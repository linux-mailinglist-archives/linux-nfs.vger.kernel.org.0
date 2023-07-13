Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EFF7529E4
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jul 2023 19:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjGMRfP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jul 2023 13:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjGMRfP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jul 2023 13:35:15 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431A12699
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jul 2023 10:35:14 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-346317895e7so456535ab.1
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jul 2023 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689269713; x=1689874513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/jGLZbFflKh8iVJ5pfkLpxhZEV6cFYv+46Kvu9MMZAU=;
        b=VC5Xx7zQ7S/Z4aOuGj53my6J4oSh4gU+bKTQ3FZBQ0Ki4FMkjahp7ofQfvXCDaMyMy
         Wbkm1Uc57FI3IduSCIw+S1E2h5WuGlFO0HwC5NmOb2WuygI/3nnKw+AQHI28oPIxCMsD
         WpPddcpPq+tK82EHUL7uZNRymlWvY6Ke8nDbwfwWsd2VlmWHHKzbvEDBolANwoJj9IHY
         mbHaztKyxBRU3za3gDSSDHTzb1obt41UQogyAJNTN8n5WYQXULHKitWoT9+XRYaSzGDs
         dhe7gjSuwhFukpsRqx+BBTCOr5NLbRzC5JJFvT7BEbziqEZve6OGF6iNaTEkcNBmMXHV
         3MdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689269713; x=1689874513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jGLZbFflKh8iVJ5pfkLpxhZEV6cFYv+46Kvu9MMZAU=;
        b=QdwmXl+y12TBOjvVIkiZEWLseov0alp427sYDlkGlDeb4jRKEc+vzjj5s3mUER3byG
         ZzymlPavdDYUMfNRW0O4Ob1LpcrFzcM6G9mndLY9WN+tRp9VHAaveFujE3yeC0QUf9Fi
         IzXfXafgYe0M8H9ppDTNRIFnac/LT9FkVogcmkIVJ4YGYNQuic3u2c0whKZXebEbwiBQ
         89wGVqUgTZ0wNAfMVDlcmTUAtpexD9qS4V5Fbw3bElKpMMxC4ieADaJIwTW0td4xjPFV
         pD1ZHKOcq5iz5BmPQQlFmlj9IoTE9ELoOQ5fhuPHFRtkH59p0kOfqxb8i+CfBy/kF5sQ
         kgtg==
X-Gm-Message-State: ABy/qLabWaIgotP5rtZUXuznOqKt21a06kI36UM6tfEwMuMS8C2hjJTL
        QimwYGOYAjNjtyCq6Na3Q8lQSO85TW4=
X-Google-Smtp-Source: APBJJlHYcUFzTrxE3jCtd/gsmstrAjk5JltYlnVDudmftnP/hm4WxOR7gwFLxtgaD3r7laYkAYSyPw==
X-Received: by 2002:a05:6e02:924:b0:33b:d741:5888 with SMTP id o4-20020a056e02092400b0033bd7415888mr1538341ilt.0.1689269713497;
        Thu, 13 Jul 2023 10:35:13 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:e116:c73f:66fd:3d1b])
        by smtp.gmail.com with ESMTPSA id b3-20020a92db03000000b00345e3a04f2dsm2171705iln.62.2023.07.13.10.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:35:12 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1: fix pnfs MDS=DS session trunking
Date:   Thu, 13 Jul 2023 13:35:11 -0400
Message-Id: <20230713173511.24651-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Currently, when GETDEVICEINFO returns multiple locations where each
is a different IP but the server's identity is same as MDS, then
nfs4_set_ds_client() finds the existing nfs_client structure which
has the MDS's max_connect value (and if it's 1), then the 1st IP
on the DS's list will get dropped due to MDS trunking rules. Other
IPs would be added as they fall under the pnfs trunking rules.

Instead, this patch prposed to treat MDS=DS as DS trunking and
make sure that MDS's max_connect limit does not apply to the
1st IP returned in the GETDEVICEINFO list.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4client.c | 7 ++++++-
 net/sunrpc/clnt.c   | 7 +++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 27fb25567ce7..b35acd79b895 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -417,6 +417,7 @@ static void nfs4_add_trunk(struct nfs_client *clp, struct nfs_client *old)
 		.net = old->cl_net,
 		.servername = old->cl_hostname,
 	};
+	int max_connect = old->cl_max_connect;
 
 	if (clp->cl_proto != old->cl_proto)
 		return;
@@ -428,9 +429,12 @@ static void nfs4_add_trunk(struct nfs_client *clp, struct nfs_client *old)
 
 	xprt_args.dstaddr = clp_sap;
 	xprt_args.addrlen = clp_salen;
+	if (clp->cl_max_connect != old->cl_max_connect &&
+	    test_bit(NFS_CS_DS, &clp->cl_flags))
+		max_connect = clp->cl_max_connect;
 
 	rpc_clnt_add_xprt(old->cl_rpcclient, &xprt_args,
-			  rpc_clnt_test_and_add_xprt, NULL);
+			  rpc_clnt_test_and_add_xprt, &max_connect);
 }
 
 /**
@@ -1010,6 +1014,7 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
 
 	__set_bit(NFS_CS_DS, &cl_init.init_flags);
+	cl_init.max_connect = NFS_MAX_TRANSPORTS;
 	/*
 	 * Set an authflavor equual to the MDS value. Use the MDS nfs_client
 	 * cl_ipaddr so as to use the same EXCHANGE_ID co_ownerid as the MDS
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index d7c697af3762..dfdb4bc96367 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2908,12 +2908,15 @@ static const struct rpc_call_ops rpc_cb_add_xprt_call_ops = {
  */
 int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 		struct rpc_xprt_switch *xps, struct rpc_xprt *xprt,
-		void *dummy)
+		void *in_max_connect)
 {
 	struct rpc_cb_add_xprt_calldata *data;
 	struct rpc_task *task;
+	int max_connect = clnt->cl_max_connect;
 
-	if (xps->xps_nunique_destaddr_xprts + 1 > clnt->cl_max_connect) {
+	if (in_max_connect)
+		max_connect = *(int *)in_max_connect;
+	if (xps->xps_nunique_destaddr_xprts + 1 > max_connect) {
 		rcu_read_lock();
 		pr_warn("SUNRPC: reached max allowed number (%d) did not add "
 			"transport to server: %s\n", clnt->cl_max_connect,
-- 
2.39.1

