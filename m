Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945DA380A65
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 15:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhENNcA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 09:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56776 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230285AbhENNb7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 09:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620999048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=YG0mHgnCp9B4knsEgNvJSp6BZu2jnEIblQkEXOrVEYI=;
        b=JjI5Vr1jgONyW8Jchlh1faurQgj9IbrO1y6ECd7ivUl3CzJRDvDjBWY1/hSPf3xVJLOtgs
        rmqL+IcN5PnKVJMVtMItjRY6xjETK3tcNqIEIlOaqXLw1UKHq69ThfDE5Fez1Nx3aOOjp9
        v6JF/deFU2FV5fam+pTvcd/mEECPXWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-7m9n8ZkKOMKCyvbm5T-w-w-1; Fri, 14 May 2021 09:30:46 -0400
X-MC-Unique: 7m9n8ZkKOMKCyvbm5T-w-w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81BC091270;
        Fri, 14 May 2021 13:30:44 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0575360CC6;
        Fri, 14 May 2021 13:30:43 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] nfsd4: Expose the callback address and state of each NFS4 client
Date:   Fri, 14 May 2021 09:30:41 -0400
Message-Id: <1620999041-9341-2-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1620999041-9341-1-git-send-email-dwysocha@redhat.com>
References: <1620999041-9341-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In addition to the client's address, display the callback channel
state and address in the 'info' file.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfsd/nfs4state.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 49c052243b5c..89a7cada334d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2357,6 +2357,21 @@ static void seq_quote_mem(struct seq_file *m, char *data, int len)
 	seq_printf(m, "\"");
 }
 
+static const char *cb_state_str(int state)
+{
+	switch (state) {
+		case NFSD4_CB_UP:
+			return "UP";
+		case NFSD4_CB_UNKNOWN:
+			return "UNKNOWN";
+		case NFSD4_CB_DOWN:
+			return "DOWN";
+		case NFSD4_CB_FAULT:
+			return "FAULT";
+	}
+	return "UNDEFINED";
+}
+
 static int client_info_show(struct seq_file *m, void *v)
 {
 	struct inode *inode = m->private;
@@ -2385,6 +2400,8 @@ static int client_info_show(struct seq_file *m, void *v)
 		seq_printf(m, "\nImplementation time: [%lld, %ld]\n",
 			clp->cl_nii_time.tv_sec, clp->cl_nii_time.tv_nsec);
 	}
+	seq_printf(m, "callback state: %s\n", cb_state_str(clp->cl_cb_state));
+	seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
 	drop_client(clp);
 
 	return 0;
-- 
1.8.3.1

