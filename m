Return-Path: <linux-nfs+bounces-7721-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D869BF1D8
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 16:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2291F23BAC
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 15:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17BF202F87;
	Wed,  6 Nov 2024 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PzCsvmsL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uSGeWNh5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD4716CD29;
	Wed,  6 Nov 2024 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907444; cv=fail; b=XE0ZFvDuzhiNNUjIz4Qblllp+WY9zrwpGnYh3KhpSw8ndKSOUYJGJJ/uZLInwOnGy2YMmz6zg5iNez7ZwcMbdqEyosUhL9vglcY/QWYGuMR3BMU/+KClPDMiV1golUdNDdbfcPYEkPa25LemTLqe61N0MKcV4GjaQTOdtLmwChQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907444; c=relaxed/simple;
	bh=1jAEjHkYzkPurjVkWbNVsK4PxMH84o84BNu1p4dgtV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oTKfV8NAsNX0024ajxCYNEVA1cOuTbJsHukr7WAWG7uEWT2QAQvYTHpmVrl4zP7WvI6CNCz2OWCmjl+GNYZwum/wc5xFMF638nwBO8eflB4wsuRl3CXbBA6CM0Z21bxIIAXocwgdvwF9ZiN5opni2GuAjcLTXiPC5Mi2psglkV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PzCsvmsL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uSGeWNh5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6Ci4RD023406;
	Wed, 6 Nov 2024 15:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1jAEjHkYzkPurjVkWbNVsK4PxMH84o84BNu1p4dgtV0=; b=
	PzCsvmsL2RsJZHEl/piWaXb3KTPX0X/hbwfd11P7BvY7RyI4lAGg4cIDyV3bup/e
	iaaWstMIYAH5n798trb2icBG/Wh4R0p6fby8CilHbEh3P088ASxU+9fJOryqTTRb
	ASCVAZcKfwBkeNZ+8w8n8a3izsjtCSZ011N1nGoNPdoSGemBDRl3UIT4lfG8LPXg
	LgeVTCVtmrivqmIU4Qou31kdYyvw8rAR9/65Hjz9nrxyJQZDPCu9W3k4aUqJSnX0
	nmixypStC9U++XstLSQPXWPWL9FeApM0b/FMJ3sKb2cxpHWVUPdYjamErGbDQ1aO
	nmN3VpUnAYmO7uXzbY49Dw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nagc85k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 15:37:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6ERo3Z031461;
	Wed, 6 Nov 2024 15:37:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah8dfce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 15:37:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfLapOrbJFfPoVIxfYSgjsYTIKxNEaQ6e5Gs1593nvfWb+8qxh+nUlWyPqgNoIuxkRaj8jhItNwdXyNPpZeSv4HciecW9fpv69GMmjv47bgqnE43AB2guZUWvRtPmQV5QrvVlrMxAMYenUs68aoQNt7RSGD6k6fhjTb6CkWuiULAs7e2lqgEfi9rvZdx8mBSK1iwuM9i9fStqyIHnE1kiKcFYlzHAoR2mGvtAuyt8Q46rhdOESeJTfvrU8GWAn1+nxv9dqP0EpY5c+63LN1TPtWJccNiDRhNOPb53Fj4QleGbkL3+FCUMyLsN+wRItyV75cImx1MnvcyAG0/TR8TXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jAEjHkYzkPurjVkWbNVsK4PxMH84o84BNu1p4dgtV0=;
 b=DhGfil/vBYsJGhQd8hoYgwc2juZ5eHhiDr2gY2Zqao2SU//smfLBucw6A/s/24yUhJ5cAn0HisPag5avSy42gBWU2yhDvj61jzih3CbY3wwK6mP1tu0xdrBOOBzv27UIMYLgwKfjt5mwJgBT/Ij1l6nnRvzED3NzESI36eqMG2j09SemTnU/7sx7iJ4WK3BpXfiaTqGBa+CbUht9psjC68F9UyIAG3wrBuFtopEJw/gWlcTM85dPtEd/1CdLF+YYUgC6ZS0R8vpzfZWxTjflSd6/BXh2QLSWX57sM+rJIsOnhXOwEcupDSJrj+8m6NwCW9HODQrM7CBTgPrKhfvkzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jAEjHkYzkPurjVkWbNVsK4PxMH84o84BNu1p4dgtV0=;
 b=uSGeWNh5+k3iG6+1d9NnyzLOj0EVVj6YtP2X8U4JJIGDVXbx97lNd+Vo3G8NV1UWf+GwOsNciYu59bLF90Hx/VMgKrXqa3DInA06tteoPzYqO5LO22th1rcb6d4aw+Au+a+qK8OuE4pGvMO8CVZJXC0Bdx7Enx1olJj7fBZVmIQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH4PR10MB8073.namprd10.prod.outlook.com (2603:10b6:610:23a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 15:37:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.031; Wed, 6 Nov 2024
 15:37:15 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Sebastian Feld <sebastian.n.feld@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] nfsd: allow the use of multiple backchannel slots
Thread-Topic: [PATCH v3 0/2] nfsd: allow the use of multiple backchannel slots
Thread-Index: AQHbKtrbfxOz5OB8fEq1bBo3CDaH47KqaAaAgAAFuQA=
Date: Wed, 6 Nov 2024 15:37:15 +0000
Message-ID: <E97077C4-A730-4755-B637-3EF61CAB44B8@oracle.com>
References: <20241030-bcwide-v3-0-c2df49a26c45@kernel.org>
 <CAHnbEGJWtRgPHSRMqEVDgRhvYHeqcHEKxeY=B2mD3W_YjR6zpA@mail.gmail.com>
In-Reply-To:
 <CAHnbEGJWtRgPHSRMqEVDgRhvYHeqcHEKxeY=B2mD3W_YjR6zpA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH4PR10MB8073:EE_
x-ms-office365-filtering-correlation-id: dc30e3eb-4542-4c6a-6f2b-08dcfe78e3f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?alNUOGVDMjh1RHdIQ2NDWHlXaVUxUU4ydzV3V0ZJYmRiYVBVTUJiNDdmWnJB?=
 =?utf-8?B?aTdmRHJYY2RLeTU3RXliYWE3NzEzcVpVQ3BpTHNGQjExbnlkclhhNFEyYXI2?=
 =?utf-8?B?WmVaNTVUL2pjTXZyRDlrV1haaFpaZHRMbjNjazRRWG9rZGJMRVB1QzFYeHpX?=
 =?utf-8?B?Y0pGTm8wcERiYlB3VEdHcVFjOC9HWVNONkIra2J0YmlzK1BZb3V6NC8va0s0?=
 =?utf-8?B?a0ZHbU54OVdkSFkza1p0TnUxelYvTEZSZVBGaUI5d2pZMElPWGFUWUVTUHAr?=
 =?utf-8?B?eHpvOFFVVXpONW1VbzRuVGxRQWRWbEdPZWNBUU9KLzkzV1dqazNLY3BWN3By?=
 =?utf-8?B?eTgzZGFCVzA1b0FUQk5KSjFMUGJEQjMzUjUzVXVsaEw2bktlblhrNWFQMDFp?=
 =?utf-8?B?Y1R4VWNwZmpiWGc1UXdpQUpuMEt0Mlg3QzM4dVMxRkEweU9YSVFpVndSZGJ5?=
 =?utf-8?B?MU5pK0JlY1ZRZVZ4NUU3QW5TcTNqbXM0U1R2NmJIWkhnYnVXbXhONjNZUThh?=
 =?utf-8?B?NzhwS2xxOGUxMnNxWGdUZEh5enMybURvektzT0V3YUNYMk9KcjJka0JHN0xs?=
 =?utf-8?B?dnFqbEFtOGpzcVVXMUoyaGRDZit6YWw3cnFvQ0hBVTBFZWpkRTF3NHhaK0Fy?=
 =?utf-8?B?R3h6VVppQk91VFk2WlJ3a3FPeWdra2ZCTE80L3dHZmxvc1Z1VXZYUFlUd2lx?=
 =?utf-8?B?VGpqZDF4SUVLSU9VNFU2Mzdvbi9DaUFQbHd6T055N0p1ZHdlMlFtUkt3QzdP?=
 =?utf-8?B?dW9LWndMQ05vN2dTU2hYR0ZRVjZldGRtV3Y0SElBSlY5S0tzbjFpOGZzczlW?=
 =?utf-8?B?TGtkRnd3ZXBNTUpOc1FDeXBnckoyczRBZzBjb3ptRU9EeXRXbk43QUplLzhO?=
 =?utf-8?B?M0xKUG5iOFNqY0tRWkRoVmdOUkFvN2VGNG5ZN3NTeDhON1htMm1aUHRWeVRR?=
 =?utf-8?B?ems4Zjd1aXgyMnJ6T2VBdDdubVY5M2dveGZUcTYyL2dHU0tqc0wxa2tsVi9F?=
 =?utf-8?B?WCtjY0ZXVGhjeU10akt2VWRla05ZZzlaWExMSGx6aUtRRU1VRXdyZmNSWGdB?=
 =?utf-8?B?SkhzWCsybFRZRTBkU1JqTURZSTJuUVRVUmQ5Rng1QlhWZ3gzcDB1a2hqeVgz?=
 =?utf-8?B?NmpWWjNodVdmTmNwMmgvN0tLUVRTOXA5Z290Qm5UeEhLZWJrN1g1ZmdkMHFK?=
 =?utf-8?B?UTRnVDJtTERya3Nkb1dyOXhBazd5bGVxQ0lrMkdPb0VZTC9GRWVkM3F4Ync0?=
 =?utf-8?B?MWUzSStuMnBNY1RJM1U5dHVYQ3VXMnl4SDF0c3hvZFJLR1R2R3NKbWU4RjRO?=
 =?utf-8?B?b05Ka2g4UVpiUm1BK2Q2bTVwdU5lKzIweVRTaFRvZEM5Vkx4cnpKaVM0Uk53?=
 =?utf-8?B?aDgvQVdZZVMwdG1UcThKS2JQWEVBMDllY1dNdUJyUWJEVGJuSFMyaVgwdVp4?=
 =?utf-8?B?SDJWT3pvR3hXSWc1aTBVblpEaEsxeCtJeTZhWGVNQUdRcUZlcU1RbVg0Ui9q?=
 =?utf-8?B?QmZ5TStpeVA4bVpJNE8wYWhGY1FnNkFqSC9WbytLKzc1TGF0M2NFVi90dmJW?=
 =?utf-8?B?NjljTU80OWdvZzl5eFRjVDNoVlhUbGxWRDRhRVU0R21RRjlLaEl1c3RleVFK?=
 =?utf-8?B?eEZudWh0Ui9ZcW1sQm9KRGRtQ01SVFhJaTZSSURnNTJYTUljaW1iNEFVcXFz?=
 =?utf-8?B?bmkvTnEwUDN6cldvUGY1UTJacTF0OUZZR0lLT0hwNFBzVUVGL1lOKzZrZEZG?=
 =?utf-8?B?emx6TDE4QThZYnJtOTBDaXBNN0hXZ2c3dkIxeDkwZ3k5RFlSbW5CLy8rZVJ4?=
 =?utf-8?B?MTk2T29IWFlDVUsxNm45Z0dQaVFuM0RnSVVtNHBaWmVXVkxsaTRkR2JlbmFT?=
 =?utf-8?Q?V7SgveCchfeip?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2lhM0xSQjBzd1pqeTcyUFVQNnFZendPMjhhb2YvWlc0UUkrWWQ1YXY0OWtm?=
 =?utf-8?B?MnQ4Z3NDVmhOMFRIZjdXSCs2WkhTZWVIT3ZOcWVad29FMGpRVkRoa0xydEkz?=
 =?utf-8?B?d0lEU3NKZnQza3ZvRFR2YkovcVB4dFFQNjNJS3loWTdEelR1RVBNRlEyekVZ?=
 =?utf-8?B?dlE4MDZrVklaazZGTGdidUNkYTVYc0FkWlV0Z0NiSGhhb2x6ck5TRmQvZkdq?=
 =?utf-8?B?TllDc3pGR24xNWtXLy9vNHVkVXdMRyt4QTJSMGwwc2JLcG5DS1JLUHUxN0xJ?=
 =?utf-8?B?VHYxS1Z0NU1DcUhyakJYbnhyY2gwbVQzU2lsaEhJNStxZ0JPRkJMeTE5Zm9E?=
 =?utf-8?B?emlGd04zcTJBdVFLRTNyaUR1QXYvc1YyamNreGFVazA5RTFvNkVoTVgxcVhP?=
 =?utf-8?B?NDJERkJ4Tmx3ZmhSWkZQcVVFMStoQldBZHVENHJJb2dhSkcrd2Q0NXdGTzdi?=
 =?utf-8?B?WC9uUU56UXYxR3NzQ29FVFJDY3FLd21reWlGd0tNVDdNQUhJVERHYjFwbGZS?=
 =?utf-8?B?Q0VaUTZoWloxWlhRTFFRZXlvSFVzVWtlU24vVGswbnRhVGY5MEpvRzUyOHNu?=
 =?utf-8?B?eWcxNnFjQUw5b1RPaW5vbm5mdkpLQ05halVaSUtqYWJUMmc4ZXc1eDJHVHRh?=
 =?utf-8?B?L2hPdVNEaUZhMjVVU05zK0VFZko1QzVpSno5NERuMUlpVzBTSnBGV29TRGNt?=
 =?utf-8?B?S0cybitKdTNsVVVBZUFKOTBRdXBYbzB3YnRvcXJzS0JoYVY3YzN0ME53OTB5?=
 =?utf-8?B?TlFRWlhRb0VxWHlTRzhkdnVQVDRWbGRTYUh5VWFjVXFTZlQxbm9Yd3dNaW40?=
 =?utf-8?B?RGhuTGFqTU5sSUo2T1U3YXYzZm15RGNBdThQcWdDNTV3V2pHbjVJUW8wbHg1?=
 =?utf-8?B?TXdCNzNJV0s1WS9hVVNVMFFVTU56OXZjWGY5d29ER1o1N2VNM2czK3Uvc2dl?=
 =?utf-8?B?TUlvTkN5b2pHMVdodVorWlR3ZFFNSkRkaHBIOUtuVXpoWnFscXFJVmFnb2V0?=
 =?utf-8?B?SE54b0lCK1pSS1pNSlpnYUhXaWtYTjdYVFUxVmQxSTRHTXovelVlY1NvcGl1?=
 =?utf-8?B?STdWN1hiQXZFVW5WeWRNMWNQM3ZGb2g3cGYzUGV4b1p5SkRlK3VPOUYxOEtQ?=
 =?utf-8?B?TytaTzljencxMVBnSEJBVGplaUh3VGFCMmM1Ylg5ZGpiMkNuUVo5Q1ZnNEhU?=
 =?utf-8?B?eStqS3N5UjBGSS9JY21IS2NBNG5GRGsvYkd4RHNhbGtOVVNlandUSnFSZDl1?=
 =?utf-8?B?eFJJQjNsZ1FxaUJGdmZiM0pVM0ZIa0hZTEFxVWRhNWlmM3VUVjAxVVZ1MG1B?=
 =?utf-8?B?Y1l5RnQrdmhLdlFSVzJzYXNodStBMENzNnRvWGQ2YnNXVnJjM2VmNzlsUXR5?=
 =?utf-8?B?YmpQSDBoMnA2SXJxSGNmNnFYZXZxbEp5K2NJV2twczJyeDRTbS9CL3NzYjJm?=
 =?utf-8?B?dkdyanA5NWl0bmFnNENlMzA1QjB1TXVReWlDMXBTcHowNyt0STFnWkllNnVo?=
 =?utf-8?B?azFDYzJBeFJhWmhuRGgzZTlUdit6TW9kWUdicC9BeTZXV21iWGtESlhKdU1I?=
 =?utf-8?B?VklyNERkejVyNHBsZnVHd1dwWnMwd1krQnduOHZ5V05CU0x2QS9yUzR4MjVF?=
 =?utf-8?B?ZGN6TWZpcUhIRVFGNE1kUzhqUm9XbXlwdkUrN0tybHJSRkNCWGtnRk5nUHEy?=
 =?utf-8?B?WXBDTGlHaGFaUkUwcWpRd0VKNDBlekoxanIxbnNIajV0dXQ2Q0lFWjVwM3lC?=
 =?utf-8?B?L2M0eU9uWXMwTWU1dnJwMU5VQXo1bjJoMlN5bExKYTdVTk15bnpEL1dBdXRT?=
 =?utf-8?B?N3JaRktzWlk3anpLWFlGditYVEdtSGxNNlFseUk2WVllSUNKSWd2UTdGUW9t?=
 =?utf-8?B?emxLWmd4VFIrSWQwRlRWRFdmdnpYeVF5cWxseHhFdkloOE93WVNHR3BMRE5Q?=
 =?utf-8?B?c1hyRVQvaS84U0pqRVdGbUVQQWMrQ21iYkpqZ3oyQ3YyNENZZDFZbVBzNHE5?=
 =?utf-8?B?S3dZbDFISHNXTVVZMXRqdHE0U0dpWkIxdkZoeVNJNElzR0grR3FWalBRZE8y?=
 =?utf-8?B?V0JENWFuTVc3L3Z6Q3ByNWdnYTlPRzJ6Sy92bU1oVDBxQ2hVVmhjRzMvMXFo?=
 =?utf-8?B?SWxyTEFlRDdXU1BqMW53Z0l3Y3hjM1hWWStqQkhSMTFxZWx3RmFlYUYxTVND?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43BE06386D3E4740B655972D3A7D2571@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QG0R9GhE0FU7rMy9/tV8e8g/YoGmYdi8vo9M5FJUc8kWzwjTci8ZY3uq/j2SSO27eFWn/QYEr77I8bc8de9MpKpLzmcIcp6uzCD1g3MLjtHxJvwsklE0dOI5FGxK2J7JNiF4SdgwPbJ8UL0e04W0BMO5TbrP+iaWzyJidSHL3V/hVt9VhnJOh9VpRPC2nY2qpuDihLCzhuik/CHU5kuDBQGAji8DAKx4KARG8ZOD6pFNYPgoaa92T45+uyPQO/3mWB29zA9RqA+YAxd1xw06Ytr7c/8uWxpCo22vBLHHZY2zCgGbf2mXCTeGsP3ElbsEjm/HfI/rY341OWuU1FCIHs0Vo8FLIBypeVYhLDLxNMEbDILYF46IOz5jCrh0Ik/JEHvPFaTS+b408V3uMl5JOie67eO7U1X+FrfrU9X4tVbK/MHEWwMwpRwG09Wx0DQz93PdOSl8fWyZGo5ZBKVcetEJVTKF4gxNwbnhv1fao0tKwjtZZiGKvjA9HKrIAsyZcHd9Y28xtafvEI17HBdUGvcDU4Uaoeu7KLnY7dy4Todr0veXXev3LYQgXKuPg0aSGjG+j+JxoIjRxXoVularTio/MYuKv1gFIP7jLogNdNU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc30e3eb-4542-4c6a-6f2b-08dcfe78e3f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 15:37:15.3682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l6K8uhmccQukfILn3+Cp1cASh7SoUz0vXdf4448VthTYQuUQ8xdDUzU0feAeAR2azXClVuKVugoNKnPLEIHfMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8073
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_09,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411060121
X-Proofpoint-ORIG-GUID: GQB4UCQUlHmE7HDYY6MJeRGyashsjwDP
X-Proofpoint-GUID: GQB4UCQUlHmE7HDYY6MJeRGyashsjwDP

DQoNCj4gT24gTm92IDYsIDIwMjQsIGF0IDEwOjE24oCvQU0sIFNlYmFzdGlhbiBGZWxkIDxzZWJh
c3RpYW4ubi5mZWxkQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIE9jdCAzMCwgMjAy
NCBhdCAzOjUw4oCvUE0gSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4gd3JvdGU6DQo+
PiANCj4+IEEgZmV3IG1vcmUgbWlub3IgdXBkYXRlcyB0byB0aGUgc2V0IHRvIGZpeCBzb21lIHNt
YWxsLWlzaCBidWdzLCBhbmQgZG8gYQ0KPj4gYml0IG9mIGNsZWFudXAuIFRoaXMgc2VlbXMgdG8g
dGVzdCBPSyBmb3IgbWUgc28gZmFyLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBKZWZmIExheXRv
biA8amxheXRvbkBrZXJuZWwub3JnPg0KPj4gLS0tDQo+PiBDaGFuZ2VzIGluIHYzOg0KPj4gLSBh
ZGQgcGF0Y2ggdG8gY29udmVydCBzZV9mbGFncyB0byBzaW5nbGUgc2VfZGVhZCBib29sDQo+PiAt
IGZpeCBvZmYtYnktb25lIGJ1ZyBpbiBoYW5kbGluZyBvZiBORlNEX0JDX1NMT1RfVEFCTEVfTUFY
DQo+PiAtIGRvbid0IHJlamVjdCB0YXJnZXQgaGlnaGVzdCBzbG90IHZhbHVlIG9mIDANCj4+IC0g
TGluayB0byB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MTAyOS1iY3dpZGUtdjIt
MS1lOTAxMGI2ZWY1NWRAa2VybmVsLm9yZw0KPj4gDQo+PiBDaGFuZ2VzIGluIHYyOg0KPj4gLSB0
YWtlIGNsX2xvY2sgd2hlbiBmZXRjaGluZyBmaWVsZHMgZnJvbSBzZXNzaW9uIHRvIGJlIGVuY29k
ZWQNCj4+IC0gdXNlIGZscygpIGluc3RlYWQgb2YgYmVzcG9rZSBoaWdoZXN0X3Vuc2V0X2luZGV4
KCkNCj4+IC0gcmVuYW1lIHZhcmlhYmxlcyBpbiBzZXZlcmFsIGZ1bmN0aW9ucyB3aXRoIG1vcmUg
ZGVzY3JpcHRpdmUgbmFtZXMNCj4+IC0gY2xhbXAgbGltaXQgb2YgZm9yIGxvb3AgaW4gdXBkYXRl
X2NiX3Nsb3RfdGFibGUoKQ0KPj4gLSByZS1hZGQgbWlzc2luZyBycGNfd2FrZV91cF9xdWV1ZWRf
dGFzaygpIGNhbGwNCj4+IC0gZml4IHNsb3RpZCBjaGVjayBpbiBkZWNvZGVfY2Jfc2VxdWVuY2U0
cmVzb2soKQ0KPj4gLSBhZGQgbmV3IHBlci1zZXNzaW9uIHNwaW5sb2NrDQo+PiANCj4gDQo+IFdo
YXQgZG9lcyBhIE5GU3Y0LjEgY2xpZW50IG5lZWQgdG8gZG8gdG8gYmUgY29tcGF0aWJsZSB3aXRo
IHRoaXMgY2hhbmdlPw0KDQpIaSBTZWJhc3RpYW4gLQ0KDQpORlNEIHdpbGwgY29udGludWUgdG8g
dXNlIDEgc2xvdCBpZiB0aGF0J3MgYWxsIHRoZSBjbGllbnQgY2FuDQpoYW5kbGUuIFRoaXMgaXMg
bmVnb3RpYXRlZCBieSB0aGUgQ1JFQVRFX1NFU1NJT04gb3BlcmF0aW9uLg0KDQpUaGlzIGlzIHBh
cnQgb2YgdGhlIE5GU3Y0LjEgcHJvdG9jb2wgYXMgc3BlY2lmaWVkIGluIFJGQyA4ODgxLg0KSWYg
dGhlIGNsaWVudCBjb21wbGllcyB3aXRoIHRoYXQgc3BlYywgdGhlIG9ubHkgdGhpbmcgdGhhdA0K
c3RhbmRzIGluIHRoZSB3YXkgb2YgY29tcGF0aWJpbGl0eSBpcyBpbXBsZW1lbnRhdGlvbiBidWdz
Lg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

