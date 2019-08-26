Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 286A49CAF6
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 09:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfHZHtI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 03:49:08 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:41295 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730069AbfHZHtI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Aug 2019 03:49:08 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 35074371
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 03:49:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 26 Aug 2019 03:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=yxN275zZzqZNJ
        Ze4onyoq9326x4TC0jCdVT7QZYrB4k=; b=KDwgnMwPWoZ1/UbTqByGoMdEiDveF
        u//g8NkGIIqOftdNMerk9DA1+cbi1pbFE64kUE0fJGzOocdfPGhH/enhrwS0ZBex
        kyK4IRgbn63Dm851VmIx8blHEmJBkRN0Ve85bB9nV28HZ0xW3UPd3ISlMhMyE0lX
        kwHNnIC0eySI+WjOCUUDm5UASmpfb0J1k7rR4TMji+DbXRmP3N38pCSjd1RXKZqD
        mBihkFH38zaKIRvIxkEi68nMgkk/J1Zhksu0I6kY1GhsYJDwaoHx5tGK7BC+/oj0
        OMGZnW7xaTjCB0RVh4joazjF6fcsab4TlRip4yiQhJFRWoaqI2hO8GiNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=yxN275zZzqZNJZe4onyoq9326x4TC0jCdVT7QZYrB4k=; b=P1If7wrf
        0GZ/jD3igleoCb8WBiRZwn7zrbvbLRhKNhp7c9TYJeFZxye8KOQdZ7wSV70lVDQd
        DxU53BCer0xFvWML+5daxdzCMfjA3m8x//Z3hWZ9Rp2LTNHtCyACFdOAGB4qbpVe
        LpHrHAq0Cl2IUG59PKEHyoi9Z9tBb5FhCgAvUvM0nK8lYcCMSm6jljfcXSnLOOyS
        fejP+pTydy9J7bjGoUhw1LqyxtghXQvv03kB72O2gzwOXINSh/iuGTBcP0PN11ix
        kW560tkGJm+XsAWmpfj/+1MiIiBxiJ5OTr5dctu+VunGvMCCkgsnpSIfzHTw0Kyv
        EXEyS/oIIkEDfw==
X-ME-Sender: <xms:8o5jXYTDON_1yx9Bbpt3KKOsNhYWobxMGn-IkWgXTO57Q1ak732bOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudehfedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucfkphepjeekrdehhedrvdefrddutdeknecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:8o5jXWZHZyFGOmdEwRVDumdYndbAhx6LPOzoMWjPY10xCyS7BS9N0Q>
    <xmx:8o5jXQ_auJ-_S0DUoDHHFo5JcLxvJKposcIYbmV7Hp6X51o_kIKzoQ>
    <xmx:8o5jXQldHTg-nERKwQxAUySSIdWwLQchfhincWACjiqapvXGkXquuQ>
    <xmx:8o5jXWFmR_oEEpQVudl-DPau1fICaqBrZ9MZfrmouWd6_SDqzh3nBQ>
Received: from NSJAIL (x4e37176c.dyn.telefonica.de [78.55.23.108])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3A2D0D6005B
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 03:49:06 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 50c852a7 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 26 Aug 2019 07:49:01 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     linux-nfs@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/3] tests: add missing include for strerror(3P)
Date:   Mon, 26 Aug 2019 09:48:52 +0200
Message-Id: <7e2258fd221466a2974dcf7f0643c65168b429f8.1566805721.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <6de0089348765e60bcdf59ef5813d7bb631c967f.1566805721.git.ps@pks.im>
References: <6de0089348765e60bcdf59ef5813d7bb631c967f.1566805721.git.ps@pks.im>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The function strerror(3P) is declared in <string.h>, but it is not
included in "statdb_dump.c". Include it to fix compile errors.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 tests/statdb_dump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/statdb_dump.c b/tests/statdb_dump.c
index 92d63f29..3ac12bff 100644
--- a/tests/statdb_dump.c
+++ b/tests/statdb_dump.c
@@ -23,6 +23,7 @@
 #include "config.h"
 #endif
 
+#include <string.h>
 #include <stdio.h>
 #include <errno.h>
 #include <arpa/inet.h>
-- 
2.23.0

