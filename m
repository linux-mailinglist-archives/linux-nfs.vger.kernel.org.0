Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49234286AD9
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Oct 2020 00:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgJGW02 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 18:26:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbgJGW02 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 7 Oct 2020 18:26:28 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53A1920872;
        Wed,  7 Oct 2020 22:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602109587;
        bh=ip0qSkJFl5dK/ShkunbHc+ffoYil+g5R7bvtBwePjMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/IM1X8zc79MiaiiWr66B90NAlUbV6R9udItHiz8neoKdxP5LAZ5LxuX8lh3FICj6
         uWqnr4aoOMaEv81RYjwyXqboyaP44eQZA1Ef/I+AHxLfHQCCmWcK491JqtC400k18k
         dzgsoC3CgtRtqfocp3pIk/FxL3CA34Rndrh46T4g=
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] NFSv4: Clean up initialisation of uniquified client id strings
Date:   Wed,  7 Oct 2020 18:24:17 -0400
Message-Id: <20201007222418.604115-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007222418.604115-1-trondmy@kernel.org>
References: <20201007222418.604115-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When the user sets a uniquifier, then ensure we copy the string
so that calls to strlen() etc are atomic with calls to snprintf().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 75 +++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 41 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 6e95c85fe395..da12b22508a8 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6006,9 +6006,22 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
 	memcpy(bootverf->data, verf, sizeof(bootverf->data));
 }
 
+static size_t
+nfs4_get_uniquifier(char *buf, size_t buflen)
+{
+	buf[0] = '\0';
+
+	if (nfs4_client_id_uniquifier[0] != '\0')
+		strscpy(buf, nfs4_client_id_uniquifier, buflen);
+
+	return strlen(buf);
+}
+
 static int
 nfs4_init_nonuniform_client_string(struct nfs_client *clp)
 {
+	char buf[NFS4_CLIENT_ID_UNIQ_LEN];
+	size_t buflen;
 	size_t len;
 	char *str;
 
@@ -6022,8 +6035,11 @@ nfs4_init_nonuniform_client_string(struct nfs_client *clp)
 		strlen(rpc_peeraddr2str(clp->cl_rpcclient, RPC_DISPLAY_ADDR)) +
 		1;
 	rcu_read_unlock();
-	if (nfs4_client_id_uniquifier[0] != '\0')
-		len += strlen(nfs4_client_id_uniquifier) + 1;
+
+	buflen = nfs4_get_uniquifier(buf, sizeof(buf));
+	if (buflen)
+		len += buflen + 1;
+
 	if (len > NFS4_OPAQUE_LIMIT + 1)
 		return -EINVAL;
 
@@ -6037,10 +6053,9 @@ nfs4_init_nonuniform_client_string(struct nfs_client *clp)
 		return -ENOMEM;
 
 	rcu_read_lock();
-	if (nfs4_client_id_uniquifier[0] != '\0')
+	if (buflen)
 		scnprintf(str, len, "Linux NFSv4.0 %s/%s/%s",
-			  clp->cl_rpcclient->cl_nodename,
-			  nfs4_client_id_uniquifier,
+			  clp->cl_rpcclient->cl_nodename, buf,
 			  rpc_peeraddr2str(clp->cl_rpcclient,
 					   RPC_DISPLAY_ADDR));
 	else
@@ -6054,51 +6069,24 @@ nfs4_init_nonuniform_client_string(struct nfs_client *clp)
 	return 0;
 }
 
-static int
-nfs4_init_uniquifier_client_string(struct nfs_client *clp)
-{
-	size_t len;
-	char *str;
-
-	len = 10 + 10 + 1 + 10 + 1 +
-		strlen(nfs4_client_id_uniquifier) + 1 +
-		strlen(clp->cl_rpcclient->cl_nodename) + 1;
-
-	if (len > NFS4_OPAQUE_LIMIT + 1)
-		return -EINVAL;
-
-	/*
-	 * Since this string is allocated at mount time, and held until the
-	 * nfs_client is destroyed, we can use GFP_KERNEL here w/o worrying
-	 * about a memory-reclaim deadlock.
-	 */
-	str = kmalloc(len, GFP_KERNEL);
-	if (!str)
-		return -ENOMEM;
-
-	scnprintf(str, len, "Linux NFSv%u.%u %s/%s",
-			clp->rpc_ops->version, clp->cl_minorversion,
-			nfs4_client_id_uniquifier,
-			clp->cl_rpcclient->cl_nodename);
-	clp->cl_owner_id = str;
-	return 0;
-}
-
 static int
 nfs4_init_uniform_client_string(struct nfs_client *clp)
 {
+	char buf[NFS4_CLIENT_ID_UNIQ_LEN];
+	size_t buflen;
 	size_t len;
 	char *str;
 
 	if (clp->cl_owner_id != NULL)
 		return 0;
 
-	if (nfs4_client_id_uniquifier[0] != '\0')
-		return nfs4_init_uniquifier_client_string(clp);
-
 	len = 10 + 10 + 1 + 10 + 1 +
 		strlen(clp->cl_rpcclient->cl_nodename) + 1;
 
+	buflen = nfs4_get_uniquifier(buf, sizeof(buf));
+	if (buflen)
+		len += buflen + 1;
+
 	if (len > NFS4_OPAQUE_LIMIT + 1)
 		return -EINVAL;
 
@@ -6111,9 +6099,14 @@ nfs4_init_uniform_client_string(struct nfs_client *clp)
 	if (!str)
 		return -ENOMEM;
 
-	scnprintf(str, len, "Linux NFSv%u.%u %s",
-			clp->rpc_ops->version, clp->cl_minorversion,
-			clp->cl_rpcclient->cl_nodename);
+	if (buflen)
+		scnprintf(str, len, "Linux NFSv%u.%u %s/%s",
+			  clp->rpc_ops->version, clp->cl_minorversion,
+			  buf, clp->cl_rpcclient->cl_nodename);
+	else
+		scnprintf(str, len, "Linux NFSv%u.%u %s",
+			  clp->rpc_ops->version, clp->cl_minorversion,
+			  clp->cl_rpcclient->cl_nodename);
 	clp->cl_owner_id = str;
 	return 0;
 }
-- 
2.26.2

