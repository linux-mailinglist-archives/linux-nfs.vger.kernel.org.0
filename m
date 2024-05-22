Return-Path: <linux-nfs+bounces-3337-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4518CC4D8
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 18:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF6E2B2238A
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 16:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9107842AB9;
	Wed, 22 May 2024 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="S6OLvnN1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2107.outbound.protection.outlook.com [40.107.93.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDBB1411EB
	for <linux-nfs@vger.kernel.org>; Wed, 22 May 2024 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394824; cv=fail; b=e+uVaNIR0HA7uKc6HkUG29x26rHgH8M9by83buGOq5SPCqJ13GLd89wwMyoO9XKb/e9vfNJD3Q1l16UfMqUU4yIazyOWTw31M9aUdD2gpwIXd1L14AIHHThxmhathz5QIeh7vuhOA9YkQKHoeQrmhsHBRkQjc2wNSX5etON1Mt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394824; c=relaxed/simple;
	bh=MJyrp3TeDB1hm0oQHjYrl4PuaCStyq16GLU4waHlXeA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r1xRf5DtnbGBynwJnhgEX+nI0MuS50rAEXZ2sI+18grbDHHsFvGrk+szrTCowNuUsaCqgvR4b6zTHhGRVY3WyLZz41mnTe4p9H3KaZpJk4cv71Ie7pHDclfExDkR8FJECzneh4FGCoolQmWwcD5RL0jQQjVLVYpIGo48UNDEChk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=S6OLvnN1; arc=fail smtp.client-ip=40.107.93.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxKnB94p0BhWfJ2HCZSflkPjDCwcj8BFSQSlGDgwzGyZQAGTHYZ8UY4wqeC2pwxlAvO1oux0LsFHTA3Y6vjpzWhoiMPNLbaGyKU2Nai1toNf2qifvEpmXRGYc12XktfbPzG0Lt1gxAkpklpIBc20MM6EZyxYB+GvTvek4ng6os8/l2kDLufXSMF/PyVt1D65nSDtHxF1+6LdwO4tS4FTXjlNCDx90UvEoEVORnZPi7gIdZnfm+SmkE3Mp0t+3Kmex73GdqXj/SEUPgcT+gg79c9/Eo8sCkAlRpgeEdd3T/pPpOIyIP0aTsxSSI/0eAKggUGL3gWKDJMa2V7/6TxMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJyrp3TeDB1hm0oQHjYrl4PuaCStyq16GLU4waHlXeA=;
 b=E2rUoJLXthxOu5rw5SmjxWVHVbWUuqt/NQ02SjDDUxC6a8kNRlVLJKCYcIxNSaZi9GM9ylb+SsF8RG7A+h04s14TEvqKLXk5jCclEY3gTx6mGn+HammCHcm1How4xPnB86nJGSYuH03IDklWXKXT9IGQ/gIibWaWrHkRbvapxzRmrbG63PxYiNQOEGnf/i5W5kdrG4fkM4oWINonVlCMLF1VoSClPB2YPw2yhWPBrHY1pbN9vTlFycV7l6xVefo5L8HcLgVQ6wtNGFQEL/Byxe90Y1HOsITrGWajgmAK15RDizWcn2JMlOza6v/yCpxKaFEGUmjyOGZvy18p15VAzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJyrp3TeDB1hm0oQHjYrl4PuaCStyq16GLU4waHlXeA=;
 b=S6OLvnN1PV1qFyqNDmgnn8SZ2DtUHutiehocnVYgk8EH4AgrrFVNehWcpMfTEDr5+LYBE0okux5Zqk+LEOjejUwpf4tbzay5K6HtUKdDsXtj3dWiz1bDnCV1k5EzhXNOmQybidwXu9IOiXbDUBcl3gXZ31KGUpdQCLshQpOD2zs=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW5PR13MB5486.namprd13.prod.outlook.com (2603:10b6:303:195::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.10; Wed, 22 May
 2024 16:20:18 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 16:20:18 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "ffilzlnx@mindspring.com" <ffilzlnx@mindspring.com>, "aglo@umich.edu"
	<aglo@umich.edu>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: sm notify (nlm) question
Thread-Topic: sm notify (nlm) question
Thread-Index: AQHapkFKbwx/Ub9VyESFXZd0mKzp2rGXOVgAgAALmK+AAAZ2AIAMCBuAgAAn2oA=
Date: Wed, 22 May 2024 16:20:18 +0000
Message-ID: <33bdba418d7ccd7d9b87fa478ea71a14e979aaf1.camel@hammerspace.com>
References:
 <CAN-5tyFBn3C_CTrsftuYeWJHe7KWxd82YFCyrN9t=az8J4RU0w@mail.gmail.com>
	 <2C80B5BC-AAEC-41F8-BEB6-C920F88C89BB@oracle.com>
	 <0b1101daa646$d26a6300$773f2900$@mindspring.com>
	 <CAN-5tyGECFmtzFsYNSZicPcH4SMKF0yovk6V20sWJ1LrZKzzyA@mail.gmail.com>
	 <0b1401daa64b$f5831ee0$e0895ca0$@mindspring.com>
	 <CAN-5tyHWeQykx0cFpOFf2hTBRk9_NaZarzeeAFdSu2NW0zqobA@mail.gmail.com>
In-Reply-To:
 <CAN-5tyHWeQykx0cFpOFf2hTBRk9_NaZarzeeAFdSu2NW0zqobA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MW5PR13MB5486:EE_
x-ms-office365-filtering-correlation-id: 847e1cc6-5ea9-45bd-dfdd-08dc7a7b11f2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?TnFtQ1p1MEFIMERYUUJrNFlVS3h5aE5lVXhSM2JWa1FUbTF5N0pFOHA2UEY1?=
 =?utf-8?B?c2IxbjZhUm9rUCtvRVI0WVVrMXh0RVFHdmtFVkF4WFZaWExnUmMwUjd6bHoy?=
 =?utf-8?B?cHlLWVFxclBIcnVYbStZV0Y1dXlTRDVyRTU4T3ZPd2c5N05RM0h1alRkdGo5?=
 =?utf-8?B?cG5PWkx1UmV0c2REc1pYN1o1d1hSZWNwNERYaTE3OHNXOWZmNXM2R0kyRU8z?=
 =?utf-8?B?U2ZIVDdFRVI2UEVTQkZQSE1JOGZHT0NVajJHMzk3QUdZeE9JbUZlakFvMUNT?=
 =?utf-8?B?dnZKNjhhTUpMTGRjZlBKVzh1eERTdklXcEJsUVc1NG0yQXIwdEVJUnExdFB1?=
 =?utf-8?B?akRQOWJhT20zVDFQODl3dkZvTGdxYTlncGp0b0orL1Q0TVdHYjhXSHpacVFu?=
 =?utf-8?B?dFlsYi9OQTFGZE15alFNUk5CUkZNMjc4SlhoQUpOenZGQUF6NFAzbkhJUkFI?=
 =?utf-8?B?dGltdkpNUVNYdlBPOHg3blpTT0dYSDJ5WG8wQUxCS3lUdTVLWTREZDFaOEZr?=
 =?utf-8?B?bnMwL3IxT3VxME1zZlRLUzZtNEYzZm5hMkxQYjIwOVFTTkc1Y3c2QktiTllI?=
 =?utf-8?B?MU9reXM1bWdkdDA3ZUpuSVdBVWlCVW5UMkNPOE1VZWlSMzZoZE85Qzh4YzND?=
 =?utf-8?B?WFBiMVNuOGpKSFhxMGhXQTFqc201RUhiS0lGNERIRUJSVlZicHIrUy9FTmds?=
 =?utf-8?B?Y3lrdTRMN2x3UVNzNEFaR24zclNiam93Ulk0dFF4cDQzbUJkeWp3UHBIdkhR?=
 =?utf-8?B?QXVpUndPbnloM01ETmhDYnc1UG1aVE04QitwcEJjemdxV01kREJDaklkWlRI?=
 =?utf-8?B?OUZUV2pueUJhZDU0anEvU1Nmc2diQkhaUzdVNUNBcWJrdnpINjRtVk9hYVlz?=
 =?utf-8?B?bXBsQVIxdnBoVHp5SVBJekJmRVdRampKN295SG9BSWxFMTJVQWV5aGVWUHNE?=
 =?utf-8?B?MlB2Vm1TOFpnaVdhVS9odmVBQk9Gd0RabnQyQmsvaUN1T2xMZHU3M1RIb3M1?=
 =?utf-8?B?VGdISGg1TmtOTGxwVEZ4R0NLdVhvRVVVbTNrVjdnY20zSm1pZ0ZnVkhDRWtN?=
 =?utf-8?B?Vnc2TEdtWnEzS2thY2FhSEIzNzA3Z0xGUFZQd2VKd2xTVEExaldrZ1BqOHJt?=
 =?utf-8?B?TzV0d1FMcXc4Yi93WlA4c3hzMUxZbTlkaXVzVHJaTXpGVkxoTFJCSkQyY0sw?=
 =?utf-8?B?ZXk5Ryt3c0IybVNTenExL1RUTWFxNE1ha0pPV2JmUWQzSE91MjlQalNLdTlj?=
 =?utf-8?B?N0I5NVJjTngwRWJ3eE1XNUJiMTVNZytodER3YUJKVWFxdVJ3L01IdEVxVEhQ?=
 =?utf-8?B?a2RqZGtWbndLQWVucmdXeFUwWnE4NGdBNkw1ODhsUzZERWZMaE5mcUIrSnN5?=
 =?utf-8?B?QUpBano4dTBSNllFeGJZRUw5b1pUcTc0ZFV1aVlmTHdMZ2k2bDRKLzhMVmxv?=
 =?utf-8?B?d1JMVGZoeWRrcXJvaXVVY0k1L1ZMSUlaMnRCMGJIZlBQWTd6RUdjT242Rjlw?=
 =?utf-8?B?dld4MlFsMFBpVlNMSGt4WnQ5OEVKVktrUklEUytjVkdBUSthL01CSDJpNDhm?=
 =?utf-8?B?UXBrNnh4M0FNRFVpNnU1blVEUDdIY3FvaEU1VldlNFNCNDVOUCtHeHVmUmpU?=
 =?utf-8?B?VnZ6VEdiNklOMW5FY0U0cEV1U2NhR3FkNVc3d0tlQTFYeWU2UFNoMk1iRFZ4?=
 =?utf-8?B?OUpBd0V5R29CaURFY1QzdUR6aTdLZGR2T3o0SGhTMlcvTmY0OU5uQmlBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEd2RnA1SzkyRWFpUUFMajdzSXVkODNGVmZ4VzFIT3BJczBZQTJhY1FOQkp3?=
 =?utf-8?B?MWtBV043bFJyUmVvRmlHOTZaUDg2eHNvUWF1ZW0ybkIxbXVFTWYwSkRjU2NJ?=
 =?utf-8?B?Tm84VGJ2aUhkdjRCMWxJTTZTSk9XRzZ4UmZ1TkYrRGhOSm16NTJjMVdvV1Ba?=
 =?utf-8?B?VDZhSmFLL1p3Z1dXQWhnODVUWjJvelN0akZTYXhwbmJaU25pWmxSV3EzY2hs?=
 =?utf-8?B?VUZOcWd4MVppYjRRWSs5ZU9zSHp5MHdDTjBvbm9sM3l2aDJmejcxTHNENU43?=
 =?utf-8?B?RjZuWXA2bVBUSVNZbGtyZExKWkZQU0Z3YStmS0JKTDhYbEhoNnNocjZtQXFw?=
 =?utf-8?B?c0pjdC8rU0NQMldjN04xTCt6ZEc3dUp0a2VHc2Y3bU1HdWY0Tkg0TFJTQXBH?=
 =?utf-8?B?TSswelVjOUR0TG1PcDNyelBxZTcrWEJQbzc1Z1JTdEhCTVIvOGx1UEJmRmJG?=
 =?utf-8?B?YkN1TzR0dlBiWEhCemVNWE4rd0Q1TmJjNFJETXVJNlpHYU5Nci91VWZ3U09O?=
 =?utf-8?B?YWkrMm5Ic1VhYTIvOFk5UW85Q2JPSFZncXlLZWMzVE00ZUpVT3VyZDFWR1gx?=
 =?utf-8?B?WEFBcW96bldLK2pjSGpIaDR3a0lPNERFek9TUHNGZU5VeU5ZSkZCd2taR3pR?=
 =?utf-8?B?Qk9ZcnRMOTFTRll3bk5kSXVuWWRuU3VlaU9Jak0xOVhXNmNtcy9leiszeHpM?=
 =?utf-8?B?N3BWL0s1Z2ZnN2tDc1R4THFHZUQ1cVo4Rmk5WmIybjRpbG5qN005dXpNRXFW?=
 =?utf-8?B?SVV1Sno5YjE3Q2gxNmVlTEJyRFBYL3pNdE14UjNLakVMSVlNNFM3RTFtRG9J?=
 =?utf-8?B?K2RJRzI0eC93aktJdG9Uck9pL2Y5N2U0SHYxNkRDYWc2ZzVkVEppd3dONzBW?=
 =?utf-8?B?eFlRQkh1SWlrZTVLazZucDFncDZHK1R5SitJVlduN1VSWkF6ZlhBSnUxQ0VM?=
 =?utf-8?B?bExDQU41ZjQxS1VEZFFJLzlja29sZ01MbCtQcnJxWStlQVhxR2NUZVkzaG9C?=
 =?utf-8?B?Y3hJL3VrOEc2RlRZODgycUNVZTVHMWFyVS84Uk02Qi9OZTlmTDlWYTVBWGFD?=
 =?utf-8?B?VHRvanN6VEFpWjJQemg4NDV4NHpDZ0x3Qm1XdmVzZk9OZjdwVzZYU2lIYjJY?=
 =?utf-8?B?QTEyUHN2MHdlUTVlOElQQUoxSWFOWFAyZHlhYTVMQUVNRzNKOVRDTlFMcExz?=
 =?utf-8?B?MUVOdE96ZjAzd05WRUpCcWN6dEJYa1NPdEZpQmhCVkE5SUp3Vk8xRForT3VG?=
 =?utf-8?B?b2x6QXVKbjdCZGxWNERCVW82cVZEOVhpYUlNRmd4aWZWME1CYUphYzZ1TXJF?=
 =?utf-8?B?YkVkTERzVGR0bklaN0E1UXYyK3cyTWVERVpSbk93VFJLNXhqN3htSCsrbkxy?=
 =?utf-8?B?ZUV4SXRhbjB3aG5uaFZ1UHNMQ0FiZFMyWWs0MjZBM1UwU3BGRlZCdmlhY2Rw?=
 =?utf-8?B?d2VLeWxOaDhZZ2t2N2ZkT0tBcmFINlB5cm1hNVhNSmhsL2tTbTF1djl4cEdF?=
 =?utf-8?B?YUlnanl6NDBpb3U3aVlOdTJCM1Yyemd3b2RHS2VYTktlaW9jdUZPKzRJcWl2?=
 =?utf-8?B?L1dwS1dzVmdFTTlUV1dXTWxIbVk5Y0drZktFb084OXZVS3lzdmxzalhRdzFw?=
 =?utf-8?B?T3FqeGprdHowMXBqZkszQTdrdzZKTnkyV09PNy9mSHg1UEtaWHdwTGRFdnRx?=
 =?utf-8?B?cTBLVzlzVUsvaGwxTjJVSGxDaDBTalQ5N3MrMXMxWHhyZTFPL0kyNTRzdDY3?=
 =?utf-8?B?WStCMmE3SjdJOTJBbnhkRWk5V0RkVkZ6d0puVjdrU3FKeDAyOVNLbHpZUWlr?=
 =?utf-8?B?cTBqK0RlbDc4cVpYa1gxaUlyRjQ2QmtXemdDZlhhejhqeEI2ZTVOcmtwZlg1?=
 =?utf-8?B?N0VveXBFUGoxdjhRcWk5TWpRZW5ZWVZJYVdCczZKT2lZRnhRRmNNYkZrbGYv?=
 =?utf-8?B?SmdjSTdXT0xYRmR0dThnZmg0RTBVWmx3aE1RZ1FJZXZBbkJ2V2I1cVB1anpl?=
 =?utf-8?B?NDdxaWQ0TWhBYTFNa2RjWFk4YWFZR1FZZ2J3bHJubmNXUzRBeDVsMEVWK0lo?=
 =?utf-8?B?RmNaUEdSTXp2bXRwaVVvM01Ca2N5VmI0cmowdVYrakhDNCtvMFVHdWZTdFVI?=
 =?utf-8?B?VndqTjY2U3lrY3lwTTFsSlNYMmVRdFNrOHRnY1BzUGxuQUNUZVV1ZkltK1Jy?=
 =?utf-8?B?WWM0ckIyU04yMS9SaW5jL1F5bWNkQnU1dFBqRDdFZWhBakhXZHVqZS9PLzVM?=
 =?utf-8?B?b0xUamhTTnFzUG8zVGh0WWdURHZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31E69881DBCCFA4DAF2153912FFC2CED@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 847e1cc6-5ea9-45bd-dfdd-08dc7a7b11f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 16:20:18.0264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GswtvapxnCK4GrX7YIDSGKf5CtwuEhoJxGIjGc7xCPX/U52IJIz1q3ClwA1pUJ1ghUhotpSU4wV5YubWIFBtNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5486

T24gV2VkLCAyMDI0LTA1LTIyIGF0IDA5OjU3IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVHVlLCBNYXkgMTQsIDIwMjQgYXQgNjoxM+KAr1BNIEZyYW5rIEZpbHogPGZmaWx6
bG54QG1pbmRzcHJpbmcuY29tPg0KPiB3cm90ZToNCj4gPiANCj4gPiANCj4gPiANCj4gPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBPbGdhIEtvcm5pZXZza2FpYSBb
bWFpbHRvOmFnbG9AdW1pY2guZWR1XQ0KPiA+ID4gU2VudDogVHVlc2RheSwgTWF5IDE0LCAyMDI0
IDI6NTAgUE0NCj4gPiA+IFRvOiBGcmFuayBGaWx6IDxmZmlsemxueEBtaW5kc3ByaW5nLmNvbT4N
Cj4gPiA+IENjOiBDaHVjayBMZXZlciBJSUkgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+OyBMaW51
eCBORlMgTWFpbGluZw0KPiA+ID4gTGlzdCA8bGludXgtDQo+ID4gPiBuZnNAdmdlci5rZXJuZWwu
b3JnPg0KPiA+ID4gU3ViamVjdDogUmU6IHNtIG5vdGlmeSAobmxtKSBxdWVzdGlvbg0KPiA+ID4g
DQo+ID4gPiBPbiBUdWUsIE1heSAxNCwgMjAyNCBhdCA1OjM24oCvUE0gRnJhbmsgRmlseg0KPiA+
ID4gPGZmaWx6bG54QG1pbmRzcHJpbmcuY29tPiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+ID4g
PiBPbiBNYXkgMTQsIDIwMjQsIGF0IDI6NTbigK9QTSwgT2xnYSBLb3JuaWV2c2thaWENCj4gPiA+
ID4gPiA+IDxhZ2xvQHVtaWNoLmVkdT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiBIaSBmb2xrcywNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gR2l2ZW4gdGhhdCBu
b3QgZXZlcnl0aGluZyBmb3IgTkZTdjMgaGFzIGEgc3BlY2lmaWNhdGlvbiwgSQ0KPiA+ID4gPiA+
ID4gcG9zdCBhDQo+ID4gPiA+ID4gPiBxdWVzdGlvbiBoZXJlIChhcyBpdCBjb25jZXJucyBsaW51
eCB2MyAoY2xpZW50KQ0KPiA+ID4gPiA+ID4gaW1wbGVtZW50YXRpb24pDQo+ID4gPiA+ID4gPiBi
dXQgSSBhc2sgYSBnZW5lcmljIHF1ZXN0aW9uIHdpdGggcmVzcGVjdCB0byBOT1RJRlkgc2VudCBi
eQ0KPiA+ID4gPiA+ID4gYW4gTkZTIHNlcnZlci4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGVy
ZSBpcyBhIHN0YW5kYXJkOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGh0dHBzOi8vcHVicy5vcGVu
Z3JvdXAub3JnL29ubGluZXB1YnMvOTYyOTc5OS9jaGFwMTEuaHRtDQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiBBIE5PVElGWSBtZXNzYWdlIHRoYXQgaXMgc2VudCBieSBhbiBO
RlMgc2VydmVyIHVwb24gcmVib290DQo+ID4gPiA+ID4gPiBoYXMgYQ0KPiA+ID4gPiA+ID4gbW9u
aXRvciBuYW1lIGFuZCBhIHN0YXRlLiBUaGlzICJzdGF0ZSIgaXMgYW4gaW50ZWdlciBhbmQgaXMN
Cj4gPiA+ID4gPiA+IG1vZGlmaWVkIG9uIGVhY2ggc2VydmVyIHJlYm9vdC4gTXkgcXVlc3Rpb24g
aXM6IHdoYXQgYWJvdXQNCj4gPiA+ID4gPiA+IHN0YXRlDQo+ID4gPiA+ID4gPiB2YWx1ZSB1bmlx
dWVuZXNzPyBJcyB0aGVyZSBzb21ld2hlcmUgc29tZSBub3Rpb24gdGhhdCB0aGlzDQo+ID4gPiA+
ID4gPiB2YWx1ZQ0KPiA+ID4gPiA+ID4gaGFzIHRvIGJlIHVuaXF1ZSAoYXMgaW4gc2F5IGEgcmFu
ZG9tIHZhbHVlKS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSGVyZSdzIGEgcHJvYmxlbS4g
U2F5IGEgY2xpZW50IGhhcyAyIG1vdW50cyB0byBpcDEgYW5kIGlwMg0KPiA+ID4gPiA+ID4gKGJv
dGgNCj4gPiA+ID4gPiA+IHJlcHJlc2VudGluZyB0aGUgc2FtZSBETlMgbmFtZSkgYW5kIGFjcXVp
cmVzIGEgbG9jayBwZXINCj4gPiA+ID4gPiA+IG1vdW50LiBOb3cNCj4gPiA+ID4gPiA+IHNheSBl
YWNoIG9mIHRob3NlIHNlcnZlcnMgcmVib290LiBPbmNlIHVwIHRoZXkgZWFjaCBzZW5kIGENCj4g
PiA+ID4gPiA+IE5PVElGWQ0KPiA+ID4gPiA+ID4gY2FsbCBhbmQgZWFjaCB1c2UgYSB0aW1lc3Rh
bXAgYXMgYmFzaXMgZm9yIHRoZWlyICJzdGF0ZSINCj4gPiA+ID4gPiA+IHZhbHVlIC0tDQo+ID4g
PiA+ID4gPiB3aGljaCB2ZXJ5IGxpa2VseSBpcyB0byBwcm9kdWNlIHRoZSBzYW1lIHZhbHVlIGZv
ciAyDQo+ID4gPiA+ID4gPiBzZXJ2ZXJzDQo+ID4gPiA+ID4gPiByZWJvb3RlZCBhdCB0aGUgc2Ft
ZSB0aW1lIChvciBmb3IgdGhlIGxpbnV4IHNlcnZlciB0aGF0DQo+ID4gPiA+ID4gPiBsb29rcyBs
aWtlDQo+ID4gPiA+ID4gPiBhIGNvdW50ZXIpLiBPbiB0aGUgY2xpZW50IHNpZGUsIG9uY2UgdGhl
IGNsaWVudCBwcm9jZXNzZXMNCj4gPiA+ID4gPiA+IHRoZSAxc3QNCj4gPiA+ID4gPiA+IE5PVElG
WSBjYWxsLCBpdCB1cGRhdGVzIHRoZSAic3RhdGUiIGZvciB0aGUgbW9uaXRvciBuYW1lDQo+ID4g
PiA+ID4gPiAoaWUgYQ0KPiA+ID4gPiA+ID4gY2xpZW50IG1vbml0b3JzIGJhc2VkIG9uIGEgRE5T
IG5hbWUgd2hpY2ggaXMgdGhlIHNhbWUgZm9yDQo+ID4gPiA+ID4gPiBpcDEgYW5kDQo+ID4gPiA+
ID4gPiBpcDIpIGFuZCB0aGVuIGluIHRoZSBjdXJyZW50IGNvZGUsIGJlY2F1c2UgdGhlIDJuZCBO
T1RJRlkNCj4gPiA+ID4gPiA+IGhhcyB0aGUNCj4gPiA+ID4gPiA+IHNhbWUgInN0YXRlIiB2YWx1
ZSB0aGlzIE5PVElGWSBjYWxsIHdvdWxkIGJlIGlnbm9yZWQuIFRoZQ0KPiA+ID4gPiA+ID4gbGlu
dXgNCj4gPiA+ID4gPiA+IGNsaWVudCB3b3VsZCBuZXZlciByZWNsYWltIHRoZSAybmQgbG9jayAo
YnV0IHRoZQ0KPiA+ID4gPiA+ID4gYXBwbGljYXRpb24NCj4gPiA+ID4gPiA+IG9idmlvdXNseSB3
b3VsZCBuZXZlciBrbm93IGl0J3MgbWlzc2luZyBhIGxvY2spDQo+ID4gPiA+ID4gPiAtLS0gZGF0
YSBjb3JydXB0aW9uLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBXaG8gaXMgdG8gYmxhbWU6
IGlzIHRoZSBzZXJ2ZXIgbm90IGFsbG93ZWQgdG8gc2VuZCAibm9uLQ0KPiA+ID4gPiA+ID4gdW5p
cXVlIg0KPiA+ID4gPiA+ID4gc3RhdGUgdmFsdWU/IE9yIGlzIHRoZSBjbGllbnQgYXQgZmF1bHQg
aGVyZSBmb3Igc29tZQ0KPiA+ID4gPiA+ID4gcmVhc29uPw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
IFRoZSBzdGF0ZSB2YWx1ZSBpcyBzdXBwb3NlZCB0byBiZSBzcGVjaWZpYyB0byB0aGUgbW9uaXRv
cmVkDQo+ID4gPiA+ID4gaG9zdC4gSWYNCj4gPiA+ID4gPiB0aGUgY2xpZW50IGlzIGluZGVlZCBp
Z25vcmluZyB0aGUgc2Vjb25kIHJlYm9vdCBub3RpZmljYXRpb24sDQo+ID4gPiA+ID4gdGhhdCdz
IGluY29ycmVjdA0KPiA+ID4gYmVoYXZpb3IsIElNTy4NCj4gPiA+ID4gDQo+ID4gPiA+IElmIHlv
dSBhcmUgdXNpbmcgbXVsdGlwbGUgc2VydmVyIElQIGFkZHJlc3NlcyB3aXRoIHRoZSBzYW1lIERO
Uw0KPiA+ID4gPiBuYW1lLCB5b3UNCj4gPiA+IG1heSB3YW50IHRvIHNldDoNCj4gPiA+ID4gDQo+
ID4gPiA+IHN5c2N0bCBmcy5uZnMubnNtX3VzZV9ob3N0bmFtZXM9MA0KPiA+ID4gPiANCj4gPiA+
ID4gVGhlIE5MTSB3aWxsIHJlZ2lzdGVyIHdpdGggc3RhdGQgdXNpbmcgdGhlIElQIGFkZHJlc3Mg
YXMgbmFtZQ0KPiA+ID4gPiBpbnN0ZWFkIG9mIGhvc3QNCj4gPiA+IG5hbWUuIFRoZW4geW91ciB0
d28gSVAgYWRkcmVzc2VzIHdpbGwgZWFjaCBoYXZlIGEgc2VwYXJhdGUNCj4gPiA+IG1vbml0b3Ig
ZW50cnkgYW5kDQo+ID4gPiBzdGF0ZSB2YWx1ZSBtb25pdG9yZWQuDQo+ID4gPiANCj4gPiA+IElu
IG15IHNldHVwIEkgYWxyZWFkeSBoYXZlIHRoaXMgc2V0IHRvIDAuIEJ1dCBJJ2xsIGxvb2sgYXJv
dW5kDQo+ID4gPiB0aGUgY29kZSB0byBzZWUgd2hhdA0KPiA+ID4gaXQgaXMgc3VwcG9zZWQgdG8g
ZG8uDQo+ID4gDQo+ID4gSG1tLCBtYXliZSBpdCBkb2Vzbid0IHdvcmsgb24gdGhlIGNsaWVudCBz
aWRlLiBJIGRvbid0IG9mdGVuIHRlc3QNCj4gPiBOTE0gY2xpZW50cyB3aXRoIG15IEdhbmVzaGEg
d29yayBiZWNhdXNlIEkgb25seSBydW4gb25lIFZNIGFuZCBOTE0NCj4gPiBjbGllbnRzIGNhbuKA
mXQgZnVuY3Rpb24gb24gdGhlIHNhbWUgaG9zdCBhcyBhbnkgc2VydmVyIG90aGVyIHRoYW4NCj4g
PiBrbmZzZC4uLg0KPiANCj4gSSd2ZSBiZWVuIHN0YXJpbmcgYW5kIHRyYWNpbmcgdGhlIGNvZGUg
YW5kIGhlcmUncyB3aGF0IEkgY29uY2x1ZGU6DQo+IHRoZQ0KPiB1c2Ugb2YgbnNtX3VzZV9ob3N0
bmFtZSB0b2dnbGVzIG5vdGhpbmcgdGhhdCBoZWxwcy4gTm8gbWF0dGVyIHdoYXQNCj4gc3RhdGQg
YWx3YXlzIHN0b3JlcyB3aGF0ZXZlciBpdCBpcyBtb25pdG9yaW5nIGJhc2VkIG9uIHRoZSBEU04g
bmFtZQ0KPiAobG9va3MgbGlrZSBnaXQgYmxhbWUgc2F5cyBpdCdzIGR1ZSB0byBuZnMtdXRpbHMn
cyBjb21taXQNCj4gMGRhNTZmN2QzNTk0NzU4MzcwMDhlYTRiOGQzNzY0ZmU5ODJlZjUxMiAic3Rh
dGQgLSB1c2UgZG5zbmFtZSB0bw0KPiBlbnN1cmUgY29ycmVjdCBtYXRjaGluZyBvZiBOT1RJRlkg
cmVxdWVzdHMiLiBOb3cgd2hhdCdzIHdvcnNlIGlzIHRoYXQNCj4gd2hlbiBzdGF0ZCByZWNlaXZl
cyBhIDJuZCBtb25pdG9yaW5nIHJlcXVlc3QgZnJvbSBsb2NrZCBmb3Igc29tZXRoaW5nDQo+IHRo
YXQgbWFwcyB0byB0aGUgc2FtZSBETlMgbmFtZSwgc3RhdGQgb3ZlcndyaXRlcyB0aGUgcHJldmlv
dXMNCj4gbW9uaXRvcmluZyBpbmZvcm1hdGlvbiBpdCBoYWQuIFdoZW4gYSBOT1RJRlkgYXJyaXZl
cyBmcm9tIGFuIElQDQo+IG1hdGNoaW5nIHRoZSBETlMgbmFtZSwgdGhlIHN0YXRkIGRvZXMgdGhl
IGRvd25jYWxsIGFuZCBpdCB3aWxsIHNlbmQNCj4gd2hhdGV2ZXIgdGhlIGxhc3QgbW9uaXRvcmlu
ZyBpbmZvcm1hdGlvbiBsb2NrZCBnYXZlIGl0LiBUaGVyZWZvcmUgYWxsDQo+IHRoZSBvdGhlciBs
b2NrcyB3aWxsIG5ldmVyIGJlIHJlY292ZXJlZC4NCj4gDQo+IFdoYXQgSSBzdHJ1Z2dsZSB3aXRo
IGlzIGhvdyB0byBzb2x2ZSB0aGlzIHByb2JsZW0uIFNheSBpcDEgYW5kIGlwMg0KPiBydW4NCj4g
YW4gTkZTIHNlcnZlciBhbmQgYm90aCBhcmUga25vd24gdW5kZXIgdGhlIHNhbWUgRE5TIG5hbWU6
DQo+IGZvby5iYXIuY29tLg0KPiBEb2VzIGl0IG1lYW4gdGhhdCB0aGV5IHJlcHJlc2VudCB0aGUg
InNhbWUiIHNlcnZlcj8gQ2FuIHdlIGFzc3VtZQ0KPiB0aGF0DQo+IGlmIG9uZSBvZiB0aGVtICJy
ZWJvb3RlZCIgdGhlbiB0aGUgb3RoZXIgcmVib290ZWQgYXMgd2VsbD/CoCBJdCBzZWVtcw0KPiBs
aWtlIHdlIGNhbid0IGdvIGJhY2t3YXJkcyBhbmQgZ28gYmFjayB0byBtb25pdG9yaW5nIGJ5IElQ
LiBJbiB0aGF0DQo+IGNhc2UgSSBjYW4gc2VlIHRoYXQgd2UnbGwgZ2V0IGluIHRyb3VibGUgaWYg
dGhlIHJlYm9vdGVkIHNlcnZlcg0KPiBpbmRlZWQNCj4gY29tZXMgYmFjayB1cCB3aXRoIGEgZGlm
ZmVyZW50IElQIChzYW1lIEROUyBuYW1lKSBhbmQgdGhlbiBpdCB3b3VsZA0KPiBuZXZlciBtYXRj
aCB0aGUgb2xkIGVudHJ5IGFuZCB0aGUgbG9jayB3b3VsZCBuZXZlciBiZSByZWNvdmVyZWQgKGJ1
dA0KPiB0aGVuIGFsc28gSSB0aGluayBsb2NrZCB3aWxsIG9ubHkgc2VuZCB0aGUgbG9jayB0byB0
aGUgSVAgaXMgc3RvcmVkDQo+IHByZXZpb3VzbHkgd2hpY2ggaW4gdGhpcyBjYXNlIHdvdWxkIGJl
IHVucmVhY2hhYmxlKS4gSWYgc3RhdGQNCj4gY29udGludWVzIHRvIG1vbml0b3IgYnkgRE5TIG5h
bWUgYW5kIHRoZW4gbWF0Y2hlcyBlaXRoZXIgaXBzIHRvIHRoZQ0KPiBzdG9yZWQgZW50cnksIHRo
ZW4gdGhlIHByb2JsZW0gY29tZXMgd2l0aCAic3RhdGUiIHVwZGF0ZS4gT25jZSBzdGF0ZA0KPiBw
cm9jZXNzZXMgb25lIE5PVElGWSB3aGljaCBtYXRjaGVkIHRoZSBETlMgbmFtZSBpdHMgc3RhdGUg
InNob3VsZCIgYmUNCj4gdXBkYXRlZCBidXQgdGhlbiBpdCB3b3VsZCBsZWFkcyB1cyBiYWNrIGlu
dG8gdGhlIHByb2JsZW0gaWYgaWdub3JpbmcNCj4gdGhlIDJuZCBOT1RJRlkgY2FsbC4gSWYgc3Rh
dGQgd2VyZSB0byBiZSBjaGFuZ2VkIHRvIHN0b3JlIG11bHRpcGxlDQo+IG1vbml0b3IgaGFuZGxl
cyBsb2NrZCBhc2tlZCB0byBtb25pdG9yLCB0aGVuIHdoZW4gdGhlIDFzdCBOT1RJRlkgY2FsbA0K
PiBjb21lcyB3ZSBjYW4gYXNrIGxvY2tkIHRvIHJlY292ZXIgImFsbCIgdGhlIHN0b3JlIGhhbmRs
ZXMuIEJ1dCB0aGVuDQo+IGl0DQo+IGNpcmNsZXMgYmFjayB0byBteSBxdWVzdGlvbjogY2FuIHdl
IGFzc3VtZSB0aGF0IGlmIG9uZSBJUCByZWJvb3RlZA0KPiBkb2VzIGl0IGltcGx5IGFsbCBJUHMg
cmVib290ZWQ/DQo+IA0KPiBQZXJoYXBzIGl0J3MgbG9ja2QgdGhhdCBuZWVkcyB0byBjaGFuZ2Ug
aW4gaG93IGl0IGtlZXBzIHRyYWNrIG9mDQo+IHNlcnZlcnMgdGhhdCBob2xkIGxvY2tzLiBUaGUg
YmVoYXZpb3VyIHNlZW1zIHRvIGhhdmUgY2hhbmdlZCBpbiAyMDEwDQo+ICh3aXRoIGNvbW1pdCA4
ZWE2ZWNjOGIwNzU5NzU2YTc2NmMwNWRjN2M5OGM1MWVjOTBkZTM3ICJsb2NrZDogQ3JlYXRlDQo+
IGNsaWVudC1zaWRlIG5sbV9ob3N0IGNhY2hlIikgd2hlbiBubG1faG9zdCBjYWNoZSB3YXMgaW50
cm9kdWNlZA0KPiB3cml0dGVuIHRvIGJlIGJhc2VkIG9uIGhhc2ggb2YgSVAuIEl0IHNlZW1zIHRo
YXQgYmVmb3JlIHRoaW5ncyB3ZXJlDQo+IGJhc2VkIG9uIGEgRE5TIG5hbWUgbWFraW5nIGl0IGlu
IGxpbmUgd2l0aCBzdGF0ZC4NCj4gDQo+IEFueWJvZHkgaGFzIGFueSB0aG91Z2h0cyBhcyB0byB3
aGV0aGVyIHN0YXRkIG9yIGxvY2tkIG5lZWRzIHRvDQo+IGNoYW5nZT8NCj4gDQoNCkkgYmVsaWV2
ZSBUb20gVGFscGV5IGlzIHRvIGJsYW1lIGZvciB0aGUgbnNtX3VzZV9ob3N0bmFtZSBzdHVmZi4g
VGhhdA0KYWxsIGNhbWUgZnJvbSBoaXMgMjAwNiBDb25uZWN0YXRob24gdGFsaw0KaHR0cHM6Ly9u
ZnN2NGJhdC5vcmcvRG9jdW1lbnRzL0Nvbm5lY3RBVGhvbi8yMDA2L3RhbHBleS1jdGhvbjA2LW5z
bS5wZGYNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5l
ciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

