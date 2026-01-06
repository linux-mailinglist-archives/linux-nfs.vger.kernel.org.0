Return-Path: <linux-nfs+bounces-17504-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 262BECFAD04
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 20:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F11E3081E45
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 19:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FAA33B6DB;
	Tue,  6 Jan 2026 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="0vHbmp+d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2B9309F0D;
	Tue,  6 Jan 2026 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721073; cv=none; b=b23mYsKWuEeZ4y6gkl6eO07GYYF0ovSOOOutXK6OAgPGAuPoZwWLxZEPhQVCNaU+7SG2YSoaDxM5a5xy4FJ3dig0kywztC/v279vSnRHzidKZe/QhGuR0fv3Tucpv5XLpwrBsrPtEv+NKc5OBImXwCHjH2VX4UvkqqtXP2yN0P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721073; c=relaxed/simple;
	bh=UxhWDGoIp7Co8/zCbJaLOU8vA/ysfaxZLtMn+7BpHzk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lPolU3DN50ULfudt57A/+iJ5C2hf6KsGE5GY2+toOH7uCS6nJJS8R4fmHehrexq9QYAXx45325VcRs91dbeOe3QW2U6M6Lz7L7ADdIeBoBtKVFcm+dOmNsT42RvgKZ6r3TB+5rmfg4+kAf6+VMElGoNvdG2ifRlRVVH2PVMYCPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=0vHbmp+d; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=7IJMeeN5wnuf6Vhk3tgBbvmxQwetO5bIAlhzQnOhTxk=; b=0vHbmp+dI2Cm8c
	BgO+avQ5DTsX7mHZPfk/UMhrz1LfaQ5Cev6SQfusW75EMrVAGR+r78/zgQS5oFfnU4rgpsG+KCVo5
	Sgbl6uca8oxakP/Azde61YhbLYDU0TANNp07vXN1twJ1M7TwUXO9h4Ks1CgU6pNsrYzy6c1SZNj6P
	E4XTFclpVmBAmaXaiUWCgEooAh4SaGXXvbBufhoZNjBR7yrNiHOVlkiSTasGLNsVuPmHvMg1EQnvp
	nqGTpWhGKwlm5q6jHsD9FEGTyBVQWygBAMzdgcwnpAdYReuL6+DBRbvWh8+pxLoIK4R1R2TixbVvx
	+fvGUgo1LqcNbuebwIuA==;
Received: from [63.135.74.212] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vdB07-007TQ0-2D; Tue, 06 Jan 2026 17:37:47 +0000
Received: from ben by rainbowdash with local (Exim 4.99.1)
	(envelope-from <ben@rainbowdash>)
	id 1vdB06-00000000J1k-2bYr;
	Tue, 06 Jan 2026 17:37:46 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Cc: jlayton@kernel.org,
	chuck.lever@oracle.com,
	anna@kernel.org,
	trondmy@kernel.org,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] sunrpc: rpc_debug and others are defined even if CONFIG_SUNRPC_DEBUG unset
Date: Tue,  6 Jan 2026 17:37:45 +0000
Message-Id: <20260106173745.73131-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The rpc_debug, nfs_debug, nfsd_debug and nlm_debug are exported
even if CONFIG_SUNRPC_DEBUG is not set. This means that the
debug header should also define these to remove the following
sparse warnings:

net/sunrpc/sysctl.c:29:17: warning: symbol 'rpc_debug' was not declared. Should it be static?
net/sunrpc/sysctl.c:32:17: warning: symbol 'nfs_debug' was not declared. Should it be static?
net/sunrpc/sysctl.c:35:17: warning: symbol 'nfsd_debug' was not declared. Should it be static?
net/sunrpc/sysctl.c:38:17: warning: symbol 'nlm_debug' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 include/linux/sunrpc/debug.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
index 891f6173c951..eb4bd62df319 100644
--- a/include/linux/sunrpc/debug.h
+++ b/include/linux/sunrpc/debug.h
@@ -14,12 +14,10 @@
 /*
  * Debugging macros etc
  */
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 extern unsigned int		rpc_debug;
 extern unsigned int		nfs_debug;
 extern unsigned int		nfsd_debug;
 extern unsigned int		nlm_debug;
-#endif
 
 #define dprintk(fmt, ...)						\
 	dfprintk(FACILITY, fmt, ##__VA_ARGS__)
-- 
2.37.2.352.g3c44437643


