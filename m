Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C914D778225
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Aug 2023 22:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbjHJUZe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Aug 2023 16:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbjHJUZa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Aug 2023 16:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056592733
        for <linux-nfs@vger.kernel.org>; Thu, 10 Aug 2023 13:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691699086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HqygJpPikOyXm/wHwFtZNHvPApi5DlCiSAoJ4H1J1qM=;
        b=GarmIENn9NZOXH7UOdj4vN70wZ3qKFYCWPRLyvPqkFAEh5fIbDiB68MJWDRgF0NH7+7naq
        a0UQ0PxDMyvl4vZzehVkRku2tvoNUKNRuwpdCDz6oi0O1KYrekwQSx/orYyMKacKTnF+ls
        pfDAKhuXAWoawR/RSFXOa9s/oTURjTg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-RoxN_FvwP1GWKIfuITJipQ-1; Thu, 10 Aug 2023 16:24:45 -0400
X-MC-Unique: RoxN_FvwP1GWKIfuITJipQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fe4a1ce065so1269688e87.3
        for <linux-nfs@vger.kernel.org>; Thu, 10 Aug 2023 13:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691699083; x=1692303883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqygJpPikOyXm/wHwFtZNHvPApi5DlCiSAoJ4H1J1qM=;
        b=cCXovrO8V1KiIoBYAcRkWNam11S06CuK0LX8RtVXL2orYcgii1j00IuYCSmPO8dmI/
         M2YCsF8T03hnWTMRD2TAXVVEGZRQSVK1/b0XWu8VmG7PFAiuaOt523lSbBGM1QSF4V7z
         DYsUfePVxQOmkfCyrNpVP8ooDATWGAHLc/UhVWXUJcJFlkFQzS7e8KMRPdSauoOFQBWj
         N1e2jhtCOAR9D/joEMUQwVeYcognTdMLn2M84cblxOygpRVZVLJpPlFqdPIKI4a8WuUP
         KvqK01Zd/MeLzv0zxBeEl/cJ5XUoO0lj2mxSRx+OANmYV5lILvjoD7yyzalSsf4zeGG9
         4j3w==
X-Gm-Message-State: AOJu0Yx0cWZ3/nbgkMZ6DrJIbe+zgs8w76t8Zk07FcYnFSWn+0XOv6Nb
        +n/eBaNstUCYBaYi9lT91/UucMvA7ESuYqMxCmYynEIkS5bgmRdZ7jwlrNo45U3pxLywaKyWGlP
        WqtNOak8nBrfjpgAQFQ8DBTipQbggCafAPDPM4wXxdkWi
X-Received: by 2002:a19:644e:0:b0:4fe:ef9:c8d0 with SMTP id b14-20020a19644e000000b004fe0ef9c8d0mr2399099lfj.35.1691699082928;
        Thu, 10 Aug 2023 13:24:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4snsAYYAxitJ3kstAcmF6iy3hfrvRNaBhVUSfukWe/rN8pyfG+Rc91yAMi71zKGXU1Y4xobOMUc+21Uza6gA=
X-Received: by 2002:a19:644e:0:b0:4fe:ef9:c8d0 with SMTP id
 b14-20020a19644e000000b004fe0ef9c8d0mr2399086lfj.35.1691699082596; Thu, 10
 Aug 2023 13:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230720125806.1385279-1-aahringo@redhat.com> <20230720125806.1385279-3-aahringo@redhat.com>
 <fc5c5e0bcfa7110282106c3319af6a0b5a63b221.camel@kernel.org>
In-Reply-To: <fc5c5e0bcfa7110282106c3319af6a0b5a63b221.camel@kernel.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 10 Aug 2023 16:24:31 -0400
Message-ID: <CAK-6q+g4LiMixBe_U7o9sVxdz9i4FjXJ2XpBW-1JzrZ3WjkRCw@mail.gmail.com>
Subject: Re: [RFC v6.5-rc2 3/3] fs: lockd: introduce safe async lock op
To:     Jeff Layton <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, teigland@redhat.com,
        cluster-devel@redhat.com, agruenba@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

On Fri, Jul 21, 2023 at 1:46=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Thu, 2023-07-20 at 08:58 -0400, Alexander Aring wrote:
> > This patch reverts mostly commit 40595cdc93ed ("nfs: block notification
> > on fs with its own ->lock") and introduces an EXPORT_OP_SAFE_ASYNC_LOCK
> > export flag to signal that the "own ->lock" implementation supports
> > async lock requests. The only main user is DLM that is used by GFS2 and
> > OCFS2 filesystem. Those implement their own lock() implementation and
> > return FILE_LOCK_DEFERRED as return value. Since commit 40595cdc93ed
> > ("nfs: block notification on fs with its own ->lock") the DLM
> > implementation were never updated. This patch should prepare for DLM
> > to set the EXPORT_OP_SAFE_ASYNC_LOCK export flag and update the DLM
> > plock implementation regarding to it.
> >
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> >  fs/lockd/svclock.c       |  5 ++---
> >  fs/nfsd/nfs4state.c      | 11 ++++++++---
> >  include/linux/exportfs.h |  1 +
> >  3 files changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > index 62ef27a69a9e..54a67bd33843 100644
> > --- a/fs/lockd/svclock.c
> > +++ b/fs/lockd/svclock.c
> > @@ -483,9 +483,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file=
 *file,
> >           struct nlm_host *host, struct nlm_lock *lock, int wait,
> >           struct nlm_cookie *cookie, int reclaim)
> >  {
> > -#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
> >       struct inode            *inode =3D nlmsvc_file_inode(file);
> > -#endif
> >       struct nlm_block        *block =3D NULL;
> >       int                     error;
> >       int                     mode;
> > @@ -499,7 +497,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file=
 *file,
> >                               (long long)lock->fl.fl_end,
> >                               wait);
> >
> > -     if (nlmsvc_file_file(file)->f_op->lock) {
> > +     if (!(inode->i_sb->s_export_op->flags & EXPORT_OP_SAFE_ASYNC_LOCK=
) &&
> > +         nlmsvc_file_file(file)->f_op->lock) {
> >               async_block =3D wait;
> >               wait =3D 0;
> >       }
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 6e61fa3acaf1..efcea229d640 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -7432,6 +7432,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> >       struct nfsd4_blocked_lock *nbl =3D NULL;
> >       struct file_lock *file_lock =3D NULL;
> >       struct file_lock *conflock =3D NULL;
> > +     struct super_block *sb;
> >       __be32 status =3D 0;
> >       int lkflg;
> >       int err;
> > @@ -7453,6 +7454,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> >               dprintk("NFSD: nfsd4_lock: permission denied!\n");
> >               return status;
> >       }
> > +     sb =3D cstate->current_fh.fh_dentry->d_sb;
> >
> >       if (lock->lk_is_new) {
> >               if (nfsd4_has_session(cstate))
> > @@ -7504,7 +7506,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> >       fp =3D lock_stp->st_stid.sc_file;
> >       switch (lock->lk_type) {
> >               case NFS4_READW_LT:
> > -                     if (nfsd4_has_session(cstate))
> > +                     if (sb->s_export_op->flags & EXPORT_OP_SAFE_ASYNC=
_LOCK &&
>
> This will break existing filesystems that don't set the new flag. Maybe
> you also need to test for the filesystem's ->lock operation here too?
>

yes.

> This might be more nicely expressed in a helper function.

ok.

- Alex

