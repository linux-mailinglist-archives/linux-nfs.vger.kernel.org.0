Return-Path: <linux-nfs+bounces-4855-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C3092F70D
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 10:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABF91B219B2
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 08:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625E413DDDB;
	Fri, 12 Jul 2024 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YipjfU91"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF52513DDB9;
	Fri, 12 Jul 2024 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720773492; cv=none; b=gl6ivZn3dUoYKDvAbaV5PiY5ST2FZqCMgwRUMa0dkIJeUF1gVyZiCdL9igitWXT73t491ZFF0m4RuPnHabBM/UH2bEz54QeW6Irg6uzZT4kk+FGmXiknBCpRHmxJ47eXLHNoKskV2nQTd/NbRA1zqulhr3dgHf6H/bglhmXXxZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720773492; c=relaxed/simple;
	bh=j6TYywS+D5fcqbz2c4s3Sb9YbvsqkINgMG6c3lOP8Wo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqA/bb50LtQnvjx925QkgPtX17aDsRQ4Zhmz4dWIhnxSPAyqyJlnTnLgW1QYH6vwOABMDl23U2z+2zJwmlDZ0RSFa+abBtPGEC7bLPnsUi/AVvyebVaiywiBN/DH8AicRijlvfwtlZvRfOQmibHeB4hI4xtEZJI/rOJZG/F0Kkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YipjfU91; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C3qM9Y014211;
	Fri, 12 Jul 2024 01:37:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=BZ4VC5Fc9krB6j+KOWe0keTuF
	fxAXU1Mjwc6f8iC8TU=; b=YipjfU91pbtU0TrWDdjeqyb09l4/ZMA0sreCOXgTP
	F0Fk3HxzcSJmbtONXUtEWDWks8EGH3D+dItzcyvPDTv/01arWvak7ltm0lZ7+DEj
	OpgMcKUNf2+wtaCJMkKgN6RR3bdsb3ArSt/lVc8RpPvzsL8dgxDAdSdSN+/AtUvt
	qjqycDwOK+mu5DubuugNAmQ896H1w8qew5k5ZtyPe4IIyBd2mRyzoKqvubqvg4TN
	YtPOx7x0pE9iRxrWGr8o4kJHGpSJO51xJIMxw/1ANXd0KlYHA5plwky+bFC/KZ31
	p7A+0Wo3UnvGaPBgXrP+C313r8GeqGbqFqRamVELURAIw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40aukj8xv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 01:37:15 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Jul 2024 01:37:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Jul 2024 01:37:08 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 0AB953F70A3;
	Fri, 12 Jul 2024 01:37:03 -0700 (PDT)
Date: Fri, 12 Jul 2024 14:07:02 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
CC: <trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
        <jlayton@kernel.org>, <neilb@suse.de>, <kolga@netapp.com>,
        <Dai.Ngo@oracle.com>, <tom@talpey.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>, <linux-nfs@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH -next,v2] gss_krb5: refactor code to return correct
 PTR_ERR in krb5_DK
Message-ID: <ZpDrLjkCvG3rpxuD@test-OptiPlex-Tower-Plus-7010>
References: <20240712072423.1942417-1-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240712072423.1942417-1-cuigaosheng1@huawei.com>
X-Proofpoint-GUID: 0ycnydHMV8BGDDXjAp6iDpgqgwDP8Z3f
X-Proofpoint-ORIG-GUID: 0ycnydHMV8BGDDXjAp6iDpgqgwDP8Z3f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_05,2024-07-11_01,2024-05-17_01

On 2024-07-12 at 12:54:23, Gaosheng Cui (cuigaosheng1@huawei.com) wrote:
> Refactor the code in krb5_DK to return PTR_ERR when an error occurs.
> 
 nit: Please change "-next" to "net-next" in subject

 Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>

> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
> v2: Update IS_ERR to PTR_ERR, thanks very much!
>  net/sunrpc/auth_gss/gss_krb5_keys.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
> index 4eb19c3a54c7..5ac8d06ab2c0 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_keys.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
> @@ -164,10 +164,14 @@ static int krb5_DK(const struct gss_krb5_enctype *gk5e,
>  		goto err_return;
>  
>  	cipher = crypto_alloc_sync_skcipher(gk5e->encrypt_name, 0, 0);
> -	if (IS_ERR(cipher))
> +	if (IS_ERR(cipher)) {
> +		ret = PTR_ERR(cipher);
>  		goto err_return;
> +	}
> +
>  	blocksize = crypto_sync_skcipher_blocksize(cipher);
> -	if (crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len))
> +	ret = crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len);
> +	if (ret)
>  		goto err_free_cipher;
>  
>  	ret = -ENOMEM;
> -- 
> 2.25.1
> 
> 

