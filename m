Return-Path: <linux-nfs+bounces-7908-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D149C5B65
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 16:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153D0283213
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 15:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B061FEFA8;
	Tue, 12 Nov 2024 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ty7AVgDA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i82u9+IJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E89F1FF7C7
	for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423819; cv=fail; b=ST2Mweb+LOLpxuxlS/AHf6qddaKPs1CWqcE616TvfqZ41MvtkBVt0LumgaNuSvwfJxhp1ZBuHM6WOT/BfDixl+kYjlJnP+zsICoG9/xB1N77wL+0mH0B6lvyj8zPizMcR8+2o2lZwKZWEYOpg7ME3pOENpGWm4t+VQ4XxUVqQnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423819; c=relaxed/simple;
	bh=BQ1vv1s6nTNxzfTqfDy+5FQJSVrzR4mxoT05SgF/1HU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YU+UMC95+3AB+FdstmHN2Q/mK/clYOXCAdT1sH3jz42873cnVQr4u/m807booS1wXL1QEg0guSTquek/clousq6FiDJPu3MZ23Yto7IwAv3MLoHWkE874tuNmmhxn2zEKV8z2bqwjlx54YnPemykTVUsX4IycXSUvpdFkHfWM+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ty7AVgDA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i82u9+IJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACDBZoC005184;
	Tue, 12 Nov 2024 15:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BQ1vv1s6nTNxzfTqfDy+5FQJSVrzR4mxoT05SgF/1HU=; b=
	Ty7AVgDADNWaItH0t4hpVtXvaYYATsHSIEYHRQV8YVhXuTH6otcPuoL8+ohCvhyp
	p7SgG4AD+ei2GZJYoSyVTiQ9LT5hWortN2OpypqECfJq8ZW+kCaU50rpxeK/ifpG
	Fp/jYBn9DoxgN1QBdDRHYancQFoQr8vJZ65fjmY67D6LUWbkqvl2N+TlVetYmXqv
	T17OJ57ZwXLd2bUzZsu09HS+fFEyMrRb91k3YQFeaXk0Q9Kf5y5xZB/1THGWnJH4
	5YNoZVQtb665bLHdD5inVelenbWe3kd18ajtUaAsL9lOch3xb4DoxY3PAppS9tzt
	0ZAsibr8HI8XsKLqfrnpmA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5ch5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 15:03:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACEBNsc025908;
	Tue, 12 Nov 2024 15:03:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx680fy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 15:03:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVzoh0/9PoqL6Stx9NJW9P6NepbTdNU3FKhVxehnxqmprz91/f+NI1IfBOSs/tLJPn9b2jS5ROyD60IMLz+CkfptsiBJWwCZk6G4Fcsew2DyO8KM3UDNvJ8LIntewRZhjQhmgi2g2VDPwbtj5WcXQynycuri4bmkmIBiZC63bzidRGxMOA5fUysGBhruN4lgJ3THsqplx3e6hudfQIS86vrryKunQl/9RnNkrqJzbppQZoFFcHHDRxNun8JM9npQ6e2eS23a9w9A6DF9mpMCFcy0ehRLK1gOllPQ5xLLjwEpuS1F3RSM5J5iu5nWY0WvE6j+Q0V2et7fPwTjwL8a8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQ1vv1s6nTNxzfTqfDy+5FQJSVrzR4mxoT05SgF/1HU=;
 b=Z0z4x2Jjk0Fcc45bJinzigZE95VC1RbChRWm0c81VxGKckx5YCivgk4bL3uJB0H0BIk8+0Hgi/DLD01mGxdG6yLp9iQL0a5xcXAuLoY3P7JSk1arzlJGfePwe7Lu2mDTmUKprgVqh/3rQXjpiAU+gZt/awhUCYqFyYRZm97wI+1vdcVNYBRx9ae4oxsYq8vMxQOJ7y7+2rx+IdhjzEGcVBjCGM/hxseFk0l4lZQYfPWwgEOplsOFJk5gP2JJcqcPuaj6ejVNxICXcC2dprAT3cpUOcSVvYI0yIfniG6Ixm43MeFHgZl4To+tCZd5DHk+9uM6Luvr57aTDdqKtObxUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQ1vv1s6nTNxzfTqfDy+5FQJSVrzR4mxoT05SgF/1HU=;
 b=i82u9+IJb2jVw5KgieReYmG2A11LxevS/rauEcmHiqlCfHh82yp41TqxJyMPweVS1gvUsxts+GdXIS77DDg47piD56poaLvMqwlKzT3HAfw+QI5dC+/9UrO0qyc2SFW084e/+QdpxXH8uapOmsG22keJZtnaeeaAoNDiFJnS7yw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5582.namprd10.prod.outlook.com (2603:10b6:a03:3db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Tue, 12 Nov
 2024 15:03:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 15:03:24 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
CC: Philip Rowlands <linux-nfs@dimebar.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: Insecure hostname in nsm_make_temp_pathname
Thread-Topic: Insecure hostname in nsm_make_temp_pathname
Thread-Index: AQHbNIwe0SGaCBRrkUKLeTYSkr1wFbKztPyA//+wB4CAAFjGgIAAAR0A
Date: Tue, 12 Nov 2024 15:03:24 +0000
Message-ID: <04D30B5A-C53E-4920-ADCB-C77F5577669E@oracle.com>
References: <6296a7d4-64de-4df0-893e-8895e8ec36d0@app.fastmail.com>
 <192D38BE-BC46-4C8F-8C01-89EED779E77B@redhat.com>
 <ZzNpGZ1mK8lUo4St@tissot.1015granger.net>
 <F18AA886-F024-49A6-8FFC-F35A6A923704@redhat.com>
In-Reply-To: <F18AA886-F024-49A6-8FFC-F35A6A923704@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5582:EE_
x-ms-office365-filtering-correlation-id: a8aab233-af6b-44f0-ef15-08dd032b281a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bnVNTkw4NHdiV0RjWmt2UmlQbkl1cnBZZW1HUVR4Qk1hQXBWWFJPWmVUdnVw?=
 =?utf-8?B?RmxBSGxZVnhNT2FDa3Z4M0Z5WXpIOHlnREgwNFFSMytRUkl1QUxmcUEvRldG?=
 =?utf-8?B?L3Vyd05iRlhwNVluOUs1YlRpS0F3WEpKWkhzc1NIQTU3OWV5a1hBMnkzSmVp?=
 =?utf-8?B?Z2RPYXlTdlRRYVVuSVRXU2N6TWdWWkY3d1FpYTFPWlhIREtXbWR6MmZ3QzVr?=
 =?utf-8?B?TTJEUU1USk5QUDNCNFVYTWFpSytzMUNEUXpOaXA0QVc3WjlPVnlRb05kWUxF?=
 =?utf-8?B?Mk5ucVphVTFEdzhPekJvSTQ5UklzeUw4OFk5ekJoeGlxdFVsVFh2MWZqeFJY?=
 =?utf-8?B?NWxjYk5Kc21QVDN2WWhyTnJlRmJ0R3ZCUXdYQzJVd1Q0bmFDUktDQW9aYksr?=
 =?utf-8?B?ckxwTGNlMEp2UUJDb3BPbmpkQ2VpUHh1eDQxK3NwTHBMamJSa2Y2cVFUVWtK?=
 =?utf-8?B?UzQyWnlOcDNQMjdjTnZGZjdjNVdnNFIrYktaZEJXYjJjL0ltbFBkQS9JcG4r?=
 =?utf-8?B?ZVBCczNZM1ROcGxRSmF3T3p0T0dINDhLa1U3SXVBbnp1WnJ5OWtxZVVpM3dP?=
 =?utf-8?B?Y3BzVEp1QVFBQWMyZ043dFNBOWE4R3VDdlplTE16T3lLZlVZSEVBemtyN2Iz?=
 =?utf-8?B?eTBuT0xqY1ZGdGFZLzFCcW9aNEo4REZrRktMZllaV3M2M3B5YkoxdnhEYVU0?=
 =?utf-8?B?RTZ3dnRIZWF6ZTY1aGxYdCs1MjhaeGc5UzQzNEV3aUJsaUxOUkE0WmIzT0tr?=
 =?utf-8?B?NXdkWUxEYXJDSy9NdC9WZkZybG1RNmJwUUtGN3Q2ZVIrTmFmd3Nmc05Ocm1o?=
 =?utf-8?B?a3ZtWlcrZWt5M2FQaWY4aXAzVlhWb0RRTGtoSUxBclJXRklLcHdGN040di9C?=
 =?utf-8?B?bDluY1dOcXRqdXdwQytobnJZQnQxY0VCWUh0ZmhrbU5HODRVeFp6anNaZzVq?=
 =?utf-8?B?dG9BTVVFOFZQUWxjRUNVSXVUbm5qcHBUN0IyMWNsTWF1V2hHcElYUXNzWmJa?=
 =?utf-8?B?SVJsWUNGRlhhNS9IdXZOQ08yYlZJRGs0YVEwYmJYTVhYa2Z5N2dqNWxmYS94?=
 =?utf-8?B?ZnRpK0JJSTdiMjgzRUljclVWQmVhN0dnbEVLSmQ5WFFWTEYzdE5ZMHhqdDF4?=
 =?utf-8?B?c3FNdGFSa0FTYjVGSGNpaUtsUGFySEJsZU5IRE02WlM0akhVNDNjWjZyUEJP?=
 =?utf-8?B?L3ZuMTIxaGg5S2h5dWgrWE9SSjZqa1kxRy9tOE51U0x4Q3pEU21mMlF5OFEr?=
 =?utf-8?B?OTJWWjZZODFBZ0VZbDJIaTBHenJhVW9FT1BrZDFoNWhTcnJ0UUtLOG54Mm83?=
 =?utf-8?B?ZzRib2RXNDRGaEJYUmhnRVdVeFJHZzBEOWVLY0prVkFWbWRiNzM1ZVpTY3Yx?=
 =?utf-8?B?NWRURmU1TnozWUlrbUliRXZwTVpuOG50MmprMGpyT2FFRzkwWmxaWkIwdXVn?=
 =?utf-8?B?ZjJBSElRRndSZGxmRGRoK0x4U1daSEMrWFlaVGVNcEgyWk4vRkd1MlBaYlJ0?=
 =?utf-8?B?L2IwS3VIR0dXSmNlS05ITG9FeWh3M3A3R0NKSW90Yk9nMEgwTTJvb3hmaUJq?=
 =?utf-8?B?OXlOaHY1K1hGTUpweEtORTRpMHc4a2lKeldzVTRTQ0ZJczBtMC9QYkozZisz?=
 =?utf-8?B?ZmpEV2dTUVdjVkswMjdsZXlXMjZnQjVVaE1zYmdHTUFmUnpQTXBHbkxzS21I?=
 =?utf-8?B?cXlxVTc4YXdQZzE2V2lLQTVQQzR6SHVoMXZIRjhpdm45clFIcVlQZ3QycDZI?=
 =?utf-8?B?ZUxGaXcvdXVkSEtCM3RvU2VDaGdZb1psZVJ3QnJRQkZzSjhNQ0FhQkwwM1V2?=
 =?utf-8?B?U0R1bDlpT2RiWGFVR01HSFoxc1d2TU14NDRNd1lSb2NjVDM0bGZXVVJUTjJx?=
 =?utf-8?Q?sC/cDp9P6I6M/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bjRHVnhsMW1aaUlYVkZWcklnTk1pTi9ZWVhmRll2eWh5d2l3YjdQQTc4VVhZ?=
 =?utf-8?B?YXI3ZEZLOGw4cEFKS25NV1lDaEJ4cS9RU2RZeGNFNDlpR1o3RFlZbXp1MGh2?=
 =?utf-8?B?ZnVWeVNwTHROcmNXRFZlUFZ1K3lKMHpNalF5Yi9PRGM0Unplc0FRb3ViZG85?=
 =?utf-8?B?amtwQ3lXdDVCNkVsR1FWS1M4eXpZbU14cHU1RXM4NE9Rc1ZSNDQ3NXgyeGZw?=
 =?utf-8?B?RmMxSnVndlp1SWEzbEVRdXlDSGRYZEg0aHhUOHBuM2VkR1lodXVsWEczSGJt?=
 =?utf-8?B?ZFVZTElxciswODdZL05qclNIeU9zczhLNFJYMkVEUVpHakZVVHpxditFb1Nl?=
 =?utf-8?B?UU8vS0I1dEZXbGJnQzQ5bi9zSzhlTkZ6cldkTENXWURXY1crcFlTZVpmM29C?=
 =?utf-8?B?b3c1bUJ6SXZtQWJlOHEzeEtpUzZlbzdjMVJqclAvWUVoRDcrN2RHYi9VRmh6?=
 =?utf-8?B?ZGRUK2VMNHBpMWRUMkR1NVlDczZjOElHMGRjQVozSHh0eFpYRjFtMmFiNUJa?=
 =?utf-8?B?T2xZMTNIQVlvSnEvMmZxL3FCUWxWR3d0dGVoZ21SZkdSRk5sdVgvaUlsV0V3?=
 =?utf-8?B?cUVldDFzRE1DTVdKYjFmb0dJYjBITjdXUjFYYkE3WVVrLzJMUjMzZFRpeW1K?=
 =?utf-8?B?TnJNZlFFN0pWcWd6dXBGRmNwQ2VGaTNWcW8zNmlYSWxxK3ZtaW5LNlFaeHlI?=
 =?utf-8?B?LzQ5eGpYOWl0OHd6Z1hQWk5SZjdIYmg4MGpKR0NJNVk1Q0h0TFlRUHlsY3gv?=
 =?utf-8?B?UkRtQy9ubjNUSGRwZlVJaHFveHJtMW1KNnA4YkpMM0w5MUUwRDV2d05sTTZM?=
 =?utf-8?B?cVdTbEFOUWZ6V0pRd3c0cDFlUUJHRlBLZ3djcWF2TkYxR1JKenZFOTFkK2xW?=
 =?utf-8?B?TmRneGJ4OG13YjFHaFJsb0VMaGNINWwzc0d5MFQvTEhGNkFGdTBpUUF5YlZk?=
 =?utf-8?B?YVJzQXU3NUs0Ynp0WUpMVEgvb0x6YWcrUU1UQml1NXFrNHY2a1JRSWlJN2J3?=
 =?utf-8?B?UWl3ek1YaHg1ZmxkeHVNMm05bkdyWkdWTmNFd1BUaXFzWW1ZNE5pMC9vVGtB?=
 =?utf-8?B?Sld3Y3VFRE9qcHdGSnNGejJGMTgwdVF3c3lGclFKVWIxb0sxczZ1eFN4a3lk?=
 =?utf-8?B?WVpHQk5ieGhXV2paaGNtWU9lREZZNlNxRlFIdTVYWG1FZTk3aXRCVTg5eGQv?=
 =?utf-8?B?c2UrQ0x6WVZMclRzcUtpYWpBSkhyU0RlR0x6bkJyWjBMWEZZd2loaTVVN2Mx?=
 =?utf-8?B?KzI5NzdZMGRlRnFxN0lyeXJGS2RRWGErMGFNN2RWNjk0RUw5SkZmVHdDWi9i?=
 =?utf-8?B?YzlJU1lmd2VDblZhK3BPbU5DOExZY3JwaGpyYVRWTmpSOFJ1RU4rV3ZpbVNt?=
 =?utf-8?B?UjJsYmVKVVJadUtCSmdzSnVmaERTZ2tpNHlqRThmNE16OWJPQjJyMThONzM1?=
 =?utf-8?B?LzFEc2cyYmRZaGxuRTBzbE1Fd2FtNktBcVdSN1dnOGhUTkExd3pJaUZhb2Zp?=
 =?utf-8?B?ZVUreTJrdTNJdEI3WkZPY1E0TWFDWmU4Ymo4M0FzL1VxbDhjYitIL0lreVdq?=
 =?utf-8?B?MGVDcnpFWTVjWnFMZHpBdjRwZkh2S092RnZIVHpnYVZMVmxGTUVPYUNzeXBQ?=
 =?utf-8?B?M3VwR091UnEwTEVFNjQ2dG9xWDlDSDZ4OHdpaW85N2hQNEJlekoybTR2RmVu?=
 =?utf-8?B?RHNQTTlEemUyTFhrRHZlSVk0djlqVmJ2bktyK2JrTXRTMDEvby9vQVFlOFJx?=
 =?utf-8?B?eENRQzEvQXBibXhJS3RHNDZFZDh3cGNEZjRGeEVuN0doaUE2RGw5Yy91c1g4?=
 =?utf-8?B?V05aRmtBY0RuVWZVVjA2dUlnRlR6UHkwbnJwb1NMbE1uUVNLKzBmSjNFUXlJ?=
 =?utf-8?B?K2dCbVhQTzFTVTF4YTRzaTgwcWlJdWtpNHZkMDM5eWtsTCtQcFE3UmVRM0ha?=
 =?utf-8?B?UVdSYVlIQjc5MGptWDhsM2J5d21aejdlMTBqWG1OWitxOEhlOXFMa2JTcm82?=
 =?utf-8?B?SWhyUXRVcjVNb3dUUjNYYVo4bWx3ekY5M2lhb2tiT09qWUhJVWJwQWU3djht?=
 =?utf-8?B?NnlEZ0dxUUJIanUyZlVhaUl5QWNsN0ZGMlRuUlFzTFNEbElSOEg4dzRnNmlp?=
 =?utf-8?B?NzJHeXFYYVduR2prd1k2a28wY0RSMkhVRHNPbnhTVmVxQ1hCczQzdXVMalNY?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1315E17B52F86A478330577757E25360@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1t7eZ2gQQkbjHbuHsQMHIQuJfICqTXca3LOsikhVfuPnyWqLjAAEuCGMK0IJHu0YKHbIENU5wyuVsD0Tc3rwnO5AYiB5SLpKf1fVqXL7knk6JJuYe58c2De20cRVf/2oydQ7pAz7pG3Y+O50YD5hWO9QYW0KDWKpwcdxJbfFRBk89xt1Fx5xXlEyOcXJtyOzhfviHzq52YnEW0AFEF6lxqgvtRt37eSnKOEyvc3xRS8pP3FwrIzpbDBCMrV1eGrfZ1reU55X73ZdPQWifiU599Tfo2Dvi6dqFa72DZddxfHYnIh1mRL6D9ZRMOMk8HCVZHgZC4EmDxBJ3bYQeCE+9yGKx7fd2QC3FfYLWg4T6Ey/MKLuiOUONLHbSd6znRw8ZYQSDVBtKztD+VJR+Rpz3G42dVoIsPlxqEoG+OGhr64pdh24/XFHrbKNsty9MiH6lP5oOq47RK8/OcHdgmvfcGlt3g2cvR2xk7A0lTf6Uro1Z6UJS3M9+HkUnbFPgB7HZYhs9UaItJWoB5fCsuD4p2nHlIiMxoTyJ3g/LPrtCiLkBimskzCJaO2KQqczEDcJ3vfziNsbmJaiobSWu6u9/vTmmn0JFUOdjwFtjfZogQo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8aab233-af6b-44f0-ef15-08dd032b281a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 15:03:24.7289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1J2E8MNOdkM32GUuklJ6OCJkZKbfWK6XFXbsg9OpgPjtiY8U3Y6Ef8Amq9U097BAT+HVz5sZkJd3w/ZgwwplAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_05,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411120121
X-Proofpoint-ORIG-GUID: sAg50hbJc-8Z_RbLj33RMRXMInlb809e
X-Proofpoint-GUID: sAg50hbJc-8Z_RbLj33RMRXMInlb809e

DQoNCj4gT24gTm92IDEyLCAyMDI0LCBhdCA5OjU54oCvQU0sIEJlbmphbWluIENvZGRpbmd0b24g
PGJjb2RkaW5nQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gMTIgTm92IDIwMjQsIGF0IDk6
NDEsIENodWNrIExldmVyIHdyb3RlOg0KPiANCj4+IE9uIFR1ZSwgTm92IDEyLCAyMDI0IGF0IDA5
OjI3OjQ1QU0gLTA1MDAsIEJlbmphbWluIENvZGRpbmd0b24gd3JvdGU6DQo+Pj4gT24gMTEgTm92
IDIwMjQsIGF0IDE3OjQ5LCBQaGlsaXAgUm93bGFuZHMgd3JvdGU6DQo+Pj4gDQo+Pj4+IElmIGEg
aG9zdCBkaWVzIGFmdGVyIG5zbV9tYWtlX3RlbXBfcGF0aG5hbWUgYnV0IGJlZm9yZSByZW5hbWUo
dGVtcCwgcGF0aCkgd2UgbWF5IGJlIGxlZnQgd2l0aCBwYXRocyByZXNlbWJsaW5nIC4uLi9zZXJ2
ZXIuZXhhbXBsZS5jb20ubmV3DQo+Pj4+IA0KPj4+PiBTb21lIGNsZXZlciBwZXJzb24gaGFzIHJl
Z2lzdGVyZWQgYW5kIGluc3RhbGxlZCBhIHdpbGRjYXJkIEROUyByZWNvcmQgZm9yICouY29tLm5l
dy4NCj4+Pj4gDQo+Pj4+ICQgaG9zdCBzZXJ2ZXIuZXhhbXBsZS5jb20ubmV3DQo+Pj4+IHNlcnZl
ci5leGFtcGxlLmNvbS5uZXcgaGFzIGFkZHJlc3MgMTA0LjIxLjY4LjEzMg0KPj4+PiBzZXJ2ZXIu
ZXhhbXBsZS5jb20ubmV3IGhhcyBhZGRyZXNzIDE3Mi42Ny4xOTUuMjAyDQo+Pj4+IA0KPj4+PiBZ
b3UgY2FuIHNlZSB3aGVyZSB0aGlzIGlzIGdvaW5nLi4uDQo+Pj4+IA0KPj4+PiBPdXIgZmlyZXdh
bGwgc2Nhbm5lcnMgdHJpcHBlZCBvbiBvdXRib3VuZCBhY2Nlc3MgdG8gdGhpcyBhZGRyZXNzLCBw
b3J0IDExMSwgSSBhc3N1bWUgZHVlIHRvIE5TTSByZWJvb3Qgbm90aWZpY2F0aW9ucy4NCj4+Pj4g
DQo+Pj4+IFN1Z2dlc3RlZCB3b3JrYXJvdW5kcyBpbmNsdWRlOg0KPj4+PiAqIGV4cGxpY2l0bHkg
c2tpcCBvdmVyIHBhdGhzIG1hdGNoaW5nIHRoZSBleHBlY3QgdGVtcG5hbWUgcGF0dGVybiBpbiBu
c21fbG9hZF9kaXIoKQ0KPj4+PiAqIHVzZSBhIGRpZmZlcmVudCB0bXAgc3VmZml4IHRoYW4gLm5l
dywgZS5nLiBvbmUgd2hpY2ggd29uJ3Qgd29yayBpbiBETlMNCj4+Pj4gDQo+Pj4+IFN0ZXBzIHRv
IHJlcHJvZHVjZToNCj4+Pj4gDQo+Pj4+ICMgY2F0IC92YXIvbGliL25mcy9zdGF0ZC9zbS9zZXJ2
ZXIuZXhhbXBsZS5jb20ubmV3DQo+Pj4+IDAxMDAwMDdmIDAwMDE4NmI1IDAwMDAwMDAzIDAwMDAw
MDEwIDg5YWUzMzgyZTk4OWQ5MTgwMDAwMDAwMGRjMDBlZDAwMDAwMGZmZmYgMS4yLjMuNCBteS1j
bGllbnQtbmFtZQ0KPj4+PiAjIHNtLW5vdGlmeSAtZCAtZiAtbg0KPj4+PiBzbS1ub3RpZnk6IFZl
cnNpb24gMi43LjEgc3RhcnRpbmcNCj4+Pj4gc20tbm90aWZ5OiBSZXRpcmVkIHJlY29yZCBmb3Ig
bW9uX25hbWUgc2VydmVyLmV4YW1wbGUuY29tLm5ldw0KPj4+PiBzbS1ub3RpZnk6IEFkZGVkIGhv
c3Qgc2VydmVyLmV4YW1wbGUuY29tLm5ldyB0byBub3RpZnkgbGlzdA0KPj4+PiBzbS1ub3RpZnk6
IEluaXRpYWxpemluZyBOU00gc3RhdGUNCj4+Pj4gc20tbm90aWZ5OiBGYWlsZWQgdG8gb3BlbiAv
cHJvYy9zeXMvZnMvbmZzL25zbV9sb2NhbF9zdGF0ZTogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9y
eQ0KPj4+PiBzbS1ub3RpZnk6IEVmZmVjdGl2ZSBVSUQsIEdJRDogMjksIDI5DQo+Pj4+IHNtLW5v
dGlmeTogU2VuZGluZyBQTUFQX0dFVFBPUlQgZm9yIDEwMDAyNCwgMSwgdWRwDQo+Pj4+IHNtLW5v
dGlmeTogQWRkZWQgaG9zdCBzZXJ2ZXIuZXhhbXBsZS5jb20ubmV3IHRvIG5vdGlmeSBsaXN0DQo+
Pj4+IHNtLW5vdGlmeTogSG9zdCBzZXJ2ZXIuZXhhbXBsZS5jb20ubmV3IGR1ZSBpbiAyIHNlY29u
ZHMNCj4+Pj4gc20tbm90aWZ5OiBTZW5kaW5nIFBNQVBfR0VUUE9SVCBmb3IgMTAwMDI0LCAxLCB1
ZHANCj4+Pj4gIyBldGMuDQo+Pj4+IA0KPj4+PiB0Y3BkdW1wIHNob3dzIHRoZSBvdXRib3VuZCB0
cmFmZmljOg0KPj4+PiAyMjo0MjozMS45NDAyMDggSVAgMTkyLjE2OC4wLjEzMS44MTkgPiAxNzIu
NjcuMTk1LjIwMi5zdW5ycGM6IFVEUCwgbGVuZ3RoIDU2DQo+Pj4+IDIyOjQyOjMzLjk0MjQ0MCBJ
UCAxOTIuMTY4LjAuMTMxLjgxOSA+IDE3Mi42Ny4xOTUuMjAyLnN1bnJwYzogVURQLCBsZW5ndGgg
NTYNCj4+Pj4gMjI6NDI6MzcuOTQ2OTAzIElQIDE5Mi4xNjguMC4xMzEuODE5ID4gMTcyLjY3LjE5
NS4yMDIuc3VucnBjOiBVRFAsIGxlbmd0aCA1Ng0KPj4+PiANCj4+Pj4gVGhlIGNsaWVudCBzdGF0
ZCB3YXMgYXJ0aWZpY2lhbGx5IHBsYWNlZCBmb3IgdGhlIHB1cnBvc2VzIG9mIHNob3dpbmcgdGhl
IHByb2JsZW0sIGJ1dCBJIGhvcGUgaXQncyBjbG9zZSBlbm91Z2ggdG8gbWFrZSBzZW5zZS4NCj4+
PiANCj4+PiBNYWtlcyBzZW5zZS4uIHlpa2VzIQ0KPj4+IA0KPj4+IE1heWJlIHdlIGNvdWxkIGp1
c3QgcHJlcGVuZCAnLicgc2luY2UgbnNtX2xvYWRfZGlyKCkgaWdub3JlcyB0aG9zZSAtIENodWNr
LCB5b3Ugd2VyZSBpbiBoZXJlIGxhc3QgYW55IHRob3VnaHRzPw0KPj4gDQo+PiBUaGUgcHJvYmxl
bSB3aXRoIGEgbGVhZGluZyBkb3QgaXMsIG9mIGNvdXJzZSwgdGhlIGZpbGUgYmVjb21lcw0KPj4g
aGlkZGVuLCB3aGljaCBtaWdodCBiZSBzdXJwcmlzaW5nIHRvIGFkbWluaXN0cmF0b3JzIHdobyBh
cmUgdHJ5aW5nDQo+PiB0byBkaWFnbm9zZSBhIHByb2JsZW0uDQo+IA0KPiBJIHVzZWQgdG8gYmUg
b25lIG9mIHRob3NlLCBhbmQgd291bGQgc2F5IHRoaXMgaXNuJ3QgYSBiaWcgaXNzdWUgZm9yIGFu
eQ0KPiBjb21wZXRlbnQgYWRtaW4uICBJdCBoYXMgYW5vdGhlciBhZHZhbnRhZ2Ugb2YgYWxzbyBu
ZXZlciBiZWluZyBhIHZhbGlkIEROUw0KPiBuYW1lIGJlY2F1c2UgaXQgaGFzIGFuICJlbXB0eSBs
YWJlbCIuDQo+IA0KPj4gTm90ZSB0aGF0IGEgZG9tYWluIGxhYmVsIGNhbiBjb250YWluIG9ubHkg
dGhlIGxldHRlcnMgQS1aIChvciBhLXopLA0KPj4gdGhlIGRpZ2l0cyAwLTksIGh5cGhlbiAoLSks
IGFuZCBkb3QgKC4pLiBTbyByZXBsYWNlICIubmV3IiB3aXRoDQo+PiBzb21ldGhpbmcgdGhhdCBj
b250YWlucyBhbiBpbnZhbGlkIGNoYXJhY3RlciBsaWtlICIuPG5ldz4iDQo+IA0KPiBIbW0uLiBJ
IHRob3VnaHQgKGdvZXMgdG8gZGlnIGl0IHVwKSB0aGF0IGFueSBiaW5hcnkgc3RyaW5nIGNhbiBz
ZXJ2ZSBhcyBhDQo+IG5hbWUgcmVwcmVzZW50YXRpb24uICBodHRwczovL2RhdGF0cmFja2VyLmll
dGYub3JnL2RvYy9odG1sL3JmYzIxODEjc2VjdGlvbi0xMQ0KPiANCj4gLi50aGF0J3MgYmVlbiB1
cGRhdGVkIGJ5IGEgbnVtYmVyIG9mIG90aGVyIFJGQ3MuLiAoZ2FoISAtIGNhc2UgaW5zZW5zaXRp
dmUNCj4gY29tcGFyaXNvbnMhKSAgSSBhZG1pdCB0byBub3Qga25vd2luZyBvciB3YW50aW5nIHRv
IGtlZXAgZGlnZ2luZyB0aHJvdWdoIFJGQ3MNCj4gZm9yIHRoZSBjdXJyZW50IGRvbWFpbiBsYWJl
bCBzcGVjaWZpY2F0aW9uLiAgRG8geW91IGhhdmUgYSBjdXJyZW50IHJlZmVyZW5jZQ0KPiBhbmQg
ZmVlbCBsaWtlIHdlIGNhbiBkZXBlbmQgb24gaXQ/DQoNCklmIHdlIGV4cGVjdCB0byBoYXZlIHRv
IHN1cHBvcnQgSUROQSBhcyB3ZWxsLCB0aGVuIEkgZ3Vlc3MNCiI8IiBhbmQgIj4iIGFyZW4ndCBn
b2luZyB0byBiZSBlbm91Z2guDQoNClByZXBlbmRpbmcgYSBkb3QgdG8gdGhlIHRlbXBvcmFyeSBu
YW1lIGlzIHdvcmthYmxlLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

