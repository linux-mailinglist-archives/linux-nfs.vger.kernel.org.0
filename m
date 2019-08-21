Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E158497035
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2019 05:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfHUDV2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Aug 2019 23:21:28 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41894 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfHUDV2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Aug 2019 23:21:28 -0400
Received: by mail-yb1-f193.google.com with SMTP id 1so2799ybj.8;
        Tue, 20 Aug 2019 20:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oBua0iXLtvX1pOMS/2zzOhz5z0JgebEFIjoemm0o1zg=;
        b=tl8rsslErn9PGe+OVdq/oZpM6lz5Cw9WnJix3wZLV4MDA2WEC38F+41/V/93PZMYpZ
         FgAhE5MbYjmjIPkON2MY27ZKl59S50+2dmjo5mvH+Eo658Vy7y6l5ptLhXKHD9yCH/cx
         e7qa5IVLG1QTKt3IHjCUArz0LBtCdBgqmP0iDPGJNw9DlI3e0DB21rSTCv2Vr6jKbvjN
         xjXYe8w37AQYbxFyw4Dkx0YzbPK4U/j+CtyvbW+GWOtFo7bPI5uG3CFaxAtgsMz0y9Ka
         LzpZhb6w+wjy4tjfGcWQRvpVaSeKzdStZH4XkjSw+vFLD+LIzP0Kslnb3Wy2rKtWoI80
         U3Ag==
X-Gm-Message-State: APjAAAX40JpbT0pgDoyVPBazbT/ievSwQxAY0idjnIADKWnW4jast7RW
        XlODKA1ReXntMIvVfOA3gXk=
X-Google-Smtp-Source: APXvYqzG0jFrd7IJ/ULq0FqPi7FlGQPQ+MgMODAgXi6rX0jRCVcyvBpjUjZNovtVW0cbAOeH8/64Bw==
X-Received: by 2002:a25:bb03:: with SMTP id z3mr22552927ybg.160.1566357687559;
        Tue, 20 Aug 2019 20:21:27 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id m40sm4228901ywh.2.2019.08.20.20.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Aug 2019 20:21:26 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org (open list:NFS, SUNRPC, AND LOCKD CLIENTS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] NFSv4: Fix a memory leak bug
Date:   Tue, 20 Aug 2019 22:21:21 -0500
Message-Id: <1566357681-4586-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In nfs4_try_migration(), if nfs4_begin_drain_session() fails, the
previously allocated 'page' and 'locations' are not deallocated, leading to
memory leaks. To fix this issue, go to the 'out' label to free 'page' and
'locations' before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 fs/nfs/nfs4state.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index cad4e06..e916aba 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2095,8 +2095,10 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
 	}
 
 	status = nfs4_begin_drain_session(clp);
-	if (status != 0)
-		return status;
+	if (status != 0) {
+		result = status;
+		goto out;
+	}
 
 	status = nfs4_replace_transport(server, locations);
 	if (status != 0) {
-- 
2.7.4

