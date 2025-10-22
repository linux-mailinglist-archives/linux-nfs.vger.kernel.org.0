Return-Path: <linux-nfs+bounces-15547-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EB7BFE6E8
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 00:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59D21A009B9
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 22:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CCC2D739C;
	Wed, 22 Oct 2025 22:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="C+uAS3Tj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JvfrDkBT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00531289376
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761172649; cv=none; b=XYKiFmQjgz4k2Eg3oaEWhACze/tZtoG9k+g7bzchElKwgVSukn0ZSe8GmKjVS3/FpU5YTcdFZRO2os7UBEjIBFDMOFACIUAhtvFalkFf4t3k0gjtJ73khF7/udeli5mtVeMBzPumEbgHVBKfBNyHk6G++cV+WZfk0uJj5VQCUMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761172649; c=relaxed/simple;
	bh=6mVAb6HsxPS8PFuLKN5x1r49rZXBo3CpxiIl12v3rfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mikBPrMJBJc5Kwl4W/OKamO2/hjKnGf6rFKIJWjhrtmubqiU+GUaeMqjBFt96C+6iuxv6xCOukVLnZVF6Pio71XCwdzl6vGWEbHEKEBV3wUqN6NNlTCG/HowrBoJmIJHRZS6quOfPT4aALq5UCKUOhkM7quvUuZDotTWVTSadkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=C+uAS3Tj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JvfrDkBT; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 125AE1400126;
	Wed, 22 Oct 2025 18:37:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 22 Oct 2025 18:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1761172646; x=1761259046; bh=6mVAb6HsxP
	S8PFuLKN5x1r49rZXBo3CpxiIl12v3rfI=; b=C+uAS3TjZ/KerDeIQYqGFwXo8I
	dUv4Pk2vwUtKzGVdyCNVUSWl7K/B1+wqZwRoa53I5yrtVRgB0fI629v8OphFNUKj
	c9rs5kLGeoI/L4zknObrh2RsFB2uf8CfAJ9YyI2gG6SXPESRCh/Oo3reJM8lYfpi
	lWwZ0go4T84N10JbCKPaqRBEuZEGrA2DJnUq8JNNFZyJhmcve6lhsGvp+9XsNz3r
	joFWOT2ViURw7CF44KS/1UZbxuHWd3J9QV3RTCxZs1PBPxEKaJQnfF123UU06xHh
	B9sOR//RlogaaECgxRzxfTGD6WOo7iX1q7vxvffyY2AkKCxfBpOU4pr3eKEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1761172646; x=1761259046; bh=6mVAb6HsxPS8PFuLKN5x1r49rZXB
	o3CpxiIl12v3rfI=; b=JvfrDkBTXOrjcUoOauI6jeL0zeUKfpPgkttl/84hz9Jr
	5b9GxpKTPSUFy0mQzSS5M5VajFlMMzYnjfRLvQu/yKg7hava4H4QZg6wQsePxwLm
	P7RwhAXqW88E/6snnPdxFZqBMU8vN5nm5myS6n3VhflzxYun+fHZTB7VwD1Ouagh
	d2RAp94QJzcm4ygU0JRd1gmOeGrHEd/nRPtk2UT+hCP2wgzXjFTyRl2MnHXlFjOH
	7fAfKPk8E90YcjrFuX9O5kcexq/lxNBZs2kF0vml2nxcHkzKVNp0VI9rT0q/kVRm
	IK2lId7ZxlQ7u3+4+/jgQZ3xkO5z4sYKwqwgd2futA==
X-ME-Sender: <xms:pVz5aK7xEgqNI6gmZWXgYyzP3TEJE0H5yNCOtAKoT6O6TM1CbcHMeQ>
    <xme:pVz5aHl8DPcxCa0rAqcTCM90iGyu81UOg3vcIG1eGQbCrYTHtFT4DOsUU_UIyto33
    ZPM4Q2BNlEJP5oq3d5azc30FL1IXnlaROJRizEOYliNqbXn>
X-ME-Received: <xmr:pVz5aDQQdV7uiraJrJQKiYURptVXhXW9ggo4hHfD_JAr4FLpVmzrKwuMrtEaNi_08QXKnMynxCXKMR0qN0hoMDSCsg275qwAWtpngkWvFrkr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegkedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:pVz5aOENRFBjPGOr59kpA-CX1-fy3A9cXYqVjE_tcW2pL5OKS4mxDQ>
    <xmx:pVz5aAHeU6GiXLdPaos13_80KNfUILq1T1U1GDRM2KPu_9SVN3oUaQ>
    <xmx:pVz5aESLRiDEzMa4RleWSaA1Ca1NNRp5fWngIdbCeEX96wzgajKWlA>
    <xmx:pVz5aJLa4IesXPXLM9fX3nYIkDZXyhv95_XlBGmta3hAgenqlHA-CQ>
    <xmx:plz5aEZoiilyxcUCn-nGMgWKfNUnIfZImJ5ayjdnSzmJKm1Z3Ggh3SM->
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 18:37:23 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/8] nfsd: assorted cleanups involving v4.1 current-stateid
Date: Thu, 23 Oct 2025 09:34:27 +1100
Message-ID: <20251022223713.1217694-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this v2 I've dropped (for now) the patch removing ->op_release and
the change to NFSD4_FH_FOREIGN so as to focus un current-stateid.

I've added some documentation as suggested and renamed some things to hopefully improve clarity.
I've also broken up some changes to make the steps clearer and bisectable.

I've also added some rb from Jeff - thanks.

NeilBrown


