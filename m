Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE1E9CAF4
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 09:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfHZHtI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 03:49:08 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:42307 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727563AbfHZHtH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Aug 2019 03:49:07 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 8FCAB38E
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 03:49:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 26 Aug 2019 03:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=lqLvFz7httVB3
        363B7u+xSWugEcT9YQPU8nl/ICvCe8=; b=4TOjsmhGZlzPLYY13hsNpoTivsNRG
        8MfP1Fw08ul+h+3NfjJqj6A8LbOuDtBGFJGj75OAPegsoZpqSRURYyw1nnNu95G6
        yfi4a0P3u9Dcn+Dy+3JBNkTaJhqIHtv55Pkgn1cLlQRQ8oVXQkfTh57IWgW6sO46
        b2XZqsbWrl5MgWm++UPFB7PT9K+decbsuhTZ9JuhMj7vG0Mtxx8i0BaqWpFkBPHb
        JVxq2wWRIzt6TexWTsblvDyqlhwEHr/eomvWNqutNZLRZDDq4uZ/5Z7HPeTzyChb
        AU0rKJci8oLLJ1zdqXhzFmTDjJ4TQ125Nh+nP98KpJRJykbeUtH/LGcLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=lqLvFz7httVB3363B7u+xSWugEcT9YQPU8nl/ICvCe8=; b=bmLn8wRL
        WZ6vPbO8e30W4wpwFrem8U8qLEWkDMfA9BqzOaDSeq1kcIVorsjXcaDBIkqXVK+b
        7vsXMXLFzuUTFJO+WTN0AQHQVtR+ipFJXUOJaacZG5cdGo2DZiVcDBhpJYm/G/mf
        h6CFHJTgz79WFFmJSO7NzxHxSSdz5zAumIjeimQMSDk3ZM91gcvo+GE115lsy532
        ZFM87l9g+VeZYHses3wdfIxKsDJGbMQRN7br3spUCp7b/79ebRC3yleCEOwAikDR
        tSX4d4le5nkeaKfddjWeD4lI1sbyokyPmek1pSqKUCTu7i9Xv3VDPEZHLPBc/2P2
        4KR5NSSsuyu+Bw==
X-ME-Sender: <xms:8o5jXUvxLXKoTDVdCL7ibtp-NOne3T_2cVCFZlhQgornGF9mYhYwuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudehfedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucfkphepjeekrdehhedrvdefrddutdeknecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:8o5jXaSOkLZP8b1A-6dUfLcKRu8Q7yWUAfAo2sJ86eMbdDrQjw8aoQ>
    <xmx:8o5jXWvOuFSUUCAFpEpvO9hMByJwGjanx-6se2oFx-WY2uDtQ_SUWA>
    <xmx:8o5jXQw7O_sIL2ydDFTYNlpOczZR5lTrgq_Fhv6s8TrTUZkjHHHt4g>
    <xmx:8o5jXS7VbXEpfJP26GWDSVy7SPAsyM-AAx-i5sue7hhKSVZ6qZNZEw>
Received: from NSJAIL (x4e37176c.dyn.telefonica.de [78.55.23.108])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9BE69D60062
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 03:49:05 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 7f6f5b3d (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 26 Aug 2019 07:49:01 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     linux-nfs@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/3] nfsdcld: add missing include for PATH_MAX
Date:   Mon, 26 Aug 2019 09:48:51 +0200
Message-Id: <15b474e6fa7aee12e64e4376f7716a232e40100a.1566805721.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <6de0089348765e60bcdf59ef5813d7bb631c967f.1566805721.git.ps@pks.im>
References: <6de0089348765e60bcdf59ef5813d7bb631c967f.1566805721.git.ps@pks.im>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

While glibc transitively includes <limits.h> and thus has PATH_MAX
available, other libc implementations may not have the transitive
include and thus miss the definition. Add an explicit include of
<limits.h> to fix compilation with musl libc.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 utils/nfsdcld/legacy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/utils/nfsdcld/legacy.c b/utils/nfsdcld/legacy.c
index f0ca3168..07f477ab 100644
--- a/utils/nfsdcld/legacy.c
+++ b/utils/nfsdcld/legacy.c
@@ -24,6 +24,7 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <limits.h>
 #include "cld.h"
 #include "sqlite.h"
 #include "xlog.h"
-- 
2.23.0

