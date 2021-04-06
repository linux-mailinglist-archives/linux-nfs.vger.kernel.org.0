Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71969355CA0
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Apr 2021 21:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237995AbhDFT7A (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Apr 2021 15:59:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34244 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhDFT7A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Apr 2021 15:59:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136JwjtA171228;
        Tue, 6 Apr 2021 19:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ao0KlE3Qu9LvSct8DDvCgwBPuhAlWaPfCsGPykqsg8s=;
 b=FbtQ6yCEQraMfnGKywaiFnv1joRQjF2F71fSPwY1OQHWaEvFPgKYgXADAPyQvC2qB3sv
 w+D4s54RSKwLCVfsnlzkL3E5qRZ99ry86l4i9/u0mI5+3M/JEc2hjqsOanDp+G1PNxY5
 xF52TQFPQHVzyVjIVsKLXN85/cIIKSSZV1HwCNepzR7sRWl4YTLoR0lddHQgcZrQm/Dt
 SaUXDf3cPfnxFATxOzs+yGkCIymAmPWk2CH1mmmCbUZxDS8FSl4Nmm7jwoybqG2oNNYp
 3AvXHyoU955GFsd9Vnh2uHewus124E900A8YL88XLhhggdEiXO1F/tMIuPN75OE1tuUW Nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37rvas0c6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 19:58:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136Jt1V2129314;
        Tue, 6 Apr 2021 19:58:47 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by userp3020.oracle.com with ESMTP id 37rvaxmx8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 19:58:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Blwg4y3tOaGPIgyRC536kVlMe9LcrHYdE2o125WAdQgb6cEI58NYkLM6PNGC0CT3FG2NmCJqfPIMhPWLhbpy9FPAGOWUd/XltCHvbv1Y+c++RP/PdMmSdVcAFmKQGE9efE8IFfXU4dCuC5EhSjcuQ015ugXm5SEriy0Bd5TRUs8fSmFH95n2G0Ote78dq0SVQ6E9H6CRcYj9Ov5Wir886S3c1MX05h5niCbrcregwG79WvTLFYOul4nA7pMtxwiIVnPR6mSRRcBmPnS1jBx7MO2PC5vgOQUEPP/JCu21o0FdlJS4oN86QcxxMBKDBC0lI711EZ56/ZS7K/mNuIqFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ao0KlE3Qu9LvSct8DDvCgwBPuhAlWaPfCsGPykqsg8s=;
 b=WwgCnH6KSyZhOurVluVUJurHjn0XuAgzY0GG6yb3AdxS3x92VM7XV680LsqPPiJ68nu4IDGBX1Q/JrkMb3TqLAi7sBgX4OHSB/wGviCG6UVTS2JUC4qedasDBI05pAIl98YkNQozTbLddtjwWyvHq8mjnZJmsidoHpru4WEAz9ZJeEjOPJvgnEsZNN89qhks7fucW40f4Mznhi63faheULHDmBSXUyUrnYxiv9VOrfDs8hn775v56JShrNkMehDd20KKFiIUDfckrIYaqeKAxmMHv1mzW3b9p5ikT7yVSkCXo2dGkEcP5qffPXR4nBTAfNrJjty1gjsZnNO+Lu2lhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ao0KlE3Qu9LvSct8DDvCgwBPuhAlWaPfCsGPykqsg8s=;
 b=aFdDogRRVdGpDGlez0uMtQoXEb0DCc0l7zYDiTX7n/i1Q3y9r0zOZVwYqpeCpwjt8fzAxAe62vGfo8c8IkYX8SezzjhOcXM4UCQgzio3Uj3GOaErJnlRNzLqiqOeDfl28schUbtJ+2CioYeGO/NiLKRFJ0+k0XrXo59g8hy68u4=
Authentication-Results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3719.namprd10.prod.outlook.com (2603:10b6:a03:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 19:58:45 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879%4]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 19:58:45 +0000
Subject: Re: [PATCH v2 0/2] enhance NFSv4.2 SSC to delay unmount source's
 export.
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>
References: <20210402233031.36731-1-dai.ngo@oracle.com>
 <D85FBDD3-5397-4D47-932D-159AFE2A5E0F@oracle.com>
 <CAN-5tyHVOEr7zZM92PVS0GYJQ2M6rSs6_zqZwuioumQQm7zzUQ@mail.gmail.com>
 <7BED2160-1052-49EE-BB62-6ACF6F84C91C@oracle.com>
 <CAN-5tyEKqNHmwiMfCpkZrCVYeaO-FH69v5L4Tk_8EsoTfytpVA@mail.gmail.com>
From:   dai.ngo@oracle.com
Message-ID: <7f765404-7769-b39f-265f-f46d3188353a@oracle.com>
Date:   Tue, 6 Apr 2021 12:58:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <CAN-5tyEKqNHmwiMfCpkZrCVYeaO-FH69v5L4Tk_8EsoTfytpVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: BY5PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::37) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Macbooks-MacBook-Pro.local (72.219.112.78) by BY5PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:1e0::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 19:58:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdc7175c-920c-4279-c988-08d8f936626a
X-MS-TrafficTypeDiagnostic: BYAPR10MB3719:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3719DF4980078BC11378F3B787769@BYAPR10MB3719.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KLWaVzL5GshnL1w/CLhFovJanlI2wNOZWd6r76tGOqVUsBJkKNXsIGCuPUcCedg+0BB2GElwz/FfHIh28iqhtGAWOETY3/E4LpgrnG1bzu3YzHPVJp5ZijQnFlnPXkNMZdbB+4RFKgmfiGInkB/NwIjxckbRylGy1b2Dn2B3O2URZzzuIXz+CX8N9fHQrzlPsvMxXr3/nqAapnERT51de8FTr48RBP6bnJPQfM/v7MQiU1eA6WjfI7rQbCP82TWJcg8DDUqkVNkm9B9Szs2GWDvkM03IahXWfDf7Zsdoa8v1uKVXz7p09CKTUlvSMKVlp21czwFwQehN7zIA3yJ8Hp4IXmeAkepAOIwIVESJTlBo/lE4qpldtSgbbsoN/dWvUEOFzmH2Xv86iBLNDmu3nNlguDbMUDEZeE/BHPTOX+/M/TViaVtLNSZxuEladBiXm2ev8Y4EOeegg4+Cfu5rbarYHmzSgQgAmUau0zyz5h8I7B0UrZR+HBpxNqM4GB6WAaHLPggk0uZW9HYegMq5SGaGFmxnOfymSomaDP131Q2JOkIOn1gDyF7dpNbAb/kJLmkaNrrG1gJAzd/yg9bhSYADpCr80NTl6JElTSE+DWa24O5WhXa87BBPNPMsb5/FekBvObHlurZQTVPjslven285Bzj8sFPkB4HQI7dQwgyMtkenbLXh2P8OsEOT7Y0M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(39860400002)(136003)(346002)(54906003)(66946007)(186003)(86362001)(5660300002)(8936002)(31696002)(31686004)(6486002)(956004)(16526019)(26005)(8676002)(66556008)(38100700001)(110136005)(316002)(4326008)(66476007)(36756003)(83380400001)(6506007)(2906002)(6512007)(9686003)(478600001)(2616005)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q1l2Zll0VkdmRjlDQUczUk1scnlySnFjTGhxT0lGK21hTWcwVnViWDB2NWF6?=
 =?utf-8?B?bWRUVkFIRFhLVnZ3R05Kenh3eHY3bWdyZkxNUGlxaktBYU9aanVQMEhyTnZ5?=
 =?utf-8?B?SUprSmptVjNGMHI2MXFhSUF0eDBHRjJ4Ym1IdkJ6dlVFbVJjWE1pN29acFBu?=
 =?utf-8?B?SStYYVBRMmNHKy9NUmhJMCtVV0dQVmo2RG44WGh5a0hYWW9VNG9vanpXQlVG?=
 =?utf-8?B?TGZOWDVTNUxuSGRsK2V0b1QxbzBQd1BhZVI0K1huK01yRHluZTZMcWpXYUlF?=
 =?utf-8?B?bVlBalhncE4xQmNFc0JaZW1TbklPYzZVZjQ4K0R3UUgzWFY0cUR4QTVpTFNF?=
 =?utf-8?B?QnNhMDR6Q3J1NGp4TFltRFV5VWxtZkxqYVcvZU1lR01za01Tc1lzUDVBM3B5?=
 =?utf-8?B?cWtjWGNhMU9laGpxUllXSFI2dGlrZXRVY0xNaTlzWEtCVTVkRjVpZGdMRWdw?=
 =?utf-8?B?Rjc0c083SXZhNk9ERklPVGJzU2MzTUw1T25DVDdRZHdPSXV1SW01SXR3eWRl?=
 =?utf-8?B?c2hGUU9SQm1iRWFDSlFTcVNGT0VMQXpzWHowYVJoMzR6V1RrdFQvbGpPQkNy?=
 =?utf-8?B?MlBTNnJGdHpXWEkweTlxSlNpSFlTeXhPMUl2VU4vaFdZMlI1N2NjWlpkV0Fo?=
 =?utf-8?B?S0h3MDhwZlpOV09PanhLUFlmeFZuRnpVVmYrMjZST1F2STZqa0ZjRGkwdUxO?=
 =?utf-8?B?eDRKenhySFoyNjIxZXdobjM3RFZMUk9XdTF5aWdvQ1lxVlpTYXQwcFVHUDRp?=
 =?utf-8?B?L3pXVUNNS0x3M3J5MDdmdlBQTTZtdVVpb2ZYRTNOWndsQXJMMmlaZHUvQW53?=
 =?utf-8?B?anpHNTBtcTg3RitPWUo2Um5LdU15M2VZK3Q2ZTJQckU2ZHA0NUZ0S0VWUGdM?=
 =?utf-8?B?SU80cTVsSUNaM1cveUJSbVd6Smh1NTg1LzNKN2l4V3VZU2R0NE1YcGpTYVRw?=
 =?utf-8?B?aU8ybmJJRDc5ZVBMbUo2VnhaTkRva1VBcVNDaFNHRjMyRVZUZmZmRHplaFJP?=
 =?utf-8?B?MkdrdjdWeDRhSTVHcFpOWEJBYVdONjFwZzhKUnZLUFJRcG0ySnVBS1gybXcv?=
 =?utf-8?B?bWo5cTlPODhQRlh5OXpCL1k5ZE9xcXI0QWtMb1lFSEZ5ZVNBWXh5VEtINjF5?=
 =?utf-8?B?K1FCbGpJZ2FGa242aWVqL3FPa3JjS25TaFBDV2pCSFczWTVwdjIvRDE3dFpX?=
 =?utf-8?B?Rm44cWEzOFBCT082MGY0c0xIYUllNU44NmpydUtiM0IzUFB1VnVtdVRwaURH?=
 =?utf-8?B?Q05ESUpsQ2MxcUtRNExwcmpic3o3bHlpU2hVajk0SDVCR0pNSG1qdFRnMzR6?=
 =?utf-8?B?c25kM0xaMGJEdmE4N2dWbkovVXlRTEtEYlNjNG42b0RFZTFkQ2s3OUw4ZmZ5?=
 =?utf-8?B?UFlIMnM5VTZnWkhqUFk2S2FQSTF2SVBzdFdXZGlzeEFJdmMyN2YrQ2F3TXkv?=
 =?utf-8?B?dmJzSHlKc3BLdTRSTUVBc3NHSmNxUnpsVzhaZ2ZsL3cvOHhJQ1ZsS0h3SkxG?=
 =?utf-8?B?TnhaeFpSTFllRFlQZzdkRFQwbUZpekpUVElndmtNQXFlbVB2MFRVdG9FMFhz?=
 =?utf-8?B?d1hBZWFwNnJtRWtWZm5Qd1l5UDZkb29wbk1yRW5KZjRHMzV3VFFvdEpWdk5Z?=
 =?utf-8?B?RGJ4TkJDNFFvZnBkM1docXM0M2tmYzBZTE9pamFPelU3YURYaVNCMklCSi9T?=
 =?utf-8?B?QWUyTXcwWGV3VmJWdVQvZlNqSG14NGw5b1FmcXZFWE1IdG5Tcm5GRnBTcUxp?=
 =?utf-8?Q?nb9H8/YAHmE3I0Ak13t4zkqJmYvpG51aSW5p42L?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc7175c-920c-4279-c988-08d8f936626a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 19:58:44.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCdqV0uIV5XBwMY1oeU47Pyo0Ets40NDyE+i1vdETnOTG2E/JrlG+wyvGoFkjYzNxsNtYOQyFzaZabueP/hHrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3719
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104060135
X-Proofpoint-GUID: QHlMO2a11LFPBmDOwOvw-oq5CAVBhOZ2
X-Proofpoint-ORIG-GUID: QHlMO2a11LFPBmDOwOvw-oq5CAVBhOZ2
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104060135
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga,

On 4/6/21 12:57 PM, Olga Kornievskaia wrote:
> On Tue, Apr 6, 2021 at 3:43 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>>
>>
>>> On Apr 6, 2021, at 3:41 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
>>>
>>> On Tue, Apr 6, 2021 at 12:33 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>>>>
>>>>
>>>>> On Apr 2, 2021, at 7:30 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> Currently the source's export is mounted and unmounted on every
>>>>> inter-server copy operation. This causes unnecessary overhead
>>>>> for each copy.
>>>>>
>>>>> This patch series is an enhancement to allow the export to remain
>>>>> mounted for a configurable period (default to 15 minutes). If the
>>>>> export is not being used for the configured time it will be unmounted
>>>>> by a delayed task. If it's used again then its expiration time is
>>>>> extended for another period.
>>>>>
>>>>> Since mount and unmount are no longer done on each copy request,
>>>>> this overhead is no longer used to decide whether the copy should
>>>>> be done with inter-server copy or generic copy. The threshold used
>>>>> to determine sync or async copy is now used for this decision.
>>>>>
>>>>> -Dai
>>>>>
>>>>> v2: fix compiler warning of missing prototype.
>>>> Hi Olga-
>>>>
>>>> I'm getting ready to shrink-wrap the initial NFSD v5.13 pull request.
>>>> Have you had a chance to review Dai's patches?
>>> Hi Chuck,
>>>
>>> I apologize I haven't had the chance to review/test it yet. Can I have
>>> until tomorrow evening to do so?
>> Next couple of days will be fine. Thanks!
>>
> I also assumed there would be a v2 given that kbot complained about
> the NFSD patch.

Yes, I sent the v2 patch to fix the compiler warning on 4/2.

Thanks,

-Dai

>
>> --
>> Chuck Lever
>>
>>
>>
