Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D32324C651
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Aug 2020 21:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgHTTj4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Aug 2020 15:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgHTTjx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Aug 2020 15:39:53 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2000EC061385
        for <linux-nfs@vger.kernel.org>; Thu, 20 Aug 2020 12:39:52 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7105267A4; Thu, 20 Aug 2020 15:39:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7105267A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1597952391;
        bh=FhwwSoNh5mUaGlybT6mTMVeqrt2rPnd5L0Vo4RyYHSw=;
        h=Date:From:To:Cc:Subject:From;
        b=QpbwfBHSlDvgoIqaGoUxILe5I7iHczGkIrW2HYZ2pFFC8lcE5/XVJbRC+Fpl4QPnp
         WjqdXp08Ilehtt4I4TY5z/9yPpAbEKAuLQDT6WqsRaS+85q7sU+rJ4WXfue+j0XUH0
         mjVqtll87VXBnWSHZKeBEIWyFMKJ8jM1bu3wjWjY=
Date:   Thu, 20 Aug 2020 15:39:51 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfsd: fix oops on mixed NFSv4/NFSv3 client access
Message-ID: <20200820193951.GA28555@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

If an NFSv2/v3 client breaks an NFSv4 client's delegation, it will hit a
NULL dereference in nfsd_breaker_owns_lease().

Easily reproduceable with for example

	mount -overs=4.2 server:/export /mnt/
	sleep 1h </mnt/file &
	mount -overs=3 server:/export /mnt2/
	touch /mnt2/file

Reported-by: Robert Dinse <nanook@eskimo.com>
Fixes: 28df3d1539de50 ("nfsd: clients don't need to break their own delegations")
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 2 ++
 1 file changed, 2 insertions(+)

Oops, I've had this sitting around a couple weeks but I must have
forgotten to send it in.  This is needed for 5.9.

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4b70657385f2..0e5302f6df52 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4598,6 +4598,8 @@ static bool nfsd_breaker_owns_lease(struct file_lock *fl)
 	if (!i_am_nfsd())
 		return NULL;
 	rqst = kthread_data(current);
+	if (!rqst->rq_lease_breaker)
+		return NULL;
 	clp = *(rqst->rq_lease_breaker);
 	return dl->dl_stid.sc_client == clp;
 }
-- 
2.26.2

