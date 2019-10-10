Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3C2FD29D3
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2019 14:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387705AbfJJMq2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Oct 2019 08:46:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39728 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733051AbfJJMq2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Oct 2019 08:46:28 -0400
Received: by mail-io1-f67.google.com with SMTP id a1so13331064ioc.6
        for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2019 05:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XsCVxoMR45LfMXA6Sd1k+7LRp9n+Zt/u7Ma/oGmC6xY=;
        b=UgD5UUFkXfFNBeSkdqNEJ21MO2+BCkGGDwBzhyGHf3+5zfxFQou7tAM+14IUvhXEEd
         WyjhkKk/StjZmkKKk5NYHtzceIVUifTFj6hvvjOdTI1Xb4srzBbQnVEjDBnVgXzSSZc4
         1FEnj4Y8YnYWZHvzCEnB4c+Pjx7vQqOt1xktL06lUp25IMzmNaonO44ci0lOzL4ujVcG
         TH7NcX3ny6hAb0ujQDWuNKh35aHYcwvmIglMRUn980U2d4aJriPniD+X3yBjouTLk4qh
         ZVlizOkzaMGlYgccK5GaTDwp8F8U/O6njvpPRsZAvvyxUZhnPTLmINsyymmKCYu+1xS5
         OIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XsCVxoMR45LfMXA6Sd1k+7LRp9n+Zt/u7Ma/oGmC6xY=;
        b=LkWUO1IsOw4vs7aOFCafu4AfiekVB/yYT4+Z2J2+s1aD3j5fmcVwvuTzYBxUlf6t62
         PAKfAP8Lkb4nbYA/OKPcsNJ3D3+YEhzeARLGdf/R350lbbTtIbUtXwlAbhm60XzAGys2
         WCFJijdnJXzoG67kNzXPrUSO18Bk1OjSb+lJgLolIn/gtSP5B0ycn1Qmgf58TFL7brAz
         JRbSh+l9weOgRHb5k4lTp8JibC4ACRaob8EqRCLbuv0EjMJnnscSvdr5Gi3fmF0f0cBk
         xNAn7EUbR4ndkFX8HwVM1qf5o0FWjoaZo4qGsXCFcr0/TdQQwCqxMdnx1MuaNNXYpjfw
         GPJQ==
X-Gm-Message-State: APjAAAWcROmFyvOPobC1npHA2F3FJvcgaC8zRtEI7MbqqdMSXzl4wIYp
        lDajjP3So8cCPoR1l2yrWaU=
X-Google-Smtp-Source: APXvYqz/3dyRnlwY+927HZ4m4wKV8caSzW741RFx/WVHfsE0nql45Ry4RmfVLhMkUNkYMDsDp9N8JQ==
X-Received: by 2002:a92:4047:: with SMTP id n68mr487587ila.56.1570711585904;
        Thu, 10 Oct 2019 05:46:25 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r2sm1100930ilm.17.2019.10.10.05.46.24
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 10 Oct 2019 05:46:25 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 01/20] NFS NFSD: defining nl4_servers structure needed by both
Date:   Thu, 10 Oct 2019 08:46:03 -0400
Message-Id: <20191010124622.27812-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
References: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

These structures are needed by COPY_NOTIFY on the client and needed
by the nfsd as well

Reviewed-by: Jeff Layton <jlayton@redhat.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/nfs4.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index fd59904..5810e24 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -16,6 +16,7 @@
 #include <linux/list.h>
 #include <linux/uidgid.h>
 #include <uapi/linux/nfs4.h>
+#include <linux/sunrpc/msg_prot.h>
 
 enum nfs4_acl_whotype {
 	NFS4_ACL_WHO_NAMED = 0,
@@ -674,4 +675,27 @@ struct nfs4_op_map {
 	} u;
 };
 
+struct nfs42_netaddr {
+	char		netid[RPCBIND_MAXNETIDLEN];
+	char		addr[RPCBIND_MAXUADDRLEN + 1];
+	u32		netid_len;
+	u32		addr_len;
+};
+
+enum netloc_type4 {
+	NL4_NAME		= 1,
+	NL4_URL			= 2,
+	NL4_NETADDR		= 3,
+};
+
+struct nl4_server {
+	enum netloc_type4	nl4_type;
+	union {
+		struct { /* NL4_NAME, NL4_URL */
+			int	nl4_str_sz;
+			char	nl4_str[NFS4_OPAQUE_LIMIT + 1];
+		};
+		struct nfs42_netaddr	nl4_addr; /* NL4_NETADDR */
+	} u;
+};
 #endif
-- 
1.8.3.1

