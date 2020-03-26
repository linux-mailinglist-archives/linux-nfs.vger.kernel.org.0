Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 473D4193EA9
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 13:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgCZMKW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Mar 2020 08:10:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50718 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgCZMKW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Mar 2020 08:10:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id d198so6227156wmd.0
        for <linux-nfs@vger.kernel.org>; Thu, 26 Mar 2020 05:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7UqJGN6NeASp+DX5sIdEhPIKOd9okCj88NHKBcwrtuQ=;
        b=BTN54q1uovi/mWLjhMgt8jSRxk8E15Ev25F+6eFhZYIwKS2hfXnjBk7OPVYVkp+0fp
         jKwU+FZyiR5QbCepBNw12i2QTbtthXDb5f4BbXImnrwNbmuVxN9GISBFjZ3B5Yml9xvd
         KT7yX74YVL89aE/FpbAqiGNbXNZZ0GF1qRcE9lFnRyfeZKXNJ0ucEM0FFeiZzdUT2RV2
         00lOkrDEgB+YiudygiNc9fMhfTsknZzGn3haqVZCnRExSbsBVDnqfRn4XZ1TSLjfcUZ9
         bApghDKBifaL6GGaLK7Ab5zFbKtgySKFstiEkQudrwU6p0UaWdFACbU8T5TvqIqF7mvZ
         TqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7UqJGN6NeASp+DX5sIdEhPIKOd9okCj88NHKBcwrtuQ=;
        b=ez7ehjd1kvLCKPnpLpFnFYyVdYHGUqjCN4hyIsNu2YdVnWrVbkvpxCuTYpFbEkM3rt
         Gz8hBElnzc31XunNJk/eXq/RbQM2Uo/am1ZVGFfgXS5axH7JDbAaplrWL+fEh48ehhW+
         YaF03Kg9jXnTXd9AcwCEJyJDg0EXBOeYTFkJJvOkjShDY/pxoZr8OzwuNK34SV7c2+LN
         +ROX3F9xXU7BGjtFPpiy03P3AEHAbSDG4iUKoRfjPnJyhcYhdIde5N3Mdt7AEEYzZuct
         1EFakt7LfevbokinmaxPWL/I/TCiV5F3/jV9tJksHE8SpWuxTG6pbZvaINgyWacb3c/j
         g3pQ==
X-Gm-Message-State: ANhLgQ2RRyE6noSzsqw3GyajB0Sqm3Is2XfxTJ9lxhK6s35BD6Luik/v
        oPxC6VxQD2lp/r8JoOumFZvSdYTYqgQmFhHow5bpLA==
X-Google-Smtp-Source: ADFU+vty83fAO3YoSv+XB3gJmYvVoIifJ0DoNNmENuQjcQAlwODZv82PMjOXvjZvO0VI19jZ87kNhlz1soffw2l0emM=
X-Received: by 2002:a1c:6608:: with SMTP id a8mr2721463wmc.113.1585224618749;
 Thu, 26 Mar 2020 05:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200325210136.2826-1-olga.kornievskaia@gmail.com>
 <7363e7b550dc5adad3f00fb84d9586764b8ec4fb.camel@hammerspace.com>
 <8A8EC7E8-9EB6-49DA-8393-241B4977E67E@oracle.com> <95dfed7d00d8d0d02a0705e8c1ceeb961456a554.camel@hammerspace.com>
 <0D3443FF-0170-40E2-B3A5-54B486B88023@oracle.com>
In-Reply-To: <0D3443FF-0170-40E2-B3A5-54B486B88023@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 26 Mar 2020 08:10:07 -0400
Message-ID: <CAN-5tyG0R6hi80RWO74Fx-bTur8U+aqTc=a_5vb-GvakYp2PVQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] SUNRPC: fix krb5p mount to provide large enough
 buffer in rq_rcvsize
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 25, 2020 at 5:55 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Mar 25, 2020, at 5:52 PM, Trond Myklebust <trondmy@hammerspace.com> wrote:
> >
> > On Wed, 2020-03-25 at 17:43 -0400, Chuck Lever wrote:
> >>> On Mar 25, 2020, at 5:33 PM, Trond Myklebust <
> >>> trondmy@hammerspace.com> wrote:
> >>>
> >>> Hi Olga,
> >>>
> >>> On Wed, 2020-03-25 at 17:01 -0400, Olga Kornievskaia wrote:
> >>>> From: Olga Kornievskaia <kolga@netapp.com>
> >>>>
> >>>> Ever since commit 2c94b8eca1a2 ("SUNRPC: Use au_rslack when
> >>>> computing
> >>>> reply buffer size"). It changed how "req->rq_rcvsize" is
> >>>> calculated.
> >>>> It
> >>>> used to use au_cslack value which was nice and large and changed
> >>>> it
> >>>> to
> >>>> au_rslack value which turns out to be too small.
> >>>>
> >>>> Since 5.1, v3 mount with sec=krb5p fails against an Ontap server
> >>>> because client's receive buffer it too small.
> >>>>
> >>>> For gss krb5p, we need to account for the mic token in the
> >>>> verifier,
> >>>> and the wrap token in the wrap token.
> >>>>
> >>>> RFC 4121 defines:
> >>>> mic token
> >>>> Octet no   Name        Description
> >>>>        ---------------------------------------------------------
> >>>> -
> >>>> ----
> >>>>        0..1     TOK_ID     Identification field.  Tokens emitted
> >>>> by
> >>>>                            GSS_GetMIC() contain the hex value 04
> >>>> 04
> >>>>                            expressed in big-endian order in this
> >>>>                            field.
> >>>>        2        Flags      Attributes field, as described in
> >>>> section
> >>>>                            4.2.2.
> >>>>        3..7     Filler     Contains five octets of hex value FF.
> >>>>        8..15    SND_SEQ    Sequence number field in clear text,
> >>>>                            expressed in big-endian order.
> >>>>        16..last SGN_CKSUM  Checksum of the "to-be-signed" data
> >>>> and
> >>>>                            octet 0..15, as described in section
> >>>> 4.2.4.
> >>>>
> >>>> that's 16bytes (GSS_KRB5_TOK_HDR_LEN) + chksum
> >>>>
> >>>> wrap token
> >>>> Octet no   Name        Description
> >>>>        ---------------------------------------------------------
> >>>> -
> >>>> ----
> >>>>         0..1     TOK_ID    Identification field.  Tokens emitted
> >>>> by
> >>>>                            GSS_Wrap() contain the hex value 05
> >>>> 04
> >>>>                            expressed in big-endian order in this
> >>>>                            field.
> >>>>         2        Flags     Attributes field, as described in
> >>>> section
> >>>>                            4.2.2.
> >>>>         3        Filler    Contains the hex value FF.
> >>>>         4..5     EC        Contains the "extra count" field, in
> >>>> big-
> >>>>                            endian order as described in section
> >>>> 4.2.3.
> >>>>         6..7     RRC       Contains the "right rotation count"
> >>>> in
> >>>> big-
> >>>>                            endian order, as described in section
> >>>>                            4.2.5.
> >>>>         8..15    SND_SEQ   Sequence number field in clear text,
> >>>>                            expressed in big-endian order.
> >>>>         16..last Data      Encrypted data for Wrap tokens with
> >>>>                            confidentiality, or plaintext data
> >>>> followed
> >>>>                            by the checksum for Wrap tokens
> >>>> without
> >>>>                            confidentiality, as described in
> >>>> section
> >>>>                            4.2.4.
> >>>>
> >>>> Also 16bytes of header (GSS_KRB5_TOK_HDR_LEN), encrypted data,
> >>>> and
> >>>> cksum
> >>>> (other things like padding)
> >>>>
> >>>> RFC 3961 defines known cksum sizes:
> >>>> Checksum
> >>>> type              sumtype        checksum         section or
> >>>>                               value            size         refe
> >>>> ren
> >>>> ce
> >>>>  -------------------------------------------------------------
> >>>> ---
> >>>> -----
> >>>>
> >>>> CRC32                            1               4           6.1.
> >>>> 3
> >>>>  rsa-
> >>>> md4                          2              16           6.1.2
> >>>>  rsa-md4-
> >>>> des                      3              24           6.2.5
> >>>>  des-
> >>>> mac                          4              16           6.2.7
> >>>>  des-mac-
> >>>> k                        5               8           6.2.8
> >>>>  rsa-md4-des-
> >>>> k                    6              16           6.2.6
> >>>>  rsa-
> >>>> md5                          7              16           6.1.1
> >>>>  rsa-md5-
> >>>> des                      8              24           6.2.4
> >>>>  rsa-md5-
> >>>> des3                     9              24             ??
> >>>>  sha1
> >>>> (unkeyed)                  10              20             ??
> >>>>  hmac-sha1-des3-
> >>>> kd               12              20            6.3
> >>>>  hmac-sha1-
> >>>> des3                  13              20             ??
> >>>>  sha1
> >>>> (unkeyed)                  14              20             ??
> >>>>  hmac-sha1-96-
> >>>> aes128             15              20         [KRB5-
> >>>> AES]
> >>>>  hmac-sha1-96-
> >>>> aes256             16              20         [KRB5-
> >>>> AES]
> >>>>
> >>>> [reserved]                  0x8003               ?         [GSS-
> >>>> KRB5]
> >>>>
> >>>> Linux kernel now mainly supports type 15,16 so max cksum size is
> >>>> 20bytes.
> >>>> (GSS_KRB5_MAX_CKSUM_LEN)
> >>>>
> >>>> Re-use already existing define of GSS_KRB5_MAX_SLACK_NEEDED
> >>>> that's
> >>>> used
> >>>> for encoding the gss_wrap tokens (same tokens are used in reply).
> >>>>
> >>>> Fixes: 2c94b8eca1a2 ("SUNRPC: Use au_rslack when computing reply
> >>>> buffer size")
> >>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> >>>> ---
> >>>> net/sunrpc/auth_gss/auth_gss.c | 5 ++++-
> >>>> 1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/net/sunrpc/auth_gss/auth_gss.c
> >>>> b/net/sunrpc/auth_gss/auth_gss.c
> >>>> index 24ca861..5a733a6 100644
> >>>> --- a/net/sunrpc/auth_gss/auth_gss.c
> >>>> +++ b/net/sunrpc/auth_gss/auth_gss.c
> >>>> @@ -20,6 +20,7 @@
> >>>> #include <linux/sunrpc/clnt.h>
> >>>> #include <linux/sunrpc/auth.h>
> >>>> #include <linux/sunrpc/auth_gss.h>
> >>>> +#include <linux/sunrpc/gss_krb5.h>
> >>>> #include <linux/sunrpc/svcauth_gss.h>
> >>>> #include <linux/sunrpc/gss_err.h>
> >>>> #include <linux/workqueue.h>
> >>>> @@ -51,6 +52,8 @@
> >>>> /* length of a krb5 verifier (48), plus data added before
> >>>> arguments
> >>>> when
> >>>> * using integrity (two 4-byte integers): */
> >>>> #define GSS_VERF_SLACK             100
> >>>> +/* covers lengths of gss_unwrap() extra kerberos mic and wrap
> >>>> token
> >>>> */
> >>>> +#define GSS_RESP_SLACK            (GSS_KRB5_MAX_SLACK_NEEDED <<
> >>>> 2)
> >>>>
> >>>> static DEFINE_HASHTABLE(gss_auth_hash_table, 4);
> >>>> static DEFINE_SPINLOCK(gss_auth_hash_lock);
> >>>> @@ -1050,7 +1053,7 @@ static void gss_pipe_free(struct gss_pipe
> >>>> *p)
> >>>>            goto err_put_mech;
> >>>>    auth = &gss_auth->rpc_auth;
> >>>>    auth->au_cslack = GSS_CRED_SLACK >> 2;
> >>>> -  auth->au_rslack = GSS_VERF_SLACK >> 2;
> >>>> +  auth->au_rslack = GSS_RESP_SLACK >> 2;
> >>>>    auth->au_verfsize = GSS_VERF_SLACK >> 2;
> >>>>    auth->au_ralign = GSS_VERF_SLACK >> 2;
> >>>>    auth->au_flags = 0;
> >>>
> >>> Is this a sufficient fix, though? It looks to me as if the above is
> >>> just an initial value that gets adjusted on the fly in
> >>> gss_unwrap_resp_priv():
> >>>
> >>>       auth->au_rslack = auth->au_verfsize + 2 +
> >>>                         XDR_QUADLEN(savedlen - rcv_buf->len);
> >>>       auth->au_ralign = auth->au_verfsize + 2 +
> >>>                         XDR_QUADLEN(savedlen - rcv_buf->len);
> >>
> >> That's correct. The GSS_*_SLACK value is a _sz value that is
> >> the largest possible expected size of the extra GSS data.
> >>
> >>
> >>> My questions would be
> >>>
> >>> - Are we sure that the above calculation (in
> >>> gss_unwrap_resp_priv()) is
> >>> correct?
> >>
> >> Yes, this is the correct computation.
> >>
> >> We know this because if the initial au_rslack value is large
> >> enough, then subsequent Replies have the correct amount of buffer
> >> space and always succeed.
> >>
> >>
> >>> - Are we sure that the above calculation always gives the same
> >>> answer
> >>> over time? We probably should not store a value that keeps
> >>> changing.
> >>
> >> It does not change after the first Reply. au_rslack is typically
> >> adjusted downwards from the initial value based on the size of the
> >> first received Reply.
> >>
> >> Not setting these variables after the first Reply has been received
> >> would be a minor optimization that could be done after Olga's fix.
> >>
> >
> > OK. So you're both saying that as long as the initial value is correct,
> > we're good for the duration of the GSS session? Fair enough, I'll apply
> > this patch for 5.7 then.
>
> Thanks, please see my one-line correction. I think the definition of
> GSS_RESP_SLACK should not include the "<< 2", I would like Olga to
> confirm.

Yes I do.

> > Let's also fix up the above in a separate patch to not keep setting
> > auth->au_rslack / auth->au_ralign if their values are not changing.
> > That should prevent unnecessary cache line bouncing.
>
> I volunteer, unless Olga wants to take it.

Please do the fix (as because I'm not understanding what needs to be
fixed and I'd be bugging you folks to explain it first).

>
>
> --
> Chuck Lever
>
>
>
