Return-Path: <linux-nfs+bounces-5848-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9932962115
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 09:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901BB1F23C9A
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 07:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22385158552;
	Wed, 28 Aug 2024 07:29:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBC7156230;
	Wed, 28 Aug 2024 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830198; cv=none; b=H79jQieRvFiJSMsHs+Tl24aNRU4emh0Ymd6MHXlYg04rGvUGJyCOyaCI4JLOoERDWva2iwWqkzsa6zbw5UT6GOvAyNhDU8GxSl2MmIhprtXqVLOSA6zaFf7t8FP+4i8C1dOxweJyeY9oIQvJB5GSMO0Iz5p9Q77hNssfKefY5S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830198; c=relaxed/simple;
	bh=lNHZNg/uyGVCYkoxTd0zuEgsyfWl2zmZoGRswPA4GCI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KGrieykgDdCJ8ZQTo7QvaxQ1niRH9rxLx85nk8lo6HVJTTynM1Gue+TY36qGxPuC64tKFPiqJ47HfwIomQhYGG7Qa/53HL4ULgQEiePdrgM9bByOpOyXiB1c2MzCDz4727Nh12s8nU85zjTLkz7DbSn/oaSFsUDf5zEYe88n5T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 47S7TnbT072959;
	Wed, 28 Aug 2024 15:29:49 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 47S7TAFF069847;
	Wed, 28 Aug 2024 15:29:10 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Wtwpk1RcLz2K6mqQ;
	Wed, 28 Aug 2024 15:22:22 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 28 Aug 2024 15:29:08 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [RFC PATCH 1/1] fs: nfs: replace folio_set_private by folio_attach_private
Date: Wed, 28 Aug 2024 15:29:01 +0800
Message-ID: <20240828072901.1017792-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 47S7TAFF069847

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

This patch is inspired by a code review of fs codes which aims at
folio's extra refcnt that could introduce unwanted behavious when
judging refcnt, such as[1]. The change relys on the policy as the
LRU page with private data should take one corresponding refcnt.

[1]
long mapping_evict_folio(struct address_space *mapping, struct folio *folio)
{
...
//current code will misjudge here if there is one pte on the folio which
is be deemed as the one as folio's private
        if (folio_ref_count(folio) >
                        folio_nr_pages(folio) + folio_has_private(folio) + 1)
                return 0;
        if (!filemap_release_folio(folio, 0))
                return 0;

        return remove_mapping(mapping, folio);
}

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 fs/nfs/write.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index d074d0ceb4f0..80c6ded5f74c 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -772,8 +772,7 @@ static void nfs_inode_add_request(struct nfs_page *req)
 	nfs_lock_request(req);
 	spin_lock(&mapping->i_private_lock);
 	set_bit(PG_MAPPED, &req->wb_flags);
-	folio_set_private(folio);
-	folio->private = req;
+	folio_attach_private(folio, req);
 	spin_unlock(&mapping->i_private_lock);
 	atomic_long_inc(&nfsi->nrequests);
 	/* this a head request for a page group - mark it as having an
@@ -797,8 +796,7 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 
 		spin_lock(&mapping->i_private_lock);
 		if (likely(folio)) {
-			folio->private = NULL;
-			folio_clear_private(folio);
+			folio_detach_private(folio);
 			clear_bit(PG_MAPPED, &req->wb_head->wb_flags);
 		}
 		spin_unlock(&mapping->i_private_lock);
-- 
2.25.1


