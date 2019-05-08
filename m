Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52CA017AB7
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2019 15:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfEHNfo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 09:35:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbfEHNfn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 8 May 2019 09:35:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9DA13079B90
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:42 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-59.phx2.redhat.com [10.3.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A33415C640
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:42 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 06/19] Removed bad frees from nfs/xcommon.c
Date:   Wed,  8 May 2019 09:35:23 -0400
Message-Id: <20190508133536.6077-7-steved@redhat.com>
In-Reply-To: <20190508133536.6077-1-steved@redhat.com>
References: <20190508133536.6077-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 08 May 2019 13:35:42 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs/xcommon.c:63: incorrect_free: "free" frees incorrect pointer "(void *)s".
nfs/xcommon.c:81: incorrect_free: "free" frees incorrect pointer "(void *)s".

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/nfs/xcommon.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/support/nfs/xcommon.c b/support/nfs/xcommon.c
index 14e580e..3989f0b 100644
--- a/support/nfs/xcommon.c
+++ b/support/nfs/xcommon.c
@@ -53,14 +53,17 @@ char *
 xstrconcat3 (const char *s, const char *t, const char *u) {
      char *res;
 
-     if (!s) s = "";
+     int dofree = 1;
+
+     if (!s) s = "", dofree=0;
      if (!t) t = "";
      if (!u) u = "";
      res = xmalloc(strlen(s) + strlen(t) + strlen(u) + 1);
      strcpy(res, s);
      strcat(res, t);
      strcat(res, u);
-     free((void *) s);
+     if (dofree)
+         free((void *) s);
      return res;
 }
 
@@ -69,7 +72,9 @@ char *
 xstrconcat4 (const char *s, const char *t, const char *u, const char *v) {
      char *res;
 
-     if (!s) s = "";
+     int dofree = 1;
+
+     if (!s) s = "", dofree=0;
      if (!t) t = "";
      if (!u) u = "";
      if (!v) v = "";
@@ -78,7 +83,8 @@ xstrconcat4 (const char *s, const char *t, const char *u, const char *v) {
      strcat(res, t);
      strcat(res, u);
      strcat(res, v);
-     free((void *) s);
+     if (dofree)
+         free((void *) s);
      return res;
 }
 
-- 
2.20.1

