Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACF9482C61
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Jan 2022 18:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiABRfS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Jan 2022 12:35:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55270 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiABRfR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Jan 2022 12:35:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AF4060F4A
        for <linux-nfs@vger.kernel.org>; Sun,  2 Jan 2022 17:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5009C36AEB;
        Sun,  2 Jan 2022 17:35:16 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@kernel.org
Subject: [PATCH 01/10] NFSD: Fix verifier returned in stable WRITEs
Date:   Sun,  2 Jan 2022 12:35:15 -0500
Message-Id:  <164114491573.7344.10290554606821879947.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164114486506.7344.16096063573748374893.stgit@bazille.1015granger.net>
References:  <164114486506.7344.16096063573748374893.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2498; h=from:subject:message-id; bh=zto3mTzBTargRt592GzXFrBkR2B5JL8M0166wefXnxw=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh0eJTQm0Cd+4BUlsv7QLbMBy5AZ/LP+Hmzn3QO3Xz XXlnZBGJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYdHiUwAKCRAzarMzb2Z/lwQ6D/ 9BXdTjHIIgrTU3v7t3JHynrJADqmNni0LvSBTCvQBQ1UySZnqYjxuS1pEbgnLxXavywdPiybAIm2q6 5JMRfU5p0xyOfogpg+TBNYE60x36g5H6xSepWHb8NhHuA4lpl6/eFQq3ZaDpADE/I45gd+FUqpm8RW M4pRWKGN1C5Mh8yBIoPL61PY+tqReyLS0x1TeQw9FHqElmH8nFjAsd1rEzfp27xNFHO9f5bAdvYYHg PJQgcnUmcRvxGSihJmWQYx129A44+3QZI5UEcoNhdon9NVE9XnWuWJ7b5r0a/r3lkIvb5aoCvfB3K2 t6k92OSFyahSv685QKzuMPrThCwyRFfQJdsDGpNGTyTqnLrQtKipUe4aMdaFkOKDZKspE+FkKnESYM pTTxL73OA4mzGyBEBBg5Ev26mfiuSZRfOFiOPqJh9t2abAALXEy+yLXXKSgT4zHxaep6CKUMwnS/mY vIOGCJMy90A6Hb91yoMYxQu3aAKBjyUBWNYBs3IdY2IClhIsSKKec515+6EXm7NRyGCiwppju2HSDA XYK8IUb7xTdzr/vEGIg8IRjDRwWYyXj/TjH+SthkAJI+IINIMX/yjSFAEAbRruLH4iiF2LdbZlSMmx g79pA2HYoipYk7/bjZgy+6UWz+k0G8G8FiiC3E2lK3mpmJls+owqGiJWvj6A==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

RFC 8881 explains the purpose of the write verifier this way:

> The final portion of the result is the field writeverf. This field
> is the write verifier and is a cookie that the client can use to
> determine whether a server has changed instance state (e.g., server
> restart) between a call to WRITE and a subsequent call to either
> WRITE or COMMIT.

But then it says:

> This cookie MUST be unchanged during a single instance of the
> NFSv4.1 server and MUST be unique between instances of the NFSv4.1
> server. If the cookie changes, then the client MUST assume that
> any data written with an UNSTABLE4 value for committed and an old
> writeverf in the reply has been lost and will need to be
> recovered.

RFC 1813 has similar language for NFSv3. NFSv2 does not have a write
verifier since it doesn't implement the COMMIT procedure.

Since commit 19e0663ff9bc ("nfsd: Ensure sampling of the write
verifier is atomic with the write"), the Linux NFS server has
returned a boot-time-based verifier for UNSTABLE WRITEs, but a zero
verifier for FILE_SYNC and DATA_SYNC WRITEs. FILE_SYNC and DATA_SYNC
WRITEs are not followed up with a COMMIT, so there's no need for
clients to compare verifiers for stable writes.

However, by returning a different verifier for stable and unstable
writes, the above commit puts the Linux NFS server a step farther
out of compliance with the first MUST above. At least one NFS client
(FreeBSD) noticed the difference, making this a potential
regression.

Reported-by: Rick Macklem <rmacklem@uoguelph.ca>
Link: https://lore.kernel.org/linux-nfs/YQXPR0101MB096857EEACF04A6DF1FC6D9BDD749@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM/T/
Fixes: 19e0663ff9bc ("nfsd: Ensure sampling of the write verifier is atomic with the write")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 0faa3839ea6c..74c3451c2089 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -995,6 +995,10 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	iov_iter_kvec(&iter, WRITE, vec, vlen, *cnt);
 	if (flags & RWF_SYNC) {
 		down_write(&nf->nf_rwsem);
+		if (verf)
+			nfsd_copy_boot_verifier(verf,
+					net_generic(SVC_NET(rqstp),
+					nfsd_net_id));
 		host_err = vfs_iter_write(file, &iter, &pos, flags);
 		if (host_err < 0)
 			nfsd_reset_boot_verifier(net_generic(SVC_NET(rqstp),

