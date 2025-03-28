Return-Path: <linux-nfs+bounces-10952-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72EAA75351
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Mar 2025 00:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3C91691D0
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 23:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A8A1E1A3D;
	Fri, 28 Mar 2025 23:29:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021123.outbound.protection.outlook.com [52.101.62.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1884A35
	for <linux-nfs@vger.kernel.org>; Fri, 28 Mar 2025 23:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743204560; cv=fail; b=EeI4cDzk7gkSW0aKN9cFXoVmKYuPX1s+YNrjSnADSUqoVBBePb8/OWWkKtWjmgOozQtGiUz/YaJyUIzGPLa9hYLcNoI6gj6LX1U1KQP/bSuBudBFImy/XWe6Lpdwy01PdRkEAyNYn5jC2Mh1Jickn3DsANpiXodpzpkJW52x+0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743204560; c=relaxed/simple;
	bh=kanmts0cREPJNA+y4vJ/4slOahxU8lRRWVhoPmmaeYk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XkiSEsncQsfs7vi9FoZCwxiWO3MLlGvfyvM/fgMOKQItyceEuXkDdYlv9Oc35M9W51WRe9rmSDkdjTVHTiYPoLI0qm1YfG52d5O/4ZZEIxyPFuRP9+9YVTl9Xtv7LvZB70dLc/1ZOPiO+UgrA386ZMeCQn1KGzIDqBRwJ4LYfAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=52.101.62.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUj8zQ1u1+8UiZMR2h5E7nabhoHDP3yw1EM8Ulbt4Tt2diIFrZ4QBO2m3snXKxZqPEBkiB6F/HEk+MqhCplVe4bYh7u4teNbsjiBR6mj9QDoD2LyxSTQrD5Djf5WIlfJ5hX58OAjVzBc3N+TARHIKav4JtrNeO5vRMntVHdUgwS3yaOQ3FqRQUWT6DJiMJwS9kDochFv8BzxLTSuZn5Pt7mPqvj+QFyJQY/bgBpk6+iGlvnKZF0bluMiqub12MvEUNvcv7kAM0cUFbI+GIZjIwVLWgqCHoPC2ix6wzjv2L9/jG+RaPExJuPfPmNuxj+NDNBIErA/vIxBdrroGAhadQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmD14BKKhMRzMYJIeAzT60GYYln4HfHHVkDuG6S6Vtk=;
 b=eKLFOVTnas8qcSoTdSkvqCxeABR9uNMtRSXRb5rW2anpeuJZS7wHN4iitIVO95cxZF3awWkgc8I5B8yIenhooYYnwTztLTRNn7GxD8v6FimJLbaPbpETlkanyvAht8e4X8aww5mf/DMNBXxya8Dv6QG4B8PYfSn8PzfQ7/0WRqw2aiK+o6T8RZ9HKGPQR5yk4E/KG0J89k2ME0sZKFhXPz5Rqb98L0bqllo7415nyO46vrUzK+o0gdcicy5wBKRrIimIelWTHwcYlb+MCWXAO/rXecy0wF0/Tw7HQ/CIOTidb8c6ll5Kh69AQ1Yb7OovjaM1OqLkQSkTryixjLGJZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB3854.prod.exchangelabs.com (2603:10b6:805:19::20) by
 PH0PR01MB6714.prod.exchangelabs.com (2603:10b6:510:94::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.47; Fri, 28 Mar 2025 23:29:14 +0000
Received: from SN6PR01MB3854.prod.exchangelabs.com
 ([fe80::66af:6788:adc5:f856]) by SN6PR01MB3854.prod.exchangelabs.com
 ([fe80::66af:6788:adc5:f856%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 23:29:13 +0000
Message-ID: <058327d3-83b4-4b1e-8ca5-786764e218b6@talpey.com>
Date: Fri, 28 Mar 2025 19:29:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nfsd: reset access mask for NLM calls in
 nfsd_permission
To: NeilBrown <neilb@suse.de>, Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com,
 jlayton@kernel.org, linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com
References: <>
 <CAN-5tyHKrbL9DuFxvH6hnL4uwHDZ-d49X8DFBVReCvdh+Qh0XQ@mail.gmail.com>
 <174319880848.9342.18353626790561074601@noble.neil.brown.name>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <174319880848.9342.18353626790561074601@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0133.namprd02.prod.outlook.com
 (2603:10b6:208:35::38) To SN6PR01MB3854.prod.exchangelabs.com
 (2603:10b6:805:19::20)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB3854:EE_|PH0PR01MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc4c80e-8301-4df7-6891-08dd6e505997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzQ5ZXBkbXl5a1BtNWptK3Z2eHBINmQzVklqN3ZpUXN0REVzdi8ySjR2TGtU?=
 =?utf-8?B?MjJXYktaK1VhN3VhRHRCNVhlOVJpNGMwY2pFbkhTaGMvWkhGQXRWV1FOa2VK?=
 =?utf-8?B?bE81alpIc21mdGRLMm5xN3hSSXFpT1Q0ZytzRTlDbStQYUEzOHhydkVzV3pJ?=
 =?utf-8?B?Ukh5TDMwM2dPSm5WV1duRmtwQ0JxdW8rTFd4OUR1dHRTSGFxYVcycVdxaUhs?=
 =?utf-8?B?ZkpwZVk3YkY4TW5aMUZYblAzWkhDQWRjZ3FGSm5zTDBXRkZDODB4Rk4ySm5W?=
 =?utf-8?B?MXBjeHpMcHJJeWZkcDJuZmZzMHpqYlZGeVlUVXB1cEQyWTZYU0orQmR3ZGdS?=
 =?utf-8?B?cWVOUGoxc2VjTlFNdEZDL0hNcFhvbjl3QkVuaG5ocG9VK2xweGU1R3BlTi9V?=
 =?utf-8?B?WThpZ3FEYTRMNlFLb2lGT0V1RkY3T2ZVM0ZBNUUyMmk4SFJPa01yQXM0bTNF?=
 =?utf-8?B?UDZPbnpYMlppeXhEbmYrMUVWdGhFNEpnYnJlMy90ZTAvcEFMbW00OU5URlkr?=
 =?utf-8?B?ZjZOK3RNRmp3TzBieHVhcWllTCtiNlIxUUY4VmF6Qk53cWVoaWxmTnJ2YXNL?=
 =?utf-8?B?ci9RV1VQU0ZBcjVSVll0Y3FtVUlXWElOZ1JwZkxEVitrMWFwaUJhblZ4WlVE?=
 =?utf-8?B?RTdKdlJHL2JGcGtxbmVWMDU0cDduaHdlR204ZTg1M2kzZE1CSFp6Snp4MFVh?=
 =?utf-8?B?NVU1cVZKSGRZQ1dGN2tVQ3l3U0Z2MHNFM2tSOWc1ek1VbWZzcVd5NU93amo1?=
 =?utf-8?B?RC90SHpnRDNqTnFEaXhBcDZjSzBKNlJSZTUrWGY5NzN6MjZSQitjT003MDRZ?=
 =?utf-8?B?OW5lWHZIM2lvNUVzck9xRDVsblBjQnMvN3dxTXZlaU8wYmtZNTBRZHNmS3F2?=
 =?utf-8?B?cjN1VWd3RWh4YnVZTHJXeEZoTWNQVlg4am5Yclh5a29kVUV6b1NSVzFBQXd1?=
 =?utf-8?B?OXEzdlVrUGdkMGY4bUhIbnZlV2JIazF3TURYNlJGMTNqcGlMOVZncFJlNnZX?=
 =?utf-8?B?MUNrKzEwYlhXWVlkWG43dWs1emtWR0FVdjhCak1VRTRvcUlUeWlYbWFPMFhJ?=
 =?utf-8?B?aVp4TmFjTEI0ckNTUStjTjcyKzNBVW10YlUxT21DOWh5Z24rUWRtV0ZMM2kv?=
 =?utf-8?B?OXQ5K0c0M2F5RTFsUGt2dUNLdmlSNk5KeUFXR081aG8xcHpyUWMvK3k5dDVN?=
 =?utf-8?B?Y2UyMEx0VFgxVmcwMllXMDR5YjJjdmxXYzFhbmgwNjJnZDRIYmhnUHIvS2FK?=
 =?utf-8?B?R2lwKzFqL1l5NnBHMzI1c3QvMnhkT0swL1JXTmkzc1hRM1lGTDRlVmxZMW5w?=
 =?utf-8?B?VXJHRHVWcjVmZmZCeTZnWEpWeTc5TUlncXBNVGFhME96UG11UFp1UXJoTHJj?=
 =?utf-8?B?dkw4Qlh1VGNhUHRHVm5XVDVwTlJXY3BIZldFYTlzQWpXWVhFR00rQXJRRFJU?=
 =?utf-8?B?QmZES2FCcUc5a2N0YkxjNDdyM3B1bWtGM0Z0aUxJTzJKNXFXL0tXTndKTDJE?=
 =?utf-8?B?dlZBSUs5dUdQTDc3U0pLUy8ybTFCbkY1QTBCYzV5aURTMkZKRC9nN2NuRk9N?=
 =?utf-8?B?c3Z0UElVYTNtamM2TEJ0RXNEQUNhRjhxMDNyUzNoQnlFbjBrM3E0NENXRTVW?=
 =?utf-8?B?RjcveFFRMFZxWkh3d1g1aGh0dkh2cW5pUGpxUVEzL0dWVUR5WmxvWTNaZ3dn?=
 =?utf-8?B?UFhGSlJNNTNkblpKZWtlMmF6V2hOYlV0SlFORjNaUUs0cjFwSnAvZytPckE4?=
 =?utf-8?B?NEF3NGtJUktPWTF3a242UU1JYmsyeS9MT1U0R2FNc1V0V2NiMkFqZ01RODMy?=
 =?utf-8?B?YlBTWXFPa2w5RXkvakhIQ0JNaWtKS3lwMmtxb1M5b0NnSndVRFBidGlQVG9S?=
 =?utf-8?Q?A/01WdQ6jHfXq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB3854.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmRZY0lIRklBU3dlSUFVeWs1cFZhOXJ6SzhVdDVqSitwNjZjeTQ5Umo0elZx?=
 =?utf-8?B?ZitteHdydnM4MUl3djJ5dGxTU09CdDFyU1YyQlR6S3dvaWFWRk1JQTl0NDBE?=
 =?utf-8?B?eTRMWlVQUHV1THl1ckdlN0ZTeVFKM0Nldi9CVkhPMHlDVS9oN0JQV3VNakVL?=
 =?utf-8?B?aVRqWHVaYVFJZTNEQ285Vk5BeTlaNkxJelc0b05SOGp4OFNTeVRKQVZsZHhH?=
 =?utf-8?B?bmtCQkg1ZW1teUZlZHBmVzIxbGJBOUMwTVRyRVFIQjdSVXJUZHc3aEp3OVY3?=
 =?utf-8?B?VmIwTUVrcFVZUVUxY09oRTBkb0dWaUZKdFM4NEFkYkZMRXZGNTRQSmI4Wkxo?=
 =?utf-8?B?QS9ydDBWeCtpT0tEN2plN3dPR1AvaVFQRW8wMW15Qk5ZdCsySnR5Y1h2MG9z?=
 =?utf-8?B?cUZRKzZGSCt1dlAwQlRWVVZHMDNoVUlaRnRHSFl3VUc5TmdvckRpMnJFUVZC?=
 =?utf-8?B?Y2pEWUVDbVRMMzlYVHNVSlhJbGxyQXV5SXc2Q01Tb3dwRkZmNWNlNy9WZjdM?=
 =?utf-8?B?dUZ6endvNFBMWmdseGlTL3dwTm1XNE1pa3dwWEJxS1BkR2RROERlNC9CMHN1?=
 =?utf-8?B?MkJ6SzI5N0c5M0NEOEdEazRncHhJU1IrL2VtNlZlOGc1RWU3ZEtmL1JqbEI5?=
 =?utf-8?B?QlVRanJYbDdudW44Z2ZpZjdRVDRDRE56bGJKamtDQVNtcDNwdVRvWkpVNUJ5?=
 =?utf-8?B?WmQ4SjhWTnlocjdBS2pDbXNUVUdncTJmejYyNENjY3NVaGlRdFNIRmRqLzBW?=
 =?utf-8?B?bVdCUTVHOXhvQVRLZXRFVTNHRk1RZDJUenErenJKalpkc0FmTURoQzFzTmc4?=
 =?utf-8?B?ZEtpcC9MbUhaL0FoYlAwSXhtQmlmRm0rYkh3WVE5clNLaWtoRlBlWFB0dGxO?=
 =?utf-8?B?OHluZm1LVHhmVFdCMjBMRDgwYk84VGwyenIxb2U2dEh6a29ENHFoRWVJSXJE?=
 =?utf-8?B?ZEVsZWtZc3piMmsrVk5aZ3BzQ2NXVnlTdUpYV01DWVhMQ1YwK3JqR3hoU3g2?=
 =?utf-8?B?SXFnbnpzOHR1eGwyeWtOUzVXMXRDaytycTZwTWY3OGZTRk5IYTFtUW1zQWJL?=
 =?utf-8?B?b0kraTlFTmJkUEE1RUhBdDhUaWUyTmI5YlZBSHYrNkRVRUtZTWZJNGR4dkFq?=
 =?utf-8?B?UEV0Vy94MjZ5WkVBcWR6M2ZuMUxrdmtVUUlBY0pIZWx2VHp1bmwxUUQ3Q2hU?=
 =?utf-8?B?ZkJKRHNxRGNWajBIeEJvL0tZbCtiak5sRE9oeGI0MHBVNjJtbCsxa3dJc1NQ?=
 =?utf-8?B?Ri9RRndjdGEzemwxOWttTDFxSWdGYU9Sc3hFMlNtaGpIOUE2THJERC92cFVu?=
 =?utf-8?B?NW5ITWlDOTZUS1paaXExM2JYVTlYYS83MmpEeHpNRngzNGJHRTREeG9yVmx5?=
 =?utf-8?B?ell3Z3RQdC9qSkVsUnV2ekg1Mkl4dWs3cWRUTm1HbWxkcWJZektFWkJyeUJN?=
 =?utf-8?B?ZG9KYnhsZmxZeGhxWWtMWHhnNzBSWXNpVmwvT0JJRUYwU1A2NCtOWkV6YnVw?=
 =?utf-8?B?eDJpWlY5NEtwRFZKSXlwVVNaaGtmQVJOL0ZlaEQ1cjZ0ckw2SkRlbjJvOFNI?=
 =?utf-8?B?Mmt3Q0NNdHNFYWt2ckkrYzc5ZVVOYXJDRDJlcXkyT29uWkRDNGsrOXQrRklm?=
 =?utf-8?B?N3BnNTdvMm10STg4dEJxbGJ5UnNmTk1UNzB1QlpDZmswT2oxS29VRFZhM0N3?=
 =?utf-8?B?UTY1ektIK2Jmc3gzaTAvTnVWZnVFa1J1UlZYbngyWEJoYm1aQnp5WGxqdnVk?=
 =?utf-8?B?MEVpQ0dTNDVYWXpIZ1FkVVI2UHFrZExmaUlDVXA2clBDeXcwS3hOUXlOUDlw?=
 =?utf-8?B?dkQ3UjI5RHkwSTMrWW9DSENrVE5VcW1Va1R1Q0puTFZGZW0vMWIyUDNvRVFu?=
 =?utf-8?B?YkJsUzhMSDd1YW16dmloNjVoMHpzcnZhbVQwaFVHekhpdlQyRVlRVit1QmZT?=
 =?utf-8?B?NXJIUDVXTElNQXRyQXo0V1FOdzlqeGVOcG5Uc21ZWktXTUFBTEZjbW5SZ3lI?=
 =?utf-8?B?QXhSZFdBcTRxZVFUR29lVHZrUzBnQkYyMVlwQzcyK0puL0w1QjZuR0VweDR1?=
 =?utf-8?B?LzNFa0JwM0ozeTJVUkRFd0VRRWNjdUdCOTRGQU1waytCVUhNdHBrVmZGV1pG?=
 =?utf-8?Q?zK/c=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc4c80e-8301-4df7-6891-08dd6e505997
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB3854.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 23:29:13.7645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLZfdx/CtYA0DI0VQez99e04svMJR90FC9JOt0TFK0+V1HG+aeRYifA+evjJft6s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6714

On 3/28/2025 5:53 PM, NeilBrown wrote:
> On Sat, 29 Mar 2025, Olga Kornievskaia wrote:
>> On Thu, Mar 27, 2025 at 9:43 PM NeilBrown <neilb@suse.de> wrote:
>>>
>>> On Fri, 28 Mar 2025, Olga Kornievskaia wrote:
>>>> On Thu, Mar 27, 2025 at 7:54 PM NeilBrown <neilb@suse.de> wrote:
>>>>>
>>>>> On Sat, 22 Mar 2025, Olga Kornievskaia wrote:
>>>>>> NLM locking calls need to pass thru file permission checking
>>>>>> and for that prior to calling inode_permission() we need
>>>>>> to set appropriate access mask.
>>>>>>
>>>>>> Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
>>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>>>> ---
>>>>>>   fs/nfsd/vfs.c | 7 +++++++
>>>>>>   1 file changed, 7 insertions(+)
>>>>>>
>>>>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>>>>> index 4021b047eb18..7928ae21509f 100644
>>>>>> --- a/fs/nfsd/vfs.c
>>>>>> +++ b/fs/nfsd/vfs.c
>>>>>> @@ -2582,6 +2582,13 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
>>>>>>        if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
>>>>>>                return nfserr_perm;
>>>>>>
>>>>>> +     /*
>>>>>> +      * For the purpose of permission checking of NLM requests,
>>>>>> +      * the locker must have READ access or own the file
>>>>>> +      */
>>>>>> +     if (acc & NFSD_MAY_NLM)
>>>>>> +             acc = NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
>>>>>> +
>>>>>
>>>>> I don't agree with this change.
>>>>> The only time that NFSD_MAY_NLM is set, NFSD_MAY_OWNER_OVERRIDE is also
>>>>> set.  So that part of the change adds no value.
>>>>>
>>>>> This change only affects the case where a write lock is being requested.
>>>>> In that case acc will contains NFSD_MAY_WRITE but not NFSD_MAY_READ.
>>>>> This change will set NFSD_MAY_READ.  Is that really needed?
>>>>>
>>>>> Can you please describe the particular problem you saw that is fixed by
>>>>> this patch?  If there is a problem and we do need to add NFSD_MAY_READ,
>>>>> then I would rather it were done in nlm_fopen().
>>>>
>>>> set export policy with (sec=krb5:...) then mount with sec=krb5,vers=3,
>>>> then ask for an exclusive flock(), it would fail.
>>>>
>>>> The reason it fails is because nlm_fopen() translates lock to open
>>>> with WRITE. Prior to patch 4cc9b9f2bf4d, the access would be set to
>>>> acc = NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE; before calling into
>>>> inode_permission(). The patch changed it and lead to lock no longer
>>>> being given out with sec=krb5 policy.
>>>
>>> And do you have WRITE access to the file?
>>>
>>> check_fmode_for_setlk() in fs/locks.c suggests that for F_WRLCK to be
>>> granted the file must be open for FMODE_WRITE.
>>> So when an exclusive lock request arrives via NLM, nlm_lookup_file()
>>> calls nlm_do_fopen() with a mode of O_WRONLY and that causes
>>> nfsd_permission() to check that the caller has write access to the file.
>>>
>>> So if you are trying to get an exclusive lock to a file that you don't
>>> have write access to, then it should fail.
>>> If, however, you do have write access to the file - I cannot see why
>>> asking for NFSD_MAY_READ instead of NFSD_MAY_WRITE would help.
>>
>> That's correct, the user doing flock() does NOT have write access to
>> the file. Yet prior to the 4cc9b9f2bf4d, that access was allowed. If
>> that was a bug then my bad. I assumed it was regression.
>>
>> It's interesting to me that on an XFS file system, I can create a file
>> owned by root (on a local filesystem) and then request an exclusive
>> lock on it (as a user -- no write permissions).
> 
> "flock" is the missing piece.  I always thought it was a little odd
> implementing flock locks over NFS using byte-range locking.  Not
> necessarily wrong, but definitely odd.
> 
> The man page for fcntl says
> 
>     In order to place a read lock, fd must be open for reading.  In order
>     to place a write lock, fd must be open for writing.  To place both
>     types of lock, open a file read-write.
> 
> So byte-range locks require a consistent open mode.
> 
> The man page for flock says
> 
>      A shared or exclusive lock can be placed on a file regardless of the
>      mode in which the file was opened.
> 
> Since the NFS client started using NLM (or v4 LOCK) for flock requests,
> we cannot know if a request is flock or fcntl so we cannot check the
> "correct" permissions.  We have to rely on the client doing the
> permission checking.
> 
> So it isn't really correct to check for either READ or WRITE.

Just one thing to mention, newer versions of the flock(2) manpage do
mention the NFS/NLM behavior w.r.t. open for writing:

        Since Linux 2.6.12, NFS clients support flock() locks by emulating
        them as fcntl(2) byte-range locks on the entire file.  This means
        that fcntl(2) and flock() locks do interact with one another over
        NFS.  It also means that in order to place an exclusive lock, the
        file must be opened for writing.

Not sure this solves the question, but it's "documented". The text
should maybe be revisited either way.

Tom.

> This is awkward because nfsd doesn't just check permissions.  It has to
> open the file and say what mode it is opening for.  This is apparently
> important when re-exporting NFS according to
> 
> Commit: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
> 
> So if you try an exclusive flock on a re-exported NFS file (reexported
> over v3) that you have open for READ but do not have write permission
> for, then the client will allow it, but the intermediate server will try
> a O_WRITE open which the final server will reject.
> (does re-export work over v3??)
> 
> There is no way to make this "work".  As I said: sending flock requests
> over NFS was an interesting choice.
> For v4 re-export it isn't a problem because the intermediate server
> knows what mode the file was opened for on the client.
> 
> So what do we do?  Whatever we do needs a comment explaining that flock
> vs fcntl is the problem.
> Possibly we should not require read or write access - and just trust the
> client.  Alternately we could stick with the current practice of
> requiring READ but not WRITE - it would be rare to lock a file which you
> don't have read access to.
> 
> So yes: we do need a patch here.  I would suggest something like:
> 
>   /* An NLM request may be from fcntl() which requires the open mode to
>    * match to lock mode or may be from flock() which allows any lock mode
>    * with any open mode.  "acc" here indicates the lock mode but we must
>    * do permission check reflecting the open mode which we cannot know.
>    * For simplicity and historical continuity, always only check for
>    * READ access
>    */
>   if (acc & NFSD_MAY_NLM)
> 	acc = (acc & ~NFSD_MAY_WRITE) | NFSD_MAY_READ;
> 
> I'd prefer to leave the MAY_OWNER_OVERRIDE setting in nlm_fopen().
> 
> Thanks,
> NeilBrown
> 


