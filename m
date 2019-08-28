Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCD39FB33
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 09:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfH1HKi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 03:10:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52107 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726368AbfH1HKi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Aug 2019 03:10:38 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id EA4A922305
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2019 03:10:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 28 Aug 2019 03:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=0wc7Gau0xii4k
        Jxb8zXQS3Ds82T+ZIi0Mk5LiRoOcLE=; b=irHN+61c+nPvOs9Drmws7KhUSfqys
        pma7TlMDLq2X29WnA/JtiN4Zgj9oqjRjoEerVa+Y+GzNPfmlI6BV0I7RfgP4Fdpi
        PAqpjtI8G0mgEr1Xf5OLH1zfNYhT1Ou8X1fr/3kNdUF61E4TMf45t19FjqG5u+B6
        Pbt5pTABtNjlp4WOQ6z65clEw4Uk6Usv13+l7KxsdSSqDyROugYXzeHkQU5v/Ue/
        RoPoMg4QH6mE+PtKZbfNhINWd+gFrRQZzUy1m4VVRua3zj/VLjBywtfWO93ao+fO
        DH6I2fCrTH6HfCQjWbRGSlJUV7pMflzEyzVQCZNpP4ubSPE7ZOqbRd+cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=0wc7Gau0xii4kJxb8zXQS3Ds82T+ZIi0Mk5LiRoOcLE=; b=JV5bHNIn
        oWsbfYF9lADngZ4HPIbo1CCd9+8eKWgVN9obxgA1x9KvkCErJDlbILxJY7c1gd9s
        K5aV/iDzR3argKEKdFjI99rHxKEdBzDJL9PX9GGJU9AbJ8C7T4scwQyCspy+SBga
        1WEFAtpaqhzl5cDafEMzdXnEPZ6HzpQh3lm3NP6rf9QaDZrb8NdA1uqXBWD8eVb4
        V9UWR3ANkSAziOVzdFvLua3PmqlubkNwKKAFD58u1Jai/wN7WqRfgzL7Q4ZClNbg
        sNHUBqUgJH5xKlFJUxl3diVQS6NUKROJwhpq/kpUoJ4AoOdke3q2dT1XW2xkGxJF
        2Cde9JEhPUfQnA==
X-ME-Sender: <xms:7ChmXVYiwuA219zu9xCno-QcpymsbH9boYWEb4zMKLo6RO8esDOvZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudehledgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucfkphepjeejrdduuddrudehhedrvdehheenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:7ChmXfw2zeWsVOD4Pt2SLl_ShwksWunTIhfpluNncSwbUvNzvBdRpw>
    <xmx:7ChmXTPkHaE1in-QQP-X9NNJQkmN44cEoUgLqd9bf4akz8Lxe6u4dA>
    <xmx:7ChmXVJrgESRc39pg6v91G4AroslFReSJFgRCV6Nrc7jG2RuKNA6tQ>
    <xmx:7ChmXReY4eLBVrpdSVGFTUeqNJ54tcMna98Q3s_2SXmkRPcB6Z_ftA>
Received: from NSJAIL (x4d0b9bff.dyn.telefonica.de [77.11.155.255])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4B70880059
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2019 03:10:36 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id d38a8fcf (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Wed, 28 Aug 2019 07:10:33 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     linux-nfs@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/6] Use <fcntl.h> header instead of <sys/fcntl.h>
Date:   Wed, 28 Aug 2019 09:10:13 +0200
Message-Id: <7c8b5df691c0b12c656e0dd8d350f260308dc115.1566976047.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566976047.git.ps@pks.im>
References: <cover.1566976047.git.ps@pks.im>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

While most source files already use the standard header <fcntl.h>
instead of <sys/fcntl.h>, some do not, causing warnings on musl libc
systems.

Fix the remaining ones to use <fcntl.h>. As we already use the header
unconditionally in a lot of places, this change should not cause any
problems for other platforms.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 support/export/xtab.c    | 2 +-
 support/nfs/rmtab.c      | 2 +-
 support/nfs/svc_socket.c | 2 +-
 support/nfs/xio.c        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/support/export/xtab.c b/support/export/xtab.c
index 1e1d679e..00b25eaa 100644
--- a/support/export/xtab.c
+++ b/support/export/xtab.c
@@ -10,7 +10,7 @@
 #include <config.h>
 #endif
 
-#include <sys/fcntl.h>
+#include <fcntl.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/support/nfs/rmtab.c b/support/nfs/rmtab.c
index 2ecb2cc9..9f03167d 100644
--- a/support/nfs/rmtab.c
+++ b/support/nfs/rmtab.c
@@ -10,7 +10,7 @@
 #include <config.h>
 #endif
 
-#include <sys/fcntl.h>
+#include <fcntl.h>
 #include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
diff --git a/support/nfs/svc_socket.c b/support/nfs/svc_socket.c
index 5afc6aa5..2e8fe1af 100644
--- a/support/nfs/svc_socket.c
+++ b/support/nfs/svc_socket.c
@@ -22,7 +22,7 @@
 #include <netdb.h>
 #include <rpc/rpc.h>
 #include <sys/socket.h>
-#include <sys/fcntl.h>
+#include <fcntl.h>
 #include <errno.h>
 #include "xlog.h"
 #include "rpcmisc.h"
diff --git a/support/nfs/xio.c b/support/nfs/xio.c
index e3d27d2f..6962751d 100644
--- a/support/nfs/xio.c
+++ b/support/nfs/xio.c
@@ -10,7 +10,7 @@
 #include <config.h>
 #endif
 
-#include <sys/fcntl.h>
+#include <fcntl.h>
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
-- 
2.23.0

