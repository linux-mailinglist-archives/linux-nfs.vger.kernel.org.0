Return-Path: <linux-nfs+bounces-21854-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EIcKS6JEWoJnQYAu9opvQ
	(envelope-from <linux-nfs+bounces-21854-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 13:02:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 291735BE9CE
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 13:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AE68302D530
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 10:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108CE385D7A;
	Sat, 23 May 2026 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZP1Gb61b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3693876A7;
	Sat, 23 May 2026 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779533758; cv=none; b=Kkjco0p4ML1L9Zg/Tzh+l5lG5aL9okWRPQnrPOuNUcjdG1bWCYZaX+/hADCebKL9r25fBBVWMGZlngO/S0UlcQkg+jEl3h26hl2uehBXDsUlFOiBhR3RnpWohoffAWiTJq6oYHoAC99byCRYyFEIfaNG7mbPUn09eEa0ytANQqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779533758; c=relaxed/simple;
	bh=FvMux4Q+qubljKjKdYexEAEpcWPS3rNDT4d2kcBZOHQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tu5Fv0bWSjldnB6Mo8eFc6zZDUCOgpe8kl9yP6trm/FsSMuYh6zPtoC5z98d6ROlJMKRMGWOfelMR44ALQUA9SheQLwGHJLkKBPmG58oI9yAApJ8q+NQNqn/Gimev63KgmhaPibaZkVljE7Vv2UUIeWXx+kuk9zytpeZTTgxwGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZP1Gb61b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553011F000E9;
	Sat, 23 May 2026 10:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779533756;
	bh=e51kdHNXyKAK8/FhvdkIzGvyPGuX+jymiccCBa72duA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZP1Gb61b9o+17HtN2vtgi1fwEgLT4++Xb2PERgoH3lR6oRQB04YrdensIgES6SsSX
	 EzRZQP7JwItNo3Rkj//rIqA9Zze87aUaXsk02bRyfiftK34ySFG4kGfr4J/2ZnHY4S
	 t8GAyPxlGZedBcIbfWXF+IQ/boxkVzbO6itF2v/LZ6z8qPekQ/29RE1Vov+b+f1JpN
	 q42H4bNsR5Lpp8pCIndJayQKawqndEweaTo1UGY1jWmy5URacifOuFj9KEf56KUzia
	 4zQuHaarbO1dIvs66AHw+YDUHPzoJLHWdiDEwv5Wtbnt+h9TUtzRShLwL3noQk/rRu
	 jbTvKv5q9LoIQ==
Message-ID: <8793ba93d173b82bd210a223a91664ee245b66dd.camel@kernel.org>
Subject: Re: [PATCH] NFSD: restart ssc_expire_umount walk after dropping
 nfsd_ssc_lock
From: Jeff Layton <jlayton@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>, Chuck Lever
	 <chuck.lever@oracle.com>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Sat, 23 May 2026 06:55:53 -0400
In-Reply-To: <20260523014107.2460863-1-michael.bommarito@gmail.com>
References: <20260523014107.2460863-1-michael.bommarito@gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21854-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 291735BE9CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-05-22 at 21:41 -0400, Michael Bommarito wrote:
> nfsd4_ssc_expire_umount() walks nn->nfsd_ssc_mount_list with
> list_for_each_entry_safe(ni, tmp, ...).  For each expired entry it
> sets nsui_busy =3D true, drops nfsd_ssc_lock to run mntput() on the
> source vfsmount, then reacquires the lock to list_del + kfree the
> entry and continue iterating via the macro's saved tmp pointer.
>=20
> The nsui_busy flag protects the current ni from concurrent
> nfsd4_ssc_setup_dul() finders during the lock-drop window, but it
> does not pin tmp.  Another nfsd RPC thread that fails its source-
> server mount and reaches nfsd4_ssc_cancel_dul() will, during that
> same window, take nfsd_ssc_lock, list_del + kfree its own ssc_umount
> item, and release the lock.  If that item is the saved tmp of the
> expire walk, the next iteration dereferences a freed
> nfsd4_ssc_umount_item.
>=20
> Reachability: triggered by any authenticated NFSv4.2 client that
> can issue OP_COPY with cna_src.nl4_type =3D NL4_SERVER to a destination
> nfsd built with CONFIG_NFSD_V4_2_INTER_SSC=3Dy and started with
> inter_copy_offload_enable=3DY.  The client chooses the source-server
> netaddr and can pick one that fails vfs_kern_mount() (unreachable,
> RST after EXCHANGE_ID, etc.) to drive nfsd4_ssc_cancel_dul() into
> the laundromat's lock-drop window.  Default Linux nfsd ships with
> inter_copy_offload_enable=3DN, so the bug is reachable only on servers
> where the administrator has explicitly opted into inter-SSC offload.
>=20
> Restart the walk from the head after the mntput() unlock window so
> no saved next pointer survives the lock-drop.  The list is bounded
> by the number of active inter-server source mounts (typically small)
> and the expire delayed-work runs periodically rather than per-IO,
> so the restart is cheap.
>=20
> Cc: stable@vger.kernel.org
> Fixes: f4e44b393389 ("NFSD: delay unmount source's export after inter-ser=
ver copy completed.")
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  fs/nfsd/nfs4state.c | 45 ++++++++++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
>=20
> Reproduced under QEMU/KVM with KASAN, three nfsd network namespaces
> on a single host so the kernel client treats them as distinct
> servers, and Linux fault injection forcing vfs_kern_mount allocations
> inside the destination nfsd to fail.  This drives nfsd4_ssc_cancel_dul
> into a tight loop concurrent with the laundromat workqueue.
>=20
> Stock kernel:
>=20
>   BUG: KASAN: slab-use-after-free in laundromat_main+0x1756/0x1be0
>   Read of size 8 at addr ffff88800ce9b200 by task kworker/u16:3
>   Workqueue: nfsd4 laundromat_main
>=20
>   Allocated by task 229:
>    nfsd4_interssc_connect+0x3f5/0xd90    (nfsd4_ssc_setup_dul, inlined)
>    nfsd4_copy+0x117d/0x1a30
>    nfsd4_proc_compound+0xbe9/0x23f0
>=20
>   Freed by task 229:
>    kfree+0x18f/0x520
>    nfsd4_interssc_connect+0xaff/0xd90    (nfsd4_ssc_cancel_dul, inlined)
>    nfsd4_copy+0x117d/0x1a30
>=20
>   The buggy address belongs to the cache kmalloc-128 of size 128.
>   Kernel panic - not syncing: Fatal exception
>=20
> Patched kernel ran the equivalent workload to completion with the
> inter-SSC code path exercised 21-22 times per run and no KASAN
> report.
>=20
> The fault-injection knobs are standard Linux testing infrastructure
> (see Documentation/fault-injection/) exercising the existing failure
> path in nfsd; no kernel source was modified.  The same primitive
> class was previously addressed by the OPEN-error path fix in
> __nfs42_ssc_open(); this patch closes the corresponding hole in
> the laundromat-driven delayed-unmount path.
>=20
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 6b9c399b89dfb..03582f15e3e7e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6728,30 +6728,37 @@ static void nfsd4_ssc_shutdown_umount(struct nfsd=
_net *nn)
>  static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
>  {
>  	bool do_wakeup =3D false;
> -	struct nfsd4_ssc_umount_item *ni =3D NULL;
> -	struct nfsd4_ssc_umount_item *tmp;
> +	struct nfsd4_ssc_umount_item *ni;
> =20
> +restart:
>  	spin_lock(&nn->nfsd_ssc_lock);
> -	list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) =
{
> -		if (time_after(jiffies, ni->nsui_expire)) {
> -			if (refcount_read(&ni->nsui_refcnt) > 1)
> -				continue;
> +	list_for_each_entry(ni, &nn->nfsd_ssc_mount_list, nsui_list) {
> +		if (!time_after(jiffies, ni->nsui_expire))
> +			break;
> +		if (refcount_read(&ni->nsui_refcnt) > 1)
> +			continue;
> =20
> -			/* mark being unmount */
> -			ni->nsui_busy =3D true;
> -			spin_unlock(&nn->nfsd_ssc_lock);
> -			mntput(ni->nsui_vfsmount);
> -			spin_lock(&nn->nfsd_ssc_lock);
> +		/* mark being unmount */
> +		ni->nsui_busy =3D true;
> +		spin_unlock(&nn->nfsd_ssc_lock);
> +		mntput(ni->nsui_vfsmount);
> +		spin_lock(&nn->nfsd_ssc_lock);
> =20
> -			/* waiters need to start from begin of list */
> -			list_del(&ni->nsui_list);
> -			kfree(ni);
> +		/* waiters need to start from begin of list */
> +		list_del(&ni->nsui_list);
> +		kfree(ni);
> =20
> -			/* wakeup ssc_connect waiters */
> -			do_wakeup =3D true;
> -			continue;
> -		}
> -		break;
> +		/* wakeup ssc_connect waiters */
> +		do_wakeup =3D true;
> +		/*
> +		 * The list_for_each_entry_safe() saved-next pointer was

Comment is a bit confusing, given that you replaced
list_for_each_entry_safe() with list_for_each_entry().

> +		 * not pinned across the spin_unlock() above: a concurrent
> +		 * nfsd4_ssc_cancel_dul() can free the next item under the
> +		 * same spinlock while mntput() runs.  Restart the walk
> +		 * from the head so no stale next is dereferenced.
> +		 */
> +		spin_unlock(&nn->nfsd_ssc_lock);
> +		goto restart;
>  	}
>  	if (do_wakeup)
>  		wake_up_all(&nn->nfsd_ssc_waitq);

The bug and patch look correct to me though.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

