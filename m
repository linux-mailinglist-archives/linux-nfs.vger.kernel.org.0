Return-Path: <linux-nfs+bounces-4345-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CF4918E6E
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 20:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721CF1C22385
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 18:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A5519069C;
	Wed, 26 Jun 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsI5WwKq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1130190699;
	Wed, 26 Jun 2024 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426482; cv=none; b=Uh7kpR8Mo5eFUIv0454NbvrV5IB2Tm9A0J/XM8PkK9zcwLXDNqidA3axx3ZieeLHtj0T4XGaNXoazjNEpAHqs3BJqpkaKCFuFw5CJboPXptXC8d9V3vgcg5p28Mwq+lrdUvKjkcxVa3MEv3Wm/MJVaUQ/HrLZkLFHACj7OD69qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426482; c=relaxed/simple;
	bh=lz4BNp2Exc9fBCHQYkJbsU/O6zJopS2cxihAzvadqlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKJfRPCK5E7ZFQC/+SatIr2/oFwWQ2LHK2XrIjVzd+oyEjn7tnQKy8DFq06SGexpE1r93p3LwhQdLhRSE7HrSZKhYcfQ1cuuqUQnirvXTkb8qe3hcWisWCMlXPiCtxFuLj6mhMrz2Tlq8OTvF7n3nDrlQFpj6GlJyqQmBvhiZNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsI5WwKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EE8C32782;
	Wed, 26 Jun 2024 18:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719426481;
	bh=lz4BNp2Exc9fBCHQYkJbsU/O6zJopS2cxihAzvadqlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rsI5WwKq0/sqv4WkNMb69+zAT6DSAYqn8iVPxqUdH+XE3ZXGPfGhe2tykwh+wLfGC
	 WdE8rpXBUDqAq5mlvEQ/ssFiCH09f6sPJX6Oh72iSXvGZCW8awXqixfwXm+r8mqM/2
	 FtoUE0CCr6c+t2ZRZaRuZNnaRmMEsjInrCsUkYVqkW5L4GnTaFRLInytBQNf6FBeNp
	 OP6x6sAkpfpuFb/8zrTUS79xONqihNQEkT/EqSOmvItdCAFo6vEhEXyQF53K35VN9K
	 VOD4qgE+qq7vD0sAvZZZZ6U+HGHwr3PDSgT2B0p7lOIg1J5qEnhllYU6l1pGgEaOdZ
	 rnBBEYZ2w/r0w==
From: cel@kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<stable@vger.kernel.org>,
	Yunjian Wang <wangyunjian@huawei.com>
Subject: [PATCH 5.10 1/5] SUNRPC: Fix null pointer dereference in svc_rqst_free()
Date: Wed, 26 Jun 2024 14:27:41 -0400
Message-ID: <20240626182745.288665-2-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240626182745.288665-1-cel@kernel.org>
References: <20240626182745.288665-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunjian Wang <wangyunjian@huawei.com>

[ Upstream commit b9f83ffaa0c096b4c832a43964fe6bff3acffe10 ]

When alloc_pages_node() returns null in svc_rqst_alloc(), the
null rq_scratch_page pointer will be dereferenced when calling
put_page() in svc_rqst_free(). Fix it by adding a null check.

Addresses-Coverity: ("Dereference after null check")
Fixes: 5191955d6fc6 ("SUNRPC: Prepare for xdr_stream-style decoding on the server-side")
Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 26d972c54a59..ac7b3a93d992 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -845,7 +845,8 @@ void
 svc_rqst_free(struct svc_rqst *rqstp)
 {
 	svc_release_buffer(rqstp);
-	put_page(rqstp->rq_scratch_page);
+	if (rqstp->rq_scratch_page)
+		put_page(rqstp->rq_scratch_page);
 	kfree(rqstp->rq_resp);
 	kfree(rqstp->rq_argp);
 	kfree(rqstp->rq_auth_data);
-- 
2.45.1


