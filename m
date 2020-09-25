Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C870278AB3
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 16:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgIYORT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 10:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbgIYORR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 10:17:17 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63713C0613CE
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 07:17:17 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9B1A714DC; Fri, 25 Sep 2020 10:17:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9B1A714DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1601043436;
        bh=azoQudSmNd81rGe6Z3wSd0GwPjnL8o+ANmODzFBoqgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qj1KsOIirbSuhjmPMPo2L5l9uFZFbTB2uSpW5bEa60OH4NRGqBpMyk1oR1WLdCsM1
         HRXi4fT1pRaUjJB4vXEDYk1F3Esoay22Nw44Spl7apcrIc+po2q9WbQzzIX433S6pq
         fnrE0/U4UUKSuZ/BqzZO3yohA30uKLvkFesPUPRE=
Date:   Fri, 25 Sep 2020 10:17:16 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bill Baker <Bill.Baker@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 26/27] NFSD: Add tracepoints in the NFS dispatcher
Message-ID: <20200925141716.GC1096@fieldses.org>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
 <160071198717.1468.14262284967190973528.stgit@klimt.1015granger.net>
 <20200924234526.GB12407@fieldses.org>
 <801F3A94-4668-4DF6-9CAF-27171EEBA17A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <801F3A94-4668-4DF6-9CAF-27171EEBA17A@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 25, 2020 at 09:59:54AM -0400, Chuck Lever wrote:
> 
> 
> > On Sep 24, 2020, at 7:45 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Mon, Sep 21, 2020 at 02:13:07PM -0400, Chuck Lever wrote:
> >> This is follow-on work to the tracepoints added in the NFS server's
> >> duplicate reply cache. Here, tracepoints are introduced that report
> >> replies from cache as well as encoding and decoding errors.
> >> 
> >> The NFSv2, v3, and v4 dispatcher requirements have diverged over
> >> time, leaving us with a little bit of technical debt. In addition,
> >> I wanted to add a tracepoint for NFSv2 and NFSv3 similar to the
> >> nfsd4_compound/compoundstatus tracepoints. Lastly, removing some
> >> conditional branches from this hot path helps optimize CPU
> >> utilization. So, I've duplicated the nfsd_dispatcher function.
> > 
> > Comparing current nfsd_dispatch to the nfsv2/v3 nfsd_dispatch: the only
> > thing I spotted removed from the v2/v3-specific dispatch is the
> > rq_lease_breaker = NULL.  (I think that's not correct, actually.  We
> > could remove the need for that to be set in the v2/v3 case, but with the
> > current code it does need to be set.)
> 
> Noted with thanks.

Maybe just do this?

--b.

commit c7265a111269
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Fri Sep 25 10:12:39 2020 -0400

    nfsd: rq_lease_breaker cleanup
    
    Since only the v4 code cares about it, maybe it's better to leave
    rq_lease_breaker out of the common dispatch code?
    
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 62afcae18e17..a498278ba96b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4597,6 +4597,9 @@ static bool nfsd_breaker_owns_lease(struct file_lock *fl)
 
 	if (!i_am_nfsd())
 		return NULL;
+	/* Note rq_prog == NFS_ACL_PROGRAM is also possible: */
+	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
+		return NULL;
 	rqst = kthread_data(current);
 	clp = *(rqst->rq_lease_breaker);
 	return dl->dl_stid.sc_client == clp;
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index b603dfcdd361..8d6f6f4c8b28 100644
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
