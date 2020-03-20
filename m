Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D533D18D868
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2020 20:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgCTT2q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Mar 2020 15:28:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56226 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgCTT2q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Mar 2020 15:28:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id 6so7780222wmi.5
        for <linux-nfs@vger.kernel.org>; Fri, 20 Mar 2020 12:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cd553LbZB0DvpPlQFPMObKK2FaE/IUZ9X7HCNyzkgfE=;
        b=VcMKG/z3nApHojuKDwfZFrhpgsuaAq/T7ZYr+YHo3AA5MGUQ9S1HNzNFU2na02f/sl
         7q8pOqXVJp4uW11TxvmSHRt7McrUv/4F4OaKsQUTNICSfBgv96S7YECSSTwkjfnRlsRK
         eOzmljYPWLitCQ9MeuZpvnxNm6+pmA8KzSKXrJX3/BaHhXvrFGh/zN433boDKxYqnsOG
         kQ6ykjyB2gMtCWkdf3luMl6ju91Y19iX6tRwiIc7fWv+wj8pXgDzNxFyy3lGkH8/R/ZK
         fgqrKsHf/wVwIVdxadO3508q7s2ILYXFK85c8hWknS6hAGTyMZPXWrM3oXpxe0PPD543
         gAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cd553LbZB0DvpPlQFPMObKK2FaE/IUZ9X7HCNyzkgfE=;
        b=E/Afhdl8IF6CtOoz8PuBHWvQzjpktvpyo1+uCkl3yt7ByndhECtmy3Nt/s64i34Bm8
         dRe/9Efvvk6n3RYAbtXJ4ngEhMUwZeFyQ9GvkzMlMHw4ICSDZx085YR7JeWTWigo2b2S
         avJh4jat3Qc0MXtrDxdqY+oxM9cJxL3DUvwd9QpItsCtAHRDRIgE9e3G36X1XYNuKOaI
         jyt52aYcjwH1PF7VpVarNdQJNolxi1P+7rcWKy5lw1w90JTvqTW4IAFY4WSbrqEETqsU
         rqq+hMxL4HGnXWlDB5spZVqFYi3l71SYgzcxq+tr7SxUclBPfn0qf1YKG07Lscyn0b3Z
         AlKA==
X-Gm-Message-State: ANhLgQ1Pcq8Zyq5TW8xYcudiEABeICZ0IJpjg/QMnzeXmcGZ1Vb9bVJn
        5QxJrXfn+dKt6Pr7A5zvZUrrc++dqeAyOW/57Wu8qvnv
X-Google-Smtp-Source: ADFU+vtb23CGXBmHwcks8TEWZFu0d5PcVX+xbTkSOzmp99w0plZMJS/vV+Nm8s7JTVyrh9QpNidj+80k4NeayWQitJ8=
X-Received: by 2002:a1c:2c8a:: with SMTP id s132mr11862706wms.22.1584732521553;
 Fri, 20 Mar 2020 12:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyHegg96s7mr1YeoPbVd0UA7_cd2GEPYNWx98uUcx-0ARw@mail.gmail.com>
 <FF0659E0-8F04-4005-96D0-5D513881EDFE@oracle.com> <CAN-5tyHQpS7AmPX1cDxKpD=5gyAM7+nmLX+iA29QV7sLwhoX9Q@mail.gmail.com>
 <EE167593-39A6-4E29-B690-31D1D985DCC0@oracle.com> <CAN-5tyHjrNcSc+h62dBiYhNmLxWcR1Pj7fLJOnSfgR6JDZbEAA@mail.gmail.com>
 <E8169251-A626-4FD6-9A62-42C218AB79DF@oracle.com>
In-Reply-To: <E8169251-A626-4FD6-9A62-42C218AB79DF@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 20 Mar 2020 15:28:30 -0400
Message-ID: <CAN-5tyGvi_KBZHr0YKqhtyB5CNAtKk77+c0dkmb=u=4FCD7daw@mail.gmail.com>
Subject: Re: [RFC PATCH] fix krb5p mount not providing large enough buffer in rq_rcvsize
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 12, 2020 at 4:10 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Mar 12, 2020, at 3:17 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > On Tue, Mar 10, 2020 at 7:56 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>
> >>
> >>
> >>> On Mar 10, 2020, at 5:07 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >>>
> >>> Hi Chuck,
> >>>
> >>> On Tue, Mar 10, 2020 at 3:57 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>>>
> >>>> Hi Olga-
> >>>>
> >>>>> On Mar 10, 2020, at 2:58 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >>>>>
> >>>>> Ever since commit 2c94b8eca1a26 "SUNRPC: Use au_rslack when computing
> >>>>> reply buffer size". It changed how "req->rq_rcvsize" is calculated. It
> >>>>> used to use au_cslack value which was nice and large and changed it to
> >>>>> au_rslack value which turns out to be too small.
> >>>>>
> >>>>> Since 5.1, v3 mount with sec=krb5p fails against an Ontap server
> >>>>> because client's receive buffer it too small.
> >>>>
> >>>> Can you be more specific? For instance, why is 100 bytes adequate for
> >>>> Linux servers, but not OnTAP?
> >>>
> >>> I don't know why Ontap sends more data than Linux server.
> >>
> >> Let's be sure we are fixing the right problem. Yes, au_rslack is
> >> smaller in v5.1, and that results in a behavioral regression. But
> >> exactly which part of the new calculation is incorrect is not yet
> >> clear. Simply bumping GSS_VERF_SLACK could very well plaster over
> >> the real problem.
> >>
> >>
> >>> The opaque_len is just a lot larger. For the first message Linux
> >>> opaque_len is 120bytes and Ontap it's 206. So it could be for instance
> >>> for FSINFO that sends the file handle, for Netapp the file handle is
> >>> 44bytes and for Linux it's only 28bytes.
> >>
> >> The maximum filehandle size should already be accounted for in the
> >> maxsize macro for FSINFO.
> >>
> >> Is this problem evident only with NFSv3 plus krb5p?
> >
> > So far that seems to be the case. Every other version and security flavor works.
> >
> >>>> Is this explanation for the current value not correct?
> >>>>
> >>>> 51 /* length of a krb5 verifier (48), plus data added before arguments when
> >>>> 52  * using integrity (two 4-byte integers): */
> >>>
> >>> I'm not sure what it is suppose to be. Isn't "data before arguments"
> >>> can vary in length and thus explain why linux and onto sizes are
> >>> different?
> >>> Looking at the network trace the krb5 verifier I see is 36bytes.
> >>
> >> GSS_VERF_SLACK is only for the extra length added by GSS data. The
> >> length of the RPC message itself is handled separately, see above.
> >>
> >> Can you post a Wireshark dissection of the problematic FSINFO reply?
> >> (Having a working reply from Linux and a failing reply from OnTAP
> >> would be even better).
> >
> > I'm attaching two files. I mount against linux and mount against ontap.
> >
> >
> >
> >
> >>>>> For GSS, au_rslack is calculated from GSS_VERF_SLACK value which is
> >>>>> currently 100. And it's not enough. Changing it to 104 works and then
> >>>>> au_rslack is recalculated based on actual received mic.len and not
> >>>>> just the default buffer size.
> >>
> >> What are the computed au_ralign and au_rslack values after the first
> >> successful operation?
> >
> > With GSS_VERF_SLACK 100
> > Linux run:
> >
> > Mar 12 13:14:29 localhost kernel: AGLO: gss_create_new setting for
> > auth=00000000e14fdc39 cslack=200 and rslack=25
> > Mar 12 13:14:29 localhost kernel: AGLO: gss_create_new setting for
> > auth=00000000e14fdc39 ralign=25
> > Mar 12 13:14:29 localhost kernel: NFS call  fsinfo
> > ... <gssd upcall>
> > Mar 12 13:14:29 localhost kernel: AGLO: call_allocate
> > auth=00000000e14fdc39 au_cslack=200 au_rslack=25 rq_rcvsize=256
> > p_replen=35
> > Mar 12 13:14:29 localhost kernel: AGLO: gss_unwrap_resp_priv rcv_buf
> > len=176 is ok offset=56 opaque=120
> > Mar 12 13:14:29 localhost kernel: AGLO: gss_unwrap_resp_priv ****
> > auth=00000000e14fdc39 resetting au_rslack=26
> > Mar 12 13:14:29 localhost kernel: AGLO: gss_unwrap_resp_priv ****
> > auth=00000000e14fdc39 resetting au_ralign=26
> > Mar 12 13:14:29 localhost kernel: NFS reply fsinfo: 0
> >
> > Ontap run:
> > Mar 12 13:16:46 localhost kernel: AGLO: gss_create_new setting for
> > auth=00000000e02d9e6e cslack=200 and rslack=25
> > Mar 12 13:16:46 localhost kernel: AGLO: gss_create_new setting for
> > auth=00000000e02d9e6e ralign=25
> > Mar 12 13:16:46 localhost kernel: NFS call  fsinfo
> > ... <gssd upcall>
> > Mar 12 13:16:46 localhost kernel: AGLO: call_allocate
> > auth=00000000e02d9e6e au_cslack=200 au_rslack=25 rq_rcvsize=256
> > p_replen=35
> > Mar 12 13:16:46 localhost kernel: AGLO: gss_unwrap_resp_priv rcv_buf
> > len=256 too small offset=56 opaque=204
> > Mar 12 13:16:46 localhost kernel: NFS reply fsinfo: -5
> >
> > With GSS_VERF_SLACK 104
> > Mar 12 13:33:23 localhost kernel: AGLO: gss_create_new setting for
> > auth=000000004a545ea2 cslack=200 and rslack=26
> > Mar 12 13:33:23 localhost kernel: AGLO: gss_create_new setting for
> > auth=000000004a545ea2 ralign=26
> > Mar 12 13:33:23 localhost kernel: NFS call  fsinfo
> > ... <gssd upcall>
> > Mar 12 13:33:23 localhost kernel: AGLO: call_allocate
> > auth=000000004a545ea2 au_cslack=200 au_rslack=26 rq_rcvsize=260
> > p_replen=35
> > Mar 12 13:33:23 localhost kernel: AGLO: gss_unwrap_resp_priv rcv_buf
> > len=260 is ok offset=56 opaque=204
> > Mar 12 13:33:23 localhost kernel: AGLO: gss_unwrap_resp_priv ****
> > auth=000000004a545ea2 resetting au_rslack=26
> > Mar 12 13:33:23 localhost kernel: AGLO: gss_unwrap_resp_priv ****
> > auth=000000004a545ea2 resetting au_ralign=26
> > Mar 12 13:33:23 localhost kernel: NFS reply fsinfo: 0
> >
> > difference in actual packets in fsinfo is that ontap sends postattrs
> > so that's 84bytes.
> >
> >        req->rq_rcvsize = RPC_REPHDRSIZE + auth->au_rslack + \
> >                        max_t(size_t, proc->p_replen, 2);
> >
> > RPC_REPHDRSIZE is defined to be 4 (*4)  (it says it doesn't include
> > the verifier ???)
>
> > rslack needs to cover kerberos blob 25 (*4)  (but that's the kerberos
> > part a part of the wrap and not the verifier)
> > p_replen to cover fs_info args 35 (*4) (seems like the right number)
> >
> > So we are missing the GSS to include the verifier and the kerberos
> > blob of the wrapper (and lengths!!). Basically we need GSS_VERF_SLACK
> > to cover 2 kerberos blobs (or more specifically KRB_TOKEN_CFX_GetMic
> > 9*4 and KRB_TOKEN_CFS_WRAP 15*4 + 2 lengths before the kerberos blobs
> > = 104 and we are only giving 100).
>
> GSS_VERF_SLACK is also used for setting au_verfsize, so please don't
> change its value. Define a new constant for initializing au_rslack.
>
> Let's construct that constant using the KRB5_TOKEN constants you mention
> here... include/linux/sunrpc/gss_krb5.h has
>
> 221 /*
> 222  * This compile-time check verifies that we will not exceed the
> 223  * slack space allotted by the client and server auth_gss code
> 224  * before they call gss_wrap().
> 225  */
> 226 #define GSS_KRB5_MAX_SLACK_NEEDED \
> 227         (GSS_KRB5_TOK_HDR_LEN     /* gss token header */         \
> 228         + GSS_KRB5_MAX_CKSUM_LEN  /* gss token checksum */       \
> 229         + GSS_KRB5_MAX_BLOCKSIZE  /* confounder */               \
> 230         + GSS_KRB5_MAX_BLOCKSIZE  /* possible padding */         \
> 231         + GSS_KRB5_TOK_HDR_LEN    /* encrypted hdr in v2 token */\
> 232         + GSS_KRB5_MAX_CKSUM_LEN  /* encryption hmac */          \
> 233         + 4 + 4                   /* RPC verifier */             \
> 234         + GSS_KRB5_TOK_HDR_LEN                                   \
> 235         + GSS_KRB5_MAX_CKSUM_LEN)
>
> So this, or something like this, plus the comment below.
>

I'm not sure this particular structure can we re-used as it computes
something different (as it can be seen below what RFC structures are
for mic and wrap cksums).

I have 2 ways this can be solved. A simple patch that eliminates
quartering the rslack of the GSS_VERF_SLACK that produces too small of
a buffer. GSS_VERF_SLACK value in itself is a good approximation of
what Kerberos needs.

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 24ca861..e3b6ea2 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1050,7 +1050,7 @@ static void gss_pipe_free(struct gss_pipe *p)
                goto err_put_mech;
        auth = &gss_auth->rpc_auth;
        auth->au_cslack = GSS_CRED_SLACK >> 2;
-       auth->au_rslack = GSS_VERF_SLACK >> 2;
+       auth->au_rslack = GSS_VERF_SLACK;
        auth->au_verfsize = GSS_VERF_SLACK >> 2;
        auth->au_ralign = GSS_VERF_SLACK >> 2;
        auth->au_flags = 0;


Or I can introduce a new variable but I'm having a hard time figuring
out what are the appropriate values for the checksums (I've added what
I'm getting on the wire):
diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index c1d77dd..9ef77eb 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -234,6 +234,26 @@ enum seal_alg {
        + GSS_KRB5_TOK_HDR_LEN                                   \
        + GSS_KRB5_MAX_CKSUM_LEN)

+/* to decode a GSS wrap reply the RPC code allocates buffer size based
+ * on GSS_KRB5 tokens (mic, wrap) and the max operation reply size
+ * provide MIC and WRAP token sizes in bytes
+ */
+#define GSS_KRB5_TOKEN_GETMIC \
+       (2 /*KRB5_TOKEN_ID*/ \
+       + 1 /*KRB5_CTX_FLAGS*/ \
+       + 5 /*KRB5_MIC_FILLER*/ \
+       + 8 /*KRB5_CTX_SEQ*/ \
+       + 12 /*KRB5_MIC_CKSUM_LEN*/)
+
+#define GSS_KRB5_TOKEN_WRAP \
+       (2 /*KRB5_TOKEN_ID*/ \
+       + 1 /*KRB5_CTX_FLAGS*/ \
+       + 1 /*KRB5_WRAP_FILLER*/ \
+       + 2 /*KRB5_CTX_EC*/ \
+       + 2 /*KRB5_CTX_RRC*/ \
+       + 8 /*KRB5_CTX_SEQ*/ \
+       + 44 /*KRB5_WRAP_CKSUM_LEN */)
+
 u32
 make_checksum(struct krb5_ctx *kctx, char *header, int hdrlen,
                struct xdr_buf *body, int body_offset, u8 *cksumkey,
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 24ca861..d6a52dc 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -25,6 +25,7 @@
 #include <linux/workqueue.h>
 #include <linux/sunrpc/rpc_pipe_fs.h>
 #include <linux/sunrpc/gss_api.h>
+#include <linux/sunrpc/gss_krb5.h>
 #include <linux/uaccess.h>
 #include <linux/hashtable.h>

@@ -52,6 +53,12 @@
  * using integrity (two 4-byte integers): */
 #define GSS_VERF_SLACK         100

+#define GSS_RAU_SLACK \
+(4 /* GSS verf token length */ \
++ GSS_KRB5_TOKEN_GETMIC /* verifier's getmic */ \
++ 4 /* GSS warp token length */ \
++ GSS_KRB5_TOKEN_WRAP) /* wrap verifier */ \
+
 static DEFINE_HASHTABLE(gss_auth_hash_table, 4);
 static DEFINE_SPINLOCK(gss_auth_hash_lock);

@@ -1050,7 +1057,7 @@ static void gss_pipe_free(struct gss_pipe *p)
                goto err_put_mech;
        auth = &gss_auth->rpc_auth;
        auth->au_cslack = GSS_CRED_SLACK >> 2;
-       auth->au_rslack = GSS_VERF_SLACK >> 2;
+       auth->au_rslack = GSS_RAU_SLACK;
        auth->au_verfsize = GSS_VERF_SLACK >> 2;
        auth->au_ralign = GSS_VERF_SLACK >> 2;
        auth->au_flags = 0;


Here's the KRB5 RFC structure for MIC:

 Octet no   Name        Description
         --------------------------------------------------------------
         0..1     TOK_ID     Identification field.  Tokens emitted by
                             GSS_GetMIC() contain the hex value 04 04
                             expressed in big-endian order in this
                             field.
         2        Flags      Attributes field, as described in section
                             4.2.2.
         3..7     Filler     Contains five octets of hex value FF.
         8..15    SND_SEQ    Sequence number field in clear text,
                             expressed in big-endian order.
         16..last SGN_CKSUM  Checksum of the "to-be-signed" data and
                             octet 0..15, as described in section 4.2.4.

for wrap:

Octet no   Name        Description
         --------------------------------------------------------------
          0..1     TOK_ID    Identification field.  Tokens emitted by
                             GSS_Wrap() contain the hex value 05 04
                             expressed in big-endian order in this
                             field.
          2        Flags     Attributes field, as described in section
                             4.2.2.
          3        Filler    Contains the hex value FF.
          4..5     EC        Contains the "extra count" field, in big-
                             endian order as described in section 4.2.3.
          6..7     RRC       Contains the "right rotation count" in big-
                             endian order, as described in section
                             4.2.5.
          8..15    SND_SEQ   Sequence number field in clear text,
                             expressed in big-endian order.
          16..last Data      Encrypted data for Wrap tokens with
                             confidentiality, or plaintext data followed
                             by the checksum for Wrap tokens without
                             confidentiality, as described in section
                             4.2.4.

Variable parts are cksum lengths based on the encryption used.

Current code has GSS_KRB5_MAX_CKSUM_LEN to be 20 (bytes?. Is that for
hmac signature) in WRAP cksum sent is 44bytes.

Looking for guidance here.

Thank you.

> > The reason things work against linux is because it has a nice buffer
> > of 84bytes of post attributes that it doesn't send.
>
> Missing post-attributes makes sense. Thank you for the analysis.
>
>
> > To address your later point that kerberos blob is encryption type
> > depended and that once some other encryption is added to gss-kerberos
> > that's larger than existing checksum then this value would need to be
> > adjusted again.
>
> > If you agree with my reasoning for the number then I'd like to send
> > out a patch now.
>
> The current numbers are based on the kernel GSS implementation supporting
> only Kerberos with a narrow set of enctypes. That needs to be made clear
> in a documenting comment.
>
> The reason this has been bothersome is because the existing setting is
> a magic number (100), and its documenting comment has been stale since
> 2006. Any proposed fix has to address the missing documentation.
>
>
> >>>>> I would like to propose to change it to something a little larger than
> >>>>> 104, like 120 to give room if some other server might reply with
> >>>>> something even larger.
> >>>>
> >>>> Why does it need to be larger than 104?
> >>>
> >>> I don't know why 100 was chosen and given that I think arguments are
> >>> taken into the account and arguments can change. I think NetApp has
> >>> changed their file handle sizes (at some point, not in the near past
> >>> but i think so?). Perhaps they might want to do that again so the size
> >>> will change again.
> >>>
> >>> Honestly, I would have like for 100 to be 200 to be safe.
> >>
> >> To be safe, I would like to have a good understanding of the details,
> >> rather than guessing at an arbitrary maximum value. Let's choose a
> >> rational maximum and include a descriptive comment about why that value
> >> is the best choice.
> >>
> >>
> >>>>> Thoughts? Will send an actual patch if no objections to this one.
> >>>>>
> >>>>> diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
> >>>>> index 24ca861..44ae6bc 100644
> >>>>> --- a/net/sunrpc/auth_gss/auth_gss.c
> >>>>> +++ b/net/sunrpc/auth_gss/auth_gss.c
> >>>>> @@ -50,7 +50,7 @@
> >>>>> #define GSS_CRED_SLACK         (RPC_MAX_AUTH_SIZE * 2)
> >>>>> /* length of a krb5 verifier (48), plus data added before arguments when
> >>>>> * using integrity (two 4-byte integers): */
> >>>>> -#define GSS_VERF_SLACK         100
> >>>>> +#define GSS_VERF_SLACK         120
> >>>>>
> >>>>> static DEFINE_HASHTABLE(gss_auth_hash_table, 4);
> >>>>> static DEFINE_SPINLOCK(gss_auth_hash_lock);
> >>>>
> >>>> --
> >>>> Chuck Lever
> >>
> >> --
> >> Chuck Lever
> >>
> >>
> >>
> > <linux-v3-krb5p-mount.pcap.gz><ontap-v3-krb5-mount.pcap.gz>
>
> --
> Chuck Lever
>
>
>
