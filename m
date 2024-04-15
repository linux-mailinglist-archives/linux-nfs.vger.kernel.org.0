Return-Path: <linux-nfs+bounces-2825-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3358A5B8E
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 21:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5E61C21EC9
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 19:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F3115CD44;
	Mon, 15 Apr 2024 19:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uL1Qbw7D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A16156997;
	Mon, 15 Apr 2024 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210326; cv=none; b=H5PXCkLj+KsmVrBATsPBJpMB0AuINZJku8FPHUaZnvK5waUV6LuXkav5+CTrBhzqYpviF5OeGhxycTRv+IOS3XH4Yk6ecUItPqcWnHDYtJdWLth+KHDGdXqA2FXY2Y/8cZy9uBxXtnLXbS6CIVLT31/YB5UPIgGHvBph4IK08FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210326; c=relaxed/simple;
	bh=u1MIVeEB9jfAKl7VCceRlD6fHf4D2LjW0+JisF5Qw84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F66ieZmnDgic+dia3BOaKpQUFVhDkot4znxIgNm0tBu/CMcixI2xuIaTu0JP/us80glBdf3dyw6xI7LLEamv1YM6KpOuKAhU9/z5OB9DtXRMbUMnd6OCa2R3oFDBmIxlldeUYZqbUJlmm+cc4Fp8mFeBmjKGiuseQPmt2u7ACAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uL1Qbw7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498B4C113CC;
	Mon, 15 Apr 2024 19:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713210325;
	bh=u1MIVeEB9jfAKl7VCceRlD6fHf4D2LjW0+JisF5Qw84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uL1Qbw7D1Ia+IrOBHTci395fidsVWuJjfGeonpHEzyZ3NRvrMEjcArQ+Zcmt8Mndj
	 dnOUpe1dGyejwQNj5FkJ/9HXWovplf8YNvrqvLNLpurnHOA9THB6vChlY8+58tiT7D
	 FPcTDbFIF7q86zljCqIXy8qF73S7Z9beeldMo8IG8jDfwIRAq5GYWMDnXS7yYe81X1
	 LDsrIRuMKxzmOi4M/7jS+CAGNCP7aBTuQz18u+7cCaD5K8cve4xSVbkVgdIxYRG81S
	 JtXrarU1mVpJCjfcRuvJVq8efITN4x+0HCiQxDIPoTrB4+6xYSqdwseqcyiVndf2cR
	 LUJAQR61G5MDg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	neilb@suse.de,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	jlayton@kernel.org
Subject: [PATCH v8 5/6] SUNRPC: add a new svc_find_listener helper
Date: Mon, 15 Apr 2024 21:44:38 +0200
Message-ID: <00d60d4fb200e4d9762a03d0b561a61e92c7b071.1713209938.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713209938.git.lorenzo@kernel.org>
References: <cover.1713209938.git.lorenzo@kernel.org>
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


