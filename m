Return-Path: <linux-nfs+bounces-16360-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA0AC59957
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 19:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC5F3B40B4
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 18:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7F73101C5;
	Thu, 13 Nov 2025 18:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ktdPx7PI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qig9YQqd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6579C314D16;
	Thu, 13 Nov 2025 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060269; cv=fail; b=QZI8LC2FHK4GKTIV7SseWVsdRjBW9yWSmkpMfa/vfpEY5+Q+trxu2rvlAyZpkq0pGIRip+mRdxRnmm3KvBZeJ6VEMyzBt8ZHq5uiRz2W1Vfoim4h6pFwedX9fksBiwm6PRJ9SSw6BUGEnGID8/hNa3UJ5IIxh0Wmc1t2XCNuOic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060269; c=relaxed/simple;
	bh=XXLqeNBvPfVczjWfw5n1N1uJkqXBZYySddwNTV2T254=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dg6Ys/4ucEPUDImUNX+lwgb3ETCNwu0BWYgkexb3UsFCnSXMQJx01vbIOeckBTTO8YS4FklCdHsN1xRI3RxiWd0dqm9zi3LUaAqw4G8e0HFr6gIA00Bry5PnKt5spS+TJPN17HdXFI8M2XozEbzS4Sx/7seEJZYlGXEvul6L8vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ktdPx7PI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qig9YQqd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9uEZ015549;
	Thu, 13 Nov 2025 18:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qkV2gWuVVxrPkakz4ckbQ3jv6Mgf6crEC1IdGHuN7EM=; b=
	ktdPx7PISL8k4ZV3W5DsXrIkqE4eHEL8bBjD7w1s1cwGqAe5F3/MYbCEbAoOQp0G
	i73bAk5cBwynViwZDSzki8z1BNDq5wgOgJqvrIk9gNZM7G2ROl22Bb8dBFTCpa8f
	1GQobHgWuu06d5B1pENOogrmj5b6NEUymwJCKn/k0deRwvtb9+1TUaXv/Maxkq8+
	Hj8WgCVmv/ksGt78xJ8I7GXKAigHODTJGtYkCFnWJhJyX2O/c5ieGpwHiwYnDmUJ
	vXqVQw7gDGWpjeAFRQPYTkX6JziQ4UAWCDExT5zGrP0NoYJ1hcI2ZMmNw6wNVCGE
	A4SaPJdb6aiADri7/QgPDg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acxfvjkr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 18:57:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADIsqSF027610;
	Thu, 13 Nov 2025 18:57:27 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vagkqba-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 18:57:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9jBocDurBRVr2tivCkEkI2ldEdMK8RQu8VvNk7aO6RKY5vve6ecZ2jf29CuwGWo3By+wipk20Jiv3aMGQpbHWXENJWiUibN7CGSUhqq4FON9XVVzec7edvtKJNOXgf9c6A+gU/H9PGUTi6jNIQ7MXepwj2Gh7SHUtSiXLYujnqpzclnMYBS2Dby1t8ISp41gU0in1ZImiEkYEtpGvWHZCnyjhhRnvaN4+mT+5vHI2k6lf/Tp9OO1Eies8G4dRKXY41Sacua6CuaHbpD1fm8OOXNGhV6XLSRg2Dptegs9HKe5HpErKIqKXv6lduZZ1qMjs1GU7Cmyo3KpD6Kdv4/Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkV2gWuVVxrPkakz4ckbQ3jv6Mgf6crEC1IdGHuN7EM=;
 b=K6Udido+DH465GWuuU6iVq9/LVQK2da2qYuj89lDLsv2MMm45qEL6uneZNP+TKlhnYASRhu5YMHBGpNULJ8jK1kTe91t2iGCMGshtb/tzyFApLwHWG+WOTDnwYdwapdf+KtXDlxxzFGkkE36q70m+QtFuipgOj70z/81RLhym7HHp9ZDOjofsMv72nk+b0NyARTP30LSZRo457h/OHFSU3h8p6g9WooGIbCKmB7wPW03b/VOyqRDqolsAAY0H4Ec6Ti/H8mRFILF8X3PZCwqwPP00KpZ3hP17QaFTewXmF5H22csjOya6tqfDP+sUgRERTiUcxGNj+MLuU+YVbt4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkV2gWuVVxrPkakz4ckbQ3jv6Mgf6crEC1IdGHuN7EM=;
 b=Qig9YQqd/qzZZ/haozuKPr5y9RLT1QACvYcUkmDAVzP27VX4cWJpkBSu/94bgMT4RJkv0bfKPdaLd9ZAKhbcyGyh5hiUwQFH7yw+lfJHEbwgxVkH15krhgYhQQrlzD4N/DrnUDPfnF4/ybiyS1XqOZhge15NbO/HIlanLao4ork=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5751.namprd10.prod.outlook.com (2603:10b6:303:18f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 18:57:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Thu, 13 Nov 2025
 18:57:22 +0000
Message-ID: <943d3e48-9582-4521-9cc8-eb84eb72d788@oracle.com>
Date: Thu, 13 Nov 2025 13:57:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5
 NFSv4 client using SHA2
To: "Tyler W. Ross" <TWR@tylerwross.com>
Cc: "1120598@bugs.debian.org" <1120598@bugs.debian.org>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Scott Mayhew <smayhew@redhat.com>, Steve Dickson <steved@redhat.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net>
 <aRVl8yGqTkyaWxPM@eldamar.lan>
 <8d873978-2df6-4b79-891d-f0fd78485551@oracle.com>
 <c8-cRKuS2KXjk19lBwOGLCt21IbVv7HsS-V-ihDmhQ1Uae_LHNm83T0dOKvbYqsf4AeP5T8PR_xdiKLj5-Nvec-QVTLqIC4NGuU2FA0hN5U=@tylerwross.com>
 <c7136bad-5a00-4224-a25c-0cf7e8252f4a@oracle.com>
 <N14GL1WKSGqrFl8nF0e6sa0QxOZrnrpoC7IZlZ20YqUyfsxpsoqu2W3a31H_GfQv7OEqaEWKwDXdgtAV-xv613w_slTAFZIoyWMutIE5pKk=@tylerwross.com>
 <4b77bf39-bc1a-47a1-9a16-14c44c31614f@oracle.com>
 <eUtqaTOrHO8Sj-82m04dsCpmYX8bPkr5r9Nla1muHxSnxBYq57wxk7LLf_RuI377WMpUcczBXteWGvF5OfNfe5gwLmfTn_YblJucaF58POo=@tylerwross.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <eUtqaTOrHO8Sj-82m04dsCpmYX8bPkr5r9Nla1muHxSnxBYq57wxk7LLf_RuI377WMpUcczBXteWGvF5OfNfe5gwLmfTn_YblJucaF58POo=@tylerwross.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0058.namprd13.prod.outlook.com
 (2603:10b6:610:b2::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: bbbc8f0d-5c8c-44c9-e372-08de22e67a1c
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|159843002;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?d1NUY3JNRkJLVWRlSC9nRHRmMnZ6WUw0OEpMVjRmWk5ZTkpmQ3NyTGErczVM?=
 =?utf-8?B?N3BVU0VUb2dCYytBQUdUbSt2STY2Wmp4SEpGSjlOamtZUHpDcW1LdEVKUkdM?=
 =?utf-8?B?RXRnSFIyVWZtNloxT2NZV242UEhlTHR4STlTMGZqSk1pUTF1VzhJNmRleHlG?=
 =?utf-8?B?dk5JQzFWS21yQWs0TFR5QlJiWmwyTVNwNHlhTFF3L3hwVEg4Q0xjZFUxSzY2?=
 =?utf-8?B?SXpoWk1aL1BmL0NPL2g3TzhqVGVhYWxQclJXYUZ3NUdlNW10NTJMSjZyQlRh?=
 =?utf-8?B?SWZJTGhUeXZsVERibjZPV3NDc1E4aHJQZ0lNV0pjZDlnZmNWeHN1R25kZndu?=
 =?utf-8?B?TFNCVEozK1d3UGx3K3JUTG1nQjJEbjJ4NmgrQldxWldXMDZoZzhFS3pDS2U1?=
 =?utf-8?B?TFVReU9TOU5rZk5kbmpuQXdqUGR1R0tIVGZVaHVDSUpRaTNlTDduSkdCSWd6?=
 =?utf-8?B?VDJFNnFEeXFaVFpuM2NFZWxtemdnd09PK0dkd2RERXVPbHpKRTVCZmE1OEI3?=
 =?utf-8?B?WWtHK0xUaDlvNnQxM0w4R1ZpdVZ5M3NheDByMkxETXNEQTV3WDhpQW01S2lT?=
 =?utf-8?B?OW10MmZCQWZTRXBpQ1Q4MFphcG1FZy9NYk5YSkJYdUJmbGJiSDlCVGNqcjRo?=
 =?utf-8?B?bDROcDZlL3cxWGlNVlMrQnR0czRCNE0ya2ZHMXl6ZUhrYlFFa1pCWDRETjFr?=
 =?utf-8?B?Z3grOFNxSlZEeEc0RXovVEU3enQramFuckVpdlJxcFcwUEtQZlRBbk9nb0Iw?=
 =?utf-8?B?bWtXQXJCOTZBY1BhQjJPcVlua3l5YXJSTTJVRytON3piSllhejMranBBdGRt?=
 =?utf-8?B?N1pwNWdQanhQOC9ieWcvTGp1YzMxTCtUbG1pS0dJNEZGOVFscVNibGlXTnRS?=
 =?utf-8?B?eG1yUUdqMDAxU2phRDBXeDVScUNvTTQzYnRrcGxXNGg2VUxmdzlXZ1dTcEpr?=
 =?utf-8?B?aCtnamlwTjBFNGFDWjRKTTRSK2JPV2lMdm0rMDRyKzVFQ1RDRWNueEFqSlV4?=
 =?utf-8?B?d3M1ZlQvdm8xMnQ2dExYRitKYnRMRFQ5Wkg4Vm4xZXJ5cStBemczQXBzT2V6?=
 =?utf-8?B?bTFLcmtHTmNieG9nZ0NMWDE5Q1pWam81UDBPM3Y1ZnJ5TC96aTRpSEh3b1d5?=
 =?utf-8?B?QUtCeUdDQTZUTHBpZXhITXpjZlFWeXRZQTdGWjVMaEtIUGQxcDFRTEQvY1dW?=
 =?utf-8?B?bDFCaUxKSGc4bDA2WS93NVpONXZKZWpLUVp4RUc1NmdBaXoyT3FPK2xyZHFF?=
 =?utf-8?B?bHh0VkdBbHpOVHpOd3ZZUk9QZGJ1NTd0a0Q5eU1JcWN1UFRFYUxnaiswdHdH?=
 =?utf-8?B?NGEyNkFtek0zdzlZZkdxVkNSS2hXSTVCZmhOTUJuN3J0c0Q3WjRzL0dyRzNv?=
 =?utf-8?B?U3JhK0ZmWjRMTGY3S2t6c3FSK1pnQjRhaXVCc09IVDBXYTdMRU1EOTZadkRv?=
 =?utf-8?B?cmFDeDN4T2xkbytmZUNHLzZ1eUNTMEcyY1RkMERhTnBFL3BBMmJrc2VITkpI?=
 =?utf-8?B?clhSbmF2bGVZQ25VVzZPUDVyMENrazM3czk1RmJYcUhBUjJxbmR6UUhyeEJP?=
 =?utf-8?B?UEZCOGNrNHBhdTZxZEtxZTFadExsRHN5cWM0OUdoZUxpb3RVaTNwZEdLR3Zt?=
 =?utf-8?B?ZmJhc3M5UVRCdFh5NSs3cndLVFJ0VkNQMU1tQk94MmpJZjQ3R0tRaHdDYXho?=
 =?utf-8?B?bGZtZkt0NmVOclVwZ2h3MjZPNTVWSHFra3J0OEZRZGN3NFd0emdZRWlONGFI?=
 =?utf-8?B?TjFqME9uSzFCaW5SYkNnVmpIaHJuSUNTQlRRSWt1ZTROTzM0MGZnbVRuK1Zr?=
 =?utf-8?B?QWZQemY2ME1UUzVTNmlSK3o4aURzUEs3WXBQcUJNVFJSQzJUQ24ramt1VnZR?=
 =?utf-8?B?VWkyWjBUNjc5YzQraWs2UHNuV016VHg2V1lYT0ZaVE9FK3llMklwREpWKzFF?=
 =?utf-8?B?STZ5eUdNYXFYNzdrUHBONURwY3hSc056TTRsWXRkVEIyZGJYdktEOEY5d1Ur?=
 =?utf-8?B?cTNKaDNNRENuVkR1eFBnMTgySkxOaC92YnFtcFVHZmNySXdObm9CeGtiaFo0?=
 =?utf-8?Q?mGKAAy?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(159843002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?THpFNTRuWHpyQ01tb3lzUnpFQitCN1hTay82MHRUcUtjL0lDeDRDVVlvRWZw?=
 =?utf-8?B?aFF3dWw2QjVyQzNGaG4vQnRodC82UHRUYm5VK1JIKzdBQkJtQ3F5RExQbHFB?=
 =?utf-8?B?TzRpam04WDRYblNlZkdIMEc4RHhMY2pUck55SXV2c1VycFF4WEo3UitrN1lO?=
 =?utf-8?B?L0VqSUVMMXdaRUJrOGIvLzdYb1cxMFVNVVlRaUR6a3VndmZKU00weVhWSEpo?=
 =?utf-8?B?M0duNVovbHdhZFRUMDlSTnhCQnJOd3dnZFYvUTJ1VlFmUmRHS3dYclZxclIz?=
 =?utf-8?B?Q2d5UjhmVGxadGMwSjQxZG55VDhGTXFFaXVIN3l6NWEvQldWYm5CMVNUekFk?=
 =?utf-8?B?M25uN3VKc2dBMVNRUEN1aXdmNERUTXFnZVd2N2M4bVJYWmtyUUVTaVR0NFhS?=
 =?utf-8?B?aVAwQUpZUzZQaG9TM2tKMWtGNE5hOVh1S0Q2NjZrRnhjV2lpVkJZNDgrOVdp?=
 =?utf-8?B?UUF3cldJU3hrSlpOcDhOOXd0WXFScWQ4QXBadkFZU1hEbFBkSEZqSnpMT1Bq?=
 =?utf-8?B?c0tqeklnNnhCamQ4dFI1SjVHeEpMdkJUUy9ST1RTd1JseVh4OGkvSzZiN2hL?=
 =?utf-8?B?NWRHV1pIL2dJelU2NFRqd3plakJWVE9wSUdPYkcvK1dYQ3NDTkYwc2VwbW1j?=
 =?utf-8?B?Wm9jTTZLMDFuNk5adHZCZWxwemZZVU9EZy96UG02VGhlWXdOYmVPaVJrOTF6?=
 =?utf-8?B?cktWNmI3c3dQTHdJTWdIR0pyVklVdDVKRWJXZmxTaEJQNEtjbG9nT1EyZ0po?=
 =?utf-8?B?aEdYcnl2dGVWUjJ1alp6cHJaemdQc0llSGRmZjlMWGphQzNjMm1SbmRnbE15?=
 =?utf-8?B?c3lSak9ZZUdFdEErU2d5VXdaNndSaElaZ1ZSaDR4WlAvNzl4dlhSWU82M2RF?=
 =?utf-8?B?RUo0ZUFFanFZQ0J2Y0xXa3ZYT285MHZWWFRrU1pTN1pjbTF3N0p1VjUrVW5l?=
 =?utf-8?B?NXlHeE1HOGtSdUhiUnY4L0pWdzBLVm1rN2s5V0I5S1V4RzNkRm5hWSt2b01P?=
 =?utf-8?B?RWhNbkRBZnAvMW5hVENiWTRmY1NNbDdmUXdnRDFWSVl0RDdvdTgwYjRqM1dS?=
 =?utf-8?B?cis2V0EvQ3JSczJjSFdIb01YSk9DdUV1enh6b2xpOERCL28xb2I1OEp1ejEw?=
 =?utf-8?B?MjJsbGdyN0FnaWVERlhXd0tidDNHNzhGTGE5QzRRb3Y1TmluRkNYWWJ5Ykk4?=
 =?utf-8?B?cG5Gc1dCOTVhWllzS0ZwNm9LNDlNdGkzc3o2Q1RtNGdZREZ4eHJZUDVrZkZR?=
 =?utf-8?B?NGpKMDhqNlpJK1VoWmhvSWw2QU9GRVY3eExyZGd6ZXNWdXpkUFZiZGpMcmJa?=
 =?utf-8?B?QWVhcTRyM29JWnRoMVhaK0dVN3EwSk4wa1BRVjJaL2lXbE1hczRCdzJlLzha?=
 =?utf-8?B?NmM4OTlsOTd1TDBpNE9kZHRaZ1h3MDRzbUtNdGdvOEVxUEhyeWNMb2tkK3Av?=
 =?utf-8?B?V1YrY0c5TlRYRUdoZ1pZSk51Qit3K01qUTVtL2VVdVhWK1RkbUpJRUp2bVdF?=
 =?utf-8?B?Z2tFOEx3OVRHVXFSeHlPWlFuRlVOc2tsOU15a0JwMXlzZGRvbnZ3MThvc0hp?=
 =?utf-8?B?SHoxdFRBbnBDZDVsaFpndm1DNWQ1RTdQRm1SQUVKQS9WUGludGo2bUFFWXpN?=
 =?utf-8?B?RHFhdzZQbkVvZWtIblMrWGRjeDZzRURrK3VyOG5xaXVIMSt1dEVHdW1LaWNR?=
 =?utf-8?B?MHlzOVhGNTgydTBjRWhqVmRELzdkTXpibEkwYlo4YUkyWlp1M1JKUXh1K29H?=
 =?utf-8?B?aWI4dDk2Y0hRRTBlQ2xIZ0ljWkxmSHhVeW1CRXNhbmt4dnBucVo1SktsbG1z?=
 =?utf-8?B?OE9nOW1vR2JlRWlhY21kb0FzOEZLL2I4SW1QTTlCN0pLbWRHVGh1K0tVZmJK?=
 =?utf-8?B?UnhwWkpjNVBoSmRzakx5d2dyUVBuV2Q5NHRFZ0NEZm9QYnd6WU5TWnlCb2pj?=
 =?utf-8?B?Tk56RmVrckY1dzd5aXhRMWdGa1g3MkpLSS93dEFoSWVkZkpkUTNRTjNnM1JV?=
 =?utf-8?B?aHRIaDJmeFdYbis1SUdLSldNNjdWenZjYjY0Vk0zbkNWdTF1akc1MXVYQy9o?=
 =?utf-8?B?Z1M2Qy9Cc0E5ODFNdVhxcFBsRHZBMHlBOFg1azBINXFGYmFuQzVuaXhHRWZo?=
 =?utf-8?B?dXFWbFN5eHRYUVgzKys0WEo3UmJyOVVhS1JmMWRoSENKVGJPeXJPMmxwUkpw?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qEbyqcqE7UkdzXN8HzDlNsNyGZoLAzkI1cc7U+IuOCFigl1wGP6bRoAu09L3ymVfxDZiWULSXvxSmHFQN7tGlWJ01niu2rvTh6JhDvV4D76lUDkFtx5jywW1LwmlaWOQ0rL7KHaqx/sH94WNsV6+XHhql2a71pwte1QArdqSpPT2gwzwvZtPPBtfeMjTP4RL4oZJ+n6MEQRK7g+mTgAEfOPrqwi/4CXHE1QAaTQ61SAn3iklr1E83tOLVSwVANxmU1em3WqxpFPIfzkFG71plAmCmbvL3w88hugtbX19mnNcIxBN8Iv4De4hZ4AIen4zV5gfkBygc5Sexx3W2hdVv02VoEa5z39Y5znbaHTru8TMYjlnuduGynch8VgzvoFqR79Jz3axJuwHdbpTb+r8MFpuetZ4LTYesMODto1qEEr9YklRgTabbUS1QfEYy8Pyaie1BXhKNLFVly3FiB8xkR4bJHcjJrQZL7nj28lDA93zMWZ993+VWEtXwI+cYn3B56tufIF4Fyv8y/+EiKYrjqGIPYwcCg4ss0JmSAXzTY4rnpZK0ILqeSscZALlWZH7T2cGKmtfCCPyelttcBOODUqYiUWEY0JfGBqlC1fP7MY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbc8f0d-5c8c-44c9-e372-08de22e67a1c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 18:57:22.0730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0C6tTHkQKL6nFhVzZPMRQa+E8l0P/4hLANSbQI3Xoa7tZNiE60spjecKGPs0eDyKafEp6/PmJ44eaHJkdtJWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_05,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130147
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEzOSBTYWx0ZWRfX+XokjeCSUIMB
 Lva8SvgnyTI9BMxMJGUzqRFCWgU2+BjqqMyg0fu5TFPwEcRLLGR6VttGvTHq76gyRSc/JhDrXvx
 4RFRRZ4pmXk4Xoe5M999xkLXJyif9syyUFC9NStqg14ebjyck3zGkF9xmtavos0xCwOdrrFPfi/
 lSZQgAwk3wajdyqZVCO7hQx3W5mbaQGnJJ36s2rLMkZFFH7R93U/Y1jMcX6QwKNDcYMHCIj+uVF
 U2Se83YHpb8im2rkmOcH7mzShu4NsvILSAP5Uq0BT8/+gckSVb+P+L3U8tINxYOxFkvYi+HxpVG
 kwcj7ZEFlfqjrmwp5pxP0l01+fHYBnyodoMlzAxAZGkwxRLUa+05JXdXV2WLw13UQCIvJvrho6D
 r2GN+GLI2Zp587WnbbpQ5HF6e5NXFJVqnrorfdFRzshX41joHNA=
X-Proofpoint-ORIG-GUID: 98sz3j00GRZJoIwi_iSoQtIhgM4bsC6E
X-Proofpoint-GUID: 98sz3j00GRZJoIwi_iSoQtIhgM4bsC6E
X-Authority-Analysis: v=2.4 cv=FKYWBuos c=1 sm=1 tr=0 ts=69162a19 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=0D1FuqgDwlF8c14N2voA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13643

On 11/13/25 1:51 PM, Tyler W. Ross wrote:
> On Thursday, November 13th, 2025 at 11:12 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
> 
>> Then I would start looking for differences between the Debian 13 and
>> Fedora 43 kernel code base under net/sunrpc/ .
>>
>> Alternatively, "git bisect first, ask questions later" ... :-)
> 
> This is outside my day-to-day, so I don't have a workflow for this kind of
> testing/debugging, but I'll see what I can do.
> 
> Thanks for the starting place.
> 
>> So I didn't find an indication of whether this was sec=krb5, sec=krb5i,
>> or sec=krb5p. That might narrow down where the code changed.
> 
> I confirmed the issue with all 3 krb5 sec modes, in both the 6.12 kernel
> that ships with Debian 13 and the 6.17 that currently ships with Debian
> Sid/unstable. Similarly, I confirmed NFSv4.2, 4.1 and 4.0 are impacted.
> 
>> Also, the xdr_buf might have a page boundary positioned in the middle of
>> an XDR data item. Knowing which data item is being decoded where the
>> "overflow" occurs might be helpful (I think adding pr_info() call sites
>> or trace_printk() will be adequate to gain some better observability).
> 
> No experience with kernel hacking, so I'm not confident I can locate
> meaningful places to insert those.
> 
> I'll see where some snooping and a bisect gets me. Failing that, if
> anyone has recommendations on where to add those calls, I'd appreciate
> the guidance.

xdr_inline_decode(). Easiest approach (but somewhat noisy) would be to
add a WARN_ON just after each of the trace_rpc_xdr_overflow() call
sites. The stack trace on the failing decode will be dumped into the
system journal.


-- 
Chuck Lever

