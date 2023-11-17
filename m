Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146217EFB39
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 23:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjKQWOc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 17:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjKQWOb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 17:14:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AF0D4E
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 14:14:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70889C433CA
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 22:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700259268;
        bh=/jy2dlNVtF45gHuw2giQPnbKbbI+95WgTArDmH6adxQ=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=oSSdhWUr1o5gZGhGTZfhODMzomIYdvKgnUCnl0LTKvw+BBx6AVBzKHU9zMXS6h1C3
         dmX+CD0ZqDFvS5dWy9vsR/8nU75C9aUmj5PeAskoTt9faFValTptCX4ApsdmA/nj17
         HfrfzCCk2+3bsIKOb7ZSexD/Cu5n9MmYiorkZH6y5qhZIxBdNjFAG+nltokrXcQ7Va
         14/V7mWkJjfIOm0qJDjldK00Ms0ZRSq3QiF8M7F2Bokd3IVoP7CAOtbTt0/d3TZQda
         TvqARajRWm502jcoLNegc/la5iuhFHGVkMGXV6fJau005K/ybp7jXP866o+WOEJm0I
         NpjBLCH5PkBOA==
Subject: [PATCH v2 1/4] SUNRPC: Add a server-side API for retrieving an RPC's
 pseudoflavor
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 17 Nov 2023 17:14:27 -0500
Message-ID: <170025926738.4577.11486458886663210137.stgit@bazille.1015granger.net>
In-Reply-To: <170025895725.4577.18051288602708688381.stgit@bazille.1015granger.net>
References: <170025895725.4577.18051288602708688381.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

NFSD will use this new API to determine whether nfsd_splice_read is
safe to use. This avoids the need to add a dependency to NFSD for
CONFIG_SUNRPC_GSS.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svcauth.h    |    7 ++++++-
 net/sunrpc/auth_gss/svcauth_gss.c |    6 ++++++
 net/sunrpc/svcauth.c              |   16 ++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svcauth.h
index 6f90203edbf8..61c455f1e1f5 100644
--- a/include/linux/sunrpc/svcauth.h
+++ b/include/linux/sunrpc/svcauth.h
@@ -131,8 +131,11 @@ enum svc_auth_status {
  *   This call releases a domain.
  *
  * set_client()
- *   Givens a pending request (struct svc_rqst), finds and assigns
+ *   Given a pending request (struct svc_rqst), finds and assigns
  *   an appropriate 'auth_domain' as the client.
+ *
+ * pseudoflavor()
+ *   Returns RPC_AUTH pseudoflavor in use by @rqstp.
  */
 struct auth_ops {
 	char *	name;
@@ -143,11 +146,13 @@ struct auth_ops {
 	int			(*release)(struct svc_rqst *rqstp);
 	void			(*domain_release)(struct auth_domain *dom);
 	enum svc_auth_status	(*set_client)(struct svc_rqst *rqstp);
+	rpc_authflavor_t	(*pseudoflavor)(struct svc_rqst *rqstp);
 };
 
 struct svc_xprt;
 
 extern enum svc_auth_status svc_authenticate(struct svc_rqst *rqstp);
+extern rpc_authflavor_t svc_auth_flavor(struct svc_rqst *rqstp);
 extern int	svc_authorise(struct svc_rqst *rqstp);
 extern enum svc_auth_status svc_set_client(struct svc_rqst *rqstp);
 extern int	svc_auth_register(rpc_authflavor_t flavor, struct auth_ops *aops);
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 18734e70c5dd..104d9a320142 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -2014,6 +2014,11 @@ svcauth_gss_domain_release(struct auth_domain *dom)
 	call_rcu(&dom->rcu_head, svcauth_gss_domain_release_rcu);
 }
 
+static rpc_authflavor_t svcauth_gss_pseudoflavor(struct svc_rqst *rqstp)
+{
+	return svcauth_gss_flavor(rqstp->rq_gssclient);
+}
+
 static struct auth_ops svcauthops_gss = {
 	.name		= "rpcsec_gss",
 	.owner		= THIS_MODULE,
@@ -2022,6 +2027,7 @@ static struct auth_ops svcauthops_gss = {
 	.release	= svcauth_gss_release,
 	.domain_release = svcauth_gss_domain_release,
 	.set_client	= svcauth_gss_set_client,
+	.pseudoflavor	= svcauth_gss_pseudoflavor,
 };
 
 static int rsi_cache_create_net(struct net *net)
diff --git a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
index aa4429d0b810..1619211f0960 100644
--- a/net/sunrpc/svcauth.c
+++ b/net/sunrpc/svcauth.c
@@ -160,6 +160,22 @@ svc_auth_unregister(rpc_authflavor_t flavor)
 }
 EXPORT_SYMBOL_GPL(svc_auth_unregister);
 
+/**
+ * svc_auth_flavor - return RPC transaction's RPC_AUTH flavor
+ * @rqstp: RPC transaction context
+ *
+ * Returns an RPC flavor or GSS pseudoflavor.
+ */
+rpc_authflavor_t svc_auth_flavor(struct svc_rqst *rqstp)
+{
+	struct auth_ops *aops = rqstp->rq_authop;
+
+	if (!aops->pseudoflavor)
+		return aops->flavour;
+	return aops->pseudoflavor(rqstp);
+}
+EXPORT_SYMBOL_GPL(svc_auth_flavor);
+
 /**************************************************
  * 'auth_domains' are stored in a hash table indexed by name.
  * When the last reference to an 'auth_domain' is dropped,


