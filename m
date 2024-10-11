Return-Path: <linux-nfs+bounces-7094-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14A599A8B2
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 18:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD15F1C21B82
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 16:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE48839E4;
	Fri, 11 Oct 2024 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OooofFtE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04691F5FA;
	Fri, 11 Oct 2024 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728663427; cv=none; b=RrsMrn1ZiqdoFVCpW8bCXIJpLPKK2xWWoL/7KyFWcBIsZdw6Bw6SJS32C0n9kxfGCVh1FqeB4GZaGnyBQDs6aR3fqWQeEFQxpChG54hxNtkKWsYE0AmtC5yNiSyG4njeZ+NOTeyyGjL3Yoymgj5sd880sPHPKROpeKfN5/HDw2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728663427; c=relaxed/simple;
	bh=8ZVXROsgbo9fns3VYtwJXcaCrspOyCm/BW+V/pomFq0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tjrYRc6nep09EEMJ4jYHZsWF9cz5WSvy2L+ckKsSDpOW9uFHRFxiCwPDeNFZuKwUe75p3YiQQ+Dz7MrC3zOu7ppsnHRilHe+KTpJfZQ+voyMhb4RMapvzAOD8SvJuiJl6z6Y8/zUuJ1dB75WDleyJJDpBT1tJDYmmxS0QJEZBWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OooofFtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3798C4CEC3;
	Fri, 11 Oct 2024 16:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728663427;
	bh=8ZVXROsgbo9fns3VYtwJXcaCrspOyCm/BW+V/pomFq0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OooofFtEkuihYyu5yjqwgfF+fN/AFAi0d958VWJD5mVCg7CV8PsPJnLNgfR+rfgeQ
	 EDMunJX0+bOHaYxu6Plv60n3mSdvo0JjCDTVuqfrp+3GBetH7xU8ze1OyMyUvxWxMb
	 Qmjq2dSft69eZfqUJg5greS9uFDP4QheVShpTj047l8Qu5k6dYfrC2KLDOLiaO+Jk/
	 MH3PzY8BApkXlX83O1esep/zo1iqnqtKUTUH5EGSdEkP+dWZTaxoB75YKAr28hRTXK
	 7Rtkwr4czTbHOh7ZWrpox+Pqn23JI79eo1yveGIUkMyEHotVYqxGFj5Dm3uH/pnbIE
	 MKHGisw8cUrUA==
Message-ID: <f824c20c2eda23bcd98c75dc5313f0f8da5e6b84.camel@kernel.org>
Subject: Re: [PATCH 1/1] nfsd: fix race between laundromat and free_stateid
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia
	 <okorniev@redhat.com>
Cc: linux-nfs@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 11 Oct 2024 12:17:05 -0400
In-Reply-To: <Zwk4mAhnaoFe43Gy@tissot.1015granger.net>
References: <20241010221801.35462-1-okorniev@redhat.com>
	 <Zwk4mAhnaoFe43Gy@tissot.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-11 at 10:39 -0400, Chuck Lever wrote:
> On Thu, Oct 10, 2024 at 06:18:01PM -0400, Olga Kornievskaia wrote:
> > There is a race between laundromat handling of revoked delegations
> > and a client sending free_stateid operation. Laundromat thread
> > finds that delegation has expired and needs to be revoked so it
> > marks the delegation stid revoked and it puts it on a reaper list
> > but then it unlock the state lock and the actual delegation revocation
> > happens without the lock. Once the stid is marked revoked a racing
> > free_stateid processing thread does the following (1) it calls
> > list_del_init() which removes it from the reaper list and (2) frees
> > the delegation stid structure. The laundromat thread ends up not
> > calling the revoke_delegation() function for this particular delegation
> > but that means it will no release the lock lease that exists on
> > the file.
> >=20
> > Now, a new open for this file comes in and ends up finding that
> > lease list isn't empty and calls nfsd_breaker_owns_lease() which ends
> > up trying to derefence a freed delegation stateid. Leading to the
> > followint use-after-free KASAN warning:
> >=20
> > kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > kernel: BUG: KASAN: slab-use-after-free in nfsd_breaker_owns_lease+0x14=
0/0x160 [nfsd]
> > kernel: Read of size 8 at addr ffff0000e73cd0c8 by task nfsd/6205
> > kernel:
> > kernel: CPU: 2 UID: 0 PID: 6205 Comm: nfsd Kdump: loaded Not tainted 6.=
11.0-rc7+ #9
> > kernel: Hardware name: Apple Inc. Apple Virtualization Generic Platform=
, BIOS 2069.0.0.0.0 08/03/2024
> > kernel: Call trace:
> > kernel: dump_backtrace+0x98/0x120
> > kernel: show_stack+0x1c/0x30
> > kernel: dump_stack_lvl+0x80/0xe8
> > kernel: print_address_description.constprop.0+0x84/0x390
> > kernel: print_report+0xa4/0x268
> > kernel: kasan_report+0xb4/0xf8
> > kernel: __asan_report_load8_noabort+0x1c/0x28
> > kernel: nfsd_breaker_owns_lease+0x140/0x160 [nfsd]
> > kernel: leases_conflict+0x68/0x370
> > kernel: __break_lease+0x204/0xc38
> > kernel: nfsd_open_break_lease+0x8c/0xf0 [nfsd]
> > kernel: nfsd_file_do_acquire+0xb3c/0x11d0 [nfsd]
> > kernel: nfsd_file_acquire_opened+0x84/0x110 [nfsd]
> > kernel: nfs4_get_vfs_file+0x634/0x958 [nfsd]
> > kernel: nfsd4_process_open2+0xa40/0x1a40 [nfsd]
> > kernel: nfsd4_open+0xa08/0xe80 [nfsd]
> > kernel: nfsd4_proc_compound+0xb8c/0x2130 [nfsd]
> > kernel: nfsd_dispatch+0x22c/0x718 [nfsd]
> > kernel: svc_process_common+0x8e8/0x1960 [sunrpc]
> > kernel: svc_process+0x3d4/0x7e0 [sunrpc]
> > kernel: svc_handle_xprt+0x828/0xe10 [sunrpc]
> > kernel: svc_recv+0x2cc/0x6a8 [sunrpc]
> > kernel: nfsd+0x270/0x400 [nfsd]
> > kernel: kthread+0x288/0x310
> > kernel: ret_from_fork+0x10/0x20
> >=20
> > Proposing to have laundromat thread hold the state_lock over both
> > marking thru revoking the delegation as well as making free_stateid
> > acquire state_lock before accessing the list. Making sure that
> > revoke_delegation() (ie kernel_setlease(unlock)) is called for
> > every delegation that was revoked and added to the reaper list.
> >=20
> > CC: stable@vger.kernel.org
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> >=20
> > --- I can't figure out the Fixes: tag. Laundromat's behaviour has
> > been like that forever. But the free_stateid bits wont apply before
> > the 1e3577a4521e ("SUNRPC: discard sv_refcnt, and svc_get/svc_put").
> > But we used that fixes tag already with a previous fix for a different
> > problem.
> > ---
> >  fs/nfsd/nfs4state.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 9c2b1d251ab3..c97907d7fb38 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -6605,13 +6605,13 @@ nfs4_laundromat(struct nfsd_net *nn)
> >  		unhash_delegation_locked(dp, SC_STATUS_REVOKED);
> >  		list_add(&dp->dl_recall_lru, &reaplist);
> >  	}
> > -	spin_unlock(&state_lock);
> >  	while (!list_empty(&reaplist)) {
> >  		dp =3D list_first_entry(&reaplist, struct nfs4_delegation,
> >  					dl_recall_lru);
> >  		list_del_init(&dp->dl_recall_lru);
> >  		revoke_delegation(dp);
> >  	}
> > +	spin_unlock(&state_lock);
>=20
> Code review suggests revoke_delegation() (and in particular,
> destroy_unhashed_deleg(), must not be called while holding
> state_lock().
>

We'd be calling nfs4_unlock_deleg_lease with a spinlock held, which is
sort of gross.

That said, I don't love this fix either.

>=20
> >  	spin_lock(&nn->client_lock);
> >  	while (!list_empty(&nn->close_lru)) {
> > @@ -7213,7 +7213,9 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct=
 nfsd4_compound_state *cstate,
> >  		if (s->sc_status & SC_STATUS_REVOKED) {
> >  			spin_unlock(&s->sc_lock);
> >  			dp =3D delegstateid(s);
> > +			spin_lock(&state_lock);
> >  			list_del_init(&dp->dl_recall_lru);
> > +			spin_unlock(&state_lock);
>=20
> Existing code is inconsistent about how manipulation of
> dl_recall_lru is protected. Most instances do use state_lock for
> this purpose, but a few, including this one, use cl->cl_lock. Does
> the other instance using cl_lock need review and correction as well?
>=20
> I'd prefer to see this fix make the protection of dl_recall_lru
> consistent everywhere.
>=20

Agreed. The locking around the delegation handling has been a mess for
a long time. I'd really like to have a way to fix this that didn't
require having to rework all of this code however.

How about something like this patch instead? Olga, thoughts?


[PATCH] nfsd: add new SC_STATUS_FREEABLE to prevent race with  FREE_STATEID

Olga identified a race between the laundromat and FREE_STATEID handling.
The crux of the problem is that free_stateid can proceed while the
laundromat is still processing the revocation.

Add a new SC_STATUS_FREEABLE flag that is set once the revocation is
complete. Have nfsd4_free_stateid only consider delegations that have
this flag set.

Reported-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 3 ++-
 fs/nfsd/state.h     | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 73c4b983c048..b71a2cc7f2dd 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1371,6 +1371,7 @@ static void revoke_delegation(struct nfs4_delegation =
*dp)
 		spin_lock(&clp->cl_lock);
 		refcount_inc(&dp->dl_stid.sc_count);
 		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
+		dp->dl_stid.sc_status |=3D SC_STATUS_FREEABLE;
 		spin_unlock(&clp->cl_lock);
 	}
 	destroy_unhashed_deleg(dp);
@@ -7207,7 +7208,7 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfs=
d4_compound_state *cstate,
 	spin_lock(&s->sc_lock);
 	switch (s->sc_type) {
 	case SC_TYPE_DELEG:
-		if (s->sc_status & SC_STATUS_REVOKED) {
+		if (s->sc_status & SC_STATUS_FREEABLE) {
 			spin_unlock(&s->sc_lock);
 			dp =3D delegstateid(s);
 			list_del_init(&dp->dl_recall_lru);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 874fcab2b183..4f3b941b09d3 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -114,6 +114,7 @@ struct nfs4_stid {
 /* For a deleg stateid kept around only to process free_stateid's: */
 #define SC_STATUS_REVOKED	BIT(1)
 #define SC_STATUS_ADMIN_REVOKED	BIT(2)
+#define SC_STATUS_FREEABLE	BIT(3)
 	unsigned short		sc_status;
=20
 	struct list_head	sc_cp_list;
--=20
2.47.0


