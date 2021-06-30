Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDB63B8B03
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Jul 2021 01:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbhF3Xvd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 19:51:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61584 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236647AbhF3Xvc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Jun 2021 19:51:32 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UNgrHn026107;
        Wed, 30 Jun 2021 23:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xRWcxWXVYYK8NjzdM1pv9Ir0SO+/eVdgTtEIzRnO6ik=;
 b=nNX6fNA0CkRM0tF3r1sVrV7l8ECmWH46jsZDuGOPCc1zO+cfrXq8bgsUFfFGU48D21/e
 XDVzBlleWpHeB3MOsr+oTwXL942CctugAtQUXd+5A0WAmL2lUWDtb1W6qSMQms55NSgi
 /5nr6qbypUrWjjBDgfDh9fvr14VdmJCdIE2twDy5QguG+/wO3+cYjEheOhckuoqapDnu
 AZJTKolLhC93CZPdUF6hy/8jmcyikzAgbCx39P6T58bIQNE90cL45XPknthFB8FXf4JQ
 tdfj/jSxNIXltWxkfYu0wyYtV0Xud3h5+dtl//B8jbJvjqDIHnbPvDZn3Xs61ukmtHFI Qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gguq24sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 23:49:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15UNjvQq123612;
        Wed, 30 Jun 2021 23:49:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by aserp3020.oracle.com with ESMTP id 39dv292w6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 23:49:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDuqt+0iCdEjFxT6kLQbkS+sPMlhMwfSIGxF0ufpEA7S5tmtJhuhuNBalVpypnrTahdvY2ThcZTo0naxzMZ0bl/PSYYtYvAa0M0k5fyu3wipljxxD166pl5vgQ+P5LQHATH0PgNbMrCZaCyIl8LKhLGLJbnsvG93ayYFJ/hDFKY/JNZfh+KvmBPX9/cVu6CnejvquWOw+tMDtg2SmNGwlxKRvNmvkIbomPPd8nv8j3cgqphHq00/KraKGkSVT2sAGiGgMpsYYTvF4pU3mC645O/U6dVFU5EF/nv9efvFqjaWyPo5IbZvN0A8Skb3ZbZrHXFoqoajWe2e1kJ3KM42lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRWcxWXVYYK8NjzdM1pv9Ir0SO+/eVdgTtEIzRnO6ik=;
 b=DRf0hxTuWewgWT8nps+YLIMzfdPT+f8iyyWBhEViTGV4yxu9yBxSw16KooapUxM8DMwh8qjvrxJGPQi59hab652dllNnr2pmwFVXHKwmR2JWLqadwrc2KvkPfOQLjYTueVU4CwZfnK2Fnk5REcju1gW/sq0a1VHF+C9rItEC4Xwa3Hj6q27bxPXf62UYv7ODnjl31zwP3WHxShv9OK7ftwtQhrQY648yET5LSyPX/VELJQ8zj9dKbBsfEERGWK4W1Ky5EAsnYnoVL6FhhYxFe16HCDIHa0rrTOkOLlUqglPEhNN1ppsWlzSgIftP4ngdt/s0KZ87txBqqR84NdZiWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRWcxWXVYYK8NjzdM1pv9Ir0SO+/eVdgTtEIzRnO6ik=;
 b=CNdmwoO1FvDS/Fn8mgOqB4lXFqpympatFoS7uOQI5EhH9qy0boiHKz794FTUgJEBu9/qssBxQuHjTy+8iGYxLPvAvJNsinXc+WblNEEe4JkqmEFOokbpEJI+/x5SJ4C9Bks6bUBJ1VqBK8nTAyQrveU++w+ZeCDRhkoXtG4quCY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by BLAPR10MB5249.namprd10.prod.outlook.com (2603:10b6:208:327::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 23:48:59 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::a8b2:35e6:5837:13e5]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::a8b2:35e6:5837:13e5%6]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 23:48:59 +0000
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
References: <20210603181438.109851-1-dai.ngo@oracle.com>
 <20210628202331.GC6776@fieldses.org>
 <dc71d572-d108-bcfc-e264-d96ef0de1b36@oracle.com>
 <9628be9d-2bfd-d036-2308-847cb4f1a14d@oracle.com>
 <20210630180527.GE20229@fieldses.org>
 <08caefcd-5271-8d44-326d-395399ff465c@oracle.com>
 <20210630185519.GG20229@fieldses.org>
 <08884534-931b-d828-0340-33c396674dd5@oracle.com>
 <20210630192429.GH20229@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <a111226a-c6ac-0a39-190a-c2cc8b781213@oracle.com>
Date:   Wed, 30 Jun 2021 16:48:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <20210630192429.GH20229@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SA9PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:806:20::22) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-232-63.vpn.oracle.com (72.219.112.78) by SA9PR03CA0017.namprd03.prod.outlook.com (2603:10b6:806:20::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend Transport; Wed, 30 Jun 2021 23:48:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7199d1b6-f83e-4239-fe9d-08d93c21a157
X-MS-TrafficTypeDiagnostic: BLAPR10MB5249:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BLAPR10MB5249636A4441EE944E46BF4C87019@BLAPR10MB5249.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PFKSd3hlPMUoVsOzfXUZq/TxhPSshpOdYDL01LuTiEX3A8ynD8m5tOJ/uihipHYOuPZyM3bGF1yKkIqKtOOm4Tt+QAGQl/iWAXl546Tl1ILMNRRCpIGnW0leodjPNlq9EEpf8mUzA1W/jY6nvDyDHVtHKTC0fY7Rhg+vQfH+1+TS0kvRJ1pu2F6HHwErAqnYcpxkNUqAzJOsyUzgZpnUam/awPE+Bwx4x9BhYPVPmJ+aPQBPB2iSu66Pa6llYam7LRHeAvqy7LRbdY5q+7U8VgrIG9rcpR63EfS87D8jDLwqzv2UmnhzKTWL6gj8SLKdibybXwnnXDHvWbAMq523zHfToPpwGgg6/DesE51n+VMSLZ8qhnFso6HE2HjluwQl87VYWjgHwLvH37IHY/erIsf7m4dq5qN3381WxgeTlF9j05KHw4tA7pvWhlwYX5eQIlgMGu4K4meJABX5FtRSN8fAMzOe1DkMHeJb6eF940gb4dmRYpvJTMnzIPjXoOAUb11NLWXKpuE3x8KwSymrYpizBhoNb2rqQ3EIs19cm8M4plooqYvzciTiHUGqkIeye0Zxt04TvMrwKAgeUGOvkTeEdJFtwrVF07xjs3N1ewBZz3WBovUC40oBvrMrfHERLncN1+qdFsg921WuQiTACBevv0AFXs0S7CMWZh2KXto8hK51FK3QvSZ011srsWK9VY4kWjIIt+/xA/QiKwpN+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(376002)(396003)(346002)(31696002)(9686003)(36756003)(6486002)(2906002)(86362001)(38100700002)(53546011)(66946007)(2616005)(26005)(66476007)(66556008)(956004)(4326008)(8936002)(16526019)(83380400001)(7696005)(478600001)(316002)(5660300002)(186003)(6916009)(8676002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGd1Q3dZazE4S3NVTkY0L2xmWUlkZGV3QkhjcERPWDFMYVhyekxqeDlBVytj?=
 =?utf-8?B?djNYV0VuQUxva1o1dWlsaXNHUDlTcEpONjZ6YmFBVi9Da1NEUktOaGR3Q1Jm?=
 =?utf-8?B?TTZDYlNxVWoveXZUbHQ0VGNPY0NYRHIrbzRKNTRBcnRiM0lNSnVmM0piM0hI?=
 =?utf-8?B?QnRWSG5NQXlKNW5DVURybTA4Wlo2L0laWXluQlppcjVjSXJxcVdzMlJhUTQv?=
 =?utf-8?B?L3NiUWg3N2E0UlJ5ancwLzhoaHRwOTkzbmtaWUpQWEVlcUt4cTRudnZFb3ds?=
 =?utf-8?B?a0V6OGd4UUJBa2M1R1NIZXp4NFh2bmkyd0dxUEoxRXhoZmowYlk0YUVEL1lX?=
 =?utf-8?B?cVRpMVFudzVvM3J2TUNlMk11T1FSUytEY2E5NFRqSFpjZDZvYUZqUXlnMWN1?=
 =?utf-8?B?YU9VTUo2akdxY0xpVE4yUzBDZjRhejJZaUFYdDJqWFdQRnRuYWRqbUltTWhk?=
 =?utf-8?B?a29wME9KbG5tNG1KdTZJbHppbTBmNHFXRjRqTDUzSWE1SytRSnBUdHpQVTBP?=
 =?utf-8?B?c3l6ZzZYcEg3b2JZTTR2blhOdWVlUHcxK0xwTU00S1d5ZXFUcjFwTnNIN2FN?=
 =?utf-8?B?M2dma2hteENraFlVTWd4dWhMZjFWaVhvb1NFRnBhOWR0b090Qjg5Mk9sV29r?=
 =?utf-8?B?V2dDSS9uc0g4TnZJTnZjb2gvcVVJeWIzZnVqN0E0bDU2dFZTQmU3SkQ0c0xh?=
 =?utf-8?B?TkIyOUlWMm1kckFPTmpWeEw2d29UR3A5NER3aXdYbi9Gc2d4T1QrSDdlbllN?=
 =?utf-8?B?dWxaam9sVGNOZjI4eU0yZE9JVFRsc1psc2U2M3c5aFU3SGltTUt1YWZKTFBt?=
 =?utf-8?B?V2I0V29CTVVHM3k2MW95amRmZkxUUjIwMmZuQTh4SEI1dmpaWENpUFNuUmlu?=
 =?utf-8?B?bC92SkhIRUNtUUJWb2pDTXZoZnlTZEZaSy9pb0pCNVpJVStuNUpmM2MrUDlY?=
 =?utf-8?B?RzRuTkdpdWJnU3JUVzhvSjJWZnF5cUk0d1VjMXJTL012enpDbnVXNktzSFFE?=
 =?utf-8?B?TUozcXRpaXEydlZTYzZMV24xU082Nk1vYXNrUHNxUExnb29iaDU1T2ptMW9K?=
 =?utf-8?B?TXlPVFZodVBHOXVJRjNnSmcwdmpHdzZMaEtKckhVMDFybTZMcDlnRStkRUFG?=
 =?utf-8?B?Z2Y4NzBsTUdKTVNLemlQTU9kNW1WS3BPNWl0YUpkZ2F3WXB3M0ZST1hJbXNV?=
 =?utf-8?B?dDJOUDVGeXNyRmJHWi93aW5SWUZTSG42Z2l3SzV6WWI5VkhhQmt0akEvcHZJ?=
 =?utf-8?B?LzEyR2ZVWiswTUJmU3ZvNEZNNllmaFhVNytwUTdGclp4THJmTldsdnJhWEc3?=
 =?utf-8?B?N0Y5MjhWcmFweE9RbzZxbEFubmNEUGRvYlJ6Qzg4SlUxZ3RmMjRSV1NYUmFx?=
 =?utf-8?B?aFR6V1pxWEZEQWJqOXJHWDBHMjRzTlFMYTloWERzM2Ryd3N4a2JGOW1rQ3Mr?=
 =?utf-8?B?MVpsWWlPZ3VsTTh2eEZsQ2x4Y2RmbjV3QnQxWjUvT1NxaXRZQW9HZ2dkRThB?=
 =?utf-8?B?YTdrWjJQSlBsVnEzTHZpcStTaTNDTnpGTjhjMU5zMWJPeUdkLzFULzZ0NXJv?=
 =?utf-8?B?TTFNNVlVdmt6MFNFT0E3YXB6NzJ1TGJqeGJYQ1hyR2VQMFk3end0dHBhZk8w?=
 =?utf-8?B?U3pLOXZsejVuODlTV1lhRExhTnh3TkRYWnN3Mi94SnF4MGJYdXo0L2lZNGhI?=
 =?utf-8?B?OWhxRDdaZGp1c3ZTbGx1cy94dTdaOUFYQW9FYmF4L1hFMDM1azJLRW1iMmVG?=
 =?utf-8?Q?dlFqvCSDkNVuyWeLDkGezbLd+IeqJ+4iPoEcCO9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7199d1b6-f83e-4239-fe9d-08d93c21a157
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 23:48:58.9674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uOBdZIwjrzfocW6IjmSg8YE9+6/VRTeIt7wbEVYHOkPo4SfdzfJl0oTKPTtp/70bYm5OFTisMfQtacS+s1AAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5249
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10031 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106300135
X-Proofpoint-ORIG-GUID: JFw0simz0Rl5pV6I3pCPaRuu0TfSH_in
X-Proofpoint-GUID: JFw0simz0Rl5pV6I3pCPaRuu0TfSH_in
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 6/30/21 12:24 PM, J. Bruce Fields wrote:
> On Wed, Jun 30, 2021 at 12:13:35PM -0700, dai.ngo@oracle.com wrote:
>> On 6/30/21 11:55 AM, J. Bruce Fields wrote:
>>> On Wed, Jun 30, 2021 at 11:49:18AM -0700, dai.ngo@oracle.com wrote:
>>>> On 6/30/21 11:05 AM, J. Bruce Fields wrote:
>>>>> On Wed, Jun 30, 2021 at 10:51:27AM -0700, dai.ngo@oracle.com wrote:
>>>>>>> On 6/28/21 1:23 PM, J. Bruce Fields wrote:
>>>>>>>> where ->fl_expire_lock is a new lock callback with second
>>>>>>>> argument "check"
>>>>>>>> where:
>>>>>>>>
>>>>>>>>      check = 1 means: just check whether this lock could be freed
>>>>>> Why do we need this, is there a use case for it? can we just always try
>>>>>> to expire the lock and return success/fail?
>>>>> We can't expire the client while holding the flc_lock.  And once we drop
>>>>> that lock we need to restart the loop.  Clearly we can't do that every
>>>>> time.
>>>>>
>>>>> (So, my code was wrong, it should have been:
>>>>>
>>>>>
>>>>> 	if (fl->fl_lops->fl_expire_lock(fl, 1)) {
>>>>> 		spin_unlock(&ct->flc_lock);
>>>>> 		fl->fl_lops->fl_expire_locks(fl, 0);
>>>>> 		goto retry;
>>>>> 	}
>>>>>
>>>>> )
>>>> This is what I currently have:
>>>>
>>>> retry:
>>>>                  list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>>>>                          if (!posix_locks_conflict(request, fl))
>>>>                                  continue;
>>>>
>>>>                          if (fl->fl_lmops && fl->fl_lmops->lm_expire_lock) {
>>>>                                  spin_unlock(&ctx->flc_lock);
>>>>                                  ret = fl->fl_lmops->lm_expire_lock(fl, 0);
>>>>                                  spin_lock(&ctx->flc_lock);
>>>>                                  if (ret)
>>>>                                          goto retry;
>>> We have to retry regardless of the return value.  Once we've dropped
>>> flc_lock, it's not safe to continue trying to iterate through the list.
>> Yes, thanks!
>>
>>>>                          }
>>>>
>>>>                          if (conflock)
>>>>                                  locks_copy_conflock(conflock, fl);
>>>>
>>>>> But the 1 and 0 cases are starting to look pretty different; maybe they
>>>>> should be two different callbacks.
>>>> why the case of 1 (test only) is needed,  who would use this call?
>>> We need to avoid dropping the spinlock in the case there are no clients
>>> to expire, otherwise we'll make no forward progress.
>> I think we can remember the last checked file_lock and skip it:
> I doubt that works in the case there are multiple locks with
> lm_expire_lock set.
>
> If you really don't want another callback here, maybe you could set some
> kind of flag on the lock.
>
> At the time a client expires, you're going to have to walk all of its
> locks to see if anyone's waiting for them.  At the same time maybe you
> could set an FL_EXPIRABLE flag on all those locks, and test for that
> here.
>
> If the network partition heals and the client comes back, you'd have to
> remember to clear that flag again.

It's too much unnecessary work.

Would this be suffice:

retry:
                 list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
                         if (!posix_locks_conflict(request, fl))
                                 continue;
                         if (fl->fl_lmops && fl->fl_lmops->lm_expire_lock &&
                                         fl->fl_lmops->lm_expire_lock(fl, 1)) {
                                 spin_unlock(&ctx->flc_lock);
                                 fl->fl_lmops->lm_expire_lock(fl, 0);
                                 spin_lock(&ctx->flc_lock);
                                 goto retry;
                         }
                         if (conflock)
                                 locks_copy_conflock(conflock, fl);

-Dai

>
> --b.
>
>> retry:
>>                  list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>>                          if (!posix_locks_conflict(request, fl))
>>                                  continue;
>>
>>                          if (checked_fl != fl && fl->fl_lmops &&
>>                                          fl->fl_lmops->lm_expire_lock) {
>>                                  checked_fl = fl;
>>                                  spin_unlock(&ctx->flc_lock);
>>                                  fl->fl_lmops->lm_expire_lock(fl);
>>                                  spin_lock(&ctx->flc_lock);
>>                                  goto retry;
>>                          }
>>
>>                          if (conflock)
>>                                  locks_copy_conflock(conflock, fl);
>>
>> -Dai
>>
>>> --b.
