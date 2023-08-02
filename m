Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1187C76D875
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 22:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjHBUQY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 16:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjHBUQX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 16:16:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367242690;
        Wed,  2 Aug 2023 13:16:22 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372HJ1wj009261;
        Wed, 2 Aug 2023 20:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6Fv4RX/PnH0IgAmQIM+TiQ2qph/hnq33I18ZrXak7QE=;
 b=1MUS03KK+gGFINtmDXj0xrZOFviwUOE2ehQEWr84AKO97BbFwRmUcQ5EYctUF5GY3jDX
 yEbdX3mNJPTGZ8h7oTSIwjgYA0+Za0KgiWwhESs1hSt9inRwwn+yhrmTjCukuPvSJAht
 bv4driUrwhFOjOjLoevLS+ypBhfuBPha19poGmSQIKGIc91j1qYPL2DlhhxXGHPtJc5D
 aRyRdTFb8iFhS+5HRmK7uqk3TXEK1czdXp7JJ1O802I+rpeZz+XCHNeO2EkdyapJji4Q
 UYk343iaiPdDAai8VdxLSXQiRWTsN6YaVUUu5o9Aj4QwNUqDsgwMg4FMAYVogmcPb535 Nw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spc88ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 20:16:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372Ijtsa015665;
        Wed, 2 Aug 2023 20:16:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s78ncdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 20:16:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X68E5ZBpWWe9yjHFxOPG816wBLGCZZcak6y0TtH9+Y49IwFGxNI0zxgnjSIidaQ/ht9UTl3nMbc1z/S77X9hMNKhvFcrjG/oHxfUkuVolc1iDpVli3ITlU1M8qyCkalptL29bzDzqPTatFRnZ2JLT8l2dgVxhcT2lEwYjZuhav+EiqdFFIUJ8pEqp/wsGG8QCIbwkoOLRNWf0bEycTVIsD87OUIBEVfhj2KemixgqT3E+y5vvRyaJAJ87ht2P2aadJREBq5eUqqExm0NGut0tYdrvXXasaJ9FZ/OQHNGPHMY+OEs2I+17fpzyn8Ig2aYjSbF9YDeTrYDyQsyH8yahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Fv4RX/PnH0IgAmQIM+TiQ2qph/hnq33I18ZrXak7QE=;
 b=Bto8BJ8LvlDY24pbzUw7axouAbrqRA1q83XZdWV/FsVqomw3w7dVPPsJnq3DzI/TQ9WU9F1PRwFjhS63plc8h0X5Klwc0qUowvu9XlnBEe4NCawtHMfbrifHH5M5J+8o/ye0isgtWs0FrEgAlELdZQ1nDHd/iFY4xAJYL47Ie+3R5Xxg7PAepDCZn+GlWMsHO9g+xdnJpQFYqagpTb3IGgnxtKaA4+19PF7h6GHELDgLM1B1CKDzw5gAe9vR7EVaEPQnzM2TLacv2q3N9qy5NNNVnrsVSidFXTM4EVIPod6vtrItgtqD8+X/V+ywibnPey/wFe3wx9DSYj2k/IRXIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Fv4RX/PnH0IgAmQIM+TiQ2qph/hnq33I18ZrXak7QE=;
 b=A+/EW19ZGB/zSfa/JiMVIzTN9Vo+la5EKyoZKuhlhNwjHNCnKj9d6nMcgKD23N+5neMC/HbbXw6kt2iR0OFMhij3/JsVyqpc+WxTxMbmi5rC2nj8el2kljaE863jeGeim71cSqqnNBwzjCMAfT8dfwZ2cjO6JQ0uwmBcXexkDLQ=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by SA1PR10MB6591.namprd10.prod.outlook.com (2603:10b6:806:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 20:16:04 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 20:16:04 +0000
Message-ID: <0a256174-44ea-d653-7643-b39f5081d8a5@oracle.com>
Date:   Wed, 2 Aug 2023 13:15:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] nfsd: don't hand out write delegations on O_WRONLY
 opens
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Tom Talpey <tom@talpey.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230801-wdeleg-v2-1-20c14252bab4@kernel.org>
 <8c3adfce-39f0-0e60-e35a-2f1be6fb67e6@oracle.com>
 <c9370f6fde62205356f4c864891a3c35ef811877.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <c9370f6fde62205356f4c864891a3c35ef811877.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0679.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::12) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4270:EE_|SA1PR10MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d73d0a-3575-464f-0f1d-08db93954c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9nIW0VyxOSQ/2kWZm9yg2pX7LZPxIL3nHuTOijFgj+RQVrEh2HxRwVJNd4sH0DvfkDgtK6gkU0OLpmZFLiQN9UhoPNgbgiP21fcZxpRpPTZFTlDV6NuzgTBldhhhUr7Ro3L3Qd8+CcpDsBo8Rb4GdiYzNTAPlkzltONOrhxyiRVIur/ohhI5EX+kBNN+cvUTByBWrEqCRwLtaYvE8ZVlL2hFaD0vuoHI5QXAcris1ZkgyUUFaRqnIQqeWTwtC5pVgLhpnNq8jr4oRw8vnY9l88KUvAQCrzkQuvr7csRClPGWWx6baxv6nx0yEbDTZ1cw8C1jckXO8hWLsWVLpv1MjvgsKimH/FfGx4Vt050sU5d3tOKWWHI55lPonQEzn512iPXsBNd0HN2pCMueg32SdyH3T9QDYN8jcxh9pxpwScYSLv93pIK0b7SJVDszakhwPSUzledAfGdeu7lLPk36krqgqWyunqBDB+42TWVb4SKFyUUNS/qMgUfsUV9T/IGQweCcVtroMECPHx7YZOosrjF7U6lZ94ZHqi4W32L/xXluORifeHYs/SL4e5Jb5DdbAug4A9RvTsb6UV5kk9+4WCd183WiMH2MPZoHg4rYv+rHtNbl1mzrK1j8oXklR5CDPM16AO60dn8Zky3xlCvwVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(8676002)(5660300002)(83380400001)(2616005)(38100700002)(41300700001)(316002)(186003)(8936002)(26005)(53546011)(6506007)(31686004)(4326008)(86362001)(66946007)(31696002)(66556008)(66476007)(6512007)(9686003)(966005)(2906002)(6486002)(6666004)(36756003)(478600001)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHR0bXU0NVdzRXFpSXI5UldidkdKUXVJMG9nTnJsUjVUMmQ2TDFocEhOTDBM?=
 =?utf-8?B?Z0V2ZyszYzV4N1Z6bS9DTDFPOVhNRmdsKzRrT1pza2xNYmNQZ3pLcEVUQ0RG?=
 =?utf-8?B?TWN6VzNIMEUwWmtGK1p3TmdNUUZQbGRyckdBY0hwZ09rVmVvSFl2eFhKclNF?=
 =?utf-8?B?NkFJaTN5U05UTll3VlB3T1BCbEJ0Zks4MHh6WC9JOGM1QTJBWmNnTS9BUjdM?=
 =?utf-8?B?K2RSYXhqVUhGSExzbmtraUpoVXBYYzNlWWxlOEY0eE9DeWp5b1lpNjNpeWQz?=
 =?utf-8?B?VXN2OUZjMERRTGgwWEM3b2R4QzZxQzB0VmpmR0dyWHpGRUkzSDFiNTdWUUlC?=
 =?utf-8?B?eDM5RnIwQnM3YnZlTm1qbHYvOEV4RE5QUmVUMUk3OTB3QmRqRk84MEtOcWRK?=
 =?utf-8?B?ZFNSbVA2SUV4SmQ5MGp2V0hIQWV6dGlUbWYrblZFM3JkMnhEYm5Bc0xacU9r?=
 =?utf-8?B?a0V3eGpSQU9MV0hLTklESlpLNU5aRVpVR294MTBadjlBNmhpWUlCWnFodlpz?=
 =?utf-8?B?a3cvUWFwY2thQm9ldHhNL01STnJsYTRRZjRLbzI0a3c1Rk91bUVWMUR2NFdk?=
 =?utf-8?B?ZlMreHhnRm04RlVZU05UbUlraVJrS2V2K1RGWUdSQnJac2dXQUU0RjRZZCtF?=
 =?utf-8?B?YWJMRFNxRHE2WTlHdlNDZVhpV0syZGlFaW54OVhncXNrRy84SUFNQUIyZ3k0?=
 =?utf-8?B?NFRiVDJYcmJVY2VBVXBLa2N4OE1nNDRBK1FPNEgxalpNaDZvS0ZMM0paeFB0?=
 =?utf-8?B?cWFRaTdiaEhqaXlENi92UmRoaWhyM3UxcFNGT1FUK3AyZG1UMm90Z1ZXQ21X?=
 =?utf-8?B?ay9YbUtTQjFRY1JLOStaU0hEbEFrOGlscUh0a1oxVlFZaDlEWDdXeDg4djVL?=
 =?utf-8?B?dFpQZGpPcnVPbVBTTjJndEtvdW5NTjU0LzRRWksxL0R3TTdPOVM4Nk5SYmhE?=
 =?utf-8?B?RWVBbXhMOGx3SlNaWUJ2clBySEdueiswSjJtYWJIalBubis3bmNUV3Z4RTVQ?=
 =?utf-8?B?cXpzZEFjVFZSVWZxWGEzcDc1VFNoQ2lzS3hwaU9lZHQwN2o3bHlOakpHamdq?=
 =?utf-8?B?TkpwMGc1bmlBRVB1bVFieEtQOWpKSU9DQi9zUHRMblFoZkFpTUp3WnFmSUVy?=
 =?utf-8?B?ak4zN29JUXhFZjZQWHNsU0t3UmV2M3pmQUJBWGJiZnFDVjNYUlkvb3AyT0xI?=
 =?utf-8?B?QWxFWWVENnpUWHFmQnhkcmFMNmxUZ1FIRnR0V3RadGlKSktkTjZ2WVZsMElM?=
 =?utf-8?B?QlV1STMvZEkranhBbGEwTnJIbkxpRVUzdndZQXNYVVhlMzhqZWl6NFowZzMw?=
 =?utf-8?B?Vk9ESUZNN1M0Q3RJNCtRWjlPSEtGTGFHVG9MdDdJT3cyNlRxZmdPL3VMMnBt?=
 =?utf-8?B?VDlWYnRmamVSYVEybEFIYzEzeEY4cXJqNTlaRVNrWm8vaXZ4dWJ4STIySUlw?=
 =?utf-8?B?dHlDYmdOVmpUNmwwQjFwRGczMmdZSzVRbVBmL3BmZ211L1Fnci84bEN3WWtY?=
 =?utf-8?B?ZkUzU1lNMGhkRVYrZkltYi9GNi9sYVpuQWVHcHN1d1R1Y2FGT1FQa3g5Q3d1?=
 =?utf-8?B?d2h0VGRlVDNLU29Kb3ZONlpSc3JQNHMxS1RxOFRVQVFzQkNiVFZaMmdUYThi?=
 =?utf-8?B?RGZUUE1Wd3drbWNyd0U1ZVVQNFZNWnlPNFBWS1pQY3pQWVFDTHBiRGhGYisx?=
 =?utf-8?B?cFQ1aCsxQjRDZ3NjQ3Y3VS9JSVBNZER6OTZLWGszOGFuYzUrdUQ0aXdlVk1P?=
 =?utf-8?B?aXUzNG5sVkRyWURvS1VnaWpoVXFwOE5jZG9iRTNUQnA1UHFvenRYQWhNUGRU?=
 =?utf-8?B?S1RURWZ5aFJtT3dkRHdleE9VYWJHSVE1aTF0NUpTK3NmVVdJWng5RkJqL0tF?=
 =?utf-8?B?RUVXanFxVXVmVmZjMGwvQXB3K0ZOSXkwdkxUWVBzVnQxSnBtbTg2WkFNcEQw?=
 =?utf-8?B?eWNvenJLY1Jkcys3R25vaDZXdGNCNEpEQnBzSmR6ZzVPc1A2T3BEWjhuUVR4?=
 =?utf-8?B?VEdpdlRYMjBJbEh5TTF4KzJnbEJmN1R2SWhWUFZYVjh0U21CeEhDZS9MazVa?=
 =?utf-8?B?L3B3TUduQnRqR2JNU2ZUQ2xuOWFzSVZ5bGRraGpyRy9PUTVXSE41U1BXcUI4?=
 =?utf-8?Q?n/+LOK54MehsQfI0deBkKwXoR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1huD05er5/ES53f1Uufes3lRjD+pO2XP7OesibjWzzGTwITVmO5IPJmdPlv0Lyp9PWABkf1tlVEt0GYIaiU3YNDksDCPtyhDOJmotMnZU3M4uSE56EmKScneTnmF5vIKi6Rb31cXaihfrqibifo3kkSk5z2EyaKeibZWUBuW95e625aJogNwywGuhe8Lr1FBWNtrjRC5yVW7Hzoan6A5q6wLhnkJbqKuLTDlRA3wXPr6x3d+KvK/Y3sYmVrUXR586ZXdsMcXWZswYo+n0gAQvUbOXMzxC7NFkSldrtBDqfHOy6lwh3fvVLV++Ew2UPW3WJv/yXTYE05Wj3YDVt62zIv4z2AlnwRZ/6GLlrSAZGeFjHBtVSNrtYJTcGUVKuNYV5upu9+/JZliyGAfBuZ67Att5uL1TfdjY07hf/YIuv2MYBxmjHo5OL7ofy/C3Y1TB6KdEUiCqSBjtKN/8QAaGwg/dME/Ul+ByVu25mFOEUbG96Fc3ppHxycCCnV/6DQMj1IYz9fWo8V9fpjUQIC0MNxgKTVch2HrHhb2qCnLM8RO2L8gYxwYTTQcxvx2oFWt8sE66bhPECtDoMkzGpvTVrts1fM4hSMN85FbAUdZMxgMnJU+0bsRPp1T5oKuakyiAQ1scX8iA74VG2GMxmkvW+qTdCLZ8NYjuTOk6fMYutiWOWrDpV2JcmTRePkEQQc35YdoJQX7kvKDgVu6TSRL8hLE/nnB8F9xVXWcDxarfFhnw7MlAxmItzXUsrBD4ahgrkmA83FTJ1pNH7tA7PRztwAMWe3uEc5gfo060pifLW+QUZOTzDTFtEWoAZ7jK3aMBBd1ML4Ytfyk9XDP/nC6Nm6wTnxmQ73ZzbVIpHV1IPHpmEE7M3dou6bZW04Wv0VI
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d73d0a-3575-464f-0f1d-08db93954c32
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 20:16:04.4147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DQ8dWrU7XEL7kfogk0gfvmOoawGbpPNiPVwCWiqLhoBWDuPFT2nTzSLKYO32TWlyMz1M6TS4UqjfGiDR8dvkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6591
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_17,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020177
X-Proofpoint-ORIG-GUID: pg1iHp6nojZaV-VRIFFhczQePyZSYA0V
X-Proofpoint-GUID: pg1iHp6nojZaV-VRIFFhczQePyZSYA0V
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/2/23 11:15 AM, Jeff Layton wrote:
> On Wed, 2023-08-02 at 09:29 -0700, dai.ngo@oracle.com wrote:
>> On 8/1/23 6:33 AM, Jeff Layton wrote:
>>> I noticed that xfstests generic/001 was failing against linux-next nfsd.
>>>
>>> The client would request a OPEN4_SHARE_ACCESS_WRITE open, and the server
>>> would hand out a write delegation. The client would then try to use that
>>> write delegation as the source stateid in a COPY
>> not sure why the client opens the source file of a COPY operation with
>> OPEN4_SHARE_ACCESS_WRITE?
>>
> It doesn't. The original open is to write the data for the file being
> copied. It then opens the file again for READ, but since it has a write
> delegation, it doesn't need to talk to the server at all -- it can just
> use that stateid for later operations.
>
>>>    or CLONE operation, and
>>> the server would respond with NFS4ERR_STALE.
>> If the server does not allow client to use write delegation for the
>> READ, should the correct error return be NFS4ERR_OPENMODE?
>>
> The server must allow the client to use a write delegation for read
> operations. It's required by the spec, AFAIU.
>
> The error in this case was just bogus. The vfs copy routine would return
> -EBADF since the file didn't have FMODE_READ, and the nfs server would
> translate that into NFS4ERR_STALE.
>
> Probably there is a better v4 error code that we could translate EBADF
> to, but with this patch it shouldn't be a problem any longer.
>
>>> The problem is that the struct file associated with the delegation does
>>> not necessarily have read permissions. It's handing out a write
>>> delegation on what is effectively an O_WRONLY open. RFC 8881 states:
>>>
>>>    "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
>>>     own, all opens."
>>>
>>> Given that the client didn't request any read permissions, and that nfsd
>>> didn't check for any, it seems wrong to give out a write delegation.
>>>
>>> Only hand out a write delegation if we have a O_RDWR descriptor
>>> available. If it fails to find an appropriate write descriptor, go
>>> ahead and try for a read delegation if NFS4_SHARE_ACCESS_READ was
>>> requested.
>>>
>>> This fixes xfstest generic/001.
>>>
>>> Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=412
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> Changes in v2:
>>> - Rework the logic when finding struct file for the delegation. The
>>>     earlier patch might still have attached a O_WRONLY file to the deleg
>>>     in some cases, and could still have handed out a write delegation on
>>>     an O_WRONLY OPEN request in some cases.
>>> ---
>>>    fs/nfsd/nfs4state.c | 29 ++++++++++++++++++-----------
>>>    1 file changed, 18 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index ef7118ebee00..e79d82fd05e7 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -5449,7 +5449,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>    	struct nfs4_file *fp = stp->st_stid.sc_file;
>>>    	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
>>>    	struct nfs4_delegation *dp;
>>> -	struct nfsd_file *nf;
>>> +	struct nfsd_file *nf = NULL;
>>>    	struct file_lock *fl;
>>>    	u32 dl_type;
>>>    
>>> @@ -5461,21 +5461,28 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>    	if (fp->fi_had_conflict)
>>>    		return ERR_PTR(-EAGAIN);
>>>    
>>> -	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>> -		nf = find_writeable_file(fp);
>>> +	/*
>>> +	 * Try for a write delegation first. We need an O_RDWR file
>>> +	 * since a write delegation allows the client to perform any open
>>> +	 * from its cache.
>>> +	 */
>>> +	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
>>> +		nf = nfsd_file_get(fp->fi_fds[O_RDWR]);
>>>    		dl_type = NFS4_OPEN_DELEGATE_WRITE;
>>> -	} else {
>> Does this mean OPEN4_SHARE_ACCESS_WRITE do not get a write delegation?
>> It does not seem right.
>>
>> -Dai
>>
> Why? Per RFC 8881:
>
> "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
> own, all opens."
>
> All opens. That includes read opens.
>
> An OPEN4_SHARE_ACCESS_WRITE open will succeed on a file to which the
> user has no read permissions. Therefore, we can't grant a write
> delegation since can't guarantee that the user is allowed to do that.

If the server grants the write delegation on an OPEN with
OPEN4_SHARE_ACCESS_WRITE on the file with WR-only access mode then
why can't the server checks and denies the subsequent READ?

Per RFC 8881, section 9.1.2:

     For delegation stateids, the access mode is based on the type of
     delegation.

     When a READ, WRITE, or SETATTR (that specifies the size attribute)
     operation is done, the operation is subject to checking against the
     access mode to verify that the operation is appropriate given the
     stateid with which the operation is associated.

     In the case of WRITE-type operations (i.e., WRITEs and SETATTRs that
     set size), the server MUST verify that the access mode allows writing
     and MUST return an NFS4ERR_OPENMODE error if it does not. In the case
     of READ, the server may perform the corresponding check on the access
     mode, or it may choose to allow READ on OPENs for OPEN4_SHARE_ACCESS_WRITE,
     to accommodate clients whose WRITE implementation may unavoidably do
     reads (e.g., due to buffer cache constraints). However, even if READs
     are allowed in these circumstances, the server MUST still check for
     locks that conflict with the READ (e.g., another OPEN specified
     OPEN4_SHARE_DENY_READ or OPEN4_SHARE_DENY_BOTH). Note that a server
     that does enforce the access mode check on READs need not explicitly
     check for conflicting share reservations since the existence of OPEN
     for OPEN4_SHARE_ACCESS_READ guarantees that no conflicting share
     reservation can exist.

FWIW, The Solaris server grants write delegation on OPEN with
OPEN4_SHARE_ACCESS_WRITE on file with access mode either RW or
WR-only. Maybe this is a bug? or the spec is not clear?

It'd would be interesting to know how ONTAP server behaves in
this scenario.

-Dai

>
>
>>> +	}
>>> +
>>> +	/*
>>> +	 * If the file is being opened O_RDONLY or we couldn't get a O_RDWR
>>> +	 * file for some reason, then try for a read deleg instead.
>>> +	 */
>>> +	if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
>>>    		nf = find_readable_file(fp);
>>>    		dl_type = NFS4_OPEN_DELEGATE_READ;
>>>    	}
>>> -	if (!nf) {
>>> -		/*
>>> -		 * We probably could attempt another open and get a read
>>> -		 * delegation, but for now, don't bother until the
>>> -		 * client actually sends us one.
>>> -		 */
>>> +
>>> +	if (!nf)
>>>    		return ERR_PTR(-EAGAIN);
>>> -	}
>>> +
>>>    	spin_lock(&state_lock);
>>>    	spin_lock(&fp->fi_lock);
>>>    	if (nfs4_delegation_exists(clp, fp))
>>>
>>> ---
>>> base-commit: a734662572708cf062e974f659ae50c24fc1ad17
>>> change-id: 20230731-wdeleg-bbdb6b25a3c6
>>>
>>> Best regards,
