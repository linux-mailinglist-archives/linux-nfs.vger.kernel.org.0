Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD6DEB9D8
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 23:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfJaWn1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 18:43:27 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35426 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfJaWn0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 18:43:26 -0400
Received: by mail-yw1-f67.google.com with SMTP id r134so2799018ywg.2
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 15:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=miHuqUqWzdE1nbZhl0K85EkExwuSgvBYv/eRMB4N1Ko=;
        b=Fq4pu+akxnGfhPCWfDtr8jOA6vV2beNxDwmzyeU2raiCesZL/4eRlWEGkk5P4o93CA
         PFwJN+5Wwu2gDhqlj0DGeZUnT2OVoiF+qRWlpW0W83vMczAOYkkIz1iYpmDJsO4VD2gM
         8YjmBE6Ze8qTiI7fssjkZ+Zsn7ykkSYY1lfyN/Mb57O5+22bzifDu5yRReMcZQzq3IOm
         oxZXjvUSF/U6NvTiV7pnmAElS0tqCW8LJw/9heMFVFhYoc3EorxjODX6qIhSRYFQ+jq2
         J5jLZY/RKTpXfwY2f3sUrnkNnOIJSalumv+kYiLXquE0B6JFMTjE/fgOzfkOyPT3UoZE
         Vsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=miHuqUqWzdE1nbZhl0K85EkExwuSgvBYv/eRMB4N1Ko=;
        b=gbvBmB+u3pmLI45LUQ4zxz6noRZ6QD5owzzbtLkkw2lR9tzQN7t/QgXD/jAN6YChbj
         v77SK0gGF4zw6BNyXD+9YpUCK9tCHYJzxsG1oZeNtNj4XDNgLz5d93JM9bAjWGFAueaI
         i5HQcdGQKZpPBNff1clyRSOqG/FL/I9NJQww7nhogslLFYfzPq2wZs+ND2ey0TMglph7
         BxRGDLeEfvAveHmoMQfbuzP+aSSHMG2q8Ud+JO/zC1ClhgJUWjq8nGNYVgKp8bukRyUG
         MoWF/4698YizA99oIv8WoOiW3GL/gzTRF4+lnzBFeQd04dJS7n128721Xmwks7Z4MaUa
         6K9A==
X-Gm-Message-State: APjAAAUq7RfJUm6e9PuPKXllNVAKgQrKi/M0gAruXAo0i1yT5toDH66P
        akODGIvVfdKwticyV6BvIa0Yyms=
X-Google-Smtp-Source: APXvYqycYgr4TEz1ESR0AVwCe8Q1PW5wxXMGju8fqoW7biczO419qxkh+R+gQwTlOX2FJPWJ2Ljk4Q==
X-Received: by 2002:a81:61c3:: with SMTP id v186mr6313170ywb.151.1572561805336;
        Thu, 31 Oct 2019 15:43:25 -0700 (PDT)
Received: from localhost.localdomain ([50.105.87.1])
        by smtp.gmail.com with ESMTPSA id d192sm1720287ywb.3.2019.10.31.15.43.24
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:43:24 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 16/20] NFSv4: Fix nfs4_inode_make_writeable()
Date:   Thu, 31 Oct 2019 18:40:47 -0400
Message-Id: <20191031224051.8923-17-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031224051.8923-16-trond.myklebust@hammerspace.com>
References: <20191031224051.8923-1-trond.myklebust@hammerspace.com>
 <20191031224051.8923-2-trond.myklebust@hammerspace.com>
 <20191031224051.8923-3-trond.myklebust@hammerspace.com>
 <20191031224051.8923-4-trond.myklebust@hammerspace.com>
 <20191031224051.8923-5-trond.myklebust@hammerspace.com>
 <20191031224051.8923-6-trond.myklebust@hammerspace.com>
 <20191031224051.8923-7-trond.myklebust@hammerspace.com>
 <20191031224051.8923-8-trond.myklebust@hammerspace.com>
 <20191031224051.8923-9-trond.myklebust@hammerspace.com>
 <20191031224051.8923-10-trond.myklebust@hammerspace.com>
 <20191031224051.8923-11-trond.myklebust@hammerspace.com>
 <20191031224051.8923-12-trond.myklebust@hammerspace.com>
 <20191031224051.8923-13-trond.myklebust@hammerspace.com>
 <20191031224051.8923-14-trond.myklebust@hammerspace.com>
 <20191031224051.8923-15-trond.myklebust@hammerspace.com>
 <20191031224051.8923-16-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fix the checks in nfs4_inode_make_writeable() to ignore the case where
we hold no delegations. Currently, in such a case, we automatically
flush writes.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 78df1cde286e..e3d8055f0c6d 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -644,10 +644,18 @@ int nfs4_inode_return_delegation(struct inode *inode)
  */
 int nfs4_inode_make_writeable(struct inode *inode)
 {
-	if (!nfs4_has_session(NFS_SERVER(inode)->nfs_client) ||
-	    !nfs4_check_delegation(inode, FMODE_WRITE))
-		return nfs4_inode_return_delegation(inode);
-	return 0;
+	struct nfs_delegation *delegation;
+
+	rcu_read_lock();
+	delegation = nfs4_get_valid_delegation(inode);
+	if (delegation == NULL ||
+	    (nfs4_has_session(NFS_SERVER(inode)->nfs_client) &&
+	     (delegation->type & FMODE_WRITE))) {
+		rcu_read_unlock();
+		return 0;
+	}
+	rcu_read_unlock();
+	return nfs4_inode_return_delegation(inode);
 }
 
 static void nfs_mark_return_if_closed_delegation(struct nfs_server *server,
-- 
2.23.0

