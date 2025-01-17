Return-Path: <linux-nfs+bounces-9330-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3849A14872
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 04:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 058CF7A2969
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 03:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C419A1F63DD;
	Fri, 17 Jan 2025 03:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Y6AOzW2e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2119.outbound.protection.outlook.com [40.107.223.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51741F63F7;
	Fri, 17 Jan 2025 03:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737083721; cv=fail; b=IUR97F3BBEXbRqS8kDuyzPTRT7RDHCPaHiQpO+V7nhUlgQcg4LUWBQTRjkJ5aXqH/TzDBGk6dwh0XyYCi9AiC+rBhhmPH6Vlz2SBYj8nyO9UjhUrocKkiJPdnUttvlRr/0uhYP7IK+t2AkGHNCn6EmV7gkA4VcsGfbOO09n31NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737083721; c=relaxed/simple;
	bh=aujnAXz6E3ed3MI0wyYd2Z4RxFBLWS3NeEfOet8JwN0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZxPu9lQ7GDzAgQKXCSsO9aOP+TqewzWwmDSa5cXFlMGxuqR5UCVzxfoT0CZ5WdngubGw+/wfmQdOaLuLnvS/BQGFTpHxIxLarx9mET+jn1kp709W+vIemJqrkqwZOkqPhpNYF5X6L/5WqCLlAiTSoUGeLesSaBIiQolWsvhTGKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Y6AOzW2e; arc=fail smtp.client-ip=40.107.223.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwYM6yTd8r6lmNB6ULOWqEOzfCpeVgsArccloRqxFcp2fWOec9JOUUOADBtfuxJT84h0YOokRtkfT/Sn5oI2P6gGktBp4YatzkWXeydaMKSl9xpkmfUJCTqW0LyVbFeRHyfOHQhkRVaupW/NhZDA3oMB9qEhCsm1iQo/Ae9mGkb0FB21MnY2ZdIU8xQNpV5yDUF1JlYR87ea1RgpqNCLzV9pWcJVkvk6Df2VA5+Usv8bLvKD73HZ1WYOSSumMt9bxMk1CZ7NF5v19x2A9DxohlPlK0G/0TI9fHRAYYZiPuYZCNPwVSJoIlB2eUZeuSIIDqEKnnLYpG5uNyX1CmAzrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aujnAXz6E3ed3MI0wyYd2Z4RxFBLWS3NeEfOet8JwN0=;
 b=L1Xh+qjhUvydDJ50/mzp4ngBhxrjY5RU5k4xuQousrgAXhO4ZzqVQ8pOF1PTZ+/FR9S3nIlJhfCQPjJ17UpMoaRMtQg7A4GS1l3dpnZcv0GAq2z9pI4qDlPjaCwg79BJscVyUibYm0U7XsRU3QCifgOwuzBdd80VqXfRvw6PnZ41RhQJeLIGq1eKnT7b73bVEaG0vghDjFFFYohq/vUhcuinZfBfjNkRYRTUNUEEXmnzAiSBe0MAN2ZPpP4RYDeM5LpcU6mn+Fw16Rb6tA6Ctx+CwqiO/RzbkjtMTAfxMFqHIVXn0+OOK80Qlcc/IqXJMExQYUcRipDWoL6fvzEPfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aujnAXz6E3ed3MI0wyYd2Z4RxFBLWS3NeEfOet8JwN0=;
 b=Y6AOzW2e31yXeSsmJthLTUcuipEpY6zSt6TJyCAHP4Cq+VR7TTi3BcgY6/DM3zWEP9TxoagPspIsDDrbDDueZyJmciDA//8W7/1sR/83FcidtBfg/oP8iOnUkZztrOSN3hSrGKRtYUrribPYbdYVwerplOnKkc/CiHwQu8Bc28Y=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW3PR13MB4091.namprd13.prod.outlook.com (2603:10b6:303:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.15; Fri, 17 Jan
 2025 03:15:16 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 03:15:16 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "tom@talpey.com" <tom@talpey.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "lilingfeng3@huawei.com"
	<lilingfeng3@huawei.com>, "okorniev@redhat.com" <okorniev@redhat.com>,
	"anna@kernel.org" <anna@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "Dai.Ngo@oracle.com"
	<Dai.Ngo@oracle.com>, "yangerkun@huawei.com" <yangerkun@huawei.com>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "neilb@suse.de" <neilb@suse.de>
CC: "houtao1@huawei.com" <houtao1@huawei.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lilingfeng@huaweicloud.com" <lilingfeng@huaweicloud.com>,
	"yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Set tk_rpc_status when RPC_TASK_SIGNALLED is
 detected
Thread-Topic: [PATCH] SUNRPC: Set tk_rpc_status when RPC_TASK_SIGNALLED is
 detected
Thread-Index: AQHbZpCbUIUTseuRhkGlry2Cvg0UVLMZSn4AgACZhICAAF4jgIAADMeA
Date: Fri, 17 Jan 2025 03:15:16 +0000
Message-ID: <4d3e8d4385a511860ec9018b3ca864e7ef3a7b48.camel@hammerspace.com>
References: <20250114144101.2511043-1-lilingfeng3@huawei.com>
	 <fed3cd85-0a15-ae30-b167-84881d6a5efd@huawei.com>
	 <642413c4bdbe296db722f0091ffa5190c992eb8e.camel@hammerspace.com>
	 <58bf9d83-b58d-e5a6-4096-64eb96f3854a@huawei.com>
In-Reply-To: <58bf9d83-b58d-e5a6-4096-64eb96f3854a@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MW3PR13MB4091:EE_
x-ms-office365-filtering-correlation-id: 2240b721-9c60-458f-54c1-08dd36a52a42
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aFQzYi9sN2orSG1wWmFzSWVQWnlXNEgxY1dTRXVKR3Ivb0UrM2o3RSs4a0M2?=
 =?utf-8?B?aWpaUEdkbHJvSzBKNGhqdHowMyt4VkxwdjliRDd1c1pTeVhzRVMraFdLNGJx?=
 =?utf-8?B?TEx4ekhLNXpaQWFyZXRJNHhGc2xmeTc3ZG1sVEQ2UGI0WGtWNWJMRHlGSERQ?=
 =?utf-8?B?SjlmYTFWS3hMRFhMYnkvUmVndG9rd1E1SEQ5dnFQSWZnMjFSbEN5M3FxbjhK?=
 =?utf-8?B?RzFiK0txY3d4MFlyT3Y1cFkzdXhPaUowc2Nwd2wzZ1BQbkxxcENyN0JPeWxJ?=
 =?utf-8?B?bmlKTCtrOXo5a3JiYWNad2xlQnVOUittVG1VdkgxTkVoVStRZ2JQRllFNEFL?=
 =?utf-8?B?SnRZYzM1Um52dmN2RUhMck1teG5Eb2JYM3QrU2pJclBBKzZTMzFvUFNORk9t?=
 =?utf-8?B?Q2dIK2Y5K1FwOEJPSVVqd1hLcDg5WlM3TXlpanU1cUlDcS9sb3JyVC9aOWpP?=
 =?utf-8?B?TXRlRVpyRG5wR05oMTljY1RER1h6cyt6ajFuRGVsZnVEbTgrRlh1dE1QSnh6?=
 =?utf-8?B?UnAwSVlqTjdCemxHemc5bG5yQUlLSm41TlpCeG1SNFVxcmw1NDllR2ZEN2FR?=
 =?utf-8?B?QmVkYWJTMjRHK1NvUk81OVNyZXpJclJ2b3hCbjRRYXFGbFJiY1o3aWxCbEk2?=
 =?utf-8?B?c2xVWmxqdzh4OW82VjlvKzQ3WWhPWU1YSW1ZeHpFclNrWXQ3aGdVbWp6NTF4?=
 =?utf-8?B?OExoVVhpa1RYYk55OHg4VGJsVXE5b3MyZXY0Z2psbDY5eWlvc1IrS1BGZzlp?=
 =?utf-8?B?d1ZOTnRhNFdXUzFUKytPaC9DTjREYVRTZk9qUWcrdEh1aUU1NFBab3JiUDFu?=
 =?utf-8?B?Q2VrSVRVK05GU3VQa1lERTVlWkozSjhxMUtJdnlEZ0NGNWVMTGdLQnQvS3VX?=
 =?utf-8?B?VS9RY0djM3ZCTzFKZm1uOFBYckUxbmdlVDNwY25mMHRYczJmMi9uOHFUYUxI?=
 =?utf-8?B?Z0R1RExQRkd0SFlzR3pIbXYxSFhzUnhudDJTTmJCNXVsQWs5NU9SWWtLRnp6?=
 =?utf-8?B?TXRCOUVkSkRsUXFIODUrdzlKQ2N0UXdROFJvY3Z4U0VCNXFrS2ducE1ORGts?=
 =?utf-8?B?YW4yay9iRzJWVEdHV2VtSUJDSVZuTkFsQVRGRU5DUUc1cVFoVW5PWkpWU1pI?=
 =?utf-8?B?RWxZVkJSd0lRQUkxNnk3QVFQMm5IMlAxMXpaVW5JK1hYSXRYRjRXZytySnl4?=
 =?utf-8?B?a25GOWZUd1dPd0tnUllqaVc5SVBVdTM2TFJ4RkswVVd0SDBKQXNHSlNHckJx?=
 =?utf-8?B?aXJlWHBKRmFuZkx0QzBERjJpTHlTRjFLZFB0MWhqNmo1OGU5dVYwZTd0a0d1?=
 =?utf-8?B?bkVNa3lYekQ0bWlQOHJMY25xT0VoZ1Naak9FNGx3ZnRGc2NoRnhZc1g1TVpi?=
 =?utf-8?B?T1IrMk1EWEFTT1prZFd2MklydUdyQXY4WUZ2TjhQSDR4dnFncXJkR0Nxcmpn?=
 =?utf-8?B?cTEwMm1lQVAzZlBCMHZEWVdLUU5tdlJzRllrRDhJRTFFck96b1VzUURTUzlY?=
 =?utf-8?B?MmM5WWNrek9nZmZURGprSHR0dno3eFBsUGdNa2NMdXArWms1bFlLYzA1Zk9r?=
 =?utf-8?B?MndQSTBIcDBrTE4wVm9DUjgxM1pHS2I0ZFcrS09BalAwOFdXUG1aR01WRW1M?=
 =?utf-8?B?UWFjenAybm45MjlXeE9HVGZkWjF1REZnMmp0TmxqbElEaDVKOXh6OGx5b2RX?=
 =?utf-8?B?UmlDcGhWRWVBckNWNDNVNG9RVjN2MjN1eXB0QkRtVGVyeDVtRmVjZ0V3d1Fz?=
 =?utf-8?B?Snh5YTJ5ZG9mVjlRV0w0K0t4amZqRU9RQXJ4THd3RkpIYnYzNWxLMFh4c1lM?=
 =?utf-8?B?cmtxUnpvUkFZOEU0R3NJQkVIZTBTQzJ3K0NRT2VZbnRwNk8vdDJ5WGExeTdo?=
 =?utf-8?B?WUt5UUNBRkpINXFqdjB3bUVZcDc1TzZXQ2IybWpPTWJiNHJ4NWpja2tkaTFT?=
 =?utf-8?B?QVVhbzl2bkhrdlljbjZrN0NNbmtyc3FXdGdTMkMyZVVydlplR0tIT0VhQ1BJ?=
 =?utf-8?B?SzRJR3dwZEJRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXZlMU5la0lJR0dxcytER1lqUFUrUXFGankyNFFRQnpOR2xiV1M2R2xEdDhq?=
 =?utf-8?B?TDNCOGlpL21hNjBLOWorZmJCaE9JWlUvbTQwN1JWcGhwd3lpbnFoaVpTSkk3?=
 =?utf-8?B?cSt2Q0xmT3Bzdk51R0lRdUd1ckxFNUgxdWRDWml2OUxMUmdPb3U0N1FGeGZ2?=
 =?utf-8?B?d2xPaHkwbkVjUG5nQlJ3V3VWN1FPSXFhUkNkTWxtdzNuVUhRZC9abHJYTVk1?=
 =?utf-8?B?Y2s5MXR5RU5ySlg1QVRLSmZCZUhyVWdzL3JuZzRGUjMyUjcvNGtaL3YyMTd3?=
 =?utf-8?B?cmFma3lnQkVvOWNWWHJXT2ZsVWZvQ1EwUEJkeXduSVNpak45QTdBQTJxeDUz?=
 =?utf-8?B?MXRNcVpoT2d6aVB6Sk1WbldjTmxIQnJGZlNxZkJtN0tRNmM2RjRoZXNlWW5o?=
 =?utf-8?B?TENRMFM3Z2QrMzBHNTIzbm9xelBoSHR0R05SUnA0VzNIM1NGL25DaWRvdHcv?=
 =?utf-8?B?MjJvcmZESEJPZk5KcFJBQ1E3NTJaSHgyblRCa1NXUjFpeDFBN0wzYVl5OTAv?=
 =?utf-8?B?UDZtak1oMkpNeGFXT3RCWEtkVGljdEFIVHZzZ00vSytqUHNWYUtVQlE5Q3F3?=
 =?utf-8?B?SjhQT0h2enpCcEowMTEyNHpteDNWRmFWOTA0aXV3U1dOOWhWTFd4UmRpdSts?=
 =?utf-8?B?d0lmS01IaDZNNWZ0YlZnVlFvWCswa2w2R1lGWXBlUy9yak1NNXBaaXB3V0pO?=
 =?utf-8?B?N3pKOHJyUUJNWjB4THJ0N0Y1R01JQ0VkNFFmOXdZRzJEYjdLQ0k0RHhKZkZ4?=
 =?utf-8?B?aENiTUxCdVgvOEd5QjhUSUhmOGVkaVRsaFNxL0tTTzZWS0tHYno0U1ZvaW12?=
 =?utf-8?B?dmx2Z0tuRzVBSWVYL1lWaWYwKzhybzFrQlpDa2R3OTg3RWVQTjJkdVppSmlz?=
 =?utf-8?B?ZjZGamU4NEhOT2o4NjhueXJTVTNTa2RPQnprMU95Wjg5dHBUWS9oTEtqOTR2?=
 =?utf-8?B?ZlAwSEc2cVlDdXFFVkk3SXp4SFNyM3hZeDhaYk81TXUvdnpIWkgzbWVna3JI?=
 =?utf-8?B?RzFNSjJUdy9LN3VxWFhWTjlVcFVtT0JYdGcxWFlwd3J5ekZBcnJyVjFpUmlK?=
 =?utf-8?B?M1pMdnZFYjBPKzlDTWRkSGJqVlJoVjVqZEJvNzBmYmw1Nmd5VmY2aXFqUy9G?=
 =?utf-8?B?WUc4OWpZdDlLc2FYUmtwdU1vbWxBQ1paeHdScG1DSmlZOFRaTXZVZFczUzAr?=
 =?utf-8?B?SlVaNmxuSmhqQk9tRVlqMk84K1RMY0tNaHRWSFhqWTQ3eTdJUXdOU1p3aEk0?=
 =?utf-8?B?RktlVUN4UVFmUWswRFlKcy9mSkxLS2t6VjhzbHR0bkhsL1dyRk44YWVIbzI4?=
 =?utf-8?B?M216ZmtVUDhtSGZJSEo0S0wrWUt5d2ZHUXgwZnNXRDNnUFBjSU1UQmdRZTda?=
 =?utf-8?B?cThlR25vU3gzUXJJaWRjZnFtVFNzNXY0RWpaOVBZTVB2a0RhejYyb1hJelZl?=
 =?utf-8?B?SWhNcEVQdE1vck11QWtMYUJ0a2hpN1AySkJaT0kvVldacHp3cFJwU0VvYkFZ?=
 =?utf-8?B?aFNQbDlhWm5BbHJlQ24zZnc0YXVpOXRLR205Q0Zrb0oxZnc3S1JmNEtqakVj?=
 =?utf-8?B?akRLL1lEeEEvNFJtNDQrN0VPUy9GdFhsbm9sMHVLc2ZOemhLb0xYMGtSMnRR?=
 =?utf-8?B?alRNODhhSWVVRmRuWmhmdmVNSDFReU9RQjB3Nm5jTWJWendIcVhpUC84aFlG?=
 =?utf-8?B?YUVpV2xEck8zbHR0VDJFajl0VzBqWTBQNy83bkE2ZWNtdVIyMlJsczBZNjdJ?=
 =?utf-8?B?bm1LYjVSTGUwZUJ6ancvZXFNcXQvcHhCNXVPMEk5ajhCTlM5Wm8zTTEzUXdo?=
 =?utf-8?B?T3NxdWxISThDZFFOdjZETWg3YThoeU44K0plaUhXcFM1OXRTdnhlUWhQQVdY?=
 =?utf-8?B?V1I3WVNic1MrRXlpbjhBU0FmS3NoWDFmRGUwZVFtSHgvbjhFRW1jd0tPMkRj?=
 =?utf-8?B?WFpaQ0cwV2dBU25VNVBHemNsUHRvZTMyRWtMa3NyVzhYQnhqY0dqUE94a1Z6?=
 =?utf-8?B?RENoaXRpdVZYQjJSdDVreFYxODlkUXA1eElOQ2taVVFzMURLK2dkZmhGZmFi?=
 =?utf-8?B?SEdDcXRKNHBlMEcyOHMyUVpCaWxnNEh4bERwc0ZmN09lbUJta3pyUDFRVzlF?=
 =?utf-8?B?QUFrR1E4RnMzeGp3V1drL0JLN1luZ0ZQK253RUMxUmRBQ0FPVU9BRDVRMVM1?=
 =?utf-8?B?ejRvNTJSSmxSY0dkM1p4MXk4bWdYUUdPQWhKOCtPeVBTR1BPTFp6dDBrbkQ5?=
 =?utf-8?B?ZVZra1hVN0tHYXVGWGcvRGxITEd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBE47EB6A0CCB6498B7CE9946B9A9414@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2240b721-9c60-458f-54c1-08dd36a52a42
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 03:15:16.2412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CbKhKvkB0yn4PON/1u0fIGn7KlZB6xokp+sLROMOrt7ZmEKjkJ1CqmzCDV5ddTTki0tNMbHIDAf92FxItAUazw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4091

T24gRnJpLCAyMDI1LTAxLTE3IGF0IDEwOjI5ICswODAwLCB5YW5nZXJrdW4gd3JvdGU6DQo+IA0K
PiANCj4g5ZyoIDIwMjUvMS8xNyA0OjUyLCBUcm9uZCBNeWtsZWJ1c3Qg5YaZ6YGTOg0KPiA+IE9u
IFRodSwgMjAyNS0wMS0xNiBhdCAxOTo0MyArMDgwMCwgeWFuZ2Vya3VuIHdyb3RlOg0KPiA+ID4g
SGksDQo+ID4gPiANCj4gPiA+IFRoYW5rcyBmb3IgdGhlIHBhdGNoLg0KPiA+ID4gDQo+ID4gPiBC
ZWZvcmUgMzk0OTQxOTRmOTNiKCJTVU5SUEM6IEZpeCByYWNlcyB3aXRoIHJwY19raWxsYWxsX3Rh
c2tzKCkiLA0KPiA+ID4gZXZlcnkNCj4gPiA+IHRpbWUgd2Ugc2V0IFJQQ19UQVNLX1NJR05BTExF
RCwgd2hlbiB3ZSBnbyB0aHJvdWdoIF9fcnBjX2V4ZWN1dGUsDQo+ID4gPiB0aGlzDQo+ID4gPiBy
cGNfdGFzayB3aWxsIGltbWVkaWF0ZSBicmVhayBhbmQgZXhpc3QuDQo+ID4gPiANCj4gPiA+IEhv
d2V2ZXIgYWZ0ZXIgdGhhdCwgX19ycGNfZXhlY3V0ZSB3b24ndCBqdWRnZSBSUENfVEFTS19TSUdO
TkFMRUQsDQo+ID4gPiBzbw0KPiA+ID4gZm9yDQo+ID4gPiB0aGUgY2FzZSBsaWtlIHlvdSBwb2lu
dCBvdXQgYmVsb3csIGV2ZW4gYWZ0ZXIgeW91ciBjb21taXQNCj4gPiA+IHJwY19jaGVja190aW1l
b3V0IHdpbGwgaGVscCBicmVhayBhbmQgZXhpc3QgZXZlbnR1YWxseSwgYnV0IHRoaXMNCj4gPiA+
IHJwY190YXNrIGhhcyBhbHJlYWR5IGRvIHNvbWUgd29yay4gSSBwcmVmZXIgcmVpbnRyb2R1Y2Ug
anVkZ2luZw0KPiA+ID4gUlBDX1RBU0tfU0lHTk5BTEVEIGluIF9fcnBjX2V4ZWN1dGUgdG8gaGVs
cCBleGlzdCBpbW1lZGlhdGx5Lg0KPiA+ID4gDQo+ID4gDQo+ID4gQmV0dGVyIHlldC4uLiBMZXQn
cyBnZXQgcmlkIG9mIHRoZSBSUENfVEFTS19TSUdOQUxMRUQgZmxhZw0KPiA+IGFsdG9nZXRoZXIN
Cj4gPiBhbmQganVzdCByZXBsYWNlDQo+ID4gDQo+ID4gI2RlZmluZSBSUENfVEFTS19TSUdOQUxM
RUQodGFzaykgKFJFQURfT05DRSh0YXNrLT50a19ycGNfc3RhdHVzKSA9PQ0KPiA+IC1FUkVTVEFS
VFNZUykNCj4gDQo+IEhpLA0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHJlcGx5ISBZZWFoLCBpZiBh
bGwgdGhlIHBsYWNlcyB3aGVyZSB0a19ycGNfc3RhdHVzIGlzDQo+IHVwZGF0ZWQgYXJlIGJ5IGNh
bGxpbmcgcnBjX3Rhc2tfc2V0X3JwY19zdGF0dXMsIHdlIGNhbiB1c2UNCj4gdGFzay0+dGtfcnBj
X3N0YXR1cyA9PSAtRVJFU1RBUlRTWVMgdG8gZGV0ZXJtaW5lIHdoZXRoZXIgcnBjX3Rhc2sgaXMN
Cj4gUlBDX1RBU0tfU0lHTkFMTEVELiBCdXQgZm9yIHRoZSBjYXNlIGxpa2UgTGkgaGFzIHByb3Zp
ZGVkLA0KPiBfX3JwY19yZXN0YXJ0X2NhbGwgd29uJ3QgZG8gdGhpcywgYW5kIHdpbGwgb3Zlcndy
aXRlIHRrX3JwY19zdGF0dXMgDQo+IHVuY29uZGl0aW9uYWxseS4gVGhpcyB3b24ndCBiZSBhIHN0
YWJsZSBzb2x1dGlvbi4gTWF5YmUgaXQncyBiZXR0ZXINCj4gdG8NCj4gY2hhbmdlIF9fcnBjX3Jl
c3RhcnRfY2FsbCBjYWxsaW5nIHJwY190YXNrX3NldF9ycGNfc3RhdHVzIHRvbz8gQW5kDQo+IF9f
cnBjX2V4ZWN1dGUgd2lsbCBiZSBlbm91Z2ggdG8gaGVscCBzb2x2ZSB0aGlzIGNhc2UuDQo+IA0K
PiANCg0KVGhhdCB3b3VsZCBicmVhayBfX3JwY19yZXN0YXJ0X2NhbGwoKSB0byB0aGUgcG9pbnQg
b2YgcmVuZGVyaW5nIGl0DQpjb21wbGV0ZWx5IHVzZWxlc3MuDQpUaGUgd2hvbGUgcHVycG9zZSBv
ZiB0aGF0IGNhbGwgaXMgdG8gZ2l2ZSB0aGUgTkZTIGxheWVyIGEgY2hhbmNlIHRvDQpoYW5kbGUg
ZXJyb3JzIGluIHRoZSBleGl0IGNhbGxiYWNrLCBhbmQgdGhlbiBraWNrIG9mZiBhIGZyZXNoIGNh
bGwuDQpZb3VyIHN1Z2dlc3Rpb24gd291bGQgbWVhbiB0aGF0IGFueSBSUEMgbGV2ZWwgZXJyb3Ig
c3RpY2tzIGFyb3VuZCwgYW5kDQpjYXVzZXMgdGhlIG5ldyBjYWxsIHRvIGltbWVkaWF0ZWx5IGZh
aWwuDQoNCkkgc2VlIG5vIHBvaW50IGluIGRvaW5nIGFueXRoaW5nIG1vcmUgdGhhbiBmaXhpbmcg
dGhlIGxvb3BpbmcNCmJlaGF2aW91ci4gRWxpbWluYXRpbmcgdGhlIHJlZHVuZGFudCBmbGFnIHdp
bGwgZG8gdGhhdC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFp
bnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
DQo=

