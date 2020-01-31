Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5CE14F0F4
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2020 17:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgAaQ5H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 Jan 2020 11:57:07 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41315 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgAaQ5G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 31 Jan 2020 11:57:06 -0500
Received: by mail-yw1-f68.google.com with SMTP id l22so5332303ywc.8
        for <linux-nfs@vger.kernel.org>; Fri, 31 Jan 2020 08:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uU4/YNk3YheU2GlayAYAG2smNmvbjK9oQzG1XeeKCUQ=;
        b=ZSzzWnjZnTpzry33K7jmDej0wDA4kTuqEdsos6ljNLltJ+/9ujdNmFkCFi6o1REtHj
         2TMJv6osXlOsJIwfoLiIoKae40soWZS65F9rx9evUeYMk+Avq7nRAFYeYFPpX8aYkSuy
         RMoJPOnWhO3aab4ANpVkk6ggANnaIrv3Tp7/U8ylInEkdDp9tQNeHdD4O7aIYinPRoi5
         GCwNEcMPJgJVEMqyxufIxV6HK511vDUrfC1/2QVrtMB4XeRRxXNOrRMauo9ODOVYsmFI
         +xw5uiAyH6Ku2tGh3Na/RTWheJxTYQCtaH8AlSNGcldSuXeSW+9WKIubKZxSj4OmF4Fa
         Rmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uU4/YNk3YheU2GlayAYAG2smNmvbjK9oQzG1XeeKCUQ=;
        b=RanYATAEvP9wYHClGBDtpj8s85dgL8R2SqOcT2zero6EWg3ChRXyrFrIhNsKE/vJ9I
         1KVD6weUkkjQe4YgxmAqVFiUvz2ouNbukHmc55NlKdxQ662jg5J6XODAS3uhW1yoC1Uy
         ena+jznTHAG4ngMY34J/tz6aWT/dWl8OTemA5KiNCw9VuTz901EEWfhUk6d/mgKfIoMK
         pBu6Qp9Gi+qgpwZdkF9Q08dEgD7CnNp1f4j7ZBN9GdIN5pRqJUZdJDkGXr6cBx+s1gi4
         C6orOSkkQaZ1fCkjS1nBdDt3wbZl+hcjJvcRgsMDemk99IUmnPc7CCoaHXwI4DjCifT0
         bbuQ==
X-Gm-Message-State: APjAAAXKxzaigGw55AJd3Pz8pV0qsRqzKvR2ym7xPHa6pzrvuL2wqbr6
        olbOebXI+x3ERmQOpfWaqHo=
X-Google-Smtp-Source: APXvYqzM/Gm0PtmfUMF/rzsil2d+gXrJqEgvU98XpqBqPL5W1liF1XDvMl1XNm50toQNWkWc/6zwPQ==
X-Received: by 2002:a81:780b:: with SMTP id t11mr8208404ywc.117.1580489825684;
        Fri, 31 Jan 2020 08:57:05 -0800 (PST)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id s3sm4466993ywf.22.2020.01.31.08.57.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 31 Jan 2020 08:57:04 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.0 encode nconnect-enabled client into clientid
Date:   Fri, 31 Jan 2020 11:57:02 -0500
Message-Id: <20200131165702.1751-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

It helps some servers to be able to identify if the incoming client is
doing nconnect mount or not. While creating the unique client id for
the SETCLIENTID operation add nconnect=X to it.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 402410c..a90ea28 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5950,7 +5950,7 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
 		return 0;
 
 	rcu_read_lock();
-	len = 14 +
+	len = 14 + 12 +
 		strlen(clp->cl_rpcclient->cl_nodename) +
 		1 +
 		strlen(rpc_peeraddr2str(clp->cl_rpcclient, RPC_DISPLAY_ADDR)) +
@@ -5972,13 +5972,15 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
 
 	rcu_read_lock();
 	if (nfs4_client_id_uniquifier[0] != '\0')
-		scnprintf(str, len, "Linux NFSv4.0 %s/%s/%s",
+		scnprintf(str, len, "Linux NFSv4.0 nconnect=%d %s/%s/%s",
+			  clp->cl_nconnect,
 			  clp->cl_rpcclient->cl_nodename,
 			  nfs4_client_id_uniquifier,
 			  rpc_peeraddr2str(clp->cl_rpcclient,
 					   RPC_DISPLAY_ADDR));
 	else
-		scnprintf(str, len, "Linux NFSv4.0 %s/%s",
+		scnprintf(str, len, "Linux NFSv4.0 nconnect=%d %s/%s",
+			  clp->cl_nconnect,
 			  clp->cl_rpcclient->cl_nodename,
 			  rpc_peeraddr2str(clp->cl_rpcclient,
 					   RPC_DISPLAY_ADDR));
@@ -5994,7 +5996,7 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
 	size_t len;
 	char *str;
 
-	len = 10 + 10 + 1 + 10 + 1 +
+	len = 10 + 10 + 1 + 10 + 1 + 12 +
 		strlen(nfs4_client_id_uniquifier) + 1 +
 		strlen(clp->cl_rpcclient->cl_nodename) + 1;
 
@@ -6010,9 +6012,9 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
 	if (!str)
 		return -ENOMEM;
 
-	scnprintf(str, len, "Linux NFSv%u.%u %s/%s",
+	scnprintf(str, len, "Linux NFSv%u.%u nconnect=%d %s/%s",
 			clp->rpc_ops->version, clp->cl_minorversion,
-			nfs4_client_id_uniquifier,
+			clp->cl_nconnect, nfs4_client_id_uniquifier,
 			clp->cl_rpcclient->cl_nodename);
 	clp->cl_owner_id = str;
 	return 0;
@@ -6030,7 +6032,7 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
 	if (nfs4_client_id_uniquifier[0] != '\0')
 		return nfs4_init_uniquifier_client_string(clp);
 
-	len = 10 + 10 + 1 + 10 + 1 +
+	len = 10 + 10 + 1 + 10 + 1 + 12 +
 		strlen(clp->cl_rpcclient->cl_nodename) + 1;
 
 	if (len > NFS4_OPAQUE_LIMIT + 1)
@@ -6045,9 +6047,9 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
 	if (!str)
 		return -ENOMEM;
 
-	scnprintf(str, len, "Linux NFSv%u.%u %s",
+	scnprintf(str, len, "Linux NFSv%u.%u nconnect=%d %s",
 			clp->rpc_ops->version, clp->cl_minorversion,
-			clp->cl_rpcclient->cl_nodename);
+			clp->cl_nconnect, clp->cl_rpcclient->cl_nodename);
 	clp->cl_owner_id = str;
 	return 0;
 }
-- 
1.8.3.1

