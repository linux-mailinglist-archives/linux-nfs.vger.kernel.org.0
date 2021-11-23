Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA6945A97E
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 18:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbhKWRDg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Nov 2021 12:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238077AbhKWRDe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Nov 2021 12:03:34 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10199C06175B
        for <linux-nfs@vger.kernel.org>; Tue, 23 Nov 2021 09:00:25 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9C3146F29; Tue, 23 Nov 2021 12:00:24 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9C3146F29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1637686824;
        bh=UaWND8d3ZoQSU9KjxQBdtcwAgA3F71Cr7XyuqUf5nPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hU6gVonRqdhaOSvEhTNIrPGAe5YY948wWjkxDs6q5J+dbgiL1VVeo3lnaxssi0unw
         SngWu46c8cDbjfgmT0jttEe6MhI08H1d9vz0TpJpZk8ue79unZHBeuK7HGSwd+VkAJ
         v3hGhEojtjgk9DL0ahFkqqk3lz4xbuXQeEZoasHo=
Date:   Tue, 23 Nov 2021 12:00:24 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Volodymyr Khomenko <volodymyr@vastdata.com>
Cc:     linux-nfs@vger.kernel.org, Ilan Steinberg <ilan@vastdata.com>
Subject: Re: pynfs: fixed gssapi usage (RPCGSS) + GSS* tests for nfs4.0
 server test
Message-ID: <20211123170024.GF8978@fieldses.org>
References: <CANkgweusOQRSvTtCRLPmGHO3YkTkfbvdtMCwg6RPv6Q54G4EHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANkgweusOQRSvTtCRLPmGHO3YkTkfbvdtMCwg6RPv6Q54G4EHA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 18, 2021 at 12:34:16AM +0200, Volodymyr Khomenko wrote:
> Please review attached patches for gssapi-related code of nfs4.0
> server test (pynfs).
> This is a continuation of previous work to make GSS tests work
> correctly with the recent gssapi python library (using python3).
> 
> $ nfs4.0/testserver.py server.fqdn:/export gss noGSS8 --security=krb5
> ...
> Command line asked for 8 of 673 tests
> Of those: 3 Skipped, 0 Failed, 0 Warned, 5 Passed
> 
> $ nfs4.0/testserver.py server.fqdn:/export GSS8 --security=krb5
> ...
> Command line asked for 1 of 673 tests
> Of those: 0 Skipped, 0 Failed, 0 Warned, 1 Passed
> 
> $ nfs4.0/testserver.py server.fqdn:/export gss noGSS8 --security=krb5i
> ...
> Command line asked for 8 of 673 tests
> Of those: 1 Skipped, 0 Failed, 0 Warned, 7 Passed

Looks good to me, thanks!

I've been worrying about these tests for a while, it's a great relief to
have someone looking into them.....

--b.

> 
> Thanks,
> Volodymyr Khomenko.

> From fe6e9fee4bd1979e2e02d9f46d76dace90b5909c Mon Sep 17 00:00:00 2001
> From: Volodymyr Khomenko <volodymyr@vastdata.com>
> Date: Thu, 18 Nov 2021 00:06:02 +0200
> Subject: [PATCH 2/2] Fixed gss flag for nfs4.0 server test (GSS* tests)
> 
> - Fixed scope/visibility issue of caught exception 'e' for try/except
> - Added OSError exception as a valid use-case for testBadGssSeqnum (aka GSS1):
>   server may close TCP connection as a possible reaction for bad GSS seq_num
> - Fixed python3 issues for concatenating bytes + string
> 
> Signed-off-by: Volodymyr Khomenko <volodymyr@vastdata.com>
> ---
>  nfs4.0/servertests/st_gss.py | 82 ++++++++++++++++++++++--------------
>  1 file changed, 50 insertions(+), 32 deletions(-)
> 
> diff --git a/nfs4.0/servertests/st_gss.py b/nfs4.0/servertests/st_gss.py
> index e10e849..f651e57 100644
> --- a/nfs4.0/servertests/st_gss.py
> +++ b/nfs4.0/servertests/st_gss.py
> @@ -78,6 +78,8 @@ def testBadGssSeqnum(t, env):
>              res = c.compound([op.putrootfh()])
>          except timeout:
>              success = True
> +        except OSError:
> +            success = True
>          if not success:
>              t.fail("Using old gss_seq_num %i should cause dropped reply" %
>                     (orig + 1))
> @@ -106,17 +108,19 @@ def testInconsistentGssSeqnum(t, env):
>  
>      try:
>          c.security.secure_data = bad_secure_data
> +        err = None
>          try:
>              res = c.compound([op.putrootfh()])
> -            e = "operation erroneously suceeding"
> +            err = "operation erroneously suceeding"
>          except rpc.RPCAcceptError as e:
>              if e.stat == rpc.GARBAGE_ARGS:
>                  # This is correct response
>                  return
> +            err = str(e)
>          except Exception as e:
> -            pass
> +            err = str(e)
>          t.fail("Using inconsistent gss_seq_nums in header and body of message "
> -               "should return GARBAGE_ARGS, instead got %s" % e)
> +               "should return GARBAGE_ARGS, instead got %s" % err)
>      finally:
>          c.security.secure_data = orig_funct
>  
> @@ -131,21 +135,23 @@ def testBadVerfChecksum(t, env):
>      orig_funct = c.security.make_verf
>      def bad_make_verf(data):
>          # Mess up verifier
> -        return orig_funct(data + "x")
> +        return orig_funct(data + b"x")
>  
>      try:
>          c.security.make_verf = bad_make_verf
> +        err = None
>          try:
>              res = c.compound([op.putrootfh()])
> -            e = "peration erroneously suceeding"
> +            err = "peration erroneously suceeding"
>          except rpc.RPCDeniedError as e:
>              if e.stat == rpc.AUTH_ERROR and e.astat == rpc.RPCSEC_GSS_CREDPROBLEM:
> -                # This is correct response
> -                return
> +               # This is correct response
> +               return
> +            err = str(e)
>          except Exception as e:
> -            pass
> +            err = str(e)
>          t.fail("Using bad verifier checksum in header "
> -               "should return RPCSEC_GSS_CREDPROBLEM, instead got %s" % e)
> +               "should return RPCSEC_GSS_CREDPROBLEM, instead got %s" % err)
>      finally:
>          c.security.make_verf = orig_funct
>  
> @@ -164,24 +170,26 @@ def testBadDataChecksum(t, env):
>          # Mess up checksum
>          data = orig_funct(data, seqnum)
>          if data[-4]:
> -            tail = chr(0) + data[-3:]
> +            tail = b'\x00' + data[-3:]
>          else:
> -            tail = chr(1) + data[-3:]
> +            tail = b'\x01' + data[-3:]
>          return data[:-4] + tail
>  
>      try:
>          c.security.secure_data = bad_secure_data
> +        err = None
>          try:
>              res = c.compound([op.putrootfh()])
> -            e = "operation erroneously suceeding"
> +            err = "operation erroneously suceeding"
>          except rpc.RPCAcceptError as e:
>              if e.stat == rpc.GARBAGE_ARGS:
>                  # This is correct response
>                  return
> +            err = str(e)
>          except Exception as e:
> -            pass
> +            err = str(e)
>          t.fail("Using bad data checksum for body of message "
> -               "should return GARBAGE_ARGS, instead got %s" % e)
> +               "should return GARBAGE_ARGS, instead got %s" % err)
>      finally:
>          c.security.secure_data = orig_funct
>  
> @@ -211,19 +219,22 @@ def testBadVersion(t, env):
>          c.security = BadGssHeader(orig, bad_version)
>          bad_versions = [0, 2, 3, 1024]
>          for version in bad_versions:
> +            err = None
>              try:
>                  res = c.compound([op.putrootfh()])
> -                e = "operation erroneously suceeding"
> +                err = "operation erroneously suceeding"
>              except rpc.RPCDeniedError as e:
>                  if e.stat == rpc.AUTH_ERROR and e.astat == rpc.AUTH_BADCRED:
>                      # This is correct response
> -                    e = None
> +                    pass
> +                else:
> +                    err = str(e)
>              except Exception as e:
> -                pass
> -            if e is not None:
> +                err = str(e)
> +            if err is not None:
>                  t.fail("Using bad gss version number %i "
>                         "should return AUTH_BADCRED, instead got %s" %
> -                       (version, e))
> +                       (version, err))
>      finally:
>          c.security = orig
>  
> @@ -238,17 +249,18 @@ def testHighSeqNum(t, env):
>      orig_seq = c.security.gss_seq_num
>      try:
>          c.security.gss_seq_num = gss.MAXSEQ + 1
> +        err = None
>          try:
>              res = c.compound([op.putrootfh()])
> -            e = "operation erroneously suceeding"
> +            err = "operation erroneously suceeding"
>          except rpc.RPCDeniedError as e:
>              if e.stat == rpc.AUTH_ERROR and e.astat == rpc.RPCSEC_GSS_CTXPROBLEM:
>                  # This is correct response
>                  return
>          except Exception as e:
> -            pass
> +            err = str(e)
>          t.fail("Using gss_seq_num over MAXSEQ "
> -               "should return RPCSEC_GSS_CTXPROBLEM, instead got %s" % e)
> +               "should return RPCSEC_GSS_CTXPROBLEM, instead got %s" % err)
>      finally:
>          c.security.gss_seq_num = orig_seq
>  
> @@ -274,21 +286,24 @@ def testBadProcedure(t, env):
>  
>      try:
>          c.security = BadGssHeader(orig, bad_proc)
> +        err = None
>          bad_procss = [4, 5, 1024]
>          for proc in bad_procss:
>              try:
>                  res = c.compound([op.putrootfh()])
> -                e = "operation erroneously suceeding"
> +                err = "operation erroneously suceeding"
>              except rpc.RPCDeniedError as e:
>                  if e.stat == rpc.AUTH_ERROR and e.astat == rpc.AUTH_BADCRED:
>                      # This is correct response
> -                    e = None
> +                    pass
> +                else:
> +                    err = str(e)
>              except Exception as e:
> -                pass
> -            if e is not None:
> +                err = str(e)
> +            if err is not None:
>                  t.fail("Using bad gss procedure number %i "
>                         "should return AUTH_BADCRED, instead got %s" %
> -                       (proc, e))
> +                       (proc, err))
>      finally:
>          c.security = orig
>  
> @@ -316,20 +331,23 @@ def testBadService(t, env):
>  
>      try:
>          c.security = BadGssHeader(orig, bad_service)
> +        err = None
>          bad_services = [0, 4, 5, 1024]
>          for service in bad_services:
>              try:
>                  res = c.compound([op.putrootfh()])
> -                e = "operation erroneously suceeding"
> +                err = "operation erroneously suceeding"
>              except rpc.RPCDeniedError as e:
>                  if e.stat == rpc.AUTH_ERROR and e.astat == rpc.AUTH_BADCRED:
>                      # This is correct response
> -                    e = None
> +                    pass
> +                else:
> +                    err = str(e)
>              except Exception as e:
> -                pass
> -            if e is not None:
> +                err = str(e)
> +            if err is not None:
>                  t.fail("Using bad gss service number %i "
>                         "should return AUTH_BADCRED, instead got %s" %
> -                       (service, e))
> +                       (service, err))
>      finally:
>          c.security = orig
> -- 
> 2.24.1
> 

> From 3f94e9aa811cfff033a8d5438b7679ce0fa55b73 Mon Sep 17 00:00:00 2001
> From: Volodymyr Khomenko <volodymyr@vastdata.com>
> Date: Wed, 17 Nov 2021 23:58:20 +0200
> Subject: [PATCH 1/2] Fixed gssapi usage (RPCGSS) for nfs4.0 server test
> 
> gssapi library used in the code has been changed and current code is not
> compatible with API of new library version.  Fixed the code
> to work with recent gssapi (tested with 1.6.2).
> Tested with krb5, krb5i and krb5p security, like this:
> nfs4.0/testserver.py server.fqdn:/export gss noGSS8 --security=krb5
> Note - GSS8 is known to cause the problems for other tests that run after it,
> however it's safe to run it alone.
> 
> Signed-off-by: Volodymyr Khomenko <volodymyr@vastdata.com>
> ---
>  nfs4.0/lib/rpc/rpcsec/sec_auth_gss.py | 116 ++++++++++----------------
>  1 file changed, 45 insertions(+), 71 deletions(-)
> 
> diff --git a/nfs4.0/lib/rpc/rpcsec/sec_auth_gss.py b/nfs4.0/lib/rpc/rpcsec/sec_auth_gss.py
> index 1b5eb93..6577fcf 100644
> --- a/nfs4.0/lib/rpc/rpcsec/sec_auth_gss.py
> +++ b/nfs4.0/lib/rpc/rpcsec/sec_auth_gss.py
> @@ -1,8 +1,8 @@
>  from .base import SecFlavor, SecError
>  from rpc.rpc_const import RPCSEC_GSS
>  from rpc.rpc_type import opaque_auth
> -from gss_const import *
> -import gss_pack
> +from .gss_const import *
> +from . import gss_pack
>  import gss_type
>  import gssapi
>  import threading
> @@ -125,50 +125,41 @@ class SecAuthGss(SecFlavor):
>      def initialize(self, client): # Note this is not thread safe
>          """Set seq_num, init, handle, and context"""
>          self.gss_seq_num = 0
> -        d = gssapi.importName("nfs@%s" % client.remotehost)
> -        if d['major'] != gssapi.GSS_S_COMPLETE:
> -            raise SecError("gssapi.importName returned: %s" % \
> -                  show_major(d['major']))
> -        name = d['name']
> -        # We need to send NULLPROCs with token from initSecContext
> -        good_major = [gssapi.GSS_S_COMPLETE, gssapi.GSS_S_CONTINUE_NEEDED]
> +        name = gssapi.Name("nfs@%s" % client.remotehost, gssapi.NameType.hostbased_service)
> +        # We need to send NULLPROCs with token from SecurityContext
> +        good_major = [GSS_S_COMPLETE, GSS_S_CONTINUE_NEEDED]
>          self.init = 1
> -        reply_token = None
> -        reply_major = ''
> -        context = None
> +        input_token = None
> +
> +        # RFC2203 5.2.2.  Context Creation Requests
> +        # When GSS_Init_sec_context() is called, the parameters
> +        # replay_det_req_flag and sequence_req_flag must be turned off.
> +
> +        # Note - by default, out_of_sequence_detection flag (sequence_req_flag) is used by gssapi.init_sec_context()
> +        # and we have 'An expected per-message token was not received' error (GSS_S_GAP_TOKEN).
> +        # To prevent this, we need to use default flags without out_of_sequence_detection bit.
> +        flags = gssapi.IntEnumFlagSet(gssapi.RequirementFlag, [gssapi.RequirementFlag.mutual_authentication])
> +        context = gssapi.SecurityContext(name=name, flags=flags)
>          while True:
> -            d = gssapi.initSecContext(name, context, reply_token)
> -            major = d['major']
> -            context = d['context']
> -            if major not in good_major:
> -                raise SecError("gssapi.initSecContext returned: %s" % \
> -                      show_major(major))
> -            if (major == gssapi.GSS_S_CONTINUE_NEEDED) and \
> -                   (reply_major == gssapi.GSS_S_COMPLETE):
> -                raise SecError("Unexpected GSS_S_COMPLETE from server")
> -            token = d['token']
> -            if reply_major != gssapi.GSS_S_COMPLETE:
> -                # FRED - sec 5.2.2 of RFC 2203 mentions possibility that
> -                # no token is returned.  But then how get handle?
> -                p = self.getpacker()
> -                p.reset()
> -                p.pack_opaque(token)
> -                data = p.get_buffer()
> -                reply = client.call(0, data)
> -                up = self.getunpacker()
> -                up.reset(reply)
> -                res = up.unpack_rpc_gss_init_res()
> -                up.done()
> -                reply_major = res.gss_major
> -                if reply_major not in good_major:
> -                    raise SecError("Server returned: %s" % \
> -                          show_major(reply_major))
> -                self.init = 2
> -                reply_token = res.gss_token
> -            if major == gssapi.GSS_S_COMPLETE:
> -                if reply_major != gssapi.GSS_S_COMPLETE:
> -                    raise SecError("Unexpected COMPLETE from client")
> +            # note - gssapi will raise an exception here automatically in case of failure
> +            output_token = context.step(input_token)
> +            if context.complete:
>                  break
> +            p = self.getpacker()
> +            p.reset()
> +            p.pack_opaque(output_token)
> +            data = p.get_buffer()
> +            reply = client.call(0, data)
> +            up = self.getunpacker()
> +            up.reset(reply)
> +            res = up.unpack_rpc_gss_init_res()
> +            up.done()
> +            reply_major = res.gss_major
> +            if reply_major not in good_major:
> +                raise SecError("Server returned: %s" % \
> +                    show_major(reply_major))
> +            self.init = 2
> +            input_token = res.gss_token
>          self.gss_context = context
>          self.gss_handle = res.handle
>          self.init = 0
> @@ -176,7 +167,7 @@ class SecAuthGss(SecFlavor):
>      def make_cred(self):
>          """Credential sent with each RPC call"""
>          if self.init == 1: # first call in context creation
> -            cred = self._make_cred_gss('', rpc_gss_svc_none, RPCSEC_GSS_INIT)
> +            cred = self._make_cred_gss(b'', rpc_gss_svc_none, RPCSEC_GSS_INIT)
>          elif self.init > 1: # subsequent calls in context creation
>              cred = self._make_cred_gss('', rpc_gss_svc_none,
>                                    RPCSEC_GSS_CONTINUE_INIT)
> @@ -237,12 +228,8 @@ class SecAuthGss(SecFlavor):
>          if self.init:
>              return self._none
>          else:
> -            d = gssapi.getMIC(self.gss_context, data)
> -            major = d['major']
> -            if major != gssapi.GSS_S_COMPLETE:
> -                raise SecError("gssapi.getMIC returned: %s" % \
> -                      show_major(major))
> -            return opaque_auth(RPCSEC_GSS, d['token'])
> +            token = self.gss_context.get_signature(data)
> +            return opaque_auth(RPCSEC_GSS, token)
>          
>      def _make_cred_gss(self, handle, service, gss_proc=RPCSEC_GSS_DATA, seq=0):
>          data = gss_type.rpc_gss_cred_vers_1_t(gss_proc, seq, service, handle)
> @@ -264,13 +251,10 @@ class SecAuthGss(SecFlavor):
>              p.reset()
>              p.pack_uint(gss_cred.seq_num)
>              data = p.get_buffer() + data
> -            d = gssapi.getMIC(self.gss_context, data)
> -            if d['major'] != gssapi.GSS_S_COMPLETE:
> -                raise SecError("gssapi.getMIC returned: %s" % \
> -                      show_major(d['major']))
> +            token = self.gss_context.get_signature(data)
>              p.reset()
>              p.pack_opaque(data)
> -            p.pack_opaque(d['token'])
> +            p.pack_opaque(token)
>              data = p.get_buffer()
>          elif gss_cred.service == rpc_gss_svc_privacy:
>              # data = opaque[wrap([gss_seq_num+data])]
> @@ -278,12 +262,9 @@ class SecAuthGss(SecFlavor):
>              p.reset()
>              p.pack_uint(gss_cred.seq_num)
>              data = p.get_buffer() + data
> -            d = gssapi.wrap(self.gss_context, data)
> -            if d['major'] != gssapi.GSS_S_COMPLETE:
> -                raise SecError("gssapi.wrap returned: %s" % \
> -                      show_major(d['major']))
> +            wrap_data = self.gss_context.wrap(data, encrypt=True)
>              p.reset()
> -            p.pack_opaque(d['msg'])
> +            p.pack_opaque(wrap_data.message)
>              data = p.get_buffer()
>          else:
>              # Not really necessary, should have already raised XDRError
> @@ -303,10 +284,7 @@ class SecAuthGss(SecFlavor):
>              data = p.unpack_opaque()
>              checksum = p.unpack_opaque()
>              p.done()
> -            d = gssapi.verifyMIC(self.gss_context, data, checksum)
> -            if d['major'] != gssapi.GSS_S_COMPLETE:
> -                raise SecError("gssapi.verifyMIC returned: %s" % \
> -                      show_major(d['major']))
> +            qop = self.gss_context.verify_signature(data, checksum)
>              p.reset(data)
>              seqnum = p.unpack_uint()
>              if seqnum != gss_cred.seq_num:
> @@ -320,11 +298,8 @@ class SecAuthGss(SecFlavor):
>              p.reset(data)
>              data = p.unpack_opaque()
>              p.done()
> -            d = gssapi.unwrap(self.gss_context, data)
> -            if d['major'] != gssapi.GSS_S_COMPLETE:
> -                raise SecError("gssapi.unwrap returned %s" % \
> -                      show_major(d['major']))
> -            p.reset(d['msg'])
> +            data, encrypted, qop = self.gss_context.unwrap(data)
> +            p.reset(data)
>              seqnum = p.unpack_uint()
>              if seqnum != gss_cred.seq_num:
>                  raise SecError(\
> @@ -373,8 +348,7 @@ class SecAuthGss(SecFlavor):
>              p = self.getpacker()
>              p.reset()
>              p.pack_uint(cred.seq_num)
> -            d = gssapi.verifyMIC(self.gss_context, p.get_buffer(), rverf.body)
> -            #print("Verify(%i):"%cred.seq_num, show_major(d['major']), show_minor(d['minor']))
> +            qop = self.gss_context.verify_signature(p.get_buffer(), rverf.body)
>              
>          else:
>              pass
> -- 
> 2.24.1
> 

