Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1312341152
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Mar 2021 01:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhCSAEB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Mar 2021 20:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhCSAD2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Mar 2021 20:03:28 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917F0C06175F
        for <linux-nfs@vger.kernel.org>; Thu, 18 Mar 2021 17:03:27 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 10A29A6F; Thu, 18 Mar 2021 20:03:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 10A29A6F
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 2/2] nfsd: COPY with length 0 should copy to end of file
Date:   Thu, 18 Mar 2021 20:03:23 -0400
Message-Id: <1616112203-14672-2-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1616112203-14672-1-git-send-email-bfields@redhat.com>
References: <1616112203-14672-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

From https://tools.ietf.org/html/rfc7862#page-65

	A count of 0 (zero) requests that all bytes from ca_src_offset
	through EOF be copied to the destination.

Reported-by: <radchenkoy@gmail.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4proc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5419342df360..62354229f0b0 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1387,6 +1387,9 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
 	u64 src_pos = copy->cp_src_pos;
 	u64 dst_pos = copy->cp_dst_pos;
 
+	/* See RFC 7862 p.67: */
+	if (bytes_total == 0)
+		bytes_total = ULLONG_MAX;
 	do {
 		if (kthread_should_stop())
 			break;
-- 
2.30.2

