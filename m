Return-Path: <linux-nfs+bounces-7275-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C71DB9A3FB7
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 15:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE94A1C21137
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 13:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F909476;
	Fri, 18 Oct 2024 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B8aEfRyA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RnVMbsC/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98D020E335
	for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258376; cv=fail; b=n8obw5gStq7vl1+qDCqMVy/iG/Ino80uaR9qpfwzJxSSFOSEsUMDlArOPkOZgup+qQJxALsDKA+9NzUOoqOb3JsHZbQGt3NGe9GrENeZ9KsHn2wvkUtEPC9fQL6LWDWgfVqc6nf/IWmFofcgx8gM/jBnKfDzzt3YiFmQ0MP6w1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258376; c=relaxed/simple;
	bh=01EBRv360t3QLBh9aPkLFbyt9ma7qM+Q+Hdi5oVqdO8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ys/vsi45rppLm8jYsh7aZUFGvQAUnVTnodvgbotn7C+tGKuD9owbk3oabnLZxW1qbmguVrO31wrccMDCmJOf5+iknSqgbQlzDyD5TTs166WOewhIhopnlJeIKZISp32Ya5gIM68egJcsvE+QRW6TLefBqw6La98Gl/F0WjKp0CM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B8aEfRyA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RnVMbsC/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IBtxGV032477;
	Fri, 18 Oct 2024 13:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=01EBRv360t3QLBh9aPkLFbyt9ma7qM+Q+Hdi5oVqdO8=; b=
	B8aEfRyA6TICKhQsWBLxJi8J4pdOROMCViWhH9KmBr/GWNLm1hMTVuiBlS73daKV
	L1OsclWDnHSmzvx8dJTW9ornh6p4lhrM0LeIWXi0qNCTrQPq8NtJlzwumkXS8yIR
	8KZKh6u3ZStPYH8Krp4Ux48BjTQaUdjwNTAUH2gIPKHGSbxoKfLKZSvWks4xCPq9
	Is6xnivBrRv4ZfXWER6sRRlIH7RTIMpDEG2egMgOdWoZcSsb1GIQBrsyG55cIrI0
	7Wz/WWFWgMhC8TicnOflM5henSgyEvfCr09B5Zs/gVAbcBTQ2idtbj1LeVTPnwIH
	1zQv+/8vO0hiV1kRsCvPPg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hntgurs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 13:32:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49ICpFde010433;
	Fri, 18 Oct 2024 13:32:40 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjhy73y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 13:32:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcHI54rvB8OApLJM3tZ6mDRjRZfGD2zkynH+lAbU7POKda5KPQIobXfVbfIr9UoP2unWvu6cunvFD53Zo3yAIp9/Bg96yQBgs1+I5gy/qsy2RkKLXI0ms4KZrnrjkTdHSYEf9pcvPwZ/iZchnxWtAakk1yzEIKEj+KJbNd4J5EqYwa7k2LDznsyNP+Ht9Iowbsr0eSOL4T/hrgZHhi3BLEOY1JWsUmhh/lwsv2g4ivY/Im+WJvnIt8PMXPJJwXxfPDRjthzT6wbZkCVWhQ8fothqE0i5KW291nW473evf6BTWyKhYVyoSeBvp1BzRzrs5HtWtEzBNTj6wQ5taO1nDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01EBRv360t3QLBh9aPkLFbyt9ma7qM+Q+Hdi5oVqdO8=;
 b=FPPa0tXzbP2qdQQx+Ck3rO8HZqB4bvWbztfav/XTehIWS+M7gqA8ixOtOlXofGQwVnXZzdOI9HUMCP0r+xvY2ccAn/KQcS6rX8L4X7XRfUPAfzPZytJnscVGcfmxp1A4gq/ncrpDXU92tKCWKxKLWEiARoiA3LltJKliM6VL5jZQabw1rshoWIH4ZWoN/n0Q5FCbY/jarI4SdGokKvTmqicSY1BqmdLn6jsaO9nx8HmuU/CmBGn3hDwTsmd3J+51qU0/30TejLERZUmv9Fs1pW+XTyUcsH0TeHpHBf9dCvPb7U3wVP7AgCyu1N3flQ36e+tDRWmqd1fDSj8Fo9DkNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01EBRv360t3QLBh9aPkLFbyt9ma7qM+Q+Hdi5oVqdO8=;
 b=RnVMbsC/JfoOTVSwwcFt2LwTqw7y7GbF7SfHAR+7aFHGnAoYyQXmV0GKVcA3ydHojuMOevHWoIyXXr64+dCz/fXtKv9bUedJU5GGtWI5jWOYlw8p8lbD3Zs6eg35iko5bkzjuQJWiLRateUWM8SqySKDg4LCo8lAvj1gzxq7b/E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4523.namprd10.prod.outlook.com (2603:10b6:806:113::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Fri, 18 Oct
 2024 13:32:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 13:32:38 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Cedric Blancher <cedric.blancher@gmail.com>,
        Steve Dickson
	<SteveD@redhat.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chen Hanxiao
	<chenhx.fnst@fujitsu.com>
Subject: Re: /etc/exports refer= syntax for raw IPv6 addresse?
Thread-Topic: /etc/exports refer= syntax for raw IPv6 addresse?
Thread-Index: AQHbIV6507T1+oTYl0mGkA96cbk1xbKMgZqA
Date: Fri, 18 Oct 2024 13:32:38 +0000
Message-ID: <2EAAFA93-4E6C-4DC6-86DB-49CF7936E692@oracle.com>
References:
 <CALXu0UdkaXPMWEe9amJ5Ugg0rw3CWnQMLDyhx6PtPc6oEKoPMg@mail.gmail.com>
In-Reply-To:
 <CALXu0UdkaXPMWEe9amJ5Ugg0rw3CWnQMLDyhx6PtPc6oEKoPMg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4523:EE_
x-ms-office365-filtering-correlation-id: 510f875a-3136-456f-8b14-08dcef795551
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkxLZWh3Vk4xRGJIVmgwTTVFY05JRjUyNkRuc3pMTERxaEpRcHRCNzEvTFFI?=
 =?utf-8?B?VVR6SlBXaG90bW1Oekg4eWsyTlRGSWN0S1JoTVFEaHJBWWtHY0Y0b3NKeDIv?=
 =?utf-8?B?MDVuSUdOUmh2WkV5WXFSZms1MEptYXU0bVRVdGlrRzlmVDZMbmlMZW5EclJK?=
 =?utf-8?B?c0JaS2d3d2l6a1pvZHBmaW03L3c1bkE0aUoxMHhlUWxQdkt1WkNlbGw2M2RQ?=
 =?utf-8?B?ajNGM2k3UWJPT09wYmpyeHpORlRRc1lxSHV6K2FESXJ5QTduTzMyczZyYkRm?=
 =?utf-8?B?cmJtZTZVTDBFQ0VvZ0ZkNFY1bm1hR1JxZ3drK1hGdUtkdUJBUGkvZkdOUVZN?=
 =?utf-8?B?Z0tMbDRjVkhaeVIrV1Vadi8rTERiWUVBR2pqRE54NHJqMjZWWUZpcmxhZnAr?=
 =?utf-8?B?NS95WFBvdGVnZVVlb2JYbUR1MVI3elQxV0l6NnB6eXE4ZGpyK0lkaEluaGxV?=
 =?utf-8?B?WDFTZldzdTRWNnorT2FteVErME5wYTNVTmEwSEhCWCtwWFFMZ1BOTjNVV2Ns?=
 =?utf-8?B?TkY4U0NTTWhRTWFnOGsrVCtXZE1ENkxlUmZrV0tKQ1VSZzVCNFhKaXJSMDNZ?=
 =?utf-8?B?ZFBmMlVuK3NCWk1jOXpGaFd5MVJYQTVqWXAvUTRmbDRGdHdkTnNld3Fnay9h?=
 =?utf-8?B?VVA2U3B1d3ZHSzV6Y2Fobk5RR3ZuUFVjN2FRM1BVMzdndGJHS21yN1hNNWYy?=
 =?utf-8?B?NGI3akNHSVR1dHh3M2doLzh6R0QvU3JHeDkrZGdGVjlqUEpDcHNYRkx0WEJi?=
 =?utf-8?B?cTFxZWtOazgzc1RCYTRucGxGa0tNNVZYK24yZzNVUnRCeEtmck5xemRuVmNU?=
 =?utf-8?B?ZFAvVUwxeml6TloxMksyakxsdlJ5TXUvaUFoakpvTzNFMFpvYXdJWWJ2MjBk?=
 =?utf-8?B?WW5OUFIyWC9vVkgzdmFTclNQU3RHZ0lzL29YZFBVN0lFdmtlTVJ0aVp2Rk84?=
 =?utf-8?B?ME12YUtQL1NOeEpSdGlmUEM1TU84ZUQyNWs4bzFzOW1pUXR4QUNyL3d2UHpR?=
 =?utf-8?B?bURyb21yOXd2aXJtTjI4ZlV3TG5jbmIyUVRzaHlWUUw5cExDUm9FMStsN1g1?=
 =?utf-8?B?c29aWEVBNkw4Z2g5dk1wQlZjcEZnME9BNjBzdWFDVmZjV0ZOM2NrL3dBT3Fq?=
 =?utf-8?B?NkxROFhVTlorRFpJNmM3Y05kd1BiLy8wNEcrN3JGWnBta0x5cVZJQ1pZenZN?=
 =?utf-8?B?a3d6RUQvZEVXMkkyd3NXSkVjTGl4b084Sy9YZVlONUZ5KzM3UlhwZkNoWjJZ?=
 =?utf-8?B?d1VIMlp6eTFqOVVGdXpPK1U3b3VJUmFpY2pSbmU1bEJjRHhXYm8vb2ZsRFlz?=
 =?utf-8?B?eGIwQThRdXU5Y1hLS0hua1hNdUtaVXpkRXQ0a21Jc0t6UEZEU2IzMVUwY3RQ?=
 =?utf-8?B?UGxFaSs4KzFpSHd1K3ZFMmVoVC8zYUtHOW4xNFg3d0lXTzY0dm1ZQjlaUlhB?=
 =?utf-8?B?S2pTMm5MTXFka1N2NEZ5c1d6R2p2MmlBRWNyV1RoTW96SGRpUUliSXBhcmwv?=
 =?utf-8?B?a2w2WHBrT3Bub1FMbzdlMnE2TmZQWEM2MTlGcHZEcTcwMThIb3Y1bk1jcmQ4?=
 =?utf-8?B?MEVxOUVDQXd1YXNaREwzTjBZNU5IVitFZi9TZC9iQlF0Z1YvZGNsYXVYWE5G?=
 =?utf-8?B?N3lZU2plMHk0WlBPVzBPOGNEdjc3NG5HTDdaQXRlRTVDS2pGL1U2YzJZMDVE?=
 =?utf-8?B?MXp0STYzZzdrbERFWW5ZcUljbXh6enVEb2x5RURQYWs4aWZxSC8xdEQ1bFND?=
 =?utf-8?B?SW80U0xLUXRQR0FMWUxnY0RkcWllNGdFS1FUSktsQ3RUdVorSTFGaGN4U0o2?=
 =?utf-8?Q?ChQ864na/qiFIvtPkMmrmZbwpiAQW2jvyLezg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TTlkV1hZV1ROek5rdFZjQ3kxUmkzaTcvTndVb2NZSGpBZDBLeXowWEFtNTVo?=
 =?utf-8?B?Y0s3ZThsc1cweWVxVmx0Y0xsY042ZnZmZll1Wnh0UzZuRTNGMTFOcUdtTXdW?=
 =?utf-8?B?dWZ2QjFmZ0Y1b0tsbVJUeDRGMmxJQXNoZ1dZQ0FpQXA0clZuTXJsTm1ucEJO?=
 =?utf-8?B?b2k0bnZDVmtvT0Rsek9Tc1JxNWI0MlFhbHVYdUJQWG04NC8yR0U0aW8wdngy?=
 =?utf-8?B?K1VuSlNldGU4eEtPdWJ1d1Z6WTFkMm44aUo2SStXeUkwdFAzd2ZyWWgyYWJZ?=
 =?utf-8?B?YU9HNmladkZGYVJ3MmVQMi9YWVdtbzZJbnpIOHJBcTFGSzc5NWdNeUZLUTEx?=
 =?utf-8?B?T3FJbERDRXdQbjRUODNHR0hNWFlVb2tBc0VPWTRJSk11aEZvNCtIdTlzSUpB?=
 =?utf-8?B?RFVicEdKbG9PY1ZPSERwQ2ZqV05IUEdUbi85S0VuN20yRDlwcjhtLzlkWlB5?=
 =?utf-8?B?QXpWUFZIdTZJL1lRSE9QTktpaENtQ3ZKRjh2ME84NlU0TzhQS1Z2UlMyY3Qy?=
 =?utf-8?B?NHk2RDZLT29vY2ljempEVHBTbXdSOTlUanVNQVpieGhUaUt1S1doUG9zd0gw?=
 =?utf-8?B?QXUzZWQwb1hOVG94UEtwSjl6QjFEbkhPTUF5U2d0QzIvQVdYWmtTbVlhandH?=
 =?utf-8?B?a3Q4ditnclByNDdmSG41QTkwRzJDeXdYNkJ1QUtjWEJITCtSd0l1cUJWdTk0?=
 =?utf-8?B?NnVmSU12TlUveU05Ny80SlA1UTduM1lNTXFRa2dRTGpGOUJVQVhGZzNrcXcx?=
 =?utf-8?B?OHIyN2dGanF0VkZLSjNlYlVRM3ZCL2lrUUZWTlRCUHBSVm1rYmxWUzRIOE9h?=
 =?utf-8?B?ZDNxcVVSVEo4ZURwb0FJWlJDc0VMWEc4aG4zNFovaHRoNTBSdmVmMzlBS1NX?=
 =?utf-8?B?TXR4Ly8wQlBSbmc5bEZray9QMGRaeDF0aC8vZkw1V2tmb2Q1MVhqeVlWRENY?=
 =?utf-8?B?Y09wY2d1WTBRT3lIZWNqci90aTVlWVk0anVJT2gwRXhIVXVmVEpyY1dWcmk1?=
 =?utf-8?B?QTd3OHJITDBJRnN4VzdzVDdyQTFpS014d1Y3YldVLzdtaHpEOTJNdENhUTgy?=
 =?utf-8?B?T05jN2VYQVFsT2JKOTZHbzM0SmovT0Y0b3VpOEhqU29Wb3RMYXlNRWJmN1ZM?=
 =?utf-8?B?eTljOEcyQTlTVGJlRTJsL2lVU1N1KzU2VG10UTlCUFhvY3ErNGpYL2themlx?=
 =?utf-8?B?L2VnNUo2MTl3RU5wdVE2L0llK1RhMUY4bEhjUjByRVNvSk5HR0k0WGFOVU9h?=
 =?utf-8?B?SFdWV2ZudlpGMDhhQ1pNanJ1YnlKcUhGVU00UkFTTkRJaWppaU5KZHdQdEN6?=
 =?utf-8?B?czVObzdkU0FERTNUSlNrNjVTSHM0ZnB5S0VscHdXbW50eEIyMDFEa1QyNE51?=
 =?utf-8?B?Q2swSFVHaXpYakt3RC94cjRUZWxpeU90KzkxSXMyQ3JHMEtSQVh4UTRyVTIx?=
 =?utf-8?B?RUJBNi92Wk5reUZYVzcwRndwczRPdks2VmFFbDFnM2hrV2dEQXQ4QWhXdnNy?=
 =?utf-8?B?cXFqVDdtNUtMVVp2ZTNSM0lhSXI2NVh0OUw1bURkU3pmZUFCb1QzT2Jhdkt3?=
 =?utf-8?B?NnRlUlVJTEgzWmZkSk0rNDdwOUJNdExJSjBrZzZnZlRaNnpoK2VsZlBaZ1F0?=
 =?utf-8?B?SHFzVWtFZDJTYkNMWXhrb3hmd3JpWlcwTWhGSFVjMVlVY3IrWHEzYjdqVXpJ?=
 =?utf-8?B?MnRPdmlmc05VM0U5ajdGM3U1Z0xQd2h4OUFVc01RcVVPaVlzbTN4azBwQk14?=
 =?utf-8?B?Q2FOQjh1d1FMWm9kaUVMTEIzaGx2RjRxS0NBSmk2bkZsYjRsVHhnemtpYjJz?=
 =?utf-8?B?K0tVMWM3VkJpUGppMXJwSnBaQk56Y1NkSEtFM2E4a2V2WGlUWkNMZis5eGJD?=
 =?utf-8?B?a1BmdVpzWWZPNkhHVVh6WlZQdS80MDZGZ2xnU29scFJENDIvaTVQdThBY3U2?=
 =?utf-8?B?UmVSZFFELzZyeG1PSEpERTEvdVk2ZkthK1pCNmx3VjJTcEl5NEo5RFpXWFAy?=
 =?utf-8?B?YjZDd3FVNkhDRkpqWVhEeXhpR1lNMm5wTnY4S0NtekZaa3RUbEtscE11Z1BV?=
 =?utf-8?B?OFhRS0cvUFpyTlM0Mlp1S3RMSXhWU3RmeHlwVXBIUFRrR3hnbjB6TjkwSHpQ?=
 =?utf-8?B?WHpKaXpOSnhzVVpDS0RrMVBKc0xjK3NjUjV1a0tqak5aMWVCQUVyQ0thMXhX?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D806482B6A0D104D88C9993A0AC66E29@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vf87svmr//7xTW5pH9iSf2mTuSzliaAQp5+F54BIBPxcNZOkv37vgVs1Z9FKlNi/MGJbQkDjfhrzTCO0Nu5MtWRRWrYxsylKl3FHc+A33wKI6V3MSXNAE+qINUvk84VA/duUXtI7WvMd5VaK5Xf/dqHmJKQJC56saZ/UG9nlktefskcuqN1KfmpWPV6CxP+HlDFxtwrH2Tkw5Qgajn5AYy3I80fKSCi6oYvtGdi7GN6U5vq9xdTFFvjupAkhh31g2DgF9j2tvS+zuHvu+6M0i1YjchSms7vSqOBNTsRLAPsasSdKqUtZkwUDyaRzRqVukSeqK217F7pfTH/hLs8UytV0ksutdf0PJFTcFIcUThZHUVq97VBKy3Q8TTaMKgNr01k2ahFk0vO3MW0bYuF9SrKpdnEkmn7ykAY3m40eZ0DZluJkzD/UVlW14ag8i40HAuufyH5hV+6lcZ82wlijskBk3885Hrc8wijNVruQnP2A66MchsUZSsLnPD4PB/zx3Hm+qwcFaHPPm9pXDw7MPCMCykcYPSEXLskymUSEfN0kFjNMP/vNyvus+FxRYPahC4OCRYcnQVrEL339Ab25vWLfmN6JK03IWFG83G1F4c8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510f875a-3136-456f-8b14-08dcef795551
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 13:32:38.0805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fynywYQJC3YDlD0Ia7FE0KX112Y9I0h5+83Bmv9mox9V15msLGeR46X7Cm07u2l3o94s8I4DtsKBXn6vOD1+UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_09,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180085
X-Proofpoint-ORIG-GUID: Xb2xwkf5EY9Q0d_s7XFuuy2R1GiAoty5
X-Proofpoint-GUID: Xb2xwkf5EY9Q0d_s7XFuuy2R1GiAoty5

DQoNCj4gT24gT2N0IDE4LCAyMDI0LCBhdCA5OjA24oCvQU0sIENlZHJpYyBCbGFuY2hlciA8Y2Vk
cmljLmJsYW5jaGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBHb29kIGFmdGVybm9vbiENCj4g
DQo+IFdoYXQgaXMgdGhlIC9ldGMvZXhwb3J0cyByZWZlcj0gc3ludGF4IHRvIHBhc3MgYSByYXcg
SVB2NiBhZGRyZXNzPw0KPiANCj4gUFM6IE5vLCBuZnNyZWYgaXMgb2Ygbm8gdXNlLCB0aGUgdGFy
Z2V0IHN5c3RlbSBkb2VzIG5vdCBzdXBwb3J0IGl0LiBJDQo+IG5lZWQgdGhlIHJlZmVyPSBzeW50
YXggZm9yIGV4cG9ydHMoNSkNCg0KVGhhdCBxdWVzdGlvbiB3YXMgYXNrZWQgcmVjZW50bHkgb24g
dGhpcyBsaXN0LiBJIGRvbid0DQp0aGluayBhbnlvbmUgaGFzIGEgcmVhZHkgYW5zd2VyLCBzbyBJ
J3ZlIGFza2VkIFN0ZXZlDQp0byBsb29rIGludG8gaXQsIHNpbmNlIGhlIGlzIHRoZSBtYWludGFp
bmVyIGZvciBuZnMtdXRpbHMuDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

