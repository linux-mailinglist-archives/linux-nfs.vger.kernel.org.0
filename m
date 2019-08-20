Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D7D958F5
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 09:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfHTHyT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Aug 2019 03:54:19 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43696 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfHTHyT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Aug 2019 03:54:19 -0400
Received: by mail-yb1-f196.google.com with SMTP id o82so1655127ybg.10;
        Tue, 20 Aug 2019 00:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OjkK6EB2PuI2qQbEQ93AzCQ5P3wMA5I+qFalZij811o=;
        b=gXa6zBs/Vbdo8i/Zn03xEZQldj+P0MbGSsCx3mhD9VSJDB4G3745OtRwYKBq9yL+Px
         E+v393O7WKDAy03bintkbcCfgUkADvdcHbXiCYOeNUnfLgYyMYFGKpjB7tbizkGMlYSM
         Rbz4GqZNIKwn4Woq44OATK5tKqZk3uBxzX211wHKoSCXEGaZlzWZxxTKz4SaiflXZEd9
         n+lLJbUulxjxxvaF3/z9F+gZgYfFOJV+HGJLRFprAAr67hfwWv5v6Y+sYN4Lji/qAa8k
         tmk8ZUVYWPvX83XBZksu9gK5Pkqc2rogU/FzUXU9aB7h7OeQ7xuIECZBTtNVPP6i5U6p
         oIbg==
X-Gm-Message-State: APjAAAVX0n8mH58giXg15G46LDkALP40dS+TNcBm6oMyR8UBI8qSUrw8
        igAenpH2qBWRCS8aZDPxrWk=
X-Google-Smtp-Source: APXvYqwXfHgvtpvoCxcqC68OdHOkyoo1ZThYfoBbHm7jWpj5bnNPAx0YGY9TW7kmf3RukgXpxJQNKg==
X-Received: by 2002:a25:2403:: with SMTP id k3mr18920369ybk.377.1566287658366;
        Tue, 20 Aug 2019 00:54:18 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id t63sm3448566ywf.92.2019.08.20.00.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Aug 2019 00:54:16 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org (open list:NFS, SUNRPC, AND LOCKD CLIENTS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] NFSv4: Fix a memory leak bug
Date:   Tue, 20 Aug 2019 02:54:10 -0500
Message-Id: <1566287651-11386-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In nfs4_try_migration(), if nfs4_begin_drain_session() fails, the
previously allocated 'page' and 'locations' are not deallocated, leading to
memory leaks. To fix this issue, free 'page' and 'locations' before
returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 fs/nfs/nfs4state.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index cad4e06..37823dc 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2095,8 +2095,12 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
 	}
 
 	status = nfs4_begin_drain_session(clp);
-	if (status != 0)
+	if (status != 0) {
+		if (page != NULL)
+			__free_page(page);
+		kfree(locations);
 		return status;
+	}
 
 	status = nfs4_replace_transport(server, locations);
 	if (status != 0) {
-- 
2.7.4

