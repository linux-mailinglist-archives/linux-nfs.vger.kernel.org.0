Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631042C45ED
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 17:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbgKYQvE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Nov 2020 11:51:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44631 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731088AbgKYQvD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Nov 2020 11:51:03 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1khy0T-0005D7-RI; Wed, 25 Nov 2020 16:51:01 +0000
Subject: Re: nfsd: skip some unnecessary stats in the v4 case
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <de7dc4f1-cbf2-6bcd-1466-d67b418dcc5f@canonical.com>
 <20201125164738.GA7049@fieldses.org>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <5a0b9908-9942-ddca-63f6-a87bb9867855@canonical.com>
Date:   Wed, 25 Nov 2020 16:51:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201125164738.GA7049@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 25/11/2020 16:47, J. Bruce Fields wrote:
> On Wed, Nov 25, 2020 at 02:50:51PM +0000, Colin Ian King wrote:
>> Static analysis on today's linux-next has found an issue with the
>> following commit:
> 
> Thanks!  I'll probably do something like this.

Looks good to me, even if it is a little more convoluted. Thanks.

> 
> Though this still all seems slightly more complicated than necessary.
> 
> --b.
> 
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index 8502a493be6d..7eb761801169 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -260,13 +260,12 @@ void fill_pre_wcc(struct svc_fh *fhp)
>  	struct inode    *inode;
>  	struct kstat	stat;
>  	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
> -	__be32 err;
>  
>  	if (fhp->fh_pre_saved)
>  		return;
>  	inode = d_inode(fhp->fh_dentry);
>  	if (!v4 || !inode->i_sb->s_export_op->fetch_iversion) {
> -		err = fh_getattr(fhp, &stat);
> +		__be32 err = fh_getattr(fhp, &stat);
>  		if (err) {
>  			/* Grab the times from inode anyway */
>  			stat.mtime = inode->i_mtime;
> @@ -290,23 +289,23 @@ void fill_post_wcc(struct svc_fh *fhp)
>  {
>  	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
>  	struct inode *inode = d_inode(fhp->fh_dentry);
> -	__be32 err;
>  
>  	if (fhp->fh_post_saved)
>  		printk("nfsd: inode locked twice during operation.\n");
>  
> +	fhp->fh_post_saved = true;
>  
> -	if (!v4 || !inode->i_sb->s_export_op->fetch_iversion)
> -		err = fh_getattr(fhp, &fhp->fh_post_attr);
> +	if (!v4 || !inode->i_sb->s_export_op->fetch_iversion) {
> +		__be32 err = fh_getattr(fhp, &fhp->fh_post_attr);
> +		if (err) {
> +			fhp->fh_post_saved = false;
> +			/* set_change_info might still need this: */
> +			fhp->fh_post_attr.ctime = inode->i_ctime;
> +		}
> +	}
>  	if (v4)
>  		fhp->fh_post_change =
>  			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
> -	if (err) {
> -		fhp->fh_post_saved = false;
> -		/* Grab the ctime anyway - set_change_info might use it */
> -		fhp->fh_post_attr.ctime = inode->i_ctime;
> -	} else
> -		fhp->fh_post_saved = true;
>  }
>  
>  /*
> 

