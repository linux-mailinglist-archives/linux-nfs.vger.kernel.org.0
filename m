Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538462C91FD
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 00:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgK3XFm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 18:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgK3XFm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 18:05:42 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB61C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 15:05:02 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id CD99667C6; Mon, 30 Nov 2020 18:05:01 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CD99667C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606777501;
        bh=ftd/P3nH/Jp0D6zznyjgpSWbkf1PQFvp6hx/0FQY38s=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=lSefEbgjtrewxwqBTqAbI+AARl2y37VSK9G9m1sqUnU1oUuXmU4WU/S0qSeS50fyM
         SpZSxJSIdIje0IPpWhET0rPSEAwZufyviG3oH2l5Pj6EsblUqh7RjQ8V6MfsRkg55j
         Ds+n7IWh5K8RsVvCpoGfcbbp2UxtSfkaAsVRbxuY=
Date:   Mon, 30 Nov 2020 18:05:01 -0500
To:     trondmy@kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 5/6] nfsd: Fix up nfsd to ensure that timeout errors
 don't result in ESTALE
Message-ID: <20201130230501.GC22446@fieldses.org>
References: <20201130212455.254469-1-trondmy@kernel.org>
 <20201130212455.254469-2-trondmy@kernel.org>
 <20201130212455.254469-3-trondmy@kernel.org>
 <20201130212455.254469-4-trondmy@kernel.org>
 <20201130212455.254469-5-trondmy@kernel.org>
 <20201130212455.254469-6-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130212455.254469-6-trondmy@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 30, 2020 at 04:24:54PM -0500, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> If the underlying filesystem times out, then we want knfsd to return
> NFSERR_JUKEBOX/DELAY rather than NFSERR_STALE.

Out of curiosity, what was causing ETIMEDOUT in practice?

--b.

> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfsd/nfsfh.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 0c2ee65e46f3..46c86f7bc429 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -268,12 +268,20 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
>  	if (fileid_type == FILEID_ROOT)
>  		dentry = dget(exp->ex_path.dentry);
>  	else {
> -		dentry = exportfs_decode_fh(exp->ex_path.mnt, fid,
> -				data_left, fileid_type,
> -				nfsd_acceptable, exp);
> -		if (IS_ERR_OR_NULL(dentry))
> +		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
> +						data_left, fileid_type,
> +						nfsd_acceptable, exp);
> +		if (IS_ERR_OR_NULL(dentry)) {
>  			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
>  					dentry ?  PTR_ERR(dentry) : -ESTALE);
> +			switch (PTR_ERR(dentry)) {
> +			case -ENOMEM:
> +			case -ETIMEDOUT:
> +				break;
> +			default:
> +				dentry = ERR_PTR(-ESTALE);
> +			}
> +		}
>  	}
>  	if (dentry == NULL)
>  		goto out;
> -- 
> 2.28.0
