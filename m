Return-Path: <linux-nfs+bounces-4714-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E2892A479
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 16:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53771F21F9D
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 14:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C28825745;
	Mon,  8 Jul 2024 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fgkd9wjS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g7YV9vbU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCC8823CB
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jul 2024 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448340; cv=fail; b=PWHxzoYqLflqRwcUe8Y76DVACzWm3rQi/bKpl71dSJIagB/dpyokbckqpTy+TyIT4xAdEHVJ36fkp0qD5CrCT8iw8KJ6tKCQOBW/uZYiKPnLqqzvf3xgRrFeRMM3oRomNS1IEH6SYrFJFtcTmQiBKGcFLFJKkWSt/DZv9oYLaKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448340; c=relaxed/simple;
	bh=p9jP41ov9vu/kLSRgVUVZ8T5msWLTUy/nvoM6f0zgX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=njLr6Wi+pRw6i6Cw67H/pHoyGYF9zj3nrfFBFSP6SX8xXjGAW+rSgM8GD60H0cmTuuQtwBjc7dhd7nkITAFs1e+OoJWVZ8XfWhU9yTfAn0ff0QCqpayht/FrTyvG2hqNBj479qT4Iwfz07GUbfdlyyYPJ7MZVbbt4j/o1hVi/g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fgkd9wjS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g7YV9vbU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fVDc004189;
	Mon, 8 Jul 2024 14:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=p9jP41ov9vu/kLSRgVUVZ8T5msWLTUy/nvoM6f0zg
	X4=; b=fgkd9wjSTSgRzoaSX7h5n/Ci1ccfru7Qnq47+OSvYLWRgRP9C+yZMwJgQ
	LEG8+HMTVNAsOml4gR1ofI7r0c7pFdyLmsQ4OcLS1oYhJ6KzRIyDjkKHBb5a58vG
	kkl16yNpMlC0aD6CI3+x6bTAHTyNOJKjGYxjgCq0ZXCbgw9XZyPmdFRz1Qfr97fC
	lkCeP1AzglxQnERSMXhf1ori6zHbLWoFmiBHSWB5Bvnh5MZZyWJkA3bpxvh/a9Ug
	cQYfH41tEJ725h5PcWhkQKywKpPGFMxMBP4DzSh60mhwxzuTeBfdLWg26q9IUSKu
	rzZdkwcAslxaXJkWChXv3g8RQua8A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8ar1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 14:18:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468DNjDc007417;
	Mon, 8 Jul 2024 14:18:47 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tu1qj5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 14:18:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHEISPoAa8Yh2BccRD2grNTU3zAMyVX85hBhPvJu2aIG06oJMM42G0xtpM0SP7Glod0Tm4TDo1S8DNJ8+tbZyphH2k11vPaHuygM5xwAZxVElZyhHj+JgkkdKe3Ruiyr9cvWZR6Zo3wWTPjKqIvM6AfqF4TVvzyD97ED3yNF3qjw0naBLH7ysBx1rB5D/ZRPiQTWyvRa5CmnaLKE+C2WATcn4K9/5qtuXv3nD7xBPahy9hE3ciqY398S1S8COFFgHg4uroXH4/3yE5w+yRmhoHFdgoRZLQL45L5Y/qlOEQYOztQgjRohvyqm2rQWFVLUukNXoyeV3FxJHpgsS5Pu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9jP41ov9vu/kLSRgVUVZ8T5msWLTUy/nvoM6f0zgX4=;
 b=HOX0TGy1vhP6u0QtifQNgGX5oL5gIa4so234AmV9fiVDnyUicx7jRyxeXqAQPl/WG5vlq+lIrNTuQnKIqm4riASMl1aZPVFIHMgs/Y7HdFR9OgjNiHwL7igP1hR3NGGa4iKndD6vXftdq6XYKVD82qDESEFV366IvK6NjWnV7DBv1ED7X5x/Lqpg4P3FwUbitWBfVOod/1rVmKqR7Wd2jHFzeJI5G+A8v/fh5wXog7D/R3kC5orWL+BrEQvNUEhjUOJ8Z5G6zattB5Yl/fViT+fvEawtIQxnn4Qj+y6RjUMjLnRevQUl9FQU+4o7fp77kwdu+6usv/TnG1jEnU5ZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9jP41ov9vu/kLSRgVUVZ8T5msWLTUy/nvoM6f0zgX4=;
 b=g7YV9vbUdU+j/FLkwJPY0+pycmW0qWXRprVIvQSc6JZEXS2xLOm2plr2RU5czmkqo+YfX98hsH9vYhyLU7ZJtYmg7L2aC6/aHcmH96qBSnYF1UxN2Ca4A1kf7TWWAv1D7H7axGwMAC0rrZkp2VFaufFRuIfz/AFZtg313dAXC0Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7988.namprd10.prod.outlook.com (2603:10b6:610:1c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 14:18:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 14:18:45 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Sagi Grimberg <sagi@grimberg.me>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
Thread-Topic: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
Thread-Index: AQHaz/XBfwkxQ1O/ZU+jeIGo74rnYLHrG52AgAHH5gA=
Date: Mon, 8 Jul 2024 14:18:44 +0000
Message-ID: <9156BC30-78C3-4854-8BC3-510E586B4613@oracle.com>
References: <20240706224207.927978-1-sagi@grimberg.me>
 <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
In-Reply-To: <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7988:EE_
x-ms-office365-filtering-correlation-id: 0eac446f-a8d7-41c9-89e8-08dc9f58e05b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?aUZjeEtXWk93dXBCRTN0U04rZHNuZ0g3T1dLQlZVcU15VGQxbnJVYjhiemtt?=
 =?utf-8?B?NkxhMjl4SU9IWURlRXc3d05tSG1naWYwR1FqZzV0SjIvL1RiMzYyWHJBVUFK?=
 =?utf-8?B?ZjEyMVlVcHQwS1VNRVlVYWdDWUFsMG5PRy9JcmFtUTBkZ1B2UFpPUm84d25I?=
 =?utf-8?B?M2FxdUxReWZRRW5EZndOM3M5UlF4OUdUUXFqdGNOMjMwWCtIUjZxTFNiVWtr?=
 =?utf-8?B?RmJqYjl4UWRRVlVZL0pkVXZtdkErRnBrd21xTVZ4WkVROGFQQ1VLd0FNM05P?=
 =?utf-8?B?QnRiWEJLeTVPekIvemR3VE0wNnM2a2VwNGpXc0wvanZVdkN2TEdNNDArRDhi?=
 =?utf-8?B?ZlFWaTF5WUcvVFNDN3ZiclR6eXQrZDY1RVVWQnVwRStJaE9VdUNESlZiRFJq?=
 =?utf-8?B?TUNPUCsrZUcxK0RXb2xoZ3g1K2Qxc2xNV1hGR3FCWVNkZEY4dnBqempoTVVK?=
 =?utf-8?B?Y0F0bkVTcFJzRnBvditNbG1ZYm0rWkhUZ1Z6dHpvVVZVbXpabHprOHFGYUNV?=
 =?utf-8?B?U0w0cWRYd1EwK0NZZ3F5K1lCbnAzNUJodG5IUHpJT3VEWnc4M3dRK0liRFFI?=
 =?utf-8?B?TkRLSFRYMWVTWFE2ZUpxT3poTkNrT09PS1lybzZyYUpVKzVpZUdtUExGbmFY?=
 =?utf-8?B?TEluV1Fzd1FUR3F0TjlQdFFTRVVLVG8vQjAyeERzUFBGS0pjTlBYUjd4ZFJH?=
 =?utf-8?B?TXBBYXZKL3V3SFNEQ3h1VEk0Wk5pYXp2d3RpSjBLMVpzRzlzcUdLbjlGMnR3?=
 =?utf-8?B?cVVXSFp0a3ZMbUF1S1ZLN1lCV2RLOWhSTkk0MUdMa0kwQmZXSUR0cXRPV2sw?=
 =?utf-8?B?U2pieGNJMWtzUDJiNVV2VDdheFROWHBvZklhdk5rckQ1allQdnRDaVVzdGhP?=
 =?utf-8?B?aXNuQkJFcGllTjZUa1F3QlpQeFhpeVcwYkVybUpiR1VhcHpZUzlOcXlWWXZI?=
 =?utf-8?B?bitrWkVML2cwbytXSmJ6L3BiaDQwVW1YeHBrZHJLUzkwOTJkOExtc3k1ZXZQ?=
 =?utf-8?B?Q2xlZXF2RGRoSkNERkI2TjNsU1RCc2U3R2k4Qm44MEVmWWFpT3Q1dUZNK2FJ?=
 =?utf-8?B?YWZnZFNqNUhDajlHT1dwMlU0YisxYUoydUtoZnNQSjl3SzVLVEYxL20yVEE1?=
 =?utf-8?B?Z1kwK3lwNEdoVWJBci9OOFY0dkJ3NkZNdWVkY0UwWVJhdTVpL2Nnbmg3ZFBo?=
 =?utf-8?B?WnQyQVB4UXNESzN3L09nMEZDTkk1STRCdlBCVXA2dC80SVVKNnluWHF6eHhV?=
 =?utf-8?B?dktZMUxCWE5OdElUa1Q3NVVoQ3lZa2JZWlFGalRIbUw5VlhvQ0JmeU5uWDFN?=
 =?utf-8?B?dmgxRXhaSElMQmFUN1FWRTBwdDcyclpRdmNnZEp1T1ZXVjRWM1hoRXJtSmVD?=
 =?utf-8?B?VEtVWnRLaXBjUHZBUmh0d3p3Ni9ZdUVSUndWWkJ3b2djMVJveG01eGlFb1pq?=
 =?utf-8?B?WlE5MVlrOTVwckpRWVVqN2JpZUdYczI3R2xjbURwRW5Reko0OGxYZXI1SDhG?=
 =?utf-8?B?ZENpUy9sYTFWRWJUVVphUnFlSGx4VW5SdUNXQVdXVm12VjlNaDhHMjFTNHY5?=
 =?utf-8?B?NmtuVVEzbERSbHRFQWxHV1J5RTRwM0VpUWZvWWMrZE1FZ0RyKytJRXN2Zzhw?=
 =?utf-8?B?c1Q1YVpNSTAzOGxrZ2tzSWVPYmZJL21ZQ3VDZUFYTDZXTFo2SHlPditBOTJE?=
 =?utf-8?B?eUsva0FhNjNRMmZsUFF0WTZaS2ljbjhLR1RXUWI3TGU3cjFxQ2FGVHJVUFZO?=
 =?utf-8?B?RVF0NFlWMnVwMzZRNGNXZkFkbFJVdFVPZmhRenEwQllOY1hnbCt4ejF3eFh0?=
 =?utf-8?B?M0xjNVdBbVB1L29RckhPTE8xaWRYTWtnZDFiUXVVY2svaWt0MGpDdFdYTFBP?=
 =?utf-8?B?SFBXZ21hV2JBYVNBcmVCZ3hQZy8zRUUyRUdCUklCYTlVTFE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VURGVVZQczlkVnhQbUQyMHRIVFRKd21jZ2xXdGducjhuTUZnNC9sYmt2emQy?=
 =?utf-8?B?blRpZmtjc0NEcDdPQXR5NXljbFliWXRJRzRxWVlrdFUvUU85OENMN0VZdk9D?=
 =?utf-8?B?RXVyZkpNWnlxTnkyWnY3WVRLK3p6R3BlZzVwZFhoakt0VkxLT2ZjdXp0ZjFp?=
 =?utf-8?B?aVhxQUdPVnlUN1NWdnRwcTJUdVJ4Wm1IQlJYaEpleUxUOWNDc2pXQTg0NFN5?=
 =?utf-8?B?S2JIZ0RpY3BCZG93bE5ib1pyenZPc3JYa2xUWE16SE5RckZmdVBzazI5SEND?=
 =?utf-8?B?WmVnVW9XbSt5c3dkcXpRWm1DREs2dm0zc2I5Sk50MHI5QmluK20yMWw4d25h?=
 =?utf-8?B?Ri9QUDhTRHVDS1VzUFBmVmhxVHR3eHRQWS9TRGdZaEx4WHdJVEZ3MGNsNXQx?=
 =?utf-8?B?N1VQaUdNaFZOT1JEcjk0YjVJeXZzSnFBcktNdHhxSi9ZRlNHK3BaTEhmUGdu?=
 =?utf-8?B?REs0cFBGNllRbHJZdlYyM1huQkpadHg2YVVSL3JBRXdvZ3hmZVlkZk5zQnFr?=
 =?utf-8?B?WHNhR1VtdEJPaHBNNHN1WkFVYXpRUUFXNEppaHNEZDFkOUpaZDJSOXVTUUR6?=
 =?utf-8?B?Z3FleDVkbUY4WmxKaWc2TWRlQjNINFpsOERMMndrVHRISURpaVZ1YkhJS2My?=
 =?utf-8?B?ZVRqcHRWYm5OdktCblJRanpLdGdLUW1STWQvZXMrMjhwUGt2MERvVHZ1MVV0?=
 =?utf-8?B?M01ZQXpzbmhBc2JUQ0RSVUg2VDh4UEJrK1BCTlhvSWFla3pjd1JHVC9TWHpC?=
 =?utf-8?B?N1hFMnQ5UFVjNExydDUrczAxcUJJRjQxR1k3d0dIcmNrSFlMblRNRjRQQ3dB?=
 =?utf-8?B?Zit6UW9PQmtiUGIybUNNNmIzZWVxY1dRdUZTWHJIS1F4SklDNWFaQ0cxU2lx?=
 =?utf-8?B?cnBOZzFqQUt2RnJLTSt6THpqZ2ttZjZtWEdnNTMrbi92djhRdHlQbzNtNTJ0?=
 =?utf-8?B?Z1Rtb0JZQzI4ZDAxVjZPcHM5Rk0rRk9qSnhnVi8yRU0yV3VRell0clFKZERL?=
 =?utf-8?B?Tm8yalU0T3B6MnNjZHZUSzlzZDVLY2Z2UzJ3UHJMOWV0NVZtN0IwcjZCQk5t?=
 =?utf-8?B?UUM4TzUzUjBsSEhOL1RveWYwTWhDV3k3MnZQbDBXbmR3UjRUNmJVWG1udEpn?=
 =?utf-8?B?Ky84OVN2Z01BV1FJa1RWMmZ2bTVUQklYMnY3aEI2MzRQM0hTSEVYcktIZXRp?=
 =?utf-8?B?SDdoSE1yT0EwQ0hlb0Y0ZEVxcE05RGk0dDZYREZlWnRQaXlNTnVyYU9lR1px?=
 =?utf-8?B?b2I1MXY4WW94STdaYlQ4QUZMcE1sUldKK2NsRGRIOC9xUm9vS1J6SGJsbE9K?=
 =?utf-8?B?UElFUGxLSlYzQWRmS0hKUkpSajl3ZHZiOFgxZmM5ZmxaeCtudG83N2grbjdk?=
 =?utf-8?B?U1JpK3JKTm1SUzVRSmwwcG9WVkc1VE44UEJoNHlMdStVUXM5UjJvZVdGOWtF?=
 =?utf-8?B?ekpkd2VGai9rOTNjaUx4WWVjZVJ0V25hSmJManEvZDNELzMwZG1JRGlFRGhT?=
 =?utf-8?B?a0FpcXBCLzRkSVBZZ2g5YzNyaGUwU3lBQzFyQlpOZ1YzWmowR2hpUERrQ01K?=
 =?utf-8?B?SUMzR3RRU3VNMURvUFkwM2tDVVBRRnpLYWU0YnBPN0xRMzFkeVRlV2dzWld2?=
 =?utf-8?B?RGcybTdJcXZQSDhUS2xyYk1MQXZHRENPUnpqbmNvamU0MzlSVEtDbWhKUTdI?=
 =?utf-8?B?WGRDRTJ0dzh4YnE2cFBWbFFtVVMzRERhUWc3SCtSMFNTbDF4eVpscjNZOFZh?=
 =?utf-8?B?RlFidWdSdy9WdFJFODF0VkZZRXlMZytHUDJoVVJrbjQ2S2ZUc0VpeU1zUHI2?=
 =?utf-8?B?b1UxZWtoclN4L2p3OW9ZRlRpSFVWc1prOVlucHFIQkI1YnY3cUczcnBLNDBm?=
 =?utf-8?B?ZXFFakt6N3dPMzhSYS9hTXg2cFZmUGZ2K2VYRS9xZWVkTEptaU8ydWllT29v?=
 =?utf-8?B?RGZtRWt4c1YzK3ZIRldmclpmeFBXZVFmUmRzNHdIL0FRL0JUN1hIdENFeHJB?=
 =?utf-8?B?dDdRUkUrb2lKNUk1aExWZGQvMjhFaS9DcEdOMml0a2lTdkdsVWtJQ2p4Z0oy?=
 =?utf-8?B?ZEQ2ZmRXVUNPYmZWM3RVcE80cExoRGhpMU85bUg3M0s4eTIvUXA5RlZzVVkv?=
 =?utf-8?B?TlNid1h0TzloVlFCNGJlRncvMktkTnQ1cFlOZXY3akd0MmM5dXpkNEh5YTd2?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC1F6FC2DFD00F4192B29E8C96CA3513@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	s49i5sKM1UWZGf8eJPSOq0oAd9xo3IAlY5P8ma7fd2xjAmfbcpEWvw0dYAAXsTg2jlOCqPf8ZQa1vcFnp84SSJeMgfzaz20A8tupoNjDO23rT9Hs4dbm9Yu84IpMuipw++J0IU7Hs8LsqNQbGGdNbteCDkiWNA32+MTbKt3wq9E3bU9kLKYSPRpOTSULUrIjFBHvhI2dpo5JoOe2Cx/z39m895OqCSuP3OMyEV0hU+wZHhd8NI1HMQMhi4/dPH3wH9g04HQ8enRwZTkkwzaYYAOEGA5Fdvzs6QHYwP66KgOaZzJPVLywjCLTCh5fKBlYldLWDO/nECTxajiTr7p0J2MknrHSDiWmpfpGc/UzNQ/1J0pquTS4J3e7yrGalIa+xlOby7X/u5uUKNG7FTax3pmKpe4xHLsPlX1SJfel+DNIbjFhTieT4NhK6SdzpPk7bt4gh0T0Fw4r2fQ/Fpzbxjoh2Q/cKyKsSEHXX4rfYhFSR63ZDqeFQSkoIy+QFaMFzOubq3vIiDuXnTZgPRHLpOk23ZSFJE58PFSLJk+4da+QJGqnTM4NA+tJ7/Vl/y+ttMnnJT/9Ls24nqTPevIyh6Nflax1XYxvb10GGoX3vs0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eac446f-a8d7-41c9-89e8-08dc9f58e05b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 14:18:44.9526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VG+8SQWsEzR0ha7401MDILZAcXqs0EYX1+0GS0Cp95pyQbdrGNxwD+XfNLY/VdX0v41jD730yQ/JVNSvm+SSxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7988
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080108
X-Proofpoint-GUID: rH2Bec2-LaflLynFXf_pPKaCUPw3nJNh
X-Proofpoint-ORIG-GUID: rH2Bec2-LaflLynFXf_pPKaCUPw3nJNh

DQoNCj4gT24gSnVsIDcsIDIwMjQsIGF0IDc6MDbigK9BTSwgSmVmZiBMYXl0b24gPGpsYXl0b25A
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBTdW4sIDIwMjQtMDctMDcgYXQgMDE6NDIgKzAz
MDAsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+PiBNYW55IGFwcGxpY2F0aW9ucyBvcGVuIGZpbGVz
IHdpdGggT19XUk9OTFksIGZ1bGx5IGludGVuZGluZyB0byB3cml0ZQ0KPj4gaW50byB0aGUgb3Bl
bmVkIGZpbGUuIFRoZXJlIGlzIG5vIHJlYXNvbiB3aHkgdGhlc2UgYXBwbGljYXRpb25zIHNob3Vs
ZA0KPj4gbm90IGVuam95IGEgd3JpdGUgZGVsZWdhdGlvbiBoYW5kZWQgdG8gdGhlbS4NCj4+IA0K
Pj4gQ2M6IERhaSBOZ28gPGRhaS5uZ29Ab3JhY2xlLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFNh
Z2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+DQo+PiAtLS0NCj4+IE5vdGU6IEkgY291bGRu
J3QgZmluZCBhbnkgcmVhc29uIHRvIHdoeSB0aGUgaW5pdGlhbCBpbXBsZW1lbnRhdGlvbiBjaG9z
ZQ0KPj4gdG8gb2ZmZXIgd3JpdGUgZGVsZWdhdGlvbnMgb25seSB0byBORlM0X1NIQVJFX0FDQ0VT
U19CT1RILCBidXQgaXQgc2VlbWVkDQo+PiBsaWtlIGFuIG92ZXJzaWdodCB0byBtZS4gU28gSSBm
aWd1cmVkIHdoeSBub3QganVzdCBzZW5kIGl0IG91dCBhbmQgc2VlIHdobw0KPj4gb2JqZWN0cy4u
Lg0KPj4gDQo+PiBmcy9uZnNkL25mczRzdGF0ZS5jIHwgMTAgKysrKystLS0tLQ0KPj4gMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAt
LWdpdCBhL2ZzL25mc2QvbmZzNHN0YXRlLmMgYi9mcy9uZnNkL25mczRzdGF0ZS5jDQo+PiBpbmRl
eCBhMjBjMmM5ZDdkNDUuLjY5ZDU3NmIxOWViNiAxMDA2NDQNCj4+IC0tLSBhL2ZzL25mc2QvbmZz
NHN0YXRlLmMNCj4+ICsrKyBiL2ZzL25mc2QvbmZzNHN0YXRlLmMNCj4+IEBAIC01Nzg0LDE1ICs1
Nzg0LDE1IEBAIG5mczRfc2V0X2RlbGVnYXRpb24oc3RydWN0IG5mc2Q0X29wZW4gKm9wZW4sIHN0
cnVjdCBuZnM0X29sX3N0YXRlaWQgKnN0cCwNCj4+ICAqICAiQW4gT1BFTl9ERUxFR0FURV9XUklU
RSBkZWxlZ2F0aW9uIGFsbG93cyB0aGUgY2xpZW50IHRvIGhhbmRsZSwNCj4+ICAqICAgb24gaXRz
IG93biwgYWxsIG9wZW5zLiINCj4+ICAqDQo+PiAtICAqIEZ1cnRoZXJtb3JlIHRoZSBjbGllbnQg
Y2FuIHVzZSBhIHdyaXRlIGRlbGVnYXRpb24gZm9yIG1vc3QgUkVBRA0KPj4gLSAgKiBvcGVyYXRp
b25zIGFzIHdlbGwsIHNvIHdlIHJlcXVpcmUgYSBPX1JEV1IgZmlsZSBoZXJlLg0KPj4gLSAgKg0K
Pj4gLSAgKiBPZmZlciBhIHdyaXRlIGRlbGVnYXRpb24gaW4gdGhlIGNhc2Ugb2YgYSBCT1RIIG9w
ZW4sIGFuZCBlbnN1cmUNCj4+IC0gICogd2UgZ2V0IHRoZSBPX1JEV1IgZGVzY3JpcHRvci4NCj4+
ICsgICogT2ZmZXIgYSB3cml0ZSBkZWxlZ2F0aW9uIGluIHRoZSBjYXNlIG9mIGEgQk9USCBvcGVu
IChlbnN1cmUNCj4+ICsgICogYSBPX1JEV1IgZGVzY3JpcHRvcikgT3IgV1JPTkxZIG9wZW4gKHdp
dGggYSBPX1dST05MWSBkZXNjcmlwdG9yKS4NCj4+ICAqLw0KPj4gaWYgKChvcGVuLT5vcF9zaGFy
ZV9hY2Nlc3MgJiBORlM0X1NIQVJFX0FDQ0VTU19CT1RIKSA9PSBORlM0X1NIQVJFX0FDQ0VTU19C
T1RIKSB7DQo+PiBuZiA9IGZpbmRfcndfZmlsZShmcCk7DQo+PiBkbF90eXBlID0gTkZTNF9PUEVO
X0RFTEVHQVRFX1dSSVRFOw0KPj4gKyB9IGVsc2UgaWYgKG9wZW4tPm9wX3NoYXJlX2FjY2VzcyAm
IE5GUzRfU0hBUkVfQUNDRVNTX1dSSVRFKSB7DQo+PiArIG5mID0gZmluZF93cml0ZWFibGVfZmls
ZShmcCk7DQo+PiArIGRsX3R5cGUgPSBORlM0X09QRU5fREVMRUdBVEVfV1JJVEU7DQo+PiB9DQo+
PiANCj4+IC8qDQoNClRoYW5rcyBTYWdpLCBJJ20gZ2xhZCB0byBzZWUgdGhpcyBwb3N0aW5nIQ0K
DQoNCj4gSSAqdGhpbmsqIHRoZSBtYWluIHJlYXNvbiB3ZSBsaW1pdGVkIHRoaXMgYmVmb3JlIGlz
IGJlY2F1c2UgYSB3cml0ZQ0KPiBkZWxlZ2F0aW9uIGlzIHJlYWxseSBhIHJlYWQvd3JpdGUgZGVs
ZWdhdGlvbi4gVGhlcmUgaXMgbm8gc3VjaCB0aGluZyBhcw0KPiBhIHdyaXRlLW9ubHkgZGVsZWdh
dGlvbi4NCg0KSSByZWNhbGwgKHF1aXRlIGRpbWx5KSB0aGF0IERhaSBmb3VuZCBzb21lIGJhZCBi
ZWhhdmlvcg0KaW4gYSBzdWJ0bGUgY29ybmVyIGNhc2UsIHNvIHdlIGRlY2lkZWQgdG8gbGVhdmUg
dGhpcyBvbg0KdGhlIHRhYmxlIGFzIGEgcG9zc2libGUgZnV0dXJlIGVuaGFuY2VtZW50LiBBZGRp
bmcgRGFpLg0KDQoNCj4gU3VwcG9zZSB0aGUgdXNlciBpcyBwcmV2ZW50ZWQgZnJvbSBkb2luZyBy
ZWFkcyBhZ2FpbnN0IHRoZSBpbm9kZSAoYnkNCj4gcGVybWlzc2lvbiBiaXRzIG9yIEFDTHMpLiBU
aGUgc2VydmVyIGdpdmVzIG91dCBhIFdSSVRFIGRlbGVnYXRpb24gb24gYQ0KPiBPX1dST05MWSBv
cGVuLiBXaWxsIHRoZSBjbGllbnQgYWxsb3cgY2FjaGVkIG9wZW5zIGZvciByZWFkIHJlZ2FyZGxl
c3MNCj4gb2YgdGhlIHNlcnZlcidzIHBlcm1pc3Npb25zPyBPciwgZG9lcyBpdCBrbm93IHRvIGNo
ZWNrIHZzLiB0aGUgc2VydmVyDQo+IGlmIHRoZSBjbGllbnQgdHJpZXMgdG8gZG8gYW4gb3BlbiBm
b3IgcmVhZCBpbiB0aGlzIHNpdHVhdGlvbj8NCg0KTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGEg
d3JpdGUgZGVsZWdhdGlvbiBpcyBubyBtb3JlDQp0aGFuIGEgcHJvbWlzZSBieSB0aGUgc2VydmVy
IHRvIHRlbGwgdGhlIGNsaWVudCBpZiBhbm90aGVyDQpjbGllbnQgd2FudHMgYWNjZXNzIHRvIHRo
ZSBmaWxlLiBTbyBncmFudGluZyBhIHdyaXRlDQpkZWxlZ2F0aW9uIG9uIGEgcmVhZC1vbmx5IG9y
IHdyaXRlLW9ubHkgT1BFTiBzaG91bGQgYmUNCmZpbmUgdG8gZG8gKGF0IHRoZSBkaXNjcmV0aW9u
IG9mIHRoZSBzZXJ2ZXIsIG9mIGNvdXJzZSkuDQoNClRoZSBpc3N1ZSBhYm91dCB0aGUgQUNFIGlz
IG1vb3QgZm9yIE5GU0QgcmlnaHQgbm93IGJlY2F1c2UNCk5GU0QgcmV0dXJucyBhbiBlbXB0eSBB
Q0UuIFRoYXQgc2hvdWxkIHJlcXVpcmUgdGhlIGNsaWVudCB0bw0KY29udGludWUgdG8gc2VuZCBB
Q0NFU1Mgb3BlcmF0aW9ucyB0byB0aGUgc2VydmVyIGFzIG5lZWRlZC4NCg0KDQotLQ0KQ2h1Y2sg
TGV2ZXINCg0KDQo=

