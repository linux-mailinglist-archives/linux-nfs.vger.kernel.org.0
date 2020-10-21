Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2461294C32
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Oct 2020 14:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411210AbgJUMFm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Oct 2020 08:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411168AbgJUMFm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Oct 2020 08:05:42 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE519C0613CF
        for <linux-nfs@vger.kernel.org>; Wed, 21 Oct 2020 05:05:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id g16so1048904pjv.3
        for <linux-nfs@vger.kernel.org>; Wed, 21 Oct 2020 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Or3OrGmTCVsC6irW7Os1G3558l38zqrysNf3h0cfK5c=;
        b=RK5bzLagY7MwYmbltNGhZ6w2+8kHeVI0CkHzGATgoSmrNsbptAxmzQhPWoAWkxNez9
         poU/XlsHTD1dqq1tXO0UgmZlpvOw60EdWjvsv0kXFrGYX7kL1h/IjceIXYGgPNoIj/aT
         sXHp09uleltxEiEw2swEHxSawsX0KYjaqMvxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Or3OrGmTCVsC6irW7Os1G3558l38zqrysNf3h0cfK5c=;
        b=YUS+ly5fhVZ7Fd2QlCGu08CeKUL13DgQnZE/1kUJU9rHcxl/Pzi9/uH+nnY0AyxneZ
         cmGDrynpO9gm6yQ3hoa8E6xZVks1I2HI85abE8XwokygxucNtwlwwOw7f7/h+Vt+OluG
         pybACsPR+nVml+ggUwRu6g+pMjr9lm7vUdykYP8r1aOCURcuiotT2XcmK/qfQkJfkcKH
         K3m4sdMU/gKs+RCKXXUhwJScK1ngyAIoXNsAzdzuS8KtK0XeYw9iYklAwYLWd3sQTFkI
         C6n6QF3yvFAspXe33cq4lxFF6n20Idou6VbOFHyVJgo/k3VqlPX+591eLnaZRllCg+s8
         u7AQ==
X-Gm-Message-State: AOAM533C6UcJej+LyQMkg6VCb0pCla/2UsCoHPyTTmheO4Oy3YpRpaqu
        /3pQb1Kt7eyWxBvYKkmBHWea3Q==
X-Google-Smtp-Source: ABdhPJwmpjHy1WRp9iSKqElLpy3hosxwYtT3h2VWW5BLoQCLOAYhuwx01oWjtT6w49LWtwTz/Vl4yg==
X-Received: by 2002:a17:902:ac82:b029:d5:b159:3335 with SMTP id h2-20020a170902ac82b02900d5b1593335mr3386721plr.44.1603281941101;
        Wed, 21 Oct 2020 05:05:41 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id b5sm2276392pfo.64.2020.10.21.05.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 05:05:40 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, kylea@netflix.com
Subject: [PATCH v3 1/3] NFS: NFSv2/NFSv3: Use cred from fs_context during mount
Date:   Wed, 21 Oct 2020 05:05:27 -0700
Message-Id: <20201021120529.7062-2-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021120529.7062-1-sargun@sargun.me>
References: <20201021120529.7062-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There was refactoring done to use the fs_context for mounting done in:
62a55d088cd87: NFS: Additional refactoring for fs_context conversion

This made it so that the net_ns is fetched from the fs_context (the netns
that fsopen is called in). This change also makes it so that the credential
fetched during fsopen is used as well as the net_ns.

NFS has already had a number of changes to prepare it for user namespaces:
1a58e8a0e5c1: NFS: Store the credential of the mount process in the nfs_server
264d948ce7d0: NFS: Convert NFSv3 to use the container user namespace
c207db2f5da5: NFS: Convert NFSv2 to use the container user namespace

Previously, different credentials could be used for creation of the
fs_context versus creation of the nfs_server, as FSCONFIG_CMD_CREATE did
the actual credential check, and that's where current_creds() were fetched.
This meant that the user namespace which fsopen was called in could be a
non-init user namespace. This still requires that the user that calls
FSCONFIG_CMD_CREATE has CAP_SYS_ADMIN in the init user ns.

This roughly allows a privileged user to mount on behalf of an unprivileged
usernamespace, by forking off and calling fsopen in the unprivileged user
namespace. It can then pass back that fsfd to the privileged process which
can configure the NFS mount, and then it can call FSCONFIG_CMD_CREATE
before switching back into the mount namespace of the container, and finish
up the mounting process and call fsmount and move_mount.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 fs/nfs/client.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 4b8cc93913f7..c3afe448a512 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -571,7 +571,7 @@ static int nfs_start_lockd(struct nfs_server *server)
 					1 : 0,
 		.net		= clp->cl_net,
 		.nlmclnt_ops 	= clp->cl_nfs_mod->rpc_ops->nlmclnt_ops,
-		.cred		= current_cred(),
+		.cred		= server->cred,
 	};
 
 	if (nlm_init.nfs_version > 3)
@@ -985,7 +985,13 @@ struct nfs_server *nfs_create_server(struct fs_context *fc)
 	if (!server)
 		return ERR_PTR(-ENOMEM);
 
-	server->cred = get_cred(current_cred());
+	if (fc->cred->user_ns != &init_user_ns)
+		dprintk("%s: Using creds from non-init userns\n", __func__);
+	else if (fc->cred != current_cred())
+		dprintk("%s: Using creds from fs_context which are different than current_creds\n",
+			__func__);
+
+	server->cred = get_cred(fc->cred);
 
 	error = -ENOMEM;
 	fattr = nfs_alloc_fattr();
-- 
2.25.1

