Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EFA71631C
	for <lists+linux-nfs@lfdr.de>; Tue, 30 May 2023 16:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjE3OGY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 May 2023 10:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjE3OGW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 May 2023 10:06:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5772CF9
        for <linux-nfs@vger.kernel.org>; Tue, 30 May 2023 07:06:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA488630D2
        for <linux-nfs@vger.kernel.org>; Tue, 30 May 2023 14:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D65C4339B;
        Tue, 30 May 2023 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685455575;
        bh=QLJijva0Skh8Lw8HTuYurfuKSrgOa808Jcdr6DWqDVE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rZkSPqrQGPkM9/3RO548tyrnUTRw9hnkyf/QEV1M/Mml4d+o92tZGtNNprGJU/CqX
         SGvqyBf0FiJwFC9j2fnJ1e2m0lTmuzd8/vyymIyN6yrW7RxhUmrllKG0W5td2yh/Fi
         aX+IUuM6GuqzkZogurfhNVKRBWivBFgWdQrNud8CgOHCaWxs+bR1zKHmLeWkScPS6A
         IEDDnJenkR3sW4p8tAJvjsrB5dtyanS4BkuUl4AUR6faej/VCxP8xEZpByoLxtdt20
         UtK1Zu0CotP7Pe2kGGUKJ1irn7BnWDYmSQhDneawXtGXS0Vi5YEdFa7+V9auIt9spZ
         bktXxW3v1EeHg==
Subject: [PATCH v3 02/11] SUNRPC: Plumb an API for setting transport layer
 security
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, jlayton@redhat.com,
        linux-nfs@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date:   Tue, 30 May 2023 10:06:03 -0400
Message-ID: <168545555346.1917.9916779401802657173.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168545533442.1917.10040716812361925735.stgit@oracle-102.nfsv4bat.org>
References: <168545533442.1917.10040716812361925735.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Add an initial set of policies along with fields for upper layers to
pass the requested policy down to the transport layer.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/clnt.h |    2 ++
 include/linux/sunrpc/xprt.h |   17 +++++++++++++++++
 net/sunrpc/clnt.c           |    4 ++++
 3 files changed, 23 insertions(+)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 770ef2cb5775..063692cd2a60 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -58,6 +58,7 @@ struct rpc_clnt {
 				cl_noretranstimeo: 1,/* No retransmit timeouts */
 				cl_autobind : 1,/* use getport() */
 				cl_chatty   : 1;/* be verbose */
+	struct xprtsec_parms	cl_xprtsec;	/* transport security policy */
 
 	struct rpc_rtt *	cl_rtt;		/* RTO estimator data */
 	const struct rpc_timeout *cl_timeout;	/* Timeout strategy */
@@ -139,6 +140,7 @@ struct rpc_create_args {
 	struct svc_xprt		*bc_xprt;	/* NFSv4.1 backchannel */
 	const struct cred	*cred;
 	unsigned int		max_connect;
+	struct xprtsec_parms	xprtsec;
 };
 
 struct rpc_add_xprt_test {
diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index b9f59aabee53..9e7f12c240c5 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -129,6 +129,21 @@ struct rpc_rqst {
 #define rq_svec			rq_snd_buf.head
 #define rq_slen			rq_snd_buf.len
 
+/* RPC transport layer security policies */
+enum xprtsec_policies {
+	RPC_XPRTSEC_NONE = 0,
+	RPC_XPRTSEC_TLS_ANON,
+	RPC_XPRTSEC_TLS_X509,
+};
+
+struct xprtsec_parms {
+	enum xprtsec_policies	policy;
+
+	/* authentication material */
+	key_serial_t		cert_serial;
+	key_serial_t		privkey_serial;
+};
+
 struct rpc_xprt_ops {
 	void		(*set_buffer_size)(struct rpc_xprt *xprt, size_t sndsize, size_t rcvsize);
 	int		(*reserve_xprt)(struct rpc_xprt *xprt, struct rpc_task *task);
@@ -229,6 +244,7 @@ struct rpc_xprt {
 	 */
 	unsigned long		bind_timeout,
 				reestablish_timeout;
+	struct xprtsec_parms	xprtsec;
 	unsigned int		connect_cookie;	/* A cookie that gets bumped
 						   every time the transport
 						   is reconnected */
@@ -333,6 +349,7 @@ struct xprt_create {
 	struct svc_xprt		*bc_xprt;	/* NFSv4.1 backchannel */
 	struct rpc_xprt_switch	*bc_xps;
 	unsigned int		flags;
+	struct xprtsec_parms	xprtsec;
 };
 
 struct xprt_class {
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index d2ee56634308..a18074f8edf2 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -385,6 +385,7 @@ static struct rpc_clnt * rpc_new_client(const struct rpc_create_args *args,
 	if (!clnt)
 		goto out_err;
 	clnt->cl_parent = parent ? : clnt;
+	clnt->cl_xprtsec = args->xprtsec;
 
 	err = rpc_alloc_clid(clnt);
 	if (err)
@@ -532,6 +533,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
 		.addrlen = args->addrsize,
 		.servername = args->servername,
 		.bc_xprt = args->bc_xprt,
+		.xprtsec = args->xprtsec,
 	};
 	char servername[48];
 	struct rpc_clnt *clnt;
@@ -727,6 +729,7 @@ int rpc_switch_client_transport(struct rpc_clnt *clnt,
 	struct rpc_clnt *parent;
 	int err;
 
+	args->xprtsec = clnt->cl_xprtsec;
 	xprt = xprt_create_transport(args);
 	if (IS_ERR(xprt))
 		return PTR_ERR(xprt);
@@ -3046,6 +3049,7 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 
 	if (!xprtargs->ident)
 		xprtargs->ident = ident;
+	xprtargs->xprtsec = clnt->cl_xprtsec;
 	xprt = xprt_create_transport(xprtargs);
 	if (IS_ERR(xprt)) {
 		ret = PTR_ERR(xprt);


