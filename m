Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD9864A2AB
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 14:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbiLLN5P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 08:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiLLN5O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 08:57:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6232AB4F
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 05:57:13 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BC989QH014374;
        Mon, 12 Dec 2022 13:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=737sNII9RljyzjOhbIL8Q/GZkc/L4JmqWrAxLlf9QfE=;
 b=fcDv6TFpPdYBTIEpF7024R3Llh0Oog+YxGaBr+X9txDEE0nrQLY11kMa4UJynyxSJ1/6
 dc8i0XboxSGoXNj+7StPdZdBZ5/zb4pMUVchUOSNriBQXuLftfstsZuV0IfrmnPm6BBd
 79VnVCCNY8L5CLlQk41GlCBNFrhbNcz/stX0UF7zK2Ih0NR0zX2BTjCN2cbCzNQiXEaf
 iq62eNZ74DqT4v0WoU5H4s/+5t2llW0Rh4qlwt8V4BNNhAQ2XenYcTNjkc8MWkFdRP7z
 KJGmAiQMKiU9S3ZdVL4BhT6by+642KWgLlx7sPIaGbn+dE7rkwVSkA1EnJ8ylE8lisAR cw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mchqstr62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 13:57:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BCBwCp5009164;
        Mon, 12 Dec 2022 13:57:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgj41wfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 13:57:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+TpuVGTnibAhl3Ejdekk8iHKM6gCPVVIr8oyzM1yUT6xEKVNB+dK5ZIaBhE+ZJpqtSqnMheLaxRG1rE1T5ZFrwv9KS1BJIZKpqqnFTkYOS7T1meEacjAl93OVST3+EO/EnNc6pZmIKQH8Y7awUXgE8Lqf3mbdihYgx+25s1ot3mp1rydNCMCtCsLEgLJ4MuUboMSfwRNkv6rlzbWioes3O4oOkD9cVsRAtgUPQM58J3H4XGlOGAtxeNXtb2ZpvOGtPB6V45PTnpNVuTWQB1gx3dAKrjEHmghFBljdyw/z0W0Dh2KmLlaogTyMy1N6qeE62OdqSD6JTCvYsYwCyIng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=737sNII9RljyzjOhbIL8Q/GZkc/L4JmqWrAxLlf9QfE=;
 b=lIM5o0Xy9xvDOHF+IRINTBQZEHCpxw3xQlxT2J1OX0WyLZMzNYPUqd4uZWsGo+Y7yOm9wJWQDMSIuliAqsYRwPQ5LFS8l0v9vJgcmPezRpBN+Yj2v2wpK19h4b/b7EnFC6QCQpaRQGwAkYuT0Du9TJmgRZ7Au89rAFwYh7NAYVOyTemwuJGk9olVYbH7RybTeWKAgc7jPGOWjN/WkPFeFxsWdNeVWPqp+PSeT70TpbJDdWDPdcT6cmEDNN/+g7YYjGqK1Jl9M+N4KAbTufifkyA4v7ay4ixaitlC7QsaV29jcNE4iWk8RmBD6UVUisn2wQiqkJK8VHV58Sy1tPMyxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=737sNII9RljyzjOhbIL8Q/GZkc/L4JmqWrAxLlf9QfE=;
 b=ZLEdiq+4qI7GLyd4Y2cD9ixTOAsBRUBq0CVF/1wgenb8rOpQO6hdTvybkkC90sJoXbjuFNiZGyOmVXN2XXtV7SnEY3X4SHKbtM5oYOIJqbKZtyoLPxpaRlG3J1/7GwxiG+RqI2a1dv8P8DnsZWfiPsT2J6QoAw32O2LtlgiJBck=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH7PR10MB7054.namprd10.prod.outlook.com (2603:10b6:510:276::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 13:57:05 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::193d:c337:4b9:3c77]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::193d:c337:4b9:3c77%9]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 13:57:05 +0000
Message-ID: <bd43b7c9-a710-7251-46e0-b2c31b27d812@oracle.com>
Date:   Mon, 12 Dec 2022 05:57:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     kolga@netapp.com, hdthky0@gmail.com, linux-nfs@vger.kernel.org,
        security@kernel.org
References: <1670786549-27041-1-git-send-email-dai.ngo@oracle.com>
 <7f68cb23445820b4a1c12b74dce0954f537ae5e2.camel@kernel.org>
 <56b0cb4f-dfe9-6892-7fef-1a2965cf1d99@oracle.com>
 <0ab8efccae708faa092a56c6935c33564814bfed.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <0ab8efccae708faa092a56c6935c33564814bfed.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0123.namprd05.prod.outlook.com
 (2603:10b6:803:42::40) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH7PR10MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5c570d-8edc-4996-ea7c-08dadc48c09f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4uSxJIeeOnCGP7zfVnBXkBboZ/vpvfPwbmQJtatjpHkJAlRoXRNid4a7c7kJJ8igAdEYtf9p1Mk5TjFenjLXKpvPF+Jp+C6K9wFaBvzVng1UPJVf/DDdbrjIiamAdelAMCONYUszRHn2fXhYYQzTHb1vJtHIM+qEZ9As+Y4/0lvIu4b3KVvdq9LSPGfZ9Br8XkBNpnUfembAGkOGuXR31O/KcGk6yJH1wg+Sx3sakBcj+fTj/kl/OylMTkfpMXI8wltaEwtuyMzbhgOwLVYZ6SO29prDRVWuiKcExaGXRr6Cyrp5OYjWI89VAPq3ozQ3a7O2fhkxdz/owUS6QquHs0gfkKGWMO6E+xGhCAmAjUhVlMma3KZYrCgpXjbJv+Fdb6YkEZ9JENDUpuX+R3nR8UP/Y3Dm+a4w7h/xnzuU6ycNdZPrRc1EhvsQHkRs6x0CQzQs6Vo9t1rpqMmIDHdk/v8wgoM4W8ewqReWP6DfROXF53CVZTF+Q1MDFrsDFBjMgoiLx1+jsWtVK6vJAMx/FUYKTGz9cTi2KZj5Vse62hQSu8N0cL8FioSH+43bweAMjMVvTvsGXdYCIO9TINIKuYwBus7szBDc7peifYQO1+cj2UYmgyPZs1mOJbl2FUix85KMjQsO6lt4vtDQZu+tpBJpiIESo8+OuzSOIj069VitoQRQL8mfDX79Hn5WjKKM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199015)(38100700002)(66946007)(41300700001)(66556008)(66476007)(8936002)(5660300002)(8676002)(31686004)(4326008)(83380400001)(6506007)(6666004)(4001150100001)(2906002)(186003)(36756003)(316002)(478600001)(53546011)(6512007)(26005)(6486002)(9686003)(31696002)(86362001)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDRrbUlRaCtNR1M2NFFZWjVqaHZKSTBkWEd4K1ZxODBjU1JlWjhSeFZOQ2Fv?=
 =?utf-8?B?eEQxZ1NxYUtLSFNqTFdjNURIZ2szWGN5NHloUlp1eWl2azJEL2xnYnpNbDBE?=
 =?utf-8?B?UHA4RTFqc3B1b0hoeDN5Nmp0SlhYNjhuUWgrcDNGN0VUUENRWjBWL3JDV0xm?=
 =?utf-8?B?NlZCbEc3Nms4K29ORDA5WFB0ODI2eXNLK0hva0JSekQweUNYdmkrUWVlWjh5?=
 =?utf-8?B?b251VHdoV1k4ajZuR1RrSGFHcVhNb1UzajYzT2did3FqV0dJaWd6UnBVL3ZY?=
 =?utf-8?B?M2thMk9sSnBYMGUzZnQ3S1A1WFVoUzIvRjhGanhDVUtZSW1VWHlGTUloQUxY?=
 =?utf-8?B?K3Boa25XUkRJVmYyYWVUZFBEK0dhRXJMTDlnQW9NenFBT1JwcHdNaFZmWkhq?=
 =?utf-8?B?eEp4NjdQKzVBR2R0ZHdYaXpmZk9GWE5TQ1ZVb1BWTnpFTmdTeFQ4RFhvQkx2?=
 =?utf-8?B?cUM3RHYraElYdmJmRHNoblJ2UjZEUzRjQ1F5djFPUERTejkxUFlBRW1HQk5P?=
 =?utf-8?B?L3h6UXgrejFKZ3VQOE1iUnNWOXFJQ3JXUnNreTdtM3ZnODFoMkJGS3FOekgv?=
 =?utf-8?B?VVJxQTZmMXZvRWtYdWVhVVN0dTBwSnk1VkVWVnNxbEtmYjgvR2lSeS9vVk00?=
 =?utf-8?B?VmFGRm1nc2ovRXFDRC9iOE54SDlCVUJZbVdzWUlrSVZudHFlMXZGWGt3c204?=
 =?utf-8?B?SFJqRXk4QnF3eEV1Ymg4ZGlxWUtpZ21Tbzd5UTRoaXZmVGZKM3JOZXhnQktQ?=
 =?utf-8?B?WjNlR3VqZnBMYW5IaFdOdXVFL094SmUvMSswdm9wWnltZGIwK3lPV3A0SFF1?=
 =?utf-8?B?SmErTkxTaW02R3pGZUNIWEk4cjNTNFQ3aUs0dnJzb3BqNXdSM2dBWjVHRmln?=
 =?utf-8?B?WWRkWkpUdVNQZCs4Yk1XcmFhb3BRR2gyRHg4Z1pWT3FXc1FjODVpdmFmQ1B5?=
 =?utf-8?B?TVE3T0t4WE0rV0VnVTRtSWI1Q2VWRTJkMndmNWwyTlBGRVVEbnBsNlk5K1cy?=
 =?utf-8?B?TEx4UlNqN3hpRGlTNzNQMzRyNWY4UEhvQ1cxZlRXSGpvdWY2dFNGOUR1bnpG?=
 =?utf-8?B?b0JFMnM1VVF4V1gyUWkvaEd2Y0dXdXhpekNTVHFmNWxwSnV4WFV0QXk5VXRR?=
 =?utf-8?B?NzlwVjZnS0RJRmpoclVHWVRaNW1RT0twY3N6MWJQMFYxeWd1TXdGdWpPQ2lx?=
 =?utf-8?B?TzJnNGdhV3ZZbzBhSlkzdndLZG9KTmM1OEF3cUxKS29lVGhFQk1JQ29nRlBC?=
 =?utf-8?B?UHNzODJmRUViUElpVmhJSEdlajR1OUxDb1MyM3pjOEl1Q1BRNWZzam9zdnh4?=
 =?utf-8?B?N3VRa3dBNzFtTStkQlFacnpYZW16VjZVTHpFeU90RGd0bWJyNFZGLzhVR1Rz?=
 =?utf-8?B?S09QU0VIYjB5VEtMdDVyVmdReTMva0hHTlVpU1FQQlFXVVNucUNFL3dubGVh?=
 =?utf-8?B?NE1uL1lTc2lieFdkSHRTT3hFTXFCSGl1OVlJZUJQZ0U3eHFuVlhQTjg3WjZZ?=
 =?utf-8?B?TTNJaXgvSnpzSmhuWjhlajhtSFc4aDdkZVdQOXF2Ky83WWdNQnQ2bXdOTTJX?=
 =?utf-8?B?cUpaWWFYbDJScVpkdjRieGpuVk1qUlZOTjJ5SzV4Yk5PeFFSb1ZqaSthSklq?=
 =?utf-8?B?STRnMGNCSEt4ZXFab1VEY2xLNlozdmpGWmJtT2FjQS9iYzRQTngrV1YyQWdo?=
 =?utf-8?B?NmM1b0FyS1hnd3RWY3BpSkpTSkI3WkhIdHZyMWZTWjhNVEd5TEhhbjRNR3Rj?=
 =?utf-8?B?cFJCOEZtU0p5c0svTlhJUVdMOUhzZU9mRmdqV29EMmphVjNpcmpvd29FdGll?=
 =?utf-8?B?bkg1V0pCNVc0cXdxaVQ5RTRqV0JINWo3dFNtNERhT2p6YVRMcWpnNE5lNWMw?=
 =?utf-8?B?N0RnUENFQlAyY1U2VHlvdEw3K29JNDlOSE1OOVZOQzFMaUl2UDBPVGFPQ3pR?=
 =?utf-8?B?L1Q2elk4QXpGajhuZmtORzlxNmprVW5heTNjU3dGN0lLUEpsU1BiMmp2OHI2?=
 =?utf-8?B?RXRETGR5NkJDcGErUEo0SldTa2xYTWdhY2picXVuQndrNkxrTVY5N1hFRUZJ?=
 =?utf-8?B?N1plaDJTTjNCaDVIaXlSbmJ3RjJVZ1BxUDFPenRuWVhRNmtvTklEVndlS0ZP?=
 =?utf-8?Q?J9FgI3VVJv9UcF4q6Jfz13BF9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5c570d-8edc-4996-ea7c-08dadc48c09f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 13:57:05.5525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwRKGzUUI6QWe8MBQEl9nBAFFaErhKpNFkdzLygvFx55K2NKNGAVy48zqFDGGeueMP9AR5F1zjuTt5+a1VtflA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7054
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212120128
X-Proofpoint-ORIG-GUID: 57DlRLEgqjGjrYzo0JATbMgzdfoYwuwV
X-Proofpoint-GUID: 57DlRLEgqjGjrYzo0JATbMgzdfoYwuwV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 12/12/22 5:40 AM, Jeff Layton wrote:
> On Mon, 2022-12-12 at 05:34 -0800, dai.ngo@oracle.com wrote:
>> On 12/12/22 4:22 AM, Jeff Layton wrote:
>>> On Sun, 2022-12-11 at 11:22 -0800, Dai Ngo wrote:
>>>> Problem caused by source's vfsmount being unmounted but remains
>>>> on the delayed unmount list. This happens when nfs42_ssc_open()
>>>> return errors.
>>>> Fixed by removing nfsd4_interssc_connect(), leave the vfsmount
>>>> for the laundromat to unmount when idle time expires.
>>>>
>>>> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    fs/nfsd/nfs4proc.c | 23 +++++++----------------
>>>>    1 file changed, 7 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>> index 8beb2bc4c328..756e42cf0d01 100644
>>>> --- a/fs/nfsd/nfs4proc.c
>>>> +++ b/fs/nfsd/nfs4proc.c
>>>> @@ -1463,13 +1463,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>>    	return status;
>>>>    }
>>>>    
>>>> -static void
>>>> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>>>> -{
>>>> -	nfs_do_sb_deactive(ss_mnt->mnt_sb);
>>>> -	mntput(ss_mnt);
>>>> -}
>>>> -
>>>>    /*
>>>>     * Verify COPY destination stateid.
>>>>     *
>>>> @@ -1572,11 +1565,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
>>>>    {
>>>>    }
>>>>    
>>>> -static void
>>>> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>>>> -{
>>>> -}
>>>> -
>>>>    static struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>>>>    				   struct nfs_fh *src_fh,
>>>>    				   nfs4_stateid *stateid)
>>>> @@ -1762,7 +1750,8 @@ static int nfsd4_do_async_copy(void *data)
>>>>    		struct file *filp;
>>>>    
>>>>    		filp = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
>>>> -				      &copy->stateid);
>>>> +					&copy->stateid);
>>>> +
>>>>    		if (IS_ERR(filp)) {
>>>>    			switch (PTR_ERR(filp)) {
>>>>    			case -EBADF:
>>>> @@ -1771,7 +1760,7 @@ static int nfsd4_do_async_copy(void *data)
>>>>    			default:
>>>>    				nfserr = nfserr_offload_denied;
>>>>    			}
>>>> -			nfsd4_interssc_disconnect(copy->ss_mnt);
>>>> +			/* ss_mnt will be unmounted by the laundromat */
>>>>    			goto do_callback;
>>>>    		}
>>>>    		nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
>>>> @@ -1852,8 +1841,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>    	if (async_copy)
>>>>    		cleanup_async_copy(async_copy);
>>>>    	status = nfserrno(-ENOMEM);
>>>> -	if (nfsd4_ssc_is_inter(copy))
>>>> -		nfsd4_interssc_disconnect(copy->ss_mnt);
>>>> +	/*
>>>> +	 * source's vfsmount of inter-copy will be unmounted
>>>> +	 * by the laundromat
>>>> +	 */
>>>>    	goto out;
>>>>    }
>>>>    
>>> This looks reasonable at first glance, but I have some concerns with the
>>> refcounting around ss_mnt elsewhere in this code. nfsd4_ssc_setup_dul
>>> looks for an existing connection and bumps the ni->nsui_refcnt if it
>>> finds one.
>>>
>>> But then later, nfsd4_cleanup_inter_ssc has a couple of cases where it
>>> just does a bare mntput:
>>>
>>>           if (!nn) {
>>>                   mntput(ss_mnt);
>>>                   return;
>>>           }
>>> ...
>>>           if (!found) {
>>>                   mntput(ss_mnt);
>>>                   return;
>>>           }
>>>
>>> The first one looks bogus. Can net_generic return NULL? If so how, and
>>> why is it not a problem elsewhere in the kernel?
>> it looks like net_generic can not fail, no where else check for NULL
>> so I will remove this check.
>>
>>> For the second case, if the ni is no longer on the list, where did the
>>> extra ss_mnt reference come from? Maybe that should be a WARN_ON or
>>> BUG_ON?
>> if ni is not found on the list then it's a bug somewhere so I will add
>> a BUG_ON on this.
>>
> Probably better to just WARN_ON and let any references leak in that
> case. A BUG_ON implies a panic in some environments, and it's best to
> avoid that unless there really is no choice.

ok, thanks Jeff!

-Dai

