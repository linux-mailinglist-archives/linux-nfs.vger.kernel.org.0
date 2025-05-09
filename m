Return-Path: <linux-nfs+bounces-11631-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF66AAB1D0B
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149744A1545
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 19:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1417D243387;
	Fri,  9 May 2025 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsN+mL39"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CFE24169B;
	Fri,  9 May 2025 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817445; cv=none; b=JPP+e5WASynHuzoR2c7EipFM550y5dClxpvn5i5WiKHWMuLFB3pB7qaB+FQG7WKI4adbwOiK5O6HR5fJh//t+U9wA0NB+fPYHmpgkYh18U7MGQTuT08uwrEfN6NQt9/DSoQXT321rhY6NVNFt5Reuu/mJxcBNpM4l6DXYtL4CM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817445; c=relaxed/simple;
	bh=EuvVL61BxfXVGGlDS/KnWG047ihuK8S1vV2BWINdNw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uu1Z7/t7oyFa+BTUh0flPnaTunqVJLaaThpSj/BPpbfORVdup87h51oHsVUohyIGc7+AT+bsOOIoeXhkCqc4VQLg74MVlYd1/UYy4LatBRZ9GWeDlnXLkixqhaNbs+aSMknUDdXbHZnrGUrYjVJlEfsB21kyw02Kd63qgqgjsGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsN+mL39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCCCC4CEEE;
	Fri,  9 May 2025 19:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817444;
	bh=EuvVL61BxfXVGGlDS/KnWG047ihuK8S1vV2BWINdNw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GsN+mL395hrXFxI3R7kK2wtNyG3j0vTybomD4nyaaVzc4bFS2QqdARPu1FUXwmUkB
	 Gdpz0SceZBELoplZZlSqk5znIM6d1AuGRXfdow07+vBGkOXYr6H4cMZhRp1Y8rAU10
	 pBQ2o9rYGj95NdbZ8WCN2NgjQe0h1+pS7LbMQNxJVJzWtgc3myANp0D9tREp2LjhFg
	 GZOOcMu6V+tMMHXdicYYV+1t4MsIYY3Ytq8FikToQ0+G5c9rJh6tedpJBJYyQVgGkG
	 IlEc35EcuLtyhc20KZMBHKWrmD0oL6fVaQcZ7QiNIuUSxcRiZ17eI2EmeqGC90jMs0
	 qylpwq+JkSmSA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v5 09/19] NFSD: Use rqstp->rq_bvec in nfsd_iter_write()
Date: Fri,  9 May 2025 15:03:43 -0400
Message-ID: <20250509190354.5393-10-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509190354.5393-1-cel@kernel.org>
References: <20250509190354.5393-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

If we can get rid of all uses of rq_vec, then it can be removed.
Replace one use of rqstp::rq_vec with rqstp::rq_bvec.

The feeling of layering violation grows stronger now that
<linux/sunrpc/xdr.h> is included in fs/nfsd/vfs.c.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 43ecc5ae0c3f..fac53cd145e7 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -31,6 +31,7 @@
 #include <linux/exportfs.h>
 #include <linux/writeback.h>
 #include <linux/security.h>
+#include <linux/sunrpc/xdr.h>
 
 #include "xdr3.h"
 
@@ -1206,8 +1207,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (stable && !fhp->fh_use_wgather)
 		flags |= RWF_SYNC;
 
-	nvecs = svc_fill_write_vector(rqstp, payload);
-	iov_iter_kvec(&iter, ITER_SOURCE, rqstp->rq_vec, nvecs, *cnt);
+	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
+	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
-- 
2.49.0


