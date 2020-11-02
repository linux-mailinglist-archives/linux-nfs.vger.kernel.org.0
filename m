Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C772A31FB
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 18:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgKBRr7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 12:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgKBRrt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 12:47:49 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD1FC061A04
        for <linux-nfs@vger.kernel.org>; Mon,  2 Nov 2020 09:47:49 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id x13so11737677pfa.9
        for <linux-nfs@vger.kernel.org>; Mon, 02 Nov 2020 09:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GPfV3EPWs4wkJt5zx6YlYB6T70PG6umvg/9zEQjZbrY=;
        b=VMtzx0oPaEipf/zXI15cLmo/wvQA810qZ5FQdB4A1vQHTH2U0GQyKIXEIb2U+ged5J
         1LZdN37vN1nTwjxbGD++9sExdTPJGNvH7/NLllhKAs+tfc4IdNgfMXFvymaigoTsbtU4
         XAETqBFwFDt5LC9ddjux7sEwrNia7qxAjx9XE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GPfV3EPWs4wkJt5zx6YlYB6T70PG6umvg/9zEQjZbrY=;
        b=f/xFQf8cCSlPVvUGmvmyMt3+uubPp89yvfOR5xrmFAHn3UzgIQtQLuDHn31eizNET2
         in9fQ5TAH50XxfxLtKJubFOZQzCjvsv1hccFkbAIpwVSIJp4HbZuzeUjADKYvmypP2eC
         VCVpDQUHczENnUgOx8XjnbVreHjMF/4WyzWXWnU9e+IpofdQiFN3bSt5K6cA4l13Vn09
         9DuRR2nMFPEe7FiYr9n7/hD2DZgttQCTlhGD0nNxlcqH5wQEwEsq3GKOJIlAk3YlBoV7
         bi+IKaM+zbF17WHXC4fD7z1UJ1YNns73Llbw6ZDOotHXi+pvHNt/UBoXyWDYw3834Xor
         dTmQ==
X-Gm-Message-State: AOAM532t2/RCwH/7IjjoIHrvheJ/1pm1pPZtYFypV5FW0cNuerhPPjyD
        BVdlav9elMRW770ESb5DrzDQCQ==
X-Google-Smtp-Source: ABdhPJxTGQViefe+gy4MFUjnFJoxAayZBvl8kfrkYRMvylwQSrpXyZQLMpYp3SKDIU9x74fFwDsu4g==
X-Received: by 2002:a17:90a:c917:: with SMTP id v23mr18235242pjt.235.1604339268689;
        Mon, 02 Nov 2020 09:47:48 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id f4sm115989pjs.8.2020.11.02.09.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:47:48 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Anna Schumaker <schumaker.anna@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] NFSv4: Refactor NFS to use user namespaces
Date:   Mon,  2 Nov 2020 09:47:37 -0800
Message-Id: <20201102174737.2740-3-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102174737.2740-1-sargun@sargun.me>
References: <20201102174737.2740-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In several patches work has been done to enable NFSv4 to use user namespaces:
58002399da65: NFSv4: Convert the NFS client idmapper to use the container user namespace
3b7eb5e35d0f: NFS: When mounting, don't share filesystems between different user namespaces

Unfortunately, the userspace APIs were only such that the userspace facing
side of the filesystem (superblock s_user_ns) could be set to a non init
user namespace. This furthers the fs_context related refactoring, and
piggybacks on top of that logic, so the superblock user namespace, and the
NFS user namespace are the same.

This change only allows those users whom are not using ID mapping to use
user namespaces because the upcall mechanism still needs to be made fully
namespace aware. Currently, it is only network namespace aware (and this
patch doesn't impede that behaviour). Also, there is currently a limitation
that enabling / disabling ID mapping can only be done on a machine-wide
basis.

Eventually, we will need to at least:
  * Separate out the keyring cache by namespace
  * Come up with an upcall mechanism that can be triggered inside of the container,
    or safely triggered outside, with the requisite context to do the right mapping.
  * Handle whatever refactoring needs to be done in net/sunrpc.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 fs/nfs/nfs4client.c | 27 ++++++++++++++++++++++++++-
 fs/nfs/nfs4idmap.c  |  2 +-
 fs/nfs/nfs4idmap.h  |  3 ++-
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index be7915c861ce..c592f1881978 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1153,7 +1153,19 @@ struct nfs_server *nfs4_create_server(struct fs_context *fc)
 	if (!server)
 		return ERR_PTR(-ENOMEM);
 
-	server->cred = get_cred(current_cred());
+	/*
+	 * current_cred() must have CAP_SYS_ADMIN in init_user_ns. All non
+	 * init user namespaces cannot mount NFS, but the fs_context
+	 * can be created in any user namespace.
+	 */
+	if (fc->cred->user_ns != &init_user_ns) {
+		dprintk("%s: Using creds from non-init userns\n", __func__);
+	} else if (fc->cred != current_cred()) {
+		dprintk("%s: Using creds from fs_context which are different than current_creds\n",
+			__func__);
+	}
+
+	server->cred = get_cred(fc->cred);
 
 	auth_probe = ctx->auth_info.flavor_len < 1;
 
@@ -1166,6 +1178,19 @@ struct nfs_server *nfs4_create_server(struct fs_context *fc)
 	if (error < 0)
 		goto error;
 
+	/*
+	 * nfs4idmap is not fully isolated by user namespaces. It is currently
+	 * only network namespace aware. If upcalls never happen, we do not
+	 * need to worry as nfs_client instances aren't shared between
+	 * user namespaces.
+	 */
+	if (idmap_userns(server->nfs_client->cl_idmap) != &init_user_ns &&
+		!(server->caps & NFS_CAP_UIDGID_NOMAP)) {
+		error = -EINVAL;
+		errorf(fc, "Mount credentials are from non init user namespace and ID mapping is enabled. This is not allowed.");
+		goto error;
+	}
+
 	return server;
 
 error:
diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index 8d8aba305ecc..33dc9b76dc17 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -73,7 +73,7 @@ struct idmap {
 	struct user_namespace	*user_ns;
 };
 
-static struct user_namespace *idmap_userns(const struct idmap *idmap)
+struct user_namespace *idmap_userns(const struct idmap *idmap)
 {
 	if (idmap && idmap->user_ns)
 		return idmap->user_ns;
diff --git a/fs/nfs/nfs4idmap.h b/fs/nfs/nfs4idmap.h
index de44d7330ab3..2f5296497887 100644
--- a/fs/nfs/nfs4idmap.h
+++ b/fs/nfs/nfs4idmap.h
@@ -38,7 +38,7 @@
 
 #include <linux/uidgid.h>
 #include <uapi/linux/nfs_idmap.h>
-
+#include <linux/user_namespace.h>
 
 /* Forward declaration to make this header independent of others */
 struct nfs_client;
@@ -50,6 +50,7 @@ int nfs_idmap_init(void);
 void nfs_idmap_quit(void);
 int nfs_idmap_new(struct nfs_client *);
 void nfs_idmap_delete(struct nfs_client *);
+struct user_namespace *idmap_userns(const struct idmap *idmap);
 
 void nfs_fattr_init_names(struct nfs_fattr *fattr,
 		struct nfs4_string *owner_name,
-- 
2.25.1

