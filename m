Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2003F6C372
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2019 01:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfGQXH1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Jul 2019 19:07:27 -0400
Received: from fieldses.org ([173.255.197.46]:59414 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbfGQXH1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 17 Jul 2019 19:07:27 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id C7A431C95; Wed, 17 Jul 2019 19:07:26 -0400 (EDT)
Date:   Wed, 17 Jul 2019 19:07:26 -0400
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     bfields@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 4/8] NFSD add COPY_NOTIFY operation
Message-ID: <20190717230726.GA26801@fieldses.org>
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-5-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708192352.12614-5-olga.kornievskaia@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 08, 2019 at 03:23:48PM -0400, Olga Kornievskaia wrote:
> @@ -726,24 +727,53 @@ struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *sla
>  /*
>   * Create a unique stateid_t to represent each COPY.
>   */
> -int nfs4_init_cp_state(struct nfsd_net *nn, struct nfsd4_copy *copy)
> +static int nfs4_init_cp_state(struct nfsd_net *nn, void *ptr, stateid_t *stid)
>  {
>  	int new_id;
>  
>  	idr_preload(GFP_KERNEL);
>  	spin_lock(&nn->s2s_cp_lock);
> -	new_id = idr_alloc_cyclic(&nn->s2s_cp_stateids, copy, 0, 0, GFP_NOWAIT);
> +	new_id = idr_alloc_cyclic(&nn->s2s_cp_stateids, ptr, 0, 0, GFP_NOWAIT);
>  	spin_unlock(&nn->s2s_cp_lock);
>  	idr_preload_end();
>  	if (new_id < 0)
>  		return 0;
> -	copy->cp_stateid.si_opaque.so_id = new_id;
> -	copy->cp_stateid.si_opaque.so_clid.cl_boot = nn->boot_time;
> -	copy->cp_stateid.si_opaque.so_clid.cl_id = nn->s2s_cp_cl_id;
> +	stid->si_opaque.so_id = new_id;
> +	stid->si_opaque.so_clid.cl_boot = nn->boot_time;
> +	stid->si_opaque.so_clid.cl_id = nn->s2s_cp_cl_id;
>  	return 1;
>  }
>  
> -void nfs4_free_cp_state(struct nfsd4_copy *copy)
> +int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy *copy)
> +{
> +	return nfs4_init_cp_state(nn, copy, &copy->cp_stateid);
> +}

This little bit of refactoring could go into a seperate patch.  It's
easier for me to review lots of smaller patches.

But I don't understand why you're doing it.

Also, I'm a little suspicious of code that doesn't initialize an object
till after it's been added to a global structure.  The more typical
pattern is:


	initialize foo
	take locks, add foo global structure, drop locks.

This prevents anyone doing a lookup from finding "foo" while it's still
in a partially initialized state.

--b.
