Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37478139657
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2020 17:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgAMQ3X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Jan 2020 11:29:23 -0500
Received: from smtpcmd0756.aruba.it ([62.149.156.56]:35435 "EHLO
        smtpcmd0756.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729242AbgAMQ3X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Jan 2020 11:29:23 -0500
Received: from ubuntu.localdomain ([212.103.203.10])
        by smtpcmd07.ad.aruba.it with bizsmtp
        id psVJ210130DySFo01sVLzo; Mon, 13 Jan 2020 17:29:21 +0100
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Steve Dickson <SteveD@RedHat.com>
Cc:     linux-nfs@vger.kernel.org,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [nfs-utils PATCH 3/3] support: nfs: rpc_socket: silence unused parameter warning on salen
Date:   Mon, 13 Jan 2020 17:29:18 +0100
Message-Id: <20200113162918.77144-4-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200113162918.77144-1-giulio.benetti@benettiengineering.com>
References: <20200113162918.77144-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1578932961; bh=PXVvlnUUfu0xHS7uQbqK4+CL7ZTbWldvWiTx1mvN6U8=;
        h=From:To:Subject:Date:MIME-Version;
        b=k4pW4r5jrIjmrUXdUTeZOcgMYYrpGsXlyqFSOHkdL/HslPhff85uUwz/swSDe02WA
         quTJ5Ugo1HSmD+sqEApaVkGNSLpJur5OTxDIHj3MqJlNGhnCovS3r8O25PkobJJgsE
         f3j+5LO8K2iZcGsSzYAQs/Xf+5p1Vy4/cq9yhoa6cutzcvrlxxJcSt6/3cygRr6YFC
         qa7LmErzc7I2mYnjzIBZbT7nBh8y+q3Lmp7BE9/4mwQVcAJJYrbXx96pE9prUPu/gf
         sOjHyJR9QhbftK3jk/ZDA3XMpYnfDclcmQ42jOebVQQu32vwDvwTquzMdOTYUyxmRL
         it6j46NWlo4qQ==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If HAVE_LIBTIRPC is not defined salen parameter is unused and not taken
into account, so compiler emits warning. Add a (void) salen; in that
case.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 support/nfs/rpc_socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/support/nfs/rpc_socket.c b/support/nfs/rpc_socket.c
index bdf6d2f6..5fabf5a1 100644
--- a/support/nfs/rpc_socket.c
+++ b/support/nfs/rpc_socket.c
@@ -77,6 +77,8 @@ static CLIENT *nfs_get_localclient(const struct sockaddr *sap,
 		.len		= (size_t)salen,
 		.buf		= &address,
 	};
+#else
+	(void) salen;
 #endif	/* HAVE_LIBTIRPC */
 	CLIENT *client;
 	int sock;
-- 
2.20.1

