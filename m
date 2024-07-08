Return-Path: <linux-nfs+bounces-4733-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0838592A86B
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 19:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C50B1C20D92
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 17:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AC8149C57;
	Mon,  8 Jul 2024 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PzMN2KKS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nnP1MXWn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A82146A85;
	Mon,  8 Jul 2024 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461015; cv=fail; b=FiRuCOkvkop69KLRusSwK3jrNVZUWvNlW3uGCiSOPzu+ctSfqiUrqnxWYAdd2gI+RO44csLWxRVkRi/lLSQr9n/ucBxst6uNuKaaNOUdUKrKnyoNLrpRRgH16qEXhLpFwK2nT06Ycgl8PV5CxFPMN+zA8+tkICiellv2GzKlNyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461015; c=relaxed/simple;
	bh=0irKKwg2M+qc8ONuXRwoBks2LE17RXCsR5tIYC4KqaM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ItGqdjBZQr30Ym0ay9kbcudzZBoEIiI5EUKuVyN57qw0nZsTauxDZy8WiWouR0F3FWIul+YiwLMHfLgXZyu+l4f2UQSGceuU7AhyTGYSypm61nDsH7oBck+rPwQaYhtqS95Pq7810txtlZ38XAF2gBQTiiO+CkoS7vtMLKcbRpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PzMN2KKS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nnP1MXWn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468HXTGk024001;
	Mon, 8 Jul 2024 17:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=0irKKwg2M+qc8ONuXRwoBks2LE17RXCsR5tIYC4Kq
	aM=; b=PzMN2KKSzV/tiPSecbK6F4hmeNR2gsHir285UAJ/a98iSUSD7tlL8imBF
	gqhPiKnoRh1nZjdKhXb7U4KqSG4SRcXDaNOZl6x/qe8Z3dcXN/shEqvSgQ4St97V
	qpQ1JFjD7+FOXdMiFy088HfNhPBiWI7mgjuQ0AT9SV62zCXG8hDSt4g4g9zfd408
	sroMw4ZVf59CNnsVC45v1nXv+ZDAeFpm8x+4DzIidYscI7aL1Vb/SQ352PngUuV0
	XBCUjeeSXB8ml2MeiaqVzencbntV6YuccJKx21euy2gQyUk1MpMFRHZvaxwujlZI
	J3yzUIbmY3AfIhnyL68E5W00A26Iw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcb7fm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 17:49:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468Hmsog005036;
	Mon, 8 Jul 2024 17:49:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tvcfugp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 17:49:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lt13RtvyFSqFXxoXeY5WXwWDhKGPdHxcvTTXDMn2HzKtIPP5+l0TINijWoxX5/dE5n43tmI8UYNUCWzIQT+Zac4G6BlxzrRp2BFOmH31N6qYpl4bZRA6HRnzEgraz9Kyaxm8jG10sU+XQe7BIKRVThp+n/gtAnznwIlbn26Jk6XuCE9RIO99d+FpWty/woQ3wCOyhBl5mpvWevIiCJ4vUZv44SAwSCiD7z0Ivt5mllDhUYT6w8Zxp4DOGyO5zDYHmIyGoPdymuf13L+Y6nbzeqIAsX+2fySLqDB23QpcBfA++keEFdVvmjbrrAELI6BDczolBhTpCwdl97e54RfF/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0irKKwg2M+qc8ONuXRwoBks2LE17RXCsR5tIYC4KqaM=;
 b=C/2StG/lC6MNX5EcRdqAeW5Ske7X+dOfpFtsxe+6uzu1EupUUx7ERImdFKwuEjyfWf4UIq/Qqk4qsZphw2v7W/zIoRqUz0XB0t5zWNcE4JAeLdBdr6MI9umOGMaLETTaMrjSp7nliZjTmijMg5JE0GGqC4LZSG+54LC4xYtWvmtYcPV7o2LuAWQlupwClaNUGyRxMTpJ1x80Bh3nYUbMImG7ugbPV/AI2FIxGeueSVDu6Wha853xOD+0y78S7wPhT7giikIJzzet+SB8ieZtIaAXsWTVKxp1GCBA7MHMwK8thMcSIuQF/5u+rFqyoYM6z9qhgFRcxxhz79zpuk8W7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0irKKwg2M+qc8ONuXRwoBks2LE17RXCsR5tIYC4KqaM=;
 b=nnP1MXWn5lX63wYfii707fOaJNtbH5RVu0CkFdhl8ok4mA8RS3DXXPYQsSzbLcGqB2KZwTjFnpSlmfYWwfqDYZDF7UCS+vaba8Tt1Cbsk2pj6Fc+ueMxe4eAuDhFaSoUFf6wjUtlUAfFSQ11QzBx0NnOSA0vNv/cw+YqbJkMYqY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6714.namprd10.prod.outlook.com (2603:10b6:610:142::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 17:49:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 17:49:52 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Greg KH <greg@kroah.com>
CC: Sherry Yang <sherry.yang@oracle.com>,
        Calum Mackay
	<calum.mackay@oracle.com>,
        linux-stable <stable@vger.kernel.org>, Petr Vorel
	<pvorel@suse.cz>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker
	<anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "ltp@lists.linux.it"
	<ltp@lists.linux.it>,
        Avinesh Kumar <akumar@suse.de>, Neil Brown
	<neilb@suse.de>,
        Josef Bacik <josef@toxicpanda.com>, Jeff Layton
	<jlayton@kernel.org>
Subject: Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
Thread-Topic: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
Thread-Index: 
 AQHazKCp5HoPbCA8x0icX5uCFQ/MP7HkDKAAgAQmtoCAARq9gIAACdiAgANUOoCAAHkFAA==
Date: Mon, 8 Jul 2024 17:49:52 +0000
Message-ID: <64D2D29F-BCC0-4A44-BB75-D85B80B75959@oracle.com>
References: <d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com>
 <2fc3a3fd-7433-45ba-b281-578355dca64c@oracle.com>
 <296EA0E6-0E72-4EA1-8B31-B025EB531F9B@oracle.com>
 <2024070638-shale-avalanche-1b51@gregkh>
 <E1A8C506-12CF-474B-9C1C-25EC93FCC206@oracle.com>
 <2024070814-very-vitamins-7021@gregkh>
In-Reply-To: <2024070814-very-vitamins-7021@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB6714:EE_
x-ms-office365-filtering-correlation-id: e374c3bb-910f-4dd4-ba72-08dc9f765ec2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VWl6aGRLNldPRk4vQXBHTFVjMUNlajROQU5JTTFQTTIwSkgzUzBjbzFsb2dI?=
 =?utf-8?B?RU5tSlljUE9HM2EwbDVwbTkxNU9kM2IrNXdhVUZBTXBsQlIzcXdjWnFnMDZw?=
 =?utf-8?B?OVp5eVF2OU0ydTFkZlZiZTUrZmhMZzF1ZXJJQ0dkRkdCZjlYQUo4ekZOdmox?=
 =?utf-8?B?bU1OYUwrSXR5NjBwc000bGd2VnlXV1ZvRkpWSi9HdXRHTnlZRWRCZXFwR0Q4?=
 =?utf-8?B?UTRsVlVNbkZSU1laY29ZTWU0T1hFRnpObmtacVVycDVrSXozbFM2UVZwdXZY?=
 =?utf-8?B?SDBwSVQ1T3FQaVY3elZFanN3YTZNWGI5WHBpWklrWVVZT1NDTFJBVTdId3B1?=
 =?utf-8?B?cVZDeDVJL25VTGJ6dUtVVlRNMUFqRnBqME1jREF6cjdrZmlQYUZVd0c0NFdN?=
 =?utf-8?B?alloZTMzWU9ZdDl1MVdZa2hPQ014WldLSGpDV2Y2bDJ6NEFGOG1TdEQ3VUVq?=
 =?utf-8?B?NHdSWk40eXpLdHVjSGloRVVBMjNJWE8rMVF0S1g2QitFeFVHZ0FsZ2RHQnd6?=
 =?utf-8?B?bDdWN2dmRmZCZTE3MmVvVHJYckRxNlA1RENZaURBQkp1U0VyWGZOL3IyTWk3?=
 =?utf-8?B?bzcvb0prM2w3dllpUndjSWJqZG1vTFRsWUZOTHEzQ1k5MnRWZ0dNZ24yM1Vu?=
 =?utf-8?B?eSszOFRlUXlOYURQZUhrQ3VDZGUvc05LREk5eldiMHdzWklSQy9QOWl6cmhV?=
 =?utf-8?B?eE5OS2ZXOXVEMXFDbVZOWnJBVlpBeG5mYVZHaUtreEtnZXRXQ056Q2M5OGN1?=
 =?utf-8?B?TmJKem9UTHNwZUcwU1A2Ny9YL295RVR6ZkZxT0NuMWh2UmhxQnEyZ3N0aVBY?=
 =?utf-8?B?T2tRZXZNNEtzV3QrMCtRejY5Y3MwV0xWU2V4VlJnWWI0Tkk3a3luaXRxcXhn?=
 =?utf-8?B?blVFM0JiS0tPUU9sV21nNnBMN0tMV1VZN3IzZnVzVWJOMlNkZnNPdTZwQUk3?=
 =?utf-8?B?T1E1TUhkL1dQZjhPUHN6NGV5c09xVVpMMGNzRnNIU0ovemJVUDIzVkcyTXAv?=
 =?utf-8?B?c1RrZmZmZmJ4UWNxa1dqczloR05tYVROYWNZMk5nM1BXSGZ5QlBIVVhwV3M1?=
 =?utf-8?B?alM4Mm9BWldIeGpQZWVLSytsbVRQL082MTQ3MkJtTkV2NUVTVGI2Y25FdlN5?=
 =?utf-8?B?aGhqWW1ZdWVPRTRIWmc1ZDF1THF3bS9uYzBoYTlrU2xwdEErT0loTFNsTXM2?=
 =?utf-8?B?NUpCWWZMUVdtbjB6Nk8rOGZIM2gxSVczZWZwSGZvSHdEcDdhR2dlSkllUVFH?=
 =?utf-8?B?S01oNi9wTEQ3dUtOMDEvM2FCby9zNS9WcGgzRXZpRENRTDY1bmlZSFd5UU9S?=
 =?utf-8?B?eTg3ak1NaWljejRuMjlwT2NwZUY2cXNGa2wrMGxjTEkva2ZHdVgzYkRwcVY4?=
 =?utf-8?B?cWVXV1lCc1lpTmdMWTN0dGkzZE9FV2dPVTZCUHFFREhHS1VEQzB5VHVqWm1S?=
 =?utf-8?B?YlhiSTFsYjBOZW9LZlpxVzRTZ3BVR2N3YTluTEFJNmZDYlduaHFtSUQrTnlZ?=
 =?utf-8?B?V0Evckt3WFcrNDdrZlpKMHhqaHdQUEpkakhwVTRnVmw0WDdMLzN5Nm5CV0Y5?=
 =?utf-8?B?ZEVDYmNmenlpS1BGMWpEWm9XUHIrNkxSVFpBSUQ2b09WU2tJby90ZXg2dVdM?=
 =?utf-8?B?WFV2amhKVXlraCtpV09ZUjdrQzVQaTZlaVdHVDMzcHBydFNaQy9kOG1rdkIw?=
 =?utf-8?B?V0Z2VnVzV3IzaDRkMHJSRzRMT3pyeHdTWGE5TTVWM284QnJYUGRGQ3ByQi81?=
 =?utf-8?B?S0RwQjBQK1N3TlNxREpoMTRZYlEyNjQrbGxkcnZqdTBDM0tLUlR1SS9Zclht?=
 =?utf-8?B?UlJ4ZzNTNEM2eExqMXBCTStBMWw5eURnUXpCSURyYjVER1pSZ1NSZS9wUThs?=
 =?utf-8?B?VzNKeUQ4QldRWjNKZkx3S3JCc01rSW84OXNVU3VOblJ2Y0E9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K1ZPOEZabjJHQ2E3a0E1Vzk0R1YvWjJRS0hWSUtRbzcrSElPVXhUcUxnQytU?=
 =?utf-8?B?ZjJiVWdhRjN1TE9OZUFySUZEQi9jcGZHWksyRGpjek16eUd1eVk4MVE3aWRL?=
 =?utf-8?B?YWd4eFhaNUJiSFUwNXJ3THNwbTBKNmZLUWY5NEtOZnZocWtwKzlCbE5tZEV3?=
 =?utf-8?B?cUh4Rm10SStLbFlUM1o1U0lxWmtTTFBYVEljQWNFQitVLzBsblF1N1UyY01G?=
 =?utf-8?B?NDZ3WkZtRlovRDViM1ZQVEpCM2NGTk9EdzJUYzJBR0FpK1B0a1JscVpQZnNq?=
 =?utf-8?B?Z2JwT2dnb1l0TS83eTNDQS9idElEbHdTZFlFRmpGSVlKMk81UXliQWNFN3lC?=
 =?utf-8?B?dndFaUlCRFpsd1FhUGpac3dZbTFReUtaU2xpT1gyek9tWE9BYUh0akhDeldN?=
 =?utf-8?B?NVFIa1MvSWx2QmZZR2pkRVhTT01PRUNLS1hTem9SclFUSTluMnVKbWRsTkNL?=
 =?utf-8?B?WDhOWjk2V3htWmlJclNyaHZMeWFkZ0RLM0pYZk1aRDFxamZTVFQvWTg0UTI1?=
 =?utf-8?B?dnc1Yzh2NHV2YUdHUmVMV3Bqc0w5NUM1dDdUbnZveXArOWtqRXRzZ09sbTVE?=
 =?utf-8?B?RUlNek9JNGtMbkF5dXo2Y2hMVEUza3A2ak5hYWlrMHFxbTlFNUJGQXFUVDhh?=
 =?utf-8?B?UVRCRTZnWU5ieUVPZTBKSVR5WDBqNkRTNUtKTnNYQTdXNDBNclFKcXNqVlpw?=
 =?utf-8?B?T1BibWZPOGowUngzaEQxbUgrRTdWTHVMZDJuTmZucEIwVGdOV0ozM0tqMVhu?=
 =?utf-8?B?SnRkSFV2YXlGanRwb3pRUENJUDRlVHRjdXkyYTFwN3BCeXhRUUM0RVZUNjU0?=
 =?utf-8?B?cmRWWFhYT3hwTUpjcnNBVjlOTUd2VHBOcUtjY1RaT1ZLYlNUK1hhSnZZNjFq?=
 =?utf-8?B?ajZLczlPUlRDY0IxOXBYSnZjc0RjN1YxejJNRWoramdBSnlkNFpIeFQrTDlq?=
 =?utf-8?B?UGdOOTNNbmFiM0ZKaGZ6cDRRT2JOekEvcU5QVmVOQ1duQlFxTDBKeStadCtS?=
 =?utf-8?B?YSt6WlRDTk9OeDlRNG1mdTNRbDVMQlZqdHZOVW1jb1NtbWFNZDk4RndJNDdL?=
 =?utf-8?B?Nk1xU3MyU25KYTJ6M2UyMWdFaXlnQXd0WUxlc0xvV0wwdmcwZFhQZ2VSWWtI?=
 =?utf-8?B?TlUwTUhOaURBNEE0WDdVVmVVbmZNVFcyUFZrNXdYUjdGKy80eE43MVJTcmMr?=
 =?utf-8?B?bnI5aDRyWG5mbmhIOEZ4WFZPM3B5OWE5VVhIVGxCby9WYmcweGVpNVhJak9s?=
 =?utf-8?B?anVtMmhLVkZabWVyV1BtQmJLV041RVIzN2JBTWl0RVlVRUlQc0NTV0g5RWNR?=
 =?utf-8?B?YVNjeDNacXEwZ1lzaC9Pd0RUakhGL1dPc1BLMHliWmtlM1ZmV0ZFL1I3VVJ0?=
 =?utf-8?B?N0Fzc00rVGhGQ2xyVjBQVCtsWk1RVGFHMVRnN09uNVEyc3grWkpna2Nhcnh1?=
 =?utf-8?B?ZG1idWtNbU9xYmdsMWNtRlVqUktaTGRZMHRTaW4vL3MvUyt5UGJnSW1Ea2V6?=
 =?utf-8?B?bysrNHoxaVlhakx1emJWL29hd214dFg5VWRxbURZSGJmeHVxd0l2WWREcDVM?=
 =?utf-8?B?TTBza2NYNmxSbW4xY0lzd0E0VWhmbVE5enJMbkhheisxamxWNnpjSVNYbnFQ?=
 =?utf-8?B?dWpaOUtoVzZlRnk3QzNLUnNseW5uWjF3TDByLzhYeURCbVVpRlZocXk5QkFZ?=
 =?utf-8?B?N0xRSDVFRVQ4RnBSTEZ6eTVzYjRjYWdVUTZrNjhzcEtGbnl1dDVNNm1jR2lX?=
 =?utf-8?B?Qkdld1dWWnpXWWFMVmxyb3BIK2xITDZsTmJxZ0R4R05yLy9ORWtLNG9jeHl3?=
 =?utf-8?B?bFh4STdKaGV4ZzVXeFJtWTJERHliTXNBSFJCSkZkdE5hNStackxMRjlwYUJN?=
 =?utf-8?B?MGN5YUZVdTJVY2F0Rk45WDZWd2NsY2IwVE9BMm5Wc3RhSW5rRExUUy9uWUxG?=
 =?utf-8?B?UmlrQ20zdjlkQUMyemg1Y2ZNT3FVSnRlcG1TMTd4dDBvbWkzaWxwMzEycUVu?=
 =?utf-8?B?SHhUeVhkNzEyQk9YU3puZ2dZQWRLL0lERTAwSVo1L0ltcG1pY0krQUVIaEsw?=
 =?utf-8?B?a3FCdnQ3NmhLaGdXQklnRTAxWjJvY0Y5bWNHV1V4RUJuT0U4dG01bkR2RmU1?=
 =?utf-8?B?Yy9iMTg1YUFyUzRSdFY4QzR3Qnhkc21ObFFpTVFDUVhoZWhCanV5TTA1STI4?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D81C9EE19ADF964D844AC85ED7458EFC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Z08rUG5TB3hiPBPwl7VxhLNnt9KhWJhLePS9tjTFvFxMvJrxEf6ffZQjU8FuawWPa+UccByL37QE1DKsev068XchHo3XU5GaRlPPn8aUsZnO1JvnSKELPBNc3J5rUqid/qPjPOn35Pq2H3XEXibXDc4SmCvz4Nq1ycldfe6BLA68AY4AqjnpVQ1R1GCiMWRKjmi4u+llaKXzRfyPDzU+9YF1MEgA9xb0Eqyi2cUG/Qthk21+9byXmfHPWN7HWMdTnXyaFGigci5BT9jI5UBLZ6wYV2gPJTMdlk/UXjUNFiQnGNGbkaNxOi8ehl3nzfPhAi5bm+IHhSRnUj20AeJVJ924AruOK7nn04N7/SdOT7iERq3yl2uLSgKiSweEshnORTeLm1qkNUuw/b3L8BSyIqL2VJGr3rKZ5w7/c5cNxM+7ktK3vEYO3l+s//G2qxO77DUwYaz134SoIttwx00UkjtTJ2PAusaMDNOf8XrIT8yhKPiPrXYhoH6uRBOihwHgZl1oT0qJc8OqBo4yyHx182aHmtp5d88sp0aiINibbnBqwB31eYijjVq+4qlnKqvhX2bjGA20YpOlQ6l1f83Blo4i9iQ8EoH3OxQiOiG26qw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e374c3bb-910f-4dd4-ba72-08dc9f765ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 17:49:52.4517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3kdRUO3dCDQ6pmiQDssRPYNS6g9gNxcR+/wf4iMdQtN30fQEFaQ58VmwzviDMdsXxl4a9hSuk69ZtOWJjIOJkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080133
X-Proofpoint-ORIG-GUID: 25TgEeve_F1c9Gki-YIeVrviHMNHtpnB
X-Proofpoint-GUID: 25TgEeve_F1c9Gki-YIeVrviHMNHtpnB

DQoNCj4gT24gSnVsIDgsIDIwMjQsIGF0IDY6MzbigK9BTSwgR3JlZyBLSCA8Z3JlZ0Brcm9haC5j
b20+IHdyb3RlOg0KPiANCj4gT24gU2F0LCBKdWwgMDYsIDIwMjQgYXQgMDc6NDY6MTlBTSArMDAw
MCwgU2hlcnJ5IFlhbmcgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIEp1bCA2LCAyMDI0LCBhdCAx
MjoxMeKAr0FNLCBHcmVnIEtIIDxncmVnQGtyb2FoLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24g
RnJpLCBKdWwgMDUsIDIwMjQgYXQgMDI6MTk6MThQTSArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdy
b3RlOg0KPj4+PiANCj4+Pj4gDQo+Pj4+PiBPbiBKdWwgMiwgMjAyNCwgYXQgNjo1NeKAr1BNLCBD
YWx1bSBNYWNrYXkgPGNhbHVtLm1hY2theUBvcmFjbGUuY29tPiB3cm90ZToNCj4+Pj4+IA0KPj4+
Pj4gVG8gY2xhcmlmeeKApg0KPj4+Pj4gDQo+Pj4+PiBPbiAwMi8wNy8yMDI0IDU6NTQgcG0sIENh
bHVtIE1hY2theSB3cm90ZToNCj4+Pj4+PiBoaSBQZXRyLA0KPj4+Pj4+IEkgbm90aWNlZCB5b3Vy
IExUUCBwYXRjaCBbMV1bMl0gd2hpY2ggYWRqdXN0cyB0aGUgbmZzc3RhdDAxIHRlc3Qgb24gdjYu
OSBrZXJuZWxzLCB0byBhY2NvdW50IGZvciBKb3NlZidzIGNoYW5nZXMgWzNdLCB3aGljaCByZXN0
cmljdCB0aGUgTkZTL1JQQyBzdGF0cyBwZXItbmFtZXNwYWNlLg0KPj4+Pj4+IEkgc2VlIHRoYXQg
Sm9zZWYncyBjaGFuZ2VzIHdlcmUgYmFja3BvcnRlZCwgYXMgZmFyIGJhY2sgYXMgbG9uZ3Rlcm0g
djUuNCwNCj4+Pj4+IA0KPj4+Pj4gU29ycnksIHRoYXQncyBub3QgcXVpdGUgYWNjdXJhdGUuDQo+
Pj4+PiANCj4+Pj4+IEpvc2VmJ3MgTkZTIGNsaWVudCBjaGFuZ2VzIHdlcmUgYWxsIGJhY2twb3J0
ZWQgZnJvbSB2Ni45LCBhcyBmYXIgYXMgbG9uZ3Rlcm0gdjUuNC55Og0KPj4+Pj4gDQo+Pj4+PiAy
MDU3YTQ4ZDBkZDAgc3VucnBjOiBhZGQgYSBzdHJ1Y3QgcnBjX3N0YXRzIGFyZyB0byBycGNfY3Jl
YXRlX2FyZ3MNCj4+Pj4+IGQ0NzE1MWI3OWUzMiBuZnM6IGV4cG9zZSAvcHJvYy9uZXQvc3VucnBj
L25mcyBpbiBuZXQgbmFtZXNwYWNlcw0KPj4+Pj4gMTU0ODAzNmVmMTIwIG5mczogbWFrZSB0aGUg
cnBjX3N0YXQgcGVyIG5ldCBuYW1lc3BhY2UNCj4+Pj4+IA0KPj4+Pj4gDQo+Pj4+PiBPZiBKb3Nl
ZidzIE5GUyBzZXJ2ZXIgY2hhbmdlcywgZm91ciB3ZXJlIGJhY2twb3J0ZWQgZnJvbSB2Ni45IHRv
IHY2Ljg6DQo+Pj4+PiANCj4+Pj4+IDQxOGI5Njg3ZGVjZSBzdW5ycGM6IHVzZSB0aGUgc3RydWN0
IG5ldCBhcyB0aGUgc3ZjIHByb2MgcHJpdmF0ZQ0KPj4+Pj4gZDk4NDE2Y2MyMTU0IG5mc2Q6IHJl
bmFtZSBORlNEX05FVF8qIHRvIE5GU0RfU1RBVFNfKg0KPj4+Pj4gOTM0ODNhYzVmZWM2IG5mc2Q6
IGV4cG9zZSAvcHJvYy9uZXQvc3VucnBjL25mc2QgaW4gbmV0IG5hbWVzcGFjZXMNCj4+Pj4+IDRi
MTQ4ODU0MTFmNyBuZnNkOiBtYWtlIGFsbCBvZiB0aGUgbmZzZCBzdGF0cyBwZXItbmV0d29yayBu
YW1lc3BhY2UNCj4+Pj4+IA0KPj4+Pj4gYW5kIHRoZSBvdGhlcnMgcmVtYWluZWQgb25seSBpbiB2
Ni45Og0KPj4+Pj4gDQo+Pj4+PiBhYjQyZjRkOWEyNmYgc3VucnBjOiBkb24ndCBjaGFuZ2UgLT5z
dl9zdGF0cyBpZiBpdCBkb2Vzbid0IGV4aXN0DQo+Pj4+PiBhMjIxNGVkNTg4ZmIgbmZzZDogc3Rv
cCBzZXR0aW5nIC0+cGdfc3RhdHMgZm9yIHVudXNlZCBzdGF0cw0KPj4+Pj4gZjA5NDMyMzg2NzY2
IHN1bnJwYzogcGFzcyBpbiB0aGUgc3Zfc3RhdHMgc3RydWN0IHRocm91Z2ggc3ZjX2NyZWF0ZV9w
b29sZWQNCj4+Pj4+IDNmNmVmMTgyZjE0NCBzdW5ycGM6IHJlbW92ZSAtPnBnX3N0YXRzIGZyb20g
c3ZjX3Byb2dyYW0NCj4+Pj4+IGU0MWVlNDRjYzZhNCBuZnNkOiByZW1vdmUgbmZzZF9zdGF0cywg
bWFrZSB0aF9jbnQgYSBnbG9iYWwgY291bnRlcg0KPj4+Pj4gMTZmYjk4MDhhYjJjIG5mc2Q6IG1h
a2Ugc3ZjX3N0YXQgcGVyLW5ldHdvcmsgbmFtZXNwYWNlIGluc3RlYWQgb2YgZ2xvYmFsDQo+Pj4+
PiANCj4+Pj4+IA0KPj4+Pj4gDQo+Pj4+PiBJJ20gd29uZGVyaW5nIGlmIHRoaXMgZGlmZmVyZW5j
ZSBiZXR3ZWVuIE5GUyBjbGllbnQsIGFuZCBORlMgc2VydmVyLCBzdGF0IGJlaGF2aW91ciwgYWNy
b3NzIGtlcm5lbCB2ZXJzaW9ucywgbWF5IHBlcmhhcHMgY2F1c2Ugc29tZSB1c2VyIGNvbmZ1c2lv
bj8NCj4+Pj4gDQo+Pj4+IEFzIGEgcmVmcmVzaGVyIGZvciB0aGUgc3RhYmxlIGZvbGtlbiwgSm9z
ZWYncyBjaGFuZ2VzIG1ha2UNCj4+Pj4gbmZzc3RhdHMgc2lsbydkLCBzbyB0aGV5IG5vIGxvbmdl
ciBzaG93IGNvdW50cyBmcm9tIHRoZSB3aG9sZQ0KPj4+PiBzeXN0ZW0sIGJ1dCBvbmx5IGZvciBO
RlMgb3BlcmF0aW9ucyByZWxhdGluZyB0byB0aGUgbG9jYWwgbmV0DQo+Pj4+IG5hbWVzcGFjZS4g
VGhhdCBpcyBhIHN1cnByaXNpbmcgY2hhbmdlIGZvciBzb21lIHVzZXJzLCB0b29scywNCj4+Pj4g
YW5kIHRlc3RpbmcuDQo+Pj4+IA0KPj4+PiBJJ20gbm90IGNsZWFyIG9uIHdoZXRoZXIgdGhlcmUg
YXJlIGFueSBydWxlcy9ndWlkZWxpbmVzIGFyb3VuZA0KPj4+PiBMVFMgYmFja3BvcnRzIGNhdXNp
bmcgYmVoYXZpb3IgY2hhbmdlcyB0aGF0IHVzZXIgdG9vbHMsIGxpa2UNCj4+Pj4gbmZzc3RhdCwg
bWlnaHQgYmUgaW1wYWN0ZWQgYnkuDQo+Pj4gDQo+Pj4gVGhlIHNhbWUgcnVsZXMgdGhhdCBhcHBs
eSBmb3IgTGludXMncyB0cmVlIChpLmUuIG5vIHVzZXJzcGFjZQ0KPj4+IHJlZ3Jlc3Npb25zLikN
Cj4+IA0KPj4gR2l2ZW4gdGhlIGN1cnJlbnQgZGF0YSB3ZSBoYXZlLCBMVFAgbmZzc3RhdDAxWzFd
IGZhaWxlZCBvbiBMVFMgdjUuNC4yNzggYmVjYXVzZSBvZiBrZXJuZWwgY29tbWl0IDE1NDgwMzZl
ZjEyMDQgKCJuZnM6DQo+PiBtYWtlIHRoZSBycGNfc3RhdCBwZXIgbmV0IG5hbWVzcGFjZSIpIFsy
XS4gT3RoZXIgTFRTIHdoaWNoIGJhY2twb3J0ZWQgdGhlIHNhbWUgY29tbWl0IGFyZSB2ZXJ5IGxp
a2VseSB0cm91YmxlZCB3aXRoIHRoZSBzYW1lIExUUCB0ZXN0IGZhaWx1cmUuDQo+PiANCj4+IFRo
ZSBmb2xsb3dpbmcgYXJlIHRoZSBMVFAgbmZzc3RhdDAxIGZhaWx1cmUgb3V0cHV0DQo+PiANCj4+
ID09PT09PT09DQo+PiBuZXR3b3JrIDEgVElORk86IGluaXRpYWxpemUgJ2xob3N0JyAnbHRwX25z
X3ZldGgyJyBpbnRlcmZhY2UNCj4+IG5ldHdvcmsgMSBUSU5GTzogYWRkIGxvY2FsIGFkZHIgMTAu
MC4wLjIvMjQNCj4+IG5ldHdvcmsgMSBUSU5GTzogYWRkIGxvY2FsIGFkZHIgZmQwMDoxOjE6MTo6
Mi82NA0KPj4gbmV0d29yayAxIFRJTkZPOiBpbml0aWFsaXplICdyaG9zdCcgJ2x0cF9uc192ZXRo
MScgaW50ZXJmYWNlDQo+PiBuZXR3b3JrIDEgVElORk86IGFkZCByZW1vdGUgYWRkciAxMC4wLjAu
MS8yNA0KPj4gbmV0d29yayAxIFRJTkZPOiBhZGQgcmVtb3RlIGFkZHIgZmQwMDoxOjE6MTo6MS82
NA0KPj4gbmV0d29yayAxIFRJTkZPOiBOZXR3b3JrIGNvbmZpZyAobG9jYWwgLS0gcmVtb3RlKToN
Cj4+IG5ldHdvcmsgMSBUSU5GTzogbHRwX25zX3ZldGgyIC0tIGx0cF9uc192ZXRoMQ0KPj4gbmV0
d29yayAxIFRJTkZPOiAxMC4wLjAuMi8yNCAtLSAxMC4wLjAuMS8yNA0KPj4gbmV0d29yayAxIFRJ
TkZPOiBmZDAwOjE6MToxOjoyLzY0IC0tIGZkMDA6MToxOjE6OjEvNjQNCj4+IDw8PHRlc3Rfc3Rh
cnQ+Pj4NCj4+IHRhZz12ZXRofG5mc3N0YXQzXzAxIHN0aW1lPTE3MTk5NDM1ODYNCj4+IGNtZGxp
bmU9Im5mc3N0YXQwMSINCj4+IGNvbnRhY3RzPSIiDQo+PiBhbmFseXNpcz1leGl0DQo+PiA8PDx0
ZXN0X291dHB1dD4+Pg0KPj4gaW5jcmVtZW50aW5nIHN0b3ANCj4+IG5mc3N0YXQwMSAxIFRJTkZP
OiB0aW1lb3V0IHBlciBydW4gaXMgMGggMjBtIDBzDQo+PiBuZnNzdGF0MDEgMSBUSU5GTzogc2V0
dXAgTkZTdjMsIHNvY2tldCB0eXBlIHVkcA0KPj4gbmZzc3RhdDAxIDEgVElORk86IE1vdW50aW5n
IE5GUzogbW91bnQgLXQgbmZzIC1vIHByb3RvPXVkcCx2ZXJzPTMgMTAuMC4wLjI6L3RtcC9uZXRw
YW4tNDU3Ny9MVFBfbmZzc3RhdDAxLmx6NnpoZ1FIb1YvMy91ZHAgL3RtcC9uZXRwYW4tNDU3Ny9M
VFBfbmZzc3RhdDAxLmx6NnpoZ1FIb1YvMy8wDQo+PiBuZnNzdGF0MDEgMSBUSU5GTzogY2hlY2tp
bmcgUlBDIGNhbGxzIGZvciBzZXJ2ZXIvY2xpZW50DQo+PiBuZnNzdGF0MDEgMSBUSU5GTzogY2Fs
bHMgOTgvMA0KPj4gbmZzc3RhdDAxIDEgVElORk86IENoZWNraW5nIGZvciB0cmFja2luZyBvZiBS
UEMgY2FsbHMgZm9yIHNlcnZlci9jbGllbnQNCj4+IG5mc3N0YXQwMSAxIFRJTkZPOiBuZXcgY2Fs
bHMgMTAyLzANCj4+IG5mc3N0YXQwMSAxIFRQQVNTOiBzZXJ2ZXIgUlBDIGNhbGxzIGluY3JlYXNl
ZA0KPj4gbmZzc3RhdDAxIDEgVEZBSUw6IGNsaWVudCBSUEMgY2FsbHMgbm90IGluY3JlYXNlZA0K
Pj4gbmZzc3RhdDAxIDEgVElORk86IGNoZWNraW5nIE5GUyBjYWxscyBmb3Igc2VydmVyL2NsaWVu
dA0KPj4gbmZzc3RhdDAxIDEgVElORk86IGNhbGxzIDIvMg0KPj4gbmZzc3RhdDAxIDEgVElORk86
IENoZWNraW5nIGZvciB0cmFja2luZyBvZiBORlMgY2FsbHMgZm9yIHNlcnZlci9jbGllbnQNCj4+
IG5mc3N0YXQwMSAxIFRJTkZPOiBuZXcgY2FsbHMgMy8zDQo+PiBuZnNzdGF0MDEgMSBUUEFTUzog
c2VydmVyIE5GUyBjYWxscyBpbmNyZWFzZWQNCj4+IG5mc3N0YXQwMSAxIFRQQVNTOiBjbGllbnQg
TkZTIGNhbGxzIGluY3JlYXNlZA0KPj4gbmZzc3RhdDAxIDIgVElORk86IENsZWFuaW5nIHVwIHRl
c3RjYXNlDQo+PiBuZnNzdGF0MDEgMiBUSU5GTzogU0VMaW51eCBlbmFibGVkIGluIGVuZm9yY2lu
ZyBtb2RlLCB0aGlzIG1heSBhZmZlY3QgdGVzdCByZXN1bHRzDQo+PiBuZnNzdGF0MDEgMiBUSU5G
TzogaXQgY2FuIGJlIGRpc2FibGVkIHdpdGggVFNUX0RJU0FCTEVfU0VMSU5VWD0xIChyZXF1aXJl
cyBzdXBlci9yb290KQ0KPj4gbmZzc3RhdDAxIDIgVElORk86IGluc3RhbGwgc2VpbmZvIHRvIGZp
bmQgdXNlZCBTRUxpbnV4IHByb2ZpbGVzDQo+PiBuZnNzdGF0MDEgMiBUSU5GTzogbG9hZGVkIFNF
TGludXggcHJvZmlsZXM6IG5vbmUNCj4+IA0KPj4gU3VtbWFyeToNCj4+IHBhc3NlZCAzDQo+PiBm
YWlsZWQgMQ0KPj4gc2tpcHBlZCAwDQo+PiB3YXJuaW5ncyAwDQo+PiA8PDxleGVjdXRpb25fc3Rh
dHVzPj4+DQo+PiBpbml0aWF0aW9uX3N0YXR1cz0ib2siDQo+PiBkdXJhdGlvbj0xIHRlcm1pbmF0
aW9uX3R5cGU9ZXhpdGVkIHRlcm1pbmF0aW9uX2lkPTEgY29yZWZpbGU9bm8NCj4+IGN1dGltZT0x
MSBjc3RpbWU9MTYNCj4+IDw8PHRlc3RfZW5kPj4+DQo+PiBsdHAtcGFuIHJlcG9ydGVkIEZBSUwN
Cj4+ID09PT09PT09DQo+PiANCj4+IFdlIGNhbiBvYnNlcnZlIHRoZSBudW1iZXIgb2YgUlBDIGNs
aWVudCBjYWxscyBpcyAwLCB3aGljaCBpcyB3aXJlZC4gQW5kIHRoaXMgaGFwcGVucyBmcm9tIHRo
ZSBrZXJuZWwgY29tbWl0IDU3ZDFjZTk2ZDc2NTUgKCJuZnM6IG1ha2UgdGhlIHJwY19zdGF0IHBl
ciBuZXQgbmFtZXNwYWNl4oCdKS4gU28gbm93IHdl4oCZcmUgbm90IHN1cmUgdGhlIGtlcm5lbCBi
YWNrcG9ydCBvZiBuZnMgY2xpZW50IGNoYW5nZXMgaXMgcHJvcGVyLCBvciB0aGUgTFRQIHRlc3Rz
IC8gdXNlcnNwYWNlIG5lZWQgdG8gYmUgbW9kaWZpZWQuDQo+PiANCj4+IElmIG5vIHVzZXJzcGFj
ZSByZWdyZXNzaW9uLCBzaG91bGQgd2UgcmV2ZXJ0IHRoZSBKb3NlZuKAmXMgTkZTIGNsaWVudC1z
aWRlIGNoYW5nZXMgb24gTFRTPw0KPiANCj4gVGhpcyBzb3VuZHMgbGlrZSBhIHJlZ3Jlc3Npb24g
aW4gTGludXMncyB0cmVlIHRvbywgc28gd2h5IGlzbid0IGl0DQo+IHJldmVydGVkIHRoZXJlIGZp
cnN0Pw0KDQpUaGVyZSBpcyBhIGNoYW5nZSBpbiBiZWhhdmlvciBpbiB0aGUgdXBzdHJlYW0gY29k
ZSwgYnV0IEpvc2VmJ3MNCnBhdGNoZXMgZml4IGFuIGluZm9ybWF0aW9uIGxlYWsgYW5kIG1ha2Ug
dGhlIHN0YXRpc3RpY3MgbW9yZQ0Kc2Vuc2libGUgaW4gY29udGFpbmVyIGVudmlyb25tZW50cy4g
SSdtIG5vdCBjZXJ0YWluIHRoYXQNCnNob3VsZCBiZSBjb25zaWRlcmVkIGEgcmVncmVzc2lvbiwg
YnV0IGNvbmZlc3MgSSBkb24ndCBrbm93DQp0aGUgcmVncmVzc2lvbiBydWxlcyB0byB0aGlzIGZp
bmUgYSBkZWdyZWUgb2YgZGV0YWlsLg0KDQpJZiBpdCBpcyBpbmRlZWQgYSByZWdyZXNzaW9uLCBo
b3cgY2FuIHdlIGdvIGFib3V0IHJldGFpbmluZw0KYm90aCBiZWhhdmlvcnMgKHNlbGVjdGFibGUg
YnkgS2NvbmZpZyBvciBwZXJoYXBzIGFkbWluaXN0cmF0aXZlDQpVSSk/DQoNCg0KLS0NCkNodWNr
IExldmVyDQoNCg0K

