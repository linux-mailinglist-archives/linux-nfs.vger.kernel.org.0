Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF266621C82
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Nov 2022 19:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiKHSvc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Nov 2022 13:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKHSvH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Nov 2022 13:51:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E531663E2
        for <linux-nfs@vger.kernel.org>; Tue,  8 Nov 2022 10:51:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37956B81C16
        for <linux-nfs@vger.kernel.org>; Tue,  8 Nov 2022 18:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709B2C433D7;
        Tue,  8 Nov 2022 18:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667933462;
        bh=z9MHswVlTpzv2dDbcvYALr9rrU6He9MIatQ3n8ASjBs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XsQSaLFuI06tyhUotnrrrqqfIvX/BxkOug2Mzk3XuoNe378L4J2jR1VlhwWLzSk0n
         6dg2blDulsC4znlW3EjnMQniWh5w1SWBjeXOtgGlLQ03ZfT6ZF22QpeUDYWzS9vc6j
         XafksxRiYs0E1bFTVWH+amxfPSRnAG8TSCPX4rdJPM5dGwfLMSxXnzGDIPIbisx/zJ
         Lz4fjcqLtRn7Bh+2bq5Tt48v/VjWpW9rJXmKsjqXF2GUin6l1Nw9hLvmdo8Tfm7V2k
         qegTtziozq6SIy5AQ9ext5QY++jd0muX3IfKfVSv8tOenYIpz/dq8dH52khHEAmFzI
         yN8aDaphWM/ng==
Message-ID: <7b6cc96e5a6758d176453e9c47146b81581a717c.camel@kernel.org>
Subject: Re: [PATCH] lockd: set other missing fields when unlocking files
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Date:   Tue, 08 Nov 2022 13:51:00 -0500
In-Reply-To: <020EC0D6-7EEE-4678-B2B7-B9F58D4EDB15@oracle.com>
References: <20221106190239.404803-1-trondmy@kernel.org>
         <2b5cffddf1d4d5791758e267b7184f0263519335.camel@kernel.org>
         <6D002058-C292-4F77-A1B7-C943B3A203C5@oracle.com>
         <B6C6DFDF-3AEC-4BAD-8810-76A47824E282@oracle.com>
         <a77a62bad91ad53fd896ba2a752e0f0cc5ced47f.camel@kernel.org>
         <020EC0D6-7EEE-4678-B2B7-B9F58D4EDB15@oracle.com>
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

On Tue, 2022-11-08 at 16:52 +0000, Chuck Lever III wrote:
>=20
> > On Nov 8, 2022, at 11:41 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Tue, 2022-11-08 at 14:57 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Nov 7, 2022, at 4:55 PM, Chuck Lever III <chuck.lever@oracle.com=
> wrote:
> > > >=20
> > > > > On Nov 7, 2022, at 5:48 AM, Jeff Layton <jlayton@kernel.org> wrot=
e:
> > > > >=20
> > > > > On Sun, 2022-11-06 at 14:02 -0500, trondmy@kernel.org wrote:
> > > > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > > >=20
> > > > > > vfs_lock_file() expects the struct file_lock to be fully initia=
lised by
> > > > > > the caller.
> > > >=20
> > > > As a reviewer, I don't see anything in the vfs_lock_file() kdoc
> > > > comment that suggests this, and vfs_lock_file() itself is just
> > > > a wrapper around each filesystem's f_ops->lock method. That
> > > > expectation is a bit deeper into NFS-specific code. A few more
> > > > observations below.
> > > >=20
> > > >=20
> > > > > > Re-exported NFSv3 has been seen to Oops if the fl_file field
> > > > > > is NULL.
> > > >=20
> > > > Needs a Link: to the bug report. Which I can add.
> > > >=20
> > > > This will also give us a call trace we can reference, so I won't
> > > > add that here.
> > > >=20
> > > >=20
> > > > > > Fixes: aec158242b87 ("lockd: set fl_owner when unlocking files"=
)
> > > > > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com=
>
> > > > > > ---
> > > > > > fs/lockd/svcsubs.c | 17 ++++++++++-------
> > > > > > 1 file changed, 10 insertions(+), 7 deletions(-)
> > > > > >=20
> > > > > > diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> > > > > > index e1c4617de771..3515f17eaf3f 100644
> > > > > > --- a/fs/lockd/svcsubs.c
> > > > > > +++ b/fs/lockd/svcsubs.c
> > > > > > @@ -176,7 +176,7 @@ nlm_delete_file(struct nlm_file *file)
> > > > > > 	}
> > > > > > }
> > > > > >=20
> > > > > > -static int nlm_unlock_files(struct nlm_file *file, fl_owner_t =
owner)
> > > > > > +static int nlm_unlock_files(struct nlm_file *file, const struc=
t file_lock *fl)
> > > > > > {
> > > > > > 	struct file_lock lock;
> > > > > >=20
> > > > > > @@ -184,12 +184,15 @@ static int nlm_unlock_files(struct nlm_fi=
le *file, fl_owner_t owner)
> > > > > > 	lock.fl_type  =3D F_UNLCK;
> > > > > > 	lock.fl_start =3D 0;
> > > > > > 	lock.fl_end   =3D OFFSET_MAX;
> > > > > > -	lock.fl_owner =3D owner;
> > > > > > -	if (file->f_file[O_RDONLY] &&
> > > > > > -	    vfs_lock_file(file->f_file[O_RDONLY], F_SETLK, &lock, NUL=
L))
> > > > > > +	lock.fl_owner =3D fl->fl_owner;
> > > > > > +	lock.fl_pid   =3D fl->fl_pid;
> > > > > > +	lock.fl_flags =3D FL_POSIX;
> > > > > > +
> > > > > > +	lock.fl_file =3D file->f_file[O_RDONLY];
> > > > > > +	if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &loc=
k, NULL))
> > > > > > 		goto out_err;
> > > > > > -	if (file->f_file[O_WRONLY] &&
> > > > > > -	    vfs_lock_file(file->f_file[O_WRONLY], F_SETLK, &lock, NUL=
L))
> > > > > > +	lock.fl_file =3D file->f_file[O_WRONLY];
> > > > > > +	if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &loc=
k, NULL))
> > > > > > 		goto out_err;
> > > > > > 	return 0;
> > > > > > out_err:
> > > > > > @@ -226,7 +229,7 @@ nlm_traverse_locks(struct nlm_host *host, s=
truct nlm_file *file,
> > > > > > 		if (match(lockhost, host)) {
> > > > > >=20
> > > > > > 			spin_unlock(&flctx->flc_lock);
> > > > > > -			if (nlm_unlock_files(file, fl->fl_owner))
> > > > > > +			if (nlm_unlock_files(file, fl))
> > > > > > 				return 1;
> > > > > > 			goto again;
> > > > > > 		}
> > > > >=20
> > > > > Good catch.
> > > > >=20
> > > > > I wonder if we ought to roll an initializer function for file_loc=
ks to
> > > > > make it harder for callers to miss setting some fields like this?=
 One
> > > > > idea: we could change vfs_lock_file to *not* take a file argument=
, and
> > > > > insist that the caller fill out fl_file when calling it? That wou=
ld make
> > > > > it harder to screw this up.
> > > >=20
> > > > Commit history shows that, at least as far back as the beginning of
> > > > the git era, the vfs_lock_file() call site here did not initialize
> > > > the fl_file field. So, this code has been working without fully
> > > > initializing @fl for, like, forever.
> > > >=20
> > > >=20
> > > > Trond later says:
> > > > > The regression occurs in 5.16, because that was when Bruce merged=
 his
> > > > > patches to enable locking when doing NFS re-exporting.
> > > >=20
> > > > That means the Fixes: tag above is misleading. The proposed patch
> > > > doesn't actually fix that commit (which went into v5.19), it simply
> > > > applies on that commit.
> > > >=20
> > > > I haven't been able to find the locking patches mentioned here. I t=
hink
> > > > those bear mentioning (by commit ID) in the patch description, at l=
east.
> > > > If you know the commit ID, Trond, can you pass it along?
> > > >=20
> > > > Though I would say that, in agreement with Jeff, the true cause of =
this
> > > > issue is the awkward synopsis for vfs_lock_file().
> > >=20
> > > Since Trond has re-assigned the kernel.org bug to me... I'll blather =
on
> > > a bit more. (Yesterday's patch is still queued up, I can replace it o=
r
> > > move it depending on the outcome of this discussion).
> > >=20
> > > -> The vfs_{test,lock,cancel}_file APIs all take a file argument. May=
be
> > > we shouldn't remove the @filp argument from vfs_lock_file().
> > >=20
> >=20
> > They all take a file_lock argument as well. @filp is redundant in all o=
f
> > them. Keeping both just increases the ambiguity. I move that we drop th=
e
> > explicit argument since we need to set it in the struct anyway.
>=20
> Sounds good to me.
>=20
>=20
> > We could also consider adding a @filp arguments to locks_alloc_lock and
> > locks_init_lock, to make it a bit more evident that it needs to be set.
> >=20
> > > -> The struct file_lock * argument of vfs_lock_file() is not a const.
> > >=20
> >=20
> > That might be tough. Even for "request" fl's we modify some fields in
> > them (for example, fl_wait and fl_blocked_member). fl_file should never
> > change though, once it has been assigned. We could potentially make tha=
t
> > const.
> >=20
> > > After auditing the call sites, I think it would be safe for vfs_lock_=
file()
> > > to explicitly overwrite the fl->fl_file field with the value of the @=
filp
> > > argument before calling f_ops->lock. At the very least, it should san=
ity-
> > > check that the two pointer values are the same, and document that as =
an
> > > API requirement.
> > >=20
> > > Alternatively we could cook up an NFS-specific fix... but the vfs_loc=
k_file
> > > API would still look dodgy.
> > >=20
> >=20
> > I see no reason to do anything NFS-specific here. I'd be fine with
> > WARN_ONs in locks.c for now, until we decide what to do longer term.
> > It's possible we have some other call chains that are not setting that
> > field correctly.
>=20
> Agreed, a WARN_ON would be a good first step.
>=20
>=20

Yep. There aren't that many callers either, so I'll plan to do a sweep
and look for any that aren't setting it now. Once I do that, I'll add
the WARN_ON to catch any I missed.

> > If we can audit all of the call sites and ensure that they are properly
> > setting fl_file in the struct, we should be able to painlessly drop the
> > separate @filp argument from all of those functions.
>=20
> The only one I found that doesn't set fl_file close to the vfs_lock_file
> call site is do_lock_file_wait().
>=20

I'll look at that. At a glance though, it looks like its callers all set
fl_file (mostly via the struct flock conversion routines). We can
probably eliminate the filp argument on that too.

>=20
> > I'll toss it onto my to-do pile.
>=20
> I'm assuming you mean you'll do the API clean-up, and that I should
> keep Trond's fix in the nfsd queue.
>=20

Yes. I'll plan to go through it here in the near future. In the
meantime, we'll still need Trond's fix for lockd.
--=20
Jeff Layton <jlayton@kernel.org>
