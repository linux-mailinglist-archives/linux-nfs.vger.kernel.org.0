Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4E2917AC3
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2019 15:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfEHNfu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 09:35:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57555 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727414AbfEHNfu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 8 May 2019 09:35:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 159CC3079B66
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:50 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-59.phx2.redhat.com [10.3.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C42761724D
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:49 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 18/19] Removed a resource leak from mountd/fsloc.c
Date:   Wed,  8 May 2019 09:35:35 -0400
Message-Id: <20190508133536.6077-19-steved@redhat.com>
In-Reply-To: <20190508133536.6077-1-steved@redhat.com>
References: <20190508133536.6077-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 08 May 2019 13:35:50 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

mountd/fsloc.c:97: overwrite_var: Overwriting "mp" in
	"mp = calloc(1UL, 16UL)" leaks the storage that "mp" points to.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/mountd/fsloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/utils/mountd/fsloc.c b/utils/mountd/fsloc.c
index bc737d1..cf42944 100644
--- a/utils/mountd/fsloc.c
+++ b/utils/mountd/fsloc.c
@@ -102,6 +102,7 @@ static struct servers *parse_list(char **list)
 		cp = strchr(list[i], '@');
 		if ((!cp) || list[i][0] != '/') {
 			xlog(L_WARNING, "invalid entry '%s'", list[i]);
+			free(mp);
 			continue; /* XXX Need better error handling */
 		}
 		res->h_mp[i] = mp;
-- 
2.20.1

