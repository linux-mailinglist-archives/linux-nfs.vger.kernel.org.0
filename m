Return-Path: <linux-nfs+bounces-5978-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3DD9648E0
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 16:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CE31C227CD
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 14:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AFB193067;
	Thu, 29 Aug 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SEggAv9r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NoLjL+on"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5728F1922F1
	for <linux-nfs@vger.kernel.org>; Thu, 29 Aug 2024 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942737; cv=fail; b=n62MctgaxIFI6hijZBibAR+VKCRTuUDAcCVStXseEWNhp9S23FFhNiYve1jmwGgGiy0rfjkwCBCGu48P3282BIVjj0jj93psFuc94z2pNPTSjor0akeJhnR6V9zz65U1YgVRpTVrZM4H3St3NtJ8Gn3GBVsFJePKkSEJjUnOph4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942737; c=relaxed/simple;
	bh=qI4SBo6KTmkKYzQVf6O4CBJ27NyMwWR1tJojh2wACkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CwpmeCMCH0258DSaqcQL+3Olpi6pMCaxAaCdFNMTdsEu2FABAmI1k/jirr0d9qUSEEwXT2tvph0pGOAf5B3nv6G+DZC5uAgigbKPCxSaOwxwvjSESJWwO7GR15/63K/kj5DTvBmLFjPG/uE/UULSGMFG5t0nLpdnLDSjyBbtOWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SEggAv9r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NoLjL+on; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TBQlwV030244;
	Thu, 29 Aug 2024 14:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=yKXS5ak9SHCqV61
	pNkpzUZjGUUuoPmDVDjLX9P5iEV4=; b=SEggAv9r8A7gQetPHtYO9zTmc9YGq0o
	BQdF7KP0n2Gdjs/gHdUw6+8tWmGoRLHq5RB+fJeLqaHRmGwjl1zRZ8oTXO0qlc3L
	Sq9maV8/cilFnrzZnb6EMwTYQtz3kKD/aQEweRjdqc0y7MmjdXaKUaqpJQT8ZImE
	stJ/9ofatnDi5944ecfBJQNdYVradzof3yq5oUkCdW2UPTTsUBU+KhrCkUZWTXNH
	2H8vMb+80HPYDZM3mu8YGTxCcn8SPxcaXXnDFzdh1x8IMWJ7fHc5ZTMfXMCe0byD
	czGQ4ykwp9AEVKSuK/ptg82tEcP0mnFR6AXyLhGhV/2E24JNXZ+jx5w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pup4h4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 14:45:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TEDw80036950;
	Thu, 29 Aug 2024 14:45:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jnb0yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 14:45:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnSh7lqV/Kb6iO52R+VWK2X2nnPS+4SaESf7OqnwUmndcmLUgnooO7H+LswygEqdXXTnNNKIIT5dcdO/fdceAk+ud4dSHCqjMb1G5g2rm9HWD+cSmFoTFMCHXJrGWEwIUShv4VbgpFRLCe0DvCR/OXC8d8g9gfy3VHiFjEH377pa8b6IsR/x4XFIT4fgr04hT2/4IJ0WkXcqJPKfzTNE1AwnDb2oq1ODyRmr6ltfhlNXPGXonlJ3amC3gSPxmYlrwxWD+ZYAt3dcIDh1/zMNoWynZpjDrdlq1L+cRYUZsRDO4W+3EB8QjHdwWbTaI4PeCaiIwyszb84/pGyb2NzFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKXS5ak9SHCqV61pNkpzUZjGUUuoPmDVDjLX9P5iEV4=;
 b=qJfoyTx+LfV4+bUF9hksa1D4NEPn1kHzpdUfAT/uArkuVGl2SOwiBoJFAqxWR6wLnt0YbJZunz8jD6J/LYE9wH74llL4MioJepuUVIS3GMs4E71cXthAgDd7+NuZ/dpfsWEKVG87u1rN8DYc83RnFe/Y78kjYUDdDMtb6fdmTbJOBs6ZqNENJiHDTfhKO8oD72KQ7GvLIGGDPyeWtOil221vFZT+WVeo6iKm2Dnq+gYAowAsKTE6awmMxV96iTIIE9TFNwCtspKSwr8AYevitJ+7KpMGgYJH34rl+tYX1X7VwUxkgh2Maz4oQul7OwlumNxz1VjAij/zhUwmJ32A9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKXS5ak9SHCqV61pNkpzUZjGUUuoPmDVDjLX9P5iEV4=;
 b=NoLjL+onNecvqbgTlysBEMZFwi1s1eCK5U1FlH5eFcb8uHDphHOprOvs32g2NT+WOMi2bSynh58Gth/nee+ycrlJtMwo9TsZ4xy+9tKQ6rgKvN7yqzPA8BEVAGr3N7fstl38S52XgV0VDc3RGqre13447A9Xq+HB8sJfbHpSj9M=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Thu, 29 Aug
 2024 14:45:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 14:45:26 +0000
Date: Thu, 29 Aug 2024 10:45:22 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] xdrgen tool
Message-ID: <ZtCJgjQ8fi4KXKEU@tissot.1015granger.net>
References: <20240827162718.42342-1-cel@kernel.org>
 <4df488607c5d64e44962a696d05d8246164571a5.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4df488607c5d64e44962a696d05d8246164571a5.camel@kernel.org>
X-ClientProxiedBy: CH5P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4722:EE_
X-MS-Office365-Filtering-Correlation-Id: 664c41cd-7351-4119-f8c7-08dcc8393802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?drOrdkwNMolog0/PpAcHWA6HsKNWn756AZ4E5Y6JsB4nKecBRbrQ+xM9CTPT?=
 =?us-ascii?Q?spVeIYP4UWqzRkxJhP1vH7Prg2N9MrdLtB2Tzv4uTDrXfpJDh4wsJbgkktwh?=
 =?us-ascii?Q?QHikkEdK7lic0BMIYHY2BNr6OGeKxSztt3RPDuGiv+GMhfq0WJsxcD3AxaC2?=
 =?us-ascii?Q?qRIWeEfwtBcFZKBcv2mAY6y6wlWuG6moDfGCB26mZhadaC4dHEPUdDaHBFhR?=
 =?us-ascii?Q?e5B2/9Lt2N8BLYEQdV6B2iDPdvLMhINes/CLDwvwYZRoX6f5n4AF34es+0pN?=
 =?us-ascii?Q?D4aEBoBQv7NBYR2nRg0u5trC+O+XPpMjar1fAqS/2y7XrbXtjEAjZR35I2PG?=
 =?us-ascii?Q?3ZQgOxcuJknMqqQhvCNTyoRocPRFwGEWYDc91F6SMIzesrVUizU920wFE/OY?=
 =?us-ascii?Q?SU5GBfGjm+/9JnJnaYOCPRljTNNUfIVLyro9C1813j/f3rHnIJbn5p63IVEg?=
 =?us-ascii?Q?2enkHmZcrsqhoIgBPfuX5Ln2CFtjJsysDcu35N/LulggZgxKNMr1vY2yE6iI?=
 =?us-ascii?Q?hfh+Ri5hAkio4sl87Y0GKNtkE2HYaR0uBGjh0+PdUwYzzIYLeo7Pi32lkIXd?=
 =?us-ascii?Q?UWnSLdjkbHkpemEaYuMzLceUCGORnebnay98OtuQVJ0ib6/UKB8jrdh4aIgN?=
 =?us-ascii?Q?aqtXdiTpRkDNxvJwRg25z0IU/b3tsH+iuHvg69C+XWucfMlS7V26RM6eSkkN?=
 =?us-ascii?Q?h/D0TjWeGQvQM+9Ye4vqHwBv8q2PFLNizaTG3eEOVz/q/pgtWmetKO6evou9?=
 =?us-ascii?Q?xG51ExAWkThkXZeFQSSiOTx0gPlF2Rg+iZD0+CkYOvYJ++FsvNYo7Cr0XynL?=
 =?us-ascii?Q?/1lge7rKgV0T200yq2P2OQrxhHAG+mOmPt2h0T8zHjhpZ3Ct4UHted+aKfmt?=
 =?us-ascii?Q?RxGUpn3th55VZDQ10kTFgWoA9Tg+U94RBy20jMzlllKWNpLx9b1cCg96Mu6W?=
 =?us-ascii?Q?6pnBWwnaAnfh9KFCuOtM2u7YCosCdLJgC6Oc6Gm+K/3yJFGqesDXDQ+KBi5v?=
 =?us-ascii?Q?NURaiHOlH2Kd1AGxO198b47Q22au3n//7FYs4JZguNgOyjgDIiJUmEQPiS7o?=
 =?us-ascii?Q?siRnr3NTAqMTylmshMg8Yzdz8N86ROxh+2FvlUZ+9xeRb2luI8ImzwvpvZ2Q?=
 =?us-ascii?Q?CaEUCHkju9S3OjTyXz6H37IqolePpKY8MaChhSdPF3A5E1+HTt1QuzBXxVNu?=
 =?us-ascii?Q?Qkyx0qiw1h3+KXqh+gnT9mDDFyXFjGzgU9aJEpw9Vf49IsAIvU2MzCM8y+IJ?=
 =?us-ascii?Q?IxcmjkaV0XCDoUgxjWBwlDwZdGzsGL2k6i3IOTNUqxEDeWWHkuQ5NYXESveQ?=
 =?us-ascii?Q?oc8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dRJpcBpjPi0qONWV1hyVOocrCK1Y1U8QI+KgJA0MFXc0ZthRcKVSyaiP8mkB?=
 =?us-ascii?Q?xVyXcXuVuc3z0PM/8cwV83Jffn0PPbZTA85DtrTuP66ZBUXbqSdMUDlAmiTp?=
 =?us-ascii?Q?78JfVqv6r70uzmIQr4z9H7bG85T5bnz31OcqR8Be5dJjNVCKIq6qvVai/xfV?=
 =?us-ascii?Q?6z4/mmZGkBL0bPHnWxy8PL/jK1nnJfju63YC/+R53WJ0FKhHvcoSwLhf/KOU?=
 =?us-ascii?Q?TONDGz6zUB6uVUJ9HvuvRZ/Fc8dEEw3oCfvIksgg6QTf89es05W3QGKvbVDR?=
 =?us-ascii?Q?cA4IJ1h8JAK01d1H9+MAAVdq1VurAQCL5I5NN9tshWbOD2S7M1GisgdhuXuv?=
 =?us-ascii?Q?y08T7xbFI4cdjaC3HXL9Z05Jdlo7AuOVSe40DSQ+My1NIIDUF/f2mOvdANvS?=
 =?us-ascii?Q?6TqXbtR/0Wcu8Fz+M85Be6R4mEmGdcD1Z5frX0A561LZYS4I3btXsrkV4v4w?=
 =?us-ascii?Q?37YVFJHziGLJIVtM3cTrBzE+QmS/aAXhuQlPBmKQ7M1a7IW2IMX1IQrL0GaC?=
 =?us-ascii?Q?wB7zIKl8ji5savNX0VOV1X+H6af3gzvq+oyTEcNvoeDhmB2HmAm6xL5hqOrL?=
 =?us-ascii?Q?3bAiVCsf0kTzpZ2LIJyPfYrDO+Y6EsilK9AP74nKWOZA8/21L4deayhDrJAa?=
 =?us-ascii?Q?KNwmeSYIXVsmDZ+QL/4NjzkKnFioYTKmpxDieGYAJ+AKlcHtgEh6sbqe5sxy?=
 =?us-ascii?Q?UVU10wYnafsElQX5JJOSeT/J70sB+PGfBC9yL9yR4bOIOKJWpKcGKb3V7MiT?=
 =?us-ascii?Q?2tabLwvkxTFAA0Tf1XqdJhBb9l4YQsOIw5LgSi0pDnReeTVjE38T7XC6NTqD?=
 =?us-ascii?Q?7jSnnsHKNgQA6L7mS5pVQ+Q0VFY9Vqeair91uRkzo+DHT+vcyYLD1Iuc9pbE?=
 =?us-ascii?Q?FLROavN1HNN4lJEamS5hIAdNhkIZVqzV+U9sWGLHIkyatpnSLMuEGPTnJkrg?=
 =?us-ascii?Q?h0lMzt37nNC3EzkDh7MI5fF700l921vhkj2yJlHnksiIoTEzw26FSJSWN4Fp?=
 =?us-ascii?Q?m8HAL3XrOivE4JBKKrwPusQZbii7Zg1k7/piZ7ZWxN1j/Z454HbDATOm4LXH?=
 =?us-ascii?Q?DMNVJGIS4aB0VIImZPN96IY6SHlzc+50l6sYqkVTefi7x5sdZ0IZpo3jl7/M?=
 =?us-ascii?Q?tJnwrt04AxOsuBCWWgmeji1IIDhvK1jqLbQYtyseksHUj6kt5mAL2UAtRqhj?=
 =?us-ascii?Q?Zb+YX6f59HZmahqH+/8gNjNZv3jo1fAtR7FRAKMsq4zomUr4HATNqmsDJ0fZ?=
 =?us-ascii?Q?gBbhzkrLGaHWHLYrAzaFr8XKeSJyCfwlkzeMCa+zlxyPLBHQc1OgL5i2bQ/m?=
 =?us-ascii?Q?ykDRIH4hn30W+YVHl/6D5QEeFLAxVJVxrehmetqyDnzSylsfUAtyd3JUee/E?=
 =?us-ascii?Q?Lnu3Chh7d1V9DdLZATmx/aq4tzB7M51aSK/98Fc81+kRT4lw0st+1ZVzbAIn?=
 =?us-ascii?Q?xKK6QZGT+vMqqCa44t2Zm8hl3OpBU3RiZxQdzCYlD1uKR8yUBBcFCE1i+prx?=
 =?us-ascii?Q?PXm/STra4lu/rCDchwzX9+w15lxRggUw0KZq3Eh3CvkXdn1nsxOzJom96eTz?=
 =?us-ascii?Q?AtEeKIJIIvREVe296g8Iwo7G9knCPJOtmZY0ZZ0zxB8ilf4+0PFi6hBBJJOI?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0hshcAxe8uq5Eq0IJ6WrcaWFIzPNY/iUDsAM9jvdOtjDUNcgk1GOFElGPJ1xS0NktkupEB+glXzEXi63YvuMRfJMSnGVkbTzkK2ewD6nUge7NBfO+VdKGZJTKaqcOJnthBe0se8uuV9sbzYQdwGPN/UXQjwKqftWvWAuNXtzv9OnSX++iwySGbXMz2g+Tyh9p7tdZoT397kh/BEoTQt0jEyhteUF9BOkPWtpDSPem++qrNRWVrG6oXSPTA1tV3zi3u/O6GIynyagwKvkacixpkeNxBglF+6Ov8zNQiUAvw4rx9pMKV9kpaEBEYdcZwBuSI3beCsMFqY8yubBeFoj1LlpYy5kJE1oylzLwZN37ikBHpHbmOtyd5kSG9AIG5vuXnypVg2GOumoiQVdWyLdAN9g1IIoZQun2UCSnE88gRfA4VoO5FP0RlefPdLrYROvEcEHRT0Om9prCC0RAYtIHFJiPQq5S0fsrOB7fSaB5z6qziuxR/bDxgR2MCYn9+NBAsPmt6OXKtzFLw0kAxk5ze5QXB2WRXXjeHHOKu1pEJO0IA6xtcgJLiqZQvTX9+QaPwyD6jpikDLLhutKsq5JgoEGxOAS12lnOqFRak32MJ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664c41cd-7351-4119-f8c7-08dcc8393802
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 14:45:26.0608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpzeXtGHFEUBsr60bXX+06xOo5rC2sQmZxnjeExsjZYqNpz8dSIbG0e1SxIpY1R52cAOP9ltGJKceeoutI9YJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4722
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_03,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290102
X-Proofpoint-ORIG-GUID: DTMr7AlXi2HnkudoRqJK0fXrmqSqROWM
X-Proofpoint-GUID: DTMr7AlXi2HnkudoRqJK0fXrmqSqROWM

On Thu, Aug 29, 2024 at 07:26:31AM -0400, Jeff Layton wrote:
> On Tue, 2024-08-27 at 12:27 -0400, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Update of the xdrgen tool.
> > 
> > I don't know what the merge criteria are for a tool like this, but
> > Jeff's delstid work depends on getting this merged first. I could
> > just pop it onto the nfsd-next stack, if folks think that's OK.
> > 
> > Changes include:
> > - Added some support for generating files for client side (not complete)
> > - Added a single SourceGenerator class, all others now inherit from that
> > - Split XDR pointers (optional data) into a separate class and generator
> > - Added Python type hints
> > - Lots of other minor cleanup
> > 
> > Original posting:
> > 
> > https://lore.kernel.org/linux-nfs/20240820144600.189744-1-cel@kernel.org/
> > 
> > Chuck Lever (2):
> >   tools: Add xdrgen
> >   NFSD: Create an initial nfs4_1.x file
> > 
> >  fs/nfsd/nfs4_1.x                              | 164 ++++++
> >  fs/nfsd/nfs4xdr_gen.c                         | 236 +++++++++
> >  fs/nfsd/nfs4xdr_gen.h                         | 100 ++++
> >  include/linux/sunrpc/xdrgen-builtins.h        | 256 +++++++++
> >  tools/net/sunrpc/xdrgen/.gitignore            |   2 +
> >  tools/net/sunrpc/xdrgen/README                | 249 +++++++++
> >  tools/net/sunrpc/xdrgen/__init__.py           |   2 +
> >  .../net/sunrpc/xdrgen/generators/__init__.py  |  49 ++
> >  .../sunrpc/xdrgen/generators/boilerplate.py   |  58 +++
> >  .../net/sunrpc/xdrgen/generators/constant.py  |  20 +
> >  tools/net/sunrpc/xdrgen/generators/enum.py    |  41 ++
> >  tools/net/sunrpc/xdrgen/generators/pointer.py | 283 ++++++++++
> >  tools/net/sunrpc/xdrgen/generators/program.py | 141 +++++
> >  tools/net/sunrpc/xdrgen/generators/struct.py  | 283 ++++++++++
> >  tools/net/sunrpc/xdrgen/generators/typedef.py | 225 ++++++++
> >  tools/net/sunrpc/xdrgen/generators/union.py   | 238 +++++++++
> >  tools/net/sunrpc/xdrgen/grammars/xdr.lark     | 119 +++++
> >  tools/net/sunrpc/xdrgen/subcmds/__init__.py   |   2 +
> >  tools/net/sunrpc/xdrgen/subcmds/header.py     |  88 ++++
> >  tools/net/sunrpc/xdrgen/subcmds/lint.py       |  33 ++
> >  tools/net/sunrpc/xdrgen/subcmds/source.py     | 121 +++++
> >  .../templates/C/boilerplate/header_bottom.j2  |   3 +
> >  .../templates/C/boilerplate/header_top.j2     |  11 +
> >  .../templates/C/boilerplate/source_top.j2     |   5 +
> >  .../templates/C/constants/definition.j2       |   3 +
> >  .../xdrgen/templates/C/enum/decoder/enum.j2   |  19 +
> >  .../templates/C/enum/definition/close.j2      |   7 +
> >  .../templates/C/enum/definition/enumerator.j2 |   2 +
> >  .../templates/C/enum/definition/open.j2       |   3 +
> >  .../xdrgen/templates/C/enum/encoder/enum.j2   |  14 +
> >  .../templates/C/pointer/decoder/basic.j2      |   6 +
> >  .../templates/C/pointer/decoder/close.j2      |   3 +
> >  .../C/pointer/decoder/fixed_length_array.j2   |   8 +
> >  .../C/pointer/decoder/fixed_length_opaque.j2  |   6 +
> >  .../templates/C/pointer/decoder/open.j2       |  22 +
> >  .../C/pointer/decoder/optional_data.j2        |   6 +
> >  .../pointer/decoder/variable_length_array.j2  |  13 +
> >  .../pointer/decoder/variable_length_opaque.j2 |   6 +
> >  .../pointer/decoder/variable_length_string.j2 |   6 +
> >  .../templates/C/pointer/definition/basic.j2   |   5 +
> >  .../templates/C/pointer/definition/close.j2   |   7 +
> >  .../pointer/definition/fixed_length_array.j2  |   5 +
> >  .../pointer/definition/fixed_length_opaque.j2 |   5 +
> >  .../templates/C/pointer/definition/open.j2    |   6 +
> >  .../C/pointer/definition/optional_data.j2     |   5 +
> >  .../definition/variable_length_array.j2       |   8 +
> >  .../definition/variable_length_opaque.j2      |   5 +
> >  .../definition/variable_length_string.j2      |   5 +
> >  .../templates/C/pointer/encoder/basic.j2      |  10 +
> >  .../templates/C/pointer/encoder/close.j2      |   3 +
> >  .../C/pointer/encoder/fixed_length_array.j2   |  12 +
> >  .../C/pointer/encoder/fixed_length_opaque.j2  |   6 +
> >  .../templates/C/pointer/encoder/open.j2       |  20 +
> >  .../C/pointer/encoder/optional_data.j2        |   6 +
> >  .../pointer/encoder/variable_length_array.j2  |  15 +
> >  .../pointer/encoder/variable_length_opaque.j2 |   8 +
> >  .../pointer/encoder/variable_length_string.j2 |   8 +
> >  .../C/program/declaration/argument.j2         |   2 +
> >  .../templates/C/program/declaration/result.j2 |   2 +
> >  .../templates/C/program/decoder/argument.j2   |  21 +
> >  .../templates/C/program/decoder/result.j2     |  22 +
> >  .../templates/C/program/encoder/argument.j2   |  16 +
> >  .../templates/C/program/encoder/result.j2     |  21 +
> >  .../templates/C/struct/decoder/basic.j2       |   6 +
> >  .../templates/C/struct/decoder/close.j2       |   3 +
> >  .../C/struct/decoder/fixed_length_array.j2    |   8 +
> >  .../C/struct/decoder/fixed_length_opaque.j2   |   6 +
> >  .../xdrgen/templates/C/struct/decoder/open.j2 |  12 +
> >  .../C/struct/decoder/optional_data.j2         |   6 +
> >  .../C/struct/decoder/variable_length_array.j2 |  13 +
> >  .../struct/decoder/variable_length_opaque.j2  |   6 +
> >  .../struct/decoder/variable_length_string.j2  |   6 +
> >  .../templates/C/struct/definition/basic.j2    |   5 +
> >  .../templates/C/struct/definition/close.j2    |   7 +
> >  .../C/struct/definition/fixed_length_array.j2 |   5 +
> >  .../struct/definition/fixed_length_opaque.j2  |   5 +
> >  .../templates/C/struct/definition/open.j2     |   6 +
> >  .../C/struct/definition/optional_data.j2      |   5 +
> >  .../definition/variable_length_array.j2       |   8 +
> >  .../definition/variable_length_opaque.j2      |   5 +
> >  .../definition/variable_length_string.j2      |   5 +
> >  .../templates/C/struct/encoder/basic.j2       |  10 +
> >  .../templates/C/struct/encoder/close.j2       |   3 +
> >  .../C/struct/encoder/fixed_length_array.j2    |  12 +
> >  .../C/struct/encoder/fixed_length_opaque.j2   |   6 +
> >  .../xdrgen/templates/C/struct/encoder/open.j2 |  12 +
> >  .../C/struct/encoder/optional_data.j2         |   6 +
> >  .../C/struct/encoder/variable_length_array.j2 |  15 +
> >  .../struct/encoder/variable_length_opaque.j2  |   8 +
> >  .../struct/encoder/variable_length_string.j2  |   8 +
> >  .../templates/C/typedef/decoder/basic.j2      |  17 +
> >  .../C/typedef/decoder/fixed_length_array.j2   |  25 +
> >  .../C/typedef/decoder/fixed_length_opaque.j2  |  17 +
> >  .../typedef/decoder/variable_length_array.j2  |  26 +
> >  .../typedef/decoder/variable_length_opaque.j2 |  17 +
> >  .../typedef/decoder/variable_length_string.j2 |  17 +
> >  .../templates/C/typedef/definition/basic.j2   |  15 +
> >  .../typedef/definition/fixed_length_array.j2  |  11 +
> >  .../typedef/definition/fixed_length_opaque.j2 |  11 +
> >  .../definition/variable_length_array.j2       |  14 +
> >  .../definition/variable_length_opaque.j2      |  11 +
> >  .../definition/variable_length_string.j2      |  11 +
> >  .../templates/C/typedef/encoder/basic.j2      |  21 +
> >  .../C/typedef/encoder/fixed_length_array.j2   |  25 +
> >  .../C/typedef/encoder/fixed_length_opaque.j2  |  17 +
> >  .../typedef/encoder/variable_length_array.j2  |  30 ++
> >  .../typedef/encoder/variable_length_opaque.j2 |  17 +
> >  .../typedef/encoder/variable_length_string.j2 |  17 +
> >  .../xdrgen/templates/C/union/decoder/basic.j2 |   6 +
> >  .../xdrgen/templates/C/union/decoder/break.j2 |   2 +
> >  .../templates/C/union/decoder/case_spec.j2    |   2 +
> >  .../xdrgen/templates/C/union/decoder/close.j2 |   4 +
> >  .../templates/C/union/decoder/default_spec.j2 |   2 +
> >  .../xdrgen/templates/C/union/decoder/open.j2  |  12 +
> >  .../C/union/decoder/optional_data.j2          |   6 +
> >  .../templates/C/union/decoder/switch_spec.j2  |   7 +
> >  .../C/union/decoder/variable_length_array.j2  |  13 +
> >  .../C/union/decoder/variable_length_opaque.j2 |   6 +
> >  .../C/union/decoder/variable_length_string.j2 |   6 +
> >  .../xdrgen/templates/C/union/decoder/void.j2  |   3 +
> >  .../templates/C/union/definition/case_spec.j2 |   2 +
> >  .../templates/C/union/definition/close.j2     |   8 +
> >  .../C/union/definition/default_spec.j2        |   2 +
> >  .../templates/C/union/definition/open.j2      |   6 +
> >  .../C/union/definition/switch_spec.j2         |   3 +
> >  .../xdrgen/templates/C/union/encoder/basic.j2 |  10 +
> >  .../xdrgen/templates/C/union/encoder/break.j2 |   2 +
> >  .../templates/C/union/encoder/case_spec.j2    |   2 +
> >  .../xdrgen/templates/C/union/encoder/close.j2 |   4 +
> >  .../templates/C/union/encoder/default_spec.j2 |   2 +
> >  .../xdrgen/templates/C/union/encoder/open.j2  |  12 +
> >  .../templates/C/union/encoder/switch_spec.j2  |   7 +
> >  .../xdrgen/templates/C/union/encoder/void.j2  |   3 +
> >  tools/net/sunrpc/xdrgen/tests/test.x          |  36 ++
> >  tools/net/sunrpc/xdrgen/xdr_ast.py            | 485 ++++++++++++++++++
> >  tools/net/sunrpc/xdrgen/xdr_parse.py          |  36 ++
> >  tools/net/sunrpc/xdrgen/xdrgen                | 111 ++++
> >  137 files changed, 4392 insertions(+)
> >  create mode 100644 fs/nfsd/nfs4_1.x
> >  create mode 100644 fs/nfsd/nfs4xdr_gen.c
> >  create mode 100644 fs/nfsd/nfs4xdr_gen.h
> >  create mode 100644 include/linux/sunrpc/xdrgen-builtins.h
> >  create mode 100644 tools/net/sunrpc/xdrgen/.gitignore
> >  create mode 100644 tools/net/sunrpc/xdrgen/README
> >  create mode 100644 tools/net/sunrpc/xdrgen/__init__.py
> >  create mode 100644 tools/net/sunrpc/xdrgen/generators/__init__.py
> >  create mode 100644 tools/net/sunrpc/xdrgen/generators/boilerplate.py
> >  create mode 100644 tools/net/sunrpc/xdrgen/generators/constant.py
> >  create mode 100644 tools/net/sunrpc/xdrgen/generators/enum.py
> >  create mode 100644 tools/net/sunrpc/xdrgen/generators/pointer.py
> >  create mode 100644 tools/net/sunrpc/xdrgen/generators/program.py
> >  create mode 100644 tools/net/sunrpc/xdrgen/generators/struct.py
> >  create mode 100644 tools/net/sunrpc/xdrgen/generators/typedef.py
> >  create mode 100644 tools/net/sunrpc/xdrgen/generators/union.py
> >  create mode 100644 tools/net/sunrpc/xdrgen/grammars/xdr.lark
> >  create mode 100644 tools/net/sunrpc/xdrgen/subcmds/__init__.py
> >  create mode 100644 tools/net/sunrpc/xdrgen/subcmds/header.py
> >  create mode 100644 tools/net/sunrpc/xdrgen/subcmds/lint.py
> >  create mode 100644 tools/net/sunrpc/xdrgen/subcmds/source.py
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/boilerplate/header_bottom.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/boilerplate/header_top.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/boilerplate/source_top.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/constants/definition.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/definition/close.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/definition/enumerator.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/definition/open.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/basic.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/close.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_array.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_opaque.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/open.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/optional_data.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_array.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_opaque.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_string.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/basic.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/close.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/fixed_length_array.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/fixed_length_opaque.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/open.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/optional_data.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_array.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_opaque.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_string.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/basic.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/close.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/fixed_length_array.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/fixed_length_opaque.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/open.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/optional_data.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_array.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_opaque.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_string.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/declaration/argument.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/declaration/result.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/decoder/argument.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/decoder/result.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/encoder/argument.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/encoder/result.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/basic.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/close.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_array.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_opaque.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/open.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/optional_data.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_array.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_opaque.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_string.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/basic.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/close.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/fixed_length_array.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/fixed_length_opaque.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/open.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/optional_data.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_array.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_opaque.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_string.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/basic.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/close.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/fixed_length_array.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/fixed_length_opaque.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/open.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/optional_data.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_array.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_opaque.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_string.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/basic.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_array.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_array.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_opaque.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_string.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/basic.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/fixed_length_array.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/fixed_length_opaque.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_array.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_opaque.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_string.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/basic.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_array.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_opaque.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_array.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_opaque.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_string.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/basic.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/break.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/case_spec.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/close.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/default_spec.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/open.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/optional_data.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/switch_spec.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_array.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_opaque.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_string.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/void.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/definition/case_spec.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/definition/close.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/definition/default_spec.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/definition/open.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/definition/switch_spec.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/basic.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/break.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/case_spec.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/close.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/default_spec.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/open.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/switch_spec.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/void.j2
> >  create mode 100644 tools/net/sunrpc/xdrgen/tests/test.x
> >  create mode 100644 tools/net/sunrpc/xdrgen/xdr_ast.py
> >  create mode 100644 tools/net/sunrpc/xdrgen/xdr_parse.py
> >  create mode 100755 tools/net/sunrpc/xdrgen/xdrgen
> > 
> 
> I'm no python expert, but I've been using this while working on the
> delstid and dir-deleg patches.
> 
> Tested-by: Jeff Layton <jlayton@kernel.org>

Thanks, Jeff. I've applied these two to nfsd-next.

-- 
Chuck Lever

