Return-Path: <linux-nfs+bounces-10062-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC25DA3310F
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 21:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42DA2188B760
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 20:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38C01FF5EF;
	Wed, 12 Feb 2025 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RoCFC9rV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DaYMRns2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37A81EEA4A
	for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2025 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739393589; cv=fail; b=qEDRwGWot/RwqOXlgMgJMqTKBAZb1N5a1XyMd9upaWhHGe2x1afccp7cAY870P9NzNRW2Cg97ZyAA1e5HdyK6eBqsnFDszr2Ok0ky15tdgZe8x4jF2tcxLTKaSPoPpPdrucuLDKzQrbz3eS1GOCj/FP4Y0VIVVkcQvGzvPdy9Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739393589; c=relaxed/simple;
	bh=Jp+btdCjKnBTyRA2DZgQ1eKEgfD2bCHsK7a+KLNyBt8=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mvbbmukvxKP8G+kAVch0ozNOnHDunAoaXFYPRb2Vxiklnl+LbS0oqVaEbaAkRhgtQ5JqruY3CB8HCmRyb+hzq2QSCWX5Ii2BlQER1ocOgBLI3CvNzugaML0nFql5cTb+CADgmfkhsfgGtqg4D7xqThg4azNV3ZzqAvyeSJ8guWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RoCFC9rV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DaYMRns2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CEtb97003025;
	Wed, 12 Feb 2025 20:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hvB5AnDo7tYC9ztHf10jH9Hi4uOW1FWPcJ75VovqgLY=; b=
	RoCFC9rVqrcQQszqrXGW2h3AGcfiHHxdsgsH0F/z5TAauOPsN2DmFyA+iuJQQkba
	WdxDH4ahpUZ0jtS2ZQc/jm4Ri15ZLtPZ4J+YXhu1QDm86mZX7kvzJ0TtFWSWfIht
	dz1lKWh3joRqL173MRy2MhTH3beOrz3efsTaDbXQaMu7a+ezOUlPiPuGqdQoiIyI
	nPifWEqhX69Gltba0nmo/M4SlR5NCwnrzJ3+t9agLUy7h6mIsb6fXPQsJ6ketwc4
	pm7R0uL+JoMROXpeYqQZyObNebwjmaT/WUJOEBp2LAYhVhV87zkGq71QeU6eAsgB
	EmYKasbByCUdHFwZLhe8og==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2gbud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 20:53:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51CJLwn4030471;
	Wed, 12 Feb 2025 20:53:00 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44p63192vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 20:52:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJ7LVjsPZ7rBIrZvG+Etmt9Lj245/FP99U/Tkb28cfULKWrpR9LpnaFJg5vFzI3gqIsl/agkh9zJJohrFngtxtlgtZweh6n4KN80VIfmitYcexKHhdkDyU4vu1KpYEQQ8IMExAUvHw1gJnJuuaib2k06+TsnJozmf+9hSteuUFr5H9z7ENEZoYR4NTrSSH2ZF4fZTc6cijrmpYSEQZQzL4vxkSPy8hbG3l0BdoIr6alh+7h5C9HQcMD+9JqVBeN1w2sYFaJO2FcQWPjh3O2aQENSXCZH5NXkYmLTcXhBLNgPOfS5GCvHNp4CXNHD9yd1ojfmZ1RWwcprUGEYBkXrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvB5AnDo7tYC9ztHf10jH9Hi4uOW1FWPcJ75VovqgLY=;
 b=iVmx8COqnqLdcE3IBSymSZ2YOwguw1WE0Mtbwd5tu42SB5f3zXN3PgLmJe2wLbbDsbikK7YVeQNcG3HiPBQJ/78mCrn4p4QXNviC/cOeDr92m/Rsy1xkbVWpqP8qietj7U9+rbV6fMPZ9R9jaWPASNWv5OPWu8j1PZUiFILaOjzc2P33xWLV8EOa45T5a1MoL8aVf91gDlQdDmPEl76fQTdQhO7HKuoztUEMP2GEpql33BlvaJO6PbJi33VgSd/n2AlRO0m5PCk/t2u7wOFmQ3gE2N239A1Hhgmj5YMBPDUCJ2RGvDavnpcuhLVx+WpKxznwL/ndXxPelKCzJ5FH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvB5AnDo7tYC9ztHf10jH9Hi4uOW1FWPcJ75VovqgLY=;
 b=DaYMRns2zN1QBUgVqpkac04rE7x1Oaa1kofwaQBxty73l4vJq3tSEivl+Tbnz/f8sj95hkI1ZK7lmvpJGT5rE2arwnv2GrRmnur+S6YNRniv0Q58vuf6tIthrJ9YTa9DoZ+saOUIW5Yq8LKtkF3pXEGm82uTsQTn0HCFm9+J9zI=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by SA3PR10MB6997.namprd10.prod.outlook.com (2603:10b6:806:31a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 20:52:57 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%5]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 20:52:57 +0000
Message-ID: <0b73e27f-9b1f-4840-af10-b687c90759ad@oracle.com>
Date: Wed, 12 Feb 2025 20:52:54 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Michael Moese <mmoese@suse.com>
Subject: Re: [PATCH 1/1] Allow to fallback to xdrlib if xdrlib3 not available
To: Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
References: <20250212132346.2043091-1-pvorel@suse.cz>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <20250212132346.2043091-1-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0365.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::10) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|SA3PR10MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: 848e8162-bf37-4ca2-467a-08dd4ba73aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qk1hRnZGMnN5MTdlLzRWcFVaVFJpL3NYYzgrSVJhd2VxMXhtUXZLK3p4RitN?=
 =?utf-8?B?Z3VSdzMrYlJJa3BaSysvVjJIWml5NXBlTWxJaklsdDA0MDlReHBoSVZlOFdI?=
 =?utf-8?B?L1BlYitlZkRpRkdBZ1phbnJPRUZ1bnAxZmNnOGd5Q2FGL2xZblRQYy8xN2pS?=
 =?utf-8?B?ZWd0OHBSUDZLaytZUGt4UFpyU3VvdXFERC95Qm8vR1ZiRWVwMnhWZW12bzl5?=
 =?utf-8?B?QzBLODUwY3BWWGw2THl3RWRBVXdFZFN4cXFvQjB3MklRMFdjSE5UdTZyaUZW?=
 =?utf-8?B?ZEg0OEpTakllQnJrL09QT1c1MnZjcmU2QTIxZjZOY3lSb3gxQVpRK2M3Z2lD?=
 =?utf-8?B?YjhaY3ZSY0JjL1VteVRhSUt4b2U1VzlpSVdtbXk5bXFMa1IxM0Zyc3VpMVp5?=
 =?utf-8?B?TGs0eWNHdko1TklqWnl0MlRRVHQ3NHJHeFQ1eVZPNGJZSmxqTGJyQjMvNjRh?=
 =?utf-8?B?RGtrWHpBSlhTdHFjUG5IUkduNUp6cTU5d29kUlZkN1RMcEp6L0ZnTyt3Qkc1?=
 =?utf-8?B?aXAxR0M4ZHpCM0dqVXl3bUpSdnFuZ2lRdHI0bzZYMkxCcFZqemZnTmFVaGFF?=
 =?utf-8?B?R09KWDVjSWwyWkR4V0JJdGdIaFFLT3BRUDhDcXRQUklVV2NoT25mSVcyR2JP?=
 =?utf-8?B?RTg0TjM2Q01raVltN3B1U1BIZzVhYUNYbzFmS2ZyVE5zby8rVU0rNU16VHdy?=
 =?utf-8?B?bm91MGFPTTBFaHFnSUZRRHZ5YzNnTXFPejBXVm5VaWF1WW5lNnVhNU9JMW10?=
 =?utf-8?B?VmlYaVVCNEpTR3RaVk1iOEtIR1RLUEZQRjQveFhwaS9Td2pENXNzUldTOXdT?=
 =?utf-8?B?TGJhVzYyZ2w2bmJzZysxMEJvMUloR1VMQU9vbFhrcXFnYnRRTW9QKzJBK3g0?=
 =?utf-8?B?UVFZZEtCU1M4akJQZVNEYUNwZ1lsU1pBam5ocko1ZFRSQVVOUldDSnBDS2dS?=
 =?utf-8?B?d3ZrZEdzaDE5ZDRjcFgyRmlnRXp5eGh6TkQ3UlBZTUlJRzBORzlQZUJOMVlt?=
 =?utf-8?B?VEhDcFdvNFJhRStEL3JzT2liaDFucERiVE0vbUs5SUROOGFKUWRnZmM1V3h3?=
 =?utf-8?B?Tnp2Z3lHWXNXSmFIRHVCMG1ZdUhkYzhkU3J3V1VmNXF5N2xoOTMrVkpCZ1Zx?=
 =?utf-8?B?NXhtRExhRUROMXZ5L0h1Y2p0eGxqOHFPZm5RK2ZTVDRrWitwcTh0YmkrVWMy?=
 =?utf-8?B?SEZrMThCQXNOTzE5Rkk4RzFvSFk3WW0vTGFPdEZHMHRKN1g2TjBsR0dHVnAz?=
 =?utf-8?B?SGNPalpieDFJQVVpTXFraVcvVHJGQXNndGJNbWhiQUU4cUFIMUlNWXViN3c1?=
 =?utf-8?B?czVBOHRlNEFibVJHOU5wbUxDYUM5bjNldUptbG9hK2dZcUZSQlZvbktrVmFi?=
 =?utf-8?B?MnhzZVJyM3FmMVlPWmNvZXI3a3dDWFZ4NStWZHdkalB5Vy9GTjZ5MnpIWElK?=
 =?utf-8?B?NWhOTW04d25QMENvOHpOM0d4TFFtWTlSLy96SkN4WUlPMGhyVDFmZzF0eXIx?=
 =?utf-8?B?eFBySDhlcUtIQ3RYTXUyUmQxRkRWMkpQbWdNSDQ3S09NbmNVbHBaSWxYRHFC?=
 =?utf-8?B?WGMvMGlneUFHMGQyUklJbzZ5N1RGWWZmREZYL2VKOE5rT0pCd3E3V1kxMzZP?=
 =?utf-8?B?ZmFkWERENDJHVmlZWXpoOUJScnV6OFNxdXJKeGgvK09kOUc1NVB4UU5oSys3?=
 =?utf-8?B?eXBFMWlSVjVYUXpPZk15ZzhscE1WbXQ2b2dyOGZoSEJjTzN6OWUxQ1F3c0JS?=
 =?utf-8?B?UlpuaHlpQjlRWmxqZkxsampndHROVzdoMjREY1NSUyt5OFJVbGpVWkx3OENS?=
 =?utf-8?B?cFp4Z1ZOZy95VmNWYjZ2V252YWRYQk1BS05HTXh4N2hjeXNRMjdUS0pzM1hW?=
 =?utf-8?Q?RFVIP9fXKGdo3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDF3OGFGVFRqNkZkOGxKd3E5YTYraFlwcFY2NWRvb2hpbHJBT09pdmI3c25C?=
 =?utf-8?B?UG1tV2xhb0t5blB2bDNFeXhaY1VQR3lydXZVckVUV0w4eGdicWtTNUlMTWxR?=
 =?utf-8?B?OFpFNndSOWZmajRRcWhlWVRUK3k3SHdSR1RvN05zMVhjUjEvNWc3T2YyQ1Nv?=
 =?utf-8?B?OCs3T2YvOXNwa0ltRXhHcHJsZ2UvbkJ3TlczTXpYNGNRdU1iSTdmVHRRQmVo?=
 =?utf-8?B?R3AweWZCcVV5WW5FdFl4eG9WOWhaOHpYdmhiOCttUWZkV0VDZk1yMTN6K1dL?=
 =?utf-8?B?aUk1cmpqcXZNN2U3NDd0U0RzUHFGYmhxVnlLYUYyaWRFb0NqeUhPRUN3eVJD?=
 =?utf-8?B?LzFtcTlUWW5qcWdWV2hvMEp5OFQ4NnZyZ1VNWnRiWVo5MndUNjFHSGlYTkox?=
 =?utf-8?B?eWpDMUlKK2NjK1JUYlE5MFhOMklZTTFYRk1mOGxlb0Fpc2EweWo5a1RWQ3FL?=
 =?utf-8?B?TkRocC9WYUtFb0Y5bWtVWmFHeDhOcm9iR0FheVh5OFk1eEZiOFp5cjdKNTZh?=
 =?utf-8?B?N1VuMWx2Vmp6ZnJlVlRpM2c1N0pkOU1QbmhoRmtNNDZnMWU4L1dRVkhEa1pm?=
 =?utf-8?B?djhKbnFka2RzTEJDcDVQczAyclBpWmFUY1VhS3RQYWRaNFpCKzA3bjhlbmxw?=
 =?utf-8?B?d1NZVzRtOGRxcUFYUDhLd2xUbU1ha3dMSnVPbFdGWWs5S2M5eURCWlU5T0NB?=
 =?utf-8?B?aUl6NldWOS9xajNURWQ5Q1dtb0FSTEY4MlFNZDZWZnNhVDNwWFpwWHphWXBU?=
 =?utf-8?B?NStzMWxQRkxGcUlBUWw2UERwdGFzUTFweEh5anFadHozUnhiOVhZUnZaUEJZ?=
 =?utf-8?B?cXJNdk9uOVNIL2dUUCtDZlcybWdFVVc3b3dJdkhNTTVLWTI1ZUxCQWdYSFVQ?=
 =?utf-8?B?NjdITWdlMWpPUU9LaElNcUlFL2V2NktNT3Z0Zy9sYmFtL0t5YkFLY0pzNlUz?=
 =?utf-8?B?eVk1YnNRU21BbkdBeERlV2tPWm01NitQM1pYQlRibnlUTERVTm1memVCRTBP?=
 =?utf-8?B?Q1JoVTgxRmxnakoyb0VoM3cyZzRZcCtRRGxpRTVCc1dIL29FQ2hhUWhQd3BH?=
 =?utf-8?B?RHBhTnB5WFRzZ0xqMDIxdVVGVDA2VEZyeFZzQy9SdmJ5REFGMjdQTWducU1r?=
 =?utf-8?B?Q3l4QkZYYk5VOHNUMVo1MHJUOVZ3MlI4akloc1NZZlpnT1lieVBRNDVUazgy?=
 =?utf-8?B?ZkdnZDRuamh1ZEJOZVo2bTAxR3h2YmpKSmRHZ1dnSlBaWWpGNTd1bmViRXds?=
 =?utf-8?B?bW9qdGhlclZ5aUZ0azRRVzRmMjZjR2puWmFsQ1YwK1c5OTREQVZNSTYrekpp?=
 =?utf-8?B?cE9WQU9rK0pzU09NTGhJUDAybXRDaHNiTXBGRDhGZzZKbm9aUnhPYlVxaDJ4?=
 =?utf-8?B?d1F4bmlRaVpQdGZlelNWYXVhZWd1UGE0TUUzWGhYY3lDNzAxRktRRGhVRks1?=
 =?utf-8?B?VjlqUjk5b2pNS0dGVVlPV3dpWC9IRGY4Rlh1SWNxL2htZGdBeGNBR2haVG1N?=
 =?utf-8?B?bUdYSlF6V2pOZkp5Uy9OeGJHUzFTYWdHV2xaTnBiRGdsZjlBM1cwVVFkL3dI?=
 =?utf-8?B?dlhDWEE1aFh1MjA2QUlnQ3lXUENReHk3SG13RXE0QnJvVUhtL2g3aW9Gd2V4?=
 =?utf-8?B?NmJCeExHYzJIelpqN0FyMDdSTHVyTHB1bWhGRzVTanh0cHBveEsrT2huVHp4?=
 =?utf-8?B?NUhVS2l1NyttRjI0d0wrSksxTTFqWC96V0dZcnVqY3VKRUxrZkhrZGZGTUdJ?=
 =?utf-8?B?c3cxSEY1c2ZYQjUrNTdXQTdleEo1eHNDSyswc2RNQ0JwMURrSnVmMHU0Mzhm?=
 =?utf-8?B?WUg0dmJpWjJSZ21za2JiVzNjMmQ4WHY1djMrNUlqUDdLOE43L2IvcWNobFZV?=
 =?utf-8?B?NjBPaC9ab3NUME9Mb1lKem5Ka2MxVGUxTXFzSlV2SUUvYXRNTzJDUktCSE9F?=
 =?utf-8?B?cVBSeDB1ZThra2NlVXp2UjhyZXFGeEVnYmRDNElvSlZReEVwMjl5ckJGV3p6?=
 =?utf-8?B?blRDbGllZkcrNmhWZ0ozNFEzd2pSNWkwVm1EeVU1cEZvNUxzVTdIMDhvcHUv?=
 =?utf-8?B?ZkJPaVdkaW9WT2FmOE81UGFnOWN0MEdlUVJ4NXJ5dm82c1Ntb055YzlPV2lY?=
 =?utf-8?B?RWlUb1BBTStNNTQ5RHRXK1FIL2d5QmFCSEpiT0Rnb3dXOE9KNnVFY1NUMnl3?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HDMml/9OZly6DAX5JXy6sppv0zjdiaMWY8OrXTlPzkzMQlR/jlsymazJNCim976jGoaWnW/kdDxoD+Xl5oVCexBtjGZ3xn/rE14o5KnjdRUTj6Cd6FtqsURArRUmpJfQLQIxG6tKKiOWNohkKzMDYaZ59H+dAO2tvyGUjmbd2LNSDdKq6pX5FOwkZHTzA9UStflCEna2NxYcdaHLDvCtJXVdBaQq5oKiVtbRS5WARYh+N029Tk48pWwCUyGHD1wE2ZyEpXlmFHK357ortO1hN1H/6r/7vUVyr9yjevWszDm3t5FbPqB3LLtvKJ4Y4ka9bR2gCqJt5NYDzYAOl8lVd8hJQBROTg0BA36yct4ljyXYMchiMoIyXzioaf2A/yW2I8aOgrdOx4YdFQGzOTkwOyNuIdvvxg3EN6C98+kBJMShfpyq2LXa0q83qCVGSTqb22by1/TN7tcMwKaJXnOLk6OsRVkmesjfEVDoe2b26FZzToSJt2S9ztmjRRe3Zwmj3eesdnQRqucWAu4Dri9Xlp84GqdgSnNPRkEZFczXnagesaDopKIXg9XrZxiKujiGc/IXihLfRySyLeaV5oZiK9PYlGEM9LcscxmCmw0LAwY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 848e8162-bf37-4ca2-467a-08dd4ba73aa5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 20:52:57.4513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0igYcEL5xeN5Xto1CtKrvCx8ZCC+dquOn+54QZMq/5BklQbatbcI64ntwIeJorEhTRTUlr/hY20V9RAv/SK7vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_06,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502120148
X-Proofpoint-GUID: MnH3PnFLGD8V6t-o_0E4QCuqyO16xpCZ
X-Proofpoint-ORIG-GUID: MnH3PnFLGD8V6t-o_0E4QCuqyO16xpCZ

On 12/02/2025 1:23 pm, Petr Vorel wrote:
> On certain environments it might be difficult to install xdrlib3 via pip
> (e.g. python 3.11, which is a default on current Tumbleweed).
> 
> Fixes: dfb0b07 ("Move to xdrlib3")
> Suggested-by: Michael Moese <mmoese@suse.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
> 
> I admit it would be safer to check if python is really < 3.13.
> 
> Kind regards,
> Petr
> 
>   README                                | 2 ++
>   nfs4.0/lib/rpc/rpc.py                 | 6 +++++-
>   nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py | 7 ++++++-
>   nfs4.0/nfs4lib.py                     | 6 +++++-
>   nfs4.0/nfs4server.py                  | 6 +++++-
>   rpc/security.py                       | 6 +++++-
>   xdr/xdrgen.py                         | 9 +++++++--
>   7 files changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/README b/README
> index 8c3ac27..d5214b4 100644
> --- a/README
> +++ b/README
> @@ -19,6 +19,8 @@ python3-standard-xdrlib) or you may install it via pip:
>   
>   	pip install xdrlib3
>   
> +If xdrlib3 is not available fallback to old xdrlib (useful for python < 3.13).

It sounds a little like the above is an instruction for the user; if you 
don't mind I'll fix this up, adding "the code will fallback…", just to 
make it obvious?

Thanks for the fix Petr, I'll get this in today.

cheers,
c.



> +
>   You can prepare both versions for use with
>   
>   	./setup.py build
> diff --git a/nfs4.0/lib/rpc/rpc.py b/nfs4.0/lib/rpc/rpc.py
> index 4751790..7a80241 100644
> --- a/nfs4.0/lib/rpc/rpc.py
> +++ b/nfs4.0/lib/rpc/rpc.py
> @@ -9,12 +9,16 @@
>   
>   from __future__ import absolute_import
>   import struct
> -import xdrlib3 as xdrlib
>   import socket
>   import select
>   import threading
>   import errno
>   
> +try:
> +    import xdrlib3 as xdrlib
> +except:
> +    import xdrlib
> +
>   from rpc.rpc_const import *
>   from rpc.rpc_type import *
>   import rpc.rpc_pack as rpc_pack
> diff --git a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
> index 2581a1e..41c6d54 100644
> --- a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
> +++ b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
> @@ -1,7 +1,12 @@
>   from .base import SecFlavor, SecError
>   from rpc.rpc_const import AUTH_SYS
>   from rpc.rpc_type import opaque_auth
> -from xdrlib3 import Packer, Error
> +import struct
> +
> +try:
> +    from xdrlib3 import Packer, Error
> +except:
> +    from xdrlib import Packer, Error
>   
>   class SecAuthSys(SecFlavor):
>       # XXX need better defaults
> diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
> index 2337d8c..92b3c11 100644
> --- a/nfs4.0/nfs4lib.py
> +++ b/nfs4.0/nfs4lib.py
> @@ -41,9 +41,13 @@ import xdrdef.nfs4_const as nfs4_const
>   from  xdrdef.nfs4_const import *
>   import xdrdef.nfs4_type as nfs4_type
>   from xdrdef.nfs4_type import *
> -from xdrlib3 import Error as XDRError
>   import xdrdef.nfs4_pack as nfs4_pack
>   
> +try:
> +    from xdrlib3 import Error as XDRError
> +except:
> +    from xdrlib import Error as XDRError
> +
>   import nfs_ops
>   op4 = nfs_ops.NFS4ops()
>   
> diff --git a/nfs4.0/nfs4server.py b/nfs4.0/nfs4server.py
> index 10bf28e..e26cecd 100755
> --- a/nfs4.0/nfs4server.py
> +++ b/nfs4.0/nfs4server.py
> @@ -34,7 +34,11 @@ import time, StringIO, random, traceback, codecs
>   import StringIO
>   import nfs4state
>   from nfs4state import NFS4Error, printverf
> -from xdrlib3 import Error as XDRError
> +
> +try:
> +    from xdrlib3 import Error as XDRError
> +except:
> +    from xdrlib import Error as XDRError
>   
>   unacceptable_names = [ "", ".", ".." ]
>   unacceptable_characters = [ "/", "~", "#", ]
> diff --git a/rpc/security.py b/rpc/security.py
> index 789280c..79e746b 100644
> --- a/rpc/security.py
> +++ b/rpc/security.py
> @@ -3,7 +3,6 @@ from .rpc_const import AUTH_NONE, AUTH_SYS, RPCSEC_GSS, SUCCESS, CALL, \
>   from .rpc_type import opaque_auth, authsys_parms
>   from .rpc_pack import RPCPacker, RPCUnpacker
>   from .gss_pack import GSSPacker, GSSUnpacker
> -from xdrlib3 import Packer, Unpacker
>   from . import rpclib
>   from .gss_const import *
>   from . import gss_type
> @@ -17,6 +16,11 @@ except ImportError:
>   import threading
>   import logging
>   
> +try:
> +    from xdrlib3 import Packer, Unpacker
> +except:
> +    from xdrlib import Packer, Unpacker
> +
>   log_gss = logging.getLogger("rpc.sec.gss")
>   log_gss.setLevel(logging.INFO)
>   
> diff --git a/xdr/xdrgen.py b/xdr/xdrgen.py
> index f802ba8..970ae9d 100755
> --- a/xdr/xdrgen.py
> +++ b/xdr/xdrgen.py
> @@ -1357,8 +1357,13 @@ pack_header = """\
>   import sys,os
>   from . import %s as const
>   from . import %s as types
> -import xdrlib3 as xdrlib
> -from xdrlib3 import Error as XDRError
> +
> +try:
> +    import xdrlib3 as xdrlib
> +    from xdrlib3 import Error as XDRError
> +except:
> +    import xdrlib as xdrlib
> +    from xdrlib import Error as XDRError
>   
>   class nullclass(object):
>       pass



