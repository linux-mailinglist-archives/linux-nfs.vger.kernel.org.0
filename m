Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2FA24002A
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Aug 2020 23:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgHIVZd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Aug 2020 17:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgHIVZc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 Aug 2020 17:25:32 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6906C061756
        for <linux-nfs@vger.kernel.org>; Sun,  9 Aug 2020 14:25:32 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9949E1CE6; Sun,  9 Aug 2020 17:25:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9949E1CE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1597008331;
        bh=PeLynJ9RjXf67msa6wod4M2gpFOf0ChauvrykDvcYwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PhQEAH9U8mpE7kb4IO9OUKj7f49j/DdDvHCCsoID0f5W9zGoR8QBipuWYxV4UNWGm
         n3ADNa74zGoCNy/bS7JDC8CITb3d8N4LnYJuPII2tmIfspfQJ31qNi7V5kWNS60TFM
         LOeADQSfuX02ns6gheGO7UfhbTNIWnAADmNVg1RQ=
Date:   Sun, 9 Aug 2020 17:25:31 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: still seeing single client NFS4ERR_DELAY / CB_RECALL
Message-ID: <20200809212531.GB29574@fieldses.org>
References: <139C6BD7-4052-4510-B966-214ED3E69D61@oracle.com>
 <20200809202739.GA29574@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809202739.GA29574@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Aug 09, 2020 at 04:27:39PM -0400, Bruce Fields wrote:
> On Sun, Aug 09, 2020 at 01:11:36PM -0400, Chuck Lever wrote:
> > Hi Bruce-
> > 
> > I noticed that one of my tests takes about 4x longer on NFSv4.0 than
> > it does on NFSv3 or NFSv4.[12]. As an initial stab at the cause, I'm
> > seeing lots of these:
> 
> Oops, looks obvious in retrospect, but I didn't think of it.
> 
> In the 4.1+ case, sessions mean that we know which client every
> operation comes from.
> 
> In the 4.0 case that only works for operations that take a stateid or
> something else we can link back to a client.
> 
> That means in the 4.0 case delegations are less useful, since they have
> to be broken on any (non-truncating) setattr, any link/unlink, etc.,
> even if the operation comes from the same client--the server doesn't
> have a way to know that.
> 
> Maybe the change to give out read delegations even on write opens
> probably just isn't worth in the 4.0 case.

Untested, but maybe this?--b.

commit 2102ac0b68f3
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Sun Aug 9 17:11:59 2020 -0400

    nfsd4: don't grant delegations on 4.0 create opens
    
    Chuck reported a major slowdown running the git regression suite over
    NFSv4.0.
    
    In the 4.0 case, the server has no way to identify which client most
    metadata-modifying operations come from.  So, for example, the common
    pattern of a a setattr is likely to result in an immediate break in the
    4.0 case.
    
    It's probably not worth giving out delegations on 4.0 creates.
    
    Reported-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fdba971d06c3..ce2d052b3f64 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5096,6 +5096,16 @@ nfs4_open_delegation(struct svc_fh *fh, struct nfsd4_open *open,
 				goto out_no_deleg;
 			if (!cb_up || !(oo->oo_flags & NFS4_OO_CONFIRMED))
 				goto out_no_deleg;
+			/*
+			 * In the absence of sessions, most operations
+			 * that modify metadata (like setattr) can't
+			 * be linked to the client sending them, so
+			 * will result in a delegation break.  That's
+			 * especially likely for create opens:
+			 */
+			if (clp->cl_minorversion == 0 &&
+					open->op_create == NFS4_OPEN_CREATE)
+				goto out_no_deleg;
 			break;
 		default:
 			goto out_no_deleg;
