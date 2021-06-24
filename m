Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CB53B376C
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 21:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhFXTwx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Jun 2021 15:52:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23736 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232178AbhFXTwx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Jun 2021 15:52:53 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15OJlsLd030686;
        Thu, 24 Jun 2021 19:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=YL2g2VpPrYiOqmsECS6/r++FrBwvfGP2CI/aAUqWo0c=;
 b=Rc/zOYjcsDYiT8uj5A42xFpzlps4mnBuTEcrkXVzuXKqNSoInYCQJGE148rtDKqwE7mF
 h52wxXTHaKxUXpMSOFm/iMMXioplgtssqepTs5fF5dWggxdKwz7n30eeUehcNRi6rjiR
 gdzNuMnPXkqOE6artkFI6AhhKv1xyL2WNdAWglA0akt4dgQMrpyLnHrlYbT0Mf2KGhkK
 9wGiXHfKfs4xge83axScfJ2eoz2QhLfIg4ycW6LgrvAgsvA9BWB5rzFx9658eb2rxSKo
 oRVMmTNbNIkHAzmaSGOnuG/44Ihv/LT07IYP5CnFrBI4MqtG3ivoXgrdNZvf5RJ0tNee kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39c8twavah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 19:50:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15OJjMmx103107;
        Thu, 24 Jun 2021 19:50:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by userp3030.oracle.com with ESMTP id 3995q193dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 19:50:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpihIfrLXPOAalOWGOYP/BkYWBZ8Jgb3AGg/7Pkq94achv3rEvwStK+32KpnXD2XnxZ5hpEwqBxqFDhIsobi5NUTSA/75F3S1BUnxzeVcnMQPrbuQPnrwUH2gcqsatV7fT/2SLc/AcTkbSopyeFbLB77Ciw4Rpj5pNfTn3QlhVVaVGbK3IvL10pc4ee7KV5rqd8f3D+tnuTpDhkY9Z7LWGJo9CSkQ37rJMd12Y//eUwjgOD6UdATf3gNIVvI35oniLcwF83+tXKkqZsd1zwsD1ZzZVV2vtWnEAQO931lPyp1bsacBbfKrQniZUXNgEdMgyI1pTGGEn67IrmJWAlm+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YL2g2VpPrYiOqmsECS6/r++FrBwvfGP2CI/aAUqWo0c=;
 b=hijiLhk9Fw2GWiESLRDUVaVpIYgDZh5q0O1c+KhxHKmG7V+OWgiaPhGZZ3bCX1UI8xS/0LN5p96D07Z7TSMq4kLKrN4hK5eyiH/J48GBvoDpLdqAiV3hFpkJ67NlvLQMP2QWR5UBiaUVet+2BFUUxelTWjEXSWzJgKW4QjD/3woXvOWQT12vVe52r3ykTQXhM02hCDlAUJVpAJ19cmeHFpeoAapc5PwRGrjHkofp/gG8Hhaui3XkqyJguGeAH5U3VhE3u7p26gKv4NSXsNfxWhv2gBMGmWJvQb9hczZZodMGs5ZxmI1JjpQmdJhywRxOlND2A9eTjSWeFczw5Xij7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YL2g2VpPrYiOqmsECS6/r++FrBwvfGP2CI/aAUqWo0c=;
 b=FWybxUURe0DLFCSK7OwCBBeWJG+ogd5aCEB/VBVSyif82TQXcrRbPowzgmEJ/vc26Msda3cqhKly3yvmkywlx5Nu4GnH6tXMbWwzz1lKYMgmoelXMKnOfO2dP0qHCMxyDCvbRQFH8Qr432EVsX6ZUrUHviFh3k0PFoTFuLJ2Q/I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3672.namprd10.prod.outlook.com (2603:10b6:a03:128::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 19:50:28 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be%5]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 19:50:28 +0000
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
References: <20210603181438.109851-1-dai.ngo@oracle.com>
 <20210624140216.GB30394@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <c983218b-d270-bbae-71c5-b591bfbce473@oracle.com>
Date:   Thu, 24 Jun 2021 12:50:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <20210624140216.GB30394@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SA0PR11CA0089.namprd11.prod.outlook.com
 (2603:10b6:806:d2::34) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-150-181.vpn.oracle.com (72.219.112.78) by SA0PR11CA0089.namprd11.prod.outlook.com (2603:10b6:806:d2::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 19:50:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fee129c-8511-4b5a-bef7-08d9374950fb
X-MS-TrafficTypeDiagnostic: BYAPR10MB3672:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB367273BEF2A76FAD2B0AC94787079@BYAPR10MB3672.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZebvbQ5zcUb766NnoXA256oTo32JfQMK78/+KZMCcrf/y5cHsvIHvWJZpZ4sv3OOyIuwF9I8+ky4txslpNftmdMToIJ8VKBjJDEWgoe6+sTOgroD8BIpSg2JHnD9CoZ+Qb5ixY5GVl78kksmpZ0PHNsHlvLmpoDjxLMajFg+JodM6kG+6gHLi+psJmMT0klyboWiRpLR5Ue8QajHyjMvwwpno52QbpRC5Vv1Se4CA3Wr8Om7AX2PGJgnj4na5dQ0GrD2ouFIPByTnoHoO20jICf4yLw1sw3lIBu4fYSlRlUxR3hlJ+fBWYzU0+jooQfEye8kTZZPa0YbciRo86awdUuF/uVv8EGhQqeNxV+yCXNmLZ3OMydD+c5kITYzubPCsZ0rSj3kICUQ7p+dbEWYqibIs6+wid1vXEguqiRH2rUkmh7qihgkwXfgXo+4mkahsUDofsqZEndUZzIgc+CEQyx4HLxkx3iHo507osDIV6l/nAz8a3FtZ5N1C8RPSzh8WjU+7Q/ei8YPNGiyUztO7ZKQNvboz/Cq/rhWfOPaRtgDyaq/mD3JEycYU44HTY+0sJq6GJ/tNDOHz9AD+BN59t78PZCR9S3iIxW3oBoAxe9rBD7g4qOoVia0pIDnU5R0N/xIPmZvFRpVOvqArfOISAwfCy432DoC/p/VVpVGTGEh4E4LRi/PxHWCd8+VVUnkw2661y7jDyTgWnDOfXbeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(39860400002)(396003)(366004)(6916009)(8676002)(478600001)(38100700002)(6486002)(36756003)(31696002)(8936002)(86362001)(83380400001)(2906002)(2616005)(16526019)(26005)(9686003)(53546011)(186003)(30864003)(66946007)(66476007)(66556008)(31686004)(5660300002)(956004)(4326008)(316002)(7696005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzRFc25CbmZmblJ6YTlqRktrY25jTGdRaE1jZjZ0NVcyRERnZlpOcVZTWnli?=
 =?utf-8?B?QlhIUlp5cVFrVmFzV3lSRm9oOXNyZ1RaK3FaNWtsaG9rTDZGLzMzbUlJSjNp?=
 =?utf-8?B?UU82b29IeEUrOEV3aE5TckVMWlc5R1pkZmxocGRXQStMOG0zTEcySGlYQi9t?=
 =?utf-8?B?UUhaVEJQWUNaNDdpWjRDZ0RtMTdDVGRzNGdWbGErYnJzbDg4VS9OTU9aQVZX?=
 =?utf-8?B?czdGejF2QU5nOGN5cDEvWlB0NmUxQzBrNVdIUFU3ZHVKUUtJa3pCOWRadVZK?=
 =?utf-8?B?OStBYzFldS9XdkNtMnh0ZU9mbkNTSGtIbGlhQnIwUm4zTWF1NFJWOVlrL0RD?=
 =?utf-8?B?RjhMZVlzTWVnOHRvM210VEpTbzhDZ0ZkWThBVG5EVW9vY3MvZ3B3eFFyR1NO?=
 =?utf-8?B?VnV2bHpxS0ZZTUtkckpmYkhGSGFIQkRHcEFQekU1NG8rZ1ZabG1LZFAxbC9o?=
 =?utf-8?B?QmtOWkcxaHZ3YWh2SThxNCtFaFdWNUNUMVdTbFM5V053SUFtaHlNcDhBSENK?=
 =?utf-8?B?RWE2TnVRa054MTFnaUpiZlp0TU5IcEtkOStaVVdFNFA4cGxXRzQ3UHptU0l5?=
 =?utf-8?B?OThiZDlidUUyMjlkbE10NUJJUDFNVEFWeGVtWjg1aWZRK1BLK2lYTjBrNUNz?=
 =?utf-8?B?eGliRThRUFJsVTNVVGZRc3V4K0hTQ2Iwc3RIVkxvUDVMUzd6c2xWZ2FMVEU2?=
 =?utf-8?B?VGJQck5YSHpEMUc0b1pVNjlra0ZwQnIvK3JjT2NlRWVCbHk4OEoyalpTWVRM?=
 =?utf-8?B?azcwaUYyQ1JXZDVmZjlJcW5pcm0vNVBnd2NrQm1Ob1NHVkNLVXJtTzVTUXRX?=
 =?utf-8?B?aWh6bERWclR2RVF2U0MwUGJNSnpRZWdxUThwMXVEWmVIWTVEcFBrWXpvcmQ0?=
 =?utf-8?B?N0IrK283c1ZwZHlZWWlCQWxlaElUYnJjMjFXRFFUQzN5bi9MK0I3bURDb1Vm?=
 =?utf-8?B?Y3RXYzRuRmFRbEFkVWcyMEIySkpDV09zb05CZFIzRU11U2o5M1Y4c3BpdFRB?=
 =?utf-8?B?MVVtV1Y5bzJiZlJBSHlrOURKMFRCdUlyaGl6Z3psclNUSHFOWTlqcjA0N0l3?=
 =?utf-8?B?ZFg0aVEyaHNxdGVBa0lWdHBObTh2dGh1VWhTSW9KQ25PRDV4cjgyeUphcVp3?=
 =?utf-8?B?TW1wdllsTUFmNzQreWdIRTlDZHlvKzVLRkVYNHgxL090eDJMTUZuOEFDN0pE?=
 =?utf-8?B?VWRWNWlBNWs5eks3aE53VTFiTkcxMlRDbUZKaW1YKzZWczNyL3B0blpsL3hp?=
 =?utf-8?B?TExUaStNR1lYMTJ4ZHBBTUpiWW1lanhNWkt1WWt4alFqS0FLZlRCaTRWS3F0?=
 =?utf-8?B?R3ZiZDl6RnRzREloN1loNTFFM1lZaTZJTjBKTXBkZHlMWFhYay8rYTBoQ08r?=
 =?utf-8?B?Vk9HZTFXNlhzWkJZRGxaYjZjVVdNVHViNGlPaEtvMTA4VDJ3eFUrdndkMWlD?=
 =?utf-8?B?OGJwUDRYakY5YzA0dnNlRlVicW9JMktRUlF0cm9jb1ZjZHJqYlFOM0t2U2VP?=
 =?utf-8?B?akhaT1ZyRWpBZTU1OXk1bVA1S21qMUp4U2FnK1RjbHFPcUwzM2VCeklSbkpP?=
 =?utf-8?B?MHpFZVdoSThaalFVSzhxWG5WUlgveVA2d2xoZ1RMN0EwVjBPUEZFNWluSGhm?=
 =?utf-8?B?Y0JIdzltQ1ltdnFaZzBwYmJvVTcrTlVFQkVZY01wcGRzaVB0Q2o1VU5qRUli?=
 =?utf-8?B?QTZxVEtCOWxyZFYvNkdxODZ6L2thY2pQR0ZZSHFjZG0yandhVWNDWXJhT1lP?=
 =?utf-8?Q?KsI3LCFl8pf9xc7dIeAnPU0eSNAploMDD2s+iTV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fee129c-8511-4b5a-bef7-08d9374950fb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 19:50:28.1995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNBLlrhmNnW/FgzmMg2HMoPYfO9X6Gc6uwVljPni8xI/1y5En3mhQ9T6tT2JVqoHauYsm0K3YxwzWtONO6NIXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3672
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10025 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106240109
X-Proofpoint-ORIG-GUID: CCLo_1DGiNXWLN1rrQcesVeGCsemEqJT
X-Proofpoint-GUID: CCLo_1DGiNXWLN1rrQcesVeGCsemEqJT
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 6/24/21 7:02 AM, J. Bruce Fields wrote:
> By the way, have we thought about the -ENOSPC case?
>
> An expired client could prevent a lot of disk space from being freed if
> it happens to be holding the last reference to a large file.

I think memory shortage is probably more likely to happen than running out
disk space but we have to handle this too.

>
> I'm not sure how to deal with this.  I don't think there's an efficient
> way to determine which expired client is responsible for an ENOSPC.  So,
> maybe you'd check for ENOSPC and when you see it, remove all expired
> clients and retry if there were any?

I did a quick check on fs/nfsd and did not see anywhere the server returns
ENOSPC/nfserr_nospc so I'm not sure where to check? Currently we plan to
destroy the courtesy client after 24hr if it has not reconnect but that's
a long time.

There are other immediate issues that needs to resolve:

1. before an expired client can be set as courtesy client, we need to make
sure there is no other NFSv4 clients interest in any of the locks owned by
the expired client; another v4 client tries to acquire the lock and gets
denied (the lock request is not blocked). We need a mechanism to detect
this condition and do not allow the expired client to be a courtesy client.

2. handle conflict with a v3 lock request.  The v3 lock code can detect lock
conflicted caused by an v4 client but it needs a way to call into v4 code
to destroy the courtesy client.

3. handle conflict with local lock.  Currently the lock lock code does not
even need to get conflict lock info in case of a conflict.  It's just blocked
and wait for the lock to be released. We need to detect this condition before
allowing an v4 expired client to be a courtesy client and also handle the case
after the v4 client was set to courtesy client then a local lock comes in. I'm
not sure how to handle this without modifying the fs/locks.c.

-Dai

>
> --b.
>
> On Thu, Jun 03, 2021 at 02:14:38PM -0400, Dai Ngo wrote:
>> Currently an NFSv4 client must maintain its lease by using the at least
>> one of the state tokens or if nothing else, by issuing a RENEW (4.0), or
>> a singleton SEQUENCE (4.1) at least once during each lease period. If the
>> client fails to renew the lease, for any reason, the Linux server expunges
>> the state tokens immediately upon detection of the "failure to renew the
>> lease" condition and begins returning NFS4ERR_EXPIRED if the client should
>> reconnect and attempt to use the (now) expired state.
>>
>> The default lease period for the Linux server is 90 seconds.  The typical
>> client cuts that in half and will issue a lease renewing operation every
>> 45 seconds. The 90 second lease period is very short considering the
>> potential for moderately long term network partitions.  A network partition
>> refers to any loss of network connectivity between the NFS client and the
>> NFS server, regardless of its root cause.  This includes NIC failures, NIC
>> driver bugs, network misconfigurations & administrative errors, routers &
>> switches crashing and/or having software updates applied, even down to
>> cables being physically pulled.  In most cases, these network failures are
>> transient, although the duration is unknown.
>>
>> A server which does not immediately expunge the state on lease expiration
>> is known as a Courteous Server.  A Courteous Server continues to recognize
>> previously generated state tokens as valid until conflict arises between
>> the expired state and the requests from another client, or the server reboots.
>>
>> The initial implementation of the Courteous Server will do the following:
>>
>> . when the laundromat thread detects an expired client and if that client
>> still has established states on the Linux server then marks the client as a
>> COURTESY_CLIENT and skips destroying the client and all its states,
>> otherwise destroy the client as usual.
>>
>> . detects conflict of OPEN request with a COURTESY_CLIENT, destroys the
>> expired client and all its states, skips the delegation recall then allows
>> the conflicting request to succeed.
>>
>> . detects conflict of LOCK/LOCKT request with a COURTESY_CLIENT, destroys
>> the expired client and all its states then allows the conflicting request
>> to succeed.
>>
>> To be done:
>>
>> . fix a problem with 4.1 where the Linux server keeps returning
>> SEQ4_STATUS_CB_PATH_DOWN in the successful SEQUENCE reply, after the expired
>> client re-connects, causing the client to keep sending BCTS requests to server.
>>
>> . handle OPEN conflict with share reservations.
>>
>> . instead of destroy the client anf all its state on conflict, only destroy
>> the state that is conflicted with the current request.
>>
>> . destroy the COURTESY_CLIENT either after a fixed period of time to release
>> resources or as reacting to memory pressure.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c        | 94 +++++++++++++++++++++++++++++++++++++++++++---
>>   fs/nfsd/state.h            |  1 +
>>   include/linux/sunrpc/svc.h |  1 +
>>   3 files changed, 91 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index b517a8794400..969995872752 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -171,6 +171,7 @@ renew_client_locked(struct nfs4_client *clp)
>>   
>>   	list_move_tail(&clp->cl_lru, &nn->client_lru);
>>   	clp->cl_time = ktime_get_boottime_seconds();
>> +	clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>>   }
>>   
>>   static void put_client_renew_locked(struct nfs4_client *clp)
>> @@ -4610,6 +4611,38 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
>>   	nfsd4_run_cb(&dp->dl_recall);
>>   }
>>   
>> +/*
>> + * Set rq_conflict_client if the conflict client have expired
>> + * and return true, otherwise return false.
>> + */
>> +static bool
>> +nfsd_set_conflict_client(struct nfs4_delegation *dp)
>> +{
>> +	struct svc_rqst *rqst;
>> +	struct nfs4_client *clp;
>> +	struct nfsd_net *nn;
>> +	bool ret;
>> +
>> +	if (!i_am_nfsd())
>> +		return false;
>> +	rqst = kthread_data(current);
>> +	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
>> +		return false;
>> +	rqst->rq_conflict_client = NULL;
>> +	clp = dp->dl_recall.cb_clp;
>> +	nn = net_generic(clp->net, nfsd_net_id);
>> +	spin_lock(&nn->client_lock);
>> +
>> +	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) &&
>> +				!mark_client_expired_locked(clp)) {
>> +		rqst->rq_conflict_client = clp;
>> +		ret = true;
>> +	} else
>> +		ret = false;
>> +	spin_unlock(&nn->client_lock);
>> +	return ret;
>> +}
>> +
>>   /* Called from break_lease() with i_lock held. */
>>   static bool
>>   nfsd_break_deleg_cb(struct file_lock *fl)
>> @@ -4618,6 +4651,8 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>>   	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
>>   	struct nfs4_file *fp = dp->dl_stid.sc_file;
>>   
>> +	if (nfsd_set_conflict_client(dp))
>> +		return false;
>>   	trace_nfsd_deleg_break(&dp->dl_stid.sc_stateid);
>>   
>>   	/*
>> @@ -5237,6 +5272,22 @@ static void nfsd4_deleg_xgrade_none_ext(struct nfsd4_open *open,
>>   	 */
>>   }
>>   
>> +static bool
>> +nfs4_destroy_courtesy_client(struct nfs4_client *clp)
>> +{
>> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>> +
>> +	spin_lock(&nn->client_lock);
>> +	if (!test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) ||
>> +			mark_client_expired_locked(clp)) {
>> +		spin_unlock(&nn->client_lock);
>> +		return false;
>> +	}
>> +	spin_unlock(&nn->client_lock);
>> +	expire_client(clp);
>> +	return true;
>> +}
>> +
>>   __be32
>>   nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open)
>>   {
>> @@ -5286,7 +5337,13 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>>   			goto out;
>>   		}
>>   	} else {
>> +		rqstp->rq_conflict_client = NULL;
>>   		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
>> +		if (status == nfserr_jukebox && rqstp->rq_conflict_client) {
>> +			if (nfs4_destroy_courtesy_client(rqstp->rq_conflict_client))
>> +				status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
>> +		}
>> +
>>   		if (status) {
>>   			stp->st_stid.sc_type = NFS4_CLOSED_STID;
>>   			release_open_stateid(stp);
>> @@ -5472,6 +5529,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   	};
>>   	struct nfs4_cpntf_state *cps;
>>   	copy_stateid_t *cps_t;
>> +	struct nfs4_stid *stid;
>> +	int id = 0;
>>   	int i;
>>   
>>   	if (clients_still_reclaiming(nn)) {
>> @@ -5495,6 +5554,15 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   		clp = list_entry(pos, struct nfs4_client, cl_lru);
>>   		if (!state_expired(&lt, clp->cl_time))
>>   			break;
>> +
>> +		spin_lock(&clp->cl_lock);
>> +		stid = idr_get_next(&clp->cl_stateids, &id);
>> +		spin_unlock(&clp->cl_lock);
>> +		if (stid) {
>> +			/* client still has states */
>> +			set_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>> +			continue;
>> +		}
>>   		if (mark_client_expired_locked(clp)) {
>>   			trace_nfsd_clid_expired(&clp->cl_clientid);
>>   			continue;
>> @@ -6440,7 +6508,7 @@ static const struct lock_manager_operations nfsd_posix_mng_ops  = {
>>   	.lm_put_owner = nfsd4_fl_put_owner,
>>   };
>>   
>> -static inline void
>> +static inline int
>>   nfs4_set_lock_denied(struct file_lock *fl, struct nfsd4_lock_denied *deny)
>>   {
>>   	struct nfs4_lockowner *lo;
>> @@ -6453,6 +6521,8 @@ nfs4_set_lock_denied(struct file_lock *fl, struct nfsd4_lock_denied *deny)
>>   			/* We just don't care that much */
>>   			goto nevermind;
>>   		deny->ld_clientid = lo->lo_owner.so_client->cl_clientid;
>> +		if (nfs4_destroy_courtesy_client(lo->lo_owner.so_client))
>> +			return -EAGAIN;
>>   	} else {
>>   nevermind:
>>   		deny->ld_owner.len = 0;
>> @@ -6467,6 +6537,7 @@ nfs4_set_lock_denied(struct file_lock *fl, struct nfsd4_lock_denied *deny)
>>   	deny->ld_type = NFS4_READ_LT;
>>   	if (fl->fl_type != F_RDLCK)
>>   		deny->ld_type = NFS4_WRITE_LT;
>> +	return 0;
>>   }
>>   
>>   static struct nfs4_lockowner *
>> @@ -6734,6 +6805,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	unsigned int fl_flags = FL_POSIX;
>>   	struct net *net = SVC_NET(rqstp);
>>   	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>> +	bool retried = false;
>>   
>>   	dprintk("NFSD: nfsd4_lock: start=%Ld length=%Ld\n",
>>   		(long long) lock->lk_offset,
>> @@ -6860,7 +6932,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
>>   		spin_unlock(&nn->blocked_locks_lock);
>>   	}
>> -
>> +again:
>>   	err = vfs_lock_file(nf->nf_file, F_SETLK, file_lock, conflock);
>>   	switch (err) {
>>   	case 0: /* success! */
>> @@ -6875,7 +6947,12 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	case -EAGAIN:		/* conflock holds conflicting lock */
>>   		status = nfserr_denied;
>>   		dprintk("NFSD: nfsd4_lock: conflicting lock found!\n");
>> -		nfs4_set_lock_denied(conflock, &lock->lk_denied);
>> +
>> +		/* try again if conflict with courtesy client  */
>> +		if (nfs4_set_lock_denied(conflock, &lock->lk_denied) == -EAGAIN && !retried) {
>> +			retried = true;
>> +			goto again;
>> +		}
>>   		break;
>>   	case -EDEADLK:
>>   		status = nfserr_deadlock;
>> @@ -6962,6 +7039,8 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	struct nfs4_lockowner *lo = NULL;
>>   	__be32 status;
>>   	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>> +	bool retried = false;
>> +	int ret;
>>   
>>   	if (locks_in_grace(SVC_NET(rqstp)))
>>   		return nfserr_grace;
>> @@ -7010,14 +7089,19 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	file_lock->fl_end = last_byte_offset(lockt->lt_offset, lockt->lt_length);
>>   
>>   	nfs4_transform_lock_offset(file_lock);
>> -
>> +again:
>>   	status = nfsd_test_lock(rqstp, &cstate->current_fh, file_lock);
>>   	if (status)
>>   		goto out;
>>   
>>   	if (file_lock->fl_type != F_UNLCK) {
>>   		status = nfserr_denied;
>> -		nfs4_set_lock_denied(file_lock, &lockt->lt_denied);
>> +		ret = nfs4_set_lock_denied(file_lock, &lockt->lt_denied);
>> +		if (ret == -EAGAIN && !retried) {
>> +			retried = true;
>> +			fh_clear_wcc(&cstate->current_fh);
>> +			goto again;
>> +		}
>>   	}
>>   out:
>>   	if (lo)
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index e73bdbb1634a..bdc3605e3722 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -345,6 +345,7 @@ struct nfs4_client {
>>   #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
>>   #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
>>   					 1 << NFSD4_CLIENT_CB_KILL)
>> +#define NFSD4_CLIENT_COURTESY		(6)	/* be nice to expired client */
>>   	unsigned long		cl_flags;
>>   	const struct cred	*cl_cb_cred;
>>   	struct rpc_clnt		*cl_cb_client;
>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>> index e91d51ea028b..2f0382f9d0ff 100644
>> --- a/include/linux/sunrpc/svc.h
>> +++ b/include/linux/sunrpc/svc.h
>> @@ -304,6 +304,7 @@ struct svc_rqst {
>>   						 * net namespace
>>   						 */
>>   	void **			rq_lease_breaker; /* The v4 client breaking a lease */
>> +	void			*rq_conflict_client;
>>   };
>>   
>>   #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
>> -- 
>> 2.9.5
