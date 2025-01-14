Return-Path: <linux-nfs+bounces-9200-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10829A10B89
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 16:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B706A7A0FBC
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 15:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAF4145A07;
	Tue, 14 Jan 2025 15:53:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023138.outbound.protection.outlook.com [40.107.201.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC0523242C
	for <linux-nfs@vger.kernel.org>; Tue, 14 Jan 2025 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869998; cv=fail; b=n+5LGeRDWuvLdO36kAbM8s+Vy4gk3Kb+vWb+7rQx7KcIozv/I5YI00kaf3gfWQjWShloL+VDlkcEZXAqIXbtEjZxMSSg74Q9lZqywkDvP8FfVbU6/IQYmpbyczA76kJcNJwtsaAw7D6ILjZOQLPeUzoLce7ssDVkuZFqh0T+HXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869998; c=relaxed/simple;
	bh=RJ9C3jLNGg2VWC8DWplqGsdDeQsY7S9i35n8oqbedMY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rtm9p2BCNIJIQgFBc8S1Zmgj7heiRpn6LLzJ2G/WBq6oR8sFQn4f0Ts8+1S1T4YQ+61C98rn3bK5vX4BMLMSm8XkkkZuZ6/3ysZ/g0MFEw2oYQbob3gZL2g0AD+HvBeRTkYMQH2foJwCTWuyOC2wnjcfQNPzhnVj3+aswn72vdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.201.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIURt5S0yE16pCh/kjgW+yZBRzuPoJtuX/+spf9/8tpakg+20xYqWc8hRA9YWF19YS7liSr/xO1RNvKNNEzsRw+Qk2KqXnWuUCjBdASsEZWojrFef9JSscGFv0gcNXFTI5nXipbewa+lw2lEMJwNkSu5DwIxzevk7thfpJ05/0On2mNHbVDndA9JymwfL5al+z1SDaytEPz/1X2BrPurAj0ZH1yYZqMP6VZw+lVgr/yE8FRTLehOUPyMyeBuZIrBtCsrlxq3hkD2KoVtfOW6/v14Ohc2jouU3NDp2Go4abF90wGlzsXIo3LMKrrPTzXPsnX6+xkq3YNDAcLuhaVaBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvl2qtgrSnjxOFBqFzT+Ck/qpoRNo0E06EVIanlS3N4=;
 b=WhZh7BZIQm55fE8xRVp5QqDUzynuWz1pNjEOHoQAZrCk1bUnN11/4CUjo3ZUT4VrNH8Jg0Fkfjm2651B3MGwiNoZDsHG6ZQgZ5PNcnE3cI2XUjszBg6WI0nnSgKnkCpTvTqaKH0ZKMvOwWfJr7lr5IJyzp5S9DJKMxpjwMtxL3cPbObM232J9/tdzVIuh4WB4m4ZHAlEWgaHB3939/NhAGEi32X4I+ThfmREhiBdf8hBkMdcU7cvjHtsL9XW4JO3WlCTeJy21XMB89wwPimRiD1Z1O9rpLTnLqhz0kD434VP8rui3/i2eY256olwn9vt0EcHVjGMapUcWwFuRC+7lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 MW4PR01MB6386.prod.exchangelabs.com (2603:10b6:303:76::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.13; Tue, 14 Jan 2025 15:53:11 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%5]) with mapi id 15.20.8356.003; Tue, 14 Jan 2025
 15:53:11 +0000
Message-ID: <958ed35c-ed89-4ce5-b587-c170b45a224f@talpey.com>
Date: Tue, 14 Jan 2025 10:53:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] nfsdctl: add necessary bits to configure lockd
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>,
 Scott Mayhew <smayhew@redhat.com>, Yongcheng Yang <yoyang@redhat.com>,
 linux-nfs@vger.kernel.org
References: <20250110-lockd-nl-v2-0-e3abe78cc7fb@kernel.org>
 <20250110-lockd-nl-v2-3-e3abe78cc7fb@kernel.org>
 <6c6bdf9b-858b-4a10-9317-f55aeda1ab80@talpey.com>
 <5b7b7284cb844b36ab89e77689f5baf5035f93e1.camel@kernel.org>
 <65f2226e-0e7f-4969-bc16-d4d56d2a5cb8@talpey.com>
 <5C361E33-7765-4888-BA7B-E90FC6256893@redhat.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <5C361E33-7765-4888-BA7B-E90FC6256893@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:208:52d::35) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|MW4PR01MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc761df-6929-4283-faa1-08dd34b38c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnFpMUVPMDVrUG5xNmEzZEZCVmxLUUhBdm5La2kzUnZwUmg3MXVGa3JvVzgv?=
 =?utf-8?B?MVVJbEZZRVZTK05CTE5wWWVTd1oza2dVSkpPL3lsN01ub2trdFE2NFZUVkhH?=
 =?utf-8?B?NjMyLzUzTDd1UlFNR09XZGJnWWwxaTNpdGhMS2dSOGVLUnhTVjZqbFJwQjFY?=
 =?utf-8?B?MEdhaFlpRXJPMjVnMU1SVTNWVGo4aHIrclhRbHNJWW45R1NGNTRna3hRNWZ2?=
 =?utf-8?B?OEc1RGJjQkpOWTU4Y3BUTVJlbkFQVFE1UWFQWHp2dk82ODhHcEM2RHgyMDlt?=
 =?utf-8?B?RWFIeWowWVd5RE1uaSt2NnMwNkkyM0tWcFYvcVVKcEgxUExRL0ZMZGhreGVP?=
 =?utf-8?B?RHoxanpveE9pT3hCOGozZXNGaVcyUW1leG9jZVRUSTl0c0JCMklaTXJsZDd3?=
 =?utf-8?B?T2RURFgzTHJrWm43RTZOWDBRZHFQZXAwb2YwSVp2U0xiMFN4eGFCa2t1WkIy?=
 =?utf-8?B?ZlNXWVQyUVNkdEMxNmZiV2x4N0RWQ2dnTnZ4RjloWnRTN1J6dFpVQUw1SjRB?=
 =?utf-8?B?NGlpRFZaSVpGc0JWN0N0UjZ5bWJ5bmY1YmRPb3N0ckxJWGFlRDY5bWVBaGN4?=
 =?utf-8?B?S2dqVTVLeGYrQlBLUU9iWGNyWXpqSTJvVWhQWlpjRU5XQXMrTjA4MFJXTzA5?=
 =?utf-8?B?Vnk3K2tUTG9kblI0enhVUXZIWUxIT1BxZFlzc2VJRUpTNXZ2emZ4VTVtcmNj?=
 =?utf-8?B?ZlV3ZlZwYTN0T1ZyQmJRc3NsNitneTE0Ti8wblFGQ1ZhZHc3TDY1UzRNcmZj?=
 =?utf-8?B?VmE5NlJzbldxTjA3RzFJRW0rNzNCeHhYTHRQL3Z1ZDJESDVTSnBac0todlla?=
 =?utf-8?B?N1VnOEhiRG9uNFRRY2N3YjdUZ0J2ak9BQUlBWjkwdVNkTzQvZzFHaFFDYWxB?=
 =?utf-8?B?dm0zYzR5OTVxVEFhcHhGV1JQTDMraExhVC9TVW43dzhjZkdSRGhGcG5qOXVx?=
 =?utf-8?B?dFFzY0FqUkQrYkZTdkt3OTJYbDJ1MTJnZkdDZFRNSmRxcUFpL2Z4eERHVFFl?=
 =?utf-8?B?Wm9JblJVOXIvSWNjTTdYdDQrRUZ2dHVUb3N4Yk9lUzFEMXprYzVzTFV5K1J1?=
 =?utf-8?B?b3RyQWpBZ0tVcmdEZmlzQVRQby9RZUR3Q2RDNnhJZ2FEVmNNNGxya3hBZDg4?=
 =?utf-8?B?cDRTcElrYmN6UTZqemRlUllic2Q4N1lESDJTT09QQXhEb3o4QjFWVi82OVl5?=
 =?utf-8?B?V0xURmlrZ3M0LzBranZLQnlxcTRzaFFUeFdYZG1pczE0ajI3YjZkcm5DdkFv?=
 =?utf-8?B?ek1zYXNGUTBWNnFha21WMUk3OWlvQkJNU1ljKzZYWkZtNFVIc2F5UEQ0UytD?=
 =?utf-8?B?SGpzQXpjTStNa1BOekNybjhFWjdCeWlaRnJJVW9rYzRUQXc0RW0rY2VxRWNy?=
 =?utf-8?B?SnI1QkxqajBaTXdvU0J6YUt6eDJ3VFRUQXQ5TlFJRHNneWxLN0JTUStIY2R0?=
 =?utf-8?B?NkZoODJXUVhzTjFycTVEU2lKWkg0SkJ6QXlKelk3SURRWVhrWmQ5eHN4bjZR?=
 =?utf-8?B?RnZGNThPR3I4Yks2YVlobFh0K1VrZi9xV2VrTkdkNXRkeklSdnBWZEY4eTBJ?=
 =?utf-8?B?WUx1T0RFWVlBU1dYd1ZhTlZQRW9pNWNhVEdLeGx3TkZsQ0lHYzgvOG9acUJ2?=
 =?utf-8?B?dlM1THdlTWQ1WWlrRW05YXlORHpDbnFDWDUyRWppNHhCTzBRUGU0blZmaGl0?=
 =?utf-8?B?ZlN6OVBCMi8yRGs4b3pDUzJwY1k1UE1OZmord3pYZ1I2NHA0bFR2UnJFSkIv?=
 =?utf-8?B?QjhLYnpNNHAxUDNLMUdmc3pZNWEyeS9kVUlXbzBpNWpyT2NTc3ZDcjhnT2dv?=
 =?utf-8?B?VWRkeWpuWVI5V3g5Q0FhT0RJVm9qZ3hUbEZJV1o1bVJzS3RoV2laYUVLWkNq?=
 =?utf-8?Q?wF04vcYVTtnH6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU1iMXYxdTJvS2FBT1RlNGhIbjRUS01DbERVeVhpelFDd3k4bDN4dTFkMEgv?=
 =?utf-8?B?alFTYnZQMHVZRUd1ZndRb3kxdzVvT0QwNFFMMFZvSHo5RG1MdElxdENaRDND?=
 =?utf-8?B?T1Z5UGkxMFcrNm1ra2tYcTY1cDdvbnROL3FzOVVmZ0gwYkhCQ0NxNGEvdFVk?=
 =?utf-8?B?c2pxTkpBa0JHYThnMmhVamc1bWxEWXpleFJsVFh4SjJCaEFEUXNNSm0xaDI1?=
 =?utf-8?B?TGFiQVdSUmhjZjEzenJMQjMrcUh6Y2JHQWQxNGNQMUFPeVl5bTZDNDl2Ynk4?=
 =?utf-8?B?RlhzcEpOd1NENWVWRUZzREo3Mk53V3ZvUkhwRzZhc294Wk02Qmt2OFp5TVFH?=
 =?utf-8?B?dDM1MUx0eUJndlZOTzRIN0x1ZzNLRUZ1UVlMS1dzNk9KbGxtbkF2VjFidUgx?=
 =?utf-8?B?MXZqSTNLbURIeG5QZm9LR3RvY09jeUszai9ReWQzaFlycFdPRUl0VGE3ZDBP?=
 =?utf-8?B?WnhYVXJSYnk3ekJRdzh6RGJ6VjE2RjNaUFZidk5BbkhxNDhnNjJodzZkL2Vj?=
 =?utf-8?B?YXFab1gyOTFUZndUMEZBUnZHOU4yVm1DNGFqYXR6MFM0ZnFYdVJOdHhOMmNm?=
 =?utf-8?B?QTNHaFJqaWROOXM1bndFK1RsUXR6MUowZjZqOFJYd2hwLytETXBvQ2lYaTZx?=
 =?utf-8?B?M2llaDlNQW9HdWF5K29kbW5iMEgrUFI5S1prY0F4blRNa1pVZ1RpTzF4dzgx?=
 =?utf-8?B?SEUvS2xKMlk5NjBCTG81Vk0zVWZvczBTdzNUMUU5WkpNdGo0ZFdkcmVySnRF?=
 =?utf-8?B?a2hlWDF3V2VHcGJ2enRScHJGV3JHN2RzdUg5dksycEticElWK3YxNHVsQlEz?=
 =?utf-8?B?ODkyelRNdXpGK21SUGI2a0ptd0I0RG1lTmh3NHVYdUZ0bWJmZ1hIZ1pEeXBo?=
 =?utf-8?B?Q2xYT2FhdWdLM0E3cDFLdTk2RVJHeGZDdlVZaEVBOTZCc1FrdjQ3cFVYNjAx?=
 =?utf-8?B?WG0wVkxiUGlIa09vTjVqVDdoNzhJSmJ4eHVKb2E5V012UW5oU0s0Uno5ZDNB?=
 =?utf-8?B?WkFOY2ZYRGpaT1lkM1RDMVg4OU0ra3JjbjVzTTU2NHNZSEFpK2JwL0toUkVu?=
 =?utf-8?B?QktLRVVOcmx6b0tuQkhxc1ZmUUxXbTdJdGpoV2RIbCsvZEwxejlKYW1uWHRv?=
 =?utf-8?B?K0krK3Z4Z1NSMDcwYjlOTW1NbWtFeWpQbnBrVkZ1TEs1SlFnMG11YzVmRUR3?=
 =?utf-8?B?S0RRSlJrdXI2YkprQklONzIxc283ZTZHK2VzRkVrdGxuekl5eVdzYWIzNno2?=
 =?utf-8?B?dXZDRmE3cnUxcmJ5dThUOGtkMUNxaEVGRVdtSWNQSVlOa1pPRmg2clZrRDRi?=
 =?utf-8?B?bitMOUNhVFJDWHJJMzV6THpoaWxjTW9QV3hXbWNsQW9ld3AvVXFaRjA2aEh5?=
 =?utf-8?B?MVBhRjBGYmZGTXY3UFQ5M2VpeVY2STRUTVN4a1ZOdVJZNmhWT0R3YUFPamFL?=
 =?utf-8?B?bzNMcWo5NDN0TSswVjZOckhKSWN1OUkvY1crVW1EUHVvVjhpd3dTU2ZtUTVS?=
 =?utf-8?B?dkZPemlKY2RQOUNBNDJtR0hDeHdZTkk0Q2VwWnhQZXRWeWNYL1ZKS3UvdFdy?=
 =?utf-8?B?QndEVE5LWVRsT1Q2SGpQSnMzM1M5RzBGMU0ranhJM2ZlaUxETk1oMFg4eDBP?=
 =?utf-8?B?QXNycFZ5QThJcGc1c1JDYzIvODBUYVpKWGVyaHNpVWVwSFpIamc2QTUzdXRM?=
 =?utf-8?B?amVza2RDY0hwcVdjQ1RSWUdoVG1zdWUwVVIrM2gzMkRyWXI5ZXM0b2lYaVFo?=
 =?utf-8?B?czlaQmVZKzdhL0xSSU0wWWZLU0xocXZnMUpVWjFjdVk3Z09rTkdLbjNoVU00?=
 =?utf-8?B?TDlhUlVBNFhpTG5TbGxXZ1JwcFk3aFJFUHN3SHhGaktFRkFNQWxNM1dYYXFY?=
 =?utf-8?B?ejNaQXB4ZGwwUTJ4N1RseHBuQ3FTcHNwQVVZU01VanZFd25QZm81dEI3NTEr?=
 =?utf-8?B?dE5HaUVYbWkwZ2FiV0tiK2VyaXp4YWdZMjlvbnFFRWVRTTNUcW1qTThuQmdB?=
 =?utf-8?B?d081TFJMcDFDbUZ2MTlNZHl2d1ByOWlPRldYNWRpUDF5UlpCVnZlVkIvaFFQ?=
 =?utf-8?B?NTg5L3VsVHFOanJlTzJuRGFIVlREYkVyNEo1eWh5QW8rbCt3a2dDb3BETlZF?=
 =?utf-8?Q?VKwo=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc761df-6929-4283-faa1-08dd34b38c4b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 15:53:11.5507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cp2zwfThHr20GJyCSc4UY1NLMJ34wTMfLD+/buuVl+YHTl0KyBhJl5gfnYnyHaTl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6386

On 1/13/2025 8:39 AM, Benjamin Coddington wrote:
> On 10 Jan 2025, at 10:40, Tom Talpey wrote:
> 
>> I wonder how many sysadmins are actually changing it, and why. It's
>> not truly a correctness thing, more of an availability setting, so
>> the choice of value is pretty soft. As you say, if the clients all
>> reclaim promptly, nobody's the wiser. Do we have any data on how
>> often the setting actually gets used?
> 
> Here's an anecdote - when I was a sysadmin (~12 years ago), we were very
> aware of the grace period and tried to optimize it because too long meant
> many of our clients applications would hang for a longer outage, and too
> short meant that all the locks weren't recovered.
> 
> We also depended on lock recovery working well because we would often
> update and migrate servers.

Ok good to know - v3 and v4.0 I assume.

> This was before knfsd v4 could end it early, which is.. quite nice.

Yep, v4.1 RECLAIM_COMPLETE, right? You're welcome. :)

Tom.

