Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B805754BE
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 20:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbiGNSO5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 14:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240559AbiGNSO4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 14:14:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41B767CAA
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 11:14:54 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EG53Av006431
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 18:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rmwIZYyBwetEON4FHUrHSfoLHXwoEQFqE+FTxj+CV8U=;
 b=wp6c/IRWEfR6k54xbfnYw25Lzm9w5WNZL+sXpitIjatnahfr/gRKjd2fk1kEe06vxknT
 eimt74DJitcZ+h9SoDzIbebXd3LbpUc/7RqCgeAQAM89G7ocgsUSkBRxU/GL4j/etkrK
 0YegHJHxB7fvjCXB3S9EzAvx93YW7PPNxNkWBM0rJDtfcnuarDmF1nED3E6uLgvg6zLN
 e9CbjgvAABsmIIGcXWxg7L/OsDBHhFAy6OxrN2JRDYsEaIJPI+ich0GQPFVZKOApPVRx
 pI7uwDYSlj7sBOD7UGzsxU+ibspAzV0HVhpOs2TOqY0ZNSzujQzMXt3AVlvcNqQ4B8xF VA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71rg5tnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 18:14:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26EI6nKI013641
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 18:14:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7045v1am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 18:14:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZM+WmYwUk+msKo1RMzfAkUQfUttaSPvB5Vq7nr1V2nILPYEJhN+AmOd+sOdtYnk+rBmm8wll+78erX37rTWgerPYzzG9h6soZsF/f4K3ya/xIffzR4PW+waXZ7lwDgbFFYL51gqqamj5Zpdjv7yCqFjkCMqIE4q477RB7Mk3sUbUFO3jql8puoHm2K8BuS6ZXMkSEE7Wj+Omo/73pA/bXw7YaAab5As+BEj4T/fxj1uzVY/Gp4j428HWBhAqSeSTVB81yy/Z/N/885aHKOx1x6xD8Hy71nxy5JJysYr4xfD7WpksFgseZ5HYoQiDkwz8mqkp5XZmuRC+SVXDeHIUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmwIZYyBwetEON4FHUrHSfoLHXwoEQFqE+FTxj+CV8U=;
 b=JWHPonVQAvenAHiJY2lSNPTXSU1yQQkKdnfuc85DLWfnxAH+FHsVrLNiJs5fZq7BrEbgNuOybMpQZrUj0XGSXJVnFYqDzHtm6JtI1OMsd6XMqAYOITCBLV5L8VcLRO0gUxJ92ZtwMJcNfRxIAc+GZPqNTW8NVqkvqXHZ+JChy01KV8NNvVFWkmybXYBkv2QkjqqOeyo0CMAqe9SFbKFcJ1af6wB+nvlmlRkBHnSZHMDkM2KbfO7Jk/5GZrkwqXuwWvYy864BdeSARdvuDZ7Sca1/CIQdPWAjVaC+/xUZX4er+m9LLzCFnKQV3HQc6bUsiFV8+i/FtZQMx7n1Xx7EgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmwIZYyBwetEON4FHUrHSfoLHXwoEQFqE+FTxj+CV8U=;
 b=hY16qlkq1oELCR13UP1Pf6T+5DUjzjtJW77On9/W+3HQzib9o/TuwjsJGzgFqz7nEXCLkYBrbUQhPSzCMuHU4eL5ydZS06VCcKCgxb49jUOyjkVgKXWARQvUFhNfoGC4sz0QucWWti/IEtbTyA2MVfGATj4GyJ/gijLjEYOguRA=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN0PR10MB5047.namprd10.prod.outlook.com (2603:10b6:408:12a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Thu, 14 Jul
 2022 18:14:50 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd%4]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 18:14:50 +0000
Message-ID: <c26f0c8b-2d54-5e21-f276-2eb525c67e9f@oracle.com>
Date:   Thu, 14 Jul 2022 11:14:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/2] limit the number of v4 clients to 1024 per 1GB of
 system memory
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1657815462-14069-1-git-send-email-dai.ngo@oracle.com>
 <86EDD9A1-CB3D-4E3F-B4EB-0FEB3EED37F2@oracle.com>
 <30ec26a2-cf4d-151d-9045-bcc382c633e5@oracle.com>
In-Reply-To: <30ec26a2-cf4d-151d-9045-bcc382c633e5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:806:23::23) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddfa39df-6f17-4b8c-2854-08da65c4be08
X-MS-TrafficTypeDiagnostic: BN0PR10MB5047:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bfzERabHGDc6X29mZCUcRuFnLz4MH85LKXCp9MVUr4p2paMvHFeRrIK3xaB47vhpMKsanBITll70R2LAkhRCpCWFXv6PpLrAKeVWqCbJtXKPH3+BHq99mByN/oXw1PiNoBQv/xAUbltAO1Osu+hTbXkJGOFAZhvpOlcqW6EsZhyEj04W81WaZ4KOTdTY/jp6NDDX5Nk6V9gTuxc/6QnVrGh+Dj5js/Do+Gkf4W7WJ7cEvXodeTIogZqkEuGXo+i1jSlDHhfoGpJDwBI6RDEbCpC99dCQp9FJSGtKS2nH+NXY3uEdVDkcbDtlYxz6rbbJOuiSz84kBZPpm4grcqsq8iL3ZzI5lmnOpX801M0UbPx/P1K97ceto8U5oJYqFplyeHX+x5fQ/qBnMTqqWY5XcWdsmuSgOa1po+sjqYOi3J7JdhMPl2KULO2Q/z66mq4xS2HyeJ2sw7SC1m86UC+FyEOMOVAqmd5S+a5Gu6rCu3lybt2gkLkdSu7DMLH++1GALaqS3RQkcrL2l6xkjPkml8YGVdqtDmovAxmmiVbvCeXJQPkMb0gp33mJ5qZKhZuF6ck2H7VE7x6LcHU0XFHz0fKvyFKcP/dFKQxJhNXDTgOuiqTaBpgEHU5wUYGSk/FUmG1aFwxH6Knsyu3wU7JDcr1OMz6AMnfuAYK5F8b6rsP8/3R3RaAZu0v5AN+EN7PPpWUNQYjUrfpVmVj0ecfa1KUmG9eiVhI6lpWXtpbbEnb9Zga/0PJDr7rzkmLgah+9ZtX5/VBAzU5+lT/w7I7zudUsyR791iotarHUCtdpXGcn0ptpG1/FYUX3/gppmEWI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(366004)(346002)(376002)(6862004)(2906002)(8936002)(5660300002)(8676002)(4326008)(86362001)(83380400001)(31696002)(36756003)(38100700002)(478600001)(6486002)(37006003)(316002)(66476007)(66556008)(66946007)(2616005)(186003)(6506007)(41300700001)(53546011)(31686004)(6512007)(9686003)(26005)(6666004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFhkQjVud0w3N0RwdmhSYmtHNHI5OEwrdzl2ZnFxTGRoZXBhQWRNenBxTHZ3?=
 =?utf-8?B?b0ZYczZZUjRBczArbWIxbEhxdm0wQmljYjFyQ3lIWmlZM1k5emI0eFJHZE9q?=
 =?utf-8?B?cW5Rc0M3NE1ZWXNMNTNsQXdUK1pMTTk5SFB1YnNBWTJrT1BOUjc2M2NtQ1ZN?=
 =?utf-8?B?MkszbEJwRHMxVUFrc1lNWnBkV0RBSTJtMXpzOXgxdThxeDNXS2RHa0gxUmo5?=
 =?utf-8?B?R05FVi9lVnlYOGk5K2ZGS1Y0dnNnSHZqODQ3Vi9jMjhmMFRWNVB0U2gzdU5r?=
 =?utf-8?B?eFZKQndxVUs5RXlWWStPYVUzanE3cUV1czV1ejM4Z09BRnlPdk93WDlPS09J?=
 =?utf-8?B?eVNtSmVRVDBReXphdXFyUnQ3UlR5TG5OMnpDOUtDOE1Hc1RPN0hWSGVrNVJU?=
 =?utf-8?B?bVBTQkdiaFdPd1NnQ1hNZEhEajFOb0Q2eldCMmZkRVlpZ21weHYrZFVhbVVW?=
 =?utf-8?B?RmhQNjVsbHNHZXUrRCtWVWhYVm0xL2dvNHJ5QnZiM0hqTSs2TjhGZHRKVWg2?=
 =?utf-8?B?TjNyMXMvRCs3WGJCNk41ZEI2K3lQcVJaa0lYdzRWdGFNeTBBcy8wOGt3QUpy?=
 =?utf-8?B?WUQ2Y1NUMGJsMCtGMTJWejZOYXVmQ0ozZmpUUDV3RG9lYlhmVHBLODVTYm01?=
 =?utf-8?B?ejE4Q2svNG5iVHp0dnFtaXpOdy9nemhpNXhHUDdxeW1sc1l2ZjZPSDZCOXp0?=
 =?utf-8?B?WG92K1dsdzBuWkFaQ2xLM1U3ZFBSZUNRbXg1NkoxcFpObitTREZhS0pDZ3V2?=
 =?utf-8?B?bWlGcllZNE5HT29abDViRzFGRkVMbit0bzAwWmY4YU8vSGNDTjFad09ld250?=
 =?utf-8?B?bmw0M3BNMitwT2h2OWF1OVVGNk5GemViakYzaGNlRHZNd3BCVXBPWk81elMx?=
 =?utf-8?B?bzJFVjE3elVOYU81V3Z1TEdWR3RzcXhnZ0pESHRLMnRnbDJ3VHBJZFJaOUMv?=
 =?utf-8?B?cDhLZEkxeVl2citobE8wVkkxMTFSZlg1K1FyYTlSOG9sWmFTeGVMc2g5bTB3?=
 =?utf-8?B?cFlLZVlzWUZ3ZVZqZ0JVS3VaMmZyb2UzRm05d1BFV2FuYXVoOWw1L1BLVnhO?=
 =?utf-8?B?N2hTblZNblpZc1VuNDZmbTVkdFFsZzV3c1Bhcm0yTktPZGc2SWFkVFIzU0R4?=
 =?utf-8?B?SmlYL0ZKWEFOS09WZVM0NTNUSC9iZTBXT2RYUXBTWlJWdCtzQWVodG9pdnl2?=
 =?utf-8?B?dzNwTnBSS3FOZ1F4R2RyclhrUHFXbHZrRHUyWDdOWW43TTJMNmVTdTBYMVZz?=
 =?utf-8?B?bEtKWjl4Z0c0U0JZcUYzZTQrNWRMckhpL2k3NmNBTmlMUG9VTk9RbW0yYzAy?=
 =?utf-8?B?TklBVzdiNFdDQ21nTENCUXRMWWo3TWlQNlB0bmtyYnhLT0lPZEJTc1VZSFp2?=
 =?utf-8?B?Mzh5T2lld3Jzdm9qU3AzNWYvSVBvL2JjNVFTdTBldW5QNmRVQ25ncmdEQmdo?=
 =?utf-8?B?YzJhaWU2bEpSNWZRbkVkNjIvc3g2d3JtUTVtaFZTRlhWR3hoN3M5M2lTN1hS?=
 =?utf-8?B?TmRCdzVTZ0JZckY5c1cxTG9iY3BOdVcyRVRla3VQMVNlSUxwZDhqNlVxNHJz?=
 =?utf-8?B?WGtQeng1aTlOT0tWN0tUTDVEeWUzYkhmeHI3L0ZQaGFQek1KaTFsb1VxK2Zk?=
 =?utf-8?B?bEVJQ0RKRHdYQmpiVXdwYmFLdnArSlMyQXdLQnVpUnU3NmF6N3hUcWVuYlQx?=
 =?utf-8?B?a1BvZFpqNHJyM3hKVDMxbmVrUmVBU0ZnaW90dVJhT2ZQUUVsRmV0Qzh3VjBY?=
 =?utf-8?B?eHNSRFZ0VWVrQWtGc3M4eEZaN2t2MXVCUUp1YWRrWi9HeW9TY3E5czNmbmVF?=
 =?utf-8?B?M2JDM0JNelE2cmlpRW5nR3htQzU1c3crdVdLdjYzendkU0JmeWh5WVFMTk9z?=
 =?utf-8?B?SWxnamtKR1d1b3VmelBrUW5kNUlTWEdkQWs5WWprUlpUMG5FSTZnSURyTUhi?=
 =?utf-8?B?c0VkR1l0ODV5Uk81SmNsNFZqTGNYMVpsdGZyM2NoS2hES3M4bXRKN0tvM2R3?=
 =?utf-8?B?NCsyd2NWU1VVc2oxWWtzdU1tV3pPRW5ZVFJsTUNqQWFhalRhT0ZQRGhtaUVC?=
 =?utf-8?B?Q2tUV3djV21YMmpSek1iZmR5MjZjbnlENGhWSUtsSm1nYjdFTU0xeHVSYWpS?=
 =?utf-8?Q?3XRrg4/ZS0X+0fF9lrOdKX814?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfa39df-6f17-4b8c-2854-08da65c4be08
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 18:14:50.4109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QUBn0A+bhq9uTPKamfbqwbU6iC6YW6FfcGQWEzke4dOO1g2yd20IkAu+UUq6LlDBJhoMHXnEIZ7l3UIV3yWrFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5047
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-14_15:2022-07-14,2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=926 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140079
X-Proofpoint-GUID: _aXIlVxtm5Dpdt60qfg6P2pdc2DUXSAg
X-Proofpoint-ORIG-GUID: _aXIlVxtm5Dpdt60qfg6P2pdc2DUXSAg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 7/14/22 10:56 AM, dai.ngo@oracle.com wrote:
>
> On 7/14/22 10:18 AM, Chuck Lever III wrote:
>>
>>> On Jul 14, 2022, at 12:17 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>
>>> This patch series enforces a limit on the number of v4 clients allowed
>>> in the system. With Courteous server support there are potentially a
>>> lots courtesy clients exist in the system that use up memory resource
>>> preventing them to be used by other components in the system. Also
>>> without a limit on the number of clients, the number of clients can
>>> grow to a very large number even for system with small memory 
>>> configuration
>>> eventually render the system into an unusable state.
>>>
>>> v2:
>>> . move all defines to nfsd.h
>>> . replace unsigned int nfs4_max_client to int
>>> . kick start laundromat in alloc_client when max client reached.
>>> . restyle compute of maxreap in nfs4_get_client_reaplist to oneline.
>>> . redo enforce of maxreap in nfs4_get_client_reaplist for readability
>>> . use bit-wise interger to compute usable memory in nfsd_init_net.
>>> . replace NFS4_MAX_CLIENTS_PER_4GB to NFS4_CLIENTS_PER_GB.
>>> . use all memory, including high mem, to compute max client.
>> Hello Dai, I applied these two to NFSD's for-next branch for early
>> adopters and other testing and review.
>
> Thank you Chuck,

I forgot to mention that I will prepare the patches for
pynfs to deal with NFS4ERR_DELAY on SETCLIENIID and
EXCHANGE_ID.

-Dai

>
> -Dai
>
>>
>>
>>> ---
>>>
>>> Dai Ngo (2):
>>>       NFSD: keep track of the number of v4 clients in the system
>>>       NFSD: limit the number of v4 clients to 1024 per 1GB of system 
>>> memory
>>>
>>> fs/nfsd/netns.h     |  3 +++
>>> fs/nfsd/nfs4state.c | 28 ++++++++++++++++++++--------
>>> fs/nfsd/nfsctl.c    |  8 ++++++++
>>> fs/nfsd/nfsd.h      |  2 ++
>>> 4 files changed, 33 insertions(+), 8 deletions(-)
>>> -- 
>>> Dai Ngo
>>>
>> -- 
>> Chuck Lever
>>
>>
>>
