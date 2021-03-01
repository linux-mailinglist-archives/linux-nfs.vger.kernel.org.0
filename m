Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA88328A6C
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 19:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbhCASR2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 13:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239424AbhCASPp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Mar 2021 13:15:45 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A703C061788
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 10:15:03 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6D34635DC; Mon,  1 Mar 2021 13:15:01 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6D34635DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614622501;
        bh=rjCqC5B/e/3K7IJVmbYnA4z8n9Vw0Lr5RM/YaB743ZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NDn6u2cuKFw2ksMMVn7KYLfDBUy50MwLYHhYeAnNGSIj9DjxqUMb9+oo/2pw3HJv8
         vEuu5fKgkoM++uuag/ZS4b3BdKYVNSVUZbl5XLQ9qKIBuSNmnZbrjgAiEH3gDGRWV3
         wrlD4VPR3xz3yc6XPSxnb1OK9Gov8NAVJoFlGu6Y=
Date:   Mon, 1 Mar 2021 13:15:01 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Daniel Kobras <kobras@puzzle-itc.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: fix refcount leak for rpc auth modules
Message-ID: <20210301181501.GC11772@fieldses.org>
References: <20210226230437.jfgagcq5magzlrtv@tuedko18.puzzle-itc.de>
 <C2704113-2581-4B58-806B-BB65148AC14B@oracle.com>
 <20210301162820.GB11772@fieldses.org>
 <F2DE890D-C2D7-476A-AF6F-949B105728E9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F2DE890D-C2D7-476A-AF6F-949B105728E9@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Mar 01, 2021 at 05:44:02PM +0000, Chuck Lever wrote:
> > So, the effect of this is to call svc_authorise more often.  I think
> > that's always safe, because svc_authorise is a no-op unless rq_authops
> > is set, it clears rq_authops itself, and rq_authops being set is a
> > guarantee that ->accept() already ran.
> > 
> > It's harder to know if this solves the problem, as I see a lot of other
> > mentions of THIS_MODULE in svcauth_gss.c.
> 
> Perhaps a deeper audit is necessary.
> 
> A small code change to inject SVC_CLOSE returns at random would enable
> a more dynamic analysis.

That might be interesting.

I don't think tihs patch necessarily has to wait for that.

> > Possibly orthogonal to this problem, but: svcauth_gss_release
> > unconditionally dereferences rqstp->rq_auth_data.  Isn't that a NULL
> > dereference if the kmalloc at the start of svcauth_gss_accept() fails?
> > 
> > Finally, should we care about module reference leaks?
> 
> I would prefer that module reference counting work as expected. When it
> doesn't that tends to lead to people (say, me) hunting for bugs that
> might actually be serious.
> 
> 
> > Does anyone really *need* to unload modules?
> 
> Anyone who wants to replace the module with a newer build that fixes a
> bug. It avoids a full reboot, and for some that's important.

Fair enough.

--b.
