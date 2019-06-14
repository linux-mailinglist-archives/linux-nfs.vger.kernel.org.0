Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C2A46880
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2019 22:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfFNUA6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jun 2019 16:00:58 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40140 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfFNUA6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jun 2019 16:00:58 -0400
Received: by mail-io1-f68.google.com with SMTP id n5so8357019ioc.7
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2019 13:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4IoPYbY7faRXqYApBCuNXczxAha8aebK68IvZnRULGY=;
        b=m3aqiGyyuuwy3l4EFSugkEQFxGx4TwbTLUmS1jyIRv6tchnZd51wdjp4b4ZZFfaMYL
         sqIquJTkHnKrHiSkY95u0qlfGUZVtB/T/F4OogmA5u0/nVeVlXZL6JQcA2JMGGLSz2oh
         cVWYD9GbwhCTtht1+EVXBV/s+mjParnLPgox/buebw3hLYniuMjxuEVfoQIip5l01Il7
         7hbZBDC3sARYFiBcivRsHIthuT6NL/GsU/aMgH+ydco9YyO76CBmbeHP0SG8Wk9O07Pp
         VsWsTXBogpi552yMtSu1MX1A5Vavkeu0I5EH4CVtw6rvyGaSLPcHquBwCTsoAulTXpPN
         yZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4IoPYbY7faRXqYApBCuNXczxAha8aebK68IvZnRULGY=;
        b=U4ApfGoAF7D0Sdk00WbLOzcKMq+XipC/RhDvc/bI1U4OsGpmsJ/cX9kRypevWdhyh+
         Q4bxueyXeLImPCuloKxwVm5rXFJ+pE33tsQ8kYWnFwlXL0GdzG2AI4une0x9bfMxthVw
         N0oF69lQUUWDRonEddlxlEjK+3iYs3OJ78ZpP9duR9gZYWz00DscexvaaDKAxRkAkitW
         GDdraFXHjRvvHHSI54osjMN2/CFRgox6ndlEL9Pu8vSeChb6SpDSJaUCz2OUBQmQvDh5
         zsG2pN330wIr5GKRL0G2/4jHi9AgI6E5jc/sfLbj7A6P1Zf+aSMkufryAZMtNMZyBQ4H
         0KHg==
X-Gm-Message-State: APjAAAV4zoqUQAyZmBWKK0jIs+qiRYccYP1XG7dtO2Api+W2Kz2F+mL5
        6Bv3HeVlvfDRB3qnIOLrZ8zkz6NbSCk=
X-Google-Smtp-Source: APXvYqzbQ8IoculurkSD8F8ezD+dUKL7tjEvnP07j5mum/DeeESdMyN9bNzDOdEmKF17Z3hQPJzPEA==
X-Received: by 2002:a6b:c9c1:: with SMTP id z184mr5439990iof.74.1560542457031;
        Fri, 14 Jun 2019 13:00:57 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id p4sm6528115iod.68.2019.06.14.13.00.55
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 13:00:56 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/8] NFSD fill-in netloc4 structure
Date:   Fri, 14 Jun 2019 16:00:47 -0400
Message-Id: <20190614200054.12394-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190614200054.12394-1-olga.kornievskaia@gmail.com>
References: <20190614200054.12394-1-olga.kornievskaia@gmail.com>
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

