Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 943D6AC32C
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Sep 2019 01:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393110AbfIFXgP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 19:36:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46508 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388714AbfIFXgP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 19:36:15 -0400
Received: by mail-io1-f66.google.com with SMTP id x4so16548447iog.13
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 16:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qGt2ER4yFNOyT1DXb865r1chKAqCRPuhuS1uy3lp5lo=;
        b=OhlM87ZdZatF/UKTGgzyXYSSWtwkf6H7wRbPRUSvnlWUQTTBiA3Ak+49Rh+n07DM42
         gZayTsSsQx9rz1WR4zT1OjIEEcwXvd81wq4OXLGU1SpdyCHSzxWZHWKc1lc3Ug6MF3zS
         Bl1TOLOJ/XOIUurglJ7SAfOJze/G3MzTHr79w0Ygi1hi3Rncv2Z9B4ttxHKfh/M/Dtoe
         9jrcVHRDEi5z1yDOmH2XeB/0D3qvHNHQws8JXgHFVctdshl8QtOup43ddh+P6ZMgXR9e
         9tJMcO53Od4pzUIXDpJSe4nARazBRN4eVGvaDQM4c/f0UnXSc3+jPASt96R+fTUOF62e
         OSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qGt2ER4yFNOyT1DXb865r1chKAqCRPuhuS1uy3lp5lo=;
        b=B3ZVNt3aBC/h4kBWzfyhHJrvbMub7T++ivULNr9BlsSc2cEiwsAJPcmG1SdFSkMIDu
         ueqpMZhdesyyjpWPIKAFYNUpTWmdjK4NmptRN+e/GqPIizmv1df5ZTg9+RiA6f4u8qZr
         GP2Q5oRU6kxjyqiS6EUr1yIy4qU8RF216VqwKuzCNX6Jumtr6c85Us2rKgFcUdItR0Wz
         fQrGJ8tJoVJcOI8AdgtEOwM4faA8yzz2OLigaH2lbjcdIRpdDvNQNuywYdako/G4sXqA
         IqQ0Aoatx9bWhsuqJVpM4FkbniYC795pWyVxL7xUt3S4Fdvoz4X2ezK4Xr7VrBZJ3VQ2
         zT4A==
X-Gm-Message-State: APjAAAUMcUy0r+gXgUBJVh2z/mrUu54TPNj5YM7MjIyYOlIPw8DPVEzo
        32s9d9koBXB3chzcANVe9vX1fS4+PDY=
X-Google-Smtp-Source: APXvYqw8GKnhGLVyiUiVklL3MGO7ItzYLxAXMrJCHd9jhahi0L1BtgqIXl3YIZHtI4fmEh9Jjht+Ow==
X-Received: by 2002:a02:c7d2:: with SMTP id s18mr12640451jao.109.1567812974026;
        Fri, 06 Sep 2019 16:36:14 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r138sm10439360iod.59.2019.09.06.16.36.13
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 16:36:13 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 01/21] NFS NFSD: defining nl4_servers structure needed by both
Date:   Fri,  6 Sep 2019 19:35:51 -0400
Message-Id: <20190906233611.4031-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
References: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
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
index fd59904a282c..5810e248c1bd 100644
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
2.18.1

