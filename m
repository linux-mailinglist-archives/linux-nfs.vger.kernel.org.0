Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9925AF42C
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Sep 2022 21:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiIFTGk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Sep 2022 15:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiIFTEr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Sep 2022 15:04:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50790786EB
        for <linux-nfs@vger.kernel.org>; Tue,  6 Sep 2022 12:04:41 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdYHw029915;
        Tue, 6 Sep 2022 19:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=bHZdMJSBUSKPCq/pWCf6RP6d97RQDncP+V9r4V1cmgA=;
 b=ZpgNVtAsq484J1s+ab+Eu0sBOMizkOunFc9SJSWui4OyR8HC5YFwgI5//+xv3IxvhNlD
 7GKksXN4Klxc4p9250c77D79W059Vbv0ty1ZnbP2AnvRWhDMcgHCJ0Mh88ALXGc7/3VS
 VCWs2eHqFgcaHAjTjpTTP7eR+k03/DVsQkyD71XSafNQGI1xjmyzJrU/Yvh3MlFYqUyv
 5xvvfnGcseRVanNP5T/inu8QiDIdyQorxN9AaCTTNZNg6jzsWzUDWY6x1WOmWyo74Uou
 K+Q8jILEiFP3fwaCLftIqRp43F5/qllF8YzfarLl6Oo158CrKOPYNXfawhqrVtFrrteB aA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftpruh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:04:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286H4HpT023869;
        Tue, 6 Sep 2022 19:04:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9j7my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:04:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqUKgJ/mRu39xVuhoYwOcVWLekBc04ARmOPN5LwSCY1i/fPdZtslSIzEbo0egPUDjoHMG5rI46si5iU+y6vJLO2/e6EeDymmRkXKy4zHtxa/lFwa+6ct7UXDsm+iUGMpa5VH/3u/e7G2xWDNy0zbDKPqYGuKno7oan/jK9PZKcrroQoVsegqSw//8HlPB93Z9RJshsp1+iM88Mt9PmIOcZi8T4wWO55xAp0IJiasvhEpIflVq0S06nibIVzeXZl7KDU/Vb19zwtHgCk3HZqFNqlVtwLoqVpWN+2uMLi7T95SfjqS6vHxpVTH1V0ZwemVOH5pjmkzWWyW0oCvdQDcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHZdMJSBUSKPCq/pWCf6RP6d97RQDncP+V9r4V1cmgA=;
 b=BKnatLVAClzNL+XVh77Nena/uO4YPuttIwlH86SZu4Y/146ftjXBj07plAhQRcOlGwANdSQBxyfmhINgCsMpNuWNTeyxn+ol2Gsm6/Ilq2JDeKd20veNLeFwlO1VzI27YxE2VFWY5yzGhYU3Cf99TcrID/pDmtoJTwZ1p6SGih2m8RbTjej+cXErvaLNjJd4fpFgT4PMhiTshLEME7TuhbFHTKDRsWOl4LMdVp46jxR41A/LUUtrkBM4zALpr5nLyryTdK3XgEXj1Z6W/ZUEiHLCvARyTBIf+Ip01BeId9mZwkTGLSs6yVBpDzPO0Vzfjtvv8+DJzxNoIGkug/Usfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHZdMJSBUSKPCq/pWCf6RP6d97RQDncP+V9r4V1cmgA=;
 b=AgX0MTKjPfhO5PHly0FcmzLzMqPcbKa1ElFlQcFbTJJk/S53YiqEyJOIlYrnBzNRyNVbLYpbvLkzmwgRDGDM2oK5QRKEsgaSzUbp7YsCrMx3A00jG75E6ygOoMqbd5+y+OEiOzBNivcafeMOI+sqWhN9mSix4OUsTH/23ni2gu4=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DS0PR10MB6799.namprd10.prod.outlook.com (2603:10b6:8:13f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:04:30 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::803:3bcf:a1ee:9e1c]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::803:3bcf:a1ee:9e1c%5]) with mapi id 15.20.5588.010; Tue, 6 Sep 2022
 19:04:30 +0000
Message-ID: <e5be438b-2d1a-35cf-55ac-1047a544aab0@oracle.com>
Date:   Tue, 6 Sep 2022 12:04:26 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v4 2/2] NFSD: add shrinker to reap courtesy clients on low
 memory condition
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        steved@redhat.com
References: <FA83E721-C874-4A47-87BA-54B13E0B12A3@oracle.com>
 <2df6f1fe-c8eb-d5a1-0a11-2fd965555a33@oracle.com>
 <7041D47D-ECB3-497E-9174-96E9E36FFBDE@oracle.com>
 <eb197dde-8758-7ef4-8a7b-989273e09abc@oracle.com>
 <3CD64E7F-8E81-4B37-AAF3-499B47B25D19@oracle.com>
 <fc5a3aa7-af8e-656d-a16e-c07c201ec62a@oracle.com>
 <44A716C4-3904-424D-A5D6-CE46FC9145F0@oracle.com>
 <2b9549f8-58ec-be8a-1b15-3a6d7751a04f@oracle.com>
 <5B4E5FAA-5D46-4E43-962D-64AFDC035C41@oracle.com>
 <1f395e2b-695f-836f-2038-6a672c651d53@oracle.com>
 <20220906130011.GB25323@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220906130011.GB25323@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR06CA0093.namprd06.prod.outlook.com (2603:10b6:3:4::31)
 To BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc9a1799-daa6-4bbe-eeb0-08da903aa03f
X-MS-TrafficTypeDiagnostic: DS0PR10MB6799:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f5bUlVG3Rc0WlWn/SYjT/tJHafKUleLgI5HxCRfv0LljrFo4DWM3Sx/Ff/wVP1352iKMCNUX32OQ/Kx3/I8p13n4QwQjh/5NQ3Lel7JN6JhrTLDSxgczZZjcydGh07WM262m9ESNkwOF2hWyKR1MsPEGY9/bo+JGm30t0Bi85JtIHaQXeTRGDeU8qWGQz4AjhWXhQMnReDDtbwQehDywqMqTMpEmlFoTEWCQepo9Szp8dMLNHn1LcDW/bztjNgMzPjPHJfuKZvAlsgeWep5NyVcQ74EPA4XHd3iMPPBHilj2pXnP01A8Mjw9RYXR4ohk6CbEpjO3kt83ZmVAQcY4ToGyJvW4UdTcCPJ0N/KpR+VuFNxG9sstTHGAb66Do0w137RB/U0M+uO8JInkYSsYVsRn5JEJT2QKrtThQlyBHrV2llSd3BO1kneO94weTOvOKdIzSr+zR4GMkR2K3ZuLBPgTGQGYmNQJx3hPcye1IsRfKIQd2VOP7jUD8vI66RJqA84mk7ElVNPR0S32PupZSikEocZfxKMMkDSWQOAxf5lwrYUXnPPv7O5TKLHaHaTlAd64gFRR8yGC5aDSfm3dvZR0d0Oclfl0ZNwCCpiBUu2aMENKk1Tr/2X+jLpyvH05HtZKlIr1UfIPBZZtBCAWryg4cqAFNPL4mp9PH8PFKk9Nb8EQqcBcdpD0NqHf7co6fOQr5xhvVqiUFew9wMC5o5IkT4aILCGb2mSHE9vO4DaE/zErs9IHlFrjVh/L95neBKQuwpBx1PX82P8G0EBRkgXEC9eRlc/qJCicQbVeoaeN6qHjWqyqr0R8eqQ1dmGj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(136003)(396003)(366004)(376002)(53546011)(31686004)(38100700002)(6916009)(54906003)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(8936002)(5660300002)(2906002)(9686003)(6512007)(186003)(2616005)(41300700001)(6666004)(83380400001)(966005)(478600001)(6506007)(36756003)(26005)(6486002)(31696002)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFplLzdPUVJHYXVYN0s3eTNjeDBGRkxSM3o5ejZFNWFhWjM3TUFrTkY0YU0x?=
 =?utf-8?B?Z05nbzF0Wmp1SkRCZFdtbGJ0QjEyNngySGFzZzdrVTJmVGxFMnlqbmNMdVU3?=
 =?utf-8?B?TDFnTXlGODJEamhCUExqeUQxaHh4allLWXhMUHNIb3h3WGZiMFM4L0hzdjhM?=
 =?utf-8?B?N2wxekU2OHRqd1hGQWhwbHp3QmRxaVdDamlid0dEOUN2YnEwVSthZytVQ2lF?=
 =?utf-8?B?Y1hnZmovNDdVMDU1bVd2bW1CTWtST0I3c1RRanFmTCtWeGc0eFJSYzdNSmQ2?=
 =?utf-8?B?OFpOaXdSREE3ekJWeXd0RjBqekRJblhqbDlyZFR6NFJSOFJnb1JIcEpEeHlL?=
 =?utf-8?B?UnE2L1h5L3c5VDBOTkVZWVpUTTFpclY3cFEyK3ZyUU0xUkpxNjB5Um9tSHJt?=
 =?utf-8?B?WGlZTnRzQXZEbjl0SUdXeHh1bHVmRDlESS9iWURtZmpWWmU4MENFTUtmWkZv?=
 =?utf-8?B?UkFwa1BPQW5ZaUNuTmdWMFNZQkVHU0RrNk02dGhvTTdBTWtOcy9qV0RMR3Y2?=
 =?utf-8?B?djBVa2NEdENoS2RmVkh4QkRLL2VyRUxreGVndXEvdEE4Qld2blJxaDdUc2Zo?=
 =?utf-8?B?TmlMcmhYcThyY21GVEttdjRFMW5vcEtRQlZZdEZkbzFYOXMvN29FR3pRREdi?=
 =?utf-8?B?aC9jVzcyTERrMjgyc0IxVk1IZTBtTXJEV0x3cHBGVmRaYWpnTHZQd3RpVjc0?=
 =?utf-8?B?bGR4ME5JNmpqT2tkc1NyVStXN0dqZXFDajAra1JaTDVmWmJxbU4xYlErb0FW?=
 =?utf-8?B?b0hFQkY4TG1VMXZESUwwZ1hNR2pFb3RobVNvRWpsK1ZJSm9xRE41bWZFN3lK?=
 =?utf-8?B?MEQwRFU1NUFDcThac1BTbU80SlB5K2Z4Qm1TdThSYzh4N1dCSk4zcjNVc1VP?=
 =?utf-8?B?aGw1YTA4T0hyUW9POUpKRFp6OFBUTTBMVkJsb081cmJ0VC8wM0gwYm1tSS9m?=
 =?utf-8?B?QkVWdVd2cVZXRktkSjZqdGVCTDZyOG1wMDdXbTJMMHczK1N1M3V5Sm1LR04x?=
 =?utf-8?B?UFhMbG9kT3dmZThuR3hoNHJnSGFhdFV0Smc5aXJ2NUw5V2g2eFRxN1dabU55?=
 =?utf-8?B?Z0UxS3hJNWduYktmLzltNG1FVHNtZi8yQ1ZtU3J1bVZCU2hkNys5U3orUkpD?=
 =?utf-8?B?T05VaEVvYTVJVU9ES3haVGdZQlVCSVFvZ0x1T1JJbittVFFUYnN4UFlYR3hy?=
 =?utf-8?B?UzRXZnZpTUdhb3B4aDh1ZFlXc3A2SmpydkVsRFkzelZBQjdBUnFjWFA2ekNS?=
 =?utf-8?B?RkVqQzNneUNSNEhvZ1ZRc3dmNTlpU3ppaWFHbnExRUw2dk8ray9mbVV5ckUr?=
 =?utf-8?B?QXowdjBkVWlHa2VPd2RVUkg3T0dVei9sQjJ5UW9KRzJML3pQd0pWK2U4UVlQ?=
 =?utf-8?B?WXlQdFp4SGxYK0JYRzVyKytqdEFHb1pVOHE1azlqbEZVemdnYUdaTW1DRytE?=
 =?utf-8?B?NHpld2ZaQlUyN2xsb0xGaXJoUlU3SDhwODlwRkRNam9MQUp2VjBrZ3NKS2tK?=
 =?utf-8?B?Sk5kd3pwL2VGOXZNaUV0Qm81d1hXWEp3aEVkZEt0alNucGp3NWM0bjAzcCtm?=
 =?utf-8?B?dnI3OGQrZ1liRVJJdWpxYitIUjZnWTJIWEtyVWNBVml3MDcrWEVtMWw1S0Zy?=
 =?utf-8?B?MS80MmxLQkRKVjdrMmp6UzRkbmdJc1d4M2t3WEF5NlBjdEhHRU5xaVRnR3JJ?=
 =?utf-8?B?ZDNmbFhTL0c3eVNhcmN2aTJLeUhEUExPc2drT1djVEV5SlRkWEV5UWlOenpV?=
 =?utf-8?B?UFA0czg3czh1dzMvcHh3bkxtZURKdXRJN2RoMkJvemN1eTFQZ2dTQlFVdmo0?=
 =?utf-8?B?VVh0VlZnQXpsZEw1cWtnSk8rY29sLy9nMnFvb2dMM2F3U2oybThUWUlLZjZE?=
 =?utf-8?B?OVgvUG5tTDA1RmZ5UjR3ZEgxa2xPYXZnRDhydkRzWlBLZmVGMWc4cVpHS3U4?=
 =?utf-8?B?bVlNdmtveVAzbUtDNGFLMnVpUWtDdHFUU3BLSS90YzBNaGZBOEdlQ0ZaV1J3?=
 =?utf-8?B?KzZITjNBTXBoRk1reXpTdXA5UmREUVZHb2FwblZWY1g1OEhvbXVUUUoxTG40?=
 =?utf-8?B?T3cwNWVuMXZjMEpaS2VwVzZFbjZhQ2QydXhXMUs2MzAxRU1wdDNtcEJFb25O?=
 =?utf-8?Q?s4wy05VQkHsb4aFQaKltQKMyF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9a1799-daa6-4bbe-eeb0-08da903aa03f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 19:04:30.1455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPGzAbDRup+cwMx2KDNiSdd5wJBjAnWaKTej+diGzYN2omAuxiJT57+yOHmjgf8/Xi5+fqk1vEhnfG4xHhTw+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060089
X-Proofpoint-ORIG-GUID: 3qYAPy4ezxz9I157u7Mm4ESjPtF_TyYF
X-Proofpoint-GUID: 3qYAPy4ezxz9I157u7Mm4ESjPtF_TyYF
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 9/6/22 6:00 AM, J. Bruce Fields wrote:
> On Sat, Sep 03, 2022 at 10:59:17AM -0700, dai.ngo@oracle.com wrote:
>> On 9/3/22 10:29 AM, Chuck Lever III wrote:
>>> What I was suggesting was a longer term strategy for improving the
>>> laundromat. In order to scale well in the number of clients, it
>>> needs to schedule client expiry and deletion without serializing.
>>>
>>> (ie, the laundromat itself can identify a set of clients to clean,
>>> but then it should pass that list to other workers so it can run
>>> again as soon as it needs to -- and that also means it can use more
>>> than just one CPU at a time to do its work).
>> I see. Currently on my lowly 1-CPU VM it takes about ~35 secs to
>> destroy 128 clients, each with only few states (generated by pynfs's
>> CID5 test). We can improve on this.
> Careful--it's not the CPU that's the issue, it's waiting for disk.
>
> If you're on a hard drive, for example, it's going to take at least one
> seek (probably at least 10ms) to expire a single client, so you're never
> going to destroy more than 100 per second.  That's what you need to
> parallelize.  See item 3 from
>
> 	https://urldefense.com/v3/__https://lore.kernel.org/linux-nfs/20220523154026.GD24163@fieldses.org/__;!!ACWV5N9M2RV99hQ!KK7Xqkksy2WBks12oxpw0FMQW8z7_FpSDgruhtAIrNCW5kmhvAY7noT5d6ybenxkIowyx9cVXBLDysVq$

Right! thank you for reminding me of this. I'll add it to my plate
if no one gets to it yet.

-Dai

>   
>
> Also, looks like current nfs-utils is still doing 3 commits per expiry.
>
> Steve, for some reason I think "nfsdcld: use WAL journal for faster
> commits" never got applied:
>
> 	https://urldefense.com/v3/__https://lore.kernel.org/linux-nfs/20220104222445.GF12040@fieldses.org/__;!!ACWV5N9M2RV99hQ!KK7Xqkksy2WBks12oxpw0FMQW8z7_FpSDgruhtAIrNCW5kmhvAY7noT5d6ybenxkIowyx9cVXP3Ocamj$
>
> --b.
