Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E5C78DF2C
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 22:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbjH3T7a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Aug 2023 15:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbjH3T7J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Aug 2023 15:59:09 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7D66FB2A
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 12:31:57 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-34ca6863743so144495ab.1
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693423777; x=1694028577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7/CsU6Z0fPtJ5a72ht/LLtYHIeRukeZ9aQDsZpwNARQ=;
        b=pRj1KD+UDnxGnm4Tv5N9WWRK/+YxRZxBwlbPz0Uo8ihXEgoEbccg4EggGUPxgRj/ku
         rkyOhiY9IwWXaFzZPzX4mSq9msYU0rP93tE5w0YH0eW/NBHaIIfSRuW31taYJJkkEuFY
         2gDZ8NzcuTVkryB/LptG/VdNR+oTc633OO+XkalSTxVA835NN1cgGZUAWa1Tdsme9Szh
         u39N3Rm1z3DW5Uhj6r7La47V+a/EvbjQlXEMY0e0U6AOCkvQ1Kc3olHBGR10GzW/1qEI
         6OVqXJkM3pbyK4EgYYc/fcfG9PCyhJVoEbvH/UC6Yn8SwWxFN7P514z21hZZTGn/RvPM
         QARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693423777; x=1694028577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/CsU6Z0fPtJ5a72ht/LLtYHIeRukeZ9aQDsZpwNARQ=;
        b=Bky5JncxLDkrsGpQ+w/gdUQICuk+VaWOURlOL3y4Jbx8aXrrMkWSRIw+2TtgKdxgAf
         prhHFAMRsHHtg6R5rRJlzhYL0VrzMpqygJ4aIsRFYj9AKun0yuQm1iOcOreUCk+CWvqt
         vRmQWsbL9xhRgSrOPKh+bGJDeKc043tSNpGAQbYkV0785FVMHlex1K5gbYic7NACnaHC
         VaaSaFAe+APbyNJyq0MEYchWILYrwW3q8cXUiNFaRuCHHzbS0tMI2DTCQkjEKw0frt7K
         H4VqbEYAILn0LUJmNJLgk8SzY9Q1t+cHbKGm/CofBb9gW4CdD/wEfK+vOSmrFE0a9bav
         uXGQ==
X-Gm-Message-State: AOJu0YwCRZK62CgRnTNrYVan8Ivf6A4SlxQXb9mVfMCqWIom7Ljy+ZyG
        Rt3+9dWUyPR/gq2b+szmf2c=
X-Google-Smtp-Source: AGHT+IEC+R1aJ8gKORvfl83y8EI1LP2F7hpDsnnDd0gLP7glA2T1EzFgsMKLumEbsMzgSk2EzDoMZg==
X-Received: by 2002:a05:6602:89e:b0:792:7c78:55be with SMTP id f30-20020a056602089e00b007927c7855bemr3498480ioz.0.1693423776618;
        Wed, 30 Aug 2023 12:29:36 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:b9e5:28ab:6ad7:257e])
        by smtp.gmail.com with ESMTPSA id gj25-20020a0566386a1900b0042b48d372aasm4030106jab.100.2023.08.30.12.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:29:36 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/1] NFSv4.1: fix pnfs MDS=DS session trunking
Date:   Wed, 30 Aug 2023 15:29:34 -0400
Message-Id: <20230830192934.80404-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
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

For the list of IPs the 1st goes thru calling nfs4_set_ds_client()
which will eventually call nfs4_add_trunk() and call into
rpc_clnt_test_and_add_xprt() which has the check for MDS trunking.
The other IPs (after the 1st one), would call rpc_clnt_add_xprt()
which doesn't go thru that check.

nfs4_add_trunk() is called when MDS trunking is happening and it
needs to enforce the usage of max_connect mount option of the
1st mount. However, this shouldn't be applied to pnfs flow.

Instead, this patch proposed to treat MDS=DS as DS trunking and
make sure that MDS's max_connect limit does not apply to the
1st IP returned in the GETDEVICEINFO list. It does so by
marking the newly created client with a new flag NFS_CS_PNFS
which then used to pass max_connect value to use into the
rpc_clnt_test_and_add_xprt() instead of the existing rpc
client's max_connect value set by the MDS connection.

For example, mount was done without max_connect value set
so MDS's rpc client has cl_max_connect=1. Upon calling into
rpc_clnt_test_and_add_xprt() and using rpc client's value,
the caller passes in max_connect value which is previously
been set in the pnfs path (as a part of handling
GETDEVICEINFO list of IPs) in nfs4_set_ds_client().

However, when NFS_CS_PNFS flag is not set and we know we
are doing MDS trunking, comparing a new IP of the same
server, we then set the max_connect value to the
existing MDS's value and pass that into
rpc_clnt_test_and_add_xprt().

--- v3: introduced a new flag NFS_CS_PNFS to distinguish the
caller coming from the nfs4_set_ds_client() path vs MDS path.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4client.c       |  6 +++++-
 include/linux/nfs_fs_sb.h |  1 +
 net/sunrpc/clnt.c         | 11 +++++++----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 27fb25567ce7..11e3a285594c 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -417,6 +417,8 @@ static void nfs4_add_trunk(struct nfs_client *clp, struct nfs_client *old)
 		.net = old->cl_net,
 		.servername = old->cl_hostname,
 	};
+	int max_connect = test_bit(NFS_CS_PNFS, &clp->cl_flags) ?
+		clp->cl_max_connect : old->cl_max_connect;
 
 	if (clp->cl_proto != old->cl_proto)
 		return;
@@ -430,7 +432,7 @@ static void nfs4_add_trunk(struct nfs_client *clp, struct nfs_client *old)
 	xprt_args.addrlen = clp_salen;
 
 	rpc_clnt_add_xprt(old->cl_rpcclient, &xprt_args,
-			  rpc_clnt_test_and_add_xprt, NULL);
+			  rpc_clnt_test_and_add_xprt, &max_connect);
 }
 
 /**
@@ -1010,6 +1012,8 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
 
 	__set_bit(NFS_CS_DS, &cl_init.init_flags);
+	__set_bit(NFS_CS_PNFS, &cl_init.init_flags);
+	cl_init.max_connect = NFS_MAX_TRANSPORTS;
 	/*
 	 * Set an authflavor equual to the MDS value. Use the MDS nfs_client
 	 * cl_ipaddr so as to use the same EXCHANGE_ID co_ownerid as the MDS
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 20eeba8b009d..cd628c4b011e 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -48,6 +48,7 @@ struct nfs_client {
 #define NFS_CS_NOPING		6		/* - don't ping on connect */
 #define NFS_CS_DS		7		/* - Server is a DS */
 #define NFS_CS_REUSEPORT	8		/* - reuse src port on reconnect */
+#define NFS_CS_PNFS		9		/* - Server used for pnfs */
 	struct sockaddr_storage	cl_addr;	/* server identifier */
 	size_t			cl_addrlen;
 	char *			cl_hostname;	/* hostname of server */
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index d7c697af3762..6ef0775bba83 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2904,19 +2904,22 @@ static const struct rpc_call_ops rpc_cb_add_xprt_call_ops = {
  * @clnt: pointer to struct rpc_clnt
  * @xps: pointer to struct rpc_xprt_switch,
  * @xprt: pointer struct rpc_xprt
- * @dummy: unused
+ * @in_max_connect: pointer to the max_connect value for the passed in xprt transport
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
-			"transport to server: %s\n", clnt->cl_max_connect,
+			"transport to server: %s\n", max_connect,
 			rpc_peeraddr2str(clnt, RPC_DISPLAY_ADDR));
 		rcu_read_unlock();
 		return -EINVAL;
-- 
2.39.1

