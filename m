Return-Path: <linux-nfs+bounces-10383-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEFDA48747
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Feb 2025 19:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC596169769
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Feb 2025 18:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48A81E5212;
	Thu, 27 Feb 2025 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHCG3lg5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8000199239;
	Thu, 27 Feb 2025 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679679; cv=none; b=uhp8L+HH93z4D5kqSdToQfh6pTss4IaSB+73Ua9oqk36cOsOaC8ShZ+jcX/EXSDDarmKXbJ1TU76BoxQ1G27ZQKv+TFMx+//JdkqHHId9uucsVV8HNbU9jEsjLsbKmwRgQ+H0+6hZgHqnrwWZD1Nkr468k/qGLEzNbFi3FLs4VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679679; c=relaxed/simple;
	bh=vhmtyUChkLPeqliiyC9AicZu6RAusKQ/lN10XdERt1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pmk3dTMKQ3je0L9X44cMyGi5lU4qqBdJTUTMd+TA37m54fqqK2zd2hRwP5vOz52CKFcZ01s2sGIRqlRWLDvYJxdXQ6IEsK68VOinipmuWw4lhGJnRJ8iGehK5fbFrbAzV0T1WlifI6Zdl8gRGN3Hy2KHonsXd/Qsmolocz7Xj0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHCG3lg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D134C4CEDD;
	Thu, 27 Feb 2025 18:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740679679;
	bh=vhmtyUChkLPeqliiyC9AicZu6RAusKQ/lN10XdERt1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PHCG3lg59WgBLams8yFpmmMIgDrpjKJ/TrdD3aQuKUUxYtvCDBqmlzBJDCrDpOOl9
	 0ectFu5s73VOV9/HWTUNHUfB40wvWBKyTX/WIW4aWuMQhXHY71VjxukflBtZz43+zx
	 lhbyDlKB5D15VNp2bVaK/soCxZYbeR2GN4987Wqeg6LC4Pjt2JGdE+WJmykQoBKJ8q
	 qsOcfpzExLyn3vQNtumk1170d+0gi4twgT2FIzzE/utgIQFFRvyYItLTpkTABxzZpH
	 clpg6s+xBnDE5jg2SN2dVOlF9M9KGvXyHQR5uaUYZFGoykLEeaSMhjS2ifD3yCw4b7
	 T0vtZonjk4auw==
Date: Thu, 27 Feb 2025 18:07:53 +0000
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	NeilBrown <neilb@suse.de>, "J. Bruce Fields" <bfields@fieldses.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Yang Erkun <yangerkun@huawei.com>, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] sunrpc: suppress warnings for unused procfs
 functions
Message-ID: <20250227180753.GI1615191@kernel.org>
References: <20250225145234.1097985-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225145234.1097985-1-arnd@kernel.org>

On Tue, Feb 25, 2025 at 03:52:21PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There is a warning about unused variables when building with W=1 and no procfs:
> 
> net/sunrpc/cache.c:1660:30: error: 'cache_flush_proc_ops' defined but not used [-Werror=unused-const-variable=]
>  1660 | static const struct proc_ops cache_flush_proc_ops = {
>       |                              ^~~~~~~~~~~~~~~~~~~~
> net/sunrpc/cache.c:1622:30: error: 'content_proc_ops' defined but not used [-Werror=unused-const-variable=]
>  1622 | static const struct proc_ops content_proc_ops = {
>       |                              ^~~~~~~~~~~~~~~~
> net/sunrpc/cache.c:1598:30: error: 'cache_channel_proc_ops' defined but not used [-Werror=unused-const-variable=]
>  1598 | static const struct proc_ops cache_channel_proc_ops = {
>       |                              ^~~~~~~~~~~~~~~~~~~~~~
> 
> These are used inside of an #ifdef, so replacing that with an
> IS_ENABLED() check lets the compiler see how they are used while
> still dropping them during dead code elimination.
> 
> Fixes: dbf847ecb631 ("knfsd: allow cache_register to return error on failure")
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This patch from last year is still needed, resending without changes

Tested-by: Simon Horman <horms@kernel.org> # build-tested
Reviewed-by: Simon Horman <horms@kernel.org>



