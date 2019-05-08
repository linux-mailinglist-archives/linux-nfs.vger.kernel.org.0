Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E148A17AB3
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2019 15:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbfEHNfi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 09:35:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58974 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfEHNfi (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 8 May 2019 09:35:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C20F42DA990
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:38 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-59.phx2.redhat.com [10.3.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E0831724D
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:38 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 01/19] Removed resource leaks from junction/path.c
Date:   Wed,  8 May 2019 09:35:18 -0400
Message-Id: <20190508133536.6077-2-steved@redhat.com>
In-Reply-To: <20190508133536.6077-1-steved@redhat.com>
References: <20190508133536.6077-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 08 May 2019 13:35:38 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

junction/path.c:167: leaked_storage: Variable "start" going out
	of scope leaks the storage it points to.

junction/path.c:331: leaked_storage: Variable "normalized" going out
	of scope leaks the storage it points to.

junction/path.c:340: leaked_storage: Variable "normalized" going out
	of scope leaks the storage it points to.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/junction/path.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/support/junction/path.c b/support/junction/path.c
index e74e4c4..13a1438 100644
--- a/support/junction/path.c
+++ b/support/junction/path.c
@@ -163,8 +163,10 @@ nsdb_count_components(const char *pathname, size_t *len,
 			break;
 		next = strchrnul(component, '/');
 		tmp = (size_t)(next - component);
-		if (tmp > 255)
+		if (tmp > 255) {
+			free(start);
 			return false;
+		}
 		length += XDR_UINT_BYTES + (nsdb_quadlen(tmp) << 2);
 		count++;
 
@@ -328,11 +330,13 @@ nsdb_posix_to_path_array(const char *pathname, char ***path_array)
 		length = (size_t)(next - component);
 		if (length > 255) {
 			nsdb_free_string_array(result);
+			free(normalized);
 			return FEDFS_ERR_SVRFAULT;
 		}
 
 		result[i] = strndup(component, length);
 		if (result[i] == NULL) {
+			free(normalized);
 			nsdb_free_string_array(result);
 			return FEDFS_ERR_SVRFAULT;
 		}
-- 
2.20.1

