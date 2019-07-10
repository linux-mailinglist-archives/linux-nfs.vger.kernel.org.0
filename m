Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8C3E63E83
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2019 02:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfGJADB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Jul 2019 20:03:01 -0400
Received: from fieldses.org ([173.255.197.46]:52814 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbfGJADB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 9 Jul 2019 20:03:01 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 7B5B11C9D; Tue,  9 Jul 2019 20:03:00 -0400 (EDT)
Date:   Tue, 9 Jul 2019 20:03:00 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     =?utf-8?B?6buE5LmQ?= <huangle1@jd.com>
Cc:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd4: fix a deadlock on state owner replay mutex
Message-ID: <20190710000300.GD1536@fieldses.org>
References: <720b91b1204b4c73be1b6ec2ff44dbab@jd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <720b91b1204b4c73be1b6ec2ff44dbab@jd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 27, 2019 at 06:30:27PM +0000, 黄乐 wrote:
> from: Huang Le <huangle1@jd.com>
> 
> In move_to_close_lru(), which only be called on path of nfsd4 CLOSE op,
> the code could wait for its stid ref count drop to 2 while holding its
> state owner replay mutex.  However, the other stid ref holder (normally
> a parallel CLOSE op) that move_to_close_lru() is waiting for might be
> accquiring the same replay mutex.
> 
> This patch fix the issue by clearing the replay owner before waiting, and
> assign it back after then.

I don't understand why that's safe.  Maybe it is, but I don't understand
yet.  If we take the mutex, bump the seqid, drop the mutex, someone else
comes in and bumps the seqid again, then we reacquire the mutex... what
happens?

--b.

> 
> Signed-off-by: Huang Le <huangle1@jd.com>
> ---
> 
> I guess we should cc this patch to stable tree, since a malicious client
> could craft parallel CLOSE ops to put all nfsd tasks in D state shortly.
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 618e660..5f6a48f 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3829,12 +3829,12 @@ static void nfs4_free_openowner(struct nfs4_stateowner *so)
>   * them before returning however.
>   */
>  static void
> -move_to_close_lru(struct nfs4_ol_stateid *s, struct net *net)
> +move_to_close_lru(struct nfsd4_compound_state *cstate, struct nfs4_ol_stateid *s,
> +		struct net *net)
>  {
>  	struct nfs4_ol_stateid *last;
>  	struct nfs4_openowner *oo = openowner(s->st_stateowner);
> -	struct nfsd_net *nn = net_generic(s->st_stid.sc_client->net,
> -						nfsd_net_id);
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  
>  	dprintk("NFSD: move_to_close_lru nfs4_openowner %p\n", oo);
>  
> @@ -3846,8 +3846,19 @@ static void nfs4_free_openowner(struct nfs4_stateowner *so)
>  	 * Wait for the refcount to drop to 2. Since it has been unhashed,
>  	 * there should be no danger of the refcount going back up again at
>  	 * this point.
> +	 *
> +	 * Before waiting, we clear cstate->replay_owner to release its
> +	 * so_replay.rp_mutex, since other reference holder might be accquiring
> +	 * the same mutex before they could drop the references.  The replay_owner
> +	 * can be assigned back safely after they done their jobs.
>  	 */
> -	wait_event(close_wq, refcount_read(&s->st_stid.sc_count) == 2);
> +	if (refcount_read(&s->st_stid.sc_count) != 2) {
> +		struct nfs4_stateowner *so = cstate->replay_owner;
> +
> +		nfsd4_cstate_clear_replay(cstate);
> +		wait_event(close_wq, refcount_read(&s->st_stid.sc_count) == 2);
> +		nfsd4_cstate_assign_replay(cstate, so);
> +	}
>  
>  	release_all_access(s);
>  	if (s->st_stid.sc_file) {
> @@ -5531,7 +5542,8 @@ static inline void nfs4_stateid_downgrade(struct nfs4_ol_stateid *stp, u32 to_ac
>  	return status;
>  }
>  
> -static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
> +static void nfsd4_close_open_stateid(struct nfsd4_compound_state *cstate,
> +		struct nfs4_ol_stateid *s)
>  {
>  	struct nfs4_client *clp = s->st_stid.sc_client;
>  	bool unhashed;
> @@ -5549,7 +5561,7 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>  		spin_unlock(&clp->cl_lock);
>  		free_ol_stateid_reaplist(&reaplist);
>  		if (unhashed)
> -			move_to_close_lru(s, clp->net);
> +			move_to_close_lru(cstate, s, clp->net);
>  	}
>  }
>  
> @@ -5587,7 +5599,7 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>  	 */
>  	nfs4_inc_and_copy_stateid(&close->cl_stateid, &stp->st_stid);
>  
> -	nfsd4_close_open_stateid(stp);
> +	nfsd4_close_open_stateid(cstate, stp);
>  	mutex_unlock(&stp->st_mutex);
>  
>  	/* v4.1+ suggests that we send a special stateid in here, since the
