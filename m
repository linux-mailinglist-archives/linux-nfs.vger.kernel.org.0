Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96014742A6E
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 18:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjF2QQS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 12:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjF2QQN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 12:16:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9F7359C
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 09:16:12 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TE7YBr008394;
        Thu, 29 Jun 2023 16:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2foRUdSQuvR5P/hM3IKl5L8YXn6AE1A/Fh3TNBstFbM=;
 b=kBk+SKoZ/Oy3/82e9svmw9CGOZohd49HIE10aIiVi1DLaK/RrLoC6A3BceCb0jfNYHu7
 KYtxiVQnQt8l5N987Xsq9VnyFSoPB+5VXkuGw8JHi6tJeuj0VUJhln7VX4NTSfMoOkRM
 JKnpd6PJmW0mIZR08PRTVjlaopmFOFQSoSEr9Gv3TUBuW0KvpPqkoYkJy9nigwc/yAHy
 M0yKrNEuggL2s9/a33xhUY2qL3jPNCImrNOYIXDdUOy9tBwoR2vBqUp3cariHzF62vvB
 j4+gJNte6K3fR0Om+guq/XwWz2Wc6QzjKtTW5naZAuMSk0yEW3EjuoF9+obSRGPOM9mR nA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdpwdms1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 16:16:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35TFrseF004007;
        Thu, 29 Jun 2023 16:16:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxdmv71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 16:16:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlhDm53z23qGG9jG40If7c6Ds4crdpaER3k1OEv164Py+o5cfrtEHaOR9sE/E4971GtcBGESls2ROuU0O6Fj25WG8UkvZuMx6+a9VuClF/0GJXOJiQImLcROm7Ogbl2xVfyAvydaAakChnHTyw3JlTIunL+igBUSO9knJxwYk1mt/Hqtk9aIjRjBSRP44RU/taCVIMcF0yCXD9GVvNZbzHvlDpfMqYsNBMe3rIb185Vo9FvGlQ7ABcT5nVdmnGhhAJt8Eo4HdJNTinH+NqfCXD9PiYe3V4HvNgicQcqxHd9oFkgLnifefYFfR7dpL1hkhBlqVJ4Gb5SzY1aFGzWNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2foRUdSQuvR5P/hM3IKl5L8YXn6AE1A/Fh3TNBstFbM=;
 b=QsftQSAMDAKFI7+34vEkOo8vengyTvWXadY6SReTi5Ot7B83cJc8r0Mh/w4Tg4kMCOtXKXnDSpTyunsK+brEITFEjrFgvwQsvKCpKgTX1Fme+DbLGGyeMDwSHAjDj5wqsFZxJ+K/17KVSNxE6+KNwmbjlD7L0Prur/zSquoE8WsRqYGC8TDHCvkHoYTFBlV/I4WtxdYAx2webpvEipyuD8eZTPu7C8Wnf+NAvicbEvmVgLiUfLkUUnEJ2S2d0a2/aaaADOFYm6em3RpJx36x2lXGf0saIloKSqBBGCSsYZFssEJClI+vYBADFzLimuo+dCawPGpUharvsVYxO0qA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2foRUdSQuvR5P/hM3IKl5L8YXn6AE1A/Fh3TNBstFbM=;
 b=YpiNUNRAqCDx0RrnpI1VxJS0KPDxToSi8cUYUS6GLjfL3EDDd9wS2OyRQlFhCfLaPm+JiXoOMALae7NTpteL1pTvgRCsX7BiYdKV+wi/zd6VplnU1Vz4KZoM3IjSGrGY1A4+mSLQjQiJg33WJqnGx+57kT5Moj6OhxTM3wBTH/g=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by BLAPR10MB5217.namprd10.prod.outlook.com (2603:10b6:208:327::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 16:16:05 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::1b0f:fad9:3eb1:95e8]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::1b0f:fad9:3eb1:95e8%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 16:16:05 +0000
Message-ID: <ea18db89-47ca-3eb2-2669-a414dbd77e08@oracle.com>
Date:   Thu, 29 Jun 2023 09:16:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v6 4/5] NFSD: allow client to use write delegation stateid
 for READ
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org,
        linux-nfs@vger.kernel.org
References: <1688006176-32597-1-git-send-email-dai.ngo@oracle.com>
 <1688006176-32597-5-git-send-email-dai.ngo@oracle.com>
 <ZJ2dBnw2PZOMB0oQ@manet.1015granger.net>
From:   dai.ngo@oracle.com
In-Reply-To: <ZJ2dBnw2PZOMB0oQ@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::19) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4270:EE_|BLAPR10MB5217:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d853243-a92a-476b-8648-08db78bc23cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1hlgjvjs4efBe2LxIt60bXxCZb+A9Vf8fyWTpCSgKbUJDhoNd2T9xGej/KGR7TALrsA7ngZjuZtAz9WEEXJDXwmOthQmMuVKv8ZFeBVr/6PTHSOhXHjcv3Dj+0hURT0+HENYXY7aD4rBgTfevxhECaPGmLUFaWI8smWUTpBjifq4J6LyowNIWzF4clkZ+ocpEldEMYAGRayB+7E3UwM/w+OqkPnDX8OuuEBMmue0o2Tw4od0TngchdUW1pQZqidfjTdhm+k7brXnbgTIhcCYt7CggP+dEa7yVCTpnONa39pY1nHIN4KF2B+sMD8L515VXj1AFBBhyuV4MCmtet6qz7ChC4E/uXhpE/5cOBhSw7ZFz9N5ZKPvxw6IQF19ZA+CLsu/H+3OGnLwer9nlfMMnwXwNrHQvp6fxLh5cHC6hsAV6s03GZ7dTC2NpqNQ3+LdER8NH2OmFptIRvEn0E0Eoh2bmn2F3anp8pUX6uwooL1MUTIhlNq46ep5gtwBIJMn1QoXJtXqaIH+siwG/GYUYUvqACRDz8i/2hGaiVT0uaj1m7mO675yycHUp018f5azrOmBF5nCHv9lhxpxBhaMRIMtvQ6lxStk/RuxoPc8Vm6W6UVhhW+kSHP+sZz8R6HE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(31686004)(6512007)(36756003)(38100700002)(5660300002)(31696002)(86362001)(41300700001)(6916009)(66476007)(8936002)(8676002)(316002)(66946007)(4326008)(66556008)(478600001)(6486002)(6506007)(2906002)(53546011)(9686003)(26005)(186003)(2616005)(83380400001)(6666004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yy92TWg2R2toOTZRZUxyTjFuT09JeE9aVWh5aTNmRnc0YjNLbmFDV2ErWmNN?=
 =?utf-8?B?UU95eWZUc2tGd211YXE0NC9oTXdNdDRyTXFkRWcwaVFvVGlHUUVJdW1ieDR5?=
 =?utf-8?B?M28ra2NSdjlSalJjYkpsdEZoSTIxSitJYkNIUnJHbGJkSkFjYllJb2Nwd0xo?=
 =?utf-8?B?TUMvdjlNaHRpc0VwNGV6cjBveWpmVW5LR0U4VC9ITXJkNVNrZ1BvYTZ1bVl3?=
 =?utf-8?B?VENNZ2xQT0hObnRqczFhcDN2MUw1djIrWEJBREZVRnpOQjJzdmtyanpyc1V4?=
 =?utf-8?B?cmZGMFBBb2dhbDVlYVNGS2s3aDg4cXNSOUhQY1pyN1JmajVCZndUNTdUTFFJ?=
 =?utf-8?B?c3hKOElLTHdkZXVBRkJTOVRXaXhYY1dWMzFhK2dxUTZOU2EvRzk1OENnWldI?=
 =?utf-8?B?N2R3eFZRRXBXdmtYZXVyb09xTG1rZEZKcGRJR3NxRmtXWW8xU0ZzWHhRejY5?=
 =?utf-8?B?SWxERERWZW5uWVFmUmtOTHFzY3lJNHJNMDBLdjVqemtBRHg2OXRoLy9aN2Zx?=
 =?utf-8?B?dVd1ZmpnNmwrTFQ0T2pJYmR0Z0ttVXNtY2sxVFJEQlZ1Q0l3OUFmbWdNM0ZY?=
 =?utf-8?B?cnpiMU5tNXNWUUl4VkEyNlA1akRWcGh5aFVKSkY0QTlhblRIVUszRVRrSStD?=
 =?utf-8?B?UTFuUDdDOWVCSG9pMnhFMkd1Ukd2czBNdTlVWFVrRlF5NTBRd2JmbW1wcXc1?=
 =?utf-8?B?dHJZYXpmdFRrdjVxMTV3VHhFSXYxTXkxUFhPU3JCQkYxTk9wa0psUWlyZjBQ?=
 =?utf-8?B?Ulk2SSswMk9iQkZrVk8rU0hkeWlSNks3QmQwY05Lc1VZT09uN1lGQjkrSE1I?=
 =?utf-8?B?bG5yMDJSay92RjBHOHlmUjR1UllvWG1Pa0JzUGhJckd5aXNTTmY0RWkvRTF5?=
 =?utf-8?B?TktEbW80dDkrZFdaM0Njd1daM2xEbXJMbUVMWTJYcVQyd0g1U00yTkIwWkZI?=
 =?utf-8?B?RDJpZDdRMHZsdWxpeUxqZGVaK3pqb3l3dUpaN1U0ZDEwdGEyclhHK0ZYOFZS?=
 =?utf-8?B?T3Z1ZTBMN0dPNjJVQmpabFVRaHNCTm5PdUVhcS9DRTlnVy81dzEvUEVEUnZu?=
 =?utf-8?B?czd5V2Y5U05tRWJCeVVIbDF2eElxVEJCaVNQcXNmRXRyY2EyQW1RcHFjdjVy?=
 =?utf-8?B?Z2VFYlFTNFdTalhxcEFEd1M0OUpRaS95cW5veXV4SW9oYThkVGlKVVcraHVS?=
 =?utf-8?B?MTNnam9PNWhCRWVIa0tDTEczWktTYndianNDZCt5dHgrVTE3V0FoZW5iVUY1?=
 =?utf-8?B?MjdqT0QvcEpSQTd2NjRWVWhDWDg0b2dVM2luZjc2WmN5ZmxMSkJpQ3Y2V0pv?=
 =?utf-8?B?d2tPYXZ0V1NNdWFxSjM1M3NFbE5kOGlhcDRiSEprcUtTemJNWStGQ00vQ0hU?=
 =?utf-8?B?QVV6YithZU03RG4ySXdvY0xJUlZRVUYzWWx2SmNGWW5QbktvRm1DN3k4TW1F?=
 =?utf-8?B?bEU5ZlVuaTd6Nk03NUZlSkJYZGh4SlJCdWJwRlhJNnp2UERkTzFKd09GMkcr?=
 =?utf-8?B?dHJNamo3dzQzQktDeng2RzVCaFRkZnVLYjNDTXMwblhub3k2WGZLd0VLY1hG?=
 =?utf-8?B?cnJNZFBSdUh1VTByOTJ2bTdCOVJURkdubWNrTGMwa1EwM0gvMmdPb3l4d0pt?=
 =?utf-8?B?MUo4SjM3NmQ5THdGU09PN0lRVTB2aHZsZTAxUXlQcHVRZS9zenMvU0JCVXZt?=
 =?utf-8?B?N3JNWTNHYnE1Z1VndEpQV0xVT2ZTa1hXRGF6VXB4VGxPbCtWY3N3SDY5dGtT?=
 =?utf-8?B?Z3pkNmUzeVZoMWJkM0ZWNEJJVmlmVzhJSjVvQ2xOb1ZYczNxNzVoZHNDcnJ4?=
 =?utf-8?B?bldubDYyYjFUUmlXdTJSckNOcHpOSkFqdUg1aWQzd2Npeld3ckRNVGFFWnVr?=
 =?utf-8?B?b0NDb09hU2xES1pEdUo1RVVuZnozRmlZMEtDRWdTd2pOeDJkNHpWdlJUVzN0?=
 =?utf-8?B?RURKRWJQWlQ4eVNPQnl3cEgvd3UrRXczbkF3aE5yaDY0bkFsNjhDS3F5K1VO?=
 =?utf-8?B?SHBNSG54SkpIZ29QSjlaay9qQTI3cEtUZU9jOUxMNVdBRkpWcFNuQVZ4d1JG?=
 =?utf-8?B?M0tCbWRXQ0lHNGlIUk5xaVhUaXZOM3hqYkNoVU1INWl5YktzeWlZVm51RFQ0?=
 =?utf-8?Q?qg+nGrSWd0fXLNpF+zvxKGPsL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NvFv9e3zE4GLFB6n1Sc+lRSC1lUSQ8MtU4m5lnsWEvYz8Pxw5m32pwSxeC+Iy2DnJJXB6/BlDDUSJQsJwhMvu6hPVJ6XhsumOtwHCkjKyzcK94l9WesUWYNyHQFJyFONexKgBajncCBr/hC+QPnflUU25tXhQkKWy+8FeBiDVLhX+kGtnJGRSat14s+gWvnn4haZZw4n5wxq/22Moo+sH6KfSSBjs8xrQakqahF8IR9TRD3c8oSQjcKrUuFvc0qntgsuFS/BAZeeQn2mTnb9mjx5jU63/swHeCvvb9ywtZza23NunQdGch51JUEINNsTORsvKz6c34g3iBj7+JcKF7I87P3rSPcF9JKVi2tpqRagw8fGfqsEgs6VNGVDMF0eT/234yC5wjYMxe0ckd2AgAG9yhEnduF+pq0Z7P14PXfMAZOOL03pVFNT218+RCJeLgYKtZnA2dJkT46mFRHIWY5ug+Mjy5eI/Pe7KezzxoHuYqWYr50zmF1ppBSOrmSX2I3MZYmWx4+RYtee4FHWLNiOchVYvV4QdGJ5xURiRJe4x9IrWmnA/H8Q4CGJOtjBT3U5taTxyGItpbTTNXdRmw4U42fpby4syrSfmFqVM760Ve6n4xvLk41h+52sbJBHc56PgkpM/1xWOOwp9zDfIlEAW4agRBrJFKHa7aIscOWOM4UlZ6m1K3pd3TOJWBe68GrpI37qUzA+Rz8JGTY6FXHda3csXuRrbYV/stlcsUr8rfhm8tRdTpBpncpLwFQGct/lZLanexR1rN3FyjYtHHum/1C0BwPsbXQUBNpw3+Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d853243-a92a-476b-8648-08db78bc23cc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 16:16:05.4445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4V8pTQC0DZrRf67S5z2T+nIUDUXjM7ksnp7RmkmqGE7L3UFG4L76+h/9l7KyPmMSKTzm+ixiy4SLNV8bPwTzfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290147
X-Proofpoint-GUID: whfEu6cyIh08NlKaJI-_Z20TP2ydD49j
X-Proofpoint-ORIG-GUID: whfEu6cyIh08NlKaJI-_Z20TP2ydD49j
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 6/29/23 8:02 AM, Chuck Lever wrote:
> On Wed, Jun 28, 2023 at 07:36:15PM -0700, Dai Ngo wrote:
>> Allow NFSv4 client to use write delegation stateid for READ operation.
>> Per RFC 8881 section 9.1.2. Use of the Stateid and Locking.
> I'm wondering if this fix should precede 2/5 to prevent breakage
> during a bisect. Jeff, what do you think?

Will make this patch preceed 2/5.

-Dai

>
>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4proc.c | 16 ++++++++++++++--
>>   fs/nfsd/nfs4xdr.c  |  9 +++++++++
>>   fs/nfsd/xdr4.h     |  2 ++
>>   3 files changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index 5ae670807449..3fa66cb38780 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -942,8 +942,18 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	/* check stateid */
>>   	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
>>   					&read->rd_stateid, RD_STATE,
>> -					&read->rd_nf, NULL);
>> -
>> +					&read->rd_nf, &read->rd_wd_stid);
>> +	/*
>> +	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
>> +	 * delegation stateid used for read. Its refcount is decremented
>> +	 * by nfsd4_read_release when read is done.
>> +	 */
>> +	if (!status && (read->rd_wd_stid->sc_type != NFS4_DELEG_STID ||
>> +			delegstateid(read->rd_wd_stid)->dl_type !=
>> +			NFS4_OPEN_DELEGATE_WRITE)) {
>> +		nfs4_put_stid(read->rd_wd_stid);
>> +		read->rd_wd_stid = NULL;
>> +	}
>>   	read->rd_rqstp = rqstp;
>>   	read->rd_fhp = &cstate->current_fh;
>>   	return status;
>> @@ -953,6 +963,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   static void
>>   nfsd4_read_release(union nfsd4_op_u *u)
>>   {
>> +	if (u->read.rd_wd_stid)
>> +		nfs4_put_stid(u->read.rd_wd_stid);
>>   	if (u->read.rd_nf)
>>   		nfsd_file_put(u->read.rd_nf);
>>   	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index b35855c8beb6..833634cdc761 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -4125,6 +4125,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>>   	struct file *file;
>>   	int starting_len = xdr->buf->len;
>>   	__be32 *p;
>> +	fmode_t o_fmode = 0;
>>   
>>   	if (nfserr)
>>   		return nfserr;
>> @@ -4144,10 +4145,18 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>>   	maxcount = min_t(unsigned long, read->rd_length,
>>   			 (xdr->buf->buflen - xdr->buf->len));
>>   
>> +	if (read->rd_wd_stid) {
>> +		/* allow READ using write delegation stateid */
>> +		o_fmode = file->f_mode;
>> +		file->f_mode |= FMODE_READ;
>> +	}
>>   	if (file->f_op->splice_read && splice_ok)
>>   		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
>>   	else
>>   		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
>> +	if (o_fmode)
>> +		file->f_mode = o_fmode;
>> +
>>   	if (nfserr) {
>>   		xdr_truncate_encode(xdr, starting_len);
>>   		return nfserr;
>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>> index 510978e602da..3ccc40f9274a 100644
>> --- a/fs/nfsd/xdr4.h
>> +++ b/fs/nfsd/xdr4.h
>> @@ -307,6 +307,8 @@ struct nfsd4_read {
>>   	struct svc_rqst		*rd_rqstp;          /* response */
>>   	struct svc_fh		*rd_fhp;            /* response */
>>   	u32			rd_eof;             /* response */
>> +
>> +	struct nfs4_stid	*rd_wd_stid;		/* internal */
>>   };
>>   
>>   struct nfsd4_readdir {
>> -- 
>> 2.39.3
>>
