Return-Path: <linux-nfs+bounces-3830-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C55908C32
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 15:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA961F28156
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 13:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E0A14885C;
	Fri, 14 Jun 2024 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RD/FJ4Sn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cFmVi/sN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4805A19AD45;
	Fri, 14 Jun 2024 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718370074; cv=fail; b=MX7iIvB1oq5MGOrTlmH8UrzdKTyMfOfCtDhOA0vnNo4XQdFmFfLvmMDVHu8mFHtJ0uzWnx3lX56HRwEyMGfn9zhT97gXaPB5ooR1Ohl/JvYce8NinMmwZuFKjoRE9sAvpcXAfeyNpft5iCwIiSnYQgjVIuunpP+e601RMRC7MK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718370074; c=relaxed/simple;
	bh=yB9NJzPXnjdUO6Ua6cKkOXJx4+q2CEOVmWOgPODWZro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UsM7uEtOsElENY1ka8m5vkcJlLdgD35gl+ZzonbMU/Yk2oluxXEaqlQYyeD1+LfaTg+6L/zq6KHbekLubOY5vZKSnb4ZTVQIvBIbhjGtnxf1bu8v5QLR4LzdGNJzzis+VhAmsDeIwwXzhIurVDxYJsYYup6mqUKlp90W/ilJHzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RD/FJ4Sn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cFmVi/sN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E1fXhP029892;
	Fri, 14 Jun 2024 13:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=yB9NJzPXnjdUO6Ua6cKkOXJx4+q2CEOVmWOgPODWZ
	ro=; b=RD/FJ4SnWN60w4axb6l0lQe+RwP+7V2rMf2kMPSBIdl2Ek6rextA+0gji
	TjuzGMNWVFm7HAh2ri/tEnrQasuhZ23wYp5EwpWO4M0VrzUJWwemgG+8t7x8rejY
	IJ130eNv5NnphRp9+AnoBTJFAFxoEMLTGd2DJ4/otmjU1e557K/vo489Xx0Se+Pq
	gvz1Ljz+bPlX2KfvIpO+iIRe8B4yXnP1GXg8KY4H6kyikaizOaBuO19U0SzNfDJ0
	YmpqGQF5LsClppd9y7EjNIzrUKNTBr7tQXfV4ahe3z1NO6L1I08AiwtZB9DrjVcR
	/41GDy+ICfooJ6Xru4eJroWF2hEpw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh3pbhxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 13:00:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45ECm5Xl036554;
	Fri, 14 Jun 2024 13:00:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ynce1pdmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 13:00:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oD6nWUBfZ/cWsroFugCOecgSxDiOcsIuFYuhMN9yODiYODgr7NgQMDE+vobqztOg2TYWgWFxVdnZ23l3XLgqrzGF2kAAg8vLAXlN7ofE/AM5zjxDMsViQfq5RL3oqtyyuiOAsd/JtQtUdQ3ck+/tk444NOfIBiRayvx2KNSVUggecfcI83KHPOyTqvM/G8v2pdTZ5uyq2OhHxhJS0lNfGialBAeBtVQFhQ7nZXxaKbuJ/fRrgAkp5cHrmF//axwTqSxDAt77uXejBO1RxD1JWsRxd2OzFX4Lc5svxJ1PsniTWehI1tkb1WtCWgM4irnyonWt3LQWOMp/10XVlTO+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yB9NJzPXnjdUO6Ua6cKkOXJx4+q2CEOVmWOgPODWZro=;
 b=WS4t1quF1RyxFA0GURByj+9pRe+G73TqY2NccfzlnUf5oUuiXEUvUjaF3kAnf8/b+TZa6T6GDlXrW63PVGyQKf0mH1ZcFDi7GufVTmEDu577rxDFnhWj4i1CKOJp81u2TTcs4ZkRpk0E4zmqaUG4JSHPbC7FhP+p8f3onWjcsOTzRf7HMTBtSDz0ux+P5CenfgBZz/Lp3rNrc6L7zW6ejYk72ExK8hewKVkZ2gnNFCcEdkr+Q6oNngcBhRB/sO9Ix/nTzmzrNyFsti7n7h2aETgfrt6erTty2IorTYmrmyebTbki3wH122Fwr4+d/Afl9xHlUvAOsx6tHgKAY7lB1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yB9NJzPXnjdUO6Ua6cKkOXJx4+q2CEOVmWOgPODWZro=;
 b=cFmVi/sNOpYWJVnl6VYwXgPNi+ItFOLbzkvcTpt1CXGf2IDTCz4kQ0fzulJ0Akyr1hrA0f2Gtve7WevUJKrZUYn6iWKxJ2mq5jvtPgY3e/CfjO5IoV3LTHCtDmPCMla3zdYjk/WKzkQUyax9psB+RD5rPP8fQjALE3FE2tfYgMc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA3PR10MB6972.namprd10.prod.outlook.com (2603:10b6:806:31f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 13:00:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 13:00:48 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
CC: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker
	<anna@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Olga
 Kornievskaia <kolga@netapp.com>,
        Josef Bacik <josef@toxicpanda.com>, Jeff
 Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        "liuzhengyuan@kylinos.cn"
	<liuzhengyuan@kylinos.cn>,
        "huhai@kylinos.cn" <huhai@kylinos.cn>,
        "chenxiaosong@kylinos.cn" <chenxiaosong@kylinos.cn>
Subject: Re: Question about pNFS documentation
Thread-Topic: Question about pNFS documentation
Thread-Index: AQHavW2QBBcqYXgDhEyPRodGlikhM7HF0pCAgAEevQCAAEmLgA==
Date: Fri, 14 Jun 2024 13:00:47 +0000
Message-ID: <1D4505F5-1923-4E7B-A12B-F1E05308914C@oracle.com>
References: 
 <BA2DED4720A37AFC+88e58d9e-6117-476d-8e06-1d1a62037d6d@chenxiaosong.com>
 <08BB98A6-FA14-4551-B977-8BC4029DB0E1@oracle.com>
 <93D6D58053EB522F+de1c8896-65e1-442d-99f6-c5b222c0a816@chenxiaosong.com>
In-Reply-To: 
 <93D6D58053EB522F+de1c8896-65e1-442d-99f6-c5b222c0a816@chenxiaosong.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA3PR10MB6972:EE_
x-ms-office365-filtering-correlation-id: e9670a39-ac5c-4b37-aefb-08dc8c7202be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|366013|376011|7416011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RzRSSmh6U0NpZmxrNDVJMXlOb2llMFdhNjljL0xCVVpDdTR1aytldStlNkNq?=
 =?utf-8?B?SFp3bzVWMVQ1NTY1RVlZalN3cnBDTkNLRy9lRTFrMDNDVHdQbTQxaVNrL1ll?=
 =?utf-8?B?aVY1VWpqZlg2Y1JQOENZRDlra0I5enlSamQwMlgvQ2tVemVXWTFXbWxjQ1pv?=
 =?utf-8?B?SVN4T0w5QW1RTHIrM2RtZjhoM3pVTUJvTEwxaUQ1N1BxWlA2Q0Y3Q1RLaUdJ?=
 =?utf-8?B?bFp0RHBBYWhqM0ErZjZFb1NBY0JkY1lZWVVJaEFjVnAyUWxLVm5keFczUEI4?=
 =?utf-8?B?b2MyZURici9LMytoeFQxMk5QczUzYUkrenFkZkx3T3Z0b25zdCs0bDVYT3k2?=
 =?utf-8?B?NGxjZ3FFU2hTWnVIU0NLWXBRRkZ2c1o3QjB0Q1VtaU1yQitZNms2RE52N1Vz?=
 =?utf-8?B?T3hIcGJTT3BKWEs5TFJSRWNpTXhHNkFBUEppb2d0eVlBMVJGNStNM3Vtbm9H?=
 =?utf-8?B?c0NiZ3JjemZOWWp5M2FSZm54WmlHdUltOHZvL3JEM3BIc2xicFo3K0VMaGty?=
 =?utf-8?B?R0lNRkc4ZUkwYnpQbzJrZjhjbGFsWGRoaW9SZEpGcEV1SWV6bkkxaGFlWk1o?=
 =?utf-8?B?OWFpbUFhQklTVkZqWU1PYy9DcmJzZTRaNGhlVEpzdkJrNUZuZndyL3F4V0dh?=
 =?utf-8?B?aVdQMDRaZ0NJVEFLV0RXcExnVEhrWDlkY3h4blZvTzNQTEduVFVrNlRTTG11?=
 =?utf-8?B?SHAzOU9sVnRNY1BYL3RQUXlVYmgwYlIzUEtzejdtNGlaMHpjYVdCWFIrdEoz?=
 =?utf-8?B?LzlHWXpJNDdNeFh6LzVBMDVYSkw1d1lhcytFQ1EzaUlBMnlNTFR4bWxibnFx?=
 =?utf-8?B?SktSR0RvYnJnL3V2SlZVcm9TSDlpdHNwcmR3RXpGL2ZYT0l0ckVocTdQQkxU?=
 =?utf-8?B?VnIrd3ZBNUF4VnpLZjZudE5qTmN6NUI0Ymxxcm5EQUZLQkExdHBLOFlhNThv?=
 =?utf-8?B?dXVId3ZpUkVaa1hPV1VUUmczRnJFOWNacHNoV2F1MXBVZ0tMRmxSUkJFbXRL?=
 =?utf-8?B?eXJDSE9xMVh4SGJFUlp4eDA5M2ZJTjdlbXAzOGdHNnRHT2lzUzJEbytvY2V3?=
 =?utf-8?B?bTJBSlBjRUZ2cklXczlOQWc4ZWVqNTVzcUNISUtpQjdyWDJrOUYrK2tNTTdo?=
 =?utf-8?B?WkZKOHJKY3hpcXdoYXNkVVNUeEJsdnNmc1RvcXFRQWwvMnNHTkZiaVFsMTlp?=
 =?utf-8?B?M2dtQUlwd2U2T1pRWlhvMlRhc1FLYld5OW84WStxbVNVZVNLUWg0dlNPeVd1?=
 =?utf-8?B?elpuczdrYnNJTU8wZzhRQW9JN29QMXRFVU84czl1ZWZDYUlpN2Fkb0dqYkI4?=
 =?utf-8?B?UXk1L3RnVHBYMkg0TURvRVN0NlVhNlFPRlZGanVsZ1NxOWM0VzZpZmlZcmdO?=
 =?utf-8?B?MjRiR2dNaC9KRXgxOE1BT2hkZTY0UUViYWdTUkJsNElEOVFjWjVPT2ErVkcw?=
 =?utf-8?B?cUxYYU1id2xubVhnVSt1YWZRR0JmK2VKZG11a2hOM2lmM2xSNjZFd0w4Z2lk?=
 =?utf-8?B?MklPYjJneFZUYlNPTTdzdUZwUDdIOE9IYjBKbkwwYnEvdEF3VUR2U0JiM1VH?=
 =?utf-8?B?c0FONTd3ZC80R3hZYjl0d2dHdkpQMzNuSWlEdnk4NG1CNkh0NmNRK3ZnTEFk?=
 =?utf-8?B?ZmxtanVsYkpobTlZNHc1ODhFQlorMWpOVURFQ0JxdXdZbHhzYzFhU0JoOWdY?=
 =?utf-8?B?WkhjSmpZc2FDYTdsWU83dHU5NWxnYnVxSGdwUkkxM2dKRWFaRC9WamdXbGdo?=
 =?utf-8?B?S0lta2hSd3VsajVIbHU2eEJPRkxHZjBKMnozdEpEZGpRRVN4S1d5YThaZXhD?=
 =?utf-8?Q?sBlMdAd/hrX7VwrJBATt00S4/TIoirVlFwKwQ=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?U1ZWTWxITmR4ckVBcmt0dzNqRk9NNTI4RGR0TmdySk1odG9kclppZ2V0R1cv?=
 =?utf-8?B?ZWlGQjB6YjE4VThqNk9UbnFsUU1DUTF4QWdBLzhMUG1CSVMvaklEcHoyY3Vj?=
 =?utf-8?B?d1hLTHVIRHJEQVg1dk0xZWV5SVNOaW5SQXVFMUFQUnJ2VHZwN0oxdDE4ck94?=
 =?utf-8?B?bDFJeWhNOERmMzJlTk1uTUN5YXJjclFpMVZRY1QzOVI0dWlYS3NRTm5PVU8w?=
 =?utf-8?B?dllOeUdOcmZZY2Q3UkJYSG93YnhNL0RoN2lWRkxrVGJiN29ORENjRkQ2NU5C?=
 =?utf-8?B?TUJ1UzcyakZEa05UaHFUaU00UVpGQlVkY1M1Q2ExdWFmcVpCaVpRMHVIWnNy?=
 =?utf-8?B?cmppSXNOWm1hNmFQMTBiN2F2RFlRQXkyUmp6ZGF3YzRmWE9lOWtZYTdwTC9G?=
 =?utf-8?B?dVJDaXdER25pQUthdll3U0huajdxRHFkUDZMV0JKR2I3ZGU3ZXM5NXM3OENi?=
 =?utf-8?B?aERtbXZSQzNPc1V0aE1xWG9zQ1o3OTZqQXVnZjhMMzFyRFV3NDIvU21OUHVV?=
 =?utf-8?B?Tk4ySDZWWEVLVjRYU1JHZk5zaTlPdTdzdWcwWE9Hbks0RUZ1WUlGODVrVXlq?=
 =?utf-8?B?bXYyL2w0ZXYyV3hKMUt1Slk2a1Z2V2FvUGw3TUE2UUlNOVFJZ2tWdzFFZWxW?=
 =?utf-8?B?RUhiQ0pzVS81V2Z0eUwxNk10d3B5b0tDNXNZU2x4NGZiaUJJRks4b2xadVlk?=
 =?utf-8?B?SUNIWDZiZm9qR1NsejBtOHMxY3VIeEN2V1dVb2pPQjlpaVRrZlNTYUlaTUw3?=
 =?utf-8?B?N0FrdFFMcVJodFhGc3dGZXlLTi9pMDY3U2g0N1dMdXJaaFE2blptNGhEaUJ4?=
 =?utf-8?B?ZlV3NEZFK3o0dTAxRVQ1bEF6SlNHZVI2d2kyU21Wd0doNFNXbURVUkdQeHdp?=
 =?utf-8?B?QWF3S0FIMkVudVF5dWdlRUgrVUpVVHN0SG1zNWV2TzdrNlV5bmdGZ3BacjZ4?=
 =?utf-8?B?OUdIYVRxNUlta3o2MUhDdDFDL3g3YjdMYU4wdG1vVnBENzY3ckVWZEtDWm5q?=
 =?utf-8?B?Sk5CUXdZcy9vcGxuRU9zdm9rYytRZDFKM0JyaWVidmdoQ0UzMEc2aW9kdXFR?=
 =?utf-8?B?TXNXbkNyWHZQbFFic2ZkWllWck1KNTFxdmcxWWV3TVZ0VGZzWDM2Y01rRjQw?=
 =?utf-8?B?L3hWb3Q4VWxzUjBQa1JPZy95dUt2ZUU0am4wRDdMQytiWk45eUpkZTE1MFQ1?=
 =?utf-8?B?Qm9rdUtSU0Y3RFRuNXQ3blN5WTZaN3krUU5qRzY2QnMyeG1vbFY0bjFMcFBu?=
 =?utf-8?B?THNTZEJNQ1lmY0tweUltalppeHVtcFpvRkNMVHRlOGt3V1dDNHNCQy81UHZt?=
 =?utf-8?B?UkdGYWRlaXBxaDB2SXhMdUNuWmxOcXB1M0ZjTzIxV0NMMGl0cHd1d1JCdm5O?=
 =?utf-8?B?MDZETzJjZ2lGREpWenZ5bmNtcCttYXhKK2UzckJjSXRlUVA4R2NLeGdMYUJE?=
 =?utf-8?B?QkJQMngvbmtQcXVpaXJTUHRkV3NlTW53VnlldDY1U1RGZE5BMjVsK3lsL0xS?=
 =?utf-8?B?S0tXN0p0bFNEeTJ2V1ZKQk9mVGZSblhlUGtDWE5nY1lUSXlqZWJXbm9GMTJa?=
 =?utf-8?B?M0Q5Sk45QjRDTUw5MEdmR2hhWE1jLzkzWTl2QjRHY2ROekh3d2FLeDdIOFpO?=
 =?utf-8?B?L3ptbndRamFtK09OalpOT2hBU3FlZGcrS01JS3dscVZSc20vNFl4eUw3VGIw?=
 =?utf-8?B?WkpZYzZWZzJYOUNPcmlSOFBLVndhbVBLa0E4eTQ3MVE5bkFrRFFiMGJSY2kr?=
 =?utf-8?B?Vm91ZGRXSGZjSW8wcmkxRWh3MzhkTWx4N1lQNUNvNG04R2Z3MlpQVjFUNmU4?=
 =?utf-8?B?YldPYkJnVFRQQ2dqNFJFTEtBYTVtTGVOdkNBelRUQ05sZGdoMStwemk1bzhG?=
 =?utf-8?B?aWlKTjRJcGR1V0Y5bi9mY3VlWndkZDBvbzhLMkpBRVBFbzlVUHFxd0NrY2Iw?=
 =?utf-8?B?TDRRRDEvVnk2akNsTmpuRmNFQy82WGxENms4WEFKdTN3b0p5OWloQkxHSEFG?=
 =?utf-8?B?UitWYUpHdUYrM0hGYjFwS09zdFV0ejNuSHZEOWhwODRYRHNtUkJuNjJFTFBO?=
 =?utf-8?B?Wndybkg3YXdSeHJOV0xnZUJBMU1JQUVDYnA5UHRBYVd0SzdweWVtTjljRFJr?=
 =?utf-8?B?SHVNZ0xacFZjZWY2bytXZGk5bS9ZQVVhMnp6VVQzRUt4azBtdUlDRzgybHRR?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B69BADC1E1F154C97D88FE3DEA6962A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2rR+1Q8k2LuxRNOssr2soNN4xAna4GxkcXUIABgP1sgNUahCEm6NRGh2gx/ve2DOmzO++/Lgrc+CXN/lluHWIfloKQEwdJwQUtpoPoZj+Wta3s/bKzPGUCDGp8UZdHUlhyWpNRbOalGnLKTVjeHhc++jUBRZh4WTyH41CGWA6V4BsecjBE9yi8uPGLaW0s+J1fOepdJ0Y+Yr2So1NhAgM+P1GetarL8WB/GMKNQ7ajQexc8nWSxOeQu/MNFv/LdUpyFJab6k8II4DHHEswpNPl0VoY+9/w7XpW1+VyYFsuZFyz7Nsw+tqrQhPJBW+Cw2Ki+/qfDF9Unw9GiRlzWI9/Q7xWROfixr1mt836NfMHWBvnd+c0Qg7iSOUJOg0cw3uZxjhJT/EWMTtL/ACdPn3nBLxPw/JEBMA3W5TN3oxYUrTEeEV44wzOsZHBp8/noXJA845QZWLUcGaBdBH0YBuAbrGtEIHgVvhVupH5wcKDFMB961bmREMeIUh/FeW2C0poWHmR4ZFuraRXhdrmcoNGjtuYoaJWAkOz7B2+2nXHs6VCa8sxwA+qmXrf5cFQR3xuPz3sSSrbn7yUxPzJGi27y6RGE7q6xoPXry1B6qmcI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9670a39-ac5c-4b37-aefb-08dc8c7202be
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 13:00:47.9768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9xJzmKZBuSc9O7asz5fLHM5ux05mzNAE/U/72vTsUnIrpgJEVFrtZPLLQkarYNPXxQU2HPWEiM5rnBTQ6WBeGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_10,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406140088
X-Proofpoint-GUID: iwswl6OuyRv8LLQlILy4yQp-fW2n9Ue4
X-Proofpoint-ORIG-GUID: iwswl6OuyRv8LLQlILy4yQp-fW2n9Ue4

DQo+IE9uIEp1biAxNCwgMjAyNCwgYXQgNDozN+KAr0FNLCBDaGVuWGlhb1NvbmcgPGNoZW54aWFv
c29uZ0BjaGVueGlhb3NvbmcuY29tPiB3cm90ZToNCj4gDQo+IFRoYW5rcyBmb3IgeW91ciByZXBs
eS4gQnkgdGhlIHdheSwgYXJlIHRoZXJlIGFueSBwbGFucyBmb3IgdGhlIExpbnV4IE5GUyBzZXJ2
ZXIgdG8gaW1wbGVtZW50IHRoZSBmaWxlLCBmbGV4ZmlsZSBhbmQgb2JqZWN0IGxheW91dD8NCg0K
VGhlIG9iamVjdCBsYXlvdXQgdHlwZSBoYXMgYmVlbiBkZXByZWNhdGVkLCBJSVJDLiBTdXBwb3J0
IGZvcg0KdGhhdCB0eXBlIHdhcyByZW1vdmVkIGZyb20gdGhlIExpbnV4IE5GUyBjbGllbnQgeWVh
cnMgYWdvLiBObw0Kc3VwcG9ydCBmb3IgaXQgaW4gdGhlIHNlcnZlciBpcyBwbGFubmVkLg0KDQpU
aGUgZmlsZSBsYXlvdXQgdHlwZSBnZW5lcmFsbHkgbmVlZHMgYSBjbHVzdGVyIGZpbGUgc3lzdGVt
DQpvbiB0aGUgYmFjayBlbmQuIFlvdSBjb3VsZCBidWlsZCBzb21ldGhpbmcgb3ZlciBDZXBoIG9y
DQpnZnMyLCBidXQgaXQgd291bGQgYmUgYSBzaWduaWZpY2FudCBlZmZvcnQgYW5kIHdvdWxkIG5l
ZWQNCnVzZXIgZGVtYW5kLiBDdXJyZW50bHkgdGhlcmUgaXNuJ3QgYW55Lg0KDQpUaGUgTkZTIHNl
cnZlciBoYXMgYSB0b3kgZmxleGZpbGUgbGF5b3V0IGltcGxlbWVudGF0aW9uDQp3aGljaCBpcyBu
b3QgbXVjaCBtb3JlIHRoYW4gYSBwcm9vZiBvZiBjb25jZXB0LiBXZSBkbyBoYXZlDQphbiB1bnNj
b3BlZCB0by1kbyB0byBsb29rIGF0IGJ1aWxkaW5nIHRoYXQgb3V0IHRvIHByb3ZpZGUNCmEgcGxh
dGZvcm0gZm9yIHRlc3RpbmcgdGhlIGNsaWVudCdzIGZsZXhmaWxlIHN1cHBvcnQuIFRoYXQNCmVm
Zm9ydCBpcyBub3QgYSBoaWdoIHByaW9yaXR5Lg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

