Return-Path: <linux-nfs+bounces-8566-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4336A9F2784
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 01:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657CD164DCE
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 00:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CFF4C7C;
	Mon, 16 Dec 2024 00:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="LU/hwEWe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2098.outbound.protection.outlook.com [40.107.223.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1AD4C79
	for <linux-nfs@vger.kernel.org>; Mon, 16 Dec 2024 00:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734309247; cv=fail; b=XedVlmuOkGwmHyYxItbfIhADjmc4OKls5RntIzkP+CB/8WbuIviSJzBGmM7fYGWMBDpefRYwD1ryUfMeJhqXmqcJij1liJGh9gltZJ4u+gv1NHv/CD2HM4nMDimPSsrD9BjkKSsmU7SDS9x40cMwiW1rZnh7guURQip08U5qpEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734309247; c=relaxed/simple;
	bh=CGwNy88Y+nXVLpCNmteZxoAOMW0ORGMjv+IqptrYEm8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iqtWiaC1snk7ZsorXV8dOz8ej+9YAIBq3xZRVF4ZSk6CLeZ4GY6IFn2F3nEcov6hx0XD8eTqJ0hL5sksQ6wvfF3B7ptKiPW904P6hFnNUFiL+5aLJG1ltd6q6oIy3ttkDLaRgMUr1Y8CIhsvPFzs61Q7QwMKooPBD8aEPGIa5is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=LU/hwEWe; arc=fail smtp.client-ip=40.107.223.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBwc6qOhe+mphUTdoyymHXQbtOS7PxTcdlVd6QLLN+Af6sLdueiv9zfozaEBcSLIMZ5v756MXEHT/GTBBz+EdCShZnaZk4ZxaxaB2eWgZpTiGjGvIYQ79t88uHjNI1TERIZCARcKRUzPLmp/TIpzddxoPT2lfRruHXVYjK5lGmorMpms0iavxcjtWEBL+W3pQkezxg7n5ww8l7re0oAH3s8aai60tqHLyuTPtRYqDx3FP5pDARtt2bxZaNaZ94S6YpECaG4c6apd6BOXi017dKha9VCcW30SqhzVKaiUInPQ26LUYOS4cYJHU41GVka9KE3C6VbJA7j4RUVPhYEmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGwNy88Y+nXVLpCNmteZxoAOMW0ORGMjv+IqptrYEm8=;
 b=nhGasceezfDqPG/iFXj8QFYRv1mpHFKCG//UlkqXxwduxsk3O3tjmjEBOwbnUH1uScelykpEcKtzeUZuOE5Qgzc7URbZWooVDwxoZqS3uANZeU55tkVKkvKTGc0Z40w4sf8Tb8u4PAMWUotd5wUQDmG2C+Fd5qs4/ednZELg9jPubBlnrKLtb3vgLz4E2vuV++xKW5BHJOyptrn87cKIczvHaSfy/zGQYnoQm6viklxa2L5uTP3jfHjZCJgxq+5M28kumPUwePje+tWTbpzUpw57EhVhs2XeKzZ3CZbfer9xyA4WsQv4dA4ZSlDO9zS6SMQdQ+NrRWTKN9RYz9C3zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGwNy88Y+nXVLpCNmteZxoAOMW0ORGMjv+IqptrYEm8=;
 b=LU/hwEWeHAPVkFgLJzKKS7dIuiWLb58vR+gcYkczCWYNrggRDuLdqpBMse8qYWcyZSngyiRxWFovf2KNxb45XywFsztbncKZltPAPJ1ByC/LI9IuhLysjzBbefA9m/U52+YnBS+5Y1FtSTaMYxqEPSe95LO5+embzXk5ER8gxOA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BL0PR13MB4417.namprd13.prod.outlook.com (2603:10b6:208:1c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 00:34:03 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 00:34:02 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "Rik.Theys@esat.kuleuven.be" <Rik.Theys@esat.kuleuven.be>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: non-stop kworker NFS/RPC write traffic even after unmount
Thread-Topic: non-stop kworker NFS/RPC write traffic even after unmount
Thread-Index: AQHbTu9hnNWY8LwHaEGn2XTEUzAkb7LoBoiA
Date: Mon, 16 Dec 2024 00:34:02 +0000
Message-ID: <87314e6d09a96a5cffc13dd1b9cb94da7d94e376.camel@hammerspace.com>
References: <79767ded-466f-44a5-b15a-fde5af1b03c7@esat.kuleuven.be>
In-Reply-To: <79767ded-466f-44a5-b15a-fde5af1b03c7@esat.kuleuven.be>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BL0PR13MB4417:EE_
x-ms-office365-filtering-correlation-id: be102a9f-43c1-429b-9b3e-08dd1d695727
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M0ZPeWcxR1RJT3dCcDFhOFpWdndQYVhkOS92YTBFWjFpeVh1Z3FuWEZIM1FZ?=
 =?utf-8?B?UXJTZC9naWlkWlBsQ0dvN3VzZ2o3RTY4NnErVkJ1eEl2R3o2Q2lMOGNFWE1w?=
 =?utf-8?B?ajdiS2k1aktHSnVkTHVmdkRXWGI0NkRUNm9wWDZtSTBEY2ROTmQ4b1I0WkVy?=
 =?utf-8?B?NmE2dk5tdWN3MVdtL0I5OXI1d0k0Q25ucWdLSG52NkZnaiswb1BJc0JrYXhx?=
 =?utf-8?B?cnJ4TURzUTMyNThJQmQ1cmZKMDNudlpDOXNKY3pXQlhVNEYzK2pQK0xqK3hG?=
 =?utf-8?B?ekgvR3NIM2tod3ZsN0p4Z01HWkxRWGo5WDNUYWh1K3pYMis1VytEUnVBUHJN?=
 =?utf-8?B?SUhjbWJHOWpTQnJLM3l2cFNvVnRIY25EWWVJSWlpUWwyUlpBcFJocS90Qlpk?=
 =?utf-8?B?OC9pOTJmMmlxTFlCNWI2M3VZRVZhUmNCZlBsekViRzVKK3FFSFJxS3B1N3p3?=
 =?utf-8?B?MHY1YWU5bzBtZzE5MzV1SmtSZTd3QXJFaWdVRHliU0NpL3cxd3pPSFU3aFpl?=
 =?utf-8?B?eU5yd0FhUWVEeitYNzUrWFBTVzMrQWYreG1HZm1Na20yaXFtOXBLVG03RWtS?=
 =?utf-8?B?NDlEMStLeTk2N2RrLzhtMU1tNm5hajhRZGNhSTYrMFpRK1FMN3hMUnNSK3o3?=
 =?utf-8?B?ZUxuNC9KU0xOV2h1QnVZUk1XelVqbjl5aUoyRzR5L2F3cVFGTkhabWVMUDNM?=
 =?utf-8?B?N01aczdVN3NKenFjRFA2UXNpbXNhUi9xV3lRZ1VCOE9MaSsvd1RobSt5QjRI?=
 =?utf-8?B?UCtoZEVUMGM1SVF2dTZocTRwN3pKSy9CM1VGNHdKSFRGWDVxaDhGNmdRNEVM?=
 =?utf-8?B?Vi9obzRqYlV1MG1wVmhDaWsxS3NZbDBaNnQwRlpoRVJRdUNMbW9HVm1hSktZ?=
 =?utf-8?B?L01aQ1dsa29OV293ZEdPZ21RZzlTWWExUEQxZHBPOWx2NEc1OXY1MUFWRVhY?=
 =?utf-8?B?NXQ5YVcwSjVYaHNGWDNWYjViYU5GQTgrQS9KUDJwVnVTUFRCYWFlRXR1Nm1M?=
 =?utf-8?B?Rkp0M29mQVhhdU1haHpQeXpBUE9vTFFKelMyUGVjWDZoamp5Qk4rSythcHBV?=
 =?utf-8?B?QmlwU1JQSWRNazRRYTNsQUt4UHdGT1dLQWpvekhrSTVoaldIUjF5YytDM0pW?=
 =?utf-8?B?bHpsWUZ4ZStUKzhHT3p3c284QXNzbTFadXhwM3UxTGY1ZWZkNlhzRGI3cEN4?=
 =?utf-8?B?WEJNQVNremVlZWwrZWJQNlhYbVg2R3loL2ZwTnZMMVdtdXlZVk5kT2xUWmtI?=
 =?utf-8?B?KzN3MU1JUUd1TXN4Yjg2SXdjeCtSN1RYN3REVEtZZTBjVFlPdjdWYkJLSTF5?=
 =?utf-8?B?aVVTMmIxemtndFllSWU5cFlnUUVkK0srWUIzeTNybGdIeVVzbmd2SGgwVXVW?=
 =?utf-8?B?aURIeHRtbE1MdU9vYXFWSzgrZ2xRMmtTR3VNQ0hKdW56cFdXbVo0cCtRUTN6?=
 =?utf-8?B?TURTaDREaWlkN09WcDRiMlB1dVNSaWJIY21DTHNMVy9lQ2cwS0Y2NlQ4NWhz?=
 =?utf-8?B?OWhwSWRuajRabTUxeHlqeFBsa3F2blEyR25TR0FWMWNaUDZySG1oYmMyMXNU?=
 =?utf-8?B?blcxSmR1RGh6M2NaMG1laXFoMFl3ZDd4YWRQeW5NUS9pMGtNZkdmVTNCaVlN?=
 =?utf-8?B?RW5CeGYrcEZQUGhQTytXMlI3YmlhaTFFOWNDaUc4M2hNWElwVXVKNTI3c2pa?=
 =?utf-8?B?NDZMelJpbXJtNExKOWJIaTNjSzFZeTdoTHdkU2puZ3ZZVXlqVmRiMkVSR3JR?=
 =?utf-8?B?aExPYWNyaTEwVXRXOW9wOEZaSnErbTBoRlhDUWFPWGhNRStOOE5BQ1NvNVFF?=
 =?utf-8?B?cDhDK1RVZWFrYWtobVNpeVA4R0MxeWhOQWhpSVNZbmsweFMzQUJUdE9kcjJX?=
 =?utf-8?B?bEZaRHREOGpUR0dJSld6a1RHeWpCYkpEakN3WXM5MzlidWVxcU8ySkFKSXJN?=
 =?utf-8?Q?HKP/WLMi8P4MsYsg68TtPbYkaB0UVNRo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ajNyNm9JV2NCYjZkNFA1b243cEpnZXBZZE55eisvNWVvbkd6YU5sYzdNZG9a?=
 =?utf-8?B?ZVhoL00wclFBNGt3bGowSXZxMHNoWUxUUk0vSld1MVFRNlU4bUNjUmJDcEtj?=
 =?utf-8?B?NVVTMm1ac3RDekJMWG1zVjd6NzVWeG1jeFMvSU1wOFhNR0ZJWEdTKzF4QjEw?=
 =?utf-8?B?dlZ3K1NoY3Z4ZmkzbXUvVVVFcG5xbVNaWWlBYjhqbGV4UW4zNnAwc0dkSlgz?=
 =?utf-8?B?dGpTUWdhYnM3YTRrei9yQnZsMWxhUmNzSTUzQWVRYjRRVjA3R0plUWpLcGdH?=
 =?utf-8?B?amR6WjNCRkhFRE9UamtBbWpMdjNjOTNURWdjZzRzTHE0YUlNeHNwUnpmUkt1?=
 =?utf-8?B?ViswcTNvcklTTUtrVXUrcTBvMHQ0dlBEWHo4QjlkekhZVTdvRWk3bUVQZ281?=
 =?utf-8?B?M0dsbFJoZ0FlZ1hCZDhiU01yOU5zMG03YTBsZ1dWKzgvUzhtSXhiTXdUQUdY?=
 =?utf-8?B?UHI0SGN3OFNHLzJHSUcrbGNBYklZZlB0WVplblFOcHZrbjJCSXNLUmlmaHNq?=
 =?utf-8?B?a3ZCRm5wSE9ITWVEMUU2NnlLRmd4NUZ6RUV2R2R4VkZWZUZRZUUrajBXWUIw?=
 =?utf-8?B?U1hmK0FCaExEc0oxY0hZZytnNjFaend6ZDJkWWxncmRuc3ZYNmx6T0RRd2ox?=
 =?utf-8?B?MDdEVXdXUGltaTlEWFlTTWEwUWhiZzVTbkh1Um9OR3FYWlZheXRSWXZKVndB?=
 =?utf-8?B?Q0x1R0pVNWhyTklTdFlNbkpVbncrOVBFVDg5SVFkWGk2bTVSMlNXZ045VS8z?=
 =?utf-8?B?YVVDSk1yR3IrRzNvS1ZscFBBOGZDUHpqYkZvQm4yeFdPb292SERhSHRYNjJD?=
 =?utf-8?B?Ym1TZkVqNXhiWWpvSFVRcERiZ0ZZL0NpTGZzZTRVR2pDSnRCUHhmOXE2a0hE?=
 =?utf-8?B?QWFTMDAwOVZPbXV2Sm1LYStRU21WVjZWUktVMU5jejhyNjlyK1p2YnBkU3Vj?=
 =?utf-8?B?R0tQRCtlc2d0dVZQWG9uVk5paW1qM0NnSk5WZW1KcjFmRFV6Z2czUkFKZ3FB?=
 =?utf-8?B?OVJHYThhZ1pxS1BLS3dhdVlFcXRJQzc1U2hYQ3pBUDVuZGtWTHErTEpiZ1lo?=
 =?utf-8?B?NmNKZGRRZEdXL0w3d3NMOGxYNnZpQUJYbXc2QThPSGxxeGlBWi9LQnh5a3Ni?=
 =?utf-8?B?TTFHc2w4YkN5YUZaOUxRb1RjMHB4U2FuQ3RpSEFldXpzMndiNVdOaVZ3ZVlN?=
 =?utf-8?B?b1RkVlZCYTIvTnBralBZWFZIZWo5ZlN4ZEx5UGFCWm5XTUVldWV0N3RUaWw4?=
 =?utf-8?B?RUpLUkE1dll6clFrNWRJcElXOFM0Mlh2c0ZUMTlYUU1VZDljdUxHeUw1YkM2?=
 =?utf-8?B?WGhHVUs1UkRINjJXWG5RK041NWtnZWN4bEVHU01tRlBxVlZRSkFKNlJ6aEwr?=
 =?utf-8?B?QlJ1Sldpdzc3YnFhdlhrUzF6RndiWVl1THFCVzZyaFU4cnpYeEhuZWRoV3Vr?=
 =?utf-8?B?alV3V2hBZnNzbEtHVFlYUWpZdHM2UGJrUkQxZWh2TWNLYVl1cGZPQnYzK3pN?=
 =?utf-8?B?TTQrQXdOeXY3dVJiNHMzTGU2Tnk0WHRjT0V4ZDJxT2hkTzNSbE1SV2w1aFFH?=
 =?utf-8?B?UHhaTFhONWZZMXNidW1HQkNCR0dIMlJhY2ZPcnlxYWZ2TTVLUjg4U1BhdEdo?=
 =?utf-8?B?VlI0Sm5INk1mVmRJczB2ZzBNbmV3cGhpWGljamJkUWx4emxDVS9JdEkrSWVx?=
 =?utf-8?B?NUI3SFJwMW0vem9KTWc2d0w3MUc1a0txUytmUFUvMUhIamJVZ0dSUUcxSWZz?=
 =?utf-8?B?L3FPOTRKOVZQVm0zK2ZUN1FrdnczaGFzY2NjV0tBZnppU2pFeTY2OGNUa2V1?=
 =?utf-8?B?ZFcyTGU5ZWpscmsxNThSaEh3VG9TNm1IMmxBS1hFdXFQMmtpN1hteGtDQWV5?=
 =?utf-8?B?V3o4VnlocE13Q0E1WE1DUUlUSmQramxOSzRZWnJOT0YxUkFrdE5JRllaNlk4?=
 =?utf-8?B?VWt6MGhvcWFUS25WS3dpYkR4NEl5cXBKc2t0eDQzNTJwZWdBeHl0MUltSUtx?=
 =?utf-8?B?TmtEVHM3MlpOWi8zZFJDbjUrS3BQQVZzKzJxNTU2UnpiWFNyOUwzMEF6SkVs?=
 =?utf-8?B?UVJGRkpkWG4rd296d29EZ0J3a3VsclZQc1VtNnZaajQ3RkRIbnBaMlhRTXBv?=
 =?utf-8?B?R0JKQTJieVV1ZHhpc0Q4RUN4TjdTVXkyWGZvVlNIZk5jRGFBeGZhNFY1bVlU?=
 =?utf-8?B?d0ZuVlJsekdmSDNXWkxVSHp6Ui82VFNmMUlaSi9lelRYSnAyZFlTY2FBL1VI?=
 =?utf-8?B?RFVPUTY3UUk1T3JYZFpqcytpVHp3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0BF637AABB9C540B72045F9965A24AF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be102a9f-43c1-429b-9b3e-08dd1d695727
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 00:34:02.7000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZpTKpienUBss+LmF+6c+5GfPSR3agohUx8Jjs0hmvLGN+2GRzXU7BsZnFFR+Kc/DgLFU15Tty3OEvObr+PoPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4417

T24gU3VuLCAyMDI0LTEyLTE1IGF0IDEzOjM4ICswMTAwLCBSaWsgVGhleXMgd3JvdGU6DQo+IEhp
LA0KPiANCj4gV2UgYXJlIGV4cGVyaWVuY2luZyBhbiBpc3N1ZSBvbiBvdXIgUm9ja3kgOSBORlMg
c2VydmVyIGFuZCBSb2NreSA4LCANCj4gUm9ja3kgOSBhbmQgRmVkb3JhIDQxIGNsaWVudHMuDQo+
IA0KPiBUaGUgc2VydmVyIGlzIChub3cpIHJ1bm5pbmcgdXBzdHJlYW0gTGludXggNi4xMS4xMSBh
bmQgdGhlIEZlZG9yYSA0MSANCj4gY2xpZW50cyBhcmUgcnVubmluZyB0aGUgRmVkb3JhIDYuMTEu
MTEga2VybmVsLiBUaGUgUm9ja3kgOCBhbmQgOSANCj4gbWFjaGluZXMgYXJlIHJ1bm5pbmcgdGhl
IGxhdGVzdCBSb2NreSA4Lzkga2VybmVscy4NCj4gDQo+IFN1ZGRlbmx5LCBhIG51bWJlciBvZiBj
bGllbnRzIHN0YXJ0IHRvIHNlbmQgYW4gYWJub3JtYWwgYW1vdW50IG9mIE5GUw0KPiB0cmFmZmlj
IHRvIHRoZSBzZXJ2ZXIgdGhhdCBzYXR1cmF0ZXMgdGhlaXIgbGluayBhbmQgbmV2ZXIgc2VlbXMg
dG8NCj4gc3RvcC4gDQo+IFJ1bm5pbmcgaW90b3Agb24gdGhlIGNsaWVudHMgc2hvd3Mga3dvcmtl
ci17cnBjaW9kLG5mc2lvZCx4cHJ0aW9kfSANCj4gcHJvY2Vzc2VzIGdlbmVyYXRpbmcgdGhlIHdy
aXRlIHRyYWZmaWMuIE9uIHRoZSBzZXJ2ZXIgc2lkZSwgdGhlDQo+IHN5c3RlbSANCj4gc2VlbXMg
dG8gcHJvY2VzcyB0aGUgdHJhZmZpYyBhcyB0aGUgZGlza3MgYXJlIHByb2Nlc3NpbmcgdGhlIHdy
aXRlDQo+IHJlcXVlc3RzLg0KPiANCj4gVGhpcyBiZWhhdmlvciBjb250aW51ZXMgZXZlbiBhZnRl
ciBzdG9wcGluZyBhbGwgdXNlciBwcm9jZXNzZXMgb24gdGhlDQo+IGNsaWVudHMgYW5kIHVubW91
bnRpbmcgdGhlIE5GUyBtb3VudCBvbiB0aGUgY2xpZW50LiBJcyB0aGlzIG5vcm1hbD8gSQ0KPiB3
YXMgdW5kZXIgdGhlIGltcHJlc3Npb24gdGhhdCBvbmNlIHRoZSBORlMgbW91bnQgaXMgdW5tb3Vu
dGVkIG5vDQo+IGZ1cnRoZXIgDQo+IHRyYWZmaWMgdG8gdGhlIHNlcnZlciBzaG91bGQgYmUgdmlz
aWJsZT8NCj4gDQo+IE5vdCBhbGwgY2xpZW50cyBzZWVtIHRvIHRyaWdnZXIgdGhpcyBpc3N1ZS4g
T24gYSBGZWRvcmEgNDEgY2xpZW50DQo+IHRoYXQgDQo+IChhdXRvKW1vdW50cyBob21lIGRpcmVj
dG9yaWVzIGZyb20gdGhlIE5GUyBzZXJ2ZXIgdGhlIGJlaGF2aW9yIHNlZW1zDQo+IHRvIA0KPiBi
ZSB0cmlnZ2VyZWQgd2hlbiBJIHN0YXJ0IFRodW5kZXJiaXJkIGFuZCBsZXQgaXQgcHJvY2VzcyBh
IGxvdCBvZiBuZXcNCj4gbWFpbCAobWFpbCBmcm9tIHRoZSBJTUFQIHNlcnZlciBpcyBzdG9yZWQg
aW4gdGhlIHRodW5kZXJiaXJkIGNhY2hlIA0KPiB0aGF0J3Mgc3RvcmVkIGluIHRoZSBuZnMtbW91
bnRlZCBob21lIGRpcmVjdG9yeSkuIFRoaXMgdHJpZ2dlcnMgdGhlDQo+IGhpZ2ggDQo+IHdyaXRl
IHRyYWZmaWMgb2YgdGhlIGt3b3JrZXIgdGhyZWFkcy4gQXQgZmlyc3QsIHRodW5kZXJiaXJkIGJl
aGF2ZXMgDQo+IG5vcm1hbGx5IGJ1dCBnZXRzIHJlYWxseSBzbG93IG92ZXIgdGltZS4gU3RvcHBp
bmcgdGh1bmRlcmJpcmQgZG9lcw0KPiBub3QgDQo+IHN0b3AgdGhlIGt3b3JrZXIgdGhyZWFkcyBh
bmQgdGhleSBrZWVwIHNlbmRpbmcgYSBsb3Qgb2YgdHJhZmZpYyB0bw0KPiB0aGUgDQo+IHNlcnZl
ci4NCj4gDQo+IENhbiB5b3UgcG9pbnQgbWUgdG8gc29tZSBzdGVwcyB0byBmdXJ0aGVyIGRpYWdu
b3NlIHRoaXM/IFdoZXJlIGNhbiBJIA0KPiBmaW5kIHdoYXQgdHJpZ2dlcnMgdGhlIGNyZWF0aW9u
IG9mIHRoZXNlIGt3b3JrZXIgdGhyZWFkcz8gV2h5IGRvZXMNCj4gaW90b3AgDQo+IHNob3cgdGhl
IHdyaXRlIHRyYWZmaWMgd2l0aCB0aGVzZSB0aHJlYWRzLCBhbmQgbm90IHRoZSB0aHVuZGVyYmly
ZA0KPiB0aHJlYWRzPw0KPiANCj4gVGhlcmUgaGF2ZW4ndCBiZWVuIG1hbnkgY2hhbmdlcyB0byBv
dXIga2VybmVscyBvbiB0aGUgUm9ja3kgc2lkZSANCj4gcmVjZW50bHkuIElzIGl0IHBvc3NpYmxl
IGEgRmVkb3JhIDQxIGNsaWVudCBydW5uaW5nIGEgbW9yZSByZWNlbnQNCj4ga2VybmVsIA0KPiBz
b21laG93IHRyaWdnZXJzIGEgYmVoYXZpb3Igb24gdGhlIHNlcnZlciB0aGF0IHJlc3VsdHMgaW4g
Um9ja3kNCj4gY2xpZW50cyANCj4gdG8gc3RhcnQgdG8gbWlzYmVoYXZlPw0KPiANCg0KV2hpY2gg
b3BlcmF0aW9ucyBhcmUgdGhlIGNsaWVudHMgc2VuZGluZyB0byB0aGUgc2VydmVyPyBJZGVhbGx5
IHlvdSdsbA0Kd2FudCB0byBsb29rIGF0IGEgd2lyZXNoYXJrIHRyYWNlIHRvIHNlZSB3aGF0IGlz
IGJlaW5nIHNlbmQgb24gdGhlDQp3aXJlLCBidXQgaXQgbWlnaHQgYmUgc3VmZmljaWVudCB0byB3
YXRjaCB0aGUgJ25mc3N0YXQnIG91dHB1dCBvbiBib3RoDQp0aGUgY2xpZW50cyBhbmQgc2VydmVy
IHRvIHNlZSB3aGF0IGlzIGFub21hbG91cyBvciBkaWZmZXJlbnQgYWJvdXQgdGhlDQp0cmFmZmlj
IHdoZW4gdGhlIGlzc3VlIGlzIG9jY3VycmluZy4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxp
bnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBo
YW1tZXJzcGFjZS5jb20NCg0KDQo=

