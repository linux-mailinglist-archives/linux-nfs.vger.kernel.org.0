Return-Path: <linux-nfs+bounces-1033-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2E582AF91
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 14:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05A61F22844
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 13:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E6817756;
	Thu, 11 Jan 2024 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lplxwR3L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6981774C;
	Thu, 11 Jan 2024 13:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03DAC433C7;
	Thu, 11 Jan 2024 13:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704979197;
	bh=Py9GZW6bz3Ftsp/kWmIWKLoUxUT/lIEhBD9mMIzmipM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lplxwR3L2EEdttM8HHLNSmBUrM7UmVYJ8JMB3tYBFb2pbmHM+jW/hnjg8kB0Uimnq
	 z4k2rT+zgutaqfuShuj66anIZ74QRnXXjuvSE1kIXvTojHtgHgZjIqFJNFNN2ObjUH
	 xG0uQ5jME6E9bZVTZHxP/qbyRh+mZhHm+7Yg1Dizpfd9hWpzu53d26RDNk5RA1z5CD
	 kOzA4xNomfp6jMctsw8PVNWKlbVjl2LUP4P1nt8ypgHtsktI7/lHq0D1zKjvn+R0WL
	 YeqK+ANinUKtrg9Px7dl9QTuIfDrCFuQ3XRa2Q9gmO1vmEGwgJyqqvRdT/2dA1jcm4
	 gjdkPqmdct2bQ==
Date: Thu, 11 Jan 2024 13:19:50 +0000
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Edward Adam Davis <eadavis@qq.com>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Markus Suvanto <markus.suvanto@gmail.com>,
	Jeffrey E Altman <jaltman@auristor.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Wang Lei <wang840925@gmail.com>, Jeff Layton <jlayton@redhat.com>,
	Steve French <smfrench@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org, keyrings@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys, dns: Fix size check of V1 server-list header
Message-ID: <20240111131950.GB45291@kernel.org>
References: <1850031.1704921100@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1850031.1704921100@warthog.procyon.org.uk>

On Wed, Jan 10, 2024 at 09:11:40PM +0000, David Howells wrote:
>     
> Fix the size check added to dns_resolver_preparse() for the V1 server-list
> header so that it doesn't give EINVAL if the size supplied is the same as
> the size of the header struct (which should be valid).
> 
> This can be tested with:
> 
>         echo -n -e '\0\0\01\xff\0\0' | keyctl padd dns_resolver desc @p
> 
> which will give "add_key: Invalid argument" without this fix.
> 
> Fixes: 1997b3cb4217 ("keys, dns: Fix missing size check of V1 server-list header")
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Link: https://lore.kernel.org/r/ZZ4fyY4r3rqgZL+4@xpf.sh.intel.com/
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


