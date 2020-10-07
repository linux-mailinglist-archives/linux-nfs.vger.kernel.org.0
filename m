Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970D92869DA
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 23:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgJGVJa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 17:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbgJGVJa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 7 Oct 2020 17:09:30 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E253E2087D;
        Wed,  7 Oct 2020 21:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602104970;
        bh=oKoHzfk4Pdw+BEotzgkjisWZt/IwoCU5xdDP7N1iyU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ys5VVr8zn9yp9WM3whPTC69udHoT3i5MnAyNmUWkLesbLFrVDHWI/UR3kzXg4WwmD
         EC+2/ggWFwLWM4aFSV71HGLkCy9Cft6losCKTzKe7SgqN3AdeaBiWiJC39QfLZMMce
         tq0QWKWMcT0vf35IC3YOZYkizLZcEl+FvebNXd1A=
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv4: Use the net namespace uniquifier if it is set
Date:   Wed,  7 Oct 2020 17:07:20 -0400
Message-Id: <20201007210720.537880-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007210720.537880-2-trondmy@kernel.org>
References: <20201007210720.537880-1-trondmy@kernel.org>
 <20201007210720.537880-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If a container sets a net namespace specific uniquifier, then use that
in the setclientid/exchangeid process.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3a39887e0e6e..a1dd46e7440b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -63,6 +63,7 @@
 #include "callback.h"
 #include "pnfs.h"
 #include "netns.h"
+#include "sysfs.h"
 #include "nfs4idmap.h"
 #include "nfs4session.h"
 #include "fscache.h"
@@ -6007,9 +6008,25 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
 }
 
 static size_t
-nfs4_get_uniquifier(char *buf, size_t buflen)
+nfs4_get_uniquifier(struct nfs_client *clp, char *buf, size_t buflen)
 {
+	struct nfs_net *nn = net_generic(clp->cl_net, nfs_net_id);
+	struct nfs_netns_client *nn_clp = nn->nfs_client;
+	const char *id;
+	size_t len;
+
 	buf[0] = '\0';
+
+	if (nn_clp) {
+		rcu_read_lock();
+		id = rcu_dereference(nn_clp->identifier);
+		if (id && *id != '\0')
+			len = strlcpy(buf, id, buflen);
+		rcu_read_unlock();
+		if (len)
+			return len;
+	}
+
 	if (nfs4_client_id_uniquifier[0] != '\0')
 		return strlcpy(buf, nfs4_client_id_uniquifier, buflen);
 	return 0;
@@ -6034,7 +6051,7 @@ nfs4_init_nonuniform_client_string(struct nfs_client *clp)
 		1;
 	rcu_read_unlock();
 
-	buflen = nfs4_get_uniquifier(buf, sizeof(buf));
+	buflen = nfs4_get_uniquifier(clp, buf, sizeof(buf));
 	if (buflen)
 		len += buflen + 1;
 
@@ -6081,7 +6098,7 @@ nfs4_init_uniform_client_string(struct nfs_client *clp)
 	len = 10 + 10 + 1 + 10 + 1 +
 		strlen(clp->cl_rpcclient->cl_nodename) + 1;
 
-	buflen = nfs4_get_uniquifier(buf, sizeof(buf));
+	buflen = nfs4_get_uniquifier(clp, buf, sizeof(buf));
 	if (buflen)
 		len += buflen + 1;
 
-- 
2.26.2

