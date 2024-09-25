Return-Path: <linux-nfs+bounces-6635-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11722984F80
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 02:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA1A284B75
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 00:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3322C4A18;
	Wed, 25 Sep 2024 00:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i6IcYMWC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147F1182B3;
	Wed, 25 Sep 2024 00:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727224692; cv=none; b=HHN0o24hK7LFzAzWquQE6YiIDIVpr9DghLQzGp+zzcwsqICJUet7WoSBLjMsTpIrE9C3UZEnaPG8Q6Rr9jhyElcuFJtSu9r26eLQLYcL23p9zupt0RUEZM6F5WxM8hI0xkzzjIbx/hu/zlX/PeWYOt6ITGzTr2L8cxtbhs/kvhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727224692; c=relaxed/simple;
	bh=LvjLSHc/UONrtjheP0u/OXO2knPXZPRU5IF9QjPCMtM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nxtb4oSZKWixjG9Hn4PH7CaxhHGOLj6b7DVL5a/2ffUW3O3aBRJ4thlEzv6Gd9qJMQ/ZINKvncrcAywdZbMGRQrclLZsUog3+HvIIM1c8Qj0/8lEHoyRaxmZrwLc7Lk5wQY+3DEqzBlbNyPr7d2OeaE3AcQ5weWfY1Z+vHPz3Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i6IcYMWC; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727224686; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=sXnRssGR22aI+TcHSakhfD7awYhwBEz/yWC8prDCIQw=;
	b=i6IcYMWCABgu63Ns6CtEV+B0CqzIetRACU/5040cB8yW0rkm9r1valCGPVhcjWYBEjW8Chi2suVmYcPEuaEPbe+m0+zXgXWsYCc5o3yuzAKYhoHIcU7pSHisLPtw8lSlp3/N3MhEKsjt22u1CKISfafMig0Ykd5kjCo9IKADyTo=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WFhb-Zy_1727224685)
          by smtp.aliyun-inc.com;
          Wed, 25 Sep 2024 08:38:06 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] nfs: Remove duplicated include in localio.c
Date: Wed, 25 Sep 2024 08:38:04 +0800
Message-Id: <20240925003804.71899-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files linux/module.h is included twice in localio.c,
so one inclusion of each can be removed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11073
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/nfs/localio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index c29cdf51c458..c5922b1a77c0 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -18,7 +18,6 @@
 #include <net/addrconf.h>
 #include <linux/nfs_common.h>
 #include <linux/nfslocalio.h>
-#include <linux/module.h>
 #include <linux/bvec.h>
 
 #include <linux/nfs.h>
-- 
2.32.0.3.g01195cf9f


