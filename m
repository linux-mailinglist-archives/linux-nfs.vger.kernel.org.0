Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F60741C54F
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Sep 2021 15:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344093AbhI2NP1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Sep 2021 09:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242801AbhI2NP0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Sep 2021 09:15:26 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1A2C06161C;
        Wed, 29 Sep 2021 06:13:45 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id EE4C9AB8; Wed, 29 Sep 2021 09:13:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org EE4C9AB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1632921223;
        bh=NlIvgxM5m93hFWHDs1DDtdJm2ZkdR1b6DDVnj7Z2NJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iV9o6A78vZxoNseK507gTN7oaihJ9ZFoe5ajWPXQ1kFpV6vn75YKMmn02zJMjgmck
         LvSQ5mSOMjI86t3nftzpYSCJvNpuutIGUI5E2vVnDbaWxlhQlpjhkSEg0nfQjQ/YgN
         dve8nanSLmwbnLh/aUZvGQU3tjT7vIftEjrrKG0w=
Date:   Wed, 29 Sep 2021 09:13:43 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dingsenjie@163.com
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, dingsenjie <dingsenjie@yulong.com>
Subject: Re: [PATCH] fs: nfsd: Simplify the return expression of
 numeric_name_to_id
Message-ID: <20210929131343.GA20707@fieldses.org>
References: <20210929091626.11828-1-dingsenjie@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929091626.11828-1-dingsenjie@163.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Well, tastes could reasonably differ, but I'd rather leave this code as
it is.

--b.

On Wed, Sep 29, 2021 at 05:16:26PM +0800, dingsenjie@163.com wrote:
> From: dingsenjie <dingsenjie@yulong.com>
> 
> Simplify the return expression in the nfs4idmap.c
> 
> Signed-off-by: dingsenjie <dingsenjie@yulong.com>
> ---
>  fs/nfsd/nfs4idmap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
> index f92161c..dc5926c 100644
> --- a/fs/nfsd/nfs4idmap.c
> +++ b/fs/nfsd/nfs4idmap.c
> @@ -603,7 +603,6 @@ static __be32 idmap_id_to_name(struct xdr_stream *xdr,
>  static bool
>  numeric_name_to_id(struct svc_rqst *rqstp, int type, const char *name, u32 namelen, u32 *id)
>  {
> -	int ret;
>  	char buf[11];
>  
>  	if (namelen + 1 > sizeof(buf))
> @@ -612,8 +611,7 @@ static __be32 idmap_id_to_name(struct xdr_stream *xdr,
>  	/* Just to make sure it's null-terminated: */
>  	memcpy(buf, name, namelen);
>  	buf[namelen] = '\0';
> -	ret = kstrtouint(buf, 10, id);
> -	return ret == 0;
> +	return kstrtouint(buf, 10, id) == 0;
>  }
>  
>  static __be32
> -- 
> 1.9.1
> 
