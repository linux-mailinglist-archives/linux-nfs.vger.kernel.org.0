Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32165311336
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Feb 2021 22:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhBEVOw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Feb 2021 16:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbhBEVOd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Feb 2021 16:14:33 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DC2C06174A
        for <linux-nfs@vger.kernel.org>; Fri,  5 Feb 2021 13:13:52 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 0AA4C14D4; Fri,  5 Feb 2021 16:13:51 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 0AA4C14D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1612559631;
        bh=XGZLOAkvciIpfu/nSYSfEQWp+WXnvr/pic1GWFUyw/E=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=XcDiY3an1jSVg6HGO4ory7L2v45XAh7c0V6s49RJqds9iuaSldlWf0vZspxyaksAJ
         uvnnEHR5R2s75h7yTHOckMBr9dp9cC78IrZ01+cMZ1S82/VPIDSWQ9T1anuj5D5aRp
         GjB4FaixczOEHKIG0Uq6v3IEfBXLwgtMReIAKnzA=
Date:   Fri, 5 Feb 2021 16:13:51 -0500
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: releasing result pages in svc_xprt_release()
Message-ID: <20210205211351.GC32030@fieldses.org>
References: <811BE98B-F196-4EC1-899F-6B62F313640C@oracle.com>
 <87im7ffjp0.fsf@notabene.neil.brown.name>
 <597824E7-3942-4F11-958F-A6E247330A9E@oracle.com>
 <878s88fz6s.fsf@notabene.neil.brown.name>
 <700333BB-0928-4772-ADFB-77D92CCE169C@oracle.com>
 <87wnvre5cy.fsf@notabene.neil.brown.name>
 <9FC8FB98-2DD7-4B78-BD72-918F91FA11D9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9FC8FB98-2DD7-4B78-BD72-918F91FA11D9@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Feb 05, 2021 at 08:20:28PM +0000, Chuck Lever wrote:
> Baby steps.
> 
> Because I'm perverse I started with bulk page freeing. In the course
> of trying to invent a new API, I discovered there already is a batch
> free_page() function called release_pages().
> 
> It seems to work as advertised for pages that are truly no longer
> in use (ie RPC/RDMA pages) but not for pages that are still in flight
> but released (ie TCP pages).
> 
> release_pages() chains the pages in the passed-in array onto a list
> by their page->lru fields. This seems to be a problem if a page
> is still in use.

I thought I remembered reading an lwn article about bulk page
allocation.  Looking around now all I can see is

	https://lwn.net/Articles/684616/
	https://lwn.net/Articles/711075/

and I can't tell if any of that work was ever finished.

--b.
