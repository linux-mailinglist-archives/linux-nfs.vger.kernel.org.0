Return-Path: <linux-nfs+bounces-15350-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6F9BEC13C
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 02:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF185741F42
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 00:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58941805E;
	Sat, 18 Oct 2025 00:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="cIbB/pjh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yUJ0+Lg4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7547DEAF9
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 00:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745965; cv=none; b=ssN0L3SKevKvSqE6fo1OXDncu1NlvnvohwyntIgoGBAMfxkNa1udIYbbaJxyXk+DBsfRy5BrmoQaFY2vI2Pg5rNYtALaDcsm2xwEcGUwXiphfyDJrCJVoTSxTcahCCn+bmH2hHFSWo2wm4TqJjiuHdOscYN91RadvFyC6epCpMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745965; c=relaxed/simple;
	bh=J6+z5JJEnKE2ZkR0Fl11rw5jfgEqou9g33rEaqDDMvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kXtB29DcvJLmE47MbY2rLIVqVS1wG8nfxd+2/sYevgxFremwXJdYXHdWJXkjcEqQTIEEg3hrwpRBjqvBomZ7/witn9rzPsU1q27eMz7o1KpuOuRMx2FlbWdT0NUgxGbDiJS0Zi1rxs889ioieow5jqRlLqpxt5qL073+FV6RSZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=cIbB/pjh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yUJ0+Lg4; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 599C27A00EC;
	Fri, 17 Oct 2025 20:06:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 17 Oct 2025 20:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1760745960; x=1760832360; bh=xCSy6NqPOM
	9xGvqMBx36nwt+OOZh7OBBub5sANQZi8E=; b=cIbB/pjhcC8OZhGFtVKqMLIEEY
	iqmDCe2MOYD7Kt7lvPOmlBNKuJHdFnJf1OF6mO6YskponzLox02VOeuF4Y2fEk2w
	NtAtEBiRXdWT+7hLXIlZZH3wSE78udUUobaKx/B+qn2LITZp8gc9s+cK3WsIIV/u
	FqHon3IrROjNMeUDe2M7Me4qFlj5AE8XGU+Cd/TT8//ITMZtPPNDU8aOZ4rjcURz
	L3KJfICSHqxO9421fR6PsZMD6Wecx4dIa9p59oSJW7xo46goklRGJGCFpVGSss+V
	jTzJA29/8tbvbmMYSwgz6aTjrpIvPtzE0FrEkzYEJAPLhjJq6KoPUX0Zu4fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1760745960; x=1760832360; bh=xCSy6NqPOM9xGvqMBx36nwt+OOZh
	7OBBub5sANQZi8E=; b=yUJ0+Lg4sy4DRSGxG5rt9T6GaNMHIKCZqcN6gI9a9ciV
	ucpeCCyLFiFJ0WewHs6rs6jQfLDThq0O8Xd53DW1giKuZozj/3u53Zmp6svxxqis
	BVZw79YMU72JBUNo6cWNIgcRznSmyfCZsZK7ZGTfe3iQ9kxHcVgw67SlyeX9RplC
	sRBbSHVOSybb+Wd6isDOob12Hnw8/FisMaWOOrxl6680U++8mteAj5lrL3lpN6ch
	AcZel2VaEgnuIV422QIvSvAGmv/X/WarpZ5p6FcdMwoX4lNClHrk0UXA6Aid+Hcl
	FqsX+3uJh0eqlKmvA4uAni6NYsz12ugw1S1/1AgVYg==
X-ME-Sender: <xms:59nyaMw1i9zGn7K-jJQA00jQaMaPsWTEEGAdjUJ1dQ0MloVcVw5F-Q>
    <xme:59nyaD9xHHF-WKKtTaVIecCNzx_JvaYwEmuPeGnAZhEphbkG37q1ruqCGZcT6gbOt
    I_mocg8oVvSj7SCw_qMiVtmrZDe5Lzt1fXuMQE_8w1xOapw4A>
X-ME-Received: <xmr:59nyaIIssgenKChb3fgFp2tDm1QsAy1qF6PDxCG1UFexWoTU1DIk7xHO7HiJ6hxLSBCecCtaK8hxR-HSKvUf84cCDnPJH5FP9oDg_Vsdo0KJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedtheejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:59nyaBcvnwJ3SqL2S0QGQEh1LAklp1RuG6uV50juzoMRZ1FsvzLHBg>
    <xmx:59nyaP-Fv-N3525bGhExsDQx2ixWm1_02UZPeR5vlOCREJCmi3Dafg>
    <xmx:59nyaGpGM0Mhi8xu8qE0pW5qZvFjCBGeBfCcrBDpaeW9deaInYKSeg>
    <xmx:59nyaMCt2JE1ppXmVA6H1qHVxDqmY38E0bEZbodajSJlPhs0XXSGDQ>
    <xmx:6NnyaOS9l1jMj9954HEHfzH4zMivpkYGGC3silmox0RC88Ul3sKxxy5m>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 20:05:57 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/7] nfsd: assorted cleanup
Date: Sat, 18 Oct 2025 11:02:20 +1100
Message-ID: <20251018000553.3256253-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches remove various indirections in nfsd code which, I think,
improves clarity.  I was motivated to look at this by a recent buglet
with traceing called from nfsd4_read_release().

Apart from a slight change in when trace_nfsd_read_done() is called, no
change in behaviour is expected.

NeilBrown

 [PATCH 1/7] nfsd: discard ->op_release() for v4 operations
 [PATCH 2/7] nfsd: discard v4 ->op_get_currentstateid() function
 [PATCH 3/7] nfsd: discard ->op_set_currentstateid()
 [PATCH 4/7] nfsd: discard OP_CLEAR_STATEID
 [PATCH 5/7] nfsd: replace sid_flags with two bools.
 [PATCH 6/7] nfsd: discard current_stateid.h
 [PATCH 7/7] nfsd: use a bool instead of NFSD4_FH_FOREIGN

