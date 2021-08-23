Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F0F3F4F6A
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Aug 2021 19:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhHWRWB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Aug 2021 13:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhHWRWB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Aug 2021 13:22:01 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99362C061575
        for <linux-nfs@vger.kernel.org>; Mon, 23 Aug 2021 10:21:18 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 893216855; Mon, 23 Aug 2021 13:21:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 893216855
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1629739277;
        bh=EvzQ2xH2UkWtriOKtoxdzlGACD6GuJWgeF++xfQpZOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XBWAdovDe+aygMNsPzxw9sA5hgPD0oY13tIGnCZAbC03EgAuoacltbtUueHF180Gn
         gIpNc/JWK/eY8HTDisS5dIFYfI8PQ+aQ9XAs/rncXrsxE15IM2jNa20bKTOKb/ZbHd
         9iPHXNKIzdgHpPvDEY8pam2r5t9kbiXwqLCYDpQY=
Date:   Mon, 23 Aug 2021 13:21:17 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        "daire@dneg.com" <daire@dneg.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/8] nlm: minor nlm_lookup_file argument change
Message-ID: <20210823172117.GF883@fieldses.org>
References: <1629493326-28336-1-git-send-email-bfields@redhat.com>
 <1629493326-28336-3-git-send-email-bfields@redhat.com>
 <77E5AE14-04E1-4C54-BC3C-192FADAF7B96@oracle.com>
 <20210823160118.GD883@fieldses.org>
 <5375D339-E402-41E6-9EC7-0E3FFFD34D1A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5375D339-E402-41E6-9EC7-0E3FFFD34D1A@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 23, 2021 at 05:02:19PM +0000, Chuck Lever III wrote:
> 
> 
> > On Aug 23, 2021, at 12:01 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > Subject: [PATCH] nlm: minor style issue
> > 
> > Make the assignment separate.
> > 
> > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > ---
> > fs/lockd/svc4proc.c | 3 ++-
> > fs/lockd/svcsubs.c  | 3 ++-
> > 2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> >> Style: Replace the "assignment in if statement" in these spots,
> >> bitte?
> > 
> > Feel free to fold this in if you'd prefer.--b.
> 
> Squashed. However, this change conflicts with 5/8. I've fixed
> that up in my tree.

Thanks.

> There are still several outstanding inline comments for 5/8,
> in case you missed those.

Whoops, I did.  Looking....--b.

> 
> 
> > diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> > index aa8eca7c38a1..bc496bbd696b 100644
> > --- a/fs/lockd/svc4proc.c
> > +++ b/fs/lockd/svc4proc.c
> > @@ -40,7 +40,8 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
> > 
> > 	/* Obtain file pointer. Not used by FREE_ALL call. */
> > 	if (filp != NULL) {
> > -		if ((error = nlm_lookup_file(rqstp, &file, lock)) != 0)
> > +		error = nlm_lookup_file(rqstp, &file, lock);
> > +		if (error)
> > 			goto no_locks;
> > 		*filp = file;
> > 
> > diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> > index bbd2bdde4bea..2d62633b39e5 100644
> > --- a/fs/lockd/svcsubs.c
> > +++ b/fs/lockd/svcsubs.c
> > @@ -117,7 +117,8 @@ nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
> > 	 * We have to make sure we have the right credential to open
> > 	 * the file.
> > 	 */
> > -	if ((nfserr = nlmsvc_ops->fopen(rqstp, &lock->fh, &file->f_file)) != 0) {
> > +	nfserr = nlmsvc_ops->fopen(rqstp, &lock->fh, &file->f_file);
> > +	if (nfserr) {
> > 		dprintk("lockd: open failed (error %d)\n", nfserr);
> > 		goto out_free;
> > 	}
> > -- 
> > 2.31.1
> > 
> 
> --
> Chuck Lever
> 
> 
