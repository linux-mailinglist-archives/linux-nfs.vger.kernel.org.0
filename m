Return-Path: <linux-nfs+bounces-16762-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 24380C8F8AC
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 17:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CEB4C34AEEF
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 16:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502FF27E06C;
	Thu, 27 Nov 2025 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5yPOkm0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEBC2264C9
	for <linux-nfs@vger.kernel.org>; Thu, 27 Nov 2025 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764261672; cv=none; b=mWVciwXVXNGU73vJYV8rTqO5FIfEZ5CZfjCdQ9oh/Q6vmXubopb0HXcVQpE+jGos32XQ7iVYuzgVHIrN7PAGdCNJpALa0fc1zQm3ZT3Tp1w83QKdDIesDr6/q4I5wt8IfmUtupOXKTNzGmLqv9Mq88UO0GuzzndsM5a+rctCSBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764261672; c=relaxed/simple;
	bh=iyGr5W8zeG2/O89oucajX2UM0wSj2BBQQCPMJ/4Ibvk=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=n1jcTljzCxy5664WsOl/tls1QeFmwDHZIDBzziE4kYOLhtM0F6Akc0pF4sjDYetefTCCiBgpQ61Wfxv2jdtNNOrZUMlrTSnmJUeo2Kk+HQ2OIZYlDz4OP1VUkr4c0wPJzP6hb+ukmQJVxp1Nb1/PbU7HAESRwZuUGBuYCe4oFFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5yPOkm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F129C4CEF8
	for <linux-nfs@vger.kernel.org>; Thu, 27 Nov 2025 16:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764261671;
	bh=iyGr5W8zeG2/O89oucajX2UM0wSj2BBQQCPMJ/4Ibvk=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=e5yPOkm0shT7Qy5jKFBqPP7REX19CBqWVWcEEyIsw3EuzN+vatuVgLTs8IQ9PenPs
	 Q7GZ7AKnOhjAW3VEO0bxWyj3eGKTdRztcR9wjlgDmsl1Vy87iYirVeX2nFn9KbKEFV
	 aVPBlVsdb8Q4KLqmgD2+JBwm+w14YxKsFXNT5O7BfUN7qx3a6L8Evn6HDbdQDTxFu+
	 Nm8ytZ8LIPsH5lVNrt/WTaekzBuWIRAhSqN2vN6QrHWEMnBGUGbetJ/Vk/QvQ38e1u
	 TpSm4ESUn1Bd2//uMmQoZXA/Jzl5aPO9poBFf7zDf4IAWAyvZ45+kD1MLF7d8/stx5
	 ri1lwYHURuvgg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id C687EF4006B;
	Thu, 27 Nov 2025 11:41:10 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 27 Nov 2025 11:41:10 -0500
X-ME-Sender: <xms:Jn8oadNy-K9OU6tDugE-l-rN-59mv9VAyV_-30QxdxhRvibmMRcXdA>
    <xme:Jn8oaaxJBdTNTWmt83L0ME21uwfO7FF3c7bV1ok51wX4CVu__OXOvaCejSebWxiJA
    seju_P_y39pqZJc4JEGtfuEIxsJhDqUGnt222x4r6eGoUtNvHPC1RQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeejjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epfefgffevhfefieevvefhkedvueejheehhfduvdehhedvjedtleejtdejuddtuddunecu
    ffhomhgrihhnpeduvddrrghsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshho
    nhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlheppehkvghrnh
    gvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopeiihhhouhhjihhfvghngheskhihlhhinhhsvg
    gtrdgtohhmrdgtnhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:Jn8oaaDtdRRBiLIVGTJ4M7fSkY3PvXyd4YmLpkr0ha44DHQQxESnyQ>
    <xmx:Jn8oaY3Yyxa9RHb445j-Sck9F6m6XsGndS2shFgKmuWx5rCIe8cUUQ>
    <xmx:Jn8oacuU6pxCMy1UsGF_NxnGUkvojcG9lYT71G6P6PIXDI2ruX2vxg>
    <xmx:Jn8oaQ60hXgA0OUwWyrrE_kWMHJST4pRIjq4fn_33THCAu1Y9Dp70A>
    <xmx:Jn8oaVJGGMZsYUSnIRhnUC2wjVkIXHN3jXTs-Dnip2spkTt0SH0e4IpG>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8B6D4780054; Thu, 27 Nov 2025 11:41:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A05TY8vYG-PV
Date: Thu, 27 Nov 2025 11:40:50 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Zhou Jifeng" <zhoujifeng@kylinsec.com.cn>,
 linux-nfs <linux-nfs@vger.kernel.org>
Message-Id: <5e1b3d07-fd80-47d0-bbf8-726d1f01ba54@app.fastmail.com>
In-Reply-To: <tencent_780E66F24A209F467917744D@qq.com>
References: <tencent_780E66F24A209F467917744D@qq.com>
Subject: Re: Can the PNFS blocklayout of the Linux nfsd server be used in a production
 environment?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Nov 26, 2025, at 9:14 PM, Zhou Jifeng wrote:
> Hello everyone, I learned through ChatGPT that the PNFS blocklayout of Linux 
> nfsd cannot be used for production environment deployment. However, I saw 
> a technical sharing conference video on YouTube titled "SNIA SDC 2024 - The 
> Linux NFS Server in 2024" where it was mentioned that the PNFS blocklayout 
> of nfsd has been fully maintained, which is contrary to the result given by 
> ChatGPT.
> 
> My question is: Can the PNFS blocklayout of nfsd be used for 
> production environment deployment? If yes, from which kernel version can it 
> be used in the production environment? 

Responding as the presenter of the SNIA SDC talk:

There's a difference between "maintained" and "can be deployed in a
production environment". "Maintained" means there are developers
who are active and can help with bugs and new features. "Production
ready" means you can trust it with significant workloads.

The pNFS block layout type has several subtypes. Pure block, iSCSI,
SCSI, and NVMe.

Pure block has some protocol deficiencies that prevent the ability
of the MDS to fence pNFS clients, so it might never be production
ready.

NFSD's pNFS block layout with iSCSI or SCSI works well in recent
kernels, but has some quirks that still need to be addressed. You
will have to test it with your favorite workloads to see whether
it will work for you.

NFSD's pNFS block layout with NVMe implementation is fresh from the
factory (I think the implementation went into v6.12?). As with
iSCSI/SCSI, try it and see if it works well enough for you.


-- 
Chuck Lever

