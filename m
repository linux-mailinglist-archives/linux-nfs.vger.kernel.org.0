Return-Path: <linux-nfs+bounces-666-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DF98156B6
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 04:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880D9285FB6
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 03:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25AB1C32;
	Sat, 16 Dec 2023 03:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m8nQ9TBd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b63uRDe+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B8A1C2E
	for <linux-nfs@vger.kernel.org>; Sat, 16 Dec 2023 03:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFK7hrw024672;
	Sat, 16 Dec 2023 03:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=bq7mKp27VegKRC9t/JqhfAt9osnSyK8SfHlT4Ro+kF8=;
 b=m8nQ9TBds5sz60oDkxDcO5HQO2LULPB8LPlRPVKzVwji5BXz9marAFIfKOWWqIowxrYx
 P3I/rHaYCqN76S67IR2vGlenSdK3LrbKXx3JdmRKvqfwFzJkxxzP74xKSd+qLXlvA/Jk
 4Bj1wLkWdC/AP/ek9qPrgY5qFNzwaIKYKilvYlhQF2U4RO/9DjXO5daWXO2Cm+qDAH02
 icKY6TCPaTbW+fas9FNJuociRAkOvPNYVeaW3b9NYkUnRQVzo6LVcsVolp5ehtSSEXxV
 SKYUNZopdOvS9JA+RDfRe9sew8CudLS7oO4c8itZjQg7DGG561yQELoKU9Pt13LM4pDA bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvg9deu85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 03:18:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BG1XlZ7027444;
	Sat, 16 Dec 2023 03:18:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b92det-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 03:18:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVE1WPN5KLpxM9aDY705xHO9UfXxdmg7vClC44tADdnTdEUOFbRkW0slz27ftcNihncB0xQlw8iQ2epCNoJr/8T9DwDqZxCQU57zZy/aQnjOd9sUxP+UJ9WTCG5uuwnYry+zx1IJpGPyowanfFeeizCJ2+ORrXU6bKQmBT0fuke/9M1Jzbk8IK4NXiQxeH7DRkN2x09p6d4z/1cGCVGJTeRIDgR3La7sBBjS1A0KZBnTvu/jTpHFtDuIT2S/RjoPH6J3E0UFGIvSEoa02rNgqinBuOUUpU0dYZrMxQfjSp8f2GnNWMMHtzwUGN6nKgHU+cjHLRtBvNB2cUU/46z7IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bq7mKp27VegKRC9t/JqhfAt9osnSyK8SfHlT4Ro+kF8=;
 b=SzE+TTyeh5WTRrNQg9MJEyX1iF0xvZYZXwFJGHgZ5tklvAk3nKCZHiqsy/7ud7l2H86BkcE2fYRmJEQBjRFP/yecgmgoDfvxdvGyNg+UeFAydEhL4T9kHBmWtTkYSI2iDA+IfkBF/orgoM0UIEbTJLs7OUu/Jr5DFF8hAvCmBdykkqYZYLT7HPdcB8Duy81qIIHnihSlq46ctJfDEj8ZCk5D+Q+BVFXUM42pu9Ez0u6rqATfMbwd/oL6eJnQTks3WGeWMIrEYh0SDmulOLgeWpYxG9FBv3TyKG+AObXUwvXher8MBF/w/93rtOQ6g0ulfa4DhnnmUP1zALF15ZYQug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bq7mKp27VegKRC9t/JqhfAt9osnSyK8SfHlT4Ro+kF8=;
 b=b63uRDe+zcpSAgLTwrBJm6oxoZIUeZpg3OLOQk/E4R1DiFCV5QcTzmnP2rWCzB7SlYr3vU/5ZSVkEsJgRHEmRxj/PYSPm0X5QSuY3/5ebFbEcMdCFdp59FFcFOQBQ35pF+nssVSIODsANRalF0QFYoLEJoXeG+ncKMHKdt6uKN8=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4592.namprd10.prod.outlook.com (2603:10b6:a03:2d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32; Sat, 16 Dec
 2023 03:18:34 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5%7]) with mapi id 15.20.7091.032; Sat, 16 Dec 2023
 03:18:34 +0000
Message-ID: <1a988fe4-a64c-48c2-9c2c-add414294e07@oracle.com>
Date: Fri, 15 Dec 2023 19:18:29 -0800
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
From: dai.ngo@oracle.com
In-Reply-To: <ZXz7nxzlPfJ+06QI@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0036.prod.exchangelabs.com (2603:10b6:208:10c::49)
 To BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SJ0PR10MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: f431325a-ef13-46d0-990a-08dbfde5aff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zhgOQv1+zM7WhKS+MrONHDRnHbNuRbR5SpgHDEIpVpt5MvKYVUXTxciTnntY64PNLTErZSl0/Wn3FEfO8l621zHx5khEsR3UidAcGJb1cGXZ6cZac95xIpBsWPHW1p/FT3YznCXkv0ZQZFRuV5j3DYDyPB/VUUh5azjsEwZZtEcxFblFr5XC8JUWPDL2u+7k3v7PxCt2k/w6AtxKuoCb0HtByS1d6rj1UjlgaZt8iBZbCgqsTPf5zWWYaeJtZKt0QQqmO5XMnBjzVAgQfPD1MjrI2XKHlkqSmHMOgZG9riK0qHWbzJabpn6WCGZ6i3cAKk/zRttpNGvj0O247M82RlIFx5NBxauePnZJ0zQ97jK1rZFEtslVjLUvl7XzbFrld9KK4YLa3kkcMwowaEyWDkzVI3xoKf7a1frlDj7DftuRgBALgW3VJ1bWQKWyWekSEglkimYhp88+UDaI/hWGFry/noizfdzDjltkbZi9LUYEn1J5OfL4JEf+ZpQbP0wb4LB2/b5goHk2ipjEOQIBWy++RU72UWnaBHWg/6r/c8B4jighVaKT8vW/ncwUPblNqmFRX5l9JE0BsZsmavPtx5FIQkV5nUM3Jlw1Bc9JhhSvEThPPbtoz/rgf29K7mQb
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(316002)(36756003)(31696002)(86362001)(38100700002)(26005)(83380400001)(2616005)(53546011)(478600001)(6486002)(2906002)(66556008)(66476007)(37006003)(66946007)(9686003)(6666004)(6512007)(6506007)(5660300002)(8936002)(8676002)(6862004)(4326008)(41300700001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z21aUDRRQ0FNaVN5dVUxbktIVkUyY0FxSCtId255c2w1TTFYSXM5WEF5WlBB?=
 =?utf-8?B?WVlUNEZjRktrZmlZMUhjcE5JZENUSllMU1YvaU5hbDV4SXFrN0Z4NFBYMjln?=
 =?utf-8?B?dnEzTjNuYXJJVThuQ1ZBVmNrY1h1YUpyNnJDQlYzRkhoK0wyaXJjYklFZng2?=
 =?utf-8?B?TWlhTEtkQS9QakJZR2hXeE8yU1Z6QUY0WktEbzhKcEUrSnlkeDdmcXBBWlhL?=
 =?utf-8?B?ck54cVQ2K253enJCVzdGeXFTd1BoaE1lSlgyeExQZlByeWorT0ZxeXRmYXZ0?=
 =?utf-8?B?dnZ3d2NLd1hJNmpnT2ZIVER6czhNdFVqVEdycVM4YmhSUUpWMWo1WENPK01J?=
 =?utf-8?B?Q2xnL2pOZkgyNkJkS2s4ZWV1VE5MMkQ4U3FDSkxXck1CQ1oxSFN2dTRuM3lt?=
 =?utf-8?B?K0pCODQ4dFpYQTZtKys5WmRwSlNEYk8rbUpSdTlJZ1ZsRERpUi9OcmRyem5a?=
 =?utf-8?B?YVVlYWlGQlBSa2Z5cVZDTDM0V0xOTnFTNTlxTThKVTl0K2RKTDhKeDZSSExU?=
 =?utf-8?B?ZVB1MFMwMHZVSmpyS2UzQWlDNGNsa1lKTklvSnBzT080b0lLeEhWaDViWHZn?=
 =?utf-8?B?MENNaXl2OTJhK21hUS9RQWI3YU80eHlQVTZUblROTlU4UmVSVUgzSHhvNStZ?=
 =?utf-8?B?VXQzak4vUU8xSU14YmFEdUhPL3V6Rk9IamRsUnhRRS9Wa2dqdHJlbG9ZS25l?=
 =?utf-8?B?TkVpUkxqckFQZEx4VnNkVFFaVVhOVDhnM2h1MFRhaXZCMi9RaEYvSTBzMXFy?=
 =?utf-8?B?OEhKa1oyaDk5ejh0ZnQveUREbStWbkJXSDNaekVoMVlpWmI5L1FrYTgwYUZm?=
 =?utf-8?B?M0QrTU0yUGN0dEJLMDkrR2FoZHBmRTlIYk1NUzl0SFZWcnlJcnhzUUJxTFVF?=
 =?utf-8?B?WWErUFZTMlUvMExGZlJXaG9NNUpMY3Z6RHM2YWE3Vm1qeW5ZWGlBd3RIS2dF?=
 =?utf-8?B?Y1p6bWhhUVBRQlBMQ0kwcG04Vk1sbi93M2V5ZzA2a0VrcGt0SUVqSjVERDZS?=
 =?utf-8?B?THdBdEtlYUMwRThEWG1EY2luelhKVHN6R1B4M2g2ZkxrNDZJQ2UzZWt1c3FS?=
 =?utf-8?B?ZVhNOWw4cTJ1cGVSQmticWZmRjlwWFl5YkZMUkxhU2wwS3VmYXlIdDJaOHRy?=
 =?utf-8?B?UjFVQ2p1cTUxRUozMHRCMWRWUGpPNHo4ZGZLekdKV0NnWlhJLzc0enBCTytD?=
 =?utf-8?B?OUtBMGxiV1BVenUxS2N1NXhaZVRyRW84UmorR0NLOVFMZm41K0NnQUVNNWZU?=
 =?utf-8?B?dG0vYzFXZkQySmliSDBudHJvRk1XTVlvSVdIMVJ5NUEvSHd0RUE3ZFVib20z?=
 =?utf-8?B?MTd3S0dYZklZMzQxaVNIaFNOSFc2S0dVanJrUGpGUlkzVXYxQmR3V2ZDeHg3?=
 =?utf-8?B?Rk82ZjdtQXkzcmgvTjk1bnB2QVlCaytRUGltbE4zVDNack9DUmNQZnJGZXZC?=
 =?utf-8?B?b1BTdjBYa3JaNllxVUZURW5UNm9QWnNPQkQ3Rys4a1QrVUVYcWtCOVdMcUt5?=
 =?utf-8?B?VHVyQ1VDbld1aHlEU1JNRTBmSDVhMytKb1lLR2wyU2kwYXBFeVFtOEQ3d01W?=
 =?utf-8?B?NGRENStVV3lPdElHWUdWSGhTZzV6eEI3ZHJZMERDMURVOTFCNVNWNytJY2U3?=
 =?utf-8?B?L1dtNkpmZXlZd0I1Nkt1ZGpqd0YvTUJxYUVJUFNmbEZ3VE5XU0VVZVIxY3Fn?=
 =?utf-8?B?QzJ1d1FwKzRqQTN3SlJyN0NpT3ZGbEZHMnhLcngyd3JMNkg3MzMrUmNKdDFK?=
 =?utf-8?B?U2ZrdUltVU40QmFVclR5LzN2R2lFNkpJaXMwSnBBSXdnak5zZ3dPMjhGK0xT?=
 =?utf-8?B?Z1pwT1VvQ2ozdGlCdEJ5c0o0cDZkVUV2dGV6aDVUNFU0Vm5abGNFTkQ5bkk2?=
 =?utf-8?B?cXJqaXFQZzlkMis4cC80ZERFVUIwblNmSCtvMWlielpRSzI4OWJVUnJBSFE2?=
 =?utf-8?B?MEpndDRNTFp5dkNock5vbmRiU1c3VWVBWGRING5uSzhXNjNNS0ZFTEJYUkZP?=
 =?utf-8?B?UGRWOFg4WG9rZmZ5VSs2OGJqakt2Zlk0ZlljVktsc003dCtNemdqKzVhQTV2?=
 =?utf-8?B?U0tueVRhM3RBV1pkVDF3azFLMGRJenFKUHB1RXh0OG5wVEJLQWFUV3lvMTcz?=
 =?utf-8?Q?VUZmyPCjlA14pHRooQ8paMSUI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HMk4Q1X6+Gr1gfBRUFp0ZogL0Js8VG4hXQDA7N+wqsWMWv6oJZxOUurDyG8n0LCB77hAUExvq7ivMdmjDYTyWwH+vawSaeltJUTK3s6x9mMosFtk7Xo7jeReKJDO1wuof7BzqlVm5o6hKqkxvMb7NPy6+fLMguy8WyrE1WWMgKpzR/R44W2IrnzDKwAspLSof4Vw3W+VVcD1LqfalqaRGjuasj3MqzgLbYqYLAPhmDqwRny3Fe/mL2jNWyjII0GeHAUKu6mAImkiAeTcLAZewfzmfbeJwLjpFTOXnrg2Xkzz/jMO/391qL8zCaoboc0RU5yDGXsefPAfkgNhsAo1R0f0jihanbo5vFhGw0DrqoZYdwTf1K5d2QPaqBGiCe71mq2qnVOXvX0Cv9igFZOnevnW4TakAD2Pa8nk68zPHxTdbM2AukJZZPrA4ZNjSAU92FEido0feMOORxTTM419mM3+fpcVN879o9YOSolYQKEGthJiUpbylN0mLSGhqYYc5wCoLdMJyC9k1tT30PyD7DT81wuMoZ9jH+avTP05py7sS1wJgXPMHxaQGwpObtSgqKc2w33oKxuGIWV8idxk6qBus3hJogZ3nZW2HfwFcSU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f431325a-ef13-46d0-990a-08dbfde5aff0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2023 03:18:34.5678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SOPpmLsa5fNp4gicwrqhqbUjILU/Lhno4402Fl9+1Ohg8shT2YU83DqI2HDJ1EXjN1sx0AKpoSxFXE07OGCOsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-16_03,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312160023
X-Proofpoint-GUID: Z-axON_zgDop5ieSDjrILsaT-oDFKDlV
X-Proofpoint-ORIG-GUID: Z-axON_zgDop5ieSDjrILsaT-oDFKDlV


On 12/15/23 5:21 PM, Chuck Lever wrote:
> On Fri, Dec 15, 2023 at 01:55:20PM -0800, dai.ngo@oracle.com wrote:
>> Sorry Chuck, I didn't see this before sending v2.
>>
>> On 12/15/23 1:41 PM, Chuck Lever wrote:
>>> On Fri, Dec 15, 2023 at 12:40:07PM -0800, dai.ngo@oracle.com wrote:
>>>> On 12/15/23 11:54 AM, Chuck Lever wrote:
>>>>> On Fri, Dec 15, 2023 at 11:15:03AM -0800, Dai Ngo wrote:
>>>>>> If the callback workqueue is stuck, nfsd4_deleg_getattr_conflict will
>>>>>> also stuck waiting for the callback request to be executed. This causes
>>>>>> the client to hang waiting for the reply of the GETATTR and also causes
>>>>>> the reboot of the NFS server to hang due to the pending NFS request.
>>>>>>
>>>>>> Fix by replacing wait_on_bit with wait_on_bit_timeout with 20 seconds
>>>>>> time out.
>>>>>>
>>>>>> Reported-by: Wolfgang Walter <linux-nfs@stwm.de>
>>>>>> Fixes: 6c41d9a9bd02 ("NFSD: handle GETATTR conflict with write delegation")
>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>> ---
>>>>>>     fs/nfsd/nfs4state.c | 6 +++++-
>>>>>>     fs/nfsd/state.h     | 2 ++
>>>>>>     2 files changed, 7 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>> index 175f3e9f5822..0cc7d4953807 100644
>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>> @@ -2948,6 +2948,9 @@ void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
>>>>>>     	if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
>>>>>>     		return;
>>>>>> +	/* set to proper status when nfsd4_cb_getattr_done runs */
>>>>>> +	ncf->ncf_cb_status = NFS4ERR_IO;
>>>>>> +
>>>>>>     	refcount_inc(&dp->dl_stid.sc_count);
>>>>>>     	if (!nfsd4_run_cb(&ncf->ncf_getattr)) {
>>>>>>     		refcount_dec(&dp->dl_stid.sc_count);
>>>>>> @@ -8558,7 +8561,8 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
>>>>>>     			nfs4_cb_getattr(&dp->dl_cb_fattr);
>>>>>>     			spin_unlock(&ctx->flc_lock);
>>>>>> -			wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRUPTIBLE);
>>>>>> +			wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
>>>>>> +				TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
>>>>> I'm still thinking the timeout here should be the same (or slightly
>>>>> longer than) the RPC retransmit timeout, rather than adding a new
>>>>> NFSD_CB_GETATTR_TIMEOUT macro.
>>>> The NFSD_CB_GETATTR_TIMEOUT is used only when we can not submit a
>>>> work item to the workqueue so RPC is not involved here.
>>> In the "RPC was sent successfully" case, there is an implicit
>>> assumption here that wait_on_bit_timeout() won't time out before the
>>> actual RPC CB_GETATTR timeout.
>>>
>>> You've chosen timeout values that happen to work, but there's
>>> nothing in this patch that ties the two timeout values together or
>>> in any other way documents this implicit assumption.
>> The timeout value was chosen to be greater then RPC callback receive
>> timeout. I can add this to the commit message.
> nfsd needs to handle this case properly. A commit message will not
> be sufficient.
>
> The rpc_timeout setting that is used for callbacks is not always
> 9 seconds. It is adjusted based on the NFSv4 lease expiry up to a
> maximum of 360 seconds, if I'm reading the code correctly (see
> max_cb_time).
>
> It would be simple enough for a server admin to set a long lease
> expiry while individual CB_GETATTRs are still terminating with
> EIO after just 20 seconds because of this new timeout.

To handle case where server admin sets longer lease, we can set
callback timeout to be (nfsd4_lease)/10 + 5) and add a comment
in the code to indicate the dependency to max_cb_time.

>
> Actually, a bit wait in an nfsd thread should be a no-no. Even a
> wait of tens of milliseconds is bad. Enough nfsd threads go into a
> wait like this and that's a denial-of-service. That's why NFSv4
> callbacks are handled on a work queue and not in an nfsd thread.

That sounds reasonable. However I see in the current code there
are multiple places the nfsd thread sleeps/waits for certain events:
nfsd_file_do_acquire, nfsd41_cb_get_slot, nfsd4_cld_tracking_init,
wait_for_concurrent_writes, etc.

>
> Is there some way the operation that triggered the CB_GETATTR can be
> deferred properly and picked up by another nfsd thread when the
> CB_GETATTR completes?

We can send the CB_GETATTR as an async RPC and return NFS4ERR_DELAY
to the conflict client. When the reply of the CB_GETATTR arrives,
nfsd4_cb_getattr_done can mark the delegation to indicate the
corresponding file's attributes were updated so when the conflict
client retries the GETATTR we can return the updated attributes.

We still have to have a way to detect that the client never, or
take too long, to reply to the CB_GETATTR so that we can break
the lease.

Also, the intention of the wait_on_bit is to avoid sending the
conflict client the NFS4ERR_DELAY if everything works properly
which is the normal case.

So I think this can be done but it would make the code a bit
complicate and we loose the optimization of avoiding the
NFS4ERR_DELAY.

-Dai

>
>
>>>> We need to
>>>> time out here to prevent the client (that causes the conflict) to
>>>> hang waiting for the reply of the GETATTR and to prevent the server
>>>> reboot to hang due to a pending NFS request.
>>> Perhaps a better approach would be to not rely on a timeout, but
>>> instead have nfs4_cb_getattr() wake up the bit wait before
>>> returning, when it can't queue the work. That way, wait_on_bit()
>>> will return immediately in that case.
>> We can detect the condition where the work item can't be queue.
>> But I think we still need to use wait_on_bit_timeout since there
>> is no guarantee that the work will be executed even if it was
>> queued.
> This is a basic guarantee provided by the RPC layer. Can you
> enumerate what other ways this path will fail without waking the bit
> wait? Are those issues going to impact other callback operations?
>
>
>>>>>>     			if (ncf->ncf_cb_status) {
>>>>>>     				status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>>>>>>     				if (status != nfserr_jukebox ||
>>>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>>>> index f96eaa8e9413..94563a6813a6 100644
>>>>>> --- a/fs/nfsd/state.h
>>>>>> +++ b/fs/nfsd/state.h
>>>>>> @@ -135,6 +135,8 @@ struct nfs4_cb_fattr {
>>>>>>     /* bits for ncf_cb_flags */
>>>>>>     #define	CB_GETATTR_BUSY		0
>>>>>> +#define	NFSD_CB_GETATTR_TIMEOUT	msecs_to_jiffies(20000) /* 20 secs */
>>>>>> +
>>>>>>     /*
>>>>>>      * Represents a delegation stateid. The nfs4_client holds references to these
>>>>>>      * and they are put when it is being destroyed or when the delegation is
>>>>>> -- 
>>>>>> 2.39.3
>>>>>>

