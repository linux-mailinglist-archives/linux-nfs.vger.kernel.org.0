Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488794C3557
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 20:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiBXTGl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 14:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiBXTGk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 14:06:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B56C81E6947
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 11:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645729568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ga6IpuS3zJPXUwQECcaZA6QGlljuCly3VfKW9XSsQxM=;
        b=O4U5x//L7R8oQiDeZdy38vXs328DwcjbFW3ds+JlTc9WlbcnHbIEx8MHqktOaG+HGzO420
        5gN7yu9VXrN+FCeRB00CI3iBcJcc7dqsItS9gMPmSUm4e+HGkAPDmhVnFTcXufPoYp2gcf
        o0lSSq5hM/AvUO3hr/dmT4ZQFJpHftY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-4F-DfOafPUWEu0XHSHQWng-1; Thu, 24 Feb 2022 14:06:07 -0500
X-MC-Unique: 4F-DfOafPUWEu0XHSHQWng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A032D5123
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 19:06:06 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.11.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 355E35F4E7
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 19:06:06 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] mountd: Fix potential data corrupter
Date:   Thu, 24 Feb 2022 14:06:04 -0500
Message-Id: <20220224190604.291491-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit 9c99b463 typecast an uint into a int
to fix a Coverity warning. Potentially this
could cause a very large rogue value to be
negative allow the rouge value to index into
a table causing corruption.

A check has been added to detect this type
of situation.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/nfs/rpcdispatch.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/support/nfs/rpcdispatch.c b/support/nfs/rpcdispatch.c
index f7c27c98..7329f419 100644
--- a/support/nfs/rpcdispatch.c
+++ b/support/nfs/rpcdispatch.c
@@ -26,12 +26,13 @@ rpc_dispatch(struct svc_req *rqstp, SVCXPRT *transp,
 			void *argp, void *resp)
 {
 	struct rpc_dentry	*dent;
+	int rq_vers = (int)rqstp->rq_vers;
 
-	if (((int)rqstp->rq_vers) > nvers) {
+	if (rq_vers < 1 || rq_vers > nvers) {
 		svcerr_progvers(transp, 1, nvers);
 		return;
 	}
-	dtable += (rqstp->rq_vers - 1);
+	dtable += (rq_vers - 1);
 	if (rqstp->rq_proc > dtable->nproc) {
 		svcerr_noproc(transp);
 		return;
-- 
2.34.1

