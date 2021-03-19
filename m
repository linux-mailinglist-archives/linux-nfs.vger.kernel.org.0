Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D44F341151
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Mar 2021 01:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhCSAEC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Mar 2021 20:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhCSAD2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Mar 2021 20:03:28 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51059C06174A
        for <linux-nfs@vger.kernel.org>; Thu, 18 Mar 2021 17:03:27 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 063AC1F78; Thu, 18 Mar 2021 20:03:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 063AC1F78
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 1/2] nfsd: don't ignore high bits of copy count
Date:   Thu, 18 Mar 2021 20:03:22 -0400
Message-Id: <1616112203-14672-1-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Note size_t is 32-bit on a 32-bit architecture, but cp_count is defined
by the protocol to be 64 bit, so we could be turning a large copy into a
0-length copy here.

Reported-by: <radchenkoy@gmail.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b749033e467f..5419342df360 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1383,7 +1383,7 @@ static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
 static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
 {
 	ssize_t bytes_copied = 0;
-	size_t bytes_total = copy->cp_count;
+	u64 bytes_total = copy->cp_count;
 	u64 src_pos = copy->cp_src_pos;
 	u64 dst_pos = copy->cp_dst_pos;
 
-- 
2.30.2

