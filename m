Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B781E193E8A
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 13:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgCZME3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Mar 2020 08:04:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36988 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbgCZME2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Mar 2020 08:04:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id d1so6691598wmb.2
        for <linux-nfs@vger.kernel.org>; Thu, 26 Mar 2020 05:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FDNyDDJ8o0K9QyMa5cH/UAK1e8l66FlzJGB1L65Rgrc=;
        b=YDW/8dxhb4ZcChUHLUXF5aeE0n53tZGioqTmFfHhifvnKHUZK/LhlLF7cjhUP5l1vL
         t3r0hxykuYHw1QzZFMBepGzNM54lAGTov1E9cuTOib4ki6MD8hRhTwD1xdCp4LwK21Fp
         6aAEPWlPlMSyeuoKUBXvzeI7CSWFxJr4ZQFXCA1Er6CotnihYHu41KUsqE5FWIOTHtBx
         Xwzkz87nGDFKD6+UURf5InqcKCroyJ+hxRo2ovLLqlcrGDrczom99PZCxh7XDNVf6b2o
         0MYXCd8qviccsHHcEay/J35nInxBNR+mnDH0Alcd23Zlq1kSeG76UxSeC3SsY3xi8i68
         B7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FDNyDDJ8o0K9QyMa5cH/UAK1e8l66FlzJGB1L65Rgrc=;
        b=COwmWuM8pp6VP8W+Twpjg6k3FyqPEqoSbE8OgZ+Oho7Er2CBNBbhvxIfhY8jQ4b05c
         peaL1UTuXq1HKDLeMhMWAINPWfuFUriaXa/EMr0VIeStWHnLi9PAQMPWtqfb/+WWcLEw
         z1G8eG+nnIT+CSmoP+3hFed+hSCy3GQbSlJFIXXmfh7+t68I3r7I+BHYPELDRvTyue7x
         Gs7qG+8RFYcNlzTTbAqlv1FG5LOCa4N23eE0Keo9oWKCt6FFULnCj7MarvYop8xzflMT
         Ba/ZgALsHAaMRnp1w4fAVOR9pbY4Htt0Giw2gIybc8N1pufcp+6j3zWzYU0oNAQBM9Cy
         21ag==
X-Gm-Message-State: ANhLgQ0/s+MjNk+YLpHYTSIox6iiJlKbHCK90tQqtwNrbdNxdUW16+/6
        BHcyhzZlE5pETojAuJd0KIcnUkuBhqsf7eaWzHI=
X-Google-Smtp-Source: ADFU+vvXB3I/k23u0Sjzv5e7z0aUT+GGZnOBkWIhk8VYCACp97JlvV7fmOuznJ3d2khSBeFuRR6o8CTScb9xIa3ZwGI=
X-Received: by 2002:a1c:3d83:: with SMTP id k125mr2960474wma.177.1585224265621;
 Thu, 26 Mar 2020 05:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200325210136.2826-1-olga.kornievskaia@gmail.com> <B6EFDEA3-BEB0-4ED0-8288-34CAE4BE9B8A@oracle.com>
In-Reply-To: <B6EFDEA3-BEB0-4ED0-8288-34CAE4BE9B8A@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 26 Mar 2020 08:04:13 -0400
Message-ID: <CAN-5tyEDRQZX-saVrbfn7G7pzmSOyROipEzxjVPxF1WV8rK+vg@mail.gmail.com>
Subject: Re: [PATCH 1/1] SUNRPC: fix krb5p mount to provide large enough
 buffer in rq_rcvsize
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 25, 2020 at 5:34 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Mar 25, 2020, at 5:01 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Ever since commit 2c94b8eca1a2 ("SUNRPC: Use au_rslack when computing
> > reply buffer size"). It changed how "req->rq_rcvsize" is calculated. It
> > used to use au_cslack value which was nice and large and changed it to
> > au_rslack value which turns out to be too small.
> >
> > Since 5.1, v3 mount with sec=krb5p fails against an Ontap server
> > because client's receive buffer it too small.
> >
> > For gss krb5p, we need to account for the mic token in the verifier,
> > and the wrap token in the wrap token.
> >
> > RFC 4121 defines:
> > mic token
> > Octet no   Name        Description
> >         --------------------------------------------------------------
> >         0..1     TOK_ID     Identification field.  Tokens emitted by
> >                             GSS_GetMIC() contain the hex value 04 04
> >                             expressed in big-endian order in this
> >                             field.
> >         2        Flags      Attributes field, as described in section
> >                             4.2.2.
> >         3..7     Filler     Contains five octets of hex value FF.
> >         8..15    SND_SEQ    Sequence number field in clear text,
> >                             expressed in big-endian order.
> >         16..last SGN_CKSUM  Checksum of the "to-be-signed" data and
> >                             octet 0..15, as described in section 4.2.4.
> >
> > that's 16bytes (GSS_KRB5_TOK_HDR_LEN) + chksum
> >
> > wrap token
> > Octet no   Name        Description
> >         --------------------------------------------------------------
> >          0..1     TOK_ID    Identification field.  Tokens emitted by
> >                             GSS_Wrap() contain the hex value 05 04
> >                             expressed in big-endian order in this
> >                             field.
> >          2        Flags     Attributes field, as described in section
> >                             4.2.2.
> >          3        Filler    Contains the hex value FF.
> >          4..5     EC        Contains the "extra count" field, in big-
> >                             endian order as described in section 4.2.3.
> >          6..7     RRC       Contains the "right rotation count" in big-
> >                             endian order, as described in section
> >                             4.2.5.
> >          8..15    SND_SEQ   Sequence number field in clear text,
> >                             expressed in big-endian order.
> >          16..last Data      Encrypted data for Wrap tokens with
> >                             confidentiality, or plaintext data followed
> >                             by the checksum for Wrap tokens without
> >                             confidentiality, as described in section
> >                             4.2.4.
> >
> > Also 16bytes of header (GSS_KRB5_TOK_HDR_LEN), encrypted data, and cksum
> > (other things like padding)
> >
> > RFC 3961 defines known cksum sizes:
> > Checksum type              sumtype        checksum         section or
> >                                value            size         reference
> >   ---------------------------------------------------------------------
> >   CRC32                            1               4           6.1.3
> >   rsa-md4                          2              16           6.1.2
> >   rsa-md4-des                      3              24           6.2.5
> >   des-mac                          4              16           6.2.7
> >   des-mac-k                        5               8           6.2.8
> >   rsa-md4-des-k                    6              16           6.2.6
> >   rsa-md5                          7              16           6.1.1
> >   rsa-md5-des                      8              24           6.2.4
> >   rsa-md5-des3                     9              24             ??
> >   sha1 (unkeyed)                  10              20             ??
> >   hmac-sha1-des3-kd               12              20            6.3
> >   hmac-sha1-des3                  13              20             ??
> >   sha1 (unkeyed)                  14              20             ??
> >   hmac-sha1-96-aes128             15              20         [KRB5-AES]
> >   hmac-sha1-96-aes256             16              20         [KRB5-AES]
> >   [reserved]                  0x8003               ?         [GSS-KRB5]
> >
> > Linux kernel now mainly supports type 15,16 so max cksum size is 20bytes.
> > (GSS_KRB5_MAX_CKSUM_LEN)
> >
> > Re-use already existing define of GSS_KRB5_MAX_SLACK_NEEDED that's used
> > for encoding the gss_wrap tokens (same tokens are used in reply).
> >
> > Fixes: 2c94b8eca1a2 ("SUNRPC: Use au_rslack when computing reply buffer size")
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> > net/sunrpc/auth_gss/auth_gss.c | 5 ++++-
> > 1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
> > index 24ca861..5a733a6 100644
> > --- a/net/sunrpc/auth_gss/auth_gss.c
> > +++ b/net/sunrpc/auth_gss/auth_gss.c
> > @@ -20,6 +20,7 @@
> > #include <linux/sunrpc/clnt.h>
> > #include <linux/sunrpc/auth.h>
> > #include <linux/sunrpc/auth_gss.h>
> > +#include <linux/sunrpc/gss_krb5.h>
> > #include <linux/sunrpc/svcauth_gss.h>
> > #include <linux/sunrpc/gss_err.h>
> > #include <linux/workqueue.h>
> > @@ -51,6 +52,8 @@
> > /* length of a krb5 verifier (48), plus data added before arguments when
> >  * using integrity (two 4-byte integers): */
> > #define GSS_VERF_SLACK                100
> > +/* covers lengths of gss_unwrap() extra kerberos mic and wrap token */
> > +#define GSS_RESP_SLACK               (GSS_KRB5_MAX_SLACK_NEEDED << 2)
>
> GSS_KRB5_MAX_SLACK_NEEDED is already in bytes. Shouldn't need the "<< 2" here.


Ok yes just for my own understanding I convinced myself that indeed
"<<2" is not needed here because clnt.c will do rq_rcvsize is <<=2.

Now question: Do I even need to introduce GSS_RES_SLACK at all or
perhaps just use GSS_KRB5_MAX_SLACK_NEEDED to initialize?

> > static DEFINE_HASHTABLE(gss_auth_hash_table, 4);
> > static DEFINE_SPINLOCK(gss_auth_hash_lock);
> > @@ -1050,7 +1053,7 @@ static void gss_pipe_free(struct gss_pipe *p)
> >               goto err_put_mech;
> >       auth = &gss_auth->rpc_auth;
> >       auth->au_cslack = GSS_CRED_SLACK >> 2;
> > -     auth->au_rslack = GSS_VERF_SLACK >> 2;
> > +     auth->au_rslack = GSS_RESP_SLACK >> 2;
> >       auth->au_verfsize = GSS_VERF_SLACK >> 2;
> >       auth->au_ralign = GSS_VERF_SLACK >> 2;
> >       auth->au_flags = 0;
> > --
> > 1.8.3.1
> >
>
> --
> Chuck Lever
>
>
>
