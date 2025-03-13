Return-Path: <linux-nfs+bounces-10585-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A45A5F25B
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 12:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059BD3BE1C3
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 11:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D1F2641F4;
	Thu, 13 Mar 2025 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnal.gov header.i=@fnal.gov header.b="Cs/YDFA4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SA9PR09CU002.outbound.protection.outlook.com (mail-southcentralusazon11010052.outbound.protection.outlook.com [40.93.193.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB331F151E
	for <linux-nfs@vger.kernel.org>; Thu, 13 Mar 2025 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.193.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865416; cv=fail; b=HrPA+mfWD8sTn1sAeeu6Q9fiU+hP5bIsfjbYhmVqtaAYTdgW0VqXnx5y2zzuk790CeuF21ETJNFFDbZJw84/1KaYPjwsoJBSNrriW7q5pNxm0iomucrFzF6h54cP57iJIUNrIyWZmAhwp3doZExcGjx9ruFsPpIhUVrtXYa0/BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865416; c=relaxed/simple;
	bh=n/VGrftxekOZNi15rhe4CQ94w2dbyRGqQDEqOkOLoMM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D9K6jPrg6p+XFZalA8lv3C8HkJfqYgbuYNTqhwTSoCYoyvG2bbIWnHj8IEt570EMxiLZw0Do2hDBsWU80psi7viVgCx/BGpJLKQv9xlHyAWDoKkz06MG/pqWxAVjOXchuQ4cX2HG8yM3OCpZkMdXWMtdM9El/al9ob/JY4Jw1ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fnal.gov; spf=pass smtp.mailfrom=fnal.gov; dkim=pass (2048-bit key) header.d=fnal.gov header.i=@fnal.gov header.b=Cs/YDFA4; arc=fail smtp.client-ip=40.93.193.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fnal.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnal.gov
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdjb8Hf+cIJg59K+FtNp6JG2Wb6CQ8w/3c4kn8QpwgDR7AW9Y+vRRz9dCRfjofFVTeUoScOt2gvHvCLLuGY/rEm4ToRV1KJvnKfe4ACpsiKHyhPB5nE9JqiQS5GwzLxJFeX7pI1ecO9TfzJFEUGUT/DbrsMKGzVkOkX9Q+ujTqhxm2ucDiH4z97RvhnjUfw4P6Xd6qiNE9m+YDt1Epq6jku8dEPDik0FcENhjHgY2n71JgujqhJtSEM3V5lHa5a+ND5QRfZV1sxPtJQ+A2NXqQLV5CzNtV60HpjHyN/MLEDluSbq7cC7DKLqT1UlSlAR3+4TmTt50C8KBbOPwV6aWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/VGrftxekOZNi15rhe4CQ94w2dbyRGqQDEqOkOLoMM=;
 b=p3Pg+uGmwf7Krvw2YT/vZHnSOucFwe53wvD07AoMNbfQeveQITwcOuO3O226x3wk1PkHRUIRx0183X6a0oASnn26+hXkTSnEnPbZ7vdW0h2NkJrmHu9GURcTcp5t2qmWK0hPqVHmHlsFr3XcIAB99d6DQqGquPnWwOzson+Cr50gkfPyQuxI9loXDbQ1kr51hb7KaFl+gEaRBH1gg/TQSTCThwFRO89Pn+qiUscVINLuqvu6ku25VSZ7PB4e+BbzqUKbMp79+mDonH09tkVOge9StWtsc2e1rKcLXrxwXoxLwOWnlm1FRAtMkGgrLhm4TseipFA14tzviDTM+N6PZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fnal.gov; dmarc=pass action=none header.from=fnal.gov;
 dkim=pass header.d=fnal.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fnal.gov; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/VGrftxekOZNi15rhe4CQ94w2dbyRGqQDEqOkOLoMM=;
 b=Cs/YDFA4jOdg8XSGtJpnfsEqAJcEsSkCr9GUszvCNs7hdNsf1m6WP+BlZhpS7T51U8Pd7VjBBcGYNq7o97aiz0OZRFi+NSLfgiAC54haMqhKTutMP+uDPUewgAKwUuKbBk9gblp63Dmhe3pHI3VywT4nvP/zFAv8DAOmB1+z5MsKPJ9xK3I+tQfQz3Zo7hM5TXCub5H/f6U1Q5ULlRgs9UC4szY7zucAn82xWNv77pTsczBRuZ0zP3NLsReYXwV9KneB6dY91DpfGGCz3AgnKVL3FBzhIznkS2AB4tjmKvnUKJg1Lv8+EqgiC0AzZkzzEfmTPI6r8sTMf8eCBSwrrg==
Received: from PH0PR09MB11599.namprd09.prod.outlook.com (2603:10b6:510:2aa::9)
 by SA1PR09MB10636.namprd09.prod.outlook.com (2603:10b6:806:369::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 11:30:12 +0000
Received: from PH0PR09MB11599.namprd09.prod.outlook.com
 ([fe80::7c3d:ada9:5944:a121]) by PH0PR09MB11599.namprd09.prod.outlook.com
 ([fe80::7c3d:ada9:5944:a121%3]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 11:30:11 +0000
From: "Andrew J. Romero" <romero@fnal.gov>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: GSSPROXY ( for NFS with sec=krb5, krb5i  , krb5p ) is development
 still active or is it being depreciated
Thread-Topic: GSSPROXY ( for NFS with sec=krb5, krb5i  , krb5p ) is
 development still active or is it being depreciated
Thread-Index: AduTpkJL3Z+Uz30mSiOYGbEcxqj6hQAZCTBg
Date: Thu, 13 Mar 2025 11:30:11 +0000
Message-ID:
 <PH0PR09MB115990D120B04F28C93F4014CA7D32@PH0PR09MB11599.namprd09.prod.outlook.com>
References:
 <PH0PR09MB115997CF2D7A117949CDDB375A7D02@PH0PR09MB11599.namprd09.prod.outlook.com>
In-Reply-To:
 <PH0PR09MB115997CF2D7A117949CDDB375A7D02@PH0PR09MB11599.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fnal.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR09MB11599:EE_|SA1PR09MB10636:EE_
x-ms-office365-filtering-correlation-id: 1e4adf25-daef-407b-fc28-08dd62226acc
x-fermilab-ob: 1
x-fermilab-sender-location: inside
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V2laK3ljRW1rNE9RKzgyME1CV1pvRUtJUEEzVUUwbm5BdWo2R1JwZGJuaGJh?=
 =?utf-8?B?eE13KzNBMXkzUWVFN3Z4U2xUY3J1NnFUSmxYOEtzSXZTajNsR0ZEbGJMM25h?=
 =?utf-8?B?NURMY0E2L0dTVUVMZVoyVHU2YjlFWmZTUnhsYzNYVEVLSmxXNFV1cXBvNXpG?=
 =?utf-8?B?eExtTEticmxvRGVtdi9FVmMrSER5Z0EyS1duZjBSOE04eGxFTHFNOWRZa2tG?=
 =?utf-8?B?WTRHY3hKS00wMzA0aWZoUHp6YVNrTFZwZmZzMjhrQVF4eE5RRGFNMGhNbHh0?=
 =?utf-8?B?OXFDa0lCeUZkc0cvSHhoK21GMm4yMm9jZGN3SHRLMy92a0RmcGYrY29YNVdq?=
 =?utf-8?B?b0Nhb3g1VzR3SDJzNnhnVnFqMzhRcSsvQmlHb3JRQVFZV2x3TlBiNzhxcW1o?=
 =?utf-8?B?MkNnaE9aak5SczdMUWFkRG1RQVV6RExaVGNha0FJZy9BalhGZWJqMTkrN1dZ?=
 =?utf-8?B?MkwycE5DUmtnelg4T2lucE14aUJBaEowM2ZHYjMybTJtSHBIMGd1WDhkb0Nn?=
 =?utf-8?B?S1luWHl4UTZvbUo0aU96aUczWDQ2N09WODJ6QWIyMVJCOU1VODZsbTI0R01F?=
 =?utf-8?B?RTRWUWRCY1R3T2YrejY1T1lhS3ZtU1RpSnJUeHNyTjl3dVpqakZpVnlNWk9X?=
 =?utf-8?B?RWNLbGprUFNiazhMcnB6MWdUYkIySzhwc2lIdlhseXlobndaNHFEMTVGeGhq?=
 =?utf-8?B?b3FZbXczNUhaVE5wbzVTK09heUN5VnFCNWxIcWhSdWppOEtxYiswaG1LSS9m?=
 =?utf-8?B?dzNyWVJ0UG5kOExxTVhiTmwydzlxT3N5bnByQm9RNkVnWWM1OUtGQjltSUt1?=
 =?utf-8?B?Y2RScXM4dVc0aUZSb21CWlJYU3NkT2xlRHd5b3QrM21aK3d4MVVYajBXamhq?=
 =?utf-8?B?bldka0kwMjNhRUl2UzJTaEFjTFpGWTlKSnJyeFpJOHZKaEZKNC9mNjhVd295?=
 =?utf-8?B?Y29zeWhwMndEUi9zS05zSkd6TFc3bm9LU3pxdEprODA0ZnVZQy9mM2JaR0Fz?=
 =?utf-8?B?cG1rd2hOSmxKVi9abGFwV2h6czNvdmRLY2ZEVnpGb1pjeWFuZ25BaHZwWm91?=
 =?utf-8?B?TDQrSHpESUlQL2ltSDQ4ZnVkdGVNa011cGhRTGhaWE55WXFBM1NkQktFT1Z1?=
 =?utf-8?B?bnhjSlZ3SmdoK3BTZGN5dnlwWE8vcVRCc2RRbGdOUlEza2FYUzI0T3JNTkll?=
 =?utf-8?B?eGdrMGZEZm80eFpmcURkckMvZ0ZLRXEvYXF2bGFvbXhtVWtlbWROZ3FRaEQ4?=
 =?utf-8?B?eDdRM002eHlZS1RCVklxeFlOcE05OHBQV21YTDBFVElrank0ai8wUVFQRjBU?=
 =?utf-8?B?ZzV1SytWMWVLMGlQMzBmTGZvWkxoeUZZSEpFL3M1aTFOY3Zkd3R0QWtXN1ZU?=
 =?utf-8?B?N0kwZERiNk40aXkwYlZsQ1JVT05paUxXZ1kzb1huQ1JhcUs0N1YyakJtN3dN?=
 =?utf-8?B?MGU0UFJ6VFYxREt6UHgwVFNWYTA2NDIvcVZGMkdzS29vRTVnenBHMHdWazBm?=
 =?utf-8?B?WTNoVURmelNyWThDZ2hqVzRMVjlVbVcxVnRMUGFvQndXYTgyRG1OWXYzSTdV?=
 =?utf-8?B?UDRTYVd3YkhKeUJOT2JJMy84RmZvVHoxTFRKSEp6anlTOHpkNlFtV3I0cU50?=
 =?utf-8?B?THRVUEdGOWN3Q1lwT0F1WGZRMGJ5aU12TEJLeFlLaStqVzcvM2luNEZyL3ZO?=
 =?utf-8?B?UTFPZHJKTjMwMmYrQWtaeExUYUpyMmc4N2NWeTdRdUgzZmYwYVd3RDE0MTIv?=
 =?utf-8?B?UjFUWUZTMVoxS2FyYkVqVzliM1FZbjliMStqWnRZbDA5SmIxbm1Bc3ljanBs?=
 =?utf-8?B?REtLNHhoblRlTVlXelkraGEyaEtIOFJaemQ4b1dmYzZqWm9XM0c3NEVldHZx?=
 =?utf-8?B?QjZkcXpLakZHdDgzNlZFRVR1c1dTV3piRzhITGNUQ2g4MWRPUkdKQ2V0b3Y1?=
 =?utf-8?Q?0Ov6EyYNBMJys55Pr/TAQjsFZ2YS5QH7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR09MB11599.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VElyOERtOTc5MXpzdEZ1RnExS3J3T080WVAzNGM0RkxLbkw0M2svYUlGQ1hw?=
 =?utf-8?B?TEZOakxiUzdVTEx6em5PTGoySC9WQjJucmpsYTN5RllrZittWmlaYWFKajEw?=
 =?utf-8?B?NldsSFVpa2hQbmJrZHVFWnE4ay9qVzVaM3ZsMFFScHJvM2xzUkJJMHF0eXRa?=
 =?utf-8?B?aCtHSFdJV0lsMzVGcjZyZDhLVWs4dS9qOStKMjJINlhPNmFQN3Y5SDFneVlY?=
 =?utf-8?B?cS9FSVBnYVZ4d1ArTEh6YWZ2ZFdJc2x4cEM3Z3pvcHlCN0wvVVRyV3JRbjQr?=
 =?utf-8?B?U1pTdWg4aU5aVm9tR0R5WnM3K1VlTUo2dTg0dUZVUXhoUDI5c2NSK3NsM2Zl?=
 =?utf-8?B?NEpVWE1uR09Fa2gxWlNxZFNqZHh0QVN5YjhuejYvaW52R2h5RVR4ZzVtRmt3?=
 =?utf-8?B?NzYybnphSmFFQTYxSnEydzYxYmg3VDJubGxTaDh6bFdUWk9nVk5vK2JESGcx?=
 =?utf-8?B?b1dEbzEzVFdjZ2xwL2lYWWwwRWMrTmlhZ2dGYTRGZm1IWnhLL3lWWTQ5QmZo?=
 =?utf-8?B?emE3QmxtTVEvWjhqV2huaUthcGQ0UXFwN1JHQ1BjcG5CWkg1Z0RDd05POHYr?=
 =?utf-8?B?bWduaTdPcXRkdGxMQlF5dVlFWDk5dCtXcDJ4T1V1RXE0SjI1VE5hdDRZWVN3?=
 =?utf-8?B?MDdVSUZ4WVlXUk9rZTVuYlF2dmZVOWQ0eHBWd2ZHMHE1N2lXTHA1WElLYXl6?=
 =?utf-8?B?U1VxUnFOTWRaVzVMaWxST0FlMnRBTGdsd2REMnVnTjZYMkZiOFprSGNCbE8r?=
 =?utf-8?B?bjdsT2xUVjczSk9CNjNpRVQvNE92YmltZjRER3JpNG11ZjJ5M2p0TTdmZHRJ?=
 =?utf-8?B?SG9yRFkxQ0J4ZWJsMnBpa2ZlRTdEakx1cUF5MWxlNllSU0lkS2tGZEZRTnFz?=
 =?utf-8?B?dENhNFBBNk5BVkxZK28wLzBjclhlOGloaE1XcVZhQytLZ0ZML05QVWIvWFgx?=
 =?utf-8?B?cEsxd05TV0I3QU9vWDZkNmhIK2N3RHBMaHZNc1o2UmVZekwvTVlkZDd1aG5F?=
 =?utf-8?B?UkdOazkwdG44QkF2aG5PSDhFK0lLaGRiT3hBcXY1Z1RCalIxTlFZYzFpRDgy?=
 =?utf-8?B?S0VreDdQdnAyQnFzamplSU5uRURPYkx4QjlPZEJRbUpUMUpaN3p1SmRnaHJr?=
 =?utf-8?B?ckJRRlhvUkVEdkJLWTc2N3Evcit5bUFwb3EzbmFyOE84OEU5eTNkb0NxMzFx?=
 =?utf-8?B?TFBjQ2lWdkpINDBkcUhFZVpjVUFUbC8rdnpwaUg4MHhPQzV2anZlODJYeVIz?=
 =?utf-8?B?MXIzd3g1c25zN2gra2VzOU1OZUoxLzRFQ2NFR1UybjFxYjJKODgvbUpmNVRn?=
 =?utf-8?B?b1RVWXgvc2h1c090cEJhLzZyUGt5ZzRnM1VnbThQU3ZjTDVIMk5kN2xFb0Fv?=
 =?utf-8?B?Wk5FZGpYbVh3UlR1ZnlmN3ZxUU5GMHBVK0VrcnFxb2RXczlhbWl4c2xwb3k4?=
 =?utf-8?B?N3dsZThCWjdlK2d6YklzUVhZWkNFZDhQM3h3b2NtSEtJVElaVC9EUlBhemdF?=
 =?utf-8?B?ZVhQcHJNOTlKdnZGbGlTaFNFUU1GMHFIUlVjMVBzTy9EWGFWS2dMZmtzcWlw?=
 =?utf-8?B?TjkvT3FDRTE1V3piZk9RS2xlL05ZVitYZlhnRVEvNVliQzdTSWQ3ZUhZcC84?=
 =?utf-8?B?VnB4YUljVlJ6RE5Pc21aeGo2cVVkTkJSMGdOWnlEcVhLa0xvdDdFK0dYZmtY?=
 =?utf-8?B?VmxvUytYVnFWbXNnRHhMTzNpbFB6UnBOQ3plKzFMQVdyMFJhU2E5VmpUeDhJ?=
 =?utf-8?B?QTlaajN2V1RQeFl6eG9kaHpXZTZTWnhrb3NVNGdWY1VrR1Rqb05Md08vZUs4?=
 =?utf-8?B?aWNlYlRFRTZzMUgwMDJ4K1phOWxtb1BpNVhKWjFRTXN4ZFljUTkyUUlZRWlq?=
 =?utf-8?B?a0QyUWUyR0MvSjVHWnhYZjJrczQ1TVdMa2puWjNIUWozd2hBRThxM0k1dzhQ?=
 =?utf-8?B?Y1V0cnVlZ016NHNxbjJ0TnFEajB6SWRTSElHTENWSkQxckNJTTJLeTRhZnF4?=
 =?utf-8?B?NWpZcHAvQmd2UGlxRDZSbVNlcENtUDZyaENXTzlkd29xNE1mSzdqUEtlY3Qy?=
 =?utf-8?B?Y3ZON1hZNGJPeGNLMkhBYWdUL2M1S0tXS0RCRjI1YWZVREtzbVZqaUEzZjBM?=
 =?utf-8?B?MnNEMjJNaTF2MW11VXpYWmdsY1NYb2M5dzdlWmdncDRwbkhOVlhZc3pKQlVv?=
 =?utf-8?Q?rKMteP+v4V4054wGSqIKvFC+Ea7RckfO8Z9wOezNmaMb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fnal.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR09MB11599.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4adf25-daef-407b-fc28-08dd62226acc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 11:30:11.6466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d5f83d3-d338-4fd3-b1c9-b7d94d70255a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR09MB10636

DQpIaQ0KDQpBbGV4YW5kZXIgQm9rb3ZveSBwcm92aWRlZCBleGNlbGxlbnQgYW5zd2VycyB0byBt
b3N0IG9mIG15IHF1ZXN0aW9ucyBvbiB0aGlzIHRvcGljDQpTZWU6IFRocmVhZDogZ3NzcHJveHkg
IHNlY3VyaXR5LCBjb25maWd1cmF0aW9uIGFuZCBsaWZlLWN5Y2xlIHF1ZXN0aW9ucw0Kb24gZ3Nz
LXByb3h5QGxpc3RzLmZlZG9yYWhvc3RlZC5vcmcNCg0KUmVtYWluaW5nIHF1ZXN0aW9uOiAgDQoN
ClByaW9yIHRvIFJIRUwtOSAsIGluIHRoZSBzZWN0aW9uIG9mIHRoZSBnc3NkIG1hbiBwYWdlDQog
ICAoIHVuZGVyIHRoZSBoZWFkaW5nIENPTkZJR1VSQVRJT04gRklMRSAuLi4NCiAgICAuLi4ub3B0
aW9ucyAgdGhhdCAgY2FuIGJlIHNldCBvbiB0aGUgY29tbWFuZCBsaW5lIGNhbiBhbHNvIGJlIGNv
bnRyb2xsZWQgdGhyb3VnaCANCiAgICAuLi4uIHZhbHVlcyBzZXQgaW4gdGhlIFtnc3NkXSBzZWN0
aW9uIG9mIC9ldGMvbmZzLmNvbmYgKQ0KdGhlcmUgd2FzIGEgY29uZmlndXJhdGlvbiBwYXJhbWV0
ZXIgInVzZS1nc3MtcHJveHkiDQoNCndoeSB3YXMgdGhpcyBwYXJhbWV0ZXIgcmVtb3ZlZCBmcm9t
IHRoZSBjdXJyZW50IG1hbiBwYWdlLCBjYW4gaXQgYmUgcmUtYWRkZWQgPw0KKCBhcHBhcmVudGx5
IHRoZSBwYXJhbWV0ZXIgaXMgc3RpbGwgZnVuY3Rpb25hbCAuLi4gaWYgdGhhdCdzIHRoZSBjYXNl
ICwgaXQgc2hvdWxkIG5vdCBzaW1wbHkgYmUgcmVtb3ZlZA0KICBmcm9tIHRoZSBkb2N1bWVudGF0
aW9uIHdpdGggbm8gY29tbWVudGFyeSApDQoNClRoYW5rcw0KDQpBbmR5IFJvbWVybw0KRmVybWls
YWIgLyBJVEQNCg0KDQo=

