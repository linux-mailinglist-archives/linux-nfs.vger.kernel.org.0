Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B2264A837
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 20:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiLLTqH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 14:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiLLTqG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 14:46:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EBA11465
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 11:46:02 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCGwihw013146;
        Mon, 12 Dec 2022 19:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+fZaBfTcXgBGUUlLmdM701gaD/g4pN3fd3y0jCHbbus=;
 b=3J3kHDPjPiE9PhMfzgx6bGZPUjPSGEAp5wuOuVcNpVpksRtSQgu7mOKyq8D3af44JPMk
 CFRT+EtrCvrgL2gB5+oWyp7qAXyGGyHB5IeMByl61Y+QaqlA2EjKZfQwUGinWh9jCGue
 Z8zGk0diyUK4zSwjR9oRZQFQ/d1uGIdbH3RNH1Hrqev/MskQQJkg2taOTJ8fiLYf75Sm
 neC2F4iJnfZJjHN/Yof9sbmPXAOoIwlcgcHTD2ZDYbWtWi9Pv1/EVn1rwUclAuoACwXt
 hdgraVRpPQEReivWyqy4nNWZFUBmxVZZ3BoKS0cNK14ouJaDVZ02lDWnHQ03Fa6/yBxt OA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mch1a3s8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 19:45:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BCIph2x017710;
        Mon, 12 Dec 2022 19:45:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgjathkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 19:45:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2c19Op47Q/1F/0xF+3UiSoD4bPUqwpZb4mZjNyGL4YKAm5/nJDG4ZVzB9r36NVigjfc/8BKEWlEpZA1UFajSmZh7hMcm/kokprFcBCGXCRSTiL6JUwFNXd+pUfK2PkjEvm22sB2LnbPmX2pCFOxS1YZf/qIv1VFJtTrdUVieb+GRNhBvsOyqButjnC3h/d66Qt68QtBEukeUdrCYawv6Tw1O0atbVtpz1gcDY2t7Qx3kiZC0SeVgtY8RkAL1ekKrKWyK7ODcd1NbBMKZGgPSFwZOtUCA89R8FYsza2/FD/1JbB6gZ1wGI0HvIkgzhgO7QpeONqCUWnRzBPYFDsCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fZaBfTcXgBGUUlLmdM701gaD/g4pN3fd3y0jCHbbus=;
 b=Jjby92ENfYwK8iOqdMHqIR4A4R0zpZS0VumFLBVVoffrdw5ilJt6yCqTpq1jD27MHJ4WKR+x1Zjb+yR4tCTAKD0qwxbJcMzsPpjhQ3bz224YCUJjW7ofICeiJUIaKShuWZ8suL8iw7+we8eViv7zcKucEEKpp8LvVyA8LNRlzJ322z5EE29vGSaEadIofDfTk/rVOGr8i1M40dlImkMQ5qmPwEHMozSEb1DZRwANSowuM3FFTdb+k27ykrKMq3jeHLlJ6eDnmYiJKU5VeS+vGzfh2VFW7HKO4Z8/9nYP/foUEVeK6c81k7vMuh2J5n8Hf0LSh0JE722dvCYt+LxSzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fZaBfTcXgBGUUlLmdM701gaD/g4pN3fd3y0jCHbbus=;
 b=qPAUfxBbDXBC+Mu5FgPv9hHxznIUjDwmC/y87+adNpk7fDY3qgPz9mamvF1auSuvgrZjMRuqmNHieNbRPnfzLr1Mf+5UpAUKFD54ksEA+UcONuPo2CpuOpDmY5LxfO+MgKcScd/C5trgm/RUvyFaxIGDZHzqZpyObmdKFZwLG24=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB5567.namprd10.prod.outlook.com (2603:10b6:a03:3dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 19:45:54 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::193d:c337:4b9:3c77]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::193d:c337:4b9:3c77%9]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 19:45:54 +0000
Message-ID: <0f3f3858-5fae-1305-3e33-ca0a2f939119@oracle.com>
Date:   Mon, 12 Dec 2022 11:45:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        "hdthky0@gmail.com" <hdthky0@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>
References: <1670786549-27041-1-git-send-email-dai.ngo@oracle.com>
 <7f68cb23445820b4a1c12b74dce0954f537ae5e2.camel@kernel.org>
 <56b0cb4f-dfe9-6892-7fef-1a2965cf1d99@oracle.com>
 <0ab8efccae708faa092a56c6935c33564814bfed.camel@kernel.org>
 <Y5czwRabTFiwah2b@kroah.com>
 <a47cc610af621e95ba359388e93d988f1ef5b17f.camel@kernel.org>
 <Y5dha1Hcgolctt0K@kroah.com>
 <7365935036c192bfc64cda41cb9ccb297e3eb86f.camel@kernel.org>
 <6D5F96AA-A8A7-4E19-A566-959F19A3CB0A@oracle.com>
 <6200943464679d51de50a05ab2ca1cc0c91d8685.camel@kernel.org>
 <a895cb89-f8f3-a2e1-1958-cf9379ecdcd5@oracle.com>
 <4CAE538E-9F0B-4B44-956E-C6498A37A83A@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <4CAE538E-9F0B-4B44-956E-C6498A37A83A@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:806:120::21) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SJ0PR10MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: a755b31a-09ba-4c66-3193-08dadc797a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2WWTLO4C+QCpxAKezaH7Hvr6K24YZubWRx5Hc61TuTVEu0pNWoJVBIZNfxSa0K0hImYjN8BwGNY0fvkq61lKHU80icvg0pUmb6vdKaMH2CWQt/mvuNKPZvy6A+MR2BamRb+7h7RTY5FouRJL+syqpOCoMUE86oozAhS2y7qEQNyyX2LNKo+xr1FisUDpjCuU1ua2MBA6CRBk20n96Md24bPVDFORCrhwDPyS9GlaammDKzLe1+axibeBsGtHDK+DViAqIAusfB5nGJp/oDecYlkU8gJeHqHjoT0bn/NMGKOo9jo3UKuVU9zOaokdu/MPrOnqyrahE2FuQmmDi/MxStEHi4YXQ2Fdvu+MzRKmpSDrVPGlDSgvP5SUqhOWz7CAAuAPqv+5TkerGoOux4G8qRagFJUm//TyTZ3OIx5lPof1c6WjqHulsBkNHPiEGv+K1qDGbcBz1+9wG4m4P9NtiBNrNTYBx1//aDgrDJjir9Fs6egVgHCRgrRrQDFfq2bnOr/EQFAa+ZmBBSwAQSloLXYjnk1K503/gsxAOtpV8aG5jUUcbaZZ5BmhNfLmEP2nwg1ZlBLMg1s6MKRVSaPBRjwm4sAazqrdpvUEQuhI8jN9kwksAgyVWp/1dF2tZK5NBhcEeXtvNVcWmDsuTtddAUQcC7lgCNsA0kRta7Ia7iW5JkpCPO0clRP4DqcOQr5gXqB4dDwGoCE69HZ/kemLeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199015)(4326008)(31686004)(41300700001)(5660300002)(66899015)(30864003)(8936002)(31696002)(6862004)(4001150100001)(316002)(54906003)(86362001)(66556008)(66476007)(66946007)(8676002)(37006003)(6486002)(83380400001)(478600001)(38100700002)(2906002)(6512007)(6666004)(9686003)(6506007)(53546011)(26005)(186003)(36756003)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXphTWVwZ1RwZEp4a3JWZVhEOTBXMk44MTJaV3BCb2VGOGNSeEVqTHJIdUFP?=
 =?utf-8?B?OVMzVDJDZVJIdjBOYUVJRFRqQXZYN1Z2Ynk0Y1JrOTlGSkZwOWZ4SjU2MUlq?=
 =?utf-8?B?ZFZpaUVjSTlBcHNHWmNyRFJoTzI3Rkh1KzRvMUgxMDh5VGx0eWo4VEdFZ1Vv?=
 =?utf-8?B?THVEUm1UOHpuUit4d1RmQ3NzSVhKQ3QwWEowRmZrZlRkVWZpYklxb2hYZUVB?=
 =?utf-8?B?bkRwUmI1UmdWbFp3RTRVZktDaGdSbHNmVWtoWlFtc2tJVlhYMWplU2kvSWZX?=
 =?utf-8?B?ZUp5SUF5SmY0cW15Y2tMcXdWd2dxcXJJRVQ2YU0vblpzVjNjZmpSUS9hMDJZ?=
 =?utf-8?B?Z0xRaTBWQ2RoTDRDZTlaMFo4VTYyYnBPWTAvMU5mbUl0bG5jbVk0VGl3Y0Mr?=
 =?utf-8?B?TStVSVpmNVV1N3BBWlRITlAzWjNyaytkRUYyUytXakxnVXpxc2VWUmF3WW9j?=
 =?utf-8?B?RDd6THZ6ZkhQUFpFeXVjUHZ1U0NQSHRHVzhDL2NYRTREYTRjTzFpVGxtTFVI?=
 =?utf-8?B?Qkh1ZkJBT1NPcUo3WmIzWEQ0VS9RRHVBYUx1bXBpUmFRMXg5bExEQW1HLzEy?=
 =?utf-8?B?TkEyZkFza3RaR09qOUlWRVVsdVZwdDdSTXRicnAxZmREaFVtUWpWcUN4YW9Q?=
 =?utf-8?B?QkpEaDkrK0wySlQyeXJzSTVtclZvM3FRTk5rdjg0RlhhM1hkNWN5UlNReVEv?=
 =?utf-8?B?aHBoQ1IvYVFBejlHNGFaSnhvZUVIV3pydU5uOUZQbkJoRWJVVHFnY0VhVFNi?=
 =?utf-8?B?RmErZkE4eHhlTnZwSFBtUUpUQ1dJWDFXajNiVlR3aWFEWVJmZ1huN2ZsT0NZ?=
 =?utf-8?B?TmJPN0swQ29zMkx5dXJ4dDgzeXZqKzd5M2hBQXRRekM5R2FmU2ZlSFBrbzll?=
 =?utf-8?B?c2JzMFRlUmtRbUg5R3J3V0ZGcG9DUmlETjkwK1FYbVdYVG5xelNwNHlyQXFZ?=
 =?utf-8?B?ZjJsWTU1MGt5cmFtNmI5dmNsNmZ4aDh5bnVmMnpqSDFJdEdYS3hkVzZMbk42?=
 =?utf-8?B?WCtRcjNLZXJlL0IwajNrOTRNM202NjZ0SDc0c2pRK1NHQnhQWmEwV09EbVFL?=
 =?utf-8?B?VTh2YVgwMUQzamFMR2hhemJUYlNweW5rbC9NaTNFVFM3WE8ydWJ4aXRYNE94?=
 =?utf-8?B?MmJjUHN1Ri95c1Vua1dESGlEOHRweDlIeVl6WHNMRkJFZENZTWVyc0hiUmdk?=
 =?utf-8?B?Q1phV0VVK0NVdnd3dDA4aDhiY2pjVXJrcHZKVEdXdmdBaDg4SDlYRkk1UmE2?=
 =?utf-8?B?dFdlcnc0UWllV3pnUXBSc2JlRmswYUxVZFBXcXE2eHpZa0J3VkVINWxneHJQ?=
 =?utf-8?B?WldJUEhJS2YrTnZ0azNDRjhJWjlvb1ZFUjZLOHUzRmgvSHdVWTRvS0QxaU1V?=
 =?utf-8?B?dGs1RktJcFdXMjMvL05ZZWZUcm1PMXpvNFNSTEZmYU0yamNnYjZucTJNM1M3?=
 =?utf-8?B?amRVWDQzblhPamQ1RWswNmtTN29pbnBrcmtmd21GU1crZmtRUzgyWVZFTnpq?=
 =?utf-8?B?ejlPZUF0Nmc3VVJTU0tnR3ltRXNzWWl6MVF5aHZFeGpuallFdkNDaDEzYWFk?=
 =?utf-8?B?K3R6ak43MzNJRWJ3ZHNYM2pwbDFodFJPanVNcWFHdjBabmRmUHlFS2lSVzFm?=
 =?utf-8?B?Y3BBM25jNDlZd1hiQzg1WVM0R2hzUWtFc2ovRzZrVU5tZlljd3puSEhKL3lT?=
 =?utf-8?B?dmpTbTYvdkpwT0I2Z1ZzRDVKOFNJemJ5NDFiOHVJUmZmbmtZWG1uaUFMOWlN?=
 =?utf-8?B?dExpaGdTR2daSTZFZzBTK0EzelllUkhCTWVtUzVGM0hJRmNLNy92SDlsaDRC?=
 =?utf-8?B?MXZqSTJFMmtpRW90WXlpejBBZ2UzUk16VEh3aDU3VW9wQk5LOUZXTFFKNkNj?=
 =?utf-8?B?U09HTXluVzBHenhVNlFGeUhnQzdOSjFUNTVibElTRlRwdStTYjF3SzkydzNV?=
 =?utf-8?B?QXNTRlNURWFNR3hnSTJDMnlIY0E2bUY5a3AveTlhZGRVY0EzOFNXVmN6UVlt?=
 =?utf-8?B?TDlMaThYZmtkbjBhN3NiRnl6d0xhMldoeUlTWjAxWVJFNnp6QS8vRXZRMlNG?=
 =?utf-8?B?ZUcwcUhYenJ1YW9rbWR5S0M0dklLT2ZvS3dKSms1YXZxREE5WmtEMHZJZWtB?=
 =?utf-8?Q?xDK/kWbu8HfG1/3HOrkX1E1xv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a755b31a-09ba-4c66-3193-08dadc797a83
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 19:45:54.5148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CzkLlo2MfSfoJoyRCkyk5ln+fjNraN43StbC6j/Lrz+UZLlztYw5aG0+DF6ZP5dFiwwp1ZeCDuVmroq0JSE4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120177
X-Proofpoint-GUID: 6GwwoNKncL8Q-wTPfvP2fZETwn5tDslG
X-Proofpoint-ORIG-GUID: 6GwwoNKncL8Q-wTPfvP2fZETwn5tDslG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 12/12/22 11:28 AM, Chuck Lever III wrote:
>
>> On Dec 12, 2022, at 2:16 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>>
>> On 12/12/22 10:38 AM, Jeff Layton wrote:
>>> On Mon, 2022-12-12 at 18:16 +0000, Chuck Lever III wrote:
>>>>> On Dec 12, 2022, at 12:44 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>
>>>>> On Mon, 2022-12-12 at 18:14 +0100, Greg KH wrote:
>>>>>> On Mon, Dec 12, 2022 at 09:31:19AM -0500, Jeff Layton wrote:
>>>>>>> On Mon, 2022-12-12 at 14:59 +0100, Greg KH wrote:
>>>>>>>> On Mon, Dec 12, 2022 at 08:40:31AM -0500, Jeff Layton wrote:
>>>>>>>>> On Mon, 2022-12-12 at 05:34 -0800, dai.ngo@oracle.com wrote:
>>>>>>>>>> On 12/12/22 4:22 AM, Jeff Layton wrote:
>>>>>>>>>>> On Sun, 2022-12-11 at 11:22 -0800, Dai Ngo wrote:
>>>>>>>>>>>> Problem caused by source's vfsmount being unmounted but remains
>>>>>>>>>>>> on the delayed unmount list. This happens when nfs42_ssc_open()
>>>>>>>>>>>> return errors.
>>>>>>>>>>>> Fixed by removing nfsd4_interssc_connect(), leave the vfsmount
>>>>>>>>>>>> for the laundromat to unmount when idle time expires.
>>>>>>>>>>>>
>>>>>>>>>>>> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
>>>>>>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>>   fs/nfsd/nfs4proc.c | 23 +++++++----------------
>>>>>>>>>>>>   1 file changed, 7 insertions(+), 16 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>>>>>>>> index 8beb2bc4c328..756e42cf0d01 100644
>>>>>>>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>>>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>>>>>>>> @@ -1463,13 +1463,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>>>>>>>>>>   	return status;
>>>>>>>>>>>>   }
>>>>>>>>>>>>
>>>>>>>>>>>> -static void
>>>>>>>>>>>> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>>>>>>>>>>>> -{
>>>>>>>>>>>> -	nfs_do_sb_deactive(ss_mnt->mnt_sb);
>>>>>>>>>>>> -	mntput(ss_mnt);
>>>>>>>>>>>> -}
>>>>>>>>>>>> -
>>>>>>>>>>>>   /*
>>>>>>>>>>>>    * Verify COPY destination stateid.
>>>>>>>>>>>>    *
>>>>>>>>>>>> @@ -1572,11 +1565,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
>>>>>>>>>>>>   {
>>>>>>>>>>>>   }
>>>>>>>>>>>>
>>>>>>>>>>>> -static void
>>>>>>>>>>>> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>>>>>>>>>>>> -{
>>>>>>>>>>>> -}
>>>>>>>>>>>> -
>>>>>>>>>>>>   static struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>>>>>>>>>>>>   				   struct nfs_fh *src_fh,
>>>>>>>>>>>>   				   nfs4_stateid *stateid)
>>>>>>>>>>>> @@ -1762,7 +1750,8 @@ static int nfsd4_do_async_copy(void *data)
>>>>>>>>>>>>   		struct file *filp;
>>>>>>>>>>>>
>>>>>>>>>>>>   		filp = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
>>>>>>>>>>>> -				      &copy->stateid);
>>>>>>>>>>>> +					&copy->stateid);
>>>>>>>>>>>> +
>>>>>>>>>>>>   		if (IS_ERR(filp)) {
>>>>>>>>>>>>   			switch (PTR_ERR(filp)) {
>>>>>>>>>>>>   			case -EBADF:
>>>>>>>>>>>> @@ -1771,7 +1760,7 @@ static int nfsd4_do_async_copy(void *data)
>>>>>>>>>>>>   			default:
>>>>>>>>>>>>   				nfserr = nfserr_offload_denied;
>>>>>>>>>>>>   			}
>>>>>>>>>>>> -			nfsd4_interssc_disconnect(copy->ss_mnt);
>>>>>>>>>>>> +			/* ss_mnt will be unmounted by the laundromat */
>>>>>>>>>>>>   			goto do_callback;
>>>>>>>>>>>>   		}
>>>>>>>>>>>>   		nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
>>>>>>>>>>>> @@ -1852,8 +1841,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>>>>>>>>>   	if (async_copy)
>>>>>>>>>>>>   		cleanup_async_copy(async_copy);
>>>>>>>>>>>>   	status = nfserrno(-ENOMEM);
>>>>>>>>>>>> -	if (nfsd4_ssc_is_inter(copy))
>>>>>>>>>>>> -		nfsd4_interssc_disconnect(copy->ss_mnt);
>>>>>>>>>>>> +	/*
>>>>>>>>>>>> +	 * source's vfsmount of inter-copy will be unmounted
>>>>>>>>>>>> +	 * by the laundromat
>>>>>>>>>>>> +	 */
>>>>>>>>>>>>   	goto out;
>>>>>>>>>>>>   }
>>>>>>>>>>>>
>>>>>>>>>>> This looks reasonable at first glance, but I have some concerns with the
>>>>>>>>>>> refcounting around ss_mnt elsewhere in this code. nfsd4_ssc_setup_dul
>>>>>>>>>>> looks for an existing connection and bumps the ni->nsui_refcnt if it
>>>>>>>>>>> finds one.
>>>>>>>>>>>
>>>>>>>>>>> But then later, nfsd4_cleanup_inter_ssc has a couple of cases where it
>>>>>>>>>>> just does a bare mntput:
>>>>>>>>>>>
>>>>>>>>>>>          if (!nn) {
>>>>>>>>>>>                  mntput(ss_mnt);
>>>>>>>>>>>                  return;
>>>>>>>>>>>          }
>>>>>>>>>>> ...
>>>>>>>>>>>          if (!found) {
>>>>>>>>>>>                  mntput(ss_mnt);
>>>>>>>>>>>                  return;
>>>>>>>>>>>          }
>>>>>>>>>>>
>>>>>>>>>>> The first one looks bogus. Can net_generic return NULL? If so how, and
>>>>>>>>>>> why is it not a problem elsewhere in the kernel?
>>>>>>>>>> it looks like net_generic can not fail, no where else check for NULL
>>>>>>>>>> so I will remove this check.
>>>>>>>>>>
>>>>>>>>>>> For the second case, if the ni is no longer on the list, where did the
>>>>>>>>>>> extra ss_mnt reference come from? Maybe that should be a WARN_ON or
>>>>>>>>>>> BUG_ON?
>>>>>>>>>> if ni is not found on the list then it's a bug somewhere so I will add
>>>>>>>>>> a BUG_ON on this.
>>>>>>>>>>
>>>>>>>>> Probably better to just WARN_ON and let any references leak in that
>>>>>>>>> case. A BUG_ON implies a panic in some environments, and it's best to
>>>>>>>>> avoid that unless there really is no choice.
>>>>>>>> WARN_ON also causes machines to boot that have panic_on_warn enabled.
>>>>>>>> Why not just handle the error and keep going?  Why panic at all?
>>>>>>>>
>>>>>>> Who the hell sets panic_on_warn (outside of testing environments)?
>>>>>> All cloud providers and anyone else that wants to "kill the system that
>>>>>> had a problem and have it reboot fast" in order to keep things working
>>>>>> overall.
>>>>>>
>>>>> If that's the case, then this situation would probably be one where a
>>>>> cloud provider would want to crash it and come back. NFS grace periods
>>>>> can suck though.
>>>>>
>>>>>>> I'm
>>>>>>> suggesting a WARN_ON because not finding an entry at this point
>>>>>>> represents a bug that we'd want reported.
>>>>>> Your call, but we are generally discouraging adding new WARN_ON() for
>>>>>> anything that userspace could ever trigger.  And if userspace can't
>>>>>> trigger it, then it's a normal type of error that you need to handle
>>>>>> anyway, right?
>>>>>>
>>>>>> Anyway, your call, just letting you know.
>>>>>>
>>>>> Understood.
>>>>>
>>>>>>> The caller should hold a reference to the object that holds a vfsmount
>>>>>>> reference. It relies on that vfsmount to do a copy. If it's gone at this
>>>>>>> point where we're releasing that reference, then we're looking at a
>>>>>>> refcounting bug of some sort.
>>>>>> refcounting in the nfsd code, or outside of that?
>>>>>>
>>>>> It'd be in the nfsd code, but might affect the vfsmount refcount. Inter-
>>>>> server copy is quite the tenuous house of cards. ;)
>>>>>
>>>>>>> I would expect anyone who sets panic_on_warn to _desire_ a panic in this
>>>>>>> situation. After all, they asked for it. Presumably they want it to do
>>>>>>> some coredump analysis or something?
>>>>>>>
>>>>>>> It is debatable whether the stack trace at this point would be helpful
>>>>>>> though, so you might consider a pr_warn or something less log-spammy.
>>>>>> If you can recover from it, then yeah, pr_warn() is usually best.
>>>>>>
>>>>> It does look like Dai went with pr_warn on his v2 patch.
>>>>>
>>>>> We'd "recover" by leaking a vfsmount reference. The immediate crash
>>>>> would be avoided, but it might make for interesting "fun" later when you
>>>>> went to try and unmount the thing.
>>>> This is a red flag for me. If the leak prevents the system from
>>>> shutting down reliably, then we need to do something more than
>>>> a pr_warn(), I would think.
>>>>
>>> Sorry, I should correct myself.
>>>
>>> We wouldn't (necessarily) leak a vfsmount reference. If the entry was no
>>> longer on the list, then presumably it has already been cleaned up and
>>> the vfsmount reference put.
>> I think the issue here is not vfsmount reference count. The issue is that
>> we could not find a nfsd4_ssc_umount_item on the list that matches the
>> vfsmount ss_mnt. So the question is what should we do in this case?
>>
>> Prior to this patch, when we hit this scenario we just go ahead and
>> unmount the ss_mnt there since it won't be unmounted by the laundromat
>> (it's not on the delayed unmount list).
>>
>> With this patch, we don't even unmount the ss_mnt, we just do a pr_warn.
>>
>> I'd prefer to go back to the previous code to do the unmount and also
>> do a pr_warn.
>>
>>> It's still a bug though since we _should_ still have a reference to the
>>> nfsd4_ssc_umount_item at this point. So this is really just a potential
>>> use-after-free.
>> The ss_mnt still might have a reference on the nfsd4_ssc_umount_item
>> but we just can't find it on the list. Even though the possibility for
>> this to happen is from slim to none, we still have to check for it.
>>
>>> FWIW, the object handling here is somewhat weird as the copy operation
>>> holds a reference to the nfsd4_ssc_umount_item but passes around a
>>> pointer to the vfsmount
>>>
>>> I have to wonder if it'd be cleaner to have nfsd4_setup_inter_ssc pass
>>> back a pointer to the nfsd4_ssc_umount_item, so you could pass that to
>>> nfsd4_cleanup_inter_ssc and skip searching for it again at cleanup time.
>> Yes, I think returning a pointer to the nfsd4_ssc_umount_item approach
>> would be better.  We won't have to deal with the situation where we can't
>> find an item on the list (even though it almost never happen).
>>
>> Can we do this enhancement after fixing this use-after-free problem, in
>> a separate patch series?
> Is there a reason not fix it correctly now?
>
> I'd rather not merge a fix that leaves the possibility of a leak.

I think we should do it separately because the reported problem of
use-after-free is not related to the problem of not finding the ni
item on the list.

AFAIK, the problem of not finding ni item on the list was never
reported or happened during my testing.

The fix for the use-after-free deals with the handling of errors
returned from nfs42_ssc_open and other places in the code. This
fix remains the same no matter how the vfsmount is passed around.

-Dai

