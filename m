Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA653487D69
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jan 2022 21:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiAGUCF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Jan 2022 15:02:05 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37076 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233856AbiAGUCF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Jan 2022 15:02:05 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 207HaxVW021187;
        Fri, 7 Jan 2022 20:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+8vToFNyR3rTveaCy5aH/BjQlMHhOplswC8JvqIC+IY=;
 b=ZqAJBm16jNpMoV7csaZUBbLxKHA0bosuGHwd7srracTPP9Kar+3ckXWYKhLnPpbu4AxQ
 KeQbhIR11TJaLtCiM4aYiSfCafSCcN0+EuS5VJC4PB625SAap08dNlpdpp+ZwKSuW7Bt
 y5vMfx4nwgm4egutj30HLO5neQZSxmSRoHBYb1yF/mrgm7SPhuRZza/neqSFSn0bron+
 uUx6FaYBTAeHN7EsBIAUB9Au1O1YPuBT+wCBacPTWHsRNDdlcKnNuTvvGKuIKpWv4dyt
 9t8KD0Tsslse9uAGL9wsMh7yf+bw7iKD2EVGoX2KZ82x41eGh+RnnBP5loiLdH8V8J4u Pg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4va2v4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 20:02:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 207K1kC7151504;
        Fri, 7 Jan 2022 20:02:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3020.oracle.com with ESMTP id 3dej4t8cr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 20:02:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/0acxRYjbBX3iNyMOHC3LHfh1Yd4X4PZy7a10ZxEoa+vNWjk1tvUlymjwwNhGl2KNKXW3rFlBQj7nW9g2gseN1ZG709H/BkPmZGKifVqXh0APKLymzcRPcQ7NuvH9Lms2i4s4c7mQsGVC/FcWnhEu2CMkWgzxH54zM+PWqa581Dkh84aAL1HVW1AFkANeQbwhFvDosYAy7i6lsNpZy1u/kFXCqKb+3iGejDA9Bl1e5mP1e4CC5HuWnac9gEpEUrdltp/5RpI46jdExGUns5G+zLkG21WV73lsdaRcdLqzZYNKwWkmQaBNUuQuxRUWGaw6jxKreTaIF5/Kp+ZZDpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8vToFNyR3rTveaCy5aH/BjQlMHhOplswC8JvqIC+IY=;
 b=TyRIPTIYbBOTC6KOx1c3w0w9QnO2Mpg6P7oBLR4rBgc/A5kFtI3LMqRye8enoDGVpbMX572hMLZD1ElDpxxDquJ+ZA/YPeno8VRbRJtKkhLvBuU9jVmGS2QHD1zNs2R3U0iXswiz13pu5HOyTYa7PbxB5m15APB0uXf5qVXMbxrJ7V7Ihg2r2MbxUn5BOuoVynoSUnpwnTKpW0bE6tKKHvykyQXJIQs7HTlzlWZfV1juBEn2+Pf6RoSSMKcchRUDSZbIB4qPL56i9vpQjYKiUeCm/SZuc13gP/BM+uqnaF+dDhgkxVtzOgsTduKwsKVRyC37IrmZY2TszAwZgJKAsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8vToFNyR3rTveaCy5aH/BjQlMHhOplswC8JvqIC+IY=;
 b=OqEJ5m6tz0L5g0s5UJah9waAhDcJn5kGPKYkl1d06Vdr+s+HMhtufzTjMkh6R7sQL2usYV1i0zYOte+wPknMkPgYj9U9XtRrzZ5cGLJBoYrZ+cXKJ9hxOqJMDXw2/MjLhKhIdqgZDs3DjWRu9PJGiEiy04jtORYJPbNllDjiMww=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB3954.namprd10.prod.outlook.com (2603:10b6:a03:1ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 20:01:59 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2531:1146:ae58:da29]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2531:1146:ae58:da29%7]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 20:01:59 +0000
Message-ID: <91f66c99-aac7-e47d-4c4e-b02d4b4778a3@oracle.com>
Date:   Fri, 7 Jan 2022 12:01:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: pynfs regression with nfs4.1 RNM18, RNM19 and RNM20 with ext4
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAPt2mGNF=iZkXGa93yjKQG5EsvUucun1TMhN5zM-6Gp07Bni2g@mail.gmail.com>
 <20220107171755.GD26961@fieldses.org>
 <46407a8e-8011-9cdc-4db5-5679e2b59957@oracle.com>
 <3D2F2375-DDF0-424F-925A-B3BF4457FFE2@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <3D2F2375-DDF0-424F-925A-B3BF4457FFE2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0042.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::19) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14c75bda-8c0a-4a81-9da1-08d9d218906d
X-MS-TrafficTypeDiagnostic: BY5PR10MB3954:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB39543CE6C348621DC99F969E874D9@BY5PR10MB3954.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h7F324/y2yghWES4pkYg9tYwvRCNK1rluTjg7W76xgaOgCjsVlKwKi0+yKXIFmMBtNCM9qa7BviAOG2ROQdy6Hn7vSjz4ar1HFIiQnT2bCnO8SH8rKuuZvYzRiu5ItwqNwy7VjceWMg3SeqrndETMd8NL10RsyljWInZyPR16Qj5Yd4rfu1kgOsi00CMMYP/NG3ELeYqgL6YO3Xm1NfPLGdx70tgjjCVlSumdjx6UdH5X/dkz0QZI8dxL13mvbLMNbSFFziNSCtzLU//jeoQC6nUhSxtYoDIGLMpsrpB6npme8w3coYai+70Xg7enbNwuA3o/I5Vt9gYW9FGDcmCck7kXoglRir5XXdseOT+sKejHf93fG2HxLgYTK1njPEHeW8zFx1Fn+Pch87f/TEej0E5NCbpsjo8rrte9tp78fUETO9oDCXtNX1Wo4+3SplWl65fGETp/01SUPLXsKZUhAi8i1I6CWSJNLo5pe9a6xWUwaFE0t5mRqAYfZGTl9auBa28Sp7Qf/HhvpUaMjNP7iVKYbmBY89aMIDPyfEk4UBy7FtaBo+llFjX9JA+Xp20dDj0WbQIogiu+JdrdL+IvI1dfQofAMTMPmozsMfn+drfoAbn2FYbwNvmRFELnh5EzWANVUZ739b7Fv5kN5RI0M0sdPTvfS2qqolSYJ/id6rIiEmDJDq/hRLpNvcoJ+byJh9aCz8+xFaDbN401XVBeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(37006003)(8676002)(186003)(6506007)(53546011)(31696002)(26005)(83380400001)(36756003)(2906002)(8936002)(86362001)(31686004)(316002)(508600001)(66556008)(4326008)(2616005)(66476007)(66946007)(4744005)(5660300002)(6862004)(38100700002)(6486002)(6512007)(9686003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTRNQ0NOWE1xZnZEbjdnRTRJRXVQTjQrR2RURE5vWHpHSzV6TERQLzVpVVEw?=
 =?utf-8?B?ZGtiRUVGZEtVVk5wNDREY3d6VkZFZ2hFMFo3N2phSG90UGdmNXNTT24zUGsr?=
 =?utf-8?B?ZW9vRVNtUkFiQXczcXlTQU4wNVpCUFdXTy9qK1BoRHlzZVowRkVpL2JKTmZn?=
 =?utf-8?B?Q01pNWhXMk5BMEp6Y0VYblc5MGNScGYrMFhZOU9XYkwwRTdOSDgzYUxPWktv?=
 =?utf-8?B?MVdVWkJVSHBRdzMwWVBBSjBNQTE1L1BVaWQ3VGZJcTVTUk85bFlHbmxHeCtZ?=
 =?utf-8?B?ZnUwV2c0NXZVU09QTCtINFpjcm83WmNDMlpLU0NIVmF3eDBxR1VUdXp3UHN2?=
 =?utf-8?B?MUxPTzFiTHJDRWtqMnlBNHFCalJZVmtrVXR0L1N6d3paVkpHSUJLSGhZUklJ?=
 =?utf-8?B?MkZ5VlorZlN3WUpNVUt0M1R6SVFTSzdETTdYTFVoKzh5bEVoZFJTM1NqMmVU?=
 =?utf-8?B?eGZUcUpSK0FQOUR6MzNuOVZ4ME9tMHgzK1dOU0RWeXBqUTBxQ3ZNR1pDeHdW?=
 =?utf-8?B?OGxDazV6Qmo1SzBJbU1nQXhCMmJDODlKV2JlblRWK0FKZVEvUSs1VzNCc1pj?=
 =?utf-8?B?MmgvVHE1dGtkZWI3aTRqK0Z0ampWWU0wL3YzN1Z6cEtmOGNBMFZRVjM4b0Jr?=
 =?utf-8?B?YVdzUVM1ZGRzMENGQUYyWEo4MWJHM1lVenFVNldYRXBMak9XbnZpYUpSZU9t?=
 =?utf-8?B?NUNXN2pOaC83NjlGc3U3TUttL1NMMkpEekE0aVlSK0NxaVJxRExaYXUyS1Y5?=
 =?utf-8?B?eTRYNzlYY1RmbytDUEQ0eW04TW0zb250VU9UWXlvbEtHVHdCWDFVeUFZbGFK?=
 =?utf-8?B?M21NQ1gzM0VYSjZqZmdkc2k4UUgwOWdSSFVzR0NDbEhxZEtXSk1QYnFBYzVs?=
 =?utf-8?B?czNNSmFxSVJCS21EaWg5VUtrZlZ2MmFVVGZtTWZVbWVJTkJaNzk0c2FFSVBB?=
 =?utf-8?B?ejF5d0M2MExENU9waUZ6UEFlaG1CWkVtNlhGbGl0L3pObWdTenhPa0JZeWNX?=
 =?utf-8?B?UXZpYWRRNVhQMG1lQlkvQjJuUks5Qm1DOGFxSThxQUFoTmdCbW1CeFhXNlgv?=
 =?utf-8?B?OVBGQzZZNHUzaENWOExVUUxqMWVrditrcnFUeFExZ2swSk1WSEVpckZKNDRI?=
 =?utf-8?B?RlF4b3lyUk1wV1JHNmxhQmdrUVczY3kwQkUyWmIrUDVqN25nZFlRTzBGTm96?=
 =?utf-8?B?eVk5bkhsV1dBYVRlVklUVGpyRFUvcHgxS3VERFlJRElGeG8yK3ZYM296OWJ2?=
 =?utf-8?B?dWY2d3cvQXJSMU93RjZhSW9ubzV5TjVyZ28yUUlqQ2tma214QTFEWXRLOGlM?=
 =?utf-8?B?aWFyeFpDQzh3eERKemJJckd0K2hQOE9mMUkzVFVHeHM2UmpYUWlIWkd1TTY5?=
 =?utf-8?B?cnUvRjEvN2o2NG96c090MWZYajJVYXgwdXNyVnpHZWJyd2JQekRPSThUczFv?=
 =?utf-8?B?dGpGNW5QZ0JBbUdDVW01ZjhBV29FTnh5Q0lVeU80OWx5bDVYdWE4SkJyeHN0?=
 =?utf-8?B?c3UvQlZjN3BpUEhjMmpWTm1pVnVMTlhCK0hzYUZkQlNvWHFtRElpZ0w1b2Fh?=
 =?utf-8?B?SUQ2YTQyZ0ZUazIrbGxDcjFmbjBoTStsSGMrTXJNU1ZuV3I1bVVJSFpUUUdC?=
 =?utf-8?B?ZUJXMkxVT21IVlFSOWRSRFd0b1RBQmxEWjhnU1FxUkNnK2Y0ZlVqUk5oMEVE?=
 =?utf-8?B?MXhaN0hMLzMxVXJZOGlMWU1DYWhWOFkxeXlFTTY4WGYrYUJXR25xd0Uwampw?=
 =?utf-8?B?dklvazQ3MFFMNVlSQU5tNFVhTk9sRnVPbHdSSFhYZElXb0RtVVREK0tDU1p3?=
 =?utf-8?B?djJlWmlmcFluclI3S2tKNmJhN3MxSVd5QjBQY2wwZUw5cmdQanJmYTh1b1Js?=
 =?utf-8?B?VFVkOW83aWZheUZZUmc3RDdzNHBtVkl6R250K2RoOXRXT1hMclhDY3M3MSti?=
 =?utf-8?B?V1JhR2lwY1I1ODI3NFkyTG02eFFodDlHMDY0RzFYblh3Wk5lTHNTcTVYSk9a?=
 =?utf-8?B?OXl1cFFyQ29UQmZ1TmM2Z2YyUlQrUXBzZDQ4dXc4N3Jway9VN0JzWldabUF2?=
 =?utf-8?B?bHVEM2FQWWtQOHQ4Vmlwa01QS0E2c3JYVlhMd0F0UXN6OXc4L2JBenB3K1lH?=
 =?utf-8?B?TTB3WHdDR2tsOFZXdjBUbTFjV3pPWWVFdzBvOGFvRDdTNjllVnVxNEpNYmUv?=
 =?utf-8?Q?Vgwd1mN/6JJDdQh8p1PRM/U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c75bda-8c0a-4a81-9da1-08d9d218906d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 20:01:59.5348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eude74lUAdQx9WnxaNWPMCulrlg+msffXUdwUhrLNKpDKpcAegyWjKqHIHUO4R7zzGwX+E425kqp6Js41wlbqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3954
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10220 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070123
X-Proofpoint-ORIG-GUID: Z_jNVAPwomhtFECrKgzkiSUSt2UJSfX8
X-Proofpoint-GUID: Z_jNVAPwomhtFECrKgzkiSUSt2UJSfX8
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 1/7/22 11:41 AM, Chuck Lever III wrote:
> Hi Dai-
>
>> On Jan 7, 2022, at 2:15 PM, dai.ngo@oracle.com wrote:
>>
>> Hi Bruce,
>>
>> Commit428a23d2bf0ca 'nfsd: skip some unnecessary stats in the v4 case' causes these tests to fail when the filesystem is ext4. It works fine with btrfs and xfs. The reason it fails with EXT4 is because ext4 does not have i_version-supporting. The SB_I_VERSION is not set in the super block so we skip the fh_getattr and just use fh_post_attr which is 0 to fill fh_post_change. I'm not quite sure what's the fix for this. If we skip the fs_getattr
>> for v4 thenfh_post_attr is 0 which causes the returned change attribute to be 0. -Dai
> I've got a fix for this issue scheduled for v5.17, and hopefully
> it can be back-ported to stable kernels too.

Thank you Chuck,

-Dai

