Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE786240D6B
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Aug 2020 21:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgHJTHb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Aug 2020 15:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgHJTHb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Aug 2020 15:07:31 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21EBC061756
        for <linux-nfs@vger.kernel.org>; Mon, 10 Aug 2020 12:07:30 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1FDF24F41; Mon, 10 Aug 2020 15:07:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1FDF24F41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1597086449;
        bh=Eg9C8mryB9njOOl+555iXOcfaMXyLFOwhlnhnQ7Vlhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gwcaDBnDOck8FSeLW7G2N1a07G93AlyfLLkprDcztq7Ql9ZWa9xH4f6bL0M41Zj26
         /ZUxa+hJsBrN+REoR9vjwn/15dRUjfVHQ/Jc54s7DQqAmF+UU/cKMXA+Dk4IjJrCE0
         YyCAJr5TuLn/pvAQ8z7C8f0h8xhkUiD2f2Ke1s9Y=
Date:   Mon, 10 Aug 2020 15:07:29 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: still seeing single client NFS4ERR_DELAY / CB_RECALL
Message-ID: <20200810190729.GB13266@fieldses.org>
References: <139C6BD7-4052-4510-B966-214ED3E69D61@oracle.com>
 <20200809202739.GA29574@fieldses.org>
 <20200809212531.GB29574@fieldses.org>
 <227E18E8-5A45-47E3-981C-549042AFB391@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <227E18E8-5A45-47E3-981C-549042AFB391@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for the test results:

On Mon, Aug 10, 2020 at 02:21:34PM -0400, Chuck Lever wrote:
> For these results I've switched to sec=sys so the test completes faster.
> 
> NFSv3/sys: 953.37user 5101.96system 14:13.78elapsed 709%CPU (0avgtext+0avgdata 107160maxresident)k
> 
> NFSv4.1/sys: 953.64user 5202.27system 17:54.51elapsed 572%CPU (0avgtext+0avgdata 107204maxresident)k
> 
> NFSv4.0/sys unpatched: 965.44user 5406.75system 36:10.72elapsed 293%CPU (0avgtext+0avgdata 107252maxresident)k
> 
> NFSv4.0/sys with fix: 968.38user 5359.18system 30:50.38elapsed 341%CPU (0avgtext+0avgdata 107140maxresident)k

Well, that didn't work!

So maybe it's write opens that are the problem in this case.  The below
should mostly revert to pre-94415b06eb8a behavior in the 4.0 case, so if
this doesn't fix it then I was wrong about the cause....

--b.

commit 0e94ee0b6f11
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Sun Aug 9 17:11:59 2020 -0400

    nfsd4: don't grant delegations on 4.0 create opens
    
    Chuck reported a major slowdown running the git regression suite over
    NFSv4.0.
    
    In the 4.0 case, the server has no way to identify which client most
    metadata-modifying operations come from.  So, for example, the common
    pattern of an create or write open followed by a setattr is likely to
    result in an immediate break in the 4.0 case.
    
    It's probably not worth giving out delegations on 4.0 write or create
    opens.
    
    Reported-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fdba971d06c3..0d51d1751592 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5096,6 +5096,19 @@ nfs4_open_delegation(struct svc_fh *fh, struct nfsd4_open *open,
 				goto out_no_deleg;
 			if (!cb_up || !(oo->oo_flags & NFS4_OO_CONFIRMED))
 				goto out_no_deleg;
+			if (clp->cl_minorversion)
+				break;
+			/*
+			 * In the absence of sessions, most operations
+			 * that modify metadata (like setattr) can't
+			 * be linked to the client sending them, so
+			 * will result in a delegation break.  That's
+			 * especially likely for write and create opens:
+			 */
+			if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE)
+				goto out_no_deleg;
+			if (open->op_create == NFS4_OPEN_CREATE)
+				goto out_no_deleg;
 			break;
 		default:
 			goto out_no_deleg;
