Return-Path: <linux-nfs+bounces-677-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE5C815C2B
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 23:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4CE2850B5
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 22:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B0936B02;
	Sat, 16 Dec 2023 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ag00+zhS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ywKaJcYy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7981336AEA
	for <linux-nfs@vger.kernel.org>; Sat, 16 Dec 2023 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BGJ3xoO031167;
	Sat, 16 Dec 2023 22:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=waa7Q+swzHfz+qPIzhrR2iBYQUHvTmI5982qa1/p/4M=;
 b=Ag00+zhSlEawyP4wNxmYQ67XHCDe+pA4OaMFVy8BEP4A1agIxkMjbVwQlGYNUsn2xFOk
 5ojMI1VYX/FXLYc+XXZDHLl5vCEKTpiKiO1U9pQgF09tlouz/hKPbG4t5Vlg0H4Zea5U
 VsWHa9k41XhWA+QHledn+q8Ou+8WYv8mssVdhBpZhqfaCallbr4byUaOAL7xpRy1iN5I
 bqdL4zfP3N872Kr/1n55HThtR5o7ymD3wCRSYbi9u4ervZMTaEJrCc/kK9rWNLoFFqCF
 idXU49W7/++o2FCEKjcy2si1XutyExrZCoeSdggVIFJsOfDoEzdm42Blvdxvkv19s+JW lQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12ae917f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 22:45:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BGLNdOB027438;
	Sat, 16 Dec 2023 22:45:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b9s459-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 22:45:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPMPh/APJBiFPnYSCNkZZC9O76k//W9pAyK6QSBiBBDsd8L44LhE8mdFINc6z+tQK+djOzHISZmHXreLA2okVOQs0eJCuH2d8ADYhIGcd6MM++nfEFHO6pTFBtElvHeXxKPxLm9T6Bqt3kgEd7DgRU6eFuOVt5bw0sW+vrHlW/RvV09jyYGHDxVDwx58QhwI3Xcs3r2XCCuUjWYU2ekkOZt9sPfDaKR1851Fenwh2uyy/vJnwm4uWBgd6KgS7Gql5ESuVamBlYCQCquKy4q4Af0x6W25OH+Ob6uYoUUK8AXAySQkrZnbVTakPV2LNOIQsujZzkyQiZcPbEXo89IjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waa7Q+swzHfz+qPIzhrR2iBYQUHvTmI5982qa1/p/4M=;
 b=NDu2H4fVg97YExbE8vtRbGBkTF3DwNE+NHxRdaUBYv6eKBg94JJx97iiQZCAyLLgHGk1TDCBo8dbbPqo9a5GwlLLuMoYDjX4ORzcoKhFv6Bp4eZ/cBd3wd9WKeLQkW47HlLNm1gZZe59Ivi35yGb/L+f33GJLzKqKyxligq9Lf019XDpQU0ETOCI9nwHX+5MOz/f9/92jccF42Z8Mnxd0TkT68PvHkKTLJFt/glpMELRPu3WRUr6u9COdgyE8/STD3mt1goQGAMiKoOxfFVso29rw7dssrBj+6IlmlldcSU2hTIq316/wWTY79f3PM9oW0r2COgylTCF3jPAwAY8ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waa7Q+swzHfz+qPIzhrR2iBYQUHvTmI5982qa1/p/4M=;
 b=ywKaJcYy7vbXmorS2Wq6WU3gWUWz4X2ObxbaoRPb5Lw5GfgQj9c+TGuyIokCYFczOHX0+OZW6mrlqX0TllrG1Go54QxNy/BXvH8uEn1/elmwKwRA6ACg0SHj8utyuJkAlzRXqkhSeKDRdiaaRC3+UIl5meExEBjuSVb7eS6kfXw=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH3PR10MB6715.namprd10.prod.outlook.com (2603:10b6:610:148::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.35; Sat, 16 Dec
 2023 22:45:01 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5%7]) with mapi id 15.20.7091.034; Sat, 16 Dec 2023
 22:45:01 +0000
Message-ID: <88802128-3ae8-4f91-aeeb-69693b137981@oracle.com>
Date: Sat, 16 Dec 2023 14:44:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] NFSD: Fix server reboot hang problem when callback
 workqueue is stuck
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org, linux-nfs@stwm.de
References: <1702667703-17978-1-git-send-email-dai.ngo@oracle.com>
 <1702667703-17978-4-git-send-email-dai.ngo@oracle.com>
 <ZXyvCnEuV9L18JSS@tissot.1015granger.net>
 <195ba461-0908-4690-85a9-a9d12ffbad90@oracle.com>
 <ZXzIGmhDZp7v87aZ@tissot.1015granger.net>
 <aef15e6d-20c2-461d-816b-9b8bc07a9387@oracle.com>
 <ZXz7nxzlPfJ+06QI@tissot.1015granger.net>
 <1a988fe4-a64c-48c2-9c2c-add414294e07@oracle.com>
 <ZX0gOlqGbIES5RtB@tissot.1015granger.net>
From: dai.ngo@oracle.com
In-Reply-To: <ZX0gOlqGbIES5RtB@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0072.namprd17.prod.outlook.com
 (2603:10b6:510:325::20) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CH3PR10MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6c4edc-f38d-418e-3416-08dbfe88a322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7iS6ryOfQY5ST56F/GKQQzmsgoXbVKYv33ZkZZIWo4/cjS0LsLWhnzYQgeXhZ7xRe6uV/wrVSZ2V0k5lFYZl8+jVPbkikun6PTjVDqENMXGB0Qt0fzZN0xSEoo5VxoUq+mTtH8a0CDM8ACofYqI97oFlEO635pZvEMaEerRz7ooi469a3AG5TR+gEMxiP2BdGbRLYjYrifY5LST8CpXMiMGvz5p6RLXzJQEYsn1Og5X20M44WaXu8+nlM9daJGsn0ernjtouoDH71oBzWWop29ZDjEn+VVrUNSWEifsendubTlz3ZrplqjABjoG8Fs3IcZhpcjSIJBzSYhAVvHIRbhvTiDBgz6E+oaBCkIpXChBPP26wI3yoAmgw8daIC1yHLC2z7ZypkUISyqSjTo6CHEzuKry29a0UILwrBX0/1GsTfXx/U1Sl4OwNSklBi1MGkqyqaIrrx7ekOQfljd1If/x9O00TitUQwUCKcnArSdEhQ1ajEd1JwMXNuavzFdKw5OyHfq1405EcUA6hiWgvuQ/34b+hwCPsjLcfcN9UkRmuGrWicOgtaqFJoEJUkgW72DI+WEmUO/VxOXCjzjgfNpCqX7dArdIkvFnxdF1/0VTLJJcj7r3pBhZ73rqwUX5G
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(8936002)(8676002)(6862004)(4326008)(5660300002)(2906002)(53546011)(6512007)(9686003)(83380400001)(316002)(66476007)(66946007)(66556008)(37006003)(41300700001)(6506007)(31686004)(478600001)(6486002)(38100700002)(26005)(86362001)(2616005)(31696002)(66899024)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QndZNFk0eTZKT0lqODRaUWQwallPdjdncjNXMFRiWjlMbUNtUGFIczh2bjJQ?=
 =?utf-8?B?NDU0VmtUM1NFR2luUFBvblVPYWhnYUkzdUFsKy9XWm1FQVNqVEsvLzB5RHpk?=
 =?utf-8?B?UXFIdTFsYlBHdlZYQ2xudlVzbVRZZ2tuaCt6L2NWcmJBc2VZY3paOVQ1Yldm?=
 =?utf-8?B?Q0l1Skt4SUt2bmt1YTI0cThxRDJBYW1BWENZenJHRHUxL3BwK3VnM2wwUXBl?=
 =?utf-8?B?SjJ6U3E3bzlDQi9SVk15aXU1V0psY2xTdmJ5My84Zmo5UEs1MWlsK0xKTmU3?=
 =?utf-8?B?bCt1d1hjSjF4Z0dySHQ4OHlwTWVUanhSKzkyQ3BpQXhuV3FKKzlEUDNBM1E4?=
 =?utf-8?B?NENBOFdjdkMrRlNmSEE2MjFBUzRSWWV5QXFDZFd3akZTQ3FBajNsb3pxRWVV?=
 =?utf-8?B?TzFaZnFNSXBzNWdGRHFsK1hXZjBQeGJxOEZpM1RxdE9pZXNQaWhaajdsN3NP?=
 =?utf-8?B?Ry9nOHJhZTFlcmNHQlNrNFRQTHN3ZkNqUm5ZMEhEWUo4cXo3U3VKQUgwMloz?=
 =?utf-8?B?MDhPUkNxUldBbk9HWHZCR3FPNzJhWVVWa1RrbXBTSWI0Q1dpSm5ianBFdkwz?=
 =?utf-8?B?RjBHQnMyVndDNzREK0JyVzR0RXlRSmF6NHYyQWprSGxwWU5nMW5hK0xzK3hT?=
 =?utf-8?B?RVpmdDRMMCtPVzdyZ1l5YnRvaHo2OUFNMHpUd2pxYVVVYUxBRExENTk1ZHZW?=
 =?utf-8?B?UC9kMXZab3lKT3BFejd4QWttTUVITzNRL3JVM0JpQkJ4OEszUkpsbWlJV2pi?=
 =?utf-8?B?WW5ZTlhPOS9heTAwUUkzRWxQbkVZZDZaSkFucU9mcEs1N0YzNFUyYmgwcXR5?=
 =?utf-8?B?WE51UW5XUlJDcG1CamVIcjViKzR0ZTI1WDB0SGN3Mk54ZDRMd1hVL0FZV1lq?=
 =?utf-8?B?WjU0bkVTVUVKNlJ5V3lVWjIxeFJ3Rk1YUkJYRDN2S1RlSnpUMFRNZXVYK3Z4?=
 =?utf-8?B?N296Mmg5ZHJpMVZxQzFtaFB5VHJwS2V4QzQ2SDlJUUU1RjBqdWdNVDJmV1Vy?=
 =?utf-8?B?eFNPRkRyRzVLWGdDNHllNnIvQzZuSnQ0MFlmeGM4aGVERDV4VkllQjFxV2hm?=
 =?utf-8?B?MEFTYk9MbFVRYVgvcWtGeTJoVCtsNzdKckprcVAxTjQ1bFJ2UUJhMjdtR096?=
 =?utf-8?B?WEdJSGx3ZFBqTlY1Y2RwY2hvR1pqTmg5bHYrZ3B0eWRpWkZNQWhBRFRiMHlq?=
 =?utf-8?B?TmtYRzNVZkJrR0xCSDN6aVJnZkt4YUw1d2o5UWVSVW84K0c3UTFoRlg3OFh5?=
 =?utf-8?B?MWE2OEUzTVgwamxrSmY1MWhhcFdFZXpvcklHSzVKRjBtSE04bnNFMWFjT0t4?=
 =?utf-8?B?anZnSzVnN1FiZDJrN3NQNGtTL2RhNitUMmJOZ1Y0Ry9UR2xkY1ZjWG9UR01T?=
 =?utf-8?B?ZXJ5bWREMVVhVEhDQ3htdGttNjZaNyswdFVOeGxnQitYeWJxZ0toSU1nMSsr?=
 =?utf-8?B?dTJXWENsNk9zUDNLUHloMjIyamlrV2NOWS85bzNERG5ZZkU3Wkx3VTBCNS9H?=
 =?utf-8?B?UFBibThpaTlFdlo5WUtXdDJwaGJad204UXBJUEFTVGxIZ2lHU2tJQzJDMmcw?=
 =?utf-8?B?VzVQaThiSzBYMzBUNGZ5VTR4b2JYbC9sNXdCcVVISVpkSUNJVHh5c0VTc3Jk?=
 =?utf-8?B?L3p0ODdUbng2ZFBsVzRqN2VHbkVkMGgyQThHeHdXZ2dtc3BuYkdmbmVMeFZQ?=
 =?utf-8?B?V0RERzFRcmR6YmlHVzhNRmkrNVRYK1VwRE0xQjhMT003N05kaGVHRi9mMWh1?=
 =?utf-8?B?S3d1LzRURkpTeWZ6UVo3Qkh0NTdhYlRsV3NxN3l4RzdraWtYeUhYNTg3cDVW?=
 =?utf-8?B?REJkSG9PR2V6WW9XRnFzeTh2NzJ5SlppN2E3eHBya2hlbVZtbGZEK2FHcW0w?=
 =?utf-8?B?dEJxZUhvNWtmWGdnYjAyOG5JUGlQRUpEWGJORGNXdjZSTUhVSUtVcUNITWg2?=
 =?utf-8?B?WS9IM3R5eUF0Qks1dUVzQzNGRGc3cG5ldWU4eWlYQWQvWmZvWU9lckozV3dP?=
 =?utf-8?B?Q1BWV2tNMnlYSENHcGhlbnZvOTJ4enBoQmtJWWl5dG13dFdrd2I0RTZ2bDR5?=
 =?utf-8?B?eVhXTjhyN2NjcDJHS0hQbDdQRFlSK0ltN1hSNERwTXYzMStlTDJHd1BhTXRC?=
 =?utf-8?Q?sn9MfdHNPN2buGBbJesr6juj/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7Ihyvj/1Yr9DvAzx+JVbLERxC0YnutCkxzwNnoN0Fo89iyIjo46dvj4DKHzOYlMUtQiEKkHq2xvUe3nmbIDmQ7Ank/3A/v8oimJe6yI+LQ1SZ+jA5XWImKVoPXcZ0bAI8riIeNWEQyzXPQ+uM1XloaziLgWyMF4D8ehgykd4vvaAleEjlKVOjjvFe3H9nqSnMFxjNbCFopXsBmyagTSUE8s5ftiuQ+9JOk2BIgG19KRijb0yqqcNIPLvfpHjIzJhJyK4USSID+e03ljd+R++9IUK132Yu88pmXPsiKM3WAg65Ot1zRoRiEV8DvXfRRxd/7NMPQpkGb4tCMC2u1Aa1QYaGlGGtj8p4Kh9ADyVfOhA2PW0MNc3pChi9OYhxFRiTDKf3KRopzsWPgrjkveEBE66Ag/0NJdLg7mGQ0UlNOCm/TjExsTTjwBiKZx4T93/sZliL3qqqP3Kklve18Kox4njZyS6/FQbqQbi0HVMqh9eToJq7Y+EDHT/qHINFLEK3TggDaIa65n/dKV0BHxbgyiWTjazWdxu4zG2igNnCcEUXYC15Ni5jXMvwYg2WLeNY13IPJBVJxW5jc6aukDVjHHtSV6HqcTJn/jFyDT1fjg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6c4edc-f38d-418e-3416-08dbfe88a322
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2023 22:45:01.0468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QxZNzqfJtIiXfCjbl8PDHLFgC0fZzaWDyf63sHosw7al6NsGbgUg2MjgPwaWvUn+DoWDlnJO4oxHpHDY/etYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-16_17,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312160174
X-Proofpoint-ORIG-GUID: 8_Bo1itBNLQwsjeEmzjZ0YfTQmAR1tB1
X-Proofpoint-GUID: 8_Bo1itBNLQwsjeEmzjZ0YfTQmAR1tB1

On 12/15/23 7:57 PM, Chuck Lever wrote:
> On Fri, Dec 15, 2023 at 07:18:29PM -0800, dai.ngo@oracle.com wrote:
>> On 12/15/23 5:21 PM, Chuck Lever wrote:
>>> On Fri, Dec 15, 2023 at 01:55:20PM -0800, dai.ngo@oracle.com wrote:
>>>> Sorry Chuck, I didn't see this before sending v2.
>>>>
>>>> On 12/15/23 1:41 PM, Chuck Lever wrote:
>>>>> On Fri, Dec 15, 2023 at 12:40:07PM -0800, dai.ngo@oracle.com wrote:
>>>>>> On 12/15/23 11:54 AM, Chuck Lever wrote:
>>>>>>> On Fri, Dec 15, 2023 at 11:15:03AM -0800, Dai Ngo wrote:
>>>>>>>> @@ -8558,7 +8561,8 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
>>>>>>>>      			nfs4_cb_getattr(&dp->dl_cb_fattr);
>>>>>>>>      			spin_unlock(&ctx->flc_lock);
>>>>>>>> -			wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRUPTIBLE);
>>>>>>>> +			wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
>>>>>>>> +				TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
>>>>>>> I'm still thinking the timeout here should be the same (or slightly
>>>>>>> longer than) the RPC retransmit timeout, rather than adding a new
>>>>>>> NFSD_CB_GETATTR_TIMEOUT macro.
>>>>>> The NFSD_CB_GETATTR_TIMEOUT is used only when we can not submit a
>>>>>> work item to the workqueue so RPC is not involved here.
>>>>> In the "RPC was sent successfully" case, there is an implicit
>>>>> assumption here that wait_on_bit_timeout() won't time out before the
>>>>> actual RPC CB_GETATTR timeout.
>>>>>
>>>>> You've chosen timeout values that happen to work, but there's
>>>>> nothing in this patch that ties the two timeout values together or
>>>>> in any other way documents this implicit assumption.
>>>> The timeout value was chosen to be greater then RPC callback receive
>>>> timeout. I can add this to the commit message.
>>> nfsd needs to handle this case properly. A commit message will not
>>> be sufficient.
>>>
>>> The rpc_timeout setting that is used for callbacks is not always
>>> 9 seconds. It is adjusted based on the NFSv4 lease expiry up to a
>>> maximum of 360 seconds, if I'm reading the code correctly (see
>>> max_cb_time).
>>>
>>> It would be simple enough for a server admin to set a long lease
>>> expiry while individual CB_GETATTRs are still terminating with
>>> EIO after just 20 seconds because of this new timeout.

With courteous server, what is the benefit of allowing the admin to
extend the lease? I think this option should be removed, it's just
an administrative overhead and can cause more confusion.

>> To handle case where server admin sets longer lease, we can set
>> callback timeout to be (nfsd4_lease)/10 + 5) and add a comment
>> in the code to indicate the dependency to max_cb_time.
> Which was my initial suggestion, but now I think the only proper fix
> is to replace the wait_on_bit() entirely.
>
>
>>> Actually, a bit wait in an nfsd thread should be a no-no. Even a
>>> wait of tens of milliseconds is bad. Enough nfsd threads go into a
>>> wait like this and that's a denial-of-service. That's why NFSv4
>>> callbacks are handled on a work queue and not in an nfsd thread.
>> That sounds reasonable. However I see in the current code there
>> are multiple places the nfsd thread sleeps/waits for certain events:
>> nfsd_file_do_acquire, nfsd41_cb_get_slot, nfsd4_cld_tracking_init,
>> wait_for_concurrent_writes, etc.
> Yep, each of those needs to be replaced if there is a danger of the
> wait becoming indefinite. We found another one recently with the
> pNFS block layout type waiting for a lease breaker. So an nfsd
> thread does wait on occasion, but it's almost never the right thing
> to do.
>
> Let's not add another one, especially one that can be manipulated by
> (bad) client behavior.

I'm not clear how the wait for CB_GETATTR can be manipulated by a bad
client, can you elaborate?

>
>
>>> Is there some way the operation that triggered the CB_GETATTR can be
>>> deferred properly and picked up by another nfsd thread when the
>>> CB_GETATTR completes?
>> We can send the CB_GETATTR as an async RPC and return NFS4ERR_DELAY
>> to the conflict client. When the reply of the CB_GETATTR arrives,
>> nfsd4_cb_getattr_done can mark the delegation to indicate the
>> corresponding file's attributes were updated so when the conflict
>> client retries the GETATTR we can return the updated attributes.
>>
>> We still have to have a way to detect that the client never, or
>> take too long, to reply to the CB_GETATTR so that we can break
>> the lease.
> As long as the RPC is SOFT, the RPC client is supposed to guarantee
> that the upper layer gets a completion of some kind. If it's HARD
> then it should fully interruptible by a signal or shutdown.

This is only true if the workqueue worker runs and executes the work
item successfully. If the work item is stuck at the workqueue then RPC
is not involved. NFSD must handle the case where the work item is
never executed for any reasons.

>
> Either way, if NFSD can manage to reliably detect when the CB RPC
> has not even been scheduled, then that gives us a fully dependable
> guarantee.

Once the async CB RPC was passed to the RPC layer via rpc_run_task,
I can't see any sure way to know when the RPC task will be picked up
and run. Until the RPC task is run, the RPC time out mechanism is not
in play. To handle this condition, I think a timeout mechanism is
needed at the NFSD layer, any other options?

>
>
>> Also, the intention of the wait_on_bit is to avoid sending the
>> conflict client the NFS4ERR_DELAY if everything works properly
>> which is the normal case.
>>
>> So I think this can be done but it would make the code a bit
>> complicate and we loose the optimization of avoiding the
>> NFS4ERR_DELAY.
> I'm not excited about handling this via DELAY either. There's a
> good chance there is another way to deal with this sanely.
>
> I'm inclined to revert CB_GETATTR support until it is demonstrated
> to be working reliably. The current mechanism has already shown to
> be prone to a hard hang that blocks server shutdown, and it's not
> even in the wild yet.

If I understand the problem correctly, this hard hang issue is due to
the work item being stuck at the workqueue which the current code does
not take into account.

>
> I can add patches to nfsd-fixes to revert CB_GETATTR and let that
> sit for a few days while we decide how to move forward.

The simplest solution for this particular problem is to use wait with
timeout. But if that solution does not meet your expectation then yes
reverting the CB_GETATTR, or remove the handling of GETATTR conflict
with write delegation, will definitely resolve this problem.

-Dai


