Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC075249F7
	for <lists+linux-nfs@lfdr.de>; Thu, 12 May 2022 12:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351990AbiELKHg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 May 2022 06:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345766AbiELKHf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 May 2022 06:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E1EF36334
        for <linux-nfs@vger.kernel.org>; Thu, 12 May 2022 03:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652350052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R3b33V4KBr+OrqnqliMan9aY9CziFpRIWpp3d5JkrO0=;
        b=ZqQr0k5xFfPh2ArYMLMOyc7d/OTB/OLEjVdjIwVcduDjrsZ9Tn+q4LrfNl1N/KavWYmILS
        bGXXuIC02yRqlMInkFNKtkkt0z3JdeEiFEeVeChKtit1bCgVe68QQ6+T50CDqELxm24TwA
        FaimbmKdxCVzDeZND3RnRJsoA5jxAdA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-QH6h7q-FMzG_P2ragEjEYg-1; Thu, 12 May 2022 06:07:31 -0400
X-MC-Unique: QH6h7q-FMzG_P2ragEjEYg-1
Received: by mail-qt1-f200.google.com with SMTP id ay35-20020a05622a22a300b002f3fdcb1bb1so259081qtb.8
        for <linux-nfs@vger.kernel.org>; Thu, 12 May 2022 03:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=R3b33V4KBr+OrqnqliMan9aY9CziFpRIWpp3d5JkrO0=;
        b=CQoTr5v2WG+/nHJBwg9eZyE0ECbPYejQNCwaQFPpQlVqaoZeRmhjcyPP3sOb0eI9TJ
         8kksGLD3ar2ete23PpQTvQKPe4c8C6vlxYWRVuk52JaYIXPd/NJ5LHtfZIyMV4TQ5R4p
         xmTK4r1oujuT+gurO0PImP3PgTlGsJkZ/KMiP/Q6IZg59m5Ua7/Mpf7ppfiVmDdAnGyp
         qY8fE7TvZUJy46TbuujjLQjB25R3GOGnmKNnWN/hIdW4mbqvt5v2BCLl8Vte9sjZ/xF+
         qfPQ6oTRMCf3S14MctnrvWI54SBECEbUm9graP5HPfjO1kk8EVeEhf0vDfOlR3eXzgFh
         vVoA==
X-Gm-Message-State: AOAM533E8XIK7yFcpjz6pTDDcv14PlZFjp3qsXYzgnEefbPu47X/6Cqh
        e9cOdfxBZ9R+Fj9lsNeru0ST65z8N3Heyaoux2EYIBLnvyTAshVemJmLzZtCPkOVI/egZwofR2m
        FjXmHwAKjCsXJTEN6nkOo
X-Received: by 2002:a05:6214:19c5:b0:45a:e0e5:d37b with SMTP id j5-20020a05621419c500b0045ae0e5d37bmr25643175qvc.100.1652350050912;
        Thu, 12 May 2022 03:07:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdZpgBUaoLLGuCCxIXq5yAlWegvB8YCl7Jx9OtjCy4w2NNS7LYV3e1ZK92W4TAhSj7qE3jAg==
X-Received: by 2002:a05:6214:19c5:b0:45a:e0e5:d37b with SMTP id j5-20020a05621419c500b0045ae0e5d37bmr25643163qvc.100.1652350050694;
        Thu, 12 May 2022 03:07:30 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a13af00b0069fe7f77e4bsm2718991qki.33.2022.05.12.03.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 03:07:30 -0700 (PDT)
Message-ID: <8e19f02252305f718c104d21ff1910c13eee437b.camel@redhat.com>
Subject: Re: [PATCH RFC 1/2] NFSD: nfsd4_release_lockowner() should drop
 clp->cl_lock sooner
From:   Jeff Layton <jlayton@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com, bfields@fieldses.org, dai.ngo@oracle.com
Date:   Thu, 12 May 2022 06:07:29 -0400
In-Reply-To: <165230597191.5906.5961060184718742042.stgit@klimt.1015granger.net>
References: <165230584037.5906.5496655737644872339.stgit@klimt.1015granger.net>
         <165230597191.5906.5961060184718742042.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2022-05-11 at 17:52 -0400, Chuck Lever wrote:
> nfsd4_release_lockowner() mustn't hold clp->cl_lock when
> check_for_locks() invokes nfsd_file_put(), which can sleep.
> 
> Reported-by: Dai Ngo <dai.ngo@oracle.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Cc: <stable@vger.kernel.org>
> ---
>  fs/nfsd/nfs4state.c |   56 +++++++++++++++++++++++----------------------------
>  1 file changed, 25 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 234e852fcdfa..e2eb6d031643 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6611,8 +6611,8 @@ nfs4_set_lock_denied(struct file_lock *fl, struct nfsd4_lock_denied *deny)
>  		deny->ld_type = NFS4_WRITE_LT;
>  }
>  
> -static struct nfs4_lockowner *
> -find_lockowner_str_locked(struct nfs4_client *clp, struct xdr_netobj *owner)
> +static struct nfs4_stateowner *
> +find_stateowner_str_locked(struct nfs4_client *clp, struct xdr_netobj *owner)
>  {
>  	unsigned int strhashval = ownerstr_hashval(owner);
>  	struct nfs4_stateowner *so;
> @@ -6624,11 +6624,22 @@ find_lockowner_str_locked(struct nfs4_client *clp, struct xdr_netobj *owner)
>  		if (so->so_is_open_owner)
>  			continue;
>  		if (same_owner_str(so, owner))
> -			return lockowner(nfs4_get_stateowner(so));
> +			return nfs4_get_stateowner(so);
>  	}
>  	return NULL;
>  }
>  
> +static struct nfs4_lockowner *
> +find_lockowner_str_locked(struct nfs4_client *clp, struct xdr_netobj *owner)
> +{
> +	struct nfs4_stateowner *so;
> +
> +	so = find_stateowner_str_locked(clp, owner);
> +	if (!so)
> +		return NULL;
> +	return lockowner(so);
> +}
> +
>  static struct nfs4_lockowner *
>  find_lockowner_str(struct nfs4_client *clp, struct xdr_netobj *owner)
>  {
> @@ -7305,10 +7316,8 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
>  	struct nfsd4_release_lockowner *rlockowner = &u->release_lockowner;
>  	clientid_t *clid = &rlockowner->rl_clientid;
>  	struct nfs4_stateowner *sop;
> -	struct nfs4_lockowner *lo = NULL;
> +	struct nfs4_lockowner *lo;
>  	struct nfs4_ol_stateid *stp;
> -	struct xdr_netobj *owner = &rlockowner->rl_owner;
> -	unsigned int hashval = ownerstr_hashval(owner);
>  	__be32 status;
>  	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>  	struct nfs4_client *clp;
> @@ -7322,32 +7331,18 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
>  		return status;
>  
>  	clp = cstate->clp;
> -	/* Find the matching lock stateowner */
>  	spin_lock(&clp->cl_lock);
> -	list_for_each_entry(sop, &clp->cl_ownerstr_hashtbl[hashval],
> -			    so_strhash) {
> -
> -		if (sop->so_is_open_owner || !same_owner_str(sop, owner))
> -			continue;
> -
> -		/* see if there are still any locks associated with it */
> -		lo = lockowner(sop);
> -		list_for_each_entry(stp, &sop->so_stateids, st_perstateowner) {
> -			if (check_for_locks(stp->st_stid.sc_file, lo)) {
> -				status = nfserr_locks_held;
> -				spin_unlock(&clp->cl_lock);
> -				return status;
> -			}
> -		}
> +	sop = find_stateowner_str_locked(clp, &rlockowner->rl_owner);
> +	spin_unlock(&clp->cl_lock);
> +	if (!sop)
> +		return nfs_ok;
>  
> -		nfs4_get_stateowner(sop);
> -		break;
> -	}
> -	if (!lo) {
> -		spin_unlock(&clp->cl_lock);
> -		return status;
> -	}
> +	lo = lockowner(sop);
> +	list_for_each_entry(stp, &sop->so_stateids, st_perstateowner)
> +		if (check_for_locks(stp->st_stid.sc_file, lo))
> +			return nfserr_locks_held;
>  

It has been a while since I was in this code, but is it safe to walk the
above list without holding the cl_lock?

> +	spin_lock(&clp->cl_lock);
>  	unhash_lockowner_locked(lo);
>  	while (!list_empty(&lo->lo_owner.so_stateids)) {
>  		stp = list_first_entry(&lo->lo_owner.so_stateids,
> @@ -7360,8 +7355,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
>  	free_ol_stateid_reaplist(&reaplist);
>  	remove_blocked_locks(lo);
>  	nfs4_put_stateowner(&lo->lo_owner);
> -
> -	return status;
> +	return nfs_ok;
>  }
>  
>  static inline struct nfs4_client_reclaim *
> 
> 

-- 
Jeff Layton <jlayton@redhat.com>

