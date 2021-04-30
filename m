Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E656937010A
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Apr 2021 21:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhD3TLF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Apr 2021 15:11:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36340 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhD3TLD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Apr 2021 15:11:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13UJ9nPF128338;
        Fri, 30 Apr 2021 19:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BZqNEXshx6AlCXXoDvS2B/9N40SVsyK9xh+C2+6OiVA=;
 b=on9Z0aHvGcMP2bWrXEFTl6jTL6API0k8gj4cKwxR55BvfHRY1eRXpn+gz6sbjrux3WRp
 bQcpjkOU1uGE3VcDDSUI8q2R04TpFPkiUUd2WpmAskPsFVPQR9pA6jtWhEVdvarOaK3H
 vylb9fXEgO4zH1h0pOReXRWwn4WINllBZeaw/3sNoZ5Vb/YLfbT7VRTLqMkzJtQGU0iT
 hhVwNin/jiXJw6GFS7TGVSeusSLHqCrSTNEvnEkjQwObdyg+R1i+bdgSFwV4EgGEG1E0
 FoIo1BEpzuBBrb1q3ipIG7HgM12kox/13JQ0iG+vhTOv50RDpGTKiDxN8Lhw0OrG0lWU mw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 385ahc0nwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 19:10:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13UJ4qLN023654;
        Fri, 30 Apr 2021 19:10:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by userp3020.oracle.com with ESMTP id 384w3y51c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 19:10:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPPhpTL24rD0kzs284PjcRrJZcPuk1k0Mxuqg+/CN9KYHX2Hoy2rtTBiomtHBUpFXb4vnBMpbTwkhw4PNzl47hqNB6t+VpovTKRdiMnFwViFHxyd6f+8F060rcwxNkmSxkKNJtC+NjRjQ5vbtbMd8UD5UesTbYA2uCn5DPrKBR8QFRFHQeLbOsW0iq9vhJ7hh0nktWxwDXWGZ3LbmUlEsKfhwfRoKq9ppX5eABSxV6fCqcau2ykShOkSLBx45V8MU2KIp+Gaf9GI+QXo2Eti5Q0n/DhshS2pM5uswd6SpcoNs7fRO/4gbFaYl/rGoJ1nKJjtV6oGbZ9WnQQYCfr3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZqNEXshx6AlCXXoDvS2B/9N40SVsyK9xh+C2+6OiVA=;
 b=GPueSZX1f+/aEwNZrDAXG8GcqkHf1Ggf3WDRiW7WjZHx9lBfoj2nw1EBq7ietcLXS+Y8X2CWpmRd1q8v6dh+ISagYNEzyH55jKgEKLQIuROjhhaf+PKhyF22FSZcpoN2FJXHR40DO3gX8DB3Q3nCQvaPCna8Qkj4bIdzQ1MT16zQgnLyAs58ey3DnMiaRYXc6mR/2MIf6Lkie8r9aGy8gWOkvjsQs1YS/hs30p24Wi1ezD+a3PgjmnWnK7SWLsKVnrrkeale45tSZWlxw3LPG0T5TPDwzmlM0opu4fDc23IGONGXv1iXH7SgRxAzMM2ODzpDPLRf0GI//dLNEqOQSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZqNEXshx6AlCXXoDvS2B/9N40SVsyK9xh+C2+6OiVA=;
 b=bbe+YTjfe35884blYQCdDfSIk+NXjEQzMgTGXpf5RvgF4JeEGl0TlSbJRWvvHQxeiMwnH+C2iVcekSaTrG47vB0lGtfFgLOCDWVeqOpsNRvqFr51fkpOTBisDjN4bq5Mn+t1JD07E/aXuLwirGQn3ice/TGIlOjEkhZ32YlELVE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB5485.namprd10.prod.outlook.com (2603:10b6:a03:3ab::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 30 Apr
 2021 19:10:09 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879%4]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 19:10:09 +0000
Subject: Re: [PATCH 1/1] NFSv4: can_open_cached needs to be called with
 so_lock
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <20210430050900.106851-1-dai.ngo@oracle.com>
 <8fadf7c12b188eacf5c2bb577a2fbf938e51ebaa.camel@hammerspace.com>
 <6ecdca6f-85a8-87d5-a5ce-069b98533a10@oracle.com>
 <87e0aec1dcc3fb03474734db5699b4d7dba9944f.camel@hammerspace.com>
From:   dai.ngo@oracle.com
Message-ID: <cef5fd3c-ab94-76e3-321e-4d441fa549c9@oracle.com>
Date:   Fri, 30 Apr 2021 12:10:06 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <87e0aec1dcc3fb03474734db5699b4d7dba9944f.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SJ0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::33) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Macbooks-MacBook-Pro.local (72.219.112.78) by SJ0PR03CA0388.namprd03.prod.outlook.com (2603:10b6:a03:3a1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 19:10:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9383a7aa-7bc8-4d61-13a5-08d90c0b928d
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5485:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB54854E8D209C702BD6586FE7875E9@SJ0PR10MB5485.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Bg5bU00F94yytX/tRAjKKuvBX0K6sn9EvlEA6QNfgUTeQnJV96GwPrOrny3cyDUK2AFmBY1S2xqQq+bq6FHHU82eAfxuxdRGSSqsoHZcNqEI3ek8UUwD/KzT44BBlfZQDQyDz4l38qFoDZtTVwtU8Mf4S0MzdGJUw/WG2FjGlManNbxIUTZ3l7t59qk+c3DHPj08M1fWenU3N/VzpptH9nwz8a9mzczK3kVESeCVxMa/nB32mKJKmKMK7n0DcylHD6Dtn/c+l0sV5yMEQF+eD+ZmX6W55V5le0K+wygKVuioVw73Ccr7QwyOnOCQuGHaBR4tIFMC9N9HjMyLIjcpeMmFEy21rzh58Zuu0kGIFYK/qyHg09R4Djakdza8NaG19h0PE7ETG5y4Q/minPCKSXfJCvS56COSD5WEL+YW4cpeimooUs7jirplAyk35oiJVJMHCLgq/nwUUuJ2DDs5XCuw+04nvXCRGTY3ueB/lSIBbVqimL2DTuVZV0jejYlPzbWRqbdQJGrIsYAtZPr+vAX3I3EFFGUG96kIizIxWMx4JvdgWcaisiyt3hnaoiYrAFPW7G54Dk+yOuZy9NW/YR4BQkq16doKuxBb6BPJQK3aSlWCpVj+Zi7tu6+t1WBQoX1z6Kg79wsQX+mWyUDYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(39860400002)(376002)(366004)(86362001)(8676002)(66946007)(83380400001)(6506007)(26005)(4326008)(38100700002)(31696002)(6916009)(5660300002)(31686004)(8936002)(2616005)(956004)(66476007)(66556008)(36756003)(16526019)(6666004)(2906002)(316002)(478600001)(6512007)(6486002)(9686003)(53546011)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K1UwcnU2ZmE5QVVqNUNnNGtiQnZ5RDVhVTNmRCtoSXRxOURPUDZlR2RuMzdU?=
 =?utf-8?B?dlQ3WVdWNmVhZHNJcVlLMkFvVGpXZUNsSHA5aWgzbXh3cytlTXVrSUM1bDNX?=
 =?utf-8?B?R2VlMlIraDlRNjZIcllLTS9YeW5CRTJWRWoway9uZHpqS1Nrd3NuU3ZnY0Iw?=
 =?utf-8?B?YU1CZDczTHIrTGszb2VxVFE0ZE5kWDV0WGlrQ2xvY0RFT1kvMlJMS1RTNlBi?=
 =?utf-8?B?VXJWNk0yeUlZQitzaDh6R2VMTEV2WkcxdGVyNk9LNXRmbmRraCtBZm9yeXhJ?=
 =?utf-8?B?Mm16bmh4OW1IT1lmQzJKR2JBdGdTYTJiMk5SR2VSOXFGc0tQWmdLcEN1WG8y?=
 =?utf-8?B?d0hmTnp3N2RyM2pIUk1oU053SDVNcTZwWlZQemNvalBybTNHS0dKK1o5NHIx?=
 =?utf-8?B?emMxMmkrWG8vOFF6NTBBRlZBc1k1M0hNMVgzL2k2eDNlUTJHZW9nT0dXSCtr?=
 =?utf-8?B?OHRrUGZGRHBHN0NkeDBHa0FjemZ4YjRCcU0xQm5XTngwY05wWCtDb2NYRmhG?=
 =?utf-8?B?emVQYWszWGl3Q2dtOGt4d1ZGTEJRZXg5WUJVYTVhTXQwSUdzL3hNZm9tM2tN?=
 =?utf-8?B?elcxdTdkZlNEUnJJUjdVZ3FwVDJ4aFVmbHlteE9yYnEzWXkwZy9jOTh3VGM0?=
 =?utf-8?B?M3AxOUVxOGYwYTJscTFZY2g5ZU9KWDlBektLNXh5UllpaTJuNzNpSHE4aUlr?=
 =?utf-8?B?ZE9XV3ZHbnJ4alU1SVRtd29haWFVUERXYlo5NkJLbThVM0NGY05nanhCOUUr?=
 =?utf-8?B?V09vVzhyMC9abS9rNlFrTnRyaXNyOCs0R2tTTEUwUXhkMHoveXVyRVBvMklC?=
 =?utf-8?B?Ris0YkhNR2pPT0doV25wanZ4K3lDK1BJb3FWaHlSOFR1ak9XNUtRbmVLeG5P?=
 =?utf-8?B?ZWd2N0xFR1hrVG9KTEpBK2VhMkNyWXFvbyszME1YaFc5QnFDSjcwVHY1UWhN?=
 =?utf-8?B?LzA3MloxNkJlYXFUSks3K1lRR0hHTW9Na3BKd0dYVVFkN0djZjdDVXlxUE5y?=
 =?utf-8?B?ZGlZR1JHZ3BMOUdPb1dnaGZCN1ZpN2g3ODFWa1JGc3dNUndUeVZVV1graThX?=
 =?utf-8?B?T2ROV3l2UVFIWnRpL2ZDL3pVVkdhKzAvL1FiWTFkT2FqNi95QUhYNlNwaFJi?=
 =?utf-8?B?RnBXM1FLU3VmWVUySnNER0h5ZnFHdUpOSU00QndGTENLRTU0TnZTRlh0SFRL?=
 =?utf-8?B?N0dmMjRZOVY5eVB5Y3VCZE9VSm93TkVIdXBOemFuSUppYWJteG94YlIybXBt?=
 =?utf-8?B?WlhPM3Z6WXZvVG1jczl3dVkzRXF2ZmF0RjRidkJud3Rudzk1clJPUVNRV2ZB?=
 =?utf-8?B?ZjZ3V3Q1Vy9TM0sxdFRORUNPR1BQT3dPKzlJSGxzT2RiVGhNaHdjeUc1N0dG?=
 =?utf-8?B?WFo1MllGSGY3bFJweVRQeDcvY0ZNNEQ3UmlhZlJqdVFUSitsYnBPNk5NeG1E?=
 =?utf-8?B?ZXdIZExGOVhBWC9XaDZkMExrZzFTdFQwL2Z2UUZKVTdWbnIxWFdXUnFiRWNP?=
 =?utf-8?B?UmlQTWlsbzVhckdxUTJGV2hyNFA1VHFvN3pEZmE2ZmRadFhTUDVDZkdERUtW?=
 =?utf-8?B?MmgzOHNHWjdNM3F3T2JvUW1rS3UvaFFYdDBkWXNqTXdRdlFpam5mZ3B2amtU?=
 =?utf-8?B?MWhDc20zVkR4bHFyWTlkOTdKWVJlQTN3emNGVWo1eFQxUVBUM1k4aXZISko2?=
 =?utf-8?B?MnZWSTYycmNNdDczQ1g5NlhSMU9BTUg4MERXVU0zV0IwZ3NDNjJVOEQxSXEz?=
 =?utf-8?Q?Dnj9LFbYFMBlqygxJHTEZqqwNt8hCv3AM4v3ypJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9383a7aa-7bc8-4d61-13a5-08d90c0b928d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 19:10:09.4390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJk7dVyHuEdrOdAFmTzG8kNqon/nu01ejhpzmqiNFQISV/nBczLO0KdpJbTM90SjvKYED1u+c6PGvaXAAjbNRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5485
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9970 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104300130
X-Proofpoint-GUID: fUU7SjOZrtfdiEVZmlkcmHZdaX3wBdHj
X-Proofpoint-ORIG-GUID: fUU7SjOZrtfdiEVZmlkcmHZdaX3wBdHj
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9970 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104300131
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/30/21 10:56 AM, Trond Myklebust wrote:
> On Fri, 2021-04-30 at 10:24 -0700, dai.ngo@oracle.com wrote:
>> Hi Trond,
>>
>> I have a question below:
>>
>> On 4/30/21 5:42 AM, Trond Myklebust wrote:
>>> On Fri, 2021-04-30 at 01:09 -0400, Dai Ngo wrote:
>>>> Currently can_open_cached accesses the openstate's flags without
>>>> the
>>>> so_lock and also does not update the flags of the cached state.
>>>> This
>>>> results in the openstate's flags be out of sync which can cause
>>>> the
>>>> file to be closed prematurely.
>>>>
>>>> This patch adds the missing so_lock around the call to
>>>> can_open_cached
>>>> and also updates the openstate's flags if the cached openstate is
>>>> used.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    fs/nfs/nfs4proc.c | 8 +++++++-
>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>>> index c65c4b41e2c1..2464e77c51f9 100644
>>>> --- a/fs/nfs/nfs4proc.c
>>>> +++ b/fs/nfs/nfs4proc.c
>>>> @@ -2410,9 +2410,15 @@ static void nfs4_open_prepare(struct
>>>> rpc_task
>>>> *task, void *calldata)
>>>>           if (data->state != NULL) {
>>>>                   struct nfs_delegation *delegation;
>>>>    
>>>> +               spin_lock(&data->state->owner->so_lock);
>>>>                   if (can_open_cached(data->state, data-
>>>>> o_arg.fmode,
>>>> -                                       data->o_arg.open_flags,
>>>> claim))
>>>> +                               data->o_arg.open_flags, claim)) {
>>>> +                       update_open_stateflags(data->state, data-
>>>>> o_arg.fmode);
>>>> +                       spin_unlock(&data->state->owner-
>>>>> so_lock);
>>>>                           goto out_no_action;
>>>> +               }
>>>> +               spin_unlock(&data->state->owner->so_lock);
>>>> +
>>>>                   rcu_read_lock();
>>>>                   delegation = nfs4_get_valid_delegation(data-
>>>>> state-
>>>>> inode);
>>>>                   if (can_open_delegated(delegation, data-
>>>>> o_arg.fmode,
>>>> claim))
>>> This is going to introduce stateid leaks. The actual update of the
>>> open
>>> state flags happens in nfs4_try_open_cached(), which is called from
>>> nfs4_opendata_to_nfs4_state().
>>>
>>> While we could put spinlocks around the call to can_open_cached()
>>> here,
>>> there is little point in doing so, since this is just a read-only
>>> advisory check. The real check is performed, as I said, in
>>> nfs4_try_open_cached().
>> If we wait to update the flags in _nfs4_opendata_to_nfs4_state after
>> the
>> RPC thread decides to use the cached state, the file could be closed
>> by
>> another thread before _nfs4_opendata_to_nfs4_state is called by
>> another
>> thread. The client in this case will retry the open from nfs4_do_open
>> and
>> everything is ok.
>>
>> However, if we update the flags nfs4_open_prepare then it will
>> prevent
>> the file from being closed and this saves one CLOSE and one OPEN rpc
>> request to the server.  Is this correct and is it worth it to
>> consider
>> doing anything since this is a rare scenario?
> If you're in a scenario where several processes are accessing the same
> file on the same NFS client, you probably want to see the server hand
> out a delegation for that file rather than keep relying on OPEN/CLOSE.
> That's actually why we started using nfs4_try_open_cached(). The
> intention was that it mainly manages the delegated open case. We then
> added support for the non-delegated case mainly because the Linux
> server doesn't support write delegations and because there were corner
> cases where files were being opened/closed by multiple processes
> without a delegation.
>
> So what I'm saying is that ideally we really want to concentrate on
> fixing the Linux server to support write delegations so that we can
> relegate most of this code to handling corner cases.
>
> Make sense?

Yes, I agreed. It's not worth the effort to look and fix corner cases
on the client side that rarely happen. Support for write delegations
provides much more benefits and it's worth to spend the effort on.

Thanks,
-Dai

