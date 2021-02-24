Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0883244F8
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Feb 2021 21:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbhBXUJu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Feb 2021 15:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbhBXUJa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Feb 2021 15:09:30 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B93C06174A
        for <linux-nfs@vger.kernel.org>; Wed, 24 Feb 2021 12:08:50 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9EB392501; Wed, 24 Feb 2021 15:08:49 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9EB392501
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614197329;
        bh=yIgcTKyxFzWkd8wGIb7MZWb3mhrfjklWinB06ykAfRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vpcJbMNMO13VYvClEj4VDGXoGUElWEqjayeaJJKk6r9LI4OHcOyHV1WXkdnP3Tkd0
         XLEf3Lz6mD2suSAGuDt7BmAXKNpm3MjgZLfKssqrUClcQIvWnBszJhX9G8wMpo0C84
         FPuCHJlsR7SpUcTdlfX0dMGsUu2UH3LcCbsV8vQM=
Date:   Wed, 24 Feb 2021 15:08:49 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Timo Rothenpieler <timo@rothenpieler.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [PATCH] svcrdma: disable timeouts on rdma backchannel
Message-ID: <20210224200849.GE11591@fieldses.org>
References: <C99EA5DE-814A-418B-9685-D400F4E7B964@oracle.com>
 <20210222233619.21568-1-timo@rothenpieler.org>
 <E650E8DD-9F65-4029-8F3B-AA854AF575A1@oracle.com>
 <20210224200231.GD11591@fieldses.org>
 <D208366F-8FB7-48C9-A380-5518AA845B6C@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D208366F-8FB7-48C9-A380-5518AA845B6C@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 24, 2021 at 08:03:54PM +0000, Chuck Lever wrote:
> 
> 
> > On Feb 24, 2021, at 3:02 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Wed, Feb 24, 2021 at 02:18:18PM +0000, Chuck Lever wrote:
> >> 
> >> 
> >>> On Feb 22, 2021, at 6:36 PM, Timo Rothenpieler <timo@rothenpieler.org> wrote:
> >>> 
> >>> This brings it in line with the regular tcp backchannel, which also has
> >>> all those timeouts disabled.
> >>> 
> >>> Prevents the backchannel from timing out, getting some async operations
> >>> like server side copying getting stuck indefinitely on the client side.
> >>> 
> >>> Signed-off-by: Timo Rothenpieler <timo@rothenpieler.org>
> >> 
> >> Thanks for your patch! I've included it in the for-rc branch at
> >> 
> >> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> > 
> > So, I'm sure this patch makes sense.
> > 
> > But I'm also curious why it's not recovering.
> 
> Agreed. This patch is not a substitute for proper callback channel recovery.
> 
> 
> > What I think should happen:
> > 
> > 	- clp->cl_cb_state should be set to NFSD4_CB_DOWN.
> 
> I think it's set to FAULT.

OK.  The result should be similar in that case, but SEQUENCE gets the
SEQ4_STATUS_BACKCHANNEL_FAULT flag set instead.

--b.

> 
> 
> > 	- This should cause the next SEQUENCE reply to have
> > 	  SEQ4_STATUS_CB_PATH_DOWN set.
> > 	- That should poke the client to recover.  (Maybe by sending a
> > 	  BIND_CONN_TO_SESSION call?)
> > 
> > I'd be curious whether any of that's actually happening.
> > 
> > --b.
> > 
> >> 
> >> 
> >>> ---
> >>> Did the same testing with this applied than before, and could not
> >>> observe it getting stuck, same as with the previous patch, which I
> >>> removed before testing this one.
> >>> 
> >>> This obviously still does not fix the issue of it being seemingly unable
> >>> to reestablish the disconnected backchannel.
> >>> An event that disconnects the backchannel but leaves the main connection
> >>> intact seems a pretty rare occurance though, outside of this issue.
> >>> 
> >>> net/sunrpc/xprtrdma/svc_rdma_backchannel.c | 6 +++---
> >>> 1 file changed, 3 insertions(+), 3 deletions(-)
> >>> 
> >>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
> >>> index 63f8be974df2..8186ab6f99f1 100644
> >>> --- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
> >>> +++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
> >>> @@ -252,9 +252,9 @@ xprt_setup_rdma_bc(struct xprt_create *args)
> >>> 	xprt->timeout = &xprt_rdma_bc_timeout;
> >>> 	xprt_set_bound(xprt);
> >>> 	xprt_set_connected(xprt);
> >>> -	xprt->bind_timeout = RPCRDMA_BIND_TO;
> >>> -	xprt->reestablish_timeout = RPCRDMA_INIT_REEST_TO;
> >>> -	xprt->idle_timeout = RPCRDMA_IDLE_DISC_TO;
> >>> +	xprt->bind_timeout = 0;
> >>> +	xprt->reestablish_timeout = 0;
> >>> +	xprt->idle_timeout = 0;
> >>> 
> >>> 	xprt->prot = XPRT_TRANSPORT_BC_RDMA;
> >>> 	xprt->ops = &xprt_rdma_bc_procs;
> >>> -- 
> >>> 2.25.1
> >>> 
> >> 
> >> --
> >> Chuck Lever
> 
> --
> Chuck Lever
> 
> 
