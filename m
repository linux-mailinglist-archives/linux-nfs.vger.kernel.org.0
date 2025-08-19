Return-Path: <linux-nfs+bounces-13781-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3739CB2CB49
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 19:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC293B4054
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 17:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD1830BF74;
	Tue, 19 Aug 2025 17:39:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022077.outbound.protection.outlook.com [40.93.200.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F4C2E2297;
	Tue, 19 Aug 2025 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625195; cv=fail; b=bM5J4ntLd8+4csSX9DxfO7xCEtHbNTVbbrEHwjJTfe/23r9Mp/NHiLx0QZZ8Z3s1w4k8cUmZ1gvxlxFHcC+kCoJ4avd70lnkAX5skH6jZ470k7imcsB3yLXBzgial7zKlKmnoYcLod04eCTHUcNack7om6OlhO4ksQh9lRSUlNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625195; c=relaxed/simple;
	bh=iZNokIZwJNR4kfKBdhCTXgr8d855CCihCYSoYOhxc+E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qJbgNhcfu9X6m5YHDM6N9tjSY4YspFo2n1TeO8SL/t9rlqMDW+NvDLtieajz24w/nuQaXf2F5gp52WWC7AOz8Cu05Wz3Ys8ambuMBJMiELgdJi26a1TXmG6dRczrq0FKd6bYitPeLPO+R32LJxFFpiY4qwNuGlioM4O4ZQ/tSBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.93.200.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLNhOT72S2wT2eWR+AEObaVqsY1TjxBoJso05mxmgIKK3l70fBvKBZCMzo4Rr0ASsidJpmu8lxALQjwmRJw3xX/mb2TKX8PCh/7XSWeeooXYlxyCOBsWR28a4/d1fwL5r91MZ5iS3XMMvZnBAYDbIijh+QdGjl9uYcIyqtJm1D3fvJFmxulkxCSlFPylkkd4p57W2I7LjY1qApPMZGp+eKf4EKGRvCRn/TRyuOygRDQUPW+i9+auDxDE/BInOozv8fgSAzKcOC8p3jtWn4DH4iVDUd6oZOT6ETrTu2NezCQ3FDMe3jwEN+Mr8bBX73cqHcSmQtxxwwPBc0hnAZyFUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuNG637aA/XhPRMbkJafaEBjB1Vtife/uvV/ZzV4tnI=;
 b=NWr5K4w+fEPuAy36b2rq3XaVQFTVjWuGO6AgUMk0Ll+2P7ZTMy1hgbuWK7yCQP/wxUe8MlpFDTYIDCiS2tASE4UFU4iNSmOenGDk7+0BKEV6ZXjcJH5xyw9lKJDvKu3JM8Za+KZQ7alUGPU/H0hMjWd1h5ZnfrSfc2Sw5FcuD4laE/g067JV728KxpxUNPEIsj0qer3IqfxsSB1ntQdtTktQQCW38VNa/SE+smi4t+780Y0DVFWu+wGHv9LNZvPPI8fwCVfDmwWfljBQbSABoZ6k8lJKF3alNBSv1cxDkax2UDp7Hqp3l1Auu0+UibFODAR57BLKk6zEyZTMy+ONTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from DM5PR0102MB3414.prod.exchangelabs.com (2603:10b6:4:a8::22) by
 SJ2PR01MB8583.prod.exchangelabs.com (2603:10b6:a03:53e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 17:39:50 +0000
Received: from DM5PR0102MB3414.prod.exchangelabs.com
 ([fe80::cc85:45b5:e6fe:e2db]) by DM5PR0102MB3414.prod.exchangelabs.com
 ([fe80::cc85:45b5:e6fe:e2db%5]) with mapi id 15.20.9031.021; Tue, 19 Aug 2025
 17:39:50 +0000
Message-ID: <044700d6-4f40-4ac8-bcd5-d3856af9f926@talpey.com>
Date: Tue, 19 Aug 2025 13:39:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] svcrdma: Introduce Receive buffer arenas
To: Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>
References: <20250811203539.1702-1-cel@kernel.org>
 <a1ce98e1-83b6-45c4-bde0-c4b71be67868@talpey.com>
 <1cea814e-8be3-4bf9-ae3b-5bf21eae0a3c@kernel.org>
 <383ea66a-8b0e-4b90-98c7-69a737c23f82@talpey.com>
 <ee20aca3-8c32-48f4-8a90-5e4cd4e05aab@kernel.org>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <ee20aca3-8c32-48f4-8a90-5e4cd4e05aab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:23a::17) To DM5PR0102MB3414.prod.exchangelabs.com
 (2603:10b6:4:a8::22)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3414:EE_|SJ2PR01MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d7d284-6c80-43eb-47e8-08dddf4765d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TS8xaHBnRWNSMXY5Ynd4cCtLQ2dzZVB5anF4ZENMbEVmM1Jnb2RzU2oxQmh4?=
 =?utf-8?B?bTQyYWRoemJpSVQzckJXb2RhMzFJQml5ZmdaUlRlNU5EbHVLelJUbkk2NUF4?=
 =?utf-8?B?TXFjNEN3ZDRxYVhGSnh6MllpY3dJY3dyaUdBd082ckhXeUZ3eHFQMUhUSTRH?=
 =?utf-8?B?K1ozUVBWT3RTNHVKK0xzb2ZiemtFWnlzdlRLNjF6N0tZZDg4aFl5OXJYMFpD?=
 =?utf-8?B?QlczdmpReUd0a0FnL0JINEZQTlFxWWxKcXAxcTFVWTlUVkd0b2wxZExiTzhC?=
 =?utf-8?B?a0NySlEyYStEZnJkbUt3YXZ1eUZUaS9oS2gvYllNeTRUTlozKzN6SlFhVCtD?=
 =?utf-8?B?V3VpWmJYaWRPdDRuR0F3cEZFT21XYnFRb25wWDBkZ3FoYlFiMm04b2Iyb3ha?=
 =?utf-8?B?RzEvakt6ZkFtd0pEeFFPKzZhWFdZQVVOdGU0U2tvTmVrTkQyandJeFgyQ1hn?=
 =?utf-8?B?MmZJa2lpVXljRDVESUF4bGRHU1FPZUQ1UkkzWnd2WVVLa3F3VFNCZTErZ0hT?=
 =?utf-8?B?VEtJQnY2YllqdldzVDNocTlpUFJoUDVrOWpwaTNnUTR4NTJSQTJoRGxmUlRl?=
 =?utf-8?B?LzliS0xSTllJZEpFOE81bFd6WElJMmZtMEdUWVcvVGpxNkcxbEM2VWpyUldW?=
 =?utf-8?B?TGJIc0tIUTFkbUQvU1c4Ky9NTVROSW4wajB5WGd0T0w0WXI3N0wzcm85alJQ?=
 =?utf-8?B?eUFPdjRwTWZ2dC9NZDZ2eWRRTTBjK0RTZDYzTFEvZWZBZDd4S2RzMVlMWHZB?=
 =?utf-8?B?cTJOVHpDKys2cFF1eUdqbk1leTh1WEdqcTJITUlqdU5RVm5pSGpDR0ErOGgz?=
 =?utf-8?B?ck9KU1ZKeitCdWlMdFE2aU9ORGRWbmF6MjhxZmFvd0NTZ0xFTU1ycUtVd0sy?=
 =?utf-8?B?aHRLRk4rYzI1N1IvNFgwa1h1VC9kVXpVV2FGa1duOGJVZisxRnk1eXg3Z3Z2?=
 =?utf-8?B?bjZHbG13ZjU5Z1BLc05reUNtOUFZbHc1d28xeDRNODZtK1RLUkVVR1pJK0Vk?=
 =?utf-8?B?UU5vUUJ3cENMcXo5S0o3YS9ld1JwaWdUQjdwSk1IT1EveXV0eHVCa2dQcTV3?=
 =?utf-8?B?THB6L0V6cTJvRDlob01tZTluRFd2eU5KZUxrVUNLMFpWcDF0UnJpVXFXN1Fq?=
 =?utf-8?B?WklILzdJRG5JcjFCKy9FQlh4Q21ZVGtJSzBwTVo0YzhtL1JHcmNjSkJWYjRa?=
 =?utf-8?B?ZHBYYjBjRlRsYk1VcGYwV1VpcE1DQ0YzVzEzZENjZStLZzdnZExpTWYyU0la?=
 =?utf-8?B?R3dSNE1TU2FLUG53enRPM1R1RHpXeVBqcmRQYkVsTWVidGVRUE5pYzJYbnN3?=
 =?utf-8?B?bXFvaUJ2V0FnYlJlRWlkZlpCU2Q0eHlocGlBYW8zQUQwVlZUbHRPc3RheFVo?=
 =?utf-8?B?NHltOSs5TFRjMXhVekVvU1JPaUtpaTFhTkczSUtycXI1dUdIWmpLTkRLWVdN?=
 =?utf-8?B?YzdmZlR5Y2ZtR3h4Q2JXc1p2bWJkdFd1QmtiMFNTZU9TR296UnRxRmU3TitD?=
 =?utf-8?B?ZkVtYUNyRi9wZWZWVnhyY3JxditlTXZRNVNuZS9xM0RreitkclhiT3RrbCty?=
 =?utf-8?B?RHAydjlsSS9oWllrU0l6WGx3aUxuQzhXQ3U3YXFlbURlZ1ZJd3RQSE9OcDgz?=
 =?utf-8?B?ZnlFYmRRSkZzT0JpVS9Kc0NiQm1QNGdxOWJETUhIbHRqeXB3eCtJSUJLclBV?=
 =?utf-8?B?MnhIR1VFK0FCemdzZWROYjlEWWdEd3dMRVdMemtoTUZlYjQ0d2VMSmM5MHlW?=
 =?utf-8?B?ZFlYdFJiaC9VVFg5NDNLSGVnS1JPS1ZOMkplRTQ3eW4xYUtjdGJudy96YXVr?=
 =?utf-8?B?a3UwOTNTZnpGS1gwTEZrWWo0NTZkMm90dkRLdWF4OFZJM3pMdlBvL3hGRWtw?=
 =?utf-8?B?cEFFRWxnSFdaNEp2TkNTSFk0Unp1eis2TzlYTzlyVjBCd2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3414.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SktXbW9pUHp6Si9rcElLa0oydlVVa284SkJ2NWswRWpSLzZWU25DdEd4TlNz?=
 =?utf-8?B?RFNZTGFOM2xUY2d1RXJMblBvYWU1T0Fyc1ZuWWlySUVZRXRtbm8rSU9DcnBl?=
 =?utf-8?B?VlVJQzJrMStoNTlTZ09ZenlueStpaEtJRDByb3dWblpDYnJ4ZHVtNkxkaVV2?=
 =?utf-8?B?OHEyNW14MnFXazRra3JtbkVDN3JIeVFJU0FySW4zNTU2SUh5T2xCbjgvMDl1?=
 =?utf-8?B?OW90OHZQQTlaQ0NrNDV2MlJBSnJaeU5HTko2d2QzdmZPNlEvMHJvVFRDRGlD?=
 =?utf-8?B?Zmp2N3BzcjNQcWtkQ3daUEE4UnNRZEZVUjdxMXFKSE9kZEx2bTFyZFdscXZ0?=
 =?utf-8?B?ek1OVHlha0k3VGM0WFBCNGFIWXZqa2ZhNEhHSHo5cFFUZXlCMmNieHluelFZ?=
 =?utf-8?B?ajlnQUNJa1RZRlJiVE84WTZQWTBMSWU1TGhjMm53dFZuUi9QbUxvSlhTTUFx?=
 =?utf-8?B?aG5hTzdwV3Q5dHl5M2RmMHRnK0hSR1lxT3JVWjVLNDQwc0RGZG9WaVJxRWxM?=
 =?utf-8?B?M0MyVDd0Kzk0VHF5UHhqMEhKb0EraTZpc2plMExXZE8yQk5DOHRLVmJDRGV4?=
 =?utf-8?B?VmFtbGhkZWRRK2xqQkxBdk4vYStzblhBeER3YXNSN0NrbmxkWWlsNG4vSU5n?=
 =?utf-8?B?d3p0V1lzRmF1eTh2ZHIxS1BGa0xidS8zbDVRNkZJdmNZVjRrZmFLS0hLRTE0?=
 =?utf-8?B?aFNrQ3NoVURweWlDY0FFb1gxWWwxd0FlRjJReWVEbFpSZEp3NjJKbXgrNzA4?=
 =?utf-8?B?M1JON2NaaDR3ejUxbGJKTWRhQ1pMZXBTSmRLakp3dzFXTm90QlU1VGFRajJ4?=
 =?utf-8?B?dWJLdFV5eUc3NHZnWGMwZmhYNzMzYldWU1dOdndmT1U2dHZOVXlCc2hyRGdB?=
 =?utf-8?B?YUZJbkZkTGxNWEFUQkE0ajIyYjhISkF1elhsdjMzcEFRQytzV3VUQ2pGTG5W?=
 =?utf-8?B?NStNNmhYaFRiVkZwL0Mrc2d2ZlZWVmQ5SzJybXoyWnN2K1FDdzZMcSt5R1RQ?=
 =?utf-8?B?Q3JzWHFTd2lsMEpOQWY4VVNjdGNWdlRTc0hSR3FFcTFWS3piYndLZHM2ekRG?=
 =?utf-8?B?VnhUVWpOQnpxS05LMW5JSGNJMngvY1VoZjhidDhnWmg3Y3BNWmtwRnJ3Tkps?=
 =?utf-8?B?ektsdzNRVERmalk5OVJtdGtNZzVCNVdwOThjUXo2ckFGUGpoeHFjNGgvRXFu?=
 =?utf-8?B?Q2hFVTJJd2ovVm51S09UU3NnTDhCc1RZakZMQ2s0T3ViS0hhM2MvdFNxTzVk?=
 =?utf-8?B?eFZsVVFCdjQ0VWVhaEMxcU5UM2ViSVpJeGF2N1k3ZVNCRmpyeVV2Y01BV3Bh?=
 =?utf-8?B?Ykl6VWlKeWdtNG9PSVdXUTNVS3RmdzlneWVEV1lzTm5MOWpsaCtpaXdBSlcw?=
 =?utf-8?B?bDZGdC85dmdLd3ptWi8raHRvN0ZhbHVDOVB4aWlMWkhJWkNheDlBQ1Q3bUo3?=
 =?utf-8?B?ZGJaZHlsaE1BZUJ4SE9qL205WWdGQURhd05nbG5WZjU5eWZOSnhqOFloVG1p?=
 =?utf-8?B?RlFzSmVtY3FENXErVEtqa0NaeFpFdmc3MUxONFcyT0M2SXVIbGhKdGcwNzhl?=
 =?utf-8?B?YlFacXNxVFZJNWV0MEF6ZSs3VnVHbVp6ZzI1OGMwREZhRjFDdmpTbWhmektu?=
 =?utf-8?B?YnFLRnBuSUVBWEh6eW5Dejl4Skx6Y2dWZ3l2KytkbXhmL1NMaTFjbG5QcThw?=
 =?utf-8?B?Nkx5M1diaGNXQkRMdDNna3NENHJ2bHRPdU9rTXhpS3E4eFJyODg5UW03aFNo?=
 =?utf-8?B?cnpHcDRyc1ZJMS9lUll3R0lER2NvZlJrbHlhdWIvQmFQb1BiRVpTZU1KakRx?=
 =?utf-8?B?dGpDZ21KT3N3WHlLKzFZS05PVGQvK3dtc1gyd3FVNVlKU2dJWlBKT0pDRndC?=
 =?utf-8?B?dUhqRGR1cmdHRG5sbFhjNzBQeDlKN1RNT3JNMjdwbUNmRnhteldZblBzUUpV?=
 =?utf-8?B?ZjZySVJDK0pJc2t5Rk40QktiT3ZLK3laZHBnR01vaG1TS0Q4VFphaVlHZ3JD?=
 =?utf-8?B?eWwxZEdCbnVpVWtGZFo3OExER3liSGFmNEVPK0dMUU8wSS9nNVg4WVp5YjUy?=
 =?utf-8?B?V1JQOEcvdkNBdE52OFBxRTR6cmxZZ3NoWWcrNDRqSnJhZDlta1hDVTNzWUpF?=
 =?utf-8?Q?9vtftW6V8p3DRU9D/nBIHP1yo?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d7d284-6c80-43eb-47e8-08dddf4765d3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3414.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 17:39:50.2513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqdTf2A/fuPUVx2XLuJRn+aqPxvc62gZeNupvxpjxyW/LwRiQFwMjqBfXtwfom7k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8583

On 8/19/2025 1:16 PM, Chuck Lever wrote:
> On 8/19/25 12:58 PM, Tom Talpey wrote:
>> On 8/19/2025 12:08 PM, Chuck Lever wrote:
>>> On 8/19/25 12:03 PM, Tom Talpey wrote:
>>>> On 8/11/2025 4:35 PM, Chuck Lever wrote:
>>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>>
>>>>> Reduce the per-connection footprint in the host's and RNIC's memory
>>>>> management TLBs by combining groups of a connection's Receive
>>>>> buffers into fewer IOVAs.
>>>>
>>>> This is an interesting and potentially useful approach. Keeping
>>>> the iova count (==1) reduces the size of work requests and greatly
>>>> simplifies processing.
>>>>
>>>> But how large are the iova's currently? RPCRDMA_DEF_INLINE_THRESH
>>>> is just 4096, which would mean typically <= 2 iova's. The max is
>>>> arbitrarily but consistently 64KB, is this complexity worth it?
>>>
>>> The pool's shard size is RPCRDMA_MAX_INLINE_THRESH, or 64KB. That's the
>>> largest inline threshold this implementation allows.
>>>
>>> The default inline threshold is 4KB, so one shared can hold up to
>>> sixteen 4KB Receive buffers. The default credit limit is 64, plus 8
>>> batch overflow, so 72 Receive buffers total per connection.
>>>
>>>
>>>> And, allocating large contiguous buffers would seem to shift the
>>>> burden to kmalloc and/or the IOMMU, so it's not free, right?
>>>
>>> Can you elaborate on what you mean by "burden" ?
>>
>> Sure, it's that somebody has to manage the iova scatter/gather
>> segments.
>>
>> Using kmalloc or its moral equivalent offers a contract that the
>> memory returned is physically contiguous, 1 segment. That's
>> gonna scale badly.
> 
> I'm still not sure what's not going to scale. We're already using
> kmalloc today, one per Receive buffer. I'm making it one kmalloc per
> shard (which can contain more than a dozen Receive buffers).


Sorry - availability of free contiguous memory (pages). Over
time, fragmentation and demand may limit this or at least make
it more costly/precious.

>> Using the IOMMU, when available, stuffs the s/g list into its
>> hardware. Simple at the verb layer (again 1 segment) but uses
>> the shared hardware resource to provide it.
>>
>> Another approach might be to use fast-register for the receive
>> buffers, instead of ib_register_mr on the privileged lmr. This
>> would be a page list with first-byte-offset and length, which
>> would put it the adapter's TPT instead of the PCI-facing IOMMU.
>> The fmr's would registerd only once, unlike the fmr's used for
>> remote transfers, so the cost would remain low. And fmr's typically
>> support 16 segments minimum, so no restriction there.
> 
> I can experiment with fast registration. The goal of this work is to
> reduce the per-connection hardware footprint.
> 
> 
>> My point is that it seems unnecessary somehow in the RPCRDMA
>> layer.
> 
> Well, if this effort is intriguing to others, it can certainly be moved
> into the RDMA core. I already intend to convert the RPC/RDMA client
> Receive code to use it too.

Not sure. The SMBdirect code doesn't need it, because it uses
somewhat small receive buffers that are much smaller than 4KB.
Block protocols probably not.

I sort-of think this is a special requirement of the rpcrdma
protocol, which was architected in part to preserve older xdr
code by hiding RDMA from the RPC consumer and therefore segmenting
almost everything. But there may be other reasons to consider this,
need to ponder that a bit.

>> But, that's just my intuition. Finding some way to measure
>> any benefit (performance, setup overhead, scalbility, ...) would
>> be certainly be useful.
> 
> That is a primary purpose of me posting this RFC. As stated in the patch
> description, I would like some help quantifying the improvement (if
> there is any).
I'll ponder that too. There are potential benefits at several
layers, this makes things tricky.

Tom.


