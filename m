Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3997779D487
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 17:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbjILPNv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Sep 2023 11:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbjILPNu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Sep 2023 11:13:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A6BCC3
        for <linux-nfs@vger.kernel.org>; Tue, 12 Sep 2023 08:13:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303E5C433C8;
        Tue, 12 Sep 2023 15:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694531626;
        bh=2L5Bh1G8YCmECxIJnsFzVig/S0IZ4CVAWBpDmSDebTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dbRVB3AlRvUVWAQA6Dj1F2x7Rl9KDZaVcxb/+z8e2+/eSJegJltepUof0VPErIT2b
         tAAb3FOebHzyzMsb2l5hIqHaz4r5xTDtXzLos3H7hPahs3Ta2IBXoMPeE1tLNtkURd
         vZ664z3ZnZtRCTtdTLiLXCyD/0VaivqxnNNwi+w+0DW6k2+/OlR3XzEDUxFWvgPMkz
         FPfgtXqcfQIuCcrFFeHWRS4+E8e+0EuMVWPE7610CW9CYpkJwtEJVCa7WJgDPp58o6
         hnITEQHCd65yfe6NVy7+0tTjDLI5QYuawgv8i2eGdHR9XNBZ0dLoSH49VWjtXJmzku
         3MssGYna6kkjA==
Date:   Tue, 12 Sep 2023 17:13:40 +0200
From:   Simon Horman <horms@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        netdev@vger.kernel.org
Subject: Re: [PATCH v8 3/3] NFSD: add rpc_status netlink support
Message-ID: <20230912151340.GH401982@kernel.org>
References: <cover.1694436263.git.lorenzo@kernel.org>
 <ac18892ea3f718c63f0a12e39aeaac812c081515.1694436263.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac18892ea3f718c63f0a12e39aeaac812c081515.1694436263.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 11, 2023 at 02:49:46PM +0200, Lorenzo Bianconi wrote:
> Introduce rpc_status netlink support for NFSD in order to dump pending
> RPC requests debugging information from userspace.
> 
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
o
Hi Lorenzo,

some minor feedback from my side.

...

>  int nfsd_server_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>  					 struct netlink_callback *cb)
>  {
> +	struct nfsd_net *nn = net_generic(sock_net(skb->sk), nfsd_net_id);
> +	int i, ret, rqstp_index;
> +
> +	rcu_read_lock();
> +
> +	for (i = 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> +		struct svc_rqst *rqstp;
> +
> +		if (i < cb->args[0]) /* already consumed */
> +			continue;
> +
> +		rqstp_index = 0;
> +		list_for_each_entry_rcu(rqstp,
> +				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
> +				rq_all) {
> +			struct nfsd_genl_rqstp genl_rqstp;
> +			unsigned int status_counter;
> +
> +			if (rqstp_index++ < cb->args[1]) /* already consumed */
> +				continue;
> +			/*
> +			 * Acquire rq_status_counter before parsing the rqst
> +			 * fields. rq_status_counter is set to an odd value in
> +			 * order to notify the consumers the rqstp fields are
> +			 * meaningful.
> +			 */
> +			status_counter =
> +				smp_load_acquire(&rqstp->rq_status_counter);
> +			if (!(status_counter & 1))
> +				continue;
> +
> +			genl_rqstp.rq_xid = rqstp->rq_xid;
> +			genl_rqstp.rq_flags = rqstp->rq_flags;
> +			genl_rqstp.rq_vers = rqstp->rq_vers;
> +			genl_rqstp.rq_prog = rqstp->rq_prog;
> +			genl_rqstp.rq_proc = rqstp->rq_proc;
> +			genl_rqstp.rq_stime = rqstp->rq_stime;
> +			genl_rqstp.opcnt = 0;
> +			memcpy(&genl_rqstp.daddr, svc_daddr(rqstp),
> +			       sizeof(struct sockaddr));
> +			memcpy(&genl_rqstp.saddr, svc_addr(rqstp),
> +			       sizeof(struct sockaddr));
> +
> +#ifdef CONFIG_NFSD_V4
> +			if (rqstp->rq_vers == NFS4_VERSION &&
> +			    rqstp->rq_proc == NFSPROC4_COMPOUND) {
> +				/* NFSv4 compund */

nit: compound

> +				struct nfsd4_compoundargs *args;
> +				int j;
> +
> +				args = rqstp->rq_argp;
> +				genl_rqstp.opcnt = args->opcnt;
> +				for (j = 0; j < genl_rqstp.opcnt; j++)
> +					genl_rqstp.opnum[j] =
> +						args->ops[j].opnum;
> +			}
> +#endif /* CONFIG_NFSD_V4 */
> +
> +			/*
> +			 * Acquire rq_status_counter before reporting the rqst
> +			 * fields to the user.
> +			 */
> +			if (smp_load_acquire(&rqstp->rq_status_counter) !=
> +			    status_counter)
> +				continue;
> +
> +			ret = nfsd_genl_rpc_status_compose_msg(skb, cb,
> +							       &genl_rqstp);
> +			if (ret)
> +				goto out;
> +		}
> +	}
> +
> +	cb->args[0] = i;
> +	cb->args[1] = rqstp_index;

I'm unsure if this is possible, but if the for loop above iterates zero
times, or for all iterations (i < cb->args[0]), then rqstp_index will
be used uninitialised here.

Flagged by Smatch.

> +	ret = skb->len;
> +out:
> +	rcu_read_unlock();
> +
> +	return ret;
> +}

...

> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 11c14faa6c67..d787bd38c053 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -62,6 +62,22 @@ struct readdir_cd {
>  	__be32			err;	/* 0, nfserr, or nfserr_eof */
>  };
>  
> +/* Maximum number of operations per session compound */
> +#define NFSD_MAX_OPS_PER_COMPOUND	50
> +
> +struct nfsd_genl_rqstp {
> +	struct sockaddr daddr;
> +	struct sockaddr saddr;
> +	unsigned long rq_flags;
> +	ktime_t rq_stime;
> +	__be32 rq_xid;
> +	u32 rq_vers;
> +	u32 rq_prog;
> +	u32 rq_proc;
> +	/* NFSv4 compund */

nit: compound

> +	u32 opnum[NFSD_MAX_OPS_PER_COMPOUND];
> +	u16 opcnt;
> +};
>  
>  extern struct svc_program	nfsd_program;
>  extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;

...
