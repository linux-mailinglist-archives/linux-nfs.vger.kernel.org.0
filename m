Return-Path: <linux-nfs+bounces-3528-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C3F8D838B
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 15:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90ED9B273B9
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 13:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2284212C7FB;
	Mon,  3 Jun 2024 13:10:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AF612D1E9
	for <linux-nfs@vger.kernel.org>; Mon,  3 Jun 2024 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717420218; cv=fail; b=MeXV/i4Qu/wTgcxsDmwOdRc6N7SkfhQLMDKmm0NgvBIIyK6WX9Nkf93nyY8RSmk0i1B9SKHKQpERwmSTjHh9NXvzV4eq30dv7L4Uv5yferOwk5UkRwPZznBy0viwz4eUVE4b/wOviIyZw+P1BSxdQ3F7M26RUvlceR7ZxBSm70g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717420218; c=relaxed/simple;
	bh=NcgLdSFe/vQ4kKdNHRnFcFnlAvJGMOnRY+7pHB9hp+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=muTp01NTHz7Sf5UBo9RRgv3bwxc9slhIVF/oIMw54ymJXlMb63eYEGfou4Eo3JcuB5OOMlbpR+gvX2r3PxS93FTvnR5alSF4GBxNVX0sRp6mNQp6p9EpkuNzuFM0g9G2bObPJpKJsHYHUrb9WoaVMSfGk0/bqOXnFhxolqEUgp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 453CFFKK022899;
	Mon, 3 Jun 2024 13:10:11 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3DrI2qQKpywleJ?=
 =?UTF-8?Q?mCcdX2runZmjJL3jcELpbgC55TsgjZ8=3D;_b=3DFiUD02u18IgSnG6xe8H5e82?=
 =?UTF-8?Q?Uy34LY1MlfvHr/W5kAeYSIVUhzsH8Ztvxuwv8KLPt72Zg_d+/XxBfnmHDylBPjR?=
 =?UTF-8?Q?AktfsxJeuIg2p0K7fbCuDn6PkWdHP3AQ0ed0LOzFyVOc0eHKYzV_IpsST5WNwQr?=
 =?UTF-8?Q?6wPZFmWvFyAIQBgFNOm7FH8T6SSyTKfzU4kmkxdZIA0yjsvtPEuRUMLac_1k8vn?=
 =?UTF-8?Q?wQ92LyRuvqu8SBZQOzmDS3csmJBU0VsBOebfk8qVe1IY/V0fEI9GHXBHhpwcoKy?=
 =?UTF-8?Q?_NWeuBpmnv8kYLsVQYGC8hf91ifP0RLUihVVqMieUxaGbBHWyoMR9uVIUs65vbj?=
 =?UTF-8?Q?vrHUXn_Bw=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv58asy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 13:10:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 453Ca5WZ005462;
	Mon, 3 Jun 2024 13:10:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmc4qks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 13:10:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDyA9Eqgn/W9YlAG6weLoD7k/tEB/OcGblDagndy8GNAY12UvY2+HOJoi2QPNZia7NsmgbtbobIf15MKugCBlDZOY3FuO/6J/UnMWDKzDbhzmOfwA0K+JBbpXFI/Qad9Gpn1s4Xwdwr60H0isruMVJu4PvMcG+js31orEfDpCI+ZXuthMgdlqEHMT0xxDXA/PKev8A8K+scjdm6QSD9SkGiiqpf0yueV84Tw6hKgHE6S91qBP7cWdoImfEbQG2n17Li4a9tTzCz5ga+DQbrdSPMnG99RGxSHUB9UakU0OK2/HUv1QsLqXAPXXDf0dcMjMmHh/Ri0i4BG1RnMU1MVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rI2qQKpywleJmCcdX2runZmjJL3jcELpbgC55TsgjZ8=;
 b=Sf+lEfnzprgS6Z6ogZ3ldH6efk5rjdtNc+UimS47trN7E7V0GrHBAoRZ8fVx+8/gIGXDuHM3SOoG7t8M85IbF4Sd6QbfQ2ZpdzoFba8kxo5g2DWOSDGrjXoceBHHfUkcuxI4rqU+/T1ht7rzuteMa+0eiEa2WeZ2F0ghZMR7w29S4x2IifR6goIPqI3P8XZYWFpljg/VU4ngrpebBzSlWbVCh3Y0Wexz9Yc1idww197okj9N4RdmOHinw8g9CttoDK5z1H+d1s/2PNcEv8tj7kHZww3xw39FT8UZhyBZLguKMGOYv7ZfNOgneqw/WOxwE3H/mIAeJ3MoK1RdHu+LVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI2qQKpywleJmCcdX2runZmjJL3jcELpbgC55TsgjZ8=;
 b=Nu+FAmycxxa+hBReB1D5TLOzEJRBwGRSpRoTL19mZc3hqOKAHjPXPFzJXmuYA9Axwgl502dNClAoWH+2RbXzlg97aClls4NP23JOFPJCbPFEOZkiBhPZq98KFDG4xL7DugXnws54mbxVw6e90JPuuhisfzvmnLWn/KtbGeZ2XUY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM3PR10MB7910.namprd10.prod.outlook.com (2603:10b6:0:b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.25; Mon, 3 Jun 2024 13:10:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 13:10:07 +0000
Date: Mon, 3 Jun 2024 09:10:04 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Fix loop termination condition in
 gss_free_in_token_pages()
Message-ID: <Zl3ArO+upgtkE2Z5@tissot.1015granger.net>
References: <20240602221525.4257-1-cel@kernel.org>
 <21189EC9-21A6-4B67-B72A-02F156DD721D@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21189EC9-21A6-4B67-B72A-02F156DD721D@redhat.com>
X-ClientProxiedBy: CH2PR20CA0030.namprd20.prod.outlook.com
 (2603:10b6:610:58::40) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM3PR10MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 459d6889-cde1-42ed-c928-08dc83ce7d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?MJ6JhYnyxZO0Mzxmedhua6f0Yq0SzmqkOjArlNNm6mNB9ZA94ZmbP6tjjvOX?=
 =?us-ascii?Q?Y9hvnC/q0v96RHCxwGJ36PwoeoqU/NIud+M3FzuC8lSR4OFF1bVhqlp+06Z0?=
 =?us-ascii?Q?okEZr4AX/B/QCyL7gEYB+NKcbevZVMrjfDN6bED2ZZAOxH92NV1b9a3hXVaT?=
 =?us-ascii?Q?uEsLBHmgLHxLeZNFO3ATcfG35Ckox2QXtLQHEg8TORSWm2p8vjo82M7hFHNr?=
 =?us-ascii?Q?WOWqaJ6AUbTrdAKIHzUxNA83MibK0EN94loP58KZZHhD9/bDDgf9yUMKsZYx?=
 =?us-ascii?Q?FMBCntAAZqO5/E+5C5IXqwM1dqq4fMa8rtZhuRJR6SarfOe/vYlmo0NWFDG7?=
 =?us-ascii?Q?orvIO3cr6mqUyrlchQFt08gDntevXn28gL98pqcRWEdmvg8yC4L8dpI5lp7p?=
 =?us-ascii?Q?/PiAxgzxw5739BZ14qlCL0BnjTtmcxDxwilg2tnkZbEVpraRdNA2djLo3iPd?=
 =?us-ascii?Q?RGKx2nsSVmDevVGWqYbTKGrwFMAx1PBFRKsbqku6fLsN3dLjkdSfvsO4GNST?=
 =?us-ascii?Q?xBHV3aZW1mONzYp/OH0do22l+bvQmB1N1NLbE9EdYGuoT0fBeeDw0KdgpqYx?=
 =?us-ascii?Q?P7MttN2KIgaes+zSVAeFrffTRMo6NFCO5ZrqswLd1Nu9EvFae2iYu4WTzJKI?=
 =?us-ascii?Q?/sOjAZxubQxK+nFtA9kpMqlMaN+0tZMiFb+KzA11UAUTyPmPYUc1Gaawondp?=
 =?us-ascii?Q?YTS0wBNP+FTl4WqZ5Cxtirc1WCsHc3hjrzDU9w3usbcFZl/SAJFjRLLEF4XN?=
 =?us-ascii?Q?yDDQ6fqiki85LU6JbS8ClIeiigFnvfZn2rtDwyF1bsA/XP3AgIIrISiGafJW?=
 =?us-ascii?Q?DF8OzQ9OpT/l3eCXcugY/vYpGJF5ww0e2JGB2wHZmrk+dH/YFwKqcAvxdlGe?=
 =?us-ascii?Q?51ZSEeUBZdbn6XOUWpU8rAN0K0TNZrgYwbxl3FCDzUybDresSxf+jF6grHt1?=
 =?us-ascii?Q?A06f7Gfk7SB4rYOX/XdmFgPH6OPKFW39B5UqixQ1qEaTLOTN1pfTtrc+xEUu?=
 =?us-ascii?Q?rwn5cjhFP0euFnmfumd8+IjZDQtNXd44gWt5lgccmdGhN2SgGNBT99ppSDW4?=
 =?us-ascii?Q?eo9Z2VZcpfBYAIPEKB8Er3KGEOYhQY9W26uZdd1RqEzHQ6itGRELSWloMOmb?=
 =?us-ascii?Q?DoRH378xK65rqQaL4U0JKGFV2ad3jdFEHMDeKvSkPLCDCVg6Luaw+4j+cpSd?=
 =?us-ascii?Q?TxXVTaOZHz7wLDp9aXwA426Abbjw4wQmhBZDj13kt2etA+pqKPxcID+Me8KA?=
 =?us-ascii?Q?A6iMh74KDW8uOljHvvo2PKg32mCwVkp0hBl6tJYuaw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nHnCHCSxqghzD9i53cTGdjszSBCQ8EOJW2n4bGBPJqf230b6gNpzaFvcbHiE?=
 =?us-ascii?Q?xomwy2Y6jbMM0rk0z/T56gO38JvE6S61M8BZbstJQWm6+JO+3zSv0jZJ/sOd?=
 =?us-ascii?Q?ZccHoPvIlsSSfEt00GN+Tdz1Hv/otTWbVa0lneqApKb5JKBgIAqfXyC9OOO0?=
 =?us-ascii?Q?HJ2nkIlPegwDiqhdOIX1kfn8FO5qunC/nehm26Jan1b4x/UroKmGWo7v+eFj?=
 =?us-ascii?Q?dFWt2U8AbwD3hsVHMmtc0Hq63Ics3AvfKnOoozvLwect34VGBgS4TWrnxz/V?=
 =?us-ascii?Q?F7mgr7fS89YUOGpZvtllk7TypLpz7YnP/3FR0r0hgFs2cP+x+9+2eXMMZ5Xa?=
 =?us-ascii?Q?URSHJC94h2PRGzkeeZ3qxz90T7IV8y9Okf8CnDSAX+lpufmYpb6GggvejhxS?=
 =?us-ascii?Q?zvCjGLpr36jQcyi1tTT7Na/is/etqiL2a170ehvBFbiyuGVMKG3sDGuUE6lq?=
 =?us-ascii?Q?lGnLnUO79RjtH+oSRXWhmeas5Rl1cFNhXEFS8Puav/4NAt55m2CIr7Qb9ivA?=
 =?us-ascii?Q?ds8uNlUoou22ntANvsSQl0L1mxbXGQc8WpeIjc7/Mhxyo85sOzPK8+O2Wu3r?=
 =?us-ascii?Q?12aL1+JTOrsoA75AYeHw//J1RzuCvxv6N4JGYOJ+4bZued5TBDqmi3xs+x9i?=
 =?us-ascii?Q?MpnuFZz1XaY7Mi81AtTW8i6fuqP8Xq6ReL3B1+bswhkJYvOqpB+5Qyu/Zq6F?=
 =?us-ascii?Q?w24PHA6jKAJEQSa6/CKS3CaNwXVyXqjVyql+U3qiTbBiEQSubbOnDlPrGDgT?=
 =?us-ascii?Q?gA59P5EKYjVlIQGyny7N6no+y3gT7XztG/HXk5m8bV78J/W1/2zZKSRaQdeb?=
 =?us-ascii?Q?aDMMU+meSlRXp7gWtXdUPN9txPGvROsk8rVBXhme9zKjDyL3dcUVJf0IHIlS?=
 =?us-ascii?Q?kpNDan7t0lpzhxAdvsa+K+tKhUCDMnKU/g7t65K9J3ZQgMNHfBJL7fh7EsJr?=
 =?us-ascii?Q?LF2mpMkePFmJLGdFIXbR1bGsiEI/xfKFzApaA73WLK5h+AYL+MLipeL4DJ07?=
 =?us-ascii?Q?hTYOdv6Qf7RmWWJIq9dspW+OshmBBFdog2kFL6y2tMYLswwzo2UD57qqjyNJ?=
 =?us-ascii?Q?j6/HH17IC9nZxlYST2TiNp5wHHfu/mLEZl903zDohh0k144tFZj91GUvTVow?=
 =?us-ascii?Q?H1mG3SklTSX3pDckp41ICobZwcRJZwSPuzuBNMOCEegTOPQmarmdTyYBZSkb?=
 =?us-ascii?Q?O73ct/ALtkRHn9btbUcqsJhRN7PMVYKrbHG5NTVUQminhOiMAdNmdqwhPjf5?=
 =?us-ascii?Q?HVBMD923lOS3+dpV0irkQsqYc98DqqdUu3Irt3Ak0+wzJcJ7368YuH3qFDKM?=
 =?us-ascii?Q?8CdRMyQRKPZ60X9+1urwJfg7Y8IPUkwOfS7QK4+KRReekn+OcgMH+UO5Qdbf?=
 =?us-ascii?Q?2pVTDomYj4HzzHYKpzSCqFSyTiamtdKPB6AQhMfpNHJwRGkJhTWg06XHL/jO?=
 =?us-ascii?Q?5ME1y3CQ2RkOeE3jKSeCtw3IiqOcL7dwa/RHnK9YhU2W9ResfobLWeKmYOVA?=
 =?us-ascii?Q?srfWcotBZjBIRggJzRdPfkwo2w5H2Lle+JfuwDttqhLEwvJsKZPL4v8aYJm6?=
 =?us-ascii?Q?oNt2jsPoZuVc1eTFOeSSLMlQ8U0BQXprlaocmEXSIPtllIjzPWkMrpWK9+51?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	65CGcyXPRdabT0hV5VaHIdsrWW6L3vkiFcf9RYieFXKoOs3MeSYUlpLUQ4tPLKtwYyXwmun/O1QLlSj0N2v4m0cuJDU2vmTJCyzYwtDZRY2Fq5pdBPcSAMyXfprCTsdditBQse4qEFlfcYA9juWaCucRtzcnVQk4gwHqR2hnQGbLSSxRsTLczC7EHFrgY3u4dMwSpVAIYotdpI9c+tGg4o/UIn9GysWfTErRLLQrsiHiyuBSpm1vTd5NhlwHcLJ7CMswwNzAL5YVyx08QCeClWzUylzUh7WBxUyHMIAhkQZFFMBJZnG7MFNzaZH6wd9E8DUYMWX8y212iY9qj9vbyrikqt1crE0igvL4OfHMO1w8wCjKQ3IOphHCcbNogKCnbf9rY+EWS8onXUD+Gr8pwVsnUeKA8antI8t2NoSob9MQxu3YybMqGTeqZm4DhAkoU3JoZSd6q5MfUhqY2AT9FtGyy4tedLjg5YgkQEHuHEzmj5Lqt2en4V9n+pGpwFDD34c9ppW9Ozc+uAOd4YB2IgjpMKSBbB4SVrX/pfN6d/rjqUruYwfUrnljLpa/ybiWHivFbd/Emfuo2pnRAvNXO0ZtJH7igzjyEz44xAyWguo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459d6889-cde1-42ed-c928-08dc83ce7d64
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 13:10:07.2484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gb/lUnaIHQRoQEXaVXnob7uoOGU9DpodRm6v4+gkU5K3wy10uYTdYGJPXQFxNFyvh/8t+xBAyfmkjnxmDIhXTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7910
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_08,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=746 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406030110
X-Proofpoint-ORIG-GUID: 2mm5h7mQfvKAB49q8FqFHTstk-1I_QVV
X-Proofpoint-GUID: 2mm5h7mQfvKAB49q8FqFHTstk-1I_QVV

On Mon, Jun 03, 2024 at 08:33:51AM -0400, Benjamin Coddington wrote:
> On 2 Jun 2024, at 18:15, cel@kernel.org wrote:
> 
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > The in_token->pages[] array is not NULL terminated. This results in
> > the following KASAN splat:
> >
> >   KASAN: maybe wild-memory-access in range [0x04a2013400000008-0x04a201340000000f]
> >
> > Fixes: bafa6b4d95d9 ("SUNRPC: Fix gss_free_in_token_pages()")
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> 
> Nice.
> 
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
> 
> Ben
> 

Thank you, Ben. Applied to nfsd-fixes (for 6.10-rc).

-- 
Chuck Lever

