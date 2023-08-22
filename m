Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B1378468E
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Aug 2023 18:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjHVQIN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Aug 2023 12:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjHVQIM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Aug 2023 12:08:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BB7CDA
        for <linux-nfs@vger.kernel.org>; Tue, 22 Aug 2023 09:08:09 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MFnbVe030424;
        Tue, 22 Aug 2023 16:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jn2qIgPwHNDJf3d3cMPtSwKNqUtwJ1Ag0N8s83F9gMc=;
 b=TNCqq1TMEYgAGzhT9842yfm5Aq1XcjaGbSH75ZiuFEo64YFE4GHOeqxO3eHWbwVxS6xm
 GBz+2j+l2C0FtYG9rmJRv2hgkM0ejHkzp5I85wpEsnI27HHqHDwqHmRR48c7UXYC+3cU
 EVz5bnJXC1VsmObanZOxmTRoiIJHouS1GkOmSsXAL88tUGnVGsD1uY5ya12HhzFbbR+7
 zVcB9hzFX2mUD93JY645y2jHs79LxIMDdE0mpdwQ1raFGuqs28LCVIod2wH6DmjHnIlk
 gjvwHqseo/TEmLblcjtH6C/RL3/3HU3WdCcRsB8ynLndXJ/zfCOmyylv2UZlwjtmGCyf Rg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjm5dwska-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Aug 2023 16:08:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37MF2QWL031740;
        Tue, 22 Aug 2023 16:07:59 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm65b3g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Aug 2023 16:07:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKpoZho666qxDL19ZsxZpXrmauDcZGG3wwM5aYPojs9lSy40WN/Qoz4jQXF5tjL22bWPj/9O5x/cBZia3FMOYFC85I6CldNozYGXa8S2Z7tUpE2rcYDV1yov8ba6bVACH26tCtINvbMg11A+awRCJLMuDtB2DQ9L8swEjlbU6/IQ4gHkhxQSBwxccbEhddje3klX0w19OY3Leh4c9aHjCyqNqz3uEUpDOHt1eiENdaMAy0Erv3dvKd63Yag6rRXBHbxylVWhzNngQxi1PaVa/d978xOlfvTvpTtPgvCsRv3NgX0R2hkdTpPLzluwaeOGPJklOokjQbFPFLZFK7tAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jn2qIgPwHNDJf3d3cMPtSwKNqUtwJ1Ag0N8s83F9gMc=;
 b=AA8MMprSUkGSRiTK4MYndR4+ig4RmiErSc1/3s9E1ah0SIm3RWSe8YyaVZcxcq2TrHAgRLyDgWePhfmvdhF2n6prCGjMVcQlrxLo9ThC1WRC1W25Gh1MlXkRgULwNaMSUxZrGlNjQ3Zremhi8AphsgCEVZ/nQw/DD9kKU4CrZ/w6t7Dlnp7BmmTda24JAOjqDZm1Xq3RGjDAUaxHjnFcQPJe1dlOZCk67MkUF3i8Lg0yv9Fuzf14fFoTGeSihZCQKMsVXcq3owIkkSODbDGmztZsZ3ED45G6Z9pmSMb9FJM8f8w147T2WfsBV84M2mEsIxB1pUWgIRj9tuOtDDpFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jn2qIgPwHNDJf3d3cMPtSwKNqUtwJ1Ag0N8s83F9gMc=;
 b=WStKqn2BHcE7rMWkVsspg7rjy5r9nWDwQL/46r91XBTce0hVoZNiwBR2JroTAq8FOCK4Nk9AZI71JyrYvOOu72eNrd0OTNdiqBcAKkKOY/fyw5iIPbEbTZdUdF7ak8rG9YVPIpi+BoaDtvEq4ayVCiCAHzOchjq02wD/98EnIho=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CY5PR10MB5937.namprd10.prod.outlook.com (2603:10b6:930:2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 16:07:56 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::40f2:46bd:814d:297e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::40f2:46bd:814d:297e%6]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 16:07:56 +0000
Message-ID: <9d1ffe71-83b2-a9c7-861f-0d3f8d715e70@oracle.com>
Date:   Tue, 22 Aug 2023 09:07:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: xfstests results over NFS
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        Tom Talpey <tom@talpey.com>
References: <9ee56f62652c3d338aff809f70e7941dfc284bf9.camel@kernel.org>
 <7C595ADA-E841-44F7-918A-3A46A55D546B@oracle.com>
 <2fc1f9bf5fdc25acbcabaf4266584f0857bc4b19.camel@kernel.org>
 <CAFX2Jf=gq-U464_SrebSwCMOU+g0Vcx9Us7SPn8JQEoA6s27DQ@mail.gmail.com>
 <77977950a7d6a4539114fdd0d6db982143c4f9b1.camel@kernel.org>
 <0AEF7E06-E2F6-426D-B3DF-3D0ED8233082@oracle.com>
 <6af7807c75e3d6110bc80661a600038f5cfb0022.camel@kernel.org>
 <7b2746692aef1725cb000faabf4db2d115279423.camel@kernel.org>
 <25bc018a-00a7-1634-9535-9d01328264d3@oracle.com>
 <b535fccd-acd2-8fca-71ac-6aa17ee84708@oracle.com>
 <cd592a05c13226c5e1fb4f390eb2473ba20024ad.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <cd592a05c13226c5e1fb4f390eb2473ba20024ad.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0160.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::6) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CY5PR10MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: c0832452-f6fd-4bf0-9b61-08dba329f277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qHL9mhYJviIk4X1RUIr0l4MMa/dHeZw3bnKoilWOvEPv2KIM1opnhnMt96p07Fx5CkMAVpGt34IIRUxzYcs+cFz4vJ63omKA0doMP6i7rJJ8rn1VnmwoYsjqM2wx5MhW0WRPH5y0OuuO17KDqOGQ/iAVWrDFtYre+k6+16aLS0B3/6vig7y6loHnPz2vY6uF7pLHBmOaMLjJFlh56XqBz+K6HnBBxN1Fta6pd9MFfFVL7hiGcWAEoWOP28aHMGHO4lqEoOvssn+0BCQm0ED0hftMtw1sTx6gWJbDeWE+YIQMHCA0LYEBTO3RQCdb/VmNJ8G92LHBzHnNeSky1oFET+JIR4mgJj1YvhMZuq9OpTrRkZ0XvpaTvTUWdCjniTPUWI8jkc1OXNj8aKzgDvQinz8b2sXGY+KggZ53FdvUtDcKiursK0UnorZ9KMQM/zz1AEzDwndIdJJctmq9tzacvSdI9hp4ibnTkzkbB4JLbM7bMeMTir0nQpTNPbLk5PlncWZQJ1qYKMhtFAmW4GkG2BRqlyBKvlHeXBsQAhhdwfmMu3/e4xyl8EJv1hzouVVK8ti4SlmTAM5kAwKHrG3MEyVIqTDCdjsESBI3ifLjouY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(1800799009)(186009)(451199024)(54906003)(66476007)(66556008)(6512007)(316002)(66946007)(9686003)(110136005)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(6486002)(53546011)(6506007)(83380400001)(3480700007)(30864003)(2906002)(31686004)(31696002)(86362001)(5660300002)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1FkL2JOeG9KakFqWWpWaGt3S3RseXVXQkNXYnd3T2ZpeVdTMGloU2FYTDhz?=
 =?utf-8?B?S1VUMFFkYStJTzFNZlRqa0xVSTIrMjdzVExtM2dKSkt1bWRXNE91aUtxbnZj?=
 =?utf-8?B?MzkxV3hJYS80bnlPdXZMVmswS2xvMStFRmZFWi93c0YxbWkveGtpOFZpams2?=
 =?utf-8?B?cVlZZkg5M2lxY01oTW1NdWZrT3YzY3VJTG9hTVFJTm5lNjNhYityQVNONWJG?=
 =?utf-8?B?MmlibmFTMGYzK2xPOWRyUlJ1YWx0L2NUdDB1ckFlVUM2ZTV5citBRVg0d202?=
 =?utf-8?B?Q0xZT25pSWtvRUZPRXdiNC9KdUVXeWVtMThpMjkrcVppaVAyL1NIWjdnVU1L?=
 =?utf-8?B?VEduZUhFbU04bFdMeEZOUHd1RE00OEVWb1drV2VOOVlMTm5XS3JlQ2Mvd1Nx?=
 =?utf-8?B?NUtXMzFwVkwzQ3JVNnYyQi8xeGhiT3dXL1V1TWlWSmZMaVV3QlZYK0NURWZl?=
 =?utf-8?B?RGh6azNJR1pVMWhVaE5NSzE5VmQ4bkRVa3YxcTZHYXNWNDdmRmhkUnFIeVlh?=
 =?utf-8?B?VmdVcXd6TDlYRXhiallOVVZHbGthR0t3WjNTaWJxMkh1MnE5SkMzbnVyRGJE?=
 =?utf-8?B?RFZPQVI4MkZDWGxSemhyZDdCU2Z6aEJlNlpIdkhEZkluR3FtRnZSdVNieDhW?=
 =?utf-8?B?Wmk4YnJJRmRwUUwxYVhpQXZySEhKY3NyUFJLVnVSSi9xU1h3SURqVTFZNElk?=
 =?utf-8?B?SXIzdlh4V05DdmxPc1lqdHJ4SVVNdVhFam9Ia09kdnQvWXBOUStiYm5EM2JK?=
 =?utf-8?B?ZTVpMmF2aVhFRUE4R3NOcnBCUnRwVDlNdnMxVkkva25rVkpSdG1uajgra2FE?=
 =?utf-8?B?QTg2TVltci94RWd4bXV3RkllS1p0NloyNkkxeVA5bXdTQmRqK0tkNGRXby9p?=
 =?utf-8?B?WU9tUFdXT2Q3Rm82ZnlzRDdqbmxTYklrS3NQdVNnWkprcWpaeFBLTjlpYWtG?=
 =?utf-8?B?dE5MNFJ4cXZ4bFZjTDdYNW9VYTFScXR1S290ODlxTTJsSEJLVjNMeXpNL2Fx?=
 =?utf-8?B?djliZm82cVRnY2NLY0xoS1AvT3BSS1VtZUdPeE9QUVRmUFoxeTRld2hsNmVa?=
 =?utf-8?B?eFFFSE5mYm04NGd2MGxjTVhXTXBEYkFkUklIbDBXWjluRVNrSzRJZ2VITXNG?=
 =?utf-8?B?RG84ekw1K2liUDRDd2lxZDBYSWxDL00vYWtQbnlCM1UyL05KL2FPR0lTMXFQ?=
 =?utf-8?B?VUJvVEQyOFdveFdwMEQ3WVF6bkJpZk5wSlhLd09EWHE1TWNvUHFjcW9oRnE4?=
 =?utf-8?B?UXpOMUdIckh6ZkhsV3RycmFHWTBXMDFyMktuUDZDTHQreXpEeTVvRG8zRXA0?=
 =?utf-8?B?YVU0Njh6NWJPSlNmZWY0UW05elR4TmkwcXZ6c0pvVUJLaTZNeE9CVnBrUmkv?=
 =?utf-8?B?QmY4SjN4ZnhCR3dKQzVkZDk2MUNLQ281bmZDODZSaGNycVYwdXVFRzU0WElM?=
 =?utf-8?B?bWIzSzBGK2oxenFBcXYwZG81bHJKanFPeU52bnoxRFBEL1pYSnF3cURvSFdO?=
 =?utf-8?B?ak84ZlZqQjkzUm5VallEalNGZGNZZ01ZblhXdkJCWjFPS2tUUEx6bXlUY1dy?=
 =?utf-8?B?Qk9RWTMybHFvNmpySGk2WHNJZy9Nb3FqZnNQTFBqalFxNnJtZjhEM2Jjc3c2?=
 =?utf-8?B?YUVYY2hQSlpBYm12aTViWGdlOWFGNkMyL0tDWmF1ZGtsTmwxSDFhSU5FT0Ji?=
 =?utf-8?B?c3lNODJwK1k3R1Q1eVlsVUlxQnFsRnhPM0VYY0NmZk5QTU1PNVZzaGQ4T3ZG?=
 =?utf-8?B?cUNvNFdxNEd2SzVRdFNHbHduWUhob1NRMGtFRjltbFRuM2pvZTY3bnFtNmR1?=
 =?utf-8?B?SFBrQXIrOVFCRXhXQWVOeW5lY3NCc3pHRDVpMGtTaUFCLzBvOGNyR3FCWWhY?=
 =?utf-8?B?WXNuVVJGNTg1ekpGN0NQSlhnbm9MTTViVUx4MnAzUEE5WWdpZ3JKQkpYOVNi?=
 =?utf-8?B?RXVlTUJKcGxhVXBvTC9YOXExVmx2ZDYrVmFadFhQZ0t6NENQSGo1ZklMOGwx?=
 =?utf-8?B?R2dvalFxSEFzV25SWjkvRHhtRm5qYkV1M05wSHppQ292KzNHb1VWRks3WnRs?=
 =?utf-8?B?RnpzVmlrMDFQWlNPZ3JPeFAxUXU5VkhRSHBwbXVrb0gwQWVQMGdMYk9nYXdY?=
 =?utf-8?Q?WtUzPJMl7fonBScww2uFqYW45?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mOWym3XRnnbINydvjq2AScKHBWY50ZUNSONm1drk2pXWvklUzukTBenDW2MjhrTUaMF0oiV+i6A8UL1KVDAgQBIdFGrd7sDGmsp8P3sN/keAtmXthfPQ67D48vFm0KtyxduUhMB7p6iff+DAzH6ZenEN+5l7MkUXUCQYORF+8qtwm98aywWG2sWd+KmJv2gKnv2OOrwVll2hybzm0kgPn+x7DEEdoyee+05GGrzrQr0gBr3Y6uD21FE32+kZVktxEKil7CAhm0C1tU0mqubI8pBA1DA4K+Y9nE8AIG5p+3YFEv4jp5QJfi2Jmq8mPK1svvqG1K5DJsgqGnBNtRZpEpKQvTe0I2ZIaaBlLoXqWl2pIRvxo6AIY2xkDKmOroPm8peVwS1LMY6KALEutZACY/HQRXgXseEpgDYf5faToRGFJyA3NyhesrEe3KBZr27BJjJyAOHE1a7tKvaJF89SefKWPx8s3FtwGoWGEnrmy06760GW40pseSTrhf0H1CEf/iSt0FUTP7sY2UAorwILs11Hp6F1+CyHzIE/pHMB35N0D0d8Dd/0o5UREYs2EviD11JGWw3ubj/SiZle16b7Ob5mM+3Tpk7se/sFO5Buk+CIYlQh/6o3P+MxDWxHI81DPdBtj9Lx5ZhEDH7Lg6s4iGenQWWfq38w6A0nWS92aVuSqbb0nlt1APXSnR+fhZSZIdtLDx5EVLx1avOMlqT3h6l3Sd7GyxJhlrxrepQ1Z1EsPQkwoSGQ+a9Y4lYjy64G+UoB38g8Y/oWFuVlJPcJFeelakT6d0IkHG2o3so7Gc+HdkMvFSaHaJ/Tx96aIoTHlMMH5+5dHm6SPbmQykG8sx5e2OPSVeXxONUEyC54kfLMK9zXe/V3ATW6zB2wp4TcSwz7p3NEvTlqf/uo7tDVYA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0832452-f6fd-4bf0-9b61-08dba329f277
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 16:07:56.1279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2sumVbAtpp8TLBP39hiAKbwRM+qmj141EK0cwR1zLhAWCmW706qlDnuG+PI1jWc/K3DixIIg1JwFhd10YgB0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220125
X-Proofpoint-ORIG-GUID: Q2f-ogyJrsl7fPk6gB9Zkq16FXIvFSQ3
X-Proofpoint-GUID: Q2f-ogyJrsl7fPk6gB9Zkq16FXIvFSQ3
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/17/23 4:08 PM, Jeff Layton wrote:
> On Thu, 2023-08-17 at 15:59 -0700, dai.ngo@oracle.com wrote:
>> On 8/17/23 3:23 PM, dai.ngo@oracle.com wrote:
>>> On 8/17/23 2:07 PM, Jeff Layton wrote:
>>>> On Thu, 2023-08-17 at 13:15 -0400, Jeff Layton wrote:
>>>>> On Thu, 2023-08-17 at 16:31 +0000, Chuck Lever III wrote:
>>>>>>> On Aug 17, 2023, at 12:27 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>>>
>>>>>>> On Thu, 2023-08-17 at 11:17 -0400, Anna Schumaker wrote:
>>>>>>>> On Thu, Aug 17, 2023 at 10:22 AM Jeff Layton <jlayton@kernel.org>
>>>>>>>> wrote:
>>>>>>>>> On Thu, 2023-08-17 at 14:04 +0000, Chuck Lever III wrote:
>>>>>>>>>>> On Aug 17, 2023, at 7:21 AM, Jeff Layton <jlayton@kernel.org>
>>>>>>>>>>> wrote:
>>>>>>>>>>>
>>>>>>>>>>> I finally got my kdevops
>>>>>>>>>>> (https://github.com/linux-kdevops/kdevops) test
>>>>>>>>>>> rig working well enough to get some publishable results. To
>>>>>>>>>>> run fstests,
>>>>>>>>>>> kdevops will spin up a server and (in this case) 2 clients to run
>>>>>>>>>>> xfstests' auto group. One client mounts with default options,
>>>>>>>>>>> and the
>>>>>>>>>>> other uses NFSv3.
>>>>>>>>>>>
>>>>>>>>>>> I tested 3 kernels:
>>>>>>>>>>>
>>>>>>>>>>> v6.4.0 (stock release)
>>>>>>>>>>> 6.5.0-rc6-g4853c74bd7ab (Linus' tree as of a couple of days ago)
>>>>>>>>>>> 6.5.0-rc6-next-20230816-gef66bf8aeb91 (linux-next as of
>>>>>>>>>>> yesterday morning)
>>>>>>>>>>>
>>>>>>>>>>> Here are the results summary of all 3:
>>>>>>>>>>>
>>>>>>>>>>> KERNEL:    6.4.0
>>>>>>>>>>> CPUS:      8
>>>>>>>>>>>
>>>>>>>>>>> nfs_v3: 727 tests, 12 failures, 569 skipped, 14863 seconds
>>>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/124
>>>>>>>>>>>     generic/193 generic/258 generic/294 generic/318 generic/319
>>>>>>>>>>>     generic/444 generic/528 generic/529
>>>>>>>>>>> nfs_default: 727 tests, 18 failures, 452 skipped, 21899 seconds
>>>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/186
>>>>>>>>>>>     generic/187 generic/193 generic/294 generic/318 generic/319
>>>>>>>>>>>     generic/357 generic/444 generic/486 generic/513 generic/528
>>>>>>>>>>>     generic/529 generic/578 generic/675 generic/688
>>>>>>>>>>> Totals: 1454 tests, 1021 skipped, 30 failures, 0 errors, 35096s
>>>>>>>>>>>
>>>>>>>>>>> KERNEL:    6.5.0-rc6-g4853c74bd7ab
>>>>>>>>>>> CPUS:      8
>>>>>>>>>>>
>>>>>>>>>>> nfs_v3: 727 tests, 9 failures, 570 skipped, 14775 seconds
>>>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/258
>>>>>>>>>>>     generic/294 generic/318 generic/319 generic/444 generic/529
>>>>>>>>>>> nfs_default: 727 tests, 16 failures, 453 skipped, 22326 seconds
>>>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/186
>>>>>>>>>>>     generic/187 generic/294 generic/318 generic/319 generic/357
>>>>>>>>>>>     generic/444 generic/486 generic/513 generic/529 generic/578
>>>>>>>>>>>     generic/675 generic/688
>>>>>>>>>>> Totals: 1454 tests, 1023 skipped, 25 failures, 0 errors, 35396s
>>>>>>>>>>>
>>>>>>>>>>> KERNEL:    6.5.0-rc6-next-20230816-gef66bf8aeb91
>>>>>>>>>>> CPUS:      8
>>>>>>>>>>>
>>>>>>>>>>> nfs_v3: 727 tests, 9 failures, 570 skipped, 14657 seconds
>>>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/258
>>>>>>>>>>>     generic/294 generic/318 generic/319 generic/444 generic/529
>>>>>>>>>>> nfs_default: 727 tests, 18 failures, 453 skipped, 21757 seconds
>>>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/186
>>>>>>>>>>>     generic/187 generic/294 generic/318 generic/319 generic/357
>>>>>>>>>>>     generic/444 generic/486 generic/513 generic/529 generic/578
>>>>>>>>>>>     generic/675 generic/683 generic/684 generic/688
>>>>>>>>>>> Totals: 1454 tests, 1023 skipped, 27 failures, 0 errors, 34870s
>>>>>>>> As long as we're sharing results ... here is what I'm seeing with a
>>>>>>>> 6.5-rc6 client & server:
>>>>>>>>
>>>>>>>> anna@gouda ~ % xfstestsdb xunit list --results --runid 1741
>>>>>>>> --color=none
>>>>>>>> +------+----------------------+---------+----------+------+------+------+-------+
>>>>>>>>
>>>>>>>>> run | device               | xunit   | hostname | pass | fail |
>>>>>>>> skip |  time |
>>>>>>>> +------+----------------------+---------+----------+------+------+------+-------+
>>>>>>>>
>>>>>>>>> 1741 | server:/srv/xfs/test | tcp-3   | client   |  125 |    4 |
>>>>>>>> 464 | 447 s |
>>>>>>>>> 1741 | server:/srv/xfs/test | tcp-4.0 | client   |  117 |   11 |
>>>>>>>> 465 | 478 s |
>>>>>>>>> 1741 | server:/srv/xfs/test | tcp-4.1 | client   |  119 |   12 |
>>>>>>>> 462 | 404 s |
>>>>>>>>> 1741 | server:/srv/xfs/test | tcp-4.2 | client   |  212 |   18 |
>>>>>>>> 363 | 564 s |
>>>>>>>> +------+----------------------+---------+----------+------+------+------+-------+
>>>>>>>>
>>>>>>>>
>>>>>>>> anna@gouda ~ % xfstestsdb show --failure 1741 --color=none
>>>>>>>> +-------------+---------+---------+---------+---------+
>>>>>>>>>     testcase | tcp-3   | tcp-4.0 | tcp-4.1 | tcp-4.2 |
>>>>>>>> +-------------+---------+---------+---------+---------+
>>>>>>>>> generic/053 | passed  | failure | failure | failure |
>>>>>>>>> generic/099 | passed  | failure | failure | failure |
>>>>>>>>> generic/105 | passed  | failure | failure | failure |
>>>>>>>>> generic/140 | skipped | skipped | skipped | failure |
>>>>>>>>> generic/188 | skipped | skipped | skipped | failure |
>>>>>>>>> generic/258 | failure | passed  | passed  | failure |
>>>>>>>>> generic/294 | failure | failure | failure | failure |
>>>>>>>>> generic/318 | passed  | failure | failure | failure |
>>>>>>>>> generic/319 | passed  | failure | failure | failure |
>>>>>>>>> generic/357 | skipped | skipped | skipped | failure |
>>>>>>>>> generic/444 | failure | failure | failure | failure |
>>>>>>>>> generic/465 | passed  | failure | failure | failure |
>>>>>>>>> generic/513 | skipped | skipped | skipped | failure |
>>>>>>>>> generic/529 | passed  | failure | failure | failure |
>>>>>>>>> generic/604 | passed  | passed  | failure | passed  |
>>>>>>>>> generic/675 | skipped | skipped | skipped | failure |
>>>>>>>>> generic/688 | skipped | skipped | skipped | failure |
>>>>>>>>> generic/697 | passed  | failure | failure | failure |
>>>>>>>>>      nfs/002 | failure | failure | failure | failure |
>>>>>>>> +-------------+---------+---------+---------+---------+
>>>>>>>>
>>>>>>>>
>>>>>>>>>>> With NFSv4.2, v6.4.0 has 2 extra failures that the current
>>>>>>>>>>> mainline
>>>>>>>>>>> kernel doesn't:
>>>>>>>>>>>
>>>>>>>>>>>     generic/193 (some sort of setattr problem)
>>>>>>>>>>>     generic/528 (known problem with btime handling in client
>>>>>>>>>>> that has been fixed)
>>>>>>>>>>>
>>>>>>>>>>> While I haven't investigated, I'm assuming the 193 bug is also
>>>>>>>>>>> something
>>>>>>>>>>> that has been fixed in recent kernels. There are also 3 other
>>>>>>>>>>> NFSv3
>>>>>>>>>>> tests that started passing since v6.4.0. I haven't looked into
>>>>>>>>>>> those.
>>>>>>>>>>>
>>>>>>>>>>> With the linux-next kernel there are 2 new regressions:
>>>>>>>>>>>
>>>>>>>>>>>     generic/683
>>>>>>>>>>>     generic/684
>>>>>>>>>>>
>>>>>>>>>>> Both of these look like problems with setuid/setgid stripping,
>>>>>>>>>>> and still
>>>>>>>>>>> need to be investigated. I have more verbose result info on
>>>>>>>>>>> the test
>>>>>>>>>>> failures if anyone is interested.
>>>>>>>> Interesting that I'm not seeing the 683 & 684 failures. What type of
>>>>>>>> filesystem is your server exporting?
>>>>>>>>
>>>>>>> btrfs
>>>>>>>
>>>>>>> You are testing linux-next? I need to go back and confirm these
>>>>>>> results
>>>>>>> too.
>>>>>> IMO linux-next is quite important : we keep hitting bugs that
>>>>>> appear only after integration -- block and network changes in
>>>>>> other trees especially can impact the NFS drivers.
>>>>>>
>>>>> Indeed, I suspect this is probably something from the vfs tree (though
>>>>> we definitely need to confirm that). Today I'm testing:
>>>>>
>>>>>       6.5.0-rc6-next-20230817-g47762f086974
>>>>>
>>>> Nope, I was wrong. I ran a bisect and it landed here. I confirmed it by
>>>> turning off leases on the nfs server and the test started passing. I
>>>> probably won't have the cycles to chase this down further.
>>>>
>>>> The capture looks something like this:
>>>>
>>>> OPEN (get a write delegation
>>>> WRITE
>>>> CLOSE
>>>> SETATTR (mode 06666)
>>>>
>>>> ...then presumably a task on the client opens the file again, but the
>>>> setuid bits don't get stripped.

OPEN (get a write delegation
WRITE
CLOSE
SETATTR (mode 06666)

The client continues with:

(ALLOCATE,GETATTR)  <<===  this is when the server stripped the SUID and SGID bit
READDIR             ====>  file mode shows 0666  (SUID & SGID were stripped)
READDIR             ====>  file mode shows 0666  (SUID & SGID were stripped)
DELERETURN

Here is stack trace of ALLOCATE when the SUID & SGID were stripped:

**** start of notify_change, notice the i_mode bits, SUID & SGID were set:
[notify_change]: d_iname[a] ia_valid[0x1a00] ia_mode[0x0] i_mode[0x8db6] [nfsd:2409:Mon Aug 21 23:05:31 2023]
                         KILL[0] KILL_SUID[1] KILL_SGID[1]

**** end of notify_change, notice the i_mode bits, SUID & SGID were stripped:
[notify_change]: RET[0] d_iname[a] ia_valid[0x1a01] ia_mode[0x81b6] i_mode[0x81b6] [nfsd:2409:Mon Aug 21 23:05:31 2023]

**** stack trace of notify_change comes from ALLOCATE:
Returning from:  0xffffffffb726e764 : notify_change+0x4/0x500 [kernel]
Returning to  :  0xffffffffb726bf99 : __file_remove_privs+0x119/0x170 [kernel]
  0xffffffffb726cfad : file_modified_flags+0x4d/0x110 [kernel]
  0xffffffffc0a2330b : xfs_file_fallocate+0xfb/0x490 [xfs]
  0xffffffffb723e7d8 : vfs_fallocate+0x158/0x380 [kernel]
  0xffffffffc0ddc30a : nfsd4_vfs_fallocate+0x4a/0x70 [nfsd]
  0xffffffffc0def7f2 : nfsd4_allocate+0x72/0xc0 [nfsd]
  0xffffffffc0df2663 : nfsd4_proc_compound+0x3d3/0x730 [nfsd]
  0xffffffffc0dd633b : nfsd_dispatch+0xab/0x1d0 [nfsd]
  0xffffffffc0bda476 : svc_process_common+0x306/0x6e0 [sunrpc]
  0xffffffffc0bdb081 : svc_process+0x131/0x180 [sunrpc]
  0xffffffffc0dd4864 : nfsd+0x84/0xd0 [nfsd]
  0xffffffffb6f0bfd6 : kthread+0xe6/0x120 [kernel]
  0xffffffffb6e587d4 : ret_from_fork+0x34/0x50 [kernel]
  0xffffffffb6e03a3b : ret_from_fork_asm+0x1b/0x30 [kernel]

I think the problem here is that the client does not update the file
attribute after ALLOCATE. The GETATTR in the ALLOCATE compound does
not include the mode bits.

The READDIR's reply show the test file's mode has the SUID & SGID bit
stripped (0666) but apparently these were not used o update the file
attribute.

The test passes when server does not grant write delegation because:

OPEN
WRITE
CLOSE
SETATTR (06666)
OPEN (CLAIM_FH, NOCREATE)
ALLOCATE        <<=== server clear SUID & SGID
GETATTR, CLOSE  <<=== GETATTR has mode bit as 0666, client updates file attribute
READDIR
READDIR

As expected, if the server recalls the write delegation when SETATTR
with SUID/SGID set then the test passes. This is because it forces the
client to send the 2nd OPEN with CLAIM_FH, NOCREATE and then the
(GETATTR, CLOSE) which cause the client to update the file attribute.

-Dai

P.S I have the pcaps of the pass, fail and fixed case if anyone
want to see. I do the tests with generic/683.

>>>>
>>>> I think either the client will need to strip these bits on a delegated
>>>> open, or we'll need to recall write delegations from the client when it
>>>> tries to do a SETATTR with a mode that could later end up needing to be
>>>> stripped on a subsequent open:
>>>>
>>>> 66ce3e3b98a7a9e970ea463a7f7dc0575c0a244b is the first bad commit
>>>> commit 66ce3e3b98a7a9e970ea463a7f7dc0575c0a244b
>>>> Author: Dai Ngo <dai.ngo@oracle.com>
>>>> Date:   Thu Jun 29 18:52:40 2023 -0700
>>>>
>>>>       NFSD: Enable write delegation support
>>> The SETATTR should cause the delegation to be recalled. However, I think
>>> there is an optimization on server that skips the recall if the SETATTR
>>> comes from the same client that has the delegation.
>> The optimization on the server was done by this commit:
>>
>> 28df3d1539de nfsd: clients don't need to break their own delegations
>>
>> Perhaps we should allow this optimization for read delegation only?
>>
>> Or should the NFS client be responsible for handling the SETATTR and
>> and local OPEN on the file that has write delegation granted?
>>
> I think that setuid/setgid files are really a special case.
>
> We already avoid giving out delegations on setuid/gid files. What we're
> not doing currently is revoking the write delegation if the holder tries
> to set a mode that involves a setuid/gid bit. If we add that, then that
> should close the hole, I think.
>
