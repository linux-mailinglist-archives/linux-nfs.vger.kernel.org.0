Return-Path: <linux-nfs+bounces-21864-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEohFDHCEWpDpgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21864-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 17:05:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F9F5BF87C
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 17:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 951BB3007523
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 15:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC573002CF;
	Sat, 23 May 2026 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="OnOUk4qM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010022.outbound.protection.outlook.com [52.101.69.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3A8218EBA;
	Sat, 23 May 2026 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779548717; cv=fail; b=FCBt7Y6S7PzmuU00TDbI9pp2/lP5L21fY4E/bNzUpg8GLy0mNf8oiZB2i0y8E1BXmrKJubOINHEsc/f1Zhc/zANogOsU6QEJAZOYE2ilEB2vreO0TmxR5u20RdhYG+4w5M76XfB3xu616j6Artj2pk5emmRgcsZYAgLQZ6LSysk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779548717; c=relaxed/simple;
	bh=xEiz8BkJgp7MUVncezwjJ6jv190l78ar/eyWMIOtBzM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cQLRJuOF45ZDI4au5+W0Q3YTdqAMpN4LO0mb53U5miCRb7FXVT5lcHbJaON6FCb4QEJkLS7vf9wPYzSy1NOVSPVrnDa7fcYSjFC5OqkcPrVggn4UxD2SyEhNtes9RexiDEIZpI0ZgltumCMF87V5Qk50fVLyoswMLiSUKBcN2Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=OnOUk4qM; arc=fail smtp.client-ip=52.101.69.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGgRBn0+oopOLmbzX07jyao9yJjCcSmyo5rHsN/Ci1NbjcgNzt1UDBz/8tH3HqyuENjDbauCCZQiUs1ePkAOV2UcBiqG1Ao2r0Uh+LwoyUvcvWuoiiQsj3hwjYy+7VTLE4yx6HO9U4DQepUVhybMkPJRhLc5cHQ/AQ8kH3y/su9L/BYQlF6FlW3FjujL2xukkocXgQTACGXGtXDlT4xlnK3wpdFLu5TZUPR/yBUbSPDzPbnUZQEjTTUBr4GC1cl1Y5EMFK1LLVLzeeql5pLjl9Z8Vhs9A7FXt0MDeYjPUzd24NFTZdbdLJqgNwBl6l/np/EqlyxLvNAoCdnmJOTRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lM6XFgBnDQRzF0g/lsSy0OTrlpdiocTQ5Zg3wGe3+A=;
 b=jy8nmdu3DwNCUE7zt2T6NHuSq0L5MiSD84E0MZRcpfWaAgm3bjJv7hBHDNmZGbuV1hLv6Ij/4ULuAG+evZsW4+5+AKTiIMCpbt4FgT4n9E+Eqwizx0O1+HyBuBzxHXQ5eWAZ5lbRTN/VkQX68T+R3PXo5v6HJQQAanJmWuixHA9+sR6FvxDWWwd2OWc8gf4JUlxteoq1OiLZDRP0TrhHC3UGVdzMRFJT+rsP0eRtJJPuVjbRCeRsQItPYAOT6VXdx0WNxw/llNWU9VMKrVEiy30NfLS57rhid1vn321gMrOYRoVegaRHriNee9h06rG7PEqtR+yMzUKcpDh9umjKWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lM6XFgBnDQRzF0g/lsSy0OTrlpdiocTQ5Zg3wGe3+A=;
 b=OnOUk4qMxB8y3g0u4QTxSnBrB92umovY1ZOtNevgFN1fn/UIFy5uMAE2mO8wA9HAxrkzgoz/YxAGHIAJ+OWfbumwkhWpqC2cgmS3gVVl0/sIdp/pMZ+5E6xcawGz2YuJ3EtFmPmYb3wduwGqdDESVilkIeJcMhuBeqIfU1Hjzzf+onkVZJtwNqajKlpyvm3Lj5uTDGi+lKR1xfX3nyLlvhyh1ihYW5BXCpf0LeN/a20OzPAcRSsfn7gi6/3cou0BjNdkHCpGtZTd4zrw1s1qfakSk05LhyZfkKHozXeEoPzm6VLnC5cBKOUe7ZkSkOVKNnmbojT815KNg21wkMGufg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:39b::19)
 by AM0P189MB0754.EURP189.PROD.OUTLOOK.COM (2603:10a6:208:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 15:05:11 +0000
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4]) by AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4%7]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 15:05:10 +0000
Message-ID: <c2a74857-d043-4e8e-a9cc-2ca3cde52b25@est.tech>
Date: Sat, 23 May 2026 17:04:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: DEPT (the dependency tracker) as AI review prompt?
To: Harry Yoo <harry@kernel.org>, Yunseong Kim <ysk@kzalloc.com>
Cc: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
 kernel_team@skhynix.com, torvalds@linux-foundation.org,
 damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
 adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, mingo@redhat.com,
 peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
 rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
 daniel.vetter@ffwll.ch, duyuyang@gmail.com, johannes.berg@intel.com,
 tj@kernel.org, tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
 amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
 minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
 sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
 penberg@kernel.org, rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, jack@suse.cz,
 jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
 djwong@kernel.org, dri-devel@lists.freedesktop.org,
 rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
 hamohammed.sa@gmail.com, harry.yoo@oracle.com, chris.p.wilson@intel.com,
 gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
 boqun.feng@gmail.com, longman@redhat.com, yunseong.kim@ericsson.com,
 yeoreum.yun@arm.com, netdev@vger.kernel.org, matthew.brost@intel.com,
 her0gyugyu@gmail.com, corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org,
 gustavo@padovan.org, christian.koenig@amd.com, andi.shyti@kernel.org,
 arnd@arndb.de, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, surenb@google.com, mcgrof@kernel.org, petr.pavlu@suse.com,
 da.gomez@kernel.org, samitolvanen@google.com, paulmck@kernel.org,
 frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 josh@joshtriplett.org, urezki@gmail.com, mathieu.desnoyers@efficios.com,
 jiangshanlai@gmail.com, qiang.zhang@linux.dev, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, chuck.lever@oracle.com,
 neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 trondmy@kernel.org, anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de,
 clrkwllms@kernel.org, mark.rutland@arm.com, ada.coupriediaz@arm.com,
 kristina.martsenko@arm.com, wangkefeng.wang@huawei.com, broonie@kernel.org,
 kevin.brodsky@arm.com, dwmw@amazon.co.uk, shakeel.butt@linux.dev,
 ast@kernel.org, ziy@nvidia.com, yuzhao@google.com,
 baolin.wang@linux.alibaba.com, usamaarif642@gmail.com,
 joel.granados@kernel.org, richard.weiyang@gmail.com,
 geert+renesas@glider.be, tim.c.chen@linux.intel.com, linux@treblig.org,
 alexander.shishkin@linux.intel.com, lillian@star-ark.net,
 chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com,
 link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org,
 brauner@kernel.org, thomas.weissschuh@linutronix.de, oleg@redhat.com,
 mjguzik@gmail.com, andrii@kernel.org, wangfushuai@baidu.com,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-i2c@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, rcu@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 2407018371@qq.com, dakr@kernel.org, miguel.ojeda.sandonis@gmail.com,
 neilb@ownmail.net, bagasdotme@gmail.com, wsa+renesas@sang-engineering.com,
 dave.hansen@intel.com, geert@linux-m68k.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, rust-for-linux@vger.kernel.org, Chris Mason
 <clm@meta.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Josef Bacik <josef@toxicpanda.com>
References: <20251205071855.72743-1-byungchul@sk.com>
 <6b2a816f-eb3b-4e0c-a024-ee2e3743eb04@kernel.org>
 <CA+7O06GxeDLR9RcKDN2i-Rgc4kgzz6BfF4b0XAH4tFx=A723Nw@mail.gmail.com>
 <0592b09b-a084-4d9d-bcbf-1b77e45226cf@kernel.org>
Content-Language: en-US
From: Yunseong Kim <yunseong.kim@est.tech>
In-Reply-To: <0592b09b-a084-4d9d-bcbf-1b77e45226cf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF000239C4.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::1b4) To AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:39b::19)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P189MB1752:EE_|AM0P189MB0754:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a0a403-31dd-4280-da47-08deb8dcaf58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|56012099003|22082099003|18002099003|4143699003|5023799004|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	x/DVjpp8rtpbyaki9kKmHFQT0z01TB0w3CS11/gMcbjXd4P9xLMnPzBpFoR1Mdx0t000S/ax8P6a84EgohJdSp9rJUD0lxYnko7IB9BPIEr2pvXL8IOlPpEHM8B/Z/5UR5M4VHNRdXcMw3bsjyJrbVhyIl94yBpscZCZHshuiwJcPoXie7NzkipKn7dG6sOldFuR0RQN8/z0Aimvr/D3BYLbT3TPFuWIAfI+gI9OL1pFtQ0fHD5z7l2hLyWB140jpX3/10Cv6IaF2UhZ3pv+SL3uG7a3joZvob4eVSQwhWBh5waBLl1MiB60oom9tYFo4axpxBaL1nDxtEfkRQ5nI2rrJg7ULQRRBNQphR2anqmWbWm2KAHd/wcpnNm617DW2cf2w1m4HOf5Ga6Mm4kYhi+S4o7nVkvc2TAaCmtxwf5qeClZ3V1ETn1/vrur8PmwbMfxVRsZ6wDq+RWpvJMnQ1sVwm1k+FN0uzvvB3ykTOWUWqSib7hmjQu5HbYGF5J1gsMkuHmKA8JFdGpVhtye/GbIrSnm6/YXt/i0pNr/vtfySAhn+2UkXNY5zCuPvInKbz8wBfvzucRnKLCVUBhKNV0kUdT69RV2iI72rpKPG1s3DjgRYtpvB62/7lrUBH4whCzzt9rTSWDk17qrgf/V4o/FWRhJDczaQYKCYM5H1isbCuQjY7apqbqwfzn/+N8y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P189MB1752.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(56012099003)(22082099003)(18002099003)(4143699003)(5023799004)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGVLOTRLNE91QXFJOUZqeWs3WVVwb2xML2RNaHBEd21qRXpoaFRzcXJkS3V4?=
 =?utf-8?B?OU4yUVJLcW51dUozZjVLYkhpMElQc0dDT3EwWTIyYlZhRUpHVkkyNEhIWmEv?=
 =?utf-8?B?dFQvb0ZMRXI2elV6RE9xN21YVUd6N1RVT1lFY0cxN3hoaEtMZlBZYTJYSXVN?=
 =?utf-8?B?bWVkN3h2ejl5RXEzQndFM0NTNklmK3FjbUhxekNtQmE2RWlBM2FqMC8vQkNL?=
 =?utf-8?B?d3RKbE9qMW5ITXZWWW9CR3Q3VDN4WHFMYklvaW8xVGV3RU5hZmVXSDA3M0tG?=
 =?utf-8?B?SnI5Tzl1aGhMak41THI4NFVYMzA3YzB5Z3pHanJEK2pUdVY0cXZwaEhPVHdy?=
 =?utf-8?B?bHBUTzlHZnMrd1JwdldOUmZwMnlPUnpQdDBiNkY1ZWwyMndWRmN0NmRvVko1?=
 =?utf-8?B?ckxwWEgvcHlVRFhVejZGakxQZGsyeXRpQkZRSVJaNVBrb0lIcHdzUy94aXpW?=
 =?utf-8?B?Q2RidGQxMUQzc21URFkzQ3Z4cUo3RE9uKzg1WDk5MVZSVW5JSGVEYXVMUTRW?=
 =?utf-8?B?TDVoMFBNbjhYZ0RnUW1tWWl1NjVnazBGMEdXUTY4ZWhFR3c2RzNzM2t5L3dm?=
 =?utf-8?B?R09TN2dzc1ZtT3l6WHNTNG9nTDlUN3pObmxUa3BUdjc1UFBqdnUyMXB0ZU9V?=
 =?utf-8?B?dml1elBTbG1TOXpFTlptVlh5bVVydGFqNi9BTXdQck1ocWFlb1E4WDNGZ0dV?=
 =?utf-8?B?em93citoZDl4aWVjQXJQWmFoSFU3b29kbjFYNDYyTm5FN1lrbURYa1JKVmJM?=
 =?utf-8?B?OUVlUGJpWFhNNW1PN216SHhpTVVyc0U3NDVwTEE4MU1rZ1JiYy9oTVhJQVBm?=
 =?utf-8?B?S3FIVWRSSlRkV3JFUnVKUmFuQjZMSGdVYVZqYzh6b2RrRCttaXhvZTl0Zmk3?=
 =?utf-8?B?OHJSWnlIYUVDcGk5bEpnRXJseWFQVjdXQU9XTmpwOTRlZHJqOHZSQTNveVp6?=
 =?utf-8?B?UnNWeHlJREs3cUp6ZHpTcHBVTFAza1A2U2wyNUFLMFNWNWRleU8vMmdJN1Bq?=
 =?utf-8?B?NCttRUlLSXYyWlZuc09mMWdXakxtWHRMdXBhT3lybmhxWEx1MTVuMzcvdFU1?=
 =?utf-8?B?bVREaXRHczM4WjNKcjNZZHBSMC9vbnh2aDhlT3FwaTFETnd5TDhIWk9yNEpZ?=
 =?utf-8?B?VEs4RHhNdGpzM0d4cVVLTEdwdG1UdEhyK2djaEJ1MTI4ZDdabzlXVmJsKytV?=
 =?utf-8?B?VVAzOElOOUNyWXJUYWtaTnZvRDJuRkNIa3ZWVW5EYnVKemk3dWgrZ2hRU0NV?=
 =?utf-8?B?UG1aNHQ3MmhLZ2hZOUJUY2lIN1RwZlU3WDlGaTg4elVyOEdmdFc1NU5LMGRK?=
 =?utf-8?B?NFN4YVUyUGNCU0IrZUpUYTViZ3phMXcwYy94MWEwUlg4WTBObjNHai9KQkY2?=
 =?utf-8?B?WWVzNGc1TzFKL3BJVGNHU1FNcExhRDZrMXRKZ3RRWUwrVER1d3RIWUFqWklm?=
 =?utf-8?B?cURhQmVkQ2M2R213OXhDcWtCVWpzelBMRFI2N1FLd045WlVndU9mZXUzdVF0?=
 =?utf-8?B?UzI5M3d0UU5zL2RiejhZMjdZV0l1c2VTaXJjVVBMNFhpbTcvSzlVbXlNdnMy?=
 =?utf-8?B?TEphaW1JZlBJa21ybW0ydGtyRm1ZdTNhbVczcll3UThRMUpqNVZtSUNlQ0h5?=
 =?utf-8?B?ZWZtSkhmWW1NR2xYTnZiVm1qMTVpTm4rUkpxL0tjaFoyRlNaYVgwWWtPV29s?=
 =?utf-8?B?YnJTMG16Lyt5TzJXN1VCa2w5Q05aRnVQNGlxTFhDalJPcDdPTEpQMjV0dmFO?=
 =?utf-8?B?aDY1UEY1UlFjelNxeENDaVBRSlRlcUNvclR6Ym5xNVZIVzAxbGZnRHRlNEZn?=
 =?utf-8?B?OFkxbXF4TkpOQ0YrajFkVVEzbnNHSFJEc01wMlEycTN2SFA4RjBpcjl4a1RZ?=
 =?utf-8?B?ZFBNYWl4cHFTVXNNSk5pMk5CUU9LZmxveE1yc3FCU2Qybm5lYUhDeENxUWF5?=
 =?utf-8?B?RkNaVVBiWFkydnd5a2ZFUE8rTDllVjkvcU8waDZwWGdjSkhYclAySWVFNzVj?=
 =?utf-8?B?SUlub0JTNWsrc29JZWxXekMrYjlLNlA2OXg4cjN3b256eWkvOFFFS242cnZm?=
 =?utf-8?B?MEdVRlRTQWEwTTQxc0hTSzBjOFUrNU9pVFllMWdORk9pdWhudHZlOU4yWkVs?=
 =?utf-8?B?Q3ZxWEYwbkxYd0FOWHlrcm84OEJ5aHJPVVcvdmt6S2QwWmdJNzlaK0VHNG5w?=
 =?utf-8?B?Ym9XVDZvWXlvRFBYU3I0azVBRkk5RnBQTFZ2TUV4TzdYbFgySVU0Nk9QVmxU?=
 =?utf-8?B?OVB2V203Z3J4UFFnMXQzczBTcHd4VG1xRnM5R3pPRGNPcm1qK29DYWlZTGMr?=
 =?utf-8?B?SjJjSWpIUmJJWFQ5TU9iL3I1M3BpWGNBOFc3R29DWGJtS2FXR0RiRzM0dW5N?=
 =?utf-8?Q?Y+efjEiK1ZEK9iNOUdlou6KPpQHVBL7wmcUwypPCRUlv3?=
X-MS-Exchange-AntiSpam-MessageData-1: kmHxRz7M3Cgu8w==
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a0a403-31dd-4280-da47-08deb8dcaf58
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 15:05:10.8667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQ5kN/58gQ1jgrudkYmbd+zET7SkQ4tFrNNXgheVNoMqOtWqn0gt9JkAl0vGc08x26U7BPVik0akB84pg8IUWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P189MB0754
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21864-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[sk.com,vger.kernel.org,skhynix.com,linux-foundation.org,opensource.wdc.com,dilger.ca,redhat.com,infradead.org,kernel.org,linutronix.de,goodmis.org,joelfernandes.org,ffwll.ch,gmail.com,intel.com,mit.edu,fromorbit.com,linuxfoundation.org,lge.com,kvack.org,cmpxchg.org,linux.com,google.com,suse.cz,vflare.org,lists.freedesktop.org,oracle.com,ericsson.com,arm.com,lwn.net,alien8.de,zytor.com,linaro.org,padovan.org,amd.com,arndb.de,suse.com,nvidia.com,joshtriplett.org,efficios.com,linux.dev,suse.de,brown.name,talpey.com,huawei.com,amazon.co.uk,linux.alibaba.com,glider.be,linux.intel.com,treblig.org,star-ark.net,valla.it,vivo.com,baidu.com,lists.infradead.org,lists.linaro.org,lists.linux.dev,qq.com,ownmail.net,sang-engineering.com,linux-m68k.org,garyguo.net,protonmail.com,umich.edu,meta.com,toxicpanda.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[est.tech];
	DKIM_TRACE(0.00)[est.tech:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yunseong.kim@est.tech,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[169];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 32F9F5BF87C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Harry,

On 5/23/26 16:34, Harry Yoo wrote:
> 
> 
> On 5/23/26 11:00 PM, Yunseong Kim wrote:
>> I've previously experimented with running DEPT alongside syzkaller fuzzing,
>> and many hung tasks missed by lockdep are caught by DEPT, but the resulting
>> high volume of reports makes it easy for issues to get lost in the massive
>> log output. Sorting through that output manually is a huge bottleneck, so
>> leveraging a well-crafted AI prompt to triage the warnings and filter out
>> the false positives would be incredibly valuable.
> 
> I mean both 1) detection of deadlock issues AND 2) false positive elimination with AI.

I completely agree.  Implanting DEPT's model into an AI review prompt
is a great idea. As you suggested, the patterns we develop for the AI
could provide valuable feedback to enhance DEPT's itself.

> If the review prompt is only used to eliminate DEPT's false positives, I think that would be quite hard to get broad use.
> 
> Someone would have to build out-of-tree DEPT, collect the reports, and then feed those back into the AI. I don't think building that kind of pipeline would actually work well in practice.

I also have a huge dept report of DEPT reports, and manually
reviewing all of them is makes me sigh. The constant kernel rebuilds
required for lockup testing every time are also quite expensive.

Thanks for the summary!

Best Regards,
Yunseong

