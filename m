Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECDE32FDDB
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Mar 2021 23:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhCFWcr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Mar 2021 17:32:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229977AbhCFWco (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 6 Mar 2021 17:32:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7941F650D0
        for <linux-nfs@vger.kernel.org>; Sat,  6 Mar 2021 22:32:44 +0000 (UTC)
Subject: [PATCH v2 35/43] NFSD: Update the NFSv2 SETACL result encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 06 Mar 2021 17:32:43 -0500
Message-ID: <161506996373.4312.5185301493220008587.stgit@klimt.1015granger.net>
In-Reply-To: <161506956174.4312.17478383686779759287.stgit@klimt.1015granger.net>
References: <161506956174.4312.17478383686779759287.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The SETACL result encoder is exactly the same as the NFSv2
attrstatres decoder.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs2acl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 4a15ae6fdbc2..9c572ffa5e7b 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -365,8 +365,8 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 	[ACLPROC2_SETACL] = {
 		.pc_func = nfsacld_proc_setacl,
 		.pc_decode = nfsaclsvc_decode_setaclargs,
-		.pc_encode = nfsaclsvc_encode_attrstatres,
-		.pc_release = nfsaclsvc_release_attrstat,
+		.pc_encode = nfssvc_encode_attrstatres,
+		.pc_release = nfssvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd3_setaclargs),
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_NOCACHE,


