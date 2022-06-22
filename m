Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3D8555341
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jun 2022 20:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiFVS2X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jun 2022 14:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbiFVS2S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jun 2022 14:28:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD95193C3
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 11:28:17 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MFabZk021340
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LdJpGRFjjK6N+KAIdyACP7sv4tqYIBwEgX+Ypp5T5bY=;
 b=yXjb1McBI3PYaCPebG6OuXJd0rT8w6p6HxsnR0AGahfi/k7zbGaQYf1gskE6KmzTqGjD
 4EAo0E+XHZTyWn5k2v8rVadQDQp3E1IFh7lAHNyr11ftoyflL3aUXqXRAm78nauOXKVy
 2O0ISglAmvpqvvzckotd7JKw+5UscdsJtIc4KntfsAvYyM/Cn6xnbwKG3Wz5l9EP2Psl
 LqzpS9kFtISqFi2NF/oTdgu5VES8li/IrBsgun8a0AFW+52cUuJuxy9lOewOUBFNGeBl
 3U11JtHtN9XcGRWW9HgmUIpx42DeoUdV6Tfy1Avt22U10YhBYyR6lEziOFX/BeVIi8wg gw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6at19r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:28:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25MIK1VT035066
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:28:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfvwgp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:28:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfPf1QnnymLGIZsFRP5C+TvAP31gGVM72Ehn/hFqxv4TlDY4UMf7lbYYoyZttyn4gl7dRQUhFw5aMGW+E5JkxDLBXg3SMIFoyXO7+XTn5JLZJOAkIKvw8a9Q4UPauCjwN+xnWhYqR10nSPDfQfdOAzXTjV0shvJ+KNEEC5j7rb7gMM33vjEomXCeAbfUs3MX4iTTsCAsEO5MeSmyvtxouWNwE5XUtSlMu+a3q4IT7zqhZXvlc1p/D3RCd1Tc+qXJPhrqzd98JBDeYJZE4R9NGoyrS6dd/eMhUbJ+P6pAm7JSi4XROlcTrivCkETgQ7XJpgUnA8/ogGAH1ysv5bPF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdJpGRFjjK6N+KAIdyACP7sv4tqYIBwEgX+Ypp5T5bY=;
 b=foe27UCV/fLY3ysrauaFWDSjbkKk+Usv/uZnYdFobiPcvzZV1h/xEBDTCLuqECfrTubVIzYcBTX/8c1wPCIlVt2CkHs6gbPhxPYr9aISSmNCLuyy4kEbs9op5FwIwGemXrHqxDeMXbHIg2u36ZamRaVZJIJ8nsDFWDLWIDzdtF6a7NjnkuK0DF3CH0XNPmd+SoNJ0HshemvXaDaeQ+5Rz0zMA+n/KnoXKuDmgrYKcUh/BMMclRHMs/v6qOqEZD3lzLzdiORGV/jwUkbKHnpUzFITKoJWLkticF33bdlxDMT5QYlA4kHETu+IJjDUs7qx6KQJ7znlj+S2DAjBBusCAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdJpGRFjjK6N+KAIdyACP7sv4tqYIBwEgX+Ypp5T5bY=;
 b=Z8dRjb3mYue81fA60pcXGMv5Vgcdsp6UuYis8WxUZ7Bekdk5VO1N/OILYElPZsh5CCxTq17Z5ZlSyKjumeuAbo7poy96IGdgrsufDqg/vjW08lSa5fTocIYylG9P4Pw8rfolu3rKxvauEQRhNyeSXnY7UKVtemNaJh8aM5NXkl8=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DM6PR10MB3596.namprd10.prod.outlook.com (2603:10b6:5:150::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Wed, 22 Jun
 2022 18:28:12 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a44a:1596:2b77:2199]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a44a:1596:2b77:2199%5]) with mapi id 15.20.5373.015; Wed, 22 Jun 2022
 18:28:12 +0000
Message-ID: <52820d99-48f6-f56a-fc00-3cbb7fa07f8e@oracle.com>
Date:   Wed, 22 Jun 2022 11:28:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 1/1] NFSD: Fix memory shortage problem with Courteous
 server.
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1655921718-28842-1-git-send-email-dai.ngo@oracle.com>
 <27586B46-7926-46A7-AFF0-4E0F322B4225@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <27586B46-7926-46A7-AFF0-4E0F322B4225@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::19) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d12767a6-08da-4cfb-d88c-08da547cf729
X-MS-TrafficTypeDiagnostic: DM6PR10MB3596:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3596C83511C1238CEE12484887B29@DM6PR10MB3596.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61Xe9aq7fjEwADNRe/RLlO2CZAQdMILWf5IqSpZsaUGVhbfy20eD/B6smcjHSJdNK57RzsxNCw2UlQA5wZWruDV1NqfOKPK7jnOGuJ+fKG5+Geec8qqeWf+UrpdNnDMYZJpfrDMrvoH86KZ7qV4yWf0/+QoDZ4p0IMT11bSd2ZK5+42cpRLo7HgSX1tWn3tGJVAlJOMOOnjsaZ1IL3N0gjh6VsGvIHq55XalI7Xs8ezhQLbcgujfrx8m9ahUiXgtvGOP+4WicqUQOThHy92pmC1w+S0QSQdRjXZvzhXQ2GxG/Jw3XniVrelmUTIe9CUmn1t0A43Buf/lcATUgtAdX5Oz5GlFIGm581pE+OIXLuAnAUARTLy6I1gFL+amXFi+KdYspnJyU0IyldVa9LNpovYdEhErtCGIqeWjMbkbWyv+qMkhsMn6gQGuWOL/qW1LnaVIs20ru4AfZHYk2lG/ccgu5eWOzp0obl/kQmfobljZ9GWYE0yTB6H6r+9oDCdhUIqEjUL2mNGpGBwEIQ1XIJEYeqSg62txTJgu6xw+x6nOadhs1nr87Md/47tbeyin92Q4cyn80dTjoZDAabTOtN8RWfJjeMTzOgZNjjhoEtosUz4fHxo8YZQtX1Jt0En0vFkDoKQTXnVu+ILHfkgu6wKpTYwoadGpaM/FwgO9GWNpwNqdIK/HN3URGQiwM+z60saFjJzu+2W/2NXBfsHrgDaxnMzpdebG6bfvvWG7FTP7wcQKlmBzjfjri/Xf8Fd1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(376002)(346002)(366004)(31696002)(53546011)(41300700001)(38100700002)(186003)(2906002)(5660300002)(6506007)(26005)(316002)(83380400001)(31686004)(6512007)(9686003)(4326008)(8676002)(37006003)(6486002)(8936002)(36756003)(66556008)(6862004)(66946007)(66476007)(478600001)(86362001)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1lSMlhuU243alQ5aTJUZjU4SjBPMW5YdC9iajc0Unc2ZngrUEtHVnVYZFJL?=
 =?utf-8?B?REtMYm1QeE1MWDNRTkUrNDc0NUlsNEoyNWxtR09Mb1FRZ29zeTYvSVNFTGJy?=
 =?utf-8?B?SVBFSm1KMUxBWExnbVd1UW95bnpOcXBlVHR1dXBlaVlsb0JLV1k1dytGTTFO?=
 =?utf-8?B?bmpMUGRxeHYvbDB1dFVPTUZ6RVNtWEp0V212NG5VNmFFRmVKZXNNUFozV3Q5?=
 =?utf-8?B?VW5xZmN5RXlBelJxZmVUQThNWVBwbE9wUzNaYzBpL1lER1ZybFdMV0YrMU1L?=
 =?utf-8?B?Um5KSVlpNDljTExtM0xreHZxOTU3MGxBNFVIVGN0aGFTbVl3RVE2TlVtM3dR?=
 =?utf-8?B?MmpoSnRKczg2c1l6ZldMS3d0Tk5xdE1RcnZudkI0RXpISElMeHBMd1ZLOFNP?=
 =?utf-8?B?dHdmRXMrYmFyVUNlbFVpNm5oOXluNk5TSVhjVyszTnVLWXZkcHVDcHNBWVdR?=
 =?utf-8?B?blhOTWhBQ2xSRmdPZHdDVGpHdllRa3NVSFJiWWV4RWljTUxKQWdLWEFKR2d5?=
 =?utf-8?B?eGVaWm16Ni9hSm5tdTZBanN2aFNHWUtOR1BLdzJlaVlPQUw5Sk5aTGpNKzhY?=
 =?utf-8?B?akRTOU8xMFVMWmJtblpmQVd1OFh2UG40YVlaSmxGMUNPcDNMRDAvZE9vZEZU?=
 =?utf-8?B?WFVvTDdxYnFMcTd5SUIwOTAyalFjRDlyd3lBbUlFdUNqb0tWcmZzNDYvN0Fn?=
 =?utf-8?B?VDRieWY3SDd1Z1pxU1JZNGtmcXgzUWhZSXBzQ0lGZlc0RmxOTlRmU0k0TzhL?=
 =?utf-8?B?S0R5RTRiMURsQ3pVQy9GTDZDWlJQTWRuQWdUY3FVZTdoL05OMndJZERORnZP?=
 =?utf-8?B?Q2ErTGtsN04rL1ljb1YvWW1EbVkrQWc5WW5UR3BmeUxWVlNFS3Q0Y1lsYXYy?=
 =?utf-8?B?ZzFHVHpuVDVHRDlXVFJNOVR6MCtwRWNyRUd4RHVTZ2UzUVdVNEhKRjJTN2lO?=
 =?utf-8?B?V0VVS3BJdzkvbTVHalRndExlV1BrTTNsS1BrdHBlNjR1cnRmUjlFMkFKVFZn?=
 =?utf-8?B?eTd5Mk9udkQ5Zy9sMjlxSUcrUTRLWm9vZXZjVEFjWUd2YzRHMGc3by9vb1Iy?=
 =?utf-8?B?L0hEdHZSQ3pQV2RXMmRibW9PQzZHempadFdXcllsMVRhVjlmeER5ZUQvYU42?=
 =?utf-8?B?Zm55NTRvbjVmM0JjSFRRMUdnSXQzU0NCcWhhOGhwYVQxZzV2aUlVTkF0RWo5?=
 =?utf-8?B?dUo5KzNtQy93S0FtNHB5cWUrRXpEYVo1blRMcEhrOWFYSHEwM1Fna1hGVi9Q?=
 =?utf-8?B?NUYvaDV5WlBFNTdJeFY2Tmg5U29TeFA5V3h3QzMzZmhocCtzZnNRTlFBeU5r?=
 =?utf-8?B?elNkQmxsNTZGQnYzcFJ5MFB0ZUs2SWxETWFBbU0zd3FLZVZ6dXJYU1Q1eE1R?=
 =?utf-8?B?YTVhZy9HenpTbTNhRFo0Rlp4dldwS2FDM21KV1hoWE1ZWEpXSy95cmE5RXU3?=
 =?utf-8?B?MC9tK3E5UVRQa1RNVE9RLzJNUi9MRjUvNWx4N0p0WmcwZXBsQW9UMkwwUG5R?=
 =?utf-8?B?QUZQZWpuWlYrQktPZEg5TjFBVUMwTWRhdWlSZ3N4NnIrOWNyZGl6b1RnUDFJ?=
 =?utf-8?B?ckQ0R0VaT2NEZ2llNW1rYnlSNHJnNVdKSjltenQ0eFpuRkcxN2ZnSnhrT3Q0?=
 =?utf-8?B?aWw0amxJa29mM2Q4cy9kcnFhUmJPb3JtTUVscmdqNEJQWXplOWV2YVo1K0cv?=
 =?utf-8?B?dVBuR2MrM1VsN2ROcEt3Y3RKQSsvRWdUVDNhSXIrQlYwV3A2UVVadW4zb1g2?=
 =?utf-8?B?ODQ2d1RwUmk3cWpJM2dZME1HYnpVaVkyZElpQS9BNHdZeXBHVVY3ZGVVYlRT?=
 =?utf-8?B?WTZCMkRxdy83WVB0TFZqTkt6Mm9mSDc1czhtUEkxY2NOd3ErREl6RE9nT0hw?=
 =?utf-8?B?Z0pXNDZIRFpoM1NmNkF3ZjNrMlo5QUZHbTNvMGQydFYvWGNrbVQzS3JkMjY4?=
 =?utf-8?B?dkZOTHI2T1BQOHhLZFJ6eDY5ZzBCUjNObTNqNHlkdFdyYWZ6VzlIeVdRNVpo?=
 =?utf-8?B?L1c4dnlwNmxESlJqWjMvOE54UHlIWXBkMjB2Z1RROGZyWG1TU2hHSTFnZDRX?=
 =?utf-8?B?Qks1VVp3YXRPV2NDc21OSlJIVE1qTE5HZktZMERUZWlwSFAvV3JUN3ljWFNs?=
 =?utf-8?B?Zmk1ZWtqdVJ6UGd4T3M4b052Vjk0OHQyV2RGRlIvOUU4emdUQkRsYUQzZ2JD?=
 =?utf-8?B?YXpJelJaR2EzTkJRT3c3aEVjQk0rMGhOV2F4ZUE4Nk9GZ2xzK1RJcjhxSUlp?=
 =?utf-8?B?Q0lvZGxjbVF0WXF4TkEzcW5ieDl5TndJaWV2bzZ6SGFndld0Z21DVndUS1ZI?=
 =?utf-8?B?ZVFmYnNDUTRHRlFqc3F6eVpzNzViNTYrcllTVUxjSXh4SzFQNkhQUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12767a6-08da-4cfb-d88c-08da547cf729
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 18:28:12.7145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGX3J4O+3vj4SI6/rmbE+JUiwXGUu0jkkzDSVUaqJm+FoMq6+bNQYZnvf/01mYbhJBhc64qwLiVZ763PfEg3Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3596
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-22_05:2022-06-22,2022-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220087
X-Proofpoint-ORIG-GUID: p6Upu_qUGzSpO9U9h7FI_2OCaj-yyDR7
X-Proofpoint-GUID: p6Upu_qUGzSpO9U9h7FI_2OCaj-yyDR7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 6/22/22 11:16 AM, Chuck Lever III wrote:
>
>> On Jun 22, 2022, at 2:15 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Currently the idle timeout for courtesy client is fixed at 1 day.
>> If there are lots of courtesy clients remain in the system it can
>> cause memory resource shortage that effects the operations of other
>> modules in the kernel. This problem can be observed by running pynfs
>> nfs4.0 CID5 test in a loop. Eventually system runs out of memory
>> and rpc.gssd fails to add new watch:
>>
>> rpc.gssd[3851]: ERROR: inotify_add_watch failed for nfsd4_cb/clnt6c2e:
>> 		No space left on device
>>
>> and also alloc_inode fails with out of memory:
>>
>> Call Trace:
>> <TASK>
>>         dump_stack_lvl+0x33/0x42
>>         dump_header+0x4a/0x1ed
>>         oom_kill_process+0x80/0x10d
>>         out_of_memory+0x237/0x25f
>>         __alloc_pages_slowpath.constprop.0+0x617/0x7b6
>>         __alloc_pages+0x132/0x1e3
>>         alloc_slab_page+0x15/0x33
>>         allocate_slab+0x78/0x1ab
>>         ? alloc_inode+0x38/0x8d
>>         ___slab_alloc+0x2af/0x373
>>         ? alloc_inode+0x38/0x8d
>>         ? slab_pre_alloc_hook.constprop.0+0x9f/0x158
>>         ? alloc_inode+0x38/0x8d
>>         __slab_alloc.constprop.0+0x1c/0x24
>>         kmem_cache_alloc_lru+0x8c/0x142
>>         alloc_inode+0x38/0x8d
>>         iget_locked+0x60/0x126
>>         kernfs_get_inode+0x18/0x105
>>         kernfs_iop_lookup+0x6d/0xbc
>>         __lookup_slow+0xb7/0xf9
>>         lookup_slow+0x3a/0x52
>>         walk_component+0x90/0x100
>>         ? inode_permission+0x87/0x128
>>         link_path_walk.part.0.constprop.0+0x266/0x2ea
>>         ? path_init+0x101/0x2f2
>>         path_lookupat+0x4c/0xfa
>>         filename_lookup+0x63/0xd7
>>         ? getname_flags+0x32/0x17a
>>         ? kmem_cache_alloc+0x11f/0x144
>>         ? getname_flags+0x16c/0x17a
>>         user_path_at_empty+0x37/0x4b
>>         do_readlinkat+0x61/0x102
>>         __x64_sys_readlinkat+0x18/0x1b
>>         do_syscall_64+0x57/0x72
>>         entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>         RIP: 0033:0x7fce5410340e
>>
>> This patch adds a simple policy to dynamically adjust the idle
>> timeout based on the percentage of available memory in the system
>> as follow:
>>
>> . > 70%    : unlimited. Courtesy clients are allowed to remain valid
>>              as long as memory availability is above 70%
>> . 60% - 70%:  1 day.
>> . 50% - 60%:  1hr
>> . 40% - 50%:  30mins
>> . 30% - 40%:  15mins
>> . < 30%:      disable. Expire all existing courtesy clients and donot
>>               allow new courtesey client
> I thought our plan was to add a shrinker to do this.

I'm not familiar with kernel's memory allocation and don't want to muck
with it so I start with this simple approach but I'm open for any suggestion
on how to add a shrinker for this task. Is there any existing model that I
can use as reference?

Thanks,
-Dai

>
>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c | 41 +++++++++++++++++++++++++++++++++++++++--
>> fs/nfsd/nfsd.h      |  5 ++++-
>> 2 files changed, 43 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 9409a0dc1b76..a7feea9d07cf 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -5788,12 +5788,47 @@ nfs4_anylock_blockers(struct nfs4_client *clp)
>> 	return false;
>> }
>>
>> +static bool
>> +nfs4_allow_courtesy_client(struct nfsd_net *nn, unsigned int *idle_timeout)
>> +{
>> +	unsigned long avail;
>> +	bool ret = true;
>> +	unsigned int courtesy_expire = 0;
>> +	struct sysinfo si;
>> +
>> +	si_meminfo(&si);
>> +	avail = (si.freeram * 10) / (si.totalram - si.totalhigh);
>> +	switch (avail) {
>> +	case 7: case 8: case 9: case 10:
>> +		courtesy_expire = 0;		/* unlimit */
>> +		break;
>> +	case 6:
>> +		courtesy_expire = NFSD_COURTESY_CLIENT_TO_1DAY;
>> +		break;
>> +	case 5:
>> +		courtesy_expire = NFSD_COURTESY_CLIENT_TO_1HR;
>> +		break;
>> +	case 4:
>> +		courtesy_expire = NFSD_COURTESY_CLIENT_TO_30MINS;
>> +		break;
>> +	case 3:
>> +		courtesy_expire = NFSD_COURTESY_CLIENT_TO_15MINS;
>> +		break;
>> +	default:
>> +		ret = false;			/* disallow CC */
>> +	}
>> +	*idle_timeout = courtesy_expire;
>> +	return ret;
>> +}
>> +
>> static void
>> nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>> 				struct laundry_time *lt)
>> {
>> 	struct list_head *pos, *next;
>> 	struct nfs4_client *clp;
>> +	unsigned int exptime;
>> +	bool allow_cc = nfs4_allow_courtesy_client(nn, &exptime);
>>
>> 	INIT_LIST_HEAD(reaplist);
>> 	spin_lock(&nn->client_lock);
>> @@ -5803,11 +5838,13 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>> 			goto exp_client;
>> 		if (!state_expired(lt, clp->cl_time))
>> 			break;
>> +		if (!allow_cc)
>> +			goto exp_client;
>> 		if (!atomic_read(&clp->cl_rpc_users))
>> 			clp->cl_state = NFSD4_COURTESY;
>> 		if (!client_has_state(clp) ||
>> -				ktime_get_boottime_seconds() >=
>> -				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
>> +				(exptime && ktime_get_boottime_seconds() >=
>> +				(clp->cl_time + exptime)))
>> 			goto exp_client;
>> 		if (nfs4_anylock_blockers(clp)) {
>> exp_client:
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 847b482155ae..9d4a5708f852 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -340,7 +340,10 @@ void		nfsd_lockd_shutdown(void);
>> #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
>>
>> #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
>> -#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
>> +#define	NFSD_COURTESY_CLIENT_TO_1DAY	(24 * 60 * 60)	/* seconds */
>> +#define	NFSD_COURTESY_CLIENT_TO_1HR	(60 * 60)
>> +#define	NFSD_COURTESY_CLIENT_TO_30MINS	(30 * 60)
>> +#define	NFSD_COURTESY_CLIENT_TO_15MINS	(15 * 60)
>>
>> /*
>>   * The following attributes are currently not supported by the NFSv4 server:
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
