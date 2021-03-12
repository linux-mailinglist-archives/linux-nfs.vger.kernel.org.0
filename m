Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D87339156
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Mar 2021 16:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhCLPdS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Mar 2021 10:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhCLPc7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Mar 2021 10:32:59 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FABC061574
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 07:32:58 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1D91025FE; Fri, 12 Mar 2021 10:32:57 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1D91025FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1615563177;
        bh=RWDh1DWb4mYh7To2VZfVF4XABo/kcvm07teheztr2iI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xfeE6R0MizMvkWZYycZdBiqoEZ7f3Bqx9lzAPmS1+NpIaJL+3GCE9r7PW6jC1L4/z
         LFTUCTVGFocHun/ijajqGQuU96Ysa8K6tK35BW+rC/ig09/E2XZ70gyxmEMepb9yGW
         irpxfHtsqEVFdWKw/LjnSoQqYnD6BQdO0PTbOLOk=
Date:   Fri, 12 Mar 2021 10:32:57 -0500
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Demote UMH upcall init message from warning- to
 info-level
Message-ID: <20210312153257.GC24008@fieldses.org>
References: <20210312112840.49517-1-pmenzel@molgen.mpg.de>
 <acd50b86-a200-34bf-5768-e5bb93b2278f@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd50b86-a200-34bf-5768-e5bb93b2278f@molgen.mpg.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Mar 12, 2021 at 12:33:00PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Am 12.03.21 um 12:28 schrieb Paul Menzel:
> >By default, using `printk()`, Linux logs messages with level warning,
> >which leaves the user seeing
> >
> >     NFSD: Using UMH upcall client tracking operations.
> >
> >what to do about it. Reading `nfsd4_umh_cltrack_init()`, the message is
> >actually logged on success, so nothing needs to be done, and the info
> >level should be used.
> >
> >Cc: linux-nfs@vger.kernel.org
> >Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> >---
> >  fs/nfsd/nfs4recover.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> >index 891395c6c7d3..db66c45a6b97 100644
> >--- a/fs/nfsd/nfs4recover.c
> >+++ b/fs/nfsd/nfs4recover.c
> >@@ -1864,7 +1864,7 @@ nfsd4_umh_cltrack_init(struct net *net)
> >  	ret = nfsd4_umh_cltrack_upcall("init", NULL, grace_start, NULL);
> >  	kfree(grace_start);
> >  	if (!ret)
> >-		printk("NFSD: Using UMH upcall client tracking operations.\n");
> >+		pr_info("NFSD: Using UMH upcall client tracking operations.\n");
> >  	return ret;
> >  }
> 
> A debug-level message could also be used, or the line totally
> removed, and the condition be changed to print an error in case of
> failure. I am wondering about the benefit for the user reading
> through the logs. Maybe the log was only there, because UMH upcall
> client tracking operations were something new?

Could be.

I think debug-level would be fine.

--b.
