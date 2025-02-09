Return-Path: <linux-nfs+bounces-9973-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FEEA2DA24
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 02:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976A61662B6
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 01:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FD4243386;
	Sun,  9 Feb 2025 01:24:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020096.outbound.protection.outlook.com [52.101.61.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372A4819;
	Sun,  9 Feb 2025 01:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739064295; cv=fail; b=kUxEkRghqFyIg1nuwTr4ES7CiQsPJ5rL/4GrzVMdbo4DfUL8dgCBv9uJmwMshYU82BBTf8whOmcpxtwMjiV+xpDFY4s7nmwxUeHbwA0h6mBJ78tLFDgBTtjAZeQ1tA+LVX7G7k8KQcxf+kZ7Y445Us02PbknbsIAo4r/KdQa7Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739064295; c=relaxed/simple;
	bh=WeffZpISub/M9a6gIJWRgPmMfZhwWCKWVef/Vy7lP4c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G+1mLp6SzHxN0NXz6yBQgaPzr11vXYn3I6pb4iBTT+HTVTbxGxO0oFmfgclPz0n/o5ndeRUaoo8Sva9h7jPjgGaxlTIHcr0Z5KXolkXlhl4xOyNra+BjGpc8ascB3h1KHgxzLEqqN7/fPnlxz4l0K+z6aW8vjbWifbTf3e3UzFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=52.101.61.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyzRPALsGxM/+9PQRS1Jx+4y4Ttgq46lVzLtmwwzh7EJFOwbCsDf7rFxfdvbfBWPt8HwlpSO5LvM6bOoD8C55A9PjPvMOHtAhJ6m8Mq23sa2sbXRIJJtEnmDAfgsQFRCkajWgl7jyiZGoBUiKnV/8WCrE/zvJKuLhNMMMcpR1Q4F5bEHWPYMV4bzdGeP2+FHZ11GBHKMG0u36Ig9kNKt38T8URSBgLRppdG8eph+A+zadM1e1jnk4p7X8wA+6Vqaj2OEQQqZxDlX6X8eD6qIU6P418OPq3no3PN2RxRtVEK57D5KoJEfJseVdLoGvq20ZXFjBSlCw1QLlhUOmGi8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEu9l7uq0sfBe9Pm6aCRypJVOhejmqBU65wZ7T7n9Ag=;
 b=aj+7G61eCAqjajVs7yUaUD0m7nGGiChnTZTt3Q82vgkQQF++ftXSwMARU9xbNA0ZX9oZoUeVpORkRl7uK4UjjrvB1MgPDRgz2XJSEUwKXNfPRt5TSTVavL+Au4k7CWzeiWoVV/x18dr+Czn6GTkqnxC17nk1zugq1H5r1eI6UOfQ86ediDz0TQKQfReTiZ8Ek6Hp7zh6mA5QbstcUrF0ATUCeY9ofy+sks+OOrDNsdVCIOr+VkLjn99Yrrbx/yykkSuavdmjDY1zlCJRvp7ERUxOwancIisd8n+xqHNu1vyDaAEzU7zYYKX1BXka465QibfPd+vaPBBsCEZ2R7+kfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 DM8PR01MB7112.prod.exchangelabs.com (2603:10b6:5:315::21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.9; Sun, 9 Feb 2025 01:24:49 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%6]) with mapi id 15.20.8445.005; Sun, 9 Feb 2025
 01:24:49 +0000
Message-ID: <ad26cab0-8f63-4ff7-a786-1d0ec51da490@talpey.com>
Date: Sat, 8 Feb 2025 20:24:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] nfsd: handle CB_SEQUENCE NFS4ERR_SEQ_MISORDERED
 error better
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
 <20250207-nfsd-6-14-v5-6-f3b54fb60dc0@kernel.org>
 <28174296-129d-4459-aa23-a94bbf00d257@oracle.com>
 <3e4d14075482489cd010e4ea621c0bd368700e27.camel@kernel.org>
 <40970e33-4689-4623-a423-b346e739ba80@talpey.com>
 <66532654ca25280ffa30168a977601ba4a37aaab.camel@kernel.org>
 <29e739f1-2d85-40c2-a549-5ab9d71686b0@talpey.com>
 <35cae0eb73781bb36c49aed2c2bc49a808698635.camel@kernel.org>
 <2f9fe86f-b49c-460c-bf2e-fed97970952d@oracle.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <2f9fe86f-b49c-460c-bf2e-fed97970952d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0477.namprd03.prod.outlook.com
 (2603:10b6:408:139::32) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|DM8PR01MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a783d92-d54c-4530-779b-08dd48a88b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnJ4T3RIRjVlYVJkVmE0bU1WUUwyakNxeWRpNUJtWXIyMFgyMjN5ek5RWXM5?=
 =?utf-8?B?SVlkWFNVL3hlYmFIREtDR0s5eHhzS0FEVXFmcjZSaUtZYnEvVGk0RkVWdHYw?=
 =?utf-8?B?MnRxOFFFUmx6bTR0Q2Z3anU2NVk0L3A5TTk4VzQxc3FwakNWNDN6UWNhczdw?=
 =?utf-8?B?MUI2bjJKc0haazlTRSsyM2RDZzI0Tm9JWGhLUmNBVUZtSXdxTW5yZTJYU0s2?=
 =?utf-8?B?ckJnNVh4WGd1YUZFcGNGSkxiblBzWGJKNVRLanp4MHFGTXNXRERKTGh0bE96?=
 =?utf-8?B?RkJIUUJFZzBkMGYwRUlHaVZYSFRWMnRPNGNHUHRaNk9nQVI4NnkvQm1OU0NN?=
 =?utf-8?B?YjdVd3drWVFXZ1hQYzZVdkljdTJ0b2NROVFSeWpsS1FQMmE5TU9ESFd6bnl2?=
 =?utf-8?B?R1JSdHFRSUZPY3UrVE9hOWJpM04rL1cwd2p4WFo1U0hrWDBtSjFiRTVKd0pK?=
 =?utf-8?B?ZW5QYzlKRCt5MW5rKzdaQVZhYm9rQVQzN1Q4dytwZTRNOTNtSGFXbkJnUk90?=
 =?utf-8?B?a0x0NVVpMVZuWGFPN2pIM29IcGdVVlhHeEZIYnl2VHlVbFgxTkVUUVhzZGd0?=
 =?utf-8?B?aGFlMUhxenRHNWxmNEx1cHlYakx4bytKdTNJcnQzR3JkSy9nenExWENBUGJm?=
 =?utf-8?B?dW4rRVl6dGxwWFVDMFdzNGtrak9vZklMclJUNXIvdkIzQlpHMkFNQU5EVU1I?=
 =?utf-8?B?Q1hWY1d6WTBVZ3F6M0J2NnFqZGtyZHpQMVorVU45ZEMyVlBMWHk1U21ldFhp?=
 =?utf-8?B?VDdHVTRYek85dFhTbGRXSjNPNmJST1hCc2JYMjhNNmRwTUhGUi96bnZFR3pM?=
 =?utf-8?B?L21wMGxMMW95MTB3VXg5cFF0Y01PMmtrY3RjNUZYeWRXdlhqNkR1N3ZHQ2Qy?=
 =?utf-8?B?bkFGMEMvQUdMOU5BTm5ReExlaWNKYWphZVA3Mmg4SUU1RDFVS05uSXBYRE0y?=
 =?utf-8?B?VUZnRlI4b2lSZFc2TnAzKzdXU3VtSHVWanBtUlV6cUlkUGhwL0JibkI5c2FH?=
 =?utf-8?B?cW5IODhKUnpyM1JtcW9YWllHMnFZa1dNM21ya2JNR0c2VkRLcU5SbUNITzB0?=
 =?utf-8?B?Z0dwVWNMTTFHSUVubUpnNnphMzJsdXVQOGFmdXRydzdrTEVCSC9RdXpHV0ox?=
 =?utf-8?B?TWFNa2Q2enV6enJrUXdQNWVuVm9ZNFFNT1NRQVdvT3dqNG5pcHFsbVhlSmRW?=
 =?utf-8?B?dmtDRXlIWjVVMHR1K2s0TFdoTjhXaEVYY0swMCt2bkFZVzFlaExEWEp0WTRa?=
 =?utf-8?B?d21QREx4ekkxVENUWkh1TDBRaDRGTERHbXR4dzY3djVlbVFFNXE2N2xRSkFr?=
 =?utf-8?B?K1dWSjAzbzRsdzhId0tpMGMxY3RDdW5NSzRtU3YrdHA0andlUWxEU2IxeEFt?=
 =?utf-8?B?QWhzc0RnSy9yWGZ3Tnc3eUlRVCtlUHJ5ODV5T1ZLR2kzUENFRzBqRjFjdUhr?=
 =?utf-8?B?NFQ2a1lpaElkRm1jR05Ra2p6VWFWNjJadnVTSVp5MFlKd3E5V0pxMkREcmRm?=
 =?utf-8?B?UkVxS3RCNWZVV0MrY1Bja3FTakRzS2JJL2lhV2VCZTZ4ak9GQ0NxbTVDL2RQ?=
 =?utf-8?B?cFRGQ1dOajVzZVRqMkp1STRDZldDdXB6Um9mRS95THNIekNwUkI4SW9uRnNj?=
 =?utf-8?B?Y21uSks3RWlWNVpmU3prWkNUc2VrYmJzY2tqRGdLd3dpOVNJcWZCY3FWVFhz?=
 =?utf-8?B?a1pqdFcyNmRvWGIybDZsTlRRdityQXlYWUVMZmFsWHNMM2Ryc1FzNVNiZ2lm?=
 =?utf-8?B?K0xoZnYyM0NybFVvNGJBazZ5NHk2ajlNRWdBWlVoeHpVSHhtK1g1cDJxYmVx?=
 =?utf-8?B?Q2tGZVU0VUpEVkxLSjdkeUYwNmZybVg5a3k1MnREZFVBbHpsSUtHcUxmMTFU?=
 =?utf-8?Q?lgNt7gzvV7eLw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHFyakkxUFA3TUl6cllHOFdkOFhmQkwwVjBQbW4xSVFQb2pPZjUrb2hxblE3?=
 =?utf-8?B?ZkhuSWVUMzZieW9Wakt5NEE4Q0tVSDNkaXg5VlJ5QXl6L0hyWkVnNjhIUnpl?=
 =?utf-8?B?YzZ0OVhjZVFEekNPaWVJVUpPV0RlZ0M1bkMwRmdBUkF1UnRDTk80c2NmanpX?=
 =?utf-8?B?RWFXZTk2TlNvMUI2ZTVGNEUycGFsRUhoeHdhKzVtYlBYN2NsN29MZklnaHVX?=
 =?utf-8?B?MXppekRaVDdpcDRkU25PSEw4bCtwc2ljcTZiZmtyeC9BUEw5c0t6Q3RoaFFN?=
 =?utf-8?B?RU1MZlJjUUxMSzhLTTZDVkNOK1RUUXBMNGdFNFc3ZG5jdmM3Tmx3K2VFZzd1?=
 =?utf-8?B?WEFHVzVPTnhDN1dZbWtaZjRoMTkyakx6OHUrd016UUQ1R2dLTkFjSjByb2Vq?=
 =?utf-8?B?TnRFUExyVHpkeVE1TmdpcHVQUGowcnhnRzBqSExNcjUrYWZkNHV6U1pNOFRv?=
 =?utf-8?B?dThkVFN5bFFNQy9xM3hRWktEZkR3MVdPeXoyb2h1WitsRkRsQ1ptR051Rklj?=
 =?utf-8?B?TDMyNzY0eVlGNWxQbEhwVTBjaUllV25ZUFVPNU83WFc2MWFSM3FrNkJyODd5?=
 =?utf-8?B?cGh2eTN1MXk1RUgvUVFLblROMGVvdDBNazlHS1dJN0Nvem5RdGJiVENIZTlP?=
 =?utf-8?B?QjdxeDRRUzk4SktMeFZZbUo5Vi8yM0J5YXl6dG5sbURvSWFTQ2tWaGgzSnB4?=
 =?utf-8?B?ZHZzMDBZN2VreS9YNkpReUIxVlB0T0ZLZ0VtazlLdXAxSTc1Mlg1aUpZcWlI?=
 =?utf-8?B?VHd5V1hBZUNnUlBCcWN1YUJQc3hJUkpYVmI5WGhxTXlMSjhrT3lBc3RXbTFj?=
 =?utf-8?B?aUVTNDJ3L053STNOU09rbzc1TFFmOW1jc1htSEZiUWRhSVlhM0ExYy85RkUv?=
 =?utf-8?B?V04zY2N0ckpBdGNmd0FOMG9uc1FEZnB1blFINXhxT2tWUW5rdXd1UGZHSTRs?=
 =?utf-8?B?OGcvdTllTWx0TGNrTUpOMURWcktKVGtPaTVPZDlLUjdEdGVvYXJmRFdFclFy?=
 =?utf-8?B?YndLaWJ6SHdjZUhjWXJDVnBrV0k1Vm1xWERyd2N6RjkveDh0eDB5OWlNc2hK?=
 =?utf-8?B?eXNjckZMUWEyZFRDNGJSaE41RGJyeE90OGFOak9zMWE2MUY5UW4rdFRudVZL?=
 =?utf-8?B?RlpmZlNtb0gvWnNyVkZHdnU4Zmp6NUhiTlVuZGswUGpXMFRsaGdvcnh2azRL?=
 =?utf-8?B?aStrOHpLa0hqOGIrd3JId29LTWVmSVN4U3Q3anNkNG1VYjVRRUp0THNZcW9Y?=
 =?utf-8?B?d1l5V0huQkorTUJ0d0dpSFRFZW1tMk9JN01vYlZkWC94ZStwYnZtaVRkM2N1?=
 =?utf-8?B?QVdQakhScUhVU2VhdmVHbUhjSjFkbk9QNGNKVXF2OS9EMEFucWc1RjViOGRY?=
 =?utf-8?B?VlpMWmJlRG9GcjROUGFvazdJM2IxME1sM1BIdnJRR1pjVXRNdU1GNnh3eFJv?=
 =?utf-8?B?Q1lDbHU0T2diWGN6UWM2RytLa2FNVzZVZktKSWZZYVd5eElJMDBuWUtOOGlt?=
 =?utf-8?B?YU1namR3SlNuYzRyOHNHZ01zVXVCcXVwZW5JTDhnUE5XK2dOZEtOUUQwY3Z5?=
 =?utf-8?B?cmpzeW1NUnMzRlgvaEJnd2FNdklUT2FHZ3NMaHk1WjVjUkxxTklWWG13QW14?=
 =?utf-8?B?cHFhUnduTDdBdWVWcWhjTzNGcFB1NldST0JWdnVSRlJnTUFRRW1kdHI0KzVi?=
 =?utf-8?B?S1hRaDFaZUF5QnlqOHV0eUczbkdXdGNLWTZ4b1JmbHJBMytuUm42aU5NWmhm?=
 =?utf-8?B?cGZLOWZaeWdxVzQ5dWRGNlc4dVNiOTBZdnV3T2FFcVJaa3VVd1loaitmUkU2?=
 =?utf-8?B?UDliZkZLSStsOElVWm5CY1pyODZVRlQ3MUlVZjZNVktYMjFyRS9RWkxwQ1pR?=
 =?utf-8?B?K1lLVS9tZ1J6WWhWNlhqeHN1UzRPdkRwUW1adExvTGZraDhaVUZqTzRXZEls?=
 =?utf-8?B?ZmhYNGdlRzJhMGtzcVZZY1VRMU9jWUd6NkRaQkdGL3ljekVRS082TFdPYjc1?=
 =?utf-8?B?TEZidEdpcFB2dkxFbnVFMEhsckw3QjdRMEkrcm5NeGkxMUlkdXdJSE1HT0d3?=
 =?utf-8?B?QkdzcEh6N1Roa1N2UCszQmh1ZGthRndRaEdsRjJONDdTaDlGNW83ZGpoa09Y?=
 =?utf-8?Q?b3Bo=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a783d92-d54c-4530-779b-08dd48a88b8a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 01:24:49.0765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/6NrPhow7hHGIaNuDbsufmCStK3rCMOSHHtijDyYWwdlmD5DHYF/8xkSGY4+dVL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7112

On 2/8/2025 4:07 PM, Chuck Lever wrote:
> On 2/8/25 3:45 PM, Jeff Layton wrote:
>> On Sat, 2025-02-08 at 14:18 -0500, Tom Talpey wrote:
>>> On 2/8/2025 11:08 AM, Jeff Layton wrote:
>>>> On Sat, 2025-02-08 at 13:40 -0500, Tom Talpey wrote:
>>>>> On 2/8/2025 10:02 AM, Jeff Layton wrote:
>>>>>> On Sat, 2025-02-08 at 12:01 -0500, Chuck Lever wrote:
>>>>>>> On 2/7/25 4:53 PM, Jeff Layton wrote:
>>>>>>>> For NFS4ERR_SEQ_MISORDERED, do one attempt with a seqid of 1, and then
>>>>>>>> fall back to treating it like a BADSLOT if that fails.
>>>>>>>>
>>>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>>>> ---
>>>>>>>>     fs/nfsd/nfs4callback.c | 16 ++++++++++------
>>>>>>>>     1 file changed, 10 insertions(+), 6 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>>>>>>> index 10067a34db3afff8d4e4383854ab9abd9767c2d6..d6e3e8bb2efabadda9f922318880e12e1cb2c23f 100644
>>>>>>>> --- a/fs/nfsd/nfs4callback.c
>>>>>>>> +++ b/fs/nfsd/nfs4callback.c
>>>>>>>> @@ -1393,6 +1393,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>>>>>>     			goto requeue;
>>>>>>>>     		rpc_delay(task, 2 * HZ);
>>>>>>>>     		return false;
>>>>>>>> +	case -NFS4ERR_SEQ_MISORDERED:
>>>>>>>> +		/*
>>>>>>>> +		 * Reattempt once with seq_nr 1. If that fails, treat this
>>>>>>>> +		 * like BADSLOT.
>>>>>>>> +		 */
>>>>>>>
>>>>>>> Nit: this comment says exactly what the code says. If it were me, I'd
>>>>>>> remove it. Is there a "why" statement that could be made here? Like,
>>>>>>> why retry with a seq_nr of 1 instead of just failing immediately?
>>>>>>>
>>>>>>
>>>>>> There isn't one that I know of. It looks like Kinglong Mee added it in
>>>>>> 7ba6cad6c88f, but there is no real mention of that in the changelog.
>>>>>>
>>>>>> TBH, I'm not enamored with this remedy either. What if the seq_nr was 2
>>>>>> when we got this error, and we then retry with a seq_nr of 1? Does the
>>>>>> server then treat that as a retransmission?
>>>>>
>>>>> So I assume you mean the requester sent seq_nr 1, saw a reply and sent a
>>>>> subsequent seq_nr 2, to which it gets SEQ_MISORDERED.
>>>>>
>>>>> If so, yes definitely backing up the seq_nr to 1 will result in the
>>>>> peer considering it to be a retransmission, which will be bad.
>>>>>
>>>>
>>>> Yes, that's what I meant.
>>>>
>>>>>> We might be best off
>>>>>> dropping this and just always treating it like BADSLOT.
>>>>>
>>>>> But, why would this happen? Usually I'd think the peer sent seq_nr X
>>>>> before it received a reply to seq_nr X-1, which would be a peer bug.
>>>>>
>>>>> OTOH, SEQ_MISORDERED is a valid response to an in-progress retry. So,
>>>>> how does the requester know the difference?
>>>>>
>>>>> If treating it as BADSLOT completely resets the sequence, then sure,
>>>>> but either a) the request is still in-progress, or b) if a bug is
>>>>> causing the situation, well it's not going to converge on a functional
>>>>> session.
>>>>>
>>>>
>>>> With this patchset, on BADSLOT, we'll set SEQ4_STATUS_BACKCHANNEL_FAULT
>>>> in the next forechannel SEQUENCE on the session. That should cause the
>>>> client to (eventually) send a DESTROY_SESSION and create a new one.
>>>>
>>>> Unfortunately, in the meantime, because of the way the callback channel
>>>> update works, the server can end up trying to send the callback again
>>>> on the same session (and maybe more than once). I'm not sure that
>>>> that's a real problem per-se, but it's less than ideal.
>>>>
>>>>> Not sure I have a solid suggestion right now. Whatever the fix, it
>>>>> should capture any subtlety in a comment.
>>>>>
>>>>
>>>> At this point, I'm leaning toward just treating it like BADSLOT.
>>>> Basically, mark the backchannel faulty, and leak the slot so that
>>>> nothing else uses it. That allows us to send backchannel requests on
>>>> the other slots until the session gets recreated.
>>>
>>> Hmm, leaking the slot is a workable approach, as long as it doesn't
>>> cascade more than a time or two. Some sort of trigger should be armed
>>> to prevent runaway retries.
>>>
>>> It's maybe worth considering what state the peer might be in when this
>>> happens. It too may effectively leak a slot, and if is retaining some
>>> bogus state either as a result of or because of the previous exchange(s)
>>> then this may lead to future hangs/failures. Not pretty, and maybe not
>>> worth trying to guess.
>>>
>>> Tom.
>>>
>>
>>
>> The idea here is that eventually the client should figure out that
>> something is wrong and reestablish the session. Currently we don't
>> limit the number of retries on a callback.
>>
>> Maybe they should time out after a while? If we've retried a callback
>> for more than two lease periods, give up and log something?
>>
>> Either way, I'd consider that to be follow-on work to this set.
> 
> As a general comment, I think making a heroic effort to recover in any
> of these cases is probably not worth the additional complexity. Where it
> is required or where we believe it is worth the trouble, that's where we
> want a detailed comment.
> 
> What we want to do is ensure forward progress. I'm guessing that error
> conditions are going to be rare, so leaking the slot until a certain
> portion of them are gone, and then indicating a session fault to force
> the client to start over from scratch, is probably the most
> straightforward approach.
> 
> So, is there a good reason to retry? There doesn't appear to be any
> reasoning mentioned in the commit log or in nearby comments.

Agreed on the general comment.

As for the "any reason to retry" - maybe. If it's a transient error we
don't want to give up early. Unfortunately that appears to be an
ambiguous situation, because SEQ_MISORDERED is allowed in place of
ERR_DELAY. I don't have any great suggestion however.

Jeff, to your point that the "client should figure out something is
wrong", I'm not sure how you think that will happen. If the server is
making a delegation recall and the client receive code chooses to reject 
it at the sequence check, how would that eventually cause the client to
reestablish the session (on the forechannel)?

Tom.

> 
> 
>>>>>> Thoughts?
>>>>>>
>>>>>>>
>>>>>>>> +		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
>>>>>>>> +			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
>>>>>>>> +			goto retry_nowait;
>>>>>>>> +		}
>>>>>>>> +		fallthrough;
>>>>>>>>     	case -NFS4ERR_BADSLOT:
>>>>>>>>     		/*
>>>>>>>>     		 * BADSLOT means that the client and server are out of sync
>>>>>>>> @@ -1403,12 +1413,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>>>>>>     		nfsd4_mark_cb_fault(cb->cb_clp);
>>>>>>>>     		cb->cb_held_slot = -1;
>>>>>>>>     		goto retry_nowait;
>>>>>>>> -	case -NFS4ERR_SEQ_MISORDERED:
>>>>>>>> -		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
>>>>>>>> -			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
>>>>>>>> -			goto retry_nowait;
>>>>>>>> -		}
>>>>>>>> -		break;
>>>>>>>>     	default:
>>>>>>>>     		nfsd4_mark_cb_fault(cb->cb_clp);
>>>>>>>>     	}
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 
> 


