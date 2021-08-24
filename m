Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE16F3F689F
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Aug 2021 20:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240077AbhHXSCs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Aug 2021 14:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238959AbhHXSCo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Aug 2021 14:02:44 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B700CC05340C
        for <linux-nfs@vger.kernel.org>; Tue, 24 Aug 2021 10:51:20 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id e15so17541856qtx.1
        for <linux-nfs@vger.kernel.org>; Tue, 24 Aug 2021 10:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t8C+GGrkuHZuCFx+eMpPXA1G1r6jwtJtqK4jsR12uQk=;
        b=jQhdyINnizSaMJaCWWONx1Iiu58miDDwYgXhQqVZ6Fyyl3PdPsZtPN8o5X61f9mTGZ
         HZ5UUSartqLgzEIJv7H6qKIx1O8dNeVSxt91/l2U6n/6FOSmGRlhzTyVl3v6yM6ZENcT
         jVFtCjESf/XpOxq0vxYJFKny2n92Fp3j0tT18RNLHqXS6v2tWasURaGt/GS5jVjtTfng
         bmvYwbDtZ/5+ehlEp5PK2IXNV//lDh13tHC/lllhlbuhRU5IQGp/oz8KOymgcpDBgwG9
         AkC8igxFfkxzIZhZhlUi/hta4BL5DF4Oj0yw/pG0ylU4CKzFfDSeDxvFr9bik43DjLCd
         j4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t8C+GGrkuHZuCFx+eMpPXA1G1r6jwtJtqK4jsR12uQk=;
        b=PkP20fIacTgGEdXmrMTfWBgQKac3v3Ei3l8QNY9TZI3WL+2s8AzN+/N3TM5QiJb92M
         EtT5xuK3dDWBFCZG5QQCO/V1ulO78l3JQMsmhUypJGj5z5ttzpb3oiVhcxkgE+vtNZ+I
         Q/NUVa5zVcnMywMI4gwZF5OPCePFehkocWO8KshW8erzZk4A3t52/RBY8KCWsEWQrtBp
         ljX5A0qA8RI8NEtulhlkN+wljD9vjXX0UxO8ppXYm+lgKVWr6gQ24nZGTGFAWD12PPBj
         PLZp9psfQdWlrfMlORYPOhYvIx/gdc05/BHbsr3ugblvZiklbZK8Oq9TaYQJdKR4ncfK
         wRnA==
X-Gm-Message-State: AOAM533rjTm59P92e3CTYgO9ugDVXrIiZ+r2trxZ+NxdepTKTdANh1AI
        xBK5EBVnKKcqaOl6d3Nx55BFySSn2V2ODg==
X-Google-Smtp-Source: ABdhPJwsAZ1O33jVKxNjBZw8baERdAcFzz59gNYZmY+k/pZpp0xS2WM2stAxMLBJtFvX6PhppvEp/g==
X-Received: by 2002:aed:3082:: with SMTP id 2mr36496649qtf.98.1629827479882;
        Tue, 24 Aug 2021 10:51:19 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:549b:da99:adb5:676c])
        by smtp.gmail.com with ESMTPSA id n18sm11519658qkn.63.2021.08.24.10.51.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:51:19 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 2/5] SUNRPC add xps_nunique_destaddr_xprts to xprt_switch_info in sysfs
Date:   Tue, 24 Aug 2021 13:51:05 -0400
Message-Id: <20210824175108.19746-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210824175108.19746-1-olga.kornievskaia@gmail.com>
References: <20210824175108.19746-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

In sysfs's xprt_switch_info attribute also display the value of
number of transports with unique destination addresses for this
xprt_switch.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 414c664a3199..9a6f17e18f73 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -207,8 +207,10 @@ static ssize_t rpc_sysfs_xprt_switch_info_show(struct kobject *kobj,
 
 	if (!xprt_switch)
 		return 0;
-	ret = sprintf(buf, "num_xprts=%u\nnum_active=%u\nqueue_len=%ld\n",
+	ret = sprintf(buf, "num_xprts=%u\nnum_active=%u\n"
+		      "num_unique_destaddr=%u\nqueue_len=%ld\n",
 		      xprt_switch->xps_nxprts, xprt_switch->xps_nactive,
+		      xprt_switch->xps_nunique_destaddr_xprts,
 		      atomic_long_read(&xprt_switch->xps_queuelen));
 	xprt_switch_put(xprt_switch);
 	return ret + 1;
-- 
2.27.0

