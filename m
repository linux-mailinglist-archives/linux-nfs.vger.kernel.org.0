Return-Path: <linux-nfs+bounces-6191-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7FD96C258
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2024 17:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B7028A717
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2024 15:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CAD1DC19C;
	Wed,  4 Sep 2024 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T+J94i4O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K0gEhSOJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256951D88DF
	for <linux-nfs@vger.kernel.org>; Wed,  4 Sep 2024 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463722; cv=fail; b=XhCRBWirB3dx0K62bCH2P6B4nz1103iNB17OuVH7YIQpU7DGiUDTLSWIKpU9V+QKYrkV1E4b7PUXG39+pWO+e83T9ROygmqVGp30bg+NtvHIAmzA2ujGPhe491fWws8gsY66FRMS9rF8g1hu9X28IOsMrGq7iFYZFMQ5Yyy3q2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463722; c=relaxed/simple;
	bh=Pig8IXPAlJd72WlDWTYtUJJRyxmoPQkp3HQG9pdPkBk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kkytzXZWyZz2E3fUyVsG48p3VqTycDTiyAGP1jev1Bg2Pc10vmJRQIBz84B94K5nKwdA7DIqmFiXfaTLLPhKfJHEZ0EMd/Fhu5gT5kyf+cEjKyTy7zuZI5626SWxSvXaSt8LP9r9OM5Pmbaxy1Etn7o+LJ17MMzRnjouhd67n80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T+J94i4O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K0gEhSOJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484DXUDI024887;
	Wed, 4 Sep 2024 15:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=Pig8IXPAlJd72WlDWTYtUJJRyxmoPQkp3HQG9pdPk
	Bk=; b=T+J94i4O34wckRcDgMJYkX5jZzdmmls0jVwWHyzsUBjqtEvhzApPZfbXu
	MNACr54ex82H5LwBONyHc3cX9WCxB8/Q2JK0sm3bzglbhySVtnX6o9sudvK2x3kI
	ej9jSC21gzxB9NTRCjlpd/NMJJLQmnhiR7YPqFNTuwm5fUAiNscgS+qhlTm5u1Ka
	opxYm0eglxMH6inxogqb+fkfYqGGxzdbiw+N1S0vaMwERkwFDIAOfTInQNcN6Ls5
	2xCAGWWIHHjGcMF0+iVKgZA/7IjEQoJUjhkftQvYZ0OPP2d5oWmOPl4kClasFIOE
	kZPVEMxlpnWfaTqR0BpfFTakE7amg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41duyj3xb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 15:28:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 484F0sCg023663;
	Wed, 4 Sep 2024 15:28:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm9qxjx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 15:28:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gd8iSrfmC/uXtRx8GqI8I/QSnZ0n5LkD/gBUIz+lS+tWH2CiMEGSFb2xfPc9S4v8nRXOOnp79XU80BPXYIhnfRLEG7o6VFR2cLAcRqhriP0/eAmz9q2ieCBtRB6zOUMe7Sq2sVms/9eQaXG7/v8Ex8fMKu0ezXA+eQwUNDKd54G6L0iwDfNZnlyYvC1to4XpxmfPpeCw+I8gEtJRckD3LUeqwlWuZmDE1oTGOjOyuza5/MMKmr88r2RFLLLJF7wJJ3xsV7GfpyTvuFOBYJd0wlY6UMRfK9FZJDi9qVyvIMhuf6yu7Hsq8mjjwBzGmMUv/dyIoOv4ekRrAaJgadcXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pig8IXPAlJd72WlDWTYtUJJRyxmoPQkp3HQG9pdPkBk=;
 b=OgAyhwOX1wkld6NLZUoepZso6wEGcyNrRB33BIcgmmZ5TUZ8ak9Tqkop4YokX5JJrPzY2kHOsjbZ1dgmHNzQEu2FivKaiRHmDBNz59DZz8NTQtQRIJTlXnlrd3S/hSn3wCRDNqP4ZQPB7WF0HnH4Nr/kiUaTD3hZ5xL4m5HmBPFpQZq1n+btWcb36J9zaf9GbkARuzUGZ5cbbhp96aIVdmDOKomALLmov0Jzvv0fUhmurCOeiGIucuJ+Ef0rHDBU21oe16DHfrXcDXcsZBGHALCNigrbJwKDyo1Ase+j9sOzWW3Dxed/dgoHu5V1FTa2FCojtalQmyB/E6wrafNI4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pig8IXPAlJd72WlDWTYtUJJRyxmoPQkp3HQG9pdPkBk=;
 b=K0gEhSOJBh+JjamCgcUEHvg/ilNMAkxv36Vhq05qYNMGYIzz4CWUqlMRGr1tdFQOpbbaydlLAmbYY2CxlbTu6raJ+URnWZIseW1FQH8VTmkiXLfGX2fS0DQOn8S9cY7G6chUJ4XH2FSSqEog/Ci+X3eQUm69ktd7FMuKFOirK7g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6337.namprd10.prod.outlook.com (2603:10b6:510:1cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Wed, 4 Sep
 2024 15:28:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.010; Wed, 4 Sep 2024
 15:28:04 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Rick Macklem <rick.macklem@gmail.com>
CC: Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: Any idea how best to handle potentially large POSIX ACLs for
 getfacl?
Thread-Topic: Any idea how best to handle potentially large POSIX ACLs for
 getfacl?
Thread-Index: AQHa+nJQBOv4G6fVYUyMcpCz9+XTabI+854AgAAQbICAAAKSgIAGMaSAgAKQ4QA=
Date: Wed, 4 Sep 2024 15:28:04 +0000
Message-ID: <2710EC77-51FF-43D4-9E88-BC04DF28952F@oracle.com>
References:
 <CAM5tNy6UmWngTqzy=YVQ_2x61+AdZp2uW90N8oGB1V73O-vDMA@mail.gmail.com>
 <babb9c0643d56a7aeee80bca7ec78f557f965081.camel@hammerspace.com>
 <CAM5tNy7_gv_Gp17X+rZmZ4t_UTKWSX=+zGHGKPuhtF+--xOp-w@mail.gmail.com>
 <0c4d1a086b2d453cfa9e62b88bc28c0cc5720d20.camel@hammerspace.com>
 <CAM5tNy5xXd2d8CZXEsUUFh-OjMnME92ce7YxCT3P7MAdutCFFg@mail.gmail.com>
In-Reply-To:
 <CAM5tNy5xXd2d8CZXEsUUFh-OjMnME92ce7YxCT3P7MAdutCFFg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH8PR10MB6337:EE_
x-ms-office365-filtering-correlation-id: cf8364f4-cbaf-4cf7-5e3c-08dcccf62bb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NmJ2ZUJ2MDAwUVdLYlMyd1VzUWtWMkpqUzUvZ1Z4MDRyZFUyRVpvUHRXSVpB?=
 =?utf-8?B?NmFycWVDWkR2ZU04SEpJNHdTY2RPbXVyWVdxajE3K3EyYUEzcDV1SDdFcnJs?=
 =?utf-8?B?dzdxc2tGeEhiRmJZMlR6MXVSQUsxcG4yNUkvM2lVTFViaTdZMisvd2loZHAy?=
 =?utf-8?B?bjJIOEI3TkRVZTM5bUxJMFhkUi9UYkVoS0pXVEJQVVdjbkYxUVRxTW5Vais1?=
 =?utf-8?B?S2VncTNQSEM1MW90UDFXL1JCVlZwaDVHNU56TXF3eTIzbFZKZFZWYnZrZDlx?=
 =?utf-8?B?MjQyazlyemw1UHVFV0dCdUJwa0JhMlRNSEs0UHNLTzJXRm15bmIyQWNCUzBP?=
 =?utf-8?B?QktBMUNOTkVDczFVay9KM2FDMWNOeHljTEZST2pSTUZHUlZ5aGFPazRPS0NC?=
 =?utf-8?B?ZDh0UDlTTzY0NGRuV3h3bVVxK2dJeU11Vm1ya2dRcjZtU3JPMEV4Q2R4ai9v?=
 =?utf-8?B?cEVGOER3VTFFOEtvQ0dwUWRlL0d3SlRHMFFJZ1BXcnNZSG1YdytuVnYzUjBi?=
 =?utf-8?B?N1VUbE41RW93YkRDYXg3aGVxV2NDWlVTYXZOM1o2R20vRW1SYnl6RUV6Wi92?=
 =?utf-8?B?bmpPRkRram8vajhmN29qMjNFYnFsa3NLYXRteERZN2NWUzRpYnZTdUFvU3VC?=
 =?utf-8?B?U0szdlA2MUxlTmYzNTJ4YXRpTDJ4NUVyZlBLbUNFa0JDdlZDbE4rMHF1SDhW?=
 =?utf-8?B?WHBkTW9veXpHSXpaWE5QSUJVUW1RclhaLzBQQVlCTlExWWRNMVN1eHV4NmIz?=
 =?utf-8?B?TXV4bFlJU01WaUZrRjZ3K0xCclhLYXNIWnV2Uy9QN2ZaSmh5SU9Yek8yc0ZG?=
 =?utf-8?B?Y0ljUWxYbVNPdVBNZG5HcVFNTGtoelVteEhabkFDdFhLSExLTml5NWszWHBV?=
 =?utf-8?B?b04yMWVLNHNNa2syMDg3ek00dG5jSTVsOE5wSHFjcFptL2FmcTA4OHZqNEQv?=
 =?utf-8?B?U2JNL2dDY3R0RldNNmdnemJZOG1aeWVES3gxdDJzcnE2RjJHS1p5NXE5elA1?=
 =?utf-8?B?TWR0WWJuUzk5L0xqNW1RWTdMbHQ5YnJlYmFndGlkeGE3dldydzdZejdsSCtv?=
 =?utf-8?B?OU9QZGtWdzNucTVvWHM1ak10cXlQMUIwaWR5b3RXOEtQOEVrUjhwN2Fxa1lz?=
 =?utf-8?B?eFlNb2MvU2hWbDRTaWIvT2F6aHJiL0lCazU0NzJHTk1MZWNWL3kzL3RsQkxX?=
 =?utf-8?B?VnBmb25VdEcwdFUyanZUbitHNEtSQkdOeHBkeFV2RGprWTMvaCtyVVdsaGNr?=
 =?utf-8?B?UHd4UE9SU1pON1lHMkxsSkpsSkhxS2huWXpsb0J3cDVQcE5rdm1SS1dER00z?=
 =?utf-8?B?WnF5U3NaN2ZDaWhXRTZDTUdBd3QvTWtkWUUwVnhWczF6TnNwRzNYSEpCejV4?=
 =?utf-8?B?MVg2eUhNdjllU3dycGorZ0VrSCt5RldaZ2IydzJRcFZBRkd6bkN5U2prc2ty?=
 =?utf-8?B?dHR0Y0p2c0pVUGR0ejdnbWRWNEZCM3hKdnZ0TDdKeC9jT2JOQVBWdERqeUpX?=
 =?utf-8?B?Kzd4VzdIaEp4NlVjbG1PMUhCdFBuM3FpOUUxcDRFMTdMbC9vU0M1R1RZSFpJ?=
 =?utf-8?B?a1F6d2Vta2g4dGd3OEgzY3NDMC9Wc2kvcjd1MXI3ZzlBMng4NmszdXh1b2hO?=
 =?utf-8?B?WG8vT2tYd0l3Y05URU1jNjAwdEErVzlGM1NoRWtlZmxoNmRhZFV1MWdkQmZp?=
 =?utf-8?B?dkZwZHBXZmNDK1Z5ZHIvZ1llbVNxaERheHNNSXFweTJWWTMzODFZWHV4V2Mx?=
 =?utf-8?B?VzRGZ2JiSGdib2d1Tk5VZlFFTXlERUpwTytEdGNGTm8zMlBhamVqY1M0ZTRQ?=
 =?utf-8?B?VTltODJVRjdyNmhuN1pCM2xselVhaWxKUm8zeWNwbEZqYkpmNkxCZEdzMVZS?=
 =?utf-8?B?cnQ1bjVscitEcmNBaUpxSno0eVhYQTZSQURMTG0velpaUHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmQvV3FyeHhwZC96NHI2dnE1alZYS0VLem9KNG10a1FULzNRR1pFSnk2MTV5?=
 =?utf-8?B?Nlp3bjVwYU04ZjZUTVkwd2hObXJrQlNTanRITmRLOEVBVXhwUGlBenpuVDFG?=
 =?utf-8?B?QVl5L2pIOU01RnFyV29wS2VxVDRtd0NsNU1mejR4VHUzaFpTYXFLUzV5UGVM?=
 =?utf-8?B?M2VjUzMvU0R5U0tienpMV20yL2NZekZCbHhudW9CLzNKb1lVTEdvYWRxbC9v?=
 =?utf-8?B?eGp5Q2hwTWQ3WE9uOVhWTWM3ekZYQjArVGQ4MVJqVHhHL0V0eTVKVnFqaTdB?=
 =?utf-8?B?cUpsa28rd0JzUFlwRmxaUjhidnRGb2hOcjlwRlI3Sm9QR0NZYmJKM3M1L2JY?=
 =?utf-8?B?MFMwb2xkRG16YWZCWENUbEQ3aVFtUi9pRmJQdHVpdmt3Ri9uVUJ6VlJZUzBh?=
 =?utf-8?B?cVNlc0tDWGpxaUxxNHk4TVRxMlNiMUtOb1dmd3VZZ2I1NmFKZnZQNFowRFBK?=
 =?utf-8?B?WXpENnBaT2tjZVQxZDUyNmM4SXo1aitBWlBnZFlXT1cxVklxTFhXY25hODJK?=
 =?utf-8?B?WmovOHhTRFBYcFpDdnQ5ckVlOC9LUllHUTlwMlZWK1oyeXducWsxT2xvcUNz?=
 =?utf-8?B?eVJYN0ZsekxwaXRBeElaVzlTTXYxdE90VGpOdVpvT2ttem9mVWxXWU9tbVkw?=
 =?utf-8?B?TGNBNlRLdlJqOHFsc2RsU3VLY3JYejcxdWMvc21xOG05RDdTOFJ2elAwTTFs?=
 =?utf-8?B?c0hvVGF5QjVSTHdtNFVVSE5paHVQNzVkT1Z6SzgzWjQ0Z3BIRDFKOG5teitD?=
 =?utf-8?B?am1WVUNEZWxjWEJGZ2Y5bUVSSmhOUGFiR1BJVWhaV2RERitwSFFXaURXL2hN?=
 =?utf-8?B?czVpQ3lIMGRtZmxDcm1WZjdwTE1iVGg4VW01YjRCaEtWby9mS1VGSUJVbElZ?=
 =?utf-8?B?SlRYaXArMW13MThFRTZFVjhFNmpXaEhUbHFsR3MrbWljU21DYUVVbXN2eVpo?=
 =?utf-8?B?L3J0cmNHS2lxVEoweVArbkY2Q0FXbjRWS081eWhkZksxVkJmRCs5Q3U2b2JN?=
 =?utf-8?B?L3VTQzZ1VVJLdFFGMktwSXJlMHBtcHEyU2tvRWdSU1I5SnFBM3pBcjJFU3FT?=
 =?utf-8?B?OUIyN1NLdVMrZjAzQzhnbEpLMkdmNUJXNy9ESEIyR1V2NmcrVjRTTW8yRVBa?=
 =?utf-8?B?ck9weWJaQXFMdlJoSmNqSWtYbkRVVmRabmpUSGc2cDVMeXkvTmxUVDQ2cUtr?=
 =?utf-8?B?S3JhUysvaWhndkRKOGxEdHhLZ3o4QU90WFFRdnpVaFJhdWdSRXlaWitRN094?=
 =?utf-8?B?YXk1Y3NLU3orSGhtT2VzQWJGcmdtNE5LVzh3cjh4eEs1Nzdha3RPZVZ0enJr?=
 =?utf-8?B?NTZXOVFaWWNoTTh2Z1l4VW04QWtvb0hMNTd6MmhVeTFUYzNoeElidG1hOFNv?=
 =?utf-8?B?czI2eThWRUdJSElOK3RUTnhMS0tQZkxQZmY2N1VyQk5FR3FqWHp4QXptTVlC?=
 =?utf-8?B?ZGZITitBRHJoci9qL1Y4UEI4ZzJiSG1mSGRGS2dSVVBuazEydXNpRkwwbzhK?=
 =?utf-8?B?VTV5WWw5Z3hwRm1pVkU2THZtRlp2WDlpVXFGbFlzcmtYeFZnT0Z0M3ZYc0VL?=
 =?utf-8?B?MGVxMXRMZFYwbGxnMCtZYktpS1JTN3oxd0lvamZNMHptODNYUmRPY09PTkcz?=
 =?utf-8?B?Vk1wb2pkWmlzTG16R0p6S3NGdUNhN1hLZ2MrTHlNR0hxb0lGVXBHeVBIY084?=
 =?utf-8?B?cmtUL2Q5NDZ3czhnLzBPaVpPa2J4MjgvRXhMVk11VGI0UDVzbTcxbnhjQjU1?=
 =?utf-8?B?SkJ3ZVpyR3VzY2xzcUdDenN1YmFWL29ObzNacEpxS3FMZDlpV3lCQnFPc2JP?=
 =?utf-8?B?VFNOUkJFTDQ0WGdJUU9yR3Rrb3hDWUQrSTdlSnppcHovdHZGd1B0eEhwOW1S?=
 =?utf-8?B?dU5rYlBWRm92STZqNDF6dmFWYWtaN2RKT2FWd0pPbTdWcE52NGdOcS91bTVS?=
 =?utf-8?B?Wmp5MDFPcmhsTUN3Y3hxdVh4NzF5c0NCbmh0ZWpHMlkzNjkwbVVRR1dUUmQz?=
 =?utf-8?B?cVZnekhYbTZWeGhwbDhTSU1aVFRFOTJZY20vZjRwSHMrVDJXZU1zc0FFVlh5?=
 =?utf-8?B?QlRpQlpic1hyZnNVcWs1SnJWQ3QzMVNxRjRaSEJsNU5FaGVnZFl4UnF2WE1Q?=
 =?utf-8?B?SFI3MnZRV3NUemZkcDl2SFJESlplbE1ua1k3VWhOck5JVnhudWw4Mi9yOTFz?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EB4BE0ADF9E964EBE2C565DA87D4605@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YZitUSXp35FW7uYpFZyRCZhoeT0O+mtp/Nwms927QwyDDOK7Rlr/vAiGBbzn6T8JVllLAwyejB/UhFlX7fU5wFGqANhkC63t+p4RrwYYDLYcmep3DCgeibVzuMU+hM8mNRIVGFTHNr7SpBfsnKskDczsfEdydwwNKMBFt1LYIXy5dvXk/6PKcIb5D6xJoDdZ/YYRqSh10wyVc2uSUPKzfFY6CnjDuKor8xhDxAyHpVEmuORFBNW4wEeWeXc/C3dECYLjQhbRQh6M/uw79tEg+gaCYe6Sq7iz5i9gSY/0qzE1npsMQwQXteOEMrnWxBZWjeJQ4gPJUva8AnF0iNpeTvSuc4w66Y7LPh9Crz1Amf8RfQEr+HdocrzU7Hai30smZhZ0W6WWoUNBRo3cKCXX5Aw8Rp7l5XhDvgBKtP7yq9Mmub0w8jVJZ+fTb1NxWyVcUCYmQ5eWjlKE1vb9JEQi3oLNL7591PLJrNb/YD2n2MSfBe40kj3tomfuHCboKYIrwWcjJWdjmlmnw9UF0Uy75GHmcoB9xNjyhWPrhzvGbGlpwXj9TfI4yLBE7GgUFF49lYTpp9tnMtPM62tm4lAXS0IVFnDhjpVZq79/Hgxapjs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8364f4-cbaf-4cf7-5e3c-08dcccf62bb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 15:28:04.6596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uMeGgDC/t2cHqvAG0DzvvpD+YtSHLmssZW/OTRTe2y+iRre0fHTfi1ijw8hW75iLONda9l+CNwu5ubR+sasZjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6337
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_13,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409040117
X-Proofpoint-GUID: 2JRJF4JsXSQVplKi5hNYZMHQaaguX4LP
X-Proofpoint-ORIG-GUID: 2JRJF4JsXSQVplKi5hNYZMHQaaguX4LP

DQoNCj4gT24gU2VwIDIsIDIwMjQsIGF0IDg6MTbigK9QTSwgUmljayBNYWNrbGVtIDxyaWNrLm1h
Y2tsZW1AZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgQXVnIDI5LCAyMDI0IGF0IDY6
NDHigK9QTSBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToN
Cj4+IA0KPj4gT24gVGh1LCAyMDI0LTA4LTI5IGF0IDE4OjMyIC0wNzAwLCBSaWNrIE1hY2tsZW0g
d3JvdGU6DQo+Pj4gT24gVGh1LCBBdWcgMjksIDIwMjQgYXQgNTozM+KAr1BNIFRyb25kIE15a2xl
YnVzdA0KPj4+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+Pj4+IA0KPj4+PiBP
biBUaHUsIDIwMjQtMDgtMjkgYXQgMTc6MTkgLTA3MDAsIFJpY2sgTWFja2xlbSB3cm90ZToNCj4+
Pj4+IEhpLA0KPj4+Pj4gDQo+Pj4+PiBJIGhhdmUgYSByYXRoZXIgY3J1ZGUgcGF0Y2ggdGhhdCBk
b2VzIHRoZSBQT1NJWCBkcmFmdCBBQ0wNCj4+Pj4+IGF0dHJpYnV0ZXMNCj4+Pj4+IHRoYXQgbXkg
ZHJhZnQgaXMgc3VnZ2VzdGluZyBmb3IgTkZTdjQuMiBmb3IgdGhlIExpbnV4IGNsaWVudC4NCj4+
Pj4+IC0gSXQgaXMgd29ya2luZyBvayBmb3Igc21hbGwgQUNMcywgYnV0Li4uDQo+Pj4+PiANCj4+
Pj4+IFRoZSBoYXNzbGUgaXMgdGhhdCB0aGUgb24tdGhlLXdpcmUgQUNFcyBoYXZlIGEgIndobyIg
ZmllbGQgdGhhdA0KPj4+Pj4gY2FuDQo+Pj4+PiBiZSB1cCB0byAxMjhieXRlcyAoSURNQVBfTkFN
RVNaKS4NCj4+Pj4+IA0KPj4+Pj4gSSB0aGluayBJIGhhdmUgZmlndXJlZCBvdXQgdGhlIFNFVEFU
VFIgc2lkZSwgd2hpY2ggaXNuJ3QgdG9vIGJhZA0KPj4+Pj4gYmVjYXVzZQ0KPj4+Pj4gaXQga25v
d3MgaG93IG1hbnkgQUNFcy4gKEl0IGRvZXMgcm91Z2hseSB3aGF0IHRoZSBORlN2MyBORlNBQ0wN
Cj4+Pj4+IGNvZGUNCj4+Pj4+IGRpZCwgd2hpY2ggaXMgYWxsb2NhdGUgc29tZSBwYWdlcyBmb3Ig
dGhlIGxhcmdlIG9uZXMuKQ0KPj4+Pj4gDQo+Pj4+PiBIb3dldmVyLCB0aGUgZ2V0ZmFjbCBzaWRl
IGRvZXNuJ3Qga25vdyBob3cgYnVnIHRoZSBBQ0wgd2lsbCBiZSBpbg0KPj4+Pj4gdGhlIHJlcGx5
LiBUaGUgTkZTQUNMIGNvZGUgYWxsb2NhdGVzIHBhZ2VzICg3IG9mIHRoZW0pIHRvIGhhbmRsZQ0K
Pj4+Pj4gdGhlDQo+Pj4+PiBsYXJnZXN0IHBvc3NpYmxlIEFDTC4gVW5mb3J0dW5hdGVseSwgZm9y
IHRoZXNlIE5GU3Y0IGF0dHJpYnV0ZXMsDQo+Pj4+PiB0aGV5DQo+Pj4+PiBjb3VsZCBiZSByb3Vn
aGx5IDE0MEtieXRlcyAoMTQwYnl0ZXMgYXNzdW1pbmcgdGhlIGxhcmdlc3QgIndobyINCj4+Pj4+
IHRpbWVzDQo+Pj4+PiAxMDI0IEFDRXMpLg0KPj4+Pj4gLS0+IEFueW9uZSBoYXZlIGEgYmV0dGVy
IHN1Z2dlc3Rpb24gdGhhbiBqdXN0IGFsbG9jYXRpbmcgMzVwYWdlcw0KPj4+Pj4gZWFjaA0KPj4+
Pj4gdGltZQ0KPj4+Pj4gICAgKHdoZW4gOTkuOTklIG9mIHRoZW0gd2lsbCBmaXQgaW4gYSBmcmFj
dGlvbiBvZiBhIHBhZ2UpPw0KPj4+Pj4gDQo+Pj4+PiBUaGFua3MgZm9yIGFueSBzdWdnZXN0aW9u
cywgcmljaw0KPj4+Pj4gDQo+Pj4+IA0KPj4+PiBTZWUgdGhlIE5GU3YzIHBvc2l4IGFjbCBjbGll
bnQgY29kZS4NCj4+Pj4gDQo+Pj4+IEl0IGFsbG9jYXRlcyB0aGUgJ3BhZ2VzW10nIGFycmF5IG9m
IHBvaW50ZXJzIHRvIHRoZSBwYWdlIGJ1ZmZlcnMgdG8NCj4+Pj4gYmUNCj4+Pj4gb2YgbGVuZ3Ro
IE5GU0FDTF9NQVhQQUdFUywgYnV0IG9ubHkgYWxsb2NhdGVzIHRoZSBmaXJzdCBlbnRyeSwgYW5k
DQo+Pj4+IGxlYXZlcyB0aGUgcmVzdCBOVUxMLg0KPj4+PiBUaGVuIGluIHRoZSBYRFIgZW5jb2Rl
ciAibmZzM194ZHJfZW5jX2dldGFjbDNhcmdzKCkiIHdoZXJlIGl0DQo+Pj4+IGRlY2xhcmVzDQo+
Pj4+IHRoZSBsZW5ndGggb2YgdGhhdCBhcnJheSwgaXQgc2V0cyB0aGUgZmxhZyBYRFJCVUZfU1BB
UlNFX1BBR0VTIG9uDQo+Pj4+IHRoZQ0KPj4+PiByZXBseSBidWZmZXIuDQo+Pj4+IA0KPj4+PiBU
aGF0IHRlbGxzIHRoZSBSUEMgbGF5ZXIgdGhhdCBpZiB0aGUgaW5jb21pbmcgUlBDIHJlcGx5IG5l
ZWRzIHRvDQo+Pj4+IGZpbGwNCj4+Pj4gaW4gbW9yZSBkYXRhIHRoYW4gd2lsbCBmaXQgaW50byB0
aGF0IHNpbmdsZSBwYWdlLCB0aGVuIGl0IHNob3VsZA0KPj4+PiBhbGxvY2F0ZSBleHRyYSBwYWdl
cyBhbmQgYWRkIHRoZW0gdG8gdGhlICdwYWdlcycgYXJyYXkuDQo+Pj4gT2gsIG9rIHRoYW5rcyBm
b3IgdGhlIGV4cGxhbmF0aW9uLg0KPj4+IEl0IGRvZXNuJ3Qgc291bmQgbGlrZSBhIHByb2JsZW0g
dGhlbi4NCj4+PiANCj4+PiBJJ2xsIGp1c3QgY29kZSB0aGluZ3MgdGhlIHNhbWUgd2F5Lg0KPj4+
IA0KPj4+IE1heWJlIEkgY2FuIGFzayBvbmUgbW9yZSBxdWVzdGlvbj8/DQo+Pj4gVGhlcmUgYXJl
IGEgbGFyZ2UgIyBvZiBYWFhfZGVjb2RlX1hYWCBmdW5jdGlvbnMuIEFyZSB0aGVyZSBhbnkgdGhh
dA0KPj4+IHNob3VsZC9zaG91bGQgbm90IGJlIHVzZWQgZm9yIHRoZSBhYm92ZSBjYXNlPw0KPj4+
IEZvciBleGFtcGxlLCB0aGVyZSBhcmU6DQo+Pj4gLSBPbmVzIHRoYXQgdGFrZSBhICJzdHJ1Y3Qg
eGRyX3N0cmVhbSAqeGRyIiAodXN1YWxseSB3aXRoIF9zdHJlYW1fIGluDQo+Pj4gdGhlIG5hbWUp
DQo+Pj4gdnMNCj4+PiAtIE9uZXMgdGhhdCB0YWtlIGEgInN0cnVjdCB4ZHJfYnVmICpidWYiIGFy
Z3VtZW50Lg0KPj4+ICAoSSBlbmRlZCB1cCB1c2luZyB0aGVzZSBmb3IgdGhlIGVuY29kZSBzaWRl
IGFuZCB0aGlzIGxvb2tzIGxpa2UNCj4+PiB3aGF0DQo+Pj4gICBuZnNhY2xfZGVjb2RlKCkgdXNl
cywgYXMgd2VsbC4pDQo+Pj4gDQo+Pj4gKEknbGwgYWRtaXQgSSBoYXZlIGJlZW4gd2FkaW5nIGFy
b3VuZCBpbiB0aGUgY29kZSwgYnV0IGhhdmVuJ3QgcmVhbGx5DQo+Pj4gZ290dGVuIHRvIHRoZSBw
b2ludCBvZiB1bmRlcnN0YW5kaW5nIHdoaWNoIG9uZXMgc2hvdWxkIGJlIHVzZWQuKQ0KPj4+IA0K
Pj4gDQo+PiBUaGUgInN0cnVjdCB4ZHJfc3RyZWFtJyBiYXNlZCBjb2RlIGlzIHRoZSAnbmV3ZXIn
IHdheSBvZiBkb2luZyB0aGluZ3MsDQo+PiBhbmQgYWxsb3dzIHlvdSB0byB3cml0ZSBjb2RlIHRo
YXQgYWJzdHJhY3RzIGF3YXkgc29tZSBvZiB0aGUgdWdsaW5lc3MNCj4+IGluIHRoZSBSUEMgbGF5
ZXIsIHBhcnRpY3VsYXJseSB3aGVuIHlvdSBuZWVkIHRvIG1peCByZWd1bGFyIGJ1ZmZlcnMgYW5k
DQo+PiBwYWdlIGRhdGEuDQo+PiBUaGF0IHNhaWQsIHRoZXJlIGlzIGRlZmluaXRlbHkgbGVnYWN5
IGNvZGUgb3V0IHRoZXJlIHRoYXQgd29ya3MgcXVpdGUNCj4+IHdlbGwgYW5kIGlzIG5vdCB3b3J0
aCBhIGxvdCBvZiBlZmZvcnQgdG8gY29udmVydC4NCj4+IA0KPj4gSSdkIHJlY29tbWVuZCB0cnlp
bmcgdG8gdXNlIHRoZSB4ZHJfc3RyZWFtIGlmIHBvc3NpYmxlLCBqdXN0IGJlY2F1c2Ugb2YNCj4+
IHRoZSBiZXR0ZXIgYWJzdHJhY3Rpb24sIGJ1dCBpZiB5b3UgaGF2ZSB0byBmYWxsIGJhY2sgdG8g
bWFuaXB1bGF0aW5nDQo+PiB0aGUgeGRyX2J1ZiBkaXJlY3RseSwgdGhlbiB0aGF0IEFQSSBpcyB0
aGVyZSwgYW5kIGlzIHN0aWxsIHN1cHBvcnRlZC4NCj4gSSBoYXZlbid0IGJlZW4gYWJsZSB0byBm
aWd1cmUgb3V0IGhvdyB0byB1c2UgdGhlIHhkcl9zdHJlYW0uLi4gc3R1ZmYNCj4gd2hlbiB0aGUg
YXR0cmlidXRlcyBnZXQgbGFyZ2UgZW5vdWdoIHRoYXQgdGhleSBuZWVkIHBhZ2VzLg0KPiANCj4g
V2hhdCBJIGN1cnJlbnRseSBoYXZlICh0aGF0IHNlZW1zIHRvIHdvcmspIGlzLi4uDQo+IEZvciBH
RVRBVFRSLCBYRFJCVUZfU1BBUlNFX1BBR0VTIGlzIHNldCwgYW5kIHRoZW4sIG9uY2UgaXQNCj4g
Z2V0cyB0byB0aGUgYWN0dWFsIEFDTCAod2hpY2ggY2FuIGJlIHByZXR0eSBiaWcpLCBJIHVzZQ0K
PiAgIHhkcl9kZWNvZGVfd29yZCgpIGFuZCByZWFkX2J5dGVzX2Zyb21feGRyX2J1ZigpIHRvIGRl
Y29kZSBpdA0KPiAgIChUaGUgc3RyZWFtIGNhbGxzIHdvcmtlZCB1bnRpbCB0aGUgQUNMIGdvdCB0
b28gYmlnIGZvciB0aGUgbm9uLXBhZ2UNCj4gICAgcGFydCwgd2hpY2ggSSB0aGluayBpcyAyS2J5
dGVzPykNCj4gICAtIE1heWJlIHRoZXJlIGlzIHNvbWUgdHJpY2sgSSBkb24ndCBrbm93IHRvIGdl
dCB0aGUgYmlnIG9uZXMgdG8gd29yaw0KPiAgICAgd2l0aCB0aGUgeGRyX3N0cmVhbV9YWFgoKSBk
ZWNvZGUgY2FsbHM/DQoNClNlZSB4ZHJfc2V0X3NjcmF0Y2hfYnVmZmVyKCkgLS0geGRyX3N0cmVh
bSB3YW50cyBhIHNjcmF0Y2gNCmJ1ZmZlciBmb3IgbWFuYWdpbmcgdGhlIHRyYW5zaXRpb25zIGJl
dHdlZW4gdGhlIHhkcl9idWYncw0KaGVhZC9wYWdlL3RhaWwgY29tcG9uZW50cy4NCg0KDQotLQ0K
Q2h1Y2sgTGV2ZXINCg0KDQo=

