Return-Path: <linux-nfs+bounces-22850-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eKGONxLsPWoc8ggAu9opvQ
	(envelope-from <linux-nfs+bounces-22850-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 05:03:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF18C6C9E55
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 05:03:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=DUCeUZ9X;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="l TPwAap";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22850-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22850-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0E603027718
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 03:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDBF2EEE63;
	Fri, 26 Jun 2026 03:03:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EAF2E091B
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2026 03:03:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782443024; cv=none; b=JhiBkmszWTTXcEYI4SZwzkwN/H3wmgN9ctxnhcE4KR4QBzrivJQngSl2L0yRg79UcPu/DEYzpN9+Nqpd6KyE53fzdInYFeGHJZQCjb1IKW50/EJopDBUyRyfYC0u65B5MvBd7EAFItlzBPh0IpWwb9Bi9DdD3PU3ga1thhpZ9Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782443024; c=relaxed/simple;
	bh=gfW11wjSq477Gd4D93pg9M8ExhTeybLwYtLtNhT6n30=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=MCibEFwMzFOHj0P69o+lvs9djRsYIkTgjIZzvdk1tActten0rl+vvAWKB++5/W1LV7bXNugurvjFf8rogxcBZNf4bIs8NVSAgmO6I3DJjNiFDB+HExTUcwWj7VUAZpxqKulOox7n8q9BhGFLedu+ikhHoFoUH+qZKThe0fMUPLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=DUCeUZ9X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lTPwAapB; arc=none smtp.client-ip=202.12.124.152
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DF06E7A0082;
	Thu, 25 Jun 2026 23:03:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 25 Jun 2026 23:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1782443021; x=1782529421; bh=yuM/vjeiZQuQMPLzWVzhoDNMTw5SoK8oNBe
	AJWR5sOw=; b=DUCeUZ9Xyy8QM2TUeQpZGyinmhImTGqfQ9PW6HSvcmhIOKVBgrf
	AxEAsy2+UJdSgNtyw0M2mQislqNJGR5pEISHerEoXzHhbUTi5T8yEigmyI3eX7ix
	vdbMKq/Ny6zsdjqXJoV5rrE2WT/xTR5bnIE50YipYHfVPNZ8LRff4gI9HQYjqagH
	erchrHjOFqLebboOKQW2pwutrSz5NKlhu9SwQFnLPtIaLMTRmJteWr1UncW/i1cy
	uL/dyUFCoLYY0x0We8qAQlCFY3HpLioUDcuESCA9K9NR+iX7MJ0fjyttQG61KFFj
	n8jqjKREo6eAN9pT91MsFHowQeA2cf9CJhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782443021; x=
	1782529421; bh=yuM/vjeiZQuQMPLzWVzhoDNMTw5SoK8oNBeAJWR5sOw=; b=l
	TPwAapBRFRGOiFQd//mWEcXXmF+VaQkliAaEC12xuVTib+QjZivq4JXjHkA82hh5
	io4aQObPsFQl1Kg4UZ92foIuD3LMZrSZt/+UxKb7cL7u1S0CT8zddzaunh4cGoFH
	sfRJ87Yf5NK+tqRbN0N355/tGtIw2XUkAPLsYwy68+FQ5cPnNIPWXuhzlLqfgc3B
	AeEHVC1EE20T8hUkRu+QHbhNDRgVx/LPCUh7A32P1i5xCUhcAJGcj43Z0j3aY1su
	j45v19pEtN2t95s9B+atcY22lBkWsQfblnVQH0i3FwGRtjxOZvseOlSLSc3ShS2a
	zYCUIQAjx0PwQSxGsW9OA==
X-ME-Sender: <xms:Dew9av6dVDJoSd-fhN60GByUrJUjWKt4UB_ZzrH_e0H2CRO30Y2A4w>
    <xme:Dew9ahdg7dW8TqSZBkf3lRESGH5TjkLUfa_t9Qz0X2Pr2g-HNv5uV7rXDX6fYnfUc
    Uv5T4hTBO5DbbE37zTsPGGCLtyxgm4er-h5sU5CPKKFit6fxw>
X-ME-Received: <xmr:Dew9aq7MQFVsjCM4fu91stkJMNpvCNmn90FsW8MSWT8BgRGu9yFBLE5osRX1L_KL_mxPGVC7B8BXgSqWe5jKWAhioUC7GuI>
X-ME-Proxy-Cause: dmFkZTF0Hy5b2SmN3KffrxBgRyM3dWO17l5n+swZ65XpMuKdq4TiQn3dtll3VGFpt0nZ/r
    VWqAMwBL5JnPJLcpeWeSrxedqtlYn5XelGuf2yB6AUF4Eb9Vq2yRcQxyuRKkRZYxnFoCiL
    0/u4I24ZoIiIXmy1n+bXLcNeiKsqac3Rvx0cMnpI+b0GZ3J66TjYS8jyZbc/a/70Nxrjaa
    wrvTnTmGMD6ty3/hGLsES1UcqWs5EsRhzHKH6LGunBFaPgWYenuX81COPo8hwRTEZ8UDnL
    MeObd7cABy9uNJiKhmP5FPrwUd/r4WO2TWe5yHn5IvDrSzeucgoRUDb+jmf85Gt/BTD5qC
    RzvkDSTqWKij4LT4UgkTcVcCA6w7mo6MUqtTJpeXXbEUqRayqJTcKP114/M1hwxVpbJEQX
    bc0qph1YwWVoPaPRQhFqjlnf1bAJos5wWdsfxzu4pwfEH0mLWE1fEONpp5knTujrr7KI0d
    GvROm2vtVJ7KnwBkfyRq8qdMFsLjowFWeWD31Qbk8Q9nBOvSeKVYFe/GcFTNn6nYBg/+EU
    IPD1qJAMY204UTcqmQIxZvkC3+JrqbQ36ihCSD2lgcBCf5ALvS+VBL3i8G/KdauBXj9904
    76KCrpCdvp9E0yj4terV7DaoFC1H7KiRfYRibl+YnGUhsBA0mMOgMr5vyfbQ
X-ME-Proxy: <xmx:Dew9am97WEmyBxrb4-kpzfVblhZwKH9HRTSms5gC3Z9ljM1x-IG_qA>
    <xmx:Dew9akEgBCJv0_MgAJu7Rymvm7Zbi7Y5F0geffrBH2QJxa-6YZKDbA>
    <xmx:Dew9ajWZqiOEUF3kWtOLhgliAow-PKhSEGxbf5bYBc2VT3dP1sOByQ>
    <xmx:Dew9ao9C5TuWHfDi3a6AIVpRM1C6o2GVrRga4AhPBH3MFnpt2blxHA>
    <xmx:Dew9agGwd8iG7G1ls4uvOBIQpb18KqXh1KJm4oTXNWxZVmIrWt0jsGN1>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 23:03:38 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Benjamin Coddington" <ben.coddington@hammerspace.com>
Cc: "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Daire Byrne" <daire@dneg.com>,
 linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH RFC 2/3] SUNRPC: dispatch idle transports ahead of backlogged ones
In-reply-to: <8b65b751a62984fa08797b18be7dfaf16bdb3721.1782314746.git.bcodding@hammerspace.com>
References: <cover.1782314746.git.bcodding@hammerspace.com>  <8b65b751a62984fa08797b18be7dfaf16bdb3721.1782314746.git.bcodding@hammerspace.com>
Date: Fri, 26 Jun 2026 13:03:36 +1000
Message-id: <178244301603.27465.15071583882673669213@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22850-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_RECIPIENTS(0.00)[m:ben.coddington@hammerspace.com,m:cel@kernel.org,m:jlayton@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:daire@dneg.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,brown.name:replyto,ownmail.net:dkim,ownmail.net:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF18C6C9E55

On Thu, 25 Jun 2026, Benjamin Coddington wrote:
> A pool dispatches ready transports in FIFO order, so a connection that
> already has requests in flight sits in the same queue, on equal terms,
> as one that has been idle.  A client driving many concurrent requests
> therefore delays the next request of an interactive client whose
> previous reply has already completed: the interactive request waits
> behind the busy client's backlog even though servicing it costs a
> single round trip.
>=20
> Route a transport with no requests in flight onto the new high-priority
> queue, sp_xprts_hi, and drain that queue ahead of sp_xprts.  xpt_nr_rqsts
> is incremented when a thread reserves a request slot and decremented when
> the reply completes, so at enqueue time it counts the transport's prior
> in-flight work, not the request that just arrived: a flow whose last
> reply has completed reads zero and jumps the queue, while a flow with
> requests still in flight stays in the bulk queue.  The classification
> needs no client identity and no lock -- each queue is an independent lwq
> with its own ordering, so svc_thread_should_sleep() simply tests both.
>=20
> This gives an idle flow's request a latency floor that a backlogged flow
> cannot push it below.  It is starvation avoidance, not proportional
> fairness: under sustained load across many idle flows the bulk queue can
> wait, and bounding that is left to later work.

I don't feel comfortable completely leaving this for later work.  I
think some minimal solution should be present from the start.  Possibly
we could simple alternate between interactive and batch.  This would
effectively defeat the unfairness created by using nconnect but
otherwise share resources fairly well.

NeilBrown


>=20
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  net/sunrpc/svc_xprt.c | 44 +++++++++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 16 deletions(-)
>=20
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 63d1002e63e7..ec4c05094e9a 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -523,7 +523,10 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
> =20
>  	percpu_counter_inc(&pool->sp_sockets_queued);
>  	xprt->xpt_qtime =3D ktime_get();
> -	lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts);
> +	if (atomic_read(&xprt->xpt_nr_rqsts))
> +		lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts);
> +	else
> +		lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts_hi);
> =20
>  	svc_pool_wake_idle_thread(pool);
>  }
> @@ -536,7 +539,9 @@ static struct svc_xprt *svc_xprt_dequeue(struct svc_poo=
l *pool)
>  {
>  	struct svc_xprt	*xprt =3D NULL;
> =20
> -	xprt =3D lwq_dequeue(&pool->sp_xprts, struct svc_xprt, xpt_ready);
> +	xprt =3D lwq_dequeue(&pool->sp_xprts_hi, struct svc_xprt, xpt_ready);
> +	if (!xprt)
> +		xprt =3D lwq_dequeue(&pool->sp_xprts, struct svc_xprt, xpt_ready);
>  	if (xprt)
>  		svc_xprt_get(xprt);
>  	return xprt;
> @@ -759,7 +764,7 @@ svc_thread_should_sleep(struct svc_rqst *rqstp)
>  		return false;
> =20
>  	/* was a socket queued? */
> -	if (!lwq_empty(&pool->sp_xprts))
> +	if (!lwq_empty(&pool->sp_xprts_hi) || !lwq_empty(&pool->sp_xprts))
>  		return false;
> =20
>  	/* are we shutting down? */
> @@ -1183,26 +1188,33 @@ static int svc_close_list(struct svc_serv *serv, st=
ruct list_head *xprt_list, st
>  	return ret;
>  }
> =20
> -static void svc_clean_up_xprts(struct svc_serv *serv, struct net *net)
> +static void svc_clean_up_queue(struct lwq *queue, struct net *net)
>  {
>  	struct svc_xprt *xprt;
> +	struct llist_node *q, **t1, *t2;
> +
> +	q =3D lwq_dequeue_all(queue);
> +	lwq_for_each_safe(xprt, t1, t2, &q, xpt_ready) {
> +		if (xprt->xpt_net =3D=3D net) {
> +			set_bit(XPT_CLOSE, &xprt->xpt_flags);
> +			svc_delete_xprt(xprt);
> +			xprt =3D NULL;
> +		}
> +	}
> +
> +	if (q)
> +		lwq_enqueue_batch(q, queue);
> +}
> +
> +static void svc_clean_up_xprts(struct svc_serv *serv, struct net *net)
> +{
>  	int i;
> =20
>  	for (i =3D 0; i < serv->sv_nrpools; i++) {
>  		struct svc_pool *pool =3D &serv->sv_pools[i];
> -		struct llist_node *q, **t1, *t2;
> -
> -		q =3D lwq_dequeue_all(&pool->sp_xprts);
> -		lwq_for_each_safe(xprt, t1, t2, &q, xpt_ready) {
> -			if (xprt->xpt_net =3D=3D net) {
> -				set_bit(XPT_CLOSE, &xprt->xpt_flags);
> -				svc_delete_xprt(xprt);
> -				xprt =3D NULL;
> -			}
> -		}
> =20
> -		if (q)
> -			lwq_enqueue_batch(q, &pool->sp_xprts);
> +		svc_clean_up_queue(&pool->sp_xprts_hi, net);
> +		svc_clean_up_queue(&pool->sp_xprts, net);
>  	}
>  }
> =20
> --=20
> 2.53.0
>=20
>=20


