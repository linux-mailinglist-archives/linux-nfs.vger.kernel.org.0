Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826513221B9
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Feb 2021 22:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhBVVrS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Feb 2021 16:47:18 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58400 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhBVVrN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Feb 2021 16:47:13 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MLTKNH061821;
        Mon, 22 Feb 2021 21:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=IpkIuC2jOgyJPU8ocIwVuH197wu4ZiWn0pGIQcZPSbY=;
 b=v6c7y1yt79WCcRjO/pnWJinSCQdWjZDz+ys4pgJi5dtLqhwVqot087GDJBPVHqIWgIDz
 fdIg1b4Nw7A2MQg3jRtjnmEUv5AQ/csE7QLgb4WC25ikaUtx1GvNppcnX3wVuBjonE0v
 tAVN1MQhc912gm5bLi6Q1Ql43vf7V80ezWhIfYddQznG0mMHxkM7RmZzpqzhA7XWcK7X
 pHYUb30Dni0RI1DxmqLzQZzHSOHHJ4zL+LeqmvJvMEj1oSnE85hFcFDjk6SelWZbk+/2
 6cXNApCzrTM0t89vj8ahOc2lC19q1ogy44Qk//jlwrrk50INdqltMFW9ZDuZAuRpazi4 yg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 36tsuqw9an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 21:46:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MLkJtl193915;
        Mon, 22 Feb 2021 21:46:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3030.oracle.com with ESMTP id 36v9m3sqes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 21:46:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjuMOaHgWY29VZcVR/b9pU9xBOP7YlzG4O2tJUb7kor1LK41Cj/IiWyOAl2PYg2LCAgyaLJF2d3yqsNb/ejlI9XnC0+3USV0un7zU7y/9mBoXBTFOIp2D4PFN5nVPaoYcDBsa2xsLWCJZnfne+9RJJHqRMwCGExkQ65gZx3zAkrg6RqL2/eZocSXXPs9/AsgVXGgAom4X9Y7caUpy/ypJEi7y4aOa1YxRXzwoveTsgTGfgVOrJUoLihp7xqwhnvl2hUsRsUc87hm05PtVfbQ2Jqj2JZoFcUezaJO9S+HQVZ2bNA7m/cYiwBl5BF1Xc1BKRz9IyZFopMNGddtKgzBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpkIuC2jOgyJPU8ocIwVuH197wu4ZiWn0pGIQcZPSbY=;
 b=UW3dYld0RAY9ue8epadEGvQlYc9XrCyTrvVTs2ygANvRhEV/Aai1WldDYKlfBwvbJsJK6rfUWaDFTmlB+2dEgncUJ7optAOJk1DSuZec2N5yqP2eiSyQftCMpBvXsdEpzEFUa1LKMsUGTy/pXv9fAvq/Tm0M8d8fEiip2HwtevTGMqX90UP/RWUfvY2lLhfIuIslFpIGVd5s0D0S2bMIqoiHe5SV/rpLbb2qky/Si6DDYHgNVcqr+WVEULCfuVusJbKkAyfR7OvWHkt41UexO5kb9oM0bRUZ2bHNWaBxyHlXkHGiLESn7HBsrvYJFypsy0XHQbQ2RePylM8CrI5GBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpkIuC2jOgyJPU8ocIwVuH197wu4ZiWn0pGIQcZPSbY=;
 b=zZDM/zixzhYG0CFgccSwFT20XFQ/k3BKuX1wWaHBBx+mGe6ZN9BhhzZ8scgCcbKvkwYFK+FM8bFUpcAhmL6jdfgHONpW0GvAwqDHGtvX8bZlfYgoNXP6qBLlAo973hfC0mo7e/mtLlSEBshJqwEF2HrWm3mdoFJ0Bz2MAbdBGiE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB2565.namprd10.prod.outlook.com (2603:10b6:a02:b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Mon, 22 Feb
 2021 21:46:08 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8%6]) with mapi id 15.20.3868.033; Mon, 22 Feb 2021
 21:46:08 +0000
Subject: Re: [PATCH 1/2] NFSD: Fix use-after-free warning when doing
 inter-server copy
From:   dai.ngo@oracle.com
To:     Olga Kornievskaia <aglo@umich.edu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
References: <20201029190716.70481-1-dai.ngo@oracle.com>
 <20201029190716.70481-2-dai.ngo@oracle.com>
 <CAN-5tyFnTSuMivnBPD9Aur+KDxX8fCOuSaF7qGKe6bFB7roK6Q@mail.gmail.com>
 <20210220010903.GE5357@fieldses.org>
 <69ea46ff-80d1-acfa-22a5-3d1b6230728f@oracle.com>
 <20210220032057.GA25183@fieldses.org>
 <CAN-5tyHq2NcQRbx01cSyJob=72MDUnwjK_t6GiDjTc3twbnvwA@mail.gmail.com>
 <ef11a2f9-f84b-7efc-ba5b-ca36c33d1825@oracle.com>
 <52e26138-0d3d-bd3c-6110-5a41e1fdf526@oracle.com>
Message-ID: <517d8f58-4a00-8fe1-ad5a-b19ed50a8fe3@oracle.com>
Date:   Mon, 22 Feb 2021 13:46:05 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <52e26138-0d3d-bd3c-6110-5a41e1fdf526@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SN7PR04CA0245.namprd04.prod.outlook.com
 (2603:10b6:806:f3::10) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-137-111.vpn.oracle.com (72.219.112.78) by SN7PR04CA0245.namprd04.prod.outlook.com (2603:10b6:806:f3::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33 via Frontend Transport; Mon, 22 Feb 2021 21:46:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 108be3a6-d2f5-4a8a-dc93-08d8d77b4333
X-MS-TrafficTypeDiagnostic: BYAPR10MB2565:
X-Microsoft-Antispam-PRVS: <BYAPR10MB25654B4657ABD1A87239641187819@BYAPR10MB2565.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ix1YaMkr29fKXRzw/aV93WJWiDVTsd+GUNZ1sXE4k7PR1FmeS1u/el26u01PTF23ZQBKCN4XU348ZCZp0pGVocX0CGhIR7//R//17j1r94DoNkTL8yAlLmlxvrknLvhYnNLCkH2vECz0cD+WXEc9WGq7vs/gFxKRBWMwQfolk7iwObK5jVht1oyqwHYr6kzObFJ/AppzqEYeew4/MLjerVClHdm1pky9Blz16dWlSVQuL7U3f0LNAoR9MMV0JQIPdf5gx1VDvbu4CHtus4Dwb+tYwY2ypVTjQuZSA7OJegMBIF8859ZXoLTcWWDp3BmQWJBfd+jqGzLxRBuvrNXUMgAO+hZDQw2TAkA4aqA8/UJ/b5oJ+Dno0OOeqTil7Ds51i9lGbLWXRawQQStxQaJxCz5TJ7z9L1pueRfWUSZCu/i4FY+zI9dC5KWs6oPZk9lGzZEA4RW+Vinlnb3kV0r8mm9JtBqlHJf8/hR7QUpk4eazQi5mYHa+j5m4JGDc+VSRj8kXvz+mFJvvHJQf1l7vQyKPdDMqZ8Hg6i6yI0pq32uoJ1/EdQ3VHGBRD6OtlX9y3ow2hCyOzfUpeh1BXbnMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(396003)(346002)(376002)(83380400001)(8676002)(6486002)(9686003)(53546011)(86362001)(8936002)(2906002)(956004)(5660300002)(478600001)(36756003)(186003)(110136005)(2616005)(31696002)(16526019)(4326008)(66476007)(66556008)(7696005)(26005)(66946007)(316002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VlB4NG9hRm8yS2dYUGdCNTAyNGlWTHJWejZ1Z002ZWIrOWM0Vkp0ODl6TmI3?=
 =?utf-8?B?ZXVmWExPczJpVDJqOEV2d3FrNGNzSkdGaWJjdThsZGg3NFdQWFJyaVVyblhq?=
 =?utf-8?B?cUQ0bE11clhCeURCSjNmZ1JJcnF4OS9BRFg5SVg2ak03KzMvUm4xY3RSeGJ6?=
 =?utf-8?B?MTB2STVqK0ZhVUY3YjlENDNxU2Rwc1BmT2FUcC9LR0ZTU2ZYbEVwaEtJNzhF?=
 =?utf-8?B?RytnWnFNcmtMVVg1eVl0YWgyc1ZTWFA2bnBtWHFXVGpWTEc5UXFBZFY1VWlF?=
 =?utf-8?B?UktERUVDd2UxZndrbUh5ZE5hVXhNak83a1pIUzJKaytvK3RzYm5pQzZTajhN?=
 =?utf-8?B?Sys5Y083ZXI4bjFBR2NwbGVQUVIxODI3bHQ4VDhFdWFETXNUMjVhcUt6NXhR?=
 =?utf-8?B?QVl5R2Z3NklmbklZL0lTUFRlU1NHdC9BOXo2ME9oY3h2WHRudTlGZzljZ0Zj?=
 =?utf-8?B?b1ljTk0yeUdJYTFONVNnNVlaUWpvSTU3WkVsdDBMdnU0SVUybWpubmpRY0pk?=
 =?utf-8?B?VGhjZlZ6MkxJUjJ6a1VSTFdwdjZQRjJrSU9xM3krU3p4enptb0tHd25tODJw?=
 =?utf-8?B?MmIvRFN6M09kNmFvbXM2WEtyMmd1V2dqUVhKQmRiN1pmZHpyZy9lT1VjMG5r?=
 =?utf-8?B?ejl1SEw5VkpJaHg0OVpwSUFRRFdNN1VoaUp2RkMvS3dKYVd1ZEVjVklLTHpF?=
 =?utf-8?B?K3VMMmsyZEticTVZT2xmc1crMlR0NjR4NUROT2RRbjhVR3V3Tm4xMy83ck1j?=
 =?utf-8?B?bFhjc1RJZ0djNDVTd2h2UDR3VWZDcERIeDRRb3R4TUJBd3krNUpxTzNxR0w1?=
 =?utf-8?B?N2tMa3RxWGZPNUJveUlqa2FTWURTbTZ6NHdSdFRrdkp2VGhTMWxuQXE0L1U2?=
 =?utf-8?B?QkswSkhUR1RBMWhNZ2JtRWppVHBMSXFqNzlPM1NTNHlna1VMVmQ1bjBwYnpq?=
 =?utf-8?B?RnVac3JsYTltQVJjRFNBRWpBZUt1MXJGYnBnSzFqZTdheWhQUUZjTmRUYnlR?=
 =?utf-8?B?ejJ3WGVwSFNEaWVnOWU0K0VGeFdlcGJ4R0VrQVIxUjh4YmFYY0psTTVtTjJ1?=
 =?utf-8?B?Rmdud1E5ZjI3eHJiSUpPUkplOHRCbHNFRzl3ZytZZkJHclRtVXh1YlNyTlIz?=
 =?utf-8?B?ZkkzdEVmN0kreGdndFRqam42bHJVdkpuT1NuSEhLaFgxYUdZdXRrNzF6ZTNk?=
 =?utf-8?B?ZzAzRktiOW81RE5JdmFWeW9ERXVjRnBZVFpLVmxJT0ptdGlBVjV3OGxXeWlV?=
 =?utf-8?B?STF4dEhjWm1UM1I1QWNPSjcrT1JVQXNMQzNVMmwwenB3NHZZeTA5aGhuS2p4?=
 =?utf-8?B?U2R5Mmk5eWUybjFJMTFjMTd5bDFNdnBiVGJBTERIQmdVVzkzNCtxUjZVQWJL?=
 =?utf-8?B?QnhGUmdrYk9PdUQzTm55bjlIVUFYT2NyMzhWZ1k5VllqUlo3bkQ1UlVrR3lB?=
 =?utf-8?B?VGdjZlF1Um5qNldOQzYxZEYxc3A4VWhxMkdQYU5KK1FNdDFPc3BNMGNIYnE2?=
 =?utf-8?B?blp4MWxzNHJ3N3EvQ0pwUjcySnJXWkd6V1BaRjVtYkJSZloxUzRhckdSMjhn?=
 =?utf-8?B?VDBsOU9OZkh0Y3pidHFnMzN5WkZqcGVlTklUSnUyVEltMGJ0a0FUSHhpZmpP?=
 =?utf-8?B?NWtoQXNBcnJTWkhkU3Yvb1VYWVJJWlp2YVQrdDM4eEJNdS8yK0xnWGdnNk5p?=
 =?utf-8?B?MlVUYTJHWXdobFVTNDUyZHV0WXU3am9IbnhISyt0ajl4Mys3R3VURFd1Wlpt?=
 =?utf-8?Q?4ZNSkO+Rc6wJp2Tz3orydp+P47GyF4neK9vR0jr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108be3a6-d2f5-4a8a-dc93-08d8d77b4333
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 21:46:08.2969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYAidq+HLfKOmSpvOS9ZjfDYLFY80H4NQm8lYLyev4PzRfsINU5A6lBoV4Qe4ImZ+F7dwJGQpqOsIigTsNyqYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2565
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220188
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102220187
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 2/22/21 10:34 AM, dai.ngo@oracle.com wrote:
>
> On 2/20/21 8:16 PM, dai.ngo@oracle.com wrote:
>> On 2/20/21 6:08 AM, Olga Kornievskaia wrote:
>>> On Fri, Feb 19, 2021 at 10:21 PM J. Bruce Fields 
>>> <bfields@fieldses.org> wrote:
>>>> On Fri, Feb 19, 2021 at 05:31:58PM -0800, dai.ngo@oracle.com wrote:
>>>>> If this is the cause why we don't drop the mount after the copy
>>>>> then I can restore the patch and look into this problem. 
>>>>> Unfortunately,
>>>>> all my test machines are down for maintenance until Sunday/Monday.
>>>> I think we can take some time to figure out what's actually going on
>>>> here before reverting anything.
>>> Yes I agree. We need to fix the use-after-free and also make sure that
>>> reference will go away. 
>
> I reverted the patch, verified the warning message is back:
>
> Feb 22 10:07:45 nfsvmf24 kernel: ------------[ cut here ]------------
> Feb 22 10:07:45 nfsvmf24 kernel: refcount_t: underflow; use-after-free.
>
> then did a inter-server copy and waited for more than 20 mins and
> the destination server still maintains the session with the source
> server.  It must be some other references that prevent the mount
> to go away.

This change fixed the unmount after inter-server copy problem:

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8d6d2678abad..87687cd18938 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1304,7 +1304,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
                         struct nfsd_file *dst)
  {
         nfs42_ssc_close(src->nf_file);
-       /* 'src' is freed by nfsd4_do_async_copy */
+       nfsd_file_put(src);
         nfsd_file_put(dst);
         mntput(ss_mnt);
  }
@@ -1472,14 +1472,12 @@ static int nfsd4_do_async_copy(void *data)
                 copy->nf_src = kzalloc(sizeof(struct nfsd_file), GFP_KERNEL);
                 if (!copy->nf_src) {
                         copy->nfserr = nfserr_serverfault;
-                       nfsd4_interssc_disconnect(copy->ss_mnt);
                         goto do_callback;
                 }
                 copy->nf_src->nf_file = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
                                               &copy->stateid);
                 if (IS_ERR(copy->nf_src->nf_file)) {
                         copy->nfserr = nfserr_offload_denied;
-                       nfsd4_interssc_disconnect(copy->ss_mnt);
                         goto do_callback;
                 }
         }
@@ -1498,6 +1496,7 @@ static int nfsd4_do_async_copy(void *data)
                         &nfsd4_cb_offload_ops, NFSPROC4_CLNT_CB_OFFLOAD);
         nfsd4_run_cb(&cb_copy->cp_cb);
  out:
+       nfsd4_interssc_disconnect(copy->ss_mnt);
         if (!copy->cp_intra)
                 kfree(copy->nf_src);
         cleanup_async_copy(copy);

But there is something new. I tried inter-server copy twice.
First time I can verify from tshark capture that a session was
created and destroy, along with all the NFS ops. On 2nd try,
I can see any NFS ops from the tshark capture because all data
are encrypted by TLS/SSLv2. This behavior seems to repeat.
I will look into it but I think this is a separate issue.

-Dai

>
> -Dai
>
>>> I'm assuming to reproduce the use-after-free I
>>> need to run with kazan, is that what you did Dai?
>>
>> I did not use Kasan. I just did an inter-server copy and this message
>> showed up in /var/log/messages.
>>
>> -Dai
>>
>>>
>>>> --b.
>>>>
>>>>> -Dai
>>>>>
>>>>> On 2/19/21 5:09 PM, J. Bruce Fields wrote:
>>>>>> Dai, do you have a copy of the original use-after-free warning?
>>>>>>
>>>>>> --b.
>>>>>>
>>>>>> On Fri, Feb 19, 2021 at 07:18:53PM -0500, Olga Kornievskaia wrote:
>>>>>>> Hi Dai (Bruce),
>>>>>>>
>>>>>>> This patch is what broke the mount that's now left behind 
>>>>>>> between the
>>>>>>> source server and the destination server. We are no longer dropping
>>>>>>> the necessary reference on the mount to go away. I haven't been 
>>>>>>> paying
>>>>>>> as much attention as I should have been to the changes. The 
>>>>>>> original
>>>>>>> code called fput(src) so a simple refcount of the file. Then things
>>>>>>> got complicated and moved to nfsd_file_put(). So I don't understand
>>>>>>> complexity. But we need to do some kind of put to decrement the 
>>>>>>> needed
>>>>>>> reference on the superblock. Bruce any ideas? Can we go back to
>>>>>>> fput()?
>>>>>>>
>>>>>>> On Thu, Oct 29, 2020 at 3:08 PM Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>>>> The source file nfsd_file is not constructed the same as other
>>>>>>>> nfsd_file's via nfsd_file_alloc. nfsd_file_put should not be
>>>>>>>> called to free the object; nfsd_file_put is not the inverse of
>>>>>>>> kzalloc, instead kfree is called by nfsd4_do_async_copy when done.
>>>>>>>>
>>>>>>>> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
>>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>>> ---
>>>>>>>>   fs/nfsd/nfs4proc.c | 2 +-
>>>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>>>> index ad2fa1a8e7ad..9c43cad7e408 100644
>>>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>>>> @@ -1299,7 +1299,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount 
>>>>>>>> *ss_mnt, struct nfsd_file *src,
>>>>>>>>                          struct nfsd_file *dst)
>>>>>>>>   {
>>>>>>>>          nfs42_ssc_close(src->nf_file);
>>>>>>>> -       nfsd_file_put(src);
>>>>>>>> +       /* 'src' is freed by nfsd4_do_async_copy */
>>>>>>>>          nfsd_file_put(dst);
>>>>>>>>          mntput(ss_mnt);
>>>>>>>>   }
>>>>>>>> -- 
>>>>>>>> 2.20.1.1226.g1595ea5.dirty
>>>>>>>>
