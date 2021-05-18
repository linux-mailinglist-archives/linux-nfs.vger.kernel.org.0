Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56598387D83
	for <lists+linux-nfs@lfdr.de>; Tue, 18 May 2021 18:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350647AbhERQbx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 May 2021 12:31:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35066 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245101AbhERQbw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 May 2021 12:31:52 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14IGR6Pw002751;
        Tue, 18 May 2021 16:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=LlMFb8d9f+or0fGKm7D40jJFPdh8AHOPR6ztPRIjKko=;
 b=ieXZ9ZLT1pmcpXulE44FEJfGdo49hdZtnlqCoO1o1GMLjNDhyRZVAcBQ+pOv+nGcex8F
 VNW+cFDKykbNNFUhrN+78X98G5utDh9OuBM0XBvgp2kfgElfz6NQUFEh4iYbsTGa45ZO
 yCl6vCoG3KJ6E4qSAeYZuziojbypSKHWdZdAF2zOxbn3gBYY7L/tAxTnkSKr/LNrw8eO
 vi699qBSFjFMthAPCVNk5dknBv5fWYjyAuWLcaD08SkTQw3CafONOWV/Pl5NL6Ulbjy8
 5zRb7dF6jmtIVzJtO/62o/WNpiv5dcMKYOWdN1IO8wJi75BIbWX4+gPYFC8NJPZFLvVO yg== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38kffu0rdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 16:30:31 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14IGR5q7064560;
        Tue, 18 May 2021 16:30:30 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by userp3020.oracle.com with ESMTP id 38kb383sq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 16:30:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxSl19b2E20+vKmxEhCw8/XxT55aRBMF5wvuKLNbGqlQCSAQnO+G+ImFbSKIiX8sXqiVeLVoAZ88E0ncWsTbtXE7FUjkYD5MhruSA5vVltKQdw30fKJ2hVAW1tXYx4nF6KxDLPqULpzJcEx3Rptka5zeXXJROKUcPxMJmFXBXV5qE9P0wx2mvNzGQZK/MPTMYyGRABmgdZwu8prZNkActwmKG8BdpP+B7JsuwlDs2/qE3eZ+60HjpO4+VY2RnVX+9ktKcx3JPt8wBz03zYUHB5VSG6r5EGC1U+53rj9iYixIiSBTQKAo0PywuJ9zLx8ikzzunPbC3E8mhuHt6+NgPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlMFb8d9f+or0fGKm7D40jJFPdh8AHOPR6ztPRIjKko=;
 b=IJjuO3aQ214+f7MiGSXw2WaN0wSCG5K6mfls/tIuzuq6V+epMKxu81e4Q/Nq9MLlq29bw9Rd9YfKKiMOR7Nln1C8uU+ayuF+lawfvcSOJQG7qsktHMgBvZd3a2rnGfhEbK9EI0Z7TwKePVGEf6E3K8pJWDpkO8XAfaTS69q4njKYhY8wjV5eFi5S32rfULga8o48GkQISQKT6WdXo1GyTwqWyoe8oc59m1AA2J08Huhgh/2Jx/tVV4e9rz63TO10OiVAK2ODKFE8+Vq72iz0BYXGkXka9rpPF2v/T152Ig+uL8A7uCq9hr48QhYzk6eG0TQIaYImwhSqh6xadHVhZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlMFb8d9f+or0fGKm7D40jJFPdh8AHOPR6ztPRIjKko=;
 b=m3APtuttrWlcUZlZjgYX1weE7/8p9l0qWajVv55dzDqLhg5TJx7X8niK9TnQggjbKcgW4LCDNVCqXWDgl8DCbhRFiQ8iJbRpA/045AnM0sxs9TYaxBEHBuehbKneOXpHoAInhUI3rtRIL1XFIMXbQpY3J+B4tUcg6lBX9BSbyNU=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3142.namprd10.prod.outlook.com (2603:10b6:a03:14e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 16:30:26 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879%4]) with mapi id 15.20.4129.033; Tue, 18 May 2021
 16:30:26 +0000
Subject: Re: [PATCH v5 1/2] NFSD: delay unmount source's export after
 inter-server copy completed.
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
References: <20210517224330.9201-1-dai.ngo@oracle.com>
 <20210517224330.9201-2-dai.ngo@oracle.com>
 <CAN-5tyHBpRj526G2Phbt6yEEjeYR3ms2-0P1TsZwY=ZMpj_7Rw@mail.gmail.com>
From:   dai.ngo@oracle.com
Message-ID: <15328931-1eeb-36f1-1eea-1716605ee5b7@oracle.com>
Date:   Tue, 18 May 2021 09:30:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <CAN-5tyHBpRj526G2Phbt6yEEjeYR3ms2-0P1TsZwY=ZMpj_7Rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SA0PR11CA0093.namprd11.prod.outlook.com
 (2603:10b6:806:d1::8) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-230-11.vpn.oracle.com (72.219.112.78) by SA0PR11CA0093.namprd11.prod.outlook.com (2603:10b6:806:d1::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 18 May 2021 16:30:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 923e7518-caf8-43a8-31ad-08d91a1a3e4f
X-MS-TrafficTypeDiagnostic: BYAPR10MB3142:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3142C3EE966D71B1389752DA872C9@BYAPR10MB3142.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:281;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVv34OjJfAZO46Sh0gschW7FX9rBfvyXLjjpmj/VtS5KRj926dF+4Gd1pJsMFIRQxZ204Az2LTxkDX8BzwQ4uSfPUZABUFUr7RrKbqJuiOd0j+MTYb7kctn8GoZftg1Gd2f0oOlHu8v5GUYPObzKMAJC/sXGCn6DjLbUXEPcKq8xViw7pdoohj88kjmX4bC6p/xbQkrNSXEkR7L4qv2wppk09mQCGsX1wBgTYLBCLliu40d/VUy85ft9ep37BNmCarNxYlXbPOnS2rnIgfSvabALuO2Zp9D4yeBfPJ9zZIQ3os/ykUshs1f7JR14+iuh1nH3gpz5VvGN40MsHmXnSzJN3BXAz6ODMGZ0tNsfEFE8PSMEClyNElweAz9F7DfW0AsuxzyD2xc0Qn884rCgzWXZD12lTUQWhatP6mRcwWVTUtod6IXVAZEIkak3g/hZGQ2pa+YSCUWtR6yP58M55HS6n79xN64RjEzGe9E3xBeK9mtA9eWKDkRq4Bha/lxA79UMM1Vr4zNHy/QYRUsOKwLD1jYjmna3YrAr/wF8RVLe10+E7li3f1zNRZOkNx8eJ3MiV2rN430BkfDW2wVMpFtu++aipHK9k3y8hNFQI4Y2LDBI/mvgHvuYTXdZxRqy5kvFxDzxx/DdNTTKBfqh+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(136003)(346002)(39860400002)(7696005)(2616005)(16526019)(26005)(8936002)(956004)(6916009)(53546011)(86362001)(186003)(8676002)(31696002)(38100700002)(107886003)(4326008)(31686004)(316002)(30864003)(5660300002)(478600001)(66946007)(66476007)(66556008)(6486002)(54906003)(9686003)(36756003)(83380400001)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RktRL1VULzVnakxKWHBKeHh5MkMyZTA3VlljaU03c2FaN0wwbHcwUW9wb1Z6?=
 =?utf-8?B?Q1RaRTVJeUFSVjRKWlZwTmJUSldHcmRlSnpUOGhnY1dBVkl1UWVyTWR0eVA1?=
 =?utf-8?B?RUhaRWNiTlM3MkRrbElYdzlFTDB5eG9MZXdLTkJna3ZZamo4MjQ3eThKK1hV?=
 =?utf-8?B?MXg0aU84eXNxOXJSWm5kL1NHRG11aEpFZjIyaUJhVTZNQmxuZnBoQUZETXZq?=
 =?utf-8?B?eHZJZUR0VnFlOFJaY1BLK3ZIaUd4cDdFRGMyWjUzbFRMKy8xMUM0eDJ6K3gv?=
 =?utf-8?B?aHFFYW9xUGU3dG4ra2dIdzRoQkw0dnM4Z3c2UmJtRG42V2pBWjh2Qmg0WDdu?=
 =?utf-8?B?a1k3WjBJNlJOazlrc01lbXdHNHlpenZpemUyb1UxSXBDVTFuOVZiMGpBeXI1?=
 =?utf-8?B?bTkwZkpia2hWUjliMVVhOTJYanRYSjhZQmM5akJwU0NUTlBxOVF3aFVDdXp5?=
 =?utf-8?B?ZEVjZ2hTRnd2NmxuK0hIaExxMFJRQVpyTk94Tk9oRHNZbEtNVmxhT053dUk3?=
 =?utf-8?B?V1dzd3Q0cnJUdnhQMkk3ejRJQmEySml3VUxSa3NObm5ZamJ0ekZtTXdQWmQx?=
 =?utf-8?B?WDcySVZwS25jZENsdUV3cWtadnpMeU1NUGNHS2kxWVdBUCtpVE8xU2EwdDFL?=
 =?utf-8?B?OHFudWVGQTdHb2xYUlQ5ZlZucUNCcG85QWIwVDROVEErd2hXVXVLMU54cEhp?=
 =?utf-8?B?TVhDcHRLZ2xBa0ZxZmVLZ0tsbFlkT2tkM0lQVmNVNTQwb0JpWWJyTTgwaUJk?=
 =?utf-8?B?U3N6TWovclpOK0tyRkZaU3B4eDdnYXZBVktyOEM0TG50WG84V09wVWpaMXR4?=
 =?utf-8?B?bG9IOGh2TG52VFVSVHB6NzFEbTlNS2JibnNpcHQ3OVk0QlZCN2xNUmZyNXAx?=
 =?utf-8?B?NDFjMldZRVJselZzRWUrUERUejZhNFZ0Z0ZYNUNsVEN3Vjd6QlRDL3llcTBN?=
 =?utf-8?B?SUdJT09wUUg4SXBESjkycFVqWmNCY0JxVTYyOGVFdlFPNG9xTEZZR1VYa3dU?=
 =?utf-8?B?VUFENkJPUjBvOHdZTXlmc3lkUUg5MGFCWi9uWTZmQWs0bWk5UnRpZjVNaHBH?=
 =?utf-8?B?M09aMVdTZ2tNS3J6dE5sZ25GbHZCVkZuVVllYTRyK2twMU9pSk5IbFNXV1lE?=
 =?utf-8?B?cEZSN05oZU1tQlAwNHQ0SUJsbWx3L2RqVkdXY2RLc0ZXbDQ5S0hIWk5lcFJN?=
 =?utf-8?B?WEdBdGpsZlh4ajhwZTE0NU9uYkplam94K09PVUVBMlNxSG1hQWJORUFPQWtT?=
 =?utf-8?B?NXZWTStjUGw0YWp1UDNVcVJVOEpWemRqQkN4WUJUdDBjaUpmb1lScGI0YTJ5?=
 =?utf-8?B?UHU4RGJUbG56VVozQ00vS20ySTZYbWsyblFUdExDbUFNV0x6aGFWUnM1YVln?=
 =?utf-8?B?Q1FVRjRVQlF6Q3Y3SzN5STBBL1NSb0tNNnZzR3c2c1I4ckxLSmZzMXdsQXgz?=
 =?utf-8?B?dEhZNm15MzNYSG8yaUd6NmVsQlF6V1g4NXdDMVV3K0d0M05RdHlrRlFPTkln?=
 =?utf-8?B?RVNRWmVCODgyYmpNa0xMUUs5eTRyVC9WcWU4MXpId05RbjQ5ejkzd1JKTnl1?=
 =?utf-8?B?WEVVOW9oYkE0ZVFxWkM4dWRwQmVPcE1Sbk05dFN3YmhiSlQyaml5QWl4OHkv?=
 =?utf-8?B?S21NeVdrY3ovcC9TSzMrbTRET0NGajk4N3EwQjZibW13TThMb05TK20yRmJE?=
 =?utf-8?B?dTZ6NThsakNlTUpaVktaNVVkNmkyMUp2eXpnVWpZN0FvUjdna3Q0YWYzUDBH?=
 =?utf-8?Q?G80atz3NaHnqongctm3Ap+QrXW4K+7AWyQpGB2H?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923e7518-caf8-43a8-31ad-08d91a1a3e4f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 16:30:26.8197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfnMnI/slR2HYkepJhsdm7DaNhKBCoiPJ78F5aCO4QvnAkxOc1tWxlZ68ZgX1ma9/y0nffqwrcG+WyGNuHYWDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3142
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9988 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105180112
X-Proofpoint-ORIG-GUID: C2tOubwzP4wy048h9RzarrTgarATmreS
X-Proofpoint-GUID: C2tOubwzP4wy048h9RzarrTgarATmreS
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 5/18/21 9:28 AM, Olga Kornievskaia wrote:
> On Mon, May 17, 2021 at 6:43 PM Dai Ngo <dai.ngo@oracle.com> wrote:
>> Currently the source's export is mounted and unmounted on every
>> inter-server copy operation. This patch is an enhancement to delay
>> the unmount of the source export for a certain period of time to
>> eliminate the mount and unmount overhead on subsequent copy operations.
>>
>> After a copy operation completes, a delayed task is scheduled to
>> unmount the export after a configurable idle time. Each time the
>> export is being used again, its expire time is extended to allow
>> the export to remain mounted.
>>
>> The unmount task and the mount operation of the copy request are
>> synced to make sure the export is not unmounted while it's being
>> used.
> Can you tell me what this should apply on top of? It doesn't apply to
> 5.13-rc2. I know Chuck posted a lot of nfsd patches which I don't
> have, is your patch on top of that?

I built it on top of 5.12-rc8.

-Dai

>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/netns.h         |   5 ++
>>   fs/nfsd/nfs4proc.c      | 216 +++++++++++++++++++++++++++++++++++++++++++++++-
>>   fs/nfsd/nfs4state.c     |   8 ++
>>   fs/nfsd/nfsd.h          |   6 ++
>>   fs/nfsd/nfssvc.c        |   3 +
>>   include/linux/nfs_ssc.h |  16 ++++
>>   6 files changed, 250 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>> index c330f5bd0cf3..6018e5050cb4 100644
>> --- a/fs/nfsd/netns.h
>> +++ b/fs/nfsd/netns.h
>> @@ -21,6 +21,7 @@
>>
>>   struct cld_net;
>>   struct nfsd4_client_tracking_ops;
>> +struct nfsd4_ssc_umount;
>>
>>   enum {
>>          /* cache misses due only to checksum comparison failures */
>> @@ -176,6 +177,10 @@ struct nfsd_net {
>>          unsigned int             longest_chain_cachesize;
>>
>>          struct shrinker         nfsd_reply_cache_shrinker;
>> +
>> +       spinlock_t              nfsd_ssc_lock;
>> +       struct nfsd4_ssc_umount *nfsd_ssc_umount;
>> +
>>          /* utsname taken from the process that starts the server */
>>          char                    nfsd_name[UNX_MAXNODENAME+1];
>>   };
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index dd9f38d072dd..892ad72d87ae 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -55,6 +55,99 @@ module_param(inter_copy_offload_enable, bool, 0644);
>>   MODULE_PARM_DESC(inter_copy_offload_enable,
>>                   "Enable inter server to server copy offload. Default: false");
>>
>> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
>> +static int nfsd4_ssc_umount_timeout = 900000;          /* default to 15 mins */
>> +module_param(nfsd4_ssc_umount_timeout, int, 0644);
>> +MODULE_PARM_DESC(nfsd4_ssc_umount_timeout,
>> +               "idle msecs before unmount export from source server");
>> +
>> +void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
>> +{
>> +       bool do_wakeup = false;
>> +       struct nfsd4_ssc_umount_item *ni = 0;
>> +       struct nfsd4_ssc_umount_item *tmp;
>> +       struct nfsd4_ssc_umount *nu;
>> +
>> +       spin_lock(&nn->nfsd_ssc_lock);
>> +       if (!nn->nfsd_ssc_umount) {
>> +               spin_unlock(&nn->nfsd_ssc_lock);
>> +               return;
>> +       }
>> +       nu = nn->nfsd_ssc_umount;
>> +       list_for_each_entry_safe(ni, tmp, &nu->nsu_list, nsui_list) {
>> +               if (time_after(jiffies, ni->nsui_expire)) {
>> +                       if (refcount_read(&ni->nsui_refcnt) > 0)
>> +                               continue;
>> +
>> +                       /* mark being unmount */
>> +                       ni->nsui_busy = true;
>> +                       spin_unlock(&nn->nfsd_ssc_lock);
>> +                       mntput(ni->nsui_vfsmount);
>> +                       spin_lock(&nn->nfsd_ssc_lock);
>> +
>> +                       /* waiters need to start from begin of list */
>> +                       list_del(&ni->nsui_list);
>> +                       kfree(ni);
>> +
>> +                       /* wakeup ssc_connect waiters */
>> +                       do_wakeup = true;
>> +                       continue;
>> +               }
>> +               break;
>> +       }
>> +       if (!list_empty(&nu->nsu_list)) {
>> +               ni = list_first_entry(&nu->nsu_list,
>> +                       struct nfsd4_ssc_umount_item, nsui_list);
>> +               nu->nsu_expire = ni->nsui_expire;
>> +       } else
>> +               nu->nsu_expire = 0;
>> +
>> +       if (do_wakeup)
>> +               wake_up_all(&nu->nsu_waitq);
>> +       spin_unlock(&nn->nfsd_ssc_lock);
>> +}
>> +
>> +/*
>> + * This is called when nfsd is being shutdown, after all inter_ssc
>> + * cleanup were done, to destroy the ssc delayed unmount list.
>> + */
>> +void nfsd4_ssc_shutdown_umount(struct nfsd_net *nn)
>> +{
>> +       struct nfsd4_ssc_umount_item *ni = 0;
>> +       struct nfsd4_ssc_umount_item *tmp;
>> +       struct nfsd4_ssc_umount *nu;
>> +
>> +       spin_lock(&nn->nfsd_ssc_lock);
>> +       if (!nn->nfsd_ssc_umount) {
>> +               spin_unlock(&nn->nfsd_ssc_lock);
>> +               return;
>> +       }
>> +       nu = nn->nfsd_ssc_umount;
>> +       nn->nfsd_ssc_umount = 0;
>> +       list_for_each_entry_safe(ni, tmp, &nu->nsu_list, nsui_list) {
>> +               list_del(&ni->nsui_list);
>> +               spin_unlock(&nn->nfsd_ssc_lock);
>> +               mntput(ni->nsui_vfsmount);
>> +               kfree(ni);
>> +               spin_lock(&nn->nfsd_ssc_lock);
>> +       }
>> +       spin_unlock(&nn->nfsd_ssc_lock);
>> +       kfree(nu);
>> +}
>> +
>> +void nfsd4_ssc_init_umount_work(struct nfsd_net *nn)
>> +{
>> +       nn->nfsd_ssc_umount = kzalloc(sizeof(struct nfsd4_ssc_umount),
>> +                                       GFP_KERNEL);
>> +       if (!nn->nfsd_ssc_umount)
>> +               return;
>> +       spin_lock_init(&nn->nfsd_ssc_lock);
>> +       INIT_LIST_HEAD(&nn->nfsd_ssc_umount->nsu_list);
>> +       init_waitqueue_head(&nn->nfsd_ssc_umount->nsu_waitq);
>> +}
>> +EXPORT_SYMBOL_GPL(nfsd4_ssc_init_umount_work);
>> +#endif
>> +
>>   #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>>   #include <linux/security.h>
>>
>> @@ -1181,6 +1274,12 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>          char *ipaddr, *dev_name, *raw_data;
>>          int len, raw_len;
>>          __be32 status = nfserr_inval;
>> +       struct nfsd4_ssc_umount_item *ni = 0;
>> +       struct nfsd4_ssc_umount_item *work = NULL;
>> +       struct nfsd4_ssc_umount_item *tmp;
>> +       struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>> +       struct nfsd4_ssc_umount *nu;
>> +       DEFINE_WAIT(wait);
>>
>>          naddr = &nss->u.nl4_addr;
>>          tmp_addrlen = rpc_uaddr2sockaddr(SVC_NET(rqstp), naddr->addr,
>> @@ -1229,12 +1328,76 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>                  goto out_free_rawdata;
>>          snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
>>
>> +       work = kzalloc(sizeof(*work), GFP_KERNEL);
>> +try_again:
>> +       spin_lock(&nn->nfsd_ssc_lock);
>> +       if (!nn->nfsd_ssc_umount) {
>> +               spin_unlock(&nn->nfsd_ssc_lock);
>> +               kfree(work);
>> +               work = NULL;
>> +               goto skip_dul;
>> +       }
>> +       nu = nn->nfsd_ssc_umount;
>> +       list_for_each_entry_safe(ni, tmp, &nu->nsu_list, nsui_list) {
>> +               if (strncmp(ni->nsui_ipaddr, ipaddr, sizeof(ni->nsui_ipaddr)))
>> +                       continue;
>> +               /* found a match */
>> +               if (ni->nsui_busy) {
>> +                       /*  wait - and try again */
>> +                       prepare_to_wait(&nu->nsu_waitq, &wait,
>> +                               TASK_INTERRUPTIBLE);
>> +                       spin_unlock(&nn->nfsd_ssc_lock);
>> +
>> +                       /* allow 20secs for mount/unmount for now - revisit */
>> +                       if (signal_pending(current) ||
>> +                                       (schedule_timeout(20*HZ) == 0)) {
>> +                               status = nfserr_eagain;
>> +                               kfree(work);
>> +                               goto out_free_devname;
>> +                       }
>> +                       finish_wait(&nu->nsu_waitq, &wait);
>> +                       goto try_again;
>> +               }
>> +               ss_mnt = ni->nsui_vfsmount;
>> +               if (refcount_read(&ni->nsui_refcnt) == 0)
>> +                       refcount_set(&ni->nsui_refcnt, 1);
>> +               else
>> +                       refcount_inc(&ni->nsui_refcnt);
>> +               spin_unlock(&nn->nfsd_ssc_lock);
>> +               kfree(work);
>> +               goto out_done;
>> +       }
>> +       /* create new entry, set busy, insert list, clear busy after mount */
>> +       if (work) {
>> +               strncpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr));
>> +               refcount_set(&work->nsui_refcnt, 1);
>> +               work->nsui_busy = true;
>> +               list_add_tail(&work->nsui_list, &nu->nsu_list);
>> +       }
>> +       spin_unlock(&nn->nfsd_ssc_lock);
>> +skip_dul:
>> +
>>          /* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
>>          ss_mnt = vfs_kern_mount(type, SB_KERNMOUNT, dev_name, raw_data);
>>          module_put(type->owner);
>> -       if (IS_ERR(ss_mnt))
>> +       if (IS_ERR(ss_mnt)) {
>> +               if (work) {
>> +                       spin_lock(&nn->nfsd_ssc_lock);
>> +                       list_del(&work->nsui_list);
>> +                       wake_up_all(&nu->nsu_waitq);
>> +                       spin_unlock(&nn->nfsd_ssc_lock);
>> +                       kfree(work);
>> +               }
>>                  goto out_free_devname;
>> -
>> +       }
>> +       if (work) {
>> +               spin_lock(&nn->nfsd_ssc_lock);
>> +               work->nsui_vfsmount = ss_mnt;
>> +               work->nsui_busy = false;
>> +               wake_up_all(&nu->nsu_waitq);
>> +               spin_unlock(&nn->nfsd_ssc_lock);
>> +       }
>> +out_done:
>>          status = 0;
>>          *mount = ss_mnt;
>>
>> @@ -1301,10 +1464,55 @@ static void
>>   nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
>>                          struct nfsd_file *dst)
>>   {
>> +       bool found = false;
>> +       bool resched = false;
>> +       long timeout;
>> +       struct nfsd4_ssc_umount_item *tmp;
>> +       struct nfsd4_ssc_umount_item *ni = 0;
>> +       struct nfsd4_ssc_umount *nu;
>> +       struct nfsd_net *nn = net_generic(dst->nf_net, nfsd_net_id);
>> +
>>          nfs42_ssc_close(src->nf_file);
>> -       fput(src->nf_file);
>>          nfsd_file_put(dst);
>> -       mntput(ss_mnt);
>> +       fput(src->nf_file);
>> +
>> +       if (!nn) {
>> +               mntput(ss_mnt);
>> +               return;
>> +       }
>> +       spin_lock(&nn->nfsd_ssc_lock);
>> +       if (!nn->nfsd_ssc_umount) {
>> +               /* delayed unmount list not setup */
>> +               spin_unlock(&nn->nfsd_ssc_lock);
>> +               mntput(ss_mnt);
>> +               return;
>> +       }
>> +       nu = nn->nfsd_ssc_umount;
>> +       timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>> +       list_for_each_entry_safe(ni, tmp, &nu->nsu_list, nsui_list) {
>> +               if (ni->nsui_vfsmount->mnt_sb == ss_mnt->mnt_sb) {
>> +                       list_del(&ni->nsui_list);
>> +                       /*
>> +                        * vfsmount can be shared by multiple exports,
>> +                        * decrement refcnt and schedule delayed task
>> +                        * if it drops to 0.
>> +                        */
>> +                       if (refcount_dec_and_test(&ni->nsui_refcnt))
>> +                               resched = true;
>> +                       ni->nsui_expire = jiffies + timeout;
>> +                       list_add_tail(&ni->nsui_list, &nu->nsu_list);
>> +                       found = true;
>> +                       break;
>> +               }
>> +       }
>> +       if (!found) {
>> +               spin_unlock(&nn->nfsd_ssc_lock);
>> +               mntput(ss_mnt);
>> +               return;
>> +       }
>> +       if (resched && !nu->nsu_expire)
>> +               nu->nsu_expire = ni->nsui_expire;
>> +       spin_unlock(&nn->nfsd_ssc_lock);
>>   }
>>
>>   #else /* CONFIG_NFSD_V4_2_INTER_SSC */
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 97447a64bad0..0cdc898f06c9 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -5459,6 +5459,11 @@ nfs4_laundromat(struct nfsd_net *nn)
>>                  list_del_init(&nbl->nbl_lru);
>>                  free_blocked_lock(nbl);
>>          }
>> +
>> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
>> +       /* service the inter-copy delayed unmount list */
>> +       nfsd4_ssc_expire_umount(nn);
>> +#endif
>>   out:
>>          new_timeo = max_t(time64_t, new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
>>          return new_timeo;
>> @@ -7398,6 +7403,9 @@ nfs4_state_shutdown_net(struct net *net)
>>
>>          nfsd4_client_tracking_exit(net);
>>          nfs4_state_destroy_net(net);
>> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
>> +       nfsd4_ssc_shutdown_umount(nn);
>> +#endif
>>          mntput(nn->nfsd_mnt);
>>   }
>>
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 8bdc37aa2c2e..cf86d9010974 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -483,6 +483,12 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
>>   extern int nfsd4_is_junction(struct dentry *dentry);
>>   extern int register_cld_notifier(void);
>>   extern void unregister_cld_notifier(void);
>> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
>> +extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
>> +extern void nfsd4_ssc_expire_umount(struct nfsd_net *nn);
>> +extern void nfsd4_ssc_shutdown_umount(struct nfsd_net *nn);
>> +#endif
>> +
>>   #else /* CONFIG_NFSD_V4 */
>>   static inline int nfsd4_is_junction(struct dentry *dentry)
>>   {
>> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
>> index 6de406322106..ce89a8fe07ff 100644
>> --- a/fs/nfsd/nfssvc.c
>> +++ b/fs/nfsd/nfssvc.c
>> @@ -403,6 +403,9 @@ static int nfsd_startup_net(int nrservs, struct net *net, const struct cred *cre
>>          if (ret)
>>                  goto out_filecache;
>>
>> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
>> +       nfsd4_ssc_init_umount_work(nn);
>> +#endif
>>          nn->nfsd_net_up = true;
>>          return 0;
>>
>> diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
>> index f5ba0fbff72f..18afe62988b5 100644
>> --- a/include/linux/nfs_ssc.h
>> +++ b/include/linux/nfs_ssc.h
>> @@ -8,6 +8,7 @@
>>    */
>>
>>   #include <linux/nfs_fs.h>
>> +#include <linux/sunrpc/svc.h>
>>
>>   extern struct nfs_ssc_client_ops_tbl nfs_ssc_client_tbl;
>>
>> @@ -52,6 +53,21 @@ static inline void nfs42_ssc_close(struct file *filep)
>>          if (nfs_ssc_client_tbl.ssc_nfs4_ops)
>>                  (*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
>>   }
>> +
>> +struct nfsd4_ssc_umount_item {
>> +       struct list_head nsui_list;
>> +       bool nsui_busy;
>> +       refcount_t nsui_refcnt;
>> +       unsigned long nsui_expire;
>> +       struct vfsmount *nsui_vfsmount;
>> +       char nsui_ipaddr[RPC_MAX_ADDRBUFLEN];
>> +};
>> +
>> +struct nfsd4_ssc_umount {
>> +       struct list_head nsu_list;
>> +       unsigned long nsu_expire;
>> +       wait_queue_head_t nsu_waitq;
>> +};
>>   #endif
>>
>>   /*
>> --
>> 2.9.5
>>
