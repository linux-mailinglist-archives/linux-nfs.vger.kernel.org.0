Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9439F3EDAE1
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Aug 2021 18:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhHPQ0o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Aug 2021 12:26:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41432 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229556AbhHPQ0n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Aug 2021 12:26:43 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GGBV8I016692;
        Mon, 16 Aug 2021 16:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=92Y0Wfkbaw6sktLvfry1bNYxGeyA/cOg0aq2vkBCooY=;
 b=LdpU7MaebGCwCSi7Zr6mXTKgzf1Dr3850QlHC6SXTB3PgewZ01qxdot01pogFle5TOZY
 w0c4mm4LRc/acLpBDFrEqocpQUsO7tMRnpSTiz40+Scqh33CMyE5Fh7UDUA12Fp2gPhb
 ibOaqdri7x+UIDIe2/IFYONGJ/ubV5eBP5qLvi7s4c9hHwEsU8nrxF8SNaZ4ImNArN3Q
 //9Ay0SBnkKaqhUVHTcHFfOfSKVQ9yHUt48jwq4TGwJATd93g4gNwb7/jq/2ruSAW+tH
 scbX8Y064/aDIF5hqRSgK/Y7KG65wVMtnprWaFTfgrPO0RzdDS4QW0Eqr5wMN9tjm03+ sA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=92Y0Wfkbaw6sktLvfry1bNYxGeyA/cOg0aq2vkBCooY=;
 b=kzmBiSi0qf1cqtpsedBvVkcVQHRNdDJxptn6SL4lSAF7ogaMcmPj0gQ2HjtYnG+NbHO7
 dLmrH79V/FPCfk/uq8qrk/7S4Sh0O9bfWbdlhNPxdNEn5o+rtDcRjq5CYbPJ1XL2j/k0
 lEdRZwIM6xGYbOdlwXB7wtVPGAfQ4FdPTeFfk/VISvvJsPmOBjO+LSqqM+hHpNCLOu18
 sRk6twRV72Wpn5BJe8JZht1ytEW+FvEbBZjvmlkPLkuVh+PieVvOgbq6JlerBZGzuKUH
 OFccmA04fAQekEOtvPEXztLxbtVyo1PY3img9NrAqQa0C3JK4A4mHH6hJepudbIeRRCY cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3af3kxteq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 16:25:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GGCj9p025548;
        Mon, 16 Aug 2021 16:25:54 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by aserp3020.oracle.com with ESMTP id 3ae5n5ygg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 16:25:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHqOdr7qNVUUZ6Hw7Ws+rjvCUVh1MjyEmej5f5r55gqJvO/FOzgu6Uzs0CSm7p0xdMa1hBFS01JfLxgljHaO1dZNjCb0PH20dSMgFQu9OivmDvevR8Aa55KBYVj/QML+qPC6B+DoqhPZ5YJzKxhOBQTM4lQeuHeQ0Gqm8mf/H4vY6qG4suTq2PwdSMtHuS5GJe+YutdxTLAf6f2LkClM7UP8xfg9gktY8u8LI01u7sEzN3bB2za9X04x+8EL+jM2JKZFbN+b/6fEe8n/DmSrLmaZZGwQNsM6IcSKC1FAgQUN28AU0E8is8tA1x2PJPPB/ejRYxPlS1+MiQjhPqkCLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92Y0Wfkbaw6sktLvfry1bNYxGeyA/cOg0aq2vkBCooY=;
 b=l7SuxOis349QlvMGT0s7soH2qXtcV8YoAFnHGqA/MlXDkvfVpd847yXwZ5OVI6nnbBlaS8HI4A2fWzs4Oijy9eF4mXJXPi5Z23wbDwYzch+6egxTeoOTyxKEvXWBOIJsKCZTGOJ9BK8nJKEJzajZ8xRT56ccC3d2q1ZAof2cyGpWeYAqMV5x2xnmsNqDteQG0x9iGfIzRhfJXrkvqCgyv7lEfMS9yfpB1pe1zlPVSoryCwXqXkAdSiVvZ+lHlgg03MxUL2XqDlsYRW7tn6VSVjrG49hceOoLBKYuQCwlgUNamOAXggX2rJ564oDvG64ocMxytWtY3uNI8bV9FNEiSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92Y0Wfkbaw6sktLvfry1bNYxGeyA/cOg0aq2vkBCooY=;
 b=acN5+n8TNGNWIQn39jfmH6mmN2Dc20lTAJDRQcZ3WN//M2Apnv96O31R1bEULoiBx/xPAw90tOveTFmkS/daFOQUlsBe2QgZBIkBpJyJd7MeLkp+w6sFoUmrfOeNJUe5IS/DGrW7GcC209bDfcmiUPVX8NejPFKSh8FXN2UjLi0=
Authentication-Results: thkukuk.de; dkim=none (message not signed)
 header.d=none;thkukuk.de; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3335.namprd10.prod.outlook.com (2603:10b6:a03:15d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Mon, 16 Aug
 2021 16:25:52 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::e4ce:bb43:6e72:1e10]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::e4ce:bb43:6e72:1e10%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 16:25:52 +0000
Subject: Re: [PATCH v2 1/1] Fix DoS vulnerability in libtirpc
From:   dai.ngo@oracle.com
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     libtirpc List <libtirpc-devel@lists.sourceforge.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        "kukuk@thkukuk.de" <kukuk@thkukuk.de>
References: <20210811000818.95985-1-dai.ngo@oracle.com>
 <FB734534-39C5-4C07-9E06-65E052D04BB0@oracle.com>
 <695d3e57-4227-04d6-4702-12ee381671df@oracle.com>
Message-ID: <d9ca9ef4-4f19-882a-2553-a1d7a1f19400@oracle.com>
Date:   Mon, 16 Aug 2021 09:25:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <695d3e57-4227-04d6-4702-12ee381671df@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PH0PR07CA0081.namprd07.prod.outlook.com
 (2603:10b6:510:f::26) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MacBook-Pro.local (72.219.112.78) by PH0PR07CA0081.namprd07.prod.outlook.com (2603:10b6:510:f::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Mon, 16 Aug 2021 16:25:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cde57f13-4ae3-4e9f-29cb-08d960d283fa
X-MS-TrafficTypeDiagnostic: BYAPR10MB3335:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3335D26813422465DAC844CD87FD9@BYAPR10MB3335.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1v08ES/t8hrM7gKO++Wa794xXybFk/SJLTRLyI72cPphU2lpoQs43/uEQDNmBfdZMLwaqCjAcGFJQrJpORg0PKzrnoilX7f3buZ8jo/K+VTw8Rx4xa5At375uxG3h+NrujxO7QhEGFXwsyR3syGcnwMtCzPpjAUQiPSVG9e76gfzcYBkN4oRSCNIO6zQmTAROl7pnhp/6OnhYcIEL3JJp2jvbSXs10CEQSCeLiuXu9tF5JGheaOBBSGnckqLt1fWsoLJrezIb6VvY//6CwH3jk4XghR/l7nTc9Osju3TwaF7ouwYoG8HlwEYdB52dbj9w1qblA2j3Dzimw7dRprezqvvz4B+c3PjC1y5wF4n8gvS2MKon8boszQmnxwUIbm5BnU8uU/6KEbyheytjLAUz6kROXI/DQAunCZUyhs/7w/yerFPYyk55xVRmziCjOCqnEyLAl+TOo3HZCw4956jU1cQrasbJG8YQeINWBz1CsyFr7SHT8gjlJkV02bVqJsd4lCQc2v6reFlJH86utye7whwCMjrAkAsQTl0hg8N5Ruy/CaAYAfS+P6HZSg0xrLNvLi5nTXaRMIOzoi9WqfGN+ofqr1f0HHvIrVudq6UWnmm91Zxtc4UOHIMV4TETrBTCfuT2b6bagvsUCLFwXIcNlggY6/oOTi7EBGRbbAV+LCeqdvCPcWiB3ia+8PkmF/i9ewH1cA4cFnwVGTkcteOXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(6862004)(316002)(6486002)(38100700002)(37006003)(36756003)(508600001)(53546011)(6506007)(4326008)(6512007)(9686003)(66946007)(66476007)(66556008)(54906003)(86362001)(31686004)(83380400001)(2616005)(8936002)(31696002)(8676002)(5660300002)(956004)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bStSclJqL3dZUlBOUmRjSWo2K3pDUTgvOHNoY3V6NFgzeVJJbnBpTDY4YmhU?=
 =?utf-8?B?RHlUcXZQdE5YbDJLMmV1eXNFbE9lQ0JodGNZcWozOWFrc1JaNlRNUVl5Rm01?=
 =?utf-8?B?clJiMzFQa25NcTZjM3JQRG1QQkwybEZQTzBFQkJDUUcvWXE3elBhSVRMbVNP?=
 =?utf-8?B?Q0llREdXd29lODQzYVNseHdqL1Zzc21VdURycnJDWncvWUc0VS9yeFl5Nm9E?=
 =?utf-8?B?MGwxaFdzdUI5Y1hHVS9NTm5ZckdQMVZscml3cFVLUXFmenJ3d1BHTUJ6Wk14?=
 =?utf-8?B?YzFaZ21RbjIrOHM4c21FRHFybW93ZjE2OVVJV28zajN5UDFvY0FLbi82d1Ni?=
 =?utf-8?B?SExSYzBna1daNkpKQ1FjaHNUaWd5ZTRENWJqZUVzaG9QOXdGUHFsYkhLZjlO?=
 =?utf-8?B?YitWWU5SeVZtV2lsanJIR1ZJbDZ3SjBQRm9TYWM1bXJtRHdtbkljUzErcGV2?=
 =?utf-8?B?bFRWS1h4TnBsYkh1c3AzKzRvLzJ3aEp0UlVrQnF0U0NLTkE0M20yWjlKMGc4?=
 =?utf-8?B?NGV0em9lRlNmczVEQjdMRVJ5bkU3YjhFaU5CL2E2N3R0QUQ5aHRoTzF4TUFH?=
 =?utf-8?B?MkFjZnNVVFpUamk4b0MvVERzS0p0bDB1ajl4K01pOERUVUlYYmlaekpGaG0v?=
 =?utf-8?B?QWNzT0tKQlRKeWwzS01LbUQvN3VabzdlYTg3TGRNRFFaYVVHMGFSZ0w4aFlr?=
 =?utf-8?B?Y2wvUnp6YUlIR0ZjR3YzQTE4REhyeWxSK2FsbTNTVVVFODJTU3kxK01lcTl5?=
 =?utf-8?B?MnpDZEI5RVJualRyM3pkbTMrbkhkbDZVU2ZvWEZuN0g3dml3anhvY0VoLzZx?=
 =?utf-8?B?T013c2orVGZJUnBpaUthL1p0dHBQQzJiejUzVEtHRnU0MHM5dFJPQ0FqMS95?=
 =?utf-8?B?UkQ1ckVFcm96TUgyVHMxbTU1c01XNnZMUVF6a1lYMXNYSUtCa3RONXYwekN6?=
 =?utf-8?B?ZVczWi9FQ0JudDAzN3FBZ0tJUy96d0dtQVp3V1h2d21wY1VZek4vRlcyRXlS?=
 =?utf-8?B?bml4MFlMRjZHZVN3b0l1TEIwR3JSVjlaTE92V0Z5UnNmQVVZTS90MWF2aG9H?=
 =?utf-8?B?am95ZGYrZ2JHa3RIL2IyZ29BVGxZUnk2TU9jQ1Rjd0ZVbjBFNjBYQUlBNStw?=
 =?utf-8?B?UEJDbTZORnFjczhKR3hELy9SUWk0SzE1QnpGT2dlUE9ld2I2SExDSjZnWTBS?=
 =?utf-8?B?bXlRQ004dnMzQlAwMnY3T3YzYzZLdTE2Z2s2V2N2NUpiOGhnYm1mTHVzbGNV?=
 =?utf-8?B?cmN4WDgwWklFZHVIUDJCa2VocUpXZ0crUWRvSFB5K3dPOHJLSW1kTE52SmZN?=
 =?utf-8?B?eEM4M1ZXMXM5OFk2NnFpcFFsc1FHWk9RNTY0NEJiWGZQN2pLR1d6UDYwZ2x2?=
 =?utf-8?B?c3FYRnpPYVFaZ0NjeXExTkFQZExrNlNWeCtOVzhoSHlpVEllbXhUUjdRUisx?=
 =?utf-8?B?clFiV3VaTHY4STBYWUhjcnBuVnJmcjBuVTVNUGRYNGtjR2Q4WS9zWE90ZWRG?=
 =?utf-8?B?bUdmZFoyWVZnWERnTnB2NzMwNUVyMTBSMk40aVFiQjlZVXVNSG9LYW9yNldj?=
 =?utf-8?B?eXc3dDhCQ3ljTFB5QmIzd01PSXl6S3N6ZEZsa0RWNWVFVW5ldkdYUitkLytx?=
 =?utf-8?B?bzlHNmhqUVBvZG1XamRqNmNWM2hlYW5IbkxvZzZFcGZuQkZRWHduSjVrQ3pp?=
 =?utf-8?B?Z05NMTFTZWtpREUyQ1kxbWIwZXl3RTI4bzVOdWR5WHR1ak9ueDZFV0d0Rngz?=
 =?utf-8?Q?GDuXpdTNv44gP7oUloUizGzvcQ8zvWQUmS34pRs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde57f13-4ae3-4e9f-29cb-08d960d283fa
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 16:25:52.5355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xaq1lFBdSYrb1+kjeQ+Y0U/yy9O+S6T6jqbGc3G+NrxJ4hW+na03OkQ7DViYSe/mBhwpD8Buxbjsy7w5FjlllA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3335
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160103
X-Proofpoint-GUID: yK4zk_mHdF_GpoO8abM8a2EXY4oCTFwv
X-Proofpoint-ORIG-GUID: yK4zk_mHdF_GpoO8abM8a2EXY4oCTFwv
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

On 8/11/21 2:16 PM, dai.ngo@oracle.com wrote:
>
> On 8/11/21 12:43 PM, Chuck Lever III wrote:
>>
>>> On Aug 10, 2021, at 8:08 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>
>>> Currently svc_run does not handle poll timeout and rendezvous_request
>>> does not handle EMFILE error returned from accept(2 as it used to.
>>> These two missing functionality were removed by commit b2c9430f46c4.
>>>
>>> The effect of not handling poll timeout allows idle TCP conections
>>> to remain ESTABLISHED indefinitely. When the number of connections
>>> reaches the limit of the open file descriptors (ulimit -n) then
>>> accept(2) fails with EMFILE. Since there is no handling of EMFILE
>>> error this causes svc_run() to get in a tight loop calling accept(2).
>>> This resulting in the RPC service of svc_run is being down, it's
>>> no longer able to service any requests.
>>>
>>> if [ $# -ne 3 ]; then
>>>         echo "$0: server dst_port conn_cnt"
>>>         exit
>>> fi
>>> server=$1
>>> dport=$2
>>> conn_cnt=$3
>>> echo "dport[$dport] server[$server] conn_cnt[$conn_cnt]"
>>>
>>> pcnt=0
>>> while [ $pcnt -lt $conn_cnt ]
>>> do
>>>         nc -v --recv-only $server $dport &
>>>         pcnt=`expr $pcnt + 1`
>>> done
>>>
>>> RPC service rpcbind, statd and mountd are effected by this
>>> problem.
>>>
>>> Fix by enhancing rendezvous_request to keep the number of
>>> SVCXPRT conections to 4/5 of the size of the file descriptor
>>> table. When this thresold is reached, it destroys the idle
>>> TCP connections or destroys the least active connection if
>>> no idle connnction was found.
>>>
>>> Fixes: 44bf15b8 rpcbind: don't use obsolete svc_fdset interface of 
>>> libtirpc
>>> Signed-off-by: dai.ngo@oracle.com
>> Thanks, Dai, this version makes me feel a lot better.
>>
>> I didn't look too closely at the new __svc_destroy_idle()
>> function. I know you based it on __svc_clean_idle(), but
>> I wonder if we have any regression tests in this area.
>
> Thank you Chuck for your review.
>
> So far I used the 'nc' tool to verify rpcbind, statd and mountd
> no longer have this problem. I also verified that NFSv3 and NFSv4.x
> mount also work while the tests were running. I don't know of any
> tests specifically designed for this but I will look around to see
> if we can use some NFS tests that would exercise these services.

I ran the rpc, ti-rpc and ts-rpc tests of the LTP testsuite with and
without the patch. The results are the same, there is no regression.

-Dai

>
> -Dai
>
>
>>
>>
>>> ---
>>> src/svc.c    | 17 +++++++++++++-
>>> src/svc_vc.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>>> 2 files changed, 77 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/src/svc.c b/src/svc.c
>>> index 6db164bbd76b..3a8709fe375c 100644
>>> --- a/src/svc.c
>>> +++ b/src/svc.c
>>> @@ -57,7 +57,7 @@
>>>
>>> #define max(a, b) (a > b ? a : b)
>>>
>>> -static SVCXPRT **__svc_xports;
>>> +SVCXPRT **__svc_xports;
>>> int __svc_maxrec;
>>>
>>> /*
>>> @@ -194,6 +194,21 @@ __xprt_do_unregister (xprt, dolock)
>>>      rwlock_unlock (&svc_fd_lock);
>>> }
>>>
>>> +int
>>> +svc_open_fds()
>>> +{
>>> +    int ix;
>>> +    int nfds = 0;
>>> +
>>> +    rwlock_rdlock (&svc_fd_lock);
>>> +    for (ix = 0; ix < svc_max_pollfd; ++ix) {
>>> +        if (svc_pollfd[ix].fd != -1)
>>> +            nfds++;
>>> +    }
>>> +    rwlock_unlock (&svc_fd_lock);
>>> +    return (nfds);
>>> +}
>>> +
>>> /*
>>>   * Add a service program to the callout list.
>>>   * The dispatch routine will be called when a rpc request for this
>>> diff --git a/src/svc_vc.c b/src/svc_vc.c
>>> index f1d9f001fcdc..3dc8a75787e1 100644
>>> --- a/src/svc_vc.c
>>> +++ b/src/svc_vc.c
>>> @@ -64,6 +64,8 @@
>>>
>>>
>>> extern rwlock_t svc_fd_lock;
>>> +extern SVCXPRT **__svc_xports;
>>> +extern int svc_open_fds();
>>>
>>> static SVCXPRT *makefd_xprt(int, u_int, u_int);
>>> static bool_t rendezvous_request(SVCXPRT *, struct rpc_msg *);
>>> @@ -82,6 +84,7 @@ static void svc_vc_ops(SVCXPRT *);
>>> static bool_t svc_vc_control(SVCXPRT *xprt, const u_int rq, void *in);
>>> static bool_t svc_vc_rendezvous_control (SVCXPRT *xprt, const u_int rq,
>>>                             void *in);
>>> +static int __svc_destroy_idle(int timeout);
>>>
>>> struct cf_rendezvous { /* kept in xprt->xp_p1 for rendezvouser */
>>>     u_int sendsize;
>>> @@ -313,13 +316,14 @@ done:
>>>     return (xprt);
>>> }
>>>
>>> +
>>> /*ARGSUSED*/
>>> static bool_t
>>> rendezvous_request(xprt, msg)
>>>     SVCXPRT *xprt;
>>>     struct rpc_msg *msg;
>>> {
>>> -    int sock, flags;
>>> +    int sock, flags, nfds, cnt;
>>>     struct cf_rendezvous *r;
>>>     struct cf_conn *cd;
>>>     struct sockaddr_storage addr;
>>> @@ -379,6 +383,16 @@ again:
>>>
>>>     gettimeofday(&cd->last_recv_time, NULL);
>>>
>>> +    nfds = svc_open_fds();
>>> +    if (nfds >= (_rpc_dtablesize() / 5) * 4) {
>>> +        /* destroy idle connections */
>>> +        cnt = __svc_destroy_idle(15);
>>> +        if (cnt == 0) {
>>> +            /* destroy least active */
>>> +            __svc_destroy_idle(0);
>>> +        }
>>> +    }
>>> +
>>>     return (FALSE); /* there is never an rpc msg to be processed */
>>> }
>>>
>>> @@ -820,3 +834,49 @@ __svc_clean_idle(fd_set *fds, int timeout, 
>>> bool_t cleanblock)
>>> {
>>>     return FALSE;
>>> }
>>> +
>>> +static int
>>> +__svc_destroy_idle(int timeout)
>>> +{
>>> +    int i, ncleaned = 0;
>>> +    SVCXPRT *xprt, *least_active;
>>> +    struct timeval tv, tdiff, tmax;
>>> +    struct cf_conn *cd;
>>> +
>>> +    gettimeofday(&tv, NULL);
>>> +    tmax.tv_sec = tmax.tv_usec = 0;
>>> +    least_active = NULL;
>>> +    rwlock_wrlock(&svc_fd_lock);
>>> +
>>> +    for (i = 0; i <= svc_max_pollfd; i++) {
>>> +        if (svc_pollfd[i].fd == -1)
>>> +            continue;
>>> +        xprt = __svc_xports[i];
>>> +        if (xprt == NULL || xprt->xp_ops == NULL ||
>>> +            xprt->xp_ops->xp_recv != svc_vc_recv)
>>> +            continue;
>>> +        cd = (struct cf_conn *)xprt->xp_p1;
>>> +        if (!cd->nonblock)
>>> +            continue;
>>> +        if (timeout == 0) {
>>> +            timersub(&tv, &cd->last_recv_time, &tdiff);
>>> +            if (timercmp(&tdiff, &tmax, >)) {
>>> +                tmax = tdiff;
>>> +                least_active = xprt;
>>> +            }
>>> +            continue;
>>> +        }
>>> +        if (tv.tv_sec - cd->last_recv_time.tv_sec > timeout) {
>>> +            __xprt_unregister_unlocked(xprt);
>>> +            __svc_vc_dodestroy(xprt);
>>> +            ncleaned++;
>>> +        }
>>> +    }
>>> +    if (timeout == 0 && least_active != NULL) {
>>> +        __xprt_unregister_unlocked(least_active);
>>> +        __svc_vc_dodestroy(least_active);
>>> +        ncleaned++;
>>> +    }
>>> +    rwlock_unlock(&svc_fd_lock);
>>> +    return (ncleaned);
>>> +}
>>> -- 
>>> 2.26.2
>>>
>> -- 
>> Chuck Lever
>>
>>
>>
