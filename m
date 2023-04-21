Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A976EB075
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Apr 2023 19:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjDURUM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Apr 2023 13:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDURUL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Apr 2023 13:20:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BC9125BF
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682097527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PKscJJGRbiQgUaCsPBqkxMCbP1BW8v7pKgvxNq9aXVg=;
        b=DZrgjyAeRVBOPOTerjinzKy1KKhPQsUV2+gaZ3y0sTkXyCuTwkAqHCC6+NsjLWki9plFg6
        8WClq3914t7Qg6rbxuFnleGTOYqGGfMoNwOGFat6RmRRH7zwiVpAhXVZuyIezjXGmzpd9n
        Dykg/2CFkXmpjAWuaMZjHLbvd5cAN+U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-TzC5bNR4Of6h705TebM3WQ-1; Fri, 21 Apr 2023 13:18:46 -0400
X-MC-Unique: TzC5bNR4Of6h705TebM3WQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF149811E7B
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 17:18:45 +0000 (UTC)
Received: from bcodding.csb.redhat.com (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 999D740C201F
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 17:18:45 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 9/9] NFSv4: Clean up some shutdown loops
Date:   Fri, 21 Apr 2023 13:18:39 -0400
Message-Id: <d05619dabbbc09760b82ca844dd7ddb610e38e69.1682097420.git.bcodding@redhat.com>
In-Reply-To: <cover.1682097420.git.bcodding@redhat.com>
References: <cover.1682097420.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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
2.39.2

