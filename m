Return-Path: <linux-nfs+bounces-14816-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B019BADB9A
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 17:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0FB16CFFA
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C0E173;
	Tue, 30 Sep 2025 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kAJiXlfd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eFyNLkiF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE10E27B328
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245591; cv=fail; b=AKXmIuDrmJT0rRlMCMFLc4LTo49HbCSmd+rb3hiWkMMX010U1J83WVlWztVQzct8uvwlF2skdOW1EP50zQ49oX6ii4n7CuKQgi3mWYkiMNzHKS26MU8ubuwH3RQrlZgm5uE3MGNmJ2Ybtuqe4L4b73NB8UXbqOSA8U1YEb+/Jdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245591; c=relaxed/simple;
	bh=zG5oxIOM6pnQyq+LvjWTaSboPuyDiQHU4ixVAuM3YKw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tJ5X0ikS3JYobFQZ0FumyVt40aq8QOUNx39qeLALa6dpp2ANJsXBBWONk0Nc1JE0VfGjACvVHL6jtPHhEKOqV8/yLznospYf9llheJq1QVEz97tpXKVS9g2WVmCCNlviTLAXuxgtYpNckFsqCVBwGB+stYvanfDTnIrc+ThgENY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kAJiXlfd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eFyNLkiF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UDTVDn026423;
	Tue, 30 Sep 2025 15:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/FhPvzb6Up7CFEEomthPma+u7rNgHc4gPEE99PHCjp4=; b=
	kAJiXlfdb7k13N1qhH7+OmwooB2hfDjdMePReELNmW45P2StAXZH8CwqnpN6UEcD
	+7kDRxARjtm4Fl40/jaXS0OCkbrq3uhA9V9ofTXPgbAqQHjNJSjGElYulF5vlVbt
	l/1HNq4DiuPnR3nfPEuou1dD83T63avdNUBSBxHdE/VDBaPjBJB/Zfgy8aUju/Df
	4xMbApB/wNaDfF+jCvVGeh/75IK3V5SSIzB7mvTq/k2HV5lvoTCP1JWs9vAlTiA2
	zqIUSWGu4oRoZmU0SVnTxeoYGK1ochijTTMExlnUWuMdjovldesggQHXN9WD4x9Y
	/DSZJzeWDqWuPVAfUFPfkQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gg4r0abh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 15:19:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58UEcHC8027202;
	Tue, 30 Sep 2025 15:19:39 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c7yg0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 15:19:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0Jgho/V8FUS0StyJLRUr/7Q5c0Lfb3qvF9gtmfpLP9ipUEKZNw4D5CFoTJmLbnGsqTD4NQu1YqEnhbK3LM1F+fEodSXlyaL5pxQ1c8hhLr/nGMEZlJ8PcCba9xOufBBBtiP+YiZRP0xgn0RlEmIxrY8XQ3L3OclKgN4n260u9/sI25Sp6TOqaEYEgzeCG13wprWdVao0NB6rcZMHSFgQTGHnwLtYza3LrDk3DbkNapw63HcgL+SMXBbytYia3MZ/bjbCG5Mk9L8AZIQzZHTQPAl895bSVZwR4EIBN0r3shVt1bX2jajTzzjnhTv8v346ArHSavGG+viPMMAQz9n5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FhPvzb6Up7CFEEomthPma+u7rNgHc4gPEE99PHCjp4=;
 b=yKyH9cz8OywLSfXju6brZhA5z6dyxRnV/SG0X+UACvDiUPzOPN56rKSs/eGA6Uzb3tugZpxEvncLBax0Zu2ucAyKLm8AUCLYGaYF/DQj7YJbXOOjukdGPjj7y4JMKP6GolJESRS9KBnkNMAHS5ZViDnQplUXHXd3hJ9Dnr3dBEwij0qO+4PQRojR63GuSWv6ysRtmzigwNdzoRATytocxQs9DobPWyU2a2kHvxSqj7lp5QpVdbQh/3g7Vij3T4TNUc9omcOET+KSqtdCWP2F7a7kaAUHLAM30IoToil8ny1DvUqU7fqSqsSGU2eQpeKPslJVDQ5dcEyIMbRescP17A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FhPvzb6Up7CFEEomthPma+u7rNgHc4gPEE99PHCjp4=;
 b=eFyNLkiFLH5XLdXoKjtgx8Npmp5VXX8oZSFRhaqpoVc9tICxBbZ45PPTDfWnc16Z5xaRs/n4JqjYtGMwlghOHDe5Lose7qQrg/IYPC6RGHoVYCVLX99/dPR5Y0jbsN4wUXQiuQWV5Nj9eMRjMcNwl9btzb44gPFM48H4whCqPvc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH3PPFAF038C41B.namprd10.prod.outlook.com (2603:10b6:518:1::7bf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 30 Sep
 2025 15:19:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 15:19:36 +0000
Message-ID: <0223f915-d85e-4707-89bc-eb6f987d4d67@oracle.com>
Date: Tue, 30 Sep 2025 11:19:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSv4: handle ERR_GRACE on delegation recalls
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
        Trond Myklebust <trondmy@kernel.org>, anna.schumaker@oracle.com,
        linux-nfs@vger.kernel.org
References: <20250811181848.99275-1-okorniev@redhat.com>
 <CAN-5tyEmf9HHMuXHDU86Y5FWYZz+ZYFKctmoLaCAB+DZ1zcXSQ@mail.gmail.com>
 <2b87402379d4c88545dabce30d2877722940f483.camel@kernel.org>
 <CACSpFtC3FbdGS6W6yKKwn+JcFmkSKE8yZRkQzuEWwRjAsZYkWQ@mail.gmail.com>
 <831f2ac457624092dcfadcf8b290fc65dc10e563.camel@kernel.org>
 <CACSpFtAqWdPPCbHLnXKGOmn7bR0fBjS9fj_J=i4aNnL+=8t1zA@mail.gmail.com>
 <CAN-5tyEY17k5SZ6hj2QsgW_006c-0ywS5H5vPvadj80bC0X=7w@mail.gmail.com>
 <f6ba4e9d-98df-46f2-b2fa-8ac832b8ce11@oracle.com>
 <CAN-5tyE+VgWxK6ZT0Ls-5cV53DVrSCBMyd2SLz3PfiC2Z=gyNw@mail.gmail.com>
 <CAN-5tyF+uB8p2NP-q-Z6vp9barr3L=vPYWaRSH5iAQk-VEHKDw@mail.gmail.com>
 <b5b8835d-1c1d-4e3c-ba85-a7a2eb87b61b@oracle.com>
 <CAN-5tyE1X0uEEmVHRz8bxdPs1DR2foA8a7KnRvGPixxK2p0n4g@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyE1X0uEEmVHRz8bxdPs1DR2foA8a7KnRvGPixxK2p0n4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:610:58::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH3PPFAF038C41B:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4d8763-16eb-4310-b3cf-08de0034c3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3dkRmhvQm8rbU1jbW5PS2RmQWNaOW1mTEFMQmp1cStlS2d0OU5saHpQUUFW?=
 =?utf-8?B?WFJyVUI2R0JoVGpEdXUyQ3htVUZURzRJV2Fzb0kwOGo2MG9ZdGQ5aWozMnQ0?=
 =?utf-8?B?WEREWHdrSUpqc0FxMmNZUWNWRUVkYitYS3Y4aGpYaFdDSXhKT2xEcldvMTE2?=
 =?utf-8?B?Sm9ZTTZKZi93WnVkb2ZzUUx4T3VYWVhIOUtmM2tnd0p3M0s5YzF5Uk15c3Nq?=
 =?utf-8?B?S05lV29jcjJtejRVTXhZM3JiNHphSllxeXNBMmZUbUs1bG1pT3V2Qkc4NlV1?=
 =?utf-8?B?S3puY3VVek9CMEpub1AvbFIwWFdKLzRDRFh3ZDduOE82bWowMFBuSjg5bFpn?=
 =?utf-8?B?UzlTSlpRS05PRldjejd3LytXeGZHYVBQenVKaVhjaXJCaUNwRkRpTlJmZVRN?=
 =?utf-8?B?REFrWDdnc2twUkNUTGppeFk5eGtFTzk2UVdIV1JQblhzK3c5R2RTUUlNVEk2?=
 =?utf-8?B?V1VoUFNydXVTTnJvYlJDdUJIdVFaczk2eVZVZVZPemwrTkdHMStFZUFvMEtP?=
 =?utf-8?B?VGpoUWZ1V0hHN0w2b2lWZmNUd2ZVa2ZaWG04ZFZpNHQ4NERUMU9oMUhXVHQ0?=
 =?utf-8?B?SCtuTDMzNDJ0aEM5OWpCdWJNdGlCVGMwaG1aeW8wazFTYm05YjIrWVRyQ1hD?=
 =?utf-8?B?MTlrRDJLc2cxWTNCSkJEV1FTMlZYY3QwSnpUVnVocjl2cmg4UFZab2hSVDRj?=
 =?utf-8?B?bEJWYUxRTExkZSt4azE4eUFNb3VjcEIzZzRsT0VNNDNJaXNVS2VUME0vKysv?=
 =?utf-8?B?b3pKdjF6bGJXUVdZVnVkUmpVUUY3QjhBRmZSS05tKzJ5Rm5pcHFOUnFQTHhG?=
 =?utf-8?B?SjQ5N01wejNMSnBSaEc4QlRTTm5neFJHT0Q3UGpUc3ZNZnAxZUZzRkxWWnRj?=
 =?utf-8?B?YTdFWjlaWmhjSnM4RndHc0d1U0JVSTU2SUxDMjM4ZGFDS0F2ZElXSkNYMVp4?=
 =?utf-8?B?QmxqVCtSZzRpb2dIRHlzVWpibERER1E3UWZ3SG9HNDNrbGRnajRycktUNHNK?=
 =?utf-8?B?WGF1bGdIZFNXMU1PeVAwc0hXTkprSDQ1UjBaSDREVnNqbGpjcm13WEdoSXpV?=
 =?utf-8?B?Y0hEczJoL3M1UWU1MU1qc3UyaDdKbkxhSVN5MXpsZlRFVmpLLzdkeXM4WjUz?=
 =?utf-8?B?RlkxM2lhd2R0VlBVT1hTWUtwVTZpb0NYZFgxSFExa1JwVjdBVWRVZEdJNUNo?=
 =?utf-8?B?dTNNTy9hQ1NMb3lnSVM0aGpjNHc4RWhlLzE1emU0Rksxb0ZUM3NCMFBrblgz?=
 =?utf-8?B?bTFxSzY5TVdhKzdLY0VuUzE0dTRWVE5NTHZnNUR0OU92WkJBQ0xrMHdwNHZn?=
 =?utf-8?B?S0xmSWJiUm1XQ1ZkQ2NEbHlNRlN0L0gyZkxLUHF2UE5ReHVGUkxHTWVEY0VX?=
 =?utf-8?B?S3Z3SXhlS3Z5alpyMkNvalNPWDBBcXdsd0oraDJxQm1oOFMyWXl1TjR1MFhm?=
 =?utf-8?B?TXNURGZjejZpMjNMNkpoSU9hV1RvUnVJTHEvWW9XaFIwYUU3YVpveDJvVGNz?=
 =?utf-8?B?WnFVYkxoc3c1VjJJU2hwSDk0TnZpbTExVmNJcFpHSEViYmFkWFN1OHRjRnE1?=
 =?utf-8?B?RnI4YjNQOXk4cUN2K1BlbTU2RWdOZW1QMGxpNTgyUERBb3ZuTVZleUl0VGRI?=
 =?utf-8?B?SU1xYXJGeVpzYnFlL2VRUmFnMWo4bFVaQ051eCs1eFV2Yk9jZHROWkYxL095?=
 =?utf-8?B?WVZ5emZJVEZlS1pUME1wci9lQ2pMQmRtTk1CUVdmWkxpZ0xIZDNXS2UzVEZM?=
 =?utf-8?B?Sm9SZzFhdENFdkhmQ1BMZXVNaU1oSmNWWFlwSzVvTzhBbTkwdnNhaHArOENV?=
 =?utf-8?B?NzA2MmFuWFB3eTl3R1FpaURlUjN3aG4wRUxLZ216THExdCtTNDB5SUFvUmxQ?=
 =?utf-8?B?VHhIdGZxWnA5N0haZGN0Y2hVcG8zNkx1dngyMTlEOW1EMHVBbFdjZEpJek9D?=
 =?utf-8?Q?VriV5lnu4k6nBaLsu2MABHsBiA92FF62?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZG1iUy9YZVNvRHJoamFHWHhWcXFXTlpRYStiSlI0RmFnclM4djcyb252Q2VX?=
 =?utf-8?B?bDV1YUNZUzU3ODYvRXVvTGN3b1o3VUoxU1BQMHo4RFI1VEEvcGdHdkpVaEUr?=
 =?utf-8?B?blBQd0FLRUhmWi91NTAxay9JdE5PdENuenZ6RFJOL2piemNHSFNtRHZFUXUx?=
 =?utf-8?B?K0hzazZTSzd1VGFFZmVIOHRXRHl3aHVZZGhRQ2hHM0xvQ2h2R0gxUWNKNEFH?=
 =?utf-8?B?TDJodnhiaklsK2paaVdjNWloTzQ4M1hKWW9qdXZ5dUdibkhmelFncTNSZFMv?=
 =?utf-8?B?S0ZxbGYvNWhtbWRld0lsT0xIYlkrSUczYjBYSWllbWZrTWp6UmtTWTVqZ3V1?=
 =?utf-8?B?aG15bUw4eTdqZEwyandraEdYSkNSTWs2dG0rQ25CbUdzMk43QWVIQkFZa0Y4?=
 =?utf-8?B?cmdBem5sSkhxWktYaVBTRjRjVXkwS2wxZUlMaDYvUExVbS9Zek1SWTRkSC84?=
 =?utf-8?B?V2NtSEg2aVIwWlNwb1JHYklVaEV2cWdodE85Y0E2ZVZncWZZOHp1MVdTUUtn?=
 =?utf-8?B?YS9ZOTJXYS9sUm0ycUUwQVJONnpzQk9TdXlZTEJkcmtFMGk5MTdnY1k0UTdo?=
 =?utf-8?B?bVE0dGduV3o1aFZDVWdReHdhSU12aEJpaXdsUm9iSlpVRjVtZDRCNURUYVVh?=
 =?utf-8?B?UytOVkVlQnkyd3EyYVZBVzZ4T0xWbTBUODFjK2Z4YzAxKzJLQ2kyYjY0Qm1x?=
 =?utf-8?B?NEx0eUxjM1RoSElZUHFkcVV1aC9ZdU5qMzk5T21wTFFSOXpLYnR1TkVDNEV5?=
 =?utf-8?B?MnB1ckF5U2w0ejNqNVlDR2RmNG5WZ0ZtcngzOWNpb1BOZ3FiVGFnSU1iSlhk?=
 =?utf-8?B?Y0VtWUhLREk0NlVUcUtOL0NKT0dvUjdpQS9iSU55ZlRHMFQ2d1JlZzJjNk5i?=
 =?utf-8?B?REV1dWhucHcwVFlsd3p4WllZaHhtUnNBQW5UZ1hrWVRVb1c4SFk1TVFIY2Iw?=
 =?utf-8?B?d0dmTlQzOHMvL1lOQXNJOUdySkxjaElPMDZ5YjVZUEJYSW50b2NubVNDT2pE?=
 =?utf-8?B?b3krRUdIaWxmQytHeVhNd1NRcUdINmMxOWY0bEMwcDcwcUZ0ajdVRDI1Ni91?=
 =?utf-8?B?d01SWjJPejljY3BnQjRlQ3R5b3pWaW9XY1NtUUJ0RkIrd25zM3d3YTk5dmQw?=
 =?utf-8?B?Rzdpb3QxV29uUlA0OHVsWjVpaGxxUkZTZk5JVWJTb2xXV1hmMnVYcWxyY0dI?=
 =?utf-8?B?SjRYT1FMUjdsT1NZM3praUJwbS85OWVCV2M1VGtkbXorL2ZsM2JNYTZnejdv?=
 =?utf-8?B?a3ZQcE1GSGkzZGs0L01lYXVZVEJoa1BMbGVXd1Q3bEtqcnBRWU5GMlNuUC9u?=
 =?utf-8?B?amlmc1lUek1hRFBwSjVMa1VHQTZ5TUNjZnRObXFhcEhFWTlxMitGWUh6OEVj?=
 =?utf-8?B?RW9JYjhxRjdndDFGZVdrWTcyZkxMaGg0UHhJTStoN3d6ZThpNHgvakZ1d3l1?=
 =?utf-8?B?NXJtT2orMnpnN2N6WlJWeFRCWkpYeTBJNG9WSjk0UUN3UDE1TEVZRGFOd3Ix?=
 =?utf-8?B?c0phLzNSMmZ4aHRVOGRNNGpybm1SaHh0TE1JcWVKeXZzNE1hcktIZi9HRldr?=
 =?utf-8?B?UHhYUlRaR3VpQ3hmUWlla200SzFrelJmZVRPeFNYSENDaCszQWwvK2JWRi9u?=
 =?utf-8?B?YVNnSytvZUhvSXU1eDZzSEVmcHU2bFFrRGMxZ05TUVVMN25HK2F1VVNPay9L?=
 =?utf-8?B?NTljR0pyZEd2Y2U4ZGFMMDcrcjU2bDdzcFg3T1lPYTErcXNLNlB5ZkdwWWJP?=
 =?utf-8?B?ZzhYelRLQ3ZVbno1UFpPTERsSmQrbDZGU29EbktJVjlDZ3NVa3NjNE1CdzVE?=
 =?utf-8?B?em5sWEYwbCtxTjV0aHd1UmE1eDNBTEJLemxEUEhGMWdSdnVwUktTM0M3Vmxa?=
 =?utf-8?B?UEY1SUVwV1hyeTRLcDJOWE9lWnp3OXdhTlExT2poWXArSUZFT045WTd5OUtZ?=
 =?utf-8?B?T2dLZkpRN09qOGVMTkNwa3NIMDJMRHZqMTh4ZTZmZ0JsazBuQy9zUmkrM003?=
 =?utf-8?B?QjBmRzByVk40MnErdWRzVjNoR1p2dG5uWUVEUjBBOGd5MzRiTG11V1VDQWVo?=
 =?utf-8?B?akxIMWZpLy9QZlRLOWVwSnNtSG5FUHozN3h1aEFPY0lOdFNVNzNGOFFRVjgr?=
 =?utf-8?B?OEYxaDA3Z2tYUElqMXBzWWh1b0t1MzU1b2ZGOEhJc2pmRTJVWUZLU3JDTnNj?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hd25npMDa5zufoWtAdKZ5WY3OlhgxQmsZPWM8pygUjn79TMBy4q4UQL1cXCBF1frofZ1HAHKxkh+knAwN/BzwvIni7tDP5g8/shfLWxThLleaoNH27GkbajGKyTsN5viyxKdFe6G2g0c2wBWsYxqVb6bED99jtWf4eBhxt33SEVuaD1Jd7Ihtj8s0uba9M+EYrhtcbONFcYovC0sUwA5j6NCxZLQsC6Pdd8qjZMVyrfYoTTL4qVcM2FrRJhHdWqcuDGuXlha1Y4vgHSBnfw8TEzmMzo++mwdJAYnron9Q/SI0RSyCocZ7egh6qmVbKmZz2HmqBQHM6ygUeBU1PD/gdBVYfs4HbCPzLOqQj2UH5MX+Tvw5tksVCiWT87+JqBsTB5QV090+IvcQL4h173pQjMmRoVCiBjedDT0xfaSuirxVeDnmP+EkaN4wQWsceg4Ag735XGhWRIAJD6LMsiUrvR0BVAjUPNUtcZZMGxe+/LfmawoOQfXAslhO0kNczrJsG4IfBbz4vts4xd2nJBm5skSH/0z9CWo1VoDR70+uXP3ubB5U5IbGUuLFTTVkTIhhg2RlyXMrye5ZkVf7n5hRtKZ+qWm7JY/ILTGScKW2J8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4d8763-16eb-4310-b3cf-08de0034c3ed
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 15:19:35.9911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXRVAQK7H3ZZgmNI4RRYZ7i/1sSI7QMbxfcnhw5L35Pppbo2M3mHCrIogtsUk7PDxn6uX/VEgo50V076wcqBJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFAF038C41B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300137
X-Authority-Analysis: v=2.4 cv=Qbxrf8bv c=1 sm=1 tr=0 ts=68dbf50c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=VwQbUJbxAAAA:8 a=ks1KcbvIfVZoqikZ6SoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ID_c4kZ8z_y32ru0V5jsa2plsLr-7Irf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDEyMCBTYWx0ZWRfX1KHVymJdS40e
 N2VCr3tIMKoplc6t0Y0kPBF/Pzfwh3HSyUwi1xCZBETU3wgmYvUM3T5jI2Lho6teagoNUcPCTmM
 WL1fO9vsLJ8lEa6qskJojiZrzMal927wntq+leQm+yXXzdjtAmkcEu6dVZtBeBj3ZLWPZRFZ640
 zN9nQn725cxbe9l43GCBU/7ITpRJRVC4caVzshwXuJKY/zfUubnhqoa1BbIZsA69iMp6x1RzXuB
 u2CXu7Vos8kgOLO9mMS9fb/mYnbvDQDySz06ptseskbiIjhHjDzos/6A/A+wtmu/qTc5r7+l+Jd
 ImB826OwzsHlDxU9q/d9a0IZx4KVAL9M7dG1WeP1StSnrPzYazqSgLnMuOWqkVoBXvczbYOulRm
 WsX67eLpENfMB2kO6M6QhXatWseSXQ==
X-Proofpoint-ORIG-GUID: ID_c4kZ8z_y32ru0V5jsa2plsLr-7Irf

On 9/30/25 10:56 AM, Olga Kornievskaia wrote:
> On Tue, Sep 30, 2025 at 10:37 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 9/30/25 10:32 AM, Olga Kornievskaia wrote:
>>> On Tue, Sep 30, 2025 at 10:29 AM Olga Kornievskaia <aglo@umich.edu> wrote:
>>>>
>>>> On Tue, Sep 30, 2025 at 10:02 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>>
>>>>> On 9/29/25 1:49 PM, Olga Kornievskaia wrote:
>>>>>> On Fri, Sep 12, 2025 at 12:04 PM Olga Kornievskaia <okorniev@redhat.com> wrote:
>>>>>>>
>>>>>>> On Fri, Sep 12, 2025 at 11:11 AM Trond Myklebust <trondmy@kernel.org> wrote:
>>>>>>>>
>>>>>>>> On Fri, 2025-09-12 at 10:41 -0400, Olga Kornievskaia wrote:
>>>>>>>>> On Fri, Sep 12, 2025 at 10:29 AM Trond Myklebust <trondmy@kernel.org>
>>>>>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>> On Fri, 2025-09-12 at 10:21 -0400, Olga Kornievskaia wrote:
>>>>>>>>>>> Any comments on or objections to this patch? It does lead to
>>>>>>>>>>> possible
>>>>>>>>>>> data corruption.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Sorry, I think was travelling when you originally sent this patch.
>>>>>>>>>>
>>>>>>>>>>> On Mon, Aug 11, 2025 at 2:25 PM Olga Kornievskaia
>>>>>>>>>>> <okorniev@redhat.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> RFC7530 states that clients should be prepared for the return
>>>>>>>>>>>> of
>>>>>>>>>>>> NFS4ERR_GRACE errors for non-reclaim lock and I/O requests.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>>  fs/nfs/nfs4proc.c | 4 ++--
>>>>>>>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>>>>>>>>>>> index 341740fa293d..fa9b81300604 100644
>>>>>>>>>>>> --- a/fs/nfs/nfs4proc.c
>>>>>>>>>>>> +++ b/fs/nfs/nfs4proc.c
>>>>>>>>>>>> @@ -7867,10 +7867,10 @@ int nfs4_lock_delegation_recall(struct
>>>>>>>>>>>> file_lock *fl, struct nfs4_state *state,
>>>>>>>>>>>>                 return err;
>>>>>>>>>>>>         do {
>>>>>>>>>>>>                 err = _nfs4_do_setlk(state, F_SETLK, fl,
>>>>>>>>>>>> NFS_LOCK_NEW);
>>>>>>>>>>>> -               if (err != -NFS4ERR_DELAY)
>>>>>>>>>>>> +               if (err != -NFS4ERR_DELAY && err != -
>>>>>>>>>>>> NFS4ERR_GRACE)
>>>>>>>>>>>>                         break;
>>>>>>>>>>>>                 ssleep(1);
>>>>>>>>>>>> -       } while (err == -NFS4ERR_DELAY);
>>>>>>>>>>>> +       } while (err == -NFS4ERR_DELAY || err == -
>>>>>>>>>>>> NFSERR_GRACE);
>>>>>>>>>>>>         return nfs4_handle_delegation_recall_error(server,
>>>>>>>>>>>> state,
>>>>>>>>>>>> stateid, fl, err);
>>>>>>>>>>>>  }
>>>>>>>>>>>>
>>>>>>>>>>>> --
>>>>>>>>>>>> 2.47.1
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Should the server be sending NFS4ERR_GRACE in this case, though?
>>>>>>>>>> The
>>>>>>>>>> client already holds a delegation, so it is clear that other
>>>>>>>>>> clients
>>>>>>>>>> cannot reclaim any locks that would conflict.
>>>>>>>>>>
>>>>>>>>>> ..or is the issue that this could happen before the client has a
>>>>>>>>>> chance
>>>>>>>>>> to reclaim the delegation after a reboot?
>>>>>>>>>
>>>>>>>> To answer my own question here: in that case the server would return
>>>>>>>> NFS4ERR_BAD_STATEID, and not NFS4ERR_GRACE.
>>>>>>>>
>>>>>>>>> The scenario was, v4 client had an open file and a lock and upon
>>>>>>>>> server reboot (during grace) sends the reclaim open, to which the
>>>>>>>>> server replies with a delegation. How a v3 client comes in and
>>>>>>>>> requests the same lock. The linux server at this point sends a
>>>>>>>>> delegation recall to v4 client, the client sends its local lock
>>>>>>>>> request and gets ERR_GRACE.
>>>>>>>>>
>>>>>>>>> And the spec explicitly notes as I mention in the commit comment that
>>>>>>>>> the client is supposed to handle ERR_GRACE for non-reclaim locks.
>>>>>>>>> Thus
>>>>>>>>> this patch.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Sure, however the same spec also says (Section 9.6.2.):
>>>>>>>>
>>>>>>>>    If the server can reliably determine that granting a non-reclaim
>>>>>>>>    request will not conflict with reclamation of locks by other clients,
>>>>>>>>    the NFS4ERR_GRACE error does not have to be returned and the
>>>>>>>>    non-reclaim client request can be serviced.
>>>>>>>>
>>>>>>>> The server can definitely reliably determine that is the case here,
>>>>>>>> since it already granted the delegation to the client.
>>>>>>>
>>>>>>> I'll take your word for it as I'm not that versed in the server code.
>>>>>>> But it's an optimization and hard to argue that a server must do it
>>>>>>> and thus the client really should handle the case that actually
>>>>>>> happens in practice now?
>>>>>>>
>>>>>>>> I'm not saying that the client shouldn't also handle NFS4ERR_GRACE, but
>>>>>>>> I am stating that the server shouldn't really be putting us in this
>>>>>>>> situation in the first place.
>>>>>>>> I'm also saying that if we're going to handle NFS4ERR_GRACE, then we
>>>>>>>> also need to handle all the other possible errors under a reboot
>>>>>>>> scenario.
>>>>>>>
>>>>>>> I don't see how the "if" and "then" are combined. I think if there are
>>>>>>> other errors we don't handle in reclaim then we should but I don't see
>>>>>>> it's conditional on handling ERR_GRACE error.
>>>>>>
>>>>>> What's the path forward here?
>>>>>
>>>>> I saw something earlier in the thread that caught my eye.
>>>>>
>>>>> It looked like you said that, while NFSD is in grace, it allowed a
>>>>> client to acquire an NLM lock and that triggered the delegation recall.
>>>>> It seems to me that, because it was in grace, NFSD should not have
>>>>> allowed the creation of a new lock; it should have returned nlm_grace.
>>>>>
>>>>> Did I read that incorrectly?
>>>>
>>>> NFSD did not allow for the creation of a new lock.
>>>>
>>>> NFSD got a v3 lock request which triggered a delegation recall (while
>>>> in grace). nfsd v3 call (with the patch a082e4b4d08a "nfsd:
>>>> nfserr_jukebox in nlm_fopen should lead to a retry" no longer fails
>>>> the request) drops the reply forcing the client to retry. Please
>>>> recall that I was advocating for an additional fix where the server
>>>> goes a step further and returns nlm_lck_denied_grace_period but it was
>>>> not accepted. But that wouldn't have helped the current problem.
>>>>
>>>> Because the delegation is triggered, the client sends a reclaim lock
>>>> (but the client already sent a reclaim_complete, as it reclaimed the
>>>> open and gotten a delegation) so this is a "new" lock and the server
>>>> returns ERR_GRACE. Client does not handle this error and instead acts
>>>> like it got the lock and thus silent corruption.
>>>>
>>>> The proposed patch is to handle ERR_GRACE error while reclaiming
>>>> delegation state.
>>>>
>>>
>>> To clarify there are 2 clients: v3 client (making a new lock request)
>>> and v4 client that holds a delegation (and a local lock).
>>
>> I'm still confused about the procession of events. Namely, whether a
>> delegation recall was done while the server was still in grace.
> 
> Yes. Delegation recall is done while the server is in grace.
> 
>> Could you provide a ladder diagram showing the interactions, in steps?
> 
> I'm not sure I can do a ladder diagram but let me try to lay out steps.

Thanks, this works.


> 1. v4 client sends open (foo) and gets a delegation.
> 2. v4 client locally locks the file.
> 3. server reboots. grace starts.
> 4. v4 client sends reclaim open for "foo" and gets a delegation in reply.
> 5. v4 client sends reclaim_complete
> 6. v3 client sends NLM lock for "foo".
> as a result of  step 6 there are 2 actions happen on the server
> (a) server sends cb_recall to v4 client

It's arguable whether the server should prepare to allow the acquisition
of a new lock during its grace period. It might be overall friendlier
behavior if the server did not recall the delegation until grace is
complete for all clients, since it's not supposed to allow new non-
reclaim locks.

I guess it doesn't rise to the category of bug, though.


> (b) drops NLM lock request for v3 client (so that that the v3 client retries)
> 7. v4 client sends (non-reclaim) lock request to the server . Server
> replies ERR_GRACE.
> --> this is where the client doesn't retry but assumes it got the lock.
> 8. client sends delegreturn.

That seems like an overt client bug to me. The client should not return
its delegation until the LOCK request has succeeded.


> ... if we let this play out. the v3 client which keeps resending NLM
> lock request will get the lock once the nfsd is out of grace.
Thank you for clarifying.


-- 
Chuck Lever

