Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294893577F7
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Apr 2021 00:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhDGWuq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Apr 2021 18:50:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54626 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhDGWuq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Apr 2021 18:50:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 137MiCoI077442;
        Wed, 7 Apr 2021 22:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=O+tICQef+tLPtoAudhY1hrSieskswq3u8gHbKKU9RJg=;
 b=GIMn8vI9mRvYlxpVGzFq2wxV7oDPL+Jv0NLxU4I0QDw8jIerJhuJ9fZd87Zm/vGXn8C8
 CKdmfzSXXSRX9AZ6tvGnEAdWy+qPYqctz0/deTpJn56GzM6098drPQLt3WJXXXOuT1X5
 sHck2G22/pLAL5l+7k1cWvqOFGt5J/5jnCbffD34awCAXK1QNozCd6XuaFs9wwnUqiZ9
 ZV/nDQqVZchkxg7sDYrIdTiZuAe8Ys2cInUKZ525FBxOX25puQ2dV1MG9k3mJF1PMB2a
 9Vc5v+CizI1iUHnRft00fL3TXXvEOnbK3hTi1ehfLUjxMR7/S2q10FNdIuXdl6sbuqZT 9g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37rvagc54j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 22:50:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 137Mj7KP012441;
        Wed, 7 Apr 2021 22:50:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by userp3020.oracle.com with ESMTP id 37rvb0ff1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 22:50:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=as/5iBQvFdhPU2r3ERDWxuT/GyitXoCgpid5ZCheh4HR0cJv8nVvjBnljd1S2VnSzBCjFpRTEtzHxONgGHbhgg95Dnf8qSQLWcPyRuZqw5ZavC53ocmCDh3J9b/PHtvbDN4RD71vzkJQFza6xVMlfuxbfLRwHVmDOqX4URwiaiDsD7J10+mN/aCf+j+GBbdO9oNt8AX/2SMGc4HMbC9PyPZOhwEhVIPH/yyX0jdCCmfncmPitSU8Li20soQ0/j7atjtlMyb0V4zOHmBOrz7vZ6epPnTTABeG81n8YY5aJiQUQUD0KBbjuPYstDnpbKUgG2zAIN6Xq7gBYZ9Grtfh8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+tICQef+tLPtoAudhY1hrSieskswq3u8gHbKKU9RJg=;
 b=nPUaPhkJFfgpyGPDOFH7vs4jmRU/f1R6d6iD8xKSfVaVFhXWqjZr5mn84wVKBtcZ+pnZfloHYD881HiGAGPSy4WrriWm98x2OBoKRy7gzagyYMw98szSbVL1VoVKEgsTdQtR6MfcA2vE2Dm/TU01gol97xoZ4EQuHZ1wWEioWLkvd1zAVP5cXxW2myXAg//qJXcQp+Wwqu4L0+biPDjG3qWzIOXU7a3PGv6hy8d5dqmkmBwqD+VjCfzlIUOqqUXYIgg3Aa+F7vOyD3fNYRzU3oy7w+Npov8sVJkzdU+hfn8ymkmdkOZVj0e0D98+qFI4KSf1jpGQ5vn1re3Ujw3BqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+tICQef+tLPtoAudhY1hrSieskswq3u8gHbKKU9RJg=;
 b=UDFAn776G0NotOKbRfs1JkpllbHbzZZDqK/J9lob4X+0MQ/naj2Ut83wzXS/hiRfmJHOVlBrwOnavqR88bEIVhOcPpjZRons2xs/Qb7n9nt0QoOfIV/cdikxUSc2NY621xDt+PYVMUboPULqf2mccav0LfNzvukt2Ox5OGk6PJ0=
Authentication-Results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB2917.namprd10.prod.outlook.com (2603:10b6:a03:87::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 22:50:23 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879%4]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 22:50:23 +0000
Subject: Re: [PATCH v2 0/2] enhance NFSv4.2 SSC to delay unmount source's
 export.
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>
References: <20210402233031.36731-1-dai.ngo@oracle.com>
 <D85FBDD3-5397-4D47-932D-159AFE2A5E0F@oracle.com>
 <CAN-5tyHVOEr7zZM92PVS0GYJQ2M6rSs6_zqZwuioumQQm7zzUQ@mail.gmail.com>
 <7BED2160-1052-49EE-BB62-6ACF6F84C91C@oracle.com>
 <CAN-5tyEKqNHmwiMfCpkZrCVYeaO-FH69v5L4Tk_8EsoTfytpVA@mail.gmail.com>
 <01CD778D-57A0-442A-8D1D-5084F0FC2497@oracle.com>
 <CAN-5tyFEXBiWVbCq0Hgh01W=OVZkdYYAEujSug6biBaU=Ny8Og@mail.gmail.com>
 <99a1f327-ce69-e6eb-39fc-77991bec5b4c@oracle.com>
 <c16b4437-a554-be60-3c04-fd578b9f88ff@oracle.com>
 <CAN-5tyGS0ZO4PtTseLSmC4=fYQCUwMs6FB509g2PSCg1v+jySg@mail.gmail.com>
 <0b0c7c79-d593-c4ae-db9b-46600f2cea28@oracle.com>
 <CAN-5tyGw8_xOfMM4PNUCvo_wKEHs5NgLo3ZQf-sTGb6FHJ_r8Q@mail.gmail.com>
 <3b6e1b4f-4276-e503-9432-e15a339cac9f@oracle.com>
 <CAN-5tyG7HPQxAK-o-q8=_-wtewBcymian2AQV__p=HgL+jJPcQ@mail.gmail.com>
From:   dai.ngo@oracle.com
Message-ID: <d9a26bed-6e29-a0ea-b6a0-2fd30c240a9b@oracle.com>
Date:   Wed, 7 Apr 2021 15:50:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <CAN-5tyG7HPQxAK-o-q8=_-wtewBcymian2AQV__p=HgL+jJPcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SJ0PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::8) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Macbooks-MacBook-Pro.local (72.219.112.78) by SJ0PR03CA0183.namprd03.prod.outlook.com (2603:10b6:a03:2ef::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Wed, 7 Apr 2021 22:50:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64719175-6e31-45be-4c81-08d8fa17874a
X-MS-TrafficTypeDiagnostic: BYAPR10MB2917:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB29179CCD6700A7B89BA52AF787759@BYAPR10MB2917.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1+BQIjfMy7E+2jedVzbMrRBCGyi8gZ+vGlHn7BGnbCMiswp3WGQQff5zMXZvknYVFb//vvIGuOFDekZgqneAScGyG7ShwCyreysG5fyb9RBxnVycv9MbVZIDEhCLwHNiMv/eutADRucHG7jFIikYJfSofhj375kQldgxBjy/Tx1aSTd+ypmNNTCB9XZH+L1NiRZ3wUXYLZE5uflyxmA/PjIYqhl5ZN1G1aE6waB4AayHn8vf/sxmr829DQNchMG1LYlmKmbRxsuw65YmAfrCS8XrF3c3fCmUBe6X9PexNU2p/xRBDX/7zYDcI3jXPLLWqmIJRocasK+1kKOW97mE9cIzcIwYKZPwjqntSeGiEr7ZR/tsVLAfq3IgwPd2GbJsfFWtiJe0md+5t5+jJfK6jqGPhwUrveQ2jMzlEctCs1BHXUsMwCr4HDx8JcIiGnr+ADHn0qOWwzcaWkPljGTVKUlHjZXiMevsESnJGBNZwOsPiDFJQtZlk25hiIBNg62E806BSsTH0lXtdNTSNOthvtPsZY1ZrBNUrmu3gVrA1XXKrzoSE10scsgaW4QegZZT7oVEwbVLspsw3hoR2t77WkbHkZgBJiYRnB/0MtuZlz6sxJi7RWaFKVNOc1y30QtdQ5rxafvAK1XQcrYraGF1oTJ5zXIvaov9GaQbn9iA0rMBlwlEl+swVFik8QC+B31JIuyvsH+cO7uthLd26VqCd8T6gZ1qBTjp062SAx6KvnsVmLy/BcxwhikNviXOcAPYdAHRc+P/FI/cObyfkbrqaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(346002)(39860400002)(396003)(316002)(38100700001)(54906003)(83380400001)(478600001)(31696002)(66946007)(6506007)(86362001)(53546011)(6512007)(8936002)(5660300002)(8676002)(4326008)(31686004)(2616005)(36756003)(956004)(9686003)(186003)(966005)(66556008)(26005)(16526019)(2906002)(66476007)(6486002)(6916009)(30864003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: D7yD9pnnsagUmNXOSyNcnI5FOZpdQwpIuP28u8P/X4GYIVQQNS+lqRnyUMxfNRI41NXMCRjG7vsMTjzPAmd9ei5lQjwQ/tTDbYFPIv2jpvRYc1i862+EAn+lwZHo3hlduBOuBBJxGEoEVz9NwpjqsMHyQN+MkOhyLbf8e6HZazri5DnpREKRULX6lS+W939cBWuSsMtYf7UgBjQHyFpdd5/G+boEtyInhPQQ2Y+I6mKOhhNo+iN9/cie6jtwOhBExWfV9ZUEYHSjusQEORZD+h6IoqIuDX0M3q629unqLkr3va8cMknpJ4Xx3qDSAh/nWRJ0z/n63NVe82+PcQAg7LxwJ8J96XlYjQRQpv3nNUNm/LvMicl3EOOEkZw01+wPxlW3uWHW6zRFn8ZhI8OVHg9tQM7pjVfzPK3glqb2ayQ9TuaTM7g0l5mEs1LCp2syeq/8zjq+wIWSC4IYA5mesMs65F5Wok1BhChtnQ1A3GWlzPZQUST3gVYTetgU/bRaPNpwNvR7xTpIO7NfJsfy5h9WIOyovzMuCCoGRlJO1VgasOH0UfzPV34xGucmDcTGMmp4c2CmaM6MiWw5TgqkoPt/bCLe3lCatKL3qi2bxRO3Sk3RHrHjG0c/dbsKckQvZvKKpu+Cmr09jTXELcPsfWXNUXWtz53zMxYgHe0krOoFq75wWv3FQuC1kKSbQYN4G6/knqtLaL9wOTnYyDE1gJEJnLEXVPLZUvYd5quxb8Df79+FVupHDiadZELEQcyG
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64719175-6e31-45be-4c81-08d8fa17874a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 22:50:23.5413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgR/i18gVuGPCIj0Oy6zH6ePTzEZQF37SWYUZMffNjJutCm6rnq01EO45uGNKKZsLbGjkUxBWHWKiNt23Lur5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2917
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104070161
X-Proofpoint-GUID: 1PPqG8QSMaD1cVtXJ_TV73grBdwLCZTd
X-Proofpoint-ORIG-GUID: 1PPqG8QSMaD1cVtXJ_TV73grBdwLCZTd
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104070161
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/7/21 2:40 PM, Olga Kornievskaia wrote:
> On Wed, Apr 7, 2021 at 4:16 PM <dai.ngo@oracle.com> wrote:
>>
>> On 4/7/21 12:01 PM, Olga Kornievskaia wrote:
>>> On Wed, Apr 7, 2021 at 1:13 PM <dai.ngo@oracle.com> wrote:
>>>> On 4/7/21 9:30 AM, Olga Kornievskaia wrote:
>>>>> On Tue, Apr 6, 2021 at 9:23 PM <dai.ngo@oracle.com> wrote:
>>>>>> On 4/6/21 6:12 PM, dai.ngo@oracle.com wrote:
>>>>>>> On 4/6/21 1:43 PM, Olga Kornievskaia wrote:
>>>>>>>> On Tue, Apr 6, 2021 at 3:58 PM Chuck Lever III
>>>>>>>> <chuck.lever@oracle.com> wrote:
>>>>>>>>>> On Apr 6, 2021, at 3:57 PM, Olga Kornievskaia
>>>>>>>>>> <olga.kornievskaia@gmail.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On Tue, Apr 6, 2021 at 3:43 PM Chuck Lever III
>>>>>>>>>> <chuck.lever@oracle.com> wrote:
>>>>>>>>>>>> On Apr 6, 2021, at 3:41 PM, Olga Kornievskaia
>>>>>>>>>>>> <olga.kornievskaia@gmail.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On Tue, Apr 6, 2021 at 12:33 PM Chuck Lever III
>>>>>>>>>>>> <chuck.lever@oracle.com> wrote:
>>>>>>>>>>>>>> On Apr 2, 2021, at 7:30 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Currently the source's export is mounted and unmounted on every
>>>>>>>>>>>>>> inter-server copy operation. This causes unnecessary overhead
>>>>>>>>>>>>>> for each copy.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> This patch series is an enhancement to allow the export to remain
>>>>>>>>>>>>>> mounted for a configurable period (default to 15 minutes). If the
>>>>>>>>>>>>>> export is not being used for the configured time it will be
>>>>>>>>>>>>>> unmounted
>>>>>>>>>>>>>> by a delayed task. If it's used again then its expiration time is
>>>>>>>>>>>>>> extended for another period.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Since mount and unmount are no longer done on each copy request,
>>>>>>>>>>>>>> this overhead is no longer used to decide whether the copy should
>>>>>>>>>>>>>> be done with inter-server copy or generic copy. The threshold used
>>>>>>>>>>>>>> to determine sync or async copy is now used for this decision.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -Dai
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> v2: fix compiler warning of missing prototype.
>>>>>>>>>>>>> Hi Olga-
>>>>>>>>>>>>>
>>>>>>>>>>>>> I'm getting ready to shrink-wrap the initial NFSD v5.13 pull
>>>>>>>>>>>>> request.
>>>>>>>>>>>>> Have you had a chance to review Dai's patches?
>>>>>>>>>>>> Hi Chuck,
>>>>>>>>>>>>
>>>>>>>>>>>> I apologize I haven't had the chance to review/test it yet. Can I
>>>>>>>>>>>> have
>>>>>>>>>>>> until tomorrow evening to do so?
>>>>>>>>>>> Next couple of days will be fine. Thanks!
>>>>>>>>>>>
>>>>>>>>>> I also assumed there would be a v2 given that kbot complained about
>>>>>>>>>> the NFSD patch.
>>>>>>>>> This is the v2 (see Subject: )
>>>>>>>> Sigh. Thank you. I somehow missed v2 patches themselves and only saw
>>>>>>>> the originals. Again I'll test/review the v2 by the end of the day
>>>>>>>> tomorrow!
>>>>>>>>
>>>>>>>> Actually a question for Dai: have you done performance tests with your
>>>>>>>> patches and can show that small copies still perform? Can you please
>>>>>>>> post your numbers with the patch series? When we posted the original
>>>>>>>> patch set we did provide performance numbers to support the choices we
>>>>>>>> made (ie, not hurting performance of small copies).
>>>>>>> Currently the source and destination export was mounted with default
>>>>>>> rsize of 524288 and the patch uses threshold of (rsize * 2 = 1048576)
>>>>>>> to decide whether to do inter-server copy or generic copy.
>>>>>>>
>>>>>>> I ran performance tests on my test VMs, with and without the patch,
>>>>>>> using 4 file sizes 1048576, 1049490, 2048000 and 7341056 bytes. I ran
>>>>>>> each test 5 times and took the average. I include the results of 'cp'
>>>>>>> for reference:
>>>>>>>
>>>>>>> size            cp          with patch                  without patch
>>>>>>> ----------------------------------------------------------------
>>>>>>> 1048576  0.031    0.032 (generic)             0.029 (generic)
>>>>>>> 1049490  0.032    0.042 (inter-server)      0.037 (generic)
>>>>>>> 2048000  0.051    0.047 (inter-server)      0.053 (generic)
>>>>>>> 7341056  0.157    0.074 (inter-server)      0.185 (inter-server)
>>>>>>> ----------------------------------------------------------------
>>>>>> Sorry, times are in seconds.
>>>>> Thank you for the numbers. #2 case is what I'm worried about.
>>>> Regarding performance numbers, the patch does better than the original
>>>> code in #3 and #4 and worse then original code in #1 and #2. #4 run
>>>> shows the benefit of the patch when doing inter-copy. The #2 case can
>>>> be mitigated by using a configurable threshold. In general, I think it's
>>>> more important to have good performance on large files than small files
>>>> when using inter-server copy.  Note that the original code does not
>>>> do well with small files either as shown above.
>>> I think the current approach tries to be very conservative to achieve
>>> the goal of never being worse than the cp. I'm not sure what you mean
>>> that current code doesn't do well with small files. For small files it
>>> falls back to the generic copy.
>> In this table, the only advantage the current code has over 'cp' is
>> run 1 which I don't know why. The rest is slower than 'cp'. I don't
>> have the size of the copy where the inter-copy in the current code
>> starts showing better performance yet, but even at ~7MB it is still
>> slower than 'cp'. So for any size that is smaller than 7MB+, the
>> inter-server copy will be slower than 'cp'. Compare that with the
>> patch, the benefit of inter-server copy starts at ~2MB.
> I went back to Jorge Mora's perf numbers we posted. You are right, we
> did report perf degradation for any copies smaller than 16MB for when
> we didn't cap the copy size to be at least 14*rsize (I think the
> assumption was that rsize=1M and making it 14M). I'm just uneasy to
> open it to even smaller sizes. I think we should explicitly change it
> to 16MB instead of removing the restriction. Again I think the policy
> we want it to do no worse than cp.

I can make this a module's configurable parameter and default it to 16MB.
However, why 16MB while the measurement I did shows inter-copy starts
performing better than 'cp' at ~2MB? Your previous measurement might no
longer valid for the latest code with the patch. Can you verify the patch
performs than cp even with 2048000 bytes copy?

>
>>>>> I don't believe the code works. In my 1st test doing "nfstest_ssc
>>>>> --runtest inter01" and then doing it again. What I see from inspecting
>>>>> the traces is that indeed unmount doesn't happen but for the 2nd copy
>>>>> the mount happens again.
>>>>>
>>>>> I'm attaching the trace. my servers are .114 (dest), .110 (src). my
>>>>> client .68. The first run of "inter01" places a copy in frame 364.
>>>>> frame 367 has the beginning of the "mount" between .114 and .110. then
>>>>> read happens. then a copy offload callback happens. No unmount happens
>>>>> as expected. inter01 continues with its verification and clean up. By
>>>>> frame 768 the test is done. I'm waiting a bit. So there is a heatbeat
>>>>> between the .114 and .110 in frame 769. Then the next run of the
>>>>> "inter01", COPY is placed in frame 1110. The next thing that happens
>>>>> are PUTROOTFH+bunch of GETATTRs that are part of the mount. So what is
>>>>> the saving here? a single EXCHANGE_ID? Either the code doesn't work or
>>>>> however it works provides no savings.
>>>> The saving are EXCHANGE_ID, CREATE_SESSION, RECLAIM COMPLETE,
>>>> DESTROY_SESSION and DESTROY_CLIENTID for *every* inter-copy request.
>>>> The saving is reflected in the number of #4 test run above.
>>> Can't we do better than that? Since you are keeping a list of umounts,
>>> can't they be searched before doing the vfs_mount() and instead get
>>> the mount structure from the list (and not call the vfs_mount at all)
>>> and remove it from the umount list (wouldn't that save all the calls)?
>> I thought about this. My problem here is that we don't have much to key
>> on to search the list. The only thing in the COPY argument can be used
>> for this purpose is the list of IP addresses of the source server.
>> I think that is not enough, there can be multiple exports from the
>> same server, how do we find the right one? it can get complicated.
>> I'm happy to consider any suggestion you have for this.
> I believe an IP address is exactly what's needed for keying. Each of
> those "mounts" to the same server is shared (that's normal behaviour
> for the client) -- meaning there is just   1 "mount" for a given IP
> (there is a single nfs4_client structure).

ok, I can give this a try. However, I think this only reduces the
number of RPCs which are bunch of GETATTRs so I don't think this will
help the performance number significantly.

>
>> I think the patch is an improvement, in performance for copying large
>> files (if you consider 2MB file is large) and for removing the bug
>> of computing overhead in __nfs4_copy_file_range. Note that we can
>> always improve it and not necessary doing it all at once.
> I don't think saving 3 RPCs out of 14 is a good enough improvement
> when it can be made to save them all (unless you can convince me that
> we can't save all 14).

I don't understand your numbers here. Without the patch, there are
14 RPCs for mount and 2 RPCs for unmount and overhead of creating
and tearing down TCP connection each time. With the patch, there are
8 RPCs for the mount (PUTROOTFH and GETATTRs) and 0 for unmount and
no create and tear down TCP connection. The RPCs that the patch save
are mostly heavy-weight RPC requests as the test showed the patch
outperforms the current code even at 2MB.

-Dai

>
>> -Dai
>>
>>>> Note that the overhead of the copy in the current code includes mount
>>>> *and* unmount. However the threshold computed in __nfs4_copy_file_range
>>>> includes only the guesstimated mount overhead and not the unmount
>>>> overhead so it not correct.
>>>>
>>>> -Dai
>>>>
>>>>
>>>>> Honestly I don't understand the whole need of a semaphore and all.
>>>> The semaphore is to prevent the export to be unmounted while it's
>>>> being used.
>>>>
>>>> -Dai
>>>>
>>>>> My
>>>>> approach that I tried before was to create a delayed work item but I
>>>>> don't recall why I dropped it.
>>>>> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-nfs/patch/20170711164416.1982-43-kolga@netapp.com/__;!!GqivPVa7Brio!Jl5Wq7nrFUsaUQjgLJoSuV-cDlvbPaav3x8nXQcRhAdxjVEoWvK24sNgoE82Zg$
>>>>>
>>>>>
>>>>>> -Dai
>>>>>>
>>>>>>> Note that without the patch, the threshold to do inter-server
>>>>>>> copy is (524288 * 14 = 7340032) bytes. With the patch, the threshold
>>>>>>> to do inter-server is (524288 * 2 = 1048576) bytes, same as
>>>>>>> threshold to decide to sync/async for intra-copy.
>>>>>>>
>>>>>>>> While I agree that delaying the unmount on the server is beneficial
>>>>>>>> I'm not so sure that dropping the client restriction is wise because
>>>>>>>> the small (singular) copy would suffer the setup cost of the initial
>>>>>>>> mount.
>>>>>>> Right, but only the 1st copy. The export remains to be mounted for
>>>>>>> 15 mins so subsequent small copies do not incur the mount and unmount
>>>>>>> overhead.
>>>>>>>
>>>>>>> I think ideally we want the server to do inter-copy only if it's faster
>>>>>>> than the generic copy. We can probably come up with a number after some
>>>>>>> testing and that number can not be based on the rsize as it is now since
>>>>>>> the rsize can be changed by mount option. This can be a fixed number,
>>>>>>> 1M/2M/etc, and it should be configurable. What do you think? I'm open
>>>>>>> to any other options.
>>>>>>>
>>>>>>>>      Just my initial thoughts...
>>>>>>> Thanks,
>>>>>>> -Dai
>>>>>>>
>>>>>>>>> --
>>>>>>>>> Chuck Lever
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
