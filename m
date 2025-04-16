Return-Path: <linux-nfs+bounces-11150-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 188F7A90B91
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Apr 2025 20:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD227A455C
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Apr 2025 18:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFAE215F52;
	Wed, 16 Apr 2025 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WAa+Zd/3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Coh6gwtv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1880E10E9
	for <linux-nfs@vger.kernel.org>; Wed, 16 Apr 2025 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744829120; cv=fail; b=i8pBZ0yYC2Ei1Ne4CBpc36nsIspmgTvp82T9vxJArTuWvDsQbO9UfB018D7w07Mn307qWp0dHs8Sh4LHkfyvtJoFbuYHqasMFOPyAUfhRcd65e3IUN3N9QT6xQZcyrASZzMMlR9WMX1fD1Vi/yJC260LI+PL4lBO/RUyL+o75rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744829120; c=relaxed/simple;
	bh=DjsZqpQv5mgIdhKRJK1KodwE9tQzPfu2zR1WBcfwM60=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C44XmKXB7rX/sFhfk6qBlLZEtO+kYiOjyqwL30LoCrptU0e83dzUGx1sY9+3audvVvxjICtur4MfVm2D9Dow4kkm+j9BqniCQHkmki0hlSH8AAJ4YYLj/c8qnXREzb7VKCcQEL39GSMbnnnbM4nPxeA5go+p7SIKRUhVg4+jCt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WAa+Zd/3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Coh6gwtv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GGMqKW006658;
	Wed, 16 Apr 2025 18:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=psi/t3l4LDOmOCtpK4v/syBC7BBQvlCDZX9KsPq6+d4=; b=
	WAa+Zd/3atX+xCYmlJb1W3QoCKVHyLkFz5Zu26sn8K8ZFHExyzVwVkwSzNhRezxr
	N2hLOKk7JvNlOn05ElXG55droSwDk3OzvWbzuKSzb+we1RXMfg19EeVCEHceAV5O
	3ZtJLyxKuMudvNGCP/zZPm353qMQa3b87yWxkd/+4Yg9GpGf08xNDfF6C77Rn+sm
	fWy9t+JZ+tEryJf0XuZsm4ekoawq8RNuI3ir/4U9hfd0VtFz1EDFV3PogkT/vUdF
	qJnnQsB/zvfNxSiFBqHMPnemRwAprN9G+rLrMKAsJ7I4FKWOj9BLmijUsQeKlNOZ
	Rfe26HAUludzUKQTZu2hXA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46185mvptg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 18:45:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53GI0OCV038856;
	Wed, 16 Apr 2025 18:45:13 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012051.outbound.protection.outlook.com [40.93.20.51])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460d4tc8vw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 18:45:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slZF+EehI6611IbCHerIu2lXKy1vc9VTRNpT2g+mBb/2FBndcrY76GQLGpGuriPhamSygABwVwvKTvsQwpN7rngNdVdEqPl5+OV25UORBIm+ykIxdQXyMhGV6UA4jWXdqa8bv/g5RiNTRDG/jmdCrn9x+W+F2nSCP8D2kAL/nV9/6ikPOPgqRu2Y1ygcggc8T0hbRD166D6SMAjQltS4a6hySDh/zQW0L7Xo0jjIbTZroFfFMBsfWWWKUM5jl+jAv/+q7B6CVe6whGPhr1MH1WhnPsBTH7Op1UOwsIg4osYh2sq+0sWIg0HKQO/EYWhcYerPvWkIIam9LR6QNnQJ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psi/t3l4LDOmOCtpK4v/syBC7BBQvlCDZX9KsPq6+d4=;
 b=IQDNTPDmSnKFCAUZd2h8Q4q6HIorB7qHC6k9SwEJoeezXc+KdbRVDKw7bDRP4NJmKcMi05Ofpg9DzaMHj0qzy8RjSZewImUfRCYeJjLNCFFVimUePZjMA7BEqb7QU6GlVawzQX8roCu+V1JWo0MiGUkRzMTl5wozTwZtm4UV2MKwG6KlPOxwJA2EwEL3z9rli0W9svtyLUuV2zggHrJO8sRvuqo8dTR3n+xUlvMIYzHxufAcNRFo1HyPAlaoi/57512oEU7oOOe3XvZzwiL8MKjV8HPSTiey0fLGJ8DM44Cyxl9K0Rn3IgFpxEcO71bPbU3Z6o66XObZe4Yso9jnpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psi/t3l4LDOmOCtpK4v/syBC7BBQvlCDZX9KsPq6+d4=;
 b=Coh6gwtvALPkX4C2qN+Tk+PkYQCc7rvV5vY8sRKhdr99wVx0Yw9dk+bewrez9jn68irAAxa88/++4hJekzPLfd8x4G15n8FQPB5jUhZYaO6GCzX7bmyY7ITj9kLeUQ2fs5ac+fkjeRjUdxpzxZwCAZrTCwoonO6vNBHIYJtipzU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4760.namprd10.prod.outlook.com (2603:10b6:510:3b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 16 Apr
 2025 18:45:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8655.021; Wed, 16 Apr 2025
 18:45:10 +0000
Message-ID: <8a0fc700-c0bc-42b3-b6c2-86a5ed171534@oracle.com>
Date: Wed, 16 Apr 2025 14:45:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] sunrpc: Replace the rq_bvec array with
 dynamically-allocated memory
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20250416152854.15269-1-cel@kernel.org>
 <20250416152854.15269-2-cel@kernel.org>
 <1086d2ecc8fc0aed85fc571e8bc4c66f6ff0fb64.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1086d2ecc8fc0aed85fc571e8bc4c66f6ff0fb64.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4760:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad262da-df39-4e3f-4cff-08dd7d16d105
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?b3F2eExCMmRscE5VRW84Ujk2Zm11Q3BrVmpJb1M2TXREMndydXR3RnpHU1du?=
 =?utf-8?B?aDFselMyNmliYnFnRGsvRmlwSnEzUU9pT2wrYnlJNnFUQ1EvMVRFRVo5aVRa?=
 =?utf-8?B?cXlPQVFMZ2tldkpYVFBGN2NVejFZV3huRDljTGpYMWgwSlJZb2t3UkRmdEJm?=
 =?utf-8?B?QndqdFlsVGlLMzVueXhycUlxcHQ5dHZMaytKUkVRejRxcmFLeXFMTXI1aVIy?=
 =?utf-8?B?QnpoZ3RDU25CTXRhbDd0cUw1dGVSOU9LZlFmSGt1NTk3WEl0RUhxY2locHdo?=
 =?utf-8?B?TFcwUVNTVEJQWkFmeTYzWXV5QXVOL2lsc2RHQ3hEOWFvSDFvQjUyZnJhVmk2?=
 =?utf-8?B?T1hIbkxWaGtaNnFtcW5PcWw1cUdGdDNxYTUyaTd4WlJYNkNtajhyQ0ZCckpB?=
 =?utf-8?B?ZzFpS2dva2JPUlFXcWJlSmhkWk4wazBpTldPbGxrbFh5SHRpbDRWY2hpVDFl?=
 =?utf-8?B?cnNYaHRuMnpRV3ZaWXJTQnhBSVRMRTA4NUhsSnhZVS9QNXlnOXdHakJabkVZ?=
 =?utf-8?B?S2drYjFaQ2JKV0M1RFlvMlRSZzF1Y25lWms4emc4NEo1TG9PQTZ1dzRNekJ1?=
 =?utf-8?B?bVBESVdNVkRTWi9rNzN5bWZ1ZFVyZlVuZkI1dW5xS09lc3gxeUxNaWhvaUt5?=
 =?utf-8?B?d2dYbDVWVFpLTGp3clhsVjFkdmwxb0lZUlI4bFNpRmgxY1cxN0xQcWxTaktz?=
 =?utf-8?B?UE9tUTYvcStkODJsMmh1UHJyZkpRRnZVakJ0RzJKRy9tMWVZVXB4dW9nVDV2?=
 =?utf-8?B?d3ZSWnA1bm9YajZwNXh6UjFzbzNyZFVkQzF0WWVMTVZNN0JOeEhEblFiM2xJ?=
 =?utf-8?B?Z1RSelBkTklkeXU3eE1EYWV0c293aXdxejA2aGphNHRYQm9heTRnOXQ1Q3RU?=
 =?utf-8?B?M1A5eVdVSVQ3N01Ic09aYUl3dDR0NW4wVm5MenJSUlZiUCtpYUQxc0xHb29M?=
 =?utf-8?B?VFI0MXcrNVFRWndocHFFWFdxcW5uV2g4dXBlRzI0UWwvUTFIU2I1TWQ5bkVq?=
 =?utf-8?B?Szh6clZFaVorZ0RXYjdLaXZvTGl0VWhlRzg0Y1Zhb2psbzFsWjZVOVViWk1E?=
 =?utf-8?B?NjkvczRVdklrNWZPczJVVm5nMVF6MThpaExBN0N4bklWSFF5U1lHS1BGQ2JV?=
 =?utf-8?B?cTh1RG5KR2pXc1JpUlVFdDE5UTQ3ZlhVUWZiMGh6NzFZbUhyM1V0OVJvZ0VX?=
 =?utf-8?B?UDd1OUtwb2ErZnE5RHpHN2xlS1dlYU1iSENoUzRmeXJJTFVReHVOdVRpa0pB?=
 =?utf-8?B?ZlJwMHJZMG5sZVZ3NFl5Qjhsang0Y044V3lYTE1lSEgvZ2E2eU1YYThiRGVS?=
 =?utf-8?B?aUFic29QMkxSNnJ3OWhqZndWaEkxZ1pteUpDcytIK01Kc3Z1N2ZpcmFNSXRG?=
 =?utf-8?B?RnNwZndvWXI3UkxYWVFxbFlNZFJ3VWd1TXpSV0w5b2JiRmRFcnFnSWFRZHdv?=
 =?utf-8?B?ckNGTWFNd0FPSkVJL1lKSGlzVlR5K3JrbzdXTUdFbHFNTEdBQzhHQlRGcDFp?=
 =?utf-8?B?VXh3S2lDSUZZTURBVzlackltT1BkOHBlaDFiSFhlTWVwMytybFJvQWZaQ2li?=
 =?utf-8?B?cFlkdDFRR0ltMVV1OUF3WkxrMDc3Tm02U3NUbVpEUmVSMXEvdDkwNERtYzN6?=
 =?utf-8?B?ekJVWXBIb3I2RVVMb3hXRjZuaC95dmlFMFJvVEpnQXZPakZGYS9lN2NKc2x5?=
 =?utf-8?B?dlZZZW10V2phbXpKS05kL2FkNWlBbVhMKzZCT0Z1Mm1nK2tXdXNHYTFpMkdX?=
 =?utf-8?B?UlQxMVNVRjlUR0Rjc2xOQ09zMXM5OEJCa2luYWoyZDFjeGQ5eUFVQldBM202?=
 =?utf-8?B?Y0NRUnBSWS9hSHJVWjlidTJHcUs3SHFMc0tNMS9zM2NPRi9vcXJPWU1keDdE?=
 =?utf-8?B?Nk9zcG14WTlLYUUxQXNDd3lQOHA4L1hUV2NoSnM1NndCSFgwSG9ZdzhSZkJt?=
 =?utf-8?Q?djjjEHTIPqY=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eGRpTkkzZGhWdGlHT0Q5UVFSRU9UU3doem5QUUttWmRGQmVpTFRjbmgyRE5a?=
 =?utf-8?B?ay9YMllMd2NZbWNlQ2R5OGF2K1p3aVZkWm5RSGsyK2t1d2RNRjBmemVJSmpm?=
 =?utf-8?B?czI1WXdQREhpSmgvR080MGgxTkdOL3N5V3dSS2JCRmhGOUtoankyeXhhMVFD?=
 =?utf-8?B?aXhjV0xqRlVmajdlTDRmN3NOQ3FSKzlBTmpUZjhKN0tPMnJJUmdQR1hKVjNi?=
 =?utf-8?B?TE9zOG1uL2Y1MVExejE4Sk5LSC9ubGsvTXRJZ0RNdlh5YkNkY3ltNWVVeFU4?=
 =?utf-8?B?OXpxNnRyVFczdkdLU0xSTkxZRGJkZ1MyUGF4UUcyTFFqUTZFVjBrbDgrZito?=
 =?utf-8?B?WklPMkhwWmUxVUowL2FPZjcwcjU5aURBQkg2b2YzSHNhTVI4RVNPTDN6eGJP?=
 =?utf-8?B?ME93OGFyQkw3aFJMRGpzaDVKelJSOCt3WldLeGJuRGtaNis2NFYyTTJaeURN?=
 =?utf-8?B?dnViL1BpL1UwU1JUb0gvekdhS2VURTA5azRGMG1IbXRwY1pXekdqdExXbUZx?=
 =?utf-8?B?U0h1eG9kQlJsVmQyeCtVdFhaU2JBWTFqRWdCT1hIOGhqbThUSnAyU3RTc1BQ?=
 =?utf-8?B?ck5oWk5DeXNVM0J1QVl1SGFGK2w1OERoWHVtQ0hGMVFqMTZZbG5jdEZkOERN?=
 =?utf-8?B?aVNzcy9wQ2ZNeDM1NWZsMDI0czJhaGwxUVM4NnBMLytrbEc5SmtuY2pVZW1s?=
 =?utf-8?B?QkVIM0ZZVTNNODFwajFmQUc2Uy92SkNQUElVTWZKYzdqSWY1MGp3QXplNWhU?=
 =?utf-8?B?eURYVDBzQjRId3lkN1VWSVlpKzBnUUh6eHVReHFCVksza0tnQXZXTGxYNC9Q?=
 =?utf-8?B?UFVUakZBODdCNHRHVTNwS2JDWXNNZi9ObEhDbU5LOWF6UmhFM0F0M2JWRGQy?=
 =?utf-8?B?SDYyUzZhckVYZ2UrVFBMTTArZkd4YldTMmhudUM4UGJ1OTZ1MzlOSnhwVC9w?=
 =?utf-8?B?Znk0WDl2THpKMGF6RStOQ01sR3A4VVJCWnU4TUlIb3RhenZEUmxEbnhuMHhm?=
 =?utf-8?B?RHY1blA1K1hqSzVlZE5lcVlwRFFvNWtaNTl5UVFUL0gwYXJrK1lOM3YwMDRS?=
 =?utf-8?B?ZlVFSmtjaktLM1hXaUZoNEc3ZmNKY2VXWXNyWDZ2eVY2VnBJbkRNclI0R2dT?=
 =?utf-8?B?ZU9hYmViVUMxb3ZjYWhZZWtpOW5FNHZRb1VtcjZkNlR0c1RmNEp6T1d4a1U4?=
 =?utf-8?B?bHJ0VytReVBqNEpvdE8wKzZDVjBJVWJjYU1qcFlkSW1EWmZ5N0pTMkdlU1lP?=
 =?utf-8?B?SW5iVzUxcXdUZzhldHhlV0V5VXUzd0RZT2NJNGlqWDdzQ3IrTU5mdGhvVjdL?=
 =?utf-8?B?aGdKVWV0Q0dIVjhQeHdrOEw5WEpuenRGdUtCM0pNNXppN1hmL1hwZUJiZFlZ?=
 =?utf-8?B?eWdDZ2VsS1lBQVc1NWYwUVU4YlQ3MWhVYnF4YXcrblZJSzU5SkkySTRzektW?=
 =?utf-8?B?OXNxeVNNRkpWSVVKVy9EVWFqM0tRTmFDUWdSR2Z0S3hGc2t1QjFTcTRHSlN5?=
 =?utf-8?B?bFpYU2gwOFZLT1ByR1V2QVJtYTZRUG5WZlZuTjNEN2JIeXJBZTlqeHJkRFFi?=
 =?utf-8?B?cGhCcUpxWDZDaGdmT2FFYmE0enNYeXA1SDZjTzhHOCtzNHNrRm5CWTF3WFFT?=
 =?utf-8?B?R0l3VVQzL2NRVzkxb0M0elpnNXBYb0t3bU02UHFkb1FxMmhuSmpmeTBWQzVv?=
 =?utf-8?B?TW91SkVXL0JyYUE1TWIyU0k3eDMxTDNQbDNNQXo4OEdwT0kyVzMwZHNYb2VN?=
 =?utf-8?B?VGdCS0JRUmJyZzRscWo5S3hPeXpLRC9pVTJtdklLQmRQSkNJVlFtRXBTV1gz?=
 =?utf-8?B?ZGJGL2NZQzFuRDNtd2tVYmZkd0ZtOEllMzNnRUFJY1FZSnprOHowZHBjV3FM?=
 =?utf-8?B?OXp4TFZhYVd4N3NOTG5IZk9RQlZ3TUxuLzZBaTlITStsQjFBMjlPR2F6Z2R5?=
 =?utf-8?B?N1ovQmp1ZHQ2azFHSi9nRUplSXhuSGxzVWxuMXVoTDJMSGl3Y2lLTExjSFM0?=
 =?utf-8?B?TFFBdWtUZEcrdWlzREc5UkprOWpBaEpreHpzWUNVT0dwdTl3OTQ0YS9iV0xp?=
 =?utf-8?B?aFNCcm1GRGlFL0xPblZ5eG1zZERpM2VNVGQ1Rmk5ZlpkNFY0UVVjK1RoUkVX?=
 =?utf-8?Q?i/31NrlM37TEwxQo2stNJaXkX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ehSwy9mWeZew/7jk9UlNy39cPSIFI8Zh9dA6B6lKVH6lo7qsFPFpQa/yBOYxWyM0akTxNGoK+umHLFGrCjbweiWcWHGnDxiD/9SX5DIutPt53+WR5taSsqDJ9daaRMWRN5DIC4XH41wyuzJoREioeUvjzcUOQuvFLjW4IBP+438RSJrneF3OCXoCRCK09hHIIb2qQuqB3kh28IAzyt5xMwvhE/j8jtsqbe+pZ0P++5dln5uDOTcSL1dnLif6eyDJWbA28csqu9uFSfUh2WyuEU+y6J6tWfaQpafJ6ZYBzsMw2kerVwz6Ftjs2+57RN1u94pNq4a/U77tvWWolzGjLWebJwxcE9fG79GTvJiHCAId0XtgsFG0T4jYYXvVaMzHbKabcfpff4fq0bxr3P0dy6X2ut2GuXL75kXGePy9qbCCVdfeuFedVdNOAx6Lf7NAGgjf2AILWk0/SJqJ6nmzOgE6MfUsctfVbv6I8Q8Vsg7KpvTjQJQKO42gqkcdDvKSurQuqzHCDRQY1S+QZohQE0dPv58D90wt+qGnUS16NM37wfFNELLQYVPybC+wmrbOQ4UxA6yGSODrxnN7lIEQEpELNmu6sbjDXwO2cU9NAMI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad262da-df39-4e3f-4cff-08dd7d16d105
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 18:45:10.6993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uldhJNFHtRIaPUyt9j9kawCUNLagf0yU9LIXHo3E71dc/Dk2nrA5Lvr0IMiBAu3gzX8ueMo76MGRAUAahakEyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_07,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504160153
X-Proofpoint-ORIG-GUID: SSGEyjQDUolExAloDObYed6nnOEHUi2B
X-Proofpoint-GUID: SSGEyjQDUolExAloDObYed6nnOEHUi2B

On 4/16/25 2:42 PM, Jeff Layton wrote:
> On Wed, 2025-04-16 at 11:28 -0400, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> As a step towards making NFSD's maximum rsize and wsize variable,
>> replace the fixed-size rq_bvec[] array in struct svc_rqst with a
>> chunk of dynamically-allocated memory.
>>
>> On a system with 8-byte pointers and 4KB pages, pahole reports that
>> the rq_bvec[] array is 4144 bytes. Replacing it with a single
>> pointer reduces the size of struct svc_rqst to about 7500 bytes.
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  include/linux/sunrpc/svc.h | 2 +-
>>  net/sunrpc/svc.c           | 6 ++++++
>>  net/sunrpc/svcsock.c       | 7 +++----
>>  3 files changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>> index 74658cca0f38..225c385085c3 100644
>> --- a/include/linux/sunrpc/svc.h
>> +++ b/include/linux/sunrpc/svc.h
>> @@ -195,7 +195,7 @@ struct svc_rqst {
>>  
>>  	struct folio_batch	rq_fbatch;
>>  	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
>> -	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES];
>> +	struct bio_vec		*rq_bvec;
> 
> It's a reasonable start.
> 
> What would also be good to do here is to replace the invocations of
> RPCSVC_MAXPAGES that involve this array with a helper function that
> returns the length of it.
> 
> For now it could just return RPCSVC_MAXPAGES, but eventually you could
> add (e.g.) a rqstp->rq_bvec_len field and use that to indicate how many
> entries there are in rq_bvec.

rq_vec, rq_pages, and rq_bvec all have the same entry count (plus or
minus one) so only one new field is necessary. There are a few other
places that allocate arrays of size RPCSVC_MAXPAGES that will need
similar treatment.

Stay tuned for v2.


>>  	__be32			rq_xid;		/* transmission id */
>>  	u32			rq_prog;	/* program number */
>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>> index e7f9c295d13c..db29819716b8 100644
>> --- a/net/sunrpc/svc.c
>> +++ b/net/sunrpc/svc.c
>> @@ -673,6 +673,7 @@ static void
>>  svc_rqst_free(struct svc_rqst *rqstp)
>>  {
>>  	folio_batch_release(&rqstp->rq_fbatch);
>> +	kfree(rqstp->rq_bvec);
>>  	svc_release_buffer(rqstp);
>>  	if (rqstp->rq_scratch_page)
>>  		put_page(rqstp->rq_scratch_page);
>> @@ -711,6 +712,11 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
>>  	if (!svc_init_buffer(rqstp, serv->sv_max_mesg, node))
>>  		goto out_enomem;
>>  
>> +	rqstp->rq_bvec = kcalloc_node(RPCSVC_MAXPAGES, sizeof(struct bio_vec),
>> +				      GFP_KERNEL, node);
>> +	if (!rqstp->rq_bvec)
>> +		goto out_enomem;
>> +
>>  	rqstp->rq_err = -EAGAIN; /* No error yet */
>>  
>>  	serv->sv_nrthreads += 1;
>> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
>> index 72e5a01df3d3..671640933f18 100644
>> --- a/net/sunrpc/svcsock.c
>> +++ b/net/sunrpc/svcsock.c
>> @@ -713,8 +713,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
>>  	if (svc_xprt_is_dead(xprt))
>>  		goto out_notconn;
>>  
>> -	count = xdr_buf_to_bvec(rqstp->rq_bvec,
>> -				ARRAY_SIZE(rqstp->rq_bvec), xdr);
>> +	count = xdr_buf_to_bvec(rqstp->rq_bvec, RPCSVC_MAXPAGES, xdr);
>>  
>>  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
>>  		      count, rqstp->rq_res.len);
>> @@ -1219,8 +1218,8 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
>>  	memcpy(buf, &marker, sizeof(marker));
>>  	bvec_set_virt(rqstp->rq_bvec, buf, sizeof(marker));
>>  
>> -	count = xdr_buf_to_bvec(rqstp->rq_bvec + 1,
>> -				ARRAY_SIZE(rqstp->rq_bvec) - 1, &rqstp->rq_res);
>> +	count = xdr_buf_to_bvec(rqstp->rq_bvec + 1, RPCSVC_MAXPAGES,
>> +				&rqstp->rq_res);
>>  
>>  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
>>  		      1 + count, sizeof(marker) + rqstp->rq_res.len);
> 

-- 
Chuck Lever


