Return-Path: <linux-nfs+bounces-17799-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA19D19BD7
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 16:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51E18305C431
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 15:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A490A2E265A;
	Tue, 13 Jan 2026 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="EXHFDtor"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021095.outbound.protection.outlook.com [40.93.194.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FBB2EA490
	for <linux-nfs@vger.kernel.org>; Tue, 13 Jan 2026 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316853; cv=fail; b=RO7CLkmYeoW3hvexXJe0DnWVKUGd0qbPUaRGTPSH3jwFF9Lcbl+EWUdHOZHe83xI6csbWcDQF8SDuQQqTDSWU/K9xauJsHfVELVllnDffYGphhUaYl4e9xfsrJglODK+k77ymyCe7cyH8JSZneOhQ7/k9OlW4h4qGmqJICiY/l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316853; c=relaxed/simple;
	bh=Yz/WLZJ35zNIxgEqtsEm1988c2l+eQlZ+0xDY4QdxYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s7vm4zGBAugu8js9t8lcu07Q+czp1Io/jF5r/3U2CaydCi+aJevPSV3X3a6ECpEioZYLsgegC1Ly04j7u9Ln9doCU6sHTap4Jmm70qwtASb+RqLro3rvpfaUt6jl/zdzPbAVfCh31YvLn/nfLeoUBIU9OonnQqupsNKBjT9c0EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=EXHFDtor; arc=fail smtp.client-ip=40.93.194.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cctBGVXitNf7aVUW+zWuUCJH2OlQJ1DdmsEZR4tW6adDy530WIxmrFDb5f05U6rLhYH4aSE8cV2CJxLdoN5ca242F6P3q8XucR4sQVOlonwweFJKmERt42EENTrjWUbej8N6fj3Bs5z62l9s2qMPgLjPZvVdUOnuv5P8HjsGeOg/xsQD4DpF5qZDiFWXhkvZkr5AU3dAaMvoCg72V96qBJYKWTLRMcJoZgv0s711Ps8zxj7/xjWC2xp6ybUSvfXvuA549lXAicM/Fnz7MG84RxunfuhT1aPdauW+u5auATgMrK+2yp5ucNh8FNBZTJJnUSxALo7q2js1n7QSjZ36mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDjGaSrDxeU0a04Bdi4jDrtzUR8djTOkrES3K77hrbY=;
 b=NCB9HNYs75t5laAaMr2TZPEYhWj5nauidCkMquPHBNpXHawdIK1TDdwNQHAHi7vZFAGNy66yR8yjNXEOf5SFByq/LN9IVWWqMIO0ZZw4957XY0ptl8pcOzpxJnbHXuCve8V8HtdC5gnJ19xMaxaJ7isNj/HN0AiIR2igpPQEBFOoyB6RYnBji0K1FGYKHyPk8OkEV1InNkF825lJV9DGRkwfoyIkgxVxo07TuxZqEvVA9c+ffBGAHqNGOpWJoQMmhROZgjluvUtcSYZNqLT4WqE/GG1pybVhmLBtpSGdRScwKmUo+40UsUnurQ00Y7ZZD0BtNkMIKMw2+zyXx0EFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDjGaSrDxeU0a04Bdi4jDrtzUR8djTOkrES3K77hrbY=;
 b=EXHFDtormaWChmU/h6qbcI5Bjhen1S+m4Jz1jw58FEdNOlMfffJetDd9DNk0cC2rOvvmYCZZrYQqYP6yHbdLPkuny8A5/qDDGPOnl/F9HDHxRtHZO/2COVtx6peJkucZMBFXd3dtnZnIw3x71BQLtqxGutA6Uzz0h/OMcy7c55g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 BL0PR13MB4548.namprd13.prod.outlook.com (2603:10b6:208:1cc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Tue, 13 Jan 2026 15:07:28 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Tue, 13 Jan 2026
 15:07:27 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
Date: Tue, 13 Jan 2026 10:07:23 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <ECE1341F-BA8A-4DC7-BC9D-BDD6F10F6013@hammerspace.com>
In-Reply-To: <1e92e144-d436-44dd-956f-3125403dfdc8@kernel.org>
References: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>
 <cover.1766848778.git.bcodding@hammerspace.com>
 <aac7f668-5fc6-41cd-8545-a273ca7bfadf@app.fastmail.com>
 <2DB9B1FF-B740-48E4-9528-630D10E21613@hammerspace.com>
 <7F8B576A-465B-4DCE-95F9-9F877513DF2A@hammerspace.com>
 <1e92e144-d436-44dd-956f-3125403dfdc8@kernel.org>
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0109.namprd07.prod.outlook.com
 (2603:10b6:510:4::24) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|BL0PR13MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: 785eceb8-d5fc-4b21-f394-08de52b5771a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?78OpnOLTsJbWUTb0kamjA00w7VDYXefOBU8G9CZr429mKB78VQMYPeUs848m?=
 =?us-ascii?Q?dap/zaG2BPstp4ZejNuvLTpaL0drQJZmbCfN+JyObL+qEXHETB2Ck8hWDt37?=
 =?us-ascii?Q?GNRH97Id6L9zAtT4M0TpjAMhqkmLPnhQwMisZfiVCYCr/yJ+LZpWcwNbW2K+?=
 =?us-ascii?Q?pSoJWF6gExfd/jrcQ5fNysuuprS9Stk212URKHWS+oOCNlYou7NalyWtKdLI?=
 =?us-ascii?Q?aJ5a9ITIsrySNZVkcJAULpn4VHo/cNRVEauBez9FiQNgg2ojrck+pbfj5RiS?=
 =?us-ascii?Q?ZsXo5IMa8QCk2tOiFEh3dBFdrRIP/VKXioQMwveUIrFV49Ghq92KhjpUqbQI?=
 =?us-ascii?Q?TwzSl/8h5YaGmI8YM6UMihpDqB9PBrTIZHJo22BkFv1wEDS/aGOvTD+3LjrQ?=
 =?us-ascii?Q?JNYMyzPxzYMtg4k5Nfnqz2S0aPGhRZuTl2fIBbn7hyt/GNShAExfyq4gBa6j?=
 =?us-ascii?Q?2wR4ZXa/1JeQWcONRFtY+O7WpvxHxPqXVvjAqwNDj1D1VNf/uSvVK2ltz3FY?=
 =?us-ascii?Q?I4jVqEX4zRK3QxMQMS3bExOlbktVNOCpv8xm/otRx4vBEe8PxyZSrKLNX/sC?=
 =?us-ascii?Q?iVwcOg4mfo7p+XePdl9yrMt28clsgn6i/LAgix8yQ+4jBQ9+aJPbmYpSwSUv?=
 =?us-ascii?Q?N3d9dXJrPDwNAwL6HCwCu6CQwO3LlxQdJhVNC5O7y8thtdmKE/J39kkAGu6B?=
 =?us-ascii?Q?gUJU5bFxHeeqz2u5gTmUcpUYawmNjeztl+1yNLRydZY0llG7aOS6OUbr7ktY?=
 =?us-ascii?Q?Wv7WCE1EgdXEpKQHr++CKIY24GQ+DLEnXADB/byzgxtCNmo2902m2vB3a/rd?=
 =?us-ascii?Q?0Gg8auGpP2jztwQ9hr43BbdrCTC/9CUB6sswMXuOeckkvI6ZYgE1W3t7w8F5?=
 =?us-ascii?Q?4qiY/kOoabqBRpiUxKDVNLMrrKyhrwDHJV48nPF8U3xg0ClvWvRQdjHzz+Ut?=
 =?us-ascii?Q?9Ndgk9HMUxMuUbhJsh0DFi0Bu308y7WKurUWEJMdMvMkGDWRYxhQQ+PbxE0e?=
 =?us-ascii?Q?k789nzZDNASLlCO43sQsmzMIk12ERmVgOF/Ebe8iC9cTSBGalx+rKHOFx/Sj?=
 =?us-ascii?Q?rs0oANeuPk/unIOF5+AcfDE7tn3OQQFi7uve8YRcgVwczhIPCR2/z8NN9fFg?=
 =?us-ascii?Q?rA0sro/Z56rKLtMyFqicxJhDx5nrFISNZuzCmFNGps9PYRdxCwl4ce2GLA2+?=
 =?us-ascii?Q?xDo2zBDnI49lYQzPLidhG3VGToqcCMxrXTx0S1fCvnx1mQj03K+gncSlrr/0?=
 =?us-ascii?Q?uxpI4l6qQtqzQJ0ip7iH6niV+zVbwah2vQiTUhswGn4kUTuVo4uduJZzxCw6?=
 =?us-ascii?Q?e0o1YEWF2ZpW9OGUBgfG2PZPiS4Lvq5XvJ7YCMWn+Y+nBeo9Wa+lUOuDK/Bp?=
 =?us-ascii?Q?yOP0VCiQuENV890KBmI0JLTVmg72bpcUZ+9HXSdcLFSmzGCpJRCspmcpf2Qh?=
 =?us-ascii?Q?m8HOyH0BUJb7XYm51Pbf/iHaDaATI11L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GM3tyAoAP+nzB/jE/JW1Li0Ef2ujlrklrZJQbljvHoOCvnfzCJoImKnmESol?=
 =?us-ascii?Q?AuLflVXyw+EYG2QWqanldhV5uYSZl8h/1RUQqXy1tBkTFqWKlb8UcR50GfoD?=
 =?us-ascii?Q?uyynLBNPhAHPDnlBGYmlWZDh9PcVB0CzkfUIfqTpn0xhUJiQqWI9k3vDmJOb?=
 =?us-ascii?Q?c6UdlQl1TAmh0CT5mqDR7c4d1azGzkoNM0Se/ynw2Jmewfmn4NoUGfEwWl73?=
 =?us-ascii?Q?wgwNyWGm8Xesp+jjUWG+vFzredfsdFthdugZzFdzsbFOP2y6MykBIhPwvPN5?=
 =?us-ascii?Q?UfhNLMysCCmhIIPHy9W8gtO/WiLRoSBQEq4Pluv1Aohc2H0N/SgA3wSqQYBd?=
 =?us-ascii?Q?/kQihoanzuN1yeEmgGdIQn3uzjJCtmJ6x2wsjkSdd6WLror0SgtpJjAT4pou?=
 =?us-ascii?Q?MbXI/f9wP4RCyOUG+zLbdupel1Flljl9Wx/1Dr6EAB84lnAiuB9ByaTJWEIs?=
 =?us-ascii?Q?kdUUsEx3fUENv1Avl0rumrL7xgXe6kbqCNtQpFfAONPQrZVFWQsHUC7lvagk?=
 =?us-ascii?Q?94+jUU500rSHoAhNSIMahBqGyO/6EyTszzgscP9IHkB7uOQ2R4+8giwA31hf?=
 =?us-ascii?Q?Do78EVibOZZfyt/MEV2d05p8FnlSXyMxofqu3IKDn6O5y281DrYNh4oLc42t?=
 =?us-ascii?Q?PhjSatBeQhGq6jDvNJwXgZRy7lNr/EuxYWh1DmezW9ptidC17ff5+oTSiNBo?=
 =?us-ascii?Q?PgO0u/IFO1YTMRuyo/M1t2c7THyxS9F32kVfJFstM7Joy/xQEmgcxDs6ElIs?=
 =?us-ascii?Q?qicoqBKxv+9r2p9dFt/DYsevGsdi+PlVCWF0s4Q/jtgVwnpftvDOefDDVz8S?=
 =?us-ascii?Q?ak8YQbzYGAHYzGHysTv+mkqkd0OomLFoax15mVhz3leJ1ah8jXeS7LHjkRvb?=
 =?us-ascii?Q?oNOLIa0s4KPPt1hM3G7tuV0pHNoCOULoa4Hv2hZNNUHN8WJlmcjP7cO2+RLd?=
 =?us-ascii?Q?QosjB8sIaYGdwI4ko9IdDXb49eFZIkuB4Yy3gDdKdaxWBSuuo/MFNZs9may3?=
 =?us-ascii?Q?7hPCui0ftM7Gl9c0ViCeg9z5Wrui3PQekNj+zPf0YFVXnrOWUyMNesIw9Wxb?=
 =?us-ascii?Q?TPG3UKhqxytkuU9pUGvVF7QDTCOTaKZtM9sZpygcTBJRuUikuo2bAvYgKpQT?=
 =?us-ascii?Q?AqFgQlqbwPPIbS/0SAyQd2IDIpTitCI4XxDryyqpJMRz1R6xahId70M08x9x?=
 =?us-ascii?Q?tvk8dV7RM/7EmOhEZg99VllWYSG5XdxGWMrofq+kMiyNff1fvr7XGrWUMK1B?=
 =?us-ascii?Q?TNygl2MQmjKzJnTepHo6I38dWAM5nFsZaPAEFoX+qBMRm3P85+cN4HZqwoQD?=
 =?us-ascii?Q?4lttswT+OxFXj3dbGxLOjJ5Hq/QTN3i/om9Vc3vasCAEbUC6RLN8x71TlnmV?=
 =?us-ascii?Q?xOcKmPjnnVffww+Oi9XRBw4eh7I3jFH8PJLdQsz/qajDyVCjqCjDpVR7NdZO?=
 =?us-ascii?Q?p0KMPrCgrDSKTMaKJ8BCpw62EOCRcvt+ZfCS76LzZUYCh1N9y58AkVxAJn+q?=
 =?us-ascii?Q?Br3i9hl2IevRPRWVDQQyG2Q6V8CywRQaPPl2gzela4vaheDHxRKDuhTZFi0Y?=
 =?us-ascii?Q?fi9+VXrEFNxexJ8jnm86AzPfGtQacryctgn793QTO76vU/8pppBxAb5FvpHg?=
 =?us-ascii?Q?l5na8uXnjVqwNXMx3Ko6jfaMg27MKUrXQRLVbatQTcUKGw7Qs7NsSHagCrjL?=
 =?us-ascii?Q?05Rz0n8bpRC2x2U/mb88sc0w2+wWXSjjxHSr7lX38ag9cwU81SzndkqQ9soS?=
 =?us-ascii?Q?BqYcuF8QRUiLmxfst/E4zD6lC2K4X40=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785eceb8-d5fc-4b21-f394-08de52b5771a
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 15:07:27.5805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQuCVEZeotaJyk82NrIP6cK42eNP7RGQodBHnY6ZVqGZ8cuWKW0St3hU7JPvi6n28LpdZyXr1udvvT2n51zEGPcnAC47Hx5yamgAdWuSXU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4548

On 13 Jan 2026, at 9:08, Chuck Lever wrote:

> On 1/13/26 6:51 AM, Benjamin Coddington wrote:
>> Hi Chuck - I'm back working on this, hoping you'll advise:
>>
>> On 29 Dec 2025, at 8:23, Benjamin Coddington wrote:
>>
>>> On 28 Dec 2025, at 12:09, Chuck Lever wrote:
>>>
>>>> Hi Ben -
>>>>
>>>> Thanks for getting this started.
>>>
>>> Hi Chuck,
>>>
>>> Thanks for all the advice here - I'll do my best to fix things up in the
>>> next version, and I'll respond to a few things inline here:
>>>
>> ...
>>
>>>> I'd rather avoid hanging anything NFSD-related off of svc_rqst, which
>>>> is really an RPC layer object. I know we still have some NFSD-specific
>>>> fields in there, but those are really technical debt.
>>>
>>> Doh, ok - good to know.  How would you recommend I approach creating
>>> per-thread objects?
>>
>> Though the svc_rqst is an RPC object, it's really the only place for
>> marshaling per-thread objects.  I coould use a static xarray for the buffers,
>> but freeing them still needs some connection to the RPC layer.  Would you
>> object to adding a function pointer to svc_rqst that can be called from
>> svc_exit_thread?
> Forgive me, but at this point I don't recall what you're tracking per
> thread and whether it makes sense to do per-thread tracking. Can you
> summarize? What problem are you trying to solve?

I need small, dynamically allocated buffers for hashing the filehandles, and
it makes the most sense to have them per-thread as that's the scope of
contention.  I want to allocate them once when(if) they are needed, and free
them when the thread exits.

Ben

