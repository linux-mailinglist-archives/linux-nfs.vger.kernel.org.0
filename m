Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC7E9AD1F9
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2019 04:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732957AbfIICgL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Sep 2019 22:36:11 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33599 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731928AbfIICgK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Sep 2019 22:36:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id t11so5865677plo.0
        for <linux-nfs@vger.kernel.org>; Sun, 08 Sep 2019 19:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fGl0467DNWpNCh493JC4NyhOyXJ6p/TNVqtSivK+TJI=;
        b=HYwl7A60IgY2Ug7EoRZYJ2ZglmB3AiqiKeS4PDpXAgHXGUUF3OnPughxkYBhvJllGh
         NKvNofNK90zFh+7kS12nuOsYp/bkCrFiz8K5V5RG9hm9fzarRyc5o4bchDphihgQJuDE
         q5oxvtaJCuz4XutsRGc6F126TuZFm/TtZCkNTlIu12ijuFi2As3wgCv7wO9ZTkv3CYDe
         8uM9pTO02g7xGLguGhLj4+bheZO9QnFdXCsbuTjiacRowZfhRlSHaisHfk41BirhQyR8
         l0azkTX9iM275kfpiXVS9mJMYRiaaR9ktYyPPfd/oxbQJl/e2I8DB+j3g/yD2634Y+hj
         mF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fGl0467DNWpNCh493JC4NyhOyXJ6p/TNVqtSivK+TJI=;
        b=T/DKSepAIFE34+dq+N5eBeKYKN/W4H3MFT+8rh0rhTOQzdo+Etdf6uxMnyttOfHzXf
         m2ZRQ35rucW/AAydJKSIpTN0xJVqayJQSVFnAx5D/D0H7GzqJuGk8NVleNZXY3b8eloS
         3o94amfbfLQ+8pz/e3FTazzFvJz7jufYK1o761VhRTcZDSlR5ezdXCzPGJMzfl22necR
         JYitkJW10FbY/Nnap3QHIBN061O9eG5P0WYhTkR9ne4hwwHnM3sFvFpBjzacS+Mdi1qI
         31Ict9emx2NS4cBiIbeiniRbN4yry6f2EE886uW9deLKavfHRJ57gnnQkRV31qm6J8pN
         Z9Gw==
X-Gm-Message-State: APjAAAUenyfh+09sxr+PeNoXzEjQTJBhsLIBD6d8zrqpfnC3SeBRqOvQ
        2I09mG918PCVB2zeUGcWXDo=
X-Google-Smtp-Source: APXvYqyGx4rquNY6/gEt8u82zXsQzGMoJZr2XrNq99W3GnVShtGxLvERLqYuPtNIYWYc0UgTcsq8Qg==
X-Received: by 2002:a17:902:9a05:: with SMTP id v5mr9301914plp.237.1567996568556;
        Sun, 08 Sep 2019 19:36:08 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q42sm13378860pja.16.2019.09.08.19.36.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Sep 2019 19:36:07 -0700 (PDT)
Date:   Mon, 9 Sep 2019 10:36:00 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jencce.kernel@gmail.com" <jencce.kernel@gmail.com>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>
Subject: Re: nfs-for-5.3-3 update "breaks" NFSv4 directIO somehow
Message-ID: <20190909023600.sxygdyclxm4ivllw@XZHOUW.usersys.redhat.com>
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

Hi Trond,

Will you queue this fix for v5.3 ?

Thanks!

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
