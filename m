Return-Path: <linux-nfs+bounces-5791-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBA795FF33
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 04:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD66D1F22A53
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 02:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592F210A3E;
	Tue, 27 Aug 2024 02:37:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62880168B8;
	Tue, 27 Aug 2024 02:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724726248; cv=none; b=QDscaMMaTMb6CIRpZI7A1NEyFgoi/XEy2odmdiB2lDmpXVfr7cuzDPwDSkLx+H7Gc88t21zGqeGj8xsqVB6b/b0ekiBuB2hIGLUPqeFDX30ORKiTlBzLN6XlAOLMfabbFFrMQqvEd4iY3NNH4WY8+lf7sAcNgAXx7eVotNOwqZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724726248; c=relaxed/simple;
	bh=o7iOFPoc5qroOwbFmazuypcbwp9gMnZ5ylIiTtTRAec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AD3NFk2YAKoUnwRX4m7fBpNe1TyP1NuNAZ8k6tEDghq/zAJydtjx+vnMvntItLRnbLTBf0EBvGjfvlI0PrEbusXtw1LkAuvYArRfJcoB026Fc08VOLB+KfT76O/YFog34W0xsxpveKOaIax9Fjlq00EvFLGgO8haYti8y1Kg3Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WtBQq36KNzQqp3;
	Tue, 27 Aug 2024 10:32:35 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id BA79A140137;
	Tue, 27 Aug 2024 10:37:23 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 10:37:23 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <akpm@linux-foundation.org>,
	<trondmy@kernel.org>, <anna@kernel.org>, <gregkh@linuxfoundation.org>
CC: <linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-nfs@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next v3 3/3] nfs make use of str_false_true helper
Date: Tue, 27 Aug 2024 10:45:17 +0800
Message-ID: <20240827024517.914100-4-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827024517.914100-1-lihongbo22@huawei.com>
References: <20240827024517.914100-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)

The helper str_false_true is introduced to reback "false/true"
string literal. We can simplify this format by str_false_true.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/nfs/nfs4xdr.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 7704a4509676..61190d6a5a77 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -3447,7 +3447,7 @@ static int decode_attr_link_support(struct xdr_stream *xdr, uint32_t *bitmap, ui
 		*res = be32_to_cpup(p);
 		bitmap[0] &= ~FATTR4_WORD0_LINK_SUPPORT;
 	}
-	dprintk("%s: link support=%s\n", __func__, *res == 0 ? "false" : "true");
+	dprintk("%s: link support=%s\n", __func__, str_false_true(*res == 0));
 	return 0;
 }
 
@@ -3465,7 +3465,7 @@ static int decode_attr_symlink_support(struct xdr_stream *xdr, uint32_t *bitmap,
 		*res = be32_to_cpup(p);
 		bitmap[0] &= ~FATTR4_WORD0_SYMLINK_SUPPORT;
 	}
-	dprintk("%s: symlink support=%s\n", __func__, *res == 0 ? "false" : "true");
+	dprintk("%s: symlink support=%s\n", __func__, str_false_true(*res == 0));
 	return 0;
 }
 
@@ -3607,7 +3607,7 @@ static int decode_attr_case_insensitive(struct xdr_stream *xdr, uint32_t *bitmap
 		*res = be32_to_cpup(p);
 		bitmap[0] &= ~FATTR4_WORD0_CASE_INSENSITIVE;
 	}
-	dprintk("%s: case_insensitive=%s\n", __func__, *res == 0 ? "false" : "true");
+	dprintk("%s: case_insensitive=%s\n", __func__, str_false_true(*res == 0));
 	return 0;
 }
 
@@ -3625,7 +3625,7 @@ static int decode_attr_case_preserving(struct xdr_stream *xdr, uint32_t *bitmap,
 		*res = be32_to_cpup(p);
 		bitmap[0] &= ~FATTR4_WORD0_CASE_PRESERVING;
 	}
-	dprintk("%s: case_preserving=%s\n", __func__, *res == 0 ? "false" : "true");
+	dprintk("%s: case_preserving=%s\n", __func__, str_false_true(*res == 0));
 	return 0;
 }
 
@@ -4333,8 +4333,7 @@ static int decode_attr_xattrsupport(struct xdr_stream *xdr, uint32_t *bitmap,
 		*res = be32_to_cpup(p);
 		bitmap[2] &= ~FATTR4_WORD2_XATTR_SUPPORT;
 	}
-	dprintk("%s: XATTR support=%s\n", __func__,
-		*res == 0 ? "false" : "true");
+	dprintk("%s: XATTR support=%s\n", __func__, str_false_true(*res == 0));
 	return 0;
 }
 
-- 
2.34.1


