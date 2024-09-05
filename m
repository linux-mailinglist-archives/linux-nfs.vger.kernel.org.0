Return-Path: <linux-nfs+bounces-6271-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D8F96E2D2
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 21:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CF78B25D96
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 19:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F3F19307F;
	Thu,  5 Sep 2024 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6Uv6oHq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB20192D67
	for <linux-nfs@vger.kernel.org>; Thu,  5 Sep 2024 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563429; cv=none; b=Grkd8d3KA2/qSpxeFPE0RJBCBPvh/QJK2Vop/WrDHpSw7qacvS0gqelJByXBXmbyDFecknoNFSgdGlidyDw5eSMCJRHjEE4i9aIySV+yF36KClLFB4rGHfu9Uf+lRXY3zdyPeXsx3VDbcwZuHRdlJAC97Y5zM+owInPnQbkYIcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563429; c=relaxed/simple;
	bh=ZnBUJMvIl6K36j7Td/qZmqvGMMP9p+j21OE7Alw9ttU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m30n8afzB9Bnsv/frY29wrpNMyYx3K8jsjJqb1L3th3k7Yl2z0KRmVobrBN/NAq5ZAqhsOIOLDpYYTG1jBgQiLdeh+Vbgf8l8sKikh0LWbDHOssvEzcLbfdzz9/+lvVnUWzyiWCBMWMhWWYH0LELZBTblT6diN0SBSRcM8bO360=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6Uv6oHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8CEC4CEC3;
	Thu,  5 Sep 2024 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725563429;
	bh=ZnBUJMvIl6K36j7Td/qZmqvGMMP9p+j21OE7Alw9ttU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6Uv6oHqCjbZE6VFRvRFyGocmOAARzqb9O+fd+9kz7f6Lgam56sPk9hJ8JP5tWtVb
	 N2NWutb729l0KOzXc9IlsVa6OE7nQyGvyE+VlEVncckzIxVmS0c0iK1jmtLSfXPKuU
	 1pDacxhjTHfyxnSD0j99XgeUT7ESl61NHc+tzSyOxl/NGAkrBB7l1VOHqu1/gb1esN
	 McoDdFBGt7SyxO/wqpzSvXscAIZvn5OZDRq94gMmjcH9RnmeDZUxH++UF56CwKQFcv
	 OcrJUHRuIbCnWwXTJYZaYPbTI7skfKcPrgKd3BJo4vL40RBOpcICJ0IihMI45oAg8e
	 PmBQuybJtVikg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>
Subject: [PATCH v16 12/26] SUNRPC: add svcauth_map_clnt_to_svc_cred_local
Date: Thu,  5 Sep 2024 15:09:46 -0400
Message-ID: <20240905191011.41650-13-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240905191011.41650-1-snitzer@kernel.org>
References: <20240905191011.41650-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weston Andros Adamson <dros@primarydata.com>

Add new funtion svcauth_map_clnt_to_svc_cred_local which maps a
generic cred to a svc_cred suitable for use in nfsd.

This is needed by the localio code to map nfs client creds to nfs
server credentials.

Following from net/sunrpc/auth_unix.c:unx_marshal() it is clear that
->fsuid and ->fsgid must be used (rather than ->uid and ->gid).  In
addition, these uid and gid must be translated with from_kuid_munged()
so local client uses correct uid and gid when acting as local server.

Jeff Layton noted:
  This is where the magic happens. Since we're working in
  kuid_t/kgid_t, we don't need to worry about further idmapping.

Suggested-by: NeilBrown <neilb@suse.de> # to approximate unx_marshal()
Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svcauth.h |  5 +++++
 net/sunrpc/svcauth.c           | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svcauth.h
index 63cf6fb26dcc..2e111153f7cd 100644
--- a/include/linux/sunrpc/svcauth.h
+++ b/include/linux/sunrpc/svcauth.h
@@ -14,6 +14,7 @@
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/sunrpc/cache.h>
 #include <linux/sunrpc/gss_api.h>
+#include <linux/sunrpc/clnt.h>
 #include <linux/hash.h>
 #include <linux/stringhash.h>
 #include <linux/cred.h>
@@ -157,6 +158,10 @@ extern enum svc_auth_status svc_set_client(struct svc_rqst *rqstp);
 extern int	svc_auth_register(rpc_authflavor_t flavor, struct auth_ops *aops);
 extern void	svc_auth_unregister(rpc_authflavor_t flavor);
 
+extern void	svcauth_map_clnt_to_svc_cred_local(struct rpc_clnt *clnt,
+						   const struct cred *,
+						   struct svc_cred *);
+
 extern struct auth_domain *unix_domain_find(char *name);
 extern void auth_domain_put(struct auth_domain *item);
 extern struct auth_domain *auth_domain_lookup(char *name, struct auth_domain *new);
diff --git a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
index 93d9e949e265..55b4d2874188 100644
--- a/net/sunrpc/svcauth.c
+++ b/net/sunrpc/svcauth.c
@@ -18,6 +18,7 @@
 #include <linux/sunrpc/svcauth.h>
 #include <linux/err.h>
 #include <linux/hash.h>
+#include <linux/user_namespace.h>
 
 #include <trace/events/sunrpc.h>
 
@@ -175,6 +176,33 @@ rpc_authflavor_t svc_auth_flavor(struct svc_rqst *rqstp)
 }
 EXPORT_SYMBOL_GPL(svc_auth_flavor);
 
+/**
+ * svcauth_map_clnt_to_svc_cred_local - maps a generic cred
+ * to a svc_cred suitable for use in nfsd.
+ * @clnt: rpc_clnt associated with nfs client
+ * @cred: generic cred associated with nfs client
+ * @svc: returned svc_cred that is suitable for use in nfsd
+ */
+void svcauth_map_clnt_to_svc_cred_local(struct rpc_clnt *clnt,
+					const struct cred *cred,
+					struct svc_cred *svc)
+{
+	struct user_namespace *userns = clnt->cl_cred ?
+		clnt->cl_cred->user_ns : &init_user_ns;
+
+	memset(svc, 0, sizeof(struct svc_cred));
+
+	svc->cr_uid = KUIDT_INIT(from_kuid_munged(userns, cred->fsuid));
+	svc->cr_gid = KGIDT_INIT(from_kgid_munged(userns, cred->fsgid));
+	svc->cr_flavor = clnt->cl_auth->au_flavor;
+	if (cred->group_info)
+		svc->cr_group_info = get_group_info(cred->group_info);
+	/* These aren't relevant for local (network is bypassed) */
+	svc->cr_principal = NULL;
+	svc->cr_gss_mech = NULL;
+}
+EXPORT_SYMBOL_GPL(svcauth_map_clnt_to_svc_cred_local);
+
 /**************************************************
  * 'auth_domains' are stored in a hash table indexed by name.
  * When the last reference to an 'auth_domain' is dropped,
-- 
2.44.0


