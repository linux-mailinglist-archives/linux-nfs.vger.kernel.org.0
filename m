Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE00F3D544
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 20:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406921AbfFKSMC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 14:12:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36200 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406685AbfFKSMC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 14:12:02 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so10720696ioh.3
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jun 2019 11:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YJLD8pEsKbKgJy30zP2LAtajfM+mMiPdYAfw6ctSvAU=;
        b=HtOMHpCm+eke4h2xs+WpRbfk+R9swPSDpjIZsmkksBVE8skw5JsG1m252MoJdDq3Gs
         O+qMzpN83ZqO68fhZ5ecxaE5+PuPUBanZQcka+z2wXul4VCdpPEZzPSjybW+MWcBlW0/
         H70KR7iRppgssE5DmaZr7N2H1S186B3ieY8q5GXQStMDaRg6GROIbTTiiiQWQW78XkNR
         6/GJju+5M8DyGWCYpjbwE+7cTF0sl68z2W2kZWbczzY8IJEBGIHSRMi7EZpaN39h4RWo
         OyOQNoyGR82a9OpUhJrPEOGuWqmhKxjzzl1ZsW3qoVaei1LyJ6NgJcI+4peM6J2hM4ty
         HaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJLD8pEsKbKgJy30zP2LAtajfM+mMiPdYAfw6ctSvAU=;
        b=GT5jLt5UBFQsHzmeqV5nsnpfkeqsPjwlCIZ+hIdDNC7qF5nbbVe5Zdd0fSXLi3Q9IA
         msIRaOHrCRQGFK6slH8lSNba0/039onPmQmveS3mfUUcjTUECpNDhoq+DUsjUDwdAEvI
         72YN/xFEYIYeiVwz6prZGdb7/2eSkEUCSnihcD3SsIF9b0U4H9EYrUm82MWr85QPcRgW
         qMuuPbLqCz2yousQWdC78Ct9zPgMO7BK4qDWFnWHhCk/rRTR77N2lGQs31G6HYis6r4M
         mfR0N9IHs0faKKTSO7ox4PqtHlJAJZKMDYMgflLIzd0PFknwT7LXpo0+Pgpz/dXa1B11
         GslA==
X-Gm-Message-State: APjAAAUdXLaGMUjsTu60N0p1ltm176dyysd5pUzJ8oPctvE7rszGOYFP
        KvUdSNWRH7WrN1jEM/5b20jFZ5k=
X-Google-Smtp-Source: APXvYqwPQ2f7uUrG7d0Ru70vuMo02okx9xvyLenWS+at7UQgC9DUXO6/1bRUZjofsh9FxkK3fcyU0Q==
X-Received: by 2002:a5e:890f:: with SMTP id k15mr20772824ioj.121.1560276720756;
        Tue, 11 Jun 2019 11:12:00 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id f4sm4900212iok.56.2019.06.11.11.12.00
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 11:12:00 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFS: Cleanup - add nfs_clients_exit to mirror nfs_clients_init
Date:   Tue, 11 Jun 2019 14:08:31 -0400
Message-Id: <20190611180832.119488-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611180832.119488-2-trond.myklebust@hammerspace.com>
References: <20190611180832.119488-1-trond.myklebust@hammerspace.com>
 <20190611180832.119488-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a helper to clean up the struct nfs_net when it is being destroyed.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/client.c   | 13 +++++++++++--
 fs/nfs/inode.c    |  6 +-----
 fs/nfs/internal.h |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index d7e4f0848e28..0acb104f7b00 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -192,7 +192,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 EXPORT_SYMBOL_GPL(nfs_alloc_client);
 
 #if IS_ENABLED(CONFIG_NFS_V4)
-void nfs_cleanup_cb_ident_idr(struct net *net)
+static void nfs_cleanup_cb_ident_idr(struct net *net)
 {
 	struct nfs_net *nn = net_generic(net, nfs_net_id);
 
@@ -214,7 +214,7 @@ static void pnfs_init_server(struct nfs_server *server)
 }
 
 #else
-void nfs_cleanup_cb_ident_idr(struct net *net)
+static void nfs_cleanup_cb_ident_idr(struct net *net)
 {
 }
 
@@ -1074,6 +1074,15 @@ void nfs_clients_init(struct net *net)
 	nn->boot_time = ktime_get_real();
 }
 
+void nfs_clients_exit(struct net *net)
+{
+	struct nfs_net *nn = net_generic(net, nfs_net_id);
+
+	nfs_cleanup_cb_ident_idr(net);
+	WARN_ON_ONCE(!list_empty(&nn->nfs_client_list));
+	WARN_ON_ONCE(!list_empty(&nn->nfs_volume_list));
+}
+
 #ifdef CONFIG_PROC_FS
 static void *nfs_server_list_start(struct seq_file *p, loff_t *pos);
 static void *nfs_server_list_next(struct seq_file *p, void *v, loff_t *pos);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 60b9e14a0309..dab410f3f5db 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2160,12 +2160,8 @@ static int nfs_net_init(struct net *net)
 
 static void nfs_net_exit(struct net *net)
 {
-	struct nfs_net *nn = net_generic(net, nfs_net_id);
-
 	nfs_fs_proc_net_exit(net);
-	nfs_cleanup_cb_ident_idr(net);
-	WARN_ON_ONCE(!list_empty(&nn->nfs_client_list));
-	WARN_ON_ONCE(!list_empty(&nn->nfs_volume_list));
+	nfs_clients_exit(net);
 }
 
 static struct pernet_operations nfs_net_ops = {
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 498fab72f70b..9e87265907b8 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -158,6 +158,7 @@ extern void nfs_umount(const struct nfs_mount_request *info);
 /* client.c */
 extern const struct rpc_program nfs_program;
 extern void nfs_clients_init(struct net *net);
+extern void nfs_clients_exit(struct net *net);
 extern struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *);
 int nfs_create_rpc_client(struct nfs_client *, const struct nfs_client_initdata *, rpc_authflavor_t);
 struct nfs_client *nfs_get_client(const struct nfs_client_initdata *);
@@ -170,7 +171,6 @@ int nfs_init_server_rpcclient(struct nfs_server *, const struct rpc_timeout *t,
 struct nfs_server *nfs_alloc_server(void);
 void nfs_server_copy_userdata(struct nfs_server *, struct nfs_server *);
 
-extern void nfs_cleanup_cb_ident_idr(struct net *);
 extern void nfs_put_client(struct nfs_client *);
 extern void nfs_free_client(struct nfs_client *);
 extern struct nfs_client *nfs4_find_client_ident(struct net *, int);
-- 
2.21.0

