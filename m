Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638E24C011E
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Feb 2022 19:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbiBVSTX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Feb 2022 13:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbiBVSTX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Feb 2022 13:19:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB5FA2F2F
        for <linux-nfs@vger.kernel.org>; Tue, 22 Feb 2022 10:18:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E426614C1
        for <linux-nfs@vger.kernel.org>; Tue, 22 Feb 2022 18:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC57C340E8
        for <linux-nfs@vger.kernel.org>; Tue, 22 Feb 2022 18:18:55 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v1] SUNRPC: Teach server to recognize RPC_AUTH_TLS
Date:   Tue, 22 Feb 2022 13:18:54 -0500
Message-Id: <164555392953.4844.648964031288973459.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.35.0
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3983; h=from:subject:message-id; bh=PkNMR2Q7xZ6qjZA2SRQG9sEbsPdqDwkvTaIZcJq24Tg=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBiFSkJW3I7nvY68RLhzJmsBQHFeQGYTzfTbpIT9zOF NXfRWXaJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYhUpCQAKCRAzarMzb2Z/lxV4D/ 4r4quVayZ78nEdeohQ05wSb7XIXc74JJXRdPHkFL/wp4+tFXXVIWC8aSLO9ZBOwhx0W81SImphYX0n mxtvazqCJvy+PT6evkdQXW2qPQ022LTCysqdm49SvpylkUcmIxghdHTleeA93j7o4E3IjoUzlmj5kL rEmkF9JdnbuKeSW0MLDaM85q9iIW56+1uKycp65SkKnGBvbda5+3phR0B+HgZR8aQFShBq3vHzJCil pbdmMcURXvN7R+pAiNLJX7RZOf2d3yRpnXybmDBBaoQw5VYdRgrlWZKMJlFljFYrcnuiLH4UK/hckp LMz43fX0L1e60p3hao2yShzaxFzUV/PI2S3Et8Rk567uQ4hMAy2AyYkBECIo4j4S88zsgieNYVNtak 3RmkNeW3d43gFKZ/iwfpfrt1gCAvdpETL064rFHA/jtOftwtAGzGsNfgHzlfwAHFttEAorBUs6DEnx Tm8zX7VFasvku5aUmP/EgSsZKb2d0f6voQ9y82RJc2veszzA62Fu6hp+jBp02vFtfu3jWQuQBUZ1We hE0j4ZFweg/9jAqCT7O3A73XKK6xiI0PSdDz1i/dP8SzsS2B8gsFbtKIW12GsZlSORB7w3+Fe95eWm 4S7C0jWds7oMSwiAVHou7PJ2OLQIUX8mmgLLn6CKIoCAuNJa2HFZiGN7L4kw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Initial support for the RPC_AUTH_TLS authentication flavor enables
NFSD to eventually accept an RPC_AUTH_TLS probe from clients. This
patch simply prevents NFSD from rejecting these probes completely.

In the meantime, graft this support in now so that RPC_AUTH_TLS
support keeps up with generic code and API changes in the RPC
server.

Down the road, server-side transport implementations will populate
xpo_start_tls when they can support RPC-with-TLS. For example, TCP
will eventually populate it, but RDMA won't.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_xprt.h |    1 +
 net/sunrpc/svcauth.c            |    2 +
 net/sunrpc/svcauth_unix.c       |   60 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 42e113742429..20068ccfd0cc 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -28,6 +28,7 @@ struct svc_xprt_ops {
 	void		(*xpo_free)(struct svc_xprt *);
 	void		(*xpo_secure_port)(struct svc_rqst *rqstp);
 	void		(*xpo_kill_temp_xprt)(struct svc_xprt *);
+	void		(*xpo_start_tls)(struct svc_xprt *);
 };
 
 struct svc_xprt_class {
diff --git a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
index 5a8b8e03fdd4..e72ba2f13f6c 100644
--- a/net/sunrpc/svcauth.c
+++ b/net/sunrpc/svcauth.c
@@ -31,10 +31,12 @@
  */
 extern struct auth_ops svcauth_null;
 extern struct auth_ops svcauth_unix;
+extern struct auth_ops svcauth_tls;
 
 static struct auth_ops __rcu *authtab[RPC_AUTH_MAXFLAVOR] = {
 	[RPC_AUTH_NULL] = (struct auth_ops __force __rcu *)&svcauth_null,
 	[RPC_AUTH_UNIX] = (struct auth_ops __force __rcu *)&svcauth_unix,
+	[RPC_AUTH_TLS]  = (struct auth_ops __force __rcu *)&svcauth_tls,
 };
 
 static struct auth_ops *
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index d7ed7d49115a..b1efc34db6ed 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -37,6 +37,7 @@ struct unix_domain {
 
 extern struct auth_ops svcauth_null;
 extern struct auth_ops svcauth_unix;
+extern struct auth_ops svcauth_tls;
 
 static void svcauth_unix_domain_release_rcu(struct rcu_head *head)
 {
@@ -788,6 +789,65 @@ struct auth_ops svcauth_null = {
 };
 
 
+static int
+svcauth_tls_accept(struct svc_rqst *rqstp)
+{
+	struct svc_cred	*cred = &rqstp->rq_cred;
+	struct kvec *argv = rqstp->rq_arg.head;
+	struct kvec *resv = rqstp->rq_res.head;
+
+	if (argv->iov_len < XDR_UNIT * 3)
+		return SVC_GARBAGE;
+
+	/* Call's cred length */
+	if (svc_getu32(argv) != xdr_zero) {
+		rqstp->rq_auth_stat = rpc_autherr_badcred;
+		return SVC_DENIED;
+	}
+
+	/* Call's verifier flavor and its length */
+	if (svc_getu32(argv) != rpc_auth_null ||
+	    svc_getu32(argv) != xdr_zero) {
+		rqstp->rq_auth_stat = rpc_autherr_badverf;
+		return SVC_DENIED;
+	}
+
+	/* AUTH_TLS is not valid on non-NULL procedures */
+	if (rqstp->rq_proc != 0) {
+		rqstp->rq_auth_stat = rpc_autherr_badcred;
+		return SVC_DENIED;
+	}
+
+	/* Mapping to nobody uid/gid is required */
+	cred->cr_uid = INVALID_UID;
+	cred->cr_gid = INVALID_GID;
+	cred->cr_group_info = groups_alloc(0);
+	if (cred->cr_group_info == NULL)
+		return SVC_CLOSE; /* kmalloc failure - client must retry */
+
+	/* Reply's verifier */
+	svc_putnl(resv, RPC_AUTH_NULL);
+	if (rqstp->rq_xprt->xpt_ops->xpo_start_tls) {
+		svc_putnl(resv, 8);
+		memcpy(resv->iov_base + resv->iov_len, "STARTTLS", 8);
+		resv->iov_len += 8;
+	} else
+		svc_putnl(resv, 0);
+
+	rqstp->rq_cred.cr_flavor = RPC_AUTH_TLS;
+	return SVC_OK;
+}
+
+struct auth_ops svcauth_tls = {
+	.name		= "tls",
+	.owner		= THIS_MODULE,
+	.flavour	= RPC_AUTH_TLS,
+	.accept 	= svcauth_tls_accept,
+	.release	= svcauth_null_release,
+	.set_client	= svcauth_unix_set_client,
+};
+
+
 static int
 svcauth_unix_accept(struct svc_rqst *rqstp)
 {

