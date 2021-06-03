Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE22739A43C
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jun 2021 17:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhFCPRr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 11:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhFCPRr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 11:17:47 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2E4C06174A;
        Thu,  3 Jun 2021 08:16:02 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 852A41BE4; Thu,  3 Jun 2021 11:16:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 852A41BE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1622733361;
        bh=7maj1D43kbDLqRcM6Yl8tEaT4EYByuNrC/NaY65rlYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OeMNzTcwEnfuaq63wR2xRXNfoZX3Ddg+vTEmfZyA8/6mdShFd5kl+d2onVUbyDGZf
         BsgBA+HU6eVM6MVGb7h8xCI6DVTFfgFPVM06XtdByrLTsmSIxCK7dycNbxk2MhvVdr
         c/yLSUWgiwn0S8CqVHytxlCLZ2YmO2HK1T8ZSyec=
Date:   Thu, 3 Jun 2021 11:16:01 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] NFSD: Fix error return code in
 nfsd4_interssc_connect()
Message-ID: <20210603151601.GA1815@fieldses.org>
References: <20210603135145.972633-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603135145.972633-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 03, 2021 at 01:51:45PM +0000, Wei Yongjun wrote:
> 'status' has been overwritten to 0 after nfsd4_ssc_setup_dul(), this
> cause 0 will be return in vfs_kern_mount() error case. Fix to return
> nfserr_inval in this error case.

Is nfserr_inval the correct error?

--b.

> 
> Fixes: f4e44b393389 ("NFSD: delay unmount source's export after inter-server copy completed.")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  fs/nfsd/nfs4proc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 0bd71c6da81d..2bfb6c408dc6 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1323,6 +1323,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>  	ss_mnt = vfs_kern_mount(type, SB_KERNMOUNT, dev_name, raw_data);
>  	module_put(type->owner);
>  	if (IS_ERR(ss_mnt)) {
> +		status = nfserr_inval;
>  		if (work)
>  			nfsd4_ssc_cancel_dul_work(nn, work);
>  		goto out_free_devname;
