Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5B524FCCE
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Aug 2020 13:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgHXLkt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Aug 2020 07:40:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60170 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726938AbgHXLh3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Aug 2020 07:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598268999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4bXTwf0rq9aPBhb3R6noIkCWiK8Yp19kFDNnbB7SpNE=;
        b=YCrj+PK+M+bjah1BPozRH+8y7t2VH8sIMicbLIb+IQodVUAxXHRzGmWVccwEqTm16uXYdF
        /LsRkim4lD1Q5wWMSdqcbA//1GcLFcnraAHjORz0joS1T3kfcozypGgcuFkaDwgFm03AV3
        KHN8NggwTodr0k1pwncd28JSoELugng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-n22_oiYBNM2x1fW_z5HHwg-1; Mon, 24 Aug 2020 07:36:36 -0400
X-MC-Unique: n22_oiYBNM2x1fW_z5HHwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11FB51DDEA
        for <linux-nfs@vger.kernel.org>; Mon, 24 Aug 2020 11:36:36 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-70.phx2.redhat.com [10.3.112.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0A3260CD1
        for <linux-nfs@vger.kernel.org>; Mon, 24 Aug 2020 11:36:35 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] rpc.idmapd: rework the verbosity of idmapd
Date:   Mon, 24 Aug 2020 07:36:33 -0400
Message-Id: <20200824113633.246214-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

-v   means only error
-vv  errors and informational messages
-vvv all debugging messages will be displayed

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/idmapd/idmapd.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
index 7d1096d..f3d2314 100644
--- a/utils/idmapd/idmapd.c
+++ b/utils/idmapd/idmapd.c
@@ -365,7 +365,7 @@ main(int argc, char **argv)
 	if (evbase == NULL)
 		errx(1, "Failed to create event base.");
 
-	if (verbose > 0)
+	if (verbose > 1)
 		xlog_warn("Expiration time is %d seconds.",
 			     cache_entry_expiration);
 	if (serverstart) {
@@ -500,7 +500,7 @@ flush_inotify(int fd)
 		     ptr += sizeof(struct inotify_event) + ev->len) {
 
 			ev = (const struct inotify_event *)ptr;
-			if (verbose > 1)
+			if (verbose > 2)
 				xlog_warn("pipefs inotify: wd=%i, mask=0x%08x, len=%i, name=%s",
 				  ev->wd, ev->mask, ev->len, ev->len ? ev->name : "");
 		}
@@ -562,7 +562,7 @@ dirscancb(int fd, short UNUSED(which), void *data)
 				goto out;
 			}
 
-			if (verbose > 0)
+			if (verbose > 2)
 				xlog_warn("New client: %s", ic->ic_clid);
 
 			ic->ic_id = "Client";
@@ -585,7 +585,7 @@ dirscancb(int fd, short UNUSED(which), void *data)
 			if (ic->ic_dirfd != -1)
 				close(ic->ic_dirfd);
 			TAILQ_REMOVE(icq, ic, ic_next);
-			if (verbose > 0) {
+			if (verbose > 2) {
 				xlog_warn("Stale client: %s", ic->ic_clid);
 				xlog_warn("\t-> closed %s", ic->ic_path);
 			}
@@ -665,7 +665,7 @@ nfsdcb(int UNUSED(fd), short which, void *data)
 		xlog_warn("nfsdcb: bad type in upcall\n");
 		return;
 	}
-	if (verbose > 0)
+	if (verbose > 2)
 		xlog_warn("nfsdcb: authbuf=%s authtype=%s",
 			     authbuf, typebuf);
 
@@ -847,7 +847,7 @@ nfsdreopen_one(struct idmap_client *ic)
 {
 	int fd;
 
-	if (verbose > 0)
+	if (verbose > 2)
 		xlog_warn("ReOpening %s", ic->ic_path);
 
 	if ((fd = open(ic->ic_path, O_RDWR, 0)) != -1) {
@@ -913,7 +913,7 @@ nfsdopenone(struct idmap_client *ic)
 	}
 	event_add(ic->ic_event, NULL);
 
-	if (verbose > 0)
+	if (verbose > 2)
 		xlog_warn("Opened %s", ic->ic_path);
 
 	return (0);
@@ -932,7 +932,8 @@ nfsopen(struct idmap_client *ic)
 			*slash = 0;
 			inotify_add_watch(inotify_fd, ic->ic_path, IN_CREATE | IN_ONLYDIR | IN_ONESHOT);
 			*slash = '/';
-			xlog_warn("Path %s not available. waiting...", ic->ic_path);
+			if (verbose > 2)
+				xlog_warn("Path %s not available. waiting...", ic->ic_path);
 			return -1;
 		}
 
@@ -948,7 +949,7 @@ nfsopen(struct idmap_client *ic)
 		return -1;
 	}
 	event_add(ic->ic_event, NULL);
-	if (verbose > 0)
+	if (verbose > 2)
 		xlog_warn("Opened %s", ic->ic_path);
 
 	return (0);
-- 
2.26.2

