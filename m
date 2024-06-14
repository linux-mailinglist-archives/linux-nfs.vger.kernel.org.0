Return-Path: <linux-nfs+bounces-3831-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAAC908C43
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 15:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4B3282D73
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 13:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33B4194AF0;
	Fri, 14 Jun 2024 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QQROZEg+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nbWeyJyl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17B913B797
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718370560; cv=fail; b=KiKUurrAnBXJpXFRk4MQpwPKfrO6oVqPQ8EAinITMXJplaHaa5Y55Ip6a80btOAVpDGF4rgsESRM/R9n4DSdY6oAV9GVq4K1N32WpGky8IFQ0op7+sOF5VcOlnMzYT4Yy1zbm5zHOO5XuQs8Q9qzi/2FFOqtyPdcAdraqBPOiig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718370560; c=relaxed/simple;
	bh=aC1TGt60lSj5SbYHt1OIyYMOu/TeP+1dtS2+edDHAXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o/JvdqLrFon7SjaUuBjH0aznISR6Nh5tey/ffmMehPvkXa8vm/7nTa/Yxc/AukBH/HyJzROSg6yu5M5gqgQhv9fOwVX+ThJmGao3MWjMYSnHDYWyuMZhHPs+vf8UQWb2WPMF2N3SvyXRK6Df6MWB2KFfP8sRyYPOqESpYORcHVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QQROZEg+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nbWeyJyl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E1fQlQ010216;
	Fri, 14 Jun 2024 13:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=aC1TGt60lSj5SbYHt1OIyYMOu/TeP+1dtS2+edDHA
	XY=; b=QQROZEg+ereExuZwRdaCgvtAemXbazhxe8qPYDVwo6G/aZiRftsfhN7OE
	n42neWN8QRhA/pV+oYlYXE5gp1LlAyLzi1E+GXbfN+7wmAlauJ/bWDzCxhkX/dpO
	BsCupjwTtPiIHEQUrYMErSUujoeesVb+lzUFku2jVg4qPNWA7/BmQ0zLEIUsuK4C
	3VCud88Qgn3DrzVdYYkw73YR3cIzBe8dCTF3wfJg+KUw2vy1E4Gf2OyNXisHA3Gu
	YmnlJeGfg8TNxwhuWKz4O2Za1tcGctbPKq52KLM2JVmLdAdGlSK8MkYmqYFucnUU
	hgUc0Fl0MnK1uH1Tw9ISF2t6SSR3Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1gktaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 13:09:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45EC0V9T036557;
	Fri, 14 Jun 2024 13:09:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ynce1pqva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 13:09:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VT7dUxm0yLvJ/dS/txM4q/M+TDR7DMmsij2GqSKKhUHQtA8AnnsgK5cRNr+AqMf3bwuQDwi5AdcYRGGpqNykszipqLE61Te669cW4TQb0lJHeWPGrBjdRyTbkYoSTcRCzx8CwZIyiIY1+hDkvQVPTSs/pk/MpwslG2dcVyt/FRbeoxr6+nhSeZH8zeUt0R1HVMmRjH5vo28DlsOYuhTpXTioiZIIezOqew1Pkr/jas3qB3m1C46hj0u+33B+1BHM+Ij08u4/x6j8z5q85/gKuLiF07b+JwLwoL0wmfia7ok3ZIHh7zIfxef3zcm3yvTBorq1sL2yLVJoRV5Nv8ZVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aC1TGt60lSj5SbYHt1OIyYMOu/TeP+1dtS2+edDHAXY=;
 b=d1J3uaLhot5JzXNa1nUqCVUT3Ter8pg9xhdMKexvJLA2VFNPK/wIqxcOk0ByuAYnR21wy2uRy+uMboXAuRugqWTSNkn5I7H1NVIwhM2q3l8m9T3WzvvXQ5Ank84t5v5omvYGA5N2OGH51yCNnX5HtVoiX7ueFcWpvvJpQ/1LRSBKEahTNFPM1HEnlqqatcFUMr0MfVKOCyj/I9GIuSaYE0/3AUuNL09meWtDsV4xkcZvTw+LZ0/O4131lwFa8BrX2fpSQr0Bai5HpE+55zW8SidcB1GfDlsMuXMLc6dDyrv8PcmYcG6Wj5GkYHRRnQ2GkKiNCW1vcN1od+Bbfwwirg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC1TGt60lSj5SbYHt1OIyYMOu/TeP+1dtS2+edDHAXY=;
 b=nbWeyJyltE6mN8oyy6aDoBJpQ3vRMqJ0p1sC5wj2ex4DbGqVN1fc24HPJ1swgHo0gVY2ya6HhyLbcqRMpDH9fEa9EiFMoiHV7o3fECDrrFp9MWEHi2b2Pi6hVk5pP3z4MAFD/pYP0gaahK8gDOR2DE6gjWALlj5RcCM0Utu2LgM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7111.namprd10.prod.outlook.com (2603:10b6:a03:4c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 13:09:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 13:09:13 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Chris Friesen <cbf123@usask.ca>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Seeing strange behaviour from RPC/NFSD on 6.6.7 kernel, looking
 for debug advice
Thread-Topic: Seeing strange behaviour from RPC/NFSD on 6.6.7 kernel, looking
 for debug advice
Thread-Index: AQHaveNNuwZOR5PEkE+nHuOl38cAibHHPEiA
Date: Fri, 14 Jun 2024 13:09:13 +0000
Message-ID: <005CFD98-CF5B-4A33-9AB4-43FBE1FD8762@oracle.com>
References: <8ac2bb6f-63da-412f-8469-2a5be823fa40@usask.ca>
In-Reply-To: <8ac2bb6f-63da-412f-8469-2a5be823fa40@usask.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7111:EE_
x-ms-office365-filtering-correlation-id: 9709ad0e-8b47-4a97-7bb4-08dc8c732fdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?R1lGSzAxMlBGejBFMWcxS2lZZXJHWlpnMFdtMUhjVnRtZ3hueW9xNGgyWS9z?=
 =?utf-8?B?ZXM4SDNIR3lMcFpoVkc0bVJtSGkwU0hYK21xbXJWNnZlMWkwWU5aMU04MVhT?=
 =?utf-8?B?MVh5cW9RRjdYTEVJVUJOZnFYV3NtcEUxNkJqVmJLc2tBSDVhdGJBYWQ3QXJK?=
 =?utf-8?B?bC9YKzFEY2V6UExYQW1Rcm44NDdTZkpheWxKMEtMOFJSdE1ETnJuSktSSEJL?=
 =?utf-8?B?WDZua3pXYWRkRnE5VHcxbGxMS1ErS3lkMFNqeUNvOUk0YkJ1L1hrRk9aa1ZL?=
 =?utf-8?B?K3dvOWNOL0VLR3RqT3VzTzZjeTFqQ3I0L3FWZ2Vyc1ZCckZnZkN1ZkhuaktW?=
 =?utf-8?B?NTd2V3g4dDR4TUMwek9XU0RBemVHY2c4R1FYNkJ6Z051am5BSlk4WCtpdGNL?=
 =?utf-8?B?bWNmTU5xYXZtUEIyT3ZyRER1Z2pOb0dzY1NPWmpoTmZlRTRMcm1DWkZUV3Jv?=
 =?utf-8?B?a1d4cnN0SkVMdlBONjdIczVHOUlWdG81blBRSm83RVlZSXNVbXZjR1FNN3l2?=
 =?utf-8?B?Q2JnZFNENk80WElsVGxtRjNraXU0SEZMZ0hTVmNsWkFqNlAzZGlEeHVDOE4v?=
 =?utf-8?B?NnBIVStIM09wb2ZHUnhVV0FzV3JURkN3U1FmMkJqREVmNDAzaitscjk4RTNS?=
 =?utf-8?B?YU9rekRKZUs1RU1vS1pmV0cyMTZQYjlJY1M1amlEa3JQaTRFcktmYnBkUVFQ?=
 =?utf-8?B?YlROUU5wb2hwM3NXakpoVDVFcFJrMFVrcnYrVzhDTVhLenY2MG5UcXE4Ymtt?=
 =?utf-8?B?SzFMRXc3c09qRWtlLzE4NFFROEo5WTRYbWVRb0xvTjBEVlluQXp6ODN5dHZD?=
 =?utf-8?B?VGcvVzVybENLcXV0TWFkRStjTElSeW1kaUErK2FlcEFFcEdocUo2L0FZWG9F?=
 =?utf-8?B?bktndWxQd0FncGlUeWp1aTN6QzYxWG8zNGJWRkZYS2RDQ3BwWVpZOXc5d0Ev?=
 =?utf-8?B?SFFzdXN0YWNaazRRdCtTeGJZV3ZydHFIeXNmVWpFZk5zakNMcVdBL1IwazYv?=
 =?utf-8?B?Vm1TVllTaGRNazIzQ1dUNXVDcE4vTUZFVWRwYXRxY1FRSytITUk0V0owUlVZ?=
 =?utf-8?B?aWFhdHVCcWVXRHIybEpKaTdTTVlod0JxOEpFd0lNbTAyTS9ra2FmN3lvYmZ0?=
 =?utf-8?B?NVFuN3l5VkFvRkFxRDlqQjVBOHZLZFhVNTZBTDVNLzh6ckM3U3VWa0xJNXZY?=
 =?utf-8?B?Z1RUVmEyc01mczQ2am0zbHQ3blhCZjJ5SThGZTJHd2V1dzJZRnM3UXM4TnFm?=
 =?utf-8?B?N3Q0ZHd3VE1vb0V5QTJOSktEVVJQM2lGYU8zMmw1NFhnOStNNTgzeDJ5UjRZ?=
 =?utf-8?B?VW1MQTNIb0tEb25PcFJwU3J1RExRa2IwTXZvR21ibXFrMzZ5N3hOYThCOHZk?=
 =?utf-8?B?TU9Db3VVakZ0TjZ6SmR3ZGprRmJiTDRPdVZQY0F5TWxITzNGUFBXV200WGti?=
 =?utf-8?B?Z1BnVCs3bTdUTU1RNUthQWRkOWdJdnNvYXZjb3YzbC9tMG5DOFJRclFFU2N0?=
 =?utf-8?B?WXZHS3U4cnB4RjNKK1B1Mll1R3NwejNjWCt2STZsNmlDZ1ZCemU5Rkt6UnBI?=
 =?utf-8?B?OTd3TjR5dDVoUnNJTGtKcVI4SUF4SWRmaU4zU0RtUGNtUzUxemh1aFZYdDE2?=
 =?utf-8?B?UEhlS21UeDRlWXZNdjc5YTVQY0g3SmZZZG1DZVRUd25tWXdYUm8vVk8rYnJt?=
 =?utf-8?B?UnJSTDZvcm9IVHUrUGZzSmIreEdkbTZxekNteGhQdlcweFpydi9MQ0xCRUtG?=
 =?utf-8?B?UnhNWitHSjZoRTZFWWtIYWJkb1c1M2QwMkUvSmdSc2ZLbmdncURROHZ2aERv?=
 =?utf-8?Q?lgrV8hESbXijo6talgaY1etfhvlhvVGuUQ3SI=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VHVMTlZoVVlCbjA5OEw3ajdQUUFRL1JzR1lwZE5ic2VZZnNQT3AzQlJGbTVZ?=
 =?utf-8?B?VmF2YzBsRVN5NzdySnlZYzYwTUFZV0pSZEJwVTE4S21CRU1RTFNTVWttS01V?=
 =?utf-8?B?Nzd3VU94V0dQWmRabWllY2FaQ0wyTC9xUThxREhZYUJZR3FJOEpjNHJYdzd6?=
 =?utf-8?B?N045eU9IVWxMVFNMRk00U0o1N212dDd4UXpuYzkrOTNUMnE0UFJYb3c2VlZu?=
 =?utf-8?B?VGE0MmlOb3NKR3FpWW9LbU5PWis1dEJIWEdiN3BoOXlUOGZBTTMyUFE0dUpy?=
 =?utf-8?B?ZUxDZmVrTzVWZFlsWFJERXpxTGdXaGl6K3orUlJVbGwvTE5NdHhwMnNac0po?=
 =?utf-8?B?NkZvNkhXTjNzRlZ2bEdUSTRCRTBxUTA4VHJwQ01CWWNlM29ON1ZoUVoybysx?=
 =?utf-8?B?cEtIV1NtaGhGQm5uWC83UUtPMVZRM1pRSkt0ZkZXT0NsbHpzNGRBRFYrcEd0?=
 =?utf-8?B?MHNJc2xib3RiZUpBYkJRclVtYzJWcUxRZzd2TkxzejhINkcyWHNJK2czcFpa?=
 =?utf-8?B?VnNpcEUyeG15Z21XT1Y0eGVVRm8zc0VxWXN1WXl2b2NhRXBHaXBudlB3L3g4?=
 =?utf-8?B?OCtwOEltbUdYRXNrSjBGN0h4TWNBYUp6bTYxRzNyYjBMY3k5YTRlYlRwSmtu?=
 =?utf-8?B?bWJuNnRJRlRXb05CcU1ZSTdLUEo2dThGVlFkQzdBenlrbnc2OTd0NFJ3NFB1?=
 =?utf-8?B?a01ldTlHQW9BSkU0N3ZOYmdrS0xSb2JSM250ZWY2eHVlRTUvRWdkTWJKRDBa?=
 =?utf-8?B?b21nbTZaeGlnS0tMa0xpbHZaaUFtRFpnVVBvcVFPM1dzK0JveWhuVlBSTGR2?=
 =?utf-8?B?ZkMrSDZLTlhacVV3N0E5YjJCanN4dDYwY2UyNmZKVVJOUkhGTGMydnJIRHR5?=
 =?utf-8?B?K0pHY1IrS0VFd0RWVlJLR2xsZkNhWmRoSUFOSS8wakhRaHo4SWJvbW52dUNE?=
 =?utf-8?B?RldvMThXU29ROExzVm1YaFhYQ1NlR1BmaFZzQ0R0UG5ldzRScFRBN1hDWDNx?=
 =?utf-8?B?Qm9XaTJPc0luVWY3bW96K1Fqdys5Zks0R1BoYldKUldtNUdnTmhWWjF3MThq?=
 =?utf-8?B?RVV2MER6UVgzMU40Q0VlK3QwQ2lQQ2RLREdLOFdVRGxONnNhQ2c5L3EzaGZ4?=
 =?utf-8?B?OFVqTTZNQVdrWk8wa3ZuNjc0UzFHZnNrSlZZeWxWYlZQRkVodUx6Q2xMU1dZ?=
 =?utf-8?B?bUVzTWtJZXZxa09zQnJKQU5DUElZU21QQU5MTjVLT05aWmxmRU5vQWg1cFR5?=
 =?utf-8?B?RkhDMXh1ZlZ3aGVQMnZJcWhETEoyMVREdk5VOVF3MFIyU0pwSjJqUWtBemMx?=
 =?utf-8?B?azk3bDRESWhVRzR6dnFCcDFQeGVNWjc2SGFPRU1OaDZlVjFJRFlqSUNmOUM0?=
 =?utf-8?B?ZFhJUjlzWjBkcUNacnRLZ1hHdXZuOGlaTjdUREtyNmJHNGwvUVM0YVJpZ09R?=
 =?utf-8?B?bXJRUE5CRW5mK0xFSndwOVZOS0NVYlIvMllkQnk2MnEvVEkzUFNIbVFXSWU5?=
 =?utf-8?B?d0ZraGVOSGdoakhlNm5wL1gwMGw0SnRPTTMxT1lMa1EwREp2MllLazRwNDZM?=
 =?utf-8?B?YjEyUUhteTI1Ri9jSklVOTBXajVLZklBRGx1ekVqY3daT2RxMksvTTlqcFVI?=
 =?utf-8?B?dUlFY2NtSWRxRit6SjZLYVE0Q1FkeEhzaWdKZjZMaDdVc2NlTm1oaGpCdjZy?=
 =?utf-8?B?NXZ1a1RmdG9FcDNMYzd5UzNBazRGVXgvV1JsdGpySnhmbldLaFplcXFCalFx?=
 =?utf-8?B?dEMvcHIyVjZDZlNoUElVb0NUMHJ4THZkN0ZyVkNPdEdzQ3ExTjlQbkhHbVJT?=
 =?utf-8?B?V2dRSU9TTWJBZjBEQUwwUW1hZW1HSDJXR3gyVUYybE0zakRKd0dNVmlHNktx?=
 =?utf-8?B?Z25lbEs1MzRVd29uNlBVNjUxNUk3c2VadUlHWVZhdTA1NEJ5WTRyQ0pqbVhu?=
 =?utf-8?B?TitQaG1SQVpmNGhqSzlZbHF5Rk1BdUdHSzJaQWpJcnlhN1JUQjNwQ2MyMnZ1?=
 =?utf-8?B?TnlGeEpZaEoydXFkTHJQa3prQ3lPSUZsRDdoR3FxYXBnbHVYSnc2cC9iVTJs?=
 =?utf-8?B?bE1wMUVsM1Jac2Y5Zmk1OGpWS0RPL2RZcGJDUVZrZG5vNUIwYk90am5VZmV5?=
 =?utf-8?B?LzZ3OGpsMG9mRGM3VlZnTDdiY1UxUWkvdGxYbllnQnJyZmVaMWhvb0p5ZFBl?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A751B4C8E0C3364A90C63C738D7968CA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	02pO0pLFC7HVwst0g8hNlS6kofT/+cfRPXZgjDuxgvP9PL187yevgne99h7PPz9CvJEuj8dUSECeop4lTGtAifW7QS9cD1Phe1UAUkwM0cL6R2M8iEgBBZOpEd6pdZ576VOv3vL9vyquX5nyfV+F9TqKcjXnL5O5AoZBHkyro79ClW0eeul4H66e+IsCT9NSJTaSlEWiIwXdN+batrKjVSVjDSNmzIIi+8MgXTh9R1iR5zjI5Lk6kLA8sDrt3U7X0HXl2tei0NQo17q8tZl21PLE3zRJJMEOkNsXXpcybBb7z103oCLGcpxLVsVc2Edf2dZIBdYM/WV3+HsveAXfZo8jrtM6y/d8k9eA+zJgMPGLQlFglThsXSq9GNzRWQSHKg03EF5P4L6KtQhu1EfrUIROmd/sqp1SwdgbmpRgUX98eWqMMkRg7zffehoZKcKjgeAsFwHnd4c5hWPaySLZdvFAllgEck00jXvtZi+86bxF1XFhJsFpj2CcT4X/8vpJ+LcvP8kbmZk7V4N2e7l29QPlahB+3qv6P4+/9z/Z8jj41cGgVCvQk+I6Y4vT+NyeMmdMtnMXWgJtSQxM80lXSzsRMDOCQxiJ+QNEsS10D94=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9709ad0e-8b47-4a97-7bb4-08dc8c732fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 13:09:13.1978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1rSIilfGTN2xLE2/NwY9w3ubM4C4xhzHHexVu6atXlu9ccbaaHNGQS3zKoxYjbbyzJ4uCbTqeyLDKQFQbbM9WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7111
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_10,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406140088
X-Proofpoint-ORIG-GUID: Z9SAvVo1ZNA2qnFwi9NnHUdWjfH4Bdpy
X-Proofpoint-GUID: Z9SAvVo1ZNA2qnFwi9NnHUdWjfH4Bdpy

DQoNCj4gT24gSnVuIDEzLCAyMDI0LCBhdCA2OjQ04oCvUE0sIENocmlzIEZyaWVzZW4gPGNiZjEy
M0B1c2Fzay5jYT4gd3JvdGU6DQo+IA0KPiBIaSBhbGwsDQo+IA0KPiBJJ20gbm90IHN1YnNjcmli
ZWQgdG8gdGhlIGxpc3Qgc28gcGxlYXNlIENDIG1lIG9uIHJlcGxpZXMuICBJJ20gc2VlaW5nIHNv
bWUgb2RkIGJlaGF2aW91ciBhbmQgSSdtIG5vdCBzdXJlIHdoYXQncyBnb2luZyBvbi4NCj4gDQo+
IFRoZSBzaG9ydCB2ZXJzaW9uIGlzIHRoYXQgSSBjYW4gbW91bnQgTkZTIGV4cG9ydHMgZnJvbSB0
aGlzIHNlcnZlciAoaW5jbHVkaW5nIG1vdW50aW5nIG9uIHRoZSBzZXJ2ZXIgaXRzZWxmKSB2aWEg
VENQIGJ1dCBub3QgdmlhIFVEUC4NCj4gDQo+IHJwY2luZm8gb24gdGhlIHNlcnZlciBnaXZlcyB0
aGUgZm9sbG93aW5nOg0KPiANCj4gcm9vdEBjb250cm9sbGVyLTA6L3Zhci9ob21lL3N5c2FkbWlu
IyBycGNpbmZvIC1zDQo+ICAgcHJvZ3JhbSB2ZXJzaW9uKHMpIG5ldGlkKHMpICAgICAgICAgICAg
ICAgICAgICAgc2VydmljZSAgICAgb3duZXINCj4gICAgMTAwMDAwICAyLDMsNCAgICAgbG9jYWws
dWRwLHRjcCx1ZHA2LHRjcDYgICAgICBwb3J0bWFwcGVyICBzdXBlcnVzZXINCj4gICAgMTAwMDI0
ICAxICAgICAgICAgdGNwNix1ZHA2LHRjcCx1ZHAgICAgICAgICAgICBzdGF0dXMgICAgICAxMTYN
Cj4gICAgMTAwMDAzICA0LDMgICAgICAgdWRwNix0Y3A2LHVkcCx0Y3AgICAgICAgICAgICBuZnMg
ICAgICAgICBzdXBlcnVzZXINCj4gICAgMTAwMjI3ICAzICAgICAgICAgdWRwNix0Y3A2LHVkcCx0
Y3AgICAgICAgICAgICAtICAgICAgICAgICBzdXBlcnVzZXINCj4gICAgMTAwMDIxICA0LDMsMSAg
ICAgdGNwNix1ZHA2LHRjcCx1ZHAgICAgICAgICAgICBubG9ja21nciAgICBzdXBlcnVzZXINCj4g
ICAgMTAwMDA1ICAzLDIsMSAgICAgdGNwNix1ZHA2LHRjcCx1ZHAgICAgICAgICAgICBtb3VudGQg
ICAgICBzdXBlcnVzZXINCj4gDQo+IHJvb3RAY29udHJvbGxlci0wOi92YXIvaG9tZS9zeXNhZG1p
biMgcnBjaW5mbyAtcA0KPiAgIHByb2dyYW0gdmVycyBwcm90byAgIHBvcnQgIHNlcnZpY2UNCj4g
ICAgMTAwMDAwICAgIDQgICB0Y3AgICAgMTExICBwb3J0bWFwcGVyDQo+ICAgIDEwMDAwMCAgICAz
ICAgdGNwICAgIDExMSAgcG9ydG1hcHBlcg0KPiAgICAxMDAwMDAgICAgMiAgIHRjcCAgICAxMTEg
IHBvcnRtYXBwZXINCj4gICAgMTAwMDAwICAgIDQgICB1ZHAgICAgMTExICBwb3J0bWFwcGVyDQo+
ICAgIDEwMDAwMCAgICAzICAgdWRwICAgIDExMSAgcG9ydG1hcHBlcg0KPiAgICAxMDAwMDAgICAg
MiAgIHVkcCAgICAxMTEgIHBvcnRtYXBwZXINCj4gICAgMTAwMDI0ICAgIDEgICB1ZHAgIDQ0OTkz
ICBzdGF0dXMNCj4gICAgMTAwMDI0ICAgIDEgICB0Y3AgIDYwNTYxICBzdGF0dXMNCj4gICAgMTAw
MDAzICAgIDMgICB0Y3AgICAyMDQ5ICBuZnMNCj4gICAgMTAwMDAzICAgIDQgICB0Y3AgICAyMDQ5
ICBuZnMNCj4gICAgMTAwMjI3ICAgIDMgICB0Y3AgICAyMDQ5DQo+ICAgIDEwMDAwMyAgICAzICAg
dWRwICAgMjA0OSAgbmZzDQo+ICAgIDEwMDIyNyAgICAzICAgdWRwICAgMjA0OQ0KPiAgICAxMDAw
MjEgICAgMSAgIHVkcCAgMzY5OTMgIG5sb2NrbWdyDQo+ICAgIDEwMDAyMSAgICAzICAgdWRwICAz
Njk5MyAgbmxvY2ttZ3INCj4gICAgMTAwMDIxICAgIDQgICB1ZHAgIDM2OTkzICBubG9ja21ncg0K
PiAgICAxMDAwMjEgICAgMSAgIHRjcCAgMzMyMzkgIG5sb2NrbWdyDQo+ICAgIDEwMDAyMSAgICAz
ICAgdGNwICAzMzIzOSAgbmxvY2ttZ3INCj4gICAgMTAwMDIxICAgIDQgICB0Y3AgIDMzMjM5ICBu
bG9ja21ncg0KPiAgICAxMDAwMDUgICAgMSAgIHVkcCAgNDM2MzYgIG1vdW50ZA0KPiAgICAxMDAw
MDUgICAgMSAgIHRjcCAgNDkzNTcgIG1vdW50ZA0KPiAgICAxMDAwMDUgICAgMiAgIHVkcCAgMzk3
ODMgIG1vdW50ZA0KPiAgICAxMDAwMDUgICAgMiAgIHRjcCAgNTQ1MjcgIG1vdW50ZA0KPiAgICAx
MDAwMDUgICAgMyAgIHVkcCAgNDA5NzAgIG1vdW50ZA0KPiAgICAxMDAwMDUgICAgMyAgIHRjcCAg
NDE3NjEgIG1vdW50ZA0KPiANCj4gDQo+IFNvIGl0ICpsb29rcyogb2theSB0byBtZSwgYnV0IGlm
IEkgcHJvYmUgaXQgSSBnZXQgdGhlIGV4cGVjdGVkIHJlc3BvbnNlIGZvciBUQ1AgYnV0IG5vdCBm
b3IgVURQOg0KPiANCj4gcm9vdEBjb250cm9sbGVyLTA6L3Zhci9ob21lL3N5c2FkbWluIyBycGNp
bmZvIC1UIHRjcCBsb2NhbGhvc3QgMTAwMDAzIDQNCj4gcHJvZ3JhbSAxMDAwMDMgdmVyc2lvbiA0
IHJlYWR5IGFuZCB3YWl0aW5nDQo+IHJvb3RAY29udHJvbGxlci0wOi92YXIvaG9tZS9zeXNhZG1p
biMgcnBjaW5mbyAtVCB0Y3AgbG9jYWxob3N0IDEwMDAwMyAzDQo+IHByb2dyYW0gMTAwMDAzIHZl
cnNpb24gMyByZWFkeSBhbmQgd2FpdGluZw0KPiByb290QGNvbnRyb2xsZXItMDovdmFyL2hvbWUv
c3lzYWRtaW4jIHJwY2luZm8gLVQgdWRwIGxvY2FsaG9zdCAxMDAwMDMgMw0KPiBycGNpbmZvOiBS
UEM6IFRpbWVkIG91dA0KPiBwcm9ncmFtIDEwMDAwMyB2ZXJzaW9uIDMgaXMgbm90IGF2YWlsYWJs
ZQ0KPiANCj4gDQo+IE9kZGx5IHRoZSBsYXN0IGNvbW1hbmQgcmV0dXJucyBpbW1lZGlhdGVseSBz
byBpdCdzIG5vdCBhY3R1YWxseSB0aW1pbmcgb3V0LCB0aGUgZXJyb3IgbWVzc2FnZSBpcyBhIGJp
dCBtaXNsZWFkaW5nLiAgIElmIEkgc25pZmYgdGhlIG5ldHdvcmsgdHJhZmZpYyB3aGlsZSBydW5u
aW5nIHRoYXQgbGFzdCBjb21tYW5kLCBJIHNlZSB0aGlzOg0KPiANCj4gcm9vdEBjb250cm9sbGVy
LTA6L3Zhci9ob21lL3N5c2FkbWluIyB0Y3BkdW1wIC12dnYgLWkgbG8gcG9ydCAyMDQ5DQo+IHRj
cGR1bXA6IGxpc3RlbmluZyBvbiBsbywgbGluay10eXBlIEVOMTBNQiAoRXRoZXJuZXQpLCBzbmFw
c2hvdCBsZW5ndGggMjYyMTQ0IGJ5dGVzDQo+IDIwOjIwOjUzLjE1OTc0MyBJUCAodG9zIDB4MCwg
dHRsIDY0LCBpZCA1ODI1MSwgb2Zmc2V0IDAsIGZsYWdzIFtERl0sIHByb3RvIFVEUCAoMTcpLCBs
ZW5ndGggNjgpDQo+ICAgIGxvY2FsaG9zdC44ODcgPiBsb2NhbGhvc3QubmZzOiBORlMgcmVxdWVz
dCB4aWQgMTcxNzYxNDExMCA0MCBudWxsDQo+IDIwOjIwOjUzLjE2MDAxNiBJUCAodG9zIDB4MCwg
dHRsIDY0LCBpZCA1ODI1Miwgb2Zmc2V0IDAsIGZsYWdzIFtERl0sIHByb3RvIFVEUCAoMTcpLCBs
ZW5ndGggMjgpDQo+ICAgIGxvY2FsaG9zdC5uZnMgPiBsb2NhbGhvc3QuODg3OiBbYmFkIHVkcCBj
a3N1bSAweGZlMWIgLT4gMHhmNjYzIV0gVURQLCBsZW5ndGggMA0KPiANCj4gDQo+IElnbm9yaW5n
IHRoZSBjaGVja3N1bXMsIEkgZ2V0IHRoaXM6DQo+IA0KPiByb290QGNvbnRyb2xsZXItMDovdmFy
L2hvbWUvc3lzYWRtaW4jIHRjcGR1bXAgLXZ2diAtSyAtaSBsbyBwb3J0IDIwNDkNCj4gdGNwZHVt
cDogbGlzdGVuaW5nIG9uIGxvLCBsaW5rLXR5cGUgRU4xME1CIChFdGhlcm5ldCksIHNuYXBzaG90
IGxlbmd0aCAyNjIxNDQgYnl0ZXMNCj4gMjA6MjE6NDkuNjQyNTg4IElQICh0b3MgMHgwLCB0dGwg
NjQsIGlkIDIyMDI2LCBvZmZzZXQgMCwgZmxhZ3MgW0RGXSwgcHJvdG8gVURQICgxNyksIGxlbmd0
aCA2OCkNCj4gICAgbG9jYWxob3N0LjkzNCA+IGxvY2FsaG9zdC5uZnM6IE5GUyByZXF1ZXN0IHhp
ZCAxNzE4Mjk3ODc2IDQwIG51bGwNCj4gMjA6MjE6NDkuNjQyNjk3IElQICh0b3MgMHgwLCB0dGwg
NjQsIGlkIDIyMDI3LCBvZmZzZXQgMCwgZmxhZ3MgW0RGXSwgcHJvdG8gVURQICgxNyksIGxlbmd0
aCAyOCkNCj4gICAgbG9jYWxob3N0Lm5mcyA+IGxvY2FsaG9zdC45MzQ6IFVEUCwgbGVuZ3RoIDAN
Cj4gDQo+IA0KPiBPbiBhIHNlcGFyYXRlIHN5c3RlbSB3aXRoIGEgNS4xMCBrZXJuZWwgSSBnZXQg
YSBzdWNjZXNzZnVsIHJlc3BvbnNlIHRoYXQgaXMgbG9uZ2VyIGFuZCBpcyBwcm9wZXJseSBkZWNv
ZGVkOg0KPiANCj4gcm9vdEBjb250cm9sbGVyLTA6L3Zhci9ob21lL3N5c2FkbWluIyAgdGNwZHVt
cCAtdnZ2IC1LIC1pIGxvIHBvcnQgMjA0OQ0KPiB0Y3BkdW1wOiBsaXN0ZW5pbmcgb24gbG8sIGxp
bmstdHlwZSBFTjEwTUIgKEV0aGVybmV0KSwgc25hcHNob3QgbGVuZ3RoIDI2MjE0NCBieXRlcw0K
PiAyMjoyMjowMC4zODg0OTcgSVAgKHRvcyAweDAsIHR0bCA2NCwgaWQgODA2LCBvZmZzZXQgMCwg
ZmxhZ3MgW0RGXSwgcHJvdG8gVURQICgxNyksIGxlbmd0aCA2OCkNCj4gICAgbG9jYWxob3N0Ljgw
OCA+IGxvY2FsaG9zdC5uZnM6IE5GUyByZXF1ZXN0IHhpZCAxNzE4MDM3NTc4IDQwIG51bGwNCj4g
MjI6MjI6MDAuMzg4NTI1IElQICh0b3MgMHgwLCB0dGwgNjQsIGlkIDgwNywgb2Zmc2V0IDAsIGZs
YWdzIFtERl0sIHByb3RvIFVEUCAoMTcpLCBsZW5ndGggNTIpDQo+ICAgIGxvY2FsaG9zdC5uZnMg
PiBsb2NhbGhvc3QuODA4OiBORlMgcmVwbHkgeGlkIDE3MTgwMzc1NzggcmVwbHkgb2sgMjQgbnVs
bA0KPiANCj4gDQo+IEFueW9uZSBoYXZlIGFueSBpZGVhcyB3aGF0IG1pZ2h0IGJlIGdvaW5nIG9u
IG9yIGhvdyB0byBkZWJ1Zz8gIEknbSBidWlsZGluZyBhIGtlcm5lbCB3aXRoIENPTkZJR19TVU5S
UENfREVCVUcgZW5hYmxlZCB0byBzZWUgaWYgdGhhdCBnaXZlcyBhbnl0aGluZyB1c2VmdWwuDQoN
CmxpbnV4LTYuNi4xNSBoYXMgIlNVTlJQQzogdXNlIHJlcXVlc3Qgc2l6ZSB0byBpbml0aWFsaXpl
IGJpb192ZWMgaW4NCnN2Y191ZHBfc2VuZHRvKCkiIHdoaWNoIG1pZ2h0IGFkZHJlc3MgdGhpcyBp
c3N1ZS4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

