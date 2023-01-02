Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C849365B581
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbjABRGA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbjABRF7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:05:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF00A64DE
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:05:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74F7C60F79
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C1EC433EF
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679157;
        bh=4Dg0X8b/OAe/y83wjuPsvvei15+aA28xvkB2os7hn50=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Bp0jOBzDOk4nVyyEtjwPCCmGKpPv0ZB1BmAFQHuCe0c0ENT518oTFBfCGFOThxPxQ
         iJMsx3LL9TDS4hJO6qjtDh6oBJQ4yd2mzdpLhkA01EVzhW/Z2PWwn2F3FDcKUcHlIx
         RH/FcAnJh5I+BqNFqwr9vlbZtWEtZQziZ3Y1A+UWuD2Vla9hkHw5cZRyy8+UMnle2B
         sn0olQ+XCUAnl98/dcJw3TrPi6YQOj/Jp4FvAFrmDCY283XBrbLb+sjlcODM2HDYUx
         D3ATsTPbfF2xBx9VBoxT81Zk+w9gaen464MYEbtX+u+9C9osWZGP8bS2JCPurDw7O7
         6NJg4DYR4tIpA==
Subject: [PATCH v1 05/25] SUNRPC: Convert svcauth_unix_accept() to use
 xdr_stream
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:05:56 -0500
Message-ID: <167267915666.112521.3772441945439792226.stgit@manet.1015granger.net>
In-Reply-To: <167267753484.112521.4826748148788735127.stgit@manet.1015granger.net>
References: <167267753484.112521.4826748148788735127.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Done as part of hardening the server-side RPC header decoding path.

Since the server-side of the Linux kernel SunRPC implementation
ignores the contents of the Call's machinename field, there's no
need for its RPC_AUTH_UNIX authenticator to reject names that are
larger than UNX_MAXNODENAME.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/msg_prot.h |    5 +++
 net/sunrpc/svcauth_unix.c       |   71 ++++++++++++++++++++++++++++-----------
 2 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/include/linux/sunrpc/msg_prot.h b/include/linux/sunrpc/msg_prot.h
index 02117ed0fa2e..c4b0eb2b2f04 100644
--- a/include/linux/sunrpc/msg_prot.h
+++ b/include/linux/sunrpc/msg_prot.h
@@ -34,6 +34,11 @@ enum rpc_auth_flavors {
 	RPC_AUTH_GSS_SPKMP = 390011,
 };
 
+/* Maximum size (in octets) of the machinename in an AUTH_UNIX
+ * credential (per RFC 5531 Appendix A)
+ */
+#define RPC_MAX_MACHINENAME	(255)
+
 /* Maximum size (in bytes) of an rpc credential or verifier */
 #define RPC_MAX_AUTH_SIZE (400)
 
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 95354f03bb05..b6aef9c5113b 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -867,26 +867,45 @@ struct auth_ops svcauth_tls = {
 };
 
 
+/**
+ * svcauth_unix_accept - Decode and validate incoming RPC_AUTH_SYS credential
+ * @rqstp: RPC transaction
+ *
+ * Return values:
+ *   %SVC_OK: Both credential and verifier are valid
+ *   %SVC_DENIED: Credential or verifier is not valid
+ *   %SVC_GARBAGE: Failed to decode credential or verifier
+ *   %SVC_CLOSE: Temporary failure
+ *
+ * rqstp->rq_auth_stat is set as mandated by RFC 5531.
+ */
 static int
 svcauth_unix_accept(struct svc_rqst *rqstp)
 {
-	struct kvec	*argv = &rqstp->rq_arg.head[0];
 	struct kvec	*resv = &rqstp->rq_res.head[0];
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct svc_cred	*cred = &rqstp->rq_cred;
 	struct user_namespace *userns;
-	u32		slen, i;
-	int		len   = argv->iov_len;
+	u32 flavor, len, i;
+	void *body;
+	__be32 *p;
+
+	svcxdr_init_decode(rqstp);
 
-	if ((len -= 3*4) < 0)
+	/*
+	 * This implementation ignores the length of the Call's
+	 * credential body field and the timestamp and machinename
+	 * fields.
+	 */
+	p = xdr_inline_decode(xdr, XDR_UNIT * 3);
+	if (!p)
+		return SVC_GARBAGE;
+	len = be32_to_cpup(p + 2);
+	if (len > RPC_MAX_MACHINENAME)
+		return SVC_GARBAGE;
+	if (!xdr_inline_decode(xdr, len))
 		return SVC_GARBAGE;
 
-	svc_getu32(argv);			/* length */
-	svc_getu32(argv);			/* time stamp */
-	slen = XDR_QUADLEN(svc_getnl(argv));	/* machname length */
-	if (slen > 64 || (len -= (slen + 3)*4) < 0)
-		goto badcred;
-	argv->iov_base = (void*)((__be32*)argv->iov_base + slen);	/* skip machname */
-	argv->iov_len -= slen*4;
 	/*
 	 * Note: we skip uid_valid()/gid_valid() checks here for
 	 * backwards compatibility with clients that use -1 id's.
@@ -896,20 +915,33 @@ svcauth_unix_accept(struct svc_rqst *rqstp)
 	 */
 	userns = (rqstp->rq_xprt && rqstp->rq_xprt->xpt_cred) ?
 		rqstp->rq_xprt->xpt_cred->user_ns : &init_user_ns;
-	cred->cr_uid = make_kuid(userns, svc_getnl(argv)); /* uid */
-	cred->cr_gid = make_kgid(userns, svc_getnl(argv)); /* gid */
-	slen = svc_getnl(argv);			/* gids length */
-	if (slen > UNX_NGROUPS || (len -= (slen + 2)*4) < 0)
+	if (xdr_stream_decode_u32(xdr, &i) < 0)
+		return SVC_GARBAGE;
+	cred->cr_uid = make_kuid(userns, i);
+	if (xdr_stream_decode_u32(xdr, &i) < 0)
+		return SVC_GARBAGE;
+	cred->cr_gid = make_kgid(userns, i);
+
+	if (xdr_stream_decode_u32(xdr, &len) < 0)
+		return SVC_GARBAGE;
+	if (len > UNX_NGROUPS)
 		goto badcred;
-	cred->cr_group_info = groups_alloc(slen);
+	p = xdr_inline_decode(xdr, XDR_UNIT * len);
+	if (!p)
+		return SVC_GARBAGE;
+	cred->cr_group_info = groups_alloc(len);
 	if (cred->cr_group_info == NULL)
 		return SVC_CLOSE;
-	for (i = 0; i < slen; i++) {
-		kgid_t kgid = make_kgid(userns, svc_getnl(argv));
+	for (i = 0; i < len; i++) {
+		kgid_t kgid = make_kgid(userns, be32_to_cpup(p++));
 		cred->cr_group_info->gid[i] = kgid;
 	}
 	groups_sort(cred->cr_group_info);
-	if (svc_getu32(argv) != htonl(RPC_AUTH_NULL) || svc_getu32(argv) != 0) {
+
+	/* Call's verf field: */
+	if (xdr_stream_decode_opaque_auth(xdr, &flavor, &body, &len) < 0)
+		return SVC_GARBAGE;
+	if (flavor != RPC_AUTH_NULL || len != 0) {
 		rqstp->rq_auth_stat = rpc_autherr_badverf;
 		return SVC_DENIED;
 	}
@@ -919,7 +951,6 @@ svcauth_unix_accept(struct svc_rqst *rqstp)
 	svc_putnl(resv, 0);
 
 	rqstp->rq_cred.cr_flavor = RPC_AUTH_UNIX;
-	svcxdr_init_decode(rqstp);
 	return SVC_OK;
 
 badcred:


