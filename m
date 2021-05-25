Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95E139086A
	for <lists+linux-nfs@lfdr.de>; Tue, 25 May 2021 20:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhEYSER (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 May 2021 14:04:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232367AbhEYSEO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 25 May 2021 14:04:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17E19613D8
        for <linux-nfs@vger.kernel.org>; Tue, 25 May 2021 18:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621965764;
        bh=M2IbsbrlnkubofiaIql2tXG4AUGE+T+yiiZ3564q0cA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=s3GQ7XS1odc3GWHT9L5ku9m4FFy1Ymeb0qpIY4fBRckWA3HHhaw3t7QPYqIlx5qHo
         +ZLWgfYBuWbzNqTUBf1LTPbEzasgiuIVd7jPbi1kkWBEurB31Ln+1HWsg5mA/zfGNy
         ZP1i9Uoe+dtI6rGozCHMZRpVdtPWz86u28zPmJrUKJW9rvOK/GEzQK52aQPgDiCyl1
         Qfzdn8dAw/M8o5dhcSA8ut0g15a8TjxKWV2Su/6bxLOj5O2m5O5jeV6mglZ1CemACh
         AQM6ypU9OS6TBMnK4lz+ZbKJuQ2g5cN2nC/8DPVu6CM9JBymG8kDqmKZT0wgWwin7Y
         w6p2KdFi9mmMg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/3] NFS: Clean up reset of the mirror accounting variables
Date:   Tue, 25 May 2021 14:02:41 -0400
Message-Id: <20210525180241.261090-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525180241.261090-2-trondmy@kernel.org>
References: <20210525180241.261090-1-trondmy@kernel.org>
 <20210525180241.261090-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Now that nfs_pageio_do_add_request() resets the pg_count, we don't need
these other inlined resets.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index daf6658517f4..cf9cc62ec48e 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1132,12 +1132,8 @@ static void nfs_pageio_doio(struct nfs_pageio_descriptor *desc)
 		int error = desc->pg_ops->pg_doio(desc);
 		if (error < 0)
 			desc->pg_error = error;
-		if (list_empty(&mirror->pg_list)) {
+		if (list_empty(&mirror->pg_list))
 			mirror->pg_bytes_written += mirror->pg_count;
-			mirror->pg_count = 0;
-			mirror->pg_base = 0;
-			mirror->pg_recoalesce = 0;
-		}
 	}
 }
 
@@ -1227,9 +1223,6 @@ static int nfs_do_recoalesce(struct nfs_pageio_descriptor *desc)
 
 	do {
 		list_splice_init(&mirror->pg_list, &head);
-		mirror->pg_count = 0;
-		mirror->pg_base = 0;
-		mirror->pg_recoalesce = 0;
 
 		while (!list_empty(&head)) {
 			struct nfs_page *req;
-- 
2.31.1

