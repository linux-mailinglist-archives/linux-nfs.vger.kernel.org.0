Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10E2424059
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Oct 2021 16:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbhJFOsi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Oct 2021 10:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhJFOsi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Oct 2021 10:48:38 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF181C061749
        for <linux-nfs@vger.kernel.org>; Wed,  6 Oct 2021 07:46:45 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 4BE02703F; Wed,  6 Oct 2021 10:46:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 4BE02703F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1633531605;
        bh=elalU8AnPHAif8h0i3/TwTZFw8RzuZYbaHtXhUET0Vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GsZil5tCj9DtsV9oz8cCvrznJEbG2zS0ZwBmSnsbwD9D8qqYbTpci9IL+sB3Pr4ia
         2HSb1oJpgiduPfhcG7hgcgMjWDwEDsyUtqc51QMwsJVEGvJQxewMFC7hP/TO2vD0cU
         kaBB/8uHKKxa7dq4qh+S2HlIt/LN0mBZwDTwf2I8=
Date:   Wed, 6 Oct 2021 10:46:45 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: Keep existing listners on portlist error
Message-ID: <20211006144645.GB15343@fieldses.org>
References: <45b916f1aa3fb7c059a574f61188a8f2f615410e.1633529847.git.bcodding@redhat.com>
 <20211006143335.GA15343@fieldses.org>
 <053E93B5-0DFB-4A20-9742-F3894E2BE224@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <053E93B5-0DFB-4A20-9742-F3894E2BE224@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 06, 2021 at 10:43:14AM -0400, Benjamin Coddington wrote:
> On 6 Oct 2021, at 10:33, J. Bruce Fields wrote:
> 
> >On Wed, Oct 06, 2021 at 10:18:05AM -0400, Benjamin Coddington wrote:
> >>If nfsd has existing listening sockets without any processes,
> >>then an error
> >>returned from svc_create_xprt() for an additional transport will
> >>remove
> >>those existing listeners.  We're seeing this in practice when
> >>userspace
> >>attempts to create rpcrdma transports without having the rpcrdma
> >>modules
> >>present before creating nfsd kernel processes.  Fix this by
> >>checking for
> >>existing sockets before callingn nfsd_destroy().
> >
> >That seems like an improvement.
> >
> >I'm curious, though, what the rpc.nfsd behavior is on partial failure.
> >And what do we want it to be?
> >
> >If a user runs rpc.nfsd expecting it to start up tcp and rdma, but
> >rdma
> >fails, do we want rpc.nfsd to succeed or fail?  Should it exit
> >with nfsd
> >running or not?
> 
> I lean toward having it fail - but I think that's a different patch for
> rpc.nfsd.  Right now rpc.nfsd exists without error, but you end up
> without
> any listeners at all.
> 
> Do you want a patch for rpc.nfsd instead?

I think we need the kernel fix.  I agree that it's weird to shut down
the server on a failure to add a listener--better to leave usrespace to
decide if it wants to do that.

--b.
