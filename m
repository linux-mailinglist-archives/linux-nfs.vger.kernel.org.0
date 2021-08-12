Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DEC3EA9FC
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Aug 2021 20:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbhHLSNz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Aug 2021 14:13:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35470 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237510AbhHLSNz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Aug 2021 14:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628792009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a6re5z/1xFOfyfCufrSByXvH7aWkIdHvmtevdKf9iAA=;
        b=SWSb8Bcdx8+CpWoiRKLR5ppPvEr2RHROGd515OEZTx6AeJNYnf32iiKWILVx7oG/uwiFha
        /uBwSSn/1vBaO6flXZdAiySLGOX032IoiVsyiA55mp8swdOJo5HWPxkRFuxATYRzltjY6m
        AsIRqKM48orq49McpnMDETLCO9MJGWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-sDlMH8DQPMeQh3xRJYV3iQ-1; Thu, 12 Aug 2021 14:13:28 -0400
X-MC-Unique: sDlMH8DQPMeQh3xRJYV3iQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6668C8015C7
        for <linux-nfs@vger.kernel.org>; Thu, 12 Aug 2021 18:13:27 +0000 (UTC)
Received: from ajmitchell.com (unknown [10.39.192.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CF4760657;
        Thu, 12 Aug 2021 18:13:26 +0000 (UTC)
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, Alice Mitchell <ajmitchell@redhat.com>
Subject: [PATCH 2/4 v2] nfs-utils: Fix mem leaks in gssd
Date:   Thu, 12 Aug 2021 19:13:17 +0100
Message-Id: <20210812181319.3885781-3-ajmitchell@redhat.com>
In-Reply-To: <20210812181319.3885781-1-ajmitchell@redhat.com>
References: <20210812181319.3885781-1-ajmitchell@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

ccachedir_copy isnt used properly and is leaking, ccachedir gets modified
by a strtok, altering the original argv or conf parameter which is an
undesirable side-effect

Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>
---
 utils/gssd/gssd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
index 4113cba..833d8e0 100644
--- a/utils/gssd/gssd.c
+++ b/utils/gssd/gssd.c
@@ -1016,7 +1016,7 @@ read_gss_conf(void)
 		keytabfile = s;
 	s = conf_get_str("gssd", "cred-cache-directory");
 	if (s)
-		ccachedir = s;
+		ccachedir = strdup(s);
 	s = conf_get_str("gssd", "preferred-realm");
 	if (s)
 		preferred_realm = s;
@@ -1070,7 +1070,8 @@ main(int argc, char *argv[])
 				keytabfile = optarg;
 				break;
 			case 'd':
-				ccachedir = optarg;
+				free(ccachedir);
+				ccachedir = strdup(optarg);
 				break;
 			case 't':
 				context_timeout = atoi(optarg);
@@ -1133,7 +1134,6 @@ main(int argc, char *argv[])
 	}
 
 	if (ccachedir) {
-		char *ccachedir_copy;
 		char *ptr;
 
 		for (ptr = ccachedir, i = 2; *ptr; ptr++)
@@ -1141,8 +1141,7 @@ main(int argc, char *argv[])
 				i++;
 
 		ccachesearch = malloc(i * sizeof(char *));
-	       	ccachedir_copy = strdup(ccachedir);
-		if (!ccachedir_copy || !ccachesearch) {
+		if (!ccachesearch) {
 			printerr(0, "malloc failure\n");
 			exit(EXIT_FAILURE);
 		}
@@ -1274,6 +1273,7 @@ main(int argc, char *argv[])
 
 	free(preferred_realm);
 	free(ccachesearch);
+	free(ccachedir);
 
 	return rc < 0 ? EXIT_FAILURE : EXIT_SUCCESS;
 }
-- 
2.27.0

