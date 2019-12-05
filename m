Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E99F51145B2
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Dec 2019 18:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfLERTZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Dec 2019 12:19:25 -0500
Received: from fieldses.org ([173.255.197.46]:53172 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729450AbfLERTZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 5 Dec 2019 12:19:25 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 34E061513; Thu,  5 Dec 2019 12:19:25 -0500 (EST)
Date:   Thu, 5 Dec 2019 12:19:25 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nfsd: unlock on error in manage_cpntf_state()
Message-ID: <20191205171925.GD22402@fieldses.org>
References: <20191204075935.sgdcxib4jahd5blr@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204075935.sgdcxib4jahd5blr@kili.mountain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 04, 2019 at 10:59:36AM +0300, Dan Carpenter wrote:
> We are holding the "nn->s2s_cp_lock" so we can't return directly
> without unlocking first.

Thanks, applying.

--b.

> 
> Fixes: f3dee17721a0 ("NFSD check stateids against copy stateids")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 296765e693d0..390ad454a229 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5695,13 +5695,16 @@ __be32 manage_cpntf_state(struct nfsd_net *nn, stateid_t *st,
>  	if (cps_t) {
>  		state = container_of(cps_t, struct nfs4_cpntf_state,
>  				     cp_stateid);
> -		if (state->cp_stateid.sc_type != NFS4_COPYNOTIFY_STID)
> -			return nfserr_bad_stateid;
> +		if (state->cp_stateid.sc_type != NFS4_COPYNOTIFY_STID) {
> +			state = NULL;
> +			goto unlock;
> +		}
>  		if (!clp)
>  			refcount_inc(&state->cp_stateid.sc_count);
>  		else
>  			_free_cpntf_state_locked(nn, state);
>  	}
> +unlock:
>  	spin_unlock(&nn->s2s_cp_lock);
>  	if (!state)
>  		return nfserr_bad_stateid;
> -- 
> 2.11.0
