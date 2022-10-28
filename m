Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8E3610CCF
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 11:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJ1JLz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 05:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiJ1JLg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 05:11:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB4E59737
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 02:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666948239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5F5IpR4CpWAl33ymNkl13hfpK7vfwoAzsrMvewKPWKg=;
        b=gEWw2KcpBg8LhbYF13t5O+QwbqucOwCJfZTfGwBXI5u3AnQyfiZ8uRxbtF/kU8XlHxdpct
        jqhdwyCV5c9BVAD2MXaU+NwGd6soxMmHCquQYsgGzuRNOt8tshNtYzio+wLo33pBW+5Dmh
        rqgZB1ylWNvvO1fg3aJ0Wc2n3haTQMA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-GBBtgDEwPBmElbVKPVxiog-1; Fri, 28 Oct 2022 05:10:36 -0400
X-MC-Unique: GBBtgDEwPBmElbVKPVxiog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93170811E67
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 09:10:36 +0000 (UTC)
Received: from localhost (unknown [10.66.60.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E44B540C206B;
        Fri, 28 Oct 2022 09:10:35 +0000 (UTC)
From:   Zhi Li <yieli@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, Zhi Li <yieli@redhat.com>
Subject: [PATCH V2] [nfs/nfs-utils/libtirpc] clnt_raw.c: fix a possible null pointer dereference
Date:   Fri, 28 Oct 2022 17:10:33 +0800
Message-Id: <20221028091033.278199-1-yieli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since clntraw_private could be dereferenced before
allocated, protect it by checking its value in advance.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2138317
Signed-off-by: Zhi Li <yieli@redhat.com>
---
 src/clnt_raw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/clnt_raw.c b/src/clnt_raw.c
index 31f9d0c..03f839d 100644
--- a/src/clnt_raw.c
+++ b/src/clnt_raw.c
@@ -142,7 +142,7 @@ clnt_raw_call(h, proc, xargs, argsp, xresults, resultsp, timeout)
 	struct timeval timeout;
 {
 	struct clntraw_private *clp = clntraw_private;
-	XDR *xdrs = &clp->xdr_stream;
+	XDR *xdrs;
 	struct rpc_msg msg;
 	enum clnt_stat status;
 	struct rpc_err error;
@@ -154,6 +154,7 @@ clnt_raw_call(h, proc, xargs, argsp, xresults, resultsp, timeout)
 		mutex_unlock(&clntraw_lock);
 		return (RPC_FAILED);
 	}
+	xdrs = &clp->xdr_stream;
 	mutex_unlock(&clntraw_lock);
 
 call_again:
@@ -245,7 +246,7 @@ clnt_raw_freeres(cl, xdr_res, res_ptr)
 	void *res_ptr;
 {
 	struct clntraw_private *clp = clntraw_private;
-	XDR *xdrs = &clp->xdr_stream;
+	XDR *xdrs;
 	bool_t rval;
 
 	mutex_lock(&clntraw_lock);
@@ -254,6 +255,7 @@ clnt_raw_freeres(cl, xdr_res, res_ptr)
 		mutex_unlock(&clntraw_lock);
 		return (rval);
 	}
+	xdrs = &clp->xdr_stream;
 	mutex_unlock(&clntraw_lock);
 	xdrs->x_op = XDR_FREE;
 	return ((*xdr_res)(xdrs, res_ptr));
-- 
2.37.3

