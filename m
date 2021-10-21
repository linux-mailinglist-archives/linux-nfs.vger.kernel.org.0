Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8581D435A22
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Oct 2021 07:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhJUFDH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Oct 2021 01:03:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47218 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229499AbhJUFDF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Oct 2021 01:03:05 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19L3eBqB025798;
        Thu, 21 Oct 2021 05:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=dSXuNmOxgTS4BnUThUNgiWqdpcL2qdq2rfdJP/X+Pk0=;
 b=UWPaLXSXVzNiSFR8S5HQqrlL3baL4m3OHgyWX1tnzIeu6dxoNoe2Wnur9yYAQsD0oTmm
 7/iFRSNhB9Rkd3ATIBYceCWr1tGMuM2SZbgyH3mQEi6LcE1IF3Z15XshoO+81nnzORkP
 yDY2bgkuL4Y99MHlDc2ADp+weV+D8BM+L4FdPjOGbcPKlC77UgmRI6IcG6SMIyGLWURg
 D5J5tJuAPY981dFIlM2A6Fh0YdkNasl+VaeVvm2Xo0w7pz3t//X6DP+UqrlK29pYbTTJ
 xkq5Z1VuBv+C3DKKKotkX5FZmzA6Fz9kWbfd00Aco23uH27gLCMV7LA1bMSlLqHODP4D aQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btrfm2fpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 05:00:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19L4pK0I186834;
        Thu, 21 Oct 2021 05:00:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3020.oracle.com with ESMTP id 3bqpj85avj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 05:00:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1WqgR1CLUqv46io82K+gIv4iWC3e2IMr6iBXdMQNnM9GhIPMiYf63OODAO4XcKfa+LNwS0vzFjZzCUVtlrdyawMu5YO2yrBeo/QUIlEPOnV0tJNChcuFeWqn+gHLJNYpf+JmZTBgRE3v3svhcC1KI5lR6X72sm1tAo8rzolYhjdnE+oBdLSzUZaj6SB5seAmcaoFbk+FKNYkVc2xB1KGAKQlhXeiJjVcc1iF7DL+PDLwd6uAKqtXkJeaVrT878HOAXPEAN4I0aXnoi+1vkYEoZG3khaWLKAAXZhxVvzXfkvMjDqnUHpFf+DIGrDDVwrqTrXoJ0MQn6mWmzmFGJRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSXuNmOxgTS4BnUThUNgiWqdpcL2qdq2rfdJP/X+Pk0=;
 b=h7UJQJd+JclLRfnAjOfjt+sIfZ45MIELRo0Kwh7EkCX9emad12tN3SToT5ssRggNIFKXwHPFBfVIiwykclYyQTLfaqxrMVyviztB1E0fDwxJNJ9GJ4myh8lpLjsjSO9T7oT/57GWXdZ1pKNWsZ5LhdTxhRaEavId+Mla0oi7e0F8vdgTfFCtGMxtv58V7+y5ltV4GCH8Y3pnQvUmViGSZ0fJ6F/Vehw/8QdNBFI0EOszMAqgmICPDcNx3b4+w9eCqvJwcKJG2V1WWbBi2Z2A0Y3GZdrb8wpHmgfyAzCS2Dk9J++syc7fwhfLe6AR/gCff4UqVyVQZKyoM4QHU+FJ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSXuNmOxgTS4BnUThUNgiWqdpcL2qdq2rfdJP/X+Pk0=;
 b=UscT9aRuQ4AhoTiby3mK4w6t/D4NVRyONIOS41HvZJjvTyyJ8XvzqoIGQyAEiGIVRd0KPT6UDkAqvSfIQBri7V7kdu/CKVgu+G/OPJtr1ykYP8CbJS3VOWrtLk4+QvqC/g4PGX9k8DBeUarPJBFc3hUzdebsGOeIHKoVAPcmOG4=
Authentication-Results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB3954.namprd10.prod.outlook.com (2603:10b6:a03:1ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 05:00:45 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%8]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 05:00:44 +0000
Message-ID: <a009cbf3-cb83-b7c8-aa86-2eee06962b68@oracle.com>
Date:   Wed, 20 Oct 2021 22:00:41 -0700
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
 <8b1eb564-974d-00b6-397a-d92f301df7d8@oracle.com>
 <20211020202907.GF597@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20211020202907.GF597@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:806:21::14) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.159.130.198] (138.3.200.6) by SA9PR13CA0009.namprd13.prod.outlook.com (2603:10b6:806:21::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.10 via Frontend Transport; Thu, 21 Oct 2021 05:00:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db23fa8d-3dc1-4b48-46ba-08d9944fbd34
X-MS-TrafficTypeDiagnostic: BY5PR10MB3954:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3954EC51A69F2A578AC7DE5287BF9@BY5PR10MB3954.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FJnnHUgOnUBAFrc0Ldy/xKZAg4jhLn8W5kDv46W8smpi6jj+S/7nAIxVeCoMZlcNkY9EJE4gpnbd41W5rfsmpKMGbKlvaCNX3gXBhuHzSO0L4bfLEEr9NjJGyuupdQIHL6oCLkr06taecqiLC6q9gyqIVYqSCx7ek+U3CRYsiFSMc22UUs2pB9COLe2/lRKvSMeKB+074A/hzUkYRTVnQqfeaUhyoV26KlARm9/UlnQ5ilNuIpilcYzkpZAZMDdLAF2QjCE4DGtf5q/KRGQ1JGfLQiklTbAcVXlAH/mq1xVNXuVe6G7xXKvjAurT0WgvhRujSaFjngwI8RgHQs16XFyIzVQyFiZvsPUCI5pOKBoEKQZGZvfadBTCMDa2OqPV2/g4Y0Zx69FA/zvRs1w38KcrWM121DWzPjyDkHe1V1QhLpqSLzQ0qol5Zv8BweBiLk0Gub+fAUT6Sr+8FjgCAOl9RpZ5UkI5ViTW5reIjMVVfNtrlDuYK3Q/iNWjkFpV23G+scqC16WWr/6j9u57zB8WEWUnz2fBz/YTx1BUETH0qTDWzIx5OjP6eJyx/Ufn1eWGsf4X/regTdnVBDDT0jUUHeunxGEcF42gAjmDwFK/1HHofKu4e8oEiiz1Trk5cqaGEMqstv2B75MPWInUjA5u71fZQl4xnQB3a/AV4rU5+EN4h+i57oaD792AxgudHjWiga+kR6yqoabViSIOZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(31686004)(2906002)(8936002)(66476007)(6916009)(66556008)(2616005)(186003)(83380400001)(54906003)(508600001)(53546011)(956004)(66946007)(16576012)(8676002)(4326008)(316002)(36756003)(9686003)(107886003)(38100700002)(6486002)(31696002)(5660300002)(26005)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWJUM00reHNDRUhmcjVrWElFR0l2bTJyS0s3eHVkSGR3YVc3OUxzQUtlMC9O?=
 =?utf-8?B?OS9xYjVaRzI4d2Zmd0QrMFA5YldZVmEyb2ZKZkhVdzNVbDh0a2hHcUVBZjNO?=
 =?utf-8?B?N3hJTjBFZVFhT2hNYlEycGFRQjhkVGYzZGlwRkIvNkIvYjFXb29QeHlsMzF3?=
 =?utf-8?B?TzdVVVprTnRRU1ZWUGtFZVdBbUlSS3Y5N1AvUnpWN1BrMVB0M3dRYVVqYmFn?=
 =?utf-8?B?cnBGazF0Mk1MUWxqS2JGcko1Ujh1R0NoNjNzd3BEYVNtaHBwb3lLWGhjZmtD?=
 =?utf-8?B?T2l1TGJyRFF0L1NDOS9yNjhCMmtRcUd6YktVako0a3B3UzU4Z1RlM1IyaEx6?=
 =?utf-8?B?dVFjUW1LWHpPQnRMMFZoR3laellQVVBwK2tyRWV4c0laNDFib2JkalduNnpF?=
 =?utf-8?B?c1dxV2NuMndvVjhyWkFPY1hITktDM2JXcU1lY3Z2dlVqWk5QOTI1cjJVUGtl?=
 =?utf-8?B?eVhmeXV3UGNxUlduT3liaVJXUWQyZDdYYkFMS3F5dFVMVVMrWTczSU0raWsr?=
 =?utf-8?B?ZGtLeUpRZTYzakVYUm1wTk9hOFp1TnBWOERDYzMzY2cxREphVWZHczNHSWlG?=
 =?utf-8?B?ZUlFSEpESC9kVlFzVzhMT1BXREZ2Nm04T29tRkFKOEhKeXhkWXUwdytCbmNH?=
 =?utf-8?B?NjlWU0VhK1BDb2toZXNVcE5BMHpXK0FaM2NXTnhIZm9Iei96Y3dVb3lzN08r?=
 =?utf-8?B?ZysvQzIrU3d0VlN5M2FWNC9VRzE4b0dpV2FUYkNMZ2s4UVkydHRRSXV2VEJm?=
 =?utf-8?B?NlgzRGZRanU5NWRQYithMUtxdGt0TXVwSUVUVDc5dm5qOWc0VjQ5NzNxU3ZP?=
 =?utf-8?B?QmhsZWFLSmg4WFpPMHdUMGdyblg5SmRReUJxcmRSR0t3SXB2engyandUd1RC?=
 =?utf-8?B?Q3F3YVpwQkRxMGgvYkluYmVvY21tS1RoczM1anFRaW4wM2JVU1dLTXNTTTlQ?=
 =?utf-8?B?Smc4NmJVZjlkS1BxcjY5amx5UmlhMVQ5MkFTbWVCY01xNFoyM2JRaURaTVJH?=
 =?utf-8?B?bVJtQmdFdDdWcHdHR0w1Mmp4VWxha3NqOUNnclJnV0Y1cFJpdE1reHAzR05k?=
 =?utf-8?B?ODFlaE5waFBTdmYzTlRwaFcyRDdZRFAwcnEwcWx6L3E3Ym40YUF0aU1wbEhC?=
 =?utf-8?B?RDhETUlObEhScXg3Y2k2eFBuTDQzQmxGMWw5WGF5WkJKODdienRMSm1tSWt4?=
 =?utf-8?B?ZlBxOE9QWVJlUklUc094Ukh1Q2JmTTRUWGZKVmVib0pTdWdBalZlTU1va1pX?=
 =?utf-8?B?VE5nSlczZVNUa3dRQTFIRnJPd3V2ajM5LzVHb2hFMk5VemJVbDd1QjhqSkNT?=
 =?utf-8?B?MTRLVmljblViZ0dOZlNPOGtOSFJuSXNIQVBtVW9zM1BHMlVJb28zVzVtbUlD?=
 =?utf-8?B?OXZ6bHk0eWtqWnlyR1doTXBwQjlOR21Nc1JMMG5DcWNsOU9EQVFlSnE3OHdu?=
 =?utf-8?B?WG1GQ2IybFlXY3p1ZkRxVHZoRVpiM1lwbDZSRFlLMFpRSjkyalFDMERzWXcv?=
 =?utf-8?B?Zkk3QVpxL21ZczdIYWI1MHYxK2JXNU5pcXVZVWNEemhUVW00cHZuS2NkMmVM?=
 =?utf-8?B?alJsZmxwN043bG9jaEkybXJ6c2pKeVZQaWtnNTNXZk84SU5mWUljL3JzK3M3?=
 =?utf-8?B?MDJ4MVBRSjlYaHpWdldLNE9vemFzRVZ2S252VldDNmVJeHJpOG9Sc3RiTldq?=
 =?utf-8?B?TExGNXlxK2N6d3NhUTVPeUx3R3J6RndGR3VObXJrcU1vSHoxRFBZbEpkVHRN?=
 =?utf-8?Q?DCL7UA739y59Jgy2JPaIoNXfSQKbFe1ldNJDDri?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db23fa8d-3dc1-4b48-46ba-08d9944fbd34
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 05:00:44.8527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dai.ngo@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3954
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210021
X-Proofpoint-GUID: Xa_ggJMgxjvfR_ni7jyxkZkalN5gTCj7
X-Proofpoint-ORIG-GUID: Xa_ggJMgxjvfR_ni7jyxkZkalN5gTCj7
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/20/21 1:29 PM, Bruce Fields wrote:

> On Wed, Oct 20, 2021 at 12:03:46PM -0700, dai.ngo@oracle.com wrote:
>> On 10/20/21 9:33 AM, Olga Kornievskaia wrote:
>>> On Wed, Oct 20, 2021 at 12:00 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>>>>> 2. Security question: with server-to-server copy enabled, you can send
>>>>> the server a COPY call with any random address, and the server will
>>>>> mount that address, open a file, and read from it.  Is that safe?
>> The client already has write access to the share on the destination
>> server, it can write any data to the destination file.
> Agreed.  Please look back at what I said; I'm not thinking about attacks
> on the source server, I'm thinking about attacks on the destination (the
> one that receives the COPY).

Sorry for missing you point. If I understand correctly, your concern is
that a malicious client can direct the destination server to mount a
malicious source server that can generate DOS attack to the destination
server.

The attack can come from the replies of the source server or requests
from the source server to the destination server via the back channel.
One of possible attack in the reply is BAD_STATEID which was handled
by the client code as mentioned by Olga.

Here is the list of NFS requests made from the destination to the
source server:

         EXCHANGE_ID
         CREATE_SESSION
         RECLAIM_COMLETE
         SEQUENCE
         PUTROOTFH
         PUTHF
         GETFH
         GETATTR
         READ/READ_PLUS
         DESTROY_SESSION
         DESTROY_CLIENTID

Do you think we should review all replies from these requests to make
sure error replies do not cause problems for the destination server?

same for the back channel ops:

         OP_CB_GETATTR
         OP_CB_RECALL
         OP_CB_LAYOUTRECALL
         OP_CB_NOTIFY
         OP_CB_PUSH_DELEG
         OP_CB_RECALL_ANY
         OP_CB_RECALLABLE_OBJ_AVAIL
         OP_CB_RECALL_SLOT
         OP_CB_SEQUENCE
         OP_CB_WANTS_CANCELLED
         OP_CB_NOTIFY_LOCK
         OP_CB_NOTIFY_DEVICEID
         OP_CB_OFFLOAD

-Dai

> --b.
