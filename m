Return-Path: <linux-nfs+bounces-4280-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE7A915680
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 20:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854C4281359
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 18:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CA419F48B;
	Mon, 24 Jun 2024 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jv7CjzfT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sud+62s5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA16182B2
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719253701; cv=fail; b=SKsacKe0sor771NhvHb0gHcTytz5XvXez2qedluzm09D1DlUWSShEZk2OOkirnTQj70nTJnL35ihD8GjRLgk00bZPcdT9/xkOUQC06E9eg5/+T8DCz6dAZ+wX2HOtXrZMce/m3Ffqql9jX2Ax+7Tv3ncxT9vzqmqzRSokq6TZA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719253701; c=relaxed/simple;
	bh=5mQJe8wb/CtH8lZuKl51Y/3tdnHGfXM45YNV08IfABw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IuWp/FtnxJWBbH/otOB5R5XQ6QDbqZ1YVg4JuFMQ8BVJokRQN3FgX5nCRDTYSW/HETPPjXLHnV7wgte1+HPFUQTCrIghIsYt7dA71W8KFJr/LT+zfIPW3U2YQeyfLHnHtU/c/sTGv4rPc7VYduS82QHRdldqC7EEwaGqcXypJ08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jv7CjzfT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sud+62s5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OHUYYx020792;
	Mon, 24 Jun 2024 18:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=087Ih+Zc37r/zAT
	unO9N2/2FfCDflORQmfeDcaT83ho=; b=jv7CjzfTC7cgezO8BZfv6f4nYCtOOX+
	LzRhNU0u86Skmbk1aFNYJb8xU+m5UQQGyIu+x3btJgWtW/Bu9ib8yXR47R50sqru
	AEbg2GZuTBQyDmELcmzyErclPLXSRyqmZ0Z07GTs6FbtcXlVnEvB7OZ4uKT7Am7N
	RZnmG7zgwBvmMa5mC5BEceEUo1TeBmqNAnMljf8aH3qERcorB2V+9oqFbLv5V9ZE
	Ot3+vScFNqiimtKL1FC40xEx0/zoDscldOMnOTZJs+cJ8laGKNONYNfyBYLyelNN
	tfTS48mfIOiYKxFZ3vK9V2IQxSHWFJx1H0mofT5vIUF63EKGMNCNA0Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnhavsds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 18:28:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45OHndfU010771;
	Mon, 24 Jun 2024 18:28:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2cwu92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 18:28:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWjXNbURE9gkSL8jdZmoC7nhUDHoZx1/QzV+4lx0R8QhnkRgOEVfhWC5240RUP2hRpfM4pO8mX5Jivly8rk8jRaG3z3BTJZ1hTGjBSL0llTXOiNvxhounaUWO+fm6wIpF35cx09ZWNDX3B3rHviSxkNcumwDaU9KRDP9dUrPg4z59oaWOwKkRYWQRDSnvd9JP7uqC3C7cfaiqudMq6sQw0lXGCWqrll1kBAOMdluNN4Brx0JHnQ3AgeMs8a0By7w4+oFhL3wwMUvLDKVueKdMtHlF2AzDu/M6aTq2DpbqYeJ60bt0zSYBZ1hUB1Kbze8bZ1lOJG5Q1Xe32Q0mAqe2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=087Ih+Zc37r/zATunO9N2/2FfCDflORQmfeDcaT83ho=;
 b=PLTgNpk3tW8K7snoJ/JihQujYw33IMRiwH0XzBO4oodwH8rBcBlHWlQBhXwEzUtYpB+g942aUkwjWzLMUwoBEhAWOtRwXWDAp/5PUS0Fi64TRHqIiHrh19eM2yw2MmMG/AeC2s9noTeXodwdU76qhAs5p+JtX5QhUEMfpG8GFGfuKQ09+xNKx0oQ4n1l/XNcBOlU3skEketpb/xtERZskpP84UJW7BI/ubpeh7zHfADHBxsPffgQo8eRkG2+f1hc/+8s8shuvQtdCQ5rA6utv0eNVL0rqOj0fDNWbiZEepKgw+sfc0FMeJAyo/G1DimYDrm6H1VO2M9rmFxhpGoR2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=087Ih+Zc37r/zATunO9N2/2FfCDflORQmfeDcaT83ho=;
 b=sud+62s5fh5rQWZ8fg2GETPBpeP2uo2zbBL2ITiFtrc8FuhaZ45LgBvTUnxGb2TlWx06sNilpcm9Qq38F1cRcV22dxX0LqUlV8ZTION6G8/wBfxNJzu+708L+4edukLqzQoM+eXZNCJ1IVODTt8EktamdYHyIt1wFWalW6S1ic8=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 18:28:08 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 18:28:08 +0000
Date: Mon, 24 Jun 2024 14:28:05 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        snitzer@hammerspace.com
Subject: Re: [PATCH v7 11/20] nfs/nfsd: factor out
 {encode,decode}_opaque_fixed to nfs_xdr.h
Message-ID: <Znm6tR3REEi7xVa4@tissot.1015granger.net>
References: <20240624162741.68216-1-snitzer@kernel.org>
 <20240624162741.68216-12-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624162741.68216-12-snitzer@kernel.org>
X-ClientProxiedBy: CH5P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::19) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|SJ0PR10MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a94a25a-8880-4965-fcfd-08dc947b6563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?GeXLk2R6ed9J1WMvOMEXPMlJsvAwsbwE6IugBbcdyAbO10t3rarvvQN+IWQC?=
 =?us-ascii?Q?cX09QHI7mqmkqMgiCGcNyN6QnQewhT1QQ4I9WU0hHfpYYdhF45WyTByr7i3A?=
 =?us-ascii?Q?hNBvHzxtm61i6bOGjXimgALLr/yACKCbAyNRJHjEqOcnsOTxMig+EIfCADqU?=
 =?us-ascii?Q?rtERW4m09YvQFbrHf66J7ONam9zRSC3idAFmW5MV+27ZSpZ84cDJVymFIxhc?=
 =?us-ascii?Q?hywyv33GF3SqmgjnjQ+8y6r5kWGiu/mw7X9sxUCW+EdtSdLSwc55AWKPr2xX?=
 =?us-ascii?Q?DSZ7rVmXm1SkKpwxoy1994Riy+nj9R6IbwFjNLgQki1A+i4NE8TXSiLX3XWr?=
 =?us-ascii?Q?Eiw6I8VEdcxveYaWkKabwxnC3s4KtR8XyLyUswwo8ZKQkPqsEHSDOhYlQECr?=
 =?us-ascii?Q?QZYxJ1bTM85WVqsWOY8iGxVZbd7PPC7olozA4EBTYzi84ufzlpv9oBe+m0bE?=
 =?us-ascii?Q?n5esd+3Ud4P68LvuVGVx4VBFPHiNaTeeFOGT+VEB6bmF+FlE5jEBwP1SGQZ+?=
 =?us-ascii?Q?CZh87tUluj3/ysDscO83fiuqmsY9+Cge335JY7UQDjZhWK9egSvvFl5KMsFo?=
 =?us-ascii?Q?7ZkQo+vgb1GqNq3ddBxtGHNkT/v1puRpKSH/qYZMkzM/TvhJohzqHUHIJ3Lv?=
 =?us-ascii?Q?EZFyt2GCTUpg6f/pTEDTgR4ghT0N0AA2rkfrsFQGshWzYBd0dAcXdNugeoxt?=
 =?us-ascii?Q?/fNG54mHObWXbJaKUY4Qh+oCfX1AcmFUeMvklxae3mmaisclMzDW0JZx3/jj?=
 =?us-ascii?Q?lFytwYOAM1lxt5fsPNYZCenW+ntayQJgfgW4HOulLL+pxShoJAMQ3fw3M2Ti?=
 =?us-ascii?Q?Tt63pZRQRoDgDOwfh67N4UFBizF+bp37MpT1GVMPxQDfVCREDIlc/z/TqdUY?=
 =?us-ascii?Q?ttLTWW5FTuu5btUOmYH2LwdlrYfFLv/N/r3Skxm42JRnMdXYnfjWyu7Goypd?=
 =?us-ascii?Q?1ZKxTqqyjIp/q7rAdn6PSnQUrlfVPHQKi7LLODGHspxbpZ5nbwWH13WmghSP?=
 =?us-ascii?Q?Sk/z/ozEUe8hfyMgBryajLGaT9cYYo2c+06tnVXuGpLpAnpNF62HQCE0RNWV?=
 =?us-ascii?Q?6RYkmcuzjrxBtcLArGTGt2aKGCD2/AFySYOzOUtDyaZrE3UKfnC+s7sCGUO7?=
 =?us-ascii?Q?/oFezxcPYnfSyXrLj8yrOnpToIm4U+gDs5r8es+eF+QHHvRBIOZZSI+semxP?=
 =?us-ascii?Q?0MotU8FASns4cvYrP6I0gLTzU/IOSNR8p2ljJKVyCdOhThgYPGI5otMQYT0b?=
 =?us-ascii?Q?7mhWUiXAek+VSqCZxJcBGjnALIbz8J/2dwAOM84InPG4Jvo/+645Jp6V5rBK?=
 =?us-ascii?Q?aE6M8ZN2brRBhX8CWiQjEM3N?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JWgwU5KidEGvQ9UNMbCsjS+GjJwLntHINfVHnkOpk2HVlIEAB/8648Ik60L6?=
 =?us-ascii?Q?gerlLHN9YJ2VpQE5y++R3uzDN3FJ4WkvlYpM5P4buRLhDROJ7SCP71IkiaYh?=
 =?us-ascii?Q?qhWr8dtqYKIHUOILTWbbhLermccKE1udgK94Q3g9d0uI04L3rkl2Ss6DPFAN?=
 =?us-ascii?Q?MUTIZZOD25QjEDEY9DAw4OG06O6WH60ERbpPTLg1K5Y0ILQoWZ4H2vo/PB76?=
 =?us-ascii?Q?SEbJUW7HoSRmvKVkaAjm1odINGrLtKWCBFxYSVUltcpcq5jcKhL7qRAtT4W7?=
 =?us-ascii?Q?IbB0jY9ceSckE0w9qvNB/iiOXNUokvJR+KBbT7/2nJEDV4A2VsofyEDcohAy?=
 =?us-ascii?Q?Qv16KHUu2kX3OQ3bbmmK21H8HddVmIpzhtLXQeIrZ/pKW+qXy7mIDpdHHH/m?=
 =?us-ascii?Q?SRmA5fZc4dnPdBZQdn2qWrqJ89yMF/F2/TdX7Z4wOyDYP5kPgC3qbykiMU1k?=
 =?us-ascii?Q?d9uaT5iAMe5SyARhT0bOeDRg7ShlFnoV7ISbhpkQkU0SOYETxbudYPGkkScY?=
 =?us-ascii?Q?y9G1090+XE5T/0B0P/UQQpVQ1Q9ZoMGUXQCDeGk9g/x+aII4HmlaQzHtyMqt?=
 =?us-ascii?Q?gVjly/OUm42mh5wesvpgk9PWXg22YZk8Ji5j74R1LPEcLqSZZ6/iT+pqvRtl?=
 =?us-ascii?Q?TCYdV+yelcRQDdcmDoju7jF40+7Tp4FC4vHXQBkGorTHI0DH0GW7bD6ayLz3?=
 =?us-ascii?Q?qOEfpIbygrBaRjX0eneTwzOyJlMZTuZ9Ioo3VdrV4bqWv+lHQ+HgYGO0g3po?=
 =?us-ascii?Q?PxTwPJ33E4HwsaOUCtn2XBNjl+QZ947vcJG+54P6tNDZJb3oegQvh0O6GcDv?=
 =?us-ascii?Q?vjB2wX5xu44zgB7Cmq29vu/FtpDbVO7tcOK8jbERV3FhsCD9r1HRPN6vlpch?=
 =?us-ascii?Q?jKndszrNG7lpez+uMkmHcbIkJUMdiJrEMb5IC+86vEPjcS1qRM+G/X2haqxZ?=
 =?us-ascii?Q?tfTWOLYbyX2xugEoJyxkMmQtUAwzxIn3eUHcQd5ugcsC7yMOhcXOpOb81vN7?=
 =?us-ascii?Q?EDkws0si9J/I6rnnR4l0pyBS5xZLTRI/FjGLuM/AC/OrqDYhXQ+jQkKLjsU1?=
 =?us-ascii?Q?ggVxRuVLpdXWx62QdtSjFP7iCH4BmqL25RO2phLiUxg+N2zd/Vc/0W5RAZgi?=
 =?us-ascii?Q?7JTtwgg96SMgCY1qVyOQYeh9sE5XxItgDYl/ahuXDol+8S8W4xBy9ydPNNaC?=
 =?us-ascii?Q?geK4zbDC3Dgqy/n9FUiTKYPwnrK969QBMKeb8jy0povHyG5yAj51FFDt4P5M?=
 =?us-ascii?Q?oZhLsdOIJMOHC5jyk2NZNdx1yxLFSxtLPiK+wh27cIL6tE2h2svgh0egJPwe?=
 =?us-ascii?Q?R8XfIR33664PrGdXLeUpcGpM4dC1ZchUuNZ87pIjc9LnGET1UuFhIIbgTdXI?=
 =?us-ascii?Q?AbGV/ggh7Z2z5IuHbdf52y1pvPMU41YCh4DfP83JaUQEC68at9tusaYfYEFw?=
 =?us-ascii?Q?nHaDt4186WlkwzreYwAVuvw5GSINCDEtCVE9W4aOsCIpUiRhmTi9a3VHwlEA?=
 =?us-ascii?Q?aB6xgecuTgYknWGL3DX4tj15QqqowaH+EEEdct5nUkJR/J+2H5J62rdK4KtI?=
 =?us-ascii?Q?EMVhWAfbwLg84mZz/5ts1GzlI1BScCRMDllMjuxp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	X6W7Xc+IUBjhNAIPNkWjO5NMyHrpRXQM5lnBzLsTB9rgfDUAsRn7la1naW6bNAUwo42sGAT3qMEBpk4vb0EEgHFRZz7NCBU6C+Q87SZI/KKmTNebbNzmxMHSa0dRlMgvaE383x3eKWJ76e1ZjmbvidolLdMzh0754lukmzY8jGpBrQgLiuto+i7xJDp1afVWgDstb5s0IVU73av7Bm15cOaXNfQx6pKt5F6VdXTbGbj/1z5WnFEUTraMlyLTdVL+UraKLf0Y0Z2s4uyv3HP6MXfxoY6xmngMPeLyj9l/2sVq8P0ExQd2rggpSHXsn4jl8+L5FGO2ne2RChJw9u5ouNZYhnvpvzIxKnfpi2vJ6VNy7UMoCcUmYWjm28DHgGpUq6vvs5BVUPpztYyYIt9M5p/EFhQdRPwXHXxkHVn/RbGgSN/IS1OX/bXVlEMxw4iRbTGozMbaL/dQFiQQWi8KCzF7qL7O88bWPc8hmttflSnfgal+3Op9PNbNUxZrnlmKrkJfPIpStGhjgeWEeZ9Bo+42ZjpWhZQDVyvevjgHpmJ2ADPJvE97U6BKIxpgULiUpwjJGyyU8tw/TdXGgVYI6JAprwbMcbk8RVKoqDjUN2s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a94a25a-8880-4965-fcfd-08dc947b6563
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 18:28:08.4518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7HoX7TG4A93+7BpPcXRseEcbx2RJDHnUoN+e0JWDFiB19AOns09A7DvMAPhOopkBMjtupGef4ulaS5FSvEGmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_15,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=564 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406240147
X-Proofpoint-GUID: mbVfbFkk_2PDuQCyNZkSXYWHjuvbFAwK
X-Proofpoint-ORIG-GUID: mbVfbFkk_2PDuQCyNZkSXYWHjuvbFAwK

On Mon, Jun 24, 2024 at 12:27:32PM -0400, Mike Snitzer wrote:
> Eliminates duplicate functions in various files to allow for
> additional callers.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/flexfilelayout/flexfilelayout.c |  6 ------
>  fs/nfs/nfs4xdr.c                       | 13 -------------
>  include/linux/nfs_xdr.h                | 20 +++++++++++++++++++-
>  3 files changed, 19 insertions(+), 20 deletions(-)

Nit: The "nfsd" can be removed from the Subject line since there are
no NFSD changes in this patch.


> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
> index ec6aaa110a7b..8b9096ad0663 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> @@ -2185,12 +2185,6 @@ static int ff_layout_encode_ioerr(struct xdr_stream *xdr,
>  	return ff_layout_encode_ds_ioerr(xdr, &ff_args->errors);
>  }
>  
> -static void
> -encode_opaque_fixed(struct xdr_stream *xdr, const void *buf, size_t len)
> -{
> -	WARN_ON_ONCE(xdr_stream_encode_opaque_fixed(xdr, buf, len) < 0);
> -}
> -
>  static void
>  ff_layout_encode_ff_iostat_head(struct xdr_stream *xdr,
>  			    const nfs4_stateid *stateid,
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index 1416099dfcd1..ede431ee0ef0 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -968,11 +968,6 @@ static __be32 *reserve_space(struct xdr_stream *xdr, size_t nbytes)
>  	return p;
>  }
>  
> -static void encode_opaque_fixed(struct xdr_stream *xdr, const void *buf, size_t len)
> -{
> -	WARN_ON_ONCE(xdr_stream_encode_opaque_fixed(xdr, buf, len) < 0);
> -}
> -
>  static void encode_string(struct xdr_stream *xdr, unsigned int len, const char *str)
>  {
>  	WARN_ON_ONCE(xdr_stream_encode_opaque(xdr, str, len) < 0);
> @@ -4352,14 +4347,6 @@ static int decode_access(struct xdr_stream *xdr, u32 *supported, u32 *access)
>  	return 0;
>  }
>  
> -static int decode_opaque_fixed(struct xdr_stream *xdr, void *buf, size_t len)
> -{
> -	ssize_t ret = xdr_stream_decode_opaque_fixed(xdr, buf, len);
> -	if (unlikely(ret < 0))
> -		return -EIO;
> -	return 0;
> -}
> -
>  static int decode_stateid(struct xdr_stream *xdr, nfs4_stateid *stateid)
>  {
>  	return decode_opaque_fixed(xdr, stateid, NFS4_STATEID_SIZE);
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index d09b9773b20c..bb460af0ea1f 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -1820,6 +1820,24 @@ struct nfs_rpc_ops {
>  	void	(*disable_swap)(struct inode *inode);
>  };
>  
> +/*
> + * Helper functions used by NFS client and/or server
> + */
> +static inline void encode_opaque_fixed(struct xdr_stream *xdr,
> +				       const void *buf, size_t len)
> +{
> +	WARN_ON_ONCE(xdr_stream_encode_opaque_fixed(xdr, buf, len) < 0);
> +}
> +
> +static inline int decode_opaque_fixed(struct xdr_stream *xdr,
> +				      void *buf, size_t len)
> +{
> +	ssize_t ret = xdr_stream_decode_opaque_fixed(xdr, buf, len);
> +	if (unlikely(ret < 0))
> +		return -EIO;
> +	return 0;
> +}
> +
>  /*
>   * Function vectors etc. for the NFS client
>   */
> @@ -1833,4 +1851,4 @@ extern const struct rpc_version nfs_version4;
>  extern const struct rpc_version nfsacl_version3;
>  extern const struct rpc_program nfsacl_program;
>  
> -#endif
> +#endif /* _LINUX_NFS_XDR_H */
> -- 
> 2.44.0
> 

-- 
Chuck Lever

