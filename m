Return-Path: <linux-nfs+bounces-16826-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DB4C98D95
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Dec 2025 20:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C38104E1880
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Dec 2025 19:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3787B215F7D;
	Mon,  1 Dec 2025 19:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+Pn81ca"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070561B87C0;
	Mon,  1 Dec 2025 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764617333; cv=none; b=LVOoKV3UK3BEC1seyEtfI/0CKUWJNBx27PDvxzcpxwNIzlCi0EihQ6L8ymp6VudiXMhxT1t942R1USS4xIsLimarq1G9N2xuB36DD8zPLIWPfsjcxMm69GdlNGFAP9AYNlanm+pV5a22hbexQFLuBexpgvcodz9vmXLUmmbNqIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764617333; c=relaxed/simple;
	bh=3Zu7HM100fRSMABFNYlgfXQFkBL6cdCWowzbbRyMMz0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Gx7nY7Keq5AG6TgwGAqoeEMs3/j3aOw+EqW5RhC6yeCW5al5ydi5YoDKgq4w69lKHuUV6cnt+ovx9dOs1VkqZVJnqpFP2fD+q7xnhqz04tsVyHCbRsCgRVk06/hqHi4K5RkG8FOBo0GTPls8oTZ+z8pRunfXXAssedqb/MNNWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+Pn81ca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA4CC4CEF1;
	Mon,  1 Dec 2025 19:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764617332;
	bh=3Zu7HM100fRSMABFNYlgfXQFkBL6cdCWowzbbRyMMz0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=m+Pn81cacPibVcSEbKUi1Baeqrh/wjivSVcoNwgvjqOjKnJZaannH8WhNLlaHcd9r
	 5tEuT5xSAyve6WfLFm+0qjklIc7bdo7hwhjJ6vYuPg2Ya+a3q6GY5jxNJIyU+OURnG
	 PVdi8fadn2xgsPNfBqd1bc4s0w9ldBhYETZhBztAM2wOOrPJKh3943Zb6z8dCvm+in
	 hzO6wyblP1XFP+xqylyXcreDgGOMkPBjl/8utmPl8aHQzsP09vrGpcEhsNAqUMDrVo
	 OnIKakIGJ32k9FsPNa/wKLSIgOxSlZBKoXJHiwQ0EApQ1sdV50z3hnMtj/RKHQ7g1M
	 9vOrsFKNHBeSw==
Message-ID: <8bd5a144-1d67-447c-b33e-388ef27b1176@kernel.org>
Date: Mon, 1 Dec 2025 14:28:50 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 v6.12.y] nfsd: Replace clamp_t in nfsd4_get_drc_mem()
From: Chuck Lever <cel@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
 linux-kernel@vger.kernel.org, speedcracker@hotmail.com,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 david.laight.linux@gmail.com, Andrew Morten <akpm@linux-foundation.org>,
 stable@vger.kernel.org
References: <20251114211922.6312-1-cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <20251114211922.6312-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/25 4:19 PM, Chuck Lever wrote:
> From: NeilBrown <neil@brown.name>
> 
> A recent change to clamp_t() in 6.1.y caused fs/nfsd/nfs4state.c to fail
> to compile with gcc-9. The code in nfsd4_get_drc_mem() was written with
> the assumption that when "max < min",
> 
>    clamp(val, min, max)
> 
> would return max.  This assumption is not documented as an API promise
> and the change caused a compile failure if it could be statically
> determined that "max < min".
> 
> The relevant code was no longer present upstream when commit 1519fbc8832b
> ("minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()")
> landed there, so there is no upstream change to nfsd4_get_drc_mem() to
> backport.
> 
> There is no clear case that the existing code in nfsd4_get_drc_mem()
> is functioning incorrectly. The goal of this patch is to permit the clean
> application of commit 1519fbc8832b ("minmax.h: use BUILD_BUG_ON_MSG() for
> the lo < hi test in clamp()"), and any commits that depend on it, to LTS
> kernels without affecting the ability to compile those kernels. This is
> done by open-coding the __clamp() macro sans the built-in type checking.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220745#c0
> Signed-off-by: NeilBrown <neil@brown.name>
> Stable-dep-of: 1519fbc8832b ("minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Changes since Neil's post:
> * Editorial changes to the commit message
> * Attempt to address David's review comments
> * Applied to linux-6.12.y, passed NFSD upstream CI suite
> 
> This patch is intended to be applied to linux-6.12.y, and should
> apply cleanly to other LTS kernels since nfsd4_get_drc_mem hasn't
> changed since v5.4.
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 7b0fabf8c657..41545933dd18 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1983,8 +1983,10 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn
>  	 */
>  	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
>  
> -	avail = clamp_t(unsigned long, avail, slotsize,
> -			total_avail/scale_factor);
> +	if (avail > total_avail / scale_factor)
> +		avail = total_avail / scale_factor;
> +	else if (avail < slotsize)
> +		avail = slotsize;
>  	num = min_t(int, num, avail / slotsize);
>  	num = max_t(int, num, 1);
>  	nfsd_drc_mem_used += num * slotsize;

Is something else needed from me to get this applied to v6.12 and older
LTS kernels?


-- 
Chuck Lever


