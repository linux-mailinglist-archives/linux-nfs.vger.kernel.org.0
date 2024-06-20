Return-Path: <linux-nfs+bounces-4200-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F53911708
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 01:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149531C20AED
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 23:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1285155C99;
	Thu, 20 Jun 2024 23:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Md/wNj9z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g9gflzgx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A7155C95
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 23:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718927591; cv=fail; b=bXBYXGCgRywv54c0OS4J6I0RTeHRt9Ob76kNOI2usdD79kJOJkKrItZK7SJy7APTGPE2ybLWuqZzUSW1LMyDyU+uaw76fi/xBHhrWk7Ru0/ZCTnLLtBRzwNOqHo+kdKcyEN//7ceQ4V9XFI2w9rA9JNNr1kHS8R/KFOuXFrslJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718927591; c=relaxed/simple;
	bh=2bjbjILTIlVabECFg3g5hcXY+772q+PB8rVg6esYAfk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EUVwbrjVtAMyBGnqTcXyLvpGQr1oK1MiHQspOsb06ElWXmO9cX7jSuVMMtCVC6NJZkbHLKPTpJVE/RNVswnP9uQX1w6GCe59I+Y9WSo32JXTt6/CVqWubM+lUXy+0kmRffmf42FkEJJM2LgFniwznqN6D6+dHowA9V8uX348vLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Md/wNj9z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g9gflzgx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KKtQhp025085;
	Thu, 20 Jun 2024 23:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=2bjbjILTIlVabECFg3g5hcXY+772q+PB8rVg6esYA
	fk=; b=Md/wNj9zAY7RCdaUnAQ4++L7qf+FTxeWClyqJwUPmaEbJoAnFEvuSQOqd
	lMf6ASYloiaFv+izoPJDaSfk5mHVezmv9n2mqaCG9v0vfnCyatc4VvlGbm2JomhS
	IXkyKPe6IqEGLOyZesEuAIL+eAsGeiGNlpYe0c2kDFczJA316Zl/kvI2HJzGK9g/
	FW9Ms2fRgtp0F5+eySy/tIjrHVXuFknikfEahZM0Cn0hyWHO7CdvD9xBECT4qlJP
	PkFzkqLM97JxC+A+I3HeM9gA1wB/eqBkIoGi854TR1EoWfkq3bSooElQG1ikqms8
	jnZUv2S6zvOQKl40qFTiimbClLBhw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrktrqe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 23:52:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KMDvJU019592;
	Thu, 20 Jun 2024 23:52:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn35tuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 23:52:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjhEV3LZSLwhEngPK3y+QSrKhpq2YOqCCU0HXrGSI8Di+/2wThmsPRB5hhhaT6KnivJtZRIjeOCBoAIcYkwPMmz5iAFVcUAySK40nv/Ow3WbS/ymxZc0cj5/6HHILkQXAmI2IKkv08UF/QuH2CZabVBkOZrGoEYguUhl30g2qXZbcjo62iNg7TBym5YEB2zukUDKbPvweOFCtGSEs2e5gu8/7n95dAVpYoLJdF8YZ1QNxKZmulfH7ShvBZslmEr9eWHg9TuG+X5NyFzeg2OLBnYHjc3kw5KcmSWMswUXZvbw4B9wk2d5ZEvQvobf+XQk2vHS6U3treH+g8SwUTmvAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bjbjILTIlVabECFg3g5hcXY+772q+PB8rVg6esYAfk=;
 b=SVzzipY8+nZzTmPAn3xlj5wNJnchdBMQJvkkMFXD1RO8MeU7P5ZPpt4x+OGGOmkcbE7dRwXS0AqzsYiZUwUOwaqNXs9nPpiEPsi1hs++RHY4xfH7wDOkU7501TZLR5FEpoPWp57GaPb7SGTPhgo6VVB3NmNE8/IZZFj/EQ68aSPolUis0LtTu3oFzA1Q6hs60eriaqCeR34rzH08gsKI+s/M2qZIDntVUK4rIhYVA5POStMtJAcJmJOgNzIaGmbLjJxCvja9hF5rJQaSmne7DPY/+Vvbo07+pJBwPYnjSoYhSVw5OYwGQZjvmMQBj/PZNeXSP8rOB5UC11rikUcNNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bjbjILTIlVabECFg3g5hcXY+772q+PB8rVg6esYAfk=;
 b=g9gflzgxXEaZPs2Nn0K7eqU/3M+wSZ0BJXv/QyrOMf+t73mKZFJlCAq9HsJGp9TwQSHSnfdkpBDiNV6bCPeAWBbNMW43W7qvTklfakyP3plzkfNbY+YUXTkXNQmgbsn4V2a//tPF04Iln5neIbOci3roNkeRuRXnNy+K+bLOZ0g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4310.namprd10.prod.outlook.com (2603:10b6:610:ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Thu, 20 Jun
 2024 23:52:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 23:52:48 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        "it+linux-nfs@molgen.mpg.de"
	<it+linux-nfs@molgen.mpg.de>
Subject: Re: Linux 6.6.12: kernel BUG at net/sunrpc/svc.c:581!: invalid
 opcode: 0000 [#1] PREEMPT SMP NOPTI, svc_destroy
Thread-Topic: Linux 6.6.12: kernel BUG at net/sunrpc/svc.c:581!: invalid
 opcode: 0000 [#1] PREEMPT SMP NOPTI, svc_destroy
Thread-Index: AQHaw1m3HYb3T52I70+pY2NZhScxurHRUyeA
Date: Thu, 20 Jun 2024 23:52:48 +0000
Message-ID: <C1811E7E-F7C0-4B10-93BF-98A2F5649CB9@oracle.com>
References: <3179936e-71eb-cb0a-8a8f-362607150771@molgen.mpg.de>
 <7f7a45a2-1134-4cef-be5a-ce50667cf1d1@molgen.mpg.de>
In-Reply-To: <7f7a45a2-1134-4cef-be5a-ce50667cf1d1@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH2PR10MB4310:EE_
x-ms-office365-filtering-correlation-id: e560126b-4b87-4cef-63f5-08dc918416a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cWpkUWJPRVY2MGFvZEJtVzBsU1FQeFQvWGRvMlh6V3BGVUJFMTJFTmFnM1hi?=
 =?utf-8?B?bDB0dThrT3RVV05sR0svS2ZsZ0NKOE1TNXdzMEcvYVVIUFlCQVFaMHcyRnpp?=
 =?utf-8?B?eE1rUHBDNDZpRnZJWU9pS2lYc2dRSmdNZVFMdEZpYW1ubzhHQm4rUkJteWZY?=
 =?utf-8?B?dWpxbCtrbUk5MW04MnBhV29HcnNnNlR1WU40aEptUHB2bnVZd0tUbmRyQUFK?=
 =?utf-8?B?QldRYjk3U2ZSeWNUUll1UFlZbW81UzBMci8vZHd2MWVCb24vSVF6cjVWMWU0?=
 =?utf-8?B?dHJvaVQ3U0cwS0tsV3ViVk5mREI5MFdLckxLVWMzU3FDR2FudWdsYk5ETXVW?=
 =?utf-8?B?QUJ5blBVV3VKSEFSWHRiUytTSWN2UzZaUTd4aGppVVUwYldWNGoxUFZQSTFj?=
 =?utf-8?B?VXE3RDdqcytsUWhNaXlQZjQ0UjZRaVlBV1RWZzhsb09QY3IxV2N5b1kxeHU4?=
 =?utf-8?B?QlE3eGNHRkhlS0V3ZFgzV1Vld0tnSXhYWXlkd2hyVDJRWTNiU09nVzFxK0Y0?=
 =?utf-8?B?TGN4YXBneUR6dnJGcy9GT3F3dDF5N3RjaEpDR3RQNlRuMTJyamRmeGJCZlM3?=
 =?utf-8?B?ekxHSHk3Zy9NZzBBTzVBR3JrcjJoVzBNM09DNDRlU2tmTFpXdnNUNXN2cGlv?=
 =?utf-8?B?dW5nVXZqNFJ5ZHdIZW1KOGcvWkdWaEVVelNWbm43M1IvUmQydktJL0tPcE93?=
 =?utf-8?B?THllM3Y3Njd0cVhmcWtsNHloTjJjVFdRcTNDT1Y5RGNUTW9kelhnK3dlTkZ4?=
 =?utf-8?B?Mko1Y1lFcEVjWFJ6bXRWRHVya1pSYkVEVC9GQ0xYcFhnbU9mVFhaOGpxcUNq?=
 =?utf-8?B?SGlHUnUvaCttU1l6ZnVydkJiQmp5aWV6bDJLYXdJWGVadTZkVTBWSlBtcys0?=
 =?utf-8?B?TXNWbkYzWTFDVThLc3dWcVI1ZW4rUmphQTBlSC9ZUEk5UE9rbGJHMnpDSzli?=
 =?utf-8?B?QklaUnhoQ05BRHF5V2REYXErWEMvVHMweCtaM3JCQ2h3RjBROWpNaEY4L040?=
 =?utf-8?B?b1VTdFRKYzlzRUV2Q1pWZUhFRzhmdG5DdTVDVE5IVHNSS050aXZvMzBIYllR?=
 =?utf-8?B?SUh4K09XRzBuQnQrMm5MV2RGZkEva2NyaXloa2orSjdjcmdkNXNqZjA2cGlF?=
 =?utf-8?B?Vkw0Uks2NHBCeUhYYzJPMUczMTRRbUJPRThWT2lHQm5CM2FSR2VtNHpMRWFr?=
 =?utf-8?B?TmRFelZDWWZsZ2liRHBqSEVjL3RNM0VEcDZJUXBXaTkzazkzaDM5eUU5d01y?=
 =?utf-8?B?cmwycWZRZUtRaURTZWlzM1dRaTJoV0RPOFhIK2N0cjlLN1NicFY4c1lrNTBP?=
 =?utf-8?B?YWFyNlk0cjF3U3ZlWCswZ1JvMGx5eUFleUdHZE0vRkdVQXY2UjgxYW9iaE5i?=
 =?utf-8?B?YkFRSFdTK1Uza0xGWVRTWEZ0SkdtL01nbTVYY3lMQllvUllISitjYzlEMXFu?=
 =?utf-8?B?RlVKTlRVVWJUdDZiaUhjM0luS3BxdFR3UVhTSS80YnlOMXNqQngvWjltMVF2?=
 =?utf-8?B?SDN4WFlsWVk5ay9HZ0l1eWxOUVJxWml4SGZZbG5xRTJSTTRVNVgwMmxEblNL?=
 =?utf-8?B?OEliM01LUnUzNGtJZ3pQL2dQakJoa1F2VE50ZTA5RXZJMlU3OFFGSmtLRVB6?=
 =?utf-8?B?bVp3aUNUd1R6bjJEM0srMzR1d0FTeStzZXMxSjdXUmRYZ05SSzlZL2w1Mnpm?=
 =?utf-8?B?Nk5DaTNHd3JGQ0E4SDQ5YzA3ZW5ldlZQdGxRN0ZtM09ONElaL1pWcUdZWnVN?=
 =?utf-8?B?TFZyREszbzFWU2UxcXZXQ041UnBubEhndGw2bmhVV0ptSEgvcWF1K0Faa3FZ?=
 =?utf-8?Q?y0TGWmUVvS/jKZwBd0Fl4gLCfEbWqZ0qzvXiI=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RzVRcEZXNEh1bTdoSmxBb0tBL0NuVTlnWTNwTk5PeUJmWGZWUUJxYW1JWm9D?=
 =?utf-8?B?NkVOSGc1bUpjRkRicDRNaUl2VURwMDhndVJaVUdITXBkTmNlZlhJWHJhZkky?=
 =?utf-8?B?WXVKbGxDWmhOWFEzanBPN2l2bGU2YVlTRVJkSHQwU2w2ZitKZDAwbzl2Qy9S?=
 =?utf-8?B?RFAySC9YQ3greVJWOUdlQjVsVXpHazA2U2kvVitNT3ZYWUozRUV3N1RlN2NE?=
 =?utf-8?B?OFQ5dGxkN1QwUk5RNzI3WXZWc0YwQk9zai94ZlVUWXN6aWJPMmlKTW1HNGtV?=
 =?utf-8?B?QU41NThmSFV1RVhGNEVSRmNvTkVQNGt4cVVkYVRwL3duNzdhOHcxN0xwcmd6?=
 =?utf-8?B?ek1iZDU2bk9pMFQ1Y2sxdzJzMytGVVQ2cHh3N3Zud29CSTg3SGgySFh2cTNs?=
 =?utf-8?B?NUxLVmhCOTllTUtzS0xCeW81UE9DRTJLWWdsdVljMFowbmNJNUdpSm11TUVI?=
 =?utf-8?B?LzNlUzNiWDZLdlF0MDlSMmM5OG50SnZiVENLeUJTOEpKcDBjYmpqcCtlQXdT?=
 =?utf-8?B?ZmlqZUVFblA3c0tEMHFwYndDOUg2eXlMNVF0Vm5nV1pLTDlZbnJldG83RU9n?=
 =?utf-8?B?bDdVSjZjYzBUcThNd1NMbjF3U2dOQm45QWxRYVIxN2czRm1HL0pPMXJ5aHlW?=
 =?utf-8?B?RUZNVFhtMVFKcE9WNlBJNVRwdTM1aFZ3ekN4QTVLTk9vUkdGSW00ZnFZZ01O?=
 =?utf-8?B?eHdpTWNiOWV6Ny8wNEVuenFrQWs3WnB0RHBNWHRMaFE3cDh6Sy83cGZaZVMx?=
 =?utf-8?B?TUlNT2ZMamY0ZXpXZDN1bDBjNGtFUEtPRkl5VFVCcGhvMmRISU1XT2J2bG1u?=
 =?utf-8?B?T2tEYkZlVkhJdmNaZ0lmcWZUMENGSjBtTG5YZG04ck9OU2ovV3IxNTJBZnJY?=
 =?utf-8?B?OTk5YktkcjVETE1KV0lad2dyRTdmbDRVbXQ1QTk1aDlNc3FpTmI1ejJWcmc2?=
 =?utf-8?B?aWRQTnBDQ2NmZTI1K1Z5bFB0ckoydE1Jbk9tVHZlblZnZWs5RlF6NDVtc3ha?=
 =?utf-8?B?UUFFbCtRZHNORVFva0E5eUU3a25ma2RoU3NlL2ptUW9zUm5udnNLSW1RMDdr?=
 =?utf-8?B?NUI4RHBRck5CQ3l3N3pXaW9NeTlRcWk1bVRtRC9pT3NPaGNodUdESVAvUEk0?=
 =?utf-8?B?d2hPQVFQZVozVUVEL0dsSittT0MzcUNkWkNNL2o3eXNuS0tPK0U4cHpFR0dE?=
 =?utf-8?B?ZjRrVG9MVUVPbzFqcU9XRkpxcVF6bm9LVGtQcFJGUU1OWVN0TjlDaldqVExT?=
 =?utf-8?B?eGQra3BqaDdDMUdJblE2a050c05Icm8yMGRMWFhMb1pRSWJIVFVTSjlXb2x6?=
 =?utf-8?B?dFh5OHZya0s4VGZyZU9BQXNHdHQzeWhzYkd1WVN1ZkVqR1RZRXdCR3Q4OHNW?=
 =?utf-8?B?RS90M1krRVF4T0lYT0xaYUZnOVhWSzVaeXVjeDgzL0swT0ZFS1oxK2V0R1V5?=
 =?utf-8?B?RFVxd0c5WW5NcmJlNXRQRlJJVWtvcGFTb1pYSFFyb2JsNzNwUVFEZ254WkhZ?=
 =?utf-8?B?STFKVnltanNCTmhieGtqNitxR0swVE9uMFh0clNhQ25vUEhtdk5wU1U3S3dN?=
 =?utf-8?B?cjBoTkNFMXZxNHBWS0ZKLzY5S21tQkt5R1BoU1NTOUpiRVkxdEYxNEZUZFFD?=
 =?utf-8?B?SXhNVE9nYXpwVnRnUysySnpCenFHM1lNR1c4NWhOQWQ0TmNTa0h4MDcvRDJt?=
 =?utf-8?B?MWtrbkQxVUcyeGZGREcyS1dzdEVNbjh1b2toaW1BNmdYUVZxQjlKMmRkVWhN?=
 =?utf-8?B?TjJFUTlic2hEVXlubUJQNnZVU054WGxZQjVObG53aEJOQzg1SWJmS2xabXUw?=
 =?utf-8?B?cEtQVjA1Q1hpcEdwRDZnZFRCakVVTXBoVitMcWpjNEZwdFEycUJ1RlJxbUVt?=
 =?utf-8?B?cWNBRlZwcXBzUk1LTi83dzkzUFNldFJjWDltTkNHZGxrempQcnBnSEpIb1ZB?=
 =?utf-8?B?ODJtTEJ3R2pERlFVRmk5VFpENUp2NkcwdERRTUhaeFV5NGxPN2V2UWdEWlA1?=
 =?utf-8?B?OEZkdUR6eXdlblZqVGJSMG4rUE96cmdQTklpZ3ZqZEVyNk1xQi9ZcDhSdmZH?=
 =?utf-8?B?NUlWaDZXZUVpaDBJQks0Z3FVSTJ6QXFaaytLRlJaWkNHdTRkaHJSOHlTVEFN?=
 =?utf-8?B?ZkpxZWNWTFZjYmw3SlJjMFpVZk80UTFUM0Q3aHlCMnBpM214YnVuemFwaFU3?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B321DFB94174947A623F54FC4094C00@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	l7KvijEzbzubibO/vA5EMyYTPDu76fgNiJGoXFRycQbzd7++bMTANXhj/74JbTLD5to1itAAoQzXlsTjnIFYGAOdYB9TP8icumTCPM72WPYsW4S4nz8dQRcCzJrbkjwERpMdhx22QnOQmcSBDaPxwn7NDRSVjFJHMQd6A/1qve+eYL5UYF58AABq9IOScEfYqVDXyA901CK4SAJBB4qKxOphuWRiBE1+rgybO01VueTT7moM0EhZTvEaAVLJlVldNh1sqHBObmuuYBPqxfBID8EVxzN7WtSrjpHkdIuY2r3O2EQM+UJ0QBm3nlCuy4dw/8rENyyEQ/PRq/a0McsTfVsSCj6LfQDSklLx63ILqQi056DjZPgUf5DbtRvgLCLnQa1nr0IPikTO9INxYqbvr1yg4RKfZt2W5bu00Ge61Jkh5Ni0RdWVxM4UecCdrqS7tWUSoBgZBCX9CReLRerW4nTKwlmJkhEoqMx42RAZ4WTx228wlOaVt+4efvYOShmUuLVnIWqKCysEAVBnAOqLR8Ib3gUmXF18AW+k/btDx5wT9CCdoqq4E80X6TLscbMWzugDgBlXyOWFiDAljzymdp9yU9dPGLtDoVTfQEZxoFI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e560126b-4b87-4cef-63f5-08dc918416a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 23:52:48.1423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x9tBmybH1NWALDqZPzA6qo2PyqukUT38cuwqWJ2vK1hgSbV4cLZIXk5HQ2rfEfzSZI/RxQUpUJou8pNBFSu2Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4310
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_10,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406200174
X-Proofpoint-GUID: 5oOLg2NXpUIn73EoXWy6yjZxTe25oLCL
X-Proofpoint-ORIG-GUID: 5oOLg2NXpUIn73EoXWy6yjZxTe25oLCL

DQoNCj4gT24gSnVuIDIwLCAyMDI0LCBhdCA1OjM04oCvUE0sIFBhdWwgTWVuemVsIDxwbWVuemVs
QG1vbGdlbi5tcGcuZGU+IHdyb3RlOg0KPiANCj4gRGVhciBMaW51eCBmb2xrcywNCj4gDQo+IA0K
PiBPbiBMaW51eCA2LjYuMTIgY29weWluZyBzZXZlcmFsIGxhcmdlIGZpbGVzICg14oCTODAgR0Ip
IGluIHBhcmFsbGVsLCBhbmQgdHJ5aW5nIHRvIGNoYW5nZSB0aGUgbnVtYmVyIG9mIHNlcnZlciB0
aHJlYWRzIHdpdGggYHJwYy5uZnNkIG5wcm9jYCBhZnRlcndhcmQsIGBzeXN0ZW1jdGwgcmVzdGFy
dCBuZnNkYCByZXN1bHRlZCBpbjoNCj4gDQo+IGBgYA0KPiBbMjUwMjM2Ny45NTg4MThdIG5mc2Q6
IGxhc3Qgc2VydmVyIGhhcyBleGl0ZWQsIGZsdXNoaW5nIGV4cG9ydCBjYWNoZQ0KPiBbMjUwMjM2
OS4yNjE5ODddIE5GU0Q6IFVzaW5nIFVNSCB1cGNhbGwgY2xpZW50IHRyYWNraW5nIG9wZXJhdGlv
bnMuDQo+IFsyNTAyMzY5LjI2ODY3OF0gTkZTRDogc3RhcnRpbmcgOTAtc2Vjb25kIGdyYWNlIHBl
cmlvZCAobmV0IGYwMDAwMDAwKQ0KPiANCj4gWzI1MDIzNjkuMjg1MDEzXSAtLS0tLS0tLS0tLS1b
IGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4gWzI1MDIzNjkuMjkxMjMwXSBrZXJuZWwgQlVHIGF0
IG5ldC9zdW5ycGMvc3ZjLmM6NTgxIQ0KPiBbMjUwMjM2OS4yOTcwMDhdIGludmFsaWQgb3Bjb2Rl
OiAwMDAwIFsjMV0gUFJFRU1QVCBTTVAgTk9QVEkNCj4gWzI1MDIzNjkuMzAzNTQ4XSBDUFU6IDkg
UElEOiA0NTc5IENvbW06IHJwYy5uZnNkIE5vdCB0YWludGVkIDYuNi4xMi5teDY0LjQ2MSAjMQ0K
PiBbMjUwMjM2OS4zMTE3NDFdIEhhcmR3YXJlIG5hbWU6IERlbGwgSW5jLiBQb3dlckVkZ2UgVDQ0
MC8wMjFLQ0QsIEJJT1MgMi4xMi4yIDA3LzA5LzIwMjENCj4gWzI1MDIzNjkuMzIwNjk2XSBSSVA6
IDAwMTA6c3ZjX2Rlc3Ryb3krMHhjOS8weGYwIFtzdW5ycGNdDQo+IFsyNTAyMzY5LjMyNzQ3NF0g
Q29kZTogMDAgMDAgMDAgYmUgMDEgMDAgMDAgMDAgZTggZDQgZjIgNTQgZTEgNDEgM2IgNmQgNzQg
NzIgYmMgNDkgOGIgN2QgN2MgZTggOTUgNDAgMWMgZTEgNGMgODkgZTcgNWIgNWQgNDEgNWMgNDEg
NWQgZTkgODcgNDAgMWMgZTEgPDBmPiAwYiA0OCA4YiA0NyBlYyA0OCBjNyBjNyBmOSA1YSAxNSBh
MCA0OCA4YiA3MCAyMCBlOCBjMSA4NyAwMSBlMQ0KPiBbMjUwMjM2OS4zNDk4NjNdIFJTUDogMDAx
ODpmZmZmYzkwMDBlMjZiZDYwIEVGTEFHUzogMDAwMTAyMDYNCj4gWzI1MDIzNjkuMzU2NTczXSBS
QVg6IGZmZmY4ODg4NjA2NGUxMzAgUkJYOiBmZmZmODg4ODYwNjRlMTE0IFJDWDogMDAwMDAwMDAw
MDAwMDAxMA0KPiBbMjUwMjM2OS4zNjUxNzNdIFJEWDogZmZmZjg4OTA5MmQ3MzAxOCBSU0k6IDAw
MDAwMDAwMDAwMDAyNDYgUkRJOiBmZmZmODhhMDNmYzFjZmMwDQo+IFsyNTAyMzY5LjM3Mzg3OV0g
UkJQOiAwMDAwMDAwMDAwMDAwMDQwIFIwODogMDAwMDAwMDAwMDAwMDAwZiBSMDk6IDAwMDAwMDAw
MDAwMDAwMDENCj4gWzI1MDIzNjkuMzgyNDc0XSBSMTA6IGZmZmY4ODkwOTJkNzEwMDAgUjExOiAw
MDAwMDAwMDAwMDAwMDAwIFIxMjogZmZmZjg4ODg2MDY0ZTEwMA0KPiBbMjUwMjM2OS4zOTExMTVd
IFIxMzogZmZmZjg4ODg2MDY0ZTExNCBSMTQ6IGZmZmY4ODg4NjA2NGUxMDAgUjE1OiBmZmZmODg4
MTA2MWQ2MDAwDQo+IFsyNTAyMzY5LjM5OTczMF0gRlM6ICAwMDAwN2Y2MTBhYzMwNzQwKDAwMDAp
IEdTOmZmZmY4OGEwM2ZkMDAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KPiBbMjUw
MjM2OS40MDk0MTBdIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAw
NTAwMzMNCj4gWzI1MDIzNjkuNDE2NjY3XSBDUjI6IDAwMDAwMDAwMDA2OWFkZjggQ1IzOiAwMDAw
MDAwNGJhMTRhMDAyIENSNDogMDAwMDAwMDAwMDc3MDZlMA0KPiBbMjUwMjM2OS40MjU1MjRdIERS
MDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAw
MDAwMDAwDQo+IFsyNTAyMzY5LjQzNDI0MF0gRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAw
MDAwMDBmZmZlMGZmMCBEUjc6IDAwMDAwMDAwMDAwMDA0MDANCj4gWzI1MDIzNjkuNDQyODgwXSBQ
S1JVOiA1NTU1NTU1NA0KPiBbMjUwMjM2OS40NDcxOTNdIENhbGwgVHJhY2U6DQo+IFsyNTAyMzY5
LjQ1MTIxMV0gIDxUQVNLPg0KPiBbMjUwMjM2OS40NTQ5ODJdICA/IGRpZSsweDM2LzB4OTANCj4g
WzI1MDIzNjkuNDU5NDIxXSAgPyBkb190cmFwKzB4ZGEvMHgxMDANCj4gWzI1MDIzNjkuNDY0MzM3
XSAgPyBzdmNfZGVzdHJveSsweGM5LzB4ZjAgW3N1bnJwY10NCj4gWzI1MDIzNjkuNDcwNDc5XSAg
PyBkb19lcnJvcl90cmFwKzB4NjUvMHg4MA0KPiBbMjUwMjM2OS40NzU4NTddICA/IHN2Y19kZXN0
cm95KzB4YzkvMHhmMCBbc3VucnBjXQ0KPiBbMjUwMjM2OS40ODE5MjRdICA/IGV4Y19pbnZhbGlk
X29wKzB4NTAvMHg3MA0KPiBbMjUwMjM2OS40ODczOTBdICA/IHN2Y19kZXN0cm95KzB4YzkvMHhm
MCBbc3VucnBjXQ0KPiBbMjUwMjM2OS40OTM0MDJdICA/IGFzbV9leGNfaW52YWxpZF9vcCsweDFh
LzB4MjANCj4gWzI1MDIzNjkuNDk4NDk0XSAgPyBzdmNfZGVzdHJveSsweGM5LzB4ZjAgW3N1bnJw
Y10NCj4gWzI1MDIzNjkuNTA0ODI2XSAgbmZzZF9zdmMrMHgyOGMvMHgzZDAgW25mc2RdDQo+IFsy
NTAyMzY5LjUxMDgzNl0gIHdyaXRlX3RocmVhZHMrMHhlNC8weDE5MCBbbmZzZF0NCj4gWzI1MDIz
NjkuNTE3MTg0XSAgPyBfX3BmeF93cml0ZV90aHJlYWRzKzB4MTAvMHgxMCBbbmZzZF0NCj4gWzI1
MDIzNjkuNTI0NTgwXSAgbmZzY3RsX3RyYW5zYWN0aW9uX3dyaXRlKzB4NGEvMHg4MCBbbmZzZF0N
Cj4gWzI1MDIzNjkuNTMxNDk1XSAgdmZzX3dyaXRlKzB4Y2YvMHg0NTANCj4gWzI1MDIzNjkuNTM1
NTc4XSAga3N5c193cml0ZSsweDZmLzB4ZjANCj4gWzI1MDIzNjkuNTQwNDE1XSAgZG9fc3lzY2Fs
bF82NCsweDQzLzB4OTANCj4gWzI1MDIzNjkuNTQ1NDU1XSAgZW50cnlfU1lTQ0FMTF82NF9hZnRl
cl9od2ZyYW1lKzB4NmUvMHhkOA0KPiBbMjUwMjM2OS41NTE5ODhdIFJJUDogMDAzMzoweDdmNjEw
YWQzYWEyMA0KPiBbMjUwMjM2OS41NTcwMzBdIENvZGU6IDQwIDAwIDQ4IDhiIDE1IGUxIGIzIDBk
IDAwIGY3IGQ4IDY0IDg5IDAyIDQ4IGM3IGMwIGZmIGZmIGZmIGZmIGViIGI3IDBmIDFmIDAwIDgw
IDNkIGMxIDNiIDBlIDAwIDAwIDc0IDE3IGI4IDAxIDAwIDAwIDAwIDBmIDA1IDw0OD4gM2QgMDAg
ZjAgZmYgZmYgNzcgNTggYzMgMGYgMWYgODAgMDAgMDAgMDAgMDAgNDggODMgZWMgMjggNDggODkN
Cj4gWzI1MDIzNjkuNTc4NTA0XSBSU1A6IDAwMmI6MDAwMDdmZmY0ZDhkZWFmOCBFRkxBR1M6IDAw
MDAwMjAyIE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMDAxDQo+IFsyNTAyMzY5LjU4NzcyMF0gUkFY
OiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMDAwMDAwMSBSQ1g6IDAwMDA3ZjYxMGFk
M2FhMjANCj4gWzI1MDIzNjkuNTk2NDE5XSBSRFg6IDAwMDAwMDAwMDAwMDAwMDMgUlNJOiAwMDAw
MDAwMDAwNDBkNTQwIFJESTogMDAwMDAwMDAwMDAwMDAwMw0KPiBbMjUwMjM2OS42MDQ2MTNdIFJC
UDogMDAwMDAwMDAwMDAwMDAwMyBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiAwMDAwN2ZmZjRk
OGRlOTkwDQo+IFsyNTAyMzY5LjYxMzI1OF0gUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAw
MDAwMDAwMDAwMDIwMiBSMTI6IDAwMDAwMDAwMDAwMDAwNDANCj4gWzI1MDIzNjkuNjIxMjc2XSBS
MTM6IDAwMDAwMDAwMDAwMDAwMDEgUjE0OiAwMDAwMDAwMDAwNDBlMmEwIFIxNTogMDAwMDAwMDAw
MDQwOTEwZQ0KPiBbMjUwMjM2OS42Mjk5MjddICA8L1RBU0s+DQo+IFsyNTAyMzY5LjYzMjg0OV0g
TW9kdWxlcyBsaW5rZWQgaW46IHJwY3NlY19nc3Nfa3JiNSBuZnN2NCBuZnMgaTkxNSBpb3NmX21i
aSBkcm1fYnVkZHkgZHJtX2Rpc3BsYXlfaGVscGVyIHR0bSBpbnRlbF9ndHQgdmlkZW8gODAyMXEg
Z2FycCBzdHAgbXJwIGxsYyB4ODZfcGtnX3RlbXBfdGhlcm1hbCBjb3JldGVtcCBrdm1faW50ZWwg
dGczIGt2bSBpcnFieXBhc3MgY3JjMzJjX2ludGVsIHdtaV9ibW9mIG1nYWcyMDAgaTJjX2FsZ29f
Yml0IGxpYnBoeSBpVENPX3dkdCBpNDBlIGlUQ09fdmVuZG9yX3N1cHBvcnQgd21pIGlwbWlfc2kg
bmZzZCBhdXRoX3JwY2dzcyBvaWRfcmVnaXN0cnkgbmZzX2FjbCBsb2NrZCBncmFjZSBzdW5ycGMg
aXBfdGFibGVzIHhfdGFibGVzIGlwdjYgYXV0b2ZzNA0KPiBbMjUwMjM2OS42NzI1MzRdIC0tLVsg
ZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiBbMjUwMjM2OS42Nzc1NTddIFJJUDog
MDAxMDpzdmNfZGVzdHJveSsweGM5LzB4ZjAgW3N1bnJwY10NCj4gWzI1MDIzNjkuNjgyOTMxXSBD
b2RlOiAwMCAwMCAwMCBiZSAwMSAwMCAwMCAwMCBlOCBkNCBmMiA1NCBlMSA0MSAzYiA2ZCA3NCA3
MiBiYyA0OSA4YiA3ZCA3YyBlOCA5NSA0MCAxYyBlMSA0YyA4OSBlNyA1YiA1ZCA0MSA1YyA0MSA1
ZCBlOSA4NyA0MCAxYyBlMSA8MGY+IDBiIDQ4IDhiIDQ3IGVjIDQ4IGM3IGM3IGY5IDVhIDE1IGEw
IDQ4IDhiIDcwIDIwIGU4IGMxIDg3IDAxIGUxDQo+IFsyNTAyMzY5LjcwMjI4OF0gUlNQOiAwMDE4
OmZmZmZjOTAwMGUyNmJkNjAgRUZMQUdTOiAwMDAxMDIwNg0KPiBbMjUwMjM2OS43MDc5MDZdIFJB
WDogZmZmZjg4ODg2MDY0ZTEzMCBSQlg6IGZmZmY4ODg4NjA2NGUxMTQgUkNYOiAwMDAwMDAwMDAw
MDAwMDEwDQo+IFsyNTAyMzY5LjcxNTQzMF0gUkRYOiBmZmZmODg5MDkyZDczMDE4IFJTSTogMDAw
MDAwMDAwMDAwMDI0NiBSREk6IGZmZmY4OGEwM2ZjMWNmYzANCj4gWzI1MDIzNjkuNzIyOTYwXSBS
QlA6IDAwMDAwMDAwMDAwMDAwNDAgUjA4OiAwMDAwMDAwMDAwMDAwMDBmIFIwOTogMDAwMDAwMDAw
MDAwMDAwMQ0KPiBbMjUwMjM2OS43MzA0ODNdIFIxMDogZmZmZjg4OTA5MmQ3MTAwMCBSMTE6IDAw
MDAwMDAwMDAwMDAwMDAgUjEyOiBmZmZmODg4ODYwNjRlMTAwDQo+IFsyNTAyMzY5LjczODAxNV0g
UjEzOiBmZmZmODg4ODYwNjRlMTE0IFIxNDogZmZmZjg4ODg2MDY0ZTEwMCBSMTU6IGZmZmY4ODgx
MDYxZDYwMDANCj4gWzI1MDIzNjkuNzQ1NTM3XSBGUzogIDAwMDA3ZjYxMGFjMzA3NDAoMDAwMCkg
R1M6ZmZmZjg4YTAzZmQwMDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQo+IFsyNTAy
MzY5Ljc1NDAxNV0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1
MDAzMw0KPiBbMjUwMjM2OS43NjAxNDldIENSMjogMDAwMDAwMDAwMDY5YWRmOCBDUjM6IDAwMDAw
MDA0YmExNGEwMDIgQ1I0OiAwMDAwMDAwMDAwNzcwNmUwDQo+IFsyNTAyMzY5Ljc2NzY4MV0gRFIw
OiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAw
MDAwMDANCj4gWzI1MDIzNjkuNzc1MjEwXSBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAw
MDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMA0KPiBbMjUwMjM2OS43ODI3MzVdIFBL
UlU6IDU1NTU1NTU0DQo+IGBgYA0KPiANCj4gV2UgaGF2ZSBub3QgZXhwZXJpZW5jZWQgdGhpcyB3
aXRoIGVpdGhlciA1LjE1LjExMiBub3IgNS4xNS4xNjAsIHRob3VnaCB0aGUgbGF0ZXIgb25lIGhh
cyBub3QgYmVlbiB0ZXN0ZWQgdGhhdCBtdWNoIHlldC4NCj4gDQo+IEkgZm91bmQgc2ltaWxhciBy
ZXBvcnRzIGluIHRoZSBsaXN0IGFyY2hpdmUgWzFdLCBidXQgdGhlIGhhdmUgYSBoYXJkIHRpbWUg
Zm9sbG93aW5nIHRocm91Z2ggYXMgdGhlIGNvbW1pdCBoYXNoZXMgZGlmZmVyIGJldHdlZW4gdGhl
IGRpZmZlcmVudCBMaW51eCBzZXJpZXMgYW5kIG5vIGNvbW1pdCBtZXNzYWdlIGV4cGxpY2l0bHkg
Y29udGFpbnMgdGhlIHRyYWNlLiBJIGFzc3VtZSBpdOKAmXMgZml4ZWQgaW4gNi42LjM0LCBidXQg
anVzdCB3YW50ZWQgdG8gcmVwb3J0IGl0IGFueXdheSwgc28gaXTigJlzIGRvY3VtZW50ZWQsIGFu
ZCBtYXliZSB0aGUgbWFpbnRhaW5lcnMgY2FuIGNvbmZpcm0uDQoNClRoZXJlJ3Mgbm90aGluZyB3
ZSBjYW4gZG8gYWJvdXQgb2xkZXIgcmVsZWFzZXMgb2YgTFRTIGtlcm5lbHMuDQpQbGVhc2UgY29u
ZmlybSB0aGlzIGlzc3VlIGlzIGZpeGVkIGJ5IHRlc3RpbmcgNi42LjM0IGFuZA0KNi4xMC1yYzQu
DQoNClR3byBwb3NzaWJseSByZWxhdGVkIHVwc3RyZWFtIGNvbW1pdHMgYXJlOg0KDQo2NGU2MzA0
MTY5ZjEgKCJuZnNkOiBkcm9wIHRoZSBuZnNkX3B1dCBoZWxwZXIiKQ0KMmE1MDFmNTVjZDY0ICgi
bmZzZDogY2FsbCBuZnNkX2xhc3RfdGhyZWFkKCkgYmVmb3JlIGZpbmFsIG5mc2RfcHV0KCkiKQ0K
DQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

