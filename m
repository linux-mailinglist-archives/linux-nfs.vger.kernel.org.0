Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4700423CEFF
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Aug 2020 21:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgHETLp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Aug 2020 15:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgHETKN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Aug 2020 15:10:13 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00974C06174A
        for <linux-nfs@vger.kernel.org>; Wed,  5 Aug 2020 12:10:12 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id B19C0425E; Wed,  5 Aug 2020 15:10:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B19C0425E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1596654611;
        bh=fkdLIa8e5zewcNIjrImpnuxZU9oGWopYF7D6RNnlPJk=;
        h=Date:To:Cc:Subject:From:From;
        b=Gs6IN8WUG2fdLw+5i6RJLn4NnF93YWI+0c14RsMUhWl8pPE8KjLNnIOEuU3HkDS4B
         qhfV6pmKvxUeW4VRtxLzbX+6hacoRXYxY+7w2mjPZ+1etFdsM/y2nNHD6FNTWGjy1E
         S1iqcOE6Zn/qeI4UEDGE3EEY7m91BFWZO/goFcwQ=
Date:   Wed, 5 Aug 2020 15:10:11 -0400
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: fix oops on mixed NFSv4/NFSv3 client access
Message-ID: <20200805191011.GB14429@fieldses.org>
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

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9fc0a1b9e4dd..45f3832d70d4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4597,6 +4597,8 @@ static bool nfsd_breaker_owns_lease(struct file_lock *fl)
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

