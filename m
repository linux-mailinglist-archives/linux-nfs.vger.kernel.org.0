Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 410F5C8D67
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Oct 2019 17:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfJBPwV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Oct 2019 11:52:21 -0400
Received: from fieldses.org ([173.255.197.46]:40564 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728735AbfJBPwV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 2 Oct 2019 11:52:21 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id BB8641C97; Wed,  2 Oct 2019 11:52:20 -0400 (EDT)
Date:   Wed, 2 Oct 2019 11:52:20 -0400
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v7 13/19] NFSD return nfs4_stid in
 nfs4_preprocess_stateid_op
Message-ID: <20191002155220.GA19089@fieldses.org>
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
 <20190916211353.18802-14-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916211353.18802-14-olga.kornievskaia@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 16, 2019 at 05:13:47PM -0400, Olga Kornievskaia wrote:
> @@ -1026,7 +1026,8 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
>  static __be32
>  nfsd4_verify_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		  stateid_t *src_stateid, struct nfsd_file **src,
> -		  stateid_t *dst_stateid, struct nfsd_file **dst)
> +		  stateid_t *dst_stateid, struct nfsd_file **dst,
> +		  struct nfs4_stid **stid)
>  {
>  	__be32 status;
>  
...
> @@ -1072,7 +1073,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
>  	__be32 status;
>  
>  	status = nfsd4_verify_copy(rqstp, cstate, &clone->cl_src_stateid, &src,
> -				   &clone->cl_dst_stateid, &dst);
> +				   &clone->cl_dst_stateid, &dst, NULL);
>  	if (status)
>  		goto out;
>  
> @@ -1260,7 +1261,7 @@ static int nfsd4_do_async_copy(void *data)
>  
>  	status = nfsd4_verify_copy(rqstp, cstate, &copy->cp_src_stateid,
>  				   &copy->nf_src, &copy->cp_dst_stateid,
> -				   &copy->nf_dst);
> +				   &copy->nf_dst, NULL);
>  	if (status)
>  		goto out;
>  

So both callers pass NULL for the new stid parameter.  Looks like that's
still true after the full series of patches, too.

--b.
