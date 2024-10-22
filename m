Return-Path: <linux-nfs+bounces-7354-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A889AA218
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 14:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142331C21F88
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 12:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D641E495;
	Tue, 22 Oct 2024 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eZ3o05jy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dUwYi8Qz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B019D881
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729600122; cv=fail; b=geZVljzfJVziFDkF7RFy614Embuq0B0aogpAHEZrGbQD5/pYaDYbv2XbxNz1nVcbc0jkli1ZLUwQYGP0JTFGNV97hTLJQoDUaGlUo3ST4I9G/mbvth4jCOKAMhlGXaj8k0dG610fOX1JeTeK2P7vZG4SbHmZcCt8y+vN0j1XHfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729600122; c=relaxed/simple;
	bh=SgisC28XOc/bmOoTvsDySM9kEB3CPEu1W77eVxFq/mQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pSaLDdhrFqEeMyavcuT8+3xelc/0WzjhyR3ubb/6Yo6OfMf/rtcylie5/5HVnemgIpeWt/MzevScMe82wKtrGKlRNWRXbF/mAMSBj9o+4df7isw92ySp8sOjUnLxWls1mo+WWKT9pPgu+R9Lv0jwRDJzbXLJnF6IrPPYi8+DR5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eZ3o05jy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dUwYi8Qz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MBhUrB027116;
	Tue, 22 Oct 2024 12:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SgisC28XOc/bmOoTvsDySM9kEB3CPEu1W77eVxFq/mQ=; b=
	eZ3o05jyUaAtBneUmogXIC7aJJxX31LmNlTfTaIaANbdNzl/mEDZs7K8tqZBNiry
	e3A9OCiBM7AxuBTIADvN/rkvXxb2qEIcadGaHZCz3K2mNcK2x3Ien6RDeKoPw3SK
	O7OGLCkUT0kCfXERSbIt7FJvCn37Ayqn8XUxk+0UurqwdyKaGAa4cHvYNEg7a0J2
	iEEb/qjM7lY7eZ15LIY/o7+99TL0+XRHlFFF9/xS62rm+do57tiWoVrRfNo9HXfh
	Bm3bfw3jAnykB6X4pTxWjMVcyDcCAN6ttJQCz2/u08TuvvyH0G3eE+HvElVTl4y8
	DVjm9cjbK+uc6sdiBns9rA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5455f2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 12:28:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MCIoRe026242;
	Tue, 22 Oct 2024 12:28:37 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c377kk3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 12:28:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hm4XUHI3zAlEC/ZkNwWyNwNvflWDBA22+E0fBJ/rAVQkbwAX4/Q0M6pcL9sy6d77lRK+r6vTwojkKPI/LyVNt3EqEtjlr3bG2cEjBfNjXJ3LwcVOrZcWRhvOEwv/HFXLB7hxHTR+yotbrarSgatosVcpf6TG5uGNpIAR7nx6L6ow9wi1KmTVOLgMENCOvSitnz3hkHEuaacw+Mr/HmTpIkX8Or+2Qzu1WAO7xJliCoMuQeFYKTVXKm8+lTvvFqRNBJNRLxQ2wWKzZ5XyTZEDClqCAYy/P/fxH1TMYfydxlFVV5oVoGpHvVhh7kdY4WVEOAGtqkFVv9HNIfw/Xh1P+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgisC28XOc/bmOoTvsDySM9kEB3CPEu1W77eVxFq/mQ=;
 b=yLvnwUmmPB2RX3oCue5iYCjT5IhjCLHlmfeEuMaZLCEbcqeYhsnJ1gE9i7icWheed9MCe6W0Ctnprxi6AiDBwfDxBIf0xnUARUVloFJx260eNcx7TY2xXcNn4ehwFWKw7EKliQQ/qA1HeoZGlM7pZebpMArPj0CUs+A4lnuOxiXDSbtpDuG4LO5HNezyyBfa5gd0szwKr8b74JW8XVFfgCHexuzl88L3F+zrlXQ4xNPZ0u9RKUWu46hO5iAwKomD4R54iLht3hBdhCV0wE8K0fe3Ns4EKmdmGtfC+E53gx67+bv2Z07+M7jbfm+h/aW0ed+fEaceqJNlRr/V/PBDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgisC28XOc/bmOoTvsDySM9kEB3CPEu1W77eVxFq/mQ=;
 b=dUwYi8QzKuRtJLDc+SA/8i4C4LSbIqStUnqa7/Ov5ddYG+6LKDlTjCzNW+gJNmS0itV5whmDvs1N9hCxBxfwHaugKdz3bUX+yqlQ1g/aanVPy7FukiQwizKhtY4HMb+dIjNjpsYHCSoj5a1CTDdZ3oW/asV2wAXoL3VnwaHJTKU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4192.namprd10.prod.outlook.com (2603:10b6:208:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 12:28:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 12:28:15 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Rick Macklem <rick.macklem@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: RFC: Dealing with large POSIX draft ACLs for NFSv4.2
Thread-Topic: RFC: Dealing with large POSIX draft ACLs for NFSv4.2
Thread-Index: AQHbI0UuNnIPLptcXEqPvS3UQPcZ+rKRSTAAgACC6oCAAOkKAA==
Date: Tue, 22 Oct 2024 12:28:15 +0000
Message-ID: <DD0FDD16-B48A-40BA-B231-C6139DCCD130@oracle.com>
References:
 <CAM5tNy4S0O28CcDGV43BWXegSZSPVEYgFKpaLxLSNSgjti_L5Q@mail.gmail.com>
 <0A2D2441-712D-4EE5-BFDB-E77108BB1A1F@oracle.com>
 <CAM5tNy4jsSeAWQX43K9+6n=byvuGJF0o4enySTmdY-j=Y8BvvQ@mail.gmail.com>
In-Reply-To:
 <CAM5tNy4jsSeAWQX43K9+6n=byvuGJF0o4enySTmdY-j=Y8BvvQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4192:EE_
x-ms-office365-filtering-correlation-id: 6f4671ef-0834-4901-c2ab-08dcf2950066
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eEFWRXJ3WUtWL3Q0NFlORTljMTVraUxEV2dZWW5pajg0c3oxeld2ZHBLamxY?=
 =?utf-8?B?R25WTUROZW0zYUFsK3VhK1MvMGNOdFR1Z1FOdkZ1WmRVc2dwTEh6bzlUOEZJ?=
 =?utf-8?B?amVTd1VKM2JQYkNGcXZISDd0d0R1RExJdHQ4UEViMzJ3UWR5Z2x1blVqbTJN?=
 =?utf-8?B?TEVpQWh2T0pSVzlIUFllUGl3RTNUOC9NVDNzK2Z4MDdvUUluTkw0T2JRWlRq?=
 =?utf-8?B?Rit6RXlHQ3FCbno2dElRZ01FU0NUWlZxaUxZYnhpYzkxaU0zV0p2cmFzTWlZ?=
 =?utf-8?B?UVZ2bFhwVFE5WTdlblozWU9yZW9ORlFDS1BaQ3h6QlA0VVNZQk05OTV2eElR?=
 =?utf-8?B?cjl6Uy9iVTlCbjNyNjJmaTF5eTduQ0tOTWJIeDRDeE1kN1l0bExDYkUwckNt?=
 =?utf-8?B?SGd5VHZGUFZHUExzd1k0YmZuZ3piRHkrbFhHR3AyYXo0RDFtWEwzUEtEVmda?=
 =?utf-8?B?ZGo0eHhpT3Q0UUhCSzdHUDBWUUlJcXQ3SlVaZFZ5UmNKR0NaMEJnMXlIQ2xY?=
 =?utf-8?B?YTh4ZHMrYzQ2c0c3Z1Znd0c2QVNFaEJZTU03R3NON0hZTFFzOVFyNkVJSXM2?=
 =?utf-8?B?ZjJiQXFKVlhDdThScG9nb2k1alV6dzEyZ3dTb2NWR2tBM04rWXJ6bWlLblpn?=
 =?utf-8?B?MCtPcjViSENvaGptZ1c1akZmcTRBTzNQdTUwTFM4U3h0emxHdXFPdUt6SzhJ?=
 =?utf-8?B?My9rNDNGZ1FTdUlscDVBdmUyZjRWQmlGR1JuaGdhRmF3Njh5ZFVacXdLVDdV?=
 =?utf-8?B?ME8rNWN0WllUTlhkeThRQUNGTHdYa3dOa1k2dEFnRGJFM1dNeEFYV1haZVVI?=
 =?utf-8?B?dm1RUnVNYWZUbFlmZVNnOWZLMTI2cWgwU1N3L3FVeHYrVzVhWXE2aWdiVThQ?=
 =?utf-8?B?NHJicmp1MWVFQVNQNXZNZzV0SkZ6c0FaU000aVozVkxEa05nNHJHejJCOHpW?=
 =?utf-8?B?UkNWSGhzamZYaGxGdGVrT2ZhNUVtMmY3ODVlV1g3cXVGNEcvMzBYaFczMXlJ?=
 =?utf-8?B?ZE5KYTBKUEQzSkFLNU8yQk5QK2p5WXFJeU9YL0tyMUR0TWZraGlQRkdxb2M5?=
 =?utf-8?B?QWo2Y2QySXNtVHVYSElFcnFCendJQ1ZhUzdZYUlhbkdZVWV1c1pwNTBKOXM5?=
 =?utf-8?B?dU0vblF4R3d0U1pyb2o3ZkRidWM0Q3B3Tnd3ckI0VFcrQTk5VVU4OUFRaE8r?=
 =?utf-8?B?VXhkYjRJMXd3ZFIxNGhROXZObFdCc1I4eHl1d1BuNDZnMTVDMXoxNU5QZHR4?=
 =?utf-8?B?emtMMFY5eGF6RUxaU3RpUy9oSzlXTlY1UmJhTDdFbFN1QkxXRVc4TUpZU0xM?=
 =?utf-8?B?bzFhODYwL1BhWDlXRHJjZ2k3SmVYZi9hZHVPb1dKMllTakNWdlFFOFE0SkMz?=
 =?utf-8?B?b3h0QzQwZWtuT3dUdEpoSnBNSWVLZDRSNkVRemhYRE1QSHV1bHkwN1pnaHVj?=
 =?utf-8?B?M3VRanRFZmVFMGVHR21Sd0p5LzVQLzdBNWZOR2pZcEhYcDJjQUx1Vm16TFZt?=
 =?utf-8?B?UzZ3NU1sRW0zZ1RLdFV0K2JTRmZDL1oxMkY4N25xUDIrRFMrbGhXckxPMVlY?=
 =?utf-8?B?VExCL2lBUGlWa1UxZklta09kVWcyckU3YVRwYWxyNjZJVEFSbkZhOE5CU3I5?=
 =?utf-8?B?TkFrSUg1b1VFcFE2RHhCQ1hWTC9oS3N5SzJsbDRqbUFEVWplYjd6b0FxOUVJ?=
 =?utf-8?B?SXovVHZITjR6STlJL3FQL0ZYZDd5QlkxNS92K0U1M2VwSWpiRWdKeUxTQkJm?=
 =?utf-8?B?SlRGWUoxOVpTcGF1SUZtS0ZmZ0c3azhiWGs3bnpsQW9VcHJRRU1iOW1HSy9o?=
 =?utf-8?B?RXdBcndHUXZHc3VmSXFWZWczWFl4N1NYNkNGMUovd3Y0ajVCbW00c2tlK2Iz?=
 =?utf-8?Q?RvhaBZeSc3IKB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3puVjBJMUFOUkdyT09rTUhrZkFoZVhQUFEvYVRTTFZVUUI2a2MzOCtlQ2U4?=
 =?utf-8?B?dFIxMnNyWk5McndrOGtTS1ViTTFNVWJmNkd6QkdEeFVHK3V2dVVqaDZNSjNG?=
 =?utf-8?B?ZTIzM0NFNHQ4MnphTldsTHAyVCtZUWU1bVRSaXcyY05aU0Q3bnFVRkxnbFIw?=
 =?utf-8?B?eU0yMVFKUDJBS01tWUtsckdrbjdMdG84ejhVeWhoc1VOeWxEU3IybWxqdkc5?=
 =?utf-8?B?L1IxVENrbFpMK0VTMDZ3UnRjaHBQSXRNVTEyOGdaNmtmMEJENGpwTFBIOExn?=
 =?utf-8?B?R3h2Wi9ya1ZHeEpUZnM0UXlrNUNIaXBtcnpod1pCLzlWdzNLcXhFQ1FEdk5L?=
 =?utf-8?B?UmFNRXFOSE1aOXUySDFBQkw3SG9KSjVYNTJ0NjY3ejYwYlM4KysyRUdMNitx?=
 =?utf-8?B?M1loZTlxM1Q4QzdVZkR0UzJSUmZKMExYMkx5WFllN0JiQjIzTTRyTVlsUFQx?=
 =?utf-8?B?VXViOHBZeFN3L013TXkzZjNVWEZ5UGVFb3hWSWNQMlBGYkRQWFYrVHQ5Mkht?=
 =?utf-8?B?WlExNlRFNGZLSllWa3hTYnBFN0FhZFRZTmJBVGdlTUhnNHlWK3NGTVc0Q0RE?=
 =?utf-8?B?alNrUzZHSE9zLzdGTFdPRzR4a0RGQmFnQlpSU0VUZE1XcVFnZHFZNWVpWWNP?=
 =?utf-8?B?SlBuK2R6N2xZZDRleDVBS09ubjc0S0NaL2FCb0Y2OXFCbEx6NW5QVDB6UFZD?=
 =?utf-8?B?Y2krOVVOZGpuRjhQaktCdnhSNlZBdUpUVjdwZ0FrMmE4RDFLL2pTc3prS3JY?=
 =?utf-8?B?ejVtV0RRdHVqWkc5WlF0NE81NXVZSDRmaUEyRVFaZ2ltNFpXa25JakpZTmdU?=
 =?utf-8?B?cG1uZHo1ZHp3Z2wvbWRQMGVjTVdHQVBKa3g5c1ZnTmRMckhvdFcyTXFQMDBh?=
 =?utf-8?B?K2p4Z1NnNUNoVE9oYjB5bm40N3ZwcThMUGJ3Z2ZWalRDNW5TVkxWZFMyTVN2?=
 =?utf-8?B?WTAzRnpEdTlmNmFBVDNsNG5yVjVzYmdBQ04vU3VRR1h6akFkY0RXbU1TMWZy?=
 =?utf-8?B?S3FaaHQ1SlNtZ2VpaktseGJ3TllVd01hVDdvaU5LbktVWnBuY3JoOTQwbkFR?=
 =?utf-8?B?QVA1Qmh6cUZVajhtRU51TjhLb2FUNkJIQlNURmZCR0JLSGZ6SkxNR005TWZy?=
 =?utf-8?B?YVNQdmFVdU4vQmhNamx1aTVKVjFFVVVEWlEwa2g0Y2FGbWc2c2pYb25UdjlK?=
 =?utf-8?B?NWd6VGxVNUJoVm5ZaHEwaFhubWo5RC9aMEQzRmJpZzNFKzNJK0I2Wm1vODZi?=
 =?utf-8?B?cW12TXhwSXRmai8ySzg3V0F0TmpVRVVHMnh2LzhTOVdkd2VmdGd0RnYvQjBz?=
 =?utf-8?B?aDFxdWtYb1RRZXFnRndLaE1pR3BXTFJNQXBZWkVaOUQ3V0tnczFLQ1JJY0l6?=
 =?utf-8?B?T0JGQkRTWDhSdERYV0FsQks2SG9TL1IwanorY2NzdHUyUm1RZnI1T2llZXd3?=
 =?utf-8?B?UFJSR0NndDcvWmNhM1JYb00rUEFnaWlLNW9ob2g3RGVsSzUwR1pvL3l1RzVy?=
 =?utf-8?B?NHpKN25QUjNVdVJIZXRJUzh6eU01YkJFMjVGWGFWRStnTEM0K0lBTll4Yy8v?=
 =?utf-8?B?aTNLQ0lUQmcvQjR3SGY0WFVuTlE2M1Q3YkJxZnRXMVlvV3pxYjkrY3czOWdX?=
 =?utf-8?B?TElvSkMwc1huekFSU3piNHd2QWpHZ1g5ZEN5UkJFWFVRK1R0a01jdkpOWlk3?=
 =?utf-8?B?dS83SFc0d1cwSGxzbEZrSUNHY1JWU2QrRjFNNDJLZS9kZS9sR3JOclFGdkVz?=
 =?utf-8?B?ZkI2L3h0N3RtVmh4WVdLbG00bVVIMjk5d2F3UkFVUG5iS3hhTk1hODgzQU5I?=
 =?utf-8?B?ZU8rZktXSmlNQ1Q0WnkwV0FJNklTYTdMU29VL0gxM3M0RkcrN0VRbWw3U2Vh?=
 =?utf-8?B?OHFVUjdkRUFEclF5ZkZMVTgrQklYR1JFbmNjN0syUHEvWXl2dE9sZDlqVEEy?=
 =?utf-8?B?OFFkT1RsYTNETW9LZ0FkTGxXSS92QVgvdzFvU2Z2eUdTRTdzTFlqcFRqQnRJ?=
 =?utf-8?B?NnMvVlJQZWI5RTlRWTVLMHp4a1JmYnlwb2I4STVnRjlzUTVhL0NGRnRwNzZC?=
 =?utf-8?B?YzlhdkYybjN1L1dNMVZjNGZpakxhWkZZRHk2dUVQNjE3eEpxa1RpQXdNSmIr?=
 =?utf-8?B?enptZXJRUlRPeU8zVVlJTWxBMU9yNzhxbWYwOVhHdTdYcWhXazJRbVhQeXBl?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C86CE951FC5C8D42A5BB2210B778B036@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KUN7eajxpIUZUPfuhMQr9D07Q9JL+n+sUqX8hq41RiZcP1JkZwJuAmXRVfeVPkoOxeO1irZYnmvfliAzW8yeZJhSEfIYhG+2a+vrRXFcamqhejzsEDdqipTwTIwq5HpLG68CKwuB1Iz2VHpzF57P44n99pJyKft+lEG+uRtoS2T2v89d7OjH4lZRXMs1mNdvwW5+aamOzhCayfGQWohlPB/w/Sj9xVgn7kiOy7H61pQcF46RcL7yf7Vfg6zEsa0vz+Wx4M6nVmDeb7CuxxI9SpC8MKkK5DGOUszY2nwqx8TBLQQxbhJnnyYfG6WxbG4Le+lk0nTef/nTerJjh0oXE6qdD8qpE2w10EZASRYiPrxXBwIgdv7hrFkHecvXFfyGS+pEmkthKrXQO1tJ8+QGGKU5UBFJ3FwNRrcCFH63gE0W3WsYTcS5K723mMn5VUH6JMjfbKeA//VEv75+YYX+SYwXxoB3hhyM99kRJujsTKCq9M1+tSC7Q6gyGWGkVdlRdRoTOpIJo+dlgVltAzu+aMgwnY+aKtkF+Ex87NgIZPqepeEgeJgT1bsn60AD8FE0jZlXT56tpdtdZIWgB757DlvwtX5FYaug/Qq7PIlNtzg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4671ef-0834-4901-c2ab-08dcf2950066
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 12:28:15.0290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVmFazn+t84j8SybKf1dvToYqhbhAi3USbmwpDqeBkTUHN9Szr4Kk5szL2ZgWfRwivmOH2+A9kdo2RAi66Vg2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_12,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410220080
X-Proofpoint-ORIG-GUID: 46HBMyEfWdxE2paq43JetgEr-GE9hiiI
X-Proofpoint-GUID: 46HBMyEfWdxE2paq43JetgEr-GE9hiiI

DQoNCj4gT24gT2N0IDIxLCAyMDI0LCBhdCA2OjMz4oCvUE0sIFJpY2sgTWFja2xlbSA8cmljay5t
YWNrbGVtQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIE9jdCAyMSwgMjAyNCBhdCA3
OjQ14oCvQU0gQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToN
Cj4+IA0KPj4gDQo+PiANCj4+PiBPbiBPY3QgMjAsIDIwMjQsIGF0IDc6MDnigK9QTSwgUmljayBN
YWNrbGVtIDxyaWNrLm1hY2tsZW1AZ21haWwuY29tPiB3cm90ZToNCj4+PiANCj4+PiBIaSwNCj4+
PiANCj4+PiBBcyBzb21lIG9mIHlvdSB3aWxsIGFscmVhZHkga25vdywgSSBoYXZlIGJlZW4gd29y
a2luZyBvbiBwYXRjaGVzDQo+Pj4gdGhhdCBhZGQgc3VwcG9ydCBmb3IgUE9TSVggZHJhZnQgQUNM
cyB0byBORlN2NC4yLg0KPj4+IFRoZSBpbnRlcm5ldCBkcmFmdCBjYW4gYmUgZm91bmQgaGVyZSwg
aWYgeW91IGFyZSBpbnRlcmVzdGVkLg0KPj4+IGh0dHBzOi8vZGF0YXRyYWNrZXIuaWV0Zi5vcmcv
ZG9jL2RyYWZ0LXJtYWNrbGVtLW5mc3Y0LXBvc2l4LWFjbHMvDQo+Pj4gDQo+Pj4gVGhlIHBhdGNo
ZXMgbm93IGJhc2ljYWxseSB3b3JrLCBidXQgaGFuZGxpbmcgb2YgbGFyZ2UgUE9TSVgNCj4+PiBk
cmFmdCBBQ0xzIGZvciB0aGUgc2VydmVyIHNpZGUgaXMgbm90IGRvbmUgeWV0Lg0KPj4+IA0KPj4+
IEEgUE9TSVggZHJhZnQgQUNMIGNhbiBoYXZlIDEwMjQgYWNlcyBhbmQgc2luY2UgYSAid2hvIiBm
aWVsZA0KPj4+IGNhbiBiZSAxMjggYnl0ZXMsIGEgUE9TSVggZHJhZnQgQUNMIGNhbiBlbmQgdXAg
YmVpbmcgYWJvdXQgMTQwS2J5dGVzDQo+Pj4gb2YgWERSLiBEbyBib3RoIHRoZSBkZWZhdWx0IGFu
ZCBhY2Nlc3MgQUNMcyBmb3IgYSBkaXJlY3RvcnkgYW5kIGl0DQo+Pj4gY291bGQgYmUgMjgwS2J5
dGVzLiAoT2YgY291cnNlLCB0aGV5IHVzdWFsbHkgZW5kIHVwIG11Y2ggc21hbGxlci4pDQo+Pj4g
DQo+Pj4gRm9yIHRoZSBjbGllbnQgc2lkZSwgdG8gaGFuZGxlIGxhcmdlIEFDTHMgZm9yIFNFVEFU
VFIgKHdoaWNoIG5ldmVyDQo+Pj4gc2V0cyBvdGhlciBhdHRyaWJ1dGVzIGluIHRoZSBzYW1lIFNF
VEFUVFIpLCBJIGNhbWUgdXAgd2l0aCBzb21lDQo+Pj4gc2ltcGxlIGZ1bmN0aW9ucyAoY2FsbGVk
IG5mc194ZHJfcHV0cGFnZV9ieXRlcygpLCBuZnNfeGRyX3B1dHBhZ2Vfd29yZCgpDQo+Pj4gYW5k
IG5mc194ZHJfcHV0cGFnZV9jbGVhbnVwKCkgaW4gdGhlIGN1cnJlbnQgY2xpZW50LnBhdGNoKSB3
aGljaA0KPj4+IGZpbGwgdGhlIGxhcmdlIEFDTCBpbnRvIHBhZ2VzLiBUaGVuIHhkcl93cml0ZV9w
YWdlcygpIGlzIGNhbGxlZCB0bw0KPj4+IHB1dCB0aGVtIGluIHRoZSB4ZHIgc3RyZWFtLg0KPj4+
IC0tPiBXaGV0aGVyIHRoaXMgaXMgdGhlIHJpZ2h0IGFwcHJvYWNoIGlzIGEgZ29vZCBxdWVzdGlv
biwgYnV0IGF0DQo+Pj4gICAgIGxlYXN0IGl0IHNlZW1zIHRvIHdvcmsuDQo+Pj4gDQo+Pj4gRm9y
IHRoZSBzZXJ2ZXIsIHRoZSBwcm9ibGVtIGlzIG1vcmUgZGlmZmljdWx0LCBzaW5jZSBhIEdFVEFU
VFIgcmVwbHkNCj4+PiBtaWdodCBpbmNsdWRlIGVuY29kaW5ncyBvZiBvdGhlciBhdHRyaWJ1dGVz
LiAoQXQgdGhpcyB0aW1lLCB0aGUgcHJvcG9zZWQNCj4+PiBQT1NJWCBkcmFmdCBBQ0wgYXR0cmli
dXRlcyBhcmUgYXQgdGhlIGVuZCwgc2luY2UgdGhleSBoYXZlIHRoZSBoaWdoZXN0DQo+Pj4gYXR0
cmlidXRlICNzLCBidXQgdGhhdCB3aWxsIG5vdCBsYXN0IGxvbmcuKQ0KPj4+IA0KPj4+IFRoZSBz
YW1lIHRlY2huaXF1ZSBhcyBmb3IgdGhlIGNsaWVudCBjb3VsZCBiZSB1c2VkLCBidXQgb25seSBp
ZiB0aGVyZQ0KPj4+IGFyZSBubyBhdHRyaWJ1dGVzIHRoYXQgY29tZSBhZnRlciB0aGUgUE9TSVgg
ZHJhZnQgQUNMIG9uZXMgaW4gdGhlIFhEUg0KPj4+IGZvciBHRVRBVFRSJ3MgcmVwbHkuDQo+Pj4g
DQo+Pj4gVGhpcyBicmluZ3MgbWUgdG8gb25lIHF1ZXN0aW9uLi4uDQo+Pj4gLSBXaGF0IGRvIG90
aGVycyB0aGluayB3LnIudC4gcmVzdHJpY3RpbmcgdGhlIFBPU0lYIGRyYWZ0IEFDTHMgdG8gb25s
eQ0KPj4+IEdFVEFUVFIgKGFuZCBub3QgYSBSRUFERElSIHJlcGx5KSBhbmQgb25seSB3aXRoIGEg
bGltaXRlZCBzZXQNCj4+PiBvZiBvdGhlciBhdHRyaWJ1dGVzLCB3aGljaCB3aWxsIGFsbCBiZSBs
b3dlciAjcywgc28gdGhleSBjb21lIGJlZm9yZQ0KPj4+IFBPU0lYIGRyYWZ0IEFDTCBvbmVzPw0K
Pj4+IC0tPiBTaW5jZSBpdCBpcyBvbmx5IGEgcGVyc29uYWwgZHJhZnQgYXQgdGhpcyB0aW1lLCB0
aGlzIHJlcXVpcmVtZW50DQo+Pj4gICAgICAgY291bGQgZWFzaWx5IGJlIGFkZGVkIGFuZCBtYXkg
bWFrZSBzZW5zZSB0byBsaW1pdCB0aGUgc2l6ZQ0KPj4+ICAgICAgICBvZiBtb3N0IEdFVEFUVFJz
Lg0KPj4+IFRoaXMgcmVzdHJpY3Rpb24gc2hvdWxkIGJlIG9rIGZvciBib3RoIHRoZSBMSW51eCBh
bmQgRnJlZUJTRCBjbGllbnRzLA0KPj4+IHNpbmNlIHRoZXkgb25seSBhc2sgZm9yIGFjbCBhdHRy
aWJ1dGVzIHdoZW4gYSBnZXRmYWNsKDEpIGNvbW1hbmQgaXMNCj4+PiBkb25lIGFuZCBkbyBub3Qg
bmVlZCBhIGxvdCBvZiBvdGhlciBhdHRyaWJ1dGVzIGZvciB0aGUgR0VUQVRUUi4NCj4+IA0KPj4g
R2VuZXJhbGx5LCBJIGRvbid0IGltbWVkaWF0ZWx5IHNlZSB3aHkgUE9TSVggQUNMcyBuZWVkIGEg
cmVzdHJpY3Rpb24NCj4+IHRoYXQgdGhlIHByb3RvY29sIGRvZXNuJ3QgYWxyZWFkeSBoYXZlIGZv
ciBORlN2NCBBQ0xzLg0KPj4gDQo+PiANCj4+PiBBbHRlcm5hdGVseSwgdGhlcmUgbmVlZHMgdG8g
YmUgYSB3YXkgdG8gYnVpbGQgMjgwS2J5dGVzIG9yIG1vcmUNCj4+PiBvZiBYRFIgZm9yIGFuIGFy
Yml0cmFyeSBHRVRBVFRSL1JFQURESVIgcmVwbHkuDQo+PiANCj4+IElJVUMsIE5GU0QgYWxyZWFk
eSBoYW5kbGVzIHRoaXMgZm9yIGJvdGggUkVBRERJUiBhbmQgTkZTdjQgQUNMcw0KPj4gKGFuZCBw
ZXJoYXBzIGFsc28gR0VUWEFUVFIgLyBMSVNUWEFUVFIpLg0KPj4gDQo+PiBTbyBJJ2xsIGhhdmUg
dG8gaGF2ZSBhIGxvb2sgYXQgeW91ciBzcGVjaWZpYyBpbXBsZW1lbnRhdGlvbiwNCj4+IG1heWJl
IHNvbWV0aW1lIHRoaXMgd2Vlay4gSSBjYW4ndCB0aGluayBvZiBhIHJlYXNvbiB0aGF0IG91cg0K
Pj4gY3VycmVudCBYRFIgYW5kIE5GU0QgaW1wbGVtZW50YXRpb24gd291bGRuJ3QgaGFuZGxlIHRo
aXMsIGJ1dA0KPj4gaGF2ZW4ndCB0aG91Z2h0IGRlZXBseSBhYm91dCBpdC4NCj4+IA0KPj4gSXQg
bWlnaHQgbm90IGJlIGVmZmljaWVudCBmb3IgbGFyZ2UgQUNMcywgYnV0IGRvZXMgaXQgbmVlZA0K
Pj4gdG8gYmU/DQo+IE5vcGUsIGl0IGRvZXNuJ3QgbmVlZCB0byBiZS4uLg0KPiBXZWxsLCB0aGlz
IGluIGVtYmFycmFzc2luZyAoYmx1c2ghKS4NCj4gSXQgdHVybnMgb3V0IGl0IHdvcmtzIGZpbmUg
Zm9yIEdFVEFUVFIgb2YgYSBsYXJnZSBBQ0wgKGVpdGhlciB0aGUNCj4gYWNsIGF0dHJpYnV0ZSBv
ciB0aGUgbmV3IG9uZXMgYWRkZWQgYnkgdGhlIHBhdGNoKS4NCj4gDQo+IEZvciB0aGUgY2xpZW50
IHNpZGUsIEkgY291bGQgaGF2ZSBzd29ybiBJIG5lZWRlZCB0byBkbyB0aGUNCj4gImZpbGwgaW4g
dGhlIHBhZ2Ugc3R1ZmYiIHRvIGdldCB0aGUgbGFyZ2Ugb25lIHRvIHdvcmsgZm9yIFNFVEFUVFIs
DQo+IGJ1dCBmb3IgdGhlIGtuZnNkLCBpdCBmaWd1cmVzIGl0IG91dC4NCj4gDQo+IEJ0dywgSSB3
YXMgb25seSBhYmxlIHRvIGdldCB0byBhYm91dCA2MEssIGJlY2F1c2UgdGhlIGV4dDQgZnMNCj4g
SSBoYXZlIG9uIHRoZSBzZXJ2ZXIgd291bGRuJ3QgYWxsb3cgYW4gQUNMIHdpdGggMTAwMCBlbnRy
aWVzIHRvDQo+IGJlIHNldCAocmVwbGllZCB3aXRoIG91dCBvZiBzcGFjZSBvbiBkZXZpY2UpLg0K
PiAtLT4gSSBkaWQgZ2V0IG9uZSB3aXRoIDQ1NSBlbnRyaWVzIHRvIHdvcmsgYW5kIG1vc3Qgb2Yg
dGhvc2UgZW50cmllcw0KPiAgICAgIHdlcmUgZm9yIDExMCBieXRlIGdyb3VwIG5hbWVzLg0KDQpJ
SVJDIHRoZSBMaW51eCBmaWxlIHN5c3RlbXMgaGF2ZSBhIDY0S0IgbGVuZ3RoIGxpbWl0IG9uIGV4
dGVuZGVkDQphdHRyaWJ1dGVzLCB3aGVyZSBBQ0xzIGFyZSBzdG9yZWQuDQoNCkVOT1NQQyBpcyBh
IGxpdHRsZSBzdHJhbmdlLg0KDQoNCj4gU28sIHdoYXQgY2FuIEkgc2F5LCBleGNlcHQgSSBzaG91
bGQgaGF2ZSB0cmllZCBpdCBiZWZvcmUgSSBwb3N0ZWQuDQo+IChPbmUgZ290Y2hhIGlzIHRoYXQg
RnJlZUJTRCBvbmx5IGhhbmRsZXMgMzIgQUNFIEFDTHMsIGJ1dA0KPiB3aGVuIHlvdSBsb29rIGF0
IHRoZSBwYWNrZXQgdHJhY2UsIHlvdSBjYW4gc2VlIHRoZXkgYXJlIGFsbCBpbg0KPiB0aGUgR0VU
QVRUUiByZXBseS4gTm90IGFuIGV4Y3VzZSwgYnV0Li4uKQ0KPiANCj4gVGhhbmtzIGZvciB0aGUg
cmVwbHkgQ2h1Y2ssIHJpY2sNCj4gDQo+PiANCj4+IA0KPj4+IEJ0dywgSSBoYXZlIG5vdCB0ZXN0
ZWQgdG8gc2VlIHdoYXQgaGFwcGVucyBpZiBhIGxhcmdlIFBPU0lYIGRyYWZ0DQo+Pj4gQUNMIGlz
IHNldCBmb3IgYSBmaWxlIChsb2NhbGx5IG9uIHRoZSBzZXJ2ZXIsIGZvciBleGFtcGxlKSBhbmQg
dGhlbg0KPj4+IGEgY2xpZW50IGRvZXMgYSBHRVRBVFRSIG9mIHRoZSBhY2wgYXR0cmlidXRlICh3
aGljaCByZXBsaWVzIHdpdGgNCj4+PiBhIE5GU3Y0IEFDTCBjcmVhdGVkIGJ5IG1hcHBpbmcgZnJv
bSB0aGUgUE9TSVggZHJhZnQgQUNMKS4NCj4+PiAtLT4gSSBoYXZlIGEgaHVuY2ggaXQgd2lsbCBm
YWlsLCBidXQgSSBuZWVkIHRvIHRlc3QgdG8gYmUgc3VyZT8NCj4+PiANCj4+PiBUaGFua3MgaW4g
YWR2YW5jZSBmb3IgYW55IGNvbW1lbnRzIHcuci50LiB0aGlzIGlzc3VlLCByaWNrDQo+Pj4gcHM7
IEluIHBhcnRpY3VsYXIsIEknZCBsaWtlIHRvIGtub3cgd2hhdCBvdGhlcnMgdGhpbmsgYWJvdXQg
YWRkaW5nDQo+Pj4gICAgIHRoZSByZXN0cmljdGlvbiBvbiBhY3F1aXNpdGlvbiBvZiB0aGUgUE9T
SVggZHJhZnQgQUNMcyBieSBHRVRBVFRSLg0KPj4gDQo+PiANCj4+IA0KPj4gDQo+PiAtLQ0KPj4g
Q2h1Y2sgTGV2ZXINCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

