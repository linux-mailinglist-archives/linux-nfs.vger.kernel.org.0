Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7A577050A
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Aug 2023 17:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjHDPls (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Aug 2023 11:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjHDPlq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Aug 2023 11:41:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0A71734
        for <linux-nfs@vger.kernel.org>; Fri,  4 Aug 2023 08:41:45 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374EiD40002950;
        Fri, 4 Aug 2023 15:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=EOC1oeyAijOEWOTWY4y2Ml+K+nSlEtXjEJxi0SEBq3s=;
 b=RJzNEX24D9T9u2ztSXsUNvmo37/zdx2JdFgIZ0pBSq4Dci421CHqB971hVTKUVnLXAww
 BVSqSdO1tsQ+D7Mwpc0IvWrQlgkxnp7CVTq5HeZhMQyoEdtVXeC4JUQB9TWkUpkrIt3G
 PMcwqQqv7p6DabaIhB4OMOuQJHIwXO6WrC+gPX8aJC1ru0kpNElhVA0ij/dwSRv3bF31
 ucCsAOogox5ac8JofxTGesS5Ot+BwvPttZ8TEwLMq9WWlNMvWh9hYGveNo/b52L4Et/p
 kZ+1GzJIym/Tj7pAthVIrueKLr274fJgDaU1KqCcb/wvcGm9/E6umUAL4xFUzd9LxCau eQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spcc4pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 15:41:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374EvBYK021398;
        Fri, 4 Aug 2023 15:41:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s8kqf1ab7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 15:41:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avRhkExU/9J+vI+FbaH/o3wrhKtW5vYJyhWD+20XIZvx5HeV5ky6UB/7NY8R2ypZ+7OXeQfhRtzFvEtDRhBoIs5TkFddIjxmEEHVlK5xjSRDtMaU935ahZaeZETn88a/mTsC19Z/sZXi0m3Qmkdg4RcVH34HGBgidfW4EmPKwRI8IxHpgBn3x36FQaClqmmS17IrwmXNhsmw9sOOC1GzxASdHtXDoesHwJBVcpTfAUuw1YVICzVB17rsMeJ44Ynk4qQzfq8MXphghRvDeJ9itKkPm5J8GfcG5/BLVUWBlHW0UBfSGcJNwNn4TapfEzIgMTW1kC5kVbln9qFspHCbaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOC1oeyAijOEWOTWY4y2Ml+K+nSlEtXjEJxi0SEBq3s=;
 b=Hu228hqJWmxWTFxA0Fl6A9niFRIn6gURAhSko4newAOI9MjXjrRoDC2UQkIwOlnxQtmZbzGhYWXmA0BwT0F7/3UqrctqDPt+i9mqquli3OyBFYIfEv89HT3wnH/6VwwhKgmgQngesW0QdBc8iDOGJFzbxElJ81LdqLbYcWNySnNc17AMgW49POM03Ybdaybdv1nyadzGtQy5zu3eySOhDe65kL4FKAUvBWzavgkxCQjhZpeQcx96HIgU+m9uOfdTnLnpmto6slUpJd9prhfIlq/MX03919ud/FFcVUarH4GdtAfNXEgIJHOd9uqYJ0cjITTJqYa9HAMReIAGUq002g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOC1oeyAijOEWOTWY4y2Ml+K+nSlEtXjEJxi0SEBq3s=;
 b=YRTcHFjIpjFGZzsJq6cZHkonA2W3UtsvAP0PMmhf8XpVvW7Dj0ZG5PdEG5YXX78ZNDFGIDiSolae/hRCP+Irc1rwRPGdJrBMqCV0e6tWQH1YROKwlJbm7qYj//dnMNlHBPncnR8BBAy+Eo00ev6GTBUWDHV22EYpQJc/jA/EBFM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7166.namprd10.prod.outlook.com (2603:10b6:208:3f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 15:41:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 15:41:36 +0000
Date:   Fri, 4 Aug 2023 11:41:33 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fix race to FREE_STATEID and cl_revoked
Message-ID: <ZM0cLSgattzr+Tmv@tissot.1015granger.net>
References: <c0fe2b35900938943048340ef70fc12282fe1af8.1691160604.git.bcodding@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0fe2b35900938943048340ef70fc12282fe1af8.1691160604.git.bcodding@redhat.com>
X-ClientProxiedBy: CH0P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a6b60c0-652c-409e-c2bd-08db950149aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gn5Zl5MYh73o+5M/Et9fhzYUW6xloJaF3LOCLq9zd9DtfkSQNSVcmKwXDdYxlZ10kKjM0wHbEviZ+/rlcHxpwQPOyxBT7xpwW8ZuIbPzVkpk6zFBnXd1vhjZe7iBNol8kID0pIDXKjhH9i6jl4imOHRnQYC5JjheCTMGCSxreDqE0FwmOg3zRsr4iA1bQnGQsF2nivIOSeyJky4pM+7x7Dxl3tPVcGwcgxQ3h0vPRManLqAPTc6gbG7QxAisYXyYuJyTBXqTABSdOOUkHch8jFFJKBK/7JKsiGpG/IZbCGRAc/jsCjjFKTyhBVbKEEFiowYEaNieeSMJJKuRMVbqfrXt23BQOO5wXjHfR7Z0+jMDOkoGZeOq+5lAcV9VyuC9ttitxDp3349mOjiU05E3LhpGSb1k7x7P0n8T63G+SWNz1H1KgM6tTvEMlyZ1npgjCHgkMmKPNXyyuwZyY1Qi3MsR+r7NEPD0woeg3KqdxEiCbfnXRgTflASgylzseJFZXoD+ZahpQMRDZNKOoRA8ddvrzW+5xoUmWdVV8D2xq6LzxjeHWNkAyjhekyZjxcMrqyBvjutVspwrCO/oLF0NOnqsIL0cHH138VQF96THdV32OXcxT0eVrZLqvYml1Zy6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(346002)(39860400002)(1800799003)(451199021)(186006)(26005)(6506007)(83380400001)(8676002)(66476007)(2906002)(4326008)(316002)(66946007)(5660300002)(6916009)(66556008)(44832011)(8936002)(41300700001)(966005)(6666004)(6486002)(9686003)(6512007)(478600001)(38100700002)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MFxCCN+OgmXDNMrfX4+ko/Qv52EZceU0aIZMA2VOsG2ueLUul7VN7ZXk3UV5?=
 =?us-ascii?Q?DeCXUGgwry0gdjDDXzM5iTRqMnUOeGcLTvDFuI1gf2zPe025Yi87799SX/+B?=
 =?us-ascii?Q?0WBgO6CSXHDRrIwU2SD7yzTLZiyy+54AxdfqLxSrPSYOJZH/RriV4Cu4XpGY?=
 =?us-ascii?Q?mhnqRttsgHWrzOYUFxr1SJRvN4tiGTQXFby3aeG09oS9yYMbhQg/jRp8lbtC?=
 =?us-ascii?Q?hyepKehGvFa0v0tomA77jNdpcFocVRk4BF7ONmJXRYH8cQnwu+jzi9IDxR1F?=
 =?us-ascii?Q?Cy6VaK/pu6XcXV6zrXU3Cs+60JfTb50rKKDB6hUkx/ZGbgjruoGBMP9IPltQ?=
 =?us-ascii?Q?xNXYOknWLI5wASFUurwGZyCrCDJ57I14/oWvPTH0oxydeuS6OO6PGwLfB+z0?=
 =?us-ascii?Q?1/ruuYJhlAQ2Tz7krjewcxZNuhI6Pc1Zo04qOPXoJVeYZVNQXgnjFamb7c/+?=
 =?us-ascii?Q?LWkU+PW5xXkeOMFzrkF9OwKCo/bPaSm0AiYDK4piDRSScpdjxr/ysELpR/OB?=
 =?us-ascii?Q?8DrxPusib7/Ow0usKSnZgriRK9xbAUuMOAL8lTvhn2O7Lw8TfooI8LfaxHLw?=
 =?us-ascii?Q?q9WhSESDEvdgltV7isn3zByM2FdzGmd57fJpJVVKm/P0QdVzMTm6Stzm/0tV?=
 =?us-ascii?Q?yFNlzuyQnS9/TBMsnE+k9Q8DginLEtrxpLdIikRt0bzzBoNfZpiJ+Ww1QneR?=
 =?us-ascii?Q?cbV/bwCe9sKBVwYckBz4lAuXEWpKXC2Z0aBpA6nl13L5qAR2WC49FkDA8Mq0?=
 =?us-ascii?Q?ZjI4XJQiAl180UNEyAwLnYaErwzy5znWTdvpQWne4xtkTWyuGzclpGo2u2bq?=
 =?us-ascii?Q?rcuvfAldCWVA+9iMvFrYPmzleNA34DOuntlAxq6QPIRKw5GQ90dWGlJLjNiw?=
 =?us-ascii?Q?O2aKLw/ZN58H6tqDhX3rPOfL/AUTze3aZLgoYpMQsQOjxRO+1ZoTEv0a11cM?=
 =?us-ascii?Q?o0jre7AkHpTDxvxsBNsbBlKZSAEcNC8WW4xwTWj287mwJE16wH1jwe/FzM2w?=
 =?us-ascii?Q?mSRRb3LU8qCz3PcsqSrrZ3JhmZbDfnfmw1N43rcrJ1V6Ma2MAI4uZ1rcAEEd?=
 =?us-ascii?Q?vbztiPrrQcfSateSG7vkhduLsf1SqyvmO+VdsKQk+MqvxGqP8aa5l6ZmsiFW?=
 =?us-ascii?Q?WSxxP+uMHFm2QS1wq9PiVaULEejgayj8qtrlhp23OpwjOJxHy1rsIERYfYaG?=
 =?us-ascii?Q?GVrzfRwE+4J/wCEIBvnBsOqyx/uOlOPAUs6M4JsjSyP9kJ+MsozynasebN/5?=
 =?us-ascii?Q?9T4jxlp+xVF4Fve75BwAjvOnGAl6rXFLCsdWnhartTzXI/qRlLZf/12vXRiA?=
 =?us-ascii?Q?NeQpjURQLg/oK1xLSVlLinsJk6/dVhLhv2rsHL1WM/ytGKffVIbPR+Pf4a8n?=
 =?us-ascii?Q?hD8MNZERbCC+4OmnUf3WIp4dWT6dYYbtccOlZEYD4I0SmtMRozoqUL4bIlME?=
 =?us-ascii?Q?Y3gadgWOPqcJKRjBGwH2WqJsa5XL6KYkNwcrA25RsN4x56hSMJzZ6O24WtbO?=
 =?us-ascii?Q?FgDuSm8Vyq0PthVnpfmq87/nXwKz+gazedDy61m+pBtU6vI5m6+Zn1fcX7+v?=
 =?us-ascii?Q?tQP693LVrfIZRQhBGqKaGJ0OG3gYWapr1pVqMeQBp7eWs+3aoAYKbnO/h6KP?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /NL8zZXE/XuiLCrf0i6IUkB6BWxxEYyFuKDQRzPEZiQYaeP0QUXkcaRxWDE7AZD4hG8Av9vD1malWNJ6O3zybStj6UAORI8Emuu8OpPgQ90HxhU/X8BpSx8g6Sh9uiMpD8ZQr9xpszDKrYG5gJfbPfQEpFTY7yLEE2CWI3PS/o3+iU/slfQdWoKE62VuWvN7QihRxC7VwmnIxAAVNTcahZenLqEcr11cjKvZkUvIbIzGiVd/ojVAAF4vGJ0pL5lrBQhyMUjXJqOLkIsLoLd5g6fyFzcI7RAAEX4l7etzvx9XdlM0JUfbsOL6y4vxNGTtb82GZA07aVYhVgjDHOGUZxfy2Ofa8qLwJtsBFki7PmOA42phHbW4tZV0Lq068kEAfJGNgPyiBfow2IzERyAB5e0N2K6P0dmUKPN/zhAGW2MU/fb/9onAy/r53sMuM93MZFnL/Mf4Yjxr/ZkUpRc/F+R1Ccota1Xy3NmRNkogBzI9lb1DjFsjEZMa6fzfG3kI/e5/bQNwBv3j0rqPg++cxT/tmwdjOGisRnR8PNwDISje+BcNnkE+UFQ33bhMBI/j3UGxLd+PGGE3VRIgCYZ5kMfR4o3veKnJIFT7xM6Ul/Z8OehfnWx2SbislauG/oiW2MtcCNWoAefv9TxSIvw2JvOF/9dOvaZ6/oJPwgaz65BdvSieeOMzWjrsDDgTKUhNbTF94ClXzKA11pghYoO2wmEKgAtqSBiguaPitoxsAerJWMqcW3beWodsP3w49neL7JyJ1h+4IQg4yfFtzZavskkMyPgDJ7yla0Sx0BPYBwmB61dvAlQFj0NTS0A5ucuY
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6b60c0-652c-409e-c2bd-08db950149aa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 15:41:36.8164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0L/0XX5ZDMxXBOFhPjYkkRloKNi64mBpgvaDSZ7r+ccI6XHEFVx5hGMFcPXsaCx+QBZ3PfU02pApCp9JLmTsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_15,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040140
X-Proofpoint-ORIG-GUID: ZP_ojGFj2iR4swf2T7pzR59awB-pBU_L
X-Proofpoint-GUID: ZP_ojGFj2iR4swf2T7pzR59awB-pBU_L
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 04, 2023 at 10:52:20AM -0400, Benjamin Coddington wrote:
> We have some reports of linux NFS clients that cannot satisfy a linux knfsd
> server that always sets SEQ4_STATUS_RECALLABLE_STATE_REVOKED even though
> those clients repeatedly walk all their known state using TEST_STATEID and
> receive NFS4_OK for all.
> 
> Its possible for revoke_delegation() to set NFS4_REVOKED_DELEG_STID, then
> nfsd4_free_stateid() finds the delegation and returns NFS4_OK to
> FREE_STATEID.  Afterward, revoke_delegation() moves the same delegation to
> cl_revoked.  This would produce the observed client/server effect.
> 
> Fix this by ensuring that the setting of sc_type to NFS4_REVOKED_DELEG_STID
> and move to cl_revoked happens within the same cl_lock.  This will allow
> nfsd4_free_stateid() to properly remove the delegation from cl_revoked.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2217103
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2176575
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>

Applied to nfsd-fixes (for v6.5-rc).


> ---
>  fs/nfsd/nfs4state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 3aefbad4cc09..daf305daa751 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1354,9 +1354,9 @@ static void revoke_delegation(struct nfs4_delegation *dp)
>  	trace_nfsd_stid_revoke(&dp->dl_stid);
>  
>  	if (clp->cl_minorversion) {
> +		spin_lock(&clp->cl_lock);
>  		dp->dl_stid.sc_type = NFS4_REVOKED_DELEG_STID;
>  		refcount_inc(&dp->dl_stid.sc_count);
> -		spin_lock(&clp->cl_lock);
>  		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
>  		spin_unlock(&clp->cl_lock);
>  	}
> -- 
> 2.40.1
> 

-- 
Chuck Lever
