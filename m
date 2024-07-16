Return-Path: <linux-nfs+bounces-4957-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 866C29330B0
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 20:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C901C22AD2
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 18:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FAA1643A;
	Tue, 16 Jul 2024 18:50:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021115.outbound.protection.outlook.com [52.101.62.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29861B94F
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jul 2024 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721155805; cv=fail; b=A1YeyBMZPYIPpguLumO6u56jGLOAInCn/dj1gEhYyWu2n/fSGgxZ2vGoozlHdwT64Ast603a4EypnfIUoI1HjvLnB4Qme7etT0SHVKnnjG8d6kUWDRvlC16GaVdSHkxbaeznh9Lh28msi5/LHbLh5z9S+dPhyQqvfE4/MFx4d0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721155805; c=relaxed/simple;
	bh=GZ9sSZdzoic4matIPyX4iNpt0W70+UgfD7xVPKitIKE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ktv/CdenNpUVPNxj+MYL23z4FPMSiB8pfeynde6yLs1FASc1x0dcbFWt6fuW+zTgq1qVoEIBK9+fiq553LWhNSAWrKfMPsfgFqijmV8IwJP0yRITwD5UdFvNc5M1FmbfioM/5xVOE3U+eN1vkLWyJk5KbLbHz14BJDARAPX8Gfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=52.101.62.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crDgDPLXU2jLg2qZC0SdNqFTgfGBOSXCBZsaXhspqLHV29KlfaXtSk9n5FN+ae3iudV3YEdijsLGhd0OuZZ7AZLyZlSu5gXBLJXbchhOrtSaHS32CEhuO4GZ21s0ycaNWLBS0oCuqXsAqBqaNnMdqEEmZfZiD+D0Dxz+XmMU/C9/OtKN/ltpl2LP8VBJ6uPMnsBwZh5hurc4VXEwQE6baRx3wMua26FFqXa8BgWRxwwBd5QWid+X9N1FvFcXutzzu1YtnPJwpt6ZQPGEOdH2GO0eQXvtyQtpj9O3EJgRvVN8Yyf1/QEBKzE2HaKpnEhMKEY36jAfwwQ99t9L+AB+WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vX9TmyRIsVu+XhF0/t9lwOWlMQn8FFyWBim2yOqtpK8=;
 b=bkkctoriIup2OVpoDI+w1PnGEA591bsRsTbMxQa66anWqABKdwbuzXa/nG7UXbzR3TTBP12m4/eEzxw9ekeXmPfeVRC8762sFW2cXH13euHMjznG8mnoTE7eCWdgjGlwgWzUxT8UAtI41VL+MSVVKeV8vx1ZpPRbMNy+WrY/rBs6WWKeDCtOeFxKUmJHGb4ptb0C3AJg6jCygeWS7znoeocjvLnNhk56wwE3foPlfTwC3TEULh/MeUF+fTwXuM5VLiHj7gE8HhsQm3egnse85HDFHQDpehxUGB2WwRtWl/pZI1imWcDZxnmESHGO1KC8O109n+FJabQO3GWYkVlJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from CH0PR01MB7170.prod.exchangelabs.com (2603:10b6:610:f8::12) by
 BL1PR01MB7531.prod.exchangelabs.com (2603:10b6:208:386::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.30; Tue, 16 Jul 2024 18:50:00 +0000
Received: from CH0PR01MB7170.prod.exchangelabs.com
 ([fe80::97c:561d:465f:8511]) by CH0PR01MB7170.prod.exchangelabs.com
 ([fe80::97c:561d:465f:8511%7]) with mapi id 15.20.7784.015; Tue, 16 Jul 2024
 18:50:00 +0000
Message-ID: <05ab9c05-5d5d-4e51-9e38-7df1c2e60c28@talpey.com>
Date: Tue, 16 Jul 2024 14:49:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] nfsd: introduce concept of a maximum number of
 threads.
To: Chuck Lever III <chuck.lever@oracle.com>, Jeff Layton
 <jlayton@kernel.org>, Neil Brown <neilb@suse.de>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
 Steve Dickson <steved@redhat.com>
References: <f12bdd8dde21de4473d38fada67b60ef5883e8dc.camel@kernel.org>
 <172110007383.15471.14744199179662433209@noble.neil.brown.name>
 <27b282045253419857b67f3240ab8ec5f585cf40.camel@kernel.org>
 <B8450A75-EB10-4FED-A0AF-7EA7EA370055@oracle.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <B8450A75-EB10-4FED-A0AF-7EA7EA370055@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:208:52d::12) To CH0PR01MB7170.prod.exchangelabs.com
 (2603:10b6:610:f8::12)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB7170:EE_|BL1PR01MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be5c190-018b-4671-c64e-08dca5c8187a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEMxUm5EWW5ZZ3RTL0U3Mi9VSm14akNwaTZJNldrNUMwWkhFampEcVdCWklH?=
 =?utf-8?B?MkJickVtNWFXM1FQdHRMR29HRko4dnhDQmg5VWgxK3I0MWNEeWZHZGtGaWlL?=
 =?utf-8?B?ZWtFeWx2RFEwTkMwMDYvZkEvSHRiRjdTbjJ1VENjNksrK3orNVJVaGJhbWUy?=
 =?utf-8?B?cVo5NUlOdG5PTWJlNjh1TWhuZlppU0RWc3dnVnFGTUlEZzVkc3dHZWNoZlBW?=
 =?utf-8?B?ZVljUzg3MkZvVUtEZUhTREJqNHFQRmxpTjArU3Q2eGlPLzJZNVNVNWlIMjVL?=
 =?utf-8?B?WUdRME5zRWFkN081ZmZHYTdrNVg3ZC91bno4Qjc3UEcyV29xY21KclFHeHZM?=
 =?utf-8?B?YUVzcjVuSUE0VkxQbmlpL1lWSFVubm5DUjQ1ekdObmxYUUlMbTdkWjVCdGVh?=
 =?utf-8?B?eTZzcGhzajFuQWN5ZnVDdGVqVTNzYlcxV2REdUhGRE9xWk9TL2w2ek5QYmsw?=
 =?utf-8?B?bGJ4R2FoVnNKYld4VkNYK3BiYnhvZ2d0cDR4dHE4czNnRDRleU5MSUhyRzFC?=
 =?utf-8?B?OXBTb1MyTWM4dHF1cHNLd2lsRDNudUo0dEE3VUVKYUozQzI2S2I1ZkpWN2JO?=
 =?utf-8?B?S2I5NUxucVdtNnFRdDVoZU4wUzVSamNIREtVNDVRV2VCVWZvOTlrY0xZdTVD?=
 =?utf-8?B?N2Znd3l4dVhCbWZIWmkvS0ZTVEUzK2hPekZiV21XS0FhbExuZ1dhVVRPTk5h?=
 =?utf-8?B?ZlpPNDRSTG1SMm95V3p2eFJCNVNMb2IxMWFCTmhPVmlWU2NkWFFPVkhLVHg2?=
 =?utf-8?B?emxXS1lhcTd6dWtVYS9vL0pmM1l0bnJhMTMzYmhUYnozellmNFpmV0R6TXVa?=
 =?utf-8?B?OHRmcHFTdUJNd1d2dFplL3lVSlh1ejdCOERPZzE5UXhjdmxUQ3hPV3NMSEx1?=
 =?utf-8?B?Y202R3E3UHNZN0FqTitobGM0VlRzYzdqMk0xdXRkN2xyV3pzQWhkMHRzdld1?=
 =?utf-8?B?WVdld0FQYzluLzdJWjF0bkN5S2lvR0R3R1I1NnhzOFBRU1JIOXhOV2VNeVNl?=
 =?utf-8?B?VDEzYU81VlhZQVNHeDRub1hRZDk1Y0VlRmpjdG5IcDlmU1JrZXhVaXAzdVZp?=
 =?utf-8?B?MEwxb05WUnBVMEFNL0NHTmdpRlVCa05YWGgzN1dxUVlLa1ppZ1Uxd1g4QjZm?=
 =?utf-8?B?dHNoNVJYeEdIV1J6U0pXZVEyZkFvNThyUVQrVzFCWmE3dFdKa0Y2MVJPMW92?=
 =?utf-8?B?c05Ec0VjbHVyRlB6S3dhbzM0bTVYQmQvbm4wbTNacGVuODZyYit0YXNXQS9k?=
 =?utf-8?B?VWVQR1U3eU5rZEY4NjlpWkw1MTUwU1dlZTMxRmgwVGs1bGdEd0xvNytWbFJm?=
 =?utf-8?B?b1hsNDJRMVlYdTZvaUQ3Z0Uyc2w0R0laM0toWDdxbUFmd3RjcGNUeTFmSGUv?=
 =?utf-8?B?bmZwSFRFRi84QlFOZTJPcXZ1MHRFOVlSSXRaK2lZa1QxN1cyQjNmV01vWHRx?=
 =?utf-8?B?enpydjZJeFArRnJKaDhuZlB2U0ZRZ1VnOUxrVG1XNHgzRHVKQkZUMzJpSHVi?=
 =?utf-8?B?NVcyNEZOMFBPTnMwalczVmxBQ2VWWVg1VVJsYVhicVNLZlJCM0JpNlUvRS9J?=
 =?utf-8?B?Vkl2SnVxeXh1NFFIeXFBZ0dyOTVaSDdEditoeHJZb05MTDhnWXVTbGx3MXVQ?=
 =?utf-8?B?cFFzOTQ0SGNrejhyK1ZvbkMvZlJ3RnlYdm0xZnYvWnQ1UXdzMU91MDEvTi9v?=
 =?utf-8?B?b1Nab21UWW1hU1hXa290WGNZNGR4RmdCMU5HVFUwdDRzY2tIVW1Bb3MyM2tE?=
 =?utf-8?B?OHZScXR0WHAxejR3emVvaGhTZFFrSWU3Yy9pT2NOWWlBV0FXS1ZBNlN2Yi9p?=
 =?utf-8?B?dGZMSE9pbVJweVlEYWc4QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7170.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFoxb3l4VFY5L25ZWjQ3RVFacWhsYkhkeWtqZktpNjB5Q1RsU21IelVPZ0hS?=
 =?utf-8?B?dmg0YWJzaGVwYitDeUJmVjlJd3AvSU1HUGM3Qkp2cm1hWGxVV2ZheXZ3SzNy?=
 =?utf-8?B?VkZjVFhrRlJ0MFducEh4TTI2VDlzQm85ZmE2K1RRblJQS2pId2pydjZTSkpZ?=
 =?utf-8?B?TGVlRmFJZ2F6UTFxSlRneTQ1UUxZaVZxakNDU0Q0bEpDdGNrSW4xWTJkWFBP?=
 =?utf-8?B?akVSMjllWVo2ZmI1V3NqWHV1VzhLYnNXYlRLV0xLY08yUmozUEFTZE1mb0JY?=
 =?utf-8?B?R2ZOeHNRUm5CMzBHZGxXME0xaHkrbVc3Y09WMWwzeStFS0l3QlZWRVgzSlB1?=
 =?utf-8?B?Sk5nNU9JeFEwVVhBSC9XZnBGTEVFcGg3KzJ5MUhIbDhTWS90Mk9UMHBaM3J1?=
 =?utf-8?B?VHpLVENVdEpmaWprZGVJcGxvTGRwSklWVFlkSU8vN2R1Z2NSRWtOWityOTlj?=
 =?utf-8?B?eXl5MWhpUUlISnhmeGYvSjVNSnkyNVZINjNtU2tmM1lwMDBZMkhNd0ZTZitQ?=
 =?utf-8?B?SFNYZVQxM2k0Mm0wUTNmeEZON291OGhEYTl5a1FobWFjRys0SDZ1eCtKSUJY?=
 =?utf-8?B?eHhXYlp3UlBaSThxTjNhSkFDenpNckszMDd1Z0NtUUtEYU5nZXJ1cEpUcHc1?=
 =?utf-8?B?dVhyS2NsWjNCdjNhbkpZQ2U2ZlNZWk1HdzA5OHZkRExGdmxTZlh3Zmp3M0RF?=
 =?utf-8?B?cFdiOXg4NG9kek4zT3F4Q0tUbkoyRWFsVFdnMkR4TzdBVjdVR3ZtZVBNQmsy?=
 =?utf-8?B?ZDVMek9HaTZENWJJcDhuWTZ5VjhETTJQb0l4YmFCNmd3YUxHY20vT0FYVk9r?=
 =?utf-8?B?M2l4TEdBS0k5Tm5Zd2cwazlyaGdIYTlTNTVkakQ2UUVwMFF0V3dyaE5BVW1U?=
 =?utf-8?B?V0NpMUx4cThsN2VZYTE0QytaMjZyYllRbGF5Tjd3K2VHNnNlc0toWVNIMksy?=
 =?utf-8?B?eGVUMTRoQ2lscUg0cDcrMmN4OTJjYlFOWUQyNE5oNWt2cEZYWkVMOXhOMXVG?=
 =?utf-8?B?OXg3bUxhK2lac3RLL1JBbWcrT2RNSVNpbldQQThtOVQyL0UwTHhFdklHc05C?=
 =?utf-8?B?VG9CWGtnTWo2RGdicXNDaXozNGZSdm9ZNWwxRTEzSHQwV29mclR5OVhsQis4?=
 =?utf-8?B?OWtTb1VXV0dQVzFXYW1lRVQwQUFmU2VFOG45V2U3aGZiQ0hYdy9DZ2dGdG1P?=
 =?utf-8?B?amVKT2UxVXU2eDNvR2JDVWhqR2FEMmxOUnJlS3dBdlZLd2paS2dXVDcwUWpk?=
 =?utf-8?B?U3BPOUZPRVFsL1FRZVdHdkN2aGF3SXBubjFxVEU5bDE5b0hld0tzdFdjVzhX?=
 =?utf-8?B?Z21xcG1DMjFjZiszc0kyVm1nN0l4VzFsdUtSZ2NwRnl2UklzTmFrbkYzU3pa?=
 =?utf-8?B?VVNWVVMrd2NzQnhKN3RpVGlycjFQelJZL2I3TytmTlZINEpzSFUwVE54TUZ5?=
 =?utf-8?B?U0FTRXBLMGwzMi85T3JLSkMvTmtOYy9DTVdMRUkxOVVXN1VlSkdzRUIwUU9j?=
 =?utf-8?B?S3lycjRYWXRzWENVZndtc3BBdTdjV1pUdFA1RGFqSkNDcDBSeVdDNlk4cjVa?=
 =?utf-8?B?c1VaaUY1ZEVFSWZPUnpQOThIVEc4S0JUMUFBWFRwTHpmemlLSjFnZGlNS0hM?=
 =?utf-8?B?YktCbWZFTTZIQUFJU1VGM2pYU3JCY3ZsRnBRenNSRUU2TGFJMnFDTDVVQk0z?=
 =?utf-8?B?a1I2OHhLMGgyWW9ZN29abnFZdmtQYXhJSmNUbVdCL3hKcHNqS0FkSTI3K2d0?=
 =?utf-8?B?N1ZDMW95bUpJYmFxMHJyeG9KcnQxTEx0SkVRakh2TldTVXM4bXJnek5IUmFq?=
 =?utf-8?B?a3ErWjQvK2hxOTR1NExNMWxtdlc2VFZFaEs0MG5ETXBQK2hEU2tmSHdTbFg1?=
 =?utf-8?B?VGNEbGQwdEdJalM3eHZ4SFdzZmprYU5VZ0RadWFUNWhjWXlwMGFMTURrS1hr?=
 =?utf-8?B?Zi9nam1taUcrb0NIbUEybHJxbGhmdlZsK3NGZnJoaUtYbUc0ZU94R3YvMlYx?=
 =?utf-8?B?bStidW02YUJEM0l4R0NNTXI1N1BKb0J5eWFCc2dNWjE0NzRxWjU5MjlTWDcr?=
 =?utf-8?B?TkY1V0dRMllIVnBNU1NDNmxtZGNPZGg4ZVVVeWd0cDJnckwwTVU1ZVFNaUNx?=
 =?utf-8?Q?eV2J2rDqC4/olMUOMoJ/rVpS+?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be5c190-018b-4671-c64e-08dca5c8187a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7170.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 18:50:00.3591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gPbr7MeynByfzku7EhDOTBf4vXHz2zxaJ+6k2jPXUJ9vfiDM0taP2ggTd6m0bCa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7531

On 7/16/2024 9:31 AM, Chuck Lever III wrote:
> 
> 
>> On Jul 16, 2024, at 7:00 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>
>> On Tue, 2024-07-16 at 13:21 +1000, NeilBrown wrote:
>>> On Tue, 16 Jul 2024, Jeff Layton wrote:
>>>> On Mon, 2024-07-15 at 17:14 +1000, NeilBrown wrote:
>>>>> A future patch will allow the number of threads in each nfsd pool to
>>>>> vary dynamically.
>>>>> The lower bound will be the number explicit requested via
>>>>> /proc/fs/nfsd/threads or /proc/fs/nfsd/pool_threads
>>>>>
>>>>> The upper bound can be set in each net-namespace by writing
>>>>> /proc/fs/nfsd/max_threads.  This upper bound applies across all pools,
>>>>> there is no per-pool upper limit.
>>>>>
>>>>> If no upper bound is set, then one is calculated.  A global upper limit
>>>>> is chosen based on amount of memory.  This limit only affects dynamic
>>>>> changes. Static configuration can always over-ride it.
>>>>>
>>>>> We track how many threads are configured in each net namespace, with the
>>>>> max or the min.  We also track how many net namespaces have nfsd
>>>>> configured with only a min, not a max.
>>>>>
>>>>> The difference between the calculated max and the total allocation is
>>>>> available to be shared among those namespaces which don't have a maximum
>>>>> configured.  Within a namespace, the available share is distributed
>>>>> equally across all pools.
>>>>>
>>>>> In the common case there is one namespace and one pool.  A small number
>>>>> of threads are configured as a minimum and no maximum is set.  In this
>>>>> case the effective maximum will be directly based on total memory.
>>>>> Approximately 8 per gigabyte.
>>>>>
>>>>
>>>>
>>>> Some of this may come across as bikeshedding, but I'd probably prefer
>>>> that this work a bit differently:
>>>>
>>>> 1/ I don't think we should enable this universally -- at least not
>>>> initially. What I'd prefer to see is a new pool_mode for the dynamic
>>>> threadpools (maybe call it "dynamic"). That gives us a clear opt-in
>>>> mechanism. Later once we're convinced it's safe, we can make "dynamic"
>>>> the default instead of "global".
>>>>
>>>> 2/ Rather than specifying a max_threads value separately, why not allow
>>>> the old threads/pool_threads interface to set the max and just have a
>>>> reasonable minimum setting (like the current default of 8). Since we're
>>>> growing the threadpool dynamically, I don't see why we need to have a
>>>> real configurable minimum.
>>>>
>>>> 3/ the dynamic pool-mode should probably be layered on top of the
>>>> pernode pool mode. IOW, in a NUMA configuration, we should split the
>>>> threads across NUMA nodes.
>>>
>>> Maybe we should start by discussing the goal.  What do we want
>>> configuration to look like when we finish?
>>>
>>> I think we want it to be transparent.  Sysadmin does nothing, and it all
>>> works perfectly.  Or as close to that as we can get.
>>>
>>
>> That's a nice eventual goal, but what do we do if we make this change
>> and it's not behaving for them? We need some way for them to revert to
>> traditional behavior if the new mode isn't working well.
> 
> As Steve pointed out (privately) there are likely to be cases
> where the dynamic thread count adjustment creates too many
> threads or somehow triggers a DoS. Admins want the ability to
> disable new features that cause trouble, and it is impossible
> for us to to say truthfully that we have predicted every
> misbehavior.
> 
> So +1 for having a mechanism for getting back the traditional
> behavior, at least until we have confidence it is not going
> to have troubling side-effects.

+1 on a configurable maximum as well, but I'll add a concern about
the NUMA node thing.

Not all CPU cores are created equal any more, there are "performance"
and "efficiency" (Atom) cores and there can be a big difference. Also
there are NUMA nodes with no CPUs at all, memory-only for example.
Then, CXL scrambles the topology again.

Let's not forget that these nfsd threads call into the filesystems,
which may desire very different NUMA affinities, for example the nfsd
protocol side may prefer to be near the network adapter, while the
filesystem side, the storage. And RDMA can bypass memory copy costs.

Thread count only addresses a fraction of these.

> Yes, in a perfect world, fully autonomous thread count
> adjustment would be amazing. Let's aim for that, but take
> baby steps to get there.

Amazing indeed, and just as unlikely to be perfect. Caution is good.

Tom.

