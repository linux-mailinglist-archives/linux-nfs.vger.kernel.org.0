Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA817AB9
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2019 15:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfEHNfo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 09:35:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfEHNfn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 8 May 2019 09:35:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61D0D3087BD2
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:43 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-59.phx2.redhat.com [10.3.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18AE95C269
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:43 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 07/19] Removed resource leaks from nfs/xlog.c
Date:   Wed,  8 May 2019 09:35:24 -0400
Message-Id: <20190508133536.6077-8-steved@redhat.com>
In-Reply-To: <20190508133536.6077-1-steved@redhat.com>
References: <20190508133536.6077-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 08 May 2019 13:35:43 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs/xlog.c:139: leaked_storage: Variable "kinds" going out
	of scope leaks the storage it points to.

nfs/xlog.c:142: leaked_storage: Variable "kinds" going out
	of scope leaks the storage it points to.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/nfs/xlog.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/support/nfs/xlog.c b/support/nfs/xlog.c
index f75a9ab..687d862 100644
--- a/support/nfs/xlog.c
+++ b/support/nfs/xlog.c
@@ -135,10 +135,14 @@ xlog_from_conffile(char *service)
 	struct conf_list_node *n;
 
 	kinds = conf_get_list(service, "debug");
-	if (!kinds || !kinds->cnt)
+	if (!kinds || !kinds->cnt) {
+		free(kinds);
 		return;
+	}
 	TAILQ_FOREACH(n, &(kinds->fields), link)
 		xlog_sconfig(n->field, 1);
+
+	conf_free_list(kinds);
 }
 
 int
-- 
2.20.1

