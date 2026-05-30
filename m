Return-Path: <linux-nfs+bounces-22118-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEcOHVVbG2oiBgkAu9opvQ
	(envelope-from <linux-nfs+bounces-22118-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 23:49:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F30E613807
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 23:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 422B3300FAB5
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 21:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D941E25B0BF;
	Sat, 30 May 2026 21:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPGP6zu8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3386377EC7
	for <linux-nfs@vger.kernel.org>; Sat, 30 May 2026 21:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780177745; cv=none; b=cctUv6K51dJSXFv2hna9k8RUNZtYh7VsilCrZrgN/+QEiNBIFlld0W5GBh6YrCCFGJr0XK+CS5FyeWur5XD26dsX3s/RTapd9tdthKiL1LF21JfpJ23S5mkr2PkVcyc3zMx7+DHjVpot+Et+YIRfwrjr4Wgq1qkMRrGeAwiX5MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780177745; c=relaxed/simple;
	bh=gSgJAufpREubhNVBbev1SbERKfQXmSgb4gcNPBWZJoI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JNSbjk0OYlKAWSrlior4AisFHOqfXp730mkFsyI+zlY+b9R4uchA6Fu6xHusTs6no3/0kTYjogWkwTkvO7CR1C6PWOg+JmaRsOWmp03hRnTfxY0pKccYAzTbdDOeyl+2CU4tUpxMWsp9+aIvj4nTkwdOuzCSiXLsfJRxQA1loZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPGP6zu8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886F11F00893;
	Sat, 30 May 2026 21:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780177744;
	bh=yQnqYp4maw5dooYrzFRqXzUQeTwqeyWIiXqth/RYrB4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BPGP6zu8l1kQ3/WCGF4beIhq74r1CTC5yT88eORJA7H8VveowIVAQXU6e/6dKked2
	 Sv3CQ6CbQCd3GV2F5RVUowLsz9/9E5O82f5siqXJQNsWLdID+p9oCdPisR0Ezs1uXQ
	 mgPG5+nViBsWxhKjz744y8w+QkZyCWeuuJ+53QdEuEUd7mgXrJIZ/2aTtDebezNnmZ
	 jmM8jvofoTSdzgmUKsP+CZMM7q0zB6pmxCcSUoiE/cVCaeXF3dKYYZcRURDR5IhFNH
	 LKUcvdg9/KdgMAUkqpOZMjwIDW10imzTCGRTZMG2tGKJJVPoom0XLGIrYqhuw0OrUs
	 q2koUVCCpP2Lw==
Message-ID: <36d0e0ea5f69e600267d9adad085f1fb5d2f6fd9.camel@kernel.org>
Subject: Re: [PATCH 2/2] SUNRPC: Check svc pool percpu counter allocation
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Date: Sat, 30 May 2026 17:48:56 -0400
In-Reply-To: <0b0a969d8c8dd4769faf8ea2f0589e5af5a9a0a3.camel@kernel.org>
References: <20260530-tier2-local-v1-0-fc294d34848a@oracle.com>
		 <20260530-tier2-local-v1-2-fc294d34848a@oracle.com>
	 <0b0a969d8c8dd4769faf8ea2f0589e5af5a9a0a3.camel@kernel.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22118-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0F30E613807
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 2026-05-30 at 17:45 -0400, Jeff Layton wrote:
> On Sat, 2026-05-30 at 16:21 -0400, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> >=20
> > __svc_create() initializes three per-pool percpu_counter stats and
> > ignores every return value. On SMP, percpu_counter_init() fails when
> > __alloc_percpu_gfp() cannot satisfy the allocation, leaving the failed
> > counter with fbc->counters =3D=3D NULL and its embedded raw_spinlock_t,
> > list_head, and count never initialized. __svc_create() returns the
> > half-constructed svc_serv to nfsd, lockd, or the NFS callback service
> > anyway.
> >=20
> > Once that service is live, the hot-path increments in
> > svc_xprt_enqueue(), svc_handle_xprt(), and
> > svc_pool_wake_idle_thread() reach a counter whose backing pointer is
> > NULL. The pointer is a per-cpu offset, so the access does not fault:
> > it resolves to offset zero of the current CPU's per-cpu area and
> > silently corrupts whatever variable lives there. A
> > /proc/fs/nfsd/pool_stats read walks the same NULL per-cpu storage and
> > returns garbage, and on CONFIG_DEBUG_SPINLOCK or lockdep it splats on
> > the never-initialized lock.
> >=20
> > Creating the broken service requires a percpu allocation failure during
> > RPC server startup, so it is reachable only by a local administrator
> > under memory pressure or fault injection; a remote peer cannot induce
> > the bad state on its own.
> >=20
> > Initialize the three adjacent pool counters with one checked
> > percpu_counter_init_many() call and fail __svc_create() when the
> > allocation fails, unwinding the counters for pools already set up. Use
> > the matching percpu_counter_destroy_many() at teardown so the single
> > per-cpu allocation is freed exactly once.
> >=20
> > Fixes: ccf08bed6e7a ("SUNRPC: Replace pool stats with per-CPU variables=
")
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  net/sunrpc/svc.c | 32 ++++++++++++++++++++++++++------
> >  1 file changed, 26 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index ae9ec4bf34f7..aeb6e631848c 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -476,6 +476,22 @@ __svc_init_bc(struct svc_serv *serv)
> >  }
> >  #endif
> > =20
> > +enum {
> > +	SVC_POOL_COUNTERS =3D 3,
> > +};
> > +
> > +static int svc_pool_init_counters(struct svc_pool *pool)
> > +{
> > +	return percpu_counter_init_many(&pool->sp_messages_arrived, 0,
> > +					GFP_KERNEL, SVC_POOL_COUNTERS);
> > +}
> >=20
> >=20
>=20
> Switching to this looks like a good thing, but it means that the
> svc_pool struct fields now have some strict ordering requirements. The
> percpu_counters all need to be snuggled up together.
>=20
> That deserves a comment to that effect in the struct svc_pool, so that
> we don't inadvertently break it later.
>=20

Actually, sashiko points out that struct randomization could break here
too. Given that service creation isn't a hot codepath, I'd keep these
as discrete percpu_counter_init/destroy() calls and avoid the hassle.

> > +
> > +static void svc_pool_destroy_counters(struct svc_pool *pool)
> > +{
> > +	percpu_counter_destroy_many(&pool->sp_messages_arrived,
> > +				    SVC_POOL_COUNTERS);
> > +}
> > +
> >  /*
> >   * Create an RPC service
> >   */
> > @@ -540,12 +556,18 @@ __svc_create(struct svc_program *prog, int nprogs=
, struct svc_stat *stats,
> >  		INIT_LIST_HEAD(&pool->sp_all_threads);
> >  		init_llist_head(&pool->sp_idle_threads);
> > =20
> > -		percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
> > -		percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
> > -		percpu_counter_init(&pool->sp_threads_woken, 0, GFP_KERNEL);
> > +		if (svc_pool_init_counters(pool))
> > +			goto out_err;
> >  	}
> > =20
> >  	return serv;
> > +
> > +out_err:
> > +	while (i--)
> > +		svc_pool_destroy_counters(&serv->sv_pools[i]);
> > +	kfree(serv->sv_pools);
> > +	kfree(serv);
> > +	return NULL;
> >  }
> > =20
> >  /**
> > @@ -624,9 +646,7 @@ svc_destroy(struct svc_serv **servp)
> >  	for (i =3D 0; i < serv->sv_nrpools; i++) {
> >  		struct svc_pool *pool =3D &serv->sv_pools[i];
> > =20
> > -		percpu_counter_destroy(&pool->sp_messages_arrived);
> > -		percpu_counter_destroy(&pool->sp_sockets_queued);
> > -		percpu_counter_destroy(&pool->sp_threads_woken);
> > +		svc_pool_destroy_counters(pool);
> >  	}
> >  	kfree(serv->sv_pools);
> >  	kfree(serv);
>=20
> Patch itself looks fine though.
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

--=20
Jeff Layton <jlayton@kernel.org>

