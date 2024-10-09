Return-Path: <linux-nfs+bounces-6976-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA7E996ED6
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 16:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52EB281AE7
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 14:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD4751C4A;
	Wed,  9 Oct 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Gug0dAoq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2135.outbound.protection.outlook.com [40.107.94.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38368558B7
	for <linux-nfs@vger.kernel.org>; Wed,  9 Oct 2024 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485705; cv=fail; b=RsTkCuTrUuSkJ4yPA8cNR886uuyupxxzrDyokadQegM+jR9JAVwqSk5gWqeCVnXHD8M8VXmiNcfnY04gVmUvzXc4cb2PjUTooCbLcgxFNEHs1us4g+D2dpslvQ6C2TXfBnu7qYdcWtQZw1ihgW5psF9Mrb5sYn9N7SlXG3LLOdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485705; c=relaxed/simple;
	bh=J66Ds/bjCSmCr8v5QQd9DrVAqosyonJgQWwDrXFPjUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qt/fYvenpXs4PMm2LFYDfvXfHSokZY4maoYgLx7R659I+ZkPpxhTPVzhAd5yNNgvRG9dMw8LvYpIAxBVgTjICeTpEaTR2EWFAKAKgsNvVB4kaEJD/xJ+MpuR/jZDbWy+zF7DRq7vsNwvRqwwmCw53AdTKS+rJTdndqlEhF7IC58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Gug0dAoq; arc=fail smtp.client-ip=40.107.94.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXOqFhPqHmy6hdcmZPdNrL51wjronuIAgBSxYW5jcectw2RrW0Fh7TPWpu1Wr9BpluEmJci8qOzIju50Y5VRx8oCDfrl6m2VsDbS2WxeA6/lLlNT6krSJrvoXVDL32X3pEhkUfCykFVrD+xbiSY6lu6oKpqLOaYopKWZFjdijRzKbfcLvs43dUiMyKAjHQpIlX5RFbS3W3pnWRSlbnM1KZIfMfw+BN7G+zbXzhc8hcZLjYX9CCz51ekLeLOGZwUQHVLO7oe3jJ9g5Z8uLuMWN6Rivm9TjQ4F85+JBeSPo5cE3aL7cRZwbXTk5yLZwtdzCvpV4ewkT8yKdCqZK8VF5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J66Ds/bjCSmCr8v5QQd9DrVAqosyonJgQWwDrXFPjUE=;
 b=EDZ3UHTsWHgBeslO1mW6xtN3wQL1yYAj76yrYSiM8ug1ha+e2V7eHXFvmrRFYFKO/VtkuOiYQNn+XO7cdIcao9XmnwF479+pHzMDfsWMK5jZV3OjWgSLljwlrhdhGKwBVUV2CitzPHEZ+PyBbpSdzd7/ieXhsK1D2KIwdeBQzhCCNBVloSWs5VuLAzjVj+ON0QId8hLTk4ixmJe+WUB+XLbpj11MtyRH/nP3eogMpNpsiM3BDPylb+U3QjJsNOpP5DM5IO5NLMzOWCPFmh/6hKFaNsM/we3bv2EypVVhLxz1V/AxnQFpp058Zih45q1N9JfkllBK6k+ru5UjkuBI+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J66Ds/bjCSmCr8v5QQd9DrVAqosyonJgQWwDrXFPjUE=;
 b=Gug0dAoqCtUDBl6iWbH72NsGYUEiYkgS1XGF+byr4lu8nfjyKdvLeljEl2NNzVeVIznc8HSK2ZWk+pj9LKHpTqA5Yw/ASp1gtzA9uDjBmqgjt86BFKeOgfzMAUE0KC0a2//cvwPBi6aPiZuQZspd0WC9/htQLvJR08lKj4qJ680=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB4757.namprd13.prod.outlook.com (2603:10b6:408:124::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Wed, 9 Oct
 2024 14:54:57 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 14:54:57 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "yangerkun@huaweicloud.com" <yangerkun@huaweicloud.com>, "anna@kernel.org"
	<anna@kernel.org>, "yangerkun@huawei.com" <yangerkun@huawei.com>,
	"anna.schumaker@oracle.com" <anna.schumaker@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"yi.zhang@huawei.com" <yi.zhang@huawei.com>
Subject: Re: [PATCH] NFSV4: fix rpc_task use-after-free when open concurrently
Thread-Topic: [PATCH] NFSV4: fix rpc_task use-after-free when open
 concurrently
Thread-Index: AQHbD9t+pj8ZWRUwq0W3P3OOkzvhNbJsIDQAgAHgxYCAD87kaIAAxtOA
Date: Wed, 9 Oct 2024 14:54:57 +0000
Message-ID: <edd32ea932f9b24fe188ffbadb28bc8bf4e066dd.camel@hammerspace.com>
References: <20240926061210.3309559-1-yangerkun@huaweicloud.com>
	 <929c8087-e28b-43e9-8973-71d9f1b821d6@oracle.com>
	 <965aad29-d119-b3bb-1a19-0c52c28fd376@huaweicloud.com>
	 <ec268559-2b29-c7b1-85b8-7a86a4ba228a@huawei.com>
	 <086eb949-6d07-e5af-da65-e4bccf84dd1a@huaweicloud.com>
In-Reply-To: <086eb949-6d07-e5af-da65-e4bccf84dd1a@huaweicloud.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BN0PR13MB4757:EE_
x-ms-office365-filtering-correlation-id: f6033f96-751d-48c3-e463-08dce8725790
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?azNhOC9xSi9SSXBsWU1SQnhkMzlCQ2o3VGl3dXJTUjNYZnNBYVVpLzc0Um1M?=
 =?utf-8?B?dUtzVHh4bXpweE5QcnhoQW1EdFdxR3ZyUkZ6QjJWdW9zUC8rZFozbFNKOHQ1?=
 =?utf-8?B?SVR0d3FVd0RONjFTWHBGbURqdkVaNWtISVB3YmF2a2hsQ1I2UWo0QjJOYmto?=
 =?utf-8?B?RGxqeXVlVGwxYlB0anhqV3lMalBnTk00emYrTGVXS1pQWU5IaFlVZnhmR0lB?=
 =?utf-8?B?WkMyNlBrWG5OemJOOU5YUVZoOGtIVTRiL3lCV2Jjb0hhMHVacXRLSElDVkJn?=
 =?utf-8?B?TFkycFFVZDk4dVNIcGlYamhCTFVEL1huTHJGM2E1d0UvMU93U2ZvWUZRd1kw?=
 =?utf-8?B?QjNSOXlhN1VkSy82c2Q3NkdWZFcvMG9XdGZ2U0ZJUURzaTVYT3lMb1JuVkha?=
 =?utf-8?B?SFdVd3k2NUFBMmNZNlFwSmMveUtpNWRxZnJueEpBbHZ0TXo3cUU5V0JzMzd3?=
 =?utf-8?B?eDNaQWtKNENGVDZmOVR1bG9PeFNpdk9nN1VYOVpFNHg4UXpuTE8zeXdTUEF4?=
 =?utf-8?B?S1FkZ1VRL2pCbTg5WGJDZk4yMk1HeXg5RmZnTGFBVmZ6LzdhZjdJeUdJOE1P?=
 =?utf-8?B?dTNMYXEwYU1zcjRRS3RwUERXUmhXd1FsUXJYVEs2c2RHK2NzSXN5ZXFiM0pO?=
 =?utf-8?B?ZSt3NndqWkVBcnI3QjNJaFNFU0Y2VUQrYVp1V05HWE93cVZidmNnZTY3b3Z3?=
 =?utf-8?B?SDZJaFhZZ0FSVFYwcXhpeFpVUDJSQ3k0T2Q4dzRqdHZUdWpHZlFSZ2pScXVm?=
 =?utf-8?B?NGVyUzJ2eVFON2lCbGxNeGV5bTlpZ0FuUTBrMjV0SGtONlprV25mRTdxdTNU?=
 =?utf-8?B?NndaR0hPSWc0Y3NqNTRpSkYzc2N3MFZWdGRDd3FoZHpFMExBL3BsQk8rRG5E?=
 =?utf-8?B?ci9iczZuR3pac0g2WnhmM2hLYUNmTTVzMmN3aU9JTzNpeng2akxWVktNQ2Jr?=
 =?utf-8?B?S2NveUdCTzZGWHRVdHoyZVZVMnd2WHY5WCtmQzJ3RzZPRnRwQmVOb3JoS28v?=
 =?utf-8?B?bnUxbzFsYmt5bFZ3UWJmSVFlcXNvd1JuVEdpNmRVL2dKQXVzNFlobTFQVHY2?=
 =?utf-8?B?Y1ZZSkJVQkZpUmgrUHhQeFZoY1NrQk96NFVUdUMzVjdrT3lpdTFBckp2S2F0?=
 =?utf-8?B?LzBnUlM1RnRNODV6TWw2SnByM3VJNUQrZ29icUNCMU5yc1lrbHlEYTJ6RGg4?=
 =?utf-8?B?RU5vR1dyZWRzMzhuY0tUYXZpL0QzbVBDRWpHcVJSazlNRm85WlQ2cnc2L0gw?=
 =?utf-8?B?RG1DNlJ0Q2NGMWJOYkNoVzh5NWJacUFodytQSStoTmp1UGdVeDhzODFlZEU2?=
 =?utf-8?B?Y0sxVHdibmxFMVFncXg5dmFZNW9aTnB1bzRUbS9QVXU3TWNYSmN1L1NzY1ls?=
 =?utf-8?B?YkRQU05pVElvZGt2L3VCYmRZdnVnSFNtZXVuWm1WczhzT3ZDMERmNlZvdG9m?=
 =?utf-8?B?bHNhakV2WjBaTDFicm9vOUxJUWNGZ3FLTlgxR1p4dFpTdmVCNjZOZVp1djZR?=
 =?utf-8?B?MnJRV0lVdnJ4MGJJQjRCemx4WmJjbTBFS1lKdkZzSzJ1Sjd3Qy93Z3VEbTZB?=
 =?utf-8?B?dFZxa2NnVlo3Q1FNak5vNlg5bHdsejV0NmNEVVptT0tGWkZFb2poMHZ2cmNt?=
 =?utf-8?B?WEdGRFhSeVM1ZzE4blFlbWp3YkJ1am9wUjgwVVJTdi9hdjdLYjBXWFlLSC9x?=
 =?utf-8?B?VW5rQ1ZkQ3Qxc1dOMHVnSG1GQnRHclZmZTNOeHVodGwyb2dVa1FSZWFLMVVB?=
 =?utf-8?B?ay83c2lQMC9kR2lDNkdFTktZTVZEcm1QUTdwM2c2MUw1TFFrbzdualp2bHVF?=
 =?utf-8?B?WGJEcHdCcFJDMk90UlQydz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vmc4M3V0dFkvYlZURmlXMW9SbVlRbGNDSHVmOFlXZzl6cEY1M29pd0Z1WkpQ?=
 =?utf-8?B?TWUzaXU2VkI0WkluYlNyZ1JhL0pPZDgyUkRHU3p1Y1d2emUwMnVpTHZWOS91?=
 =?utf-8?B?RG5SRk9vQ1VhUk82TWNrdWFwWHFwWWtGWm9odTExa05PZ2p6NTE4bGs2Qit1?=
 =?utf-8?B?NTBST2phZ0pDeVZuVGVCS04xRy9ZSHdQckN6OXg1NlQ5U01vbTZSNDFHVGlU?=
 =?utf-8?B?SllrR08ya3ZNVXlBdnRHRXVPUjQ3UHJWYzBnY080eHVLVmxIaWJqL0h5V1pr?=
 =?utf-8?B?U0xXNHdESWdRVkhpejEvQU04UXNmSGJWNnJBVnNISzRUSHdSZlUyRVR6ZGdE?=
 =?utf-8?B?U2hwZ0pmdk1DWTdLcmRPem5rV1VDUG5peGN3N1ZJczhpUXdrdy9qZTVOYjJR?=
 =?utf-8?B?WDRuRlJ1R3JLMWNnM3NEOXhWWGRtYmF5UUs2RlRkZ0FITDdoN3RRNnQwVFEx?=
 =?utf-8?B?cjZGeDgvZ09lN3N2UkxjeWpEZDBIaldhVzNad0dvaG5CQVY5cFVQNktJMTR1?=
 =?utf-8?B?NlA4TlpYMHBuSTZJY1JHUDM4K1RpQVM3akJlVWFCSnNPS3d1V05QZG12eXox?=
 =?utf-8?B?RGdMa2EwcGtIcXdrWGpySjd4dDY2T2xHUktaTXpUOXdNSGZaZndWbTM0dTFv?=
 =?utf-8?B?ZWE5d0ViVEpQQy9KZFV2UlhmTnNXV2pRVjdiRzZkQmhNNlZ0M2hvL2pDSnh2?=
 =?utf-8?B?cWIraGpvYjhyTGJjbWFERjhLOFd0d3FoUXhRcGY3L3lUSkZvWVFnK0VzZTNz?=
 =?utf-8?B?V3VSd0tyZWRIZVJsTFVYZ2FVMW5aTEFMZ1lqaFp1VnBMQ3ZiUTYwS241WTVE?=
 =?utf-8?B?Qk0zZzhyOTlpNHNudUdTaXVGMWtydUxEUDR4V0RBQ0ZDMGo2cHpWcjBwM0Yz?=
 =?utf-8?B?Uk5tbGJHZktIVTlBMnNVVGVieWdYeXQzYTZJc3Z5RFV6ZDkySElCaUlXbktS?=
 =?utf-8?B?cDlEYjNMTkNMOWw1MkViUytYSFFBYjRRQndQNEJYazFVUDZ6R0xaQTFTUHdF?=
 =?utf-8?B?OVk2Um9iRExTOUYvL3M5c2tTRGlNWVJqVGliRjFCRnJ2ejRLdlF1SWpVWkNK?=
 =?utf-8?B?cE9FUmRPWnVOSUw5ckhlTHlWT3lxWGpPblZJNmM2ZDYrRzZZbjZBVVdTdXcy?=
 =?utf-8?B?UXRLSEFoS0xlQitUV3BudXpNa0ExOFQyQjBTd25UTFJKUDl1S0tXYy9QQkFC?=
 =?utf-8?B?aVYxdHc2VFMycnN1QmpiYWQ4LzdnOERFTmF4eXpUcjU0YTF0SjkwMHhHTGRr?=
 =?utf-8?B?K1k1YnZMSytGNWtEQmk2UitMU0JNV3ZDZ1N4Z3E1Ylc2dEt3LzRFdG5hMzB2?=
 =?utf-8?B?aklvMHZaYXVYVk1JeFBzMUtNY1lqKzB4azRKU1lHS1dqTE9kTGdNOUM1Z1pQ?=
 =?utf-8?B?Q3RkWENSbHpSL2NIQklwWUtXSGFXQVF1enRYd3JzeER6YnZDWHoraVJxbHpI?=
 =?utf-8?B?QUwwS1dSUk9xN3VjSVlkTWFCU3M3cEV6dVlIbXpGOTIyZ28rWFJWZFMrbE9y?=
 =?utf-8?B?UExvZlk1aTl1UEpuQzdaV1prMWl4V3psbUVmWmhFMEFyS08wRis4NzJoUkxo?=
 =?utf-8?B?QjNNbGZwVmhtamZOZ2xBNWZMcy94M0hZbkN0c1JSL1RPbjQ2WkJGNk1aUGVy?=
 =?utf-8?B?OU56VWduZmYwVnRZbklMYXk5WDlXM1kwczRoSmk5bzFNcjhXWG41RCt2b3lT?=
 =?utf-8?B?KzliampkNWdJRVl3MGFjbWZOWXBGYy9NaHdXZXBXcXh5NnZTQnVaUXFDQ2li?=
 =?utf-8?B?Ykh6VmwxaDlHM0QxNzdsWW5CdSs0aG1kcC9KU1l2dHVDZkdjUWlyZUM3OVNY?=
 =?utf-8?B?VFgzR0ZLRFJjSXJTZ0p1VlQxSHh0aTJ6OFBUVnh3TVI5NG8zVzZTdjVjR0s3?=
 =?utf-8?B?UWtoTDZkRGVjMkVjN1JaeXoyaE5OQWszZTJySmpyNzdpcy9hQ0pVdWU0Y2J4?=
 =?utf-8?B?dGhHc1lNQ0E4SkE5c2t4aXQzU1Uwcm1SZlRrNU1kNk9EdldkMVhEVG56UG9Z?=
 =?utf-8?B?dW9mWHBrZjhJY04yc1BuRTZKUklseUdQcW43WUJKTmpmK3VzTVVadmtCNXBu?=
 =?utf-8?B?bWVXL1hMZFM2ZWNVYnEzWnorakJSV01XMkRPZGN3bGltREhERWlnVC9BK0dP?=
 =?utf-8?B?QmFwb2pPYnh6WEkwdCtrT1NwbzdnNXVuWTlkRUxHaEtOSlVXZUx0Y2dhUmN1?=
 =?utf-8?B?eWtrUkFLU0hMOWlraUVOb0pNUmFrSk42dSs0RGlVdmdtVnBzaTd1eFo0bXo1?=
 =?utf-8?B?cFViK2c5MEJRcnFMQlJzOS9vdHZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DEEEF3532FC2145872C7F399B1A5C64@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f6033f96-751d-48c3-e463-08dce8725790
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 14:54:57.2480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1V2VFVmiGzzxgONxmFWgGGKBR9KAuqPdB24SLPwgTU8/I8vvCuYWZX78glzf1dC8BO5ixVovc6zhMZtlBU7doA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4757

T24gV2VkLCAyMDI0LTEwLTA5IGF0IDExOjAyICswODAwLCB5YW5nZXJrdW4gd3JvdGU6DQo+IEhp
LA0KPiANCj4gUGluZyBmb3IgdGhpcyBwYXRjaC4uLg0KPiANCj4g5ZyoIDIwMjQvOS8yOSA5OjQ1
LCB5YW5nZXJrdW4g5YaZ6YGTOg0KPiA+IA0KPiA+IA0KPiA+IOWcqCAyMDI0LzkvMjkgOTozOCwg
eWFuZ2Vya3VuIOWGmemBkzoNCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiDlnKggMjAyNC85LzI4IDQ6
NTgsIEFubmEgU2NodW1ha2VyIOWGmemBkzoNCj4gPiA+ID4gSGkgWWFuZywNCj4gPiA+ID4gDQo+
ID4gPiA+IE9uIDkvMjYvMjQgMjoxMiBBTSwgWWFuZyBFcmt1biB3cm90ZToNCj4gPiA+ID4gPiBG
cm9tOiBZYW5nIEVya3VuIDx5YW5nZXJrdW5AaHVhd2VpLmNvbT4NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBUd28gdGhyZWFkcyB0aGF0IHdvcmsgd2l0aCB0aGUgc2FtZSBjcmVkIHRyeSB0byBvcGVu
DQo+ID4gPiA+ID4gZGlmZmVyZW50IGZpbGVzDQo+ID4gPiA+ID4gY29uY3VycmVudGx5LCB0aGV5
IHdpbGwgdXRpbGl6ZSB0aGUgc2FtZSBuZnM0X3N0YXRlX293bmVyLg0KPiA+ID4gPiA+IEFuZCBp
biBvcmRlcg0KPiA+ID4gPiA+IHRvIHNlcXVlbnRpYWwgb3BlbiByZXF1ZXN0IHNlbmQgdG8gc2Vy
dmVyLCB0aGUgc2Vjb25kIHRhc2sNCj4gPiA+ID4gPiB3aWxsIGZhbGwNCj4gPiA+ID4gPiBpbnRv
IFJQQ19UQVNLX1FVRVVFRCBpbiBuZnNfd2FpdF9vbl9zZXF1ZW5jZSBzaW5jZSB0aGVyZSBpcw0K
PiA+ID4gPiA+IGFscmVhZHkgb25lDQo+ID4gPiA+ID4gd29yayBkb2luZyB0aGUgb3BlbiBvcGVy
YXRpb24uIEZ1cnRoZXJtb3JlLCB0aGUgc2Vjb25kIHRhc2sNCj4gPiA+ID4gPiB3aWxsIHdhaXQN
Cj4gPiA+ID4gPiB1bnRpbCB0aGUgZmlyc3QgdGFzayBjb21wbGV0ZXMgaXRzIHdvcmssIGNhbGwg
DQo+ID4gPiA+ID4gcnBjX3dha2VfdXBfcXVldWVkX3Rhc2sgaW4NCj4gPiA+ID4gPiBuZnNfcmVs
ZWFzZV9zZXFpZCB0byB3YWtlIHVwIHRoZSBzZWNvbmQgdGFzaywgYWxsb3dpbmcgaXQgdG8NCj4g
PiA+ID4gPiBjb21wbGV0ZQ0KPiA+ID4gPiA+IHRoZSByZW1haW5pbmcgb3BlbiBvcGVyYXRpb24u
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhlIHByZWNlZGluZyBsb2dpYyBkb2VzIG5vdCBjYXVz
ZSBhbnkgcHJvYmxlbXMgdW5kZXIgbm9ybWFsDQo+ID4gPiA+ID4gY2lyY3Vtc3RhbmNlcy4gSG93
ZXZlciwgd2hlbiBvbmNlIHdlIGZvcmNlIGFuIHVubW91bnQgdXNpbmcNCj4gPiA+ID4gPiBgdW1v
dW50IA0KPiA+ID4gPiA+IC1mYCwNCj4gPiA+ID4gPiB0aGUgZnVuY3Rpb24gbmZzX3Vtb3VudF9i
ZWdpbiBhdHRlbXB0cyB0byBraWxsIGFsbCB0YXNrcyBieQ0KPiA+ID4gPiA+IGNhbGxpbmcNCj4g
PiA+ID4gPiBycGNfc2lnbmFsX3Rhc2suIFRoaXMgaGVscCB3YWtlIHVwIHRoZSBzZWNvbmQgdGFz
aywgYnV0IGl0DQo+ID4gPiA+ID4gc2V0cyB0aGUNCj4gPiA+ID4gPiBzdGF0dXMgdG8gLUVSRVNU
QVJUU1lTLiBUaGlzIHN0YXR1cyBwcmV2ZW50cw0KPiA+ID4gPiA+IGBuZnM0X29wZW5fcmVsZWFz
ZWAgZnJvbQ0KPiA+ID4gPiA+IGNhbGxpbmcgYG5mczRfb3BlbmRhdGFfdG9fbmZzNF9zdGF0ZWAu
IENvbnNlcXVlbnRseSwgd2hpbGUNCj4gPiA+ID4gPiB0aGUgc2Vjb25kDQo+ID4gPiA+ID4gdGFz
ayB3aWxsIGJlIGZyZWVkLCB0aGUgb3JpZ2luYWwgdGFza3Mgd2lsbCBzdGlsbCBleGlzdCBpbg0K
PiA+ID4gPiA+IHNlcXVlbmNlLT5saXN0KHNlZSBuZnNfcmVsZWFzZV9zZXFpZCkuIExhdHRlciwg
d2hlbiB0aGUgZmlyc3QNCj4gPiA+ID4gPiB0aHJlYWQNCj4gPiA+ID4gPiBjYWxscyBuZnNfcmVs
ZWFzZV9zZXFpZCBhbmQgYXR0ZW1wdHMgdG8gd2FrZSB1cCB0aGUgc2Vjb25kDQo+ID4gPiA+ID4g
dGFzaywgaXQgDQo+ID4gPiA+ID4gd2lsbA0KPiA+ID4gPiA+IHRyaWdnZXIgdGhlIHVhZi4NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBUbyByZXNvbHZlIHRoaXMgaXNzdWUsIGVuc3VyZSBycGNfdGFz
ayB3aWxsIHJlbW92ZSBpdCBmcm9tDQo+ID4gPiA+ID4gc2VxdWVuY2UtPmxpc3QgYnkgYWRkaW5n
IG5mc19yZWxlYXNlX3NlcWlkIGluDQo+ID4gPiA+ID4gbmZzNF9vcGVuX3JlbGVhc2UuDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+ID4gPiA+ID09PT09DQo+ID4gPiA+ID4gQlVHOiBL
QVNBTjogc2xhYi11c2UtYWZ0ZXItZnJlZSBpbg0KPiA+ID4gPiA+IHJwY193YWtlX3VwX3F1ZXVl
ZF90YXNrKzB4YmIvMHhjMA0KPiA+ID4gPiA+IFJlYWQgb2Ygc2l6ZSA4IGF0IGFkZHIgZmYxMTAw
MDAwNzYzOTkzMCBieSB0YXNrIGJhc2gvNzkyDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQ1BVOiAw
IFVJRDogMCBQSUQ6IDc5MiBDb21tOiBiYXNoIFRhaW50ZWQ6IEfCoMKgwqAgQsKgwqAgVw0KPiA+
ID4gPiA+IDYuMTEuMC0wOTk2MC1nZDEwYjU4ZmU1M2RjLWRpcnR5ICMxMA0KPiA+ID4gPiA+IFRh
aW50ZWQ6IFtCXT1CQURfUEFHRSwgW1ddPVdBUk4NCj4gPiA+ID4gPiBIYXJkd2FyZSBuYW1lOiBR
RU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUw0KPiA+ID4gPiA+IDEu
MTYuMS0yLmZjMzcgMDQvMDEvMjAxNA0KPiA+ID4gPiA+IENhbGwgVHJhY2U6DQo+ID4gPiA+ID4g
wqAgPFRBU0s+DQo+ID4gPiA+ID4gwqAgZHVtcF9zdGFja19sdmwrMHhhMy8weDEyMA0KPiA+ID4g
PiA+IMKgIHByaW50X2FkZHJlc3NfZGVzY3JpcHRpb24uY29uc3Rwcm9wLjArMHg2My8weDUxMA0K
PiA+ID4gPiA+IMKgIHByaW50X3JlcG9ydCsweGY1LzB4MzYwDQo+ID4gPiA+ID4gwqAga2FzYW5f
cmVwb3J0KzB4ZDkvMHgxNDANCj4gPiA+ID4gPiDCoCBfX2FzYW5fcmVwb3J0X2xvYWQ4X25vYWJv
cnQrMHgyNC8weDQwDQo+ID4gPiA+ID4gwqAgcnBjX3dha2VfdXBfcXVldWVkX3Rhc2srMHhiYi8w
eGMwDQo+ID4gPiA+ID4gwqAgbmZzX3JlbGVhc2Vfc2VxaWQrMHgxZTEvMHgyZjANCj4gPiA+ID4g
PiDCoCBuZnNfZnJlZV9zZXFpZCsweDFhLzB4NDANCj4gPiA+ID4gPiDCoCBuZnM0X29wZW5kYXRh
X2ZyZWUrMHhjNi8weDNlMA0KPiA+ID4gPiA+IMKgIF9uZnM0X2RvX29wZW4uaXNyYS4wKzB4YmUz
LzB4MTM4MA0KPiA+ID4gPiA+IMKgIG5mczRfZG9fb3BlbisweDI4Yi8weDYyMA0KPiA+ID4gPiA+
IMKgIG5mczRfYXRvbWljX29wZW4rMHgyYzYvMHgzYTANCj4gPiA+ID4gPiDCoCBuZnNfYXRvbWlj
X29wZW4rMHg0ZjgvMHgxMTgwDQo+ID4gPiA+ID4gwqAgYXRvbWljX29wZW4rMHgxODYvMHg0ZTAN
Cj4gPiA+ID4gPiDCoCBsb29rdXBfb3Blbi5pc3JhLjArMHgzZTcvMHgxNWIwDQo+ID4gPiA+ID4g
wqAgb3Blbl9sYXN0X2xvb2t1cHMrMHg4NWQvMHgxMjYwDQo+ID4gPiA+ID4gwqAgcGF0aF9vcGVu
YXQrMHgxNTEvMHg3YjANCj4gPiA+ID4gPiDCoCBkb19maWxwX29wZW4rMHgxZTAvMHgzMTANCj4g
PiA+ID4gPiDCoCBkb19zeXNfb3BlbmF0MisweDE3OC8weDFmMA0KPiA+ID4gPiA+IMKgIGRvX3N5
c19vcGVuKzB4YTIvMHgxMDANCj4gPiA+ID4gPiDCoCBfX3g2NF9zeXNfb3BlbmF0KzB4YTgvMHgx
MjANCj4gPiA+ID4gPiDCoCB4NjRfc3lzX2NhbGwrMHgyNTA3LzB4NDU0MA0KPiA+ID4gPiA+IMKg
IGRvX3N5c2NhbGxfNjQrMHhhNy8weDI0MA0KPiA+ID4gPiA+IMKgIGVudHJ5X1NZU0NBTExfNjRf
YWZ0ZXJfaHdmcmFtZSsweDc2LzB4N2UNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAuLi4NCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBBbGxvY2F0ZWQgYnkgdGFzayA3Njc6DQo+ID4gPiA+ID4gwqAga2Fz
YW5fc2F2ZV9zdGFjaysweDNiLzB4NzANCj4gPiA+ID4gPiDCoCBrYXNhbl9zYXZlX3RyYWNrKzB4
MWMvMHg0MA0KPiA+ID4gPiA+IMKgIGthc2FuX3NhdmVfYWxsb2NfaW5mbysweDQ0LzB4NzANCj4g
PiA+ID4gPiDCoCBfX2thc2FuX3NsYWJfYWxsb2MrMHhhZi8weGMwDQo+ID4gPiA+ID4gwqAga21l
bV9jYWNoZV9hbGxvY19ub3Byb2YrMHgxZTAvMHg0ZjANCj4gPiA+ID4gPiDCoCBycGNfbmV3X3Rh
c2srMHhlNy8weDIyMA0KPiA+ID4gPiA+IMKgIHJwY19ydW5fdGFzaysweDI3LzB4N2QwDQo+ID4g
PiA+ID4gwqAgbmZzNF9ydW5fb3Blbl90YXNrKzB4NDc3LzB4ODEwDQo+ID4gPiA+ID4gwqAgX25m
czRfcHJvY19vcGVuKzB4YzAvMHg2ZDANCj4gPiA+ID4gPiDCoCBfbmZzNF9vcGVuX2FuZF9nZXRf
c3RhdGUrMHgxNzgvMHhjNTANCj4gPiA+ID4gPiDCoCBfbmZzNF9kb19vcGVuLmlzcmEuMCsweDQ3
Zi8weDEzODANCj4gPiA+ID4gPiDCoCBuZnM0X2RvX29wZW4rMHgyOGIvMHg2MjANCj4gPiA+ID4g
PiDCoCBuZnM0X2F0b21pY19vcGVuKzB4MmM2LzB4M2EwDQo+ID4gPiA+ID4gwqAgbmZzX2F0b21p
Y19vcGVuKzB4NGY4LzB4MTE4MA0KPiA+ID4gPiA+IMKgIGF0b21pY19vcGVuKzB4MTg2LzB4NGUw
DQo+ID4gPiA+ID4gwqAgbG9va3VwX29wZW4uaXNyYS4wKzB4M2U3LzB4MTViMA0KPiA+ID4gPiA+
IMKgIG9wZW5fbGFzdF9sb29rdXBzKzB4ODVkLzB4MTI2MA0KPiA+ID4gPiA+IMKgIHBhdGhfb3Bl
bmF0KzB4MTUxLzB4N2IwDQo+ID4gPiA+ID4gwqAgZG9fZmlscF9vcGVuKzB4MWUwLzB4MzEwDQo+
ID4gPiA+ID4gwqAgZG9fc3lzX29wZW5hdDIrMHgxNzgvMHgxZjANCj4gPiA+ID4gPiDCoCBkb19z
eXNfb3BlbisweGEyLzB4MTAwDQo+ID4gPiA+ID4gwqAgX194NjRfc3lzX29wZW5hdCsweGE4LzB4
MTIwDQo+ID4gPiA+ID4gwqAgeDY0X3N5c19jYWxsKzB4MjUwNy8weDQ1NDANCj4gPiA+ID4gPiDC
oCBkb19zeXNjYWxsXzY0KzB4YTcvMHgyNDANCj4gPiA+ID4gPiDCoCBlbnRyeV9TWVNDQUxMXzY0
X2FmdGVyX2h3ZnJhbWUrMHg3Ni8weDdlDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gRnJlZWQgYnkg
dGFzayA3Njc6DQo+ID4gPiA+ID4gwqAga2FzYW5fc2F2ZV9zdGFjaysweDNiLzB4NzANCj4gPiA+
ID4gPiDCoCBrYXNhbl9zYXZlX3RyYWNrKzB4MWMvMHg0MA0KPiA+ID4gPiA+IMKgIGthc2FuX3Nh
dmVfZnJlZV9pbmZvKzB4NDMvMHg4MA0KPiA+ID4gPiA+IMKgIF9fa2FzYW5fc2xhYl9mcmVlKzB4
NGYvMHg5MA0KPiA+ID4gPiA+IMKgIGttZW1fY2FjaGVfZnJlZSsweDE5OS8weDRmMA0KPiA+ID4g
PiA+IMKgIG1lbXBvb2xfZnJlZV9zbGFiKzB4MWYvMHgzMA0KPiA+ID4gPiA+IMKgIG1lbXBvb2xf
ZnJlZSsweGRmLzB4M2QwDQo+ID4gPiA+ID4gwqAgcnBjX2ZyZWVfdGFzaysweDEyZC8weDE4MA0K
PiA+ID4gPiA+IMKgIHJwY19maW5hbF9wdXRfdGFzaysweDEwZS8weDE1MA0KPiA+ID4gPiA+IMKg
IHJwY19kb19wdXRfdGFzaysweDYzLzB4ODANCj4gPiA+ID4gPiDCoCBycGNfcHV0X3Rhc2srMHgx
OC8weDMwDQo+ID4gPiA+ID4gwqAgbmZzNF9ydW5fb3Blbl90YXNrKzB4NGY0LzB4ODEwDQo+ID4g
PiA+ID4gwqAgX25mczRfcHJvY19vcGVuKzB4YzAvMHg2ZDANCj4gPiA+ID4gPiDCoCBfbmZzNF9v
cGVuX2FuZF9nZXRfc3RhdGUrMHgxNzgvMHhjNTANCj4gPiA+ID4gPiDCoCBfbmZzNF9kb19vcGVu
LmlzcmEuMCsweDQ3Zi8weDEzODANCj4gPiA+ID4gPiDCoCBuZnM0X2RvX29wZW4rMHgyOGIvMHg2
MjANCj4gPiA+ID4gPiDCoCBuZnM0X2F0b21pY19vcGVuKzB4MmM2LzB4M2EwDQo+ID4gPiA+ID4g
wqAgbmZzX2F0b21pY19vcGVuKzB4NGY4LzB4MTE4MA0KPiA+ID4gPiA+IMKgIGF0b21pY19vcGVu
KzB4MTg2LzB4NGUwDQo+ID4gPiA+ID4gwqAgbG9va3VwX29wZW4uaXNyYS4wKzB4M2U3LzB4MTVi
MA0KPiA+ID4gPiA+IMKgIG9wZW5fbGFzdF9sb29rdXBzKzB4ODVkLzB4MTI2MA0KPiA+ID4gPiA+
IMKgIHBhdGhfb3BlbmF0KzB4MTUxLzB4N2IwDQo+ID4gPiA+ID4gwqAgZG9fZmlscF9vcGVuKzB4
MWUwLzB4MzEwDQo+ID4gPiA+ID4gwqAgZG9fc3lzX29wZW5hdDIrMHgxNzgvMHgxZjANCj4gPiA+
ID4gPiDCoCBkb19zeXNfb3BlbisweGEyLzB4MTAwDQo+ID4gPiA+ID4gwqAgX194NjRfc3lzX29w
ZW5hdCsweGE4LzB4MTIwDQo+ID4gPiA+ID4gwqAgeDY0X3N5c19jYWxsKzB4MjUwNy8weDQ1NDAN
Cj4gPiA+ID4gPiDCoCBkb19zeXNjYWxsXzY0KzB4YTcvMHgyNDANCj4gPiA+ID4gPiDCoCBlbnRy
eV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Ni8weDdlDQo+ID4gPiA+IA0KPiA+ID4gPiBP
bmNlIEkgYXBwbHkgdGhpcyBwYXRjaCBJJ20gc2VlaW5nIG15IGNsaWVudCBoYW5nIHdoZW4gcnVu
bmluZyANCj4gPiA+ID4geGZzdGVzdHMgZ2VuZXJpYy80NTEgd2l0aCBORlMgdjQuMC4gSSB3YXMg
d29uZGVyaW5nIGlmIHlvdQ0KPiA+ID4gPiBjb3VsZCANCj4gPiA+ID4gY2hlY2sgaWYgeW91IHNl
ZSB0aGUgc2FtZSBoYW5nLCBhbmQgcGxlYXNlIGZpeCBpdCBpZiBzbz8NCj4gPiA+ID4gDQo+ID4g
PiANCj4gPiA+IEkgaGF2ZSB0cnkgdG8gcmVwcm9kdWNlIHRoaXMgd2l0aCBrZXJuZWwgY29tbWl0
Og0KPiA+IA0KPiA+IEZvcmdldCB0byBzYXksIGFkZCB0aGlzIHBhdGNoIHRvby4uLg0KPiA+IA0K
PiA+ID4gDQo+ID4gPiBjb21taXQgYWJmMjA1MGY1MWZkY2EwZmQxNDYzODhmODNjZGRkOTVhNTdh
MDA4ZA0KPiA+ID4gTWVyZ2U6IDlhYjI3YjAxODY0OSA4MWVlNjJlOGQwOWUNCj4gPiA+IEF1dGhv
cjogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiA+ID4g
RGF0ZTrCoMKgIE1vbiBTZXAgMjMgMTU6Mjc6NTggMjAyNCAtMDcwMA0KPiA+ID4gDQo+ID4gPiDC
oMKgwqDCoCBNZXJnZSB0YWcgJ21lZGlhL3Y2LjEyLTEnIG9mIA0KPiA+ID4gZ2l0Oi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21jaGVoYWIvbGludXgtbWVkaWENCj4g
PiA+IA0KPiA+ID4gQW5kIGZvciBuZnM0LjAvbmZzNC4xLCBhbGwgc2VlbXMgb2sgbm93Li4uDQo+
ID4gPiANCj4gPiA+IENhbiB5b3UgcHJvdmlkZSBtb3JlIGluZm8gYWJvdXQgdGhlICdoYW5nJyB5
b3UgbWVldCBub3c/DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gPiBUaGFua3MsDQo+ID4gPiA+IEFu
bmENCj4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gRml4ZXM6IDI0YWMyM2FiODhkZiAo
Ik5GU3Y0OiBDb252ZXJ0IG9wZW4oKSBpbnRvIGFuDQo+ID4gPiA+ID4gYXN5bmNocm9ub3VzIFJQ
QyANCj4gPiA+ID4gPiBjYWxsIikNCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIEVya3Vu
IDx5YW5nZXJrdW5AaHVhd2VpLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiDCoCBmcy9u
ZnMvbmZzNHByb2MuYyB8IDEgKw0KPiA+ID4gPiA+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNHBy
b2MuYyBiL2ZzL25mcy9uZnM0cHJvYy5jDQo+ID4gPiA+ID4gaW5kZXggYjhmZmJlNTJiYTE1Li40
Njg1NjIxYmE0NjkgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZnMvbmZzL25mczRwcm9jLmMNCj4g
PiA+ID4gPiArKysgYi9mcy9uZnMvbmZzNHByb2MuYw0KPiA+ID4gPiA+IEBAIC0yNjAzLDYgKzI2
MDMsNyBAQCBzdGF0aWMgdm9pZCBuZnM0X29wZW5fcmVsZWFzZSh2b2lkDQo+ID4gPiA+ID4gKmNh
bGxkYXRhKQ0KPiA+ID4gPiA+IMKgwqDCoMKgwqAgc3RydWN0IG5mczRfb3BlbmRhdGEgKmRhdGEg
PSBjYWxsZGF0YTsNCj4gPiA+ID4gPiDCoMKgwqDCoMKgIHN0cnVjdCBuZnM0X3N0YXRlICpzdGF0
ZSA9IE5VTEw7DQo+ID4gPiA+ID4gK8KgwqDCoCBuZnNfcmVsZWFzZV9zZXFpZChkYXRhLT5vX2Fy
Zy5zZXFpZCk7DQo+ID4gPiA+ID4gwqDCoMKgwqDCoCAvKiBJZiB0aGlzIHJlcXVlc3QgaGFzbid0
IGJlZW4gY2FuY2VsbGVkLCBkbyBub3RoaW5nICovDQo+ID4gPiA+ID4gwqDCoMKgwqDCoCBpZiAo
IWRhdGEtPmNhbmNlbGxlZCkNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXRf
ZnJlZTsNCj4gDQoNCklmIHRoZSBPUEVOIHdhcyBzdWNjZXNzZnVsLCBidXQgYXNrZWQgdXMgdG8g
Y29uZmlybSB0aGUgc2VxdWVuY2UgaWQsIHdlDQpjYW4gZW5kIHVwIHJlbGVhc2luZyB0aGUgc2Vx
dWVuY2UgYmVmb3JlIHdlJ3ZlIGJlZW4gYWJsZSB0byBjYWxsDQpvcGVuX2NvbmZpcm0gaWYgd2Ug
ZG8gdGhlIGFib3ZlLiBJIHN1c3BlY3QgdGhpcyBpcyB3aHkgQW5uYSBpcyBzZWVpbmcNCnRoZSBo
YW5nIHdoZW4gcnVubmluZyB4ZnN0ZXN0cy4NCg0KSSB0aGluayB3ZSByYXRoZXIgd2FudCB0byBj
aGVjayBpZiAodGFzay0+dGtfc3RhdHVzICE9IDAgJiYgIWRhdGEtDQo+cnBjX2RvbmUpIGJlZm9y
ZSBjYWxsaW5nIG5mc19yZWxlYXNlX3NlcWlkKCkgYWJvdmUsIHNpbmNlIHRoYXQgbWlnaHQNCmNv
cnJlc3BvbmQgdG8gdGhlIGNhc2Ugd2hlcmUgd2UgaW50ZXJydXB0ZWQgdGhlIFJQQyBjYWxsIGJl
Zm9yZSBpdCBnZXRzDQp0byB0aGUgZnJvbnQgb2YgdGhlIGxpc3QsIGJ1dCB3aWxsIG5ldmVyIGNv
cnJlc3BvbmQgdG8gdGhlIGNhc2Ugd2hlcmUNCndlIG5lZWQgdG8gY29uZmlybSB0aGUgc2VxdWVu
Y2UuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIs
IEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

