Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA3D17AC2
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2019 15:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfEHNft (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 09:35:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727404AbfEHNft (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 8 May 2019 09:35:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0E9ECA1DF
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:49 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-59.phx2.redhat.com [10.3.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B2561724D
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:49 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 17/19] Removed resource leaks from mountd/cache.c
Date:   Wed,  8 May 2019 09:35:34 -0400
Message-Id: <20190508133536.6077-18-steved@redhat.com>
In-Reply-To: <20190508133536.6077-1-steved@redhat.com>
References: <20190508133536.6077-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 08 May 2019 13:35:49 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

mountd/cache.c:1244:3: warning: statement will never be
	executed [-Wswitch-unreachable]

mountd/cache.c:1260: leaked_storage: Variable "locations"
	going out of scope leaks the storage it points to.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/mountd/cache.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
index 2cb370f..bdbd190 100644
--- a/utils/mountd/cache.c
+++ b/utils/mountd/cache.c
@@ -1240,7 +1240,7 @@ static struct exportent *lookup_junction(char *dom, const char *pathname,
 		goto out;
 	}
 	status = nfs_get_basic_junction(pathname, &locations);
-	switch (status) {
+	if (status) {
 		xlog(L_WARNING, "Dangling junction %s: %s",
 			pathname, strerror(status));
 		goto out;
@@ -1248,10 +1248,11 @@ static struct exportent *lookup_junction(char *dom, const char *pathname,
 
 	parent = lookup_parent_export(dom, pathname, ai);
 	if (parent == NULL)
-		goto out;
+		goto free_locations;
 
 	exp = locations_to_export(locations, pathname, parent);
 
+free_locations:
 	nfs_free_locations(locations->ns_list);
 	free(locations);
 
-- 
2.20.1

