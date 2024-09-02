Return-Path: <linux-nfs+bounces-6130-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B44E968D63
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Sep 2024 20:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4981C21A0A
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Sep 2024 18:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315B919CC05;
	Mon,  2 Sep 2024 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="inpomyz3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="onYrNILP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A190D19CC18
	for <linux-nfs@vger.kernel.org>; Mon,  2 Sep 2024 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725301636; cv=fail; b=cKpsXG7RmyTnMRxUMR2cKNx4Gs4Cdb91QTvvw2D395Y2U22r4vedprL1iLAlr4k3zIulaOezXeIPR4XreTJfxXgOT+pmOmx1hCxqlhw4pwdXlnsxa9cUZVNpZoRwJj+LzeUJgRuAfKO8ZebbcjLsyyxmNfGuVknV47PYpmDle7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725301636; c=relaxed/simple;
	bh=R0pxuWJ7F1LrBDLWcYCOCE8rKOkaA2cwqNxj5+LPalA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E92drEuCqexrObO+xMmNNMxdMBw7E8NXTG2hdrspw+9/tFitHH3VsKPw9zwJGwWNy9IJSqizv+lUSny04/fYbXVdfPWFxvYewKgbtm8jAEyYyJ1UEe9OEO9tHfssuiG99ScK8U5RkxZOTHZJkRqnMnXyVzT9ogV7pMXdef/ERT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=inpomyz3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=onYrNILP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482Hn0oT030658;
	Mon, 2 Sep 2024 18:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=R0pxuWJ7F1LrBDLWcYCOCE8rKOkaA2cwqNxj5+LPa
	lA=; b=inpomyz3r450I5ihR1N2vi6aYZ69ioCbA36xun8/LFqmMy4j7eIpX0dIf
	Qj6BptJysRw6v/g04BQPXxib45GxdUYhdZRxk6AwbwxI70L6jIDxjctFxX1W8pKr
	uTT5FHbAtT7SwEyq3Ndt8D9v7Ma+rqzdaQUE3S0YhMBYXCDLzs+NEkjWojvCXpE3
	UZ52tEpXP1WtOD7Ed5lYlz8mJQhN+uHNn4hWVjMsxtqKnp0VQe7xNZ0hSN8TIe8l
	NhYzQI3yFlEdAsHJonyjAAwoST6tGoWiB/woWWfn509i+UZkAfXAu7j5adxOy3mk
	AMrADTs/+ySLYy1Aa0HjZhWpeX4Nw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dhb7r24p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Sep 2024 18:27:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 482HkGEh001738;
	Mon, 2 Sep 2024 18:27:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsme59bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Sep 2024 18:27:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIWBOzNXZIbECAL5L/vNiPK9agH94dlr3ELuZiJ4YkkmluA/cIrmpFgpBBunN1wlDCtVmsu1dWzApNO/9C9o93NUekS1jIJr7HH40ErOtkhCfWZfsSTCcntp1g83UaWyLrE7fDJl/GkBygU3TlEZB7QrloVfS9VjpmNJPuR1ClfNnf78EE4xuGCezO59R4uEQ/J/hmwZ8V+SbbKZDjK6CWdI5P7Fr1NA7d3uD0mJO8ShAuo32vj6Fm0MnraQ5e/FIiP00rxWeTpoF3EEYDqh/kzfJJoDgJemz0a7UkOO1+Z0E7Ookym2nVl0YeiOUPScg9ht6jx+FIEqxOb3gKF5xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0pxuWJ7F1LrBDLWcYCOCE8rKOkaA2cwqNxj5+LPalA=;
 b=nL081Fr0+SGaONvfTTmgXlanxAn2E6dVOIOx4gO4+fnKBWo/vkaFVman25iNTf+DrgHVy/ih1eYeSBFMhs5DKeMg5bIOXbfIhzGkPZF50x9oYGab4o+zlrAGpwrJNJ3xWXhXteApdObvxxzIVL8isdhpThtUMH4/f6u1YUryRH8b1559aYIElzNcCLUfOQU46VRW0kWp8PXliYLcZ2luJJcvinDvi/GVr9OkX6GbazkNV/smHrV6H3hftycHTCHsJZBA9zqGYuwpikrITTIZJOrvOr1W0JzqMdgLe98szoKkjoGCiNZ9KP3PmGE/eLV1zZ9VfdE6wxokoXVkuAloiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0pxuWJ7F1LrBDLWcYCOCE8rKOkaA2cwqNxj5+LPalA=;
 b=onYrNILPnPDzteHV7RPFB6dtnX5RBuf3H1KZX42johw6f6zKyMgCXzAZaR/9r+W0oTIAG1i+Gcn/fXnnWbTdKIoRvsCwdPskGuy9XK8lob1prRBqXSjo1ZEwyDN8cDGWxxm/ufgQqdpIXB/QhBjiUqpUpmS/DuDi6cECbOJhVq4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6017.namprd10.prod.outlook.com (2603:10b6:208:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 18:27:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.007; Mon, 2 Sep 2024
 18:27:02 +0000
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
Thread-Index: AQHa+fQMSvU+UHZs70qpZfYWU/bmYbI+LmEAgAADAYCAAFSfgIAF4bKAgABvwQA=
Date: Mon, 2 Sep 2024 18:27:02 +0000
Message-ID: <382C8220-090F-431D-B166-24A4ED503D65@oracle.com>
References: <20240829091340.2043-1-laoar.shao@gmail.com>
 <D27B60B1-E44E-4A89-BB2E-EF01526CB432@redhat.com>
 <CALOAHbDuThEW=osQudcxGQtFQqePaHzbG3MJyzGi=fLGbUqmKg@mail.gmail.com>
 <6B62A228-6C9C-4CDD-8334-E26C11DB51A1@redhat.com>
 <CALOAHbD0vhRypzEJDKJgCzYTzrhoiofzRZWF4rgr304NMXTjBw@mail.gmail.com>
In-Reply-To:
 <CALOAHbD0vhRypzEJDKJgCzYTzrhoiofzRZWF4rgr304NMXTjBw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BL3PR10MB6017:EE_
x-ms-office365-filtering-correlation-id: f8fb6909-0e64-4c05-8023-08dccb7cd711
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MzZ4MlNOSFdqMW5jRjhqUXVyZWNlVDJWajFkRTA5cllraFhHWXNPdkVoaVVI?=
 =?utf-8?B?emxTWGRKOEpKODNqQkl4SHl0NWl6alZZY01vZ3BXanlTZGpOSE5YQTU5RE5y?=
 =?utf-8?B?SGlERHg0TVJpa3c1ZEhDSVVJWGFFTk9YVzVRNzVwazNubTlmaU1ER1RwdWZk?=
 =?utf-8?B?SjNrOGUzM2lXcUt1MFloZk9GMncvNUE0d3RyK00wWWdXZThaejF2ajIwQkRl?=
 =?utf-8?B?OXdKcVFmZzNoZUNzNGNod1lqWWxxRzVGSW5kNlI0Q29mVzQvWG0yK0tFNHFq?=
 =?utf-8?B?MXh5Y0loN3dHVXQwa3FLZ0o4ak1lYTVVMDZTMlZoKzNybnNFeFU0d3lZU3R3?=
 =?utf-8?B?ak03RC80L1JqU1h4UjQwMnlaSWEyVXFmYm90UjN0ZDRDVGc5KzNQdTMwYnU3?=
 =?utf-8?B?d1F4MEl6RDRmbnV5UjhrOHZ2a0RwQ1ZzdjQyZWhKUTFvR2ltTVowVEY3aDZH?=
 =?utf-8?B?UFVCZmYrRVlkRGUzeEttN2xxQVdScGgxS2Z6czgwSG9YQjRoeXZUSDA0VDRk?=
 =?utf-8?B?eFBtOGtTUHJmbnZ4U1BsNHZEKzJqUFV2VjlEUlpnMTJFTVVBREVzZWY1b3Q2?=
 =?utf-8?B?Zm1QYVZYVXkzZ3g4UTZyL2NJS1VDWVlhdlZwc1hNa1EwdzJXNFNMV2orbVRu?=
 =?utf-8?B?NUFiYWVqTEJGMTQ3RGlmRmVRRzU0L3RwRGI1NkJPSmRmSzVVOGQ2QmIvbWF3?=
 =?utf-8?B?Tnh1VnRwc1BsazhJc3JDTVNYaE4veDRad0NUZFk4N2VqL0hlVkJBRjE4dGhW?=
 =?utf-8?B?bXV0djlFMmxLOUhxQ010dUx2R2VScyt3SjB3dEQ3UlJzMjh3MHZhdld6amJO?=
 =?utf-8?B?bit6K3Vnc3VqUVBaTGl1SVFmNkpIblpFM3JPcmxwblZTT0lrSDVlOWJFQ2dk?=
 =?utf-8?B?WXRDVjhxTDZJMm5vK1FmK0ZlaUtoaEFSbEpObnUyaGRnbGl5SkdaODVKbGNl?=
 =?utf-8?B?QjVvR0pwY252RG41RjQwczE5S21NU1ZHaCtBcDJ5dzF4RFVyc1RsR0loVEdo?=
 =?utf-8?B?Wk5yQXZ3eW12Sm9qYzhMY2g4WVphL28xZkVudDk3S3R4eGhubERmUy8rUzJZ?=
 =?utf-8?B?Zm90N1hMZTBzeWJjMFo5NXd3RkJ3dUNIbFNiRUwrMHgybnZOSHJSbWwrNFMw?=
 =?utf-8?B?MjYzcnE2aDYwYTdKK3Nza1IwNWxTT1B2OXYrZS80dVFHeVpXcHhrWUF3T2xk?=
 =?utf-8?B?SVd0M3dBUGhjY3QvVk5lWnB5Ymo5MjkyUEp1UHRpOHVXUXJPbDBoZzUvRE9h?=
 =?utf-8?B?cUgxTlF5dXpKTUVHc0VoNUpZdEtLTUpUKy9qNWY2VlFSVVVKYnhPeUxnUElp?=
 =?utf-8?B?Q1pjUEhyNjJEc2NrTGlmM05CTlVaTUhPalNWUGZYNzJUWFNSc2IvbUQ3U2c3?=
 =?utf-8?B?R21NY2NTbm5JYlhBbmlTSG90cTJ3MXE0SVowckFSWFhlbm1rdklBbDhzaHJw?=
 =?utf-8?B?bW9jR0l1cmc3SjczNDltRm9iR3NDbzB4R1lFS0JLVjVCRFNYRUZieEZzaTdF?=
 =?utf-8?B?MlhOazdXMTVldmkyajhOY3pCSWoyRXdENkJYa0VJU00rRUx2Sm5Kb3kwYVRz?=
 =?utf-8?B?bXQ5a0ViUG1WbFJ1SE1EZldJaktDZWRkVU5oZ3ZTUUZ5TzRuc3UvMythZm5q?=
 =?utf-8?B?US9MbFJEcitZUkpxMzFHeUxpVFFkV1E4QldSVmR3WEdES0ZQSklGaTloMm5n?=
 =?utf-8?B?aEFvTzFDRGw5QllsSi9VeHVZb2QzaUo0R0d6VFI0TCs1Q0RMdTR5c0o3b0t0?=
 =?utf-8?B?NFN5dlJldUk3N1VnWWpkK1NyWDI1NS9PTUJSRzJyYUJ3MS9pcUt3cHQzNW85?=
 =?utf-8?B?YjB4YkljYkZXQUJzb3I4ZHNydzhlaWR2OEw1SkJUOThHMHcwU2tTNUlmOHFm?=
 =?utf-8?B?a2h0Q1I5N2FkLzJ2QXhRRUtYbmZvWnNEU0lWVHZQT3Q2QXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1VQYkhhdnpxZ3ZiZVdraEhINm9iOWVHdXE3NitkK2ZZZkd5Tks2QjRrVTNm?=
 =?utf-8?B?ak1LMWNxbTd1VEdxZXY0ampIL09wbGNFK0JoTjBXbUQ5U2I2NFcyU3RMM1Ns?=
 =?utf-8?B?dVVjVmpKdmJscTFGekNteWF4OFBxK3lzZlBZam5yUisrRjhUSTRVTi9nZ3Bp?=
 =?utf-8?B?eGxjTzQzZ2dNS0Z1NjRGNmtIY3R1M0UvSy9DYUZIZTIrSVd1YWVwdDAwWGFY?=
 =?utf-8?B?OUQrNytJRlFlOGVyVnczdVlJb1RjVlpzL2RSMXVGc3B3OFI4M1hNQXZ4ckVC?=
 =?utf-8?B?Q3E2Mm01bzBDOUNoZ1pOWWZocEZlT0RqUVA5dVRxd3Z1d29HV2hhMDZBaVNS?=
 =?utf-8?B?N0ZnNzdEL2E5Tm1oa2t2TzRLQW9QN3pzS0xydGNrTVVUWGVmTHdtbit5MHo1?=
 =?utf-8?B?OWdWdFFBb2R5eGZSSWI0RHpMZXZRdVhwdWFTTGpiT29QVTF3aHV3ZzAvOUFa?=
 =?utf-8?B?eHRmcTBrVjhNVXl4VkozQ24yR3VUU0lVTGJlZlduREtzWFJ1L1JvMENkYmFx?=
 =?utf-8?B?ZVFTZ2F6b1FLWlgzdGQzMzZxQ3E3MXprVlF5N0N4UWJUdi9Ma0UrWHoySnR3?=
 =?utf-8?B?QkRTcDQzYms1RTlkKzBBZzBkZnN1TUIyVW9sNlZybDBoL29kVkM4Nzc0ZVZs?=
 =?utf-8?B?VEQrbHVSUFVJS09SaGlIQ0xyZHBYN0RsWGhwYitQc3hIS01RRmJRa3ZMQTJj?=
 =?utf-8?B?dzRpTG8wWEM4VFFkdjFtZC9DbUx4WTdwa1lsWCtrWE91aXVIUDhWUmJJQTQ4?=
 =?utf-8?B?TGt0Q0hIOFlaM05zMkpzY0VmOC9semU3ZDUzZGZONVJZUEs1K2t6RW02dUdX?=
 =?utf-8?B?NmFzNjNOUDhpYkcwNlRsdlRlQ2duVHdONEVQQTQzRG9CRWNvYTdpK0VvWlEv?=
 =?utf-8?B?anRPVzJCbDdVZEhvUzJlaWUyUlBiOUxFUHVmZThlZXM5WTdWVk4ySWt4UjhG?=
 =?utf-8?B?TmtWVW1JZjBudUpsZmExZkdQS3M5KzJLdmIrSUEwREdHZXcvcG9vZVdyK05H?=
 =?utf-8?B?a1RSOFJ3ZVYvR2VaVyswaytQeVJlRFNMWHNJTlpQZUMreVdPdVQxaXV1RGNJ?=
 =?utf-8?B?NndyZlNGV2Nmb1N3TXlkODJER093MVNtMWZrUytkSmJxeStoRHMwMUp3UHRm?=
 =?utf-8?B?WUxZR3dENmJBcEphS1NHQ0dJdGhjbzU5aHhGMU5sN0hCcWsxMXdwT2psLzh2?=
 =?utf-8?B?TmZuYUZWKzJwSS9iR2F4ZHMzSDhHaTZCeXRBSnFvNjlDTThSY1FhWTEvTkdr?=
 =?utf-8?B?aFYzRjVTZ2J6d3ZJQmF4MHdUK0twTUkrSU1GSFBJT2EydHo3U0NKR29NdmVl?=
 =?utf-8?B?MG5lZ08yV3BuQjVaZWNVcXNBNlRiVHN1bTRKaGM1cDlwSXB2U25USjZRRmZC?=
 =?utf-8?B?cWx4cERoMHo0cnJVYjY5cGtZK2FsUmszZ3FaUVNtQkQyeTE1WWpmbTRON0w4?=
 =?utf-8?B?M2dSOHJxZXA0NnVsbHdKV1N1cVdqR3hLbHFKM1ZrTWhPMGswREFvUWozcjhU?=
 =?utf-8?B?UDFLQjFsRTVVSXdVUDNac1lTQzNEclV0ZTJPSEhmcmg3aUNOVnFGaTR1eHV2?=
 =?utf-8?B?UGZCcnU3a1g4eFB3cVFlK3B0eVIzMlMyekw0RUVyUWJZeGFmR09Db2t3N1h4?=
 =?utf-8?B?MWdFME8zaDgvUmF1SzNIdDlkRGZkTGNsWmpuUVRDczYxK0xFUXBaMWZDL0wv?=
 =?utf-8?B?eGNiUURGV3VjaCtXVnFqYXpJRzF3aGZWc2FxTFhMZTJRTE92ZVErTnp6M3M0?=
 =?utf-8?B?NDNMaXplNERZb3ppSXR0YU9iOEk4bGN5K05xaFYzMHlyUm0xeTdBUG4rdk0y?=
 =?utf-8?B?T2JtWEpKMFVINEtEK0ZlNTdUNjVmbVVSRWt0Z3ZJbjRjek1RNkMxejE0SmU4?=
 =?utf-8?B?ZGFLVmN4NkxpdWVRNFh6Z3grUTBxV0g5RHZZSDFhNldFRkhqYVVmU0pEWHoz?=
 =?utf-8?B?TnZydllubFBBMEFndS9oN3ZMQjVad1dBT2o3eTdtQkdFMWFQOTVzYndwT3Vh?=
 =?utf-8?B?NUFJQjVkQnJJNFV6TXJTLzhQUFFvZ0NWRlZCdXlRSmk3bmhDNkdsZTY5dU1G?=
 =?utf-8?B?T1JEandwVWJ3MDA4aWdscDFhQmpGaVVYbE1CalZDUS8xMFlubG80QlZFNm9i?=
 =?utf-8?B?eXF2dFBuak01RFYwczlHY3lkV0hjUUM5VFJhYVhWYVJaYlBBYnNkaGl1STJJ?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC982A833108114C9C3B0D870F29AE83@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+l+J5Lb0rEj4grFFQdhbpNQ6nHltVH5LuGHkQtUaRQqDIf6rD8z/VpOJ+EBkKJBPW3dkeClFwT3jUEJuCe76xLvSRlEladSa2VHEAaSqIR+FL9IJIQO5GCMG03BgwlHgT5mWILMLObpuFnkqQOoQE9GibuphfQssy16fJ290vXXWvh+ZPn/QTclvoESmhY92sQ3zw6cGwkhC43chmMno20V44JHyNX99R6YeCZ1yy4jTZHLZkZneaZMBZOWGZUUQzQZxVnQgg9+hlSm+BaeVqyFsBhGUWgq2JP63+IpFk3iEUzXHCZbVeSGICXb8SjTVuKhXzacwbFEaTTDcSTvyIZBpdqiKyZzgJJCHUj6NdEGbS/ty8MhzVGJvgBkgPU8la8ZsfM1qFfdn8pO9JBknW9RbtgmOPoZ+GyC6kFOMoVWUyEAMvBjP+CZ94/PuKcfdTBssRiDB+DL2SuhX5P+ilb3pMbYD4F1KLf+7LcIp8JCgtS8GC58Qcp0jBWQrM2IdC7/BjGlHaA3D6xjf87W1HGzp5DIb0N+mPq/TziX8j+s3qE7a7SKgH11x1GoV58bLPUnOEsZG1Cq4xUMcAiwm6mRnFyCXp0ZmXUoExB85qqk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fb6909-0e64-4c05-8023-08dccb7cd711
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 18:27:02.3796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: luM5KTKBqEqR0bVbq8GCFZVA1TGqy5X6sTqGJf6boQPMHluNMbOsUGUGuM9WtrtJ7pu5FJqL5K+DKsfNPvh6Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6017
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_04,2024-09-02_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409020147
X-Proofpoint-ORIG-GUID: aMahxzcrpwdqRrFRrbx9paxAF-wIDhb0
X-Proofpoint-GUID: aMahxzcrpwdqRrFRrbx9paxAF-wIDhb0

DQoNCj4gT24gU2VwIDIsIDIwMjQsIGF0IDc6NDbigK9BTSwgWWFmYW5nIFNoYW8gPGxhb2FyLnNo
YW9AZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgQXVnIDMwLCAyMDI0IGF0IDE6NTfi
gK9BTSBCZW5qYW1pbiBDb2RkaW5ndG9uIDxiY29kZGluZ0ByZWRoYXQuY29tPiB3cm90ZToNCj4+
IA0KPj4gT24gMjkgQXVnIDIwMjQsIGF0IDg6NTQsIFlhZmFuZyBTaGFvIHdyb3RlOg0KPj4gDQo+
Pj4gT24gVGh1LCBBdWcgMjksIDIwMjQgYXQgODo0NOKAr1BNIEJlbmphbWluIENvZGRpbmd0b24g
PGJjb2RkaW5nQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4+PiANCj4+Pj4gT24gMjkgQXVnIDIwMjQs
IGF0IDU6MTMsIFlhZmFuZyBTaGFvIHdyb3RlOg0KPj4+PiANCj4+Pj4+IEluIG91ciBwcm9kdWN0
aW9uIGVudmlyb25tZW50LCB3ZSBub3RpY2VkIHRoYXQgc29tZSBmaWxlcyBhcmUgbWlzc2luZyB3
aGVuDQo+Pj4+PiBydW5uaW5nIHRoZSBscyBjb21tYW5kIGluIGFuIE5GUyBkaXJlY3RvcnkuIEhv
d2V2ZXIsIHdlIGNhbiBzdGlsbA0KPj4+Pj4gc3VjY2Vzc2Z1bGx5IGNkIGludG8gdGhlIG1pc3Np
bmcgZGlyZWN0b3JpZXMuIFRoaXMgaXNzdWUgY2FuIGJlIGlsbHVzdHJhdGVkDQo+Pj4+PiBhcyBm
b2xsb3dzOg0KPj4+Pj4gDQo+Pj4+PiAgJCBjZCBuZnMNCj4+Pj4+ICAkIGxzDQo+Pj4+PiAgYSBi
IGMgZSBmICAgICAgICAgICAgPDw8PCAnZCcgaXMgbWlzc2luZw0KPj4+Pj4gICQgY2QgZCAgICAg
ICAgICAgICAgIDw8PDwgc3VjY2Vzcw0KPj4+Pj4gDQo+Pj4+PiBJIHZlcmlmaWVkIHRoZSBpc3N1
ZSB3aXRoIHRoZSBsYXRlc3QgdXBzdHJlYW0ga2VybmVsLCBhbmQgaXQgc3RpbGwNCj4+Pj4+IHBl
cnNpc3RzLiBGdXJ0aGVyIGFuYWx5c2lzIHJldmVhbHMgdGhhdCBmaWxlcyBnbyBtaXNzaW5nIHdo
ZW4gdGhlIGR0c2l6ZSBpcw0KPj4+Pj4gZXhwYW5kZWQuIFRoZSBkZWZhdWx0IGR0c2l6ZSB3YXMg
cmVkdWNlZCBmcm9tIDFNQiB0byA0S0IgaW4gY29tbWl0DQo+Pj4+PiA1ODBmMjM2NzM3ZDEgKCJO
RlM6IEFkanVzdCB0aGUgYW1vdW50IG9mIHJlYWRhaGVhZCBwZXJmb3JtZWQgYnkgTkZTIHJlYWRk
aXIiKS4NCj4+Pj4+IEFmdGVyIHJlc3RvcmluZyB0aGUgZGVmYXVsdCBzaXplIHRvIDFNQiwgdGhl
IGlzc3VlIGRpc2FwcGVhcnMuIEkgYWxzbyB0cmllZA0KPj4+Pj4gc2V0dGluZyB0aGUgZGVmYXVs
dCBzaXplIHRvIDhLQiwgYW5kIHRoZSBpc3N1ZSBzaW1pbGFybHkgZGlzYXBwZWFycy4NCj4+Pj4+
IA0KPj4+Pj4gVXBvbiBmdXJ0aGVyIGFuYWx5c2lzLCBpdCBhcHBlYXJzIHRoYXQgdGhlcmUgaXMg
YSBiYWQgZW50cnkgYmVpbmcgZGVjb2RlZA0KPj4+Pj4gaW4gbmZzX3JlYWRkaXJfZW50cnlfZGVj
b2RlKCkuIFdoZW4gYSBiYWQgZW50cnkgaXMgZW5jb3VudGVyZWQsIHRoZQ0KPj4+Pj4gZGVjb2Rp
bmcgcHJvY2VzcyBicmVha3Mgd2l0aG91dCBoYW5kbGluZyB0aGUgZXJyb3IuIFdlIHNob3VsZCBy
ZXZlcnQgdGhlDQo+Pj4+PiBiYWQgZW50cnkgaW4gc3VjaCBjYXNlcy4gQWZ0ZXIgaW1wbGVtZW50
aW5nIHRoaXMgY2hhbmdlLCB0aGUgaXNzdWUgaXMNCj4+Pj4+IHJlc29sdmVkLg0KPj4+PiANCj4+
Pj4gSXQgc2VlbXMgbGlrZSB5b3UncmUgdHJ5aW5nIHRvIGhhbmRsZSBhIHNlcnZlciBidWcgb2Yg
c29tZSBzb3J0LiAgSGF2ZSB5b3UNCj4+Pj4gYmVlbiBhYmxlIHRvIGxvb2sgYXQgYSB3aXJlIGNh
cHR1cmUgdG8gZGV0ZXJtaW5lIHdoeSB0aGVyZSdzIGEgYmFkIGVudHJ5Pw0KPj4+IA0KPj4+IEkn
dmUgdXNlZCB0Y3BkdW1wIHRvIGFuYWx5emUgdGhlIHBhY2tldHMgYnV0IGRpZG4ndCBmaW5kIGFu
eXRoaW5nDQo+Pj4gc3VzcGljaW91cy4gRG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zPw0KPj4g
DQo+PiBJJ2QgY2hlY2sgdG8gbWFrZSBzdXJlIHRoZSBzZXJ2ZXIgaXNuJ3Qgb3ZlcnJ1bm5pbmcg
dGhlIFJFQURESVIgcmVxdWVzdCdzDQo+PiBkaXJjb3VudCBhbmQgbWF4Y291bnQgKHRoZXkgc2hv
dWxkIGJlIHRoZSBzYW1lIGZvciB0aGUgbGludXggY2xpZW50KS4gIElmDQo+PiB0aGUgc2VydmVy
IGlzbid0IGV4Y2VlZGluZyB0aGVtLCB0aGVuIHRoZXJlJ3MgYSBsaWtlbHkgY2xpZW50IGJ1Zy4N
Cj4+IA0KPj4gQmVuDQo+PiANCj4gDQo+IEhlbGxvIEJlbiwNCj4gDQo+IFVwb24gdGhvcm91Z2gg
ZXhhbWluYXRpb24sIHdlIGhhdmUgaWRlbnRpZmllZCB0aGUgcm9vdCBjYXVzZSBvZiB0aGUNCj4g
aXNzdWUgdG8gbGllIHdpdGhpbiB0aGUgTkZTIHNlcnZlciwgc3BlY2lmaWNhbGx5IGl0cyBiZWhh
dmlvciBvZg0KPiB0cnVuY2F0aW5nIGZpbGUgbGlzdGluZ3MgdG8gbWF0Y2ggdGhlIGNsaWVudCdz
IFJFQURESVIgUlBDIGFyZ3MtPnNpemUNCj4gcGFyYW1ldGVyIHdpdGhvdXQgYXBwcm9wcmlhdGVs
eSBhZGp1c3RpbmcgdGhlIGNvb2tpZSB2YWx1ZS4gQWZ0ZXINCj4gaW1wbGVtZW50aW5nIGEgZml4
IG9uIHRoZSBzZXJ2ZXIgc2lkZSwgdGhlIGlzc3VlIGhhcyBiZWVuIHJlc29sdmVkLg0KDQpQbGVh
c2UgcG9zdCB5b3VyIHNlcnZlciBmaXggb24gdGhpcyBtYWlsaW5nIGxpc3QuIFRoYW5rcyENCg0K
DQo+IEhvd2V2ZXIsIHRvIGVuaGFuY2UgcmVzaWxpZW5jZSBhbmQgbWl0aWdhdGUgZnV0dXJlIHNl
cnZlci1zaWRlDQo+IHZ1bG5lcmFiaWxpdGllcywgaXQgbWF5IGJlIHBydWRlbnQgdG8gaW1wbGVt
ZW50IGNsaWVudC1zaWRlIGhhbmRsaW5nDQo+IG1lY2hhbmlzbXMgZm9yIHN1Y2ggaXNzdWVzLiBX
aGF0IGRvIHlvdSB0aGluaz8NCg0KVGhlIGdlbmVyYWwgcG9saWN5IHdlIGZvbGxvdyBpcyB0byBh
dm9pZCBmaXhpbmcgc2VydmVyDQpidWdzIHZpYSBjbGllbnQtc2lkZSB3b3JrYXJvdW5kcy4gRml4
IHRoZSBzZXJ2ZXIgaW4NCnRoYXQgY2FzZS4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

