Return-Path: <linux-nfs+bounces-7623-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8547A9B92BB
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2024 15:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A1D1F20FD6
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2024 14:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5FF15855D;
	Fri,  1 Nov 2024 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S+5G2dYU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VvxPLBBj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076E54436E
	for <linux-nfs@vger.kernel.org>; Fri,  1 Nov 2024 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730469625; cv=fail; b=e+ZwVw4CE6zADhLK1UH0yEhddg7wLNUvd3SxfwIbsch2PIz0BxbpAE365zvMOpAWIlWJ4QBo3oWK0bFwPd9oqc6+4eFsTNZ388JRWta9D4/LuDUyhZeLQej8VDezu+YVIzIPuegg3xNEDmcBsSBezvIuzM/+ElM8oi2diUMNIk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730469625; c=relaxed/simple;
	bh=21PjzvoFoveriXPt8x+LahOUAA7Lto1rJtc6IuE7/S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LArdtk5usHoRHFQ/8Lr2nQeJA3uqIKUGHLh1U+ThLAGfEJ3xqajDGZF0ZAFTBlimDuxWUlvU7icg2t0ud4D67MCl6D0rXy4DSfgZR+xfUFLmbDQ7CfarTnv4NfgnAX92xzuNdrZrDjKEPc48jUXU15j/U5mM70trmiUJbhG+7qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S+5G2dYU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VvxPLBBj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1Dfj4n004019;
	Fri, 1 Nov 2024 14:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=lbn3Vfv1lvVSjGZLRp
	7udduZ8izMOTixIBdLEXjNLVU=; b=S+5G2dYU/cUtcrI3dp9ucSIqC6GGzBK9bg
	7+BQiVolvOA/zlASNu1i+oMCoAvx5VwB7uaHjW5GxAXUnBragM/0AzoAPsrjp1D1
	ZfYhmDbQwXPEiaXONrDx9aQmWXTUJM7yYGQnKI0e67wRVMouo4/BH6m6eDqzRWUo
	v6SN5ots76XSag3s22gH2wdJRrcTrRNgroyyx7WLSHPwFyKDnMlgHxl69THjVD6Q
	fr5J4wOo4U2hM/dDilxiJzG7gvTdff7ZaSkLoMZI8URrsv/xkECj8i+viy6xyXwy
	hDMuswU3lbTllo5FY2lxRvGGI45bHljBIIUslP5JE512XYQhKgAg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgwm7f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 14:00:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1CGlTt034908;
	Fri, 1 Nov 2024 14:00:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hndbj8fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 14:00:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ow1b4tvXZCn9IFAvzLO6O1wE9F+sH/1UCXbX5i8Z0N/7SH7U/TF7YBmBKF1/UK6qWCRJaGSDYf7rKe06BhFPhsgSxkmyGjU12TA7h9I9KlQ9ZouF+2zBObuu+b3FP8z3Sp825UPVFD3EaCrPK4o/8fbuCkca9yo3gYoRGLsnadFvjDfdogVKsJK0MfCrOHf4grwDtbCdTmxh1EqOGoYskuJ4SELunl56ClYMcxrUkwBX0OqAOAmOKuJZrkl68jDTbETFJM5GHI7iT7JFW/JKEK4RZnAFz5VcAWqwUImSnCihcbBI+zA2O7rlesDKLxn52Bf5+kT/xO5GlRSGghyHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbn3Vfv1lvVSjGZLRp7udduZ8izMOTixIBdLEXjNLVU=;
 b=uT5YVASpel3MPXs4s1NpRaGP3FcY+qDlySDe+bJI/7578y49PMVF6TA1BcfERHlWx8ycXGQ17St6VLnoyVuGvO7oVmtw1d8w3FipTe4AQ8G1/b/ZqfccdgWbBmbZ3YauEq+ofYQx3bs1GNyUj8J6o43h03n4Zc9O0NlolMfSxP6S7lzhCYLmsaT2AghT4Bjs3AX10L8EAaehBu29xHi6amehAoU6hw5gHUCNV28UuVOVeoXemdKTJGsfwW8bAOJJkMxbGzW9ji+RwZyEtOPKPMlltYUNV31TZ8z0VzuJmFRA0yM/08PpZzbZJc2ghBe3a3glXJQdoMa/PZo9q/CiyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbn3Vfv1lvVSjGZLRp7udduZ8izMOTixIBdLEXjNLVU=;
 b=VvxPLBBj26/CtA7HnZwedyxtG66xdkZmyLeXkoOFYGPf7okqMq+XT27ZP9rvrbKnihzoUaeHy0ARrVZdsuSksr/u7hPS4kNOJWRM49XHrSdCIvv5t552Bq/Iauyh8TuSZ9nXzmS8d2J59XlIt+R1JhtkGOQjIb+BDbhv39O/zy4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6085.namprd10.prod.outlook.com (2603:10b6:8:bd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.23; Fri, 1 Nov 2024 14:00:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.023; Fri, 1 Nov 2024
 14:00:03 +0000
Date: Fri, 1 Nov 2024 10:00:00 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: cel@kernel.org, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 8/8] NFSD: Send CB_OFFLOAD on graceful shutdown
Message-ID: <ZyTe4N1WXCGQwA+o@tissot.1015granger.net>
References: <20241031134000.53396-10-cel@kernel.org>
 <20241031134000.53396-18-cel@kernel.org>
 <aafc9341224f4649daa44c15a1abaa62d442e604.camel@kernel.org>
 <ZyTVC5kqozgp8DYq@tissot.1015granger.net>
 <f6690d37bc38edd0f84c6d88d188526cd2fb9707.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6690d37bc38edd0f84c6d88d188526cd2fb9707.camel@kernel.org>
X-ClientProxiedBy: CH5P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 137ebc89-a1c6-4251-28b0-08dcfa7d7b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gn96OE+hjqz1wHKIzEhXuc+A4wexO9uYr7D5rc/JHNAiBFk7sDTbaJDAoW1j?=
 =?us-ascii?Q?NfxCFCXXo8FgRuo75SXsbisSvB7lBwzEfqSrNIqavsTeBK3l+jJVpTmpv7jX?=
 =?us-ascii?Q?ioGUWS9EZCS5gRIYQkqp0ybJG55WYHueg/RLLS/vcmlof2pNN3U422okTUIQ?=
 =?us-ascii?Q?82SeYS48bnO3HvtR5ccFbY8Im2viaxVU4dSpFpn64pP4P8dKnYQmcf25Ywoi?=
 =?us-ascii?Q?dUFaZGtZo++5/0OyU02KaJRz2KHj8UGtwwLL+IET1Yn5wD6KbGMqB/F7YOjp?=
 =?us-ascii?Q?3YGIrgEaqjYI2T6GG+32MGUnQKDH63iYZ9Hm/JdXAnH0F62lCre/y9xUsG/g?=
 =?us-ascii?Q?YI2Ds1D5VdFnH5GxFlfNheSWPzfE2QbC0h3ttRHHG5welUoP7U6LETxwLt8m?=
 =?us-ascii?Q?xiUUTv0QICM7WOeWwAbzN1Iytb0R8+B0YbCVXxCpdRO/0GhKjTIYIOH5h1f3?=
 =?us-ascii?Q?EEIWlG5nKT7KaOzDjNrSh41rNFWlfxlE4egmdmIrYoxYScLtxn7QNFOdoFJn?=
 =?us-ascii?Q?QasaEAodWBO2N+MyLMYtNh785+8VtUWHIJl1JCWCBnwHKHf5tOZHp+rhCec0?=
 =?us-ascii?Q?/t03S/yI/xkTJINhEQOEpkAgg3qsqXapP0gfZDeiPRhbQDQnvWF6dPZcR9na?=
 =?us-ascii?Q?06nouw9ANAQ5kgg5r1SIzHVM+aTxdAiad67csAH/v3k4I8WfxQCv7RtdBMkv?=
 =?us-ascii?Q?a0u4Myiu9tW8nPOHtNl74LreexREtYBSTJD3mHtAweQ8rFkgpChQlbuIIeTG?=
 =?us-ascii?Q?N0ZuDE+wqOMKshg7SauWscSmQJ4CK/Hb8Sspq/xDMMjuHmtlN34YH5k1+pWN?=
 =?us-ascii?Q?vu0tie6V6546KwN4Go3VvpalKBHQeeEXXS+GDA6IF52M79MjjM+bhmNNjoGW?=
 =?us-ascii?Q?100QQ6bhcmHLQf564FAsY47qgmAkNdZJ0Vh4Exi2IcC0qGpgm+K/cwwuGSRQ?=
 =?us-ascii?Q?ETdXB/L7ir687U8HNf0SS1AeFWyG2XAQ+N0WBn/7hqzCYzSCmHO0dbnplRCs?=
 =?us-ascii?Q?ObQDa+kcFJNU9EF7xGJE60t/Vy4KdgtWAFNNYokytuAizMCznbK99C/sn/Jm?=
 =?us-ascii?Q?MTnKWes0d3yHNVtVSpFA5tfEDKuNbrKhvC/uU43Pr+5tT4CQx6+hZnsEFQ2G?=
 =?us-ascii?Q?mOORCcNIXK8vMpbCU511e3oKUjTOMf59oBhq6uQs4UwPmMthrpSp8JiAv1U7?=
 =?us-ascii?Q?WGS8blyIzksiH3QWlG9qvSzPPtbWOEtDWDqbl4snRLPcdYBOhaGGuPlfoxe6?=
 =?us-ascii?Q?TL3btDznGbR2nSe+cYFX5B5c62vDnn2YKV4OlSfuCZfTJPCvVobJO2E+Lhme?=
 =?us-ascii?Q?GX3g8qC2B9zsFeU6wUq4n28B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QsAUqZyHwqmRtP88qLBqz2onO+WiDdXMbS4X/yEPLJ7egRW7BfPPXpfz0NGz?=
 =?us-ascii?Q?qlE0kCHzPbMSpGYQ7q1L/CzQRPCDRCbdMY6JALe9WsJtIkp1T/HlNeHfIjFi?=
 =?us-ascii?Q?kR362SZtnc6kwD7CQm1KqVMndwDGb5d+u9Ho8JQQQz2SeDnFK2fLCsqzcwsG?=
 =?us-ascii?Q?9GzNMhffivil/CUV5KqOh53ZDhhHnqgNA4ncl00Qx5RCyfIJEvTzTyfOfR7R?=
 =?us-ascii?Q?JTgc9iE0PvQRMeUWzXCZ/QofUXW0yVU2OXKQKnHeH1otmWs/qPd28nAemGQj?=
 =?us-ascii?Q?77Pq2CTFmWMcxru7urE3lXDUNkencJB2w+P51TDOrRr/OfGb2fwohRUA29S1?=
 =?us-ascii?Q?HzGJ11u8ypqE6Y3+94Fylh0ShNFrfZplBOhUOsCDH2DmYDeSQllT5N52I+hx?=
 =?us-ascii?Q?hH/l1RpIi+vHFs9zeRPJ42hvf9JndnkNr5/ru0yOxJaK4A9ifn34yy0Ixvrz?=
 =?us-ascii?Q?v3Nyl+4x7s5h48CRCEAEhdp9VFqXkiBj8LhOSBroiAxXpa1V+zCWoLDxQxJZ?=
 =?us-ascii?Q?dN1h86SdTENbaCd/YelKf6IOI6uEIIQQNFB24hdiK7FqOKNgyzmA0kAvefBq?=
 =?us-ascii?Q?jE6HG6tqHSkBToHCDBt3Mn9GVvO5O2cZBtoEeH5sTSK/FlBPae7yQd9sT67V?=
 =?us-ascii?Q?eZvN6CbZqz8POxBGTabKiPedqUcp5fTYC6jA62GbPmBfuSG11CZ/8cYobtAJ?=
 =?us-ascii?Q?VCGOwQnBjoCmvKsE040ghKNewIvyo5Xpo9ECJDXtcEZUz+tJ/mSaMT8+zbii?=
 =?us-ascii?Q?LRpKvwx4pOC9r4kvuXWkvcWfQLkJk5P9S85FmSd1BMmUOlXCW2oxmtzcFjpv?=
 =?us-ascii?Q?7BIaJX3kH1IHX8876+6KyJwxTQExgZrInPJ9hAhXDStucFT+O7pPVD2DnhIb?=
 =?us-ascii?Q?TYY0FcErWr+O35MC8ra+fCiB+AJiA7xXQ4faIQwo98MrKSKYDH7f0ahaJGLU?=
 =?us-ascii?Q?QvSmdG9OkVG1c3VzTERs1OZvPLbU3a/Kl34gJWWYCiS5t+Ueyjisnw3zJ8jS?=
 =?us-ascii?Q?1OfSiXj58fxNSNjz0bkJaaVtHAnsGUXiYLe5wjO3VyyJCYv1a0Dn+VoaehsY?=
 =?us-ascii?Q?Og33xa4th4kv1NMMZvoZmWybDfMhBSjJ75RrbJYtiK7OMiRVooyHX4AABuhK?=
 =?us-ascii?Q?cmwPVsk2v7jkNdEt+TIUZT05KhBbduWV/w+fiMJEY3boRqi/Bj/HmD+gCasH?=
 =?us-ascii?Q?nxENKO1F2+fEjx4acZmDHM2oeVs6qPhM6WDuV8DN3pGdXFFx7i8YqNRbUhgU?=
 =?us-ascii?Q?zm35Qc1j7xBCHTdjTVZrNuWNg+xII6fANLguLJZ1KWyZ+6BlzN1CvETIOqgj?=
 =?us-ascii?Q?D2/aTyulVx2Hk2rGEwxP2hCGreebRigeaMYypN1J2Qi1ed9Qh5IhilNGsVrd?=
 =?us-ascii?Q?uT5Rexo1k6zj3MABiohNXW3MOPmrLleCdta+vRAEEZ2y86SsrBuMRmZbDqHw?=
 =?us-ascii?Q?tGKx6xiI6K/UktZKm6IrP+Nn23udOeoOjC61sKbHuQbr7jtO2ccjhsFsqYo3?=
 =?us-ascii?Q?wcT6DwDi8K0zVHbJBcflomHpjgnlq7kZBnahyj6O1e+6kKxkXA8oThDJR3xT?=
 =?us-ascii?Q?QAnccZ/kMAzXy5msE1gctDccBgd64TnNLaH4sihT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	en5CraDnFyW1uLYFmWpZn7MMr9tu2hDSLX9OKaPqs125KiMrwSPTYzvrmElcRBNiEEpOkGjoj5M9WxfWLzFvHw9b5mnhZ6eEWwPkWiWVEDw+Ess/Lx6BnapHx+REmo0TIdulE7p9q2FhyoGMJsp5JD9y6vJmPXPMh2q2g08H31xKCFNdW6lYqrB0BepD9cWmGPfA2ZecLfuskU/pDplSHHcbTJ1pIqyXU321kwxzwaZ5dHxQ+mEuG5kPIgyfAuOApq7M8wB9kxI6vfpfZQsktjuEnDF2ZySgqMh5tNC+CLMSMSs0cRNKFom/1inXa2MZo/X5uLIEYFXXZH2KmnFBlZtogNVzk7t6UvcpIO92eGtXRnHLbNAvtJ3/QSG7Opwb/ZywgM6/wMy8RwmM/DpilnongGgd223t+yWTHV2ked6MEXDr0J3hjx9izDCqConfuRpkGrUV7GnhIxWu37UUt1uFLDRHt1f8yfDHb6i+w5cdJuzmfxTsIK4QdyPYXa82L/agpJ/zwozCCiUF4hvpdn4HRiKzqqwEhbhm9TJz7tfWaHTR6Spdb5rR2Ux02sCRpDDRysTBfLMNvjyK2qYPqFybmZIz30UUkDGe/XiiYNU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137ebc89-a1c6-4251-28b0-08dcfa7d7b97
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 14:00:03.2538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrLxfx/spweV82dAmZMGgPw07fy9Lye4jJP+sTAHgFeLpPcilMMOrLRwKCPiyaAIohMNAzpxaTLerQ/SOrxWlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6085
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_08,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010101
X-Proofpoint-ORIG-GUID: bi5kmhBU4USutuUcrgc8j-T5-0x3Ntma
X-Proofpoint-GUID: bi5kmhBU4USutuUcrgc8j-T5-0x3Ntma

On Fri, Nov 01, 2024 at 09:30:44AM -0400, Jeff Layton wrote:
> On Fri, 2024-11-01 at 09:18 -0400, Chuck Lever wrote:
> > On Fri, Nov 01, 2024 at 09:05:07AM -0400, Jeff Layton wrote:
> > > On Thu, 2024-10-31 at 09:40 -0400, cel@kernel.org wrote:
> > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > 
> > > > If an async COPY operation happens to be running when the server is
> > > > shut down, notify the requesting client that the copy has completed.
> > > > 
> > > > Since the nfs4_client is going away, seems like this could introduce
> > > > some UAFs.
> > > > 
> > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > ---
> > > >  fs/nfsd/nfs4proc.c | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > index 4c964bce6bd7..51b3f85f3791 100644
> > > > --- a/fs/nfsd/nfs4proc.c
> > > > +++ b/fs/nfsd/nfs4proc.c
> > > > @@ -68,6 +68,8 @@ MODULE_PARM_DESC(nfsd4_ssc_umount_timeout,
> > > >  
> > > >  #define NFSDDBG_FACILITY		NFSDDBG_PROC
> > > >  
> > > > +static void nfsd4_send_cb_offload(struct nfsd4_copy *copy);
> > > > +
> > > >  static u32 nfsd_attrmask[] = {
> > > >  	NFSD_WRITEABLE_ATTRS_WORD0,
> > > >  	NFSD_WRITEABLE_ATTRS_WORD1,
> > > > @@ -1381,8 +1383,10 @@ void nfsd4_shutdown_copy(struct nfs4_client *clp)
> > > >  {
> > > >  	struct nfsd4_copy *copy;
> > > >  
> > > > -	while ((copy = nfsd4_get_copy(clp)) != NULL)
> > > > +	while ((copy = nfsd4_get_copy(clp)) != NULL) {
> > > >  		nfsd4_stop_copy(copy);
> > > > +		nfsd4_send_cb_offload(copy);
> > > > +	}
> > > 
> > > Not sure about a UAF, but it seems like NFS4ERR_DELAY returns might
> > > delay the client destruction for quite a while.
> > 
> > The nfsd4_copy() is removed from the nfs4_client's async_copies
> > list, and the RPC proceeds in the background. It doesn't block the
> > destruction of the CLIENTID.
> > 
> > But it might be a problem for the RPC logic to transmit the call
> > when there's no nfs4_client to dereference. I should probably
> > drop this patch and try a different approach.
> 
> 
> No, I think this will block the client shutdown. After
> nfsd4_shutdown_copy(), it calls nfsd4_shutdown_callback(), which does:
> 
>         flush_workqueue(clp->cl_callback_wq);                         
>         nfsd41_cb_inflight_wait_complete(clp);  
> 
> So the CB_OFFLOAD workqueue jobs will run, and everything will wait for
> clp->cl_cb_inflight to go to 0. That won't happen until the CB_OFFLOAD
> jobs complete.
> 
> No objection from me though if you see a better approach. Dropping this
> one for now seems reasonable.

There is no spec mandate (yet) for CB_OFFLOAD notification on
DESTROY_CLIENTID, so I'm dropping the patch for now.


> > > Maybe this CB_OFFLOAD shouldn't retry on DELAY?

Some logic can be added such that no retry is done. However, if the
client does not respond at all to the CB_OFFLOAD, NFSD's RPC timeout
is still 7 seconds.

We expect this will be exceptionally rare, though -- clients are
typically aware of ongoing COPY operations and generally won't try
to destroy a client ID where there is pending work that they care
about.


> > > >  }
> > > >  #ifdef CONFIG_NFSD_V4_2_INTER_SSC
> > > >  
> > > 
> > > 
> > > -- 
> > > Jeff Layton <jlayton@kernel.org>
> > > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Chuck Lever

