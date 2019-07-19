Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E78336EC53
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jul 2019 00:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfGSWBQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Jul 2019 18:01:16 -0400
Received: from fieldses.org ([173.255.197.46]:58670 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbfGSWBQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 19 Jul 2019 18:01:16 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 6B29A1D39; Fri, 19 Jul 2019 18:01:16 -0400 (EDT)
Date:   Fri, 19 Jul 2019 18:01:16 -0400
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     bfields@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 5/8] NFSD check stateids against copy stateids
Message-ID: <20190719220116.GA24373@fieldses.org>
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-6-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708192352.12614-6-olga.kornievskaia@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 08, 2019 at 03:23:49PM -0400, Olga Kornievskaia wrote:
> Incoming stateid (used by a READ) could be a saved copy stateid.
> On first use make it active and check that the copy has started
> within the allowable lease time.
> 
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfsd/nfs4state.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 2555eb9..b786625 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5232,6 +5232,49 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
>  
>  	return 0;
>  }
> +/*
> + * A READ from an inter server to server COPY will have a
> + * copy stateid. Return the parent nfs4_stid.
> + */
> +static __be32 _find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
> +		     struct nfs4_cpntf_state **cps)
> +{
> +	struct nfs4_cpntf_state *state = NULL;
> +
> +	if (st->si_opaque.so_clid.cl_id != nn->s2s_cp_cl_id)
> +		return nfserr_bad_stateid;
> +	spin_lock(&nn->s2s_cp_lock);
> +	state = idr_find(&nn->s2s_cp_stateids, st->si_opaque.so_id);
> +	if (state)
> +		refcount_inc(&state->cp_p_stid->sc_count);
> +	spin_unlock(&nn->s2s_cp_lock);
> +	if (!state)
> +		return nfserr_bad_stateid;
> +	*cps = state;
> +	return 0;
> +}
> +
> +static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
> +			       struct nfs4_stid **stid)
> +{
> +	__be32 status;
> +	struct nfs4_cpntf_state *cps = NULL;
> +
> +	status = _find_cpntf_state(nn, st, &cps);
> +	if (status)
> +		return status;
> +
> +	/* Did the inter server to server copy start in time? */
> +	if (cps->cp_active == false && !time_after(cps->cp_timeout, jiffies)) {
> +		nfs4_put_stid(cps->cp_p_stid);
> +		return nfserr_partner_no_auth;

I wonder whether instead of checking the time we should instead be
destroying copy stateid's as they expire, so the fact that you were
still able to look up the stateid suggests that it's good.  Or would
that result in returning the wrong error here?  Just curious.

> +	} else
> +		cps->cp_active = true;
> +
> +	*stid = cps->cp_p_stid;

What guarantees that cp_p_stid still points to a valid stateid?  (E.g.
if this is an open stateid that has since been closed.)

--b.

> +
> +	return nfs_ok;
> +}
>  
>  /*
>   * Checks for stateid operations
> @@ -5264,6 +5307,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
>  	status = nfsd4_lookup_stateid(cstate, stateid,
>  				NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID,
>  				&s, nn);
> +	if (status == nfserr_bad_stateid)
> +		status = find_cpntf_state(nn, stateid, &s);
>  	if (status)
>  		return status;
>  	status = nfsd4_stid_check_stateid_generation(stateid, s,
> -- 
> 1.8.3.1
