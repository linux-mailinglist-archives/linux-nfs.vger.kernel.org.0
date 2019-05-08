Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4C9817ABF
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2019 15:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfEHNfr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 09:35:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35119 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbfEHNfr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 8 May 2019 09:35:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5B6E33087951
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:47 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-59.phx2.redhat.com [10.3.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14F021724D
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:47 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 14/19] Removed a resource leak from mount/configfile.c
Date:   Wed,  8 May 2019 09:35:31 -0400
Message-Id: <20190508133536.6077-15-steved@redhat.com>
In-Reply-To: <20190508133536.6077-1-steved@redhat.com>
References: <20190508133536.6077-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 08 May 2019 13:35:47 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

mount/configfile.c:410: leaked_storage: Variable "config_opts"
	going out of scope leaks the storage it points to.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/mount/configfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/mount/configfile.c b/utils/mount/configfile.c
index b48b25e..93fe500 100644
--- a/utils/mount/configfile.c
+++ b/utils/mount/configfile.c
@@ -404,7 +404,7 @@ char *conf_get_mntopts(char *spec, char *mount_point,
 
 	/* list_size + optlen + ',' + '\0' */
 	config_opts = calloc(1, (list_size+optlen+2));
-	if (server == NULL) {
+	if (config_opts == NULL) {
 		xlog_warn("conf_get_mountops: Unable calloc memory for config_opts"); 
 		free_all();
 		return mount_opts;
-- 
2.20.1

