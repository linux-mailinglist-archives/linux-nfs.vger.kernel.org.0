Return-Path: <linux-nfs+bounces-2194-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C10D871082
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 23:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA814B23665
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 22:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCAD7C08C;
	Mon,  4 Mar 2024 22:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UYxe5btI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bHsr5QZr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB7B7B3FA
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592872; cv=fail; b=HvYwvX7yrtKPJ7VkRxuXKrCfO9sZY6TIJnoaBmMYky112g3slOGXOxkcPtYBALDfiLCFRKiNwvQaA7YxqUadD1pnI6wR220CDweHvAbVUgPqDblo2al+yTFudO5SNyLw1E0EJyHIvPA9Eotu09r7R++QlBdwJNOQNysGaa6zOH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592872; c=relaxed/simple;
	bh=kkJZnO49sUpfUDiLHkQneXoH5Tw3vCRNtcZLAoPuY2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bIUO7bX02ZuyvIVBZ7MCNuprRhQaRT2zzfsi5jCIQFvBoDYby1TAlSauxi6m2IhJCUBcO5iEEw5nRGR95m20xK8gw1KchlZOiU10XJBr9kv8YKU22rytWoS98GCrS3uFECprSlkuc95lgQQtAN1klP1t0t7QTiMJ7DvSJ8188MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UYxe5btI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bHsr5QZr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424Ixf1k002258;
	Mon, 4 Mar 2024 22:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=K96MSYHCtfrSzjifAA3pUVVa4coQc/qpFjEPZGKgMH8=;
 b=UYxe5btIHyQRFowXm2VBgHJzj7WmX+bmsgJj9ZPhNaSdNTZy4uWutYk5IyyueDLbvYHu
 SoaQ8NclS/Zp1hW5PIss+18DbI7QhTBDV3P6dDwieKitgrOhhuXY2D6FmFeXVBDRu0kT
 y0h/gsL4GIyHRFGZSp/XavUxR7fNf6DEC0qkK3MX9LHHIY4kXzLiF7IcC+NIDGkfw7Sl
 4pZGYafUecKYLePXN6aY39XaPyvCKgTu8akDfyDslNo2cj59CLjOsivU9qMrSYkBvnWA
 /sYfhuhsAduTi8xd+GkhL5GSYINV7cjOiapHKsJwmmHiGbNZC0qxbE32e63uJyqGiDGc AA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5dd0at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 22:54:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424LJAl6017512;
	Mon, 4 Mar 2024 22:54:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj6trfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 22:54:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTE1dI9iBvau8/bGUxPYz5W3VXB/WLOKd65EZSDMSQONSDMgQ9zpiUbBFbj6/uEOQGop3urZSq0LCMTtWz6m9VuRO5qPLbvtgUohxf4oBTZBDMZu+jNIiOyhOwSWyqmfLBC9peh+ArVMdf3pG9ywazmcQGrfIIs1eeCPip02g+kZAfnL63Khk5uzNrf7lstPrTjQbKvdmM/F8okDBON5oiq02V2grnHbddPbAcKQiX2j7ZzWP981BB+tHwSYT8gpCPCikSnLnmEHDUiGq45F/GDb8Jdc9tmzxFJh7ehOBgyiBoFrRCojQtrocpSim+S3Cy+RKQfmYbgJTQ7aYyg1bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K96MSYHCtfrSzjifAA3pUVVa4coQc/qpFjEPZGKgMH8=;
 b=FCa0qV6Bs5tGApw4UGbXPu6lHYivzJKQzF2M5783YtC2DE8dUaOY9ajlkGVOLHmhlfanxgSsd6S+Xkyhjk3Ko0W5n22KuMKug52fHT0UK5ChHTvmUDdhKjuhGjMDVfA4ayv6tsdIHvIDy1aIBl1ZVCoIjM1iHRN9vq4zLMLlUHV+GDrnwYLhvcs0ixnh+YL+oBXiYmMdk4q9Ex0Rk/YiZHFNPdvOGv/I2boZDmXKjjnSQJpE/YWS0QBkwB5ZiomNaeRPirX0CIc1eMUGfXNFb41QLPsoYHwQMI8Xy2pwHeUJrsfe6LlgSrkdtUAGyVGC1lpR3WvXaaT679Q0R6chYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K96MSYHCtfrSzjifAA3pUVVa4coQc/qpFjEPZGKgMH8=;
 b=bHsr5QZrXEVHsJ8ulZbURsjgfvikciYlYSBG+vK0QgLO4ABhnP86EExDvu/Y+x/XkWEzE5S2I4mC8vC4tKvDOAQgihrdK8MZyhC1VKLRQs/bxe17FIGJH2L6I1+BO0FPOpW87nSiilj9U8Ry4GlZRsrQPNjGi1gX0T9rjvie2aQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5176.namprd10.prod.outlook.com (2603:10b6:408:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 22:54:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 22:54:13 +0000
Date: Mon, 4 Mar 2024 17:54:03 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 3/4] nfsd: replace rp_mutex to avoid deadlock in
 move_to_close_lru()
Message-ID: <ZeZRC21DdOkuKroo@manet.1015granger.net>
References: <20240304044304.3657-1-neilb@suse.de>
 <20240304044304.3657-4-neilb@suse.de>
 <ZeXWGJqreYH8aayB@klimt.1015granger.net>
 <170958874536.24797.2684794071853900422@noble.neil.brown.name>
 <ZeZFGdOD3KWkF1Zf@manet.1015granger.net>
 <170959178935.24797.7531672348129457687@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170959178935.24797.7531672348129457687@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:610:e5::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: 5988f3cd-6f24-4848-393e-08dc3c9e02d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	v2rNqZQg5nBOFq9sBuhuPFl2M3UPbv9Q4Qtd4q/ifIwWXhMpdcAT7D1fhWZ+u48cNnG7tcTpELhZffoXUO0CJ5qIGY/3vdCQXs1i/neEMUSZwIx9reQvwt27Kf04/ExGIfUUdZN+8aLYlTfzMDFUTC8mVD523Hx9QzCBnyGL37NOMi7yB9b+CDr6lJvY22gbmfsH6vH8F43r+2498Ga1F/S0kuuKLyGkempCgTDQiY1VA4Gh7VMoDe/nBxt66A6fi0xV54AyTuxD/R8zdh7GO1cieC9pkakr5aCVYrFR1WeGXlhAzA/m93GtbWixVVJaVXi29Md15WfdYkER5U6MCv3MlC959Ld4CxTInjlioIIBDfp82c/1tcSNIDG+oCBaRP9Ys7N3XHqz0tpB3dDNeckI/NIjSATYQdvTkOPg7LFhOmwy7EFkdjijsWMTVEAYf+kubMpoDctC9Hidw1PTq92UlZwJQhV1t34C2vEf4edGTzupmZaDuXvgA9F2YWWqZzQknNsElp2NyLf5JhEh4o/st9v4Cu5xp3BBF0vt0TGjmOWR4V+R74PwUhXwXac+lDbzuyE/HpEyumgRZD4iJXfaBaDG2ONSTKKA9EcUHOvNdABlhSHJMxfTDqSCfe3P4RUuV1Dgkm42n0/h2XgPiaSAJkwzX7gxMJdLXoWs7a0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9yIvVV0KDdnbRt9BMkNJSd7xbNwxdRBBhVm5YXF5dZUMrzOXaDrAnjQENqRj?=
 =?us-ascii?Q?d/QmqTF6tsdVRQ4WB4ZeuM/aGXVsZGCclyvOsTThLeu1Pq1ylPCDWGF6OZRI?=
 =?us-ascii?Q?wXb4+nHIq++N+/YjUKr3Ph/W+X9KRTbunRI6HOX5j3jluNHGn2X4wdSVXb5J?=
 =?us-ascii?Q?tAL4aGwQg2d9fDgLsguRhr8x0h8dq+W3ZBqTewhbo9Hn5NUeWNfuqD2ZstFD?=
 =?us-ascii?Q?a6AxB/FICWR+FCsg7wQVWvfV1m1/9kqmwXiNMs6ic0EIBOss6fsm7EO6ctlK?=
 =?us-ascii?Q?BltVk6DfwZfk/h+3ZxpoLSWs27emOxOu3n8nqdw5bY2RglycCuH4l0OIjh25?=
 =?us-ascii?Q?1NJcQMhsRmltXZFc8lTHqKdpnt65TVuyfgOvVoUrY5O3eXGqKFYd9LUd3UwC?=
 =?us-ascii?Q?sunxInOdfZRDGBLnENsPzLGniI094GtSXfkai378F0zSZV1AXA3E5zufAX+7?=
 =?us-ascii?Q?1/vk6QwHDUBeHPBfMA4JAtxx8Wg04R4mVyIdB6vV5z79aNKZ1eXZUtaFJ0GM?=
 =?us-ascii?Q?DoKMUdmSCSlJSo0ivfgx9NQyZp8faEGWXl6/5BetrHGZlwS2enphybGvMf83?=
 =?us-ascii?Q?j7sGhhbq85Kh+IYFmNQwmGUmxmtf7CrlEexWvYUvHBrLf7ojjwP7PZ67E3Ka?=
 =?us-ascii?Q?LQdh+28pqLoOCJiBuIHlaSo5OqxtwsKEkYA0b0ObKkLGPnQL5cKVpNHEI8Pk?=
 =?us-ascii?Q?QySVlIkPHsJtOpCXSFrkMfAQU/Q3Bck7tyybd65b6sLB5FFJoA8MwhMjs7F2?=
 =?us-ascii?Q?VlHQr13Ct14yHfiZAqF85ghQbHVPNCAlPbRZCba5gjjiRhp8cuqBurJfy+fE?=
 =?us-ascii?Q?QX22HYJAJaXHWfVgvOw2tnqV2NX+qzWgmMdTHsQNIBuz8l77PA0zQfE2zVj5?=
 =?us-ascii?Q?1shUFKD2s4TO36GWgDY6E9Zhq54JcxfTshdAyPedpm6hjnvbrt7JP8nVh98m?=
 =?us-ascii?Q?/R4rxKK8ZLzuDw5eT3oqUTB5xZjgE0JSdGOFoTrB0IHRlK39+w8SZQW+1l9x?=
 =?us-ascii?Q?+fMDWaIpxiXdpKdEeDsZGYDXPXHcOwvoFqAAWjFO/UYAEOFfgpwwM4x5t1rS?=
 =?us-ascii?Q?EeZbeKWhC2sUf+ZLd7CZXdq4HjgTBt2rbClZYyAS7lUhIlmWaVVai36MYPks?=
 =?us-ascii?Q?OIKi1avNXO8a+U3g3/3Pco3okXcT0Nnh4Wq1BVSAHDWJ9ltX0PLBNI4X35uJ?=
 =?us-ascii?Q?q6C0+/bfcupDy4IkDW22EYj0QqjpI1ScIiN2aSflWqO0qTxFC9WXAqAjoU5k?=
 =?us-ascii?Q?KPlWiXRl8flSoNapM16dbL8+qxW23ks07V9kM95h37W3+jeb5RLm8zvCBDvz?=
 =?us-ascii?Q?yLwhnqq3bO068VdZBtIx382uybvv8V0z7e3OCDXJKCJM2Iwp9ovtTAFgjRXa?=
 =?us-ascii?Q?vuC2c7isSwjIERjYSoV0UZgh8kMASP/f9H9pQH1tLQeHp67nx1j5EpJlk5V2?=
 =?us-ascii?Q?PxT+YuFWN1Emnkw6+j4j6aVTemJBHaGqzJKzKby0euipd9P5MTirJwjTk2MK?=
 =?us-ascii?Q?5rwN62tf8UzIm3Y5x+11jvR2pOmwlzjcPvZM30gwqp2Ky0cZ3sva7qqgBA/p?=
 =?us-ascii?Q?KwYS7XDpGF4tF+lGuT2u1HPdFdQDhQOh2Zp8FMo6irF6lnF2+PIFN3a538un?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5T22VSWaXIA3/IlWTyKCZxpxb5YbBIhisZZw/0JhSZnvXc8cUkvqC1rjVyX3waKPdkL109hAD1qjZLQ6LtsfrFvOmr1OuMlOem07w57cGndhc2k+S1SmRIYeZfzDEKYdEfKsoqGfPRxIWMARSrVWoJDOjEM94xcRD9x+bzMDLx8LqrCkKbzBTnfDDeQhsb99ctDvUMUY14WoVNnhqULXx5QqDYRY7YpUKXWiISegLFDbjvgvJfaVhBwBALyMLHy5aX3UZACSA6r/GkN4jKRvPdaL9UTpNCi7+/6LT90R5yTv7q7iT2zMJGOIbMrk9AZSFpP472k5YHCtR2louEmTjx40XaWolDqpYW1IGOFM9YVmROWgr5SHrW4ltojW1ZOGoAr2veHgmaZrhAxlURXdkwD8UYHLyHgxxK8shJxYPW+LOopnD9zbGNNeb8hYC9buHHogNaxcRox+OfpRrwLGx1d8wFmaRImHk6bIejjZfPltRFd8zjKjNnyx8b0l6Tsmn0FC0qFzWWPVNxx/1BimqD2CbgqhPzapEBd8JFFr/dWFh99YpI9TloRNGy6Jk3nFHqAQAHy/q9yTDe8BD25323lNzWHll3r8UVIWMNeC7cs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5988f3cd-6f24-4848-393e-08dc3c9e02d9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 22:54:13.0998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMJCXF6YbqwIW74yyDEiI0ptnRhNnm/E4p/y8Qb3mzSlsOqNlzM3pc47syt/L3vd5QHO+7PrU9AXWDcpHeppdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5176
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_18,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040178
X-Proofpoint-GUID: R97WrVpHQ6mZY6Z28eFpyK1_-v_uowJd
X-Proofpoint-ORIG-GUID: R97WrVpHQ6mZY6Z28eFpyK1_-v_uowJd

On Tue, Mar 05, 2024 at 09:36:29AM +1100, NeilBrown wrote:
> On Tue, 05 Mar 2024, Chuck Lever wrote:
> > On Tue, Mar 05, 2024 at 08:45:45AM +1100, NeilBrown wrote:
> > > On Tue, 05 Mar 2024, Chuck Lever wrote:
> > > > On Mon, Mar 04, 2024 at 03:40:21PM +1100, NeilBrown wrote:
> > > > > move_to_close_lru() waits for sc_count to become zero while holding
> > > > > rp_mutex.  This can deadlock if another thread holds a reference and is
> > > > > waiting for rp_mutex.
> > > > > 
> > > > > By the time we get to move_to_close_lru() the openowner is unhashed and
> > > > > cannot be found any more.  So code waiting for the mutex can safely
> > > > > retry the lookup if move_to_close_lru() has started.
> > > > > 
> > > > > So change rp_mutex to an atomic_t with three states:
> > > > > 
> > > > >  RP_UNLOCK   - state is still hashed, not locked for reply
> > > > >  RP_LOCKED   - state is still hashed, is locked for reply
> > > > >  RP_UNHASHED - state is not hashed, no code can get a lock.
> > > > > 
> > > > > Use wait_var_event() to wait for either a lock, or for the owner to be
> > > > > unhashed.  In the latter case, retry the lookup.
> > > > > 
> > > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > > ---
> > > > >  fs/nfsd/nfs4state.c | 38 +++++++++++++++++++++++++++++++-------
> > > > >  fs/nfsd/state.h     |  2 +-
> > > > >  2 files changed, 32 insertions(+), 8 deletions(-)
> > > > > 
> > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > index 690d0e697320..47e879d5d68a 100644
> > > > > --- a/fs/nfsd/nfs4state.c
> > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > @@ -4430,21 +4430,32 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
> > > > >  	atomic_set(&nn->nfsd_courtesy_clients, 0);
> > > > >  }
> > > > >  
> > > > > +enum rp_lock {
> > > > > +	RP_UNLOCKED,
> > > > > +	RP_LOCKED,
> > > > > +	RP_UNHASHED,
> > > > > +};
> > > > > +
> > > > >  static void init_nfs4_replay(struct nfs4_replay *rp)
> > > > >  {
> > > > >  	rp->rp_status = nfserr_serverfault;
> > > > >  	rp->rp_buflen = 0;
> > > > >  	rp->rp_buf = rp->rp_ibuf;
> > > > > -	mutex_init(&rp->rp_mutex);
> > > > > +	atomic_set(&rp->rp_locked, RP_UNLOCKED);
> > > > >  }
> > > > >  
> > > > > -static void nfsd4_cstate_assign_replay(struct nfsd4_compound_state *cstate,
> > > > > -		struct nfs4_stateowner *so)
> > > > > +static int nfsd4_cstate_assign_replay(struct nfsd4_compound_state *cstate,
> > > > > +				      struct nfs4_stateowner *so)
> > > > >  {
> > > > >  	if (!nfsd4_has_session(cstate)) {
> > > > > -		mutex_lock(&so->so_replay.rp_mutex);
> > > > > +		wait_var_event(&so->so_replay.rp_locked,
> > > > > +			       atomic_cmpxchg(&so->so_replay.rp_locked,
> > > > > +					      RP_UNLOCKED, RP_LOCKED) != RP_LOCKED);
> > > > 
> > > > What reliably prevents this from being a "wait forever" ?
> > > 
> > > That same thing that reliably prevented the original mutex_lock from
> > > waiting forever.
> > > It waits until rp_locked is set to RP_UNLOCKED, which is precisely when
> > > we previously called mutex_unlock.  But it *also* aborts the wait if
> > > rp_locked is set to RP_UNHASHED - so it is now more reliable.
> > > 
> > > Does that answer the question?
> > 
> > Hm. I guess then we are no worse off with wait_var_event().
> > 
> > I'm not as familiar with this logic as perhaps I should be. How long
> > does it take for the wake-up to occur, typically?
> 
> wait_var_event() is paired with wake_up_var().
> The wake up happens when wake_up_var() is called, which in this code is
> always immediately after atomic_set() updates the variable.

I'm trying to ascertain the actual wall-clock time that the nfsd thread
is sleeping, at most. Is this going to be a possible DoS vector? Can
it impact the ability for the server to shut down without hanging?


-- 
Chuck Lever

