Return-Path: <linux-nfs+bounces-17804-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD32D1A13E
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 17:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94F8130004FB
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 16:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4045E31D36D;
	Tue, 13 Jan 2026 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="JYhQNuQh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022098.outbound.protection.outlook.com [40.107.200.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EBD3043CE
	for <linux-nfs@vger.kernel.org>; Tue, 13 Jan 2026 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320339; cv=fail; b=bAEuLKqm4qBJJloqatNn8jKwBiDuiqjoYjE9AFVLM4i6Fv3F7xcj5P6I8K8YOeWgp0pDBg0PExzrj9OoeWU1z2QpCMWTj6Uf2xAPxfPlfpLLaw8bWibvqJwm6+TOQES519BFi5/nZtO7OuCGVRjkuEEr8SNfnek/hkfkxFk9X3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320339; c=relaxed/simple;
	bh=LS+m2740j7YyXE26kOkN4unDDJQ26gHUC4PVKWtSk9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XggCPjt7YvFLaQET1fgGTqduTC8TkdPPwS8BNZTuW9UwQ1XRdhKBMw0YEmb/W8P4E60WEo3LyEBkn+fp46UqbtIR980MAX1R74unGt9VCWKdbS2RR2H3hpZpm2moXDqKF+lu83cu84354uYwuFQUntvTpSZbdO/VKWaxSyMT+/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=JYhQNuQh; arc=fail smtp.client-ip=40.107.200.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1Q6SGKWXsLlQ1pYj/ndR0tWY+bxNkeKZ+djtyWWKahmzjRrewuBOJdBPDm3T0rEOrFVFJ0RbocQMznzqM59qgV/jjD994PZ0H7KGCpqReZ1KDuNLbof6N7ziH5nGqX516qK97VkEHuHnckA/6l1XFnwuuBHEhF5hjRFVBOzlf8j7qf1fiauc6rZHbS8m3ZsbLb5JST7BwqFfo11fa+KOop7uDjqzsVxzxibHkQ4T+K6CQ1dv9SPRlOwwKJGitgmA8O5Vd4tw2GQ91lK1KhpmrxsWsgX4L5iuWjn4poHDT1GDbFdXz0d4zKOteVEVwL5YL7Isq8d4kb0rhqbvJRujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8I8R2loerubcXdUWIz7pzkvh9fIw4tAL8x8pFJblCQ=;
 b=I0jQbGPJvDeExWdwfLvbPYI9N4iWSgU70SKJTvSO87cOhN3VgL7c1px+aZQBmkofs4jzhWDX9SEGr1D0v64DmIL7SPEK+BQOaBSj1rXfCLqoxL4mQ03mKA00KQMxwvpPJ2xM/75gbVM/9d73P6ab14MXmzbiEarW1/+sKcIVejBbkErloSgVXvQINNORzGCXtdZ/H4Hizm3CSLiJWCkHTDnpu/Y6DL2Tbxrf5U98lAkvNMaLrJkisjbsi/Dk/5fu/dMwEwPccvGscqZm4IT1W6c4jY6JJLOQHwVDlxZ2lg0Sgo/xNF0Ue9CLjcYHx9OKYPVEuliEhTrK49Y8s/t3hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8I8R2loerubcXdUWIz7pzkvh9fIw4tAL8x8pFJblCQ=;
 b=JYhQNuQhk/NXJjeP6ij2hQAFKYpJxUJaiYTA98xD8q381ImeeoEWqsDcVVXoz0aOS+b8yTXkE0th7mJB7Q22LlwbYFaqtbIi/WKQhbvRPXhTPCrawQeUUqkkD6ITarkRsYFNv6+PueH6JTOksn029x33hXPbCylVgqbKTFKCVsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 PH7PR13MB5453.namprd13.prod.outlook.com (2603:10b6:510:138::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Tue, 13 Jan 2026 16:05:34 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Tue, 13 Jan 2026
 16:05:33 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>, Eric Biggers <ebiggers@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
Date: Tue, 13 Jan 2026 11:05:30 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <A3F6E0BB-523F-4B99-B583-D6D80E9D7BFB@hammerspace.com>
In-Reply-To: <dc3d8ff3-f68f-4200-a546-605f0f2e3611@kernel.org>
References: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>
 <cover.1766848778.git.bcodding@hammerspace.com>
 <aac7f668-5fc6-41cd-8545-a273ca7bfadf@app.fastmail.com>
 <2DB9B1FF-B740-48E4-9528-630D10E21613@hammerspace.com>
 <7F8B576A-465B-4DCE-95F9-9F877513DF2A@hammerspace.com>
 <1e92e144-d436-44dd-956f-3125403dfdc8@kernel.org>
 <ECE1341F-BA8A-4DC7-BC9D-BDD6F10F6013@hammerspace.com>
 <dc3d8ff3-f68f-4200-a546-605f0f2e3611@kernel.org>
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0032.namprd17.prod.outlook.com
 (2603:10b6:510:323::22) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|PH7PR13MB5453:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ffd6725-c5b1-4575-81d6-08de52bd94fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nXx1NcI19s+DFP65QUImAundYbdw4utvTKQf0QIHMWs5vVcWAVWozXntm2h2?=
 =?us-ascii?Q?Cb4U0dT2DzGNoeASVIYi3BUigXXECy5Hy4RUOf7B6zxU9kJs0/5MmHCk32Ir?=
 =?us-ascii?Q?V0JsBoHLiNC+hmHCy85GjvM5zjFuf2BGU4m4M8mDEPOegiXGazEQ90+YPxD9?=
 =?us-ascii?Q?jL3a5c/8+7iK4ZkCSxTHE7RVdWDrl+Bzi4v/NSzzMzHkI8tinZaDYJ0R3Rxe?=
 =?us-ascii?Q?Old1KAr4N8bxNj8prWppYKP2jR0iUz1rTxH9pmQRv3FM33pmUFB87qQeQzVJ?=
 =?us-ascii?Q?eNV1fxnRR3Rx3fNUC4MUJkNvqCpZPdfuJMiZPfCz4hlmp7vFnH96HVkLwwAx?=
 =?us-ascii?Q?3rB3PAAlswdF+HbLExMCDsPUbQUy032gcF7yuDYcYRazKX6h3aJvBP18rL8m?=
 =?us-ascii?Q?+Wi4tG630GpRdudkQ0zb8MRXjKDu4tU3Z7hMq7cHYj0wFGmDpUlYdba/s4Tw?=
 =?us-ascii?Q?2GVGfuWMDCaHK2z2nARTfgNaKCeNFxxwpmverNnTbRqY0aYkXM+0Zz1sQeZ8?=
 =?us-ascii?Q?KvjCb/TY6Y6Lk5lQm2VibVk2f583pJXPFGXZEsSEn+SEF9hbOI4nDdAuA5I4?=
 =?us-ascii?Q?Rx2Mjmb1uoemj/MdaauZqrTBHFGyvON8w/KGnwZjo81SkJYO6fCeYZPFCcm8?=
 =?us-ascii?Q?Kh1GejcshaGbIKZrZ25ppoLO8O8rSWRIjnJ1usafP8hh5a8JO+RyYLjBLKGn?=
 =?us-ascii?Q?cJOq938wj8EcydC2Wk8psIlimDL+FVaNeSGWKzlmVuf05IoEwawwqP6TfRdV?=
 =?us-ascii?Q?rDnKlvem4whq38izNlEZEQse1IjD0dpjsz7UqCdR4Qw/HjjsyODUUshXzE0/?=
 =?us-ascii?Q?S+nTculWkaobvlHWzBINDAHYgAVKvAIxRNjDOcdeicRozB/dI7YEUT2hVGoq?=
 =?us-ascii?Q?2utpS9ZbJ0Y5dZeroiFPXBOfnWWBwMzF2EkNDZWallKvKAfMkj1auV3Foxpm?=
 =?us-ascii?Q?uVHe7S9iYvyhcqc5LxbrEp4BmBxVi/fD18duT7bFPOJQ0Iy43f4WELKtufsF?=
 =?us-ascii?Q?LfSP9/7SQ4vvBljlqT5lZkxi5h1++L+gzNTfds1vO4bGFyMTIvephg2Z1dXH?=
 =?us-ascii?Q?KyEX50cVnvvaBV+Dfv+v9DRBsPAJCTJYSvcI3wFaX92dY/8h+V1O9jVN8B8o?=
 =?us-ascii?Q?ETUSDCSY3HGm6nV9c5buZDMTuUd3/4wD1HSHoAjiNnbCHdvHBsEx+tZ7Y5NE?=
 =?us-ascii?Q?ZYPuzpC1+6MUvez8rCeEko0MYIYnxQLHeDJ7RyVfKonmGrHvSocA/GaKDd9v?=
 =?us-ascii?Q?enBJ98GXKAuSKeTttXJY/svb0x+VBucQCvWjMyENMB3eJaDl+LR+/kmP2svp?=
 =?us-ascii?Q?jkvze2aBCkCOYaU+44adC3Ga3ktsrJhHma5yF/z8QqarGi/cu+IKFTur+FF0?=
 =?us-ascii?Q?GyJ/T0V4kP+99K1aHNyJlDCZpzXlcSbsacWthFd0pIWYbrsPCa7H7IqCMO2j?=
 =?us-ascii?Q?a8SK1fMSZWcv+7qKxwmy4XB2QgSOLtrG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EEYPYyLkgczy/WalvM0TKqULo6kDnD7QQo6ZW8E8dru5ioAETaaUCIRunfEl?=
 =?us-ascii?Q?c7+6bLPU3hnGfAstpvV5HsZnhWTE0NoCHHkKfLActPwiqhZHVdT2xXYdegcM?=
 =?us-ascii?Q?tRSi+d8jJHKVwst6pJcQkhm6Dq/kzDUgfGXkH4xczUeK3woOGs9W6W1ZlmWZ?=
 =?us-ascii?Q?j+gdWXnjl2INa6S/E2TZLS//V8c896x7g8asew0vkRAYmp/a0eHR8hqZtMOt?=
 =?us-ascii?Q?ppf7Ji5FjSRdHERTvYofNN5Jg503Yf1hyCX943nICwnWSUCPC3V4Ek+QsqBl?=
 =?us-ascii?Q?rULI0vTMapWaeF1StFbOiOEIH9rIq35mHcj+6MO6slV+4bet7DpVkW8KfdOh?=
 =?us-ascii?Q?aebi1P6ixWs/0JqbcvZInb9lWgl2JuOwY85EdQC5CCzmWB0ICyt5jaipnKb0?=
 =?us-ascii?Q?desSFZ1N1sXdMbTeKtdLKKSOt+ioLUit1N2FgjVSROQKbeU6qwbuv3L6vYsR?=
 =?us-ascii?Q?AX0xoF0vlaaQSB10Jks+C7pccVoj0UYxtvTjXOCkQFae6EzS9iSX+OEtaK50?=
 =?us-ascii?Q?QbUdzOyiE8ZPLT/hut5Q0afOICsyLybg0Tepjo6MajQDXvhqU+goxz3mrwKZ?=
 =?us-ascii?Q?vXZi/OH9xvxE31dk4VNeX4C9JoHA/kLx/vPdNRxs3vQP/CvBCoEKb/+e/a2y?=
 =?us-ascii?Q?DVFUwyb2M6vNMFh2uPw+bE3pY/TvXabLDd8i/P9JKl+HQde5IgV9Dpb+zCq6?=
 =?us-ascii?Q?+SEMEBd2MrLfnfB13JnU1uBZfG0JbMRgJb81sGXf3bWjiYvRVRhMeDDDInRD?=
 =?us-ascii?Q?lFWL1lUNddjuoMm4kIglj7cVT5qxYIqAKvbR4dIjihUFVe/IWvaA2g+v/fbn?=
 =?us-ascii?Q?IvX0ddtWgxQw1H5rJkNVFtYjP2ycWTHHAt+IC/+Ggduk64vfkv4kNbWlCNXv?=
 =?us-ascii?Q?3hQUYFvB0GMn2oI3wuJOZF2WkIn8Db2ZLvjt+Vml4eqM0XTBdgzzs8WfOxV8?=
 =?us-ascii?Q?l3Y/yjMhctyb/Oc8ZsgwAqqyIbppUaNs2XUBTpodbaJ4EbEMvWJDz5Y6LZ9f?=
 =?us-ascii?Q?Xp0Cku2Sv9RCoIbLVrYJKrW220Q1s9WJQVzLVvwSdqeHBMDVncQ2MWwdK9rE?=
 =?us-ascii?Q?lUbAW1oMMh+0RM86SLCEZ/4sEbIP/FiVOzLInI4YbufsUab4Zreagf/ZnNN4?=
 =?us-ascii?Q?9cYSBeQwzTc886RZU9Tk8vY+qT078TP1+54hPn39iZmHyXmGR0k2YwcThHHG?=
 =?us-ascii?Q?aShxjoA964tLwvxUZ9cUrxfrga+utvdPVJ7rc5SpZhlzE8o39FdW6gunK+id?=
 =?us-ascii?Q?SGOnHoHXMHuuxhYufehz2vfyGwjESR+MqSdu8FgpHW8At8+7M7H7lKTwzU7q?=
 =?us-ascii?Q?Hf0wqLKGphBSB+Y7qV+SJRncKK3fgAfP7633FjI9Lr2U+ucBQESCZBM3UfIX?=
 =?us-ascii?Q?CtfCgaL4DvZqHYfUGmp1rdKHilikURbUZkR6lg6SUBx9V80cUOzxtpfpegqu?=
 =?us-ascii?Q?3zbsUJyBt/1VBEZPzmE49zQ6kiwKxXLGN00RGoUJ56v5KpqYhEVqtR1ruVLE?=
 =?us-ascii?Q?DUK+T5I6w5dsIdve6qyNK2KeujlTKndczIidlcBhOjoo4Ac9NcdJDTCOJe4O?=
 =?us-ascii?Q?XarNqpPPk05yt0YfoL4xMZiSFxF7YQkTXqJL0VXFTwiR8gC8aoiK8mtlQ8nW?=
 =?us-ascii?Q?cug3PzEtUsLjOGbQ61yUIgQnw+qoSkAdbaUCpVw7+75MlJ4OPPMCG5LCALGA?=
 =?us-ascii?Q?JTkyT4qJbCgeCm+NwZwpf3jQqvHnuQO33f2PVAp/x0ofp+IVhKOl2NxaMg8H?=
 =?us-ascii?Q?oY4/wRMgKnHoC8dAlJN53E1GJ1saEJQ=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffd6725-c5b1-4575-81d6-08de52bd94fc
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 16:05:33.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pv4HAXBztQkUh2JPueI5SuLbd1u+Zp7MHAbSghlE6YO1d05Xq4lMGp6cE4GRpLMApXL1WK6ma4LRTmg4uaJhrnZjq+KrBwDk3OcSfkgxaq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5453

On 13 Jan 2026, at 10:18, Chuck Lever wrote:

> On 1/13/26 10:07 AM, Benjamin Coddington wrote:
>> On 13 Jan 2026, at 9:08, Chuck Lever wrote:
>>
>>> On 1/13/26 6:51 AM, Benjamin Coddington wrote:
>>>> Hi Chuck - I'm back working on this, hoping you'll advise:
>>>>
>>>> On 29 Dec 2025, at 8:23, Benjamin Coddington wrote:
>>>>
>>>>> On 28 Dec 2025, at 12:09, Chuck Lever wrote:
>>>>>
>>>>>> Hi Ben -
>>>>>>
>>>>>> Thanks for getting this started.
>>>>>
>>>>> Hi Chuck,
>>>>>
>>>>> Thanks for all the advice here - I'll do my best to fix things up in the
>>>>> next version, and I'll respond to a few things inline here:
>>>>>
>>>> ...
>>>>
>>>>>> I'd rather avoid hanging anything NFSD-related off of svc_rqst, which
>>>>>> is really an RPC layer object. I know we still have some NFSD-specific
>>>>>> fields in there, but those are really technical debt.
>>>>>
>>>>> Doh, ok - good to know.  How would you recommend I approach creating
>>>>> per-thread objects?
>>>>
>>>> Though the svc_rqst is an RPC object, it's really the only place for
>>>> marshaling per-thread objects.  I coould use a static xarray for the buffers,
>>>> but freeing them still needs some connection to the RPC layer.  Would you
>>>> object to adding a function pointer to svc_rqst that can be called from
>>>> svc_exit_thread?
>>> Forgive me, but at this point I don't recall what you're tracking per
>>> thread and whether it makes sense to do per-thread tracking. Can you
>>> summarize? What problem are you trying to solve?
>>
>> I need small, dynamically allocated buffers for hashing the filehandles, and
>> it makes the most sense to have them per-thread as that's the scope of
>> contention.  I want to allocate them once when(if) they are needed, and free
>> them when the thread exits.
> I'm asking what are these buffers for. Because this could be a premature
> optimization, or even entirely unneeded, but I can't really tell at this
> level of detail.
>
> So is this because you need a dynamically allocated buffer for calling
> the sync crypto API?

Yes.

> If so, Eric has already explained that there is a better API to use for
> that, that perhaps would not require the use of a dynamically-allocated
> buffer.

If he did, please show me where - I only received one message from him which
lamented my lack of my problem explanation.  I responded with much more
detail, and nothing further came from that.  V2 will do better.  I missed
any assertion that we wouldn't need dynamically-allocated buffers.

True - we could use siphash or HMAC-SHA256 as he suggested, but both would
still expose detailed filesystem information to the clients which was
counter to my design goal of hiding as much of this information as possible.

Using a MAC may have the advantage of sometimes resulting in smaller
filehandles (siphash would add 8 bytes to _every_ filehandle).  But it also
may not result in smaller filehandles when the unhashed size lands on or
just under the 16 byte blocks that AES wants.

What would you like to see used here?  I do not think that allocating 32
bytes for each knfsd thread for this optional feature to be a problem.

Ben



