Return-Path: <linux-nfs+bounces-15281-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D5DBE12C3
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 03:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181273AFF2F
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 01:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFA4134BD;
	Thu, 16 Oct 2025 01:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="JuP5ssHV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QX2vHZ7Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27DB4A21
	for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 01:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760578415; cv=none; b=CZybrad1LJB/cO1j8jYO88yQXraALvcsK71IRVtsJqGQ/ctNWAZVm+14eebkQnflcAy5bPIVydeB/3kWWS3AKb4ugR1a1M7ojBvAmNXHhzhKBPMrBeHePGgOTid1FDxfkrx4nRLLgmqpxo2/RiGn3At14eqLq0S03BMUprrpvAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760578415; c=relaxed/simple;
	bh=kzM3PnTXJy/0V79p98jIwArJvqnfyqnP+5PN2+5UsW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K/1RveQXP5yO3YphrxkG/8nLiGkRls+f8XQImt03vlWnwJbLi2sHfNI/tSWsIIdWBFkNWjsWFssyXiPSwK6x1C87DpsQGUw6KzP1Bf3m3cPbspUXUM4Z1FAu+xxsXWMWNXX3gwtqGQv2ZswArV9MD1jP+l2JLE/HcIMbrwdSiIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=JuP5ssHV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QX2vHZ7Y; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AC1937A0132;
	Wed, 15 Oct 2025 21:33:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 15 Oct 2025 21:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1760578411; x=1760664811; bh=kzM3PnTXJy
	/0V79p98jIwArJvqnfyqnP+5PN2+5UsW8=; b=JuP5ssHVFtndiwU/wssNK6+fGw
	ljwoUN3LH/HRjfflRFK2EEEFw6rIDQ4+EBe8nk6EYNxJ41tzf2J1fJEckrAdrSbD
	+VUPIso5+lhoWIWVAJ+fdJ6tyYvzpUS45TPDAKhJPWtqwUNvplWihFTZM8ZhUsXW
	TdU4nSK9g5CR4JyFix7b8z3Gs8LJr/dHfbTZRaeBjpo2XdqHVpmqdVqeuUgoOPhF
	uRfIxkU7O9FIO7EpYye0o3d38XDK7Ijp9TAQFQ0F5Z/Io3EptkVl+05r+M8EMCgO
	k/hR9vZPurnPwi/+EaRP6pEgiigYBn2kjMETG8a0wUh4VO6yoR55nvU9+eUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1760578411; x=1760664811; bh=kzM3PnTXJy/0V79p98jIwArJvqnf
	yqnP+5PN2+5UsW8=; b=QX2vHZ7Y4N3BnDCL2idOvIjc+6adNkURzMQs4IlW2O/m
	efTCF7Z8LP5Ws7stjOFEbFIQYCf0k/zmzEii4GUCCvgiboYByr+S4meNjdJckC1r
	DYMhv/qbjqodvG1xkLk0z2boGB9SRRcW8adGyBlRc+K9sF8TjRp7iJIth8tJJNXk
	8MHaHavgyRHh5/5oprzQL7DpZ//gbrjJMqxmjvmg8F4F4rZfaGIja+YzTKYrXIyc
	L6tYCkDlKfIzXvwbHH50OjDkzYeQOlfGtPDlDoZ8WY1IVeLRbLpg7XbVaUuDQK4j
	KeW0O9VPpxv/KnXVg1yNYjqJl80j8BMKtdq0TbQbIg==
X-ME-Sender: <xms:a0vwaKuHJR7Xw272WuyEMyPvOT9jbEz2x7j1OxPrSitAeZeFhCqTww>
    <xme:a0vwaDKn8-Bs5Ur-xJjmL2hs1lpGL8o2r_qMy1sNvab7n-vCa9e9Ug-z3Se5RkY3N
    KsSIUFRsUbHrUKeU7nulDUQoaJr_elbS4ON_GYJ7pnVoXqgXQ>
X-ME-Received: <xmr:a0vwaPl20Ha9M0pDBGFtcXG0i9nUCDShtt8ndoJDiVaREpzfGbeEXHUCU7ynt-WtHZz5DovhSGsC4CXid2h9sFN97gFEbXMQsJswFcTClSS5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegleekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:a0vwaMLNH2Hsdgzk5tU8ysY_ZZv03SaR7gSbl0d1gBEr-0l001LZ8Q>
    <xmx:a0vwaM62tD6lN8HOfkEOtHC8h3jUOHzgN71YB5JoSoGKrIlStISWcA>
    <xmx:a0vwaI0IR8jWjm8B7puJGqgRZvZRWp1HMg-zktWShpCF-C5afAXNzw>
    <xmx:a0vwaKfI8U1iUUrKqo1VPOy4GgzExLp6rCsCD3lyGagi2nlecJDeXQ>
    <xmx:a0vwaIN8WOioALSEkX804sy-3UZaPMTjOJ0qVKTlcTB0Shcb-7yDLjFd>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 21:33:29 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/2] nfds: fix up v4.1 slot-based replay handling
Date: Thu, 16 Oct 2025 12:31:12 +1100
Message-ID: <20251016013310.2518564-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3 - with the fix to nfsd4_encode_sequence() in the first patch
plus some minor cosmetic changes as requested.

NeilBrown

 [PATCH v3 1/2] nfsd: ensure SEQUENCE replay sends a valid reply.
 [PATCH v3 2/2] nfsd: stop pretending that we cache the SEQUENCE

