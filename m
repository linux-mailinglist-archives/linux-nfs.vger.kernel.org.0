Return-Path: <linux-nfs+bounces-8309-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EAA9E0CB6
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 21:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6834D16497E
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 20:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAFD1D63CA;
	Mon,  2 Dec 2024 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AFdiB9TJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I4XdjI0Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C661DB540
	for <linux-nfs@vger.kernel.org>; Mon,  2 Dec 2024 20:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733169711; cv=fail; b=BaJZi/U/IRRfZKrX+TaywA8p7XLDI53xXG0JbPSLA01QOknnW9F44J7cF9pEfJOLJHWoP4AiogZElInNNBZdosoOZLEz5B7a5uuGtHPcgMIPAFprt51xKmeKzn2yAUg2Jq7njw7W66m69mTj4gymEjrH9A8MLcxHkcye4HENhvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733169711; c=relaxed/simple;
	bh=POHoE3mtukHlbwgvbLl1NQw2rXLCh6ZVg8jgYbtNGsw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SHMV1A3dfoVusEj2MdPQsehuHiQjDg+8fylJ3gCv3bskX7I+lBnXupBPwDddGqVoZKfmz4J7Yd5q4fUv0mV8IPrtgfOm/yfJ2IOjC5roZePCqx69mxLOqsF/td3rNNgIXeq1kQJ+2E0EXAW+C4fBUvkXiKRxYwFWPmNbufuy/L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AFdiB9TJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I4XdjI0Q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2Hfi06028045;
	Mon, 2 Dec 2024 20:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=POHoE3mtukHlbwgvbLl1NQw2rXLCh6ZVg8jgYbtNGsw=; b=
	AFdiB9TJfKYeENd+OWwMwKBGCVMqUF66wCDtJbMzbDT47Jce+Hec5kd+zP11uHpe
	GeZ33iKwftZEht7v8cfY5eB/RYfyUk0otZbxCMRTgFzUKhWVw6u5JsKcVG/9+xlI
	ri4uMl2Dc1o0DUbwo4jhYCF2DKcHVaCIu422NOBG+00EHjjzkJql+TEyP12i7I0c
	Mv91OtLnhNW6YNqEzG97wVase+w4ELB5D1pzffVwC9OgUcZ+QZ6mHR/EEECkwHfH
	QpbRpgPJ7+3wwGUCtcIn8I5j+TpXvXdWqNnf/Yhdc9xfna9e81M2WSijqHnbZ8eh
	fT59mRC/Rv6E+DtUp66ybA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437u8t4fe2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 20:01:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2JHWgA000934;
	Mon, 2 Dec 2024 20:01:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s572ray-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 20:01:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Psrcnc1zDlBJZweJ6hTrx8VD2MSYppRgcwEfChwu2ocAKc/uEEI19K44ck4YQm0b1YfESFiD6WrOmpQiLQ67or/QlGLVEXcwkDNlILhbRkr60OgLkyYrUPjm+RyVmaCv7LR4+lnsQcOzr9+cp53mVHHhJlXhMAe6dZLB89AHieXj54FXzL4IUYLGxhEgpZMEewteG0gH0f9LhfDIc35Sx5t+lNWAPcMQ6n2fFVpX/nCD+qyKfTVTw0ugI56m79BwrnMWIN1lVYc/MeVYaLDXhyrMiH4k7wjk8RlnmH2Ae1hSHlDVXrDiF1LMWLV/401mpvKIvGCD+EDJeuxswUaflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POHoE3mtukHlbwgvbLl1NQw2rXLCh6ZVg8jgYbtNGsw=;
 b=L/2wDcMtYUHGuzpwrRNXRFng14fj7uoxqgcfGpv9FzyOXMFJKyk+Z3Okh26/Eu6c96M0uOko3mq+IzL8VAfouqSC+WSnDVOnNqlfjO+e2oJoZ+5GsRveY+r3AzKCtLa4tuoQ/pQ7QhwwYEKPo75MhWwaqMiGU4Dd7/mx8FyAt6dZ6wI+7x2rLJJ2SELngv3RcWsFWLQXOzWpXF/UKU6dhij5IiK1ehDnJOdr7P0Riaqh9aToTbUBEDCLUUeMaiXXsw2GGrVaMVyOKfT4aUHHaFids3oq025Zuhk4TEZDLAWk144biDEh8T6mwEMghavXkd1j7NQRvM+YJgWyBTxFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POHoE3mtukHlbwgvbLl1NQw2rXLCh6ZVg8jgYbtNGsw=;
 b=I4XdjI0QCXBDBe9Wspka7YxYsAxBcDqhE9sO94oltSJLWlMlRuXmM/Zr1f5lLQ+EA7HqUT4oRiV6gW1gh9DaJ5jHGnyGCjr6GKCxdfdRUnsZe6wftgC1Pg9/NOlYmPmzHEsJGVXztX9ybhW1fNN3Btmvaxvc3WLXevaDlF0XgMo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB7438.namprd10.prod.outlook.com (2603:10b6:610:18a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 20:00:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 20:00:57 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Salvatore Bonaccorso <carnil@debian.org>
CC: Steve Dickson <steved@redhat.com>, Sam Hartman <hartmans@debian.org>,
        Anton Lundin <glance@ac2.se>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: NFSv4 referrals broken when not enabling junction support
Thread-Topic: NFSv4 referrals broken when not enabling junction support
Thread-Index:
 AQHbFbWgp2fWmvplk0mUZs37kCic+rJ8qeAAgBMlywCACDnYAIABGh+AgDAwSoCAClAlAIAAFk4AgAAD9QA=
Date: Mon, 2 Dec 2024 20:00:57 +0000
Message-ID: <DCCD5A98-3754-4035-90D1-168A13656BCB@oracle.com>
References: <Zv7NRNXeUtzpfbJg@eldamar.lan>
 <e7341203-c53c-4005-9d70-239073352b2b@redhat.com>
 <ZxUVlpd0Ec5NaWF1@eldamar.lan> <Zxv8GLvNT2sjB2Pn@eldamar.lan>
 <1fc7de18-eaf0-4a1e-bd41-e6072b0f3d7f@redhat.com>
 <Z0VVLw9htR7_C5Bc@elende.valinor.li>
 <e86284ac-7a77-440b-bb5d-bdb1e6f23a40@redhat.com>
 <Z04OnJtb1oDl5sfd@eldamar.lan>
In-Reply-To: <Z04OnJtb1oDl5sfd@eldamar.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB7438:EE_
x-ms-office365-filtering-correlation-id: 20f2372b-5790-46c0-d131-08dd130c093f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ek5DOUtKWGxFUit3ZmpRVTFqUnM5UGdmckNLTWZySlhDVVY5NEhlT1o3S1lM?=
 =?utf-8?B?aWlWMXlBNWJYVXdFVXRnUlJwUXdxUXQ2Tmx5SVpHcWdud3ZlQUp4c3JYenFG?=
 =?utf-8?B?Umk0L3h4cmk0Y0VZUzZuYTcvSGVZNEtoaEtBdmtCQ3dkaXRaenl5dE1uOUxE?=
 =?utf-8?B?WEF6Nk5nd0hIcGRpSE9GV2M4ODZhWStpOE9Ib2NLYVJjY2pKVWFYSE1QcmFD?=
 =?utf-8?B?OGNwRjl1Y2ZaNDhTVHpxNjNicVVQM3VDcDhpakQ2djlkYnZkMDZkTFFBbUwv?=
 =?utf-8?B?VzdJVTBoc0FjcklqcTgyWC9KRUZGRnRCdVp5aTFhazFrRFJCazN5eVdwTEdD?=
 =?utf-8?B?NW9KdU00aWxXUjhtVi9UOXl4M2pRSzE0TG9ydG92cm8wY2Z4Y2JhN0h0eVN2?=
 =?utf-8?B?VFdZdFNCa205c05UbHcrRkRHREtTaTRKVGFCblFPaXNlS0N3TEtPb2VvMlhj?=
 =?utf-8?B?ZXBlTVZPY2RLUVN0SDBVb20wM2E2dnF2Ny8wSjhrQUFJYUFHaUJ5UktZOVJk?=
 =?utf-8?B?cVdBWm1CZFRFRW9rYU9WbEQ4NXQrZCthR0JHeXM5K0ZOUVdtK2xGaDB2bGdF?=
 =?utf-8?B?d3dPeGEzK0diK3RqQTY0NTFaWThXZEtRZ3pEU2cxSGE4NjAvNTJSakU0OUcw?=
 =?utf-8?B?emxwclppT3MyeGhvOVMyamYxZEJUYmlsc3FlSDF0OEJLYmUwT2E2c1dlOWRZ?=
 =?utf-8?B?VHNLWkJDMVdVMUo0ajZJRXJ5OXhUZUpNYVlsS3VyV3BNY09XVmVuaFhLcGxN?=
 =?utf-8?B?UFZ0UmovU2lvUXh0MFprT3JzU3Z2Z1FyZ2RkWTRyNDVFQWNoYzZuTUVFUmNO?=
 =?utf-8?B?SDRzQWFEUTlFN1RFZk80TCt3RVN4RGl0b1hwZWV0bTN1ZU50TEtGRGczd2xM?=
 =?utf-8?B?WW1nY0tHdkRISmVrdE5mL0syelhCa0FVbWdwaVhpUElwSGFlVEIvUDRFcVo3?=
 =?utf-8?B?VEhHeThuMHBqUnJkNGVxdmlkZlBJeExhUXltaEdmQ1JFVmQyaDZ2OGVTOGR6?=
 =?utf-8?B?TXVYNU1rQzJQSCt3VGE0NHlDbUZ6WkNwVEY4di9WMkcxZS9lRmZDcHBxSVZw?=
 =?utf-8?B?RjY2YVplSGhVTlRZMS9pSHdoaDJpQlhKM1F4MlpvR2VMVGt5MWlQWHlMcmlu?=
 =?utf-8?B?d1BFRHBxNUxYU0Vwemp1M2VqQnNRdVdFRllrWE9tTWc2VFZRR01NL3c3YTFn?=
 =?utf-8?B?K0lnNEdEN09GNTkzckRTT3ZQQWlJVFRhQnB5bTNHclB2Yk9DbEpKV3RCN3Yw?=
 =?utf-8?B?UGJJOVJqazdhMWdiYitxalNNSnk1b0tQbGYzN1BhVlExT2FjZnRXM1FSbWRK?=
 =?utf-8?B?b2F3dGpyR0VpQ1NHS1FpMGx0amZRWklOaStXNHp5QjBZeTJSNUZ5Ulc0TDli?=
 =?utf-8?B?aVhaSTIxZXRHVW5GdU41bXNkOU9Wd3lxZnlRL1NDc3M4SHlZdXl6bHp0Q1ZM?=
 =?utf-8?B?aE9nVGJINHFJaEFNTW9aZ2hyRWJDdEluSEpOTjR3R2R2YnJka255dHRHRDY3?=
 =?utf-8?B?MU8vbm90bFhNK2FlYmhDSlFUcXUzRGFCOUhhdjlTSlFacWlBTEgzMFczWUtD?=
 =?utf-8?B?L3NSRjcya1g3YytlZFc1VllRZzViQjhoaGQ2YUhJV2FCNUxabTlxVHp4UEhH?=
 =?utf-8?B?aEpaMVBQSVlkUWFLcU42SVZXZUc5ZXpzYmhmaitjSEU3U05odWc2NGJvbnR4?=
 =?utf-8?B?TkhQQ2MxMlJZTWpNbmFLZm9oVnYvaDlLVm9VbmszMXZpRVFid2syK1FQWjFq?=
 =?utf-8?B?UC9uaS9yWC9WWFZrN3BpbEwvYUlRc1FEcXJlL2JBQ2pBZCtWWmRKWTQ5Z1h2?=
 =?utf-8?B?VTFETVFZanBaNUF3RXF4MUNjOFNNVFBCK0VMbE9jcjZHQ0ljL3VMRW51WkVC?=
 =?utf-8?B?MFlCMlhya1FpVjk1VnpsQU5QZmF1T29OT0tsZENEdHVYbHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTFTQWl4WWVmbnFxK050Z3NSRkJKZzBVQkV5ZWJGSW9aZ0RRUWQzMW5rTDRx?=
 =?utf-8?B?bnZBZ1V3VkNaVDE3U01xdlM3TFhqTXlIUVI0eWI5Y3lJVmdiQXAwSXNzNmVY?=
 =?utf-8?B?bE01WWxXa21OckgySFN6OUxXbHp2cE1nY1VjVERZQnp4Z3R4bWZaK1BnY3Y0?=
 =?utf-8?B?UzlrMjRTdURoRmRZOHZmN0hFUlRJeUNWMENBSTYvMWllWE84aVM3c29KNjRQ?=
 =?utf-8?B?eDFaTGhJNk8vNlhHMktXemNqZGw1ZEhXZC9QeFRlcDUrT2NxRk9vd3ZBYXh5?=
 =?utf-8?B?b2ZoR0R1bXBzTm1oL2d0ZVVyRlZTZ3BuZ0NaWGsxRXErbEljdURnYWlYMVFI?=
 =?utf-8?B?ZExnQkx4R3o2ZG1QSWJldHk3TXQ5NHRrWnRQeVV0T0x6TS9lYkpQeGNHOGNI?=
 =?utf-8?B?REJOZEtBRWNvMjFXb3pzamE0NmErakxkWHRXMU5GOFV4UCtVQkxKMXlMZHRE?=
 =?utf-8?B?ZXFYa0t4OW12dWpRTEpDM1hPdHNKS1JpQW50cnVaNGE1VmtSdXdZK3dBS2Q4?=
 =?utf-8?B?RnVOOUhVc1lVc0o1OE1lZlZzdmhkU0c1OHJzWTNhUmhmblNXWjFXbmtraWVt?=
 =?utf-8?B?MHpla3I1WS9zSFVCbThVVlBzRlM1RDFTNWpJNXZTbTdKSzUreW9HVi90eU9a?=
 =?utf-8?B?OTRPMytVVGQxdk9BaU42VVJ0elNKMHVwckRaL1JkZG1JZXBWL2VqcVpTWkRh?=
 =?utf-8?B?Z1hHZ3FvL1BybmR2WGR1M3dxRGlrcEgydFhqOWExUVNlQ1dBeXNDZjR0TW1h?=
 =?utf-8?B?cTRDYTEvS1Y0TTlZYloyTkpWVGRyWTNqQmt5amU5anNtRWMrMklZNnhrb05x?=
 =?utf-8?B?NEc2bHVPbk9HNjBVNzdRMCtFQVRDbVlHNU1peE9oMzlaYjRxTmRKaVZBM0ty?=
 =?utf-8?B?SDZHL2Y5TlBTNVNTbkxjNWRBTldrc3BiNEQzWXVtOG1QT0RwR093ckQ5QnB0?=
 =?utf-8?B?a0FpTVh2OHZUaU1RWVBFZFZVaVYwSTJ5NHVYdndiN2hmM0k3V1EwT05PbzFU?=
 =?utf-8?B?NURGREU5enZBWndmOTc3eWpMZGNMTjdqWG54b2lrRlgyZ29LR21vWVhQaUhS?=
 =?utf-8?B?VlBpa2dqdjJQQVJBMG1SaVZrNEYzZlliOE5iSGZackxmcUVKNU9YU1o4WDJV?=
 =?utf-8?B?azZMVFhkTnlNeDNKeXpsTHNnQmlHVFpObW5CNzZ1SnVORlhwQ25vUCsyNFh3?=
 =?utf-8?B?SjNOamdSY2k0cldVbDM5bjlDVGpuZFVWQzdrWmovdjZsMDdyT0g3MzlBeTBS?=
 =?utf-8?B?Rnp1R3FRcGFjMm1LdkF1SGhHV045cllRK0l0ZUdhMkJabU9QT2paeUF0blVB?=
 =?utf-8?B?UitDVVBuRS9Jdm5qWGJKOFN0Y3RyNFppQmoxNDVOYVZXcGJSWkNQYlVTU25o?=
 =?utf-8?B?RS9PSXN4cHcvdDVxdzViYWxLU21KZDRkVXhuRUhmL3duQkFkSnc2MFdpTmNl?=
 =?utf-8?B?cXgxem5kaVNDaTZHNzJHbVR3a3Nrc0ZnNmY3V2QvM3h0bnhMVWcybnpvYTR0?=
 =?utf-8?B?RmEvVHhPQ1NxS2svZ1pVeFRJYkhsczhaMXRETUZGZkVwaVRQVmRzaGcrUG05?=
 =?utf-8?B?SFgzSEZkZFR5VXJUUE93d0NwQ3o4bFB1dGJKbGVLSVg0NUgzVlJmakFpMjVH?=
 =?utf-8?B?Y2NRemkwK3MrdTEvckxpT0FIMEJyeGJmd1Uyaldia1hWTVptaTZaYUVuUUE2?=
 =?utf-8?B?VUE4ZHBsVUE1VVlNSTdETGkwaGhLUDVWR0hVNktidGZIKzI4cUtVVUlBaTdJ?=
 =?utf-8?B?ZFZOSWpUMExVYkY4NVBWOS9pUXhzN0xaWWZtUHpaTUh5bTUyb0JJRzFnVWtK?=
 =?utf-8?B?VFptWWVCZE1xU09HSm05Q281NFpYOHZ1VXVscWxVZCtGSnVDc2d3L2s5K1lM?=
 =?utf-8?B?WGdpTCtXWFhTQ3p5SFRGanNaYi9ZMEordHpsdUJYdWRGMVl2b25OTWJJRDQ2?=
 =?utf-8?B?MVFVRGJGRkpzWjhBTitKTStJZHVQUi9FT1QrTzBwRTNXQmtOMnkyNHJETEJV?=
 =?utf-8?B?dmhXamZwdVdFa21DOUNGNW9uLzZwQlRySVYxZ3dlL2REdi94aDZDbGtCWCsv?=
 =?utf-8?B?VnpYeVVDK1B3MDZ1RWp6YzVUd0dxTENXWjZORGpvbHNXNzdEQmFpWDZtSkpp?=
 =?utf-8?B?NjYvUDR0SEFaRzAxZG40ZGJ2b08rYjBCK2x2VFdSK3lvTUZZZWpkYUJUUS93?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44988D7AD103E64CB48BD4371D083687@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qurErMZs6fNzmc/HU1AliC2ZigM35Nxoafql4MhAWE9eiJA+OYcWE5kWymIhMoPBZ0v6HRmRsbj0ZaX1aRb9bu7D/hHxDWcnJ0vuKwwzT1LREPqUZYSQi2VCYjY/d8EUNfZDImEH+W/RJUtpr4YhY2PLanUx0jYuZTwTmotxM18cPGyPTYuLOZVC7rSfBSx9Lmu/KX3in0lRmJVR4nmokJ635wTxVzxZ4mc8fJvmqPVDg4DF1ANsjWFJ4BmTsZfoonjFRMnXiP43C3+hZIkQGXXHQICKlcCEosmxPHVBfUk54Arv6fE2LkFIl5kskgDX9nbEkySOLibocBUivDGVoarDhASK6QPzMhTigSeZ1ZZBL3KJp3tOt6Z66qSgP0LZBtZc3PyxPGGnksXw1BickOBgmnXxwwJaVfHV/JsuoOX94H8TLPdYIF+ZyVPYoPGqJ/9vd0g8TedotCwIVmJcG7kH04tyh2mmQwWk3BL/HiPJy36fy/ol0WwpGew4Ods9eGsIijCzKiK8E3xO7aPEB04H6ydXrjrLGYhl/QOwNGnFFVi4mYmvWl1JpYUj0ijfRTjqL+43A0ZD1red5TVVf8Kx/wpQrv+KUKAja1ZD/AU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f2372b-5790-46c0-d131-08dd130c093f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 20:00:57.1805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QhgzdJIpaUvpLK4f09vV5yTwUEj5iswDjJvq154sOz4shUSOxOZo9Wvik9pnZhVjNJ/TP+1T95uwe4R9kJnO9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7438
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_14,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412020169
X-Proofpoint-ORIG-GUID: XHz4Gl8rNdeAHaA1o5xRz6G_ZpyKeqOS
X-Proofpoint-GUID: XHz4Gl8rNdeAHaA1o5xRz6G_ZpyKeqOS

DQoNCj4gT24gRGVjIDIsIDIwMjQsIGF0IDI6NDbigK9QTSwgU2FsdmF0b3JlIEJvbmFjY29yc28g
PGNhcm5pbEBkZWJpYW4ub3JnPiB3cm90ZToNCj4gDQo+IEhpIFN0ZXZlLA0KPiANCj4gT24gTW9u
LCBEZWMgMDIsIDIwMjQgYXQgMDE6MjY6NDZQTSAtMDUwMCwgU3RldmUgRGlja3NvbiB3cm90ZToN
Cj4+IA0KPj4gDQo+PiBPbiAxMS8yNS8yNCAxMTo1NyBQTSwgU2FsdmF0b3JlIEJvbmFjY29yc28g
d3JvdGU6DQo+Pj4gSGkgU3RldmUsDQo+Pj4gDQo+Pj4gT24gU2F0LCBPY3QgMjYsIDIwMjQgYXQg
MDk6MDQ6MDFBTSAtMDQwMCwgU3RldmUgRGlja3NvbiB3cm90ZToNCj4+Pj4gDQo+Pj4+IA0KPj4+
PiBPbiAxMC8yNS8yNCA0OjE0IFBNLCBTYWx2YXRvcmUgQm9uYWNjb3JzbyB3cm90ZToNCj4+Pj4+
IEhpIFN0ZXZlLA0KPj4+Pj4gDQo+Pj4+PiBPbiBTdW4sIE9jdCAyMCwgMjAyNCBhdCAwNDozNzox
MFBNICswMjAwLCBTYWx2YXRvcmUgQm9uYWNjb3JzbyB3cm90ZToNCj4+Pj4+PiBIaSBTdGV2ZSwN
Cj4+Pj4+PiANCj4+Pj4+PiBPbiBUdWUsIE9jdCAwOCwgMjAyNCBhdCAwNjoxMjo1OEFNIC0wNDAw
LCBTdGV2ZSBEaWNrc29uIHdyb3RlOg0KPj4+Pj4+PiANCj4+Pj4+Pj4gDQo+Pj4+Pj4+IE9uIDEw
LzMvMjQgMTI6NTggUE0sIFNhbHZhdG9yZSBCb25hY2NvcnNvIHdyb3RlOg0KPj4+Pj4+Pj4gSGkg
U3RldmUsIGhpIGxpbnV4LW5mcyBwZW9wbGUsDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IGl0IGdvdCBy
ZXBvcnRlZCB0d2ljZSBpbiBEZWJpYW4gdGhhdCAgTkZTdjQgcmVmZXJyYWxzIGFyZSBicm9rZW4g
d2hlbg0KPj4+Pj4+Pj4ganVuY3Rpb24gc3VwcG9ydCBpcyBkaXNhYmxlZC4gVGhlIHR3byByZXBv
cnRzIGFyZSBhdDoNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gaHR0cHM6Ly9idWdzLmRlYmlhbi5vcmcv
MTAzNTkwOA0KPj4+Pj4+Pj4gaHR0cHM6Ly9idWdzLmRlYmlhbi5vcmcvMTA4MzA5OA0KPj4+Pj4+
Pj4gDQo+Pj4+Pj4+PiBXaGlsZSBhcmd1YWJseSBoYXZpbmcganVuY3Rpb24gc3VwcG9ydCBzZWVt
cyB0byBiZSB0aGUgcHJlZmVycmVkDQo+Pj4+Pj4+PiBvcHRpb24sIHRoZSBidWcgKG9yIG1heWJl
IHVuaW50ZW5kZWQgYmVoYXZpb3VyKSBhcmlzZXMgd2hlbiBqdW5jdGlvbg0KPj4+Pj4+Pj4gc3Vw
cG9ydCBpcyBub3QgZW5hYmxlZCAodGhpcyBmb3IgaW5zdGFuY2UgaXMgdGhlIGNhc2UgaW4gdGhl
IERlYmlhbg0KPj4+Pj4+Pj4gc3RhYmxlL2Jvb2t3b3JtIHZlcnNpb24sIGFzIHdlIGNhbm5vdCBz
aW1wbHkgZG8gc3VjaCBjaGFuZ2VzIGluIGENCj4+Pj4+Pj4+IHN0YWJsZSByZWxlYXNlOyBub3Rl
IGxhdGVyIHJlbGFzZXMgd2lsbCBoYXZlIGl0IGVuYWJsZWQpLg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+
PiBUaGUgImJyZWFrYWdlIiBzZWVtcyB0byBiZSBpbnRyb2R1Y2VkIHdpdGggMTVkYzBiZWFkMTBk
ICgiZXhwb3J0ZDoNCj4+Pj4+Pj4+IE1vdmVkIGNhY2hlIHVwY2FsbHMgcm91dGluZXMgIGludG8g
bGliZXhwb3J0LmEiKSwgc28NCj4+Pj4+Pj4+IG5mcy11dGlscy0yLTUtMy1yYzYgYXMgdGhpcyB3
aWxsIG1hc2sgYmVoaW5kIHRoZSAjaWZkZWYNCj4+Pj4+Pj4+IEhBVkVfSlVOQ1RJT05fU1VQUE9S
VCdzIGNvZGUgd2hpY2ggc2VlbXMgbmVlZGVkIHRvIHN1cHBvcnQgdGhlIHJlZmVyPQ0KPj4+Pj4+
Pj4gaW4gL2V0Yy9leHBvcnRzLg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBJIGhhZCBhIHF1aWNrIGNv
bnZlcnNhdGlvbiB3aXRoIEN1Y2sgb2ZmbGlzdGUgYWJvdXQgdGhpcywgYW5kIEkgY2FuDQo+Pj4+
Pj4+PiBob3BlZnVsbHkgc3RhdGUgd2l0aCBoaXMgd29yZCwgdGhhdCB5ZXMsIHdoaWxlIG5mc3Jl
ZiBpcyB0aGUgZGlyZWN0aW9uDQo+Pj4+Pj4+PiB3ZSB3YW50IHRvIGdvLCB3ZSBkbyBub3Qgd2Fu
dCB0byBhY3R1YWxseSBkaXNhYmxlIHJlZmVyPSBpbg0KPj4+Pj4+Pj4gL2V0Yy9leHBvcnRzLg0K
Pj4+Pj4+PiArMQ0KPj4+Pj4+PiANCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gU3RldmUsIHdoYXQgZG8g
eW91IHRoaW5rPyBJJ20gbm90IHN1cmUgb24gdGhlIGJlc3QgcGF0Y2ggZm9yIHRoaXMsDQo+Pj4+
Pj4+PiBtYXliZSByZXZlcnRpbmcgdGhlIHBhcnRzIG1hc2tpbmcgYmVoaW5kICNpZmRlZiBIQVZF
X0pVTkNUSU9OX1NVUFBPUlQNCj4+Pj4+Pj4+IHdoaWNoIGFyZSB0b3VjaGVkIGluIDE1ZGMwYmVh
ZDEwZCB3b3VsZCBiZSBlbm91Z2g/DQo+Pj4+Pj4+IFllYWggdGhlcmUgaXMgYSBsb3Qgb2YgY2hh
bmdlIHdpdGggMTVkYzBiZWFkMTBkDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBMZXQgbWUgbG9vayBpbnRv
IHRoaXMuLi4gQXQgdGhlIHVwIGNvbWluZyBCYWtlLWEtdG9uIFsxXQ0KPj4+Pj4+IA0KPj4+Pj4+
IFRoYW5rcyBhIGxvdCBmb3IgdGhhdCwgbG9va2luZyBmb3J3YXJkIHRoZW4gdG8gYSBmaXggd2hp
Y2ggd2UgbWlnaHQNCj4+Pj4+PiBiYWNrcG9ydCBpbiBEZWJpYW4gdG8gdGhlIG9sZGVyIHZlcnNp
b24gYXMgd2VsbC4NCj4+Pj4+IA0KPj4+Pj4gSG9wZSB0aGUgQmFrZS1hLXRvbiB3YXMgcHJvZHVj
dGl2ZSA6KQ0KPj4+Pj4gDQo+Pj4+PiBEaWQgeW91IGhhZCBhIGNoYW5jZSB0byBsb29rIGF0IHRo
aXMgaXNzdWUgYmVlaW5nIHRoZXJlPw0KPj4+PiBZZXMgSSBkaWQuLi4gYW5kIHdlIGRpZCB0YWxr
IGFib3V0IHRoZSBwcm9ibGVtLi4uLiBzdGlsbCBsb29raW5nIGludG8gaXQuDQo+Pj4gDQo+Pj4g
UmV2aWV3aW5nIHRoZSBvcGVuIGJ1Z3MgaW4gRGViaWFuIEkgcmVtZW1iZXJlZCBvZiB0aGlzIG9u
ZS4gSWYgeW91DQo+Pj4gaGF2ZSBhbHJlYWR5IGEgUE9DIGltcGxlbWVudGF0aW9uL2J1Z2ZpeCBh
dmFpbGFibGUsIHdvdWxkIGl0IGhlbHAgaWYgSQ0KPj4+IHByb2QgYXQgbGVhc3QgdGhlIHR3byBy
ZXBvcnRlcnMgaW4gRGViaWFuIHRvIHRlc3QgdGhlIGNoYW5nZXM/DQo+Pj4gDQo+Pj4gVGhhbmtz
IGEgbG90IGZvciB5b3VyIHdvcmssIGl0IGlzIHJlYWxseSBhcHByZWNpYXRlZCENCj4+IEkgd2Fz
IG5vdCBhYmxlIHRvIHJlcHJvZHVjZSB0aGlzIGF0IHRoZSBCYWtlYXRob24NCj4+IHdpdGggdGhl
IGxhdGVzdCBuZnMtdXRpbHMuLi4gYW5kIHRvZGF5IEkgdG9vayBhbm90aGVyDQo+PiBsb29rIHRv
ZGF5Li4uDQo+PiANCj4+IFdvdWxkIG1pbmQgc2hvd2luZyBtZSB0aGUgc3RlcCB0aGF0IGNhdXNl
IHRoZSBlcnJvcg0KPj4gYW5kIHdoYXQgaXMgdGhlIGVycm9yPw0KPiANCj4gTGV0IG1lIGFzayB0
aGUgdHdvIHJlcG9ydGVycyBpbiBEZWJpYW4sIENjJ2VkLg0KPiANCj4gU2FtLCBBbnRvbiBjYW4g
eW91IHByb3ZpZGUgaGVyZSBob3cgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZSB3aXRoDQo+IG5mcy11
dGlscyB3aGljaCB5b3UgcmVwb3J0ZWQ/DQo+IA0KPiBDb250ZXh0Og0KPiAtIGh0dHBzOi8vYnVn
cy5kZWJpYW4ub3JnLzEwMzU5MDgNCj4gLSBodHRwczovL2J1Z3MuZGViaWFuLm9yZy8xMDgzMDk4
DQoNCkkgd2FzIGFibGUgdG8gcmVwcm9kdWNlIHRoaXMgYnkgYnVpbGRpbmcgbmZzLXV0aWxzDQpm
cm9tIHNjcmF0Y2ggd2l0aCB0aGUgIi0tZGlzYWJsZS1qdW5jdGlvbiIgY29uZmlndXJlDQpvcHRp
b24uIEluc3RhbGwgdGhlIHNlcnZlci1zaWRlIHVzZXIgc3BhY2UgY29tcG9uZW50cw0KZnJvbSB0
aGlzIGJ1aWxkLg0KDQpUaGVuIGFkZCBhICJyZWZlcj0iIGV4cG9ydCBvcHRpb24gYW5kIHRyeSB0
byB1c2UgdGhhdA0KZXhwb3J0IGZyb20gYSBjbGllbnQuDQoNCg0KLS0NCkNodWNrIExldmVyDQoN
Cg0K

