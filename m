Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F64460C14F
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 03:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiJYBp0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 21:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiJYBpI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 21:45:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDCFB5151
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 18:31:09 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OL6SUA013584;
        Tue, 25 Oct 2022 01:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=w7ZWbUxSiNo22nfBnQBWw7zS1eetDrguPI0QsjPtE+c=;
 b=q3UzTeCjqM4CKENv535i2X71ggMVXdg+bI9VvQdjbHtn0xEDH5tJk4Uz7Qs2AUdNOpFK
 Q8HTJjrsdajv4o1mWIDi+12bTJB/llBPvvUe6WrU80Af/wykE3saBtdQuN3QvY8Wwumn
 8EGXI4KSgIWMZuFaH3Q38oTRMmbJT/sK5klUgDZoUqvsqZYogLkXeiqc9kZaSfIe58Dt
 2ThMVBqd76JVjkQMY4vyuiG44C5vblu/fmMpW33/hLAwIbap07WvCLep81jESkYoUYz4
 N8kk8q+mKga2QGSIRbGIuQ/3Smks66VOG9+biALbieq13uIjzPCMZ5tQM3NcyKATKspQ cw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc6xdxw0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 01:31:03 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29P1D0b0017232;
        Tue, 25 Oct 2022 01:31:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y4dcbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 01:31:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUzAYw3+FqlfU5P9I3o4qhPgktcvArWfxGDo7NUHJ0U5/HFX/xQaSpofH2IiWraz/g9shR8GMs5PLUf9r/2PNO3UVnQ1H79NN9J/RsM5rXzz2H3F+YPP1fW7mb+SeNfKOaswseu1sIX5XIaix/VPhRy6zw0UqwNDGZ01Y6u+Ip+GERcw5ld+yJqqGdTQuKhZyPbYUEwqZNGMSlIZpahrX91Clksmz6Pc45vYg5tAY/Ia6TS/MXDtEE3ZNqO4NQHX5+3ey/V/JLiUnyN91dGW7huDRso3CY6KtEwWTq6irwLgm7xu9RDhk03v7gzJJICb5lPdm3xeoVoMCUWkzCjoow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7ZWbUxSiNo22nfBnQBWw7zS1eetDrguPI0QsjPtE+c=;
 b=l814DAXZbyiNVbSJuXTH18ZXM6iI+MypO+9q+AqSj17syHCcWsiooT9TTuyTdGg1LQ8P/I3vdQY3+eCqv/Lu+aU3uLi3V0GZLHasCqjNTm6bU7yonxoroQDwpelugCQ7RXSWE2hW743wMT2AWOGB1t2L4BkWFU/pivo7iQX5cbEIGX/wg9nRDuxZi+ZSypI6siSr85hEVJ5OGqdgZmrI1F5xEqIGaO1uHfJ00yhmVTHMidmCDX/ueaKb0oDTiw9r90xsL3cyZp48N/V317lv1n+mZCchXTHj0x2Hjueu355fAsgtQfUmJ83KG1vdGsl41cAYbRHqeonJs1LBkoRm2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7ZWbUxSiNo22nfBnQBWw7zS1eetDrguPI0QsjPtE+c=;
 b=ipdKsTs1YJTEiLBERd0b1DcUxY7suMu2cPfUCInukHUcyia3tBZL/FHDKhx0R87jLlCAaSOKbSLQ3xIPQMFJcL7aG/ch2ye3smxrioVuUFN/RvSklguOYDm5kEUkoLg9N8l4NIW4Gs2/kbnM4ar9LJOImgk1AtdUZbqimI2bPXc=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN0PR10MB5335.namprd10.prod.outlook.com (2603:10b6:408:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Tue, 25 Oct
 2022 01:31:00 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::21ec:d1ee:2a59:a1d0]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::21ec:d1ee:2a59:a1d0%6]) with mapi id 15.20.5746.023; Tue, 25 Oct 2022
 01:31:00 +0000
Message-ID: <ffcf7b71-8afd-bea1-9757-e7e0dc36f187@oracle.com>
Date:   Mon, 24 Oct 2022 18:30:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v2 1/2] NFSD: add support for sending CB_RECALL_ANY
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
References: <1666462150-11736-1-git-send-email-dai.ngo@oracle.com>
 <1666462150-11736-2-git-send-email-dai.ngo@oracle.com>
 <d43a3dac01f8c4211ec7634a0d78dae70468f39b.camel@kernel.org>
 <efbea8dd-1998-fe2a-1a94-6becc5ea691f@oracle.com>
 <342dd03eea9a1eccf1848c1e2f5f92791c4c42f2.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <342dd03eea9a1eccf1848c1e2f5f92791c4c42f2.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:a03:114::29) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|BN0PR10MB5335:EE_
X-MS-Office365-Filtering-Correlation-Id: 50866b6e-ae40-4d51-3054-08dab6289277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FUvuqP+KEgLhhFPsfT/JrKKKMfijZPYnjNwHThCivhJbbVTB9njMAZZk4lOe2IXTVd8N22ndh9hZrYFsYaqjZ6YjXXKjiH4DkUcvzZj4sDhdlNc4QK3SA2fr+2pOMXlr3bOjlniGf13ZW56H+3FbrY6AGfg/fCW7qMoTou1z2ncIf0YSQctYDIYvK8RQ+wgGWZsii3TSjXoRZ80kbchUu+JUHq1WoLGpCvOkAm2v+Nmnxv0bmpVXxzL8I78rhe+omQ1eAZs95Uky799Ki6I12HuBljaXVbKlzvFz1o4xMNYMg2JSigOpsa+WUsoU21dKyiOq696qsz+Ozk3stBvd9VgpW/HQWMSjFkpCdkWG9Vn87YDlcs0IU7TShXrFAoBqb/c3uCyNOAR1Dyp9lJx0P9mKI2Ed2gYR1f3OK7RZlS+ZPwLKxYtRPIs5/0HDeWmFyDg8uQl/Og2YdgyKa0rv4fJuYa1og47EsZkhXYB4SLg/Z56RJnk5dTmRNwn/JUya3NFsvnd54XhAEHndShNS+p1nW84uKpEG+CaAy+cKWnN5xpVIu6JCFaJj05nyHd8sJmRYZFtV+PjKI/G94oa8sFI+BYrQHMdoyVUCP4aJV09pkFDicFMUf0SQkjBcijkkfO0ImgZTSvDJFVmgJA4SLeIObdvOYje1BGDgTzwd4k8E/KqEqKKdTDuPujXaDKwTbFS/x8meI5eqN7SGpDMe+aN7bumcE8OF7zWK0pFy1Ey3RWooUUICPz/ouw8MAgHD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199015)(38100700002)(186003)(4001150100001)(2616005)(2906002)(6486002)(478600001)(36756003)(66476007)(8676002)(66556008)(41300700001)(6512007)(66946007)(4326008)(83380400001)(86362001)(31696002)(9686003)(26005)(30864003)(6506007)(53546011)(8936002)(316002)(5660300002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um4vVFpTTHl4T0hQQ3Q4ZEw5Um1melRyY1NLWTJtYnFyRjJKUkxyamd4NjJP?=
 =?utf-8?B?amg2VVJtcEpwa2h5ekVFVlJjem1tK3RzbWpCNCtJYWZtbG5xRTNadUNtck9s?=
 =?utf-8?B?ZTRWYjlLbTU5T2RvQ25wdGkxU2FKdmFGSWxwbjJwcVFGT3pJejZ6dHhIc21C?=
 =?utf-8?B?d0llUUpIYTczWjlRbXJPOERyYjN6ZXR6Y29raTVKVFFTSzR5K1ZtaTk5OXl1?=
 =?utf-8?B?UnZhUVdaLzdyQ3QyRkpoTjI4N1JOWGtnaTMyUnVEQXlTRCt5dVNMUmJYZThj?=
 =?utf-8?B?VWdCWTd6bnNwQTJkWlhRNGhkc1E4V0UvTlk5ZWtGQWtyOXJneklMY0tJU1BF?=
 =?utf-8?B?b2lJUk5lSUd4eGNNSXpsUWZxeVNNQ2NJYmMzeGJLK2tDcnZFMTg1QlFyamMz?=
 =?utf-8?B?MlY1SlJ1Z01TUEhDTkhOK3pNQ3M5blFZR29rV29QQjdXZjl5T1pFSU9Pb3Y1?=
 =?utf-8?B?NGNwK2w0MEs2SWxpUElsUTNjTlB4RmlWVVdqMmlJN1hyQU81UllweDBEVGtU?=
 =?utf-8?B?YnR1VlM0WFY0WEs2ZTdYclg0NkVnZUx2TlMvaUxRdlBsdGR0VktCM3A2Y2Nq?=
 =?utf-8?B?WURoeVB5Nk1GQVdHOEpvREMySHR6OGZNaDRNMmRkajI3YmZSWlZ5Y1JQbGZO?=
 =?utf-8?B?b1BYT2d5Y1RQWGt1eCtrSW9FNHQvY0Z0SURRUnArSkUrTUdubXU1Y2lTaTJt?=
 =?utf-8?B?dG9rUXhpSXoyOHIwZ2c3WmZwRm5RSU1VUmlIZlQwOEVuVGlTenVNTGwyeFI4?=
 =?utf-8?B?SHY2NFZscjhTOVZoMUNkSmY1WTdZUEFrUkFvK2dSTE1KKy9YUkdyb01qSXlv?=
 =?utf-8?B?RlRFZEI2bTBNc2dXZzJzZnBhM0YreVhGZWo5OC82S3YyeDFiYTUvMDlyYS9L?=
 =?utf-8?B?eHRMZkgwOGhXMEgyaWZlb29VQkU4K1l4ZEdKTjlrdUd0YVUyTTVYL0dVRFgy?=
 =?utf-8?B?dXV4YzRndTFBbDlmSXBKc2xxT3h1ZWtHa2dnU2xJUThVTXg2U0lhM1dqT3Fq?=
 =?utf-8?B?Y2pxbnFaWFlJWi9CMnRQVTd3VU1KMXNETDRuR3hUTGwwLzY4T1cyb3lyRkZN?=
 =?utf-8?B?VUpUZmYzV0JCRWdTRCtVYWNkRlJvVDYzNDJPSWVxcWxic3RlK1ZyRkhMaDVL?=
 =?utf-8?B?YStMVWRFTnJJUEE3SzdDbW1sWnNITk5tamV5QS90L0t3NnNCWFBhVkN2d1lz?=
 =?utf-8?B?bnUzVnhGU2JuUXZFakQvMzV3NCsyV1Mvei9DTWM2RThXUDQzUXliRm5UcUtr?=
 =?utf-8?B?UkhUb1JFVVBXcituYzRzbFBjbkhKTSt4NXdGSHozN1FKVWovT0MyY1pFVUxE?=
 =?utf-8?B?cEFzUktqanpsSnd5djFYeXFTTExNWlJFZ3c5VnlBUVJiNlFBeVprQ0FpbHVn?=
 =?utf-8?B?NUdiaTVoYndOaUhpNHk4eTdRYTB3MitjbDJ6MTBQa3ZlTGJIemhsaGxQVHRL?=
 =?utf-8?B?eHgwMmIvTGY3dEtPOHlaanUyOFo2QldvTmdUOFdva1ZRYkMvd21MQUJONzZJ?=
 =?utf-8?B?VVg5eDFlMjlTYjJjUm0yaG14VFlKTFlWUE5kMHl0Yy9NSlNYdGliV2YySU1K?=
 =?utf-8?B?TzdIV1NaOEhBTjI3MGZPL1ZWQkV6dlY2V0o4OEdzRThmUlVtcjhIdml6b3hJ?=
 =?utf-8?B?UzhKNDFZTUxQMmFaK1Uxb29lOStCUUpMT1hPb3ZHR2t2U3hJcUF6VzNtQytE?=
 =?utf-8?B?U01tWmplaUQ3VVdENHd2MUxSR0hld0dJclIwS3h4aEpma0JwenlpV25OVUIw?=
 =?utf-8?B?WXlQUnlFRUkzdDREU0J4alRUbkdMM2ZwK0xDTE4veVY3R0FuTVIzamNMcE1w?=
 =?utf-8?B?Z0FjclhvN1NYd21PMFVvc0gyMjBGcElmTmRidUlEbXRabU1xQkswVUtENTBB?=
 =?utf-8?B?dklzZGYwU0RvbDNJL0dBRTIzRVJkQmcrSmdJOENlU0MxaHR5NHQxeGtvNmxv?=
 =?utf-8?B?ZFVCUms5ZnJWS3hMT0cvNnFPb3A5S0dhelV4N2VpUVR0V2V4bW9VZDdPWGxV?=
 =?utf-8?B?aVI2c2RZQ3NCUEpMc2p4Rmx4cEJEVHFqOFlHUDJ4Z3JCV0JJQzAvTm92L05O?=
 =?utf-8?B?a2F5MWRZNHNpcnpwSnB1SnZXdWhsdVE2L2swYXZCNnliTmRCTzBUem1IeWRL?=
 =?utf-8?Q?HS3jiGVSmNZvwxJeVBSUk57OM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50866b6e-ae40-4d51-3054-08dab6289277
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 01:31:00.0938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rLlFUn+Ke7a3EIubPp7fcXpDk1emHp+S+PWYz/aiC7eA9CsORXA26kBA/+YMQR4BsjfWzFFq3oT3k7uB4LyQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5335
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_09,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210250007
X-Proofpoint-GUID: LnzQdDxHFyO4YIVHGAMkAj60DlSg2iq1
X-Proofpoint-ORIG-GUID: LnzQdDxHFyO4YIVHGAMkAj60DlSg2iq1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 10/24/22 2:09 PM, Jeff Layton wrote:
> On Mon, 2022-10-24 at 12:44 -0700, dai.ngo@oracle.com wrote:
>> On 10/24/22 5:16 AM, Jeff Layton wrote:
>>> On Sat, 2022-10-22 at 11:09 -0700, Dai Ngo wrote:
>>>> There is only one nfsd4_callback, cl_recall_any, added for each
>>>> nfs4_client. Access to it must be serialized. For now it's done
>>>> by the cl_recall_any_busy flag since it's used only by the
>>>> delegation shrinker. If there is another consumer of CB_RECALL_ANY
>>>> then a spinlock must be used.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    fs/nfsd/nfs4callback.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    fs/nfsd/nfs4state.c    | 27 +++++++++++++++++++++
>>>>    fs/nfsd/state.h        |  8 +++++++
>>>>    fs/nfsd/xdr4cb.h       |  6 +++++
>>>>    4 files changed, 105 insertions(+)
>>>>
>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>>> index f0e69edf5f0f..03587e1397f4 100644
>>>> --- a/fs/nfsd/nfs4callback.c
>>>> +++ b/fs/nfsd/nfs4callback.c
>>>> @@ -329,6 +329,29 @@ static void encode_cb_recall4args(struct xdr_stream *xdr,
>>>>    }
>>>>    
>>>>    /*
>>>> + * CB_RECALLANY4args
>>>> + *
>>>> + *	struct CB_RECALLANY4args {
>>>> + *		uint32_t	craa_objects_to_keep;
>>>> + *		bitmap4		craa_type_mask;
>>>> + *	};
>>>> + */
>>>> +static void
>>>> +encode_cb_recallany4args(struct xdr_stream *xdr,
>>>> +			struct nfs4_cb_compound_hdr *hdr, uint32_t bmval)
>>>> +{
>>>> +	__be32 *p;
>>>> +
>>>> +	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
>>>> +	p = xdr_reserve_space(xdr, 4);
>>>> +	*p++ = xdr_zero;	/* craa_objects_to_keep */
>>>> +	p = xdr_reserve_space(xdr, 8);
>>>> +	*p++ = cpu_to_be32(1);
>>>> +	*p++ = cpu_to_be32(bmval);
>>>> +	hdr->nops++;
>>>> +}
>>>> +
>>>> +/*
>>>>     * CB_SEQUENCE4args
>>>>     *
>>>>     *	struct CB_SEQUENCE4args {
>>>> @@ -482,6 +505,24 @@ static void nfs4_xdr_enc_cb_recall(struct rpc_rqst *req, struct xdr_stream *xdr,
>>>>    	encode_cb_nops(&hdr);
>>>>    }
>>>>    
>>>> +/*
>>>> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
>>>> + */
>>>> +static void
>>>> +nfs4_xdr_enc_cb_recall_any(struct rpc_rqst *req,
>>>> +		struct xdr_stream *xdr, const void *data)
>>>> +{
>>>> +	const struct nfsd4_callback *cb = data;
>>>> +	struct nfs4_cb_compound_hdr hdr = {
>>>> +		.ident = cb->cb_clp->cl_cb_ident,
>>>> +		.minorversion = cb->cb_clp->cl_minorversion,
>>>> +	};
>>>> +
>>>> +	encode_cb_compound4args(xdr, &hdr);
>>>> +	encode_cb_sequence4args(xdr, cb, &hdr);
>>>> +	encode_cb_recallany4args(xdr, &hdr, cb->cb_clp->cl_recall_any_bm);
>>>> +	encode_cb_nops(&hdr);
>>>> +}
>>>>    
>>>>    /*
>>>>     * NFSv4.0 and NFSv4.1 XDR decode functions
>>>> @@ -520,6 +561,28 @@ static int nfs4_xdr_dec_cb_recall(struct rpc_rqst *rqstp,
>>>>    	return decode_cb_op_status(xdr, OP_CB_RECALL, &cb->cb_status);
>>>>    }
>>>>    
>>>> +/*
>>>> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
>>>> + */
>>>> +static int
>>>> +nfs4_xdr_dec_cb_recall_any(struct rpc_rqst *rqstp,
>>>> +				  struct xdr_stream *xdr,
>>>> +				  void *data)
>>>> +{
>>>> +	struct nfsd4_callback *cb = data;
>>>> +	struct nfs4_cb_compound_hdr hdr;
>>>> +	int status;
>>>> +
>>>> +	status = decode_cb_compound4res(xdr, &hdr);
>>>> +	if (unlikely(status))
>>>> +		return status;
>>>> +	status = decode_cb_sequence4res(xdr, cb);
>>>> +	if (unlikely(status || cb->cb_seq_status))
>>>> +		return status;
>>>> +	status =  decode_cb_op_status(xdr, OP_CB_RECALL_ANY, &cb->cb_status);
>>>> +	return status;
>>>> +}
>>>> +
>>>>    #ifdef CONFIG_NFSD_PNFS
>>>>    /*
>>>>     * CB_LAYOUTRECALL4args
>>>> @@ -783,6 +846,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[] = {
>>>>    #endif
>>>>    	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
>>>>    	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
>>>> +	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
>>>>    };
>>>>    
>>>>    static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 4e718500a00c..c60c937dece6 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -2854,6 +2854,31 @@ static const struct tree_descr client_files[] = {
>>>>    	[3] = {""},
>>>>    };
>>>>    
>>>> +static int
>>>> +nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
>>>> +			struct rpc_task *task)
>>>> +{
>>>> +	switch (task->tk_status) {
>>>> +	case -NFS4ERR_DELAY:
>>>> +		rpc_delay(task, 2 * HZ);
>>>> +		return 0;
>>>> +	default:
>>>> +		return 1;
>>>> +	}
>>>> +}
>>>> +
>>>> +static void
>>>> +nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
>>>> +{
>>>> +	cb->cb_clp->cl_recall_any_busy = false;
>>>> +	atomic_dec(&cb->cb_clp->cl_rpc_users);
>>>> +}
>>> This series probably ought to be one big patch. The problem is that
>>> you're adding a bunch of code to do CB_RECALL_ANY, but there is no way
>>> to call it without patch #2.
>> The reason I separated these patches is that the 1st patch, adding support
>> CB_RECALL_ANY can be called for other purposes than just for delegation such
>> as to recall pnfs layouts, or when the max number of delegation is reached.
>> So that was why I did not combined this patches. However, I understand your
>> concern about not being able to test individual patch. So as Chuck suggested,
>> perhaps we can leave these as separate patches for easier review and when it's
>> finalized we can decide to combine them in to one big patch.  BTW, I plan to
>> add a third patch to this series to send CB_RECALL_ANY to clients when the
>> max number of delegations is reached.
>>
> I think we should get this bit sorted out first,

ok

>   but that sounds
> reasonable eventually.
>
>>> That makes it hard to judge whether there could be races and locking
>>> issues around the handling of cb_recall_any_busy, in particular. From
>>> patch #2, it looks like cb_recall_any_busy is protected by the
>>> nn->client_lock, but I don't think ->release is called with that held.
>> I don't intended to use the nn->client_lock, I think the scope of this
>> lock is too big for what's needed to serialize access to struct nfsd4_callback.
>> As I mentioned in the cover email, since the cb_recall_any_busy is only
>> used by the deleg_reaper we do not need a lock to protect this flag.
>> But if there is another of consumer, other than deleg_reaper, of this
>> nfsd4_callback then we can add a simple spinlock for it.
>>
>> My question is do you think we need to add the spinlock now instead of
>> delaying it until there is real need?
>>
> I don't see the need for a dedicated spinlock here. You said above that
> there is only one of these per client, so you could use the
> client->cl_lock.
>
> But...I don't see the problem with doing just using the nn->client_lock
> here. It's not like we're likely to be calling this that often, and if
> we do then the contention for the nn->client_lock is probably the least
> of our worries.

If the contention on nn->client_lock is not a concern then I just
leave the patch to use the nn->client_lock as it current does.

>
> Honestly, do we need this boolean at all? The only place it's checked is
> in deleg_reaper. Why not just try to submit the work and if it's already
> queued, let it fail?

There is nothing in the existing code to prevent the nfs4_callback from
being used again before the current CB_RECALL_ANY request completes. This
resulted in se_cb_seq_nr becomes out of sync with the client and server
starts getting NFS4ERR_SEQ_MISORDERED then eventually NFS4ERR_BADSESSION
from the client.

nfsd4_recall_file_layout has similar usage of nfs4_callback and it uses
the ls_lock to make sure the current request is done before allowing new
one to proceed.

>
>>> Also, cl_rpc_users is a refcount (though we don't necessarily free the
>>> object when it goes to zero). I think you need to call
>>> put_client_renew_locked here instead of just decrementing the counter.
>> Since put_client_renew_locked() also renews the client lease, I don't
>> think it's right nfsd4_cb_recall_any_release to renew the lease because
>> because this is a callback so the client is not actually sending any
>> request that causes the lease to renewed, and nfsd4_cb_recall_any_release
>> is also alled even if the client is completely dead and did not reply, or
>> reply with some errors.
>>
> What happens when this atomic_inc makes the cl_rpc_count go to zero?

Do you mean atomic_dec of cl_rpc_users?

> What actually triggers the cleanup activities in put_client_renew /
> put_client_renew_locked in that situation?

maybe I'm missing something, but I don't see any client cleanup
in put_client_renew/put_client_renew_locked other than renewing
the lease?

-Dai

>
>>>> +
>>>> +static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
>>>> +	.done		= nfsd4_cb_recall_any_done,
>>>> +	.release	= nfsd4_cb_recall_any_release,
>>>> +};
>>>> +
>>>>    static struct nfs4_client *create_client(struct xdr_netobj name,
>>>>    		struct svc_rqst *rqstp, nfs4_verifier *verf)
>>>>    {
>>>> @@ -2891,6 +2916,8 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
>>>>    		free_client(clp);
>>>>    		return NULL;
>>>>    	}
>>>> +	nfsd4_init_cb(&clp->cl_recall_any, clp, &nfsd4_cb_recall_any_ops,
>>>> +			NFSPROC4_CLNT_CB_RECALL_ANY);
>>>>    	return clp;
>>>>    }
>>>>    
>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>> index e2daef3cc003..49ca06169642 100644
>>>> --- a/fs/nfsd/state.h
>>>> +++ b/fs/nfsd/state.h
>>>> @@ -411,6 +411,10 @@ struct nfs4_client {
>>>>    
>>>>    	unsigned int		cl_state;
>>>>    	atomic_t		cl_delegs_in_recall;
>>>> +
>>>> +	bool			cl_recall_any_busy;
>>>> +	uint32_t		cl_recall_any_bm;
>>>> +	struct nfsd4_callback	cl_recall_any;
>>>>    };
>>>>    
>>>>    /* struct nfs4_client_reset
>>>> @@ -639,8 +643,12 @@ enum nfsd4_cb_op {
>>>>    	NFSPROC4_CLNT_CB_OFFLOAD,
>>>>    	NFSPROC4_CLNT_CB_SEQUENCE,
>>>>    	NFSPROC4_CLNT_CB_NOTIFY_LOCK,
>>>> +	NFSPROC4_CLNT_CB_RECALL_ANY,
>>>>    };
>>>>    
>>>> +#define RCA4_TYPE_MASK_RDATA_DLG	0
>>>> +#define RCA4_TYPE_MASK_WDATA_DLG	1
>>>> +
>>>>    /* Returns true iff a is later than b: */
>>>>    static inline bool nfsd4_stateid_generation_after(stateid_t *a, stateid_t *b)
>>>>    {
>>>> diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
>>>> index 547cf07cf4e0..0d39af1b00a0 100644
>>>> --- a/fs/nfsd/xdr4cb.h
>>>> +++ b/fs/nfsd/xdr4cb.h
>>>> @@ -48,3 +48,9 @@
>>>>    #define NFS4_dec_cb_offload_sz		(cb_compound_dec_hdr_sz  +      \
>>>>    					cb_sequence_dec_sz +            \
>>>>    					op_dec_sz)
>>>> +#define NFS4_enc_cb_recall_any_sz	(cb_compound_enc_hdr_sz +       \
>>>> +					cb_sequence_enc_sz +            \
>>>> +					1 + 1 + 1)
>>>> +#define NFS4_dec_cb_recall_any_sz	(cb_compound_dec_hdr_sz  +      \
>>>> +					cb_sequence_dec_sz +            \
>>>> +					op_dec_sz)
