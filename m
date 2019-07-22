Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A515F70208
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2019 16:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbfGVOQT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Jul 2019 10:16:19 -0400
Received: from smtp-o-2.desy.de ([131.169.56.155]:57113 "EHLO smtp-o-2.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727880AbfGVOQT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 22 Jul 2019 10:16:19 -0400
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
        by smtp-o-2.desy.de (Postfix) with ESMTP id 7C8FC1607BA
        for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2019 16:16:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 7C8FC1607BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1563804977; bh=X/fv5GJsN2/N/TJrtmJuRFcYBJpGJKRgceUSfDN3ibw=;
        h=From:To:Cc:Subject:Date:From;
        b=cGXR8K8mDpevg59B09rHIdD9pmQU6JGZq9/185I9xTeEBDqjchrRf3nyGfW7MVujI
         KqEKyVOf37/6BCuCRdynD7Xqf/BK1Z8MVysFTKhxBl+60YjibwPdt4BxEgRgb2fmJd
         M0BgrxZj5BALDq7jsSi0r8/MEgNualiBqEugsDGo=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id 765AC1A00F5;
        Mon, 22 Jul 2019 16:16:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from ani.desy.de (zitpcx21033.desy.de [131.169.185.213])
        by smtp-intra-1.desy.de (Postfix) with ESMTP id 4B65DC003B;
        Mon, 22 Jul 2019 16:16:17 +0200 (CEST)
From:   Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To:     linux-nfs@vger.kernel.org
Cc:     bfields@fieldses.org, Tom Haynes <loghyr@gmail.com>,
        Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH] st_flex: fix uid/gid formatting in error message
Date:   Mon, 22 Jul 2019 16:16:02 +0200
Message-Id: <20190722141602.14274-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

as ffds_user and ffds_group are utf8 encoded string use '%s' when
constructing an error message.

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 nfs4.1/server41tests/st_flex.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/nfs4.1/server41tests/st_flex.py b/nfs4.1/server41tests/st_flex.py
index 335b2c8..f4ac739 100644
--- a/nfs4.1/server41tests/st_flex.py
+++ b/nfs4.1/server41tests/st_flex.py
@@ -313,10 +313,10 @@ def testFlexLayoutTestAccess(t, env):
     gid_rd = ds.ffds_group
 
     if uid_rw == uid_rd:
-        fail("Expected uid_rd != %i, got %i" % (uid_rd, uid_rw))
+        fail("Expected uid_rd != %s, got %s" % (uid_rd, uid_rw))
 
     if gid_rw != gid_rd:
-        fail("Expected gid_rd == %i, got %i" % (gid_rd, gid_rw))
+        fail("Expected gid_rd == %s, got %s" % (gid_rd, gid_rw))
 
     res = close_file(sess, fh, stateid=open_stateid)
     check(res)
-- 
2.21.0

