Return-Path: <linux-nfs+bounces-8631-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141DB9F517D
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 18:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 779457A39DE
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 17:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326181F76DF;
	Tue, 17 Dec 2024 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="K4Xj8W1d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2093.outbound.protection.outlook.com [40.107.94.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365371F76B2;
	Tue, 17 Dec 2024 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734454810; cv=fail; b=qu02XctOFXMVdI1f6lQnKRYDJywF5R6SJSd6pQOpfl5hc03WV7xE+VrgRl/ivOvPbeHvy100gf57etgY0LByommoPkgHCHxWpcrnfXvi6ZEcMU2q5nyno4goYfiogTALAVFFqz5eCYS721wih1YlrY3tI4wav4GgQizLFcHYyy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734454810; c=relaxed/simple;
	bh=qfPUjCV3Pt2t/u+NrSoPttVAu3yzHCPNANVt5+v+OPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FaQ5+G4FRt5fewT7UGJJ+cp9XQ7p7Sayps419htKwpZi188UQC0ILJhQMjXx68FosUMQSUdNqlOnvwMx3Vh210NTqGeyKk5cmiwqv50YpZJKayItG/xJ+nRmgOM+W0c+gDMkU9Cr/4PEAuiqmHHQPtKTYbZKvOmw2mrmJkFLJvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=K4Xj8W1d; arc=fail smtp.client-ip=40.107.94.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nn1qIbPWczut4RKGjpI8/vNFXzKA5nuhycJDPPTHgAmzjrGlQpjfqWlqmW9Ho2V7Zw/Y4FR4RA2bV7W+X8dTAbM65pgDsz7qJIVaM6Yjmy01B4ocZAst1KSQmQV9q6BSi4KsSXhHJ+D0XtV2+mz3kFLyXbkDmGGL2TuFHJSp77mRcSOGXyGMmb3pfUAXpmDRAduh7+6FdfDe8Bzhxk3dbe6J5Vmf9P5Fs3t/AORIg9ieqMVGZk7sJLbu0nrvJAV9EY/MV1pqGm6eBL/g4HkLKR8hhGgQVWV73beXkaQIbH8M4AIQvqzPbIRmkM9M6G3inyNVxHsDhaa4F6G/xvzzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfPUjCV3Pt2t/u+NrSoPttVAu3yzHCPNANVt5+v+OPA=;
 b=FHM6g8Jt2KfO2ZPS54K9t8d57ldKr/qIYf0kBy52Jgovm5DWI5VoicyjOE0mLf/IrDOFPIIDSxJWfMfKbLULzSkSH1ZQbd2RVi4SdhD9RSFTM9hKLz0Quz9pTcNslqlBa+Abgle9btU3GlK3SNpD6YPaH8y38whFtefHoeP2Q1ACGAn48Q4zMRIJjW4vKtgHkzBe9KI5jyykBtedZ/oqVfwGv2Y62O6yYmH7qG6r88OaNIxuQWxKNfW7Yn6kFIX4q0g8EqYe2R7yWwg+SPJH8jT9jj39D1xfvZZV9i9b8smEHgxMd8XLW4XKgNy7Vi0xEoJ2T104LYWaWQ8fyhSZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfPUjCV3Pt2t/u+NrSoPttVAu3yzHCPNANVt5+v+OPA=;
 b=K4Xj8W1dXnpZM8nt1ESx9S0WNWgt23MsYn8H0RQhg7DKMR5kiLeaG1waF9CoXpDVQ9uOK+8MPocyj9qa4huZOd+bs3bEMTuXcSQ+SZgvWQ8w61ESim9GrzzsLUZncTJbWylru1zjurLwcUJoOcKY8jqrzIa1LESzfubnNqZzEzY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB6779.namprd13.prod.outlook.com (2603:10b6:806:3ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 17:00:04 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 17:00:03 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "lilingfeng3@huawei.com"
	<lilingfeng3@huawei.com>
CC: "houtao1@huawei.com" <houtao1@huawei.com>, "yukuai1@huaweicloud.com"
	<yukuai1@huaweicloud.com>, "yangerkun@huawei.com" <yangerkun@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lilingfeng@huaweicloud.com" <lilingfeng@huaweicloud.com>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "yi.zhang@huawei.com" <yi.zhang@huawei.com>
Subject: Re: [PATCH] NFSv4: Fix deadlock during the running of state manager
Thread-Topic: [PATCH] NFSv4: Fix deadlock during the running of state manager
Thread-Index: AQHbTRGEJW16+QWXH02QZeyxPdB9YrLqsBYA
Date: Tue, 17 Dec 2024 17:00:03 +0000
Message-ID: <baa76c7946676fccafb1dbf658905a0ab3e3bdec.camel@hammerspace.com>
References: <20241213035908.1789132-1-lilingfeng3@huawei.com>
In-Reply-To: <20241213035908.1789132-1-lilingfeng3@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA1PR13MB6779:EE_
x-ms-office365-filtering-correlation-id: d42b5413-3554-4385-edeb-08dd1ebc4059
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Vk5NdDVVTFlyNm9hUHRyR2d3Rm5qYldrUEROajluRENuQ2tTcWx2bU0yTFJQ?=
 =?utf-8?B?VHg2aldDdHBmYXhMQzVBeVlJWFVvNVlXZnVlTGlrc2pLNkVOek1FYnA5ZEVr?=
 =?utf-8?B?ZENOU1NmT05kaFFqTzd5R0dxUE9NZVpOM2p2UXAvMnB1ZUlaSGtoMU9WWGFq?=
 =?utf-8?B?cjB0TDlCSDMvNDRQVmJqWkFnLzJTODZHNHJ5azBJSm9HTzIyZzhURHFSbGFa?=
 =?utf-8?B?S1RRaVFvSGdEb0Vhc1EyWW1Ib1VTUmhzRkJ1TmZ2d0s0d1lCbWE4cW1ncG1C?=
 =?utf-8?B?RGFURzVmWENVZmhmZzlMV0FIMlExME5HekxpejVWMk51V0J0WXRWb3l1cHB5?=
 =?utf-8?B?V3cxS0lyVlBQZUNkNlppVXJBeTAxdkRPelU1aUpWNVNBSUlVcnFRdndtVE1C?=
 =?utf-8?B?elcrRVRUd2ZSeEJ5M3A1RFJaTmJQUjA3aGtQZmhhNmxRR0JMVlFEVVphNXNm?=
 =?utf-8?B?UVRQcjhLSjdzQVN2Rjhrakk1c3QwVlduaDFlT2pzSnJpUXFJM0p3MUdyZVAz?=
 =?utf-8?B?M1Rub2g2T0dqcGd0VnoyU1pZSEthSENHenZRcU9YWDVLUU5pM0lSSnlEOGRU?=
 =?utf-8?B?alZRTzBBekk4YWtSaU4vdGFpaFpBTXh2NWk0b3g4YjhpdWwvdm9JRlpoSGJ3?=
 =?utf-8?B?MG5Mb3JuQU5jUmpVKzRXMURXSlVrdmFGdFlUVE0rN0pYdE5WUTcvWGF0WEQx?=
 =?utf-8?B?K2YrVW5sWFREZWVjaHhwMXY5M0I1U2c0ZXo3U0JXNnoxSUZMSnlrZytjbW0r?=
 =?utf-8?B?M2x2UkRuM1orWEVHTFAzcUdwSnhXQUtMUUl4QitZczRSTSt0YnFZamRaODJn?=
 =?utf-8?B?bElkYmxHN0VTUjhoT09KbGFmNG9uNFJ0UzhsMjExQkJUY0VwTE5qVFp4ZkFP?=
 =?utf-8?B?cE9vY3RUb1FSR1Q5bFc4M1hIeHJJc0Z3RTZLdHN5dGRqTnVMSDN4dkxmYW9p?=
 =?utf-8?B?UFlLc24xN011L04rVUJyRUs5UEFNak1RaHNNaE1zWDVMdFZNVUV2cmVZVmFQ?=
 =?utf-8?B?aS82Z2hZejFjenpibzFMVGozUUlQQWd2KzdVUHdnU1R1d1kvcTUzTUNoVzVt?=
 =?utf-8?B?OEVEeGVVbkoyTk5WR05NRWVwSjNZRHdnSUYrWWpWSDZkYUFJL0Y5TjlXVlk5?=
 =?utf-8?B?TkFXMTFXd29FNkpjWmR6OXVBQ0txdE5OenFGdVhaazl1MnNucERyVHBsdnBq?=
 =?utf-8?B?OER6SVNmY01DQ25LQkdpY0psbWQ3N0ljTFhRdmdrRnVHL2FWb0t3NFJoV1NR?=
 =?utf-8?B?dDlJdFpiSDlCdE9YMHNkUXhnZzI0ZmpybU5hOG1OZ1ZuMERlYVJrVWF3SGVi?=
 =?utf-8?B?Q21RT3d0S0JJbmZYc0Z2N1lZVkxPOFZWMSt4NE1zUVA1aks3UkRwVTY5TnIr?=
 =?utf-8?B?MGp4bitFMW1EQVZoV09TUHZYMW1HaUkxaXlWN3ROQkJySGFNYWZqR1dsNEhr?=
 =?utf-8?B?S3lOZlFGcWNML2wxYWZnbEZUM1B5UlVUVkFuNVlwT1ZMTWQvWU9CMC9Fa2hx?=
 =?utf-8?B?Y0o3MncvdUJYVmVPbzNpTWdYK1YvdUNmQVp5cTlYaC9WaDZyeE81UlgzMGNs?=
 =?utf-8?B?SzUwT0ZlaEpQLzhBOGc3QzhtUjk1b0dMUmlPZVlyYjlqRlF6VDlUNTNKMXJs?=
 =?utf-8?B?T3BoeWJsbmRiMWIvOVk4TThITWZnYUpkdklxbUs2amcySDZhaXgzU1JCdGV2?=
 =?utf-8?B?WFdqZ0ltWTdGRjNjQ3VmWVZNY1JJZS9yekt1dlArM29FZWxjQTNQdXcxdkpV?=
 =?utf-8?B?ZnVodHRLMXlkSlh1dFRZTFlzOGRnVWxoTWdPSDhRZitZUk5QYmc1UzZmcWhj?=
 =?utf-8?B?N3l6dC9vMXB4TWkvUy9CKzh5QmFYUVZSREs3L2l0WnBSdzUxNkdONFpLTmZq?=
 =?utf-8?B?b01DcXJ5d1Q1REM2ME5kRytDN2VGVFUzbkRXUS95T0o2Q2Z4bFFneEVsT3ZE?=
 =?utf-8?Q?k8J3e+LudLw7lqOgBOyvSNDvCo3pHmRp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTdpZk4yT1B3ZElSeHQ0NTNQU3dQQmdGNkJZcGhwYjRqNmlsejdCMnZ2S0R2?=
 =?utf-8?B?VkVmRjBCY0dOaHcwS3pWcjNUUUw2ZHRIMUplMzkreHRGNVRsNGszczNyOFA0?=
 =?utf-8?B?M3luVlBWR0M1Um8zL1BMdDFIT0RKbVBNcnBwcWNacHJHQjVYbStLTWVXRkJy?=
 =?utf-8?B?aFRLT2JGZERRQ0I0aDRYajFmRGcyQkhxZWRBaFZQY3RZaVFUSGJhNE1vTVVP?=
 =?utf-8?B?ZE5NMWVlSzJkTHQ5L3ZyNjUvV21OMG8rZFNLb2RpVnJvNG45TkNlUERCZlF1?=
 =?utf-8?B?UEhhRUVZbmlPcEJqZG1LSC9mdkhZZFVxZHlvYmh1NERJS0NtTjZ6RFVrRnFi?=
 =?utf-8?B?VVpRV3lmNUNIS3JCQlpYa0lpdElLRjluY00yVjd1cENkQytYRzdKRlA5TFc4?=
 =?utf-8?B?cTVNYVY3NlZSZm5YNUlueHFlQW1DOUxWZmlBMS9qWnV1Snd1WEpVQ3ZQaFhs?=
 =?utf-8?B?TnRFV1VGWCtRNldtZFN0S2VXUFJWc2psb3JYb2s2QTNEelNFMnYrTndobkVN?=
 =?utf-8?B?WjVIZEhXaThtcUg0dVFHTm1RdmkwWUJFLzNPSStKcVN2clF4Y3FPaWlQUVV2?=
 =?utf-8?B?ZlA0VHNjYURUK1NqazByVThudm16RnNybS84UHNtNlplbVcyZWFpUmJqUUI4?=
 =?utf-8?B?a3Z2L1VJRmVVQlE3OFowZTlUUkVNNzU1REUzcStUencxTGNZSURDZ09yd1lo?=
 =?utf-8?B?VzlQa2RPSlZPQUpqNW0vRjJ4b3NxK0hXSnJKY3YxQzNtWjlhTnhkc09qSitZ?=
 =?utf-8?B?Kzg2aWo3aFdwMEhhYzRKQUZqLzJMSHFTZ0I5L01SNll0dXJPOWlhRVdXOXp5?=
 =?utf-8?B?c0oyQkRkWG56M290VWIySHhsWWp6aUxDYnZLNExGdGNhY3l5T1p5QldGWVY2?=
 =?utf-8?B?SUNuMU1XTWpLeGZoMHhkMzBveldDSHZJNnc4RCtmcVM2cG5TNlFXQitGdWM1?=
 =?utf-8?B?S04xcFhqZzBWeFNVcjk1R1BFelRoREZhRjFCdHJqaHRKQXhhVEpLWWY1Nmo1?=
 =?utf-8?B?M1BRdnlkdktsUFVlZGhHUzJMU29VdWJ5cW52ZCtCcVp1T0Z2alVTS0JuTUJH?=
 =?utf-8?B?Sms1d0FxblBaamZqdG5MS0lqL0NrTUpZWFYzeTA4STRHTnJPL2dXZXd0MU9t?=
 =?utf-8?B?QWJLLzJnU0NQb1drWlNCWlZTNU5UUCtPbngvalVrbzgvVzNkanVTM01KMzBN?=
 =?utf-8?B?NVZhOWpKdWtVS2lOZnhzNmJuNG9EVHc2bmU1cmwvU1BOak5hc1BzZ1p4YzQ5?=
 =?utf-8?B?R0FhYkNNYlpIRUhhZDBRWWNsWFdYV08rdkhvYWNpNDJibW9RcGEvL2N5ZW84?=
 =?utf-8?B?ZVpGc0l5OFc1bzkrdVRkMmpWa2RFekgwak5MRVlWZVVNQmE2OTRFTERUZElz?=
 =?utf-8?B?SnlrMU8ycExiYzBuaUZTS253Wm5PY0hPV3kveHk1ZjhQc2tMODUyd1NiZTJL?=
 =?utf-8?B?eWhTT1M0ZWk1aHBESk5Idzh4RUNkc0dOSTlTOUdjQ0ZNN2w5Yi94ZWZsczFx?=
 =?utf-8?B?dDZTRG9vbnRCT09TK1VLMVJtcW04aFptNmRGeU0rUTV5OGs3WXFPUktGWEFs?=
 =?utf-8?B?aXMyMVV5eXM2L3lZeERMTEsyM1RSNy9yWTc5R0IxVUpwclJ2UWEyMnNObjg0?=
 =?utf-8?B?VEZmZnh4bVBRMnlXNFdkakJWa2hxWUVqUVExdkpkSWdrUkd1ckRqUk9PWVQx?=
 =?utf-8?B?d3lXdFZiWHpQZlRyN0Z0c280TFZvSjBJWTdwdHI1QjkrcFRTZFU5S0JTTXZs?=
 =?utf-8?B?b1l3R0dMc3F5K2kwSEtuTjJpTG43cHNZUXFhNlBVVUxHVklRRUg1YUpMc1FR?=
 =?utf-8?B?eXNKdURPZm1QQVYvSFJ3aTRLY2RLNVMyTmRoamRMTWVKa1V0a0NOeWhiQU45?=
 =?utf-8?B?Mllyc0VHTktpN0lDWmVmRld2SVN1WFVyN1hpSExIYkNlWW5NYmNUM2tFbWI4?=
 =?utf-8?B?MVlFcGt4OHZ5dVAzRVdmODkxWVZQRjNONzcyWmhLdm5Wb0hIZU9nL2hQbEdK?=
 =?utf-8?B?dDVSaGtab2JxL3BVTFNMWXV5NGdiNHFVbmYrbHQ3cFZ1STl0Z291Y05qWXF2?=
 =?utf-8?B?c2Jod0FIeHQ0UTZXc2hsZ0pXZ0hwRFN5S1VlS2VaSUJqNHp4VHVnUFVHWVNR?=
 =?utf-8?B?RWpGZGRya2JVN0piRVB2alFtOG9oNk40bUJTbVVnSCs1K1YydDVWM2FZYVh1?=
 =?utf-8?B?MkhqSFhCaXZQUTh2UUxpcW5IZUZEYWxZOW1aY2tPOCs4OXdTZFdtaXB5ajBs?=
 =?utf-8?B?T2trdkhSTi9QdkpncExSeG84eXd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <440FCAE52847A14781016E6C2EC67A62@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d42b5413-3554-4385-edeb-08dd1ebc4059
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 17:00:03.8452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aorYfDEc6QfrfEkGSjxw1hZCQCm4h+5QQ76199IqU0kjkffEuh3aRyOnnLN4/umHfiBilJWz2IZwdq24zcoLIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB6779

T24gRnJpLCAyMDI0LTEyLTEzIGF0IDExOjU5ICswODAwLCBMaSBMaW5nZmVuZyB3cm90ZToNCj4g
VW5saW5raW5nIGZpbGUgbWF5IGNhdXNlIHRoZSBmb2xsb3dpbmcgZGVhZGxvY2sgaW4gc3RhdGUg
bWFuYWdlcjoNCj4gW3Jvb3RAbG9jYWxob3N0IHRlc3RdIyBjYXQgL3Byb2MvMjk0My9zdGFjaw0K
PiBbPDA+XSBycGNfd2FpdF9iaXRfa2lsbGFibGUrMHgxYS8weDkwDQo+IFs8MD5dIF9uZnM0X3By
b2NfZGVsZWdyZXR1cm4rMHg2MGYvMHg3NjANCj4gWzwwPl0gbmZzNF9wcm9jX2RlbGVncmV0dXJu
KzB4MTNkLzB4MmEwDQo+IFs8MD5dIG5mc19kb19yZXR1cm5fZGVsZWdhdGlvbisweGJhLzB4MTEw
DQo+IFs8MD5dIG5mc19lbmRfZGVsZWdhdGlvbl9yZXR1cm4rMHgzMmMvMHg2MjANCj4gWzwwPl0g
bmZzX2NvbXBsZXRlX3VubGluaysweGM3LzB4MjkwDQo+IFs8MD5dIG5mc19kZW50cnlfaXB1dCsw
eDM2LzB4NTANCj4gWzwwPl0gX19kZW50cnlfa2lsbCsweGFhLzB4MjUwDQo+IFs8MD5dIGRwdXQu
cGFydC4wKzB4MjZjLzB4NGQwDQo+IFs8MD5dIF9fcHV0X25mc19vcGVuX2NvbnRleHQrMHgxZDkv
MHgyNjANCj4gWzwwPl0gbmZzNF9vcGVuX3JlY2xhaW0rMHg3Ny8weGEwDQo+IFs8MD5dIG5mczRf
ZG9fcmVjbGFpbSsweDM4NS8weGY0MA0KPiBbPDA+XSBuZnM0X3N0YXRlX21hbmFnZXIrMHg3NjIv
MHgxNGUwDQo+IFs8MD5dIG5mczRfcnVuX3N0YXRlX21hbmFnZXIrMHgxODEvMHgzMzANCj4gWzww
Pl0ga3RocmVhZCsweDFhNy8weDFmMA0KPiBbPDA+XSByZXRfZnJvbV9mb3JrKzB4MzQvMHg2MA0K
PiBbPDA+XSByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzANCj4gW3Jvb3RAbG9jYWxob3N0IHRl
c3RdIw0KPiANCj4gSXQgY2FuIGJlIHJlcHJvZHVjZWQgYnkgZm9sbG93aW5nIHN0ZXBzOg0KPiAx
KSBjbGllbnQ6IG9wZW4gZmlsZQ0KPiAyKSBjbGllbnQ6IHVubGluayBmaWxlDQo+IDMpIHNlcnZl
cjogc2VydmljZSByZXN0YXJ0KHRyaWdnZXIgc3RhdGUgbWFuYWdlciBpbiBjbGllbnQpDQo+IDQp
IGNsaWVudDogY2xvc2UgZmlsZShpbiBuZnM0X29wZW5fcmVjbGFpbSwgYmV0d2Vlbg0KPiBuZnM0
X2RvX29wZW5fcmVjbGFpbQ0KPiBhbmQgcHV0X25mc19vcGVuX2NvbnRleHQpDQo+IA0KPiBTaW5j
ZSB0aGUgZmlsZSBoYXMgYmVlbiBvcGVuLCB1bmxpbmtpbmcgd2lsbCBqdXN0IHNldA0KPiBEQ0FD
SEVfTkZTRlNfUkVOQU1FRA0KPiBmb3IgdGhlIGRlbnRyeSBsaWtlIHRoaXM6DQo+IG5mc191bmxp
bmsNCj4gwqBuZnNfc2lsbHlyZW5hbWUNCj4gwqAgbmZzX2FzeW5jX3VubGluaw0KPiDCoMKgIC8v
IHNldCBEQ0FDSEVfTkZTRlNfUkVOQU1FRA0KPiANCj4gUmVzdGFydGluZyBzZXJ2aWNlIHdpbGwg
dHJpZ2dlciBzdGF0ZSBtYW5hZ2VyIGluIGNsaWVudC4NCj4gKDEpIE5GUzRfU0xPVF9UQkxfRFJB
SU5JTkcgd2lsbCBiZSBzZXQgdG8gbmZzNF9zbG90X3RhYmxlIHNpbmNlDQo+IHNlc3Npb24NCj4g
aGFzIGJlZW4gcmVzZXQuDQo+ICgyKSBEQ0FDSEVfTkZTRlNfUkVOQU1FRCBpcyBkZXRlY3RlZCBp
biBuZnNfZGVudHJ5X2lwdXQuIFRoZXJlZm9yZSwNCj4gbmZzX2NvbXBsZXRlX3VubGluayBpcyBj
YWxsZWQgdG8gdHJpZ2dlciBkZWxlZ2F0aW9uIHJldHVybi4NCj4gKDMpIER1ZSB0byB0aGUgc2xv
dCB0YWJsZSBiZWluZyBpbiBkcmFpbmluZyBzdGF0ZSBhbmQgc2FfcHJpdmlsZWdlZA0KPiBiZWlu
Zw0KPiAwLCB0aGUgZGVsZWdhdGlvbiByZXR1cm4gd2lsbCBiZSBxdWV1ZWQgYW5kIHdhaXQuDQo+
IG5mczRfc3RhdGVfbWFuYWdlcg0KPiDCoG5mczRfcmVzZXRfc2Vzc2lvbg0KPiDCoCBuZnM0X2Jl
Z2luX2RyYWluX3Nlc3Npb24NCj4gwqDCoCBuZnM0X2RyYWluX3Nsb3RfdGJsDQo+IMKgwqDCoCAv
LyBzZXQgTkZTNF9TTE9UX1RCTF9EUkFJTklORyAoMSkNCj4gwqBuZnM0X2RvX3JlY2xhaW0NCj4g
wqAgbmZzNF9vcGVuX3JlY2xhaW0NCj4gwqDCoCBfX3B1dF9uZnNfb3Blbl9jb250ZXh0DQo+IMKg
wqDCoCBfX2RlbnRyeV9raWxsDQo+IMKgwqDCoMKgIG5mc19kZW50cnlfaXB1dCAvLyBjaGVjayBE
Q0FDSEVfTkZTRlNfUkVOQU1FRCAoMikNCj4gwqDCoMKgwqDCoCBuZnNfY29tcGxldGVfdW5saW5r
DQo+IMKgwqDCoMKgwqDCoCBuZnNfZW5kX2RlbGVnYXRpb25fcmV0dXJuDQo+IMKgwqDCoMKgwqDC
oMKgIG5mc19kb19yZXR1cm5fZGVsZWdhdGlvbg0KPiDCoMKgwqDCoMKgwqDCoMKgIG5mczRfcHJv
Y19kZWxlZ3JldHVybg0KPiDCoMKgwqDCoMKgwqDCoMKgwqAgX25mczRfcHJvY19kZWxlZ3JldHVy
bg0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBycGNfcnVuX3Rhc2sNCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAuLi4NCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZnM0X2RlbGVncmV0dXJuX3By
ZXBhcmUNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5mczRfc2V0dXBfc2VxdWVuY2UNCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmZzNF9zbG90X3RibF9kcmFpbmluZyAvLyBjaGVj
ayBORlM0X1NMT1RfVEJMX0RSQUlOSU5HDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvLyBhbmQgc2FfcHJp
dmlsZWdlZCBpcyAwICgzKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJwY19zbGVl
cF9vbiAvLyBzZXQgcXVldWVkIGFuZCBhZGQgdG8gc2xvdF90Ymxfd2FpdHENCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8vIHJwY190YXNrIGlzIGFzeW5jIGFuZCB3YWl0IGluIF9f
cnBjX2V4ZWN1dGUNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgcnBjX3dhaXRfZm9yX2NvbXBsZXRp
b25fdGFzaw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fcnBjX3dhaXRfZm9yX2NvbXBsZXRp
b25fdGFzaw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3V0X29mX2xpbmVfd2FpdF9vbl9i
aXQNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcnBjX3dhaXRfYml0X2tpbGxhYmxlIC8v
IHdhaXQgZm9yIHJwY190YXNrIHRvIGNvbXBsZXRlDQo+IMKgPC0tLS0tLS0tIGNhbiBub3QgZ2V0
IGhlcmUgdG8gd2FrZSB1cCBycGNfdGFzayAtLS0tLS0tLT4NCj4gwqBuZnM0X2VuZF9kcmFpbl9z
ZXNzaW9uDQo+IMKgIG5mczRfZW5kX2RyYWluX3Nsb3RfdGFibGUNCj4gwqDCoCBuZnM0MV93YWtl
X3Nsb3RfdGFibGUNCj4gDQo+IE9uIHRoZSBvbmUgaGFuZCwgdGhlIHN0YXRlIG1hbmFnZXIgaXMg
YmxvY2tlZCBieSB0aGUgdW5maW5pc2hlZA0KPiBkZWxlZ2F0aW9uDQo+IHJldHVybi4gQXMgYSBy
ZXN1bHQsIG5mczRfZW5kX2RyYWluX3Nlc3Npb24gY2Fubm90IGJlIGludm9rZWQgdG8NCj4gY2xl
YXINCj4gTkZTNF9TTE9UX1RCTF9EUkFJTklORyBhbmQgd2FrZSB1cCB3YWl0aW5nIHRhc2tzLg0K
PiBPbiB0aGUgb3RoZXIgaGFuZCwgc2luY2UgTkZTNF9TTE9UX1RCTF9EUkFJTklORyBpcyBub3Qg
Y2xlYXJlZCwNCj4gZGVsZWdhdGlvbiByZXR1cm4gY2FuIG9ubHkgd2FpdCBpbiB0aGUgcXVldWUs
IHJlc3VsdGluZyBpbiBhDQo+IGRlYWRsb2NrLg0KPiANCj4gRml4IGl0IGJ5IHR1cm5pbmcgdGhl
IGRlbGVnYXRpb24gcmV0dXJuIGludG8gYSBwcml2aWxlZ2VkIG9wZXJhdGlvbg0KPiBmb3INCj4g
dGhlIGNhc2Ugd2hlcmUgdGhlIG5mc19jbGllbnQgaXMgaW4gTkZTNENMTlRfUkVDTEFJTV9SRUJP
T1Qgc3RhdGUuDQo+IA0KPiBGaXhlczogOTc3ZmNjMmIwYjQxICgiTkZTOiBBZGQgYSBkZWxlZ2F0
aW9uIHJldHVybiBpbnRvDQo+IG5mczRfcHJvY191bmxpbmtfc2V0dXAoKSIpDQo+IFNpZ25lZC1v
ZmYtYnk6IExpIExpbmdmZW5nIDxsaWxpbmdmZW5nM0BodWF3ZWkuY29tPg0KPiAtLS0NCj4gwqBm
cy9uZnMvbmZzNHByb2MuYyB8IDIgKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNHByb2MuYyBi
L2ZzL25mcy9uZnM0cHJvYy5jDQo+IGluZGV4IDQwNWYxN2U2ZTBiNC4uZjNiMWYyNzI1YzRlIDEw
MDY0NA0KPiAtLS0gYS9mcy9uZnMvbmZzNHByb2MuYw0KPiArKysgYi9mcy9uZnMvbmZzNHByb2Mu
Yw0KPiBAQCAtNjg3OCw3ICs2ODc4LDcgQEAgc3RhdGljIGludCBfbmZzNF9wcm9jX2RlbGVncmV0
dXJuKHN0cnVjdCBpbm9kZQ0KPiAqaW5vZGUsIGNvbnN0IHN0cnVjdCBjcmVkICpjcmVkLA0KPiDC
oAkJZGF0YS0+cmVzLnNhdHRyX3JlcyA9IHRydWU7DQo+IMKgCX0NCj4gwqANCj4gLQlpZiAoIWRh
dGEtPmlub2RlKQ0KPiArCWlmICghZGF0YS0+aW5vZGUgfHwgdGVzdF9iaXQoTkZTNENMTlRfUkVD
TEFJTV9SRUJPT1QsDQo+ICZzZXJ2ZXItPm5mc19jbGllbnQtPmNsX3N0YXRlKSkNCj4gwqAJCW5m
czRfaW5pdF9zZXF1ZW5jZSgmZGF0YS0+YXJncy5zZXFfYXJncywgJmRhdGEtDQo+ID5yZXMuc2Vx
X3JlcywgMSwNCj4gwqAJCQkJwqDCoCAxKTsNCj4gwqAJZWxzZQ0KDQpSYXRoZXIgdGhhbiBtYWtl
IHRoZSBkZWxlZ3JldHVybiBiZSBwcml2aWxlZ2VkLCBpdCBzZWVtcyBiZXR0ZXIgdG8gbWFrZQ0K
dGhhdCBkZWxlZ3JldHVybiBiZSBhc3luY2hyb25vdXMsIGp1c3QgbGlrZSB0aGUgdW5saW5rIGl0
c2VsZi4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5l
ciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

