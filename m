Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31B542E096
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Oct 2021 19:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhJNR5S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Oct 2021 13:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbhJNR5R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Oct 2021 13:57:17 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA59C061753
        for <linux-nfs@vger.kernel.org>; Thu, 14 Oct 2021 10:55:12 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id p4so6238413qki.3
        for <linux-nfs@vger.kernel.org>; Thu, 14 Oct 2021 10:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j28KvjFQKnh8F2mr0scE3JBhKS0v4PXIXSytFkREKq8=;
        b=ia70gp6Zyepoih3SSqShgVuffb+gIBs6rwpZ7oXJVbwmrjlaULsXr4rxt4YkiTZOhs
         qfreRKYIJV5KfA4gWQUooHmxMmOZfz+0uNcHTLfTJIw3PI16DftNu4SKhrVuB6um36t7
         ZO7g89B1ZPanQSGA30BCGdXTGfXEOsbL3rIyCnEGenPTUbSwXExNkLr11OuHPhlTBn9Q
         16H9PHfilCk25Cd8pFtNLpvjJhgGyQGJyNRMp7CpuIrB1UcIIvVh3N9RQCLThuictCFW
         AD4v2m9mSMwv2gaoDjTWOGmRBACmTf1JfrZv3/xeKA1JejDwiTjuweW50vJkG5D+r8M/
         Czbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=j28KvjFQKnh8F2mr0scE3JBhKS0v4PXIXSytFkREKq8=;
        b=npdUAm+5MG9/2u6UFrl+riyMiYK/GYXLh6gL7aYZDLozq90wakuqb77fSH1GxxaC2q
         T3k20y9T+ndi0RQnCyBVpdQsEgVmN2DAcs7sXfob3AY+VNDYFS+s3cL7r/lghUaREpPW
         tNFbVnD53AXxCrHTAG9SNwI1dfuzhLFbEXDSIlSj96pfYSJAZaF/or/yy+Zh6zaZ5jc/
         rubvVwMtxRTj31RjjjH8aGvo3dSU6Oc+2arLuQ3kZFlKLrNB90fTSP3wAS0O9Hsv4qhZ
         hnC4wpYlWv18OMQY/J2/tcrI0AmyN8MWQ0mjdMBu/MubceY7yxm5hh6ztrcIs83+Xfl8
         E/0Q==
X-Gm-Message-State: AOAM533ZKuhstClb7GpT/X2rTwpb8TPNn9v/x5l7GiP8K4kzVYFciEcY
        dJxUNKINhBhUd3JJxLJF2ZfR/2jMR4k=
X-Google-Smtp-Source: ABdhPJziuAgVPoORB7N6YlDAx0CwWjoyf9zEUy5vM5WS2wjt/5cGNzkWDKvgs0PR9Foy/3Ges4NA6Q==
X-Received: by 2002:ae9:d8c6:: with SMTP id u189mr6221288qkf.391.1634234111613;
        Thu, 14 Oct 2021 10:55:11 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id m6sm1536131qkh.69.2021.10.14.10.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 10:55:11 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 3/5] NFS: Replace calls to nfs_probe_fsinfo() with nfs_probe_server()
Date:   Thu, 14 Oct 2021 13:55:06 -0400
Message-Id: <20211014175508.197313-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014175508.197313-1-Anna.Schumaker@Netapp.com>
References: <20211014175508.197313-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Clean up. There are a few places where we want to probe the server, but
don't actually care about the fsinfo result. Change these to use
nfs_probe_server(), which handles the fattr allocation for us.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/client.c     | 10 +---------
 fs/nfs/nfs4client.c |  8 +-------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index b7b79a348c2b..7f30a6c1a0b0 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1082,7 +1082,6 @@ struct nfs_server *nfs_clone_server(struct nfs_server *source,
 				    rpc_authflavor_t flavor)
 {
 	struct nfs_server *server;
-	struct nfs_fattr *fattr_fsinfo;
 	int error;
 
 	server = nfs_alloc_server();
@@ -1091,11 +1090,6 @@ struct nfs_server *nfs_clone_server(struct nfs_server *source,
 
 	server->cred = get_cred(source->cred);
 
-	error = -ENOMEM;
-	fattr_fsinfo = nfs_alloc_fattr();
-	if (fattr_fsinfo == NULL)
-		goto out_free_server;
-
 	/* Copy data from the source */
 	server->nfs_client = source->nfs_client;
 	server->destroy = source->destroy;
@@ -1111,7 +1105,7 @@ struct nfs_server *nfs_clone_server(struct nfs_server *source,
 		goto out_free_server;
 
 	/* probe the filesystem info for this server filesystem */
-	error = nfs_probe_fsinfo(server, fh, fattr_fsinfo);
+	error = nfs_probe_server(server, fh);
 	if (error < 0)
 		goto out_free_server;
 
@@ -1125,11 +1119,9 @@ struct nfs_server *nfs_clone_server(struct nfs_server *source,
 	nfs_server_insert_lists(server);
 	server->mount_time = jiffies;
 
-	nfs_free_fattr(fattr_fsinfo);
 	return server;
 
 out_free_server:
-	nfs_free_fattr(fattr_fsinfo);
 	nfs_free_server(server);
 	return ERR_PTR(error);
 }
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 85978ecb727e..d8b5a250ca05 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1080,17 +1080,12 @@ void nfs4_server_set_init_caps(struct nfs_server *server)
 static int nfs4_server_common_setup(struct nfs_server *server,
 		struct nfs_fh *mntfh, bool auth_probe)
 {
-	struct nfs_fattr *fattr;
 	int error;
 
 	/* data servers support only a subset of NFSv4.1 */
 	if (is_ds_only_client(server->nfs_client))
 		return -EPROTONOSUPPORT;
 
-	fattr = nfs_alloc_fattr();
-	if (fattr == NULL)
-		return -ENOMEM;
-
 	/* We must ensure the session is initialised first */
 	error = nfs4_init_session(server->nfs_client);
 	if (error < 0)
@@ -1108,7 +1103,7 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 			(unsigned long long) server->fsid.minor);
 	nfs_display_fhandle(mntfh, "Pseudo-fs root FH");
 
-	error = nfs_probe_fsinfo(server, mntfh, fattr);
+	error = nfs_probe_server(server, mntfh);
 	if (error < 0)
 		goto out;
 
@@ -1122,7 +1117,6 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 	server->mount_time = jiffies;
 	server->destroy = nfs4_destroy_server;
 out:
-	nfs_free_fattr(fattr);
 	return error;
 }
 
-- 
2.33.0

