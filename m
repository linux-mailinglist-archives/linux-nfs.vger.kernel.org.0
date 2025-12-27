Return-Path: <linux-nfs+bounces-17332-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 662DBCE02F6
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Dec 2025 00:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78A78301142D
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 23:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA00423D7CD;
	Sat, 27 Dec 2025 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="TBjljJiY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bvWY6ebb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C4E3A1E66
	for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 23:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766876781; cv=none; b=X97ZRHI82lp6M3aqVvvoWV0VX9XnGU+40Ypgep0qlwux4ykF6N+HssrbmgEO8LUT59BiHUV/ymJnKK9lD1vo+GO3AN3cZCthHNU8ZT/hXeHJ/5w96kK/Hj0T7NP6+OENEZNYZejb4aHhuvvZIIpaBFs612FtvsO0OVCjPrS5GVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766876781; c=relaxed/simple;
	bh=DTcPxaiPR96HWTgOhpG3+sy7qNyi6exYrrYELxcah84=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=PrrW0ZJ6ZkcYBIxs78W9xRoGdkB5U0vwBGa52wp03A4hczAF1FSW+5HuxPJQP1GeAxazPvybu2szsTd8kA3ZOfI9JfoY69+wzmVjLBBAyhj6RX9z+JrAjYSrx2uhfNue6rwBPIUW+eBeK7aDSJxLAxeJqcRMkgqJLC3oQOmwVYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=TBjljJiY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bvWY6ebb; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D81827A002E;
	Sat, 27 Dec 2025 18:06:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sat, 27 Dec 2025 18:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1766876778; x=1766963178; bh=pLRG6FFuDhPdcSuggr+ZKW5eZps7pCg//8M
	jzvD/JY8=; b=TBjljJiYWZtYjgbq5D3CZ+Xnz7zbUQMIMt/2RxNcQB2G28NxSXg
	YyRYqPlD6vkQ/zJSid/K0rAz6EJ/6fvjV4NukG0FZh1wOPB35NDNN/zSmU/vjzeS
	rz0BJvkVyGuRGgxxWOXahYq+RlTcgSm0u9SYXdJKn+wN9VHuLmq2H4NOZ1iJ9UBq
	75iMzxBxxf+X6AwOKwTdzFYJVnnCNAE7GQm9Dc2h/6TqiU8O9/GdJ/VQBDMBwzYI
	h860veTi7IuioypDfmJj7+qfLpu6/+nl5VYR0m+aXOmUNLuQ85xPRF3vQLDxDk+R
	x+mfUaMD92PiUiWDdx9ytZ2NnFc3597hu7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766876778; x=
	1766963178; bh=pLRG6FFuDhPdcSuggr+ZKW5eZps7pCg//8MjzvD/JY8=; b=b
	vWY6ebbckHtdejz8Mfvw2cK7cEjkWTFsMVEVFV6wpNjDt8ySDJ8opYJpW5BmHhr+
	RBY0bVRDV6DfF0+rnClawZ87H2NoUqfkqkDoeDy66rqRA18ugHI4W0kgDVu4BKhM
	xeyZSWx4bdRhnjNdcB7Cik0SlooaZNMeaEGTu/pf5FttujoWZkYraPD+n/ceiyhc
	JkC7iY3welhbc/KL6CCbZzfCnDRjka0Kd+KbaU8t4Yi2Z2T5oBpDpb1eHBUp/73l
	aez+fpb9Zk4fOnFuGyZ6ERMLYG79FuWaBxu58foMWNbbHoy1gRfBm0OkRe7Am55R
	3ezCa/yzZN8ZQ+p5iazwA==
X-ME-Sender: <xms:amZQaap7vTUZzY2mVK5fXEA6JrjzDI-5z9kmP1nmsQ0hGM7BfGS64g>
    <xme:amZQacWk8YLqagAYM17QZh7fjf9u6DifMkTMWpg9OW1C3J_Hce0sifVWLfKXf8Vfe
    TEhTJdG7kauADHWHhkVpZesBFpooOCtJN6CvFZJGvFbZcXJ>
X-ME-Received: <xmr:amZQaZCAS9_sqI2Td5vJI185pkSsBzZ0_PcUlgRgXGvk7sZneYNw-0PPsyfX8d65jIM_iEKa5QpmJjIje3MW63XrkY9-we6s422e2Qkng-2O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejvdeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthejredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duteefhfduveehvdefueefvdffkeevkefgtdefgffgkeehjeeghfetiefhgffgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthht
    ohepthhrohhnughmhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegstghougguihhngheshhgrmhhmvghrshhprggtvgdrtghomh
X-ME-Proxy: <xmx:amZQaQ2NVDGTFzlUF2DHfF0Du92SxxUdT2pGaUtz9ZY1vJzK5LjbbQ>
    <xmx:amZQab2LK6xvG5AGo6fA3K4bCizl7bcMlzMnG4y-oWiRn-d0b3YIaw>
    <xmx:amZQaVBsgrW1zS24L8ylVprffZSIMEDK-SZTp_vaWhcsuzsDYDOvPA>
    <xmx:amZQaa50oL2AkpOxNMvCeRLL3gJ6OtQwagFLkbEF5nW2mMaXPVIaYw>
    <xmx:amZQadbgWV5mbd9IyarGm0jccTQjVkH4_IenmHTfWdjeIAsrfwTjP1Pe>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Dec 2025 18:06:16 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Benjamin Coddington" <bcodding@hammerspace.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Benjamin Coddington" <bcodding@hammerspace.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
In-reply-to: <cover.1766848778.git.bcodding@hammerspace.com>
References: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>,
 <cover.1766848778.git.bcodding@hammerspace.com>
Date: Sun, 28 Dec 2025 10:06:14 +1100
Message-id: <176687677481.16766.96858908648989415@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 28 Dec 2025, Benjamin Coddington wrote:
> In order to harden kNFSD against various filehandle manipulation techniques
> the following patches implement a method of reversibly encrypting filehandle
> contents.
> 
> Using the kernel's skcipher AES-CBC, filehandles are encrypted by firstly
> hashing the fileid using the fsid as a salt, then using the hashed fileid as
> the first block to finally hash the fsid.
> 
> The first attempts at this used stack-allocated buffers, but I ran into many
> memory alignment problems on my arm64 machine that sent me back to using
> GFP_KERNEL allocations (here's to you /include/linux/scatterlist.h:210).  In
> order to avoid constant allocation/freeing, the buffers are allocated once
> for every knfsd thread.  If anyone has suggestions for reducing the number
> of buffers required and their memcpy() operations, I am all ears.
> 
> Currently the code overloads filehandle's auth_type byte.  This seems
> appropriate for this purpose, but this implementation does not actually
> reject unencrypted filehandles on an export that is giving out encrypted
> ones.  I expect we'll want to tighten this up in a future version.
> 
> Comments and critique welcome.

Can you say more about the threat-model you are trying to address?

I never pursued this idea (despite adding the auth_type byte to the
filehandle) because I couldn't think of a scenario where it made a
useful difference.

If an attacker can inject arbitrary RPC packets into the network in a
way that the server will trust them, then it is very likely to be able
to snoop filehandles and do a similar amount of damage...  though I'm
having trouble remembering that damage that would be?

Thanks,
NeilBrown

