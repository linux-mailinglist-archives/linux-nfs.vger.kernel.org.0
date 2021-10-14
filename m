Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56CE642E098
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Oct 2021 19:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbhJNR5U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Oct 2021 13:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbhJNR5T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Oct 2021 13:57:19 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D2EC061570
        for <linux-nfs@vger.kernel.org>; Thu, 14 Oct 2021 10:55:14 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id z3so4201085qvl.9
        for <linux-nfs@vger.kernel.org>; Thu, 14 Oct 2021 10:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ooXUaPsDW36LEYss3e9YwlUtHeSl9e6veGzBqPcOAKY=;
        b=paRbI4LK3gkfYOPHgrtNH55h0krrFl1mF5eszsv9XPfsnqAW+d7qNSYRu1WLrbO3fZ
         AX4B5fQDopLF0ILpJzBqCyQJMXTsihp7PWN9lSLOt5kWAAGuL/U2HMYTcGFsPzBP7O3s
         MR4d9pMG5yfdUZkKnJAmwfVUuVnY3XjYqtwW8unwyIgk7bNhiR7CQDz+omMxIq5Im4xN
         8Xi1nR5OZpl4A8FRmG0ry34l5di6wMJYqIFp4ZufMzJ/dOfj6mazoAZzmqGfnCVy/8Nx
         imZRnHt4yesH3PM5/KkM22P9kezcftDN0LguD4RT895kMKjME21S5cmubHJrBfyuL/yr
         s7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ooXUaPsDW36LEYss3e9YwlUtHeSl9e6veGzBqPcOAKY=;
        b=kZNhPZhLWklPN00B8F3fkmPMQVsZXGA50aNPeYpKNdl7+n8RkX4TepqX8qxkiDLeW4
         83cFA1FD6ZAHpQoQ48B7jYETIh6tnXBv3B3VjLwPw6PkxNu4jN6jXo8SoMXgIadk000k
         Qsywwpasr3FDykhj1gAhYTbH2VNVTYjUZyE/TkKJ8tshjiFjDj3IDUuNA4pI4Owl9QiE
         tE0IzGKpW5rgufBAKgGGGI66deDU+QWuEcyOvGF6vrMknWIrrqkXNxCF2SuvG99s4ZTC
         IIHMy1OzpYDe2DH+gW4A9IZ+hwQBJBhFQJSxZ9L5jxEm7JVoavbL7pX9FmRgT/BKcdUq
         BBNQ==
X-Gm-Message-State: AOAM531zO00QIHtInrKCAlDnRBqB0T9IYwnm3GiB9nahp9kvLC7Iagj4
        rxCUovEYgz/IbQ/dfWMpoYUGOlkxbBA=
X-Google-Smtp-Source: ABdhPJzA2N4+gkrx1QiZmlNPPiDN3ZjZAVZcd2QF+bxOIOkKy5VPOvxAnC0G+VFeXwdNRYu+1W9n4Q==
X-Received: by 2002:a0c:da8b:: with SMTP id z11mr6915038qvj.24.1634234113302;
        Thu, 14 Oct 2021 10:55:13 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id m6sm1536131qkh.69.2021.10.14.10.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 10:55:12 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 5/5] NFS: Unexport nfs_probe_fsinfo()
Date:   Thu, 14 Oct 2021 13:55:08 -0400
Message-Id: <20211014175508.197313-6-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014175508.197313-1-Anna.Schumaker@Netapp.com>
References: <20211014175508.197313-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

All the callers are now in client.c so we can remove the
EXPORT_SYMBOL_GPL() and make it static.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/client.c   | 3 +--
 fs/nfs/internal.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 7f30a6c1a0b0..1e4dc1ab9312 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -828,7 +828,7 @@ static void nfs_server_set_fsinfo(struct nfs_server *server,
 /*
  * Probe filesystem information, including the FSID on v2/v3
  */
-int nfs_probe_fsinfo(struct nfs_server *server, struct nfs_fh *mntfh, struct nfs_fattr *fattr)
+static int nfs_probe_fsinfo(struct nfs_server *server, struct nfs_fh *mntfh, struct nfs_fattr *fattr)
 {
 	struct nfs_fsinfo fsinfo;
 	struct nfs_client *clp = server->nfs_client;
@@ -862,7 +862,6 @@ int nfs_probe_fsinfo(struct nfs_server *server, struct nfs_fh *mntfh, struct nfs
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(nfs_probe_fsinfo);
 
 /*
  * Grab the destination's particulars, including lease expiry time.
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 508cb64c2661..12f6acb483bb 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -193,7 +193,6 @@ extern void nfs_clients_exit(struct net *net);
 extern struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *);
 int nfs_create_rpc_client(struct nfs_client *, const struct nfs_client_initdata *, rpc_authflavor_t);
 struct nfs_client *nfs_get_client(const struct nfs_client_initdata *);
-int nfs_probe_fsinfo(struct nfs_server *server, struct nfs_fh *, struct nfs_fattr *);
 int nfs_probe_server(struct nfs_server *, struct nfs_fh *);
 void nfs_server_insert_lists(struct nfs_server *);
 void nfs_server_remove_lists(struct nfs_server *);
-- 
2.33.0

