Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8D03083E1
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jan 2021 03:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhA2CgN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jan 2021 21:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhA2CgJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jan 2021 21:36:09 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4E0C061573
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jan 2021 18:35:28 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7BD324599; Thu, 28 Jan 2021 21:35:27 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7BD324599
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1611887727;
        bh=fKYk+bQMjc7+Pk1Fus0b+39ojugig6ZiA62cnbvlwSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b1iNwtWNaGyajoeSIQgdLzpEoiRbYPUQOB2XpxPh2UgiGB8Z5/FACo5kNrr3c9V/g
         yq+mqKUKAWFEA6b7D3TiWsjw+k2EWpJTmcPZn/EnXXjP9qxToZtYjJYISXliWs1MAS
         aVBAkLOb3ki25H5QN6o70o0y9sytO54ZwFnpHN8M=
Date:   Thu, 28 Jan 2021 21:35:27 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "guy@vastdata.com" <guy@vastdata.com>,
        "schumakeranna@gmail.com" <schumakeranna@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: we don't support removing system.nfs4_acl
Message-ID: <20210129023527.GA11864@fieldses.org>
References: <20210128223638.GE29887@fieldses.org>
 <95e5f9e4-76d4-08c4-ece3-35a10c06073b@vastdata.com>
 <cbc7115cc5d5aeb7ffb9e9b3880e453bf54ecbdb.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbc7115cc5d5aeb7ffb9e9b3880e453bf54ecbdb.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 29, 2021 at 01:37:10AM +0000, Trond Myklebust wrote:
> On Fri, 2021-01-29 at 01:34 +0200, guy keren wrote:
> > On 1/29/21 12:36 AM, J. Bruce Fields wrote:
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > The NFSv4 protocol doesn't have any notion of reomoving an attribute,
> > so
> > removexattr(path,"system.nfs4_acl") doesn't make sense.
> > 
> > There's no documented return value.  Arguably it could be EOPNOTSUPP
> > but
> > I'm a little worried an application might take that to mean that we
> > don't support ACLs or xattrs.  How about EINVAL?
> > 
> > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > ---
> >  fs/nfs/nfs4proc.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 2f4679a62712..d50dea5f5723 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -5895,6 +5895,9 @@ static int __nfs4_proc_set_acl(struct inode
> > *inode, const void *buf, size_t bufl
> >  	unsigned int npages = DIV_ROUND_UP(buflen, PAGE_SIZE);
> >  	int ret, i;
> >  
> > +	/* You can't remove system.nfs4_acl: */
> > +	if (buflen == 0)
> > +		return -EINVAL;
> >  	if (!nfs4_server_supports_acls(server))
> >  		return -EOPNOTSUPP;
> >  	if (npages > ARRAY_SIZE(pages))
> > 
> > question: what happens if someone is attempting to create an empty
> > ACL on a file? as far as i know, this is legal.
> > won't you arrive into this position with a buflen of 0? it should be
> > similar to 'chmod 0 <file>'.
> > 
> 
> Agreed. If the server doesn't support removing the ACL then it should
> be up to it to enforce that condition. I see nothing in the NFS
> protocol that says it is up to the NFS client to act as the enforcer
> here.

Agreed.

Note that this patch doesn't prevent an application from setting a
zero-length ACL.  The xattr format is XDR with the first four bytes
representing the number of ACEs, so you'd set a zero-length ACL by
passing down a 4-byte all-zero buffer as the new value of the
system.nfs4_acl xattr.

A zero-length NULL buffer is what's used to implement removexattr:

int
__vfs_removexattr(struct dentry *dentry, const char *name)
{
	...
	return handler->set(handler, dentry, inode, name, NULL, 0, XATTR_REPLACE);
}

That's the case this patch covers.

--b.
