Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A82CA144669
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2020 22:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgAUV2j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jan 2020 16:28:39 -0500
Received: from fieldses.org ([173.255.197.46]:37770 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728776AbgAUV2i (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 21 Jan 2020 16:28:38 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 512651C84; Tue, 21 Jan 2020 16:28:38 -0500 (EST)
Date:   Tue, 21 Jan 2020 16:28:38 -0500
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RESEND 1/6] nfsd: fix filecache lookup
Message-ID: <20200121212838.GC26055@fieldses.org>
References: <20200106181808.562969-1-trond.myklebust@hammerspace.com>
 <20200106181808.562969-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106181808.562969-2-trond.myklebust@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 06, 2020 at 01:18:03PM -0500, Trond Myklebust wrote:
> If the lookup keeps finding a nfsd_file with an unhashed open file,
> then retry once only.

So, symptoms are a hang?

Should this be cc: stable, Fixes: 65294c1f2c5e ("nfsd: add a new struct
file caching facility to nfsd") ?

--b.

> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfsd/filecache.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 32a9bf22ac08..0a3e5c2aac4b 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -789,6 +789,7 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	struct nfsd_file *nf, *new;
>  	struct inode *inode;
>  	unsigned int hashval;
> +	bool retry = true;
>  
>  	/* FIXME: skip this if fh_dentry is already set? */
>  	status = fh_verify(rqstp, fhp, S_IFREG,
> @@ -824,6 +825,11 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  
>  	/* Did construction of this file fail? */
>  	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> +		if (!retry) {
> +			status = nfserr_jukebox;
> +			goto out;
> +		}
> +		retry = false;
>  		nfsd_file_put_noref(nf);
>  		goto retry;
>  	}
> -- 
> 2.24.1
