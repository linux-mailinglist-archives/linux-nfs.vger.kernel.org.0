Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3F1A9FB36
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 09:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfH1HKv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 03:10:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57701 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726446AbfH1HKv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Aug 2019 03:10:51 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 863E62232A
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2019 03:10:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 28 Aug 2019 03:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=kB7M3jDMSMxJZ
        qvcCqIBAjbh3jTGK0mCRBhq2OIwRCo=; b=QcY9zZnAAYTv9W22kk/Knjvp+6Dmh
        AUMDnWul+hK/f0crF9Hec6l/2BPIWtf5coerdOcQiFWYnuvu5kWaSiMgHXXEPZy2
        2iiCyZJb0JteVgKAlvKm3Aq9VQoX5I//r7mQnhKihqrjA2hwi6pJxK+WuMiYpF37
        vg9W55GR+LIYco+eYFPIEEohhqLSKLWINTKRExxIDPWfbRiBVqwpK/hkRPN9KJ4e
        JwbM9T6xskh/ik+yBU1TQmYDJxh8Y6SDyr9sTInSrQKF0XDqRaV5QDDM+ypQ8dni
        A3wwhhOIoShQTBwn7pHJHHjFnl1VIXZi0/3BXxlBr2tjiKXgDAGbFQv1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=kB7M3jDMSMxJZqvcCqIBAjbh3jTGK0mCRBhq2OIwRCo=; b=IUIIfc77
        0ZpMl4lEUPaCQ1KAzWdi17LRhue1VJaTy4xqUqxIxjqfkjht/IRXqDV1YVgrr1zO
        pZHZe/IztEGKW4SkBb9YUGJQI5M9d6hxsbT9LFb2szuhYRLDAwVZMVelzhPHoZyf
        HZDtkIOYMv7tgKGga6T58P4OAXgA3kC8iMTwmTa0y55wmASVrPOKUmEzDkVSNcGn
        nLIw9oBV/TtjCZ2QiPkhEa/MGzgqxiLwvP1EvxQ19XCWxM0qSljv2hXNq9V3eePt
        Zz9jZrxdpG90D6oXdHId+n+A2kHUjjutltDBn3r7C+UxdBI1RC6uLe/YzofbTKoQ
        GuyPp2nphwV/vQ==
X-ME-Sender: <xms:-ihmXdnz_FiTRDfZRM4wi2NEDT_qOfQXeDMrgvLTPOAwPNQqNTPibQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudehledgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucfkphepjeejrdduuddrudehhedrvdehheenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhenucevlhhushhtvghrufhiiigvpeeh
X-ME-Proxy: <xmx:-ihmXdG--cH7-CltRP6n_J5nwGLXcG_8A9APbaZcoeLAgNiYZBojUg>
    <xmx:-ihmXerxHOFs6SouHZIUaDqs4f2B85MkvLBp2L2JXiEhJVsoEXG8Wg>
    <xmx:-ihmXR5GYtnTiT0zw3hJEcjyDQmucpFGc829Wxnn64GjYzKcphTRBQ>
    <xmx:-ihmXXs6-uvSnHrdCYSWohx7w5ZRxr9NGS9VY0K0g5IjePQTBAto_g>
Received: from NSJAIL (x4d0b9bff.dyn.telefonica.de [77.11.155.255])
        by mail.messagingengine.com (Postfix) with ESMTPA id D50658005C
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2019 03:10:49 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id b81197bb (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Wed, 28 Aug 2019 07:10:49 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     linux-nfs@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 6/6] mountd: Use unsigned for filesystem type magic constants
Date:   Wed, 28 Aug 2019 09:10:17 +0200
Message-Id: <6ca3eb041a455eb0d37ee359e9831fe5a8605a2f.1566976047.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566976047.git.ps@pks.im>
References: <cover.1566976047.git.ps@pks.im>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The filesystem type magic constants are all unsigned integers, but we
declare them as signed ones. This may cause a compiler warning when
comparing our own signed magic constants with the unsigned ones return
by statfs64(3).

Fix the issue by uniformly usign unsigned types.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 utils/mountd/cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
index ecda18c7..6cfa0549 100644
--- a/utils/mountd/cache.c
+++ b/utils/mountd/cache.c
@@ -302,7 +302,7 @@ static int get_uuid(const char *val, size_t uuidlen, char *u)
  * we generate the identifier from statfs->f_fsid. The rest are network or
  * pseudo filesystems. (See <linux/magic.h> for the basic IDs.)
  */
-static const long int nonblkid_filesystems[] = {
+static const unsigned long nonblkid_filesystems[] = {
     0x2fc12fc1,    /* ZFS_SUPER_MAGIC */
     0x9123683E,    /* BTRFS_SUPER_MAGIC */
     0xFF534D42,    /* CIFS_MAGIC_NUMBER */
@@ -355,7 +355,7 @@ static int uuid_by_path(char *path, int type, size_t uuidlen, char *uuid)
 	rc = statfs64(path, &st);
 
 	if (type == 0 && rc == 0) {
-		const long int *bad;
+		const unsigned long *bad;
 		for (bad = nonblkid_filesystems; *bad; bad++) {
 			if (*bad == st.f_type)
 				break;
-- 
2.23.0

