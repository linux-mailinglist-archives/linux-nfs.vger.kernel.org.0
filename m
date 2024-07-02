Return-Path: <linux-nfs+bounces-4560-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C019246FA
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 20:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B47B25464
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 18:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F621C0DF4;
	Tue,  2 Jul 2024 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b8cjFzl9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ehiwPEBd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FC8178381
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943583; cv=fail; b=olNMa1k46xdBn3lzNwSydGXAyoi0cPX3tTvBay/Ff+NcAS5HbpHicNZkjpmxWo3p2GQRC3mFajaAZ7R0Tk/l0mqvUpHOgebdfxqYD4kcxO/AJ2R9zPgVO0sQV+ipXRmBjyDu0zqU0aX7A39KUi/RtlPdRq1qVj4MXO4DEK+C9hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943583; c=relaxed/simple;
	bh=gNN7d2SVWrC2MM/6E0M/pqZ82kgUd77i2pxSGd5rIwI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z66l8+ITci9IglTcdH9qDG4ssMdAKjX4H8wiGFVjdmrXs3aN5pAuHaKLEnoqsxfJ/JlrroUdkUbTTeiSjgAOb8spZiwFHwcWTVFk3izo4lwfry5YkwW4Swtsbvsvr+6e/vbEbMWrsnePXW8AhCkWfZQv8bzjoLe4NJLVaESkeWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b8cjFzl9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ehiwPEBd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462HfXPp006974;
	Tue, 2 Jul 2024 18:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=gNN7d2SVWrC2MM/6E0M/pqZ82kgUd77i2pxSGd5rI
	wI=; b=b8cjFzl98qQNRW4vIDAW5RUlLO8UIUmCTml3laJWLtPDxkcxns/V2l7ZN
	UUNDRQCsM8cpIQVzm7qUFlh0QAqn//P8fXR2uvm3WpRKyk/KlkfS0VLEyd/asS0V
	Q8fSAzXHqM7Wul8P0B0Cc0q4qYzQdV37l69kyB5daL8LIlygiDjhpESlK0Nzm6op
	Ooz2rz/qhUi2RXkZN0exBJRgqMSV3uzElWR/nCquk4SLAeNINWXgHnilf9nxKPZH
	TdrFQk3euPIlyw1Eoh0ewkFedrJ/+MPmu76TKNhnI0OKg3jdIMelPdzq0S8m3FXw
	xtNA1g9GYEviLRfAPevA2iU7gEQbg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a596b6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 18:06:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 462I514X023607;
	Tue, 2 Jul 2024 18:06:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n0y42w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 18:06:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDit3C0ksNA9Yoh/WzAiMrsSlvBR2TqSzsr+MbwTxMCeWMIgr017ces7/ZpeaUTcjTLuxR7NCUe4vH94kJZMF+N1PWENY2AWVL/LzivVw3AJe6nbJ7dXfsstFRABdXrl4ib5wtJxRstmIRvLHC/RRB0Wza2pV4ApSEBbeDR1WtMw0nFNYcAuehfI9G+A/as0OnqT56gDr6/R+AAz09oQYlkh5KJd+/hQwaW+tSqb+WwjXowjNw03/Yee1m4HXsVRjtPrKDUtDRhnxgFqTL6+fYhWYpq7FvxAVFa54PqY7YQ8Rj0Ad4twNS1BunD+2BuTWm1CRdddpqMzWKuu9Izokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNN7d2SVWrC2MM/6E0M/pqZ82kgUd77i2pxSGd5rIwI=;
 b=AB3r/y5JMR08XuWy3ApOYH3R3hkFeu5/JZ+HvYjHtLiGJLRpGx6zglSd0IQ6o9X1NeAl3qKQkJMkW9+GmcbsDRZUIG/PdQnS4cUIyLdRy9qRTZ7cx8xlQDhp1yMNJ7nhQy4dRhEScHHqFVwT2Y5r+GXsLRcyZylSZXWVdvaXzwf3K7OQJfp9fYDmmy7Y2z/W8MV2tEVL68LKcprFbwZmbMcbdNuYc9tQQNjMyuuD2xpT8pwvo+AOnfCe5BtjMG+Xdm0UfDMYlnivlyLPTltsOJugj9qJe2l7j9EUDB8kJYs4rqjmKam6EQvjGwNgCVJyNpNENDhTo+bw98UVW7iSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNN7d2SVWrC2MM/6E0M/pqZ82kgUd77i2pxSGd5rIwI=;
 b=ehiwPEBdinhegpljLXAsxDnYWcQoVJaiRMkh485pI/Eb37pcAGtw3uoRO4dnVsNe1qDjEa7RkpLSREGfMyDYVLhePlK+peGZIHRVcVYDvZ+kC+bmINkHIKAIQ5jG9bVG52HyuBxTjTphRYjiVMZGUzBqxnBy9e/mPN1EsGd4hkg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4564.namprd10.prod.outlook.com (2603:10b6:303:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Tue, 2 Jul
 2024 18:06:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 18:06:09 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton
	<jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Trond Myklebust
	<trondmy@hammerspace.com>, Neil Brown <neilb@suse.de>,
        "snitzer@hammerspace.com" <snitzer@hammerspace.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Thread-Topic: [PATCH v11 00/20] nfs/nfsd: add support for localio
Thread-Index: AQHazJzmgcDeJH7XRUCD8QiVhiofhbHju8AA
Date: Tue, 2 Jul 2024 18:06:09 +0000
Message-ID: <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>
References: <20240702162831.91604-1-snitzer@kernel.org>
In-Reply-To: <20240702162831.91604-1-snitzer@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4564:EE_
x-ms-office365-filtering-correlation-id: 82cae321-1337-43ab-9fcb-08dc9ac1a6a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cHgwcUVIanNFZnlYdlYxWEFhUE9kTUxTM1Jyc3A4dlVteWVrMlphWmNDY0Rj?=
 =?utf-8?B?elpsd1BSb3htMWk4TW5MaXF6a1Y2MEUyNFdDNHQxZVdJT0JsQWg0NkhrODNy?=
 =?utf-8?B?bFAzYS92b1RvNG1DVHRZSTNVSjZEZ2pGNFRacW4rWEthZm5oZjU4RnFnWVpW?=
 =?utf-8?B?SVl5cCtWMW84Y1h3QXoxazFKa2V4TGVaYzZjMUhjMWptY1B6NWlwM1loSlJk?=
 =?utf-8?B?cmM1NzRoaVc5cEZqSUlERDFjSDVmK3Iwc2RGQjMxWURNSVhtU3dWYzRuMGNC?=
 =?utf-8?B?Szh4MTNpcDNrQUNVNGk2bHNNUjJ0cHhMdE5JeHlQUjEvMDBreEZlaWFodXN4?=
 =?utf-8?B?V3o3K2lVYnpHUlJiaG9TTC9TaUpqbmRVNkszaG1JOGoxUURlSTlxRk1NbEJB?=
 =?utf-8?B?aXNuSEk2NExIK21QYVNXdEtBUFFWTVdoWnZ1Ymp5bnhGWkRXaWxHUUwwOWFW?=
 =?utf-8?B?QmhZQjZLRTdqNGVVdlFHVFRONSt4Y1BQaVg3T2t0OStXOUYwUjh5ZjcvbC9p?=
 =?utf-8?B?cWwvNWVjeVpmc0xyUHdlVTNZOUI1KzRnQjJLZnVMd21ERUl1TzJaMG9Qdzkv?=
 =?utf-8?B?SGlKQnNjeDIyd25oSmh3UFRpTURoaVhBRWFvQ3VGS3ZJOGJHNmh6QXBwS1ZQ?=
 =?utf-8?B?ekZEaWE1QUlocDFFdEE5MXpPSSs2SlBMWCtkdFpOMzZvRkwrMkhqUlJYbk5q?=
 =?utf-8?B?cTR2VzlQOFRvS3JwOEM1L2xBLzJLd0NZc3FKelhHN2R3U0lYUzZaU1EzMnQr?=
 =?utf-8?B?d0dvOG9ncFBJUGkwQi9jb2dYV09ORWc0WnlxcWVheVRlTUtnMXpFQnBxL1hW?=
 =?utf-8?B?NDBGb0dUamdFdXBCRHFqTDVMMy9qUXpDdVJCS2N6dzRpdFYwcnZsTEZzSWpi?=
 =?utf-8?B?aWVidzA0UUVHb1JtNStDenRURTZ3dDUwcmtTT1RNZmR1dE5jTDVndDI0MFcr?=
 =?utf-8?B?VDl0VDM2VlFBcW9CNTk0eGY5dW45M3RPZk1ZQitSQ2pTbCtEUWQ3bzlQaUl0?=
 =?utf-8?B?Z2pFcUQxOUxkVmRZK1lzSXZDMnBRcmxxTG5uTDRrai9JSGkvM0dHRGVFTHRq?=
 =?utf-8?B?WUpBK1hXVEVzK1BXWmxraFE2VHlIMTdNdGlVVU9BYTM3ZFhlYTFHNWdTc3l4?=
 =?utf-8?B?ZFhrcVIvbkJmSTJSWlE3c0NqKzlwTE9lZ2p6d1p1Z0EvZDlSQXRGU05YM2Jr?=
 =?utf-8?B?MGVpSzZzR2xZcHh3WmZNeDhwREYrVXp6NTAwR25ETG8xb21OR2t1a3o5L2pi?=
 =?utf-8?B?bEIrZUlrWXM3K1hBVTJCZzBuRmNpOFRVTkRVamNia3gwTHByRWltdHgxSXYr?=
 =?utf-8?B?OVBNNkZTa1dVaHJYVFBvUHE5U1M3ZFFFa0dRazNoQlhFRnUySWhLT1JYTVA2?=
 =?utf-8?B?bzZyc0p6ek15SHJmd0xqcWNwbjVueERobldYeis3WUQvM3Vkc1N2Z0VxYTRO?=
 =?utf-8?B?NjUzUUFJS1VUVGxzb2NGWnMxQ2xlOU9uVUh3UEt4L3Awclc5NnlPcTQ1RzAv?=
 =?utf-8?B?ZlliL0diSWlXbXVWTXA3N1NNY1FaaUc4WHR1b1dEd3l3NGZRbVc1Z0U5ak1I?=
 =?utf-8?B?ZDRuSzVkdDZ0bmFMT3VFV3BNTlBFWkd6M1pkL1hWM3MvR3hzakhWTE4wZ2tP?=
 =?utf-8?B?QlJDbnRBTFJvRjdPV2R4R3Jod1orVGxYQ2RDUktUeVVCNVVTS2ExL1pSdnRN?=
 =?utf-8?B?QnZVbDJOWVlYelA4R2x2bWkydzhyb2pYZmlwYWs5UG9sNFF2Y2FQRkN0Unow?=
 =?utf-8?B?a2VsdlU3b3Zid1BDR1c4SFBFMzRFVkk4S3RDYno3TTdMNS81NU00cGRqN0ZJ?=
 =?utf-8?Q?a0UYYa+rTR2MOvktg5zQnkBGAB7nPhos4c7Nw=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cS9QYlVWblJQKy9OTndRUmFWTlU5ZzJTNFp4R1V3R0phRE1uOU54anlGd1F4?=
 =?utf-8?B?eFZybDYweG1hZWNjWVVkWVZIMkxiYW5odEdUWnBPTVpTZHNQTlZ4VTRKUHI5?=
 =?utf-8?B?Tmk4NDcrbXJ4QnVqZTAzS1ZwallaOVBvL3BaUk5NZ3pGQ0hLMFhtYUQ3cU1J?=
 =?utf-8?B?TGVOWlBmWVdGWGNFVkYwNEltcHdzUFpZUmM5b3VQMTBwUUkyRFhGanE4QVcx?=
 =?utf-8?B?alRwWlhvMDQwVGN5R2l2d2FuZk1YbHdqS0w5ZGw1emVMQVpDdEcxZTI1emlK?=
 =?utf-8?B?RDFyamp3ckxTYTNvWk1JY3NqakFpWXJrQkRXTGNsSlQvTC9ERGRyUys2OS9U?=
 =?utf-8?B?OC9CQUMrN04zZ0RGMHpiVHBqRVIyNkpJc1V0WmVSM2J0bTNZTVYzQUU0ckV2?=
 =?utf-8?B?NjN6cDczQjE4WWtNMUZnQjhtbDcyK1ZQRlA3RmhmM2xkTFJmOUdwQkZLWDJP?=
 =?utf-8?B?alA5SmVmam5GaExKQ3M4VlY1R0hOMi9UbTkwMkRmTXBEeHlnZ1JnVWt2Mzk5?=
 =?utf-8?B?QmJESGNwR1R4a2lhbk1lTEx5NWRETE1BUzhvdlFpSFpobklBWUVBeVNseW96?=
 =?utf-8?B?NGlSNWhpYlcxZ3pVWDhkVkhKWFlEbTZwZEdCcWU1MEREWUdaN0U1b3pURWcy?=
 =?utf-8?B?U3JncXovVEZIenp2dDhVZUF2UXp0VFJsbnJSTmtVV2ovMHJaa2RCMVdvWEFH?=
 =?utf-8?B?N1ZUOU9RdEdiS1Jvb2hKTFQvQzU4NGl6OFlYYzh0NXU5RTFEQ2J6WEJUZmls?=
 =?utf-8?B?K0JLZkZwdjI2dU9QanBGMksvMEVjbnEyOURpbHR1S1gyYklZVGNhMVpDZmRx?=
 =?utf-8?B?cHkxemlZcnpmZHJtY2kwV0tobGdnd1d3eklxTk8vR1dNTmQyTFk1bzJ3akJ5?=
 =?utf-8?B?WldTOGU5a2M0dHZuYlliRVlhUUI1WnZZT3pWbFBMSVpUS1A2dCtFc1UrTFZo?=
 =?utf-8?B?Nk16UHlsUXNPWWxXK3l3aHgvdFhvWkNqc2c4WUtibnVwbUNucTRhSXJjVTRa?=
 =?utf-8?B?OG1yNDBncHF2eWVFQnorUXE3Y2FGNE41V0VQVkNveUllMGdWREZQUUdOSDVK?=
 =?utf-8?B?WmNrZG0vMk9KL3NBRnJMa2RPcHRqUG0yK0xxUW95bTVwMjZVUWo0TkI3RitD?=
 =?utf-8?B?aFcwZFRVOGIxbGEyaFd5bHFhaS9KWlhubGVCbTRiSHZEcWdSRDZqY0JpZGFO?=
 =?utf-8?B?WFdnYks4YUhpYitmMUJVWXRzem9ocU84S1ExY2haTXBYNjhKRnhQc0o0bUtx?=
 =?utf-8?B?bDNDajlHQ1N4akp5NEJ4c0F1L0hSbUhoWW9FLzRjdERlZlZLeHpQSVplL001?=
 =?utf-8?B?UnpFNWRJWjR5MG0vc3JJQm0vUXp4SXJGZEkwWTBNWHZmd2NxZmwrcFJYVGxr?=
 =?utf-8?B?SU1wbjlOd2dkS1ZhUGdqV0pYSThsbGlEQ0V5YU9vUDRyQm5MNk5RcUhmY01Y?=
 =?utf-8?B?cGdtU3pVK3NsQW50NDQ1blVZRlE2YklyY0o3Ly9vQTF1eEdsSFVRcUx1K1gr?=
 =?utf-8?B?QzhtU2tyOXBGOTNienNzTjBLdHVieWlFbHZBMG1Yc1ZkK3N4N3dYZFF6aFZ5?=
 =?utf-8?B?N2Q2cDJ5dThPeVdTZ2w5Q1NkMFpTZ3JqNjV5YWlDc21pZzRGNWJGc2ZGNjY2?=
 =?utf-8?B?cDFWamhwdXJiS2dnU1pIblk4MjdsTUdMNmlaNisvUUpEby9nTkMxYkRuQzZj?=
 =?utf-8?B?TnhIUTRqL2lPOFhzdkk3VXRGK1ROMmgxL0JYOWR4RzlxMHg5MDkvV3E0M2xV?=
 =?utf-8?B?NmI1YittRFFnZHBmUHZTVUNRWGJGZjV0RHFhQ2Z4aEx6U3BqRG1qaFphWkFX?=
 =?utf-8?B?Y3E3ekdmT0h5RjdONzZ3ekpSTkNoWlpwTnNCaEpMRFgzOEoraHFtNVZzM09T?=
 =?utf-8?B?TzA2Z1dQeGxTejVaZVJ6enpnTXdES1RCc2M0QVN3NDcvb0ZvdnByQ1FRL2JI?=
 =?utf-8?B?WFZGak9qcml2ZWg5SUZNd3U0TWdpaGU3clllYXFveGxKZ1Q2QXpZYjhmbE13?=
 =?utf-8?B?L2ZqSFdVWDRicWxxVUsyai85aE1jbWx0aHduSmp2RVNaUHFjZ2Vpd1JPRldJ?=
 =?utf-8?B?bDNXVW1MdWJoR2FFTVlPWjdyWDZ5QnlhRFhHNU96NndKWURRTHdYYzRxbzNP?=
 =?utf-8?B?K0dNb0ZGckQ1Nng2d0tENUlaL2pEWTFaQmhWdUEweE1tNXpsNmJ0MHNJMEJr?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CB7335FB67FC44DA3829A519C14EF4D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Z4RgRnq0HgeGwAWpKyQTkr6MGuc4OC2bbtUo8uJVaN+ckv98qQygAsaJNVoSaEjFv3AlmanuiN7ERc+lEvTUuXoKpiehlqamJnWWb1ocjaKjWaBQ2qIRYjG7E+CzqUTb9Nv+mqRi9ngGud3mG1bN2hRJwhe8/qMPZzyRm9vgl2GQd6SinVPQAnjBwHH3W8z5dpKzNhZoVd0iHX4MC92bZkIVG9TSJTMA2LtkRM3Rsn4RDdvYXNZbmry/OLDRkb/zgn/E0tseiRTuFYCUZN6nQA0HyLeYQy8SDT4UAnw5Rn1oxXIwQ3HdMZiogF1pwkvfIXr7cY/r3ubzMXEmnq99/g2lYTVXKjz23Gc8Qa+9isivQCkPbhN+VQ0Xh5gvTHVIdXQPeaVdViOhJyHsB78dAlHPpX+jlkG2lLFsqhbA4ZN+deWRZK68WjVCrl5qzedS2cBptslz6WqaCK/dLwtdJC8irmXAfsnKfkcNRRN/E/GyZ3tCm0KdnRa015zDPxIRePfMqI2aQqmv183HRVy1PtFjEZwzdbAYKxXIGYpqTxhEx4LYZDFqK9z8e7F/bJEkgo6Mv66J4WXMFU/Sw2xhmWA0T1t5iOGD5IrRYBczYTo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cae321-1337-43ab-9fcb-08dc9ac1a6a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 18:06:09.4793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l7GxbVnkrKKHn8jRleBs9XZm03457KKVZyEFlj57hoWzNLpzBuJo9ZmIinW9g2FEYpmISPHM/hnPlngKRrvXew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4564
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_13,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407020132
X-Proofpoint-GUID: 37a7yiz3KgX6XxCkEK7d0k7OpdDBypGR
X-Proofpoint-ORIG-GUID: 37a7yiz3KgX6XxCkEK7d0k7OpdDBypGR

DQoNCj4gT24gSnVsIDIsIDIwMjQsIGF0IDEyOjI44oCvUE0sIE1pa2UgU25pdHplciA8c25pdHpl
ckBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IEhpLA0KPiANCj4gVGhlcmUgc2VlbXMgdG8gYmUg
Y29uc2Vuc3VzIHRoYXQgdGhlc2UgY2hhbmdlcyB3b3J0aHdoaWxlIGFuZA0KPiBleHRlbnNpdmVs
eSBpdGVyYXRlZCBvbi4NCg0KSSBkb24ndCBzZWUgYSBwdWJsaWMgY29uc2Vuc3VzIGFib3V0ICJl
eHRlbnNpdmVseSBpdGVyYXRlZA0Kb24iLiBUaGUgZm9sa3MgeW91IHRhbGsgdG8gcHJpdmF0ZWx5
IG1pZ2h0IGJlbGlldmUgdGhhdCwNCnRob3VnaC4NCg0KDQo+IEknZCB2ZXJ5IG11Y2ggbGlrZSB0
aGVzZSBjaGFuZ2VzIHRvIGxhbmQgdXBzdHJlYW0gYXMtaXMgKHVubGVzcyByZXZpZXcNCj4gdGVh
c2VzIG91dCBzb21lIHNob3ctc3RvcHBlcikuICBUaGVzZSBjaGFuZ2VzIGhhdmUgYmVlbiB0ZXN0
ZWQgZmFpcmx5DQo+IGV4dGVuc2l2ZWx5ICh2aWEgeGZzdGVzdHMpIGF0IHRoaXMgcG9pbnQuDQo+
IA0KPiBDYW4gd2Ugbm93IHBsZWFzZSBwcm92aWRlIGZvcm1hbCByZXZpZXcgdGFncyBhbmQgbWVy
Z2UgdGhlc2UgY2hhbmdlcw0KPiB0aHJvdWdoIHRoZSBORlMgY2xpZW50IHRyZWUgZm9yIDYuMTE/
DQoNCkNvbnRyaWJ1dG9ycyBkb24ndCBnZXQgdG8gZGV0ZXJtaW5lIHRoZSBrZXJuZWwgcmVsZWFz
ZSB3aGVyZQ0KdGhlaXIgY29kZSBsYW5kczsgbWFpbnRhaW5lcnMgbWFrZSB0aGF0IGRlY2lzaW9u
LiBZb3UndmUgc3RhdGVkDQp5b3VyIHByZWZlcmVuY2UsIGFuZCB3ZSBhcmUgdHJ5aW5nIHRvIGFj
Y29tbW9kYXRlLiBCdXQgZnJhbmtseSwNCnRoZSAoc2VydmVyKSBjaGFuZ2VzIGRvbid0IHN0YW5k
IHVwIHRvIGNsb3NlIGluc3BlY3Rpb24geWV0Lg0KDQpPbmUgb2YgdGhlIGNsaWVudCBtYWludGFp
bmVycyBoYXMgaGFkIHllYXJzIHRvIGxpdmUgd2l0aCB0aGlzDQp3b3JrLiBCdXQgdGhlIHNlcnZl
ciBtYWludGFpbmVycyBoYWQgdGhlaXIgZmlyc3QgbG9vayBhdCB0aGlzDQpqdXN0IGEgZmV3IHdl
ZWtzIGFnbywgYW5kIHRoaXMgaXMgbm90IHRoZSBvbmx5IHRoaW5nIGFueSBvZiB1cw0KaGF2ZSBv
biBvdXIgcGxhdGVzIGF0IHRoZSBtb21lbnQuIFNvIHlvdSBuZWVkIHRvIGJlIHBhdGllbnQuDQoN
Cg0KPiBGWUk6DQo+IC0gSSBkbyBub3QgaW50ZW5kIHRvIHJlYmFzZSB0aGlzIHNlcmllcyBvbnRv
cCBvZiBOZWlsQnJvd24ncyBwYXJ0aWFsDQo+ICBleHBsb3JhdGlvbiBvZiBzaW1wbGlmeWluZyBh
d2F5IHRoZSBuZWVkIGZvciBhICJmYWtlIiBzdmNfcnFzdA0KPiAgKG5vYmxlIGdvYWxzIGFuZCBo
YXBweSB0byBoZWxwIHRob3NlIGNoYW5nZXMgbGFuZCB1cHN0cmVhbSBhcyBhbg0KPiAgaW5jcmVt
ZW50YWwgaW1wcm92ZW1lbnQpOg0KPiAgaHR0cHM6Ly9tYXJjLmluZm8vP2w9bGludXgtbmZzJm09
MTcxOTgwMjY5NTI5OTY1Jnc9Mg0KDQpTb3JyeSwgcmViYXNpbmcgaXMgZ29pbmcgdG8gYmUgYSBy
ZXF1aXJlbWVudC4NCg0KQWdhaW4sIGFzIHdpdGggdGhlIGRwcmludGsgc3R1ZmYsIHRoaXMgaXMg
Y29kZSB0aGF0IHdvdWxkIGdldA0KcmV2ZXJ0ZWQgb3IgcmVwbGFjZWQgYXMgc29vbiBhcyB3ZSBt
ZXJnZS4gV2UgZG9uJ3Qga25vd2luZ2x5DQptZXJnZSB0aGF0IGtpbmQgb2YgY29kZTsgd2UgZml4
IGl0IGZpcnN0Lg0KDQpUbyBtYWtlIGl0IG9mZmljaWFsLCBmb3IgdjExIG9mIHRoaXMgc2VyaWVz
Og0KDQogIE5hY2tlZC1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQoN
CkknbGwgYmUgbXVjaCBtb3JlIHJlYWR5IHRvIGNvbnNpZGVyIGFuIEFja2VkLWJ5OiBvbmNlIHRo
ZQ0KImZha2Ugc3ZjX3Jxc3QiIGNvZGUgaGFzIGJlZW4gcmVwbGFjZWQuDQoNCg0KPiAtIEluIGFk
ZGl0aW9uLCB0d2Vha3MgdG8gdXNlIG5mc2RfZmlsZV9hY3F1aXJlX2djKCkgaW5zdGVhZCBvZg0K
PiAgbmZzZF9maWxlX2FjcXVpcmUoKSBhcmVuJ3QgYSBwcmlvcml0eS4NCg0KVGhlIGRpc2N1c3Np
b24gaGFzIG1vdmVkIHdlbGwgYmV5b25kIHRoYXQgbm93Li4uIElJVUMgdGhlDQpwcmVmZXJyZWQg
YXBwcm9hY2ggbWlnaHQgYmUgdG8gaG9sZCB0aGUgZmlsZSBvcGVuIHVudGlsIHRoZQ0KbG9jYWwg
YXBwIGlzIGRvbmUgd2l0aCBpdC4gSG93ZXZlciwgSSdtIHN0aWxsIG5vdCBjb252aW5jZWQNCnRo
ZXJlJ3MgYSBiZW5lZml0IHRvIHVzaW5nIHRoZSBORlNEIGZpbGUgY2FjaGUgdnMuIGEgcGxhaW4N
CmRlbnRyeV9vcGVuKCkuDQoNCk5laWwncyBjbGVhbi11cCBtaWdodCBub3QgbmVlZCBhZGQgYSBu
ZXcgbmZzZF9maWxlX2FjcXVpcmUoKQ0KQVBJIGlmIHdlIGdvIHdpdGggcGxhaW4gZGVudHJ5X29w
ZW4oKS4NCg0KVGhlcmUgYXJlIHN0aWxsIGludGVyZXN0aW5nIGNob2ljZXMgdG8gbWFrZSBoZXJl
IGJlZm9yZSBpdA0KaXMgbWVyZ2VkLCBzbyBJTU8gdGhlIGNob2ljZXMgYXJvdW5kIG5mc2RfZmls
ZV9hY3F1aXJlKCkNCnJlbWFpbiBhIHByaW9yaXR5IGZvciBtZXJnZS1yZWFkaW5lc3MuDQoNCg0K
LS0NCkNodWNrIExldmVyDQoNCg0K

