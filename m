Return-Path: <linux-nfs+bounces-3786-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA426907B94
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 20:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7851C24320
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 18:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EA2156653;
	Thu, 13 Jun 2024 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBOa39lV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1CC156257;
	Thu, 13 Jun 2024 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303687; cv=none; b=QBSCXyg1bod6I5g+hdYDh3LKjzp5+XxqmRHLmbjN6vPVYOp7OuXD3p2xzwWh63bJ4vke8yNx33x3XcAzba43QmZ+ECYdfLYKknrTNcQsawfR4qa4RAzhITd6iYVH1O7rUrnI2iY1JkAIhI0EG3ING2DCvF52Y/wFS6G5lPl0ENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303687; c=relaxed/simple;
	bh=5pnQH8utNOC4XYM7FgM/OzSZhJOaeE1L632BBMj8Y9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BkAC0pNMLLPaXwIKzfCzEUa+AXfdXZa+w5F67EnI+vx4H2nks8HGT7UaBWHH0A4UBFwwNPZP0NNTwM2aHz6K3BoYvVxPCm13cUa1b8ehvgcr/Y+6iVC6aZRb4Cm2xPJQ0uOBxLHQlaagJR1oKiDgG2sDaQA30rT/6clmvNV7hsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBOa39lV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF76FC32789;
	Thu, 13 Jun 2024 18:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718303687;
	bh=5pnQH8utNOC4XYM7FgM/OzSZhJOaeE1L632BBMj8Y9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eBOa39lVdgUa1cQ7sZ+ROgH7j7VE+zuCEXWegFvkOMnIXutOQlVvAv6jFXy/2OKcs
	 HBubddH8RZi+Ftww0EtGDAGulx+EwHY6WErxxzYcRi7WkV3eUO1M/pkEom6x4SbghL
	 ZiF/S+Iyn8Dw/TKFMWaOF/ehQczpuvVsnsjzgOYOjdPChUGXHvhQELWF2XLIW79DaP
	 Sa7gAAdkyeNm41OG3vTY14wxhjDBnH4p/7jNKck/cwqsN6CGRoxwywvKjAXHBbRLiN
	 94fchKHfoXuL0GLuh98SzasKhXmLfkiH23fK/yy6Mpaksc1xJIbu0tQvjBBYF5j4Bt
	 uWX16Sd16XuGQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 13 Jun 2024 14:34:33 -0400
Subject: [PATCH v3 4/5] sunrpc: refactor pool_mode setting code
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-nfsd-next-v3-4-3b51c3c2fc59@kernel.org>
References: <20240613-nfsd-next-v3-0-3b51c3c2fc59@kernel.org>
In-Reply-To: <20240613-nfsd-next-v3-0-3b51c3c2fc59@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4325; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5pnQH8utNOC4XYM7FgM/OzSZhJOaeE1L632BBMj8Y9Y=;
 b=kA0DAAgBAA5oQRlWghUByyZiAGZrO7+iP03g8DDP7hiyAZXpIdDiLq6l1pv4z2DknHbV+ANk4
 4kCMwQAAQgAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJmazu/AAoJEAAOaEEZVoIVjKcP/0xj
 ewFA+3+/wAwzj7GPhOAaeoOgoGDuAE8eqZjCqFU8ty8JfMhHY5Z28tAuEycUUqa+lZPD5F1rvWs
 LuGdg41b9+RNU3v7BKGTPAKVOvMh2d+D6rU3ebSzztEgTT7HEpel+2LkKektZphau4zihsEkZ8b
 4gXFmnWHeCJQ76rs7Le/QeXGVEdZr5hjcHRa1rMe86VQ/2W9PmuVJyqsc4Raqwk6jaLG7r3IKMy
 BgmemVZlkdxNTp1bsfiNV1eziem6nBZbHFs8ha8LT4IWmfVgTQECIMqlF10cfPDc/V87OHrAymK
 1ypWh/TKPmLiN8Y2k2dw6tOzUMozC9sm5snVSxA0L1STr2l4NWSv06vy6sIEDoYgmhrLmFWeSJ6
 Ck7RamGdB9t5zmJdMsffuL+VcCIY13UaYw9NGuOU+NDx7vERNlgImI6GOOkPqeGWKESjABDzZJN
 GLSpfO62CZgZDeF+7X691FH4+r/Zar2eoZGBcriBuUM+kLO2SZ3aabKco36ZOF/MqKyu4knztkK
 WdbTFwNoX3UugK9DS/EInSue0ufE2/J/b/xjrPWUzXJXmx23fWLj4UdvgKkvk5sWT0gp+BJuReh
 2uNln7DlJGAzTxDUaeZbQt4zMyfKYNAGiTiEwlc7CIhjkHGLrj00IVVYc3UF2eQ3ibyXjzKIydq
 h9p2Q
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Allow the pool_mode setting code to be called from internal callers
so we can call it from a new netlink op. Add a new svc_pool_map_get
function to return the current setting. Change the existing module
parameter handling to use the new interfaces under the hood.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/svc.h |  2 ++
 net/sunrpc/svc.c           | 85 ++++++++++++++++++++++++++++++++++------------
 2 files changed, 66 insertions(+), 21 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index d0433e1642b3..a7d0406b9ef5 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -399,6 +399,8 @@ struct svc_procedure {
 /*
  * Function prototypes.
  */
+int sunrpc_set_pool_mode(const char *val);
+int sunrpc_get_pool_mode(char *val, size_t size);
 int svc_rpcb_setup(struct svc_serv *serv, struct net *net);
 void svc_rpcb_cleanup(struct svc_serv *serv, struct net *net);
 int svc_bind(struct svc_serv *serv, struct net *net);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index f80d94cbb8b1..965a27806bfd 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -72,57 +72,100 @@ static struct svc_pool_map svc_pool_map = {
 static DEFINE_MUTEX(svc_pool_map_mutex);/* protects svc_pool_map.count only */
 
 static int
-param_set_pool_mode(const char *val, const struct kernel_param *kp)
+__param_set_pool_mode(const char *val, struct svc_pool_map *m)
 {
-	int *ip = (int *)kp->arg;
-	struct svc_pool_map *m = &svc_pool_map;
-	int err;
+	int err, mode;
 
 	mutex_lock(&svc_pool_map_mutex);
 
-	err = -EBUSY;
-	if (m->count)
-		goto out;
-
 	err = 0;
 	if (!strncmp(val, "auto", 4))
-		*ip = SVC_POOL_AUTO;
+		mode = SVC_POOL_AUTO;
 	else if (!strncmp(val, "global", 6))
-		*ip = SVC_POOL_GLOBAL;
+		mode = SVC_POOL_GLOBAL;
 	else if (!strncmp(val, "percpu", 6))
-		*ip = SVC_POOL_PERCPU;
+		mode = SVC_POOL_PERCPU;
 	else if (!strncmp(val, "pernode", 7))
-		*ip = SVC_POOL_PERNODE;
+		mode = SVC_POOL_PERNODE;
 	else
 		err = -EINVAL;
 
+	if (err)
+		goto out;
+
+	if (m->count == 0)
+		m->mode = mode;
+	else if (mode != m->mode)
+		err = -EBUSY;
 out:
 	mutex_unlock(&svc_pool_map_mutex);
 	return err;
 }
 
 static int
-param_get_pool_mode(char *buf, const struct kernel_param *kp)
+param_set_pool_mode(const char *val, const struct kernel_param *kp)
+{
+	struct svc_pool_map *m = kp->arg;
+
+	return __param_set_pool_mode(val, m);
+}
+
+int sunrpc_set_pool_mode(const char *val)
+{
+	return __param_set_pool_mode(val, &svc_pool_map);
+}
+EXPORT_SYMBOL(sunrpc_set_pool_mode);
+
+/**
+ * sunrpc_get_pool_mode - get the current pool_mode for the host
+ * @buf: where to write the current pool_mode
+ * @size: size of @buf
+ *
+ * Grab the current pool_mode from the svc_pool_map and write
+ * the resulting string to @buf. Returns the number of characters
+ * written to @buf (a'la snprintf()).
+ */
+int
+sunrpc_get_pool_mode(char *buf, size_t size)
 {
-	int *ip = (int *)kp->arg;
+	struct svc_pool_map *m = &svc_pool_map;
 
-	switch (*ip)
+	switch (m->mode)
 	{
 	case SVC_POOL_AUTO:
-		return sysfs_emit(buf, "auto\n");
+		return snprintf(buf, size, "auto");
 	case SVC_POOL_GLOBAL:
-		return sysfs_emit(buf, "global\n");
+		return snprintf(buf, size, "global");
 	case SVC_POOL_PERCPU:
-		return sysfs_emit(buf, "percpu\n");
+		return snprintf(buf, size, "percpu");
 	case SVC_POOL_PERNODE:
-		return sysfs_emit(buf, "pernode\n");
+		return snprintf(buf, size, "pernode");
 	default:
-		return sysfs_emit(buf, "%d\n", *ip);
+		return snprintf(buf, size, "%d", m->mode);
 	}
 }
+EXPORT_SYMBOL(sunrpc_get_pool_mode);
+
+static int
+param_get_pool_mode(char *buf, const struct kernel_param *kp)
+{
+	char str[16];
+	int len;
+
+	len = sunrpc_get_pool_mode(str, ARRAY_SIZE(str));
+
+	/* Ensure we have room for newline and NUL */
+	len = min_t(int, len, ARRAY_SIZE(str) - 2);
+
+	/* tack on the newline */
+	str[len] = '\n';
+	str[len + 1] = '\0';
+
+	return sysfs_emit(buf, str);
+}
 
 module_param_call(pool_mode, param_set_pool_mode, param_get_pool_mode,
-		 &svc_pool_map.mode, 0644);
+		  &svc_pool_map, 0644);
 
 /*
  * Detect best pool mapping mode heuristically,

-- 
2.45.2


