Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102A241E7C5
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Oct 2021 08:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352303AbhJAGvs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Oct 2021 02:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhJAGvs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Oct 2021 02:51:48 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084CDC06176A
        for <linux-nfs@vger.kernel.org>; Thu, 30 Sep 2021 23:50:04 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z24so35006550lfu.13
        for <linux-nfs@vger.kernel.org>; Thu, 30 Sep 2021 23:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rx3Q2sktlQLqP/r7U0gNwoa9GsYAJKJ02irwlASp0Lo=;
        b=MzCEhNYwJjIL5H65ttWhzWka6J8xptkhLTwIeNhJQWcLmCujQ8OLntGnE0cmlI6z9e
         WlH2dynIoGnJw5QNLM8nOXpXc/LN6Vpa9RHTraiwWF0QJzElSD8r4oElj19dbwXM3YPr
         6ipFQWS2jAkRYTvTvqMLLmvrYkai8/KVyyaSKt0friiGGTiBcYqSTdUfIydsc//DPkQH
         +zUU/smxhcjeCAgKvRqkK95K25lDJj3v6UIL6qg3Yt8OPXqiJMbRkuACDuqVznvwbxy9
         OswZiECPoEfA3AcRQe8y9DM7x5PAEizKpgNxFIAoVy47lcWb8dqeDXP/L4muvQEHVjIu
         t7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rx3Q2sktlQLqP/r7U0gNwoa9GsYAJKJ02irwlASp0Lo=;
        b=rAkHfQZQ+baqAFx6Z8zpc2c3jgVpeOE9vS6KSdUNZeNaFBWmMTdXlw++nNzWwUFkdq
         S9efSLdwmm9GVZ/TyXTe3DmYNLtQcPdEoOcpOsIdyvL6l6f+DWu4ctXFkIWEqm6jlIP2
         lIKH4Xdg2R59O5SWoXioF4h7qAKdRNv3xmhIsi27Gx91C3p3YvZ6UHIDIkRSF/87qy8e
         5REt3nTlvJh0smQWEW6DNtTAxcWrhenQDoOwZheAmmEm0vNQzF9EjbOlNVQVgfxdgd9l
         m0/RwojXWisTRuzDMsjUS3cfB3iR7yOG8mYuxccgu0wHXhr2/NLD9mO+3mKZvoTciLAc
         3xng==
X-Gm-Message-State: AOAM533/GsKq4oU1LHwWxK5lhHqHloMCLcuZ9FauZTVN383U61XM1Qk/
        Lhhwgh0Rkm24Epkx0ErNgMao90ft65YKTsNyRFBSCA==
X-Google-Smtp-Source: ABdhPJzBMhv9vQRoxQb0Ovtq7aPszbHOg7DSwY/0R8O4pBRb+UGrpbvTkSfxF3XoC+HBOUREXXIFIkwRDWVcYbAVnsM=
X-Received: by 2002:a05:651c:311:: with SMTP id a17mr10259983ljp.293.1633071002062;
 Thu, 30 Sep 2021 23:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <CANkgwetkTUjj-bMrM4XTvk0vhGiJt3wNKPpRvzgTk-u7ZfrdXg@mail.gmail.com>
 <20210930211123.GA16927@fieldses.org>
In-Reply-To: <20210930211123.GA16927@fieldses.org>
From:   Volodymyr Khomenko <volodymyr@vastdata.com>
Date:   Fri, 1 Oct 2021 09:49:50 +0300
Message-ID: <CANkgweuuo7VctNLNSGyVE2Unjv_RMdG7+zPYr6_QwSZAQTbPRQ@mail.gmail.com>
Subject: Re: GSSAPI fix for pynfs nfs4.1 client code
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> So, I can verify that --security=krb5 works after this patch but not
> before, good.  But why is that?  As you say, the server is supposed to
> ignore the sequence number on context creation requests.  And 0 is valid
> sequence number as far as I know.

By design of RPCGSS we have a 'last seen seq_number' counter on the
server side per each GSS context
and we must not accept any packet that was already seen before (we
also have a bitmask of several last requests for this).
This 'last seen counter' is unsigned int32 (the same as seq_num) so we
can't just init it to -1 so next seq_num=0 will be valid.
The most obvious implementation is to init it last_seen_seq_num to 0
so the very 1st packet after NFS4 NULL must be 1 to differ from last
seen seq_number.

A better implementation (theoretically) can set this counter to
'undefined' state by additional flag, but this is  more
resource-consuming
(you need to process is_inited flag + last_seen_seq_num instead of
just one counter).
If the last seen seq_number is undefined during GSS initialization,
then strictly speaking we can send ANY seq_num for the very 1st
request after NFS4 NULL.

volodymyr.

On Fri, Oct 1, 2021 at 12:11 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Thu, Sep 30, 2021 at 06:22:09PM +0300, Volodymyr Khomenko wrote:
> > commit b77dc49c775756f08bdd0c6ebbe67a96f0ffe41f
> > Author: Volodymyr Khomenko <volodymyr@vastdata.com>
> > Date:   Thu Sep 30 17:53:04 2021 +0300
> >
> >     Fixed GSSContext to start sequence numbering from 1
> >
> >     GSS sequence number 0 is usually used by NFS4 NULL request
> >     during GSS context establishment (but ignored by server).
> >     Client should never reuse GSS sequence number, so using
> >     0 for the next real operation (EXCHANGE_ID) is possible but
> >     looks suspicious. Fixed the code so numbering for operations
> >     is done from 1 to avoid confusion.
>
> So, I can verify that --security=krb5 works after this patch but not
> before, good.  But why is that?  As you say, the server is supposed to
> ignore the sequence number on context creation requests.  And 0 is valid
> sequence number as far as I know.
>
> --b.
>
> >
> >     Signed-off-by: Volodymyr Khomenko <volodymyr@vastdata.com>
> >
> > diff --git a/rpc/security.py b/rpc/security.py
> > index 0682f43..86f6592 100644
> > --- a/rpc/security.py
> > +++ b/rpc/security.py
> > @@ -174,7 +174,9 @@ class GSSContext(object):
> >      def __init__(self, context_ptr):
> >          self.lock = threading.Lock()
> >          self.ptr = context_ptr
> > -        self.seqid = 0 # client - next seqid to use
> > +        # Note - seqid=0 is usually used during GSS context establishment,
> > +        # to have the unique number we need to use the next value now.
> > +        self.seqid = 1 # client - next seqid to use
> >          self.highest = 0 # server - highest seqid seen
> >          self.seen = 0 # server - bitmask of seen requests
> >
>
> > commit a612cf9897f0fa5b5de94885e00ef9293e93ffa3
> > Author: Volodymyr Khomenko <volodymyr@vastdata.com>
> > Date:   Thu Sep 30 16:29:07 2021 +0300
> >
> >     Fixed gssapi usage (RPCGSS) for nfs4.1 client
> >
> >     gssapi library used in the code has been changed and
> >     current code is not compatible with API of new library version.
> >     Fixed the code to work with recent gssapi (tested with 1.6.2).
> >     Tested with krb5, krb5i and krb5p security:
> >     ./nfs4.1/testserver.py server.fqdn:/export --maketree --security=krb5 all
> >
> >     Signed-off-by: Volodymyr Khomenko <volodymyr@vastdata.com>
> >
> > diff --git a/rpc/security.py b/rpc/security.py
> > index fe4390c..0682f43 100644
> > --- a/rpc/security.py
> > +++ b/rpc/security.py
> > @@ -10,6 +10,7 @@ from . import gss_type
> >  from .gss_type import rpc_gss_init_res
> >  try:
> >      import gssapi
> > +    from gssapi.raw.misc import GSSError
> >  except ImportError:
> >      print("Could not find gssapi module, proceeding without")
> >      gssapi = None
> > @@ -242,11 +243,11 @@ class AuthGss(AuthNone):
> >
> >      def init_cred(self, call, target="nfs@jupiter", source=None, oid=None):
> >          # STUB - need intelligent way to set defaults
> > -        good_major = [gssapi.GSS_S_COMPLETE, gssapi.GSS_S_CONTINUE_NEEDED]
> > +        good_major = [GSS_S_COMPLETE, GSS_S_CONTINUE_NEEDED]
> >          p = Packer()
> >          up = GSSUnpacker('')
> >          # Set target (of form nfs@SERVER)
> > -        target = gssapi.Name(target, gssapi.NT_HOSTBASED_SERVICE)
> > +        target = gssapi.Name(target, gssapi.NameType.hostbased_service)
> >          # Set source (of form USERNAME)
> >          if source is not None:
> >              source = gssapi.Name(source, gssapi.NT_USER_NAME)
> > @@ -254,18 +255,26 @@ class AuthGss(AuthNone):
> >          else:
> >              # Just use default cred
> >              gss_cred = None
> > -        context = gssapi.Context()
> > -        token = None
> > -        handle = ''
> > +        # RFC2203 5.2.2.  Context Creation Requests
> > +        # When GSS_Init_sec_context() is called, the parameters
> > +        # replay_det_req_flag and sequence_req_flag must be turned off.
> > +
> > +        # Note - by default, out_of_sequence_detection flag (sequence_req_flag) is used by gssapi.init_sec_context()
> > +        # and we have 'An expected per-message token was not received' error (GSS_S_GAP_TOKEN).
> > +        # To prevent this, we need to use default flags without out_of_sequence_detection bit.
> > +        flags = gssapi.IntEnumFlagSet(gssapi.RequirementFlag, [gssapi.RequirementFlag.mutual_authentication])
> > +        context = gssapi.SecurityContext(name=target, creds=gss_cred, flags=flags)
> > +        input_token = None
> > +        handle = b''
> >          proc = RPCSEC_GSS_INIT
> > -        while True:
> > +        while not context.complete:
> >              # Call initSecContext.  If it returns COMPLETE, we are done.
> >              # If it returns CONTINUE_NEEDED, we must send d['token']
> >              # to the target, which will run it through acceptSecContext,
> >              # and give us back a token we need to send through initSecContext.
> >              # Repeat as necessary.
> > -            token = context.init(target, token, gss_cred)
> > -            if context.open:
> > +            output_token = context.step(input_token)
> > +            if context.complete:
> >                  # XXX if res.major == CONTINUE there is a bug in library code
> >                  # STUB - now what? Just use context?
> >                  # XXX need to use res.seq_window
> > @@ -277,16 +286,16 @@ class AuthGss(AuthNone):
> >                                  gss_proc=proc)
> >              proc = RPCSEC_GSS_CONTINUE_INIT
> >              p.reset()
> > -            p.pack_opaque(token)
> > +            p.pack_opaque(output_token)
> >              header, reply = call(p.get_buffer(), credinfo)
> >              up.reset(reply)
> >              res = up.unpack_rpc_gss_init_res()
> >              up.done()
> >              # res now holds relevent output from target's acceptSecContext call
> >              if res.gss_major not in good_major:
> > -                raise gssapi.Error(res.gss_major, res.gss_minor)
> > +                raise GSSError(res.gss_major, res.gss_minor)
> >              handle = res.handle # Should not change between calls
> > -            token = res.gss_token # This needs to be sent to initSecContext
> > +            input_token = res.gss_token # This needs to be sent to SecurityContext.step()
> >          return CredInfo(self, context=handle)
> >
> >      @staticmethod
> > @@ -361,7 +370,7 @@ class AuthGss(AuthNone):
> >                  except:
> >                      log_gss.exception("unsecure_data - initial unpacking")
> >                      raise rpclib.RPCUnsuccessfulReply(GARBAGE_ARGS)
> > -                qop = context.verifyMIC(data, checksum)
> > +                qop = context.verify_signature(data, checksum)
> >                  check_gssapi(qop)
> >                  data = pull_seqnum(data)
> >              elif cred.service == rpc_gss_svc_privacy:
> > @@ -373,14 +382,14 @@ class AuthGss(AuthNone):
> >                      log_gss.exception("unsecure_data - initial unpacking")
> >                      raise rpclib.RPCUnsuccessfulReply(GARBAGE_ARGS)
> >                  # data, qop, conf = context.unwrap(data)
> > -                data, qop = context.unwrap(data)
> > +                data, encrypted, qop = context.unwrap(data)
> >                  check_gssapi(qop)
> >                  data = pull_seqnum(data)
> >              else:
> >                  # Can't get here, but doesn't hurt
> >                  log_gss.error("Unknown service %i for RPCSEC_GSS" % cred.service)
> > -        except gssapi.Error as e:
> > -            log_gss.warn("unsecure_data: gssapi call returned %s" % e.name)
> > +        except GSSError as e:
> > +            log_gss.warn("unsecure_data: gssapi call returned %s" % str(e))
> >              raise rpclib.RPCUnsuccessfulReply(GARBAGE_ARGS)
> >          return data
> >
> > @@ -397,7 +406,7 @@ class AuthGss(AuthNone):
> >                  # data = opaque[gss_seq_num+data] + opaque[checksum]
> >                  p.pack_uint(cred.seq_num)
> >                  data = p.get_buffer() + data
> > -                token = context.getMIC(data) # XXX BUG set qop
> > +                token = context.get_signature(data) # XXX BUG set qop
> >                  p.reset()
> >                  p.pack_opaque(data)
> >                  p.pack_opaque(token)
> > @@ -406,16 +415,16 @@ class AuthGss(AuthNone):
> >                  # data = opaque[wrap([gss_seq_num+data])]
> >                  p.pack_uint(cred.seq_num)
> >                  data = p.get_buffer() + data
> > -                token = context.wrap(data) # XXX BUG set qop
> > +                wrap_res = context.wrap(data, encrypt=True) # XXX BUG set qop
> >                  p.reset()
> > -                p.pack_opaque(token)
> > +                p.pack_opaque(wrap_res.message)
> >                  data = p.get_buffer()
> >              else:
> >                  # Can't get here, but doesn't hurt
> >                  log_gss.error("Unknown service %i for RPCSEC_GSS" % cred.service)
> > -        except gssapi.Error as e:
> > +        except GSSError as e:
> >              # XXX What now?
> > -            log_gss.warn("secure_data: gssapi call returned %s" % e.name)
> > +            log_gss.warn("secure_data: gssapi call returned %s" % str(e))
> >              raise
> >          return data
> >
> > @@ -436,8 +445,8 @@ class AuthGss(AuthNone):
> >              return rpclib.NULL_CRED
> >          else:
> >              data = self.partially_packed_header(xid, body)
> > -            # XXX how handle gssapi.Error?
> > -            token = self._get_context(body.cred.body.handle).getMIC(data)
> > +            # XXX how handle GSSError?
> > +            token = self._get_context(body.cred.body.handle).get_signature(data)
> >              return opaque_auth(RPCSEC_GSS, token)
> >
> >      def check_call_verf(self, xid, body):
> > @@ -448,10 +457,10 @@ class AuthGss(AuthNone):
> >                  return False
> >              data = self.partially_packed_header(xid, body)
> >              try:
> > -                qop = self._get_context(body.cred.body.handle).verifyMIC(data, body.verf.body)
> > -            except gssapi.Error as e:
> > +                qop = self._get_context(body.cred.body.handle).verify_signature(data, body.verf.body)
> > +            except GSSError as e:
> >                  log_gss.warn("Verifier checksum failed verification with %s" %
> > -                             e.name)
> > +                             str(e))
> >                  return False
> >              body.cred.body.qop = qop # XXX Where store this?
> >              log_gss.debug("verifier checks out (qop=%i)" % qop)
> > @@ -522,10 +531,10 @@ class AuthGss(AuthNone):
> >              context = self._get_context(cred.body.handle)
> >          try:
> >              token = context.accept(token)
> > -        except gssapi.Error as e:
> > +        except GSSError as e:
> >              log_gss.debug("RPCSEC_GSS_INIT failed (%s, %i)!" %
> > -                          (e.name, e.minor))
> > -            res = rpc_gss_init_res('', e.major, e.minor, 0, '')
> > +                          (str(e), e.min_code))
> > +            res = rpc_gss_init_res('', e.maj_code, e.min_code, 0, '')
> >          else:
> >              log_gss.debug("RPCSEC_GSS_*INIT succeeded!")
> >              if first:
> > @@ -538,9 +547,9 @@ class AuthGss(AuthNone):
> >              else:
> >                  handle = cred.body.handle
> >              if context.open:
> > -                major = gssapi.GSS_S_COMPLETE
> > +                major = GSS_S_COMPLETE
> >              else:
> > -                major = gssapi.GSS_S_CONTINUE_NEEDED
> > +                major = GSS_S_CONTINUE_NEEDED
> >              res = rpc_gss_init_res(handle, major, 0, # XXX can't see minor
> >                                     WINDOWSIZE, token)
> >          # Prepare response
> > @@ -559,15 +568,15 @@ class AuthGss(AuthNone):
> >              # NOTE this relies on GSS_S_COMPLETE == rpc.SUCCESS == 0
> >              return rpclib.NULL_CRED
> >          elif cred.gss_proc in (RPCSEC_GSS_INIT, RPCSEC_GSS_CONTINUE_INIT):
> > -            # init requires getMIC(seq_window)
> > +            # init requires get_signature(seq_window)
> >              i = WINDOWSIZE
> >          else:
> > -            # Else return getMIC(cred.seq_num)
> > +            # Else return get_signature(cred.seq_num)
> >              i = cred.seq_num
> >          p = Packer()
> >          p.pack_uint(i)
> >          # XXX BUG - need to set qop
> > -        token = self._get_context(cred.handle).getMIC(p.get_buffer())
> > +        token = self._get_context(cred.handle).get_signature(p.get_buffer())
> >          return opaque_auth(RPCSEC_GSS, token)
> >
> >      def check_reply_verf(self, msg, call_cred, data):
> > @@ -593,12 +602,12 @@ class AuthGss(AuthNone):
> >                  if res.gss_major != GSS_S_COMPLETE:
> >                      raise SecError("Expected NULL")
> >                  # BUG - context establishment is not finished on client
> > -                # - so how get context?  How run verifyMIC?
> > +                # - so how get context?  How run verify_signature?
> >                  # - This seems to be a protocol problem.  Just ignore for now
> >          else:
> >              p = Packer()
> >              p.pack_uint(call_cred.body.seq_num)
> > -            qop = call_cred.context.verifyMIC(p.get_buffer(), verf.body)
> > +            qop = call_cred.context.verify_signature(p.get_buffer(), verf.body)
> >              if qop != call_cred.body.qop:
> >                  raise SecError("Mismatched qop")
> >
>
