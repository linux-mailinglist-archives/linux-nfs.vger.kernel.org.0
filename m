Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4A6603032
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Oct 2022 17:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJRPwn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Oct 2022 11:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJRPwk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Oct 2022 11:52:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BA4C1D98
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 08:52:28 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IDxj1c006034;
        Tue, 18 Oct 2022 15:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=cpJwdkone2a59Gbzib8/hRHXheTjcZYasrtOtuAyOrs=;
 b=fahOdYkS5yWxPwANc9aGJpxpr+/KrKJRBtwuX6htxQdjYvNcGiRLZj94Fh2COMsUnkfz
 wkEnSPsrjrHjxEX/bv9lQ10acjfS9IWTd8tTr196e7MXpg12Y1uXjGf3jx6g5OoB9aLX
 pfbFWurNSbVzMSuUjksrXT3KQp5GZOlKVhKsEDhs1O27AIMCiWeMAuYi/bd6uHmjfiB8
 A6q862L9m1vs4I4Cj0mRmixE6DJTODLBIyY2UcH7u0xkfmLcbPiwoJ/QftEahO/VUKxG
 USyc5OjDhHKgaikqvEWm/W5Uk26XDbUT3tKe5nLMcgflXXzobPJqhnQ87ynBQDHKJVmE vQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99ntba6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 15:51:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29IF4Rf6028861;
        Tue, 18 Oct 2022 15:51:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hqyw0ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 15:51:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gou+ZaTtIqCQB8aTpRUsnlaog5VHzRVb/nVJ5Q/Ix/D5zuYUrlrYiUPh+iZ+Hnf4tA0Y2Bd580Z3okR3fXsKo3MTBomVmqUIjZk6WxzooDYURHjlGdFNXWx4+VKG1ClLJCkTylfAhHIBKj4/sgEBrTFQL2pOZsJU7DD6TPJ+MCVS7NzIu9xdyY23e4cgyRH+dDRsQ7OhltHBpB/qObi/lLNQqKDJpkX7t8ZHdHOD/gXEVl+kjIuyKwgJYysieS+IT56+qbs9F+uaCwo0YPHMEs5aXcYM+FHsEn+vU7YozLhGrlDJUY+vuSLs+a0IAISxOXwxEtvorcLTTTAufITzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpJwdkone2a59Gbzib8/hRHXheTjcZYasrtOtuAyOrs=;
 b=DBsBQOFXbS/Jh0HZl2JLWsLYkYIGnNrGLxENVAbjsrvjsVm/AuA1493Zfzsjq2aRtHuQ+Pxem/NHWbB2Bdd6tF6iP5161s8pwuwAm58XcE0n337asA8WibLX9BoeCo0oYLpT+ymsl4KWg+XV/Ct+r9Ck6CY5tbj7RJNBhkeCrB5PC/szBqMIjDrcNzhosCHDlf2o+jmGiE6SLzaZ8J86vJ49IIwMj4FEIwxOpoCUwfLV69Pk/CkwxAn0V4ojaCSaALlrz4ls2iCejIFeJKkZFr+FX4ZBxCcyX8s8bMZ33TThL8VMbH37+FPFoUGhc3Y84lpWOT2thHLnZiNCkD2zDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpJwdkone2a59Gbzib8/hRHXheTjcZYasrtOtuAyOrs=;
 b=VMPpjbFi3He5umghF1rjGLTYr9cnf6KJSGNcRs5EHkFKaZadKWA4MUowb67FcMlXNlXIQyNRhEfn98i+++51BmxbcIdVitCso8Ayh76dJzRqjv3BQTQvC8+LOZbL4o5J/QMiTcRHCSBVbW3ICJ1g8YaZbaNzQj68wGllBsibUiU=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH7PR10MB6356.namprd10.prod.outlook.com (2603:10b6:510:1b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 15:51:05 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::21ec:d1ee:2a59:a1d0]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::21ec:d1ee:2a59:a1d0%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 15:51:05 +0000
Message-ID: <b42e1cc3-2eba-9494-79bb-2574f785b1b3@oracle.com>
Date:   Tue, 18 Oct 2022 08:51:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH 2/2] NFSD: add delegation shrinker to react to low memory
 condition
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
References: <1666070139-18843-1-git-send-email-dai.ngo@oracle.com>
 <1666070139-18843-3-git-send-email-dai.ngo@oracle.com>
 <9d1be93452dc03f911c684946464b0862c93b965.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <9d1be93452dc03f911c684946464b0862c93b965.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:a03:332::9) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH7PR10MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: 176b16de-2623-4cc3-0dc6-08dab1209106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HtQUot0JWHwgaTutq7MRnEOQX7s60oWrwQGpm/LCo4JSSVeKXpMSEQFIXI5tiXauO2pEptdkPz0UoYTMrfW3Xmhc2DK5jEgAOdZ0p48FIeCMS+fdNuha9aH+o2Tz6nCODwK12igGMrO5cDYk//Qb5JsDs7Msp2aW2j79NI5T7uPCX7ghDQoSebxApFJNkXEpYqAI1FLE+eCs4CUgNnRRX5IBj1g9AKIERWe5XYW3BOiIbRDXG1jU8AgbX5dgydjDu4S+uGopjvncB9dimirBrfpXNMCE5tu9zUunDr4oKIsg8Zl2LSe2dINp+9SV91iHaE55J0PJQ/Q0EKj++QdfVAvlBCknokYzDf9je/Mgfnm9ViQeJmzH6EnJ5+1fuGGT0EBkcUXmO0gjDWXBxbM6e7rkNp46jRIeS83TGnrni9x9v1m4ISNMriJoj3mIh/bQMAjJkDLZgz+QJzdozDnzk07nbVtjicyBiyj2xFYuXMS/6idY3gyoa4HZwycJMO38eJ9hQ8L2IFvS7xdZT2P8WjW321kR7lrCS9AK9BYYdaV5Mhk8W+tCLbt79LhrFcx0PjKwMzQqc354qv3Kebzgx+JtPOhV4YCGeQNJkOA63sSry8Lo6bfdK6EpITxpyqk0qUhd5Yq03glzMXNEbBtzB/QOKgegPOf4Z8sWXTWkpSNd2qOGPmXpcjrfsqz1UlIgEieAjWRCdx+paBFNjPMxJlyM4n4CKsx3TYcMpGmckY1PaljCKRD2+tro2YmhIE4y0bLiKj+c1dMKPylLTV7dfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(36756003)(86362001)(31696002)(31686004)(38100700002)(2906002)(4001150100001)(186003)(5660300002)(2616005)(9686003)(53546011)(6506007)(26005)(6512007)(478600001)(83380400001)(6486002)(316002)(66946007)(66556008)(8676002)(66476007)(41300700001)(8936002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnhGY2NSLzF6c0ozWkV0VUJmbEt6Tk9lWmUzNTJSRFB5WDYvUTl2VHNZMmZp?=
 =?utf-8?B?a2laQ0h3QnNxbnpnUVdqeU9oWkp2L21kSzltR0w1NnJmSkJUNThJWEkxTjZR?=
 =?utf-8?B?TC9yZGVuejNNUlo1MmZYTGhMUTZQZnlRR0tkb1FPZW9PeExoVG1HOWgrYTEz?=
 =?utf-8?B?Ykg0K2ljVi9ieElsMjdyYWpmQ0xDTkkvT2VlN3ZSQnZvTHpiNWhZZFduUVcr?=
 =?utf-8?B?RkF6QjBjSWxqV29jd1ZUa0w4VnBUOS8xNkNVSE9yWDZxU2RSaWxGRHpqOXl5?=
 =?utf-8?B?SkxUQ1JUMFNrZGxMYThFL3lBbFVQYVg4aXhIdDAzSFlTSHRjY09oMG9ETTJK?=
 =?utf-8?B?VjBmdmY0ODBLZjFLMjZXWGltdTE2TXNvUkhUdVN6WEcxaWFNaWpRVVk3Rmov?=
 =?utf-8?B?em9idGJZZkg2ODZrdWR6L0RYZWcvY1l6VFpYUWY3dHZKckJyWWZ4WndxRW95?=
 =?utf-8?B?cWtadWdrN3g1SGRNVW1JdW5BNjl3T201alVVbU5LeVA3OW0zNkllS1Nzc2p2?=
 =?utf-8?B?WEVkaGtEK0hkQVpjK29KN29CeDV0VHNHSCtTTHM1aHlGWFlyekw1VHEwbnI2?=
 =?utf-8?B?VVV4K2VXd29hOCtlVEk4SXNIYkp5cjkwNnZnUVFEMWU4aitkRkF2ajhxMVRu?=
 =?utf-8?B?ZGkwNGFpc3FsQWt3R1cxaVQ4VTFSaTl6VjZ3U2t1b0RUci9LQVVpTWdHamkx?=
 =?utf-8?B?WVdMNzNnUHJ6OE1sY1YwdmdsY2RnYnF1c24rZ2tNMzBLTkVSc2ZYYVExZ0p3?=
 =?utf-8?B?UlZoY3Fmb3kzbE44U3N5SGt0aVlGVUMxOExybGVRYnJIWlBjLzllRTN4blVk?=
 =?utf-8?B?MlVFNmVWbFpheHloaWs0U0lVNUhkVU5PeW8xeXowaGxNK2k4OTJiaGhWYWt4?=
 =?utf-8?B?RytGZGlSWEtZZ1VDVzJXVGZpWWt2eGxCdjUvS1JKWWY3T2d0Ym4zZkxkZUQ5?=
 =?utf-8?B?OFFBYkpZTjZKYU5BOG11a1dKQ0xBYTJKZ2wvTld2NU8xaGVOUEgwZE4yMkdW?=
 =?utf-8?B?LzhKTFU0OWVYVmNSbDRyck4zMktxSjBITGFNY2VUbGFaMDdSaU01OHJBc0NL?=
 =?utf-8?B?Y3UvK0xTaU5uNnJacFNOaUljNy9MbG5oZ0o2Z2xDSFNGWHl3aFFUbTVZQWxr?=
 =?utf-8?B?SnFmWmlmMUppcTBkSWt4RnUvQjM5Sm5VRkc1ck5Mck5yV2ZDZVhRSUVTcmRW?=
 =?utf-8?B?Rk90ZTNEK1NGZFJpeFZtTWhwTUtva1RIN3FtTis5UXRobmFOcU9Pb3NDZ0xV?=
 =?utf-8?B?bkhjRFJYME9TOTM2VnQ3andwUGtkVDc2dkJ0azhHeVlHQ0FPWmlwcnIyVktm?=
 =?utf-8?B?VE0xUWJHVHZBUXp6c1MrTEY5VGt3eFJ0Z2xFS2tCZi9yQ09YL2RoeW1JcWNF?=
 =?utf-8?B?OGNxOTc5LzN1VGNGbjVLUGJTQkFsdWhCenNMY3lOSmlGNVgwRUpsVUphb3lQ?=
 =?utf-8?B?NVI1ZTBUSnZ5cFJZRldIVTZsQ3p2MHpEeWlodVZHNW5tTlB1OGpFRlhzY2Jm?=
 =?utf-8?B?b3BDeDhLUmZlQ3A4aHB4a0RHeExMckg1L1RiQ1UxSFlyYkpGQkhWL3JzNmsy?=
 =?utf-8?B?NllpRUVRVG5XT3YvOUVtM2NYQ2dSN0dTM1VGc242VXRnbzl2ZmdzcDBzT2pn?=
 =?utf-8?B?bGt3RkpzL1RCeldIcFR6bGhTZlpzZ1J6V1NFRm1lMENPUmswZmZDcGFESmxr?=
 =?utf-8?B?N0lBbjNrR2MwNEZMZmZPQWR5SHErUit2K1F0dTZpTnN0dHJrVm9HbFgyWkpH?=
 =?utf-8?B?eC80MUIwajBJd1BjVjVkZWNnQUx5VHFGbWpmUkxGaXBxNFkxbGhUMjZDWk5T?=
 =?utf-8?B?L1kyeW9pKzB4a09rRzJiZjBFVU5yUGdhVDNmUDJ2RXh3TmdpeDFmbG9IUnB6?=
 =?utf-8?B?TTczRHNGazh1TEVURUd5dU9mWnhuZHBOdThnS2tIa1phRDYyK24yQ2dOSjlF?=
 =?utf-8?B?ZVVUZDZzYXNZU0VvN2FGbXRtRkpUeXBjS3ZYc1dsNVFQc24wU0FKUjZ1RStB?=
 =?utf-8?B?VThPYURncDBvM2hqLytxcXdpQUphOUNSS3dxY1pLdmVyK0pNWnFKYjVaa1Jw?=
 =?utf-8?B?MDN0Mmo3c0hWbEhtUHAyQkdjcytzQUVzRjRreFRMSDJHekdwcEZzMjBPU1ZP?=
 =?utf-8?Q?GA6RzRlEJw+53pAC/esvWgO9F?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176b16de-2623-4cc3-0dc6-08dab1209106
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 15:51:05.7759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qalObNOayXmt2wRMULSrYT0cxhpc9ReiO9EpAflotpGS1GpXJv2B5esXkbE1PsQRTI+tE2d6+YHDnO4qwToutQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_06,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180090
X-Proofpoint-ORIG-GUID: kzLiVCWuUcFr_0Cs4to0IJC8ewtNJGMY
X-Proofpoint-GUID: kzLiVCWuUcFr_0Cs4to0IJC8ewtNJGMY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 10/18/22 6:07 AM, Jeff Layton wrote:
> On Mon, 2022-10-17 at 22:15 -0700, Dai Ngo wrote:
>> The delegation shrinker is scheduled to run on every shrinker's
>> 'count' callback. It scans the client list and sends the
>> courtesy CB_RECALL_ANY to the clients that hold delegations.
>>
>> To avoid flooding the clients with CB_RECALL_ANY requests, the
>> delegation shrinker is scheduled to run after a 5 seconds delay.
>>
> But...when the kernel needs memory, it generally needs it _now_, and 5s
> is a long time. It'd be better to not delay the initial sending of
> CB_RECALL_ANY callbacks this much.

yes, makes sense.

>
> Maybe the logic should be changed such that it runs no more frequently
> than once every 5s, but don't delay the initial sending of
> CB_RECALL_ANYs.

I'll make this adjustment.

Thanks,
-Dai

>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/netns.h     |  3 +++
>>   fs/nfsd/nfs4state.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   fs/nfsd/state.h     |  1 +
>>   3 files changed, 73 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>> index 8c854ba3285b..394a05fb46d8 100644
>> --- a/fs/nfsd/netns.h
>> +++ b/fs/nfsd/netns.h
>> @@ -196,6 +196,9 @@ struct nfsd_net {
>>   	atomic_t		nfsd_courtesy_clients;
>>   	struct shrinker		nfsd_client_shrinker;
>>   	struct delayed_work	nfsd_shrinker_work;
>> +
>> +	struct shrinker		nfsd_deleg_shrinker;
>> +	struct delayed_work	nfsd_deleg_shrinker_work;
>>   };
>>   
>>   /* Simple check to find out if a given net was properly initialized */
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index c60c937dece6..bdaea0e6e72f 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -4392,11 +4392,32 @@ nfsd_courtesy_client_scan(struct shrinker *shrink, struct shrink_control *sc)
>>   	return SHRINK_STOP;
>>   }
>>   
>> +static unsigned long
>> +nfsd_deleg_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
>> +{
>> +	unsigned long cnt;
>> +	struct nfsd_net *nn = container_of(shrink,
>> +				struct nfsd_net, nfsd_deleg_shrinker);
>> +
>> +	cnt = atomic_long_read(&num_delegations);
>> +	if (cnt)
>> +		mod_delayed_work(laundry_wq,
>> +			&nn->nfsd_deleg_shrinker_work, 5 * HZ);
>> +	return cnt;
>> +}
>> +
> What's the rationale for doing all of this in the count callback? Why
> not just return the value here and leave scheduling to the scan
> callback?
>
>> +static unsigned long
>> +nfsd_deleg_shrinker_scan(struct shrinker *shrink, struct shrink_control *sc)
>> +{
>> +	return SHRINK_STOP;
>> +}
>> +
>>   int
>>   nfsd4_init_leases_net(struct nfsd_net *nn)
>>   {
>>   	struct sysinfo si;
>>   	u64 max_clients;
>> +	int retval;
>>   
>>   	nn->nfsd4_lease = 90;	/* default lease time */
>>   	nn->nfsd4_grace = 90;
>> @@ -4417,13 +4438,23 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
>>   	nn->nfsd_client_shrinker.scan_objects = nfsd_courtesy_client_scan;
>>   	nn->nfsd_client_shrinker.count_objects = nfsd_courtesy_client_count;
>>   	nn->nfsd_client_shrinker.seeks = DEFAULT_SEEKS;
>> -	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
>> +	retval = register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
>> +	if (retval)
>> +		return retval;
>> +	nn->nfsd_deleg_shrinker.scan_objects = nfsd_deleg_shrinker_scan;
>> +	nn->nfsd_deleg_shrinker.count_objects = nfsd_deleg_shrinker_count;
>> +	nn->nfsd_deleg_shrinker.seeks = DEFAULT_SEEKS;
>> +	retval = register_shrinker(&nn->nfsd_deleg_shrinker, "nfsd-delegation");
>> +	if (retval)
>> +		unregister_shrinker(&nn->nfsd_client_shrinker);
>> +	return retval;
>>   }
>>   
>>   void
>>   nfsd4_leases_net_shutdown(struct nfsd_net *nn)
>>   {
>>   	unregister_shrinker(&nn->nfsd_client_shrinker);
>> +	unregister_shrinker(&nn->nfsd_deleg_shrinker);
>>   }
>>   
>>   static void init_nfs4_replay(struct nfs4_replay *rp)
>> @@ -6162,6 +6193,42 @@ courtesy_client_reaper(struct work_struct *reaper)
>>   	nfs4_process_client_reaplist(&reaplist);
>>   }
>>   
>> +static void
>> +deleg_reaper(struct work_struct *deleg_work)
>> +{
>> +	struct list_head *pos, *next;
>> +	struct nfs4_client *clp;
>> +	struct list_head cblist;
>> +	struct delayed_work *dwork = to_delayed_work(deleg_work);
>> +	struct nfsd_net *nn = container_of(dwork, struct nfsd_net,
>> +					nfsd_deleg_shrinker_work);
>> +
>> +	INIT_LIST_HEAD(&cblist);
>> +	spin_lock(&nn->client_lock);
>> +	list_for_each_safe(pos, next, &nn->client_lru) {
>> +		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> +		if (clp->cl_state != NFSD4_ACTIVE ||
>> +				list_empty(&clp->cl_delegations) ||
>> +				atomic_read(&clp->cl_delegs_in_recall) ||
>> +				clp->cl_recall_any_busy) {
>> +			continue;
>> +		}
>> +		clp->cl_recall_any_busy = true;
>> +		list_add(&clp->cl_recall_any_cblist, &cblist);
>> +
>> +		/* release in nfsd4_cb_recall_any_release */
>> +		atomic_inc(&clp->cl_rpc_users);
>> +	}
>> +	spin_unlock(&nn->client_lock);
>> +	list_for_each_safe(pos, next, &cblist) {
>> +		clp = list_entry(pos, struct nfs4_client, cl_recall_any_cblist);
>> +		list_del_init(&clp->cl_recall_any_cblist);
>> +		clp->cl_recall_any_bm = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
>> +						BIT(RCA4_TYPE_MASK_WDATA_DLG);
>> +		nfsd4_run_cb(&clp->cl_recall_any);
>> +	}
>> +}
>> +
>>   static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *stp)
>>   {
>>   	if (!fh_match(&fhp->fh_handle, &stp->sc_file->fi_fhandle))
>> @@ -7985,6 +8052,7 @@ static int nfs4_state_create_net(struct net *net)
>>   
>>   	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
>>   	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, courtesy_client_reaper);
>> +	INIT_DELAYED_WORK(&nn->nfsd_deleg_shrinker_work, deleg_reaper);
>>   	get_net(net);
>>   
>>   	return 0;
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 49ca06169642..05b572ce6605 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -415,6 +415,7 @@ struct nfs4_client {
>>   	bool			cl_recall_any_busy;
>>   	uint32_t		cl_recall_any_bm;
>>   	struct nfsd4_callback	cl_recall_any;
>> +	struct list_head	cl_recall_any_cblist;
>>   };
>>   
>>   /* struct nfs4_client_reset
