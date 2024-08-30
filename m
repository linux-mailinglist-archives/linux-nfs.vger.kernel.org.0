Return-Path: <linux-nfs+bounces-6030-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E18299655A7
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 05:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98224283C5B
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 03:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F9113A242;
	Fri, 30 Aug 2024 03:28:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B4535DC;
	Fri, 30 Aug 2024 03:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724988535; cv=none; b=q5RoPogxFR5PUqr8xqztQ2AQgIW27fJz4BOT3ZupfE3rcOI7BY+eRKMXNQjX/OdfIvu74+S5M84BRFtmEQj0F7jGo1nulOZy3BV9ynnua+2+OPOzdp8CiZklH9WeHLXiYUBdU/WqjbYA2WAMp1yA2PqouQo2QQrReq/L5Pf3FPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724988535; c=relaxed/simple;
	bh=SbejTAQA0QmyRdM6RuyQGFhUpnU20lwKrS+Vt6qX0NY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P3IgNihGsrAsmPXemGKT8zOd4evjhAmziciPNRCPtkF+nNmJSw3MbBD14rGYxdxtnaMMO0X9tmm7+ueHgWp/XVzx3LhztNBmit8dG70qNdVdzeHhnWLWSNHUEJD+HDFaf5xQg5YMA2wP/B5VMHFVpoNWLiFg2XCqpQD+Sr5V4UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 47U3Rvq7092001;
	Fri, 30 Aug 2024 11:27:57 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Ww3MP1zTdz2P8CWm;
	Fri, 30 Aug 2024 11:21:05 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 30 Aug 2024 11:27:55 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, <linux-nfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH 1/1] fs: nfs: fix missing refcnt by replacing folio_set_private by folio_attach_private
Date: Fri, 30 Aug 2024 11:27:47 +0800
Message-ID: <20240830032747.1082484-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 47U3Rvq7092001

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

This patch is inspired by a code review of fs codes which aims at
folio's extra refcnt that could introduce unwanted behavious when
judging refcnt, such as[1].That is, the folio passed to
mapping_evict_folio carries the refcnts from find_lock_entries,
page_cache, corresponding to PTEs and folio's private if has. However,
current code doesn't take the refcnt for folio's private which could
have mapping_evict_folio miss the one to only PTE and lead to
call filemap_release_folio wrongly.

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


