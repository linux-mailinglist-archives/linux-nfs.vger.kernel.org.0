Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEB4587095
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Aug 2022 20:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiHASww (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Aug 2022 14:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiHASwv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Aug 2022 14:52:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32EA1AD9D
        for <linux-nfs@vger.kernel.org>; Mon,  1 Aug 2022 11:52:49 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271HrwZx020251;
        Mon, 1 Aug 2022 18:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BV7eAOoAvpwVIFQ0evo8e32G/uwlDnPVlOD9zYubmD0=;
 b=r5cCmkGneVsqMNmUrZSC06a5mfJkCY2xv6SbyWkYtrdF4jQAg9mpyJS2MpaDf7uomPZh
 MkrOhA77N0Wu7v+PpR583UM07vA/nIdygIq1RZWv7JKCbzSaMa8ukC1TeAmvW8TM2TFr
 5qgvjRWgcd3LS14/w/KSk1mUM0E7NtHBzf/Y8M2wFitV1QXb8fN10FvtJu0EmoTLboy1
 t1KsE2zmTX5JHhvdOWA832ClhDtdQvDsm57cxSgdFTQaQw46b296y/5Byh7mrpYSsDxa
 +tXEK75KK3+rqXoSxuJZZz7chsRtBgUsfW0TAfcd0UMqNfWw6q9u7OMKIkzLrs9cl7wb tA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu2c4jjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 18:52:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 271HTleD007473;
        Mon, 1 Aug 2022 18:52:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu31bcas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 18:52:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yub9exDDsWAVOTFgQWNuG/N98iwc6z6z4p7GMMC9ji0kRz1P2J+tx/FprI70SVtfSwOqTjDxAyjhfuJwXW10qVN59HKCKFchy+/a4pL4xW9rZptqNBGmhQOOY2ochggIKNBOkNPY7+Nv4zb/kYc8HeTOXfIRHFfOjleaAlJrF+zzSQyrWPr9ioALwsHUwhD9UN7nkxHGV5pLNqT0n5T4Hzk6P8E86M2DyJ7M+Fs8LqVXHA1If4Vw+pOoMDOoeSduy6W47CxOr9aGQOhSWx6a1Y7eUrz4AM8G9oLNxNnHP1DkA/PIt/bndJeliUtrcPkeliy7+S+OFLWFiqZd7QrkJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BV7eAOoAvpwVIFQ0evo8e32G/uwlDnPVlOD9zYubmD0=;
 b=e7zRRaqXUU/VFwg4fdJkyw2g50phw5ZV1KM3Ojsh44qxMCO7YMDvCgrdCgPk1m2V7UcZl0ZY+9wbjIIkz7rPlNNEh05I1BTqo/cMf4zFGjsJby6eU80fyEQWJN0WGynxj8CRrYX2453ubWWqO7N8s17O8D245cJwikwwNNV5ejnYz1ivXu+MMRnE4AJWlOS67+7D1+l6GZhy2x/Q/xwCrZAKOgiZSkND3qhiSbU4eFHeqrAC/EUqzSeY6CDKsGbajxzTZFDf9boUYi8xlRH85+5SoXHiy4id6OIfsytYbPXg+Nk5o9ujmhdhITdLx1rph4aTQDxm+Jq9hqx3Zs9TIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BV7eAOoAvpwVIFQ0evo8e32G/uwlDnPVlOD9zYubmD0=;
 b=VdxayVGr3TVZ+m9d6bCNqt15w8VX6F5Tqif4VvQDdhtkdl5H8iKpTco1s+nk+qYqoVkJoeVYcaD7MoFQr7EkaIYXDMbD8ktXu6GLnp8gqd6dzx136pNGdrwOKuj9usnvJhkQEN+83FlOlm5mxbBfQq44pyJ+5q8DiVz2DjNMba8=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH0PR10MB4808.namprd10.prod.outlook.com (2603:10b6:510:35::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 18:52:36 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd%5]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 18:52:36 +0000
Message-ID: <c969d149-36be-a161-2b2a-469dbf7b9bcf@oracle.com>
Date:   Mon, 1 Aug 2022 11:52:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] NFSD: fix use-after-free on source server when doing
 inter-server copy
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com,
        olga.kornievskaia@gmail.com
Cc:     linux-nfs@vger.kernel.org
References: <1659298792-5735-1-git-send-email-dai.ngo@oracle.com>
 <ea6d0556198dd6b77f1ab711401ca65bc39e9912.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <ea6d0556198dd6b77f1ab711401ca65bc39e9912.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:8:2f::27) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 142e186b-d7a0-4827-e1e0-08da73eefffb
X-MS-TrafficTypeDiagnostic: PH0PR10MB4808:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0jPfhV95sOCILSLT6g5M1dW6Apt7j6+/dqCh8SXGldpqYPupd6LgJ83PVjf0pcqhk1yWZFoC2l0dtQxi0YgaffyZKtk8/6La3fGMaQ4WygQfupE+6sHx9AboXxdqpy3mchWz4+qTBDCl9wg6/bRUKXL+U6v2JambBsFg8Z5+UCDo0QWIKhnMNS3WzGC6RPRwiCbNc0k8lYdhwKtSfdSFh6b3gJsrcCJ01zlgqDHFEgSZjEGBqT0KERPjQ3LZpHc5IFiN/RFY0tacQ7XZCI+3bU7kwtAFp1wETih6Q8btQrQJd7VN5Hie/9BrY6JhGWYro4kYoXsLlMGyxUW0p4Nn+QqlpLpD83B0hPThZ1RbKwR5RsZN1Ni1mghI3EjTXMnPhHUt3wBFqJd2z4YUvbDXA50+3y5ygor9yxTMcmd4aIwA3mQMlPUjWwhtzylTVKaEYQkdHIW4wVEko9hHC72sMZzG6ZKlOF+nUgQIsdXmxexdr66SmtXVAYP3I9xjgmPy3JoZp3ib6uKUsdpFBuNhNiuzuUBVYSfLjBtOyVo6vOf1xAXiDQsQAQEa2GCn7dEj5mnDZeYgNi+xE+SztXzmB6qrQw2OaQclRbF7o3lP8cs9MctavEvK0E5XD0uDN2m29Q7sJYTZsWiF5U7cvnQXKb1tjLY5i2H0/EsL0tcsd7feTR592/si/YhPIJwjL01EDG+ebhdXO9Fhi9umNo1RPZz2I2aDyMqFmq+FV+wrFxivAVWe6pdtBIWE/babBw/+knFgp0yEOSHVRZmLTmThiaVQPlK6n5C4tAtl+MO5DHQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(346002)(366004)(396003)(376002)(316002)(6666004)(41300700001)(26005)(6512007)(6486002)(6506007)(53546011)(478600001)(9686003)(2906002)(66476007)(66556008)(66946007)(4326008)(8676002)(8936002)(5660300002)(31686004)(31696002)(38100700002)(36756003)(2616005)(86362001)(186003)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVVKaytoVzV1K0IvUmxvVW5vN2xpL3BseGNZUEZtZk9sY0tIN3JRNkZpT3VI?=
 =?utf-8?B?VC9QU2FrUXBDSXRDRDNMR3BmeVB1aDN1Qm1iRllXUDRMdEtPM3Zxb1hYM2dx?=
 =?utf-8?B?aDlwb3RMN0dIRzIxR081bGY4Y3VLc1dWS3MrTkRvYW1LeVFzVENZQ0I0MXhB?=
 =?utf-8?B?YlZ4VWNYUFdiOXgxQWVzMjFqYjhjWEpsVFRsT1BaVWNVS1o3eUpEN2NKSEpV?=
 =?utf-8?B?b1BQUkJLZ2FESEFQbmxOVTdRa2dOcUE5YkdDUFNoc2JZaUJtSDcyYTM5ZmRx?=
 =?utf-8?B?YkxPOU0zMnlic2oxRi9mWTlFUGI1ak11Y2l3UEtEUWRYNWhXSjdSSFFoL3Jq?=
 =?utf-8?B?MTRrRkp4WllnNFVNcGZoRXI4Y0U5c1ZZY0tWeVFWN1FGNVpGRWRNZ1VVZXM1?=
 =?utf-8?B?c3FOM0o4V1p6RWF2aWRkZFBTeEl0UVJKcmM4bGNqMGRodW90QSswZy9MZTFN?=
 =?utf-8?B?U0ZCTFVCWS9UUjEyeVNKSmpzZ3F2ZW9IZVJYdDZXZDFJYTlqT1pyV1pJZEJL?=
 =?utf-8?B?Yi8rN0NuaUxtWS8ra3l1RWpqMjRWYmx4WlhJR2owSHRzNEhkVDdCZlVLKzh6?=
 =?utf-8?B?dlVlUitVWlBwdUE2Nm1aTWZvd1dBOWpJWm1WZXFnN3VpV0p6UnJGSWlaeWw2?=
 =?utf-8?B?bUJGMjJNSTNaY0NONFY5cHZUcjJxWVNqNjlsTkZKcFZQa0xlb3dmTzNDcnls?=
 =?utf-8?B?RUEzbkE0MXJBYm1qQlhxa2p3QXVmSGtGNlRWUzFkRkFxaUJqc0xXUiszOVhy?=
 =?utf-8?B?Zyt3bWcreUt6N1dRZEFZYkRDV003VWRRUHBEUTNHNEFxRGN2c1IrbHFFSlZH?=
 =?utf-8?B?NmF6aEk2bnB4cW52S2NBOGlCbFdwanl0cXJTbVpSWFdocERxMUJBa1lvQWUv?=
 =?utf-8?B?b2Ztd2Zla0tmcjNLMXFSOEY0OGpaMGkzQnJmTFgrcEtTVjJhMDY2RnE3VEF0?=
 =?utf-8?B?RDM2U3ZnenpyNzVsNVNBNUdXUjRCZ0xqRUNUdGFYcEFXRFdUbjRWZTczd2Zj?=
 =?utf-8?B?V0J1WWRUbzVtM3VsbHp5MTA2SnlPMVZBODlMeG1WY1l5NHpFTHp2Nm82clJa?=
 =?utf-8?B?V1pLejhac0loOUx6d2VkTGVYWUxVNDFjK3NPdHJkQ0hxSmNCRU1Ka1pmczdr?=
 =?utf-8?B?T3phUGsrbk9iVS84M2VqaFA5RklYYmY3M0ZzUnJJNVF6TEYyUTFSSzNnNHdH?=
 =?utf-8?B?K0M1WUh1c0wyaWM3dWIzNjlFUlZrTXozS21KR2tIU1FPUHhLK2Z1NzlZN0Nk?=
 =?utf-8?B?S050MlBqUUJ6cTQ1KzNucWs0dzBXeWdNN05QdUdieXkxQmpCMERGZVNmbDdm?=
 =?utf-8?B?bmMyZzl5ckcyZ20rYndLZHBEQU9iSHo5enFjNlRVekJQSjdiSFZHZXM5bENF?=
 =?utf-8?B?eFNqRWRCbGZjc0ZYTFJGNEhSYzQvUHRnM2RBeGM3SlVhRkgrVnN3dTJZMDU5?=
 =?utf-8?B?TGFlZGc4VUVJL3RNTUx2YUppeGRVTEs4c2tJZGdUVkdtNnNFclZtNWpZcEJG?=
 =?utf-8?B?UE1zL3hVRWxuT0c4WkRxY3drUzU5N2RJeGN4b0ZNUDdSUFZrVkhPMVMxcGFT?=
 =?utf-8?B?MnNwMVpjWnRIUDE5VUJRaHQzYTNEZStlNjhJNnNkalJYNWJQcmE0TDJVQ09t?=
 =?utf-8?B?YnVYbFZRTEljR1htUEV3WHJZMTFLemJYQ3B2azAyUU45M3RraDQ5QUNKY0Yw?=
 =?utf-8?B?bVdLMklJcjZBZkN3T2orMVhGQm5qcmpzd0g5UW1zY1F5S2toWUlSdmJKdWli?=
 =?utf-8?B?U2pRQktFT0NZZTlUZkwzZjIreFZaNnFwOHcxREFQZzQreGprQnk1TkdSN0t0?=
 =?utf-8?B?Ni93TStxNW42bmk3TlQzdjZKalhVT3o3djJoQmlNdWNLeEFjT3cvQS9NOHBL?=
 =?utf-8?B?VjRVZkRPamlWMVBmNXVuRlpTb2ZXeHprdzZ4NEIvNStZeTZaOG11UTFWQ3Ez?=
 =?utf-8?B?dXh2YTNzaFlUcTI0SHpubjVmcXVMQm9IVjVYMWNvM3NMYnZjOUF3U0tNUGF4?=
 =?utf-8?B?SFR3MnBXYVBCVVF0d09xb2laeS9yS3g3bXlNKzl4NHFtK1N0OHo0RHJ4cnY5?=
 =?utf-8?B?MTFpaDIrWERhTDg4QUoxSGp4QjAxN2lGaVFJUm84QUNTdndwSG1JYStPdDBB?=
 =?utf-8?Q?l6Tbb1vJwB5rHFSmuSBbCu1P2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 142e186b-d7a0-4827-e1e0-08da73eefffb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 18:52:36.5453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zkvUQvFQbPYW3L9yxOZSbWYxYfOyxCyrr0RFEy1yYN/J+OD/W+TtWhoXg0yRP5AGgKw2QrIX3i2QMT3Yy8Ynw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_08,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208010094
X-Proofpoint-GUID: nBEunUvbDqhV1vptliDENjwxDHPSTgt1
X-Proofpoint-ORIG-GUID: nBEunUvbDqhV1vptliDENjwxDHPSTgt1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/1/22 4:47 AM, Jeff Layton wrote:
> On Sun, 2022-07-31 at 13:19 -0700, Dai Ngo wrote:
>> Use-after-free occurred when the laundromat tried to free expired
>> cpntf_state entry on the s2s_cp_stateids list after inter-server
>> copy completed. The sc_cp_list that the expired copy state was
>> inserted on was already freed.
>>
>> When COPY completes, the Linux client normally sends LOCKU(lock_state x),
>> FREE_STATEID(lock_state x) and CLOSE(open_state y) to the source server.
>> The nfs4_put_stid call from nfsd4_free_stateid cleans up the copy state
>> from the s2s_cp_stateids list before freeing the lock state's stid.
>>
>> However, sometimes the CLOSE was sent before the FREE_STATEID request.
>> When this happens, the nfsd4_close_open_stateid call from nfsd4_close
>> frees all lock states on its st_locks list without cleaning up the copy
>> state on the sc_cp_list list. When the time the FREE_STATEID arrives the
>> server returns BAD_STATEID since the lock state was freed. This causes
>> the use-after-free error to occur when the laundromat tries to free
>> the expired cpntf_state.
>>
>> This patch adds a call to nfs4_free_cpntf_statelist in
>> nfsd4_close_open_stateid to clean up the copy state before calling
>> free_ol_stateid_reaplist to free the lock state's stid on the reaplist.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 9409a0dc1b76..749f51dff5c7 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -6608,6 +6608,7 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>>   	struct nfs4_client *clp = s->st_stid.sc_client;
>>   	bool unhashed;
>>   	LIST_HEAD(reaplist);
>> +	struct nfs4_ol_stateid *stp;
>>   
>>   	spin_lock(&clp->cl_lock);
>>   	unhashed = unhash_open_stateid(s, &reaplist);
>> @@ -6616,6 +6617,8 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>>   		if (unhashed)
>>   			put_ol_stateid_locked(s, &reaplist);
>>   		spin_unlock(&clp->cl_lock);
>> +		list_for_each_entry(stp, &reaplist, st_locks)
>> +			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
>>   		free_ol_stateid_reaplist(&reaplist);
>>   	} else {
>>   		spin_unlock(&clp->cl_lock);
> Nice catch.
>
> There are a number of places that call free_ol_stateid_reaplist. Is it
> really only in nfsd4_close_open_stateid that we need to do this? I
> wonder if it would be better to do this inside free_ol_stateid_reaplist
> instead so that all of those callers clean up the copy states as well?

Yes, we can do this in free_ol_stateid_reaplist too, I tested it.

The linux client uses either delegation state or lock state to send with
the COPY_NOTIFY to the source server. If the server grants the delegation
in the OPEN then the client uses the delegation state, otherwise it sends
the LOCK to the source and uses the lock state for the COPY_NOTIFY. This
problem happens only when the lock state is used *and* the client sends
the CLOSE and FREE_STATEID out of order.

free_ol_stateid_reaplist is called from release_open_stateid, release_openowner,
nfsd4_close_open_stateid and nfsd4_release_lockowner. Among these functions,
only nfsd4_close_open_stateid deals with lock state that may have cpntf_state
associated with it and only for the minorversion > 1 case.

nfsd4_release_lockowner will free the lock states but if the client has
not send LOCKU yet then put_ol_stateid_locked would fail to add the lock
state on the reaplist.

I'm ok to move it to free_ol_stateid_reaplist if you still think we should
and don't mind a little overhead on the unneeded cases.

-Dai

  

