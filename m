Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283365709C5
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 20:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiGKSQc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 14:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiGKSQb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 14:16:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8FB2B268
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 11:16:27 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BGLuUd029608;
        Mon, 11 Jul 2022 18:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bO7fIN1smGBC+7hnBTE2kSa86rOlJhNngUm3TLdRt5k=;
 b=nVkPTzP4mP8BHNlJraqqp9mBioPRI3WOZVnGfcTfS5HyMveZKRkrqW6nAqo9CPlCb5sz
 1bQq5k0hryGdQVVIUlnwozvTQD2BD8OmY/lcz2KwO4Vnog9LnS8HkDPH0O0WzpTXr7FQ
 mBpoCdM6a3h2kmBbrdu04NS6VxuUZJpdKZa8KECS3fWgpUnj/RLmnM0ZgEkqvdEOR5tg
 evdc1e2Ax8ySKG0bdE5AAMoEjJayZw42yiYIZRTtUg7esb9pc3OxgBLOZs2NWV97z3w1
 LkmbcmOto06tQcuE17tAwuyNyXZwfWjM0/w6VInwz2Jb+ZmwWTWciVcLjCWyGK4Og328 rQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r148te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 18:16:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26BIBXif036728;
        Mon, 11 Jul 2022 18:16:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7042h8br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 18:16:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7lY/x/sFnzN86Vz49Qvky0UVwnlSb4xVBP7J7oHG9htsTp4McV1Mt09Nn/sp1L9ihwS/tltNdIAI7od79unxcdMGL+W0o5XLQ5PgHeZT9H/OapXTX3dmtK61xmA7RwI60+ZWuKwtB446mxDF7scEi2hr7eHVgBRcKPSeCFc1Z4fP099NB+c2TRFEIAcApiWa8aUXlw1jbzD2B/BYZZZ4Og1j3ZWtlyKIV5mQyJAxw/cnme9tgxyy9bdepJjeAXEu6biGWZXwAU5n1sOVtWaOwHht9asgq/S21je6FEKKEJX6vUvSWDp+0gSwddcRZCqSdVvGymXNC15z6XQs6HM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bO7fIN1smGBC+7hnBTE2kSa86rOlJhNngUm3TLdRt5k=;
 b=Sw4BGf7mfJiuO8r6wriQu0oLghLt5ytloE2iPsWT56+rDqsQFx3xa36ox0SByiR9OYvbCBWDNsxqEf51iYVMKXDhWvhkO8StaZhQJ36HrnaJ8LFdTWR1yex36RRa/rExGZ9jUaeWichkXCgAEXHV95VghMwVur+REOZ+7PKabQQnGoHipZqi+Ku2q9erleXCOy4mKd6iIyxAYDM+n3BTTVlLOj6aKQCxixxx0bhTNBj9HVAQARDdvq93fl9wD4gaq4J1+1RlIw0aURGxQQMA6Z3CeciG7rNngghh6FW4v5GFjfBoTzAdmLjXsNmLOooKm73Tk+X7HRc1/c2ItsDZ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bO7fIN1smGBC+7hnBTE2kSa86rOlJhNngUm3TLdRt5k=;
 b=bpjLsqFlTEDNK8kyuuUmig1KczZBXWNhcsgby9Z9ycx5Jik+nTCS1GNF8Za0SB3yYb5zHsKJLj0NWgb8pXA9AklU+dB7eGre2nnI7eSBSlWQcS7kzmYRvo68g7rb+kPWSjOuRQX+fXMpnQzBEa+wHnxau8nhu+H8lEw4iIA4dQ8=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DM6PR10MB4394.namprd10.prod.outlook.com (2603:10b6:5:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 18:16:23 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd%5]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 18:16:23 +0000
Message-ID: <9bc4ed9d-1bde-2957-b9bb-11c89c6809c0@oracle.com>
Date:   Mon, 11 Jul 2022 11:16:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] nfs4lib.py: enhance open_file to work with courteous
 server
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
References: <1655314495-17735-1-git-send-email-dai.ngo@oracle.com>
 <20220615193453.GB16220@fieldses.org>
 <d0db9a5c-01f3-2380-20ab-36c1e78e395d@oracle.com>
 <20220711180522.GA14184@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220711180522.GA14184@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR12CA0001.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::14) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43d0f078-7795-4d1e-5807-08da636975f4
X-MS-TrafficTypeDiagnostic: DM6PR10MB4394:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9DtpBo6zua/gP6lorlSr4Wai+MFTM+t+ud8MJvMOg63o4h8DZXs+/hXI461g2fitLOZIgzJ4xVUO0MYE3RsHp1wfK3x9HzWbD+9kwWSRHzOF8owjJGvoIinBwPhA4S0TPl6KQVpHyCJLJ9GuL16gIe1C6mwNKli9BfPlzEAlX5LxM0ak7wv9vfqc+sh+mDtxkUM0iIvYvhE7mSh1nvvarL7bhO0JhUFXcy7qQocq65GGTrNfLuxixaws68SEtIyOed67XH2a9MYNrrDuHU00Hug0p67bkdmw4t3xHX2KKekMPTFXrofG2XOV8+fkQxnadN0asVW83XzQ7HSBMk5jAfqQtuJrG0wr+wJZVlkJ7QB+Nmr/Dj3e7CmFKe4fPUTop4sOLybxHLJtA2HD1GykFFP5g0RpZKgPoHSfXq8TW0y/6l5qIR2G+9brwEc1NTH2XB63i7JDiVrDVs/ll8b/WxT+JaDS9WpwtBYUSMRI18mfWivu7AVQ6Re5vwZKsGn6MPi7ZrWvTqHymVgZ/G60FHXXAmPMx5T+lZ/4QGknXNAm/COmlgpxAMkWfuGlANIMiLrUmDV7RLhFZgTERXpIIxXIrBzZVIwSg06HD/25p4ym1t2t1qmWKUljefmCCm4iutIPPT/inRD972bf5n1LajxipRcU9SxBdjVX7GrD+x3e6soNLSd5HF+wPIv4Vxf7LDaBquFgig3Q7fo2Cg7AtCvMt+bicDJ69QTp4ec9uExCWxdFIT0L7VMz0lvg5BwhrvlsjWUAQPwVYgydbx2xsNa0Fj16Ro8R3WyXLAXl4sd0Xc1PgDMW49W2JSEDODYSKcjXdzFQ7yB57qtyrNM5ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(396003)(376002)(136003)(39860400002)(6916009)(5660300002)(86362001)(66556008)(66476007)(8676002)(4326008)(8936002)(186003)(31696002)(2616005)(316002)(66946007)(41300700001)(6666004)(9686003)(26005)(38100700002)(53546011)(6506007)(6512007)(2906002)(478600001)(31686004)(6486002)(83380400001)(36756003)(32563001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFJLazRVcDhUYytPQUdWblJQNkVlU0dyR2FQRDZxbEJoWjBHcFRVNWJJMm41?=
 =?utf-8?B?ZHhSY2xKdjRacmh3MEQzMU1ZQXVMYjNCMzRBODkyMGtidGhQdmtlUEU2RXIx?=
 =?utf-8?B?K1BldU9WOU5FWTZEdEorNmJYKzkrZ3NuRHpqeVkvSGhWUDJ3MjVYb2tZSXg5?=
 =?utf-8?B?bEJMaGM3Ykh6aVZwWUxGYnEzV3NlOXpEWVZHTExNVW9uUVdYclV3M2hLQWp0?=
 =?utf-8?B?MWNMZFFsOHJqUlFHMlJhbkVURnY2aklVUEF3U09vcms0cjNua21lcHNaRXNJ?=
 =?utf-8?B?cnZpeGhraU01ZXJZN2RRYVQ0MHVHVHpxa2dxa1R3N09nNUxuYzNPSmFXcG5X?=
 =?utf-8?B?YzV2N1VIb0ZmYzhwY1l0dE5OSXBPMUFqZlRGb3J6ZEI4Ykk5aDkvTE4zajdQ?=
 =?utf-8?B?djloa1hFeEtkRUZjRlF4YVdnTzl6U2pCQ0RqbXBnS21jUlVIZFE1V3BpMVNu?=
 =?utf-8?B?UmFlUDd6cElTR0QyT1lhNll4SnRhajEyQkpiWGhOYUlESHEzd0RvSzRSOTdz?=
 =?utf-8?B?bDN6MERFVXdUUURjbU8ya3pnWEZMUmtMMjlxOGxGcmRoaVVHbjBIRlIwU2J0?=
 =?utf-8?B?TWlWU2JxL29BNlVBYUN6UE9uSC9RQkNxU1BPQ3hLN1hEckpUTXBwY2lQWjBj?=
 =?utf-8?B?SWF5OEhXcU0zYWE3cTZ3NEhVekw1YnYxa05OcVNrUlpieks3NjRXMENpRDFs?=
 =?utf-8?B?eHQ1Vk9meEF5bGxYSjBWVWsyejR2Qld4LzdGWWxPK0phSjJnNmhlWGc5TXJD?=
 =?utf-8?B?ekszc1B5c2hHdmYvNm4zRXcwN21kZERWNWxKMUsrUS90RzgrdDVMWHQzL2R0?=
 =?utf-8?B?TDlsRFcvemdDZDM0b3E5RWRDdWFoMlVvQUJ2ZW12OGpaQWFibjhHRytHcy8v?=
 =?utf-8?B?TzJWcVNpdmxtczVTUzhPdUgySEM3emNBY3pUVnMwem1VYVRZSXdBZWVVdUd3?=
 =?utf-8?B?S3paazRnRUUyMW5RaEIyYlBRVVdYSk9XY0F4ZGV0MHJQY3JSMVF2UW5TaDhT?=
 =?utf-8?B?UlFWb3MxYXM0VDdQSWlNei95ZUIyRUhBRFFnL1AzOEdud0VVMnE3dzVZb1kr?=
 =?utf-8?B?Wi9OK1FIY2Yrbkk3ckdTVDJYd0FiV3R1bUpDd1ZvWkk5b1YzYkk5VjgyN0t3?=
 =?utf-8?B?dHRIMEduTnJCQVUzSDVrSVBKVW4wYXUwS1dJMmc5aEsrZ09EdlorVTA0OTlm?=
 =?utf-8?B?OFRXbjAveGx6R0ppdVpLNDhVN2FvcUlINWZTcFRkZURqbGhNbHZWbkMzL25a?=
 =?utf-8?B?VkFkcE9Kc1RjcGphd0xDby9IcUdyN1ZhTzR6N202Q3FiZ1BVTEJJNlV0WGkz?=
 =?utf-8?B?c0FUeFRUQm5OME80YldaSUthYXVqL2VvZk1rTzU5WENpQmhBb1pnVkdpVGVT?=
 =?utf-8?B?VytFbjJkbXVmYllzMVNlYkJrT2ZsL3FZcXptMW1yTUI2RjFCN1FvY1FvVnc5?=
 =?utf-8?B?THl3dHAzK2ZMTEtVZk5BVkN6NlhlREQ5Nk1CY2xXQUYvemZjTjFJdnNTbWJo?=
 =?utf-8?B?QllYTURvd3RWOTFKT1pGa3QxU1dFanRYZEg4bm9YSXludnNTcWVwQnp0VUFF?=
 =?utf-8?B?Y2xEcjZGMENxQmlpL05jQ2RGVmJxTjdUSko1Z1dIbjFweUZwZHBGWFkyM3I2?=
 =?utf-8?B?Z2VENjRZWnhLakduRG5sVmhpMVRocVVtSUV3eDNwb3pab3FtOWVHTmVMY0h1?=
 =?utf-8?B?Y2hNSG0vSHZDU3k5VzZxRHQ0Q0dnUjJNNkt2d3laaGVscEJ0bkJXSnpEUnc0?=
 =?utf-8?B?S21veDZ4eVBhdWx2NjliNEo4L3R0Z1RMQmkxY1JRVEFiTnJXOGRNOGluWkFD?=
 =?utf-8?B?YUs4SVdpVG1iQzVTYUdkK1R3RHlwbGFDSjhLemtpUlVPaEEwd0VRNFNiOGEr?=
 =?utf-8?B?MEt1SVprMGlReHhBb1NFdGpJU2owWmh5VmF2U3cvOHp5bE1wblQ0ci9ldG1H?=
 =?utf-8?B?VEx4WE9WQXF1K01UamdlNlA5bkQ4MjhGaGk4ZEozNllOWHd5dGN5bmpoNERx?=
 =?utf-8?B?SzR2NDg3ZUVOL0ZscTJ5a256bGd2V2kyTHk3Y1BCSXZsRUZaQUtZVVJtQnFZ?=
 =?utf-8?B?bjBDNjBXVEpsRU5HVnhDL2FBSVdDbFJtQXBocTJOcmZsT2F2YWlUVjRwamY1?=
 =?utf-8?Q?7OZaRxZL+5U4d4oJv3Qk5QbO5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d0f078-7795-4d1e-5807-08da636975f4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 18:16:22.9884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2cxYFtr653EdUqN80Sh+pjMRJR0cvjhdKzsMtKTqGBVCrTsd63tahOxqqst0Pfutw5242FUmEroD95OJnM7NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4394
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-11_23:2022-07-08,2022-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110078
X-Proofpoint-ORIG-GUID: ydnAbBG1d7M7W6i9CUKATZ2MPF2MHY0p
X-Proofpoint-GUID: ydnAbBG1d7M7W6i9CUKATZ2MPF2MHY0p
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 7/11/22 11:05 AM, J. Bruce Fields wrote:
> Applying, thanks, sorry for the delay.--b.

thank you Bruce!

-Dai

>
> On Wed, Jun 15, 2022 at 12:48:17PM -0700, dai.ngo@oracle.com wrote:
>> On 6/15/22 12:34 PM, J. Bruce Fields wrote:
>>> THere are tests that want to explicitly test for DELAY returns.  (Grep
>>> for ERR_DELAY.  Look at the delegation tests especially.)  Does this
>>> work for them?
>> Those tests expect NFS4_OK but also handle NFS4ERR_DELAY themselves
>> if the OPEN causes recall. With this patch, the NFS4ERR_DELAY is handled
>> internally by open_file so the ERR_DELAY never get to those tests.
>> All tests passed with this patch.
>>
>> -Dai
>>
>>>   I assumed we'd want an optional parameter that allowed
>>> to caller to circument the DELAY handling.
>>>
>>> --b.
>>>
>>> On Wed, Jun 15, 2022 at 10:34:54AM -0700, Dai Ngo wrote:
>>>> Enhance open_file to handle NFS4ERR_DELAY returned by the server
>>>> in case of share/access/delegation conflict.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>   nfs4.0/nfs4lib.py | 7 ++++++-
>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
>>>> index 934def3b7333..e0299e8d6676 100644
>>>> --- a/nfs4.0/nfs4lib.py
>>>> +++ b/nfs4.0/nfs4lib.py
>>>> @@ -677,7 +677,12 @@ class NFS4Client(rpc.RPCClient):
>>>>                             claim_type=claim_type, deleg_type=deleg_type,
>>>>                             deleg_cur_info=deleg_cur_info)]
>>>>           ops += [op4.getfh()]
>>>> -        res = self.compound(ops)
>>>> +        while 1:
>>>> +            res = self.compound(ops)
>>>> +            if res.status == NFS4ERR_DELAY:
>>>> +                time.sleep(2)
>>>> +            else:
>>>> +                break
>>>>           self.advance_seqid(owner, res)
>>>>           if set_recall and (res.status != NFS4_OK or \
>>>>              res.resarray[-2].switch.switch.delegation == OPEN_DELEGATE_NONE):
>>>> -- 
>>>> 2.27.0
