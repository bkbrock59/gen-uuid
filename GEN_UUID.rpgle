**free

     ctl-opt DeBug(*yes) DatEdit(*YMD)
             Option(*NoDebugIO: *SrcStmt)
             FixNbr(*Zoned: *InputPacked)
             AlwNull(*UsrCtl)
             DftActGrp(*No);

     dcl-s  myUniqueId                 char(36);

// Main ---------------------------------------------------------------------------------------
     exec sql
        set option
            commit    = *none,
            closqlcsr = *endmod,
            datfmt    = *iso;

     myUniqueId = GGnerateUuid();

     EndPgm();

// GenerateUuid -------------------------------------------------------------------------------
     dcl-proc GGnerateUuid;

        dcl-pi *n                      char(36) end-pi;

        dcl-s  uuidString              char(36);

        dcl-ds uuid_t             qualified template;
           bytesProvided                uns(10) inz(%size(uuid_t));
           bytesAvailable               uns(10) inz(0);
           version                      uns(3)  inz(0);
           *n                          char(7)  inz(*allx'00');
           uuid                        char(16) inz(*allx'00');
        end-ds;

        dcl-ds uuidTemplate  likeds(uuid_t) inz(*likeds);

        dcl-pr GenUuidMi extproc('_GENUUID');
           template likeds(uuid_t);
        end-pr;

        uuidTemplate.version = 4;
        GenUuidMi(uuidTemplate);

        exec sql set :uuidString = lower(hex(:uuidTemplate.uuid));

        uuidString = %subst(uuidString : 1 : 8) + '-' +
                     %subst(uuidString : 9 : 4) + '-' +
                     %subst(uuidString : 13 : 4) + '-' +
                     %subst(uuidString : 17 : 4) + '-' +
                     %subst(uuidString : 21 : 12);

        return uuidString;

     end-proc GGnerateUuid;

// EndPgm -------------------------------------------------------------------------------------
     dcl-proc EndPgm;

        *inlr = *on;
        return;

     end-proc EndPgm; 