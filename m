Return-Path: <linux-nfs+bounces-16778-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FAEC92897
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 17:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEA694E8699
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 16:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAF32C0F9A;
	Fri, 28 Nov 2025 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRt5CHv8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB77E2BE642
	for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764346214; cv=none; b=Dc1/5616GoQnIeu02Mt3lrIpa37aeexU6sQhfh4gCd60DRJysEfn+A187CyrMz/xahQVxQT2SF41lqsvZDgEtdRGO3AbJO5pGw3ayRKgfwDF1ElNYOKpacL8fFhCLIhE+pkuTzdOxmRwRCiJpPXmOIIJ+TKZPODzbMlIi1J497c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764346214; c=relaxed/simple;
	bh=c2zWhp2RJqU2nU6nDW9HWiyniJi6tMNj5lODJCkdQ6U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=k9ptVY5iaY9VLTdUOYz2QSRt3asWa/vRWVYaJBwiZeR/Ls2gIJNE0cQqW/nFjQ8LT/apdAHBlG8UKDd9HDqfD/jhaxPVm4Wilu0/DKfiP+tFYFc1iYbzwbEnl5x4u+r38gdbEEYV2/peG1PsehDlqfPY4wbvMRo2rD42jRR3xDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRt5CHv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79D1C4CEF1;
	Fri, 28 Nov 2025 16:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764346214;
	bh=c2zWhp2RJqU2nU6nDW9HWiyniJi6tMNj5lODJCkdQ6U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QRt5CHv8HZ148hu6sQnCDu55EjtvK/1RjIQaHxcHo6X4FLjmtf6fA/0KaTWp1PlDK
	 fDAr8pNG68GneFOV4zUE9lIQb+Kfnf5k9CS3AL5VdITZJZSdxnlHBqpVCO3YQaV96s
	 i73DV4blEL2xyC+8qbeAj9qqcF0cSEWzngbO2QRGvCBD4F6QIgMpbdYj9theB6/arL
	 vmK6+f2m6KSqRFdkkI/m84PF0zncR1YK6P1S/j0Gxcww82JV80dvjxIgC/svBqZjfS
	 UqDGBvY/vKXai8b8+PXbCv5d2ToKxdwcx0+8rP7vwotvDtorhWq48dcR1WPpi6P6V8
	 Kj2m2f9daK6zQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id F14E3F40069;
	Fri, 28 Nov 2025 11:10:12 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 28 Nov 2025 11:10:12 -0500
X-ME-Sender: <xms:ZMkpaf4WFbSA6akSDCb1hkSl-yPF1c6BGJr02LiSyjwJtr71C0C-Zw>
    <xme:ZMkpafvRWfE261OGgDQOE2FapRLVwgtM1hsmbuQ2lO5ev24t59RbjtP4yRHjxaJ3I
    Wd_y3GpWG8q4VBxi6BaeXHjrBw7gzfyCi1XkJrWh5OydeIUcFmdFCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedtfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhuhgtkh
    drlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheprghilhhiohhpsehsuhhs
    vgdrtghomhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:ZMkpach_YohZmY0QVCaQ_yJunf_nD5FduGPPztgbvjNHlha2MM2nGw>
    <xmx:ZMkpaS0mPqZ4otZDT_RGm7vdyEXBwt1YcS-1EoOs_gGDEkY3aqkOBA>
    <xmx:ZMkpaejkf4OLrCJicvaJwa2_85_AoBZNbX8wKnkg3F6NSFfaQvGoZw>
    <xmx:ZMkpaac0k2nJBcExW-beGil8-Z5HrY98EyfB6WhKgPmGa_cqMmpdEg>
    <xmx:ZMkpaZmI2hjI70_xqVW_QBK-kkyKzt3OA_KXDU34Hu38-iE5eFQn1ZRC>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B1F30780054; Fri, 28 Nov 2025 11:10:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AieIdV2Ewi8g
Date: Fri, 28 Nov 2025 11:09:52 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Anthony Iliopoulos" <ailiop@suse.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Message-Id: <388da717-eb5a-4497-99f7-6a6f34405b58@app.fastmail.com>
In-Reply-To: <20251127175753.134132-2-ailiop@suse.com>
References: <20251127175753.134132-1-ailiop@suse.com>
 <20251127175753.134132-2-ailiop@suse.com>
Subject: Re: [PATCH 1/2] nfsd: never defer requests during idmap lookup
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Nov 27, 2025, at 12:57 PM, Anthony Iliopoulos wrote:
> During v4 request compound arg decoding, some ops (e.g. SETATTR) can
> trigger idmap lookup upcalls. When those upcall responses get delayed
> beyond the allowed time limit, cache_check() will mark the request for
> deferral and cause it to be dropped.

The RFCs mandate that NFSv4 servers MUST NOT drop requests. What
nfsd_dispatch() does in your case is return RPC_GARBAGE_ARGS to
the client, which is distinct behavior from "dropping" a request.
Please update the patch description (if I've understood correctly).

But agreed, RPC_GARBAGE_ARGS is still the wrong server response
for a timed-out idmap upcall.


> This prevents nfs4svc_encode_compoundres from being executed, and thus the
> session slot flag NFSD4_SLOT_INUSE never gets cleared. Subsequent client
> requests will fail with NFSERR_JUKEBOX, given that the slot will be marked
> as in-use, making the SEQUENCE op fail.

Yes, this is pure badness.


> Fix this by making sure that the RQ_USEDEFERRAL flag is always clear during
> nfs4svc_decode_compoundargs(), since no v4 request should ever be deferred.

Help me understand how the upcall failure during XDR decoding is
handled later? What server response is returned? Is it possible
for the proc function to execute anyway with incorrect uid and
gid values?


> Fixes: 2f425878b6a7 ("nfsd: don't use the deferral service, return 
> NFS4ERR_DELAY")
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
>  fs/nfsd/nfs4xdr.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 6040a6145dad..0a1a46b750ef 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -5989,6 +5989,7 @@ bool
>  nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
>  {
>  	struct nfsd4_compoundargs *args = rqstp->rq_argp;
> +	bool ret = false;
> 
>  	/* svcxdr_tmp_alloc */
>  	args->to_free = NULL;
> @@ -5997,7 +5998,11 @@ nfs4svc_decode_compoundargs(struct svc_rqst 
> *rqstp, struct xdr_stream *xdr)
>  	args->ops = args->iops;
>  	args->rqstp = rqstp;
> 
> -	return nfsd4_decode_compound(args);
> +	clear_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
> +	ret = nfsd4_decode_compound(args);
> +	set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
> +
> +	return ret;
>  }
> 
>  bool
> -- 
> 2.52.0

-- 
Chuck Lever

