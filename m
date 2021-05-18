Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB710387EFD
	for <lists+linux-nfs@lfdr.de>; Tue, 18 May 2021 19:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351306AbhERRw1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 May 2021 13:52:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14330 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344873AbhERRw0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 May 2021 13:52:26 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14IHhNdL000937;
        Tue, 18 May 2021 17:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=NXK+fQh8qciQQoxeM8Xaki6PoTvskMo0Djv9xe/njhE=;
 b=IwRW1dMDJ7Vn+5LoFClneN7OUUx1T0MQT8Uj/rqUibZEfZ+hUp9sGBL2OV7wjG3zht5z
 CBh1u5AysACOo6KDgwyzFHme7hv2pdB8bdr8LwF2o49/qO9l1lCqMzY4WJtx6MoYPPvj
 SGfTK9uM2BvodSchh+ZD8olGzf6mt6Polu16/5bE9PDlnpoDXbikNpgweMom50L71Z/b
 8vCzC39a+18IbYs2EioM7k2kUrwH3tNpUvJzVzwIiqs3pg3n1XDjthIqBzdjkQx5BWC0
 3khSXmvtjuye0Q7SujBRYQN09r5WBHwGjtQq4V8blawy54o7IImS17edzkcI7g0PMqe+ QQ== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38kh0h8ryj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 17:51:06 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14IHp5et005741;
        Tue, 18 May 2021 17:51:05 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by aserp3030.oracle.com with ESMTP id 38meefeejk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 17:51:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqJ+vzr0i/R0FfnrFYIyfTtdnR+rD50IsMvpfCYtqdT/Y/MmU0HFR58y5lc1Igy4Ek6GH2+GmlgsTBMkjwSDm9r8WjsPVfz5GRE7l0OYgv786BlY5xiTXDa86Q67UUPfOpESbqoL6FIadWbo4ADN3kPRV1ochbLp/JDT2MNg8HaPAClUJamEjBIrDBsilARK9N+2MZh7bv2rWiDJXaDHKjHDoK9TO7O4cEqrO6pxpZ+2/6D0mOp9dUQnHwgSJfZVxfB9+AI/IzBoVS6OPnCRJ6urnISf1T4cyCUioyh2/QNt08PZ+A0b6g8C7+u7sxYsRfX71xsONGT8950nxtNL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXK+fQh8qciQQoxeM8Xaki6PoTvskMo0Djv9xe/njhE=;
 b=UJ3VLe0t9GhwCWtAcPki8gizQepqciYBa+wGk4Kp5FtIKJkvmrRo9HdO+5+ia/HWMEnADD3LQ6HUjWTt514F4AhTQE02fPwiwwc/B+eU+vFuw+1ysq/XEPhrTsPtUs9bsnwFpkwR+k94vjXFUq1doCbMWSnLKw3m3C/gV2WBlk2tb3MzKMb+IwNM6+wIdT37LgkTwg2RTQTCX+NMVXK4oQpo0V+nTn+tD3h7Hps0Zhz/5VBXehU/C+K+RMfXZrXZNAKop5hQC8nA6twfGU/YtG+WEQ9ydXi+K8gxLG47pIFby5Mnsw4BTzjrph/L4WHNSwMPu8Oav5JO1jBPaQP9BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXK+fQh8qciQQoxeM8Xaki6PoTvskMo0Djv9xe/njhE=;
 b=puvKUtKIF+ETmbgYBy47RKD5hIdXvhsdzvzMRt+Ld8wHw4H388cXaVBkRbAFXPofe0l/U+tIeP3QOz4JUuosOh6A7AqsZoHNb4V0HnwxOyil8glUDvbDlaJvb0Ic5o9ntHENuM4Jg6WPq+XLcmiWuXrE0vCO+xWSEXIVJmUoExo=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4605.namprd10.prod.outlook.com (2603:10b6:a03:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 17:50:59 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879%4]) with mapi id 15.20.4129.033; Tue, 18 May 2021
 17:50:59 +0000
Subject: Re: [PATCH v5 1/2] NFSD: delay unmount source's export after
 inter-server copy completed.
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     olga.kornievskaia@gmail.com, linux-nfs@vger.kernel.org,
        trondmy@hammerspace.com, chuck.lever@oracle.com
References: <20210517224330.9201-1-dai.ngo@oracle.com>
 <20210517224330.9201-2-dai.ngo@oracle.com>
 <20210518170456.GA25205@fieldses.org> <20210518172105.GB25205@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <8bdfd7ac-8c42-8af7-ff2d-624669f7244e@oracle.com>
Date:   Tue, 18 May 2021 10:50:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <20210518172105.GB25205@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: BYAPR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:a03:100::15) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-230-11.vpn.oracle.com (72.219.112.78) by BYAPR08CA0002.namprd08.prod.outlook.com (2603:10b6:a03:100::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 18 May 2021 17:50:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 444206a7-2ad5-43b4-dd01-08d91a257ed9
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4605:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB46059C584951A0610C619C3B872C9@SJ0PR10MB4605.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6aZ+2EnfKhsFeU66M2Wyc53EXPTy89tAodiTgJUgC80cztCCvg8vFNm4XPRNR5IMTuD/6bNWzFl41bt2CHsGLOOd/rpNk2pCpV9I15pstFp6fgyfrlpUQd9rk1XZBTQyI38s18kGOX32W0GfnAcicShb9ldUkqawbo8PEPGiA7ckbf6UE+nEVsFgDUXiyjOKH09zQBs6cSSkTFgk56xc2FFkLaYmT0vUVYu5Ykgi+jd3pZRiDSdSA1CvntKeFThmKUyszTdqCcS+cErct9pF9APVzF7n3tSPvX/pWCTBrXAI83f+QzHKfrpwiVr+fpziD+7WJYhNkN7nFFXbm8SbELcVSkcPrnEUjHaa5uqXONKw8bFVIOnBPy6eBfgsSiBR4QSobL6OwUW3/PWV/j2exCXrjS2q33ujFO0nkqVq1GwOE6u/1IzdT+tqjktB+6qVIaC6YRpfcrNOsPEHQFSKPfn/zQJtL4Anzwq79M2maBN7JqH4QoPzyh7nVz3002lCFonHHw5IIoqqJV7RYNm8S3dzr/c7Hm4T6sM+f8aZD2oSWHRk51tdrHvSwE2yohAQDjbMGTfTg64B/SxRVIxIdA0cSJ/TmymCK9D1oUVXrEj+2VInB4IxBJm/E9K/QNKckdjo9ycyMvNSuRwC8CREA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(396003)(136003)(376002)(7696005)(9686003)(26005)(83380400001)(16526019)(6916009)(186003)(31686004)(31696002)(6486002)(2616005)(66556008)(478600001)(66476007)(36756003)(86362001)(2906002)(38100700002)(5660300002)(66946007)(316002)(4326008)(8936002)(53546011)(8676002)(956004)(107886003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WDc4V2M5Rm9KdHgzdXhCTFZsZWdnMXFTT2pTYjVrNEx6Q2ZxUEdZWEVOVkUx?=
 =?utf-8?B?bzgvNysrc0pwdU1nMVh1cy9CSmpyWVhlVEFYdlhkaTgvY1hKTHN1T0E0VWV4?=
 =?utf-8?B?ZXFEakdoYndvdktsSTdxWmZ0N3E1bVhXajRLd1h1bGpTTmJpVkNSMlozMk9v?=
 =?utf-8?B?NkZNQ2xobW1GbWZpZUs3d3poeFlOWDEzNGJoMjFaZ2VpT21DK0hwc0Jpejcr?=
 =?utf-8?B?MFY4dnBDREU4b0VVaWs2aVU1RnVVelByNHR1SER6STh4WjhyN1VvaFl4Mnhz?=
 =?utf-8?B?WnhIRXg3dHZKdDNTdXNrckZaNHdqK2R2NGRDWlQrUGVsaEhoVGgvT1FUaWlh?=
 =?utf-8?B?UUxPV2JaVE45cGdXTFY5c3FtVkdTSFJTTytFaFBiZERyQU10a1NaTXVmSG02?=
 =?utf-8?B?d1d6TEppUnh1TDlVZUNLY2J6bTRvQStHWW03NUhvTVVTSGlTYVYvbVZERW1F?=
 =?utf-8?B?ZjZ3aURUMkdmeGc4T1lVcWpROWEvSW5FZ1JDQWdoTkJDOGFQMGdHTzZidmkx?=
 =?utf-8?B?UmRZOHgyMmxDUXhoRUFiSndDemtyQ0lOZlQ4M1M1SnBaUWIrSHlBcCtPM1Zn?=
 =?utf-8?B?ckU4QStldWJadzErTndGNU9BOXkxQmN5MllBbWJCTkRZVUlYdUo1R2JxWi9u?=
 =?utf-8?B?SGFuTDlMdUFKeittOWFoRUtwUzBod2VKbWVnMFlISjdKbXViUkZEd2crWXpr?=
 =?utf-8?B?QTNIZ2hUS3dhVWhoQ1F0Ny96SGN3cnUxTThMYXdqNE9hQ013Y3FMNUhrYWdz?=
 =?utf-8?B?WWczVmpUYlVud0s4VGlWUkpmc0RXRlg4RVlrMVQ0VncyeHh5ZzF0R3I0YUlM?=
 =?utf-8?B?Wm5YRythTDhSbm45STFrQ1NxT0tPaTNnaElXK0RoRHhwb29mamp2UmFtazNj?=
 =?utf-8?B?NFdCbEVUTmNHc0tGd1Zhb3ViUklOYTZZcG9iQ1NwYjY2YXdHM0JrWmtqeWZL?=
 =?utf-8?B?c01XRUxlZ2paZ2twQnNKR2lSMXN4VXlHR3AxbnhoRXpsVm1DektEZnY0UHlh?=
 =?utf-8?B?YUFnRzNydkZhRWVjeVBjVWdvSkdQazBlbi9jSzk0cERFdXVNYXZhdXB2aEpZ?=
 =?utf-8?B?OE0zandxWGp2cWFISk4zYllpZHlRTWRuRzlHYjVWcjUyenBiQm13R3RRd1Bk?=
 =?utf-8?B?VjlEdnRDU0tiN1lmK2FMeHEwMzhneXlSWnNaelJvYk9scnFBOFltbnRrQ0oz?=
 =?utf-8?B?cVBlRFhlWE50aGhteUx5VXRVV2xNS0NjS2hjNS9pK0llL3MxUVNwMXB2elIr?=
 =?utf-8?B?RDRuQ2FQcitELzBnV2JxdnlkUjhkMkY4SGtyYWhiak9GVGQrY2NtS0cwM01u?=
 =?utf-8?B?UzJXdXEzOTZpN2RqQ2gzVjhybGJ2SHNwK0YwZVdhQmcrV0FJeXRlajVTRW1p?=
 =?utf-8?B?eDd5U3RyaDZvSVhYU1VSRW84OVlwQW05Z0xGdWgyRFozUHIvRW9OMEZaeU5a?=
 =?utf-8?B?cE8xWUtMUlE0dnp5UDJqelc1MzZBUGpic09aUTM4VlZXVTlhZnhKTWt6V1o0?=
 =?utf-8?B?ZmluSE1wZEVOSGE0b3BjSy8rSzNIV08zTm1WQ29GZC9MQWE5QTlNUFRmWUNq?=
 =?utf-8?B?a1dTK0J5TGthUFFialRQTmJzd1NxbTlmMFRxby9Oa2l6aTYrOGF4eGwvbFY3?=
 =?utf-8?B?Q1JXNzY1djBpSkpzdWtBTXRkVnE1UVZ1Y1pTWFUxOWVRNkZBUXB6L1djWmh5?=
 =?utf-8?B?cTJDRWNoOVM1WUpndTFGVFNlTldCV1d6WkhnR1ZFejhCWHRJOE1WWDU3cHI0?=
 =?utf-8?Q?Q2yEB4Y3eOxPSRUb5D3DfgtevGpAztaZTPF8fop?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444206a7-2ad5-43b4-dd01-08d91a257ed9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 17:50:59.4881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiXs96VxUP/ukzpTtx3zikaGDF6uJpl9IDvGJzcjG9GKBGflfnvnZY1yR2D57e0xoThyiqy5phLuNK7vl2SPNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4605
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9988 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105180124
X-Proofpoint-GUID: RnrdTAIO-nz7EuKsGSauccS3rA5bCwz1
X-Proofpoint-ORIG-GUID: RnrdTAIO-nz7EuKsGSauccS3rA5bCwz1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 5/18/21 10:21 AM, J. Bruce Fields wrote:
> On Tue, May 18, 2021 at 01:04:56PM -0400, J. Bruce Fields wrote:
>> On Mon, May 17, 2021 at 06:43:29PM -0400, Dai Ngo wrote:
>>> +struct nfsd4_ssc_umount;
>>>   
>>>   enum {
>>>   	/* cache misses due only to checksum comparison failures */
>>> @@ -176,6 +177,10 @@ struct nfsd_net {
>>>   	unsigned int             longest_chain_cachesize;
>>>   
>>>   	struct shrinker		nfsd_reply_cache_shrinker;
>>> +
>>> +	spinlock_t              nfsd_ssc_lock;
>>> +	struct nfsd4_ssc_umount	*nfsd_ssc_umount;
>> ...
>>
>>> +void nfsd4_ssc_init_umount_work(struct nfsd_net *nn)
>>> +{
>>> +	nn->nfsd_ssc_umount = kzalloc(sizeof(struct nfsd4_ssc_umount),
>>> +					GFP_KERNEL);
>>> +	if (!nn->nfsd_ssc_umount)
>>> +		return;
>> Is there any reason this needs to be allocated dynamically?  Let's just
>> embed it in nfsd_net.
>>
>> Actually, I'm not convinced the separate structure definition's really
>> that helpful:
>>
>>> +struct nfsd4_ssc_umount {
>>> +	struct list_head nsu_list;
>>> +	unsigned long nsu_expire;
> Also: doesn't look like nsu_expire is actually used.  Am I missing
> something, or is this a leftover from the conversion to the using the
> laundromat thread?

Yes, will be cleaned up in v6.

-Dai

>
> --b.
>
>>> +	wait_queue_head_t nsu_waitq;
>>> +};
>> How about just:
>>
>> 	struct nfsd_net {
>> 	...
>> 	/* tracking server-to-server copy mounts: */
>> 	spinlock_t		nfsd_ssc_lock;
>> 	struct list_head	nfsd_ssc_mount_list;
>> 	unsigned long		nfsd_ssc_mount_expire;
>> 	wait_queeu_head_t	nfsd_ssc_mount_waitq;
>>
>> or something along those lines?
>>
>> --b.
