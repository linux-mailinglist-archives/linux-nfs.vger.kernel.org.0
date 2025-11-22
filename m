Return-Path: <linux-nfs+bounces-16649-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1E6C7C085
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 01:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97AB83A64E4
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 00:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4801F09AD;
	Sat, 22 Nov 2025 00:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="VWBm8BtS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jRW50Gg/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B32714A91
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 00:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772770; cv=none; b=WBe9fdAdaiIRLRFuN6GiPwqPkTLKTg7B89nP2EmPg6Ccj0ivmfK8MB5yj+zRYlPNxzBQCJHqWRR5DfGdXHec6rM0SqPtFCOKo7Q/f/MRwYu8c17hbtJFl6aFz3kxpMpK+c/opXNbPMj715xww6qZjBvrbWePkScVaC02gXaTHDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772770; c=relaxed/simple;
	bh=XT7O4nqyyqe1Fl49Kaf07HJeRIhoKR2oQDb8r/uQhm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YITUvkSkK8j3vJkVercD4jg/SOSruY/b868hIEvbX13o2VeRt/uWN2YoC/CVmVZoH6y2nLK4ILL2npccO26tr6euSu7F5dVU2X5rShk9Dbt4Gg90Guh2DDZzLlDX8OfGW9nJkPpYOATP/CqLv4NKQrZmj8iYBUQ5JHvQjdqJFKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=VWBm8BtS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jRW50Gg/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 374B4140009C;
	Fri, 21 Nov 2025 19:52:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 21 Nov 2025 19:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1763772767; x=1763859167; bh=OvcTCVBKzf
	QI/+LHNgYR+193Qi2JBYc7PIl/IgCDNSU=; b=VWBm8BtSU8GLxYWO3nRCXHNeHS
	fE0G4yXZQ/OBL3cSnPRz7sNPPPp1PO4h9He9HVoS1WormClG3naup10HP4jBiAsW
	vDJ5OcWR4w1ge+YQUo7wp8fNOMLbl5WcoIt7OZwRmkMrvXZa7vK5p8ZX4NG+MweS
	C98sQbNa8h5UJ3+QUzuIK0kAg0es637UO8why5KxJ7Kiyl4RloLdjTDBl2Y8y6Sw
	IyjGnzi1auBHHwNcUn78rmLO+iuMZ8raSVVaTrH0MAmAD0cdhykbPgFW5a07hukZ
	dgHOZUj3FEmnl/JHpUgbQFJ+mlMXFFH5stVcjUOOu7oMgQVAYEOQFvZxL/6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1763772767; x=1763859167; bh=OvcTCVBKzfQI/+LHNgYR+193Qi2J
	BYc7PIl/IgCDNSU=; b=jRW50Gg/QWSrcFLlZOFMTibP7j9lYfNrrOdzxeh3uzmo
	9oTFmXOyZ+1gBdjecjmQVr5hEL2v818kDtFPpM0b15xZRKdivXIk95VSAQCsci92
	m213VK75GgiCXWZ5i/UFsDarkV980BO3lwF9ri9S/hUS8Gq4ghFoZHdwZq2wb4Z4
	b6u9W7z2LmmBlbHRcn1ZbexVKq0r6spXMiKvovb//B4BD9MXdWWM3h1n9WminUm1
	Q8rf1UfXL5nvUcELugDq13352rqqpys7skokHQ7+WUKEKRRfxGqZGR3EFdAQNY6p
	EyvhxX7tl3csN+aVPj4ledLET9ba3Y1ygRcEGQT7aw==
X-ME-Sender: <xms:XgkhaQiP7r-1eowXCKMUXGGu3DvHtdRPkuhEXqcUXog4eBxhdiXEHw>
    <xme:XgkhactX5c-emQKM6Ipah-pNsq9fHM-mbXarQPihrwwWNuPjG6fsbK9f3Ri7Wdq_O
    X_o2PDUyI7j9s0WsLUqd89YI-wea_XytN2YzsihWS2M7h8Kgg>
X-ME-Received: <xmr:XgkhaR4ebtO_Gw2U_JADZ4idegZVoSjXseN_BTmNfONAZie4Z6rrV-ppmLLdZhOJeCheIkPqojfmAu36YY-UrGUDj40HBur-nwohHReCzSFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedugeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:XwkhaYM2h6Dho1_W84KG1rUumO8xSCsOkUKuTMQuoGhiW2v8ygTEbQ>
    <xmx:Xwkhafu2xRV3ebAW5bb0u2_TQ_7S0ECk9ipYFtbNCWoyHvx3lEA3CA>
    <xmx:XwkhabaJKNBcyJe_aPVNO21JvlzXq2y6yjLESVcCIKrBsaNIacEz_A>
    <xmx:XwkhaRydzOKWtiAGpTutTX9U8pT0ikZUH-HnMwsoKQQjg33dTWW2wA>
    <xmx:XwkhaSB6dAHPfvqrxEIQzwiFfPgKpnGUzoovv1-JIWNlaHBwr5vR_147>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 19:52:45 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v7 00/14] nfsd: assorted cleanups involving v4 special stateids.
Date: Sat, 22 Nov 2025 11:46:58 +1100
Message-ID: <20251122005236.3440177-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've done some proper testing this time and found that nfsd4_open() does
something a bit unusualy with current_fh so that my change to how
current-stateid is saved didn't work.  I've added two patches to fix that (08 and 09).

I've also split the non-RFC-7862 change to foreign-filehandle handling
out to its own patch (04).

This series compiles at each commit and passes all nfsv4.1 pynfs tests.
A few nfsv4.0 pynfs tests fail because they try a "stale" stateid which
isn't one that the server ever would generate, so those tests get a
BAD_STATEID error.  Hopefully I'l post a patch for pynfs.

Thanks,
NeilBrown

 [PATCH v6 01/14] nfsd: rename ALLOWED_WITHOUT_FH to
 [PATCH v6 02/14] nfsd: discard NFSD4_FH_FOREIGN
 [PATCH v6 03/14] nfsd: simplify foreign-filehandle handling to better
 [PATCH v6 04/14] nfsd: allow unrecognisable filehandle for foreign
 [PATCH v6 05/14] nfsd: report correct error for attempt to use
 [PATCH v6 06/14] nfsd: drop explicit tests for special stateids which
 [PATCH v6 07/14] nfsd: revise names of special stateid, and predicate
 [PATCH v6 08/14] nfsd: pass parent_fh explicitly to
 [PATCH v6 09/14] nfsd: revert nfsd4: delay setting current_fh in open
 [PATCH v6 10/14] nfsd: simplify clearing of current-state-id
 [PATCH v6 11/14] nfsd: simplify use of the current stateid.
 [PATCH v6 12/14] nfsd: simplify saving of the current stateid
 [PATCH v6 13/14] nfsd: discard current_stateid.h
 [PATCH v6 14/14] nfsd: conditionally clear seqid when current_stateid

