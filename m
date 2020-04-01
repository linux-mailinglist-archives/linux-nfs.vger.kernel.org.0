Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B16F419B613
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2020 20:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgDAS7B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Apr 2020 14:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgDAS7B (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 1 Apr 2020 14:59:01 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C875820784
        for <linux-nfs@vger.kernel.org>; Wed,  1 Apr 2020 18:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585767541;
        bh=12kGjrSqRzVmjt4qwLOmKH42IBHqc6DHTELc8v4z87Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tctzTY9HBWb5ulEfKrH55WhYIysdqB4Rv4brNUoQUjpnZ37A34ROnjoWniqzjD8XF
         t4qwko0/RzsTJBZ45XC/y4pOhtubXsioor38pAifvbN+cY6+6rpztGmV7Qy6TaKf19
         sz4jMHCtGf7enXkWDHMpimqMkCo1XgQWBOjhrAUo=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 01/10] NFS: Fix a page leak in nfs_destroy_unlinked_subrequests()
Date:   Wed,  1 Apr 2020 14:56:43 -0400
Message-Id: <20200401185652.1904777-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401185652.1904777-1-trondmy@kernel.org>
References: <20200401185652.1904777-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When we detach a subrequest from the list, we must also release the
reference it holds to the parent.

Fixes: 5b2b5187fa85 ("NFS: Fix nfs_page_group_destroy() and nfs_lock_and_join_requests() race cases")
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 03b7f64f7c4f..626e99cbb50e 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -444,6 +444,7 @@ nfs_destroy_unlinked_subrequests(struct nfs_page *destroy_list,
 		}
 
 		subreq->wb_head = subreq;
+		nfs_release_request(old_head);
 
 		if (test_and_clear_bit(PG_INODE_REF, &subreq->wb_flags)) {
 			nfs_release_request(subreq);
-- 
2.25.1

