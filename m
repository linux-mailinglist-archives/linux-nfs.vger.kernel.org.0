Return-Path: <linux-nfs+bounces-8048-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C85EF9D1993
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1231F2100E
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 20:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CDE1D0DFC;
	Mon, 18 Nov 2024 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlU70yaT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FBC13E8AE
	for <linux-nfs@vger.kernel.org>; Mon, 18 Nov 2024 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731961490; cv=none; b=Q/pd2yfXXheXrkb5UjTOTP6ZzVhNoE+Xr3vPs+CEiXN/cCl9DsVmPsGAgW5r7rAAmY6lN7YchOyE2kzLbvq5kuYzbGOmPbh1qE/VlAnRdng4/fVAIbLuAdAVqRkQBspGrR8HC06r5EbLfxRvGB/klvYr3QTTMP4q4FAxIZeEaG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731961490; c=relaxed/simple;
	bh=QzSIvgGRqU/FlmaEMqLPIIkkEvAe77HEhRZrDww9v5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVLhkdD6ChH79pq2G25TmYYUSRoLZX13b0D7FlavFJg0hn910SBvqLAqrerht2YKt6dFOcK37iMWQdtg6Gv8pDJpMuPONiPrBVJDQvVvp70d1NehHCkHBFxhTf0EDMrayrtjU5kDJPrdNgjUT3pHq7EZt3on7KGNkzBAz6UVDdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlU70yaT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731961487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5cwzc0wJ0hDQth9zvzZfmcdD0+CuajnlWtY4GNQBL74=;
	b=PlU70yaToXg2xUQ+GBV5oNb5ELWrgN2Y1fY0gW2iGGk+UbtnGjC2yax8LKi/URyJcar+dv
	2LydyR5LZrkZpacSSZDRVOx/3uf5qqpP+FlX06msVy+ec/VCmuabYLdYDYrnonay66VYat
	apA03L5f1wr6k+0Fo357szUEnmhYTzY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-AoAUqZmMPtWKK_X4qxlFDw-1; Mon,
 18 Nov 2024 15:24:45 -0500
X-MC-Unique: AoAUqZmMPtWKK_X4qxlFDw-1
X-Mimecast-MFC-AGG-ID: AoAUqZmMPtWKK_X4qxlFDw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6490A1955F3A
	for <linux-nfs@vger.kernel.org>; Mon, 18 Nov 2024 20:24:44 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3919A1955F43;
	Mon, 18 Nov 2024 20:24:44 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 8AD83222559; Mon, 18 Nov 2024 15:24:42 -0500 (EST)
Date: Mon, 18 Nov 2024 15:24:42 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH] nfsd: dump default number of threads to 16
Message-ID: <ZzuiiraPkRN8vMsh@aion>
References: <20241118202011.1115968-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118202011.1115968-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Subject line should say "bump", not "dump".

-Scott

On Mon, 18 Nov 2024, Scott Mayhew wrote:

> nfsdctl defaults to 16 threads.  Since the nfs-server.service file first
> tries nfsdctl and then falls back to rpc.nfsd, it would probably be wise
> to make the default in rpc.nfsd and nfs.conf 16, for the sake of
> consistency and to avoid surprises.
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  nfs.conf          | 2 +-
>  utils/nfsd/nfsd.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/nfs.conf b/nfs.conf
> index 23b5f7d4..087d7372 100644
> --- a/nfs.conf
> +++ b/nfs.conf
> @@ -66,7 +66,7 @@
>  #
>  [nfsd]
>  # debug=0
> -# threads=8
> +# threads=16
>  # host=
>  # port=0
>  # grace-time=90
> diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
> index 249df00b..f787583e 100644
> --- a/utils/nfsd/nfsd.c
> +++ b/utils/nfsd/nfsd.c
> @@ -32,7 +32,7 @@
>  #include "xcommon.h"
>  
>  #ifndef NFSD_NPROC
> -#define NFSD_NPROC 8
> +#define NFSD_NPROC 16
>  #endif
>  
>  static void	usage(const char *);
> -- 
> 2.46.2
> 
> 


