Return-Path: <linux-nfs+bounces-16413-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99020C5F4F9
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 22:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412603B02A2
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 21:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F076F2FBDE4;
	Fri, 14 Nov 2025 21:04:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020089.outbound.protection.outlook.com [52.101.56.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BD82F2616;
	Fri, 14 Nov 2025 21:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154278; cv=fail; b=sMksvXKfs3peRShFk1qK3twW94pPSkYSS4LUt4FQiJFZz2no7U3+PhTeI24QX8srPVtbGp2xZXtH6SFr06S7FXxLnPvciIV4v8GP2JD/Xcy3Ve1gmNVqddrIfA2jJsJK/ktHtD+D3hfluChFV062DGLKL1OHd/WfRJVmrlbSJRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154278; c=relaxed/simple;
	bh=ndO3sSHw0iynkNrAtCmKm8BYj//2+5ze/o8CXa0Zefo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AExIvPVj/MmfjIIw5HqekwtxlcLlfeK0WTXeBhWOGDGkPOnQ3Hoq0fJUVQSftxx8gpu0Dggmws6oo+6952lhvBSJLJuwvIMkzo4wZO39oLmvmKjQLX3ZnoWtIKuoTN62GVMgXUt6Is9HaTNLf85YKmyPbAmN4jnevWQPu5zheJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=52.101.56.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZPFIu7phmN19owywuixopBJSjp/iOWJu3CJ1rHGDtn4Ljf3pNs/FAuym+Fob8Mst7mXsE5SCPjzcFoUNGYB1szHUMi+4xkprNIVa3ryqsxZ6w1qfnLdfaKT3pM0sdtFgRuuijqMeGz8JP7Cjlct/ZFHvF32yfwtM4pl3XgkgNbazIpZPKLlyEGJqZCRz8VjDX3UUs4TE84GvnkRP5Ot0uayS37ToXJ0oBwg/Wj9Jpaubm4UnRS0gf0KGWO6f7raDkqy836AwqoNzL9ZqXiz+kSnwwRTfphNq4XQDpzRRS2eaipi/vfx9QAz7KmCkRMiwtw3AK0ZYjX6N0EEg/h/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7J/aejzfM4xbuy+4R8ghBFPz+1KTMFQKaMaoHTmzCU=;
 b=Ps3MZOwSJXX1R6UBUTJ3RnjklkXrkv4FsC9xj54nGppgjxcLfPGPTe+pV7ZxrhKMoZWn8rPEuXsgA37folJDKTAoV/0vYbHyvDnaB5rkLwROARcslCjI1/qtDzSgNGEfxIVh9FO+oRIAwWSF4uheAeZwzX9UqJPpqnbTnhh6+vV8DdJnavZzB26wkaGF0phC+tX1VhmsH6wsf76IC4ytZL30xE5xcOiu+GlAwJjt3M3K++6J03hJNygAZSkFki4eoqgaJVWoaV60ELJw1SlPdnTj18v7BBhzl8ldwaxVMdhKkohERCSNJDisEz/c2AkQXx8BSY3v4nlymzx4HuNyRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BYAPR01MB5144.prod.exchangelabs.com (2603:10b6:a03:7e::17) by
 BL1PR01MB7650.prod.exchangelabs.com (2603:10b6:208:395::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.17; Fri, 14 Nov 2025 21:04:29 +0000
Received: from BYAPR01MB5144.prod.exchangelabs.com
 ([fe80::f973:4d38:accd:b75]) by BYAPR01MB5144.prod.exchangelabs.com
 ([fe80::f973:4d38:accd:b75%5]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 21:04:28 +0000
Message-ID: <55be56d3-b286-4b39-8246-4be80b03c22c@talpey.com>
Date: Fri, 14 Nov 2025 16:04:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Make RPCRDMA_MAX_RECV_BATCH configurable.
To: Chuck Lever <chuck.lever@oracle.com>,
 gaurav gangalwar <gaurav.gangalwar@gmail.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, neilb@brown.name,
 Jeff Layton <jlayton@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20251113093720.20428-1-gaurav.gangalwar@gmail.com>
 <d3b2e4c8-18ec-4b8f-a05f-42bc00196e1c@oracle.com>
 <CAJiE4O=zhEaJKQO7bBc8g9gXCiMoi7G7qSiVbQ5Cq+SwBK8OVw@mail.gmail.com>
 <fc58b0f2-d00b-4e4e-a353-ffe43bec6c6e@oracle.com>
From: Tom Talpey <tom@talpey.com>
Content-Language: en-US
In-Reply-To: <fc58b0f2-d00b-4e4e-a353-ffe43bec6c6e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:208:32d::31) To BYAPR01MB5144.prod.exchangelabs.com
 (2603:10b6:a03:7e::17)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5144:EE_|BL1PR01MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: 703ae03e-1794-472c-6ba0-08de23c1666f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjVRVkt0clpHUlJ0bURIZXJDcTFoUklhTzVaSXplNFZ4ZmxZNkQ0Z1EvYmw2?=
 =?utf-8?B?VjFuOHpXZWcxZkNmZ2ZZblRrMTNPYVJnQjJGREo1SjZGQlRJcCtaRzFrSFgx?=
 =?utf-8?B?OWxuTHpGcm5MWjBrWkliTFQ3K2ljS2pWWUNtODFsZ21KTnVoQVV0Lzk2UWVQ?=
 =?utf-8?B?Nm1NZmZKN2daNW1LaVBVT2FwNDdZOENycnZzN3NQOER1ZFBUWVJUZDRaaEpw?=
 =?utf-8?B?WXphemo0OVdVS3c5dWZKTCtVaWlLbFRtckQybW1Wd1hNd2dGRmZoeUZjS2VH?=
 =?utf-8?B?cFJoYmR6QVJsR2oyRGNudFZnQUg3UTdES1J5S2NuZ29Ta0t4NGlUU0pjaTdG?=
 =?utf-8?B?Z05hL0tBNmUvVHhJMEhUeThqck81STZRQkM3eEFxVTFwUW9kb1dxVDR1c3hv?=
 =?utf-8?B?TkhDUWxQdW1JQWI3alNEazhRa2JnQ201cjcrSDVZVmQ2K096MXh6RGM4dEkr?=
 =?utf-8?B?M21JVWNrNEQ3TXN1Rk5GTGtodDRKWG40d25ZTHBTL3dYRDFqemg1QzFyNDZO?=
 =?utf-8?B?c1V3NkZDNnZhdnhvQnkyY2l6MkxlMGpKVUZTNUF5MkF6S281N0sxS0dRRDBV?=
 =?utf-8?B?KzRMd3dHdzJ5S0g5ckJqNVoxWThhbmZGclRqYjloV05JNjVhdWRkSzU4SnBx?=
 =?utf-8?B?dHJoKy9ib0QwV0dOemwvYlg1KytGTzRQY3ZRUmo5VWtlRlNQcmIxWDhPNVBC?=
 =?utf-8?B?Wkx2SUw0dnZsSStMaExnYUtnVFdYRlkxREtHQ3JVYmdWNlZUeUJ1VkREaVJI?=
 =?utf-8?B?OGZScCtRWi9VaC9KU3JLL0dEcUtCaHp0V2lGWUtlTEl4RXh3d2cvSE96NEZ0?=
 =?utf-8?B?TSsrKzltQyt1VTN3MUpYZE9iSmJWVzhtMTJOb1JYOG8weTllQ3FGWElFUkNR?=
 =?utf-8?B?VWsyYmo1aEF1aVhVeVgrYTg3d01PVmhMRDBTR1BUenpjeVN0Rm1BRVprMmdi?=
 =?utf-8?B?SDZCenhaNHhQbVlHZ2xDUSthOXRKRjFheURhbGNLRWMycWpUbjlrT2k5eTI0?=
 =?utf-8?B?S0RCSlhXeExQQ3djMGQ4dG96NUtrOHBWNkozcGJBWEl0VGJjZ3ErUmJEcGhp?=
 =?utf-8?B?c1FUNEJqQVhmTklzcnVXbk9iVzIxSlhIYjBjUnpINW1uTXpMalFsYTA5S0I1?=
 =?utf-8?B?dWthUWFlUUsyem9oc2RtZGZmb2ZKNkhOZWVuRmo3K2Z2bExJY25Mb2wyNnFL?=
 =?utf-8?B?TFpnd2lwdnl3TUEzWjZ2bE01M2VrN0wvRVlha1BzWkFsby8zSkgxUk9RbXFx?=
 =?utf-8?B?M2hnWEhCdHJkd0J2SzhoUEptQWhhcUhvOUxUVGxEaXRiWnp4YVhCYkVoRmIr?=
 =?utf-8?B?cDhhSGljVzMrRUV6WW0wNXNDelVUVHpQZ3c3eDJsSG5xakxlU0FzN2lKV0hh?=
 =?utf-8?B?MFZKdGNjbytheVdVRjFmbThJcXd1cVJWOHhDRklnS29TUisvSTFnOWwybFBm?=
 =?utf-8?B?aDV5YXRCMklVcEkvTkZ1S0g4MHJIYk5KOFdmbmpNdGdsS1RadktkVVpDTGFQ?=
 =?utf-8?B?UDZIbnFocjU0SnV3S3czTUtTNDA0N0U5azZ0Rlk4TUNXS0hwSDVyY1U0Y0dW?=
 =?utf-8?B?djk1SmsvR1J1MHNHUXRKWkRnQW1XKzNxOXVzMDF2ZEpwMGhKakludy9YNFdF?=
 =?utf-8?B?ZGtkUkVyTFBGN2wwbXZ0cFNwWnhtUTkwUGI4TVY2MFVhMDI3U1BUSnEzdVM2?=
 =?utf-8?B?b1hJV1A1MllhOG9LOGxhZlRsbHRrRHQwRGFHdWxMVytGcHJQOVN0STg1Y3dM?=
 =?utf-8?B?Rk9pTXFCWGdQRU5GMGZhdGZZK0JIKzFvVVB6MCtDaWtyMmIxaDhqZW1nWDlv?=
 =?utf-8?B?QWJDMFJYUHFtR2ZoUkpncU9aeU04SmUyRm9JYkl1S1BiLzRkbHZvR3hqajRW?=
 =?utf-8?B?b1JMNFBiaFVuVmk0cjJsSTRDSWJIcmY1MkVFWGFYMVJFbmZCTkIrUTNNUnlU?=
 =?utf-8?Q?BbGX4O5W0UQCHRskR5eQyRBcEIuCr3Ij?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5144.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vkt1YnVLd0x4YkNHY1M2RGFlUllyV2FzUHFORWNmMklwUUxIU2FoYThYRDht?=
 =?utf-8?B?MGFwOElSUXRYdi9NRTM2bkphOU1oT1hjWFFPSERNdjgyekVDV2xvcURYdjFa?=
 =?utf-8?B?T3EyK2prSXJ4R1pHUENmcEVBTFV6d1dGV2llTEFRNkp4YUkydWhIWjJ2ckhy?=
 =?utf-8?B?S0pMZlVwOE85SkpIRVhsNlZQVVJjYXJ1ajYwTG1hdTdtbDBvMUFLR0hmZVUx?=
 =?utf-8?B?eVlVcUtOOUJOOU13WHJOcTZxZVVFNVI3RXBGTWZFMjh3dGlabk9kMkhSR0hN?=
 =?utf-8?B?a04xTUJpckxpanF5eGlSSktIT1A5L2g2Nm5MNEpSRklzMmhIWnhTNVA4Rmx0?=
 =?utf-8?B?Y1NaTFpiNWs1NjdodkVnN3lycjhZL3dVKzIrT2tzNDNFc0J1Sm1CeEU5WGpH?=
 =?utf-8?B?MEQvcWc5SEdjKzlDL040d3V2aXpyZjJiWUxKZStPL2o0c3dZNzBoUkF3RHZB?=
 =?utf-8?B?c1lmNkhWRDZ0R0tDWm4rVlBvelJrNkxUdTdXT09pb0IwL0piWjhlY0k1OTk1?=
 =?utf-8?B?b0JDeEhZRHlVMzUyVG9ncDEvKzRHb3lXRWZ0eU5CdnczaGlMeHNha2ZkS2hK?=
 =?utf-8?B?K0pWNXRudXd6YmNQalRwbDJTU0orNnluR3NDZTI5NkFmOEV3Wm12ZmI0c2Uz?=
 =?utf-8?B?d1JZa2VITXQwWXUveVIxcURCVUVrMHJVMS8yV29McjNZTkRORUhNT1ZRK0l4?=
 =?utf-8?B?a0ZPMFluWFNKdElkMXA2UHRTZ2ZIK1pnYmIzODlYZHhaT0tMZ2dxbVRCUlIz?=
 =?utf-8?B?NEkzMHlxeFVIS1lFQytYVys2bFVxdGh6ZFZhMG14ZDBQVVdsZDl1bG5XL3B1?=
 =?utf-8?B?UENFSmtRZXBvczNKTTg0a0d2NnNjVjhsbWFDb1oyZGZMeCtESEZ5Y3FlN1Bi?=
 =?utf-8?B?VEwwcVk4bWJmZlcvT0c5cm1LeWsxQlZsUUw3c201VndxTUpMNVk2dnlBTmN6?=
 =?utf-8?B?OXZ6dlljYUpVTnNlKzg4aVIzT1NyUURYR0xjTXhkZmgvOWhaaTNyaElyUjBj?=
 =?utf-8?B?RWxPTGVMRXJObEVXQlZxZzZpVDlvSjdzM3MzNldDNktwcDhVb0RLdzRLa3pt?=
 =?utf-8?B?N2lWb0dLY2RtL1NFNnlkUHllZ1d1M0hteDlURzlYYlRxSGlGL09YamU4czB5?=
 =?utf-8?B?Z0FSc29zbzdEak9UeUhwaFgwOWgwYlhkU3VrU2pZUUlhWGVFZ3lWVDlhWFhX?=
 =?utf-8?B?Y1FsZFI2NzF5eDlLQWF0K3Y0K0RYdGdGMmNpZmc3Z2k4eWgrdkl1U1V6eDJ6?=
 =?utf-8?B?QnBhN1VnVVgvdkUvYUZoMXkvWnJPenNWZjJnTFV0NWtEemRmbVBJVWwraWRF?=
 =?utf-8?B?d0xPc0NwR24wZ2wrcnNOdFdUa2grU3dQWTJ3SXBHNDV2ODVKZFdScUNyYm9t?=
 =?utf-8?B?ZEhRL1ZMUU1rUmNYYmN3anZ4d215L0ZnTUFDOTduT3MwTkFlb3ZnT2huOHVt?=
 =?utf-8?B?d0V3bTE1Vk1DN3p6UFVpYVVibHMvaVE2ODBlaHkzMkdpZFc0UEhoVWtNRE55?=
 =?utf-8?B?OXc2OUdSOGpnYWFSeUt2Q2hyd3ZuY2pFTWlsK3lxLzI3b3dpakN3aDdNUkxv?=
 =?utf-8?B?NitzSGZBalk5dW5mRjZweHg1ZEJWaWROYmp1QTJBUi8xN2dqOWFKc3VNU2du?=
 =?utf-8?B?VHFTVFZoM0EyTGFjeFRwc0JKYjhsWEJMMko0UXBBME50SmJobVlOMzhLUm1W?=
 =?utf-8?B?U2FOV2ZiOTJ1ZTh5clRQNFRJZ0lSbTVKWmFsNEJGWTduQjVwakdqT1QrVHZY?=
 =?utf-8?B?R3ZLN3V6TUdxbi9oamh2UGRSTWNpTnZJMDlsRFkrNWxOUEg4ZWFEOHRBeTQx?=
 =?utf-8?B?S1RJb3ZaYkZyM3VLSnBHSG1iOVRTSmRSVXlKVnpaZ2EzVlMyVHZ5UHJJcm1N?=
 =?utf-8?B?LzdhczhJcUdWamQrdFdxVFhscFllRHBQTzh3dW5NRkZNV3pLVHJSSE9FWWx1?=
 =?utf-8?B?VVkzbVdLRzVMdDRQUDFrQTE4L2tIZVRGZWlBREpUYkdQN2JKMVRwVXUwTUth?=
 =?utf-8?B?V0ZhS2RDekd6NG9QS2Q3WVNiaS8xa0xPRlRHLzhRTjdUaDNOZmtsNzNHWjQ1?=
 =?utf-8?B?YUlLb1pNb3pkS0kxeEFJclk0bkRhYzRRQ2d3VzNzUmtpNkd3Z3JGTnhob3VE?=
 =?utf-8?Q?ZCLynUiDP7Gi7YkqgGTQssUIN?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703ae03e-1794-472c-6ba0-08de23c1666f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5144.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 21:04:28.9037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77EsBBnb0sUYQMmMs+/AIfU3sggX0RiX4MEvwlLIBl+upIJ5+/F/nHJoFXJxf+Qj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7650

On 11/13/2025 12:41 PM, Chuck Lever wrote:
> On 11/13/25 11:39 AM, gaurav gangalwar wrote:
>> On Thu, Nov 13, 2025 at 7:49 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>
>>> On 11/13/25 4:37 AM, Gaurav Gangalwar wrote:
>>>> Bumped up rpcrdma_max_recv_batch to 64.
>>>> Added param to change to it, it becomes handy to use higher value
>>>> to avoid hung.
>>>
>>> [ Resend with correct NFSD reviewer email addresses and linux-rdma@ ]
>>>
>>> Hi Gaurav -
>>>
>>> Adding an administrative setting is generally a last resort. First,
>>> we want a full root-cause analysis to understand the symptoms you
>>> are trying to address. Do you have an RCA or a simple reproducer to
>>> share with us?
>>
>> Issue found while testing fio workload over RDMA
>> Client: Ubuntu 24.04
>> Server: Ganesha NFS server
>> We have seen intermittent hung on client with buffered IO workload at
>> large scale with around 30 RDMA connections, client was under memory
>> pressure.
>> Ganesha log shows
>>
>> 10/11/2025 16:39:12Z : ntnx-10-57-210-224-a-fsvm 1309416[none]
>> [0x7f49a6c3fe80] rpc :TIRPC :EVENT :rpc_rdma_cq_event_handler() cq
>> completion status: RNR retry counter exceeded (13) rdma_xprt state 5
>> opcode 2 cbc 0x7f4996688000 inline 1
>>
>> Which points to lack of posted recv buffers on client.
>> Once we increased rpcrdma_max_recv_batch to 64, issue was resolved.
> 
> That still doesn't convince me that increasing the receive batch count
> is a good fix, though it's certainly a workaround.

It's not a workaround, this will fail on any RDMA provider that doesn't
perform RNR retry, for example iWARP. But more importantly, RNR retry is
unnecessary because the rpcrdma protocol implements a strict crediting
exchange. A proper rpcrdma implementation will never trigger RNR.

This is almost certainly an rpcrdma protocol violation in the sender,
which is failing to honor the credit limit granted by the receiving
peer and is overrunning the peer's receive queue. A wireshark trace
would prove it. Please do this research.

Tom.


> 
> The client's RPC/RDMA code is supposed to track the number of Sends and
> keep the correct number of Receives on the Receive Queue. The goal of
> the implementation is to never encounter an RNR.
> 
> Therefore, if it's not doing that (and the RNR retries suggests that's
> the case) there is an actual bug somewhere. The extra batch Receives are
> an optimization, and should have no impact on correct operation.
> 
> If you can't reproduce this with the Linux NFS server, the place to
> start looking for misbehavior is NFS/Ganesha, as it is the newer NFS
> over RDMA implementation of the two servers. Maybe it's not handling
> credit accounting correctly, or perhaps it's putting more Sends on
> the wire than the credit limit allows.
> 
> 


