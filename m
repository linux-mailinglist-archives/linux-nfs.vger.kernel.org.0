Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A68256901
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Aug 2020 18:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgH2QRU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 29 Aug 2020 12:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbgH2QRU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 29 Aug 2020 12:17:20 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E1EC061236
        for <linux-nfs@vger.kernel.org>; Sat, 29 Aug 2020 09:17:19 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9BB622012; Sat, 29 Aug 2020 12:17:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9BB622012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1598717838;
        bh=FhjKFb1Dta38cvLlcRJDNRQdAbwdCHq2DqpCz6gI56s=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=r22BS8rQoiLIQy0Hex09yxu2ptkAu/fNXkHb28AwjIcL+3qH9vwH+gKspXhxkS5Ix
         ylyHfRGkm2Ejf96oMukhls9CNFoxHWhaH5i+l+sFLINTTUNLdKkISwURIlwgLUZsHS
         dL6IsWWrd0AuM6zS+yyYACFw9pO8JxkLEdlf6+po=
Date:   Sat, 29 Aug 2020 12:17:18 -0400
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1] NFS: Zero-stateid SETATTR should first return
 delegation
Message-ID: <20200829161718.GC20499@fieldses.org>
References: <159864470513.1031951.14868951913532221090.stgit@manet.1015granger.net>
 <f5827110d3627096bdd4c07060876e69089a8d87.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5827110d3627096bdd4c07060876e69089a8d87.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 28, 2020 at 09:13:07PM +0000, Trond Myklebust wrote:
> On Fri, 2020-08-28 at 15:58 -0400, Chuck Lever wrote:
> > If a write delegation isn't available, the Linux NFS client uses
> > a zero-stateid when performing a SETATTR.
> > 
> > If that client happens to hold a read delegation, the server will
> > recall it immediately, resulting in a short delay while the
> > CB_RECALL operation is done. Optimize out this delay by having the
> > client return any delegation it may hold on a file before issuing a
> > SETATTR(zero-stateid) on that file.
> > 
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfs/nfs4proc.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index dbd01548335b..53a56250cf4b 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -3314,6 +3314,7 @@ static int _nfs4_do_setattr(struct inode
> > *inode,
> >  			goto zero_stateid;
> >  	} else {
> >  zero_stateid:
> > +		nfs4_inode_return_delegation(inode);
> >  		nfs4_stateid_copy(&arg->stateid, &zero_stateid);
> >  	}
> >  	if (delegation_cred)
> > 
> 
> This should not be needed for NFSv4.1 or greater. Only NFSv4.0 is
> incapable of identifying the caller and recognising that it is the
> holder of the delegation.

And the server should be getting this right now in the >=4.1 case, so
let me know if you see otherwise.

--b.
