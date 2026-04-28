Return-Path: <linux-nfs+bounces-21257-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPU5A5Ti8GmoagEAu9opvQ
	(envelope-from <linux-nfs+bounces-21257-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 18:38:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCAB4891EF
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 18:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7CF0314B112
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 16:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F343264CB;
	Tue, 28 Apr 2026 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="HC5SaI20"
X-Original-To: linux-nfs@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013018.outbound.protection.outlook.com [40.107.162.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1151ADC7E;
	Tue, 28 Apr 2026 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393630; cv=fail; b=STbb0WdeLWi7kLZwCF400lRVSfdg45s8YbIg6DQaMu48s9fxHiTTfHf+y2mjBVoOXrjkDQeJw+Xe/ln1eZzn4Vt7ei/whVz4VY+JCF8K22zlxXK73zdTtrWO77rfSzqQR6a2vfz72O6ZUjcDC9/0VPGAT6hPbeqlFIuYOrocfKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393630; c=relaxed/simple;
	bh=czkuRTCbXbBTjUssA7PNwnP3nQDZCmLwMQETFvf6abQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WEEbAAFl8cQ2O9wpNHkpw1nun6oFceG6LHXmRlaLSlcbAGkteiFZl91PMTuk0l0/BM5juOmYsTfeab5uCCv8y6OjrqdXj2OW2ilQ1neLx8BOfmc02gN0Duk6fvpsSqaM99qoSCbvtXinJznMA0xl22BroYV6pLo3q4yQ5HrO5T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=HC5SaI20; arc=fail smtp.client-ip=40.107.162.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxYMXwWTW4zb1QsFuyoQrTHJnsUhHxVP7BD4tjOnv4tB64w9Kg2A5EdQhQ2D91tbAYfR1GdsTTUGIUg8eoeEx5/SzNygCwJEAA3hyiYIcTQtz93YuBHYj5BBjD4LrI69o9vNnSqkM0TWzLYVsUSFGMOauvRxzc/fS4IzhIEx7gW7c+kfVV2PMQuHc6H/Dtl1fknoERVGjhB5YN0U+ms39XAUGejZtWlcr+QbR1ZhptX5TtKGc3h8Uw1W33bQs/X92mfaJIpWv7crTRVk71EhVxsLx3WwHsghob8UviMKnwJgGRVYDwufdNpivS/o2Fh/OmE/OWZvhvHIoNxTx5H2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ww3rMVFVCESbkNYlfhduIl3KcVpeXojhIB9Dy7bdGg=;
 b=eN0mvJGkfT+d4yp3ze5S10aVDX1QhKF83hT7YsWcNmte3XuImRH0XEkCJ1Gb4cPxHG8k2AiREVXBWC3KeXR1Cbwhs8NI9wOdVXgVT4+/Xkh/nJKoerUvsMnvBshJxmJL/c7d4LPKYm8hzmLHIKEnKjJwc/6Y6TqbvOddzq27hi+9zoh+T6mfMctSvKgK44rXQE8MHrdoWRrBmKH13CosxiIfCaEHSSeusQsBiVdrZoc50j0ZwPbeEBXsoFDcJrzi26lKSESoF8kVDJt8tGmfqk/mY4EQSILZqButGkN+ar2SsK7+3qodOJaQnf9cigBQ3l6xs4OSUo/G4RrLzfDtCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ww3rMVFVCESbkNYlfhduIl3KcVpeXojhIB9Dy7bdGg=;
 b=HC5SaI201ITeqNkG6K00qF3Q2S52XtVIN4kKsLWLu1mnMGNf/O+Xhi8AHsNBuJyCEgf6yj6PPCq5uuAgZ+7b2YX75S6BuTbesQDcWx4rALEybQeBjFIDu+GpW6JVtTe+HHCCRI5L1XjJarihsRcbW69BwTmZuPPG0mqKmgxqVpg43eEGWkOdGzzdEacvcVQlToRi3WQlMdAfpK2LO9Du7DWicmvwVjMoGnN9FqDrB2odBy9gS8M1dPrbXDFApXMATesWjKHfrbmXE1bYiaDD6/F9wnMfomuMWCwRxQGXgHMzuF43LIIe2SaQcQlA6xcCJ1S7zBwnymjMSSZF94TuhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:39b::19)
 by DU7PPF6FE197BF0.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::ad5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 16:27:03 +0000
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4]) by AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4%7]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 16:27:03 +0000
From: Yunseong Kim <yunseong.kim@est.tech>
To: bagasdotme@gmail.com
Cc: 2407018371@qq.com,
	Dai.Ngo@oracle.com,
	Liam.Howlett@oracle.com,
	a.hindborg@kernel.org,
	ada.coupriediaz@arm.com,
	adilger.kernel@dilger.ca,
	akpm@linux-foundation.org,
	alex.gaynor@gmail.com,
	alexander.shishkin@linux.intel.com,
	aliceryhl@google.com,
	amir73il@gmail.com,
	andi.shyti@kernel.org,
	andrii@kernel.org,
	anna@kernel.org,
	arnd@arndb.de,
	ast@kernel.org,
	baolin.wang@linux.alibaba.com,
	bigeasy@linutronix.de,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	bp@alien8.de,
	brauner@kernel.org,
	broonie@kernel.org,
	bsegall@google.com,
	byungchul@sk.com,
	catalin.marinas@arm.com,
	chenhuacai@kernel.org,
	chris.p.wilson@intel.com,
	christian.koenig@amd.com,
	chuck.lever@oracle.com,
	cl@linux.com,
	clrkwllms@kernel.org,
	corbet@lwn.net,
	da.gomez@kernel.org,
	dakr@kernel.org,
	damien.lemoal@opensource.wdc.com,
	dan.j.williams@intel.com,
	daniel.vetter@ffwll.ch,
	dave.hansen@intel.com,
	david@fromorbit.com,
	dennis@kernel.org,
	dietmar.eggemann@arm.com,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	duyuyang@gmail.com,
	dwmw@amazon.co.uk,
	francesco@valla.it,
	frederic@kernel.org,
	gary@garyguo.net,
	geert+renesas@glider.be,
	geert@linux-m68k.org,
	gregkh@linuxfoundation.org,
	guoweikang.kernel@gmail.com,
	gustavo@padovan.org,
	gwan-gyeong.mun@intel.com,
	hamohammed.sa@gmail.com,
	hannes@cmpxchg.org,
	harry.yoo@oracle.com,
	hch@infradead.org,
	her0gyugyu@gmail.com,
	hpa@zytor.com,
	jack@suse.cz,
	jglisse@redhat.com,
	jiangshanlai@gmail.com,
	jlayton@kernel.org,
	joel.granados@kernel.org,
	joel@joelfernandes.org,
	joelagnelf@nvidia.com,
	johannes.berg@intel.com,
	josef@toxicpanda.com,
	josh@joshtriplett.org,
	jpoimboe@kernel.org,
	juri.lelli@redhat.com,
	kees@kernel.org,
	kernel-team@lge.com,
	kernel_team@skhynix.com,
	kevin.brodsky@arm.com,
	kristina.martsenko@arm.com,
	lillian@star-ark.net,
	linaro-mm-sig@lists.linaro.org,
	link@vivo.com,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux@treblig.org,
	longman@redhat.com,
	lorenzo.stoakes@oracle.com,
	lossin@kernel.org,
	luto@kernel.org,
	mark.rutland@arm.com,
	masahiroy@kernel.org,
	mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com,
	max.byungchul.park@gmail.com,
	mcgrof@kernel.org,
	melissa.srw@gmail.com,
	mgorman@suse.de,
	mhocko@kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	minchan@kernel.org,
	mingo@redhat.com,
	mjguzik@gmail.com,
	neeraj.upadhyay@kernel.org,
	neil@brown.name,
	neilb@ownmail.net,
	netdev@vger.kernel.org,
	ngupta@vflare.org,
	ojeda@kernel.org,
	okorniev@redhat.com,
	oleg@redhat.com,
	paulmck@kernel.org,
	penberg@kernel.org,
	peterz@infradead.org,
	petr.pavlu@suse.com,
	qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	richard.weiyang@gmail.com,
	rientjes@google.com,
	rodrigosiqueiramelo@gmail.com,
	rostedt@goodmis.org,
	rppt@kernel.org,
	rust-for-linux@vger.kernel.org,
	samitolvanen@google.com,
	sashal@kernel.org,
	shakeel.butt@linux.dev,
	sj@kernel.org,
	sumit.semwal@linaro.org,
	surenb@google.com,
	tglx@linutronix.de,
	thomas.weissschuh@linutronix.de,
	tim.c.chen@linux.intel.com,
	tj@kernel.org,
	tmgross@umich.edu,
	tom@talpey.com,
	torvalds@linux-foundation.org,
	trondmy@kernel.org,
	tytso@mit.edu,
	urezki@gmail.com,
	usamaarif642@gmail.com,
	vbabka@suse.cz,
	vdavydov.dev@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	wangfushuai@baidu.com,
	wangkefeng.wang@huawei.com,
	will@kernel.org,
	willy@infradead.org,
	wsa+renesas@sang-engineering.com,
	x86@kernel.org,
	yeoreum.yun@arm.com,
	ysk@kzalloc.com,
	yunseong.kim@ericsson.com,
	yuzhao@google.com,
	ziy@nvidia.com,
	Yunseong Kim <yunseong.kim@est.tech>
Subject: [PATCH] dept: update documentation function names to match implementation
Date: Tue, 28 Apr 2026 18:26:15 +0200
Message-ID: <20260428162614.786365-2-yunseong.kim@est.tech>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aTN38kJjBftxnjm9@archie.me>
References: <aTN38kJjBftxnjm9@archie.me>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU2PR04CA0057.eurprd04.prod.outlook.com
 (2603:10a6:10:234::32) To AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:39b::19)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P189MB1752:EE_|DU7PPF6FE197BF0:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ef4166-f10b-4680-89f8-08dea542fb08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZrBrcEqsBxWaUtIkXBuaZbiJkK9T5hpQaWEJenFKgDIBh6LrXwWxkyLRJH1vf4sr5zaPWTzey3hnne3VTwhRcxxajiKakAhXivYPo2g4XlUdNm7fGZXcF78ZP34FvcYEqv9CYMVn6pIhJ+gXPPL69jFIxnu8Tld32UK8Gxd71d8EcxG1rBvCLk/45b55qUy4OJygtEZ/t477YXSPOTsvzdQ8z/ANM8X01HY9GGWvjzYMWHLdKv+a34GtB6DE67wWNazWVD2pv0OLmgXR60cqQId/p7xGpeNMcWhL3BYwrLVrgJ+V+f/35BwSUeN6Q6z7NZgIWuBFU79mhlK13giRF2ot65ymf4NtY6IRHobog38B6tXLRPtuJoY520bmhHuPbwV84dxn5Hts0Ho3xepGc650awz9Oe+vK//oKqYgcKSsrbSb8okgfww9Qk4Jo3V2cgq2OiaG8pbFTvkWqzJTsYO71pq3FQqLRmFKH8/0ShJqW1UZJYVw0pqslhPHCuKwUx+UmU0Mk7tCrKh6h7wIvV1GjMiTlt1d/3SE6p97PaxuaEgI9apsXW8h85aaCGcyXi6E1tHAiAZaRZt44JB9QmNJBB4WEaZcf5p0ig0+7iz+o/o2soO4COJM9yAQTk+F2rGoqMlyt2G4iFSaGNGAfkPDcWqrZFyh8V/ld2hO9WAZd0T2C0etisEzEiiSFYtx368RxXq08NgemHMnrEpRZcTZ3zWe0GjGaDHUkt8wo8Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P189MB1752.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?91lmgw6PEF3mTxhj5DqxcL15nmLUTHzQFIuHDYIUWoBFqaq+zm8el+evrjdn?=
 =?us-ascii?Q?28UDQtpT9yMQl/4XvNpKrehMmjAJv9Sv06+FzCWMe3UH/3RLjmX72RZB0vhT?=
 =?us-ascii?Q?uk4lmif8aByQ3rDvrf9NInOdoEqEHnYtAyhwkYwyI1Nx+1TJrPqhDnxuVRpk?=
 =?us-ascii?Q?ZSeu1m2jm0XUDXHoSe+YitRU9kLjswco1ZtUcQwKLR3RCq5AXJy6IL90BVkK?=
 =?us-ascii?Q?bvRrGITo8It7tx06lZpCQanDaFJ15Px/eQ/7MS7lh98Vs1F5fif17yAr/6eO?=
 =?us-ascii?Q?mxKZjPZVl2Hy6xLJCNxxKJ914rtvTUARnDXbnOBcUyfXwdT4lWw9pNuQlH2B?=
 =?us-ascii?Q?Co6c5czkVD2bG6l1OVDFTHjzroTXMRCoOPDjTvSIJkTpL6QKgC8JEB96BQwG?=
 =?us-ascii?Q?a4FfmfSsicuXtzk11YYEKedZnuxf8vRNhXBUPY2tttFDv8/07HGLxXI4RQMk?=
 =?us-ascii?Q?7DwXCtza1Rx07hRCucCpJrN5UPwnNoCRUrrM51ilSH/h5QNQ40nXo5R98Ndj?=
 =?us-ascii?Q?0C2p8wQr0crqrXiZ1O4ycyAJ5d2ztkOseAHyB2+UMUr/mhL2GEem1Jh79U7v?=
 =?us-ascii?Q?4wxUz+3HBJspZBgccLAg2b+hkv54Q6hiXrfGcfr/PgdxHxKsKLY9dUULN2mN?=
 =?us-ascii?Q?9Wrx7oSuyqrA17QZ8JlJ9qZC6BnK+mJZDv+uvE4+Z/Fy/w3NFfvA6mUIDRmb?=
 =?us-ascii?Q?xreACR6m0rirPMF03dVrreoM+EWueapkk7x2GNLywR5mqikiRaCA7v+xNPmW?=
 =?us-ascii?Q?lEeDpHNh3IQaP3en7zooZnBg0JRQfvSo7WteU32/b9v7fDqiID2Dk2Qbvmcb?=
 =?us-ascii?Q?qgpwU8QBW0lsiyDdB5RQjETR0tfOxSSKBHQhaikCScpcTfmT7AassI9mo8df?=
 =?us-ascii?Q?6r7z4Cy00m3cD3KfzL54WaRsD/jLUr5IwRgE5bPCfBXWQ+DSWSLwFb1If6Q4?=
 =?us-ascii?Q?+XW8twg73C4YKlaE59jX6i60Kc0ECEknZwJefqO8n1xryCKMF+jguOgm3a/p?=
 =?us-ascii?Q?HCzF7Has/7RJW2j06k4oiZhcknZ51J9YGm44jBtvV58AXifV27DtookFdCSw?=
 =?us-ascii?Q?b7AI7xBNgosz47FWC8tHwMPw2zUdTJchuIG6I8XC3WQswZh73akCdp1RY9CL?=
 =?us-ascii?Q?EyxfXpSSWBMTwwkRI1OjYVsxzK14cZ69mWQ7tDZCsu/UTF2dDWyXjwqMqIRY?=
 =?us-ascii?Q?AZAY4BSPVq+Jf/DqjUU6V2u4AYVkwo6HteAXHdgIL+OdXvmCCW/sqlHV93nC?=
 =?us-ascii?Q?Lft+jRNp8ER49Q1ol0SuwJZBrndRZ0mDcqvJYzkhIe/BIVMk+XevvBmuKXbM?=
 =?us-ascii?Q?rjh7SjXVQ4LzcyjloG7PWe9ChgjpZKWY7E2SrQ3iLAhQJE26f3EV/RRJpwD1?=
 =?us-ascii?Q?zje3l86FJW4KOKGNQ7lRjeQX/W9BV6da016hiAyvi/wBTQR7JORi8MeiMxIX?=
 =?us-ascii?Q?KgF+v11h/9wcFra4DuO0IUGJlO9BbTTAcHM+I5Rngoc6pSiljdD1CZc3Fy3j?=
 =?us-ascii?Q?K+2dJGvfIannhR/K1qnUOVwuqSX7oi8Gzt1KJFBjSQqGzt5c0mdcv0C7jLqX?=
 =?us-ascii?Q?xtm5znIZ13MienE9ICAHRhO87N1G2tvs22yrzi8rEXjgo8EEBu8Hl3HS4hbh?=
 =?us-ascii?Q?SVhWyWfgQfd8jaHowzNwmhBhzAZB2c0CfbxxY+qYh/fDLryznsybdO7P3fSy?=
 =?us-ascii?Q?m6hyBEaNJXry1TVAjUZmvRaBunN96OEkbL9EJelsHAOHz0ZuLGc+lH89G5y+?=
 =?us-ascii?Q?+okl/obTCA=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ef4166-f10b-4680-89f8-08dea542fb08
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:27:03.2904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kt3ldRAB6jTICdoR8HAa2yj+Tdv/0cT0k0yKTjliKpO5aSo52R1DNrgIjXb36qyHw7G7gL8UZwLChVuUFUNobw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PPF6FE197BF0
X-Rspamd-Queue-Id: 5CCAB4891EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-21257-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[qq.com,oracle.com,kernel.org,arm.com,dilger.ca,linux-foundation.org,gmail.com,linux.intel.com,google.com,arndb.de,linux.alibaba.com,linutronix.de,protonmail.com,alien8.de,sk.com,intel.com,amd.com,linux.com,lwn.net,opensource.wdc.com,ffwll.ch,fromorbit.com,lists.freedesktop.org,amazon.co.uk,valla.it,garyguo.net,glider.be,linux-m68k.org,linuxfoundation.org,padovan.org,cmpxchg.org,infradead.org,zytor.com,suse.cz,redhat.com,joelfernandes.org,nvidia.com,toxicpanda.com,joshtriplett.org,lge.com,skhynix.com,star-ark.net,lists.linaro.org,vivo.com,vger.kernel.org,lists.infradead.org,kvack.org,lists.linux.dev,treblig.org,efficios.com,suse.de,brown.name,ownmail.net,vflare.org,suse.com,linux.dev,goodmis.org,linaro.org,umich.edu,talpey.com,mit.edu,baidu.com,huawei.com,sang-engineering.com,kzalloc.com,ericsson.com,est.tech];
	DMARC_NA(0.00)[est.tech];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yunseong.kim@est.tech,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_GT_50(0.00)[167];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[est.tech:email,est.tech:dkim,est.tech:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Synchronize function names in the documentation with the actual
implementation to fix naming inconsistencies.

Signed-off-by: Yunseong Kim <yunseong.kim@est.tech>
---
 Documentation/dev-tools/dept.rst     | 2 +-
 Documentation/dev-tools/dept_api.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/dept.rst b/Documentation/dev-tools/dept.rst
index 333166464543..31b2fe629fab 100644
--- a/Documentation/dev-tools/dept.rst
+++ b/Documentation/dev-tools/dept.rst
@@ -97,7 +97,7 @@ No.  What about the following?
 
 			   mutex_lock A
    mutex_lock A <- DEADLOCK
-			   wait_for_complete B <- DEADLOCK
+			   wait_for_completion B <- DEADLOCK
    complete B
 			   mutex_unlock A
    mutex_unlock A
diff --git a/Documentation/dev-tools/dept_api.rst b/Documentation/dev-tools/dept_api.rst
index 409116a62849..74e7b1424ad5 100644
--- a/Documentation/dev-tools/dept_api.rst
+++ b/Documentation/dev-tools/dept_api.rst
@@ -113,7 +113,7 @@ Do not use these APIs directly.  The raw APIs of dept are:
    dept_stage_wait(map, key, ip, wait_func, time);
    dept_request_event_wait_commit();
    dept_clean_stage();
-   dept_stage_event(task, ip);
+   dept_ttwu_stage_wait(task, ip);
    dept_ecxt_enter(map, evt_flags, ip, ecxt_func, evt_func, sub_local);
    dept_ecxt_holding(map, evt_flags);
    dept_request_event(map, ext_wgen);
-- 
2.53.0


