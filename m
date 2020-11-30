Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FF52C902D
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 22:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbgK3Vn3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 16:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgK3Vn3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 16:43:29 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54275C0613D2
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 13:42:49 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 88B666F4A; Mon, 30 Nov 2020 16:42:48 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 88B666F4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606772568;
        bh=kUl+m2+x9z6999By4hnUJ7omoFviFWMKXWjiJqYj8VM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GrjhodYxJaeVTo6uxyxa9cmFDPBfgXtapP9TGqmXDYHMmB7hzmLuWg+Nw/thMG4nl
         W6LHKAKxJN/YVWW45ZRVfIScUjnYUHXt3xMrwJ2lqFFbzBd0zePi5RiYOygHlrFWAD
         GoFbVnnCgExqkAML328vVxSE3+2l3GcqY5t+DGtQ=
Date:   Mon, 30 Nov 2020 16:42:48 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>
Subject: Re: [PATCH 1/5] nfsd: only call inode_query_iversion in the
 I_VERSION case
Message-ID: <20201130214248.GB18997@fieldses.org>
References: <1606765137-17257-1-git-send-email-bfields@fieldses.org>
 <50CF0FBE-9C58-4DAA-B524-DE15047E9FD1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50CF0FBE-9C58-4DAA-B524-DE15047E9FD1@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 30, 2020 at 04:03:23PM -0500, Chuck Lever wrote:
> 
> 
> > On Nov 30, 2020, at 2:38 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > 
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
> 
> New sparse warnings after this one is applied:

D'oh.  I'll send again, thanks!

--b.

> 
> /home/cel/src/linux/linux/fs/nfsd/nfsfh.h:270:24: warning: incorrect type in assignment (different base types)
> /home/cel/src/linux/linux/fs/nfsd/nfsfh.h:270:24:    expected unsigned long long [assigned] [usertype] chattr
> /home/cel/src/linux/linux/fs/nfsd/nfsfh.h:270:24:    got restricted __be32 [usertype]
> /home/cel/src/linux/linux/fs/nfsd/nfsfh.h:272:24: warning: invalid assignment: +=
> /home/cel/src/linux/linux/fs/nfsd/nfsfh.h:272:24:    left side has type unsigned long long
> /home/cel/src/linux/linux/fs/nfsd/nfsfh.h:272:24:    right side has type restricted __be32
> /home/cel/src/linux/linux/fs/nfsd/nfsfh.h:270:24: warning: incorrect type in assignment (different base types)
> /home/cel/src/linux/linux/fs/nfsd/nfsfh.h:270:24:    expected unsigned long long [assigned] [usertype] chattr
> /home/cel/src/linux/linux/fs/nfsd/nfsfh.h:270:24:    got restricted __be32 [usertype]
> /home/cel/src/linux/linux/fs/nfsd/nfsfh.h:272:24: warning: invalid assignment: +=
> /home/cel/src/linux/linux/fs/nfsd/nfsfh.h:272:24:    left side has type unsigned long long
> /home/cel/src/linux/linux/fs/nfsd/nfsfh.h:272:24:    right side has type restricted __be32
> 
> 
> > ---
> > fs/nfsd/nfs3xdr.c |  5 ++---
> > fs/nfsd/nfs4xdr.c |  6 +-----
> > fs/nfsd/nfsfh.h   | 14 ++++++++++----
> > 3 files changed, 13 insertions(+), 12 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> > index 2277f83da250..dfbf390ff40c 100644
> > --- a/fs/nfsd/nfs3xdr.c
> > +++ b/fs/nfsd/nfs3xdr.c
> > @@ -291,14 +291,13 @@ void fill_post_wcc(struct svc_fh *fhp)
> > 		printk("nfsd: inode locked twice during operation.\n");
> > 
> > 	err = fh_getattr(fhp, &fhp->fh_post_attr);
> > -	fhp->fh_post_change = nfsd4_change_attribute(&fhp->fh_post_attr,
> > -						     d_inode(fhp->fh_dentry));
> > 	if (err) {
> > 		fhp->fh_post_saved = false;
> > -		/* Grab the ctime anyway - set_change_info might use it */
> > 		fhp->fh_post_attr.ctime = d_inode(fhp->fh_dentry)->i_ctime;
> > 	} else
> > 		fhp->fh_post_saved = true;
> > +	fhp->fh_post_change = nfsd4_change_attribute(&fhp->fh_post_attr,
> > +						     d_inode(fhp->fh_dentry));
> > }
> > 
> > /*
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 833a2c64dfe8..56fd5f6d5c44 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -2298,12 +2298,8 @@ static __be32 *encode_change(__be32 *p, struct kstat *stat, struct inode *inode,
> > 	if (exp->ex_flags & NFSEXP_V4ROOT) {
> > 		*p++ = cpu_to_be32(convert_to_wallclock(exp->cd->flush_time));
> > 		*p++ = 0;
> > -	} else if (IS_I_VERSION(inode)) {
> > +	} else
> > 		p = xdr_encode_hyper(p, nfsd4_change_attribute(stat, inode));
> > -	} else {
> > -		*p++ = cpu_to_be32(stat->ctime.tv_sec);
> > -		*p++ = cpu_to_be32(stat->ctime.tv_nsec);
> > -	}
> > 	return p;
> > }
> > 
> > diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> > index 56cfbc361561..3faf5974fa4e 100644
> > --- a/fs/nfsd/nfsfh.h
> > +++ b/fs/nfsd/nfsfh.h
> > @@ -261,10 +261,16 @@ static inline u64 nfsd4_change_attribute(struct kstat *stat,
> > {
> > 	u64 chattr;
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
> > +		chattr = cpu_to_be32(stat->ctime.tv_sec);
> > +		chattr <<= 32;
> > +		chattr += cpu_to_be32(stat->ctime.tv_nsec);
> > +	}
> > 	return chattr;
> > }
> > 
> > -- 
> > 2.28.0
> > 
> 
> --
> Chuck Lever
> 
> 
