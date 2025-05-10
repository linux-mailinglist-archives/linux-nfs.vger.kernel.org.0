Return-Path: <linux-nfs+bounces-11652-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1CAAB2483
	for <lists+linux-nfs@lfdr.de>; Sat, 10 May 2025 18:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3D0A025F0
	for <lists+linux-nfs@lfdr.de>; Sat, 10 May 2025 16:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9077F72626;
	Sat, 10 May 2025 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aivnluoh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QD13HcLW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DB76125
	for <linux-nfs@vger.kernel.org>; Sat, 10 May 2025 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746892971; cv=fail; b=mKmFWCWfEV4z6TXX6q+r/ePwYvwT0yr0UeCfSuBsNAW6O/5xpaU9GNCJLQ0HvhzF370L3b+8xpZHOPwu+lPiRwZ99mURVhxQv2NAVonw221TkrwHpkIswWzHMTG77NMmzgh9yAH/eS/yDio2m0NTm5LI2FrkXyqp0Nbtpz7Ah1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746892971; c=relaxed/simple;
	bh=kFPm8jZzziA9jSC7Iq10u2plAsQjGUaKJT6fc65JqnE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ow+DMZZtwHWlZ6A9s1Nv4GgQKGQHXh3qSkdewuoUK603KASz06NEEOcHFCb10MCQmIvJEgttwngNG0THQas77suLzI22mcU3xBY7GOc+al9vRxUg52OkuH5IDQ0mZTm3I2wxoqX0PFSR2HJW4JOaiaIxE2cDkYqq6S+Mj5HhpXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aivnluoh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QD13HcLW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54AF02lm024446;
	Sat, 10 May 2025 16:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vaNliQmKd7SZ0v1CVjpTYL+61MCEdjUXVkmU+RI8qhQ=; b=
	aivnluohwolPIulwwLhLB+uvBC3REH0uo0KTl+Nghw7Gr7IEg70I83IJAlFBALkX
	gJRs/Y8l/55E4vm7JQThuGZaCjj/VVUx3uoGGdIH0/2yrcAP7bK3/EPK3k+fEzvL
	6lm0cgrUbVM3z0xyf/WE0ClQSPOkXTH2+ZJ4mcw6yuSvkp+sPzdUphQh5lctzcJH
	sC3ZpaGZ+nd7QHc4cDn1DBbz5IalZ+wjQ+WZTI3XYV+SvYUvFzXYcc+twxf9P4i3
	m1Bcp4i9PLHUy4Lsf6npD8iqilrogshWNyAbmiJkhhSvJdi1OC36PINrbY+LnjMq
	2G8hQtC9uED7KG+9OawwuQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1660a7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 May 2025 16:02:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54AAeGNm002040;
	Sat, 10 May 2025 16:02:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw8cjx67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 May 2025 16:02:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbfwvLdP2XpNpv9ItCBpZq90aFB65eyC2917Pny+1FUNCA1iiVmhhpnqTueqXkRunHnSyMDQfSxJhDUDnk+jGb8QUZ6V37P8eEjz5k8bHSI8ibgDjOFN51TrmUT2PIhznGTbr+OahIzRVSUDhYVjfzCNODTdrYQ+Y0xuFVSAW9lcnLgEBP9LoL6CvWL83gYmhj3XgPitiCf19kFEGIkzHL93mkDWLQBV0a6MAlL6sCBbqgx//+xa1r9zgXwS8KCKXFiUEIIirKm1Y9aaugO9f7zl6NMdm3LjrRwex6e/p5CjkdK3BWsYF/8lOjv/MNIryTu2rWHffGi11yyY05rBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaNliQmKd7SZ0v1CVjpTYL+61MCEdjUXVkmU+RI8qhQ=;
 b=tIbP0tgDJFiF/BIfGtlBG1hcfX752SPwrtrfpuQL/FmWviKRskiq9v+Ep8yZ7923chhb1iwe8BP7ZaIzNZh21jObQAEh/5ooaXkH4wEXldQpVVyk/Q28b3L//dSS4o9+/PxtNhOIYO4dj/InATHNl4+zfeOoEuUzEdKP26tuy4Y4Dp6K4tY9FM69XmSqMlfPWLuhPPt4OFnUDdLEf/tgVfdR0qAkqTT4fv6dkyFh2hhmBE8JX59i7KDU5NQUVC7EtOJDIluhS8z8t1FzF1YQIcrMfvvqf3efUUXPkvJFAS0oPu1i9POCr1Pg1lV5iI9hurLNIWlwYuoUnGXbOyB1WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaNliQmKd7SZ0v1CVjpTYL+61MCEdjUXVkmU+RI8qhQ=;
 b=QD13HcLWOAE8/80oJwa+MUeaIgiNtBMT3c/VRJgkWzQw3inzpa07NCYSVU44h8JRvPwSYfQZu6xxmDYEaBtGso9TaS9NfgC7ius/sVtJeF2EVT/1Shxn9S/kLUqoQZFUu2vRPlMJGY8B2e82VCEHEW5+F0B/QSGQezijDlP8jC4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6540.namprd10.prod.outlook.com (2603:10b6:930:58::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Sat, 10 May
 2025 16:02:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Sat, 10 May 2025
 16:02:29 +0000
Message-ID: <8c8ded94-ea5e-4b12-af2b-72004a988ad5@oracle.com>
Date: Sat, 10 May 2025 12:02:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6 v2] nfs_localio: fixes for races and errors from older
 compilers
To: NeilBrown <neil@brown.name>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        paulmck@kernel.org
References: <20250509004852.3272120-1-neil@brown.name>
 <f540ef6a-705a-4987-87b5-fd6753174289@oracle.com>
 <174684611546.78981.17530209113609371873@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <174684611546.78981.17530209113609371873@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0010.namprd18.prod.outlook.com
 (2603:10b6:610:4f::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: b585f6ed-906b-4fac-121a-08dd8fdc10a0
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?M1BBUVlWcU0ySDhxYXluRzJBcFduY3VjVDRVR1hFcXZCWXQ3OHlaVy8vQW0z?=
 =?utf-8?B?YUJUc2xSTmpwSUtXYks1bEYyb3hjS2ZEL3hwajlxZHlaN09VNzJwR0FmdjNC?=
 =?utf-8?B?SEpZU2JhV2szQVY0aVYzdnZIUU5jYmhvK1AzTjhHcm16WG0vaXh6aVp2ME0x?=
 =?utf-8?B?cTdObzJ6ZkZsdEY4Njh0TXh0cHJJK24yMDYvOGs1eVV3ZWN2RUNyL3h1Nmcy?=
 =?utf-8?B?VzlJeTNPUmtoWjlXWXFwaGRKdHBpakdBTjlLbG5nU3BsOHpGK05CTnRId3lB?=
 =?utf-8?B?dk5NanpUMjNEN2hhWG04N0cyNGU3ZjhEc1dTYVQ2clBmK2FVTjFWMzZ2aDZB?=
 =?utf-8?B?QlJ0MkVoemlZR3JGLzhjcUgySzRDQmdmZE5ZbllPek5NeGRPRmVFYVpjdjAy?=
 =?utf-8?B?UmZGMW1KWkZQWFdjdno0RkJRR21OSCtuQkx6clJ3aFJjT3FPZ3lqdnNwTTZL?=
 =?utf-8?B?Z3M5a2NYbnNRWElrQ3RFL29KVFpIaHowRkk3OUlXZUNkZmNiZVJNR2V3Snps?=
 =?utf-8?B?bEgyZ255Y2F0QS9lRVhLdlNDOVNoV2RsdURHWFgzRDhjVkhySWltdjNibVJM?=
 =?utf-8?B?b0ZpU3VVQU5nUWlPRW14VnJ2Q09wQXBUcldnZUxBUWYrUnY3UGpZa3F6UlBR?=
 =?utf-8?B?dUZPQVZEMW1ZWU5JV1dLKzNFM2tCRjRDNGxkZjAwaDFaalBRYXdtTzhqVGQ1?=
 =?utf-8?B?VzkrRElMR0EzbzBLbDVRVFR1WWRQVEJoMldQU09FeVdRUWJKZVJsSlM0UUly?=
 =?utf-8?B?bXRHODZEREhjdnoyaXZRWXVsRklsL2JiU29qMGszV1FiR2hucWExM3hlUSti?=
 =?utf-8?B?ZkdwUlZmaUdXYVFZNG5sR3IzeWVSN1lLSXEzWURBQThTYUhSSTF6SUE5M243?=
 =?utf-8?B?aG1HK3RuTnExVXBwcFZmb2xDV0V6RjlpSlVLdkZkeFN2VnJQL25OcTRqZ1NU?=
 =?utf-8?B?dmFaWXl0NGh6Tjc5KzZCcnJHaHNjSjYrUkwraTZqUVpPelhWMmMxTExWUlNW?=
 =?utf-8?B?cldZbTU4YlVVMUpERC81b1pOeGFPU094NDd3NURzcGFuZ2tFV3JjZnBGbHVF?=
 =?utf-8?B?bGM1S3EydDRFaUpxd1FsaHIycUJUcGFaQXVpVENKWm9KNlltQkFVT1Q1dXRC?=
 =?utf-8?B?ZEpBWU1HS01rTnMxZFVvbTVHN0VLTEkrTEdUaVNTeGw0WERTYkNMNndncWd0?=
 =?utf-8?B?RGtCcGNJSzJMY3NML05XS09WYVExZnpHQ1Yzd0ZaRnRnN0lLSi8yYXdST1VV?=
 =?utf-8?B?b3IvNW8xZ3pZVmJJalBXM0NNVkhkNUUvS1pmM1lwamNZTnlpbFRpbDlVWnJ5?=
 =?utf-8?B?RHhwaTdCQ3JFZU1oTUhRV0Rmalg5T2NOSkpBUzd6L0dEdCtKVXd4QVEwREdT?=
 =?utf-8?B?T1Iwak91ZDAvRUFkNlE4M3FDVVVBMCtRSjRsbzE0YUxncnZ6MTdrNGlNQndP?=
 =?utf-8?B?OXV1eDdjdHFXaHltTlIvYWlZdWY4Sy9WWW1ZNTBvWmNqcEsxTmdzNHl6bFlE?=
 =?utf-8?B?N1Z3SEN6Z3UxMlUzdGpZQktLNEhSRk4vQ01nMGNpK1pmVVFTaFNyU2orQVhO?=
 =?utf-8?B?WjgxVkYySXAvcklkUWoyb1ZLVVdxODlZVkVRUHQ2RnpYUzBuL1lhc0FmQk1h?=
 =?utf-8?B?eHNlM3EvanlIbTJzUUNUUURBOUVQVTVLQ2JmQXYyZi9WaEN6WlppTStBYm1y?=
 =?utf-8?B?QXdlMnZIeWgzbTlkbnV1b3dBcU1lb2xMb2NGakFxYUNsTVIwalpvNFZVUmxp?=
 =?utf-8?B?eVZPc1FGS25YaDgzc2xzaVgzOFhhMFdDTmpSTFpHN21PaTlYdEtjT2NzWHdL?=
 =?utf-8?B?ZjBGbXUxM044a1RNSXJrVW9PbW1jOG1lb2F1ejk0Yk5BelNObjZrV3kwWHlp?=
 =?utf-8?B?allWYmNtUE5nWm0zN2tZQmxKRnFWK0dDZjhsODVSR3IyUm5pSzBKeFR3L1RF?=
 =?utf-8?Q?qm0VehSzVzk=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TFpsQUhMNG4yUWZtRXpMcEtacXdvbmh1SlBmcmIvNjFwTDFvRklvRUZUVGx5?=
 =?utf-8?B?NmFXejZ0SkFIb2Y0VDdGdDZQVWI0TjZ2RDFob3ZuNENUeU1nVzQvb1BSL2ho?=
 =?utf-8?B?TDdsdHRabXQrdkdLYnJaeWgzaHpmVi9sMVB2aUg1c3hhdmF2VE9WbGJNcHU4?=
 =?utf-8?B?UTI3MFdBVHZ4Q0tiZ0lyTE0wSzlaTDB0VTcva1dMeC94VWFGUnY2Sjc0Lzd5?=
 =?utf-8?B?ZkRQMnJuSkJhUnFYL3BJNGRPQVY5VjJpS2VTTWRnSG9MUy9lbmY3NldTV2g1?=
 =?utf-8?B?YVFsSFB2RVo2YUFmbFBNWmJMMG1GdThsdU9TcFhSZjU4ZGJLM1VtSHRGT0hh?=
 =?utf-8?B?MVlLSE0yZXRnS2FsTlBJcGFnMnNvYXpOOFNhWmE5NE5KazhZeW1BRkkwWWNW?=
 =?utf-8?B?Sm8vVzE4OXJaa0xrSlljcnRIcFJDS0pnaHkyTkpNVVp0eTc4RDRKM3JDRVlt?=
 =?utf-8?B?Y1lnZ1JNSzlsb0JhVWcyY1hpelZwbGx5cUhjRXp6Qkd4M2VIdlJWWVUrMkxI?=
 =?utf-8?B?REVXc3o1RE5BYWRtOWozTDM5YkVaUFYrdUVOMllaNEwzZkdFeXBJbW9YaFNk?=
 =?utf-8?B?YzBvK1hta2FPY3NLYXhyWk9ieC94cTJtWGprQmlKbU1EN2t6STBmNGpOMWh2?=
 =?utf-8?B?Um1WMTlTTHl4dHRESy9WeTg5Zmh1cGFiR0g3UVpvNGhPSXV6L0EzYTFGRTRS?=
 =?utf-8?B?dGs1Q2FxUm0yRUlmbFdrVzRZcFh1MTZzTUlVVVVuWmtKMDJjbml4MmpVV29E?=
 =?utf-8?B?UVczclY4SENpZXdOUTN1SEN0RXlJUE13THBzK1d6ZHJRSXRJNXVkcTBiODdl?=
 =?utf-8?B?ZGg1N2lxc1d3VVZrUlAyU1FMN3pwbmJmczRoZ3kzZ253UEJGZ1JxNDdmQUM0?=
 =?utf-8?B?VHpwYnJtMkV0TjR4UUU5TytKTWtreFdjUGZmMWM4UzBGTVpiaXFWcTlVYWFB?=
 =?utf-8?B?RFIxTXBWR2FuUndFZWN2ZVRBODY0M29CYVRFWkpOMDNOcUJicUhIS3luMWIy?=
 =?utf-8?B?Y0prV0h1N1FPalhNZWlXQUY1ODhzM21uV1dzZUVQRThXZlFMaWpsMWVwS1cz?=
 =?utf-8?B?RHY5bnQ4akxwWlY3YTRrZlVEbkt1NDFFODk5anFxY0w2M015RE9lQjJCYnRI?=
 =?utf-8?B?TndxK0tsTTZLOE1Tb0kwTlA2R3NNeld3eEl6M05VclpMbmJuZXJxQUJVUThC?=
 =?utf-8?B?OTFrWktaS2pKNmNqaHk3YWNtTGxwQm5mSWM1Z050OEl4UE5lOE9YcndTc1R6?=
 =?utf-8?B?T3BpWWZiTjMrQnFjQ25qY25aWTJBbWRselYzaUd5em90T3R1aCtsaS9QRW5y?=
 =?utf-8?B?bWFYTE44TVhseTRoaE1hTHo3ZE1ja2dNaURhZjFBQ0RScEoxTEtLOHlCQmMz?=
 =?utf-8?B?bFlBOUtJblcwT0ZkOVJOR0hvVUZmK1NNYndMQzhsdzBMaDE5ZFA0TllxdWlY?=
 =?utf-8?B?aEdlaEgzazRCbVk5YnZpMDl4ZDE5YmlFamhkMUJna0JKOTdlcnIzQlJTMm1R?=
 =?utf-8?B?cmlyMnpWSzBtcXkyMVFWelcxT29MR3dwemFCZkVzNm5nb1UwZGlxWnA3eTMy?=
 =?utf-8?B?T2JOaVpLWndiWTk2VHdDOUp4aGpDcGh6ejV4eXB1ZmpZMC9hdk02c0FkY2dx?=
 =?utf-8?B?QXNYZWp1cmFKZzBrcDZNNCt5cmYrQnVrZW9PYlJtZGJhTWx4ZzB1azVlYWhm?=
 =?utf-8?B?VlUrRzZka05CVlpLTUZ6TGsvU0xYVmlRQkU3dmUvekM5Tlc0eXBIVmpBd0JL?=
 =?utf-8?B?aVg1anZkdG1wQ25KbHlzcThSL1JYU1hpYUgyRTBINjY2OXVYSU9VT2pUN2JE?=
 =?utf-8?B?YjJ1RWFJajYwMG01UXlmTVg2SjkxTlZITm5PVjFYZkNmaDJDMUZkR0k1ZlRW?=
 =?utf-8?B?VU5HWDduL29hWHpwVnN1c3NUckVCVGRCdEYrTXpodDBHRWtEN25GU29VUkp6?=
 =?utf-8?B?a2QyT3ZIRGp0a3N0SlZoUGtVRFVDRVgyQmhhbHdFdVR1QW1LajhYc1ZSWHNy?=
 =?utf-8?B?OWVnNDQvczNpYjgxZW14MjRXV2tOZm52Z05tRnp3aFZXZGpWZGJoVGR5dmIr?=
 =?utf-8?B?K2dXNit1ZVA1dGcycVVWMXNDek9sOUp0UlVUK3llci9GSnluMHpRQllkTTlS?=
 =?utf-8?B?bUsyZUVrbHhrYVZMRVpxaXNnSzNYc1F4TlJGM2lCRXJJeDZjOExZZjdIVHBp?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ExNCrfM6dIDttdY+WoPinooWQI0lJQIpvs1N1eoxbVWbNAl53bAwCEM0UmETGYB6BKrnotnXfiUrgCty4W8/Axk6Snzv6tCIHEdmVUuNaHwvjtCQsQ81T1QvI7oINMHc9HBDUA+z8d90sp3grg+8xOWNiVzrgAXaAOpzk9wdrA01WImQn3ydi3tk+93zsfv8qNIZmOusEp0apmqAomOLc09aD9Ydrg97iErg+bSGE+bJfXNSWcZFoIN6XXErbq7TCxGSZ6yrat/MZxsxYGbo3YPkd5L25WVmLtdQKeIrz8T6UUykQmYdVZzTXwhq839kgn/jdVe3csMiolmJtM5oP7anUDx+tMVDRUWHPMRsi1Lsy9LbZeLhCBHeUTBLmYX1df3vmeYza2uqzcnJrKr7hW0j/60MBLiLE2eO+xEQkuW/vDaJzdGx/+XTfVnGcYjSAv4xaGEI0y2smoKdZhXcfgZjFTb8zJH8Qzs0Gb1fi6kdqPb/NKin/W9lU1x+eXQoV8/xS58JF6+KQCf34C3Kai3iBH9n7Kb9wZoAN5Uh4ArJaCEOImNsbL6OeqSwRKKu9zd+jgtgJnYbUemDC7TW7JQzaeuUoW0k2pDDKOi3pxA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b585f6ed-906b-4fac-121a-08dd8fdc10a0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2025 16:02:29.2370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvVhiZScNYJoDWosmmRH4H8QZ8r+VOm9zCsojoESmOYN3gtKbSSy6it3tNLuxIa5higv5qUnJhRgoVj0p8834g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6540
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-10_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=799 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505100163
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEwMDE2MyBTYWx0ZWRfX7SlZ+hIDNrRQ CSuieEqe1BxxkpKj5WxbjfSgMy7bkMviLhZ6ns7EWTIXqbk4SY8yDRYsyNf46WYduk2bgYDgkRM e/Op92wPfhR77SUicW31ymk/c5dIQSx0HUwr4aB3yj1duLcXoDMpRJTFkBEqZ1PRpXZioavqmHw
 CV8IvNI27KCBdRAdiYP0Z5LvYeEhtaeL8fvz+aJOirXfM7dVOUnkvemePMh6SuJP3Q5jQLOPFPb ZDWjb9AtqEGiXBmfTKK6ZZGzl3pp+H3SO+rtBsBUxrmuNxfCl+41RU//SX7L2El3KEeuGUoLBBD 9BfBwk+mizrP3pj3oa+VXE2lNWfq/a+Al2ZPXIE06E1xIRbCC0+OBoiDziQSTYjjOzj3sRsOjXk
 V6eEMkp8izWZZwNFw7rxFGcqEijv3jRd3OHkAgEsfusC4wNuvY2iZf7PQHnkOhOv7DEVkxlU
X-Authority-Analysis: v=2.4 cv=VMDdn8PX c=1 sm=1 tr=0 ts=681f7899 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=R88SyDmtfrmK4KR3vmEA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13185
X-Proofpoint-ORIG-GUID: LdfkvsoZw8HfQv8foiBNouYO23sLDFLZ
X-Proofpoint-GUID: LdfkvsoZw8HfQv8foiBNouYO23sLDFLZ

On 5/9/25 11:01 PM, NeilBrown wrote:
> On Sat, 10 May 2025, Chuck Lever wrote:
>> [ adding Paul McK ]
>>
>> On 5/8/25 8:46 PM, NeilBrown wrote:
>>> This is a revised version a the earlier series.  I've actually tested
>>> this time and fixed a few issues including the one that Mike found.
>>
>> As Mike mentioned in a previous thread, at this point, any fix for this
>> issue will need to be applied to recent stable kernels as well. This
>> series looks a bit too complicated for that.
>>
>> I expect that other subsystems will encounter this issue eventually,
>> so it would be beneficial to address the root cause. For that purpose, I
>> think I like Vincent's proposal the best:
>>
>> https://lore.kernel.org/linux-nfs/8c67a295-8caa-4e53-a764-f691657bbe62@wanadoo.fr/raw
>>
>> None of this is to say that Neil's patches shouldn't be applied. But
>> perhaps these are not a broad solution to the RCU compilation issue.
> 
> Do we need a "broad solution to the RCU compilation issue"?

Fair question. If the current localio code is simply incorrect as it
stands, then I suppose the answer is no. Because gcc is happy to compile
it in most cases, I thought the problem was with older versions of gcc,
not with localio (even though, I agree, the use of an incomplete
structure definition is somewhat brittle when used with RCU).


> Does it ever make sense to "dereference" a pointer to a structure that is
> not fully specified?  What does that even mean?
> 
> I find it harder to argue against use of rcu_access_pointer() in that
> context, at least for test-against-NULL, but sparse doesn't complain
> about a bare test of an __rcu pointer against NULL, so maybe there is no
> need for rcu_access_pointer() for simple tests - in which case the
> documentation should be updated.

For backporting purposes, inventing our own local RCU helper to handle
the situation might be best. Then going forward, apply your patches to
rectify the use of the incomplete structure definition, and the local
helper can eventually be removed.

My interest is getting to a narrow set of changes that can be applied
now and backported as needed. The broader clean-ups can then be applied
to future kernels (or as subsequent patches in the same merge window).

My 2 cents, worth every penny.


> (of course rcu_dereference() doesn't actually dereference the pointer,
>  despite its name.  It just declared that there is an imminent intention
>  to dereference the pointer.....)
> 
> NeilBrown


-- 
Chuck Lever

