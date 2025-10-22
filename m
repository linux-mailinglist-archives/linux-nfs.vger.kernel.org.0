Return-Path: <linux-nfs+bounces-15553-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7EFBFE6FA
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 00:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAF33A760D
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 22:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F3026ED44;
	Wed, 22 Oct 2025 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="VDwKQW1Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gZpPW6kn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DB12F39B1
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 22:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761172674; cv=none; b=ifVwv2aC05jv8EX+8cfcD5CU4Pw1yd0P43rG7S4CSgjViyG5L5DMtDszVcF103x0ALYVvi5Ct0sSlsFbsc6zeS3BsbPTooN+YjX2IU3fRHM47DokDMqRbOpRcWG90LNF5k0D8EJ+R3j6QrVS2J93IjXE7Y7Prbe9Wm9n9N9AQ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761172674; c=relaxed/simple;
	bh=IcLtWFAo12zqgNlEigsFGvjKxSoCRKBvTVJ1yxoa8RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=is8tRHV8JN0XnIg8m5EpkLLX8smBP2rH11WWRVe0FQWuQTdQx8msq8TsGz8x9gX/1IfWqdOpHLhQUXJAektBZaj6ryttarmptZAoKtuvYsTWb0CCi6sMxNf/NFhyIeRl9iaMbQEKDSExxCtq7ylrVakupfiDxLsKu98B9ZQ0uPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=VDwKQW1Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gZpPW6kn; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0BE73EC01B4;
	Wed, 22 Oct 2025 18:37:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 22 Oct 2025 18:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761172672;
	 x=1761259072; bh=cTWXrWfrF6qtFWHI9MYwGWia7JN/RnW4Juyl+BExDDA=; b=
	VDwKQW1Z/oJr6Bn9tUOopwwbKO7xIlObQTh1nuG071TFeQ9Pn8aEGuP9F/8MdODJ
	CJjLHFKye0wUvTZcWg0ixWcpAzwmhK4f8qs4f8Z19XmPd0vM/8ZWrtQNaPTce0y2
	i7dRYTkBoys0aMe+1J66IxXO/CTE7kMG5c9gHy+aCFiO9cKzvYOY6PU287bqB8NI
	8IrzKBEkzjdt5/rvDCAsetEGGMcVomF8NFmKupUYCRV6qF9xpJ6N1v/K1a4HLgct
	Mb5OhyGWUk5EmH0idDc8U4SAcRyO+PfsEwvmryTHkffCW2ybUfs6VvtGyoTOPnAM
	kXY5ieXFhEggEfDS72E+Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761172672; x=1761259072; bh=c
	TWXrWfrF6qtFWHI9MYwGWia7JN/RnW4Juyl+BExDDA=; b=gZpPW6kn/tSwm8DaA
	LFVdr2J1md/c8KWouKLEgQ+hQF+gs8lujS+J/QXXqqIWyXvtz8dEYEPVDZcF68Ew
	SW9KIXgm3E/H+5EPS8g1C7X4sHKwsov3HJM70AX+NInBOFDb/Ek0E6TnhoLGABJy
	OrO2PqoBk6WSXkfMou5f0f5ESuy0j0vSecDSOjxWizG2wxgvzBHRhWeW64ubhjqe
	KSFVwIs+2qlOb6QWWU0iu+/opxrh4BOxWa4MuantczIZfMhR6WVgisab8NrrL+C2
	QnbHBsIkxzW7OyrsRyIfhUf51RFVJ7FFCEza9C09ETz6M7H4yT8LXF3qxsFc+oLe
	UtTiQ==
X-ME-Sender: <xms:v1z5aAZUQ_uQQvRBwXiYguFJ-vId_CleSRFAj0Zsy9WC41Qf-wTR0w>
    <xme:v1z5aPFrIRqjTjXiHMMy2YR99Ztisdst8Ma-sxSDzi2MBIVpvF7p1TkVAOV0IFXH4
    sTwVYqnDxE7QHNB7hlj2Iv35Q4yOApKqEV-xU7QxKy9Wsb24w>
X-ME-Received: <xmr:v1z5aEzWJPA8Th1knCb97aTV5eIYnl_syivXGMfzei6ey1WNtbOM5Nl-SPInBHnNfu8KJ14JZLA-A3NATxd13jTzvK3TF-HLgaf7pTmqMfOe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegjeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:v1z5aBn2NLLoyhB9_r26t7as4ueNfaHQoIup-_vwkiY2hPnZJh-9ig>
    <xmx:v1z5aNkNKWnKOha9WuEck6R420p11z587kznmiZ97tCMyYvI7v1xQg>
    <xmx:v1z5aDz6JyrKi-Z5u6O1JrYhV6zhGkmcl_bQG60n3V0QOMnC3bTiQg>
    <xmx:v1z5aCrqL6NboSmidrtn7BsTQIzx5_4_cAmrj0LU_ArugOF-LOWGjQ>
    <xmx:wFz5aJ4o1Mxy_bOdCUESU-VVo1j2xdGx0OhoRsG_JTuZoz0lRbvthW7h>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 18:37:49 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 6/8] nfsd: discard current_stateid.h
Date: Thu, 23 Oct 2025 09:34:33 +1100
Message-ID: <20251022223713.1217694-7-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251022223713.1217694-1-neilb@ownmail.net>
References: <20251022223713.1217694-1-neilb@ownmail.net>
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
index 8d21fc900fc7..19dba0664ec2 100644
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
index 429ed80a13a7..4cdf8668eb10 100644
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


