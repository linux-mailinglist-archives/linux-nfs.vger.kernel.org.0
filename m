Return-Path: <linux-nfs+bounces-10911-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B11DA71C98
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 18:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943C23A22F3
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 16:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135B21F37C3;
	Wed, 26 Mar 2025 16:59:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020097.outbound.protection.outlook.com [52.101.46.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D3C1E4AE
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743008363; cv=fail; b=DTfWMkBWmf/ihDnkPohjzxVM04J53pE59iB0v/9BdR8Pb3kt1sHyptfzimGQlWfIvKfIHEQ/S/0kiHVcb2oNWRYAX7NvIO7iXJSlMlo2rnmhz1GJILF8xZDuskVTh++OPCSp6yBksbmx3R2KqkNdh6o3J+bsNtmxjUckyVJAwE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743008363; c=relaxed/simple;
	bh=I9l+q2kuS+I0+yLd0pHSykJYBOtf6y3ZpZisAR79i+8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kMtQ9OLXZ7xv2i9CLVpZvaM/bX/2cNvx1Jjh/j9DH3xqmm48NHybM6k1rj+107zNbsx8kFTNJUXjmF63p4sPRR+izIYWQWDz7PNGCcl+9dFU813DZQfsgTjCNC6XeKYv+QcHa5D56JjcVM/heRRAGbT+m7Z23QJDQ+KrawPCKI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=52.101.46.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncjXAoDbHamGtL6brfUoZ7dfy2WLbH1n8uU8ebs5QOn04r7iQJqM0t9AU89pgVC8j8y0wRgV+LApoZ3MgKsr8HU23Q4udqg6/jnJeAmctHzYiYAWs9X4W5YQHcahlR3CZuwlHpw04/4kqPhG2QvOp9XLxA+hEoJzF0EIoUjGOIloU+RYEFgsxEkOQf8YvPtNYC7f5oJpceHbwYFCkV73MP2Q7ZgM0FmR4Ww4IyoXfmMKEdhW/5B6KXuqH/xvb8pbr0SylnrpaFBizlqneNA/M5PjCK5Abxt4zFJni8ePszoL4iSrqaSpjR/EVnU+3Ffkllmyk2h97p/YvhY5l4+Qlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wJTp2jgfEpgeX4jkZfBKO50NeB6xr4rNRW9q15cakI=;
 b=w+b/xCNNfA9i1TreLERXKEhubJxmqn3YpWb0hjexSWQoOoC5xKP5qU3gr0vMTLJMm8yvSkXZKe9psYUWeXFHrkJT+KDidCLYVL3sFy+y650RFvEGRcl7sBbhMw7WbRAWGaRVNGo6OXgApx9IbQ2IY2uN5Y5m2sUZVh84Db21xa6eG9qc/z8FZ3pSL6TJWTGmP7G/SvErqlzKJ19XhRegRdfFLilC84JUW7z3GMwhLGYEYDFopX39yWhclesmi6AgYnFs7cetv5EcopMJDYsbEBcxnZjdvnwvhZDBNodhb8et9UnWdtPJ/iqeX3i3YSle0h+0DpEjZk3+8dl6F0sH9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB3854.prod.exchangelabs.com (2603:10b6:805:19::20) by
 BL1PR01MB7673.prod.exchangelabs.com (2603:10b6:208:394::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.43; Wed, 26 Mar 2025 16:59:15 +0000
Received: from SN6PR01MB3854.prod.exchangelabs.com
 ([fe80::66af:6788:adc5:f856]) by SN6PR01MB3854.prod.exchangelabs.com
 ([fe80::66af:6788:adc5:f856%5]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 16:59:15 +0000
Message-ID: <92a56d9a-b773-46ac-8a72-a20c7dcf41bd@talpey.com>
Date: Wed, 26 Mar 2025 12:59:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Using Linux NFSv4.1 RDMA with normal network card?
To: Chuck Lever <chuck.lever@oracle.com>,
 Lionel Cons <lionelcons1972@gmail.com>, linux-nfs <linux-nfs@vger.kernel.org>
References: <CAPJSo4V8WnCz0rrdHK0SdvrhKO9Ex-BONU3bkao5wziCnXfJ5g@mail.gmail.com>
 <5c458e04-4be1-4b0b-af99-41d258da5d7b@oracle.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <5c458e04-4be1-4b0b-af99-41d258da5d7b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:208:23a::25) To SN6PR01MB3854.prod.exchangelabs.com
 (2603:10b6:805:19::20)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB3854:EE_|BL1PR01MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: ef815a4a-fa21-4eff-0ae7-08dd6c878a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eko4NTFYcFBlM0V0RWJseWNXbXIwemh3Sy9CWlZjMDkxUjJnYlBqOHMzOUs3?=
 =?utf-8?B?dnEwTHZQbk4rdGt1NXZBTG82dThiMFM5dkt3UERCMGxac0laMmliRDk4bVRP?=
 =?utf-8?B?K3VPelMwb3BIcnJJWU9yb0c5U2t1NUdFT0ZRMHRDTjJ2VW4wSW9GNEsxc2VF?=
 =?utf-8?B?Zkh3YngxaEhLVWltL2k1L05HUStDYWJqelpHS3hhM0xYeVVWQU1ubmc1bHpP?=
 =?utf-8?B?YW50VlVFRldXMGorb1dmWUpIcUQwZk5FT2ZCMjEwTXZjRVc2U2ZvdnNxaGVY?=
 =?utf-8?B?dytFZEwvSHJ2RGlGZ21JbUdGK0E5dVdYRU5BZlBhSFBNbFpTaGdsOVhpOVBZ?=
 =?utf-8?B?VFlJVlAyK2F5ZW9Uend5SzJESlhYb1YrRkVGU1haZEVaOHdUM1gxS0VCcUM4?=
 =?utf-8?B?d0N1cTVvalFZeDVLUTZzVUN4SU9qK1ZSVzJNM3FDcVlndXVpaFFZaVBld3BQ?=
 =?utf-8?B?SHdIeUR0K0ZVWHlMSlJLd3BmWHVZS243c0o5OG9ZVGFqc3RmSGh3anE1ZnBh?=
 =?utf-8?B?cjVJWElwUVZ1UEVlaUhVS1psTXVXUWJZSVNDVnJXNmZkNVZtSjBueWJmSGNi?=
 =?utf-8?B?dkN2a3hEZi9ldTREZk9Yb1FmZDVCU2hySUlIZzAvN3hqN2l5VzBNQ1pzdGtL?=
 =?utf-8?B?bWNvNlByU1NmSzhEcWo3YVVKdkxYb1pTUVNlcnlpaVhFRnFSeWgvYzlndUVj?=
 =?utf-8?B?MUVRNm4zOG5ISUpSUm4rbEsvd0pmS1NpZ1g0UjVaS2NVd0lndFpsbmJjVFA4?=
 =?utf-8?B?YStOMjNWcklTN003cGtlS0lKTUVpdzUrVUxIemwrajlRbm9nMEtyR05xTGph?=
 =?utf-8?B?TlFrRTZFNW11U2FvSkZZYXFyQ2J3Nld5NlErbzFHeCtzckhBak5kRnQ3blZw?=
 =?utf-8?B?bFJxRmNwM3pZaUNudC8vbVYydllnck0vN1F4eW1TVUs3OXN6c0ViejltWkZS?=
 =?utf-8?B?UlI3SmVrbklMSUpKajk2NnBlZzR4VXprWHloSnd1NVRZQzk3YmVoTUZub01j?=
 =?utf-8?B?QWRXSUlCVmRqc0piMHBDYkVaNWdEZHRSK0R3emNVNTFySHIvbFczcEF6VVBw?=
 =?utf-8?B?cVo1SVJGZW13eThaKy83N0dtSHUySGlXNGUvUzMyVjE0ZzZTZDltVDBVWC92?=
 =?utf-8?B?MEVrNFBsRXBJVFl6YVA0RmZ3NHhBRndicXR2TXEwSWU3MGZtMTgweUloUzFn?=
 =?utf-8?B?dUEzaVZjNjluU2ZvZDB6UTBQRUViODJyS0VTb3VjeGlWR2NzTGJqS1NaOG95?=
 =?utf-8?B?NWQ4YU9wbTQyWTNqbDBCcjd4eEZnQXlTcmYyMWNqYWFvV3Q4bHlFbGtxTk5y?=
 =?utf-8?B?QjhyRENkK3ozQ1I2bEVleDE2cEJkZjc2R1lzZ3pXajl6YUVDT0xwZldVRDR3?=
 =?utf-8?B?MmFTNDNYWkVGY3FWa0ZPVGZsVW1lOXRFMXlIWTIxQ0dWNGtzVjdaK2hYOURR?=
 =?utf-8?B?dnJSQXQ1U2FpUDJUbmJ5R3Q5VkNsd3M1R3FNbXBqN1ZBMlY5UHIySS9Ya0p3?=
 =?utf-8?B?aU5BY3Zza1QxaWQrQUphTWFlNHVEN0tyREhuZXE4MUIvSFZxZ3I3NXBnaVlB?=
 =?utf-8?B?bmVWRjVBaE5VN251dGJXUEQvTU9WU0tHamVOZFlJaUhiU2RhVTkvVE43S0Zl?=
 =?utf-8?B?eVgyYXlLQTRqMHROVlg3OTk3U0EvVm5zK2kwVkp0SDYwRWg3MkFDZ3k3aW5p?=
 =?utf-8?B?bVJ0SW91N0xqQjJPUUxRcWZ6MjBGK01BMUZuU2Nib3lDZjFvQ1EyaGRXdGdv?=
 =?utf-8?B?b2ZpOTU5STJ6MkFlZmFrWWZkMEJoNTFWUW52VEw0VTE4bEtCcGJRNENvcUZi?=
 =?utf-8?B?bVJBS1psRWxuM29UT0dOeUFUZk9TWHl5VTdyNExhSUdSbmNyMHBSZE1PcUlK?=
 =?utf-8?Q?2C+sYK5xWm6KK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB3854.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlBYWHI2WTRwNmFyTjl0aVV5elBSSytxS0hVRWtIMmZUT3hCYkNEZ3Z0bEx1?=
 =?utf-8?B?TWpSU25ldWZxTjRweUN3SSs2bXRWYWVTTFFnblZHNUFSUjVDOUIwU3JQUmRx?=
 =?utf-8?B?Qm0rcG9hM09zRzE4UW9GL0ZiVklDbjRxWGpmejdIN3ZIcjJiS01lL0FqNHJL?=
 =?utf-8?B?SzkyS3pSNU5MZUlQWXoxM2xaZTczUlFKMmc5c3BzWHFmMTZnN3lDTzFTbjQ4?=
 =?utf-8?B?dVlUdXVET2NIdlpKUjFYU3hSeUVyUWE1ampod1ZCU1FJQkl2cVUrdm5HVXIx?=
 =?utf-8?B?QnJ0dnEwUWhZRWlRRHY4bmNkVHN3N1prRVUvT2ZDZ3NpZ25YWWFzcnByUmJM?=
 =?utf-8?B?cE9ETTc4S1NHUHJvMXZzM3hENW8wbGtaanRTZWhpUHBaV1VQamFCWGZob3lD?=
 =?utf-8?B?RENiV2NDQVdnbjlNV1YzbXZuUURjREtETTRwbmg3ZTBUQTdoRXRHbXQyL2pZ?=
 =?utf-8?B?WFBEaVZ2UURreTcwWFVncCtSR0toTkwvbHhhcFhKVURIZ2JjNHpSR05DOXQ2?=
 =?utf-8?B?VURKT3JVQjFZUDZxc3pCdnR6TjVWNjZHdEdxdjc2YmlHakwvbHVIZ0NLODUr?=
 =?utf-8?B?S09PTityOWpCaGJMRjZYeDgzQ2psMThrUHRvemFMSWpjZXZFeXVyTUxhVEFG?=
 =?utf-8?B?bjgxM3pEdEdEbkVnYUp1RWlFZEZUNlljMkpCbHdjdVJLMkVsSDNyYUtSdDdk?=
 =?utf-8?B?SDdUOE5QVkVTTm1hZUFaaHBKc3hxUzlZWHJ3S3ZrNFU1RlFxOGdPbTV2ekU1?=
 =?utf-8?B?YnByTjU5aDgxMWJQRGg4TDBrK0ZOL05WNXlCeTB5YkZFczVyaUZKblVWSmJN?=
 =?utf-8?B?QXEvWnBXcGFEUXNRaStJTDFLNkkxNTMxcjVKZUVtTnZ0bVhHdWdoWENpMlR1?=
 =?utf-8?B?aUFhL1ZYdFZydWRBZWNYQUxmL2xSLy9tNkpiUUtiTlhrWDFUa1JpMVdKVmll?=
 =?utf-8?B?UG9IZGpHQ3hCeVlxRE5CckNod3k5YklKNGhxaHdIc2F5M201SUpYQkdHcDJr?=
 =?utf-8?B?elNsS2x0MmhDM2VSbVMrbzdFWWFtdHRYK3hmdWVnQ1BsQ3A3ZEFrMmU2SW0v?=
 =?utf-8?B?UXlpTDNGU0U4RHN5NldCUGxFdHQ4cjNmR1JkV3BOMThKVWFNaG42UkxuVUNz?=
 =?utf-8?B?NEZoaHlvN1orbXJJOUtnVXdLeXZMeHdJS29jVFJZcFlyUjR6cktYZW1JTmdp?=
 =?utf-8?B?RGNCd1JkN3AwMjVoMlZsZ1JqK2ZkSEdBK2R4WEh4N3IxSjZFQkU0UnM1YTI2?=
 =?utf-8?B?OHZ4SXArM3FrRTZMcEcwVTcwbnQvU0k2MnhFUWtwZEZwamNTQUQ4dGlKbGE3?=
 =?utf-8?B?TFFiNkJ2YVJSQjFGelVQelFoZXhUUWVwRllzZHd2K2Rwd3YzTnhKc3pnZzQz?=
 =?utf-8?B?QTdkMEVmOVFUSXdiNmx6USt3cmkwYmIzcFJyQlI0SDA2Y1UxOE9LbTBIMjRp?=
 =?utf-8?B?WFF2UGdTS0lsbmxBS2FXVlhYMkIzVmp2UDhwZXVkcHpOZWM2Rzd2TDlWelBk?=
 =?utf-8?B?SWQza2xuUHR0UjE0aEZDcnRaM2pXY0pRamhDZVpIeDhqUjg1NWtwb1hlN29F?=
 =?utf-8?B?SnBDQ3hkSmxUWENxS2Q1WTJrYVEzVzVaanBUcHZJeXI1ZUMxZ25LWDlGeUNL?=
 =?utf-8?B?RDByT21pYjM1cjdUUVR3Rk42bnJCZ0t6Q29ELzBhb2MrdHR2clRJeGFEaUM2?=
 =?utf-8?B?eEErVW8zaHF1d3FYSytFVWdCZG13L2VWdWVYS2owM2dzTkU2K09WSklXNWRp?=
 =?utf-8?B?d1VWclZ3NTFNM1JKR3ZJRlRxWkdCSzhydzVHTGNiOXVmcDJjR1V2N2RZSndp?=
 =?utf-8?B?aW1oZlVSOXRBa29zS2wwMDBzM2psMUhraEQwVENEY05lTzBtRlFSKzB6Y3N1?=
 =?utf-8?B?eGdFSVlWRGJ5SDJwS2luc0JacUQwRTVmQlFHQXNVY09vV1Y4Tmh1MEJDRGh6?=
 =?utf-8?B?aXVERWFVeDBCT2drWkdnZmJJeHJsNFVWT0ZDc1hwa2lkQ3BOakN3NUw3aGdE?=
 =?utf-8?B?TitXeEg3MVF5RytNZWh5bEhON2VyR0ZzdXRNd2Qvd3Vxb3ozdXQzOHV2S0hu?=
 =?utf-8?B?NTVIZkc0TUZEckxPY09PeURJRmthZFhmVnZUMldJRXlOaE82Q3JYYmlNaC9Y?=
 =?utf-8?Q?6In4=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef815a4a-fa21-4eff-0ae7-08dd6c878a4a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB3854.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 16:59:15.4396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sk634k/xoDl1uDRGfOvnhiuuX2ff20VP8XojOdbKdfNrPgPvoSIIlySl29VcrZsy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7673

On 3/25/2025 3:12 PM, Chuck Lever wrote:
> On 3/25/25 2:53 PM, Lionel Cons wrote:
>> Does Linux have some kind of RDMA emulation for "normal" network cards
>> (e.. not IB, not 10000baseT) which could be used for Linux
>> NFSv4.1/RDMA testing?
> 
> Linux has a software iWARP emulation that works with standard Ethernet
> devices. I use this with NFS/RDMA in test scenarios all the time. The
> driver name is "siw".
> 
> Linux also has a software RoCE emulation, same deal, but I don't use it.
> The driver name is "rxe".

For the record, both siw and rxe are not emulations, they're the
real thing and they interoperate with either software and hardware
implementations across the wire. They actually work well!

Tom.

