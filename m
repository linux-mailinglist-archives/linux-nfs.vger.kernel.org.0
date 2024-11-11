Return-Path: <linux-nfs+bounces-7847-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9A59C36F0
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 04:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F89EB207A8
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 03:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40CBEEA6;
	Mon, 11 Nov 2024 03:18:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022122.outbound.protection.outlook.com [40.107.200.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38772595;
	Mon, 11 Nov 2024 03:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731295121; cv=fail; b=pks0qpP5/la81x7c13mxZCHfAHMXBmSAAXPa8+2FbuOh+/Ho6B2wc/ECiFaNGxU++HBq2GH+7I0wCDM3ol4/iEtZ21iYMnSesjWWXvRVFIqdgeJ/KMWy2OpCMRXu8mLQU0I9rLtB2XCpT2c+cp/Fjl6lldrS50G6dZJrLODo9XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731295121; c=relaxed/simple;
	bh=R5Os5KkKEu/McVsXusNjzzW48BomyY+DX6z0Fcn4S4k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TqH9ZwxXrhObJ/HP2FNgDbaTdteBpPcpvA1679bwy4fJF/W4ocYWisWMrTAhGwKGiG7JJwzutQ+wZh8pSFNfQJGO13h22OwvTO4Tt6a5tAfgj6nmDSR+RUy8qGf22PIQCx7j2L9FY5v4897xtOspOO96gSIEpDt5d4xRuniub8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.200.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lw793b640PJOjZ/C3tgaErJYPmctjeMhjVU/kbltp3eyPiOBJBxuWA9MQ9c80U6Di3VjEKVRQPR4urmzB/ptr0IlZFalJor0OTjT8g3vYy70mlpyKoxACxkE9WgG829htTxplo0uQmEFX41M0iAIyoYWUxCNyj9WatJHpqDQpxhBYhOrexCcdw/eQRmobwnUSf8IeUy2H1bM4GeVIoPNn+XepDlmlL1dHOKB4i+RXkaoJ11C3g/z/DQBpPuTpjfoRt7+nBlin3XGcBtOdul4SdAtuwwvMvxKGVTwlAnsmXOM2zAmG+ZNdmx872iTNkyrxnF64MbPdfxDu0NSPPouyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pguS1pS7f7ba5unp9/haI4ynQ9qCV2Ood3CphxSfWHE=;
 b=K2vJcCF/qH9WhPKJrvRKmN5raLmLYd0sIk2N89LBE3Y2TvnzoabhQE35mCmFUF/tiTNxR6qMSmeKA1B/bfSp/Is6y40BIACSVU+1ZBLWXnSNldOuCk5P1PfHnB2hfJupuvwWSTTpPNrDIpxSkFmyWp6o9cKsTfxnHojheonyF6lXBwztZ/W0JQxmmtwFliL8uoHa0vz93nw1Grb4vSq8uN6crg2Vp7Zno6yCFDR1ZtwfSZDaVc7pqZ+x/Q38msuaJanDJeTpFVOHGgIyJl6U8s4i+WURven835r+BMbF5G9jwWhL+Ci7OOI7JJnyZ00wNzO5OHdsRPqL+khjal5Y+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 DS0PR01MB8009.prod.exchangelabs.com (2603:10b6:8:149::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.12; Mon, 11 Nov 2024 03:18:35 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%3]) with mapi id 15.20.8158.013; Mon, 11 Nov 2024
 03:18:35 +0000
Message-ID: <c60e636f-8d69-4ec5-84d7-58cf72bbd0e8@talpey.com>
Date: Sun, 10 Nov 2024 22:18:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nfsd: allow for up to 32 callback session slots
To: Olga Kornievskaia <aglo@umich.edu>, Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
 Dai Ngo <Dai.Ngo@oracle.com>, Olga Kornievskaia <okorniev@redhat.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241105-bcwide-v4-1-48f52ee0fb0c@kernel.org>
 <CAN-5tyHqDNRm-O+NKNXGG_J91M3vCgz8LVZWUjePpYUyy6Pmsg@mail.gmail.com>
 <CAN-5tyHGgtBv6u4TBtx8+0nQy26fbqBE0ic_orGHUihNoHNa4g@mail.gmail.com>
 <ec6f82804aac6fa2b75e35c39977703bde38f507.camel@kernel.org>
 <CAN-5tyFmEUyZS-hXURdhhETwC-0MPPz0Vnu6oRW6dbZdWanpjA@mail.gmail.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <CAN-5tyFmEUyZS-hXURdhhETwC-0MPPz0Vnu6oRW6dbZdWanpjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:408:ea::23) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|DS0PR01MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c53bc75-879a-4681-1454-08dd01ff8729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bC9ma2hIY0dNTDJZNFhBUk5nSEpOTVVyU3BXOUhBV3lwVnpzRlFaV2ExdDJS?=
 =?utf-8?B?V3lZUXA2VHFIaFl4Mk4vVVRGdGNGWjc5dG16NG53ZEk4YmJSY3M2RnE0bVNH?=
 =?utf-8?B?MmwvdlltSC9KcDYwNmlqRFVGNlJkZHplZmFuV3N3REMyWVQ3Yk5FT2ZhTEJq?=
 =?utf-8?B?WmkxL3hNWWltQ0lEYzdrc1ZHZitkMjFtc2JyYUpoQXBYbWRZMnB2WlhPaU9P?=
 =?utf-8?B?N2FLaXo0SUIrOWpMNy9vZGordWdKNmVjaUpWdkNqSm1HMjVwYy84aC8wRk9v?=
 =?utf-8?B?MHh0L3YwK0V0dEh4aTRFdDVsNWkxTlVtUjlSQ3pXZXJQbHZJVlhHUTdYemhQ?=
 =?utf-8?B?M3dITXZmYVZyOVlYQjNNajRweis5VGIvTmh6NzI2bSttcUhFZ284c2hER29X?=
 =?utf-8?B?OUc4eHRWTnRCYUloS09tbXNxUDg0VUdGUDNMSHNIOW9HQkU1T054c25ZeXFh?=
 =?utf-8?B?NUhMR2xzYVhPUE5Vb29ZMkNpTkVlVEpNbElIb1lBMThCMUpCbmc3WnAwOTl6?=
 =?utf-8?B?VFdmbjJRdm5UVVlLeDQxMjJ0ckZTd214RG0zNHAybHpqVit3MXVhY00vQzFB?=
 =?utf-8?B?UFNlQ2tqdktMeWtZR3BmbzdyNzdvUkRZRDkrUnJaS0c5YUxiYWpaYjhiZWVs?=
 =?utf-8?B?eDNDbHhxUnFOTUFydlJnWjBRRGc1WXlvcjFTR3JHa253Y0FLMERuTHljMmli?=
 =?utf-8?B?ekJnbEVXWTg2OEI3cGVOZGkwenBjbGZocVQvdGYyZVFrVUVPaHcrMFRhd2Z1?=
 =?utf-8?B?K2ZRS1cyV1BkN1FNdzhYbkZmZTNYNkp6RTZkTlB5OHMvdXlxTE4vdFNZM1hJ?=
 =?utf-8?B?enliVTU5Vmg5TzVtQklpQ2o3d0FmaVkwR3R0eENDdkNCK0F6dmlNbkNKTjl0?=
 =?utf-8?B?REdsSDlzc0FnSDMrRnJ2RzRJMlZYV2cyTE9pSFduaURnU2x6ZVBQVVlXZjFF?=
 =?utf-8?B?eXA1UlU5NHlQYVFEY210L2FXbFl4S0RYMm44QnBEUnUwa3pOdWtMR0dPZ2Vt?=
 =?utf-8?B?K3B3c1R1b2Z5NFFxdEwvWkJTMWJ4Nm5nbXQ2aTFYVGVnMVJNbUNib1RmVnhU?=
 =?utf-8?B?RzUzNnpEZ250Z0g4MXBnQk4xSnFyL2dOdUwreEN4aGUzVGZZdWR6Znp4cTJB?=
 =?utf-8?B?UEVqL09SY3VJR2g3VU1lWEVGVDNJaFJLU2VJRGJyNEY1QXZUcVBQaDJEMWFt?=
 =?utf-8?B?Wk42aVJHdlZMVFUzaTBEV1JJRDgwOWtjQUNhc3hDYjJmdmV6RnVQYmgyZ2Iz?=
 =?utf-8?B?VDVjTXAvZHJwUnFuNWg1Y203UWs5M0lZYXVBNTFKRldjU08xVitBNVltOG41?=
 =?utf-8?B?ekh4MXRiNkxkcG5sWHVLYTJZWTcvYkh0cFZuVTJLbDl2RHBiS2FGV2xybkxI?=
 =?utf-8?B?QkJiTVVaMUVpNEZTODdTK0krMGcwVEtuY3o4Qm5zWmZucm1PektTOEVHbFpO?=
 =?utf-8?B?QW5TcngzMURkT0lkaHFocThpcktyNXRHZHRPWE01bnR6SnlWMkxwOEF1NnNI?=
 =?utf-8?B?ME1UTkxxWjh2T0ZKTUxDNlBnaDZvaGN2N1A0SXZnSUowWkd1ZW5ETzl5UHdH?=
 =?utf-8?B?akhGOWRjZnRXdkFXdzlRek1aM3BxWkpuTVp5Qk9Rb3ZEeGZubGpPc2paN0o5?=
 =?utf-8?B?OEFKMFFTZjNYUnFkdWM4bUYyazNFM1NrbXo0OEdRZ1VsK0JhRmdSUWQ1V2Zv?=
 =?utf-8?B?UW1SVjl5bmhPelcvRTl5WmxxL2Zvcnc2eWdUVmFPNmk3R3ppY20ySGFCZTBw?=
 =?utf-8?Q?B8T7ko8e64OcWLvqfuSfcbX2WGqNxqQvQBVCnMv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LytqNFZIWVpaT0xOR3puVjU1WENqeU9HUzVyK3BlMW0rSTl4RTcwUFh1a3BI?=
 =?utf-8?B?YWM3aVJLVXA1cVpLamptVU9VdzAvdmJtVW9kYit5dHhpUWtnemdueERvUk4x?=
 =?utf-8?B?R1d2ZDlMaTB2cW9wNFBMcWFOV3hhczJqVUtuVXBlYTg2Vnp0OW81bWREQTFC?=
 =?utf-8?B?VEhLekt0SGFWUCtDWTQ2eGNWOU5yNXdObFdJUnF2WGxmOU5sQi9GTE5ZRk9l?=
 =?utf-8?B?RTlpaFRrSzNYdUVQZlIzWCtsbkt1M1dkL0pGc0tRMmMyUWhDTmJFOVBuZnda?=
 =?utf-8?B?azByQzYyOTFnTUxkbTVPRjByb1pPNWRVREgvc3VRc0FUZEV1SmpRUTVGLzBE?=
 =?utf-8?B?M3U2T2JQNjRIOUJQc0hrUmZzZllMeUxyQWsrSWUvWWxrSUVjTGc4aFlTb3ZT?=
 =?utf-8?B?VnhGWU9ueGpka281SEtIa2dVdUZBQ3RvNWRTeEw4eXJQNDRheFZwemVHZDQ1?=
 =?utf-8?B?NkdFVEZVV2kySGxuUEIrNFlaV2l0blB3V2R0Y2xDeU1BSjIzcmxUQkFJVFBF?=
 =?utf-8?B?eEZmeWMzS0I2YVJydS9HRmxVU3d2a1Vuc0phU1diMHdYUk52YVVFMWJ5ZDJ4?=
 =?utf-8?B?U3B5UW9ZWmJ2c3R3eHYzR1JVUGpaTzZhSUtBellRVmFVUk5YQldMYWpkcmx2?=
 =?utf-8?B?SnByNStTQXpBZGdQSG83Z1I5a1Q1Y2xLN0YybUs2Y1J3clRCWWs1TDlscVZO?=
 =?utf-8?B?Y2NXQ3dDelkydDFFWTdjVCt5N1FONU4wcVg5TGNSNno2ZkdDM2NlR2IyRGxz?=
 =?utf-8?B?aUttWUVZbkI3N0FIYmFKcWNjc0xCK2M0T2gvcjFSakhMRmcweDJYQlBnQllT?=
 =?utf-8?B?NC9xWEQ1aVNBS051bi9ZNVJWV3lMZTFDbE54RU1pV3VnZ3ZoelVleFo2K0pp?=
 =?utf-8?B?ay9ncnNld2xFbjZXdUIzSld6WndTT1VMNElHa2plMGVzSlliODBCUEdwWXJ0?=
 =?utf-8?B?MVJ6ZzM1OHkyeWF2Y0NFK2xSTExiQk1ZUWQrem1US3YveTZNUHJrdmJwT0dm?=
 =?utf-8?B?Q2RkQ3A3V3l5ZnV6ZWJtK05wQ01kMWo2OTJka0pwTnlSVkNPZm5JOWRaTXVP?=
 =?utf-8?B?VVJQa2VYUUJvb2RyWkV2d1Q1YVprek5QTHIxOW1abVF4NVVOaXRYZDQ3Tk9k?=
 =?utf-8?B?dFg5V3VOb2dnT0NnOHNxQjZBbFBUc2ppbDNOMVlkYmlqNmNQY3ZPTmQ5dnlB?=
 =?utf-8?B?K3VTZDBvYXBQNW8wOFpPZjREZ1l1VDg5a2JtNjdpMmJkbzRyTWNuVm1sUFhi?=
 =?utf-8?B?ZDhYejlOSUltOVFqVDB6T1d2V0cyMWFXOU5Kd0ZsNDJjc29kU2RJaDBDL25Z?=
 =?utf-8?B?V3EwTk5tcUtkaGZOa21uemkvYzd4WnNhMzhHNnRDOUJHMnBXdDRpc0JaZWcw?=
 =?utf-8?B?aEdMdDRESTU0TnVrZjd4bitJalFVMFVRdUxhbDZvZnhqTEJYSjVBeEo5aUwr?=
 =?utf-8?B?NythQ2V2c0hsMnErMWhQNktzT2dYLy9pN29xckZUbFBkS1VtakdEUmxrYlF6?=
 =?utf-8?B?cWtNSVNEYVc3NDlhd0xKd3B3TmdJdWhCOC9hVXV0N3owT1YyZnRZWENtOW5F?=
 =?utf-8?B?YVY1QjVYcDdPNjZQaU5ZekpsRytoMTlXTzREN2gwT1orSTVjY0czaHVMdWIy?=
 =?utf-8?B?SmdmVlFYRzhobTFYSjdDQXVBdW5xUnorOXdlMTIyaFJkZjRJRFNlZllwMGx3?=
 =?utf-8?B?c2JLQmNlaDl1d3NZV3hpMVFLK0VpVHgxc3ExeVk4aVY4TXorcmVmc054UllR?=
 =?utf-8?B?bnhWWGVtYzFuRVk3MG5nTlR5SzA0V0F5SzNxWU1wSUFyeHY5eGFPWnlhdUdm?=
 =?utf-8?B?UndIdTEzbDNZMzlGK3JrWWdWcC9HU1Q4YU0zakFHL2VhK2lEeUkraE5zN3Nl?=
 =?utf-8?B?aWthZmdjTmEyeDdUWnNvVnZwSTlrQWppSTNrYUVPa2pRR0FwSjY2Q3RPMW8z?=
 =?utf-8?B?elpRNkJJb0RtbXdwZzhxYWxmRGJMOSt0VGc4STdYbHkzUVgvRCtCNUVzd3RP?=
 =?utf-8?B?U3NPbHlOTFZiQWdqQlZ0dzJjMExvdyt0S0s5blhNUEpEZkYxUmNNVW53dGxG?=
 =?utf-8?B?YlVjdzM4S3VHZGlaM2RzbEZCcXJ2UGxMdkZIYS9PL2c5VUJpZ3F3Und4Uysx?=
 =?utf-8?Q?743M=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c53bc75-879a-4681-1454-08dd01ff8729
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 03:18:35.3789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5LOppdMUnH9Tm3RhB3aLfPpm/6mWI0JBV2mX0r/gKXTGI9b1BZ9HnMrqZ8NIawu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR01MB8009

On 11/10/2024 9:24 PM, Olga Kornievskaia wrote:
> On Sat, Nov 9, 2024 at 4:10 PM Jeff Layton <jlayton@kernel.org> wrote:
>> Sounds like a client-side capacity issue? nfs4_callback_recall()
>> returns NFS4ERR_DELAY when nfs_delegation_find_inode() returns -EAGAIN.
>> Maybe there is something weird going on there? Eventually the server
>> has no choice but to revoke an unreturned delegation.
> 
> I'm not trying to imply in any matter that there is a problem with
> either server or client side. I'm simply trying to state that there
> was a theory that having multiple cb_table slots would help in the
> case of having a lot of recalled/revoked state.  What I'm finding is
> that it doesn't seem so (and possibly makes things just slightly
> slower. But no measures were taken so my focus is elsewhere).

We should definitely understand this! I'd say that supporting multiple 
slots is worthwhile and should be merged if stable.

But if they're no better performance-wise, we're missing something. 
There's got to be something else serializing them.

Tom.

