Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFD564A111
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 14:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbiLLNeu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 08:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbiLLNeg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 08:34:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E051413EB9
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 05:34:34 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BC98JpS010623;
        Mon, 12 Dec 2022 13:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=JQXHl6rAiMq0XKyOXMebUHADwnFZE/1gCt/b6AfNb48=;
 b=vg3D/kTw2/f3Vph0+2CKYlXvGDQAr2jtZz3bVlkmIWZSMcs+q9+MtC6+QFWeRDCOlm8h
 iCYSAEwTOJeoEjduriAL9pJ55rCOJDNaQ/9pd+5738XfxdEFo0R461AwxbUzybsjRMHC
 h98dhWdojPT4XYaQ4aYh3BpyuI6bOZwXzb3Y9VZHpbyL5zap+NVMI04J6UaozzVc6dLl
 dpy8eYQ5p8xibOM8ybme03UPKpY2i/CPZdrZ+GkwscCbtAZdKIHlaaUD5KGIB6X/J7af
 JltCpAUymQC8z8FqIP3fzbuLRdFSO7APyutZKLWP+qap83bHR2s2zvIsWG+s8BFtNVkW sg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcgq0ars1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 13:34:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BCBvlZk018690;
        Mon, 12 Dec 2022 13:34:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgjag388-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 13:34:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkP+HDEiwvFFF0bsZu0oG1UmS2xI5u7BYmBRkkb2jGp+Hwu0vry7CkTv7Ng1JMO+PA5qX/0rd2zA6sYV0D1Q1joyy9yTR5zcYSPAg15F8bjTE8nHPAzeTytT0cxB0qfFgIEu5fLX74iYlfCBjtRujUWv4PQpZGYyEEVrotZ0pZ1uOB7kye+zs7shWpjcjung/UUsY/F7Zob65EloiHCYcmGmJq2fr7kbiNJi31fehaXK9NFoivsmKMiRY/uNJShmavEDx9qwAicqVaaAs51BkI8UPCJk1iwxvqGKQdxIRAUKS7O3e3+fzXoAbupY4EmGb1HxseeYHZJOuVLshfIMqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQXHl6rAiMq0XKyOXMebUHADwnFZE/1gCt/b6AfNb48=;
 b=C6JKhnWAJAyrO3QTljRZLCIwvj2b3+V5nllGTeU+ljLqMMZl8OK3Jf20SKi62rA+v0/ZeOEejGRHLsuvErMo63Ppz+U8EpIOuQGkXyq19baqSVKoRN0LuL2MocvKRYnMTDAeLqug6HxhiHpFJL0+lDr6bHe6AjaUENbGfHVryAOqdy+zG5DYc4S6/3L62d7IhJlKaXFFZKc/jaJllVBLs57LQ9JAr8aoUVtOPxW1O7S2HMGdxYO44PaKXiIYjROk+Yk7u+mS2mdiUP+BJRnorpKMgzVwfPsae8yZVeIlfAeNYfaHP/uA2Y8p5cxpVwgYur5QAx0wrHzLA4m1G8CWZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQXHl6rAiMq0XKyOXMebUHADwnFZE/1gCt/b6AfNb48=;
 b=qU8BljmW+SsiY4G3xbY1tZkWEOmmwl5zE1EXzBDJ44XCpntIRmkC/SZxNuHEg9cuXRZCXG/qp7ZR1iqfi10K1aBpqyFZ4AQO9HzjlZ1eP6nyyBIHCnqvRU3ZU4SHgweONC+kltebbry9GTQKLkbKGSB9e7RMeOP6bIHz5P/9g7c=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB5648.namprd10.prod.outlook.com (2603:10b6:a03:3e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 13:34:27 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::193d:c337:4b9:3c77]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::193d:c337:4b9:3c77%9]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 13:34:27 +0000
Message-ID: <56b0cb4f-dfe9-6892-7fef-1a2965cf1d99@oracle.com>
Date:   Mon, 12 Dec 2022 05:34:25 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     kolga@netapp.com, hdthky0@gmail.com, linux-nfs@vger.kernel.org,
        security@kernel.org
References: <1670786549-27041-1-git-send-email-dai.ngo@oracle.com>
 <7f68cb23445820b4a1c12b74dce0954f537ae5e2.camel@kernel.org>
Content-Language: en-US
From:   dai.ngo@oracle.com
In-Reply-To: <7f68cb23445820b4a1c12b74dce0954f537ae5e2.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:a03:331::34) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SJ0PR10MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2e699f-6a3b-4534-8dc7-08dadc459751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SagnOEGRVWMTADgAr/sLTMGdyD7M7Mh9Wy+OV21E3JfNpo+LoKY5hnw7Mnv7UVgyFxX4p7+2ZTM8MxpEU5YWYlX8x9akljl5DqYg7cjq3+qou+yohnFPXTjC1TspZmTrwr8iMpXJ/cKx+rKR2/snAdF21H9U8hAvZOOM6nOYviMp+tS1hmAqgtP3ttD2ED9kf3dbO8CZ8uneyubGjMMo+5TLb0t61Xs0srO21S5NMdisCDkVqSTq8GBvz2ZLTXskOw+ZEv3lNcK4Dz8k1wRF5Oxx8KPpiIaWyXTjK5GudZ6NAiir/AJvEVloatZJ62CghDRIOoIaAd3gEgsVqkRwokOfJE3byHFmDxkPRIgMzFSUH9bfJmE7Y2ZAEx7rkYbym+IyOY6BwKe2poxr2n0MUiB4Q9ltn/WiMnlafuMUQMp1JF2mSg/83A+p8yTX6/EOjOckGa7ah4HLaRV7lXy3TxO5J9CHs4tb4EnsCsfkMxhJFVo5acrSPnNiQRFqjutRxygTESJBG5HpTboaDnHj/3S88Pw9Hv5uQ+h3sU8szAKeagQJvXc/+mHHbYu0SBrqj41v3wL6tHFppaKe+dW/ep7cVXXKxurQv/pDFy+843XTgbmAmF5dc2kgPZFKD2iGPOzbx0hRGI6N+Vj9ImGAr/gxIPZ7ItwKdfbBki5uYWURfHd0GpnR4eQISfdzPkUl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199015)(83380400001)(6486002)(2616005)(186003)(26005)(6512007)(9686003)(6506007)(53546011)(478600001)(31696002)(38100700002)(86362001)(36756003)(31686004)(5660300002)(8676002)(41300700001)(4326008)(66946007)(66476007)(66556008)(8936002)(4001150100001)(2906002)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajV5MVNEb3B2anZjLy9UeW9ydVZmRjduQU5zZUNCcUlRMzFnWi80VHljMEJp?=
 =?utf-8?B?YUtBL1liaUJ1NHl6YUNrSW9qS213eEdCQmRtR1dHRHhFY0JXV2tRWFJ4VDRL?=
 =?utf-8?B?QWxqOTFTWWQvelpiSXFlWEp2OGhKQ0hvRHo0cFJ6UjlCdVFtS0ZoelpKSjZx?=
 =?utf-8?B?dThwWWpQUWJ3SHdOWWxjdjNuaklXeFJMUjNCQzAxc0tpTmtkMDYrWFp0cGFP?=
 =?utf-8?B?WkhvbnU4NnZBVml1ZVgvR0FoWVlMR0x6YTlncUNqcDhPNUlQdGtyLzhFQTlR?=
 =?utf-8?B?YUNkMEpaWkd4TjNmd2FjeUtZa3BWdkMzeExwNC9HRkNRUjFHa2YveGpxQ0Rl?=
 =?utf-8?B?THoxcmVoV0dxZ1c4Zk5FQWVHOC9FaUxCall6OGMyOXN3dkZXZzA1NForK2Jl?=
 =?utf-8?B?dFpTTUozY2hvOXF5YkM5Wi9aRzRaYThNdWU5ZjFMOFNlT1dsMlYrRUQ2Ti9W?=
 =?utf-8?B?ZnQ5azE1OHEvMHZMWVUzZmlNd0x4OG4wd1VFa3ZBSElrcUtJZ1R5cFFpRzVU?=
 =?utf-8?B?a0VmZWc1WXlLTk0vRVI3SlR4dW16MGFjWU1UQnpqNVU4a2h5WmNqbXNsTlVa?=
 =?utf-8?B?RkVYRkhYNjRZRTNXbHluM2pkR0NZZnA5MzVCOXNOKzExSTQrc2lHVkp1MUdh?=
 =?utf-8?B?dlZXNVpjZlVBM0ZhZmV3MmNRajltRWdTOWg2d3BMdzB2VnJwMEI5azZxaXFs?=
 =?utf-8?B?dEw2Yy9wdXJEOXBWSyttemt1UXNnRlFHTStFM1NIc0ZpOHpoOXE3YnN6RnB6?=
 =?utf-8?B?L0M5cnlnOWk4R0g3eStCdFNMSjVWOWN6WEtMMW1jMTBMdE9lZnYralFORWVZ?=
 =?utf-8?B?MEN0U3BmWW53QmZmQTFWVnFSYTRMRExWQytmZFp6aFR4ZXQ3ajRaR0FsR08r?=
 =?utf-8?B?SGtOZzdqY2ZvZWdmeGpvRkFzaklQOTNLeGtPZjcrcEhITHlBd1Q2MENWdmNa?=
 =?utf-8?B?R2RwN0xjTllXcUNQOEVSM3VwQ2gxK0pLbHM4bVNGUU5CU3UxYWpoR2VVSkxO?=
 =?utf-8?B?byswWkhGNzIvb2RGOGhtODhrc2JiaWhMcjE0RVhBL1BTUkpTQndhd2JtdkxG?=
 =?utf-8?B?aGUvYUxoTTAwZmdhcktuWCtJT1dzckpCNGhiUGJ3S3Y4YnM2aGloejRIMkNm?=
 =?utf-8?B?UGUwb0NMUy9UZDg5dENMZjNHWkZTcVpSQUJvdDllK0ZXakZWODRrVXR0dytp?=
 =?utf-8?B?OTYrMGRHUE8zK05pVWo4SnozVXcxWlR0YkN1R2ZPT3JwZGpZQ3JWRkpFbmtl?=
 =?utf-8?B?SHRvUEw4VVdNT1NDNEplNk90bWJ2Y3p4YlFUZFlKVHpGUjN4N21SUlZzUUlv?=
 =?utf-8?B?bUZRMnBNN0daWkxHZzZWM1pUK0RMSHZSam4wVWRjQzBWbW1LK0d6am5lOUZv?=
 =?utf-8?B?R3lpL21iYTMxMTk1eWo1STFmVGZxRmhuR1JOQ1FNazJTcEdYbVc3dERGaWlU?=
 =?utf-8?B?REt1U0hZN0FBVVdHMk1IRDEvY2dwSjV6MHBSUlJuZEpQY0dqcFJjcklOdjNC?=
 =?utf-8?B?Y2p2cUovR0JNem1hbGlITlpyeEdrME8rSHhkTktBV2FoellvNC9sbWp0a2Ir?=
 =?utf-8?B?U2sxYjRTeVBPZEt5RmYrczNYdVFuT2RtbENrOUdkQ2dpMnM2VHFSMFpGSFY0?=
 =?utf-8?B?YzZjMU9uM05udmxNMllEMEZGRmRYQllrdk1rb0JTNDJYNC9CSmd5R2lyelY2?=
 =?utf-8?B?V1dDMUdLU3BsZ1p3OWRPQzVuczF5T2k1R3J1SHZYbCtYYTAxeTAvdGw3bmV0?=
 =?utf-8?B?ZkZ2WWFqaFNmbFgvUlBtVksvSnlvM2RzdUpLQTRqODhzbldUUGdOY053NFJu?=
 =?utf-8?B?RmFZRVdvUDhXYnpiMEFuQUVEMzNUMVQ3UWtpMEkrS3JGUHF2azc0dmQvRjJC?=
 =?utf-8?B?NFRwY0h5ZFFWb2xvbTlTdCtKbjV5ci9HWWlHY3J5WGczR1AxL2lzQkJCUTNS?=
 =?utf-8?B?dWx6T0RHNCtpbkJFRnY4TnhPMzhMOWo4ZVovWStYRzI3Tm1SYkE0ZVlKZkRY?=
 =?utf-8?B?a1BjUVBYRlhkbkdLU3ZFRjhCaGF1TkdEcnVIeTFRU050OVN3NVBrazBjZFRk?=
 =?utf-8?B?S1BoRE15ZC9uYml1ZUlsK2lqOStqZVlaRkdqWkNDV3Bkd2N5VDhvT2JTczNI?=
 =?utf-8?Q?00kMQIZ6/Ouz+TvI8FqgoaXne?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2e699f-6a3b-4534-8dc7-08dadc459751
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 13:34:27.7623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yG+f9g2iI7nPbUdd7GBwxN1EFErI5WOWSJ4hXcSFauAlmVTiJRRuWpoVhhJM/fghoT0qFmvJDMx7VyKZnsWuAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120125
X-Proofpoint-ORIG-GUID: Z1Ysvhp55JxE59o1ytYMHMOu9aAIbYZR
X-Proofpoint-GUID: Z1Ysvhp55JxE59o1ytYMHMOu9aAIbYZR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 12/12/22 4:22 AM, Jeff Layton wrote:
> On Sun, 2022-12-11 at 11:22 -0800, Dai Ngo wrote:
>> Problem caused by source's vfsmount being unmounted but remains
>> on the delayed unmount list. This happens when nfs42_ssc_open()
>> return errors.
>> Fixed by removing nfsd4_interssc_connect(), leave the vfsmount
>> for the laundromat to unmount when idle time expires.
>>
>> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4proc.c | 23 +++++++----------------
>>   1 file changed, 7 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index 8beb2bc4c328..756e42cf0d01 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -1463,13 +1463,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>   	return status;
>>   }
>>   
>> -static void
>> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>> -{
>> -	nfs_do_sb_deactive(ss_mnt->mnt_sb);
>> -	mntput(ss_mnt);
>> -}
>> -
>>   /*
>>    * Verify COPY destination stateid.
>>    *
>> @@ -1572,11 +1565,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
>>   {
>>   }
>>   
>> -static void
>> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>> -{
>> -}
>> -
>>   static struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>>   				   struct nfs_fh *src_fh,
>>   				   nfs4_stateid *stateid)
>> @@ -1762,7 +1750,8 @@ static int nfsd4_do_async_copy(void *data)
>>   		struct file *filp;
>>   
>>   		filp = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
>> -				      &copy->stateid);
>> +					&copy->stateid);
>> +
>>   		if (IS_ERR(filp)) {
>>   			switch (PTR_ERR(filp)) {
>>   			case -EBADF:
>> @@ -1771,7 +1760,7 @@ static int nfsd4_do_async_copy(void *data)
>>   			default:
>>   				nfserr = nfserr_offload_denied;
>>   			}
>> -			nfsd4_interssc_disconnect(copy->ss_mnt);
>> +			/* ss_mnt will be unmounted by the laundromat */
>>   			goto do_callback;
>>   		}
>>   		nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
>> @@ -1852,8 +1841,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	if (async_copy)
>>   		cleanup_async_copy(async_copy);
>>   	status = nfserrno(-ENOMEM);
>> -	if (nfsd4_ssc_is_inter(copy))
>> -		nfsd4_interssc_disconnect(copy->ss_mnt);
>> +	/*
>> +	 * source's vfsmount of inter-copy will be unmounted
>> +	 * by the laundromat
>> +	 */
>>   	goto out;
>>   }
>>   
> This looks reasonable at first glance, but I have some concerns with the
> refcounting around ss_mnt elsewhere in this code. nfsd4_ssc_setup_dul
> looks for an existing connection and bumps the ni->nsui_refcnt if it
> finds one.
>
> But then later, nfsd4_cleanup_inter_ssc has a couple of cases where it
> just does a bare mntput:
>
>          if (!nn) {
>                  mntput(ss_mnt);
>                  return;
>          }
> ...
>          if (!found) {
>                  mntput(ss_mnt);
>                  return;
>          }
>
> The first one looks bogus. Can net_generic return NULL? If so how, and
> why is it not a problem elsewhere in the kernel?

it looks like net_generic can not fail, no where else check for NULL
so I will remove this check.

>
> For the second case, if the ni is no longer on the list, where did the
> extra ss_mnt reference come from? Maybe that should be a WARN_ON or
> BUG_ON?

if ni is not found on the list then it's a bug somewhere so I will add
a BUG_ON on this.

Thanks,
-Dai

