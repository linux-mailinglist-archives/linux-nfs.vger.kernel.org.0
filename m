Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2AC42E095
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Oct 2021 19:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhJNR5R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Oct 2021 13:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhJNR5R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Oct 2021 13:57:17 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F47C061570
        for <linux-nfs@vger.kernel.org>; Thu, 14 Oct 2021 10:55:11 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id bi9so6187764qkb.11
        for <linux-nfs@vger.kernel.org>; Thu, 14 Oct 2021 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hkCl4AhoMlF3zujXe2g18GkqBQoCDlCVA09o/GacXFU=;
        b=EGR90zMCcmumdmn3OTR4tBZeCYSy2yE1OAQjF8qYxbzuxmHnLnProqZtaQEvoMwHzB
         ZW3ptzsIaQsOC7nVmyVLEqKxltwn3Z1qRqLc2jLVKKDHJoc/ctlxUC0hApgv7mhdmXW3
         s1xHi6zTTELHP0rNtIxRRjzJrHKyZcHqXLrwX5c6wFSagUqc4bhlcrasfY8EHAT6qoZB
         R/kTjscsuHWu6eT8ghmsFz+r9d6pU7HHEWHV481HNiInUcnevEeyH761T80RS8wACXpK
         OXuj4zJb1ZNc+m74SrXhqcAsG/TNO2OX/C2TG4r6Mfzicuwi+aPabh0pR8tTpeu/rgsI
         6HNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=hkCl4AhoMlF3zujXe2g18GkqBQoCDlCVA09o/GacXFU=;
        b=gZfYCt6wCA4/eqM48bAssrSK04pdu7L46iDsxSP8LjZ9ZQXw1r041gbboHKx9ge40e
         tNmzPHg7T1bQ2XZricIDN1E7ZoatWX90dmPmG6ANdzlTfhGVZj9YINy/dy0a3OKksbjv
         heKWrmW866PEnTLeSDbMdA3Y1BAvJL2UCi4cs7pCvT29WAPK/28gGmw5umbOR5M2sqBE
         UNEhLmDlQdiNzqr1XvF+CLjEk8zfkk90hZvujypnFR2EUQfG+CaR56nZtCrvCn7Kgt6g
         d7Xmvc+17aIUo3oAUC7wV5YfEBFj92v6h5DTFtKbo0FiKMe6/8F5zZpvpUWwok1vVa6t
         Wc3A==
X-Gm-Message-State: AOAM531B2U1RVf+4XvFC4A7UqiFfDUVO/XrkfkJWpWPbu5YADrUnGj3o
        +qJixxKVKb+7R9BclqBlwso=
X-Google-Smtp-Source: ABdhPJylt32tkX5QkqsSart9w8ciW7PHJ8k/pROkhoEBXlu/Abbkc+AoJxornmWmakFwjObcxcDvFQ==
X-Received: by 2002:a37:44cc:: with SMTP id r195mr6340988qka.77.1634234111004;
        Thu, 14 Oct 2021 10:55:11 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id m6sm1536131qkh.69.2021.10.14.10.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 10:55:10 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 2/5] NFS: Move nfs_probe_destination() into the generic client
Date:   Thu, 14 Oct 2021 13:55:05 -0400
Message-Id: <20211014175508.197313-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014175508.197313-1-Anna.Schumaker@Netapp.com>
References: <20211014175508.197313-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

And rename it to nfs_probe_server(). I also change it to take the nfs_fh
as an argument so callers can choose what filehandle to probe.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/client.c     | 24 ++++++++++++++++++++++++
 fs/nfs/internal.h   |  1 +
 fs/nfs/nfs4client.c | 26 +-------------------------
 3 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 6956079b7741..b7b79a348c2b 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -864,6 +864,30 @@ int nfs_probe_fsinfo(struct nfs_server *server, struct nfs_fh *mntfh, struct nfs
 }
 EXPORT_SYMBOL_GPL(nfs_probe_fsinfo);
 
+/*
+ * Grab the destination's particulars, including lease expiry time.
+ *
+ * Returns zero if probe succeeded and retrieved FSID matches the FSID
+ * we have cached.
+ */
+int nfs_probe_server(struct nfs_server *server, struct nfs_fh *mntfh)
+{
+	struct nfs_fattr *fattr;
+	int error;
+
+	fattr = nfs_alloc_fattr();
+	if (fattr == NULL)
+		return -ENOMEM;
+
+	/* Sanity: the probe won't work if the destination server
+	 * does not recognize the migrated FH. */
+	error = nfs_probe_fsinfo(server, mntfh, fattr);
+
+	nfs_free_fattr(fattr);
+	return error;
+}
+EXPORT_SYMBOL_GPL(nfs_probe_server);
+
 /*
  * Copy useful information when duplicating a server record
  */
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 690271adb294..508cb64c2661 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -194,6 +194,7 @@ extern struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *);
 int nfs_create_rpc_client(struct nfs_client *, const struct nfs_client_initdata *, rpc_authflavor_t);
 struct nfs_client *nfs_get_client(const struct nfs_client_initdata *);
 int nfs_probe_fsinfo(struct nfs_server *server, struct nfs_fh *, struct nfs_fattr *);
+int nfs_probe_server(struct nfs_server *, struct nfs_fh *);
 void nfs_server_insert_lists(struct nfs_server *);
 void nfs_server_remove_lists(struct nfs_server *);
 void nfs_init_timeout_values(struct rpc_timeout *to, int proto, int timeo, int retrans);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 3fb0ca92377c..85978ecb727e 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1293,30 +1293,6 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
 	return ERR_PTR(error);
 }
 
-/*
- * Grab the destination's particulars, including lease expiry time.
- *
- * Returns zero if probe succeeded and retrieved FSID matches the FSID
- * we have cached.
- */
-static int nfs_probe_destination(struct nfs_server *server)
-{
-	struct inode *inode = d_inode(server->super->s_root);
-	struct nfs_fattr *fattr;
-	int error;
-
-	fattr = nfs_alloc_fattr();
-	if (fattr == NULL)
-		return -ENOMEM;
-
-	/* Sanity: the probe won't work if the destination server
-	 * does not recognize the migrated FH. */
-	error = nfs_probe_fsinfo(server, NFS_FH(inode), fattr);
-
-	nfs_free_fattr(fattr);
-	return error;
-}
-
 /**
  * nfs4_update_server - Move an nfs_server to a different nfs_client
  *
@@ -1377,5 +1353,5 @@ int nfs4_update_server(struct nfs_server *server, const char *hostname,
 		server->nfs_client->cl_hostname = kstrdup(hostname, GFP_KERNEL);
 	nfs_server_insert_lists(server);
 
-	return nfs_probe_destination(server);
+	return nfs_probe_server(server, NFS_FH(d_inode(server->super->s_root)));
 }
-- 
2.33.0

