Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBF15AB8E5
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Sep 2022 21:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiIBTe5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Sep 2022 15:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiIBTez (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Sep 2022 15:34:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5D73ECF2
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 12:34:54 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282GF41i029456;
        Fri, 2 Sep 2022 19:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=890FNS213gOUf8pV83Rjc5+Ci+l1U95k7LvkQkGeUQs=;
 b=hSk5maYRaXy4Gh3LXiH1XDNOCjLxKrSubsAWuAPd8MQ6zsbmFkzW0zywdZl/Uzav2zkF
 H85inMf94++nBCtaqzJg/aDlxiyXbYslQ+6eBSKIliZRjSbbJBHDqfN0jpkFr20wuy28
 OzUPMwZ+GGxAUWAtebzpFpRrocl3Gq0W/dpDMcqHzRuIHKjF6iGD+ZXreKc45829phAt
 /+BuRq1TaJAmN1Y1FBrGBJqtNQnOWc+Mt34Ny7OWCTves+AmRQ8Kz+5AlWkMwIpNSF9o
 K8ecsIcliDyvlt7Ly72YHo3r4yHBuBDZppxjNr72H0MZ6NHHoPBAE4bvU6Kkgy4kNSB+ Sg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79pc7mg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 19:34:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 282HJUlh019753;
        Fri, 2 Sep 2022 19:34:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q7tv07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 19:34:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gK8kO8PEHQu2yoJlADeg3pUCWUMgVciAHFqXfx4HikyxPQ43lUwhjyd6JCahP1m0Qa65nwfi7S/fWWNWOo28y4fcffYtUtC9uoQ5K35ZeM3+bKfRKiGPnyQSwhKiVmiZ4YlX0HoUo7NK9MCvKubajGbnNG6uMejXCYXWNHSiAugMaukZdkMrQ/wI0wyfMt0xAeHwp9HPGGDdg8k2zeOFBptfnDOIB/Xk5gD5zBZsanQBRS8OZxFkulAsIVczh459S9Pl+nUtjKoGizZLYGrY9ofzC8y00uDqovQqYeGfKsrpDhrWHXWGzLYtFmpy1fp5U7aA/mBq7qdy7BpfQ727jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=890FNS213gOUf8pV83Rjc5+Ci+l1U95k7LvkQkGeUQs=;
 b=FvYO6dv1adqQYbPTF3HTB3zOsex9T0DKvnChQMCYslNONyxh/8KxIY9ZYLiehNre49a4b2R6IjhKGtU8xxjRKo4Nvrde8OPo9u/62Xb/SwGc2OHuhclcTFX6GgxWpXKuOpvXlsrtzWi09KjA16D3sDMyMDjZ/z3rDzxtUtE3PSyr1bh3F0WsKDnbxGHYALJPcvt6kIraPG3aOoyTL5Jw5aMAyUeglPeBGz5H8Ujajy6ICOf+VJ3La49OF4hwguiSEXxoK7AXYo3Fmb1NahlaqIaA/mlWqqmKxnip9I1U84adrhjhAtQPM57uLQepLtSJ/4qnkoaLeANIKh8iSEjhmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=890FNS213gOUf8pV83Rjc5+Ci+l1U95k7LvkQkGeUQs=;
 b=JQ0aPwriziemL06rYF6LKacwZrkDF+yMWBupWsddyvcOQHtvo79lZM7UozncX+kKlhin0SJgst/gFSfCxfX17iU9U6ew0C4x27ohkHCdWpFs1xIavAzCfKkzEFKugrTvNIpgOqqg6O2ZJWHAKYVj4WKCmsNBAKbh29lGSR65vu8=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Fri, 2 Sep
 2022 19:34:47 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::803:3bcf:a1ee:9e1c]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::803:3bcf:a1ee:9e1c%5]) with mapi id 15.20.5588.010; Fri, 2 Sep 2022
 19:34:47 +0000
Message-ID: <fc5a3aa7-af8e-656d-a16e-c07c201ec62a@oracle.com>
Date:   Fri, 2 Sep 2022 12:34:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v4 2/2] NFSD: add shrinker to reap courtesy clients on low
 memory condition
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1661896113-8013-1-git-send-email-dai.ngo@oracle.com>
 <1661896113-8013-3-git-send-email-dai.ngo@oracle.com>
 <FA83E721-C874-4A47-87BA-54B13E0B12A3@oracle.com>
 <2df6f1fe-c8eb-d5a1-0a11-2fd965555a33@oracle.com>
 <7041D47D-ECB3-497E-9174-96E9E36FFBDE@oracle.com>
 <eb197dde-8758-7ef4-8a7b-989273e09abc@oracle.com>
 <3CD64E7F-8E81-4B37-AAF3-499B47B25D19@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <3CD64E7F-8E81-4B37-AAF3-499B47B25D19@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0101.namprd06.prod.outlook.com
 (2603:10b6:5:336::34) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6665e568-f3c7-4995-6731-08da8d1a31b2
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4542:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VT8lTzBGzsCE9JtbhBU9NSrTpDgpcy0PzoZmb4WdpzCdxEKBE/4R1/KRDRQeUN7hC8dF4U3viRhQj+X4zQtjbHkXAX8aXVcLqX6FqJw1LLLOy20MF7CPfYODa7rLEKvDBMWpoLZinasbQvl2aFm16rRhFJdCk1NZoMCd5W8YNicyjmCf91/3xxnG4H+ighlmAIv3HZZqBsamDkPdrDQ/3S+PNkntrP/MsGq9VqV2RoPy0VI0gDOSMQc1wHaMjJvivsNUKR5VqEYXeZ2N2npVIibiJTgZQdUUXZJaxCHSXz0uW+OyIhhP+0S18PQeE4DmhhkmYb/qFJ5Wid+IU+SOzYsozmtQbSiTtvHQlO3bCst96I+FSfa+ucwl7B4RQ2CWCxScAt5cgw535acB3JyrmU0yxkoSGvskzwV6Asp8YuRNNNj1EKE0LUbbMjPJ+PNbA7LPz8+ZMPG5hQA1jHJiOxvhKu/wO3hdQoJlGR5drawUqzty6jrG33xzIgzHJ8/QfeP4LFw0/M2fjO8m4FQr2Uqn13fEW0ETHlVDJZC8ReoqThe08H9c2qNZhD/yV+O3LvTl8ADs6Ql0WkpqKQu6NkJVFdbMcc0Y/QY9peBUj37BxW5b0QyFOx3E684mlDiXqvUOhmleU8djcS+nElKLVLMOT67eUzqB6s6ZkavWttZYmv2kiX4sp6/CmwINuucZ3NrBJRK78oZH1kii8QOLuYgiqenYV2b2HZqujXaKT6b2ZAkQyCThMf+veKjY+i9G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(376002)(39860400002)(136003)(396003)(6666004)(6506007)(6512007)(9686003)(53546011)(186003)(83380400001)(36756003)(31686004)(26005)(6486002)(478600001)(2906002)(2616005)(8676002)(66476007)(66556008)(66946007)(6862004)(38100700002)(8936002)(5660300002)(41300700001)(31696002)(316002)(4326008)(37006003)(86362001)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3R5KzZRUE5FWGlZQi9TMi8zNzZUbFdDTHIrZHFjenlWZjFkekNUMkxCdzI3?=
 =?utf-8?B?V2UrZ04vekVZQWZneUFBRmtrZHpGY2FENVlMaU9GaHFqMWo3aEFOT0o0Y2hy?=
 =?utf-8?B?NTNlRHJyUEhUSFZtY3pNd1drODZ4WEJkdG9jQW9ySThXYmtJbG9ScEMzMDAw?=
 =?utf-8?B?ekdXQkgvbUh4WVRndjhqOXBDdDhoeURlNmRzd2JQeXUxSVlwZTJlMmRRdW9v?=
 =?utf-8?B?MlNkYk5mblQvZ2J3c015QkRSb3picGdWdndTcUxVWks5L2FGRi9aQVpHMFZT?=
 =?utf-8?B?eGVWSWxqVm90OVZDYjAxZEJXcFdlQTNyL0N4QzIvaU9wZmR2MFJ5Y0hvVDBI?=
 =?utf-8?B?RUJCdXRtZGJVajY0dU9adEJCZmNJVXViRGZJREVhNk5DczNoOSs0MWh5YnNJ?=
 =?utf-8?B?U3NDY0FhUWNvdDZtRi9tOTJOd2htOWRCTWJwN0xsb1RWcVpqT25WeEdWRG4w?=
 =?utf-8?B?TmZPSUhLelFYR3EyaFd2ZnJ0UGd5enpPMDZFbXVzTldROVYreWFNQ1pMREtN?=
 =?utf-8?B?QlNpVmNsOVBKdlZ3NnhoYm5ydGpGY1NUQ0x3eG9nMGNKM1pneDR5ZUh6ZGNs?=
 =?utf-8?B?b0hkZ2VRVEluSWVaMGd3TmFnWGlMQW81SEl0dVluZGQvdWhzbThRUTFrQ0U4?=
 =?utf-8?B?NDdsK091RGxxSi9KVURJdzR3ay94YXN4cmtHUEZZQ0tlRlY5dU0xWTM1cDNh?=
 =?utf-8?B?ZGlDaW5RMEZxcm9SUUk4ajdMTWx4MVhhM2N6UkNkUXRwNWJMMUlSd0hoTkpO?=
 =?utf-8?B?V3BEVjJWeXNDZDhKMXpXbmY1a0FOdWdEc2p3YkRSVWVueDZISFM0Q1pieWdj?=
 =?utf-8?B?VUlSUEZrTHQ0d0haUThHZ2hvdU10bzZqeWhlZDJoSlhnK0EraDJ6QWxWN2Zy?=
 =?utf-8?B?cklwZ1RlUjNTZ1hFNW9OTXRRQVA0a2tZeEtQRlUvRWxzSmVZeER0ZDNST2gy?=
 =?utf-8?B?MGxsNnJXdUExYm9DVUJTSis2T3JEaGF0M21aVFN3amlOQ2NqcXRNNjBzbnds?=
 =?utf-8?B?ZEJ5NWNMdVhqbS9hYXBZcFU2MjdmRXRNY0xZRUhTMDdScDc0Z282TTFaOXVQ?=
 =?utf-8?B?MW4zcjJUT0RWbTNqemhBWlV0ZkQwQkNRYW05NFA2RHdjeVhxbXg0Njkyd05C?=
 =?utf-8?B?OXUxczRjWlNlbTZkelM1TTZ1TXhHUTRMZklqZTlleDlXWmZzS3hXVnQyejhN?=
 =?utf-8?B?RHpUMGZvbml0Qi9qSlJrQU9RZW41NVFMMmcxV2F0TFpZR21TVGNYQngwN25J?=
 =?utf-8?B?VW1PS1VkSDBoT2tXSkpnNW1BWDY2S0tBMWVPT3daMHRuVlV1NE1HMURNWVpB?=
 =?utf-8?B?NWZmbUFDWlNSN0pBTDJwc2JYYW5RaDh6N04zenoyTWRESTlDWTJ4cnVneGN4?=
 =?utf-8?B?S0lZdGpwYUdybHlrejNmOFVCWFUzcE1tNTlIQWthdm9MQWF5YkVtNUg1S2JM?=
 =?utf-8?B?SFFiTHJpSVVuSDNNcmttUUVsNXRobFc3WGFiYk0xNVh4ZHQ4KzgvWlpTVWtv?=
 =?utf-8?B?VGJXYWlYOTZwVGl2UTUzQmRWWExlVTMzU1RqM1FWS25NVmxLbDVVbjU5MFNV?=
 =?utf-8?B?TDJLQ0hQbXkyUWxTSG5tRlhpUldneFNYWkM1NzhGNEpTa3NkQlR0R3o1b3p0?=
 =?utf-8?B?aWhndWlpNFRmL3JJTDgzR3VZR25XUk41ZDNWQlRNQjBrMjIzL1hRazkrYWJ6?=
 =?utf-8?B?ZzAwTThWREdlK0NxZ21wTXlUTHBKMi9HOUdDdUxSb2hwa2dvY3E4VEl6RGJ4?=
 =?utf-8?B?NTB3dDhTMkNGSjlaNStpRWZ5NmpEY25hZlVJc3RHL29LWGNpQzNYQk5sbC9i?=
 =?utf-8?B?UjhxWXlsdXYwbUpLN2VEcTE0MTNVWXc1b08wL2hteFNUdENlalBOSzZ3Ty9a?=
 =?utf-8?B?SmZJSWx5SDR2NGwxK01WL3ZyMXRwbTliTS9hbExtOUtzaElwUjRZRUVkUTE5?=
 =?utf-8?B?VUlqeFd2aURwdis5OUdacCtHWVgxRXJTNHlKd2ZMaThMUVFGLzkyNW5hanFW?=
 =?utf-8?B?WVBlZTgxbVZLOTNFQTdKYk9YcVBRRTExcE5VR2RyeitxVzZnaXBRRFBJcnRK?=
 =?utf-8?B?OXVzVnV2bjVCRmVNNVlsRmVBTXp0NmFlaVZkQ1g3a000Qk9kN1hUREFka2VT?=
 =?utf-8?Q?p1w+yk2rEajojlBZlB3Dvempp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6665e568-f3c7-4995-6731-08da8d1a31b2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 19:34:47.3162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKDb6WFHicBy/3JZq75QAbjP2RtocGITnDM77B+pZyuyTBkLMhbxfTipx6ycbUu0C75R4GxBHaZocL91NuYSkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_04,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209020088
X-Proofpoint-ORIG-GUID: Q_MxpBvSN_lz_6IC5Xn3v7hWMJy8gVyl
X-Proofpoint-GUID: Q_MxpBvSN_lz_6IC5Xn3v7hWMJy8gVyl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 9/2/22 10:58 AM, Chuck Lever III wrote:
>>> Or, nfsd_courtesy_client_count() could return
>>> nfsd_couresy_client_count. nfsd_courtesy_client_scan() could
>>> then look something like this:
>>>
>>> 	if ((sc->gfp_mask & GFP_KERNEL) != GFP_KERNEL)
>>> 		return SHRINK_STOP;
>>>
>>> 	nfsd_get_client_reaplist(nn, reaplist, lt);
>>> 	list_for_each_safe(pos, next, &reaplist) {
>>> 		clp = list_entry(pos, struct nfs4_client, cl_lru);
>>> 		trace_nfsd_clid_purged(&clp->cl_clientid);
>>> 		list_del_init(&clp->cl_lru);
>>> 		expire_client(clp);
>>> 		count++;
>>> 	}
>>> 	return count;
>> This does not work, we cannot expire clients on the context of
>> scan callback due to deadlock problem.
> Correct, we don't want to start shrinker laundromat activity if
> the allocation request specified that it cannot wait. But are
> you sure it doesn't work if sc_gfp_flags is set to GFP_KERNEL?

It can be deadlock due to lock ordering problem:

======================================================
  WARNING: possible circular locking dependency detected
  5.19.0-rc2_sk+ #1 Not tainted
  ------------------------------------------------------
  lck/31847 is trying to acquire lock:
  ffff88811d268850 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}, at: btrfs_inode_lock+0x38/0x70
  #012but task is already holding lock:
  ffffffffb41848c0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x506/0x1db0
  #012which lock already depends on the new lock.
  #012the existing dependency chain (in reverse order) is:

  #012-> #1 (fs_reclaim){+.+.}-{0:0}:
        fs_reclaim_acquire+0xc0/0x100
        __kmalloc+0x51/0x320
        btrfs_buffered_write+0x2eb/0xd90
        btrfs_do_write_iter+0x6bf/0x11c0
        do_iter_readv_writev+0x2bb/0x5a0
        do_iter_write+0x131/0x630
        nfsd_vfs_write+0x4da/0x1900 [nfsd]
        nfsd4_write+0x2ac/0x760 [nfsd]
        nfsd4_proc_compound+0xce8/0x23e0 [nfsd]
        nfsd_dispatch+0x4ed/0xc10 [nfsd]
        svc_process_common+0xd3f/0x1b00 [sunrpc]
        svc_process+0x361/0x4f0 [sunrpc]
        nfsd+0x2d6/0x570 [nfsd]
        kthread+0x2a1/0x340
        ret_from_fork+0x22/0x30

  #012-> #0 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}:
        __lock_acquire+0x318d/0x7830
        lock_acquire+0x1bb/0x500
        down_write+0x82/0x130
        btrfs_inode_lock+0x38/0x70
        btrfs_sync_file+0x280/0x1010
        nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
        nfsd_file_put+0xd4/0x110 [nfsd]
        release_all_access+0x13a/0x220 [nfsd]
        nfs4_free_ol_stateid+0x40/0x90 [nfsd]
        free_ol_stateid_reaplist+0x131/0x210 [nfsd]
        release_openowner+0xf7/0x160 [nfsd]
        __destroy_client+0x3cc/0x740 [nfsd]
        nfsd_cc_lru_scan+0x271/0x410 [nfsd]
        shrink_slab.constprop.0+0x31e/0x7d0
        shrink_node+0x54b/0xe50
        try_to_free_pages+0x394/0xba0
        __alloc_pages_slowpath.constprop.0+0x5d2/0x1db0
        __alloc_pages+0x4d6/0x580
        __handle_mm_fault+0xc25/0x2810
        handle_mm_fault+0x136/0x480
        do_user_addr_fault+0x3d8/0xec0
        exc_page_fault+0x5d/0xc0
        asm_exc_page_fault+0x27/0x30

-Dai

