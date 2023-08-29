Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686FB78C9A2
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Aug 2023 18:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjH2Q16 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 12:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237495AbjH2Q1v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 12:27:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73430D2
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 09:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693326422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=D/e0Fznsuod56eGhfWGIYsDYHeTS4wVaDFe7Um+cXW8=;
        b=A5gBMiwb3LQlJbq52qAVYsfdv+BjDPgrxRr0+DXJzvRgMr0Uyjujn7JglU2XsSqXQK+9pi
        qqvqURBJVFHwQdCr3BMuRUk9o5U30ULXiKGMA7gyZ0uvQHESq52+51GFdmkko06OmlTHVF
        CwBoWuqZNwyFMS7T4qTIjLmZVGh7GFo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-qHElc9z9NRm9ZuOZTtaAOA-1; Tue, 29 Aug 2023 12:27:00 -0400
X-MC-Unique: qHElc9z9NRm9ZuOZTtaAOA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51C95801C99
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 16:26:59 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 510A740C2063
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 16:26:58 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: allow setting SEQ4_STATUS_RECALLABLE_STATE_REVOKED
Date:   Tue, 29 Aug 2023 12:26:56 -0400
Message-Id: <cd03fb7419f886c8c79bb2ee4889dbc0768a1652.1693326366.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch sets the SEQ4_STATUS_RECALLABLE_STATE_REVOKED bit for a single
SEQUENCE response after writing "revoke" to the client's ctl file in procfs.
It has been generally useful to test various NFS client implementations, so
I'm sending it along for others to find and use.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfsd/nfs4state.c | 19 +++++++++++++++----
 fs/nfsd/state.h     |  1 +
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index daf305daa751..f91e2857df65 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2830,18 +2830,28 @@ static ssize_t client_ctl_write(struct file *file, const char __user *buf,
 {
 	char *data;
 	struct nfs4_client *clp;
+	ssize_t rc = size;
 
 	data = simple_transaction_get(file, buf, size);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
-	if (size != 7 || 0 != memcmp(data, "expire\n", 7))
+
+	if (size != 7)
 		return -EINVAL;
+
 	clp = get_nfsdfs_clp(file_inode(file));
 	if (!clp)
 		return -ENXIO;
-	force_expire_client(clp);
+
+	if (!memcmp(data, "revoke\n", 7))
+		set_bit(NFSD4_CLIENT_CL_REVOKED, &clp->cl_flags);
+	else if (!memcmp(data, "expire\n", 7))
+		force_expire_client(clp);
+	else
+		rc = -EINVAL;
+
 	drop_client(clp);
-	return 7;
+	return rc;
 }
 
 static const struct file_operations client_ctl_fops = {
@@ -4042,7 +4052,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	default:
 		seq->status_flags = 0;
 	}
-	if (!list_empty(&clp->cl_revoked))
+	if (!list_empty(&clp->cl_revoked) ||
+			test_and_clear_bit(NFSD4_CLIENT_CL_REVOKED, &clp->cl_flags))
 		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
 out_no_session:
 	if (conn)
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index d49d3060ed4f..a9154b7da022 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -369,6 +369,7 @@ struct nfs4_client {
 #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
 					 1 << NFSD4_CLIENT_CB_KILL)
 #define NFSD4_CLIENT_CB_RECALL_ANY	(6)
+#define NFSD4_CLIENT_CL_REVOKED (7)
 	unsigned long		cl_flags;
 	const struct cred	*cl_cb_cred;
 	struct rpc_clnt		*cl_cb_client;
-- 
2.40.1

