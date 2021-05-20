Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16FF38B5F8
	for <lists+linux-nfs@lfdr.de>; Thu, 20 May 2021 20:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhETSaZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 May 2021 14:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhETSaY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 May 2021 14:30:24 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E29C061574
        for <linux-nfs@vger.kernel.org>; Thu, 20 May 2021 11:29:03 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id CFFAA1C81; Thu, 20 May 2021 14:29:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CFFAA1C81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1621535341;
        bh=A/E54ArV0aD9M9GeHB0g00/yWPcrte5yH35x37noS1c=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=hP1B2rgEJb2F6bhcoTZVjyL13W3gOYfGWrCbL4HLzW/I/GeRDSmTjHmH/NBzA5AyT
         T9NVu70LSuFn9UTGFN1lhqcyLdr4j5OQzr/kWTcQNqR8x3ZWyH5wBlrsYbSimXEgmJ
         N6+K6qfbOBcfcyeiI9zO1IJjV0sw1m6ftneBjUIc=
Date:   Thu, 20 May 2021 14:29:01 -0400
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/4] NFSv4: Fix delegation return in cases where we have
 to retry
Message-ID: <20210520182901.GA8759@fieldses.org>
References: <20210520163902.215745-1-trondmy@kernel.org>
 <20210520163902.215745-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520163902.215745-2-trondmy@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 20, 2021 at 12:38:59PM -0400, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> If we're unable to immediately recover all locks because the server is
> unable to immediately service our reclaim calls, then we want to retry
> after we've finished servicing all the other asynchronous delegation
> returns on our queue.

So, there's a situation where the server can't service a reclaim until
some other delegation is returned?  I'm not seeing how that happens.

--b.

> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/delegation.c | 71 +++++++++++++++++++++++++++++++++++----------
>  fs/nfs/delegation.h |  1 +
>  fs/nfs/nfs4_fs.h    |  1 +
>  3 files changed, 58 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
> index e6ec6f09ac6e..7c45ac3c3b0b 100644
> --- a/fs/nfs/delegation.c
> +++ b/fs/nfs/delegation.c
> @@ -75,6 +75,13 @@ void nfs_mark_delegation_referenced(struct nfs_delegation *delegation)
>  	set_bit(NFS_DELEGATION_REFERENCED, &delegation->flags);
>  }
>  
> +static void nfs_mark_return_delegation(struct nfs_server *server,
> +				       struct nfs_delegation *delegation)
> +{
> +	set_bit(NFS_DELEGATION_RETURN, &delegation->flags);
> +	set_bit(NFS4CLNT_DELEGRETURN, &server->nfs_client->cl_state);
> +}
> +
>  static bool
>  nfs4_is_valid_delegation(const struct nfs_delegation *delegation,
>  		fmode_t flags)
> @@ -293,6 +300,7 @@ nfs_start_delegation_return_locked(struct nfs_inode *nfsi)
>  		goto out;
>  	spin_lock(&delegation->lock);
>  	if (!test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
> +		clear_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags);
>  		/* Refcount matched in nfs_end_delegation_return() */
>  		ret = nfs_get_delegation(delegation);
>  	}
> @@ -314,16 +322,17 @@ nfs_start_delegation_return(struct nfs_inode *nfsi)
>  	return delegation;
>  }
>  
> -static void
> -nfs_abort_delegation_return(struct nfs_delegation *delegation,
> -		struct nfs_client *clp)
> +static void nfs_abort_delegation_return(struct nfs_delegation *delegation,
> +					struct nfs_client *clp, int err)
>  {
>  
>  	spin_lock(&delegation->lock);
>  	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
> -	set_bit(NFS_DELEGATION_RETURN, &delegation->flags);
> +	if (err == -EAGAIN) {
> +		set_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags);
> +		set_bit(NFS4CLNT_DELEGRETURN_DELAYED, &clp->cl_state);
> +	}
>  	spin_unlock(&delegation->lock);
> -	set_bit(NFS4CLNT_DELEGRETURN, &clp->cl_state);
>  }
>  
>  static struct nfs_delegation *
> @@ -539,7 +548,7 @@ static int nfs_end_delegation_return(struct inode *inode, struct nfs_delegation
>  	} while (err == 0);
>  
>  	if (err) {
> -		nfs_abort_delegation_return(delegation, clp);
> +		nfs_abort_delegation_return(delegation, clp, err);
>  		goto out;
>  	}
>  
> @@ -568,6 +577,7 @@ static bool nfs_delegation_need_return(struct nfs_delegation *delegation)
>  	if (ret)
>  		clear_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags);
>  	if (test_bit(NFS_DELEGATION_RETURNING, &delegation->flags) ||
> +	    test_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags) ||
>  	    test_bit(NFS_DELEGATION_REVOKED, &delegation->flags))
>  		ret = false;
>  
> @@ -647,6 +657,38 @@ static int nfs_server_return_marked_delegations(struct nfs_server *server,
>  	return err;
>  }
>  
> +static bool nfs_server_clear_delayed_delegations(struct nfs_server *server)
> +{
> +	struct nfs_delegation *d;
> +	bool ret = false;
> +
> +	list_for_each_entry_rcu (d, &server->delegations, super_list) {
> +		if (!test_bit(NFS_DELEGATION_RETURN_DELAYED, &d->flags))
> +			continue;
> +		nfs_mark_return_delegation(server, d);
> +		clear_bit(NFS_DELEGATION_RETURN_DELAYED, &d->flags);
> +		ret = true;
> +	}
> +	return ret;
> +}
> +
> +static bool nfs_client_clear_delayed_delegations(struct nfs_client *clp)
> +{
> +	struct nfs_server *server;
> +	bool ret = false;
> +
> +	if (!test_and_clear_bit(NFS4CLNT_DELEGRETURN_DELAYED, &clp->cl_state))
> +		goto out;
> +	rcu_read_lock();
> +	list_for_each_entry_rcu (server, &clp->cl_superblocks, client_link) {
> +		if (nfs_server_clear_delayed_delegations(server))
> +			ret = true;
> +	}
> +	rcu_read_unlock();
> +out:
> +	return ret;
> +}
> +
>  /**
>   * nfs_client_return_marked_delegations - return previously marked delegations
>   * @clp: nfs_client to process
> @@ -659,8 +701,14 @@ static int nfs_server_return_marked_delegations(struct nfs_server *server,
>   */
>  int nfs_client_return_marked_delegations(struct nfs_client *clp)
>  {
> -	return nfs_client_for_each_server(clp,
> -			nfs_server_return_marked_delegations, NULL);
> +	int err = nfs_client_for_each_server(
> +		clp, nfs_server_return_marked_delegations, NULL);
> +	if (err)
> +		return err;
> +	/* If a return was delayed, sleep to prevent hard looping */
> +	if (nfs_client_clear_delayed_delegations(clp))
> +		ssleep(1);
> +	return 0;
>  }
>  
>  /**
> @@ -775,13 +823,6 @@ static void nfs_mark_return_if_closed_delegation(struct nfs_server *server,
>  	set_bit(NFS4CLNT_DELEGRETURN, &server->nfs_client->cl_state);
>  }
>  
> -static void nfs_mark_return_delegation(struct nfs_server *server,
> -		struct nfs_delegation *delegation)
> -{
> -	set_bit(NFS_DELEGATION_RETURN, &delegation->flags);
> -	set_bit(NFS4CLNT_DELEGRETURN, &server->nfs_client->cl_state);
> -}
> -
>  static bool nfs_server_mark_return_all_delegations(struct nfs_server *server)
>  {
>  	struct nfs_delegation *delegation;
> diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
> index c19b4fd20781..1c378992b7c0 100644
> --- a/fs/nfs/delegation.h
> +++ b/fs/nfs/delegation.h
> @@ -36,6 +36,7 @@ enum {
>  	NFS_DELEGATION_REVOKED,
>  	NFS_DELEGATION_TEST_EXPIRED,
>  	NFS_DELEGATION_INODE_FREEING,
> +	NFS_DELEGATION_RETURN_DELAYED,
>  };
>  
>  int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
> diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
> index 065cb04222a1..4c44322c2643 100644
> --- a/fs/nfs/nfs4_fs.h
> +++ b/fs/nfs/nfs4_fs.h
> @@ -45,6 +45,7 @@ enum nfs4_client_state {
>  	NFS4CLNT_RECALL_RUNNING,
>  	NFS4CLNT_RECALL_ANY_LAYOUT_READ,
>  	NFS4CLNT_RECALL_ANY_LAYOUT_RW,
> +	NFS4CLNT_DELEGRETURN_DELAYED,
>  };
>  
>  #define NFS4_RENEW_TIMEOUT		0x01
> -- 
> 2.31.1
