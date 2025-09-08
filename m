Return-Path: <linux-nfs+bounces-14120-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B8BB4823E
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 03:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144AE189AFC9
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 01:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA59185E4A;
	Mon,  8 Sep 2025 01:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="unXxRJx0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T5RsVSIc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1E32AE99
	for <linux-nfs@vger.kernel.org>; Mon,  8 Sep 2025 01:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757295853; cv=none; b=qDLGk66EXSrZEziRHwJRXBXEw1QGh0DnoviXq0VAYNC+FAxgLjFYbf31XdGAzcvPMsSrQVmbeiOXZt2QvJC/ePk1kgcJL6UgimSSgS2/OIEczKR/xrncycX1oqvHLm07y4WK2lhiaJ/ZM1fj/buV60/8pn3zQNcaSgqPCy7G7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757295853; c=relaxed/simple;
	bh=no7c8Yfqn2ef2s2RmHc014BRv7O5ctPs9Bnz9Zs8LfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r0Q60TRBUfITiXjkpry7Hb7+VcdlbDNWugWelikoZl0DtHcAeC7i3fgxqzuKyTEkLC6Fak7m50Ef0k3I4sdT3xxGmtoRqcmEc4EHqKm8Z3cX8Yr+kSEUpA8NlC2ia9w3XISlzJr2ncO7vNOOCIaJY4d6CBNka8MQsaOOPX7bK10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=unXxRJx0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T5RsVSIc; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id CAE2BEC00C7;
	Sun,  7 Sep 2025 21:44:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 07 Sep 2025 21:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1757295850; x=1757382250; bh=nG3RqZgB9VDBUPcGze+7L
	8ZpwOOvtHENOj6YBeuG6+s=; b=unXxRJx0uQvsWAWP9KebZYh7Mt241VV9IH1Wg
	rzmKrwzLG97iZlmxvYaBmEBYmqK/YLysEqChdU+YaFwkJowYcWntPwUYvFaM3c0A
	2tU0F4TPmDr7ulguHsojgQ2Wbd7dYHUvLPAiu6pWztSiNYti3yPlcWHh6QomFtr7
	P6rG9ILQuwJSjzu6SwSttwEbf63nvXbO1gyYch2UrusBKZj30MpnbixCzCWX7uMO
	oEi2Plihid5PTXYTfpkeZKpNG1ebLuP2LjL5mP8m59tTlQamAyN/QVADvcBXJZAQ
	kbq8GUhQxQPwR3SpWkCuQLFzr4JzUdTbyVo8PszoY94xcr69A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757295850; x=1757382250; bh=nG3RqZgB9VDBUPcGze+7L8ZpwOOvtHENOj6
	YBeuG6+s=; b=T5RsVSIczFl2f/jEtgDmmN5Ol8mqndQWZBMxWTEyz1fmlyt0EIB
	9DLagueQ4SBp3CFr8xJDmwGooPo0jn5TmZqVtJ7vPols/BD+luusnj+AabhH69c+
	Zt2vjZXvsNMMIpGl76qn4/MRt324J7p1xWguKmYf7pn7bnC9fy18B6ZdlW2SsmSZ
	3zO/JgvuYUMIQ2S7E1VBl30A4e5qbAn75yHpeFb8STlk+2XP1M/4VhwXEfuKIWIz
	Uh0zqBgiJK1Z2ShI6ho+9ARczeEv2MCmznLVIL62G+I2x9DyNTO2YHtdZf4e4gDq
	7sjr2cgcfhNI1u2KRu7sAuUjnCQUZTR4NMg==
X-ME-Sender: <xms:6jS-aCQ8gmf10hO0KFU8hhOXHtMxlexkf6xNftQvCFkjo0LpxYP2jQ>
    <xme:6jS-aANObwZCoFWbZ_n95FvrN7jcDw9CiaWPomb15ygF5n-KQbVggPtCJk-VWx3ZZ
    C1zrzgmG5-tTg>
X-ME-Received: <xmr:6jS-aARZLCaGmjMoH7M1vGlu47zhxzeugFnsXjPryQiXb9Nud1VRvUGwIf1mFeASfFiA7r6seewMOUSLP7Tqj4kpsBNxE8dmLLihRLzflr0n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheurhhofihn
    uceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepteeiff
    ehledthffgieeuveetffegteeigeetfeffueekvefhgfdthfeugedtteehnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnh
    hmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhnihgvvhes
    rhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghp
    thhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6jS-aOhNAQe7PtVNx_wOcN2pIEJW2kHnsjqsifVSkOO5wxhDQFX3gA>
    <xmx:6jS-aJ-6nLhydkGbP0lQmkq4ZTGcsdXrquPPYg4KMFnlK6T2rIS-uQ>
    <xmx:6jS-aFHGAmUEz-dFAMymSfcRXND4hvSyzyrUCz2P5YC5nV69WCoz_A>
    <xmx:6jS-aMk61Y826kmVmNMD1J7Iz8jvzerD2BPVuVQllLNvH-nYU_87Uw>
    <xmx:6jS-aHfE9rQQ0o9THKIg9EnD4sDUQh3zmM2n-J-KOnZhSpprvm6FFbZU>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 21:44:08 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] cleanups in nfs4reovery.c
Date: Mon,  8 Sep 2025 11:38:31 +1000
Message-ID: <20250908014348.329348-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This first of these patchs is part of my work to change how directory
locking is managed.  That will involve moving the lock as close as possible
to the operation being locked, and using some standard interfaces 
which combine the lock and the lookup.  Then changing the mechanics of
taking a lock.

nfsd4_list_rec_dir() currenty locks a direct and performs a lookup
in a different function to where the lock and lookup results are needed,
and does it even when those are not needed at all.  So the first
patch moves the lock and lookup to where it is needed.

The second patch (arguably) improves the calling protocol for
nfs4_client_to_reclaim().  If people don't like this second patch I'm
happy for it to be dropped.  It is the first patch which is particularly
important to me.

Thanks,
NeilBrown


 [PATCH 1/2] nfsd: move name lookup out of nfsd4_list_rec_dir()
 [PATCH 2/2] nfsd: change nfs4_client_to_reclaim() to allocate data

