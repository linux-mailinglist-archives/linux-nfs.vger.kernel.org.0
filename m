Return-Path: <linux-nfs+bounces-6065-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F10299669DA
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 21:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D7A28298B
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 19:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F901BDAA3;
	Fri, 30 Aug 2024 19:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RGK5FmiX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L6WrGN2K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1487233CD1
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046317; cv=fail; b=If7AtktN6Xv/YL1J4gWu3jGD1ZdpiSbJtOxZQ77UDXwuhzrEeutkhv1ufmd2kIkEK08XgA9Btd0HcQ8wJrywHz40vXWTyp3gT5qYDJOwOWSFFWhGiiK8XXj4YHACuGn37e0i0IWlI6Ujs8/XGqFJyzCKUj9SE+ClxCp1xwxgo9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046317; c=relaxed/simple;
	bh=LnGisyOlxB0hZUKoqTAm/RVIdEzkvAktM754dSFRdyU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jw6uJAdJKjARvdMvmjbSM4eR4H8VB8HCStrX+H4QNZdkPqCso2WosmILbekpNmXzfo2oCDVDsLq6TgIwYS0uckkHfaixi0PY5zhD1lrO0IdRwNoKD9evTsiHOqubKdPmrgLQTjtsrWjRtxmMFhpcdAkMNoiZ/Kz4FgzfXrmyuAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RGK5FmiX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L6WrGN2K; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UInOqV007936;
	Fri, 30 Aug 2024 19:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=LnGisyOlxB0hZUKoqTAm/RVIdEzkvAktM754dSFRd
	yU=; b=RGK5FmiXdojeAVOrpfA5vj+wj/VsIox31zuRFVnwqtzvwWI7LiF7rRPuz
	yqcsHDySY0silMZDUhdAQ8XYjk5s5Q1vnubCrdoTZsXg7MKZA9Gkaj+mU0jy9gdI
	9VPF4M1l5aa4RCHmEprDrC/hPGVWO3qZcSDK6nb8xLnjbETn/CnPf7HF0hmBj57y
	pulgf+mMPtBZx+COAnWSK+7pNopibubvLWpv3LluPevb6g7f9cLgjKYM2+F0adtK
	7myM/NApYpq+pLp5KarptlbJHqvjQcEX7+say3qEXX7krWnXxSTiXzHYuxEogocd
	XEvcuQjMsa5a8SwlFapEJx0ay2scw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bkcr834a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 19:31:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UJQkhK034765;
	Fri, 30 Aug 2024 19:31:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189sxsu7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 19:31:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CK+bpDPabH9EIdBRvWPPvrv8z5RrOm55e0xKNmdMNl9fD+QQulkgRf7KSbArEZUHGO+GCVH59fo+vsbsuANdD4U7FUePKuTW1UPhBhfSpeyaWqR1qYi7QfrTkdClngpKVQHCtB4LiVcOKbqcO5C/hhqcoC4MVI7GN0T2lY3mNBf0Gxf+Dufq15FqTwUzJRX2YgcQYW2iPYefPETB9+9DTI4jGblXQMKacRJACib0iW0u87UEYVDglbtprqux+jrCgEohcmUvlO5IJ2C+dM1zV79R9xdS+zmNEmpehKdZBjRuOnu0Am/304PkMO8bxDU/RuQI0jciMb999UcsP5hUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnGisyOlxB0hZUKoqTAm/RVIdEzkvAktM754dSFRdyU=;
 b=n+fkSmCp4OgHcRGJ0/JHf3mSfuDrxu/14JbWSg2Ty9hqHAYjdXWrZ7g4Mj20vrA/jSZa2EaM8dvrcvOa85t/sgpVA+ajf/uI92vIYOfsl/qJiBs5PmY0PYQklF3R6zcIc1TlGAofCSevsLId0Zalm0Cubn13Ha1Mq70SBwfBIvUX9uejhBzbo8hTt1QRvVRjdDHMAzwNs/Mb/2jtAjh7DsG8VxS858bUnEaLS+cRjbtU6inEm8X1O8juMOOxMP/ueUYe0Y41bfkoIgu1IeS4vx2wg4f9XP97CV7EvxM601lVtOZq6LdSIBz+fo+cfYg+mehENnWnhwh7qCq8KYtYjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnGisyOlxB0hZUKoqTAm/RVIdEzkvAktM754dSFRdyU=;
 b=L6WrGN2Krw7rq+BS/tpkqh6hU2sDUjEf+gV1OGj6wjFc7cSvTjFAIPwX7C33cBNEiYwLpaf6xwKNJ2Z90nchRDQI1LKa5OTXKF4lswwsJxL4Ag+zInz+F15Bbu7+Cu/dztBrNeTEwEDWU73jBBI9gpo0WPsMvXyREpV8b5Gwy18=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6492.namprd10.prod.outlook.com (2603:10b6:930:5c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Fri, 30 Aug
 2024 19:31:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Fri, 30 Aug 2024
 19:31:47 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Chuck Lever <cel@kernel.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia
	<okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Jeff Layton
	<jlayton@kernel.org>
Subject: Re: [RFC PATCH 0/7] Possible NFSD COPY clean-ups
Thread-Topic: [RFC PATCH 0/7] Possible NFSD COPY clean-ups
Thread-Index: AQHa+XFfbzGBtAnNjEurX0F1iSdENrJAM5CA
Date: Fri, 30 Aug 2024 19:31:46 +0000
Message-ID: <27D5507C-654D-44A5-9C15-356234B33CE6@oracle.com>
References: <20240828174001.322745-9-cel@kernel.org>
In-Reply-To: <20240828174001.322745-9-cel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6492:EE_
x-ms-office365-filtering-correlation-id: 7662ea8f-2b0c-409c-c153-08dcc92a6335
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VzcycVRlZit3RGplK1BJUDM3RGpQWEg1QVowSi9FSjBjbzB0dSt3Z05Hc2x1?=
 =?utf-8?B?b3AxcW4rWmpKcFdUcmJOZnhrUnFDVmVNQnhJdTRDYTFwUUM0dzdUZXZwcW9I?=
 =?utf-8?B?VWhxRzFjY3F1bEJtSjhMOThnMGxSME9YaWdtbExLNlZQQkhtaUMvTnkxQUR3?=
 =?utf-8?B?cGRCOWEvOEpGWFFzM0ErakhaRmJudkV2OU05aEpoK1UxditWb3hhZGM1aldz?=
 =?utf-8?B?Nkc2a2dsQWFPTS81MktLZVpLb09tYUkwejl6R2VKZ2VLRHcvZmIrRmtPMERw?=
 =?utf-8?B?MUFudjBIenFPcTlLVTE4N2hDRUZ2c0xtbmlCVFFxV0hFY0orK0llNUFtUmI5?=
 =?utf-8?B?VWR0dVBuT3pobDk4WXRnakNKQk4xZ2FaamRpUlBEcjNZK2dsVHNWalVKVTE3?=
 =?utf-8?B?UWJSaEh6MUV5eHc3Qm5hZlF1L3ZicUNBdVF6ZTBDc053WEJYM2tWRmxMWDAr?=
 =?utf-8?B?dFFGZ0JJbWlCTDZUU1JULzJFemFSQnRuYTI2emExYWxoT1hPbkY0ZVNkT0JJ?=
 =?utf-8?B?cXo4NG5UYTg5ZnRPZTI1dnFod0Rnb28wZm8ySXF2VkRzN21MVyt1ZExrZkNL?=
 =?utf-8?B?bTRpTy9tL1htTTljN2hVRlRoZkNraEhwdHBJNkszbXlqYVZWQlN5RDhZVzFK?=
 =?utf-8?B?L1I5dC9jZmJPQ1h1aDA3Y3lPdDg0bjBjeFFzWjFVTGdzTm0xZEdCQURoazl6?=
 =?utf-8?B?UkNPNXo5bDNIRGVPTVc0SzgrZ0Z0QU51UU9ibHZsQ05Jekh2cEZWVjJ6T2t4?=
 =?utf-8?B?eDJuOFFURFZUT0tnOTR4b0V5REkvUHI2OHBRaHJhUTZNQit2R3VtbnhKYkJo?=
 =?utf-8?B?N1EzYkJBYjUwV3F1MG9tVlNPeHd4TjI2UVRBZGtUNXF5cFZINW5hZ1dTRVF6?=
 =?utf-8?B?Z2RYZkpvdjRKaG45bkRzdW10UUV5MjJBZTMvS1VTMjJBOTlabEtQVnFlb0Qy?=
 =?utf-8?B?RkVCaGxlN0VXanp2Ynp4QlJuWGVyWkhlcUhyWTlDZEpXdWZPYXY0dEpnYWN0?=
 =?utf-8?B?S21PeFl2Mys3NVFjYTdXRjhPeHNrT3FhMTc3dFQ5ZEpGc24rdGpld29tbk5N?=
 =?utf-8?B?WVcxbDNsN0ZBQ1VMKzdUdVhja0RRUXV2b0w5OHFJRDFrcTVOMENrcXhObk9z?=
 =?utf-8?B?YlBKQnIwbDQ4SGtGZ2xYUEVMNUhDYkV0dmxFeW0yN3U3b2E1ZWVJYnF3QTlk?=
 =?utf-8?B?TnNSeGowaGNReWxoeHg3ZENhWUJxU1dDakxoaVhMb29IclhKZUhCbGxOQzJY?=
 =?utf-8?B?c09FNWJVR0V2SGJ2OHJsbDluVU9ibEsrdE5VYWp0SjVtWDB2M3I4d0FEek9m?=
 =?utf-8?B?NzlNYmRnYlRWeUFYSWtWVjE2bEdVdVlhU3ZtTWFEUEtlTXdHSFQyOXVkV0xM?=
 =?utf-8?B?bEUyNURHYkRzQnJuRHdsNEhMVjJMWFB5bURhSldwRnllOXQwWmtiWmp0NVZw?=
 =?utf-8?B?b2tGcURXWVZEU25GeUJuSDhDUG43Z3IrdWtJM0tXOHhPSzZqM29oUEJHbEhx?=
 =?utf-8?B?NjVnTzVycmY0WS9sak9vY0lOTTZqMWFDa3RObDd6cWVoU2JuVGk0ejBBMUpl?=
 =?utf-8?B?am9zT3FleCtQQ21CbWgrK2xGbi9XRHNJaTFEU1dzaXY2eE1zbG1hbHowMm8v?=
 =?utf-8?B?RFdpZE01bUd6RmgxZ01LdVVvVU1HUTZMejhnVzhHUGI0T3Rlb1JKZmlPZG0v?=
 =?utf-8?B?WnNKSU1qTTcvWFcyeDFRUHpaQThPcnhDZE5vT2pVbkJGL0tqa05UTHpmWXVv?=
 =?utf-8?B?K0V2SlpsOWVWVnplMzNsYmxQY1FZdWlUSzczR2l1ZlM0YUZJZHFlb2hEWGdr?=
 =?utf-8?B?MU03NlpWekc2L0M3ZWEvWmV5SHZ3Mk5BQmFMKzdzOUtZNEMrekNPdVNuYjg2?=
 =?utf-8?B?QTlpS1M3cWZIdC85WXk0MVFtM3ByU2FIZkhxc1NWY25Ja2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZjFTdjYwL0g2ZjB2ay9oNXZ5WXJzaWtSVkpSbVhXSVZUVzVMcDVmNG1zNVBq?=
 =?utf-8?B?SzMwajFndU01dzlDTzJxYlJIa2lrbkZ2dlFtWEZuM21WaGNSS2RKZi9tS25X?=
 =?utf-8?B?aDBZUzJRQ0FGRm03K0lmNnRGc3hEWVJ2Mzkxc2tmSWFxNmZuUFgwWkJ2Qjdn?=
 =?utf-8?B?dk9HTVN2QkxtWU5ETFdFV0RSRkVDbkZ3czFpZGEwbjJBbkRYTnpyRTZYZVI5?=
 =?utf-8?B?RVFrUWNvMk5EbG95c0JwSG1EcjQ1Szl2ay9ZQ09TRUJkY0tsRUFraVZhZStB?=
 =?utf-8?B?clVYcWsvYVRDZFlnbUhDU1J4NDUwRzA2bkNVcTczQmEvVDZkWFBRMFRtK0Vo?=
 =?utf-8?B?emQ1YXFYalUxSVhtcUVTTGRTSFdZVFArbERXdWlScFBqYUJjSWRqUEJoZ1dx?=
 =?utf-8?B?WGllM1AzQnpUMDZuN0hxVmc2Q3pqVE80Ym5oM2k4YkR2bzhUNUZ4bGduWVAz?=
 =?utf-8?B?S25zS3dDRXVCa3cvMElXeXNIL293bmpPdkxoaE9PQXoybzk2UnlsVEFIcUM0?=
 =?utf-8?B?aFVSWmhsdUxWVHJMYzNZSmVxSXBteUh5NlJ3SU5xM3F2NE5SdGdJaHdLWUdF?=
 =?utf-8?B?VDJIYi9OcjJuVGUzSU0xWHkrZU9ZNGJkY0JZaTk2bENmbjQ0NGtQSnRXRnRD?=
 =?utf-8?B?Mzg1WFoycnV4Y3FueHRHcEdKU3d1eWVuZDh5dmtUbjRZSjNZTFJod1doaUVn?=
 =?utf-8?B?ZFJnVVJiQUg5RGF6U0g0bVBTNEZDa3ZqRGFrUGx2QUNzcVVBYVYySDZDc0ZP?=
 =?utf-8?B?czY2cHUrV0ZpN3YyZWM2bjE3bVpHQjVHMlhDeVgxTEFqV3QxcWdxcytIcXlw?=
 =?utf-8?B?MDVDdTZaQjkwK0R3T1RZS1FoQ3hwQ0hBMDVCQnBmVE5HVm50ZVR4enpWL1FP?=
 =?utf-8?B?V00xQnozV21GREg0OFNFeHdNOVlUYWcwdEwwdjgydU53YW5QRDlqVjJtV0V3?=
 =?utf-8?B?Y2g2NGNYL0dMUVFXRU1yZWFzWTNwN25CUTh5d3IzMTU2TDdjMWlaZnAwTGs4?=
 =?utf-8?B?Z3I1NExnOEVPbTFLVnFmUXdrcU5sK0pUM203WlZRR2ZhR0tQWjV1R2kraW10?=
 =?utf-8?B?cTN2SGNMaXNwd0Y2WWlVYWZYV1Z0ZkZqMG1YWnlEbXZIZTEveWlOWkJSSUFZ?=
 =?utf-8?B?NEpMZTFoRG1nU1ZvWDU0OVh3VU1kaHhWMnNyQVcydHgxL1dnRHBCTVFRL0Mr?=
 =?utf-8?B?cFZWQkVrZVdCL0dJZXM2Z09CTDFkeUFEZnJnaE51QVEybTNsRHo3QlVxeStO?=
 =?utf-8?B?N2RBcjJncEhUM3dqaGl2YjNVNUFjQUVsL29nNERuaDc2ckEzZ2FNYURLMzhL?=
 =?utf-8?B?TGFIQWpqejI2NGZwQ0RkS09QMU5JZjBhenYvTFVZaWtnNmNST1R5K0lTSkxT?=
 =?utf-8?B?TEVIaFVwOE16ZzZnd3BCNHgzeHVPYXhRbFl3a2FPVnVYc2I2UFdXakgrYmVV?=
 =?utf-8?B?MlI1dGx4MEwxMncxRnpIWkxXSUM0YlMwMUphcHRvelZxbW5hT20ySVhHVDQ3?=
 =?utf-8?B?KzFUV1NnWXduOWFMamZEYzZTRHhJOVp3aDFKNm1NT2IzU21IeUllRlhYUW5W?=
 =?utf-8?B?Wng0ZVZyZTFXc2lxbTVGYXlyZUNRWnV2MjhkUnZTRENwajFHVk4zUUtnT0Ey?=
 =?utf-8?B?UW94WTErengrM2pscGxJN016OGI2SG5DM2R1M2psbG9kZVZ5eGprUVpyQ3lZ?=
 =?utf-8?B?a3g0RTNBSWx6SytEZmFXOUlCd2JkRkJFVUFFdGlESGpqUE1hOWhUcVFWV3pW?=
 =?utf-8?B?QkgxRURwc0phOHN4eDlsbjVsT0RRU1liM0xSYkgvQzRYaTlySW5IMG9zL2Ji?=
 =?utf-8?B?VTRxcG5xTWk3elZ2RGJOV2s1a2ZidEtZNDl1RFFhcmtLT3kvRVpkd2RzS0dk?=
 =?utf-8?B?b1pEcTZDanJTdEdyWFladFlHUTB4SFgvL01vQ1hYZExJTXAzb0FkYkdlQVgv?=
 =?utf-8?B?bzhvM1JBbEE2RnBkYlorSzY3NjhjMUNrNnJSencyNGZ3VTM0V1hXQUwyNWJB?=
 =?utf-8?B?WFZiNFg1MWhaVWdzNXp4QjlVaG1OSVJjMnhvMmRpT05uTExHQVUzL0NybHkw?=
 =?utf-8?B?ZUMvbXBYY1NGeXhxM1Q3MnV5VGhNM3F0ME02Tk9hN281MmdESW5XNjdLYWYy?=
 =?utf-8?B?SUhzamJwanpSSkdtWms1Ly94dWhsb1VhdnQ4R3Zka2tjSlpJc05kVDhuYkov?=
 =?utf-8?B?Rnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FC57B0024E8E64C9C01BC077555AE7A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zY8lAN9fguswTMIx1190yVc1QG6Kdaix66c8M6ZeKKlEgVCLUOVQ36/5l+Thfen132JWOgOgOmfCBok24h2FoaRzOF/Fm8pmjK4Ma4rYErkgRVl27K0xOwc2kFSIBp5YB711zdJMcG6lEuVQedF/smo0wpzHHsxHDIFn2OLtjjzqE4vsVOX6dJwmdMgDbg7RwvmtaTjdfxXSuIowIHIJUZgOrOHlbhAWcpUsr11XEQCOEp+svOEx2jmzvq6eUU5WO2r2x3pNN8xoOm8Twr5xA4H7fjmpcyXgMkUyLI4i31Wzh2VLXQpgBxVCeM/4/5meGZ7qOddv+w5idfcgQBGmSJaHrLgYE/SCZGovvbRSI1F2vuIK7Auq6AXX+8wSatSzHsp6LIUIYg2cMpXJ5+k6Ol3fCQWhv6A5QKrGzVRJsTXti7MQJ/HctHcErdP0KD2MWQk4yZeEZgLdoyIyJVXn2okhIyGTF3pXONcBzczj3lSZWRL9EMu4byUqW7wkyYqCxRHtaJ4c/jC5lMw8YUG/sj/EeTSJqxCiLpvV/T5vee3TdWtblM1o+Ai2S6pyHCLlvCypRkZXJqhe8WKBow1RtPzytWjb31pT1vD4NDj6jQY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7662ea8f-2b0c-409c-c153-08dcc92a6335
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 19:31:46.9420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WAAwL17cDvlTuHztEQyQ5B90xfxF68We2kLWS5pJM5ktv5N6l1XWJ++EMgHwvsbhrlzSIWzMRCBaT/p5eYYHsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6492
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300150
X-Proofpoint-GUID: 63yozt2cZ1-85aBDzLqifn7QkgSPNRvS
X-Proofpoint-ORIG-GUID: 63yozt2cZ1-85aBDzLqifn7QkgSPNRvS

DQoNCj4gT24gQXVnIDI4LCAyMDI0LCBhdCAxOjQw4oCvUE0sIGNlbEBrZXJuZWwub3JnIHdyb3Rl
Og0KPiANCj4gRnJvbTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+IA0K
PiBXaGlsZSB3b3JraW5nIG9uIE9GRkxPQURfU1RBVFVTIGFuZCBvdGhlciBwb3RlbnRpYWwgaW1w
cm92ZW1lbnRzIHRvDQo+IExpbnV4IE5GUydzIENPUFkgb2ZmbG9hZCBpbXBsZW1lbnRhdGlvbiwg
SSd2ZSBjb21lIHVwIHdpdGggYSBmZXcNCj4gc2VydmVyLXNpZGUgb2JzZXJ2YWJpbGl0eSBlbmhh
bmNlbWVudHMgYW5kIG9uZSBvciB0d28gcG9zc2libGUgYnVnDQo+IGZpeGVzLiBUaGVzZSBhcmUg
Y2FuZGlkYXRlcyB0byBtZXJnZSBmb3IgdjYuMTIuDQo+IA0KPiBDb21tZW50cyB3ZWxjb21lLg0K
PiANCj4gQ2h1Y2sgTGV2ZXIgKDcpOg0KPiAgTkZTRDogQXN5bmMgQ09QWSByZXN1bHQgbmVlZHMg
dG8gcmV0dXJuIGEgd3JpdGUgdmVyaWZpZXINCj4gIE5GU0Q6IExpbWl0IHRoZSBudW1iZXIgb2Yg
Y29uY3VycmVudCBhc3luYyBDT1BZIG9wZXJhdGlvbnMNCj4gIE5GU0Q6IERpc3BsYXkgY29weSBz
dGF0ZWlkcyB3aXRoIGNvbnZlbnRpb25hbCBwcmludCBmb3JtYXR0aW5nDQo+ICBORlNEOiBSZWNv
cmQgdGhlIGNhbGxiYWNrIHN0YXRlaWQgaW4gY29weSB0cmFjZXBvaW50cw0KPiAgTkZTRDogQ2xl
YW4gdXAgZXh0cmEgd2hpdGVzcGFjZSBpbiB0cmFjZV9uZnNkX2NvcHlfZG9uZQ0KPiAgTkZTRDog
RG9jdW1lbnQgY2FsbGJhY2sgc3RhdGVpZCBsYXVuZGVyaW5nDQo+ICBORlNEOiBXcmFwIGFzeW5j
IGNvcHkgb3BlcmF0aW9ucyB3aXRoIHRyYWNlIHBvaW50cw0KPiANCj4gZnMvbmZzZC9uZXRucy5o
ICAgICB8ICAxICsNCj4gZnMvbmZzZC9uZnM0cHJvYy5jICB8IDM4ICsrKysrKysrKy0tLS0tLS0t
LQ0KPiBmcy9uZnNkL25mczRzdGF0ZS5jIHwgMzcgKysrKysrKysrKysrLS0tLS0NCj4gZnMvbmZz
ZC90cmFjZS5oICAgICB8IDk3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLQ0KPiBmcy9uZnNkL3hkcjQuaCAgICAgIHwgIDEgKw0KPiA1IGZpbGVzIGNoYW5nZWQs
IDEzNyBpbnNlcnRpb25zKCspLCAzNyBkZWxldGlvbnMoLSkNCj4gDQo+IC0tIA0KPiAyLjQ2LjAN
Cg0KSSd2ZSBhcHBsaWVkIGFsbCBidXQgIk5GU0Q6IERvY3VtZW50IGNhbGxiYWNrIHN0YXRlaWQg
bGF1bmRlcmluZyINCnRvIG5mc2QtbmV4dC4NCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

