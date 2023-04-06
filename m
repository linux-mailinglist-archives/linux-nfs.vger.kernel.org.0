Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA0A6D993C
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 16:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239111AbjDFOLd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 10:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239130AbjDFOLK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 10:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E221AD1C
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 07:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680790213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDT2xZslmwC5RymDr+i2C+SpKbLu+XFfhz6wrT81Es4=;
        b=bdnU/HNbKINGb+dJIAD63uijaGAsdZRsLMj5kq5vcIPkR69FH0/QIHyBJr0poYse2BZa4I
        h+2ROIZD/3j9pg+IIwWU+jQNeQj0sVnTQQvomamgLtUAgxNvTm42sEsbYsHSFEiF6QnufK
        Uv1g+eyyVKDITSEk8HmuPLTzm+TzR84=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-jZkgifT-M1aA2ESDXtJQ9w-1; Thu, 06 Apr 2023 10:10:08 -0400
X-MC-Unique: jZkgifT-M1aA2ESDXtJQ9w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30B9085A588;
        Thu,  6 Apr 2023 14:10:08 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.10.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4BBB2166B2A;
        Thu,  6 Apr 2023 14:10:07 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@netapp.com, Olga.Kornievskaia@netapp.com
Subject: [PATCH 5/6] NFS: add a sysfs link to the lockd rpc_client
Date:   Thu,  6 Apr 2023 10:10:03 -0400
Message-Id: <988114e82de907d741bffa23c9e14b641413bbb9.1680786859.git.bcodding@redhat.com>
In-Reply-To: <cover.1680786859.git.bcodding@redhat.com>
References: <cover.1680786859.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

After lockd is started, add a symlink for lockd's rpc_client under
NFS' superblock sysfs.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/lockd/clntlock.c        | 6 ++++++
 fs/nfs/client.c            | 1 +
 include/linux/lockd/bind.h | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/fs/lockd/clntlock.c b/fs/lockd/clntlock.c
index a5bb3f721a9d..0340e10b5715 100644
--- a/fs/lockd/clntlock.c
+++ b/fs/lockd/clntlock.c
@@ -94,6 +94,12 @@ void nlmclnt_done(struct nlm_host *host)
 }
 EXPORT_SYMBOL_GPL(nlmclnt_done);
 
+struct rpc_clnt *nlmclnt_rpc_clnt(struct nlm_host *host)
+{
+	return host->h_rpcclnt;
+}
+EXPORT_SYMBOL_GPL(nlmclnt_rpc_clnt);
+
 /*
  * Queue up a lock for blocking so that the GRANTED request can see it
  */
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index de275f1fde92..eede8c28a56b 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -592,6 +592,7 @@ static int nfs_start_lockd(struct nfs_server *server)
 
 	server->nlm_host = host;
 	server->destroy = nfs_destroy_server;
+	nfs_sysfs_link_rpc_client(server, nlmclnt_rpc_clnt(host), NULL);
 	return 0;
 }
 
diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
index 3bc9f7410e21..c53c81242e72 100644
--- a/include/linux/lockd/bind.h
+++ b/include/linux/lockd/bind.h
@@ -20,6 +20,7 @@
 /* Dummy declarations */
 struct svc_rqst;
 struct rpc_task;
+struct rpc_clnt;
 
 /*
  * This is the set of functions for lockd->nfsd communication
@@ -56,6 +57,7 @@ struct nlmclnt_initdata {
 
 extern struct nlm_host *nlmclnt_init(const struct nlmclnt_initdata *nlm_init);
 extern void	nlmclnt_done(struct nlm_host *host);
+extern struct rpc_clnt *nlmclnt_rpc_clnt(struct nlm_host *host);
 
 /*
  * NLM client operations provide a means to modify RPC processing of NLM
-- 
2.39.2

