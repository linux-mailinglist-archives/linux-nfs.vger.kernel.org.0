Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D6177601A
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Aug 2023 15:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjHINBF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Aug 2023 09:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjHINBE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Aug 2023 09:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBF71FF9
        for <linux-nfs@vger.kernel.org>; Wed,  9 Aug 2023 06:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691586022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZENLl+nsBszxlzOow1CP78a1ab8afmrbo7G80mFVNxM=;
        b=hqxNwY0a5z4hyKxk6nDMyCzS2R5hZJiuXXG7J0nzZbfBG+VKJjZyeGLQtYEoJOu6h/nVPt
        HVOt6kk8V7nTI1795/5d7LGDqfT2PqNmrukmXARLPmrzoRWomPvigpkogu9xYTkiqYYXoU
        zJgXzetxlQ8NRfNJd3rz8hlO0IY5PSs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-qoVmHXVeNPe4741OfsFP-w-1; Wed, 09 Aug 2023 09:00:20 -0400
X-MC-Unique: qoVmHXVeNPe4741OfsFP-w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60F7A802A7D
        for <linux-nfs@vger.kernel.org>; Wed,  9 Aug 2023 13:00:20 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.33.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35DBF2166B25
        for <linux-nfs@vger.kernel.org>; Wed,  9 Aug 2023 13:00:20 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] Fixed a regression in the junction code
Date:   Wed,  9 Aug 2023 09:00:18 -0400
Message-ID: <20230809130018.184633-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

commit cdbef4e9 created a regression in the
in the junction code by adding a O_PATH flag
to the open() in junction_open_path()

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2213669
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/junction/junction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/support/junction/junction.c b/support/junction/junction.c
index 0628bb0f..c1ec8ff8 100644
--- a/support/junction/junction.c
+++ b/support/junction/junction.c
@@ -63,7 +63,7 @@ junction_open_path(const char *pathname, int *fd)
 	if (pathname == NULL || fd == NULL)
 		return FEDFS_ERR_INVAL;
 
-	tmp = open(pathname, O_PATH|O_DIRECTORY);
+	tmp = open(pathname, O_DIRECTORY);
 	if (tmp == -1) {
 		switch (errno) {
 		case EPERM:
-- 
2.41.0

