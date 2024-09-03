Return-Path: <linux-nfs+bounces-6158-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D148969F63
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2024 15:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0EF1C23BCD
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2024 13:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C73E1CA69A;
	Tue,  3 Sep 2024 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eim0r0TW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hDHOUhES"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682DB1CA682
	for <linux-nfs@vger.kernel.org>; Tue,  3 Sep 2024 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371327; cv=fail; b=f9/uNeCJrD+Uz6r0YaXTl1llNU0NDagn/wkQAtAaos1KJp0o8snd5/AhID5t4DBkn0tJ3EUIAhqPDGjcyqgjuevjYaY2DiSv2oumAkpg7kfDxxSgpWJbeu2uiGDM9mL1CzQfNwTk6W6kzNF9Yb8Cmg0Q1RpatOQdC/+HcLn/ktk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371327; c=relaxed/simple;
	bh=XnlcyU+CCpmgI9zE6lVG1UCSzN2UvebbH4yA1mLhBSY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vD94tL9EgzpIUMgnZC5ZfDsF4pzcRQe7s1szpRoI3EWmxdfIAEtGSjuQTFbh47jcOvOSXuEzBhJRj6w49Chb7Kvlf5umkEr9VYjUixzvGQU29eIrrpmo0qDZOfZfVSXglcGU0RGwmSR+uDuPfUFngLGMW1DJspkfNcTsWlOXAuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eim0r0TW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hDHOUhES; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4837fjcI026927;
	Tue, 3 Sep 2024 13:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=XnlcyU+CCpmgI9zE6lVG1UCSzN2UvebbH4yA1mLhB
	SY=; b=eim0r0TWkYi8xz44swl9hzkw0AX/3NkvQXErtmGhyX3VqzjNdCpdyIPP6
	LRHbG59eg5xxPD+UNz7wxtqOur4H5xoUoPc78Q72t99779xiELdAmYzbuFnfZWLA
	1Mr6VHD4dAF0WLIm3c2o5konO0z9QkLqtazIn9D5fb7lRUzUdRQl+fHeJMUohyyu
	zAcIEf9SSkBQ03poo/nV2CJHWRgbrWMzrO50lq06GoUhzDxLK9wOrOnB7rUErT7d
	2ry4ca9kKEzw8vsVQTLf1aXdmaV1in1zsC2aXlAre7+opZNwVA5euREgWKZ36/h7
	nHvAv0MOekBWhjSQLtSAylb7hu85g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dr0js7wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 13:48:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483Cb46n039591;
	Tue, 3 Sep 2024 13:48:27 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm8r49q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 13:48:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDiVQy/+1ApNTAQ2TSBRbPrgf6b4iuJjzlD4ZeoFqZSV2Qdut9CN5r3GjDO51K96jdrz4tTxKu8Vk2wGWwU1gp/09kkdTBdDJS7i9q2O6RhfvXTH9gWIxQG7ck5SaJIVqdB4XYlwbF6oa+p+QLLVVo+JW8DUBnljeozt6YzybN9XH7dYBWPhDBlpSg9wb6pYW5cwRxdA4c5pN3zXXVKw/odXUrtEix6v6j2iYfmxufLnkFZi+n1xu69apF8BpRkEqayY5R8pUWHHgJuSDOhyM8rUe5kn3q4hp+d7rltSQJghhQo+qKQ4vOjwbplhizY9VC3JFN5zePtaINwKdyey2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnlcyU+CCpmgI9zE6lVG1UCSzN2UvebbH4yA1mLhBSY=;
 b=vKxOuRNQqIe0qwEV5mv5exWwCd1QAR64rtzMPfrevW9ygJhamExRG2kYdodlvKzbcCKoL7unQBTErM+O/znsMYmGSu1efJsdk32figWac3dd8nqC8WoU66Dsa1hMf/54JEXD5LzSH2yBV0CRdVSBRyhdgYKWw7+EZ+cBJQHUSvld2FLsXnwmQ74BPA2VX7vB+Wqkb/PkWFa+sa6SbUbu5/2eWbnLIn9f2X5HQObY47gI0EsehNjQlKSuCb0GsPk+mFJC0sY0IvLoTRWjKrOMzD7MTRRJk8viAEcF7YzzkGposeU3D9/vS64jxA5n0PWhV7zu2wscmxmp+wYDQ/iJag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnlcyU+CCpmgI9zE6lVG1UCSzN2UvebbH4yA1mLhBSY=;
 b=hDHOUhESrB7ss37Z1G9aXi9jzU5kh8lhC4SYaddTErAaEDtq97tCOHfkcry5Mc+WtZiErZ8lb/JtZZBthLre/R4RnlTA49IBlkSgb8B6Paw8U8nz8md6b6mSnbLZDTOyT+2kkI7+Ipwv+pMOfFqhUxfKpQqKpdioKseXA0nsaOQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB6400.namprd10.prod.outlook.com (2603:10b6:a03:44c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Tue, 3 Sep
 2024 13:48:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.007; Tue, 3 Sep 2024
 13:48:17 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
CC: Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust
	<trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing
 List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH] NFS: Fix missing files in `ls` command output
Thread-Topic: [RFC PATCH] NFS: Fix missing files in `ls` command output
Thread-Index:
 AQHa+fQMSvU+UHZs70qpZfYWU/bmYbI+LmEAgAADAYCAAFSfgIAF4bKAgABvwQCAAURyAA==
Date: Tue, 3 Sep 2024 13:48:17 +0000
Message-ID: <CDE053B3-0BCC-4447-86A6-EFE97AB84209@oracle.com>
References: <20240829091340.2043-1-laoar.shao@gmail.com>
 <D27B60B1-E44E-4A89-BB2E-EF01526CB432@redhat.com>
 <CALOAHbDuThEW=osQudcxGQtFQqePaHzbG3MJyzGi=fLGbUqmKg@mail.gmail.com>
 <6B62A228-6C9C-4CDD-8334-E26C11DB51A1@redhat.com>
 <CALOAHbD0vhRypzEJDKJgCzYTzrhoiofzRZWF4rgr304NMXTjBw@mail.gmail.com>
 <382C8220-090F-431D-B166-24A4ED503D65@oracle.com>
In-Reply-To: <382C8220-090F-431D-B166-24A4ED503D65@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB6400:EE_
x-ms-office365-filtering-correlation-id: 10a7c1f2-203d-417e-e59b-08dccc1f106c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ajhWbEpPSTdkUEQ0QzQycmJNSFlMMVRZUHkzOXpWbU1NL3Vpa1BYSWFUaytT?=
 =?utf-8?B?RXJZbEsyWHBsdUw3alVMbnhIcHZmWDhHSm9Cb2ZXWUg2dHJReXRYclo5QlZm?=
 =?utf-8?B?eVBVV04yNC95VnVLYmgrMHg4Z1o0dVlsMjdVQW5MaWgzb2tuNStmWGdpM3lI?=
 =?utf-8?B?Y3BIcmlYa3RRMW5PSXZjTHh2MlMwK0xzaGxORHg5cjd3SjkrMW1XV3hsRG9k?=
 =?utf-8?B?YW1sTmkrc2JFWnZvc3BaaUZGNHVNdGJHS2pXVzA3d2JkYWF5eUhoaUFxdXo1?=
 =?utf-8?B?dFM2dHFpZEdFakRyNC9FMmR4Nno5OEJVRTFUM0tIWDM1WmxwNVp4aFIzUjMz?=
 =?utf-8?B?MnpGTTZ6aVNVSFRCcVRuU0JnVDRaY1oveVpCSC9DSlY4ZGZRM3lPbVZuSmVT?=
 =?utf-8?B?T1Fvd0R1V3FUdWZ6bGZaZThPcjhXdkt5WkJma0xWdk56eEJwS0dRWTRzYVFj?=
 =?utf-8?B?MlNtVHNaZXJpN1hydjNnWjl4UDlTOThNayt1L3FKTk5FcDc0b3VzVGVkK09C?=
 =?utf-8?B?QVMzM3B6bHBvNVphMUNvLzd6NmV0Y3UveGpXVVJwRHZCcmxrL1ByOEFMTmRt?=
 =?utf-8?B?R0pEM1VkcjJvTU11RGRkS1RYWkg1dGhEbmk1MnhGRWVoVk9pQjhVeGhmL2gy?=
 =?utf-8?B?aVNoeFZLS2MzSE1kWTZia0xaUnp1T0xjWUZ1OFBHV2FVeEgreCsrdVV4RmtP?=
 =?utf-8?B?Ri9YUmpkcVdGVmpqUDQvNm45cjFOZVREbEVRUU5lRnIzVUV2NFlxVjUxOTdD?=
 =?utf-8?B?Y3JNbURnWFQ0aTRTUnpKa3FobThsZEdQUzU5ekhZMXdlTDJwbElrUStLNGt1?=
 =?utf-8?B?bE5BdHFrN3NlNlNCemtsajlKcnBON0E1ek9FN092NVNSWGs0ZU8zTlBkZmNE?=
 =?utf-8?B?SCswY1VpL2h3RmlTeDErcFp3bEovcTM5ZXV5WE54bUdCM2M0Yy9QM2FidUxO?=
 =?utf-8?B?ckdsa0c4SnluWFFpZWQyTXBFYWliaFNGM3UrbFNXcUd4UC9vVjhDeWNEWHVE?=
 =?utf-8?B?NlJxbURCQlZaeWVrUWNxTTlvMkFLZHJUNFBObTNITHBPVHZWL1lzY2hKMzlX?=
 =?utf-8?B?eG16ZGtWMnRTT1orYWlqU3BpQnZsRlpUZmFRSHNJZWtqdjdFM3o5emgvQkpx?=
 =?utf-8?B?azNORmY3Q2w2Vm81MmZncXpFcVZTeEU4c2JBTHhFbG1RTG5lbXVGZUNjallZ?=
 =?utf-8?B?Qi8vQll0Sk5oOFN4RDk3RzVJbkUzTHhTbFdmL0JtY05EMzFiNEZPYU5qOXdH?=
 =?utf-8?B?ZjJqZ3QwNXYyTmUrd3lxOTduK1hnTHp5U3A1YjhBZ1UzYUxMZ1lzSVFxUm5L?=
 =?utf-8?B?K3VqcVhhVWZENTFvSFl0bk1EdUszWkZOcDZPbHdQRGRVL2NCU1g0U0VxeGI4?=
 =?utf-8?B?NWM2MytYMkxsWGlsZS9lRm14eVRaeUtuTUJ4aVA5OTNkZUNkQnpML1p4OXk1?=
 =?utf-8?B?Z0xRanUvMk1HajRselgxdG5jSkVVSEkxWUJqYVpsb09YN0kwOUFLM1Ntd29u?=
 =?utf-8?B?SitySEo3VWNyd1djTmNwV1doTldGc2NUemNpYk1KYi9LU2FrbWE2bnZDOWJX?=
 =?utf-8?B?NmlJejFZUkpkM0ZTU25qSVg4cXpzaWhoRDQwVEtwR3UzTWxlN3BEUmJFbWVi?=
 =?utf-8?B?T3dRdUpLNnRkOVdxZXkrMHdxaVRncmVhY1RscFloQnVqSTU2VnEwWG5hVGpt?=
 =?utf-8?B?bzQyZDhRbnQ0SXlNTUJLOWE2SzhRTVFCUmxyUDlQVVlYWnNhaVR5WnZDYlZB?=
 =?utf-8?B?SFl1RE5jUnpySTQ0TDRCNFl5MnZDUEhZTXlsQ1M5eTNwanNHZHlDQnF1TGpE?=
 =?utf-8?B?aEFZV2RmRWhsQ0ord2F3bUVhTTJXUDhFV3k1TU8rVy9VMzU0UENuQ3Qwalp6?=
 =?utf-8?B?Qjk2OWp6cmdkNU14KzU3QnNtWFZBQWVScVdnNFVWRGZlanc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1JxbVFTSXMxdVBYL3h2U3ZpaktrQ043MEY4ZzNOSURIc2xxZUhQUkc4M0do?=
 =?utf-8?B?SWZIWmdnWExTQ09PNHRYZHNrQXN1V2xDTDM1aHMrSEFjYjhNODNjcGpTSnJn?=
 =?utf-8?B?SmU4NHVyMGppaUYrSkNMbFFKYkJrUUorZXhnOFdtY1pkUThtZER2ZVlRTXhG?=
 =?utf-8?B?Q1ZsV3p3ZjNBUW5uWUNaeGt3ejhQdVlPZEpma0gyYW80UE1OcWhjekdpeTR5?=
 =?utf-8?B?TmZLc1VkVlhtNHNiWThqVnJIRm1vRnBxMi91SS9RMjdMSVRnOElTQUg3eWJH?=
 =?utf-8?B?MUtHZ05zamlzRk5oQkt1VjlMVXNadUp2TU5DWldmNm1IRURHY3ErV1lVR2Iy?=
 =?utf-8?B?MWJRbXRIZWJiVmtSemV1T0FuRFlqdGM4YWYxM0l2Q25VMW91cE1UcVA5U2dS?=
 =?utf-8?B?VS9SNEtKbnpINW5KMzBLWVlZU0JWWm5kbWkxY1JtSmFHY2VlblJlS1phdVlE?=
 =?utf-8?B?YkZ1amcrVXpoMXQ4dUprN29ZSTFQQkJ4U3QwUk9nNkRhQ3ZWQnJ4dk1oZnF4?=
 =?utf-8?B?RmRacllHZzFTalo1Rjcvd2g5Q0RleXRwRkNNS2kyUldkd0dPRzlKVHlTSjU1?=
 =?utf-8?B?WmFjU0FQandBSjBkbmlJbVJZNkp1UFUyZFVOeGxBeTIyY2pzYmtkQ0ZLS2R2?=
 =?utf-8?B?cjFjRGs0b2FJazh2NWNHVkVJS05oQ25ybUhUelRCNWxSYzRzZlN0Q0hFeExY?=
 =?utf-8?B?Q1p3RzZxMFlnejB1NHBOeFdWOFdIWFJQVkluckI2cEZHOWV1Y3c5cXUvNzlL?=
 =?utf-8?B?R2Uxb3BRQi9aMWNJWWdPTEdYem5SUkNhNjFaQXNqdi9aN0tqSUhVVCtKWDBq?=
 =?utf-8?B?M0tmUkNYYkdqTWVSWWFTalE0RkRsb2hQSTBjNnpHTFNoaUNZUlpXNGkxQ3hl?=
 =?utf-8?B?Si9tUU1LSHhCdHd1eW5FWWg3R0hpUTFUOFdMOGZEM1hXMlF1WkF6UHpWN1dx?=
 =?utf-8?B?c2VNZkhSSXpwTy85QVk3Z3pzUExTYTBPSTZaeHRGanRmZitoWCszdWRsMGdS?=
 =?utf-8?B?UWZwMndVY3AyYnNPYWVEWmtObm1RU3ZzZnkvM3pxSE5NK0VaOXBLSHdRUHUv?=
 =?utf-8?B?bkpjaWpiTHB0UHlrTnpPZmpxVkFhSm1aWW11Z2lXam5UTWZSNmkvemlRV1cr?=
 =?utf-8?B?NFdhb2pvUEZhTWN4Wlh5ZHMyMTlIdG8rSUQxMmVoZWtFYWZEa0YxRFVRdElh?=
 =?utf-8?B?K2NIL3pWNXRlL1Z6bVdrMThIMEFqRFFsaXlKU2tqNEZScktOU2REdm9VNVJZ?=
 =?utf-8?B?elErMVVIcXN3QXRsekp3a1g3TnV2YmF3RjBIYkl6WG5pdmZFUUpseGdlSHNS?=
 =?utf-8?B?MkJIWG1EQWNoM21tU2ZwYVdKZWhHcFg1WkdDeTM5U3o1VXpqNFE1eVBuT1BH?=
 =?utf-8?B?eFlXUUN5dmlQSXVhbHl3U2s5NXlWTzNTa01JQXdjclNFcSt5SmEzQ2YrUG1U?=
 =?utf-8?B?Sm9MU1F1QWdXa3RJV3U3M1Yxa0E1MWhDU3ZUZUM3VmdGSkE0OWtIenNsckZE?=
 =?utf-8?B?NVRXKzV5bVFBZm90aGF5cXBDeXlLRjdpMlN0REdVZ0Uza2lLR2huMTNtTm96?=
 =?utf-8?B?Mk1qYk9rRHZDRFZxTlRHRzAxTFJ4M29QZHRDMVFaRFlVdStHcDNBV1Q1Z0t6?=
 =?utf-8?B?dlNpMDFuSDJNTjAzL0xkNThqWVdqRW5Ja2ltdWhPazBFOFhzK01aY0VvRVJw?=
 =?utf-8?B?d0NmSitlYWI3dU9kUG8yMVR2eHN5cHhaMzJnMldCWDhZMVYrUU5vdnRoZ2Ir?=
 =?utf-8?B?NW9Gd1ZlTmtzTDl3Z3ZqWThuRENkZ1p6TTdsa3lDMCtLUHpSNnQwVW9wMGxW?=
 =?utf-8?B?a2o0YU9YNWE5UXpGM3d0c2k0TUJkYWNhRGhHYWhaSDFtR1lNRGRjM3JLNnRy?=
 =?utf-8?B?bmpkcHJLQ3FNbk5zTGRMUElnL3BxUXBCbGJmTFR6dW9pMHVuV1RzWTNYK2h6?=
 =?utf-8?B?U09MOUloZmNWTHpQbWJnaGtEOUc5blQ4MmJQV3RReE5LYytUeXNSc3laV1hs?=
 =?utf-8?B?cGs3aktxOVhZd3BrVGhjZndHeFgzR3dOUVJsdTI1TVNIRllWejE0SWhVMDlz?=
 =?utf-8?B?QXY5dVNGSHFDdldGSyt4aW9CUG4wTCtucW5rNkQ5Rm81SHFBNGdqUWhTWHZH?=
 =?utf-8?B?Q0NPYTBZK3JqODh5MXEzWVRUdWlKTzl5YWRHMFNjdTl2eVgwcDhacS9lM0tQ?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22CA1E94FBF75945A2D51E662FF37E58@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CV8CARWgUvV+alJM7U2CwMH9PZOqOSo4lNHiJursNl12HJPF3cHqLuBZyqbr2Vm9VNwCXojlWzLBawYA1KKJ/G4uEe7jQdFFy8RlwUlIGDrM9I43fhJgn4rGY4zDbd/4m/dvxnEqKYhlTKhCI0/1BYtSvtw42rM6gvXoZJLzQ7n2P928HgrEoOzZtwoYvavlulmWjWP1UwvDu8u38MJk4k+J1+z+fO92ZeF7WhMAOXJgmzPoPBF7tUOzhSBdOPoJJnOH2pGvve5qnUYh6Uw3nV0jbDYXl0Y4vMFzF5Oijmiu6zlbUyVOepYQREXtu6jw9l/rhDbQDrpNihkNG1/1BHmhibTt5bz47gBLXc4XD95imCrfpjiT1Vx/3Pv7jkZSmFnnFSb5tLf3OYfbPAtoQIOedh6oO03ggwgn//80E/QpWcF/imBbHLoW7x760IDoSGwlQvtZMde67/+aIoOfEORA6hsDpmnuB1+rUdXrcjd6ytrI6aesXDQdpBpbyVarMbx1rWkUVq7KxFXg35bkgsMS+ozCuzNbTtifTcBp2v3LEmHV0OSyjM1sAv/k/UwedOfkZnBQLUOuYH0/w0wMCibkkAim0hIX/BtFAMoCEiI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a7c1f2-203d-417e-e59b-08dccc1f106c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 13:48:17.1281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZlgas1k7m7wyq8wZuISWNQmcvFmbCwww1PtWF30DQcL5xHq/XDm9MUIg0GjNFLGxHLppv1QBivDlWFzzteeAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_01,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409030112
X-Proofpoint-GUID: jYmqlZCRD1YFZd50by6RBm7Pya_o6QRK
X-Proofpoint-ORIG-GUID: jYmqlZCRD1YFZd50by6RBm7Pya_o6QRK

DQoNCj4gT24gU2VwIDIsIDIwMjQsIGF0IDI6MjfigK9QTSwgQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVj
ay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IA0KPiANCj4+IE9uIFNlcCAyLCAyMDI0
LCBhdCA3OjQ24oCvQU0sIFlhZmFuZyBTaGFvIDxsYW9hci5zaGFvQGdtYWlsLmNvbT4gd3JvdGU6
DQo+PiANCj4+IE9uIEZyaSwgQXVnIDMwLCAyMDI0IGF0IDE6NTfigK9BTSBCZW5qYW1pbiBDb2Rk
aW5ndG9uIDxiY29kZGluZ0ByZWRoYXQuY29tPiB3cm90ZToNCj4+PiANCj4+PiBPbiAyOSBBdWcg
MjAyNCwgYXQgODo1NCwgWWFmYW5nIFNoYW8gd3JvdGU6DQo+Pj4gDQo+Pj4+IE9uIFRodSwgQXVn
IDI5LCAyMDI0IGF0IDg6NDTigK9QTSBCZW5qYW1pbiBDb2RkaW5ndG9uIDxiY29kZGluZ0ByZWRo
YXQuY29tPiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gT24gMjkgQXVnIDIwMjQsIGF0IDU6MTMsIFlh
ZmFuZyBTaGFvIHdyb3RlOg0KPj4+Pj4gDQo+Pj4+Pj4gSW4gb3VyIHByb2R1Y3Rpb24gZW52aXJv
bm1lbnQsIHdlIG5vdGljZWQgdGhhdCBzb21lIGZpbGVzIGFyZSBtaXNzaW5nIHdoZW4NCj4+Pj4+
PiBydW5uaW5nIHRoZSBscyBjb21tYW5kIGluIGFuIE5GUyBkaXJlY3RvcnkuIEhvd2V2ZXIsIHdl
IGNhbiBzdGlsbA0KPj4+Pj4+IHN1Y2Nlc3NmdWxseSBjZCBpbnRvIHRoZSBtaXNzaW5nIGRpcmVj
dG9yaWVzLiBUaGlzIGlzc3VlIGNhbiBiZSBpbGx1c3RyYXRlZA0KPj4+Pj4+IGFzIGZvbGxvd3M6
DQo+Pj4+Pj4gDQo+Pj4+Pj4gJCBjZCBuZnMNCj4+Pj4+PiAkIGxzDQo+Pj4+Pj4gYSBiIGMgZSBm
ICAgICAgICAgICAgPDw8PCAnZCcgaXMgbWlzc2luZw0KPj4+Pj4+ICQgY2QgZCAgICAgICAgICAg
ICAgIDw8PDwgc3VjY2Vzcw0KPj4+Pj4+IA0KPj4+Pj4+IEkgdmVyaWZpZWQgdGhlIGlzc3VlIHdp
dGggdGhlIGxhdGVzdCB1cHN0cmVhbSBrZXJuZWwsIGFuZCBpdCBzdGlsbA0KPj4+Pj4+IHBlcnNp
c3RzLiBGdXJ0aGVyIGFuYWx5c2lzIHJldmVhbHMgdGhhdCBmaWxlcyBnbyBtaXNzaW5nIHdoZW4g
dGhlIGR0c2l6ZSBpcw0KPj4+Pj4+IGV4cGFuZGVkLiBUaGUgZGVmYXVsdCBkdHNpemUgd2FzIHJl
ZHVjZWQgZnJvbSAxTUIgdG8gNEtCIGluIGNvbW1pdA0KPj4+Pj4+IDU4MGYyMzY3MzdkMSAoIk5G
UzogQWRqdXN0IHRoZSBhbW91bnQgb2YgcmVhZGFoZWFkIHBlcmZvcm1lZCBieSBORlMgcmVhZGRp
ciIpLg0KPj4+Pj4+IEFmdGVyIHJlc3RvcmluZyB0aGUgZGVmYXVsdCBzaXplIHRvIDFNQiwgdGhl
IGlzc3VlIGRpc2FwcGVhcnMuIEkgYWxzbyB0cmllZA0KPj4+Pj4+IHNldHRpbmcgdGhlIGRlZmF1
bHQgc2l6ZSB0byA4S0IsIGFuZCB0aGUgaXNzdWUgc2ltaWxhcmx5IGRpc2FwcGVhcnMuDQo+Pj4+
Pj4gDQo+Pj4+Pj4gVXBvbiBmdXJ0aGVyIGFuYWx5c2lzLCBpdCBhcHBlYXJzIHRoYXQgdGhlcmUg
aXMgYSBiYWQgZW50cnkgYmVpbmcgZGVjb2RlZA0KPj4+Pj4+IGluIG5mc19yZWFkZGlyX2VudHJ5
X2RlY29kZSgpLiBXaGVuIGEgYmFkIGVudHJ5IGlzIGVuY291bnRlcmVkLCB0aGUNCj4+Pj4+PiBk
ZWNvZGluZyBwcm9jZXNzIGJyZWFrcyB3aXRob3V0IGhhbmRsaW5nIHRoZSBlcnJvci4gV2Ugc2hv
dWxkIHJldmVydCB0aGUNCj4+Pj4+PiBiYWQgZW50cnkgaW4gc3VjaCBjYXNlcy4gQWZ0ZXIgaW1w
bGVtZW50aW5nIHRoaXMgY2hhbmdlLCB0aGUgaXNzdWUgaXMNCj4+Pj4+PiByZXNvbHZlZC4NCj4+
Pj4+IA0KPj4+Pj4gSXQgc2VlbXMgbGlrZSB5b3UncmUgdHJ5aW5nIHRvIGhhbmRsZSBhIHNlcnZl
ciBidWcgb2Ygc29tZSBzb3J0LiAgSGF2ZSB5b3UNCj4+Pj4+IGJlZW4gYWJsZSB0byBsb29rIGF0
IGEgd2lyZSBjYXB0dXJlIHRvIGRldGVybWluZSB3aHkgdGhlcmUncyBhIGJhZCBlbnRyeT8NCj4+
Pj4gDQo+Pj4+IEkndmUgdXNlZCB0Y3BkdW1wIHRvIGFuYWx5emUgdGhlIHBhY2tldHMgYnV0IGRp
ZG4ndCBmaW5kIGFueXRoaW5nDQo+Pj4+IHN1c3BpY2lvdXMuIERvIHlvdSBoYXZlIGFueSBzdWdn
ZXN0aW9ucz8NCj4+PiANCj4+PiBJJ2QgY2hlY2sgdG8gbWFrZSBzdXJlIHRoZSBzZXJ2ZXIgaXNu
J3Qgb3ZlcnJ1bm5pbmcgdGhlIFJFQURESVIgcmVxdWVzdCdzDQo+Pj4gZGlyY291bnQgYW5kIG1h
eGNvdW50ICh0aGV5IHNob3VsZCBiZSB0aGUgc2FtZSBmb3IgdGhlIGxpbnV4IGNsaWVudCkuICBJ
Zg0KPj4+IHRoZSBzZXJ2ZXIgaXNuJ3QgZXhjZWVkaW5nIHRoZW0sIHRoZW4gdGhlcmUncyBhIGxp
a2VseSBjbGllbnQgYnVnLg0KPj4+IA0KPj4+IEJlbg0KPj4+IA0KPj4gDQo+PiBIZWxsbyBCZW4s
DQo+PiANCj4+IFVwb24gdGhvcm91Z2ggZXhhbWluYXRpb24sIHdlIGhhdmUgaWRlbnRpZmllZCB0
aGUgcm9vdCBjYXVzZSBvZiB0aGUNCj4+IGlzc3VlIHRvIGxpZSB3aXRoaW4gdGhlIE5GUyBzZXJ2
ZXIsIHNwZWNpZmljYWxseSBpdHMgYmVoYXZpb3Igb2YNCj4+IHRydW5jYXRpbmcgZmlsZSBsaXN0
aW5ncyB0byBtYXRjaCB0aGUgY2xpZW50J3MgUkVBRERJUiBSUEMgYXJncy0+c2l6ZQ0KPj4gcGFy
YW1ldGVyIHdpdGhvdXQgYXBwcm9wcmlhdGVseSBhZGp1c3RpbmcgdGhlIGNvb2tpZSB2YWx1ZS4g
QWZ0ZXINCj4+IGltcGxlbWVudGluZyBhIGZpeCBvbiB0aGUgc2VydmVyIHNpZGUsIHRoZSBpc3N1
ZSBoYXMgYmVlbiByZXNvbHZlZC4NCj4gDQo+IFBsZWFzZSBwb3N0IHlvdXIgc2VydmVyIGZpeCBv
biB0aGlzIG1haWxpbmcgbGlzdC4gVGhhbmtzIQ0KDQpJIHdhcyBhc3N1bWluZyB5b3VyIHRlc3Qg
c2VydmVyIHdhcyBMaW51eCBORlNELiBJZiBub3QsDQp0aGVuIHBsZWFzZSBpZ25vcmUgbWUhDQoN
Cg0KLS0NCkNodWNrIExldmVyDQoNCg0K

