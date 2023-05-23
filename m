Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5740670DDEF
	for <lists+linux-nfs@lfdr.de>; Tue, 23 May 2023 15:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbjEWNu3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 May 2023 09:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbjEWNu2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 May 2023 09:50:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5016121;
        Tue, 23 May 2023 06:50:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51FD762C14;
        Tue, 23 May 2023 13:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7E5C433EF;
        Tue, 23 May 2023 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684849825;
        bh=TssHSLUZY2PWvwpGU4FPKnhXWL/err8f/M7euIDAMA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oEKADboVmN6CU3ba1iJC2wD24oTgBLfw2gByCCJolryjj4bA0fEyrliU9cVppl/kA
         g/nvDkXS+Y/CRMiQaIi/FY2judblTOXtXbw7WAg8V0p9uPG8OsOrqvuwQ+TISRhZrM
         ELKAdndDXAytyKM8ny5JJOla5LtO+8qlT0ry3VPTxnwbzPMyxcApuIbjsjDFhcGNLY
         mohK04uDSiWxvqwnT6FTJadEbUuFIj2nQm3cOo1m7lcneqjIthcysOOK4hlJT/1Jsj
         65KafXhf/aV59XJVlFEzfJYziRLD5xxnPl7gvz6oBRENUmccZbrMfcsvBCbyfdKlX6
         Nq0T/jzBjoowA==
Date:   Tue, 23 May 2023 09:50:23 -0400
From:   Chuck Lever <cel@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>,
        Zhi Li <yieli@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: make a copy of struct iattr before calling
 notify_change
Message-ID: <ZGzEn8RdnUCDsY0t@manet.1015granger.net>
References: <20230517162645.254512-1-jlayton@kernel.org>
 <168472353748.5298.2381558773846767023@noble.neil.brown.name>
 <d07a0957040ebc3b5689f524e9d3c04cd166c42b.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d07a0957040ebc3b5689f524e9d3c04cd166c42b.camel@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 23, 2023 at 09:41:14AM -0400, Jeff Layton wrote:
> On Mon, 2023-05-22 at 12:45 +1000, NeilBrown wrote:
> > On Thu, 18 May 2023, Jeff Layton wrote:
> > > notify_change can modify the iattr structure. In particular it can can
> > > end up setting ATTR_MODE when ATTR_KILL_SUID is already set, causing a
> > > BUG() if the same iattr is passed to notify_change more than once.
> > > 
> > > Make a copy of the struct iattr before calling notify_change.
> > > 
> > > Fixes: 34b91dda7124 NFSD: Make nfsd4_setattr() wait before returning NFS4ERR_DELAY
> > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=2207969
> > > Reported-by: Zhi Li <yieli@redhat.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfsd/vfs.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > index c4ef24c5ffd0..ad0c5cd900b1 100644
> > > --- a/fs/nfsd/vfs.c
> > > +++ b/fs/nfsd/vfs.c
> > > @@ -538,7 +538,9 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > >  
> > >  	inode_lock(inode);
> > >  	for (retries = 1;;) {
> > > -		host_err = __nfsd_setattr(dentry, iap);
> > > +		struct iattr attrs = *iap;
> > > +
> > > +		host_err = __nfsd_setattr(dentry, &attrs);
> > 
> > I think this needs something to ensure a well meaning by-passer doesn't
> > try to "optimise" it back to the way it was.
> > Maybe make "iap" const?  Or add a comment?  Or both?
> > 
> 
> We can't make iap const, as we have to call nfsd_sanitize_attrs on it,
> and that will change things in it. I think we'll probably have to settle
> for a comment. Chuck, can we fold the patch below in to this one?

Done, and pushed to nfsd-fixes.


> --------------------8<------------------
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 2a3687cdf926..817effd63730 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -538,6 +538,11 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	for (retries = 1;;) {
>  		struct iattr attrs;
>  
> +		/*
> +		 * notify_change can alter the iattr in ways that make it
> +		 * unsuitable for submission multiple times. Make a copy
> +		 * for every loop.
> +		 */
>  		attrs = *iap;
>  		host_err = __nfsd_setattr(dentry, &attrs);
>  		if (host_err != -EAGAIN || !retries--)
> 
