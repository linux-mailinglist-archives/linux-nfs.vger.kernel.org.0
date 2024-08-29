Return-Path: <linux-nfs+bounces-5965-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7000964797
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 16:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161E51C2472A
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 14:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555971AE84C;
	Thu, 29 Aug 2024 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m7LDH8s6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dvC7fvsg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898B11ABEAF
	for <linux-nfs@vger.kernel.org>; Thu, 29 Aug 2024 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940359; cv=fail; b=MpMyz/M2kqBpPvkVv5AHh3MPJdno2rcGHq5Y+y2ZT1LpRrRv++HPTTAvt6PYjrGpmM+kNi3bzFqn+zDZS+QkrpdRTyTIF8twZuw4Oqs+UwJhctqJPKIKrw3BLRAxank3sTTCjtJX7HmH0jRcQGGEKAcBrRDWE40CGDAzTZvBW40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940359; c=relaxed/simple;
	bh=6PB2moEUk4TMH3MVTXPC/UsMv15J4QECOHOSR67P7NM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a54NSiY7MhyGABDj9Zvb73JxUnr9R8v0SL5a0tGEsUhVs6JIbBuzwtB2sFaRQZgl/ZKsbt06TTlmiCy3iZoWbkUb26dAn2I/w1U+b8BquwqoYPV2Y4C5UKxMEJ/LXcaOw4zSIB4SS+JGy4BGfEzWUEAzXIYwEGOMmczcayfJHI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m7LDH8s6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dvC7fvsg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TBYFCi030245;
	Thu, 29 Aug 2024 14:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=6PB2moEUk4TMH3MVTXPC/UsMv15J4QECOHOSR67P7
	NM=; b=m7LDH8s6M21wbhzLom3kkEXKjp4ONvQFGMpYR8erJ1BAJFLGn6uIhLtyQ
	HH3yZn0xQfKTio0NnP2cLrPA0QA50EyoeO3F4qBl4+TWApYWmYFlmBxqHZZzCDjS
	/20nK3bJFrgVOK9PwtrRaq9GPks0PpQAvfmAePRQktMyXOmKQBm8CCZXKDnz0WBC
	ngEYr0sn6EVaEXtxueZ6CIpOBYsbPfpamaGYMnRRNdyqqbq9ggUbHDyPZE0IcPpk
	BbRxA5R0+xErtluvjQbIjtifWiIEXhzj5/CzGJtd1vh6mQD4GTif8KRYIn4v8pO4
	8yK1juqGURwyhSwKbCaxiH6eZGhIg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pup4cyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 14:05:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TD47mh036501;
	Thu, 29 Aug 2024 14:05:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jn9ak5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 14:05:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxSAHmP3FklQgpgcBBQolfNU2uP/Wb5cecTZf9yxLPEjjrv+Rk1/W4UvZDDJITX7+lFsxcbxO3l3g8rkxtzRaFwF1p3l9f22LNzSm5ZrSBu6Zyy7Km72O5+x5E8qzd/RqMZ2Xr0EfSrK6htS8XvitWRxTz8vSENvBFpJBVxAc9Oj2wYjww3I9goEIaKRu74wvZlKYcZpyn6xUbThUIBmEZ2/VbE6MPkWt1F9UwsuIOZFxHm30bt7aCc22hjpz/63fW1ahVfaVW1BGnBOBz2e0Nw7aLPbaqU/Bq0UZEMnvTi6fxsVTuT59i0F9rfwt4I3ZPG+/Sjheu7bdv93HrvxpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PB2moEUk4TMH3MVTXPC/UsMv15J4QECOHOSR67P7NM=;
 b=KCOa/gPXwCU98WO4LE4ejt7gtXBIzO0waCpF1xihETvvVbvwuGAyPcWaTmep7rlQBvH++eCaiYZKikDMAAK2Xpxb3/EWnh3vhY/50x+WGZl29+jdvuJm9zrFjZXcMpUqUf5hgg/9yA+TTcjaxjQMqYgjuyLTh4i1gaJWuNMR7fh3haHjpVA9PLS3LxF3BAG9GVJv33pjbgYaLYWPShumn2L5Hd941jGPruSt/ugRDghv8Q/qqgmmDVOVNBHjl1UtM1ADQa7sOId9nGhDEkK4+BMXeW+oabu85Eom/RFfRLRE6A+8VBGlfdhhzZHfNy6O5ZtdrH++D6YYcZs7BoTyuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PB2moEUk4TMH3MVTXPC/UsMv15J4QECOHOSR67P7NM=;
 b=dvC7fvsgwkeHq4yve0L7x57X99gUL3lWTKvxBSRc+QnXP+rw3DKDA6OdQauuYUf79+MQE40HdxzX8q75s+uZc1B5K1GSyWIBJMcvecwlTULGfPCmnxLCtjVjbA67mq1hM4Lo5T4Ge91fuzUyVp9SYKqGjv4VvD4yxnAfK69JYmw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ1PR10MB6004.namprd10.prod.outlook.com (2603:10b6:a03:45d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Thu, 29 Aug
 2024 14:05:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 14:05:41 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Olga Kornievskaia <aglo@umich.edu>
CC: Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
	<dai.ngo@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC PATCH 6/7] NFSD: Document callback stateid laundering
Thread-Topic: [RFC PATCH 6/7] NFSD: Document callback stateid laundering
Thread-Index: AQHa+XFjqaTrWEJ2rUiOlNRQuXqFE7I9RhKAgAEAD4A=
Date: Thu, 29 Aug 2024 14:05:41 +0000
Message-ID: <5AA76799-6840-4F65-A944-548FFE378382@oracle.com>
References: <20240828174001.322745-9-cel@kernel.org>
 <20240828174001.322745-15-cel@kernel.org>
 <CAN-5tyEL6kDQ7N6yQDswj+JgmnjnhpzVoYA_tWrsR8Yu2Nyg2w@mail.gmail.com>
In-Reply-To:
 <CAN-5tyEL6kDQ7N6yQDswj+JgmnjnhpzVoYA_tWrsR8Yu2Nyg2w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ1PR10MB6004:EE_
x-ms-office365-filtering-correlation-id: 5488e01a-59e0-4197-5d1d-08dcc833aaca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a0tzdHdoUHh3MjFjL1I4ejFrL0RXemkrU2xOcUpXckprdk5FZHExTWpuVE1l?=
 =?utf-8?B?dUtrcmFMeEdqRFhtYWsxWG1jWlBYa0ZEdmM5c3p3S2EvOTlaQ0NjaGxTblBv?=
 =?utf-8?B?M3FyYWlRbUVvSVppMWpQMUg1eUxQOFExdllXbnI2RWkrTHNwcXRjbFZUYkcv?=
 =?utf-8?B?TVNDUzJZVi9mbGlTRTBpMWNKZmFBL2J5SldIeUIzdk5CKzkvTHZNMzBjZUNl?=
 =?utf-8?B?QzYzSkdiNHA1NnJEVUVaazR5aENTYk9lSkU1SVZzR204SVFtZTdpRm9QVHN2?=
 =?utf-8?B?SlYvVHNTbTIzVGNOczNndDBweHVPUzJCYURBa3FLUTNwOCtPUDUvNStEakIy?=
 =?utf-8?B?eGZmRUVqQnBTSWpwNGFxemJCWCtnMTZ0UXN5WmNOM0h6MFc2S2RrcTBIY0g0?=
 =?utf-8?B?Y2pJNHBPTldkTFVUU3JhOXZKMStHbWkxc1BhbVNOWDA2WmpWTFJtcjBHVHV5?=
 =?utf-8?B?TU5JS3N1WE5MdjdxbHlzRnVGeDVrdFdxbGwxdGVDazFseTE1Smp1elFNaEJl?=
 =?utf-8?B?aC9jbkFxbGJpOFAvWGpRK09YSkR2K2FJcVA2ZG1WRHRGOFVnV0RaVy9sd0VC?=
 =?utf-8?B?aU1rVTBlejR1ZVY3QTA2L3d5KzkwRXJaLzlZdmpmYmpGaTZaSTV4WFFMMktF?=
 =?utf-8?B?b0l6Q0dnaHJTUEY2OW13ZWZabzRFK0tUbEIwK3htZmRCTTEzcndxUVkvSld3?=
 =?utf-8?B?c3h0VjhoNU9qQ0hjMU1MclZiT2NabFBMM242NVZISWZkOG1PTHlOUlJNbXB4?=
 =?utf-8?B?cVFKc2ZIY2F5d2NnQlp2UDVHVVRjUnR2dWh5N2JSQ2czbWlnSWo3YlZCcHQ2?=
 =?utf-8?B?dVJHNDYrNGxnOFlseFY5TDBDU2ZUTXRMRUgzUWdBV2RNRUpNSzFkditoOWJ2?=
 =?utf-8?B?dlFBQ29uVjBUVHFiTGdvRnZmVHF6aE1vd0toNXhhZEJESGI1c3l3SUcyYnBF?=
 =?utf-8?B?aitpVUYrcVNEWDFMMjhuUG44ZEJGcWloaUN6THhmYS9yTGVtSVp4UGM0bmE2?=
 =?utf-8?B?bS9sNkxZbkdqQ0E0U25OZDg4bU5LaXlmMmJiQlNCcEZiOVF5Zm45Tmh3MEZp?=
 =?utf-8?B?WGpTb2tDSlIvYWU5WWs0bXZtL1VLR0xzaVcveGZIV2VkNTViNWRjNmhoT1Vp?=
 =?utf-8?B?OE9CVGtFMWhPM1JYMXFqajZyNGpWQ3RCczQyWHNPd2d6S1FDcG1ycXVBdytl?=
 =?utf-8?B?eXZGRkhhNTVUdE5TT1VZWjlnVmk0QW9VWThHNGdDaXRwdW0xR3graks2cmNo?=
 =?utf-8?B?dVJXdnFtK2hQdThGTXFlWk14US95UlN5UW1ZcExUQ1ZoVlZLcDE2ZUptYTZq?=
 =?utf-8?B?QW1KT1FXNVFyQUlBdmwxYjZMQnFjVW9PcEVjTkl5eXkvcW8xKzlUb0hOQjEy?=
 =?utf-8?B?YmdpZmFzM3JRSEw3ekNMWmFFMUphYU1UMytReXJWcDkrcVJEaTAvUUJtbGtQ?=
 =?utf-8?B?U0JnZlhKbFdWSmNGOGJUVzRnTzRFeHVGYjQyVUxMYWMwT2Z2RTBGaU1LWGVn?=
 =?utf-8?B?azNkUHRRUnVIaE1TdnRNdW80ZFhQYzJOZkRkaHZxMTZsdHdzM2pCeWZmN3Z1?=
 =?utf-8?B?STZiSkRHVXMrejYvR0VENkgwQlhmKzFKNVNTdE1lY2EwS1hBTDFYbU00NVZm?=
 =?utf-8?B?Y0tWSzJMSUdSYnVhMmpVSWJjeThHTnN2MW00RkFGK2kyeTArWjRURDJDa3lh?=
 =?utf-8?B?V04rRWMrT2R1QklBcFZhem5YSjNNZFBxbXM3aWJkT0Vma2Z4bkhjUHNvS25R?=
 =?utf-8?B?d0ZoUHVQZGN4RTI3c2RBYzFBeEc0dWVFbXpCTy9Wa3lSN1VRUjVOZUlwU3VM?=
 =?utf-8?B?ZHo4QlpEVmpyNGw3NDBNeS94ZHJrNFhoV0k2NTZFSm9nZ2swb0haais0dlFG?=
 =?utf-8?B?Lzl1aE9XZzNUQVJGTUxoUUV4eFI2OG9KbDNSbFI4SzBnUFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NTFNZyttNWdaczBrdEpONmxkVmNoVFJIMUpxeThIdTl5eG5lNXJiOUZCeFZ3?=
 =?utf-8?B?Z082VmorOUVLYVJNdDk4YVdCbENTWVc5OEgxOUZhOVBZN0RKN2lQUWtGVTZn?=
 =?utf-8?B?TUFST1ZlMkdhWEFscGY5NElyY2UrUDllUkVmajVDTUw3aysxRzRBOURGcVdV?=
 =?utf-8?B?MTdFSUMrdk8zazJyUEpKTVZCZzc0eHNZc1hmaWJlM3grcjFnV0g4TVhuV0lK?=
 =?utf-8?B?NS8zSmdheEhjWnJVb0lVNGZ1NFM2dUs4M0c5bHNWdGpIalZ4cUJNb1Vxa2Nr?=
 =?utf-8?B?L09SQm5GWHcvWk5kZktSVUY1aE5qdEJYK0pYYjNRajlSYkVBRG9pckRKV0tR?=
 =?utf-8?B?Z1hsczhwd0lDaFc3OHh0VWVkSGpaQXV4cVBpdFREU3pDQ0RmRXlBUEtRR1hM?=
 =?utf-8?B?MlhQbXA5czNrTWRxRytFbkZlTmxtLyt1d2xlQUZFK0hwUUhDQXNHSEN2QUhm?=
 =?utf-8?B?TVZUUW0rdFkxclFDKzZXQTAwYkZhRXBlb0h2S0dpT2djeGNBbmovTWNhUHRo?=
 =?utf-8?B?OVhSM3Zlb0U0RWlEK2QxRTB6L3ZWNnR3NlZDNlNzNUlsV0VzZzhTbFhYQnZF?=
 =?utf-8?B?WmV6WjE1WC81TjRaZCtORVpJSzBGc1ZKdFYyODNXcitxdkZBVEtTdjhBTUhG?=
 =?utf-8?B?L0daRnpDYVZVQjFyUWNXK3JHbXR5N0xLYWREMnJQNExZeHNwSi9kbVlUMEtW?=
 =?utf-8?B?ZGM4MWJHWkVPTGZ5TncxZitueVZwMjFzY2dVeGcrLytqelJPNlBtdXdpck9n?=
 =?utf-8?B?ZTcvWUNlRGZHRWJIcHRPdk0vKzd4dWdnZEhSZmt4MUd3SHR3T08zMUxhZFJB?=
 =?utf-8?B?SEp2N0xBRDRlWCtaSkkySmF4aWdPa3QwUjYxL1JpU2VjZnc5cHZBblZxRzJS?=
 =?utf-8?B?VVJNeWo1TEQvQ2dzbVQ4eFBNcGlONmlZb3MvU1BHcCt2Yk5sYUxLZGtVTW1U?=
 =?utf-8?B?eGdxUy9uTE1qZTVuU2lmelJOTEJOMUQ3di83RmEwek81NXN3VE9IdUJPTnV4?=
 =?utf-8?B?bmVTM0tTcjNzaWViOE9iN09tVE5YTUJqaDZpYU1xeVlDTnlQTDF5eW0xTFNz?=
 =?utf-8?B?MFdoSWlUNUlubTlZQ3J6bE16VFJGTUNDMmF6dCsxT3l6L21TL1U5aTZzWGls?=
 =?utf-8?B?d0FHcHFxcFM3L1dGbWNld0NCVTljNW9mVUJGc3hwVGVUeU9VN1BidVUzdHFT?=
 =?utf-8?B?SWN6VUpBdWhQbkhmWXJZQ3lFUE9VZHl5NHBjZHkwWWQzWGVLQzVqRWp6NEx0?=
 =?utf-8?B?NVlsNGZzU2lBY0JVUmNvVnBLbXhHbDE2M29ESWxuY1JQbnRFczdvMStPQ29s?=
 =?utf-8?B?U2I0ME9RM3M1ZVZEUUFNQ0ZvRnJiYmxudFFlTjQvWTB4N1JkTkJqZHlzZDcz?=
 =?utf-8?B?Sjl1NzhWc05Nd3ZJS09vdEtqNjBFbjJZVXBPeHpQZEIrU094b2NKQXF1S0VU?=
 =?utf-8?B?NFZkQktxRDFPRFh4RWJVMlVmczkxeTRPN09mNUhvSmpJRjE4Q28ySkFLSXh1?=
 =?utf-8?B?eTNPQllJd3NSMWowN2tmQVBVNXVGQzZqSlV6ZmRuZ1YzaHg0SWk5VDhSN1lN?=
 =?utf-8?B?aXQ1V2lFNVFvYm9lekd1amUxNlRUUDh1eWVzZ0JZVUxiTDZRMjMraUJHTTVL?=
 =?utf-8?B?a2FPdGZFMTdMNTlFOXE1VVE2Y1FlaGdTNXUwWUMxaUdSUEF3SUxmSUcvNDd6?=
 =?utf-8?B?L0dvUjlKdFNJemVJbnFsNTNhakhDUUZsbHY2OWZOYVIwdmgwY0hjc1gvNGs5?=
 =?utf-8?B?U3VlNHlyV0hRcUpYWUd4ZFYrT0lDWEhjYkVvSEFpTVBORUs0OHk1WDJpRXpU?=
 =?utf-8?B?ZUVEcnUyTjY2WTUwWUF6dmxycmkybDYremRzMEdFT3EyR09wRDIrczg3VkQ3?=
 =?utf-8?B?M1ZuS0ltTTNPV01TelVVQkQvRFpHanplOUdJaVBVZXlZY09mN2tBL0Vwd1pt?=
 =?utf-8?B?K3AzVnJUd0E0blk2S1BLenZMS3dndFprNk94TEpRRmlmOHZqTzdFdmZNaS9W?=
 =?utf-8?B?eXh0MTIrczgxQ3pDSHBYZE16a3MxUVVmUjdqRTFxUHZIaDJZNlV4TFErNzh2?=
 =?utf-8?B?TGMxVWkxTGpnc2lvZWJRZVAxR0h1aG04Um9IZmhIR01pM0hGWjdYV3Y4Z0gz?=
 =?utf-8?B?UFB6MFY4Z2xIcVplNTEzNStvQ0Y1MWMrQzlobVpVencwSysrcEIxaTZuZkwx?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C8BAA969665F84B9D8AE9C15623FAFD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bsX/8dhMAOhYhfMtB1fedSRpTHZdWIsDNAhTgTV9IUkZx6eXm65ghlvXtQbcL4f4zP/Iny0kZD4h7yiUW+lL1MQe+jmyOSYPT4MBbeBJQdNE6XGGMmNVJBUDQJT9Tdzuftar5fzVD6hG+LMLAOkGs+qlqtgOGhKk6sng6dPGIkwbm9+D3sb950UodZcm7KFr2Xn/AHGSJg3UdM1RV9TKX9UyDhqnyT548c9n8w1xpes4UhoEaqAkJdPT8AjJlrs2S8RtjsH7Hv1/qawVHMqd27Tf1qiW/+yY6vSJhKLQOczLYu6j4H2oI00HlRP8+je3IXImzuUTIhBbrXu0KYR5CTSQYNPG7dc2O3bgSqfhC2/TqyXkT/ABY7kGp4NGPw9407DbsK+hoGCsHaa1TUoENIntVtvj9v3VspHDj/Oh+kkGMMNnVxj5NYvqvX7lpbItF1FowD4qOFWeZKpuLRrPkpw9HuxnOTwEX/ONMhSkYUkEK8RUIPs/weH4IMcgTEJRZmM2V8Oj1b28JEXxG5HnUmp4LhLYD3c3hGa/FSrOXKB5hTBK6y8/VkYmAVzGOuGcM3S+hvOYvJDO9Ahj+gH7KCw47BuP/mwBZGReim6TVk8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5488e01a-59e0-4197-5d1d-08dcc833aaca
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 14:05:41.3632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D6/GsFSjE/X9xCmSwDMBrhW+NJcIWuToxAaE1Q3CEjHDA52FtXlPu70uOOSpI7SoR43FU2W1FG9vsIHKlSS64A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6004
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290097
X-Proofpoint-ORIG-GUID: LD7krfJOF6iChzdCfrdlUe2LyhYD9WIp
X-Proofpoint-GUID: LD7krfJOF6iChzdCfrdlUe2LyhYD9WIp

DQoNCj4gT24gQXVnIDI4LCAyMDI0LCBhdCA2OjQ54oCvUE0sIE9sZ2EgS29ybmlldnNrYWlhIDxh
Z2xvQHVtaWNoLmVkdT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIEF1ZyAyOCwgMjAyNCBhdCAxOjQw
4oCvUE0gPGNlbEBrZXJuZWwub3JnPiB3cm90ZToNCj4+IA0KPj4gRnJvbTogQ2h1Y2sgTGV2ZXIg
PGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+PiANCj4+IE5GU0QgcmVtb3ZlcyBDT1BZIGNhbGxi
YWNrIHN0YXRlaWRzIGFmdGVyIG9uY2UgbGVhc2UgcGVyaW9kLiBUaGlzDQo+PiBwcmFjdGljZSBr
ZWVwcyB0aGUgbGlzdCBvZiBjYWxsYmFjayBzdGF0ZWlkcyBsaW1pdGVkIHRvIHByZXZlbnQgYQ0K
Pj4gRG9TIHBvc3NpYmlsaXR5LCBidXQgZG9lc24ndCBjb21wbHkgd2l0aCB0aGUgc3Bpcml0IG9m
IFJGQyA3ODYyDQo+PiBTZWN0aW9uIDQuOCwgd2hpY2ggc2F5czoNCj4+IA0KPj4+IEEgY29weSBv
ZmZsb2FkIHN0YXRlaWQgd2lsbCBiZSB2YWxpZCB1bnRpbCBlaXRoZXIgKEEpIHRoZSBjbGllbnQg
b3INCj4+PiBzZXJ2ZXIgcmVzdGFydHMgb3IgKEIpIHRoZSBjbGllbnQgcmV0dXJucyB0aGUgcmVz
b3VyY2UgYnkgaXNzdWluZyBhbg0KPj4+IE9GRkxPQURfQ0FOQ0VMIG9wZXJhdGlvbiBvciB0aGUg
Y2xpZW50IHJlcGxpZXMgdG8gYSBDQl9PRkZMT0FEDQo+Pj4gb3BlcmF0aW9uLg0KPj4gDQo+PiBO
b3RlIHRoZXJlIGFyZSBubyBCQ1AgMTQgY29tcGxpYW5jZSBrZXl3b3JkcyBpbiB0aGlzIHRleHQs
IHNvIE5GU0QNCj4+IGlzIGZyZWUgdG8gaWdub3JlIHRoaXMgc3RhdGVpZCBsaWZldGltZSBndWlk
ZWxpbmUgd2l0aG91dCBiZWNvbWluZw0KPj4gbm9uLWNvbXBsaWFudC4NCj4+IA0KPj4gTmV2ZXJ0
aGVsZXNzLCB0aGlzIGJlaGF2aW9yIHZhcmlhbmNlIHNob3VsZCBiZSBleHBsaWNpdGx5IGRvY3Vt
ZW50ZWQNCj4+IGluIHRoZSBjb2RlLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHVjayBMZXZl
ciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4+IC0tLQ0KPj4gZnMvbmZzZC9uZnM0c3RhdGUu
YyB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPj4gMSBmaWxlIGNo
YW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBkaWZmIC0t
Z2l0IGEvZnMvbmZzZC9uZnM0c3RhdGUuYyBiL2ZzL25mc2QvbmZzNHN0YXRlLmMNCj4+IGluZGV4
IGFhZWJjNjBjYzc3Yy4uNDM3Yjk0YmViMTE1IDEwMDY0NA0KPj4gLS0tIGEvZnMvbmZzZC9uZnM0
c3RhdGUuYw0KPj4gKysrIGIvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPj4gQEAgLTYzMjQsNiArNjMy
NCwyOSBAQCBzdGF0aWMgdm9pZCBuZnNkNF9zc2NfZXhwaXJlX3Vtb3VudChzdHJ1Y3QgbmZzZF9u
ZXQgKm5uKQ0KPj4gfQ0KPj4gI2VuZGlmDQo+PiANCj4+ICsvKg0KPj4gKyAqIFJGQyA3ODYyIFNl
Y3Rpb24gNC44IHNheXMgdGhhdCwgaWYgdGhlIGNsaWVudCBoYXNuJ3QgcmVwbGllZCB0byBhDQo+
PiArICogQ0JfT0ZGTE9BRCwgdGhhdCBDT1BZIGNhbGxiYWNrIHN0YXRlaWQgd2lsbCBsaXZlIHVu
dGlsIHRoZSBjbGllbnQgb3INCj4+ICsgKiBzZXJ2ZXIgcmVzdGFydHMuIFRvIHByZXZlbnQgYSBE
b1MgcmVzdWx0aW5nIGZyb20gYSBwaWxlIG9mIHRoZXNlDQo+PiArICogc3RhdGVpZHMgYWNjcnVp
bmcgb3ZlciB0aW1lLCBORlNEIHB1cmdlcyB0aGVtIGFmdGVyIG9uZSBsZWFzZSBwZXJpb2QuDQo+
PiArICovDQo+IA0KPiBJIGRvbid0IGJlbGlldmUgdGhpcyBpcyBjb3JyZWN0IGRvY3VtZW50YXRp
b24gZm9yIHRoaXMgcGllY2Ugb2YgY29kZS4NCj4gVGhlcmUgYXJlIHR3byBraW5kcyBvZiBzdGF0
ZWlkcyBpbiB0aGUgY29weSBvZmZsb2FkIHdvcmxkOiBvbmUgaXMNCj4gaXNzdWVkIGJ5IHRoZSBz
b3VyY2Ugc2VydmVyICJjbnJfc3RhdGVpZCIgaW4gdGhlIHJlc3BvbnNlIG9mIHRoZQ0KPiBDT1BZ
X05PVElGWSAgYW5kIGdpdmVuIHRvIGJlIGNsaWVudCAodG8gYmUgZ2l2ZW4gdG8gdGhlIGRlc3Rp
bmF0aW9uDQo+IHNlcnZlciB0byB1c2UgZm9yIHRoZSByZWFkKSAgYW5kIHRob3NlIGFyZSB0aGUg
b25lcyBrZXB0IGluIHRoZQ0KPiBrbmZzZCdzIHMyc19jcF9zdGF0ZWlkcyBsaXN0IGFuZCB0aGVu
IGNsZWFuZWQgdXAgYnkgdGhlIGxhdW5kcnkgdGhyZWFkDQo+IHdoZW4gY29weSBpc24ndCBjbGVh
bmVkIHVwIG9uIHRoZSBzb3VyY2Ugc2VydmVyLg0KDQpHb3QgaXQuDQoNClRoYXQgZGV0YWlsIHdh
cyBub3QgaW5jbHVkZWQgaW4gd2hhdCB5b3UgbWVudGlvbmVkIHRvIG1lDQpiZWZvcmUgOy0pIEVp
dGhlciBJIGNhbiBkcm9wIHRoaXMgcGF0Y2gsIG9yIHBsZWFzZSBzdWdnZXN0DQphIGNvcnJlY3Rl
ZCB0ZXh0IGFuZCBJIHdpbGwgcmVwbGFjZSB0aGUgY29tbWVudC4NCg0KDQo+IFRoZSB0ZXh0IGZy
b20gdGhlIFJGQw0KPiBxdW90ZWQgaGVyZSBpcyBmb3IgY29weSdzIGNhbGxiYWNrIHN0YXRlaWRz
Lg0KDQpJJ2xsIGxvb2sgZm9yIHNvbWV0aGluZyBtb3JlIHJlbGV2YW50LCBpZiBvbmx5IGZvciBt
eSBvd24NCmVkaWZpY2F0aW9uLg0KDQoNCj4gSW4gdGhlIGN1cnJlbnQNCj4gaW1wbGVtZW50YXRp
b24sIHdlIGRvbid0IGtlZXAgY2FsbGJhY2sgc3RhdGVpZHMgYXJvdW5kIHBhc3Qgd2hlbiB0aGUN
Cj4gYXN5bmMgY29weSBpcyBkb25lLiBJIGFncmVlIHRoYXQgbmVlZHMgdG8gYmUgY2hhbmdlZCBm
b3INCj4gT0ZGTE9BRF9TVEFUVVMgb3AgYW5kIHRoZW4gd2UgY2FuIGFkZCB0aGUgd29yZGluZyBv
ZiBob3cgbG9uZyB3ZSBhcmUNCj4ga2VlcGluZyB0aG9zZS4NCg0KWWVwLCBhcyB3ZSBkaXNjdXNz
ZWQgeWVzdGVyZGF5Lg0KDQoNCj4+ICtzdGF0aWMgdm9pZCBuZnM0X2xhdW5kZXJfY3BudGZfc3Rh
dGVsaXN0KHN0cnVjdCBuZnNkX25ldCAqbm4sDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCBsYXVuZHJ5X3RpbWUgKmx0KQ0KPj4gK3sNCj4+ICsgICAg
ICAgc3RydWN0IG5mczRfY3BudGZfc3RhdGUgKmNwczsNCj4+ICsgICAgICAgY29weV9zdGF0ZWlk
X3QgKmNwc190Ow0KPj4gKyAgICAgICBpbnQgaTsNCj4+ICsNCj4+ICsgICAgICAgc3Bpbl9sb2Nr
KCZubi0+czJzX2NwX2xvY2spOw0KPj4gKyAgICAgICBpZHJfZm9yX2VhY2hfZW50cnkoJm5uLT5z
MnNfY3Bfc3RhdGVpZHMsIGNwc190LCBpKSB7DQo+PiArICAgICAgICAgICAgICAgY3BzID0gY29u
dGFpbmVyX29mKGNwc190LCBzdHJ1Y3QgbmZzNF9jcG50Zl9zdGF0ZSwgY3Bfc3RhdGVpZCk7DQo+
PiArICAgICAgICAgICAgICAgaWYgKGNwcy0+Y3Bfc3RhdGVpZC5jc190eXBlID09IE5GUzRfQ09Q
WU5PVElGWV9TVElEICYmDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXRl
X2V4cGlyZWQobHQsIGNwcy0+Y3BudGZfdGltZSkpDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICBfZnJlZV9jcG50Zl9zdGF0ZV9sb2NrZWQobm4sIGNwcyk7DQo+PiArICAgICAgIH0NCj4+ICsg
ICAgICAgc3Bpbl91bmxvY2soJm5uLT5zMnNfY3BfbG9jayk7DQo+PiArfQ0KPj4gKw0KPj4gLyog
Q2hlY2sgaWYgYW55IGxvY2sgYmVsb25naW5nIHRvIHRoaXMgbG9ja293bmVyIGhhcyBhbnkgYmxv
Y2tlcnMgKi8NCj4+IHN0YXRpYyBib29sDQo+PiBuZnM0X2xvY2tvd25lcl9oYXNfYmxvY2tlcnMo
c3RydWN0IG5mczRfbG9ja293bmVyICpsbykNCj4+IEBAIC02NDk1LDkgKzY1MTgsNiBAQCBuZnM0
X2xhdW5kcm9tYXQoc3RydWN0IG5mc2RfbmV0ICpubikNCj4+ICAgICAgICAgICAgICAgIC5jdXRv
ZmYgPSBrdGltZV9nZXRfYm9vdHRpbWVfc2Vjb25kcygpIC0gbm4tPm5mc2Q0X2xlYXNlLA0KPj4g
ICAgICAgICAgICAgICAgLm5ld190aW1lbyA9IG5uLT5uZnNkNF9sZWFzZQ0KPj4gICAgICAgIH07
DQo+PiAtICAgICAgIHN0cnVjdCBuZnM0X2NwbnRmX3N0YXRlICpjcHM7DQo+PiAtICAgICAgIGNv
cHlfc3RhdGVpZF90ICpjcHNfdDsNCj4+IC0gICAgICAgaW50IGk7DQo+PiANCj4+ICAgICAgICBp
ZiAoY2xpZW50c19zdGlsbF9yZWNsYWltaW5nKG5uKSkgew0KPj4gICAgICAgICAgICAgICAgbHQu
bmV3X3RpbWVvID0gMDsNCj4+IEBAIC02NTA1LDE0ICs2NTI1LDggQEAgbmZzNF9sYXVuZHJvbWF0
KHN0cnVjdCBuZnNkX25ldCAqbm4pDQo+PiAgICAgICAgfQ0KPj4gICAgICAgIG5mc2Q0X2VuZF9n
cmFjZShubik7DQo+PiANCj4+IC0gICAgICAgc3Bpbl9sb2NrKCZubi0+czJzX2NwX2xvY2spOw0K
Pj4gLSAgICAgICBpZHJfZm9yX2VhY2hfZW50cnkoJm5uLT5zMnNfY3Bfc3RhdGVpZHMsIGNwc190
LCBpKSB7DQo+PiAtICAgICAgICAgICAgICAgY3BzID0gY29udGFpbmVyX29mKGNwc190LCBzdHJ1
Y3QgbmZzNF9jcG50Zl9zdGF0ZSwgY3Bfc3RhdGVpZCk7DQo+PiAtICAgICAgICAgICAgICAgaWYg
KGNwcy0+Y3Bfc3RhdGVpZC5jc190eXBlID09IE5GUzRfQ09QWU5PVElGWV9TVElEICYmDQo+PiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXRlX2V4cGlyZWQoJmx0LCBjcHMtPmNw
bnRmX3RpbWUpKQ0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgX2ZyZWVfY3BudGZfc3RhdGVf
bG9ja2VkKG5uLCBjcHMpOw0KPj4gLSAgICAgICB9DQo+PiAtICAgICAgIHNwaW5fdW5sb2NrKCZu
bi0+czJzX2NwX2xvY2spOw0KPj4gKyAgICAgICBuZnM0X2xhdW5kZXJfY3BudGZfc3RhdGVsaXN0
KG5uLCAmbHQpOw0KPj4gKw0KPj4gICAgICAgIG5mczRfZ2V0X2NsaWVudF9yZWFwbGlzdChubiwg
JnJlYXBsaXN0LCAmbHQpOw0KPj4gICAgICAgIG5mczRfcHJvY2Vzc19jbGllbnRfcmVhcGxpc3Qo
JnJlYXBsaXN0KTsNCj4+IA0KPj4gLS0NCj4+IDIuNDYuMA0KDQoNCi0tDQpDaHVjayBMZXZlcg0K
DQoNCg==

