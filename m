Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A295731FB8
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jun 2023 20:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbjFOSJR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jun 2023 14:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbjFOSJF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jun 2023 14:09:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D4A296A
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 11:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686852460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cXP/fyAMAMLW5CMbOwVgpz0k/D1MmC8DxRciC+Dubrw=;
        b=KypsLRRHidFjkoYQu4wkrifBNAD35Gjmd5qd9vG6eAmVgzKrkIFBa0B+R9ydLV69CbSdym
        IGtjBgollXSHiUlwQOpAPtg2lYSsl2wdcnc+9NHuagb+oktyfude8/J4R/lbYtYp/whM9z
        MPwvSxG7xi8M+TcytxKB1/TuDsw15Lk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-yIe_T-9wP9WVYyARzc1inA-1; Thu, 15 Jun 2023 14:07:38 -0400
X-MC-Unique: yIe_T-9wP9WVYyARzc1inA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7EC83C0D84D
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:37 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A41B2166B25
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:37 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 11/11] NFSv4: Clean up some shutdown loops
Date:   Thu, 15 Jun 2023 14:07:32 -0400
Message-Id: <16ff132c2f61e4eac1935d0a01f84ba2361fb15c.1686851158.git.bcodding@redhat.com>
In-Reply-To: <cover.1686851158.git.bcodding@redhat.com>
References: <cover.1686851158.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a SEQUENCE call receives -EIO for a shutdown client, it will retry the
RPC call.  Instead of doing that for a shutdown client, just bail out.

Likewise, if the state manager decides to perform recovery for a shutdown
client, it will continuously retry.  As above, just bail out.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs4proc.c  | 2 +-
 fs/nfs/nfs4state.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 40d749f29ed3..a36e35d885c3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9357,7 +9357,7 @@ static void nfs41_sequence_call_done(struct rpc_task *task, void *data)
 		return;
 
 	trace_nfs4_sequence(clp, task->tk_status);
-	if (task->tk_status < 0) {
+	if (task->tk_status < 0 && !task->tk_client->cl_shutdown) {
 		dprintk("%s ERROR %d\n", __func__, task->tk_status);
 		if (refcount_read(&clp->cl_count) == 1)
 			return;
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 2a0ca5c7f082..ead60d7ed4e9 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1210,6 +1210,9 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
 	while (cl != cl->cl_parent)
 		cl = cl->cl_parent;
 
+	if (clp->cl_rpcclient->cl_shutdown)
+		return;
+
 	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
 	if (test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state) != 0) {
 		wake_up_var(&clp->cl_state);
-- 
2.40.1

