Return-Path: <linux-nfs+bounces-16779-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BB7C928EF
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 17:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 980983A6221
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6481F224B0D;
	Fri, 28 Nov 2025 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZJtJFEu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3F37D07D
	for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764346701; cv=none; b=Oz7E8hfvsAeC58DlrQt1UbbuUpOkmn9JzLzX4zFw3hScPK2YaUVd0ENYd6pELYsfYcMDaOunmz8XHs+hh6smuOKNbLRjb5v5XLfuXQrW72Ay1ahWqsZzYv883tOHqZlH5l8fgWWnSWIHZ0ugBObkNCSnh2u+yFKjuGY5eNB6J/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764346701; c=relaxed/simple;
	bh=b5DUyNC5snLV3EmYSYb8tZs9UiTGO0KyOo+6hnSAP4Y=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hc8sk4ErnbqOlDXsq83OBT6IkkNXL86O2I8WPK3GTKkLlgiCIGILnKW42EIHD3O6GYN3Ap0Jk/KPfI4zfCm7L9edLLLqpj6R1CBU4N/1wofeucwL3A0/AkBoBalrR0e3lK3wdesf2lhGT0errOwXAmNIi25uhlYfHon3D7DdQnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZJtJFEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE49C4CEF1;
	Fri, 28 Nov 2025 16:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764346700;
	bh=b5DUyNC5snLV3EmYSYb8tZs9UiTGO0KyOo+6hnSAP4Y=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=dZJtJFEuGJN4WP7rWhmlU2RlrB8A2awiTtBh82oXSC56xPBHxN9TK5U7dQl4ghVid
	 hTIre562v8tGLln0GcNuIkGRG06L6eafI9nwlx5/ki4Yq1D7oWMmecmxkpuINWnE64
	 7+d3V7h5elggCwMEdkgos7yv1SLcwgCH42fIyJ8mppvlZr08d/6hzTWZjyHjQ4wcrG
	 hSYDfWIGRTWxM8IHFrC6FXTY9NpWuFumIpdpCOxDZwXNsennT7vNqQ1Jt2JW/fFc71
	 g8EjMkiLiBmiKdXoohnsxfv3Tm0acMP+d7UfQXYxcQAyzDu1fPkU9PFk6tdEGHwKYC
	 kRHmYRmyf6Fww==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 82DABF4006C;
	Fri, 28 Nov 2025 11:18:19 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 28 Nov 2025 11:18:19 -0500
X-ME-Sender: <xms:S8spaRsGuFKQAmTy5MJbtUnjaIheYSnvl8718bjfup1RgWs0Ud-0pw>
    <xme:S8spaVSvSXQ3pqpdVaQPwXNIgT7Kqh-Q8MGBmANRk02VNNB4bTzjHy5LUxFyTskZu
    c-Uf5YosiL_EthtGwKc15eh1WDRZbfzQgBxlqzn-1FBHtj_PEOSLRc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedtfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    eptddvtddtueetgfevheeiudekkefgjeeihfffffeujeevlefggeeufedvjeefkedunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghdpohhrrggtlhgvrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghr
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvd
    elkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeiihh
    houhhjihhfvghngheskhihlhhinhhsvggtrdgtohhmrdgtnhdprhgtphhtthhopehlihhn
    uhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:S8spaShY6UaJj0c3xFYcaXuQVYeqseRoeV7pkGG61QyCiExllavxxA>
    <xmx:S8spaXVkBmlOVAmHEapHXpu7BDpiM7nAQ6w846yka_pdMhMfJGkDBQ>
    <xmx:S8spaZOWamMhkMLW3PK7QrqFFDIP4MmSBlKYttaR_Mh1ZnuJ2uPT0A>
    <xmx:S8spaTYmABMPAu1iJhQRPFaARxOlS2eaJPQzxNLmp-pFOBNFMS4xaw>
    <xmx:S8spaVrRqnsIxHnLCeAhZRuyaO_X7a5Qu2bHUO2wHV9LdTPK0rVdlWTZ>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 480AE780054; Fri, 28 Nov 2025 11:18:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A05TY8vYG-PV
Date: Fri, 28 Nov 2025 11:17:38 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Zhou Jifeng" <zhoujifeng@kylinsec.com.cn>,
 linux-nfs <linux-nfs@vger.kernel.org>
Message-Id: <50678c67-53ab-417d-b991-8f42ba05446f@app.fastmail.com>
In-Reply-To: <tencent_013D77524EB6303F7D357E60@qq.com>
References: <tencent_780E66F24A209F467917744D@qq.com>
 <5e1b3d07-fd80-47d0-bbf8-726d1f01ba54@app.fastmail.com>
 <tencent_013D77524EB6303F7D357E60@qq.com>
Subject: Re: Can the PNFS blocklayout of the Linux nfsd server be used in a production
 environment?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Nov 28, 2025, at 3:12 AM, Zhou Jifeng wrote:
> I'm truly honored to receive your personal response, which has been 
> extremely helpful to me. I've searched extensively online for methods 
> to deploy pNFS clusters with nfsd, but most resources are incomplete. 
> The documentation at 
> "https://docs.kernel.org/admin-guide/nfs/pnfs-block-server.html" also 
> provides very limited information. Are there any official, more 
> comprehensive deployment guides for pNFS available.

I'm afraid there is not much official documentation at this time.
My colleague Dai has published an introduction and brief set-up
guide:

https://blogs.oracle.com/linux/parallelize-nfs-with-pnfs


-- 
Chuck Lever

