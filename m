Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A187D72B8
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 19:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbjJYR6H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 13:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjJYR6G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 13:58:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021FA18D;
        Wed, 25 Oct 2023 10:58:02 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PEwUPM032133;
        Wed, 25 Oct 2023 17:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=4RZ4PgzVsUU4Ox5+LUarhT4zfKHCDjHYLzKjHDzipd0=;
 b=wTL/7/eJbHd8ayo4L4yeThbg3YO/rCcYmXdDLruZPrqbjpnBH5YJ70y12zf6UiVC8Trz
 mqoCr1v1LqUXNlJI6ICnxqx3wYY53RqMUDuGG7RSHvVyc3BB/9lNgEBI9SebDPnug4VB
 0jKkBOsWMChU2qszjiB8ZOFQFbw9893Es5sjF4ek89diHeUi/EWRo9w99QSGW/ba1kVU
 cxeJvPYNCaFsKTmxzYFwa+zjDtc9P3tlx+3Rx0XJ/hjRHgR/hPFHNUZOxYT/wJlWYd1i
 qGDJjQbpjKzfEUXJqTEVjbEtLy2aMBpKA+B+TfrIkDM3LP+WpqIOSIBNcmo7KE52n53F xg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv6harb0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 17:57:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39PGYqLS031243;
        Wed, 25 Oct 2023 17:57:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53dgn4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 17:57:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlAwF8o22jnSqq6Y0ErsZK1JX4vEr4mETn1z7gp0VN8rAyLseuYDANbb4evP33p4rvBzZCiNmKwqOvJ0HF097UbBC+RijnhVOX8qV5Vkh6Dfg+KwfUvWO0iUu0xze4yr49on+oTOmLr9V7lOZwjztPIagIlpm48fYjZLpZZaTBy49c0NIDkgyICrDryHGznYUNd/baGfO5M+XwzQ7DjkyhN4RUYuM5rYMSHYFk9mAIhI3SbtdFdbeGOc/0oYOb8ZbqG250r3dKijtTRUpa+lob+UIw7UmLd1vIUvw0zVcuznVJvSBGtYasc0PM2kCpaXvUyOb3Urz8aDVsenJ0COQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RZ4PgzVsUU4Ox5+LUarhT4zfKHCDjHYLzKjHDzipd0=;
 b=SK6NFenAhG6uc5o3U6FCjmDE3wOgA/Yaa1m5EaVHFuPci0SB7hzzXFOXn0KdITH9JNuzjBMTXRs+95OQNBcff2W4/jXWTEkXVvIncVVYEQ6h1FOeOT0mhLk5Jjd8frzNrDP8eGeu8obRbXTPxCs3tYBDh6JVxT9k8hTfiVXNyrg/5jil5dnolQ8hPeenfYkHSLK4sEojHqMnA41JhcV0i6MH0ekxs2dESQi2L/2Tv3hj70urmKd+oIdS9F9TPoS/y0tzqOz4yGQ4MPPw+AGNGLORbcjOAbNYUo2zjifQ0u7QK1hHA1q3RbvWyL3D38Mhh4pAixu6sEbsKBPDfQgV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RZ4PgzVsUU4Ox5+LUarhT4zfKHCDjHYLzKjHDzipd0=;
 b=lpnJ/OQb7Y9jDvHXBIqzXhaSwGKUqyqiEp0WoF2fFPeR3Q3wWDz0WHMt2K5sVBKyZ570pdR2kS441IDVLFqLHh1DtHulmOJm5+7Qms0f4yg7aKSqNi44TFFZoam7pHlZT4uxp1Q5UZrFAj7ZSVBvCA01VwxCWpLN19IUR6xCkiA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7264.namprd10.prod.outlook.com (2603:10b6:208:3fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 17:57:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7c24:2ee:f49:267]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7c24:2ee:f49:267%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 17:57:38 +0000
Date:   Wed, 25 Oct 2023 13:57:35 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Ingo Molnar <mingo@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: nfsd_copy_write_verifier: wrong usage of read_seqbegin_or_lock()
Message-ID: <ZTlXD/hQAVQMKfaE@tissot.1015granger.net>
References: <20231025163006.GA8279@redhat.com>
 <ZTlJmuDpGE+U3pEF@tissot.1015granger.net>
 <20231025173931.GA29779@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025173931.GA29779@redhat.com>
X-ClientProxiedBy: CH0PR04CA0110.namprd04.prod.outlook.com
 (2603:10b6:610:75::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bed4663-a896-45fd-0505-08dbd583e039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m57ITQMFMDHIFKxvnj5v3CYL/xSkgDedwgbZKnIsAfcqqQurUKP9sMu2F7uRBLM+SxCt3V66BtjQo+4rRg29kD4XBBvX/dB3bQvhPzvb+xRYcaq1L2jgzg9I5XruKDMABwBmsPZGhM6a9GYijX0pVLdO7PDb8uH9CntPOlYhJJSuO4SfkfPIm2wb3wJz6VZnLeilid5RVQiDUw77rGuzvxwiGVQKwo1WEuMQDxvGqZNgVgJ1INWqn3v5Jkq0yErIOwOwbO69o6CHG8rQXljz11TEtld/9LbH7ZbE2+VBkeuyaR3ROwPsvXNIyEe5xwM+UBlORKFGSmr3c33Q8bUDu5jR4kaUUlEBuORQzPufGUOpKtEuksvXQPtZmC+jOy2EKLlLLKsK3Se8wbGa58KikkU/9CEDofqyR0UTxqSOxjx6bhtIzcsNY3Se47/P2efZdn+ZP9C/ba3dQVF52sQvXO57NSMbodSL82aM63daPK+33GA8sLYCzzaPKQ59AGBQ8vyaz0WXCz4a1agbAmwQfxNsa1EzZYR1RKz5B3KOh7G1RcgAea8N9LCZbgm2bp74
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(44832011)(6506007)(6666004)(478600001)(66476007)(54906003)(66556008)(9686003)(6512007)(66946007)(6916009)(316002)(86362001)(6486002)(26005)(83380400001)(38100700002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JTIuzedQcrP76iH3GkBvyBIIo+n4CpiN6Jfz0QZeaLkDfJj9QE7LYv3tpYUH?=
 =?us-ascii?Q?GfLfkDczFEHkIpo++Wz7377aLcVTHfza/winoS055lAYZimgE1ljQ15MrOiS?=
 =?us-ascii?Q?TLqe/vyqYSAlQS7LcBzbp2XXu8sAtWuvf0RF0/TCif87cW1KZlg8cBtV82di?=
 =?us-ascii?Q?GoXwG+XStBo45Mm4cbGWn9T+1vx/AjUyU2axDvtRS0SlRbC3i/qeKZ2XmelB?=
 =?us-ascii?Q?fsgReoN+QXmkxj4Dn5vB3TMpaEPj/dVI2dt0lMsCEglsx1II4E4VEPkLv/Qk?=
 =?us-ascii?Q?R95nhYB6TG6LCuoCD4RtPBjROUX32kaJcLLexo5jh0siErfGV/1Id1fKtip4?=
 =?us-ascii?Q?e7t3InWTOhmSvstJ2JWCAPNPm0ovDFNsepuOH1kYM4ePOY/z2ShbFh25mleH?=
 =?us-ascii?Q?PkiGZTHLPHDMheaKpUT+9dmz3E455G2xrDTGfWk0hGdUkSSe/+OKm7FrRnyk?=
 =?us-ascii?Q?HIxfx/tjCgjKSHpFKRYbKfABhRN+3dTYBzktRW+aVWFeuCV/UVyGE7S/MEox?=
 =?us-ascii?Q?dsaT/ulm512YDvgO0rKkg749Cz7l0W1qpfrMhK07nwLzg/5W/Thn+id0sIE6?=
 =?us-ascii?Q?xtQFm64pLI2NxBpIWVGIPhwe5eO4jGUETPoJyNXS4my4xBDAErgpSdeNYnwS?=
 =?us-ascii?Q?vXHhJx1OPozuzoUpgwk6ckxQKT0yNBLov6m0HXLCdc9xx6vk21zlXqHM2Hxt?=
 =?us-ascii?Q?mEgqJofJz0RBOhQwdD0T6DP7ICvl6l61rbWttpawnFt1vgU4G/KPiln+s6a9?=
 =?us-ascii?Q?iYEsHnTgOsToQG6GjLi+WyYjOE5UzFFc3pxenQ6QrMvvehrGCyY+NlOWnl+8?=
 =?us-ascii?Q?Ilkn3gjgzXTRJOwrm03KmzkpL5Xups4IlPqhWutPYOpSysVWALkI5ti7CxO6?=
 =?us-ascii?Q?i+8WN0Ef5r0MrdVNmtZ3eVOnyoZNPuXQz8fXP4MgCfo5hmOzGlV57w1dT8bi?=
 =?us-ascii?Q?8KB585Yf65h+C2/LlhMTJfLCfJ6MD6IrhRhNZtqY43YRgkMVi/mdfVV/E2i6?=
 =?us-ascii?Q?yy9vH4JOVcN6wI5W8rlnqzEWv+xjxoHyD8nR9jXRnl3qtI5n4ez2Lgyeb+FH?=
 =?us-ascii?Q?1EDtZEV3FzkgtyS+snfNpyPOZ7DAxWHp4hdz7L0fq3qTDudG1j1B++bCPLM7?=
 =?us-ascii?Q?RFhzT0zTi/NvTglscMmlLGsHLy5UEp6Qqq0uVAMup16I6R10wiTB7KxR7RTw?=
 =?us-ascii?Q?ECU4xtFUjl/mrpB722u56KpGAKlHwBR0sVuF0Px0cVKsFz/O5AjvdwcNYs87?=
 =?us-ascii?Q?MK4pupn+Gzp4z5k7fQvkxirLuMd9pN7fuJdDyH0a5IQAbeR1m+3BI9UPhnc2?=
 =?us-ascii?Q?QVrtA2H3oUx0rebb0o+vbLP8fYTpJdUHR+c5RjMQ8qRbiVICz2U4AtQAlDP1?=
 =?us-ascii?Q?gZ46T9TepDdMX1N1x6XXcCcS7tdC6tLNqVf0IJSuHt9tiJtq/aChSOazhytz?=
 =?us-ascii?Q?oRlkZ213k6XQzGD7/K4NlUz55dt0faqQdzr/0sQuiSK/AQtHKJw58vVUXMK/?=
 =?us-ascii?Q?WpnCrrJQuoxenXPhtAUHROQUKJUThgdqqyoCPe3koV1Mq8LI3pkT6Gu9/TMb?=
 =?us-ascii?Q?UXu32v9VGNI5lnJ4xlKU8fuN7E/hwI1qkaRQdGfaNXdP6GfiNCOnsBbjgPV0?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4mec47zXcPProcCIY+NiGnU8S3Fpr/Fin6nzhRVJGPvui/GiqcpbRmV6zQv5sc462vmNNiuCuKtM62RTAOb/DzYYMWFd80gVszMThogozO2FD0aspFvTjz7ek6KvmlPL80Krw/74geQF+RW/BsAhoa0NTMcD0iDh4NzREI2UiDAuZ9bSrQ/dLwEogpkYQFFXrCWMldG5Y/Vqd1j1ILxPO8ZmdF22TVCrKx2vAbXoMw4U/W3znF62AoDwNe9X0d4/MdzQyDP2OHibIaGUnvR+kqaB0fHFmUksD+NF4eNFCOxn3Ep9pROSvlRfRprdFFSOYbV/44bi93D2gsixnc+1/8pbHRB5fIkJkVNjXBx0b5/S/sFKGY5dbIii6EbsgIqMu3SD4Q+8LkAiwatVJA1oDPTVEdMiY6epMc+9COQngepLEtSFWG6GZ+frDjsjKNwqHolphq78lATofKIhla5ZMbtIrR0lrFR7v817ngwG2ZaZRVrh1cZjWvkit3mc6U7J5/WgEpHIrpZIWGym1dKzV2iyO72gH2WJDqlpm7+WTidO6jiHvsPCGxzjhmqzvnL/CwX4aA8cm88r1BOm/culV5NPAmQqB4n2c/3r4gUUmOISQvKdpauy6TVCKVm+pJUQxEh+50qfcuSqWY2GooD5G72nUq58XOeR8+ijoQ9ip/lifVVYkSxZjyp319T7/0wwPLLEbhZoQKyEu/fIKqw5ONIsfRLwBn3Wn4u7mxGguEjG8XWC0tssDUqsrN/2739WlbyRwyrQTjoGDktn9viSVLEhMVORQNMDvseSQDGg63mKhAcx5a5m1p2F5OhusycJlBS6FQ4ftBDJ172warVkXE4n133ZtIfbk0WTykgOANj9GL2xXxEY/GwIQWVfGNqbJoFLupsxsodcOumQdypKsA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bed4663-a896-45fd-0505-08dbd583e039
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 17:57:38.3289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGvHNBVT02san2Qmdlx4R8mtruxkmTXFwF/28PLnRER70T2uvcvaIBB0h8HvOcR4LUFLZLbCivekTgRsgNb3Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7264
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_07,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250156
X-Proofpoint-GUID: sEP55jheQxy6i7oCZhX1g7VkEObd4wWM
X-Proofpoint-ORIG-GUID: sEP55jheQxy6i7oCZhX1g7VkEObd4wWM
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 25, 2023 at 07:39:31PM +0200, Oleg Nesterov wrote:
> Hi Chuck,
> 
> Thanks for your reply. But I am already sleeping and I can't understand it.

I was responding to "I can not understand the intent." But also I
was hoping that explanation would help you provide a correct
replacement for the existing code.


> So let me ask a couple of questions.
> 
> 1. Do you agree that the current nfsd_copy_write_verifier() code makes no sense?

Probably.


>    I mean, the usage of read_seqbegin_or_lock() suggests that if the lockless
>    pass fails it should take writeverf_lock for writing. But this can't happen,
>    and thus this code doesn't look right no matter what. None of the
>    read_seqbegin_or_lock/need_seqretry/done_seqretry helpers make any sense
>    because "seq" is alway even.

> 2. If yes, which change do you prefer? I'd prefer the patch at the end.

Based on my limited understanding of read_seqbegin(), the patch at
the end seems cleanest and is on-point. Please post an official
version of that to linux-nfs@ with a full patch description, and
I'll see that it gets into v6.8-rc with proper tags, review, and
testing.


> Oleg.
> 
> On 10/25, Chuck Lever wrote:
> >
> > On Wed, Oct 25, 2023 at 06:30:06PM +0200, Oleg Nesterov wrote:
> > > Hello,
> > >
> > > The usage of writeverf_lock is wrong and misleading no matter what and
> > > I can not understand the intent.
> >
> > The structure of the seqlock was introduced in commit 27c438f53e79
> > ("nfsd: Support the server resetting the boot verifier").
> >
> > The NFS write verifier is an 8-byte cookie that is supposed to
> > indicate the boot epoch of the server -- simply put, when the server
> > restarts, the epoch (and this verifier) changes.
> >
> > NFSv3 and later have a two-phase write scheme where the client
> > sends data to the server (known as an UNSTABLE WRITE), then later
> > asks the server to commit that data (a COMMIT). Before the COMMIT,
> > that data is not durable and the client must hold onto it until
> > the server's COMMIT Reply indicates it's safe for the client to
> > discard that data and move on.
> >
> > When an UNSTABLE WRITE is done, the server reports its current
> > epoch as part of each WRITE Reply. If this verifier cookie changes,
> > the client knows that the server might have lost previously
> > written written-but-uncommitted data, so it must send the WRITEs
> > again in that (rare) case.
> >
> > NFSD abuses this slightly by changing the write verifier whenever
> > there is an underlying local write error that might have occurred in
> > the background (ie, there was no WRITE or COMMIT operation at the
> > time that the server could use to convey the error back to the
> > client). This is supposed to trigger clients to send UNSTABLE WRITEs
> > again to ensure that data is properly committed to durable storage.
> >
> > The point of the seqlock is to ensure that
> >
> > a) a write verifier update does not tear the verifier
> > b) a write verifier read does not see a torn verifier
> >
> > This is a hot path, so we don't want a full spinlock to achieve
> > a) and b).
> >
> > Way back when, the verifier was updated by two separate 32-bit
> > stores; hence the risk of tearing.
> >
> >
> > > nfsd_copy_write_verifier() uses read_seqbegin_or_lock() incorrectly.
> > > "seq" is always even, so read_seqbegin_or_lock() can never take the
> > > lock for writing. We need to make the counter odd for the 2nd round:
> > >
> > > 	--- a/fs/nfsd/nfssvc.c
> > > 	+++ b/fs/nfsd/nfssvc.c
> > > 	@@ -359,11 +359,14 @@ static bool nfsd_needs_lockd(struct nfsd_net *nn)
> > > 	  */
> > > 	 void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn)
> > > 	 {
> > > 	-	int seq = 0;
> > > 	+	int seq, nextseq = 0;
> > >
> > > 		do {
> > > 	+		seq = nextseq;
> > > 			read_seqbegin_or_lock(&nn->writeverf_lock, &seq);
> > > 			memcpy(verf, nn->writeverf, sizeof(nn->writeverf));
> > > 	+		/* If lockless access failed, take the lock. */
> > > 	+		nextseq = 1;
> > > 		} while (need_seqretry(&nn->writeverf_lock, seq));
> > > 		done_seqretry(&nn->writeverf_lock, seq);
> > > 	 }
> > >
> > > OTOH. This function just copies 8 bytes, this makes me think that it doesn't
> > > need the conditional locking and read_seqbegin_or_lock() at all. So perhaps
> > > the (untested) patch below makes more sense? Please note that it should not
> > > change the current behaviour, it just makes the code look correct (and more
> > > optimal but this is minor).
> > >
> > > Another question is why we can't simply turn nn->writeverf into seqcount_t.
> > > I guess we can't because nfsd_reset_write_verifier() needs spin_lock() to
> > > serialise with itself, right?
> >
> > "reset" is supposed to be very rare operation. Using a lock in that
> > case is probably quite acceptable, as long as reading the verifier
> > is wait-free and guaranteed to be untorn.
> >
> > But a seqcount_t is only 32 bits.
> >
> >
> > > Oleg.
> > > ---
> > >
> > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > index c7af1095f6b5..094b765c5397 100644
> > > --- a/fs/nfsd/nfssvc.c
> > > +++ b/fs/nfsd/nfssvc.c
> > > @@ -359,13 +359,12 @@ static bool nfsd_needs_lockd(struct nfsd_net *nn)
> > >   */
> > >  void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn)
> > >  {
> > > -	int seq = 0;
> > > +	unsigned seq;
> > >
> > >  	do {
> > > -		read_seqbegin_or_lock(&nn->writeverf_lock, &seq);
> > > +		seq = read_seqbegin(&nn->writeverf_lock);
> > >  		memcpy(verf, nn->writeverf, sizeof(nn->writeverf));
> > > -	} while (need_seqretry(&nn->writeverf_lock, seq));
> > > -	done_seqretry(&nn->writeverf_lock, seq);
> > > +	} while (read_seqretry(&nn->writeverf_lock, seq));
> > >  }
> > >
> > >  static void nfsd_reset_write_verifier_locked(struct nfsd_net *nn)
> > >
> >
> > --
> > Chuck Lever
> >
> 

-- 
Chuck Lever
