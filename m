Return-Path: <linux-nfs+bounces-6368-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1215297389A
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2024 15:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EFCDB24425
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2024 13:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDC7187555;
	Tue, 10 Sep 2024 13:28:16 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2133.outbound.protection.outlook.com [40.107.223.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F0018CBE0
	for <linux-nfs@vger.kernel.org>; Tue, 10 Sep 2024 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725974896; cv=fail; b=k5MQVWPfq+N27hb7XbPruAeXxfghQOeEIIJi6i6g8MuY/us1XXzjZaTg1O9cr58Nj3O9RxiXL2dI42cAXmNLIO422ah1XNEc7f0TkE5KgzISCcPN4N47M6uYk6DmknS+boyuM/JAUuKm/8ER5+LzTFMyNdFhZ+MjmuhgBzvqRIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725974896; c=relaxed/simple;
	bh=udgoKyJjsWqy6h8g8kizuF0Neb5lcezQvsKnnD2duc8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PEZWkST/kFbhaN+iZRksSCttOB2UOpk8eiYXXLBv2yfKVGpn1fjymKYh7Wveb3t3fa76mEMGkF0koUu96C7bT95fm+b4zyuVNg63HDCvQySGiNxAw6lyOEfiIQyf09swxvyIIduDHq5cxLqt9wAtd+0/Xi+bGP+gKLe+6bMaGOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.223.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MumI0E9EqdAWkdwW27E03fmBXw/8AqaOVV7YHwszQohD9vmqjiVSRR06QDoHRwwbCZKj5g+Z8/SDPjYDWj2zMkXhH+VlvmQInXBCYq/KmJbEWDPJcPGTIelTMU7mtkoE8vwBWezDa/F/YpZOwYnEoyc2eW4TbV891IRiXCZss+FnLWzVfKpG/jatv2HWXKaCCW9yxlu9P9/0ONujGKA7dsmGvjsqeLmSm8TnEzciR5z0P+ZRB6UhJTnmOEZWlJhoMAiYO5A/ojN9URZWpt2clxqax+9vX/xwX1LNuwk3q7pOkciZ0S3jwCe2xWaAFJiUp7zwc/jZ4qbigx6a8rt+NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8oDHYTj8pNJR6oipdRjuIThOgFEHfEPPLKzoa4oUy0=;
 b=c/FAg0+k0t4mHxPnNDNB1PygEP1UBHbYs9JoyUtpcQ4+qygtqU4ldoo9Gd30iVz23jfhM4fB6AIXKOlJ8EmK/1wv0Y8lPsUxFIYn11OQk5AhN/Mr6O9186jn/k8TBuWwh+QVw8OIOVlOEPt6K9eqlFW6CBpJkpuTEzKDY8UTnEaia8CrHwlMaf75LYVL6a/sEStHw+X9VSI37SQr/Rs+aBDiMhEA24IoxacSkyR38RO4MxmYeF6qFeVohgZp8wB2kRchSQ23T7JMYyGBcA9/louiq5TkNrF69bcWWU56DvLifX5RCu3ssaDPU372pALcSVgEdADdUa4lBF4CFOW08w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BL1PR01MB7721.prod.exchangelabs.com (2603:10b6:208:395::9) by
 CH0PR01MB7137.prod.exchangelabs.com (2603:10b6:610:ea::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.25; Tue, 10 Sep 2024 13:28:10 +0000
Received: from BL1PR01MB7721.prod.exchangelabs.com
 ([fe80::d33d:8437:f7d:568e]) by BL1PR01MB7721.prod.exchangelabs.com
 ([fe80::d33d:8437:f7d:568e%6]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 13:28:10 +0000
Message-ID: <f83b79fc-2ac0-4567-a46d-d3b7a4582ba2@talpey.com>
Date: Tue, 10 Sep 2024 09:28:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: fix delegation_blocked() to block correctly for at
 least 30 seconds
To: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neilb@suse.de>, Dai Ngo <Dai.Ngo@oracle.com>,
 linux-nfs@vger.kernel.org
References: <172585839640.4433.13337900639103448371@noble.neil.brown.name>
 <adadfa97e30bc4d827df194814e4e05aa26b8266.camel@kernel.org>
 <CACSpFtBYpQpAKVOmHLPUOr5LvoYq0-ea_NFMctqhMYSamUL_ZQ@mail.gmail.com>
 <Zt8IOQUF/VEkCPgO@tissot.1015granger.net>
 <CACSpFtCD-yBiO3Oe9m8k9q6Wug6MqgNQmjoT9K8DRAmc3bGLfg@mail.gmail.com>
 <727023c4-416d-43ba-a82a-3fbd0a831f49@talpey.com>
 <8e02bafe8027b060b38d38ebbd3092d2beb35206.camel@kernel.org>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <8e02bafe8027b060b38d38ebbd3092d2beb35206.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LV3P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::7) To BL1PR01MB7721.prod.exchangelabs.com
 (2603:10b6:208:395::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR01MB7721:EE_|CH0PR01MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c9aca4-85a4-4d4f-a6c3-08dcd19c6a0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qmd1M3B0eFNqSzRUNFlLOThodzlzVVJ5VjhSZW1EMHp4MGFnTlZSWDhOOUc1?=
 =?utf-8?B?RjUxOGpoWk1VdVRFemVhUVBjZnduSzBRdy85aGtaZ0FEOStkNlc2NE5CRmo2?=
 =?utf-8?B?N09tMS85QzVPb3BJcGVGNG4zMjZLVDFQL2wxN1MwditMa0VPZjJKaEV4UURl?=
 =?utf-8?B?dlpYRGVlVk52REZYU21UdlZRdzdvVTZBN2Z4dWpHY0tOU01oOG13TFB2dlFM?=
 =?utf-8?B?TnhwTXZBNGh5eUd3d3FOTnZQMEdRMk9RQ2R3a0hjVFJSZE9VbGFTa250RWFw?=
 =?utf-8?B?N1AyakZBcjJsTmwvQ2s2cUJBb1BoYUJoMG5xaGxLU3RhT3Y5RDRBUEkvQUNQ?=
 =?utf-8?B?U3YyOFdsTTNSR0s4VzFrbVJQWjlZWU9VNXd2WTVycktsbGxXKzdoeGxGV3JI?=
 =?utf-8?B?MFV1TG56czlMWDd6MGJkemlzd2NYZ3NuRGIwNmgwaDBVQzV5SFVMRGtPT0h4?=
 =?utf-8?B?cFRLeTFoUXk4Zm9UY1VmTk9UeVhhNDFobWlmdGpmcEVKdGVRUW5pYk92bmsy?=
 =?utf-8?B?SlBvaTJNaElUWmxlYkNJN2dDVCthemF4RTE2LzFoV2JMVHZZK3czRkcyczJP?=
 =?utf-8?B?bDN3V1d5NFdCTUxicHhYWWlkV0tNam5mVnNKTVMyRjNCVmliYkVyZlJSNzY5?=
 =?utf-8?B?SGVncy94Q1ZNNitaZkh1M0xNZGVBNUNLOG85MHNBVkJxbVpqcTdwdkNMcTcy?=
 =?utf-8?B?MnJ5WFB5MnpweWp4TXZDR0xBVjRVd3Q1bVJ3eDZmRy82Y0svTEFyVk5yZnds?=
 =?utf-8?B?T1YxWDhNcGYvT3pZMHdTTTVWRVJjM2M0RUk2TTBZUTVyNDN4ZXlBUXlPcG9w?=
 =?utf-8?B?N2k3aDN4QU9aWVc0N3AvWEpWSE0wS2MrNFBCZUxwQzFpc0YzNWM1c2VMVEx5?=
 =?utf-8?B?eWFScitsTkxFZ0czbjE3TWg1TmZrVm56NzMrNEN6bFl6RGtEcENkMGF0bUxs?=
 =?utf-8?B?WUNObFhVMnVSeVp5czZKbkNaZWVhakdrUlhCaFI0d2pMTGd2V2k5c3h0anhp?=
 =?utf-8?B?WDkyNnlET29nY0t4YXU4eS9wZnFMMkhsaUQ1MHE3aTJTSDJvV1A2UzUxcUNr?=
 =?utf-8?B?cGxqVXJxR1A2Nk93M3NVcUtiVDlSTzRuKzhXZWVVQ2ErcFF6V05TNU1lUDJ5?=
 =?utf-8?B?S0tiVVVNSWpBM254ZUdXenhqWHRSc1QxajREQnlnL0x3WWdCL2wwNzh0dGtv?=
 =?utf-8?B?Y2VYdkg2S0pKWENyQkk5cHpyYXNkSTMxUjJvcUNPeEhvWDhJZXQrMzFIeXNj?=
 =?utf-8?B?Ny9EbWE0YnVoVDBYMlBiMHhkRnZ3MDdFQzNFNWFEYzdJcDRzN0JvSTIrQXBk?=
 =?utf-8?B?MzllaGJzZUxFdGt6Z0NpVHhYZkJKQXlBQlJ1NGRjYUVhWnBkbFlndW1rMmVW?=
 =?utf-8?B?WDlUekpBZlhLZzR5NFVhWUJKQlRKZDNmT2x0TG1CdjZwTjdWSlZkai9CTGVs?=
 =?utf-8?B?L3JRNHVVOUVXTVZUeTJnV3VLZGQzck0zTWEzNUxueUYwSnNwd2dIdnlBemNE?=
 =?utf-8?B?WHIrbzl6WFk1bnloMXlxUS9waFNTb2I4Vmpabi9pdnkwR1ROZkdNakhPYXNp?=
 =?utf-8?B?dmw4VGF5SXdlY1BMNmphd0hjU1pzcStqOGxmbGI2cWcwdzIxQmRuVUlrVDND?=
 =?utf-8?B?djR2cTFqWmRMR21lSUYzSUF4VGZBcFRtSGJ5YlE5MW5Sb2JEVkUyYUhoTFRF?=
 =?utf-8?B?QnlZY2FnZzRhN2tUei82V0dVWU9EUnNYMVlPMUh4R3llSUtrd1JTdU5ITXU3?=
 =?utf-8?B?dmFxRDB5TG5UM2s2QTlaWUdDM1BNZFJuYzdmWWdmTkJzWWg5SnozLzFiREts?=
 =?utf-8?B?cWt2OGdQRXA4MTEzLzMrUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR01MB7721.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2RBenJVVFg0TEdLZTA0QXhIdXA0ZEJJei9xNndWZVJFeXEyc0k2N3hsU1N3?=
 =?utf-8?B?TThiR0NpZG9LeVNZNlBTZ0R1bG1OZW9LbXpmMVAzc2xtOG1mWG52ZFM3d1Fj?=
 =?utf-8?B?MkgvZkMxSzE4N0d3M0FOL0FpOFNHSVJpSnZZZVFZZVJ4d20vT3BjYnhKbzZK?=
 =?utf-8?B?LzJpUmZ0SzN5cDJmMy9LVGRrZ2RXMitGeHg2UG0vd1dPby9PVk5iczllRHcw?=
 =?utf-8?B?Z2ZmK0dlcG0zbWFpZXF5dG5XdnllWVNheElkR2hRZ0RlaEVxc2I0TTViOUVy?=
 =?utf-8?B?U2NBSmJ5UWV1SGlHbVhBdUlYaXJ0U0Fhb1BQNXp6SmpkSC9YSk9pTXRKNVll?=
 =?utf-8?B?NE5GWXFWcWtkUUxNS0xySGN6K3gzcHo1dVAybkErUmlHSS9ud1pzK0piY0Nv?=
 =?utf-8?B?SzVIamZlSW4zUkxodjdwZ25JeTJvVDRFQzZOSGZRQU9RSHdsVXBuc3V0U3dy?=
 =?utf-8?B?RDAxVUszS2xDTENWc1JMMHRLNms4YVVSSTV1a0czN1cvSW9SZXorRGc3YXhu?=
 =?utf-8?B?NE1pYXJDNU9KNUppdEFaZE9YY0VlRzNHSnZQWVEya0FIdU85NUs2R2E0b3VB?=
 =?utf-8?B?a0dwQ3VCZmp5Y003KzY2WElhbTJYVDhQdTcvVGFqQnRhQ08ybXdqczI4T0Yx?=
 =?utf-8?B?ZS9ZUERtd1VCSU1EcUNGYk8rUkQ0OFU0dGR0bTZCVUdkZWJ3U0QzdmF1Qm9L?=
 =?utf-8?B?c0VxQzhkOE43T1ZBNmJWeDgyeUUzMElCc3E2UnE5SkVWSHVHcTIxRnk5VjJQ?=
 =?utf-8?B?blJ5TTlsY3k5NFY0MUR5VDlDVEJMREZISkJGaXQ2OGlaci9NM1RhMnhqQWVi?=
 =?utf-8?B?S3U1UmdVOW40d0hVZUhJeEV5bWhwako0eGthRU81MUtTb21LajdQcnNWTG1t?=
 =?utf-8?B?SS8yYmhxVmMyNUQwSmswY1NmUWtvZy9HaHh2YlpnM2FIMmd6bS9aTjhTbFh3?=
 =?utf-8?B?UmsvNkYxM0JVVkhXWlVIbUxIK2U2clBKaUtMMFpwSW9RZjVZMk02VFp5WEds?=
 =?utf-8?B?QXJYR05sTjVlQk8rYXBzV0NCNlJSOEdQS0xWVHRqbmxhM0NhMTZxd0NtNDlX?=
 =?utf-8?B?ck9PcEh1ZXdobWZCcFJDcHYvK0EyVStIUitGNVV1WldBeW5zSk9WM1gweWJC?=
 =?utf-8?B?ZUxmUlJrTThMa01GRFlTZTdBS0JJNTlaMVpvVm43MHFWTFpPUlg0Mnllcy9H?=
 =?utf-8?B?SGZVVjF2alpZMzNxOFM5cUFtOTlyWW84ckN0ZWxzazFMOEtiYy9ObWFtQTlB?=
 =?utf-8?B?R2Y5WGJOQ1ljcFRCd2c1eG5nZHVWRis0d05LaW1kd05CbnhyQzdKUHdVZlFn?=
 =?utf-8?B?S3BMa1l3ek5TWEF6R1BGS091RzBBSXFJMFdWa0lhUmdNc2l5UWk3ZkdzKy9G?=
 =?utf-8?B?LzBFandISmpCSVJKQUZ2QTJLV2doVmJ6WjVQTURXaTFMVjJ0TmlIOUUydEpT?=
 =?utf-8?B?SmZFVU9hbmlNRitqQUxCL0lMbXJFbGhHOHVJc2ZhYzJRaVg1NXNFRkhoQ3R6?=
 =?utf-8?B?OTBnOWE3RFM0NjB3T2dQUE40dmR2cjFsUTRLRk5uZjVFd3VPU1dVSHhKQmZL?=
 =?utf-8?B?WVJRa3RVWm9iSE81SmtWajdKZ0dMeFRHYTVGNXoyd1JleE9BQ1YxaHVEdnE5?=
 =?utf-8?B?NVZRUHNDUU1WN3BEVnhZdHg4RW51Wml1RklhQW1IRjFZWjRaQ1VQbFZLcUtt?=
 =?utf-8?B?M20zRlpMU0ZZb3pKYnR2RmNDeFlHTWd0UVY1V0ZFTVpyS3FNYmNpRVd6eEZj?=
 =?utf-8?B?aEZpVE9oQ3dGdU1qZ0gvK2xIaWs4dm9teGRQcHZ0L2Z2K2pLa0twTVpBdGVK?=
 =?utf-8?B?OFJubDVKRVV1VUVLQ0tINDZxODUwNFdVREordDl0by9oTm1pZXVteGNpcEgx?=
 =?utf-8?B?TlVjNGZJWHhTWTBlV3E2dmxmdi9MYTdhcTM5cDVCTFk2Zlk5ZExUWUlTUEh3?=
 =?utf-8?B?WS9pamp6OFlqS1lxamV6WldWSHpUZUV6enFFbWdhQ040MERKMzU4M2prNWVY?=
 =?utf-8?B?WUI5YzdQeGdrMFU4OGc3WllONGJyRlFrZVJrdzZYZWx1UG0vVXB1cGhoTWZ4?=
 =?utf-8?B?Q2krekZWeitsYXV5dWpnUUJFNVVWR0RCUDRCT3o2cEdUQVRaSFBVdkNPMm53?=
 =?utf-8?Q?FKsU=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c9aca4-85a4-4d4f-a6c3-08dcd19c6a0b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR01MB7721.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 13:28:10.5476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6Q4i3Yay4GbojT+CLNZnuqA2WVGq5FQSwZgFd719hs2r37VAlQoQgp0e6TfaSPm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7137

On 9/10/2024 8:52 AM, Jeff Layton wrote:
> On Tue, 2024-09-10 at 08:32 -0400, Tom Talpey wrote:
>> On 9/9/2024 11:02 AM, Olga Kornievskaia wrote:
>>> On Mon, Sep 9, 2024 at 10:38 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>
>>>> On Mon, Sep 09, 2024 at 10:17:42AM -0400, Olga Kornievskaia wrote:
>>>>> On Mon, Sep 9, 2024 at 8:24 AM Jeff Layton <jlayton@kernel.org> wrote:
>>>>>>
>>>>>> On Mon, 2024-09-09 at 15:06 +1000, NeilBrown wrote:
>>>>>>> The pair of bloom filtered used by delegation_blocked() was intended to
>>>>>>> block delegations on given filehandles for between 30 and 60 seconds.  A
>>>>>>> new filehandle would be recorded in the "new" bit set.  That would then
>>>>>>> be switch to the "old" bit set between 0 and 30 seconds later, and it
>>>>>>> would remain as the "old" bit set for 30 seconds.
>>>>>>>
>>>>>>
>>>>>> Since we're on the subject...
>>>>>>
>>>>>> 60s seems like an awfully long time to block delegations on an inode.
>>>>>> Recalls generally don't take more than a few seconds when things are
>>>>>> functioning properly.
>>>>>>
>>>>>> Should we swap the bloom filters more often?
>>>>>
>>>>> I was also thinking that perhaps we can do 15-30s perhaps? Another
>>>>> thought was should this be a configurable value (with some
>>>>> non-negotiable min and max)?
>>>>
>>>> If it needs to be configurable, then we haven't done our jobs as
>>>> system architects. Temporarily blocking delegation ought to be
>>>> effective without human intervention IMHO.
>>>>
>>>> At least let's get some specific usage scenarios that demonstrate a
>>>> palpable need for enabling an admin to adjust this behavior (ie, a
>>>> need that is not simply an implementation bug), then design for
>>>> those specific cases.
>>>>
>>>> Does NFSD have metrics in this area, for example?
>>>>
>>>> Generally speaking, though, I'm not opposed to finessing the behavior
>>>> of the Bloom filter. I'd like to apply the patch below for v6.12,
>>>
>>> 100% agreed that we need this patch to go in now. The configuration
>>> was just a thought for after which I should have stated explicitly. I
>>> guess I'm not a big fan of hard coded numbers in the code and naively
>>> thinking that it's always better to have a config over a hardcoded
>>> value.
>>
>> No constant is ever correct in networking, especially timeouts. So yes,
>> it should be adjustable. But even then, choosing a number here is
>> fundamentally difficult.
>>
>> Delegations can block for perfectly valid long periods, right? Say it
>> takes a long time to flush a write delegation, or if the network is
>> partitioned to the (other) client being recalled. 30 seconds to data
>> corruption is quite the guillotine.
>>
> 
> I don't think this is danger of data corruption here. The bloom filter
> is there to keep the server from handing out a new delegation too
> quickly after having to recall one. Allowing no delegations for 30-60s
> seems a bit too cautious, IMO.

Agreed that the server is doing the right thing, it's about when the
hammer comes down, and again, any constant is inevitably going to be
wrong, sometime or somewhere.

> Ideally it seems like we'd want this to be some function of the delay
> between the server issuing the CB_RECALL, and the client doing the
> DELEGRETURN.
> 
> That value is obviously highly variable, but it would be an interesting
> statistic to collect, and might help inform what the bloom filter delay
> should be.

It would, but it seems it would have to be per-client and per-workload.
There is definitely no single value. Some clients may take a caching
read delegation "just because", and return it promptly. Others may
be at the end of a skinny/flaky link and want to buffer writes. These
are going to have wildly different delegreturn latencies.

Tom.

> 
>>>> preserving the Cc: stable, but handle the behavioral finessing via
>>>> a subsequent patch targeting v6.13 so that can be appropriately
>>>> reviewed and tested. Ja?
>>>>
>>>> BTW, nice catch!
>>>>
>>>>
>>>>>>> Unfortunately the code intended to clear the old bit set once it reached
>>>>>>> 30 seconds old, preparing it to be the next new bit set, instead cleared
>>>>>>> the *new* bit set before switching it to be the old bit set.  This means
>>>>>>> that the "old" bit set is always empty and delegations are blocked
>>>>>>> between 0 and 30 seconds.
>>>>>>>
>>>>>>> This patch updates bd->new before clearing the set with that index,
>>>>>>> instead of afterwards.
>>>>>>>
>>>>>>> Reported-by: Olga Kornievskaia <okorniev@redhat.com>
>>>>>>> Cc: stable@vger.kernel.org
>>>>>>> Fixes: 6282cd565553 ("NFSD: Don't hand out delegations for 30 seconds after recalling them.")
>>>>>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>>>>>> ---
>>>>>>>    fs/nfsd/nfs4state.c | 5 +++--
>>>>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>>> index 4313addbe756..6f18c1a7af2e 100644
>>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>>> @@ -1078,7 +1078,8 @@ static void nfs4_free_deleg(struct nfs4_stid *stid)
>>>>>>>     * When a delegation is recalled, the filehandle is stored in the "new"
>>>>>>>     * filter.
>>>>>>>     * Every 30 seconds we swap the filters and clear the "new" one,
>>>>>>> - * unless both are empty of course.
>>>>>>> + * unless both are empty of course.  This results in delegations for a
>>>>>>> + * given filehandle being blocked for between 30 and 60 seconds.
>>>>>>>     *
>>>>>>>     * Each filter is 256 bits.  We hash the filehandle to 32bit and use the
>>>>>>>     * low 3 bytes as hash-table indices.
>>>>>>> @@ -1107,9 +1108,9 @@ static int delegation_blocked(struct knfsd_fh *fh)
>>>>>>>                 if (ktime_get_seconds() - bd->swap_time > 30) {
>>>>>>>                         bd->entries -= bd->old_entries;
>>>>>>>                         bd->old_entries = bd->entries;
>>>>>>> +                     bd->new = 1-bd->new;
>>>>>>>                         memset(bd->set[bd->new], 0,
>>>>>>>                                sizeof(bd->set[0]));
>>>>>>> -                     bd->new = 1-bd->new;
>>>>>>>                         bd->swap_time = ktime_get_seconds();
>>>>>>>                 }
>>>>>>>                 spin_unlock(&blocked_delegations_lock);
>>>>>>
>>>>>> --
>>>>>> Jeff Layton <jlayton@kernel.org>
>>>>>>
>>>>>
>>>>
>>>> --
>>>> Chuck Lever
>>>>
>>>
>>>
>>
> 


