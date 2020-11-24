Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D2D2C3231
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 21:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgKXUt6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 15:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgKXUt6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Nov 2020 15:49:58 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA18C0613D6
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 12:49:57 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id BB75D6E9E; Tue, 24 Nov 2020 15:49:56 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org BB75D6E9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606250996;
        bh=aGxvlEg3oVDYTcBgT6zw8DLo/AL57tGEfqiQpngLLKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c5EOicYzvQs0iG4Mr8/QDoY29jUrwi+GkEMaIdiPgbeJTXoYZtRyQjTat+hRf8J8m
         Wu4buljs/zxrah8TkeEry//lD23iFVvBDSnYG2djFGIFOmiRUbKnRIfMcMAF1aoSKA
         dNWlkQckFroPErfMNCkG8N0Y1qqvGlpJDoBi0/dA=
Date:   Tue, 24 Nov 2020 15:49:56 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: Fix 5 seconds delay when doing inter server copy
Message-ID: <20201124204956.GB7173@fieldses.org>
References: <20201124031609.67297-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124031609.67297-1-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 23, 2020 at 10:16:09PM -0500, Dai Ngo wrote:
> Since commit b4868b44c5628 ("NFSv4: Wait for stateid updates after
> CLOSE/OPEN_DOWNGRADE"), every inter server copy operation suffers 5
> seconds delay regardless of the size of the copy. The delay is from
> nfs_set_open_stateid_locked when the check by nfs_stateid_is_sequential
> fails because the seqid in both nfs4_state and nfs4_stateid are 0.
> 
> Fix by modifying the source server to return the stateid for COPY_NOTIFY
> request with seqid 1 instead of 0. This is also to conform with
> section 4.8 of RFC 7862.
> 
> Here is the relevant paragraph from section 4.8 of RFC 7862:
> 
>    A copy offload stateid's seqid MUST NOT be zero.  In the context of a
>    copy offload operation, it is inappropriate to indicate "the most
>    recent copy offload operation" using a stateid with a seqid of zero
>    (see Section 8.2.2 of [RFC5661]).  It is inappropriate because the
>    stateid refers to internal state in the server and there may be
>    several asynchronous COPY operations being performed in parallel on
>    the same file by the server.  Therefore, a copy offload stateid with
>    a seqid of zero MUST be considered invalid.
> 
> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index d7f27ed6b794..33ee1a6961e3 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -793,6 +793,7 @@ struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
>  	refcount_set(&cps->cp_stateid.sc_count, 1);
>  	if (!nfs4_init_cp_state(nn, &cps->cp_stateid, NFS4_COPYNOTIFY_STID))
>  		goto out_free;
> +	cps->cp_stateid.stid.si_generation = 1;

This affects the stateid returned by COPY_NOTIFY, but not the one
returned by COPY.  I think we wan to add this to nfs4_init_cp_state()
and cover both.

--b.

>  	spin_lock(&nn->s2s_cp_lock);
>  	list_add(&cps->cp_list, &p_stid->sc_cp_list);
>  	spin_unlock(&nn->s2s_cp_lock);
> -- 
> 2.9.5
