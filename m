Return-Path: <linux-nfs+bounces-2953-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A960F8AE818
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 15:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3131C22DB1
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 13:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE09136667;
	Tue, 23 Apr 2024 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+Q2LE0z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5621613541A;
	Tue, 23 Apr 2024 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878780; cv=none; b=ZCP+eCPekxfvjn8dWxPgGDbfV0wPVvnVGO/4V1YzfveDKzZrKSOap6LIABRUyA0jjAU4Gl4f6SIkaEAQsXPQG6UzpG6nIJaxR9Vl0Gs0KmwxkcQcm06+dQrN9cHuUE4180YE8lGBKIkWrhupLaWlIIhW+a4MPI+I6Uj8cGTvscE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878780; c=relaxed/simple;
	bh=u1MIVeEB9jfAKl7VCceRlD6fHf4D2LjW0+JisF5Qw84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmBlDz4zPv84/Lbkfcwivrlkp4RDc1xM4byLe64y9cZ2YI4E2tbh+y8XTb1Rn86OMbquD1T5Hfr5mDXe6gz5GKHO0nELTR8gcp0LHMfwJltqu6FMaqnt8SEPezCRwts2uC0ILOk6kx5rrEHkX8YuTsj4oAvmuTXuzPHWchRVlFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+Q2LE0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69A5C116B1;
	Tue, 23 Apr 2024 13:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713878780;
	bh=u1MIVeEB9jfAKl7VCceRlD6fHf4D2LjW0+JisF5Qw84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+Q2LE0zsowboGRIIXDhD7KAEugaYFBPN6zgwZ1YQEGoMXldo0zCl4FEokQw30l0J
	 PLVUzlItMNvdfmFpp+ODbty25520WiiSynfBtPjltOvMPa+2s9GPJzY3wApFDDAsmT
	 FtTYh1xy8KSZ1uVQJB3Fv6HtGm8EG8dURJNHm+xtV18hJ85Qj8D4DxWxtbr4fndzSy
	 GBFdCy537Vx05KWVTV9dxr5GJ+mCO8PwJhvwZtLEDLuxMQYc4knjdZWKf9eLLqevFQ
	 UaUvDM2O1rnN1mLTnqGGH5AyGYpIV9XRx8TzH8m7nzelcrlmuncZ9mrAwDXeqwPBPt
	 X5k5P/MD1dwBA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: neilb@suse.de,
	lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	jlayton@kernel.org
Subject: [PATCH v9 6/7] SUNRPC: add a new svc_find_listener helper
Date: Tue, 23 Apr 2024 15:25:43 +0200
Message-ID: <dc79eb8cdba77f5d65e131720626143b1614c7e3.1713878413.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713878413.git.lorenzo@kernel.org>
References: <cover.1713878413.git.lorenzo@kernel.org>
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


