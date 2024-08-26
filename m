Return-Path: <linux-nfs+bounces-5718-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038BE95E744
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 05:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332C21C20BF8
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 03:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18862BE6F;
	Mon, 26 Aug 2024 03:22:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83801F5FE
	for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2024 03:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724642523; cv=none; b=mAcTAuE0G/IHx2VcOZ8Rdt/Zp/4XqZZxt6R1VRQdIfR7E4LxYMriWZ9IMVYY6IK1KAsqjjwDGaDIgMbOwzTi4HpFUNGI2W+YIgUW3GjObnGbzJ4UbpNp8EbVotcmqWkQql52TiAte3h9XS0GucZQ0YzeLEu5paskrv78lzucKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724642523; c=relaxed/simple;
	bh=ZcN5sH30cCRPKD8DjTTe2Szofa2kcgMbvhHhMnWVA0A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hJPJCfD1eEPGx1DDUWvhYW4uyfMqoii9AbUCMKTFb00ZxoIj3SkSTg2BcWpdwmoBb4FKeZOk2DDWZwz6pVmByQw1GnEvgKbrYcvNml5GTOy8wm+x6Kl/ugdSRxoN9Dycq7/Z3L7Im4k+OgNbIZ3M5ddvwwzzvr4LZ5M2aD/O7Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WsbSl2xNxz20mfr;
	Mon, 26 Aug 2024 11:17:11 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 36D3C180043;
	Mon, 26 Aug 2024 11:21:58 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 26 Aug 2024 11:21:57 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <cuigaosheng1@huawei.com>
CC: <linux-nfs@vger.kernel.org>
Subject: [PATCH -next] nfs: Remove obsoleted declaration for nfs_read_prepare
Date: Mon, 26 Aug 2024 11:21:57 +0800
Message-ID: <20240826032157.4011241-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200011.china.huawei.com (7.221.188.251)

The nfs_read_prepare() have been removed since
commit a4cdda59111f ("NFS: Create a common pgio_rpc_prepare function"),
and now it is useless, so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 fs/nfs/internal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 5902a9beca1f..b3dc7c84eef9 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -505,7 +505,6 @@ extern int nfs_read_add_folio(struct nfs_pageio_descriptor *pgio,
 			       struct nfs_open_context *ctx,
 			       struct folio *folio);
 extern void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio);
-extern void nfs_read_prepare(struct rpc_task *task, void *calldata);
 extern void nfs_pageio_reset_read_mds(struct nfs_pageio_descriptor *pgio);
 
 /* super.c */
-- 
2.25.1


