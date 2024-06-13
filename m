Return-Path: <linux-nfs+bounces-3757-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2133B906F7A
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 14:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279921C219B0
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 12:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10BF1482E6;
	Thu, 13 Jun 2024 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQ/AS1B3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869D31482E2;
	Thu, 13 Jun 2024 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281022; cv=none; b=jxBB0hr73j6MXpd0B8y4k1sU3Me6gc8xbddwoq9VJ3BzpgmTP5yiWPo5xZjJ7XV6WCh8Qax54eiCmtlbgOM1XOLSbzDrZeHuuYMTq9VRU0ZchY5aQy43AttYHCDtJoUTWEbIw/2viosvtouaBCJiM/1nyozTs/cfJ9jDIlulF5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281022; c=relaxed/simple;
	bh=oQa4zv0vPWkoBLtVhYd1+5aYyJOZB4t+WY3wqD7rvGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P/1bAjd5cxFNi8Bl9U5NihRqqlMHWYbF3FP2loRZZ1HB7g3YtjFEychfZm8N2EebQuJQdils2qMHCgSbPSS1W7BJ+N1+8NHLUFRH59xWbSaoV2w+hGtHSA6CrH+oh8TaUINBg8Xzspq16aKhRfG8FcRYIF/hofE7IOthM2HfmP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQ/AS1B3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2823C4AF1A;
	Thu, 13 Jun 2024 12:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718281022;
	bh=oQa4zv0vPWkoBLtVhYd1+5aYyJOZB4t+WY3wqD7rvGo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dQ/AS1B3T0oYJ3KT4/+lkG2SMTYgdP/rzkaPl/09ERntfpVebCPDy2Lxd+/ILqYyl
	 GxlbKIzGN8oWxOrcs2UlRub+GbZ0Tmwb46vJlyvzPuPM/N7Z5HR2rvrFESK6Gdqsz2
	 DW0JRCDah09ld8KpCG/ZvTt1cuhEXwQBmwooCxT3NjDNhSez/4AvZuq78016cGS1l3
	 5jWfbByDLE80nq3t7kKCtsMRbvB/0/Gdc52pXtN/gGhTl7V+Bt/SXOf302ZDiOxneC
	 7UBLipUfwlp0N8bbXj1Q/A/4t23ha9jyko5O/z62kqfRXdP3rNhrnSYVAr5wsKeWh9
	 iEHbjD6fazfFA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 13 Jun 2024 08:16:41 -0400
Subject: [PATCH v2 4/5] sunrpc: refactor pool_mode setting code
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-nfsd-next-v2-4-20bf690d65fb@kernel.org>
References: <20240613-nfsd-next-v2-0-20bf690d65fb@kernel.org>
In-Reply-To: <20240613-nfsd-next-v2-0-20bf690d65fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3838; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=oQa4zv0vPWkoBLtVhYd1+5aYyJOZB4t+WY3wqD7rvGo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmauM2y6Zdb8VyU3ELCC4Ia9NVavrCjNWWi0dxP
 86W0aTGHFOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZmrjNgAKCRAADmhBGVaC
 Fb25EADSvAS1O44JfgV27YDzQzkp8WeJ0jGQALwqrFAsDB6T1Zqz9AtA4tkHbPSz9ZeHPkE0GWe
 3JA1pImSMkAdQOtZBjltEyOl0j/mnT5DbtxnTDNGF/TEhJvtVZrc8ereY+JSMumRUFCqEXB0Apx
 ufQTUeTlRnV+rUh605mIx8F5BYPJ2zqHWXbdCxNb52UAhRGEOBtCcKQS3RUH1sxWNUqwrc9uFUy
 lC9e0Rm4Zc6n0cOaKl10s13CE5q7csqFtrBngXlqy/i3Ud3RIamAYG7ziAOuMVW1qUNMgmRtqfB
 J4As8CWwLRoUfAAOQLDrxXmqLY+iScH+g1A6tJzJBThjeP+t/U/1JELChMYjYDMfQNO0u02asal
 wK65H7OU+v+4tWJ8YUnIa6LnJeQ6BWKhEmCuMdYi6l5MeSZ4Pz2uYuLVKi1v1mN3RdZ9/DwTq43
 EBAuzqyvrJIyyYDRwVpUpmiauvNqmKbVwRflwdncpQVUtCMNTUTncpnMdYs0KFdlppva+NB7NEn
 ngeijMNoZmdPlPjX1S3UWhp9n3PyHVYUW5Dlb67KQFgbwj3ki4QgkfEJJsKNjVaJxpSdhc2Zf00
 iwfxY0vGlxmRLZDhYnBG7c4yzjdH76PDT4M76kHgJtCF9Wiled4V6WQ1OuW+j+9clDmFM3sklvn
 pB/8EYhdaYC1ATw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Allow the pool_mode setting code to be called from internal callers
so we can call it from a new netlink op.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/svc.h |  2 ++
 net/sunrpc/svc.c           | 76 +++++++++++++++++++++++++++++++++-------------
 2 files changed, 57 insertions(+), 21 deletions(-)

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
index f80d94cbb8b1..6806868b3129 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -72,57 +72,91 @@ static struct svc_pool_map svc_pool_map = {
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
 {
-	int *ip = (int *)kp->arg;
+	struct svc_pool_map *m = kp->arg;
 
-	switch (*ip)
+	return __param_set_pool_mode(val, m);
+}
+
+int sunrpc_set_pool_mode(const char *val)
+{
+	return __param_set_pool_mode(val, &svc_pool_map);
+}
+EXPORT_SYMBOL(sunrpc_set_pool_mode);
+
+int
+sunrpc_get_pool_mode(char *buf, size_t size)
+{
+	struct svc_pool_map *m = &svc_pool_map;
+
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


