Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A01876D968
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 23:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjHBVW4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 17:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjHBVWy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 17:22:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D2DAC;
        Wed,  2 Aug 2023 14:22:52 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372HJ1tN020876;
        Wed, 2 Aug 2023 21:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=3vwIXTxAzv/XsLSbikm2wycyi4TZOZ9LVs9wu9w5IdY=;
 b=dstj4Bv0C5T4Yrj3rqEYz5NkpJUiKkTAI7UZ6+h+jYQC1jONL5SBvwxYVg5b3H6xJgnT
 bgCyiAd6Rwo2piuKuboFJy5OC63rO0OfK3ns9X/1TDm6hEVkpw0O2gfWFDsSgd9V4lg+
 Drm9oTLdYowL6K9TGFPS13CjiWSrd4FsRwkOQf8LXOvCr1R2LWPYdINB15NVhCkWb63x
 wgXzAHk2/6E1RaEuacynP6JvDHxRNf4265UdOnxSr2qlSTbrBkeqGDSP3N+JOXEK/0kq
 93ehaOXhdID3eTWor70WZKQFeNB1urhiLOzq1NwIxIjkqljrD94Mfhs19dwpupqd0OjI MA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttd8cfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 21:22:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372KT8TA025263;
        Wed, 2 Aug 2023 21:22:42 GMT
Received: from outbound.mail.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7f1ear-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 21:22:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdK9WlZPxZGfJTIGJk6+udc5p1zF21ZqhAPq6fj9h+BqrinwuTu/2SijhdzMtsZe0DY2KxYTfbyy0Pa+f9t3Bj06etZVZKRicJuQpKL6pXJoeB3nIgkQ81ExsNMjiifBeUKACjxBWGrAftC6sdls4SswjR6afKYhIg364QTNoWlDfXAnGu3bjLjJVUtUxREWZ/M3FPVkH9d4Sau3d4kYr9gAePbizPEyHbfoFe5BRNgxRlaa6jOvbqx229sn/PTqbeVJGc6tVY2UgNhWDSjfuZLJfsjlpM2bGGZjA1oQVrcI7Wd7Nnc1/McAwucpgQc/5jX1ptPBDTpAhYYk2poSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vwIXTxAzv/XsLSbikm2wycyi4TZOZ9LVs9wu9w5IdY=;
 b=Mf+8k4bk3lGTMVCbbIKxqX4NGknI1u+QmJ8IrqDMTmSHyZLy4/HcV7QBrx1pv9UWOYYuoeQZLKPQr3fkQu+hE0EHA9/crWB7F5G+3BR/rbaFPWPGlEzqZBF7BkQTKtN7tcAwUFDnYsOv4ymo03L1EnPyG8GHaou0yZ0yLSZlCWeX1SqmS2a6A9dxlemCag1UO4nfTDiHWL9BqS5QIordk49yeQvCY2H4dng9a+i0IKRFE68dPGXYml4V3nC6im+cJpR21jo50j/rOVipQUrYpPpKa92LcvwH92qvA3+5Y+jXTnEi2LnzGQK+qNZGnJCNDR24nE2yp74NtrlCkiOSSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vwIXTxAzv/XsLSbikm2wycyi4TZOZ9LVs9wu9w5IdY=;
 b=PjBkOAxNr3LjepGg/130/GRzvjcrj3o2KnsirQyaPH/M82i/ybdio97XbCZqBS5DA2rTFQnFvYNyd/5K0PQtnb/mLPy01HYTYvIbmEc9LbkCKeUsM0BtyyiUWXu+ZYVAE1rycS+rPKgGdLUDbMCPdAY4bB9sSKQNk0Km3bDFeJg=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by DS7PR10MB5925.namprd10.prod.outlook.com (2603:10b6:8:87::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 21:22:39 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 21:22:39 +0000
Message-ID: <6801380f-75cb-49b2-4e89-49821193fe32@oracle.com>
Date:   Wed, 2 Aug 2023 14:22:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] nfsd: don't hand out write delegations on O_WRONLY
 opens
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230801-wdeleg-v2-1-20c14252bab4@kernel.org>
 <8c3adfce-39f0-0e60-e35a-2f1be6fb67e6@oracle.com>
 <c9370f6fde62205356f4c864891a3c35ef811877.camel@kernel.org>
 <0a256174-44ea-d653-7643-b39f5081d8a5@oracle.com>
 <d70f4dd0fc77566f15f5178424bcf901ed21fbad.camel@kernel.org>
 <26761CA2-923C-43FC-BDC6-14012115EAA0@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <26761CA2-923C-43FC-BDC6-14012115EAA0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:806:a7::32) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4270:EE_|DS7PR10MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd60246-2b46-4218-c65d-08db939e9975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: whjQg2ifZlnK/C9Jju0UwzdxorntNOMtEcRmFgEJio5MLHN93kabev1c3GvkIuoK0jPDtJklSEmCzxlx07EMxZckWrV+sg3xFcBYaYGdEgaBLt4i7WkIjooQ3mGdK4sOX3v6phkFnhzm5JzM8YBWdF071DE7JK5klkEFwJ3+KUL+i9UCDucgkSb9fC5O6a4apBrPmQatW0eNBj7QQSzwTKIJ5hrDgTvWm8J01MMOOslyK51Kcq02zI6H+mGf2QhGjI8MH3Z/Zco79aHJ/eDQUnjjiOhB8L2rTv/mZNz8eMJe+cuzJi2sZN4USsISSWyMvdZvxZXKTFlWKQfuPvPdeJoEhEycdyVCt50xwchAG5UT1X59NrtoAbO4x10EHJ7YkDCrgRWV1zHiy397qXY6P2wCuryjw8l34L1OjUg6XUGu7zvJuycut6O9gci9M9V4i17EymgLs8FftArmMf961um6dGq2dVoiIHv7O4p9vFBooGoW6ATT/YgjGOOdWpb6bARMyCKg2byXWnJieV5fh7nlJffWIpJZzfLjMir7eR0zOPiuarQdCtReBeJCLxPScwySX+fYrRgamp2pV+OFl/gnR/NXmt5MumpD8MPSLWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199021)(2616005)(53546011)(6506007)(83380400001)(26005)(186003)(316002)(2906002)(66946007)(4326008)(66476007)(66556008)(5660300002)(41300700001)(8676002)(8936002)(6666004)(6486002)(966005)(6512007)(9686003)(478600001)(110136005)(54906003)(38100700002)(36756003)(31696002)(86362001)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXkxeUJQWnJkYUVaRW50Y0ZIYUNqQS9kcklMUUErL2hiQmc3WXdqZ0pHdmVl?=
 =?utf-8?B?dlM4dUlxb1c2eDV5MTV2eDA3b0pvRTA2eTEwOTF0T3J1OHBFNzF0VTJVcC9i?=
 =?utf-8?B?OWVvcEZ5NlR1ZW5NRU9TelJpeCttOHZ6Z3QrYlNaTGZtWElDRVBjcjJIV1BQ?=
 =?utf-8?B?MzN3S0VtM0VpMkkwTk9HR3lQVUVNNEQ4dTE1KzExWGd0Yko3bWc2MUpUaUdC?=
 =?utf-8?B?WktLY3Bqdnp2NGR3blMrWUdib1ozbmt3VDVEOGlpKzlTdGFnNFpicysrNTlZ?=
 =?utf-8?B?bXdqamhKVURLSFJPRmkwVkZPZGI4dHRMRHp1RUtnZVdGZWVLcloyVTFISmNG?=
 =?utf-8?B?OXNqU3licDFJdiszOXE3ZkdISlhRUWhCbkZyVVpuUFBRZ3Q4aXJkVzZ0a1VO?=
 =?utf-8?B?TUdJK0NTRkY3cDJzMGlSTzF3d2FqeDJhZFRaZU5TN283Mk5FRlRRWEVhMjEw?=
 =?utf-8?B?cjdNWGZETnNISllmU0V4VmZtc3pMZUNYbC9EVW5UbWliWmNDSXd6WlM2N1pD?=
 =?utf-8?B?Kyt3T2Y5bG1kbERZaENWTFY0QjF3bU1Tc0hPRis5VHRLd2RGbGFwclZ5WkRX?=
 =?utf-8?B?cTJIdUlwWFdOYWJKMHVVd1hLZWhQSEUrR0J4U211REVNc0pBYnBOZWVMTk92?=
 =?utf-8?B?bXNoRXlXTExuZmJ1cGR2ZWNNb1RUeDErNEpVSXZ0YWlVL2J5WDBieS8vZ1p0?=
 =?utf-8?B?WGljSFJwZ0FWdy9ydFZnejk3MVNLekpyOVpDTm5wY2pkT2x1N0NmTy84Q256?=
 =?utf-8?B?WEk0QTY1V1V0K25QYUJXZTJTNmhUby9VTjZXVmYwdXF2MEkwRThNRFprVnVr?=
 =?utf-8?B?eFdqZFJvZDF4bW9WR1k5TXJCcmlNR05vbHZBNWlvOXplS1Z1bUQ0RUJRYkFW?=
 =?utf-8?B?R1lKcWlQelZXSzFiVlhZUmxFejJmb2w0T2dvWXBhSVJteG1ZNnRsMTVXV2tR?=
 =?utf-8?B?RFg5ZmlaV1R0bWdVdkYyMFc3TmM2SlNFWGVXK3FGSWd5eHdEUHVJaUFQdkhk?=
 =?utf-8?B?QjB5cW53eHJPNm84S3p3OWtGRTJyWjZOTUZXaDNPMnVaT1l5dHVvRExPb1hW?=
 =?utf-8?B?alI1akcwTnZBU3orYlZhaC9YRFoyRWtEMXZzZmxsOGQvV0NCNEtZaGVoeHEr?=
 =?utf-8?B?THBiRkNoVEhUUHR6azAzZVFYeGx3VEtVaDhyekdqUXBTdDBPdzRxN0ttcTdN?=
 =?utf-8?B?RmozSGxWWmY3NmxZVTFaWkxlSzMvYWljV1A2di9kd05mTVl5TlR4WVVkWTZr?=
 =?utf-8?B?OFJUTGx3ZFpvbU93YytrWlVjQXAyeXBSWTdOQXFmdjhuSlN5Y3ZCL2N5bE05?=
 =?utf-8?B?NkpsVEh5RmZxUG16WXFyVVNDdDRZMVg3Y0MxV0dzK1YyMmpSeWNlZ3dUeVl0?=
 =?utf-8?B?NFJpNmdicFNXYWZ0d2I5N0hZcndHd0FUR05NOEYxMHY1QzhkTThyM09OZk0r?=
 =?utf-8?B?YXNSdDJlcGxJTUgxY3JrUEFFcW9VVEJPWmhMWkF5VXNZYUJYVGFqNEtkRW1z?=
 =?utf-8?B?cmw4STNFd25CVm8vOXRKNTZKRXFUVHJjNVlNVmw4NDRONWMycFZqTklZOTB4?=
 =?utf-8?B?amFtdzJmcGt4NjRPT1lKYzlncUVnYmhwZWtKWjlwT0xpYTB6Y29UWTdwZm14?=
 =?utf-8?B?S3lHVUYxOHRBNnVqY3pNSjRNckVKdW9aWTdIaXpxRkV5QmhML1lVeW5Wak9R?=
 =?utf-8?B?dmtXRDRocHRuSGhhTVZ0UDNFb240OVp4SkcweThTamkzd09vWnpNa2RqbDM2?=
 =?utf-8?B?c3JDa0ZvbjQ1cDFKOVhOQnlnWE4yRUZtM2wxbXlNUXBjMnM2dmt4SXZ2UEhs?=
 =?utf-8?B?RUQ5ek5GTFdEUWQrUGlLUkhaeDZtWG85ajMyQnlUSlNMWkpmYlZIK25oZCtr?=
 =?utf-8?B?VHdUQWkzV01PZzdxcVhTcXpHQnJPcGxLa3gweFAxNzVScmFXMjBoK09EK0xY?=
 =?utf-8?B?S3F4WTAzbzdlaFhOck1JTjVZWHhKTEh6OTJSWWloSE9xVGJadFQwbTAwNS8w?=
 =?utf-8?B?QWVnbTRISXRwbmY1dUlVQ2xrNjd3MUM1LzVGelZLZEpTZ2t0SityeXRRc1U3?=
 =?utf-8?B?QU5LOHM4SnlkbTEzZ1h1UDdTUEEyNDBSUFQ5RWZLQWVMaHFGRURhNHBXbFVP?=
 =?utf-8?Q?MnIO91kP2JBB7cjvKXeMBmR4n?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VJhh3tkvK+IrXXInDXTtx2QOS8UIwCnjhgJIDr9sbH0JHFD3taastpOLsljgHaVKzFrKjd+KC+9nuD7LXAyySZWwd8HAapJFKGl0fXTlsewjlrGfwlBk5k2YsS7Xki0IgwBF/lRXLcTV2wJquEMw7rXSS7Dy7F5Extt3NHoOAJEi3VRFadRKHL635JE1oUfxbE7Ob3oh9lP+R/qb0SBcSc11mHmCUGIkQjDxkZycT6bAwueII+KTyPpypCcIMuWL+u9JZm4uMBn/4g/4rZt7kXfqCudxixW9zoivWOv07gsSaBKnMxOO4LgwCATZn6/YShQQsVp33UKEMgyNnE2XIbW2cI2Y7g7dUssK1b2pGtb70PxFNIEFSfbsVWoIGaUVE9SkrUYgQHjFKInDFslAWfv3/nmVGMwtyrWvDpKuIKrfMEn4oc8KAUxSpKc2c7wRwFl61iPH+HSAIC9h6SD1OBrc3E4P9AeN/tFnRjwF6KbbhYPqMq7O7uvHhL/V/t4SVitmJRh/NEAs3qSjwm7r2gP1X5+3HX3m22NcufTR2jAmacGR24EHkAPttCREFqdZbjddRUKPWlTjo1jSUdSVZ+Io3DMv1WjqyRZP1Lcfn1g6bu69sWBYAtvjeC9wGH9gjPbVTRLOPwXrkFakkraAevOcfhXhDmzRdd4gmkh+TwFImopOijIdyIZ+lEIayyBN7uG9kRF7MMQRd7lwSe4THt/F6b65AJ49mzIssh3+oH374X8bwumqN9AwwiXmnoLeiSq+kidt/n0DLrs1T1eODpSULV/GbMzhlgh0MPpEtrt+6MAN3h8xD7bZ0ISuDNeKYQlxOguKqVmXC3C9tk0pN/fNAy28mmoZkb7+FWlCTyMKimiZeY06SqR5w2d2KyXy
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd60246-2b46-4218-c65d-08db939e9975
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 21:22:39.3775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPINS/j4H/hHrdoebF+LuzZsvbhe6eUxdQpoONL7SF4rYDFzDkmN00t6gEG/58qlAQiShPW68qe8ZwAbUPhXwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5925
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020188
X-Proofpoint-GUID: -Ia4uroO86NAPaZrM72QVygedR5MsMK9
X-Proofpoint-ORIG-GUID: -Ia4uroO86NAPaZrM72QVygedR5MsMK9
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/2/23 1:57 PM, Chuck Lever III wrote:
>
>> On Aug 2, 2023, at 4:48 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>
>> On Wed, 2023-08-02 at 13:15 -0700, dai.ngo@oracle.com wrote:
>>> On 8/2/23 11:15 AM, Jeff Layton wrote:
>>>> On Wed, 2023-08-02 at 09:29 -0700, dai.ngo@oracle.com wrote:
>>>>> On 8/1/23 6:33 AM, Jeff Layton wrote:
>>>>>> I noticed that xfstests generic/001 was failing against linux-next nfsd.
>>>>>>
>>>>>> The client would request a OPEN4_SHARE_ACCESS_WRITE open, and the server
>>>>>> would hand out a write delegation. The client would then try to use that
>>>>>> write delegation as the source stateid in a COPY
>>>>> not sure why the client opens the source file of a COPY operation with
>>>>> OPEN4_SHARE_ACCESS_WRITE?
>>>>>
>>>> It doesn't. The original open is to write the data for the file being
>>>> copied. It then opens the file again for READ, but since it has a write
>>>> delegation, it doesn't need to talk to the server at all -- it can just
>>>> use that stateid for later operations.
>>>>
>>>>>>    or CLONE operation, and
>>>>>> the server would respond with NFS4ERR_STALE.
>>>>> If the server does not allow client to use write delegation for the
>>>>> READ, should the correct error return be NFS4ERR_OPENMODE?
>>>>>
>>>> The server must allow the client to use a write delegation for read
>>>> operations. It's required by the spec, AFAIU.
>>>>
>>>> The error in this case was just bogus. The vfs copy routine would return
>>>> -EBADF since the file didn't have FMODE_READ, and the nfs server would
>>>> translate that into NFS4ERR_STALE.
>>>>
>>>> Probably there is a better v4 error code that we could translate EBADF
>>>> to, but with this patch it shouldn't be a problem any longer.
>>>>
>>>>>> The problem is that the struct file associated with the delegation does
>>>>>> not necessarily have read permissions. It's handing out a write
>>>>>> delegation on what is effectively an O_WRONLY open. RFC 8881 states:
>>>>>>
>>>>>>    "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
>>>>>>     own, all opens."
>>>>>>
>>>>>> Given that the client didn't request any read permissions, and that nfsd
>>>>>> didn't check for any, it seems wrong to give out a write delegation.
>>>>>>
>>>>>> Only hand out a write delegation if we have a O_RDWR descriptor
>>>>>> available. If it fails to find an appropriate write descriptor, go
>>>>>> ahead and try for a read delegation if NFS4_SHARE_ACCESS_READ was
>>>>>> requested.
>>>>>>
>>>>>> This fixes xfstest generic/001.
>>>>>>
>>>>>> Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=412
>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>> ---
>>>>>> Changes in v2:
>>>>>> - Rework the logic when finding struct file for the delegation. The
>>>>>>     earlier patch might still have attached a O_WRONLY file to the deleg
>>>>>>     in some cases, and could still have handed out a write delegation on
>>>>>>     an O_WRONLY OPEN request in some cases.
>>>>>> ---
>>>>>>    fs/nfsd/nfs4state.c | 29 ++++++++++++++++++-----------
>>>>>>    1 file changed, 18 insertions(+), 11 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>> index ef7118ebee00..e79d82fd05e7 100644
>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>> @@ -5449,7 +5449,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>>>>     struct nfs4_file *fp = stp->st_stid.sc_file;
>>>>>>     struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
>>>>>>     struct nfs4_delegation *dp;
>>>>>> - struct nfsd_file *nf;
>>>>>> + struct nfsd_file *nf = NULL;
>>>>>>     struct file_lock *fl;
>>>>>>     u32 dl_type;
>>>>>>
>>>>>> @@ -5461,21 +5461,28 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>>>>     if (fp->fi_had_conflict)
>>>>>>     return ERR_PTR(-EAGAIN);
>>>>>>
>>>>>> - if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>>>>> - nf = find_writeable_file(fp);
>>>>>> + /*
>>>>>> + * Try for a write delegation first. We need an O_RDWR file
>>>>>> + * since a write delegation allows the client to perform any open
>>>>>> + * from its cache.
>>>>>> + */
>>>>>> + if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
>>>>>> + nf = nfsd_file_get(fp->fi_fds[O_RDWR]);
>>>>>>     dl_type = NFS4_OPEN_DELEGATE_WRITE;
>>>>>> - } else {
>>>>> Does this mean OPEN4_SHARE_ACCESS_WRITE do not get a write delegation?
>>>>> It does not seem right.
>>>>>
>>>>> -Dai
>>>>>
>>>> Why? Per RFC 8881:
>>>>
>>>> "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
>>>> own, all opens."
>>>>
>>>> All opens. That includes read opens.
>>>>
>>>> An OPEN4_SHARE_ACCESS_WRITE open will succeed on a file to which the
>>>> user has no read permissions. Therefore, we can't grant a write
>>>> delegation since can't guarantee that the user is allowed to do that.
>>> If the server grants the write delegation on an OPEN with
>>> OPEN4_SHARE_ACCESS_WRITE on the file with WR-only access mode then
>>> why can't the server checks and denies the subsequent READ?
>>>
>>> Per RFC 8881, section 9.1.2:
>>>
>>>      For delegation stateids, the access mode is based on the type of
>>>      delegation.
>>>
>>>      When a READ, WRITE, or SETATTR (that specifies the size attribute)
>>>      operation is done, the operation is subject to checking against the
>>>      access mode to verify that the operation is appropriate given the
>>>      stateid with which the operation is associated.
>>>
>>>      In the case of WRITE-type operations (i.e., WRITEs and SETATTRs that
>>>      set size), the server MUST verify that the access mode allows writing
>>>      and MUST return an NFS4ERR_OPENMODE error if it does not. In the case
>>>      of READ, the server may perform the corresponding check on the access
>>>      mode, or it may choose to allow READ on OPENs for OPEN4_SHARE_ACCESS_WRITE,
>>>      to accommodate clients whose WRITE implementation may unavoidably do
>>>      reads (e.g., due to buffer cache constraints). However, even if READs
>>>      are allowed in these circumstances, the server MUST still check for
>>>      locks that conflict with the READ (e.g., another OPEN specified
>>>      OPEN4_SHARE_DENY_READ or OPEN4_SHARE_DENY_BOTH). Note that a server
>>>      that does enforce the access mode check on READs need not explicitly
>>>      check for conflicting share reservations since the existence of OPEN
>>>      for OPEN4_SHARE_ACCESS_READ guarantees that no conflicting share
>>>      reservation can exist.
>>>
>>> FWIW, The Solaris server grants write delegation on OPEN with
>>> OPEN4_SHARE_ACCESS_WRITE on file with access mode either RW or
>>> WR-only. Maybe this is a bug? or the spec is not clear?
>>>
>> I don't think that's necessarily a bug.
>>
>> It's not that the spec demands that we only hand out delegations on BOTH
>> opens.  This is more of a quirk of the Linux implementation. Linux'
>> write delegations require an open O_RDWR file descriptor because we may
>> be called upon to do a read on its behalf.
>>
>> Technically, we could probably just have it check for
>> OPEN4_SHARE_ACCESS_WRITE, but in the case where READ isn't also set,
>> then you're unlikely to get a delegation. Either the O_RDWR descriptor
>> will be NULL, or there are other, conflicting opens already present.
>>
>> Solaris may have a completely different design that doesn't require
>> this. I haven't looked at its code to know.
> I'm comfortable for now with not handing out write delegations for
> SHARE_ACCESS_WRITE opens. I prefer that to permission checking on
> every READ operation.

I'm fine with just handling out write delegation for SHARE_ACCESS_BOTH
only.

Just a concern about not checking for access at the time of READ operation.
If the file was opened with SHARE_ACCESS_WRITE (no write delegation granted)
and the file access mode was changed to read-only, is it a correct behavior
for the server to allow the READ to go through?

-Dai

>
> If we find that it's a significant performance issue, we can revisit.
>
>
>>> It'd would be interesting to know how ONTAP server behaves in
>>> this scenario.
>>>
>> Indeed. Most likely it behaves more like Solaris does, but it'd nice to
>> know.
>>
>>>>
>>>>>> + }
>>>>>> +
>>>>>> + /*
>>>>>> + * If the file is being opened O_RDONLY or we couldn't get a O_RDWR
>>>>>> + * file for some reason, then try for a read deleg instead.
>>>>>> + */
>>>>>> + if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
>>>>>>     nf = find_readable_file(fp);
>>>>>>     dl_type = NFS4_OPEN_DELEGATE_READ;
>>>>>>     }
>>>>>> - if (!nf) {
>>>>>> - /*
>>>>>> - * We probably could attempt another open and get a read
>>>>>> - * delegation, but for now, don't bother until the
>>>>>> - * client actually sends us one.
>>>>>> - */
>>>>>> +
>>>>>> + if (!nf)
>>>>>>     return ERR_PTR(-EAGAIN);
>>>>>> - }
>>>>>> +
>>>>>>     spin_lock(&state_lock);
>>>>>>     spin_lock(&fp->fi_lock);
>>>>>>     if (nfs4_delegation_exists(clp, fp))
>>>>>>
>>>>>> ---
>>>>>> base-commit: a734662572708cf062e974f659ae50c24fc1ad17
>>>>>> change-id: 20230731-wdeleg-bbdb6b25a3c6
>>>>>>
>>>>>> Best regards,
>> -- 
>> Jeff Layton <jlayton@kernel.org>
> --
> Chuck Lever
>
>
