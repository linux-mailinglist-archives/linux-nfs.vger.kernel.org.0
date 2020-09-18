Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1364627041F
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Sep 2020 20:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIRSc0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Sep 2020 14:32:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32050 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726414AbgIRScV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Sep 2020 14:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600453939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WMCt82vydAOuMxr21i5VIzabIgO00NuRNotKhmjTrn4=;
        b=Lz1mOe7lqf2GI9cRfDFa37lZmcH/iO8wdGRGXSzIek5PePZ+UPUkVwIcFmwP+k2y9ittYB
        LfZm/RUE8OyEwn0ocQOLbE85D90nFD1acb9+b+6jcUgfMMGZeOcbYyBNovwVDND1bX9fhd
        zx+Eik/C6coO6+AIEblj3LkQ2w5pEbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-AY_nnCZbOaeyjOm4f2XkCg-1; Fri, 18 Sep 2020 14:32:17 -0400
X-MC-Unique: AY_nnCZbOaeyjOm4f2XkCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D20AD808245;
        Fri, 18 Sep 2020 18:32:16 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-247.phx2.redhat.com [10.3.112.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BE3D19728;
        Fri, 18 Sep 2020 18:32:16 +0000 (UTC)
Subject: Re: [PATCH] mountd: Ignore transient and non-fatal filesystem errors
 in nfsd_export
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
References: <20200908211958.38741-1-trondmy@kernel.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <33492131-a396-9f6c-30bd-fac8de9c9e6d@RedHat.com>
Date:   Fri, 18 Sep 2020 14:32:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908211958.38741-1-trondmy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/8/20 5:19 PM, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> If the mount point check in nfsd_export fails due to a transient error,
> then ignore it to avoid spurious NFSERR_STALE errors being returned by
> knfsd.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Committed... (tag: nfs-utils-2-5-2-rc5)

steved.
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
> 

