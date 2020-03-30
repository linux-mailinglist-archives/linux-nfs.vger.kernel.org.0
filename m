Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E0819793A
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2020 12:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgC3KWs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Mar 2020 06:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729241AbgC3KWs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 30 Mar 2020 06:22:48 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF83F206DB;
        Mon, 30 Mar 2020 10:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585563768;
        bh=ZrDA4XEe+oooR3I5ta+CCjaMOqer6mFM9Ab+oPDGTFQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=yOBn3zUZwPtXEVIi9Uv+HHtBnECPA3FReKWBjQlBBWMHqzUCoLq+8v5qLwbohgbQ8
         y+v51Oh3DQ7oPlSmY+48ynaDkDW29wkHS9N6o4jn3z/SvJFRu0hakR4y7W6S1z3++O
         5b9aRl/lYeOLukStHG7Va2PlvNfxc/3/9eNaOibE=
Message-ID: <80e1506f0a997f1f925990fe12c4469947b7b184.camel@kernel.org>
Subject: Re: [PATCH v2] nfsd: memory corruption in nfsd4_lock()
From:   Jeff Layton <jlayton@kernel.org>
To:     Vasily Averin <vvs@virtuozzo.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 30 Mar 2020 06:22:46 -0400
In-Reply-To: <d169e942-03e4-0a4b-8c45-56f4c26cd45c@virtuozzo.com>
References: <7E365A05-4D39-4BF9-8E44-244136173FC7@oracle.com>
         <d169e942-03e4-0a4b-8c45-56f4c26cd45c@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2020-03-27 at 07:50 +0300, Vasily Averin wrote:
> Dear Chuck,
> please use following patch instead.
> -----
> New struct nfsd4_blocked_lock allocated in find_or_allocate_block()
> does not initialized nbl_list and nbl_lru.
> If conflock allocation fails rollback can call list_del_init()
> access uninitialized fields and corrupt memory.
> 
> v2: just initialize nbl_list and nbl_lru right after nbl allocation.
> 
> Fixes: 76d348fadff5 ("nfsd: have nfsd4_lock use blocking locks for v4.1+ lock")
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  fs/nfsd/nfs4state.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 369e574c5092..1b2eb6b35d64 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -266,6 +266,8 @@ find_or_allocate_block(struct nfs4_lockowner *lo, struct knfsd_fh *fh,
>  	if (!nbl) {
>  		nbl= kmalloc(sizeof(*nbl), GFP_KERNEL);
>  		if (nbl) {
> +			INIT_LIST_HEAD(&nbl->nbl_list);
> +			INIT_LIST_HEAD(&nbl->nbl_lru);
>  			fh_copy_shallow(&nbl->nbl_fh, fh);
>  			locks_init_lock(&nbl->nbl_lock);
>  			nfsd4_init_cb(&nbl->nbl_cb, lo->lo_owner.so_client,

Reviewed-by: Jeff Layton <jlayton@kernel.org>

