Return-Path: <linux-nfs+bounces-20459-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DQWA16OxmlLLwUAu9opvQ
	(envelope-from <linux-nfs+bounces-20459-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 15:04:14 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60065345BA7
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 15:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 347BF30E7663
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 13:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1303E4C7B;
	Fri, 27 Mar 2026 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRDu12Qr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F253BA24F
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619821; cv=none; b=bCm6jhflN2L0sDm/kFrCJYZH9oqxoAINDoIMe9YHe0p39wIN3oqIVBJLn2wWBgrWmsYFhQXTinkuMKPnRDRtQsF1qmjGStAe36zmoyzZF6/9irqxZsKrjRS5r6AnmHz3PfO5GoMfpFsVXmQZbyeA9lN7Va4N3/0sf+mwEsTFWn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619821; c=relaxed/simple;
	bh=kdT7G15qg3hR2USwKG9HgWp5K2O1mK25wENX34sm9EI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Qeyn4fLGKOY8U+7EPI4sI7noTEbmJvnMRALlji91j0ldIISjf3KLfnAa4V9tN1s0BskBAzgBDp5y4jvOnkaZ+q6kDDtly8ngJWLZmVDJjLeSWWh7MkNwtZlhPxJgsH0ZINMCcezFC2BdFH8U2+n5uX3zwdrGjvlOe2USyS66Y00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRDu12Qr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18D7C4AF0B;
	Fri, 27 Mar 2026 13:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774619821;
	bh=kdT7G15qg3hR2USwKG9HgWp5K2O1mK25wENX34sm9EI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=TRDu12QrJ5tjniaxxpkb9R/z8Bfd4iV8LdsvQmbr1EkojdUDwjraUi8EU41axVfES
	 9A6Kf87WJ52MXqTQ28OqOlW24tECmCIe7nQzm4fLc+A/DA6veMgyc9hjx1PpXfmXoV
	 wG8oZjNs5WZN7c7DFw/uae3nJrGYVo4yA+aSgrCwIyyKP4zd3lQzxzo9kFxXG+H7+X
	 rDN0i7xB6r2CfqfCXDSfKNiXCk8iPMlLi5t4EKXSwU1UA+PBb58yPmxedTP3Ff1M4v
	 /7iu41K8UvxRDmXxQ0kuV4PJs0s+hArdg4kXzpF4Nxsh7KlffyI0AJcDnGiGezHxAx
	 5n1yWQSgQRecQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id AD7FEF40088;
	Fri, 27 Mar 2026 09:56:59 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 27 Mar 2026 09:56:59 -0400
X-ME-Sender: <xms:q4zGaSE6JUr0igJiFmNYa4RRd3A-gN3GZpD6TpAX3AxeuafOzOSjzA>
    <xme:q4zGaeI5DhTsnVjhIbBkABI1n668GknjchQwbcmfLPImFKwY41bOv66ENp9NMYRnB
    aJGWZOpEKvuremXDf1-impEbThDYCMVY7-deiWbdMoroFmQ0pG38w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopeduuddvkeekieduse
    gsuhhgshdruggvsghirghnrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprhgvghhrvghsshhiohhnsheslhgvvghmhhhuihhsrd
    hinhhfohdprhgtphhtthhopehtjhdrihgrmhdrthhjsehprhhothhonhdrmhgvpdhrtghp
    thhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuh
    igqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:q4zGaa28ALUyJf5JEmB2XqywlahwGPrdLDOdAyRFkOej5rcr8nZcVg>
    <xmx:q4zGafqjA-MOhNiajUEr4gJEmXizVnduPsz-duVdv50pyJSvgck_Sw>
    <xmx:q4zGaWhCdWvtso0VRS_7B1QahxbK19Qq0DZ0VSCR7VXJ4MN-fESD1w>
    <xmx:q4zGab9rA5AVWE2hiR_gVXgG4OXG6VpVJLPYAMUSi2bQRtVDQgwgSA>
    <xmx:q4zGaSWq1tvjcVzu_8R411MycQST9bn_qULrfE7BU97XTAMnw2Urb-AY>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7DA9E780070; Fri, 27 Mar 2026 09:56:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_jyC0Lb0WUR
Date: Fri, 27 Mar 2026 09:56:38 -0400
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Thorsten Leemhuis" <regressions@leemhuis.info>, 1128861@bugs.debian.org,
 Tj <tj.iam.tj@proton.me>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, stable@vger.kernel.org
Message-Id: <465012d6-c824-4d8d-b6f6-8a2d85e30154@app.fastmail.com>
In-Reply-To: 
 <177456522377.1851489.16395975485525163031@noble.neil.brown.name>
References: <c0f15088-3fc0-487a-9f24-cf89c158420d@proton.me>
 <177266540127.7472.3460090956713656639@noble.neil.brown.name>
 <6ba41798-9c69-44f5-9a4e-09336c75a4b9@leemhuis.info>
 <cf78feb7ffaee6ed478afb734d2ede149597de86.camel@kernel.org>
 <177434721528.7102.13514118512738778346@noble.neil.brown.name>
 <d4773958-5ae5-42d4-b785-6598b5c9b27a@app.fastmail.com>
 <177442248735.2237155.773724155681455344@noble.neil.brown.name>
 <a6e6a731-2885-4510-87dd-45e6a8f4fbd7@app.fastmail.com>
 <177456522377.1851489.16395975485525163031@noble.neil.brown.name>
Subject: Re: [PATCH v2] lockd: fix TEST handling when not all permissions are
 available.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20459-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brown.name:email,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 60065345BA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Thu, Mar 26, 2026, at 6:47 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
>
> The F_GETLK fcntl can work with either read access or write access or
> both.  It can query F_RDLCK and F_WRLCK locks in either case.

> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> index 4b6f18d97734..75e020a8bfd0 100644
> --- a/fs/lockd/svc4proc.c
> +++ b/fs/lockd/svc4proc.c
> @@ -26,6 +26,8 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct 
> nlm_args *argp,
>  	struct nlm_host		*host = NULL;
>  	struct nlm_file		*file = NULL;
>  	struct nlm_lock		*lock = &argp->lock;
> +	bool			is_test = (rqstp->rq_proc == NLMPROC_TEST ||
> +					   rqstp->rq_proc == NLMPROC_TEST_MSG);
>  	__be32			error = 0;
> 
>  	/* nfsd callbacks must have been installed for this procedure */
> @@ -46,15 +48,20 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, 
> struct nlm_args *argp,
>  	if (filp != NULL) {
>  		int mode = lock_to_openmode(&lock->fl);
> 
> +		if (is_test)
> +			mode = O_RDWR;
> +
>  		lock->fl.c.flc_flags = FL_POSIX;
> 
> -		error = nlm_lookup_file(rqstp, &file, lock);
> +		error = nlm_lookup_file(rqstp, &file, lock, mode);
>  		if (error)
>  			goto no_locks;
>  		*filp = file;
> -
>  		/* Set up the missing parts of the file_lock structure */
> -		lock->fl.c.flc_file = file->f_file[mode];
> +		if (is_test)
> +			lock->fl.c.flc_file = nlmsvc_file_file(file);
> +		else
> +			lock->fl.c.flc_file = file->f_file[mode];
>  		lock->fl.c.flc_pid = current->tgid;
>  		lock->fl.fl_start = (loff_t)lock->lock_start;
>  		lock->fl.fl_end = lock->lock_len ?

We have a new problem now (or maybe just I do).

I think the stable folks will insist on this fix going into
upstream first. However, this version of the fix does not
apply to nfsd-testing because that branch has the NLMv4
xdrgen rewrite.

That rewrite is not likely to be backported to LTS. So this
version will have to be directed to stable once upstream has
been fixed. We cannot rely on automation to get upstream's
version of the fix backported to v6.19 and earlier.


-- 
Chuck Lever

