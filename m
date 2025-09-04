Return-Path: <linux-nfs+bounces-14039-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AABB44124
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 17:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3FB587B36
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 15:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FE727280A;
	Thu,  4 Sep 2025 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V/wSaiO1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TcxYfGkD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D74726D4D4;
	Thu,  4 Sep 2025 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001283; cv=fail; b=ZgKCnZPGRNXaihYK2Rv4+x38tpqpZkMwi7XZac+x4gzCxWvaAzc06R+C2OpUJLMF3p5HRnNApulWyy+DMl04/CuPB2zmXfwikQncyU/p02QD295tPW+fbJ2t4rghs4/AgYYJ4IBQqes7JV3DT4UPlTLICVlfn8q+E7gambGKXAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001283; c=relaxed/simple;
	bh=a2liKT0/4tt1ow8vsqsDNIJU9MJI4rBnu8qzQSm9bx8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=teWhZ+uGTVtbONBacyNvZ3iQukNuBY+wHIj6egP2X69QBFVq+Yfbjp++0sKhmiQXhTbeQfx/ej8QcVatQcQjsCJ3G9O8SavjhUtdhVRWavOA4fL8MlVWih1vIkoMrfVBJSzfURbAhYHU9r5kYhvYmj5kXtucNZAOYoOWuFXdas0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V/wSaiO1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TcxYfGkD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584Fk4Xc006697;
	Thu, 4 Sep 2025 15:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+VYn86T4SGJCQapd8/2yWv7W+S/ejL/WaE4o0qI2zvY=; b=
	V/wSaiO1rtrsFb+M4Kz5/5uKn1N1TbOWB4+OxWVd/iB9XTRrmVzjSkc2vQ8J84e3
	0pwSxQsvWLGtZ++rfdQub/0O7qinHINeceEkguKQTKqyHuccNghRYREYd1bclnCh
	qI32ZORMb9iIkC9n3D8BuMs1vySXDFV1Z0hgw9NjG/qrEbBHdPIOXsQ9z/KjHUdi
	0pm618ke4oXp0rheR4twCzCwb3UF9ckVIdJ5vIeoWAWYPUjHW4ycUOOziXI435n1
	j+ZOhm9f+hZv58MoCe03YJYWVEZQy35EcR/kKcFbi+7xa+aZ0y+icnhqqQxrOsqX
	Rw8Y/dUM338vVn7Kp2Rdag==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ydhd01vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 15:54:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584FcUUn040079;
	Thu, 4 Sep 2025 15:54:36 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrhtk5u-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 15:54:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWFDS5D8khR3AHM2VQsPfmFydn8L4UU5LpqdzfTdqwQzM5pvQ7YO6HYgj3KJYlKS3hoOJIq0TJ+osH5qER21Xsdr+HPS1kZmVFBLLo4mDktvtI6+nA1QQbx2mgqaxY4gyr7ewqOBW59ms/7JFnLk1/FJ4/ZNyOWofiCsiy5zKNe+OHRpdW4bswAE2936qKwY+UJtqfEnFzdZ6PRWehrg0tQ290+IPw5fjrYAlY/uj67G8dbcDf9NklaYDua7dsgUpwHeIwWgDt/BRmUZ9qs3iTgVeiPgTVLGL4X4cRXTskS4lThkxxHRHVVebvDo5/tmIkQxfem/SXb7XaRULWGJKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VYn86T4SGJCQapd8/2yWv7W+S/ejL/WaE4o0qI2zvY=;
 b=RDevkmK+tq0KsuIqCm6hfMS0WNKKHjkNOroNY+Apn4nUMzViQS5DS401knb8UDVYaYfX9KOW65T7aDgTyfIfn/Jyn6UM7svcuuK9bWvUMjqHJU1RJsdWxRhPlR828FGG7wUNE+W2f7s+sVBQwmfbjTM3PyAnaTnBqKhPTQ+qU/wla9TkRhwPi/Xa3BtSjzGztXvSSPKjYhyyNliQbi+D1paH82ort5UZpA8EGUwY/CZV+dGCjrCPm9ysoa94Zffw8LeZw0pDl1jt+aSIjCSVwV7fXrfs/Ix08r/er7b2xugXZ7uLLLsEmR4vgI6XodR5dUL/E7tOQffZZT9jh3rquw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VYn86T4SGJCQapd8/2yWv7W+S/ejL/WaE4o0qI2zvY=;
 b=TcxYfGkD10JdgAUUQYKZPFv100rfFnm97L7h475yadMJ0qFErZF6q9LjiViDHqTRM7PesfBV6yRtj1innPwWwEA+cmFwEgNct6Tt9bPZK5EecyZGmIFiVPRTnQDnc1CBejPfJSsa1PbSnEz85qPplez0lmaD9a+zU8znxL+FHh4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA6PR10MB8064.namprd10.prod.outlook.com (2603:10b6:806:43c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 15:54:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 15:54:33 +0000
Message-ID: <503ab8d0-d4df-488c-8513-abc128624d59@oracle.com>
Date: Thu, 4 Sep 2025 11:54:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] NFSD: Disallow layoutget during grace period
To: Sergey Bashirov <sergeybashirov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Evtushenko <koevtushenko@yandex.com>
References: <20250903193438.62613-1-sergeybashirov@gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250903193438.62613-1-sergeybashirov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA6PR10MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cf5323-3af2-42da-41bd-08ddebcb573d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?d2tmd093S1F3dlR1ZzFackl6M3RhVzZRdlBITis1SkplcUpjU3ZyZnJGMldv?=
 =?utf-8?B?Zk43SC9OQysrejd0c2NlTWZTUWZlVkhOcVJTNThOdCtHdFRjazFLQlM2QVFE?=
 =?utf-8?B?eG5VU1ZJYzB5TXhQV2w4M3pGcFFESy9manNHcXJoVlZBemhzS2diSGxvVS9l?=
 =?utf-8?B?ZEZycGNEUG5nMEplMUdvcnJiZm5XZms2TWV0bklHWWZNRDlRUzdyZGZsdVE5?=
 =?utf-8?B?R3RtSTFpSVc2UUhsSllwb1VUYjNqbE92djhyT3kyQkhkNHNZY1lkczNkWUJx?=
 =?utf-8?B?MS9WMk9LV2FLek82WWVBNWthcW0xN0VmMFVaSUhTYjc2Qm9RSVBjc3hyMEov?=
 =?utf-8?B?VG1LYmt0dlRUK2RLVlRyNUR0MElsNW9DbW1rM2hxRWo5Rm9TMDdweG1BRG1B?=
 =?utf-8?B?Uis4cjlwemJUb0JFNnF1UFNDdSs3RlFmK0xiRDlkTG42K2RHaTBDeHp5V2t4?=
 =?utf-8?B?YWdmUHBUTjA0Y2hYbkpZOHNka2V4a2pOaG5Ma1p6eVpqTFdyQ1FKTEJWbStO?=
 =?utf-8?B?M1J4NDh2ZVRSdlNwemRPaEJ4L2REUW5kQjBGOFRTcnQybnVyZVhveGxzZTJq?=
 =?utf-8?B?U1J5dS9aeVFSRU5HR3pFL3pRcVRGWkxRZFplc0ltWm0vR0M3c0J0aXFZdWRa?=
 =?utf-8?B?dEV5SmxoR0k0MDNEbnU3bHEvajZZVDNEM2F2R0Yxb1VCY2loZEx3STZCbDBI?=
 =?utf-8?B?NHk3VFB4R1RWREFHQTVmZVo2WWtZT1EySGlnTWQvZXVRUTM1am5CT2haa1lE?=
 =?utf-8?B?WndYMElPOFQvaWROUFRSdllzcFBEYXlsUFBFZ1Z1R29HOVNQdGFzOE5nUWVG?=
 =?utf-8?B?NytuY3VUa0FHWWdJSTJ1N3JMczlPRlFXajlPZUNYWWFCVStNM2V1WlJLelJm?=
 =?utf-8?B?Q0pzNEkrL09icXhWQW9zU3hnUWVqZ2VmRnNEOUh1RnhCaTJ2YVRhWHNvRGd2?=
 =?utf-8?B?RHRGckhUbkNDSE9EOG50WjhMR0VFKy9pamZwVjRvYytINGtuOWtXZFI4cUY1?=
 =?utf-8?B?K0crQjRTWXVjTURlZDcyYlpPcTZXd09WTnByNzcrb0dIVlZGT05DdzVHWHFL?=
 =?utf-8?B?OHozb0NFeWIyQSt4VTRUUXBDaGd2Y1o4R21PZmhyMVN4YTBiWXJJZm51RUhq?=
 =?utf-8?B?K1ZEYWJ5T0Y3Uk55OHJISFg0dWkzeHprMnpkZCtwL1Njd1hrcVlKaU01YzYw?=
 =?utf-8?B?T0lTejFiSGlUeDVlRmoyeE1MNWtCSnd4MVh6ZjZMOVRTQWpmM3Q2ZWYrb2Ro?=
 =?utf-8?B?ZG4rU21Wd1RpZVZPK3NFaGl2YkFHaG9QN2U0YWNidS9tQkRnQzRKWk02dkxi?=
 =?utf-8?B?cnBpZGlEUW5sVmRTN21FKzM5Nm93N1N4Qit2TE9TWExTUURRNkFhZVIxSEcx?=
 =?utf-8?B?RlpDQUxySWhqMGM4OW1DVk5DK3Z1SFdCV1RTTXVYYlFyN0kvK1U2bGNOVWdv?=
 =?utf-8?B?S1VrSzl2alhMRGNtd09DTis5RGNSczRhenpGUGlnZHJtcDFJTXVMd01ZRWFm?=
 =?utf-8?B?YjgwTHpQdXlXVndzMWtrajRodVArVjhTQmR4QnRwb3N1YmxDR3U5QUVGZVBJ?=
 =?utf-8?B?alRoNGFRN1pYTzhIMW0yY3liSisrdFBScS9MdXNPOXpQbDRwdU5ObDgvVGwy?=
 =?utf-8?B?VGFWd1o4RU94MlFOQUpvaFMwcnZ3VExTS2pYczZqODhmaTZKOU5UK3dZSFZT?=
 =?utf-8?B?K24yRzhNTk1Vbmh5dnVQbHVvcHVRdjBQZ0xucjVMcTk4ZW9YYURhbE92RDEz?=
 =?utf-8?B?WDVFNHBBTWlxNzRWQzZkRXozamkzcXUzSU5RRzIvMzQzMlVuc2RRbGFONyth?=
 =?utf-8?B?ZGk1MVV1UEpRRDZReEltaDZWSXB1dldZMDV4UDhyNjRtRUwyWGU0Y0xUZFhI?=
 =?utf-8?B?V201QzBDcEl3N1pET2hLcmxNYzFMTkpleUhSWk9sWUdpSUE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cHFGSnUwblpsZmVUb2NOWnJYSDdCa3Z2Q1NhMUFzNjNvVEVCMTdCVGxTSjBC?=
 =?utf-8?B?bTJDeDdGcUVrckMwOFVEeVNQUjRyL1M2RXFmMkFla3hTdm5Dbmd5ZHcwK0hx?=
 =?utf-8?B?Z2x3SStnV0VxU2FlY1pFVmdYT3JVYVQzS2RnSFc1U25vckRvWjJOWDlOWU84?=
 =?utf-8?B?WE1ld0toT3hGaG5jVXA5YTZjbFdjU2xsS2dnSW5uNkdKcE1Wa1RDYjdYSnN3?=
 =?utf-8?B?bzRldzFReGdGZE1qM0RMdS8vUEFGeitUT1ZtV3pqNzFWZ3EwM0JKWUJpdm95?=
 =?utf-8?B?ZVZaOW9pS3daeVVmM3oxV1czMG5IU29adHhGa1lGRk5CQU8xUlVrMEF3Vklt?=
 =?utf-8?B?dnd5VGtWY1hVbWEzWXU0VnFlb1BpK3VLeUlTRGJnZDFnSC9JRjNNQUlGNkd2?=
 =?utf-8?B?aTE0dHNpb2JmalNZcnRkQXdDdVoxYkl1WDBIeGlIVmh0eWFhUkxHSW1zQy9W?=
 =?utf-8?B?cExkOTFKSUs0ejJ4UnA1WFhscGtYQWZZaHJpMVByZFRUSi9WajdvbHlVU2pU?=
 =?utf-8?B?YldnaWZpNUFybmZWUitQMVVQcGJSRGJBUDJ0RFZUZWhXMXdjNjA1aFNhWjQz?=
 =?utf-8?B?NENjRzJ6UGNmL0dUaFY0RDE5Y01hbGI0dlNPVnJBTE9Xc2xGV3Q0d0VYTHpk?=
 =?utf-8?B?cG5vcWR2L2Q0WGMwRDlGK204QkIxWmx1aFo1Z0FzbzZNU2NtaGxYVVFhMDNn?=
 =?utf-8?B?bE9YZnEySjJ1dWlzYlNFVXk3Q0dZRlk4UXU0REU1b3BvYWJZRFl4MHBvOEth?=
 =?utf-8?B?YkVaN3k2UFQ5Sjk1a2s1UlA1L1RoSENmY3ZXVFc0aHg1UEFTZHZ1MXhkckdt?=
 =?utf-8?B?M0ZzQmNpZkxGMUgwK3oyQ1Z5T20yc1JTeWpzVXR3cnlBTWVLcDZoQW1ZTEdL?=
 =?utf-8?B?bEJEcnZTbnAyY0lQRGJzYSsrMXJlQmI5bnBFQnRSZ0RqTHpSOXBtanNKQllw?=
 =?utf-8?B?Z0ovOU9UODdJVHZrRnYzNEZra1dvNjUyN0c0MlJ6NDdtMWdwOCtmbFVaMERZ?=
 =?utf-8?B?Sk9zNXJLcG1HRmdyQ245N0x6d1FOeHdhcmF0ajBmRHFvVnBqU1N4dE9GbWU2?=
 =?utf-8?B?cDlhY0JPR0FuZWRkM2hZbkR2Rm8xSmtsT25TcWkrUWJ3VXlqZnBTa3c2U3FK?=
 =?utf-8?B?MThwaE84d2RtSzhxWnl4MlNkT3BraW9IR2xKZUV3SDg1TzkwbjgyYWlkOUdV?=
 =?utf-8?B?cE8rcGFMOWdGSnBVZVNxV3ZtU2tHUWV2TjVGSTlFTDZ6cHRjMTBNOUN6blpq?=
 =?utf-8?B?MDZhVzJmaE5rMkxrUy9INGttcm5kc0VtZ0pCbVFac1NieStFTzc3MDk4bEdq?=
 =?utf-8?B?ZjFkaXRIY0c5bW5RQ0JUOU82Wk10cEUzampuUVJGdEZHS3R3L3V1NVpzaXgz?=
 =?utf-8?B?V0dlaXhBMWt6SndGN2oyWGI2U1hQWWZ4K3pXWlFDU3dRMmlmMnJBcFRtNW03?=
 =?utf-8?B?RkMreHVoWE9DT3ZQdTNMVCt4KzVvcmVuRDFEZUJnL3llL3hKZy82QVhIQThx?=
 =?utf-8?B?dUplRWx4ZEVmT1ZsbHMyZzljRXU4YzNDZTdSc012N0RlQThtaWNNbW1hRjg5?=
 =?utf-8?B?a2pzL0JINjVJNTZKZmNJM1RRUVFGRmI1QkYwTTVxTHBKM3FTQTRUTjlISHBQ?=
 =?utf-8?B?eGt3YXBXNWUxYUZLS29hSXpFTFJxK3VlRHNoRE1RRzArMytiZ1d6TXd1M0ty?=
 =?utf-8?B?NVZzNDRIRGdub3Q3ckxpdm45c0h6N0tNa2N5b1RoSXlPSVB4OEI4OEhobC9i?=
 =?utf-8?B?ZUlMVzhCU2pGYmNoM2JCYzJKa3VWTjFSOHVDa3dqejBYWXo2QkhMbFFnZnU5?=
 =?utf-8?B?OHBsSGxSc3hZZHpUdjNMem82MDloQzZXUkJzRWEvWWM2bFQ0Y1I2WVY4ZFd5?=
 =?utf-8?B?VWN0Tm1tWUdVNUtuam16d0NQUy8rMDg3ZkEwQ2JUZGFzTVBwRjI2MGpSWk52?=
 =?utf-8?B?UC9iZlhlR3Y5eHdpbUJtZEZUS05tdm90R1M1WXpEYndsSXZnNXlINTZxTHVH?=
 =?utf-8?B?dzUvVGF2K2pPd3ZydWExU1I1M0Fadm9mQVNOcU1PM3hzYlZNVmJ4SytEOFBJ?=
 =?utf-8?B?OVFUNTlqYU9Ob1BGUkVSODhaSVpxaC93dnA5NER4cWE5Zkd1MUd2bFpQYnQ2?=
 =?utf-8?Q?VTc3Rtwp+NKXsNxF4N8iILsxx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EKC2GUzbTGt6y7+Z36HP5KNAYIGJHMx9ru+1H/Q2lP9Je0vIuSPNYfS4xEQvhgEJMU7xIV6LPPE2Vl+bGNk+YdqXvvyKFQoCFfUVQKDoLmo6R5xmoqXwxn166CiWWqu6FZESZNSN+nEPZeQ1CnG4ALT4lYuZez0AvXvP6YFGIOo7r7Ws2oPfX4mSWXmSdGkr1/ObOjCGUDlZ/87Wsq0rzBJ37qx26K/xvTZpCr/4VkawTCu07RgT2EEewso/MRGZYebTyEYqyeICj4iyYR2iK9V8jSzbx/qNZa7Wq4zUdSCyquz4i0MRsXa94ktrAY6pWZCbAsetzeWO2zk5aPT95ifpHVM4ZLgh8FYArDxILknYX69sI7zEMls2XYZo4kn9S/+PKPaGTtHTkk5/bmPYcRGYTcKN7eSUmQX/rn/teq/W8ugTn9bPCPy7IlE6srTZdm4EKv7oadbVzBu9QXqk8FWoKKWc0fEIi4mNWFYMe4T2h5jOH+rzsVdhXQYnhew6YKeIKYyaRtS/muMSbp7Tp51JfvwCfLiPtsY9Gh+2PAe9rX1dMoEJVG9LeueFRIOgDWCcaylWtk4Kr/+FaiiVfUCfum1LdvZ/Mfy9wQRaETg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cf5323-3af2-42da-41bd-08ddebcb573d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 15:54:33.2813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +76pEflJ5hneiSwo5U74w79GXMLjV0+53vXUnKv1Vh3plOcELUCM6fj7P4Mra7mYLVqxmSnjtk+jU5hrgI1AiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8064
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509040156
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE1MyBTYWx0ZWRfX7BBHchvkEjnw
 ytqccjFIvpB2dDjqiSijDzbsClMxb0XSOI7TOVIm67m29y1mlWlGceCRGUc6Dck2w7AlGe+I+tF
 166g7JTQQAT3RHudy2LTJSukT4w1PYiwMLX9Dq9eqO3fKfQPmJLX8rQOGTXpFw+5O7X9XYLqfvv
 KQq3Q9xE6ZHMjW0ZRFGwCFzsQjW860LA69lRq3JBX+0M7PkLlalTbOtc+pnf6RavvjSVaoVtrT2
 5CwK8H8E8BzMjvMtHoAsCb9vqe1PoPO3ZKGSDdCnGVydAdZRdJo1UjmehaJoaFdvjG7FYV2YPmO
 yZCn4EWQI5321ABxRyVAI8revG/0QPc+fMI43f5NjJ6mrLIW3NIph2rZZert3m3Cw7m+IGDM5+Y
 +pRn6aXUZq3jWhoTOuMExXDKDnbSlQ==
X-Proofpoint-GUID: bzPHOO4v2aWXRtBaYUUHnxditK90pzSE
X-Proofpoint-ORIG-GUID: bzPHOO4v2aWXRtBaYUUHnxditK90pzSE
X-Authority-Analysis: v=2.4 cv=QoZe3Uyd c=1 sm=1 tr=0 ts=68b9b63c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=BMxJXzqDAAAA:8 a=pGLkceISAAAA:8
 a=eM1t0QexjdaOfGlRLycA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12068

On 9/3/25 3:34 PM, Sergey Bashirov wrote:
> When the block/scsi layout server is recovering from a reboot and is in a
> grace period, any operation that may result in deletion or reallocation of
> block extents should not be allowed. See RFC 8881, section 18.43.3.
> 
> If multiple clients write data to the same file, rebooting the server
> during writing can result in the file corruption. Observed this behavior
> while testing pNFS block volume setup.
> 
> Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
> Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
> ---
> Changes in v2:
>  - Push down the check to layout driver level
> 
>  fs/nfsd/blocklayout.c    | 8 +++++++-
>  fs/nfsd/flexfilelayout.c | 2 +-
>  fs/nfsd/nfs4proc.c       | 3 ++-
>  fs/nfsd/pnfs.h           | 2 +-
>  4 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 0822d8a119c6..1fbc5bbde07f 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -19,7 +19,7 @@
>  
>  static __be32
>  nfsd4_block_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
> -		struct nfsd4_layoutget *args)
> +		struct nfsd4_layoutget *args, bool in_grace)
>  {
>  	struct nfsd4_layout_seg *seg = &args->lg_seg;
>  	struct super_block *sb = inode->i_sb;
> @@ -34,6 +34,9 @@ nfsd4_block_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
>  		goto out_layoutunavailable;
>  	}
>  
> +	if (in_grace)
> +		goto out_grace;

Taste/style nit:

I prefer that the controlling svc_rqst is passed to ->proc_layoutget,
rather than passing a boolean. The ff layout can just ignore that
new parameter, and the block layout can deref the network namespace and
do the locks_in_grace check.


> +
>  	/*
>  	 * Some clients barf on non-zero block numbers for NONE or INVALID
>  	 * layouts, so make sure to zero the whole structure.
> @@ -111,6 +114,9 @@ nfsd4_block_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
>  out_layoutunavailable:
>  	seg->length = 0;
>  	return nfserr_layoutunavailable;
> +out_grace:
> +	seg->length = 0;
> +	return nfserr_grace;
>  }
>  
>  static __be32
> diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
> index 3ca5304440ff..274a1e9bb596 100644
> --- a/fs/nfsd/flexfilelayout.c
> +++ b/fs/nfsd/flexfilelayout.c
> @@ -21,7 +21,7 @@
>  
>  static __be32
>  nfsd4_ff_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
> -		struct nfsd4_layoutget *args)
> +		struct nfsd4_layoutget *args, bool in_grace)
>  {
>  	struct nfsd4_layout_seg *seg = &args->lg_seg;
>  	u32 device_generation = 0;
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index d7c58aa64f06..5d1d343a4e23 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2435,6 +2435,7 @@ static __be32
>  nfsd4_layoutget(struct svc_rqst *rqstp,
>  		struct nfsd4_compound_state *cstate, union nfsd4_op_u *u)
>  {
> +	struct net *net = SVC_NET(rqstp);
>  	struct nfsd4_layoutget *lgp = &u->layoutget;
>  	struct svc_fh *current_fh = &cstate->current_fh;
>  	const struct nfsd4_layout_ops *ops;
> @@ -2498,7 +2499,7 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
>  		goto out_put_stid;
>  
>  	nfserr = ops->proc_layoutget(d_inode(current_fh->fh_dentry),
> -				     current_fh, lgp);
> +				     current_fh, lgp, locks_in_grace(net));
>  	if (nfserr)
>  		goto out_put_stid;
>  
> diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
> index dfd411d1f363..61c2528ef077 100644
> --- a/fs/nfsd/pnfs.h
> +++ b/fs/nfsd/pnfs.h
> @@ -30,7 +30,7 @@ struct nfsd4_layout_ops {
>  			const struct nfsd4_getdeviceinfo *gdevp);
>  
>  	__be32 (*proc_layoutget)(struct inode *, const struct svc_fh *fhp,
> -			struct nfsd4_layoutget *lgp);
> +			struct nfsd4_layoutget *lgp, bool in_grace);
>  	__be32 (*encode_layoutget)(struct xdr_stream *xdr,
>  			const struct nfsd4_layoutget *lgp);
>  


-- 
Chuck Lever

