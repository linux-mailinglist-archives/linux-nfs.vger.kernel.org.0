Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 306691154BA
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2019 17:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfLFQAE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Dec 2019 11:00:04 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40786 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfLFQAE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Dec 2019 11:00:04 -0500
Received: by mail-pf1-f193.google.com with SMTP id q8so3537392pfh.7
        for <linux-nfs@vger.kernel.org>; Fri, 06 Dec 2019 08:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yp4NDcto5u3LEI/hPsxbY59xGgx6y4i/6vjXYjtnjow=;
        b=lnAxMEOEHX+2ySVymkjh100nDEHcIL4fsUSOKlWMR5nDBzDCp4AATKxrpWzWyI8Dk4
         zg58wU4yvgBvfrNP1HGcAvWjaydR5zG2JJOEldi2nbebNK0efx4k8YZTKryX3VIvQOyb
         lo74CFW4MxylA/c6L7/iqA0GePoca2b3t8d3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yp4NDcto5u3LEI/hPsxbY59xGgx6y4i/6vjXYjtnjow=;
        b=C41oe99MJBNRmcLmdmOy4O7HF4GKiAwAalJwWYEZ+gWQZrvp8hhHHsAJMAgamn8rz9
         gNyWkEfak9C6xkcYFDNuOIF1x1agpqOF+Mxl8hMqcbO3atjsz4oO57XTwa2HanqtKwcd
         SQS0Ezn32mAlfPNcPHBVEx0VlGKVqw4GNPYrXFdHdvKVPs4NARTIIDNgQqnnt74lsVFE
         2iZc6D+jiBkx1I7h7FYDJBfDX/eDAk25F0gppaIUFkB5vVOSoqmnNYmH7QBNsTZ3k6rt
         /BCvqHllns6FyTyyzO+1Gt9+EQmBRYri3LXLcGKw6MZpQQBaZb1kpOcFlxk3PGjIKq8L
         3JMg==
X-Gm-Message-State: APjAAAWB1w2h2sqxz1AXlBSuyfdQEBKl4TbOr9ovTIRbFYe46VaTCDg3
        LSrk0CLjyrEha61Tojy28blPIg==
X-Google-Smtp-Source: APXvYqypv1DWB8/LOdDKSMQkxkwrrdr8pO+nq2V/VfOTVcMO5ym9WNe6AXU+sPVo6aMYwGOSopGp9Q==
X-Received: by 2002:aa7:9315:: with SMTP id 21mr15127246pfj.187.1575648003565;
        Fri, 06 Dec 2019 08:00:03 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d14sm3740684pjz.12.2019.12.06.08.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 08:00:03 -0800 (PST)
Date:   Fri, 6 Dec 2019 11:00:02 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     madhuparnabhowmik04@gmail.com
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org
Subject: Re: [PATCH 2/2] fs: nfs: dir.c: Fix sparse error
Message-ID: <20191206160002.GB15547@google.com>
References: <20191206151640.10966-1-madhuparnabhowmik04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206151640.10966-1-madhuparnabhowmik04@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

+Paul, here is the dependent patch for the list_prev_rcu() patch Madhuparna
posted.

On Fri, Dec 06, 2019 at 08:46:40PM +0530, madhuparnabhowmik04@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> This patch fixes the following errors:
> fs/nfs/dir.c:2353:14: error: incompatible types in comparison expression (different address spaces):
> fs/nfs/dir.c:2353:14:    struct list_head [noderef] <asn:4> *
> fs/nfs/dir.c:2353:14:    struct list_head *
> 
> caused due to directly accessing the prev pointer of
> a RCU protected list.
> Accessing the pointer using the macro list_prev_rcu() fixes this error.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> ---
>  fs/nfs/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index e180033e35cf..2035254cc283 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2350,7 +2350,7 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
>  	rcu_read_lock();
>  	if (nfsi->cache_validity & NFS_INO_INVALID_ACCESS)
>  		goto out;
> -	lh = rcu_dereference(nfsi->access_cache_entry_lru.prev);
> +	lh = rcu_dereference(list_prev_rcu(&nfsi->access_cache_entry_lru));
>  	cache = list_entry(lh, struct nfs_access_entry, lru);
>  	if (lh == &nfsi->access_cache_entry_lru ||
>  	    cred != cache->cred)
> -- 
> 2.17.1
> 
