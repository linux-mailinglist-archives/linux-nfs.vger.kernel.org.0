Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 648EAD193C
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2019 21:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfJITvW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Oct 2019 15:51:22 -0400
Received: from fieldses.org ([173.255.197.46]:48438 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbfJITvW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Oct 2019 15:51:22 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id EBBE71C24; Wed,  9 Oct 2019 15:51:21 -0400 (EDT)
Date:   Wed, 9 Oct 2019 15:51:21 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd4: fix up replay_matches_cache()
Message-ID: <20191009195121.GA23703@fieldses.org>
References: <20191009191137.28007-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009191137.28007-1-smayhew@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 09, 2019 at 03:11:37PM -0400, Scott Mayhew wrote:
> When running an nfs stress test, I see quite a few cached replies that
> don't match up with the actual request.  The first comment in
> replay_matches_cache() makes sense, but the code doesn't seem to
> match... fix it.

Thanks, I'll apply.  But I'm curious whether you're seeing any practical
impact from this?  I don't think it should matter.

--b.

> 
> Fixes: 53da6a53e1d4 ("nfsd4: catch some false session retries")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  fs/nfsd/nfs4state.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c65aeaa812d4..08f6eb2b73f8 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3548,12 +3548,17 @@ static bool replay_matches_cache(struct svc_rqst *rqstp,
>  	    (bool)seq->cachethis)
>  		return false;
>  	/*
> -	 * If there's an error than the reply can have fewer ops than
> -	 * the call.  But if we cached a reply with *more* ops than the
> -	 * call you're sending us now, then this new call is clearly not
> -	 * really a replay of the old one:
> +	 * If there's an error then the reply can have fewer ops than
> +	 * the call.
>  	 */
> -	if (slot->sl_opcnt < argp->opcnt)
> +	if (slot->sl_opcnt < argp->opcnt && !slot->sl_status)
> +		return false;
> +	/*
> +	 * But if we cached a reply with *more* ops than the call you're
> +	 * sending us now, then this new call is clearly not really a
> +	 * replay of the old one:
> +	 */
> +	if (slot->sl_opcnt > argp->opcnt)
>  		return false;
>  	/* This is the only check explicitly called by spec: */
>  	if (!same_creds(&rqstp->rq_cred, &slot->sl_cred))
> -- 
> 2.17.2
