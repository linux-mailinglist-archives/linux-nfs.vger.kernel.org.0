Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD172D44BB
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 15:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbgLIOtf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 09:49:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733110AbgLIOtf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Dec 2020 09:49:35 -0500
From:   trondmy@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 09/16] NFSv4.2: Ensure we always reset the result->count in decode_read_plus()
Date:   Wed,  9 Dec 2020 09:47:54 -0500
Message-Id: <20201209144801.700778-10-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209144801.700778-9-trondmy@kernel.org>
References: <20201209144801.700778-1-trondmy@kernel.org>
 <20201209144801.700778-2-trondmy@kernel.org>
 <20201209144801.700778-3-trondmy@kernel.org>
 <20201209144801.700778-4-trondmy@kernel.org>
 <20201209144801.700778-5-trondmy@kernel.org>
 <20201209144801.700778-6-trondmy@kernel.org>
 <20201209144801.700778-7-trondmy@kernel.org>
 <20201209144801.700778-8-trondmy@kernel.org>
 <20201209144801.700778-9-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs42xdr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index c0b8fcd266c9..1c21db640f4d 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1087,6 +1087,7 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 	if (unlikely(!p))
 		return -EIO;
 
+	res->count = 0;
 	eof = be32_to_cpup(p++);
 	segments = be32_to_cpup(p++);
 	if (segments == 0)
-- 
2.29.2

