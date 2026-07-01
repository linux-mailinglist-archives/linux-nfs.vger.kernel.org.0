Return-Path: <linux-nfs+bounces-22921-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eLufHCaRRWpVCQsAu9opvQ
	(envelope-from <linux-nfs+bounces-22921-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 00:13:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D63EA6F208E
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 00:13:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=fk2VMc0n;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="R sgOOwr";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22921-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22921-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAA78300DD50
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2026 22:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38D43D6CCE;
	Wed,  1 Jul 2026 22:13:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675B73A6411;
	Wed,  1 Jul 2026 22:13:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782944034; cv=none; b=qJDvty4lrzbXQ3AvzE9Iln2w6a/EFE4g2w982w48ghslvmwWYxnwNaJ8z58WmNWm1o6XZKMIxAgSvzp81BJFOn+4BnkyWaD8b2B5dd/PnGCK8ABCG+2IQKbq/Ol4v5q6wPlAxo/t0YdbdOjRp0Cc8yhfU9p3p6OMOVBTM8bnNT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782944034; c=relaxed/simple;
	bh=LlSk6qpb/69Q1cHpt6fZVaAjtIr0n17lXZH61zs6z4Q=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Q+YAhOppLqoyFfYO8dQuK7/wGjrHypvN0NjWwCz8ylPhKY9adJ9IbkxW9TzPoYIDiU8kwlkDkOgT8OXBm2K9ZrqeLRJKlIZztyaCst1etTdx5UBoSC8yP3tqSFV9K+XQQ/r4mkMkE7xgcTdo1s8q8iycrst9kHVbIjm/n9wuo9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=fk2VMc0n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RsgOOwrj; arc=none smtp.client-ip=202.12.124.148
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 948C91D00117;
	Wed,  1 Jul 2026 18:13:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 01 Jul 2026 18:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1782944032; x=1783030432; bh=N4i7YHMbgkZn9A2S6Bqd5OMM5F3eoif3iAD
	HFpmhk2k=; b=fk2VMc0ndPhQ3fawGNMlfn38tbbPkq1FfRNV2M1josnf+cgH849
	+8hjJbKGHuP6PvOvUCEdbPs1sJQjQnFzmOr1DtalBBLJD6juIvnteGNZCtMtHqFM
	R6AuC29wBr18UMfHOvHMxIp5ps/qYKlXdnc8gaST8XGvEctmFQiHt5Jfj/EwUskl
	KknsGVgbmN2dpGmVm7xflrNswbbWE2/8GzAuzOf0h8qW+CxlYzcqAqiDsf3wAsdG
	q3Ns/Nt97nluQH2c3a5YjnIvJvV6oJIyNHQHdEV2Dg19mymxDXf7PSvUbvHhFc9V
	0CpF95V6avFj/26yPcQYV+gyiC1Dzp7OGog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782944032; x=
	1783030432; bh=N4i7YHMbgkZn9A2S6Bqd5OMM5F3eoif3iADHFpmhk2k=; b=R
	sgOOwrjZIH+nd74ysXoirCTA29ELo6vjBQRJ2ZXkblCpf3nj/CJULIijA0BQQxxV
	uHRkcamTuasAMj2/usj52kYSS8k2qfRHGRcFr6itWw7OXoVN6E8trm3Nx0fD/PGt
	u5/Z5UkxqIQBIkmXnUMY4vR6uccFlnQp78BD+72TsLQ3HW8OkOJ22mMWooCs2nU5
	QUWflM0lx1ORrG79lFNJ68X1LapyYcDP7ju5Hb3S7zUiTS3/C7EOhDuQ5t806Zd6
	jpLPbuIus9wcuhG2c3mZNMK20q0MB3Hmu6OmnpGMCu3YhL0YxC3/R5GIp0BcdvSg
	eanou7QyqCjDJl8vwf1Cg==
X-ME-Sender: <xms:IJFFah7OrCxRZSWTvqejDyBaRx7_tnuHDvp-LMEUlaXgIDwkAWsVuA>
    <xme:IJFFaj1s91uo7WuxLhJhlawQ0ojsnRauZJFglA0VGjErWj-lOYw_xLX3lWRwH0Wzr
    WRvP8f86FWtuow837iwFGosFwIrBxcoWl-Op9mR5Nbn2XTcEA>
X-ME-Received: <xmr:IJFFassTVKObKTAYgLmv1mb1314iS7z9-xVeWWos-NFA-fVtcndOZHZ6LOUv_vL-_zbiQMmo8rZdC3u-YqgQU5kqsAF-HJ4>
X-ME-Proxy-Cause: dmFkZTF4vMJxBkhdQvq9nNWykMZmFuqvtpy4fTSvs7Akn0+BzwZMUtl4LeaDwSW2P1IjOL
    XSfoSggfdit9n3/KkxJYsBaFCjsHpWkqvdnDIrqarPeUpBXUtOHYE58z8MZhEzAIBylx76
    SlIZ9UYKCUb9mHQN8JExb7P8TUYMBc/hnlQM/9qQlDsFGnkVARNKWtl9VWxmYKmBUqLNbJ
    S0krE/dX2N67xA7j+u8nUjJ1190DPJxbCprIeb6JJAw9pSIModmFqIsymijqS/7hPYgUbY
    AOm/OzcSLYzHN4ddlZIWFhqspt4K3z7AocN8giaDLXBVUJXVf2S8MNqyzoMJjtssY8IyW/
    9/sb5pZBnto2907P0DNZ2vDbx7OAm6sULeDip1YaB0a9B1z1dbc69CZpxJtAuDcBTFrIOQ
    ++yQebpWvIjSkzURG0jmFOhmvkuQVKrIrVmgHcDoD3628jMTSlzA0BhgXTIH2c+m265n0h
    WtmS9SujPpUZM920yHpOaHlbYNvbGCrsqt3GzOQRq22l8vCwhx6IZ/IJnjoaK/aHPudjXX
    jkjIDSu4u6G3Awh3pqTWKZ3Aljy5l70/UAbdNWPKeCEwfWg7Uk5caJho5qSJbCw8Mg9ZNV
    Hjs+eyYFPDPQkFq8+g32klamuhEQgfc85MAvqZUTuewC1VxxHfqRLLKVcsQw
X-ME-Proxy: <xmx:IJFFap6FWm97UwOu1n1NcMqE7132tI_8utzGJeBhmCN-HVfPOQPJKg>
    <xmx:IJFFaofURbgLH7QQJBctqT_3cPvmqx3TrK4LO8iFtXyY1wWugZg5PQ>
    <xmx:IJFFamyu7Kh2fwygWPa-b_rsHY0_6pv-B2f9-0hXvAB3_Jxpi8ibRQ>
    <xmx:IJFFat-EsXiHsYM2pyC9eaX45IqQVe7hCXrSZkN8OcseLDa3OUWeXg>
    <xmx:IJFFaqbkKR36Ay8ofVdqi9jnt1N3sfAb4IPL3gf1n3rimt_cW4OLteQH>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 18:13:49 -0400 (EDT)
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
Cc: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Chuck Lever" <cel@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject:
 Re: [PATCH v4 1/4] sunrpc: route to a populated pool in svc_pool_for_cpu()
In-reply-to: <20260701-sunrpc-pool-mode-v4-1-b3d867e4c8f9@kernel.org>
References: <20260701-sunrpc-pool-mode-v4-0-b3d867e4c8f9@kernel.org>
  <20260701-sunrpc-pool-mode-v4-1-b3d867e4c8f9@kernel.org>
Date: Thu, 02 Jul 2026 08:13:47 +1000
Message-id: <178294402742.27465.8893159356805540635@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22921-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D63EA6F208E

On Thu, 02 Jul 2026, Jeff Layton wrote:
> svc_set_num_threads() spreads the requested threads evenly across the
> service's pools (base =3D nrservs / sv_nrpools).  When a service runs
> fewer threads than it has pools -- e.g. an nfsd configured with fewer
> threads than the host has NUMA nodes while running in "pernode" or
> "percpu" mode -- the trailing pools are left with no threads at all.
>=20
> svc_xprt_enqueue() selects a pool from the CPU servicing the transport,
> queues the transport on that pool's sp_xprts, and only wakes a thread
> from the same pool.  Each thread services exclusively its own pool, so a
> transport that lands on a threadless pool is enqueued on sp_xprts and
> never picked up: the connection hangs indefinitely.
>=20
> Have svc_pool_for_cpu() skip pools that currently have no threads,
> falling back to the next populated pool.  This trades NUMA locality for
> a guarantee that the work is actually serviced.  sp_nrthreads is only
> updated under the service mutex; the lockless read here is a best-effort
> routing hint, so annotate it with data_race().
>=20
> Fixes: 0f0257eaa5d2 ("svc: Move the xprt independent code to the svc_xprt.c=
 file")

Why that commit?  Did this ever work correctly?
It seems more likely that=20
Fixes: 3262c816a3d7 ("[PATCH] knfsd: split svc_serv into pools")
is appropriate.

> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  net/sunrpc/svc.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index dd80a2eaaa74..82fb7faf563f 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -402,6 +402,7 @@ struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
>  	struct svc_pool_map *m =3D &svc_pool_map;
>  	int cpu =3D raw_smp_processor_id();
>  	unsigned int pidx =3D 0;
> +	unsigned int i;
> =20
>  	if (serv->sv_nrpools <=3D 1)
>  		return serv->sv_pools;
> @@ -414,8 +415,31 @@ struct svc_pool *svc_pool_for_cpu(struct svc_serv *ser=
v)
>  		pidx =3D m->to_pool[cpu_to_node(cpu)];
>  		break;
>  	}
> +	pidx %=3D serv->sv_nrpools;
> +
> +	/*
> +	 * Threads are spread evenly across the pools, but when there are
> +	 * fewer threads than pools some pools can end up with none. A
> +	 * transport enqueued on a threadless pool would never be picked
> +	 * up, since each thread only services its own pool. Fall back to
> +	 * the next populated pool, trading NUMA locality for a guarantee
> +	 * that the transport is serviced.
> +	 */
> +	for (i =3D 0; i < serv->sv_nrpools; i++) {
> +		struct svc_pool *pool =3D &serv->sv_pools[pidx];
> +
> +		/* This is set under the sp_mutex and rarely ever changes. A
> +		 * data race here is harmless.
> +		 */
> +		if (data_race(pool->sp_nrthreads))
> +			return pool;
> +
> +		if (++pidx >=3D serv->sv_nrpools)
> +			pidx =3D 0;
> +	}
> =20
> -	return &serv->sv_pools[pidx % serv->sv_nrpools];
> +	/* No pool has any threads; nothing can service the transport. */

Would a WARN_ON_ONCE() be appropriate here?

I think this is a sensible defensive-programming approach.

Reviewed-by: NeilBrown <neil@brown.name>

Thnaks,
NeilBrown


> +	return &serv->sv_pools[pidx];
>  }
> =20
>  static int svc_rpcb_setup(struct svc_serv *serv, struct net *net)
>=20
> --=20
> 2.54.0
>=20
>=20


