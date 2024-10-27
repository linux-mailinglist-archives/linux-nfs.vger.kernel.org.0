Return-Path: <linux-nfs+bounces-7515-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D3C9B1F06
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Oct 2024 16:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759CF1F2116A
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Oct 2024 15:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C12978C9D;
	Sun, 27 Oct 2024 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XMoXz6d5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yxj8p5GU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B587C13B
	for <linux-nfs@vger.kernel.org>; Sun, 27 Oct 2024 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730041354; cv=fail; b=bsF3+PB1/6mSrun2bQBY59TJbdL7yQAMA9JeruocHzeYM/07r7JrTHI9jfbvmAFHUt8Qa8N8dkMOgRVqjw7mZMIp2fWOlHWa+Yra7UPKAFhpN7gVYeKkrDD1shS0Iuy4Z2ncFxTYXqxuhBj1eCB9NTonKC69FEZD6KBdEfk50D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730041354; c=relaxed/simple;
	bh=MMQLTZPeC3ZObPBLTW2MEKeKoTwCrHN7VOBhTEl+2R4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TtQIxVRXxX79QFfK8DuuAUaaxZoihjAYxT8F5fUMPiuY9J8zLZ4vxIqIE89lI/kw/3bA9n0IryJJNjUlAT5MANVlbwXbmpjk9FZmFiKwYXCTBCWkKyW/5n6sSby4lzNbQEE7FOsnw7JVvhGMQHu2pw68ErLDfUtkSiCfssufRng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XMoXz6d5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yxj8p5GU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49R4ESU0011884;
	Sun, 27 Oct 2024 15:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MMQLTZPeC3ZObPBLTW2MEKeKoTwCrHN7VOBhTEl+2R4=; b=
	XMoXz6d5Wb5uDfke3MWCiKQy48ktue40QG+X47pZ4R7R9K6GLVe0KSlw38WOhtzf
	qaRUU84eaIs6C/3pDo+dCGrdGha+8vGJ3itCB8sWno4z7fH+GXv17R1Tu/oWPQ+F
	XtMoMTlWvchERgjogTdJZvW8jYJeYe0Dn9g9RmIFpBJRMutYQAo3+uNOwQT2yPBP
	+RGUipKiJ9AOr1qL4tuO3JsHyRtZCQLNmQpjJDvz6RbgGHmmv7zA+pu0XSbxQ0KK
	aC2dULa0bmtUNEoHyJqyBwNdeI6NeChc0VePsSrtzSD4dkDJ/qEF4pcKtgcKXoXV
	IHe8W1tDtuj7jihgqb3f2Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdp1cg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Oct 2024 15:02:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49RCBa4U011917;
	Sun, 27 Oct 2024 15:02:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hna9tdby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Oct 2024 15:02:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhsZ49S82To3veJ83Edngcwkqa6qgmWbalM/YLcIZJ+ACb0R7zdMhh6uEX5ALeIbPgUMEqYQOf/+4DYbyiA2krPUUMPV5dSifGxYF1MbsySPAesYJqjwCXplPS6HYFNL9csMfWxEkayZV/kudcd26tYzR9PUdA5O8QKqXePvdewEV5Kkh82pWnT6Um+EKqkzyljr0rhRRcoFAIxOwD9dZXsu59pAiT+BTmKDxxOQ3Z0YtXx8Ux9/oFN+qcf5IrFSG9lDAeDeJyDf0VYdL/9TxcROJoo/bbQROFs4Bng5PjqMMB25vkGhXVdHMY/hv30ZzAhFSTet/EATAU8Tp2sFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMQLTZPeC3ZObPBLTW2MEKeKoTwCrHN7VOBhTEl+2R4=;
 b=N0BNuaFv4bqXcXxb0a7dEJ6Ocu+Jt0+HOgEcZ5rXmkzlPWiD6gqQQa6RIDrWTbnz/6gpZ6/l3oLxtQFhR8zyJEVNSnkQEa/l7liv2MzcOfdDEDu7jZfzikCy9+D0XQTmgTwFzoC4X3/h3QfwPQVDLne9PwuWVi55uTA7dzLT9X+X6fb0XV9b4dpHGguhiIYj8maIsSo1be7pHhCjlC1cXN1CgfgruSgHd5gyuTZAZlHZbHZEcpicNEgqjF0/C8HvXmfU3fhIJ0uHd6QuveaKJwMrs2bTI9VpVri6yhzVhxyGFAVZ7fQqZps92z4G7I1u8EGC6B5XgEDtsturkCGgfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMQLTZPeC3ZObPBLTW2MEKeKoTwCrHN7VOBhTEl+2R4=;
 b=yxj8p5GUBVEpkgHNjGpsuA5UNCx3hdY1loYWnN/3VwqxZeSOPX5mZ3c6MZgVhiEZwKKvKeQECpWFkMmkS95Bq2JAtRrXyZYGfU6CbTz8dMcV37Afpf0KQftnXO9eR/eM4uB2HKHFaRWAsYOLcuCa/tLd+8J1TxFWVRIrpqOzu1Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6226.namprd10.prod.outlook.com (2603:10b6:510:1f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Sun, 27 Oct
 2024 15:02:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8093.024; Sun, 27 Oct 2024
 15:02:26 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Rick Macklem <rick.macklem@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: posting POSIX draft ACL patches
Thread-Topic: posting POSIX draft ACL patches
Thread-Index: AQHbJy/nx1Qi+Q5QsEWJRnYY3dKpK7KatAuA
Date: Sun, 27 Oct 2024 15:02:26 +0000
Message-ID: <FF23731E-7672-4933-8261-04EA2E6B488E@oracle.com>
References:
 <CAM5tNy4RY-vMZU5zP=-X4F9ahPYHbAAyLkWKBbJc01jB_LD2jA@mail.gmail.com>
In-Reply-To:
 <CAM5tNy4RY-vMZU5zP=-X4F9ahPYHbAAyLkWKBbJc01jB_LD2jA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6226:EE_
x-ms-office365-filtering-correlation-id: 66cae61b-9003-4f05-a5ca-08dcf6985e8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TGFTRUptT2wrSHJITTRqVFl0d1BiK3AvamZ0ODJGRnAxVnpIalVnNnE4TFhJ?=
 =?utf-8?B?NHdJRlRkUWVPM3JnRVhBam1ic3UrRXRFQWFXR2hqK1RTMWh1dGx5czRHb3E1?=
 =?utf-8?B?OHltWFhEWUN0dGdTNVBwVlcyTXE1emdWQm55elFYU0hsNnh5UE1ncXJRVkhn?=
 =?utf-8?B?ZTVhbmdEVFRCcGFsemlneWY4M3A2VmFBdnNUUytnUzFybW5RNXFpSERlMU9G?=
 =?utf-8?B?eC8xMW5kVU1KYXRyTSs2TFdDYnZHSXVxU1c0RUIrdkREWHlmNHVhNlZ6U1Vp?=
 =?utf-8?B?YkRNY0dhQUYvMXRXMklrNVE2dnRyZGVJM2s2bGU0TlRBakE1RVZuREo5ajBz?=
 =?utf-8?B?MkNJZS9tS0Q3SGhiVVVLTU4wczRwVzdoUXJoMmV5ajhIQ05uWnBpSGdSM0Zx?=
 =?utf-8?B?YTlpa0hKVGpQZjkrYzd5L1VzQmladWcxSmloK1pyOUsvSmhuWEZJamMrNnBC?=
 =?utf-8?B?NStqenplZTRnM3pYajAwc1Y1TXJ4Y2VzZlhueTBDTTZxYU5OOHJ5QWVKd2Fu?=
 =?utf-8?B?LzVxYm9QWDluTVZ6OGhHZEJJYVJCSkIwRWNMR1pRSC9BWG44dmJ6RVJka1R5?=
 =?utf-8?B?NEJQQ3dLcWFnNUZHN055WW1PR2gwblVLSm5pRVRrUXdPTStIcXk4Unl2NU9P?=
 =?utf-8?B?dUN3VHFZeThCL25VM0VZbHZRYXB4RW8yTjQvZGdXZVBNdFFBdHd4NHhOT2hB?=
 =?utf-8?B?N0xWVmRrV2xhL2NVNDBXVTJxbEdjMU9tTHkySDdKZ2FrZVhaRzh4YnZjM1Vu?=
 =?utf-8?B?S1FIUld4b01qODZlazFadHZPN1BjQWE2NEp0aURsTzRXU1dJM283aGdRQk5D?=
 =?utf-8?B?OU5jczZNbndPeW1Vc3U3c0syZGZ2RVNTOHBIRTY5QW80VFFpTldhaUxIQTNN?=
 =?utf-8?B?S1lSNDNBTnVYd0thSkhBWjNvU1loQWdONmRnRys3RGRORkl1Q2xCZGtwc2Zs?=
 =?utf-8?B?ZmlMeVFsMVpJQnFkNlFySnF0dFZwaXFFdUlzWWpBRGZSN3J3YS80Q244VDJF?=
 =?utf-8?B?L1JqZHJwZDBmUy9WREdoRmprNWxVaUl5bGt0SDdGYURlM213d3A4emVhL0pK?=
 =?utf-8?B?N1RQdTA2R08vOVJnNjRlODMyTS9ZRmdRNW5xM1VTSU4xTUFneWtHQms2TmRS?=
 =?utf-8?B?bHZMbmJMTU5kMUlOcDluOC90MjIrNkw4TXlIQ3VTWkxoWTJXWlJXMUJCeU1Z?=
 =?utf-8?B?SWVVSWVPSG43UUJVUlZ6eXNNK2dhbXRkVnNGZXpGbFYxaXVxV0NORlZyUzhB?=
 =?utf-8?B?S1U5MlU1MUxFUmVSb1RSM1VwY1FmbE01NHNGaXAwbnpIeHovcStHOVo2OHVF?=
 =?utf-8?B?SkEvUjg0QkZvc3hFaGVtNTVtMHBtVWhvL1JqcmxLMUYxcnNSZ3A1cHMrdHo2?=
 =?utf-8?B?WEhxeGFFWVdZNUMrYzYyYUtQdmtjRUE2cWlUSVZ0aUQwOTV2dUs4cm5La0lr?=
 =?utf-8?B?MGZsR3Q3YXJQRnR2MFE1Q3h0eER4MW9ORWJxaUJxSXhXamtIaVhQaFI2NVBM?=
 =?utf-8?B?MWpmenJYb3QwcWcrZ1Rtd3BXME16WmZrcXVoZFdQQ3VOcDIybmdDMjhPRC8z?=
 =?utf-8?B?dVZWMEhPbDIyc2t5L3hFN2IxaFZrb2svU3kyQ2ZxOUZycmxnS3IrcE9WWE1B?=
 =?utf-8?B?SncwYjVDUUZXMGxSdXZPamhQd21COUN6ZW5mK0hxWDBKVWhJbnpNaWJVem5K?=
 =?utf-8?B?YTFicHh6S3F6dmZuV0hOakJkM1Zwa0xMRThkbWZhelVKSkxaUllZU0VacWpU?=
 =?utf-8?B?Q3FpTDQyZy9lRHZudWFHR0MvNzR1REVtdVNyMm05czdxcnFEeHh1WkU5S08z?=
 =?utf-8?B?ZlQ0THdINnVXVWoybWpjMW1iMUV4a1orTmw3Vys3WWdqdzFKZTUvSHFkdkQ3?=
 =?utf-8?Q?lWu5e0s4T+soK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDFyZjR3Ujh5cWVXVGlQanF0eSswbFo4YVVPdm9Zemd5YmE3TW41Tm5hQTk4?=
 =?utf-8?B?clJKRkZSVWZQei8rVnd5TEJpanFVOVlKRlRpL3RZWGdJdlU5SnhuRHlnN2Q0?=
 =?utf-8?B?R2JiV2Jzdlp5ejh6dW9qK3I2NXEvYzBoekJBdkFrWE5wUzBLS0RrM3hsV2NG?=
 =?utf-8?B?TzlCaVdWNDRvTkF6MGowdE1FRHFuR283RWh3VlBpTEVIaXpmKzhlbkFvdlFZ?=
 =?utf-8?B?YzNmTzNTN3NWWWlhcjJXekt2NUdFOGVIS0J6VjczeDhqci94V2dSS1NSYjZu?=
 =?utf-8?B?cmFhVkY4MEtpUkFWY3ZRQXVtNFZVZnF2MGNOV2FPS1FlaVJ0bFB0RDNjcCs3?=
 =?utf-8?B?ZWlETkdhQzZxNVQ2cFc3RmhMcFQ4N0g4eWlEYnhVbTF5QWMyUXFpUkJLSXUw?=
 =?utf-8?B?b0N5TEpaUEZTelgxVTJsSEtRRWNUS3JJejJoQlJkNTNXRS8yZDZLVW5LOFhS?=
 =?utf-8?B?Y0VJL3JRRnJFTnArU1NQVnFQQXJVMlh3dzcvR1B0WitCR3FLa0puSUFXTEl4?=
 =?utf-8?B?b3BaMU43eXllMVBRNG04WDAyelFxMEFxenVoUVI1TjZjTEJHM3VKWWdtOXcw?=
 =?utf-8?B?ZnF3YXVBdWRpM1dSdEEvMVlCWHhEdnJMUEx5NnA4dEl2aUZhV0wxREhwZ3BY?=
 =?utf-8?B?bzVEVGhwaHNsWUZDRGZJL1lrTS9laldnRkNYcmZGaFNpbEd3bklReDRzZkJm?=
 =?utf-8?B?K3pHZWRSbjNKcTNnTm5vZHlBcjU4YXRjNnRWajFEK1R0cmtlYzYxR0dOODN3?=
 =?utf-8?B?bUxFMzA0cXBpcnR5T2tMRWdQVC9qQ3Q1c0ltZzgzWmZVTFJFekpNTVFaOEZF?=
 =?utf-8?B?ZEtQWmt3K3FXbmtXbDdnb0crUWF1WStDUmF5eHV4Rlc0aVRaQWVCWXBqR0Ju?=
 =?utf-8?B?eU5ueDBleUxQNGlSVmJibUp3b3VwMEdibS9mNjZxdDNoeUh5amtzT2JUemUw?=
 =?utf-8?B?T2ozT0w0U2Y2dWRvYmo4em5pcWVLcS9LQnVacjJzMzlFVm9Fa0JMUzVwZXZS?=
 =?utf-8?B?cjkxc0hVckdwRHpyOXphVG1FTzkwY25zQ3ZWNy9YeTlRWURJb1JBelV2YlNw?=
 =?utf-8?B?K2QyOWRMRGduUTl0cW1JdjRxTFd0eGRGTkl5MTNhRnU4R3N5VWE1aCtXb2RI?=
 =?utf-8?B?T0IvMm9LQ2JqSnpMT3luMENVeFhlZjZuYWNnV200Y091SUJoMVV1aTY2Ky9Q?=
 =?utf-8?B?bTI4NXVZcnBKSFljWGRwZjQvRWNFVjZDNWE2bXVEeXVFR09LZkxWbFVrclRF?=
 =?utf-8?B?ME5rOXNDQzBYZ1VPTWtxVGFHUFpZcURBYjhBMDFLNTY2eWFNTWdoZUpFRWdK?=
 =?utf-8?B?UGYzMjdrbm53MEhlY1g3RGt3QmpqVHN4WFdIbktta3BlUmFTcXF6NThmTlZS?=
 =?utf-8?B?REl4SnQ5S2E3UEdab3JidkRoOGVyelhZT0RYWHprT043WDJUUCtWRytwTU5v?=
 =?utf-8?B?c0tNTCsxS3FwN2Y2MklEVzVJZ1hJK0x0V0ZUNEY2TFR5MDU2cDhIQXZqNUxz?=
 =?utf-8?B?YTl1UDk3Qnl5Z1c3NGtzT2RlR2sxMkFvd2tBVTZiek5ONDVMdUtkanQvWUo4?=
 =?utf-8?B?dFkzU0NDRWIvaytJNHpLMGQ2Nm5aK2J4NHVUYkNpZ2YyZ3UwVFFlSjZjWUdE?=
 =?utf-8?B?aU9SS1dlKzNjR2I4YmZrb1FYeWRja2puTWdaV2VWQUlXRS83clYyYURXN1h4?=
 =?utf-8?B?K3JlK29RK1lzaElUTTVPdFRIc1JlMlpWSC8yMUZaNzloSWFObm9WdHVSZnhE?=
 =?utf-8?B?YmZjQ2VTMWlnUmVNdC9CbWFiRVM4bm00VjQ3Y09BWVFoQzNmd050QmIybDlO?=
 =?utf-8?B?Y29ibFZEUVJRL2FTWURLTzFBdjRHKzFoZHZrcjB2eXJtVmFySmFSV2VYbFIw?=
 =?utf-8?B?WGtjZmphTC9KUlpZN2FWSnh3UDBGZFV5dGNMSnU0WTRJNnZGQXZVb01abXk5?=
 =?utf-8?B?R2xSUmQ4TXNHQlhpOGdRODJWNWxRM3g0eTA5MlVGZ05aWGxGdEJyVEE0OW51?=
 =?utf-8?B?RG9IalMrRTZNM0VtTDhFZ0FQMmttbHhEN1V6M3BvMjBRbXNYbGp6eHpkclRY?=
 =?utf-8?B?dmtmZUFaU1JqeXQzcXVMYmdQQ1RzVWpkU0J6TVJQREJzOGZ5L3QrOGdiSFRZ?=
 =?utf-8?B?UkR2NEQxakd4RS92YXlnN1lYTS84Q3pUcE9EMXYvSy9YY2ZreDBEYjgyWkZn?=
 =?utf-8?B?RHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BCF8A4CD9A55D45A3E115336210BB34@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QQgpHKoFwro74nIzczp12LjU+x6fRGWPcXFcMZVsehnt+LTshW001t7QW8fMo7M0Vjb+q7ofSH4M6YRm4sanxfBXero0dE18QatMXiuQ1RlRRNIEO3pq37hZRJ0N+EeuzGi6tPoSaEPe6UQ8yLnarRWyLBMQcKVbPh072uz/epddlV7uMqhNzBV7crDzQ96HlAYxfthUZtIjtTjYxkb8XPlVA4BcPkxGqT+l5NneyNIfNwpjd6ZG1jKBVnRxwvejHwNwziKueV6NFCr36mRByrFofEJJat1V4AFv3eOU3IQUOCdWq7IKxPjruf7ALmftOX8o/x1V7tNo/f29alkjg8qXxiRFTKdFiED1cNcIylddDpi8qS8ug1Ui6B+Ec/D+ChJS/qBuSplbko+jibUMZrB+hqPr3mkNYMPFjKAGunptioYkIWEzaumuR6pOMGuroxv+Q26sL82p1J+Zy4s2IjlIU+B1cbZLENEXKYfbEmOi/RF1FNLw1gMooRK69UHXGMwfFNOV/SuerdSutACek/4fWApRTiyzADGmBzmf1Xhnr2dtanDszlgG11uCyqHD7zjUzvJ1qoqVIY6SMByyjK2c8HhscjZSFLjln7uhWno=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cae61b-9003-4f05-a5ca-08dcf6985e8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2024 15:02:26.1002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H5SkkHoCeWUiP/gb7U1HGzxDUNztyrI6FKGFFqKN96j4VdOXKp+ElJFoLsXEQQO/VP4/+jeVClLEvGFDWLFAlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-27_02,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410270131
X-Proofpoint-ORIG-GUID: pveRRHvcLYobu1BkahSAvo1DWrLCjP-d
X-Proofpoint-GUID: pveRRHvcLYobu1BkahSAvo1DWrLCjP-d

DQoNCj4gT24gT2N0IDI1LCAyMDI0LCBhdCA2OjQ34oCvUE0sIFJpY2sgTWFja2xlbSA8cmljay5t
YWNrbGVtQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBTbywgSSd2ZSBmaW5hbGx5IGZpZ3VyZWQg
b3V0IGhvdyB0byB1c2UgZ2l0IGZvcm1hdC1wYXRjaC4gSXQgdG9vaw0KPiBtZSBhIGxvdCBvZiB0
cmllcyBiZWZvcmUgSSBkaXNjb3ZlcmVkIGFsbCB5b3UgZG8gaXMgc3BlY2lmeSAibWFzdGVyLi4i
DQo+IHRvIG1ha2UgaXQgd29yay4gKEkgc3RpbGwgaGF2ZW4ndCB0cmllZCB0byBlbWFpbCB0aGVt
IHZpYSBnbWFpbCwgYnV0DQo+IEkndmUgZm91bmQgdGhlIGRvYyBmb3IgdGhhdC4pDQo+IA0KPiBB
dCB0aGlzIHBvaW50LCB0aGUgcGF0Y2hlcyBhcmUgc3RpbGwgaW4gbmVlZCBvZiB0ZXN0aW5nIChJ
IGhhdmUgeWV0IHRvDQo+IHRlc3QgdGhlIG5mc2QgY2FzZSB3aGVyZSBmaWxlIG9iamVjdCBjcmVh
dGlvbiBzcGVjaWZpZXMgYSBQT1NJWCBkcmFmdA0KPiBBQ0wsIHNpbmNlIG5laXRoZXIgRnJlZUJT
RCBub3IgTGludXggY2xpZW50cyBkbyB0aGF0LikNCj4gDQo+IElzIGl0IHRpbWUgdG8gcG9zdCB0
aGUgcGF0Y2ggc2V0cyBmb3Igb3RoZXJzIHRvIHRyeSBvciBzaG91bGQgSSB3YWl0IGEgd2hpbGU/
DQoNCk15IG9ubHkgaGVzaXRhdGlvbiBpcyB0aGF0IHRoZSBkcmFmdCBoYXNuJ3QgZ29uZSB0aHJv
dWdoIFdHTEMNCnlldC4gVGhlIHByb2JhYmlsaXR5IG9mIGNoYW5nZXMgdG8gdGhlIHdpcmUgcHJv
dG9jb2wgZGVjcmVhc2UNCm92ZXIgdGltZSwgYnV0IGFmdGVyIFdHTEMsIHdlIGNhbiBiZSBwcmV0
dHkgY2VydGFpbiB0aGF0DQp0aGUgcHJvdG9jb2wgaXMgc3RhYmxlIGFuZCB3b24ndCBnZXQgYW55
IGZ1cnRoZXIgY2hhbmdlcw0KdGhhdCBtaWdodCByaXNrIGludGVyb3BlcmFiaWxpdHkuIFRoZSBj
bGllbnQgZm9sa3MgbWlnaHQgYmUNCk9LIHdpdGgganVzdCBhIHBlcnNvbmFsIGRyYWZ0LCB3aGlj
aCB3ZSBoYXZlIG5vdy4NCg0KTWF5YmUgd2Ugc2hvdWxkIGNvbnNpZGVyIG1lcmdpbmcgdGhpcyB3
b3JrIG5vdyBhbmQgaGlkZSBpdA0KYmVoaW5kIGEgS2NvbmZpZyBvcHRpb24gdGhhdCBkZWZhdWx0
cyBOLiBUaGUgcmlzayB0aGVyZSBpcw0KdGhhdCBmb2xrcyBub3QgZGlyZWN0bHkgaW52b2x2ZWQg
bWlnaHQgZW5hYmxlIHRoaXMgYW55d2F5LA0KYW5kIGlmIHRoZSBwcm90b2NvbCBjaGFuZ2VzLCB3
ZSdkIGJlIHN0dWNrIGhhdmluZyB0byBzdXBwb3J0DQpvbmUgb3IgbW9yZSBwcmUtc3RhbmRhcmQg
dmVyc2lvbnMuIE9wZW5pbmcgdGhlIGZsb29yIGZvcg0KY29tbWVudHMuDQoNCkZvciBub3csIHVz
dWFsbHkgdGhlIGRldmVsb3BlciBjYW4gbWFpbnRhaW4gYSBwdWJsaWMgZ2l0IHJlcG8NCnRoYXQg
Y29udGFpbnMgdGhlaXIgcGF0Y2hlcyBzbyB0aGF0IG90aGVycyBjYW4gcHVsbCB0aGVtIGZvcg0K
dGVzdGluZy4gWW91IGFyZSBmcmVlIHRvIGNvbnRpbnVlIHBvc3RpbmcgbmV3IHZlcnNpb25zIG9m
DQp0aGUgc2VyaWVzICh3aXRoIGEgY292ZXIgbGV0dGVyIHRoYXQgY29udGFpbnMgYSBjaGFuZ2Ug
bG9nKS4NCg0KV2UgcHJvYmFibHkgd2FudCB0byBzZWUgc29tZSB1bml0IHRlc3RpbmcgKGllLCBw
eW5mcykgYnV0DQp0aGF0IGNhbiBiZSBkZXZlbG9wZWQgc2VwYXJhdGVseS4NCg0KDQo+IEEgY291
cGxlIG9mIHF1ZXN0aW9ucy4uLg0KPiBUaGUgcGF0Y2hlcyBjdXJyZW50bHkgaGF2ZSBhIGxvdCBv
ZiBkcHJpbnRrKClzIEkgdXNlZCBmb3IgdGVzdGluZy4NCj4gU2hvdWxkIHRob3NlIGJlIHJlbW92
ZWQgYmVmb3JlIHBvc3Rpbmcgb3IgbGVmdCBpbiBmb3Igbm93Pw0KDQpUaGUgdXN1YWwgcG9saWN5
IG9uIHRoZSBzZXJ2ZXIgaXMgdGhhdCBkcHJpbnRrKClzIHRoYXQgd2VyZQ0KdXNlZCBmb3IgZGV2
ZWxvcG1lbnQgYnV0IGhhdmUgbm8gZGlhZ25vc3RpYyB2YWx1ZSBmb3IgdXNlcnMNCm9yIGFkbWlu
aXN0cmF0b3JzIHNob3VsZCBiZSByZW1vdmVkIGJlZm9yZSBtZXJnaW5nLiBXZSBhbHNvDQpkb24n
dCBsaWtlIHRvIGtlZXAgZHByaW50aygpIGNhbGwgc2l0ZXMgaW4gaG90IHBhdGhzLg0KT2JzZXJ2
YWJpbGl0eSBpbiBob3QgcGF0aHMgaXMgZG9uZSB3aXRoIHRyYWNlcG9pbnRzLCBidXQNCmlmIHlv
dSBkb24ndCB3YW50IHRvIGFkZCB0aG9zZSwganVzdCBsZWF2ZSBhIGNvbW1lbnQgd2hlcmUNCnlv
dSB0aGluayBlYWNoIHRyYWNlcG9pbnQgbWlnaHQgYmUgYmVzdCwgYW5kIHNvbWVvbmUgY2FuIGFk
ZA0KdGhlbSBsYXRlci4NCg0KDQo+IFRoZXkgYXJlIGN1cnJlbnRseSBiYXNlZCBvbiBsaW51eC02
LjExLjAtcmM2IChsaW51eC1uZXh0IG9mIGEgZmV3DQo+IHdlZWtzIGFnbykuIFdoYXQgZG8geW91
IGd1eXMgZG8gdy5yLnQuIHJlYmFzaW5nIHRoZW0/DQoNCldoZW4gdGhlc2UgYXJlIHJlYWR5IHRv
IG1lcmdlLCB0aGUgc2VyaWVzIHNob3VsZCBiZSBiYXNlZA0Kb24gbmZzZC1uZXh0IChzZXJ2ZXIg
c2lkZSkgb3IgdGhlIC1uZXh0IGJyYW5jaCBmb3IgdGhlDQpjbGllbnQgc2lkZSAoVHJvbmQgYW5k
IEFubmEgdGFrZSBldmVyeSBvdGhlciByZWxlYXNlLCBzbw0KYXNrIHdoaWNoIGlzIHByZWZlcnJl
ZCkuDQoNClB1bGwgdGhlIGJhc2UgYnJhbmNoIGludG8geW91ciByZXBvIGFuZCB1c2UgImdpdCBy
ZWJhc2UiLg0KDQoNCj4gVGhlcmUgYXJlIHRocmVlIHNldHM6IGNvbW1vbiwgY2xpZW50IGFuZCBz
ZXJ2ZXIgKGNvbW1vbiBpcw0KPiBuZWVkZWQgYnkgYm90aCB0aGUgb3RoZXJzLg0KDQpXZSdsbCBo
YXZlIHRvIGRlY2lkZSBob3cgdGhlc2Ugd2lsbCBnZXQgbWVyZ2VkLCBhcyBJDQptZW50aW9uZWQg
dG8geW91IHByZXZpb3VzbHk6IEVpdGhlciBvbmUgc2lkZSBnb2VzIGZpcnN0DQphbmQgcHVsbHMg
dGhlIGNvbW1vbiBicmFuY2gsIHRoZW4gdGhlIG90aGVyIHNpZGUNCm1lcmdlcyBsYXRlcjsgb3Ig
b25lIHNpZGUgYWdyZWVzIHRvIHB1bGwgYWxsIHRocmVlIGF0DQpvbmNlLg0KDQoNCj4gVGhlIG90
aGVyIHR3byBzZXRzIGltcGxlbWVudCBjbGllbnQgYW5kIHNlcnZlciBzaWRlIGZvciBoYW5kbGlu
Zw0KPiB0aGUgbmV3IGF0dHJpYnV0ZXMgcHJvcG9zZWQgaW4NCj4gaHR0cHM6Ly9kYXRhdHJhY2tl
ci5pZXRmLm9yZy9kb2MvZHJhZnQtcm1hY2tsZW0tbmZzdjQtcG9zaXgtYWNscy8NCj4gDQo+IFRo
YW5rcyBpbiBhZHZhbmNlIGZvciBhbnkgaGVscCwgcmljaw0KPiBwczogVGhlIHByb2JsZW0gSSB0
aG91Z2h0IEkgaGFkIHcuci50LiBzZXJ2ZXIgc2lkZSBsYXJnZSBBQ0xzIGRvZXMNCj4gICAgICBu
b3QgYXBwZWFyIHRvIGJlIGEgcHJvYmxlbS4gSXQgYWxzbyBhcHBlYXJzIHRoYXQgdGhlIG5mc2Qg
YWx3YXlzDQo+ICAgICAgIHNldHMgdXAgYSBzY3JhdGNoIGJ1ZmZlciwgc28gdGhlIHNlcnZlciBj
b2RlIGRvZXNuJ3QgZG8gdGhhdCwgZWl0aGVyLg0KPiANCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

