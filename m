Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBA01AC0BD
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2019 21:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392220AbfIFTqg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 15:46:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46775 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfIFTqf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 15:46:35 -0400
Received: by mail-io1-f67.google.com with SMTP id x4so15339598iog.13
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 12:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XsCVxoMR45LfMXA6Sd1k+7LRp9n+Zt/u7Ma/oGmC6xY=;
        b=GFSRuB945LVXBRtETQnhpmD7dDdy5iAMuEcvtZGMkDsgYSTOXkCHJvnKSvuj5oDmrj
         11F8YeR25K5kCklyKpngpJJvQa2v28bND0KYopUEGhyOteaPQSJe7xgpEg9Ao2wxG9hg
         08ht5G/LhyTD056BMBkzte0B97z0hUm7XsBPjU5pNUrVdr0RNj4NWJq8GSsRwnpFM2Oe
         cHErImOX9BuUfYLYv4jAhu3UeOtMthprkEI0kRlWg8AWVOr4FXLqxTsSbQ1tZP7ENuJ/
         WCylfENidxaYUDffEJtzMDvAXEJwIfGyUMoENrATAbGTZIfP94a7WXL5oHZfAZEb4wYl
         YMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XsCVxoMR45LfMXA6Sd1k+7LRp9n+Zt/u7Ma/oGmC6xY=;
        b=ZwMKo6viPpNnDa1JkywG4BI9hnQZVMeuKimXdlLC0TfJH+0aC0W55HAPRaebN3ajCw
         sXp7t7WpsIR4tHRvTEBN4Sid2xqjDD+TGiLRqxhLJ8YjVekID/QLtMguoAQ48rl2NQXP
         caXHOyyhJ48t6oU2iYlbmdlfW9u18KG9qcJnXaIW3ZjvZFCFN6OdzNai9QyXP79AyniN
         bmpi3df3vEHZ+Vtk4lHTPxWjQV3F8EOQw6zqFjmDnd8soEm3O4EY1vfzWQ7hmXl2Ct56
         moX0c1z3DdTu0b6xfVolHCikiO7NQYKhEG79lMXxV5/2yUdK3DNWIYA5K5tZan7n/lsf
         Yhyw==
X-Gm-Message-State: APjAAAVIIAfMeTSasv2c/Kbk418+1VCUd/Rh0OSq9fWHP/Groy1NoTqE
        1p7mp7WPbIbfgB4oa7AhZD8=
X-Google-Smtp-Source: APXvYqwStMexRbSxYR+IhbevuxEfHIYRwH5jGAWJwOLSKLc1mx/dV/gXzfho/nv7uCMYiOM5SB3koQ==
X-Received: by 2002:a6b:7215:: with SMTP id n21mr2254400ioc.238.1567799195059;
        Fri, 06 Sep 2019 12:46:35 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id i14sm5118085ioi.47.2019.09.06.12.46.34
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 12:46:34 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 01/19] NFS NFSD: defining nl4_servers structure needed by both
Date:   Fri,  6 Sep 2019 15:46:13 -0400
Message-Id: <20190906194631.3216-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
References: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
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

