Return-Path: <linux-nfs+bounces-3843-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 884F8909231
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 20:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282DF1F242FF
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 18:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164F31990BE;
	Fri, 14 Jun 2024 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mXa1p9Ol"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFB04414;
	Fri, 14 Jun 2024 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718389310; cv=none; b=BCGdunGpvNvmjhVNOM3tYeGpzrklqVRpyg/HiSXhWduaSILSQM6sBxz0A9dzClPbphd0v+JtyrxRobIHZLV9/toPhfHHHvTMykyZt8ecN8C1qvUxNzSEDZKYlBsa4psbauakEurIpgj9N75d+QCuRxDiyosNT2tmjlkv6v0ooL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718389310; c=relaxed/simple;
	bh=t10/DKZawOM942+Rfsr5XZjFk4CUdJJZ76zYdBDj74o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DgNt5xuBY4nfJJ4XwERNGY4fyhWbVSHUWH7aTolgDICJHhz503ryCFXUj7J+7SmAWIGKJvqW3nF8L7/pv67l6EHSaHM7bL8IQ/wPSmRkEO3smedxf+ekmyp57Lvft6p0m02KP1cxd/FlvceqtJV+VI/+nrOcD9fPyVC8ECTkxrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mXa1p9Ol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB81C2BD10;
	Fri, 14 Jun 2024 18:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718389309;
	bh=t10/DKZawOM942+Rfsr5XZjFk4CUdJJZ76zYdBDj74o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mXa1p9OljcPPnHJe+S0GH8f6obYCNzxKYDdRO1my5cwauiSQ3W6HwFATHU6hTo3hF
	 21LYGc1ijTFwH0lWjVP6YdcPtcsA6JGnHW8g9LjMAkIEJmpDLWk3TKDD1TpL+mTZ7q
	 tJ7MtxzA0aJpeJ6qgSQhZodFd66LDBIisBke4hwY=
Date: Fri, 14 Jun 2024 11:21:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Steve French <sfrench@samba.org>, linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-mm@kvack.org, Barry Song
 <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] nfs: fix nfs_swap_rw for large-folio swap
Message-Id: <20240614112148.cd1961e84b736060c54bdf26@linux-foundation.org>
In-Reply-To: <20240614100329.1203579-2-hch@lst.de>
References: <20240614100329.1203579-1-hch@lst.de>
	<20240614100329.1203579-2-hch@lst.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jun 2024 12:03:25 +0200 Christoph Hellwig <hch@lst.de> wrote:

> As of Linux 6.10-rc the MM can swap out larger than page size chunks.
> NFS has all code ready to handle this, but has a VM_BUG_ON that
> triggers when this happens.  Simply remove the VM_BUG_ON to fix this
> use case.
> 
> ...
>
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
> @@ -141,8 +141,6 @@ int nfs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
>  {
>  	ssize_t ret;
>  
> -	VM_BUG_ON(iov_iter_count(iter) != PAGE_SIZE);
> -
>  	if (iov_iter_rw(iter) == READ)
>  		ret = nfs_file_direct_read(iocb, iter, true);
>  	else

I'm thinking this should precede "mm: swap: entirely map large folios
found in swapcache", or be a part of it.

Barry/Chuanhua, any opinions?

