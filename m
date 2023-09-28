Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E7F7B1F40
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Sep 2023 16:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjI1OLB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Sep 2023 10:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjI1OLA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Sep 2023 10:11:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EAA136;
        Thu, 28 Sep 2023 07:10:57 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SDgrT0006149;
        Thu, 28 Sep 2023 14:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=wVic/FIJHfelKs/lnGVOxVQEMeTduAsg/81Imp770E8=;
 b=kWSiGxQHd6OJHtQAUi6GsNzUI+d0vqJv9MJSyhymaXQQ8mDvpJJCjiit1BHNYQsx5x3S
 vh3l9POIuFqCu9XmDJVrh8GCeP+gEMRJgP/VttUsAOH5HS8Ees2BNaYsCXi7rEQDtoc8
 QDuA8gep8obxp9ssDWMyXqUoxdaulIQMiyqoQ6u3ErROtlSWyCjTmZ4qkw8ZJI0ehvWm
 vZTJo9IzTxcPHp/WzSr8iTKZl2WVjEaP2ITjw1qJmDoG4ylV+wu8yZkJJdxhFhON7Cn4
 SacM5pzexicvPAQei1fF3vGtkZOBloyIl9a9cWk8jpMR8Bwp16IIZ0iw8rZvvRmY3BCD 7g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qmumk4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 14:08:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38SE8j1h008209;
        Thu, 28 Sep 2023 14:08:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfa3qb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 14:08:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6BRcZUZwgrmfrwkUdV/GctFkKxvZ6Vy8P18YAaC0ml+Cp/K774b5kTcjouiQFCTDZaaE9jVb2GAf94FVfzFkKPV7ZfPmOGlBBmybUBu88jYK/awbFIfRVJ6g/U54eeBe7yngWXg4mJ74sZ7Xa5SPiIgqEceUPo5cmKA4J1mWQPkJFk9tN74UOvh/kDUgsY/8iFUd6ixzqiKNZXYpRK5eYuEVBvhw+UIgdx8DFYxb62w6y3IP+xe5Ztkm402aswqnWzO67FdbF5o6L/XmgFIdkgBN9/mEm5OTIswb5XkA1T0JKYyGjOy7qO1xfcVgYEdRsOYa7JQkpwiZSjjLzbpUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVic/FIJHfelKs/lnGVOxVQEMeTduAsg/81Imp770E8=;
 b=AGFsF6jOIb1dZf+HAP4y/b2L14oLVGEe/lNcDmDGg8qBVrwoQllyfnnZCQWFTZRaM4bzy1lDXIohBoK8wRk7pvlRRmcXS2S3ElKpQVLlzW388yXt0skb9p6gA6nXt3q0QYB1UXXXziepPX0lhVKc/pXA+xmWyZnv9X1Qbkc7rbf7viLM3UWZMFZH8zGO/7KRwOSSKrvzKTXjB6oQ6bTYPJkQFmQJc+cC/BCkrBi03/rv/QkiVHaQtvCbLDXm5zyRWPzi8/dj9ri520vlYx0ODbhUtF97nda3YkMsU/NbghqsJKeyCIit7i1b7jYcHbY2xrQc7lNNGYSg+HvPdmIVXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVic/FIJHfelKs/lnGVOxVQEMeTduAsg/81Imp770E8=;
 b=iFNX2Ibmnbv1GEXshNGpt3Ii4yqD+HYJBEP11+y9L6Ch4AGl1UU+czZ2UQL5HngKRorcKSFzaU+hVoVEH63i2qmBECvlPla0rg66Et9lNAliJd7unFoVh5qyI2/yXdn5A+UcVbMC4CknmGNaEN2hrIk6SctHIEaCzkYdR7fIgxk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5836.namprd10.prod.outlook.com (2603:10b6:a03:3ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Thu, 28 Sep
 2023 14:08:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 14:08:34 +0000
Date:   Thu, 28 Sep 2023 10:08:31 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     KaiLong Wang <wangkailong@jari.cn>
Cc:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "kolga@netapp.com" <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Clean up errors in nfs3proc.c
Message-ID: <ZRWI37mzhRaLWIns@tissot.1015granger.net>
References: <10df416a.8a7.18ad9b33756.Coremail.wangkailong@jari.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10df416a.8a7.18ad9b33756.Coremail.wangkailong@jari.cn>
X-ClientProxiedBy: CH0PR08CA0010.namprd08.prod.outlook.com
 (2603:10b6:610:33::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1d3eae-325c-413a-a0ec-08dbc02c6710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MUPWD06TpC6vZVhUNDY344my9WL8/EzkC/A1wC/KgBbN0YeZ4chEXIynvG73SIxoDgMPK2iXcNpyslH1nxgBPFqyniOxtm7SgXj+pOT5SWaA0RUNeTwaoSZ8WT2DlWt+qs4ekap31bzKJd6FV49fwssJxVYOZuppi4onu+cZ3uVG4I6ElbnbPT131RxGo7IVnYF+GvSm9TE1hSX/ybcMUxvZldCmyGMiw3uh000DNc9gDyZL1RarmHWbDfD1DRcGz+50EF/5QaoxXdzPcaN/Vh9HOAjxAFWV4eas7A5KhddN3POwr+JMQ/p/MXgBN7OJuBEI7hwmioCovfcSITSiGcxdlhNDuWLPi/l9t33BMvtgqHLQNI1C3t0lVXCaEwKUOD3P+h4MwLcygxit+IokRj64dGF4bd+aEg+VVWfGYxHNKT8GLisDFQHto9fELvkZGp47cSamvUdxrhYo4MrZxeOw0aabfoomjO+g4sdL6QAkxYDGwk7rD7/gUNsQV1dIqCfII7C3NJD97isqynG7CWOKzW+VurdLyOW7zWDJXcXW8b9IQlcz6/Zqepl4DzHqN0qu6QO4AZsxiu/+z9+mokvhZ8SpUh4mKjykyd/M6Og=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(8676002)(86362001)(83380400001)(2906002)(478600001)(9686003)(6666004)(26005)(6512007)(6486002)(6506007)(38100700002)(5660300002)(41300700001)(66946007)(44832011)(4326008)(316002)(66476007)(66556008)(54906003)(8936002)(6916009)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aeBC62sxPwoLZaz1sNWggaDhJtIwa7KSQKq8+NLvH8YG3K7pqdj1Eignm/9s?=
 =?us-ascii?Q?kT+Ns9UHGlmNVcr9MYrVzAhKinFOH4bjRPR207KoWtHbuP+Pz6L0zMeTPDXm?=
 =?us-ascii?Q?Obp0QyLoee8qpGYavpVbDd1KYrXqtU5BlhH5+CEHlu6IM04GPDOEuBqmMGSI?=
 =?us-ascii?Q?VvzP3I2pYXlslS2EQWF/ZrxQ+M3S8Qol0epFdRXYrEsFyJnzKBdYBe8eICiF?=
 =?us-ascii?Q?bIEmX9NeIq97GnB+Wan/bSQ2ZupMoxbFp+0/+//CVPF4Q3X6ffAwzUnqozfJ?=
 =?us-ascii?Q?H2MwZL0wkPmaR2vxyp+7kZJ+38RV1fWbCbpfx3PNffya2/Wy1nhPloQl/M/W?=
 =?us-ascii?Q?TqhWLa6mSrcEcqbMMls3vhoM5GVZgEpREGoSUqvF8brsJR1o8s29EFZP+5yq?=
 =?us-ascii?Q?nCw2cbr7FUwCKUR4Gz9KsYkw318NgwgAEObkcKREzHZybj9rS+hMbSZFXLoW?=
 =?us-ascii?Q?GlgwjZhh8GT5vKmtplE1nNp0VFU+qqKxmNIuhoHu+Pu5kk/FkcbpYsmoA359?=
 =?us-ascii?Q?7GyjnEZfh9deqxqKpxgiGp0KIYVZRZMgtMgUXr8sarqZkYLaXN+Jnyv4MRgc?=
 =?us-ascii?Q?+GU0ZFsXw5CyAjTk/2A3IkMGeWl7a2U8MLMFGo/XS8TIBW2UFk0+DBNFwlua?=
 =?us-ascii?Q?STTB8bDan5wFr0RIPDtY1QAq1BsQ1bTLcnvsr4Ag+306DeePEJRKw0NNRk/x?=
 =?us-ascii?Q?u4OL3CTUq7Ik1K0i5M+hi/Dkdd22b7rWH9jV7LAvb6IwRTAzUQbGZulDjCaM?=
 =?us-ascii?Q?olaotOE9riAjB/rfu+ELN5UY0iYqKQNHsBQoIM/BLTZNfmUIGwudhJrdnXX5?=
 =?us-ascii?Q?86CuuR3bL2hVOGKui4VOMN1PsdND+mWMzyL21fb46SX0ahrMkZU4jTbFJrSS?=
 =?us-ascii?Q?6g9WYl0aJczN16Jr3OcrlYGSslUJ3TY6Ux5Z8ye96Sy/e3PvgByoDLqfWvVx?=
 =?us-ascii?Q?Yqd0bwAc6s6UdBDpnqLoda1OfwwLoBNhe5CXp3uUurcbh2I9M3Mrrt3hZOYT?=
 =?us-ascii?Q?QRTKMzZIs34sN3vEu+abF5vtjt4fU/iFa0W3/R3JKjH0BsQQMJxKy0jphuJf?=
 =?us-ascii?Q?TwL+Xux3tDPv5YOpSsv+mqvcRK4t2sg4R+J68wypm0mYZt3TYobXZMPNNZNh?=
 =?us-ascii?Q?WKg3QPzt2veUaW5qeZyK8qPlNFjAP2WWAo5dXxlxKFDia8XD5J5FxINrSe4M?=
 =?us-ascii?Q?0sgzLjGYJDqWIAso9+T3Ya15XIGKFJRg8rPeZQn9CDd8reDx0TFz4P73Lk2Y?=
 =?us-ascii?Q?gJcP5B3w3qvBUSrwhk10l0nzI4E9r7vsACUZBhCJBq6mFHxVGCj+FBLRqtPN?=
 =?us-ascii?Q?wNkP4LgSTU/S2azsp1MTL/2rXHPfbdNH01+ybmgZPDLCIhXVPz4dRhq9Z1d4?=
 =?us-ascii?Q?qr7SYIsjarczrP4T9i2SWpOsVcET3aRVQs2/eTVN4bjE2hm+3ZUJ2VwsmV2x?=
 =?us-ascii?Q?zWm99757QJG+zZFfdKsYFev3zTlGg9GrcGJ58tb79+56XbDf98u8kPf7KjpE?=
 =?us-ascii?Q?kNsCvGoZYFf2tfuEhIj7p0bJY+anJFtCgbr3iGszEpYMnUwAkJxNV/qBuoXl?=
 =?us-ascii?Q?nO+UNDu9UctyJfdSk9AJpazVXtjlCLZqUgtidoFC9XHfPKo38Oy8wnDiGfrJ?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G2U4fb4l6NDl6cCdXL1v7Nl6JNTtIRTxcliOn/yNDCFeKiiVL+viMx0Qal5ALMMUTmZteBOHmOjjZIU1jbRrCorJWoqbwn++ew+hrbrg0/PicbqoxRk9mjXNs83d0vx9G34D6ziXEVTDHWLVJnGm1kfP8hVWc3l8xDeTDYN77cu+E+SsHiz1dX2a0v96resW8w9BwSIUGQUYsAuyx1bnkz4Ubrj7CqksQJVtW+WolBXIIuyib0Dl2JX6KTrwNE6UCMRtljcftNumiqNfCphNa3g32ZDoIEoQ2N4n5zdA2rPB+/UQAl7A9L7nzXuGeXxUuf/3iZRbTeNXX/17IBHTYJHO4DfBUfGP8thRGb+WoNtBuK2wnFmrGeJbNpvg4soBixDCJFYBbNL7UhOM/OZqnyYsAXbvXM+D5D5igFXYvQ8d2DPDWC90Z1gAeFRLTnAQOEB3FUJ04wJHqN7/rFeVJ1PjdNABvyilgB3ivvdzJ6QFPVLBIyxfU6Sc6NPwpYs/f2tsTf+79JfvyF1qyKRpyWcfNmpTvRKpMcbqvpPkqb4brPOpBl1OSKXXiI2hFQ2b+l9b9x+agCINixfioSZFj0fjgiF7RwjQnQP5JwnbUunWj65OYP5qeOlEFXPH2d58GC5OZU4ELv80ruGofz59jaVsQaMEqLW6Tdu59ZMf73mBZ3JJrIG4iy2QPskBiVBymZ18PQAjCYVq1T4VZr2GlkJDTIWD/3Nv333hBBO3nd4+9y66t6h1IOpAFl9OZHWQWdZ6l4WIcPxYmmZ3oxwFN3BCQwPw4RaDcf1EHIdQoFFEDF6iJMn/oIX0dfCM353UYRNU44dpsIQOLBjjmieCL3Sh3O4Q3Q1DgZei2Munb6Z+twQiKI//gv4NB6R4IWZSzxh8H+rL7mrIrOYfRCQkKA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1d3eae-325c-413a-a0ec-08dbc02c6710
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 14:08:34.5494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNHBL/s9xOYiJPLWRgPosyz+3ej9LvzvsdQvku+vf4L2SaSi7fD3P/A8HD//DwfZ1BB6fTvRWR5D/m6c3bFxFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5836
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_13,2023-09-28_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=936 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280122
X-Proofpoint-GUID: tX28bMfHq8yttLlD09VIZIHp-9CrlZYm
X-Proofpoint-ORIG-GUID: tX28bMfHq8yttLlD09VIZIHp-9CrlZYm
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 27, 2023 at 10:51:55PM -0400, KaiLong Wang wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: need consistent spacing around '+' (ctx:WxV)
> ERROR: spaces required around that '?' (ctx:VxW)
> 
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>
> ---
>  fs/nfsd/nfs3proc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I've applied 1/4, 2/4, and 4/4. I'm still debating whether to apply
3/4, that "char *<tab>variable" style is used everywhere (though
I kind of agree it's an eye-sore).


> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 268ef57751c4..3dc1386e30bc 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -171,7 +171,7 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
>  	 * + 1 (xdr opaque byte count) = 26
>  	 */
>  	resp->count = argp->count;
> -	svc_reserve_auth(rqstp, ((1 + NFS3_POST_OP_ATTR_WORDS + 3)<<2) + resp->count +4);
> +	svc_reserve_auth(rqstp, ((1 + NFS3_POST_OP_ATTR_WORDS + 3)<<2) + resp->count + 4);

Since this line is already longer than 80 characters, I updated
this patch to split it.


>  	fh_copy(&resp->fh, &argp->fh);
>  	resp->status = nfsd_read(rqstp, &resp->fh, argp->offset,
> @@ -194,7 +194,7 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
>  				SVCFH_fmt(&argp->fh),
>  				argp->len,
>  				(unsigned long long) argp->offset,
> -				argp->stable? " stable" : "");
> +				argp->stable ? " stable" : "");
>  
>  	resp->status = nfserr_fbig;
>  	if (argp->offset > (u64)OFFSET_MAX ||
> -- 
> 2.17.1

-- 
Chuck Lever
