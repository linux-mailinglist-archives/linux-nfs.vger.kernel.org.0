Return-Path: <linux-nfs+bounces-8327-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A64FD9E1FAA
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 15:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652152802A7
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 14:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593563BB24;
	Tue,  3 Dec 2024 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XvkFeJH2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Dt+pVmDw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A58E1EF0BA
	for <linux-nfs@vger.kernel.org>; Tue,  3 Dec 2024 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236838; cv=fail; b=SF5PopUUYkmhU81KOLB9UTNpWoHN0o1YHuGb6xmCZNriyMyFPJUeiGFqX4IgA+VQxnymE11BoNjOR0jrVGwcSSHK1hb89OLvYI+W9rFzB8QGWyChmyteEBE3K5TpLv3l0lRJ+W2/Ew47/0nMOR6H78b9Y2nSv6lH2WjIC+p8KQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236838; c=relaxed/simple;
	bh=mkhO+MsvYHWUivxqwQP2zzneGJZS+nxL4QHWzaNaUs4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=caMeMptBnL+Bs7W+/B3nj/pYqqKHhLTGi+YDA/qHgOhhgn9EcSWhuolbB7vrVvXJlVFvedz2ng9wWH4p3ObSlqTALRHxXTDu72fgeR7FAXNXuUkQ9PRTMXkYVm4BnFyvq3K1RnvEFGVBagvc5h52S2AAlHshO7jMIdpOsJ7XKJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XvkFeJH2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Dt+pVmDw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B37XjAx012977;
	Tue, 3 Dec 2024 14:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mkhO+MsvYHWUivxqwQP2zzneGJZS+nxL4QHWzaNaUs4=; b=
	XvkFeJH2fiR/50oCOwq9E9vzKF8bEDom23P7mruEbCtGOSmgqmVp/Y0pH+yNNudi
	gKV11rCII7PD0XAldEu+zxoUj6FjMQg9/JcWVRVIotuXQNU2rPv06/ZdDk4O98Dg
	lY+G3qAiMZ4M39aCzaMRuvvkBQsJpHmBeeriHLd1nYhrzHtbwDvcThZylXtCgLWM
	oyGliO08mYnRnsIpNYdJCCATeuQ2FPxQtnfTlNLpouW7TsTSvqw8Nj2ydILxmAwU
	mtMSPLRxsCkGB7zYK9VnPf7PUJLME96OsT66b7TCsuGuEZe/MMJvXz8xiQgKzJUs
	5t0OUmiVBPuArwvupbMR6g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437u8t643n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 14:40:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3Cg6Bm001103;
	Tue, 3 Dec 2024 14:40:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5800b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 14:40:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHX927zwGc7XvyOaNwAxQzqqaAyu5MQMAcaWXFd95pTcmDWjKixo2EykXQbg/NGPwPED7tE6VX6fpYSfF7awWO8hKvWgUHzMudVdEDkvUE9Xl4G8S0V+qmzL01JcW7GcFaCfiB8bHW8SqgxRF3Ge+fAjgqKaNkjcCyAj0dkqQBh9e9qkalPQFgD1gmoi97gXgPBhHEDol4lhPuNRq0DfIpa8ADD+YwSfhCiFftIIi/YY5Y4fst9MO/VOw0NToMgF8JUdOfHYZ3vnToolUmEAVdrzf4AVLucqUkm/Iw0OijYzexh2zTnhXQ+OX3kN/weSa3qeYrRLxNqH3+cZ2IHbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkhO+MsvYHWUivxqwQP2zzneGJZS+nxL4QHWzaNaUs4=;
 b=IK/lvmUPGK7NFbmlAgj0HNbynjhpLvKsG+fpumV67vMZCWmObJdVZRzWSWyr44wl2tyM9pPpPDiLpoSi0g/v0bSoSCuDtibu5pIccECwNrGmY+iCqhOGEJ5zIpLCiL0gXfbySSzgRgX3CjWhvbwWFhbLW78qCjfdwb1Rb6KuRlPS1zoR5XhkcSPqyAJ7hg00AkWYyFN00BveFpxu2q18RBJznAyAdMYZCE9bN2BaKfO1RhqnIKuWaDCY+KK5MtOVqL/FXjNfMtHX3iFSDdkFevMAQXWWWVbPmNLKA0bzMEeAB8QDx4Jyos/P+Y/TLokh08gg5EjoO4gXUxDuH7WCwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkhO+MsvYHWUivxqwQP2zzneGJZS+nxL4QHWzaNaUs4=;
 b=Dt+pVmDw/B9ZWbl8tOT2wxkybHprH6pBt89Q/bBfwstyKNFzojQNH4rP4n3329gsgpYtP8vdqLhjgORiDXbT4iu1L4ebf47IOZfx7geLM8oiNC7FBqWAWnxd6S8Cqy5wLKY8FMgloxUH2MksdgPxbV2uqFcVVVAnG44BlNO6L80=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7254.namprd10.prod.outlook.com (2603:10b6:208:3dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 14:40:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:40:16 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
	<dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 5/6] nfsd: add support for freeing unused session-DRC
 slots
Thread-Topic: [PATCH 5/6] nfsd: add support for freeing unused session-DRC
 slots
Thread-Index:
 AQHbOh0Frj5X9m/dQEyMrQOHJ7SFQrK+/WyAgAA04wCAADAjAIAC50SAgAALpYCAEOAEAIAAzgaAgACq3IA=
Date: Tue, 3 Dec 2024 14:40:16 +0000
Message-ID: <ECEE4B5D-EEAC-435E-875E-22653B2E5452@oracle.com>
References: <14EF5A9B-0511-42FE-8E3C-32CDC8133A99@oracle.com>
 <173320011366.1734440.11867983668802898163@noble.neil.brown.name>
In-Reply-To: <173320011366.1734440.11867983668802898163@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA0PR10MB7254:EE_
x-ms-office365-filtering-correlation-id: 92f6dba9-57fc-40db-8ae7-08dd13a8672a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RjNremFMcnpzbk15VW1kUHNkaG0wclo3T0U3YjJEbGZIMDl3N3lBQktwV0xj?=
 =?utf-8?B?M3lCTk9KL05CNk9ZdXBtZnpIbC92OTZzdkxnMC9YbUVTMWJnVUlpdGVFK2Rz?=
 =?utf-8?B?VlYrYUErUWttb0tPdUd1bS9SbFZLcG5tTE9UdXNQTy8yWVMrMldQdWVlZXRW?=
 =?utf-8?B?cEJqeVJpdWtDaGpkZlF4UzM3NDcxWUhXb05tWWp5VGs4aWVnUEJZcFV1SWpD?=
 =?utf-8?B?TGI5aENDQ0pvcXgzK2tTQ2hwY2lobDlVNHFRN2NpMmRlN0ErU0diWUtVelN4?=
 =?utf-8?B?N2YyWThtVzB0cnBxQ0c3NUZYSE16SjJzR3FlT1B1NXVKU1FsRXJxanFyVWNO?=
 =?utf-8?B?eEpQQjZTKzdiek1jRjlSa3VCREJjb1Nna0dZYWxCRGpFaW1aNGpPOWxwWXBi?=
 =?utf-8?B?SHNkZnRBaS81WDVJUTRNemZEcU1FcEt3UFRXNFVVQ0xPbFJPU0RFVmVLY256?=
 =?utf-8?B?T3d2bnB1WS9DMzVVc0lyYm02aDVxNVVycUw3ZTBjb3o0RWJRb2xZVlhML0pZ?=
 =?utf-8?B?dFJjVFhyNEVLeHNsalZvZysySFEwUU9sYlZJSmpTd1NDZFYzUDZVSk9OQ1Vk?=
 =?utf-8?B?QWVMOUFJQVo1WXF4MHVobjVqUlk4OHQwVkVITFRjMjBYd3NlQjNnbjZEM3g4?=
 =?utf-8?B?aC9mM1g1cjVxNEE0QlZLKzEvYUZhOU0xRjZaZit0cWJXSzhDMEhqVGlOTEF5?=
 =?utf-8?B?SjdHYWpEaDNOTjRZb3lHYTNCb2c3dXQ4czRiWHZFWlhMcDJ6REFzYWUvY0oz?=
 =?utf-8?B?NmkzNUJqMndiMm1NSDhnMjgyd3E4YlE2M2EwVyt2ejJaMUZ6WTA4ZXM2ZWd6?=
 =?utf-8?B?QUVjQ1hMWk1DR291TUVoellUTlh2Ujh3dSszODFSTlZDb2IwRDFXRER0WDNE?=
 =?utf-8?B?RVQ3NTgrQmppK2JESlczcytyd0d4N096SGp1M3hFRzA1RktGdXp3RjVFNmgz?=
 =?utf-8?B?ZjJvSEUzNkF2R0QveE5LM1EwZmhVVllIRlZPZnluOERQektLNk5POXNjRzVs?=
 =?utf-8?B?aGRoOGQ3RWNkMjAvb0VDSEZYbjlyY2N1NjBWUGxkVk1vb1Z3cEtXazh0UnBL?=
 =?utf-8?B?NmZlQkxCcXAyS05QM1JKeHdWZm91L3E0SmwyT2RCb1ZHNnRHQVhGY3NZcTRD?=
 =?utf-8?B?ZWpIWDh2elFHdUl4QnVsS1FOc2RnRmpZSzJsd0dqV1lLM3NyRWRPZThVUUFT?=
 =?utf-8?B?ZXAvS0VQMnhGQnNGRUpUTDJRMUlGa3JNU09ZaS9uWXNISWZ5eXFOZTBGQ1E4?=
 =?utf-8?B?NmZHNE05dUpSbDhJMjd2TnFBa0xZNkswOFM3N3hwbTJqZjdXRGRWZm9RcjhF?=
 =?utf-8?B?eE4wbmpMTXlhaG0wT1JQUWVHaWt6Y0g3aTB3VWtSSlUreC92aFJqOFJ2cEho?=
 =?utf-8?B?Q2Z5SjJpdWk2U0tNY3ZySU16ekkrT0FGNWsvRnIrMFczSjloZ214cm14b3or?=
 =?utf-8?B?ZWNJUk85R0kwaS9Cem5KTVN3RFFlUEZwaG11VjR2SFhKdmkwRWFuQVR1T0No?=
 =?utf-8?B?V0VvaTdJMW9sNDI0MDY2U2xBK2Y3dU51SXhmTWtJcGNwUytKK0Z2V1laSmx1?=
 =?utf-8?B?OWxqSDNiVkxZd2F6eHRhNEZSWUhnV1ZoeDFTYmFucWJLazBHaUhwSWlxcEdh?=
 =?utf-8?B?akZPWnRKdjJuNldpamZqakFidkxNb1RDMjAvV1JmdWRDSFdWY0t3QnFmbnlC?=
 =?utf-8?B?NzdOZ3B6aGhQWFV4N3lXdlpXTWNIT0NVSzdrcTRKc1RPNXd2NEtTek5PbWVz?=
 =?utf-8?B?RHpucTFzejZFWFBOeWt5Q0hNeXNnSjQwK1dFb3JXVEF4aXUxY05CUjY0Mkoz?=
 =?utf-8?B?L2VXODFUSWY3d1g0QldoZjVkcnVlWUYwditLM0JVcERVYXNoV05ENHljYjhl?=
 =?utf-8?B?dHJvQURObEZTVUlicFFwK2MwMHVzV1pkREo3WjVmcXc0SHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yk5RYVAzMTNkY0ZpK3Fldkc1Sndld0d3dGR5K2Zzdnd4UWxoaG5PKzlEdjNY?=
 =?utf-8?B?SHcvMmxuTjRhdC9jOWk4cGFQd0d6M1hJc3V5UVRyYXVFTklhdkFFRTZaTU9L?=
 =?utf-8?B?K0swazZac0xCQ3RFSkNHaDBlcDRMS1NMVGlsZXd4NWJLazZCZXgwRjJBd3Jm?=
 =?utf-8?B?bk5aNzNsRG9mWm0vOUYyQ0UxYlV5TlgxYUExVzJqNTFFWEpGU04wdGVGUjhF?=
 =?utf-8?B?OVl2MXFGbUFVQ0Z1VFFQTUhuVlZzd0R6ZGY2USt6OC8ybXpmQWdublQ4ZWw5?=
 =?utf-8?B?akVQOGFsbit6QTVZUTdxOGpYZ1FQaWYvc3VYampvRDRWRFhad1hNbW8zazVh?=
 =?utf-8?B?aGdCT25Yd0V6d3Z0N0xMY2hiUGtJd1dHcnpScHVITUVkVGtKY2kzUWd1QWQv?=
 =?utf-8?B?Q3BkTzJpWmVvbkplQVRUbUlseFBkdnduWEZ4WG5XUGRqblp2NFQrbEREYldI?=
 =?utf-8?B?N3hrMFlrQ2VubytHUnI2Z3hxK3ZWM0xiU2ljdEhKV2FwR0JHcnJqWFVYR1h6?=
 =?utf-8?B?TWcwS29mdXVxb0ptSmVGTS84VTRIaFlsSlFrWXJRcG9Xa0VoMmNZVHM1aVBM?=
 =?utf-8?B?cWc4cWNpNS9RenoxWE8wNTZJbmFSZ25TYmhwZ0M3V1hDQkYwY3c3TkJSNUxX?=
 =?utf-8?B?VU5UMzI5YlA3RTFOckh0d2FhKzR3WXFFMXRqTzZWcFV3RHo3encxMmxERlBR?=
 =?utf-8?B?a21VcjZicXBZdWtIMkJwWUpCWmdsQWtiajQ4NHYrQWdqTDQ0M3hxVHFpRmd1?=
 =?utf-8?B?WUVzU0kwandYZWtXUWtVc2JGVTR6eGR1enpSbXBXRG1IY3EyK0VudFY4b3A2?=
 =?utf-8?B?aEhkQTBwcjRucjZCMEtuNllZcnM3VDV0UDhtSmtHNmNsaUF4R1BpbEF4NmVM?=
 =?utf-8?B?UEpTVDg2eTZ1T2NUVHBtVlNQRnI0aXRzVXdUYVFqMkxjZXl5OWFVYmN4b2Ni?=
 =?utf-8?B?MW9DUjdzd2MwKzg2TmFRamxmVE5rdHZlZnlFTlczK2N0ZVI3bHE3VG8wNTc3?=
 =?utf-8?B?TDNrMzU5MXhibzZTWEpSemxkTjVhMU9LMHFqcm80TkdMVGFGRVBsQ01tZHg3?=
 =?utf-8?B?bjZRdWNmR2x4alI1dUM1Zlk0aWhGblFLdjR0cXAxOGhoSnV3anRJcGhRZTZY?=
 =?utf-8?B?azQzUTJ3Z2R3emdoKzkvNWRiTG9RRFBwM3JhTWpzbVF6eE9zYnJKNUlkTnBC?=
 =?utf-8?B?cnUzdjQ4QnFiZEFjT0Z3YUdGNTJaT3dndFJ5WmRramhTOS9JM1BWVEgrdzJT?=
 =?utf-8?B?djA2RzRCNnZMa3pSeFgzVmVoRllSS2JqQjlZcUtxbkdJTlZmcFhkZ0FLRUw0?=
 =?utf-8?B?TC84NFZZL0lESVEvL0REbm85dDB6ZDdGTHViMUkvdENLZ1ZYM2o1QUF1SSsz?=
 =?utf-8?B?VnQyanlqSTRqK1JqaUtnM2JOaHpTL1I0OGRDRVpTUmNWMFhtbGYxL1RQcFlP?=
 =?utf-8?B?Y0xwQVN6UUE5MWJVNXF3ampmOWZBYmltanNMdVdBdU9JRjB3RFFkalRuZVor?=
 =?utf-8?B?Ti94RWJqUUk1WFFRUSsrUE9zazEwdU9wV3V2WXFTcFFadFdwbG5tWTVlM2pa?=
 =?utf-8?B?UUFvU2x1b2docTA0SUdWMVI1UmxEOUxPMmtqcEFIQnVnTGVLVW9xdDFSZ1Ix?=
 =?utf-8?B?ZmdNZHFvc0hLSE5aeWxjdXNYTXR0UVJzenBjSGtJY1RJaUlWbmxMTlgzcGov?=
 =?utf-8?B?bGpLdmNEaCtGajNrVkd4ajJQb1ZiYVdsVS9EM1Q4UDZyTkVLR2kvd1cvNHdQ?=
 =?utf-8?B?RlZMc0pWOHpPSG1QMXZhSDM3WmU1OWFtNnlIeWdXQWRya2NtMUIyV2xVdUlQ?=
 =?utf-8?B?THloSnA0RG9xTWsxeXdYS1MwOGR4cXFzSUdRRzhhVUV2RHBNVlJLaDVOZzFH?=
 =?utf-8?B?emgyeXMxWStlTk9xeExCaFpXWnZBYmZjRFRXQWFEb3dXeHR0TGd5aWZxbmxi?=
 =?utf-8?B?Y3QyWkpWbUZYeUo1VFhwS2RBb2FvdE0vT01vdVF3MExKVmdXTHB2VzZTcHZF?=
 =?utf-8?B?NVd6VVVKODFnY3Zsb05zTkxoZi9wSWRrVXhTeld4TmxKcnJRTkZMY1dzR0dq?=
 =?utf-8?B?OTZmZUlXMnFqc21BOEJ1bjhJZGIrbFZxSEtUdXJuMzlVcVp6Vm02S0h4dTRB?=
 =?utf-8?B?K0I5V1A5TlRKVnJPK3F0enFvUXFtMi9JL2pXTDZUZUgxeGliR1ppdDB2M0R1?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <773E0029F8937D4BB0DE567CFB40F3CA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JHb0FzsuTgSsTn7zFWTofpccIfyk7F3iQ6M0VJBtCExqcrkhhJVNMjjScvkSXgllKMAJEMqdSo5Io1LZ4zlA9dCszNDK5IQiEO+jzb7YcsPq7sfjLVAicSNgxE8RbZeBOtCI5DryPf+e0AlRDsXwveKP5OIdg6zAmD637zWn379ygjDSKMUj0qQ3F4pwt3SNdtbMrCDXX1doW2v0w3to/uRneO/wb35BJU1ZwsXfWkEMVMvZJ5Ol54INni7DsJCSI8adqcZ3SYWjt9dEq4P/WFqQ2SBgZRH78Kr65Q2JygBNe4FIRgvBrIPi1vqV/nVXS7Nx3VRm8SRJgiZyE1FcbjVKOJJv6fT05haOQ7owiUbr+mFbj1eotHmTB/yAqcmvpTVNQyfvXbQOR6Y76TOAlNtxwZQAf8OyOoxH3kfFoNYrpKUs+voxSHucF54RV2VLmQxNoyprXb/0cWz/Rzk81GQi2Wuyn2SqrcBPp0PVmyqqYs8ieDpFDZT/Yc+ZuaGr4utvbqP2HXZucChsZMCouarD/fXwz+O5yCoRzAmDkLQX2ibDDZvINa37ekOgQcWhdMuXY39VJtzvaYfbrjcL/5aJbiIgxOdWQsx5L8u53VY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f6dba9-57fc-40db-8ae7-08dd13a8672a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 14:40:16.2303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: izo0qDtXDe9XAl8oc/Uh1Ec6lvFCxV7+ZvKIgRZ1zq4FyS4y9JvA3A4iUKHOOj6Yl30sZv/1Deg7w0/tUVbWZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7254
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_04,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412030125
X-Proofpoint-ORIG-GUID: J-dmnmfJw02rsrkO_4zGbrp5TgKKlhOk
X-Proofpoint-GUID: J-dmnmfJw02rsrkO_4zGbrp5TgKKlhOk

DQoNCj4gT24gRGVjIDIsIDIwMjQsIGF0IDExOjI44oCvUE0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIDAzIERlYyAyMDI0LCBDaHVjayBMZXZlciBJSUkg
d3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIE5vdiAyMSwgMjAyNCwgYXQgNToyOeKAr1BNLCBDaHVj
ayBMZXZlciBJSUkgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IA0K
Pj4+IA0KPj4+PiBPbiBOb3YgMjEsIDIwMjQsIGF0IDQ6NDfigK9QTSwgTmVpbEJyb3duIDxuZWls
YkBzdXNlLmRlPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IE9uIFdlZCwgMjAgTm92IDIwMjQsIENodWNr
IExldmVyIHdyb3RlOg0KPj4+Pj4gT24gV2VkLCBOb3YgMjAsIDIwMjQgYXQgMDk6MzU6MDBBTSAr
MTEwMCwgTmVpbEJyb3duIHdyb3RlOg0KPj4+Pj4+IE9uIFdlZCwgMjAgTm92IDIwMjQsIENodWNr
IExldmVyIHdyb3RlOg0KPj4+Pj4+PiBPbiBUdWUsIE5vdiAxOSwgMjAyNCBhdCAxMTo0MTozMkFN
ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+Pj4+Pj4+PiBSZWR1Y2luZyB0aGUgbnVtYmVyIG9m
IHNsb3RzIGluIHRoZSBzZXNzaW9uIHNsb3QgdGFibGUgcmVxdWlyZXMNCj4+Pj4+Pj4+IGNvbmZp
cm1hdGlvbiBmcm9tIHRoZSBjbGllbnQuICBUaGlzIHBhdGNoIGFkZHMgcmVkdWNlX3Nlc3Npb25f
c2xvdHMoKQ0KPj4+Pj4+Pj4gd2hpY2ggc3RhcnRzIHRoZSBwcm9jZXNzIG9mIGdldHRpbmcgY29u
ZmlybWF0aW9uLCBidXQgbmV2ZXIgY2FsbHMgaXQuDQo+Pj4+Pj4+PiBUaGF0IHdpbGwgY29tZSBp
biBhIGxhdGVyIHBhdGNoLg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBCZWZvcmUgd2UgY2FuIGZyZWUg
YSBzbG90IHdlIG5lZWQgdG8gY29uZmlybSB0aGF0IHRoZSBjbGllbnQgd29uJ3QgdHJ5DQo+Pj4+
Pj4+PiB0byB1c2UgaXQgYWdhaW4uICBUaGlzIGludm9sdmVzIHJldHVybmluZyBhIGxvd2VyIGNy
X21heHJlcXVlc3RzIGluIGENCj4+Pj4+Pj4+IFNFUVVFTkNFIHJlcGx5IGFuZCB0aGVuIHNlZWlu
ZyBhIGNhX21heHJlcXVlc3RzIG9uIHRoZSBzYW1lIHNsb3Qgd2hpY2gNCj4+Pj4+Pj4+IGlzIG5v
dCBsYXJnZXIgdGhhbiB3ZSBsaW1pdCB3ZSBhcmUgdHJ5aW5nIHRvIGltcG9zZS4gIFNvIGZvciBl
YWNoIHNsb3QNCj4+Pj4+Pj4+IHdlIG5lZWQgdG8gcmVtZW1iZXIgdGhhdCB3ZSBoYXZlIHNlbnQg
YSByZWR1Y2VkIGNyX21heHJlcXVlc3RzLg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBUbyBhY2hpZXZl
IHRoaXMgd2UgaW50cm9kdWNlIGEgY29uY2VwdCBvZiByZXF1ZXN0ICJnZW5lcmF0aW9ucyIuICBF
YWNoDQo+Pj4+Pj4+PiB0aW1lIHdlIGRlY2lkZSB0byByZWR1Y2UgY3JfbWF4cmVxdWVzdHMgd2Ug
aW5jcmVtZW50IHRoZSBnZW5lcmF0aW9uDQo+Pj4+Pj4+PiBudW1iZXIsIGFuZCByZWNvcmQgdGhp
cyB3aGVuIHdlIHJldHVybiB0aGUgbG93ZXIgY3JfbWF4cmVxdWVzdHMgdG8gdGhlDQo+Pj4+Pj4+
PiBjbGllbnQuICBXaGVuIGEgc2xvdCB3aXRoIHRoZSBjdXJyZW50IGdlbmVyYXRpb24gcmVwb3J0
cyBhIGxvdw0KPj4+Pj4+Pj4gY2FfbWF4cmVxdWVzdHMsIHdlIGNvbW1pdCB0byB0aGF0IGxldmVs
IGFuZCBmcmVlIGV4dHJhIHNsb3RzLg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBXZSB1c2UgYW4gOCBi
aXQgZ2VuZXJhdGlvbiBudW1iZXIgKDY0IHNlZW1zIHdhc3RlZnVsKSBhbmQgaWYgaXQgY3ljbGVz
DQo+Pj4+Pj4+PiB3ZSBpdGVyYXRlIGFsbCBzbG90cyBhbmQgcmVzZXQgdGhlIGdlbmVyYXRpb24g
bnVtYmVyIHRvIGF2b2lkIGZhbHNlIG1hdGNoZXMuDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IFdoZW4g
d2UgZnJlZSBhIHNsb3Qgd2Ugc3RvcmUgdGhlIHNlcWlkIGluIHRoZSBzbG90IHBvaW50ZXIgc28g
dGhhdCBpdCBjYW4NCj4+Pj4+Pj4+IGJlIHJlc3RvcmVkIHdoZW4gd2UgcmVhY3RpdmF0ZSB0aGUg
c2xvdC4gIFRoZSBSRkMgY2FuIGJlIHJlYWQgYXMNCj4+Pj4+Pj4+IHN1Z2dlc3RpbmcgdGhhdCB0
aGUgc2xvdCBudW1iZXIgY291bGQgcmVzdGFydCBmcm9tIG9uZSBhZnRlciBhIHNsb3QgaXMNCj4+
Pj4+Pj4+IHJldGlyZWQgYW5kIHJlYWN0aXZhdGVkLCBidXQgYWxzbyBzdWdnZXN0cyB0aGF0IHJl
dGlyaW5nIHNsb3RzIGlzIG5vdA0KPj4+Pj4+Pj4gcmVxdWlyZWQuICBTbyB3aGVuIHdlIHJlYWN0
aXZlIGEgc2xvdCB3ZSBhY2NlcHQgd2l0aCB0aGUgbmV4dCBzZXFpZCBpbg0KPj4+Pj4+Pj4gc2Vx
dWVuY2UsIG9yIDEuDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IFdoZW4gZGVjb2Rpbmcgc2FfaGlnaGVz
dF9zbG90aWQgaW50byBtYXhzbG90cyB3ZSBuZWVkIHRvIGFkZCAxIC0gdGhpcw0KPj4+Pj4+Pj4g
bWF0Y2hlcyBob3cgaXQgaXMgZW5jb2RlZCBmb3IgdGhlIHJlcGx5Lg0KPj4+Pj4+Pj4gDQo+Pj4+
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBOZWlsQnJvd24gPG5laWxiQHN1c2UuZGU+DQo+Pj4+Pj4+PiAt
LS0NCj4+Pj4+Pj4+IGZzL25mc2QvbmZzNHN0YXRlLmMgfCA4MSArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4+Pj4+Pj4+IGZzL25mc2QvbmZzNHhkci5jICAg
fCAgNSArLS0NCj4+Pj4+Pj4+IGZzL25mc2Qvc3RhdGUuaCAgICAgfCAgNCArKysNCj4+Pj4+Pj4+
IGZzL25mc2QveGRyNC5oICAgICAgfCAgMiAtLQ0KPj4+Pj4+Pj4gNCBmaWxlcyBjaGFuZ2VkLCA3
NiBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gZGlm
ZiAtLWdpdCBhL2ZzL25mc2QvbmZzNHN0YXRlLmMgYi9mcy9uZnNkL25mczRzdGF0ZS5jDQo+Pj4+
Pj4+PiBpbmRleCBmYjUyMjE2NWIzNzYuLjA2MjViMGFlYzZiOCAxMDA2NDQNCj4+Pj4+Pj4+IC0t
LSBhL2ZzL25mc2QvbmZzNHN0YXRlLmMNCj4+Pj4+Pj4+ICsrKyBiL2ZzL25mc2QvbmZzNHN0YXRl
LmMNCj4+Pj4+Pj4+IEBAIC0xOTEwLDE3ICsxOTEwLDU1IEBAIGdlbl9zZXNzaW9uaWQoc3RydWN0
IG5mc2Q0X3Nlc3Npb24gKnNlcykNCj4+Pj4+Pj4+ICNkZWZpbmUgTkZTRF9NSU5fSERSX1NFUV9T
WiAgKDI0ICsgMTIgKyA0NCkNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gc3RhdGljIHZvaWQNCj4+Pj4+
Pj4+IC1mcmVlX3Nlc3Npb25fc2xvdHMoc3RydWN0IG5mc2Q0X3Nlc3Npb24gKnNlcykNCj4+Pj4+
Pj4+ICtmcmVlX3Nlc3Npb25fc2xvdHMoc3RydWN0IG5mc2Q0X3Nlc3Npb24gKnNlcywgaW50IGZy
b20pDQo+Pj4+Pj4+PiB7DQo+Pj4+Pj4+PiBpbnQgaTsNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gLSBm
b3IgKGkgPSAwOyBpIDwgc2VzLT5zZV9mY2hhbm5lbC5tYXhyZXFzOyBpKyspIHsNCj4+Pj4+Pj4+
ICsgaWYgKGZyb20gPj0gc2VzLT5zZV9mY2hhbm5lbC5tYXhyZXFzKQ0KPj4+Pj4+Pj4gKyByZXR1
cm47DQo+Pj4+Pj4+PiArDQo+Pj4+Pj4+PiArIGZvciAoaSA9IGZyb207IGkgPCBzZXMtPnNlX2Zj
aGFubmVsLm1heHJlcXM7IGkrKykgew0KPj4+Pj4+Pj4gc3RydWN0IG5mc2Q0X3Nsb3QgKnNsb3Qg
PSB4YV9sb2FkKCZzZXMtPnNlX3Nsb3RzLCBpKTsNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gLSB4YV9l
cmFzZSgmc2VzLT5zZV9zbG90cywgaSk7DQo+Pj4+Pj4+PiArIC8qDQo+Pj4+Pj4+PiArICAqIFNh
dmUgdGhlIHNlcWlkIGluIGNhc2Ugd2UgcmVhY3RpdmF0ZSB0aGlzIHNsb3QuDQo+Pj4+Pj4+PiAr
ICAqIFRoaXMgd2lsbCBuZXZlciByZXF1aXJlIGEgbWVtb3J5IGFsbG9jYXRpb24gc28gR0ZQDQo+
Pj4+Pj4+PiArICAqIGZsYWcgaXMgaXJyZWxldmFudA0KPj4+Pj4+Pj4gKyAgKi8NCj4+Pj4+Pj4+
ICsgeGFfc3RvcmUoJnNlcy0+c2Vfc2xvdHMsIGksIHhhX21rX3ZhbHVlKHNsb3QtPnNsX3NlcWlk
KSwNCj4+Pj4+Pj4+ICsgIEdGUF9BVE9NSUMpOw0KPj4+Pj4+PiANCj4+Pj4+Pj4gQWdhaW4uLi4g
QVRPTUlDIGlzIHByb2JhYmx5IG5vdCB3aGF0IHdlIHdhbnQgaGVyZSwgZXZlbiBpZiBpdCBpcw0K
Pj4+Pj4+PiBvbmx5IGRvY3VtZW50YXJ5Lg0KPj4+Pj4+IA0KPj4+Pj4+IFdoeSBub3Q/ICBJdCBt
aWdodCBiZSBjYWxsZWQgdW5kZXIgYSBzcGlubG9jayBzbyBHRlBfS0VSTkVMIG1pZ2h0IHRyaWdn
ZXINCj4+Pj4+PiBhIHdhcm5pbmcuDQo+Pj4+PiANCj4+Pj4+IEkgZmluZCB1c2luZyBHRlBfQVRP
TUlDIGhlcmUgdG8gYmUgY29uZnVzaW5nIC0tIGl0IHJlcXVlc3RzDQo+Pj4+PiBhbGxvY2F0aW9u
IGZyb20gc3BlY2lhbCBtZW1vcnkgcmVzZXJ2ZXMgYW5kIGlzIHRvIGJlIHVzZWQgaW4NCj4+Pj4+
IHNpdHVhdGlvbnMgd2hlcmUgYWxsb2NhdGlvbiBtaWdodCByZXN1bHQgaW4gc3lzdGVtIGZhaWx1
cmUuIFRoYXQgaXMNCj4+Pj4+IGNsZWFybHkgbm90IHRoZSBjYXNlIGhlcmUsIGFuZCB0aGUgcmVz
dWx0aW5nIG1lbW9yeSBhbGxvY2F0aW9uIG1pZ2h0DQo+Pj4+PiBiZSBsb25nLWxpdmVkLg0KPj4+
PiANCj4+Pj4gV291bGQgeW91IGJlIGNvbWZvcnRhYmxlIHdpdGggR0ZQX05PV0FJVCB3aGljaCBs
ZWF2ZXMgb3V0IF9fR0ZQX0hJR0ggPz8NCj4+PiANCj4+PiBJIHdpbGwgYmUgY29tZm9ydGFibGUg
d2hlbiBJIGhlYXIgYmFjayBmcm9tIE1hdHRoZXcgYW5kIExpYW0uDQo+Pj4gDQo+Pj4gOi0pDQo+
Pj4gDQo+Pj4gDQo+Pj4+PiBJIHNlZSB0aGUgY29tbWVudCB0aGF0IHNheXMgbWVtb3J5IHdvbid0
IGFjdHVhbGx5IGJlIGFsbG9jYXRlZC4gSSdtDQo+Pj4+PiBub3Qgc3VyZSB0aGF0J3MgdGhlIHdh
eSB4YV9zdG9yZSgpIHdvcmtzLCBob3dldmVyLg0KPj4+PiANCj4+Pj4geGFycmF5LnJzdCBzYXlz
Og0KPj4+PiANCj4+Pj4gVGhlIHhhX3N0b3JlKCksIHhhX2NtcHhjaGcoKSwgeGFfYWxsb2MoKSwN
Cj4+Pj4geGFfcmVzZXJ2ZSgpIGFuZCB4YV9pbnNlcnQoKSBmdW5jdGlvbnMgdGFrZSBhIGdmcF90
DQo+Pj4+IHBhcmFtZXRlciBpbiBjYXNlIHRoZSBYQXJyYXkgbmVlZHMgdG8gYWxsb2NhdGUgbWVt
b3J5IHRvIHN0b3JlIHRoaXMgZW50cnkuDQo+Pj4+IElmIHRoZSBlbnRyeSBpcyBiZWluZyBkZWxl
dGVkLCBubyBtZW1vcnkgYWxsb2NhdGlvbiBuZWVkcyB0byBiZSBwZXJmb3JtZWQsDQo+Pj4+IGFu
ZCB0aGUgR0ZQIGZsYWdzIHNwZWNpZmllZCB3aWxsIGJlIGlnbm9yZWQuYA0KPj4+PiANCj4+Pj4g
VGhlIHBhcnRpY3VsYXIgY29udGV4dCBpcyB0aGF0IGEgbm9ybWFsIHBvaW50ZXIgaXMgY3VycmVu
dGx5IHN0b3JlZCBhDQo+Pj4+IHRoZSBnaXZlbiBpbmRleCwgYW5kIHdlIGFyZSByZXBsYWNpbmcg
dGhhdCB3aXRoIGEgbnVtYmVyLiAgVGhlIGFib3ZlDQo+Pj4+IGRvZXNuJ3QgZXhwbGljaXRseSBz
YXkgdGhhdCB3b24ndCByZXF1aXJlIGEgbWVtb3J5IGFsbG9jYXRpb24sIGJ1dCBJDQo+Pj4+IHRo
aW5rIGl0IGlzIHJlYXNvbmFibGUgdG8gc2F5IGl0IHdvbid0IG5lZWQgInRvIGFsbG9jYXRlIG1l
bW9yeSB0byBzdG9yZQ0KPj4+PiB0aGlzIGVudHJ5IiAtIGFzIGFuIGVudHJ5IGlzIGFscmVhZHkg
c3RvcmVkIC0gc28gYWxsb2NhdGlvbiBzaG91bGQgbm90DQo+Pj4+IGJlIG5lZWRlZC4NCj4+PiAN
Cj4+PiB4YV9ta192YWx1ZSgpIGNvbnZlcnRzIGEgbnVtYmVyIHRvIGEgcG9pbnRlciwgYW5kIHhh
X3N0b3JlDQo+Pj4gc3RvcmVzIHRoYXQgcG9pbnRlci4NCj4+PiANCj4+PiBJIHN1c3BlY3QgdGhh
dCB4YV9zdG9yZSgpIGlzIGFsbG93ZWQgdG8gcmViYWxhbmNlIHRoZQ0KPj4+IHhhcnJheSdzIGlu
dGVybmFsIGRhdGEgc3RydWN0dXJlcywgYW5kIHRoYXQgY291bGQgcmVzdWx0DQo+Pj4gaW4gbWVt
b3J5IHJlbGVhc2Ugb3IgYWxsb2NhdGlvbi4gVGhhdCdzIHdoeSBhIEdGUCBmbGFnIGlzDQo+Pj4g
b25lIG9mIHRoZSBhcmd1bWVudHMuDQo+PiANCj4+IE1hdHRoZXcgc2F5cyB0aGUgeGFfc3RvcmUo
KSBpcyBndWFyYW50ZWVkIG5vdCB0byBkbyBhIG1lbW9yeQ0KPj4gYWxsb2NhdGlvbiBpbiB0aGlz
IGNhc2UuIEhvd2V2ZXIsIHRoZXkgcHJlZmVyIGFuIGFubm90YXRpb24NCj4+IG9mIHRoZSBjYWxs
IHNpdGUgd2l0aCBhICIwIiBHRlAgYXJndW1lbnQgdG8gc2hvdyB0aGF0IHRoZQ0KPj4gYWxsb2Nh
dGlvbiBmbGFncyBhcmUgbm90IHJlbGV2YW50Lg0KPj4gDQo+PiBEb2VzIHRoaXM6DQo+PiANCj4+
IHhhX3N0b3JlKCZzZXMtPnNlX3Nsb3RzLCBpLCB4YV9ta192YWx1ZShzbG90LT5zbF9zZXFpZCks
IDApOw0KPj4gDQo+PiB3b3JrIGZvciB5b3U/DQo+IA0KPiBTdXJlLg0KPiBBbmQgaXQgbG9va3Mg
bGlrZSBzcGFyc2Ugd2lsbCBiZSBoYXBweSBldmVuIHRob3VnaCAiMCIgaXNuJ3QgZXhwbGljaXRs
eQ0KPiAiZ2ZwX3QiIGJlY2F1c2UgMCBpcyAic3BlY2lhbCIuDQo+IA0KPiBJIG1pZ2h0IHByZWZl
ciBHRlBfTlVMTCBvciBzaW1pbGFyLCBidXQgMCBjZXJ0YWlubHkgd29ya3MgZm9yIG1lLiAgSSds
bA0KPiBpbmNsdWRlIHRoYXQgd2hlbiBJIHJlc2VuZC4NCg0KTWF0dGhldyBzdWdnZXN0ZWQgR0ZQ
X05PQUxMT0MuIEJ1dCBuZWl0aGVyIG9mIHRoZXNlIHN5bWJvbGljDQpmbGFncyBleGlzdCB5ZXQu
IEknZCByYXRoZXIgbm90IGhvbGQgdXAgdGhpcyBzZXJpZXMgYmVoaW5kDQp0aGUgYmlrZXNoZWRk
aW5nIG9mIHRoZSBmbGFnIG5hbWUgOy0pDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

