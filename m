Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DCE33128D
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Mar 2021 16:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhCHPv6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Mar 2021 10:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhCHPv5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Mar 2021 10:51:57 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEE8C06174A
        for <linux-nfs@vger.kernel.org>; Mon,  8 Mar 2021 07:51:57 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 27E9723D8; Mon,  8 Mar 2021 10:51:51 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 27E9723D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1615218711;
        bh=vkDTc1A+vYcibLi+ve/DNdx3yo4Si4tNWWU7QXiUcUA=;
        h=Date:To:Cc:Subject:From:From;
        b=nELbCA8IK8FxcEm84PVk2vF1eob04PHYxm8warB31oUnzSiv7hMRqwN605HVyX06K
         1/qh3kBwMpPlGnStXhgtgyvKBMpLJ0M7fqNI6oWdoBKgpZXYp1tLAPHx7glRtzG3Z4
         DAfc5k5Ytf4QqEWx3vxhgbOn5s7MaoXNJ5mDC1NA=
Date:   Mon, 8 Mar 2021 10:51:51 -0500
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] Revert "nfsd4: remove check_conflicting_opens warning"
Message-ID: <20210308155151.GC7284@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

This reverts commit 50747dd5e47b "nfsd4: remove check_conflicting_opens
warning", as a prerequisite for reverting 94415b06eb8a, which has a
serious bug.

Cc: stable@vger.kernel.org
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4f6d7658da8a..408e2c4db926 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4952,6 +4952,7 @@ static int nfsd4_check_conflicting_opens(struct nfs4_client *clp,
 		writes--;
 	if (fp->fi_fds[O_RDWR])
 		writes--;
+	WARN_ON_ONCE(writes < 0);
 	if (writes > 0)
 		return -EAGAIN;
 	spin_lock(&fp->fi_lock);
-- 
2.29.2

