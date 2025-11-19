Return-Path: <linux-nfs+bounces-16507-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6C1C6C9FF
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 04:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C3FD4E773D
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 03:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4825221FDA;
	Wed, 19 Nov 2025 03:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="NLguy7KO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XxxoWO5x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBD52E9EC7
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 03:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523137; cv=none; b=Li4C0SLB8gPVX3b55hKJHMVGnSs8RLlqIPiDgRWK6U57DKCQgaAv6Pay0wHvIpKYRXFb6fXUwzLB8yvRXDGM6FsIwC7BW5VN3SlM0D+FGKM5y+tSpwkHrt0mdlRHIUO3wjjGhiv8NUxHQTFnAP80rdFJ3MuIOad0CfLe7T5qDHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523137; c=relaxed/simple;
	bh=EI3yK9NeniCqeWT9KQdKcTviDtgzPJdtczur/TgL0hM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bpIHXXp4UMde4t0WrLabMLDgQ+Kbpxpjt8nIcYz1n4aqzFAgveOYgPGGbQNqOBEscRqKeuWU/ocaElvbMKYK5DD6s43LC2QojlROFTtQ1bgyRPazSks4M1iFgU39lmB/Qz/38uBii6khyUnm8LKwGYR7WKrTxPXt8BNxvtCw6aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=NLguy7KO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XxxoWO5x; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AEC6C7A0110;
	Tue, 18 Nov 2025 22:32:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 18 Nov 2025 22:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1763523133; x=1763609533; bh=EI3yK9Neni
	CqeWT9KQdKcTviDtgzPJdtczur/TgL0hM=; b=NLguy7KOJukatFl9F/cjYDzUPh
	7v13Uo16q3+QPi9bcaAywZQ4KjahrUHudI8s1SKoGZzllSgiU0f81mBdaaVh31OY
	akl0tB3n8ZIt+NLxxgepKgB0Ub5/FgPD9xlmKtRyR5YAvmOKcGYrp8I5qzz1AivY
	pQSeT+yQLPri8DSjyKwQvLR7ONvKK8FoK4tNZji51m/ZnZq6bwgo5S6TmeNpl2LO
	eBn85V79kmZfmcIrAg27zufEA2vcwSAPsgnIfhJhKvUnCY8KsF1IYBCXqFDGrlJR
	fiGeaBsEk6a1YcboqxvXUkbUy5UWBvskDT3kCL6AHupk1XOEb5y9JFP+6eaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1763523133; x=1763609533; bh=EI3yK9NeniCqeWT9KQdKcTviDtgz
	PJdtczur/TgL0hM=; b=XxxoWO5xFNAiZht15IJ4mumIfLW1QkDFSo47hP7QAXPO
	iq4Q1DJzdDAbftK57wIQu2FSJGJQEqRSygxShTdSmwiYM8fG8ps3C1DyNtNHZ8vP
	msjjzxO4C1wMIDx6S0Bu4BFnw6jFz6KNoROqJGqJKoWtse3+fGQAAfGFMEk2wK5y
	couNQ8fYZX0BIoUbi/FI7Lhx+XZGhk95LyPklUF9IbJ7475VrHMt4uMLMzonSyeC
	VfrVIa8/FnbbF9xiNf65NNZm+G+ksn0PfE7fvjYxtni7eCLmApaoHT5P/55UcKg9
	bAVpgREcIRaU7rGkACX78iazHVps/GmUXQTR3GrIZQ==
X-ME-Sender: <xms:PTodacw1ji9n3U8xczSNlN0fAEvGAjlND5ClzhgOi9-xLyspg7aqBg>
    <xme:PTodaT9xY3uLdTdTgYcrOumF-kt6bLU8-WdvzDJRPu8ZaAEjowe1NyQPSsxRirJxU
    cygrwOHXptOl1yu6V4VMKlmyBjaecbwdLGPSBPHxxQvMjpd6w>
X-ME-Received: <xmr:PTodaYIs7THEHkCmptDRNk7kHc75ywtIE7maJwee--CRGN2oQP8d46UDwGFIVAPy_vr_BzWpNeAjIOKa-42hFcC4NmPNBkX0BQzHbbb9GoMC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefuddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:PTodaRcvvv_oYK9kfBJeQRQ-DnKDUJ5bWO5zkxv9RzeJ_-HzI7YdmA>
    <xmx:PTodaf-F8oP1t9sKvURK5q91OiQTwTIYCOW43K1JN-v66FdMndvGpA>
    <xmx:PTodaWpG6krGl1-eJypXQdS6eMZix8Vvpt_r-Kw6NpHiQesUifl_Hg>
    <xmx:PTodacCtw0QyuYH7kidS6En6GoybQpHZdGhsBDtq6u43FEM0Z0GTgg>
    <xmx:PTodaeS9Wm1SfEJB6JPxxQa_zQBwx0XlfE6kHxIjqtKnDHhPEimyFxGO>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 22:32:11 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v5 00/11] nfsd: assorted cleanups involving v4 special stateids.
Date: Wed, 19 Nov 2025 14:28:46 +1100
Message-ID: <20251119033204.360415-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series started out as an attempt to simplify the management of the "current stateid" which is associated with the current filehandle.
This end up including fixes for foreign filehandle handling as well,
including the first patch which fixes a possibly NULL pointer dereference.

Other than that first patch, this is mostly cleanups with a few minor bug fixes.

Thanks,
NeilBrown


