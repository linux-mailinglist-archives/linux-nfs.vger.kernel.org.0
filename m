Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B16117ABD
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2019 15:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfEHNfq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 09:35:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36197 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbfEHNfq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 8 May 2019 09:35:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 826783060486
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:46 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-59.phx2.redhat.com [10.3.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 379A65C640
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:45 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 12/19] Removed resource leaks from blkmapd/device-discovery.c
Date:   Wed,  8 May 2019 09:35:29 -0400
Message-Id: <20190508133536.6077-13-steved@redhat.com>
In-Reply-To: <20190508133536.6077-1-steved@redhat.com>
References: <20190508133536.6077-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 08 May 2019 13:35:46 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

blkmapd/device-discovery.c:190: leaked_storage: Variable "serial"
	going out of scope leaks the storage it points to.

blkmapd/device-discovery.c:378: overwrite_var: Overwriting handle
	"bl_pipe_fd" in "bl_pipe_fd = open(bl_pipe_file, 2)" leaks the handle.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/blkmapd/device-discovery.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/utils/blkmapd/device-discovery.c b/utils/blkmapd/device-discovery.c
index 2ce60f8..e811703 100644
--- a/utils/blkmapd/device-discovery.c
+++ b/utils/blkmapd/device-discovery.c
@@ -186,8 +186,13 @@ static void bl_add_disk(char *filepath)
 		}
 	}
 
-	if (disk && diskpath)
+	if (disk && diskpath) {
+		if (serial) {
+			free(serial->data);
+			free(serial);
+		}
 		return;
+	}
 
 	/* add path */
 	path = malloc(sizeof(struct bl_disk_path));
@@ -223,6 +228,10 @@ static void bl_add_disk(char *filepath)
 			disk->size = size;
 			disk->valid_path = path;
 		}
+		if (serial) {
+			free(serial->data);
+			free(serial);
+		}
 	}
 	return;
 
@@ -232,6 +241,10 @@ static void bl_add_disk(char *filepath)
 			free(path->full_path);
 		free(path);
 	}
+	if (serial) {
+		free(serial->data);
+		free(serial);
+	}
 	return;
 }
 
@@ -375,7 +388,12 @@ static void bl_rpcpipe_cb(void)
 			if (event->mask & IN_CREATE) {
 				BL_LOG_WARNING("nfs pipe dir created\n");
 				bl_watch_dir(nfspipe_dir, &nfs_pipedir_wfd);
+				if (bl_pipe_fd >= 0)
+					close(bl_pipe_fd);
 				bl_pipe_fd = open(bl_pipe_file, O_RDWR);
+				if (bl_pipe_fd < 0)
+					BL_LOG_ERR("open %s failed: %s\n",
+						event->name, strerror(errno));
 			} else if (event->mask & IN_DELETE) {
 				BL_LOG_WARNING("nfs pipe dir deleted\n");
 				inotify_rm_watch(bl_watch_fd, nfs_pipedir_wfd);
@@ -388,6 +406,8 @@ static void bl_rpcpipe_cb(void)
 				continue;
 			if (event->mask & IN_CREATE) {
 				BL_LOG_WARNING("blocklayout pipe file created\n");
+				if (bl_pipe_fd >= 0)
+					close(bl_pipe_fd);
 				bl_pipe_fd = open(bl_pipe_file, O_RDWR);
 				if (bl_pipe_fd < 0)
 					BL_LOG_ERR("open %s failed: %s\n",
-- 
2.20.1

