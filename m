Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0455442E094
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Oct 2021 19:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhJNR5Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Oct 2021 13:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhJNR5Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Oct 2021 13:57:16 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E55FC061570
        for <linux-nfs@vger.kernel.org>; Thu, 14 Oct 2021 10:55:11 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id n12so4212206qvk.3
        for <linux-nfs@vger.kernel.org>; Thu, 14 Oct 2021 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ISmsyCdA8i0HSR3KkV7dEglqd7mksKGIyfOdhCrrGv8=;
        b=WbGJATiBYlVMv0MXKEvDyFxurq/EIrR05ZjoGmBL1P7ncKxARcp8/mUULTmt0SkdBN
         00tnUizMe7m3DtcdtoKGX8PVdrv8glwcXWEyuITJNeE7tvnQsmSkfS94Cqy+YvOiXgIY
         SVTSZMUs4+zpWf2mGAkD4rjA8CZS7M0+qrYEFVXmusEG89QygHFHEY9Ykx/hDPEPPOaQ
         iXWGdTpCaIJCKcCIF8f+BwdJCF5kuQGXu5CUD/5pXyy5fTs0qIg/F71KXMWHPBkQEZIU
         SKaRV/1A/qmmf5hjfbgIUbqESgDpR/EvvbuHktJP4qr6EQ0cqgVznug6R7fA6RZp+X1q
         f1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ISmsyCdA8i0HSR3KkV7dEglqd7mksKGIyfOdhCrrGv8=;
        b=o2SqoZlw4rFQJ6EiCBmiAy0Y+eMrvk22PKWxBpg3eUuQPv/BeezYOZuKHy/0EDhWF4
         POUVXY6OBDASmPb1cc9fEkZ6GRkbH5o0yxRqyV05j1uoSCHo2fIzDsi1Win3cxOVHP13
         ZFQDEWyXoscIUeLuJnJZDXOcjB9A4z8ic9kd4LtjJQ1Y64Plc3drJFace3f2CauXAhoF
         Eh/XCJY/CktFILASwIyaK5VGNGI+Hhl0Ez2+xOe/R7235w56xrjq9sSTsIFsOHyT+Esf
         cbDEd+Z+mNF2ALPyd10veguEBocL7xwBlptcxHdZcMntUM+8TXyVX/L/cb63oWgRRZuh
         Jaiw==
X-Gm-Message-State: AOAM532a6Y1PgzD1CTmXdMasmzkgDG1MtJvEYvxu04Vn3jLGtLmuNk2F
        T2CYIOVjn13cKF4IJDSe6BU=
X-Google-Smtp-Source: ABdhPJyPUNWPCWmXSM8UAmTU6xw5dm80yihGh3fGMlN0RgGvGLnHijg/B54UgfTTl6AnnotrpkCRjQ==
X-Received: by 2002:ad4:476a:: with SMTP id d10mr6913089qvx.20.1634234110400;
        Thu, 14 Oct 2021 10:55:10 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id m6sm1536131qkh.69.2021.10.14.10.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 10:55:10 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 1/5] NFS: Create an nfs4_server_set_init_caps() function
Date:   Thu, 14 Oct 2021 13:55:04 -0400
Message-Id: <20211014175508.197313-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014175508.197313-1-Anna.Schumaker@Netapp.com>
References: <20211014175508.197313-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

And call it before doing an FSINFO probe to reset to the baseline
capabilities before probing.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/internal.h   |  1 +
 fs/nfs/nfs4client.c | 41 +++++++++++++++++++++++------------------
 fs/nfs/nfs4proc.c   |  2 ++
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 7483f196c6ef..690271adb294 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -209,6 +209,7 @@ extern struct nfs_client *
 nfs4_find_client_sessionid(struct net *, const struct sockaddr *,
 				struct nfs4_sessionid *, u32);
 extern struct nfs_server *nfs_create_server(struct fs_context *);
+extern void nfs4_server_set_init_caps(struct nfs_server *);
 extern struct nfs_server *nfs4_create_server(struct fs_context *);
 extern struct nfs_server *nfs4_create_referral_server(struct fs_context *);
 extern int nfs4_update_server(struct nfs_server *server, const char *hostname,
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index af57332503be..3fb0ca92377c 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1059,31 +1059,15 @@ static void nfs4_session_limit_xasize(struct nfs_server *server)
 #endif
 }
 
-static int nfs4_server_common_setup(struct nfs_server *server,
-		struct nfs_fh *mntfh, bool auth_probe)
+void nfs4_server_set_init_caps(struct nfs_server *server)
 {
-	struct nfs_fattr *fattr;
-	int error;
-
-	/* data servers support only a subset of NFSv4.1 */
-	if (is_ds_only_client(server->nfs_client))
-		return -EPROTONOSUPPORT;
-
-	fattr = nfs_alloc_fattr();
-	if (fattr == NULL)
-		return -ENOMEM;
-
-	/* We must ensure the session is initialised first */
-	error = nfs4_init_session(server->nfs_client);
-	if (error < 0)
-		goto out;
-
 	/* Set the basic capabilities */
 	server->caps |= server->nfs_client->cl_mvops->init_caps;
 	if (server->flags & NFS_MOUNT_NORDIRPLUS)
 			server->caps &= ~NFS_CAP_READDIRPLUS;
 	if (server->nfs_client->cl_proto == XPRT_TRANSPORT_RDMA)
 		server->caps &= ~NFS_CAP_READ_PLUS;
+
 	/*
 	 * Don't use NFS uid/gid mapping if we're using AUTH_SYS or lower
 	 * authentication.
@@ -1091,7 +1075,28 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 	if (nfs4_disable_idmapping &&
 			server->client->cl_auth->au_flavor == RPC_AUTH_UNIX)
 		server->caps |= NFS_CAP_UIDGID_NOMAP;
+}
 
+static int nfs4_server_common_setup(struct nfs_server *server,
+		struct nfs_fh *mntfh, bool auth_probe)
+{
+	struct nfs_fattr *fattr;
+	int error;
+
+	/* data servers support only a subset of NFSv4.1 */
+	if (is_ds_only_client(server->nfs_client))
+		return -EPROTONOSUPPORT;
+
+	fattr = nfs_alloc_fattr();
+	if (fattr == NULL)
+		return -ENOMEM;
+
+	/* We must ensure the session is initialised first */
+	error = nfs4_init_session(server->nfs_client);
+	if (error < 0)
+		goto out;
+
+	nfs4_server_set_init_caps(server);
 
 	/* Probe the root fh to retrieve its FSID and filehandle */
 	error = nfs4_get_rootfh(server, mntfh, auth_probe);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index fc0be32b19fc..77bbdced702f 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3923,6 +3923,8 @@ int nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 		.interruptible = true,
 	};
 	int err;
+
+	nfs4_server_set_init_caps(server);
 	do {
 		err = nfs4_handle_exception(server,
 				_nfs4_server_capabilities(server, fhandle),
-- 
2.33.0

