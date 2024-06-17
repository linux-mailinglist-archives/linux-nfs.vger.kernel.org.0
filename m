Return-Path: <linux-nfs+bounces-3907-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE9690B3A5
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 17:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93CE01C214CB
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 15:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEAD157E94;
	Mon, 17 Jun 2024 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W3C+ChBQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tZqLbTk4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB49B157498
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634744; cv=fail; b=BiGJKZOhzLJ/CjvLLD/JlL7jl199ANm5fQxD8BN3H2fNIGeJJTB7QakG7xepGUQWVu4XxSbs9Fe5buRZlWYj1PSXJyrqPhrqtUqGHhmn8JXwFKqMv4gBfpRzr+K2osA8MPAsv3niUoq0jvsd/+ECbypyjxDTiQTXLln9x3IUf8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634744; c=relaxed/simple;
	bh=9Bp0FuhHcXeoufZONg+m/YcjY2eTGjVZjppk6MQ2Dxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CGEZ94VIxlLbUus2WZenOkGvDDHBEWjYi9TcXgFGk4jydmqq/qd9PZ7rs3A1OevyaYu/ChgTVT8th3knuHCQOKenZ7vLvLYU7k0z/iZiwfktsUhFN3XVH4Ol+akEAfcIn7PsYQ4hsZF9BjTdXBunUG9b1eg9K7RWAnD710p2fT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W3C+ChBQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tZqLbTk4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HEBP1i030705;
	Mon, 17 Jun 2024 14:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=9Bp0FuhHcXeoufZONg+m/YcjY2eTGjVZjppk6MQ2D
	xw=; b=W3C+ChBQQu3q4oGEg5ZEq5icCJohiREKVbvA+l0YiQj0i4/TXs4RARdhv
	3CJt7xsmQ/VD05S8rtfFPY2xev73glCHZiV+Gjhgo/PsLG5PEX6HukS4UBqmFEXK
	5AdJxuPdxXHaGzIJqNnc1J1Xhw/rvhDGwThMmtFUm1fvhZxcETU4sJN/l2g7SUoy
	i1CIUR2sGMaFijfJG5CfKt1uRRDbv8lJS4n7M4qCd3P8NThnreHHW8sOfLXR1IQk
	b0eD0fDgRiPAeLs5JHVYg2Aftisz/1yGGS52h7R2WUX5XpvxNHE4kzst7FhU3F5/
	WO//e3bfFA6CabLQmTrKrrkKgyYcg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys2js2str-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 14:31:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45HDNhhU034772;
	Mon, 17 Jun 2024 14:31:57 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d6smwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 14:31:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSh/T4u0Bvad4rXgrZgfiUVUl6aHaafKrsApgwT9wpB7j4LBfOD2EjdHq9+AMozwRgiigs7GTHs43LmJPl4Tqp7sSBCBZAlvtDaHPzS1xiQl1kwjxoKuc5H0fFQLrOBidDWqwPUDdMdpboN26UyOvVlwVOEGhqFL+etqAf2lq7OVwU4EJeNXHAfLhrdap8vX6uiAyzPOH4lwKD/tAAQ8QuNd3EHYyG56exVdxVblSMI7C+VtZzjAARjdSyubkmUCp00PFq5mEpcXCMLMGNGxK21Kio9j0pcG/PAO0uzHF2hdFf0IiXCNZhrqFjsCsw9heia7R8eLO6TCILR6bzbDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Bp0FuhHcXeoufZONg+m/YcjY2eTGjVZjppk6MQ2Dxw=;
 b=h/1NnhnxloO4rLHJhkuXkn46vbQTai7LbQshfU1NnQ2eWLMj021VeCJVw2lJbut+7JQURm7lfmhpclSSFFaXbHaTTZGVbviBDjOFujiXVpTBwzS1iVxiEDbeccucTt8QsDvS8xzxngQjmqgJr9RDWJAbdTeulMVfXpw1e4i6P3dDWJREc1xsjVMHtDRtr9EGSXQ0WN9hRPFzkG8mRxNxVfxOCJeMhvGKuggyUgcjcg9Gr92YDmDBoXbRXH6wbG3UuTRyYf0j3y+noXCvSC+9lkU5xo2qiWsVUoJhez0fakHPMNcGCC5WsyjcJNkIoA9ewX0yvrrCGvnGJhy8VUc+HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Bp0FuhHcXeoufZONg+m/YcjY2eTGjVZjppk6MQ2Dxw=;
 b=tZqLbTk4cVaXPCYLQsxNV8SULH0hP4/6DdGkMZDFnQchy4E7i7V4UM45IU1bPu4AkW52m4TqgL7XRzvXkhKb9f91PdXulnRgWycVS6KwJmmcKx0KgLoRBC1WZV9gOMybp/HA1yalKte7bNYpJ9+rx7jFAUBdZjOe0nluLfkV6tU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7351.namprd10.prod.outlook.com (2603:10b6:208:3dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 14:31:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 14:31:54 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Harald Dunkel <harald.dunkel@aixigo.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfsd becomes a zombie
Thread-Topic: nfsd becomes a zombie
Thread-Index: AQHawINhxmk/oYie502r8DWoEFDBZrHMBR+A
Date: Mon, 17 Jun 2024 14:31:54 +0000
Message-ID: <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
In-Reply-To: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA0PR10MB7351:EE_
x-ms-office365-filtering-correlation-id: 47861ae3-f0f7-484d-4f1d-08dc8eda3c7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?QXlLVGs5NjV3eFZXZllLamdtOHo3VGJiaHVLS2FXT1hJSSs3am81c2lUWC9B?=
 =?utf-8?B?dm0ydFNMcHNwSDZ3RU9PTWpGUy96cHh3alBySVZZRm1rUzVXcVpZa0s0bVk4?=
 =?utf-8?B?dHZSMzA1NGp1dHVYNFErTUtXY0FuZDhEVmNkK0NpNDlFVGp6T3RaaTR3YzNX?=
 =?utf-8?B?T1hwTmxOTnFWaU5DRHcydlc4RVEwOTdzd3M0bFFBRzN1c3VTS2V4OHNSenZH?=
 =?utf-8?B?UXMrVUp4ZWZsMlppUXJpYVd5d1NVT002NW9ydnF1K1NZUUh3eitpdjEvdmNE?=
 =?utf-8?B?eXpJcmVpWWRpWndJNGR1a3RhOVNGV0VTTHZiVWRqZDI1U3lYRGFDNDhyNjRp?=
 =?utf-8?B?QUxTU3drUUpoalRrZE05Zi9wNWYxRVJiWkFsaU8rUm4rSmZvNVAzV3Z4RnZo?=
 =?utf-8?B?eEFJOHYxa0VDY3ZRN1J4Rk10RnRPWmE0QXdBeVJiV2JYb3ZxWUJlYWh3aUYv?=
 =?utf-8?B?M0ZJSHVMYmFVdkx3ZmhieGZoMUZCbThBY0hlQzhXaitMSER4R1FNaDRuYTFr?=
 =?utf-8?B?d3YwNmk1QTNxT3Y0WVI4QkJkNFFVNGRjVUlEOFhBSUVET21oK1A1YnFkaGlV?=
 =?utf-8?B?aW1janZmM1JuYU9pdVhlWkdtang0NDFFd0d2bVNuOXc1UFFRWXpMakpiV1Q5?=
 =?utf-8?B?cGxQRzFqcThnTzQ4OXhhVi9NbFZ1aW1FM1BVQUhBSnh5V3dQZkRqSnBkT1Qz?=
 =?utf-8?B?YUc1VWVkR1c5TThzanFFRGJUdGRlQkN1bnFhZEloWlp4NnFmQjIxOXpQZWVv?=
 =?utf-8?B?STNPbzBnTjRNQTc5UzVyRk5DQU9hRmFHdE1EbWVZU0Y4bEV0SjFaRHE5Ukgw?=
 =?utf-8?B?cTBVaFo5NFZlekFnejUvWDA0ZkFoV0MwQzJpMWEvMzE0cXZNYjZYRHFkVmJn?=
 =?utf-8?B?dmIwajVEd0VXL0J3NkpYRGFMbVQ2NE1MOUdyZUJIT0gzTkZ4NUJENERySzQw?=
 =?utf-8?B?VDdSMlhZV3FkQ2ZyWmhHZVRmZTBCS1djcFNpYzZNK0hFMlVxOU0wVS9OWVpy?=
 =?utf-8?B?a1NROU5MK09UOVhQVjZ2czlFSmtRU3l4UE15bHBDK0NiQXVUWGdnbjJpV0RQ?=
 =?utf-8?B?ZlZBclQxand6SWlJUFlNWHE2NzBPTmxKSDJiWVFUTVFYMzlxNzFUYlQzOFlk?=
 =?utf-8?B?emVRQnRHYVlmaTZ1VW9RUFZIRmtRMkRGSUNFTnJ5bzlIZHMrME12c2s4WWZu?=
 =?utf-8?B?Ukt4a2tDWUpaODBCSlZUdGU0dUd6UklxQ203SWpBRVdzRlhKbE44dzB6OU45?=
 =?utf-8?B?akJ0TGwrS3JaRFlQOUZZK2p5ZjJCOGVpY0ZEb1FVNDRENUVraU16OW9ualFo?=
 =?utf-8?B?R3NRRXlIWEtvTUM5UERrWUdlTjBJcjNqbkoxb21KUnBSVDNvTFltcWZSUUc2?=
 =?utf-8?B?QjVmZVpsa3BaRFV1WTNSNnRib2lKanFKSnJTSFZUV3VGNHhWbkVteC9vMWVz?=
 =?utf-8?B?UWJ1SVNaQjl4ajMzdE9oM0JEK0J2eFgvRjlERzBYdTdsM3JXQTU1U1ErTmY5?=
 =?utf-8?B?R09wMlE4ZUhDQTQ4LzRBVm0zdTFzNkVvcnVod3JXR29jZUVaZ2ZVSEY1bFg1?=
 =?utf-8?B?akRYNEdDdllmcjFIbndGbDVCN3Nsc2U1dGRLWFBGMjJjVHNldGcvSmV1Si8w?=
 =?utf-8?B?c0hzR2g1RVFlQlN0ZW8vbVp1bm1WbjBRc3M0dmVZbEZ3MmRhbEZrMUI3bkts?=
 =?utf-8?B?VFZ0MzBXc2NYNHVxNkt1anhpajY2ZExkeVprSHNpVEs1RHJiVU95WThON2JC?=
 =?utf-8?Q?UiwgXVeHKmZbW1PtDZsmfOIddJNpmWl+nHJzUdg?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bUdqRGpDSkk5MG4yTjl5Q0dMK3Bnemxwb2tQdHVDK2x4SWpxT2ZTSS9oRXBP?=
 =?utf-8?B?RjU0L2tPV1RCd1drdmxNcWpZbVY0eTg3VGR3dWx5TDNKWHEwV0NQMldabVRV?=
 =?utf-8?B?VG9Bdkt2R08zaWJTUEh3WG81WmxLUGc1OTgvMVBSbURkamdGampYSFVxVEgv?=
 =?utf-8?B?T0VFT3pMUUlWQVNsdkdkajczeVJ5bmZmYTlSeEdRWjVJRUpISCtHcmJlMTk1?=
 =?utf-8?B?L3J1Tk92b1p6V0hrR3luV1RwNWsrcG9zZEF0MUx1bDN4SkhGb1J3NmxUWmZM?=
 =?utf-8?B?QTMxQTBVSWVGcUZ3NmZ1VU9EU01TeVpndDl1YTlCeG9kSTdzVG1jYkIwa0xE?=
 =?utf-8?B?Ukk1YmM0alZUU0M1Y1krMm9CU3JadTMyRWJtWnNNd1BrSm1IZCtnY1Q5bE56?=
 =?utf-8?B?VHhOSWR1T2UrSkJnU2ZVMys2YzE1N0MvSlZyRHlFaGtXTzlnNEJoaVdkN0Vt?=
 =?utf-8?B?Zk9lMjBQVHcyQ0tVU0xZMWl1cHRKQ3dlMGVBaVNCc0YvOFp2SlQzQ2YzVjFa?=
 =?utf-8?B?eVRRY3p5REcxcDZiQVY5aGdGQVRiK0hobkdaMW5BbGlncjVQQWFlaHhpQ0tV?=
 =?utf-8?B?akUwb3MzWWl1cFk5eUJBdFFlTTl2OTM3RmJnTk9udlNjRmtMR1BQUm9pbjZL?=
 =?utf-8?B?djllZ3NnRjJBOTBveFlYeUpUZjlsSjVBYXgxUnBGNkJMM3ptRG9QSnRGcjAy?=
 =?utf-8?B?U09ZVUxnVDhaOFdZK3E2UFpsZ0tMQVoxU1pCMUZoc1dOZkNDNEljc3NNWXZE?=
 =?utf-8?B?Q0lGaXZ1bDFWSXY1SnhDVGk1OVArUGliUCtxMTNOdHRRamR5azlVRmQ4ZXNN?=
 =?utf-8?B?eGRHZTlPYnZ4dW42Wk53OXVsVE4xKzdQbmtpS3NjYmMrQW9kSE5xbkYrTjdx?=
 =?utf-8?B?ODZKOFFJeEpVdklzTkNUV0xuVTVjOGJydFozOHY5cUVxL2RhbG9yQTA3YVpw?=
 =?utf-8?B?MXhMYlREc1dsMS9oZHFsZ1pvU3JaMTVOSTZodnRSYkY3Mm8vSDkyZUtXQVpF?=
 =?utf-8?B?a3FhSklJb29oYjE4dk4ydGVwdkdpQjhZeTdXV0RaTWcwYm1zb1lMQ1llaEtp?=
 =?utf-8?B?K0ZSdk1lOWF5allTeXZ0Z0Y3NjJ6K1pxM3FiYnZValVnRmt5VUNLMHpjSXVX?=
 =?utf-8?B?alNHTGZWYTVseWprYUlVY3VhejhJVXJac0YrOE1lQ1VFbFA5US9Fc2ZiaDhR?=
 =?utf-8?B?L0dYU3U5WUhRb1pDTjBEU1FhVm9rQVVydC9YOE82Zm1DWCtOV3hlbkQzQjRn?=
 =?utf-8?B?a0d5RHNLV1QrM0NvY3VWaTd0bmNuYmpwaEFhTnVSYzNUL2pxaHBwRWVaVUJi?=
 =?utf-8?B?WnNGZmJzUHBzaGRCNVVLaW9mZlhQMlJRTWtHbE1iY1RoMlJEaWs1YVFjcGtl?=
 =?utf-8?B?dGIzQWdNb1VVZFVoSHRTeHZPazBxZTlFZG9FV21mZnM1OWd2MzlRVUNKcmpZ?=
 =?utf-8?B?MVRVWS9OLzBaV2IwNXYxdUZYMzVuZmc0Y2NYVDl5K2Nxa053ai9VV1dRdndu?=
 =?utf-8?B?MFZ3NDVlUzlLUE1WQkRJa0c2Q3NHbU5CdERXMWdnQm9IcGdhMlhxTGlJNEgx?=
 =?utf-8?B?WkV5NndnY2NGU3dWUG44UzFnOWdKeHpvZFRSTGFrdk1xTnROQUpEMjl5ZHhm?=
 =?utf-8?B?V1FlYXRiWG5oY2N4NU1SRExwOUordFZ6ekdFUENLd2tLaUZIRDRuM2haRTRX?=
 =?utf-8?B?TkliSVlxbldhTHBOMk13a2dQR3dBaDRHL2lETmQ5MXFVL0sxazlHOFJsZTBq?=
 =?utf-8?B?eVk4aTZsaHI1Tm51MEVlNm1qQzJSWWZlc0ZiWkRVM3lyYzFBSkVvSmVKa0g5?=
 =?utf-8?B?aEdjcFVCazVMUm1nbDZZQmQ5MWxwYmJLZnFvODM2T1pZdXI1cEhvOURKc3lp?=
 =?utf-8?B?OXZQWnM2dTlCbUt3MGZad1pkMVNRM3diYituMG1iTUd4dHpOTnZyeUszbklZ?=
 =?utf-8?B?bzVadElaK3A4UGVLeFBwbXo0ZlFLK1Fka0xXaDB0SnJ2eHlCUm8xQzNTd2dH?=
 =?utf-8?B?T29MSjFTdHdQME5YZy92ODFnQStyR0FDNkZsbWNoKytFYjlKRVh5dk5sZG11?=
 =?utf-8?B?MDNJVSt1TUE2UkZscHZIeENuWDJIRFBZbjBIMkRqU2prZzdxMjBCWmYvcW8x?=
 =?utf-8?B?T1lVUis5TVprTkhsY3RoeFAyR2MwdElpRjRpbStOL0F1U0Rka0Z1K3hVdnNl?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B797146E6289748AA00A6A3B06E1EFA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lfOS2WlBeCxw5D+7wN3XDBrWHndLDvo1EgSU3sJN/pBbj4BZI0keZH4Gmn4zcfzMXx3vZv9WQLUTETKiM7vu7DWv7B0IqUeX8DtTvCGYsyvTjwEwXfX75UzfEl225NQP7p6tZTNio9W6jTQWRPi1A61V5zYiFppZV8Aknp1ekvGxLaUgeg0OozK+uHfE8woAcnIKVxDtlfEJVMAAssnAMTZCE9aCLCMLXZCQ2KGQA5xd2qiTJDpBXlRq9G+doL4J358dPRPBp2CoWGvxC+PRtrOAXqiLiKISNz4k7qufg5KyrR1IvdfrYuDvE3jzqrGnzaMgBN3h1Au//dl20VQgWSt2dOdTp0g0vAdL6Rbq8gvTsS20lSVJD2+ZFGcLBeORVdkXxqTvDCkIjDlWMlG07jjMp2cPhO8pgxYBfzCa9HvBQ3n86UcrVZNXG2AhNHXZ/MrWPLVkBVyMU/ynfmG/SCjfEYxNv8Yc+fE3wK5JoS50q4KLXaobM99bMhAhnby+5Sa5Qlaai9WQn2T9qR4kUgAIHqGgPzLFWQX6I7nyVFyV22TyxcPLWp92p3CMuHnUwl5JHXYlSidnyBhTDLtvO618FKLK6zEYS+5hJsmSGp4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47861ae3-f0f7-484d-4f1d-08dc8eda3c7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 14:31:54.8352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MwtsMofgvm0KeJxwTovqA3Br3uR49u7KXA9MmCIcfKtNFUSMdbZC/+HRkt3GEOLyBN31wGsgE62LlQ450lXsvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_12,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406170112
X-Proofpoint-ORIG-GUID: HRDuxlO_65Fwjf3o-17OxucrU_i62N6U
X-Proofpoint-GUID: HRDuxlO_65Fwjf3o-17OxucrU_i62N6U

DQoNCj4gT24gSnVuIDE3LCAyMDI0LCBhdCAyOjU14oCvQU0sIEhhcmFsZCBEdW5rZWwgPGhhcmFs
ZC5kdW5rZWxAYWl4aWdvLmNvbT4gd3JvdGU6DQo+IA0KPiBIaSBmb2xrcywNCj4gDQo+IHdoYXQg
d291bGQgYmUgdGhlIHJlYXNvbiBmb3IgbmZzZCBnZXR0aW5nIHN0dWNrIHNvbWVob3cgYW5kIGJl
Y29taW5nDQo+IGFuIHVua2lsbGFibGUgcHJvY2Vzcz8gU2VlDQo+IA0KPiAtIGh0dHBzOi8vYnVn
cy5kZWJpYW4ub3JnL2NnaS1iaW4vYnVncmVwb3J0LmNnaT9idWc9MTA3MTU2Mg0KPiAtIGh0dHBz
Oi8vYnVncy5sYXVuY2hwYWQubmV0L3VidW50dS8rc291cmNlL25mcy11dGlscy8rYnVnLzIwNjI1
NjgNCj4gDQo+IERvZXNuJ3QgdGhpcyBtZWFuIHRoYXQgc29tZXRoaW5nIGluc2lkZSB0aGUga2Vy
bmVsIGdldHMgc3R1Y2sgYXMNCj4gd2VsbD8gU2VlbXMgb2RkIHRvIG1lLg0KDQpJJ20gbm90IGZh
bWlsaWFyIHdpdGggdGhlIERlYmlhbiBvciBVYnVudHUga2VybmVsIHBhY2thZ2VzLiBDYW4NCnRo
ZSBrZXJuZWwgcmVsZWFzZSBudW1iZXJzIGJlIHRyYW5zbGF0ZWQgdG8gTFRTIGtlcm5lbCByZWxl
YXNlcw0KcGxlYXNlPyBOZWVkIGJvdGggImxhc3Qga25vd24gd29ya2luZyIgYW5kICJmaXJzdCBi
cm9rZW4iIHJlbGVhc2VzLg0KDQpUaGlzOg0KDQpbIDY1OTYuOTExNzg1XSBSUEM6IENvdWxkIG5v
dCBzZW5kIGJhY2tjaGFubmVsIHJlcGx5IGVycm9yOiAtMTEwDQpbIDY1OTYuOTcyNDkwXSBSUEM6
IENvdWxkIG5vdCBzZW5kIGJhY2tjaGFubmVsIHJlcGx5IGVycm9yOiAtMTEwDQpbIDY4MzcuMjgx
MzA3XSBSUEM6IENvdWxkIG5vdCBzZW5kIGJhY2tjaGFubmVsIHJlcGx5IGVycm9yOiAtMTEwDQoN
CmlzIGEga25vd24gc2V0IG9mIGNsaWVudCBiYWNrY2hhbm5lbCBidWdzLiBLbm93aW5nIHRoZSBM
VFMga2VybmVsDQpyZWxlYXNlcyAoc2VlIGFib3ZlKSB3aWxsIGhlbHAgdXMgZmlndXJlIG91dCB3
aGF0IG5lZWRzIHRvIGJlDQpiYWNrcG9ydGVkIHRvIHRoZSBMVFMga2VybmVscyBrZXJuZWxzIGlu
IHF1ZXN0aW9uLg0KDQpUaGlzOg0KDQpbMTExODMuMjkwNjE5XSB3YWl0X2Zvcl9jb21wbGV0aW9u
KzB4ODgvMHgxNTANClsxMTE4My4yOTA2MjNdIF9fZmx1c2hfd29ya3F1ZXVlKzB4MTQwLzB4M2Uw
DQpbMTExODMuMjkwNjI5XSBuZnNkNF9wcm9iZV9jYWxsYmFja19zeW5jKzB4MWEvMHgzMCBbbmZz
ZF0NClsxMTE4My4yOTA2ODldIG5mc2Q0X2Rlc3Ryb3lfc2Vzc2lvbisweDE4Ni8weDI2MCBbbmZz
ZF0NCg0KaXMgcHJvYmFibHkgcmVsYXRlZCB0byB0aGUgYmFja2NoYW5uZWwgZXJyb3JzIG9uIHRo
ZSBjbGllbnQsIGJ1dA0KY2xpZW50IGJ1Z3Mgc2hvdWxkbid0IGNhdXNlIHRoZSBzZXJ2ZXIgdG8g
aGFuZyBsaWtlIHRoaXMuIFdlDQptaWdodCBiZSBhYmxlIHRvIHNheSBtb3JlIGlmIHlvdSBjYW4g
cHJvdmlkZSB0aGUga2VybmVsIHJlbGVhc2UNCnRyYW5zbGF0aW9ucyAoc2VlIGFib3ZlKS4NCg0K
DQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

