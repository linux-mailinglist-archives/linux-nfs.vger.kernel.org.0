Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE5E69CAF5
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 09:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfHZHtI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 03:49:08 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:54917 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727674AbfHZHtI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Aug 2019 03:49:08 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 89037377
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 03:49:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 26 Aug 2019 03:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=Ngx/N2sgJZBewYkvtYJmlECxAF
        AHU1SdApns+TaMaTY=; b=sb9uXFe/uAJjBAZHJhgtus72tfGyIb3iRfxB/eSRh4
        D8U7YykxljcsSuUrga6CHaueh6ggNKMfH8DUXgv7CAVNFTO1m8cH34fsAM9dvRbs
        OZspchJyKb6E+r63zqbKd6BNJDYyGQsrrm+lbzglqY8C2bb6x3Xtd9UFg7JxyseX
        3hLOGsSetICY8YDMqIDZr/khDDeLWTPb57iriviz/x17yVafZaKWEpiyks8ZqpcI
        pm6gsmpqiJ1Y66wPQenOxl0iE0nvPvk+RDRFRfnNauwZNc5N2/3eGHImbkTfaIYW
        r6gpns36eYU1F1MjAw2KrzRKEvuMIVL6XCLmfnye5yHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Ngx/N2sgJZBewYkvt
        YJmlECxAFAHU1SdApns+TaMaTY=; b=WEng3x6qxs+mxNGK82YstO0qimFQsotVg
        h5Dmng+RpVvG3s+XII5LSSj8WXVJM+5cPRrM9iOyHGkoBb5TLvbOg+5jFrT3DABu
        HoYEcb2yqrQKrF4OXLI8qnpIXlmU26AO5JS0BbLR6LdyDmE3k6Kn/YG8IkFX8Oxi
        lmMWNyZ0AwisNcUR4BaZVZK0Vf83QtO2BnFGbw5hmc/gh1y/mnQGAAPjBegR2ZkE
        xbqQKTaBoq24iJOJLnWwV/7/q1QJC6J7zO2iZaG3UJxRIgp3rZXhGoVz05gInm0p
        kuXF/+nzIrXfY3PPNYyG0K5lpdl1qIC65QgKUnYYVyYF5BUX8/FlA==
X-ME-Sender: <xms:8Y5jXW-5IndnI1CWWg8GAhNq4sx-M3Uu-0m3aKlnFrfGQ_psX0UA4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudehfedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucfkphepjeekrdehhedrvdefrddutdeknecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:8Y5jXSzByyJO6Cz1z49CcDguzecrotuXV7fkuiM9WYXLQVu9dxaiKA>
    <xmx:8Y5jXVbOe0rU6mcW-yR6EnYs2sy_tBgWFRUPB2KMee3Ep5xXn9ZEdA>
    <xmx:8Y5jXWr194C_njh1rrOKW-BGIhMDnK3YvFQXnSBvs5QGx22PZSpqtA>
    <xmx:8o5jXXqYQAW9lL1xiO6Rog5v_rVRv8gXyqQVei91x_cXyIYc9wzhFQ>
Received: from NSJAIL (x4e37176c.dyn.telefonica.de [78.55.23.108])
        by mail.messagingengine.com (Postfix) with ESMTPA id 09294D6005E
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 03:49:04 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id db4080a9 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 26 Aug 2019 07:49:01 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     linux-nfs@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/3] mount: fix compilation if __GLIBC__ is not defined
Date:   Mon, 26 Aug 2019 09:48:50 +0200
Message-Id: <6de0089348765e60bcdf59ef5813d7bb631c967f.1566805721.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As glibc versions before v2.24 couldn't safely include <linux/in6.h>,
commit 8af595b7 (mount: support compiling with old glibc, 2017-07-26)
introduced some preprocessor checks to special-case such old versions.
While there is a check whether __GLIBC__ is defined at all, it only
applies to the first comparison `__GLIBC__ < 2`, but doesn't apply to
the second check due to operator precedence. Thus the preprocessor may
use an undefined value and thus generate an error if __GLIBC__ is not
defined.

Fix the issue by wrapping the version check in braces.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 utils/mount/network.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/mount/network.c b/utils/mount/network.c
index e166a823..6ac913d9 100644
--- a/utils/mount/network.c
+++ b/utils/mount/network.c
@@ -39,7 +39,7 @@
 #include <sys/socket.h>
 #include <sys/wait.h>
 #include <sys/stat.h>
-#if defined(__GLIBC__) && (__GLIBC__ < 2) || (__GLIBC__ == 2 && __GLIBC_MINOR__ < 24)
+#if defined(__GLIBC__) && ((__GLIBC__ < 2) || (__GLIBC__ == 2 && __GLIBC_MINOR__ < 24))
 /* Cannot safely include linux/in6.h in old glibc, so hardcode the needed values */
 # define IPV6_PREFER_SRC_PUBLIC 2
 # define IPV6_ADDR_PREFERENCES 72
-- 
2.23.0

