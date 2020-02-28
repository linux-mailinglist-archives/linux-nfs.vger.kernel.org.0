Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E05B1737F6
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 14:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgB1NJi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Feb 2020 08:09:38 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34597 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgB1NJh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Feb 2020 08:09:37 -0500
Received: by mail-yw1-f65.google.com with SMTP id b186so3236743ywc.1
        for <linux-nfs@vger.kernel.org>; Fri, 28 Feb 2020 05:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=R6+NgKOvGU7WnxAOSrWHkptT277VM35k/++AgcgpjME=;
        b=ejGqG8qu+KFADf9DvCM5VGMqrq18yE3cNed8IlmPuXO6iu3xbs615NM+K3aqb1Nga5
         dR2YJPOjfRlL2vi3IOTl0FqV3Cjh2Pb3TdBnU9nAOajsJLaRqo9XONlcFyCqp53d3uXK
         RtsyrlVoFLBLfuvZtUc8IvR4iZK90FEHNQ7khYHOnI9m+yrO30Mt6ZSNVbGeZfJsrcSD
         aXnIS+wTWLo8sxr9bUML3jNkEiFtXiHWHLGDWqUigr5pk+2xpM0QkxFhC9ZnM6z1OgIz
         zyE5W+js+BD7aYHEsdqwVo0ZbvTmH3ZcEdlYwFxs0R7l7SP1dL3f5h3/24//c6Ei5KM5
         o5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R6+NgKOvGU7WnxAOSrWHkptT277VM35k/++AgcgpjME=;
        b=maC2sqsA7d/OpyECUnK6+gGi+t19zEq4GAtFs9st5w2V0M8aMHwJmtYm3kVpCV4W4k
         lN2EgZm1W+Tl40vsYF4KHV1deTNXLQ48JsnwQhZx3vap3e0an76nbrAytF7cbDc0TUCW
         jbYnTFM3u0RhOfeke8Jle+ekFWAOWPo0xxSYUWNw6yhHwm2HSHTQIQcrT3aHdS6UsnV4
         6lH0CLEF/Dm6VaaUDm646yUglkxzTdc+BJRXfL+8IJFYe55LGTA0+F97sxQujCnysvCr
         SZ+D8ked1IYKogHTqjeBqOJic9NkLY0i9G0JkGivJueaSgImvT6sKat7QE2bNi5KPEoQ
         eEUw==
X-Gm-Message-State: APjAAAUuB6GWVsr34TZReP+iHpDvEV+p2Vnu4RHrCn665pqgmGAJccJI
        NNZAZ7OnOtfD3LkJNFqap9D2Gt6aeA==
X-Google-Smtp-Source: APXvYqz/CfVZZcrv8h1cNqp9JMyxDiY547TLziXNNGjiC314CuGuJLfCuy2UwGABE58sUSQQ+0pZIw==
X-Received: by 2002:a25:694c:: with SMTP id e73mr268710ybc.198.1582895376267;
        Fri, 28 Feb 2020 05:09:36 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id j23sm3925150ywb.93.2020.02.28.05.09.35
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 05:09:35 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/7] NFS: Add a helper nfs_client_for_each_server()
Date:   Fri, 28 Feb 2020 08:07:21 -0500
Message-Id: <20200228130725.1330705-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200228130725.1330705-2-trond.myklebust@hammerspace.com>
References: <20200228130725.1330705-1-trond.myklebust@hammerspace.com>
 <20200228130725.1330705-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a helper nfs_client_for_each_server() to iterate through all the
filesystems that are attached to a struct nfs_client, and apply
a function to all the active ones.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/internal.h |  4 +++-
 fs/nfs/super.c    | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index f80c47d5ff27..3b6fa9edc9b5 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -417,7 +417,9 @@ extern int __init register_nfs_fs(void);
 extern void __exit unregister_nfs_fs(void);
 extern bool nfs_sb_active(struct super_block *sb);
 extern void nfs_sb_deactive(struct super_block *sb);
-
+extern int nfs_client_for_each_server(struct nfs_client *clp,
+				      int (*fn)(struct nfs_server *, void *),
+				      void *data);
 /* io.c */
 extern void nfs_start_io_read(struct inode *inode);
 extern void nfs_end_io_read(struct inode *inode);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index dada09b391c6..eb3a85492396 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -176,6 +176,41 @@ void nfs_sb_deactive(struct super_block *sb)
 }
 EXPORT_SYMBOL_GPL(nfs_sb_deactive);
 
+static int __nfs_list_for_each_server(struct list_head *head,
+		int (*fn)(struct nfs_server *, void *),
+		void *data)
+{
+	struct nfs_server *server, *last = NULL;
+	int ret = 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(server, head, client_link) {
+		if (!nfs_sb_active(server->super))
+			continue;
+		rcu_read_unlock();
+		if (last)
+			nfs_sb_deactive(last->super);
+		last = server;
+		ret = fn(server, data);
+		if (ret)
+			goto out;
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
+out:
+	if (last)
+		nfs_sb_deactive(last->super);
+	return ret;
+}
+
+int nfs_client_for_each_server(struct nfs_client *clp,
+		int (*fn)(struct nfs_server *, void *),
+		void *data)
+{
+	return __nfs_list_for_each_server(&clp->cl_superblocks, fn, data);
+}
+EXPORT_SYMBOL_GPL(nfs_client_for_each_server);
+
 /*
  * Deliver file system statistics to userspace
  */
-- 
2.24.1

