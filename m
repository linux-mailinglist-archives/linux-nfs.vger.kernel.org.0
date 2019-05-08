Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C7C17AB2
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2019 15:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfEHNfj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 09:35:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfEHNfj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 8 May 2019 09:35:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37507307B481
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:39 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-59.phx2.redhat.com [10.3.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5F8C5C640
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:38 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 02/19] Removed resource leaks from nfs/exports.c
Date:   Wed,  8 May 2019 09:35:19 -0400
Message-Id: <20190508133536.6077-3-steved@redhat.com>
In-Reply-To: <20190508133536.6077-1-steved@redhat.com>
References: <20190508133536.6077-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 08 May 2019 13:35:39 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs/exports.c:717: leaked_storage: Variable "id" going out
	of scope leaks the storage it points to.

nfs/exports.c:727: leaked_storage: Variable "id" going out
	of scope leaks the storage it points to.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/nfs/exports.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index b59d187..5f4cb95 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -714,6 +714,7 @@ parsesquash(char *list, int **idp, int *lenp, char **ep)
 		}
 		if (id0 == -1 || id1 == -1) {
 			syntaxerr("uid/gid -1 not permitted");
+			xfree(id);
 			return -1;
 		}
 		if ((len % 8) == 0)
@@ -724,6 +725,7 @@ parsesquash(char *list, int **idp, int *lenp, char **ep)
 			break;
 		if (*cp != ',') {
 			syntaxerr("bad uid/gid list");
+			xfree(id);
 			return -1;
 		}
 		cp++;
-- 
2.20.1

