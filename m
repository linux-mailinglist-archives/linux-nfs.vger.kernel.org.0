Return-Path: <linux-nfs+bounces-11633-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E23C9AB1D08
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00B4F7A46EA
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 19:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4B224466D;
	Fri,  9 May 2025 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIYiO9xN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96237244663;
	Fri,  9 May 2025 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817446; cv=none; b=WpArUTaVOOqruIrhxz8cYezin3YLxe59SbnZQ6d5MGjMJlzegmTfPHcd1WAUSFjptZb2iCjv2ybMkWRLpcWPLhIjBhQ6GyIsSsfNd2J58FhHuYhbULYFRTrUAKHhRNJgwcQN0QfQe1HTih8QTNkvb4QizKfezuyMKFL/5VjDHVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817446; c=relaxed/simple;
	bh=JPgN/97mpJgS7RDESHifVqCvnCoZfswjd6exDXBdxyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cB3flRAnfYYnR824IDGQ+0RkuljdKbrQ/twICBts/If3NHfx95eLmU/YphY2fcDL5ptNHYxNpqKnq15sqc3KJBTwRXDePDAvnxX1YF3I5t+hj7zh5vVz9L9RlZvjbQ+0l2FCVu/CW10ZY3QZKY7e6HVEensmFErsgSjJfGslOCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIYiO9xN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA7DC4CEF0;
	Fri,  9 May 2025 19:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817446;
	bh=JPgN/97mpJgS7RDESHifVqCvnCoZfswjd6exDXBdxyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FIYiO9xNsjNJga32N5mL3BLt4ZnVQHsZN2QsSEqrmG4XNnP+pM7Dw9uWpgSYPTILY
	 /mT2ehYvgxL2quAnxX5s8ZWC+v0pMqicN/dx211bGr6xVjAg4gylovuQxsJRLm2ZD1
	 fTmFwZLFIKgutp7TM3PYOQAG/OyZYsIiYg6DYCpCVKcSRO3bF9NPcCqqZjBHJ2xmnC
	 TG2eoN/YygYUlbkBYCEz/ZEbG3sTmplObX6ntGN+jZljl6mmRUfJzNLjI3tQ3HrkVW
	 AoyvxaM/sUNgDuEnvpFFCT/LT/zog0ksjTB9TJMogbD+FUj2Zd68itmBdYNr+UUzvq
	 KvefB9XV3rnUw==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 11/19] SUNRPC: Remove svc_rqst :: rq_vec
Date: Fri,  9 May 2025 15:03:45 -0400
Message-ID: <20250509190354.5393-12-cel@kernel.org>
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

Clean up: This array is no longer used.

On a system with 8-byte pointers and 4KB pages, pahole reports that
the rq_vec[] array accounts for 4144 bytes.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 510ee1927977..6540af4b9bdb 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -212,7 +212,6 @@ struct svc_rqst {
 	struct page *		*rq_page_end;  /* one past the last page */
 
 	struct folio_batch	rq_fbatch;
-	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
 	struct bio_vec		*rq_bvec;
 
 	__be32			rq_xid;		/* transmission id */
-- 
2.49.0


