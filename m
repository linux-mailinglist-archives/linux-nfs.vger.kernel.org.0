Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF7665B583
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbjABRGO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbjABRGM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:06:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD43064DB
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:06:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47A6F60F79
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8F1C433D2
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679170;
        bh=niqlqHAGjGFIF/ZW/+kgSfQh9MTnC1Lndk5Bo4wcpsE=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=A4N1chX4Vnw6YjFNAhZvWYacWgucjGH8fi0J3IQIHdGsYllPlNV9dkI2257Wh+mJj
         uaptWqPJ6RayMiomQxA9V71EOGDWaqFrXNfaT4kTUWKDuxWO6yzADm+Nn0KpPJ63El
         Ym1deiaaEv07SnVUI6XhwJViMuyHrRT5WMqVOF7YZPOrIhXvpgM6N65dX/tNgHM8PK
         mjWBYq9ZZ/n5audX7xmxpXEA9O0baYuR+wkFfFp5+Sbe2PQQ+h2XwvNbYI7lOr0NEY
         bd+UjZSdE3yJSD0yG03mMLwpvd3Rbzh/L/dbHHoBq9y2SaIjwMAnFp2WfQAHnLhx8r
         6Sf+v3ruq0RfA==
Subject: [PATCH v1 07/25] SUNRPC: Move the server-side GSS upcall to a
 noinline function
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:06:09 -0500
Message-ID: <167267916945.112521.12682566743515878078.stgit@manet.1015granger.net>
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

Since upcalls are infrequent, ensure the compiler places the upcall
mechanism out-of-line from the I/O path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 8ebc06bebbec..2a11721dd5c4 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1444,6 +1444,14 @@ static bool use_gss_proxy(struct net *net)
 	return sn->use_gss_proxy;
 }
 
+static noinline_for_stack int
+svcauth_gss_proc_init(struct svc_rqst *rqstp, struct rpc_gss_wire_cred *gc)
+{
+	if (!use_gss_proxy(SVC_NET(rqstp)))
+		return svcauth_gss_legacy_init(rqstp, gc);
+	return svcauth_gss_proxy_init(rqstp, gc);
+}
+
 #ifdef CONFIG_PROC_FS
 
 static ssize_t write_gssp(struct file *file, const char __user *buf,
@@ -1600,10 +1608,7 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 	switch (gc->gc_proc) {
 	case RPC_GSS_PROC_INIT:
 	case RPC_GSS_PROC_CONTINUE_INIT:
-		if (use_gss_proxy(SVC_NET(rqstp)))
-			return svcauth_gss_proxy_init(rqstp, gc);
-		else
-			return svcauth_gss_legacy_init(rqstp, gc);
+		return svcauth_gss_proc_init(rqstp, gc);
 	case RPC_GSS_PROC_DATA:
 	case RPC_GSS_PROC_DESTROY:
 		/* Look up the context, and check the verifier: */


