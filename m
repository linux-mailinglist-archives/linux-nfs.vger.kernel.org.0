Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C68069FB34
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 09:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfH1HKj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 03:10:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58131 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726444AbfH1HKi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Aug 2019 03:10:38 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7B8242230F
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2019 03:10:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 28 Aug 2019 03:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=ESxHxEDzwGVav
        JtbQlSYJR8/RFA2T/9kB/XUMsaQgII=; b=id7RU7DGS4ssgUFO/i0CLnTiOdl8g
        L5suLdZoPAlkLBjZtuNprGtsCgcMXvV8knZcZqPBKCxnhBAs6BLRo4c64C6cx0qi
        bppNOzgJtL/7Ax6oVvQPkTmvqqJfsuHWdiZdQKEs1KfXc+vFPS/E4lrKZ9goqamt
        7uMViGBkltRYiuLOh3UJduAWK+tMV4nf1mOY73t8jg/uADOUwiB9LgIk4j8d+YOC
        roQ3i5FoOw0FK+jPMfQp6JwqzqzvMUFIZAYg2hxPr2JIlCpi3LxEB6CRDux3eEwo
        y6yj/L2VN6DCQoCql/KGyvH8+7pCmhqIuSVw/VSNpZm6qm3oVeCnXs54w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ESxHxEDzwGVavJtbQlSYJR8/RFA2T/9kB/XUMsaQgII=; b=fIUBwwfs
        +/pqbK3mW3ct/zNU6eHx0bI80uZi65GD19ckfk5W6Lkb7wOsWdD+j0Vi31PL7gIq
        F8IJslgdU55nSAMk8aaRfWlMgpST7OTmocoGws5o0C/40jmWeiUmdfAA/ZD3b0HK
        kfBzIueIcUdJ5ijwkdRJHNqNT3kRBLaIeYXAhnCpI/1PxXgyiaPbLpZbx+0Ez7K4
        FX7O5YfjyEP9USVSF5A//ex2knLCkic1oqb0V8Dcms3yljT3hVeU4mjLPr282Ox9
        ThWTG6wx+Uzyz0fwEikWcB+7JrNRRz+ubpC3gVhtsTuLiCv56/eC31ZMZlqsTEgl
        5wNSJhXnjbivCg==
X-ME-Sender: <xms:7ShmXU1S-jDiH-nSzNxyRO-MMg2tWAnILOgZH8FzqUuhZcWHjRYz-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudehledgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucfkphepjeejrdduuddrudehhedrvdehheenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:7ShmXSH1KZ0gUAeb8afRg_-vtbPMrdkvTx9akHQ8aXjFBfjZkgI-Kw>
    <xmx:7ShmXfdpXU8dFRSvE5yldXQ8581ZusTJLz9x_H39JLonoAPZ5tNLsg>
    <xmx:7ShmXYR7YwcsfGAQZ67W4vCScRCWueMqDKe2FYgtBv3bMD7cGyDejg>
    <xmx:7ShmXcPK9scaHzlbbfk5pjfUKJ0lTsWEQ4kVqudBoGBfayRj_7KcZw>
Received: from NSJAIL (x4d0b9bff.dyn.telefonica.de [77.11.155.255])
        by mail.messagingengine.com (Postfix) with ESMTPA id CEE7280060
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2019 03:10:36 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 5aa33a69 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Wed, 28 Aug 2019 07:10:34 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     linux-nfs@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 4/6] configure.ac: Add <sys/socket.h> header when checking sizeof(socklen_t)
Date:   Wed, 28 Aug 2019 09:10:15 +0200
Message-Id: <42879dea46c255025fb579dcf7b15335fd77291c.1566976047.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566976047.git.ps@pks.im>
References: <cover.1566976047.git.ps@pks.im>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We're checking for various sizes in configure.ac, among them the size of
the socklen_t type. If socklen_t's size is not found and thus reported
to be zero, we will typedef our own socklen_t as "unsigned int".

The check for socklen_t is insufficient, though. While the type is
declared via <sys/socket.h>, we only search AC_INCLUDES_DEFAULT for its
declaration, which doesn't include <sys/socket.h>. On musl libc, this
causes us to not find the declaration and redeclare it with an
incompatible type.

Fix the issue by searching both the default includes as well as
<sys/socket.h>.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 configure.ac | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 50002b4a..37096944 100644
--- a/configure.ac
+++ b/configure.ac
@@ -545,7 +545,10 @@ AC_CHECK_SIZEOF(short)
 AC_CHECK_SIZEOF(int)
 AC_CHECK_SIZEOF(long)
 AC_CHECK_SIZEOF(size_t)
-AC_CHECK_SIZEOF(socklen_t)
+AC_CHECK_SIZEOF(socklen_t,, [AC_INCLUDES_DEFAULT
+                             #ifdef HAVE_SYS_SOCKET_H
+                             # include <sys/socket.h>
+                             #endif])
 
 
 dnl *************************************************************
-- 
2.23.0

