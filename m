Return-Path: <linux-nfs+bounces-8330-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5189E2A46
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 19:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79389BE7D16
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 16:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400DF81ADA;
	Tue,  3 Dec 2024 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hzldaOhn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fKTimJBG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F841E3DF9
	for <linux-nfs@vger.kernel.org>; Tue,  3 Dec 2024 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242370; cv=fail; b=atcQ7P8S/W/SPKHi/XGPF6OpVMGlVjw0CGdg7keuAnOWXuEi2cbDL3D4HEuYrCra0Cvyu1LZ6vyYfKcQjWviehsPEL9SeNYep2Oa8qb0KIqC2BvWjvwX42S64f+Enxj7nrV8+BKpXRlhaCaGTXJaBUyF1rL64qMfrE51tvntZHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242370; c=relaxed/simple;
	bh=bMMYT2lNUTIkO7Qi2iO2OllOfO0O2hx8k75i8rzpU+A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E5Ds6f9JxSU7cFF8P6+36GofGmrxorQp8wCEmAE2SwZdE8oQc+8TTHN1qyUFSz7jYf06Q7rfMgyTu+EoNtGL8g2VYfJFVo/9qxocejZdsxuA4SX6Nge5ePSx4Rnf7fk8sLkKTgy0ssQzLy/cTtn4n7JIn4Bj7ZPUTc1Jbnqpi50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hzldaOhn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fKTimJBG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3F6kYe017988;
	Tue, 3 Dec 2024 16:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bMMYT2lNUTIkO7Qi2iO2OllOfO0O2hx8k75i8rzpU+A=; b=
	hzldaOhnC32wcajz5r0z3kJTYs9T/8rnMCuL1vnt340PS6RnY6FcynFSKWAMZvEL
	lqjGR61Ynwm4no1+njjgviYHTr1CVbyMTfvGrOACpFuAZIypjW77z+K6G6/GAySx
	GyDpqFScTfT3uVos5d1sQmoScIWosY359KdEGa6uhE20gZXxUHsSe6rSf/AMsLaL
	S7NXXHrSNp3Ggf57TEvStcEk0EqU30Ux3KOXf7YxLoBC40mE2I3XAbYFJaCX0GCQ
	TMNn5S5v0f2glSHUBpwRLQvSN3uB/VVmkt/8XPLdysfq/BIp+Gfr5PuQ1DNSBRkK
	eRumNRab/8JVErrC/jciUg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s9yxc85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 16:12:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3FuZCQ000959;
	Tue, 3 Dec 2024 16:12:44 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s585ths-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 16:12:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvIugo0Va9UUBsZQ3cEj34wLzEfKgBccU9rzFZuktxPH2+p3tgsOkbvoz2H8ZKKMlU5EGraL2YyZUKzQPbd7DEdPMdVCtLU7ZxQQf1HfMXLDq6uVzgJBi9XIed995+DuGBpdVLAj7rXPDJsSrh9c18gs+DvAKoWoqOblkanenbyPU9sI/wbiKr/QIDAETz/1CEELosqnByPwotPr9Y1Cav69grNskP8x0ZJcCOyAW8egfPItpMt9a9NCaoabH5z9aj5NI/76Qlbf54ddvioiDY/Yj8qqgvCWUYxeS9XdMVkFpcK5tFyS0GQrK7Ljv6UcxfjZosnTULKw+OgX+DiG6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMMYT2lNUTIkO7Qi2iO2OllOfO0O2hx8k75i8rzpU+A=;
 b=a/mH5OmOYa1VWgM9zq0CErg66UMHYMySijYe0qC7xQ9tbUW0pGlkwX9D3pNKCCINdRwOorD+J33wMIvi/a4BJOnZ/8kWYrWcSVnwr/v2Ld/Wues2IPvzcWu5CUpFJo9vWOp+R0eJ4MRez/27pbd2sT87/gSBGaHdiG7ZLLXg1lH+13+HRpo/RYiIg0aY+WQmypdZh1EMG/lXPGGR8kjtkzDm/9uTgT/7ol54eGDnhLchRNoHYCTQj3C98G8NDskVA9a1+W4Qckrb4nGPNus5bb4UiDfz3iTQZB6HthfRINx/5CLntfb12XyDYQp+YWbhceZgtv1J8IZqbAak/QIyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMMYT2lNUTIkO7Qi2iO2OllOfO0O2hx8k75i8rzpU+A=;
 b=fKTimJBGsjwR/MEqaVLWIhgz5VU4rAmsU+Q2mQafF9kn8d9onL41qCgsQgATZN2886VC9vZLSmqcZsw8fbRjAV/MfRnmfyHd6532YOK/vkCyH/8EpkYDGUUmEHO8d8y+2dFSDeAZF8BDqqMfgOSVMrSHq/nLzdgRemSbp++huhI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6495.namprd10.prod.outlook.com (2603:10b6:806:2b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 16:12:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 16:12:40 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Steve Dickson <steved@redhat.com>
CC: Scott Mayhew <smayhew@redhat.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [nfs-utils PATCH] exports: Fix referrals when
 --enable-junction=no
Thread-Topic: [nfs-utils PATCH] exports: Fix referrals when
 --enable-junction=no
Thread-Index: AQHbRQEiw86raxJWZUWDjDc1ottT+LLT2liAgAC67ACAABorAIAAAtwA
Date: Tue, 3 Dec 2024 16:12:40 +0000
Message-ID: <BFFB8E03-3E4A-43D1-9727-1F5D91E6E9F0@oracle.com>
References: <328fdce3-a66b-4254-a178-389caf75a685@redhat.com>
 <20241202203046.1436990-1-smayhew@redhat.com>
 <6b8990cc-ec29-4e01-acd6-8c7ec6487d99@redhat.com>
 <A47A9D21-EF59-4263-AC63-059FB0661CA8@oracle.com>
 <5bd739e8-e4ed-446a-b443-2554dc20d57c@redhat.com>
In-Reply-To: <5bd739e8-e4ed-446a-b443-2554dc20d57c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6495:EE_
x-ms-office365-filtering-correlation-id: bfff7037-849a-46d5-8658-08dd13b54ff3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U0VhVDM3KzF1SE9Eb3MxNDI3SnNsbHgwSUNHMldacDJ5bHhJNEtvL0Q2Rjh1?=
 =?utf-8?B?THhscG1HZGFzdFZxQ1ZLV0traHl4ZHJqWGtQM2ZPVUI3SzUvK2UrbHhkamJi?=
 =?utf-8?B?dGdueXJaWmJOQXhxL1poYjYyN2hPRGdNQ3ZFOVNGU0toNEJLektwRVp4S09y?=
 =?utf-8?B?K05zNllENkJqTzlPS3hZZ05XRzNnK3g5dEJITG1RUG9VTUZiSHZXZmwzcEt4?=
 =?utf-8?B?cUxqRmdhYU9Ta0lhRWg1dGZyVm5rNXgzWjZzeEp0RHhWUy83SHUzM3FXc1Nw?=
 =?utf-8?B?M1c5YkttaExtdEFGUVp6N1lqazVEOXBUd2xXbEVQaU1OSi9aUzdTOTJBZVdQ?=
 =?utf-8?B?cjJDakRPOW56bk9YMndhb0F3RUJlUkVveXgxdkNOUVJ0aHZNREJiRkxCL2RK?=
 =?utf-8?B?R0NNWWVnZmJsSlhna0ZlQ1JpQWh2MTdzbkxJK3ZIR09RcWR3RTFIS2JiYk5H?=
 =?utf-8?B?TTZDU0NZK253RkRoTmVCMzlUcm9BVkM1NUtPUzNOcTd3VWFzUFVWeXIwVzl3?=
 =?utf-8?B?MEhGdXpWV1Mwejh6ejVvdXJ1VXgvUXRMNEIwZDFZTVVqUWtHRE9iQXNCelRU?=
 =?utf-8?B?WVVkZEFaNGxZdk5IZWZuOUVwbmxsZ09sMG5qcUE4NXJ6ME1DOG5pNHNZQnR5?=
 =?utf-8?B?ME50SDNBV1JCNzJLeWxWeUN4eVdQMitkMjdlZ0JiQWxOUFcxQUhXRi9vczcx?=
 =?utf-8?B?RkxsTFRUWmI1RCsxVWZmODFVYWZLU2VlL2JUSGwySmx1YnhRMmx4eERFaFZ2?=
 =?utf-8?B?MSs3S1hESlp6N1E4d2ZHZ2p2ZUk2TXFxUmJEeVNMQW8vb3VkQXNVM3ZpaWlW?=
 =?utf-8?B?aG9iR21OaTkraFJKTVZWRGlnZDF4c2xpVk5Ra3R4b1ZDcFZEdGl6VEJ1WU1p?=
 =?utf-8?B?NEc3TU5uR3BlMVZZK3Bob2QrWlB4SFBOZWpKeU9JbWNMMlhqVWpwMzR3aWZo?=
 =?utf-8?B?c3ovNmRDbW1GZTRkT09WSTg3ZFBUaFlVQWltbGdiTmZxZDlFZnBGMnh1YkVm?=
 =?utf-8?B?KzVnemJJZThjTWNQZE93c2NYcmFOQldDem5YVUFNdnA0Z2RQdWMveGQvdkJP?=
 =?utf-8?B?VkhQMGRwNmVCZlZTajdUdHN6R1h5MUhveFhKbkJiODJmOEVCSHp2Vm9sbUsx?=
 =?utf-8?B?bHdLWml4VnUvdVVWWXZiN0k0VWtCcTZhdG8rQTkxQ0xwQkJIbEVJWXFaZkN2?=
 =?utf-8?B?YkNWR0FSN0NvL2Fvc2JXZERveFRLZE9OVysreDAydncrRmlHQm9JTUpmVk0x?=
 =?utf-8?B?ZE00TzlzVGRyeG4zSGFiRU9kdEo3eXF2NWxBN2NMY3dSMVBNRHluWGhrU1NG?=
 =?utf-8?B?YzZUOHJDZytqdS8zcCtsRVF1Q3g2TUlGUWwySzUvaWM1ZjRoYy81TVdEMGxm?=
 =?utf-8?B?S1FsbWtodFVkQnczaGxvL3JyM1ZpUGg0TFJHN1M5YXFMcnA0Uy9MWHFsRDh0?=
 =?utf-8?B?ZGhNL003V0txMEw0Tzl3YTBaaGJOamt0c2ZkbDkwSUY3UXNSRERqSWF3Z2FL?=
 =?utf-8?B?Yk9KdUFHRlVuL0Y4YjdyK3NwcjA4NFpHZk91dVJNZU1IekJYVVJnMHNoL1h1?=
 =?utf-8?B?WkpUTlpoRExNZHJLdFl0RnpWbU5ERUFrTjZCL0VBeTlwREtUYU1hWjJzejZj?=
 =?utf-8?B?R3NRVE1KblRJR0p2a2UxYkl4dGU3UTR5T3lLUnlpTHhtVDQzbit2eFNaTXc1?=
 =?utf-8?B?TGhiN3FKM2Uzc0ZYS3Q0MWFIa3plY3NmWDlpSkttTjJOUHJORmdNMUFlb0Fk?=
 =?utf-8?B?MkxUZEVUaUJ6aWIvRGpXVmdrZGhrb0VuU1dVNmwwZE5VUTVZNTdMc1l4dTIz?=
 =?utf-8?B?QWErOUtWKyszMVhoQVJaU1JQbCtPQlV0WFJ5RnVBdHZYSW5kNFc0Q05mQ1Uz?=
 =?utf-8?B?SDBmbTcva2dKbEhwSmg0aHY3U2lPeUc4R29nTWd5VUloalE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZGlUQWMwaG5sODFqc0kyQ2cyTWR4TFhVZGIzYURwWlpsdnBiSTNRc0twUFYr?=
 =?utf-8?B?VzB3K0FySVMxbVJsOTlQb1VqaWZiTkZ0SkZkdGg3cGpaUzlzYTBuLzdGdTVJ?=
 =?utf-8?B?NHZlTGh5cmhKclBDMmVJaWVicDYrdmxvV2NEV0FMT09hWHpZWDFrZjY4bDh6?=
 =?utf-8?B?NllmMjNqMWFCZytPR09lWjBiQ1lNdDk0aTF1MTYwR0Z5WXpMR2MrTms5Q1RQ?=
 =?utf-8?B?MDNhbGhhRmlhbzJMM2NkWXpYeTl1djUxelh0SFFxYW9tY2NUa3l0T0lXZDVu?=
 =?utf-8?B?OXFQamdCdU02L2tXUFdUM3hGckthc0ZKdGNBeTlTZmtqSTBqczI2T0JJcFc1?=
 =?utf-8?B?OVloelAvbktoUmI4eDdzd25VQXAzSldXSlRjblNWb21NcmRsN3c1WEgzanRY?=
 =?utf-8?B?U0xWQXF5NGsvd3U3dWFYSCswN0svbmwrSmpjMFVoTW4rMitOMUpieHpRNFFO?=
 =?utf-8?B?RXdzRzR3NURzKzJ0aDZiY3FrcERyRDh4TkxoRDIvZzhXR0hGY0tpVnd4RkFm?=
 =?utf-8?B?a0MraEVBUmJIUDJ6ZDVFalhNcVZYSFdhVzB5TE51cGY2TkltQWVaaG83QjM2?=
 =?utf-8?B?Z0pXWG1jU0QxZHA3L3JDdHFlN29sOVVkL05jMEdDbVlxTUZsNmdrcEg2MnVF?=
 =?utf-8?B?dkFnaHg4b2RyanFTSnlrdzNCU3ljZnVFcmduVFM5LzAzdjlPUVU0dlpTOUh6?=
 =?utf-8?B?S3FoK25jK1FNeDRYNkpZWXVpTjlqZ1lXQWpKRGNzSkRkRDZxMERpdEQyYXN4?=
 =?utf-8?B?VjV5NTFDY0psVVd1ZXRRcTZKV3NaaU5VYkdFcXh0Y3BmOUE0WVpXblpka2h5?=
 =?utf-8?B?S0dVOWRpcVc5Q0xPRkhHdW54NUVDYUN0SnRUQjRTSW0zUjlxYVNkb3RIdHlP?=
 =?utf-8?B?SlFVanM5QjBRcnRoeGp6dEgzTXd2RWJlSjZkZ1JjaVpVa2pQZncwU0RBcTAw?=
 =?utf-8?B?MHB6Mm50NkI2WFI3TmRsNUFZUGk1SUlCa0tlN0NyRFBiTWlYall1cmdmc1lP?=
 =?utf-8?B?MzBxQ2dLcGhvY2IzNUVZT3J1WVZFVU9vaFM4b1lYOCsvdlpDQVdsNjhiWmt3?=
 =?utf-8?B?VVNubWF0eElLRkVRRUl4c1BXaEc0anBnN1pUWG53ai93cnFYNkNTWFdTc01x?=
 =?utf-8?B?b2dnWG8zM0VwTnpOcHBpL2hsZ3Q2STBjaTdHOG1LdHNvVTY0TzZsS3NPWGw1?=
 =?utf-8?B?RnZaczlLbkVCcDdaZ3ZaWnhuU0E4SmVxUDNJVW5sbWxQZkNjMmZ2cmhta1Vj?=
 =?utf-8?B?SENqRUJoci9SZ00rTUpSWlhkbDdNTlloaUV3VDJIMmpyTXAzYmdLb1prZlk4?=
 =?utf-8?B?WDc4RTVybUQ2WU9BY3Z4NCtGUW5La2tkYktKMXlOTXpWRDdQWE1xSVQvd29r?=
 =?utf-8?B?d3lJeENPS0V0T3RzdVVSZnk2MWZjNlBoYU9URWF5aklDN21kNFRrMG1DY2pX?=
 =?utf-8?B?MXVyV1YwYnRCZTJIYWxEMTdxRDBaTUhRNXRCMTN1eUJPOVNJaWFheUd2WlRx?=
 =?utf-8?B?Q1BZanNZTE9tWExTazl3d3dmT2l3VWlOakxGZXNubE9xY2dOWlhKMGtCWnhO?=
 =?utf-8?B?NkQyTU0vTVRvWGhxUGE1d0FGZWcyTzhoak5kZVdRNFgrTUVuK0tETjRzUXQv?=
 =?utf-8?B?YVNJNEJQc0kvYmhCZDgyL2QzdW5rV09OZHFoZFE2QVd4NUNrM21EQldPanQ2?=
 =?utf-8?B?c1JZUzFVakp4LzlDSzRFS1ZVRWRsQmVsazAzOG44VG1UZ2t1b2RIc2Z0c2hi?=
 =?utf-8?B?V0s1ZlczQWpsTHNBVC82aFdxS2JSQ3BpQldadmllOUlKa2IvUjRhQVpraVhy?=
 =?utf-8?B?UlZMcGJNeTUrV3MzUUJ3VngyZmEyZ0VIV2E5L3VLeWRTdWdxa0ZwQ3VWY0VQ?=
 =?utf-8?B?d3p6NTNqeC9UdE5iT3BxY3pGWVhINXQzZFNFSVJBV1RNL0VuVkE1SE5LOCtS?=
 =?utf-8?B?QnpYU2YxR2tqMCtyclBEVis5b09mMmJLNXhDbFJMVWlsNFNGVWVOVVdMaWpY?=
 =?utf-8?B?dHRHd25ObTRLSDlycVpDdzNRTndoN05BcHRGWW5KVWRzdjFDVDM2MmVUb2tw?=
 =?utf-8?B?Y3hPcExsUEg4d2RFTDJSNmc1YksrQU15MjNmVXMrWXo2NVk0QlphT29NNU9w?=
 =?utf-8?B?RnRPc0ovOEZmN0pOdjNIdjczT0ZzWDNrd3NLZE02aFNRMTVaam1ocHlPWWVL?=
 =?utf-8?B?RHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <649E0C8F31BFCF448CBD3FE331A00F09@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t4jaAPmqkw0r8VoNBReYnI3D+0nPWh9wq3ztwx/k4r7iSWUxHf6DpaoBqik04WZNJ7XxosYSnvabR9FNzV/chk2G6vd+GVCdN49W4d+MV1CQdlSf0btuGNCGdYq31WIjAGciJn2aHzHs1x1jLOv8vQID4Wl7rEEDVQPVkNs+mxFCzUhE3gyCIPeEmqrj1m6oJy7eRJjeSfC4OyiUy1QHchmbwXGnR3RIgnUk3mm0Cv7mVqwFh69CjwlNwaAPrcYjqbXKVWcLsRBhkArU7cf1rwUgWvvrwIxj4c8mDz+QaeYenMy2upQljosUnSQQVU4vBb6/qC/7ViM3lLhLXrVHUGkIxZbagV4yWGSW3sHOlN+ve1IJ/ZsCDCsKG9fPf3+SW9cUO4pPdXRfhBQHgKyfc7yX9jBdY/bzrVeXoqeP/2MY3Mc2jtvT6LrpjpFl0Hn0zcSLiZZ+4RkTa7oitMESONnt4J/vlV7rj9eOGOO5OOmtQbTbucwS5niXlRw6RNBfe08Cf7HxvPufh3uX+lgxwrUi96GAMwgq7wYX6+Kqe7vul2L5nzSKRYRjTqDhMOj/BkZyhEF6LxOENQwpbyYfJHqJuZa2rWj5kQE28vmsa1w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfff7037-849a-46d5-8658-08dd13b54ff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 16:12:40.7166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZ4HQmmvoAacWAjP/C/ZhAmA0Yn6GpgclTkTCjiw9fSkXKkh8WkXak3Q6htfrCvLv05Hodqo6Y8i0pbZrRnEyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6495
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_04,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412030135
X-Proofpoint-GUID: 19ZUJu_Z0GEyuHuKI8crS0-vOrmotHJs
X-Proofpoint-ORIG-GUID: 19ZUJu_Z0GEyuHuKI8crS0-vOrmotHJs

DQoNCj4gT24gRGVjIDMsIDIwMjQsIGF0IDExOjAy4oCvQU0sIFN0ZXZlIERpY2tzb24gPHN0ZXZl
ZEByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IEhleSENCj4gDQo+IE9uIDEyLzMvMjQgOToyOCBB
TSwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4+IE9uIERlYyAyLCAyMDI0LCBhdCAxMDoxOeKA
r1BNLCBTdGV2ZSBEaWNrc29uIDxTdGV2ZURAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4g
SGV5LA0KPj4+IA0KPj4+IE9uIDEyLzIvMjQgMzozMCBQTSwgU2NvdHQgTWF5aGV3IHdyb3RlOg0K
Pj4+PiBDb21taXQgMTVkYzBiZWEgKCJleHBvcnRkOiBNb3ZlZCBjYWNoZSB1cGNhbGxzIHJvdXRp
bmVzIGludG8NCj4+Pj4gbGliZXhwb3J0LmEiKSBjYXVzZWQgd3JpdGVfZnNsb2MoKSB0byBiZSBl
bGlkZWQgd2hlbiBqdW5jdGlvbiBzdXBwb3J0IGlzDQo+Pj4+IGRpc2FibGVkLiAgR2V0IHJpZCBv
ZiB0aGUgYm9ndXMgI2lmZGVmIEhBVkVfSlVOQ1RJT05fU1VQUE9SVCBibG9ja3Mgc28NCj4+Pj4g
dGhhdCByZWZlcnJhbHMgd29yayBhZ2FpbiAodGhlIG9ubHkgI2lmZGVmIEhBVkVfSlVOQ1RJT05f
U1VQUE9SVCBzaG91bGQNCj4+Pj4gYmUgYXJvdW5kIGFjdHVhbCBqdW5jdGlvbiBjb2RlKS4NCj4+
PiBXaHkgbm90IGp1c3QgdGFrZSB0aGUgZW5hYmxlX2p1bmN0aW9uIGNvbmZpZyB2YXJpYWJsZQ0K
Pj4+IG91dCBvZiBjb25maWd1cmUuYWMgYXMgd2VsbD8NCj4+IEl0J3Mgbm90IGdlbmVyYWxseSBn
b29kIHByYWN0aWNlLCBidXQgSSB3aWxsIGJyZWFrIHVwIHlvdXINCj4+IHNlbnRlbmNlIGJlbG93
IHRvIHJlcGx5IHRvIGVhY2ggYml0LiBUaGVyZSBpcyBzb21ldGhpbmcgdG8NCj4+IHVucGFjayBp
biBlYWNoIHBhcnQuDQo+IEkgYWdyZWUgbm90IGJlaW5nIGEgZ29vZCBwcmFjdGljZS4uLiBCdXQg
c29tZXRpbWVzDQo+IGNvbmZpZyBzd2l0Y2hlcyBvdXQgbGl2ZSB0aGVpciB1c2VmdWxuZXNzLi4u
DQo+IEJhc2ljYWxseSB0aGF0J3Mgd2hhdCBJIHdhcyB0aGlua2luZw0KDQpTb21ldGltZXMuIEJ1
dCAtLWVuYWJsZS1qdW5jdGlvbnMgaXMgbm90IHRoZXJlIHlldC4NCg0KDQo+Pj4gSWYgd2Ugd2Fu
dCBqdW5jdGlvbnMvcmVmZXJyYWxzICh3aGljaCBhcmUgdGhlIHNhbWUpDQo+Pj4gSU1ITy4uLg0K
Pj4gSnVuY3Rpb25zIGFuZCByZWZlcj0gYXJlIHJlbGF0ZWQsIGJ1dCB0aGV5IGFyZW4ndA0KPj4g
dGhlIHNhbWUuIEFzIFNjb3R0IGRlbW9uc3RyYXRlZCwgYSBqdW5jdGlvbiBpcyBhIGZpbGUNCj4+
IHN5c3RlbSBvYmplY3QgdGhhdCBzdG9yZXMgTkZTdjQgcmVmZXJyYWwgaW5mb3JtYXRpb24uDQo+
PiBUaGUgInJlZmVyPSIgZXhwb3J0IG9wdGlvbiBzdG9yZXMgdGhhdCBpbmZvcm1hdGlvbiBpbg0K
Pj4gL2V0Yy9leHBvcnRzLg0KPiBJcyB0aGVyZSBhIHBvaW50IHRvIGhhdmUgYm90aCB3YXlzPw0K
DQoicmVmZXI9IiBpcyB0aGUgY2xhc3NpYyB3YXkgb2YgZG9pbmcgdGhpcywgYnV0IHdhcyBhZGRl
ZA0Kb25seSBhcyBhbiBleHBlcmltZW50LCBiYWNrIGluIHRoZSBkYXkuDQoNCkkgYWRkZWQganVu
Y3Rpb24gc3VwcG9ydCBhcyBwYXJ0IG9mIHRoZSBGZWRGUyBlZmZvcnQsIGENCmRlY2FkZSBhZ28u
IEF0IHRoYXQgdGltZSwgd2UgZGVjaWRlZCB0aGF0IGp1bmN0aW9ucywNCnZpYSB0aGUgbmZzcmVm
IGNvbW1hbmQsIHdvdWxkIGJlIHRoZSAib25lIHdheSIuDQoNCldlIGhhdmUgdG8gd2FpdCBmb3Ig
ZGlzdHJvcyB0byBwaWNrIHVwIGp1bmN0aW9uIHN1cHBvcnQNCmJlZm9yZSBkZXByZWNhdGluZyAi
cmVmZXI9IiBiZWNhdXNlIHRoZXJlIGFyZSBzdGlsbA0KYWN0aXZlIHVzZXJzIG9mICJyZWZlcj0i
LiBEZWJpYW4gc3RhYmxlIGlzIG9uZSBvZiB0aGUNCmRpc3Ryb3MgdGhhdCBpcyBibG9ja2luZyB0
aGUgY29tcGxldGUgZGVwcmVjYXRpb24gb2YNCiJyZWZlcj0iLg0KDQpXZSBhbHNvIHdhbnQgYSBi
ZXR0ZXIgbWVjaGFuaXNtIGZvciBrZXJuZWwvdXNlciBzcGFjZQ0KaW50ZXJhY3Rpb24gdG8gZW5h
YmxlIGZ1bGwgc3VwcG9ydCBmb3IgSVB2NiBhZGRyZXNzZXMNCmFuZCBhbHRlcm5hdGUgcG9ydHMg
aW4gcmVmZXJyYWxzLg0KDQpTbywgd29yayBpbiBwcm9ncmVzcy4gV2Ugd2FudCB0byBoYXZlICJv
bmUgd2F5IiBidXQNCnRoZXJlIGFyZSBhbHdheXMgc29tZSByb2FkIGJsb2NrcyB0aGF0IG1ha2Ug
aXQgc2xvd2VyDQp0aGFuIGp1c3QgdG9nZ2xpbmcgYSBzd2l0Y2guDQoNCg0KLS0NCkNodWNrIExl
dmVyDQoNCg0K

