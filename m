Return-Path: <linux-nfs+bounces-2722-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DC689CF8B
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 02:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B381F233BB
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 00:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAA32746A;
	Tue,  9 Apr 2024 00:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iRt8W9Ik";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YD/i/pse"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E7325757
	for <linux-nfs@vger.kernel.org>; Tue,  9 Apr 2024 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712623450; cv=fail; b=NvkivJZkIQNnF+KRNrl8hX+PN++B1uzibeQYFk5RD3TQO/pEJ0gGehCCBRGXB2fAO0OlXU6uPimM0dP9TbNx8BKIn81WR2I9rxkyP3Vh1N7lmDeTC0cREtKXZrkNTaYg6U6Ca43R81bDNtqbyF3fqfTBz3zM/1O2z08Pi0D4G+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712623450; c=relaxed/simple;
	bh=sJ5USJIi6qV9NrQ9axzTJmLHhFgbGfd8GXkX5RxPN3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IO7WxjcvV70WNw0P8grVGomk2F75PIxHeHRCNGPCHGQd8pl86+NWQ3llyLSusSraQUiXYinpskdxnYqu7yg4TvWxRr7MjhDs7bU3cUkbOszA1YSb/+fuPba8ZR+R+18Qd48Hk6Q9ddiWxl2q87KBT0pdjcTuaQb1zo+Dq7OJePU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iRt8W9Ik; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YD/i/pse; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438LnMuO007085;
	Tue, 9 Apr 2024 00:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=JSOLaMG0IwEIi8SeHDbaT0xXVnfNYjqhFavvcl2LrTE=;
 b=iRt8W9IkkYIBl5gzprlDFLknftKpUgrd/2J6Zg2rXXhkYIEGvDFgTO0MqICUlbMJChZy
 IgQzruMhc1lwsKv6G8xAA0fWucKHWZ1vnI/weSDNFVAkIb0zI0qGYbO8SaNukOBJ6Tlf
 S4hh4W0IlJanuGsRclcP7ntzFIYvF28iSeXhdN/sqIQAchAyzz7WWBi5in+vbmWQnoai
 GZB4GIv/jYtvL/VSl4PjthgYkjbn8pdqUdezwE8aix+TG6VZ6aZEF+4bVPLuiqN4pqhr
 e+ol79KiFu5OxNDtSKFU2KSxPW/lMpAvVmRQQjfaPok5KZ4Fv3N/8X7J+RMGDu9t+fPC cA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxxvbysy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 00:43:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 438NGYGs007869;
	Tue, 9 Apr 2024 00:43:57 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu66jm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 00:43:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1LPqoddc+0vnkJqdsJYDncxm5e4MqSlVL/+LW0jIebquM43s73AgFhWyjUq5XWjVSiks/gbUuvfka+J1xNmdJ1zn4MUuQPwku22WXtYyaPpd0yFtsJggRpCod1G4l0Gb2OHzvjbZrw0yJdxeJhF1RsB8PylVjguwsRow7eMXXDIoN9J5u8aM7Gt2T63NLLU72jV69SoSNSof5gZ298ca+Voh39Nef8rJY+i3K9RNi8C5BVQZ2dAG4J7VLvYw6qHaegmv1yWiROUIcwKTAUxGSzykcGtlWI5XqRDwrGasreGmaW2/oh4u6j5w9yu0esV49taE2UoH1KlbLr2TffCMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSOLaMG0IwEIi8SeHDbaT0xXVnfNYjqhFavvcl2LrTE=;
 b=fln1F0zHvJwvW8QBVOb8+JIx9x3ffR41l5IUX81XHBbWxQiKstJ+FetrJT64v9mMS/JRXHersb1DrlRcAlFjefSHdV2CAaZelsfiII9fnxHdPjI50uhcKTY+ivWsRfWlKQ60aMdOygR41tGAzPiD1cJsimXg6uB+ZISpghurITDPkoNYTmFpW4hP18HAFpea5VlQbVcr3r8YxUnwmrlPGfdsQ1ZpSzaqfc0ld+UuKW385qgGjcmRmUwmJWe2840OM5yZuAxMoFglWjVgYPeQ2AOBpeK+46WfteOAalHNXHoHHYvfqGcMgWqadnnoL0JwiOmBWgJMUeojzkwotyzaAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSOLaMG0IwEIi8SeHDbaT0xXVnfNYjqhFavvcl2LrTE=;
 b=YD/i/pseEaFDN8oJuhV+TQL8cXs2gvQNIlD2f+Ea3rExr37aGZyQIdHScKg5aGHrhSx8itCGnZRykzDyM6l/66e4aaxaufM7M+2qDHbclxAq1eenj2OCKXOjLNQ5tH0YY7M61o5FvtPD5azN6Eo7ASVWp91kRdnRMb3CyJYosU0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7281.namprd10.prod.outlook.com (2603:10b6:610:12e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 00:43:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 00:43:52 +0000
Date: Mon, 8 Apr 2024 20:43:49 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Chen Hanxiao <chenhx.fnst@fujitsu.com>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: remove redundant dprintk in exp_rootfh
Message-ID: <ZhSPRTPtGCm4InJ8@tissot.1015granger.net>
References: <20240408150636.417-1-chenhx.fnst@fujitsu.com>
 <171261851499.17212.4957589707094499321@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171261851499.17212.4957589707094499321@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:610:52::37) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7281:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lSKk9quZ59GugqK+uS7/bCAIWT+cHj4sZvSp2rtoYLd3E4FKgFJOk54KpV9UoZZl80/bVUZQ57MubqcPG0LszHt9dbAoJauoBfMApMgNDs3UyBRSQsH2irRm70XVY9TWVzGQ+1WXHYFhsAC5RokC17ZRcvN4VVo8fBaXqL7V9IrpbpH58qzWRs3KTb/DmfBj4aIc0et60GeFGB3j/oe9qq2JV3epD2CGrhYWq0F8pQXZUWfiPSRWe+YvtuP1dB+xY1QIV4umOwIqviCokcpp9AZgkzxNf5jmE5+4LClbDJsUol5eCIkWEBvHNLj76qfkjxndguMWmANnmLnrT3zFRk7AuScWQIAhhhmZGnoBguALr2+SGQ0n5AOs/nd89FaB8YKZ+0cyS6IQVDN+cgh2HRL8gWwu45emaLmxmu6N2+WK+HzSn9xLs8vpUeBJFiiJuFsm5QZ4iVEbZdYr8B8B4Z9Y70A9nU8Iw1fjH92N3JIZDFF6AI9NDkEOEzvnarWeLAq2Q1Wbp+eYUJNuDnHQyA4umY3cgbhqZ8qZeXRVO8IqZ+pj2QvynxmNRdeUNuOlTPAgTGtxXxNoFeCwgzd+Dl6gpGLoJbQkLps+0eJGYU9qypuLNgHdqc/X1lO5PlmNBetFSYh5sB4mKWPeBtCByJeKNcfebmOs62igNLsHahE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VnrTOYI8jJhNZRlg4qnu8W6CpBksOAmoSCgItJsxDIlgCm4SrKINXKXlo6Dn?=
 =?us-ascii?Q?JNrgy5lpA+AFi87ZCCLqtPA9LyQDB/ShmpfKmL10J2MXcgiQuHYdrrx1HUW+?=
 =?us-ascii?Q?DQjLKlSov1Flzj7DQ9aKHrTyAkKOe4gyFeiNZdBxo1dQPV4u3Q9wvltc/+8s?=
 =?us-ascii?Q?/S+8g4mfMqz4j3E6MaRqeR6Q4F0yJrafDLK+lGG7FAFpzMxOFBCIf5CzHW8W?=
 =?us-ascii?Q?kPFjRgjYYvLc7Oigovh/cYMq4XAzJEddOkx9iVH1dVO1mPceJuwQMNzDJsUw?=
 =?us-ascii?Q?qAMBXKB06JmeaDHQu16qG/vJ8FgDMcStzrj9HOApcvLwCkw3e9PtcLM1WRhj?=
 =?us-ascii?Q?oSfnrwLv2rq61K39+LGVJFVV76vvlFiXO8aZ89kuLr4/1BauHftGaOOlKRWn?=
 =?us-ascii?Q?kav+seQgMx/Z916fu2E6C+Ef1xJQM+MaiO1fEhRS0IEEpiPGspumEX6GarMi?=
 =?us-ascii?Q?0YUu0e4VvKmO1F5SkAjHyr3Zorb8quDDsaOPhviFha4zgN70sWvWnxguV3eu?=
 =?us-ascii?Q?aZsbbQsUdMGbczHy6l77FyX/JaxYw/9Et5UCtRbwgalLmsVTRVkY1LGvyNAV?=
 =?us-ascii?Q?dwZr+E8+3W2PjgaYDBOiKJImY2yC1Qe8/zbWTSz1u/5MMOSwKeAKGDHd86E0?=
 =?us-ascii?Q?mczrl6gLMFWGPTABSnD7/dfJb5n7/OzzCKFisGBvTd3pSqcW6EinccYPXFAN?=
 =?us-ascii?Q?Rgwsm4/m8hZFLchVbx35Fk0jCq5IxkyAcb0XTZu22II35RdcTpEthK05Y5iZ?=
 =?us-ascii?Q?vEF6dGW6XrjVp6MrmXkYexL4DtevNu92dEpYFozI0GR+8XiRuEQOsMT1CwnB?=
 =?us-ascii?Q?xvFc2hubBYMsO18957n+OzkOlDF9OCpz2UkFmNuVCZvT10xdbr3grpZ5EuAd?=
 =?us-ascii?Q?dk1cjMSiFo04ta18rBVrYn0UIPUWqznrBohezBS3BCLkLM6PO/rkZpCfRUm4?=
 =?us-ascii?Q?B5fo1rpBrfYHfNlHuAB9hIm/3tdDtMaztHDgp2eRFfi6g32J3iknaJujwvAw?=
 =?us-ascii?Q?EiAhZEUeGxca2FYLTFa+0xAl5F0Fj8lnGQ1CrQnYasqJ3B0NRFkebMjD6UJg?=
 =?us-ascii?Q?hS2t6POUa4PilvGfPwwkP/O8THWpEZpBWn3uKgLUKu8sHULHalXaL0EDfAxn?=
 =?us-ascii?Q?z5QNzREFodBJv4isz0KTXGUmBUWUmiHdBH9XDsYwedrE8dwYPUkGXi/+LJ/H?=
 =?us-ascii?Q?jeRrb0UgOqKfswRRtjHpf4KW/vzjiXbOZwlLRuNkUGXRc4DxtX9FR5yggcdD?=
 =?us-ascii?Q?6OM1yzIaLhaedeLgClbc7zfOrWmPWBfWjseycPEvcET1DsNpNq71PFJak5A8?=
 =?us-ascii?Q?DeooKzuYjajBnUD8flXbMDiUKe84skh53hhmRfC0G27W+xJ+RW9dVOSl2cfo?=
 =?us-ascii?Q?GLh5DqfSY3IhmhP+Pt42IKK0LhNIWgejJ0NhGV92fjnMT1exW4byEn9tnW1/?=
 =?us-ascii?Q?qJWQ8YQvSztGIK4cSQ3Lm8gaLt2uyFHtLMb2nBqFyY48wTpYDe9jhVVEblyk?=
 =?us-ascii?Q?RB7zcWT0msZaCnBuX3FyWboTM7oX24NTCXE2r9+SEwOlBm6/9nw+9pe+I8S4?=
 =?us-ascii?Q?JnOGfPHYziSDUaV2h5bTk5KINylIlle+Kjk19ViUeW9Bx0piwPQ0vN7r7gUP?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9z7zSGTUl9JXniwpm1ZUUjZhJIsIpmlDE8ZIgIqJ5Ol3wN8Ba8B+Q+gME0VFiFmOnhTodfH9B9DBGaWittSQHj/aOcyAMBzzrzzaiptd7xv9pTOvTazAvcPnWm1BrCvLFRCM2lYUnCVNTZfhBCG7yxKfRfTTOs0a4crr7cuwlVeIxMO27jPHbsBRQFHXOQb+sDXfDkfUHkTpIr7riiOfBI/mGKMVRlWvKaKCo43w/VyE0yKW7eWt2puL7rxWhTv9ukunrt+B5RdBHYg0xpr4n09194vFTY4gdAzh+QHRhTv9M+KOvLwCG1qp8+vIc9IJFtUeN4rOvOmP5acZsoo9jC5uUnQuxyHJ5Q50oo0PSDFIkcfd0wOyknPJDurilPST04AUpH3XjfEI2lAU1F5nyyjbJPNqjA4556/yRRxt2c7JoJSyCN4OLjIIWvE/ekrCY/sWxffQ5zpoNDeiR38YyMZjcFP5Bqs9f72boxpAdGv8YI0ClgqQi3H+IAJsaoMtY5rXYYo5m9H/Pb6kJJcCtwzKauAKWBhOptoZ7N9LdNVbChDzfk8P6y4z+a7l9uhrMN8NGy5DkqI315ERqHMFx8FQsZjFfhIqOvx72ubs6Y8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8addfb-a798-4d9a-4fc5-08dc582e20f1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 00:43:52.6522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INpmlNGdJyUjDZbWbOcTPBWi8rRt5XdVjuCDkjwOutepUO0yPJhdJJML+sib1rRY5UVoq8IX+rog9xOWQHS0bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7281
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_18,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=928 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090000
X-Proofpoint-ORIG-GUID: 9q_ZV9XOiXxdvq_Xv6YVB-eAW-yorZjk
X-Proofpoint-GUID: 9q_ZV9XOiXxdvq_Xv6YVB-eAW-yorZjk

On Tue, Apr 09, 2024 at 09:21:54AM +1000, NeilBrown wrote:
> On Tue, 09 Apr 2024, Chen Hanxiao wrote:
> > trace_nfsd_ctl_filehandle in write_filehandle has
> > some similar infos.
> 
> Not all that similar.  The dprintk you are removing includes the inode
> number and sb->s_id which the trace point don't include.
> 
> Why do you think that information isn't needed?

I asked him to remove that dprintk.

Can you say why you think that information is useful to provide
via a dprintk? It doesn't seem useful to system administrators,
IMO.


> > write_filehandle is the only caller of exp_rootfh,
> > so just remove the dprintk parts.
> > 
> > Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> > ---
> >  fs/nfsd/export.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > index 7b641095a665..e7acd820758d 100644
> > --- a/fs/nfsd/export.c
> > +++ b/fs/nfsd/export.c
> > @@ -1027,9 +1027,6 @@ exp_rootfh(struct net *net, struct auth_domain *clp, char *name,
> >  	}
> >  	inode = d_inode(path.dentry);
> >  
> > -	dprintk("nfsd: exp_rootfh(%s [%p] %s:%s/%ld)\n",
> > -		 name, path.dentry, clp->name,
> > -		 inode->i_sb->s_id, inode->i_ino);
> >  	exp = exp_parent(cd, clp, &path);
> >  	if (IS_ERR(exp)) {
> >  		err = PTR_ERR(exp);
> > -- 
> > 2.39.1
> > 
> > 
> > 
> 

-- 
Chuck Lever

