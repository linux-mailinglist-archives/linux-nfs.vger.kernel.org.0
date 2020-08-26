Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F9F2538EA
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Aug 2020 22:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgHZUJL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Aug 2020 16:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZUJK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Aug 2020 16:09:10 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE36C061574;
        Wed, 26 Aug 2020 13:09:07 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C39266EEB; Wed, 26 Aug 2020 16:09:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C39266EEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1598472541;
        bh=bOOt3zm1gFKfZCQYnWvAjCoBU/NfeqJ2yjHfacdjZAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IungCNGpsTp02s8WmHcduBXrVPdjq5S95KDlnn8+yyR6WbzrGCuGp+GjLVmzz+UdR
         fVlkSc9Pnf5x5G8s+8PBoShJhcB/dMr4o5j0FML36r8weLcOe4dviGRtdp/y8j4fzB
         Guj/STXp4qx4fxsPzOMxiXQXkBb7PYX3njdIEhu0=
Date:   Wed, 26 Aug 2020 16:09:01 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Frank van der Linden <fllinden@amazon.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nfsd: Remove unnecessary assignment in nfs4xdr.c
Message-ID: <20200826200901.GA28877@fieldses.org>
References: <20200812141252.21059-1-alex.dewar90@gmail.com>
 <20200812203631.GA13358@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <20200820233745.fhfsbx63td3u5guy@medion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820233745.fhfsbx63td3u5guy@medion>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 21, 2020 at 12:37:45AM +0100, Alex Dewar wrote:
> On Wed, Aug 12, 2020 at 08:36:31PM +0000, Frank van der Linden wrote:
> > On Wed, Aug 12, 2020 at 03:12:51PM +0100, Alex Dewar wrote:
> > > 
> > > In nfsd4_encode_listxattrs(), the variable p is assigned to at one point
> > > but this value is never used before p is reassigned. Fix this.
> > > 
> > > Addresses-Coverity: ("Unused value")
> > > Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> > > ---
> > >  fs/nfsd/nfs4xdr.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > index 259d5ad0e3f47..1a0341fd80f9a 100644
> > > --- a/fs/nfsd/nfs4xdr.c
> > > +++ b/fs/nfsd/nfs4xdr.c
> > > @@ -4859,7 +4859,7 @@ nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
> > >                         goto out;
> > >                 }
> > > 
> > > -               p = xdr_encode_opaque(p, sp, slen);
> > > +               xdr_encode_opaque(p, sp, slen);
> > > 
> > >                 xdrleft -= xdrlen;
> > >                 count++;
> > > --
> > > 2.28.0
> > > 
> > 
> > Yep, I guess my linting missed that, thanks for the fix.
> > 
> > - Frank
> 
> Ping? The second patch in this series had a mistake in it, but I think
> this one's still good to go :-)

Thanks, applied for 5.10.--b.
