Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA08317ABB
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2019 15:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfEHNfp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 09:35:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbfEHNfp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 8 May 2019 09:35:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15461821EF
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:45 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-59.phx2.redhat.com [10.3.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4DE15C269
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:44 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 11/19] Removed resource leaks from systemd/rpc-pipefs-generator.c
Date:   Wed,  8 May 2019 09:35:28 -0400
Message-Id: <20190508133536.6077-12-steved@redhat.com>
In-Reply-To: <20190508133536.6077-1-steved@redhat.com>
References: <20190508133536.6077-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 08 May 2019 13:35:45 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

systemd/rpc-pipefs-generator.c:73: leaked_storage: Variable "pipefs_unit"
	going out of scope leaks the storage it points to
systemd/rpc-pipefs-generator.c:77: leaked_storage: Variable "pipefs_unit"
	going out of scope leaks the storage it points to.
systemd/rpc-pipefs-generator.c:85: leaked_storage: Variable "pipefs_unit"
	going out of scope leaks the storage it points to.
systemd/rpc-pipefs-generator.c:94: leaked_storage: Variable "pipefs_unit"
	going out of scope leaks the storage it points to.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 systemd/rpc-pipefs-generator.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/systemd/rpc-pipefs-generator.c b/systemd/rpc-pipefs-generator.c
index 0b5da11..8e218aa 100644
--- a/systemd/rpc-pipefs-generator.c
+++ b/systemd/rpc-pipefs-generator.c
@@ -69,12 +69,16 @@ int generate_target(char *pipefs_path, const char *dirname)
 		return 1;
 
 	ret = generate_mount_unit(pipefs_path, pipefs_unit, dirname);
-	if (ret)
+	if (ret) {
+		free(pipefs_unit);
 		return ret;
+	}
 
 	path = malloc(strlen(dirname) + 1 + sizeof(filebase));
-	if (!path)
+	if (!path) {
+		free(pipefs_unit);
 		return 2;
+	}
 	sprintf(path, "%s", dirname);
 	mkdir(path, 0755);
 	strcat(path, filebase);
@@ -82,6 +86,7 @@ int generate_target(char *pipefs_path, const char *dirname)
 	if (!f)
 	{
 		free(path);
+		free(pipefs_unit);
 		return 1;
 	}
 
@@ -90,6 +95,7 @@ int generate_target(char *pipefs_path, const char *dirname)
 	fprintf(f, "After=%s\n", pipefs_unit);
 	fclose(f);
 	free(path);
+	free(pipefs_unit);
 
 	return 0;
 }
-- 
2.20.1

