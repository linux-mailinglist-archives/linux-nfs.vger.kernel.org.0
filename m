Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776F02D44BC
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 15:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733110AbgLIOtf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 09:49:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733112AbgLIOtf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Dec 2020 09:49:35 -0500
From:   trondmy@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 10/16] NFSv4.2: decode_read_plus_data() must skip padding after data segment
Date:   Wed,  9 Dec 2020 09:47:55 -0500
Message-Id: <20201209144801.700778-11-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209144801.700778-10-trondmy@kernel.org>
References: <20201209144801.700778-1-trondmy@kernel.org>
 <20201209144801.700778-2-trondmy@kernel.org>
 <20201209144801.700778-3-trondmy@kernel.org>
 <20201209144801.700778-4-trondmy@kernel.org>
 <20201209144801.700778-5-trondmy@kernel.org>
 <20201209144801.700778-6-trondmy@kernel.org>
 <20201209144801.700778-7-trondmy@kernel.org>
 <20201209144801.700778-8-trondmy@kernel.org>
 <20201209144801.700778-9-trondmy@kernel.org>
 <20201209144801.700778-10-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

All XDR opaque object sizes are 32-bit aligned, and a data segment is no
exception.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs42xdr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 1c21db640f4d..4c6bce3dbaeb 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1038,7 +1038,9 @@ static int decode_read_plus_data(struct xdr_stream *xdr, struct nfs_pgio_res *re
 
 	p = xdr_decode_hyper(p, &offset);
 	count = be32_to_cpup(p);
-	recvd = xdr_align_data(xdr, res->count, count);
+	recvd = xdr_align_data(xdr, res->count, xdr_align_size(count));
+	if (recvd > count)
+		recvd = count;
 	res->count += recvd;
 
 	if (count > recvd) {
-- 
2.29.2

