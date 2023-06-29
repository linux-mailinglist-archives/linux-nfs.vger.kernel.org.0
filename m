Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DD4742900
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 17:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjF2PA2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 11:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjF2PAW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 11:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD0E2D7F
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 08:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E0A961570
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 15:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4B9C433C8;
        Thu, 29 Jun 2023 15:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688050820;
        bh=EfwCifPGmnutYzUGiIV42Ol+qRL358L5HQ0fi1HEnW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7Vbw8BANtaCXwmPox1EvhHMW8GET6miQwpg7E5g84O/Qr0VJ5SSG7Q921JSlMfc7
         2I+jN3Mfoyk/YV5vnB3CmN2PAom+i2009ARYJqTr1I/yDN06xmzJAx1jDGCb5pd0lI
         aWVC7m1eQURBwZRwafDyEvZocYdrNIXCGaHV5tdEspfHLRUJkqT4AOdyQZ27oTiEsr
         gRJ/fEwZMlQIsrRmZII/1yMpuWWUu34+Vk78CuYJ62ASl45P19Rv4Im+UGv/ZUU4il
         79+4rt3lA0+nYz+fh3OztF8ETPwUGTvpf8v/ahFm88ncHJzFiXi9sd9BwQfSlQjb8i
         9drRFirfgJ1nA==
Date:   Thu, 29 Jun 2023 11:00:18 -0400
From:   Chuck Lever <cel@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v6 3/5] NFSD: handle GETATTR conflict with write
 delegation
Message-ID: <ZJ2cgj9QzrgHExLG@manet.1015granger.net>
References: <1688006176-32597-1-git-send-email-dai.ngo@oracle.com>
 <1688006176-32597-4-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688006176-32597-4-git-send-email-dai.ngo@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 28, 2023 at 07:36:14PM -0700, Dai Ngo wrote:
> If the GETATTR request on a file that has write delegation in effect and
> the request attributes include the change info and size attribute then
> the write delegation is recalled. If the delegation is returned within
> 30ms then the GETATTR is serviced as normal otherwise the NFS4ERR_DELAY
> error is returned for the GETATTR.
>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfs4xdr.c   |  5 ++++
>  fs/nfsd/state.h     |  3 +++
>  3 files changed, 68 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index f971919b04c7..2d2656c41ffb 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -8361,3 +8361,63 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>  {
>  	get_stateid(cstate, &u->write.wr_stateid);
>  }
> +
> +/**
> + * nfsd4_deleg_getattr_conflict - Trigger recall if GETATTR causes conflict
> + * @rqstp: RPC transaction context
> + * @inode: file to be checked for a conflict
> + *
> + * This function is called when there is a conflict between a write
> + * delegation and a change/size GETATR from another client. The server

/GETATR/GETATTR/

> + * must either use the CB_GETATTR to get the current values of the
> + * attributes from the client that hold the delegation or recall the
> + * delegation before replying to the GETATTR. See RFC 8881 section
> + * 18.7.4.

Since you have mentioned CB_GETATTR here, you should also clarify
that our implementation currently does not use it, but eventually we
might implement CB_GETATTR to avoid recalling the delegation due to
this kind of conflict.

Thanks for the thorough comments!


> + *
> + * Returns 0 if there is no conflict; otherwise an nfs_stat
> + * code is returned.
> + */
> +__be32
> +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
> +{
> +	__be32 status;
> +	struct file_lock_context *ctx;
> +	struct file_lock *fl;
> +	struct nfs4_delegation *dp;
> +
> +	ctx = locks_inode_context(inode);
> +	if (!ctx)
> +		return 0;
> +	spin_lock(&ctx->flc_lock);
> +	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
> +		if (fl->fl_flags == FL_LAYOUT)
> +			continue;
> +		if (fl->fl_lmops != &nfsd_lease_mng_ops) {
> +			/*
> +			 * non-nfs lease, if it's a lease with F_RDLCK then
> +			 * we are done; there isn't any write delegation
> +			 * on this inode
> +			 */
> +			if (fl->fl_type == F_RDLCK)
> +				break;
> +			goto break_lease;
> +		}
> +		if (fl->fl_type == F_WRLCK) {
> +			dp = fl->fl_owner;
> +			if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker)) {
> +				spin_unlock(&ctx->flc_lock);
> +				return 0;
> +			}
> +break_lease:
> +			spin_unlock(&ctx->flc_lock);
> +			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> +			if (status != nfserr_jukebox ||
> +					!nfsd_wait_for_delegreturn(rqstp, inode))
> +				return status;
> +			return 0;
> +		}
> +		break;
> +	}
> +	spin_unlock(&ctx->flc_lock);
> +	return 0;
> +}
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 76db2fe29624..b35855c8beb6 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2966,6 +2966,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  		if (status)
>  			goto out;
>  	}
> +	if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> +		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry));
> +		if (status)
> +			goto out;
> +	}
>  
>  	err = vfs_getattr(&path, &stat,
>  			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index d49d3060ed4f..cbddcf484dba 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -732,4 +732,7 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
>  	cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>  	return clp->cl_state == NFSD4_EXPIRABLE;
>  }
> +
> +extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
> +				struct inode *inode);
>  #endif   /* NFSD4_STATE_H */
> -- 
> 2.39.3
> 
