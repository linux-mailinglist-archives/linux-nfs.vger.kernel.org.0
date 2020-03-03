Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C46C177C79
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Mar 2020 17:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgCCQyv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Mar 2020 11:54:51 -0500
Received: from fieldses.org ([173.255.197.46]:37344 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbgCCQyu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Mar 2020 11:54:50 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 628351C22; Tue,  3 Mar 2020 11:54:50 -0500 (EST)
Date:   Tue, 3 Mar 2020 11:54:50 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     madhuparnabhowmik10@gmail.com
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org
Subject: Re: [PATCH] fs: nfsd: fileache.c: Use built-in RCU list checking
Message-ID: <20200303165450.GD19140@fieldses.org>
References: <20200213150359.5819-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213150359.5819-1-madhuparnabhowmik10@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Applying for 5.7, thanks.--b.

On Thu, Feb 13, 2020 at 08:33:59PM +0530, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> list_for_each_entry_rcu() has built-in RCU and lock checking.
> 
> Pass cond argument to list_for_each_entry_rcu() to silence
> false lockdep warning when  CONFIG_PROVE_RCU_LIST is enabled
> by default.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> ---
>  fs/nfsd/filecache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 32a9bf22ac08..547d2d8bde62 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -736,7 +736,7 @@ nfsd_file_find_locked(struct inode *inode, unsigned int may_flags,
>  	unsigned char need = may_flags & NFSD_FILE_MAY_MASK;
>  
>  	hlist_for_each_entry_rcu(nf, &nfsd_file_hashtbl[hashval].nfb_head,
> -				 nf_node) {
> +				 nf_node, lockdep_is_held(&nfsd_file_hashtbl[hashval].nfb_lock)) {
>  		if ((need & nf->nf_may) != need)
>  			continue;
>  		if (nf->nf_inode != inode)
> -- 
> 2.17.1
