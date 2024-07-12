Return-Path: <linux-nfs+bounces-4852-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9B792F5F2
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 09:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254171C21F4F
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 07:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CF113D601;
	Fri, 12 Jul 2024 07:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HuL6VC4Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D398EAC7;
	Fri, 12 Jul 2024 07:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720768215; cv=none; b=iVheQ6OWh5UYUtHDf8NMeDjvsSkfjWtxj5I3g71chpBfgId1pSqdTaeVimMcUcPc6TR21OnG8/0v5/msfjGXRDXv8uPk+efH+js9Z8GezKmzcG3r+SLqWAjb8NtNQyCGjMwM4zpE53qpxjpGng+g3eqZy3gbR1de06bmrK+47zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720768215; c=relaxed/simple;
	bh=xtvLbCp+9h/B9U2we951SJ1mUg1tFOTXvgQcrDV7GJg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqDP81Lyqiao+FLWLVMD4dkxX8FbTJ7XzcSZanow+oWS4e/9TsbWS9We9cItco+EBphuf3cDIpBoj6PaaQvMwW/na4CDVU3HwY9QDI/D0I3caA/d1ytQXoTDz/tuS2UnImV/0NInxyeVOpuG04qA3lUDij+KjE6e6l4udHSIAq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HuL6VC4Z; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BNSktB001298;
	Fri, 12 Jul 2024 00:09:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=XWP8ZoxK/0iqAkwFzGQTOnvqo
	/hg/DfqAF6SrmaaL0Q=; b=HuL6VC4Zc9PnWMgyfTLaazkOwNUG81s7V7MwHoPGQ
	ijajSf1ByL1RP7HMrmI6xUX22weWar4E83X4K8Nrk8uz+kfCiNZ7MZv/ZYQxmupc
	PXh9KSxKtLCBvotoHTF7Uj65UYoWpeXRyv4oWVpPUYbhBqR39vtW0rZQ1rXOshhs
	Xu8+P2TVO+/3E2PvUqJ9cu7OYn5hN2D0vurfHGZf2JaXCgT83mqi6CuNU4x1CA4t
	P6U+asqI4lRIOKwm2+iqrY6SFIif6hBAhswv6frnQYSSKpgIVxEPRApc9jmWqHk7
	TAzh+byxtVU1enUTgBvrK/5Ejn01Jz6a+U9rCOZeL4aPA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40agvrk3vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 00:09:33 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Jul 2024 00:09:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Jul 2024 00:09:32 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 75CB93F7048;
	Fri, 12 Jul 2024 00:09:28 -0700 (PDT)
Date: Fri, 12 Jul 2024 12:39:27 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
CC: <trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
        <jlayton@kernel.org>, <neilb@suse.de>, <kolga@netapp.com>,
        <Dai.Ngo@oracle.com>, <tom@talpey.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>, <linux-nfs@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH -next] gss_krb5: refactor code to return correct PTR_ERR
 in krb5_DK
Message-ID: <ZpDWp9P6M+LUVcBZ@test-OptiPlex-Tower-Plus-7010>
References: <20240712060312.1905013-1-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240712060312.1905013-1-cuigaosheng1@huawei.com>
X-Proofpoint-GUID: PNm3ICI8q61R492qOXqqV9VQ6TCu71Jo
X-Proofpoint-ORIG-GUID: PNm3ICI8q61R492qOXqqV9VQ6TCu71Jo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_04,2024-07-11_01,2024-05-17_01

On 2024-07-12 at 11:33:12, Gaosheng Cui (cuigaosheng1@huawei.com) wrote:
> Refactor the code in krb5_DK to return PTR_ERR when an error occurs.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  net/sunrpc/auth_gss/gss_krb5_keys.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
> index 4eb19c3a54c7..b809e646329f 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_keys.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
> @@ -164,10 +164,14 @@ static int krb5_DK(const struct gss_krb5_enctype *gk5e,
>  		goto err_return;
>  
>  	cipher = crypto_alloc_sync_skcipher(gk5e->encrypt_name, 0, 0);
> -	if (IS_ERR(cipher))
> +	if (IS_ERR(cipher)) {
> +		ret = IS_ERR(cipher);
         need to use PTR_ERR?

Thanks,
Hariprasad k


