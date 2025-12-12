Return-Path: <linux-nfs+bounces-17052-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C07CB85B3
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 10:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 628C13011A7D
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 09:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE69E30DD2F;
	Fri, 12 Dec 2025 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bHM4DOjI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7129722B8CB;
	Fri, 12 Dec 2025 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765530148; cv=none; b=mFS/GALGowDHdlxpMXbUZlHBYkgrfLJ2YuzFFtwsf92joLQ/nfMUK2YRVM/6eEGJcSPlA5eww1T0atHgRgwmM53rhT1yfJTxff1emiGaB013LeLqaSVY76wm6ehAdk5FpqpWjd7+Heqt7IvFxBHPx4Gp1eBAppm+yaUUh4sDRaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765530148; c=relaxed/simple;
	bh=EQdG4V+Hdw5dhgbxukvZigjZUhLOzHeybaoPZ3bS7w0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PhLFVBAYF+0uYGX5g8tKDJr+DqhDuRYcMDeZ44In4E9+4z8fZKqoxe5yGtxHy0qzbrXFqtItYr12TaZe+fOaEYeYuQqI4QyKCaDSCliTAXceNtbAZMn6dDG5bmT0kjnAJpCPIcXfHWY20ggay7KhHrpbihJ1MTpSGxh+G89TrxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bHM4DOjI; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fG
	tkV+V8EKIFYz+NK5yfo9yPxVegjc2xk2uMxBZw4dU=; b=bHM4DOjIO0kFTx8TXQ
	FUnu9dn+MWizcdif0WxZoisylg3csVJbY62yav7iXVXIgzW/tsRSgTpkHC+OIdLX
	ew+PyOOfAjz7GkVGB3rRkJ+r6tjbq4lS+RgiJT8XM7S0BpSROaNkfnwIv1KF0Fpk
	FqpHO4kfByx+ep1isuQ+zrilw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXs1sH2jtpqxIkBQ--.24109S2;
	Fri, 12 Dec 2025 17:02:00 +0800 (CST)
From: "rom.wang" <r4o5m6e8o@163.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Yufeng Wang <wangyufeng@kylinos.cn>
Subject: [PATCH] pnfs: add checking of the return value of sscanf
Date: Fri, 12 Dec 2025 17:01:58 +0800
Message-Id: <20251212090158.43715-1-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXs1sH2jtpqxIkBQ--.24109S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF4xGrykAw1rAFW7Jr4ktFb_yoWxKrX_Ka
	43Xry8WayfGr1Yywn8KFy2gF1jgrZ2kF48XrWqkFZFy345JF98Crs7K39Yyws8ur4jgFWr
	Aw18Cry2yrW3CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1JGYtUUUUU==
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/xtbCzgjhV2k72ghExwAA3z

From: Yufeng Wang <wangyufeng@kylinos.cn>

Add a missing check of return value of sscanf

Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
---
 fs/nfs/pnfs_nfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 9976cc16b689..c6a999f6220d 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -1114,7 +1114,8 @@ nfs4_decode_mp_ds_addr(struct net *net, struct xdr_stream *xdr, gfp_t gfp_flags)
 	}
 
 	portstr++;
-	sscanf(portstr, "%d-%d", &tmp[0], &tmp[1]);
+	if (sscanf(portstr, "%d-%d", &tmp[0], &tmp[1]) != 2)
+		goto out_free_da;
 	port = htons((tmp[0] << 8) | (tmp[1]));
 
 	switch (da->da_addr.ss_family) {
-- 
2.34.1


