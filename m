Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D55364666
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Apr 2021 16:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbhDSOsc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Apr 2021 10:48:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240158AbhDSOsc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Apr 2021 10:48:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA59F61245
        for <linux-nfs@vger.kernel.org>; Mon, 19 Apr 2021 14:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618843682;
        bh=pvb/THyD1+647NAO7H2Hx6b2RD1W8HE3vmnp13DWcWQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PMAzGPejnrEhm91N7x4tQdCuBE9FQbsIQmrDsg+2T0rQX437INsR7xhBoxjuvih45
         lrxkUqVwE2qUZKfgWYTyvcX4OxVA7RSa09pTPaeNu2zX6chevCl91wQuEcE/3mCaUw
         xl9Nsain8Qjr0fB1czNJ1DeNv8F7DYb8G7lq4yDx1ynVzWiiHn1iOjFusTOELo+zfY
         bWoHsoSz0f9Z5TqYi6hqpJ2wcB/1C6nt5ANklsn/aAjIT+NlpvxdZOt8YclarJsO1t
         ULlDsFDfYZWB6/bt2/5qblaWWViPLz9IZuqULUkFnrsjSdCtk1fq0ENw1j+VeMpc+k
         lmmtgiQvsbC1g==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/4] NFSv4: Don't discard segments marked for return in _pnfs_return_layout()
Date:   Mon, 19 Apr 2021 10:47:58 -0400
Message-Id: <20210419144759.41900-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210419144759.41900-2-trondmy@kernel.org>
References: <20210419144759.41900-1-trondmy@kernel.org>
 <20210419144759.41900-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the pNFS layout segment is marked with the NFS_LSEG_LAYOUTRETURN
flag, then the assumption is that it has some reporting requirement
to perform through a layoutreturn (e.g. flexfiles layout stats or error
information).

Fixes: 6d597e175012 ("pnfs: only tear down lsegs that precede seqid in LAYOUTRETURN args")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 33574f47601f..f726f8b12b7e 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1344,7 +1344,7 @@ _pnfs_return_layout(struct inode *ino)
 	}
 	valid_layout = pnfs_layout_is_valid(lo);
 	pnfs_clear_layoutcommit(ino, &tmp_list);
-	pnfs_mark_matching_lsegs_invalid(lo, &tmp_list, NULL, 0);
+	pnfs_mark_matching_lsegs_return(lo, &tmp_list, NULL, 0);
 
 	if (NFS_SERVER(ino)->pnfs_curr_ld->return_range) {
 		struct pnfs_layout_range range = {
-- 
2.31.1

