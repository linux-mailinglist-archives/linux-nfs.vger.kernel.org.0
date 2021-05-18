Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABC4387EEB
	for <lists+linux-nfs@lfdr.de>; Tue, 18 May 2021 19:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345614AbhERRth (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 May 2021 13:49:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21632 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345084AbhERRtg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 May 2021 13:49:36 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14IHfNFc030982;
        Tue, 18 May 2021 17:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=jNgFXxSu5rdaZNn3Jwnzn0OMgoy+P7/hE5pQU3kXmEw=;
 b=FuF/+46YHnyCyh8eQnZjxKCkuJc3LgAktvCQ53cLlXVzKyzWg+aOK77+/yKe6sFxX0OU
 cDFP27in7uS+otTzUyK+2CQSX3B6UW+Is2s+Ks8o+V4Fr+SNdk4M4wrK3/Kt8/H/EHbK
 /8SSMO0Zelw+AQcJp8AKunHUurG08yCoD+eLHXHrOS0molKoDgPezMbSXqCyBRBizXgO
 p5DHKRoSP41cTfePqGte/Vz7F9bsMCA04YORww5W4gHob5zEPvzFtewv4CF01+3LgdMU
 3mQ9SUz1XyIDlUexgXf29QsVTvvKL6wZtUzJVuvBwHxNjatxB9NfQ5q0+MFN5ZWwhPPc QA== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38ker18sqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 17:48:14 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14IHknCu192330;
        Tue, 18 May 2021 17:48:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by userp3030.oracle.com with ESMTP id 38megjpvrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 17:48:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdtLsuq7534okAYtKx6DHQWidN4viKTRrv2of9LsOtmwuDzlYV1Io6/Nu+r8sCvW85g8gW+CNZBbA9KFXbX2eX6IdckFq+tnH9KtK4EKdTn+rzIqAENlR5oMn4CaJQxgk+eqvzqsgN+rLiF5Fo+BmP9xzYBtQj3imw34TIhpl7M4PbhuPSo88LtiHVLWx4NzncsauVXUYbJZNJwxkiGsVyJPA39koCmeKgRQ76rtxSuNkKhIFeBALZeFfoYufHW9JVcmZVpqUc8Ro6wiy6MA0FOgamPUicaQnL42P/Pp+uXL578sjN4aEiYLQ+h3tuIlGHaJNQRjmdf42cjGNzYL2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNgFXxSu5rdaZNn3Jwnzn0OMgoy+P7/hE5pQU3kXmEw=;
 b=nNniiXTSbfyfiyc5Lyb+Al1mgz+j0oXU1aD13Yr6vgEjYG9ZTE8plVj2bxj/kYnLe63OkiRUNio+8SGF7TUAfpMG9c5xuohL9BVO1m/gbbwLzAoOMGUDH3eR9XW1iTZ44+7tBNs1HrXNBQjxW6lS/5Ua8BTmYiNbh3uKJryg/MJPHcOJrYSGrChDOMS4GszuiTnZXSZT27qWwuHEKLpRvwDHGZHaE084KRVoZBqDB2nOwM4YHEoN7uNj7+lqDOvMBXWqE2yxUMAvaIbdRqiwXPfGPdNKudFYzhlfQWZl6tMnf2G4tsVsAJSGlonPnkqkPOhGKEOJxtvu0JBCey9EGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNgFXxSu5rdaZNn3Jwnzn0OMgoy+P7/hE5pQU3kXmEw=;
 b=G8KDFO2UWPxCpHYjOT7zVl0FKajzvY2U7ntfu2Dv2+Ac7uPHqoJYG+Lo5M5EaX/ZLjt+n7Ed0ORYutdetxDwM8ZzXEuPpWBf9rwYMz2h4YT78xlVxNHuXookmS2Z3WJtcYlAslq8xk+8clGgqV/mWEjRuY4xf64ghkDewRWnOYY=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4656.namprd10.prod.outlook.com (2603:10b6:a03:2d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 18 May
 2021 17:48:10 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879%4]) with mapi id 15.20.4129.033; Tue, 18 May 2021
 17:48:10 +0000
Subject: Re: [PATCH v5 1/2] NFSD: delay unmount source's export after
 inter-server copy completed.
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
References: <20210517224330.9201-1-dai.ngo@oracle.com>
 <20210517224330.9201-2-dai.ngo@oracle.com>
 <CAN-5tyGYhmy_dgKV_7xuPFJjyY_wsjDcun_TrDK_vidmVG1ZXg@mail.gmail.com>
From:   dai.ngo@oracle.com
Message-ID: <8885dd72-41fa-89b7-bb82-096c03bfd0f9@oracle.com>
Date:   Tue, 18 May 2021 10:48:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <CAN-5tyGYhmy_dgKV_7xuPFJjyY_wsjDcun_TrDK_vidmVG1ZXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: BYAPR07CA0039.namprd07.prod.outlook.com
 (2603:10b6:a03:60::16) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-230-11.vpn.oracle.com (72.219.112.78) by BYAPR07CA0039.namprd07.prod.outlook.com (2603:10b6:a03:60::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend Transport; Tue, 18 May 2021 17:48:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba25b3e7-0dea-4bdf-cbd4-08d91a251a1a
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4656:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB46565AD5A65203148606D3D8872C9@SJ0PR10MB4656.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MAW1NHeWpZg28UaKy8A8E391IWtdo90Zl+b8lafXnsweZmWX5uOzjRkAQrFxAWk+3tduuwt7Rq2xErw6syLMCHAU/y8OVKxB2FFlgAgg/qD24yd0jXzDA0uedtxMmQp4hUH01HtqUk2uq6wxkwAdRtmD7poWZA3ww963n3rdyQAJWv9dq0oPnnssmTWpL8SU8S+JrUXG/TO2/EASq01RiZAK2Feyi+xX9k3h5+gQgFHgjdfnb8ON6gOenOK4CL3QInkq4BFTLw/2w3kq3q8f3u8dqe2D6iA0SV8NPbyqZ/MAd9mbOetjUEAyCsJqzOuEriA60ImhAw8zOTJSo6tkASDXsNmgowqOj8E38kdbzcOjsLl1BQKr7iCE3HP4w3CL4NHVhsAxa1nCTKyj/+Y4+XytRxpQw4oXHIR+vjuYdy1bCQEllOrGHu9UOfdvA94OGEtBBmg6H3PIGyuHsISZH8CtV5eunEQg/KA2p9E0BYXswPz8SXp810+5akCnhoCp1mqobBDnI+yexIgCLW3Kma2kuiETqav/6jcGZCM17u0Eq9XTYLFiU56hMPO6LXwjF5PFbfJCOpCyAPXLfM7fC1CaCoDE/Pqr7sXahRN+i0IbSkuUBiVyjr62TBcqsorwXgf5nj2CWq/CJBfaHIkVnjP9G73iRbdcgEHuGH2SeO0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(346002)(376002)(39860400002)(16526019)(956004)(186003)(2616005)(31696002)(4326008)(9686003)(8676002)(53546011)(26005)(86362001)(107886003)(36756003)(83380400001)(8936002)(6916009)(7696005)(66556008)(31686004)(66476007)(66946007)(2906002)(6486002)(316002)(5660300002)(478600001)(38100700002)(54906003)(30864003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TkptOXpmWUEwdFFLY1lWUXIwNlR5cm5Vd2R0cjA0TVRFWDNqNThtb3FxTlJv?=
 =?utf-8?B?Y1g5TURvZ0NydlNCK1IzbzE5aVAxUnZXdCsxU3hxdUhjcEVuOEJteWFrQSti?=
 =?utf-8?B?NFpkazdpSEgvMWYwcWY1dXlUUGdOam1QRjhDRWVqQVplV2pIUjVmWlF0UWZB?=
 =?utf-8?B?ZWk1eGRRNVBoU1VGbjNFYXp4U3VpTy9KalBYZ05YZnU4WmlBcjhPTTdleUZ5?=
 =?utf-8?B?Wm1KYkpoWkNEZGROQndMTFhnM0hibGNtQUU4ZnVqZ0F2YTFnU20vSEJiNTNU?=
 =?utf-8?B?b2RCQmZTWWRJbkZ0SDFpNHdqSVJhVU5ITU9NRldhbHFJbVpCYk5Uai91SkJt?=
 =?utf-8?B?ZjZ2K1QraFJVN2tKOXVPWnZpcG1CZk1QZXZVQjhDd1JDNE1DRkRwUDFCOTJh?=
 =?utf-8?B?MzhKdGdMK3JlK20rSkw0MXJCejBOL2M5aldlKzhNZHI3Uis2aWhISjJob0Mv?=
 =?utf-8?B?M1Z6SEk5MEFMWjMxOFh6VUkza0VjTXVVazIwVWpWSGpIS0VXN1g4aDlhelRF?=
 =?utf-8?B?R2FjZmkvajA1U29qOE9pcnMreG96dy80K1pSUVlSY1JKc2ZjUzlkcU1TZ0Zq?=
 =?utf-8?B?UU9jUEk1YVdHeTgyTU9pWEtIZER0MDE5WnVuQ1VvN2tGeGRuYXRNc1JlbTg0?=
 =?utf-8?B?cW1UbFNjc2NEanE3c1loKzMxT1Z3YWdRbmxsN0FhczBmc0wzSFg1aXNMQXM0?=
 =?utf-8?B?WGVJUWZhWkhzMFl6SitUdDVCRTRpWlJERll6RlJ5dVJHL1A4SGdNMnhlckFE?=
 =?utf-8?B?ZzAwc1U3UDZnK09qM3UvNWVCUVZjNm95RTVodUNTNzhTMnFEQmZlR3NYU21Z?=
 =?utf-8?B?clFldHlreXZ4Z0dnSlhIWXZZMEJMeVN0N0IxUHIvVUUxRWt4MGVSNHNQdEVh?=
 =?utf-8?B?aHJSTWhtcSsrTzFiVVpjQWwzNEVESExnQkkxQ0RBVk9pQ2hIVjBzcys1UWw2?=
 =?utf-8?B?cmp0WlY4Q1RLa01kaG0rMWcrcitZVWVoQjlBK09scGxvTnRMR2t4elNmbi9r?=
 =?utf-8?B?YkpXSkVSL25BQ0NRNzNqQ2d2SjhsOG1SbExjcWtDK3VNU0N0b3pNWE1yajB1?=
 =?utf-8?B?MVo4SGR4YStmaHJickZwU3ZLUjZuR1RlaTNSQmJWcVQ1dlY0cjR4SWZFN25n?=
 =?utf-8?B?Zkl5WUNISzVjOE5yaTZDV201eHd2Vi9ZWXpVTFRjcFBqaW9SU2NZK3Q2V1pH?=
 =?utf-8?B?eU5XbWRGMUtqdXRzRWFmVGNEVXRQVno2M0h5SUZNM2hWSTZPbzRaL3JVQWJu?=
 =?utf-8?B?cndsaEdnd05PY0ROZ2dOc3kvV2g3Z3VxY3l2SFp4bzhWSnM2dFlianlTdThm?=
 =?utf-8?B?Z3ZkZlZlZEIyc2hPOFBQc3dGNk1ZV0dOZGRWMG5RMHVmQStQVTQvcVFOSTdO?=
 =?utf-8?B?ZXF1elIxR2Z1QytiN0JvQ0pvSCtXaG5SRXhqSllMTlVGTndkVXdNbkNheG9y?=
 =?utf-8?B?MWllQlhWbS9uVmFBdHdMY0VsSjFWdi95ajVIMmovVXlXTzF1aFdsYmtFaU9I?=
 =?utf-8?B?dkdTSFViRVBPb1Rkclpic0JQcVJxTUVidy9zWDUrLytBYVlML3JTM2hGMDFx?=
 =?utf-8?B?YWpxNmFSOHh0WGFoNnh6dkh2dGVvZlpWUUdiNm80L2RsSnFzOTFhdlZTNnNh?=
 =?utf-8?B?cXFDTlUyL2U4SjVCUlROUVlVWEtuRFRGTm8zMWRxWFU2QUZlZTZ2VFNhSkhE?=
 =?utf-8?B?aGFpNmZGa2ppTkZ3c1dGbDZQbnZiTHlQL0tDZk1hZnNESWpuQkNXaHk1VVNW?=
 =?utf-8?Q?GeR2ucXRg+JN11SHMhHW880chM25MyWAV5vTQpL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba25b3e7-0dea-4bdf-cbd4-08d91a251a1a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 17:48:10.4478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siDIM1rOIvTGXhrVuy8Ur6YihVTR+qceOTCNIj1JNSISb/c+8ZCyU/Ltz2aDNfhxLM9cDTiooI8ZwPIa9u7xTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4656
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9988 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105180123
X-Proofpoint-GUID: kpcKpleRIMiqf_piDYB3NNnv37QJEVpg
X-Proofpoint-ORIG-GUID: kpcKpleRIMiqf_piDYB3NNnv37QJEVpg
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 5/18/21 10:16 AM, Olga Kornievskaia wrote:
> Hi Dai,
>
> General review comments inline
>
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
>>
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
> Why should this be in nfs4proc.c when it's used in nfs4state.c only?

I will move nfsd4_ssc_expire_umount to nfs4state.c

>
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
> mnt1, mnt2, mnt3  added all at the same time. mnt1, mnt3 only used
> once during the expiration time. mnt2 is being used continuously.

m2's nsu_expire is updated and re-inserted to the tail of the list
every time it's used.

> expiration time comes. delayed mnt1 is processed. mnt2 is next on the
> list and it's not expired so code quits. mnt3 will not be umounted
> until mnt2 expires. I think the break is wrong.

m1 and m3 will be processed first and unmounted if their nsu_expire
expires, m2 is last on the list.

-Dai

>
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
> General question to maybe Bruce: can nfsd_net go away while a compound
> is using it ? I hope not.  I can't quite think thru the scenario where
> we started the async copy task but then somehow nfsd_net is going away
> before async_copy is done and if there is anything we need to take
> care of. I think the net shutdown would not find anything to free so
> it would just return. And the copy's cleanup would not find a nfsd_net
> and so it would right away unmount. This is more of thinking out loud
> but I'd like somebody else to confirm I'm correct that we are OK here.
>
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
