Return-Path: <linux-nfs+bounces-15738-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D6CC172F2
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 23:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FAB53B06E0
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 22:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479DA2E0901;
	Tue, 28 Oct 2025 22:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="KMMyYntm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LHzpYPwR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801502C3244;
	Tue, 28 Oct 2025 22:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761690293; cv=none; b=JfZ6b1JbsvcB1hMhCA1pg5FvpP8SbjaDvBAtOw/W02W+NCEuUjC+7Sz/0V2dgmP3Ls+begvzEcwK6IZJxVMRB+/D4prnNYThsZsVc1YHu6K5l7QKxY/FbL8bN9AHlLMVcR4MLu0yRZDfIx6khj5ukp+lxFZ1USqSXdnDCOXMcP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761690293; c=relaxed/simple;
	bh=Oam2va7MmmZ3mEnhKA7wghpNktb70BDdloGLJ4rCws4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=TVhCfN2FBUkZJuPOnYORioM27XBu2nTlMav4FGdaZKBBtFeWcSZHBZe+IcDXNsulKjIu6gQnTCTJu9JUdw9ZORT18vvXBstE9iS+lpUeMowrKrwsJSG7rsGIHYHCpsGF4af/pucXFVgHMpsJ4vQJe6Uz4DDDTvg+2hWpAISh2mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=KMMyYntm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LHzpYPwR; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 438227A00F8;
	Tue, 28 Oct 2025 18:24:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 28 Oct 2025 18:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1761690290; x=1761776690; bh=m9c4KXkrm3n9FA2Zuexcj0LYa3ZWj9eTbWo
	tzWEvdlw=; b=KMMyYntmrBHPe+vtVwaAnTJ4NluGfjYCfv1fRd4n/EnbulTpXez
	xqDf1SLDeHIQpUCv1nJNU3By2wkPC8F8j0hjXp/QzRfIHJyYgn47XD6zI5I6MUj1
	6LraBsJTPCaJjgZPdEWo3hZvA0yJq4PXNXWAJmfgfUZzdS/OQ82rFXmFm0qUK5Lw
	zAlKupFWvl8Y1T5CpHXl2aEd2OzvJGPj+g0+9jxNzi+zvLY+SwY+pPv4ESwFqtJp
	3yZzDaQF6jDVIvY1fPx21TrTx8iwLab++uoJNnMvXNf4PLJgHmQ4eZUkX8nUDMzy
	OYHZQ3v8Kvlft9XXGMCikMdgxxdKQ10qZVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761690290; x=
	1761776690; bh=m9c4KXkrm3n9FA2Zuexcj0LYa3ZWj9eTbWotzWEvdlw=; b=L
	HzpYPwRKo4XzbBVLtjmBtUPWqdlEM4MJBWsiWoOP+O1xj+JaXgEJI9f0J5I/z280
	y2wiGvRBD4/4vh8swGy5aZg4tov0dzo1tX7hDLLR1FGhaGGFnfwCCsIWYucJAiNR
	G7EEXMf6+4lRDFiD3boQ5uaPKyZHhp3K20+Er9Ist/gRXDfKOpHojekTP2F5ZiEq
	I1n8XnUWDrdxNWLQFrzE+Pi1KA8FlwZdbUvM2MAJ1rCYMVA8n+UtbS+0RmG7ZJRc
	eUQHaPNouqTPRF7H82KCauPYEFl7zQH19pCX1xpl11y9mKVbHkgZC7zo/FghWU5r
	i3uwFmXHtC4ZxBr6BxUXA==
X-ME-Sender: <xms:sUIBad6vGR35bfGSRldPHLL-vu4u4FJ5ADyItESTGqr8yp93nonkrA>
    <xme:sUIBaaeUt7rWfTynbbW7dqD-LZMfJTF-XyBz8pIWkYZJw5uCjM2XiL1oiqQaF3KXt
    vFct8-rOMIkJrSloNEeC2atafEivaUAsYb9tULopiFgoFudBg>
X-ME-Received: <xmr:sUIBaYzoJy4iz-NE8xrMY-hNC53CffPjVsgGDYhs8sLL1J6kjRx9Iz-MUzNRNulvOO7XItERb-TWYiFaijalh1mULthFMHFT0IJIlxOI0yaH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedvtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehr
    vgguhhgrthdrtghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghp
    thhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepkhhusggrse
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sUIBaYpL3IvEz7XOjkokXwTsbC2toh7224_pOCPwR7Fug6WHnryVCg>
    <xmx:sUIBaey2nQrd8cpMCQ9yZWsZgbSDR_ZA0kNjxwXr-8oaevm4_4htPQ>
    <xmx:sUIBaUr_QwhT9_naQvp1537SWeI_reGzRgncpDj4_g8A0GvQHhgS3Q>
    <xmx:sUIBaWfOTs2zaHBUyF7B9Li9FT8k7nPWCN6sQENQccZq8kLoQxFecA>
    <xmx:skIBaWBI-rLTUCiwGhRFG1TFHB2KFpydGICze5A9z1LBRCuqnIU0AYxe>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 18:24:45 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Khushal Chitturi" <kc9282016@gmail.com>
Cc: chuck.lever@oracle.com, linux-nfs@vger.kernel.org, jlayton@kernel.org,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Khushal Chitturi" <kc9282016@gmail.com>
Subject: Re: [PATCH v2] xdrgen: handle _XdrString in union encoder/decoder
In-reply-to: <20251028145317.15021-1-kc9282016@gmail.com>
References: <20251026180018.9248-1-kc9282016@gmail.com>,
 <20251028145317.15021-1-kc9282016@gmail.com>
Date: Wed, 29 Oct 2025 09:24:43 +1100
Message-id: <176169028361.1793333.2540728361412926877@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 29 Oct 2025, Khushal Chitturi wrote:
> --- a/tools/net/sunrpc/xdrgen/generators/union.py
> +++ b/tools/net/sunrpc/xdrgen/generators/union.py
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>  #!/usr/bin/env python3

#! must be the first line to be effective.
Other .py files in the kernel have '# SPDX' on the second or third line.

NeilBrown

