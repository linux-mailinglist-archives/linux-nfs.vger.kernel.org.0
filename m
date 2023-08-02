Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA87076D3A8
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 18:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjHBQaE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 12:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjHBQaC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 12:30:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792BD213D;
        Wed,  2 Aug 2023 09:30:01 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372FYSpO021840;
        Wed, 2 Aug 2023 16:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MHRH0FoR9mBpQKvMfWkHqg9UkK3B8cL5Z4+kU5rZStg=;
 b=zsik+J6F7LJBBlLSc8qiMTzw4hZjbnuhZ/qImkW4n8ecEQ0IdHsTee1sY/2z4bWt6pFh
 bUNOY0XjFs/lhcRZRzLliWFqbbnxdbQ5L0vgXrjeuH3fuc4JsJgW0QNG60+zcWLhw7jl
 WJ0a4O2qDcv+ROCcY7b/sYnGdRL3pO559W39ol8ixS+bM08wvliqPDFPgazDL1xemUlh
 JvZ+o9kZXmB69hNgvB5sFONQyOZGhxmfaxTfTF4/yKijTnbBg0QdpMjxdsyLAjKHZHS7
 IOWeMnJ2dsz9vxcsi33lBAF/0h7EohjsQlMZlphxOy+QB2wgor3Tv7kYsuXDAJG91f+4 mw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spc7scc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 16:29:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372F6JBw020541;
        Wed, 2 Aug 2023 16:29:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s78df1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 16:29:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZtAO993wCRD1wWBf2aps/6PyFEEZqcFX0oInJEKEN27l9iC2EOR/2YZdTXxMknwpl4TSkmT62glRxW4brWuXbk2oLHZNgcBSxu09QnrsODVtJoqLk7GLZarUEQFQH1TliFssE/fnfIRnM07Q/Gt1PsqXEzpRQfEI+im2eiqmlJakCLipiM+QfqV0ujK0QMnxY87ds8roiw5KEt+V1KRDa9VaMglGKsE82UEUm534nkz+MubjGKJoK4+b8cQkX9Pju/guUUvdHJbeDr2OpmHA/ATJPSNhBzGjD1teunF7HS23PJH8GjxdgtIBKb3hgb7qY9mG/VBxERkbAPmPSnPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHRH0FoR9mBpQKvMfWkHqg9UkK3B8cL5Z4+kU5rZStg=;
 b=LcNyxrZAzxkh+7LmFadg7amt6B3udIxhoEWFXumG5Xw3xvObaC/7w0HYWCaRERGhG1Y5hB5Ca4H0nQak/OGDVkgbEKMc70738P1YfE4RAmzu6I6VXZ2AZmNDE3mu8FjhNDfGeCQn/WIVGM4nh2VHpCCCQDjCpACL+7sZ98y3qFUwmNrKvR5aFvJHc6VBHHCyAfVOXZuLHZ7YJ/Ulby8IhujlNIzJO3mrYnV0yYTLhmDemEpdnRyIZt6zL8W32r8kQjf7svy4RSrH3eBWT4Zrrso7YtdhMg2Mb5W08/kkDZ8fiidvHXFeT7uuCZPwrp8IYZXgCuHUO4hHcXYSstDCCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHRH0FoR9mBpQKvMfWkHqg9UkK3B8cL5Z4+kU5rZStg=;
 b=IEsRXj6YA2cyHFDxmr8bZqXYWpXYDAwE40tLNmUVjATcuB8Mi/Fd8HtiyE/WgIBkYvn/ppIfV3DQ1emCv7WN8Mb/LGb45UweN0R9cWjSvRoWD++vF3mRCBV8acrOdD0PwxjBrop54iqUldD3m0H/AXBanH8gGOB2ILhxKHXl+ho=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by DS7PR10MB4861.namprd10.prod.outlook.com (2603:10b6:5:3a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19; Wed, 2 Aug
 2023 16:29:49 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 16:29:49 +0000
Message-ID: <8c3adfce-39f0-0e60-e35a-2f1be6fb67e6@oracle.com>
Date:   Wed, 2 Aug 2023 09:29:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] nfsd: don't hand out write delegations on O_WRONLY
 opens
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Tom Talpey <tom@talpey.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230801-wdeleg-v2-1-20c14252bab4@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20230801-wdeleg-v2-1-20c14252bab4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0064.namprd12.prod.outlook.com
 (2603:10b6:802:20::35) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4270:EE_|DS7PR10MB4861:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac2a45a-6de9-424e-b503-08db9375b0cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yVAEZ7Y0xkxHKaLb2VqGvYAgjbqaKEYNZ/b6NtnbSVM6LL+O95bdYKgCgccfCTqDJebA+DztnpQdwfu6r+xkZq1UqNkQcahGT/CwGX+ilDfg99qK65sf58MN7ioplWwtPxA6mxRXSxURP4RP/z6D+y85RlxUdo/Edu4svUQ3dRKn9WgOhDiiBT5uMl4qF1uMk4SfO/yLROcSAEm4+cRPIUcH2OMXzM734VZtJC1PiNW4/L/7XaRpNWti3l5wh1otZxr0iGBm0E5wneUsUj6agua8M6xBRk2Wx7ttlGO+UnbuXKJtKp5teV+euPIrEyULnoW7vFZXxOkeHeevnrtiUR49ZzMvJhVtn7ZAkZgZfRJW6G4+gIKp2hWeKObVNGbqSCd+5N4tHhJKpuHEt06AHnOVsqVAzs2mJGSMXyTVcrc9lHtN//A0snqwYpaaGKoJPg3wnu3p4wS0zB/PrKCW491eGqpWu1EsPaWfCl8geG28mao4SZBalKjnvu++NZWqvYVRvCJU+8sS2pAnNxluy3SFVLLnKpNLrTpcrQ1/8BCOkmX8ks/XpVkYCYgYfH5S/zn6P1RX8mF4F9ZKy+OSj4nKkurj4CEYLmqaHf5uFTs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199021)(31686004)(31696002)(86362001)(36756003)(478600001)(110136005)(38100700002)(2616005)(6506007)(83380400001)(186003)(26005)(53546011)(41300700001)(8676002)(8936002)(966005)(6512007)(9686003)(6666004)(6486002)(316002)(66476007)(4326008)(5660300002)(66946007)(66556008)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VklHbHZjQSs4ZEJHdmErdUdIeC9iVC8wa3RuaVJtZ1NUSzNGV2RtZnV6OFRJ?=
 =?utf-8?B?eGgxbmxxQjFtK016OEJaekdvTHRyUTBiM2VmdXN1QVcxRnFML05lQU1ZU0pw?=
 =?utf-8?B?VmxWcjBVWUFwYkdIejZEeHZZZnMyMG9KZlczZ1djY0U0bnhZdWtjQ0M3SUVX?=
 =?utf-8?B?eWIweUI5aWRnUXVIeUE3ejZ5QU9qbVRoZDYyMmUyZDZNTUtXL2RRZE1uME9Z?=
 =?utf-8?B?bmZ2TFdUdk1iWlVpYnV0alRjOGdFZFc1QnRmcHpxWjIwK3ZGSEFpdTNqWTNm?=
 =?utf-8?B?QWkzVUhQbUk4RnlkUGpZVWtpY3VWWWIxVzZTbHNDbzJlb2RMWnpweUdSUFg1?=
 =?utf-8?B?M1U4aU1PY0lIaFl3MGZETk1rVXFmQlg5bXE3UitnTitBTER1SitGNTdkSFR3?=
 =?utf-8?B?alpqTjdhNStReVBaMzlvUDFtQW5nbkRHNFk2Rk9yMzZVS3F1UlN3TkRnV3VB?=
 =?utf-8?B?U0xpL2FGUHdVUzk4VnRmU3JlYm1pR3NwSU9LSE83enhvbmRzY3VZd0tUc0hX?=
 =?utf-8?B?bVk1UE80OEJEY21JempTaFUrbG1DOTVJci9jUWxsSjAzM3hSWDVhd3NKL3g4?=
 =?utf-8?B?ZTUrUFhaMW9qSHlxTFlJTTRoMUE0a1hDVXVZS2pJek5vL1h3V00vc3JPL3hi?=
 =?utf-8?B?Qm1XM1drZUprWmRXMStLZWFYZEV3dzBUTmpERFgrQ2xLVnU3YjUyL2xNZVV4?=
 =?utf-8?B?UHFDR0tGV3FUVlFrZ1JOZloxSENBeTQxeU53bnJEWGlHaFk2OCtucDZMOWdZ?=
 =?utf-8?B?MzFvMjNMbENBRGxnMFJGQkV3bTltTStIWGc2V012SmlGZzFERUswdUFQVU0v?=
 =?utf-8?B?RXYvQktiOTR5NHVJdFQwazNUVXNJRzJndnpZa0NkZEJpb0FkWlM1eWx1QTZa?=
 =?utf-8?B?Ym1tZHNzOEI4ZmlLdjVLaDAvZXpqRFdhdVh4SG5wKzZCT3BYWlZ6SkZLWldr?=
 =?utf-8?B?WGg1NzlzYlAvVWxFbmJsYk1TM2Q2TTd3UUFuVWRuM0txbjJhcVd2MWNPdlNh?=
 =?utf-8?B?SUZIeTRNeWFyR1F4RmxOUXhvWlZIVDRDMSsrNVZDQTNyb2pMVG90dW1QMlFk?=
 =?utf-8?B?MDJrbjIxbmNCQjZPME9TdWF1RkR0U2YwTHMwNmRhbUpFSVVwK0pVQjZPQ1kr?=
 =?utf-8?B?bVlHMEZUdHFZVUVDSi91d3BtSjhmbkNPYjZZOElTRmJKbWFOd3dxMHpqVnl1?=
 =?utf-8?B?akNZYWNHWDRXUkowUWJ6L2N4RzdlOU1mY1dHaERId3BxcFFSeDJQYk81S2pE?=
 =?utf-8?B?WmJ5STZ5SUFnbUZZTU5Ra2xCZHMwWXpXTG94ekh4MmdoYnNGOEp5TDV3RHR5?=
 =?utf-8?B?dmE3ZHBYZHRjdVdkMERhNU1WQmlmaWMweWlLRmRCQTlWaUtXUkIwUkl5V1Qw?=
 =?utf-8?B?TStpVjNRRW15T3l1dWx3K1JlMUIrak53dEtsdFIxWHFvMERrNnoyaWtaOTNU?=
 =?utf-8?B?bW1WSCtrbmlqd0R0dHJVdkp6WEoyT1dPTENyRFpTNnNVck4xQnZ0UHcrdFhl?=
 =?utf-8?B?VkRWbk5oUHV2K05KMndQekJ0VEpzSjNYZ1BDNDZHWkpudnFFWUh4T01hK25z?=
 =?utf-8?B?OFlSRkpmamYzRklHMGsvV1F3RWFDU3RKWlNNaFE4NUlWODlxNnlSa2lVMlFi?=
 =?utf-8?B?SVJueWRGWG8xUDR0eHFON0lWQWpaa2dhd2tldVRWNkErMG5sU2I2Ky9PajJC?=
 =?utf-8?B?SC9pQzBoT2RWVTFEUERoNVB4VHFzUGRBdXhMSi9xcW5Ya0QwK25BUmFQWUQz?=
 =?utf-8?B?SGxpOEpLaCsyS1QzdWZGWjl3R1haVVp3dm8xN2RkaHpKM2FYQVFFQlFqRXF2?=
 =?utf-8?B?eERuRmcvdFd4dkVwRlBzVFJSU3NrU3pwVUREQ05yTnQ1UlBmQzd2YUdwWFZa?=
 =?utf-8?B?d0J6MHgzc08wR24vUWJ2NVpueG9BQm5vZlQ3VjNSQmFLYnZYdEFGQ0NTcUxJ?=
 =?utf-8?B?c01nMVlWaHRKd3FDNWNaclYrQUZXbHhRc2lYZEt1MWkvL21HR25WQnQxSitJ?=
 =?utf-8?B?Q1pCQit3TXdlY1lKNGpCWXEyL2ZnaC9OQjlINFg0RTJuejNwaTdMRTZWMk9a?=
 =?utf-8?B?Sk5WQlNYak4vU25QWHRVYkF6b0kySUFKU2NIbUQ2bFpIVHlwanN3N3B5NWdE?=
 =?utf-8?Q?/a0JwWJqROUxWAAEEcLbHmNR9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Wql0pk6cYLHSuTqcsBa5MxCnFjZ7UUy5dqyRLOv+Q9biF7GYoEdxy6kzH1iDpKyVPmrCi3+5G5etlND7F5mG/gCIyGUtFEOMxhyK0ACAlVOK+7XFougL30F83y0jMSVouAN2gGUH3vnz5YZsz/ZHunRLoLTifIlh66wURguD0ZFvmofn7qkxHCsMBn7wo/z4N/kmAvo5g/SJHpoLQVMY0cRvLIDiADRGmSIfknZVyQYXNzCrjp7ZeALrUQiP5tpsWI0v6EIwwv5j/bf52CZ71eA5W5jboJklY8RP/JDes+6CNoL2Z/IwE7h2e3uID2T2Z0a8I7K5s4XxbVfVmHv3LQ3pM9gzH4LhRciWmYQO/gwH0f8QLLOkCxXIN/38Tv7dbyTWFl8qZZx6bnAacOunR7n1/fy2rrExSjHbM5rPpggXHPNrMJ79soqP4/rvm520+R5rrtDDKeOkhJFu8lVvx4CFc6c7ZwVn+Q7ieD/QpenUdmNdaFOaTpJwxf46qyzhbkeJGNOTBSnyuTV+4bierZ2qwJGLTydwU/ztB3ohcRAsekn2Nl1YJYhaOTg0rqt9XPWn1W9piO9VoLkUkURnvpECWUMQ3kK6b2T1sWj5Oiz6zPuQbwrHGHkXhfhLlDNGkR2xqOeubcwX4zOswlirTTitXk4F15pN+vkaorAap+1XzfihyZGPFd2ygfmyQWg6JIlRsUS0wuvKjZJgrJi05/t4wrlb6l/+KRgUaUZYbSs1W5ayEfmJGg7UMTvdQ8kdgOEXZtwqfKckxsZrA37Jn/8ZcKn3c7vGjA/sNxXi5QPasXTuKtUA9v50wT2DwO/NjENgNaqLU3qefeWDPWnW3ZAEwKRcKJ1R548hXsgRq3NgkDTeH1fUtTpAHfXqCUPc
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac2a45a-6de9-424e-b503-08db9375b0cb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 16:29:49.2162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4olItmmw/kdp0TrxVFt4OGw6v5ipF59+wYnUIY/5tEmX0GLqjTpanHD5dtLHyius57hiRx03r/3OZ4/MwRO75g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_12,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=849 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020146
X-Proofpoint-ORIG-GUID: DNL08SQzO00UWb3CtOOTYrmn295D-rrd
X-Proofpoint-GUID: DNL08SQzO00UWb3CtOOTYrmn295D-rrd
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/1/23 6:33 AM, Jeff Layton wrote:
> I noticed that xfstests generic/001 was failing against linux-next nfsd.
>
> The client would request a OPEN4_SHARE_ACCESS_WRITE open, and the server
> would hand out a write delegation. The client would then try to use that
> write delegation as the source stateid in a COPY

not sure why the client opens the source file of a COPY operation with
OPEN4_SHARE_ACCESS_WRITE?

>   or CLONE operation, and
> the server would respond with NFS4ERR_STALE.

If the server does not allow client to use write delegation for the
READ, should the correct error return be NFS4ERR_OPENMODE?

>
> The problem is that the struct file associated with the delegation does
> not necessarily have read permissions. It's handing out a write
> delegation on what is effectively an O_WRONLY open. RFC 8881 states:
>
>   "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
>    own, all opens."
>
> Given that the client didn't request any read permissions, and that nfsd
> didn't check for any, it seems wrong to give out a write delegation.
>
> Only hand out a write delegation if we have a O_RDWR descriptor
> available. If it fails to find an appropriate write descriptor, go
> ahead and try for a read delegation if NFS4_SHARE_ACCESS_READ was
> requested.
>
> This fixes xfstest generic/001.
>
> Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=412
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v2:
> - Rework the logic when finding struct file for the delegation. The
>    earlier patch might still have attached a O_WRONLY file to the deleg
>    in some cases, and could still have handed out a write delegation on
>    an O_WRONLY OPEN request in some cases.
> ---
>   fs/nfsd/nfs4state.c | 29 ++++++++++++++++++-----------
>   1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ef7118ebee00..e79d82fd05e7 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5449,7 +5449,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>   	struct nfs4_file *fp = stp->st_stid.sc_file;
>   	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
>   	struct nfs4_delegation *dp;
> -	struct nfsd_file *nf;
> +	struct nfsd_file *nf = NULL;
>   	struct file_lock *fl;
>   	u32 dl_type;
>   
> @@ -5461,21 +5461,28 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>   	if (fp->fi_had_conflict)
>   		return ERR_PTR(-EAGAIN);
>   
> -	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> -		nf = find_writeable_file(fp);
> +	/*
> +	 * Try for a write delegation first. We need an O_RDWR file
> +	 * since a write delegation allows the client to perform any open
> +	 * from its cache.
> +	 */
> +	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
> +		nf = nfsd_file_get(fp->fi_fds[O_RDWR]);
>   		dl_type = NFS4_OPEN_DELEGATE_WRITE;
> -	} else {

Does this mean OPEN4_SHARE_ACCESS_WRITE do not get a write delegation?
It does not seem right.

-Dai

> +	}
> +
> +	/*
> +	 * If the file is being opened O_RDONLY or we couldn't get a O_RDWR
> +	 * file for some reason, then try for a read deleg instead.
> +	 */
> +	if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
>   		nf = find_readable_file(fp);
>   		dl_type = NFS4_OPEN_DELEGATE_READ;
>   	}
> -	if (!nf) {
> -		/*
> -		 * We probably could attempt another open and get a read
> -		 * delegation, but for now, don't bother until the
> -		 * client actually sends us one.
> -		 */
> +
> +	if (!nf)
>   		return ERR_PTR(-EAGAIN);
> -	}
> +
>   	spin_lock(&state_lock);
>   	spin_lock(&fp->fi_lock);
>   	if (nfs4_delegation_exists(clp, fp))
>
> ---
> base-commit: a734662572708cf062e974f659ae50c24fc1ad17
> change-id: 20230731-wdeleg-bbdb6b25a3c6
>
> Best regards,
