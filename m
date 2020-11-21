Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5902BBB0C
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Nov 2020 01:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgKUAeh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 19:34:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727855AbgKUAeh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 20 Nov 2020 19:34:37 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF85C23A65;
        Sat, 21 Nov 2020 00:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605918877;
        bh=nPsrTlHbTt4V41wLRoXUl9wd3VGtww3QpUsAJZ5Jz7Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PyCd5CVDjdyLPfJ9m7Y5AbKj7t2lAw+ZPsasgrtnetZPA5g2urx1P+3p8bYDL+1cE
         7EdcpVshZfsko+pSKJl+hGK7JJyUSeKNhK/K4KXtC2Xpe+v6IysowOQpHFv9vbwv2T
         XZjYiD4fxBSFN+9tqT33mApSqtpUKWLw9oeL7V5k=
Message-ID: <761df9cadb497de177eb29bb407061f6e213e75c.camel@kernel.org>
Subject: Re: [PATCH 3/8] nfsd: minor nfsd4_change_attribute cleanup
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Date:   Fri, 20 Nov 2020 19:34:35 -0500
In-Reply-To: <1605911960-12516-3-git-send-email-bfields@redhat.com>
References: <20201120223831.GB7705@fieldses.org>
         <1605911960-12516-1-git-send-email-bfields@redhat.com>
         <1605911960-12516-3-git-send-email-bfields@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2020-11-20 at 17:39 -0500, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> Minor cleanup, no change in behavior
> 
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  fs/nfsd/nfsfh.h | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 3faf5974fa4e..45bd776290d5 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -259,19 +259,16 @@ fh_clear_wcc(struct svc_fh *fhp)
>  static inline u64 nfsd4_change_attribute(struct kstat *stat,
>  					 struct inode *inode)
>  {
> -	u64 chattr;
> -
>  	if (IS_I_VERSION(inode)) {
> +		u64 chattr;
> +
>  		chattr =  stat->ctime.tv_sec;
>  		chattr <<= 30;
>  		chattr += stat->ctime.tv_nsec;
>  		chattr += inode_query_iversion(inode);
> -	} else {
> -		chattr = cpu_to_be32(stat->ctime.tv_sec);
> -		chattr <<= 32;
> -		chattr += cpu_to_be32(stat->ctime.tv_nsec);
> -	}
> -	return chattr;
> +		return chattr;
> +	} else
> +		return time_to_chattr(&stat->ctime);
>  }
>  
> 
>  extern void fill_pre_wcc(struct svc_fh *fhp);

I'd just fold this one into 2/8.
-- 
Jeff Layton <jlayton@kernel.org>

