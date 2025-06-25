Return-Path: <linux-nfs+bounces-12773-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77ED9AE8C26
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 20:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A59C1892659
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 18:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DF129B8D2;
	Wed, 25 Jun 2025 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Va7TEZLt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sox408UD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F13255E23
	for <linux-nfs@vger.kernel.org>; Wed, 25 Jun 2025 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875475; cv=fail; b=FCV2Y5A9PoUXWfmYZaq9OoA8pLKbrHZFnhRTeEK0hzCJJlMoaEThb1Ta/ekTrPkVfSJPt8lgoTi1scSfIonm+uvP8SNP5pf68Xi473zVsh0SORNjEl3HCyrYnokdB5hNxdK07wWEf/82uQO1cRriYkvEY05FWXlUZ58iiawALSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875475; c=relaxed/simple;
	bh=wuXEfpYnHEApSEpq0zoFcePaVuD2danWsjzsXmRPbQY=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cf9+0hh977LdLRyeM/Okb0/i1kDW4du+H74bu1LycTsle7Z2gGUGW73pdGSicqOP8HAv9Kn9SrKJTv6kBWlHHCJOlEb5U9aLM5ulwuDHVYtsbC81MHQ3XlEmqYRQClxGCsD+3aA8puXGkNFRK5T9X9TuA6KkfhNutTsUjhtGA4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Va7TEZLt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sox408UD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PFtfLU013728;
	Wed, 25 Jun 2025 18:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OwTya52r5XxTHSCKlt/T0JZ02Ir5eJgxn3dwkphYcFM=; b=
	Va7TEZLtGkxpkz5Qt+JSDc/j8iKndbSCLQbc+rF5Z1FyQwBu4o5hHXpK4aVq5bnd
	/tBShDLX2jAj7lLcHw7CcXe94iq38lFh2wgntkUKPMKVbQCbD23G+Cicc0Cgl1R8
	sHx+b3pAVpqvKAiQNllvh+ob2qx3PDxhznofi/TMkSGmnqSGr5JGr3iM5pwV9DXn
	rq3B50AnRQVQsfj/8ayZkwUpaKAuA/ftQ+2KCWBauFUcPcKCqyBoiFBHUhPqluvl
	AXkJM7RKGdlZzsTsHD6EaNiHlJD5plTxMvIzDN1kB48zFSrXRVk7qibm9PC+H0Fk
	Hskcahcz+zRB5vsA8tai/w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt1eypm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 18:17:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55PHgPCw034501;
	Wed, 25 Jun 2025 18:17:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehprx4he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 18:17:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lp6KHlcXoGWzz+1bHw9zTkEUJZ/TMZaa8ZC8RTHTR80Y/lHxi4BXmI3+D0EVVeuRQuxSiIlZKTxdio5FZki1qstA+bYKU1k3SLJlrIAS1LE76o2uO6yqonPdvQDH7BXTPpC5Q3lpZf/TCFVBSxLVJIPHeiRwWVm//yW7G/4o5n5z4FtITcE1s/PNQu8S2sjQUBASO/66ZvUuhyqtGaxjJhkE6AYXi0TpyyI46LolBOH6z4K5cxwnYN1yd+5zkJkc0GtxloAwp8i6bRe3BXd/mHZM7Gmoq6iiwdOvUcu1o+a2HpVuFcT3QtydE+RlRP8Vxfb2uRvM1o78bx0RetHN+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwTya52r5XxTHSCKlt/T0JZ02Ir5eJgxn3dwkphYcFM=;
 b=iPRwfuLh1w3lpQeAiMzf/DpaUbkkmLTLCk3g3q/MzPbjgJMhQk4K/xRF6eNzBrg9xRCVY7vQblwk4Br2xM+oscsWVQ1NoYtKtcjaXYmFyIg1EKn+fWEVB9SyatVlLRnVmH/WGl8pqv/WtnGwpYgM9WjlXEVHNx+nAMS0a3V4YZmoJZ+5mgKEX5ikZFWe+YJT0vfv7OEkTGbfjdoz5et+MgK8pZL3UVWe7f+KvOAkV+GrLMTRG9A/70vXwwN9Pg2Pbt55rjXG/R2SKgjPNZCl5qdZUvgXkJ8nTglLkyoVyo5C5+Ocpb8hiPIzrXkvLM5jVdSt7rZtMsuY2iIiphAwyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwTya52r5XxTHSCKlt/T0JZ02Ir5eJgxn3dwkphYcFM=;
 b=sox408UDJOe7kS5+z/3W3jgTCeJwQOx/8vJ2MwzCxaSkarZDbVW/tgB+lD5BwAj2N7UbdFBjlessYja/Hr+kKhcgoJoPWcAOp5AduL8Zd174tiM5WbS3rgSO70vU3VwJMXtx3pIISLuaw9reQnlNlg1Odrj3kV55J2dS1Bb2FTo=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by PH8PR10MB6387.namprd10.prod.outlook.com (2603:10b6:510:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 25 Jun
 2025 18:17:42 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 18:17:41 +0000
Message-ID: <58c575e5-7df7-4fbd-b1a1-98ca8488d6f0@oracle.com>
Date: Wed, 25 Jun 2025 19:17:39 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] pynfs: Fix RuntimeError by increasing default
 ca_maxrequests from 8 to 16
To: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>,
        Chen Hanxiao <chenhx.fnst@fujitsu.com>
References: <20250625080208.1424-1-chenhx.fnst@fujitsu.com>
 <1248643633.14443075.1750872022054.JavaMail.zimbra@desy.de>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
Organization: Oracle
In-Reply-To: <1248643633.14443075.1750872022054.JavaMail.zimbra@desy.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0675.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::19) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|PH8PR10MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: 335eec41-073d-4ae0-2804-08ddb414931d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUNKSm9IVHQzTCtBK25Oc1h4SkNrZytZWW1WWllablUrY1M2VTBTTlBrd0Vx?=
 =?utf-8?B?YXhWV0VqVm9sdm5uNzhWVE1uc3ZIMmNVM1daZksrMXBKdFdJc3JiYjZoeXYr?=
 =?utf-8?B?NUJtbUVQK1pLaDB0WUVUNCt6SnM2eDJMb2pwdHgxTmtIQU1pdTc3cldUZ0pk?=
 =?utf-8?B?c0I2RDIwdG5CZXhsc0NRVHM5dWJ5RzAyRE1KUjl1dkV4eUNUbGphMG1yMXpH?=
 =?utf-8?B?dXc5WEtmd1NhN2FCTDFiT2l1dDA4TVdJMHlFL3lhaHozTzJVcmczY3p6eFVn?=
 =?utf-8?B?UnZUZUwzTnFkekdwelFrQ1o3TFY0SWVtSkpnc0hNYnFuME80YjJzOXlrU1My?=
 =?utf-8?B?RXVGVVd5Y1J5TElGSzBWQmhyYlZUOWxpR0IzMHBTZk9XR2hCSUtnY2tiUDc4?=
 =?utf-8?B?ZFBiYlh4UHB0ZGF3ZExmUE5yU2NReEdwMnBuL243Y3JVcWsveU1lZzljdUdv?=
 =?utf-8?B?blJSUis3QUpPU3BpcXc0NG15VjZVSnVHZUgzbkJpLzVjajNsbDJGQlpTRlpW?=
 =?utf-8?B?cFUwMDByUG1jTldTMmgyNjEwRUN6c1I0Q2hnYUVFMTEzSCtVTWc4by9KZTBH?=
 =?utf-8?B?ek5waWlQUjFwRkY3UmRhQ0xad0lpQmJIZ3BqTjIwVEk4NjIxWC9YVDBhMGdX?=
 =?utf-8?B?dE11L0hya2hUdWwrVG51UnVmZXhTNXlvSmM2RXBxc0pHOGJZdkV0NUR1dHFl?=
 =?utf-8?B?VE9WYWFKZEZYT2RENzhTNHovSWdPazVubFBJRFk1ZnJFSkRydXpWZ2JTbjYw?=
 =?utf-8?B?djJyS0syZkJuNGxaajlxR1ZSTkxuaGFENVNNTGpkenNrNE9FRmtUeE5icEFt?=
 =?utf-8?B?ZnFvaFl0YnByZHVhUHBjTDZtRG1PQWZGRzk0RFdQNnkwY1FySDV3bEpmTlVG?=
 =?utf-8?B?ZWw5T2VoNmd3d25qNlRIS1llQlAxZmMyQUZiYnVqNkh5ZEJpcy9QZ2NSeTNP?=
 =?utf-8?B?cWdHOUtzL0U3VzluQ2MzRzhnUlVLYUtTMWw1OEt3THB2Q3NzSnd6cWRBcHl0?=
 =?utf-8?B?NElBWVN2d2FmTXp6eHpaVXRmWUp4U1pUaCtxMU04cThsUHd3VGVwMGREcStL?=
 =?utf-8?B?b3Q5clVXbld4cCszR3RKcVNwNVF0ZmZrTzROVEF4Z1oveU9xTTlvYjJsTVg0?=
 =?utf-8?B?N3NBN1dzK2lmQWpnbkM0QWxFZzFoS2JPaHZ4ZzlpcUpGRlhVYXU1N2VScmVq?=
 =?utf-8?B?RWxKK0dnNzAvd0Y2c0U5U2pybkpqSTA5Z1pvaXFvNG9EOWUzMHRSVjJRMDhk?=
 =?utf-8?B?YjZ1amQvRElGWFRZNUNiRFQ5ZlJBTVZWWHpEU1lYOHlRMUlMNS9PcDJRRUVo?=
 =?utf-8?B?WERFUXNNWEZqT1dtV2NWSTFHeDB4amYycDQxUGV0YXQxTVR2U2ZCM09PQXlq?=
 =?utf-8?B?Qlp4Y0dzd0U2b01jci9Mdkp1YS9MY21ET3hQQWxIWSt6NGZhTGFVTkxVdUFJ?=
 =?utf-8?B?UWVXVWVyU0NBbWtETTJLRWY1SHNkYXdBTi9NaUp2WVZ2emkzNzE5SzdpSUN3?=
 =?utf-8?B?RmtlTVArVVNmdDlYRk9VSG5PMnFJQ0p5QUFoN1FpSUx6ZnBDNU14QTB5aVRF?=
 =?utf-8?B?dkwreHRDZEJDeS96WU5mRGdraFczZFhTQm9LdUM2MHZmOWVMUGhqcGdTZDhs?=
 =?utf-8?B?dnRidVJuYmdCYmo1K1FJUDAySzJmQ3ZxSzhreW02VWxDVDFkTnd3dVlIR2Fi?=
 =?utf-8?B?ZkFIZUpNVjZnUEs4OXZGdUlmQTl2NDNJVHpidkdpc2VXaGVJQklYcWJmRzNL?=
 =?utf-8?B?cGp6aEk3V2p0WHBydFk1c0hNMDBXMU80UWJuOVdXZmxwUGI3ME1TZmFZZVNV?=
 =?utf-8?B?cmZvWVNZKzVCZ3VMRisvUEJ0bG9mWlFYT1BZWTlqcEFDc2theW03MHgxVU9L?=
 =?utf-8?B?NThMZ3JEcC9ZS0RwOE1iMmpDRmdRZk02WmJiS1RLL1lvaDEwN1c0T2NNWjhi?=
 =?utf-8?Q?mH6lUGvGVao=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFJlVW0xUWtaVnBGcTgxZ1VMNXVpUXJCTTZWaFlIM3drZ3FMZHBxOWlxNHFk?=
 =?utf-8?B?SHdTSEZXNEdsa0UwS0crZGFwbkJYcWQ3K05iZHlhZkRkOHVtVUxFbTh5YTNy?=
 =?utf-8?B?UkpCcUlWQzB4TzkwSjFGbzVEWGtGQUwzRkROdDZla0gyVEVKK3B4RGhRekJH?=
 =?utf-8?B?bXhLM3hMWTIvSHFwL1l6M2Vrem5MM1dtOE5URkRWMGRsWm52aENyeVFLTW8y?=
 =?utf-8?B?U0krYnRBVTRtU25HYk5rYlIxSGcyTFBLNFFwYVA4TDdzRW4yYmx6aFhIckJL?=
 =?utf-8?B?dGpPemx5MmxKOGF5TDZjTWt0TVhyclJ6eUxHcW1ET2YwMHp2MXVPaXZtck5G?=
 =?utf-8?B?ai9HaVVEczNGWkY5bS9PTDRUbmZwTklqWUxLSVVtMTJLMncrS0FtbWxNcDA1?=
 =?utf-8?B?M2g5bHlTa0Q0eGx0VWp6YmRlMGpMRldGa1pLdi9xb2RYVnBtaHdxOTV4ODho?=
 =?utf-8?B?SGtnby80T3MwUVVmY0FjSFVjOHBnWkxkaVZISlVDU2R1UDAvNk9NcWdoTVdi?=
 =?utf-8?B?RGNUMmJuTUN0WGl6YnRXK2dUVXBxaWZvQ2xvZDM3QUxub0FNYnF2d0xOQWZP?=
 =?utf-8?B?aVFqNWxyRE9RdTlwRXJ5U3c0SDZZYWpWbVRxZXRZU0tvenVGNnRoRmUxUDd0?=
 =?utf-8?B?b0NtNTBnQ2JxOTh3NTdsU0daUDQ3ekE2cHl6M3hqeXEzckt5WTVKRlMyUnRH?=
 =?utf-8?B?clBRQkdVSENpMEF1N1N1a1lKTTZrSzhaeVJpb21qdG1wREtVK1R1VFRKQTZv?=
 =?utf-8?B?T291dGZ1SlJnaS9hVEkvTDJrMnorQ01qSnZBTXBIVDJxU0FZYmEvNmxwUnIx?=
 =?utf-8?B?VWYzejdtV2hkSGQ4SHNZVWhacm5BRHFLSXIzZ2dxVVA4MTIwTWhkL0xvTWZX?=
 =?utf-8?B?UFJtUUt3MmNPajBpamJzeGp0U1dsN2ZIbVpncFNJUkJhU3FZUHdFRVJ3Z0dP?=
 =?utf-8?B?eEIwenQrYTdOTjB0Z2ZFekZrSDA2WGcxdUNJeGE5N3lzR1pTOHpRVEt6MVBV?=
 =?utf-8?B?d01mZU14bVkvTUJZTk5vRWFzR1J1VmluNnU0WXZyRmJBMUVNcDh0OW9oL1Bm?=
 =?utf-8?B?NWhKakdyY2JHTXorMlk5bTlhNUdVckFwYnFXUjFNMEtNNEhtdGthd0N4KzZT?=
 =?utf-8?B?eDBSdmFGMG1GRjJOd1VVbDZmMGdXTTd1NHNFbDh4Q2lFTFlYb0xWTTh6R3Mx?=
 =?utf-8?B?OHpRZ2pTbDB2bGpBajVGZ1QzTm5Eb0cyQTVob1pGSlZEOVlrcTZzYUkzQXZU?=
 =?utf-8?B?eDhmSThIYUJzUTBOeXI3b0RMOTZCUzZXeDNudHhwZlBZNkVudHNoR3JkTmV3?=
 =?utf-8?B?c1UrN0lMUTViWlAzdEhjK1JhN0pxZ21xMGZ2dmRFNk1mazd2T29ESlhrZTBZ?=
 =?utf-8?B?aURhNlZ1bytIVnRJNHJmbjRldTl2VnVUcWVBL2VRWXZnNGt0OUg0Vkl0Qjcv?=
 =?utf-8?B?L1huakhTQnh3RXFnSkZPUHFKSDUvZEhXUUVDcldncmVEelBJck9qYWppYjdS?=
 =?utf-8?B?QzRtZ2t0WWR0MjREb2xyNDRuLzNZTGMwSmt0U1QzVG9XVmFPazRUYk1tdjh5?=
 =?utf-8?B?TndNUzVQblJSKzVKbjJ0UjAvcTZpYWwwNGlSbjNXWmtiWDFMUnNPSW5DWkxy?=
 =?utf-8?B?MkJUVExiV1IyWmJpTFVDUnJIc3FnT2hmZlJSRVZxRDh5VGRQNmtoc2FzZTV5?=
 =?utf-8?B?ZUJtNkxkRkY4Zk9sVndtdDlJTHZVMjI0SDEvWU1uRW4ySjFaTzFyMUJNa0dH?=
 =?utf-8?B?Um1yckFha0o5V3Mra1pITU9PVk1EZXBiQnpBZ0pEaFB4UmNrOCtmbWFoNGlR?=
 =?utf-8?B?Wk9wOWZuU0tXMXZOV1pxZDRhcTc2Tzg5cWxwZDZvZUlqM3FiakJDc05RaEVs?=
 =?utf-8?B?WVEzakFZSWZCVEgrdEJDVm5CUVFmc2xhMXY0aFRBM2ZqSGlqTUJqc01tREF4?=
 =?utf-8?B?UVh5MWtpUS9reXRUTmhlNWoySVg1UzdLUStDaWZVUnpjZS9RZlNBNGI0SDB2?=
 =?utf-8?B?M0NRMytqSXcrNTdweVhhSEF1WURiakRFRkp5T01aeDlRSS85elIyR1YzS1ht?=
 =?utf-8?B?Z0NRa2w0WURMZkFKbjQyNld0aFZqZmUva2lhdUJXMTlNaS9ZQjZyU2FrdUcz?=
 =?utf-8?B?Q1EreDZXajRhTlEwTlh3UXdlbjJBSk95S2V4OVB5YzBqR1NGalV3OTJhUEpt?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dOxD7uRPky4gqaFsq2Bm+Sth078pm8k+e0sxPvjTIDXmg3yVR3PR0m8qxl7nri26U2ZqsUx5f4ZP0rGBh3MTX4fxnzfWEqqNOI4EqNQwZuo1ZJd9CG97d9oBJj3gYK170bdAihH9U84g70977Z3atpiqrMS2/QOM0HpN7neVp/+nXE9PcDMAQofd9du1XBK1YpjjVjvmo2JI9mP/qeJXHeCtBlt2i9zYMndeaMCi81jaNNirPGNAuMWYfQ9Tm4MD7nXh9NuZnlLePz+4NJQgP1AHr8cE7zHEOag/VQCgJhEU72R0D0wOWCvhuAHKCpuWIhGYFV6dJ9PB6bdHhuzYFXcwFQGeN8gHnkmTRyvHTZ0rrYIkv9jK7ZladPPAnB2oyOgoLTYMnZ2sZ5KpFCKbiSOo0m3aAmlwhyHBsSBwTJlG9ROTvu3o8sqFpHnksSIf40cghNXzkfLiZ2qFQoqFO3CLb2tNk+X9XF2XnqtNaCHj5vVZOB3SIu0+gr0c4Ik1JllI+emg8QBZ4Ct8qxcdza2KZ/pJBjpdQb523UjHxYOycEtpiMGQOvZMQHAjiGp9ddF9KeiWXEYKdcXewmJ32CMEim21pFPBwBK/P4iHvco=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335eec41-073d-4ae0-2804-08ddb414931d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 18:17:41.8861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNFXrxO1GPFokCV0ysU6OyessmFGAD5cl3DPokhHtp8soVup88Uap9ROZ/iXh8vCD3UipkN7sW3zaNbh2CyLbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6387
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506250136
X-Proofpoint-GUID: UF1Om3o_LMg8Rq2yYjjOGeNp4D8S25F2
X-Proofpoint-ORIG-GUID: UF1Om3o_LMg8Rq2yYjjOGeNp4D8S25F2
X-Authority-Analysis: v=2.4 cv=cpebk04i c=1 sm=1 tr=0 ts=685c3d49 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=omOdbC7AAAAA:8 a=yPCof4ZbAAAA:8 a=o9RIX8F5uz9IY6aXIOkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDEzNyBTYWx0ZWRfX6BPrNC5l/Vnx Iuw/7Otu0cZqpC2eKbUxpIxfPcL/vcsPZttrYPMr8sdRSty9nvOwN1hHPnhIib/o53iGlpIAyo5 sgE6Z03ph2JKuK4ByaY6jpm0JWsEFXofdF5i9odx1Lq7xabXIuAiOIKos7rjSyFt3xe+We7CQwW
 nEt8z8pBfWjdW//KStUuJk1+1bPqlmzf40zX6PXGYtf5jZMnpqzU8pWjYeeFsD+oCYrBTZhlWYS AACzEIpf81IZTilJUF/DNEEI70HFm9D/bCvD/dUZEyiC0ThzVQTbLxXg5z9nCa5Z9jKSgAg0pxz pZhNG78REpD/z8fKu7QfYYsYlr0XnG4ZLtHM5P1vU9UABDBEqoP027cEAwXobQBvPTPFkyXRjg8
 AhRdu8nxMxUho0M8lliUheAoXDhCqVQD7seYS92dq8J2qlKnA/rzP6E5b4nx6GoJjYnJcuuf

Yes, apologies, I have a wee backlog of pynfs fixes to apply, which I 
shall get to later this week, or early next.

On 25/06/2025 6:20 pm, Mkrtchyan, Tigran wrote:
> 
> I had a different attempt to address that:
> 
> https://lore.kernel.org/all/20250415114814.285400-1-tigran.mkrtchyan@desy.de/\
> 
> Tigran.
> 
> ----- Original Message -----
>> From: "Chen Hanxiao" <chenhx.fnst@fujitsu.com>
>> To: "Calum Mackay" <calum.mackay@oracle.com>
>> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
>> Sent: Wednesday, 25 June, 2025 10:00:59
>> Subject: [PATCH] pynfs: Fix RuntimeError by increasing default ca_maxrequests from 8 to 16
> 
>> Increased the default value of ca_maxrequests from 8 to 16 to address a
>> RuntimeError encountered in DELEG8.
>>
>> This change resolves the issue where
>> DELEG8 st_delegation.testDelegRevocation
>> fails with a RuntimeError: "Out of slots".
>>
>> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
>> ---
>> nfs4.1/nfs4client.py | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
>> index f4fabcc..fa31b34 100644
>> --- a/nfs4.1/nfs4client.py
>> +++ b/nfs4.1/nfs4client.py
>> @@ -390,7 +390,7 @@ class ClientRecord(object):
>>                         fore_attrs=None, back_attrs=None, sec=None,
>>                         prog=None,
>>                         max_retries=1, delay_time=1):
>> -        chan_attrs = channel_attrs4(0,8192,8192,8192,128,8,[])
>> +        chan_attrs = channel_attrs4(0,8192,8192,8192,128,16,[])
>>          if fore_attrs is None:
>>              fore_attrs = chan_attrs
>>          if back_attrs is None:
>> --
>> 2.39.1



