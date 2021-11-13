Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8D544F579
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Nov 2021 22:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbhKMV2j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 Nov 2021 16:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbhKMV2i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 13 Nov 2021 16:28:38 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C376EC061766
        for <linux-nfs@vger.kernel.org>; Sat, 13 Nov 2021 13:25:45 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1AD8F6F33; Sat, 13 Nov 2021 16:25:44 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1AD8F6F33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1636838744;
        bh=wZRl3vY7hJp6kEv5kekQdAGT63lPvlHgphM6GapBwcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OYoeJKSML9xtMLlWrXMZrf9fiAv0nYMNY4n7SwbsLx1cRk9leE26jwyT9nCtrZtIs
         S8qctf0RskSQ3ON93b3Cdc0JwXLqpCf7dcMG+ZW36edPOXq/6qpzF1jWOrDBxL6YNg
         1b8P91/eB7C0qbmi7J7qqPFt0CYku/L+e5zXcilc=
Date:   Sat, 13 Nov 2021 16:25:44 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "rtm@csail.mit.edu" <rtm@csail.mit.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS client can crash server due to overrun in
 nfsd4_decode_bitmap4()
Message-ID: <20211113212544.GA27601@fieldses.org>
References: <97860.1636837122@crash.local>
 <11B4530A-C0A0-4779-A9BA-F0E19B62C5A6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11B4530A-C0A0-4779-A9BA-F0E19B62C5A6@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Nov 13, 2021 at 09:06:03PM +0000, Chuck Lever III wrote:
> 
> > On Nov 13, 2021, at 3:58 PM, rtm@csail.mit.edu wrote:
> > 
> > nfsd4_decode_bitmap4() will write beyond bmval[bmlen-1] if the RPC
> > directs it to do so. This can cause nfsd4_decode_state_protect4_a() to
> > write client-supplied data beyond the end of
> > nfsd4_exchange_id.spo_must_allow[] when called by
> > nfsd4_decode_exchange_id().
> 
> Thanks, I'll look into addressing this for v5.16-rc.
> 
> By the way, can you tell if this exposure was in the code
> before 2548aa784d76 ("NFSD: Add a separate decoder to handle
> state_protect_ops") ? (ie, do we need a separate fix for
> this for pre-5.11 NFSD -- I'm guessing no).

It may not have been an EXCHANGE_ID problem, but:

> Is the current implementation of nfsd4_decode_bitmap() a
> problem for its other consumers?

Yeah, I don't see that there's anything a caller could do that would
prevent it, so the problem starts with the introduction of
nfsd4_decode_bitmap4.

Not actually tested, but I suppose we want the following.

--b.

commit 8211c4817cc0
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Sat Nov 13 16:11:58 2021 -0500

    nfsd: fix overrun in nfsd4_decode_bitmap4
    
    rtm says: "nfsd4_decode_bitmap4() will write beyond bmval[bmlen-1] if
    the RPC directs it to do so. This can cause
    nfsd4_decode_state_protect4_a() to write client-supplied data beyond the
    end of nfsd4_exchange_id.spo_must_allow[] when called by
    nfsd4_decode_exchange_id()."
    
    Reported-by: <rtm@csail.mit.edu>
    Cc: stable@vger.kernel.org
    Fixes: d1c263a031e8 "NFSD: Replace READ* macros in nfsd4_decode_fattr()"
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9b609aac47e1..7aa97c09b5a9 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -282,8 +282,7 @@ nfsd4_decode_bitmap4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen)
 
 	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
 		return nfserr_bad_xdr;
-	/* request sanity */
-	if (count > 1000)
+	if (count > bmlen)
 		return nfserr_bad_xdr;
 	p = xdr_inline_decode(argp->xdr, count << 2);
 	if (!p)
