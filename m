Return-Path: <linux-nfs+bounces-6341-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9736971C23
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 16:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70265281316
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 14:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0421B3F23;
	Mon,  9 Sep 2024 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rhg8usfs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yLdDJrWf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB90C178CDE;
	Mon,  9 Sep 2024 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891039; cv=fail; b=Y2Q+7ZfERJaJH+t1VkH3NfB5yzmaasY/BxUcbNx1jt9hCXoSwfIlBaZYJ+aKGl23xlyG8WYILP8ujB+IGSi3yO+SLoP/WqMUxQg0C7iPAX+TmvYtWep35/VRFKWVNQZ9AmtO6Z0fpGxUsyWRdXzERlAWOXL/sGZt0ZsTSxQOcQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891039; c=relaxed/simple;
	bh=EbmqCFnN7/hm0IT1TxaqFc7LPacAJAzDSwxZkH5P/So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lUBX1DlL7vudtsaxniZLXdA6bu/U1IZgZmIQuJNfWM1igbBcy8vds0rSh06E21xpLD7ZKpmEIRgYrL0aWFsfZqrH3ha2mwmD/iRZyJMV8/1YCmePYpfuSKfuJF/V/ofdAxALVb/uU27DAtp1Egh6sauoxw4vQAEWl06PUDmAl0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rhg8usfs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yLdDJrWf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489DfXSc016860;
	Mon, 9 Sep 2024 14:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=w90BeJsr+dalAuh
	yCNFzI0fcfQyJUyMSyovLFWpg7d8=; b=Rhg8usfsBJ3DrBJp+s/sUsBmVt8O9p/
	9EOcJ/e0O6gEsbhIQ0OGtCXT5nt05p4DpKFvBGihwYgpR2Mkb/dRgsktuCH8Lc/G
	BAeDBsOpQmU+nOA8sVgysLB7LD7rjDKBNCa/sIkRg1MMqxw2aSvklj1stK0OSlSO
	Y2rwK64K+iO7OgN0/0w5bMrdcZYGTaj2GtdqMBcyDU/m7KYt47oBJVF8a5wgXs3c
	AfJYPSxBdDVMKgTy9oIlTcHRYRw5dI2yS717gkeM+ZZePN5NE8qdWdyvreyYdvlE
	nKF+1JVw2mLK1GuEYOW0pw2AKwpD9STpvEa53JSv/r3J1NX9zn+lLNA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gd8cu23g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Sep 2024 14:10:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 489DdEmq004196;
	Mon, 9 Sep 2024 14:10:07 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd978520-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Sep 2024 14:10:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKmK11gsnd/v7y9YfQj59K/7vK0MHDKpC+7uLo9Uufc6IUD5CuMqgHzIla5wFNqrqzmQiRMkvF+PIBL4lzNv8IK5NC7cIboLCYRFx198SFFO/0AasjIu/bNb+VFE7734Ir/+BnnU1VpYCBkoNqqrk0ah+67OGtR9WUGkToPSwhgtypxyRJAI5ybeEYkVtxX760IiVBiey9gHgcE2qbMvTzgFaMswKoEiODfVqCuS7lM/CTbuotDdkUa12Uz19bEFM65jo1lTaMjCIsIBjzHr4iLG1MSopBnYkLV/CiolAWudRZA2RqxfL0bv3bWHuJZca25uo1GUZN+vzDep1UR7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w90BeJsr+dalAuhyCNFzI0fcfQyJUyMSyovLFWpg7d8=;
 b=iffV9KKdVZq17J2B+ShGUxIr6koHSXkwKZ+QvhoMzxE7cMlzqAhxRXdBgbqVQOfJamX7QN2IhmE6CTm8cmCvuG2dTcdTIP7tzGX/2XImLR5mtOajXl6nHW2pt+rQ5ost+wGAj/5/i6xZyVjbDRXErQT7+tERTrOaSaeIZjsIackoOgDZFxcuo5GqI2xbbIs2Dj6Wsb22ozw8SvP7ri+Z5eKGXhqUw5ZiQQtpbYB3sPJhHojwDAYTB35TkZ/S/3y6zzM45WXF8fsYnQ4zS17ozxnN7ommSJHvobuC0BXdwe8+hhhMKmNxL8cNnbYm4l4ux3L/wg3S3Pk+Px4C9mo/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w90BeJsr+dalAuhyCNFzI0fcfQyJUyMSyovLFWpg7d8=;
 b=yLdDJrWfMKoa9Ed0Qi8CQZEVl49JakyLetdejBEjf7ppls++2k7psXYaMRSw7jHS+zrHKSYyDdPRmqTWi9GoaWustXQ7HyuLzIJuylP4gsf5w/BRSnY/xV1S+UZuqmW8agDMCyzOL4fz75auh0yAkeQvS3HIwsWQ4Nvt/GrQMkg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.9; Mon, 9 Sep
 2024 14:10:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 14:10:04 +0000
Date: Mon, 9 Sep 2024 10:10:00 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: David Laight <David.Laight@aculab.com>, Scott Mayhew <smayhew@redhat.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "okorniev@redhat.com" <okorniev@redhat.com>,
        "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>,
        "lilingfeng@huaweicloud.com" <lilingfeng@huaweicloud.com>
Subject: Re: [PATCH] nfsd: return -EINVAL when namelen is 0
Message-ID: <Zt8BuA4gxVMpBUcW@tissot.1015granger.net>
References: <20240903111446.659884-1-lilingfeng3@huawei.com>
 <ZthzJiKF6TY0Nv32@aion>
 <cccdc13066204448af7f0fd550f34586@AcuMS.aculab.com>
 <Zt7a2XO-ze1aAM-d@aion>
 <674f0d570dc241bf86294a9c8141a0b4@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674f0d570dc241bf86294a9c8141a0b4@AcuMS.aculab.com>
X-ClientProxiedBy: CH2PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:610:4c::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4531:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa256e2-c5fc-4b86-06d7-08dcd0d919af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YmR1b+pdOdHImstqSrtzWXnXflTXWfQaEwOjvRKDd/tIB2BE2j0yfMWFsJbm?=
 =?us-ascii?Q?tcIU0nZmKHIybpBj+6odbt5wZDtyOQGW1uz7a1msTZ+nJGbf5tjfkk6vm518?=
 =?us-ascii?Q?S5PwVy6O5PXQ9lLUY+ulCqrw6/yWXDmnykdVz+U6rQE3e41juN1rUbQMzoci?=
 =?us-ascii?Q?vpcT/fz5fW+hrSqrkBFLk4JqJSaENoGqfG41BAru03rxfkXDFj1ELg8EbND5?=
 =?us-ascii?Q?7JLb+HdExeNXQ2nchSRsQytV3Gf5x1XBghIJPkLHG1WoJOhGhMUfmgRUl3nB?=
 =?us-ascii?Q?0ad6HEdHDlltW+3ho5F7CCssYcFWrSjANPw12PEo+QLChX/26GAqM9+QLRGQ?=
 =?us-ascii?Q?igQcuOmB50OnAwxcFuqt//7WGGTu/aHJn4YQBozyAKBPn5KFh2jC7vfjOkpq?=
 =?us-ascii?Q?lWGOXT8d11U/SSiyXmwrL6xtOsI7vPQQEKpAKkVHx6WXDh7CVULVGbCliSYR?=
 =?us-ascii?Q?bKwIsu+EjnibqfIcN8RmwileFFpiSlnv3bnjNrvzfZT4wx6veotX84tnNYU3?=
 =?us-ascii?Q?kBhtkPOYgSYRbMOOBRyHeRK0pQecI6QEOQ+3zC7mgtATw3OWrmBWT5znDF3S?=
 =?us-ascii?Q?JvFF1xV1nGXaq9oBuiqZHcCYc7VbQ1BpxN/bXQYvFZcSOC90MulxZxg7u/zg?=
 =?us-ascii?Q?mWj0BRUh6NIfyr4Yz8FM+XcZqkgHN/joLzGj19jxZKFN+XKjXJiMYJxTde02?=
 =?us-ascii?Q?QqPFzruIp0gJxFYGrXWOfYmFjbIwI4nbryCohNy4vHgNZN9JJfNVa2ThhC8f?=
 =?us-ascii?Q?anCFh0DfvGqMnzSdNSBCwp9vR9pW1a+WA3bi4EyXIc6fGUc3Db5+9ssDLtmf?=
 =?us-ascii?Q?My+kbAC61Hd9lZOK5B3Vx2laVynEy6re4fWrIdd82oepeeHNqlQZMTmq1+9K?=
 =?us-ascii?Q?fB9sF2EJ+6G/+JgnXJxpSXrX2F49hDnoyYokplxinHfUvzIv3NN/WY9dVxzJ?=
 =?us-ascii?Q?J13BLt16MapLLcI6O8ulVrj4Vlha3TnWjJBDwRjVZIrrrQMZrHyPxQhvl4Q9?=
 =?us-ascii?Q?dcbyQnXrQv6/h1QMZk4T/sOv9rsFc4tj163hZvSHHP9HM+Wua6hzViL2B5hD?=
 =?us-ascii?Q?7vYTKUmhZQnoppCqE11hlBt4A+92/qytLkVFR5IehGVsnV0p9IbHpRq/RxH5?=
 =?us-ascii?Q?FF/LyZTTyLec6xb/k6L+eNeeDZQ5o/AVnhhJqmOnCf+0Xo/pCyXBmQ1Lle4v?=
 =?us-ascii?Q?c7UaDT/uYoI4ss6tv7h00ByZ8NbhdCRmwEJPwtrywFU/nnWSGHUKFfq/joTQ?=
 =?us-ascii?Q?o8P3US45ymfoV3AyCJUYx8In7W9m7ooeyOvKuPPZtCtFV4dVdtG9f9LqHTep?=
 =?us-ascii?Q?Bu4EoKjSgyJCNukRQIMU/ONoFmjbFtll73R/Oec57gZjqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YPLgXY/VrIpN+JAXVBIMlgjg3nVnxDmqz3XBv8AOtY2EzBDPDnB32sAklF2F?=
 =?us-ascii?Q?KJHOVvUzYT+pyYeU63LzU4inVcVvywyikPxgyaca2WP6g+wDFdkfEEaw4XoR?=
 =?us-ascii?Q?gttacOeIujSAMyI/QtmAXyKM3moIhrN4g87IXBOhErBU1Y01irSos6cnSFUr?=
 =?us-ascii?Q?05gDcHgQrG7rHr6AU6xYs7+SD0us+zmdr2Q8wHZ5VDhvdi3Avd5u7tz8H3KO?=
 =?us-ascii?Q?HzjeOC++JURKq8QJnOtj+1tNzQXvNSNhrJ5mFByaclKgwUxDsEz5bKUbOiy6?=
 =?us-ascii?Q?T+UDIqqQAqG4BFYJikRY88P/Z5aIX0v7Mv6pHWqtInQKFyc4wVA1PgRfgNEk?=
 =?us-ascii?Q?iDlN7yTN3J+wej1aqX8SsiRDvMNX82a9EtNBx19x1vIQAkO2oHixndANOujG?=
 =?us-ascii?Q?f2mlhSsCpV6eM0U4EuJ14+6twtzQpFKizr5Jr6SRZnTiK/bj3bkxSCYgLvfB?=
 =?us-ascii?Q?4aLn6cBgX+mxRxTislw24wYYWEvVkrXYaHb9WM+QOrAAhH0uNTbj/+Xs2cns?=
 =?us-ascii?Q?yNLfh+sF8cn42cngzoIfceVd7yV5MgNcKAfK8UtTCWl7HzqawG/SdkHOpqeY?=
 =?us-ascii?Q?WM/is620qhL6KZY2nw9RpH9vNNwqWWiXcbXpnBkW3dHQpBfzmGVeMz2QMQj3?=
 =?us-ascii?Q?wnTOfNtWhsv0bY+zMxGqGs4raHZv05+s28pHlmomqIocDlSi4flV+zfFcXcx?=
 =?us-ascii?Q?2yVgT8vzRFmisnc7VkDXnLpRME8u4FoW7ovGdbkfKoYpfPj7pC69KQIB6Wy4?=
 =?us-ascii?Q?HkNdk/PEey7WderLH/YslOS55phPwKX414xc4GF0AwbgS0Xq+tFA4gLbjCWj?=
 =?us-ascii?Q?6m9OmAMxfvUjPjOiEUWCJsNNZwIG8flXslA/8SqrL+XZZTRg/edsRJu+4wKy?=
 =?us-ascii?Q?CHQXT0J/LeRCeCjcz8o+HoeH4m79E3JWDuXAyVbAVBD0mBfju6Dg/y3A9QQG?=
 =?us-ascii?Q?woj6DlVr8U6fFA5fTykzZmTrcvRqPetLaY9+ReHnZEWcmo+XyqieHpAJhR19?=
 =?us-ascii?Q?+yu+0Si188Vk5ALuZpv/zy5wIyhPT2T25XsV61yOl2s5KEXwlM7fgPRoAAjy?=
 =?us-ascii?Q?wX3ZS1zGcWth2pSZnfT4kN47bf4D8FDCc8V5iA/p+GkthNSTHJIsoNML/akn?=
 =?us-ascii?Q?2ZOVox92ce1Kr4gsZn5Wvi5ipiCAOm6lBbykw+av7B9OKN/qmnzvTGwwXa+F?=
 =?us-ascii?Q?KOshacAKFKTvqgMF9ZeDaPoTcmXdpg8SqDs95u+4Qvltp8XXEPdlwPcf+1Gv?=
 =?us-ascii?Q?0uEu6xPkJIKAKIlP4UYbGiVNjP/0hGH/69tC3QOeKgUm5xN/Fxtd6XfP7qbp?=
 =?us-ascii?Q?EKxg7ENJ/UsSv5VTWdZzcuW/syAsKT0U1ZqNGzj4z1lr7HwOgj8iSWj6SEJb?=
 =?us-ascii?Q?BaL+pydXBON8uWcVJS0Dh//y4GtWBDvkf5UsL2lR3pVaWutYkDUoyy+wF5Vn?=
 =?us-ascii?Q?SE5m+EJqUKFL7MfjlGd3dsw5Ol4wUT37/zvAZ4qocbH5IYzkocOIbm5DpC5a?=
 =?us-ascii?Q?m0vQJEqyk14cwuz+w7nEJmDgkJz9JcCE0PO2DgwM5opIksAwClqXVlV6TicN?=
 =?us-ascii?Q?y1MeBSioYLl2uVUYhHoR4ZeKmPb/hDsRo5wNOKL4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V22riiSVGlcl0ZPq0WJUjqOqDbBTxShaE8c6rYFF5Ls0CtXMqSBENUpYYNjp/pIv/AJHOWOrORmBugjlTzYZ4N1j0Eb+T4DH3iqBcIy6/IDFAnSK1JHSDLx+Nz/eqQMdatL9yw33q2qlejI7RTA3rrUf1Z3G5HPgkO48LRtPQ7mGV8Rr8qmyX65olUl3Hn+7smtPZ1GLIlo4DNq+LuLB3vAfffziRaUc6D+a3l8ftf/hvx6iKfPOjh4TifFYpu1MZmuhjj2OGl7Sn98VgDEn+5W4pzHp63uGgDVAkK0Dl3399uvWotnT3aZoVq0cJSmjuGD5bLo6y6Z6RWVcXSRtNbrFTbVqodKauCdJPfuz9nIqfLOKkV+cZrehi5hgrrlGzt7RgX67rEBBmpDyux2y1/PUUwApZxWNNOFlIH5AMSs+9yhzDw1ckw9iTXfLHRdspkS/4S6JrhxCQPQmmhLKY71uQpfS9yH91HGzRTLHWFnw0RUK9D3eVh1tHXLjM2mrnbY7frPJQT+7Ppl379q4V9L7PwH1cgy61HmPabssymUsxpmtGlbBjRQDYmTWnF1VBPpnBSyo4tProMH6B0fE7691Tq0tK5lh44pAGb5pBNI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa256e2-c5fc-4b86-06d7-08dcd0d919af
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 14:10:03.9437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kk6N7F1GTo9ZHrbKtCddaESf6sRWL4SpnbaGbys1yUc447GEb7XNDyznkZg5a+dwfU1OApN//xf+R9BdUymNyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_06,2024-09-09_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409090114
X-Proofpoint-ORIG-GUID: MFNKQSeRQW80gadJ8UgGZpaVLZyy7Mgg
X-Proofpoint-GUID: MFNKQSeRQW80gadJ8UgGZpaVLZyy7Mgg

On Mon, Sep 09, 2024 at 11:33:04AM +0000, David Laight wrote:
> From: Scott Mayhew
> > Sent: 09 September 2024 12:24
> ...
> > > > > diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> > > > > index 67d8673a9391..69a3a84e159e 100644
> > > > > --- a/fs/nfsd/nfs4recover.c
> > > > > +++ b/fs/nfsd/nfs4recover.c
> > > > > @@ -809,6 +809,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
> > > > >  			ci = &cmsg->cm_u.cm_clntinfo;
> > > > >  			if (get_user(namelen, &ci->cc_name.cn_len))
> > > > >  				return -EFAULT;
> > > > > +			if (!namelen) {
> > > > > +				dprintk("%s: namelen should not be zero", __func__);
> > > > > +				return -EINVAL;
> > > > > +			}
> > > > >  			name.data = memdup_user(&ci->cc_name.cn_id, namelen);
> > >
> > > Don't you also want an upper bound sanity check?
> > > (or is cn_len only 8 bit?)
> > 
> > Yeah, actually it should probably be checking for namelen >
> > NFS4_OPAQUE_LIMIT.

Scott, can you send me a tested patch? I can squash that in.


> I suspect memdup_user() itself should have a third 'maxlen' argument.
> And probably one that is required to be a compile-time constant.
> 
> Oh, and is dprintk() rate-limited?

No dprintk call site is rate-limited, and they are everywhere in
this code. Since they are off by default, rate-limiting is not a
concern. Also, journald will rate-limit any output from the kernel
to prevent flooding the system lock.


> Not that the message looks very helpful.

The specific message is not helpful; suggestions welcome. But I
prefer having a warning of some kind rather than a silent failure
mode.


-- 
Chuck Lever

