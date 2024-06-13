Return-Path: <linux-nfs+bounces-3787-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F33A3907B98
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 20:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACCA21C244B5
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 18:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE06157A7D;
	Thu, 13 Jun 2024 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTVcaRah"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C5B157A67;
	Thu, 13 Jun 2024 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303689; cv=none; b=tSgEHs7jWnoLcoqy6lbSsHt/Dy62vvCLTl3PhOGga82bMFYR7xpofMNbYLTUGppKaOFeIPSmAvYligBnzjg1LXyv3NddUVwEDce1X1godHZdB2jJLfSm4jTrjhXl/96NFljybCnDvhGEi2xsVKgv+4qVyiKGK76pqGts9jaOEvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303689; c=relaxed/simple;
	bh=oX0aSIaCfteVOGpAmr3SzPKXQ5QA4Z30qQIYP9WNXxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bi/euwN1CdSgBaoz70o83o2fx5zruw7UKAZcFer8tfkqO8KWFJXeUzUenNEhl2EgMN8dWRmxe3sxJWYY7DNcYoYl/RPbkCkeev4JyCRdT4RQUWX2FCH7Zf3s3pvlzoUu5KoKfMYsxMSfYsGB4TmUOxtQdPQ+ezJ9C5lNZD2AygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTVcaRah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB0EC32786;
	Thu, 13 Jun 2024 18:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718303688;
	bh=oX0aSIaCfteVOGpAmr3SzPKXQ5QA4Z30qQIYP9WNXxc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uTVcaRahEg2tE9VBEHrzfwpmILUjcrDidXqhkiJkGfCCnyxFPbGdRo/s7Jp+31dCw
	 Wv5K691gHOhrWTv9VGJBuqIXgU324AqTndTtg/DNoPIIjAWKvXh7Gb6cif1JPDew+y
	 I5x8yzfNaH8hpdb/kBHJjIJYwQcXWoU+UtxbftFFSbAfRChbly4apvnXn9nNiLv7om
	 noFEIT5Z54pTtthRB6kFXODiDFh5xQH4agM+1Fh792WlbjU/+ittFzT91+6AvyMofX
	 vh4cK69SSGQaHLHP6CoMV4aAsptxpcEhhjsTI0Zt1+ww/opE/STQFYkwLpLY9Yeizi
	 xmt8TBheSABVA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 13 Jun 2024 14:34:34 -0400
Subject: [PATCH v3 5/5] nfsd: new netlink ops to get/set server pool_mode
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-nfsd-next-v3-5-3b51c3c2fc59@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5880; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=oX0aSIaCfteVOGpAmr3SzPKXQ5QA4Z30qQIYP9WNXxc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmazu/MC2tOxfyvdCSWTHgtLgWwt3ZXJAKwPWiu
 fh/wg6t3qqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZms7vwAKCRAADmhBGVaC
 FSrTEACH81IKDS1zk4sOr9sRw+nvBJg55vz8c/7lQ71MBOLBWhU3zIfM/Ih9OQvV3u+HhtOxg/u
 gx5i8DhbD8Gz6PEWCvOM7SGpMcHEtxCEZXdsocD1RxryA1BkbCvWiYZEIfMvmDtB2suS28NCEfA
 WHPLwNiB7zRTuJdlAED4RCHvwMCOJEUzrVjS5g/JWhjsjaVHaiPTc8yAbGalM877viqWsn6/lH8
 SX1YuDBMo+Xm7MTrf+T3l0Sb1X0ra2408pVaS4LWNiGXZAVhCIsa6jPkHG7VXq83+Y0MMLINN/y
 9TrP6nbNymqS9tI7SvypJUBOea6AoG1cOesKr8Lr+zJi/92vecm+W/cIbTYDcMfN046cKI3mVqO
 bpp7cfs/Tl9tRaUcK3BtNtOlv2pGM6FMYn7TjtSmtDuziLu5VC7MwlCbC3/3iFI+Srye7wgfrG0
 JdHQrpWMFqLX/w0KIWzYgIMZXf7nV68rPWwDSSdijuKecmwVkgdryYWpPgKMnplS6QoQsIIy7vj
 ra8KUuWE+y3AO/czKwFWDh+obuejsQCQjAVEml/tRhwUae9P01lZcfx9JZ16OFDOLiT8jO6tURI
 EjOP5knWdcSVi13+oVCDU9Laa7z+6pD2tC8bHXBeB3AiPFPvtQu5/w710/flfQAPpAFr10Tekww
 VVfP6AvUpWzoMRQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml | 27 ++++++++++++++++
 fs/nfsd/netlink.c                     | 17 ++++++++++
 fs/nfsd/netlink.h                     |  2 ++
 fs/nfsd/nfsctl.c                      | 58 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     | 10 ++++++
 5 files changed, 114 insertions(+)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index d21234097167..5a98e5a06c68 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -115,6 +115,15 @@ attribute-sets:
         type: nest
         nested-attributes: sock
         multi-attr: true
+  -
+    name: pool-mode
+    attributes:
+      -
+        name: mode
+        type: string
+      -
+        name: npools
+        type: u32
 
 operations:
   list:
@@ -197,3 +206,21 @@ operations:
         reply:
           attributes:
             - addr
+    -
+      name: pool-mode-set
+      doc: set the current server pool-mode
+      attribute-set: pool-mode
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - mode
+    -
+      name: pool-mode-get
+      doc: get info about server pool-mode
+      attribute-set: pool-mode
+      do:
+        reply:
+          attributes:
+            - mode
+            - npools
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 62d2586d9902..137701153c9e 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -40,6 +40,11 @@ static const struct nla_policy nfsd_listener_set_nl_policy[NFSD_A_SERVER_SOCK_AD
 	[NFSD_A_SERVER_SOCK_ADDR] = NLA_POLICY_NESTED(nfsd_sock_nl_policy),
 };
 
+/* NFSD_CMD_POOL_MODE_SET - do */
+static const struct nla_policy nfsd_pool_mode_set_nl_policy[NFSD_A_POOL_MODE_MODE + 1] = {
+	[NFSD_A_POOL_MODE_MODE] = { .type = NLA_NUL_STRING, },
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -85,6 +90,18 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.doit	= nfsd_nl_listener_get_doit,
 		.flags	= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NFSD_CMD_POOL_MODE_SET,
+		.doit		= nfsd_nl_pool_mode_set_doit,
+		.policy		= nfsd_pool_mode_set_nl_policy,
+		.maxattr	= NFSD_A_POOL_MODE_MODE,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= NFSD_CMD_POOL_MODE_GET,
+		.doit	= nfsd_nl_pool_mode_get_doit,
+		.flags	= GENL_CMD_CAP_DO,
+	},
 };
 
 struct genl_family nfsd_nl_family __ro_after_init = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index e3724637d64d..9459547de04e 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -26,6 +26,8 @@ int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_pool_mode_set_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info);
 
 extern struct genl_family nfsd_nl_family;
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index dde42aad5582..187e9be77b78 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2182,6 +2182,64 @@ int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/**
+ * nfsd_nl_pool_mode_set_doit - set the number of running threads
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Return 0 on success or a negative errno.
+ */
+int nfsd_nl_pool_mode_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	const struct nlattr *attr;
+
+	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_POOL_MODE_MODE))
+		return -EINVAL;
+
+	attr = info->attrs[NFSD_A_POOL_MODE_MODE];
+	return sunrpc_set_pool_mode(nla_data(attr));
+}
+
+/**
+ * nfsd_nl_pool_mode_get_doit - get info about pool_mode
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Return 0 on success or a negative errno.
+ */
+int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	char buf[16];
+	void *hdr;
+	int err;
+
+	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	err = -EMSGSIZE;
+	hdr = genlmsg_iput(skb, info);
+	if (!hdr)
+		goto err_free_msg;
+
+	err = -ERANGE;
+	if (sunrpc_get_pool_mode(buf, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
+		goto err_free_msg;
+
+	err = nla_put_string(skb, NFSD_A_POOL_MODE_MODE, buf) ||
+	      nla_put_u32(skb, NFSD_A_POOL_MODE_NPOOLS, nfsd_nrpools(net));
+	if (err)
+		goto err_free_msg;
+
+	genlmsg_end(skb, hdr);
+	return genlmsg_reply(skb, info);
+
+err_free_msg:
+	nlmsg_free(skb);
+	return err;
+}
+
 /**
  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
  * @net: a freshly-created network namespace
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index 24c86dbc7ed5..887cbd12b695 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -70,6 +70,14 @@ enum {
 	NFSD_A_SERVER_SOCK_MAX = (__NFSD_A_SERVER_SOCK_MAX - 1)
 };
 
+enum {
+	NFSD_A_POOL_MODE_MODE = 1,
+	NFSD_A_POOL_MODE_NPOOLS,
+
+	__NFSD_A_POOL_MODE_MAX,
+	NFSD_A_POOL_MODE_MAX = (__NFSD_A_POOL_MODE_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
 	NFSD_CMD_THREADS_SET,
@@ -78,6 +86,8 @@ enum {
 	NFSD_CMD_VERSION_GET,
 	NFSD_CMD_LISTENER_SET,
 	NFSD_CMD_LISTENER_GET,
+	NFSD_CMD_POOL_MODE_SET,
+	NFSD_CMD_POOL_MODE_GET,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)

-- 
2.45.2


