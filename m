Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9436608CE
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jan 2023 22:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbjAFVXI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Jan 2023 16:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjAFVXH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Jan 2023 16:23:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E9577D28
        for <linux-nfs@vger.kernel.org>; Fri,  6 Jan 2023 13:23:05 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306L4mWi031283;
        Fri, 6 Jan 2023 21:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ebxpoM/VGnlY9AG1ZTsgZVMdv03mLExgPLW8/TQEl3U=;
 b=M+vQVvvxp4eqfwp5zKilqLJyKXgmX1WGliO4wYAk8iGWUz7A7D2Pk4zYaewSQMv5lFaD
 uDb8JUmPzhDiZkWI9hhThCu+9iPCBmLBrJnFHi6EAF+ytGgvGm5lmm78sG9vCNyypuU9
 jVsa4Re6QPJOFEchkLRdb3KQ+Yc8Wk4Nr5lAWwkxYLhap75AnuS3I4Xzwo3vrFOclSRy
 GcIQdhlKpDb57BcSSsDk3l7drdPnQMHjJvwMbWSXT3jFo9rqAIBcQiMI4LVAN9HFOwp9
 wTiwlCCPswQKZfMfQf5TE6U4OP3zeQoEDSvVudqerojUYI9lHiY56nupvDuVZE0KJced NA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4cc63w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 21:22:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 306KxGFv023312;
        Fri, 6 Jan 2023 21:22:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkgp626-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 21:22:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mv1xnbP4ZBgEHUrxKcBaKX2mybJp4l+nbOWFCuykV2bzJqq5Vu/Gh0uB2bNQkp96h4YV/uO/gGfWzOcGtX9zzPgKEvDJhMrVy7aeGXcJPeAY4mxFeENfNNM2wwN+fWDx2TTom/4S6P0SU1KCSiY2eP1DchtVSP4Naa0hB8tOufw3SNNndeqfaYgAO5H7vEsx6RhqhQychmkjT8DHgh2hkdeqkbWNE9E5vdvZlCat4poa2RQjhT/P0y2uSFJHF/4gLWhnypt0DB6+YIv/MgnPdV5zHE4ywS1U1s4igB6+mhWAbJe2G6HW2fP/Xv2bWM+ErNSaji4Ekbdr+UsYNBcLcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebxpoM/VGnlY9AG1ZTsgZVMdv03mLExgPLW8/TQEl3U=;
 b=h26eQNyTL0u7+vKgiQrrtVvqpKQ3qpSLnb/2q2xTAZYLqqcODPbEGdG/FWWpUtucRHjaxtdD6y0kNPTbEpTOuKKEWlUMvNrW+fNyNxFzAJwNTCTxLbZe7m/erBtiXBUwfFiXWCDjGzmgghbm/X27BdHfSLei04e0EzjBAGYycsqpq5LzxOSEnf3Hp8H9FrXE9G0lQ8KFKrhVwHZuJovw/GzkSpRRhhzrkvzakk3xCQ8xAF0FmkSjfXiZsBPH4qciVtwnj8YR3puffVvoc0/+SlH+JiqIJCVPDnW3sFTHLkkNfKSDIOwh2+knluGiMM99SGfwA3YQdg+nBATNi0Ptfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebxpoM/VGnlY9AG1ZTsgZVMdv03mLExgPLW8/TQEl3U=;
 b=O2ScR9qG5EZiG/JtwOYNuqcVHuSWOHnyKs1uRD7EoaohWkdkUOawqDo1JNc9/obmq86vogEC8lyI9IYP4dwy/w3OlAOKA3YDwFSSPJx4f10aFdMu+k2FyPR2F68uVZ/4j7XC7Iybgw+QodFaFx+F7W/2lCK9nEzY7N6ktf6sY+0=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH0PR10MB5129.namprd10.prod.outlook.com (2603:10b6:610:d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 21:22:44 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%7]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 21:22:44 +0000
Message-ID: <85c49a4e-632a-dd5e-f56b-af28312dbb8b@oracle.com>
Date:   Fri, 6 Jan 2023 13:22:42 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/1] NFSD: enhance inter-server copy cleanup
Content-Language: en-US
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
References: <1671411353-31165-1-git-send-email-dai.ngo@oracle.com>
 <28572446-B32A-461F-A9C1-E60F79B985D3@oracle.com>
 <CAN-5tyEL1FvvCMgg=NWrHcAvLdXFKZQ_p1T8gRhH9hUoD3jPhA@mail.gmail.com>
 <e46fdd1c-3a61-9849-e06a-f7df8dd78622@oracle.com>
 <CAN-5tyECjk5z8wsJ28GU_j0nL7eNwzv7Vt=dVc4UGvYgZqDYJg@mail.gmail.com>
 <CAN-5tyGdbhvNHXKRqxX48X3nvpUDPgfrM4++a2SPcuxJunkxmQ@mail.gmail.com>
From:   dai.ngo@oracle.com
In-Reply-To: <CAN-5tyGdbhvNHXKRqxX48X3nvpUDPgfrM4++a2SPcuxJunkxmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0092.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::33) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CH0PR10MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a019b4-90cf-4cd0-d861-08daf02c26c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95HBy/aDhJmYP4LCmhvRshH2ggwGPjrY6cSmBJYkG/GNCTA1FS1fBqEjnXUWrdS2qGCBQ1LFL/ykBgIO+bcfymOr67iQSiQQqdHv1EAngRQsDTGDZfacoMNUYw+RQnn0KbtEtkJk/nFA6g2vJWbNg/cyO0VflpGnyoiv1Lbfjx2hiIs9XojEqpQVOGn8G1wrOexHz2Y3JHrUNcA9fI7ZCFDvKcvdOOtZOZfzdiKaKx0tiLVNI5oKXbUd+bXz5Xli0uVdVaj4Rgs3OR1pQeSlmkePYgIyEe9OrUuinB9YaoE9i0H/GdoJlFi9uj7wCkPam75GmjcwLGsu+lTQ2PWjakHiULdQgpHHavKVb8P/zqOBMM9GYRLsED6ub+WHCo9y0dfZZOTVwnoyg+NJsSid7PY4GJNvNSYYEf675lG/nkhbJ5HpFdknQSMDtRbrKV6bx7OViZLPdrgWdEj2PUsx7LFw6ZL1TTdb/FDLjgF9tBGTXS2TWe8Kazqm+Sv5cmYaUmYZoM0YQBW38BZPVDwIoNqBTAOSo/9zdmbT2PoJ+cb4cczkEEXuzTfXVVgByvilqladFlEUVLOFzOGy9aifCvU8VVw7G2qxYbNp9Gn2E/FGrXuMVjveetZKRZ+Dng6Upqp89S0iwsqsFzFREi+BUM9hYi04lYV1eiTblvQ7nAVHnaCFFhCwGMXGN7rV2oBj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199015)(83380400001)(86362001)(31696002)(38100700002)(8936002)(5660300002)(41300700001)(30864003)(107886003)(478600001)(8676002)(2616005)(53546011)(9686003)(6512007)(316002)(6506007)(4326008)(66476007)(186003)(26005)(6916009)(66946007)(6486002)(66556008)(2906002)(31686004)(54906003)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmJxNlRMV0ZuSFJqd0V2YVFXNlFzK3dQeitydCtZNy9MWTJjZlBhWG9MMjM1?=
 =?utf-8?B?OGdqWk52OTV6Ulhhb1FXS2dRM0pOVnBqNWdsNmRjcnpvSy9jcm1HNEFIc2My?=
 =?utf-8?B?VmhPVjJUVlJ0SjNxQXAvL0dhTlNOYm5ub05LWFhaQ3FFaGk5b3ZHbEIwWVla?=
 =?utf-8?B?OFlPNVpVVEdtc21iWDVkLy9KL0NuVStZVTY5dFA5Wjh4U1hSSmo1NUp6dGlm?=
 =?utf-8?B?QWZtL1pueGJpdUt6MGJkQ2pwdTM4K3U3Yy9Ba1NtN0JyVWdyVkZhRlMxamUv?=
 =?utf-8?B?bnVGSzJQb1JpbndHcTZUbDJOdEdtWEE4eFJ0elpocEs5VW9NT0NCbmk1bDNK?=
 =?utf-8?B?S2s1VldJcldHUDMzQWpOdW1zVkJZeEJMOUVJaUZ2eEtlTXVuRmtSd2t2QmJt?=
 =?utf-8?B?MTZha2xFZk5mdEVFRGpLeXliUG41bU5tbjRVZ2grQmU3UXcvcGNORXRaS0lo?=
 =?utf-8?B?MEtidGsrcDk1VDByalRxcHFxT0UxOHA5K2RkVE1XTHEwNzhDcDJNbXFkM0dZ?=
 =?utf-8?B?T0pudGZ2N25OVlpRSDFtWDg2MGVnZU1LaEZqMW1STy85SHZyMFVsalRkNldj?=
 =?utf-8?B?QmV3UmZoSDJGa1lEenZCRGlsYzhnSy9kalZhb0hITW9FbEs0WWRvZER3TkRl?=
 =?utf-8?B?YXpGcGtQdGJNcUs4bkxiWXVQSjJvRklwYmFFYlF5bkJPOWZMaGdRTkR2andH?=
 =?utf-8?B?dVZUeTFVZ2RvSjFPWGdTK0lnV1J3cnl0SUZOT1dGWk5UYWdLazZSV08zbW5o?=
 =?utf-8?B?b3prdDgzeG5XcWpJbXlUR2UzS0JFUmhlcXltaUplKzZCcnRFSEFXVUpZa0lz?=
 =?utf-8?B?cnhKVG5YYUhVS2RxNzZxK2EzRHpGYzgrdVRYeFBkc3BGNlI0bWxrVGJlSFNP?=
 =?utf-8?B?U01SVE1rbndqZ0RERWhPMEpzZWtEUHNCTklCN0JvWEMwM29QNlNDK3ZkUFZx?=
 =?utf-8?B?N0dlL21JYXVUMEhpQUVWcDgwaXMraGlEYTh0RHVrYUVBbWdYbVJnL2F5aFQz?=
 =?utf-8?B?VVZYRS9nUDNOYWJPckd3dytVQk1CZm8xT1ZpRGxwR21JNnJiTXJjUmFLbi9H?=
 =?utf-8?B?Uzd6SGtIZ01jbitnL0NUY2RpNXVxV0xsTHJQUHJCdDhtbnM1blZqRWFsMWNZ?=
 =?utf-8?B?L05sL0tuTit0RHQ3Y3BpaGRDSC9jRUNkQXdTbEVHQ1dGSk5PZGZuZGwvd3Ew?=
 =?utf-8?B?OVdTbGwvNEVpZitVbXBOQUZ6QmZIZGtxMWZ4YkZhV2RwSEo1d2RWaHpBNnFr?=
 =?utf-8?B?QU51OHIwT0VHQTY5cGl3blNqZnZpVzAzaERaa3E4eUd6OUgvSER0UGtDK2V2?=
 =?utf-8?B?Z0ltM0JGS3hSRmFhbC9hWWZveGQ3cWxtenlJNkV5bEdpMG5ZWlVGR2pRU3p6?=
 =?utf-8?B?Wjl6Y29EeW9MWG9UVzZVcmpTK1o2cTZkSHZZdmU5S3ZxSVRxMEdiZjZ0ZUcv?=
 =?utf-8?B?VXc1dzI2c3JwcWtUelRkTHFWZlhuT3FWNitpNVdLV2NFQytIbWt3WFhsK083?=
 =?utf-8?B?T1gvSDJHTGluK2FWblFWVEF0NXhzYWFGNk15ajhvMUpJeUtvVFd4ZEZVbEYz?=
 =?utf-8?B?K1k5SGtpMVUwT2J2RUxwRVU2RnhCcnZnUmRmLzJ4ejJmZjhvbWVJcVdUY0la?=
 =?utf-8?B?L29WOVplUnl5MFQ1VDJKcnY4ZENOMWdYZnhHeVlQakdKdDV6elFFYlpLQkFT?=
 =?utf-8?B?V3RBR2RhQmZkZEFsZGpzSVpBZU1HeUFOZXROQUlJYXNQdkRVNXdHZ3VLbDFM?=
 =?utf-8?B?QVVWNGVSRUsvSWRudEI1M1VoS2NoMHhFSUVYQlNWL3l1OGc0Q1JMKytxMjVZ?=
 =?utf-8?B?ei9TRjdpNFRMK0Jwc3V6dVI2OWlSRlFnZmpsS29YMnh5R25tUmNnbGVJSm82?=
 =?utf-8?B?bTUrVWlOY3JXZkpISng4SmY5bDZ5Yit6b3FzeDhiaTFFaUR1bUk1YkR1akpB?=
 =?utf-8?B?NUZjWGx1WEI2M2xjL09qSUEwOHJzK08rcnhsa2tEN3NReFlVSzZyaTdEaWVv?=
 =?utf-8?B?eHFsK3ZWSUdrYjBhOVJhOHlkN1R5aVF6UzFvcmdjN2I4NXJOa01nVXNIL2hU?=
 =?utf-8?B?MUU4Smlwb0NKNXZZZ0JKSUtidDJNMHEwQzFxaDI3U0JHVVVXOGJLdE5HaWxS?=
 =?utf-8?Q?l7r4N1eLy3e7hGvPBjO8Z3Uin?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rQCUCAVRpSx2jGtGa45LFZEp/40sOp8Z5tDbsWyihVS8GC97Hyr+h7eVJABT5smtgkmnjBkH/03+0HC85vIpTbL7lU6wqC3pKWh6lLBap86pUEHJFBupPegDFSJ6GaJzRabPuwFm7yR1EXPai6m+2IKpXB4qB3wWgLg1hH4wsFfbxDLbMdA7qyNKEVnlC4Xs3XH7LC1H56dgq5BQmL1rTzFCoM89kmC4OXFAkrUI07JP5m9vDh0aePhtd+r6d4DZwhUeMq19xvfHzhw6tNdLsr0a2eP8z9r2vXeHqgfTK2g8O6vm9UD1i80DSBWmrJ9p8ahuWDgJWI8ICI54y72m8aMGfLuDLp3D9sYbmirtE5+L3VratYGKHdGQGxMEJNGu1raI82gOT8bOPof4CwoGzAP2EQD8ihicjlmuBnRevBpcS4ZMxtRtY9D3HypzKC8LNGMYxJrZaRE+Ee0MvKE7T4GaTVOc/01j/dAyALB77Ck7RSnHwhA4kgsCKqQlzL4goYKX3yXV9ZAzkasCh4J79TzpfnRPCeWgYC2Sxfc4RVPJ/Ay+KrN/X9j+aXVgVkoSVcAC2XI0Vdyus4vw7bSERUxVYC1msdLV5VqQO3ktVQvgOp3ZGgi07LNqYp249J+5zcAGE0hEMXKyNscnG/VSGkHVnFBVVMZJG+x5bNupxpEfTcz5KeUUQzZ0miC6o+cAQ10DqkYw3NsPEM62no66tsGdMylQNFPJkL4YE38/VLE/7Ujmcihc85qNfBgSV+bq3myo75Z8QG2nwe2IogcN4EXu5CZIee9xKQMCsqrO8RfF3EgUgpa0fyxWWbndzwZw
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a019b4-90cf-4cd0-d861-08daf02c26c4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 21:22:44.7414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vL141vHbWs4mHhgh4K6/EY2rPfJbPYcOHdmDfH0DY0L5/4YB7rZn/TZDVkcV4UYWSQW/gr0t9owKHyKMHTclew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_14,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301060166
X-Proofpoint-GUID: nu0E-qSbL15WgBri-T9L9oadxIqOo9Qk
X-Proofpoint-ORIG-GUID: nu0E-qSbL15WgBri-T9L9oadxIqOo9Qk
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 1/6/23 12:11 PM, Olga Kornievskaia wrote:
> On Thu, Jan 5, 2023 at 4:11 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>> On Thu, Jan 5, 2023 at 3:00 PM <dai.ngo@oracle.com> wrote:
>>> Hi Olga,
>>>
>>> On 1/5/23 8:10 AM, Olga Kornievskaia wrote:
>>>> On Tue, Jan 3, 2023 at 11:14 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>>>>>
>>>>>> On Dec 18, 2022, at 7:55 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>>
>>>>>> Currently nfsd4_setup_inter_ssc returns the vfsmount of the source
>>>>>> server's export when the mount completes. After the copy is done
>>>>>> nfsd4_cleanup_inter_ssc is called with the vfsmount of the source
>>>>>> server and it searches nfsd_ssc_mount_list for a matching entry
>>>>>> to do the clean up.
>>>>>>
>>>>>> The problems with this approach are (1) the need to search the
>>>>>> nfsd_ssc_mount_list and (2) the code has to handle the case where
>>>>>> the matching entry is not found which looks ugly.
>>>>>>
>>>>>> The enhancement is instead of nfsd4_setup_inter_ssc returning the
>>>>>> vfsmount, it returns the nfsd4_ssc_umount_item which has the
>>>>>> vfsmount embedded in it. When nfsd4_cleanup_inter_ssc is called
>>>>>> it's passed with the nfsd4_ssc_umount_item directly to do the
>>>>>> clean up so no searching is needed and there is no need to handle
>>>>>> the 'not found' case.
>>>>>>
>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>> ---
>>>>>> V2: fix compile error when CONFIG_NFSD_V4_2_INTER_SSC not defined.
>>>>>>      Reported by kernel test robot.
>>>>> Hello Dai - I've looked at this, nothing to comment on so far. I
>>>>> plan to go over it again sometime this week.
>>>>>
>>>>> I'd like to hear from others before applying it.
>>>> I have looked at it and logically it seems ok to me.
>>> Thank you for reviewing the patch.
>>>
>>>>    I have tested it
>>>> (sorta. i'm rarely able to finish). But I keep running into the other
>>>> problem (nfsd4_state_shrinker_count soft lockup that's been already
>>>> reported). I find it interesting that only my destination server hits
>>>> the problem (but not the source server). I don't believe this patch
>>>> has anything to do with this problem, but I found it interesting that
>>>> ssc testing seems to trigger it 100%.
>>> It's strange that you and Mike keep having this problem, I've been trying
>>> to reproduce the problem using Mike's procedure with no success.
>>>
>>>   From Mike's report it seems that the struct delayed_work, part of the
>>> nfsd_net, was freed when nfsd4_state_shrinker_count was called. I'm trying
>>> to see why this could happen. Currently we call unregister_shrinker from
>>> nfsd_exit_net. Perhaps there is another path that the nfsd_net can be
>>> freed?
>>>
>>> Can you share your test procedure so I can try?
>> I have nothing special. I have 3 RHEL8 VMs running upstream kernels. 2
>> servers and 1 client. I'm just running nfstest_ssc --runtest inter01.
>> Given that the trace says it's kswapd that has this trace, doesn't it
>> mean my VM is stressed for memory perhaps. So perhaps see if you can
>> reduce your VM memsize? My VM has 2G of memory.
>>
>> I have reverted a1049eb47f20 commit but that didn't help.
> Ops. I reverted the wrong commit(s). Reverted 44df6f439a17,
> 3959066b697b, and the tracepoint one for cb_recall_any. I can run
> clean thru the ssc tests with this new patch.

Can you elaborate on the nfsd4_state_shrinker_count soft lockup
encountered when running the ssc tests with the above commits?
I'd like to make sure these are the same problems that Mike
reported.

Thanks,
-Dai
  

>
>>
>>> Thanks,
>>> -Dai
>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>>> fs/nfsd/nfs4proc.c      | 94 +++++++++++++++++++------------------------------
>>>>>> fs/nfsd/xdr4.h          |  2 +-
>>>>>> include/linux/nfs_ssc.h |  2 +-
>>>>>> 3 files changed, 38 insertions(+), 60 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>> index b79ee65ae016..6515b00520bc 100644
>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>> @@ -1295,15 +1295,15 @@ extern void nfs_sb_deactive(struct super_block *sb);
>>>>>>    * setup a work entry in the ssc delayed unmount list.
>>>>>>    */
>>>>>> static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
>>>>>> -             struct nfsd4_ssc_umount_item **retwork, struct vfsmount **ss_mnt)
>>>>>> +             struct nfsd4_ssc_umount_item **nsui)
>>>>>> {
>>>>>>         struct nfsd4_ssc_umount_item *ni = NULL;
>>>>>>         struct nfsd4_ssc_umount_item *work = NULL;
>>>>>>         struct nfsd4_ssc_umount_item *tmp;
>>>>>>         DEFINE_WAIT(wait);
>>>>>> +     __be32 status = 0;
>>>>>>
>>>>>> -     *ss_mnt = NULL;
>>>>>> -     *retwork = NULL;
>>>>>> +     *nsui = NULL;
>>>>>>         work = kzalloc(sizeof(*work), GFP_KERNEL);
>>>>>> try_again:
>>>>>>         spin_lock(&nn->nfsd_ssc_lock);
>>>>>> @@ -1326,12 +1326,12 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
>>>>>>                         finish_wait(&nn->nfsd_ssc_waitq, &wait);
>>>>>>                         goto try_again;
>>>>>>                 }
>>>>>> -             *ss_mnt = ni->nsui_vfsmount;
>>>>>> +             *nsui = ni;
>>>>>>                 refcount_inc(&ni->nsui_refcnt);
>>>>>>                 spin_unlock(&nn->nfsd_ssc_lock);
>>>>>>                 kfree(work);
>>>>>>
>>>>>> -             /* return vfsmount in ss_mnt */
>>>>>> +             /* return vfsmount in (*nsui)->nsui_vfsmount */
>>>>>>                 return 0;
>>>>>>         }
>>>>>>         if (work) {
>>>>>> @@ -1339,10 +1339,11 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
>>>>>>                 refcount_set(&work->nsui_refcnt, 2);
>>>>>>                 work->nsui_busy = true;
>>>>>>                 list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);
>>>>>> -             *retwork = work;
>>>>>> -     }
>>>>>> +             *nsui = work;
>>>>>> +     } else
>>>>>> +             status = nfserr_resource;
>>>>>>         spin_unlock(&nn->nfsd_ssc_lock);
>>>>>> -     return 0;
>>>>>> +     return status;
>>>>>> }
>>>>>>
>>>>>> static void nfsd4_ssc_update_dul_work(struct nfsd_net *nn,
>>>>>> @@ -1371,7 +1372,7 @@ static void nfsd4_ssc_cancel_dul_work(struct nfsd_net *nn,
>>>>>>    */
>>>>>> static __be32
>>>>>> nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>>>> -                    struct vfsmount **mount)
>>>>>> +                     struct nfsd4_ssc_umount_item **nsui)
>>>>>> {
>>>>>>         struct file_system_type *type;
>>>>>>         struct vfsmount *ss_mnt;
>>>>>> @@ -1382,7 +1383,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>>>>         char *ipaddr, *dev_name, *raw_data;
>>>>>>         int len, raw_len;
>>>>>>         __be32 status = nfserr_inval;
>>>>>> -     struct nfsd4_ssc_umount_item *work = NULL;
>>>>>>         struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>>>>>>
>>>>>>         naddr = &nss->u.nl4_addr;
>>>>>> @@ -1390,6 +1390,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>>>>                                          naddr->addr_len,
>>>>>>                                          (struct sockaddr *)&tmp_addr,
>>>>>>                                          sizeof(tmp_addr));
>>>>>> +     *nsui = NULL;
>>>>>>         if (tmp_addrlen == 0)
>>>>>>                 goto out_err;
>>>>>>
>>>>>> @@ -1432,10 +1433,10 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>>>>                 goto out_free_rawdata;
>>>>>>         snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
>>>>>>
>>>>>> -     status = nfsd4_ssc_setup_dul(nn, ipaddr, &work, &ss_mnt);
>>>>>> +     status = nfsd4_ssc_setup_dul(nn, ipaddr, nsui);
>>>>>>         if (status)
>>>>>>                 goto out_free_devname;
>>>>>> -     if (ss_mnt)
>>>>>> +     if ((*nsui)->nsui_vfsmount)
>>>>>>                 goto out_done;
>>>>>>
>>>>>>         /* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
>>>>>> @@ -1443,15 +1444,12 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>>>>         module_put(type->owner);
>>>>>>         if (IS_ERR(ss_mnt)) {
>>>>>>                 status = nfserr_nodev;
>>>>>> -             if (work)
>>>>>> -                     nfsd4_ssc_cancel_dul_work(nn, work);
>>>>>> +             nfsd4_ssc_cancel_dul_work(nn, *nsui);
>>>>>>                 goto out_free_devname;
>>>>>>         }
>>>>>> -     if (work)
>>>>>> -             nfsd4_ssc_update_dul_work(nn, work, ss_mnt);
>>>>>> +     nfsd4_ssc_update_dul_work(nn, *nsui, ss_mnt);
>>>>>> out_done:
>>>>>>         status = 0;
>>>>>> -     *mount = ss_mnt;
>>>>>>
>>>>>> out_free_devname:
>>>>>>         kfree(dev_name);
>>>>>> @@ -1474,8 +1472,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>>>>    */
>>>>>> static __be32
>>>>>> nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>>>>>> -                   struct nfsd4_compound_state *cstate,
>>>>>> -                   struct nfsd4_copy *copy, struct vfsmount **mount)
>>>>>> +             struct nfsd4_compound_state *cstate, struct nfsd4_copy *copy)
>>>>>> {
>>>>>>         struct svc_fh *s_fh = NULL;
>>>>>>         stateid_t *s_stid = &copy->cp_src_stateid;
>>>>>> @@ -1488,7 +1485,8 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>>>>>>         if (status)
>>>>>>                 goto out;
>>>>>>
>>>>>> -     status = nfsd4_interssc_connect(copy->cp_src, rqstp, mount);
>>>>>> +     status = nfsd4_interssc_connect(copy->cp_src, rqstp,
>>>>>> +                             &copy->ss_nsui);
>>>>>>         if (status)
>>>>>>                 goto out;
>>>>>>
>>>>>> @@ -1506,61 +1504,42 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>>>>>> }
>>>>>>
>>>>>> static void
>>>>>> -nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
>>>>>> +nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *ni, struct file *filp,
>>>>>>                         struct nfsd_file *dst)
>>>>>> {
>>>>>> -     bool found = false;
>>>>>>         long timeout;
>>>>>> -     struct nfsd4_ssc_umount_item *tmp;
>>>>>> -     struct nfsd4_ssc_umount_item *ni = NULL;
>>>>>>         struct nfsd_net *nn = net_generic(dst->nf_net, nfsd_net_id);
>>>>>>
>>>>>>         nfs42_ssc_close(filp);
>>>>>>         nfsd_file_put(dst);
>>>>>>         fput(filp);
>>>>>>
>>>>>> -     if (!nn) {
>>>>>> -             mntput(ss_mnt);
>>>>>> -             return;
>>>>>> -     }
>>>>>>         spin_lock(&nn->nfsd_ssc_lock);
>>>>>>         timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>>>>>> -     list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
>>>>>> -             if (ni->nsui_vfsmount->mnt_sb == ss_mnt->mnt_sb) {
>>>>>> -                     list_del(&ni->nsui_list);
>>>>>> -                     /*
>>>>>> -                      * vfsmount can be shared by multiple exports,
>>>>>> -                      * decrement refcnt. If the count drops to 1 it
>>>>>> -                      * will be unmounted when nsui_expire expires.
>>>>>> -                      */
>>>>>> -                     refcount_dec(&ni->nsui_refcnt);
>>>>>> -                     ni->nsui_expire = jiffies + timeout;
>>>>>> -                     list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount_list);
>>>>>> -                     found = true;
>>>>>> -                     break;
>>>>>> -             }
>>>>>> -     }
>>>>>> +     list_del(&ni->nsui_list);
>>>>>> +     /*
>>>>>> +      * vfsmount can be shared by multiple exports,
>>>>>> +      * decrement refcnt. If the count drops to 1 it
>>>>>> +      * will be unmounted when nsui_expire expires.
>>>>>> +      */
>>>>>> +     refcount_dec(&ni->nsui_refcnt);
>>>>>> +     ni->nsui_expire = jiffies + timeout;
>>>>>> +     list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount_list);
>>>>>>         spin_unlock(&nn->nfsd_ssc_lock);
>>>>>> -     if (!found) {
>>>>>> -             mntput(ss_mnt);
>>>>>> -             return;
>>>>>> -     }
>>>>>> }
>>>>>>
>>>>>> #else /* CONFIG_NFSD_V4_2_INTER_SSC */
>>>>>>
>>>>>> static __be32
>>>>>> nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>>>>>> -                   struct nfsd4_compound_state *cstate,
>>>>>> -                   struct nfsd4_copy *copy,
>>>>>> -                   struct vfsmount **mount)
>>>>>> +                     struct nfsd4_compound_state *cstate,
>>>>>> +                     struct nfsd4_copy *copy)
>>>>>> {
>>>>>> -     *mount = NULL;
>>>>>>         return nfserr_inval;
>>>>>> }
>>>>>>
>>>>>> static void
>>>>>> -nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
>>>>>> +nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *ni, struct file *filp,
>>>>>>                         struct nfsd_file *dst)
>>>>>> {
>>>>>> }
>>>>>> @@ -1700,7 +1679,7 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
>>>>>>         memcpy(dst->cp_src, src->cp_src, sizeof(struct nl4_server));
>>>>>>         memcpy(&dst->stateid, &src->stateid, sizeof(src->stateid));
>>>>>>         memcpy(&dst->c_fh, &src->c_fh, sizeof(src->c_fh));
>>>>>> -     dst->ss_mnt = src->ss_mnt;
>>>>>> +     dst->ss_nsui = src->ss_nsui;
>>>>>> }
>>>>>>
>>>>>> static void cleanup_async_copy(struct nfsd4_copy *copy)
>>>>>> @@ -1749,8 +1728,8 @@ static int nfsd4_do_async_copy(void *data)
>>>>>>         if (nfsd4_ssc_is_inter(copy)) {
>>>>>>                 struct file *filp;
>>>>>>
>>>>>> -             filp = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
>>>>>> -                                   &copy->stateid);
>>>>>> +             filp = nfs42_ssc_open(copy->ss_nsui->nsui_vfsmount,
>>>>>> +                             &copy->c_fh, &copy->stateid);
>>>>>>                 if (IS_ERR(filp)) {
>>>>>>                         switch (PTR_ERR(filp)) {
>>>>>>                         case -EBADF:
>>>>>> @@ -1764,7 +1743,7 @@ static int nfsd4_do_async_copy(void *data)
>>>>>>                 }
>>>>>>                 nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
>>>>>>                                        false);
>>>>>> -             nfsd4_cleanup_inter_ssc(copy->ss_mnt, filp, copy->nf_dst);
>>>>>> +             nfsd4_cleanup_inter_ssc(copy->ss_nsui, filp, copy->nf_dst);
>>>>>>         } else {
>>>>>>                 nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
>>>>>>                                        copy->nf_dst->nf_file, false);
>>>>>> @@ -1790,8 +1769,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>>>                         status = nfserr_notsupp;
>>>>>>                         goto out;
>>>>>>                 }
>>>>>> -             status = nfsd4_setup_inter_ssc(rqstp, cstate, copy,
>>>>>> -                             &copy->ss_mnt);
>>>>>> +             status = nfsd4_setup_inter_ssc(rqstp, cstate, copy);
>>>>>>                 if (status)
>>>>>>                         return nfserr_offload_denied;
>>>>>>         } else {
>>>>>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>>>>>> index 0eb00105d845..36c3340c1d54 100644
>>>>>> --- a/fs/nfsd/xdr4.h
>>>>>> +++ b/fs/nfsd/xdr4.h
>>>>>> @@ -571,7 +571,7 @@ struct nfsd4_copy {
>>>>>>         struct task_struct      *copy_task;
>>>>>>         refcount_t              refcount;
>>>>>>
>>>>>> -     struct vfsmount         *ss_mnt;
>>>>>> +     struct nfsd4_ssc_umount_item *ss_nsui;
>>>>>>         struct nfs_fh           c_fh;
>>>>>>         nfs4_stateid            stateid;
>>>>>> };
>>>>>> diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
>>>>>> index 75843c00f326..22265b1ff080 100644
>>>>>> --- a/include/linux/nfs_ssc.h
>>>>>> +++ b/include/linux/nfs_ssc.h
>>>>>> @@ -53,6 +53,7 @@ static inline void nfs42_ssc_close(struct file *filep)
>>>>>>         if (nfs_ssc_client_tbl.ssc_nfs4_ops)
>>>>>>                 (*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
>>>>>> }
>>>>>> +#endif
>>>>>>
>>>>>> struct nfsd4_ssc_umount_item {
>>>>>>         struct list_head nsui_list;
>>>>>> @@ -66,7 +67,6 @@ struct nfsd4_ssc_umount_item {
>>>>>>         struct vfsmount *nsui_vfsmount;
>>>>>>         char nsui_ipaddr[RPC_MAX_ADDRBUFLEN + 1];
>>>>>> };
>>>>>> -#endif
>>>>>>
>>>>>> /*
>>>>>>    * NFS_FS
>>>>>> --
>>>>>> 2.9.5
>>>>>>
>>>>> --
>>>>> Chuck Lever
>>>>>
>>>>>
>>>>>
