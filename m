Return-Path: <linux-nfs+bounces-16448-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12377C64A9C
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 15:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65BB534210A
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 14:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9550832938D;
	Mon, 17 Nov 2025 14:32:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE772C9D
	for <linux-nfs@vger.kernel.org>; Mon, 17 Nov 2025 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763389970; cv=none; b=hdyg6eZATQcHtJo9/7VIWQp8HjTnzXtU7PKMXNYuQLrP4A5dtx5W2ASwR7R0B3bq2mNTJYFEhCtaqtKvhSrHwxYDLeEblyS/7NcraYhCcr9sXzOLooCB90cLZV/zwk+CH3Wn3reCquxkKkfn7ANbL6QHPt3yNwHu+eldlNm7lUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763389970; c=relaxed/simple;
	bh=3l7SefgOKi61O+YOv1eN9mfOzJGKFQFin72vRE1O7d4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Vmbnl28HVSlzB0i9idVGyX7Liwy5n1lM0HS17nu5sl8RpinoataYm3Xg/bWTpJ+7687KGhAGNUDrbPqSk0uKFhrULkOq5MtxGktfMh9RCiNFUbwJMarHm9pkUTsNgq3ak0C4iVxHqnKz3QGy0MLmwy+jGxgjn6swUOAyPZJA/KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5364FFEC
	for <linux-nfs@vger.kernel.org>; Mon, 17 Nov 2025 06:32:39 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 782D13F740
	for <linux-nfs@vger.kernel.org>; Mon, 17 Nov 2025 06:32:46 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: linux-nfs@vger.kernel.org
Subject: [PATCH] locktest: use correct build flags
Date: Mon, 17 Nov 2025 14:32:41 +0000
Message-ID: <20251117143241.1501312-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makefile uses CFLAGS_FOR_BUILD etc but since 2020[1] hasn't used
CC_FOR_BUILD as CC.

This means in cross-compile environments this uninstalled binary is
built for the host machine using build machine flags, which can result
in incorrect paths being passed.

As this binary hasn't been built with CC_FOR_BUILD for five years, we
can assume that this isn't actually used and just remove the _FOR_BUILD
flags entirely.

Original patch by Khem Raj <raj.khem@gmail.com>.

[1] nfs-utils 1fee8caa ("locktest: Makefile.am: remove host compiler costraint")
Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 tools/locktest/Makefile.am | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/locktest/Makefile.am b/tools/locktest/Makefile.am
index e8914655..2fd36971 100644
--- a/tools/locktest/Makefile.am
+++ b/tools/locktest/Makefile.am
@@ -2,8 +2,5 @@
 
 noinst_PROGRAMS = testlk
 testlk_SOURCES = testlk.c
-testlk_CFLAGS=$(CFLAGS_FOR_BUILD)
-testlk_CPPFLAGS=$(CPPFLAGS_FOR_BUILD)
-testlk_LDFLAGS=$(LDFLAGS_FOR_BUILD)
 
 MAINTAINERCLEANFILES = Makefile.in
-- 
2.43.0


