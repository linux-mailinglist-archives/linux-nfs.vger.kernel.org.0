Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42A8610BF0
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 10:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJ1ILL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 04:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJ1ILJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 04:11:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D3D52E6B
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 01:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666944613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=g5oM+pS1i7LJO/8MBRo3XO+oDgdVL+ZwZwWMM7q2JIw=;
        b=cKLL0YFVh9hRwOylnz0GhCiKP3z4VxvBmjcOnRDtHC33V0Loy2JzSDh51vA6WNraoh2Pqn
        1bzIFXcw12WLIuLqiL14tavTYeQWM7SX2MLK8B2qr0+dm/30beBG99GU5VTY8aU+hBkZuo
        7KhgCItiJlPJC6F7rjjAihm37/4afPU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-mgwQpP3tOoasAeoJDIG6hQ-1; Fri, 28 Oct 2022 04:10:11 -0400
X-MC-Unique: mgwQpP3tOoasAeoJDIG6hQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2FD93804069
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 08:10:10 +0000 (UTC)
Received: from localhost (unknown [10.66.60.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24FD4477F5C;
        Fri, 28 Oct 2022 08:10:09 +0000 (UTC)
From:   Zhi Li <yieli@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, Zhi Li <yieli@redhat.com>
Subject: [PATCH] [nfs/nfs-utils/libtirpc] clnt_raw.c: fix a possible null pointer dereference
Date:   Fri, 28 Oct 2022 16:09:58 +0800
Message-Id: <20221028080958.236130-1-yieli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

