Return-Path: <linux-nfs+bounces-15833-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64809C232B7
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 04:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B81AB4E9A69
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 03:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2714C28E5;
	Fri, 31 Oct 2025 03:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ZsfdwLIa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aTjbF41+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EE625CC7A
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 03:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881184; cv=none; b=UnBb7RNDVIiszgmrWSp4GBB8n05ySxBMdr4PWUh422WYTQZ1E4Dp3//uL6ghf44FonRuKoHKlnscdw8/1V+OfmsSJc76K2Sqjoea0GZjbuTojNxPwZyXFLe2JsUVNDT1D1wVqB/nCRc1JNf2UQdVg8Dg7zS6aImv2ZfdWrJkVbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881184; c=relaxed/simple;
	bh=3jMrwEiqfcFJwZcM9j2vn9sR5pOHmmg17iCujVlNVMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EspeztJKYBQnyKqyP/B9IP1QnXi9rDYSs2ecJ6GnUUxz2rJkj+CQUAH3pNVSRdf/JUhjXf8azyZh5KKJAhCOMcWPNleHTxqP3nDijieS1Hyvdooh2fzlJDBxYiqVgtSSuqWa0mG5MPNb9kE51yVLmCPTq85ztd9lbtzqKSvX7GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ZsfdwLIa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aTjbF41+; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id B97051D00141;
	Thu, 30 Oct 2025 23:26:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 30 Oct 2025 23:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1761881181;
	 x=1761967581; bh=l52bIh0HPo4/zHDDC7LYlCkjEDFuouw+u5o1at6TPS0=; b=
	ZsfdwLIa6XIvR7YR7DvGnbRS2f6bw4GcnJW12T6xES6xoQ7UImh+FWvgwkfZyVax
	FwV2EWh1APKmGmooSXBmK92vot3aFvNq9G69LLadXAOJ0iPqYManJDgFeRSmczaW
	mm9PTEpm41NvidWakL7L24I8gVB+Y8aMlmJ7012YAvsaio6sfea69SVXp1DLsrrb
	ro/8KMEz14KQhlEgcd3M14maTf0W4Q+1NTD/to2ozN4JNA2bv4FURzHMNK1xnbFh
	Nm1TnwF8SXiwFM0vxzxubTcpUfryg3spxxe2nHpd/Ybo4ziEwDL7dY0PKyc3Vn8M
	aABFHXOSKjrT4oJEpUlk0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761881181; x=1761967581; bh=l
	52bIh0HPo4/zHDDC7LYlCkjEDFuouw+u5o1at6TPS0=; b=aTjbF41+8FgSq2Uzw
	O+3zSjmABW/znuGwAkpthujl4zJLnKlTSqHvTI0MLroKo2ZDGsidk2yKT1PS4VKF
	r3ZoHEhYQd2lahbBpcn48r0W69N9KojL8grRcynH1trznlMsTyTonmB9iOUaRRne
	UENBEkSJLNmDoqgTqEW5UT5oU4nYfsBLjm3OaSCn3EUUHOljsf35E8Rk20uvWQv5
	19a8+XKnGfXBJsTwTkxdf5/obHQfjmp7DwQtwBsz/xkJKXRf4rvFq2tysQ+5HrkY
	8QZZ9VnX8cG49w4QBlH1tup9T0ky9kteIaewu+hW2RTG1/89PLUA5E8WIn+fGuv+
	TLP3A==
X-ME-Sender: <xms:XSwEacT4It4nXafcffd3a59MWjjbKCYx7FiS49uMVo9istjnIAeX9w>
    <xme:XSwEaddEhUTwr5JUqZXHvOXomm14Bw-lsJ6UsT8tsearkr4vasVxxndePrgnMPUSk
    cYlJ3bP4-8croXKYS9YCYPli5cfh9Lsv7emp92pe8PGv-sczA>
X-ME-Received: <xmr:XSwEaTrUjhnUVFONKKmvty2gpugafsQd6Gb-jEis9HFnBx1FjVmxgvnsi-Ji6t6qrbJusxiEHaosCx10zRB-fKnetxYt4l-R6mwpAHVqHqsF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:XSwEaW_o4QnFObT5_BpV-GMgxxuC3EEV4NnEIEWl97PbHcYZCeJw9w>
    <xmx:XSwEaXeAzRoBbGT2YYl2sS1-iErB1iwrw3rDnOaDHOtkE7d8aQJVIw>
    <xmx:XSwEaYK7zjlYZ0g2eC-Nw7ifOiRyw6IxgsHfJagpyUWc_tkX8F_l7A>
    <xmx:XSwEafgYXf_isrZS7aogsLShupmUN-hLevx27J3RwFT8z5gk9dJz8A>
    <xmx:XSwEadzma86ug2J5LlTb9e03pUnNQcGMMA7vJtpT4uYVrfrz6CNJeZC->
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 23:26:19 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 09/10] nfsd: discard current_stateid.h
Date: Fri, 31 Oct 2025 14:16:16 +1100
Message-ID: <20251031032524.2141840-10-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251031032524.2141840-1-neilb@ownmail.net>
References: <20251031032524.2141840-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

current_stateid.h no longer contains anything useful.  So remove it.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/current_stateid.h | 8 --------
 fs/nfsd/nfs4proc.c        | 1 -
 fs/nfsd/nfs4state.c       | 1 -
 3 files changed, 10 deletions(-)
 delete mode 100644 fs/nfsd/current_stateid.h

diff --git a/fs/nfsd/current_stateid.h b/fs/nfsd/current_stateid.h
deleted file mode 100644
index 9dce3004b846..000000000000
--- a/fs/nfsd/current_stateid.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _NFSD4_CURRENT_STATE_H
-#define _NFSD4_CURRENT_STATE_H
-
-#include "state.h"
-#include "xdr4.h"
-
-#endif   /* _NFSD4_CURRENT_STATE_H */
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index e527594148ca..93b32d69a83d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -46,7 +46,6 @@
 #include "cache.h"
 #include "xdr4.h"
 #include "vfs.h"
-#include "current_stateid.h"
 #include "netns.h"
 #include "acl.h"
 #include "pnfs.h"
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d2c5c1aefed3..515c78226a11 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -50,7 +50,6 @@
 #include "xdr4.h"
 #include "xdr4cb.h"
 #include "vfs.h"
-#include "current_stateid.h"
 
 #include "netns.h"
 #include "pnfs.h"
-- 
2.50.0.107.gf914562f5916.dirty


