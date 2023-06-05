Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C45A72270D
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jun 2023 15:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjFENL6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Jun 2023 09:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjFENL5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Jun 2023 09:11:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA91F4;
        Mon,  5 Jun 2023 06:11:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AC2A61596;
        Mon,  5 Jun 2023 13:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCC9C433EF;
        Mon,  5 Jun 2023 13:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685970704;
        bh=JIXoAPGYH+D36mtY9fzPYdt82/t5oQYK/F22Hl2yS34=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DAbpw0a1TqFtb9OvQchbumcwARk45gT3DPA6H94P8IlfDhGgy+JUDi0MyK71kWmi0
         Y2nxYROa/gRWxdyVliDy17roRPsprB7qDB8nAF+aKfTulevzOfUfLyx4eHKfmVmh/s
         15+FN5WKjTW9dYMVZD3Tz37pCvLTU5F0in7N6XZ85xtYAm0KYqt4qhu8I5CCIC9Vem
         iEBibqbLtGHx+o94eB/6YMGGd91aTvlHFUv/72U4FXMmG3gVGR6YEm8S5EN6obdf3Q
         BoosTE9RoLvlEPxaKQypvDrWE9A+0B45n/XqZB9z/MTVvDeON2c/Bh6xrRSkkvbOUa
         OhGJOmOxICPbg==
Subject: [PATCH v1 4/4] svcrdma: Clean up allocation of svc_rdma_rw_ctxt
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        tom@talpey.com
Date:   Mon, 05 Jun 2023 09:11:43 -0400
Message-ID: <168597070368.7694.12360357990371202566.stgit@manet.1015granger.net>
In-Reply-To: <168597050247.7694.8719658227499409307.stgit@manet.1015granger.net>
References: <168597050247.7694.8719658227499409307.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The physical device's favored NUMA node ID is available when
allocating a rw_ctxt. Use that value instead of relying on the
assumption that the memory allocation happens to be running on a
node close to the device.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 11cf7c646644..068c365e7812 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -62,8 +62,8 @@ svc_rdma_get_rw_ctxt(struct svcxprt_rdma *rdma, unsigned int sges)
 	if (node) {
 		ctxt = llist_entry(node, struct svc_rdma_rw_ctxt, rw_node);
 	} else {
-		ctxt = kmalloc(struct_size(ctxt, rw_first_sgl, SG_CHUNK_SIZE),
-			       GFP_KERNEL);
+		ctxt = kmalloc_node(struct_size(ctxt, rw_first_sgl, SG_CHUNK_SIZE),
+				    GFP_KERNEL, ibdev_to_node(rdma->sc_cm_id->device));
 		if (!ctxt)
 			goto out_noctx;
 
@@ -234,7 +234,8 @@ svc_rdma_write_info_alloc(struct svcxprt_rdma *rdma,
 {
 	struct svc_rdma_write_info *info;
 
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	info = kmalloc_node(sizeof(*info), GFP_KERNEL,
+			    ibdev_to_node(rdma->sc_cm_id->device));
 	if (!info)
 		return info;
 
@@ -304,7 +305,8 @@ svc_rdma_read_info_alloc(struct svcxprt_rdma *rdma)
 {
 	struct svc_rdma_read_info *info;
 
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	info = kmalloc_node(sizeof(*info), GFP_KERNEL,
+			    ibdev_to_node(rdma->sc_cm_id->device));
 	if (!info)
 		return info;
 


