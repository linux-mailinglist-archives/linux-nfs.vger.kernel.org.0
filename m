Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7524BA55C
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 17:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242754AbiBQQGJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 11:06:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242903AbiBQQGH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 11:06:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E8229C138
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 08:05:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62E4A60A57
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 16:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABE5C340E8;
        Thu, 17 Feb 2022 16:05:51 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Subject: [PATCH v2 5/8] SUNRPC: Rename svc_close_xprt()
Date:   Thu, 17 Feb 2022 11:05:50 -0500
Message-Id:  <164511395041.1361.16754947037277415946.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.35.0
In-Reply-To:  <164511349417.1361.12607852846407534019.stgit@klimt.1015granger.net>
References:  <164511349417.1361.12607852846407534019.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3408; h=from:subject:message-id; bh=qDh3S7dNgBxb+k16OzZxSHKF7n0SMYq+ubk+1ctiqxA=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBiDnJew+e9lR0ICggrdMPW2m969YMTIiU4E/MA4vkt kLGSVrGJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYg5yXgAKCRAzarMzb2Z/l9AQD/ 46ygGouiYOJR07zVs/dzBEuCVgT8X25LrCVPNS0wt8pKIPY9CQuMiMTu8hwN/LooZudRbhV8X5kmBb dG9Uj3Xm68u44tuRxp7rkjTMy7hr2bVcf6nn7a75O2ljJS8IpJNdYAKIT0b4ABhl86GFipU7grvKc1 dg9XnMBKVgi86U511YbyxbG7a3r2yeR8zJNrgyU4YFYuprg7EEQTezhDEnPDiA2iXfAx/hx6M1POBu oO8Hrup97Ci267j6VKqa2c2D/FEBbqiR2rhsWwlEiD47WiU8aToQDFRlM6oeWi90c9ibtDcFLxYz7m yGw11QXA67/7TxLC6dq/rw6sEhwmh6y/to8AJ3LdCfEzabpTmdTkV0UfCJP/GlR2V/Ej31CmxtNQB9 a30+rcsX+u77E3hXmoCWNruaQp263yRm8BJj+/TixdEAzDJVn0nPhz9JU95w229fhUE3Fu+h8gCahQ QR4fxeuVc9H6oLKP/+I2GxNspwAFMrAZ5aAUIpkGOeMY7uvGVwHbinoyn5zBtFHy3o4bP/dJylhiA+ CD1wv65Cecr3/o6QDOf/WRuNl77A6fv1+3+d4PcuPeAeltMEv9IXh8wz8i7JGuIM9O7Mv2dHaQtufg id7iHaU9IpKcsdjpn+rdsj9T2fDcgXZuD0MGwGhjdbBJXtl93cOm7SqwXkhA==
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

Clean up: Use the "svc_xprt_<task>" function naming convention as
is used for other external APIs.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsctl.c                           |    2 +-
 include/linux/sunrpc/svc_xprt.h            |    2 +-
 net/sunrpc/svc.c                           |    2 +-
 net/sunrpc/svc_xprt.c                      |    9 +++++++--
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |    2 +-
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 8fec779994f7..16920e4512bd 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -790,7 +790,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 out_close:
 	xprt = svc_find_xprt(nn->nfsd_serv, transport, net, PF_INET, port);
 	if (xprt != NULL) {
-		svc_close_xprt(xprt);
+		svc_xprt_close(xprt);
 		svc_xprt_put(xprt);
 	}
 out_err:
diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index a7f6f17c3dc5..bf7d029fb48c 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -135,7 +135,7 @@ void	svc_xprt_received(struct svc_xprt *xprt);
 void	svc_xprt_enqueue(struct svc_xprt *xprt);
 void	svc_xprt_put(struct svc_xprt *xprt);
 void	svc_xprt_copy_addrs(struct svc_rqst *rqstp, struct svc_xprt *xprt);
-void	svc_close_xprt(struct svc_xprt *xprt);
+void	svc_xprt_close(struct svc_xprt *xprt);
 int	svc_port_is_privileged(struct sockaddr *sin);
 int	svc_print_xprts(char *buf, int maxlen);
 struct	svc_xprt *svc_find_xprt(struct svc_serv *serv, const char *xcl_name,
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 74a75a22da9a..53efef3db3a9 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1352,7 +1352,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	svc_authorise(rqstp);
 close_xprt:
 	if (rqstp->rq_xprt && test_bit(XPT_TEMP, &rqstp->rq_xprt->xpt_flags))
-		svc_close_xprt(rqstp->rq_xprt);
+		svc_xprt_close(rqstp->rq_xprt);
 	dprintk("svc: svc_process close\n");
 	return 0;
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 44be7193cd9b..6809116c996a 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1068,7 +1068,12 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
 	svc_xprt_put(xprt);
 }
 
-void svc_close_xprt(struct svc_xprt *xprt)
+/**
+ * svc_xprt_close - Close a client connection
+ * @xprt: transport to disconnect
+ *
+ */
+void svc_xprt_close(struct svc_xprt *xprt)
 {
 	trace_svc_xprt_close(xprt);
 	set_bit(XPT_CLOSE, &xprt->xpt_flags);
@@ -1083,7 +1088,7 @@ void svc_close_xprt(struct svc_xprt *xprt)
 	 */
 	svc_delete_xprt(xprt);
 }
-EXPORT_SYMBOL_GPL(svc_close_xprt);
+EXPORT_SYMBOL_GPL(svc_xprt_close);
 
 static int svc_close_list(struct svc_serv *serv, struct list_head *xprt_list, struct net *net)
 {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index 16897fcb659c..85c8cdda98b1 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -198,7 +198,7 @@ static int xprt_rdma_bc_send_request(struct rpc_rqst *rqst)
 
 	ret = rpcrdma_bc_send_request(rdma, rqst);
 	if (ret == -ENOTCONN)
-		svc_close_xprt(sxprt);
+		svc_xprt_close(sxprt);
 	return ret;
 }
 

