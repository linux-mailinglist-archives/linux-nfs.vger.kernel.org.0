Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4F77812A4
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 20:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379402AbjHRSPD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Aug 2023 14:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379393AbjHRSOe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Aug 2023 14:14:34 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEE4E74
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 11:14:32 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bb8ab71165so2909881fa.0
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1692382470; x=1692987270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9l0ePQs8mKs0/qHzi4iChwKje8a/fPUtxNJyuzqEwU=;
        b=GbOqrkffGQLSyXp8d88679NwL5sRVeUihnpd97cPoQeF8A1BEQknEPHyzV9AOEpkL1
         D1NjP6pUhm5GfC+fFyigclt6/8gKbvC2bbUFHg3uyEiIVqRqVOMgdTCpK+iMZTtuT0Sk
         fOI8AcQJlSef6Xn6VEcsZ0sPnhzBAdr4q9j135L28NuAi/4EKqm/UL6oshebgSRnrHNV
         6ZsJrjQSFz0M6w0mrhTuunZUd1bvbADsOq4//2BDXtg05sLs186r9T9OHobEl62yzc0O
         j8qaDNeZUjqBpGfm9PJuIyhGEs+cSgsd2HobVLA6g9Kge2XcTqqwgUYucAYd2UbfyAFB
         WDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692382470; x=1692987270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9l0ePQs8mKs0/qHzi4iChwKje8a/fPUtxNJyuzqEwU=;
        b=PHCcFn74Zy5T2ujThFJWnvfovEyERvjAvQPYqWjsj+IrNdxgmPWLOPy5DOh8wiesIU
         5nKrRD3hntnZMVBjrd1eT7xvlQCHqlgDNjI2WBmbUotgl8rEAdFkNw6oUstJedSDkuSi
         /cvde8+JcI4egSXZ/XVhrGwc3R7sYMSI1PjS4lyGxFxNRiDWSd0Wubyl7U9opP7YbLnS
         Xk0SvJX4ioAER7aYrQ5ZXTEMzbdfbWYoDZOI50x/9Hu+HAcmtQQTnTSq/NAUso4HeAVt
         ug/gEDfqASzLmlt8Ft9z/A4S72pw1p4MS/JCcpfy/3QK4LEkZnMaBDVSGTwlk99Xo5ha
         Pqjg==
X-Gm-Message-State: AOJu0YxuNHdWhNLNMMv8iTs3Zu9yvMs9EEJGfi/T6rs3FZiS4GIek5QX
        9RsmgPWS98LKnRCKUqVn5RfXEbYhs3s0E9E6SyF3TqUA
X-Google-Smtp-Source: AGHT+IHsax8OBqncUzzVNLKrHkkewO5l6cYwSCmnPzsj1VE0AoSyqfqhEe3RUM7HW56gooIFFgyfuVrL/Lva1TIXNlw=
X-Received: by 2002:a2e:a44b:0:b0:2b7:34c0:a03a with SMTP id
 v11-20020a2ea44b000000b002b734c0a03amr2319064ljn.3.1692382470107; Fri, 18 Aug
 2023 11:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <b1ae55f1c835ea6b30089a9377ae67c40d43a0fc.camel@kernel.org> <CAN-5tyHejgLNPrF-bybFqrkiEvvFb+SZ9NHne9RiQ0kVwESd5A@mail.gmail.com>
In-Reply-To: <CAN-5tyHejgLNPrF-bybFqrkiEvvFb+SZ9NHne9RiQ0kVwESd5A@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 18 Aug 2023 14:14:16 -0400
Message-ID: <CAN-5tyFrNGFbb3Um_=SB0TYGcRoofn9vPqsbjQmNnBf3RkRpog@mail.gmail.com>
Subject: Re: turning on s2s copy by default in knfsd
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <dai.ngo@oracle.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Steve Dickson <steved@redhat.com>,
        Olga Kornieskaia <kolga@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 11, 2023 at 10:28=E2=80=AFAM Olga Kornievskaia <aglo@umich.edu>=
 wrote:
>
> On Fri, Aug 11, 2023 at 10:23=E2=80=AFAM Jeff Layton <jlayton@kernel.org>=
 wrote:
> >
> > Chuck and I were chatting yesterday about what it will take to make the
> > inter_copy_offload_enable module option on by default, and I'd like to
> > start working toward that end.
> >
> > I think what we want to aim for is to eventually deprecate the module
> > option and have this "just work" when the conditions are right.
> >
> > It looks like main obstacle is this (from RFC7862 section 4.9):
> >
> >    NFSv4 clients and servers supporting the inter-server COPY operation=
s
> >    described in this section are REQUIRED to implement the mechanism
> >    described in Section 4.9.1.1 and to support rejecting COPY_NOTIFY
> >    requests that do not use the RPC security protocol (RPCSEC_GSS)
> >    [RFC7861] with privacy.  If the server-to-server copy protocol is
> >    based on ONC RPC, the servers are also REQUIRED to implement
> >    [RFC7861], including the RPCSEC_GSSv3 "copy_to_auth",
> >    "copy_from_auth", and "copy_confirm_auth" structured privileges.
> >    This requirement to implement is not a requirement to use; for
> >    example, a server may, depending on configuration, also allow
> >    COPY_NOTIFY requests that use only AUTH_SYS.

This spec wording that it's required to implement but not required to
use makes me ask why is it a requirement at all. Anyway...

> >    If a server requires the use of an RPCSEC_GSSv3 copy_to_auth,
> >    copy_from_auth, or copy_confirm_auth privilege and it is not used,
> >    the server will reject the request with NFS4ERR_PARTNER_NO_AUTH.
> >
> > We don't (yet) have GSSv3 support, so we'd need to implement that in
> > order to make this work right with krb5. Has anyone started looking at
> > GSSv3?
>
> Andy Adamson way back when implemented a draft gssv3 implementation
> and I believe we still have those patches. Anna periodically have been
> rebasing them but no more than that. I believe there might have been
> even some patches for the copy piece but I believe those might be
> lost. I'd have to dig around in my oldest laptop.
>
> I'd like to address some other questions later as I'm out of the office t=
oday.
>
> > Incidentally, has anyone tried doing this with sec=3Dkrb5 in the curren=
t
> > code?

I'm not sure I fully understand your question but yes the COPY would
work over a sec=3Dkrb5* mount. What is not there is fulfillment of the
requirement to make sure that the client does COPY_NOTIFY over
sec=3Dkrb5p gssv3 regardless what mount flavor was used originally.

> Does it actually work? I don't see any place where we return
> > nfserr_partner_no_auth,

That's because initial implementation followed the spec wording that
it is allowed to use auth_sys and not enforce gssv3.

> so I wonder if we need to fix up the s2s COPY
> > authentication and error handling?

Yes the server would need to be change to enforce several things with
regards to the COPY_NOTIFY and inter-server copy processing in
general.

> > Another question: The v4.2 spec was written before the RPC over TLS
> > spec. Should we aim to allow this to work by default if the client and
> > both servers are using xprtsec=3Dmtls and are secured by the same CA?

Yes and no. The fact that COPY_NOTIFY needs to be done over krb5p to
insure privacy/integrity of passing the structured privilege. But then
in order to use the structured privilege a new operation is used
GSSv3_create which makes use of that. this operation must done with
gss privacy. TLS is not a GSS protocol so underneath the only choice
is krb5(p). You COULD layer gssv3 over TLS but I'm not sure what would
be the point of that.

So I think the real answer is:"no" we can't use TLS here. Or need to
update the spec with a new way of doing "inter" copy security over
TLS.

> >
> > 1/ the client and servers are all using GSSv3 with krb5p (or some other
> > encryption)
> >
> > ...or...
> >
> > 2/ the client and servers are all using mtls with certificates signed b=
y
> > the same CA
> >
> >
> > ...I expect we'll probably be able to accomodate #2 before #1.
> >
> > Beyond that, we could allow for module or export option that still
> > allows s2s copy to work and relaxes the above restrictions (to allow
> > people to use it over plaintext with AUTH_SYS on "secure" networks).
> >
> > Anything I've overlooked here, or other thoughts?
> >
> > Cheers,
> > --
> > Jeff Layton <jlayton@kernel.org>
