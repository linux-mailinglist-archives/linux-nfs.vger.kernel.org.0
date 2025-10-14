Return-Path: <linux-nfs+bounces-15207-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 91171BD6D38
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 02:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D24734EC66
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 00:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8223A2F85B;
	Tue, 14 Oct 2025 00:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ZVLrWK79";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d+eZXIX7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18AB2BAF4
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 00:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400360; cv=none; b=oUA/MeX3ql6tk0NhktUhGyqEmVt2hDJ/RpXehRQmWNw4oJgk7Gt5zX9hzW06LjEhU+ckCfDGjV29VuEzoJsjYY4mfilqSA4tpbBWrERFXZdPA5OVL+E7JfzW37qhyQe+MjhlKB+k1w4kD4w9YadPTzBycFoDwUKxZEesySpxXp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400360; c=relaxed/simple;
	bh=/ko8EPuAYy4RS8Qkvy3raa6P8Rvs1dh+mFlmQivSWbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OoobpVVuSUO8+cCy2LY/CXX1XKLmnSqqWlRr1yoH2tKfjUWM+A6u8TZEllLnJdEyn0nujEJznHv2Sb3imbFIXnPEXZLFKUpwjhd3P0Ib5JU35l3FD/aQJjSS/uOGohonROAstzoM64sSSPL8nf2i0oSrU+nUuXcjHU9GblJzmEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ZVLrWK79; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d+eZXIX7; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AFEAA7A011F;
	Mon, 13 Oct 2025 20:05:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 13 Oct 2025 20:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1760400357; x=1760486757; bh=/ko8EPuAYy
	4RS8Qkvy3raa6P8Rvs1dh+mFlmQivSWbw=; b=ZVLrWK79rDincwVrcH2viZ3xe/
	GM3mStN8KBJAECvJBg1s0uycmrTaCle+RricyTfQbBAdE9C0cdhXFrqhLKI4jXLV
	fY5VjYmyAGWyRggvIanTtzhwa45INMLaQDtfBc8LPiaanZD7YXnIQwG1WPE+gNnz
	3C+ZIbK9hh35vtuR2njoB8K+4nPS7WAFGyunwyN8Wxh609lxJ/8LzQ0Z7a5IKnQc
	+aVbQp56NvN6h4Q+7eSW9TrNmi5Lyc10QXTvr2fEuHypN0xbbpc8cKVlroFZ3+Lv
	yoST/z1lmNyc38u0nHtKWaCv4GmtLBGKkr3iGoZc6OkZUA2NfOU4uKceldZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1760400357; x=1760486757; bh=/ko8EPuAYy4RS8Qkvy3raa6P8Rvs
	1dh+mFlmQivSWbw=; b=d+eZXIX7yktrOyBZRZWqEAvvYDb5vUHKzJsC9ibVvFpr
	WGFe4yaPquntjIzPxICradp48MJ0xFxrvAZ1Z4UlYAEqs1wwHqzwMhSbedWrO0tc
	Vg5XndWpu0ZRTM7r+3CdjSeds0HgjGIwIJyeQKxcaO+iGc/LFBAeCpmzGbVvFQKn
	Duf8s2ZT61nv2VSI2XEd2PNSd1UGuxrDDKGJN5884tIA82aP6PNakfFSWH8v1UmC
	8Sa4r9RvPs4Xdq+SjlbL43zKZiXnsf3+wK21KMW/98D98FuPqHNOM5egOe7EhfTs
	2qtzN0PofuWtZROV58sBRr7khk8uZIgWJFYD6yb+wg==
X-ME-Sender: <xms:5ZPtaA3r8yRkOdcpNaSsADsWPaVNYRY8O6mY3fP_EcrG1xSroo0i7Q>
    <xme:5ZPtaOwDds6Y-QRCJ3IMEZyzpz-adcis-fZW3HgWxaJDcG5Q_SfC9UHoL5EmxQVYn
    g4FPy0wusj-ZIS3AnsGaQgm7n_3wWUOMhFJVCrOdXZEunOViA>
X-ME-Received: <xmr:5ZPtaCsOGX4gIaI9jd28gthjDr8moAmRuDHMtdrJHzCfFDv6YZ-bDf0LmGcPhdLI8vyOWgwriF6gZ2Zad6bQ_matgMsmIwTl6E7UBXJ_UZRc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudeltdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepge
    etfeegtddtvdeigfegueevfeelleelgfejueefueektdelieeikeevtdelveelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhnihgv
    vhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrg
    gtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhr
    tghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5ZPtaAwa93CqQc7jkr6w5_xAEP4vGMi7b4fI7zsUJXwVIfz7xx-3uw>
    <xmx:5ZPtaFCuIuwM65S-F1-Zo-xi60h0BBW8EsV-7Sc_m1g2DFAyujtEdg>
    <xmx:5ZPtaOc2UFTAO3Pmt-ZrVSflplttFvoXaueX1d5Flh4AeGHo69_DKA>
    <xmx:5ZPtaPlgd_SXjMEjKiGL4Dk-BNOee-phjUrK4Ps8jh2beloIMoa7CA>
    <xmx:5ZPtaD8Wv7KwFvOi3d7OCKVtvvAdz3o18Xohwrlj55ogbR9BLV3GgBk6>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 20:05:55 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] nfsd: fix up SEQUENCE replay
Date: Tue, 14 Oct 2025 11:04:40 +1100
Message-ID: <20251014000544.1567520-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I think the sequence replay code is confused and wrong.
These untested patches are a suggestion of how to fix it.

I and do some testing later it people think it makes sense.

NeilBrown


