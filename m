Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A3B4F9AA9
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Apr 2022 18:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiDHQdq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Apr 2022 12:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiDHQdk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Apr 2022 12:33:40 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530201E1F67
        for <linux-nfs@vger.kernel.org>; Fri,  8 Apr 2022 09:31:36 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C3700BCC; Fri,  8 Apr 2022 12:31:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C3700BCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1649435495;
        bh=EWY0jh11TrH9aqk5EsOxytKtouHAMFeLAqGMZHKuNZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=duo/QkhlnvEVweKyzBrGI5erTJShA4iipOIBbd5/Wet8vLvfMpdk8FMBuCTHRTHgC
         x5lu7u/HHBdh8xvtDk82eGy6wNdt/5UeA9b6BGZVakLl/Ds14G428w3ZjOCDDp39iR
         ha55mSVCNNI5ptbXqygGfO8/UhZL9M3kAZXNMpAM=
Date:   Fri, 8 Apr 2022 12:31:35 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC v20 09/10] NFSD: Update laundromat to handle courtesy
 client
Message-ID: <20220408163135.GA6423@fieldses.org>
References: <1649285133-16765-1-git-send-email-dai.ngo@oracle.com>
 <1649285133-16765-10-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649285133-16765-10-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Apr 06, 2022 at 03:45:32PM -0700, Dai Ngo wrote:
>  static void
>  nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>  				struct laundry_time *lt)
>  {
>  	struct list_head *pos, *next;
>  	struct nfs4_client *clp;
> +	bool cour;
> +	struct list_head cslist;
>  
>  	INIT_LIST_HEAD(reaplist);
> +	INIT_LIST_HEAD(&cslist);
>  	spin_lock(&nn->client_lock);
>  	list_for_each_safe(pos, next, &nn->client_lru) {
>  		clp = list_entry(pos, struct nfs4_client, cl_lru);
>  		if (!state_expired(lt, clp->cl_time))
>  			break;
> -		if (mark_client_expired_locked(clp))
> +
> +		if (!client_has_state(clp))
> +			goto exp_client;
> +
> +		if (clp->cl_cs_client_state == NFSD4_CLIENT_EXPIRED)
> +			goto exp_client;
> +		cour = (clp->cl_cs_client_state == NFSD4_CLIENT_COURTESY);
> +		if (cour && ktime_get_boottime_seconds() >=
> +				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
> +			goto exp_client;
> +		if (nfs4_anylock_blockers(clp)) {
> +exp_client:
> +			if (mark_client_expired_locked(clp))
> +				continue;
> +			list_add(&clp->cl_lru, reaplist);
>  			continue;
> -		list_add(&clp->cl_lru, reaplist);
> +		}
> +		if (!cour) {
> +			spin_lock(&clp->cl_cs_lock);
> +			clp->cl_cs_client_state = NFSD4_CLIENT_COURTESY;
> +			spin_unlock(&clp->cl_cs_lock);
> +			list_add(&clp->cl_cs_list, &cslist);
> +		}
>  	}
>  	spin_unlock(&nn->client_lock);
> +
> +	while (!list_empty(&cslist)) {
> +		clp = list_first_entry(&cslist, struct nfs4_client, cl_cs_list);
> +		list_del_init(&clp->cl_cs_list);
> +		spin_lock(&clp->cl_cs_lock);
> +		/*
> +		 * Client might have re-connected. Make sure it's
> +		 * still in courtesy state before removing its record.
> +		 */

Good to be careful, but, then....

> +		if (clp->cl_cs_client_state != NFSD4_CLIENT_COURTESY) {
> +			spin_unlock(&clp->cl_cs_lock);
> +			continue;
> +		}
> +		spin_unlock(&clp->cl_cs_lock);

.... I'm not seeing what prevents a client from reconnecting right here,
after we drop cl_cs_lock but before we call
nfsd4_client_record_remove().

> +		nfsd4_client_record_remove(clp);
> +	}
>  }
>  
>  static time64_t
> @@ -5794,6 +5876,13 @@ nfs4_laundromat(struct nfsd_net *nn)
>  		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
>  		if (!state_expired(&lt, dp->dl_time))
>  			break;
> +		spin_lock(&clp->cl_cs_lock);
> +		if (clp->cl_cs_client_state == NFSD4_CLIENT_COURTESY) {
> +			clp->cl_cs_client_state = NFSD4_CLIENT_EXPIRED;
> +			spin_unlock(&clp->cl_cs_lock);

In an earlier patch you set the client to EXPIRED as soon as we got a
lease break, so isn't this unnecessary?

I guess there could be a case like:

	1. lease break comes in
	2. client fails to renew, transitions to courtesy
	3. delegation callback times out

though it'd seem better to catch that at step 2 if we can.

--b.

> +			continue;
> +		}
> +		spin_unlock(&clp->cl_cs_lock);
>  		WARN_ON(!unhash_delegation_locked(dp));
>  		list_add(&dp->dl_recall_lru, &reaplist);
>  	}
> -- 
> 2.9.5
