Return-Path: <linux-nfs+bounces-4598-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2A09264C8
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 17:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F76281355
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 15:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C537E17625D;
	Wed,  3 Jul 2024 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HICHWtxC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qtojs3BW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349771607A3
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720020408; cv=fail; b=Z5DIoCcY1zzYH//ByovrVmAB7Pqbq1RPhq6jn+SNPqEtfv7fbR7MbKZ7VOqSnCVn6Jl17MRZc9huKgmPjyeDra2FpvYfQBZfWj3XWbk16GokoFlVupJKwUHyLKfL2RzjRf0y13Ejis9zW0J4f6numOMR5+uVluwQCw694KMpvd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720020408; c=relaxed/simple;
	bh=Cd+A8QuRUvyl8ZO+J4maLmtjfNSpMBg5gDTCLK3B6oo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VFMxnEPDGLLuPKO2ktpkuLr8AiOsKrGBNOpvfqHllDktxJHpf/YaQsePtHAmOXYjWbUzuBHnod5ELcNoVDSMuRq3KM57l08E517ptGot3N+xmbuPZms5FhC7kmxWa911znXoQRT9zvT/RVmfyGTKFKFyApADjy1kZVdSHyUA7h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HICHWtxC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qtojs3BW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463FMSx8007895;
	Wed, 3 Jul 2024 15:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=Cd+A8QuRUvyl8ZO+J4maLmtjfNSpMBg5gDTCLK3B6
	oo=; b=HICHWtxCO5pOs8vp/9Y3WTA5ODkIuAwrFfi9tPng4SCE7jENEJf1MxzHO
	pcqsbJPpVQ47IH5dcITT5Gnh+FkV5CJaYLVs4Lw0CANP+Hb7V/UZc4cpZrUhZbUv
	SGuz+3xwf+tIXtIiKAlVkwkS5ESfPHh9YxfR6EhvAPG1t9cEBhakiHutFhlqfyaj
	2EHajiGHnrrBis7Mckw3QpeW1NNq+Z9vfSXE4xSNJ6ldBlXsBCYoMAclBARu3kUF
	Hp2wdC4T+uJPiXquprkiOK0Lse6Xr10+tNKCqWkbQZ6iPQt2EF910sKt8jsuaEgG
	xOqHljCi2iVK0VB2Tw6Nc+LDZE6Ag==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402attgfjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 15:26:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 463F2U4p010980;
	Wed, 3 Jul 2024 15:26:34 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q9c9m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 15:26:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWEzzsbYEf67lTqpNhS7/CRLVbj2CkEvU05ASiRPqFEVs+2ZhpF6qbmxwMtTv/lmqgYlI6qbChIUEGjjwC7XziIedGU83pFnkZu6OCrDeNjlSbmgeV4Gdv78tZR5dQd0udB+1hI6WYoMghk4JUrGtgqXgSnq1hdXWMbN+Z0xvZyTt0bU2JT/5ypG46iiGfsgbFayp5MJ0g2yH9H0Voh/ZVdkI8ZeMmVW36wfJfISzTvburwctrm10/chKvXPJkrn8Xp1wQM7q9g6blkWlQ3WaLKHC+M7WMUChgVHL+f+zGJ4T01I0Q+kM4LS60oLCF0JcsTY53LN/v+EPiDrkUIYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cd+A8QuRUvyl8ZO+J4maLmtjfNSpMBg5gDTCLK3B6oo=;
 b=lDCxlvPjsEa2nS7JhoKUgidHCYDJLu33v+PhiDhPgzfqlIYWEtM/NQFHj4GybHEJNE1ZL1hXJyBZC74ifdpSDKPIKk94jjmBHJ2vHv1N1WDsZZNN1MGjZk3HJ2ugITU2BIQoSAqT2KuENenrqO5dZo1vzzOt87PdoLIWQAQZj2YNhw9gIlExOrNtIYAxBjNW+jLvHNRNTrae09kxToXnYs4IyQWkzlKK4aDaYvrEsZxhoNMf0ea8JIgQjXIfIR/QTZZgbM6da3PGxAHRsqu11rqBhjqlajGZgwofYu3CLdCjdv49naBY977BoN8utIogaC7HnbldRgQxtFIciqyx2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cd+A8QuRUvyl8ZO+J4maLmtjfNSpMBg5gDTCLK3B6oo=;
 b=Qtojs3BWRtrE6iVuSk021yvdZBbByD4KC71J76V8KOKqc5iVq3A/G/92g6Z2WDa6tGFFTjh9Oy6bVuciAUdpiLbEQElgXHP1bVbKAdYt5ffpbIE1zvKdc7Oq0GGLJJL7ZZP7aUeVGRUOhU38b9wifHVCEy/GZXghWPtUBY4MGdQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB6429.namprd10.prod.outlook.com (2603:10b6:a03:486::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 15:26:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 15:26:30 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
CC: Christoph Hellwig <hch@infradead.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Anna Schumaker
	<anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, Neil Brown
	<neilb@suse.de>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Thread-Topic: [PATCH v11 00/20] nfs/nfsd: add support for localio
Thread-Index: AQHazJzmgcDeJH7XRUCD8QiVhiofhbHju8AAgAC4HQCAAD+aAIAAbgOA
Date: Wed, 3 Jul 2024 15:26:30 +0000
Message-ID: <665DF70C-9D13-491E-872B-FE859A1B8694@oracle.com>
References: <20240702162831.91604-1-snitzer@kernel.org>
 <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>
 <ZoTb-OiUB5z4N8Jy@infradead.org> <ZoURUoz1ZBTZ2sr_@kernel.org>
In-Reply-To: <ZoURUoz1ZBTZ2sr_@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB6429:EE_
x-ms-office365-filtering-correlation-id: 2c1d236e-9967-49aa-b2d6-08dc9b748366
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cDRGNTdOUk91VThDaVEyNFZXTWJKSDhId0U2dnk5YWJna0Nqb1Vsc2dOODl3?=
 =?utf-8?B?RVJnWkJoL2NybFF6bDdJUnVUaWZkTGc3YXB1QjNQdWY0eERPOTVueUcxTHZT?=
 =?utf-8?B?aVp1dnRXbFdhWktyT0x4ajhQYUZrL1FtaHdxQmlMWTlvdVFBS0ZDTGRjSURw?=
 =?utf-8?B?RzVDbGNWemIxazdrRVhtRmxudFBiOFRiVmMzUzVnb2d4c0NSQWhkMGFDQ2hC?=
 =?utf-8?B?cjJReGtPWDJVNXYxNmczK0pGRFQ4S2t2ZTVyQ01pTGxVTE5aNlJMRDlCRzM3?=
 =?utf-8?B?cXgzajBpaU9mN2liMi83cEtRK1g2em5qL0FjL1pHd3EwVFF6L2gvazQ3MDR2?=
 =?utf-8?B?Z3RjNmxidTZJdXFjNW9jOUpRSVF5M1BsY1owd0pCcUxwWWVDYjBYbWt2clZ4?=
 =?utf-8?B?dUp3SjY4ZXlpZzVtaFVFbms2SnVod1FBV2pNSWFsRndoTDlWc0xyZ04xcWto?=
 =?utf-8?B?SWVHQlNoeE9FR3VodWd2RGdIcmZYb010SXJLZ29FOE03TzJCWExKaDNhYmk1?=
 =?utf-8?B?YzJnL2F4VG5yc3JremM1SjJjblo2aDRUYm9vODBpYlg2akdvQW9rTndIUVZa?=
 =?utf-8?B?U1YvRjNRQ0QzYjZqSnpxWXlZYlN3M3Q2WUpxTzFPamZQUEtzeTFRU3NFWE5F?=
 =?utf-8?B?R2xZQnQ5VXdiUU03cmdVeGMwNjNldE1wdXRYa2wxaXA1M0RZMnVkbFFaeDRa?=
 =?utf-8?B?Nm5ROE9PN01QR1RPYkRTdDBZU3o2UHJCeUErTFo0SkxZQ2V6dkdacE5HVTBD?=
 =?utf-8?B?cVY5RFk5bmwrY05aZTdwaXVWcU5saHZBellveXRuYnF3aDZPb2R3NEtGaGdP?=
 =?utf-8?B?UjVHUkNpYTJIejhVZStjRDIrRENzSi9MWUJVYVFSMkNiT2lldzJuZEVNdGZs?=
 =?utf-8?B?dExoeXExWUd2RkJFajNjbXBuOE80Ky9vVjJaV3V1UW5lZndLa0xJQ2pub1dx?=
 =?utf-8?B?T0JwdG12aUlwc0hEQ0h0Rk1RNXg3L29NOWRuVGExUDFRclJaclhXNmpHdm5U?=
 =?utf-8?B?K1ZCUjJPc01mcGladnVHTUtEV3ZlSGRISmNSOGFjZVVNZWxoMVp6TDBCNGd4?=
 =?utf-8?B?dGF4SE4vM3ZlcXo4bWxyNjYwVE1ua2FiSmtUMlNwSTl1RU11VFA2VEY4Q0Rk?=
 =?utf-8?B?dzUzeml5Ni8rYmExaGFVMDE1Z2lDNURYekZtQnlJMUlPV2RMUkJsV05FRk53?=
 =?utf-8?B?d096VW5jQ0ZuWkdmVGJVekVUa3BvSkZTRWtod1dTVkpEeFZtVTdPM2FOS1hw?=
 =?utf-8?B?cWRPZXhNejJyQm9QNXdlZkF1bXdyZU8yQUhIWHA3Mm5MOG0wdXp1aE83NWFa?=
 =?utf-8?B?TVJkbi8xQ1kwSHRKY2lTRnhnY3ZLMTY4V0FnOWtsRkoxNUJrSUw4N1lkN0RN?=
 =?utf-8?B?YUxWNTREZFdlWldYV3N1OUxJcURWS0dFcWo4OHdzQ0grMzVJdkxQSVRCQ1hq?=
 =?utf-8?B?WXpVR0txY0NRUUFydHdha3liRGpZQlNDT3NDdU0zZnQxTUhYL2JhOVZxbkZz?=
 =?utf-8?B?ZitQeEVnUkYyaXllQUhWT0cyUlJwV1hNSGVrVndhUlF1Q2w0eVExUTJmb0pO?=
 =?utf-8?B?cWFySVJscDliK0YzY0pyYmJEbFFZcksrZ3U2RnUyd1drOEFrSlo1U1BFaklm?=
 =?utf-8?B?STVUc1U2d3Z5dmFIYjhDQ3VHdGtacmtuRnNobCt0NmtJcG83cXlJeVFCUXJs?=
 =?utf-8?B?YkRtK01ycUJDbjhpbTJLL0NXbm5uUEFxVlJsNllpdTZRSE5BMi9Dbkw1WmJy?=
 =?utf-8?B?OGtyR3d6RmEyam0zbVlKaW9nWWJwK0xqVi9NQ2RpeVhYbHViNjE2YVo3aHNK?=
 =?utf-8?Q?nBTzfUA/CSPJcqASz9u4IgbB+324Qn0tClnJg=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Qm9HQlZpUGxyL3M1M1MwUGZlOG1MamdYQktlZENaTTlUMGF2Y010c0FJTWpG?=
 =?utf-8?B?MHBjcDhDWTIzNEFwK0hSSFBkM3hkdWJwU0pDWDcyRWJCZHhHYVBTYUdxNGFL?=
 =?utf-8?B?T0N6ZHFwRU92TisxUUdNUnlGM0NrSlRiY2ZnMnNJTkUwRFZlWjJCdEJXU1F4?=
 =?utf-8?B?RTduVlZsRjlkdG9CdHRvSlJmaUs3MllZVG9qK1dubmRaWWI5d1FtQUtkRXQz?=
 =?utf-8?B?Q1ZPWGZ4bTI0QjM0M0pldEZlbS9zQkdOaU5wLzIrdnJFVE44RnJoWGtGc1A2?=
 =?utf-8?B?V3VnRFpTUkZQSWNuUzJvbDdKYlFhOUM1eE8zSWNkNE9Cam4vVzV0aGdPaUtl?=
 =?utf-8?B?dERJai9mWGVrU1RzRHVsL2U3SExhQ0huQjg2b3BFZlJLQUNYODErb2JRYTN4?=
 =?utf-8?B?SzNSUXFaTWNZQngxVVh2cnBGUXkyVURhc213RjlaKzFLUDRKM0dwZmhUTE1O?=
 =?utf-8?B?ajl6dmFyRll5T1JaVHdsTldyS0tGampzcGFDQWJ0ZUtTZi9YQkthNEtHNzVX?=
 =?utf-8?B?SktVZnlYS0JNRVhZbjRUL0o0WncxR2dPaWx5THZlN2RTM0lVSTBJZzcvNlFq?=
 =?utf-8?B?ZGRoaisxUVNvWThGZTdTRWNEYWZrSG5YcGR0aEJpQWYwaVJLRE9jYUxOVmpY?=
 =?utf-8?B?LzA4K3BTaVBETU9tbjZFRzNqdktFL1FnTFZ3b21ZSGpJSWVlSGdEc3hoM0VK?=
 =?utf-8?B?bWRHOUtZaDhRbk5yQWFLZ2R5N093N0w5SEdSa1lJMGQrVHFzZ2UrSWFvamIw?=
 =?utf-8?B?dFJJYktETk5FbndMZ0YvdUxRSHVRZ0hiSWhKRkNjZjdFd2ZtVTJZT3NpZndq?=
 =?utf-8?B?RjErbGRINjJNWHFSbHZiOVdTa2g5aUUxMTBvWnJkMHYxYTZIS0RHUjVDc2kz?=
 =?utf-8?B?YUtnVDYveGVYWmJ5Ty9GQTVNRVgwZWJhMm56cjFWRE9JVDR6ZFpkb08vN3Ni?=
 =?utf-8?B?ekR3SzJOdkdHazFyRmpnWnNCZEpGUkh5bEJSSjBpN3pPVW1Rc09UWjNYc3Qz?=
 =?utf-8?B?b1FxN2tCeEZsazlqYUdNdnRYN3ZzK1RhSFQ1bisxNEoxSnpqeUsrZjNKNzhL?=
 =?utf-8?B?d0ZCdlhSakxoczVvZG1oRTQwbmNUWWkvMGxZYzczVzFtUVlKWUIxbkVDY2VL?=
 =?utf-8?B?eVRKWnZSVVBNTlNoRDZFVUVYRllVaG1qc25PQ2Q4VHVmZWdGZmFINjFGdDBW?=
 =?utf-8?B?OEdsek42Nzhla2RoMG5FdTExU0J4R2Y2SFdkVERkbjJXUC9uTjhib0FDcUt3?=
 =?utf-8?B?QUxod3BHQUd3bzFqb05vWmhvUDJSbk5rdFlFU1BZOFlORjBabnR2a0dtQXh3?=
 =?utf-8?B?Z0EwUHpmaGVMVTFJZ0VMTzlRU3IvbjFPZFRnVGE4cTY3TG9pVENoeXBDYlRY?=
 =?utf-8?B?NVZtdGFBZ2ZHeVEzcVJwQUNmWmRtZnRzOXZlR1I1azdnMm91MDNJOS9rdE9M?=
 =?utf-8?B?OEx2dDlnQ2h0dFdCdzlMRTduSWczeXZRZ2lsU3FYRG9sd0JIcDB1Y09xR251?=
 =?utf-8?B?bXFCZEFoS3R5RTFGNTB2RDhxT0V5empDZFZYNEYyZ1I5ZlE1UVFzQk91Z0Ew?=
 =?utf-8?B?Mjh2bFM4OWJMbnlsS2MyQTNUSzFvN2lhYksyM2RiY2lSb3VHL3ZidDVyRTkv?=
 =?utf-8?B?STNIbnlMZ3pmZTE2T3JNN21rVnVaQ2cwb0dncUIrL2xTaElsaU9IRDlONHAv?=
 =?utf-8?B?MVJlVEEzMlQ2Slg3UElIejFodWhEdWZOeWlNTU5UTGNCZE96Zi8xOU9yUmFM?=
 =?utf-8?B?L0E3ZmJIc3hOMHIwaHMyZTFNUENBZUhieTZXb0x5aTRDR3NrRHFTL2xNYmxK?=
 =?utf-8?B?SlNUMk56T0FHRzdXejhCU0E5WUtDUmFFQmZraTRQRzRhOE82bG9rK05tNUg4?=
 =?utf-8?B?SHA1UEpya21BWjNmYVVsM3BKRnNRK2dJVmdJZUwzYU1GM2ljVTV4OGx6aE1k?=
 =?utf-8?B?ck9QU2lLNG9TZkthM1FQWkZ4R3U4M0lreldiM3Y2TnN0ZWpRV3RJRHBhKy9i?=
 =?utf-8?B?dGlrcm51L0FZZHNORzJKZkVLYlBNaXlsSDErUmo5eDEzQWRvRk1MSnVaVEk0?=
 =?utf-8?B?WlVST3hJRlQrbDMra0p6dlAyWnVWbjhWQXF4ZVZWRTdOWmZKbjFTc1dLd0tO?=
 =?utf-8?B?aFEvN0REK1doWEhreThueUhUZVpRb2dGUjIyVmhDOVdwamltNEZWOThwZ3JI?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB6F26D6964B234D87EDACB216D8831F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YsqYbNHw2aPkU1DdjFGLlgm75K4tB7uT+3QOdZzLEyCePU2nuTUZHgWxvAbndYfm3XBI9x71WHTVWp/qBuLQcGy+z0smLP5tp7AJBr7UUPTA6S75bJXJ9sMBYcox4ofblMfsooYljRDdP3mqpL5sCAkk5h5g5Ngp1TWz7n96OrlU4LI/ZYAeeVzKXeNYznvvazTaeTLcdLCkDFTe+TBYAXtqggOjipEyJccUV5LUfecdetLdRGMFfXx3HitIKo2Z8rBezGidneJ10sbcI5bjgFSckJfKKsrMT77IHrBR3GtlbVA3jeTVerJhwg96WLkTC2SB6ZGPB+v72uUtcP1Odwcqm9aQxzbCYC6VwBrP2opFrvz56WXFhDKkkIpWaOPUTu7Xw5LxGx6XFJLA019DHw3VrjfIMu0Ddn2V7u3x9oqfHU/rxm+GgMgtbJbmlcQVKsRA26Qo8zLyxK4ffutX0T3P/Hto1g3ayD+GvBSelPwNMUjSHskEY0fK3JN0ovlkVfzzgSN1J6DhNMKvMjUb1n+RBBJOlyXP/rE7PLnZdZhjGcTpS/XF5E4Jb8LBZ/9uYs4y8L7NtbkOk3REOck3tg9+x7d2bulJqHCOJFufWgQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1d236e-9967-49aa-b2d6-08dc9b748366
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 15:26:30.2562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ivi4m2eA5dHC6SacFyaTwv34S5KSF0VWEDpt/hLV1yts1rGj8IcNTHj6iEOOz4aWCBsHbhf6zZKZnpYOikV2tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6429
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_10,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407030114
X-Proofpoint-GUID: n5b6vH6XhwHIlv-Riaxi53i8c8NpFKbB
X-Proofpoint-ORIG-GUID: n5b6vH6XhwHIlv-Riaxi53i8c8NpFKbB

DQoNCj4gT24gSnVsIDMsIDIwMjQsIGF0IDQ6NTLigK9BTSwgTWlrZSBTbml0emVyIDxzbml0emVy
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gQW5kIGlmIHNwZW5kaW5nIHRoZSBwYXN0IDIgbW9u
dGhzIGRpc2N1c3NpbmcgYW5kIGRldmVsb3BpbmcgaW4gdGhlDQo+IG9wZW4gaXMgcnVzaGluZyB0
aGluZ3MsIEkgY2xlYXJseSBuZWVkIHRvIHNsb3cgZG93bi4uLg0KPiANCj4gSWYgb25seSBJIGhh
ZCByZWFzb24gdG8gdGhpbmsgb3RoZXJzIHdlcmUgY29uc2lkZXJpbmcgbWVyZ2luZyB0aGVzZQ0K
PiBjaGFuZ2VzOiBodHRwczovL21hcmMuaW5mby8/bD1saW51eC1uZnMmbT0xNzE5NDI3NzYxMDUx
NjUmdz0yDQoNClRoZXJlIGlzIG5vIG1lbnRpb24gb2YgYSBwYXJ0aWN1bGFyIGtlcm5lbCByZWxl
YXNlIGluIHRoYXQNCmVtYWlsLCBub3IgaXMgdGhlcmUgYSBwcm9taXNlIHRoYXQgd2UgY291bGQg
aGl0IHRoZSB2Ni4xMQ0KbWVyZ2Ugd2luZG93Lg0KDQpJbiBwYXJ0aWN1bGFyLCBJIHdhcyBhc2tp
bmcgaG93IHRoZSBzZXJpZXMgc2hvdWxkIGJlIHNwbGl0DQp1cCwgc2luY2UgaXQgbW9kaWZpZXMg
dHdvIHNlcGFyYXRlbHkgbWFpbnRhaW5lZCBzdWJzeXN0ZW1zLg0KDQpJIGFwb2xvZ2l6ZSBmb3Ig
bm90IGFza2luZyB0aGlzIG1vcmUgY2xlYXJseS4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

