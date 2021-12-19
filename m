Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D10B479EB9
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Dec 2021 02:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbhLSBow (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Dec 2021 20:44:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60816 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbhLSBow (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Dec 2021 20:44:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFDB460C63
        for <linux-nfs@vger.kernel.org>; Sun, 19 Dec 2021 01:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1213C36AE2;
        Sun, 19 Dec 2021 01:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639878291;
        bh=0Jsk7Zr5sI+GMlFYYqBo32v096qFNJVtL/py9XyTCjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9IRTRHzb/heiR4TOyI+QcYeNAgAsVHxxCDC5qLX1jZg4/eCb6h3dSXiiIs4F4eLq
         vdDZ/QYTl1opaYG9hwlMQf6vjv9WXrHikphgaBYMupbK/HO61cH7Fb8/2XJwzdpsah
         hoGLmS81mrACudFFPtCg5lqbuia2a7zYoHo4EeOnMHez9yJn827RO7GK49H84kSgVG
         8QNt/qVEk8fAeqLJVqIVjBDQIyu3+8wZht9RJLYHQEuFvTUWxmh89sg4Zxvr5zsbFt
         +VXG5mVK+89U5LogvspYQmAQoaagpIPj0nvrsSgGOogng5Ccygr9L6zd2ej0eCUqDN
         s9rpusBap2srw==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 02/10] nfsd: Add errno mapping for EREMOTEIO
Date:   Sat, 18 Dec 2021 20:37:55 -0500
Message-Id: <20211219013803.324724-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211219013803.324724-2-trondmy@kernel.org>
References: <20211219013803.324724-1-trondmy@kernel.org>
 <20211219013803.324724-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

The NFS client can occasionally return EREMOTEIO when signalling issues
with the server.  ...map to NFSERR_IO.

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfsproc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 0a2b2795585f..83bd11be8406 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -879,6 +879,7 @@ nfserrno (int errno)
 		{ nfserr_toosmall, -ETOOSMALL },
 		{ nfserr_serverfault, -ESERVERFAULT },
 		{ nfserr_serverfault, -ENFILE },
+		{ nfserr_io, -EREMOTEIO },
 		{ nfserr_io, -EUCLEAN },
 		{ nfserr_perm, -ENOKEY },
 		{ nfserr_no_grace, -ENOGRACE},
-- 
2.33.1

