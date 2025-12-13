Return-Path: <linux-nfs+bounces-17079-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FCECBB3FB
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 22:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A3CA300A1E2
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 21:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F29280014;
	Sat, 13 Dec 2025 21:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+1NP9fh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B07E26B08F
	for <linux-nfs@vger.kernel.org>; Sat, 13 Dec 2025 21:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765660255; cv=none; b=L1Uj/lW/pH+mbTI6nhPshNZfzL3IeAna+QNqhQQyvGwZxHZhNO1HgyS4BVMzIxwdWxrFlMfIxk58dhaNGGbXO1tXLftRdIqLc+gP6Zb4aEXciLRX/10BKlXhbjYPfpDzP8hfFFasMvIuX2ANOl3hm6/CPl1szN5ZugP0dXUZoS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765660255; c=relaxed/simple;
	bh=jpjwtYSJkr0mZU5QKZYD4vZiUS5VoG+itugpSgTaR0A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ocTN5VFGv3BqJ5tdnYLekTzqRc3D4/F+GSTMAiWm94a80d8oDCmCkoULZOA9gPTwQCPNAY3cHI6/M25AFDTtctVNSbnOSdUcL/+WMz7p+U6OECcLwBb1KGCXqquM9aJf08Fom34Vkxs50+6Ll9DFqEEGl7oPN+J4ncX3qTVW3Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+1NP9fh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F2AC4CEF7;
	Sat, 13 Dec 2025 21:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765660255;
	bh=jpjwtYSJkr0mZU5QKZYD4vZiUS5VoG+itugpSgTaR0A=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=D+1NP9fhWKVyBoiFCVOju/gXBGSqp6XhrvPCOG3UyWy4LBbmqLpmswoU5nRjoirzq
	 ztcmiKELyOz7DAWvolTY974qmp+nrZf1muDcEyXOCMhi1w7R8fcnIdzehujA0lLrmr
	 zbAX5pKXSvx9TYZqcnmjA5MatGNauYFXyUPcyvIWBP133NsJO3L/xlGZbd5of92TKu
	 dUywaed0+7n5p1tb8r4Z5RQ1CK+MNgcmMZwMosjNhMXcNzuwN3Sr4mNxsbuIy+qFGP
	 UwV/VueAZ+DGPVY3edPRCYp389Y9EsBG/+Jy/XUQZAf5NYtPyyTHmMzMOpZ2S2SJOF
	 6m4hsyp4N2SxA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9EA6BF40070;
	Sat, 13 Dec 2025 16:10:53 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 13 Dec 2025 16:10:53 -0500
X-ME-Sender: <xms:XdY9aVob_4fV91FgDsyIfiEeB23uOIE36Om3tVmva9rPzUcCuLiO0g>
    <xme:XdY9aSdVuDhE0nJQQ1vQLEtLmN4Ru9MvxsEdp6oE0qkMF2ijwpjNM1cr5Ylx318ip
    QR8mFfc4w_gqpEGrl8eotSD-sfosf1W_caF4cLp4kEQkwttbzg4hh5V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopegrnhhnrgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepthhrohhnughmhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrih
    drnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhes
    ohhrrggtlhgvrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtg
    homhdprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XdY9aUXtLdierDwtJLQ5uvgZqVyqLYSRB-CX-n62NUrV8RZZZzpvyg>
    <xmx:XdY9ael7WLmdNfHrpje43e_Zz4-CPq06IeWycRPyYCk2MNOCyleMIA>
    <xmx:XdY9aTOBjEbaDm386HEPnc8y7kKfn46h0KJzlIvFhJXaZQw_IgKyjw>
    <xmx:XdY9aWLlXF0ByBmiNTB4mnfxnKnfIIuXCs_mXYGVZzma6-2eiZHxsg>
    <xmx:XdY9ad14djKk9ZlNYJJRDXUrO0wv3Z29H8hHymWcbhe2l97L4W4AFUHE>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7F0D2780054; Sat, 13 Dec 2025 16:10:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AE-iaDe4gSPF
Date: Sat, 13 Dec 2025 16:10:29 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <476dcf18-242c-40b2-8afa-ca2128fe4895@app.fastmail.com>
In-Reply-To: <20251213-nfsd-dynathread-v1-6-de755e59cbc4@kernel.org>
References: <20251213-nfsd-dynathread-v1-0-de755e59cbc4@kernel.org>
 <20251213-nfsd-dynathread-v1-6-de755e59cbc4@kernel.org>
Subject: Re: [PATCH RFC 6/6] nfsd: add controls to set the minimum number of threads
 per pool
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Dec 12, 2025, at 5:39 PM, Jeff Layton wrote:
> Add a new "min_threads" variable to the nfsd_net, along with the
> corresponding nfsdfs and netlink interfaces to set that value from
> userland. Pass that value to svc_set_pool_threads() and
> svc_set_num_threads().
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  Documentation/netlink/specs/nfsd.yaml |  5 ++++
>  fs/nfsd/netlink.c                     |  5 ++--
>  fs/nfsd/netns.h                       |  6 +++++
>  fs/nfsd/nfsctl.c                      | 50 +++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfssvc.c                      |  8 +++---
>  fs/nfsd/trace.h                       | 19 +++++++++++++
>  include/uapi/linux/nfsd_netlink.h     |  1 +
>  7 files changed, 88 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/netlink/specs/nfsd.yaml 
> b/Documentation/netlink/specs/nfsd.yaml
> index 
> 100363029e82aed87295e34a008ab771a95d508c..badb2fe57c9859c6932c621a589da694782b0272 
> 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -78,6 +78,9 @@ attribute-sets:
>        -
>          name: scope
>          type: string
> +      -
> +        name: min-threads
> +        type: u32
>    -
>      name: version
>      attributes:
> @@ -159,6 +162,7 @@ operations:
>              - gracetime
>              - leasetime
>              - scope
> +            - min-threads
>      -
>        name: threads-get
>        doc: get the number of running threads
> @@ -170,6 +174,7 @@ operations:
>              - gracetime
>              - leasetime
>              - scope
> +            - min-threads
>      -
>        name: version-set
>        doc: set nfs enabled versions
> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 
> ac51a44e1065ec3f1d88165f70a831a828b58394..887525964451e640304371e33aa4f415b4ff2848 
> 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -24,11 +24,12 @@ const struct nla_policy 
> nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] = {
>  };
> 
>  /* NFSD_CMD_THREADS_SET - do */
> -static const struct nla_policy 
> nfsd_threads_set_nl_policy[NFSD_A_SERVER_SCOPE + 1] = {
> +static const struct nla_policy 
> nfsd_threads_set_nl_policy[NFSD_A_SERVER_MIN_THREADS + 1] = {
>  	[NFSD_A_SERVER_THREADS] = { .type = NLA_U32, },
>  	[NFSD_A_SERVER_GRACETIME] = { .type = NLA_U32, },
>  	[NFSD_A_SERVER_LEASETIME] = { .type = NLA_U32, },
>  	[NFSD_A_SERVER_SCOPE] = { .type = NLA_NUL_STRING, },
> +	[NFSD_A_SERVER_MIN_THREADS] = { .type = NLA_U32, },
>  };
> 
>  /* NFSD_CMD_VERSION_SET - do */
> @@ -57,7 +58,7 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
>  		.cmd		= NFSD_CMD_THREADS_SET,
>  		.doit		= nfsd_nl_threads_set_doit,
>  		.policy		= nfsd_threads_set_nl_policy,
> -		.maxattr	= NFSD_A_SERVER_SCOPE,
> +		.maxattr	= NFSD_A_SERVER_MIN_THREADS,
>  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>  	},
>  	{
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 
> 3e2d0fde80a7ce434ef2cce9f1666c2bd16ab2eb..1c3449810eaefea8167ddd284af7bd66cac7e211 
> 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -128,6 +128,12 @@ struct nfsd_net {
>  	seqlock_t writeverf_lock;
>  	unsigned char writeverf[8];
> 
> +	/*
> +	 * Minimum number of threads to run per pool.  If 0 then the
> +	 * min == max requested number of threads.
> +	 */
> +	unsigned int min_threads;
> +
>  	u32 clientid_base;
>  	u32 clientid_counter;
>  	u32 clverifier_counter;
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 
> 206534fccf36a992026669fee6533adff1062c36..a5401015e62499d07150cde8822f1e7dd0515dfe 
> 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -48,6 +48,7 @@ enum {
>  	NFSD_Versions,
>  	NFSD_Ports,
>  	NFSD_MaxBlkSize,
> +	NFSD_MinThreads,
>  	NFSD_Filecache,
>  	NFSD_Leasetime,
>  	NFSD_Gracetime,
> @@ -67,6 +68,7 @@ static ssize_t write_pool_threads(struct file *file, 
> char *buf, size_t size);
>  static ssize_t write_versions(struct file *file, char *buf, size_t 
> size);
>  static ssize_t write_ports(struct file *file, char *buf, size_t size);
>  static ssize_t write_maxblksize(struct file *file, char *buf, size_t 
> size);
> +static ssize_t write_minthreads(struct file *file, char *buf, size_t 
> size);
>  #ifdef CONFIG_NFSD_V4
>  static ssize_t write_leasetime(struct file *file, char *buf, size_t 
> size);
>  static ssize_t write_gracetime(struct file *file, char *buf, size_t 
> size);
> @@ -85,6 +87,7 @@ static ssize_t (*const write_op[])(struct file *, 
> char *, size_t) = {
>  	[NFSD_Versions] = write_versions,
>  	[NFSD_Ports] = write_ports,
>  	[NFSD_MaxBlkSize] = write_maxblksize,
> +	[NFSD_MinThreads] = write_minthreads,
>  #ifdef CONFIG_NFSD_V4
>  	[NFSD_Leasetime] = write_leasetime,
>  	[NFSD_Gracetime] = write_gracetime,
> @@ -899,6 +902,46 @@ static ssize_t write_maxblksize(struct file *file, 
> char *buf, size_t size)
>  							nfsd_max_blksize);
>  }
> 
> +/*
> + * write_minthreads - Set or report the current min number of threads
> + *
> + * Input:
> + *			buf:		ignored
> + *			size:		zero
> + * OR
> + *
> + * Input:
> + *			buf:		C string containing an unsigned
> + *					integer value representing the new
> + *					max number of threads

s/max number of threads/min number of threads


> + *			size:		non-zero length of C string in @buf
> + * Output:
> + *	On success:	passed-in buffer filled with '\n'-terminated C string
> + *			containing numeric value of min_threads setting
> + *			for this net namespace;
> + *			return code is the size in bytes of the string
> + *	On error:	return code is zero or a negative errno value
> + */
> +static ssize_t write_minthreads(struct file *file, char *buf, size_t 
> size)
> +{
> +	char *mesg = buf;
> +	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
> +	unsigned int minthreads = nn->min_threads;
> +
> +	if (size > 0) {

What if @size is a very large number?


> +		int rv = get_uint(&mesg, &minthreads);
> +
> +		if (rv)
> +			return rv;
> +		trace_nfsd_ctl_minthreads(netns(file), minthreads);
> +		mutex_lock(&nfsd_mutex);
> +		nn->min_threads = minthreads;
> +		mutex_unlock(&nfsd_mutex);
> +	}
> +
> +	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", minthreads);
> +}
> +
>  #ifdef CONFIG_NFSD_V4
>  static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t 
> size,
>  				  time64_t *time, struct nfsd_net *nn)
> @@ -1292,6 +1335,7 @@ static int nfsd_fill_super(struct super_block 
> *sb, struct fs_context *fc)
>  		[NFSD_Versions] = {"versions", &transaction_ops, S_IWUSR|S_IRUSR},
>  		[NFSD_Ports] = {"portlist", &transaction_ops, S_IWUSR|S_IRUGO},
>  		[NFSD_MaxBlkSize] = {"max_block_size", &transaction_ops, 
> S_IWUSR|S_IRUGO},
> +		[NFSD_MinThreads] = {"min_threads", &transaction_ops, 
> S_IWUSR|S_IRUGO},
>  		[NFSD_Filecache] = {"filecache", &nfsd_file_cache_stats_fops, 
> S_IRUGO},
>  #ifdef CONFIG_NFSD_V4
>  		[NFSD_Leasetime] = {"nfsv4leasetime", &transaction_ops, 
> S_IWUSR|S_IRUSR},
> @@ -1636,6 +1680,10 @@ int nfsd_nl_threads_set_doit(struct sk_buff 
> *skb, struct genl_info *info)
>  			scope = nla_data(attr);
>  	}
> 
> +	attr = info->attrs[NFSD_A_SERVER_MIN_THREADS];
> +	if (attr)
> +		nn->min_threads = nla_get_u32(attr);
> +
>  	ret = nfsd_svc(nrpools, nthreads, net, get_current_cred(), scope);
>  	if (ret > 0)
>  		ret = 0;
> @@ -1675,6 +1723,8 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, 
> struct genl_info *info)
>  			  nn->nfsd4_grace) ||
>  	      nla_put_u32(skb, NFSD_A_SERVER_LEASETIME,
>  			  nn->nfsd4_lease) ||
> +	      nla_put_u32(skb, NFSD_A_SERVER_MIN_THREADS,
> +			  nn->min_threads) ||
>  	      nla_put_string(skb, NFSD_A_SERVER_SCOPE,
>  			  nn->nfsd_name);
>  	if (err)
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 
> 26c3a6cb1f400f1b757d26f6ba77e27deb7e8ee2..d6120dd843ac1b6a42f0ef331700f4d6d70d8c38 
> 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -594,7 +594,7 @@ void nfsd_shutdown_threads(struct net *net)
>  	}
> 
>  	/* Kill outstanding nfsd threads */
> -	svc_set_num_threads(serv, 0, 0);
> +	svc_set_num_threads(serv, 0, nn->min_threads);

Seems like this could actually /start/ threads during NFSD shutdown.
At the very least it needs an explanatory comment.


>  	nfsd_destroy_serv(net);
>  	mutex_unlock(&nfsd_mutex);
>  }
> @@ -704,7 +704,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct 
> net *net)
> 
>  	/* Special case: When n == 1, distribute threads equally among pools. */
>  	if (n == 1)
> -		return svc_set_num_threads(nn->nfsd_serv, nthreads[0], 0);
> +		return svc_set_num_threads(nn->nfsd_serv, nthreads[0], nn->min_threads);
> 
>  	if (n > nn->nfsd_serv->sv_nrpools)
>  		n = nn->nfsd_serv->sv_nrpools;
> @@ -732,7 +732,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct 
> net *net)
>  	for (i = 0; i < n; i++) {
>  		err = svc_set_pool_threads(nn->nfsd_serv,
>  					   &nn->nfsd_serv->sv_pools[i],
> -					   nthreads[i], 0);
> +					   nthreads[i], nn->min_threads);
>  		if (err)
>  			goto out;
>  	}
> @@ -741,7 +741,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct 
> net *net)
>  	for (i = n; i < nn->nfsd_serv->sv_nrpools; ++i) {
>  		err = svc_set_pool_threads(nn->nfsd_serv,
>  					   &nn->nfsd_serv->sv_pools[i],
> -					   0, 0);
> +					   0, nn->min_threads);
>  		if (err)
>  			goto out;
>  	}
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 
> 8885fd9bead98ebf55379d68ab9c3701981a5150..d1d0b0dd054588a8c20e3386356dfa4e9632b8e0 
> 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -2164,6 +2164,25 @@ TRACE_EVENT(nfsd_ctl_maxblksize,
>  	)
>  );
> 
> +TRACE_EVENT(nfsd_ctl_minthreads,
> +	TP_PROTO(
> +		const struct net *net,
> +		int minthreads
> +	),
> +	TP_ARGS(net, minthreads),
> +	TP_STRUCT__entry(
> +		__field(unsigned int, netns_ino)
> +		__field(int, minthreads)
> +	),
> +	TP_fast_assign(
> +		__entry->netns_ino = net->ns.inum;
> +		__entry->minthreads = minthreads
> +	),
> +	TP_printk("minthreads=%d",
> +		__entry->minthreads
> +	)
> +);
> +
>  TRACE_EVENT(nfsd_ctl_time,
>  	TP_PROTO(
>  		const struct net *net,
> diff --git a/include/uapi/linux/nfsd_netlink.h 
> b/include/uapi/linux/nfsd_netlink.h
> index 
> e157e2009ea8c1ef805301261d536c82677821ef..e9efbc9e63d83ed25fcd790b7a877c0023638f15 
> 100644
> --- a/include/uapi/linux/nfsd_netlink.h
> +++ b/include/uapi/linux/nfsd_netlink.h
> @@ -35,6 +35,7 @@ enum {
>  	NFSD_A_SERVER_GRACETIME,
>  	NFSD_A_SERVER_LEASETIME,
>  	NFSD_A_SERVER_SCOPE,
> +	NFSD_A_SERVER_MIN_THREADS,
> 
>  	__NFSD_A_SERVER_MAX,
>  	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)
>
> -- 
> 2.52.0

Thanks, Neil and Jeff, for pulling all this together. It's good to
have something we can noodle on now.


-- 
Chuck Lever

