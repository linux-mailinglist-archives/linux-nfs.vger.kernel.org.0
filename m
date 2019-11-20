Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5890A104124
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2019 17:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732112AbfKTQnW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Nov 2019 11:43:22 -0500
Received: from fieldses.org ([173.255.197.46]:34708 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732895AbfKTQnR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 20 Nov 2019 11:43:17 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id B7E021C97; Wed, 20 Nov 2019 11:43:16 -0500 (EST)
Date:   Wed, 20 Nov 2019 11:43:16 -0500
To:     linux-nfs@vger.kernel.org
Cc:     Trond Myklebust <trondmy@hammerspace.com>
Subject: [PATCH] nfsd: restore NFSv3 ACL support
Message-ID: <20191120164316.GA8520@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

An error in e333f3bbefe3 left the nfsd_acl_program->pg_vers array empty,
which effectively turned off the server's support for NFSv3 ACLs.

Fixes: e333f3bbefe3 "nfsd: Allow containers to set supported nfs versions"
Cc: stable@vger.kernel.org
Cc: Trond Myklebust <trondmy@gmail.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfssvc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Kinda wondering if it says something that server NFSv3 ACL support was
off in 5.2 and 5.3 and nobody noticed.  (At least I don't recall any
reports.)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index fdf7ed4bd5dd..e8bee8ff30c5 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -95,12 +95,11 @@ static const struct svc_version *nfsd_acl_version[] = {
 
 #define NFSD_ACL_MINVERS            2
 #define NFSD_ACL_NRVERS		ARRAY_SIZE(nfsd_acl_version)
-static const struct svc_version *nfsd_acl_versions[NFSD_ACL_NRVERS];
 
 static struct svc_program	nfsd_acl_program = {
 	.pg_prog		= NFS_ACL_PROGRAM,
 	.pg_nvers		= NFSD_ACL_NRVERS,
-	.pg_vers		= nfsd_acl_versions,
+	.pg_vers		= nfsd_acl_version,
 	.pg_name		= "nfsacl",
 	.pg_class		= "nfsd",
 	.pg_stats		= &nfsd_acl_svcstats,
-- 
2.23.0

