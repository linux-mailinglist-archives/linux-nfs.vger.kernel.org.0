Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8205175BB00
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 01:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjGTXKB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 19:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTXKA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 19:10:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C482111;
        Thu, 20 Jul 2023 16:09:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8E0E61CAF;
        Thu, 20 Jul 2023 23:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508FAC433C8;
        Thu, 20 Jul 2023 23:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689894598;
        bh=5u2MFbEXRLM0Yy5+2PHiozlXGPM2MahnPfqlMUKj5t0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dbA9l5NBi2Eb17ZHDob8XvgSLd4QlORT31d5Aub82a5uvPmL7+D5Q8pmEKQ+YCJs/
         khFYxKZtN+IOayjVNKbDzhiv2lkYO0m9HxKrice8DvAgiarc/jWuyWZEhN7bkfsJOm
         Y8AE6Yl2HoqdQzZDIBHrfWyHjozxDyoAISLpmAuELNkOdIOdOHPtom+JwMth12RYFY
         7far7M2Omx2zcqIoucbEyYx5j9J2ISujVN1d0FSs2pgmuBpo8Tc+1sEtTaRSvXk84x
         20cvue/CLcE/uEClYadd1WoYq3YTPtT6M166TBMGvVMzVTqGob7XrleBNWieHIOvBt
         Ug/DmOXxwIhmg==
Date:   Thu, 20 Jul 2023 19:09:55 -0400
From:   Chuck Lever <cel@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Boyang Xue <bxue@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nfsd: handle failure to collect pre/post-op attrs
 more sanely
Message-ID: <ZLm+w+aYVm59ctGq@manet.1015granger.net>
References: <20230720-bz2223560-v2-0-070aaf2660b7@kernel.org>
 <20230720-bz2223560-v2-1-070aaf2660b7@kernel.org>
 <168988958067.11078.10143293324143654882@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168988958067.11078.10143293324143654882@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jul 21, 2023 at 07:46:20AM +1000, NeilBrown wrote:
> On Fri, 21 Jul 2023, Jeff Layton wrote:
> > Collecting pre_op_attrs can fail, in which case it's probably best to
> > fail the whole operation.
> > 
> > Change fh_fill_{pre,post,both}_attrs to return __be32. For the pre and
> > both functions, have the callers check the return code and abort the
> > operation if it failed.
> > 
> > If fh_fill_post_attrs fails, then it's too late to do anything about it,
> > so most of those callers ignore the return value. If this happens, then
> > fh_post_saved will be false, which should cue the later stages to deal
> > with it.
> > 
> > Suggested-by: Chuck Lever <chuck.lever@oracle.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/nfs3proc.c |  4 +++-
> >  fs/nfsd/nfs4proc.c | 14 ++++++------
> >  fs/nfsd/nfsfh.c    | 26 ++++++++++++++---------
> >  fs/nfsd/nfsfh.h    |  6 +++---
> >  fs/nfsd/vfs.c      | 62 ++++++++++++++++++++++++++++++++++--------------------
> >  5 files changed, 69 insertions(+), 43 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> > index fc8d5b7db9f8..268ef57751c4 100644
> > --- a/fs/nfsd/nfs3proc.c
> > +++ b/fs/nfsd/nfs3proc.c
> > @@ -307,7 +307,9 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	if (!IS_POSIXACL(inode))
> >  		iap->ia_mode &= ~current_umask();
> >  
> > -	fh_fill_pre_attrs(fhp);
> > +	status = fh_fill_pre_attrs(fhp);
> > +	if (status != nfs_ok)
> > +		goto out;
> >  	host_err = vfs_create(&nop_mnt_idmap, inode, child, iap->ia_mode, true);
> >  	if (host_err < 0) {
> >  		status = nfserrno(host_err);
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index d8e7a533f9d2..9285e1eab4d5 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -297,12 +297,12 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	}
> >  
> >  	if (d_really_is_positive(child)) {
> > -		status = nfs_ok;
> > -
> >  		/* NFSv4 protocol requires change attributes even though
> >  		 * no change happened.
> >  		 */
> > -		fh_fill_both_attrs(fhp);
> > +		status = fh_fill_both_attrs(fhp);
> > +		if (status != nfs_ok)
> > +			goto out;
> >  
> >  		switch (open->op_createmode) {
> >  		case NFS4_CREATE_UNCHECKED:
> > @@ -345,7 +345,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	if (!IS_POSIXACL(inode))
> >  		iap->ia_mode &= ~current_umask();
> >  
> > -	fh_fill_pre_attrs(fhp);
> > +	status = fh_fill_pre_attrs(fhp);
> > +	if (status != nfs_ok)
> > +		goto out;
> >  	status = nfsd4_vfs_create(fhp, child, open);
> >  	if (status != nfs_ok)
> >  		goto out;
> > @@ -424,11 +426,11 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
> >  	} else {
> >  		status = nfsd_lookup(rqstp, current_fh,
> >  				     open->op_fname, open->op_fnamelen, *resfh);
> > -		if (!status)
> > +		if (status == nfs_ok)
> >  			/* NFSv4 protocol requires change attributes even though
> >  			 * no change happened.
> >  			 */
> > -			fh_fill_both_attrs(current_fh);
> > +			status = fh_fill_both_attrs(current_fh);
> >  	}
> >  	if (status)
> >  		goto out;
> > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > index c291389a1d71..f7e68a91e826 100644
> > --- a/fs/nfsd/nfsfh.c
> > +++ b/fs/nfsd/nfsfh.c
> > @@ -614,7 +614,7 @@ fh_update(struct svc_fh *fhp)
> >   * @fhp: file handle to be updated
> >   *
> >   */
> > -void fh_fill_pre_attrs(struct svc_fh *fhp)
> > +__be32 fh_fill_pre_attrs(struct svc_fh *fhp)
> >  {
> >  	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
> >  	struct inode *inode;
> > @@ -622,12 +622,12 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
> >  	__be32 err;
> >  
> >  	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
> > -		return;
> > +		return nfs_ok;
> >  
> >  	inode = d_inode(fhp->fh_dentry);
> >  	err = fh_getattr(fhp, &stat);
> >  	if (err)
> > -		return;
> > +		return err;
> >  
> >  	if (v4)
> >  		fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
> > @@ -636,6 +636,7 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
> >  	fhp->fh_pre_ctime = stat.ctime;
> >  	fhp->fh_pre_size  = stat.size;
> >  	fhp->fh_pre_saved = true;
> > +	return nfs_ok;
> >  }
> >  
> >  /**
> > @@ -643,26 +644,27 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
> >   * @fhp: file handle to be updated
> >   *
> >   */
> > -void fh_fill_post_attrs(struct svc_fh *fhp)
> > +__be32 fh_fill_post_attrs(struct svc_fh *fhp)
> >  {
> >  	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
> >  	struct inode *inode = d_inode(fhp->fh_dentry);
> >  	__be32 err;
> >  
> >  	if (fhp->fh_no_wcc)
> > -		return;
> > +		return nfs_ok;
> >  
> >  	if (fhp->fh_post_saved)
> >  		printk("nfsd: inode locked twice during operation.\n");
> >  
> >  	err = fh_getattr(fhp, &fhp->fh_post_attr);
> >  	if (err)
> > -		return;
> > +		return err;
> >  
> >  	fhp->fh_post_saved = true;
> >  	if (v4)
> >  		fhp->fh_post_change =
> >  			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
> > +	return nfs_ok;
> >  }
> >  
> >  /**
> > @@ -672,16 +674,20 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
> >   * This is used when the directory wasn't changed, but wcc attributes
> >   * are needed anyway.
> >   */
> > -void fh_fill_both_attrs(struct svc_fh *fhp)
> > +__be32 fh_fill_both_attrs(struct svc_fh *fhp)
> >  {
> > -	fh_fill_post_attrs(fhp);
> > -	if (!fhp->fh_post_saved)
> > -		return;
> > +	__be32 err;
> > +
> > +	err = fh_fill_post_attrs(fhp);
> > +	if (err)
> > +		return err;
> > +
> >  	fhp->fh_pre_change = fhp->fh_post_change;
> >  	fhp->fh_pre_mtime = fhp->fh_post_attr.mtime;
> >  	fhp->fh_pre_ctime = fhp->fh_post_attr.ctime;
> >  	fhp->fh_pre_size = fhp->fh_post_attr.size;
> >  	fhp->fh_pre_saved = true;
> > +	return nfs_ok;
> >  }
> >  
> >  /*
> > diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> > index 4e0ecf0ae2cf..486803694acc 100644
> > --- a/fs/nfsd/nfsfh.h
> > +++ b/fs/nfsd/nfsfh.h
> > @@ -294,7 +294,7 @@ static inline void fh_clear_pre_post_attrs(struct svc_fh *fhp)
> >  }
> >  
> >  u64 nfsd4_change_attribute(struct kstat *stat, struct inode *inode);
> > -extern void fh_fill_pre_attrs(struct svc_fh *fhp);
> > -extern void fh_fill_post_attrs(struct svc_fh *fhp);
> > -extern void fh_fill_both_attrs(struct svc_fh *fhp);
> > +__be32 fh_fill_pre_attrs(struct svc_fh *fhp);
> > +__be32 fh_fill_post_attrs(struct svc_fh *fhp);
> > +__be32 fh_fill_both_attrs(struct svc_fh *fhp);
> >  #endif /* _LINUX_NFSD_NFSFH_H */
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 8a2321d19194..f200afd33630 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1537,9 +1537,11 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	dput(dchild);
> >  	if (err)
> >  		goto out_unlock;
> > -	fh_fill_pre_attrs(fhp);
> > -	err = nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
> > -	fh_fill_post_attrs(fhp);
> > +	err = fh_fill_pre_attrs(fhp);
> > +	if (err == nfs_ok) {
> > +		err = nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
> > +		fh_fill_post_attrs(fhp);
> 
> Most error handling in nfsd is
>  
>    if (err)
>        goto ....
> 
> Here (and one other place I think) you have
>    if (not err)
>        do stuff;
> 
> Do we want to be more consistent?

Yes, unless being consistent makes this code unreadable. There
doesn't seem to be a reason to drop that convention here.


> I'm in two minds about this and I
> don't dislike your patch.  But I noticed the inconsistency and thought I
> should mention it.
> 
> Also, should we put a __must_check annotation on fh_fill_pre_attrs() and
> ..post..?  Then I wouldn't have to manually check that you found and
> fixed all callers (which I haven't).
