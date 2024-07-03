Return-Path: <linux-nfs+bounces-4597-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21769264BF
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 17:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521F4283BCE
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 15:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F5D1DFD1;
	Wed,  3 Jul 2024 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P34XdKzb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tSbdS7Nr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1EC1DA318
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720020275; cv=fail; b=BqwlB+DwJdeKbPPm8bVrytpdIbiaB0L9EuYb8/YlkzHouwib1/z2wAixbsAB1bKj1xfgOrX5AipFpPAvo6pfGTu5NutIzLao7sEGhE73l/pOeDhD6OQuaz8642Bnq7o0WGPx684tGCRF0vm6EU1MqGjS7/e78BuOMrMG18yRYNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720020275; c=relaxed/simple;
	bh=UuS3StPE6A9SicH/8JJxm0y6NTHLI6/TXp4e9uRVVTs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Phvsw5Hm4Cc4f3Lww/os44zaZ07oWuXxaaxkAnq3WDXwxTkt3AXXU86m+DAE3m/GuH9F8dU8asFkE86xvo1V5gemAJn5qyJjeMWBiptxtUAbUVYS17XBMLmLahdS3dGzHTRSOo+dLyh9aDNAO1n9vPVXQX/RevBkxeXqtZBeA8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P34XdKzb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tSbdS7Nr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463FMSrv001926;
	Wed, 3 Jul 2024 15:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=UuS3StPE6A9SicH/8JJxm0y6NTHLI6/TXp4e9uRVV
	Ts=; b=P34XdKzbJv4hVupE8M+Hsqke0PN4Gy0x7QY7YFjh1WxrJACOYKYZH0JLc
	xZ8LwpgxqC3YIdhYNVN0q5QQXs2/+P5KtMDsPa4X3wEg2BpHMf0WvSF92DADOoq6
	G24dVhf5CzhlGMX2ShVUG2kyLXzlorJmCnM6Rz3bo5MbKwfqAsGE6kgyKP0ZZgo9
	W9l7W4TmhRnwjxuv6UOnNdZeECW1n+8h6MwnXOCFJdQE1iYe3Zv2O0DTin+Upt87
	r22MRN115Zi0tfO5hd5uti1hWyWQ1sUmuxRZ5n4MPlfUhV5DxyQhzwna3yDYrOg7
	rKsEI554rBq/9NMT+Qqpg6Q+SidSg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029230dyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 15:24:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 463Ev45l023444;
	Wed, 3 Jul 2024 15:24:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n1090rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 15:24:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmX3yKgu5O1G/ZF9DOINGXPiMQmLVzitgWZLn+j8HwAwug2NGaFH+eDAgh8RNmT9J9NXB0COphEW3WxHdROGWOjaAE0XAdt48ECNxPz3pxSrZBp5rnMU5p6bpGg9O8RrQLP2dkqj4Vnp1BnsAF+890wSeAkH/5BZJz/svtFe1eleJjfRUtTSex6dKwiHj9ClNvYhdRxFogo57nBa7nvQjj4q4sivJvynNGwIXPyFYwi1iEIPy8JjVHx9lMI0zlpwUpMpjbUW6D0cps+XAPVsSuHGMht6kwLEsfEf9OstUCkIti6sGFxXlKzmawxZDFz1fcsFzuSpvaNLwNJ9Boo0gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuS3StPE6A9SicH/8JJxm0y6NTHLI6/TXp4e9uRVVTs=;
 b=V2O+IaiNqnT1qY71vDBW6YWQRdgTW6iDEW60mPbq7oUYaETuo1QnST11FdO2y7I8dpeCQ9TQZZOImyUFe+VqLawg80eWGwgPTy3C/W/nhZzOUN7zZSjRAc/OftOGGdq1Sj6ajWeboRUGQeSvxjIV2tCj49Za6U/zGGGf6JmBMnXgGdQDqoO9FmKeaUsI4r47GaCJkfbNQxdm7pjHBSxe5PKCfqVN4DdyIL1VPxhEFCXtnKwWi04mm2p2kUaASCzaX30yUc/ATmBeubBiXtM1UEv4h5GsUmcF3/18w0EWYt8LcpeEKzBWHc8iquf8yXd+P81UPNCJnimEfywThbUR3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuS3StPE6A9SicH/8JJxm0y6NTHLI6/TXp4e9uRVVTs=;
 b=tSbdS7Nrh9yIRGSU+LVEeLsBs2EBd1zPNV+2dejIgLkBzQVy0VZyb7FEBNtd9b2eNqCZSgDt7t3rgQtbH6GtxfUJTe0Ij9osKytzijMRx40Zq3s8z2lv26u/lOHEz82eZrDg3W6ZXfnr2LuiL6PuzVNEEFQnva9Z9Qku9/K0Omw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6230.namprd10.prod.outlook.com (2603:10b6:8:8d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.26; Wed, 3 Jul 2024 15:24:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 15:24:18 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Mike Snitzer <snitzer@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Anna Schumaker
	<anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, Neil Brown
	<neilb@suse.de>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Thread-Topic: [PATCH v11 00/20] nfs/nfsd: add support for localio
Thread-Index: 
 AQHazJzmgcDeJH7XRUCD8QiVhiofhbHju8AAgAC4HQCAAD+aAIAAWoOAgAAPdYCAAAG7AIAAAbOA
Date: Wed, 3 Jul 2024 15:24:18 +0000
Message-ID: <F1585F6E-8C41-4361-B4FA-F9BD6E26F3A9@oracle.com>
References: <20240702162831.91604-1-snitzer@kernel.org>
 <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>
 <ZoTb-OiUB5z4N8Jy@infradead.org> <ZoURUoz1ZBTZ2sr_@kernel.org>
 <ZoVdP-S01NOyZqlQ@infradead.org> <ZoVqN7J6vbl0BzIl@kernel.org>
 <ZoVrqp-EpkPAhTGs@infradead.org>
In-Reply-To: <ZoVrqp-EpkPAhTGs@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6230:EE_
x-ms-office365-filtering-correlation-id: 89583515-d2ec-4943-7862-08dc9b7434bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NUl5cEU0eWpBZlJqNzU0OFBrOW5VQldqcWJnRVhFTGlKSmZsbWtYSFZWUGoz?=
 =?utf-8?B?Y2JsNWcvMjJRTWE1NWNDVllPQzdwdFRmcHJnYk1JZlNpSUdiVFJxMXNIRm81?=
 =?utf-8?B?TWxUYy9ZWGFDQlpLYzF5T2NxVEhkeEkvc3lLZmFuWnNzdUU4UDhFN0VRNFJ1?=
 =?utf-8?B?cTRLUGM5ajVWTmI4cFl5RzROWGFaRm9OZ0FEc0R5Qm9lTHMyVHp2Y0YyYVly?=
 =?utf-8?B?VzF5ZTVURGtjUkdoTHByRGVURUkyUHJGNStFREJVbUpucUdkZkIvcWI1YWth?=
 =?utf-8?B?UHR4VFJGSkg2cEhtNG5aYWJselBjZExLZ2wrUERCOG1RYTE0ODdtdGxWbEJt?=
 =?utf-8?B?WExGcERUUzRrbEtXU21mczJ6ZmdEcEVqWkprU2NIcFo5TWZQZ1lKVnQyVXRu?=
 =?utf-8?B?eTVScTM1ekRMNHlnNW95SWJHTUJSb2xKTGZPeXdkSDFISUdQUXZQTDV3TE5O?=
 =?utf-8?B?RHJCQ1BuNGpWQWtBVlhwcTQ2aE94djczbVFCQTduNkYvOXhvYldOS2UrYkFH?=
 =?utf-8?B?VlRPa3U2YWlKU3dZODQxNVg4Y3lrWDVzODBvc2RhckF1cEFYdnJpUTlBK1FI?=
 =?utf-8?B?MGlEZEw5dUVmWGZxWUVLV0RNNzlOMUdqVFV4WU10ZG5sM3R6RDEzbXlad3RK?=
 =?utf-8?B?Y1pMYlhsWUp2MEllZ3lOYTNqQzhXSG5MVjAxa0ZweVpMQTVGZFdONzRLNmpk?=
 =?utf-8?B?c3dHZWZYRlBvVTJsTzlTS0N2OVVnVUVIbVZYYnFja1o1b3RZcU4rbThTZ2pW?=
 =?utf-8?B?STVxckpYUFZsVGlJc1ljeXhKUHM5NnhHNk1adXZYNGtNQlRMS00vOU5ha2Q3?=
 =?utf-8?B?V2kyL2tmNXYwS29xdCtjR1BlcXFvbFBYS3l6ck5MMVV4TjZ2Q0tCaWwwMUVO?=
 =?utf-8?B?RjdHZnpyc2hxZ3hkYjRMeFJsY2NLODY2SHM2RmVkdUtvZkpCZlJnRlpKazlS?=
 =?utf-8?B?NHJCM2psRDA0bVlGY2JIelozQ0cwbWgvMW44YTZtbVU4bE5JS1NYK3VhS2sr?=
 =?utf-8?B?RG5QV0gzdkZ6a3h5RVVzRnQ1d0JKMzFZK0xkNStPOS9Cd1BWMkE0RmQ3TmI0?=
 =?utf-8?B?Zk5DMEUrVTR3dzNERXdxYnFXcGQ4cUhXVGNVWExIMklDa05qWVdTTGJ1ZnFn?=
 =?utf-8?B?K2NSZHJMZ0ZINlhmVk5TYWNwSWFjNFVsTjdURDh3eDhvdVBXZ3k2MWxmTXpC?=
 =?utf-8?B?UzFibXowRUdXLyt5TFB4RlpKbG9HMkNlajlvVFMyL1loOERqSi9lRTBXZmRj?=
 =?utf-8?B?eFpkSFF5bmZZZ2o5cDBBYjVtaGJsdDdpMnpHb3VnNjFseUNVbVNoajVERVFQ?=
 =?utf-8?B?S2cyM2Mzai9sQmdDZFd1L2pCQ0RqQ1hJZFAxWlA1SXRFdVBrL3NVMTRyc3o4?=
 =?utf-8?B?ejllazJmZmg2T3RBU0pJN0MwV20wdExoUjFjL0FYaDVQOS8vcmRNL3Qwejdm?=
 =?utf-8?B?b3poaTdTZXdNb2J2NzVHU2dRTXcxaHdyekNiY0NKUmNLQ3pXYWZORW1UK2RO?=
 =?utf-8?B?UjBNUHROUkFVVGhweFlhNVJLVSs1cWcrYTlpVjlFV2FtU29aOXFUek1CYVl1?=
 =?utf-8?B?dTZwVzZJUVF4UkpNdkpRQ0pwTnRTRTlzUWdBK1Vac2ZJVWw1aFdaWGpWendl?=
 =?utf-8?B?QlBEWURtaGppSXVCMFBXS0lLVVprbHNEUlI1MytQR2c0S080YzA0VTA1SGY2?=
 =?utf-8?B?YTZ5bEcxOWNaY2hIbitZUVJ3TFdNaWdVeDdaSnJMdjU0MmRMZHZKZGR6NTYr?=
 =?utf-8?B?dXl1RHlqMzN5T0g5bHZPVmhwckVLSmdOSEdESERzeFdMTEVqMlV6UEtTeGNE?=
 =?utf-8?B?Sk9MNnlGVDNYbS9aVUJJamZWSUR2a29DbUxZcExsdEh4eG1jTzBCN1dDWUw3?=
 =?utf-8?B?ZGRnNE9Ed25GZnRpSFJWdXp6RHZXTi9VTXRhSmNRbkh0aGc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Rmkyb0U3OWphK0dtQ2dVZENDN3l4Z0lvSlNYZUFDZzhnd0tCWnVIblRlZ2Qw?=
 =?utf-8?B?ODIxZkhhUkxIRGJLcXZmWldrUUFZa3NlaVZxRnVYck1YYytFM3JrbDk3L1Zt?=
 =?utf-8?B?UEF4dzgxSEdrNUlSdHRCNGJrZyt6MlliODZrN2N4bGNZYWNQMkJSNzFqQkds?=
 =?utf-8?B?LzdpV2RodGFZdW5mZFFnUndOcGRMUWFjRVRUVDZITmdzTXRpeE0xWllCQk9W?=
 =?utf-8?B?ZmRuWGNZTCtKZU45MG5vcFhaaXN4cTdUV0tWU1U0N3ZwNHFtRG9hSHlYYlFO?=
 =?utf-8?B?SXBYRmdtU3oyaDRRaDc2a2d1eTFWaGU5SFBwWkVFZytqVmpqdDJjSFJjdHBk?=
 =?utf-8?B?UVZKQ1ZvZG5vZVlqdGpTNFRMYks1R2JCMm40NEduRTErZlVmalZBVDFKNldz?=
 =?utf-8?B?TmlSa2F2OHprTURmM2hucEd4S3A5ekF0UTRXMmpQSHJPQ1VFSmNQQlZPb3ZE?=
 =?utf-8?B?MzljWmFtb1hSaDc0ekVVRjhqTms4MjFaKzlkM2dTWDAzZkpFQnVKcmIwTno4?=
 =?utf-8?B?dnB3c3F5SWFhU01vQVRza0NBQWtVU011VGN6TTRHT2NPL3ZKV1Z0OC9idCt1?=
 =?utf-8?B?L3V2a21uWXE0QjF3Z1E1VzdwOGFBNEhtZFBjT0d2UExBcURseUU2YW1wMEh0?=
 =?utf-8?B?cHhqVWZJTklUand3RXRQdlJ0dHloSVpzZTJjZUNKa1ZHcDFxTmMrSlBsQTBD?=
 =?utf-8?B?aHFrQldzTkVHQjMzQTQwU1RjZHplZ04wczN4LzFnYkJkOWp0R3d1QlhvQnFM?=
 =?utf-8?B?ODNFdmE4SG5pTUVldjZvZURIbHU2MHlGeE1icmh2R3EwSGNZaE9SMWhLbC80?=
 =?utf-8?B?Wi9Bc080dG1SUDJxdVl4UHZxTitLYUN1WGY5Qkh6UjFBWXlmYkxrZXIzYjdi?=
 =?utf-8?B?VndHMWFKYzZwZmZzUnFIT2JLaTRKY0c3WlE1OCt1bG9EM2c4Q3hkRUxZUUt0?=
 =?utf-8?B?b3hHUnBWbUFBUDZRNW5KVXkxNXNCcnpERERjZzlNVmc1dmt4VC9zMzN6RXBS?=
 =?utf-8?B?ZFo1eWQrQitPcGxhYnM0YXVtQUpJRzZURk0vY1A5NTRIVEF3RlQ0MGRwcy9x?=
 =?utf-8?B?KzQ1TG5qVWRacmpVOWFPemw0VXMrZjNqNDhMek1tV0lHa1oxUDZzN2g3UjZ2?=
 =?utf-8?B?ZFk1dkFhYW82ODFMUHlWSm9mbUUxc1BYS0pLaDBxTFR0QVZscWtka2dUS0tn?=
 =?utf-8?B?QldmRkx1UElNT3hqQ08vWHZxV0hJaXhWV0x4Q2tKSFlhVUw1ckJuQVowcjFE?=
 =?utf-8?B?czV6UEw5MWVFczJmREpJTDdRWkVXSjNOeHJ2YXFJWEw5RkhaZi9ZRk1OWnF0?=
 =?utf-8?B?THBUdUE4N2hEdUxaRFlGSzJhQWZBektwSTlScmVIVDlzTkgrUU4rQ0JyY3Zx?=
 =?utf-8?B?OVRjb0pWN3RUZm9DQStDbWtDTWxvU1hUVm9hV29RWUxLa0RNNVg4U2NTa1Jp?=
 =?utf-8?B?d2ZoZHFwYnJnT3M3UGE1b0MyaXg2MEpnTU85YmVNUTZmV09uTE1HekdlaHdZ?=
 =?utf-8?B?ZzVwbXVOY28raFJQTzZoNzZjRG54UU03Smh4dVZTVGZra0NEV0c2NmxMMWZi?=
 =?utf-8?B?a3dCUkxkTm9WZUdKdFJYVDBCSWpiclVxeVVNWkRMc05PWHZ2N242TlE1OXI2?=
 =?utf-8?B?MUJPK1hFL1JTa2hMZG14Qm5zNmJYYjRvUUIzcnRhVEtQVC9PU25RWkV0SWoy?=
 =?utf-8?B?alFLc3VSTXhWNEdKcmt1cGJWR09wS1ZNUjJMenUvcW8rYytybVdxeG5zVFhh?=
 =?utf-8?B?R3V0RHpDYW1tOTVhVDkvUW42dlhpcHpZODFadnBNTW5rL3Z1bHlob29XNnZv?=
 =?utf-8?B?VXN6eVFacGZBd01oVGh1a3M1LzdwWTJpL0ZOUWtBOCtCWmJGRFIzUkNFRXor?=
 =?utf-8?B?SGVHZitmK1U1ajlBV01KSUthak95SElrUko1QWZUZlp0UFdlNUpJRFUrME1J?=
 =?utf-8?B?WFZZM0dvUzczMTd0cGFiU0pRVDZTbnQzd25TNHVwR016VzFodXJPb09nNmxv?=
 =?utf-8?B?Q0ZBNHlnaEx0b3NhZlhQQmVjK3MySGdHdGhjZDNjOWxiVXRack1oWVl0ZU5h?=
 =?utf-8?B?UU9tdTZMdkUwaWF5RHFLUjNhSWV4N1E2Vzk2L1dLaDlBN2IvSlF4Z0o3cGVM?=
 =?utf-8?B?SnlIVXpUOS9JSmNSM29ZZm5FUEFHYjZmVnVzYWpyWWF4Sk9oeHEyZVRia29O?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF899F9E8E0346439530521243A5F051@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1XMqnRjWyAZJG2TVRtSPmLloTke9uMCU8s2+moPwbNIKO2caTbSw4bCr2yhQm1oluwGCuluoYnldmrHXvczWD5YAtnoiz9xMPKRlNk/BWQExZ4V+CcCjFdGqezGKEN3Tw3RCbKFfmTavE5Ts4uXDBdqXarpDJ022c+Cd9DGoXUUrRD7jYrHbkuKwLncxO6A/3CbFvwDyyWAhdvchUYkSpO4Fm3AKQ8DF3jwSpWYsK+8Vu+CJDoKMh5HD5Er+m2Z3Pr+8haCtkf+O5dz/4rHzQSSJ7zGZUkEEyuz3qaxxTF9cPpZv0UMSZHxRwF29yM07pDJAa64OV1bkxZhCcvU3vI+HgRqWwzbkvQptSDYvoUxDmMW1XUl2OSY4JC2gNrHVzDZslj8HZ7pX4/SmDJD2c1u/hZcqGrPvSPzYHKt0iDKPVwDFYnzDa7pWacA0k95fD7TAeydrdSBUA72DXDLi1FcYfjIuaiNN/mTFUOaws+JH7aF65kBjgJbipIVWm5Q4UNteHMi3pG1SYdhKJKLW3/HH26/B6ncGAx7AHhj1BTK+ifYcSbqlGjlJ14Jvr9L2l2wUecmFRDohSSSa30vNnmZy1KHHq0c/HU4xZrI5+8c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89583515-d2ec-4943-7862-08dc9b7434bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 15:24:18.2644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OE+Z/EwJhYerBFANdONaAUYwFoK4RhIV8rSHPQH63lBKq01o4ozjWyutP0v2NKD+/CF22uQ3zxI98ezgogUBeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_10,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407030114
X-Proofpoint-GUID: oRT_mWrQmyHiK0afs4REuPgupHvQDogc
X-Proofpoint-ORIG-GUID: oRT_mWrQmyHiK0afs4REuPgupHvQDogc

DQoNCj4gT24gSnVsIDMsIDIwMjQsIGF0IDExOjE44oCvQU0sIENocmlzdG9waCBIZWxsd2lnIDxo
Y2hAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+IFRoZSBhY3R1YWwgd2F5DQo+IHRvIGZpbmQgdGhl
IGZpbGUgc3RydWN0IHN0aWxsIHdvdWxkIGJlIG5hc3R5LCBidXQgSSdsbCB0cnkgdG8gdGhpbmsg
b2YNCj4gc29tZXRoaW5nIGdvb2QgZm9yIHRoYXQuDQoNCkl0IGlzIHRoYXQgdmVyeSBjb2RlIHRo
YXQgSSd2ZSBhc2tlZCB0byBiZSByZXBsYWNlZCBiZWZvcmUgdGhpcw0Kc2VyaWVzIGNhbiBiZSBt
ZXJnZWQuIFdlIGhhdmUgYSBzZXQgb2YgcGF0Y2hlcyBmb3IgaW1wcm92aW5nDQp0aGF0IGFzcGVj
dCB0aGF0IE5laWwgaXMgd29ya2luZyBvbiBub3cuDQoNCldoZW4gTWlrZSBwcmVzZW50ZWQgTE9D
QUxJTyB0byBtZSBhdCBMU0YsIG15IGluaXRpYWwgc3VnZ2VzdGlvbg0Kd2FzIHRvIHVzZSBwTkZT
LiBJIHRoaW5rIEplZmYgaGFkIHRoZSBzYW1lIHJlYWN0aW9uLiBJTU8gdGhlDQpkZXNpZ24gZG9j
dW1lbnQgc2hvdWxkLCBhcyBwYXJ0IG9mIHRoZSBwcm9ibGVtIHN0YXRlbWVudCwNCmV4cGxhaW4g
d2h5IGEgcE5GUy1vbmx5IHNvbHV0aW9uIGlzIG5vdCB3b3JrYWJsZS4NCg0KSSdtIGFsc28gY29u
Y2VybmVkIGFib3V0IGFwcGxpY2F0aW9ucyBpbiBvbmUgY29udGFpbmVyIGJlaW5nDQphYmxlIHRv
IHJlYWNoIGFyb3VuZCBleGlzdGluZyBtb3VudCBuYW1lc3BhY2Ugc2lsb3MgaW50byB0aGUNCk5G
UyBzZXJ2ZXIgY29udGFpbmVyJ3MgZmlsZSBzeXN0ZW1zLiBPYnZpb3VzbHkgdGhlIE5GUyBwcm90
b2NvbA0KaGFzIGl0cyBvd24gYXV0aG9yaXphdGlvbiB0aGF0IHdvdWxkIGdyYW50IHBlcm1pc3Np
b24gZm9yIHRoYXQNCmFjY2VzcywgYnV0IHZpYSB0aGUgbmV0d29yay4NCg0KDQotLQ0KQ2h1Y2sg
TGV2ZXINCg0KDQo=

