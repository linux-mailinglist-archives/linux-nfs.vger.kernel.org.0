Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAD537AB1B
	for <lists+linux-nfs@lfdr.de>; Tue, 11 May 2021 17:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhEKPuc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 May 2021 11:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhEKPuc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 May 2021 11:50:32 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407F6C061574
        for <linux-nfs@vger.kernel.org>; Tue, 11 May 2021 08:49:26 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 3A8464183; Tue, 11 May 2021 11:49:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 3A8464183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1620748165;
        bh=r/VAXEuHs0VCPjQI6V+vptmbTHgOydnZvii7BBsPXmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nDlqzI47zW5yG8dH6zInxrG7a1uMO30+vwuLXLHrXqaEVJDYOmPRnoc6W+X4SQvhx
         RtmWFJZv2gKcmKAZWBByZ8wYfa0dYrit49TDuJl3dyNubmtE7S+jbPkU9p5LHLSYnx
         iLh70gD3dnU0xcFrD3FhSKdZquij5XqvHGsfUuz0=
Date:   Tue, 11 May 2021 11:49:25 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     dwysocha@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 15/21] NFSD: Add nfsd_clid_verf_mismatch tracepoint
Message-ID: <20210511154925.GA5416@fieldses.org>
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
 <162066199008.94415.3881243902817026664.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162066199008.94415.3881243902817026664.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 10, 2021 at 11:53:10AM -0400, Chuck Lever wrote:
> Record when a client presents a different boot verifier than the
> one we know about. Typically this is a sign the client has
> rebooted, but sometimes it signals a conflicting client ID, which
> the client's administrator will need to address.

Yes.  I suspect this is much more common that the cred mismatch case,
unfortunately.  Without kerberos, we just don't have much to go
on--we're not supposed to use IP address, and the auth_unix cred itself
probably doesn't vary much across clients.

(Patch looks fine, just commenting on that because it's a confusing
point.)

--b.

> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4state.c |   11 ++++++++---
>  fs/nfsd/trace.h     |   32 ++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 4feadb683a2d..56ca79f55da4 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3193,6 +3193,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  			goto out_copy;
>  		}
>  		/* case 5, client reboot */
> +		trace_nfsd_clid_verf_mismatch(conf, rqstp, &verf);
>  		conf = NULL;
>  		goto out_new;
>  	}
> @@ -3988,9 +3989,13 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	if (unconf)
>  		unhash_client_locked(unconf);
>  	/* We need to handle only case 1: probable callback update */
> -	if (conf && same_verf(&conf->cl_verifier, &clverifier)) {
> -		copy_clid(new, conf);
> -		gen_confirm(new, nn);
> +	if (conf) {
> +		if (same_verf(&conf->cl_verifier, &clverifier)) {
> +			copy_clid(new, conf);
> +			gen_confirm(new, nn);
> +		} else
> +			trace_nfsd_clid_verf_mismatch(conf, rqstp,
> +						      &clverifier);
>  	}
>  	new->cl_minorversion = 0;
>  	gen_callback(new, setclid, rqstp);
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 80fd6ca6ae46..2c0392f30a86 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -592,6 +592,38 @@ TRACE_EVENT(nfsd_clid_cred_mismatch,
>  	)
>  )
>  
> +TRACE_EVENT(nfsd_clid_verf_mismatch,
> +	TP_PROTO(
> +		const struct nfs4_client *clp,
> +		const struct svc_rqst *rqstp,
> +		const nfs4_verifier *verf
> +	),
> +	TP_ARGS(clp, rqstp, verf),
> +	TP_STRUCT__entry(
> +		__field(u32, cl_boot)
> +		__field(u32, cl_id)
> +		__array(unsigned char, cl_verifier, NFS4_VERIFIER_SIZE)
> +		__array(unsigned char, new_verifier, NFS4_VERIFIER_SIZE)
> +		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
> +	),
> +	TP_fast_assign(
> +		__entry->cl_boot = clp->cl_clientid.cl_boot;
> +		__entry->cl_id = clp->cl_clientid.cl_id;
> +		memcpy(__entry->cl_verifier, (void *)&clp->cl_verifier,
> +		       NFS4_VERIFIER_SIZE);
> +		memcpy(__entry->new_verifier, (void *)verf,
> +		       NFS4_VERIFIER_SIZE);
> +		memcpy(__entry->addr, &rqstp->rq_xprt->xpt_remote,
> +			sizeof(struct sockaddr_in6));
> +	),
> +	TP_printk("client %08x:%08x verf=0x%s, updated=0x%s from addr=%pISpc",
> +		__entry->cl_boot, __entry->cl_id,
> +		__print_hex_str(__entry->cl_verifier, NFS4_VERIFIER_SIZE),
> +		__print_hex_str(__entry->new_verifier, NFS4_VERIFIER_SIZE),
> +		__entry->addr
> +	)
> +);
> +
>  TRACE_EVENT(nfsd_clid_inuse_err,
>  	TP_PROTO(const struct nfs4_client *clp),
>  	TP_ARGS(clp),
> 
