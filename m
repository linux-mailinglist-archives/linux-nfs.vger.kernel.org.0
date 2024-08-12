Return-Path: <linux-nfs+bounces-5316-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1614B94EED8
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 15:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C394F281E62
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 13:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E37017A92F;
	Mon, 12 Aug 2024 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DRcsff5O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zkPagb4b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD62717E91A;
	Mon, 12 Aug 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470766; cv=fail; b=evLtYCguG9io+awsYA+pTBGt4yRjzbzQv/WGDu89tu/RB5c14pWQY72WScqdTnoFYTzZ3mBr0p9XPv3TlP/2M7y9rup6YvGtRgJC7CpHiE4BwbZ2iml/9nb600qtkfMjsCo1FfgSeGseix92eYBnvlQNe5dsXfHq8IGFVNvmIBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470766; c=relaxed/simple;
	bh=WboLLTMI1Obupn3rh40WRGsQxrk26HtctmXDRjh8i1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jWrR8SVTrjC0Wpi/e3CgLi+LUG42Vb/uA8VeY1YiitUMD7Fjc0LLasw97GuDnUcgQ58LLQ5m15hNnH6uiV+xgWmRwuLC1nbFV3Klcknr7n473eGSu1GDdVdwElWUsF24C1KBJRXHSK6CgS+0VDfigW8oqwSt5I3nu7D320PBdI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DRcsff5O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zkPagb4b; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47C8wolY023010;
	Mon, 12 Aug 2024 13:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=WboLLTMI1Obupn3rh40WRGsQxrk26HtctmXDRjh8i
	1k=; b=DRcsff5Of+a8p1lB3GYMuGdyVtdRcGc3tSSvdKDmJPHffWpwN3xAoWz7y
	U7xu3QiyAFDvu327Q8iSP5nuh8WiVUFfvaBF6NTDFc2YDsEgZzK1Eiqa9ptqYGXv
	YAZSPdix/msWJOE/FzfzqK0WZSUV4VLwKcDBS+7qq5rFpTN1Vei7FMbOtGl9xLai
	ZU4zhO6IwtTpAgp8nzyEJ2s+fPHaUT/k/XnB8DwwDL0uuzjajcXnqByMFJVbwyOm
	aXno8/w+8ZA7EFJBD4jo47IKgRmwGJji+eOdEY9B31MFwIr4VBAQ5iV1nndAmK1D
	GQ4JRj8JVQvxRfB4Q0htrmTkq0VvQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0rtjmdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 13:52:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47CDm1TF003547;
	Mon, 12 Aug 2024 13:52:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn74rds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 13:52:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQN+y9IuNsD+JGZNJRE226k+dz0DQ95zb4wJHcXTunWB+i2q3AjJQKDmV1E/v9znbPPVAjXQEmR+ETPBXCMyp3jcMLsZgLcvstet1upQuKWLjpQwOHAEhHJcYNvrSjDT5aXLnHN0rK9BOApCsLJtIMh+ws3o5OEqy8ppYHKSdExuNLQzwu6RqsYusBYcMQ1oM7feoirLCQBZe31lGxbT4/cAc3pu5k+06vumRV8XfffVInc1/tUJQjUckZSAVjnIvR1YDMNJh1+7UM0/kdSemHTdIOgQS98aUza6EcEM/dMONAEjhkBNAwaQNZwF4/PZ/kQ8tUEr2TXFOAouvUBbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WboLLTMI1Obupn3rh40WRGsQxrk26HtctmXDRjh8i1k=;
 b=ZyTbOLRrVB9QgFJgOH19eAzhSPS9HGhQmcUYLN8gM8jBO79Kc4xBpQfjK9g/vP+N7wBxuUjprNwSDiamTN+2DoCGiOEA7d5DtY6Rc3UCMWhcG0xz3WYSg8Vrw8MmAKoytua47IzKfImxU+tAPzTbxNH6axNyAi66J1wm+BZoW2jm+B6j2H6zIAq/6rtR+MYhpDvtcqAEku4bFrYzsj0Ovovgc8d8KAzGM8rBuKClvpxLny+2GVv5P5c1+3DPzSjv583IaWz35dpfR+E7R1NsLCAOz0YgR8fpMJ3qum7waBxFLHHZNmXmJkgpJW0gWBJcIXoyboNoTTBxJKm/K4I96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WboLLTMI1Obupn3rh40WRGsQxrk26HtctmXDRjh8i1k=;
 b=zkPagb4bnh5Mj6In8PJaAlSQFyj9WDeNGfRdNi2Uck7A3377W3dmFtUC+D3qTWHawMoVL3c6rFlyeSrI6ZdQpnQniTMeENh5MR9lFJU0y1ZicBEvARHPSw7hc9+E0w63Vv1+fH7eSn4XrB9Rp9gmTRkFn+T0M0hBM36mv2HzRMo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4701.namprd10.prod.outlook.com (2603:10b6:a03:2dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Mon, 12 Aug
 2024 13:52:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7875.015; Mon, 12 Aug 2024
 13:52:18 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Sasha Levin <sashal@kernel.org>
CC: Chuck Lever <cel@kernel.org>, linux-stable <stable@vger.kernel.org>,
        Linux
 NFS Mailing List <linux-nfs@vger.kernel.org>,
        Petr Vorel <pvorel@suse.cz>, Sherry Yang <sherry.yang@oracle.com>,
        Calum Mackay <calum.mackay@oracle.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "ltp@lists.linux.it"
	<ltp@lists.linux.it>
Subject: Re: [PATCH 6.1.y 00/18] Backport "make svc_stat per-net instead of
 global"
Thread-Topic: [PATCH 6.1.y 00/18] Backport "make svc_stat per-net instead of
 global"
Thread-Index: AQHa61/1U/H0ne1UeEGwhDkCVKBlbbIjgFQAgAAmj4A=
Date: Mon, 12 Aug 2024 13:52:18 +0000
Message-ID: <A0BF8EAF-A16D-4200-8362-E833BA23159D@oracle.com>
References: <20240810200009.9882-1-cel@kernel.org> <ZrnzLoZ8Tj9GhRSO@sashalap>
In-Reply-To: <ZrnzLoZ8Tj9GhRSO@sashalap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4701:EE_
x-ms-office365-filtering-correlation-id: e12dd053-2358-46c9-30fd-08dcbad5fb09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OGdoRlR0Mm4wWnduZ1c4bzhlOVZRbUdjKytValZsTThaL0hGT2s4OHVBNUtY?=
 =?utf-8?B?TWhKdGFTVU1YY01FdnBxZlJzZzJLTXhuclRhS0hWMUp2WFFYVUlRaVVBVGNW?=
 =?utf-8?B?K0tra3BUZ0V2dVMzOVptaWZXb0IvckZ4YkNTWGY1VXJUbUtVVlZ2NnhhSXI3?=
 =?utf-8?B?dXJnUmJFbnlYUW9WWG95eUxDRkkrVUpYKzFyT0ZwY2xSZWU0cDI3S0Q5VkhW?=
 =?utf-8?B?ajVESHdJSzFxMUNaZ0JiVEZzUk9XdDBWbGJYNEMrbDNFeFpIdGNRSnhSMWVG?=
 =?utf-8?B?dVFQOUliYU5GTlo1WTBzaFJJRFUrbFFGR1hxdTBWSG1sZGY0WGZWTEE5SlA1?=
 =?utf-8?B?Y0pWeUo2R2JvQ0daTDBQU1VjYlEyK0FuWW1QRG1QU0YrcldXbFA5YkVqQ0xv?=
 =?utf-8?B?Z2o1bWhaY2ZFWEJ4clQrRldwdWhCYm1tTGUyNks5T0FVdU1FbGI1VlU2WDJi?=
 =?utf-8?B?aEp3YlBTMVBwTGtWQjJIeE9lVEl0VERWSTJucW1HRUhQam9BRUFUWDRFeUhm?=
 =?utf-8?B?VlZ4L2l3Y0FGYXFPSDBVR0NpTXhJcHFBSDR1aWhpSUhiVXZrSjhVY3NOTDFL?=
 =?utf-8?B?eDFNbnBDMXlZb1ZaRWxJbnc2THF2NU9zOG9GVDN6QXQrREZVQWh5dFdiRWVZ?=
 =?utf-8?B?TnVTaEs0cE50NEJuZTNKUXlvamc0ZEtkeS9yM3FFWFdxdGdYeEJrTGtPcXM2?=
 =?utf-8?B?QlVGU1pYVTlsQ1RyRHZQWGhLKzhDWkE3ZXFJei8yeHRCVml4K1Q0YzNkdDhn?=
 =?utf-8?B?K1FFeUJCaUduQ1ZrdTY4UzV6YVNlV2lTNmVOMVlaUDJUNGN0TjNSenFOSVRi?=
 =?utf-8?B?VXJuZWpFSzNzK253WndwRS9LcXBVS3htS1pxR2xyMktDQ0FVcW1ZMHVLNTBw?=
 =?utf-8?B?ejhrTXoxU0tIOVVUZmNCd1VMN1V0YVU2TGRpTjA3TXhVTkNoWTVFUkVvRXgv?=
 =?utf-8?B?S200Ykx4R3o2Q3pBdWRDZTg3L0VKWlVENFZ2QXIxVlJGbE16UGg3YlU4N2tE?=
 =?utf-8?B?a2prUVplblZhaXRRajBwaXBKUHRoUG1GOExiK2xLU0dQYmUvNGhoWlM5Z212?=
 =?utf-8?B?eDZwUW92NWxET0dTMXhGcmVKNG5WNjhVbHR5S3NNUVpqdHNGM1RGYzE3R2hk?=
 =?utf-8?B?ZlRieGVGeWhjTVE2c0w4NkZRWVVDSWk3eUpjMWk5NTlzZkhnZ01BNUFYMDlV?=
 =?utf-8?B?WFB2V3pkWVhhQTlVMkM3MEJGUzdQRlM4TG4wMVMwcmJHT0h0UTZnWkt4QkNF?=
 =?utf-8?B?RnJiWVRCQ0EvWnMxL21pY2lrSGkwT01ISHB5NmpjcWV6MnV1Qko5N2ZtMHph?=
 =?utf-8?B?am1RaWhwSFZXaDhiMTdTVEIvZndUanREZlU2YUlPVUZpRlY3R1YxdThKNllU?=
 =?utf-8?B?RUdmYjNqTisvV1piRE51dFFpVG0wcDdBcUlOWEg3cC9wNGRFeUIzYXlyMCtQ?=
 =?utf-8?B?UkxUSXdWbTU2dlZMQUtVYzUwelp5b1djN2F4Q20vdHRVZlA1YXpJSndYdkx5?=
 =?utf-8?B?MmtrTmJRYmR1WjNKY1dmakVyWmI2c2lyZTVzSXJPcDNrRVcyQzVuTVY2WlhV?=
 =?utf-8?B?NVUxampPeGRXcHVPeklvVUhTSEJqQzhUK2NnT1hrTkU0c3hRTmRLWkpoQlVH?=
 =?utf-8?B?emJHZm5LL2dJUlNqUnNsWnEvWlp4THRoNEprOFMyVGFTTVE0Skx0M2tFMXZM?=
 =?utf-8?B?Mm91cEpML0J3Yi9ZQXhnemRvck9MeG1COE1rOVNNdHhXcG53SDJ4TXVWOUdT?=
 =?utf-8?B?aXE1RUJuSXNvd3BmQno5aWEwVjlUb2pqNVVlUEtUL0RHT2s3dGZaMTF3MEQ1?=
 =?utf-8?Q?DkeDdBEtg3BK2dYjtu2pk4SHUFIgdqYYXTWy8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZzFJcUdYbXdicVJlK2U3ZDc0QitkbFpCdHA5aEhwMFlLRGZCc0wrQVgyZGcr?=
 =?utf-8?B?U1VzaW0ycDlNVmNpN0RhRFYrSnE1OWhYbnI4dGl1ZUlrS1pPOFFVSnFKbm95?=
 =?utf-8?B?TkI5MnFKV3ZuRm5ndTJBaXJBcnJvUFpjUk1zZHpzYkJpTEF4VWVJRUEzMTly?=
 =?utf-8?B?anUzUFFTd0pWQ05tTFdpNnQySysyaHBDNlkvbmRZQmpSWWp6YTJRaGRPQ2tQ?=
 =?utf-8?B?RitEcS9iS09ZWnVVdml0cWhvNDJVTmMxczdNU25jUW41V214V3AzQW9vVCto?=
 =?utf-8?B?RHN3Wmp0RE9tcGZKMmQ5dlh6bkZsMEZoU3pldjhmeFlac0lNZmFsaWt0ci9K?=
 =?utf-8?B?K1dYeWVXL1N3bktzYVo0Nzg1OHNvNW9aVitXNy9TT0hMY0tPSGV6VlBYNWdk?=
 =?utf-8?B?VjhydVRUNmdDRHVOUm82UFlPVm0zVUNrYzNNeXgyUG5KNFIxNVNHanNpdTJ3?=
 =?utf-8?B?bGRZZjE4UnIyU1poWUtyVHFkOVJIMXhlbjlrTUxnYnIzUFgxaE10eTcxNUZv?=
 =?utf-8?B?MnFEOHZFRFJ2cWRvZ2JWbWM1VHRzbnpCYXRNTGpCU0dWTHQ3RUpIaFZoTU1w?=
 =?utf-8?B?UWRLUmsyTS9BVmV5aWlDTythd0huMmQxVUI5VzFDRmxTNUVPcGh5M0c1SHVW?=
 =?utf-8?B?MFhqeUJjcTYxMEtBSHlvMlU3SU43TTNZaWlTOVhSNmUvREE1MGt2MVlsMmRk?=
 =?utf-8?B?SjRtdStFZlkwZHNlOXdabGRsVXhpRUxoSExES2Y5ZGl5VDc3M1dVallZelM4?=
 =?utf-8?B?NElHYldmaFRWM3Y4VkZaQjF0VG5LZUdKZXNtWVErWlFqN0NjL1NOOGVCWThY?=
 =?utf-8?B?bnJwOU5xL09Yc0VRYlpvR1dIeG1iZzRFOWVZcFQ1NTNJZ1VmNlEyZ0xKbVBj?=
 =?utf-8?B?OE9adlU0bzNRM1VhZ3FhSE5UY3pJYmVTSHZQZUxxQjUwQml0d1NjbHRPOFgw?=
 =?utf-8?B?eU1HTERPZWt4bVdWYjY0R2ozMlYzQTcrZUdabER4Tm1UR1lySnhFeStGUGpX?=
 =?utf-8?B?OUZkaXNEcXk2MUNTSThBTi9wZlV4RGZrMHJGb3NhdmplMjVnd1ROVDQ3QWpp?=
 =?utf-8?B?V3JFZTdQNGtxSi9CYVRQZzdDY2JxTFdvVjVpNkZuTVd2TU16ZWl4QVo3SWE0?=
 =?utf-8?B?cCtpTG9zNDdxWlBUUmtWQXE1V1h0Z1A4RWluNnZrYVloMlVvRGhwcDRUdnRv?=
 =?utf-8?B?RWwvdzh2dzR1L0VqakZPZG9aS1RYaHRJeFZTUE1qTHZEY1g5WGJZYlh2RE9T?=
 =?utf-8?B?UTI2N2xwZnRVZU4zcHdHZnJvVnkrWk5qc2tnN2M1RnVKT2hYUVd1bkpaazdt?=
 =?utf-8?B?ZXNQVVc0Mml4YUVhcE85Y0pMVUc4VXdGQ1dzbzFRRHo4em4rckZCMUMzOWFu?=
 =?utf-8?B?RXhGZVoxcE5tVE5CUEdEZmowZ1ZaVXdNT0RHeVZHZkpQcS9tZ2d6cFArbHRQ?=
 =?utf-8?B?d0ZUYjBXL2hpMlN4eXJ1bFFrNHdaMUFzdkppTS9VYVFaSkFNMjQrbytTSmIw?=
 =?utf-8?B?aEVoWmJ6Wk8yTFJoeXgwSGZEYlcxNmp1OFQrTmZTSWVVV0NEZWc3NHlQdDFG?=
 =?utf-8?B?NGhIUzBBK3NMcGd6S01CQnNCN2gzNlZCMnhneVJwVHJrYUhkc0dWcjh2eWJR?=
 =?utf-8?B?dHVXSXBpYVVQdVIrNlJyL1Z3bmljMjdqQks2b2lqbW9xRENVTk4ySm52MFpE?=
 =?utf-8?B?em9xalJZZmJaZ2x5Q04xWHNtZlBnZkFmd05JeUNjL2ZCaWhTNjlvNEhZZkFQ?=
 =?utf-8?B?UEJBc1k5dzExTng2N1dvU1NzTkxlUWtNQmYrREg2aEV4VlpEMUxFUzRJVjdl?=
 =?utf-8?B?cjQwYjdyeFRtVjdNd0JHVG80TnJhM3R0RW92RmZxbTg1aC9rYmhCNUxLNkM3?=
 =?utf-8?B?SjA3czBxcFlJZ2g1cWJ6dGVwSlBxN3NvVHJCZWpxTjVpOWE1eXFVTGkyUHVq?=
 =?utf-8?B?YnNndUpWYmJkMTJpWkN6NThraDcralNSUVhDMFd0TWJ0Vy90VEpvRFo3MWpZ?=
 =?utf-8?B?V21PUHFOUHFrWlhYSjZjN3dodURFenl3WUY4Mk10U0Y4QUV3ZHlVWjkxMWJn?=
 =?utf-8?B?RVArZ0hhWVhrZll3eURXTngwUlZqelRFZ3BmY3lEV2hIOVZjdEtZaWNkeWpL?=
 =?utf-8?B?c2NkWVJObXI1T2hkeEx0QzRqMU8zNEdhUGJ3U0lDOC92VzhvK0hEY0FxeVp2?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E96EC96BE287A14C8933974645399245@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g/gSzfwEJqtHZ8xwZzRRfLjYmYS8zjtN3bZ96fHXS+U/95r+bM+ni0aSUr0PUTJCsQ73xdbBljAziufoPjn9+DB3pe/660Pz5Ee220VYm4ZxzMQs13ZsEcuA2xnLXCr9uPxdKgcmsG2KrGRiFlu9jE3s8uUCnAeXSVdLQ2jsy99CAQWRG5i84CMiEqOZtZYamkqB6Ipeyg84AjXMAcJ1mZiywJgTy+oGzUU3y/YA5BPTcW7Tjzs8eVWAutKrJ22rUNeBMnzJ759EbqGIOXOVVZU9klDd6ZGdRzRAXWA53pCAXiWzxteT7OnYRUI16M4gYN4RO02W/SDQUeH4hPILfbMsqEvgRbCuiHC6sjChhIN0XDL6M8LFj9CSJh7GDOKb1KG+4/WESetBeGL+WMVzFeF0wNSsAtF2hNzZ9/e3mAdfN2VF5rL5aDfrHTIgltD5GFe892TI2tTRPFLPgYYdCqO6u05LL9xjEc91cv7b8pzeAMV2xnDtDPHen2epHobhpQgLQk73XxlShybBqUVQh28lGoIx+aEsWYcFJ6Y4Qcst1+QC/Yf7MDN/B2lpMWK2aef24Ijf7dQVMHaEQzZ4Y+GsHTitO4fV7fvk8s+uvTM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e12dd053-2358-46c9-30fd-08dcbad5fb09
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 13:52:18.1973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zh5lHJlNH4+VCAeaT7oKtaAmm+X1f0SEDUVhdcS7tz4cagtcgKAgzjzooaDFsCHKLFtPAZWDjtvOz/w84M9J4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4701
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_04,2024-08-12_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408120102
X-Proofpoint-ORIG-GUID: iN-dRLKH-KUuLylSJ9BQq9WuRAQ7Npk4
X-Proofpoint-GUID: iN-dRLKH-KUuLylSJ9BQq9WuRAQ7Npk4

DQoNCj4gT24gQXVnIDEyLCAyMDI0LCBhdCA3OjM04oCvQU0sIFNhc2hhIExldmluIDxzYXNoYWxA
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBTYXQsIEF1ZyAxMCwgMjAyNCBhdCAwMzo1OTo1
MVBNIC0wNDAwLCBjZWxAa2VybmVsLm9yZyB3cm90ZToNCj4+IEZyb206IENodWNrIExldmVyIDxj
aHVjay5sZXZlckBvcmFjbGUuY29tPg0KPj4gDQo+PiBGb2xsb3dpbmcgdXAgb24NCj4+IA0KPj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbmZzL2Q0YjIzNWRmLTRlZTUtNDgyNC05ZDQ4
LWUzYjNjMWYxZjRkMUBvcmFjbGUuY29tLw0KPj4gDQo+PiBIZXJlIGlzIGEgYmFja3BvcnQgc2Vy
aWVzIHRhcmdldGluZyBvcmlnaW4vbGludXgtNi4xLnkgdGhhdCBjbG9zZXMNCj4+IHRoZSBpbmZv
cm1hdGlvbiBsZWFrIGRlc2NyaWJlZCBpbiB0aGUgYWJvdmUgdGhyZWFkLg0KPj4gDQo+PiBJIHN0
YXJ0ZWQgd2l0aCB2Ni4xLnkgYmVjYXVzZSB0aGF0IGlzIHRoZSBtb3N0IHJlY2VudCBMVFMga2Vy
bmVsDQo+PiBhbmQgdGh1cyB0aGUgY2xvc2VzdCB0byB1cHN0cmVhbS4gSSBwbGFuIHRvIGxvb2sg
YXQgNS4xNSBhbmQgNS4xMA0KPj4gTFRTIHRvbyBpZiB0aGlzIHNlcmllcyBpcyBhcHBsaWVkIHRv
IHY2LjEueS4NCj4gDQo+IDYuNiB3b3VsZCBiZSB0aGUgbW9zdCByZWNlbnQgTFRTLCBhbmQgd2Ug
d291bGQgbmVlZCB0byBoYXZlIHRoaXMgc2VyaWVzDQo+IG9uIHRvcCBvZiA2LjYgZmlyc3QgYmVm
b3JlIHdlIGNhbiBiYWNrcG9ydCBpdCB0byBvbGRlciB0cmVlcyA6KQ0KDQpGYWlyIGVub3VnaCAt
LSBJIHdhcyB0b2xkIHRoaXMgd29yayB3YXMgYWxyZWFkeSBpbiA2LjYueSwgd2hpY2gNCmlzIHdo
eSBJIHN0YXJ0ZWQgd2l0aCB2Ni4xLiBJJ2xsIHRha2UgY2FyZSBvZiBpdC4NCg0KLS0NCkNodWNr
IExldmVyDQoNCg0K

