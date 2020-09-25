Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACBC2792DF
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 23:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgIYVCl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 17:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgIYVCk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 17:02:40 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD54C0613CE
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 14:02:40 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1EEF1C53; Fri, 25 Sep 2020 17:02:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1EEF1C53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1601067760;
        bh=790gr4txq+NlB1t6y7GqcfAJl4bf6FWm4XWswRhYrXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I0oq7uB0vDt3CdFG/aZO5Yj0xirdlr4g0cFwZx42Y4EXNdLYtarKOaJHGZREgSk+K
         xeU1+Pk7qhjp41JM18OaxXTMa8Azj+2Tjokefbh6HFkxV4paYIY/DPKnwRD/oym0gy
         4liDZ1U/yWaqxYicSem76ZLD5nIX9fEC7O9YqhTc=
Date:   Fri, 25 Sep 2020 17:02:40 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: rq_lease_breaker cleanup
Message-ID: <20200925210240.GJ1096@fieldses.org>
References: <160106058240.10141.2317053300018495103.stgit@klimt.1015granger.net>
 <20200925204809.GI1096@fieldses.org>
 <5B93AC63-B81B-443B-BE28-D4F718978817@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B93AC63-B81B-443B-BE28-D4F718978817@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 25, 2020 at 04:49:57PM -0400, Chuck Lever wrote:
> Am I missing a patch that removes
> 
> 	if (!rqst->rq_lease_breaker)
> 		return NULL;

I've been working off 5.9-rc1, which doesn't have it, sorry about that.

--b.

commit 58b869423e3d
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Fri Sep 25 10:12:39 2020 -0400

    nfsd: rq_lease_breaker cleanup
    
    Since only the v4 code cares about it, maybe it's better to leave
    rq_lease_breaker out of the common dispatch code?
    
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a59551efd263..4f3964582b68 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4598,7 +4598,8 @@ static bool nfsd_breaker_owns_lease(struct file_lock *fl)
 	if (!i_am_nfsd())
 		return NULL;
 	rqst = kthread_data(current);
-	if (!rqst->rq_lease_breaker)
+	/* Note rq_prog == NFS_ACL_PROGRAM is also possible: */
+	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
 		return NULL;
 	clp = *(rqst->rq_lease_breaker);
 	return dl->dl_stid.sc_client == clp;
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index f7f6473578af..f6bc94cab9da 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1016,7 +1016,6 @@ nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 		*statp = rpc_garbage_args;
 		return 1;
 	}
-	rqstp->rq_lease_breaker = NULL;
 	/*
 	 * Give the xdr decoder a chance to change this if it wants
 	 * (necessary in the NFSv4.0 compound case)
