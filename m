Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1700C7D9D7F
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 17:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346247AbjJ0Pxu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 11:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346223AbjJ0Pxt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 11:53:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D193B8;
        Fri, 27 Oct 2023 08:53:47 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDUwwp003266;
        Fri, 27 Oct 2023 15:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=ToPeVqvAKMhfHoa8ZlHzrNE5BfWRnTaEQxQWhJViiU4=;
 b=FgpV5AB3xnoPJV+KAuz9uJyF1CwXlY4+qsx/urgcGpuDOL7+3y4MevNuvxXMZoAu9lS5
 T4JmEnN7uWMHu27CVGhnMK/CrqcasCr2QdcvW0RN7BBJX9No0naET3Xq68I7isSq/Nke
 a2Ymz/dKaAtuVUIQSpFpOigTwS3aSUNMOWdixFxdIqH6+dUhUZZ2nYTipuN5JozvZoW6
 UWGyzv6lFra/jovM24QLZvgVyFWa0Gp+nto/DwbIRV4Uqtfc/KH5tOi0SPS9sayjKlMC
 7SnqmDPARMY3OfFY5GJehK8c4H7l2Z7pyLmkS/9buVgSYnwyHbn039qBpGEr4oZrW8ML +A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyxmv9rn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 15:53:09 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39RFUEtK009243;
        Fri, 27 Oct 2023 15:53:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqjx5eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 15:53:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXL/lVavhe8ZrmjyLF8JMB3YCLZD+4pZOMWNMZszDCOfioWPDIasNcDqf+Laj7F7aGmCLGHZyYzpqHetqvpY1/v+tM1loucgdUj+EB4U5adEYiOGfOuTohNgrAgnSZ2w09Qs41Z2iUH+9m+Yyb8pK4hFqHZfrPwVrPhYCuTfqAEQEEB+y3fSjaKkbfxHk63kiejjQFWo3fqb3nPhrrPNxHsEMW29XhF6X5SbnKF4G29U82qZYZib4oQILOgceBiE5zdtBXxLyKBZ0BkZfF+R5y5+C9i41QvwWReHOsRCCi/9UznB0SYsSeqpycjt9QDazxB31QXniUsZces6BzsgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToPeVqvAKMhfHoa8ZlHzrNE5BfWRnTaEQxQWhJViiU4=;
 b=i5UkEesVAYzydFnExkIyZOXulrS/ftcHfE2u2gXKJB+JdA795VeHoSwFsO8iuacSTfCOTChMyPzxE0T+Ffvl6tRft3slpDq6O49Qhp2Tt1bFdN5M7rtYS9RscH9x9i1LoQFyuHMfawTq9h0ehyr0uDg5zrM4E28BZ7UWzM4fsGuHJ7bCUKzHPrAEhleBsG1svNA4WvQNE0aREuJO+C8Q1+YNC/3rX8vfFU4DBLt85aOEPTEhXIBgMmTGmRoFWSmkLCRapKumpul1pHvL7BazEYlX8jn9Au3X3GYW7GzDCTjNYHDu3mESz44r91gbDKfnycZjmzGWlG2QK/EznpMt3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToPeVqvAKMhfHoa8ZlHzrNE5BfWRnTaEQxQWhJViiU4=;
 b=MNM+MYq2LhD1vKiQWM7WT7FvKnZSBn8VSywOI6pSMIbSYLN01zjeitLB1J0vgez3g+Mei0wvIct7yDpBVTcWZU0QTPvnu6N2SwNfI0wnF4CyKsSWFIn/pgaA/RkH9ngYzVkG1b6gf7Ush8TDr49fHZZ7bx1StU6SsxvA8lfxLtk=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by PH7PR10MB5675.namprd10.prod.outlook.com (2603:10b6:510:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Fri, 27 Oct
 2023 15:52:54 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::3a93:ba27:cbea:c6d4]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::3a93:ba27:cbea:c6d4%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 15:52:54 +0000
Date:   Fri, 27 Oct 2023 11:52:49 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Ingo Molnar <mingo@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd_copy_write_verifier: use read_seqbegin() rather
 than read_seqbegin_or_lock()
Message-ID: <ZTvc0Z6DJEYXI/TL@tissot.1015granger.net>
References: <20231025163006.GA8279@redhat.com>
 <20231026145018.GA19598@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026145018.GA19598@redhat.com>
X-ClientProxiedBy: MW4PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:303:16d::8) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|PH7PR10MB5675:EE_
X-MS-Office365-Filtering-Correlation-Id: f51018bf-10ec-4aee-e3db-08dbd704c80b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Csgwlo50XPykZfSD26xbNS9iUXPRD7I1Izqnyks59DX+4EpOYV2sEkmbrj5njQGIJ5YygdsfNNiSQq2Evk5iOrRkv3vDv93177FiULgCaZ3LNjfw5g3ysD54sh7puPHUlXBSV2DHZoYo8V/jorGuicIGVqLG5hzSq45JFrKEEm7P/JTz9clXLRlnO9Fl9oXJjGsSNxmFdx9NOpeAFtOP00nDeCdWQXGp8b+oqxQE3ToQCaRm7ebGUsPJXqksFznHAWf8j2KiRlfQdYcnqRWD2iQxpMi7o1ic0oZsVYfpvPDGBwfkmDb9KwuEcL63gbu5c+AU5ygYQNgFgpDam4D8No6A0RxDdDsN5yOBavDEGOzA7ZWvt01cvbec0nWOLi5H0efmig5qCrRqDrbYsKDTfXHpRrZgcDaYfKZOtRl9Ma/QBsCElslMzhK3+44yGOQe2+vSOVG3FVYOPMZOfMjvGHQhc1QKrD6S19EewLNYYgoezSOVKvNgKij6YdFPt910p2BbawubXquLN1DOsKv0hPXKKE/1SZFgUyImbET0GV/fGDyHxpwz/qrd1am0wFIx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(316002)(26005)(6486002)(9686003)(2906002)(6916009)(6512007)(38100700002)(6506007)(44832011)(86362001)(8936002)(4326008)(41300700001)(5660300002)(478600001)(66556008)(83380400001)(66476007)(6666004)(54906003)(66946007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XJqabQ9zbyiIgaLo4OAJNGktKW0BKD65613buQzRcAYQ2ftDDDU5WS+8Z8NZ?=
 =?us-ascii?Q?fZ3ydj9B2BJKkopjhtJLdj3ca92wpt6fKr/pI/dY2Q4Ngb6SNVzl8Uil1Mi1?=
 =?us-ascii?Q?Ebn6R7T6K6s/iUwKGj4xvoozI/xtAhUDNYh+CthijONeh2+jeHuoPw+R1uV2?=
 =?us-ascii?Q?J3+87q9O/lUMi3K70JocJdDyLzGSFXeJTW1Msp9eoYVFji4gvdDwS0JA7jd+?=
 =?us-ascii?Q?9EMU+fwbuAVBNcEAePVQ5jSbREcZrZbAjtPp5Qq0gimDy5rZ/GNBnSeYhtZ5?=
 =?us-ascii?Q?uQc17Xn4zXZIK/ZW5Y0g4rRD9FonnjFks93xy3qF10pzLvHt2l4FlrE1TOYY?=
 =?us-ascii?Q?B+f9koCp0C3qIWvtLtIKuPlWHLxvEl+OVRY5p9YDrKQ509IXtJFMwj3belvr?=
 =?us-ascii?Q?oo+q3ds7zTDvglGJp/lqjIVycJPURLDGv6fGHBg2XUSLwRPAcXE5THco5vfw?=
 =?us-ascii?Q?W6cx3xojiKiDNnYfOVnTdBY6lTI5K0ohA3rOY/mPxZQ1jgb2KU1NFHnXqwFl?=
 =?us-ascii?Q?ukY1Pq/WpBL9nWjNY8oVqpYP5eGWHkoOQu0AcFjQW7Gt6alrcSakQEHZCeNy?=
 =?us-ascii?Q?ak+tXCdB12aSRiwsNkaMXL1Qrrp8Z5d5fHxk+u2sOLHjjPULbAtJEPoqYgOR?=
 =?us-ascii?Q?iLKCQdYAPIROgScyG+Mt/+QE0OeDKbAmTHj2XC3Dhu8HMVKvbLomwoRL/uQv?=
 =?us-ascii?Q?J7tibDwnCIJFBFq54Xbjz7n56uQZkox3Kka9D90ipnBA6E1uggHSFeMGDEnP?=
 =?us-ascii?Q?hGs7YVreNlCBppgyhvbSG30fWDyWKxzG3DqKdOEEVpwBUEK7byUwizLRNuUw?=
 =?us-ascii?Q?02qEfDmhBDbLnTD+o4d1vu2NI4EsleTxakAkt7xonAl+G6gdj9yFleRspf6R?=
 =?us-ascii?Q?62KMvWlKOALYfcBGWpnrmFmyJmNL1sfVGSGbFVb4IMh8wy4rU99JA6dfkHsk?=
 =?us-ascii?Q?PHcq8rqESm1sNtKBz2PoU68wqsHcCRKiiGovASEBRcdfRmM58lDN9zaSGmx9?=
 =?us-ascii?Q?0fhTAsxoxR30+9BXxiWTGCoKW8ANbzX5FWlgPOAjqbkkD8f5ORJH+C4gY5pi?=
 =?us-ascii?Q?hoGX11N/muRYweNZaVRtil3kk03kN/fl2HY2WCxOYm2Wn5s1hJF8EfgqAFy1?=
 =?us-ascii?Q?b+hdNlkpDmFyU9NR/Bgei1QBT4GRIvraLIDP/ZcicMB6QY7vI711jZFBUrh+?=
 =?us-ascii?Q?F6xsa8Dnlq3tRb3zvoU53YGZ6FLqQC4zx6FHaDEhuFEgwJPwijThAPIOsGTC?=
 =?us-ascii?Q?nyFkXYSRe5czr1HWAwO8pFyD9/Q7tjq3MxJHJCAdOeHcT4E0O2q23kboka0b?=
 =?us-ascii?Q?I2zkw2aD8w8CWCF1OgZ8uTlv4NYMAZAq0hIPmdlBRtZbwn49OO1dFbhAKXuy?=
 =?us-ascii?Q?NzUBluME669nmeeMtZXyd433l673ocqInXw241Vsnabl9OD8X9UWUY9cFx2S?=
 =?us-ascii?Q?MUdOejEBvMc6/vPo2GvFgpezcAkrMZs+GaDFYCCNxMOSHKAvgE4vw6C5Hh96?=
 =?us-ascii?Q?6+PeGf1s+/r1YTrZUJoXtIZhh6JP1NtFUG/Nan53E1up5bX1DMD19F67kGc0?=
 =?us-ascii?Q?mSvyPFXnIm49DB/rIhykPtoARBtuJrRA6RzeiuOq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JjJEER+vFI6F2tDhkCQLsjO93EIVJeX5aKh7uW/zVSjsLk6p4+d6cT9V8gX0DRYp89kzjqWNqzslqT+v3wrG6P/1F9xmqtHfP62MEK5InjiagZj2tYnOOsKtuA5HQ6+SYJx6Z03xRKgHPxp53/54m9d03oBA6fiF6tQiXCKOcHTgXv7QuPhkrRAOy3PI2JGmYVeAI+oVgbYf1dylylFcdfrSl4K+24BExDK/6jRjS8BuQVkFUqRHtYDXtUIbXVDDvM0yYppkPtepKbIGYRz1k7g64GgoDXD24adCk9jsPVo9G1fcIoS4NKBh+HYNoW9pgtZjMDqCUWnZLdualuG0MXg+nZRxshrGJn5DV/gQ0kzaVCw8Bn4zsOMuClbOiguzNJRswEVX3jR07SvT2Y+H3ErRvzt+5+3P/vdPEzRcYsALWOSZm8taKoQR1wbWh/0h+T8R70q1bEM3BhVoCJa7keqYRa41Cp8jeuiPmWNT6C0lXBSCSUtcdm2Y8nwWn5VKrsfTz5Pgbnq5NYFfcJlu0ZaY/ElCcRKdXoojGniheKdG4htHkTuV4Kql+Hl2Qw6TuA5bmJgfZnRwAIAb8MKd7nLDhBV8ydNkmQJQJudKmp2pVxraER9Sa19qNWWsxzC9bVI8/UvNqgweZy1rmeLPZZOu0dmpVQuCZxQFoj/gZB9DU5o156TiiHf5SfnfnUGwtzCUyXmRaDnCkmTtGTLyqnrpJ9LXM1VE8Nixjs0SpMRAJ4FYcKlssJCnA2HqKNEeqbZUYW1xjXRawmghnykDLBqMtMKerWyYlsF42I2uJSXJ/e7uLV0scIBd6ydSrpMr+Oi9rj2p1Wvkp0qqPi8NvO0NJBSIptlah47fAAfcS5danptyMT6Vph6M3O24EpW399kfmnBv4kVdveeZqU+HBw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51018bf-10ec-4aee-e3db-08dbd704c80b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 15:52:54.1174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtY/9XJFow06IUN3JHAtbdvZbBcoM291QcNbNr7e2u4oAa5FYPMtCy4ooGDS6pjxlRZuLoDDiURxQjBTjKAFqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_14,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=984 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270137
X-Proofpoint-GUID: gK2B_khZnKORSP-9wp-blQRyeEMWvt2p
X-Proofpoint-ORIG-GUID: gK2B_khZnKORSP-9wp-blQRyeEMWvt2p
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 26, 2023 at 04:50:18PM +0200, Oleg Nesterov wrote:
> The usage of read_seqbegin_or_lock() in nfsd_copy_write_verifier()
> is wrong. "seq" is always even and thus "or_lock" has no effect,
> this code can never take ->writeverf_lock for writing.
> 
> I guess this is fine, nfsd_copy_write_verifier() just copies 8 bytes
> and nfsd_reset_write_verifier() is supposed to be very rare operation
> so we do not need the adaptive locking in this case.
> 
> Yet the code looks wrong and sub-optimal, it can use read_seqbegin()
> without changing the behaviour.

I was debating whether to add Fixes/Cc-stable, but if the behavior
doesn't change, this doesn't need a backport.

Just waiting now on R-b.


> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  fs/nfsd/nfssvc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index c7af1095f6b5..094b765c5397 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -359,13 +359,12 @@ static bool nfsd_needs_lockd(struct nfsd_net *nn)
>   */
>  void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn)
>  {
> -	int seq = 0;
> +	unsigned seq;
>  
>  	do {
> -		read_seqbegin_or_lock(&nn->writeverf_lock, &seq);
> +		seq = read_seqbegin(&nn->writeverf_lock);
>  		memcpy(verf, nn->writeverf, sizeof(nn->writeverf));
> -	} while (need_seqretry(&nn->writeverf_lock, seq));
> -	done_seqretry(&nn->writeverf_lock, seq);
> +	} while (read_seqretry(&nn->writeverf_lock, seq));
>  }
>  
>  static void nfsd_reset_write_verifier_locked(struct nfsd_net *nn)
> -- 
> 2.25.1.362.g51ebf55
> 
> 

-- 
Chuck Lever
