Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD5F7B33EC
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Sep 2023 15:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjI2Noh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Sep 2023 09:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbjI2Nog (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Sep 2023 09:44:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA553DB;
        Fri, 29 Sep 2023 06:44:34 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TC7gEc020187;
        Fri, 29 Sep 2023 13:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=rMvhNiZk8krAq4d34tTnEUiAA8LizdtexM8dsbyq92k=;
 b=twGQHVYR4lqAlLzqoog4JcD/wEEyqO1RgpnphAWZSfhUCgUJE5+1WtGfrSTYnr5g37b2
 4/28irqZKX76VtqHFCgpsbxZxML4MiebCl7i+tYdhWt5Vfj9j+LdH8DBbV2REbmxaKYE
 WiW2SRYf6j0BhSxPjCJn1FkWRg91dOp1pVBoNzTkUgogGjxvY6I7fU7toNHtiDSNiYUv
 2SRzLSoFng9V64/h8eVK7tB8mdgkHMapqRePivYl7JLdiBBm5ZfA7o+ndh2C6YkIP8U6
 n0bPzTf2FCq1B7GQrvNBKM845SWNb3PBSA9Fpecx328wvDdTcWsMOIOt2Qqr79Hb95Ry lg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9peeekmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 13:44:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TCcvYP014021;
        Fri, 29 Sep 2023 13:44:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfbuxj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 13:44:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wmspa+IUVrnPXKE1DM9KrpMiv+pzPwTSgyk8Tl1eHdrIo1b7HfK7K+kPprnh+VtA6p0dssaGbW3Rrz/Sy7Wuh9yxb2bVroN7I1es1p9HFTYiWCA2f0SyHJXK3EokqLslR5Pe5EaMUK9oAL330YxP+FNZJ3rYlNfjKaqGC8IDL2RinCj6ch9YzPAGtu5LvS9k6uOjkXXR/Gfw1vTz5dge6YfvOEbth9/m24nRwXTV6d7/tpK4mP3/sIe8+vWh8sGiN4Vxs7QfcIJlVj/6W3haBY1llzuk+FOAaA2cNIzkFQkmqWl84DS3S9djrQ1CbqKyfy+1sa+pm9HCNbuC0AWimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMvhNiZk8krAq4d34tTnEUiAA8LizdtexM8dsbyq92k=;
 b=dOS+qa52ItiezpFl1qCRg8ux/zkRnY1QDnkaDxmLHMs8GJxjAsoQMaKLCNW41sXyz2/nD29GJ1p0sP1AUGqTKaXLgTBT4VFAJGN1OZJ/9sDDFlkyLqjQx1IZgBfxwT1a/WEfxFTgnmgrHfZS+RaE45vqZBppuvv6gwwHqq2J60OdJxBss13DbrCunLpW6Wr+bxDY5IU8adn+/9n3CwRsTE/iIAcK7XyI6hE2qGVSv47j5GY/cu6NuPbYzC5OMOZnmZPo7j+6T9zfZQT63tGbfpNbUpdRgAKwHOOQKvE1bunxaUfecuyd3A3KZi3SHrFyqWRriTLbwDV/vQqZl1ptSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMvhNiZk8krAq4d34tTnEUiAA8LizdtexM8dsbyq92k=;
 b=wgvKtJse78HKL60gZv1yPsGiBNpsEfyC0VHX3+cORRPVc5cL3GQyPKbPff2DyjiCtBlF3k2QJI9Z4BLWUcD5r+o0ypoSrplMFtZvwauPCXPUE9jJF7QN6mWPXJwvTjICthlvo//MP75eo9IIOa67mGhDe7DnPleMPisY1eRw93Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7838.namprd10.prod.outlook.com (2603:10b6:510:30a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.39; Fri, 29 Sep
 2023 13:44:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 13:44:11 +0000
Date:   Fri, 29 Sep 2023 09:44:07 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        lorenzo.bianconi@redhat.com, jlayton@kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v3] NFSD: convert write_threads, write_maxblksize and
 write_maxconn to netlink commands
Message-ID: <ZRbUp0gsLv9PqriL@tissot.1015granger.net>
References: <27646a34a3ddac3e0b0ad9b49aaf66b3cee5844f.1695766257.git.lorenzo@kernel.org>
 <169576951041.19404.9298873670065778737@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169576951041.19404.9298873670065778737@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR03CA0418.namprd03.prod.outlook.com
 (2603:10b6:610:11b::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 970ea596-90d6-48b6-a102-08dbc0f22923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3HfyeyPnnR/vbQ9UZoBJwhxmvn7WJd1MqA+5RpivjznEX8yGCL4Ntxqb9zdRgoKMnuzn222TdqglpFWP4kDKzkqPKeRyY0cn3pybzpT3/D9SJoloqVD/YC2Sc3DdYUiw8gBjkTzPHbHSgtfiGxeSEdioPjJ3mNs4LHWxln8MJPM/Q9VYQUIYu2jFiA8xNOrOiQN7F+TxMaECm2+qo6yyqH0G2u5cpV7zsE7mbsP00jdxcUDfDnIFq/E3GFK0U0nAViQmqQMOfpVjcJtKkw+08ZJJ7WwOpjeOOxHnvriEvYNK1TiFF/JSz46fchSnLobgB0u557EPdv59G44pJPd/3UzSYmg6WclEsJWYkI5QljWVitbX2l27oRunSrfSrCzFiVjnT0ICOXEfaaNFqEdzH0RjhDsb5Yakd5c36IR7Y1y4jZx59QOgYaQESVrEQr7rmxNK2UdA8V9NNxu9uOk766IY/tJ0qQdxkODAE0RUdkwJYIEdk+Hyu9q0kDyTqlfTTQoLUPU7yiR1ozXCRm845nvKLlUQUw51T1LpLUmWKXJ4MhkIo4/YDEGZond15rHu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6506007)(9686003)(6486002)(6512007)(6666004)(478600001)(8676002)(83380400001)(26005)(2906002)(44832011)(5660300002)(66946007)(6916009)(316002)(8936002)(66556008)(66476007)(41300700001)(4326008)(86362001)(38100700002)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t/4odA216VHGIrju9Ov8ZrNd1JzGtdRp6hUsH+6ZzkydHj6gMJE0oNczsl0S?=
 =?us-ascii?Q?IV9ZxTBpyQM1iiocdvUxKHAuBvFvXQ6Naca9imN7qpUiV99I2xsnSvHtLvT8?=
 =?us-ascii?Q?7l8KRgp0BZbVPeZ7xOlkbl5geh0hs1paDx0qoYipoPkysDzBqcsypZX2o9fL?=
 =?us-ascii?Q?RQtiTPzd3qvrXM6FJhVX0nvIlkMRur3CFwVo/V3ZGGBjFknRsz1DIiuOh+6D?=
 =?us-ascii?Q?SfdA40H6yNuke+zraMuhfHpwHsebzyv2r/jgToCHegyF2slAq4aQIWn+K2NQ?=
 =?us-ascii?Q?XxytsI0yWKCyiivfi3BEHhuClRuznFHuYxoQ2AccYOSg3ew8lIzEnD1hb6Ov?=
 =?us-ascii?Q?WhveOFGG21mgIkDd0Woq2AuAttKO1aGOJUOSm94BGHNAO4MGtLZvMwvUTjkA?=
 =?us-ascii?Q?Kql+I2SKmJQRWzCdqwL3diHthqojEQR4ImCV4zkt7YfSSNuu+xTPnUTqYrcq?=
 =?us-ascii?Q?b0/Ju4Deoy3u8Ytz/sI2NWATEGiGxpsF0EYHgxvNVMA3a3gEFru+OTsOR1N+?=
 =?us-ascii?Q?J3jTK4wDlkkV9VpefkOiumfgmd7/gL3MYH5fpKsFB0IvGYusIXfOeSB6RPoR?=
 =?us-ascii?Q?+nZGlx5BjwPyK8B0Dxp/LoVaWhrzhdZexKuphp4f1O0bexNryVeNbYzn/7Fc?=
 =?us-ascii?Q?HMCi6nFYI7JC7nI6beb2pPn0SVCsFjxNlxSYNsL2uo1prGlnWVans+TtmLwm?=
 =?us-ascii?Q?oLZfPngRLKXBtT+cnQNnh4QwY5ZhtWIaMxRSyNzc754/Noe876Swe5G4CS38?=
 =?us-ascii?Q?uGgTdO5jVJ9E132wksPYMm1nxlD+TV6cOkDjVcMt8K5X+/Cob3XTBBB/+Poe?=
 =?us-ascii?Q?y9nj74T0NzGKszZjruGiL41o5FKwAjBmGNzjy3KT5Uyg/EH5XumglUXS4NMZ?=
 =?us-ascii?Q?6PLPO7wLFXmRtuHseH7oMlTJ8gtMMk/K/NSjSV6iuktSLHOKG1Dcsg04KWmU?=
 =?us-ascii?Q?FjJ3mTVtKOJ4vwpBFtyy82MDe+XbB48tqRWjx2LWF+T59aZ6LKGOJ5WcqZek?=
 =?us-ascii?Q?ZHWXPKWURQhQO10z0TNAiBtrVcwM/kicmUpKnGXwb7YQZBzOUljfI9oTTAAA?=
 =?us-ascii?Q?3NKvNOmWMWIErHH66M8DGLUzE26eOH8rRRypMW2VUU3gr095KVLwEAEZff1Z?=
 =?us-ascii?Q?aBxKGjoDJbEC5qDS1klsCrkLtydW8rpB3ntfSSZT0TRIQBTi85UeF5y3+WTS?=
 =?us-ascii?Q?LOqpkB6M6AbLBvgHdPJfsau0uhYmD+LiRD8ZzHgAZ+uUeEPcqRfZKAN825/8?=
 =?us-ascii?Q?Q7WrM+ff4MUKFE4G4a50ztErwKMVtnwHEd3E2E01F/+v3i+QvZGYDvI+T0br?=
 =?us-ascii?Q?hU6oq5xoDAUPDN0quPt7NAFRumEgDg/eq8Ek9EGMNQutnhwLbG/2MFEgxrhY?=
 =?us-ascii?Q?/6iSnz7XP8IAJrXGeGck/pHA82CENaiJpXlJOWZ9pOnVX1Mt4jJ2WRIU/kuP?=
 =?us-ascii?Q?QK5pw+eahw8qdInKJvnbxJPteG0LoZiuM+p3xGVwlBlCu+FYVZcPlU6blzqI?=
 =?us-ascii?Q?PlioCctcob8kOL+6PeVcIMvZU9nuattndpnJQ1Mu1cjhQIx88iZMEqeelPF5?=
 =?us-ascii?Q?KF7L5j3mrntSe2Y1GM2ufjBUGmK0VEZPU1qVAVLc5AFh5fQcsudkHGitiaQC?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mdGdTiahGltXUgGGhSdoaKFj4kYZvb/FC0i1ZFf4cPXxgCv2/u6139GkZOEVul0ScAvBq3mY3PdDwjgPnBgTwpXjhJRFHT0mbdatD3NIyYItHbRRlSXnECs9FZ7SWwfJ0eJy2oFEeHJp6rjbEy5aHPV8hgTg3tk9E0RGsrOsYco9ccH1pTnJK0gjpOHg3riyJeizHoTTk+sGCt5B5v26dMXjq2Ep2xhRrKd4bjEgtgYiAEoE561lfeOPjYThZSkgz0ySkje6sUY+ytcWaW6BZ2S9wOcMhGJAxrXFjfaS7FDEdFhcubHwnVjsGqukf3XE2UR6p8JGXbmDPu+MuFPtBPuwUXleGlek4Hca/TXmlZEHC7Nm8r5uqhaDGMIxbT+/TbWz57G4fkPwgZ6XBOMPOl8SEUUnnZA1uHzXVX0++3fYWUTTYQK33Ga+99rv++tYBHs4i8MVZOyzfcCrbNuCxLQK9B1+nisNcObVgZVkNZRAXcaN7NgXWWRLhWN3ZaLG9tMD4V7bnMaXXbvnSPZshfb2jV/jNlgJrZb+VGYlgeocOeHGm2n/X8XKkjc9rlJi1+k+DsJdVPyQhM+qzMCGLtyp3MGdtgUtqoRuyb2uH5GJ3yngsoD5zBZ3NCx69/GGyUc6JOWZBQDjcC/iPhzMeZSW1y2hX5dNaWBo4E7xkLCG03yLqHbcqSVxk9PsW3iUAEzzUz+KzM3KdfRPW2myBlgUR5UnZtT2Rufp7Iue47OLgn7T/+l9EBZm58IJam/mn9s/6SJbhQoMcO+ic3W7n5pb/buu4K5dHvGB7KYV0MMDIY+wUKKTq1Tl+Rnf1NxXMKZziKU/24qOjVWdAoqZUg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970ea596-90d6-48b6-a102-08dbc0f22923
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 13:44:10.9865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +w8FPIH1HMzhh+qnP52cNENtxegmLxj+h0ONFeZi4Ka/Slq4qArlU//BjplrgpDncdc9UftwKGcXXbczTzs+kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7838
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_11,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290117
X-Proofpoint-ORIG-GUID: Suaks98qkQnhy2ddYd0V25VzP_wM4QtD
X-Proofpoint-GUID: Suaks98qkQnhy2ddYd0V25VzP_wM4QtD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 27, 2023 at 09:05:10AM +1000, NeilBrown wrote:
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index b71744e355a8..07e7a09e28e3 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1694,6 +1694,147 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
> >  	return 0;
> >  }
> >  
> > +/**
> > + * nfsd_nl_threads_set_doit - set the number of running threads
> > + * @skb: reply buffer
> > + * @info: netlink metadata and command arguments
> > + *
> > + * Return 0 on success or a negative errno.
> > + */
> > +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
> > +{
> > +	u32 nthreads;
> > +	int ret;
> > +
> > +	if (!info->attrs[NFSD_A_CONTROL_PLANE_THREADS])
> > +		return -EINVAL;
> > +
> > +	nthreads = nla_get_u32(info->attrs[NFSD_A_CONTROL_PLANE_THREADS]);
> > +
> > +	ret = nfsd_svc(nthreads, genl_info_net(info), get_current_cred());
> > +	return ret == nthreads ? 0 : ret;
> > +}
> > +
> > +static int nfsd_nl_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
> > +			    int cmd, int attr, u32 val)
> > +{
> > +	void *hdr;
> > +
> > +	if (cb->args[0]) /* already consumed */
> > +		return 0;
> > +
> > +	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
> > +			  &nfsd_nl_family, NLM_F_MULTI, cmd);
> > +	if (!hdr)
> > +		return -ENOBUFS;
> > +
> > +	if (nla_put_u32(skb, attr, val))
> > +		return -ENOBUFS;
> > +
> > +	genlmsg_end(skb, hdr);
> > +	cb->args[0] = 1;
> > +
> > +	return skb->len;
> > +}
> > +
> > +/**
> > + * nfsd_nl_threads_get_dumpit - dump the number of running threads
> > + * @skb: reply buffer
> > + * @cb: netlink metadata and command arguments
> > + *
> > + * Returns the size of the reply or a negative errno.
> > + */
> > +int nfsd_nl_threads_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> > +{
> > +	return nfsd_nl_get_dump(skb, cb, NFSD_CMD_THREADS_GET,
> > +				NFSD_A_CONTROL_PLANE_THREADS,
> > +				nfsd_nrthreads(sock_net(skb->sk)));
> > +}
> > +
> > +/**
> > + * nfsd_nl_max_blksize_set_doit - set the nfs block size
> > + * @skb: reply buffer
> > + * @info: netlink metadata and command arguments
> > + *
> > + * Return 0 on success or a negative errno.
> > + */
> > +int nfsd_nl_max_blksize_set_doit(struct sk_buff *skb, struct genl_info *info)
> > +{
> > +	struct nfsd_net *nn = net_generic(genl_info_net(info), nfsd_net_id);
> > +	struct nlattr *attr = info->attrs[NFSD_A_CONTROL_PLANE_MAX_BLKSIZE];
> > +	int ret = 0;
> > +
> > +	if (!attr)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&nfsd_mutex);
> > +	if (nn->nfsd_serv) {
> > +		ret = -EBUSY;
> > +		goto out;
> > +	}
> 
> This code is wrong... but then the original in write_maxblksize is wrong
> to, so you can't be blamed.
> nfsd_max_blksize applies to nfsd in ALL network namespaces.  So if we
> need to check there are no active services in one namespace, we need to
> check the same for *all* namespaces.

Yes, the original code does look strange and is probably incorrect
with regard to its handling of the mutex. Shall we explore and fix
that issue in the nfsctl code first so that it can be backported to
stable kernels?


> I think we should make nfsd_max_blksize a per-namespace value.

That is a different conversation.

First, the current name of this tunable is incongruent with its
actual function, which is to specify the maximum network buffer size
that is allocated when the NFSD service pool is created. We should
find a more descriptive and specific name for this element in the
netlink protocol.

Second, it does seem like a candidate for becoming namespace-
specific, but TBH I'm not familiar enough with its current user
space consumers to know if that change would be welcome or fraught.

Since more discussion, research, and possibly a fix are needed, we
might drop max_blksize from this round and look for one or two
other tunables to convert for the first round.


> > +
> > +	nfsd_max_blksize = nla_get_u32(attr);
> > +	nfsd_max_blksize = max_t(int, nfsd_max_blksize, 1024);
> > +	nfsd_max_blksize = min_t(int, nfsd_max_blksize, NFSSVC_MAXBLKSIZE);
> > +	nfsd_max_blksize &= ~1023;
> > +out:
> > +	mutex_unlock(&nfsd_mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * nfsd_nl_max_blksize_get_dumpit - dump the nfs block size
> > + * @skb: reply buffer
> > + * @cb: netlink metadata and command arguments
> > + *
> > + * Returns the size of the reply or a negative errno.
> > + */
> > +int nfsd_nl_max_blksize_get_dumpit(struct sk_buff *skb,
> > +				   struct netlink_callback *cb)
> > +{
> > +	return nfsd_nl_get_dump(skb, cb, NFSD_CMD_MAX_BLKSIZE_GET,
> > +				NFSD_A_CONTROL_PLANE_MAX_BLKSIZE,
> > +				nfsd_max_blksize);
> > +}
> > +
> > +/**
> > + * nfsd_nl_max_conn_set_doit - set the max number of connections
> > + * @skb: reply buffer
> > + * @info: netlink metadata and command arguments
> > + *
> > + * Return 0 on success or a negative errno.
> > + */
> > +int nfsd_nl_max_conn_set_doit(struct sk_buff *skb, struct genl_info *info)
> > +{
> > +	struct nfsd_net *nn = net_generic(genl_info_net(info), nfsd_net_id);
> > +	struct nlattr *attr = info->attrs[NFSD_A_CONTROL_PLANE_MAX_CONN];
> > +
> > +	if (!attr)
> > +		return -EINVAL;
> > +
> > +	nn->max_connections = nla_get_u32(attr);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * nfsd_nl_max_conn_get_dumpit - dump the max number of connections
> > + * @skb: reply buffer
> > + * @cb: netlink metadata and command arguments
> > + *
> > + * Returns the size of the reply or a negative errno.
> > + */
> > +int nfsd_nl_max_conn_get_dumpit(struct sk_buff *skb,
> > +				struct netlink_callback *cb)
> > +{
> > +	struct nfsd_net *nn = net_generic(sock_net(cb->skb->sk), nfsd_net_id);
> > +
> > +	return nfsd_nl_get_dump(skb, cb, NFSD_CMD_MAX_CONN_GET,
> > +				NFSD_A_CONTROL_PLANE_MAX_CONN,
> > +				nn->max_connections);
> > +}
> > +
> >  /**
> >   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
> >   * @net: a freshly-created network namespace
