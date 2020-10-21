Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A96294C34
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Oct 2020 14:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411168AbgJUMFp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Oct 2020 08:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439910AbgJUMFo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Oct 2020 08:05:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC03C0613CE
        for <linux-nfs@vger.kernel.org>; Wed, 21 Oct 2020 05:05:43 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kk5so1045597pjb.1
        for <linux-nfs@vger.kernel.org>; Wed, 21 Oct 2020 05:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vJHUiIV/mXgyDV0BplJrCZ+f4uBKxL2uz453PEXSerk=;
        b=P5zrFhEbkRW8IMbTRa8/5yw4n/AYJtpsEebsoYbAF4LdoGYLXxm1bUWxoAHdfvm3o1
         Jx6pTPuhnirmBFkEi+usNt2pMpb+6y3ROBP7la/rEpRRhSwEJqykDtMf9O3wIs7SBbD/
         NkSoPzDB6eWKj/QbRCz+9kHBoMeFOFzh16oNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vJHUiIV/mXgyDV0BplJrCZ+f4uBKxL2uz453PEXSerk=;
        b=fI2nEFA8nbqv0jwfsTkZYqdGSaxrIng0O4vxvw7G/8SGuJU11ReEOXJ3Lqg2SZHmW2
         KrTeKORQjIlYE/MCF4hiSiXhv4wcnfkai2icW0KqqYQiXZc6rAEi5/ppbXQR40jxeigh
         095Ek7K/yNf6Iid3duyC0257aOnISSjOdUSTne7LNy9E5MFUZe1yIy697lB+334UYeJC
         /IjGx6CYb7tvuGhn5FOSOwjZxHlESfb/mwK+zGlYBq6wGU6FLzwaHkIslANo+I2XXg7c
         AOJ7se0coL+cPu8s7yPpu/iOgw3r+6QxcRvLg+NLFfVdNJaYqHgtHHKEI+527MzymqrR
         yVWQ==
X-Gm-Message-State: AOAM531CgGW8rUFaAp9Y+0YxZzkaWaiKctl/Xe8kXO6wB22AzexgfKvU
        y92WFWcQPgXXTHheFXr8XQRAgg==
X-Google-Smtp-Source: ABdhPJysrrQyxAa4d/4x9NCuKLjTunYJ7BtV7RXKMPOazdzn9BUWo7vaDlNYMHGY12tDVZR35B2h2Q==
X-Received: by 2002:a17:902:8e89:b029:d5:fefd:9637 with SMTP id bg9-20020a1709028e89b02900d5fefd9637mr3217602plb.39.1603281942696;
        Wed, 21 Oct 2020 05:05:42 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id b5sm2276392pfo.64.2020.10.21.05.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 05:05:42 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, kylea@netflix.com
Subject: [PATCH v3 2/3] NFSv4: Refactor: reference user namespace from nfs4idmap
Date:   Wed, 21 Oct 2020 05:05:28 -0700
Message-Id: <20201021120529.7062-3-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021120529.7062-1-sargun@sargun.me>
References: <20201021120529.7062-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The nfs4idmapper only needs access to the user namespace, and not the
entire cred struct. This replaces the struct cred* member with struct
user_namespace*. This is so we don't have to hold onto the cred object,
which has extraneous references to things like user_struct. This also makes
switching away from init_user_ns more straightforward in the future.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 fs/nfs/nfs4idmap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index 62e6eea5c516..8d8aba305ecc 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -46,6 +46,7 @@
 #include <keys/user-type.h>
 #include <keys/request_key_auth-type.h>
 #include <linux/module.h>
+#include <linux/user_namespace.h>
 
 #include "internal.h"
 #include "netns.h"
@@ -69,13 +70,13 @@ struct idmap {
 	struct rpc_pipe		*idmap_pipe;
 	struct idmap_legacy_upcalldata *idmap_upcall_data;
 	struct mutex		idmap_mutex;
-	const struct cred	*cred;
+	struct user_namespace	*user_ns;
 };
 
 static struct user_namespace *idmap_userns(const struct idmap *idmap)
 {
-	if (idmap && idmap->cred)
-		return idmap->cred->user_ns;
+	if (idmap && idmap->user_ns)
+		return idmap->user_ns;
 	return &init_user_ns;
 }
 
@@ -286,7 +287,7 @@ static struct key *nfs_idmap_request_key(const char *name, size_t namelen,
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	if (!idmap->cred || idmap->cred->user_ns == &init_user_ns)
+	if (!idmap->user_ns || idmap->user_ns == &init_user_ns)
 		rkey = request_key(&key_type_id_resolver, desc, "");
 	if (IS_ERR(rkey)) {
 		mutex_lock(&idmap->idmap_mutex);
@@ -462,7 +463,7 @@ nfs_idmap_new(struct nfs_client *clp)
 		return -ENOMEM;
 
 	mutex_init(&idmap->idmap_mutex);
-	idmap->cred = get_cred(clp->cl_rpcclient->cl_cred);
+	idmap->user_ns = get_user_ns(clp->cl_rpcclient->cl_cred->user_ns);
 
 	rpc_init_pipe_dir_object(&idmap->idmap_pdo,
 			&nfs_idmap_pipe_dir_object_ops,
@@ -486,7 +487,7 @@ nfs_idmap_new(struct nfs_client *clp)
 err_destroy_pipe:
 	rpc_destroy_pipe_data(idmap->idmap_pipe);
 err:
-	put_cred(idmap->cred);
+	get_user_ns(idmap->user_ns);
 	kfree(idmap);
 	return error;
 }
@@ -503,7 +504,7 @@ nfs_idmap_delete(struct nfs_client *clp)
 			&clp->cl_rpcclient->cl_pipedir_objects,
 			&idmap->idmap_pdo);
 	rpc_destroy_pipe_data(idmap->idmap_pipe);
-	put_cred(idmap->cred);
+	put_user_ns(idmap->user_ns);
 	kfree(idmap);
 }
 
-- 
2.25.1

