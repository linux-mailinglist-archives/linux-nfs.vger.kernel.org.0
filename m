Return-Path: <linux-nfs+bounces-23136-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GY4GJAcNTWr1uAEAu9opvQ
	(envelope-from <linux-nfs+bounces-23136-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 16:28:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE50771C9C1
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 16:28:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b="NWZ/YLks";
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23136-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23136-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E144E3128266
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 14:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE7B42643E;
	Tue,  7 Jul 2026 14:18:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022112.outbound.protection.outlook.com [52.101.101.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DC53B810D;
	Tue,  7 Jul 2026 14:18:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433919; cv=fail; b=R4BDoCDjAl4P7n4pjBDBj0BXTYhVCsu2m1pTdyDYufLISbEiWQHw3xRCo6hCTe7+PIUO9hDK0QG3yS1Fc6ed+d3Qcjk5asNwaKGwsfV56B+J0zRxYFTlBWlqhX+SBfgIacwcB9VDg2vYfqKaoKGFB+hCrH5kRcv3JY1R/vseHsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433919; c=relaxed/simple;
	bh=nGQqlNp3YeJ7+ZZbboYIlsBOlPsUNfXO942fidU2Xa0=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=XwPS2N4fNQQjICCh5gapd6dxn3FZiKAfR9dqWfPXYLlv11WX0DcvRSeTP68+vLXwt0IiNEjgG1jNWCmYRM9duvz4pCLBvf+d10Olto7q1uWdded+q0N/uXjCSWfz8j709Hp71A5pG+IJPj86sZrlYyBEWliKsss+fjXsxffkAZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=NWZ/YLks; arc=fail smtp.client-ip=52.101.101.112
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKDQeu9IlFAlo0LXNhMGclBfY4Jpvky/RMgKFotFK9FWyqhodXPxug+Lm3rfT3W0SMMd3aDPVS24CduSUWQJLe9joS3NBq7SpZAVpUL7Yt1o6aNJ4YAgfHwH+tA+22sdb79yVj4v2rwQhZk2hVXjARS53+3dNmj4J9+ftztrbAdSfSUnyV8HgKd8SMIOI/B5HmYfHczGnnhvW3FICNosje0licJeGpa9i3UhkVIwfUDE8JAZ+IiK4du7xtLi4Sjcez4DT6VLJvjh98gMR/yYupOyWC/0yCZRwVyj/x0StZmEFvVPtxVZ0a+mW3GJ1LTErJFIrHxI6s6RRpBlXXP4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2495W9AUH/xDqzTFv2+wN86aHY/fhXZuyw1/6uJ7Ic=;
 b=rSjXGPPqYqet8CJZlHufoQxZ4HOh0Li/ZHUA3VIvrkmB1vxWjiQjhuNExtIInqz3nPiuXtWyu/hsa2sY1+J6wuk6aImgQl0UUFKlwuFUUejZPBrG9iwbey8a2vBc19b7b0O3Jaf8PsJ+ZDoGPPCLfEQdXPTMUUswQMrb0WrZup70/VOargLrgqutep1o//pRwDIcZFoxloo4S3s9Vdt18PxfONuNL1eWmRlnRc/i4IZC8RJYyk1uIfk4FTXPh6iuRhWxEWd4Rkq32t9v9C1X2ubqqYEgeBapzqLzJ7jC3EXlp2R4S8MY8461xWa37L4ZYOnRuw7OOWUh6NATUmIMpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2495W9AUH/xDqzTFv2+wN86aHY/fhXZuyw1/6uJ7Ic=;
 b=NWZ/YLksCnZHeP+4M8JWrPRWGxuojC3aVv+ukQinFMEW90zPgQP1b6RQjPdgTjxi2CLpebSakZ5TQLIdjGo+XGX3o91Wc3HUxOCQPI0ltDLuaXu1R8VRdqzc5jPFUS1drx3aJ+Shs532vWYVwlvZu5ex58RZ94ymreFyrh0psc0=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOBP265MB8415.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:46d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 14:18:31 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 14:18:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 15:18:29 +0100
Message-Id: <DJSEK3KA2ECQ.1512A4KGOBSCV@garyguo.net>
Subject: Re: [PATCH v19 31/40] dept: assign unique dept_key to each distinct
 wait_for_completion() caller
From: "Gary Guo" <gary@garyguo.net>
To: "Byungchul Park" <byungchul@sk.com>, <linux-kernel@vger.kernel.org>
Cc: <max.byungchul.park@gmail.com>, <kernel_team@skhynix.com>,
 <torvalds@linux-foundation.org>, <damien.lemoal@opensource.wdc.com>,
 <linux-ide@vger.kernel.org>, <adilger.kernel@dilger.ca>,
 <linux-ext4@vger.kernel.org>, <mingo@redhat.com>, <peterz@infradead.org>,
 <will@kernel.org>, <tglx@linutronix.de>, <rostedt@goodmis.org>,
 <joel@joelfernandes.org>, <sashal@kernel.org>, <daniel.vetter@ffwll.ch>,
 <duyuyang@gmail.com>, <johannes.berg@intel.com>, <tj@kernel.org>,
 <tytso@mit.edu>, <willy@infradead.org>, <david@fromorbit.com>,
 <amir73il@gmail.com>, <gregkh@linuxfoundation.org>, <kernel-team@lge.com>,
 <linux-mm@kvack.org>, <akpm@linux-foundation.org>, <mhocko@kernel.org>,
 <minchan@kernel.org>, <hannes@cmpxchg.org>, <vdavydov.dev@gmail.com>,
 <sj@kernel.org>, <jglisse@redhat.com>, <dennis@kernel.org>, <cl@linux.com>,
 <penberg@kernel.org>, <rientjes@google.com>, <vbabka@suse.cz>,
 <ngupta@vflare.org>, <linux-block@vger.kernel.org>, <josef@toxicpanda.com>,
 <linux-fsdevel@vger.kernel.org>, <jack@suse.cz>, <jlayton@kernel.org>,
 <dan.j.williams@intel.com>, <hch@infradead.org>, <djwong@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rodrigosiqueiramelo@gmail.com>,
 <melissa.srw@gmail.com>, <hamohammed.sa@gmail.com>, <harry.yoo@oracle.com>,
 <chris.p.wilson@intel.com>, <gwan-gyeong.mun@intel.com>,
 <boqun.feng@gmail.com>, <longman@redhat.com>, <yunseong.kim@ericsson.com>,
 <ysk@kzalloc.com>, <yeoreum.yun@arm.com>, <netdev@vger.kernel.org>,
 <matthew.brost@intel.com>, <her0gyugyu@gmail.com>, <corbet@lwn.net>,
 <catalin.marinas@arm.com>, <bp@alien8.de>, <x86@kernel.org>,
 <hpa@zytor.com>, <luto@kernel.org>, <sumit.semwal@linaro.org>,
 <gustavo@padovan.org>, <christian.koenig@amd.com>, <andi.shyti@kernel.org>,
 <arnd@arndb.de>, <lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>,
 <rppt@kernel.org>, <surenb@google.com>, <mcgrof@kernel.org>,
 <petr.pavlu@suse.com>, <da.gomez@kernel.org>, <samitolvanen@google.com>,
 <paulmck@kernel.org>, <frederic@kernel.org>, <neeraj.upadhyay@kernel.org>,
 <joelagnelf@nvidia.com>, <josh@joshtriplett.org>, <urezki@gmail.com>,
 <mathieu.desnoyers@efficios.com>, <jiangshanlai@gmail.com>,
 <qiang.zhang@linux.dev>, <juri.lelli@redhat.com>,
 <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
 <bsegall@google.com>, <mgorman@suse.de>, <vschneid@redhat.com>,
 <chuck.lever@oracle.com>, <neil@brown.name>, <okorniev@redhat.com>,
 <Dai.Ngo@oracle.com>, <tom@talpey.com>, <trondmy@kernel.org>,
 <anna@kernel.org>, <kees@kernel.org>, <bigeasy@linutronix.de>,
 <clrkwllms@kernel.org>, <mark.rutland@arm.com>, <ada.coupriediaz@arm.com>,
 <kristina.martsenko@arm.com>, <wangkefeng.wang@huawei.com>,
 <broonie@kernel.org>, <kevin.brodsky@arm.com>, <dwmw@amazon.co.uk>,
 <shakeel.butt@linux.dev>, <ast@kernel.org>, <ziy@nvidia.com>,
 <yuzhao@google.com>, <baolin.wang@linux.alibaba.com>,
 <usamaarif642@gmail.com>, <joel.granados@kernel.org>,
 <richard.weiyang@gmail.com>, <geert+renesas@glider.be>,
 <tim.c.chen@linux.intel.com>, <linux@treblig.org>,
 <alexander.shishkin@linux.intel.com>, <lillian@star-ark.net>,
 <chenhuacai@kernel.org>, <francesco@valla.it>,
 <guoweikang.kernel@gmail.com>, <link@vivo.com>, <jpoimboe@kernel.org>,
 <masahiroy@kernel.org>, <brauner@kernel.org>,
 <thomas.weissschuh@linutronix.de>, <oleg@redhat.com>, <mjguzik@gmail.com>,
 <andrii@kernel.org>, <wangfushuai@baidu.com>, <linux-doc@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-media@vger.kernel.org>,
 <linaro-mm-sig@lists.linaro.org>, <linux-i2c@vger.kernel.org>,
 <linux-arch@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <rcu@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <2407018371@qq.com>, <dakr@kernel.org>,
 <miguel.ojeda.sandonis@gmail.com>, <neilb@ownmail.net>,
 <bagasdotme@gmail.com>, <wsa+renesas@sang-engineering.com>,
 <dave.hansen@intel.com>, <geert@linux-m68k.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-32-byungchul@sk.com>
In-Reply-To: <20260706061928.66713-32-byungchul@sk.com>
X-ClientProxiedBy: LO4P265CA0242.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOBP265MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 4652dfb6-009e-4dec-ee96-08dedc329f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|23010399003|4143699003|22082099003|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	sPJhIVLuBxSy/+rdGbdejuVaMB89bRlTOhB9Ef3MQU7+tAoU3bnI7OuRYkS/QSmvbHfc7P0Ecr5pOYnOKPTBV34f4r80yKnKQoQBHACXB+aFKmuBxFSE8lloULqi2xdsNIGbGW4EKsPN91y60dYur8yO2uDW7tk5tqyGOnSuGRxz/vVuT6jYwYhPk78FSep9jrc1SDcffhmblJ8gF+4a5Z0xh4dNhD4j4J2RRAjcLjO7FLEXJ+WW3ehuorvujUVpwsPNr8G1JTp+KzS3It34LY0R30Fa1zGQ8YKeyYIOMMBGNPsVgyQ1OsVYuRg8YAXs1BMynhzM/pyL43hK4ujNBMcEuCCk7m2Ljn8o5bnClRKZbybYqAlwTBgLq/hLOJVGd8dAR02lu6kwcxJgfO9R43cpplkLtI4Aaj6CuubKIXrqQ3fwYldO17lPBXGCxW2Xsz2h6GWlSEZL5930QoaY09jU5OIIEslYdDvDS5G5QrDE5zfWtRnW8Ltu82fM3SN5IznedGagFNkzOQn5bIWhUaBsfDmialvKwVyAIiW/Z+hdYIYIz/S4AcG4MBKcKq9Kx5C2u+NqUwrtw70dXeY72h/yPPgAXvww0ArBRT9BprSuRXlhG+E4iVORCTnjJfNhQ+4W0FBgKphAwviCsxb+NZAZDaFwu+dWcu/+59fX1w8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(23010399003)(4143699003)(22082099003)(56012099006)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzVwaUtjNmxkZTZtVTBwS3hCSndRdW5abDd3RHUrbnVRNVIzMmUzVU0yOVhO?=
 =?utf-8?B?V2lSODVGbkVEcmsrK3VYd08xZzg0WTh1djE3VnBFbUZ3RkpXVENZQXJzUWlO?=
 =?utf-8?B?U3hGb0ptYUdxYjFNZ3AvaXdmZU5VZU1TR3Z2MGZHQ1ZBeEdzSkdwSENlVGxH?=
 =?utf-8?B?RmV4T2x3VlQxY1RUMEs1dkNidXNybTlPVVlVenl0M0lLVEtKZklSZ0FQZGxD?=
 =?utf-8?B?d3dnRmVYN1d6bXlsUGpyQ0gxUThuUjlsZVA5VEt4aThXWXYwUW5vOUNhNE5I?=
 =?utf-8?B?a204L0l2citOSnJUNzBrY2xhbVF4VFhjWlYyZWJDVkZPT0pOeW9WRjI3dC9t?=
 =?utf-8?B?ZW9IelZEUmtXblVYdmM3SXRjZmV2eXdtRkZaa2czRndGVkVlUU9IWmwzckFC?=
 =?utf-8?B?S1MrM1RaV1VEc1IrRjBzeVdiM2VnaHRPN2ExZlNIKzBKTDVaallQVlRUK3p6?=
 =?utf-8?B?NkRpdm5xYU1YTmwxRkZIejduaU1SV1VlMUQ4UzJMSll4Z0Y0NW1XWHZtYTdm?=
 =?utf-8?B?dTRGQnp4dXU3emI0dDVlc2dNc1lnOXh5dHZQMnJUQUxhT1VPeEIvaVBFV1U3?=
 =?utf-8?B?VzRXRWlyYUlTUGVxRWNwcXY2aitoRlY5blI0SUgvbHNuVCtJMU9uWGIxQUxE?=
 =?utf-8?B?OUk1cWRtTUUzQlBFMnBKQzEyeFdCN1EzejJKREdRMjNrVXdGaDBKazdBUHpy?=
 =?utf-8?B?ZGFpQWRvSk80ZTF0RFRwZFlVd3RoczlQWjg5R2d4RXg0L0s0eXBuaVBxK3dN?=
 =?utf-8?B?NWZLV2RURUFmZVN0UldCUm52NmQwT0hTRUNrK0sreDNCZ0pORnArTk9BdnRR?=
 =?utf-8?B?cUp6bE9NRVdib2x3Z2JOem12OHVZelhLK2lJYy9NdHZMcFFaT21USkFTQjhC?=
 =?utf-8?B?L1FuemloSlkrM3pVY3NwMVkwbmxLVFh1RDdFbmEvd0JQUlVmeEdTSGdTWFhM?=
 =?utf-8?B?RUFBelIyM1gyNEROaDBsRWk1dzFkNjJkd0V2bXQxRC9PeGpaeFJlc3FQbkJN?=
 =?utf-8?B?bVd3aVVOemYwRXZ2L21wckYvS3Ywelloa0s1N01wRlZzVHJMZGJVK0lxU1NO?=
 =?utf-8?B?eDRHRDJJcThFU3dlQy9GYWZ4akl3dmh2Q2gxbVJ0ZGZZSzBSdmhvck1takM2?=
 =?utf-8?B?dVVqK21LY2pHU2hjQUFuRFdxQ1Y1eERUQzRrb0R6WUM2bnZUMjRzV1dsVWp1?=
 =?utf-8?B?MXF1M1MrVU5oWTlZRkc3N0pBWWlrTWdlVGhJaFFsUm9ZNTRaOWlPQ1htUFpp?=
 =?utf-8?B?RlN1VnFuL3RWQ2Q2d1M0MStJTStTRDI5akJXcVhIbFVrYURaV2FJS0x4Vlg5?=
 =?utf-8?B?RWhRWW5JbGtibDhvQU1TbkRxSWltNklISXhZQzVoZ2kzTlFHK3FpdVQ3TWZQ?=
 =?utf-8?B?VThyZ2tHWmU3T05jM1F1Z25wNVJmN3JXZ0cxWXRoVUllN3hvMFo0QlhMUW9S?=
 =?utf-8?B?Mml4d3dKQU4rOXNGdXUzZ2c5NWVja2RlZ1dHUFVHY3JiSDV1U2xwMjcyZ2RK?=
 =?utf-8?B?bWRHT1lGdnJsbHdxeEFxaFlxZmJEZnkzdXBkdkd4TkFBa25nbTJ4QWpEbFhq?=
 =?utf-8?B?S3IyWkVGWHB2TWtyOENTK1UrdlExbnEyeWxlazVLNkFVWUFPejMrTTVZdXZp?=
 =?utf-8?B?Sk9abGRXVGV1S1V1R25WTmxZUzJzNGw4ODV0WFZ5cnBTSWFCTldLcm1HYkZU?=
 =?utf-8?B?TWsvNG9lTUZDUXM1QXFMdkVreS81ODhDRDNBYW5RbFVRcVpCK0ZQWk1LTzRy?=
 =?utf-8?B?Y0JPRHNzSWF5WEJiU01WOWFacFdqbFUzaldiQlhTYzVPTlVxZm9lUUF0L0V0?=
 =?utf-8?B?ZTQ1dmhyVFlLcDVWcUkwdnVyZnlFR2E0alB4c0dOYVZia2hnTmlPclQ4QmZv?=
 =?utf-8?B?dytZN045ZVJoMFczRDdNSGEyN0VrYjhaR2VZT0thdEtROTU1N2h5MTBnTVc1?=
 =?utf-8?B?b0ZYdFNET3U1cGRGdWpnbzdSQ3JTZ3hzZFpYdmoyZHZNR1FjM0pEUTN4NzZr?=
 =?utf-8?B?U2V4M1VIdjEwSXAzTEtOYXJFUHVTQkRCTTZCeStTYkdRQUlUMDVVekZhdXJj?=
 =?utf-8?B?Ry9kZFpXQzRtZkF0clplSXlNcnZDUFpGSTZ5bGF0YXozUm5mUW1KcHpRbmUv?=
 =?utf-8?B?K0lsWU1Id3pPM1o5S2xWUmcwMGU0b2VDcitZOUp2dUlaOXE3ZE4yK2pyR2o1?=
 =?utf-8?B?WVI3Wmg0TjhCZmJ3TW1Yc05WQ0dZRTdkTDFiQXV0UnNrL25DRXF2QTFsaFlX?=
 =?utf-8?B?L0hpUDAyMURTL0lWaWMxQjcxNnlwcjZoOTgyc0JMVnNxcU1uYi80V3I3Myta?=
 =?utf-8?B?Nm8rMUllZmprMmdsVEkzTUc4Wm84aXU2TC9RZDRSV2pUQXdOR3MyZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4652dfb6-009e-4dec-ee96-08dedc329f75
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 14:18:31.6428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLW0jF1+QNZkZCfKBjmPqfGZ3gYXiwuG7Bva2L0FDgPAnCm3tZwSNsGceq1tyP4GEVmd0iYuw3AMhJhfXuj6wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB8415
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-23136-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,skhynix.com,linux-foundation.org,opensource.wdc.com,vger.kernel.org,dilger.ca,redhat.com,infradead.org,kernel.org,linutronix.de,goodmis.org,joelfernandes.org,ffwll.ch,intel.com,mit.edu,fromorbit.com,linuxfoundation.org,lge.com,kvack.org,cmpxchg.org,linux.com,google.com,suse.cz,vflare.org,toxicpanda.com,lists.freedesktop.org,oracle.com,ericsson.com,kzalloc.com,arm.com,lwn.net,alien8.de,zytor.com,linaro.org,padovan.org,amd.com,arndb.de,suse.com,nvidia.com,joshtriplett.org,efficios.com,linux.dev,suse.de,brown.name,talpey.com,huawei.com,amazon.co.uk,linux.alibaba.com,glider.be,linux.intel.com,treblig.org,star-ark.net,valla.it,vivo.com,baidu.com,lists.infradead.org,lists.linaro.org,lists.linux.dev,qq.com,ownmail.net,sang-engineering.com,linux-m68k.org,garyguo.net,protonmail.com,umich.edu];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:byungchul@sk.com,m:linux-kernel@vger.kernel.org,m:max.byungchul.park@gmail.com,m:kernel_team@skhynix.com,m:torvalds@linux-foundation.org,m:damien.lemoal@opensource.wdc.com,m:linux-ide@vger.kernel.org,m:adilger.kernel@dilger.ca,m:linux-ext4@vger.kernel.org,m:mingo@redhat.com,m:peterz@infradead.org,m:will@kernel.org,m:tglx@linutronix.de,m:rostedt@goodmis.org,m:joel@joelfernandes.org,m:sashal@kernel.org,m:daniel.vetter@ffwll.ch,m:duyuyang@gmail.com,m:johannes.berg@intel.com,m:tj@kernel.org,m:tytso@mit.edu,m:willy@infradead.org,m:david@fromorbit.com,m:amir73il@gmail.com,m:gregkh@linuxfoundation.org,m:kernel-team@lge.com,m:linux-mm@kvack.org,m:akpm@linux-foundation.org,m:mhocko@kernel.org,m:minchan@kernel.org,m:hannes@cmpxchg.org,m:vdavydov.dev@gmail.com,m:sj@kernel.org,m:jglisse@redhat.com,m:dennis@kernel.org,m:cl@linux.com,m:penberg@kernel.org,m:rientjes@google.com,m:vbabka@suse.cz,m:ngupta@vflare.org,m:linux-block@vger.kernel.org,m:josef@toxicpanda.com,m:linu
 x-fsdevel@vger.kernel.org,m:jack@suse.cz,m:jlayton@kernel.org,m:dan.j.williams@intel.com,m:hch@infradead.org,m:djwong@kernel.org,m:dri-devel@lists.freedesktop.org,m:rodrigosiqueiramelo@gmail.com,m:melissa.srw@gmail.com,m:hamohammed.sa@gmail.com,m:harry.yoo@oracle.com,m:chris.p.wilson@intel.com,m:gwan-gyeong.mun@intel.com,m:boqun.feng@gmail.com,m:longman@redhat.com,m:yunseong.kim@ericsson.com,m:ysk@kzalloc.com,m:yeoreum.yun@arm.com,m:netdev@vger.kernel.org,m:matthew.brost@intel.com,m:her0gyugyu@gmail.com,m:corbet@lwn.net,m:catalin.marinas@arm.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:luto@kernel.org,m:sumit.semwal@linaro.org,m:gustavo@padovan.org,m:christian.koenig@amd.com,m:andi.shyti@kernel.org,m:arnd@arndb.de,m:lorenzo.stoakes@oracle.com,m:Liam.Howlett@oracle.com,m:rppt@kernel.org,m:surenb@google.com,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagn
 elf@nvidia.com,m:josh@joshtriplett.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:chuck.lever@oracle.com,m:neil@brown.name,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	RCPT_COUNT_GT_50(0.00)[166];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,garyguo.net:from_mime,garyguo.net:dkim,garyguo.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE50771C9C1

On Mon Jul 6, 2026 at 7:19 AM BST, Byungchul Park wrote:
> wait_for_completion() can be used at various points in the code and it's
> very hard to distinguish wait_for_completion()s between different usages.
> Using a single dept_key for all the wait_for_completion()s could trigger
> false positive reports.
>
> Assign unique dept_key to each distinct wait_for_completion() caller to
> avoid false positive reports.
>
> While at it, add a rust helper for wait_for_completion() to avoid build
> errors.

This will cause Rust code to share the same dept_key, so it will have all t=
he
false positives that the change is trying to avoid.

In general it is easy to create Rust bindings for static inline C functions
because it'll be just some computation, while creating bindings for C
function-like macros that define additional statics can be challenging.

Is dept_key similar to lock_class_key, where only the address matters? If s=
o,
the approach that I use in
https://lore.kernel.org/rust-for-linux/DJP0CDOR98N5.29BK8PUFRWRUK@garyguo.n=
et
could be used for dept_key as well, then we can keep Rust `wait_for_complet=
ion`
still a function; otherwise we have to turn it into a macro too on the Rust=
 side
to create such statics, which isn't ideal.

Best,
Gary

>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/linux/completion.h | 100 +++++++++++++++++++++++++++++++------
>  kernel/sched/completion.c  |  60 +++++++++++-----------
>  rust/helpers/completion.c  |   5 ++
>  3 files changed, 120 insertions(+), 45 deletions(-)

