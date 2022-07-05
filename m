Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9835676B9
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jul 2022 20:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiGESmd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jul 2022 14:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGESma (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jul 2022 14:42:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CE61F2FA
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jul 2022 11:42:29 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265HEWJZ003082
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jul 2022 18:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=r5awqgmGUNaPgy28RQ8NiyyAOANx6HOM5CfEb8mHE9A=;
 b=q5Ist/TsCm4ZELeR8q0tMc1u1FnfW+KLW4vBe2bxxLxvFPDXfMIzE3hlHI0IW83kPL26
 qnWHZyjkJ5DFNzuAWeevWP5kptf3MnajCQXBOEL/eQjEkCax+q6ofXDFsXldQR4KzhN3
 3ZkqEzlUT3262Tl0+iFj7y61b3lAqkNrREf+r8xdsuNX3EASJ3s4h1umKF57Ayr5wCFX
 kv2owVlSgiL5P2hmfo3NqfDwIMGRoC+1ypqT70fNn9lC9sp2BlT2M98h11F6cKFLxdOp
 ky22v7i0V+EnbRhqjX13VlyUZOaOnLE4Ufxt+xj47LTV433cNQSWbfu+3uy3qEGjN3vh UA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2eju71by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jul 2022 18:42:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 265IVDnB021421
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jul 2022 18:42:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h2cf2dkxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jul 2022 18:42:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmtD0lFq54pOqXPydgW7qE8be3eLTlgdrrt+sDqrrGmnCrCFgS/iApZP9cv/sj8TMVPVrF5T0dzYdFcQ8fE6JBlUMUp87388S+D/km4j5wFiXgw8z5RDpKjOaT4Zlg5P+Ap8VXWqIc3ropU7gXfFouRuCD+dsAS30xAmd0E1/hmLfFjLhSpwJxhUBDXiCr5HaJflgNG1ENWuCqLjSP7UYDEk+wU7d+9pKVUSGF3VlkeQd1jkXHjzTf3rHpUyzW4H8Eo8CTHBaW7md0lKsDBEH/uSyO+PhjOq7AuUtelchCLbH2vv4rdzSMgp/ax6fzxMWdzB48fDgzYXGRwiQPYYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5awqgmGUNaPgy28RQ8NiyyAOANx6HOM5CfEb8mHE9A=;
 b=b+2dotfeut1OERcXdrSd/fSNxZN+lFcdZO+kuIHRROGbVrYZ/1mELy91VfFMq84guP1kH3vbf4keAQ5z9tom501PRVOcv5UFXpf481ivX/DowL+GGuvQb+2NtJmaGT4boV/tQzzkTNvdxJqI3lEIErkkgJCi39NtTEqlYHefHnIrw55WNah5lgAzc9j2vj5VOp4gxVW1nnmst57hBaWR1IOmRZ9UbQmAV0kPsEWaEXj29+PHAQec7EedRrdM/IyPMFmlUkwIhL8LjGE1ZzszHFb6zyPeBHD8p83Ekj3OnJV0ap6c+rzxKYFLLQcNf/0I2Sso3erXiBjJ2NNYfyhzRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5awqgmGUNaPgy28RQ8NiyyAOANx6HOM5CfEb8mHE9A=;
 b=rwuOi8Ik1c1NTGCqeiT6XiirsrK+jyFmHl1ZlxSPw1q7Ktfl3E9Eaatk2TOd+l0+4S3InExrvLdSrMu+6m+FSIUrcA9rNd9xJcgjB+6jNGwv0YzH9BDKHA00zuE8E8QqbjE2QFI750aBTFoqvXq5QgdzhzDiDcM9vzkGAWg6IUs=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MN2PR10MB3759.namprd10.prod.outlook.com (2603:10b6:208:185::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 18:42:26 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd%4]) with mapi id 15.20.5395.022; Tue, 5 Jul 2022
 18:42:25 +0000
Message-ID: <61f067af-f634-e9fd-a0e5-4ee70c9e0887@oracle.com>
Date:   Tue, 5 Jul 2022 11:42:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/2] NFSD: handling memory shortage problem with
 Courteous server
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1656961543-25210-1-git-send-email-dai.ngo@oracle.com>
 <3A5C2D8F-0752-4070-9BEE-31D5E5F9AAAF@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <3A5C2D8F-0752-4070-9BEE-31D5E5F9AAAF@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0015.namprd05.prod.outlook.com
 (2603:10b6:803:40::28) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c38ab42-9029-4bbc-12c5-08da5eb61aa4
X-MS-TrafficTypeDiagnostic: MN2PR10MB3759:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5Y/rDsuhxH9MQ5qteY+KOJa3FUkK/zJDa8lW3tFKjPS5v6lyfCi5EixqT/KX/7Dd4RwQXD91cfekG5CAvLHtn/5tvdPbWl7lgSjWrK6o/28+Tm9jockvwzFEdgXFqGPoLyCuEvfYdm4/kz2wewixACv3tIjfthhN+Mid3lOMMPK172yEgQJxXZ+/SsaHTI1t2lAoXrBr7621Taffm/hWNHoZMPgJYU1nUJBbblUyYPvFRMTWmIvDfhpEPi0Zzu51z+uHPVWJiawI89a3nHRFIUZjjGBp0SadFdFzXGE6P8+niqGREmM5j9aIcnrRnmuU0dn8BB3zumxttM6gID2CEm56S291sG+IcZu2nhvq8SwyVXV69+hDYT6e/eMzZSrosZURdanWZNVQ/oCGMw7/7oof0xcnCSRKSljxgv/DXjI3sF7tqdtVvmwIgbPUwPCIVdQ+ch5DmoBxSJAoAjXZFZHzz+2T2Wr7hgiUKIRMfTnXb9+BzViB+YADxg4LXSBE2n0/HQqOZ8bYBjWf8sFdGjJv3dDCYoOxqu0BjyLolFYIl+s8kLADf8uLDBmumZFRj2kW0OKB5GpZR30r+dOPOktGMW7Fu8Mvd+ImswwIjotSAD9nzj7g54kL+x8zGN5JTlLBN+hUqp03t4fjxFSoYKW3IvYOWJr8eNoc0WurjQdgpmOpzFzUt0WkhpXJXwLHDhUKOorN7BSqNgN0ulpDJck7VayDx6EJiRR9KqyKDRt81IEBZb1sDmTuFTt++kk4/wnw2fei0Fsl20W5RJ77yZ0e8vpKssoBa2LxAIB59VJBVT0x618wcbTWnLSTymElKqBYa/WlUwjQk88DrToxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(39860400002)(346002)(376002)(83380400001)(186003)(66946007)(66556008)(66476007)(8676002)(4326008)(478600001)(31696002)(86362001)(6486002)(6862004)(8936002)(5660300002)(26005)(9686003)(6512007)(38100700002)(2906002)(41300700001)(2616005)(6666004)(53546011)(6506007)(37006003)(31686004)(36756003)(316002)(87944003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3FMVTNDdDc0cW0zRU5NTlZXV0FFd1BKUC9PQ0pCSlVneFNqVHJvbTlYU2pu?=
 =?utf-8?B?Q212K2syV0pXQUkvU29RTTdNbXA1RzM2YTZYRzZFOCtQUTRCdVdPS3poYjJl?=
 =?utf-8?B?UXRDaUhqeHZ6dCtzbm1rQzFsaHB3OXd1KzYzcG1nSUlUbVV1VUgyOUlyOWk5?=
 =?utf-8?B?cWw4SFFtZ2lwbU01VnlKTEhzdVQ5Q2Z1UHQ4RXNTbm1KZTJURkh5L2VYOTN3?=
 =?utf-8?B?TjNjTTZDYXIveUVGV3UzdU9CVkdIczZ1eFRsaHJQOFBrVkV2TllVV0hLUTR0?=
 =?utf-8?B?RVFaeU1DUnl0aWgrY0MvNmZsa3BwVlh3TVlBWDkyMys0QVZWeFJlRjdpRVN6?=
 =?utf-8?B?bnRURHRlcitRQkI0cTdPUmpxcnAxczVBRkw4RkJiUytwbWs2bUJURWg5N2Vl?=
 =?utf-8?B?bHVJbTRUYmtzYjJkYTQrdWhZVCtsbUdmMHg0ZnpHUkFBYkFtLzdvL2U5YU9a?=
 =?utf-8?B?UTNwdG9LbFpWcFlOOTdodXFPZ2pKOTI0ZUJtN3QvcEhVZ1R1ODAwREVIZFgx?=
 =?utf-8?B?NTRpRU1nQzdtUEgwYnIxZC93YTZpWmdjcTRhQTJnUFl4UXlKbDdaMzUxM3dU?=
 =?utf-8?B?VGcwdVQ1dU5GNlpHRUJzSUVKNnMwNDFjblFRZnJGdnI0NCtYcjNnOUxGNTdz?=
 =?utf-8?B?akVSRHNPTU5BUjgxNTc0OU5hTU0ycFg3aWNUakFwQ2RHemRIMWUxeE9TaFhk?=
 =?utf-8?B?VHBzcE9YbVZyMXRsOFBUL3AvOUJ2VWFNNWdYSzkwZllUSWM4cnJxQVlpWUQ3?=
 =?utf-8?B?WUMzTHZhSHRBZVJzQURDS0FoZFcwTkFrc2tWVXJ3Mlo4UmpWeDRERGc1UWdZ?=
 =?utf-8?B?eEtvdHY4eXQ3VzFNYlpIU2RqR1pabzgrQTdvNlNKekxVdXRaeTdabmFUa29p?=
 =?utf-8?B?cjYrVXFMNmRQd3F4dEU1NFFpT1VLNnRoUFlzVTNSVzNMQkNhNVYveFFUZ251?=
 =?utf-8?B?NWUzOTRENE5nZm9sVmY0a2dHREFjNitHRUJEbnQvdlIwTytYbGJDVWFEcy9o?=
 =?utf-8?B?UEtzQjhoUVkxQmFSQllqOVFucXhCMGFXOXJnblRaWk5NYU5DOXZMMkxodkdR?=
 =?utf-8?B?VkpwUGFEVEhyQVhFQ1dhZ0lqZHkyQ3hCRVdnclo4T3JXbllDU0J2dGVkWGRp?=
 =?utf-8?B?b3RGZWtKVFlTbS8vcU1CcXJUaEh0TnpRSTUzV1NQaTdJNVI2bXd0M1lqTTJx?=
 =?utf-8?B?ZXVhQVhDVE9Uem51WGRNdzlENlYwTHIrelVuNDZJY2h4cVNZa1NaeENWekty?=
 =?utf-8?B?aU02QVh4NVFYU2xKMVhTc2Ntdmc5SWE1dXpRZXRleVpQUXNOSVhHdytrNGly?=
 =?utf-8?B?UnpxU1BLWlNjeTRGT1FyVWVHRTNWa1E3U3JMWFI1OGs0SS8rejMrKzQyaWRv?=
 =?utf-8?B?bEREMm02cThXRzdzMTREaEZvWXdUYTdQNWg4cTdwU3dPVDkvT09KVjUwazRR?=
 =?utf-8?B?NG44ZTZkQVFUZDVVSm1LVFZrTkZycWtHZzZrZG52UTZiS0d2SmxNbDlBVHF1?=
 =?utf-8?B?b3lIOFU5V1ZqSzB4UkJibWtFZTNNbWJSNktYRmFTb2syY05tY25vUXp6RGlJ?=
 =?utf-8?B?ODNFWmNlMXhzc0RrVUFoVTVOeVpydlFPQlpqOXJEVldoRkREeE9URDYzUVBx?=
 =?utf-8?B?MFBQTUQyMEdNOXM5cUJ2K0t3ZmNRZFlrZ0JBTk5uelJhN2d2a1VTU3IxWElv?=
 =?utf-8?B?RHdvaDRpTEFTcXpaeHpYZ1hKTlBycDkwc2ZaWWwvTWlUYTJaS0lTS1U1ZFU0?=
 =?utf-8?B?K3puQXFYRWl1c1BwZktmdzdoTTJBMFR2Z1R5ZXBpeEhNOVBnQ0RkczllcGs1?=
 =?utf-8?B?Zkova3RzMXRWT2NYVVl3eHU0bWlGaU9ERzhnVzdacGt1dTl2b2gwcTFTYnFQ?=
 =?utf-8?B?dGJadUFQQWZ0QTI1b3habXU5RTI1UFF0a2tINXJwVExEcUtDRzVJYU9EQ0Uz?=
 =?utf-8?B?K1hTZFpJV014UGhXWTBLM2Z5V3Boa0Y1TU5NY0dxY2JNUFF2aHNVVCtNNm05?=
 =?utf-8?B?U2VsR3VjNnRKa0pPK1hYeWcvQ3k0S0dlZDl1YU1CZDMvRWlKdkt4LzRXR1VH?=
 =?utf-8?B?MmgyYWdMaUZZNFo1NWg2SGpkOGpvWitWRUFoTnNYcGxaQ1FXTk41NGkwdUJz?=
 =?utf-8?Q?wqA69f5sEdLvBrL6hxBF/31IX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c38ab42-9029-4bbc-12c5-08da5eb61aa4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 18:42:25.2552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtdvRKMZ+SD/BeGAEnVXFpGDWJlrhGYSmp0vi9ECNZ6I5A7qmX8ePOzyZgdo95YjNjQocPp/kXvFLFF1ZbwkzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3759
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-05_16:2022-06-28,2022-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207050080
X-Proofpoint-GUID: 5ja3HrtUfQrZ8ixKISDRm2WjJURnkRvL
X-Proofpoint-ORIG-GUID: 5ja3HrtUfQrZ8ixKISDRm2WjJURnkRvL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 7/5/22 7:50 AM, Chuck Lever III wrote:
> Hello Dai -
>
> I agree that tackling resource management is indeed an appropriate
> next step for courteous server. Thanks for tackling this!
>
> More comments are inline.
>
>
>> On Jul 4, 2022, at 3:05 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Currently the idle timeout for courtesy client is fixed at 1 day. If
>> there are lots of courtesy clients remain in the system it can cause
>> memory resource shortage that effects the operations of other modules
>> in the kernel. This problem can be observed by running pynfs nfs4.0
>> CID5 test in a loop. Eventually system runs out of memory and rpc.gssd
>> fails to add new watch:
>>
>> rpc.gssd[3851]: ERROR: inotify_add_watch failed for nfsd4_cb/clnt6c2e:
>>                 No space left on device
>>
>> and alloc_inode also fails with out of memory:
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
> These details are a little distracting. IMO you can summarize
> the above with just this:
>
>>> Currently the idle timeout for courtesy client is fixed at 1 day. If
>>> there are lots of courtesy clients remain in the system it can cause
>>> memory resource shortage. This problem can be observed by running
>>> pynfs nfs4.0 CID5 test in a loop.
>
>
> Now I'm going to comment in reverse order here. To add context
> for others on-list, when we designed courteous server, we had
> assumed that eventually a shrinker would be used to garbage
> collect courtesy clients. Dai has found some issues with that
> approach:
>
>
>> The shrinker method was evaluated and found it's not suitable
>> for this problem due to these reasons:
>>
>> . destroying the NFSv4 client on the shrinker context can cause
>>   deadlock since nfsd_file_put calls into the underlying FS
>>   code and we have no control what it will do as seen in this
>>   stack trace:
> [ ... stack trace snipped ... ]
>
> I think I always had in mind that only the laundromat would be
> responsible for harvesting courtesy clients. A shrinker might
> trigger that activity, but as you point out, a deadlock is pretty
> likely if the shrinker itself had to do the harvesting.
>
>
>> . destroying the NFSv4 client has significant overhead due to
>>   the upcall to user space to remove the client records which
>>   might access storage device. There is potential deadlock
>>   if the storage subsystem needs to allocate memory.
> The issue is that harvesting a courtesy client will involve
> an upcall to nfsdcltracker, and that will result in I/O that
> updates the tracker's database. Very likely this will require
> further allocation of memory and thus it could deadlock the
> system.
>
> Now this might also be all the demonstration that we need
> that managing courtesy resources cannot be done using the
> system's shrinker facility -- expiring a client can never
> be done when there is a direct reclaim waiting on it. I'm
> interested in other opinions on that. Neil? Bruce? Trond?
>
>
>> . the shrinker kicks in only when memory drops really low, ~<5%.
>>   By this time, some other components in the system already run
>>   into issue with memory shortage. For example, rpc.gssd starts
>>   failing to add watches in /var/lib/nfs/rpc_pipefs/nfsd4_cb
>>   once the memory consumed by these watches reaches about 1% of
>>   available system memory.
> Your claim is that a courtesy client shrinker would be invoked
> too late. That might be true on a server with 2GB of RAM, but
> on a big system (say, a server with 64GB of RAM), 5% is still
> more than 3GB -- wouldn't that be enough to harvest safely?
>
> We can't optimize for tiny server systems because that almost
> always hobbles the scalability of larger systems for no good
> reason. Can you test with a large-memory server as well as a
> small-memory server?

I don't have a system with large memory configuration, my VM has
only 6GB of memory.

I think the shrinker is not an option due to the deadlock problem
so I think we just concentrate on the laundromat route.

>
> I think the central question here is why is 5% not enough on
> all systems. I would like to understand that better. It seems
> like a primary scalability question that needs an answer so
> a good harvesting heuristic can be derived.
>
> One question in my mind is what is the maximum rate at which
> the server converts active clients to courtesy clients, and
> can the current laundromat scheme keep up with harvesting them
> at that rate? The destructive scenario seems to be when courtesy
> clients are manufactured faster than they can be harvested and
> expunged.

That seems to be the case. Currently the laundromat destroys idle
courtesy clients after 1 day and running CID5 in a loop generates
a ton of courtesy clients. Before the 1-day expiration occurs,
memory already drops to almost <1% and problems with rpc.gssd and
memory allocation were seen as mentioned above.

>
> (Also I recall Bruce fixed a problem recently with nfsdcltracker
> where it was doing three fsync's for every database update,
> which significantly slowed it down. You should look for that
> fix in nfs-utils and ensure the above rate measurement is done
> with the fix applied).

will do.

>
>
>> This patch addresses this problem by:
>>
>>    . removing the fixed 1-day idle time limit for courtesy client.
>>      Courtesy client is now allowed to remain valid as long as the
>>      available system memory is above 80%.
>>
>>    . when available system memory drops below 80%, laundromat starts
>>      trimming older courtesy clients. The number of courtesy clients
>>      to trim is a percentage of the total number of courtesy clients
>>      exist in the system.  This percentage is computed based on
>>      the current percentage of available system memory.
>>
>>    . the percentage of number of courtesy clients to be trimmed
>>      is based on this table:
>>
>>      ----------------------------------
>>      |  % memory | % courtesy clients |
>>      | available |    to trim         |
>>      ----------------------------------
>>      |  > 80     |      0             |
>>      |  > 70     |     10             |
>>      |  > 60     |     20             |
>>      |  > 50     |     40             |
>>      |  > 40     |     60             |
>>      |  > 30     |     80             |
>>      |  < 30     |    100             |
>>      ----------------------------------
> "80% available memory" on a big system means there's still an
> enormous amount of free memory on that system. It will be
> surprising to administrators on those systems if the laundromat
> is harvesting courtesy clients at that point.

at 80% and above there is no harvesting going on.

>
> Also, if a server is at 60-70% free memory all the time due to
> non-NFSD-related memory consumption, would that mean that the
> laundromat would always trim courtesy clients, even though doing
> so would not be needed or beneficial?

it's true that there is no benefit to harvest courtesy clients
at 60-70% if the available memory stays in this range. But we
don't know whether available memory will stay in this range or
it will continue to drop (as in my test case with CID5). Shouldn't
we start harvest some of the courtesy clients at this point to
be on the safe side?

>
> I don't think we can use a fixed percentage ladder like this;
> it might make sense for the CID5 test (or to stop other types of
> inadvertent or malicious DoS attacks) but the common case
> steady-state behavior doesn't seem very good.

I'm looking for suggestion for better solution to handle this
problem.

>
> I don't recall, are courtesy clients maintained on an LRU so
> that the oldest ones would be harvested first?

courtesy clients and 'normal' clients are in the same LRU list
so the oldest ones would be harvested first.

> This mechanism seems to harvest at random?

I'm not sure what you mean here?

>
>
>>    . due to the overhead associated with removing client record,
>>      there is a limit of 128 clients to be trimmed for each
>>      laundromat run. This is done to prevent the laundromat from
>>      spending too long destroying the clients and misses performing
>>      its other tasks in a timely manner.
>>
>>    . the laundromat is scheduled to run sooner if there are more
>>      courtesy clients need to be destroyed.
> Both of these last two changes seem sensible. Can they be
> broken out so they can be applied immediately?

Yes. Do you want me to rework the patch just to have these 2
changes for now while we continue to look for a better solution
than the proposed fixed percentage?

Thanks,
-Dai


--
Chuck Lever



