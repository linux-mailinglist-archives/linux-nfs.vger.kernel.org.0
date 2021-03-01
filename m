Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1088A32846D
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 17:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbhCAQfX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 11:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbhCAQ3L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Mar 2021 11:29:11 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A18C06178A
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 08:28:28 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6EDD325FE; Mon,  1 Mar 2021 11:28:20 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6EDD325FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614616100;
        bh=ymVMq/eXAVbkZeEY+nrCAwW7Zx5tBeFoXvrYV9FBuno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s4s13Igg/8XcARRXWb11mZI6Jw/IDMUbbKMoGqF6/lG4zhZpT0gVbHRZm9aN6Sfpy
         54vPvnYA0CHfaS+XqOXZS08lxKUhVec0OD8d6JE7jncC+SLsYkKlpFMhy41TvpbTQU
         mgw70x73EycixkH+A4rfUfSm2KGDrxLFGuoJkxYw=
Date:   Mon, 1 Mar 2021 11:28:20 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Daniel Kobras <kobras@puzzle-itc.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: fix refcount leak for rpc auth modules
Message-ID: <20210301162820.GB11772@fieldses.org>
References: <20210226230437.jfgagcq5magzlrtv@tuedko18.puzzle-itc.de>
 <C2704113-2581-4B58-806B-BB65148AC14B@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C2704113-2581-4B58-806B-BB65148AC14B@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Mar 01, 2021 at 03:20:24PM +0000, Chuck Lever wrote:
> 
> > On Feb 26, 2021, at 6:04 PM, Daniel Kobras <kobras@puzzle-itc.de> wrote:
> > 
> > If an auth module's accept op returns SVC_CLOSE, svc_process_common()
> > enters a call path that does not call svc_authorise() before leaving the
> > function, and thus leaks a reference on the auth module's refcount. Hence,
> > make sure calls to svc_authenticate() and svc_authorise() are paired for
> > all call paths, to make sure rpc auth modules can be unloaded.
> > 
> > Fixes: 4d712ef1db05 ("svcauth_gss: Close connection when dropping an incoming message")
> > Signed-off-by: Daniel Kobras <kobras@puzzle-itc.de>
> > ---
> > Hi!
> > 
> > While debugging NFS on a system with misconfigured krb5 settings, we noticed
> > a suspiciously high refcount on the auth_rpcgss module, despite all of its
> > consumers already unloaded. I wasn't able to analyze any further on the live
> > system, but had a look at the code afterwards, and found a path that seems
> > to leak references if the mechanism's accept() op shuts down a connection
> > early. Although I couldn't verify, this seem to be a plausible fix.
> > 
> > Kind regards,
> > 
> > Daniel
> 
> Hi Daniel-
> 
> I've provisionally included your patch in my NFSD for-rc topic branch
> here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> 
> Your bug report seems plausible, but I need to take a closer look at that
> code and your proposed change. Would very much like to hear from others,
> too.

So, the effect of this is to call svc_authorise more often.  I think
that's always safe, because svc_authorise is a no-op unless rq_authops
is set, it clears rq_authops itself, and rq_authops being set is a
guarantee that ->accept() already ran.

It's harder to know if this solves the problem, as I see a lot of other
mentions of THIS_MODULE in svcauth_gss.c.

Possibly orthogonal to this problem, but: svcauth_gss_release
unconditionally dereferences rqstp->rq_auth_data.  Isn't that a NULL
dereference if the kmalloc at the start of svcauth_gss_accept() fails?

Finally, should we care about module reference leaks?  Does anyone
really *need* to unload modules?  And will bad stuff happen when the
count overflows, or does the module code fail safely somehow in the
overflow case?  I know, bugs are bugs, I should care about fixing all of
them, shame on me....

--b.

> 
> 
> > net/sunrpc/svc.c | 6 ++++--
> > 1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index 61fb8a18552c..d76dc9d95d16 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -1413,7 +1413,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
> > 
> >  sendit:
> > 	if (svc_authorise(rqstp))
> > -		goto close;
> > +		goto close_xprt;
> > 	return 1;		/* Caller can now send it */
> > 
> > release_dropit:
> > @@ -1425,6 +1425,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
> > 	return 0;
> > 
> >  close:
> > +	svc_authorise(rqstp);
> > +close_xprt:
> > 	if (rqstp->rq_xprt && test_bit(XPT_TEMP, &rqstp->rq_xprt->xpt_flags))
> > 		svc_close_xprt(rqstp->rq_xprt);
> > 	dprintk("svc: svc_process close\n");
> > @@ -1433,7 +1435,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
> > err_short_len:
> > 	svc_printk(rqstp, "short len %zd, dropping request\n",
> > 			argv->iov_len);
> > -	goto close;
> > +	goto close_xprt;
> > 
> > err_bad_rpc:
> > 	serv->sv_stats->rpcbadfmt++;
> > -- 
> > 2.25.1
> > 
> > 
> > -- 
> > Puzzle ITC Deutschland GmbH
> > Sitz der Gesellschaft: Eisenbahnstraße 1, 72072 
> > Tübingen
> > 
> > Eingetragen am Amtsgericht Stuttgart HRB 765802
> > Geschäftsführer: 
> > Lukas Kallies, Daniel Kobras, Mark Pröhl
> > 
> 
> --
> Chuck Lever
> 
> 
> 
