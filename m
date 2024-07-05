Return-Path: <linux-nfs+bounces-4645-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63994928B07
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 16:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24523B24C21
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 14:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F4E1BC43;
	Fri,  5 Jul 2024 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QAwJsT4z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yN2CFdDB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1EF146A7B
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jul 2024 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720191590; cv=fail; b=Ys+TJcUKrSC1jUbTUK8mDuADbaf2RPJ/tkYVGFdESB+RhM1uhU+B6gCiCD3xjKsja6r36f20C+tcbjMphzaqfJpsxLtDiXQt7O3CzSsAJxf3PRo69cVMfef7CCwvRR4MfYkmpzCtB4sQV76xK6pXjYCAZ1nxeEZkXN95xPfpgiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720191590; c=relaxed/simple;
	bh=xTq8nBcvBNjUiHk7qz9H5M1swdqWj5k+W5/BGUDsD+k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=doZDaOaIEWIwnldD+c+SwJripZJVYriEajAkuPngZAyBLViSXkpde6McXsANwHOsuGF/vLHPCSvibum8a0EIPAAR2lLuMnA5u8WkOqkULetfh86jDQoGTWgByf+HtsPXKOwPpXC9h4HHrQNlUYc1StJaoEtiz/zujzkFgtVon9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QAwJsT4z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yN2CFdDB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465EtU3o017092;
	Fri, 5 Jul 2024 14:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=xTq8nBcvBNjUiHk7qz9H5M1swdqWj5k+W5/BGUDsD
	+k=; b=QAwJsT4z+2+0M+DyYgiu0/S2QFz5TQQRpESFhJPWIC3O+KshHLlqxA/7Y
	/Vu2fdNHgjLcxayVU5eoG5KtpCAjL6NzBoupBsPIvQh7mN8WJJhrjIvfT8rc7JCM
	raabc1y/LjolXCT1pDpsa4hosEc8RFScWZD9LUBZ2MwoJ+tmHoRPUjYXFib/ubMx
	ZxNJjn1/OkXtpIdJMsIXLhWc/hjzlK4UlyEDMokEOAAhWH5RkPKcscXMvxzXBmTk
	kentIhsQu5xSa6eB0Gj3rJ6BUl7bO6qjkWCJL7hv2IV2qg5H+38u2Z3fkKNxyBqu
	ZVGgAbNREkZ/XZpQAjS7Pl9w6+Zzw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aacm72v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 14:59:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465DUxrI023593;
	Fri, 5 Jul 2024 14:59:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n12e448-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 14:59:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdqFLIY+iR0pIA0+qGZXzMiqIDfYV1UdwmjnB1Mg75ShyPCCxUF6amYKLkQfO8tySMZWw+Ugm+40X8k6YT4Bl52YHE3pmeiTaC7EMHqUvClMQKo0aljez5CPRB48qs1AaA7ysWP+71agI+VC9Q9b4H07NY7Fl41rV4B/oOTSkX7eEHBJLw26n/4YMgJOUKg49p7Hc0caF6eevqWr1D0sdqhgkgoWIqW7V5rdmodMHao4ov7SflhItyG8i1jsAIWYDOzAlTUTrWhNNpaKQZbwB7pLKOHNYCOxk1x53RwSCEPrICIkfKT9fdAHlQN8LNESQz9wh3cOBCgEuU6IC+BvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTq8nBcvBNjUiHk7qz9H5M1swdqWj5k+W5/BGUDsD+k=;
 b=kNPHj2UFug8M/p8BVnKiL9bFyUVlYIZvl72cEVC4nLTRSy+Ou7t/5R80RdJJoDaL6FGt7uwlHutncKiJ+mqw3As3Xi4U41aySiFVjRMV7o9XCqma9mBW6F7+ip5BvN81qnAKwLJkiflRht8nzGHoJABxir9r7t3dvjpKCyUXY2T2F3anrCElDrwH86fhqWGRFvjFWVSTgFye9DBpNvLzuy4ADhc7KZyBRx1mttvb3VExJpY9rsgU4QCeR0nc7kq2BuTxIHO3LrYUlcjLr5cUkZnSd7F18bQhDrUNCzB5z1Yg/o0klpkZPpztgSxspOi/8Rip4lqozkLmjil+sKW0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTq8nBcvBNjUiHk7qz9H5M1swdqWj5k+W5/BGUDsD+k=;
 b=yN2CFdDBdYczNJEgKQenkoXPqNcslUqyd0XLTlET6xZ2Wql4OOmu8D9VEW7upOkNHY08QbRRO2LiqkAP/YRP8pBkfiHNddP1iuWtceq3GjH8gqoIAptpMpsTdDkafq64qmX3tVVgaW6WJr9/zp00+zR1wz7SEUP+RH+ZZ6nSfi4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6063.namprd10.prod.outlook.com (2603:10b6:8:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Fri, 5 Jul
 2024 14:59:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 14:59:31 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
CC: Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker
	<anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, Neil Brown
	<neilb@suse.de>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Thread-Topic: [PATCH v11 00/20] nfs/nfsd: add support for localio
Thread-Index: 
 AQHazJzmgcDeJH7XRUCD8QiVhiofhbHju8AAgAC4HQCAAD+aAIAAWoOAgAAPdYCAAAG7AIAAAbOAgAADUgCAABligIAA2CSAgADR6gCAALSggIAAitOAgAALXACAAADCgIAABSUAgAAGRoA=
Date: Fri, 5 Jul 2024 14:59:31 +0000
Message-ID: <990C712E-99B0-4227-B67D-0DBAA2B2B72E@oracle.com>
References: <ZoVrqp-EpkPAhTGs@infradead.org>
 <F1585F6E-8C41-4361-B4FA-F9BD6E26F3A9@oracle.com>
 <ZoVv4IVNC2dP1EaM@kernel.org>
 <4486ee80a487c174ec88c7e12705d99e22ae812a.camel@kernel.org>
 <ZoY6e-BmRJFLkziG@infradead.org> <ZobqkgBeQaPwq7ly@kernel.org>
 <ZoeCFwzmGiQT4V0a@infradead.org>
 <57C1CB2B-3B46-48F3-A095-417845001C3E@oracle.com>
 <ZogAEqYvJaYLVyKj@kernel.org> <ZogAtVfeqXv3jgAv@infradead.org>
 <ZogFBqv0z7Rnh4_p@kernel.org>
In-Reply-To: <ZogFBqv0z7Rnh4_p@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6063:EE_
x-ms-office365-filtering-correlation-id: d2dd02e5-3b6f-4870-92ae-08dc9d031340
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?aEJabks0UjNhU1ZEZnl5dzBkcmMyRjBFcmxSdVRweFpBZ2l1VzdGVERJdGYw?=
 =?utf-8?B?eGpnMUpuUS9xaVRjR1lhOTk4Mk81N2F0OTlETU9OeExCZm00SjF5ME5SS0ta?=
 =?utf-8?B?aFVJcVNKWkxoeWxJTjdGakpoWktzWWxWZ2huSGtyZWExUThkQW5ScXltd1NM?=
 =?utf-8?B?aVdhM0RUSDZOOU5UcGZ0Z21yWW9wcW8yekVZMEZkT21Lb3RSdGFnUWR6MVow?=
 =?utf-8?B?Sjc4dGFLNU1Ec3BMYk9yNHRqck85VnAralhra1p2YklNTUthelBPbWdtUGxY?=
 =?utf-8?B?WjlQMFZmNCtYWk1NL0ZzOS9TRWpoR21CTTZYMmo3Y0tmQUZEd1lDRHZ1R2Jm?=
 =?utf-8?B?cEZ2QTVwRk5DOENOc1VWUXMwZnBLSFNSVmNrQ3NlTWdSV3RqMEpoMmh5M3pD?=
 =?utf-8?B?MmZUZW1JTnkzSmthWDZIWE9iWGZ4SmozOFh0RUx6ODN1d0w4MmMzT2pKMHly?=
 =?utf-8?B?WDZOVUVlR2M5V1lEbHBKYXB3dmtqbmZkY1VTMmIyaVNHb3UrZlQvTkJnRm5x?=
 =?utf-8?B?eENPN2tkV2l2Q1doNkNydjQxeFU0TUdzdWhITEVQRURWTUJoKzB0ZWFEWFQ5?=
 =?utf-8?B?SmR3VDVCMUZKdnhLeXJ6ejA2Z0FlMENCSEVTWmJXNTdVY1BmTE9jOTRZNElB?=
 =?utf-8?B?akZXL0tJZWlxRGN4NDQzZWFncWQrMnRBdzdBZXlZUk9UMjlhb3lHckhINGhj?=
 =?utf-8?B?Yjl5YWZ3bGZ3KytMRUp6WHFiVVM0WjVEa3VtQzduZURjaEs3cmRpN2lSVHFR?=
 =?utf-8?B?RE5NUlFYTXpCV3RXQU5HWURRS0ZjSk1KVWRsbTRKakU0TmludW1jdlRWMDBU?=
 =?utf-8?B?T1NpNjFhVjNyUlZxRCtMZFVFQ3NGQm5MMkZHY2VYQVhwZHMwN2RaN1BCQWwr?=
 =?utf-8?B?eFhUdmRXNy9oeCtybVVMYlIvaGpSdFRBT2NLRmxPTHA0M3QwK1BYb0RrYTVM?=
 =?utf-8?B?V3lDS3h1TTQzQ2ZwMm84M0xVZWpoYXZudzFqMnc4aEwzYWdlalM5cFlHVjFq?=
 =?utf-8?B?MXNXeEhBZ0JFb3JhMTdUellITnhxZDFJaDBXWWZYVU41c29EbkpvVm5CYjYz?=
 =?utf-8?B?eXBOdEhxbzlsUmpIdkh6RWVuODV0dHExMFRQSGM1N2hCN0pjYXh2bVFjUEdZ?=
 =?utf-8?B?YlpzUHBHL3BxcjU0dFplWmJGc2piRGJ0ZzZuMmdlbVVNMmNveTRnVFM2V1pP?=
 =?utf-8?B?U2lOWTMwNkp0NWFaa1BxNHhpUEpkQU5TMThCZFJXakUraGVra1VoenczVGJh?=
 =?utf-8?B?OTYrcmp2M0tlTWsrZlVTczkwVFVLampKVnRSQ0VwRzlOMGN3bm9FU2tCa3ZT?=
 =?utf-8?B?bmgyVU1BRnpiSzlXQlV4MEt2N3BIUEYwa3U4aFIzS3JKN3VIUE83Ym1WUFFr?=
 =?utf-8?B?UGl2VzRCdDZkOTRzbDJPNlcvbi92Zk1ueXRwbkc2R1VtQThXVnFaS0RFR2dP?=
 =?utf-8?B?OHp3b0VCM1JrS0IrSGNGRDgvRGhiNmVtcjNEWDlzZzIyRHl5NlZlcUZmVjBy?=
 =?utf-8?B?ZnlaSkI5U2dJTjNqek5jdWtWRy9mVU9WMnV4VHFNb0J5UU45bm10L0dTZ2Va?=
 =?utf-8?B?RE5qMjNWWk9iWDcxVEpkek0yVmJEVGNsSVJ0aXJCNllnek1uRGNkN2lFU0xl?=
 =?utf-8?B?azRFdjBlc2lpZlhFaVJ1cFlLVkJWampVMmhRdDJwVndXYUw4bkVMT2hnYzZZ?=
 =?utf-8?B?bGRXblU1NkpXbG90b1hKaDVpWUhrdTlFdDZLZWE0aldzdEljaVNXZS91TXJV?=
 =?utf-8?B?QlpHSTlpQlU2OGxwWnh0SkkrZTZXNFlQQi9ybmFEMXpqNlNnQkJRU3RXbE5M?=
 =?utf-8?B?ZlRDMURGbS8yZ2V2Rld1QVQzL2JDazVRbDRnR0hCQTFvdjByMlZXSFdlNkl3?=
 =?utf-8?B?OXY5UStsM2xtQVZ4aW1XMkM0L0tQbnhMVE1iNE5hTUdsSVE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dHg0TVpXUEJwU1c3RzZlQ3dMSU9xYVpzWDVSRUJKR0ZJR2pHRHJRRUE2eHBu?=
 =?utf-8?B?aSt2REhrRldLZi9YdmpiY0ZyUkdvUzZ3d3I5OUo5UVhRYkJHR3Q3YU13Q3lj?=
 =?utf-8?B?Y2RYQ2x4UFYrUmhBSktZTDQzSThZQm96V05pY3ZORUdydkxidksydkFmTXI1?=
 =?utf-8?B?NCtyUUpQMFdrd1k1bVFZQ2NVMUpnemtBNXlsZWVCZ1JNM3Z3dmhFd0ZjYk1K?=
 =?utf-8?B?cE1nakNuNmtiM2ZTR1RrdGk1eXcwSXBhUnhBVkMwT2hLcWJwSkdWRm94Y3JF?=
 =?utf-8?B?ZjgvbGxITE9WZndnMlY5SjcyR3k0MXg5NnNCeTNVOGNWZkNUODJVbnlpYUh0?=
 =?utf-8?B?ODRleWFBK29MUXJzdDFJSE9VRFMzbXlHSFFaTkx5bThJWFUrWjUraU8zdWFF?=
 =?utf-8?B?dVl0bHhJZXc2VTFSeVhGT2VRVm1jT1U1WVEzT1V5ait6U1NOV3hyYUxzWWo5?=
 =?utf-8?B?TEVRc3NQMzJPd1hFR2pldDllWHlUWnZ1Qm5sZ0Z2ZmFjMGRXbVhIb1dhbm5O?=
 =?utf-8?B?TDdONzdGYnBnemhtWDNGNjdCVWlkb0JCSHQvOTcxZVBKbk9uQjJNQkkxckVO?=
 =?utf-8?B?YUR3U1NRTk5kQzJqcVlyMjlYOE1hTVV3R0RQMitadjBVcnBSVW9uNGZkMVJK?=
 =?utf-8?B?ZjRmeFhiRUNxbmdOVm44WEM0em4zR3hQRFdCM3c4akg1R0NvRUlNSEp6WktQ?=
 =?utf-8?B?ZkhqdVJXZ2JOeTgzWjhhbHRFTFRRUjgyL3JuampKLzFKNkZobWg1U2M1MEhz?=
 =?utf-8?B?OXpxWXZxZUhQK3hyWCtkK2VmakFUZGlCYy9wQms1Q2VlR0xmODdhS0gxdUp6?=
 =?utf-8?B?VHU1cXBjdy9BTFY0ZDFiYTRGcVh2VFR0NkRJLzZqWlVIVWIzTTM1UXF1Smtq?=
 =?utf-8?B?Q3h3M3dSbkk5cXk1WnFPcTl0aUJrK2hnMnJhck1SVTdFYlBLOHloMWZ5SWVN?=
 =?utf-8?B?bTRkbklCc0lrMWRnUzVuUnVoeWp1S3FaakF1QldZZ0l0K0tBUnpWZzB6ZFRF?=
 =?utf-8?B?V1E2WEV5d2FFQS9raXN5dENYY0JyUG5IbWJ6ZnJlT2l4ZFZ1NkFHalFabmtk?=
 =?utf-8?B?Q2lCSkNQYWtxVnZ6VGlmQXhCSThabzVUcDcyMllSOVYrMG1YTHp5TlZ2YmhQ?=
 =?utf-8?B?b3FKZGM4amdrZ3F1Y2RPcld0Vml6SGh3VlFZMnhnS0VQbWt3S1FxenlYWXlk?=
 =?utf-8?B?dW15WVFrd3ZpR3p6Z3ZyOXI0M1RydnhyYm9wT1AyL1M4V21VN3FEK3NSenIy?=
 =?utf-8?B?dW5teVlLZlJVTFR2KzloT3duQ2trN3JXc2NCYUNCUDhvMW9Sb1g1MVVLMTRE?=
 =?utf-8?B?SVFUUGo2Y0dKSTl6QS9WQUF1SnZ2L05jQzlNV3owUGEvVUxFU0UzRStVZ0dn?=
 =?utf-8?B?NFVlSXNJSFUwekQvdXJUWnc5OFpRVllkQ04xOVZZT1ZtRmhjdjlhNFBTME93?=
 =?utf-8?B?SnhlbHVYL0NCdGl0M3J6ZytIa3BFZVlvVkZGcE1qbUl2anR2WHF5ZnV1bkpy?=
 =?utf-8?B?Z0dwTjdKRSt5SlBuRmJXYi9xQ3ppeit3NTh1dG12M3hCV0gxN291TWdaTzhx?=
 =?utf-8?B?aWY3RklEcVpvZm1JSFlCS0ExRGo4ZERHQVhWN1ZLZUZzVHFzMkNrSTNMWm9B?=
 =?utf-8?B?dURNU1hhU0V1U3RWVUpPODFpQnd2MVdaaVI0VjRoaTJGR0dCM2JPOVlvN3ZX?=
 =?utf-8?B?NFZxdDV3dlN0U01PMkd2V3lTay94WUV2M04rTjZlNVRpMXlpQ2xnalZFSzhs?=
 =?utf-8?B?emlSUFhwdTBEb3l6Yjd0dkVmbDZzSTdXZEYzNW8zcm9oeVFyMCtwdXNURGRs?=
 =?utf-8?B?WkNDa1hOYWN2T0QzN0tsSGNTbVNpTFFMa2htOUJ5QlVuUXU1a0ZzcWFuVi8y?=
 =?utf-8?B?MHJ0SXRIYXgrc1IxOUd0NmxpYzAySmt5UFExdVdqNlFCeGZIc1VIL1N5QUhi?=
 =?utf-8?B?RzY0TDZ0bzFRRjdNeGFVYmRScHZodnNxM1VjeXJVS1dyK3luWjUxQ1lXTUJk?=
 =?utf-8?B?eVRMK0l6Y1ppT1VSaVVTU3EvVC9OdFdLYVFrUG5ta0FwMU5GVjIzeXBUTFdD?=
 =?utf-8?B?VE83N2VobU90VFNzMmZTNjBHUTc4VWRyVXVXSS8xcnRLeklPU1gvWUgyeUV5?=
 =?utf-8?B?K0xySDNNMnRMMlJBMDlCWXU3YVBLR1ZGWUNCQ0pObGl4TGM5RWFNVzJCQjJv?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <345469569A0CF7438E8C709E99084836@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0ZJ5BSTvOf5D47KEkpRZHqHmINTQLzpFTw1cBBQ0g2fGgukHNa125LKlJmf3JkP3NDXzpPs03/k2/cPVp7vXRldAXgannVGZB5FINg7Ll+lciFn/Iu7TPbpxC+geJzvQG7EF0mWFQbHG4MTC2EJw9HRWUv1yEmh8ZC2XibbVFzbfMelpiVva6K4zq7I09VCM5TY4ALeLkEHZggOMM0E0OI7ebRBEJFRIgfwuZ1KQXwiopnR0IYoqqZPoXduNERcosDklEMKoiIZoLXAkbrAiWlTFw0cSSrhZ1eCBD7FKtfbRDYDaw+fDuLfggHlzt1ZKmJ68If9l8HJXo1adl7OcKPc86WOy2otBxZzmhAv+4FxbRTo0pr7Py/cfN+I8r+BtLd/vAqGbbFMR70p5maA+rMJyhV4O3BxTc6OiYHv6pE6ySAt+vnKoP0yzoDzY06HTw6bdFbWkLUwH4lDi74D4CkpD5M5XtMkhhhxpxDS8sIZq/pq+hjguuGmFm9TkB29Odb3JjxrTRO4NAX4AFrSa9T0P0epP2Zo1iMGhSjWS2c9UFb7KE1btb/RtSwpl1NQoSjtJ4klKWLo/OC4RJCVYKvejZmB/K/t2hhfYexrkBwk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2dd02e5-3b6f-4870-92ae-08dc9d031340
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 14:59:31.2737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: crG5a0lnvtsuj1vMC7YYTjChEr+j7anTKpmcES3mj5L33is1ZKgjW+d4RxrY6fFbngCOGEtIkwCVCjsJWNpxGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_10,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=590 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050107
X-Proofpoint-GUID: 6f-em7L_uPKPkWoDMkUokQmAD2c9fJIK
X-Proofpoint-ORIG-GUID: 6f-em7L_uPKPkWoDMkUokQmAD2c9fJIK

DQoNCj4gT24gSnVsIDUsIDIwMjQsIGF0IDEwOjM24oCvQU0sIE1pa2UgU25pdHplciA8c25pdHpl
ckBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgSnVsIDA1LCAyMDI0IGF0IDA3OjE4
OjI5QU0gLTA3MDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4gT24gRnJpLCBKdWwgMDUs
IDIwMjQgYXQgMTA6MTU6NDZBTSAtMDQwMCwgTWlrZSBTbml0emVyIHdyb3RlOg0KPj4+IE5GU3Yz
IGlzIG5lZWRlZCBiZWNhdXNlIE5GU3YzIGlzIHVzZWQgdG8gaW5pdGlhdGUgSU8gdG8gTkZTdjMg
a25mc2Qgb24NCj4+PiB0aGUgc2FtZSBob3N0Lg0KPj4gDQo+PiBUaGF0IGRvZXNuJ3QgcmVhbGx5
IGJyaW5nIGlzIGFueSBmdXJ0aGVyLiAgV2h5IGlzIGl0IHJlcXVpcmVkPw0KPj4gDQo+PiBJIHRo
aW5rIHdlJ2xsIGp1c3QgbmVlZCB0byBzdG9wIHRoaXMgZGlzY3Vzc2lvbiB1bnRpbCB3ZSBoYXZl
IHJlYXNvbmFibGUNCj4+IGRvY3VtZW50YXRpb24gb2YgdGhlIHVzZSBjYXNlcyBhbmQgYXNzdW1w
dGlvbnMsIGJlY2F1c2Ugd2l0aG91dCB0aGF0DQo+PiB3ZSdsbCBnZXQgaHVuZCB1cCBpbiBkZWFk
IGxvb3BzLg0KPiANCj4gSXQgX3JlYWxseV8gaXNuJ3QgbWF0ZXJpYWwgdG8gdGhlIGNvcmUgY2Fw
YWJpbGl0eSB0aGF0IGxvY2FsaW8gcHJvdmlkZXMuDQo+IGxvY2FsaW8gc3VwcG9ydGluZyBORlN2
MyBpcyBiZW5lZmljaWFsIGZvciBORlN2MyB1c2VycyAoTkZTdjMgaW4NCj4gY29udGFpbmVycyku
DQo+IA0KPiBIYW1tZXJzcGFjZSBuZWVkcyBsb2NhbGlvIHRvIHdvcmsgd2l0aCBORlN2MyB0byBh
c3Npc3Qgd2l0aCBpdHMgImRhdGENCj4gbW92ZXJzIiB0aGF0IHJ1biBvbiB0aGUgaG9zdCAodXNp
bmcgbmZzIGFuZCBuZnNkKS4NCj4gDQo+IFBsZWFzZSBqdXN0IHJlbW92ZSB5b3Vyc2VsZiBmcm9t
IHRoZSBjb252ZXJzYXRpb24gaWYgeW91IGNhbm5vdCBtYWtlDQo+IHNlbnNlIG9mIHRoaXMuICBJ
ZiB5b3UnZCBsaWtlIHRvIGJlIGludm9sdmVkLCBwdXQgdGhlIHdvcmsgaW4gdG8NCj4gdW5kZXJz
dGFuZCB0aGUgY29kZSBhbmQgYmUgcHJvZmVzc2lvbmFsLg0KDQpTb3JyeSwgSSBjYW4ndCBtYWtl
IHNlbnNlIG9mIHRoaXMgZWl0aGVyLCBhbmQgSSBmaW5kIHRoZQ0KcGVyc29uYWwgYXR0YWNrIGhl
cmUgY29tcGxldGVseSBpbmFwcHJvcHJpYXRlIChhbmQgYSBiaXQNCmh5cG9jcml0aWNhbCwgdG8g
YmUgaG9uZXN0KS4NCg0KSSBoYXZlIG5vdGhpbmcgZWxzZSB0byBjb250cmlidXRlIHRoYXQgeW91
IHdvbid0IGVpdGhlcg0KZGlzbWlzcyBvciB0cmVhdCBhcyBhIHBlcnNvbmFsIGF0dGFjaywgc28g
SSBjYW4ndCBjb250aW51ZQ0KdGhpcyBjb252ZXJzYXRpb24uDQoNCg0KLS0NCkNodWNrIExldmVy
DQoNCg0K

