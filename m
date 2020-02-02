Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07BFF14FFE1
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Feb 2020 23:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgBBW7T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Feb 2020 17:59:19 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33469 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgBBW7S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Feb 2020 17:59:18 -0500
Received: by mail-yw1-f67.google.com with SMTP id 192so11986593ywy.0
        for <linux-nfs@vger.kernel.org>; Sun, 02 Feb 2020 14:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YGrlvKAfxCFiUu1PNVZjoQ48M4xiWbhF3ItqGi9Zh8Q=;
        b=Q9rULmY0DfPbj5hpMZDE4CurtL2RGs4Kpr1C3hRNF0WYGCuFlZGBoiaGz6dOxFR71A
         VtZug9L8vj9sfaVBHtlAEGDoSLsAzP2pkxmGx7XFahLNOkgBPQu3/tMTFuSDzspBJnkH
         FPzU2r4d4XNSAr/J1+rBZGfR58f7uDM3eYeBGRMqBd5g0mAC5ZoyMbbn/JD5DwVyDehY
         8tB98246PkMyRPi/cjuDyYxu53qCkQb1hG0/On0RW7R6FXmi8ivplrofOQ2wegJRSTGy
         tQGL2lTYVbjO9oV1QB510SUYmFVE/+g08xTZ3pzVHSmGUbLcvTd7c8rhUtY1FZ1xuwxo
         L+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YGrlvKAfxCFiUu1PNVZjoQ48M4xiWbhF3ItqGi9Zh8Q=;
        b=mnnZRJY6YBNMUPznA6xeuy0LQjq1HWcVekimkdYRgfK/5W6/gCtmj8+CqWrOvSBPww
         RJptQIoNNypikC1gaK8mC6tDHW1ilYf521BZUPBHNvLMp5XYxSG6RZMDfwlUoA5aHoyb
         YouSQ5My5hrugtSRblO1Y5nI9J8O+0bkqxw74p2qPY2t6w6XtsOt+LcYsaoJm84H8uJK
         yo0boRYbirXA7liFhuwis3ecVf+6K7u6NjxPIDJZ2x9Sw1Yo563veOq4FNXNHbKTBeSS
         w+9xnq6qE7X9GsI2laKfXGBpKsCjj/FvUbdvwM6Gbf3pJHa/cn5F3j9X52epCFoXw7Dv
         WmaQ==
X-Gm-Message-State: APjAAAVbxLz74iD2dLQiymh4S+GmWNgrCdnLLZO/+IyjtFcIUqTuriHq
        knGlLzsj2mUceoiBeplBjg+SHAxdTw==
X-Google-Smtp-Source: APXvYqx2IGt5lRErsDnBWJPUeS9rBk5xujNqtMKaC+fHREp/f0ZzCPG+9hyiNW0pAxr5mnfoOxycTw==
X-Received: by 2002:a25:496:: with SMTP id 144mr16920446ybe.272.1580684357585;
        Sun, 02 Feb 2020 14:59:17 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id j11sm7532238ywg.37.2020.02.02.14.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:59:17 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFS: Replace various occurrences of kstrndup() with kmemdup_nul()
Date:   Sun,  2 Feb 2020 17:57:07 -0500
Message-Id: <20200202225708.995271-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When we already know the string length, it is more efficient to
use kmemdup_nul().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dns_resolve.c   | 2 +-
 fs/nfs/nfs4namespace.c | 2 +-
 fs/nfs/super.c         | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/dns_resolve.c b/fs/nfs/dns_resolve.c
index aec769a500a1..89bd5581f317 100644
--- a/fs/nfs/dns_resolve.c
+++ b/fs/nfs/dns_resolve.c
@@ -93,7 +93,7 @@ static void nfs_dns_ent_init(struct cache_head *cnew,
 	key = container_of(ckey, struct nfs_dns_ent, h);
 
 	kfree(new->hostname);
-	new->hostname = kstrndup(key->hostname, key->namelen, GFP_KERNEL);
+	new->hostname = kmemdup_nul(key->hostname, key->namelen, GFP_KERNEL);
 	if (new->hostname) {
 		new->namelen = key->namelen;
 		nfs_dns_ent_update(cnew, ckey);
diff --git a/fs/nfs/nfs4namespace.c b/fs/nfs/nfs4namespace.c
index 513c272b05a9..4ea134ab56ab 100644
--- a/fs/nfs/nfs4namespace.c
+++ b/fs/nfs/nfs4namespace.c
@@ -452,7 +452,7 @@ static int nfs4_try_replacing_one_location(struct nfs_server *server,
 		rpc_set_port(sap, NFS_PORT);
 
 		error = -ENOMEM;
-		hostname = kstrndup(buf->data, buf->len, GFP_KERNEL);
+		hostname = kmemdup_nul(buf->data, buf->len, GFP_KERNEL);
 		if (hostname == NULL)
 			break;
 
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 928f22c76b43..9872ece28627 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1969,13 +1969,13 @@ static int nfs_parse_devname(const char *dev_name,
 		goto out_hostname;
 
 	/* N.B. caller will free nfs_server.hostname in all cases */
-	*hostname = kstrndup(dev_name, len, GFP_KERNEL);
+	*hostname = kmemdup_nul(dev_name, len, GFP_KERNEL);
 	if (*hostname == NULL)
 		goto out_nomem;
 	len = strlen(++end);
 	if (len > maxpathlen)
 		goto out_path;
-	*export_path = kstrndup(end, len, GFP_KERNEL);
+	*export_path = kmemdup_nul(end, len, GFP_KERNEL);
 	if (!*export_path)
 		goto out_nomem;
 
-- 
2.24.1

