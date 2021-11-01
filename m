Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD673441F6E
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 18:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhKARkQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 13:40:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10534 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230246AbhKARkE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Nov 2021 13:40:04 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A1GJRrA008632;
        Mon, 1 Nov 2021 17:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=57xay8GsS3KBf77ZaWbVLfrzg9LziV8JIiWx6TPSX18=;
 b=emoYDQgzkw0NN4hZevcF+9pbISguZWLxBpHvQN1fMf0o2iCvzKXMr4xTc4Ln8P5thva7
 hO7W3SCr88WiH/WllAF48jIdAMdbmDTF+Bld5zqNckZkAyXy2/jpivHHcsw1lVAhdUsc
 smA3fr1QejVPETZZXMdO8o+XCY1zZei0yCQMCT6EW+Z0EbjpKWstijC2dZ6gO/M6RjWh
 f3sQTy+qExgitOOkihhJMzkzi5fngl5l+/psMqRvsbLIqy+Hgetf2+vbOav0wN0WVLhQ
 plaMo8mkdujyde5oglJczlq5F8cvoYUfITLwbJ+Cm3aGkUi8tNmWlh3zVePs73Nuwrbm cA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c290gu0j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Nov 2021 17:37:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A1HURDQ058060;
        Mon, 1 Nov 2021 17:37:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by userp3030.oracle.com with ESMTP id 3c27k3sbdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Nov 2021 17:37:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiE5HCI2GmgDaCBUPVCksUMEh4WTBXTxGAP+6bOlKIY1K2GGSBy8b1mgzLVyRK7yePfnO3bKb8RfqoCWqhOavGUvgu6vD6WiLYyyai6D0pMcvVR2/PpGnpJ+D2XGUjiXhxDFKF/eRCfYkGxT4bIYlKZPCa5Awfjegt58it4VYfrfz8FV9X2VDIWRRArpfsxKWFvsvmM/j95oRV9pbOZ/eyRe/vmpmFyUAqr6fDoGRlKqvyWOGAWUtT+r7rUetEIz+MNYZTqxR0xBc5muD10AxKJf8xW+TjE+kkTEZf+m383+qDBLt5XnUtXyZHVzy/t3ZtdixtVFLz8/8diOVhc0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57xay8GsS3KBf77ZaWbVLfrzg9LziV8JIiWx6TPSX18=;
 b=L5iU6Y0J9r6RP1lFsBovrJTFmcWuXz+/zYmDh8co2GnkHfwnalIg+jeaYvcYBm6s/7hjgL2f/xkOTuifHx7xCVhQEyFABfl8hoJBo1Ql7jIterBlQ/AQNfXEMMHgr4cm+NmgYV6GCYQcgFlMF4ApsLY5ORzL+wkCKKNoIAcu9WpUoWXQLWiVYN8bgMfIoSRLv8DFKr5uAu+ZIWpinMDfPQLzozDPuDGd2Y9X0ZKJwQE5dfoOcXrlPd47/FofoBxpCspY6s9y7JfG2EVwlHcRCxnJxU4bLbEUwgK2XA4+O7PCdMfHk0/A9IbHcDvjLa/RlX8byAlwo7efWOZ+zdTOvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57xay8GsS3KBf77ZaWbVLfrzg9LziV8JIiWx6TPSX18=;
 b=N36YIxZ5u7E6CddhDLx3w3Ychk4HNYT2fixI5NSIrdv5nKE6LME5dFJzQCO4oPs3vU5XsoneGkSgHkRqsQlmRtH9Z6bnm0c5HSA92swzUb3oEn+FAgOFj+DIvSATLAwpEgmUFMpvb/6Pg5HgdbTbSZgcLzCiWNxlljTuIvMFY88=
Authentication-Results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB5836.namprd10.prod.outlook.com (2603:10b6:a03:3ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 17:37:19 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%7]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 17:37:18 +0000
Message-ID: <1500403d-6aa1-3909-d44f-b33c1c1f3ce2@oracle.com>
Date:   Mon, 1 Nov 2021 10:37:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: server-to-server copy by default
Content-Language: en-US
From:   dai.ngo@oracle.com
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
 <a009cbf3-cb83-b7c8-aa86-2eee06962b68@oracle.com>
 <20211021140243.GB25711@fieldses.org>
 <78839450-8095-01ae-53e8-f0ebf941b5a5@oracle.com>
In-Reply-To: <78839450-8095-01ae-53e8-f0ebf941b5a5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:806:23::35) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.39.219.222] (138.3.201.30) by SA9PR13CA0090.namprd13.prod.outlook.com (2603:10b6:806:23::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend Transport; Mon, 1 Nov 2021 17:37:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f2b1cbc-0924-4351-adfb-08d99d5e40a0
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5836:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB58360C1FB327FFCD9A00FA3C878A9@SJ0PR10MB5836.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWrwiHwLGkYXK9rzeeP05BT5Pl9i81mwwe3KgGgh6TD9ruglPJ8EmWysKBig90eb0C6lTl//eOpBJhmRHYQJAgl9pfEYtRnzLZChL0mlibYcAT4AMB/nEJkBewrdRdrLUtUn8d/iYRBI1wSCC9UiJF3a6ph6crJsjMj58Veut60/8PaFkE4qNn2gkbcxBWvCggn2tAnp6zSGNOjTHZVEaO5RpsC5I1WB5LSrOjZ5Ep8iv1NU5HizEBWLOPzjyfuexYi5kPZ8F9YrOjJr4rmZ5b1lOBHbRu/ippmWIe1OPyKcckAtcUzWwwndrigCkOKHTbwv6KVTC4OLp1pCr4F6rrGBoKx8oANBayfPQObzcvmp8Kj/t4pWIhB8mjqozSDDZwhH9w0whLvFtQgj1iviZkki8xeboXQg/avEpX0OXXaLLjhmhJ7+JG5npjapovmiRkSWAXVoNkLnBTuT0CRFq00XNy9aGDBGvhhMii4CXhutsw2VfhGB094pzTjgS2xbNc8z2XOOQpK0YWYVsfqqpD4J3qEiyTxWZItGyYMKpi+9+nFZevCV9/XmbnERcRHp5UaZaUqK1Qf8tNLDvMcC3vrqUJxicq91Zaeocu1xR8siY6boaS7Lq5JKxMj9hegEneTQu0LCrqkaLzpqoQFBqfab2v7TDfI5BtLDPqufzEfLKlaM9zYkdnF+neqGCDqI4o/h8BN88s16aG4zjqnR7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(16576012)(4326008)(316002)(186003)(6486002)(83380400001)(38100700002)(5660300002)(66946007)(6916009)(6666004)(2906002)(508600001)(86362001)(31696002)(31686004)(8676002)(66476007)(66556008)(956004)(54906003)(26005)(2616005)(53546011)(9686003)(107886003)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekJTS2FORDdXZVhYbzJlRG81YUNGeUM0WUpVQWRrbVNlU2NJR01EeFZ5TDRE?=
 =?utf-8?B?ZUQ1TWFWVHRYK205Qk1ENU9uMVlFMldYUC9sZGdnWExOeG9yZ1FVUXBTa1R3?=
 =?utf-8?B?MzU2b2hsL1hoRm1jZnc5VFhkQlJHWWc2ZlJHekdySjZ0cUl0dklQMGdRSjNm?=
 =?utf-8?B?ZDNHZ3FsQUlzaXQ0c2NXUlpMS2FBelAzNmsweGpoUnEzMU9zVXVSalRwVEhZ?=
 =?utf-8?B?cloxYlF4SmtaVVRGczNhVzhUOUYxb2NjbFpsWlNvVHltaVg5UXhXU0RwSWp0?=
 =?utf-8?B?VForeTNDdVpFZCsxcWIyNm9xZCtMQUZJRGxHR21uSTdZNElEbi9wV0lKR2J1?=
 =?utf-8?B?TGVER1ZnaXFnTUlUWG83VmpBVmJBeDFWVnRvTVlNTU5tTVBMamdGWVQxZ1lO?=
 =?utf-8?B?azQ3L29aTUVJVm9SQlNaYUZRNi9LUDFIOFdLc1hQZjNBKzR4YkpPbTZUR0dw?=
 =?utf-8?B?bVZGbEpiZEFlMit1R1hUdjB1elNqaEcyamYzNXJCcHpzZ2QxdEMvWFZRNndS?=
 =?utf-8?B?ckdtSW5ZRC9reTMrVEtXcmw5TTBTaHVKQmVLRVp0bTZjMTJsZzR5dkNsMW5G?=
 =?utf-8?B?anFuWGxOOWJnOXIzS2tBUnVaRFhuNDlFNzltcENUTmVHRlRYOW5QZlJ6eW0v?=
 =?utf-8?B?NjUreHN4V3JWSzhENklicXNIdCtuK3lRcHhhaG9nMEgwa2JIR1pzeS9QYXMy?=
 =?utf-8?B?cVlvdG5ZOWVPZTFac0JlOUtZbWNFaHI0MjZmYlIxbHphb3pNWlgvSDNQTFF3?=
 =?utf-8?B?Nm8vcVB5R1RHaEg3amlmS2liOWw1ckMrck1vWVBHNXRiM1VCcjZ6aXdNMFha?=
 =?utf-8?B?ODZSblZURSsvNTRXblVkZnZXeGUxN0Zwa2RZRGxWcEVJMGtOR2NqNlR0elpk?=
 =?utf-8?B?bUExNkJVZGZsVGsvMUV0UzFLazhyY1FkdUhYMEw2MDI2cFZ3M2t4RlRiWmIw?=
 =?utf-8?B?bm1sSjkzODgyMTZvR2pHNEhSOXRsU2ZtSHp5NTNsNlNLbW91dERzekJWL2w4?=
 =?utf-8?B?aFlEdDNNVzdDS3hMcmZOckk1UEZFcTU3cXhkazJsVlBHZ0RuNlNnbFdTNlNn?=
 =?utf-8?B?andYVjFTemwwZDc0cFQ1ME85azJpOTFaRlNsdURURTFFK3ZpcW5zamd4VUpw?=
 =?utf-8?B?WFo1K2w0NTVLdUVUVkkzYnhrZkd3RlBVL1A2OTRKSCt6U0NRc1o4akxxamRn?=
 =?utf-8?B?WmVUWG9BTU9iVk1MTlFUOHJrNXEzOFZ5NExmbDd1Rk1JWk41c0tmQVhodHNJ?=
 =?utf-8?B?WXFsZlJXZFpXUE5KWjUrcVY0Sm5nN0xoVWRNaWtOQ0xHc3U0RWh4cW51U2dl?=
 =?utf-8?B?YTYra01wTTU5UWhrNkYzZnBLWUU0TEZiTGQrNTFKc2hiTUVLRmtJUG9EQ0ht?=
 =?utf-8?B?UGVOZW9ZdURDZUtzb0VQenNrTXVYMjBRWGxWcWdDWHp6aHlJc3I2ejFORmps?=
 =?utf-8?B?S0c1NjhQV21TUlBqUUpXU3E2TXVvZlJuYU5uRk9qMkpQanZWaS91L2w0RUxr?=
 =?utf-8?B?bndpdVA5TFhTRDNpcURvcENRdW9RTEZWck0zaUxJaDVLcExOZ29pdzdsL1BV?=
 =?utf-8?B?SG0xL3NJK3VJZWVURk04UGZRbGduZkg2NmcvT3F5RFRUN2phM0ZxWTdrTG8r?=
 =?utf-8?B?d2FndmhvV01KbnRESVMxcDN4MUhTZ28yZnB4VktZOEFzYzJ0U1REQ1hnMEl1?=
 =?utf-8?B?UVNheUJLUHVXdlR6SlZ3L2dsL2FLZUtZbjZHM242THpiOW5sV3ZTSytFR2p6?=
 =?utf-8?B?NTU3YVhDWjd5akZ5elZQbStzTzQxS2ZWZ3NxbmJSSm1QRFZ0TnRsOUR1bDBy?=
 =?utf-8?B?S3VkVDhJVWhTNU5MVEQvNXEwYTVzbVpEQURVcFE1K1NabHhJb0dPOVJFL2M0?=
 =?utf-8?B?NTB3RHg4M3RjV3FoQXVBUVAxWGJWV3JJWEdsbHFOYkt1Y2RZUVNsSGhxRVVW?=
 =?utf-8?B?Um1pMlM1RysvTm5xeGhNTTVUQjNhK3RGQjBZcjR4Mm9iT3JPWHQvWlE3dzZ3?=
 =?utf-8?B?UXdlVmtHdVBoa1JuZjZBR2RuZUl3b0JKZ0JCVTd1NmdHQmZrTTNZYXdqYTRp?=
 =?utf-8?B?cml2OHg4aE5JdzB6M0tTbVNmMEVTd1d5RHhQeFB2RS9wSUI0c1VyZXFGK1JH?=
 =?utf-8?B?L05WbFR2Y3JneGdvdWNNdmhKLzIyd1hkYkZ0MFEvYm9lVlliRGlpSmNaTWNH?=
 =?utf-8?Q?h/qV2i1AyVoW4Bqwan2HZXU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2b1cbc-0924-4351-adfb-08d99d5e40a0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 17:37:18.8445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AGvXDiCodIxrJn2HB/+e+vWz7uuqJ1nCF1qYfQ8zmOgjIUI9x3PxImxfJp5KRMsyEEkZS8hoFf9njK5qKMU+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5836
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10154 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111010095
X-Proofpoint-GUID: xS7l4lxpNGbwwqZkqayTZ4kt4UMdStEj
X-Proofpoint-ORIG-GUID: xS7l4lxpNGbwwqZkqayTZ4kt4UMdStEj
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 10/21/21 11:34 PM, dai.ngo@oracle.com wrote:
> On 10/21/21 7:02 AM, Bruce Fields wrote:
>> On Wed, Oct 20, 2021 at 10:00:41PM -0700, dai.ngo@oracle.com wrote:
>>> The attack can come from the replies of the source server or requests
>>> from the source server to the destination server via the back channel.
>>> One of possible attack in the reply is BAD_STATEID which was handled
>>> by the client code as mentioned by Olga.
>>>
>>> Here is the list of NFS requests made from the destination to the
>>> source server:
>>>
>>>          EXCHANGE_ID
>>>          CREATE_SESSION
>>>          RECLAIM_COMLETE
>>>          SEQUENCE
>>>          PUTROOTFH
>>>          PUTHF
>>>          GETFH
>>>          GETATTR
>>>          READ/READ_PLUS
>>>          DESTROY_SESSION
>>>          DESTROY_CLIENTID
>>>
>>> Do you think we should review all replies from these requests to make
>>> sure error replies do not cause problems for the destination server?
>> That's the exactly the sort of analysis I was curious to see, yes.
>
> I will go through these requests to see if is there is anything that
> we need to do to ensure the destination does not react negatively
> on the replies.

still need to be done.

>
>>
>> (I doubt the PUTROOTFH, PUTFH, GETFH, and GETATTR are really necessary,
>> I wonder if there's any way we could just bypass them in our case.  I
>> don't know, maybe that's more trouble than it's worth.)
>
> I'll take a look but I think we should avoid modifying the client
> code if possible.
>
>>
>>> same for the back channel ops:
>>>
>>>          OP_CB_GETATTR
>>>          OP_CB_RECALL
>>>          OP_CB_LAYOUTRECALL
>>>          OP_CB_NOTIFY
>>>          OP_CB_PUSH_DELEG
>>>          OP_CB_RECALL_ANY
>>>          OP_CB_RECALLABLE_OBJ_AVAIL
>>>          OP_CB_RECALL_SLOT
>>>          OP_CB_SEQUENCE
>>>          OP_CB_WANTS_CANCELLED
>>>          OP_CB_NOTIFY_LOCK
>>>          OP_CB_NOTIFY_DEVICEID
>>>          OP_CB_OFFLOAD
>> There shouldn't be any need for callbacks at all.  We might be able to
>> get away without even setting up a backchannel.  But, yes, if the server
>> tries to send one anyway, it'd be good to know we do something
>> reasonable.
>
> or do not specify the back channel when creating the session somehow.
> I will report back.

We can not disable the back channel of the SSC v4.2 mount since it might
share the same connection with a regular NFSv4.2 mount from the destination
to the source server. We need to be able to identify whether the back channel
request is for the regular mount or the SSC mount and if it's for the SSC
mount then drop the request.

To differentiate back channel request for SSC vs regular mount I plan to
do the following:

Mark the nfs_server of the SSC mount with with a flag (NFS_MOUNT_SSC)

When a back channel request comes in, we check all the nfs_server's
that share the same nfs_client based on the clientid in the request.

If there is one or more nfs_server's sharing the same nfs_client and
none of them is marked as NFS_MOUNT_SSC then we allow the request to
be processed as normal (non-SSC case).

If there are multiple nfs_server's and one of then is marked as NFS_MOUNT_SSC
then we allow the request to be processed. This is because if there
is a regular mount from destination to source server that means the
source server is already trusted by the destination's admin.

If there is only one nfs_server and it's marked as NFS_MOUNT_SSC then
we drop that request.

Do see any problem with this approach or you have any suggestion on
how to handle this?

Thanks,
-Dai

