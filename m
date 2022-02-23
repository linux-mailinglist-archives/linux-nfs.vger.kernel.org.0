Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070674C1D10
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 21:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiBWUVy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 15:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiBWUVx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 15:21:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 010204D24F
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 12:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645647684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=u8kVwqcjIrD5zUdSjqNqhAiLPf0+xMjZB8/slyK3y54=;
        b=ETX16i3dcxlTZVtFX//qMwIybAtJN6xnsQMDSvYzlnmPVy/eHKCM+wrxln2wK6Kb3Feb+/
        kDdzoETAKAN70zR5uwAD/57BC9O3cbHVSsN3ChDlS4emYQq0XA/bIEccFViCcy0ZEImYvK
        6roOoqXtVQACr2m/AQKmgem2pjL7YS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-G_v3OKqSOmiY5LGirGHCIg-1; Wed, 23 Feb 2022 15:21:22 -0500
X-MC-Unique: G_v3OKqSOmiY5LGirGHCIg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4A8E1006AA5
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 20:21:21 +0000 (UTC)
Received: from madhat.home.dicksonnet.net (unknown [10.2.18.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 992DC61F20
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 20:21:21 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] systemd: Fix format-overflow warning
Date:   Wed, 23 Feb 2022 15:21:20 -0500
Message-Id: <20220223202120.126170-1-steved@redhat.com>
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

rpc-pipefs-generator.c:35:23: error: '%s' directive output between 0 and 2147483653 bytes may exceed minimum required size of 4095 [-Werror=format-overflow=]
   35 |         sprintf(path, "%s/%s", dirname, pipefs_unit);
      |                       ^

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 systemd/rpc-pipefs-generator.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/systemd/rpc-pipefs-generator.c b/systemd/rpc-pipefs-generator.c
index c24db56..7b2bb4f 100644
--- a/systemd/rpc-pipefs-generator.c
+++ b/systemd/rpc-pipefs-generator.c
@@ -28,11 +28,12 @@ static int generate_mount_unit(const char *pipefs_path, const char *pipefs_unit,
 {
 	char	*path;
 	FILE	*f;
+	size_t size = (strlen(dirname) + 1 + strlen(pipefs_unit));
 
-	path = malloc(strlen(dirname) + 1 + strlen(pipefs_unit));
+	path = malloc(size);
 	if (!path)
 		return 1;
-	sprintf(path, "%s/%s", dirname, pipefs_unit);
+	snprintf(path, size, "%s/%s", dirname, pipefs_unit);
 	f = fopen(path, "w");
 	if (!f)
 	{
-- 
2.35.1

