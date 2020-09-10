Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC71264A88
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Sep 2020 19:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIJRCq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Sep 2020 13:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgIJRCb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Sep 2020 13:02:31 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1BBC061573
        for <linux-nfs@vger.kernel.org>; Thu, 10 Sep 2020 10:02:26 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E6D7C425E; Thu, 10 Sep 2020 13:02:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E6D7C425E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1599757340;
        bh=GW4Ajm3bOYsTcOBYGzs2hPawP22nAScLadtVuQKq1Pc=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=R0sj1+WIb8cfhlJAUwDIezpu9ARnV81IiPORdOZpSBlG1+GjiEdM5x7ornyXUrL3E
         sjhLe1FWhMQ/S+5x2DTpU1TK0jJ8bhfeCOT+Sb/5DHZZWr7W1SCd4tBtl6ZePC2emc
         TuQyM/XXWUiLhC312IfRExSm+xhXYlcJz32+ITZs=
Date:   Thu, 10 Sep 2020 13:02:20 -0400
To:     trondmy@kernel.org
Cc:     Steve Dickson <SteveD@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] mountd: Ignore transient and non-fatal filesystem errors
 in nfsd_export
Message-ID: <20200910170220.GB28793@fieldses.org>
References: <20200908211958.38741-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908211958.38741-1-trondmy@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 08, 2020 at 05:19:58PM -0400, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> If the mount point check in nfsd_export fails due to a transient error,
> then ignore it to avoid spurious NFSERR_STALE errors being returned by
> knfsd.

What sort of transient errors?

I guess this makes the upcall (and the original rpc) eventually time
out?

--b.

> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  utils/mountd/cache.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
> index 6cba2883026f..93e868341d15 100644
> --- a/utils/mountd/cache.c
> +++ b/utils/mountd/cache.c
> @@ -1411,7 +1411,10 @@ static void nfsd_export(int f)
>  
>  		if (mp && !*mp)
>  			mp = found->m_export.e_path;
> -		if (mp && !is_mountpoint(mp))
> +		errno = 0;
> +		if (mp && !is_mountpoint(mp)) {
> +			if (errno != 0 && !path_lookup_error(errno))
> +				goto out;
>  			/* Exportpoint is not mounted, so tell kernel it is
>  			 * not available.
>  			 * This will cause it not to appear in the V4 Pseudo-root
> @@ -1420,9 +1423,12 @@ static void nfsd_export(int f)
>  			 * And filehandle for this mountpoint from an earlier
>  			 * mount will block in nfsd.fh lookup.
>  			 */
> +			xlog(L_WARNING,
> +			     "Cannot export path '%s': not a mountpoint",
> +			     path);
>  			dump_to_cache(f, buf, sizeof(buf), dom, path,
>  				      NULL, 60);
> -		else if (dump_to_cache(f, buf, sizeof(buf), dom, path,
> +		} else if (dump_to_cache(f, buf, sizeof(buf), dom, path,
>  					 &found->m_export, 0) < 0) {
>  			xlog(L_WARNING,
>  			     "Cannot export %s, possibly unsupported filesystem"
> -- 
> 2.26.2
