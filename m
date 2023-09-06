Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79018794440
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Sep 2023 22:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjIFUFv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Sep 2023 16:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjIFUFp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Sep 2023 16:05:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4DE1998
        for <linux-nfs@vger.kernel.org>; Wed,  6 Sep 2023 13:05:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F4DC433C7;
        Wed,  6 Sep 2023 20:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694030738;
        bh=ZEEE72yB8XpKrRMoeb9VdJiJ4VEHBdeW40xPLF/rUWk=;
        h=Subject:From:To:Cc:Date:From;
        b=nJW/lZGubaKkuPMJqvv1XDUk8cmYNQL/TniY7Xm2ZqM29YHHbEdSFppcdOFuHo4XV
         FimtML67fL+OIY5jnde0qfllaXlmJa/pDY11NLveXnq1u5e44mwbE1oFYoSZ42gSQH
         xU9OvtI1lrl8qNstcLDg+VxOeVqKauo9o0I9iARs6hX7LufsKQ15mzU1T0o2akuSPH
         VaD5xCptIP0YrUxEvFROdKnZoIKlPMrC+g2Ph8KUUVGMKfU5fFfi0wTKwj4mdMbn9b
         sMZMR5/lszST8IvNxHRvfvjHRgb2fvSjh5G+WjxrCjg1RS792rYCtrk+Pp+HKEKPfW
         wMzJjqjZuPOqQ==
Subject: [PATCH v2] SUNRPC: Fail quickly when server does not recognize TLS
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Wed, 06 Sep 2023 16:05:26 -0400
Message-ID: <169403069468.5590.10798268439536368989.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

rpcauth_checkverf() should return a distinct error code when a
server recognizes the AUTH_TLS probe but does not support TLS so
that the client's header decoder can respond appropriately and
quickly. No retries are necessary is in this case, since the server
has already affirmatively answered "TLS is unsupported".

Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth.c     |   11 ++++++++---
 net/sunrpc/auth_tls.c |    4 ++--
 net/sunrpc/clnt.c     |   10 +++++++++-
 3 files changed, 19 insertions(+), 6 deletions(-)

This must be applied after 'Revert "SUNRPC: Fail faster on bad verifier"'

Changes since RFC:
- Basic testing has been done
- Added an explicit check for a zero-length verifier string

diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 2f16f9d17966..814b0169f972 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -769,9 +769,14 @@ int rpcauth_wrap_req(struct rpc_task *task, struct xdr_stream *xdr)
  * @task: controlling RPC task
  * @xdr: xdr_stream containing RPC Reply header
  *
- * On success, @xdr is updated to point past the verifier and
- * zero is returned. Otherwise, @xdr is in an undefined state
- * and a negative errno is returned.
+ * Return values:
+ *   %0: Verifier is valid. @xdr now points past the verifier.
+ *   %-EIO: Verifier is corrupted or message ended early.
+ *   %-EACCES: Verifier is intact but not valid.
+ *   %-EPROTONOSUPPORT: Server does not support the requested auth type.
+ *
+ * When a negative errno is returned, @xdr is left in an undefined
+ * state.
  */
 int
 rpcauth_checkverf(struct rpc_task *task, struct xdr_stream *xdr)
diff --git a/net/sunrpc/auth_tls.c b/net/sunrpc/auth_tls.c
index de7678f8a23d..87f570fd3b00 100644
--- a/net/sunrpc/auth_tls.c
+++ b/net/sunrpc/auth_tls.c
@@ -129,9 +129,9 @@ static int tls_validate(struct rpc_task *task, struct xdr_stream *xdr)
 	if (*p != rpc_auth_null)
 		return -EIO;
 	if (xdr_stream_decode_opaque_inline(xdr, &str, starttls_len) != starttls_len)
-		return -EIO;
+		return -EPROTONOSUPPORT;
 	if (memcmp(str, starttls_token, starttls_len))
-		return -EIO;
+		return -EPROTONOSUPPORT;
 	return 0;
 }
 
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 315bd59dea05..80ee97fb0bf2 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2722,7 +2722,15 @@ rpc_decode_header(struct rpc_task *task, struct xdr_stream *xdr)
 
 out_verifier:
 	trace_rpc_bad_verifier(task);
-	goto out_garbage;
+	switch (error) {
+	case -EPROTONOSUPPORT:
+		goto out_err;
+	case -EACCES:
+		/* Re-encode with a fresh cred */
+		fallthrough;
+	default:
+		goto out_garbage;
+	}
 
 out_msg_denied:
 	error = -EACCES;


