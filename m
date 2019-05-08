Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB3917AB8
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2019 15:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfEHNfo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 09:35:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfEHNfn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 8 May 2019 09:35:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C58C1DC8FF
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:43 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-59.phx2.redhat.com [10.3.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 813E95C269
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:43 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 08/19] Removed resource leaks from nfsidmap/libnfsidmap.c
Date:   Wed,  8 May 2019 09:35:25 -0400
Message-Id: <20190508133536.6077-9-steved@redhat.com>
In-Reply-To: <20190508133536.6077-1-steved@redhat.com>
References: <20190508133536.6077-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 08 May 2019 13:35:43 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsidmap/libnfsidmap.c:410: leaked_storage: Variable "nfs4_methods"
	going out of scope leaks the storage it points to.

ibnfsidmap.c:483: leaked_storage: Variable "gss_methods"
	going out of scope leaks the storage it points to.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/nfsidmap/libnfsidmap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/libnfsidmap.c
index 35ddf01..7b8a871 100644
--- a/support/nfsidmap/libnfsidmap.c
+++ b/support/nfsidmap/libnfsidmap.c
@@ -406,8 +406,10 @@ int nfs4_init_name_mapping(char *conffile)
 	nfs4_methods = conf_get_list("Translation", "Method");
 	if (nfs4_methods) {
 		IDMAP_LOG(1, ("libnfsidmap: processing 'Method' list"));
-		if (load_plugins(nfs4_methods, &nfs4_plugins) == -1)
+		if (load_plugins(nfs4_methods, &nfs4_plugins) == -1) {
+			conf_free_list(nfs4_methods);
 			return -ENOENT;
+		}
 	} else {
 		struct conf_list list;
 		struct conf_list_node node;
@@ -475,11 +477,15 @@ out:
 	if (ret) {
 		if (nfs4_plugins)
 			unload_plugins(nfs4_plugins);
-		if (gss_plugins)
+		if (gss_plugins) {
 			unload_plugins(gss_plugins);
+		}
 		nfs4_plugins = gss_plugins = NULL;
 	}
 
+	if (gss_methods)
+		conf_free_list(gss_methods);
+
 	return ret ? -ENOENT: 0;
 }
 
-- 
2.20.1

