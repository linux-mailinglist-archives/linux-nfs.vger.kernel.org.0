Return-Path: <linux-nfs+bounces-22853-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iQPGFf8BPmrc+QgAu9opvQ
	(envelope-from <linux-nfs+bounces-22853-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 06:37:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEBD6CA21C
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 06:37:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=ExrsdeHy;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="D MjB7mY";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22853-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22853-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FA54300F9C8
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 04:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BB82FFDD5;
	Fri, 26 Jun 2026 04:37:16 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB45211A14;
	Fri, 26 Jun 2026 04:37:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782448636; cv=none; b=BCkBNpFhFyokWLN1Wg2J68wiEgp4zDYuDc3qPkx1S35DNvTeNH8d6AkV231Q4SLv92StsKycaSb+aXcJ7lQkQ23s0ELq3txuluIj7P2IyanEJ/G2bttYXcFVZSRsXiPJJeUaomhv6+m/ic5UlRf+BLSlOQu3XJpY2auhX+bZLQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782448636; c=relaxed/simple;
	bh=Cx/nlCpab6lMYFUE0kbEifTAuWnlZ+2GfqCivj50XE8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=LUXoGCpaaT5NUBVYsXml5yzvlzbrhqtpWAUrFKE801X0PtPJvshOXdG1nGxt5j6BOdE9nt3Od4qXTFApeHT57JKWSGl7+Wqd8PvmyZRUxAn+j4k290EK26IGNj+xrQKNf3Sp5JmzCv+r7aHBwFlrYpmvehcCSG1JPDrQsf1mdb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ExrsdeHy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DMjB7mYQ; arc=none smtp.client-ip=202.12.124.150
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B2E41D00078;
	Fri, 26 Jun 2026 00:37:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 26 Jun 2026 00:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1782448633; x=1782535033; bh=BlJMW1hWnqj431xgT0YvsxlifWPJOTSQm0z
	rnxihJcs=; b=ExrsdeHy6LAaMiS+NX6Pden2ykJmfYHz602kFx9z0fxxtlaoj6V
	tu0LZ0Xgu3SWIAMjT/RpOGcmjIepR8OaK3wnzgkomJgteGii6KrufrfXP2cipbjJ
	+t4FjieIuukixmMdnBMIlmcTAFykEP/OB3/GLu1HUoH7e1jsHj+bYk48Zr68ugZf
	jkWoEsOEAFPRZ7MZmoEF3aWqB7kTDHHlsuqsLf5WVsijG+61CAN0RUPLKc9uoKXh
	b2qZdjgsKIJi3yRWjjwYk9Ce2ErZoHgUipafuthcX81Ai0gL6zCoEBT9RQd1ASam
	N+6ThXbut9KVinQRhgQcrBca80+Wp7eh6DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782448633; x=
	1782535033; bh=BlJMW1hWnqj431xgT0YvsxlifWPJOTSQm0zrnxihJcs=; b=D
	MjB7mYQUNyfMHQT+igVmXDrpQwtiqObqHtlLknfFsydC1BJg6xuKzpdZt6FKimYK
	AK73Iy3uIajAfFPI4m4HP3hSX46SAanZXDwe9hUXs43rQeAoPd3tTf8hScki9H1S
	gJipfr94ZdVcW8v6pfVzg4RnvhCFpTZvweusmzVxmBNX/rVYSj5zs3Dm7JAefy0Z
	FUJOnnKmxJAA5Tlj4KagY9MfRwfmD7lNYjTelm95gCfyHRfEbdIGMXH6YKQInbnv
	CNQc6WLB2LBwy/C6nteeWc8zNAETkfXV7C2jZVC+DwaGmmMXQgfbRKMQBfqHHAuX
	EIQrcoiXNHTBM95vlShQw==
X-ME-Sender: <xms:-AE-aghbi60AJiAl9wbFMwa_Wgvl7ovI3JJqapqTUUi7z2XZ0yGZ3g>
    <xme:-AE-at-nCwFvrwGx0BVOK4RoXHyJ9mhwlTOasz9KQIIoYnHQnPmLxHPVz7z6xEQ3r
    5LrBjcpK7CKAE9e2oTC4xF0Zh1F9yVEnVx2FgxgsbjSDn-yJg>
X-ME-Received: <xmr:-AE-asUD3Y-QA9WQnlE-J7Ti_kuyYDhNaCsinFT80lxJC9HdOwWD0PcKwHEnRJFP12T3E6uFZqyLjwabcFgLTtIYwmZVOHo>
X-ME-Proxy-Cause: dmFkZTE4mf0ZrvrXXte6uw1+ahvXjvr0yLvFXy/i+7D9KhEVHNhPG1BjRU72zfdb+0MaGJ
    4zIHQMoB8WnoxYGog0I3ItfjvMhVSoYbnDYpau4rqKa6kbXyBgEnsgsugm3axxkhjdmq6t
    cPU0KggxumSgGOSnKHd3xdfEzEI/3gKY7pyxnKPtghthFC55hN2nzaEDs4T9BDfKg9as9n
    43dE5EdFsTr6TmhqmMzTf+t6tOWrCp45uQgOGaXoeBiDOvWczEUGLv+gHocWvAuK/ACaNj
    OFOdrCya0PkOyJHxNdm6Jjjvt63bUz6iHuKNg/qtMGVkgl7Zsqasvp2lBCwIAqBxR+LOZi
    xE6JGOZQnka8wMRQhpJ9HyIJTXqskxIw1Ma3o9i4k4eoQ2Sh2mxAKsPa4CXDaPbBzjDjuN
    K+6g7+uHayFSQtt/+ciMPhDgDndJB4bD58f1tj9MfmvdWzcHFMq+b2MniYFNImqYC5nZBY
    dbPEwa8Rt0P/AFGVlyLv0232+P2vfW1/5WXJKQO3YDgDtR5TZwldHI+U86wgre2I7qtfPh
    bf9TKdETXgJ8tDm77WPhOYuXA5KAL0iLE+5LRJg56kf/LUlNkyh1S1d9qLx7viMBSb5T+F
    ZcTHSbfR9aeJwuKMaVoa1t7hD8Arh7CYqWMOZIbY74FMYfuoQS5wgKIDWc2Q
X-ME-Proxy: <xmx:-AE-ahBPuzNelUwT4Z9jK8wXwMdQ3dE-obJA9xTzZO7n_MvOmxPeIQ>
    <xmx:-AE-ahEGkNsID5pycAP00Ogehh-I3H5n7RXeDzo5HCMjbLzR5v6wow>
    <xmx:-AE-ai7CPa9GMIPkn5eK2NmcGJt_HTxnVfiI_gIfeTP0sLLDcmOh0Q>
    <xmx:-AE-ank6z3MW81ChUgojI16tpE9LT7x0pWhphAetPz9uzCGiMopSDg>
    <xmx:-QE-ahrKNZ-cxjZ1NQ73pfMsJzS8wl8O-w8yr16PoKQGufk2MVUitotm>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 00:37:09 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <cel@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Andy Adamson" <andros@netapp.com>, "Chris Mason" <clm@meta.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH 3/3] nfsd: fix UAF in async copy cancel and shutdown
In-reply-to: <20260624-nfsd-testing-v1-3-b8853eb22e45@kernel.org>
References: <20260624-nfsd-testing-v1-0-b8853eb22e45@kernel.org>
  <20260624-nfsd-testing-v1-3-b8853eb22e45@kernel.org>
Date: Fri, 26 Jun 2026 14:37:05 +1000
Message-id: <178244862502.27465.12595193014671957687@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22853-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:cel@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:andros@netapp.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,vger.kernel.org:from_smtp,brown.name:replyto,ownmail.net:dkim,ownmail.net:from_mime,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DEBD6CA21C

On Thu, 25 Jun 2026, Jeff Layton wrote:
> find_async_copy() bumps copy->refcount under clp->async_lock but
> leaves the copy on clp->async_copies, violating the precondition of
> nfsd4_stop_copy(). The async copy reaper walks clp->async_copies,
> moves OFFLOAD_DONE copies to a private reaplist, then calls
> cleanup_async_copy() outside the lock, racing the cancel path:
>=20
>     CPU 0 (OFFLOAD_CANCEL)         CPU 1 (reaper)
>     -----                          -----
>     find_async_copy()
>       refcount_inc(&copy->refcount)
>       /* copy still on async_copies */
>                                    spin_lock(&clp->async_lock)
>                                    move copy to reaplist
>                                    spin_unlock(&clp->async_lock)
>     nfsd4_stop_copy(copy)
>       release_copy_files(copy)
>         nfsd_file_put(nf_src)
>                                    cleanup_async_copy(copy)
>                                      release_copy_files(copy)
>                                        nfsd_file_put(nf_src)
>                                        /* double put -> UAF */
>=20
> release_copy_files() reads, puts, then NULLs nf_src/nf_dst, but the
> two callers hold no common lock, so both can observe a non-NULL
> pointer and each call nfsd_file_put() on the same struct nfsd_file.
> That decrements nf_ref twice; nfsd_file_slab is created with
> KMEM_CACHE(nfsd_file, 0) (no SLAB_TYPESAFE_BY_RCU), so the premature
> free leads to a use-after-free of the filecache object.
>=20
> Unlinking the copy in find_async_copy() exposes a second hazard.
> nfsd4_stop_copy() only joins via kthread_stop() when the teardown
> caller wins test_and_set_bit(NFSD4_COPY_F_STOPPED). If the kthread
> sets the bit first, kthread_stop() is skipped and the teardown
> caller's nfs4_put_copy() can free copy while the kthread runs on:
>=20
>     CPU 0 (teardown)               CPU 1 (copy kthread)
>     -----                          -----
>                                    set_bit(STOPPED, &cp_flags)
>                                    set_bit(COMPLETED, &cp_flags)
>     nfsd4_stop_copy(copy)
>       test_and_set_bit(STOPPED)
>         /* returns 1, skip stop */
>       release_copy_files(copy)
>       nfs4_put_copy(copy) /* 1->0 */
>       kfree(copy)
>                                    nfsd4_send_cb_offload(copy)
>                                    /* UAF */
>=20
> In find_async_copy(), after refcount_inc() under async_lock, clear
> copy->cp_clp and list_del_init(&copy->copies), mirroring
> nfsd4_unhash_copy() so the reaper can no longer observe the copy.
> nfsd4_offload_cancel(), nfsd4_shutdown_copy(), and
> nfsd4_cancel_copy_by_sb() then call nfs4_put_copy() after
> nfsd4_stop_copy() to release the list-membership reference the
> reaper previously dropped via cleanup_async_copy(). Because the copy
> is always unlinked before cleanup_async_copy() now runs, drop the
> list_del fixup (and the cp_clp deref) from cleanup_async_copy().
>=20
> Give the kthread its own reference: refcount_inc() in nfsd4_copy()
> before wake_up_process(), paired with nfs4_put_copy() as the final
> act of nfsd4_do_async_copy(). Call wake_up_process() before
> list_add() so the publisher has no use of async_copy after
> spin_unlock; a concurrent find_async_copy() + nfsd4_stop_copy() can
> then drain all references safely.
>=20
> Pair the cp_clp writers (find_async_copy(), nfsd4_unhash_copy())
> with smp_load_acquire() in nfsd4_send_cb_offload(). set_bit() and
> clear_bit() are unordered atomics per
> Documentation/atomic_bitops.rst and provide no ordering fence, so
> a plain load of cp_clp could be reordered past the subsequent clp
> dereference on weakly-ordered hardware. smp_load_acquire() supplies
> the required barrier.

This patch seems to make two changes.
One involves extra refcount on the "copy" structure, which is probably
sensible but hard for me to follow because the patch is so noisy.

The other is barriers around assignment of ->cp_clp which doesn't make
any sense to me at all, and the copious comments don't help with.
A barrier is always between two things.  Maybe we assign NULL to
something before testing something else, or maybe we test something
before an assignment.  The comments should make clear what the something
else is.  They don't (at least not to me).

I would rather two patches with less noise and more useful comments.

Thanks,
NeilBrown


>=20
> Fixes: ac0514f4d198 ("NFSD: Add a laundromat reaper for async copy state")
> Assisted-by: kres:claude-opus-4-8
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4proc.c | 100 +++++++++++++++++++++++++++++++++++++++++++------=
----
>  1 file changed, 81 insertions(+), 19 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 669896be08b6..a16a33d0ed00 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1536,11 +1536,10 @@ static void nfsd4_stop_copy(struct nfsd4_copy *copy)
>  	}
> =20
>  	/*
> -	 * The copy was removed from async_copies before this function
> -	 * was called, so the reaper cannot clean it up. Release files
> -	 * here regardless of who won the STOPPED race. If the thread
> -	 * set STOPPED, it has finished using the files. If STOPPED
> -	 * was set here, kthread_stop() waited for the thread to exit.
> +	 * Caller has already removed the copy from clp->async_copies, so
> +	 * the reaper cannot reach it. Release files regardless of who won
> +	 * STOPPED; if STOPPED was set here, kthread_stop() joined the
> +	 * kthread.
>  	 */
>  	release_copy_files(copy);
>  	nfs4_put_copy(copy);
> @@ -1555,7 +1554,11 @@ static struct nfsd4_copy *nfsd4_unhash_copy(struct n=
fs4_client *clp)
>  		copy =3D list_first_entry(&clp->async_copies, struct nfsd4_copy,
>  					copies);
>  		refcount_inc(&copy->refcount);
> -		copy->cp_clp =3D NULL;
> +		/*
> +		 * Pairs with smp_load_acquire in nfsd4_send_cb_offload();
> +		 * see find_async_copy() for rationale.
> +		 */
> +		smp_store_release(&copy->cp_clp, NULL);
>  		if (!list_empty(&copy->copies))
>  			list_del_init(&copy->copies);
>  	}
> @@ -1567,8 +1570,16 @@ void nfsd4_shutdown_copy(struct nfs4_client *clp)
>  {
>  	struct nfsd4_copy *copy;
> =20
> -	while ((copy =3D nfsd4_unhash_copy(clp)) !=3D NULL)
> +	while ((copy =3D nfsd4_unhash_copy(clp)) !=3D NULL) {
>  		nfsd4_stop_copy(copy);
> +		/*
> +		 * nfsd4_unhash_copy() removed the copy from
> +		 * clp->async_copies and cleared cp_clp, so the reaper
> +		 * can no longer reach it and drop the list-membership
> +		 * reference via cleanup_async_copy(). Drop it here.
> +		 */
> +		nfs4_put_copy(copy);
> +	}
>  }
> =20
>  static bool nfsd4_copy_on_sb(const struct nfsd4_copy *copy,
> @@ -1637,6 +1648,14 @@ void nfsd4_cancel_copy_by_sb(struct net *net, struct=
 super_block *sb)
> =20
>  		list_del_init(&copy->copies);
>  		nfsd4_stop_copy(copy);
> +		/*
> +		 * The copy was moved off clp->async_copies under
> +		 * async_lock above, so the reaper can no longer reach
> +		 * it and drop the list-membership reference via
> +		 * cleanup_async_copy(). Drop it here, mirroring
> +		 * nfsd4_offload_cancel() and nfsd4_shutdown_copy().
> +		 */
> +		nfs4_put_copy(copy);
>  		nfsd4_put_client(clp);
>  	}
>  }
> @@ -2062,28 +2081,38 @@ static void release_copy_files(struct nfsd4_copy *c=
opy)
>  	}
>  }
> =20
> +/*
> + * Called from the async copy reaper (after unlinking from async_copies
> + * under async_lock) and from nfsd4_copy()'s out_err path (where the copy
> + * was never list_add'd). In both cases the copy is unreachable from
> + * clp->async_copies.
> + */
>  static void cleanup_async_copy(struct nfsd4_copy *copy)
>  {
>  	nfs4_free_copy_state(copy);
>  	release_copy_files(copy);
> -	if (copy->cp_clp) {
> -		spin_lock(&copy->cp_clp->async_lock);
> -		if (!list_empty(&copy->copies))
> -			list_del_init(&copy->copies);
> -		spin_unlock(&copy->cp_clp->async_lock);
> -	}
>  	nfs4_put_copy(copy);
>  }
> =20
>  static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
>  {
>  	struct nfsd4_cb_offload *cbo =3D &copy->cp_cb_offload;
> -	struct nfs4_client *clp =3D copy->cp_clp;
> +	struct nfs4_client *clp;
> =20
>  	/*
> -	 * cp_clp is NULL when called via nfsd4_shutdown_copy() during
> -	 * client destruction. Skip the callback; the client is gone.
> +	 * Pairs with smp_store_release(&copy->cp_clp) in find_async_copy()
> +	 * and nfsd4_unhash_copy(). set_bit/clear_bit are unordered atomics
> +	 * (Documentation/atomic_bitops.rst), so the acquire is needed to
> +	 * prevent the cp_clp load being reordered past the clp dereference
> +	 * below on weakly-ordered hardware. The kthread holds its own
> +	 * reference across this call (taken before wake_up_process in
> +	 * nfsd4_copy()); see commit log for per-path client lifetime.
> +	 *
> +	 * cp_clp is NULL when the copy was canceled (find_async_copy,
> +	 * nfsd4_unhash_copy) before the kthread reached this point. Skip
> +	 * the callback; the canceling path owns the notification.
>  	 */
> +	clp =3D smp_load_acquire(&copy->cp_clp);
>  	if (!clp) {
>  		set_bit(NFSD4_COPY_F_OFFLOAD_DONE, &copy->cp_flags);
>  		return;
> @@ -2160,6 +2189,13 @@ static int nfsd4_do_async_copy(void *data)
>  	if (copy->cp_res.wr_bytes_written > 0 && copy->attr_update)
>  		nfsd_update_cmtime_attr(copy->nf_dst->nf_file, 0);
>  	nfsd4_send_cb_offload(copy);
> +	/*
> +	 * Drop the kthread's own reference (taken before
> +	 * wake_up_process() in nfsd4_copy()). After this point, copy
> +	 * may be freed by a concurrent teardown caller's pending
> +	 * nfs4_put_copy().
> +	 */
> +	nfs4_put_copy(copy);
>  	return 0;
>  }
> =20
> @@ -2229,11 +2265,18 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
>  				async_copy, "%s", "copy thread");
>  		if (IS_ERR(async_copy->copy_task))
>  			goto out_dec_async_copy_err;
> +		/*
> +		 * Take the kthread's reference and wake it before publishing
> +		 * on async_copies, so the publisher does not touch async_copy
> +		 * after spin_unlock and a concurrent teardown caller can drain
> +		 * all remaining references safely. See commit log for details.
> +		 */
> +		refcount_inc(&async_copy->refcount);
> +		wake_up_process(async_copy->copy_task);
>  		spin_lock(&async_copy->cp_clp->async_lock);
>  		list_add(&async_copy->copies,
>  				&async_copy->cp_clp->async_copies);
>  		spin_unlock(&async_copy->cp_clp->async_lock);
> -		wake_up_process(async_copy->copy_task);
>  		status =3D nfs_ok;
>  	} else {
>  		status =3D nfsd4_do_copy(copy, copy->nf_src->nf_file,
> @@ -2287,8 +2330,19 @@ find_async_copy(struct nfs4_client *clp, stateid_t *=
stateid)
> =20
>  	spin_lock(&clp->async_lock);
>  	copy =3D find_async_copy_locked(clp, stateid);
> -	if (copy)
> +	if (copy) {
>  		refcount_inc(&copy->refcount);
> +		/*
> +		 * Mirror nfsd4_unhash_copy(): unlink and clear cp_clp under
> +		 * async_lock so the reaper cannot reach the copy. Caller drops
> +		 * the list-membership reference via nfs4_put_copy() after
> +		 * nfsd4_stop_copy(). smp_store_release() pairs with
> +		 * smp_load_acquire() in nfsd4_send_cb_offload().
> +		 */
> +		smp_store_release(&copy->cp_clp, NULL);
> +		if (!list_empty(&copy->copies))
> +			list_del_init(&copy->copies);
> +	}
>  	spin_unlock(&clp->async_lock);
>  	return copy;
>  }
> @@ -2307,8 +2361,16 @@ nfsd4_offload_cancel(struct svc_rqst *rqstp,
>  		struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
> =20
>  		return manage_cpntf_state(nn, &os->stateid, clp, NULL);
> -	} else
> +	} else {
>  		nfsd4_stop_copy(copy);
> +		/*
> +		 * find_async_copy() removed the copy from
> +		 * clp->async_copies, so the reaper can no longer
> +		 * reach it and drop the list-membership reference
> +		 * via cleanup_async_copy(). Drop it here.
> +		 */
> +		nfs4_put_copy(copy);
> +	}
> =20
>  	return nfs_ok;
>  }
>=20
> --=20
> 2.54.0
>=20
>=20


