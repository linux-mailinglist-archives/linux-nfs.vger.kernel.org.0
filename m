Return-Path: <linux-nfs+bounces-3126-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD84E8B9B2E
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 14:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9376B20A93
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 12:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36563E47E;
	Thu,  2 May 2024 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BDSdhVt2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x679XGai"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9CC32C60
	for <linux-nfs@vger.kernel.org>; Thu,  2 May 2024 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714654653; cv=fail; b=W6Y1LzR/zzCICglSlsH8OtT4zY3JtBnrfN8x1fhCnUcQSpdOILWe7uO5gQHdynw2N0Zju+7gXRR3vIGnXUpAGFYKICwz2j0Rd7QALC6y2nsfbrJtNGb5nWp4sPpY/7q1StuG1hYFDkg1YubRIHhM4BqeLCgZN/bAISwetsB4eCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714654653; c=relaxed/simple;
	bh=l+85JZ9B6e5aS3Gmjtdr2g6zvCWKN402Tw5nuNYTFlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s3nZ/0ZVmLQi3kyEGpo5RAQPJx3sfdJRPrqDAukgrZHybB0ut869mgV/4ZlVxdq0iYG2NLb8pt57GbVU7cf5pdhrdraio0b33Gb6ZMsi+YJCsU1IY5/VHsz5UeyMAvgX2X7b+ilAIb4LDX4Dd2RHiezzHcjwHZb3HxX5Eb6VPAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BDSdhVt2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x679XGai; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442Cd3gO010053;
	Thu, 2 May 2024 12:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=k5YruZdc4+W/vQDydn1oAASPG3rmM1hq6UO2WgiPjnA=;
 b=BDSdhVt2OdMI6zjZvKEB0jBmPZo/NL/sM3bDDD6ZVsUSB7gR4o3R5LZ8hB0RJehCbV6l
 4kS+fV9SHSTvgelQudQlZchYkwXoaL5q2ZGlwa6QWzMOZX11jaihVL30BUvukvlgtxrZ
 A9IjIF++lnkTu3hItaFol7hgRGDebyqNWFDxe+Pxd1Ym6pAP3KzVRbG+/O80gd8Dj7PW
 wA+AaXqf8XYjEOQ+NGFKlk4/qMaqAhagFpDwTJa5Pq0LEOykM1D3wfjNI2/v9QPuztZP
 GaKPviQ6mxNFyrkElzFvVRJAhyYWY6IJRTEQHWkLRlX7laVp5tz+Ilbefk1UeyNaPFRR hQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrryveda0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 12:57:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 442CdapH008820;
	Thu, 2 May 2024 12:57:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xu4c2622n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 12:57:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLOicDfJ2pMuM9FJemHsk7ZXuzYfLNKqoCNxwRQVbwzkjMWexnQo2nubiHI23/qh2qKw97iExTz4KyUU1loBacxNQI9ynw0k0BfeFlQdFHxYKE4P3zo2BeDHHHKvQS+r8hMPS56r/cv7Uz2pNOJzGmvscLBNgoeS9q/fJo+I7bCEyUE54wJavVE0KiE+ryZnbFgUIPurJOnHA/Aw5UIMo7lt3MyRXVKTauqyD/C3bWCehkJVAEIf+w908DERz4WdC74XRH1Npc7XV2P9iEMQ/MS+CsZrkbGaHsEVOku/U7Gmz9DTMNUf3//JKe5deN/8JZfVpqYJelxPSmkFB/K0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5YruZdc4+W/vQDydn1oAASPG3rmM1hq6UO2WgiPjnA=;
 b=R7qQaL8gvZRIw4qo/+rB3vWMUAzacGh4cXgFXljNeQCmJ9EXwTi/yoAaKRC/lPcnMykHWylOOx8JLxM4mlmF5rtDqv/M+DntQTObf7Pm3f58YTI/wPyPevtW1Z6F7XA093pA/1yAarhcYqFg/Pvo9Rs7BY1Qpk7T0iJk1T0dmWrP0XjpVPKhLiClSAuM0Aw8sfg3dA/C3BZh4XXaNuUGqbLRZk99aXwdmeH+bS4XNS1s4KT0/hlfDdSQAZiNw3KJTuhbQI/qrvc7jSoSb4+9lhMIEkbwHfTpQ4rt2CljDiuHnCB8FU8F7kIsEZmEWdBMaDbD8hPwjRdJFbStWBvZHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5YruZdc4+W/vQDydn1oAASPG3rmM1hq6UO2WgiPjnA=;
 b=x679XGaiWSxBmZ43gQfH38J04HWBuhvIrcJ5bEOOdyqSprTPOeued/Vb0VR54z7qTAQo3fzbq8v+Q3hSJ2T5exsLT69QrAWIaIDYjbPnl+AG51vTMN+GzLodR2g3SdjNZanfw+X35lU9hPQe31Dw5eAsNaOFYgdgEcouGnygobc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM3PR10MB7910.namprd10.prod.outlook.com (2603:10b6:0:b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.30; Thu, 2 May 2024 12:57:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 12:57:18 +0000
Date: Thu, 2 May 2024 08:57:15 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Fails to build on =?utf-8?Q?arm{el=2Ch?=
 =?utf-8?Q?f}_with_64bit_time=5Ft=3A_export-cache=2Ec=3A110=3A51=3A_error?=
 =?utf-8?Q?=3A_format_=E2=80=98%ld=E2=80=99_expects_argument_of_type_?=
 =?utf-8?B?4oCYbG9uZyBpbnTigJksIGJ1dCBhcmd1bWVudCA0IGhhcyB0eXBlIOKAmHRp?=
 =?utf-8?B?bWVfdOKAmSB7YWthIOKAmGxvbmcgbG9uZyBpbnTigJl9?= [-Werror=format=]
Message-ID: <ZjONq6cf2MEmVSBK@tissot.1015granger.net>
References: <ZhGfUpXclZeoZ_az@eldamar.lan>
 <A3AAF9FA-95BE-461C-8E7A-C0ED02526519@oracle.com>
 <ZjMd_DCJrV0tHY1K@eldamar.lan>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjMd_DCJrV0tHY1K@eldamar.lan>
X-ClientProxiedBy: CH2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:610:20::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM3PR10MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 936543c1-8bac-4e91-4bad-08dc6aa76620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Tm91cGFTWlZDZTBHNEl6SHkvK0pqajNIa0N0Nk05eEF6Ny9QM0JSU1J5a3l6?=
 =?utf-8?B?Zk9DU2FkZzBja0p3dk1WaXRXMzNqUUtuaHB2SEpCVXVGQ2NOeWpkWWdqWW5n?=
 =?utf-8?B?RXQ0YkJxb2JTQmZNV1UyOHBESnRrMWt1MTNRUHpIUFdCbnJxNnc1cjNsSmZF?=
 =?utf-8?B?QmlUc01kYS92MmsvNW12VGs2TmhXenl4Z2R3MHBEU3hrVnNIcGZ0b29TRVJo?=
 =?utf-8?B?L2praVpCcWJYME9SQkcvSnVieTdqOVdISWtYSC9ZbktsRlJCNEpKTEt6OHh0?=
 =?utf-8?B?eElKQVB3d2UxZllUTWs3QW1yMnVGM1FxZlVXSlRheVdieEd6WW1qWVpxdkx1?=
 =?utf-8?B?R0NDQmxDZm9XMm1sRndSbVVYd09lUG5PMG1aTVFyQU5ZdDdmL1prcklLWndY?=
 =?utf-8?B?emdsalZ4MVlmMkMwcXJTTVZ1dUoxNHlOeDZIZUVoWU1ZYllhb3F6SGRLcEhD?=
 =?utf-8?B?Z05Nem9qVW11amRod3ZCSDI4OWJwWVg1bjBFRnFkeVNoWjhrbUxSTXlwSDlV?=
 =?utf-8?B?UGR3YlIwRkVuNnE3OEltdDNWb1VKUDFGL2E0TThVQWMxd3NzQ2dNdGJIejRD?=
 =?utf-8?B?Zzk0OWFIaEZvOGNkTWlJeTFoVThSa0FnWjN4ckhlcC9tS1RZYmhRTDBHOVhE?=
 =?utf-8?B?bVVFRlFhUGxsaTVGK2RtV2N6Z2M3U0w1emxHUldsZUlKWGlhdEVEL25vSEtQ?=
 =?utf-8?B?LzdHdHhKUEw5eFpjQ05CUGdqWlYyUUFkdUNvMDgvRWlDV0gxZUFIV09WK1lQ?=
 =?utf-8?B?Z2FnMGtRZXdFVHk0U1pxN3BWRnBnemZ4UzNOVjdpcXRISEdhYXAzWEtlcFFi?=
 =?utf-8?B?SldUajh6R2J4MEdFK2NPaXZ1RWJZbS80Mm0vb1lVNTNxU05RNTZRSkZGczQw?=
 =?utf-8?B?eDMxVmsvMFI5aGdueERyTDJVTmYvdkxZRU1jTEl5U3plRGpxYTB6WDdBWGFM?=
 =?utf-8?B?Rkl5dGltOEltVFJMMVR5OGpWaUtYbm5Hc0VkN1hCWGNhYjl1TEM3R3JzMmhI?=
 =?utf-8?B?R2l5UG5BbzViTWpuSFdHUFZ0ZFo4RjdBNUVqWTlqOG13M3VMRWR0VEUyaG5O?=
 =?utf-8?B?TFhYM3M1UnRZSWNjczdZUjJxZFZTcHA2aXhlekd0bVZ6Q01yZ0xuVGN3OWxI?=
 =?utf-8?B?ZXZDd1Z6bVVORzN0ZlBDVFdOb2lhY1NFWHE5NFdZdnVMa09zOU54NjFJeTN6?=
 =?utf-8?B?bzRqL3ZxZDYrTUMwWkZ2L0lZNG1wMFVMTmdEdG1GN1lkcml6dWV0ZTdldnJz?=
 =?utf-8?B?TWxmMUJtYTUyTE5LL0ZITkRQTGs1cVMzcUp2QjNEMmtJaE10eU14K1dQYWRx?=
 =?utf-8?B?azdFTzM5NmpnTHB6QU5iRSt2OUpJdHErcm1mWTZpeXVuL0QzZTJnT1JqSU1W?=
 =?utf-8?B?MUE3VG5Jdm5zdzJaeFYyT0FoWDJoYWdCOTE2Z2RmRXZya1g5cTNYbE5ScmQ0?=
 =?utf-8?B?WUt2V3VHNGtLaDFpZy82WDZsNGtjTzk3Q09Zd2I2UFl1L3liVzlnVmhCNXVr?=
 =?utf-8?B?TmVGbXE2VUNxK3RsUnhPMXFaeHFxbE5iU05Zb0ZkM2x6NnJLb2VIZ01PVkhw?=
 =?utf-8?B?Qzc1T3lDakJnazBtNU1pcUlHbHVnT1NSZFQ2b0JKY0dJYU1HZG5vTlZHZ2F5?=
 =?utf-8?Q?jCkwYtMGPYEN8U409BI0VMt9VNsNy26kie6CxNy7eXWs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QlB2dnRSRm8wcHhlZUNjVnQ1Q0U2Y0ZJWXRZVU9KWGw4bkJwSG0xMU1OUE9n?=
 =?utf-8?B?b1lhTWIrMVU2ZWxkOUg1dytrMmozWGh5SWd6L1hFT21rVVZIOU0wcHZNMzN4?=
 =?utf-8?B?KzBDNlJHYSs1cU9GUEpPOVNDUWJhazJ6TG11d1NaRDBJSFJvVXg5ZkRqTVhQ?=
 =?utf-8?B?bVdyWnl1Ylk2WThIVVZwQWw3SnBaNUdTcGRONXNFMThHVkdoUXlnYUVOZEJK?=
 =?utf-8?B?M2pZQ3QvT3hKbWloSzR2TkY3RmRoRHIraFk3OWs4V0JnWGNkeXk2cUJlVk1Z?=
 =?utf-8?B?eGNvd2RmZjBqMjMvTUZ3djVFeTBualpvVHVuVEVtTnFwR05OcHpXN1VCZlRh?=
 =?utf-8?B?VkQyS0dIMHlpbk9jcGp0ODNtaTk1dEZiVE9IQWM3ZVYzQnFRa2taZUkrajBL?=
 =?utf-8?B?eWtGWU9yS0gzNk9tOU1KTWwvUUY2MnU4YWVCT3VmQXE5d2JIVDhsbVJwTitj?=
 =?utf-8?B?M3cySyt4aEhkQ1FzL050RlZJRXNkUWVmb3JtVG1uR3ZsTWlDVGJRWHRVbGpw?=
 =?utf-8?B?WCtiSEtTeHpEbFRqazRGTVowd0lOQW1GaU80S2R0UXE5czQ5b1NyV3E3bVVK?=
 =?utf-8?B?eXJHQStkMVpwVGc5ZG1OVlhYZ1phMXI1RExzSU1GTlJVcXpvN2pRb1c1V3I1?=
 =?utf-8?B?cXBCQXluUFF1U3dmVitJbGxleWlLSzF1VW1LZnl0ZjVydVE1L0pXenlwWVQ2?=
 =?utf-8?B?ZUR0TjVnMmpyV3plRlF0SEUzakc2WWRwZ2ZNU25GVUJma0pZMlM0UzI4NTJv?=
 =?utf-8?B?MEdEZmIwcWNCUGVtZEE4NzMyODRSWW96eXhlcDl4Z3NscGd1RUdMQnl5L2dl?=
 =?utf-8?B?S25yRk45NmE5ZTNtSTlwWEIzRVBVWWdnYkRyMHFUbmRwU3VGS0ViYTc3REdr?=
 =?utf-8?B?S3V2WXBLRExuLzkwVSszOGV4azNUUGJDZWpXVVJNdDIxdklHbmFmSGNkMVBh?=
 =?utf-8?B?aWdLYzdST1JNWkNFTk4vbVZkVW13eXdwbjQyWG1rTnlJRkpEbGVFbEoxd2h1?=
 =?utf-8?B?WG5jYUt2NHovcjNCUTZlY1BrVjFFS2dEd0l6Nm1nVEdJaEpHbnZ5SzBPQm5L?=
 =?utf-8?B?M1JVcitoWmZQbGdURTBZRzdzRERuZSt5NVNDSEN5RTRtOThweEJ4OXoydnJ4?=
 =?utf-8?B?RnBVd001ZE5EeTREQjZKa3J1aVJFellKRTNsa0RaM0ppb3NoUjEzanJRNERK?=
 =?utf-8?B?SHJEdDJKMDZRY3lWTXkrOTI3SkVWZnp3elBoTE0wWDZTeEhsaFZIZHQrZ3VR?=
 =?utf-8?B?NXJrSVgrNyt4WEFaNHFEbmQ4eXFjazJSN21LbHFlQ1h1SzU5YTlwb3ZRaWxw?=
 =?utf-8?B?MlhHNjJDelBJMHIvbW1YQS9kTkVicFE4eU83ZWQwekR4QmZmRm52UkNiRVdo?=
 =?utf-8?B?TFU1TWZsRndPazRjdGJienhzZUhsNlNqRG8vRWwxaVdvb2VRMFBiUlQ5Y3o1?=
 =?utf-8?B?dkhBS0FHZThoalBvRWpuQWIwSVlydWt6TG5yRW9iWlY0V01wVFRZQkg5eUVX?=
 =?utf-8?B?MEFmcXAwOVg4YlRwMGVoL1l1MWNPdW5IeTc0SCsvbmU2NnhMdElsZ3UzeFEy?=
 =?utf-8?B?MC9iUUlKOXo5cUtHdWhuZk8zOGhESGVCQ3RNZ0NCZU1LMVA0VXFUNlNLL1VT?=
 =?utf-8?B?UnBneENqNmxScENPejRwWWh1TzdZNTE1VGd0dlBTeTJYNWU3dHJMSUpobUZz?=
 =?utf-8?B?Sm5HWElobjlEbENsYjRlMzhEa2dKZWRFS1lralhqSlB0M1BvSEdncEpXWUZs?=
 =?utf-8?B?aEY2Z1BDcTU0YU9NSHBiZStJVmRlVmRwTXBZSHZlN3R4MGIrcmxsUmN2eis1?=
 =?utf-8?B?NVpUWEMvMjFBOEQwQ1pjb2JpWXNVYWV2RjJTMFdXS0ZnWTYvaDhnY3JobzFw?=
 =?utf-8?B?d3J3NGNEVEpUTGxaZE5KZ3lPb3FDZW0xMVN4bjJ4TW5iVXcwbUxpMjBKaDZT?=
 =?utf-8?B?MEdZS1hmbWNMZTJHUGVJLzN6bFZnU1p5YkFBYzlSQU8yejgxNnFQVnEvMUFt?=
 =?utf-8?B?SWxzNk9TWXIybUFwUmpDUzNTOXMxb0U3RDQ1MlFPNE0vMjFkNFhCbTNZWDFE?=
 =?utf-8?B?cWRSLzZyR09JajE1bURJWmZ0QVo2VExicFVLVURESDFxSXJFNU9kc0tySjVV?=
 =?utf-8?B?Q2FIaGtDbEJxVmpBblovOUZBODBGNDFzaWE2cU00VEc3bms2SXphRkVoOVR4?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zD/h73aQNES64Nd2vz68HdAHWFdCsoS1I1ukhBcARzzGz9dCNW+dv16g9QbmDpg3hjjLU1kw2eWk2v+qXD4Qt938kMVXGACK3COjT6WPC+E16atG3swptSrVa/4wzSRhBsBAtwIjq68Q5irAWd37kpeyHs8Q2++9JyP4L21qBz38J/t2uL3Ifb9hbLq2jymhJYc1wb1EPpbozEBNx2kUNI0tXCXoNTuhpZV2/t2xT4eVH5Ec3wUC3A+51eUrIdFu/B2xu/G+D5qr4uE2lRZk4dKfl1aaF5ntK0IClKS9Tjw+/QOOLFnxHWza0X7V10NiX3y0q1VPmYMyyN8P3Y7xK8x6BatZD3v6ObvvAkkNTucjZKPqiXBhXeIebnbKOXA+OMAuAPFrBo10q4h9uhLYbih+oRBTzOeicYb55JdTce3lXnwj0L42mJqkub6QWmU9PyhjRDVEeQa1UrSgzmrX2eR1oYNS+sU8kx/MoCall28NSl1xlLrsgSsgjnHWq5te2lhaKyD6vrB1tcp9QJZf5ivOTRzHzE+yHDngCQMTqb19mz+btLvVvKDZ5tcxkS70/tjo8ne9vZdxfw5pAJNIjDOyA+PvkFSC0eSRBVlKbWw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936543c1-8bac-4e91-4bad-08dc6aa76620
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 12:57:18.8731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQwiusbW9Knubu7zse9wWTxmMqwTxUMJkFTau+x2eLDOqXZdy7YknOvhe2Ja91vjTS/9wVkULzmvBbXQJf75Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7910
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_02,2024-05-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405020082
X-Proofpoint-GUID: eVEweH0q0hUREho8kx2VBLOa-EeR_9F3
X-Proofpoint-ORIG-GUID: eVEweH0q0hUREho8kx2VBLOa-EeR_9F3

On Thu, May 02, 2024 at 07:00:44AM +0200, Salvatore Bonaccorso wrote:
> Hi all,
> 
> On Sat, Apr 06, 2024 at 07:28:58PM +0000, Chuck Lever III wrote:
> > 
> > 
> > > On Apr 6, 2024, at 3:15 PM, Salvatore Bonaccorso <carnil@debian.org> wrote:
> > > 
> > > Hi Chuck, hi Steve,
> > > 
> > > In Debian, as you might have heard there is a 64bit time_t
> > > transition[1] ongoing affecting the armel and armhf architectures.
> > > While doing so, nfs-utils was found to fail to build for those
> > > architectures after the switch, reported in Debian as [2]. Vladimir
> > > Petko from Ubuntu has as well filled it in [3].
> > > 
> > > [1]: https://lists.debian.org/debian-devel-announce/2024/02/msg00005.html
> > > [2]: https://bugs.debian.org/1067829
> > > [3]: https://bugzilla.kernel.org/show_bug.cgi?id=218540
> > > 
> > > The report is full-quoted below. 
> > > 
> > > Vladimir Petko has created a patch in the bugzilla which I'm attaching
> > > here as well. If this is not an acceptable format due to missing
> > > Signed-off's I'm attaching a variant with a Suggested-by for Vladimir
> > > to properly credit the patch origin.
> > > 
> > > Let me know if that works. I changed it slightly and only casting to
> > > long long, and made it almost checkpatch clean.
> > 
> > I suppose strftime(3) might be nicer, but this works.
> > 
> > Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> 
> I noticed this is not yet applied to the repository, do you need
> anything else from me or did it just felt trouch the cracks or
> actually queued?
> 
> Asking since if you want to have it done differently I will then
> follow suit downstream as well in Debian, where we have for now
> applied the submitted patch.

Salvatore, can you resend the patch inline (not as an attachment)
 To: Steve, Cc: linux-nfs@ ?

Steve, see above for my Reviewed-by.

-- 
Chuck Lever

