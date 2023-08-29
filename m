Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4247978CD92
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Aug 2023 22:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbjH2Ufw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 16:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbjH2UfT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 16:35:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8741B7
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 13:35:16 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TIiHdo008980;
        Tue, 29 Aug 2023 20:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=UBkLgspy40ENVwBXf3q3loblnIPA3TrlROaZHjYlZl0=;
 b=OBWqhuOlRXl82YMhViJUPQkGDSYQqNr+tweQiDY0UyY8C5ltrAQW0G6zcXXmO1/f3pbI
 aQcbIcqQIXBBmco4rnkV8zRDLewRJoeBr6VsvtNN4rhhNlOCN9xAX6zWtuRicZbJ+78i
 rrOp6ak0dUt3nAcn2ycdydBHw3IcaH2Y3N56xePF68Lebg5gicOc7lVXBfEFmVcs6i8n
 osDfvvxW71uF/8QH+vQDtg6bx+O12ftzskEC5T9f72II81yn9ImdxoFPm61DdrH6o9t4
 U0KoVvnx03LGf1e9z0m6PfTboQa2z8FnoLYtJnKvcBtjIiHTporjm1R+2fBhbwnw2Gah EA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9fk5ysq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 20:35:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37TKRW3k032738;
        Tue, 29 Aug 2023 20:35:12 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dp52bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 20:35:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fe+VGQ5RsB8sSh75sqQWgSWlrcM+mopmrb96sPLRwd2qaFwYFoAhElQ5DjencZs/qsTaFqa2QdnO4cAQXrGnik/y0HWEHcsEx/fXYRS1+MxN1b9lib8sldhDShReR5MGx8HdzIZx/pjpPwVQePRrXyTrPkCz/TG73uyHAWvK4CJmlcI6FV5p2QCZAGJ2PVL++3tWLO703A/su6bd1nPuhrWA7901RzEmkoqMLhk29v94wPyQ+0lQ+LmCw/Ds5fk/eNcPx6KGsTKdMMQfMy+IhBaawa+nc3g3NHPtaswiF2Kqe4SkhYt2wF8ANko7v0drpZJBJ4KnJxwTkJm64/BE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBkLgspy40ENVwBXf3q3loblnIPA3TrlROaZHjYlZl0=;
 b=JZ4LZjQZqLFBZSVoN2Gct3n2iMWJAV2TgBw63zEbf5BDiy7ieklNL0aUsjB0qZ8tPBliJXIIUzHTYTFxz8vG8GmVPTS34kgyAwZFHqj7f/NwDq2ybIV8e6AH2P20U52R4k+RAQvYPjH+3yxIYg5Mlb3dqwrbcgwOOzyj/wANm8bl5qyK/NlqTaJAPWR5q30xE7WQZ4f56xs69buwpS00/OkP17YBmvVpMvUKsrkB3IiFMt3v0sMzmizDdI9l9YpPCyu69kZuTkTjsmJhXt8UEoxw/6XvNypDJxT0m8aghMsuWWAC1J0Hbuohqxvgy7rURhb+w//oaVS0uDGOatK4Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBkLgspy40ENVwBXf3q3loblnIPA3TrlROaZHjYlZl0=;
 b=F+3ib9z4al88EUCH4wssEBBF7q17sRo3m3zt4inHXniBwMfVCJqnMAKXzWu6hOJXyvL+r5jF8j1CA1uJ0vvfJoxznt80F7I9djCyW2Q8lj2sQIMe3MntC8bplugrKXy8hYkFpnV42jber49ndcOQtG5F3/KU1Gx2EHXW+khXplI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7582.namprd10.prod.outlook.com (2603:10b6:a03:538::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 20:35:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 20:35:06 +0000
Date:   Tue, 29 Aug 2023 16:35:03 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: allow setting SEQ4_STATUS_RECALLABLE_STATE_REVOKED
Message-ID: <ZO5Wd7BdgsNMOpfU@tissot.1015granger.net>
References: <cd03fb7419f886c8c79bb2ee4889dbc0768a1652.1693326366.git.bcodding@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd03fb7419f886c8c79bb2ee4889dbc0768a1652.1693326366.git.bcodding@redhat.com>
X-ClientProxiedBy: CH2PR14CA0002.namprd14.prod.outlook.com
 (2603:10b6:610:60::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 06688d30-43cc-4305-a523-08dba8cf6e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xta0k1eW2qTkWOo4/myhy+BeVWf58RR8Jpc3oqXYFtDLi5q+7sVxwpdY0FKag4UKO4qOffN2M8tF7Bc5Q2OEetuHAWGEio9Q2Ct32CajfFBB3KyI97/A3sjvaDM/8mFhplnxIRsbvCDP+Q1JY/tv4ALWZGRu2b63v1bx0L+ZEl1KYbFpAHaPpTPmgHIjMoVH94Z/xt3Nsf70Y2n7GM7I3NJHTsOJoyjh6jahLcmdkk6etxmH8cBOtuxaOHyz9SLnTrAjZ2UQlqEJh6kNddZXcId6sW7xL04tUde26RyNFeOubqAt9txNDkiNExVsnOAL/LIpYUAYDEAgMOFOVRYW5WD4GRwca/L691IxFvPSAOAmZqYGHl/MzWfImEUhQTsgXNEI7dIxKQsACMPiBmFcjoC8r4SXzcHoqL/gavUYGyVj9BBkTdt7pBS+Bzl0chs5dotHDM494v/YEs4VsXZ5BL/bqynjXgzfbITd0qXYFtEu9ELDY72jLQ2bC2jo4dfvqhY+7AV3IboX29Gtsq0irTMyPCIECjTYt7mQ30DMEgak2JrW0SqeOEaHI2pqoMoL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199024)(1800799009)(186009)(9686003)(26005)(6512007)(38100700002)(316002)(6916009)(41300700001)(4326008)(2906002)(86362001)(8676002)(44832011)(5660300002)(83380400001)(8936002)(6666004)(6506007)(6486002)(66476007)(66556008)(478600001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MHXbwx20qUuDWeN7VGu5LAjN+WDMOGJPlHXHHc25pY4TYV90X+/jnlt/xtAn?=
 =?us-ascii?Q?Lo4G+Ob75fah7S0cfSM12MreL9PEfODk3wDQ42mrrAkwVH2Yhbc8a71GW0c9?=
 =?us-ascii?Q?vd1T2TX2DK5iKZqnbLkDnxuimNEVeuepQr/lTr8uZuwODcIRHRAMG/D5GszB?=
 =?us-ascii?Q?/Ny5WL2HdCGLo1ujwXON6z+kJaL9Jgbe14NjG0uTlPNQVWDXvzIBSnV8XGip?=
 =?us-ascii?Q?fbOsPVXefdsw9voGrS4wJ8lHH/HpVIYoQG1VzOg9P7Z7B/aq3+IwfCIx2XeD?=
 =?us-ascii?Q?tq+TrbR0x9DCTyergeDZMzibybzg/XSV6jmuLKIV4Y4WdNm6KpxGDfHszlnL?=
 =?us-ascii?Q?ASxGCLIhb+XlClHf/A2rLn1be+5oQVoXz4NY/xXoW2L2lklob1G8Ne6QBKaO?=
 =?us-ascii?Q?mJh7AWxCUpfz1OnoF1cyIJlsOED38jQm3ITXWLTRgBr3vmHxXt14bO8pQ/zH?=
 =?us-ascii?Q?hCc3U8BV8aDfbGj34O20dqHMGlpdZxq1eF4V0zkEZ/BFJXi402m5cquL+7Wz?=
 =?us-ascii?Q?Y5YyFZ4xFdHI4l8b50HrVuJvJw59oK59wMk8kB40+qCXBscwk7vg7bbnipM0?=
 =?us-ascii?Q?ER7eWHXcFHTVVXL27xxsI4Wydg2OAeukFD4VAMxC49nnQKc/dayjHgdHkht1?=
 =?us-ascii?Q?YURUxXMeyU/LRDXdr1IiblzNC/ubDS0EkXCLCZK+aUSd/BEHDJyXBZjNUO7N?=
 =?us-ascii?Q?M8PoRFAOgksJD0HnRO/cPX0yDS56ij/TEpZSdmEv8NFNBDkNNNAagO9mmClv?=
 =?us-ascii?Q?KjNVd0ZutNulLI3cr1tD1dDRagQ793tP64IUSEJEV0u6+P3MRl4hQ2UAD0ID?=
 =?us-ascii?Q?BHvogp9NfA/1+RIluj1iAmkEDOmRruZXXScRS4vN2lfnHjB9WTHzHSqz8F7D?=
 =?us-ascii?Q?dTHT+Kuaw6ptEvA0jCzm5W7a8O6SRM2kilEr8Yr93mKA3W1mdmEXpg74Hu+T?=
 =?us-ascii?Q?CWBGTv9d20Akjoa9mjDWcYahzD+Sh9ldEWFlwO9t31H9xa5VtViAIjice9aG?=
 =?us-ascii?Q?6Rx9DNTIBWQAPACqUpHHOpJsrLCPcXd72orvZdyHV5888bw2dj/w01vyD7Zq?=
 =?us-ascii?Q?ki6uenCHFMKICECqPufrWxKFtOWendGtkEM/7AcNjgLyIk9rVkImsx1Cm3CX?=
 =?us-ascii?Q?PBh2UMglXdMQC+bemdQILfPdOuSUarNXubNibvPR7w84rYCPoio5lWB2qYXC?=
 =?us-ascii?Q?d8m/pASWeZwSg7+FrRsOrhIskmvAy8ucaUkuOybYI4IkHVkl1c1asdRXlktb?=
 =?us-ascii?Q?n0RSRdG7Znp7GKZqOfeX9NRMjvrFRcmMetf3vooU4WGMV2IKicYfLjRt0V/A?=
 =?us-ascii?Q?HFROTYfnY8/AR8u3REKzbN8bXkCYQzCfoisfCRYVUe4wL4+gS1Y23Bx10kKK?=
 =?us-ascii?Q?ZUdWiaqW7DtiRqwiIs6cfj9cQTyVre7/AflPxBy0VW2mJcwyb+Y4vb99bZKF?=
 =?us-ascii?Q?9clW9GdFqVgoSGoWfGFF4DSEG8748up7mn2sQzI8s7N9Im0xMRO8U8yeyMwW?=
 =?us-ascii?Q?iwxWWjd6NcQq2DkA1EdVmwmI8/AbwHdP1cGhfxywkh4gMLl5I1lCakYNrIRC?=
 =?us-ascii?Q?DiV9Nq0tvAXRHvYDoQH+KMA3TUxX5iDAYc80H294zD09By45Hc43ts5trBfl?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2ix7zogWMTRhNqSbmKFsmaF+a2Zh+x+ja7D+dsauCUtOw5QDrW7vrK7WzNkQikCBbBckckqdWAmglD/c09mSf2rkgZ4ip4piWsUd2EhIk2EdqhF0zL4Aj5a+Twk/qlkBmHcj2u+yevVi+v28c+bfnvGipWnNk1Y9jYK4C4PbHymKYVnBXWCYE4H+dtWO+sH4cCHvhyeuxEPpS55yoMHEmi/LKMxeY0Y9OqSeUJ9S7DgXVEQWzNd0qfs+4+m4YxxyRYMygltGNzcqE+UhTEps9oaGmGY52pbLd4AsOgUaqw9RUWVzKIh09JVTTbpUpVkde4G/30AiAYfw+QVTS0vuQLUlkWbeE7pEN1hwtowbfSAXyG4Jxsw45kkf85UlVjbqNjn3Dhvo40nFqcFI34sMt8QItUdhL/JAPEW+fZuGuda69koSCx2OU3P5ywzv6gnJetrO2MZhgFAttO3fR+cA3eKggTs4hOWyd1h4EEs4ys5IbLdj8OpHGG6FtSPYcxSQWMoEkXu1KbD94PtH/L0naP5YZthdD9ynDUexjdPm+OCrXY8JlfsHCysuENULjsgsAjsDEhK99fTgzYDEpNXxK50dDT67KAXagy5/Hvv+zmXI4N580Xkw0zPC6SKNp/gaEnd9H1aiMnpb2DmgW/saskmxsdW4LQo1tRrVUWe8izyD5JPdHtPewwP0BwnkFlczbJTG7kCHklw3M3V0szOi6og+I9mKyJIPmRTxkTe5tbMBHslVTJ/toAMGOYZwquXgKMwoFOrkY8gpP0htzhw+k8LNDdCiW6oB//1gH1kjEFo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06688d30-43cc-4305-a523-08dba8cf6e10
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 20:35:06.2524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vxQPWhE87ptyVmUxXIfR0b8/4qaiUXPH558VoVYX99yjbKgJWfGdyXMAzpuzeSPryd769BwpCk0pdChsXqG9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_14,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=802 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290179
X-Proofpoint-GUID: n4Tfjtik0LMignwgfHnY-BxVL3EZAKEx
X-Proofpoint-ORIG-GUID: n4Tfjtik0LMignwgfHnY-BxVL3EZAKEx
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 29, 2023 at 12:26:56PM -0400, Benjamin Coddington wrote:
> This patch sets the SEQ4_STATUS_RECALLABLE_STATE_REVOKED bit for a single
> SEQUENCE response after writing "revoke" to the client's ctl file in procfs.
> It has been generally useful to test various NFS client implementations, so
> I'm sending it along for others to find and use.

Intriguing!

It looks to me like the client would probe its state and
find nothing missing... fair enough.

Would it be even more useful if the server administrator could
actually revoke some state, rather than just pretending to?
How difficult do you think that might be?

Or, conversely, what exactly can you test with this mechanism?


> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfsd/nfs4state.c | 19 +++++++++++++++----
>  fs/nfsd/state.h     |  1 +
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index daf305daa751..f91e2857df65 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2830,18 +2830,28 @@ static ssize_t client_ctl_write(struct file *file, const char __user *buf,
>  {
>  	char *data;
>  	struct nfs4_client *clp;
> +	ssize_t rc = size;
>  
>  	data = simple_transaction_get(file, buf, size);
>  	if (IS_ERR(data))
>  		return PTR_ERR(data);
> -	if (size != 7 || 0 != memcmp(data, "expire\n", 7))
> +
> +	if (size != 7)
>  		return -EINVAL;
> +
>  	clp = get_nfsdfs_clp(file_inode(file));
>  	if (!clp)
>  		return -ENXIO;
> -	force_expire_client(clp);
> +
> +	if (!memcmp(data, "revoke\n", 7))
> +		set_bit(NFSD4_CLIENT_CL_REVOKED, &clp->cl_flags);
> +	else if (!memcmp(data, "expire\n", 7))
> +		force_expire_client(clp);
> +	else
> +		rc = -EINVAL;
> +
>  	drop_client(clp);
> -	return 7;
> +	return rc;
>  }
>  
>  static const struct file_operations client_ctl_fops = {
> @@ -4042,7 +4052,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	default:
>  		seq->status_flags = 0;
>  	}
> -	if (!list_empty(&clp->cl_revoked))
> +	if (!list_empty(&clp->cl_revoked) ||
> +			test_and_clear_bit(NFSD4_CLIENT_CL_REVOKED, &clp->cl_flags))
>  		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
>  out_no_session:
>  	if (conn)
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index d49d3060ed4f..a9154b7da022 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -369,6 +369,7 @@ struct nfs4_client {
>  #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
>  					 1 << NFSD4_CLIENT_CB_KILL)
>  #define NFSD4_CLIENT_CB_RECALL_ANY	(6)
> +#define NFSD4_CLIENT_CL_REVOKED (7)
>  	unsigned long		cl_flags;
>  	const struct cred	*cl_cb_cred;
>  	struct rpc_clnt		*cl_cb_client;
> -- 
> 2.40.1
> 

-- 
Chuck Lever
