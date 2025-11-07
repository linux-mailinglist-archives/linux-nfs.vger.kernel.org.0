Return-Path: <linux-nfs+bounces-16177-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDF8C408BD
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 16:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEDDB4F16BC
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 15:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1E832B9A1;
	Fri,  7 Nov 2025 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpF5TYha"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD7932B995;
	Fri,  7 Nov 2025 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762528194; cv=none; b=HsyX7J+fWlbvgO3D8U/QXHkwyhrZe0yASQrINYk1rrf/jVCRdjyCjYeZjkw4kno02TXIZMlgiBNx0sHAqVZwhkcihGdeHrIlj+qS02Dl/GFctfEYl9oa1Sl0j/+hBhPPwcbNnueuRslpUFiOCRPHTBIcNtEKQ/caYfoxDKDh1bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762528194; c=relaxed/simple;
	bh=jj5Fmwvzrbz6it15+oSS79Xx8+kWMHkmBoFleAxiYKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRdzuVgiRVBUhvYcMvhBVpSKxrzwu29NcH2SDDy7Z8kMhX0jiNpdIlxyBg+7hOFIcPG6PtqhYmK77foKksxGcWsKPKq6tDQSxpA6M9gX7YmwlUXKbzQolKr4fNO2aPRq1pdoPpAaPkhaGXzIZMI5uC9JT5uCjxZVcbP0hB225HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpF5TYha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DDDC19422;
	Fri,  7 Nov 2025 15:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762528193;
	bh=jj5Fmwvzrbz6it15+oSS79Xx8+kWMHkmBoFleAxiYKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lpF5TYhaWim8MdBs4kTMHtQnRhfHFDZHlz3VS5/fDZGAst7z5UESJ3kDmkaqUXfZ+
	 Fw2qgwNDGVZa8JigZ91ywq6YHU/MjRMOd8D1rRyoFm0smS+oPWyIa7cZ9IOCIb+x1c
	 QRPAZ/0Q31aO4o3Q7pimSkOkxH1nHnV/+Hzo4U7vJUnPMfVVbY+iyf8zc/JyqbqSkg
	 9UJq75v8Bj2xHRUZ6zClZ171klT1Qv1ejPFCOnfEwoDuC4CPWrYcTXskV0+D7/oMw9
	 UT4SBaSbpvEpz/cx5lZ2GnIdy9zsYtwAkJVo3ESAZcYOiYkkSZbOh5NmKtieD3WRka
	 cGIvg52U652gQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Joshua Rogers <linux@joshua.hu>
Subject: [PATCH 2/3] svcrdma: return 0 on success from svc_rdma_copy_inline_range
Date: Fri,  7 Nov 2025 10:09:48 -0500
Message-ID: <20251107150949.3808-2-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107150949.3808-1-cel@kernel.org>
References: <20251107150949.3808-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Rogers <linux@joshua.hu>

The function comment specifies 0 on success and -EINVAL on invalid
parameters. Make the tail return 0 after a successful copy loop.

Fixes: d7cc73972661 ("svcrdma: support multiple Read chunks per RPC")
X-Cc: stable@vger.kernel.org
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 945fbb374331..e813e5463352 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -860,7 +860,7 @@ static int svc_rdma_copy_inline_range(struct svc_rqst *rqstp,
 		offset += page_len;
 	}
 
-	return -EINVAL;
+	return 0;
 }
 
 /**
-- 
2.51.0


