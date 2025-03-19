Return-Path: <linux-nfs+bounces-10672-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E0AA682AB
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 02:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE76819C5F53
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 01:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E408C0B;
	Wed, 19 Mar 2025 01:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="KyYzp7FR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2136.outbound.protection.outlook.com [40.107.101.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8D2101DE
	for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 01:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742346762; cv=fail; b=AnjOwNQoxhfkWw3/65lP/tZDJZtEWZrEhJXQ5uNqE8t9INkJg1xvxVjSH2FX3IcIh62LuJwj+IZ5kp1CKEsEu67tqIv9MtHZtsL0JMMb2TMt9N+2tOPzXjmRQLKZqOdWg4onEDwRwHo/9nBDGpYa0XsKz7w3MZfZ/IEmnY1oL3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742346762; c=relaxed/simple;
	bh=KUxlD2X9SZ7m99jU74sv5O8y2lK6J7uUFhztl3cJQik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JBKhIo/d3NBxLc27gRz1xjAnjBb4sxluz1um7hZ/zsZW5Db0vCd3BDy4jFpEeUcJGeLBVoBomSenZPXTr2Ev+R1XqUuu1dj3BZ5Gbxts4z1sKhA25rTi606W8vkEC9j0O3I0Xivr9056Kp/24hmBjmG/9uWoj1UJU7384YxqXEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=KyYzp7FR; arc=fail smtp.client-ip=40.107.101.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CefpYgi0dDcATwfC1/1PPZqWj4xupFPF9ublFoI2gvep+ZoPt7Ds2ai1AbdnWASmhPvXerUQHer9fhsdo29WXk0gOs0w+T0vnPtxgRew5skppvygOdRd3zbDtlxNlRjDhyAOagmF1uaIuLI/EFjKMJEUejSs4Sd4mCIhY3zoi4gtXQCFGyyyRs2aLjjuIci8haqqn+vRrWCNjQI0C8UlvlijqB7lTofeJEgsWCrL44Ex22ioVyor1/89HRmBGmbPhK9aYk3c5tvLiT54tXM/wzCqNUZxtBdOeIhbwXgQWNVBmU5l6goIU8bkx0pS6X0kNk474AFR+5L9V6M/YeX+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUxlD2X9SZ7m99jU74sv5O8y2lK6J7uUFhztl3cJQik=;
 b=w5ejWt9YI3vrbyxdpysVwneB91OR+ff7RlJF/y8iegrG9DTZuYq2kLVZyqlQBlHxyw1dhu4j9pJIR7rlpQ0X8xl2pBvFfocpeoeqpaZvyiTMDV0WyfFBd3pAToWdVQ3xxTlykYwjdWE9ATGdAfV++jRwlGTI2CDF/+MNqfpbXscXoo/unU8SayD8ANslmQMy48mnJq93rl6Hf68jJ0qUu6YXrrblOhL5NVcB43w3DdCpM4HK0fvLxdTWDTAP7fsZFmRPPJmFZIPcUnQh3qN0klf+yVLh6YHqqpo0DEVngyTIctnfXQVEkwBzzKQbbvujIXh06SvRbuBd6E1qJpLFtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUxlD2X9SZ7m99jU74sv5O8y2lK6J7uUFhztl3cJQik=;
 b=KyYzp7FRAAR4WiwsaThtyUo8Qr1BjH0xxioGKU4cyzKt0KX/mGxMDH319WVxn/Ynjj8BRuOjazOGlwiNwAQ/abgmDh8zuc456GJTudEONX/1h70oFGYZbG4y5EruWq+//xshsIRk98Zp1QfhJnVMpvIqn62aJADB0mcJRDEGe1c=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB4405.namprd13.prod.outlook.com (2603:10b6:a03:1d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 01:12:37 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 01:12:36 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "rick.macklem@gmail.com" <rick.macklem@gmail.com>
CC: "lionelcons1972@gmail.com" <lionelcons1972@gmail.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"takeshi.nishimura.linux@gmail.com" <takeshi.nishimura.linux@gmail.com>,
	"anna.schumaker@oracle.com" <anna.schumaker@oracle.com>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
Thread-Topic: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
Thread-Index:
 AQHbmBa5xy/j3c2GaUCylZ3htsCWqbN4/18AgAAOAgCAAFTsgIAAA8+AgAAWQoCAABGcAIAAA2sAgAACFgCAABRWgA==
Date: Wed, 19 Mar 2025 01:12:36 +0000
Message-ID: <75d4e5849c488bddeaa12f2a9780394dfe8d743e.camel@hammerspace.com>
References:
 <CALWcw=EeJ7rePwqv48mf8Se0B5tLE+Qu56pkS-fo0-X0R3DQ=Q@mail.gmail.com>
		 <0ea71027-c0cb-436a-8dc7-6f261f0d9e0e@oracle.com>
		 <89535c4a-7080-41cc-a0a3-1f66daa9287a@oracle.com>
		 <CAM5tNy7FdNRC6i62jqyMs=A=03omztTk3YdgS=P3qJVersSFbg@mail.gmail.com>
		 <e674d6ec96cc8598b079efd3b93612537f840a87.camel@hammerspace.com>
		 <CAPJSo4WrOnWfLzmfoCcj1MuYQQBHo434vTK=9qx+rh_FCVck=w@mail.gmail.com>
		 <e21645871fd6249d93f9bb33b154c3663eaf0a70.camel@hammerspace.com>
		 <CAM5tNy5ZA5MKuCsFQHXE_uBkmMv3eBH7dgonaTrk9Rk-p2jA0g@mail.gmail.com>
	 <09c573463b19a1d1f4b1e50484faa657d3c3aa28.camel@hammerspace.com>
In-Reply-To: <09c573463b19a1d1f4b1e50484faa657d3c3aa28.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY5PR13MB4405:EE_
x-ms-office365-filtering-correlation-id: 2f6f5406-9ac8-4753-0c39-08dd668322cc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVpYV0xpNGtTWURxT3dPeDhySWlvWW5qY09ZVnMyZjNsenhSZVNXS0JaaW52?=
 =?utf-8?B?SVNlNkpQaWJQVi96WTQ1QnlDODZWTm1WUHZpZXlZR3hSOU1uWWVBNmhrM0Rw?=
 =?utf-8?B?T1Zob2VXNW4wbXBsWE5kSk03R2RBVCtCTW1YY1FQZ3V2ZlF6Nm40Rjg3VEVj?=
 =?utf-8?B?Rkd5U3Rqb0l1TlhoSGRTUE05TGl0TThvcks2dCswTU9WUUZoa3R5Q2U1WVA0?=
 =?utf-8?B?RlNKd04wZTA4dStlZVNySXdyY3lGMnUxUW5FcjM0MFJ3bHpNeFBGaUZJS0pX?=
 =?utf-8?B?a0ZaamlQMExadnRIWFBMd05BVjhBMnl6cktWU0RLdmVreHhOZnBxTnh6L0JB?=
 =?utf-8?B?bUZDcjk3Rzl5ZHF5VEpVZCt5WlM1TmRMb2E3a29RNm96SUFmbWNXNC9VdVNu?=
 =?utf-8?B?OXBwVWFaTEFyRWhsRnd4T2ZGZy9ucGlaSVlWdnJORWs4aVNKQW92VW9wc1NR?=
 =?utf-8?B?L0pQMEc4TGZHcHlwUy9na1BybmN4enV3YnM0emR0cU4xL296ZEVOMU1JKy9z?=
 =?utf-8?B?VzNTZEdpeWdmbEpHWEpORFpicTZLWjJqWG85QUFYMDZMNzFHSldzdGd2VWVE?=
 =?utf-8?B?S1NLeFI0MTVQcnRQbG0wZFc1TElpMTNud2FNRk1sQUFpYnBhNjVxeGI2UXky?=
 =?utf-8?B?RXFQZ0ZGckNIQXhTNG5tMVV2R294NmZXUytQMkM5V095c0dGdEVKb05XM3Q4?=
 =?utf-8?B?ekNjbkRJOFlETktJRTRlZXFzUzJpeHdyZm5mWlZqZ09mMTcxUGdtWWVFWHlH?=
 =?utf-8?B?ZUhBSzR6NHFHUG5jNTJEY0dWM3RwNGtQRnZyQjFySGVUeUdnM1dDa3lnOUlQ?=
 =?utf-8?B?aWZXRDBKaXFNVEo5K1ErSEFqVzlueU5Ybmd4K3VxcngwUnM0d0t0S2FFZS9K?=
 =?utf-8?B?VlN0Z1l0VjVNQkMrTVA5VDBubGNoVjdadmdiVTcxaXh5bUJRKzVobmVWZDhr?=
 =?utf-8?B?Y1BsbDhqc3VVaFRTeSsvK2l4NDl5dVFDYnpRby9EbFlNd1dXalp4ay9zbW1K?=
 =?utf-8?B?YWxrK3U0RzBNd0hxU213b054Q1EzNXlXS1RlVnFRQzBLWDI1SHdiUU1UMEQy?=
 =?utf-8?B?NmFJbzIwaFYwbktiS0hDL21XbEhWZlFGeE5GT0Z5QU52bS9LR1JWeEFQVy9B?=
 =?utf-8?B?NnFKMjJFalBXM3VCQ3A2ZWpGT1dTWkpNcjBMSVVIcXpoc1lyMmFKMjEvS0tV?=
 =?utf-8?B?K3JNZHoxNi8xZXRyQ3FFekFIUytoNDkzdFRBTmJoZ1ZUeGdPSzBERU9BRHl5?=
 =?utf-8?B?bXV0bEUvUmxwMXVrb0hndnBHYzBVNk11QS9Md2xkdnZFVGV3VnNUZmMzRm1U?=
 =?utf-8?B?aGowZkI5OHVsbjg2Q1FjaTJoV1E2NnNvTllwN0t1VE1nMzYzWW5zZ0I1Qk1P?=
 =?utf-8?B?WUd5OVNrVHBsejBwQnVBb1hUQlRlaDVhL1hhRnFRMFhiTEtReEhnc3A2L0VE?=
 =?utf-8?B?WUsvM09OOUFKR2NlTXBuekFFQVlONXdWNkxmay9RQ0hwc1ZkYzhvM29FRW5F?=
 =?utf-8?B?WkE3THZtQldxSnJWbVduRUFNMXdYRlpDMWhzdFlkMlF6TTlYOVpIQVFETGxt?=
 =?utf-8?B?azBHb2ZBMkw3blNObHc1cGVQYVpFOEdjWHFiTVEwSXdOY2dPbkYwempLWVJ1?=
 =?utf-8?B?MWY2eGt1eGlyVmpqbXNNUTAwYVFCYVErR005QXJuZTMxeFZPQThBeTJzRXZD?=
 =?utf-8?B?R1VDaWNkLzU5RDNNdlJVKzQ3OE1qeVBQNEFzWDNKd3N1U2xmYlZzV2E1MUJP?=
 =?utf-8?B?dExWM2VlcVFFZ1BJTERyeVQrMGpObld6b1l6RWxoT2JQOUxyVlRzWWNTK1B0?=
 =?utf-8?B?WkZYSmdUaTZKaFZXU2RVb0wrVFMydGNYU0F2YWRjR2pvMXAxdkpGTXhQUEdl?=
 =?utf-8?B?ZHNWU2FNZ2lmWUxHdFpKSHdaa2p4dkh2cTV4b2RjUVJSWnQxb0JDZ1ZOdGFI?=
 =?utf-8?Q?/bUCXioe75RYKBlPkzXaGAl31FQLxBDs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SkJlajBTbCtYTDFTcEdDamRJYUJ1RTVjaVJRQTQxNkFDZWFQQUsrQnJsZWVs?=
 =?utf-8?B?R3JhajJsRHo5TDBVZmhmdlFxOUFKMDYybXcxSWwwbkhyZ0V1c0YxUzVLMXNX?=
 =?utf-8?B?RVdzcE43Y1NpZGJaQ21xc1MyQitlem4xNy91WW9uMkVCbmdhOFV0QkNjNHUw?=
 =?utf-8?B?VDhqZklvc0hDV0V6NUt5L0RvZVJJdlduMlBteTMwZW8zNktjMlhUOFBLWEdk?=
 =?utf-8?B?UFE1V0NYVHVDZ2JFcnUwU2k0M0JEdi9Vd0MwZVlMbittUENyVzMxMGJPQnhy?=
 =?utf-8?B?aGRxQWVsTTBuZGhMamg2V3EvR1ROeTNEcENzMlBzNUk1dkl4blZ3TU5RcjlQ?=
 =?utf-8?B?Rk55c3Y3ek8vbVVaTGZ2NTNxbEQ0c1pzS2swcFZMVjZKajhqSWRXQzczRVBZ?=
 =?utf-8?B?WDRlU2JnOG52YXZtYWhNS3g5NS8rd2Z3OFJJbDVZQ2dVTUI1VlNLQUl1OXU1?=
 =?utf-8?B?Z0JQdWhVU3V4RHJMLzJEZ0JWc3pFMVovbkxsM1p5bnM5d1JmOEw3WlZRKy9S?=
 =?utf-8?B?dURSWmRFcDJFZE4yQ2dEQzl1VVo0NkxHc1RjRTcyS1Fjd2E4b0oyUTlNREdp?=
 =?utf-8?B?dlhHczViVEo1dW5EbXQzUXdCQ1JFKzNqZTlMM0JDa2t6NFF6bzdMcmdrS2Zy?=
 =?utf-8?B?eEF5alZBelZLVGNzdjdnaVZFSVpla24zV1dtWXJwYThoNXMzT09CQy9nQUV0?=
 =?utf-8?B?QUtVNWpLNi9aQ0VKNXVpQ2ZyUXVJK2xIeThraUY2QTcyajVtVE1rckQ1VDQ2?=
 =?utf-8?B?RFpQQ1BQcjhxV3NTTGsvSFVDb2JEbGdhRTZwTmw1UHY2bjFFak9QTXVwSnVk?=
 =?utf-8?B?WG1VUTRBZjdXVHN2TU5CaVlxQmNIQ09Ib0s1Y3JvQVVaVS8xRDJQM0EyOGxv?=
 =?utf-8?B?cEF6dHpHVGprT0FUSkJLRmQ4bGwra1dDQ0xDTmRJTnkvOEsyN0hFNGQ3QURY?=
 =?utf-8?B?MlFMTHVSdzk5eE5wRzVTbHZYYUtrTXRFZSt0UnRzRS83VXF0V0VhVUNORUs1?=
 =?utf-8?B?eWg1VG9vNnBDTUs0MTBVU2NRbXMzSXYxam5lUFdpbFY0eEsyeXNkN0FuMHhk?=
 =?utf-8?B?Tis4a2ZMSHNoVWF3eGpQZld1TVlwUytMemIrclY5Vi9aTXhQNGJkR2lGdVh3?=
 =?utf-8?B?STg4R1lUeGlGck15c3MyU0dYQWpBTnBRd2pmZjV2Z0lsR04vS2hlL2RvbHJz?=
 =?utf-8?B?M3JjeHd5SDBqN2tPNEN3SGw3SFBmd3NhakRCK2FwWVFFL29iTjIzUVVFcldi?=
 =?utf-8?B?eXVTYnhJd1ZnMTVsWHp4VWorZEJFd1lyQUdXdXlRMW1FT2JOOWxITndEcERk?=
 =?utf-8?B?aDVWbUxLRUdDZTB5QVdSMVZWWEl2R0JLdHBWSE82aHpxK3Q5a0hURjAvYmlJ?=
 =?utf-8?B?UURBczNuU05tZFJ6YndBb2xCZHJqczZMNzBUQkxLYWFlM01mdEM1aGVFK3JU?=
 =?utf-8?B?dlVDTklZSUx1ZTNPUytYR0lmWE5FeFV2d2hQV3lRS0RONnlkcy80aGN2WVV5?=
 =?utf-8?B?ajkzSGY1Q016RzlvMzU2R3M3aDgyczVqQmRCYkhTK0I5ZTRON01uTDlSZmlN?=
 =?utf-8?B?cFphQW4vTWpjV2FpMy8wOWdLZ1ZKN2xTcTZYcjNhcFMwWWczVXlrRG9wZE85?=
 =?utf-8?B?OVV1cjNVakdvb2VaRmd4c242S3dGR0J3NlhmOTVPTWF1N2J4RmhycDhyb08y?=
 =?utf-8?B?LzlhOEpGY1BCdCt1RVdGU1RFazcyT0hOOStZY3dheTc1YWxvMTh0R1FQaWQr?=
 =?utf-8?B?SWJjSnRqYWIxRjY1L2F6QkZoZ0xURC9PempKdjBxV0hIK2FxS2hFb1hvYU1X?=
 =?utf-8?B?bUdZTDV3S3NwOVl2SDdZL3Yvc1dGWEVYRVEwcjZCbkY3Ylo4S2Q2bmJPZ2ZO?=
 =?utf-8?B?RktwekQzU2hMbU9oRFpwNlhlZWdsSjUwN0NiRThSTkdHY1c1WDZkN3hqbGR6?=
 =?utf-8?B?MmNIaXBlTTNPQ1VLRWhkZ0g5b2dISC8yVlh5UkUzeVVvYUNFdldwZFA1NVNu?=
 =?utf-8?B?Y05xYVliMUg5Qjh6dDdqQ2lKN2wwdGlWcEFadGZvT0M4RDkzeUVSSS85Wmk5?=
 =?utf-8?B?ekdiRjI3cDIxVlhOdkMvUVMwZ2J4K2h5NEVZakx3aHp6cjZWVFhPVlNnaFBJ?=
 =?utf-8?B?V1JkYmd3d0t3c0xsdDJ0YU9IYWJ4OXk0T1FmaXE4c1l2c1lmMU85dXFnalZl?=
 =?utf-8?B?aUpKTUhJVnlaZjlCUW92dmkwNjhnWWRHUW9zelh0ampYWFJZNkZQTGZwS1A5?=
 =?utf-8?B?Ym5NbEo5dWZGVDhiUlpCS2dkS3J3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <930E77E8A1B1724CA5DF6B6DFDDE776B@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6f5406-9ac8-4753-0c39-08dd668322cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 01:12:36.6872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kYu0YldH0A0UGyqCgI2W44NHoBapOrjEEqYtg0Wfqk4o3QoXR2uzPvn57fztjg7lh4vbYO5u53AUEgzlxA9jqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB4405

T24gVHVlLCAyMDI1LTAzLTE4IGF0IDIzOjU5ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFR1ZSwgMjAyNS0wMy0xOCBhdCAxNjo1MiAtMDcwMCwgUmljayBNYWNrbGVtIHdyb3Rl
Og0KPiA+IE9uIFR1ZSwgTWFyIDE4LCAyMDI1IGF0IDQ6NDDigK9QTSBUcm9uZCBNeWtsZWJ1c3QN
Cj4gPiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+ID4gWWVzLCBJ
IGFsc28gcmVhbGlzZSB0aGF0IG5vbmUgb2YgdGhlIGFib3ZlIG9wZXJhdGlvbnMgYWN0dWFsbHkN
Cj4gPiA+IHJlc3VsdGVkDQo+ID4gPiBpbiBibG9ja3MgYmVpbmcgcGh5c2ljYWxseSBmaWxsZWQg
d2l0aCBkYXRhLCBidXQgYWxsIG1vZGVybiBmbGFzaA0KPiA+ID4gYmFzZWQNCj4gPiA+IGRyaXZl
cyB0ZW5kIHRvIGhhdmUgYSBsb2cgc3RydWN0dXJlZCBGVEwuIFNvIHdoaWxlIG92ZXJ3cml0aW5n
DQo+ID4gPiBkYXRhDQo+ID4gPiBpbg0KPiA+ID4gdGhlIEhERCBlcmEgbWVhbnQgdGhhdCB5b3Ug
d291bGQgdXN1YWxseSAodW5sZXNzIHlvdSBoYWQgYSBsb2cNCj4gPiA+IGJhc2VkDQo+ID4gPiBm
aWxlc3lzdGVtKSBvdmVyd3JpdGUgdGhlIHNhbWUgcGh5c2ljYWwgc3BhY2Ugd2l0aCBkYXRhLCB0
b2RheSdzDQo+ID4gPiBkcml2ZXMNCj4gPiA+IGFyZSBmcmVlIHRvIHNoaWZ0IHRoZSByZXdyaXR0
ZW4gYmxvY2sgdG8gYW55IG5ldyBwaHlzaWNhbA0KPiA+ID4gbG9jYXRpb24NCj4gPiA+IGluDQo+
ID4gPiBvcmRlciB0byBlbnN1cmUgZXZlbiB3ZWFyIGxldmVsbGluZyBvZiB0aGUgU1NELg0KPiA+
IFllYS4gVGhlIFdyX3plcm8gb3BlcmF0aW9uIHdyaXRlcyAwcyB0byB0aGUgbG9naWNhbCBibG9j
ay4gRG9lcw0KPiA+IHRoYXQNCj4gPiBndWFyYW50ZWUgdGhlcmUgaXMgbm8gIm9sZCBibG9jayBm
b3IgdGhlIGxvZ2ljYWwgYmxvY2siIHRoYXQgc3RpbGwNCj4gPiBob2xkcw0KPiA+IHRoZSBkYXRh
PyAoSXQgZG9lcyBzYXkgV3JfemVybyBjYW4gYmUgdXNlZCBmb3Igc2VjdXJlIGVyYXN1cmUsDQo+
ID4gYnV0Pz8pDQo+ID4gDQo+ID4gR29vZCBxdWVzdGlvbiBmb3Igd2hpY2ggSSBkb24ndCBoYXZl
IGFueSBpZGVhIHdoYXQgdGhlIGFuc3dlciBpcywNCj4gPiByaWNrDQo+IA0KPiBJbiBib3RoIHRo
ZSBhYm92ZSBhcmd1bWVudHMsIHlvdSBhcmUgdGFsa2luZyBhYm91dCBzcGVjaWZpYw0KPiBmaWxl
c3lzdGVtDQo+IGltcGxlbWVudGF0aW9uIGRldGFpbHMgdGhhdCB5b3UnbGwgYWxzbyBoYXZlIHRv
IGFkZHJlc3Mgd2l0aCB5b3VyIG5ldw0KPiBvcGVyYXRpb24uDQoNCkFjdHVhbGx5LCBsZXQgbWUg
Y29ycmVjdCB0aGF0Li4uIEknbSBub3QgYXdhcmUgb2YgYW55IHJlcXVpcmVtZW50IG9uDQphbnkg
b2YgdGhlIE5GU3Y0LjIgb3BlcmF0aW9ucyBvciB0aGUgTkZTdjQuMiBleHRlbnNpb25zLCB0aGF0
IGV4cGVjdA0KdGhlIHBlcm1hbmVudCBhbmQgaXJyZXZvY2FibGUgZGVsZXRpb24gb2YgZGF0YS4N
CkkgZGVmaW5pdGVseSB3b24ndCBzYXkgdGhlcmUgaXNuJ3QgYSB1c2UgY2FzZSBmb3IgaXQsIGJ1
dCBJIGFtIHNheWluZw0KdGhhdCBpdCBpc24ndCBjb3ZlcmVkIGJ5IGFueSBORlMgcHJvdG9jb2wg
dG9kYXkuDQoNCklPVzogaWYgZGF0YSB3aXBpbmcgaXMgd2hhdCB5b3UncmUgYWN0dWFsbHkgbG9v
a2luZyBmb3IgaGVyZSwgdGhlbiBJDQp0aGluayB0aGF0IG5lZWRzIHRvIGJlIGEgbmV3IG9wZXJh
dGlvbiwgYW5kIHdlJ2xsIG5lZWQgYSBsb3Qgb2YNCmRpc2N1c3Npb24gYWJvdXQgaG93IHRoZSBO
RlMgcHJvdG9jb2wgc2hvdWxkIGRlYWwgd2l0aCBhbGwgdGhlIHZhcmlvdXMNCndheXMgaW4gd2hp
Y2ggbm90IGp1c3QgdGhlIHN0b3JhZ2UsIGJ1dCBhbHNvIHRoZSBmaWxlc3lzdGVtIGdvIGFib3V0
DQp0cnlpbmcgdG8gcHJlc2VydmUgZGF0YS4gV2UgY2FuIHByb2JhYmx5IGxlYXZlIHRoZSBleGlz
dGVuY2Ugb2YNCmV4dGVybmFsIGJhY2t1cHMgYXMgYW4gZXhlcmNpc2UgZm9yIHRoZSB1c2VyLi4u
IPCfpJTvuI8NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRh
aW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

