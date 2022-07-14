Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6446F57544A
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 19:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiGNR5C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 13:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiGNR5B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 13:57:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACF012604
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 10:57:00 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EG0ac4026579
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 17:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LhboHYCs2RMoSKQiyfr06fx3B9FmeWAMShplbtGV9fc=;
 b=wn1AHHAKxAUwhmxGQIubEPPUO5J8uGdJOnasrZX3nXJPImMJgdn4RRB6lnzlhq8Ui05R
 +4ad2ge/ayxRpHDx+svkKfgv0qh8UPWZONYKzBeiZe3FbBcfvJjYPJjdYNRZ1fk9TNYY
 Zn7BlncmzUm4xQXND1mP2o6Kj7wCl+CgdGGe8DuZexjE6mMeMzKdDx37NYxpN0Hw0Rcl
 JiCNfG6TXSxyHN8akC0duimg6+6xUFp4dMgAPVeEDCJTVmxclro+TUAFS6lB2KtZxKTk
 clluya2hPVqihNsLDqPAZ725J2xRVal8621m8/JnwShNmzLEE783UaSHO8ypfh21ibxy KA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sgw8t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 17:56:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26EHuiRY021361
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 17:56:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7045u8wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 17:56:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTFA1mcXTY8QKMGKzU7Cztl+wuk93eVDuxAjq3TKSZo0V0CFhgcAzmsSCKE+OsEeoNvU2TCHctC1MB1FLRCp0PTZ+sLKqWFWgtFL62yhLYwXPQ0EG5CWE6HVqQfA0l/1FOZMQidm9zBHlmPzS4FRXhD0L/rpqPToPFXUo7Wb19QldzJjZPPFdoaTLWsS5K/667cCReiFfgDrFG3TuCN47nZj2WO1sWt84HfM7XqD/OkPMmGZtxMQpPdHLgjPYTTHRiAJMdIc7VIL4Qbqc/vxxqesZakir/JfbPhmJBQJ0BrCh1XmMbLcKcXQB47QrRiB5n90ruPdO4tGPoNFc1Zjkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhboHYCs2RMoSKQiyfr06fx3B9FmeWAMShplbtGV9fc=;
 b=k7x/BOsb9SHjfVtToXGLUd18boL0eM/cDRWp1dHlSGD7c+S6y44j3C1/vEEVZvorg3vwvt2MUbPU5FZbGx5NLSJ3uOUrkUDswHXpiWgTLofPjYp0EjObX9Hm5vthzkSBCGgkfwxcZ9HgG48+hkdoozArS+6+iS753RE/+ab1KfTMBRCM3oRlb/TmPjJzVQKUiiw1p7vvGjpJpinyGtn//uIwlIqrMiqC0Oux4Hq3GNY0tYvrgE5ziDLLm8I05o6hQLDkldFvSxLlXyyPrTEjMCQz6+ZsGtvyyEIqZPEw69tpqO6CUDZYswj2GI+zbXw33mkBY2W0+ev3raxmP2rJOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhboHYCs2RMoSKQiyfr06fx3B9FmeWAMShplbtGV9fc=;
 b=VrKGoHB1vZERx/zyLzYqNmpjOkSZhyQZDxLfEP+jcnBtfJPqQqqYUV7tK61PtCCpZRt49rn8Bro28VmRMfA1EOmg8/LHsyBOumTdLyCOjcZDqPQDPSeygUXAqmoIjQMGgBbICx38FEhVnBXDV4qmIL9L3E+8VNc2Ytj0htGAnJs=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CO1PR10MB4644.namprd10.prod.outlook.com (2603:10b6:303:99::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Thu, 14 Jul
 2022 17:56:56 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd%4]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 17:56:56 +0000
Message-ID: <30ec26a2-cf4d-151d-9045-bcc382c633e5@oracle.com>
Date:   Thu, 14 Jul 2022 10:56:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/2] limit the number of v4 clients to 1024 per 1GB of
 system memory
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1657815462-14069-1-git-send-email-dai.ngo@oracle.com>
 <86EDD9A1-CB3D-4E3F-B4EB-0FEB3EED37F2@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <86EDD9A1-CB3D-4E3F-B4EB-0FEB3EED37F2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0147.namprd02.prod.outlook.com
 (2603:10b6:5:332::14) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea6bae3e-f3b4-4be6-1e22-08da65c23db9
X-MS-TrafficTypeDiagnostic: CO1PR10MB4644:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DVckjBuv+JVMTR/5WuavdfO5QngLJPVV7V7jl1QqYvsm51gMbfIDzsUXbdbWkImD3enkEeQy/LOL6JDh/EOi5v26Agn8UGVh2R7bgCt4sWssZsnr0kUml4mOCE55j87x8cyKarR7k/D2FwA2HMicmCOeR41ogOoO0mQMQK0WlskR68vQK4YJs7KwMvkAK3NL3H4QR1pEagWQ2zezOh/yu2N38xUkNkJNSQUngHWi3GkALeOPyc54zS8h8px8nb+r32xjuP3BOrJB6dHhBcanzHDc90Bd4vyqlZGp4Rd1f8EWCK6JsMwBusCEAx/HvGHiz5KBKq4tSTusrzJ70D2CNVyxZglYtrTnj3rz9tKLN4XW3ZMcrb4ch3uT39XcipnTuHnsqkuLOOrLYnDPs3TZabkiS0Ficf+fZO3rj8IuJRFzLjjSxaC0jivZTSe/igPy8eygkcEAnzXZo9OkJrShYHguoatW15L9IVC3qIOZge1tbNKuLrWfd910eKYiwgHVPLxzQMlEOxVNrp6zduEvqqBr+7kEdUfz++kq/9K0Fr6xWA4DtQXtvrZqs4F4SjHXfz9danmoJQzMTBbDxmXps++GiVboApEs1hFm2E+8oDd0ikqo0AtaN2ZzF+5Atsaye7pk0p8ymyxcrrXnBzddIaO69zu/qhoyYbJOf31l1td2o3q6iPJFHr+e+NJyGb/xRIsvYSA+OnOO8zTIXGMAHCcrG/QINwjsvRND6rwQLdzdbowbZ3khO9QdDPoOfAMEzTbkc26tWyBRJ23y8oLnY2NMvSEATDUgzOzX5rN+6wUW6FFCzp35HWIZuM6UQZ2L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(346002)(136003)(366004)(376002)(66556008)(36756003)(8676002)(38100700002)(478600001)(316002)(37006003)(4326008)(31686004)(53546011)(66476007)(66946007)(83380400001)(2616005)(6862004)(86362001)(5660300002)(41300700001)(6506007)(186003)(9686003)(26005)(2906002)(31696002)(6486002)(6512007)(6666004)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWIvQWRMVVgrSW55cFlTOVFaWUZjUlpST2kzNlRSWGplN3dSMjRnR0R0V1F3?=
 =?utf-8?B?djBhUFlqVk5LcENlMXYxQmtNWWpZOFBITkVIZ2lSWi9PenpxSGMwcVhCZlBm?=
 =?utf-8?B?Qjhxa29waG96QUFTcTVUS1oweTlpYVY5MkhmWmIreWxNanRFZ1FpcUQ0YVd6?=
 =?utf-8?B?TGU2bnhZSldKQjhJaHkzRkF1MlRrQ3lzaTZuNlZlV01IQ0JVNG5GWURNLzNS?=
 =?utf-8?B?YnQ5RTh1a0lnd1g2QUUrRzhGaU5hdHRLa1B1SzJhY2pLZWlZVFp0Rm1HT3ZE?=
 =?utf-8?B?LzhNaEloTUErL2h1MENPb2I0QkIwNGZ0VmkyNWwvS0VYU3FKWisvN0NRM3pJ?=
 =?utf-8?B?SnJOaXk1d3kxdEJGdVhaQndBQnZjN0V0SFVZVG1DWEJ1cG9FcFpkM0xaRFVy?=
 =?utf-8?B?MDhQSGV4eEp5RGJncUxrc013TlJIcm9CdnZqUHpJajBhbXBaTTR3TGRhZlZU?=
 =?utf-8?B?cXdUbzhOZEI1aElpN3dDY1JyKzVJSS9uWlRNMm1HeFZNUW9qMkpzVkFJbmp2?=
 =?utf-8?B?MDN6YzM2aG05UHhRaThlMXdPN2xwdFZreUtEeEpFcFJtT0wyMVlJRHlQN2lS?=
 =?utf-8?B?NW9iWlQ3Z1hCa1JiNFpBTEFnN3liM1pPeFNhL05qYkhuWDN0SktBVGFRekVS?=
 =?utf-8?B?WllJQkowaVh2eTl6dkNDYllWaGs3c3lYZ2lzWit6QnF4emoveFJzcDZTVlhn?=
 =?utf-8?B?cFZuTjF1MmhJd3RuR0tWMmxsSXdKQXFDRlIzOGprNXRvYURuMVhYTUsxeHd3?=
 =?utf-8?B?TUJnZi9MckV5eTlVRjgzMzJIUVpjcUpDQkJ2SWd1UU5XRXlUbGd3WUdaNmlZ?=
 =?utf-8?B?NE8xUWJXWlE2d05vN0laNFptU2tNWlpjMFVGODA4S3RaeXdwOExCV2cwWThw?=
 =?utf-8?B?a3NWaFl1Q01IS1l4VjREai9HdmE4S04xbjRUbVlYMlY1T3Mwb2R0OHYwQVIr?=
 =?utf-8?B?UmxmYmhjRmJNS2VNWm14MUN4eHovWG5vQk9xTmg5YUVWVXpSajRkcWFtVDUy?=
 =?utf-8?B?c01SL1hzUkRmL0w1VDFvcFFnOTdnME44V2QramxTZVZTR3o1Vm1kd1A2UjFv?=
 =?utf-8?B?bHg1VU9YRWxWNFFqa1ZXeGJyeU1DR3Jobmt1WTYyUE05Y1RGR2pXb2FqWElZ?=
 =?utf-8?B?VGlkanhoWTFLTU9hb2g0eG5vZFA4b09MNnd0a0pDdGNFQ0RSUVR0eTJacmhB?=
 =?utf-8?B?bWZtT0tqZGhvSkx6TTlsQ0RJS2VPTnBoMkFDZHRubXh6eGtyRFFHZHRNd0k5?=
 =?utf-8?B?NjlNOE5RcVBiYWJPYVNtVCs5bHl0M1lvM1RkY3o0dnFnRXhCa1V4Tjhnb0xj?=
 =?utf-8?B?ckpLamQvZnJXc1YxOUo1eVBreEFTU0s5emVGWlcyQUdQMWFqZENYV0ZYd0dO?=
 =?utf-8?B?aDRSVTNSeFJRZXNOQjVic1kwZ0kwVEpjYnExT1pzZFpWUVUyMnJobitSNWVw?=
 =?utf-8?B?UmhBaVAzUENrY28xRit4eEVMcmNJUUM2OVA1RU9BVFpJUk1NRURQQ2Y5ZDYz?=
 =?utf-8?B?dXo4d0J0QkhWY3grZjVRdzNrS3IxM1hONkUzWDVObjI3UElqWWpQS01SaTRj?=
 =?utf-8?B?R3BkUmhud1dlcTJYYjVsa3pXbTZUalR0VmhKaHNCWHBDTUg2M1B2MVZ1dmd1?=
 =?utf-8?B?YmRSU21OcFdQSXY2c1RLVVN1ZEw3cUlxMUJIdGFFR3MyVUtMUHAxN0hyOGpW?=
 =?utf-8?B?OGlUTVkzTnBGMUV0bGNUUmhHT1NvdDNDWVg4aEJJZ3AreXIvUnRac2l2NzNP?=
 =?utf-8?B?QWQ2MlVCdUFJOVUzMDJMNTVEemlud044ZGtsa1ZUdDFFcFk5QmRmbVpLMjhL?=
 =?utf-8?B?SUs4Qi9xTWdqdDIrMm8zOGV3WXNoTHRWNXhzUm1DNVRWbG5XTnBjcUluWm1V?=
 =?utf-8?B?c0wrcWZiTCt1SDJnRjFKME9tbFlwN0k0TnJuL3RqMWVKaEpxWDNGS3hvRG5y?=
 =?utf-8?B?VEtPZWpuRFdnWWVmZURWeklMTitQczZXblFUUEZIdzdEc0FOZzVoKy90Wndp?=
 =?utf-8?B?M25rS1BaV3EreFdPR2dDQmFkMlZkNGtaTllaVkdHMTZVZHB1WEtuTUFHUmZP?=
 =?utf-8?B?YU9YcVlaUGxSZUlscU9hSXpyUktWLzhMNUFuQStMeFRZd0VrMVFwTTRwUTlX?=
 =?utf-8?Q?s6xd/ieO7ZGyKXCLd7WUiMR9v?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6bae3e-f3b4-4be6-1e22-08da65c23db9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 17:56:56.1667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0cAoEr9CBHYpwD4v3gLI2Q3AB3DFQUrcflHG5b4wObKPz+41C+j/zXHo6FXuHHHnC3X5dYRXvgQrEFB4DxINQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4644
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-14_15:2022-07-14,2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=946 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140078
X-Proofpoint-GUID: qhjARcaepoQasUX9TVeQf7Cxhe-A8J-D
X-Proofpoint-ORIG-GUID: qhjARcaepoQasUX9TVeQf7Cxhe-A8J-D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 7/14/22 10:18 AM, Chuck Lever III wrote:
>
>> On Jul 14, 2022, at 12:17 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> This patch series enforces a limit on the number of v4 clients allowed
>> in the system. With Courteous server support there are potentially a
>> lots courtesy clients exist in the system that use up memory resource
>> preventing them to be used by other components in the system. Also
>> without a limit on the number of clients, the number of clients can
>> grow to a very large number even for system with small memory configuration
>> eventually render the system into an unusable state.
>>
>> v2:
>> . move all defines to nfsd.h
>> . replace unsigned int nfs4_max_client to int
>> . kick start laundromat in alloc_client when max client reached.
>> . restyle compute of maxreap in nfs4_get_client_reaplist to oneline.
>> . redo enforce of maxreap in nfs4_get_client_reaplist for readability
>> . use bit-wise interger to compute usable memory in nfsd_init_net.
>> . replace NFS4_MAX_CLIENTS_PER_4GB to NFS4_CLIENTS_PER_GB.
>> . use all memory, including high mem, to compute max client.
> Hello Dai, I applied these two to NFSD's for-next branch for early
> adopters and other testing and review.

Thank you Chuck,

-Dai

>
>
>> ---
>>
>> Dai Ngo (2):
>>       NFSD: keep track of the number of v4 clients in the system
>>       NFSD: limit the number of v4 clients to 1024 per 1GB of system memory
>>
>> fs/nfsd/netns.h     |  3 +++
>> fs/nfsd/nfs4state.c | 28 ++++++++++++++++++++--------
>> fs/nfsd/nfsctl.c    |  8 ++++++++
>> fs/nfsd/nfsd.h      |  2 ++
>> 4 files changed, 33 insertions(+), 8 deletions(-)
>> --
>> Dai Ngo
>>
> --
> Chuck Lever
>
>
>
