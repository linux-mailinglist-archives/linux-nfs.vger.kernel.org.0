Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 047C812F9EA
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 16:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgACPnJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 10:43:09 -0500
Received: from fieldses.org ([173.255.197.46]:50494 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgACPnJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 3 Jan 2020 10:43:09 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 52A361CB4; Fri,  3 Jan 2020 10:43:09 -0500 (EST)
Date:   Fri, 3 Jan 2020 10:43:09 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nfsd: remove unnecessary assertion in
 nfsd4_layout_setlease
Message-ID: <20200103154309.GA23945@fieldses.org>
References: <20191226203733.27808-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191226203733.27808-1-pakki001@umn.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

It took me a minute to see how fl can even fail to be NULL, since we
just accessed fields of fl.

OK, I see, &fl is passed to vfs_setlease, so it can change the value of
fl.

Looks like generic_addlease() clears flp on success, unless it finds an
existing non-conflicting lease?  I'm not clear why nfsd4_layout_setlease
knows it can't hit that case.

In any case, I don't see why this assertion is redundant; leaving it
there.

--b.

On Thu, Dec 26, 2019 at 02:37:33PM -0600, Aditya Pakki wrote:
> In nfsd4_layout_setlease, checking for a valid file lock is
> redundant and can be removed. This patch eliminates such a
> BUG_ON check.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  fs/nfsd/nfs4layouts.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index 2681c70283ce..ef5f8e645f4f 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -204,7 +204,6 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
>  		locks_free_lock(fl);
>  		return status;
>  	}
> -	BUG_ON(fl != NULL);
>  	return 0;
>  }
>  
> -- 
> 2.20.1
