Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C58489F6F
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jan 2022 19:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242051AbiAJSoi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jan 2022 13:44:38 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:34078 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241010AbiAJSoi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jan 2022 13:44:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0653A62DA5FD;
        Mon, 10 Jan 2022 19:44:37 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SqfSNtZe19CD; Mon, 10 Jan 2022 19:44:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B4E3B62DA609;
        Mon, 10 Jan 2022 19:44:36 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aUPoyCPwtB1g; Mon, 10 Jan 2022 19:44:36 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 42DB362DA5FD;
        Mon, 10 Jan 2022 19:44:36 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     bfields@fieldses.org, luis.turcitu@appsbroker.com,
        chris.chilvers@appsbroker.com, david.young@appsbroker.com,
        daire@dneg.com, david.oberhollenzer@sigma-star.at,
        david@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, Richard Weinberger <richard@nod.at>
Subject: [RFC PATCH 1/3] NFSD: Teach nfsd_mountpoint() auto mounts
Date:   Mon, 10 Jan 2022 19:44:17 +0100
Message-Id: <20220110184419.27665-2-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220110184419.27665-1-richard@nod.at>
References: <20220110184419.27665-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently nfsd_mountpoint() tests for mount points using d_mountpoint(),
this works only when a mount point is already uncovered.
In our case the mount point is of type auto mount and can be coverted.
i.e. ->d_automount() was not called.

Using d_managed() nfsd_mountpoint() can test whether a mount point is
either already uncovered or can be uncovered later.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/nfsd/vfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index c99857689e2c..2f3352a99de6 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -160,7 +160,7 @@ int nfsd_mountpoint(struct dentry *dentry, struct svc=
_export *exp)
 		return 1;
 	if (nfsd4_is_junction(dentry))
 		return 1;
-	if (d_mountpoint(dentry))
+	if (d_managed(dentry))
 		/*
 		 * Might only be a mountpoint in a different namespace,
 		 * but we need to check.
--=20
2.26.2

