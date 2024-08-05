Return-Path: <linux-nfs+bounces-5235-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E150D947A1B
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Aug 2024 12:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D1F2814B0
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Aug 2024 10:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9314C154C03;
	Mon,  5 Aug 2024 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZcqGTwn2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC93154BE4
	for <linux-nfs@vger.kernel.org>; Mon,  5 Aug 2024 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855450; cv=none; b=WzcgaoFoSpgkTbi6T+gE4wrjrYTUPs11zo9rv6tryw2Bm9zOVLRAPFb6HpLWVI8TYISjwnURrGSq1/jfxA34MrmjvOUkO9cF7+RZ/YYz0Pg3nFOC1w3G+1GtPLpHiObUJ3wajc+snAtOU+AK/CKarLl/IWngrRvn/d+N1bqFhe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855450; c=relaxed/simple;
	bh=KhDB+/ANMpJdPv7/B9bx/o7QT+w+5lf9A7cVPW/bv+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qQC+t+IG1+i57pqfgl5OdBi6N+REnnr9Axp1B4vCISxTOzj64Lupr7IXisNHhL9CxOwTL1qdSpFBpMVsbF7nD8NOguqfR1IZsqS3EaGVJv4Drcl2l4NHiYzytvxokFAr+wWf0ty15Zfr/UpYRYogI4GvgJGd500cGJqaYA9utFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZcqGTwn2; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722855445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0JMJYUXrEsAvRgi002MIl+NnrGBB5A9S5Tb1OOT7df8=;
	b=ZcqGTwn2KhRmfWYPKK2PB0FYRCBnFjm3ZAdEniq/4KsSUIDXbqmqZmlYm/d2kmzjP+X56R
	WAHSiJgpgqJPiR9B7x3nCPUDXH4qmAR7kPJwbzx17NTRAGtutxgGR0y0MsCz+BNV8CDVHi
	RzWEBXmO17KCR8DGDxlO1d2t1+b3rCY=
From: Guoqing Jiang <guoqing.jiang@linux.dev>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: remove unnecessary cache_put from idmap_lookup
Date: Mon,  5 Aug 2024 18:57:15 +0800
Message-Id: <20240805105715.11660-1-guoqing.jiang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

It is not needed given cache_check already calls cache_put on failure,
otherwise we call cache_put twice in case of -ETIMEDOUT.   

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 fs/nfsd/nfs4idmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index 7a806ac13e31..08a354783d57 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -521,7 +521,6 @@ idmap_lookup(struct svc_rqst *rqstp,
 		*item = lookup_fn(detail, key);
 		if (*item != prev_item)
 			goto retry;
-		cache_put(&(*item)->h, detail);
 	}
 	return ret;
 }
-- 
2.35.3


