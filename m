Return-Path: <linux-nfs+bounces-11030-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA19AA7E595
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Apr 2025 18:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F96189A2B9
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Apr 2025 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85745204F8E;
	Mon,  7 Apr 2025 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzWsFdVD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDEB204C11
	for <linux-nfs@vger.kernel.org>; Mon,  7 Apr 2025 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041424; cv=none; b=OWZ8kxefUIvJFx64kbPpWqpe4EotVmskltKaHAcI4620iJI2eCCTF3yKuQuO6Nm2ICEFXoP4dbZidXqQ4FHxdLVHQakIdw4I+VkpBlEDIm5SsZxEoAiO7ZuuqUsuyKvf/gfCN5a5Zu5XVuQHXy7fJ3t060A7tRajm2AThXkHUP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041424; c=relaxed/simple;
	bh=GvnLxFVCucpFq9ze4iFhmBcV0Haop3zYLf33h+/SyU0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dmtDWmGi5lIp8twMRcMhGX/en4MhnaDrzVjuOJHeZ/V22VXze0q348BzqjrAESzVKMoVWNvJdQestoGz2HatN0TPtadGLTSwX1BStumiSTvCJZtM+dxIqUVvaGQ/pqk8mgJ28U7xe+mNRHyU+ILDO8Xok8JndpQi96oTeNsZwRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzWsFdVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D76CC4CEDD;
	Mon,  7 Apr 2025 15:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744041424;
	bh=GvnLxFVCucpFq9ze4iFhmBcV0Haop3zYLf33h+/SyU0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VzWsFdVDt9EM/03/PUcFSKet4phtM15k8EoTCI2PzxPQIjqvIvxt/Zc7piD1Pns7y
	 DeBwA856q5x81yBA+YYJD0kcAmA5CXo6j0KMRj9PdJ0WZ6jh+EwtDpuU6wyDCYJxGu
	 awR+IS1tbSv1kfCoFEpiY5wNyT/sCHBNwK1rQzvHc299JNTTpdKY3m2BYg6GxvH+Sq
	 ECNTcuxUlcEepblj5YJ7RWjzdWRhb/NMK7IIFYwMLHRUcSAVmLoh693WWx92xQXfH0
	 HllD1SFZi1oPJx7ZrfVxvIb7ZyU/1HnvzFADVcA76RTI4LqeEqYMkmP0nUONfjEhHc
	 0yMGJ8ZuIiAcg==
Message-ID: <05336ea7be56be78db853a811bf740ff0d3ab1df.camel@kernel.org>
Subject: Re: [PATCH 3/3] nfsd: reset access mask for NLM calls in
 nfsd_permission
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, 
	linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com
Date: Mon, 07 Apr 2025 11:57:02 -0400
In-Reply-To: <174319880848.9342.18353626790561074601@noble.neil.brown.name>
References: <>
	, <CAN-5tyHKrbL9DuFxvH6hnL4uwHDZ-d49X8DFBVReCvdh+Qh0XQ@mail.gmail.com>
	 <174319880848.9342.18353626790561074601@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-03-29 at 08:53 +1100, NeilBrown wrote:
> On Sat, 29 Mar 2025, Olga Kornievskaia wrote:
> > On Thu, Mar 27, 2025 at 9:43=E2=80=AFPM NeilBrown <neilb@suse.de> wrote=
:
> > >=20
> > > On Fri, 28 Mar 2025, Olga Kornievskaia wrote:
> > > > On Thu, Mar 27, 2025 at 7:54=E2=80=AFPM NeilBrown <neilb@suse.de> w=
rote:
> > > > >=20
> > > > > On Sat, 22 Mar 2025, Olga Kornievskaia wrote:
> > > > > > NLM locking calls need to pass thru file permission checking
> > > > > > and for that prior to calling inode_permission() we need
> > > > > > to set appropriate access mask.
> > > > > >=20
> > > > > > Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
> > > > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > > > ---
> > > > > >  fs/nfsd/vfs.c | 7 +++++++
> > > > > >  1 file changed, 7 insertions(+)
> > > > > >=20
> > > > > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > > > index 4021b047eb18..7928ae21509f 100644
> > > > > > --- a/fs/nfsd/vfs.c
> > > > > > +++ b/fs/nfsd/vfs.c
> > > > > > @@ -2582,6 +2582,13 @@ nfsd_permission(struct svc_cred *cred, s=
truct svc_export *exp,
> > > > > >       if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
> > > > > >               return nfserr_perm;
> > > > > >=20
> > > > > > +     /*
> > > > > > +      * For the purpose of permission checking of NLM requests=
,
> > > > > > +      * the locker must have READ access or own the file
> > > > > > +      */
> > > > > > +     if (acc & NFSD_MAY_NLM)
> > > > > > +             acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
> > > > > > +
> > > > >=20
> > > > > I don't agree with this change.
> > > > > The only time that NFSD_MAY_NLM is set, NFSD_MAY_OWNER_OVERRIDE i=
s also
> > > > > set.  So that part of the change adds no value.
> > > > >=20
> > > > > This change only affects the case where a write lock is being req=
uested.
> > > > > In that case acc will contains NFSD_MAY_WRITE but not NFSD_MAY_RE=
AD.
> > > > > This change will set NFSD_MAY_READ.  Is that really needed?
> > > > >=20
> > > > > Can you please describe the particular problem you saw that is fi=
xed by
> > > > > this patch?  If there is a problem and we do need to add NFSD_MAY=
_READ,
> > > > > then I would rather it were done in nlm_fopen().
> > > >=20
> > > > set export policy with (sec=3Dkrb5:...) then mount with sec=3Dkrb5,=
vers=3D3,
> > > > then ask for an exclusive flock(), it would fail.
> > > >=20
> > > > The reason it fails is because nlm_fopen() translates lock to open
> > > > with WRITE. Prior to patch 4cc9b9f2bf4d, the access would be set to
> > > > acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE; before calling int=
o
> > > > inode_permission(). The patch changed it and lead to lock no longer
> > > > being given out with sec=3Dkrb5 policy.
> > >=20
> > > And do you have WRITE access to the file?
> > >=20
> > > check_fmode_for_setlk() in fs/locks.c suggests that for F_WRLCK to be
> > > granted the file must be open for FMODE_WRITE.
> > > So when an exclusive lock request arrives via NLM, nlm_lookup_file()
> > > calls nlm_do_fopen() with a mode of O_WRONLY and that causes
> > > nfsd_permission() to check that the caller has write access to the fi=
le.
> > >=20
> > > So if you are trying to get an exclusive lock to a file that you don'=
t
> > > have write access to, then it should fail.
> > > If, however, you do have write access to the file - I cannot see why
> > > asking for NFSD_MAY_READ instead of NFSD_MAY_WRITE would help.
> >=20
> > That's correct, the user doing flock() does NOT have write access to
> > the file. Yet prior to the 4cc9b9f2bf4d, that access was allowed. If
> > that was a bug then my bad. I assumed it was regression.
> >=20
> > It's interesting to me that on an XFS file system, I can create a file
> > owned by root (on a local filesystem) and then request an exclusive
> > lock on it (as a user -- no write permissions).
>=20
> "flock" is the missing piece.  I always thought it was a little odd
> implementing flock locks over NFS using byte-range locking.  Not
> necessarily wrong, but definitely odd.
>=20

FWIW, Solaris set the precedent for that, and the NFS client eventually
added it (back in the v2.4 days).

> The man page for fcntl says=20
>=20
>    In order to place a read lock, fd must be open for reading.  In order
>    to place a write lock, fd must be open for writing.  To place both
>    types of lock, open a file read-write.
>=20
> So byte-range locks require a consistent open mode.
>=20
> The man page for flock says
>=20
>     A shared or exclusive lock can be placed on a file regardless of the
>     mode in which the file was opened.
>=20
> Since the NFS client started using NLM (or v4 LOCK) for flock requests,
> we cannot know if a request is flock or fcntl so we cannot check the
> "correct" permissions.  We have to rely on the client doing the
> permission checking.

> So it isn't really correct to check for either READ or WRITE.
>=20
> This is awkward because nfsd doesn't just check permissions.  It has to
> open the file and say what mode it is opening for.  This is apparently
> important when re-exporting NFS according to
>=20
> Commit: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
>=20
> So if you try an exclusive flock on a re-exported NFS file (reexported
> over v3) that you have open for READ but do not have write permission
> for, then the client will allow it, but the intermediate server will try
> a O_WRITE open which the final server will reject.
> (does re-export work over v3??)
>=20

Locking with reexports is an iffy proposition at best. We don't have a
way to "project" the grace period across the reexport, so if the
reexporting server crashes, lock recovery is just broken (no grace
period on the source server).

This is detailed in Documentation/filesystems/nfs/reexport.rst

I wouldn't worry overmuch about reexporting with this.

> There is no way to make this "work".  As I said: sending flock requests
> over NFS was an interesting choice.
> For v4 re-export it isn't a problem because the intermediate server
> knows what mode the file was opened for on the client.
>=20
> So what do we do?  Whatever we do needs a comment explaining that flock
> vs fcntl is the problem.
> Possibly we should not require read or write access - and just trust the
> client.  Alternately we could stick with the current practice of
> requiring READ but not WRITE - it would be rare to lock a file which you
> don't have read access to.
>=20
> So yes: we do need a patch here.  I would suggest something like:
>=20
>  /* An NLM request may be from fcntl() which requires the open mode to
>   * match to lock mode or may be from flock() which allows any lock mode
>   * with any open mode.  "acc" here indicates the lock mode but we must
>   * do permission check reflecting the open mode which we cannot know.
>   * For simplicity and historical continuity, always only check for
>   * READ access
>   */
>  if (acc & NFSD_MAY_NLM)
> 	acc =3D (acc & ~NFSD_MAY_WRITE) | NFSD_MAY_READ;
>=20
> I'd prefer to leave the MAY_OWNER_OVERRIDE setting in nlm_fopen().
>=20

Emulating flock locks over NFS locking is entirely a client-side
endeavor. The server isn't aware of it. The job on the server side is
to conform to the protocol.

In this case, I think failing exclusive flock() locks when the client
doesn't have the file open for write is the correct thing to do, as I
think the protocol requires this.

At one time, nfs_flock would reject those on the client, until this
patch reverted that behavior:

    fcfa447062b2 NFS: Revert "NFS: Move the flock open mode check into nfs_=
flock()"

I'm not sure that reverting that was the correct thing to do. NFS/NLM
locking generally follows fcntl() semantics. ISTM that we shouldn't
allow locks that fall outside of those semantics.
--=20
Jeff Layton <jlayton@kernel.org>

