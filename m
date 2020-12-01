Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A30B2CAD87
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 21:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgLAUkM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 15:40:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726037AbgLAUkM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Dec 2020 15:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606855125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9lHXPG4q5WmZy3T7IrH21rK8Vx5ePAgQ7/+GLhpXhbY=;
        b=D1WYr33WbjnCu4/6RUau4JffcqxQqbRPnUL8cjvWCPm5zvTV6IjahxF79QWesHDGk+HH3z
        fLQeEORr6T/LiceABjWmJwSFiwaUxlfJt4vObBA1G6TNWOyrnq/P23U4hHSKnBZiIzsOyn
        cfNFwlP7vKr8/oyyLzaOJhZ+uC+Wx0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-8ZwUBjKJP_yhti3kgNx_ag-1; Tue, 01 Dec 2020 15:38:41 -0500
X-MC-Unique: 8ZwUBjKJP_yhti3kgNx_ag-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BD94423BB;
        Tue,  1 Dec 2020 20:38:40 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-116-43.rdu2.redhat.com [10.10.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2692160BD8;
        Tue,  1 Dec 2020 20:38:40 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 445041205B4; Tue,  1 Dec 2020 15:38:39 -0500 (EST)
Date:   Tue, 1 Dec 2020 15:38:39 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/5] nfsd: only call inode_query_iversion in the
 I_VERSION case
Message-ID: <20201201203839.GA259862@pick.fieldses.org>
References: <1606776378-22381-1-git-send-email-bfields@fieldses.org>
 <01bad6aa8aa05bb9bafd010575866125f89c5f08.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01bad6aa8aa05bb9bafd010575866125f89c5f08.camel@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 01, 2020 at 11:43:31AM -0500, Jeff Layton wrote:
> On Mon, 2020-11-30 at 17:46 -0500, J. Bruce Fields wrote:
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > inode_query_iversion() can modify i_version.  Depending on the exported
> > filesystem, that may not be safe.  For example, if you're re-exporting
> > NFS, NFS stores the server's change attribute in i_version and does not
> > expect it to be modified locally.  This has been observed causing
> > unnecessary cache invalidations.
> > 
> > The way a filesystem indicates that it's OK to call
> > inode_query_iverson() is by setting SB_I_VERSION.
> > 
> > So, move the I_VERSION check out of encode_change(), where it's used
> > only in FATTR responses, to nfsd4_changeattr(), which is also called for
> > pre- and post- operation attributes.
> > 
> > (Note we could also pull the NFSEXP_V4ROOT case into
> > nfsd4_change_attribute as well.  That would actually be a no-op, since
> > pre/post attrs are only used for metadata-modifying operations, and
> > V4ROOT exports are read-only.  But we might make the change in the
> > future just for simplicity.)
> > 
> > Reported-by: Daire Byrne <daire@dneg.com>
> > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > ---
> >  fs/nfsd/nfs3xdr.c |  5 ++---
> >  fs/nfsd/nfs4xdr.c |  6 +-----
> >  fs/nfsd/nfsfh.h   | 14 ++++++++++----
> >  3 files changed, 13 insertions(+), 12 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> > index 2277f83da250..dfbf390ff40c 100644
> > --- a/fs/nfsd/nfs3xdr.c
> > +++ b/fs/nfsd/nfs3xdr.c
> > @@ -291,14 +291,13 @@ void fill_post_wcc(struct svc_fh *fhp)
> >  		printk("nfsd: inode locked twice during operation.\n");
> >  
> > 
> > 
> > 
> >  	err = fh_getattr(fhp, &fhp->fh_post_attr);
> > -	fhp->fh_post_change = nfsd4_change_attribute(&fhp->fh_post_attr,
> > -						     d_inode(fhp->fh_dentry));
> >  	if (err) {
> >  		fhp->fh_post_saved = false;
> > -		/* Grab the ctime anyway - set_change_info might use it */
> >  		fhp->fh_post_attr.ctime = d_inode(fhp->fh_dentry)->i_ctime;
> >  	} else
> >  		fhp->fh_post_saved = true;
> > +	fhp->fh_post_change = nfsd4_change_attribute(&fhp->fh_post_attr,
> > +						     d_inode(fhp->fh_dentry));
> >  }
> >  
> > 
> > 
> > 
> >  /*
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 833a2c64dfe8..56fd5f6d5c44 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -2298,12 +2298,8 @@ static __be32 *encode_change(__be32 *p, struct kstat *stat, struct inode *inode,
> >  	if (exp->ex_flags & NFSEXP_V4ROOT) {
> >  		*p++ = cpu_to_be32(convert_to_wallclock(exp->cd->flush_time));
> >  		*p++ = 0;
> > -	} else if (IS_I_VERSION(inode)) {
> > +	} else
> >  		p = xdr_encode_hyper(p, nfsd4_change_attribute(stat, inode));
> > -	} else {
> > -		*p++ = cpu_to_be32(stat->ctime.tv_sec);
> > -		*p++ = cpu_to_be32(stat->ctime.tv_nsec);
> > -	}
> >  	return p;
> >  }
> >  
> > 
> > 
> > 
> > diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> > index 56cfbc361561..39d764b129fa 100644
> > --- a/fs/nfsd/nfsfh.h
> > +++ b/fs/nfsd/nfsfh.h
> > @@ -261,10 +261,16 @@ static inline u64 nfsd4_change_attribute(struct kstat *stat,
> >  {
> >  	u64 chattr;
> >  
> > 
> > 
> > 
> > -	chattr =  stat->ctime.tv_sec;
> > -	chattr <<= 30;
> > -	chattr += stat->ctime.tv_nsec;
> > -	chattr += inode_query_iversion(inode);
> > +	if (IS_I_VERSION(inode)) {
> > +		chattr =  stat->ctime.tv_sec;
> > +		chattr <<= 30;
> > +		chattr += stat->ctime.tv_nsec;
> > +		chattr += inode_query_iversion(inode);
> > +	} else {
> > +		chattr = stat->ctime.tv_sec;
> > +		chattr <<= 32;
> 
> Might be nice to annotate the shifts above and maybe make them named
> constants. I'm not sure where those values come from, tbh.

This shouldn't be changing the on-the-wire results at all; so
for example the latter is just doing exactly what:

> > -		*p++ = cpu_to_be32(stat->ctime.tv_sec);
> > -		*p++ = cpu_to_be32(stat->ctime.tv_nsec);

did (after xdr-encoding of the 64-bit chattr).

But yeah maybe it could use some explanation.

The 30-bit shift in the IS_I_VERSION case is weirder, I honestly don't
remember what I was thinking.  Maybe just that nanoseconds really only
need 30 bits, and the shift would save a couple high bits in case we
wanted to change the format later without making the change attribute go
backwards.  Probably overthinking it!

--b.

