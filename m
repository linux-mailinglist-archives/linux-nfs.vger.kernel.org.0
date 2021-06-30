Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753663B7F30
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 10:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhF3IoJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 04:44:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5926 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232982AbhF3IoI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Jun 2021 04:44:08 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15U8boKB028859;
        Wed, 30 Jun 2021 08:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3rzYSVFsoZyNtKJJlaXmYJiwU/hbrE6D72yDKJj346Q=;
 b=WN8OCNtqjg3E/BisA+ZblbS6dg2h3PaQxYgildfjHUuVj0islZkK0HG413Az1q+NXlzv
 DjiOEYPx+WaIkEOO6BzHLPbnPJjNIgtib5vn7m1Qwt0oKYQ4TxbFFvqm816Oba25YpSq
 SbzTl2RpiV79hweH+3u0LkFloem9C6wNOC/6cHGPIHe1rCZMtmTzTtDUDdB64+qpq6sK
 rXFUIPLyNshxDWmggHmR3yowSOpeRtGaYxK/oHQQavtrnxhcsFJnz8QQcV5kIB15zCyD
 yddj1E1wYR7z8CmEtJtCgG1eJIa+t7C37pJIpXAm4bwd0/NqKwKzSRXJvFqd3BkZfJ4q hA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gha48e88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 08:41:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15U8aBpp031521;
        Wed, 30 Jun 2021 08:41:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3020.oracle.com with ESMTP id 39ee0ws36r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 08:41:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UU96B/gwSrYmH0FjrmZ8161RUYiwecNWSThi6GnbmrzAfdyu5DaHwBCGoIu7hpDQozur+wwS27saGiPjhnEh6fo0coRd42gTIW2rHLfvYmjyJBcBjeOWcsMeMddHnO6/Cyt925CYVL4DWBRzq95iE/RwBE6TcidnV+w4FGjbJA4BzLfN/O4nmTFRyhquCQ6b60xvgP9DezTt1i7hKXPdBcHF6czSb5+JmTFUflBwIkVNvwQwBl7YgiUDkA4VJvY2G7S5mm5kr1vN39QH883jDqnhvLxOO8VNOSoE08xGGtCr2pEzXQrINV019djEyqZVHzsHKRM/UEx2ofzYSxFNJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rzYSVFsoZyNtKJJlaXmYJiwU/hbrE6D72yDKJj346Q=;
 b=Vx4fMMSJnBBxnMMxaEL9ZWU+tcSgY8B70cLGLmrxtPmV6fDpeTqpNPSCKL25EtYuOvSM39Q7R1GHO6n0hp+rlKMWTUw3L11WeS2UphsjAN9de+UKeIDu4cNsWU9LXd8p6r4kH2Z+dg3+8A7OImJ6voSS0gT8aFA3CDen2nvKdSd48mxUVzAJROM0zC/muCIXXCR+DYvJF1S9s+eR7TCZkyEUA94Gp7J1olOge6VNN5DGrl2jF3qIKIZpoY2IE+YrrdZNVtx+crC2lZsL1ipyWaESJxXCHKUaXkElHv5X1/osUnZlNxgC9DEN4TR6YrvmBSOSRgWFD2YkqyB684ishQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rzYSVFsoZyNtKJJlaXmYJiwU/hbrE6D72yDKJj346Q=;
 b=CHDxYoHZ75dmX+f4KXPjIfw8sloisNXwDpblhy7OIVlXL+CRzAu7A2YphdDwYGORmNFN8vKDNGawEkonXteoMn2cvO0PD+ssVB9wJGUv0u2aRY1ATfjmuzHbERnGnqFLPQ6aD2j1sIt49ttY89Yqwhwx4tfRXas4Aemewkb6N90=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Wed, 30 Jun
 2021 08:41:35 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be%5]) with mapi id 15.20.4264.027; Wed, 30 Jun 2021
 08:41:35 +0000
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
References: <20210603181438.109851-1-dai.ngo@oracle.com>
 <20210628202331.GC6776@fieldses.org>
 <dc71d572-d108-bcfc-e264-d96ef0de1b36@oracle.com>
 <fae4d46d-286c-013b-7606-97231fb1c17e@oracle.com>
 <20210630013529.GA6200@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <4d05112d-4d75-afeb-c7c6-ebba650d0f1b@oracle.com>
Date:   Wed, 30 Jun 2021 01:41:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <20210630013529.GA6200@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: BYAPR08CA0038.namprd08.prod.outlook.com
 (2603:10b6:a03:117::15) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-144-55.vpn.oracle.com (72.219.112.78) by BYAPR08CA0038.namprd08.prod.outlook.com (2603:10b6:a03:117::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend Transport; Wed, 30 Jun 2021 08:41:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0b7c010-8ff3-4df2-47cb-08d93ba2de2d
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB4257199D6851CBF87CA7142B87019@BY5PR10MB4257.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BEquSbNsEeE+xW2oAfD1TqTrFDK6HijCCTehFcWFuHtbCcRKUdBdmCppChyRHH1OkmVru8D3EluvzSxbZI+80u31d0XL01PU/W5GR/WgybCrmZEtWGDfKuzt5v6GPT/MvHoQBrAe0QEQ3HZlTe+cIDTPY32wwv4s9BWySeRgy106O1XrT9KKCFQTZ3R+ujEWGki+V0gZUpygAg5UGSsNSGeBJpVMn1hTGL3BW5yBQFrftsk6VSFlbx8qYBCFzcJjNP894FKomlHzHQndoPzcz6sRfqX6dv+ErYTwhLM46OgwBx5o4wDkLxyIdIgA41/Pty5DlHyiajqu7OY1SspbMk+0aKy81f87NgV6vMGHoFDXi2cFAT1rDuyQ5PALgamYFwr5k09sWC2Ft68dNkO9rk1/+sEafQzaYgEcE38EP2GqGchxeb5BJd4YWoUi0CbWSitC3DLLYO1zrChw4St9I0HGowyEP+BpwvozSVEnZSR79QdUTXQ0OBRUQzOOYcm4zZDx1pWc9SqEOmT3++6LG4nz6kDhyedNSULg/TOYSmqIAdkhDXcg9EGSyoEp7nINxupHZ+Nc02NQN3jBMGggEhziFXEel36FVI2p9IO4XZ26VAFgZbWkKBWgAsTkx9UcBdiUbmaGXIU+SiGbxG34ad75M4D1Zd4GjGQ9k8Yjp0jceI96aMLvDcmnJlvno/JWZk/Pdk23qZO9CJJMMBtXow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(346002)(136003)(376002)(6486002)(8676002)(316002)(186003)(38100700002)(86362001)(31696002)(8936002)(36756003)(26005)(16526019)(83380400001)(2906002)(956004)(478600001)(53546011)(2616005)(31686004)(4326008)(7696005)(6916009)(66946007)(66556008)(5660300002)(9686003)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFFRaU1JWmRZd2x4UVVGdjBReGJLZEFhUm1GVmhtRzROUkd4VTNMMnYyeXdJ?=
 =?utf-8?B?MFNISWhCZU9kSkFzZEFkemRDdXVrY3FiVTV2ZU1oT0FCRnVrVmFWS3pDdHIz?=
 =?utf-8?B?azRWTjRrQjJCYzdDbTVvM1psbmowWS8wc3VLMUwxWnArcUJRNml1cmVoUHhi?=
 =?utf-8?B?ZjZ0dVAvSU93SCtKemxCbGFxWXdOUGtKT3RKeW9vOGxpN0cxMUlkdC9TS2lK?=
 =?utf-8?B?T1F2Mi9uT24zNTVnMzM0WmhTZkRGWUJlQUFCckM3NlNrRUlVN1FYdDRLZWZa?=
 =?utf-8?B?QzBVV1VIMmE0eG5NK0swWVVFL0xJSTlNd2J1WWhweVpSSisxRVgrV3hIc2xE?=
 =?utf-8?B?TGZlM1BHc2U5Z0VuamhxY285aU4rNWFJNlVBQUZ1bzhsQkR3WnhhcG5PekxU?=
 =?utf-8?B?SGtpQVV3U0ZjMmtWUGNYaW9QeDYvNEYvdnplODY1L0p3azJ4d0IwYUcwRWEx?=
 =?utf-8?B?NmtQN09paVZzR01JdEREYlVSZG9CcmdNbG9XNHJMNDZqUnFic3M3VEFGeTdJ?=
 =?utf-8?B?aGZPNEVIZ3J4M1NwQUpHY1k4RFM3QjVjMjNNdWJpckVNZjdweWxUYW1oWHNQ?=
 =?utf-8?B?K3E0MUNRZTZNekZRNjQ5ZnluZ2h3UnNHV2NkS3Z6T1VzUmFGQTBDMEIvMm0w?=
 =?utf-8?B?YXMwdlJHVnhzamZJTjRsVTd3WDA4K2R6NE1ycWdTbmlocy9WZ1FjVXdCRmpK?=
 =?utf-8?B?cHRrRjV3Y3NGOEhmdElraStKM3ROUDZpNjZzNWl2ektpVHpHeU92ZHRzWktQ?=
 =?utf-8?B?UUpkcE9kNC9VdUh1OXkrU3l6TTl2ejlEYnZFamcyT3J1Y0hZenNUZXhHQWE1?=
 =?utf-8?B?NFVnMVVTOVNaakNkNzJZUW5JbXI3Nkd2U2xxWjZURXFmWlk4Q2ptdndRNlBG?=
 =?utf-8?B?L2l5YlE4YXc4dTBwMlU2V2xic0VxQjRiaU02WXpFZkc5U3dXOUhEUEZ2T1Ro?=
 =?utf-8?B?ek9zZURrY29YUDFMbEI5VHZUMnAzUkNEdjVyMXI3blFrOWd3aUR6eCtVeVYv?=
 =?utf-8?B?TU1lc0FsUnV2YjJVajlKc05FdUxmcnY1WnpPOFdaaWczZlJ3Qk9xbHo4MXUr?=
 =?utf-8?B?TkdPMmtLSkl5SFB4dVRwV1lXMlhJbzEvVHZ5SWhtNC9NdWM1MEtuNkY0YjIr?=
 =?utf-8?B?b1lEWUtURElqRW42M1V0MnBCN0hjNndNYW85QzAxaHhoWU9zZVYwM0Nvcmx2?=
 =?utf-8?B?bWE1MTl5MVJlRW1ZU3o5UjVXSkJsREhkazJLbHJkWU9xeHZIT2JZd1pvTm9x?=
 =?utf-8?B?dFNTRGVVam91RU9KWlVIR0MzcU03VGlPbGI3ck5jayt2Y204Q2ZmWUx2VC9F?=
 =?utf-8?B?K0lOd0gvaHhBcEFXUDdkY3Aza3lRR3FYcFdpd3ZsRHhYd3pieVBtTlNEZU9Q?=
 =?utf-8?B?YnlOMFpRWGlReVUxUGVJNnIxWFYvMDNoNWcwU2xFMTRVYkt6TjQwMnA1TFNx?=
 =?utf-8?B?d0kxVElSaTVwSGw1R1MwaGRrRDVCOEE5QS9URTV5ZnpFcTNSZU1sdW5HMnRU?=
 =?utf-8?B?dUhQMzU5TVNJRzVVcCtoVmsrUXB4WmpDbHhFaUIyTEVHUlJEZm5rbXRaVjVX?=
 =?utf-8?B?c3Q1VzB4eWJ1ZTJsSEtWdllDT0lhazlBMEFaRGkxcC9jTVpvaW5uVU1tYnZs?=
 =?utf-8?B?RE52cXBLdFdGVTMzdlJsSmJET3NtVU5OMHM4MUtNSUFrR24wVUdsZmcvOXJU?=
 =?utf-8?B?M0RBOWZWUHlaZEpYL01HellKSnJVdkdSNVM0SWUxK3A1Ymw5Mkgyelo5dlpZ?=
 =?utf-8?Q?e11aNrEcTbACYjhJQ3ISSC9oZwVOgI5VuX/IWai?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b7c010-8ff3-4df2-47cb-08d93ba2de2d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 08:41:34.9289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIvO9RvS6TrQKtavcwC+xgiEKOKkZVKML5ylrqgasD+b9Fhvbg1MJAJ7dZgOzvl/1y3fbYLs1vULivts546Gug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4257
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10030 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106300056
X-Proofpoint-ORIG-GUID: zXsF4bbty8FPtjltbkDzm11Fm5JCFPCy
X-Proofpoint-GUID: zXsF4bbty8FPtjltbkDzm11Fm5JCFPCy
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 6/29/21 6:35 PM, J. Bruce Fields wrote:
> On Mon, Jun 28, 2021 at 09:40:56PM -0700, dai.ngo@oracle.com wrote:
>> On 6/28/21 4:39 PM, dai.ngo@oracle.com wrote:
>>> On 6/28/21 1:23 PM, J. Bruce Fields wrote:
>>>> On Thu, Jun 03, 2021 at 02:14:38PM -0400, Dai Ngo wrote:
>>>>> @@ -6875,7 +6947,12 @@ nfsd4_lock(struct svc_rqst *rqstp,
>>>>> struct nfsd4_compound_state *cstate,
>>>>>        case -EAGAIN:        /* conflock holds conflicting lock */
>>>>>            status = nfserr_denied;
>>>>>            dprintk("NFSD: nfsd4_lock: conflicting lock found!\n");
>>>>> -        nfs4_set_lock_denied(conflock, &lock->lk_denied);
>>>>> +
>>>>> +        /* try again if conflict with courtesy client  */
>>>>> +        if (nfs4_set_lock_denied(conflock, &lock->lk_denied)
>>>>> == -EAGAIN && !retried) {
>>>>> +            retried = true;
>>>>> +            goto again;
>>>>> +        }
>>>> Ugh, apologies, this was my idea, but I just noticed it only
>>>> handles conflicts
>>> >from other NFSv4 clients.  The conflicting lock could just as
>>>> well come from
>>>> NLM or a local process.  So we need cooperation from the common
>>>> locks.c code.
>>>>
>>>> I'm not sure what to suggest....
>> One option is to use locks_copy_conflock/nfsd4_fl_get_owner to detect
>> the lock being copied belongs to a courtesy client and schedule the
>> laundromat to run to destroy the courtesy client. This option requires
>> callers of vfs_lock_file to provide the 'conflock' argument.
> I'm not sure I follow.  What's the advantage of doing it this way?

I'm not sure it's an advantage but I was trying to minimize changes to
the fs code. The only change we need is to add the conflock argument
to do_lock_file_wait to handle local lock conflicts.

If you don't think we're going to get objection with the new callback,
fl_expire_lock, then I will take that approach. We still need to add
the conflock argument to do_lock_file_wait in this case.

>
>> Regarding local lock conflick, do_lock_file_wait calls vfs_lock_file and
>> just block waiting for the lock to be released. Both of the options
>> above do not handle the case where the local lock happens before the
>> v4 client expires and becomes courtesy client. In this case we can not
>> let the v4 client becomes courtesy client.
> Oh, good point, yes, we don't want that waiter stuck waiting forever on
> this expired client....
>
>> We need to have a way to
>> detect that someone is blocked on a lock owned by the v4 client and
>> do not allow that client to become courtesy client.  One way to handle
>> this to mark the v4 lock as 'has_waiter', and then before allowing
>> the expired v4 client to become courtesy client we need to search
>> all the locks of this v4 client for any lock with 'has_waiter' flag
>> and disallow it. The part that I don't like about this approach is
>> having to search all locks of each lockowner of the v4 client for
>> lock with 'has_waiter'.  I need some suggestions here.
> I'm not seeing a way to do it without iterating over all the client's
> locks.

ok, i feel a bit better :-)

>
> I don't think you should need a new flag, though, shouldn't
> !list_empty(&lock->fl_blocked_requests) be enough?

Thanks Bruce, this is what I was looking for.

-Dai

>
> --b.
>
>> -Dai
>>
>>>> Maybe something like:
>>>>
>>>> @@ -1159,6 +1159,7 @@ static int posix_lock_inode(struct inode
>>>> *inode, struct file_lock *request,
>>>>           }
>>>>             percpu_down_read(&file_rwsem);
>>>> +retry:
>>>>           spin_lock(&ctx->flc_lock);
>>>>           /*
>>>>            * New lock request. Walk all POSIX locks and look for
>>>> conflicts. If
>>>> @@ -1169,6 +1170,11 @@ static int posix_lock_inode(struct inode
>>>> *inode, struct file_lock *request,
>>>>                   list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>>>>                           if (!posix_locks_conflict(request, fl))
>>>>                                   continue;
>>>> +                       if (fl->fl_lops->fl_expire_lock(fl, 1)) {
>>>> + spin_unlock(&ctx->flc_lock);
>>>> + fl->fl_lops->fl_expire_locks(fl, 0);
>>>> +                               goto retry;
>>>> +                       }
>>>>                           if (conflock)
>>>>                                   locks_copy_conflock(conflock, fl);
>>>>                           error = -EAGAIN;
>>>>
>>>>
>>>> where ->fl_expire_lock is a new lock callback with second
>>>> argument "check"
>>>> where:
>>>>
>>>>      check = 1 means: just check whether this lock could be freed
>>>>      check = 0 means: go ahead and free this lock if you can
>>> Thanks Bruce, I will look into this approach.
>>>
>>> -Dai
>>>
>>>> --b.
