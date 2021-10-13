Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B3042C591
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 18:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbhJMQBp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 12:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237656AbhJMQBb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Oct 2021 12:01:31 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BF0C06176A;
        Wed, 13 Oct 2021 08:59:27 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 959F36C86; Wed, 13 Oct 2021 11:59:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 959F36C86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1634140766;
        bh=p4uPxexKQ6akinp4b6tqSqBE9oldQcONECcx2xpdsNM=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=gwy09BQf83fy7bO0mjjBUnGGA5Rq5TTua1dD+pZTnwLCqBT0eqkb0+8QBlMTsB5q1
         pGBcx6VfkSpnPALYqm2FkNRnc3olLvI2ukNnHMwOYvD6y6hHZT8HSsmmri9RF8qG8a
         1kPrshVzvgSHZXZCmZlNFd59kdqSll++J3heLbio=
Date:   Wed, 13 Oct 2021 11:59:26 -0400
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 0/6] Deprecate dprintk in svcrdma
Message-ID: <20211013155926.GC6260@fieldses.org>
References: <163413628188.6408.17033105928649076434.stgit@bazille.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163413628188.6408.17033105928649076434.stgit@bazille.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 13, 2021 at 10:46:49AM -0400, Chuck Lever wrote:
> This patch series moves forward with the removal of dprintk in
> SUNRPC in favor of tracepoints. This is the last step for the
> svcrdma component.

Makes sense to me.

I would like some (very short) documentation, somewhere.  Partly just
for my sake!  I'm not sure exactly what to recommend to bug reporters.

I guess 

	trace-cmd record -e 'sunrpc:*
	trace-cmd report

would be a rough substitute for "rpcdebug -m rpc -s all"?

Do we have a couple examples of issues that could be diagnosed with
tracepoints?  In the past I don't feel like I've ended up using dprintks
all that much; somehow they're not usually where I need them.  But maybe
that's just me.  And maybe as we put more thought into where tracepoints
should be, they'll get more useful.

Documentation/filesystems/nfs/, or the linux-nfs wiki, could be easy
places to put it.  Though *something* in the man pages would be nice.
At a minimum, a warning in rpcdebug(8) that we're gradually phasing out
dprintks.

--b.

> 
> ---
> 
> Chuck Lever (6):
>       svcrdma: Remove dprintk() call sites in module handlers
>       svcrdma: Remove dprintk call site in svc_rdma_create_xprt()
>       svcrdma: Remove dprintk call site in svc_rdma_parse_connect_private()
>       svcrdma: Remove dprintk call sites during QP creation
>       svcrdma: Remove dprintk call sites during accept
>       svcrdma: Remove include/linux/sunrpc/debug.h
> 
> 
>  net/sunrpc/xprtrdma/svc_rdma.c           |  9 ------
>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |  1 -
>  net/sunrpc/xprtrdma/svc_rdma_sendto.c    |  1 -
>  net/sunrpc/xprtrdma/svc_rdma_transport.c | 37 ++----------------------
>  4 files changed, 3 insertions(+), 45 deletions(-)
> 
> --
> Chuck Lever
