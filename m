Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD556293E
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 21:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbfGHTXw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 15:23:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34420 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbfGHTXw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jul 2019 15:23:52 -0400
Received: by mail-io1-f67.google.com with SMTP id k8so37939995iot.1
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2019 12:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4IoPYbY7faRXqYApBCuNXczxAha8aebK68IvZnRULGY=;
        b=VqOw8xLbTyJPb0GgFh2C016YP0I4+RW53FzhOS6Tfi08g26rO9e7Vj+BuhMokQsgnL
         oQ34Y2IAkmGCLCi+Kl75B9BWFOG37nOndVhG+lPLwDNhsmsMssEffXY2UamkK4yd07av
         ylpxr6OAD4lCCYQIXfPYZa5UOqfrmfLVA9nxUhdVZo9XulH7BVBOUMul2j1mn6RQWCkO
         WgQ9uR3I+Ruq6+cCMETgmWflsz+3LXbgGMhOcHNUziHfDLJRc7yOsgi93NGXCOrpUtsK
         ZH8s5Th2GnqrXaUsHM3QDJjkrGkhSsqWCg3zb6t8UJ/tOKOpJvb9LQGl+JC2oNs/i0ku
         30LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4IoPYbY7faRXqYApBCuNXczxAha8aebK68IvZnRULGY=;
        b=EvpIPplqkFuC4Zm0+O3JRXmYDiHx5I8pGA3R6/lRb9nhZM917aalwl7sD27yMpFCbS
         H5/m9a72eIjTTgzfX6LEE3LCXtjrfqcfqPKsEWOyTAoVm5F81p179qULHJeybFKZBbqq
         l80d0P8J6Ax0VKbKIi0REa+KlZZFbB9GJvGNHaZ+r+XXEa3q3hCIYuqrXlXJYoEDA8hX
         slY/8Ql8AiEuwuyMgEYcQ1VeI98N/uWJt57OwI7zitSgFttdcnFLKi4Vjm7HI1+oehXJ
         qHIdIOLhZnGWlVUYMoKQ1/r8UdMp2yjEFbpFVnh2U3fVcXoSMrsVQc65agrZUNKTwZPC
         72IA==
X-Gm-Message-State: APjAAAXiydnQYkCWIdKK7z1ILu85BVC6M701onGpdAqgnDb/XsN+YGeG
        a0OR9hz02UPpg7PRO6+YgaE=
X-Google-Smtp-Source: APXvYqxly6UJvhCnQ0MOSYaH6mDmNDaLFrOwKrQUvebMkTKey3ymvR47Z2a0H0mEtaSlV95XCh2UhQ==
X-Received: by 2002:a6b:bec7:: with SMTP id o190mr19719765iof.158.1562613831708;
        Mon, 08 Jul 2019 12:23:51 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id v3sm9212841iom.53.2019.07.08.12.23.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 08 Jul 2019 12:23:51 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 1/8] NFSD fill-in netloc4 structure
Date:   Mon,  8 Jul 2019 15:23:45 -0400
Message-Id: <20190708192352.12614-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

nfs.4 defines nfs42_netaddr structure that represents netloc4.

Populate needed fields from the sockaddr structure.

This will be used by flexfiles and 4.2 inter copy

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfsd.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 24187b5..8f4fc50 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -19,6 +19,7 @@
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/svc_xprt.h>
 #include <linux/sunrpc/msg_prot.h>
+#include <linux/sunrpc/addr.h>
 
 #include <uapi/linux/nfsd/debug.h>
 
@@ -375,6 +376,37 @@ static inline bool nfsd4_spo_must_allow(struct svc_rqst *rqstp)
 
 extern const u32 nfsd_suppattrs[3][3];
 
+static inline u32 nfsd4_set_netaddr(struct sockaddr *addr,
+				    struct nfs42_netaddr *netaddr)
+{
+	struct sockaddr_in *sin = (struct sockaddr_in *)addr;
+	struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)addr;
+	unsigned int port;
+	size_t ret_addr, ret_port;
+
+	switch (addr->sa_family) {
+	case AF_INET:
+		port = ntohs(sin->sin_port);
+		sprintf(netaddr->netid, "tcp");
+		netaddr->netid_len = 3;
+		break;
+	case AF_INET6:
+		port = ntohs(sin6->sin6_port);
+		sprintf(netaddr->netid, "tcp6");
+		netaddr->netid_len = 4;
+		break;
+	default:
+		return nfserr_inval;
+	}
+	ret_addr = rpc_ntop(addr, netaddr->addr, sizeof(netaddr->addr));
+	ret_port = snprintf(netaddr->addr + ret_addr,
+			    RPCBIND_MAXUADDRLEN + 1 - ret_addr,
+			    ".%u.%u", port >> 8, port & 0xff);
+	WARN_ON(ret_port >= RPCBIND_MAXUADDRLEN + 1 - ret_addr);
+	netaddr->addr_len = ret_addr + ret_port;
+	return 0;
+}
+
 static inline bool bmval_is_subset(const u32 *bm1, const u32 *bm2)
 {
 	return !((bm1[0] & ~bm2[0]) ||
-- 
1.8.3.1

