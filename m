Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A6A42191D
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Oct 2021 23:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbhJDVUT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Oct 2021 17:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbhJDVUR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Oct 2021 17:20:17 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66439C061745;
        Mon,  4 Oct 2021 14:18:28 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 4ED5A703F; Mon,  4 Oct 2021 17:18:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 4ED5A703F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1633382307;
        bh=JwdQJWo6iRs28qW+1inkAkmsc/S+m3258rLKggA1QY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pVIJrQXBCPZVVhlx1TfaWkmtp/KdbINW1At6qLwWoEWZjoEaXY+iR/D6+rZwSVI+6
         N8M39yd3L9qRyqCmoZe//DrXFLdxyuK6oy++7dTlut8WGDl482jx6VOA+VD2XKgb8s
         4M+FT7kgAy7GvdcTeS0m4F1TDjFglF27kb/iEJ5I=
Date:   Mon, 4 Oct 2021 17:18:27 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/5] Resend: tracepoint patches for NFSD
Message-ID: <20211004211827.GB31669@fieldses.org>
References: <163335690747.3921.13072315880207206379.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163335690747.3921.13072315880207206379.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 04, 2021 at 10:16:02AM -0400, Chuck Lever wrote:
> I posted these on 9/22 and have heard no objections. Can you include
> them in your v5.16 for-next branch?

Looks good, applied.--b.

> 
> ---
> 
> Chuck Lever (5):
>       svcrdma: Split the svcrdma_wc_receive() tracepoint
>       svcrdma: Split the svcrdma_wc_send() tracepoint
>       svcrdma: Split svcrmda_wc_{read,write} tracepoints
>       SUNRPC: Add trace event when alloc_pages_bulk() makes no progress
>       SUNRPC: Capture value of xdr_buf::page_base
> 
> 
>  include/trace/events/rpcrdma.h          | 185 +++++++++++++++++++++++-
>  include/trace/events/sunrpc.h           |  38 ++++-
>  net/sunrpc/svc_xprt.c                   |   1 +
>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   9 +-
>  net/sunrpc/xprtrdma/svc_rdma_rw.c       |  30 +++-
>  net/sunrpc/xprtrdma/svc_rdma_sendto.c   |  14 +-
>  6 files changed, 258 insertions(+), 19 deletions(-)
> 
> --
> Chuck Lever
