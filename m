Return-Path: <linux-nfs+bounces-5436-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B15956BE5
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2024 15:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563C81C23C95
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2024 13:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D0416C6B7;
	Mon, 19 Aug 2024 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SWBqIIgG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MSydX1+a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB14416B749;
	Mon, 19 Aug 2024 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073701; cv=fail; b=gwOBZYPzU3/jv6AMOqeoHIxE00p4/pqo8QDqHY7qFrBYxdxAMkIevIqf+YPuIih4wil5wHIEUdUyQ6xkdwLPv2WKK64BoJchUZ8nmjGpXQLm6ZPtAmCyRmQN6l+AjwmKeqhQPQg6lKHY+5usLR3U4ET9i43vAWrUw1DYVOVW8zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073701; c=relaxed/simple;
	bh=H8a1dGozl9C5+v2rGuXUE+HAJkPm25GoRmShYbl9Nyc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BuNF2JZbceiRyxSKYFn1FUCp93AhWCD3qszji3S2TzpQRfr0IlZ2T8h8VA4jl0pfjqnDjqlViTc7N7IRmnBmiR1guopFvXXkvZRS83cBwV8sNzLyQP/ZOyLwADFpS0wUQftm7gxZ8OUb2ppltT9aK00KfP9qO2robUgSJ/UNpbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SWBqIIgG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MSydX1+a; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JD6s2t018615;
	Mon, 19 Aug 2024 13:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=H8a1dGozl9C5+v2rGuXUE+HAJkPm25GoRmShYbl9N
	yc=; b=SWBqIIgG+GgriqaUejxihQOgrVXIIJDlMQa6o7uqe82ftbRILs2uYGYYZ
	BfVyfSTNKH5TwIgDrgOp9iIbpJ8dYvFAY5XnOybW4afdW2FytjnqIb1EyZ7YtSyd
	Y2Ge4i5c4xzusArjvEdR4G7ueSRRL6Ij8EutlLjy2LTxCg0PJnu5vnkA4S2FwNFv
	vkUb+5biYtf5pRFzfba5OhUrUivDljFNAJQREprwufxchSRl80kKjI/Pjhvm5hqH
	XlWQZdooaR1OFsoTT6DKOt6W4cZJJv+HUfMDBfA+v8kP8gwsxbfE8YgzUhga6Pnn
	JjuTztUqao5G68KlIbaOZk8oCHOFg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3hjj1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 13:21:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47JBbvsP030903;
	Mon, 19 Aug 2024 13:21:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 413h3p4t50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 13:21:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJErlm6i/FLL9yKyF7S/GFnZ/XqeTzJgXfhlbGfFofKGqFVPKV6GjeAvE446vBDlzF8vVecbu4Kr7CRZkHSe0X18OAol7B1IKA0pBuf0Aika1RprCE7XawOmwosprwArUN56EQLkR3oDTTVP0UII0rx+kU81kI/bSwiUAVdAf+eDF2A3/TMYNvy76QUFOe+V3kFIEyAP953B76SC4mHONl/cg7Nek8QOBAZXJYCCx45tzjrIKSM9HBSDDFbk2p39/2UGqOltD4BhZXg/eincSexzLpeCctBoytT2hCC2hrrDSvGlFwsNfAxgYcXLMk5WrbXJ6b4RbDvetKgF25DjIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8a1dGozl9C5+v2rGuXUE+HAJkPm25GoRmShYbl9Nyc=;
 b=VddG9PiXJkaYa4kKAl0tYTTCri3P1S/V0EAD0DFIaWM/2pFoRZNBvHKk3iJsBgRW5A/ZF3FGZeYGl9uyU29e47QWhLhGuUYDgudy6+8DchE/AtMB2B1QlM0OwEHospwZsFSkbXxyNCx3v5CtgYQgUfRzU6zjFZHq/zvkZMz7XDR0/gCpZ0e9UNlG0fCWbP4roTXjsOx0VJD9HbWVctF/EcqPHlLIfFVCBz3kkS+DS0FJ25j0qgoUFSrOdiT8E+oLoATzd1NaWmHhqY16DjPL9J2HqZm0Tp3AFohD/eLcl8UbTEazsWFZlSc80bBc8rRudpkiyzycWrHtB6WE31I7tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8a1dGozl9C5+v2rGuXUE+HAJkPm25GoRmShYbl9Nyc=;
 b=MSydX1+af2IrN6rnVonx3H2HqiZosal2RVDfLD8eD53KHYf5lL/UnxATohJHXkmEyd6kuMCQ8b0oV02sCngx44as6JoZOXOUhCnQqNWOpt7at/gjcIz24NGjCfXr3AtHcCKpdj49Hib2YCMysgn/zUXTY/CYKVTXdgjy2PU8oKU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4522.namprd10.prod.outlook.com (2603:10b6:806:11b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Mon, 19 Aug
 2024 13:21:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.010; Mon, 19 Aug 2024
 13:21:21 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>
CC: Dai Ngo <dai.ngo@oracle.com>, Olga Kornievskaia <okorniev@redhat.com>,
        Tom
 Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker
	<anna@kernel.org>, Tom Haynes <loghyr@gmail.com>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] nfsd: bring in support for delstid draft XDR encoding
Thread-Topic: [PATCH 1/3] nfsd: bring in support for delstid draft XDR
 encoding
Thread-Index: AQHa79nI8OZMU5h3VEKSAxjt3QjJK7IttuIAgADDuYCAABsBAA==
Date: Mon, 19 Aug 2024 13:21:21 +0000
Message-ID: <E7E5447E-AD50-437D-8069-C77FFF516DCE@oracle.com>
References: <20240816-delstid-v1-0-c221c3dc14cd@kernel.org>
 <20240816-delstid-v1-1-c221c3dc14cd@kernel.org>
 <172402584064.6062.2891331764461009092@noble.neil.brown.name>
 <6c5af6011ea9adfd45abe4b5252af7319a3dbc94.camel@kernel.org>
In-Reply-To: <6c5af6011ea9adfd45abe4b5252af7319a3dbc94.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4522:EE_
x-ms-office365-filtering-correlation-id: ad524eb7-df36-427b-41b5-08dcc051d148
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MHdYOHNBRUdVOVJ5WEtQOEZvY3E4Z3dCUWE2RGRzUmk0TG4zdTkyQlg0YVVR?=
 =?utf-8?B?ck8zZWRaaE9Wb2NIanc4NERWeVlBU3dlTWhIK1Z2VlJIWjFjTk81aVNHSjBN?=
 =?utf-8?B?bXUvOVczVWJwc3dqdHNwcEtuR01TWk1RNnZoalRoZTlOMGxrZ0ZlYis3dWIx?=
 =?utf-8?B?Y0dxZFJUUVJ2L05EeU9aMFdPZld6bUR4UUI2RGYrMTI5OUJCcmRWWk8yZVdI?=
 =?utf-8?B?c1FOMDdCaGRFRm5hZVF4dXA0T1h2V1VZM1dmRG5mQ2RTaGYxOGpQczdVcGVm?=
 =?utf-8?B?QWpSYnZYUzFkNzZubTJPTHdPa2o4S0NINXBoTzF3ODBDTGdGQnVvSXV4NlM5?=
 =?utf-8?B?T2VTYll4bzc5MHorTE80elJFNmV3QkF2WmFQZGpLbk1OWC9vK2dOdXFLNmc4?=
 =?utf-8?B?aGNrRGlTZzViWTJMcy9aS1Z2Z3ZjcktrZG9jSHViK0hGaTM1OWF2WE9nM21G?=
 =?utf-8?B?YVhvczdQT1RuQ1BXMnFsYTFDR29EWFg5cnoweHVXV3BIdmlYK0FUVXJDS3U1?=
 =?utf-8?B?L215SEUveENwQVJ0Q1Z0b0xWV1cvMDRLSVY0dXd5VENRM2ppbmF0dVNSdmJP?=
 =?utf-8?B?aW5UWVJSUE83cER0ZktGUUpNOWoyQ0dleGhhZU45K1I0azA3NHNpKzFITkhF?=
 =?utf-8?B?N2xDN2UvcEJPSWIvemYxK3NIYjQ3eXk1TnJRN1dlR0tMZzlIWVJPdGxsZ01R?=
 =?utf-8?B?bnlaUGNRVDFqYWRyaGJYYjNsb1V3L2JhcVZ0ODl2MWljUnM3eE8xQzZnRzRR?=
 =?utf-8?B?RTZYTFFlOEFBRjM5ZWVSYUltNHFucXM3a1h4dFJPcVlheUZUNDN4alBCMXRn?=
 =?utf-8?B?dURXckp3MTEwcUpjUmxTZ0ZqQlN0b1ZxWnp1cEl1dklNZWRUd2JobFRneHA3?=
 =?utf-8?B?MTFmdmFCU1B0TUJuRHp5M1VmR1Z1d3U4cEVuYmZzV1Jab3ZSV2xRNTUxQ1pq?=
 =?utf-8?B?UDdXUWdxMkZBZHlJcTZaWFo2NVY3dEpyTmp3ZWZ2MkxNSWhHenVMQUx4NGJs?=
 =?utf-8?B?TUtGNHJ5UkNWcFlVbGdaMmduTFZ0NVY2SzFKSGI4cGJjUElucTAwR0UyQi9L?=
 =?utf-8?B?SnI3N09MVlh0SXFpRXIzVUI2SUR3aFB0bXRQNUp4SlN3OTlhTTVPSlphZWQz?=
 =?utf-8?B?WCtSUys2eXl1ZjhCcTcyTUxyTUliQ1JuNXJ1OE0wMkd5clFqL1hWcm4yVzZi?=
 =?utf-8?B?NTdVanBwWTRlQWxXOU5wL2Uvb2dNaHZPZC9TUzdmWDBTcnFUMUM2a2tlOHF2?=
 =?utf-8?B?aXBmQjF3U0pHUjZ5NmQ3NzFnOUVPV014WTZ1QmFFM0hSY0RuL1YxazNGZXlZ?=
 =?utf-8?B?WlJwYVJTeEpPNVZ6VmtvZE9zNUtxVkxLNjJxNGJLTkI2dkxxbFVIK0NmVkZ5?=
 =?utf-8?B?bGtUTzFqd1BBU1ZBWEtScGJsYUNNdzZGSlgrL2t1eGdRUGpLYUIyemRzVWRm?=
 =?utf-8?B?UHlnK1dYZGdKenNvVWhSejRWQS9uOS9meGZkZ2ZSQTg0UGV3NkE4eHdPWTdm?=
 =?utf-8?B?QmlPc3UzdmtVSzdOc3pEdGNiSFdhckluSFI5bi9oNEwyREMwbXMxbTBaYUZI?=
 =?utf-8?B?N0ZUb0NLRHliWjllRlFhZHg3Q1lKTWtZMU9FOGNOQVpwR3lyV3lXZ0ZZWUZU?=
 =?utf-8?B?SXZieURTTHhHb0dBU01EOTFCTXVMMnVVcXJwTDYwV3VKYVYwMnFxajNINzhR?=
 =?utf-8?B?TlRtUytSeE05RkkxNCthQ3VUV3o4d3lOUEFBd2ZjN201RldKcEo5aEpkNTd4?=
 =?utf-8?B?aGlGNlBvRXlOM3NQUUZQeERlUnBQNm5sNUxpQWtkckdCZGI1amNYTkNPcmZj?=
 =?utf-8?B?clR1K2tLWjF5SHVUS3UyRjJCRDJoZllKK3FUVjhVZ2xzWG1uTmcrR1IrZTJV?=
 =?utf-8?B?L09mcFY4c3prZmlIZkpoejYrdEcvRkNaVU44NCtKTFZSaVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1VMbWdhZHFkMHRjVjdEdkNTK29PMHVrTUljZjZsa3B3aXJPYXRKdldMZzhD?=
 =?utf-8?B?SXpMNFp3Umh6cUEveUJieE1EbHVjMWJGQUliQ3Y5RVRqQ3V0ZHlOQ1FMSWcx?=
 =?utf-8?B?OVpFUlRZRmVTUW5zNkYyUDFXK1JsMk5Qb2htZUVkMEROQ0lmaU1HdmFwUEZl?=
 =?utf-8?B?RCt5eUpoaGNQcEpPUEV6S0dQbHNLUE5xR3ZOeVRORjF5cnVDazR1WFlYa0du?=
 =?utf-8?B?Q3Y0bEh2dGRrS3d1ZGE0MzIzcXVNa2RZL1ZlWmVBcEFLeVBBWi85aktFQ0NZ?=
 =?utf-8?B?TzJ1d0xNSTc5L1VxVGJGTWlzZjhUYVIyQ1VBVzBWZkpKeXYxaDNVMHpmOGNt?=
 =?utf-8?B?ZHNyanJMblRiK2dBRm1IRTFWd01BK1N3UmRNVEt5NFpLVXRGSmQ5elI1VGly?=
 =?utf-8?B?YjROM25hdjQvN2RuTUhlek9pYnR3N1A3R3Z1RnZhbmRzODVkNHhCaHJqZ28v?=
 =?utf-8?B?bVNHeEZ6bHVBeDRuNlpsVjRFS2tldUd0Z0JZVEVRdXR3Mk4vd2hCMk9Rd29x?=
 =?utf-8?B?M3B1Zk42QmtzMVBmcTc1SFZjT1ZQczhJMFA1TUQxdm12S05KNkg1cGwyK2RL?=
 =?utf-8?B?bmRJSk5PcEhZaGdSWDdHbEk2aDRoZ2NJbkxWRjloRXVaUm5qNDZkK0JlQmsx?=
 =?utf-8?B?b2p4NmlpQ1IwNVhsYVFDU2tKcVJxVVlsNmZRVkVwc2xpcjVUanFmQ2xaOVZx?=
 =?utf-8?B?bHJSNlZwQ20yU3pyQ3U3cTVrYTRUb0J0K0pPRWdySHdOaGprdWpGaTRNa2No?=
 =?utf-8?B?NFRSa3prbVR1dm5GenRjdFBVeXQ5SnZLYjkyc2Z1R0Yxd0VXWkI1SEpxcisz?=
 =?utf-8?B?clhRbXVuSDVyNzh6VzYrd25UdG5kaTYyVnZKMXBLMXZjNDNlTWREb0dpSkdH?=
 =?utf-8?B?c3NJRGpDM1k3Q3dsWjdKMi9ocFZ2M0tGRXlBNmtiNUxlUlovYnM2MiswTld4?=
 =?utf-8?B?UTEwUzlxMExxZVJGTEpEbG5SekxMa3dZSlFGc1pobzBRWFlZam9pYWF6eUlo?=
 =?utf-8?B?ZnFXTExUaWhzV1hxcHBLcG1LbTJEN3dFSEJhVlFoL1N4cTR6d0EyVUtWdXYv?=
 =?utf-8?B?ZGZwQkNlQXFESlVNY3FVNG9zY3VtcUFmaEV3QVZVc1Z1L3hzVFpPV010emhD?=
 =?utf-8?B?czd6U1piZjJnOHE3N2Rna21xaEJIVDZ6M055TjJWSHl4WDg1VC9rc1ExTUU2?=
 =?utf-8?B?VVdKMW00b0haN0JnTWFsUkFFNTgvczBhc0ljazVKbGorbFdUWFZwL1U5azRo?=
 =?utf-8?B?cklHTEhtdWUvN1c1QTdkZW0yRVQ3d1J3WnZJMHBDK1VvTGNiQzljeUw0TDAw?=
 =?utf-8?B?MVBkMXVBVEl0cTIwSlM1Tlh0emUzVkEwNlJ2WE4zMllrcjlHZ2c2ODFOanRL?=
 =?utf-8?B?ZWdwUWVnTytMVmpDa29YYjduS2YrZVdNZHNrSnlFNWx1NWphYWxHdDhDaTNF?=
 =?utf-8?B?K3hBb2RMMUlyem1FZkJtU05GYjh3WWtGRE92dm00bE1BNUpNblorTjlXR3pP?=
 =?utf-8?B?VUtlSU12ODg3eEhiZDZVZGh6UGxvT1RUci9Dd2M3SzVQSnQ5b3p2WGlOY3Ru?=
 =?utf-8?B?NW1rY3oyaTJOUzNCb0hxTE5XMGRkRnhQK2pSWUl4MWFjTzcyZHh2UkRlMnhQ?=
 =?utf-8?B?UEVCM3NEalp4VGF2a2Nzc0FyRWJ2d1ZCS0tic0s0c0VDUEx5dWtpQi9iQUQy?=
 =?utf-8?B?cmsveFdwYnNuSFdvY3ZLamJXVXdnOUtXMlNGWkxKcWUxZXpPcEFwSzJrV2x5?=
 =?utf-8?B?ZzkrUFRqSXUvSnNDYVZncFlobzFPM0toVWRaeW95OC9tSEhoSDV4Y2pKNmJz?=
 =?utf-8?B?Vi9SWDBvSEVRcE0yYVBVS09RSDkwL3BUUENGYXprZThMSDFmK2VjN2VhZ0t4?=
 =?utf-8?B?ci9KS0VmUFZKNFdkTllQNm4yNi9IajJybmlORm5PMjJVaENPNVQreGhoYURK?=
 =?utf-8?B?QjdFOU9ucSs5V0dYZzdTQThpZURUVmZUem13YzNyWXh3MlcxZW9INDJGczBt?=
 =?utf-8?B?eHYvbG91OUhKcjA4TEowSTBHeXcvNGt5SGNaTG5obUtHRkpYL09kUG0vRnBq?=
 =?utf-8?B?eXRRdzZSdXc2RnVhUENlekNHM2hCYkJXR3pnOGRiMmxiWW1BUjZNdHBMc3N3?=
 =?utf-8?B?VVJwbnpQb3U0dHl1bFpXTXlIMnFxSVRodnErUTV4d3VLZGw2eHFYZVdaNC8v?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C749AF02436B96418A7F76465B289334@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PyIWDPpZ4eUHHwZIdtk0DriyVUbxz+eYGFgQUZRQs5o1/4h3fDi2b+UIktsSlC/ZivFIirldbLnmQ12XTx6Tb8Au4VMY7+0q/NM5cV/eZgXJiEGqpJKpNKy5BcbRtr2btqWX3U9/E8BINrOEfpsKNk48UaGGGrmVNZeZCs+6aFA9fSPmN4QxUL8Ndno2uFnMHVP8SUj+1XGRbgCuUsyGhb7k2IMwuTwbtwCVvZFr7JGXEquczTwvbsjQ5w5I1HT8ZPBU0C+xlBF2mxm9XahaetSxVHClS+Q7CX+hBhgT7uz3Dm+9KkwWXmIcBsLe6bthyoFwo1YBFH/iA/htACSXJ7/iyhLuhjiyOUsL6R0XR9nqwKCVHfPU+iGMg+ZxeC3HbO0lXKTJu0zw3+MlLXKpZWll17vExpTEyPRM7t/MekIf3PInBKDhksJGybPu6qiANQFVj40W+VuVIkR72PN5rYLX6nXy462vO1gQ0zWnIhl95is19/82exe2jiDn1LAipd5eieMI9uUA5hoTtMHhpRfyrzPKGOGhiSAxgSTZTux2GOxqa3/2XcE7T2l+kNBowp0Go044lmNXZyttEAp7Kpmyw+DCR2KmrBrn2ALJ7v4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad524eb7-df36-427b-41b5-08dcc051d148
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 13:21:21.5501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4wNh0us5usxhCBEl4wjgE9C2KK+ZHK1yr2cUN07uxGr4nm579Ey+wXkAEGeC5wSr6seV78iphoTg/8v+W14mVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4522
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_11,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408190088
X-Proofpoint-ORIG-GUID: jVpCBncYTMO66YVQ7EcjtFyKTktULAWR
X-Proofpoint-GUID: jVpCBncYTMO66YVQ7EcjtFyKTktULAWR

DQoNCj4gT24gQXVnIDE5LCAyMDI0LCBhdCA3OjQ04oCvQU0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uLCAyMDI0LTA4LTE5IGF0IDEwOjA0ICsx
MDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+PiBPbiBGcmksIDE2IEF1ZyAyMDI0LCBKZWZmIExheXRv
biB3cm90ZToNCj4+IA0KPj4+ICsvLyBHZW5lcmF0ZWQgYnkgbGt4ZHJnZW4sIHdpdGggaGFuZC1l
ZGl0cy4NCj4+IA0KPj4gSSAqcmVhbGx5KiBkb24ndCBsaWtlIGhhdmluZyBjb2RlIGluIHRoZSBr
ZXJuZWwgdGhhdCBpcyBwYXJ0bHkNCj4+IHRvb2wtZ2VuZXJhdGVkIGFuZCBwYXJ0bHkgaHVtYW4t
Z2VuZXJhdGVkLCBhbmQgd2hlcmUgdGhlIGJvdW5kYXJ5IGlzbid0DQo+PiBvYnZpb3VzIChsaWtl
IHNlcGFyYXRlIGZpbGVzKS4NCj4+IA0KPj4gSWYgd2UgY2Fubm90IHVzZSB0b29sLWdlbmVyYXRl
ZCBjb2RlIGFzLWlzLCB0aGVuIGxldCdzIGZpeCB0aGUgdG9vbC4NCj4+IElmIHdlIGNhbm5vdCBm
aXggdGhlIHRvb2wsIHRoZW4gaW5jbHVkZSB0aGUgcmF3IG91dHB1dCBhbmQgYQ0KPj4gaHVtYW4t
Z2VuZXJhdGVkIHBhdGNoIHdoaWNoIHRoZSBtYWtlZmlsZSBjb21iaW5lcy4NCj4+IA0KPj4gSWRl
YWxseSB0aGUgdG9vbCBzaG91bGQgYmUgaW4gdG9vbHMvLCB0aGUgLnggZmlsZSBzaG91bGQgYmUg
aW4gZnMvbmZzZC8NCj4+IGFuZCB0aGUgbWFrZWZpbGUgc2hvdWxkIGFwcGx5IHRoZSBvbmUgdG8g
dGhlIG90aGVyLiAgV2UgYXJlIGdvaW5nIHRvDQo+PiB3YW50IHRvIGRvIHRoYXQgZXZlbnR1YWxs
eSBhbmQgSSB0aGluayBpdCBzaG91bGQgYmUgcHJpb3JpdHkuICBUaGUgdG9vbA0KPj4gZG9lc24n
dCBoYXZlIHRvIGJlIGJ1Zy1mcmVlIGJlZm9yZSBpdCBsYW5kcyAobm90aGluZyBpcykuDQo+PiAN
Cj4+IEEgcGFydGljdWxhciByZWFzb24gZm9yIHRoaXMgaXMgdGhhdCBJIGNhbm5vdCByZXZpZXcg
dG9vbC1nZW5lcmF0ZWQNCj4+IGhhbmQtZWRpdHRlZCBjb2RlLiAgSXQgaXMgdG9vIG5vaXN5IGFu
ZCBJIGRvbid0IGtub3cgd2hpY2ggcGFydHMgYXJlDQo+PiB3b3J0aCBjbG9zZXIgaW5zcGVjdGlv
biBldGMuDQo+IA0KPiBGYWlyIHBvaW50LiBDaHVjayBtYWRlIHNvbWUgc2ltaWxhciBjb21tZW50
cyB0byBtZSBwcml2YXRlbHksIGFuZCBpdA0KPiBsb29rcyBsaWtlIGhlIGhhcyB1cGRhdGVkIGhp
cyB4ZHJnZW4gdG9vbCBhcyB3ZWxsLg0KPiANCj4gSSdsbCBwbGFuIHRvIGp1c3QgcmVzcGluIHRo
YXQgcGFydCBmcm9tIHNjcmF0Y2ggYW5kIHJlZ2VuZXJhdGUgZnJvbSB0aGUNCj4gLnggZmlsZXMu
IEknbGwgYWxzbyBrZWVwIG15IGhhbmQtZWRpdHMgaW4gYSBzZXBhcmF0ZSBjb21taXQgZm9yIHRo
ZQ0KPiBuZXh0IHZlcnNpb24uDQo+IA0KPiBJdCdsbCBwcm9iYWJseSB0YWtlIG1lIGEgZmV3IGRh
eXMsIGJ1dCBJJ2xsIHRyeSB0byBoYXZlIHNvbWV0aGluZyB0bw0KPiByZXNlbmQgd2l0aGluIHRo
ZSBuZXh0IHdlZWsgb3Igc28uDQoNCk1lYW53aGlsZSwgSSdsbCBwb3N0IHRoZSBjdXJyZW50IHhk
cmdlbiB0b29sIGZvciByZXZpZXcuIEl0DQphbHJlYWR5IGxpdmVzIHVuZGVyIHRvb2xzLyBhcyBO
ZWlsIHN1Z2dlc3RlZCBhYm92ZS4NCg0KSSdtIGhvcGluZyB0aGF0IGJ5IHByb3ZpZGluZyB0aGUg
Lnggc25pcHBldCB1c2VkIHRvIGdlbmVyYXRlIHRoZQ0Kc291cmNlLCBhbmQgYnkgYWRkaW5nIG9u
ZSBvciB0d28gInByYWdtYSIgYW5ub3RhdGlvbnMgdG8gdGhlIHRvb2wNCnRvIGhhbmRsZSBjZXJ0
YWluIGV4Y2VwdGlvbnMsIG5vIGhhbmQtZWRpdHMgb3IgZXh0cmEgcGF0Y2hpbmcNCndpbGwgYmUg
bmVlZGVkLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

