Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1446F3E3CE3
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Aug 2021 23:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhHHVT1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Aug 2021 17:19:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26856 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229977AbhHHVT1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Aug 2021 17:19:27 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 178LGOEH001582;
        Sun, 8 Aug 2021 21:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8jJDqAb2FLtM3RNSNajALXDW8vUEC+2wxlxdwX+ofpQ=;
 b=Erj+t3nJDTi8yw1Klf3lfUNGvwFPgCzA2Djd70jqftgFpwBUgfZYjrIe/awlFVy65vVG
 kKUn6airMxBB/McDUPmU0Zh7arRtY203/+eOzMjE4HzvubZ63IjD8aKrH4LgYlM6ssrv
 rIBmo/hfProPbGWexb4w2Yn818Tvhi5c1ke0dVgLHUOEX0He6LJ8UaLCS7cCifHrjMQF
 g2mOSoYqQ+B9yVQhvoUnL/DtZZLJ9hquz1jlOx755NXycp+eYgigIWo/rOLxZ8j9/DoD
 muxD+mF/34MRFhd3lSXHQtqmsmNUYbP/hWmAXFAlmuySIgsHAr9AyUl02hkhSgfh4xgb TA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=8jJDqAb2FLtM3RNSNajALXDW8vUEC+2wxlxdwX+ofpQ=;
 b=I8ik5LdssUeO4UHBFPhRMBclK50DV8r+HzP+547fBmOB2NR5Yc05FdSlR/xLyvdKj8Ng
 +7HUg5r6gVgiGsDuCUoHEYVYLroYD15diB0jtqsUFIUZo7XOQERazHmLknWDIFy2/LYV
 ZyQS1tDJPpSnqyVFmqNVi7AMQT5ZskxgP3vLyF+2tNIpjz8fVgaxfR4Etvhvt4ENBGkk
 QUtDhJYXkLt+yQihl/22wJmCr1szrxKFKKUWJLIR/hw/it6NEieQh8BHGdicZw5lV+gz
 crH4gfoBHpjXdmsqo+YwiNk3l8D4PgSAHwx/Aifs0bCfxk2n3jcfXTA53mOf5WHUASzZ HA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a9gs0hwag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Aug 2021 21:18:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 178LG0kM094955;
        Sun, 8 Aug 2021 21:18:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3030.oracle.com with ESMTP id 3a9f9u1c6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Aug 2021 21:18:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z61c0jJFhZhkvScytvtuDkHWzCljUcuivtiJZEYMcinuY3jdvrvUF3pYr69woUajsggDIePh+jDL28FkXGAI4uR0fbzop0nOip+d/lAEVXHQzjxN7L6GK/lge5tkxjorpbUYtEjXcEa2EmHZSbMHoSn8MeSCuV8XqGLTZOKzDuJWN0MjdJyZZkjXaOywWFxIFpYbr0oEriCSTLA/v4GlwZd5qQXQtLz4wTQs5Ess6NgnYQov9/fc2y/DN0cQOu9GBNZ6UkiRVme0wABXedoIHub68f2IcYSe7zv+9DyM67cz5BGTFSfUSiJtihXpH8X6gdP2v1U3O7xIbCBbkZaVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jJDqAb2FLtM3RNSNajALXDW8vUEC+2wxlxdwX+ofpQ=;
 b=BktsbkrYHHHppFeRgtru3u35hqMiOJBfhjBYJE6pKEH9OrRSIqffgXWZPopWcfwGvyL97R+pbCgEAtrP+6MXhplphc7nkpZpaTZfUHeo7tqWB395DiYl0CrboHMIyW/dsyPB+BVnmv/bg9t7wSbHzAqVmGIPnGi9BqgVny/lKJPbU0cyyoeCtvqW9HnRcr6b0u+Rnx2/d85yNHcWPSxqCi6tpFY9Phk+V3/i4VeyGwGsg8ztf0LB4n/HdHe2DWC2KJYULK4XwFMGX9EIRqtK4y50r/LN7ROIs4Oqw9XvH3QQAqhtvtLhbnGKTbDvVj11D2v2ZB36esPBsWbudzcmbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jJDqAb2FLtM3RNSNajALXDW8vUEC+2wxlxdwX+ofpQ=;
 b=DGCm9nS+uJHrFBSPXXYopZHcKzpRocxkBv9f/l78oGn/vz/L/7f2CiIAlZ3SNafMLeraqL4F3vUvMxv1yJ2i2kykZguQB3pE8soNHwLljZck26vwjU/o1Ast1b0RqBj/6yCTqcsZR/c8Ojr5+C8dGVhB+tSp5eVv6SBKh+Ckyuc=
Authentication-Results: thkukuk.de; dkim=none (message not signed)
 header.d=none;thkukuk.de; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3047.namprd10.prod.outlook.com (2603:10b6:a03:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Sun, 8 Aug
 2021 21:18:36 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::e4ce:bb43:6e72:1e10]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::e4ce:bb43:6e72:1e10%7]) with mapi id 15.20.4394.022; Sun, 8 Aug 2021
 21:18:36 +0000
Subject: Re: [PATCH 1/1] rpcbind: Fix DoS vulnerability in rpcbind.
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        libtirpc List <libtirpc-devel@lists.sourceforge.net>,
        kukuk@thkukuk.de
References: <20210807170206.68768-1-dai.ngo@oracle.com>
 <72C62482-3E44-4D76-BFB0-18402D19FE2E@oracle.com>
From:   dai.ngo@oracle.com
Message-ID: <88b2db88-bb76-0466-4ae4-a27240c7f8cd@oracle.com>
Date:   Sun, 8 Aug 2021 14:18:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <72C62482-3E44-4D76-BFB0-18402D19FE2E@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PH0PR07CA0075.namprd07.prod.outlook.com
 (2603:10b6:510:f::20) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MacBook-Pro.local (72.219.112.78) by PH0PR07CA0075.namprd07.prod.outlook.com (2603:10b6:510:f::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Sun, 8 Aug 2021 21:18:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 198b75d5-1e25-4783-76c1-08d95ab2157e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3047:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3047B160D8E3030C3312071D87F59@BYAPR10MB3047.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUuUcBXNesCPII3KWiQ0UY1Eq00ajKQj0bgYljbZKiOOtCsQ+idf8261qB7Fo/DfPLmItzAt2j+dmnyuWZZwssIWHlwyf5phgcaExfxDVpD5Pm7lPtqNq2AsYmCJGxaMteqk4KCezlrv6CawuCqkKMrKM5ylfjhMTzqAHWaRuxduCOGGPABf0XjvOWb3IzHovQ4WLDpvu3M2xUJJxjncHtoEHJeRdu5z0SgIn4/+YYUGovZAie6MqCsdvp83/ZNPYwXnIrHxJKg6ffHPaxrrgXQSwkdYPUvNFkxcHO2NcbnUZJ7ga/UMnLs9VzhCmJwKm5l8APu4su3KPC5di81eemo8+7NNzC+aLWvV/sVi5q/aNFnQaZhSvEHhJ/IXL3eMS8tbIcfaFhApXsaDQD3QU0ExneNq2Po3v4smhJQ63W1+rK4s/yD1v4CSSrFu2++6jgfGt4QT+wA+4bqrJR/jE+fdnSLwmn/shCyqvrJcTnfICKyG8eRUI2Tf/UL2v5qhF8tKOnZ476yJGYcr6Lg6U2KnMNNRRuZYes/H5cA142o4c1f7e+BwXcdefQjI4aP/TWl7IXBVy5azyDU1KnAQ+a+edcD/lp9OKC3IhFU/rbG0T7wWraqnwBhIWBKbIX1XcBlkgcsI057GJMIm8+aixL5U4B9Icp6rlMOV7nOtO+RW6s57NO6uWx6p/0p0MCJZIeSF1RAtN9XtOvtog/kkdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(136003)(376002)(366004)(6512007)(54906003)(9686003)(31696002)(8936002)(8676002)(37006003)(38100700002)(31686004)(478600001)(186003)(86362001)(26005)(316002)(4326008)(66946007)(83380400001)(53546011)(66556008)(66476007)(6506007)(6486002)(36756003)(2906002)(5660300002)(6862004)(2616005)(956004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1pldWo3c2JwZVV2RFZLcFF4S1V4MzBMY0hMNVdqdkVyUGRndlVqYUZNaGRZ?=
 =?utf-8?B?OGc0eUdjSVQyZ3Rjd3pzY2VtOW9jdzl5b2dIdllhU0NhOEEwakpza1piTG5q?=
 =?utf-8?B?TkFYYzhVSVBUbXBSMzdWY08rbis3WndVcmVCSUJ5V05WZW1FLzRTa3g5cFNW?=
 =?utf-8?B?V3dRUEhtd0s0eTJKek9wamNQdjJiSzBVajJCMmVISjJiclJzc0NybnhVOWx3?=
 =?utf-8?B?VkFvU3BjT0pJY0hnM0hNdEd5M0srMnU1VEIzbzN0UDI5cFlQRyt1aEZKaXZC?=
 =?utf-8?B?d0ZRUzE4SWN0dm9sTTQxV0FJNzd0dmpKMGFZeXZjd3Y2a051M2hBcytHRkpK?=
 =?utf-8?B?N0Flckd3TU51WmFYbElIeGZ0VFQ5K0Fnell2aGcvNzN5VHNVUkU5Sk5YR2ZN?=
 =?utf-8?B?SkFlanhiM1FKNkZxVUpoUm5VbW1zQU95eC9ObzhKUHlkV29ibWJ5UVJwa0ZQ?=
 =?utf-8?B?Z0xrbFNFSUl1cExreVdIZ0lLcFVSeEEvdTRyUjNQM1ExNHYxaVh1cmx0KzVu?=
 =?utf-8?B?QkNzejh3Ty9xbTd2QkxaT2tueXo4dDVnNFZRdFVOdnppQjJhNDlCNWhmb3g1?=
 =?utf-8?B?UEZhVzBTSUhTajUxUEZYRCsrUDR4TElOb0xhNzFYK0ZwWEhFYWJ3UnZ6Mko1?=
 =?utf-8?B?b0d3azVVRUlKb2ZUclI1alBHZXVnV2kyT1FvR3JhUDNVTEt2M3M3NEl5SEJl?=
 =?utf-8?B?emYrL2tQQUYyb3l1d29STEJVY0hMNXlZTlpSUi9CN1dYbU84b281K1cwZWZm?=
 =?utf-8?B?Y01zVGFZYjhhcWc2RG4zSEVuazFoc0R0QTlDRXlqQlRJV1dUQWtvN2h6cllB?=
 =?utf-8?B?cnhweXc4eTJsbE5ZelY0aGdjeGpLamU3eXpGeFk3RExJQjRNTkxEaUZZLzRJ?=
 =?utf-8?B?dkMzbTBVeGgyTVIyd1g0N042dWhoUkNSVUp3dHRENnc2VHdHOGRNWXZyNjBN?=
 =?utf-8?B?NG1jdC9tbmIyVzRyaStLcjk0TC9PVEFWMlpjcEY0Z1lGMExJSGg4OTNNZ0xV?=
 =?utf-8?B?ZlpmWTNDNkNxREttby9OblRPN3ZXeElHUGdPZkhxN1pJcHplWDdQZWhyQU5U?=
 =?utf-8?B?Tm1UUjdjcFRRYVYzWkZqQU96WTZuY2NjUDFER3I3bVZOMFpRbDh3eHRCQ3BI?=
 =?utf-8?B?bkFzTTZxSERsNG5zYUd3QzBhZVhFVWNLUnQ4aGsrd1N6eHRyOGhPUEdiT2h1?=
 =?utf-8?B?ZnJyMzhIRzE2RGhXUjMzSVJjU3BpMW9EQmpPbytQZy9vcWxIZjEzZWM5ZTIw?=
 =?utf-8?B?SG1WT3B0aDZER2FOK1dGU1FzcmhnQW1GMlVoL242Z1A4UFZrZFVhL0J2STlo?=
 =?utf-8?B?bEFkOGF2c3pYeEhMU1I0OUJvcjVHcVlDaXk5S1N1VXEzYnhabHFSQXJnbEQ3?=
 =?utf-8?B?Y3QxbTZMQVlITmtrUWppWW01aXhoelM5V2tCV1dtS0RnZCtwNVRyc2FyU2Jq?=
 =?utf-8?B?WEUvT2d5d0diVGdnSUN3UUlreFZlc2RtY0pYVHdnNmhMWlhvRHFBdUcwa3Jp?=
 =?utf-8?B?TXNPcjI5ZjA3em5UWkRDRzZNQnZaY1Z5RU0rbnBjc01EZUw2OGVaK3VQN0pv?=
 =?utf-8?B?WStaODhXL1YrWTliLzRqbm9tcEFwWDd2UExza2JVZWRoOEgrZk95VTROUDRw?=
 =?utf-8?B?dWVhTUdFbmdqR3VTL0NFRjB4R0tmZ0k2dUo0YjBKTkkwZW5ibFdtazVHUWZU?=
 =?utf-8?B?MGJGeTR3WlJuWXppWTZGUGVtRkpsdG0xRkJUd3EzVFhmQmd6Zy8zVjlJRGk4?=
 =?utf-8?Q?UkMMQKNBpJOJ+hnaDXvZ+FAirJ/SGRgcjuZ7mk9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198b75d5-1e25-4783-76c1-08d95ab2157e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2021 21:18:36.1969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxhAfgHTJwQcjEYxDpiWaS3ZhCCc8/L++0ndNJwmTU3Z7S+Oj9SSdYUSq0XE7zNOnBJdZ9QpPRRba9MMzVa4PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3047
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10070 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108080134
X-Proofpoint-GUID: Il-71mCetKO19aabbW18r4C73qRQdLjm
X-Proofpoint-ORIG-GUID: Il-71mCetKO19aabbW18r4C73qRQdLjm
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

On 8/8/21 12:36 PM, Chuck Lever III wrote:
> Hi Dai-
>
> Thanks for posting. I agree this is a real bug,
> but I'm going to quibble a little with the
> details of your proposed solution.
>
>
>> On Aug 7, 2021, at 1:02 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Currently my_svc_run does not handle poll time allowing idle TCP
> s/poll time/poll timeout/

thanks, will fix.

>
>> connections to remain ESTABLISHED indefinitely. When the number
>> of connections reaches the limit the open file descriptors
>> (ulimit -n) then accept(2) fails with EMFILE. Since libtirpc does
>> not handle EMFILE returned from accept(2)
> Just curious, should libtirpc be handling EMFILE?

Yes, if we don't handle EMFILE returned from accept in libtirpc
then svc_run gets in a tight loop trying to accept the same connection:

poll([{fd=3, events=POLLIN|POLLPRI|POLLRDNORM|POLLRDBAND}, {fd=5, events=POLLIN|POLLPRI|POLLRDNORM|POLLRDBAND},
       ...
      {fd=36, events=POLLIN|POLLPRI|POLLRDNORM|POLLRDBAND}, ...], 1019, 30000) = 1 ([{fd=4, revents=POLLIN|POLLRDNORM}])

accept(4, 0x7ffd4ac368f0, [128])        = -1 EMFILE (Too many open files)

This is what causes the RPC service to be down.

>
>
>> this get my_svc_run into
>> a tight loop calling accept(2) resulting in the RPC service being
>> down, it's no longer able to service any requests.
>>
>> Fix by add call to __svc_destroy_idle to my_svc_run to remove
>> inactive connections when poll(2) returns timeout.
>>
>> Fixes: b2c9430f46c4 Use poll() instead of select() in svc_run()
> I don't have this commit in my rpcbind repo.
>
> I do have 44bf15b86861 ("rpcbind: don't use obsolete
> svc_fdset interface of libtirpc"). IMO that's the one
> you should list here.

Sorry, my mistake, that is the commit for libtirpc.
The commit for rpcbind is as you listed:

44bf15b8     rpcbind: don't use obsolete svc_fdset interface of libtirpc

>
> Also, please Cc: Thorsten Kukuk <kukuk@thkukuk.de> on
> future versions of this patch series in case he has
> any comments.

will do.

>
>
>> Signed-off-by: dai.ngo@oracle.com
>> ---
>> src/rpcb_svc_com.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/src/rpcb_svc_com.c b/src/rpcb_svc_com.c
>> index 1743dadf5db7..cb33519010d3 100644
>> --- a/src/rpcb_svc_com.c
>> +++ b/src/rpcb_svc_com.c
>> @@ -1048,6 +1048,8 @@ netbuffree(struct netbuf *ap)
>> }
>>
>>
>> +extern void __svc_destroy_idle(int, bool_t);
> Your libtirpc patch does not add __svc_destroy_idle()
> as part of the official libtirpc API. We really must
> avoid adding "secret" library entry points (not to
> mention, as SteveD pointed out, a SONAME change
> would be required).
>
> rpcbind used to call __svc_clean_idle(), which is
> undocumented (as far as I can tell).

I try to use the same mechanism as __svc_clean_idle, assuming
it was an acceptable approach.

> 44bf15b86861
> removed that call.

which is one of the bugs that causes this problem.

>
> I think a better approach would be to duplicate your
> proposed __svc_destroy_idle() code in rpcbind, since
> rpcbind is not actually using the library's RPC
> dispatcher.

then we have to do the same for nfs-utils. That means the
same code exits in 3 places: libtirpc, rpcbind and nfs-utils.
And any new consumer that uses it own my_svc_run will
need its own __svc_destroy_idle. It does not sound very
efficient.

>
> That would get rid of the technical debt of calling
> an undocumented library API.
>
> The helper would need to call svc_vc_destroy()
> rather than __xprt_unregister_unlocked() and
> __svc_vc_dodestroy(). Also not clear to me that
> rpcbind's my_svc_run() needs the protection of
> holding svc_fd_lock, if rpcbind itself is not
> multi-threaded?

The lock is held by __svc_destroy_idle, or __svc_clean_idle
before it was removed, in libtirpc. I think libtirpc is
multi-threaded.

>
>
> The alternative would be to construct a fully
> documented public API with man pages and header
> declarations. I'm not terribly comfortable with
> diverging from the historical Sun TI-RPC programming
> interface, however.

What I'm trying to do is to follow what __svc_clean_idle
used to do before it was removed. I can't totally re-use
__svc_clean_idle because it was written to work with
svc_fdset and select.  The current svc_run uses poll so
the handling of idle connections is a little difference.

-Dai

>
>
>> +
>> void
>> my_svc_run()
>> {
>> @@ -1076,6 +1078,7 @@ my_svc_run()
>> 			 * other outside event) and not caused by poll().
>> 			 */
>> 		case 0:
>> +			__svc_destroy_idle(30, FALSE);
>> 			continue;
>> 		default:
>> 			/*
>> -- 
>> 2.26.2
>>
> --
> Chuck Lever
>
>
>
