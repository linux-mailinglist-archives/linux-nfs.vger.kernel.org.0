Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 200AA17ABC
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2019 15:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfEHNfp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 09:35:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbfEHNfo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 8 May 2019 09:35:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3BB09308795C
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:44 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-59.phx2.redhat.com [10.3.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E939E5C269
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:43 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 09/19] Removed resource leaks from nfsidmap/static.c
Date:   Wed,  8 May 2019 09:35:26 -0400
Message-Id: <20190508133536.6077-10-steved@redhat.com>
In-Reply-To: <20190508133536.6077-1-steved@redhat.com>
References: <20190508133536.6077-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 08 May 2019 13:35:44 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsidmap/static.c:350: leaked_storage: Variable "princ_list"
        going out of scope leaks the storage it points to.
nfsidmap/static.c:358: leaked_storage: Variable "princ_list"
        going out of scope leaks the storage it points to.
nfsidmap/static.c:360: leaked_storage: Variable "unode"
	going out of scope leaks the storage it points to.
nfsidmap/static.c:382: leaked_storage: Variable "princ_list"
        going out of scope leaks the storage it points to.
nfsidmap/static.c:390: leaked_storage: Variable "gnode"
	going out of scope leaks the storage it points to.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/nfsidmap/static.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/support/nfsidmap/static.c b/support/nfsidmap/static.c
index f7b8a67..8ac4a39 100644
--- a/support/nfsidmap/static.c
+++ b/support/nfsidmap/static.c
@@ -347,6 +347,7 @@ static int static_init(void) {
 			warnx("static_init: calloc (1, %lu) failed",
 				(unsigned long)sizeof *unode);
 			free(pw);
+			conf_free_list(princ_list);
 			return -ENOMEM;
 		}
 		unode->uid = pw->pw_uid;
@@ -355,6 +356,9 @@ static int static_init(void) {
 		unode->localname = conf_get_str("Static", cln->field);
 		if (!unode->localname) {
 			free(pw);
+			free(unode->principal);
+			free(unode);
+			conf_free_list(princ_list);
 			return -ENOENT;
 		}
 
@@ -379,6 +383,7 @@ static int static_init(void) {
 			warnx("static_init: calloc (1, %lu) failed",
 				(unsigned long)sizeof *gnode);
 			free(gr);
+			conf_free_list(princ_list);
 			return -ENOMEM;
 		}
 		gnode->gid = gr->gr_gid;
@@ -387,6 +392,9 @@ static int static_init(void) {
 		gnode->localgroup = conf_get_str("Static", cln->field);
 		if (!gnode->localgroup) {
 			free(gr);
+			free(gnode->principal);
+			free(gnode);
+			conf_free_list(princ_list);
 			return -ENOENT;
 		}
 
@@ -394,6 +402,8 @@ static int static_init(void) {
 
 		LIST_INSERT_HEAD (&gid_mappings[gid_hash(gnode->gid)], gnode, link);
 	}
+	
+	conf_free_list(princ_list);
 	return 0;
 }
 
-- 
2.20.1

