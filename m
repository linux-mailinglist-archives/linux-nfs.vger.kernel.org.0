Return-Path: <linux-nfs+bounces-19085-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wtitLE96mmnJbwMAu9opvQ
	(envelope-from <linux-nfs+bounces-19085-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 04:38:55 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 987FE16E731
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 04:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3FD5301410D
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 03:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC0A41760;
	Sun, 22 Feb 2026 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="akc3fdeW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NqI8vDs5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839E7AD4B
	for <linux-nfs@vger.kernel.org>; Sun, 22 Feb 2026 03:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771731531; cv=none; b=ks3J5fpK/6bJ2lKt/kP/Klivc7irUS6mhpSgwjcFfldhslUHwKaXosUGKXoSXOo3osKGLEbEp59ZZKhEQSdGSb7Kn1VAzm4mXfXBr+ws6ua7xwq0NxyCklhbMBAURqnvsKRzdnOvyfHo/gOeTvMawotEPKuzXnOUpwgidHRr3NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771731531; c=relaxed/simple;
	bh=XQomMMgEsMou9WTvmNoXN0H2ADKkDcK+HlKaDdXMHVI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=FFnju114uIVYGeU+1rJFIrrPGlvuVTFLfyyIb/TiFLmqHhHQhcc0oWRFNtymoG3Tg8hsCNXep5+2Py53BK4SpbuQ0utP8tQDQf8xLlNRSjtDYk1sJx18gJcSuNXH3wpUnO5VYW/dCdYDainM6UhQ1SjHMxM7ly1+uvY0zY75l88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=akc3fdeW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NqI8vDs5; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BC65AEC0295;
	Sat, 21 Feb 2026 22:38:48 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 21 Feb 2026 22:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1771731528; x=1771817928; bh=d8eCD1vJRrZEak24S0px7SRdiAtVdBddPIf
	x7uDAVeo=; b=akc3fdeW/tkPVv5muxLn/vsya0fvNtWAiYVI3gzu31tWaHiNkfq
	sqCOdtR1g3CvCotTKaAi5KU9XOVv/zNh1lAv1y05qDlwfGZ2ts/v7tjtJjb/nULB
	XB6zKjDLXdiKpJnzd5OXFEM/Bdm0/R+4shlu7I9REgQZs0Q3i2rYXE9RIvhlxZ1u
	KKBMcFJhbl1rJqLNxMHE95YWGKHK9lq1yEpvn3ak2druFNxJdmxOJqwZscStnHY6
	1ARvYpvigIQ8bPKUNvrHHLmJTGsl9kw46TZILmQXdprdoFoPIDkIunGG/Fasa4tL
	I7zZQpJkqDKL4Bjv7QkW4FewveJHmnNvbPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771731528; x=
	1771817928; bh=d8eCD1vJRrZEak24S0px7SRdiAtVdBddPIfx7uDAVeo=; b=N
	qI8vDs5yxB+fTjskT9PYmVkRKFx4fXEbeRcDAkbfoCYv0LJEi5fWg5aCFr3u1ALN
	We72R0Wz3ruwoVc+aI9to/GcYayFnceOshLSRPQAfC923mby/n4g0gAoQI8ph6HW
	V/Mw2Hgr0DwgK9YbVDEsf59EgwWHdXJN9q7tj1dxKerxd9VNwFrNXrMsrnf9Hxn4
	f5tEGzJlGEEFyFO1IulnXYcJtgBf6/RuOI/yiW7lCncMtW/fhjGcmVscLqeqcthM
	ltCzWLg1KoRdMYoSPmsUtpEP9Bq9F2Ia3ovyaLqSbHCnn+aVCieDV7o5pL+nIigM
	jsJlxQwziQnFt58QvvGhg==
X-ME-Sender: <xms:SHqaaWqShvR_IxI6ytH7OwTAjhS1g8I7mg-UXrFC-bXX2feJkQurkg>
    <xme:SHqaaW6XXembEJKxs_a0i8vOCL1pJ0FPXR0a8g8A6XhSNmiIvAOtH2sW1xStfCg9f
    -y3h30gizJw7z6eco8zrQTyiyJGLsju_dq3ILwHTOHIDvRGWA>
X-ME-Received: <xmr:SHqaadcpklsAQvxma2lsVRI9X1vZ_CJXtDTtUGDBoLoo5ZTryQwem9vr5d8faTiz5EKFyr5m_fGluhOm_SQ1gZGzDU4mLdWkRCiQJaviiDYR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeefvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthhtohepjhhlrgihthhonheskh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SHqaab5otuF6lbojTa6kBaZ3lOrG7vBiPzAcqE72lZfDMPfLpxPf8g>
    <xmx:SHqaaUshopfu-xtSkR3b_VMEFy-u5XugeWy89I29eXq49xq7KdjtGg>
    <xmx:SHqaabjuYkci_0ogNPCm3Vv1Oield_oTSouNW2G0hHIbvxBHs9529w>
    <xmx:SHqaafpPE12RFrHALbWquThHHwGPUd65ipq3hHPJHhPlo0I4Pa8utg>
    <xmx:SHqaaS9mv1VUY5jmvJG9Plb-sFK_wS4d-8vNGJnb4rRsWoSa2hmqBsNW>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Feb 2026 22:38:46 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Dai Ngo" <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, okorniev@redhat.com,
 tom@talpey.com, hch@lst.de, linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH 1/1] NFSD: Expose callback statistics in /proc/net/rpc/nfsd
In-reply-to: <20260221215733.3643669-1-dai.ngo@oracle.com>
References: <20260221215733.3643669-1-dai.ngo@oracle.com>
Date: Sun, 22 Feb 2026 14:38:41 +1100
Message-id: <177173152164.8396.12929618094338409157@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19085-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,brown.name:replyto,ownmail.net:dkim,messagingengine.com:dkim,noble.neil.brown.name:mid]
X-Rspamd-Queue-Id: 987FE16E731
X-Rspamd-Action: no action

On Sun, 22 Feb 2026, Dai Ngo wrote:
> Extend /proc/net/rpc/nfsd output to report NFSv4 callback activity:
>=20
> . Add system-wide counters for each callback operation.

Why system-wide rather than per-net-namespace?

NeilBrown


> . Add per-client callback operation statistics, similar to mountstats(8)
>   raw format.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4callback.c | 33 ++++++++++++++++++++++++++++++++-
>  fs/nfsd/nfsd.h         |  1 +
>  fs/nfsd/stats.c        |  2 ++
>  3 files changed, 35 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index e00b2aea8da2..5d6c91b2da24 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -36,6 +36,7 @@
>  #include <linux/sunrpc/xprt.h>
>  #include <linux/sunrpc/svc_xprt.h>
>  #include <linux/slab.h>
> +#include <linux/sunrpc/metrics.h>
>  #include "nfsd.h"
>  #include "state.h"
>  #include "netns.h"
> @@ -1016,7 +1017,7 @@ static int nfs4_xdr_dec_cb_offload(struct rpc_rqst *r=
qstp,
>  	.p_decode  =3D nfs4_xdr_dec_##restype,				\
>  	.p_arglen  =3D NFS4_enc_##argtype##_sz,				\
>  	.p_replen  =3D NFS4_dec_##restype##_sz,				\
> -	.p_statidx =3D NFSPROC4_CB_##call,				\
> +	.p_statidx =3D NFSPROC4_CLNT_##proc,				\
>  	.p_name    =3D #proc,						\
>  }
> =20
> @@ -1786,3 +1787,33 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
>  		nfsd41_cb_inflight_end(clp);
>  	return queued;
>  }
> +
> +void nfsd4_show_cb_stats(struct nfsd_net *nn, struct seq_file *seq)
> +{
> +	const struct rpc_procinfo *pinfo;
> +	const struct rpc_version *ver;
> +	struct nfs4_client *clp;
> +	int ix;
> +
> +	/* display system-wide status, count per op */
> +	ver =3D cb_program.version[1];
> +	for (ix =3D 0; ix < ver->nrprocs; ix++) {
> +		pinfo =3D &ver->procs[ix];
> +		if (pinfo->p_name)
> +			seq_printf(seq, "%s: %d\n",
> +				pinfo->p_name, ver->counts[pinfo->p_statidx]);
> +	}
> +
> +	/* display per-client status, similar to mountstats(8) in raw format */
> +	spin_lock(&nn->client_lock);
> +	for (ix =3D 0; ix < CLIENT_HASH_SIZE; ix++) {
> +		list_for_each_entry(clp, &nn->conf_id_hashtbl[ix], cl_idhash) {
> +			if (!clp->cl_cb_client)
> +				continue;
> +			seq_printf(seq, "\nClient[%pISpc]:\n",
> +					(struct sockaddr *)&clp->cl_addr);
> +			rpc_clnt_show_stats(seq, clp->cl_cb_client);
> +		}
> +	}
> +	spin_unlock(&nn->client_lock);
> +}
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 7c009f07c90b..cec0c6167ddb 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -591,6 +591,7 @@ extern void nfsd4_ssc_init_umount_work(struct nfsd_net =
*nn);
>  #endif
> =20
>  extern void nfsd4_init_leases_net(struct nfsd_net *nn);
> +void nfsd4_show_cb_stats(struct nfsd_net *nn, struct seq_file *seq);
> =20
>  #else /* CONFIG_NFSD_V4 */
>  static inline int nfsd4_is_junction(struct dentry *dentry)
> diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
> index f7eaf95e20fc..cc601719ef26 100644
> --- a/fs/nfsd/stats.c
> +++ b/fs/nfsd/stats.c
> @@ -66,6 +66,8 @@ static int nfsd_show(struct seq_file *seq, void *v)
>  		percpu_counter_sum_positive(&nn->counter[NFSD_STATS_WDELEG_GETATTR]));
> =20
>  	seq_putc(seq, '\n');
> +
> +	nfsd4_show_cb_stats(nn, seq);
>  #endif
> =20
>  	return 0;
> --=20
> 2.47.3
>=20
>=20


