Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B5E4796A5
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 22:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhLQV5R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 16:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhLQV5Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 16:57:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8A0C061574
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 13:57:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BF08B82AEA
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 21:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A445BC36AE5;
        Fri, 17 Dec 2021 21:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639778234;
        bh=tstlxK3l0PaunHUa6sz7SHVqA8TjoSkPIh6XZXJwl1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HlEO/MF6A7VeZMi0la16QgOmgC3d7NYwLG0E1tmR/0aoJTE8xzzH0Z/CxBp8j1KMK
         9ekY7Sng4CYItLEZkNA5BYg3JSSGDBn0j5gkwnjIqidViFwvD5+28IXQuNoBfPI6HU
         vbnjYu+aj/+oKwPYkAfivkWZVdcpLS0hH6f/tHm65QEqVhSuD0wxOXpVOMTDRSHCbK
         UEP3fRoiGpuPwgW9JglXUqflMPWl/8YB5I8YWlgY70vLyejp/5oyKhP1F2dPlShmzF
         x8jbqdiJli68cGlHiUbr2HdtQMgKFa+XRXBa8+outoEU3uzK2h0n3SlMH2RXHjgRff
         tuwJykaWxaWyw==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/9] nfsd: Add errno mapping for EREMOTEIO
Date:   Fri, 17 Dec 2021 16:50:39 -0500
Message-Id: <20211217215046.40316-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217215046.40316-2-trondmy@kernel.org>
References: <20211217215046.40316-1-trondmy@kernel.org>
 <20211217215046.40316-2-trondmy@kernel.org>
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
index c2afe1afb6d7..1ebf02123368 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -880,6 +880,7 @@ nfserrno (int errno)
 		{ nfserr_toosmall, -ETOOSMALL },
 		{ nfserr_serverfault, -ESERVERFAULT },
 		{ nfserr_serverfault, -ENFILE },
+		{ nfserr_io, -EREMOTEIO },
 		{ nfserr_io, -EUCLEAN },
 		{ nfserr_perm, -ENOKEY },
 		{ nfserr_no_grace, -ENOGRACE},
-- 
2.33.1

