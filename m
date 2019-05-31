Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87F4730EF0
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 15:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfEaNgu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 May 2019 09:36:50 -0400
Received: from fieldses.org ([173.255.197.46]:42040 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfEaNgu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 31 May 2019 09:36:50 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 9BA5E1C1B; Fri, 31 May 2019 09:36:49 -0400 (EDT)
Date:   Fri, 31 May 2019 09:36:49 -0400
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jeff Layton <jlayton@kernel.org>, Jiri Kosina <trivial@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [trivial] nfsd: Spelling s/EACCESS/EACCES/
Message-ID: <20190531133649.GA1251@fieldses.org>
References: <20190527122132.5617-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527122132.5617-1-geert+renesas@glider.be>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks, applying for 5.3.--b.

On Mon, May 27, 2019 at 02:21:32PM +0200, Geert Uytterhoeven wrote:
> The correct spelling is EACCES:
> 
> include/uapi/asm-generic/errno-base.h:#define EACCES 13 /* Permission denied */
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  fs/nfsd/vfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index fc24ee47eab51ad4..c85783e536d595de 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -404,7 +404,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
>  	/*
>  	 * If utimes(2) and friends are called with times not NULL, we should
>  	 * not set NFSD_MAY_WRITE bit. Otherwise fh_verify->nfsd_permission
> -	 * will return EACCESS, when the caller's effective UID does not match
> +	 * will return EACCES, when the caller's effective UID does not match
>  	 * the owner of the file, and the caller is not privileged. In this
>  	 * situation, we should return EPERM(notify_change will return this).
>  	 */
> -- 
> 2.17.1
