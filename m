Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F3B77080D
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Aug 2023 20:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjHDSil (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Aug 2023 14:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjHDSiS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Aug 2023 14:38:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45CB4EE1;
        Fri,  4 Aug 2023 11:38:16 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374HdXju004299;
        Fri, 4 Aug 2023 18:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=CzhvFNH/xJMYJJhGWfwYN8UEAVWTtwHWYCZ/YT5ZRBs=;
 b=1bbnO1K55UuQ5voBsNtzkTWrKZJx980eBaxrHdRQESy1uRaTlp8S/mlnaxnzN/VVY3iY
 7YXAS0ObzMiTJhDk5+FxVDusUD4BQiM2sbjnTpG3TusfzVkNbRvQgKktWx7RpRrn5Zw7
 xNKDB0sNaEroxYWjtuj+BPV8b5j/yOQT7nnoM5GNojXBVAkoSqIvjUWdnQU6PFgQVDsh
 5ylaiHkIeNA4hv48VWg5U+t0ezqPKBuovhcwjZfV1SmPNY6E+lt0KnAJOyhe6rfY7/Rs
 QOzC5BsdG/ahuU2npTfHQy76xGe5jDKxIMVeNdUYmgU6IskIOIY4jymPb0hDuvo6trwP 9g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spccfpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 18:37:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374H1mCL012220;
        Fri, 4 Aug 2023 18:37:57 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s8m2s7t47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 18:37:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzqIo0EMiXojbj6NNyVTBpCSH1h7sOBiJEa/6YbrvtmGlopL3uTdIOlTE1ElZD15usS0G7OskutF4NVRAKQFg5eLOnYBlEI7O8EN/6xUusTAVJWkkkBrcP3+usIRzmsZ6OwQ2gO+RU5Y7k72jnhnG60CwOhh+3XdDMjzwGWHo6+jM7QFStAkS7f5KgzvAFoWrUM5LkbPSeZ4cJcvgFhdTFp3OcegJ0Z40Ud59Zg1WqVe1kewmbeAZz+sGm0s4A6RD8Fd60HKQGQxFRS904RiHa77k8bU7IHlE3EFG57qOWrPw2LWXTLvZeqjBYRt1liPLNGWFqZvarbei3+mldtq1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzhvFNH/xJMYJJhGWfwYN8UEAVWTtwHWYCZ/YT5ZRBs=;
 b=NKE//XXG+nSCHuCIbNq9PwVJPEYgkP6cRFqY03En3v5/tX9Dg4fXRoLT28AG2AW54vqGUUpgVWGAykKos4+Ph0/4KxQZRwwz1hUIRkADb09aJpqQc3W/YsH2zj+xA5g6aCORODva+eVY0USv9e5hJ8zqTm1yRkYrvJO+gXy0ErYwiJej0XXDCaIT9gEjp8+ZnLsngEkuJrkenUIweBxe36otVzKEGSkB8i4DsGar8CbxVZMR8iXZLbI7u3KxwWPAbgiWOWlUQWYU58E2C0eR2Y7bb9wu8A51DBH4/DfwR/S+gDsteFf8YECVBcAQ+P4s8vjpnc33e+WImArX52Mucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzhvFNH/xJMYJJhGWfwYN8UEAVWTtwHWYCZ/YT5ZRBs=;
 b=Vni1syAfD5Xi8xUsexqPz0ZpCAud0R2thabsHtbDgm1qSfE75iCTYKmvL+nEsQk9ihyZikF9o24H0UMm7PJ74zXX3vDBa1hGUmGUoW7XVry+v1qjw4XQRhYfsa9Q3hEoUZr6Pnqnxw86mBY/YqImqFBU0mmRGGoNi5eb8H7DynY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6250.namprd10.prod.outlook.com (2603:10b6:510:212::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 18:37:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 18:37:54 +0000
Date:   Fri, 4 Aug 2023 14:37:51 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Su Hui <suhui@nfschina.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, bfields@fieldses.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] fs: lockd: avoid possible wrong NULL parameter
Message-ID: <ZM1Ffz0UpI9ouaeC@tissot.1015granger.net>
References: <20230804012656.4091877-1-suhui@nfschina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804012656.4091877-1-suhui@nfschina.com>
X-ClientProxiedBy: CH0PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:610:e6::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 81cbc99f-65ad-4293-7eae-08db9519ea6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S75i0fHl8mZfbeXl7613nf2AtLDUD8bhOBdYIE51sn8iW05nJ54xJPqTUZLlZVt7uQ5Y6gDzoN8PQXu7foi2wgpwWlwtZhBiZ7bSE87TDPaPrERrMNW0JAk1j5ErD5qCXhej6A2x9VrT5i3ZYOX4+i1ZLX2/BsuYvsyASU/njHaxNIQFeLOXoGmUWyGK0314XjR83RG/Fx7VmnOgyzg87MS24wZCr7GnLU64mBlcFkvn2eDs+rYBeSmroj2C8uPXzg/Qx4a3v3Y/ei1p1vVe7N7dzVIedrHYM+mTyO89rC6bIplvwnlCaf/PbetGLrsw36p6oy8HBjC/oDbHAfTx5Z2Ory1ySaQg9Q1Og60D/66W3oEBcrBwzuubvDbFBwEThs0itV1Pfca/gmw6PeHzgfa3yF85xoeyyKHNan/HlL6TefpUW0YAlxP4PHaMUnG/n6FMwcECbUveg0xQmctthd1rpSzp+97xLWmzl6qzX6bAye7bl+44cAA1x0cRXlVuQycCu1j214v6LYNhd4hBCntDkhJtlfbGjCtoLDSiEfHm2W75pmsmDHu6ZwL02Xym
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(366004)(376002)(396003)(186006)(1800799003)(451199021)(86362001)(83380400001)(478600001)(38100700002)(26005)(6506007)(8676002)(41300700001)(6666004)(44832011)(8936002)(7416002)(9686003)(6512007)(6486002)(316002)(66476007)(2906002)(4326008)(6916009)(66556008)(5660300002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5d8RyMfc2I5Rn8Bh5HpK571E8LVopljDCvMDduMCe0E/EnKWEoVX8LtYIvh+?=
 =?us-ascii?Q?mFC116Xhw6PXQyOkb3jg2biFozJffaDFdJvvuPKUrGyryYGAv4iJKLJ8Ohk5?=
 =?us-ascii?Q?VOzTr/vMCkeSAOetHpL6iQ/oDQrYqpPdHQnFj44czMUdVmoy+bzeCyJXt5AE?=
 =?us-ascii?Q?IihJCEXJYAdz7MlO9GlLiZ3E9XjaJdkbRxxfZ/DE3Xq9IV3YBYh+GHyJ563p?=
 =?us-ascii?Q?s7MoXQZQvvNR2aQjtvJXOsELfE7dfxPFvoI7VW3Ym5HhLt/KMsKcnT+CqoUO?=
 =?us-ascii?Q?JvEVhTkAz6gXr9c1kD5dMP2JtVKn6LQYRl0Wm7U5XOeg/vX+XIg6m+s8OwXU?=
 =?us-ascii?Q?NMUJvlVqVmalA0iQsyogvM/R3bdvdFcxpk4HKiwUXZ/bqy5NSxvpT+mM+n7j?=
 =?us-ascii?Q?DlmzEtDdgKSKUpdabtWWCDkHAwfCpz89SGkVLKBB4TbfFCd94q7wbLuvom9L?=
 =?us-ascii?Q?IcibGZ9VbZ1/xgym5FjUrdFKdgUhX2lxzF9BG8bgKQYQJ4ODyXTiu+w8lS7w?=
 =?us-ascii?Q?n3rEEv9teivZ5LuGXF1rPtY8wudpANEf9zJaoqiq6Lrys2WmeQWuD9WOpBuw?=
 =?us-ascii?Q?NahfMzOfqMw2rZIlEmNBXLI7Yd0A4D1S3tKotGjGLdpvVtFtKLCwyKoZcQPJ?=
 =?us-ascii?Q?mRHi/KAOIdc4MzA+schAo3xB4z0HClFeqR/HFI0CPhI1wqBa6/Y7IpQ5Fu2a?=
 =?us-ascii?Q?pYw0Xmd9aDOuYDnw6XB9DdAO1bNymcPYMEa+OKIBGjv7/WNk+DM137DHo8CH?=
 =?us-ascii?Q?rn6kU+CkbcnJTpZ7KHCrCQNwdBWKdynKf8LURDSQ4xIGkGFFCwXF0C1Ri+d/?=
 =?us-ascii?Q?QD2Bmtp7kiAjQrfXABuI9BVpW72trUORUKKUKy/QVqzKuHhpj0u34XlMxKhs?=
 =?us-ascii?Q?80p7L3G3k+Y2EfI2dyIz+1BwWOVKZtCOoZejfQXfeKtfG56ziRL2y/huWJCB?=
 =?us-ascii?Q?4UnneuFBPk11O1vFATze0iNVFowuBFp7ct3VvdXA67GVIxRJWmqenxmgr6ex?=
 =?us-ascii?Q?e1a+w8hD3tkyUxY8h0/vbGiR0/fbppu8sTE5jsg2J7Kfv5vShufNSuvV5A1j?=
 =?us-ascii?Q?UICWQm3uezlbFpuojmBzRs8T0T2AG2FbZPbKlJyr5tR7OW5vxl+sqdJ3gJvG?=
 =?us-ascii?Q?qWXee/6+Ri9El7dY/zjWWwMzyZSvZiHBW6zB+mlMwR6yfvugfj+M5B9bjGbQ?=
 =?us-ascii?Q?ISgPrw6J486ivENhX15mdee7WWPr9dqmwC5M0P9MeS5EjgKzytHbDi64aC72?=
 =?us-ascii?Q?FwjkoRBhlL79Ps+nfjHB7gHtxpmc2C7TeP+Vbgjemq7BvqNwgWXnIQepm70c?=
 =?us-ascii?Q?QsgmSaIKVWuzW1zEKVFWC3ZreoPlEUh46uI7s3cxBQUeooo2nkkvT1mQ7+NS?=
 =?us-ascii?Q?UnEOv0rWJOS4lEsCSuW3LATVCBusCGbtKC66DeWqGCSoDWFr0LuEOyMowoFo?=
 =?us-ascii?Q?128MciXieRPIvzZS6HQIpU/N8E4ndPRwiLiryTL1ZZq9PegYSm2LavfTnQi6?=
 =?us-ascii?Q?nzJcsLUxyRDhltlwbBu2w1TcgueUHM/NmfIlB7TWPBEo6TdQPkNmDST1Qtev?=
 =?us-ascii?Q?Wlp2HpxYp7K8hnQXVpIsSg4+JIrpeq2rfPxCnYWLs8Bp98+4DI7MirSD8zcn?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?eq2v/6DT9nnz9szoOL6uabI8fni6na5ijnQ8EA43DkGr+dOK2/SRRkq6Js43?=
 =?us-ascii?Q?DTCbi5MH9TXkpf3y88NyFZpYLDU0e9Wg7kszEiHJAdFBRQKnrPXor6aohVS8?=
 =?us-ascii?Q?4f8toskGWvMXfYE1MyNvdYm41h6fVtTUfNgutxu/Ir4KpVdR+SxeQ8fkTbzt?=
 =?us-ascii?Q?s/jwY2dKECSm0EUE3mizj/GQQHKnXYSpNsfHgy3AddezMhrhAoTZlDsQDTSx?=
 =?us-ascii?Q?0orcjKhOQxVpVBC18AP3YxjrVs1UI5gCgIrvF2mGZslH+pKS4RlvEZ9MzM7O?=
 =?us-ascii?Q?W2Q4W8NcBwydw2vuaWmyd2U0sv4OaX6FNP/PmUeTqw19WbFzjChnnHv3wqKr?=
 =?us-ascii?Q?RRBLgkV0N/YKdFMDQTHSaMz9uZqAPs+3ZLPsBpU3LW9qXsj06HFEB314ktUC?=
 =?us-ascii?Q?XetB7b3euXHM57lBgrUTabhcBe4JTWTXl1CClPVBIY6FQC+TG4xkSx8sg8WU?=
 =?us-ascii?Q?+yqdTzJcubUMmzbF3sRkyJbA4IblAVvqOEaD2hHX9H7UcAjJ0F4aC01DxG5H?=
 =?us-ascii?Q?cRqtYbN07qh0K9tejeaM5LltBHxz++Lz6nobNVCO9gEsEQ/ETZDwlXC5EbGw?=
 =?us-ascii?Q?xuYpTzQUiFCE+doh/qJB94lnXfofJZp6EtvEZFNpR52VgcsLKNaUpOjIDm9q?=
 =?us-ascii?Q?LKPS5n+g5ZywP6JAeVTosaRHHsQWX+IsJBeOaS9WpT5q6XwE03MST3gCANNr?=
 =?us-ascii?Q?UvIjKTBVxx4Gp74VB45PgxIcjRfmowXuXFlWxh6wXOLysbXIRnSjT5d+tRS1?=
 =?us-ascii?Q?OjkHtZ03iogvDxSgDqcEieKM0mq5Jf6gdr3+MkXqwH+fVW4ByiGdDW0vkr2l?=
 =?us-ascii?Q?xewLkijg+xiFsXXQVkuAEv46ML/9K0+EOLu9clmWm+d90KDgvClBoyArEllD?=
 =?us-ascii?Q?u1mtHI2SVX48vdQftMUiAUVzE1PIPFO89pxnzwDcoVum6OW5M59GHBWAdD8S?=
 =?us-ascii?Q?GgCdoLOBzWpr8n7nmPuEAMMblTDKr2iTsFaTurbtsV+g/Ga8FBq1Vlu8Cgx3?=
 =?us-ascii?Q?xVrFy5eLMMgBvs/zeGT+V29o1Qp70SxfaEdWbmK6c0p3chAUeAqgZjypSI7Y?=
 =?us-ascii?Q?8xPgccSbC+6xNE9qbU3a5mQHijjZ4Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81cbc99f-65ad-4293-7eae-08db9519ea6b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 18:37:54.4191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /q7xsj9Ya5NY9AVve7h2gPXpS2WIaEriBw62hrMC6LqWOj/SeJoBkLc9nIT5l7bQ9MEIexd1Xgm0i4EbAotsyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_18,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040166
X-Proofpoint-ORIG-GUID: tf6YllqPhCmean6V-NjZjE0-ISWt4loO
X-Proofpoint-GUID: tf6YllqPhCmean6V-NjZjE0-ISWt4loO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 04, 2023 at 09:26:57AM +0800, Su Hui wrote:
> clang's static analysis warning: fs/lockd/mon.c: line 293, column 2:
> Null pointer passed as 2nd argument to memory copy function.
> 
> Assuming 'hostname' is NULL and calling 'nsm_create_handle()', this will
> pass NULL as 2nd argument to memory copy function 'memcpy()'. So return
> NULL if 'hostname' is invalid.
> 
> Fixes: 77a3ef33e2de ("NSM: More clean up of nsm_get_handle()")
> Signed-off-by: Su Hui <suhui@nfschina.com>

Applied to nfsd-next (for v6.6).


> ---
> v2:
>  - move NULL check to the callee "nsm_create_handle()"
>  fs/lockd/mon.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/lockd/mon.c b/fs/lockd/mon.c
> index 1d9488cf0534..87a0f207df0b 100644
> --- a/fs/lockd/mon.c
> +++ b/fs/lockd/mon.c
> @@ -276,6 +276,9 @@ static struct nsm_handle *nsm_create_handle(const struct sockaddr *sap,
>  {
>  	struct nsm_handle *new;
>  
> +	if (!hostname)
> +		return NULL;
> +
>  	new = kzalloc(sizeof(*new) + hostname_len + 1, GFP_KERNEL);
>  	if (unlikely(new == NULL))
>  		return NULL;
> -- 
> 2.30.2
> 

-- 
Chuck Lever
