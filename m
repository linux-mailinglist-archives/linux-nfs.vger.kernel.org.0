Return-Path: <linux-nfs+bounces-10026-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75986A2F671
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 19:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F9217A203C
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7E31BBBEA;
	Mon, 10 Feb 2025 18:07:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2095.outbound.protection.outlook.com [40.107.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D95025B66E
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739210830; cv=fail; b=nXnUkKYYUcGB+Ojq2r8TXQbSJtKEIhAV5VQWyCW8CcBXV6fWavFopKRLskUa6ER+UD9q2DHe2iOGkifcjQRxTyp7x/46Ww2G24pIvk2hneQesddNM8Yie7ovIoi6+ZuskuZiTpN2zPAJG3S4P3fxcgacTLr2X1aeJ79n3tIAVlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739210830; c=relaxed/simple;
	bh=8BGqE2+/LRzeLQocGlpNOtqWDxx8JJBPEOn0qXFLgAk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pTo1eT52cSB36eN606o64ZcAz64MttOObJvlrNO+MlaxQf6weq1ahde6U8HceoEIjklchM+6ePBruiznz7bwK6Du4RbbG87RZWCAgJqoJM+PvLhZuoZbzXtZRd8o1AAqEkoI+JzZPCPVOUyRLp2bI6BkDmShSLvZczHBtGSZz/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IK0/fOpXu4c2La86ZpbO81hT+UsKDFnoLcYe145AWhuZLSj8vgkJmr6m2AW7aZEPC0caWJfICeU6W0BB0qJGwxK5Rkvfwi2U2bvtmpvNTlX0hulXYK9vKZC/L9qSR1pTxBq944f9MA66NKh5yaJ/ohQzVtOk+fxfk1KUrJ40n7y8NmjQfPjQ+bMVxUNTGV9IH2AYscRfAKMjITityOH5cNv0NURn1n7RVbhkOhlEEKT+wUiIC0jZwD06vnSU76PYOTzQsPsN42P/dHyTXOmYHAMt7hwwq5n/xxqgT8hI67HpCsHHniAaaRQcYVG4PezpLg+0eoFceS7fEV07QBQYfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8H+qV9ne7gHxpeAVVjBtXWUUfuQk42yL2p7oH4f1oU=;
 b=RnwmL8LD3YK0js9KrBJsGqNQcEVG44C6g+oBvR9LjBvv+WLX1zzK4zHVhhAG1o+UQzMeMnLh+ZPKvBkTfPIqoUXZR2EF9sTS4Vt1kq8umbZsiXaFQWwd0iIl7nlMTA1Q3O1OFg0U0gxyDJxi5PrHy5UC0Ru7r2HOCktQ6SuZn9VYtD9ZUpR6q76r+jNoJKC5q4YBngcz56HWnxiBxKvbaDfSUQnphf0CNat1F2ljSlvaD6bGcPUBIDzu8A1KzMG+y81DdxvgfHWLs5S0HAw2CL0VHwbvcUqLoi+TFzGjpDaiubgXaorMJeXk7ajVt3Vb4/hdlJJlGPnOItkPL8PQlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 BY3PR01MB6593.prod.exchangelabs.com (2603:10b6:a03:356::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10; Mon, 10 Feb 2025 18:07:02 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%6]) with mapi id 15.20.8445.008; Mon, 10 Feb 2025
 18:07:02 +0000
Message-ID: <e937d6d9-9d58-4c09-aeed-9b7e676d8799@talpey.com>
Date: Mon, 10 Feb 2025 13:07:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: resizing slot tables for sessions
To: Chuck Lever <chuck.lever@oracle.com>,
 Rick Macklem <rick.macklem@gmail.com>,
 Trond Myklebust <trondmy@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <CAM5tNy4f9YyMhYRydudNkCqzVp5f8Np6N25NOT=-+TjJN2ewqg@mail.gmail.com>
 <884876492c56e76fd6fbb4c5c4fb08ee14de9fe1.camel@hammerspace.com>
 <CAM5tNy5yv1CkVc3z0dTJ_Fed9mP-ZBug1L39Jnau48s=OnSPvA@mail.gmail.com>
 <a9127b76-29f3-4782-ba9b-dff1ebf6f647@oracle.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <a9127b76-29f3-4782-ba9b-dff1ebf6f647@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0536.namprd03.prod.outlook.com
 (2603:10b6:408:131::31) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|BY3PR01MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: dd23b01c-9fcb-4f64-8c7d-08dd49fdb839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eE5aT2FQeVhFWTBrLzdoNlNlc3JDckwxQXJMakhKTXkyYWw4YldEZHlrYTZq?=
 =?utf-8?B?bDErTEYwTFQ0bHVxVVV0SXlYOHl5Umo1dTRUd3BGWTAvUVNhcjA2SFNaSjhT?=
 =?utf-8?B?NjNyeGQ0MTYwVmxZOEx3SU5haFBzN1I5MmVzdysvU0ZWUjh3VGNCN1NzSHVl?=
 =?utf-8?B?dzZoV3dRQWh2NWVnOVlCTk5EWGdTTkhrYzZaRlhndWxERTM4Zy9Bbzc2VWdI?=
 =?utf-8?B?NnJwS3IyamFwNkxGSEdneTRsVDF2Y2dpU0JTeWxpOWZmVGN0dGhCNGViOWVy?=
 =?utf-8?B?eDNyakhHVlFIUE9Vdy83bGFkK1FpRFZ4azR5UWxMUEc5c04zc0lzeWxoWWdF?=
 =?utf-8?B?eE1EWVJkZ1RGNngvYjZkTHNvaFFpL1VIWU9WUDQwMWhKOXB6YklXdS9nUGhy?=
 =?utf-8?B?RnhEUk52S1lLZEJtWm8yNUwrZjBFWkl0T0NBNkFoMTVncklHS0RRL3piNjB6?=
 =?utf-8?B?MjJ1UlQ3RC9xdzhIYkVSOEVCYnBkU3dXTHN1cSs1OTBxNUJlYjBBZ083dzJT?=
 =?utf-8?B?NGg2WU5vVHpmQWJlZTRZdTJnL2JCK0x6SmdMQWtSNTZjMnJ6T2FCaWdCMXA3?=
 =?utf-8?B?cXh6NGhQbXBVcFc1M3F2dE4reDlLb1NaOU1LVUFNTVhBVTJXMExRRnIwazk2?=
 =?utf-8?B?eksrR01ia2RHNjNiMVhXZEprczQ2WDFoL1BYNXg5andGUHlVMGhHbSt2MEF2?=
 =?utf-8?B?M0cvOTJsOTNvdTd0VWlKbWIwRjhjejRkSy9lVHI0b0ZnU2ltL3Q1aEoxS0xv?=
 =?utf-8?B?VFVtRU1xYklkU0tieDdvZ0MyS1RDNW0zMGNPWlkvVXZIcGF2c0VJclhyZDB1?=
 =?utf-8?B?SHkvem8vRU9jRU1WTlBNMVdTSDRRdHZsUzZiUEczMlBKMzIzenhNYmVRZ3pI?=
 =?utf-8?B?S0oyaFM2OFNaZjU0MnR0WnY5MXI0ZmgrVlVMNTdCNXlmaU9ndjU3T3ZQMDl1?=
 =?utf-8?B?M3lLMzFiOTI4dWYyZy9YRnZ6L0hORGVPNG9wZTIybUk0UDArQ1lZaEplODJ3?=
 =?utf-8?B?MWRrc0NTenRxVE5DRnFTeGkzN2VBczdKTWlCcTFUV21kS2dlaDlOajM1TFV2?=
 =?utf-8?B?QWpGUjhsc1ArWlRJNHV5aDdsQk4zdFJva3FaUEZkM1ZNbFNveG1EZzRVd25L?=
 =?utf-8?B?YTRmWWF0cXNJNERuWEwrWFNzTmc0b2NFcmxJcE5oVWZHNWZObnV0T1BJTnpS?=
 =?utf-8?B?a1FLelQzOFJMVjV1WlZSNmNLVnNUOURXZDhaMFVzRzl5Nlgyd3VEMU9jQ3hZ?=
 =?utf-8?B?bFl3ak1kUW5ULzF3aVoyTmNFZjZxM043alRxcW4weEtjdFNObEJxL2xpc05z?=
 =?utf-8?B?Qlp5Y2Zpd2oxV2JzaUROSFZjMVZPUlFFcUIwZnhYRkJJaDZMUEVLaWtnTEJK?=
 =?utf-8?B?T3dkcFpUUWVJbFF5L3U5QURMNm91aVJoS0RBVDZlMmYvOVJ5WDhiZWplcURr?=
 =?utf-8?B?ZmJ0WlBsZkU0bHZUTzUzcUdDVUpXRUUxRWFGN3lTaTZ0eVp0S1JrdFdFdW5r?=
 =?utf-8?B?VlVxb1FlU2JPaW03SGxCYUVjQ0cyS2drZ3VsOVpDR2hMVkx0Mnpvc1EyMmZO?=
 =?utf-8?B?cVJaM3BYS3BXSmd5bGtOUGFUVUtVTW1UWHZUVUdmUXRPc0RqWTlMeDZENlFP?=
 =?utf-8?B?aXNrV3Vxa1B6TmUvUUpzT01OYWZGSExNT2w5YmRyY3RJcHRQWjRXQTNBc2Fj?=
 =?utf-8?B?bTBqTUFySFZZNDYvSzlHUE9Ib05WTWd2eVJmWnNwUzh5T014ME1ycjBOK2Jq?=
 =?utf-8?B?MHcrb0NzTlkvNmc4bXE2Y2pLV0t0cEtNUFMzc1ZlRS9ZL09TS1dJTG13VjVP?=
 =?utf-8?B?NWtjR2hIRjdZZVN1T2dOczZyVEdSUzdKT3YrOFl3dEpORElIaDgwUDVNaWVT?=
 =?utf-8?Q?W5cy+qMHhN0I8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0FidU5WUzdhWS9DM1hXdElTT0FWaGE5eDRMRmVOa254VzRWSndnUEhXRWxO?=
 =?utf-8?B?MGl0aHVKQkxEUUlFS0hXRGRUOHBIWVI0ZHRSQk12bFgrQVFQTVo0czVaeXRu?=
 =?utf-8?B?YUJlSFVwVXl5RzlPNzNsZ3BSMmpqTnJ0UEFlU21iOFZuZWM0bytuMEhJbzRG?=
 =?utf-8?B?dUxhVUUxb2QwdUJNZHFHOGY4Tm9hcWF4UWJ3bUtmaE1KcTJGdlFDN0JFRmNX?=
 =?utf-8?B?QkhOT2VPd3J2a0d5MWt5Q3RRR3o4WktXNUhVb0F5N2lwSHdXZFB3UEswZHAv?=
 =?utf-8?B?dGFuN083YVRjTXdJSHU5MHcrMEo5dE1MV0RyQWRDZStEYmJySStWUWN4b0tx?=
 =?utf-8?B?d0xTa3FTR05nVjNhMGR3QkJ0SXJSeXNQbVArVC9WUFJhQ0U4Z1JWcjJxN0JS?=
 =?utf-8?B?KzVEVFJJTjVqS3dXN1ZYZWhGM25GU3A5bW8vQmVNeXVFTVZGVGZkVmNVTEpK?=
 =?utf-8?B?SVNkbm01cENjdjVkTXEzN2xBV0d5RjNrMGQ4Mi90YnhwNzZCVWR5ZzlWMkwy?=
 =?utf-8?B?VnliWXoyNVpkNzVCNnQ5TGVTdzFXQllOSEhobWd1MUtpUDA5Njc2eE1sM2NC?=
 =?utf-8?B?Z2JSY0U0K002Qk1OVEx5cHM0aDU4WmVxWVRvSHNvc0J5cStRODZzSEVxdkQv?=
 =?utf-8?B?ZS9WNUhFb251bmFBelpNaXU3SGJ5a2pJZk85dUp1RTdPcGR5S2ozRkJ2cEdE?=
 =?utf-8?B?U3JLUlQvUDAvTktyWkN3cDNuMG5NL05pQTFEazAvOVhOSGoycFRFT2lJZ0RL?=
 =?utf-8?B?ZUliSHdFYVN2Zm11MU9zdlJURGUzeFZOekNoYmdoNW8zajltUlRDTkdKc2c5?=
 =?utf-8?B?c25nL0NtK0NUV2QvVmNuaktLaS96aHd6Nk1kUzE0NHVJK0VRUitOMCs3ZDNn?=
 =?utf-8?B?UHRUbkFsWUVpV3lFVGNTOTYrOGVNRGxCR2hkdUswdU9HV0x3TVh2eUh3cmVD?=
 =?utf-8?B?dXhYUmMzVDdMZFkxWWVaM01RcGVaUkNTY1cvK1p0TFlCT0ZPNm5BOU5zQmhk?=
 =?utf-8?B?NFE1bG5OZWpZNlBnSjBnMjVRUjNSeUp3SjJlaFNZUnR5TFdlK1ZlNzZwUXpZ?=
 =?utf-8?B?czY5YTFhbmkxczFPWjgxSjRUN2pnamVLVzBOdHNFeUJVamM3bHV3WW9MOGNo?=
 =?utf-8?B?Sk9sVUxFY1BPdXBpSEpSaGNBT1NVQkhMK0V3emVRUjBCOUNxSTlMTk92UXVz?=
 =?utf-8?B?Z2k2VVh6UXFta3FaZ0ZrSWlSN0REQi92Tjh4R3FFNGFmaEREeGs0bXhjYVY2?=
 =?utf-8?B?K1p5bUZjWFNiSm0rczZuRWt2bE05a2djeCtneDRGTm42MlVtR1RCa1MwT0VI?=
 =?utf-8?B?bkZ0aVlVUGUyUGRDNVl0VEM1M2pQVTYzdUVtR0JkTk5xTGlOWnBUODROVnV0?=
 =?utf-8?B?NFhJQ3NuK1lsNjZUS04xUFQ1NjJrRzN2WE9tRnlJTzh4M1dCMVJjeWxYVndq?=
 =?utf-8?B?SmNVV3dQUkJCdG5ITEVQbFZ2Z0E2aHIvTWlOb3IxeFBNVHZTbDNwbGV3Si93?=
 =?utf-8?B?amY3Y3k0dTFrRE5BcnBJL2dHRDVSakFVR1NPR3lrdHNrc2p4TndvLzlGM04v?=
 =?utf-8?B?aUFqVlBzUXBCRWd0SjA5SXJLV2RhLzN3Rk12TUtYTHhxNUNGMnI5bGFJamQ4?=
 =?utf-8?B?Y0xLL2JNTWI4QUFZTjR6VlR2dmhxYU04YzM4RTI5MmUxTWplMExsaUV4U0Yz?=
 =?utf-8?B?aDBqSStOdTVtTjJEZ2JQNzFnNjkveUEzTmhSTU1KMWNFMlRwMzZFeklyczF0?=
 =?utf-8?B?WHFHYUN6Q05pY2d0ZFNsdjM3RTd0L2syMlNpUmxPN1RRZUFOR1pQR2JwWmZa?=
 =?utf-8?B?UlZmbkVLUEVYQ24vRXpudzFQdzZ5NVgxb1NKWEQ4WWFCcml4MnRkb09CZHAw?=
 =?utf-8?B?VjZhODR4NUZxYmRmblBjcnVXL1pSNGNSemVaTWxUY2hFckJqcnF6RVdWZFNp?=
 =?utf-8?B?Umh1RXJJVDQ3bFFsTWxMRFd0RkZFTVlKMW9KNVQrS1pRKzVldmU4Zm40TEJ3?=
 =?utf-8?B?b2hnc2ZIdXhPMjJMblZvelQwMzRlNUVGVW1jTGtUNmg5cWdhUUtWaGk5dCsx?=
 =?utf-8?B?TDV0cmVnR0dENzNtTUpSNzhQTzlLSjdINTNGYTRYUnpTQTNHWGdEUW43emdG?=
 =?utf-8?Q?iSI8=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd23b01c-9fcb-4f64-8c7d-08dd49fdb839
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 18:07:02.4248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRPSdRpBCZVZdyiJOUtz8njO7AvOH+UzVsY+l4r6TV/Cu7mTjZDBwOWCFBWhTFI/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6593

On 2/10/2025 8:52 AM, Chuck Lever wrote:
> On 2/9/25 8:34 PM, Rick Macklem wrote:
>> On Sun, Feb 9, 2025 at 3:34 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>>>
>>> On Sun, 2025-02-09 at 13:39 -0800, Rick Macklem wrote:
>>>> Hi,
>>>>
>>>> I thought I'd post here instead of nfsv4@ietf.org since I
>>>> think the Linux server has been implementing this recently.
>>>>
>>>> I am not interested in making the FreeBSD NFSv4.1/4.2
>>>> server dynamically resize slot tables in sessions, but I do
>>>> want to make sure the FreeBSD handles this case correctly.
>>>>
>>>> Here is what I believe is supposed to be done:
>>>> For growing the slot table...
>>>> - Server/replier sends SEQUENCE replies with both
>>>>     sr_highest_slot and sr_target_highest_slot set to a larger value.
>>>> --> The client can then use those slots with
>>>>        sa_sequenceid set to 1 for the first SEQUENCE operation on
>>>>        each of them.
>>>>
>>>> For shrinking the slot table...
>>>> - Server/replier sends SEQUENCE replies with a smaller
>>>>    value for sr_target_highest_slot.
>>>>    - The server/replier waits for the client to do a SEQUENCE
>>>>       operation on one of the slot(s) where the server has replied
>>>>       with the smaller value for sr_target_highest_slot with a
>>>>       sa_highest_slot value <= to the new smaller
>>>>        sr_target_highest_slot
>>>>       - Once this happens, the server/replier can set sr_highest_slot
>>>>          to the lower value of sr_target_highest_slot and throw the
>>>>           slot table entries above that value away.
>>>> --> Once the client sees a reply with sr_target_highest_slot set
>>>>        to the lower value, it should not do any additional SEQUENCE
>>>>        operations with a sa_slotid > sr_target_highest_slot
>>>>
>>>> Does the above sound correct?
>>>
>>> The above captures the case where the server is adjusting using
>>> OP_SEQUENCE. However there is another potential mode where the server
>>> sends out a CB_RECALL_SLOT.
>> Ouch. I completely forgot about this one and I'll admit the FreeBSD client
>> doesn't have it implemented.

The client is free to refuse to return slots, but the penalty may be
a forcible session disconnect.

I agree you've captured the basics of the graceful-reduction scenario,
but I do wonder if nconnect > 1 might impact the termination condition.

Because nconnect may impact the ordering of request arrival at the
server, it may be possible to have a timing window where one connection
may signal a reduction while another connection's request is still
outstanding?

Tom.


>>
>> Just fyi, does the Linux server do this, or do I have some time to implement it?
> 
> As far as I can tell, Linux NFSD does not yet implement CB_RECALL_SLOT.
> 
> 
>>> In the latter case, it is up to the client to send out enough SEQUENCE
>>> operations on the forward channel to implicitly acknowledges the change
>>> in slots using the sa_highestslot field (see RFC8881, Section 20.8.3).
>>>
>>> If the client was completely idle when it received the CB_RECALL_SLOT,
>>> it should only need to send out 1 extra SEQUENCE op, but if using RDMA,
>>> then it has to keep pounding out "RDMA send" messages until the RDMA
>>> credit count has been brought down too.
>>>
>>> --
>>> Trond Myklebust
>>> Linux NFS client maintainer, Hammerspace
>>> trond.myklebust@hammerspace.com
>>>
>>>
>>
> 
> 


