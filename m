Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37936AA0D6
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Mar 2023 22:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjCCVJ1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Mar 2023 16:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjCCVJ0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Mar 2023 16:09:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00C514995
        for <linux-nfs@vger.kernel.org>; Fri,  3 Mar 2023 13:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677877722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QvZoWEwIdpnWcYmX5vEF2AnxYyeX4RBCcb9yISp6WOk=;
        b=Bj+9MvflIxYs36D12IIsfbu5bsAhOTfx0/2FMTR2D8dmCUhN8sb+cly0G12xv9SJlFcpkf
        Jtd4rhIHj5Ok+WIow8ZUi92Cp6HxJ1TFvZ4x9rh1T9OKS1pHn2vLWhKI+wOrRiMTO1ehpn
        Rj+F88V/LBBKCxWov6uhXlq7uQB7Lxk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-b64ceFP6POKj4x9Y9UZPSw-1; Fri, 03 Mar 2023 16:08:39 -0500
X-MC-Unique: b64ceFP6POKj4x9Y9UZPSw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84D8F101A52E;
        Fri,  3 Mar 2023 21:08:38 +0000 (UTC)
Received: from bcodding.csb (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AC8B492C18;
        Fri,  3 Mar 2023 21:08:38 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id ABEF110C30F1; Fri,  3 Mar 2023 16:08:32 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] SUNRPC: Fix a server shutdown leak
Date:   Fri,  3 Mar 2023 16:08:32 -0500
Message-Id: <65d0248533fbdea2f6190faa1ee150d2d615344b.1677877233.git.bcodding@redhat.com>
In-Reply-To: <cover.1677877233.git.bcodding@redhat.com>
References: <cover.1677877233.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fix a race where kthread_stop() may prevent the threadfn from ever getting
called.  If that happens the svc_rqst will not be cleaned up.

Fixes: ed6473ddc704 ("NFSv4: Fix callback server shutdown")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 net/sunrpc/svc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 1fd3f5e57285..fea7ce8fba14 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -798,6 +798,7 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 static int
 svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 {
+	struct svc_rqst	*rqstp;
 	struct task_struct *task;
 	unsigned int state = serv->sv_nrthreads-1;
 
@@ -806,7 +807,10 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 		task = choose_victim(serv, pool, &state);
 		if (task == NULL)
 			break;
-		kthread_stop(task);
+		rqstp = kthread_data(task);
+		/* Did we lose a race to svo_function threadfn? */
+		if (kthread_stop(task) == -EINTR)
+			svc_exit_thread(rqstp);
 		nrservs++;
 	} while (nrservs < 0);
 	return 0;
-- 
2.31.1

