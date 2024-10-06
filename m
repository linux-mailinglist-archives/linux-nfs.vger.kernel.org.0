Return-Path: <linux-nfs+bounces-6898-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF56991FB1
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Oct 2024 18:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F5F1F21B10
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Oct 2024 16:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B5313BAF1;
	Sun,  6 Oct 2024 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pzhb3QJB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g1nxhKBr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D94101C4
	for <linux-nfs@vger.kernel.org>; Sun,  6 Oct 2024 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728233128; cv=fail; b=HQ0SqkIHMSrnEVZTUqRrhc8PNLD+IUH/0wuDQn92kE9o5l/hNkvQ704DRNYlUfREUUPyV/CLqiw6f//3wYGMgpYuZ16XfmmaTOqQUYeJ3D5pOgQc3hxwidu6BbTIAD5bqrYTzKiOdHTWGodY074mTtc4RXUzx36G/pZdv7YwP8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728233128; c=relaxed/simple;
	bh=JXpTSjtfwExppJKvE9PTk99kE0p1QOuhJJTmZIDyO6E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=htlAaLOtTe9qFQ4diM4tfbUkFSPxNoSAJWOOjom3/eF2IWM8LUCQ/a/tvQyiS/B0fWB+bsk2zUiuCXpCrZKsABEWoop4pqUMdbcWc4FhCC/SHEg0A2VNIp5BOnjjUWVSN084KLo0M18pPha2q5Q5X16V43mPr723jATHMaF6y7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pzhb3QJB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g1nxhKBr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4965lKwP027238;
	Sun, 6 Oct 2024 16:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JXpTSjtfwExppJKvE9PTk99kE0p1QOuhJJTmZIDyO6E=; b=
	Pzhb3QJBF37CqK2PQnrTij9vBQMGSZW8CscDb1Zye9b1wySpR7ds7UoxFAp4/TMI
	Oyd6EK8Itsz79EbXbx2vJMJw1rk0VUYGDk3kqwijkGTLIhbVEt5NZMfmYS0AIV6e
	D6TSRwQ32c7h58Lt0wWtTnL4cz9CKLuNRTZczegytBD5NfPYPKI9CFTslFCAk1g/
	XUmDmfn0YppcbC3tJeVPJn4ObCzyPlp2KyLezznknKQAPrkWZwMmP6Vzsx+PSq6V
	y0fke+LGZnz4uKmvCRs9EBAIUHw6z5WeBx6wa0JfnrbeO47q0DoKu83+u1WSc+Z7
	oexgFC3/BvG2Uov6fJkDBg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300dsavg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 06 Oct 2024 16:45:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 496Ft1va004587;
	Sun, 6 Oct 2024 16:45:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uw4ynnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 06 Oct 2024 16:45:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAQrSwT2zBckMFmU6bjQRPBzhZFnoTDwJkVUe1XgNz7fsML5tpcVl2EeWrarTsr6vW8abBdbB7MOMSz2phYEpDBGKXdjKstpN7RVSEIuFmDx1jiEvA2/XM/CZbkyESyy6zZyP1wFPPIaRsJBlVc9GmqRjwtzxcyPPX8KSjCxZulFmdnUNXnpeXInORM6ymCgF6LlPfeSN8H+CpkROXLQPI89qlMqdPNYql/n1dmz8g7M5xd7pJv/KmtkrP4T/ySoy9qoyw+Wlru0NWGQ1AAtX+5ggSMeVVxWBVGEwNtyFKaj3NmfxOU42rUM0sblxq7BZrfPLFWwKJKrrkgM15Qrog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXpTSjtfwExppJKvE9PTk99kE0p1QOuhJJTmZIDyO6E=;
 b=dsZlYwKlZpyXJXaoydA3+WelXY2N3WU+N/UrQprHnT9kVTl7dOKOgQu2o0BDKNt3R3Y0rANkJh7IeGNrVLiuaZTpypSVeVStR4F3iQWJ2W0GgcZzhQjOU7icKmQq9Op5Eq4HzEViMTSV0tDOUHR0GG6zrQLw9qJqcNuvq6qSFCbJSbnBjRvJMsC9I4DhGA7Qm1QHK+uNcnPbBal/e02ajXoWQ+69qLakTw2wPdoY3vfWqzKLk7OmG3xQR3NjnFRHN01vhW/c+iy8YvGnIW4lp+HEZR2DrIlcx3v/Kp2qy4NMZ5Vn+j2Y+i7OfbJhU8szU3n9TbtN1uYKoBP9JcXFXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXpTSjtfwExppJKvE9PTk99kE0p1QOuhJJTmZIDyO6E=;
 b=g1nxhKBrreZOap5AjQBeYzkTdbA19H0Io0acq6YzaBA9F7TEZKa6cPGbPv5EPn0gHnh4Mh98nx03jaKy8C83MzYWLk3D4xf4wnOX6aRIGNV0ASNdOh+v4x8XcO4WiAKy8BmIwILkavvbD9lewI8Z6n+0bk6I+sFZCm2OSs6t8r8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4753.namprd10.prod.outlook.com (2603:10b6:303:6f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Sun, 6 Oct
 2024 16:45:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8026.020; Sun, 6 Oct 2024
 16:45:16 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Cedric Blancher <cedric.blancher@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Volker Lendecke
	<Volker.Lendecke@sernet.de>
Subject: Re: New NFSv4 export option "HideFilesBeginningInDot"?
Thread-Topic: New NFSv4 export option "HideFilesBeginningInDot"?
Thread-Index: AQHbF7yjzOq5uj7gQ0i2aPhxNpKfhbJ57rYA
Date: Sun, 6 Oct 2024 16:45:16 +0000
Message-ID: <A3CACCCC-93B4-40DA-B5C8-19B75EF9AC3A@oracle.com>
References:
 <CALXu0Udt5hBgD2vBsface_ezCz-U8Oz=XhrefK=UxSO4o3TMvQ@mail.gmail.com>
In-Reply-To:
 <CALXu0Udt5hBgD2vBsface_ezCz-U8Oz=XhrefK=UxSO4o3TMvQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4753:EE_
x-ms-office365-filtering-correlation-id: 9e84101f-615f-420c-69f1-08dce62641da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WGx1aTl4M0dXNTNDTFJsZzVEZUY1L01uVjZaVlREV3o5Y2YrdnFTcHR1am5B?=
 =?utf-8?B?ZDR6UkJiRzlJcWtoWU1ENFZmd3hjd1BzT29tZmlOcS9ZczBzUmRiZkp6NVdx?=
 =?utf-8?B?S1F2RGhZaWlLOU00bWx0ODhQeUd2L0MwZzVPcWhKd0xTZVl3UmNBK2QrYjJU?=
 =?utf-8?B?ek5JUlZXMi9JWVRXa0psZFlSbUN2OTZHNjU5ZnQrYU80ZGdLVlhReWUwRmQ2?=
 =?utf-8?B?aEVIblJRakNvV3cxbnNSTjZTZTRZMWprWlBoNzY4djFUL3hnMmNwcGpKQzdV?=
 =?utf-8?B?L2hUelRxODUxdTUxNkcyc0lxVDVoY2tPS3J2V2V2V0JFU1c3eFJFUzV3V0JI?=
 =?utf-8?B?a0l6SCthZXFOdzJHS29CTU1sdGR6VVRxK1Rtd3ZTSG4xYU8zWnVSTG5NTzNv?=
 =?utf-8?B?NHY2aVh0UVFwU1BJa0hLRjV3QjlyNHBjSnF2UENhN0hMSitYcXhQMzRNVnFp?=
 =?utf-8?B?dEFSUFEvd25wQ2J1UDZCeUQrMWxDSmVxODExYXNKa2h5ME5yQmFFVk05bEZK?=
 =?utf-8?B?N2IxWEd2UkhVK29tNDhYRjRGZE5xZE9vZzBPQm82cjZtL3p4R1BNL2s2cCsr?=
 =?utf-8?B?aTNJQzZ4emQrby9POUxVQWcwYm81ZEpSYVR4anZZdmxyYkgrdkFOTjVqYTgv?=
 =?utf-8?B?RFd4Znc5SGh2Nkk3YWxSRHQvZ3c3YXJ3R0xiSUhDMzNUTGZ5Rk0ycjRNUUhv?=
 =?utf-8?B?UWdoUUJXMzMwWTBCVyt1YTZQU2FFcUFHbnd3S3Q2ZHJiejQzQXU4RVVmZk5n?=
 =?utf-8?B?TEZ0dHRmeGVac1d1UkN3ODhsandLNzQ0WndXRno5U0ZQWmlLV2VHQUZMUlVx?=
 =?utf-8?B?UXNJa0NSemtjYzcxeGd0UVhJNDZZQ20zT0xySGMwL2Rway9EeS9aVDB0N1ZP?=
 =?utf-8?B?V0kvOHV0R29YVVNtQVl1Y0trRVZaYlFSa2RyZHVXOE1weG45OHFvdlVsVG5L?=
 =?utf-8?B?WmhaNkxKT2xFN1c5bDB5SU54UGdiZ0UxRW1ZNE45a3R6OThlbXhweHUwQ2to?=
 =?utf-8?B?L0NUcGQ0azlyb3J4NUtlczVTNnBzaktKYjNjUkNBQWtMQXpVbW03WVV5Unho?=
 =?utf-8?B?aElHOGlZN2x0eDAvRDFKSWR0Zm5IVktuaFVEbUlQMUk1bmMxYy9WQXJ3SGZz?=
 =?utf-8?B?Zkh1Y3NzM0Fnc24rQlRtUXNZMVIvRzF6QnRFU3ArWGtJaHJnbUx6SDZadmN2?=
 =?utf-8?B?c0piMm90WUtYSjlnNC9JSHNsdmpoZnRObGRtbkdBbUo1RXB5cGtNakt6UDRM?=
 =?utf-8?B?Ym1BMXFiendmUVlwNFFib294SkF1NHZ1Q09DemRHL2p6WGVwdWxDa0laMGx4?=
 =?utf-8?B?dXdVVU1zT2lNclJ5dUhheXU4UkpYQnppZG96K0hQaTlzUzdjK09mYjE3Yzlx?=
 =?utf-8?B?YUxuRjU5SGVZRjhYUGZQSmJ1b04wZit1UXVRYzhRSGhvNTRZWWN4QmlQSHB0?=
 =?utf-8?B?TFpXUStENW9Fbm1xUWRFYktWaWd6S284Rzhla0ZNL0ZDeGFzUmxySzE2K1dP?=
 =?utf-8?B?RklBYWw3NnRFbVMwZm1LOHcxcDRQZytVSitVYUwrOUVvRHZoMHo1MzZnRWlO?=
 =?utf-8?B?YktTNTBXRWN4TEZ5VmY1MmlRemg1MG1ROENvYVdJQ05lMnpEM1k0dHRCR2pa?=
 =?utf-8?B?bDhjZnUwVk9mYUFIRFEvN0dTa09SdStzOWZhTEFGQ05oN1MwU3NabUlJNDdV?=
 =?utf-8?B?OUxZSElTUUYyYW5LMHpMUFdGZmg0UUhtZGJtUjJMUlJ6ZkIrUlNYRjBXRWZi?=
 =?utf-8?B?cXBTYVdRT2tKVDdDWjBWNDFXNS9rUzlSRlBwZGR5eXpUN3p5dXphcUhWSUdG?=
 =?utf-8?B?RTY2UkZLc1dhS05oWXhGUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ykt3SGt4T0FlYzJhUElKbWlTWTBpdXJIOVFYMElvS2RGcXlEY1pINTk4VDl0?=
 =?utf-8?B?NkxndjJKZFJocmEwZzJzUElqcWFpSWxJVUtHbWN4MGx1MElZa25IdzhVSlcv?=
 =?utf-8?B?NTc0VjNaQ0U3cDhFVXdpNDJsb3BSSDVXeTk1SG1wZVVGTjFzVnNQREo2N2ln?=
 =?utf-8?B?TG1ETFB5Ri9xTHg0djMwRnlEWnRDVXhwN3NoN081QS9DenM1RnczcHg4bzc5?=
 =?utf-8?B?MElxblJ6bFVWRmVHRG1DV2gxQWlJSWcxcXVERTc0NEhkblh2VTlLY1lvRFF1?=
 =?utf-8?B?d20yYThKTERkRHdUd0NaS1hNb2Z1aU95Vm5ZcjF3dUNoNFZiQkN5dzgzYkdv?=
 =?utf-8?B?K05GZSs1OWQ3SUdCUzhpSUhtQnRmZk9XOFVCV1RselYyYW1xaEpCUlV5MC94?=
 =?utf-8?B?SStkVTZSQjBZalF5dm16UHkxMW1wSkpkNmpDREptNGZQd2V0WEgyUCtzeW40?=
 =?utf-8?B?ZmtUQlF3WnpYTzZKWXYwdUczdmJiOUR3dTcyblRZL1JldTFOc0haWnJJUTlh?=
 =?utf-8?B?WlBxRDNEYzR5WGlhR2lHOGpTQm9JbE93UnhYbXhqd3dyaUFmdGMrb0dveDRk?=
 =?utf-8?B?Y01iUTZvamJQaHJCYzZFbkZXZ0x2a215cDhPNkdCR1FHenRuVmh0cnpwWDNm?=
 =?utf-8?B?OU8wQ2ZjU3BWZk03ZThJTVdVQm9WcGkwWmtveFpoTzh0MVFkcklFZ3JuTSsz?=
 =?utf-8?B?VzZaMU9wSm5UWWtvSTd0ZG1FR3hJWk1uRWtmSjh0ZUFTQTQwUkk0bnovSUh3?=
 =?utf-8?B?TTNTcUppOEVRR01pSlQwd3d6YW5vR3BGRElIZ0dYU0NlWk5CYVFBWjdobys2?=
 =?utf-8?B?ekJ2aWpIckJtNmhDZ2c3Q0FYWHIrWlRJVzJYTWVaZUtuMlZYdEo4WUVqeFR6?=
 =?utf-8?B?QUtiS0VhTDRjOVVPa2x4RmFFWXhRTnlmMnJmN2ZJWTJ4ZXd6ZDA1ZUt5UERC?=
 =?utf-8?B?bDEzTi9yRTh0ZXZvK3YxSUlYQmpwL3k3aUx4OUxjQmZoZWIxNGRrT2NsWGJ6?=
 =?utf-8?B?QTRMWTRSRkFwa3h3L1M0aStoZGtvM3NRVCtjeHRBVDh0bFhRWjdud29xc1Bo?=
 =?utf-8?B?R0g5eHloR1kyWkd0SXZ0MWNMYTJBQlRDcXQzMitJL1JVTURnNDVqM1RqWlR2?=
 =?utf-8?B?ODdtYVgwc1BKYTExbGJXdXkyekdzS2ZmRm1FbFFxdG82Y2x4NmNHQ0dKRHJU?=
 =?utf-8?B?Y3I1czNaZm9ZbGVNT2FnbnB1VHhVa0VZTVhDYXBsRnRyd3NsTTN0ZlRya3E0?=
 =?utf-8?B?SVgwNTR5YjhUZWpJdDBPc1BoN1pxSHczWkpjdDEvQnJ1L1Y0T0dzMmJlZjFV?=
 =?utf-8?B?RVpuSmJjbEMyVEp4WUp4dkhMK2xQVHNnYVlITGJvODlKWVpZTWx2TGhyTlZm?=
 =?utf-8?B?V0h4cGxpOGRxdkFuTFZLRUNXaFRYNFQya09qZER1Ry92NVlpZzgweDlrZkYz?=
 =?utf-8?B?anhWa0VMYnpEbDIwdDNaMTVpTGRoZHpJa20xMEFnUXNtVFJkZUtJVzBUNkQv?=
 =?utf-8?B?YlE0WXhjZUkxVVF6cHpCUGl3TmJHY3J3NEE4MnFEaFA5ZUd0YXhkK0JYSmdE?=
 =?utf-8?B?Q09XSXJJVFlIdDRmTXpJc1hsY0FBTjYrYnZGTHRjYWkxajVzUU9rUFNzYWox?=
 =?utf-8?B?Qk9sUFNhMHpjQmMxTDlxRnlvL1MvUGNDR29LM3FYd2o0d0dqc0FVYW9zZXZW?=
 =?utf-8?B?OGtmWEZwSkxhYnVJS284bHJ2UEZreXV4MVVFcDRIRUNOVjRjVjVYbXhseVpH?=
 =?utf-8?B?NUpGSzhMb2lnekc1OVlRNjFwMjJGM3NvamttcFhIdWJJcEluZ3JLcTNYL2Zq?=
 =?utf-8?B?a2J5VytlSmE5dVV0WFhEYUpkTUZiMm1EeDA2QWJGQWNQWVkvRTFoSFZHeEk5?=
 =?utf-8?B?aWZwVjFXN0Z3OW5xN1psaUNTTWRMSVR1eklMa1Boc2R0Q1EzZ3hzSEp1alB0?=
 =?utf-8?B?S21uUXc4aFFpMSs1amJSeEROdmZvN1lXNXdMSGhQK1NoN3hlWGhNVUpRMTUy?=
 =?utf-8?B?VVdMQUpFb0huUzhiSC9Ld1FiRDlzVjJ2ajFEODRVWUIwSlFUZ3JNRXhlR0Vy?=
 =?utf-8?B?WXg2VXBIWHlzUFl5dFR5WnZvNVVwWG9GRkpTTFVpVTNmdkJoaDdrQXNsNFV6?=
 =?utf-8?B?bFJQcjUxRis5WE03TkFQT0ZzcHRpZzR2azY4bk5TdXJHT2kvR2duVEZIRk9N?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <865BEDF3F1236A4B9AFF066682DCBBDB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uMSsqU+xLgMdND5y3PXVpVFCXCiVCgkE8pRdcIWvYvrzlpKM2/sLecdcg7c8h779erGvLt30Q07kdOnbDicdueHa+vTMPXZiForlCesyqSqflhXhXuxK0YJ8QnSqf+gUTi39k8BFfIDeaicsbInw79XpNG99SFUVq/RKjLobghIVNuu7Od7lKJ+TZOpbVKiL4jtGPEKHojedNI71Hv/u1nu+c7P1f5XcLkUrFi+qu5UVPLBsFjHS36gDZ7MUEY2T5itfxn3FgfJQ8K3/B7WXpJHfqyFAEFMz2xFe9OKwjWbP85ewpu2HC07dO7k6AZwhWC08EPr/ommbv1RxAHbftr8oSm3oaAHcni/MXgupM+yPKukxsER8xx9LWwpok9cWx12H3O5d2cpJ+QSXVPZYoIj4mVy/YOooonvBWwbtBqjOk5O43zPk/BL/UJLBV4+sVWIc8iEzA+Uq+rjdKuPq40tVbsaIuhdasyHFTMW5wWsVX1R+fm5phPR87gZW5X5ZxngQbsbJT6JXZ1ij6CdlCjuoocfVv69IFxYvqMVHiwl1QFF5d6sLC1E1vDG8ppfR8QAyejwEIhW5nraAmA7jDVi0u3UbY4OKxNR0I8eiXFo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e84101f-615f-420c-69f1-08dce62641da
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2024 16:45:16.7310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jj1TKTjuYyoLvT+bfim31R0utiNV9GeZFp9bSUE9AfxKHzACe9VvXJPVUXa47ZRIvs5RH64JItJBhELF2WL0Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4753
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-06_13,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410060121
X-Proofpoint-GUID: D1ahUlsGBzI2OSBtbmsMq1ztwtxdnuLW
X-Proofpoint-ORIG-GUID: D1ahUlsGBzI2OSBtbmsMq1ztwtxdnuLW

Q29weWluZyBWb2xrZXI7IG1heWJlIGhlIGhhcyBzb21lIHRob3VnaHRzIGFib3V0IGhvdw0KdGhp
cyBtaWdodCB3b3JrIHdpdGggU2FtYmEgb24gTGludXguDQoNCg0KPiBPbiBPY3QgNiwgMjAyNCwg
YXQgMjo1M+KAr0FNLCBDZWRyaWMgQmxhbmNoZXIgPGNlZHJpYy5ibGFuY2hlckBnbWFpbC5jb20+
IHdyb3RlOg0KPiANCj4gR29vZCBtb3JuaW5nIQ0KPiANCj4gV2luZG93cyBTZXJ2ZXIgMjAyMiBo
YXMgYSBORlMgZXhwb3J0IG9wdGlvbiBjYWxsZWQNCj4gIkhpZGVGaWxlc0JlZ2lubmluZ0luRG90
Iiwgd2hpY2ggc2V0cyB0aGUgTkZTIFdPUkQwX0hJRERFTiBmbGFnIGlmIGENCj4gZmlsZSBzdGFy
dHMgd2l0aCBhICcuJyBjaGFyYWN0ZXIuDQo+IGh0dHBzOi8vbGVhcm4ubWljcm9zb2Z0LmNvbS9l
bi11cy9wb3dlcnNoZWxsL21vZHVsZS9uZnMvc2V0LW5mc3NlcnZlcmNvbmZpZ3VyYXRpb24/dmll
dz13aW5kb3dzc2VydmVyMjAyMi1wcw0KPiBoYXMgc29tZSBkb2N1bWVudGF0aW9uIG9uIHRoaXMu
DQo+IA0KPiBXZSdkIGxpa2UgdG8gZ2V0IHRoZSBzYW1lIGZ1bmN0aW9uYWxpdHkgZm9yIExpbnV4
IG5mc2QsIGVuYWJsZWQgYnkNCj4gZGVmYXVsdCAoIk5vSGlkZUZpbGVzQmVnaW5uaW5nSW5Eb3Qi
IHRvIHR1cm4gaXQgb2ZmKSwgYXMgYSBtb3VudA0KPiBvcHRpb24uDQoNCkknbSBhc3N1bWluZyB5
b3UgbWVhbiAiZXhwb3J0IG9wdGlvbiIgaGVyZSwgbm90ICJtb3VudA0Kb3B0aW9uLiINCg0KSSdt
IG5vdCBzdXJlIHdoZXRoZXIgZW5hYmxpbmcgdGhlIG5ldyBiZWhhdmlvciBieQ0KZGVmYXVsdCBp
cyBPSywgYnkgTGludXggcnVsZXMgb2Ygbm90IGludHJvZHVjaW5nDQpiZWhhdmlvciByZWdyZXNz
aW9ucy4gV2lsbCBwb25kZXIuDQoNCg0KPiBCZWZvcmUgSSBzdGFydCB3cml0aW5nIGEgcGF0Y2gs
IGFyZSB0aGVyZSBhbnkgb2JqZWN0aW9ucz8NCg0KTm90IGFuIG9iamVjdGlvbiwgYnV0IGhlcmUg
YXJlIHNvbWUgdGhpbmdzIHRvIGNvbnNpZGVyDQphcyB5b3UgcHJvdG90eXBlLg0KDQpZb3UgbWln
aHQgYmUgcGxhbm5pbmcgdG8gc3RvcmUgdGhpcyBub3QgYXMgYW4gYWN0dWFsIGZpbGUNCmF0dHJp
YnV0ZSAocmV0cmlldmVkIHZpYSB2ZnNfZ2V0YXR0ciBvciB2ZnNfZ2V0eGF0dHIpIGJ1dA0KaW5z
dGVhZCBORlNEIHdvdWxkIGNvbnN0cnVjdCBhdHRyaWJ1dGUgMjUgYmFzZWQgb24gd2hldGhlcg0K
dGhlIGZpbGUgbmFtZSBiZWdpbnMgd2l0aCBkb3QgYW5kIHRoZSBuZXcgZXhwb3J0IG9wdGlvbiBp
cw0Kc2V0Lg0KDQpPbiBMaW51eCwgZmlsZSBuYW1lcyBhcmUga2VwdCBpbiB0aGUgcGFyZW50IGRp
cmVjdG9yeSwgbm90DQp3aXRoIHRoZSBmaWxlOyBhbmQgbm90ZSB0aGF0IGEgZmlsZSBjYW4gaGF2
ZSBtb3JlIHRoYW4gb25lDQpuYW1lIChkaXJlY3RvcnkgZW50cnkpIHRoYXQgcmVmZXJzIHRvIGl0
Lg0KDQpUaHVzIGl0IG1pZ2h0IGJlIGRpZmZpY3VsdCB0byByZXRyaWV2ZSB0aGUgZmlsZSdzIG5h
bWUNCmluc2lkZSBvZiBuZnNkNF9nZXRhdHRyKCksIGxldCBhbG9uZSByZXRyaWV2ZSBpdA0KZWZm
aWNpZW50bHksIHNpbmNlIEdFVEFUVFIgaXMgYSBmcmVxdWVudCBvcGVyYXRpb24uDQoNCllvdSB3
aWxsIG5lZWQgYSBkZXRlcm1pbmlzdGljIG1lY2hhbmlzbSB0byByZXNvbHZlIHRoZQ0KYW1iaWd1
aXR5IGlmIHRoZSBmaWxlIGhhcyBtdWx0aXBsZSBuYW1lcywgb25seSBzb21lIG9mDQp3aGljaCBi
ZWdpbiB3aXRoIGEgZG90LiBNYXliZSAtLSBvbmx5IGlmIGFsbCBvZiB0aGUgZmlsZSdzDQpuYW1l
cyBiZWdpbiB3aXRoIGEgZG90LCB0aGVuIGl0IGlzIG1hcmtlZCBISURERU4/DQoNCllvdSB3aWxs
IGhhdmUgdG8gZG8gc29tZXRoaW5nIGFib3V0IFNFVEFUVFIuIFJGQyA4ODgxIHNob3dzDQp0aGF0
IEhJRERFTiBpcyBhIHIvdyBhdHRyaWJ1dGUsIGFuZCBJSVVDIHdoYXQgeW91IGFyZQ0KcHJvcG9z
aW5nIGlzIGEgci9vIGF0dHJpYnV0ZSAtLSBjbGllbnRzIGNhbm5vdCBjaGFuZ2UgdGhpcw0Kc2V0
dGluZyB2aWEgU0VUQVRUUi4gSSdtIG5vdCBzdXJlLCBidXQgcHJvYmFibHkgTkZTRCdzDQpTRVRB
VFRSIHdpbGwgbmVlZCB0byBjbGVhciB0aGUgSElEREVOIGJpdCBhbmQgb3RoZXJ3aXNlDQppZ25v
cmUgaXQuIEkgaGF2ZW4ndCBmb3VuZCBhbnkgc3BlYyBsYW5ndWFnZSB0aGF0IGFkZHJlc3Nlcw0K
aG93IGEgc2VydmVyIG5lZWRzIHRvIGJlaGF2ZSBpZiBpdCBzdXBwb3J0cyBhIFJFQ09NTUVOREVE
DQpyL3cgYXR0cmlidXRlIGJ1dCBkb2VzIG5vdCBwZXJtaXQgaXQgdG8gYmUgbW9kaWZpZWQgYnkN
CmNsaWVudHMuDQoNCkdpdmVuIHRoZXNlIGlzc3VlcywgcGVyaGFwcyB0aGF0IGV4cGxhaW5zIHdo
eSB0aGUgTWljcm9zb2Z0DQpkb2N1bWVudGF0aW9uIHlvdSBwcm92aWRlZCBzYXlzIG9ubHk6DQoN
CiJTcGVjaWZpZXMgd2hldGhlciBhbiBORlMgc2VydmVyIGNyZWF0ZXMgZmlsZXMgdGhhdCBoYXZl
DQpuYW1lcyB0aGF0IGJlZ2luIHdpdGggYSBkb3QgKC4pIGFzIGhpZGRlbiBmaWxlcy4iDQoNClRo
YXQgaXMsIGl0IGFwcGVhcnMgdGhhdCB0aGUgV2luZG93cyBzZXJ2ZXIgc2V0cyB0aGUNCkhJRERF
TiBhdHRyaWJ1dGUgb24gdGhlIGZpbGUgaW5vZGUgYXQgY3JlYXRpb24gdGltZS4gVGhhdA0KaGFz
IGl0J3Mgb3duIHNldCBvZiBpc3N1ZXMgZm9yIExpbnV4LCBzaW5jZSBvdXIgZmlsZQ0Kc3lzdGVt
cyBkb24ndCBpbXBsZW1lbnQgYSBISURERU4gYXR0cmlidXRlICh0aGF0IEkga25vdw0Kb2YpLg0K
DQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

