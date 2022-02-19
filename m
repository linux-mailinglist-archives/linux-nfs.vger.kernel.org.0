Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43BF4BC96A
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Feb 2022 17:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiBSQq7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Feb 2022 11:46:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236550AbiBSQq6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Feb 2022 11:46:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 430B7AE6F
        for <linux-nfs@vger.kernel.org>; Sat, 19 Feb 2022 08:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645289195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gKLaJW54E35gD7rMoix+5ULJR5gA/lohwFiJwawTIrA=;
        b=NZBjZzNDh7oaphf1Y2ywKdkyMwNKBzclKcvSLUSaTNECDOt9z+ajemPxs+jsgEWvc2XIdO
        xultD5hsl6R81VscdhxB43V0H+6n68lkq4Hoy+T/CDd2gofBqtL2XUx8RHRle29GErPA4v
        45m2mXzVmMsFneK5XrS3XAJQdVjKgUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-AdjyAUpROLKiYEPeiuf8Sg-1; Sat, 19 Feb 2022 11:46:33 -0500
X-MC-Unique: AdjyAUpROLKiYEPeiuf8Sg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D1C680A1BE
        for <linux-nfs@vger.kernel.org>; Sat, 19 Feb 2022 16:46:32 +0000 (UTC)
Received: from madhat.home.dicksonnet.net (unknown [10.2.16.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41339348F4
        for <linux-nfs@vger.kernel.org>; Sat, 19 Feb 2022 16:46:32 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] mount.nfs: Fix Typo auto negotiating code.
Date:   Sat, 19 Feb 2022 11:46:31 -0500
Message-Id: <20220219164631.38534-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit 14258541 add a check that had a '||'
instead of a '&&' which is the typo.

The intention of commit 14258541 was to show
EBUSY errors but this error is not shown when
the mount point does exists (commit afda50fc).

In the end, EBUSY are now interrupted correctly
in this corner case.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/mount/stropts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
index 573df6e..dbdd11e 100644
--- a/utils/mount/stropts.c
+++ b/utils/mount/stropts.c
@@ -973,7 +973,7 @@ fall_back:
 	if ((result = nfs_try_mount_v3v2(mi, FALSE)))
 		return result;
 
-	if (errno != EBUSY || errno != EACCES)
+	if (errno != EBUSY && errno != EACCES)
 		errno = olderrno;
 
 	return result;
-- 
2.35.1

