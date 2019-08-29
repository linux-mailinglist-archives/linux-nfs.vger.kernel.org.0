Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87E8FA0E85
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2019 02:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfH2AGR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 20:06:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43364 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfH2AGR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Aug 2019 20:06:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so559185pgb.10
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2019 17:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wspgap3Tf9JL/6azrZxB+h+6c/nV/dmEy9Ir2yl5KrQ=;
        b=TbFpvo9PpaHCR6YW+JQ12YiRJ9k3A25bK9ANjq1tGMedJiQImOQ+IbGo9aOXHTPgYs
         aAxfWYDJj93N993CgGdaXndV2AlOHYEPx7/VnPOWMBPltFh0XV15blrLeQQqdsXQeZTg
         bn7+d1UYp+h9ha/rj4cAfNgd1XiA3v09cjwJ/uMrVdLF8aHYSdkfTcRACTy0oU17aLyZ
         ft9t3IMH+9e45fuYEKduuO+s1Lrz+dktcyVf3fKwOeRu/Q5VbQGxUHYvGVmuDEbEj6/d
         zYIRuFDIs+DGo/qgJGILXVuedmQQ8oPv5b8s+UAaAI95bywtFOfi9q2h4viheXwOw9Qr
         V19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wspgap3Tf9JL/6azrZxB+h+6c/nV/dmEy9Ir2yl5KrQ=;
        b=HJvxsk4I8je1ME3WMVVwgTVViIZhFOK/iiCbnCy+htOFzZDjNAiFmg+yGJmRcq7AH9
         RFOZ/nJpKalJB6ZivoN/Wf8uEP0KLfBUSTz1DwdXBrJt+xsI8O0qzcMPqDZ3N3mpEZ+v
         qb8jSm9U4IlHRJD/kQ3l//CEB2hExMuUvRJSI34eQAK84/iwLyUjYrqkeq2cn4ORDB67
         G5UL6OT9iS8c3W26RE8cB1e6Wcwc/sMaFFooYnT9bTPC5ZAE0VHpBY2ixzFbhCpV8OJY
         4mIAovcltQVysT2O92mwCxNDwB/BqDbg9GhZWTgDNxNdIoDTaLuqqj4nWqUWV7UB6tax
         JewA==
X-Gm-Message-State: APjAAAUxqbA0llHGlQFG4sC2B5LhK7ZtgdFqC1dP5LPVXpSMd2Z/vC/c
        CpGPllJUt1T1LYctfP98P2c=
X-Google-Smtp-Source: APXvYqztPn+/A3A6ACsh1Yjef7lBM1aJNRwz7nSZPs81i1MwGqTmUq6kCeW2MYRtIm76uF2kp6VI4A==
X-Received: by 2002:a17:90a:b288:: with SMTP id c8mr6894939pjr.135.1567037176611;
        Wed, 28 Aug 2019 17:06:16 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e9sm282404pja.17.2019.08.28.17.06.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 17:06:16 -0700 (PDT)
Date:   Thu, 29 Aug 2019 08:06:08 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jencce.kernel@gmail.com" <jencce.kernel@gmail.com>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>
Subject: Re: nfs-for-5.3-3 update "breaks" NFSv4 directIO somehow
Message-ID: <20190829000608.hugn6q5tgmttxxw5@XZHOUW.usersys.redhat.com>
References: <20190828102256.3nhyb2ngzitwd7az@XZHOUW.usersys.redhat.com>
 <00923c9f5d5a69e8225640abcf7ad54df2cb62d2.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00923c9f5d5a69e8225640abcf7ad54df2cb62d2.camel@hammerspace.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 28, 2019 at 03:32:25PM +0000, Trond Myklebust wrote:
> On Wed, 2019-08-28 at 18:22 +0800, Murphy Zhou wrote:
> > Hi,
> > 
> > If write to file with O_DIRECT, then read it without O_DIRECT, read
> > returns 0.
> > From tshark output, looks like the READ call is missing.
> > 
> > LTP[1] dio tests spot this. Things work well before this update.
> > 
> > Bisect log is pointing to:
> > 
> > 	commit 7e10cc25bfa0dd3602bbcf5cc9c759a90eb675dc
> > 	Author: Trond Myklebust <trond.myklebust@hammerspace.com>
> > 	Date:   Fri Aug 9 12:06:43 2019 -0400
> > 	
> > 	    NFS: Don't refresh attributes with mounted-on-file
> > informatio
> > 
> > With this commit reverted, the tests pass again.
> > 
> > It's only about NFSv4(4.0 4.1 and 4.2), NFSv3 works well.
> > 
> > Bisect log, outputs of tshark, sample test programme derived from
> > LTP diotest02.c and a simple test script are attached.
> > 
> > If this is an expected change, we will need to update the testcases.
> 
> That is not intentional, so thanks for reporting it! Does the following
> fix help?

This patch fixed the issue. Thanks!

Murphy

> 
> 8<------------------------
> From ce61618bc085d8cea8a614b5e1eb09e16ea8e036 Mon Sep 17 00:00:00 2001
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> Date: Wed, 28 Aug 2019 11:26:13 -0400
> Subject: [PATCH] NFS: Fix inode fileid checks in attribute revalidation code
> 
> We want to throw out the attrbute if it refers to the mounted on fileid,
> and not the real fileid. However we do not want to block cache consistency
> updates from NFSv4 writes.
> 
> Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
> Fixes: 7e10cc25bfa0 ("NFS: Don't refresh attributes with mounted-on-file...")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/inode.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index c764cfe456e5..d7e78b220cf6 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -1404,10 +1404,11 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
>  		return 0;
>  
>  	/* No fileid? Just exit */
> -	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID))
> -		return 0;
> +	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID)) {
> +		if (fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID)
> +			return 0;
>  	/* Has the inode gone and changed behind our back? */
> -	if (nfsi->fileid != fattr->fileid) {
> +	} else if (nfsi->fileid != fattr->fileid) {
>  		/* Is this perhaps the mounted-on fileid? */
>  		if ((fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID) &&
>  		    nfsi->fileid == fattr->mounted_on_fileid)
> @@ -1808,10 +1809,11 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
>  			atomic_read(&inode->i_count), fattr->valid);
>  
>  	/* No fileid? Just exit */
> -	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID))
> -		return 0;
> +	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID)) {
> +		if (fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID)
> +			return 0;
>  	/* Has the inode gone and changed behind our back? */
> -	if (nfsi->fileid != fattr->fileid) {
> +	} else if (nfsi->fileid != fattr->fileid) {
>  		/* Is this perhaps the mounted-on fileid? */
>  		if ((fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID) &&
>  		    nfsi->fileid == fattr->mounted_on_fileid)
> -- 
> 2.21.0
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
