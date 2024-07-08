Return-Path: <linux-nfs+bounces-4716-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3731492A4EB
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 16:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00682830FA
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 14:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF599133439;
	Mon,  8 Jul 2024 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZWVgzTGV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EvNKH1WT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373DF135A4A
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jul 2024 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449711; cv=fail; b=udaLSuslX2K9iR5jVj7jOK5ZFIgoEXh6jHs2C38z514gTm7yyNsa7VZbr5qdFez63/Xx7lverM3afSeh4lMThauTd5uudgwXiR7q84gfAWb2MrNx6rGeFAlJlWGD7idUxte6HFVYbowp8bLfvO9pRlq4zjI2Xan1eSQSOIodufo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449711; c=relaxed/simple;
	bh=CbQhWYY0ymaFdhY4w/V8amOcTCB3h1A6tHqfQmqKWik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tkuoBmZFHt1RDQ517epq7r8ooLNnXuEYAZfA3mVFuY0MeoRHms86SNaJpTgwGdaYiT1rqwy3UVl4CZCoowECi3TQMGnJyuzBuM++yaSurPGVHeFaKTcgjWN/m2Ze32K6u75RI8VzmPjhDQ7uyDtsVo5OyigtvNnMoIhuULBU6AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZWVgzTGV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EvNKH1WT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fYr1011958;
	Mon, 8 Jul 2024 14:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=CbQhWYY0ymaFdhY4w/V8amOcTCB3h1A6tHqfQmqKW
	ik=; b=ZWVgzTGVqDbIuJuoxkG/x2Ofv48ZVcwdj06rpTLYdcbh6i4wiwMXIGdkI
	YmZoi8cWwKpje/yQQO0nDa32lOl9cuaAIwtN/tJ8to2B/uGcUaeA636PXbuxkkyx
	QwGRiOtucSyvj92p1N9IEEBlUO0v9FGLgaGk+KmntvgS5NQYxonUtv/D1bzI95VG
	gU4Ts9gXqutla/ZwMgMHM7+KsAIcfkW3//M3yqkSI7pmRd3jVCU9lhxnDQs/6pAh
	nNwVS76nzkRL0tAWA+laTAX/XqlzfoVLq5q3/SUVN+P29fkofJ5QJQn7pI7G1R/a
	MU7b1RxS+tubbQAJfASeDqsr6bXdA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybjtr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 14:41:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468Eegb7004476;
	Mon, 8 Jul 2024 14:41:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tvc83k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 14:41:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERUeaLKJwFRRNbLqXTA/ynsWM96cQlJUC8Md5roIwb0Ro1EWcNvfdbnAbNUc/o8Hqc6Tq3Ckfe/JLTE8hj2JMgN8LjBypOmdAdWpRpzrSwK6lD9WuKXXJZSahWfbKkkCeypTt2+oMFriVONCZeNlBJvPiHhngrILRotEAV+/N6OSwr/BKfeJSDvZXqm6Z96SOhKyjKkNhx5vgYSDNvORFFMFr2DztBBCswX/DPJCqjjrWkSQA8H20HkkBRa8CvjfUWwTSdQOMr24H77J6LqsAfNmTNvF9Qnyt8L6G49UyGS7UdEVuVxSigyZJVEaITqfFnes4lUwV2h7eB56Cbim2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbQhWYY0ymaFdhY4w/V8amOcTCB3h1A6tHqfQmqKWik=;
 b=mGkHieQ8zWrfVrcqrAKlJc+sWuzacX0RJpyhxo/CMpj73NI1jIkOshsUZt16e3r9sHn1uUor3asf4d0lBZEfCcWKBkBQKV9UTfnzLaE4+/8K3ux9bBOptnZhk2pEecKAZI/Mo4NHhimdann0TZLIpBEGR3Hi1e4af26je2iqk26LrQr+szhMOQfaHHl6JTQu/k4hDPULIzOrN5yRK3IKA9oAzYwxPP6+uUcotVy1feyYS0Z5TckGOo6OLdda3fbo6sH8K+O5uYAxc+T+2BAiPn/DYoDZ4lq6pNqgCvkjUdIYF3eSnF9s5ixe715D7WWheXOpQGYUWpAa4rljAeG+gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbQhWYY0ymaFdhY4w/V8amOcTCB3h1A6tHqfQmqKWik=;
 b=EvNKH1WTs9iI6SvqA9ixx/BXM5pE3uLTSlDhzd9qzsxrRBGSmP5UQZbqUo19GgwlCp7nwmyT3EkAXhp2L3krP73bi9Cr69M/G08FVodb88LWWXHAhhGjNxrncFMiuERIy2euY9i2ZesTS2UaEnC7No/47Tk5czOp2N/7A+Sp/VU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6408.namprd10.prod.outlook.com (2603:10b6:806:268::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Mon, 8 Jul
 2024 14:41:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 14:41:33 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond
 Myklebust <trondmy@hammerspace.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Thread-Topic: [PATCH v11 00/20] nfs/nfsd: add support for localio
Thread-Index: 
 AQHazJzmgcDeJH7XRUCD8QiVhiofhbHju8AAgAC4HQCAAD+aAIAAWoOAgAAPdYCAAAG7AIAAAbOAgAADUgCAABligIAA2CSAgADR6gCAALSggIABGiiAgACEe4CAAAnNAIAAAW6AgACwwACAAkl6AIAAsDwA
Date: Mon, 8 Jul 2024 14:41:33 +0000
Message-ID: <6A5D3C4E-B1EB-4634-9D74-008487F7F2D0@oracle.com>
References: <CCC79F21-93A6-4483-A0B8-62E062BE4E6A@oracle.com>
 <172041183681.15471.6809923976922602158@noble.neil.brown.name>
In-Reply-To: <172041183681.15471.6809923976922602158@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB6408:EE_
x-ms-office365-filtering-correlation-id: 496cdfbf-6950-4248-18e0-08dc9f5c1010
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ak5GY0ViMXpCN3lZWEN1aDVOcmxLR3VodGNTVldDLy92VFFmUUxmbVJPcTRs?=
 =?utf-8?B?UnI1TjEwUmtXNTV6cU51N3k1UE5hbTIzVmt0djJZTVRsL0hCYUdUclErQU9C?=
 =?utf-8?B?Y3kyVVllcWpOS0FRdGduVFFQRjhmQklGWExhQ0E3OS9pNmhpTERMZ2RyQmVI?=
 =?utf-8?B?UW5hLzB1SjNnZDFLZlJydkI0UUhGWFlrNU9qWk9hbXBEOWhyb1BSajNBT0M3?=
 =?utf-8?B?VVFiaE5HVG11WTgwSlZzUnBzMnU0dnprakNMc09QRTV5cWhmRVJnRjNFYUNH?=
 =?utf-8?B?bGcybi9WUVNYZVkxUFIyc0daRzB4RzJ4bWpJMHBKS2U1LzFUNVYydkNvNGdH?=
 =?utf-8?B?RHR3UFZtdTF5ZEpEV0JxS09kTUo5d0djbGNPK1FVRzRzVm5OYW9NV01lQ2U4?=
 =?utf-8?B?VmR4eUFUQWZuVTVpaEtrUkxycmoxM1NFeVZGL09lc0Q5dWFiL2pWWWc4MVd5?=
 =?utf-8?B?OHZ2MFo1S25UVU9iWCtwcTZpS1NtZElBMEJranpKU3ZjS1psSDQ0dGNSU0RL?=
 =?utf-8?B?cG4wbnRMOE5WTVFFelo4Qlk1SzM1Q2R2cXZ6T24rUUIzRFJpSGY4SmZjaG1C?=
 =?utf-8?B?b3NVM3RVeHM4Q1Z5RkRTbkZNY1M5cCtNZGk3K3FDL253TkJvREkwa3V4TTI0?=
 =?utf-8?B?Z04wdGo5UU1EZnJwamFRRmpVODdCRUcyMzV6L0YrVkRPUVZ4eG5sZTA3a1Fy?=
 =?utf-8?B?bmt4UlgzRDF1ZjIyYVBGRXlmcVF5QXFKbzExK0xIdzFxQzFWSm4ydVkybitU?=
 =?utf-8?B?TkxodVBHWWtZTWJ5MUl2QmZaczMwS2xJSEdMQUpqbmF6MGp0L0tWOGFxK05N?=
 =?utf-8?B?aGdQYmQzTHFHQUJLcHZiTnJNYjhCT3lTYkRxT2dDblBFQXlWbk00S2MzNzZu?=
 =?utf-8?B?T2tHNmpLTDFCTllrMVAvSXgyK2FLb3J5eGlTRDdLV3gwZVJxS1lVWFVCbUhU?=
 =?utf-8?B?TE9zY3FwZ0FBUEw0Yjg5YVlTUEx4ajBMeXVJVG5pL3ZDOTdTNTVtNnRPM0xR?=
 =?utf-8?B?alh1M0tUd2VDNXpuMmZNQUw5L2FHT2loZkt1ZS9ya1hyKzQ1eGRSNlYxdVFD?=
 =?utf-8?B?Y01ZTzIrMUlCM0kwazRvQldBeUZjMVVQN2FWMnQ2YVdRc2g3TXp6S0RwQWsv?=
 =?utf-8?B?MUxaM1h6ZlkzZi9GMTVxYTc5ZEs4ZHFDa1NXWmRTV05QMk96R1FJTW5WdU5k?=
 =?utf-8?B?Y0pMS0M1RXhiTnIwYWZEbG1FMmJmVEJkaGY1M1FqdzhVZzVQZUp6UXhRa3U3?=
 =?utf-8?B?VlhLMkQ3bWxLL2Jic1BpcUpYS3JSWGlBdGxBbVBUTjhaajgwUElMU3E2U01V?=
 =?utf-8?B?YSs1UVVJbExCWG5YVlJFQk5tUXRmUzE5TGM5bzh4NHNlVkJQTFBVYmpaaHRN?=
 =?utf-8?B?VW1ZRllsWm9hc0l2Z0k4bjFWU1BhejlITlVVSWFTem9ibnZ6UUsxM2djN09K?=
 =?utf-8?B?bnF3dyt4SEx6QUgzU1V2SWFISm9kZEF1WUZXTzloOGlHZU5RTWl1cHdpRzRO?=
 =?utf-8?B?ZG41SEtrMHFENHcxamlGenNtY1ZBQ0dFeG9nR1c3dzdEUDJiQXp3ZmJJUGlD?=
 =?utf-8?B?NGNaUHEvMlJBUXdUalBpdlRiK3c3UG9YSTVKbncvN3lLZ3psUGo1VGZGRXBv?=
 =?utf-8?B?ZGloMldjakFnN2dvQTJEZUVUT3NVRS9SbzVKL25mMm01S0JYejNHRlE4bnBh?=
 =?utf-8?B?dTRUM2ZLWEpxTjNXQWt3emhJa2Vnb3RXRkw5RDlNZ1crV0ZKQzZBSnNJMW1p?=
 =?utf-8?B?Z0swVVdLd0hIMnhMeUFQeEphYStTK04rbTEydXgzVkhIMUVMWXh1UkJSa0RY?=
 =?utf-8?B?L01JQ3ErM0hZVWZJL1c5UktnMG5zRDc2WDVyU2t4SFNmKytoN2FZdEZvZ2xv?=
 =?utf-8?B?NVVzcEsxRUt4ZmViUndCNktiR3krOFZRSWRWSjA4NjVOR3c9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?STlXMDlQVEVScFMweDRaRGwxUiswUC81cGN4K2dhWjVsVkhYZUtubkgxUllr?=
 =?utf-8?B?MUVvK05NT0plc0JHSDY4WjdlYWJXQlNVUEc2dldMRmdvNGI0QVp6NW9DWUdL?=
 =?utf-8?B?TXN4elZ2YlZCY1NSNnV0OFplU1Rqd3BJR2x2NDV1NDZFTGIyK0tzV3RibjlU?=
 =?utf-8?B?dHBmbmRrdWV1NXhsaFNxaEVSZURid2Y1Q3VOYXBHbWZONGR5V1NTRXRoU3pF?=
 =?utf-8?B?YWlCMllzeERaZUFERnY2VjhNbFVtRmZrekplWHRocjUwcWZBdnVQUTgyWlhL?=
 =?utf-8?B?Z0Rwb0QwRHRrTDhmanp4dlFxZTJRbS9CMk91ZzRSamZRN2xCZTk3bnduVVRm?=
 =?utf-8?B?NjhJZGpEN1kzMGg5ZVV2WnhXS3hvM0NCeTBTc2hkdlg0TVNKcTdIbitSejc5?=
 =?utf-8?B?Q0FSOURSYkRybFVpVnc5WnVOY0pvbHMvQ0lCUi9TcWxES1hUbUV5OUFwVTVB?=
 =?utf-8?B?Y1Y1VWNQSmg5MTRucVU4N3ZoOTY3RFBQUlFoNU5XMTdPZ1RqYkNWMGRCenBQ?=
 =?utf-8?B?NndEUE96RlRVdXdBV0o4WkJ0L09ja1pYRmQrT0hCemR5K2ZwRXo4a1grTk1Y?=
 =?utf-8?B?U2c3akQvZWpFU1VYaTEvcTRaeTlUWCtXYkk3Q1JVdTROZEl1WkFnV0JDeDY4?=
 =?utf-8?B?L24wOE1uWVpiU0c0Q204NEIvSGhudTYyVTNWNVgwNkdXVmpZR0pibmpncGtL?=
 =?utf-8?B?MDdCOGp0MGR6ZDdReFdNcWRNYktWTlVsbWVVRWZJZVkxMnlGdkFzK2VIdlli?=
 =?utf-8?B?RExvRnhNYWZrT1ZSKys4MVJ6SnBJVGc3ejRSYTFLenBEcFFvWkR3MzZiVmtF?=
 =?utf-8?B?b1U0QkdqRlBZQUYrMVQ2WUttVklHeUpjWnplaFd0ZUE3eEE2TDVIV3VlTkpS?=
 =?utf-8?B?QTR1ZUF1ZXllTEFxSW1Oc1NKeU9ORVI3aTY3S2VobWk1Y2dRYjZFNkc3dzZI?=
 =?utf-8?B?TU1IbVpxTnBwb1RJbWkydDhXRUVENFR3eFJ1cjB4Zkp4U0llN2JPOVVNa1dN?=
 =?utf-8?B?SU5sTURkSWw0bEY2UnY0d1UyRnF0SVBWNzVnU2Iyd0RIRkZ0MVVlYlBDUksx?=
 =?utf-8?B?Q2ZNM3hyd0xhOTF1aGxEY1Y1bmRhaFkwWjNSdllxNWs0WmNlRGxQUElXaVNL?=
 =?utf-8?B?emx6N2JuTDh5VmIrMnZaRmRrQXA5VlkwZjV4QVcwZVo0aEladGVtcW1TZVlB?=
 =?utf-8?B?OFFlSENNOGRiTXZKUUQ4WWIyY2NBcTR1S3ZJSVRLclpJU2tEUVFzdmgrdHpK?=
 =?utf-8?B?czB2Zm9jMmk3QW5lTWlYRzNLcDAyRkZpQXpmNXZYS2JwZUpHbTdJWkV5Uk04?=
 =?utf-8?B?OVRMbWp1aUFaMEZ3YUNjWVBaSUtGek5DZlk1UmlzOW1pQm9kRVg0MEJLbHZo?=
 =?utf-8?B?Tmp0VytKNTVZV0RaMWJoMnZDQkozQU5yR0U4YmNQZVhEVm4rNGFBOUk5WjNs?=
 =?utf-8?B?TGVlcHkvTFFITDBqL29UdVJqNVZSMWYxUFAxYVdFL0VUVlJmRHJMRjlWcTFx?=
 =?utf-8?B?ZGxCRktDb0Z4Z0FSWUQ0SWdSVGc1amU1NkpFaUpSbTNNc2todUtBM2dyWkNz?=
 =?utf-8?B?bzRJS1pmYS95OG0yb2Y3eTBkUUFrU2VZNGFXbDk4MkhUWVlDNjNOZmR5RitL?=
 =?utf-8?B?SEw3TXRLYU9IK1RuemRyT0VBTWtLUjJyekJodDVWUXQ3QzdpTkhzaVREaEwy?=
 =?utf-8?B?cmlta2hnZzdhZkF3THp6Y1grdjBIeEs3OExnV3RhR1NvQTZjSEsvanJkSlZF?=
 =?utf-8?B?bUZuaWNIZ1dkNW8zWW8yNDhFalI2dHpyY3J2YXE3bEhFMmVGNTFsZVN0Wkth?=
 =?utf-8?B?RTQ1YWozRnE5ZW0rV2RNMmx2QUpnMkVVaEoxN0FESjUyVU9BVjZDOWpEaWtn?=
 =?utf-8?B?YmNtYTVQUXY5UFVHOWQ5bXFKd3FhYnl6Szk2TlJHeTNMSHFkdCtKR0NISDJV?=
 =?utf-8?B?cklQbGlTalpyZTdIQUEwa1dpdTFHNXlzZVg4bmpLZHAzNGFwS3hISHZYMXdO?=
 =?utf-8?B?QXNxSHV0NUxxSWRYcXhaZ3gvUEJTTWxhZGlQakZlM0dkNG1KbUxjTm0xeUxN?=
 =?utf-8?B?Q3dLUDZPeFFZQkc1Ym0wd0M2RCswalNKc3dsdFMvVGYyYzJaRm8rMmxiUm5J?=
 =?utf-8?B?TTNNdmgwdTM1VG5YUXdkT1M0THFBUDMzRjJIajc2dHJBZURVNzhCZUlCVUZX?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BF2E3DC6A496744A9E72D7351052797@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MKYs3jbs/7AUZgKbaQ/wcPmW1ghxo6VMkY++/AG/vwtLq21bUTP9Fg3wBvHQQ87Kog6YBkTO3Og2nY6xcwEzERcF0JBSISAfshR5REiGFGW94RvgEAoE5QVALIpagdJZirA60NtLX9ZGevd86MG9CXVvsxxO5h6bxl/j95+/58GxkB253LH0/U8Yg83SHEmlzNuy5oeHfq8eZn54Gpqv3K+zt7LVNnSy6P0EZ0kURJHGT+564WafWD0ObdQtIabaCLEgxUgcGuU9gDoiiuH0uSY3t3a94/DLla7AK6DM3V3pSgTbUICRGHo9tKfqA2/LIP83wK5dHqsZUDGCfOY6as8xpNjUcYJJKmJJCN5ITxKoBBA4OtjBpblxnmDIJ3RWglDDP8NUC9SxuZ6vHOubAJPyUZHZxl/RU+Pc6j0+q3QNqAt3ps5GeHXdoDPwQCssL94mqvz+e9up2OuwBC+jtRqnRFxBD0LTS1LsyVfaoQTslBoVjM6/P8Lm6++Cd/AzTS7AsW9LABFe6+YFSRw3XW7h8PBZVM5oFngq81j+f/ue/PB3E7kcD3tHr9eoKVZ6v+UQOvDv1KCjXYIPCFVkv51qzgvk12rsCqX+gg8QT1g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496cdfbf-6950-4248-18e0-08dc9f5c1010
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 14:41:33.4854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zr1d1uiuV+lVEwwYoP66AmnmZ4BA2jG72DaQxQcniKQJq02/8uXOl5+AJZxzzxJhpoYutWXNZE97GndCIunbfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6408
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080109
X-Proofpoint-GUID: DlJxdHQPHHJbGngV2spHXGNgLkBzaoMM
X-Proofpoint-ORIG-GUID: DlJxdHQPHHJbGngV2spHXGNgLkBzaoMM

DQoNCj4gT24gSnVsIDgsIDIwMjQsIGF0IDEyOjEw4oCvQU0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiBPbiBTdW4sIDA3IEp1bCAyMDI0LCBDaHVjayBMZXZlciBJSUkg
d3JvdGU6DQo+PiANCj4+IEJvdGggdGhlIExpbnV4IE5GUyBjbGllbnQgYW5kIHNlcnZlciBpbXBs
ZW1lbnQgUkZDIDgxNTQNCj4+IHdlbGwgZW5vdWdoIHRoYXQgdGhpcyBjb3VsZCBiZSBhbiBhbHRl
cm5hdGl2ZSBvciBldmVuIGENCj4+IGJldHRlciBzb2x1dGlvbiB0aGFuIExPQ0FMSU8uIFRoZSBz
ZXJ2ZXIgc3RvcmVzIGFuIFhGUw0KPj4gZmlsZSBzeXN0ZW0gb24gdGhlIGRldmljZXMsIGFuZCBo
YW5kcyBvdXQgbGF5b3V0cyB3aXRoDQo+PiB0aGUgZGV2aWNlIElEIGFuZCBMQkFzIG9mIHRoZSBl
eHRlbnRzIHdoZXJlIGZpbGUgY29udGVudA0KPj4gaXMgbG9jYXRlZC4NCj4+IA0KPj4gVGhlIGZs
eSBpbiB0aGlzIG9pbnRtZW50IGlzIHRoZSBuZWVkIGZvciBORlN2MyBzdXBwb3J0Lg0KPiANCj4g
QW5vdGhlciBmbHkgaW4gdGhpcyBvaW50bWVudCBpcyB0aGF0IG9ubHkgWEZTIGN1cnJlbnRseSBp
bXBsZW1lbnRzIHRoYXQNCj4gLm1hcF9ibG9ja3MgZXhwb3J0X29wZXJhdGlvbiwgc28gb25seSBp
dCBjb3VsZCBiZSB1c2VkIGFzIGEgc2VydmVyLXNpZGUNCj4gZmlsZXN5c3RlbS4NCg0KSSBhZ3Jl
ZSB0aGF0IGxpbWl0aW5nIGxvb3BiYWNrIGFjY2VsZXJhdGlvbiBvbmx5IHRvDQpYRlMgZXhwb3J0
cyBpcyBhbiBhcnRpZmljaWFsIGFuZCB1bmRlc2lyYWJsZQ0KY29uc3RyYWludC4NCg0KDQo+IE1h
eWJlIHRoYXQgd291bGQgbm90IGJlIGEgYmFycmllciB0byBNaWtlLCBidXQgaXQgZG9lcyBtYWtl
IGl0IGEgbG90DQo+IGxlc3MgaW50ZXJlc3RpbmcgdG8gbWUgKG5vdCB0aGF0IEkgaGF2ZSBhIHBh
cnRpY3VsYXIgdXNlIGNhc2UgaW4gbWluZCwNCj4gYnV0IEkganVzdCBmaW5kICJsb2NhbCBieXBh
c3MgZm9yIE5GU3Y0LjErIG9uIFhGUyIgbGVzcyBpbnRlcmVzdGluZyB0aGFuDQo+ICJsb2NhbCBi
eXBhc3MgZm9yIE5GUyBvbiBMaW51eCIpLg0KPiANCj4gQnV0IG15IGludGVyZXN0IGlzbid0IGEg
cmVxdWlyZW1lbnQgb2YgY291cnNlLg0KDQpNeSBmb2N1cyBmb3Igbm93IGlzIGVuc3VyaW5nIHRo
YXQgd2hhdGV2ZXIgaXMgbWVyZ2VkDQppbnRvIE5GU0QgY2FuIGJlIGF1ZGl0ZWQsIGluIGEgc3Ry
YWlnaHRmb3J3YXJkIGFuZA0Kcmlnb3JvdXMgd2F5LCB0byBnaXZlIHVzIGNvbmZpZGVuY2UgdGhh
dCBpdCBpcyBzZWN1cmUNCmFuZCByZXNwZWN0cyB0aGUgZXhpc3RpbmcgcG9saWNpZXMgYW5kIGJv
dW5kYXJpZXMgdGhhdA0KYXJlIGNvbmZpZ3VyZWQgdmlhIGV4cG9ydCBhdXRob3JpemF0aW9uIGFu
ZCBsb2NhbA0KbmFtZXNwYWNlIHNldHRpbmdzLg0KDQpUaGUgcE5GUy1iYXNlZCBhcHByb2FjaGVz
IGhhdmUgdGhlIGFkdmFudGFnZSB0aGF0IGEgbG90DQpvZiB0aGF0IGF1ZGl0aW5nIGhhcyBhbHJl
YWR5IGJlZW4gZG9uZSwgYW5kIGJ5IGEgd2lkZXINCnNldCBvZiByZXZpZXdlcnMgdGhhbiBqdXN0
IHRoZSBMaW51eCBjb21tdW5pdHkuIFRoYXQncw0KbXkgb25seSBpbnRlcmVzdCBpbiBwb3NzaWJs
eSBleGNsdWRpbmcgTkZTdjM7IEkgaGF2ZSBubw0Kb3RoZXIgcXVpYmJsZSB3aXRoIHRoZSBoaWdo
LWxldmVsIGdvYWwgb2Ygc3VwcG9ydGluZw0KTkZTdjMgZm9yIGxvb3BiYWNrIGFjY2VsZXJhdGlv
bi4NCg0KVGhhbmtzIGV2ZXJ5b25lIGZvciBhIHNwaXJpdGVkIGFuZCBmcmFuayBkaXNjdXNzaW9u
Lg0KDQoNCj4+IEluIGFuIGVhcmxpZXIgZW1haWwgTWlrZSBtZW50aW9uZWQgdGhhdCBIYW1tZXJz
cGFjZSBpc24ndA0KPj4gaW50ZXJlc3RlZCBpbiBwcm92aWRpbmcgYSBjZW50cmFsbHkgbWFuYWdl
ZCBkaXJlY3Rvcnkgb2YNCj4+IGJsb2NrIGRldmljZXMgdGhhdCBjb3VsZCBiZSB1dGlsaXplZCBi
eSB0aGUgTURTIHRvIHNpbXBseQ0KPj4gaW5mb3JtIHRoZSBjbGllbnQgb2YgbG9jYWwgZGV2aWNl
cy4gSSBkb24ndCB0aGluayB0aGF0J3MNCj4+IHRoZSBvbmx5IHBvc3NpYmxlIHNvbHV0aW9uIGZv
ciBkaXNjb3ZlcmluZyB0aGUgbG9jYWxpdHkgb2YNCj4+IHN0b3JhZ2UgZGV2aWNlcy4NCj4gDQo+
IENvdWxkIHlvdSBza2V0Y2ggb3V0IGFuIGFsdGVybmF0ZSBzb2x1dGlvbiBzbyB0aGF0IGl0IGNh
biBiZSBhc3Nlc3NlZA0KPiBvYmplY3RpdmVseT8NCg0KSSdsbCBnaXZlIGl0IHNvbWUgdGhvdWdo
dC4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

