Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF4562E84
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2019 05:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfGIDOF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 23:14:05 -0400
Received: from fieldses.org ([173.255.197.46]:38332 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfGIDOF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 8 Jul 2019 23:14:05 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id B01192013; Mon,  8 Jul 2019 23:14:04 -0400 (EDT)
Date:   Mon, 8 Jul 2019 23:14:04 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Joe Perches <joe@perches.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] nfsd: Fix misuse of strlcpy
Message-ID: <20190709031404.GD14439@fieldses.org>
References: <cover.1562283944.git.joe@perches.com>
 <b51141d12de77eb22101e81f9eb2c9cc44104d7a.1562283944.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b51141d12de77eb22101e81f9eb2c9cc44104d7a.1562283944.git.joe@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 04, 2019 at 04:57:48PM -0700, Joe Perches wrote:
> Probable cut&paste typo - use the correct field size.

Huh, that's been there forever, I wonder why we haven't seen crashes?
Oh, I see, name and authname both have the same size.

Anyway, makes sense, thanks.  Will apply for 5.3.

(Unless someone else is getting this; I didn't get copied on the rest of
the series.)

--b.

> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  fs/nfsd/nfs4idmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
> index 2961016097ac..d1f285245af8 100644
> --- a/fs/nfsd/nfs4idmap.c
> +++ b/fs/nfsd/nfs4idmap.c
> @@ -83,7 +83,7 @@ ent_init(struct cache_head *cnew, struct cache_head *citm)
>  	new->type = itm->type;
>  
>  	strlcpy(new->name, itm->name, sizeof(new->name));
> -	strlcpy(new->authname, itm->authname, sizeof(new->name));
> +	strlcpy(new->authname, itm->authname, sizeof(new->authname));
>  }
>  
>  static void
> -- 
> 2.15.0
