Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E190357D3FD
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jul 2022 21:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiGUTS2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 15:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGUTS2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 15:18:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6EDB257
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 12:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658431105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pFC7DBUzRNxjy2P8VuhVKf+CK1KK7WgBOXSnSXjnCMc=;
        b=B8WgV9fz0/xzDkGbDgnh3OtN9bPp3CfLPXH8wGLOtluxSvPvSJMc6dAo0kIX2ddVyzNgno
        rCdc0VgaHHeI06174m3ZYhZpELt4dyF9uwsh9dNZ9aYkhscB2L14Qxo1veQ05nnoqclcyi
        5yyrBQOhMouX8r+jLQip5RYdR1bI6+M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-6NZiQbwnO1SE2J-syANpeA-1; Thu, 21 Jul 2022 15:18:18 -0400
X-MC-Unique: 6NZiQbwnO1SE2J-syANpeA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03CFD185A7B2
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 19:18:18 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.8.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA7A52166B2A
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 19:18:16 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] rpc-pipefs-generator: allocate enough space for pipefs-directory buffer
Date:   Thu, 21 Jul 2022 15:18:12 -0400
Message-Id: <20220721191812.60294-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit 7f8463fe fixed a warning but introduce
a regression by not allocating enough space
for the pipefs-directory buffer when it is
not the default.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2106896
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 systemd/rpc-pipefs-generator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/systemd/rpc-pipefs-generator.c b/systemd/rpc-pipefs-generator.c
index 7b2bb4f7..3aaeaeaf 100644
--- a/systemd/rpc-pipefs-generator.c
+++ b/systemd/rpc-pipefs-generator.c
@@ -28,7 +28,7 @@ static int generate_mount_unit(const char *pipefs_path, const char *pipefs_unit,
 {
 	char	*path;
 	FILE	*f;
-	size_t size = (strlen(dirname) + 1 + strlen(pipefs_unit));
+	size_t size = (strlen(dirname) + 1 + strlen(pipefs_unit) + 1);
 
 	path = malloc(size);
 	if (!path)
-- 
2.36.1

