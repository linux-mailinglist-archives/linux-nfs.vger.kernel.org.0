Return-Path: <linux-nfs+bounces-23159-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mpaTCJnhTWo+/gEAu9opvQ
	(envelope-from <linux-nfs+bounces-23159-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 07:35:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 400AD721DF7
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 07:35:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=PiXx8K93;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="j Bmm+aE";
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23159-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23159-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12D5F30409E8
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2026 05:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB953BCD13;
	Wed,  8 Jul 2026 05:33:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073223BBFDE;
	Wed,  8 Jul 2026 05:33:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488831; cv=none; b=U/s1RmtTU+Idx2uqFcLVjr7G9q8nIlHhkyJFI0hSnHUp9d2pOtVp5DHL+Jt0dnORswJ9PHncGBmmXWHzYafcONQqxfwUF8tA9edVw4SjIiHZ6jjATpHiGEcW+xVyPBRgyspsqKIZrp3fTPzkzbBoqRzS1b899L2EwFgld7ohqoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488831; c=relaxed/simple;
	bh=oFwvMA4yi9J7CMbwFtQhf/7p0ddOawpLTk9Mzf8qJeU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=pMOowKNO/hXTjrwmCa5JAWJQV1AMEo7tVkTXt7GmL3d0XqE9WyQ+7Fsr/bTocEaWIJYXNBACHGKIFhdaX9AEFyJoBXIdQtArkLzZpsuYneLDLlfwPG+34t2hALnH1g+NAZgApIpkk3m4xKrmIp12I8LYzS3edZEOPd7iyR6l/f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=PiXx8K93; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jBmm+aEA; arc=none smtp.client-ip=202.12.124.155
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F4D17A0133;
	Wed,  8 Jul 2026 01:33:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 08 Jul 2026 01:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783488827; x=1783575227; bh=C3GqVpeb3hGNoAHZevZrXkSH8a/OPtkBer1
	Cjbog3mQ=; b=PiXx8K93drx/BLo2nIfKZivLM+Bvvb+7o3OTZb6UzYrmlIkkKxI
	xNs+3xWGcI7GBLBbQw0+pQWgWivsZznfERN93yVkvI76I+BRq0vuj7ci2ewhv6Tv
	/8YkO/mH9lh1W0eB0JU3GheJF61kSYZeS1r8ujY0Zjgz2SoLePOcjoC+tHFUDQ1X
	fVyvk86nGuQn/3lPpllK1sOnOyzytZGFFbXZ7y3aRTbzirTzv2qzKQZ8uRp+J2EK
	02kM9FPt+S7HHYelYVw3IUcsYVEGMzg8diA9tCWJ8Nr9x1XBZsgmhr/7OK2LDCGa
	LneIZWo2USovwqQvwDtoiEF+v5A3AjA5Wbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783488827; x=
	1783575227; bh=C3GqVpeb3hGNoAHZevZrXkSH8a/OPtkBer1Cjbog3mQ=; b=j
	Bmm+aEA1Nt5hldf9kHSZj8rGzF/U1Yk/BNb2ircTuiuz8Qsj9y5dbjLWpQVqDr6e
	DDbrXr1Aoj6EiQIF2LoNRcMsmIYYwXWOBwJHtbzmzdEYABpL11ZbAMdzlgJ4kfAc
	PCvbXf/NTrqg47aNKj8YRHmG7q4ZTcNpMYPZkIcjPxiA/UA2TsLtjPHePcCffY4A
	nr4Lk/FqiTJaLHAWRqyZkN7SiusGWRd79R2t8PHckkQtpUYhjsgmhcvyTkpzwD5a
	Cx3lt4S6cV8Bhu3W+i5l8/NfOGJcGo2AWcqhaWZ5dFCjVGb+wZwM4kNZ9gkVRDfk
	oqbbLSb6bwNNepfeQ6H1g==
X-ME-Sender: <xms:O-FNat8WVZi1NwJQePc_45f_2Qz_JN-mX34CcgtKHMOtTxszED7sxQ>
    <xme:O-FNamrM59PqxYhaA4ho_tYjnDJ7-jn1WZfdtlwRbZQCC-OZwnF5YK_qbvTDHxyQN
    u8cqlg4EySenfHE7nnpoXUhvAwNY1o90c-YBGbA4Yt3ryUzTw>
X-ME-Received: <xmr:O-FNavR0kVpqPWRw7w0JWDeQtM_N_a2ZR3I2xvpppxlWKDLabfqCNGprjmTarRsDH8GlwEa4VGnMg5JR4s7_F0Ig0y6VwTw>
X-ME-Proxy-Cause: dmFkZTGsmCJL1JSSll/No9pBjKfE6GFiUQkhFlIBhTN++rE/dVEy9h5nthye5tErxoDdd3
    59rkyNPoYl5DklEX5thatevyAHMKDlbvsqnlPwDDpGm96KQykMeWDHmQYji4hS96mlxJBh
    xVx4QJS7iv7u2Tkh7NJnZQyfjiAcfycUJREjBx0mbeaZlWvUH386+D9mvLg1Qi+A7n/k82
    vfeKZfkavB/ym9rJjcbKHylDVO09Ww9l/b0WU7+ODiwn7hOgveCl4pFkYslw824VOvuUYu
    +E8kT9FpNrlGOHjNc66a8m0hGJ8DlTZY2THiD2/WcKLA4ALMEElvblLQU0szP822igXujK
    wlQigE6AR8oYhHCyEF4bcOCPBWNtyKuKd3PubjMF/zECXuwIvP8cqYmBL98/5U6no/NUdH
    hxqwnPRh/kFCZ+sQWkE5QbDNmsMUp5dOjAsN7a1EAbnoNugVX5+HvGjerKj+ZQeO/q2Rqe
    A8Wbq9TENdrwhId2PWBFSBFgzCm8MdxNA+zqh507PP3ymMVK+oqGYb6vZPZYx5FFORKONB
    ztb6+a/MHqWiC2lGzInhZ0Pja2nVSwQEyfh0YAPA6f57LkUQd8hRNXwyneb+qS5XbmmRxG
    zvODaMWtc3HrH4omvzMRbh+V+d/xhcWJ7JcsMTuUfKrO4yzXk8Zzvat4KfEg
X-ME-Proxy: <xmx:O-FNahO6k7ml9qyEm9IC4DUqYMiU-_gt55UdHurmd2aLNdA6j19HDw>
    <xmx:O-FNalhInolSy-m2dXGak3WkgaBO9FzZQnZ-1a3kEZAE1w4rSwbaGQ>
    <xmx:O-FNamnET0a5HkWaTvNAf-FiinMaNKp3e-LfmRT1Uy61B_ZzN3GgGA>
    <xmx:O-FNapgv3yyFcAWQ301Hr4bfq7t5pr8K2j9wHgoASY4L-o1eKG6-Lg>
    <xmx:O-FNaltdsC_qmCJqwZUcEdUCxlLrPL1-BwRsyiMhhC7BLpkkbgxV9Npa>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 01:33:44 -0400 (EDT)
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
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] sunrpc: derive the pool count instead of caching
 it in sv_nrpools
In-reply-to: <3496ed08e534a3e81dfe4168d4b2bc3c325d829a.camel@kernel.org>
References: <20260706-sunrpc-pool-mode-v5-0-6c4ee7cd89aa@kernel.org>
  <20260706-sunrpc-pool-mode-v5-5-6c4ee7cd89aa@kernel.org>
  <178337823128.27465.5531515481696438438@noble.neil.brown.name>
  <3496ed08e534a3e81dfe4168d4b2bc3c325d829a.camel@kernel.org>
Date: Wed, 08 Jul 2026 15:33:41 +1000
Message-id: <178348882124.3371781.3092732814258907420@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23159-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,brown.name:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 400AD721DF7

On Tue, 07 Jul 2026, Jeff Layton wrote:
> On Tue, 2026-07-07 at 08:50 +1000, NeilBrown wrote:
> > On Mon, 06 Jul 2026, Jeff Layton wrote:
> > > Now that the pool mode is always pernode, svc_serv.sv_nrpools is
> > > redundant with sv_is_pooled: an unpooled service always has a single
> > > pool, and a pooled service has svc_pool_map.npools pools (which is one =
on
> > > a single-node host). sv_nrpools cannot distinguish an unpooled service
> > > from a pooled service that happens to have one pool, so it is sv_nrpool=
s,
> > > not sv_is_pooled, that carries no unique information.
> > >=20
> > > Replace the cached field with a svc_serv_nrpools() helper that derives
> > > the count from sv_is_pooled and the pool map, and convert all readers to
> > > it. svc_pool_map is file-local to svc.c, so export the helper for the
> > > svc_xprt.c and nfsd callers.
> > >=20
> > > Reading svc_pool_map.npools without svc_pool_map_mutex is safe: the
> > > mutex protects only svc_pool_map.count, and npools is already read
> > > locklessly in svc_pool_for_cpu().
> > >=20
> > > A pooled service holds a map reference for its whole lifetime, so npools
> > > is stable while any reader could observe it.  The hot path
> > > (svc_pool_for_cpu()) already dereferences svc_pool_map for to_pool, and
> > > npools shares that cacheline, so there is no new locking or coherence
> > > cost.
> > >=20
> > > __svc_create() keeps using its local npools argument for the sv_pools[]
> > > allocation, since sv_is_pooled is not set until svc_create_pooled() has
> > > returned from it.
> > >=20
> > > Doing this also removes a modulus operation from svc_pool_for_cpu(),
> > > which should make for more efficient RPC queueing.
> > >=20
> > > Assisted-by: Claude:claude-opus-4-8
> > > Suggested-by: NeilBrown <neilb@ownmail.net>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfsd/nfsctl.c           |  2 +-
> > >  fs/nfsd/nfssvc.c           | 10 ++++-----
> > >  include/linux/sunrpc/svc.h |  2 +-
> > >  net/sunrpc/svc.c           | 52 ++++++++++++++++++++++++++++++++------=
--------
> > >  net/sunrpc/svc_xprt.c      |  6 +++---
> > >  5 files changed, 46 insertions(+), 26 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index bc16fc7ca24f..0543e5bb842f 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -1526,7 +1526,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff =
*skb,
> > > =20
> > >  	rcu_read_lock();
> > > =20
> > > -	for (i =3D 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> > > +	for (i =3D 0; i < svc_serv_nrpools(nn->nfsd_serv); i++) {
> > >  		struct svc_rqst *rqstp;
> > >  		long thread_skip =3D 0;
> > > =20
> > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > index a8ea4dbfa56b..2edf716ea022 100644
> > > --- a/fs/nfsd/nfssvc.c
> > > +++ b/fs/nfsd/nfssvc.c
> > > @@ -655,7 +655,7 @@ int nfsd_nrpools(struct net *net)
> > >  	if (nn->nfsd_serv =3D=3D NULL)
> > >  		return 0;
> > >  	else
> > > -		return nn->nfsd_serv->sv_nrpools;
> > > +		return svc_serv_nrpools(nn->nfsd_serv);
> > >  }
> > > =20
> > >  int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
> > > @@ -665,7 +665,7 @@ int nfsd_get_nrthreads(int n, int *nthreads, struct=
 net *net)
> > >  	int i;
> > > =20
> > >  	if (serv)
> > > -		for (i =3D 0; i < serv->sv_nrpools && i < n; i++)
> > > +		for (i =3D 0; i < svc_serv_nrpools(serv) && i < n; i++)
> > >  			nthreads[i] =3D serv->sv_pools[i].sp_nrthrmax;
> > >  	return 0;
> > >  }
> > > @@ -699,8 +699,8 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct=
 net *net)
> > >  	if (n =3D=3D 1)
> > >  		return svc_set_num_threads(nn->nfsd_serv, nn->min_threads, nthreads[=
0]);
> > > =20
> > > -	if (n > nn->nfsd_serv->sv_nrpools)
> > > -		n =3D nn->nfsd_serv->sv_nrpools;
> > > +	if (n > svc_serv_nrpools(nn->nfsd_serv))
> > > +		n =3D svc_serv_nrpools(nn->nfsd_serv);
> > > =20
> > >  	/* enforce a global maximum number of threads */
> > >  	tot =3D 0;
> > > @@ -731,7 +731,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct=
 net *net)
> > >  	}
> > > =20
> > >  	/* Anything undefined in array is considered to be 0 */
> > > -	for (i =3D n; i < nn->nfsd_serv->sv_nrpools; ++i) {
> > > +	for (i =3D n; i < svc_serv_nrpools(nn->nfsd_serv); ++i) {
> > >  		err =3D svc_set_pool_threads(nn->nfsd_serv,
> > >  					   &nn->nfsd_serv->sv_pools[i],
> > >  					   0, 0);
> > > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > > index 3a0152d926fb..3c885ab6ad41 100644
> > > --- a/include/linux/sunrpc/svc.h
> > > +++ b/include/linux/sunrpc/svc.h
> > > @@ -85,7 +85,6 @@ struct svc_serv {
> > > =20
> > >  	char *			sv_name;	/* service name */
> > > =20
> > > -	unsigned int		sv_nrpools;	/* number of thread pools */
> > >  	bool			sv_is_pooled;	/* is this a pooled service? */
> > >  	struct svc_pool *	sv_pools;	/* array of thread pools */
> > >  	int			(*sv_threadfn)(void *data);
> > > @@ -480,6 +479,7 @@ void		   svc_wake_up(struct svc_serv *);
> > >  void		   svc_reserve(struct svc_rqst *rqstp, int space);
> > >  void		   svc_pool_wake_idle_thread(struct svc_pool *pool);
> > >  struct svc_pool   *svc_pool_for_cpu(struct svc_serv *serv);
> > > +unsigned int	   svc_serv_nrpools(const struct svc_serv *serv);
> > >  char *		   svc_print_addr(struct svc_rqst *, char *, size_t);
> > >  const char *	   svc_proc_name(const struct svc_rqst *rqstp);
> > >  int		   svc_encode_result_payload(struct svc_rqst *rqstp,
> > > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > > index ece69cb0138a..800514a14f17 100644
> > > --- a/net/sunrpc/svc.c
> > > +++ b/net/sunrpc/svc.c
> > > @@ -224,7 +224,7 @@ svc_pool_map_set_cpumask(struct task_struct *task, =
unsigned int pidx)
> > >  	unsigned int node =3D m->pool_to[pidx];
> > > =20
> > >  	/*
> > > -	 * The caller checks for sv_nrpools > 1, which
> > > +	 * The caller checks for more than one pool, which
> > >  	 * implies that we've been initialized.
> > >  	 */
> > >  	WARN_ON_ONCE(m->count =3D=3D 0);
> > > @@ -234,6 +234,24 @@ svc_pool_map_set_cpumask(struct task_struct *task,=
 unsigned int pidx)
> > >  	set_cpus_allowed_ptr(task, cpumask_of_node(node));
> > >  }
> > > =20
> > > +/**
> > > + * svc_serv_nrpools - number of thread pools backing a service
> > > + * @serv: An RPC service
> > > + *
> > > + * Pooled services all share the global svc_pool_map, so their pool co=
unt
> > > + * is svc_pool_map.npools. Unpooled services have a single pool. Readi=
ng
> > > + * npools without svc_pool_map_mutex is safe: a pooled service holds a=
 map
> > > + * reference for its whole lifetime, so npools is stable once set.
> > > + *
> > > + * Return value:
> > > + *   The number of pools in @serv
> > > + */
> > > +unsigned int svc_serv_nrpools(const struct svc_serv *serv)
> > > +{
> > > +	return serv->sv_is_pooled ? svc_pool_map.npools : 1;
> > > +}
> > > +EXPORT_SYMBOL_GPL(svc_serv_nrpools);
> >=20
> > I would make this a static-inline.
> >=20
>=20
> That would mean that we would have to export svc_pool_map, which is
> currently private to svc.c.

Why is exporting svc_pool_map more problematic than exporting svc_serv_nrpool=
s?
I think it would be good for at least the code in svc_pool_for_cpu() to
inline the function.  Maybe it already does?  Or maybe marking it
"inline" but still exporting it would work.

Thanks,
NeilBrown


>=20
> > > +
> > >  /**
> > >   * svc_pool_for_cpu - Select pool to run a thread on this cpu
> > >   * @serv: An RPC service
> > > @@ -247,12 +265,15 @@ svc_pool_map_set_cpumask(struct task_struct *task=
, unsigned int pidx)
> > >  struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
> > >  {
> > >  	struct svc_pool_map *m =3D &svc_pool_map;
> > > +	unsigned int nrpools =3D svc_serv_nrpools(serv);
> > >  	unsigned int pidx, i;
> > > =20
> > > -	if (serv->sv_nrpools <=3D 1)
> > > +	if (nrpools <=3D 1)
> > >  		return serv->sv_pools;
> > > =20
> > > -	pidx =3D m->to_pool[cpu_to_node(raw_smp_processor_id())] % serv->sv_n=
rpools;
> > > +	pidx =3D m->to_pool[cpu_to_node(raw_smp_processor_id())];
> > > +	if (pidx >=3D nrpools)
> > > +		pidx =3D 0;

