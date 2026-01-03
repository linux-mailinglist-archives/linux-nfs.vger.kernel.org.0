Return-Path: <linux-nfs+bounces-17422-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DA7CF053F
	for <lists+linux-nfs@lfdr.de>; Sat, 03 Jan 2026 20:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4BE530012C8
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 19:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1BF221721;
	Sat,  3 Jan 2026 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jd4rfPKF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oBBTT5po"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F72DDA9
	for <linux-nfs@vger.kernel.org>; Sat,  3 Jan 2026 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767469596; cv=fail; b=E4WVxbRh2WYCvPJatgJ+V0MClZIt15Z6iDzMRp+WyKncqwRDdq+zdxZT75riBG0PThUM48ofCiXAIQMY2cKa9LBF22EL6da1vIkWp6btl08/6V6B+wqTpq9FqZ/HRWZOs7x2WLwxWaT2kdo/dKUYV9qom4P5LHP66fjhFE4iC/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767469596; c=relaxed/simple;
	bh=G3xcyl1txa2cINhURwRZ9cjCaA3akc63GaiM66mti0s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZY0M6V6WWehUOHmCqWrRoRiCpS3KhDBRvV3eOLPj+cvDtp2P/LIx8PmWrm4Pjx93kZVplgPOcqdvEfCL993Agqe9346emgkKu9h4Cx2S5tsRM76QhsVm3+Jks2IiCCvBaFveuW91KYu7ZQ1kEBAJTniBDnqkDmD6+xJZEItL4aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jd4rfPKF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oBBTT5po; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 603JX9W21764936;
	Sat, 3 Jan 2026 19:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9fVLU14/nKgLTuokp+9QdX0k9dHsd1sxJi09g7Aytao=; b=
	Jd4rfPKFfAUQZonvNphiKWpprML4quZYF8jt9hFY8qi7CMO5SF/MQTFK9C1OycHn
	dFPGX+zf4XpRF3FvkVDqAxEt/RiIkiA1ad/84wwwV1YcraRVFzcfOOzPbXqoOIXc
	qc+AiuLxcv2TT9iVsfa82GnIWJQw6YUjNRlZ62GOz1svMIz8DOF7rK28NWz0AxVh
	0PbAvbG2l4414Jtxl8cUCPVQ4dXN9KXrPyHoxkAHSnQfyR4dkTh8W6n85QgAqusr
	1m7nbFM/RXBy7w7m0AKdy0b+pUQ1TtMP9uWiVt6VNTceJyxc28H5LBVuOthRuJH5
	pWSoW0sg5ra0v4MvDJ2WNw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev6ng9ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Jan 2026 19:46:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 603DJN8Z020375;
	Sat, 3 Jan 2026 19:46:19 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjg5x91-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Jan 2026 19:46:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxNR/OLTZyDE2UZSzjjVHPHy0wqsGAJ1sas5089GDV1rQHGmRW6DJAbEXq8Q2JHUns+bFtszUfkdPDpFr4aKxaaBimXTi2fcP/ibJXPr4aNrkuQUlnIjlsk0vqJCRQTp/tXFDV2SiX7Qn5DQZQ0aLG+TWF9/1Qe9XLwi9Cs5krLWA0kZg9KQMLWni+d0h/B4Ra+Su+65mQmRSAI0AzRphuxCPVBKUjkB/1g2oja+WcrXb+ge2JfUkdGk1EoIdzcZsHxXqswg3x0fCiawWaEpGoSi121g5ijpuqWqz6Gvupb2HMGpvd3KX3qA19LLLRezsypBIlJXbIu4ZSC1xvtUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fVLU14/nKgLTuokp+9QdX0k9dHsd1sxJi09g7Aytao=;
 b=qV8AeM+bggGe0TwcCDJQ83REA5hHOSZ/NRChkcxo/Q5geg0m/GZTI/OaltYwdpoZVgv/FnOI6l/00MKKFIiXa6JuENQHY/o/8WXl9KpP2wQMtfb+IoUFQE3kqU1PEE1hYofymj9tTqYp0fluZOduo1+t95L3sVPH4MTLfwl5cW4COKzKScZLm/b33sSZEflXC+rR1kgXWugiFiZv7zm/Zuh+xPsAi5o7tv5ixndFLLRTCtPGHqyKIFlUobvNzguIFcqmWoEVWj1359XEpW6oDsXSJURne+aOOSpBiMJr3PuBgXGbhP7Tm2/oLF8OT1XZPLFpGS4PlGYGBvawrTerGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fVLU14/nKgLTuokp+9QdX0k9dHsd1sxJi09g7Aytao=;
 b=oBBTT5podXiFDJ77JzvjCaDPht6V8BE20AyAPjmQOonbjGHX9O4m143fH9046e2efBJ5YcNigLwLqbFX81Haa+NKDJ+6la27BQJpdnoLVxGzgwwPPNBCMw8hzGbwu6pDhnUDs/ksZN8zBA+n2mxY7LDckZYx1VTPqiW+P6TdBxM=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DM6PR10MB4137.namprd10.prod.outlook.com (2603:10b6:5:217::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 19:46:17 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 19:46:17 +0000
Message-ID: <49c40532-1d42-4983-b079-d9cadf7e607d@oracle.com>
Date: Sat, 3 Jan 2026 11:46:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] NFSD: Track SCSI Persistent Registration Fencing per
 Client with xarray
To: Chuck Lever <cel@kernel.org>, NeilBrown <neilb@ownmail.net>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
References: <20251227042437.671409-1-cel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <20251227042437.671409-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH2PEPF0000385E.namprd17.prod.outlook.com
 (2603:10b6:518:1::6c) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DM6PR10MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: df687e26-061a-4ff5-84b4-08de4b00c2a1
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Njg2SVlaWjhQWFJZbnRyOXdyeisxSnAvZmhTWkFWemxZaDBQOE5hWHJ5a0F0?=
 =?utf-8?B?QkFFNHJqYWYvaTQvbCtUVm82Q0M2MUx4Y0diakRTMm15M0JoRDd6cUpLNzBR?=
 =?utf-8?B?dkFQcm5Ta1Z6eTRMZ2lpVi9EZ3oxL3U1WVZpLzVMS2swRWpkRVU5WnRvU2hj?=
 =?utf-8?B?WU13dS9tLysvQmthMGV4NGh6QXRJN0xkeVpXWm0rVDJiU2F2QllOSE85dlFI?=
 =?utf-8?B?dVNEQlFWNmpvT2xuYnN3V2gxMXc5MEJ4NjcyMWxCSXNqQUFOY0p1dENYNFcz?=
 =?utf-8?B?VWo5andZSjVQcmFYdUNqS0pBR0w3YVdaa0xOM2podU5xSjlQZmttYi83UmVX?=
 =?utf-8?B?SU1uS2s4dDJLTXJGdzgwc2wvSXIwdFZkOEpucWhvZ0VqT01zTlo3MkIzMjlR?=
 =?utf-8?B?a3BpOE1KSHBGRUdkN05uZVlrb2Y2ZmtmYjkyREFGU1hJYmtaTUVUaG1seFh0?=
 =?utf-8?B?UXRFSG45OGZtOXUwRC8ySjRVczNlYWwxMXhwV0dXZVhqdmZSNlRjeUJHdURi?=
 =?utf-8?B?SHgxL2NkeU9qR2JNNExSMnlDZStPUy9jTWM1UXhvR0VrblBVaDJFT1M2VjJm?=
 =?utf-8?B?b280aHQxUStuWVlpWDVtZzN6cFR4SVFVWm5QU0xNR1M5V1dOTitZakM2N08x?=
 =?utf-8?B?WWJObC9rWngyTGFHdU5CcTlWNlUreFVlVW4wbzlUOWRtMzBZbHVqNFJIN01Z?=
 =?utf-8?B?emdORzQwVzVlYkpDRXZJWVBsa0M2T2F0S015VjlneUc5UVpZeU1qclhFKzFh?=
 =?utf-8?B?WFI2SjlWV2JNMmxGY1djRVlzUE0rSnpJaDZ2bjdWR1NEalBPM3RBblpFeTZD?=
 =?utf-8?B?UlJDL1NOUGY4VlVSeStTNVM2QVNUQjduOHZEdEc3WE5QOFRuQmJybFRnMFpQ?=
 =?utf-8?B?bEJ5ZlhqeHNSY0RvNEJvajJ5SStyaEdKejBLVy80WU5sS1F0eCt6RzI2bHpN?=
 =?utf-8?B?eHRaYWhGcGJMMWh2M2s1VVM5dWMzYkpSdW9PQzVKbHhtcDhmV2dPNUttMEE1?=
 =?utf-8?B?Mkk5S01RZ04xQmt5eWlzNFNRaGZ3Q2EyaUtMYmpnTFhUd1pmQVdMcUZYaTF2?=
 =?utf-8?B?b0djNHFPNmpsS05sOFBGNjRIdXkyUmdOR1NPTGJPQklJRGRJTXRmU3dUOS9w?=
 =?utf-8?B?R2VPeDhKUzRvUkhoTzF0MFNzdDhYcUdOZW9LTmdGaS8rajhYQUQxcmtGbUhl?=
 =?utf-8?B?amQ5Z3JZbjJKSjFtYlVvL3J6UXlRSnNiUTBpanQwZnErYVZqTmU4MnhnK1BG?=
 =?utf-8?B?dmlBVE5FWnBwblJWRUtrM05HZmF3WVZxSEliR1FmQjZ6WUtRdm1nRkRnTVFZ?=
 =?utf-8?B?L2VyMkMwbXZkUnFFZGhvaXJjdlJPOWZHU2M5S3huUE9Pbi8zY2RpUmpYQm1m?=
 =?utf-8?B?WGc2ZGtaVDJYL0NyUFdzMWlkK2dDS3NyV1kzRXViQVpTZ3YrOXJOUlByYS9y?=
 =?utf-8?B?OUNmWnJBOHo1NG52S1FvSGZlamhxWFQ4V0E5aU01a0hxdFYyZjBYcmdWTzhN?=
 =?utf-8?B?eHQ3NllmQUk5MzBsanhKWnZMYWE4d0Z3TDlBUVFZS1oyN0tJc2VaYkxzbUlO?=
 =?utf-8?B?NStRQXdDaGQvWG12R3dmSFRqNjdFdjB1TEVSbHVhM3JlNGZlM3pPaFVIWWxi?=
 =?utf-8?B?eEdMejNkRVBCWTBER2M3M1oxWGNaRFQ3Vlh0TmxjR0h4Q2htdzVocEFVYVJt?=
 =?utf-8?B?d3F2NlBZUW1RTFJKWkdWalpPSnE0RFlOK3g2TVVqQUY3VTZaNElOdUNTOC9a?=
 =?utf-8?B?aDB1SXVMeGhhM2V2Q253N3A0aUVxUWZBN2wwNWZvb2RoeHdlVitXcHRadm4r?=
 =?utf-8?B?ZEhmRk1kN1krZ3hJTTlGMjRjeEJxdnVPTHJINmM0NHRFeGtUNEIxMnRaQ1NR?=
 =?utf-8?B?TkVzYmkvVDdDL3BnYmJlbWNUUkZ3MXV3QmlrdGIrSGJLaUpYb09MaFpFTlhk?=
 =?utf-8?Q?vBCkjpb+gdjiRzuABQjwSvs+8v5UJTg0?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RHpRcFk0S1lhbWY2ck9mTmQyTXNPa1hPN2NWTkJ3NjhhOTRmWkxsd3JQVTVp?=
 =?utf-8?B?Nk5xZ2NLZUwzK0hkS1YxcGRpeHpsQ1VuSVhqVUljTDFweU5oWkQ2Y0hDWnFB?=
 =?utf-8?B?bzJEV3VlQkV5U0FVUy9yRUQxQzJBRnlPekJ2amRxK3A0dEtqVTRHZWJpcFM3?=
 =?utf-8?B?RDJiaTBWSEU3V1FadVQxbnpQVk1Gc0puMVVtT1pFUGxoSU5mS2R0SnFwc3VY?=
 =?utf-8?B?M3FuZzA1VkRuVTlxNkNDYklxUGREdFVqSVdEaEhVbFdtRi9ZUWxiUlNuQzJF?=
 =?utf-8?B?S2U4NU9vQjYvR0wyTkl2L2ozOVd5ZGRSQTdCMUp5eFRNZm9BZ0hsb1J0eHN6?=
 =?utf-8?B?Sm42YWZaM3FLNVF3d05ubTNkTy9pVENkZjJzaEVIK0R6SzNvano1SmJVN1pL?=
 =?utf-8?B?VEVFVTdldmx4YjZCcXVQSDdCM09ld3hPRi9oQlVDcnhra0w5ZGRCN3ZTYi9v?=
 =?utf-8?B?dGdYSlAvOWFHeU9SZzJob0piU2o5MjY1L2YxcW5TMUN4MUgvdXZ3NE0wcFd0?=
 =?utf-8?B?SnhhWE02ZVQvL1JVanZxMk82WmFmZWFYMElvWWppSnFhRkg2eXpBOG9GRmc1?=
 =?utf-8?B?L21KUGg3ZkdTUUZqT0NpTHJwOVI0TlJXUE5UZnk5SGhMR1d2dUI2V0FwekxJ?=
 =?utf-8?B?cUtZN3E1Mm93eGdLV3RIY0hxdWoyMXZ4V1dsVXhNTVVaODlSMnFJWWw0cmpL?=
 =?utf-8?B?QWxXa2MxTVZreGNHc01Bcm1OaFNYUkYyVXppaGpyYmN5dlRFQVBvVUhkU1JT?=
 =?utf-8?B?S25nT0dHNDBFZWh4MHhyWEtEaGV3cEdONG83RjN5cGxTSElvckNFYWJ1L0o4?=
 =?utf-8?B?aFBuaFZzTEU0RS9QeXVxbnNRNDdBRitRNGQ1VWx4NkZYRkhGbStLQ25qQnJv?=
 =?utf-8?B?aXpObERlU2NORS85Snowd0hDYkY4cWJLZXFPaW5wc0pTVjl5ZDMwaHErY0Yx?=
 =?utf-8?B?QUFpQUpIaklEVmxwbzgyWG55czVFcTdvSndaMnlqaVA5VWZscDg1TmFDRGIr?=
 =?utf-8?B?aFJ5d1duY2J0d3NrTFozNFFUOFgxUVJIMEw4NUFCbjVHdVNEcElnUXdRVENo?=
 =?utf-8?B?a3NEZTFWZlk2M0U0SG84M3B2NjJreGJWYlpKcW83WFRhN2oxNHR0eHUvNVN0?=
 =?utf-8?B?c0sxS3UrQ29hWGhaNWMvaGlZWFphZkhDSndhNWV1ZVJFb3J4N0ZNOHBsQ2VR?=
 =?utf-8?B?bDV5dk9sTXFZcWtLYlZjVFMvVkJBaldMWmNKdkZBZjZ0VVpBRjdxOFNHbmpE?=
 =?utf-8?B?cFpselMxZURYZFhVZnNKVXp3Z2NScnZUbjBoUEZtb1FBZXl2K2tVS2JXRG1Z?=
 =?utf-8?B?Yi9CcUpWQWNEcmFsOExUZ2g3L09vb21YN3lRZmdLT3RGdXp1TmRDR0pQSGNr?=
 =?utf-8?B?S3o3eWNQUTc1cnFmODBwaDJpbWVTNmMzZ0hkaWpsUmd5U0s4UFdrTE9iU1JU?=
 =?utf-8?B?NExMZlZwMUJtY2Qvbk43TGlYN2VuMHQxK3lGaTQ2eHl0aTBDdFA5OE1Yakxa?=
 =?utf-8?B?MUU4d29WUUoxQ3k3ZlVUV0xFa3FaSjE2SWlpOVc2OHdwZW5WTEg2UkZtNjkz?=
 =?utf-8?B?elFNSGc3Zy9rQkMyUkdxMDRzNWtxa01sRjJoSU95cGRnOVBOOEVScUpFN1hY?=
 =?utf-8?B?LzNjc3lyZUNSVVVrS1J0NTc2VldNYytiNm9YdEVQcDNmd2V2RU1rM0hmZ3Ax?=
 =?utf-8?B?aE5uOTVyczg0RVJoUndSM00wVzhkQTFieVNKRlFSNHpwYm52N0JJa0JKOHpx?=
 =?utf-8?B?NldUb2VLZk5EUXIweGJvVlNoNE1Fak5jdEtDbzgyZnMrY0wwVFFpOUQzeXd2?=
 =?utf-8?B?Z0w5UmMvZ2RKTWZGcEVjb2hMU3k3b2hkSkFWUE12ODFOMFZXQVZHU3I3QlY1?=
 =?utf-8?B?RWNUMGs1SGsrajRQQXQvMmVzUFc4d0xMVUVwMVM0dFpUZmY2MC8vdWhsdllN?=
 =?utf-8?B?OThyUjMvVGFyZjE5WWtQd3BRUExsNktRNFZlVmtXTTluaGpORXpNQmRTMXpp?=
 =?utf-8?B?SDJmeTY0UGVlOUVUT3V1MTlYZklGdTdGZmZjK2N4QU45TFpmeEhkZEl6cGs4?=
 =?utf-8?B?Nkw0S1FQelUrR3JIYUlpdlp5UVJ2QkZ6NzJ0UDlzbWxlLzhYOHZTUXpyNVp6?=
 =?utf-8?B?OFBqbFhRbW4zZGhvZ2ZqSTNvaytHOU9xaDFCeDFRb042T2dzay94eThrU3d4?=
 =?utf-8?B?WkEyTzJTbmx3RE1NSGRkYVJYOENsOUo3WDlJQTd1OHl1dXFnYjR2UHRYYm16?=
 =?utf-8?B?cDRNMW0rai9jT2V1dHJWd1MzNmpFZHVRT2JFZzhaa2tVajlpeS9GMmI1S1Qr?=
 =?utf-8?B?aWVBaUVlRXJiRHhUTElmM0szQzBKdnRtOEVSRXF6a3hvZ3ZuOVlDUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iunDp+NGSif0yAAfwwbp1Om1ifo/kkvKht3vBroMqYFqR/qMFg4h7T3ElCS96riAkq2RUS9VWdQCYcrH60rWKZVeuYA7ZQ3v5BH4ZFsbt/Jc9zrv+96/hnMM3UBPJ/iNUHpqra5dNny9vYhIEJK0BK5xx1RFmpxLQEaWs2qbhKLGzgQVALpxfS1u1bNhLpcxFxSzScB2cgNTeOKMaTwxq0tbu64NT3mZKCNTLoXRaIXvqOBKGvxeE7VEqLm8H0WmKE2r+lSbvSd9KfzjNuvg7H8KyjHvPS/sKgRfpzrcWxICsQmgTXAZ6RvTi3B92/Ab0RQetHDYcEalN+MNSPXBzATp5b4mIEPIQR1g8iuI8ywdKpJFRlb0IcmQ2ewvosNdBX/XuWWhHERwp6+d2B3LzSQ07U1eF15i/SLN80Ex0C4gQqQg1fD0C+tUl4pEws7uOiIy+efemd0K0kmwN+aD2RL/pjckP4hPdb6bEQy1fW3eqxT8HckonDgDd0OdXDkNg7Q9Ba4oJF7eZo8ZvySuIA41dlZ5Jfiyq++asAWJR5aBiZ9qGQVWO4rVwmyT5SlrmFm70pxID+P/xyAsh6O6oa5IMnYxxUCJJrKQYL76ycU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df687e26-061a-4ff5-84b4-08de4b00c2a1
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 19:46:17.1820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8p7gmepQib+d3T11jqKn5k+OWVin2Q402hVaDsjTf3TC1eG1h6xqJx14ywZKrwBuDOSUcGFjLC/b2BHlaY2DCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-03_04,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601030178
X-Proofpoint-ORIG-GUID: fikS1yq84BJ8UPQAkMfT3Gz9I-GHuQB4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAzMDE3OSBTYWx0ZWRfX0/x78t8MEetK
 Vsd4LO0P8CJznFgBsYY7m0WGrqMaiy7iYdesZ+L1fC0vesKKDyLlSyi4LyQp7kVWyOIU9IL3bgl
 f9od86ccNkSQvlTZQsT8yjo83n6aZa5ebWekcPP4JsMU/GkMLBeMWvElDmp6ibwlc1cCeRVOq5g
 0f5vNWlliSNFyC7Xifs7qlZsdBLQ9WANhtMLoX5/p2QeGmxPQoDlwfeFmq+J6nZYL4oDRfqKEXn
 1ZJbj0DQ6IXnO8V1/eMAzxzcyQBOjlB3CFqX4iur0VyGxAdCrkdNz0GjeP/OknKu5xtgXdG5s0a
 LdZd9vnRM8JM+uhM6BLAI7wKs3wt+YfmxQqRVirA68BwejAQai5e4y6PnVgnXrl/P0KaXeLf62Y
 FBAsLeTM9lRz7QFg4tkhvNPbclV40V41OEdSYeMB9W55RTiVLvqfKt1noGy9Djue0gfT29zDSiO
 GyOu8XqNoUPh3VbMDrGyoWQUKF5jV0zVma1gfwos=
X-Proofpoint-GUID: fikS1yq84BJ8UPQAkMfT3Gz9I-GHuQB4
X-Authority-Analysis: v=2.4 cv=QtFTHFyd c=1 sm=1 tr=0 ts=6959720c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=-LOGL74TESxxC7VvuRQA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12109


On 12/26/25 8:24 PM, Chuck Lever wrote:
> From: Dai Ngo <dai.ngo@oracle.com>
>
> When a client holding pNFS SCSI layouts becomes unresponsive, the
> server revokes access by preempting the client's SCSI persistent
> reservation key. A layout recall is issued for each layout the
> client holds; if the client fails to respond, each recall triggers
> a fence operation. The first preempt for a given device succeeds
> and removes the client's key registration. Subsequent preempts for
> the same device fail because the key is no longer registered.
>
> Update the NFS server to handle SCSI persistent registration fencing on
> a per-client and per-device basis by utilizing an xarray associated with
> the nfs4_client structure.
>
> Each xarray entry is indexed by the dev_t of a block device registered
> by the client. The entry maintains a flag indicating whether this device
> has already been fenced for the corresponding client.
>
> When the server issues a persistent registration key to a client, it
> creates a new xarray entry at the dev_t index with the fenced flag
> initialized to 0.
>
> Before performing a fence via nfsd4_scsi_fence_client, the server
> checks the corresponding entry using the device's dev_t. If the fenced
> flag is already set, the fence operation is skipped; otherwise, the
> flag is set to 1 and fencing proceeds.
>
> The xarray is destroyed when the nfs4_client is released in
> __destroy_client.
>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   fs/nfsd/blocklayout.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>   fs/nfsd/nfs4state.c   |  6 ++++++
>   fs/nfsd/state.h       |  3 +++
>   3 files changed, 52 insertions(+)
>
> V2:
>     . Replace xa_store with xas_set_mark and xas_get_mark to avoid
>       memory allocation in nfsd4_scsi_fence_client.
>     . Remove cl_fence_lock, use xa_lock instead.
> V3:
>     . handle xa_store error.
>     . add xa_lock and xa_unlock when calling xas_clear_mark
> V4:
>     . rename cl_fenced_devs to cl_dev_fences
>     . add comment in nfsd4_block_get_device_info_scsi
>
> V5:
>     . Take a stab at a proper problem statement
>     . Handle failures of pr_register / pr_reserve correctly
>     . Remove usage of possibly stale xa_state data
>     . Avoid looping when pr_preempt fails
>     . Fix usage of #ifdef CONFIG_SCSILAYOUT
>
> Dai, do these changes look OK to you?

Thanks Chuck! it looks fine to me.

-Dai

>
>
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index afa16d7a8013..75bfc8d58d37 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -317,6 +317,7 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
>   	struct pnfs_block_deviceaddr *dev;
>   	struct pnfs_block_volume *b;
>   	const struct pr_ops *ops;
> +	void *entry;
>   	int ret;
>   
>   	dev = kzalloc(struct_size(dev, volumes, 1), GFP_KERNEL);
> @@ -342,6 +343,20 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
>   		goto out_free_dev;
>   	}
>   
> +	/*
> +	 * xa_store() is idempotent -- the device is added exactly once
> +	 * to a client's cl_dev_fences no matter how many times
> +	 * nfsd4_block_get_device_info_scsi() is invoked. This prevents
> +	 * adding more entries to cl_dev_fences than there are devices on
> +	 * the server. XA_MARK_0 tracks whether the device has been fenced.
> +	 */
> +	entry = xa_store(&clp->cl_dev_fences, sb->s_bdev->bd_dev,
> +			 XA_ZERO_ENTRY, GFP_KERNEL);
> +	if (xa_is_err(entry)) {
> +		ret = xa_err(entry);
> +		goto out_free_dev;
> +	}
> +
>   	ret = ops->pr_register(sb->s_bdev, 0, NFSD_MDS_PR_KEY, true);
>   	if (ret) {
>   		pr_err("pNFS: failed to register key for device %s.\n",
> @@ -399,11 +414,39 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>   {
>   	struct nfs4_client *clp = ls->ls_stid.sc_client;
>   	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
> +	struct xarray *xa = &clp->cl_dev_fences;
>   	int status;
> +	bool skip;
> +
> +	xa_lock(xa);
> +	skip = xa_get_mark(xa, bdev->bd_dev, XA_MARK_0);
> +	if (!skip)
> +		__xa_set_mark(xa, bdev->bd_dev, XA_MARK_0);
> +	xa_unlock(xa);
> +	if (skip)
> +		return;
>   
>   	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
>   			nfsd4_scsi_pr_key(clp),
>   			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
> +	/*
> +	 * Reset to allow retry only when the command could not have
> +	 * reached the device. Negative status means a local error
> +	 * (e.g., -ENOMEM) prevented the command from being sent.
> +	 * PR_STS_PATH_FAILED and PR_STS_PATH_FAST_FAILED indicate
> +	 * transport path failures before device delivery.
> +	 *
> +	 * For all other errors, the command may have reached the device
> +	 * and the preempt may have succeeded. Avoid resetting, since
> +	 * retrying a successful preempt returns PR_STS_IOERR or
> +	 * PR_STS_RESERVATION_CONFLICT, which would cause an infinite
> +	 * retry loop.
> +	 */
> +	if (status < 0 ||
> +	    status == PR_STS_PATH_FAILED ||
> +	    status == PR_STS_PATH_FAST_FAILED)
> +		xa_clear_mark(xa, bdev->bd_dev, XA_MARK_0);
> +
>   	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>   }
>   
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 4fb64ada1b64..d8969427fa14 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2382,6 +2382,9 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
>   	INIT_LIST_HEAD(&clp->cl_revoked);
>   #ifdef CONFIG_NFSD_PNFS
>   	INIT_LIST_HEAD(&clp->cl_lo_states);
> +#endif
> +#ifdef CONFIG_NFSD_SCSILAYOUT
> +	xa_init(&clp->cl_dev_fences);
>   #endif
>   	INIT_LIST_HEAD(&clp->async_copies);
>   	spin_lock_init(&clp->async_lock);
> @@ -2538,6 +2541,9 @@ __destroy_client(struct nfs4_client *clp)
>   		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
>   	atomic_add_unless(&nn->nfs4_client_count, -1, 0);
>   	nfsd4_dec_courtesy_client_count(nn, clp);
> +#ifdef CONFIG_NFSD_SCSILAYOUT
> +	xa_destroy(&clp->cl_dev_fences);
> +#endif
>   	free_client(clp);
>   	wake_up_all(&expiry_wq);
>   }
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 508b7e36d846..037f4ccd2e87 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -527,6 +527,9 @@ struct nfs4_client {
>   
>   	struct nfsd4_cb_recall_any	*cl_ra;
>   	time64_t		cl_ra_time;
> +#ifdef CONFIG_NFSD_SCSILAYOUT
> +	struct xarray		cl_dev_fences;
> +#endif
>   };
>   
>   /* struct nfs4_client_reset

