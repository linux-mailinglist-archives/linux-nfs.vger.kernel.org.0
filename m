Return-Path: <linux-nfs+bounces-10436-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8921A4CD68
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 22:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95642168219
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 21:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4BF1EE7B1;
	Mon,  3 Mar 2025 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J9KoFu1a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WCOumXlk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9B21E5B6C;
	Mon,  3 Mar 2025 21:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741036888; cv=fail; b=thCVRTTxM7ScBpNVfbLL8V+tGduMpE/G9yZyWsloh9BYo+fG3zDb6pWAVwB4Sb85qLP/f4ziGHTWGtnpAbATXwHEBiYUJ8atS8m6w/OJwV01jNjxIbPdaCGkOmFIsTQjSGelQsDVgWfJhodRIaBizXLKYtlSVyKkaCxMtkfm5vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741036888; c=relaxed/simple;
	bh=dDxnZWQJxYNeJNFVWN/nRBH/pPhvRN41mnT+UQW9wLA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I5mXpvuDKSO5HQ7H8YfcftvcnaEZ0JM0O+srCfAWbjqrSwpr5PX81bLaineMRHW7qntGrVzR+ElKnWiStTXxVz5iOspqLmy/h2ife6Ga2CYl+5B6tyAlpmmSX1zS1Hhvr8xwoxYJCA3SZY0s0sWvgSOmJ+3url6lQFPie6QERd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J9KoFu1a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WCOumXlk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523Jfi2p021363;
	Mon, 3 Mar 2025 21:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=X3kJnUTH1GIyApmacvTjW6w81fGTuLXk7uQaxlZEN3I=; b=
	J9KoFu1aeKeV+yLrO1j9G/STnFphasplaMterxJEUcGGW4+bhGNjuCIJJFTdWFjk
	apFhrj1k0ylAMKzi8Uj/SIuIIC8xrGORLr68LgUAGn718vVxgDuw3kjqpDuGzJKN
	3nhmP7xFDhCmZ46EQ7nEH2PjXvqBONlWXylRZd6H2N8vi1yGF0iZBskKeju0vzAE
	/VunF7vSLXUQL6pBtwqlI2DXFodxNrezPCumDADpaJk5LieH4WBbeJWJ+9AQJ7gB
	N5sKrKD4OiR4aZgQXXokEFkZcYbXJppiHc0XPWwq34fCtV/LmMp/uucfguozhMvy
	/RyC/wz07C5Mv0ARQCCF+Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8wkm5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 21:20:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523JYMLm019954;
	Mon, 3 Mar 2025 21:20:34 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp9a4gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 21:20:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLMrC1KnRdN3xA3qbIrWhdGPJhTC9GqRnlOlrMTyEYieX7eco8KJKtYMn4v2OXNW1XrRKGKHZQGOnoh75LcC2kyV3XRi/0ZtIJxtBZVbcsSfbDiTN5r0eQE3OugdTmOi8TeN/NG9MiIa0F6oE93gPv1Q/y2RO2laGyHAI6AqBe65k8LrveC1KAFn4cTAoAe+VNqCvSx0MVzLrRU2CzhFlrT92RDrlnmzcMahKqt3JcSUiXunZIWiBoqUzQgJtwZR4B7O6nkbSMfbaplhwYvBLaGApFkdagEvtvZjIClKHzwI8shnIeJ+eh8+NXFrQSUVE/6thBoqqSkZsT26NrFolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3kJnUTH1GIyApmacvTjW6w81fGTuLXk7uQaxlZEN3I=;
 b=vebxNLQG+eoz6CluIgvUCXSabEAIqnLpdwowEKAYsBvXUUnx5Lg6COrzknxBjcGWZ24D+fo4fKnyD0TD+g1p4XedAeqAxbpkafgHQAFtkER+mVQXHH4E6MR9lDjDJ6OX5cCUEAcnkNKAWMRzVdCZFICqH08Ud8783o4eFNiMOlft5enrLhNet3dSj2IMh5w03C4en8AqshOdIHKlZilO38+V4vHDkPmqrtDukiEbDQK2rlGWkcasysXhSSRFlaYJnIWFHVfHNijA0DNEtL6sR/hCjDpyewpub3x9BjwICczg2XB/APnCZejOmgJ8wucP/Gr/tU630xD+LOrjQo++9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3kJnUTH1GIyApmacvTjW6w81fGTuLXk7uQaxlZEN3I=;
 b=WCOumXlkMQR2ElfDU/BXkTZpYgr8fn8gmi0RsotoiM1hUSp/LTkhzymerU8KBzzV2SoBM9lIQshqJDppV67ND54mrVocNxYk5HJ/a9reToKlf5m0Jzzk7g+eF2BZtehiA1L9AWymIvX0whtBveelJI+bU38q+ibV3Jye7bMiDUU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4450.namprd10.prod.outlook.com (2603:10b6:303:93::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Mon, 3 Mar
 2025 21:20:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 21:20:31 +0000
Message-ID: <515031cd-2e25-4ae7-b0b3-5ddfda4e7bb3@oracle.com>
Date: Mon, 3 Mar 2025 16:20:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] sysctl: Fixes nsm_local_state bounds
To: Joel Granados <joel.granados@kernel.org>
Cc: nicolas.bouchinet@clip-os.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        codalist@coda.cs.cmu.edu, linux-nfs@vger.kernel.org,
        Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
        Joel Granados <j.granados@samsung.com>,
        Clemens Ladisch
 <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, Jeff Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
 <20250224095826.16458-3-nicolas.bouchinet@clip-os.org>
 <da418443-a98b-4b08-ad44-7d45d89b4173@oracle.com>
 <42t2lpwwwihg4heu4ogudt4fe5uz7trg3y2lsoqvmjnzmhnjmy@pebnborzqodv>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <42t2lpwwwihg4heu4ogudt4fe5uz7trg3y2lsoqvmjnzmhnjmy@pebnborzqodv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:610:e5::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: aaece85a-3c53-4d64-49fb-08dd5a993a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFZpVWlBaVlmeEJXQ2RYNWVaaFk5NitFUVJBTVdodVJpNnY4SmtPN2tXZE9S?=
 =?utf-8?B?QmtMVkdlUk1nY1ZGTU1ycGhaNHNsYnVaY0dVcGpvUkZIRXVFbEJNQThlWTdU?=
 =?utf-8?B?amtPb3lCcVA5aWpqemdYSUJ4VWtIaE1iQzJIMXhFNkZNamVRbWRIVkQxbFdX?=
 =?utf-8?B?eWlCbFpVMitKNGtEb25qdkJ3ekVpSkhJWnMzSEVqQ21VdTJSQUs5a3BZalNq?=
 =?utf-8?B?T2drcE9HMjFUZEVIYkpoWEJDME1YSDdlK3B0ZDlKRWlSUUJnNXV3VHN1K1N3?=
 =?utf-8?B?b0tnbmNtTnVlUlhDeHpEOU1OeDlKOVNCazFORVpIdnN0WTJUZTZuN1YrNTdo?=
 =?utf-8?B?dnRjSi9yeldmekNtblZPRExXWkNyKzJtOWRjOGRwZHE3N2FZWTIwSUdtUDVy?=
 =?utf-8?B?ZVdCb3lHT0ltM2MwNzFsU0pvL0pkVml1ZkZDRFRJbXpQU2RCNzJraWh0TVhK?=
 =?utf-8?B?MS9qQU40TS9ndnJQdTVVNktILzh5NmFEVnh3YlVtb3pmbkxsM1VMWXJmL3Va?=
 =?utf-8?B?bzdqT0hodEx5NkJaa25ZQUExVTc1T1MwVVVVVlY0ZUtRUDRtVjR2ZFpQeUF6?=
 =?utf-8?B?K0F5cThhcTdhSllGN3h0dWo5QXNZZmhzRkFzclNLSnRVWFlrTDVFaEx4S2JL?=
 =?utf-8?B?ekhjVW8ycUJ4SWlGeEZRd1pSV1o0eVVaMmNoQlFZR2dkbEh5KzA1eHFOMThB?=
 =?utf-8?B?T0N1T04rbU5ZeFdtYzQzY3lBeEoxNVpkaE5PREN3TDFCeVBpMiswWkxldHJz?=
 =?utf-8?B?VVQyTkp6cVcybE1oYXJibUxFYi9hWlJYeGI3bGJNcitIUGlSYnJ4dmhIczY2?=
 =?utf-8?B?dkx0YitjaEx1d1h5MzNPZzVQWHRvZEhwMFJxbUcxRHZCcGF6VE9EWHVFd3F5?=
 =?utf-8?B?eHpTRkhMdG5hbERDZGtsNzVBM25LSWMvNHlZV3hNblN4Ny9FVWc4UTVKTWRP?=
 =?utf-8?B?Q3hxckJwWEIyU2toQ1RlbVh5WklucGlmajdabWU0Mm55YWY4UlpnQzVrYkFH?=
 =?utf-8?B?QVFRaS91SlNySVYrVFVJcm9ORTZoRXpKUld1WFJsR21mK3VDbllVNm5YZHBV?=
 =?utf-8?B?Qjl5Z2Y4QWdrR0xOR0FPcDQ1NVZVdjFZZlFTNTcwUjNvQkdjZkFQYllWSG8v?=
 =?utf-8?B?QVIwb1JVNjVUOTFPYStERTlVaUdoMFMzZXA3elIrYjVuKy9nWUtFYUpRQW5p?=
 =?utf-8?B?blFBSzZFdmpGcWlUL0lIVmRQVEdHcDdpT1loeE1mQWpLQTFaNjRqYk5zZ2wx?=
 =?utf-8?B?TUx5TnB4S1h5amFRemQ5eVY3WjNuWUJWQnpCK0xxQ0ZuRis5emtkY0c2eW9J?=
 =?utf-8?B?TEFscnhpaFdYNmE1TzFTL2hVanZGTGVJTy80WVRnZlYxY2ZDQnZPZFd4NFJ2?=
 =?utf-8?B?Mys3UUx2cTEzT2pLaVBqTHo1MU9JR25rellOdzR6RkUrUXFBb1gzekdzdit4?=
 =?utf-8?B?QUtnL2M0MmptSDJUQUdnMklHS1JkWTMxYTVyNVU0WlVOQ3FBSDF5T084TGJU?=
 =?utf-8?B?WkYxc2JsaENZKy81a0xBbnZjMlNyMmlIVDUxOTdXWitCQWdDcXNXWFpZUXdw?=
 =?utf-8?B?QTZDZHIrTEM2OFBWbzJsUHRWTjRROEZlVEl3bU9CbGJCK0djMEtWMGxoRkFQ?=
 =?utf-8?B?K1B0WWk0YkNhdENVb3hyaDlFOFJHaVl0Y0cvYTVwQ2ZOYUI5VVRRbWQwc0xH?=
 =?utf-8?B?bnV3THhCVk9nQ2RUaVBhelNuK2daelJYUnY4T2kxWGtKVVZ2WUZJQ3pINDB5?=
 =?utf-8?B?a3M1c2RGRmRMR2RCNjdFTzhCTzBaYzVoMTMyTmx0alZQazU2UHd4N2xydUZn?=
 =?utf-8?B?RFd0T2JQR3kxZVFYdjVzajR5TGxuMGh1LytpY014eXdCUFoyNmg1ZXJMYUY5?=
 =?utf-8?Q?l6mdjhbvlwXeQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEUxTktNTFJ4YVFCd2JpVUxCK3I2VWRBa2dCL0dsMXZHamhIVU0wcFZXdFg0?=
 =?utf-8?B?dGFvb1hGOHNBSERxeS9vNlFMZHFIS3gwTGdhdWhtYXdsNWt2OGkzS1lKY2o4?=
 =?utf-8?B?alI1SU96QWRkbDB0NXF2UmJGdmhFQ3hLcFJ1S21WYW4zRm9ES2xiK09VOUNi?=
 =?utf-8?B?U2s4dDBqQUxpYmtCdUFOMk9MTlBERk8yRkNOTnFnZHZNajR5V3lhNTJsZEQ3?=
 =?utf-8?B?VkMzUktGWTUvVkZuUGFka3pyZmlmbnJYc3RZOHkxbHgzTVl4aUpYYXd4UUtM?=
 =?utf-8?B?ZE10NVd6Uk9BUkZSSXg2NmJaRlpMWE42amoyWjhZWXhnVUF5TzlqOUFzeXpv?=
 =?utf-8?B?T0ZrT0thbTBJdzBtbW9mN3JPQTNwbGM3NVpDVDBKRTd4SHpPL2l5OTdPQlh6?=
 =?utf-8?B?L3dzaWJvL3lOVWxxQmlYSzVadTNRTHk1SHgwdXZsTDRvZEhZVzZTaDNKWDRL?=
 =?utf-8?B?YVpndG1FODI4U1lNS1ZlMXVJcFBUUTdQRHlPcFcvVE9PejI1MWZOVklZNzRE?=
 =?utf-8?B?S2pOWDdiZVZiZGpGNzFpTWZTNllCTW9hb1hYenNVU0pTR2FwV2c5UUM3TTVm?=
 =?utf-8?B?VHIzdU1GbThKQmdmYzkrbzBOdFk4SzFKTFhSQnQvSEFmbDIrOTI0MjRmeW9y?=
 =?utf-8?B?VzRYUG85d1dyTmp4VXpJNDFaQ1U0UUtWZHdyR3lPQmdHbmludWQ0NzBJMFhx?=
 =?utf-8?B?WkxSWU92aVd3ektxMmtWSGp4MWdBREx6OWVXVWdkclJMQ2ZLTUk2SXkrckNT?=
 =?utf-8?B?d3hyV09EQTgydUZoMTBvall2d25EcXRyU1FvZTVLWEw2TmtyY05aSzNNQ1JS?=
 =?utf-8?B?WVhWVkdjdS9CNXZ6ajF5M2s4ckxpUkhveWQ0Z1RIN2orZUlMb1d0emxiV1V6?=
 =?utf-8?B?cDZSeCt5eHZMU1haakNQLzluTWVieXhGUEhlYmduYk00K2JEQmtya3NzdFNj?=
 =?utf-8?B?bDNjZ3J1NkJOdTZFUlRxNHVyc1hsVlpQTFF1NW1BOXZGUm5Pbm5EZlUzTWtQ?=
 =?utf-8?B?ay85SHphRURxM2RCQk5oT0dGWkdKeFNFaW9HQVVBNi9nQkxZUUNJc1l6bksz?=
 =?utf-8?B?RFdoaURMQ3dUSEpVNEhubjJyOWhUbzdBUWJ5UTRJQTMzbVBMYkJ4RGlvL3VP?=
 =?utf-8?B?dWkwaVVIV2VleEcvcUsrVEx4VnkxQVlIN29uNUYydStxYjdKMHdCZFNveVdP?=
 =?utf-8?B?U3JmRStzNmxuOU5zSnFlMnViWTJ5cFAvTXMvTU11ZEwzYi9kRFd5RTIzWTYw?=
 =?utf-8?B?a2taRDlKRngvVndjYkFMYTMwUFdGYkRWblRxZGZKTXoxVGpVdm5zaGlpVGI3?=
 =?utf-8?B?d3pJR2lxNDNCK0Nqd3JHTzU1bjZnSTBVSEhFTlBHTkxaaFVHMkhyWEIwZHYr?=
 =?utf-8?B?Z1R1clVqSFdDa1dacGZiSXRTZzY2eFNuNzVqRWI1dG1HUy9IcEFJR2lUanJw?=
 =?utf-8?B?NjhjVGNGMEtHWFFoWjhSUUx6WTl3b0VYUmpjYUU1ZW94YXRDN2tNSm5maGNX?=
 =?utf-8?B?c2Y0S2c4OUFSTVd3aWMwWmMrRWVVallYWHFvZTZWM0NRUVlUT3o2VGxHL0lP?=
 =?utf-8?B?VUMrcVpUaXNsbEY5Q1Y1d3dUYlFpSnBpZkMxSXlUWndJcjhIZDBxeDR2ZC9j?=
 =?utf-8?B?R1hySnVpRkp6N3Nqb1ZtY3dHTGFwTUYvSzEzbnEwYks3dW1qVDRocUVERnF5?=
 =?utf-8?B?bTlZb3lQTzhZQ25XRDdabGdWN3UxOU91ZWlQOSt0NEJ6aTI5RlhaRko5ZTBF?=
 =?utf-8?B?Vy9wZmEwTDViazlvZ3FYQndwODlsdk9oaUtoUFhCS3NtRXhiN01hUVh5ai82?=
 =?utf-8?B?WjBFZkRtMFhVeWhvUUJ5cks1UzVud0MvRWhCWGMzVXJ2UElOK0NCOUVmQ1Na?=
 =?utf-8?B?Nkx4NkdmdXAyOHVlVHRTckRCS1h0bFBXWld4Zk1hWFpaNFRZblNFVUQ5S2U4?=
 =?utf-8?B?cjRmUVFRWGNzcDBNRHRKWVpKK2NxWlBlZjF3Tk9QVzk1S2RuSlNOcU5rWklO?=
 =?utf-8?B?dVgvQjY2MWNHZm9VQUNhSjVaeDNoaHlVUU5SM2sxZUR1N2NnNStHa0pkaGZI?=
 =?utf-8?B?WkswWnFZeFhwcjNTTEZUWGRYTGVkbEloVVo4ZUV0R3lad0JXaUczdEhmR3Nq?=
 =?utf-8?Q?xTzjvTzBi0+oF6bVRhSiHLEsx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	InbbZiXVbwuHdyCDR8d80dsAnS1oJUxyWDShG70RlwgSdd/+ymyXht48xQLJPIefNyuQB2ujTBg2PQb1u0rlj/FktN6cFdXdwgE8mfb0qDZfDen5slniq1uIe8T4j2qOxPnOIGJDD6+bSCMXPmNzJENDqyUCtOGTEJOhNcNzvDE1CfFLG2ar7O/QBO3ZiYNBX6AlLFTpCS6N8YBM5t3dNrJ9oRfO1GlQFeaAtuRSMKI7qwR4xOnKfGvuOwJJTl+PCegbMaMtFlj1u4Yv24OgE3reUXCb9ZCtSo32ZsU8/wcUVZ7XRvDG1nQ3nSBzdiMd6f51GDbxee+DakEi+dnX9CSb/NT4ZryFtGe12PKvQUYQU9lGq2wnpc9Xpx3Dr43IT3VLsFCbHdM4rmYfjl3S5yEPJa0D8Dxji28wwnGys4GQ3aQ39TlvtkFfLryaR+BiKff2hi4acBD9FqQRnxCM0VaN7+RTYIsg4EHfNR6aIRf6htKwZeCiOXQnkfjkJeWGvKsuoEN8tKhWNPKg0VD6yvfqWBRBW05FAF4xpzzQFqV4HanRX/44073xWxrz56xO9oGE+YuNBrtNCoe3awhg0F83gW7Ea8zWzKgmthlXk0M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaece85a-3c53-4d64-49fb-08dd5a993a54
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 21:20:31.3688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drLrdxMEJ5+6abFQX2aTRewoMEb2RWAoZofqKA67gMZ+m5zWtTDp38wW/xnxzqlXOuDnrNVzEAC9/9mLqMe95g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_10,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030165
X-Proofpoint-ORIG-GUID: T1HnIt0a920f4L4UWfXeki7KU2SZV8VL
X-Proofpoint-GUID: T1HnIt0a920f4L4UWfXeki7KU2SZV8VL

On 3/3/25 9:12 AM, Joel Granados wrote:
> On Mon, Feb 24, 2025 at 09:38:17AM -0500, Chuck Lever wrote:
>> On 2/24/25 4:58 AM, nicolas.bouchinet@clip-os.org wrote:
>>> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>>>
>>> Bound nsm_local_state sysctl writings between SYSCTL_ZERO
>>> and SYSCTL_INT_MAX.
>>>
>>> The proc_handler has thus been updated to proc_dointvec_minmax.
>>>
>>> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>>> ---
>>>  fs/lockd/svc.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
>>> index 2c8eedc6c2cc9..984ab233af8b6 100644
>>> --- a/fs/lockd/svc.c
>>> +++ b/fs/lockd/svc.c
>>> @@ -461,7 +461,9 @@ static const struct ctl_table nlm_sysctls[] = {
>>>  		.data		= &nsm_local_state,
>>>  		.maxlen		= sizeof(int),
>>>  		.mode		= 0644,
>>> -		.proc_handler	= proc_dointvec,
>>> +		.proc_handler	= proc_dointvec_minmax,
>>> +		.extra1		= SYSCTL_ZERO,
>>> +		.extra2		= SYSCTL_INT_MAX,
>>>  	},
>>>  };
>>>  
>>
>> Hi Nicolas -
>>
>> nsm_local_state is an unsigned 32-bit integer. The type of that value is
>> defined by spec, because this value is exchanged between peers on the
>> network.
>>
>> Perhaps this patch should replace proc_dointvec with proc_douintvec
>> instead.
> As Nicolas stated, that is completely up to how you used the variable.
> 
> Things to notice:
> 1. If you want the full range of a unsigned long, then you should stop
>    using proc_dointvec as it will upper limit the value to INT_MAX.
> 2. If you want to keep using nsm_local_state as unsigned int, then
>    please add SYSCTL_ZERO as a lower bound to avoid assigning negative
>    values
> 3. Having SYSCTL_INT_MAX is not necessary as it is already capped by
>    proc_dointvec{_minmax,}, but it is nice to have as it makes explicit
>    what is happening.
> 
> Let me know if you take this through your trees so I can remove it from
> sysctl.
> 
> Reviewed-by: Joel Granados <joel.granados@kernel.org>

The variable "nsm_local_state" is declared as "u32".

The range of the value of nsm_local_state is supposed to be 0 -
UINT_MAX (ie, an unsigned 32-bit integer), so I'm proposing:

 		.data		= &nsm_local_state,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_douintvec,
 	},
 };

But I suspect that the "maxlen" field should be changed to something
like "sizeof(nsm_local_state)".

Does that seem correct to you?

I can take this patch through the NFSD tree so it can get some NFS-
specific testing.

-- 
Chuck Lever

