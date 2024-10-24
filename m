Return-Path: <linux-nfs+bounces-7458-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11B09AEE97
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 19:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C97A1F21A63
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 17:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BCA1FBF78;
	Thu, 24 Oct 2024 17:50:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023092.outbound.protection.outlook.com [52.101.44.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A5C54738;
	Thu, 24 Oct 2024 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792224; cv=fail; b=k6kSRxEVGGB8F0gCiZNuEXvA8gmI4jwqePyvctiEPyc2HuIPo9SBghHYG8xc/5skf/C7iK5XlWjt4d3VIUAoup6osqP3bShJru2JZZOSMuA8mKgU8MKrVLYAA1U/WczQLrLLAj3NCkTb/ui7G+/JUrGnBRSmxOtKmv995/rnxpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792224; c=relaxed/simple;
	bh=3JRxiPX6TaBnWGZZ+NEnZ4Mrdcrx4Tkz+zdClg1rG3w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o8KsDPfkxmiMFXlVUNokRmAXuctuSrUy+WrS4S2FfchA2xGbu2FY+x7BEjm/KUftt9b1aufC6ezud0NyjvcP90wU3dgwTnYrXdW/MqDxEJ75Xuw0Pa32nUU24zsufbuAZdR1rip0soSG2KiF0S9cngGBc2bcaAy0xHpGYhv3Lfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=52.101.44.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZ09mxnBwtpG11M46WQo1It9CFw7jLBQaS2LmWOJTU0rOo6EjfneGE8XpaT9+qLDKOu6sbqcV8bQ0/I9p5Vl0iMpsxuv7BkTZKumAhb40JasuVT+OWCTEflqfhDbwWTYhKV6Je1L9SF/PVkOEiCjcCPz2opZhAaw2ugyYhJKzjyI+Retiz07ysU849oV6jX3TX/obaHzaUHRblZafEX2TkUTlWLLzCc3RbZWq4T7pfFIKhzPbLw0P1+7I5oECHL/FTU9bCGk57/1xgr5RhqcoGFGEMLRfqT6ophxvvhR8v+RAHGLUch0vx4OiHX4kk86K38aHEOzBlu3o/CfzqrOqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYkb/FkCeeILJBWwYfXPhQfnZOCU8qku+kw6BXATuEU=;
 b=iSrKnhy9RObsx9S8U8ot6XLlO3EJCp4OoYTq+Aj8D0TY2VRHOeHZlXIcMl4ZLc010Ha4Y+6TqxZpcP00Gp+nxr2PNStEzv5NJwnd3ne5/8Y6wJfZ4eG71UPc2/XypWXX7sVasEoWmYtSWq+G7jo7kp+xvUed9kXIu0Wfz47044WydauKCuKunyEuSx5BOA4zpMvfkajcEXUp3b1t1VmVVLDmXwootDXjPFien/GAtsdRRVXVx66tyweglk9Q1W7E0byodQisa7psD42IqWA71NgBbgRcwv4YK9V0IQq5o+ychAfVUL5FLDsr4n07UdMMpwiX4+tu3/zqfHK8mqPX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 SN4PR01MB7408.prod.exchangelabs.com (2603:10b6:806:1eb::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Thu, 24 Oct 2024 17:50:17 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%3]) with mapi id 15.20.8069.019; Thu, 24 Oct 2024
 17:50:17 +0000
Message-ID: <6aa37253-8a0f-4323-911d-7281c4a0f14d@talpey.com>
Date: Thu, 24 Oct 2024 13:50:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] SUNRPC: support resvport and reuseport for
 rpcrdma
To: Kinglong Mee <kinglongmee@gmail.com>,
 Chuck Lever III <chuck.lever@oracle.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <1a765211-2d1e-48ef-a5ca-a6b39b833d5a@gmail.com>
 <Zw/GUeIymfw+2upD@tissot.1015granger.net>
 <a4dc7417-1d0c-4700-9102-0ecc2c9e81ab@gmail.com>
 <ZxEP/zBCaSgxbJU7@tissot.1015granger.net>
 <c04e7270-1415-4c6a-8bca-a77cc0403287@gmail.com>
 <ZxJvZqmKsPTtOFUR@tissot.1015granger.net>
 <290d18f3-befe-44b4-b79b-983983f1418f@gmail.com>
 <3225E57B-40A4-4CF6-BDF1-3A90BC313D22@oracle.com>
 <6eb46c99-d410-4090-8832-394e7aa69adc@talpey.com>
 <6c9b31e6-efb8-4b84-9af8-1dc6ed768d1f@gmail.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <6c9b31e6-efb8-4b84-9af8-1dc6ed768d1f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:208:236::15) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|SN4PR01MB7408:EE_
X-MS-Office365-Filtering-Correlation-Id: 55a9e855-7b99-479a-4fa2-08dcf45451d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVI2RVJXWTBEV0F1UmprR0hCZjRvVk9xMWhHRkdQZDNLUDVTankxcThweThH?=
 =?utf-8?B?VVMrc3BOVEZxUU42WXdKS1VHK2FwR0NHWkE5UFlTWGRybHNaU0JhTm9QTEZs?=
 =?utf-8?B?aXR0bW12QlRJL1hsVFBCK1g2UTdEMXI5ZEoxODMwcDBGbkovdnR0NmxYMStO?=
 =?utf-8?B?THdjNDVtM2Z4NGkxNjJuRk9kbHA4eEQxWW9CWk1mMXM4UHNNdExBWFZBU2tk?=
 =?utf-8?B?TEs3cVduYzMraDhTZEROMXJOQmdSZEpTSXc5amhhVHBsSVNFam9SUHFBRm1Y?=
 =?utf-8?B?a2FveTVsN2FJM205T3VKSHdVUzJ3cXp6YUptUE4yWjFtV3h0UG5QTnE4WDlS?=
 =?utf-8?B?dTU0R2lZWGk4NlN1d3dhZWdHdXdkSytzelVtREQyU2cxSDZMcmd2VC92Lzhz?=
 =?utf-8?B?UTVZS3FtVS9zOUwreVFRd0lSWHZ3WGZ1UzhEVHhVSWljdVZJS1IwU2lSajBM?=
 =?utf-8?B?ZFN4VmREZnY0bU1ldUwremhMZ2tYYklKNzI3RkZ2SXdib3plbEhGWlJHVEFL?=
 =?utf-8?B?ZFJJb3I3RkY0a0hTZUg5R3pvK1lKZ0haWjBOakFFeTZJekNVNU12VXVGM2Vz?=
 =?utf-8?B?MjE1TjcrOUQ5L2pWb1VhYnRha0haSWRPYWhCRDk0NU15OFFvRGV1dVp4bVdM?=
 =?utf-8?B?dmI3Rnd2MnZydkQzYi9SZkJGOEZKQWN3UUNLLzZYaTE5T2x2NisvS3V0SVRy?=
 =?utf-8?B?NHZadjFLdUtzNGlORk8rRjJTbWY4Vy9xbGMzRmNIWnNaSUlCZUZvalJEKzd6?=
 =?utf-8?B?Z3dGcCtxQkFBbnlldHRWZUw0U3ZGR09GNEd0SXB2QTc3SkFXNm53YUYrSVRj?=
 =?utf-8?B?clZkYnNyNlQ1N2Y5ejZtcHRRdy9XeFZOTDZBWVF3UmlKTXgwOCtsWS9pUnFp?=
 =?utf-8?B?MURaWWhaZUFjbGZySTdGRnltQ1d4VTJ2R3Q3Rk5ibkhpTGNjTk9FYWcydEF6?=
 =?utf-8?B?V240R1BFdHN1OUhkUkNrZlRDSXI1bTVDOVYxUkRmMmdyU3NSc0U5czlxM1NL?=
 =?utf-8?B?WEwxenVGdGEvWWJWNnQrb3JHMlBaQjdOSkpuRTdyZ2VqOGVIUTVZclRGSmpR?=
 =?utf-8?B?TVkzNU9uUWxUL2UyNGRXTUtNQXBNWnJYTnFWMmp1VmFFcjU5VEV4ZDlGcFlY?=
 =?utf-8?B?NDl0M0FnZ1MzaWFnS2NpekRTZTF3S2lyZy96ejJhU24rMWFGUkhKWDJOREZJ?=
 =?utf-8?B?N2tKQUFvYk0xblhhZlh5QW1jT1VhYzZkOG5pRmt2TWZKZWtWQVJ2bUV4TUs3?=
 =?utf-8?B?ZWtHQ0o1UmJlSVZVQjBSc2YxTm5GSXhzeUFNemttZjlNN1dXYVU5MmpCR0FZ?=
 =?utf-8?B?OFl1YW5vdkZiZEtkSkdyckxzNXY1ejNudzJxaGQzRnM2SWtncWF6K09TR04v?=
 =?utf-8?B?YTNsdGQwUDBhM1ZUMHYzVkhaeGVjMk9MSjJ3YVZoUFpLQkJmMFJRYU1LbVZt?=
 =?utf-8?B?UFV2UHhKalJWVXFweFo1Sk5OUEo2NG5McWVLUE1sekI4SUtqRFpjTEpaeTBv?=
 =?utf-8?B?TUVJRzJmY1ZFZmFFc2Q4QzN3ZHV5SkxNM0VSQm5Qdk16ZTNqU0Vadk5zQVRm?=
 =?utf-8?B?bnRJdDFQOG5TZ04xcHJ4dzZmQzY0K3dObkhIMVZuRWZaeUs0cUI3SmFKbE5Y?=
 =?utf-8?B?ODczUEpEUzVJK2QwSmhXeXUzUUgzeDlMd1I0aGNMMys4T05LdnBDcG9XaThi?=
 =?utf-8?Q?IcaAyLctjttz/2H8R0iY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkRXSC9BcGhSRXoxSThVb0tTWUxlYU5LU0txRjBtWXAwU3ZicGh3S2R6NTNI?=
 =?utf-8?B?TStnYmprS25HT250SVp6aEZjUjFMbTM1eGJFSUFrUjU2aHFESXVoTldDVmNO?=
 =?utf-8?B?MDhuMCtPM0lGOGUrOXFYWUFQWTAxOGkvb29QRDBqcjFWeEk5RWNyelNWYlEr?=
 =?utf-8?B?ckJ1WXRzUHlBSUZUR2xDMHptem9YdFM4Y0xERXI2R2RwQjZPNkNiTWIrN2Zu?=
 =?utf-8?B?QmxxaW5ZVHhsRndFY2lGZGxuOCtPVFlaY2xHRDRwTmI1NnNLRTNwTS9wWHN2?=
 =?utf-8?B?RFBjbnY5VU1HN2RkdnRHQ0ZBWm9GcDRvUnlqYWhpTUhkNmpQb0NNV1g0OGFx?=
 =?utf-8?B?UGVSVkR0RlZKUGllV2pIb0NLczVCOVhuUmdJeW1MRVd1MnZhcmw3WW15clJD?=
 =?utf-8?B?ZEx1c1NZTEFMOG4zT255ajZjaWFWb2dickJqZGZoNWdWc3ZmMlJwazJWYWtG?=
 =?utf-8?B?N0dENmcxcDZSUFovcUEvVzJ6RWliRHdmKzFudHNiOXRkSEJwcXhia0RoMmdi?=
 =?utf-8?B?ODVNVEE0S2ZvL1RQcDd6Z1BucXNlcU91eitHclNBRGdDUWNodFh4WStMK2xn?=
 =?utf-8?B?S0lrck1EWXlHWjZ4TzhiclZoRGp5dDVNdmdxaWs1RUVrVG9zREdJVUhRUVVG?=
 =?utf-8?B?ZnIvNWdxUXg0bDcwMUF6RFhYMEZ5Tkp0eHk4MlNzTE4yQkllOE5VYWFyVVZH?=
 =?utf-8?B?dHVzbnZyd3pKcFpHYWN6WWFROVgzcjlzR0J1TXlkZFFoeGNDbi8xNXNPVEU2?=
 =?utf-8?B?eW9JQXZ0UTJkNnFjZUYyMFBaREgra21aaWpQazlVbnpVVm8wVVNrWUJTMEcz?=
 =?utf-8?B?a2Y5MlVoUEs2bDVLa0t4SnhiM0QvMmxpTExRTXhMdWxTOC9tWHRDMGxuUlFU?=
 =?utf-8?B?MTlVTEhVWDF2Z2laNGczczhFUlRQTExaT1YxdE10R3g4bXZzTWFsaHJEUHNj?=
 =?utf-8?B?M2hWZUhuTExJSVhLOGp4VTFzNVdqS0dHQnhZbThrVlphWVgzVGQ4VEVva1pX?=
 =?utf-8?B?SmhmdktnNkZGSDVPdytNWFlEcElRaVBhWVpvWW9WcUI5SlVMcENGdy9NRk9j?=
 =?utf-8?B?OXF4V08xbExvK1p4bXJJd1BOTk5QS0lsRWFiVG1pWjY5MzZPczlub2xSVDE1?=
 =?utf-8?B?amFXUStJUFhKRTQzSnJsQ3B6Lzc2Qy9BM2t6K1BlOHZTSjRUNlArU0RlL0w2?=
 =?utf-8?B?VEkrelo4NUZaaFlXMHpsOGdrYUdoVVVVQ3FadzhJRU1ZWVhENnRWR2N2eXIv?=
 =?utf-8?B?QTZvdWcvTC9FY2JIZTl0MDQzcmltTVpRV09vcThpSzlyRUZUTnpZSHNmaXVv?=
 =?utf-8?B?WnlCSGpETGhVN3pzaHEyclpvbUxZaHJKcHZzTUNHM285SGw3ZThBWlNaeEo2?=
 =?utf-8?B?aDd0UXhsRmVkWTNHMEJWaTlpaHlTTkluOW1XZTFTSDNHdUJaZ2U3TitJMVRZ?=
 =?utf-8?B?OHBob1JHa25uL0t5ai9jc1poMmVMeXZQTi8rNnQ4NFlYck9pdGhCcUZzQWNl?=
 =?utf-8?B?Z0U0WjROT1RTaG0veDdaZld2SE03ZDdETTlyRnpBcHcxWm9ibmNZZC81QTVW?=
 =?utf-8?B?bGVadkt0a1ZQNFJvYU53bW55QjlKa0xQMWpYbHllR1BSWUxJcUx6NUxwNmF4?=
 =?utf-8?B?a0NPSkVWL1pTRHdoZ0swQWd6a3FlbWFKb1EzTXdLeUdLVGUzU05STFkrWS9Y?=
 =?utf-8?B?TWJlRDJLeWFtNUp1MHp1VGY5TXNGbFd6VWRQV0hmWlB3bHNYc3UybUE0cWsw?=
 =?utf-8?B?ZDNYQ3p2bmYzWXZRQzhpUjhnSjZIZDUvbFFMcEpRMlRFakNYZ0wzYU1zL3Aw?=
 =?utf-8?B?RkVJMjhFelpCSUNIZGRUbU5QWHBxdTZWR1lhR1RnRzJYS0dUUml3ZHk5UXh0?=
 =?utf-8?B?dm41UEpWejREbDRXVlBTUmNqK2Jmd1Z0SnJjZ1NLbVJoVmM2NGhlb0t4TXNw?=
 =?utf-8?B?N202b0JzMStsWnBUVy9BYzNOTVlLZ0ZTbHFuQmF2cnFubjNSRzJKYXcvdmlW?=
 =?utf-8?B?ckVQTUZYR0tsVGJBblQ3VVVNd2xOWG1TZFI2Rll0ckV5V1dkSm5SN1FLTnVz?=
 =?utf-8?B?dkNDcnYyc000cTBtVE5BcFVkd010cHU4dEVCUWFINkxndDlIaWExZWcxbk83?=
 =?utf-8?Q?t11w=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a9e855-7b99-479a-4fa2-08dcf45451d9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 17:50:16.9699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MUG6eqUtMJ+DB8/9asL2ZY/qy2FwzTqgBa6kZ6MT8attmhd9Sz1o1qbO0o1xKVJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7408

On 10/23/2024 11:10 PM, Kinglong Mee wrote:
> On 2024/10/24 12:02 AM, Tom Talpey wrote:
>> On 10/19/2024 2:51 PM, Chuck Lever III wrote:
>>>> On Oct 19, 2024, at 6:21 AM, Kinglong Mee <kinglongmee@gmail.com> wrote:
>>>> Hi Chuck,
>>>> On 2024/10/18 10:23 PM, Chuck Lever wrote:
>>>>> On Fri, Oct 18, 2024 at 05:23:29PM +0800, Kinglong Mee wrote:
>>>>>> Hi Chuck,
>>>>>> On 2024/10/17 9:24 PM, Chuck Lever wrote:
>>>>>>> On Thu, Oct 17, 2024 at 10:52:19AM +0800, Kinglong Mee wrote:
>>>>>>>> Hi Chuck,
>>>>>>>> On 2024/10/16 9:57 PM, Chuck Lever wrote:
>>>>>>>>> On Wed, Oct 16, 2024 at 07:48:25PM +0800, Kinglong Mee wrote:
>>>>>>>>>> NFSd's DRC key contains peer port, but rpcrdma does't support port resue now.
>>>>>>>>>> This patch supports resvport and resueport as tcp/udp for rpcrdma.
>>>>>>>>>
>>>>>>>>> An RDMA consumer is not in control of the "source port" in an RDMA
>>>>>>>>> connection, thus the port number is meaningless. This is why the
>>>>>>>>> Linux NFS client does not already support setting the source port on
>>>>>>>>> RDMA mounts, and why NFSD sets the source port value to zero on
>>>>>>>>> incoming connections; the DRC then always sees a zero port value in
>>>>>>>>> its lookup key tuple.
>>>>>>>>>
>>>>>>>>> See net/sunrpc/xprtrdma/svc_rdma_transport.c :: handle_connect_req() :
>>>>>>>>>
>>>>>>>>> 259         /* The remote port is arbitrary and not under the control of the
>>>>>>>>> 260          * client ULP. Set it to a fixed value so that the DRC continues
>>>>>>>>> 261          * to be effective after a reconnect.
>>>>>>>>> 262          */
>>>>>>>>> 263         rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, 0);
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> As a general comment, your patch descriptions need to explain /why/
>>>>>>>>> each change is being made. For example, the initial patches in this
>>>>>>>>> series, although they properly split the changes into clean easily
>>>>>>>>> digestible hunks, are somewhat baffling until the reader gets to
>>>>>>>>> this one. This patch jumps right to announcing a solution.
>>>>>>>>
>>>>>>>> Thanks for your comment.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> There's no cover letter tying these changes together with a problem
>>>>>>>>> statement. What problematic behavior did you see that motivated this
>>>>>>>>> approach?
>>>>>>>>
>>>>>>>> We have a private nfs server, it's DRC checks the src port, but rpcrdma doesnot
>>>>>>>> support resueport now, so we try to add it as tcp/udp.
>>>>>>>
>>>>>>> Thank you for clarifying!
>>>>>>>
>>>>>>> It's common for a DRC to key on the source port. Unfortunately,
>>>>>>> IIRC, the Linux RDMA Connection Manager does not provide an API for
>>>>>>> an RDMA consumer (such as the Linux NFS client) to set an arbitrary
>>>>>>> source port value on the active side. rdma_bind_addr() works on the
>>>>>>> listen side only.
>>>>>>
>>>>>> rdma_bind_addr() also works on client before rdma_resolve_addr.
>>>>>>   From man rdma_bind_addr,
>>>>>> "
>>>>>>     NOTES
>>>>>>         Typically,  this routine is called before calling rdma_listen to bind to
>>>>>>         a specific port number, but it may also be called on the active side of
>>>>>>         a connection before calling rdma_resolve_addr to bind to a specific address.
>>>>>> "
>>>>>> And 9P uses rdma_bind_addr() to bind to a privileged port at p9_rdma_bind_privport().
>>>>>>
>>>>>> Librdmacm supports rdma_get_local_addr(),rdma_get_peer_addr(),rdma_get_src_port() and
>>>>>> rdma_get_dst_port() at userspace.
>>>>>> So if needed, it's easy to support them in linux kernel.
>>>>>>
>>>>>> Rpcrdma and nvme use the src_addr/dst_addr directly as
>>>>>> (struct sockaddr *)&cma_xprt->sc_cm_id->route.addr.src_addr or
>>>>>> (struct sockaddr *)&queue->cm_id->route.addr.dst_addr.
>>>>>> Call helpers may be better then directly access.
>>>>>>
>>>>>> I think, there is a key question for rpcrdma.
>>>>>> Is the port in rpcrdma connect the same meaning as tcp/udp port?
>>>>>
>>>>> My recollection is they aren't the same. I can check into the
>>>>> semantic equivalency a little more.
>>>>>
>>>>> However, on RDMA connections, NFSD ignores the source port value for
>>>>> the purposes of evaluating the "secure" export option. Solaris, the
>>>>> other reference implementation of RPC/RDMA, does not even bother
>>>>> with this check on any transport.
>>>>>
>>>>> Reusing the source port is very fraught (ie, it has been the source
>>>>> of many TCP bugs) and privileged ports offer little real security.
>>>>> I'd rather not add this behavior for RDMA if we can get away with
>>>>> it. It's an antique.
>>>>>
>>>>>> If it is, we need support the reuseport.
>>>>>
>>>>> I'm not following you. If an NFS server ignores the source port
>>>>> value for the DRC and the secure port setting, why does the client
>>>>> need to reuse the port value when reconnecting?
>>>>
>>>> Yes, that's unnecessary.
>>>>
>>>>>
>>>>> Or, are you saying that you are not able to alter the behavior of
>>>>> your private NFS server implementation to ignore the client's source
>>>>> port?
>>>>
>>>> No, if the rdma port at client side is indeed meaningless,
>>>> I will modify our private NFS server.
>>>>
>>>> I just wanna known the meaning of port in rdma connection.
>>>> When mounting nfs export with rpcrdma, it connects an ip with port 20049 implicitly,
>>>> if the port in client side is meaningless, why is the server side meaningful?
>>>>
>>>> As I known, rdma_cm designs those APIs based on sockets,
>>>> initially, I think the rdma port is the same as tcp/udp port.
>>>
>>> IIRC the 20049 port is needed for NFS/RDMA on iWARP. On
>>> IB and RoCE, it's actually unnecessary.
>>
>> Right, the _destination_ port 20049 is IANA-registered because iWARP
>> uses TCP and the server is already listening for NFS/TCP on port 2049.
>> The NFSv4.1 spec allows dynamic negotiation over a single port, but
>> to my knowledge no client or server implements that. And of course,
>> NFSv3 and v4.0 are naive so they require an rdma-specific port.
>>
>> IB and RoCE use the "port" number to create a service ID and have no
>> conflict, so while it's technically unnecessary they have to listen
>> on something, and the server defaults to 20049 anyway for consistency.
>>
>> OTOH the _source_ port is a relic of the NFS/UDP days, where the
>> UDP socket was kept over the life of the mountpoint and its source
>> port never changed. The NFS DRC took advantage of this, in, like, 1989.
>>
>> For TCP, SO_REUSEPORT was used to retain the semantic, but it's not
>> guaranteed to work (the port could be claimed by another socket, and
>> even if not, the network might still deliver old packets and cause
>> it to fail). Because the DRC is attempting to provide correctness,
>> it's IMO very unwise for a new server implementation to require
>> the source port to match.
>>
>> So, even if rdmacm now supports it, I don't think it's advisable to
>> implement port reuse for NFS/RDMA.
> 
> Nfscache uses following data for duplicate request match,
>          struct {
>                  /* Keep often-read xid, csum in the same cache line: */
>                  __be32                  k_xid;
>                  __wsum                  k_csum;
>                  u32                     k_proc;
>                  u32                     k_prot;
>                  u32                     k_vers;
>                  unsigned int            k_len;
>                  struct sockaddr_in6     k_addr;
>          } c_key;
> 
> Nfs-ganesha uses address(conatins port), xid, and a 256bytes checksum
> (libntirpc's rdma set it to zero now) for duplicate request match.
> 
> At nfs client, a xprt connect generate xid value for a rpc requst based on
> its own random number(xprt->xid = get_random_u32(); and xprt->xid++;).

The problem with the traditional DRC is that it's completely unspecified
and has been implemented in numerous different ways. And it's frequently
implemented with an LRU eviction policy, which is basically the opposite
of what's needed.

Then on top of that nobody really tests it. The "nfsidem" test that I
wrote for Connectathon performs a series of non-idempotent tests, but
it requires error injection to cause connection failures while it's
running.

I'd encourage you to try that. I predict you'll find many, many issues
in pre-NFSv4.1 servers.

https://git.linux-nfs.org/?p=steved/cthon04.git;a=summary

https://git.linux-nfs.org/?p=steved/cthon04.git;a=blob;f=special/nfsidem.c

BTW, thanks for mentioning nconnect. That's another good reason for not
looking at the source port - in addition to the source address!

Tom.

> 
> Like that, a NFS mount with single xprt connet can run correctly,
> two requests from the single xprt never contains a conflict xid;
> but for with more xprts (nconnect > 1), two requests from different xprt may
> contain the same xid from the same address(different port).
> 
> If port reuse is not guaranteed to work, we remove the use of the port from
> the server's DRC（like svcrdma set it to 0, or a new implementation）.
> 
> Like nfs-ganesha or some private DRC, they implements a drc pool for
> each client base on address, and match other keys(xid,checksum).
> Different xprts(same address, different port) shares a drc pool,
> unlucky, they check xid and a zero checksum.
> 
> If we agree with the meaningless of nfs client's port,
> and remove it from server's drc, xid generation should be modified
> to per client, not per xprt.
> 
> Thanks,
> Kinglong Mee
> 
>>
>> Tom.
>>
>>> I'll continue to sniff around and see if there's more to
>>> find out.
>>>
>>>
>>>> Thanks,
>>>> Kinglong Mee
>>>>
>>>>>>
>>>>>>>
>>>>>>> But perhaps my recollection is stale.
>>>>>>>
>>>>>>>
>>>>>>>> Maybe someone needs the src port at rpcrdma connect, I made those patches.
>>>>>>>>
>>>>>>>> For the knfsd and nfs client, I don't meet any problem.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Kinglong Mee
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
>>>>>>>>>> ---
>>>>>>>>>> net/sunrpc/xprtrdma/transport.c |  36 ++++++++++++
>>>>>>>>>> net/sunrpc/xprtrdma/verbs.c     | 100 ++++++++++++++++++++++++++++++++
>>>>>>>>>> net/sunrpc/xprtrdma/xprt_rdma.h |   5 ++
>>>>>>>>>> 3 files changed, 141 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
>>>>>>>>>> index 9a8ce5df83ca..fee3b562932b 100644
>>>>>>>>>> --- a/net/sunrpc/xprtrdma/transport.c
>>>>>>>>>> +++ b/net/sunrpc/xprtrdma/transport.c
>>>>>>>>>> @@ -70,6 +70,10 @@ unsigned int xprt_rdma_max_inline_write = RPCRDMA_DEF_INLINE;
>>>>>>>>>> unsigned int xprt_rdma_memreg_strategy = RPCRDMA_FRWR;
>>>>>>>>>> int xprt_rdma_pad_optimize;
>>>>>>>>>> static struct xprt_class xprt_rdma;
>>>>>>>>>> +static unsigned int xprt_rdma_min_resvport_limit = RPC_MIN_RESVPORT;
>>>>>>>>>> +static unsigned int xprt_rdma_max_resvport_limit = RPC_MAX_RESVPORT;
>>>>>>>>>> +unsigned int xprt_rdma_min_resvport = RPC_DEF_MIN_RESVPORT;
>>>>>>>>>> +unsigned int xprt_rdma_max_resvport = RPC_DEF_MAX_RESVPORT;
>>>>>>>>>>
>>>>>>>>>> #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>>>>>>>>>>
>>>>>>>>>> @@ -137,6 +141,24 @@ static struct ctl_table xr_tunables_table[] = {
>>>>>>>>>> .mode = 0644,
>>>>>>>>>> .proc_handler = proc_dointvec,
>>>>>>>>>> },
>>>>>>>>>> + {
>>>>>>>>>> + .procname = "rdma_min_resvport",
>>>>>>>>>> + .data = &xprt_rdma_min_resvport,
>>>>>>>>>> + .maxlen = sizeof(unsigned int),
>>>>>>>>>> + .mode = 0644,
>>>>>>>>>> + .proc_handler = proc_dointvec_minmax,
>>>>>>>>>> + .extra1 = &xprt_rdma_min_resvport_limit,
>>>>>>>>>> + .extra2 = &xprt_rdma_max_resvport_limit
>>>>>>>>>> + },
>>>>>>>>>> + {
>>>>>>>>>> + .procname = "rdma_max_resvport",
>>>>>>>>>> + .data = &xprt_rdma_max_resvport,
>>>>>>>>>> + .maxlen = sizeof(unsigned int),
>>>>>>>>>> + .mode = 0644,
>>>>>>>>>> + .proc_handler = proc_dointvec_minmax,
>>>>>>>>>> + .extra1 = &xprt_rdma_min_resvport_limit,
>>>>>>>>>> + .extra2 = &xprt_rdma_max_resvport_limit
>>>>>>>>>> + },
>>>>>>>>>> };
>>>>>>>>>>
>>>>>>>>>> #endif
>>>>>>>>>> @@ -346,6 +368,20 @@ xprt_setup_rdma(struct xprt_create *args)
>>>>>>>>>> xprt_rdma_format_addresses(xprt, sap);
>>>>>>>>>>
>>>>>>>>>> new_xprt = rpcx_to_rdmax(xprt);
>>>>>>>>>> +
>>>>>>>>>> + if (args->srcaddr)
>>>>>>>>>> + memcpy(&new_xprt->rx_srcaddr, args->srcaddr, args->addrlen);
>>>>>>>>>> + else {
>>>>>>>>>> + rc = rpc_init_anyaddr(args->dstaddr->sa_family,
>>>>>>>>>> + (struct sockaddr *)&new_xprt->rx_srcaddr);
>>>>>>>>>> + if (rc != 0) {
>>>>>>>>>> + xprt_rdma_free_addresses(xprt);
>>>>>>>>>> + xprt_free(xprt);
>>>>>>>>>> + module_put(THIS_MODULE);
>>>>>>>>>> + return ERR_PTR(rc);
>>>>>>>>>> + }
>>>>>>>>>> + }
>>>>>>>>>> +
>>>>>>>>>> rc = rpcrdma_buffer_create(new_xprt);
>>>>>>>>>> if (rc) {
>>>>>>>>>> xprt_rdma_free_addresses(xprt);
>>>>>>>>>> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
>>>>>>>>>> index 63262ef0c2e3..0ce5123d799b 100644
>>>>>>>>>> --- a/net/sunrpc/xprtrdma/verbs.c
>>>>>>>>>> +++ b/net/sunrpc/xprtrdma/verbs.c
>>>>>>>>>> @@ -285,6 +285,98 @@ static void rpcrdma_ep_removal_done(struct rpcrdma_notification *rn)
>>>>>>>>>> xprt_force_disconnect(ep->re_xprt);
>>>>>>>>>> }
>>>>>>>>>>
>>>>>>>>>> +static int rpcrdma_get_random_port(void)
>>>>>>>>>> +{
>>>>>>>>>> + unsigned short min = xprt_rdma_min_resvport, max = xprt_rdma_max_resvport;
>>>>>>>>>> + unsigned short range;
>>>>>>>>>> + unsigned short rand;
>>>>>>>>>> +
>>>>>>>>>> + if (max < min)
>>>>>>>>>> + return -EADDRINUSE;
>>>>>>>>>> + range = max - min + 1;
>>>>>>>>>> + rand = get_random_u32_below(range);
>>>>>>>>>> + return rand + min;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static void rpcrdma_set_srcport(struct rpcrdma_xprt *r_xprt, struct rdma_cm_id *id)
>>>>>>>>>> +{
>>>>>>>>>> +        struct sockaddr *sap = (struct sockaddr *)&id->route.addr.src_addr;
>>>>>>>>>> +
>>>>>>>>>> + if (r_xprt->rx_srcport == 0 && r_xprt->rx_xprt.reuseport) {
>>>>>>>>>> + switch (sap->sa_family) {
>>>>>>>>>> + case AF_INET6:
>>>>>>>>>> + r_xprt->rx_srcport = ntohs(((struct sockaddr_in6 *)sap)->sin6_port);
>>>>>>>>>> + break;
>>>>>>>>>> + case AF_INET:
>>>>>>>>>> + r_xprt->rx_srcport = ntohs(((struct sockaddr_in *)sap)->sin_port);
>>>>>>>>>> + break;
>>>>>>>>>> + }
>>>>>>>>>> + }
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static int rpcrdma_get_srcport(struct rpcrdma_xprt *r_xprt)
>>>>>>>>>> +{
>>>>>>>>>> + int port = r_xprt->rx_srcport;
>>>>>>>>>> +
>>>>>>>>>> + if (port == 0 && r_xprt->rx_xprt.resvport)
>>>>>>>>>> + port = rpcrdma_get_random_port();
>>>>>>>>>> + return port;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static unsigned short rpcrdma_next_srcport(struct rpcrdma_xprt *r_xprt, unsigned short port)
>>>>>>>>>> +{
>>>>>>>>>> + if (r_xprt->rx_srcport != 0)
>>>>>>>>>> + r_xprt->rx_srcport = 0;
>>>>>>>>>> + if (!r_xprt->rx_xprt.resvport)
>>>>>>>>>> + return 0;
>>>>>>>>>> + if (port <= xprt_rdma_min_resvport || port > xprt_rdma_max_resvport)
>>>>>>>>>> + return xprt_rdma_max_resvport;
>>>>>>>>>> + return --port;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static int rpcrdma_bind(struct rpcrdma_xprt *r_xprt, struct rdma_cm_id *id)
>>>>>>>>>> +{
>>>>>>>>>> + struct sockaddr_storage myaddr;
>>>>>>>>>> + int err, nloop = 0;
>>>>>>>>>> + int port = rpcrdma_get_srcport(r_xprt);
>>>>>>>>>> + unsigned short last;
>>>>>>>>>> +
>>>>>>>>>> + /*
>>>>>>>>>> +  * If we are asking for any ephemeral port (i.e. port == 0 &&
>>>>>>>>>> +  * r_xprt->rx_xprt.resvport == 0), don't bind.  Let the local
>>>>>>>>>> +  * port selection happen implicitly when the socket is used
>>>>>>>>>> +  * (for example at connect time).
>>>>>>>>>> +  *
>>>>>>>>>> +  * This ensures that we can continue to establish TCP
>>>>>>>>>> +  * connections even when all local ephemeral ports are already
>>>>>>>>>> +  * a part of some TCP connection.  This makes no difference
>>>>>>>>>> +  * for UDP sockets, but also doesn't harm them.
>>>>>>>>>> +  *
>>>>>>>>>> +  * If we're asking for any reserved port (i.e. port == 0 &&
>>>>>>>>>> +  * r_xprt->rx_xprt.resvport == 1) rpcrdma_get_srcport above will
>>>>>>>>>> +  * ensure that port is non-zero and we will bind as needed.
>>>>>>>>>> +  */
>>>>>>>>>> + if (port <= 0)
>>>>>>>>>> + return port;
>>>>>>>>>> +
>>>>>>>>>> + memcpy(&myaddr, &r_xprt->rx_srcaddr, r_xprt->rx_xprt.addrlen);
>>>>>>>>>> + do {
>>>>>>>>>> + rpc_set_port((struct sockaddr *)&myaddr, port);
>>>>>>>>>> + err = rdma_bind_addr(id, (struct sockaddr *)&myaddr);
>>>>>>>>>> + if (err == 0) {
>>>>>>>>>> + if (r_xprt->rx_xprt.reuseport)
>>>>>>>>>> + r_xprt->rx_srcport = port;
>>>>>>>>>> + break;
>>>>>>>>>> + }
>>>>>>>>>> + last = port;
>>>>>>>>>> + port = rpcrdma_next_srcport(r_xprt, port);
>>>>>>>>>> + if (port > last)
>>>>>>>>>> + nloop++;
>>>>>>>>>> + } while (err == -EADDRINUSE && nloop != 2);
>>>>>>>>>> +
>>>>>>>>>> + return err;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>>>>>>>>>>       struct rpcrdma_ep *ep)
>>>>>>>>>> {
>>>>>>>>>> @@ -300,6 +392,12 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>>>>>>>>>> if (IS_ERR(id))
>>>>>>>>>> return id;
>>>>>>>>>>
>>>>>>>>>> + rc = rpcrdma_bind(r_xprt, id);
>>>>>>>>>> + if (rc) {
>>>>>>>>>> + rc = -ENOTCONN;
>>>>>>>>>> + goto out;
>>>>>>>>>> + }
>>>>>>>>>> +
>>>>>>>>>> ep->re_async_rc = -ETIMEDOUT;
>>>>>>>>>> rc = rdma_resolve_addr(id, NULL, (struct sockaddr *)&xprt->addr,
>>>>>>>>>>          RDMA_RESOLVE_TIMEOUT);
>>>>>>>>>> @@ -328,6 +426,8 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
>>>>>>>>>> if (rc)
>>>>>>>>>> goto out;
>>>>>>>>>>
>>>>>>>>>> + rpcrdma_set_srcport(r_xprt, id);
>>>>>>>>>> +
>>>>>>>>>> return id;
>>>>>>>>>>
>>>>>>>>>> out:
>>>>>>>>>> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
>>>>>>>>>> index 8147d2b41494..9c7bcb541267 100644
>>>>>>>>>> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
>>>>>>>>>> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
>>>>>>>>>> @@ -433,6 +433,9 @@ struct rpcrdma_xprt {
>>>>>>>>>> struct delayed_work rx_connect_worker;
>>>>>>>>>> struct rpc_timeout rx_timeout;
>>>>>>>>>> struct rpcrdma_stats rx_stats;
>>>>>>>>>> +
>>>>>>>>>> + struct sockaddr_storage rx_srcaddr;
>>>>>>>>>> + unsigned short rx_srcport;
>>>>>>>>>> };
>>>>>>>>>>
>>>>>>>>>> #define rpcx_to_rdmax(x) container_of(x, struct rpcrdma_xprt, rx_xprt)
>>>>>>>>>> @@ -581,6 +584,8 @@ static inline void rpcrdma_set_xdrlen(struct xdr_buf *xdr, size_t len)
>>>>>>>>>>    */
>>>>>>>>>> extern unsigned int xprt_rdma_max_inline_read;
>>>>>>>>>> extern unsigned int xprt_rdma_max_inline_write;
>>>>>>>>>> +extern unsigned int xprt_rdma_min_resvport;
>>>>>>>>>> +extern unsigned int xprt_rdma_max_resvport;
>>>>>>>>>> void xprt_rdma_format_addresses(struct rpc_xprt *xprt, struct sockaddr *sap);
>>>>>>>>>> void xprt_rdma_free_addresses(struct rpc_xprt *xprt);
>>>>>>>>>> void xprt_rdma_close(struct rpc_xprt *xprt);
>>>>>>>>>> -- 
>>>>>>>>>> 2.47.0
>>>
>>>
>>> -- 
>>> Chuck Lever
>>>
>>>
>>
> 
> 


