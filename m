Return-Path: <linux-nfs+bounces-9104-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B927A09607
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 16:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57A33A9CE4
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DC4211A02;
	Fri, 10 Jan 2025 15:40:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021108.outbound.protection.outlook.com [40.93.199.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90691FA15C
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523637; cv=fail; b=sfKauDCsXyrkjFr34Bi5rMULdhk6lsa52kQlP0h1OHBM+8mu5P5/q6cgeSPnNP6qHXeAlhNBYmQfwMmXblLo/yeAf3u0pz0tWYrx+UqKBHRIMb0AGijA6XOJXAyjlFm1/xw9puPL7spVWKXQ6YgklX+JrCWxVZo6wKlOqOq8ues=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523637; c=relaxed/simple;
	bh=qhQUJ0nlPN3h/kbfim+WNN+yzOR9j5UUjRjl1Birrdc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PirAvskOjeY3tugRhJK4S7PW2WrOMMtl8g0nwZAbO/bUWMMRlfomKLlWwIfgadXw6bmFOr1p5Ecx0YMNG3TMOFhjhT51NuIRmKBTZjVT5h6XtJ/tGJVTyNJ7U6HTGgB0YMESGKTnSsecdRNAfDlwWc+eFqN71iW0ZUfWiGxmCBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.93.199.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wblUKCt23+I2H627mxSi8zFTCnDVvtxeMlqWd5yFPJgV82GFJtXg1QH8ZDCQGCz8hjUGCytnrN8bVqWDX0U2OY249j6fl3ZZB9axOLBxqt2P7uPtvq0q9Yercdbdp7H8KZ7chkdrRZAJPQrTOiRW3T8AfiAl89vBYD2cktNxTeKiagVxyJqYFIPMzliRjZelYWqER+OHPkx+nKdbdkUe4R/0s6vFH2pLPpkwuAQ1KpCWYRyn1IB7oWjTgAcusovxfNlG/b5gdFsQuBwRf/HQsId4+mE+RyCwNinVgkfJ5jyDE35RW2mHcMd/z9DQtf/jArBqpabpgzBWOlhKdVLvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7ZvEDV1CZfMn2gZ4Bq2CXTBJdf8zFQFEtCb3KLm/HI=;
 b=rnyAy8EGN/Q1twoGhOpNjj3+SwWisjKWJSFPpo0dPDcY2uEp6YMIRGtDEOXwIumEVhwAAzmYW1lgCpfY6Dl6jCOId3uM4UqvzIQMSakCF870pqDI5vufpMzl2llX1oUieWYCmhlUrp7PsImwBEjb3Kc4MU0qjI949RBIOdhlZ/8aX9+2/T6CvJy9X1E/u+huBMGfugMxVfD5k4pwsSISBsHaPcAzaelwwRWxsG+G02j07OroaOmdMqDPjOLaJR/X01ZAuZaV3yEi5BChuhAYPu8SED18u2ru89wn94Tdse1cob8wpb8/CmX1xo4OnvMhHqAMF6WPjw0bydVlygbEZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 IA0PR01MB8256.prod.exchangelabs.com (2603:10b6:208:48f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.11; Fri, 10 Jan 2025 15:40:31 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%5]) with mapi id 15.20.8335.003; Fri, 10 Jan 2025
 15:40:31 +0000
Message-ID: <65f2226e-0e7f-4969-bc16-d4d56d2a5cb8@talpey.com>
Date: Fri, 10 Jan 2025 10:40:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] nfsdctl: add necessary bits to configure lockd
To: Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>
Cc: Scott Mayhew <smayhew@redhat.com>, Yongcheng Yang <yoyang@redhat.com>,
 linux-nfs@vger.kernel.org
References: <20250110-lockd-nl-v2-0-e3abe78cc7fb@kernel.org>
 <20250110-lockd-nl-v2-3-e3abe78cc7fb@kernel.org>
 <6c6bdf9b-858b-4a10-9317-f55aeda1ab80@talpey.com>
 <5b7b7284cb844b36ab89e77689f5baf5035f93e1.camel@kernel.org>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <5b7b7284cb844b36ab89e77689f5baf5035f93e1.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR14CA0002.namprd14.prod.outlook.com
 (2603:10b6:408:e3::7) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|IA0PR01MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e921da-0156-4ce3-d45d-08dd318d1d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V21LbVNLbWRRdGhkZ012THBCbFR4UlF0L1hSQXJ2ZFNma3A5V2FtZ0lvUUxp?=
 =?utf-8?B?WkNoOWs5NlZhSEsrNGVWNXMzZzlDcXFQVnBnU0FNYncraVFrbVdZYUV1TDkz?=
 =?utf-8?B?Z3I2akkwZzl5a3l2UTdnbEhiM1g4OUNSWm5hQXpVWnRhR1J5NHFReC9NaGlY?=
 =?utf-8?B?TlJZb1hEUFllZ0hxOWZYNnhtVEhsdzR3OEdOQjUyWEFlZm42bjhWSm5RZFho?=
 =?utf-8?B?aVpmYVAzWVRVakl6cnZtaUNxQUUvaVNBUXkzRDdVWmsza2o0eWxHMGdqSy95?=
 =?utf-8?B?c0ZlanY0Mk5FRkxITUp0R1NVOHRWM1JSVUY1NVQxV3NMellYcVFWMm5ZN2dZ?=
 =?utf-8?B?dGFsK1BIcXBSSHNNN005S2ZnaUIveGQ2a0RvNWNqa2N5YXlBZjd6MkZUNGNv?=
 =?utf-8?B?QmdhK3NUeHkrVnRRbDFjRUQzZ3ZUdjIwdjdxdGJNSW5ib0RnUVNoWTZBdTVP?=
 =?utf-8?B?YVNLSUJBVDRtcTBYV3M4bVpSL0wrME55c1JrNjUrTGpGa21ZaVZIai96MG4z?=
 =?utf-8?B?bXB4bkk1MFJjSXNZcGdCa2g2N0c1VHp4S09OQkNCL0NVYmRBSC9FMG9IbFBt?=
 =?utf-8?B?ZXpJVDgrekk1UzBJNE5LdUp5QU1tT0pwNTkzUE1VUjRhaFpnVnFqYnZta3Ey?=
 =?utf-8?B?bE9MMnVqN2YvS3BqSUpUbVVHYW1JeXJtOEw4LzZxQVVMemEySXhPWVJzaURs?=
 =?utf-8?B?V3pSWnZmRTlSTDMvbTh6Y3NTai8wMmFDZUVNQnFYREVZSkZNZ1JKS21vNXRi?=
 =?utf-8?B?cFI0cExpeWZCTkREblU0RU9KckpKcnA0UWtiNHFHc2RXQTNnM284QkJEaFls?=
 =?utf-8?B?RkNBVDdBT0JPSkRFa2dCaXJLZmxTeU1uV0JNdUU4R0FJWTBVRExZM1I2QWFT?=
 =?utf-8?B?NkJzSTNjaGwvL0htTmNRbHQ3bTRMdDZmSUhkdmwzTHpJODUxSE5IT2NwbjY4?=
 =?utf-8?B?ZmJZeEplK1dWQVpFbGZYN2ozVEtCSERna0c5bWh5YVNORDlWU2ZTZVZSb1d5?=
 =?utf-8?B?c05SM2pSYkpTemY1bi9UbVdUS1Q3b0F5OWJUVml1ajN2N0s0Z1ZjdjBvR292?=
 =?utf-8?B?NFF1Y2dKK05pREZ1U0RFb3R2SWlPQXFMQ0R3dUFVZ0VCV2hENVhwVWl6N3ZI?=
 =?utf-8?B?cEl5QlY3QitzQm5LRlJXZkZHc0kwaHRiaXpmcmFDWGl5ZlpsRjdkRk0wbkNu?=
 =?utf-8?B?T3FrVkk5Y0g4QVFrWFVIM1FEOFBjaDJtUnd4VDByVkdCdUswRERiMU5DWDFV?=
 =?utf-8?B?SHUvMGNlL3JLbFJMUlozelpQUzg0Nm9QN29YSTFEYWZtOXlvZXdIcGkrcGN0?=
 =?utf-8?B?cnpBdjFYZWhTOFpxVEUvc0ZYclpoY202U3k2NlZzUVpuRTF4MTJ1MStnQkVF?=
 =?utf-8?B?NlhmYVRkeXBOTC9zUkw4WitjZ0pob1VJV2cxQzl3aUcwcjVxR1BsQnU1aXlQ?=
 =?utf-8?B?WkZ0M2FuKzM4ZThRRC93aXQyd0owbjQ3YXhwcWRyT3VNcU92OGIyL01BSFhD?=
 =?utf-8?B?TXRWUExnUEVPTkFIcnA4UmpzM3FWUVJBeXFweVZyN2Jvckd4YW4veVdXb1ZO?=
 =?utf-8?B?dDFXUHNOQVVFdjIrVlZldEhWZHBla3hCZ280VFFPaEI0WFRGU0NGZE5sOVp6?=
 =?utf-8?B?UnliVHBJem5ET2RKNkxHMzBpQ0dUL0ZSMXpnZVd6VHdOU25rNFMwV1ZCOFJK?=
 =?utf-8?B?bjdSNWcvamxaN1V0Ukl4VmRaMjVMRkYyNUJtdXE4VjhvV242RWJFWmd1SThK?=
 =?utf-8?B?a0pGcTFEdnVkeE54Y2hBbkVyV25icWd0Q1VyVXBERDNuVm51SmUrVDVxekpH?=
 =?utf-8?B?dTY0WXNsV2JDL28wN1R0WTRTdGNYNENxcmRnMkE1WWhmbnhQRFRWd1VMZDBu?=
 =?utf-8?Q?LDVNNbD3+E9mF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnV3LzBCUWQwci9yK2ZSQzRSSjIvTGE0VVN3ODRZQTMvZkQzRDFuTGtoR2VG?=
 =?utf-8?B?TzJxOEZqdlhBNmdJT3pjQS93TWlXUjlTUnR0NnVjUUVXcDdUR2FEZlFlVkxR?=
 =?utf-8?B?eGdtcVM1Njh5bXFicHpCR3N3VTMrRTZsYmROdklxYjJDRFJpT1dYdjZkajNa?=
 =?utf-8?B?M2RkSmxjMWg5NkZLeTRlYThSTTBrcTVSTCtVUGY4Q3N6SVVuTDhXdHRPYkJk?=
 =?utf-8?B?eW96TDlWT3k1dXNuenNqZzFFUEhYYnE0UUtPZGkxY2VHRUtROFFqUWRvcjFH?=
 =?utf-8?B?K0dOR3I1bDdRNUs1eWI5TkdjMVFUak5HMjk0ZnF0bHRHOGN6dStOOW1salQz?=
 =?utf-8?B?c0lJOWtES2ZFNHcvWDRHNEdLYkVydWhsNnBTOFJYVXQvZlVhdWFKQ0hwektK?=
 =?utf-8?B?bXZ2L2VySXQ2UzVad0pvZnVRTENsY2pUOHluUC84enRpVFAvWFZWTmNlNGtC?=
 =?utf-8?B?czJuYzl3Mnk4RHpGdnA4b3BFWDE3ckw5UHMyd0d0djk2bk9KbnhFUlZOYWxX?=
 =?utf-8?B?cDF6VFZDcHNWck1Yb2dQcDFEeEVQOEwwNStVNjNaSkxZQ04xTFUzaUVISVl5?=
 =?utf-8?B?THpzbElucFlVUExFdmtWdjIvYzNTRzNmS2paeitWSFRlZHdvNjIzMVNROEdW?=
 =?utf-8?B?U2UxSEpBdUZ3L3N6ZEZoTnRtRUpjUUd3b2hzR0V5cEhUcGlORVhOdEdNNzM0?=
 =?utf-8?B?SnZ2cEcrNU14TkxZVHFFTk1SVFRyTE9zZWFxSnlxbXN2aDZINFd1bFpUWmhj?=
 =?utf-8?B?T1A5blozMnUxcG5ibWtGKzVucjVmKzlmeEtEdWhjRTR0UndYRTZQeVFUVTY5?=
 =?utf-8?B?MEFzZWsvdFk3c0g2azM2ODNHNkhqSWYwQ3Y2NkhSS2RkTUR0QnhjYWZJOG5S?=
 =?utf-8?B?VHpVWTRvNHVscUhMMFJnZkdNclgyd3NwUnk3SHZFVGw0SUhRbmNVc2N0ZXpR?=
 =?utf-8?B?dllIZy9hdXNWb09nV1lyenlrVUlqVU1ZcGw0eDlpc0Mwa1dJb211RmNmSnBm?=
 =?utf-8?B?TmkyMklRQ2JYL3JmaUhyakJDTUFKbGRUTDRUVE1nUkxqb0k2NGo5eFlLakdh?=
 =?utf-8?B?SGV4WUhnRDZoVmpXK1dHeVB0cVQyNHlMOWRmc29MTnFJZUphR1BPK0h1dGkv?=
 =?utf-8?B?SmtlVmd0bDRzaitUT1NSOEM0QW9HSi8vQ0ZDVytNc0NhZmF1R3d3S0pLRE9x?=
 =?utf-8?B?U1doT0d1MUY2U0JPbWNpSVlOdnNPWVJtd1JZQVhRMHhocS80TFNpVzBTWS9I?=
 =?utf-8?B?aFlUaktocUhQMjd0Qm13VmpkV1BiN0pkUGlDdVc4WXRJd2dIQ3BURGIxaGYw?=
 =?utf-8?B?MmdKSi9RcG1aTnZ2Mk5NWUlEa2F0c3ZlNnhPT3U0UDdORWhrS3YxRmN2bWlF?=
 =?utf-8?B?SmRqRVA5KzBZeDNXbktUaVJRWTg1a3lCUmpFbWdkQ0xMTXJqa2pua1daKzBP?=
 =?utf-8?B?UnZzNVp5WkpNaHpEaVVOQ0JvSWk0OVM4b0dZMUtaV3kxT0swM2FYMWRHK0Zz?=
 =?utf-8?B?TnVPMUo4eGdSeHQ0QkRyVlExVVBWWDdLQjZaSndHVmtpay91cUlxbG1NSkNw?=
 =?utf-8?B?MHZ1VmZiVVFhaVY3Q3pxUjV2K01rdlErbksxNk9oVG1wNkFxbDNTMWZUcklX?=
 =?utf-8?B?a29XVEkzWExGd3F5NVg3UEJ0TnVUTWtWZ0hpd29CTDZaZGdvQ3Y0Y29EN0VS?=
 =?utf-8?B?Y0xSdGYyOVJyOC9RRStvNWlQa2Y3Rkd2S1JONHFXYTQrZ0t2Tkcrdm0zdFFM?=
 =?utf-8?B?ZUJ1M2FiN1ZiZGljSFkvMnhQQ3RsZ3paemNURHNHWFErSG9WdzNhNHNDT0Q4?=
 =?utf-8?B?UW1Hd2FUbzFpdllteUFLMk9WVEpHODFtNXk3WFd0Z2p6Y0hZcXIzVHFTZmt6?=
 =?utf-8?B?YXpBZ3FNVEl4ZUx5NjVxa2FSVVRaSzZMcUhjcmwxNUZKRjFOMG45VlJiKzVT?=
 =?utf-8?B?cGtObmNTZkMxbGswQ1J1VDE5K1F1NVNCamx1TGhGczUwdlVaS3lDM0s1dHgx?=
 =?utf-8?B?WXIySG1qa3lWcWxGRGg2QU9tdFVpNHR3b3NuanBmYUtTQWlZUDNPSXBlUnl3?=
 =?utf-8?B?cml5dDl3ZGIvYUVlamNoa2llM2xpYzhhV0hhSnI2bkZYRGlZOXVnT1lUakx5?=
 =?utf-8?Q?admw=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e921da-0156-4ce3-d45d-08dd318d1d95
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 15:40:31.4553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UtJU7hFcxxHYuZ2ObN52fT5bmBh82Sr11j+swGYEljaQZAGzwJ+sXu5jPSFG2H6q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8256

On 1/10/2025 10:21 AM, Jeff Layton wrote:
> On Fri, 2025-01-10 at 10:05 -0500, Tom Talpey wrote:
>> On 1/10/2025 8:46 AM, Jeff Layton wrote:
>>> The legacy rpc.nfsd program would configure the nlm_grace_period to
>>> match the NFSv4 grace period when starting the server. This adds similar
>>> functionality to the autostart subcommand using the new lockd netlink
>>> configuration interfaces. In addition, if lockd's udp or tcp listener
>>> ports are specified, also configure them before starting the server.
>>>
>>> A "nlm" subcommand is also added that will display the current lockd
>>> config settings in the current net ns. In the future, we could add the
>>> ability to set these values using the "nlm" subcommand, but for now I
>>> didn't see a real use-case for that, so I left it out.
>>
>> It seems unnatural that the nlm_grace_period is tied to the netns.
>>
>> It seems to me it's more dependent on the network and its likely
>> failure modes, the backend storage/filesystem, and perhaps the
>> scale of clients performing possibly-conflicting locks. Oh, and
>> also perhaps the minor version, since 4.1+ have the RECLAIM_COMPLETE
>> termination event.
>>
>> Food for thought, perhaps.
>>
>> Tom.
>>
> 
> Fair point. More food:
> 
> My guess is that nlm_grace_period handling is likely horribly broken in
> multi-container scenarios anyway. If you have multiple nfs server
> containers with different grace period settings, then they will all be
> competing to set the global nlm_grace_period.
> 
> Most clients end up reclaiming quickly enough that we don't hit major
> problems here, but it would be good to make this more "airtight".

The grace period can has been kicked down the road since nineteen
ninety ump so, sure, what the heck :)

I wonder how many sysadmins are actually changing it, and why. It's
not truly a correctness thing, more of an availability setting, so
the choice of value is pretty soft. As you say, if the clients all
reclaim promptly, nobody's the wiser. Do we have any data on how
often the setting actually gets used?

Tom.

> 
>>>
>>> Link: https://issues.redhat.com/browse/RHEL-71698
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>    configure.ac                  |   4 +
>>>    utils/nfsdctl/lockd_netlink.h |  29 ++++++
>>>    utils/nfsdctl/nfsdctl.8       |   6 ++
>>>    utils/nfsdctl/nfsdctl.adoc    |   5 +
>>>    utils/nfsdctl/nfsdctl.c       | 218 +++++++++++++++++++++++++++++++++++++++---
>>>    5 files changed, 249 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/configure.ac b/configure.ac
>>> index 561e894dc46f48997df4ba6dc3e7691876589fdb..1d865fbc1c7f79e3ac6152bc59995e99fe10a38e 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -268,6 +268,10 @@ AC_ARG_ENABLE(nfsdctl,
>>>    				                   [[int foo = NFSD_CMD_POOL_MODE_GET;]])],
>>>    				   [AC_DEFINE([USE_SYSTEM_NFSD_NETLINK_H], 1,
>>>    					      ["Use system's linux/nfsd_netlink.h"])])
>>> +		AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/lockd_netlink.h>]],
>>> +				                   [[int foo = LOCKD_CMD_SERVER_GET;]])],
>>> +				   [AC_DEFINE([USE_SYSTEM_LOCKD_NETLINK_H], 1,
>>> +					      ["Use system's linux/lockd_netlink.h"])])
>>>    	fi
>>>    
>>>    AC_ARG_ENABLE(nfsv4server,
>>> diff --git a/utils/nfsdctl/lockd_netlink.h b/utils/nfsdctl/lockd_netlink.h
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..21c65aec3bc6d1839961937081e6d16540332179
>>> --- /dev/null
>>> +++ b/utils/nfsdctl/lockd_netlink.h
>>> @@ -0,0 +1,29 @@
>>> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
>>> +/* Do not edit directly, auto-generated from: */
>>> +/*	Documentation/netlink/specs/lockd.yaml */
>>> +/* YNL-GEN uapi header */
>>> +
>>> +#ifndef _UAPI_LINUX_LOCKD_NETLINK_H
>>> +#define _UAPI_LINUX_LOCKD_NETLINK_H
>>> +
>>> +#define LOCKD_FAMILY_NAME	"lockd"
>>> +#define LOCKD_FAMILY_VERSION	1
>>> +
>>> +enum {
>>> +	LOCKD_A_SERVER_GRACETIME = 1,
>>> +	LOCKD_A_SERVER_TCP_PORT,
>>> +	LOCKD_A_SERVER_UDP_PORT,
>>> +
>>> +	__LOCKD_A_SERVER_MAX,
>>> +	LOCKD_A_SERVER_MAX = (__LOCKD_A_SERVER_MAX - 1)
>>> +};
>>> +
>>> +enum {
>>> +	LOCKD_CMD_SERVER_SET = 1,
>>> +	LOCKD_CMD_SERVER_GET,
>>> +
>>> +	__LOCKD_CMD_MAX,
>>> +	LOCKD_CMD_MAX = (__LOCKD_CMD_MAX - 1)
>>> +};
>>> +
>>> +#endif /* _UAPI_LINUX_LOCKD_NETLINK_H */
>>> diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
>>> index 39ae1855ae50e94da113981d5e8cf8ac14440c3a..d69922448eb17fb155f05dc4ddc9aefffbf966e4 100644
>>> --- a/utils/nfsdctl/nfsdctl.8
>>> +++ b/utils/nfsdctl/nfsdctl.8
>>> @@ -127,6 +127,12 @@ colon separated form, and must be enclosed in square brackets.
>>>    .if n .RE
>>>    .RE
>>>    .sp
>>> +\fBnlm\fP
>>> +.RS 4
>>> +Get information about NLM (lockd) settings in the current net namespace. This
>>> +subcommand takes no arguments.
>>> +.RE
>>> +.sp
>>>    \fBstatus\fP
>>>    .RS 4
>>>    Get information about RPCs currently executing in the server. This subcommand
>>> diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
>>> index 2114693042594297b7c5d8600ca16813a0f2356c..0207eff6118d2dcc5a794d2013c039d9beb11ddc 100644
>>> --- a/utils/nfsdctl/nfsdctl.adoc
>>> +++ b/utils/nfsdctl/nfsdctl.adoc
>>> @@ -67,6 +67,11 @@ Each subcommand can also accept its own set of options and arguments. The
>>>      addresses must be in dotted-quad form. IPv6 addresses should be in standard
>>>      colon separated form, and must be enclosed in square brackets.
>>>    
>>> +*nlm*::
>>> +
>>> +  Get information about NLM (lockd) settings in the current net namespace. This
>>> +  subcommand takes no arguments.
>>> +
>>>    *status*::
>>>    
>>>      Get information about RPCs currently executing in the server. This subcommand
>>> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
>>> index 5c319a74273fd2bbe84003c1261043c4b2f1ff29..003daba5f30a403eb4168f6103e5a496d96968a4 100644
>>> --- a/utils/nfsdctl/nfsdctl.c
>>> +++ b/utils/nfsdctl/nfsdctl.c
>>> @@ -35,6 +35,12 @@
>>>    #include "nfsd_netlink.h"
>>>    #endif
>>>    
>>> +#ifdef USE_SYSTEM_LOCKD_NETLINK_H
>>> +#include <linux/lockd_netlink.h>
>>> +#else
>>> +#include "lockd_netlink.h"
>>> +#endif
>>> +
>>>    #include "nfsdctl.h"
>>>    #include "conffile.h"
>>>    #include "xlog.h"
>>> @@ -348,6 +354,28 @@ static void parse_pool_mode_get(struct genlmsghdr *gnlh)
>>>    	}
>>>    }
>>>    
>>> +static void parse_lockd_get(struct genlmsghdr *gnlh)
>>> +{
>>> +	struct nlattr *attr;
>>> +	int rem;
>>> +
>>> +	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
>>> +			  genlmsg_attrlen(gnlh, 0), rem) {
>>> +		switch (nla_type(attr)) {
>>> +		case LOCKD_A_SERVER_GRACETIME:
>>> +			printf("gracetime: %u\n", nla_get_u32(attr));
>>> +			break;
>>> +		case LOCKD_A_SERVER_TCP_PORT:
>>> +			printf("tcp_port: %hu\n", nla_get_u16(attr));
>>> +			break;
>>> +		case LOCKD_A_SERVER_UDP_PORT:
>>> +			printf("udp_port: %hu\n", nla_get_u16(attr));
>>> +			break;
>>> +		default:
>>> +			break;
>>> +		}
>>> +	}
>>> +}
>>>    static int recv_handler(struct nl_msg *msg, void *arg)
>>>    {
>>>    	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
>>> @@ -368,6 +396,9 @@ static int recv_handler(struct nl_msg *msg, void *arg)
>>>    	case NFSD_CMD_POOL_MODE_GET:
>>>    		parse_pool_mode_get(gnlh);
>>>    		break;
>>> +	case LOCKD_CMD_SERVER_GET:
>>> +		parse_lockd_get(gnlh);
>>> +		break;
>>>    	default:
>>>    		break;
>>>    	}
>>> @@ -398,12 +429,12 @@ static struct nl_sock *netlink_sock_alloc(void)
>>>    	return sock;
>>>    }
>>>    
>>> -static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock)
>>> +static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, const char *family)
>>>    {
>>>    	struct nl_msg *msg;
>>>    	int id;
>>>    
>>> -	id = genl_ctrl_resolve(sock, NFSD_FAMILY_NAME);
>>> +	id = genl_ctrl_resolve(sock, family);
>>>    	if (id < 0) {
>>>    		xlog(L_ERROR, "%s not found", NFSD_FAMILY_NAME);
>>>    		return NULL;
>>> @@ -447,7 +478,7 @@ static int status_func(struct nl_sock *sock, int argc, char ** argv)
>>>    		}
>>>    	}
>>>    
>>> -	msg = netlink_msg_alloc(sock);
>>> +	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
>>>    	if (!msg)
>>>    		return 1;
>>>    
>>> @@ -495,7 +526,7 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
>>>    	struct nl_cb *cb;
>>>    	int ret;
>>>    
>>> -	msg = netlink_msg_alloc(sock);
>>> +	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
>>>    	if (!msg)
>>>    		return 1;
>>>    
>>> @@ -607,7 +638,7 @@ static int fetch_nfsd_versions(struct nl_sock *sock)
>>>    	struct nl_cb *cb;
>>>    	int ret;
>>>    
>>> -	msg = netlink_msg_alloc(sock);
>>> +	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
>>>    	if (!msg)
>>>    		return 1;
>>>    
>>> @@ -672,7 +703,7 @@ static int set_nfsd_versions(struct nl_sock *sock)
>>>    	struct nl_cb *cb;
>>>    	int i, ret;
>>>    
>>> -	msg = netlink_msg_alloc(sock);
>>> +	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
>>>    	if (!msg)
>>>    		return 1;
>>>    
>>> @@ -825,7 +856,7 @@ static int fetch_current_listeners(struct nl_sock *sock)
>>>    	struct nl_cb *cb;
>>>    	int ret;
>>>    
>>> -	msg = netlink_msg_alloc(sock);
>>> +	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
>>>    	if (!msg)
>>>    		return 1;
>>>    
>>> @@ -1054,7 +1085,7 @@ static int set_listeners(struct nl_sock *sock)
>>>    	struct nl_cb *cb;
>>>    	int i, ret;
>>>    
>>> -	msg = netlink_msg_alloc(sock);
>>> +	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
>>>    	if (!msg)
>>>    		return 1;
>>>    
>>> @@ -1170,7 +1201,7 @@ static int pool_mode_doit(struct nl_sock *sock, int cmd, const char *pool_mode)
>>>    	struct nl_cb *cb;
>>>    	int ret;
>>>    
>>> -	msg = netlink_msg_alloc(sock);
>>> +	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
>>>    	if (!msg)
>>>    		return 1;
>>>    
>>> @@ -1249,6 +1280,131 @@ static int pool_mode_func(struct nl_sock *sock, int argc, char **argv)
>>>    	return pool_mode_doit(sock, cmd, pool_mode);
>>>    }
>>>    
>>> +static int lockd_config_doit(struct nl_sock *sock, int cmd, int grace, int tcpport, int udpport)
>>> +{
>>> +	struct genlmsghdr *ghdr;
>>> +	struct nlmsghdr *nlh;
>>> +	struct nl_msg *msg;
>>> +	struct nl_cb *cb;
>>> +	int ret;
>>> +
>>> +	if (cmd == LOCKD_CMD_SERVER_SET) {
>>> +		/* Do nothing if there is nothing to set */
>>> +		if (!grace && !tcpport && !udpport)
>>> +			return 0;
>>> +	}
>>> +
>>> +	msg = netlink_msg_alloc(sock, LOCKD_FAMILY_NAME);
>>> +	if (!msg)
>>> +		return 1;
>>> +
>>> +	nlh = nlmsg_hdr(msg);
>>> +	if (cmd == LOCKD_CMD_SERVER_SET) {
>>> +		if (grace)
>>> +			nla_put_u32(msg, LOCKD_A_SERVER_GRACETIME, grace);
>>> +		if (tcpport)
>>> +			nla_put_u16(msg, LOCKD_A_SERVER_TCP_PORT, tcpport);
>>> +		if (udpport)
>>> +			nla_put_u16(msg, LOCKD_A_SERVER_UDP_PORT, udpport);
>>> +	}
>>> +
>>> +	ghdr = nlmsg_data(nlh);
>>> +	ghdr->cmd = cmd;
>>> +
>>> +	cb = nl_cb_alloc(NL_CB_CUSTOM);
>>> +	if (!cb) {
>>> +		xlog(L_ERROR, "failed to allocate netlink callbacks\n");
>>> +		ret = 1;
>>> +		goto out;
>>> +	}
>>> +
>>> +	ret = nl_send_auto(sock, msg);
>>> +	if (ret < 0) {
>>> +		xlog(L_ERROR, "send failed (%d)!\n", ret);
>>> +		goto out_cb;
>>> +	}
>>> +
>>> +	ret = 1;
>>> +	nl_cb_err(cb, NL_CB_CUSTOM, error_handler, &ret);
>>> +	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, finish_handler, &ret);
>>> +	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, ack_handler, &ret);
>>> +	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, recv_handler, NULL);
>>> +
>>> +	while (ret > 0)
>>> +		nl_recvmsgs(sock, cb);
>>> +	if (ret < 0) {
>>> +		xlog(L_ERROR, "Error: %s\n", strerror(-ret));
>>> +		ret = 1;
>>> +	}
>>> +out_cb:
>>> +	nl_cb_put(cb);
>>> +out:
>>> +	nlmsg_free(msg);
>>> +	return ret;
>>> +}
>>> +
>>> +static int get_service(const char *svc)
>>> +{
>>> +	struct addrinfo *res, hints = { .ai_flags = AI_PASSIVE };
>>> +	int ret, port;
>>> +
>>> +	if (!svc)
>>> +		return 0;
>>> +
>>> +	ret = getaddrinfo(NULL, svc, &hints, &res);
>>> +	if (ret) {
>>> +		xlog(L_ERROR, "getaddrinfo of \"%s\" failed: %s\n",
>>> +			svc, gai_strerror(ret));
>>> +		return -1;
>>> +	}
>>> +
>>> +	switch (res->ai_family) {
>>> +	case AF_INET:
>>> +		{
>>> +			struct sockaddr_in *sin = (struct sockaddr_in *)res->ai_addr;
>>> +
>>> +			port = ntohs(sin->sin_port);
>>> +		}
>>> +		break;
>>> +	case AF_INET6:
>>> +		{
>>> +			struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)res->ai_addr;
>>> +
>>> +			port = ntohs(sin6->sin6_port);
>>> +		}
>>> +		break;
>>> +	default:
>>> +		xlog(L_ERROR, "Bad address family: %d\n", res->ai_family);
>>> +		port = -1;
>>> +	}
>>> +	freeaddrinfo(res);
>>> +	return port;
>>> +}
>>> +
>>> +static int lockd_configure(struct nl_sock *sock, int grace)
>>> +{
>>> +	char *tcp_svc, *udp_svc;
>>> +	int tcpport = 0, udpport = 0;
>>> +	int ret;
>>> +
>>> +	tcp_svc = conf_get_str("lockd", "port");
>>> +	if (tcp_svc) {
>>> +		tcpport = get_service(tcp_svc);
>>> +		if (tcpport < 0)
>>> +			return 1;
>>> +	}
>>> +
>>> +	udp_svc = conf_get_str("lockd", "udp-port");
>>> +	if (udp_svc) {
>>> +		udpport = get_service(udp_svc);
>>> +		if (udpport < 0)
>>> +			return 1;
>>> +	}
>>> +
>>> +	return lockd_config_doit(sock, LOCKD_CMD_SERVER_SET, grace, tcpport, udpport);
>>> +}
>>> +
>>> +
>>>    #define MAX_LISTENER_LEN (64 * 2 + 16)
>>>    
>>>    static void
>>> @@ -1355,6 +1511,13 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
>>>    
>>>    	read_nfsd_conf();
>>>    
>>> +	grace = conf_get_num("nfsd", "grace-time", 0);
>>> +	ret = lockd_configure(sock, grace);
>>> +	if (ret) {
>>> +		xlog(L_ERROR, "lockd configuration failure");
>>> +		return ret;
>>> +	}
>>> +
>>>    	pool_mode = conf_get_str("nfsd", "pool-mode");
>>>    	if (pool_mode) {
>>>    		ret = pool_mode_doit(sock, NFSD_CMD_POOL_MODE_SET, pool_mode);
>>> @@ -1370,15 +1533,12 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
>>>    	if (ret)
>>>    		return ret;
>>>    
>>> +	xlog(D_GENERAL, "configuring listeners");
>>>    	configure_listeners();
>>>    	ret = set_listeners(sock);
>>>    	if (ret)
>>>    		return ret;
>>>    
>>> -	grace = conf_get_num("nfsd", "grace-time", 0);
>>> -	lease = conf_get_num("nfsd", "lease-time", 0);
>>> -	scope = conf_get_str("nfsd", "scope");
>>> -
>>>    	thread_str = conf_get_list("nfsd", "threads");
>>>    	pools = thread_str ? thread_str->cnt : 1;
>>>    
>>> @@ -1402,6 +1562,9 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
>>>    		threads[0] = DEFAULT_AUTOSTART_THREADS;
>>>    	}
>>>    
>>> +	lease = conf_get_num("nfsd", "lease-time", 0);
>>> +	scope = conf_get_str("nfsd", "scope");
>>> +
>>>    	ret = threads_doit(sock, NFSD_CMD_THREADS_SET, grace, lease, pools,
>>>    			   threads, scope);
>>>    out:
>>> @@ -1409,6 +1572,30 @@ out:
>>>    	return ret;
>>>    }
>>>    
>>> +static void nlm_usage(void)
>>> +{
>>> +	printf("Usage: %s nlm\n", taskname);
>>> +	printf("    Get the current settings for the NLM (lockd) server.\n");
>>> +}
>>> +
>>> +static int nlm_func(struct nl_sock *sock, int argc, char ** argv)
>>> +{
>>> +	int *threads, grace, lease, idx, ret, opt, pools;
>>> +	struct conf_list *thread_str;
>>> +	struct conf_list_node *n;
>>> +	char *scope, *pool_mode;
>>> +
>>> +	optind = 1;
>>> +	while ((opt = getopt_long(argc, argv, "h", help_only_options, NULL)) != -1) {
>>> +		switch (opt) {
>>> +		case 'h':
>>> +			nlm_usage();
>>> +			return 0;
>>> +		}
>>> +	}
>>> +	return lockd_config_doit(sock, LOCKD_CMD_SERVER_GET, 0, 0, 0);
>>> +}
>>> +
>>>    enum nfsdctl_commands {
>>>    	NFSDCTL_STATUS,
>>>    	NFSDCTL_THREADS,
>>> @@ -1416,6 +1603,7 @@ enum nfsdctl_commands {
>>>    	NFSDCTL_LISTENER,
>>>    	NFSDCTL_AUTOSTART,
>>>    	NFSDCTL_POOL_MODE,
>>> +	NFSDCTL_NLM,
>>>    };
>>>    
>>>    static int parse_command(char *str)
>>> @@ -1432,6 +1620,8 @@ static int parse_command(char *str)
>>>    		return NFSDCTL_AUTOSTART;
>>>    	if (!strcmp(str, "pool-mode"))
>>>    		return NFSDCTL_POOL_MODE;
>>> +	if (!strcmp(str, "nlm"))
>>> +		return NFSDCTL_NLM;
>>>    	return -1;
>>>    }
>>>    
>>> @@ -1444,6 +1634,7 @@ static nfsdctl_func func[] = {
>>>    	[NFSDCTL_LISTENER] = listener_func,
>>>    	[NFSDCTL_AUTOSTART] = autostart_func,
>>>    	[NFSDCTL_POOL_MODE] = pool_mode_func,
>>> +	[NFSDCTL_NLM] = nlm_func,
>>>    };
>>>    
>>>    static void usage(void)
>>> @@ -1460,6 +1651,7 @@ static void usage(void)
>>>    	printf("    listener             get/set listener info\n");
>>>    	printf("    version              get/set supported NFS versions\n");
>>>    	printf("    threads              get/set nfsd thread settings\n");
>>> +	printf("    nlm                  get current nlm settings\n");
>>>    	printf("    status               get current RPC processing info\n");
>>>    	printf("    autostart            start server with settings from /etc/nfs.conf\n");
>>>    }
>>>
>>
> 


