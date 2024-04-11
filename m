Return-Path: <linux-nfs+bounces-2764-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0D48A1D1E
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 20:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2CB2847A7
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 18:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAE61C9ED3;
	Thu, 11 Apr 2024 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhgrSfST"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35C738DF7;
	Thu, 11 Apr 2024 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854087; cv=none; b=RVUsmE94L8LD3lpARsxq6qOZTTEYvRh6N/hg3FA+GqhzFAY4vdKeJ2HJi0tM60HGa7LZ2eluKRFvB5oTfxkdukqtUDPz3O7Ar5Gj3gQDMD2DZWtOOkdex+wOiPeooR+9+sZJjQFNb6xJajFaJs/J2R5c7N+2zfkXGsQpyfP3BFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854087; c=relaxed/simple;
	bh=u1MIVeEB9jfAKl7VCceRlD6fHf4D2LjW0+JisF5Qw84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjEWdPDEi613ffBOT9m+Ci/2YIDxB9QJ98AZfFwuQBp6SGq9vEe2xtnjZ/CWo8wTVU66t3vUrnbWhIg3HFfDztPVwHQGTDvAJiLULp+PgQYke3jcG1E/9ABz3udb1cRwh2bl6i+5ey82U81NJWGEFfmAn8nVGGD9c53LadcfKTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhgrSfST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF48C072AA;
	Thu, 11 Apr 2024 16:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712854087;
	bh=u1MIVeEB9jfAKl7VCceRlD6fHf4D2LjW0+JisF5Qw84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JhgrSfSTgNVk39AKHOHrzCWiYVjfc/zcifzETcDz/Lje4edxiRz7A+njEiokZa8Py
	 XjcgyeKDNIqlyu63lEWKvIEK52jxTzu9BI9Sb5HLojLQ9pUTwgyYJ0UvrbiNDP4hwS
	 9jozCHVbms2PRbHURlsAWq4JN8vfxsDdPRUmQh5IK3pG27fO1+0NUgrmR2VVKEUc9B
	 U/SqRJ/+6xDAKcWRcbsA8hPlFqdlssxBZ5+q3MlKZTh0V3sRPRs2el8fjv3/DT+8Sh
	 Z+k4rZelVx0PvUMCwxIy80qhSSEtbDwNw7S2ZpKGYBwgBDpHWx97itY6RRE5kKeGLM
	 yXvDnI+xRdhbA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	netdev@vger.kernel.org,
	kuba@kernel.org
Subject: [PATCH v7 4/5] SUNRPC: add a new svc_find_listener helper
Date: Thu, 11 Apr 2024 18:47:27 +0200
Message-ID: <ae559ef028fabca25407ba08c8e63e6c8c0f2916.1712853394.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712853393.git.lorenzo@kernel.org>
References: <cover.1712853393.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

svc_find_listener will return the transport instance pointer for the
endpoint accepting connections/peer traffic from the specified transport
class, and matching sockaddr.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/linux/sunrpc/svc_xprt.h |  2 ++
 net/sunrpc/svc_xprt.c           | 34 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 0d9b10dbe07d..0981e35a9fed 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -150,6 +150,8 @@ void	svc_xprt_copy_addrs(struct svc_rqst *rqstp, struct svc_xprt *xprt);
 void	svc_xprt_close(struct svc_xprt *xprt);
 int	svc_port_is_privileged(struct sockaddr *sin);
 int	svc_print_xprts(char *buf, int maxlen);
+struct svc_xprt *svc_find_listener(struct svc_serv *serv, const char *xcl_name,
+				   struct net *net, const struct sockaddr *sa);
 struct	svc_xprt *svc_find_xprt(struct svc_serv *serv, const char *xcl_name,
 			struct net *net, const sa_family_t af,
 			const unsigned short port);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 463fe544ae28..34a3626c56b1 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1276,6 +1276,40 @@ static struct svc_deferred_req *svc_deferred_dequeue(struct svc_xprt *xprt)
 	return dr;
 }
 
+/**
+ * svc_find_listener - find an RPC transport instance
+ * @serv: pointer to svc_serv to search
+ * @xcl_name: C string containing transport's class name
+ * @net: owner net pointer
+ * @sa: sockaddr containing address
+ *
+ * Return the transport instance pointer for the endpoint accepting
+ * connections/peer traffic from the specified transport class,
+ * and matching sockaddr.
+ */
+struct svc_xprt *svc_find_listener(struct svc_serv *serv, const char *xcl_name,
+				   struct net *net, const struct sockaddr *sa)
+{
+	struct svc_xprt *xprt;
+	struct svc_xprt *found = NULL;
+
+	spin_lock_bh(&serv->sv_lock);
+	list_for_each_entry(xprt, &serv->sv_permsocks, xpt_list) {
+		if (xprt->xpt_net != net)
+			continue;
+		if (strcmp(xprt->xpt_class->xcl_name, xcl_name))
+			continue;
+		if (!rpc_cmp_addr_port(sa, (struct sockaddr *)&xprt->xpt_local))
+			continue;
+		found = xprt;
+		svc_xprt_get(xprt);
+		break;
+	}
+	spin_unlock_bh(&serv->sv_lock);
+	return found;
+}
+EXPORT_SYMBOL_GPL(svc_find_listener);
+
 /**
  * svc_find_xprt - find an RPC transport instance
  * @serv: pointer to svc_serv to search
-- 
2.44.0


