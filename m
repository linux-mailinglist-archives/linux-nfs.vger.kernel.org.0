Return-Path: <linux-nfs+bounces-7189-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A8699F72D
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2024 21:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4518E1C20A20
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2024 19:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A211F80CD;
	Tue, 15 Oct 2024 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jcDFHDJD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ymccq7Sb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CF61F80C3
	for <linux-nfs@vger.kernel.org>; Tue, 15 Oct 2024 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729020067; cv=fail; b=KrjOxeIqFCb27WcpNf4IzP7M/fEfyJwDsqdHxremvGmguP7jYZo01PWUm+fGfuitDW/Eck2QIluy74UPvhmP6EX0Ka/l/L8f4XBV1igHtaOLNYfk80cPUWJn3b8KmeRV8I3y7PloVHxm4HsmPB+JZXrog7/TYIoyTyOWt/zSoB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729020067; c=relaxed/simple;
	bh=RY386GUw00LMJHr2tIZO1PJcgRS8ekvVl4HrtZbFbiM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=laV0CdZ6Nzk68w7L0GeinoZ8gZjBmr+8tT47CifAiRVi5+LxdsP09lueRy1pB0w6Qxa0GhP3/0vIDiUC1/h9/jkI2PzyOryFIfjlqNgGjYNshY9xoV/stDeHi2gdKDFKZeeEW/cZoP0BxeefWj9EaI6ADtNljZPdJ6RKQqeyTTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jcDFHDJD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ymccq7Sb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHtiQ3023516;
	Tue, 15 Oct 2024 19:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RY386GUw00LMJHr2tIZO1PJcgRS8ekvVl4HrtZbFbiM=; b=
	jcDFHDJD8pB41HD24hjasXmwiW3SjfZeDvvqYEmvXnQLyjDciZIQ4q4ec4mDIlNs
	KD+AsjcyQNqlcbD7eg5DqMMyP9gUXZmRCzyzJt72EUwAsBmZ3U3YSTpS0MLRwOsb
	1aQk1xWDDyntnCs8L0eW3UThPC/ft3GpuYIJjrbg3sPZwxmfl/2J1PR5p9X+1FBb
	b6SfRV6L5VnLTYXlbvoWb+LY+bpxV9LYUIGZbgs60JgWG+gNd8kB63p1iY8bj/xs
	hNEZwImIMaW2jPZsow3XpAnpJvSfrdugVRHCTfkyZqIjo/GhJgHAvxHV+JR+rrXt
	rAX3mhhicRcL/ga1bDkU2g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09hhyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 19:21:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FIJ5qo014020;
	Tue, 15 Oct 2024 19:21:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj7vpy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 19:21:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNJCP5mWDQ1kXg6tL1gvhTpaD1GbeEm8o2I+NHsnt2XuDR9UCzAdiviIL/Pc2qzIrriIeBGcACw+ZVKipd//m37a3ghYEQDEUImkJuC2CNtghWd8mipejLWiWRdHJ11jNC+8r1DdqR5b8v+kTZXJYqHrxAkNUWxsmuazN0RtaaukWnTUx8CcP4VdtF8oh/r5ik1SCT93/UQCNfdPAIQmLZ1qLj/KRq+iYQmjQaFiyEoi0MtpA+VTXU2SRY3nf/voswNZvgAzlC8xHSmGOdUd/WGK1bVsGLrpR5PQfayFHLhMSBd283gjgDZHUChyxkkGGxFsj3a82HPDyRDKStZpew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RY386GUw00LMJHr2tIZO1PJcgRS8ekvVl4HrtZbFbiM=;
 b=mlPHDS81s10hmUrT182h7Ovubs5PxerzoevZtk2j84eQSMM08RhUOvpP/oIYHwdt6VkiPz19wW0leVov4Q7wIC0JmlzLZ0SjdNxD0biXcuJac0ZCabo/uJ9RogR0XeL5I/jv4T5PCi73K1aasoYRglVk4OKTjpp9xSJjFve4qZUQy9B76qxFFV9sOELiUZG587UmzNxdkcElNMo7NNB6as9FUgHiuJ2DdrAiolGDzRia54cMzAfSjoDQH0cVLubNSdoz4nBEWog+S2KXxe6uu02MGemlEDBCvaltVJMVBOiIo4uUCqLoVhwEqOfn/bYJus7bM2VMaBH9UMRfZKhtHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RY386GUw00LMJHr2tIZO1PJcgRS8ekvVl4HrtZbFbiM=;
 b=Ymccq7SbztWRrb8x3nP2ZBzJib6u3Ms21GOrjyCYpIi9hdIYXH9pC+SyB4n179QRQ9q5IAk6uzQFA92POLiJWGRGE3ApU8D6LU6/eGTUHgglt1fyZ0j2x4pJcuE075dX3/LzWF3J5tBoqHup4qywPSXr+ivYJHIEh5t0HfCDE/k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5100.namprd10.prod.outlook.com (2603:10b6:610:df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 19:20:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 19:20:59 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Calum Mackay <calum.mackay@oracle.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH pynfs v2 5/7] nfs4.1: default to minorversion 2
Thread-Topic: [PATCH pynfs v2 5/7] nfs4.1: default to minorversion 2
Thread-Index: AQHbHnrDg8LzcFUYDEubfUZFT/rBorKH04QAgAALKACAAFMMAA==
Date: Tue, 15 Oct 2024 19:20:59 +0000
Message-ID: <0DE3559A-80B4-4FD0-93A8-1BD1C69B4C39@oracle.com>
References: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
 <20241014-cb_getattr-v2-5-3782e0d7c598@kernel.org>
 <6123766E-BCAB-41DB-A86B-E75B05DC88C0@oracle.com>
 <7e8aa0029fcf6901fab769addd054e17bfbae033.camel@kernel.org>
In-Reply-To: <7e8aa0029fcf6901fab769addd054e17bfbae033.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5100:EE_
x-ms-office365-filtering-correlation-id: be4d9799-2a7c-4843-92e0-08dced4e8004
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NEpjeUxMajVVcFlWMmZwejBJNy94VHNlaGtKY1hxc3JSSndUVUNNUWU2Vjhs?=
 =?utf-8?B?clc0RG5TUDNGVmxvUjI4WmlvcWJ1SG9UUHV3dzJFMTExUGNCREV2SVdqc3hG?=
 =?utf-8?B?TFdHWnc2aWZLUjVScmRtRkk1aVdSQ2lMYzRONTdEZ3hSUlBXUWpyY01GZ053?=
 =?utf-8?B?NVpDQ3pFclgrZG5iOUxJNmNNS25Oa3FHeG1TUjZKWW1aaFRqOU5kcEpwWEJ1?=
 =?utf-8?B?TUdQYThuVjJGZkR0cmxtVUlTdkY4RklxZGRBcUlUUVg0NHcxaWZkZ3NVRDhB?=
 =?utf-8?B?N2l6TEY5NEJYbnpHeXI5N0RpNkx1THFucmx2MGkrenVhQkpIZHdsVHlRTjFH?=
 =?utf-8?B?eHNLb2VVM2VrL1d2ZlJ1L3Q5ZjF6RDM3Q1F4d0FlZFB0b1VKVk9STW40VDkw?=
 =?utf-8?B?MHdTUVZkMGFaMndnNjFLak51ZGd1RHR3RjZiSitLdENiNFpYaGlPQnZLUlFi?=
 =?utf-8?B?bVBmc3dsRnpjaHQ5TGVEVkJxbHVmb0J4SEg5S3JxTkJma1hBZm5DUkFoT1Fk?=
 =?utf-8?B?UktYVWFRM1ZHdm00ODg3ZW5Wd2IyRjJBYnRkQ0FBcFZsNmZrZVc5SkV5V0Nh?=
 =?utf-8?B?Vm9QbDM1QjRxRnNydkRrdE5taGhrWVVyUkVvenRidk9WV0d4RFVpN2k5VGxB?=
 =?utf-8?B?ZGErRUF4SnAxbzBMQUszYlA4NlFEdkQ4Rkt1REl0RVJuOUxCRnBVOFNEOGNQ?=
 =?utf-8?B?ejBVNzhwbEEya0lsc2pnRlAwdllLMlc2VzhJQTQwZFo5SzhTRHZocHgyTHAv?=
 =?utf-8?B?ckd4enZvbk84OUlqYjdPYUxoaEI1bjAyMlhiL3Z4MjBDbmtsL2tUTVpHWHcr?=
 =?utf-8?B?MmJoNXZFZjNubXJVSlROWnlVTFh0dWdCeW1hWVYvOEZDWmVvVXdUSWVxRFdG?=
 =?utf-8?B?RW9yWVovZTVQUWQySGhTaWNFZlBvN05EeEZzOEVmTDRCT3pNbWdPZVlVQlQ2?=
 =?utf-8?B?N05mVDY0RTdjQjZDOFNUeEQ2SFBKU0pkVHBoQ3pkTU92cnRiWE9CdVE2dlYz?=
 =?utf-8?B?cHdSVHpCV2YwRGpOdDZ6WjVhbDdodnNwem1hUzRxeHVCQ3c4UXZGMW5saWZ0?=
 =?utf-8?B?YVh5cmlWdk15WVJqSzVZV1B3VEZTeGdEdHhiK01WLzdhbFZvc2taR201OHRl?=
 =?utf-8?B?NHVEMnpqWFBzQWl5aWRZY0swQWtzd1k5RkE2MVVOK05FeG1Uc09Za0ROZUNw?=
 =?utf-8?B?YnlJc3g0UlVkZjVOSy9pMXgvalo4MnlFcEkwN2lYc1VGVlZrbnN5UGhMU2Y5?=
 =?utf-8?B?NnVVMytSaE5zbm1oaUZrZFJEVStVSWJtZCtqemZTL1lVUlZXSGdsMVBaYnhC?=
 =?utf-8?B?QTAxZU0xbHdrSXJSc0NySlVNRnlmeERDTExubkVtQ2NIRFB2WGFpWkZDVFBK?=
 =?utf-8?B?dVBsOU54LzFlM0NTRG1yYzJmdkdtV0NOT0pEZm5sU3FBTC9BaEZJcjBWMjBP?=
 =?utf-8?B?Qk1wM0c1N09EbGtFbXp4em9IbGFLWVdZVUpQTFdUSG5OTndJVURSb0ZuTjho?=
 =?utf-8?B?TXBaajlFV2g1MnZQMURsQjFPSDFaY3dweGkrTGlVR2FaVmNuQTVyZVdyQWlx?=
 =?utf-8?B?dXRlNU9LbzlSLzZjUFV5Q1pGVkg4WmR0dGlyb0ZCb2xxcUQ0TCt3TjV1NWhE?=
 =?utf-8?B?MnJyL1drbWptRVp4OGJ2b2w3SGJWNmZFV0ErUitzaW5aTjR0SzJRclVwcDcr?=
 =?utf-8?B?R2pHY1Q1ejlzdGNKVkNEYWM1Z1B0ZmhiWkpaOSt5aTlkQnFLV1phNHlJUW9K?=
 =?utf-8?B?RXZWN0lPTTV6TzFJK2s4azhnZEcyVCt5SWNOWFpWWlhZT0IxNDNSbkdhdXBE?=
 =?utf-8?B?OU5uUDlwWTFrcHhuc3BSUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THdHWUhEQkN2aWVCcFN0Smh1RzB4d254dUFwYTRRZDRGUzMvTVZpOGhWeUFv?=
 =?utf-8?B?RzBJWm11cTh2NFlEZzcvdG1YZ2Y3S0RNdUthWE9MYkhwckp1cTExUjJQT3hi?=
 =?utf-8?B?TVZvc3loOE45a21GY2dnb00xOXU4a05ZVFZTQVlYK1VFMzhmUjNhMmVKaEQ4?=
 =?utf-8?B?WmZPdXdnNi9RVlNVMW9ZSDFiRGZiK1NlTzhEb0h2c2lvd2QwZG9xWkJFTG9C?=
 =?utf-8?B?MW1vdFZ3ODRKWWtobTI2TGZoWFlvT2NIYURlb1p2aDVHQW1GRWJPUk1La05K?=
 =?utf-8?B?VHV0MmtWNnVaTHBOSUtFMEUwblU2NWtUSzRRZmdseTIvL2N6ZEFpVmxHOS80?=
 =?utf-8?B?SUtPTVpnWnNSTjJDUm42NldyV1Ixd05uSzFYSEFpQm5hWEpsOVNJUlpyZEw0?=
 =?utf-8?B?SkdRUW02b1poQnFoZTVPeE9HNDR4b3Z4Vjl1Y1NaRVdkWVlCNlNZSDVlNGJy?=
 =?utf-8?B?ZHd2cGlHcDhIN0pPU0pXcTJoM3ZQclA0bjhqZGgwNzBrMzljWG1nbytlTlVK?=
 =?utf-8?B?blk1Vjl3U2dIaFMvaHhHcFN2VVdJOUJrZlc3YWxtQkFwUEVSdDNNd2xDMjBu?=
 =?utf-8?B?WkV6RjBIYUNaUHdVaXovVkpBUXFJQWkvQlQ4alpQQStscHoxZGVSWFI1blVD?=
 =?utf-8?B?Yjlmb0VmbWsxUFZyckhxTkNXQVA1bkd1YVArak0wTXYyS210RCthblplMkpO?=
 =?utf-8?B?VnNuS0o0cUVpSHJjdzU1dFZrWjgwbWt1bzEwUGwvZ0hJc2Q0TzBGNm00WTFC?=
 =?utf-8?B?YjNkZ1ZPRGpYaFRPdjRGN3Vyb0QyUWZUVGhGQWVQamd5UTlUVmY5cWY1MWNG?=
 =?utf-8?B?SGZtM1BseStZL21SSUxvR3kzamh6cEVRcm9RdnBmaU9YVms5cDdKYXBTQXBW?=
 =?utf-8?B?MWFqb1RXT1NhdndOMVNaMG83WjI2QUNMeGkrRFgzM0N3OWZCNVdxY2tCVVZt?=
 =?utf-8?B?R0ZYeTRxY0ZoZ1RxTFRtUWVBeDlwUVBqUVd1cTJISHBzQ0VkRTVtVm5GT1lE?=
 =?utf-8?B?ekZ5OU0yeUtYcWZZTGVjMXVjSS9LRlNsZnAzejBtNVhKWGxuTjhpRDFKNnBp?=
 =?utf-8?B?cjBQdXNXNzBKOE14N1dIeHR1QWpETGluRW4zbkZSTCtzOWZpUzZGcG1tZmxt?=
 =?utf-8?B?Mks3RVg4VHN5Qm4veFUyQXZacjllc2hSTk1LUHNqZ3lLT3FjYTFqWVBNVlpJ?=
 =?utf-8?B?YVZyTGhpMVBYZHN5aVdoZnM4N2J4SGcxa0pYYXgreGswUlFKRk0wb1RGdWNJ?=
 =?utf-8?B?aEI3NjNjeWs4YkVIZWU3YWF1T05TempGSDRGdDl5VTF6TVV0aCtBNlg3VEFt?=
 =?utf-8?B?V0pEcjdYeW9GNlpxRDZWMHFOcmhPM2VGdnpnaDlVKzRmUE5KSzRHMFNMNjhv?=
 =?utf-8?B?UkhEUWNwbnJLSzVnaC9VQlZvVHorNlQyMSt6TkhUMjFCM1VWR1dkK3A3VnIv?=
 =?utf-8?B?eUt1ZzBteGNZWlEySUJqTXRGV3pHUHRDSUxmQVBhNWc2K2VMaXZzaE5tdm5u?=
 =?utf-8?B?cUpqU05uZ0hHNHYzWEd4bHJ0R3VVTkJ5amRibDVsUkEvSGd5VkU3SnJzR29t?=
 =?utf-8?B?MFQ3OXZ5VUErOSt6Ui90MzVPYlJVOUUxVmRnRjIxREN3M3VoOUhNSDZvLzZS?=
 =?utf-8?B?TjNCdG96dEdSQjRtb3pEVXllbXlIMXMwYTFJZlF4V3ZhcitDa1ZlVEZOZnBL?=
 =?utf-8?B?ZWt3OGxxV1dwSCtDVDVQNzZVQmFMaTlqbWREZXZRa01hTVBJYVVWU3JhQ2p1?=
 =?utf-8?B?NC9ydTl0ZkNFZ3VxNGRpdkVHQUFNSmZEKy96Yk9nbWJCRFd1d3YxNjN1Wkkv?=
 =?utf-8?B?Q1l1cnZLRUd4amMzOFdRN2RQKzlQd0QvTngxR1A0c3lNWjBFSk5sZWJ0Tk9y?=
 =?utf-8?B?N1FXbUxKYjArMytaY25FTjBjZkRvUUx6bVBvWXhjaWpoQU1LclQ5RmhVQXM0?=
 =?utf-8?B?czRFcW1ZZk9LNU1oemt3Z0ZJOXJvWjJORnFzcnpFenI4cjVLMXBuRE1CTDhl?=
 =?utf-8?B?K3pQWmdIVWRrWkNtajNaQVlFbU9kSUFGWCtJdmZZZERSY3FGQlErQ0ZobkNh?=
 =?utf-8?B?ZGVQWlVQZDEzVDZ4RGoyMXp5cGV3c000Z0hWckMrK0xDZkVsUGZ6MGVCR2h4?=
 =?utf-8?B?cEJkNDMxS3g2QlV3WFpKR3cxUFRvRTBFczJHUjVad2I1eXJadHdJRHN4Ymx2?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B68C2D5986BFCE4C9249EA3C280D3577@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DJLNtLUIt9NQp0QPLoNqdjX1D2Z+FSjyUGOY5IWIfiZuDn16P1u5xlt2tgEy4kwaJ8WN1wkcnyIfJXlbOw+HzZer2f9gHEXXKjG3z+3JGWoL6Yq4Ak9gNNEcgItSPjbCHFEdLTPoWN4x5vn9LegpIqh4sI6aHeDwLq+BqDYEDD0RuF5pqW+Y3MUfwGYnyuvkY/KkAjlQOhIUgEsCHz8Wu9OIqWOrI5idpBxOoRqmTG0rFnbN87FblnMyCmHS8zChW0ueq5Jdk//yS7A/dhX0MjeklldpvltbBeczh/SW8WA6bePlu2HtrB8TkcAwwLyNVjIDns2azqh7frsnwmLcOUmcNY+s+WiqKqG9ijuG6fDIFK90qcURGYM2qwfspFs5BpYmrtfnUNu6oWNMe8/+zlfkbKof8Y/K4th8mwqQbGFuj+uXlC39BV8EszndKFIF/CtBrxeThGxn3ivA46rPPETXPIz3h6ajQNTjVNcUjTVYhazPfsNNQsj/LFrH3fJc+CVIhu9AP2zsqvkoHk4rfdVIDk5Wm8RQak96yjiCkAa3Z8JdycM60qJrR+btHKDPBGh8JBq2Wej0Du6P7gF8OPqYpSys5rT70dG1jb1Buss=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4d9799-2a7c-4843-92e0-08dced4e8004
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 19:20:59.0219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6eExbLTLkAALLAtsojvJD3IEktrhxWYMuYjLgW4HEc9OgMKqJsrCg0JsQExnzCuCfo4ivCjroTTymIBNFIbVgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5100
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_14,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150130
X-Proofpoint-GUID: XVa97jZcfA_8YsLV9CFn5ekjp6XV3Q2_
X-Proofpoint-ORIG-GUID: XVa97jZcfA_8YsLV9CFn5ekjp6XV3Q2_

DQoNCj4gT24gT2N0IDE1LCAyMDI0LCBhdCAxMDoyM+KAr0FNLCBKZWZmIExheXRvbiA8amxheXRv
bkBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgMjAyNC0xMC0xNSBhdCAxMzo0MyAr
MDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4gDQo+Pj4gT24gT2N0IDE0LCAyMDI0LCBh
dCA0OjUw4oCvUE0sIEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+
IA0KPj4+IE1pbm9ydmVyc2lvbiAyIGNvbnNpc3RzIG9mIGFsbCBvcHRpb25hbCBmZWF0dXJlcywg
c28gd2UgY2FuIHNhZmVseSBqdXN0DQo+Pj4gZGVmYXVsdCB0byB0aGF0IGluIHB5bmZzJ3MgNC4x
IE5GUzRDbGllbnQuDQo+Pj4gDQo+Pj4gU2lnbmVkLW9mZi1ieTogSmVmZiBMYXl0b24gPGpsYXl0
b25Aa2VybmVsLm9yZz4NCj4+PiAtLS0NCj4+PiBuZnM0LjEvbmZzNGNsaWVudC5weSB8IDIgKy0N
Cj4+PiBuZnM0LjEvdGVzdHNlcnZlci5weSB8IDIgKy0NCj4+PiAyIGZpbGVzIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+PiANCj4+PiBkaWZmIC0tZ2l0IGEvbmZz
NC4xL25mczRjbGllbnQucHkgYi9uZnM0LjEvbmZzNGNsaWVudC5weQ0KPj4+IGluZGV4IDk0MWNm
NDAwMGE1ZjBkYTI1NGNkODI2YTFkNDFlMzdmNjUyZTc3MTQuLmY0ZmFiY2MxMWJlMTMyOGY0N2Q2
ZDczOGY3ODU4NmIzZTg1NDEyOTYgMTAwNjQ0DQo+Pj4gLS0tIGEvbmZzNC4xL25mczRjbGllbnQu
cHkNCj4+PiArKysgYi9uZnM0LjEvbmZzNGNsaWVudC5weQ0KPj4+IEBAIC0yNyw3ICsyNyw3IEBA
IG9wNCA9IG5mc19vcHMuTkZTNG9wcygpDQo+Pj4gU0hPV19UUkFGRklDID0gMA0KPj4+IA0KPj4+
IGNsYXNzIE5GUzRDbGllbnQocnBjLkNsaWVudCwgcnBjLlNlcnZlcik6DQo+Pj4gLSAgICBkZWYg
X19pbml0X18oc2VsZiwgaG9zdD1iJ2xvY2FsaG9zdCcsIHBvcnQ9MjA0OSwgbWlub3J2ZXJzaW9u
PTEsIGN0cmxfcHJvYz0xNiwgc3VtbWFyeT1Ob25lLCBzZWN1cmU9RmFsc2UpOg0KPj4+ICsgICAg
ZGVmIF9faW5pdF9fKHNlbGYsIGhvc3Q9Yidsb2NhbGhvc3QnLCBwb3J0PTIwNDksIG1pbm9ydmVy
c2lvbj0yLCBjdHJsX3Byb2M9MTYsIHN1bW1hcnk9Tm9uZSwgc2VjdXJlPUZhbHNlKToNCj4+PiAg
ICAgICAgcnBjLkNsaWVudC5fX2luaXRfXyhzZWxmLCAxMDAwMDMsIDQpDQo+Pj4gICAgICAgIHNl
bGYucHJvZyA9IDB4NDAwMDAwMDANCj4+PiAgICAgICAgc2VsZi52ZXJzaW9ucyA9IFsxXSAjIExp
c3Qgb2Ygc3VwcG9ydGVkIHZlcnNpb25zIG9mIHByb2cNCj4+PiBkaWZmIC0tZ2l0IGEvbmZzNC4x
L3Rlc3RzZXJ2ZXIucHkgYi9uZnM0LjEvdGVzdHNlcnZlci5weQ0KPj4+IGluZGV4IDA4NWYwMDcy
Mzg4YWQ4YTRiNDc3MDczNjQxYWUxNjI2ODUzMmJjNmEuLjA5NzBjNjRlZmUzNGRjZWMxZTU0NTdi
NzAyNWZhZjBjYjEzOTY3MGMgMTAwNzU1DQo+Pj4gLS0tIGEvbmZzNC4xL3Rlc3RzZXJ2ZXIucHkN
Cj4+PiArKysgYi9uZnM0LjEvdGVzdHNlcnZlci5weQ0KPj4+IEBAIC03NCw3ICs3NCw3IEBAIGRl
ZiBzY2FuX29wdGlvbnMocCk6DQo+Pj4gICAgICAgICAgICAgICAgIGhlbHA9IlN0b3JlIHRlc3Qg
cmVzdWx0cyBpbiB4bWwgZm9ybWF0IFslZGVmYXVsdF0iKQ0KPj4+ICAgIHAuYWRkX29wdGlvbigi
LS1kZWJ1Z19mYWlsIiwgYWN0aW9uPSJzdG9yZV90cnVlIiwgZGVmYXVsdD1GYWxzZSwNCj4+PiAg
ICAgICAgICAgICAgICAgaGVscD0iRm9yY2Ugc29tZSBjaGVja3MgdG8gZmFpbCIpDQo+Pj4gLSAg
ICBwLmFkZF9vcHRpb24oIi0tbWlub3J2ZXJzaW9uIiwgdHlwZT0iaW50IiwgZGVmYXVsdD0xLA0K
Pj4+ICsgICAgcC5hZGRfb3B0aW9uKCItLW1pbm9ydmVyc2lvbiIsIHR5cGU9ImludCIsIGRlZmF1
bHQ9MiwNCj4+PiAgICAgICAgICAgICAgICAgbWV0YXZhcj0iTUlOT1JWRVJTSU9OIiwgaGVscD0i
Q2hvb3NlIE5GU3Y0IG1pbm9yIHZlcnNpb24iKQ0KPj4+IA0KPj4+ICAgIGcgPSBPcHRpb25Hcm91
cChwLCAiU2VjdXJpdHkgZmxhdm9yIG9wdGlvbnMiLA0KPj4+IA0KPj4+IC0tIA0KPj4+IDIuNDcu
MA0KPj4+IA0KPj4+IA0KPj4gDQo+PiBJJ20gbm90IGNvbnZpbmNlZCB3ZSB3YW50IHRvIGNvbWJp
bmUgdGhlIE5GU3Y0LjEgYW5kIE5GU3Y0LjINCj4+IHRlc3RzLg0KPj4gDQo+PiBIb3cgYXJlIHdl
IHBsYW5uaW5nIHRvIGRlYWwgd2l0aCBORlN2NCBleHRlbnNpb25zPw0KPj4gDQo+IA0KPiBJTU8s
IGl0IG1hZGUgc2Vuc2UgdG8gaGF2ZSBkaWZmZXJlbnQgZGlyZWN0b3JpZXMgYW5kIHRlc3RzIGZv
ciB2NC4wIHZzLg0KPiB2NC4xLCBnaXZlbiB0aGUgcHJvdG9jb2wgZGlmZmVyZW5jZXMsIGJ1dCB2
NC4yIGlzIGEgc2V0IG9mIGV4dGVuc2lvbnMNCj4gdG8gdGhlIHY0LjEgcHJvdG9jb2wuIEkgZG9u
J3QgdGhpbmsgd2UncmUgd2VsbCBzZXJ2ZWQgYnkgY3JlYXRpbmcgYWxsIGENCj4gYnVuY2ggb2Yg
ZXh0cmEgaW5mcmFzdHJ1Y3R1cmUgZm9yIHRoYXQgd2hlbiB3ZSBjYW4ganVzdCBleHRlbmQgdGhl
IHY0LjENCj4gc3R1ZmYuDQo+IA0KPiBUaGUgdGVzdHMgaW4gdGhpcyBwYXRjaHNldCB0cmVhdCB2
NC4yIGZ1bmN0aW9uYWxpdHkgYXMgb3B0aW9uYWwuIElmIHRoZQ0KPiBzZXJ2ZXIgYWR2ZXJ0aXNl
cyBpdCwgdGhleSB3aWxsIHRlc3QgaXQuIFRoYXQgbWF5IG5vdCBtYWtlIHNlbnNlIGZvcg0KPiBl
dmVyeXRoaW5nLCBidXQgaXQgc2hvdWxkIHdvcmsgd2VsbCBlbm91Z2ggaGVyZS4NCg0KSSdtIHN0
aWxsIG5vdCBjb252aW5jZWQsIGJ1dCBJIGd1ZXNzIGl0IHNob3VsZG4ndCBiZSBhY3RpdmVseQ0K
aGFybWZ1bCB0byB0YWtlIHRoaXMgYXBwcm9hY2ggZm9yIG5vdy4gTm8gb2JqZWN0aW9uLg0KDQoN
Ci0tDQpDaHVjayBMZXZlcg0KDQoNCg==

