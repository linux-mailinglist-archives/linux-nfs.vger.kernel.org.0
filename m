Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5341B77E7AF
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Aug 2023 19:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345191AbjHPRd3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Aug 2023 13:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345271AbjHPRdI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Aug 2023 13:33:08 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B948273A
        for <linux-nfs@vger.kernel.org>; Wed, 16 Aug 2023 10:32:48 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4103cec468fso29821151cf.3
        for <linux-nfs@vger.kernel.org>; Wed, 16 Aug 2023 10:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692207167; x=1692811967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdbNYCD7Z4tPncEehX34U+lgntBsfflyyHG+PTHQbHE=;
        b=fLqG8TTWv7TvmysVVIpF1/ChitMsm1JzlvkJn7ugnRVwrsoNEWdPLgLKuOPub5yCO0
         U+bpI+XRchgGtMSRuMic6kcpQqus4XqLTk9pjjk6oyYImIzftnoav+z0EUS8JXEM0OAm
         dRenlgU2UJ+P6bjsqrDQh+QnRV5hkzPONBnfChoWWpeX2BrIDoybVLeGkXiXCQM7Q/11
         U8mfs9Bu2xqURD1Z/qi4qXA86l3MNUTUA94IXV6lywNVNEvw1Q+Zn5O7W/gPBiGMShDC
         LBprkDX+eBFBbOnwO4lW69S5QFATsqS/lOdCHkHqlQcJkXNI7q/jsDgIjgeWNfNbsXqz
         uteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692207167; x=1692811967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdbNYCD7Z4tPncEehX34U+lgntBsfflyyHG+PTHQbHE=;
        b=Ofm3LQae25iCtjvAZCDc8FLa9sjp9ozioAwRJohXd/18VUunnMTaxU5K9qBL/NSdpP
         07EhAjPpsi1jrvv+jN9Y6DgRUJoui7h2bvHXXqeJ5GZF2LsfRracnKLzUOxwNn8csea6
         W7DFGVrg6M6/PLJ2ZdQrjA99tcpQxU9PUDjitSJoM4vA7cQ0EHYIN9TIvGl4I4V1cgyn
         bb3+1wSHvTHywlxOfIv49eaB/X0zlv2WEXkMOZ3zaXJfe/76qXV+wGpoPl0JpDC5Bb14
         woU7VylrdN0R9W3tFmjou27k0CrlwU1sKPPjjn4zhaMidWDS0pv3x5rU834UySx4Jyus
         outA==
X-Gm-Message-State: AOJu0YxRVpoVMHww/Wf74YCfw7PkkKto5UN1VwrCBCcyqAuvqnDZ45W0
        uQN29MpFokxLJZtfs2mMqMFRlPE/TV7F2IImkXw=
X-Google-Smtp-Source: AGHT+IFIjYjZf69mJLYWAFE4I3+YuvqqKT6WiaO18r6Kbn9ggtCjUP1ktbxbw5s1Gh46vmDVQ71z0BQTKu0U6Qbzy7k=
X-Received: by 2002:ac8:7f07:0:b0:400:9b69:7c13 with SMTP id
 f7-20020ac87f07000000b004009b697c13mr3479247qtk.59.1692207167539; Wed, 16 Aug
 2023 10:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <b1ae55f1c835ea6b30089a9377ae67c40d43a0fc.camel@kernel.org> <CAN-5tyHejgLNPrF-bybFqrkiEvvFb+SZ9NHne9RiQ0kVwESd5A@mail.gmail.com>
In-Reply-To: <CAN-5tyHejgLNPrF-bybFqrkiEvvFb+SZ9NHne9RiQ0kVwESd5A@mail.gmail.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Wed, 16 Aug 2023 13:32:31 -0400
Message-ID: <CAFX2Jfnr2_VCy7EWn7_+GMeD+rsffSX-hY0_n4=CtOdq9Wq+dw@mail.gmail.com>
Subject: Re: turning on s2s copy by default in knfsd
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Dai Ngo <dai.ngo@oracle.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Steve Dickson <steved@redhat.com>,
        Olga Kornieskaia <kolga@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 11, 2023 at 10:42=E2=80=AFAM Olga Kornievskaia <aglo@umich.edu>=
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
> >
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

I do still have Andy's gssv3 implementation patches, but it looks like
it's been longer than I thought since I last rebased them. They apply
cleanly to Linux 5.0, but not 5.1. I'll see what it takes to get them
up to date.

Anna

>
> I'd like to address some other questions later as I'm out of the office t=
oday.
>
> > Incidentally, has anyone tried doing this with sec=3Dkrb5 in the curren=
t
> > code? Does it actually work? I don't see any place where we return
> > nfserr_partner_no_auth, so I wonder if we need to fix up the s2s COPY
> > authentication and error handling?
> >
> > Another question: The v4.2 spec was written before the RPC over TLS
> > spec. Should we aim to allow this to work by default if the client and
> > both servers are using xprtsec=3Dmtls and are secured by the same CA?
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
