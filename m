Return-Path: <linux-nfs+bounces-18721-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id n62TNXGVg2nYpgMAu9opvQ
	(envelope-from <linux-nfs+bounces-18721-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 19:52:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC2FEBC3A
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 19:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECEE0301B92E
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 18:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAF6348865;
	Wed,  4 Feb 2026 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrvnJwdd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB36346AFC;
	Wed,  4 Feb 2026 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770231098; cv=none; b=DQS2dmO/1JRL5KoEP30RHMPxo998SfcvGzXl5AFQBX8EgBNNsGMf1bL6ts/0FCVft7rSjuwKCz4rjgRIKzrYpH0jlUGZAV4Z7S+8iJybfQJ6IU044Xn5cl9Xhsti1+t+GeYvpZ9jCyf4uvgHuXhBh3Wsa+py6eymvRb3Q7drSu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770231098; c=relaxed/simple;
	bh=mrKJ0ilenmS014guVFKpyxepJMZwOptObmXyiUq7SgY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SC/Wg4+9Kr85jgf6GcyJx1/LlgFL1R+3PiHpGVq1w06DsDGapa7KmY+RzIkW5un6jO9OHBRIUA1R6SWtOPIhGUmKNWxsw0gLExd/8ocRpZTVDvRBiv5vwpIjDEBn1xW6r7kCE5fnCySMEcQoJagHn0z08ZjmAN54cpAkKGQNM0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrvnJwdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA5AC116C6;
	Wed,  4 Feb 2026 18:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770231098;
	bh=mrKJ0ilenmS014guVFKpyxepJMZwOptObmXyiUq7SgY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=FrvnJwdd/v5CwafIjhd2qpJIHag7SYvYVOSjvGUTPGPWZIZG0oYXnCY9JShmiy7Pt
	 Qi5KfvSp5Qb421b6oeozBMpAbZ9Qvg7dTVDxGDpCBDYDdMtHdHsU1Dc3EhgWysZYMz
	 hbD10tbJeMOWjFzk0W06aSnbv7QJ87NBgN3nBL5SDgeBp7mKRAeVMmw8Tep6vD2RCe
	 rmQx/xLSbm4ReTySLhjgDK1WMGSq6GwpyiAgdSmIyMCuLfoupyj1P8Qzg6AWd9uOcz
	 zGCFJmu32W34qkZu9xag5iUEuGCMl0HsGTkVyeIFj0Ik+z8a+B5rKhd3rYcwUARpJd
	 0On1htxw2nO1Q==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5058EF40068;
	Wed,  4 Feb 2026 13:51:37 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 04 Feb 2026 13:51:37 -0500
X-ME-Sender: <xms:OZWDafAzuU3kJOjDKwLcUxtGzCXXJcD34onwJOtU5W2PH4Y3oMnfEQ>
    <xme:OZWDaQWRU1mUFoantGUe5oWbaAD6GcuRSRIvlyA_GLw5u-2N9xK-Hi6UkfrtW_9-N
    OezPaUAHxtzOHcMuI9_fMYtMIgR4yFtiVhY0iL7sKLztQV6-8XCXYE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeefvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtgho
    mhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtph
    htthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhes
    thgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OZWDaUC4uey59-48PZwTScrMvTRdeJfW2FrBR0HZK4_HtW4_UbYfaA>
    <xmx:OZWDaSjxVOKET2yO_OQVyAsbdWX0UlBnEuqBPJyvc_iq0t656I8qfg>
    <xmx:OZWDaZzudzIyZMPZIviL8TY7zaIsPCGaDZpHp2DhpcMK-SBHTX2vwg>
    <xmx:OZWDab2g9K84sZM7-7Z9ulybR8xf1ME2iUC20HyprU6peqI4zBDsaw>
    <xmx:OZWDaW8T7E6bXQO77GTdjn2Te6x7975iSgo2CR9kxqi72ndItpncLJDQ>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 292F2780078; Wed,  4 Feb 2026 13:51:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A18mrXQRg9Us
Date: Wed, 04 Feb 2026 13:51:17 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <2abf7a33-789f-405d-8993-8fbf30153aaa@app.fastmail.com>
In-Reply-To: <20260204-minthreads-v1-1-7480176baf35@kernel.org>
References: <20260204-minthreads-v1-1-7480176baf35@kernel.org>
Subject: Re: [PATCH] nfsd: report the requested maximum number of threads instead of
 number running
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18721-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3EC2FEBC3A
X-Rspamd-Action: no action



On Wed, Feb 4, 2026, at 12:23 PM, Jeff Layton wrote:
> The current netlink and /proc interfaces deviate from their traditional
> values when dynamic threading is enabled, and there is currently no way
> to know what the current setting is. This patch brings the reporting
> back in line with traditional behavior.
>
> Make these interfaces report the requested maximum number of threads
> instead of the number currently running.
>
> Fixes: d8316b837c2c ("nfsd: add controls to set the minimum number of 
> threads per pool")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> I think this is less surprising than the current behavior of what's in
> Chuck's tree. We could also consider adding netlink attributes to report
> the number of running threads, but you can get that info from ps too.
> ---
>  fs/nfsd/nfsctl.c | 2 +-
>  fs/nfsd/nfssvc.c | 7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 
> 4d8e3c1a7be3b3a4e4f5248b27b60d6b3ae88d51..178c7646b2e25630b85de937d7ced18947c047f9 
> 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1700,7 +1700,7 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, 
> struct genl_info *info)
>  			struct svc_pool *sp = &nn->nfsd_serv->sv_pools[i];
> 
>  			err = nla_put_u32(skb, NFSD_A_SERVER_THREADS,
> -					  sp->sp_nrthreads);
> +					  sp->sp_nrthrmax);
>  			if (err)
>  				goto err_unlock;
>  		}
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 
> 8184514c58de8e396795cd4714a04d66d9637f17..be0add971c2d994948c3e8fca19bcf6f3c75dfaf 
> 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -239,12 +239,13 @@ static void nfsd_net_free(struct percpu_ref *ref)
> 
>  int nfsd_nrthreads(struct net *net)
>  {
> -	int rv = 0;
> +	int i, rv = 0;
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> 
>  	mutex_lock(&nfsd_mutex);
>  	if (nn->nfsd_serv)
> -		rv = nn->nfsd_serv->sv_nrthreads;
> +		for (i = 0; i < nn->nfsd_serv->sv_nrpools; ++i)
> +			rv += nn->nfsd_serv->sv_pools[i].sp_nrthrmax;
>  	mutex_unlock(&nfsd_mutex);
>  	return rv;
>  }
> @@ -673,7 +674,7 @@ int nfsd_get_nrthreads(int n, int *nthreads, struct 
> net *net)
> 
>  	if (serv)
>  		for (i = 0; i < serv->sv_nrpools && i < n; i++)
> -			nthreads[i] = serv->sv_pools[i].sp_nrthreads;
> +			nthreads[i] = serv->sv_pools[i].sp_nrthrmax;
>  	return 0;
>  }

AI code review observes that:

The documentation should be updated to reflect that these interfaces
now report the configured maximum threads rather than running threads:

1. Documentation/netlink/specs/nfsd.yaml line 168 - threads-get is
   documented as "get the number of running threads" but now returns
   the configured maximum
2. fs/nfsd/nfsctl.c lines 387-405 - The write_threads() docstring
   says it reports "the number of running NFSD threads" but now
   reports the configured maximum
3. fs/nfsd/nfsctl.c lines 1666-1673 - The nfsd_nl_threads_get_doit()
   docstring says "get the number of running threads"


-- 
Chuck Lever

