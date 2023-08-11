Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B99779670
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Aug 2023 19:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjHKRsE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Aug 2023 13:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjHKRsD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Aug 2023 13:48:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DCC195
        for <linux-nfs@vger.kernel.org>; Fri, 11 Aug 2023 10:48:02 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDQ5DJ005218;
        Fri, 11 Aug 2023 17:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=W6337nm7fP/rrtyT8G6hQA3+47clYWHx9KGikp7cePM=;
 b=NkpOHnMHn+kBqwpIkf9nl6shPwP3BzLJ4TQTKiyHYUs8HVm8C4944M9HyM/wG55dB8Xk
 DXYMA+5nPaYOm2yrCgxGTLw2lsapdlbftwKD+/CYLq8fgK9JQwoxhMyAmb1ztv21dL0Y
 yueJ/BT5pj8/rESEFk86JdMWIrKhLHoI3hCzgk374T++qGPOk6LCMpJbPgPIKf/UTxyM
 tE+J4RyF8zdVvw0gHcoAXZd2X5H3X6hOUzX8aNBnxdYRnUa8d/qHaEvtfe2t6kMBJ3B3
 Nw2L6gF+5PXhjf6/im7i1Bq3sAL/BiRKkq48g7X5eeqekWpErOG/cTMsWJGuEOaZOcPh FA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8y49krd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:47:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BGUp2Y000361;
        Fri, 11 Aug 2023 17:47:58 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvgkeha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:47:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDdoINnAPmn9gbmS51zid1B/BI8aw+ZZ3aTETyoft4of3yHJ360iq5e7j2HkxGsJtJW/eB2H58pryJM1WesboOpslslbR0PB3z6hVOYvSidlbg+rOmeTuV7C/SPyMTEMRIpyQ92cbPgenVh0GBG+BHH53kbGSXVbCA83h0ODuxFJ1xmeWBKpo3I9kU5uspEm/LWfvTQsyxCDhalFzLgbZhsbOgzPA+1cYRaAIUnzOWu1r0di1X48lc/2doW7qUwOKrvyiSb5oRBt1bjNtIAVJ9kOmIP98bLDpkyMWVjWhr8L5JO/iUfJwpMTOMgEYt5qMmdQ6TX2rxtAxBWvbLtz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6337nm7fP/rrtyT8G6hQA3+47clYWHx9KGikp7cePM=;
 b=ESgEitH2enoB36489b5ilGN/XcHYtJawswZ9aiNRPgv/ODDrE/raRbnp3YqYmzCuAReEOjrHMPHzpWSwF34lMaDJZvOu1zXUbY/ya9c2J9EpDVOel0HTbntiEEKtTCez+eV2hMdz2X55dPertr2iSJCY/exdKGpY1dtMvvib7xqlk1Qh+BbkPhofEU2yiQmb8PZtpfmGv3k5Pn9KEA1A1kjUtqvYp22brVmrvtsNRaig2diA5binhAELNQXW6R+OJPHZUkoeeqNwwR2ekB4cKnMWaDk06qPMO5sgdJNZ9FsRkud+nnIpzkNfCZxDFGd+BfUPwNw/nTS6hg2usK04iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6337nm7fP/rrtyT8G6hQA3+47clYWHx9KGikp7cePM=;
 b=b5wy7wiJ3xmDGmkhsRTD2/bC+e1WBc8iVIskuJy/MRVuF2m1vN/MI/P6nlgtKirDHNBGCtpx13K3axHdDYu1+0Ig0KgxO6PDyPvay24Apt2COa/TyBX2+K3Wr9+UtPmHP4R1a/MR3Woe79yDfivMAvHyya3WWqB+aD2c8847hwI=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by MW4PR10MB6345.namprd10.prod.outlook.com (2603:10b6:303:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 17:47:56 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 17:47:56 +0000
Message-ID: <83cd1107-2efe-f16c-2015-3da15aec12a5@oracle.com>
Date:   Fri, 11 Aug 2023 10:47:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v7 2/4] NFSD: allow client to use write delegation stateid
 for READ
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
References: <1688089960-24568-1-git-send-email-dai.ngo@oracle.com>
 <1688089960-24568-3-git-send-email-dai.ngo@oracle.com>
 <6756f84c4ff92845298ce4d7e3c4f0fb20671d3d.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <6756f84c4ff92845298ce4d7e3c4f0fb20671d3d.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0230.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::6) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4270:EE_|MW4PR10MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 729eacf0-61bc-467a-4fd7-08db9a931807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8g81uyzp0NQ1E9ky8aynVoP9p26lkj2w1sDwKbRG71hJiiTelth20FWqRJ6qV2dnrzlir0HG5UEWRwL3WczrRYIyLhi1cj3FzjGS8W00eBLcXRThOuonvYlnfPL5Get/Sol1r7W9bUQlmdl7uN2F55a6Luuzj4Jh7Wikx1VN+eWoBGdjG4Zqs4ITrIuH6Rqh83VTbbygXhyeSnA5hwuI4Ct0ZTrFibMrnHwG4SjM7W3l78BmpaoCmMqzT9fkbYkyrYxppfhJnEMbB/OcQbl05HPwqaAebffroMEZ3EhH4YWoM+U34yt/WMu3coQtnv84DqS2hfnLSOv/In0sqPQyvdwu9CnE1ugGE3RRBNhp6XfhiE817/lnNhFRU9csj8cXV58wZLD+VawVxtr8fJ4lK/iKy/NHTy2wyS7+qBkUqPSiWjD8GfJEpSC0BQCqtoxouQD57909UPE5Tuat/PJYFHFPA4vRJJIrjt05615OgtPokoClspRv6SweajooYlk8nO6PKSS5cm+kL6ZjBOjWgU7hZDNlFoMOYycFiDJ9UM7x52/AnO3RR1hjVHKMZGrH34Mk+Z+PUtd5m1rObRLqZOMotcrDBwYWuJNv96A3jKzKIb/My4CpitcSgdu14cPg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(39860400002)(366004)(1800799006)(451199021)(186006)(36756003)(31696002)(86362001)(38100700002)(31686004)(4326008)(8676002)(8936002)(6506007)(6666004)(6486002)(478600001)(9686003)(6512007)(83380400001)(2616005)(26005)(41300700001)(53546011)(2906002)(66476007)(316002)(66946007)(66556008)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHpQNWVPTXNqaHRwZVVtV0h0SEFPQklzVDlJV3JQdm9iSHpEWGlaRkF2Qi8z?=
 =?utf-8?B?Tm1IQW1JN3c1NXRVYXV0MGhzZkY2REpOdHlZcTJFQ3RFd2FOWlFEU0VzSGUw?=
 =?utf-8?B?aEhqTnFrZTNMd3IyL0pCWGhFSmxpVDlCdkp1NGJYdmo3d0dlOC9uRU9oRG0y?=
 =?utf-8?B?N05VVkIrMlpWUWFFa0QreURoUjBUT0NNRi9rUysvc3NXK3JuTXRZaWtFUTNh?=
 =?utf-8?B?dFZHVXMzRHNHbFBLZlJRYmg2YWtOWXlDK3pyQVExNGR4eEswK3F1TWtrN0hS?=
 =?utf-8?B?VHc4cExtZlVVWnFRQWE4ZjJvMXI3MDBPaSsxaE5wT1BMZTdYVzNnU01mUzYx?=
 =?utf-8?B?NE51a01vTDB3dExzbnBEdXVMMm1HV0lEUUZYNkpzOWkwRFg1OHdieDRWRzdx?=
 =?utf-8?B?Wks0NnZPL21yM0t2SHozMytWQnJwTytoRVhqS2ZNUTUrUzRhWThoaVhEUlRF?=
 =?utf-8?B?dEozTTZsNWZnOXZFQ3FzaFpya2d3QjNSdWlWSnAyMklubGFYMVgwelZYSENY?=
 =?utf-8?B?ZWpkd0hMNDZNRGFHdHR3NDZtTGxNbER0N1RNZHlGdUpLZmhnalZvNkw0T3hD?=
 =?utf-8?B?NCthTlFsS3FEMjNsU0h5cTZmRUFpTmFCT1lJNUEyTVFaZDViZkhVOXNaampK?=
 =?utf-8?B?dkw1bCs1QVE5OS82cnFwSzFjNXJsd1RPK3JaajNIQURtaDBjUzdza2RzOW9u?=
 =?utf-8?B?VERId3pTTzcvOEhzSG1Ca0ZMUkN1NFpIbjczY3hKME9hcUZieEJUZnB2aDJq?=
 =?utf-8?B?cEx4anYyV2w1SHBLUVk0VHpoNVdrTnhISTFFYS9HTG00U1Vmck4veW9namhG?=
 =?utf-8?B?UkFYRXdRL3hldWltSVZDSEY5di9lOFBubTdOSG9POGhxeXA2MXRocUtuM0FD?=
 =?utf-8?B?MktKbFM3U3VMMVdZUHV3aStZQ0M5MTU2eU80T2FERFk5MHBoK3EzbTJIR0V6?=
 =?utf-8?B?ZHpvN1U4dGphS0kzUXQ1UjdTR2p6dDBna2RkU1NFemhkOHVTUnAvd25CWkkz?=
 =?utf-8?B?OFkzNjMrbk1OYUJyVmpDTHBVMVVOODUwTzB1Qm5KZ2R2clA3RGd2b3F2S21Z?=
 =?utf-8?B?aWtLaHAzZ1BkcTdTWUpIaXByTlpYQmZCKzFoMGlGUi9uVkNINERrS2poZWVG?=
 =?utf-8?B?Y0kvZG95UUQ1QjVEMThLVm1ZaWdEN2FTSHRyK3hPT1QvSXQ2L1pKZHJzVEZZ?=
 =?utf-8?B?L0ZjVEMrSGNHbFBlZ2VST2ljOFRXVG9BbUg5dE12cldvTEJzanBla1VQSVZt?=
 =?utf-8?B?TFUvd1JiWXFIWEtjdVp3SU1QUS9aaXV4Qis3eTArUmh2UWxGWmw1S0ZTcnBN?=
 =?utf-8?B?REsraEJXdG5FRWtleFJzVTFaMjBNTm0zSFk5d3I4UlRaVWthaW1pSHhEc1NC?=
 =?utf-8?B?MCtWb01FUTBacit2eVVaZXZCYVE5Q2kxbklJSGFNRjJrZWpHSllWT0dPWUJP?=
 =?utf-8?B?a3lvNmJMZWFLZEg4VGduOFJJb01sbkRlbGRnTWZnRTBncjA1NllSeTNkbno4?=
 =?utf-8?B?R2hyRHFKb2xKdTNFeTYySDVYL0psdXN1NHRCYUZQVDdtNDREVjErcjA2Q1Ns?=
 =?utf-8?B?cXJ0VXc4cmcrZ1BYU1BVMGJJZTFFOEo3S0x6dEgycnBpV2RoWGluVlZvcWpW?=
 =?utf-8?B?Rk11UitnamV6K2s2aFFmVU9hcE83MUVzOGZHZWJLTGFXOEVhZDJiV0ZIMFZM?=
 =?utf-8?B?cmhCSVNUUFZuN0JqODhHZDJRc0NHbXlZbHRUeFljRndVcVhmbDUrVnJadGE2?=
 =?utf-8?B?dWpmc1pZU2hONnJqREJ0b2x3ZDBXcXBjc2RhUjRKS1g2NDR1L0x5aGxZMzZj?=
 =?utf-8?B?N29MV3ZKUGdyNkIyK1VROXRveDlhbUJZYjQ1OW1CWFZVZ3h3SDByOU8zTUxT?=
 =?utf-8?B?UG1Wcm16WHd2cWxQYlNYdC95UEc0NWZiT0ZOSFhIcWtFYlFNeE1VdUl1MTE1?=
 =?utf-8?B?TVZZdlVxWkl3eWtiSGMwWTJ2VkpraFFLN1ZpcXQ1MGM4YSswckxzbWZUcHpU?=
 =?utf-8?B?a000aytMMzV6NDVzczRjUGpBRk42NDhjZkc3Sm9meXZJZjNONEptUzJRY0pJ?=
 =?utf-8?B?OVkwMysrdmdGOERidXgxRnQ1c2tSTERDMGh2YnFlYk5RZ29SRFowaG5KbThB?=
 =?utf-8?Q?9pTWVINqlMtjXIaMqXVrQPGMC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iNDgji7Lk/H23pXbTOqW2vooJZB9BfF4MrpeFXEN+eWRxkzoh5TQAWvXVph4jmoSynhEouy+6T4uuD1I02SVr+S+ZOmHYsGUidBMPN2rDOCstO0Hzy7jpwPCiqb51QI0B9u7Wl2+mFu3NiO1wiqX8YtkYRnzAVpvQD//lU71txAr99n7xkckMiaq5fr7/zNN2W7mxd3xVp2sUPOCudAAqNLVoh1ujDkeKHLOwca0iCoN86g/Zehz/xaDBUzyXySV3axD8FWyUgqDxdfkmhpmOcWQO6ChgPcaL4CF5ibpF0XRZzWBDgE6AVtEdAvCk/2f7ROGAvNZ2KphVVllcBXuF7/sR+clICdn+blgt30Y5hdJM2p8Cxl2q2g/OF04ShSNNVzIvWkLZ0JQw/5ND9eeVgQ4Aa0N5A4s/+MfnfkuYxZEEB08JCsFuu7AVzkAb5itdKr5aNwJBVm7csEjZid0/0IgB5P++oROOvnWVdZBWbdQhVCe0vunWBFHUVcOV17O+8xv0f0osRD1QFKfQI1W+F8g5WIDPjx+2Voxj8x17yLmwbdL9pxeoriHWNwTQFyGoHtzAJi4j1SMhBaC2pjUvdX4jWqFmSnmGdkUIJZ83XAfU7fV7yU1/oKGEs8HJmAaJvQigDm2g43xTV81zIUlKM50aemmAn/X7W9F4ifT0Meo418Rs4E4IAOQgpjap/kshCExP68oRvkZuBwdAcJyGO9M7vWhBiREfFl73F5iRiOLe65LClpDtGDGjOisVpxVXKm19GBTtjlSugRYYQIfTvwcplXkGcPy/EiMbD8ig9k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729eacf0-61bc-467a-4fd7-08db9a931807
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:47:55.9571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hk1yJ0OMrol0fH/TxsIToHaoH1t+wd2KEXNM8xUWng253Bekt7CdifATylTKwZJzWlB6+Ve3q4J6WUolNUmHxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110162
X-Proofpoint-GUID: ZPBLqyZyCC9hOWzgWMDHd2-XdJCFKES0
X-Proofpoint-ORIG-GUID: ZPBLqyZyCC9hOWzgWMDHd2-XdJCFKES0
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jeff,

I have not looked at this carefully, but since now we only grant
write delegation for OPEN with both read and write access then
perhaps this patch is no longer needed?

-Dai

On 8/11/23 10:22 AM, Jeff Layton wrote:
> On Thu, 2023-06-29 at 18:52 -0700, Dai Ngo wrote:
>> Allow NFSv4 client to use write delegation stateid for READ operation.
>> Per RFC 8881 section 9.1.2. Use of the Stateid and Locking.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4proc.c | 16 ++++++++++++++--
>>   fs/nfsd/nfs4xdr.c  |  9 +++++++++
>>   fs/nfsd/xdr4.h     |  2 ++
>>   3 files changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index 5ae670807449..3fa66cb38780 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -942,8 +942,18 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	/* check stateid */
>>   	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
>>   					&read->rd_stateid, RD_STATE,
>> -					&read->rd_nf, NULL);
>> -
>> +					&read->rd_nf, &read->rd_wd_stid);
> I think this patch is causing breakage with pynfs. WRT3 sends a READ
> operation with the zero-stateid. On earlier kernels, this works, but a
> linux-next kernel rejects this with BAD_STATEID.
>
> nfs4_preprocess_stateid_op seems to assume that if cstid is set, then
> it's a copy operation and anonymous stateids aren't allowed. Maybe that
> test should be something besides checking cstid == NULL?
>
>> +	/*
>> +	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
>> +	 * delegation stateid used for read. Its refcount is decremented
>> +	 * by nfsd4_read_release when read is done.
>> +	 */
>> +	if (!status && (read->rd_wd_stid->sc_type != NFS4_DELEG_STID ||
>> +			delegstateid(read->rd_wd_stid)->dl_type !=
>> +			NFS4_OPEN_DELEGATE_WRITE)) {
>> +		nfs4_put_stid(read->rd_wd_stid);
>> +		read->rd_wd_stid = NULL;
>> +	}
>>   	read->rd_rqstp = rqstp;
>>   	read->rd_fhp = &cstate->current_fh;
>>   	return status;
>> @@ -953,6 +963,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   static void
>>   nfsd4_read_release(union nfsd4_op_u *u)
>>   {
>> +	if (u->read.rd_wd_stid)
>> +		nfs4_put_stid(u->read.rd_wd_stid);
>>   	if (u->read.rd_nf)
>>   		nfsd_file_put(u->read.rd_nf);
>>   	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 76db2fe29624..e0640b31d041 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -4120,6 +4120,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>>   	struct file *file;
>>   	int starting_len = xdr->buf->len;
>>   	__be32 *p;
>> +	fmode_t o_fmode = 0;
>>   
>>   	if (nfserr)
>>   		return nfserr;
>> @@ -4139,10 +4140,18 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>>   	maxcount = min_t(unsigned long, read->rd_length,
>>   			 (xdr->buf->buflen - xdr->buf->len));
>>   
>> +	if (read->rd_wd_stid) {
>> +		/* allow READ using write delegation stateid */
>> +		o_fmode = file->f_mode;
>> +		file->f_mode |= FMODE_READ;
>> +	}
>>   	if (file->f_op->splice_read && splice_ok)
>>   		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
>>   	else
>>   		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
>> +	if (o_fmode)
>> +		file->f_mode = o_fmode;
>> +
>>   	if (nfserr) {
>>   		xdr_truncate_encode(xdr, starting_len);
>>   		return nfserr;
>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>> index 510978e602da..3ccc40f9274a 100644
>> --- a/fs/nfsd/xdr4.h
>> +++ b/fs/nfsd/xdr4.h
>> @@ -307,6 +307,8 @@ struct nfsd4_read {
>>   	struct svc_rqst		*rd_rqstp;          /* response */
>>   	struct svc_fh		*rd_fhp;            /* response */
>>   	u32			rd_eof;             /* response */
>> +
>> +	struct nfs4_stid	*rd_wd_stid;		/* internal */
>>   };
>>   
>>   struct nfsd4_readdir {
