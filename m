Return-Path: <linux-nfs+bounces-5363-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED49A951BFA
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 15:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C2A288750
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 13:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2AE1B0123;
	Wed, 14 Aug 2024 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z9vI+Z5O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0InSQyqG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BFE1AED35;
	Wed, 14 Aug 2024 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642582; cv=fail; b=kLeZexPMn2zuAitdn7UiHacbKLdkYP77TH0aLoVJ7JcGqwc0oen3ZARkdGnzAs3ixzRV7Yc+POEyPTFgMIVYezj/hVwTeKEJkCYkLwO0Z16Toxo97ivLeWc2NLjg0UpxQQSjY2H+FL3aYx0YMNVGvuyId30oWfrm0XWnHiboUV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642582; c=relaxed/simple;
	bh=B8tjXtq8QYDIY3YNH9IFhcEBAV8tIFAh7g6b9Stoe4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J2pD0tDlbGZzI1cpNhb6zCbYg8aeKYCWihlSdEtcIUq/dtmKabgTmXYGKnlyDqrZwB4AQ8rAM0/SQfg6TFlKdPHr+zVNcuZD2DNXYXgGkMs4Dro4j2j5P/XIBwFLTqnNQe2qAfqamBD/sTLKZeDwVzou5hq7qjw/c8veogu4h9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z9vI+Z5O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0InSQyqG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtWAZ015155;
	Wed, 14 Aug 2024 13:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=DBnqZgS75C+kK/7
	lV7Rnb6DkL6Dgbe/ETSIqk/S8KYc=; b=Z9vI+Z5OfFSZjoTgQ8G8F9h0ckdeNcB
	zEaPHcVHB9Y9VsOq/BHSRefwWKj0mfJ2jtMZg83QCSDDg4/5YHzurIZ09s3UoxMt
	0cN8jB9Fjt+EoSSqm9hXHqYnGAoo9EFgXHpeYDPxPjEVOZnnFQNYDvZ22S/BY6Bs
	I4TpEjcR9duMwLHZaOEB3pstg3tUImdFwtP9hPceWpRvwpW1SjwFRc3WhuOCntdU
	/BbrBDavBFMoBcqP4bRhvUwZmBJiBplWiNE75eIrzwA2UIQXdWXyqP9xKPSRhcBG
	C+4LbalVkqc6ru1o6ynuPb211aa9dbV5SwgwyLF3Sf6eyNCUVjmawMg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy030eb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 13:35:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EBn8vk020763;
	Wed, 14 Aug 2024 13:35:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxngef9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 13:35:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwbDsKwSlEeiUF9Gfu48lxUyZLHJRPDc1JCrTpnSjMaVSfUfP5/+QhGC08jGUazQKfylg7L8RNNDEN4AGkGIAgBQwYaloyNA/PcCCxVbk7tERVwic9RIh5KT4dG6eUmd75XoCqGFZn57Ta0y9yWJ7opLeA1rEeKXQ11rLJyN5dghwvY9NkDS7ZaIWZb+5rU22PyklPAlsUALlFOtwmUuCCwG74YSOU2CyEijt8JH5EsX4/xmR7PRVGFjwi+/ZNxZKH0gqHT/Rb+doIGHzIfK0bDqw7qNUu5OzR0berNIf2P+F8siuXnusxGCB+6HffJt0iDF8/Qu9xnaHYoiizJyGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBnqZgS75C+kK/7lV7Rnb6DkL6Dgbe/ETSIqk/S8KYc=;
 b=UBUPpE7aqmst2l7XQ+1ZWt4NWEXyKToOoAMYZhr46wcid3BJiW4VUGJQ2KCdJIE5iEWkSY6K7XKlWrCBhj2ymtEqZ6vtGOg34SHJTuHCjam/JyPUVB4MAVGGEitrUxpPRN5IaYD4ieV8NU7AG7RQD4UsE1UxldpJB7C3/vz0dcnO2OJMqVsAuNNC3fEEbF+Gh5fZfqNuCqA0fdiKqcQXTZ7EYv1wnevElLT58dTb2R6xseKDs/BiTty+He9B704f9Cpdjr+GVFWe2UXdHzozN/b+iWrIx0DUty4QqTbrvqsL/o53SUbWmJ0y613wWgfMOAMR7kn1gxJnO/XZbn7oXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBnqZgS75C+kK/7lV7Rnb6DkL6Dgbe/ETSIqk/S8KYc=;
 b=0InSQyqGQos4YXVcroUZGLO7CROiLcoRKaC6OhV/krI2G2nO0oEFo96+gwmyrUkFiLdsc2JuIjF9Rzl0JvCd15wGdr93QyS7hy7m9UkF/xqBvxW1B8Eil/RAOpLTTxQtF6F22A05qEdz9w9tyh/n5wNh9+esrGiK8Nlqe3yXG/A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5154.namprd10.prod.outlook.com (2603:10b6:208:328::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Wed, 14 Aug
 2024 13:35:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 13:35:27 +0000
Date: Wed, 14 Aug 2024 09:35:22 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        lilingfeng3@huawei.com
Subject: Re: [PATCH] NFSD: remove redundant assignment operation
Message-ID: <ZryymhU+tW9lza3c@tissot.1015granger.net>
References: <20240814112907.904426-1-lilingfeng@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814112907.904426-1-lilingfeng@huaweicloud.com>
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a5e4c24-ccbb-460d-a20f-08dcbc65f588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7OdbQHOtfoGI74ZNocn5z0ZRALCSgKE0BjlOWEOvbuP6TFbbdrj45IP+TN8g?=
 =?us-ascii?Q?hPdio7IhKdq+zPXcN98BHk4tYiez8s5qGXHGo7kIyBYcMttu9U4FajpUEQS0?=
 =?us-ascii?Q?BD0dgpzwk92ZKfZJ1t4E6uTl5nC/lgRoMftOEcacFBhhuWo3/lCfQ8h8lqGz?=
 =?us-ascii?Q?4YXsz6AgVr+TSkGG+G+qhfwMmh8nd/22cDN8/2QFZDI0yg0djtyKH4zM0FBi?=
 =?us-ascii?Q?joSWCBERDyJ/wm7ANebQrC8Bc87iSVt6Xnj44tIdh0O6S2J3EvOPexfMlmTY?=
 =?us-ascii?Q?pBm5YcbQRDqM3xsL5ZBjBqixqzrok+R+E7owGJAkhGD2oXXGkQIjifzQ9d5Y?=
 =?us-ascii?Q?vM7+BYfynEARsBjU0N0XdPPIDNEKrSfV43iXApE0+lv6++nado/C3LwzY53n?=
 =?us-ascii?Q?IWWERFozXStItbsKp9SZBIpt8+8s190zAghMOAJrDxwx3WXv2KPXemQel3gH?=
 =?us-ascii?Q?DhkYI7Gi6Aj9s0l2OYfBQ0Nl1mODY840/yI16A0Nu8JQMTDOwBZHPFxZno28?=
 =?us-ascii?Q?6cpZJP6WMY3Bc+4tGHIXXKOHbcFVLQK/XzMHsxds8+90GmQvAC2mPk5BD3KV?=
 =?us-ascii?Q?/CvCvAw8oDl3QP2D/x2Ld9mwcjDoqsdgxQaJxAS3JusDMZtvNDt1/t9T+Z7g?=
 =?us-ascii?Q?lCw6QSdUfRu3y48/ulA/IPQGSgRAe0gq0LigPSCy+I+qt15vWNJl36MWjZq1?=
 =?us-ascii?Q?F9W4Do8MeWcddh2vAcWoRue6li3xQ2FJ/DcFXZ8X+uhWf9VPXyPMVWyJyOFq?=
 =?us-ascii?Q?IhIAyeehqlN6Og8ZACdF6esbu/RQZWaHvQriYiPf+MkP0P5H6O4vxY+pesmD?=
 =?us-ascii?Q?MBlzX2xp/twG01G0by+j05ebFyu//g3MEevLwqMUIYnvhbsxllDGHrLQ2OYk?=
 =?us-ascii?Q?uGQmuKQEpILuj9DWDVFUztl4YmsZqEn+w/zMi5sZiuWWg8Af6OZ/B0Pgc2zl?=
 =?us-ascii?Q?wSznPbpCbe74TzvZzGQNK7g8j3KV0PUpV2CvOj4n/Q0I42Lf7/I9J7iRCycH?=
 =?us-ascii?Q?sxse0refU9YtVunpBY2aS24ubvAQT5JaBQ+GTcRCy2h+PHyszogZmZ3Vq5eu?=
 =?us-ascii?Q?h+HOQDo/npD9wbH7jVdJqHmKg7d/iNJtz+Ls1HFSlgDLwshRhdCO1FCBv7OT?=
 =?us-ascii?Q?Co/94P7YymGPQ0UdObYDcccJvPFinBNK06dJJqt6kfmR3EIiOoZXKmoFwV2j?=
 =?us-ascii?Q?7Z1JX/Xm6Uy9p/7SwG3Le8NuUtQqlK09zhKdemNCmknLxaKIJRhDBtTAVNk7?=
 =?us-ascii?Q?3+RT4qSYKTNGsVvUB9lQzdcLDAVzlowHCgX17DI+PoU3NOKD2q+HG7QeSZp/?=
 =?us-ascii?Q?ZsToSDJ6kpzFWhLHp9/kuepthe/ycS7fr7u0QHneiBVqSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IkZHxN0HpJhih+MfnpVb3AEaT2vcHauEaahlFyXSkyFhlDIpcXZw0dZ3fKrk?=
 =?us-ascii?Q?ngmc2v6ZrUrO7ikNJCgRX8CAXdFOE48mBZDfzLp2YZiEpe9l+N+gGfIOc5cP?=
 =?us-ascii?Q?nxBIWmpK+JirdR5DC2mkdEVZpCidEW4UNVHGpeQI9V03ivM+/WdbRFVRitA5?=
 =?us-ascii?Q?6aqAVWbcVEMYDNN6H9zDvRYZ4QeQnq6ulMfjGXTE4oCrqzj2tmqTVmM0cAgY?=
 =?us-ascii?Q?oAXNbbk+S0VFSsZ/yP5fFS8rmPW9o1vrmP0gLCD3BYu1RnXfOrkd17b7IbwJ?=
 =?us-ascii?Q?zlLPrlLTarJUv2K642spmyFkKeJGw3wgRjPmG/Y2pq7pHQyqT7UfpOgiX4Yw?=
 =?us-ascii?Q?J7zIdKjmLkKWVrZn7lqQHgNVBDWkLxYrgAKW8Yoxu3R4eVDLU3ALxDJWu3xL?=
 =?us-ascii?Q?SIO1ImczNIVqmKyMvY1ootmTlyaL0AO5uvvPxGRbmEGXcV+2UbjX6zZcS3uq?=
 =?us-ascii?Q?lDiVZf6LHXEAQGw78JNUxCBvFNw1qJ46RJ2fmpNDo//6wKRA44HuhSqNkSDA?=
 =?us-ascii?Q?LED2JY6Tz3BzACjzbrNeDS4btqpfbzblysyHGTMNm8s9bK2Cjp9KBsoiY0kQ?=
 =?us-ascii?Q?ApalPmhfUfCX2zcf479SzQbV2YNxBYMkm12sLa7xbCkGlJY2ZG3VJnFFsAC5?=
 =?us-ascii?Q?Il3BicLi6aTcVexxlv4Bvc9ZL/3Eo8ffdEyKnlg/Fdu5pIheiCF4gsEfPcOs?=
 =?us-ascii?Q?mFNzgk/3rNwmbYXCEujviMm+Cj668sya61OCRwqAfzWzfWY14FehPmTmNHR/?=
 =?us-ascii?Q?00ytOxHV1XcP9cQkq2oXYtAQTVDs5SV0rDzf4lMlxKhZBPKzxi98wj0ODKis?=
 =?us-ascii?Q?0QVER2nBTsjy9h/mrF65bkzHdgrZg1GM7W8oN0fqqvmzEqRW/DaN/JlvG7Uu?=
 =?us-ascii?Q?x4Sb7eQWoYQLErXlJ++agVMmV4c1wgDEfUwz+cUJGjBkX+OhDMJ4sRme9AnQ?=
 =?us-ascii?Q?L/g2FEiDLylDjFYChPBEFlp54izMsBvpPqHB9B5XYcvI2lh9tPZDZDUfcCjw?=
 =?us-ascii?Q?NmwTQ+vuWfbXEAmUl3Op5xgJVUbioIGlLrNBaJSQBScpTVVENT/z9rEYTjJ/?=
 =?us-ascii?Q?jUcZczKfcTe3gJKIiE43BRpDDEXOZ6ts3rMIwrhGZ+GIFmyHFaCe0N5nY2hO?=
 =?us-ascii?Q?OKkJzwuXWtUYPbZKqGboRyRlOcXELq0oYeBMsz/vsy2HcQKLgkh9FcTDDAlS?=
 =?us-ascii?Q?5YhVf+d/dZvzAdQv30dtVTZmxGOkRuqfWs+6BK9hF3mlcjfwHPEnPW0w/rKp?=
 =?us-ascii?Q?exNjddLdavTWErJt/nZsjRUPRu73Q5xrM1NLaJuRMrQgCTNDqjcyBo/mHffU?=
 =?us-ascii?Q?MTMJNysGoWTqO4t4/U2i5Y3KssFvtTzNA+m/0/Xs4q2NydkO06iWRzxlRTPg?=
 =?us-ascii?Q?AD2gB+8G6wB/16f9uw5Wf24iqE0piSsqVyWRG2w13aB6NjTW1Zp66h0rSCpC?=
 =?us-ascii?Q?1IhKEKW3NWWQzyxR3FuA2bbiOIRxOhLMm4wfRa8KuIhBHuMER3qmE3+bcJdB?=
 =?us-ascii?Q?HhNi8agd5xMdwaodG7h450MrZCaMbcESKdcUjoSSUMrzq2KrXGGCYsB8cEmJ?=
 =?us-ascii?Q?Y0ZxLcMi3V3EX6CKwQqarjCMRx2z9PXEVQfFXgRI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7mD77dQK42JNP1M4mJOb9ciCaDD9ek0L5pSjCfm5qGrEhV1eE2uGSqLdewijac3i7O3LOSTCHNy22AilugGIk1/jxfoPUy1yKnyg0XTgWUvvu5hZU8fbF7gIJZGo8ofDwxBYLCEjKZ5fIxfcBh9P8laeUrm7E6MscFKn0v6REGUbEDvGKqM83o94rsMtxNq9xpbPacu/HMCI62MD6B0JtWDL0sDJS6RZCbHjWKu55G0BMPi1N645CoWHHkywPsfuqK28ZtLkw+tJGUlw5Dd2eymakHJr5pSZlMObAACfghelOjjCYWbea88+22Rn0d+GRCpxaD8VXZA01MROIHt7Mmy4qg+jGqMiDtmjyFtT+QCasFxsyt6KPDLMiJDdFYetkogWQJnSCdFsbPxwcuhwxR0qZTXiBydhknN6HJFbkD/i+ThCtUta80ZW+tnUng999zWxSUkTUSKLXq50dINsspE09/7KEVm7uoyzrXOrDNjFVXSwNtjUtEDWQMV7eXK33o3c9VdJr8MTmNANaFqRu9E+kfevWSy3FFc8pkVxuQ4VfuxaCkcms653n+RhfwCGSfjAEheRXfJgDwD7T425RQGJ/vS9jusSGqLPN3WQPGc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5e4c24-ccbb-460d-a20f-08dcbc65f588
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 13:35:27.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dn8IltfuBr791dDFyZh6iqgIOTpNV+7/GEHpfDxlWs3OcpFR9NdEUcfht9O3oENohSArsYSWf/bAgMhyPoPYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_10,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408140095
X-Proofpoint-GUID: skhnVhA8FNuLqP9XzaZNAsfiDEG3ibv5
X-Proofpoint-ORIG-GUID: skhnVhA8FNuLqP9XzaZNAsfiDEG3ibv5

On Wed, Aug 14, 2024 at 07:29:07PM +0800, Li Lingfeng wrote:
> From: Li Lingfeng <lilingfeng3@huawei.com>
> 
> Commit 5826e09bf3dd ("NFSD: OP_CB_RECALL_ANY should recall both read and
> write delegations") added a new assignment statement to add
> RCA4_TYPE_MASK_WDATA_DLG to ra_bmval bitmask of OP_CB_RECALL_ANY. So the
> old one should be removed.
> 
> Fixes: 5826e09bf3dd ("NFSD: OP_CB_RECALL_ANY should recall both read and write delegations")
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>  fs/nfsd/nfs4state.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index a20c2c9d7d45..693f7813a49c 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6644,7 +6644,6 @@ deleg_reaper(struct nfsd_net *nn)
>  					cl_ra_cblist);
>  		list_del_init(&clp->cl_ra_cblist);
>  		clp->cl_ra->ra_keep = 0;
> -		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG);
>  		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
>  						BIT(RCA4_TYPE_MASK_WDATA_DLG);
>  		trace_nfsd_cb_recall_any(clp->cl_ra);
> -- 
> 2.31.1
> 

Applied and pushed to nfsd-next for v6.12.

But I removed the Fixes: tag:
 - This is a clean-up only, so no need to trigger a stable backport
 - The culprit commit is mentioned in the description already

-- 
Chuck Lever

