Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA536EB045
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Apr 2023 19:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjDURJ3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Apr 2023 13:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjDURJ2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Apr 2023 13:09:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371E116B07
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 10:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682096901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ethrqsNDJbce/pd6mDiBUVo/gEjhteyCZz5HB+vKCh4=;
        b=WyrcAvnQZoaF8pySN9oTVjHn0mt1jGst21bYSi12/QaCE+VYFvJAXRIy51smEwa1ru3o+B
        zY6hZP7AjkWi9PHOEPdpbZtmHRTiKnnF6veSazyzTOTXjd5pRNbIAykuzZDwUo+oIk023B
        grHH886VUQRuInQVk7Rt1GoHpbih3kc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-wiOtJi6YM1OFOu5GtY5Yyg-1; Fri, 21 Apr 2023 13:08:19 -0400
X-MC-Unique: wiOtJi6YM1OFOu5GtY5Yyg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 765913C0F689
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 17:08:19 +0000 (UTC)
Received: from bcodding.csb.redhat.com (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FEE2492C14
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 17:08:18 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 9/9] NFSv4: Clean up some shutdown loops
Date:   Fri, 21 Apr 2023 13:08:12 -0400
Message-Id: <84e78ef0afd919a5fbebbbc2b670f447c264b436.1682096307.git.bcodding@redhat.com>
In-Reply-To: <cover.1682096307.git.bcodding@redhat.com>
References: <cover.1682096307.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index f8afd75e520d..039a3b4ae565 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1206,6 +1206,9 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
 	struct task_struct *task;
 	char buf[INET6_ADDRSTRLEN + sizeof("-manager") + 1];
 
+	if (clp->cl_rpcclient->cl_shutdown)
+		return;
+
 	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
 	if (test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state) != 0) {
 		wake_up_var(&clp->cl_state);
-- 
2.39.2

