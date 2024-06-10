Return-Path: <linux-nfs+bounces-3631-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8641390228A
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 15:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379372846CB
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 13:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DEF81ACB;
	Mon, 10 Jun 2024 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YbrtFdql";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LXjHZWVE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE3F4501B
	for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2024 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025462; cv=fail; b=R1C2NEuBReqorMOvyuPYwxWuovP6ghGDAkOYVkU/IS6mJDkJC1dtIEy2t49O0bgDz7icbvkzpDpK/ytjXXL4sDE7AKMwKCca/EZeJWf5pZbw5xsZltmJ4Fak7Vk66ZwKzCl3ycuwNrZxSMjYPrnYnhHtXu+udB2pxXmIKLYWBQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025462; c=relaxed/simple;
	bh=mwJrlxM4gOEaDv7ISADeKyT6UZ5LZJE+rOnq6VAL/Oc=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=mkau8EuJj4pNMjgVR2WGSdAxg5AE+4QtBlphmg3SiSzr30Bx8dDr4rrFYKd7ZEjkwqj+rLrznxgbaIKxB/TL0NX8bjw62zKlFqLJXpDBo89hnqS8R1kGcPVg8W+riCPySUV/it18nl1pwxg3h1FQ/gN96TPO+h3EgS5KzHM3KpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YbrtFdql; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LXjHZWVE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A4BQe0024891
	for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2024 13:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:content-type:mime-version; s=
	corp-2023-11-20; bh=vNHJ+oCkTRLEWDA0gLyyRvihh8ynkVKwb1wRpQ3DcTU=; b=
	YbrtFdqlOaN3RIGmiJ++pUgnL5LJ80GUdaxwUYrc2DtKvNKYYKtvOOJzkz4DZzdg
	yYWOYO6KDs8uJEV9WSofxcdZOXNYntvFm7l/yvLTjW2ZW4U74obKOqEnY0bEx5qc
	UdEHjt0cfURAChJMVDEbr64gbDeOXvXsMabmw+Jp6LpUIyq2CIC6mnuSP7p//xSS
	GiEMsV+w/JATRTlN/5KYXeJPnEb3cZMP3KPZNsqgYpxRoGSxp0vcT4bGnelpn/RK
	lfZ4JRubVLWy9Xuqa+9CUlF++jOtjXCehh7037WBsTTXogQXO+qghKofrfZNB9ra
	/ySv5zpYKvrSeFCilGyeow==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7djh1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2024 13:17:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45AC665r027073
	for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2024 13:17:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdrrw4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2024 13:17:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivZeBqj+qJgA71I8x7TcM07bRBG8/69M1j4HNKxtIxytLl6HvFOen8KqjZCdv+KyXH16x5TGFZwKZyk5IELj2zqEz+cKXt95SxG4BCM8g2hNlXRUgSNFwAjYI3/CDUyfBhYuxxhseW2O5rAHq49hgFmF6H2UbkRofOUagKa/YNvZEAn1vaDnnLawEvArbD5+VUEBqr/EEmXAbEDcSIrzaes4PVOq1+WUCZHMoDiLjdMlxi0UARGPbOc//mdUyzRICX+JEExSd8t507NA0nNRyurX1dco1ooTswzsj2HlFfp1R5pvs9+6Jr7QdkOMMm4vQMlfWvMbHsKhvdTPVJxd4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNHJ+oCkTRLEWDA0gLyyRvihh8ynkVKwb1wRpQ3DcTU=;
 b=TnpHJIu8m6Ydv02ELHdLOqHrGtuzpz2DRe/Mym+IqCjt4hwrLmd+/fXm7W4bGKQ7CWVgz9Zm+5BpqPL/n+8iXqD/mOMBFbrxJyx8Q7e3It216AIUXlUy16jGY7blCCr1LGfSTHyuI/xwCtUYRjxukONvQGFIN1lTI1Yw0xlju/uhLq40WlhR88Ikf3B4bPoKEiqlr56xMEi5wqMOCOg4zkfGq/+B3b52N5kMjDEfqUPRHh4Tq6B0SPpTKvgF5NBgTQUwbX+TVyCuL5qhH/G/zx5ZifVKcrZpI6/mGkmFgUrncRsZpJ5fml1xKn9tZwkFvZwDcbKs/tYnTUS5BT1jFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNHJ+oCkTRLEWDA0gLyyRvihh8ynkVKwb1wRpQ3DcTU=;
 b=LXjHZWVEWO2/R9Jz46PSDKNBmiYwlSQM7ShtGInBrqKXpEl2SCjaPkn/VuOTTZvqCl1EprYvnPzrsXKwIz2O3uHVHSzZ2p0taRW0bzcaXvl4WRZaeseh4T2JNaWSRP9VwyeU3GqHjoP0oO/QzbjKM1DlkQLryWcVSHQkFkAqHwI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6405.namprd10.prod.outlook.com (2603:10b6:806:26b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 13:17:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 13:17:36 +0000
Date: Mon, 10 Jun 2024 09:17:33 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: long-term stable backports of NFSD patches
Message-ID: <Zmb87YiRVeS7KrjQ@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH5P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f74382-e972-49fc-bb61-08dc894fb1fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/APyi744IA+NQ3nMhoL5vlTzo2qlJ/R+mLiCPH0KVUHWXFVc+OkE4uWSC3CH?=
 =?us-ascii?Q?aPERhdO4B77IaCHrNRTDe/l09Ql878/MKyjI30g+G5PLZDME1aZGI9At2Yos?=
 =?us-ascii?Q?1IOS62Z5VF1lNhU0t2J8t9gyozmGuMyAH0AtF6MU8ztEzbpQ5hd4swBDAKjp?=
 =?us-ascii?Q?MRbTDK0FGUz1mZ+rv2vdZOWKwIbrD3UNdep9XrYWB2obABt7Rn9QhNfm+lgU?=
 =?us-ascii?Q?oKPB4/COFKKkGfSlkXovq/t1Pcf5KJ3+JNosqxjKwnNcutnN1WW6YTcUYsud?=
 =?us-ascii?Q?2UbQduzv43Y7EziMCXZW/qhHS6kDNgKkQGWldKgHMDK3rYM+XuaTZjiW3W5K?=
 =?us-ascii?Q?BT1FYgYZzUvGGIxlG+1WVFRoHQlO+tT4fHHosqe0m7c03QnpKcwzC4TAlMqr?=
 =?us-ascii?Q?c72FZQKSVUYY5uioeXO1no0Disyd+VHs/Lg9XQWD2wmbDO04iq7SXjF/IB++?=
 =?us-ascii?Q?SBTDxTeb98tNJjX+g9fsyKjjeVdeUBD5yM9/FbR/cZf6+YYOCQm0MYNZcmH4?=
 =?us-ascii?Q?VF/xZCqYo3+zGh5TA5Nk2V4iqTof3sf2frzyZV5iF1jCaukoAmnYq0G2+pik?=
 =?us-ascii?Q?ue4yilI3zqyv7VIAhirLLUFLcYMDVReSuhvEjpw5iY6mEfnLJsfcIIccFoqP?=
 =?us-ascii?Q?3hu+GFruM2HqGV0DMv8fqRz3I91bBuKB3ndB3/sRCDCdjNboOAgBr+Yy+wtV?=
 =?us-ascii?Q?9XZof80KVUuNCQskMOi0GDL/GsBMPwwTcarfJmugOYP39n7B/RaCpWc7F7dz?=
 =?us-ascii?Q?3PSvmF+ITIczWvmRDikQr281RAPBpgtNiamnXDaUVGGw5rOd49qZBqKQI//z?=
 =?us-ascii?Q?YyLiMPQknZnLVCfCVDmvQyN/O9yTqNCapb5j79wnVFYt+iv+yJzYektiP9oW?=
 =?us-ascii?Q?c3PXmO+DZTgr5CWTfOUSt/WtIDsmTRzbvc99F0kAsbjwvDzxFGTxB0QItOHX?=
 =?us-ascii?Q?TjOKelYNNTXEJjGwxge76hF/nnF8zq04jQ3CvlV7Ta1IKXUrM22uz8i+IP5w?=
 =?us-ascii?Q?PReV89VLE4hwOihw20G/7vJBDFwX+30hVmmg7acQtyGhrfJmLyYDBSk03QUa?=
 =?us-ascii?Q?GGfxvacKuad5ZL/LENFH88dHYrsTXZSMKjCwSrXWxLF4DAn3U4WiJsenIA0e?=
 =?us-ascii?Q?Y9ZkCpkRXRbX5Lga2+lI3z0Z5xf1nGfDK+sRm9t+A317g2zb+DpA7HY40pbR?=
 =?us-ascii?Q?OIWCUclpIGxXW8X2kku50ngR4A/pbpSEyt9aGhQMsqCmI+CAArIldZNQ1CNF?=
 =?us-ascii?Q?4GzETvF470T+evxISIr+?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WNYYZjd4jxWlq9lo876ySchcbQzC6ltOZSTcPMPFC74GPWHUS3Z6oKH6TDz2?=
 =?us-ascii?Q?mATjbPBxl8zP7E6XN0Eg2dcV29D/x0tQXXRfl764wsttUS/tsPzepuhgMhEN?=
 =?us-ascii?Q?QrKdkhKaKXQsrziU36VDylGp1nHScvgrEdubFLMYIHYhr/J0jMOVfKo2AEmI?=
 =?us-ascii?Q?XCbBbz/IqfKgpWRFSL/Ai3ZQChOtXEZMlpcotbMdAFlYy8fI5sxFh0j1bJ6b?=
 =?us-ascii?Q?6jXAoy5azviwHf7OUGY71CblyctNNJF3QGVg7UOkixBK47UqLhC3C2k03uRc?=
 =?us-ascii?Q?wXwEuhjsmf6FVtutvtWXWp6v5/RkWuy7l1+648ByBOvbqp3aF8M8TFQmDZx8?=
 =?us-ascii?Q?Tco2BxE43mqqa+rWT06PDhmlRnnhmCOkbMcvfiKQCI18nGmq2LCWZN73hPDb?=
 =?us-ascii?Q?PYKQ/LR+aA2NrX50g6Kw7NSCWqDWN2zNr6J/qy0ce4UtPrMIiSyMYkTmj7A0?=
 =?us-ascii?Q?Ezhs5PpgTYZH1SgUWYXVedZv8sITz7F9jQm3JsBD8Q/dMeNXjVsMS7dN56fJ?=
 =?us-ascii?Q?immtpQLjY7+SU+TnO5LPiJq4g8TOH8KChmGlSImv962v5LZKmG1qwSvoaLm/?=
 =?us-ascii?Q?7VYDnZXNIdM+V6CguDRYps3jg248/KCUcZTMYlQmx/NOQCbh8TVxfX435nhb?=
 =?us-ascii?Q?yy/tjaIwM4F2W0Z5bakrCfZAv9c3M1YhFGI/W+zlBFAP7uc5sDbhNaGI0hmo?=
 =?us-ascii?Q?fiA86RstQ+lF65sap6cKc73Dgb6u5+4qgmWW+YhfJgPnSjxMVgqmqjHum9Up?=
 =?us-ascii?Q?mgC/ET4PQ3p6GBmsMb9v8fZCCYM0de0YPCjLYHBt2dFqfjee6Pt2vyF2+J2G?=
 =?us-ascii?Q?UpzGGU34M3nTIfXohS3snfMFRpimUuLsPr28r8qdUxNiEMYbw/eicXvXYJXK?=
 =?us-ascii?Q?AhzOy1gzIDkXsp9Y+ECgj4SG2xqj3I3NdF/fMAyiL3Jj8ymmKGNr4RMMpe3T?=
 =?us-ascii?Q?FjtSX7sYC9Q3tlH1f6eb+uufX+FUuhmynXKIu2Xd3xIo0cts37fyB5cGiVK9?=
 =?us-ascii?Q?vEcvXTS50q+2K4GpJ8hxroOX6EyITFheDMN1jAZkyw+2VQqaYpOXgXsTXhi5?=
 =?us-ascii?Q?k9YuwX00R0otKefmfnq7oqGyWCIn3Tz8mnGOnEp6XHAFSLxYOMaoIiHjwS0t?=
 =?us-ascii?Q?o5DVhHzJeNQ86HluMjN+pfUTr6ZfXQWLuRq5DwxIqdrnjxRqdyOL8GbI7BjK?=
 =?us-ascii?Q?7+TfNY95gxUcPWssGuPeCxYXYvdXgLsMVNFayONR58XgpLb4KmmIDxA15QMm?=
 =?us-ascii?Q?Ui6XV72T+optzflAcbE3nL4GpDew767og8eIclNcXZZeQyPR8fw0r2fKQiFk?=
 =?us-ascii?Q?IOnHAxcqjoIr4Gm364wmz1lUMf9I/XSpUCM8Blo3ZWGcRul0HrsCd0z1OpCz?=
 =?us-ascii?Q?guBhWu6hS6/COgIajgZ4unX0+SVro+WKrHFsUAv/Xavsfi5nEOABrfeZROFT?=
 =?us-ascii?Q?Xyk9R4rSA4BMhrXvGhB1lkkxrX9rxaFTBomZ3xXzMDUERr19LmenqmdOgFIU?=
 =?us-ascii?Q?BpPPGEICXwCfUPvr69hO5DdqtF+tVqOYRm+ONRjVxNf4wFvlL8YaVZiqQ0ts?=
 =?us-ascii?Q?VTtkCN9UoBt+oiZjkNTcshAj/qTNvgKOIZF3JFkMWNYxC9d0dGIXUgaUjVs+?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5Rcv2fPuBhn4slEkSEm+t5SBmd8hwBfe6WyaKtyXBhdt4n9yrsIu1ujyOcRfrrwdD7ZTNTZf162UX7IDif2pTIVwsUeS+sedgBT4/p7fU6ZdvF5jpy+bZZ/ECwG7kbr/Gf3qg1Q20mkE81cm3L2aAyYBnCXuUHzO6sADaG1IFpwUaxCAKEDrkinHBoV+uLPyIt6gtwO5ClbzCrjIbHi21ATVIjk9JHyIxq7Tc7irC0GEtTroNon/QaR4lg+vNIaro7wb64R770QE4Dz9O2MvBi9duyVdfTlXNSDwQokIOW8jDMgdmFWnHAKGkGjKMrHjP5gbvwShVgMfP2u4GpVsQa5DBQtOPo5ZXVNE824s62xG0qp8nFFWtcJO3ZQ2HyWzQrFV2DFvftU2JOe5v8lvazhJyBBbTumALJPPAPbWMHaVeAiAj2fh0RBpc5pBCyoESOeZmVjpxdbRUOyAJ4pOKFiV71fs67lf47YWs/Pr9umRrN7WRD1q+Sn71BFee4gFxb5HgSwG925pBJvUs93OxoIvLHz2/1E9xViKs1i6UwA6PCwGQCtYPePGZyBtbPPWFKqNnCvO82FZHvUN0TOojPlgs+OA5pSn1V60HrTLsrA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f74382-e972-49fc-bb61-08dc894fb1fb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 13:17:36.1959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OD26di8qG5ilSl2xS1s4Vn71/cpRvtpfbHeVk4N5TSDXMdVCTlj+xUp3V54+EwMj0Y3aC90nd0PcDEZPiHYxTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6405
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406100100
X-Proofpoint-GUID: oYR-HYa6z1pSx9s0mSONIG9EB4WbdtI2
X-Proofpoint-ORIG-GUID: oYR-HYa6z1pSx9s0mSONIG9EB4WbdtI2

It's apparent that a number of distributions and their customers
remain on long-term stable kernels. We are aware of the scalability
problems and other bugs in NFSD in kernels between v5.4 and v6.1.

To address the filecache and other scalability problems in those
kernels, I'm preparing backported patches of NFSD fixes for several
popular LTS kernels. These backports are destined for the official
LTS kernel branches so that distributions can easily integrate them
into their products.

Once this effort is complete, Greg and Sasha will continue to be
responsible for backporting NFSD-related fixes from upstream into
the LTS kernels.

---

I've pushed the NFSD backports to branches in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

If you are able, I encourage you to pull these, review them or try
them out, and report any issues or successes. I'm currently using
the NFS workflows in kdevops as the testing platform, but am
planning to include other tests.


LTS v5.15.y
The thread freezing fix has been applied to nfsd-5.15.y (in the
repo listed above), has been tested, and submitted to stable@.


LTS v5.10.y

The thread freezing fix has been merged into nfsd-5.10.y and has
been tested. I plan to send this patch series to Greg and Sasha
once they have processed the same fix for v5.15.y.

You can find this series in the "nfsd-5.10.y" branch in the above
repo.


-- 
Chuck Lever

