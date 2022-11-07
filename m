Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F52F61FF78
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Nov 2022 21:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiKGUWf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Nov 2022 15:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiKGUWe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Nov 2022 15:22:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C812AE2D
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 12:22:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABD94B81619
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 20:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6369C433D6;
        Mon,  7 Nov 2022 20:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667852550;
        bh=LXUDUS4FLg9T92tQsD3msOAJc2SHYSnhSYUPJHqf2i8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=agprchSsskei8Pf9yBxuqUdanktD8bHRuPFnk1v7iRrekvfY1nuuTe6dlzL15G/fa
         x1eQFsKkczEJtwY96t0Z41QJnysxXhU7FoYRirp5bZAZL6+fffYx0cElf1xRgX5cmZ
         slEzKt7yZvyI9tj/PlrfsLK59QErMq/C74xIOlcbjD22gCWhcJC51wMc2ASIKs5o7I
         oawzZ41+aoV1Ad9cl6bEHU3waTx28CT0NRucc+z3bzYQN4SUDduz2XGQJkpbZNP2Wb
         PmGI3hNUsmFMnr0PTziq3bUwUZficl2xAAJ06znWQxuokmrZ0rF3YvoOsyQ2ZRINiJ
         rrdt6eBLvEnNg==
Message-ID: <47eaa40205fe86ca0418a4e8bed8a6ff9755571f.camel@kernel.org>
Subject: Re: [PATCH] lockd: set other missing fields when unlocking files
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Charles Edward Lever <chuck.lever@oracle.com>
Cc:     "trondmy@kernel.org" <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 07 Nov 2022 15:22:28 -0500
In-Reply-To: <3E5DCADE-432D-4CAA-88E8-DD413EDE3626@hammerspace.com>
References: <20221106190239.404803-1-trondmy@kernel.org>
         <2b5cffddf1d4d5791758e267b7184f0263519335.camel@kernel.org>
         <D25AE1CE-E8D2-4BD3-83DA-A5C3222C5E03@oracle.com>
         <3E5DCADE-432D-4CAA-88E8-DD413EDE3626@hammerspace.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-11-07 at 18:42 +0000, Trond Myklebust wrote:
>=20
> > On Nov 7, 2022, at 09:12, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
> >=20
> >=20
> >=20
> > > On Nov 7, 2022, at 5:48 AM, Jeff Layton <jlayton@kernel.org> wrote:
> > >=20
> > > On Sun, 2022-11-06 at 14:02 -0500, trondmy@kernel.org wrote:
> > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > >=20
> > > > vfs_lock_file() expects the struct file_lock to be fully initialise=
d by
> > > > the caller. Re-exported NFSv3 has been seen to Oops if the fl_file =
field
> > > > is NULL.
> > > >=20
> > > > Fixes: aec158242b87 ("lockd: set fl_owner when unlocking files")
> > > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > ---
> > > > fs/lockd/svcsubs.c | 17 ++++++++++-------
> > > > 1 file changed, 10 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> > > > index e1c4617de771..3515f17eaf3f 100644
> > > > --- a/fs/lockd/svcsubs.c
> > > > +++ b/fs/lockd/svcsubs.c
> > > > @@ -176,7 +176,7 @@ nlm_delete_file(struct nlm_file *file)
> > > > }
> > > > }
> > > >=20
> > > > -static int nlm_unlock_files(struct nlm_file *file, fl_owner_t owne=
r)
> > > > +static int nlm_unlock_files(struct nlm_file *file, const struct fi=
le_lock *fl)
> > > > {
> > > > struct file_lock lock;
> > > >=20
> > > > @@ -184,12 +184,15 @@ static int nlm_unlock_files(struct nlm_file *=
file, fl_owner_t owner)
> > > > lock.fl_type  =3D F_UNLCK;
> > > > lock.fl_start =3D 0;
> > > > lock.fl_end   =3D OFFSET_MAX;
> > > > - lock.fl_owner =3D owner;
> > > > - if (file->f_file[O_RDONLY] &&
> > > > -    vfs_lock_file(file->f_file[O_RDONLY], F_SETLK, &lock, NULL))
> > > > + lock.fl_owner =3D fl->fl_owner;
> > > > + lock.fl_pid   =3D fl->fl_pid;
> > > > + lock.fl_flags =3D FL_POSIX;
> > > > +
> > > > + lock.fl_file =3D file->f_file[O_RDONLY];
> > > > + if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, N=
ULL))
> > > > goto out_err;
> > > > - if (file->f_file[O_WRONLY] &&
> > > > -    vfs_lock_file(file->f_file[O_WRONLY], F_SETLK, &lock, NULL))
> > > > + lock.fl_file =3D file->f_file[O_WRONLY];
> > > > + if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, N=
ULL))
> > > > goto out_err;
> > > > return 0;
> > > > out_err:
> > > > @@ -226,7 +229,7 @@ nlm_traverse_locks(struct nlm_host *host, struc=
t nlm_file *file,
> > > > if (match(lockhost, host)) {
> > > >=20
> > > > spin_unlock(&flctx->flc_lock);
> > > > - if (nlm_unlock_files(file, fl->fl_owner))
> > > > + if (nlm_unlock_files(file, fl))
> > > > return 1;
> > > > goto again;
> > > > }
> > >=20
> > > Good catch.
> > >=20
> > > I wonder if we ought to roll an initializer function for file_locks t=
o
> > > make it harder for callers to miss setting some fields like this? One
> > > idea: we could change vfs_lock_file to *not* take a file argument, an=
d
> > > insist that the caller fill out fl_file when calling it? That would m=
ake
> > > it harder to screw this up.
> > >=20
> > > In any case, let's take this patch in the interim while we consider
> > > whether and how to clean this up.
> > >=20
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >=20
> > Since this doesn't fix breakage in 6.1-rc, I plan to take it for 6.2.
> > If all y'all feel the fix is more urgent than that, let me know.
>=20
>=20
> It is relevant to fixing https://bugzilla.kernel.org/show_bug.cgi?id=3D21=
6582
> No idea how urgent that is...
>

Seems like it's technically a regression then. Prior to aec158242b87,
those locks were being ignored. Now that we actually try to unlock them,
this causes a crash.

I move for sending it to mainline sooner rather than later.
--=20
Jeff Layton <jlayton@kernel.org>
