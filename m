Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49FB3B890C
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 21:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhF3TQP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 15:16:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47942 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233670AbhF3TQM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Jun 2021 15:16:12 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UJ6q8J007417;
        Wed, 30 Jun 2021 19:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=IlMJ3iZmkwCk5hCw2uFWfbAoLsfXhvNHbni2rrulHB0=;
 b=pVWRb2tiYlbOb67zJkjodSA2J/yr8dl6aGLrDdGKCaOfmWqmWgDVzjZsH/nBtr3jCkYx
 vMzAjK2+yysBu4/KMXzAXd2pFOpjZO/n04kaycTMevxF2t+nJJpfa9TdextSi+7u2MaR
 y+sXqkQre6lpWCJVIVNEsb2vhkfYlYtn+3qvsGpoS7iQ/oZ1G5krWwRcVT3Ls9ReLBi2
 gMO5NLJuToQL5xyrqomx4o9EE+tjzCW4nKodY92UxeN//qn+qT7HMEjZE28NF+fYwKYD
 kpbaRtwU8z7Ss4wT6bM3vQW2TGuBQqG4by/1SVntmMclhrXkN76712JrOg5GmcQ2An/z 2g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gguq1rj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 19:13:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15UJ06fB012734;
        Wed, 30 Jun 2021 19:13:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3020.oracle.com with ESMTP id 39ee0xx1wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 19:13:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URdPZoZ2BAatAnZOa39Dgbbpok+QTIOmarejL4mpbMVhoU0Ok3QKLZAxBFTv7kg/jCC8EKjib1g5/9qlSMxVsSlWO7XoLx+7uUHMlVdVKvf+Ilkp+AGAvUv6ZOZjlz74/5elg4vyFeeFcYpkM9DTJl5fp9mnlvDlMnorkqG6qXw67zwppWzQr5XZuGOtmNA3fdCi3bOcXlOTHwh/89fgQo9IZC3f0hno2CKA6U+Tcki+Y5xYwdz+/EJE+OzBquc5oKi2b8HhRHHNUPFFxEYD/Q7EyXp5fbli97jw70+YH/FUFYU2YfEOqr3Safeg9v9MY9vREpXx9pXFfG5cL63kYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlMJ3iZmkwCk5hCw2uFWfbAoLsfXhvNHbni2rrulHB0=;
 b=Brw1peUqWfV5CkNvqThmAAqC8WPaUKtuuayvUzYkjq6cyP7RtChvn7fJExNHDUb+r5UbYU4hoTyFa+HjWKFxk1WAFmm+Q5Po9Vr9+GcjSQoafq8+hNjwUsy74ycF0qgz19sK0UdKH4ZiGiSf0Jokz267q+L87Td6r0tBhf4hTiLxA/YqwCFGyAuE+/FiDbrdRWVZU5LfAZrgBLx3ORvwb5RbeWVD6rCqRKrUyAYffx8KANDH+AdrZB2GWHm9V4O+zu9KUBkh4S4P5ri4GaQz4yhp3eJryMjPb6GaEDS/J8wEh2Dy78GYiQc04ZdXHW6EAG/mejIJp3X6FBTq0blWHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlMJ3iZmkwCk5hCw2uFWfbAoLsfXhvNHbni2rrulHB0=;
 b=m+CTbcnnQKNyIj+XBlIzlqAJZa5/9gPWOlm1qjBTdcLlwk5fHK4GVXwIy4iBlcGuNq6a/1T2QEnQf8FrSvhL/ipyDifpp1VxCTcXmDi+6M71rWlZ4yFflhZrspXi4AT47dqNCe1Z94qNFSvBK/kkkXNBYxCsbDQpnuxuEuKWE3o=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB4161.namprd10.prod.outlook.com (2603:10b6:a03:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Wed, 30 Jun
 2021 19:13:38 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be%5]) with mapi id 15.20.4264.027; Wed, 30 Jun 2021
 19:13:38 +0000
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
From:   dai.ngo@oracle.com
Message-ID: <08884534-931b-d828-0340-33c396674dd5@oracle.com>
Date:   Wed, 30 Jun 2021 12:13:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <20210630185519.GG20229@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SN4PR0601CA0001.namprd06.prod.outlook.com
 (2603:10b6:803:2f::11) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-232-63.vpn.oracle.com (72.219.112.78) by SN4PR0601CA0001.namprd06.prod.outlook.com (2603:10b6:803:2f::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 19:13:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eda417df-056d-4162-2b65-08d93bfb2a3a
X-MS-TrafficTypeDiagnostic: BY5PR10MB4161:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB41615E53C4E3DF980FAE619987019@BY5PR10MB4161.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Le9/LcXMaiFSuU1ay5IfQwsmRnhQXZyXWodID1KBAaJ2Jh+1lHs3b0E1in5kCfzWlADihWvXZ0kyDDMf/f+51C4q/39P5P+GrNBzF4XIFPJf8dpNfGoTmNfhlWfKFTY4JvNPf7y8a4BpQN8fpKEeqY3ESpMqGRTozb0xQOTnmGSEWj+Exi1ZIM43405uHiAS861Zess/RnBXNONoyyAmE9R6AC6c2hV6cD4zjdYhNSpyj+esCe6g5i/shrxZCmJ5V2PRXzpyiZ/AaIn/MIOCIT2D9EiYpjDslE+qB7Ql/5L5pRLtlATMP9tClUTehPjP1p/tJByvaqLvnkBYXX3XegnKwwqPp45JWvh2ntNTXyYAKDr9Gx5IyTVPtv3iv1NJqjbB5Nq/uRuoeZP2kJguSfNihlrbUWJFx6ryNIDb9fijJNPgPd3Nbpa5abe4sVBpYtJluJAoSSXSi4/B7DRgjyNECIXHjJMBDtGjthZWA+/2KNj047oS8QurfnTWsAdW+hgwTi8nkM6SkSD2CGMkQvT2XcBTpJ5B940ZsPTxoz4nQi1Ie7wLJb4AbQG1BXf1TxPw8pEVPUFFBRH0f9kxfHTxccsbNUAZWBXSngyvB3cC0D0VlSbwHVwlG+I02tpbQHd1OSmSSJ1B/Lu/3o7KZfuRJZKwxAgxAo/uUYJ1t/Uuopksoc3Z2t3zuEn9aBKLve/KtvgfkcTYC+AZPd/D9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(39860400002)(396003)(366004)(83380400001)(38100700002)(31686004)(478600001)(6486002)(186003)(7696005)(8676002)(16526019)(53546011)(956004)(5660300002)(31696002)(26005)(316002)(4326008)(9686003)(66476007)(66556008)(6916009)(2906002)(8936002)(36756003)(2616005)(86362001)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEcxcnFrZHZSYi8vaWxyeE00TUhHM3lKb1YzZTJBVGpGbnF3L205b2lmQ2lD?=
 =?utf-8?B?OC8xcHZmM2QzRDZCeHkyZUVNek5mVTZJV25wNHBOY0c0aTRSTnlPT09YRjBV?=
 =?utf-8?B?NlQ1amZldCtsRTdJZk1iQTlRNXhHL1ZKelB6Q3FZWWxKUTlmK3ZuMGJSeDFG?=
 =?utf-8?B?bmpNRm14bVo0MzhtbVd4enhsYk9ERXZURDIrbXRpSENjUTc1TXgxWEdDYmRI?=
 =?utf-8?B?eEFjTHN5eVlCajNxTHY4Zk56YmJIU1k2WndSNVNIaU8wYU9GYlE2QnpqeFBm?=
 =?utf-8?B?MC9TNElzMXJpK09NQ2tsWElHeUt0NFNweHpNaWV6NkRCaWVnZE5uak1XQUtK?=
 =?utf-8?B?WEI1bUtzaWZ3ZExGWlE5eVJoWVhNM3VYRE1SQjRWRHRGK3pwb3g4UzFoUlNu?=
 =?utf-8?B?dGFnTU42L0Myd1ZaRGVBOXQ3NnNpMzYrZ3lxLzV2L3JwVzU1UU04d0FuQStz?=
 =?utf-8?B?NVp3MGRxZTcwY0lpSEMvU0tmZkRnWUpqY0E5SkcvdjljZkkxa0VidTVMZG1F?=
 =?utf-8?B?TTZMbkRUVUJGbTUvQWZBa0xaWFM3RFJVUThWZjlSdVpQMXp0SWwzN2lMS044?=
 =?utf-8?B?clhBYWZ6Q3FBaDZzZ1pVVUlLOGxBVkE1RWh2YlliZ2FRYXZSRmw5Yjd1dGNK?=
 =?utf-8?B?dExwZmxIZHl4cWhWQ1F4d3p4SUJLalVxZXg1emhnUklCekJhaFhyZmtZNWhS?=
 =?utf-8?B?RjRKcE02TVpXWTVDblJLdmJTMGRrWlYycUlKTXowOC9vdEhzaXJtdmlJQ05l?=
 =?utf-8?B?VVBmVmJlMjhQL2llbUlQSlhmbG5OSyt5eGZEdzFMY3B4dStrQ2k5Z2dUQjdr?=
 =?utf-8?B?NnhtQzArWTY2QlZQalpvWkZGaFF1RXVaYmpyekNxSFI4eFB4ckJSOVNXYWQ2?=
 =?utf-8?B?eS9EdUI0bXJJUklTLzJnRkRjTFZKcFJ2bGNHRUlNWFArWXk2QWhCOGJVVHBP?=
 =?utf-8?B?U1hGM3pDSUIwRlNOZC80K05ac1ZIYVdwUU5Nb2ZDRVhOa2hzQyt6NUJ6dFFp?=
 =?utf-8?B?aDVaSDhnSlBnZ0gxWmNXazVaOHdDQ1NibkVJN2swT1o2SXRtL2VmYUI0T3p4?=
 =?utf-8?B?cHFmRkgwT1haYXpTN1JsK2Z2ODEzOEU2TGFMckJMdm5KblhyVWF2SSsvaFA1?=
 =?utf-8?B?aXhyYnEzY2E5ZXphNGF6YUNXUWlmRTdNRXFEN2hBbGFUcThNVjVrMUR6N0pT?=
 =?utf-8?B?OG5HV2pzTHE3YVFrQ1B6V3ZIWGZhRjV5L0JGU2dLaEpBNWhIOEpnbGNYVnZ1?=
 =?utf-8?B?K1U5TjVwcDhVWWRGb1ZpRDBvazBYM1VDcTNNVVBDN3B3RDU3aEY1ejUyZ3Vn?=
 =?utf-8?B?T2hjak1aRW1VN0Z3b1lLZ1VrZ05rdnE0SzRjNkh1N3Urb0VCTm41eHFkSFdU?=
 =?utf-8?B?SzlZeW1PcU5HVUh3dUx5RlQ3S0IwQ3VDbXFqSzJoVWJ1RlZJaG90WGdXbSsz?=
 =?utf-8?B?aHNob1AxdEJnQm5Bem4xQzByRVVIRSs4eXNQS3BuLzBGZ2doanVickZ0VFpS?=
 =?utf-8?B?TDZPSDJsWjFmUDZSQy96aGtZNDQ3YVNZeDVERlY4enRiaFV0ZGg2WWQyR25T?=
 =?utf-8?B?ZUs4Um4zeXlHZ01iU0RYREVtYlJvdE5jVXozVWYwcTE5Y2VwUjgvdUo2eUJ2?=
 =?utf-8?B?WGZsak1lZDdyTSs2bXhuZlhxQUlHcnkzNGVLcHIxeTlHMkk1SWRRa2NtUWxO?=
 =?utf-8?B?ZGVOYy9aNzdHSFV5Sy9HelpCY2hIQVRJUUdZZU5kcGtzSFRPK28vWHBBRkY5?=
 =?utf-8?Q?zLq0IjNsH7Eo/h0SpiGndsVy52e5o1ICbSOGH5s?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda417df-056d-4162-2b65-08d93bfb2a3a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 19:13:38.1797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoeyQf/ic7JNJ03nPY6NM00Qj9HbAC1srIXgNlr2/qX2WUS2eEzeB4v+Q8Ja1aVFQLWK4C9kCKNh+ZxUh6Wy2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4161
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10031 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106300106
X-Proofpoint-ORIG-GUID: olIZBlRT68QXQNSBmtfB68CCJHCO9cgW
X-Proofpoint-GUID: olIZBlRT68QXQNSBmtfB68CCJHCO9cgW
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 6/30/21 11:55 AM, J. Bruce Fields wrote:
> On Wed, Jun 30, 2021 at 11:49:18AM -0700, dai.ngo@oracle.com wrote:
>> On 6/30/21 11:05 AM, J. Bruce Fields wrote:
>>> On Wed, Jun 30, 2021 at 10:51:27AM -0700, dai.ngo@oracle.com wrote:
>>>>> On 6/28/21 1:23 PM, J. Bruce Fields wrote:
>>>>>> where ->fl_expire_lock is a new lock callback with second
>>>>>> argument "check"
>>>>>> where:
>>>>>>
>>>>>>      check = 1 means: just check whether this lock could be freed
>>>> Why do we need this, is there a use case for it? can we just always try
>>>> to expire the lock and return success/fail?
>>> We can't expire the client while holding the flc_lock.  And once we drop
>>> that lock we need to restart the loop.  Clearly we can't do that every
>>> time.
>>>
>>> (So, my code was wrong, it should have been:
>>>
>>>
>>> 	if (fl->fl_lops->fl_expire_lock(fl, 1)) {
>>> 		spin_unlock(&ct->flc_lock);
>>> 		fl->fl_lops->fl_expire_locks(fl, 0);
>>> 		goto retry;
>>> 	}
>>>
>>> )
>> This is what I currently have:
>>
>> retry:
>>                  list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>>                          if (!posix_locks_conflict(request, fl))
>>                                  continue;
>>
>>                          if (fl->fl_lmops && fl->fl_lmops->lm_expire_lock) {
>>                                  spin_unlock(&ctx->flc_lock);
>>                                  ret = fl->fl_lmops->lm_expire_lock(fl, 0);
>>                                  spin_lock(&ctx->flc_lock);
>>                                  if (ret)
>>                                          goto retry;
> We have to retry regardless of the return value.  Once we've dropped
> flc_lock, it's not safe to continue trying to iterate through the list.

Yes, thanks!

>
>>                          }
>>
>>                          if (conflock)
>>                                  locks_copy_conflock(conflock, fl);
>>
>>> But the 1 and 0 cases are starting to look pretty different; maybe they
>>> should be two different callbacks.
>> why the case of 1 (test only) is needed,  who would use this call?
> We need to avoid dropping the spinlock in the case there are no clients
> to expire, otherwise we'll make no forward progress.

I think we can remember the last checked file_lock and skip it:

retry:
                 list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
                         if (!posix_locks_conflict(request, fl))
                                 continue;

                         if (checked_fl != fl && fl->fl_lmops &&
                                         fl->fl_lmops->lm_expire_lock) {
                                 checked_fl = fl;
                                 spin_unlock(&ctx->flc_lock);
                                 fl->fl_lmops->lm_expire_lock(fl);
                                 spin_lock(&ctx->flc_lock);
                                 goto retry;
                         }

                         if (conflock)
                                 locks_copy_conflock(conflock, fl);

-Dai

>
> --b.
