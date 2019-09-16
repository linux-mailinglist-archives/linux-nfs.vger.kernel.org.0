Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7ACB42C7
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 23:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391615AbfIPVOH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 17:14:07 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33293 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391553AbfIPVOH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 17:14:07 -0400
Received: by mail-io1-f68.google.com with SMTP id m11so2571147ioo.0
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 14:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oYFP7LnHnffo4j/n4viWpRrrs/1IS/MsGu8QY/P3UN4=;
        b=WJWM3dvQcA2GyESkcyElRntWZsT+MqkeLdL+6WSL2iloesJeAzuDZlJ/cJEVe9lrMF
         xxdX5taBiptyA0kbyQ5pJRyzcTBAhcQKVhTLl/ywoMlL6XQalXms9VFrJgRUj270HR1W
         g9+v5IqNf67QY8Va0vG7K9TdPOk98wDWq+wsNUVkQprrM2MbqZPl5CKMS4HXwmyvBpO3
         qP7nwLsHC0kQtYXby7G16YEkXB8OBQTFUEuRyODJWX8ua+6MsIWhfUDd7S1fWuoC835q
         xI8nH9GmvbZ/MYBcBYrSBVouzsk0Ody15irVkSI+zhUXtqaNbManNaLint9GyrQ+/Pi+
         AZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oYFP7LnHnffo4j/n4viWpRrrs/1IS/MsGu8QY/P3UN4=;
        b=e1aTDqwxckJ9ZytTf46ziqzNScbfdTbfif3fafk2Gra6tAgH0gM4bTWdmth4tLqjHX
         r88+C6TCP1nyQaVXOBzrJ9xEi898DOYXsIFAFxcPR4PVVZJ2EY4LW00I0NzUWaaqrWhd
         k96emf3gl0zDcJEd8VSm2scgAswDEpyuCBuKImpe6BqPPFmmwPR/21EZ1Bg9tQ5zsz+3
         EQznH3KkLHpL3WDTDCTJenVeyMJUWLsFA/b4gIUjHn0Qlcot5gYGMYo1D+KljTRth3dG
         EgaueXJvwNFYjQJMAn6Gj1kVlGN4ZarwZOcXOZLn8uoJP56+PdQCbQo6w+fBpMNqfU7t
         R1Kw==
X-Gm-Message-State: APjAAAXywV1tsPspTtEX4aknrNkRFW5zqn07427k9ztbNqYeKBZL9cRp
        mf4xsJ/XuWouay+8L3aCYB9Ii3LO
X-Google-Smtp-Source: APXvYqztMnETTEpFOi4+BK8o8yR8N5DQPhN42BW+iBThEUpxOY0CtdsoDElXwUSfV1ET2m4iKvB/dQ==
X-Received: by 2002:a5e:8219:: with SMTP id l25mr344831iom.177.1568668446409;
        Mon, 16 Sep 2019 14:14:06 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id l186sm71853ioa.54.2019.09.16.14.14.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 14:14:05 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 11/19] NFSD fill-in netloc4 structure
Date:   Mon, 16 Sep 2019 17:13:45 -0400
Message-Id: <20190916211353.18802-12-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
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
index af29475..687f8e1 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -19,6 +19,7 @@
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/svc_xprt.h>
 #include <linux/sunrpc/msg_prot.h>
+#include <linux/sunrpc/addr.h>
 
 #include <uapi/linux/nfsd/debug.h>
 
@@ -386,6 +387,37 @@ static inline bool nfsd4_spo_must_allow(struct svc_rqst *rqstp)
 
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

