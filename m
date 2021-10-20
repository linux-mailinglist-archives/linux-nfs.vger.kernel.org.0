Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFE3435364
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Oct 2021 21:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhJTTGL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Oct 2021 15:06:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29886 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230076AbhJTTGL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Oct 2021 15:06:11 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KIcR0o000812;
        Wed, 20 Oct 2021 19:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2Fk4O5H3D2yih6P/STO7+7CkqgyxBYVCLHzdnKN5z7I=;
 b=IbbiPqy8LawxiLDfefrFLmHV26dnanA4Ma9Z/XcpSR8IKJZshVYytUSoC8hF44ByYCQr
 kNoxuRtK/q1QwEV56vw/F75xhK7W1P+xvEsd4v5AIPdaYRvkBpjgEixnkFNRcX+Ij44D
 ddy7e7FnbEWtAknqhmDb6s+noTUa5Zjl+mVkaoAa0H25q+FC3NV3+Ckbvx7szd6RTqR/
 HMJkPgUFVeopC+tZYnK43nMP6corBaZfSzXzmS+Ba76pU/6x9x1bbQFZJTqAqCJxGLF3
 E9jabjOrJtsQkQQfv9spwrxOn0J29wmcfuAobCA51HxFSjhBvbSSNUPZP+XKPRKe2gWR xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkw4t25u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 19:03:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19KJ1AI2114151;
        Wed, 20 Oct 2021 19:03:51 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by aserp3020.oracle.com with ESMTP id 3bqpj7j41f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 19:03:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmVnIUPsTTi207xVhuLHBxqM1VlYIKk6bl3LtSIEEJqp3erRtuatxhfpBvUtAHVDKu5etQR03itnp2X2wV5Cr42frL8BwBZtUEsn51kjyDuu81xjSFVA1DnoCAdXFj9oZ4TwzfTwi/po99vTaeSZtgH76A9j8AZn7FlMBSOvjMNNr+KXYmioatkHFsRC3T82oqNjHPVToTbEJeXJDoJ+obCjZC6/N5B8ORNDAEUuzNpn6kqb2dAA+p58XOH8WxdvjUcBbxFgfksWsn0MkGpRo+xhByYpovfTNDprF6StiERCm9Mu5Zccqa6zLvKGfvmq2M+6/nprR2LT2fT9rxNmuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Fk4O5H3D2yih6P/STO7+7CkqgyxBYVCLHzdnKN5z7I=;
 b=bdKKvMbJ6/QpPPg9A2i2VahWoj/FDMDuoHdgE6etdn4Re3QlzxAA5J1EEdVmuqiv7N+1NNrguutjsIWSNkYlgXBahvHU5cECuJl05RyYrQXjhpV2wYMZZxrmP0KLtdz7cNEJZaemrDVLFbG55flsGii+O4dhc6NoPo0CI16scph6FyGUJtrvtSsPu5deuLeEskZwm+ELTQcwG6cDKO5wQfIFNi8gDs5JQ6ekWxqBMEQgry/gWJ1r6emb01rtNrnp30MzcgbltB3n4UZ1CbKD9zNW2LTbKewf/RJnsBU4J6m9BLSOLy0mKasGI9G4bgkUVP27evJVVZiDCDevNxkGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Fk4O5H3D2yih6P/STO7+7CkqgyxBYVCLHzdnKN5z7I=;
 b=pdb+V9B0Cdmnik85ryuWNnQHPWlvUX4ikMEqM23THePHp8leK1ybMqnxo/ja6NS1+3CrD0yWWgn2Rh3IOW/BTgDb4ba6ydzX+5P4J2x41SLfLblDJjrC8nvMsrH6XnOkiFUa1Qpc1IptCm8tsEosSIabi73WaR6DFO6uDZexXkQ=
Authentication-Results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB2712.namprd10.prod.outlook.com (2603:10b6:a02:b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Wed, 20 Oct
 2021 19:03:49 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%8]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 19:03:49 +0000
Message-ID: <8b1eb564-974d-00b6-397a-d92f301df7d8@oracle.com>
Date:   Wed, 20 Oct 2021 12:03:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: server-to-server copy by default
Content-Language: en-US
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
References: <20211020155421.GC597@fieldses.org>
 <18E32DF5-3F1D-4C23-8C2F-A7963103CF8C@oracle.com>
 <CAN-5tyEL4L2GH=-MDGS4qNTcCLRPFCQzfDQjFAVbG7wMKvHxOg@mail.gmail.com>
From:   dai.ngo@oracle.com
In-Reply-To: <CAN-5tyEL4L2GH=-MDGS4qNTcCLRPFCQzfDQjFAVbG7wMKvHxOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:805:f2::34) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.159.130.198] (138.3.200.6) by SN6PR04CA0093.namprd04.prod.outlook.com (2603:10b6:805:f2::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Wed, 20 Oct 2021 19:03:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8b8a12a-95aa-47b2-475d-08d993fc59a3
X-MS-TrafficTypeDiagnostic: BYAPR10MB2712:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2712EFDF4C9EEC07B384A04987BE9@BYAPR10MB2712.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: seUl+JS/UMZJbYsxuribZStbeLGDh/UhJqQMI9ljzOVS0h/JXkdodbbghVGtSCk9pzBOdUaSKNBNNiiiSjwa5cb385W1dwtcS9cHqEALwOwRRlZgh1Ib4mlwRz2KQ4u/pkhH3uAfucsV77l2JV78kksFbYWPbIgo0cNoKbfGgo/MY8c9YOXk5WjykE36Q27yOg04jQilvC9A40zsKJLYWu87pfzoQJtHKL/A0/s+lrIsBxVIp02QMVqicYjv7AERDoJ2EFSzzTZVZm+Vld1Mrp8Gye03z1wypuU4/9qp5zSPvPtVjijQVI9JhKGDO4Vo0xsDRZlvn0cPsTD4kT+68vJFtQo2LWEeGoEusajUOfAMhybecVzjQBi+Dn8NIjEcYcon7VZQTl0aXGmrOTDbK4Ve0QvqEXyJJ0BuYl/9DvABQxf2/xoFM7xuN825HDvxA2W4+2o9jtXgqxpusIheuaAoLbepcwe28iFct/PqV9Svfg3kL2nRusxWm/F2HaB4gfw6N9ab465jZ1CXCdY63VllBm3oTs68RQlzw++uv76cNskxv66C0xsIQysbiGgtyV5/NtG86SbL5WR410e/jZSWqaOvULEIbYAZ5+SaHaUeMG+sSGA6AahEZ1XqJK+aWAQOPFjE+qX2X0uCuiYJyIzs8OiovxvAF9pFTcxbco7iPNDmEyQPzHMQmgx530vhgPa0pC48E1DeKS2IbZYEDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(956004)(4326008)(9686003)(186003)(83380400001)(2906002)(66946007)(508600001)(53546011)(6486002)(86362001)(66556008)(107886003)(66476007)(2616005)(36756003)(38100700002)(5660300002)(316002)(16576012)(8936002)(54906003)(31686004)(8676002)(6916009)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WC82aHNMdm9GVjZWTTg0SHFnSm14RHdWZTE0cUVUUVh4MEZWVkcyMCtvS1Nt?=
 =?utf-8?B?cTNUamhaR01mZUNQSjd5TXc1cFNuUDNpRW01MUZCcUF0blVNcXdneUYyM0VU?=
 =?utf-8?B?cVg5UW1FTHdZbkoyTSt0VU9mR2EzMTRGNFJSdEpxMVlENGZMU1c0OTk1bDZQ?=
 =?utf-8?B?U1B0T2hlLzZPcS9nNWRKTmttSEk2ZUdSOVE0bWVUbm8ybVJtd21hTGVnbTdq?=
 =?utf-8?B?eGNIMWRYNCtFbDFGOEI1TjhlL3JpNE8yK2RLRU0xWnRrRnRBRWhvRUswZXZY?=
 =?utf-8?B?cm5SYkpLWWtURWIvVFJTem1aUWwwUGUrQVkxRlFpSUdRZTM3RzNpUFlQWDhY?=
 =?utf-8?B?RTE1ZjhZRDVZdU15WDYzVC9seVdST2hsUldreWhqWkIydjRZemdqWExvdDY1?=
 =?utf-8?B?QkNaeUdKaUNaWksvUXlBMXFTN2dBMU1Yc1VMakZ4dFhnN2JSVE5ydjZ3YUY0?=
 =?utf-8?B?M1M3L09BQzB0ZURGRUQzT1V3dUg5cmgvK281Tm1CYW1iS3BRTzJMVFZCd1Za?=
 =?utf-8?B?RWhzc1RBYmhJWmZldHYrdjdjdS9SUmFqSG45aWdJcnBEL2I0dFB3TkhCVGFu?=
 =?utf-8?B?NEZDcEN1YUViNkNaODEyZzFaaDdoVVFpSlQxNGFQYzI1MTBDbHU4dXZDUHRv?=
 =?utf-8?B?SVQ1UEdFVDF2VEZGOWNQdU45clF3cVJJb0oyNjVnSjFyQjBFWHkwYmMwdk0r?=
 =?utf-8?B?YTZOSlZpNVFKMGxDenNwaU1VNEVUMWxhTDRBYmM3STVWMmhwMFZ3aVYrNGta?=
 =?utf-8?B?OFhiZU1sS1Zqa0FDaFV0KzhJYjREQUI5SDlSOG50MFQxU2FFVDJtc2pGUWoy?=
 =?utf-8?B?VGlJWDA1bjQwZlhqNkNhTStjZ3hKVGJvUVh1UHlLU2Y5bG8yckI4dnJwZjdy?=
 =?utf-8?B?ajh6aklPYldDQWtqS0FYaE8vRHBheXNrSXNSV2IyR0w4aW9nY0ttSFNYb2ts?=
 =?utf-8?B?UGNsNENzdEZUMEo0QnkxK05ka3lTeS93Y0luNFBlVFlPMmZBWlNrWmhhUkYv?=
 =?utf-8?B?YjFKN2ZzMzMwUEFVWDhnTStLclQyMjNaUktzbkdweGhsWVRHektUZ29BVEhL?=
 =?utf-8?B?bE9BL3FQck0zcUNrU01XVndkajdIRkZGTTM4aGx3VHNaUkJkbmlocm91bEkr?=
 =?utf-8?B?NFZkSlVteUVCRnZRY3FETU9EUzVLYnVSQUZJMU9PTzc2QVQ4SDF3dFJkT20z?=
 =?utf-8?B?N3Z0MXp5b05mNXhHT3h5bjhNczJkNUd5Vm1waEs3V1JDelZlNThER3RjN1Uz?=
 =?utf-8?B?dzlHeXBPOTJiTVlVc0syazUrUEJ0MCtUajIvKzBLMUw4TnIwRlRmOFhiN2pP?=
 =?utf-8?B?Y1NEekxUWUhsa2phM05zZGdkZUZhNk90bytDRlY5d0dsVGl3REo4eEpoK2x0?=
 =?utf-8?B?ZVZKcGhFWFdOQkNmT1cvdG5uMDh0bk44QnZkT3g3SmVOU05CWWtRc2FNSWFi?=
 =?utf-8?B?L0RvUjhjaEx1aGcxRjBjdmNyV2FkQ1NUd2pESnc1QzVHV0M1a3NNK1lYdm9k?=
 =?utf-8?B?cWNpWG1hK3RTYW5PamhEdmtkdkxCTWRaV2k0c0t0MkNkd3dFUkVjRHN6ZTky?=
 =?utf-8?B?T0w2VVdIV0IzSnRzWDE4ZXlWdFU1dUY3UEViQWovYjE4b2JQdGgzcitLbWNW?=
 =?utf-8?B?amVlNWh3UUk0Z2llTkJoUkFETTVwZS9WRERLOUNiWXJTYUF5ZkxnZ1JpZjRX?=
 =?utf-8?B?bW85YzB2OEc1VlM1V3B5L1RzRGN4V0FjNzl0emRWUWNYamJ4WFNyaWxSYkN5?=
 =?utf-8?B?MnpSMjluTXlpQTl4NG5IaFNzYmkxMHoxMm9RUklLUWYrK05sSkNncVdXZ25K?=
 =?utf-8?B?ZE9NMkI2dXN6cEVUc2NEKzd6cjI1MkhLc2hHVHRRVHgwRmZOY3g3a3llWVdp?=
 =?utf-8?B?TENHUzNDZzh2dGV4RGNPeUFQWjZrd3JXTDlwUzlFWU1BVktTbHdYZ0NReG10?=
 =?utf-8?Q?fEN44H4UGTo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b8a12a-95aa-47b2-475d-08d993fc59a3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 19:03:49.5615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dai.ngo@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2712
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110200108
X-Proofpoint-GUID: G9aT_Rz67GbmhGu-NA78XQP0peFS7RZu
X-Proofpoint-ORIG-GUID: G9aT_Rz67GbmhGu-NA78XQP0peFS7RZu
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 10/20/21 9:33 AM, Olga Kornievskaia wrote:
> On Wed, Oct 20, 2021 at 12:00 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>>
>>
>>> On Oct 20, 2021, at 11:54 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
>>>
>>> knfsd has supported server-to-server copy for a couple years (since
>>> 5.5).  You have set a module parameter to enable it.  I'm getting asked
>>> when we could turn that parameter on by default.
>>>
>>> I've got a couple vague criteria: one just general maturity, the other a
>>> security question:
>>>
>>> 1. General maturity: the only reports I recall seeing are from testers.
>>> Is anyone using this?  Does it work for them?  Do they find a benefit?
>>> Maybe we could turn it on by default in one distro (Fedora?) and promote
>>> it a little and see what that turns up?
>> I like the idea of enabling it in one of the technology
>> preview distributions.
>>
>> But wrt the maturity question, is the work finished? Or,
>> perhaps a better question is do we have a minimum viable
>> product here that can be enabled, or is more work needed
>> to meet even that bar?
>>
>> One thing that I recall is missing is support for Kerberos
>> in the server-to-server copy operation. Is that in plan,
>> or deemed unimportant?
> Netapp has some code for gssv3 support which is required for
> server-to-server and possibly some copy offload pieces (Andy's work
> before his retirement). Anna was picking up the gssv3 work but hasn't
> had the cycles yet to complete it. We can make it more of a priority
> if that is a show stopper.

yes, afaik, the gssv3 support for server-to-server is the only
missing functionality (besides the potential security related issues
mentioned in this thread). It'd be good if we can implement this, or
as Steve suggested we can wait a little while for the technology
is stable before adding gssv3 support.

Do you consider this missing functionality as a show stopper?

>
>>> 2. Security question: with server-to-server copy enabled, you can send
>>> the server a COPY call with any random address, and the server will
>>> mount that address, open a file, and read from it.  Is that safe?

The client already has write access to the share on the destination
server, it can write any data to the destination file. If the client
sends a COPY with random address of the source server, that source server
has to export the share in such a way that allows the destination
server to mount. If the share on the random source server is open for
everyone, then isn't it the same as the client writes random data from
its local file to the destination file without server-to-server copy?

-Dai

>>>
>>> Normally we only mount servers that were chosen by root.  Here we'll
>>> mount any random server that some client told us to.  What's the worst
>>> that random server can do?  Do we trust our xdr decoding?  Can it DOS us
>>> by throwing the client's state recovery code into some loop with weird
>>> error returns?  Etc.
>> A basic question is what is in distribution QE test suites
>> that could exercise this feature? Should upstream be tasked
>> with providing any missing pieces (as part of, say, pynfs,
>> or nfstests)?
> There are server-to-server tests in the nfstest testing suite. I'm not
> sure if any of the xfstest copy_ofload exercise server to server
> capability. Anna wrote the tests.
>
>>> Maybe it's fine.  I'm OK with some level of risk.  I just want to make
>>> sure somebody's thought this through.
>>>
>>> There's also interest in allowing unprivileged NFS mounts, but I don't
>>> think we've turned that on yet, partly for similar reasons.  This is a
>>> subset of that problem.
>>>
>>> --b.
>> --
>> Chuck Lever
>>
>>
>>
