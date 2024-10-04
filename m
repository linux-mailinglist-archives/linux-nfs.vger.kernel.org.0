Return-Path: <linux-nfs+bounces-6868-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA272990B85
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Oct 2024 20:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B88282852
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Oct 2024 18:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785B51DF99E;
	Fri,  4 Oct 2024 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+lbm5is"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5CD1DF972;
	Fri,  4 Oct 2024 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065997; cv=none; b=NdfDTQyQSB/8UyWm/9AA3TI4/5/x9UdCd//w8B1g0NnsMZzeRxcOjdg0pIIn+Y3LIZJNUTZDtMc8WNUklCWxexCTAKQyGKkDWeFr4I5yubglRHTR2IDgMgtpc3u1TSV9aTuQlM5ZWh/mhXepQjaSZQgcvXJpYDmVZBN0z101CCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065997; c=relaxed/simple;
	bh=FAY2NJRrlAyMyffVH/SMF9nnrsZbko6LKP7OuYQFIec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vi9laPiu2ktGRaNO91mGUaH8ulXEKbPqBjlHQjxUBZrqmAXM5zzO/FdaYQ7JL6xNQTl1kEVOjjf6/x+YKzdwFZrFD4yJW4xA02+djDaZBi1IMv2Z4vmXI2sm7V8nI90E9tl4/mVMwCkASayGVu7qQNVQCmlzRUm+WbtXmmA9PAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+lbm5is; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B697C4CEC6;
	Fri,  4 Oct 2024 18:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065997;
	bh=FAY2NJRrlAyMyffVH/SMF9nnrsZbko6LKP7OuYQFIec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T+lbm5islUdg3ZARSaYjhnUQ8+lzvw5R1QI3U2dTdtGIUeAYs260qro4FzhMNDVd/
	 0dqnOrG0HJ0m2aNFBxmuVg6Ehafkpp4DRTFKXFGV98BqNCTXMMRJFq2vxLj7Ujr7IN
	 zWb8/nLxMrRENAgGk4yxqp1xMMulaNiHA/Pka/s7YLjXBlSWfN2TzM6ygT5+n0+W+g
	 4WXHGPjlyqdXz6ZJXLa5BtAwbgm7BiLiwv+zenwmNkx3Mw2RfLEz3ZDr65yuanPAlF
	 4p6ehwc4Co9sUPIMq/PhoIKb0fgO2kKIE8wzMWBAL6/3tJ7PSuu1BGaBZlpvy+TTdY
	 OMP3cCalvJQ2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 47/76] fs: nfs: fix missing refcnt by replacing folio_set_private by folio_attach_private
Date: Fri,  4 Oct 2024 14:17:04 -0400
Message-ID: <20241004181828.3669209-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

[ Upstream commit 03e02b94171b1985dd0aa184296fe94425b855a3 ]

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
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/write.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index d074d0ceb4f01..80c6ded5f74c6 100644
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
2.43.0


