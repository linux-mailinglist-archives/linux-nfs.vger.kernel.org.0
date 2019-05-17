Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 931C321F57
	for <lists+linux-nfs@lfdr.de>; Fri, 17 May 2019 23:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfEQVGn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 May 2019 17:06:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729101AbfEQVGm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 17 May 2019 17:06:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3E42C05FF80
        for <linux-nfs@vger.kernel.org>; Fri, 17 May 2019 21:06:42 +0000 (UTC)
Received: from dwysocha.rdu.csb (dhcp-12-212-173.gsslab.rdu.redhat.com [10.12.212.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF41459D0A
        for <linux-nfs@vger.kernel.org>; Fri, 17 May 2019 21:06:42 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: Add lease_time and lease_expired to 'nfs4:' line of mountstats
Date:   Fri, 17 May 2019 17:06:41 -0400
Message-Id: <1558127201-7481-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 17 May 2019 21:06:42 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On the NFS client there is no low-impact way to determine the nfs4
lease time or whether the lease is expired, so add these to mountstats
with times displayed in seconds.

If the lease is not expired, display lease_expired=0. Otherwise,
display lease_expired=seconds_since_expired, similar to 'age:' line
in mountstats.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/super.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index c27ac96..6e52f0c 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -730,6 +730,16 @@ int nfs_show_options(struct seq_file *m, struct dentry *root)
 EXPORT_SYMBOL_GPL(nfs_show_options);
 
 #if IS_ENABLED(CONFIG_NFS_V4)
+static void show_lease(struct seq_file *m, struct nfs_server *server)
+{
+	struct nfs_client *clp = server->nfs_client;
+	unsigned long expire;
+
+	seq_printf(m, ",lease_time=%ld", clp->cl_lease_time / HZ);
+	expire = clp->cl_last_renewal + clp->cl_lease_time;
+	seq_printf(m, ",lease_expired=%ld",
+		   time_after(expire, jiffies) ?  0 : (jiffies - expire) / HZ);
+}
 #ifdef CONFIG_NFS_V4_1
 static void show_sessions(struct seq_file *m, struct nfs_server *server)
 {
@@ -838,6 +848,7 @@ int nfs_show_stats(struct seq_file *m, struct dentry *root)
 		seq_printf(m, ",acl=0x%x", nfss->acl_bitmask);
 		show_sessions(m, nfss);
 		show_pnfs(m, nfss);
+		show_lease(m, nfss);
 	}
 #endif
 
-- 
1.8.3.1

