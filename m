Return-Path: <linux-nfs+bounces-7874-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1383D9C4535
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 19:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D65B1F2257D
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 18:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C34B153BEE;
	Mon, 11 Nov 2024 18:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NbERpHhN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b7/2VQx7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A512150990;
	Mon, 11 Nov 2024 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350799; cv=fail; b=Y1DkXWZuWcQ8OQTClq6gO5RKJoVOKzOgPRnMv37ubt9iGsX8MxlFvnjqTs+PunYP5OTjNvg9XWuneyDCIbze7GgWfLZkS36zGWd/pGFxCf0EM3fpN16HtkyIocNAyTGBdU4qBt6uGve+3yhMoXgEEP0XtxVPhpOAmxCWx/Lyqpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350799; c=relaxed/simple;
	bh=PSwa25LLxXLak1WakFQBw8SJ1RyJWGBGlQadrmxJmhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WHNuGIMJD6puTxC7hrA0i5bzLXR2pb9RgrW8O3iSxC+if42Ep3QXf1l/DVSR4AQSQiXlCJ0w5raPm/byV/1v2EaNEHuuW1uB0J9ZBhaa/fcxStMwgnAESkeZIrugPortAG3JPnrD8LQG9MjW2a3Qf7dguC/up5gGiXWaqf1iTHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NbERpHhN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b7/2VQx7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABGqItd027933;
	Mon, 11 Nov 2024 18:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jlmW/TF2EjI8y2CMP2pjbUXcbWjKiTyFUKGSt4Gopx0=; b=
	NbERpHhN4pEnu+544R9HRJt7AUWDQKvuKOCl8jZya3W2IBOEQmwBlpqfawRVbwrz
	PQPfse8MILjvaNr3AaohtOTQu1OasyEYc4rZtIs+6ixTm+HjqSPfxjlzoJohmAOM
	bFFN0atwOQHptVQgRIweaX5Q9jfEgD1NkWw51cb7UMVzqalFpra3kyX3dJvV6JmH
	ee5AzORTiMa7YBIaCC/PDrLiEKZvYK6BlErVngKL1l0n/ahRQCyt2Xd298ynzyz3
	ZzYNAe9ehC7MYRTNRJuv6OI21mJnxrlPOQ7OoIU21szt2njfwdbDcwTGLLXKW7dE
	cXF2JJAktvi3CByTXKY0Ug==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k232mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 18:46:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABIA4dM028251;
	Mon, 11 Nov 2024 18:46:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbp6dfyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 18:46:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjNPFmnsQcr0G1D72kE6LUsp9UfoF/OIq7MFUKppdGKmOQGeOTB9ms6SXlUJ1qYWL0mGchamu0mibk+UXZ8R4/kKZmbXDTn88HDAYvzSnzaq5Ul+JAuu6Rd9TMPSKFBax26gj5HI3BBU+OtzRQLjg6yKSxwdmE+/8miZTqeMpbvLZfmkKJwArJWVu0F9NOhkaqsriVZV90dsHuowUQfmm0KGn6UusNuWcbnUkITkMjMRJ3XLMfcQSMMWOhZkBEtP2X7cqfdMYE9MD6yXnnrcqFQB0zqsiG2JZbl5KkPYJy2gT2YnwwHR7AWj2kZnCp7HptJ06mjfOKVqOvueLsp3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlmW/TF2EjI8y2CMP2pjbUXcbWjKiTyFUKGSt4Gopx0=;
 b=ysepTtgqOrl4fBdxzQGO9WTSZeO5Lnp/yrBId7IkukYsVNXN5RuoAX5vX79IwceV03AGqoi5qlT6n3GBT4VWMCnYji5GLPvzn0bfNCgwBp+Nm9WrElmwKYOgoKWQoH7yyt3Q5P3hw+DcCSfdjRsQvy8BZRLZraL1bQpgAZamZ9eCZUzIlnujeXoICf1p7crL2iFGspSGC4bxZvNDbHid5v5LlPCA5TZEHQqRgvWE4p+TTQhHTih7BBvlPBtce5FreVV+2LJ1zmgPub8whyhXbH8SfRlnyveygBmJX+fCTYyp/O88XcspkcUnjZXpAy9I0EwvyfTvSiEzHdvsOlDMog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlmW/TF2EjI8y2CMP2pjbUXcbWjKiTyFUKGSt4Gopx0=;
 b=b7/2VQx71gsa5whh6O0DzQP7TjCBxLHqMOI7TRVvUiXdrW4bLcYY+9TAhPIzA/NL0x1jUSlIWVfR3bUIE/1U+tRqBW/kvOXfX9yhcK3lk2C6JvmlO9fvyUCXX+PrdU3irRMDU2ZadNoOZwN3z/MoMAKo2ZhHMbnmgyLZFwuUZRg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5566.namprd10.prod.outlook.com (2603:10b6:a03:3d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 18:46:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 18:46:14 +0000
Date: Mon, 11 Nov 2024 13:46:11 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <aglo@umich.edu>, Neil Brown <neilb@suse.de>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] nfsd: allow for up to 32 callback session slots
Message-ID: <ZzJQ8ywsWqlFMs5p@tissot.1015granger.net>
References: <CAN-5tyEEfJ5p=NUaj+ubzCijq+d9vxT9EBVHvwQYgF=CMtrNTw@mail.gmail.com>
 <59e803abae0b7441c1440ebd4657e573b1c02dd2.camel@kernel.org>
 <CAN-5tyH8xw6XtpnXELJfrxibN3P=xRax31pCexcuOtBMZhooxw@mail.gmail.com>
 <b7f6454176746f5e7a8d75ba41be71e46590a08c.camel@kernel.org>
 <ZzIa5q8cG5LYW5D7@tissot.1015granger.net>
 <CAN-5tyGc-jHHCQwLNAH4mFFUqZqdieygCbe+ux7rww5PC7qjMw@mail.gmail.com>
 <83b950633c5b7f6949939a4d51581196b5757c07.camel@kernel.org>
 <CAN-5tyEh6MrTBQQt99+VO4FcnX3x1DX7XOpRwmkXFryqzr95Jw@mail.gmail.com>
 <3c60acaa79ec27ed1ecb8fdc42a2cb75c75c0a25.camel@kernel.org>
 <14e6f6af974c5c17884c418560f385d051d7bdf7.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14e6f6af974c5c17884c418560f385d051d7bdf7.camel@kernel.org>
X-ClientProxiedBy: CH0P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5566:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fdbb12f-9ae7-4506-73cc-08dd02811e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WE1rcGtuajI5YlFaWXEzU3VPN2NEUnQ1b25jTW44WHlQbU5rTEZmRmNJMEY3?=
 =?utf-8?B?SkttRlh6WmZCS0hFbkxtTC9pblVFQndmMTBUdzlSS0dkb2wxSzBSWElMTFRR?=
 =?utf-8?B?R296bzZrVzNTZThGTHJIeXp6NktXTS92b3lheUpsVmNhUkFCL0lpWEhTYjRR?=
 =?utf-8?B?RU1KUTNid28wSER3Rk5ud0FlTC9CVkI5RzY0Y0Zsa2tyM2x2ODR3S1RvOExI?=
 =?utf-8?B?Mm5rd0QvbTU3SEJqRmFHdG14S1ZZTFNzanNpOVR6UVdHZlV6czB1SHFxdU9L?=
 =?utf-8?B?R21NQWczbHFHQStTblFCZlNVbTArZFNkSEs2TUFqSXdNMlZWdzUzVVBUUURU?=
 =?utf-8?B?SG95SkdMNzBWZ3QxYWFQMUVOUTBrNDRvejBmRE1IY1ovY01oU2lPM3plMStu?=
 =?utf-8?B?OGtrQk0yRitXV09LWldqMHlSa29SeVF6NXhNSVpKVHJoTmFRUVpEcFFBVENm?=
 =?utf-8?B?VVlZdXVrZGRBUVdwaS9PZjliYUtna2hnQ0RKdVlqNjZYRE1UWGVlSGw5RDJE?=
 =?utf-8?B?cDN1R3pVeldlT2NqeVlpNFZiQy9pOXZKVDhZOU5ObUdDczBSRGhodk1iU1N2?=
 =?utf-8?B?aGlPRXRua1VtWHVzeVpYSm1XZ1BBNzNhWEJoT2FuYnNIbzVlMmVCRXdxaTU2?=
 =?utf-8?B?cE1WKytZQXlSa3BOYzNCdnNRMUlqNm13OE53M2I5Ly8rczRNdDVVNElleHNN?=
 =?utf-8?B?MS9GOUVVNEZVei9PakJ6RXZ6cUYwV0xMTEh1Z2dQOUFoYW9hazBuWTkwWWRx?=
 =?utf-8?B?S28yeTdtVVZLZU43SnZENUhHR0RvR2RVTkNGUDdZVXI0bVM2SWMrOVN5OFN4?=
 =?utf-8?B?VlUvRG5wT1NHQnJSd1Q4TU9lc1lCQkMxSFdVTTZTcnpaU1dXWVJrZzRCYjZk?=
 =?utf-8?B?V3puM2g3Qmlrb01ZN0pMcHR6M2tZVkh4clFuaHZUdGVpWEVSVFFEbzZsWGJE?=
 =?utf-8?B?NC9rNFFHRld1dThHL2FHMnJ2L0tnbmZWMisxSmJmV2pCeEd2R055L1JDVys2?=
 =?utf-8?B?NVBGZklubU9JN1dNTWxUUWpMQ0N1cFhwUXAwcU1PaTJDTWlJS2VzQmFzTVBh?=
 =?utf-8?B?d3ZvUmlPaW5DTk1zZ2F0V0x5ZmZFc1g0ZXFCNUtmS1hTclRNN1F1RWJYSVht?=
 =?utf-8?B?QVNVMG9JblZERUJkLzZqZzF0c3owNElPcGlGNXZmdUU1b0xOVHhpY05JcXp1?=
 =?utf-8?B?NFZQclArcmk3dUlvcFFWdHp5RFFFbHRRSmxvcllVRFpiNzIxU214NUNiZzBD?=
 =?utf-8?B?aVV6bEZnM3BiSXpnWEg2WlRLOWhXR0RETmhheWVseTNEVC9jMjFHenFwL1My?=
 =?utf-8?B?SFZGcXlGM1Y2RTl2NnUwbGV2QTdRTnF0UGsyMU0rT2lPaG5FWCttM0VsZmdC?=
 =?utf-8?B?Z2sreklBbEdZY0l3REpJazJmck5kQWRMcENxdnpuNFYrUjY2ZEJoeGZQYUdv?=
 =?utf-8?B?WDFUQkdpMnNkOEFkMlFMUmEzaWhQTzdqMTZvYmhDRkQ0ZHB3ZEthaElCRlhz?=
 =?utf-8?B?L0tDTEZoeXRwb3VVL01kc0lTUzAxaitxdTdhYWpNOFQyUGdLTE9ydnQ0bmJz?=
 =?utf-8?B?UlhBU1lpaVA5Ykd4SFlWSXNwUXZoMUc4cVNwREdCQUFGRE1MWXo0aHp6UHlX?=
 =?utf-8?B?S1YybTVmUTgvUXBsVzRFbVN5YWRhdjd6aFdoTDJ1NWtnR1o4alpTN01YS1JH?=
 =?utf-8?B?dWFmZ0U0NGF2b3hMMGxaOXNXWGcrZkdUM1JobDNDUjhxaURDRk9LNFRMbEMy?=
 =?utf-8?Q?LpSOTw6eOnDIIWI9yuOXHTJ7jLmqtvOhLvMYmWS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czFjb0RadUJLS3k1NGxFVXpJeFR2QU82alU3L01CcVRzK1IyNklJNTNLbjVJ?=
 =?utf-8?B?Y0RNcU1MVjFtYThXdGN2N2J5QXpLTG1VRFplTlRIOG05ZUFGemdtekxHdTA5?=
 =?utf-8?B?bllseVJvQWdoUm5nYkVvNzNDcXB5cExYaUNnNDJTRTlWYitoSSthQlVuS2J3?=
 =?utf-8?B?MG5aeWdxNkNLU3kzNzJGSmh2eHVMSGxzcHAxWlduQmdkMDRzWXBGUElQVkFF?=
 =?utf-8?B?OUZ4OG00UnBsaWVqdWs1RmdyeGxMNDZkUjlyTHRJbjFYTll0bXlYM0pYdHRv?=
 =?utf-8?B?aWVzUkcwR3VydTZ0d3FoU1NWdGtVSTYzOG1MTmJnWGFlamZWZVk1L3JaVlkv?=
 =?utf-8?B?VHdFSVVoQ2pUQUpxZXNEU0Y1YlN1LzZ4enExOHhJZVp0SUdOc0NNZHMzeWxl?=
 =?utf-8?B?L2psODQzMmQ5RGI0QU1VQ3pjSlZ6YUhxSDcrV3NQRWxVRUtsRFRJTGU4RTNM?=
 =?utf-8?B?N2xHZ1d4RVJxVmtGVCt6MHdaMGdlM253aU1kemxzcnllRk4vZTVGYTRaSlpt?=
 =?utf-8?B?SHVIKzg0ck93b1IyN0hEcEZqUllaWDhwUHMyQjBJWFRNNmU0SG5raDl1YTRr?=
 =?utf-8?B?ekdVSFhrL3Nyelgyc3VHaVlydnhmeG9IcHBHSEFwUVBGQXJFVkdBSjBXWkI0?=
 =?utf-8?B?b3BORnh5YlB3YnM0R0EzY1lMUlN6eUI1ZUFSSlJKSUU2dDhlODRVdTgxaTZB?=
 =?utf-8?B?KytyWTJQNzd2M2VsQ2FVSzdqaWVMNFBWdmpNdTRPTHg5MzhOYVBSRXkrenYv?=
 =?utf-8?B?ZEJFb1hiMjVnL3lRcjJ5VEVvUXEwYUpWOXJ1SW0xWmloMHFmNzhzTWxCcFZT?=
 =?utf-8?B?aGZoT1dHL3dGVUtVUW1vQ1duc25WUGxRV0xKUFdELzdpYWVlTjJuSDlzSXpo?=
 =?utf-8?B?RmIvQkN3VWp3OXBFMzQweWFwOFBSdWRtaTRya2l3WnhOWERkVHo0dXlaMlJ1?=
 =?utf-8?B?UEM2ZDFkQ3o3dXFXaklKcFZsRTZuZW1JZ2dSekNibm1QQmRRSE11UU4rY3Bp?=
 =?utf-8?B?Q1hseG5kNXNIVUsvdnFER25XY215ZUFOUE1WR3duenN4Q0NqV1RIWFpSamZW?=
 =?utf-8?B?TVNPTGErUjQvREtyWmduSU9uemVXeFVQSlJqb0NvTk54VWcxTGQ0SXdvMHZC?=
 =?utf-8?B?d0IvUUlXZlR1NnExNnJOZFdCaFlobjA3UWFVcjNkNGJCbjA4b05lQitmb0ZF?=
 =?utf-8?B?ZnROUGxTUXBTMmVhZWMvaytSZS9DTDlOTHg1TnJOK3BXWlZFTURFOFlwbmVx?=
 =?utf-8?B?aXBIbExtNzhPdUVJdnB3aEZNWXhFZm5mejZSSitXQm9PbmFqcm5LZXdIc3Js?=
 =?utf-8?B?QXdYcTE0NjZMWkRHN2dGZUFrYW5uN082elBTVGQyZ3JmeHkxazFpV1hucE9F?=
 =?utf-8?B?RndxNGtFVHUveGIzVU5jRWVOeHF0NVZkUEFVTXJVazYySU0wUWJidHVjZTBN?=
 =?utf-8?B?dnR0SSttNUFGMXJkYVVvcTRCSyt4Z1pLZ0xqN0RDcXVhN0xLb2ZBb0ZTd2d0?=
 =?utf-8?B?ZGZpd3JOQWdCWGVqRmV2MFpmbWhmVjJ1M2h6RlBsYzVYZHhGQitsRzk4aW8x?=
 =?utf-8?B?cEFpcnR5MjU5TzFObFhnMTlIZ283S3F1RHBQS3VFaEN1OFhhZEx2MXFqOUQ1?=
 =?utf-8?B?VU5OZ3J1VzdnSDFWcFUxWmFETG4yTHlKQXF6ckc1OHREZ242Z0tGdjFrV0xE?=
 =?utf-8?B?UnpLZUhaaU5mVGs3eForekpzY2pMc1NOZkgraXQ4OEVVRG81dmFqNUJUN01p?=
 =?utf-8?B?SXYzVDQwR0ZCOHBQOExTRDlFeEtlZ2NFbEs1WTRpRGp5OThiVWRYam0yMmFS?=
 =?utf-8?B?ZHZ2NjJGS0xSTFZIUCtSQUVBeHRjTTVsbkdLNFQ0WWswQ2xxUjFJUmJwQzNS?=
 =?utf-8?B?dDRlWmU1OVhuQWdpcTBpbytTak00dmRvaE0zWlJTRDcyOWloT1M0aHVxRmdH?=
 =?utf-8?B?aTgrYXAwK1YrV2JjWFdQa3ErcjJxanZCdVlPR0RxMzVpcjBEcHpjbm16cUNh?=
 =?utf-8?B?TnA0cVpHYkhFTnEwOTZKV0cwZDV2dzZ2a2tocTVKaDJEQXlwSGhKOXhXRUVG?=
 =?utf-8?B?YjhKMFZROUdiSEVOYk1FeGVWdlQ3eTlUeS9LNEZMZWpCOGxzM3ZzV2dGOTgz?=
 =?utf-8?Q?FP3vR5+sWx0699Nq663UByrGr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RY/PtD0l1BjYq3OqDxBVuQE6GYfYFxHFyh5O5JpFQ2sOjwCLg8M6dP383FOvfvM9WrWDtzxnQ55j28BH5uw0QXGVMLkVBI2r4ClHl4P86YTYTV7hHsegdbtcrN1ZSIQs+6hrqBnscSaCfF+Iwz+BvbmZQjmj/AH3sHLzB4Ty35KjbSIZiHW9BY1q32PcnkQGII6QnygOjhbJ2q0g6Z9YRs017TT2TUIFdMNZd+JIjF4JVj0Wbe8Uj1WWOyH398SMWoxRPpK8vWqiDmvfp0ph0uXgrj3tYyIFbQEFUndxRRK9lT1UmO7vPPpDD/bmsnP2dU6hHembBauO25BR5T9Zhe+bVqu1Gy0P3xEpQwDKCmdAhAIhluSdc1A3dipOJ5UlV8WQihsUDnqNROMEv8/iytyFKmei1NFzUuEQck7MMOKlmvsidrvdPoWyBJ4BEa/5N3x58W5ViL9JNwgb2QbJTdK5rgj70Sdep8uwZ0lZGoZFx2s+MoUhgLpNxQA221jYkz/TVtZ5T7wzoTO4N6biidClMPdNHw1kft6DHeJuLRqxl3Bt3XjOWneAhJM6IaOWajfK4I2oah6ff21sWxepuYAXPbmxlgXITJOS/F9Y9NA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdbb12f-9ae7-4506-73cc-08dd02811e61
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 18:46:14.2047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASxYkOEP67JECrhyt9DLvrXz9e600U3oG99n8x5mG6X8Swb/YWCZOvuPH6v1SFcLPK+uj5/IWtWStV9EQ9BmGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5566
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411110151
X-Proofpoint-ORIG-GUID: FK-GuM-6TxmmsXEVKBaekkkuxARsYoSs
X-Proofpoint-GUID: FK-GuM-6TxmmsXEVKBaekkkuxARsYoSs

On Mon, Nov 11, 2024 at 01:27:39PM -0500, Jeff Layton wrote:
> On Mon, 2024-11-11 at 13:17 -0500, Jeff Layton wrote:
> > On Mon, 2024-11-11 at 12:56 -0500, Olga Kornievskaia wrote:
> > > On Mon, Nov 11, 2024 at 12:40 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > > 
> > > > On Mon, 2024-11-11 at 12:17 -0500, Olga Kornievskaia wrote:
> > > > > On Mon, Nov 11, 2024 at 9:56 AM Chuck Lever <chuck.lever@oracle.com> wrote:
> > > > > > 
> > > > > > On Mon, Nov 11, 2024 at 08:22:07AM -0500, Jeff Layton wrote:
> > > > > > > On Sun, 2024-11-10 at 21:19 -0500, Olga Kornievskaia wrote:
> > > > > > > > On Sat, Nov 9, 2024 at 2:26 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > > > > > > > 
> > > > > > > > > On Sat, 2024-11-09 at 13:50 -0500, Olga Kornievskaia wrote:
> > > > > > > > > > On Tue, Nov 5, 2024 at 7:31 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > > > > > > > > > 
> > > > > > > > > > > nfsd currently only uses a single slot in the callback channel, which is
> > > > > > > > > > > proving to be a bottleneck in some cases. Widen the callback channel to
> > > > > > > > > > > a max of 32 slots (subject to the client's target_maxreqs value).
> > > > > > > > > > > 
> > > > > > > > > > > Change the cb_holds_slot boolean to an integer that tracks the current
> > > > > > > > > > > slot number (with -1 meaning "unassigned").  Move the callback slot
> > > > > > > > > > > tracking info into the session. Add a new u32 that acts as a bitmap to
> > > > > > > > > > > track which slots are in use, and a u32 to track the latest callback
> > > > > > > > > > > target_slotid that the client reports. To protect the new fields, add
> > > > > > > > > > > a new per-session spinlock (the se_lock). Fix nfsd41_cb_get_slot to always
> > > > > > > > > > > search for the lowest slotid (using ffs()).
> > > > > > > > > > > 
> > > > > > > > > > > Finally, convert the session->se_cb_seq_nr field into an array of
> > > > > > > > > > > counters and add the necessary handling to ensure that the seqids get
> > > > > > > > > > > reset at the appropriate times.
> > > > > > > > > > > 
> > > > > > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > > > > > > > > ---
> > > > > > > > > > > v3 has a bug that Olga hit in testing. This version should fix the wait
> > > > > > > > > > > when the slot table is full. Olga, if you're able to test this one, it
> > > > > > > > > > > would be much appreciated.
> > > > > > > > > > > ---
> > > > > > > > > > > Changes in v4:
> > > > > > > > > > > - Fix the wait for a slot in nfsd41_cb_get_slot()
> > > > > > > > > > > - Link to v3: https://lore.kernel.org/r/20241030-bcwide-v3-0-c2df49a26c45@kernel.org
> > > > > > > > > > > 
> > > > > > > > > > > Changes in v3:
> > > > > > > > > > > - add patch to convert se_flags to single se_dead bool
> > > > > > > > > > > - fix off-by-one bug in handling of NFSD_BC_SLOT_TABLE_MAX
> > > > > > > > > > > - don't reject target highest slot value of 0
> > > > > > > > > > > - Link to v2: https://lore.kernel.org/r/20241029-bcwide-v2-1-e9010b6ef55d@kernel.org
> > > > > > > > > > > 
> > > > > > > > > > > Changes in v2:
> > > > > > > > > > > - take cl_lock when fetching fields from session to be encoded
> > > > > > > > > > > - use fls() instead of bespoke highest_unset_index()
> > > > > > > > > > > - rename variables in several functions with more descriptive names
> > > > > > > > > > > - clamp limit of for loop in update_cb_slot_table()
> > > > > > > > > > > - re-add missing rpc_wake_up_queued_task() call
> > > > > > > > > > > - fix slotid check in decode_cb_sequence4resok()
> > > > > > > > > > > - add new per-session spinlock
> > > > > > > > > > > ---
> > > > > > > > > > >  fs/nfsd/nfs4callback.c | 113 ++++++++++++++++++++++++++++++++++++-------------
> > > > > > > > > > >  fs/nfsd/nfs4state.c    |  11 +++--
> > > > > > > > > > >  fs/nfsd/state.h        |  15 ++++---
> > > > > > > > > > >  fs/nfsd/trace.h        |   2 +-
> > > > > > > > > > >  4 files changed, 101 insertions(+), 40 deletions(-)
> > > > > > > > > > > 
> > > > > > > > > > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > > > > > > > > > index e38fa834b3d91333acf1425eb14c644e5d5f2601..47a678333907eaa92db305dada503704c34c15b2 100644
> > > > > > > > > > > --- a/fs/nfsd/nfs4callback.c
> > > > > > > > > > > +++ b/fs/nfsd/nfs4callback.c
> > > > > > > > > > > @@ -406,6 +406,19 @@ encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
> > > > > > > > > > >         hdr->nops++;
> > > > > > > > > > >  }
> > > > > > > > > > > 
> > > > > > > > > > > +static u32 highest_slotid(struct nfsd4_session *ses)
> > > > > > > > > > > +{
> > > > > > > > > > > +       u32 idx;
> > > > > > > > > > > +
> > > > > > > > > > > +       spin_lock(&ses->se_lock);
> > > > > > > > > > > +       idx = fls(~ses->se_cb_slot_avail);
> > > > > > > > > > > +       if (idx > 0)
> > > > > > > > > > > +               --idx;
> > > > > > > > > > > +       idx = max(idx, ses->se_cb_highest_slot);
> > > > > > > > > > > +       spin_unlock(&ses->se_lock);
> > > > > > > > > > > +       return idx;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > >  /*
> > > > > > > > > > >   * CB_SEQUENCE4args
> > > > > > > > > > >   *
> > > > > > > > > > > @@ -432,15 +445,35 @@ static void encode_cb_sequence4args(struct xdr_stream *xdr,
> > > > > > > > > > >         encode_sessionid4(xdr, session);
> > > > > > > > > > > 
> > > > > > > > > > >         p = xdr_reserve_space(xdr, 4 + 4 + 4 + 4 + 4);
> > > > > > > > > > > -       *p++ = cpu_to_be32(session->se_cb_seq_nr);      /* csa_sequenceid */
> > > > > > > > > > > -       *p++ = xdr_zero;                        /* csa_slotid */
> > > > > > > > > > > -       *p++ = xdr_zero;                        /* csa_highest_slotid */
> > > > > > > > > > > +       *p++ = cpu_to_be32(session->se_cb_seq_nr[cb->cb_held_slot]);    /* csa_sequenceid */
> > > > > > > > > > > +       *p++ = cpu_to_be32(cb->cb_held_slot);           /* csa_slotid */
> > > > > > > > > > > +       *p++ = cpu_to_be32(highest_slotid(session)); /* csa_highest_slotid */
> > > > > > > > > > >         *p++ = xdr_zero;                        /* csa_cachethis */
> > > > > > > > > > >         xdr_encode_empty_array(p);              /* csa_referring_call_lists */
> > > > > > > > > > > 
> > > > > > > > > > >         hdr->nops++;
> > > > > > > > > > >  }
> > > > > > > > > > > 
> > > > > > > > > > > +static void update_cb_slot_table(struct nfsd4_session *ses, u32 target)
> > > > > > > > > > > +{
> > > > > > > > > > > +       /* No need to do anything if nothing changed */
> > > > > > > > > > > +       if (likely(target == READ_ONCE(ses->se_cb_highest_slot)))
> > > > > > > > > > > +               return;
> > > > > > > > > > > +
> > > > > > > > > > > +       spin_lock(&ses->se_lock);
> > > > > > > > > > > +       if (target > ses->se_cb_highest_slot) {
> > > > > > > > > > > +               int i;
> > > > > > > > > > > +
> > > > > > > > > > > +               target = min(target, NFSD_BC_SLOT_TABLE_MAX);
> > > > > > > > > > > +
> > > > > > > > > > > +               /* Growing the slot table. Reset any new sequences to 1 */
> > > > > > > > > > > +               for (i = ses->se_cb_highest_slot + 1; i <= target; ++i)
> > > > > > > > > > > +                       ses->se_cb_seq_nr[i] = 1;
> > > > > > > > > > > +       }
> > > > > > > > > > > +       ses->se_cb_highest_slot = target;
> > > > > > > > > > > +       spin_unlock(&ses->se_lock);
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > >  /*
> > > > > > > > > > >   * CB_SEQUENCE4resok
> > > > > > > > > > >   *
> > > > > > > > > > > @@ -468,7 +501,7 @@ static int decode_cb_sequence4resok(struct xdr_stream *xdr,
> > > > > > > > > > >         struct nfsd4_session *session = cb->cb_clp->cl_cb_session;
> > > > > > > > > > >         int status = -ESERVERFAULT;
> > > > > > > > > > >         __be32 *p;
> > > > > > > > > > > -       u32 dummy;
> > > > > > > > > > > +       u32 seqid, slotid, target;
> > > > > > > > > > > 
> > > > > > > > > > >         /*
> > > > > > > > > > >          * If the server returns different values for sessionID, slotID or
> > > > > > > > > > > @@ -484,21 +517,22 @@ static int decode_cb_sequence4resok(struct xdr_stream *xdr,
> > > > > > > > > > >         }
> > > > > > > > > > >         p += XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN);
> > > > > > > > > > > 
> > > > > > > > > > > -       dummy = be32_to_cpup(p++);
> > > > > > > > > > > -       if (dummy != session->se_cb_seq_nr) {
> > > > > > > > > > > +       seqid = be32_to_cpup(p++);
> > > > > > > > > > > +       if (seqid != session->se_cb_seq_nr[cb->cb_held_slot]) {
> > > > > > > > > > >                 dprintk("NFS: %s Invalid sequence number\n", __func__);
> > > > > > > > > > >                 goto out;
> > > > > > > > > > >         }
> > > > > > > > > > > 
> > > > > > > > > > > -       dummy = be32_to_cpup(p++);
> > > > > > > > > > > -       if (dummy != 0) {
> > > > > > > > > > > +       slotid = be32_to_cpup(p++);
> > > > > > > > > > > +       if (slotid != cb->cb_held_slot) {
> > > > > > > > > > >                 dprintk("NFS: %s Invalid slotid\n", __func__);
> > > > > > > > > > >                 goto out;
> > > > > > > > > > >         }
> > > > > > > > > > > 
> > > > > > > > > > > -       /*
> > > > > > > > > > > -        * FIXME: process highest slotid and target highest slotid
> > > > > > > > > > > -        */
> > > > > > > > > > > +       p++; // ignore current highest slot value
> > > > > > > > > > > +
> > > > > > > > > > > +       target = be32_to_cpup(p++);
> > > > > > > > > > > +       update_cb_slot_table(session, target);
> > > > > > > > > > >         status = 0;
> > > > > > > > > > >  out:
> > > > > > > > > > >         cb->cb_seq_status = status;
> > > > > > > > > > > @@ -1203,6 +1237,22 @@ void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
> > > > > > > > > > >         spin_unlock(&clp->cl_lock);
> > > > > > > > > > >  }
> > > > > > > > > > > 
> > > > > > > > > > > +static int grab_slot(struct nfsd4_session *ses)
> > > > > > > > > > > +{
> > > > > > > > > > > +       int idx;
> > > > > > > > > > > +
> > > > > > > > > > > +       spin_lock(&ses->se_lock);
> > > > > > > > > > > +       idx = ffs(ses->se_cb_slot_avail) - 1;
> > > > > > > > > > > +       if (idx < 0 || idx > ses->se_cb_highest_slot) {
> > > > > > > > > > > +               spin_unlock(&ses->se_lock);
> > > > > > > > > > > +               return -1;
> > > > > > > > > > > +       }
> > > > > > > > > > > +       /* clear the bit for the slot */
> > > > > > > > > > > +       ses->se_cb_slot_avail &= ~BIT(idx);
> > > > > > > > > > > +       spin_unlock(&ses->se_lock);
> > > > > > > > > > > +       return idx;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > >  /*
> > > > > > > > > > >   * There's currently a single callback channel slot.
> > > > > > > > > > >   * If the slot is available, then mark it busy.  Otherwise, set the
> > > > > > > > > > > @@ -1211,28 +1261,32 @@ void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
> > > > > > > > > > >  static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc_task *task)
> > > > > > > > > > >  {
> > > > > > > > > > >         struct nfs4_client *clp = cb->cb_clp;
> > > > > > > > > > > +       struct nfsd4_session *ses = clp->cl_cb_session;
> > > > > > > > > > > 
> > > > > > > > > > > -       if (!cb->cb_holds_slot &&
> > > > > > > > > > > -           test_and_set_bit(0, &clp->cl_cb_slot_busy) != 0) {
> > > > > > > > > > > +       if (cb->cb_held_slot >= 0)
> > > > > > > > > > > +               return true;
> > > > > > > > > > > +       cb->cb_held_slot = grab_slot(ses);
> > > > > > > > > > > +       if (cb->cb_held_slot < 0) {
> > > > > > > > > > >                 rpc_sleep_on(&clp->cl_cb_waitq, task, NULL);
> > > > > > > > > > >                 /* Race breaker */
> > > > > > > > > > > -               if (test_and_set_bit(0, &clp->cl_cb_slot_busy) != 0) {
> > > > > > > > > > > -                       dprintk("%s slot is busy\n", __func__);
> > > > > > > > > > > +               cb->cb_held_slot = grab_slot(ses);
> > > > > > > > > > > +               if (cb->cb_held_slot < 0)
> > > > > > > > > > >                         return false;
> > > > > > > > > > > -               }
> > > > > > > > > > >                 rpc_wake_up_queued_task(&clp->cl_cb_waitq, task);
> > > > > > > > > > >         }
> > > > > > > > > > > -       cb->cb_holds_slot = true;
> > > > > > > > > > >         return true;
> > > > > > > > > > >  }
> > > > > > > > > > > 
> > > > > > > > > > >  static void nfsd41_cb_release_slot(struct nfsd4_callback *cb)
> > > > > > > > > > >  {
> > > > > > > > > > >         struct nfs4_client *clp = cb->cb_clp;
> > > > > > > > > > > +       struct nfsd4_session *ses = clp->cl_cb_session;
> > > > > > > > > > > 
> > > > > > > > > > > -       if (cb->cb_holds_slot) {
> > > > > > > > > > > -               cb->cb_holds_slot = false;
> > > > > > > > > > > -               clear_bit(0, &clp->cl_cb_slot_busy);
> > > > > > > > > > > +       if (cb->cb_held_slot >= 0) {
> > > > > > > > > > > +               spin_lock(&ses->se_lock);
> > > > > > > > > > > +               ses->se_cb_slot_avail |= BIT(cb->cb_held_slot);
> > > > > > > > > > > +               spin_unlock(&ses->se_lock);
> > > > > > > > > > > +               cb->cb_held_slot = -1;
> > > > > > > > > > >                 rpc_wake_up_next(&clp->cl_cb_waitq);
> > > > > > > > > > >         }
> > > > > > > > > > >  }
> > > > > > > > > > > @@ -1249,8 +1303,8 @@ static void nfsd41_destroy_cb(struct nfsd4_callback *cb)
> > > > > > > > > > >  }
> > > > > > > > > > > 
> > > > > > > > > > >  /*
> > > > > > > > > > > - * TODO: cb_sequence should support referring call lists, cachethis, multiple
> > > > > > > > > > > - * slots, and mark callback channel down on communication errors.
> > > > > > > > > > > + * TODO: cb_sequence should support referring call lists, cachethis,
> > > > > > > > > > > + * and mark callback channel down on communication errors.
> > > > > > > > > > >   */
> > > > > > > > > > >  static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
> > > > > > > > > > >  {
> > > > > > > > > > > @@ -1292,7 +1346,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
> > > > > > > > > > >                 return true;
> > > > > > > > > > >         }
> > > > > > > > > > > 
> > > > > > > > > > > -       if (!cb->cb_holds_slot)
> > > > > > > > > > > +       if (cb->cb_held_slot < 0)
> > > > > > > > > > >                 goto need_restart;
> > > > > > > > > > > 
> > > > > > > > > > >         /* This is the operation status code for CB_SEQUENCE */
> > > > > > > > > > > @@ -1306,10 +1360,10 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
> > > > > > > > > > >                  * If CB_SEQUENCE returns an error, then the state of the slot
> > > > > > > > > > >                  * (sequence ID, cached reply) MUST NOT change.
> > > > > > > > > > >                  */
> > > > > > > > > > > -               ++session->se_cb_seq_nr;
> > > > > > > > > > > +               ++session->se_cb_seq_nr[cb->cb_held_slot];
> > > > > > > > > > >                 break;
> > > > > > > > > > >         case -ESERVERFAULT:
> > > > > > > > > > > -               ++session->se_cb_seq_nr;
> > > > > > > > > > > +               ++session->se_cb_seq_nr[cb->cb_held_slot];
> > > > > > > > > > >                 nfsd4_mark_cb_fault(cb->cb_clp);
> > > > > > > > > > >                 ret = false;
> > > > > > > > > > >                 break;
> > > > > > > > > > > @@ -1335,17 +1389,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
> > > > > > > > > > >         case -NFS4ERR_BADSLOT:
> > > > > > > > > > >                 goto retry_nowait;
> > > > > > > > > > >         case -NFS4ERR_SEQ_MISORDERED:
> > > > > > > > > > > -               if (session->se_cb_seq_nr != 1) {
> > > > > > > > > > > -                       session->se_cb_seq_nr = 1;
> > > > > > > > > > > +               if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
> > > > > > > > > > > +                       session->se_cb_seq_nr[cb->cb_held_slot] = 1;
> > > > > > > > > > >                         goto retry_nowait;
> > > > > > > > > > >                 }
> > > > > > > > > > >                 break;
> > > > > > > > > > >         default:
> > > > > > > > > > >                 nfsd4_mark_cb_fault(cb->cb_clp);
> > > > > > > > > > >         }
> > > > > > > > > > > -       nfsd41_cb_release_slot(cb);
> > > > > > > > > > > -
> > > > > > > > > > >         trace_nfsd_cb_free_slot(task, cb);
> > > > > > > > > > > +       nfsd41_cb_release_slot(cb);
> > > > > > > > > > > 
> > > > > > > > > > >         if (RPC_SIGNALLED(task))
> > > > > > > > > > >                 goto need_restart;
> > > > > > > > > > > @@ -1565,7 +1618,7 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
> > > > > > > > > > >         INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
> > > > > > > > > > >         cb->cb_status = 0;
> > > > > > > > > > >         cb->cb_need_restart = false;
> > > > > > > > > > > -       cb->cb_holds_slot = false;
> > > > > > > > > > > +       cb->cb_held_slot = -1;
> > > > > > > > > > >  }
> > > > > > > > > > > 
> > > > > > > > > > >  /**
> > > > > > > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > > > > > > index baf7994131fe1b0a4715174ba943fd2a9882aa12..75557e7cc9265517f51952563beaa4cfe8adcc3f 100644
> > > > > > > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > > > > > > @@ -2002,6 +2002,9 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
> > > > > > > > > > >         }
> > > > > > > > > > > 
> > > > > > > > > > >         memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
> > > > > > > > > > > +       new->se_cb_slot_avail = ~0U;
> > > > > > > > > > > +       new->se_cb_highest_slot = battrs->maxreqs - 1;
> > > > > > > > > > > +       spin_lock_init(&new->se_lock);
> > > > > > > > > > >         return new;
> > > > > > > > > > >  out_free:
> > > > > > > > > > >         while (i--)
> > > > > > > > > > > @@ -2132,11 +2135,14 @@ static void init_session(struct svc_rqst *rqstp, struct nfsd4_session *new, stru
> > > > > > > > > > > 
> > > > > > > > > > >         INIT_LIST_HEAD(&new->se_conns);
> > > > > > > > > > > 
> > > > > > > > > > > -       new->se_cb_seq_nr = 1;
> > > > > > > > > > > +       atomic_set(&new->se_ref, 0);
> > > > > > > > > > >         new->se_dead = false;
> > > > > > > > > > >         new->se_cb_prog = cses->callback_prog;
> > > > > > > > > > >         new->se_cb_sec = cses->cb_sec;
> > > > > > > > > > > -       atomic_set(&new->se_ref, 0);
> > > > > > > > > > > +
> > > > > > > > > > > +       for (idx = 0; idx < NFSD_BC_SLOT_TABLE_MAX; ++idx)
> > > > > > > > > > > +               new->se_cb_seq_nr[idx] = 1;
> > > > > > > > > > > +
> > > > > > > > > > >         idx = hash_sessionid(&new->se_sessionid);
> > > > > > > > > > >         list_add(&new->se_hash, &nn->sessionid_hashtbl[idx]);
> > > > > > > > > > >         spin_lock(&clp->cl_lock);
> > > > > > > > > > > @@ -3159,7 +3165,6 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
> > > > > > > > > > >         kref_init(&clp->cl_nfsdfs.cl_ref);
> > > > > > > > > > >         nfsd4_init_cb(&clp->cl_cb_null, clp, NULL, NFSPROC4_CLNT_CB_NULL);
> > > > > > > > > > >         clp->cl_time = ktime_get_boottime_seconds();
> > > > > > > > > > > -       clear_bit(0, &clp->cl_cb_slot_busy);
> > > > > > > > > > >         copy_verf(clp, verf);
> > > > > > > > > > >         memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
> > > > > > > > > > >         clp->cl_cb_session = NULL;
> > > > > > > > > > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > > > > > > > > > index d22e4f2c9039324a0953a9e15a3c255fb8ee1a44..848d023cb308f0b69916c4ee34b09075708f0de3 100644
> > > > > > > > > > > --- a/fs/nfsd/state.h
> > > > > > > > > > > +++ b/fs/nfsd/state.h
> > > > > > > > > > > @@ -71,8 +71,8 @@ struct nfsd4_callback {
> > > > > > > > > > >         struct work_struct cb_work;
> > > > > > > > > > >         int cb_seq_status;
> > > > > > > > > > >         int cb_status;
> > > > > > > > > > > +       int cb_held_slot;
> > > > > > > > > > >         bool cb_need_restart;
> > > > > > > > > > > -       bool cb_holds_slot;
> > > > > > > > > > >  };
> > > > > > > > > > > 
> > > > > > > > > > >  struct nfsd4_callback_ops {
> > > > > > > > > > > @@ -307,6 +307,9 @@ struct nfsd4_conn {
> > > > > > > > > > >         unsigned char cn_flags;
> > > > > > > > > > >  };
> > > > > > > > > > > 
> > > > > > > > > > > +/* Highest slot index that nfsd implements in NFSv4.1+ backchannel */
> > > > > > > > > > > +#define NFSD_BC_SLOT_TABLE_MAX (sizeof(u32) * 8 - 1)
> > > > > > > > > > 
> > > > > > > > > > Are there some values that are known not to work? I was experimenting
> > > > > > > > > > with values and set it to 2 and 4 and the kernel oopsed. I understand
> > > > > > > > > > it's not a configurable value but it would still be good to know the
> > > > > > > > > > expectations...
> > > > > > > > > > 
> > > > > > > > > > [  198.625021] Unable to handle kernel paging request at virtual
> > > > > > > > > > address dfff800020000000
> > > > > > > > > > [  198.625870] KASAN: probably user-memory-access in range
> > > > > > > > > > [0x0000000100000000-0x0000000100000007]
> > > > > > > > > > [  198.626444] Mem abort info:
> > > > > > > > > > [  198.626630]   ESR = 0x0000000096000005
> > > > > > > > > > [  198.626882]   EC = 0x25: DABT (current EL), IL = 32 bits
> > > > > > > > > > [  198.627234]   SET = 0, FnV = 0
> > > > > > > > > > [  198.627441]   EA = 0, S1PTW = 0
> > > > > > > > > > [  198.627627]   FSC = 0x05: level 1 translation fault
> > > > > > > > > > [  198.627859] Data abort info:
> > > > > > > > > > [  198.628000]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> > > > > > > > > > [  198.628272]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > > > > > > > > > [  198.628619]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > > > > > > > > > [  198.628967] [dfff800020000000] address between user and kernel address ranges
> > > > > > > > > > [  198.629438] Internal error: Oops: 0000000096000005 [#1] SMP
> > > > > > > > > > [  198.629806] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver
> > > > > > > > > > nfs netfs nfnetlink_queue nfnetlink_log nfnetlink bluetooth cfg80211
> > > > > > > > > > rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd
> > > > > > > > > > grace isofs uinput snd_seq_dummy snd_hrtimer vsock_loopback
> > > > > > > > > > vmw_vsock_virtio_transport_common qrtr rfkill vmw_vsock_vmci_transport
> > > > > > > > > > vsock sunrpc vfat fat snd_hda_codec_generic snd_hda_intel
> > > > > > > > > > snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep snd_seq uvcvideo
> > > > > > > > > > videobuf2_vmalloc snd_seq_device videobuf2_memops uvc videobuf2_v4l2
> > > > > > > > > > videodev snd_pcm videobuf2_common mc snd_timer snd vmw_vmci soundcore
> > > > > > > > > > xfs libcrc32c vmwgfx drm_ttm_helper ttm nvme drm_kms_helper
> > > > > > > > > > crct10dif_ce nvme_core ghash_ce sha2_ce sha256_arm64 sha1_ce drm
> > > > > > > > > > nvme_auth sr_mod cdrom e1000e sg fuse
> > > > > > > > > > [  198.633799] CPU: 5 UID: 0 PID: 6081 Comm: nfsd Kdump: loaded Not
> > > > > > > > > > tainted 6.12.0-rc6+ #47
> > > > > > > > > > [  198.634345] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS
> > > > > > > > > > VMW201.00V.21805430.BA64.2305221830 05/22/2023
> > > > > > > > > > [  198.635014] pstate: 11400005 (nzcV daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> > > > > > > > > > [  198.635492] pc : nfsd4_sequence+0x5a0/0x1f60 [nfsd]
> > > > > > > > > > [  198.635798] lr : nfsd4_sequence+0x340/0x1f60 [nfsd]
> > > > > > > > > > [  198.636065] sp : ffff8000884977e0
> > > > > > > > > > [  198.636234] x29: ffff800088497910 x28: ffff0000b1b39280 x27: ffff0000ab508128
> > > > > > > > > > [  198.636624] x26: ffff0000b1b39298 x25: ffff0000b1b39290 x24: ffff0000a65e1c64
> > > > > > > > > > [  198.637049] x23: 1fffe000212e6804 x22: ffff000109734024 x21: 1ffff00011092f16
> > > > > > > > > > [  198.637472] x20: ffff00010aed8000 x19: ffff000109734000 x18: 1fffe0002de20c8b
> > > > > > > > > > [  198.637883] x17: 0100000000000000 x16: 1ffff0000fcef234 x15: 1fffe000212e600f
> > > > > > > > > > [  198.638286] x14: ffff80007e779000 x13: ffff80007e7791a0 x12: 0000000000000000
> > > > > > > > > > [  198.638697] x11: ffff0000a65e1c38 x10: ffff00010aedaca0 x9 : 1fffe000215db594
> > > > > > > > > > [  198.639110] x8 : 1fffe00014cbc387 x7 : ffff0000a65e1c03 x6 : ffff0000a65e1c00
> > > > > > > > > > [  198.639541] x5 : ffff0000a65e1c00 x4 : 0000000020000000 x3 : 0000000100000001
> > > > > > > > > > [  198.639962] x2 : ffff000109730060 x1 : 0000000000000003 x0 : dfff800000000000
> > > > > > > > > > [  198.640332] Call trace:
> > > > > > > > > > [  198.640460]  nfsd4_sequence+0x5a0/0x1f60 [nfsd]
> > > > > > > > > > [  198.640715]  nfsd4_proc_compound+0xb94/0x23b0 [nfsd]
> > > > > > > > > > [  198.640997]  nfsd_dispatch+0x22c/0x718 [nfsd]
> > > > > > > > > > [  198.641260]  svc_process_common+0x8e8/0x1968 [sunrpc]
> > > > > > > > > > [  198.641566]  svc_process+0x3d4/0x7e0 [sunrpc]
> > > > > > > > > > [  198.641827]  svc_handle_xprt+0x828/0xe10 [sunrpc]
> > > > > > > > > > [  198.642108]  svc_recv+0x2cc/0x6a8 [sunrpc]
> > > > > > > > > > [  198.642346]  nfsd+0x270/0x400 [nfsd]
> > > > > > > > > > [  198.642562]  kthread+0x288/0x310
> > > > > > > > > > [  198.642745]  ret_from_fork+0x10/0x20
> > > > > > > > > > [  198.642937] Code: f2fbffe0 f9003be4 f94007e2 52800061 (38e06880)
> > > > > > > > > > [  198.643267] SMP: stopping secondary CPUs
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Good catch. I think the problem here is that we don't currently cap the
> > > > > > > > > initial value of se_cb_highest_slot at NFSD_BC_SLOT_TABLE_MAX. Does
> > > > > > > > > this patch prevent the panic?
> > > > > > > > > 
> > > > > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > > > > index 3afe56ab9e0a..839be4ba765a 100644
> > > > > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > > > > @@ -2011,7 +2011,7 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
> > > > > > > > > 
> > > > > > > > >         memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
> > > > > > > > >         new->se_cb_slot_avail = ~0U;
> > > > > > > > > -       new->se_cb_highest_slot = battrs->maxreqs - 1;
> > > > > > > > > +       new->se_cb_highest_slot = min(battrs->maxreqs - 1, NFSD_BC_SLOT_TABLE_MAX);
> > > > > > > > >         spin_lock_init(&new->se_lock);
> > > > > > > > >         return new;
> > > > > > > > >  out_free:
> > > > > > > > 
> > > > > > > > It does help. I thought that the CREATE_SESSION reply for the
> > > > > > > > backchannel would be guided by the NFSD_BC_SLOT_TABLE_MAX value but
> > > > > > > > instead it seems like it's not. But yes I can see that the highest
> > > > > > > > slot used by the server is capped by the NFSD_BC_SLOT_TABLE_MAX value.
> > > > > > > 
> > > > > > > Thanks for testing it, Olga.
> > > > > > > 
> > > > > > > Chuck, would you be OK with folding the above delta into 9ab4c4077de9,
> > > > > > > or would you rather I resend the patch?
> > > > > > 
> > > > > > I've folded the above one-liner into the applied patch.
> > > > > > 
> > > > > > I agree with Tom, I think there's probably a (surprising)
> > > > > > explanation lurking for not seeing the expected performance
> > > > > > improvement. I can delay sending the NFSD v6.13 merge window pull
> > > > > > request for a bit to see if you can get it teased out.
> > > > > 
> > > > > I would like to raise a couple of issues:
> > > > > (1) I believe the server should be reporting back an accurate value
> > > > > for the backchannel session table size. I think if the
> > > > > NFSD_BC_SLOT_TABLE_MAX was way lower than the client's value then the
> > > > > client would be wasting resources for its bc session table?
> > > > 
> > > > Yes, but those resources are 32-bit integer per wasted slot. The Linux
> > > > client allows for up to 16 slots, so we're wasting 64 bytes per session
> > > > with this scheme with the Linux client. I didn't think it was worth
> > > > doing a separate allocation for that.
> > > > 
> > > > We could make NFSD_BC_SLOT_TABLE_MAX smaller though. Maybe we should
> > > > match the client's size and make it 15?
> > > > 
> > > > > ->back_channel->maxreqs gets decoded in nfsd4_decode_create_session()
> > > > > and is never adjusted for the reply to be based on the
> > > > > NFSD_BC_SLOT_TABLE_MAX. The problem is currently invisible because
> > > > > linux client's bc slot table size is 16 and nfsd's is higher.
> > > > > 
> > > > 
> > > > I'm not sure I understand the problem here. We don't care about most of
> > > > the backchannel attributes. maxreqs is the only one that matters, and
> > > > track that in se_cb_highest_slot.
> > > 
> > > Client sends a create_session with cba_back_chan_attrs with max_reqs
> > > of 16 -- stating that the client can handle 16 slots in it's slot
> > > table. Server currently doesn't do anything about reflecting back to
> > > the client its session slot table. It blindly returns what the client
> > > sent. Say NFSD_BC_SLOT_TABLE_MAX was 4. Server would never use more
> > > than 4 slots and yet the client would have to create a reply cache
> > > table for 16 slots. Isn't that poor sportsmanship on behalf of the
> > > linux server?
> > > 
> > > 
> > 
> > Thanks, that does sound like a bug. I think we can fix that with
> > another one-liner.  When we allocate the new session, update the
> > back_channel attrs in the request with the correct maxreqs. Thoughts?
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 15438826ed5b..c35d8fc2f693 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -3885,6 +3885,7 @@ nfsd4_create_session(struct svc_rqst *rqstp,
> >  	new = alloc_session(&cr_ses->fore_channel, &cr_ses->back_channel);
> >  	if (!new)
> >  		goto out_release_drc_mem;
> > +	cr_ses->back_channel.maxreqs = new->se_cb_highest_slot;
> >  	conn = alloc_conn_from_crses(rqstp, cr_ses);
> >  	if (!conn)
> >  		goto out_free_session;
> 
> 
> Actually, I think this is better, since we're already modifying things
> in this section of the code. Also the earlier patch was off-by-one:
> 
> ------------------------8<----------------------
> 
> [PATCH] SQUASH: report the correct number of backchannel slots to client
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4state.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 15438826ed5b..cfc2190ffce5 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3955,6 +3955,8 @@ nfsd4_create_session(struct svc_rqst *rqstp,
>  	cr_ses->flags &= ~SESSION4_PERSIST;
>  	/* Upshifting from TCP to RDMA is not supported */
>  	cr_ses->flags &= ~SESSION4_RDMA;
> +	/* Report the correct number of backchannel slots */
> +	cr_ses->back_channel.maxreqs = new->se_cb_highest_slot + 1;
>  
>  	init_session(rqstp, new, conf, cr_ses);
>  	nfsd4_get_session_locked(new);
> -- 
> 2.47.0

Applied to nfsd-next, squashed, and pushed.

I've moved "nfsd: allow for up to 32 callback session slots" to the
end of the series to make it easier to update.


-- 
Chuck Lever

