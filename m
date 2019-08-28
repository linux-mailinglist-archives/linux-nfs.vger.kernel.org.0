Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF7B9FB31
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 09:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfH1HKi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 03:10:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47249 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726340AbfH1HKi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Aug 2019 03:10:38 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id DE0972221C
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2019 03:10:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 28 Aug 2019 03:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=8/j+2Y1dbHjza
        5Pt5iDd4OimapmgmKN+bPWjskjWaqY=; b=Peiew2VbGGDc0mC5CXn0FranRbf6p
        HfbgS8XcT3Fz+V7v/gF9986+74ZFQ3OIrfpsVoOh+SZEomXwdziopr/6Y8HH2ooo
        DqbT8Tmg1/wJK52eD9HGAsGMFfY3QH+/J8SvfHEX7BaepthnjpTvsklUxHOuNuOt
        OuK69ZPK24fxN3OxYrg3AAra221XPgrIqZYfEzr1tzCXqhKCOvf8rKKZOPArl9ua
        ZTm0h6MfZCFU+EwJ9NjFj1jsPsDHUpkTGgLX7uw0+23iG4Z1Vh9cUkuWM9NtJzAP
        kxxZZjoiqqC0xqvoQXlHM8S2f+1ukCAJ8jMC6ikMxCgHuvUnwkfgPmNMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=8/j+2Y1dbHjza5Pt5iDd4OimapmgmKN+bPWjskjWaqY=; b=pgAR5TXx
        LsS/ltVSovP/rC6cATg+GstfoBWeG4M3Aus3wYu96J4T5itTRHrqnUqIyPXAE2yX
        64xSVvEIoQis9bfmuUXmBmjJqRRnzPvh7D0WNGukeU9BzKR9bVS1BDxDYKVDsSV6
        Xy1f13ybmm0a4pZ8mm/loamBwJiap9drpH3ZK3pE4dgdkMM2WrkTDzfVX6G03grM
        Df/GtHMQU6TLclLH8SPX+QRT8cf3657IyvkkB2QdsyYcE23SyUkVIuKkZOdqRboZ
        wDTCfGm03I8HerZPA2JqXE4M2LB9avkkiVOYKm1l6k8lkN/mXjQ5Bnq/24r5Vyb9
        qJ1gA1Kj63L3Fg==
X-ME-Sender: <xms:7ChmXVqj_4ONJyQB_B61hMbrjiAfO0H9FFEApvAo9NTlJBgc___XKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudehledgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucfkphepjeejrdduuddrudehhedrvdehheenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:7ChmXVGvbda8hmpcn8-z4LG6l2I_lPrAixwle6B-tF0Zdi1pYADmuw>
    <xmx:7ChmXSInM9MKVtE1Z54U2Yp_TPRzFXKs8t0era_fZmZ6ROHYcf4ufg>
    <xmx:7ChmXSjOjNu-g0HVkUyub81ZME7GNRb8D84C1PKws3HABFcp4rg7hQ>
    <xmx:7ChmXS0CGyOhuCS8Ht9-P333FiX-QDUV9vsJk17aRwI5kZstUig9nw>
Received: from NSJAIL (x4d0b9bff.dyn.telefonica.de [77.11.155.255])
        by mail.messagingengine.com (Postfix) with ESMTPA id 54FA8D60062
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2019 03:10:36 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 7f3c31de (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Wed, 28 Aug 2019 07:10:34 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     linux-nfs@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/6] Use <poll.h> header instead of <sys/poll.h>
Date:   Wed, 28 Aug 2019 09:10:14 +0200
Message-Id: <736b1f0b3f59286150bf6b1eddcc0789c97bd9a9.1566976047.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566976047.git.ps@pks.im>
References: <cover.1566976047.git.ps@pks.im>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The POSIX standard specifies that poll(3P) should be declared in the
header <poll.h> instead of <sys/poll.h>. While there is one location
where we use the correct header, two others do not, causing warnings on
musl libc systems.

Fix the warning by switching from <sys/poll.h> to <poll.h>. As we're
already using the latter one already, this change should not cause any
problems for other platforms.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 utils/gssd/svcgssd_main_loop.c | 2 +-
 utils/statd/sm-notify.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/utils/gssd/svcgssd_main_loop.c b/utils/gssd/svcgssd_main_loop.c
index b5681ce1..920520d0 100644
--- a/utils/gssd/svcgssd_main_loop.c
+++ b/utils/gssd/svcgssd_main_loop.c
@@ -34,7 +34,7 @@
 
 #include <sys/param.h>
 #include <sys/socket.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <netinet/in.h>
diff --git a/utils/statd/sm-notify.c b/utils/statd/sm-notify.c
index abfb8bc7..739731f5 100644
--- a/utils/statd/sm-notify.c
+++ b/utils/statd/sm-notify.c
@@ -12,7 +12,7 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <sys/param.h>
 #include <sys/syslog.h>
 #include <arpa/inet.h>
-- 
2.23.0

