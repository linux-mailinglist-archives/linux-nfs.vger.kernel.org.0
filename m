Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A52D17AC4
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2019 15:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfEHNfv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 09:35:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9289 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727414AbfEHNfu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 8 May 2019 09:35:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 800AD2D7EF
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:50 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-59.phx2.redhat.com [10.3.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37C0F61D02
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:50 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 19/19] Removed a resource leak from nfsdcltrack/sqlite.c
Date:   Wed,  8 May 2019 09:35:36 -0400
Message-Id: <20190508133536.6077-20-steved@redhat.com>
In-Reply-To: <20190508133536.6077-1-steved@redhat.com>
References: <20190508133536.6077-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 08 May 2019 13:35:50 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsdcltrack/sqlite.c:218: leaked_storage: Variable "err" going out
	of scope leaks the storage it points to.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/nfsdcltrack/sqlite.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/utils/nfsdcltrack/sqlite.c b/utils/nfsdcltrack/sqlite.c
index c59f777..2801201 100644
--- a/utils/nfsdcltrack/sqlite.c
+++ b/utils/nfsdcltrack/sqlite.c
@@ -215,6 +215,8 @@ sqlite_maindb_init_v2(void)
 				&err);
 	if (ret != SQLITE_OK) {
 		xlog(L_ERROR, "Unable to begin transaction: %s", err);
+		if (err)
+			sqlite3_free(err);
 		return ret;
 	}
 
-- 
2.20.1

