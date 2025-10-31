Return-Path: <linux-nfs+bounces-15824-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9A9C23296
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 04:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A328634E79C
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 03:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDB5259CAF;
	Fri, 31 Oct 2025 03:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="WrP/90Xe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C4hNmjVx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0289828E5
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 03:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881142; cv=none; b=NHZrcsz9zM6M4WoqWXVcz90lFOA3G7RVv30oeuqdBA8KZSEErO84xYmsZGmRbd6STC7nhUCcVatZGH0bQnZlF9xpxNPoViYjK18WdCksoRps9xeI6x2grYy5SHY/PN2dQSRjTiy8buGceIPPJrwNcLis5TFEi5ejxv+kYXmF6LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881142; c=relaxed/simple;
	bh=OWFkoYnaMqICwD7eI7IWGmMyPYQ9fkFWoeru+InsvOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L5CZ/RVdUDb7RWzE54sqfJuk2bJtP5O7opj6lxPIv0H3ljIPFKlHYh6qs2Luna167/BCyQH/fspdlF6DTkhFCAGC1lhH9MbAdavbF0zGaXr9bx51aocPupDc/8s+NXEStblZmmhGDVLXGfX0PLMjFdrHWrXgNOs6VMd3n3w9VbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=WrP/90Xe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C4hNmjVx; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EF7837A0160;
	Thu, 30 Oct 2025 23:25:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 30 Oct 2025 23:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1761881138; x=1761967538; bh=KgVBxkhoeP
	WjWnDvheKTXY8LN2Yi0FJcYnXJtaAeY0w=; b=WrP/90Xexo8ppyWaL92bnd7YBB
	RlE8nYBFrczx13FsTyP9so2KlJT+tEoW6JWN5DZnT/fmaQRQVqDidqUOpdiM2d6A
	8QHgpSzfoRXZxRCmiWt8aESbddR8kZMF54lKf8y4OJQqAfjV6oXSaj7PjoDsWs4q
	ynub2twe3N29qcqKKCFO70x1ih/OguPhGJBVbpnJ6FcsFJ3nF2ZR1TLgaxCBuC7o
	HmUJNXDWpJJRCWI/t/Av13Nc73ELCnTruyBlufI4Heg0W6qbvLaVqb4UavhAn/QK
	cP9nDc95I86VrdRAI+qQN8cgxcRYWMIA94ntsDMwLIwDGJxIkHIexzF7dQbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1761881138; x=1761967538; bh=KgVBxkhoePWjWnDvheKTXY8LN2Yi
	0FJcYnXJtaAeY0w=; b=C4hNmjVx1gMIQusbbuD/7y6mCHS5OzViRWX17FnOz+nJ
	gXXLQB+Ac2g0a7Gw4eF8TH8q38wX+dxzdJQl1A2dxYC6WNtkyLlUusTJBSlgbGiK
	M9hDL3dcwm39eRam01RA8CLvat0Dflvw4ZOjXipxnJ/8/MPzkBalRi/z2fyooPMd
	p439VC/R+V0EMBKDtWCHEH5RDPpgq6KjczHOGxSCHVkTM2MH2VTqEnfXoPyMXqAF
	kXCxgIS0oIJtdKYLkVqT+qG02lsduOCo2um70F4EqCo6tbKPvUgmabu1oXnjDYuI
	EZaAjexVaZMEXvcfmF47tMgCm+Ba6lGtEU8rWO+pqg==
X-ME-Sender: <xms:MiwEadS9hltG1Xc_BRusf2MdYPC-DVyHCq5AV463zYwCWgtklkOkfw>
    <xme:MiwEaaeMzNXNVRxiE64CVFNiimWhjI2l8gYctJpoBuR0CqradQSbV4R6a_OaTDJ62
    6HkZCp2LR_2nquuN93mIHxRcN2-sGLroSCHx2bZSinhxqSo-g>
X-ME-Received: <xmr:MiwEacpHLZPa6LJhc7u7YO9-Pxzyglk_JYgflTbHxbv7K0a2fYiTaYFH3gDKOPs8E3RVvPlI6FjxCLITdR1wzBhx6zz5FBXt9PM7NtawJgRq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekgedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:MiwEab987Jat_-PFgUErJqyg9Hv4EJyv5PcTaW4EEI8yYBOOHn2nAQ>
    <xmx:MiwEaYeGTsOealzXw5j2OLREsT3sVBkPBwN_IczJaIk2qNCTUpfVqA>
    <xmx:MiwEaVKw8FqFe6i7-vcZRVjv4crBM6QmAzffRwtekztyDdFq4UYjJA>
    <xmx:MiwEaYg1hazpgFlJAlLKJS6Z30da876qKy1vdsJTN4PukQ5-VYsMCA>
    <xmx:MiwEaeyfQnWjaQQsQF865F4wKIquzcSr-aNYpuQLHiRO9iY3-1Vds63f>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 23:25:36 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 00/10] nfsd: assorted cleanups involving v4 special stateids.
Date: Fri, 31 Oct 2025 14:16:07 +1100
Message-ID: <20251031032524.2141840-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series takes a substantially different approach to earlier.  The
functions put_stateid, set_stateid, clear_currentstateid are all gone,
so we don't need to debate the names :-)
Each is now open-coded where needed, which is at most two times.

e.g.  rather than checking for current_stateid at the start of several
ops, we now check at the point where the stateid is actually used.  This
is common code shared by (almost) all relevant ops.  A similar approach
is used for saving the returned stateid and clearing the current stateid.

As an aside the RFC talks about the possible use of a generation number
in stateid and we have si_generation, but that is what the RFC calls a
"seqid".  That's not confusing at all....

Also the RFC tells us

    An "other" value must never be reused for a different purpose (i.e.,
    different filehandle, owner, or type of locks) within the context of
    a single client ID.

We don't do that.  If the idr cycles, we will start using the same other
values as we used before.  I wonder if that really matters.

NeilBrown


 [PATCH v4 01/10] nfsd: drop explicit tests for special stateids which
 [PATCH v4 02/10] nfsd: revise names of special stateid, and predicate
 [PATCH v4 03/10] nfsd: use a bool instead of NFSD4_FH_FOREIGN
 [PATCH v4 04/10] nfsd: clear fh_foreign in fh_put().
 [PATCH v4 05/10] nfsd: simplify clearing of current-state-id
 [PATCH v4 06/10] nfsd: change bools in svc_fh it single-bits.
 [PATCH v4 07/10] nfsd: simplify use of the current stateid.
 [PATCH v4 08/10] nfsd: simplify saving of the current stateid
 [PATCH v4 09/10] nfsd: discard current_stateid.h
 [PATCH v4 10/10] nfsd: conditionally clear seqid when current_stateid

