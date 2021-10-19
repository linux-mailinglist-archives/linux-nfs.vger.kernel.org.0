Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D20433C9D
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 18:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhJSQpW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Oct 2021 12:45:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhJSQpV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 19 Oct 2021 12:45:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD9D26113B;
        Tue, 19 Oct 2021 16:43:08 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: Fix sparse warning
Date:   Tue, 19 Oct 2021 12:43:07 -0400
Message-Id:  <163466178758.1803.14343498347465572240.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.33.1
User-Agent: StGit/1.3.dev16+g8b8350b
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

/home/cel/src/linux/linux/fs/nfsd/nfs4proc.c:1539:24: warning: incorrect type in assignment (different base types)
/home/cel/src/linux/linux/fs/nfsd/nfs4proc.c:1539:24:    expected restricted __be32 [usertype] status
/home/cel/src/linux/linux/fs/nfsd/nfs4proc.c:1539:24:    got int

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 486c5dba4b65..5bf1a7463039 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1515,7 +1515,7 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
 	u64 bytes_total = copy->cp_count;
 	u64 src_pos = copy->cp_src_pos;
 	u64 dst_pos = copy->cp_dst_pos;
-	__be32 status;
+	int status;
 
 	/* See RFC 7862 p.67: */
 	if (bytes_total == 0)

