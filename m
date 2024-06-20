Return-Path: <linux-nfs+bounces-4201-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BE3911712
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 01:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00FA01C2085F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 23:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF67158DA1;
	Thu, 20 Jun 2024 23:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="VXNRVeXu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2102.outbound.protection.outlook.com [40.107.92.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29177CF39
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718927828; cv=fail; b=Cmd0AycetuCpcWvj1gPZfk+KH1w0FCmZ2LtN32TtgNFJbbZ/Z7M0yanU8gm1veyKaAXJpu7BBXYofyI/4AWWsS3t5IWQ7emBn3TNCDOlEsy4DQkTZutVB++g9lHwtyr9N44bTRZAy2HSln7Dr5HG7pYRnrkXQ+B10cMdWehd/5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718927828; c=relaxed/simple;
	bh=8xJdNwEoRXGeJbwsKW+htoaHGX+ZAT0IY1KqGlgeqWY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Iy+sd80jsvf8T+lY/klEjcIpvhVFRjN4oxa6VkKP/tl4xPhPy0+5ckzRLsyqwsPP04zQTa9b3VneSyTiBCaLUEki4iDkbfehb/fb+Y9/djzMO2E4+NJX1xh07Z7St0BE+NuhTYcvqfGP65AT00UCYE4cyC+3gz6bHi7L3bGIuwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=VXNRVeXu; arc=fail smtp.client-ip=40.107.92.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mA3SBxw8Cn1bR8l6aSNVaVuBdWDOWnJJwRCD3oZllnXQBa7nvhabdL+MNWWYMf2JAAwffQOrp8s4OBcLjogF9d6vC938mI37Fkk/4OhGa6k4JclsRrtNjAr5+PpSQp0BNnt1BOu5Vr/Q8NKUetSzyB9v/F8lOYl69/JTmJzMAyLZGW2MWka63m/QG/MsE9ZRKWr1RJ9618ug3xU+CNwzcPKO5mvVSGnSnYK7wZZeusiAR6Mg2oUITlm5hn36rxin1MiJceT1bkd/RBvEnvJg8kH/Nw3Rbqthjki99mVSbB1cwYHC8dVB4FzkYxJiEk+bPw+Ij7Pi9oLhIMD4TLYcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xJdNwEoRXGeJbwsKW+htoaHGX+ZAT0IY1KqGlgeqWY=;
 b=m9Ue8yU2GEoBNnHf5D+eBYq1RHdDW2yt6rnst6ZbxSCmauhcJLHi27WczTheAM0eJ7Iz1aQgC7xAOVsTRnX8aTkaoOTHF2NwyTYinCw5pmQABojav4edpJGY2gskY3lvSOzcp/ZOhwTpHbvi+FHlKtQLLPhGwmlan0vveXy2KC4uZR1+9FWtBu1Q91A5gC1rMnpo/ghPfo4gBjQSsMuPeV9y6++v6LerNct4Y4g8gTIZskiqnnRDu4DcZkJnnwJWWVJXlfISe2VeLU/LLtrCPtbP/KNKCsXeHXNWdEmW0mKKxfiHXRmOIw1MVAtY6X5xONqPUaU1O8Kw7nUb1orhBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xJdNwEoRXGeJbwsKW+htoaHGX+ZAT0IY1KqGlgeqWY=;
 b=VXNRVeXuxUdysYW7u3SjCVqeWir9IYU/mfPrLaqAbGgPPQsns2z155F76GJ0b9rFttvxdpNDfPadeVDymd2kI+U+dbEeMuJKwGNEfSsGhHs4TW2fF37dxRQURDvCPPQyIDh2LGf/oiJ2EDUp84uigGlz4bROT6khB4srf2HgIpc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH3PR13MB6337.namprd13.prod.outlook.com (2603:10b6:610:196::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.20; Thu, 20 Jun
 2024 23:57:02 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 23:57:02 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "neilb@suse.de" <neilb@suse.de>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
CC: "david@fromorbit.com" <david@fromorbit.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: knfsd performance
Thread-Topic: knfsd performance
Thread-Index:
 AQHawa3dybcUo3ed40e1woBUDQls6LHN2rIAgAANu4CAAAKdAIAAAygAgAABH4CAAFB+AIAABSQAgAFWC4CAAFUVgIABDUAAgAA7F4CAAB9OAA==
Date: Thu, 20 Jun 2024 23:57:02 +0000
Message-ID: <29d3632a6bcf2924260d3ac632f7d2f2a1216b24.camel@hammerspace.com>
References: <>, <2F6F431C-59AE-4070-B7FF-CF456B95CBB1@oracle.com>
	 <171892109781.14261.15071047015400493177@noble.neil.brown.name>
In-Reply-To: <171892109781.14261.15071047015400493177@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH3PR13MB6337:EE_
x-ms-office365-filtering-correlation-id: c68ed0b7-4b54-429a-8351-08dc9184ae40
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q1czQjZiR1h3dTk2cjd0NmRmc2E5OHY4NVcvV1QwbW5ZVTdSUThzMTFYKzUv?=
 =?utf-8?B?VzEvTW9hVy82S2V3ejNQdEY0bElYMEZVZGh4aG9VOThrZ1N0aXlXYVZWci9j?=
 =?utf-8?B?MThpUDhNTEhWMWx0cnppTW9FeEN0VkpLVzZoRGlETlcvT3F0eVhwR3NIa0py?=
 =?utf-8?B?Um1xeXN5V3VYT3hTOHFmbWFXY0tiVWVIcFF2bXNsUHdWSmdBN0JDUm1KVHd2?=
 =?utf-8?B?QzFhRGYvMTl6Q3RIaHR2UHZNTmxtT1JiMVBVemZSOWFzWWtSdm9qTkIwMTA0?=
 =?utf-8?B?VzhUczZSWEJ1d3NkemkzU3pTQU5IcnpiOFlOenRKNm9QN3JTeElheDA2eDhM?=
 =?utf-8?B?YWpmRGZVZ25tQnVKRlp4ZUJNQks1cnZ3KzlZQTcwWXpsOHhpOVZVUUpqKzdE?=
 =?utf-8?B?VXMvSGZRbkF5TzcwNFhud0p3SmlZUDJBWjNZMzdpZE94bll3RmNBSkN6cm1D?=
 =?utf-8?B?NjQ4cENUOWZyOER6bVpRQUFKbDU1K2lXWGJGR2cvbktxcGpjRGZpM2M4NnU2?=
 =?utf-8?B?bkJ3WGZFNXpBaTFXMTgzYzRWUjcvUGt6VzllODhVWEFXTUNDWFh6M3krTzdB?=
 =?utf-8?B?SHI4YjBXTHhiVEE3YzhoaFlZUW8xV0lJMlVvNHh0MmJWZlRnSjRPK2I1eVZ4?=
 =?utf-8?B?MlhoN1hIN0Z4Mm9NenNFUWxUbEYyVzloMWpDZVliUVJ1L0FXNWZXYTFiOUMw?=
 =?utf-8?B?SFVPZXBjMVlDenlkWWhnU3FKMGV1NXJrMUNoM1lCQUg2WEFXSVlDRmwyamQz?=
 =?utf-8?B?T25mSW5WM0p4L1dYZmFScFJ4T2UweCtWTUYvaHg0WVFKZVhXZVl4Q1dNWGda?=
 =?utf-8?B?VC9leHBlN1d5UHFsQ2I5TVlQck1nRER4bEluZVN4Qi9sR2UyajRXVE5INENZ?=
 =?utf-8?B?SFB4UEJjNmsvY0VRWUR3K29ERU4wNkp5M2FmdWU1Q0EvZ0ZIZGhremtMYUcx?=
 =?utf-8?B?UE9mZ2F0clQyNGd1cTlpRGtNSmJrZGVSbmVrRjBMMm5rSUxQamdRTzY4U1NV?=
 =?utf-8?B?ZVR5QlZpdkJDNGdpTmpwTXZoWUJRa01ETHVPYkFLRDh6UmZEU2gvNk52Ymln?=
 =?utf-8?B?TUpOKzFsdytEbVp4QzVCZFNPTkQ1S1Q1S041UUpkNUdyRTIvMjh3RnBZRUZX?=
 =?utf-8?B?cFZONjlibDNiYlp6bys1SEkrQm5qUEFZdUhreGxpbjFQN0ZBbUdSOXkyaHJU?=
 =?utf-8?B?akZJcS9FaTN2RitXWGIvV1lPMm5NQ2ZHaStpYy9ieWlNNm1WVDQ5bGJGWGcy?=
 =?utf-8?B?bDdncmo3a3BDRDJRbGJYeVhBZXRXMnNkTkZ6RTRwRWc4RFJvMjVSQ2JmNjEz?=
 =?utf-8?B?VUh0TEhBQ3F2TEZoMmVXeGJoeE85blN1dkRzRWRLTUFXcGs0bW14em1LWWp2?=
 =?utf-8?B?WmYweFZrRjN4NSsrKzdpRjAzT2xvVmJGRUo3aTVPNHdqRGc1ZkFvTUcvZHJZ?=
 =?utf-8?B?L2VmNHJLY0VNTU9nVUZ5cDhQNmJGeHcvSUNsUm1nVEg3VmpUVjhjU1o5cWZM?=
 =?utf-8?B?Y3I1Q0p5R1lCUzFUeVBsOVdDMnhVQ3RMdU9YT1U4Y2pyNXVtdUtzTktYaEV4?=
 =?utf-8?B?Ryt2ZkpQVGFsQlJ0Rmk0TXB6ZUZ0VlZsNlJ1YmRNS0hRRXAwV0RkRCtacUlD?=
 =?utf-8?B?UVY3YitFRWo0U2lPZ1F4UW9LTW8vWWNOWUdYSThvRGNtUG5WUHlKeVNhUkU1?=
 =?utf-8?B?Yy8zRTJSemFuaHRkcE84UWRhRHMzcUlla1VBTVg4bDA2VTZaRWt4SnlZWkpj?=
 =?utf-8?Q?eBt+c4iNVJKqoxIzy6+D55VbGdkREjWq+4NJvid?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VUNueVJ3V3F0RDJwcis1RlYzeWVRaHFuQVNER2RmS1RVNklCa0RMRGxlTldv?=
 =?utf-8?B?Qzh4dWhYa1FCMXMxS1QyVjBrdkZpLzBYT2xrbm42YmIzSjN2WHZ0WGU1QUsv?=
 =?utf-8?B?dXNuTVpvblJuc0EwUWg5SU9oNkQ3NVdxNmk0QUNXUzhmdWd0dklyS0Jjejgx?=
 =?utf-8?B?UWozKzlZZ3hBMWU1NTd4UiszUTgxTTB1aVRNSGNUTXpKeHgxSVRaL2lvZkhu?=
 =?utf-8?B?aUU0aFByUW9LN1lNaTl6bEYyMWc1T04rMXhQZTBVRU9YUEVEbkZGdUoxSnJH?=
 =?utf-8?B?aForVU9WSFpwWDEzZklwRTBRemc3YVlpeXBHWXFpOG1HWlp0ZnpTUGdnSU50?=
 =?utf-8?B?b2xqWFJRbjdzR0YvTytmcFl4akRVM0hCb0pzMHByZ095bjhTR0tUdWdTcTJx?=
 =?utf-8?B?REVlUUI4V2JlS3hlTTFFZTM3VW1mVndUSzRrL0laSGREYS8vRmRVcnRrS3Bx?=
 =?utf-8?B?enMwa3NlbGhxUldxcWRpcUU0MmRKbGlYMnMyQUlUMk5jcXE4aERZU3A1SC9L?=
 =?utf-8?B?MGVudWY4U2hsTVdEV01FTy96cWQ5RnNvWWNJZnMydm5DUDM1c0cva1FZT2NI?=
 =?utf-8?B?U1c3Q0tOUGJ1ZWZSQmJWRkNhTkVEbTRUMDdBSjRxbnA3VjhZTkorM0xRbVll?=
 =?utf-8?B?THV2K3dUUnBEdG1vZmVzT001V0I3eUR5VzFXcms5L0REWFFmNG1DNzFIVzZV?=
 =?utf-8?B?R1pVcVhsZDFFek5FbTdwVkhuRHBvTVNTZlc2ZVlqK1BCVkF0YTNCV3lSeUFm?=
 =?utf-8?B?RmZFeFNXWkVVeWJuUzlDbWxCTU5QWXRnMThPLzFHeGg1M1NUcnRhNWluc0xz?=
 =?utf-8?B?OVpodExUYk5ockVHQUNOR0s4VVI2MkdIT0JJdzl1cFRWaDhwcDRHelNXL21u?=
 =?utf-8?B?UThybUNFSEZtbkk5V1ZFN0p3RE84WktoSlRPNVRSRWdDL1FiVkEyQTlTdGh2?=
 =?utf-8?B?VXdoY01Qakt3cXhqOHEyVUdzcytQSzdSdHpiTllmREFIa0xuTGNMTmIvS1Bp?=
 =?utf-8?B?TmF2Y3dPczlBMER3MEdtSFlmcGR6c2hqaDFPNmo5RjQ3MFdOSndaRlZpQU0x?=
 =?utf-8?B?WHNQck5iVk1EcGJsMGFHRzdFZUVQYTdtTGFyUlZOTHU1M0ZRM0N1RXNNNmU4?=
 =?utf-8?B?M0NRZm9lZmhOd2o1S1ZYL1REQUN6TFBTNGd5NHdVcHYzcG8rRVlTTlR6WWJp?=
 =?utf-8?B?QTc4ZnVIb0tvQTlQQnBFb1ZaOUF0cmRDOVJNUnIzclY0WmE5QWdqTHpEdy9j?=
 =?utf-8?B?cm5JUHRTcW0wbnNKenFWUXg0c1RHdTc4VE55MWE5UHVtQ2UxVDgxalloRWE1?=
 =?utf-8?B?VDNCS05PNlF6Q00vcFBCSFpYeVNsY3NNRjd0RlBpNFVYUjlZK0ExRlJ3Ymdz?=
 =?utf-8?B?T0ErK3hqRlNuUnYwcHFIRzdKcmFEdnRMdE12QmJBeTV5SkNDQm9sTEtyY3hu?=
 =?utf-8?B?QlkxdkxJM1lFTzg2aGhWSG94NmptTnlqUk85bGlhRHlxbEpyWE5oZ2VyOVJi?=
 =?utf-8?B?K2lxdys4UUdFUWpJbnJKV3R2cHBoMC9lZ3Yybm0yekZZTlFxbXpnYlFrQ1VB?=
 =?utf-8?B?KzNCN3R4eG9OZmg3anJ1VjV5OXBEeWw4K3oyak56S28rVzNna05ZQ0dGWm9a?=
 =?utf-8?B?Z2c4VDBPc0NXcmFsU3lYUnVxbXNoYU1SckI5SHlwY2U0SjQrTkJ6YzJqcng5?=
 =?utf-8?B?VkEraUtwTXBUeEhZekRUS2NPZGdFV3hoOCt1c3N5d2VySHgvdlVzVHEzTGZv?=
 =?utf-8?B?Nk5pTFdnbHJKRzZuS1g2NDk4M0h3eGIvSXphbExlanNoRzYyb0xOc2NxQWpE?=
 =?utf-8?B?bFZ0K2hwZVJsek10bXVaU3VieUtKczN2aXBLMjNoWWlYT05yckx3bURkNCtu?=
 =?utf-8?B?R2JYZFA1enJFbFFEV2hzVFJjRjU0UzhLOFZvYXVSSWNvRE9NaDRqNnlYd2pS?=
 =?utf-8?B?T3B4RHkzL0k4amJHdjk3U1JsSEpsRDRhYTB4eVdONlZ6Zkt5NU9ZTTV3cXE1?=
 =?utf-8?B?SU1aYldCdFVZWmh0TWhDZkNhci9idy83RTJXdGF4bFpSV3NlY09JSEJud3oy?=
 =?utf-8?B?YXVmamdNQVZnQ2JuYUxTd3hKT29iU1paRDdBZUxqcEhpcmF1VS9XWEpqTmRz?=
 =?utf-8?B?dTQ0WmNOUHdjZk1NdkRzV255V1JtK2x5VzlicC9QSDhVRHpBcmUzOTM4cVdF?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47501AAA7724D64298FB6F96DB1889B5@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c68ed0b7-4b54-429a-8351-08dc9184ae40
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 23:57:02.4445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s8YGdKz+FUBI1evpsddLXMoUs/8KFn03jqpQfchfxDyx03fAnZixAymOJTdIE1Iifgh88CtjtXnE5aF/dZhi/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR13MB6337

T24gRnJpLCAyMDI0LTA2LTIxIGF0IDA4OjA0ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IEZyaSwgMjEgSnVuIDIwMjQsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4gPiANCj4gPiANCj4g
PiA+IE9uIEp1biAxOSwgMjAyNCwgYXQgMTA6MjnigK9QTSwgRGF2ZSBDaGlubmVyIDxkYXZpZEBm
cm9tb3JiaXQuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiANCj4gPiA+IE9uIFRodSwgSnVuIDIw
LCAyMDI0IGF0IDA3OjI1OjE1QU0gKzEwMDAsIE5laWxCcm93biB3cm90ZToNCj4gPiA+ID4gT24g
V2VkLCAxOSBKdW4gMjAyNCwgTmVpbEJyb3duIHdyb3RlOg0KPiA+ID4gPiA+IE9uIFdlZCwgMTkg
SnVuIDIwMjQsIERhdmUgQ2hpbm5lciB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIFR1ZSwgSnVuIDE4
LCAyMDI0IGF0IDA3OjU0OjQzUE0gKzAwMDAsIENodWNrIExldmVyIElJSQ0KPiA+ID4gPiA+ID4g
d3JvdGXCoCA+IE9uIEp1biAxOCwgMjAyNCwgYXQgMzo1MOKAr1BNLCBUcm9uZCBNeWtsZWJ1c3QN
Cj4gPiA+ID4gPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gT24gVHVlLCAyMDI0LTA2LTE4IGF0IDE5OjM5ICswMDAw
LCBDaHVjayBMZXZlciBJSUkNCj4gPiA+ID4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIEp1biAxOCwg
MjAyNCwgYXQgMzoyOeKAr1BNLCBUcm9uZCBNeWtsZWJ1c3QNCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgMjAyNC0wNi0xOCBhdCAxODo0MCArMDAwMCwgQ2h1
Y2sgTGV2ZXIgSUlJDQo+ID4gPiA+ID4gPiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
T24gSnVuIDE4LCAyMDI0LCBhdCAyOjMy4oCvUE0sIFRyb25kIE15a2xlYnVzdA0KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gSSByZWNlbnRseSBiYWNr
IHBvcnRlZCBOZWlsJ3MgbHdxIGNvZGUgYW5kDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBzdW5y
cGMgc2VydmVyDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBjaGFuZ2VzIHRvDQo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiBvdXINCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IDUuMTUuMTMwIGJhc2Vk
IGtlcm5lbCBpbiB0aGUgaG9wZSBvZiBpbXByb3ZpbmcNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IHRoZSBwZXJmb3JtYW5jZQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gZm9yDQo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiBvdXINCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGRhdGEgc2VydmVycy4N
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gT3VyIHBl
cmZvcm1hbmNlIHRlYW0gcmVjZW50bHkgcmFuIGEgZmlvDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiB3b3JrbG9hZCBvbiBhIGNsaWVudA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdGhhdA0KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gd2FzDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBkb2luZyAx
MDAlIE5GU3YzIHJlYWRzIGluIE9fRElSRUNUIG1vZGUgb3ZlciBhbg0KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gUkRNQSBjb25uZWN0aW9uDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAoaW5maW5p
YmFuZCkgYWdhaW5zdCB0aGF0IHJlc3VsdGluZyBzZXJ2ZXIuDQo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiBJJ3ZlIGF0dGFjaGVkIHRoZQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gcmVzdWx0aW5n
DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBmbGFtZSBncmFwaCBmcm9tIGEgcGVyZiBwcm9maWxl
IHJ1biBvbiB0aGUNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHNlcnZlciBzaWRlLg0KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBJcyBhbnlvbmUgZWxz
ZSBzZWVpbmcgdGhpcyBtYXNzaXZlIGNvbnRlbnRpb24NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IGZvciB0aGUgc3BpbiBsb2NrDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBpbg0KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gX19sd3FfZGVxdWV1ZT8gQXMgeW91IGNhbiBzZWUsIGl0IGFwcGVhcnMg
dG8gYmUNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGR3YXJmaW5nIGFsbA0KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBvdGhlcg0KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gbmZzZCBhY3Rpdml0eSBvbiB0aGUgc3lzdGVtIGluIHF1ZXN0aW9uIGhl
cmUsDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBiZWluZyByZXNwb25zaWJsZQ0KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gZm9yDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA0NSUNCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IG9mIGFsbCB0aGUgcGVyZiBoaXRzLg0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiBPdWNoLiBfX2x3cV9kZXF1ZXVlKCkgcnVucyBsbGlzdF9yZXZlcnNlX29yZGVyKCkg
dW5kZXIgYQ0KPiA+ID4gPiA+ID4gc3BpbmxvY2suDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
IGxsaXN0X3JldmVyc2Vfb3JkZXIoKSBpcyBhbiBPKG4pIGFsZ29yaXRobSBpbnZvbHZpbmcgZnVs
bA0KPiA+ID4gPiA+ID4gbGVuZ3RoDQo+ID4gPiA+ID4gPiBsaW5rZWQgbGlzdCB0cmF2ZXJzYWwu
IElPV3MsIGl0J3MgYSB3b3JzdCBjYXNlIGNhY2hlIG1pc3MNCj4gPiA+ID4gPiA+IGFsZ29yaXRo
bQ0KPiA+ID4gPiA+ID4gcnVubmluZyB1bmRlciBhIHNwaW4gbG9jay4gQW5kIHRoZW4gY29uc2lk
ZXIgd2hhdCBoYXBwZW5zDQo+ID4gPiA+ID4gPiB3aGVuDQo+ID4gPiA+ID4gPiBlbnF1ZXVlIHBy
b2Nlc3NpbmcgaXMgZmFzdGVyIHRoYW4gZGVxdWV1ZSBwcm9jZXNzaW5nLg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IE15IGV4cGVjdGF0aW9uIHdhcyB0aGF0IGlmIGVucXVldWUgcHJvY2Vzc2luZyAo
aW5jb21pbmcNCj4gPiA+ID4gPiBwYWNrZXRzKSB3YXMNCj4gPiA+ID4gPiBmYXN0ZXIgdGhhbiBk
ZXF1ZXVlIHByb2Nlc3NpbmcgKGhhbmRsaW5nIE5GUyByZXF1ZXN0cykgdGhlbg0KPiA+ID4gPiA+
IHRoZXJlIHdhcyBhDQo+ID4gPiA+ID4gYm90dGxlbmVjayBlbHNld2hlcmUsIGFuZCB0aGlzIG9u
ZSB3b3VsZG4ndCBiZSByZWxldmFudC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJdCBtaWdodCBi
ZSB1c2VmdWwgdG8gbWVhc3VyZSBob3cgbG9uZyB0aGUgcXVldWUgZ2V0cy4NCj4gPiA+ID4gDQo+
ID4gPiA+IFRoaW5raW5nIGFib3V0IHRoaXMgc29tZSBtb3JlIC4uLi7CoCBpZiBpdCBkaWQgdHVy
biBvdXQgdGhhdCB0aGUNCj4gPiA+ID4gcXVldWUNCj4gPiA+ID4gZ2V0cyBsb25nLCBhbmQgbWF5
YmUgZXZlbiBpZiBpdCBkaWRuJ3QsIHdlIGNvdWxkIHJlaW1wbGVtZW50DQo+ID4gPiA+IGx3cSBh
cyBhDQo+ID4gPiA+IHNpbXBsZSBsaW5rZWQgbGlzdCB3aXRoIGhlYWQgYW5kIHRhaWwgcG9pbnRl
cnMuDQo+ID4gPiA+IA0KPiA+ID4gPiBlbnF1ZXVlIHdvdWxkIGJlIHNvbWV0aGluZyBsaWtlOg0K
PiA+ID4gPiANCj4gPiA+ID4gwqBuZXctPm5leHQgPSBOVUxMOw0KPiA+ID4gPiDCoG9sZF90YWls
ID0geGNoZygmcS0+dGFpbCwgbmV3KTsNCj4gPiA+ID4gwqBpZiAob2xkX3RhaWwpDQo+ID4gPiA+
IMKgwqDCoMKgwqAgLyogZGVxdWV1ZSBvZiBvbGRfdGFpbCBjYW5ub3Qgc3VjY2VlZCB1bnRpbCB0
aGlzDQo+ID4gPiA+IGFzc2lnbm1lbnQgY29tcGxldGVzICovDQo+ID4gPiA+IMKgwqDCoMKgwqAg
b2xkX3RhaWwtPm5leHQgPSBuZXcNCj4gPiA+ID4gwqBlbHNlDQo+ID4gPiA+IMKgwqDCoMKgwqAg
cS0+aGVhZCA9IG5ldw0KPiA+ID4gPiANCj4gPiA+ID4gZGVxdWV1ZSB3b3VsZCBiZQ0KPiA+ID4g
PiANCj4gPiA+ID4gwqBzcGlubG9jaygpDQo+ID4gPiA+IMKgcmV0ID0gcS0+aGVhZDsNCj4gPiA+
ID4gwqBpZiAocmV0KSB7DQo+ID4gPiA+IMKgwqDCoMKgwqDCoCB3aGlsZSAocmV0LT5uZXh0ID09
IE5VTEwgJiYgY21wX3hjaGcoJnEtPnRhaWwsIHJldCwNCj4gPiA+ID4gTlVMTCkgIT0gcmV0KQ0K
PiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiB3YWl0IGZvciBlbnF1ZXVlIG9mIHEtPnRh
aWwgdG8gY29tcGxldGUgKi8NCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3B1X3JlbGF4
KCk7DQo+ID4gPiA+IMKgfQ0KPiA+ID4gPiDCoGNtcF94Y2hnKCZxLT5oZWFkLCByZXQsIHJldC0+
bmV4dCk7DQo+ID4gPiA+IMKgc3Bpbl91bmxvY2soKTsNCj4gPiA+IA0KPiA+ID4gVGhhdCBtaWdo
dCB3b3JrLCBidXQgSSBzdXNwZWN0IHRoYXQgaXQncyBzdGlsbCBvbmx5IHB1dHRpbmcgb2ZmDQo+
ID4gPiB0aGUNCj4gPiA+IGluZXZpdGFibGUuDQo+ID4gPiANCj4gPiA+IERvaW5nIHRoZSBkZXF1
ZXVlIHB1cmVseSB3aXRoIGF0b21pYyBvcGVyYXRpb25zIG1pZ2h0IGJlDQo+ID4gPiBwb3NzaWJs
ZSwNCj4gPiA+IGJ1dCBpdCdzIG5vdCBpbW1lZGlhdGVseSBvYnZpb3VzIHRvIG1lIGhvdyB0byBz
b2x2ZSBib3RoDQo+ID4gPiBoZWFkL3RhaWwNCj4gPiA+IHJhY2UgY29uZGl0aW9ucyB3aXRoIGF0
b21pYyBvcGVyYXRpb25zLiBJIGNhbiB3b3JrIG91dCBhbg0KPiA+ID4gYWxnb3JpdGhtDQo+ID4g
PiB0aGF0IG1ha2VzIGVucXVldWUgc2FmZSBhZ2FpbnN0IGRlcXVldWUgcmFjZXMgKG9yIHZpY2Ug
dmVyc2EpLA0KPiA+ID4gYnV0IEkNCj4gPiA+IGNhbid0IGFsc28gZ2V0IHRoZSBsb2dpYyBvbiB0
aGUgb3Bwb3NpdGUgc2lkZSB0byBhbHNvIGJlIHNhZmUuDQo+ID4gPiANCj4gPiA+IEknbGwgbGV0
IGl0IGJvdW5jZSBhcm91bmQgbXkgaGVhZCBhIGJpdCBtb3JlLi4uDQo+ID4gDQo+ID4gSSBhZ3Jl
ZSB0aGF0IE8obikgZGVxdWV1aW5nIGlzIHBvdGVudGlhbGx5IGFsYXJtaW5nLg0KPiANCj4gT25s
eSBPKG4pIDEvbiBvZiB0aGUgdGltZS7CoCBPbiBhdmVyYWdlIGl0IGlzIHN0aWxsIGNvbnN0YW50
IHRpbWUuDQo+IA0KPiA+IA0KPiA+IEJlZm9yZSB3ZSBnbyB0b28gZmFyIGRvd24gdGhpcyBwYXRo
LCBJJ2QgbGlrZSB0byBzZWUNCj4gPiByZXByb2R1Y2libGUgbnVtYmVycyB0aGF0IHNob3cgdGhl
cmUgaXMgYSBwcm9ibGVtDQo+ID4gd2hlbiBhIHJlY2VudCB1cHN0cmVhbSBORlMgc2VydmVyIGlz
IHByb3Blcmx5IHNldCB1cA0KPiA+IHdpdGggYSBzZW5zaWJsZSBudW1iZXIgb2YgdGhyZWFkcyBh
bmQgcnVubmluZyBhIHJlYWwNCj4gPiB3b3JrbG9hZC4NCg0KVGhlIGZsYW1lIGdyYXBoIGlzIHNo
b3dpbmcgY29udGVudGlvbiBvbiBhIHNwaW4gbG9jaywgc28gaXQgaXMNCmFmZmVjdGluZyBydW5u
aW5nIHRocmVhZHMgb25seS4gSXQgd2lsbCBiZSAxMDAlIGluc2Vuc2l0aXZlIHRvIHNsZWVwaW5n
DQp0aHJlYWRzLg0KDQpZZXMsIHRoZXJlIGlzIHRoZSBpc3N1ZSBvZiBOVU1BIGFuZCB0aGUgcmVz
dWx0aW5nIHBvdGVudGlhbCBmb3IgY2FjaGUNCmJvdW5jaW5nIGJldHdlZW4gQ1BVcywgYW5kIEkg
ZG8gYWdyZWUgdGhhdCBwYXJ0aWN1bGFyIGRldGFpbCB3YXJyYW50cyBhDQpyZS10ZXN0LiBIb3dl
dmVyIEkgZG9uJ3Qgc2VlIGhvdyB0aGUgb3ZlcmFsbCBudW1iZXIgb2YgbmZzZCB0aHJlYWRzIGlz
DQpyZWxldmFudC4gTm9yIGRvIEkgc2VlIGhvdyB0aGUgdXNlIG9mIGEgcmFuZG9tIHJlYWQgd29y
a2xvYWQgaW4gYW55IHdheQ0KaW52YWxpZGF0ZXMgdGhlIHRlc3QuDQoNCj4gUXVlc3Rpb24gZm9y
IFRyb25kOiB3YXMgbmNvbm5lY3QgY29uZmlndXJlZCwgb3Igd2FzIHRoZXJlIG9ubHkgYQ0KPiBz
aW5nbGUNCj4gY29ubmVjdGlvbj8NCj4gDQo+IFdpdGggYSBzaW5nbGUgY29ubmVjdGlvbiB0aGVy
ZSBpcyBvbmx5IGV2ZXIgemVybyBvciBvbmUgeHBydCBpbiB0aGUNCj4gcXVldWUgdG8gYmUgZGVx
dWV1ZWQsIGFuZCBpZiB0aGVyZSBhcmUgemVybyB3ZSBkb24ndCB0YWtlIHRoZSBsb2NrLg0KPiAN
Cj4gV2l0aCAxNiBjb25uZWN0aW9ucyB0aGV5IG1pZ2h0IGFsd2F5cyBiZSBidXN5IHNvIGFzIHNv
b24gYXMgYSByZXF1ZXN0DQo+IGlzDQo+IHJlYWQgZnJvbSB0aGUgY29ubmVjdGlvbiBpdCBpcyBy
ZXF1ZXVlZC7CoCBUaGlzIG1lYW5zIDEvMTYgb2YgZGVxdWV1ZQ0KPiBvcGVyYXRpb25zIHdvdWxk
IGJlIHNsb3dpc2ggYW5kIHRoZSBvdGhlciAxNS8xNiB3b3VsZCBiZSBmYXN0Lg0KPiANCj4gTWF5
YmUgdGhlIDEvMTYgc2xvdyBjYXNlIGNvdWxkIHN3YW1wIHRoZSBvdGhlcnMgYnV0IEknZCBiZSBz
dXJwcmlzZWQuDQo+IA0KDQpXZSBkZWxpYmVyYXRlbHkgY29kZWQgdXAgY29tbWl0IGIzMjZkZjRh
OGVjNiAoIk5GUzogZW5hYmxlIG5jb25uZWN0IGZvcg0KUkRNQSIpIGJlY2F1c2Ugb2YgdGhlIHBv
b3IgcGVyZm9ybWFuY2Ugb2YgUkRNQSB3aGVuIGNvbXBhcmVkIHRvDQpuY29ubmVjdCBlbmFibGVk
IFRDUCBvbiB0aGVzZSB0ZXN0cy4gU28geWVzLCB0aGlzIHBhcnRpY3VsYXIgdGVzdCB3YXMNCnJ1
bm5pbmcgd2l0aCBib3RoIFJETUEgYW5kIG5jb25uZWN0IGVuYWJsZWQuDQoNCkhvd2V2ZXIgZ2l2
ZW4gdGhhdCB0aGUgY29udGVuZGVkIHNwaW5sb2NrIGlzIG5vdCBwZXIgY29ubmVjdGlvbiwgYnV0
DQpyYXRoZXIgcGVyIHBvb2wsIEkgZG9uJ3Qgc2VlIGhvdyBuY29ubmVjdCBtYXR0ZXJzIG11Y2gg
ZWl0aGVyIHNpbmNlIGFsbA0KdGhhdCBkb2VzIGlzIHRvIGluY3JlYXNlIHRoZSBudW1iZXIgb2Yg
Y29ubmVjdGlvbnMuIFRoZSBvdGhlciBvYnZpb3VzDQp3YXkgdG8gZG8gdGhhdCBpcyB0byBpbmNy
ZWFzZSB0aGUgbnVtYmVyIG9mIE5GUyBjbGllbnRzLg0KDQo+ID4gDQo+ID4gT3RoZXJ3aXNlIHRo
ZXJlIGlzIGEgcmlzayBvZiBpbnRyb2R1Y2luZyBjb2RlIGluIGENCj4gPiBmdW5kYW1lbnRhbCBw
YXJ0IG9mIFN1blJQQyB0aGF0IGlzIG9wdGltaXplZCB0byB0aGUNCj4gPiBwb2ludCBvZiBicml0
dGxlbmVzcywgYW5kIGZvciBubyBnb29kIHJlYXNvbi4NCj4gPiANCj4gPiBUaGlzIGlzIHdoYXQg
a2VlcHMgbWUgZnJvbSBzbGVlcGluZyBhdCBuaWdodDogWzFdDQo+ID4gU2VlLCBpdCBldmVuIGhh
cyBteSBuYW1lIG9uIGl0LiA6LSkNCj4gPiANCj4gPiANCj4gPiAtLQ0KPiA+IENodWNrIExldmVy
DQo+ID4gDQo+ID4gWzFdIC0NCj4gPiBodHRwczovL3d3dy5saW51c2FrZXNzb24ubmV0L3Byb2dy
YW1taW5nL2tlcm5pZ2hhbnMtbGV2ZXIvaW5kZXgucGhwDQo+IA0KPiBUaGUgY29uY2x1c2lvbiBv
ZiB0aGF0IGFydGljbGUgaXMgdGhhdCB3ZSBTSE9VTEQgdHJ5IHRvIHdyaXRlIGNsZXZlcg0KPiBj
b2RlIGJlY2F1c2UgdGhlIGVmZm9ydCBpbnZlc3RlZCBpbiB3cml0aW5nIGl0IGFuZCB0aGVuIGRl
YnVnZ2luZyBpdA0KPiBtYWtlcyB1cyBjbGV2ZXJlciBzbyB0aGF0IHRoZSBuZXh0IHRpbWUgd2Ug
Y2FuIGRvIGV2ZW4gYmV0dGVyLsKgIFRoYXQNCj4gdGhvdWdodCB3b3VsZCBoZWxwIG1lIHNsZWVw
IGF0IG5pZ2h0IQ0KPiANCg0KSSBtb3N0bHkgc2xlZXAgd2VsbC4NCg0KSG93ZXZlciB0aGF0IGRv
ZXNuJ3Qgc3RvcCBtZSBmcm9tIHRoaW5raW5nIHRoYXQgd2UgaGF2ZSBhIGdvb2QgcmVhc29uDQp0
byBhZGRyZXNzIGJvdHRsZW5lY2tzIHdoZW4gdGhleSBhcmUgYXMgb2J2aW91cyBhcyB0aGlzLg0K
DQpBZ2FpbiwgSSdtIGhhcHB5IHRvIHNlZSBpZiBJIGNhbiBnZXQgaG9sZCBvZiBzb21lIG1vcmUg
aGFyZHdhcmUgdG8gdGVzdA0KdGhlIE5VTUEgaHlwb3RoZXNpcy4gSG93ZXZlciwgaWYgdGhhdCBy
ZXRlc3Qgc2hvd3MgdGhlIGNvbnRlbnRpb24gaXMNCnN0aWxsIHByZXNlbnQsIHRoZW4gd2Ugc2hv
dWxkIGNvbnNpZGVyIHRoZSBwcm9wb3NhbHMgdGhhdCBoYXZlIGJlZW4NCm1hZGUgaW4gdGhpcyB0
aHJlYWQuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

