Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92736D0EE5
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Mar 2023 21:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjC3TdK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Mar 2023 15:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjC3TdJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Mar 2023 15:33:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C379CDDC
        for <linux-nfs@vger.kernel.org>; Thu, 30 Mar 2023 12:33:08 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UHNlia012533;
        Thu, 30 Mar 2023 19:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Vl9F0Ic9WX1uWyaRrNlP5MY/sdp8QHVITncyCDDBeEI=;
 b=SxWrLlyVinepl83esrd8SsCOB6Xae0238wcgM8/gRGqXK8WlwPcQpqXIxBSuvpYQ9wzx
 f7jyYiEFYk4JQhx8HD11N8HIsJOd162BMsS4+ODp9GnnOxRaJmkkfUNcHobBmQW4j9Zu
 NI6uXYlLwrMjU8o9nIXiAx9ISgB/m23n8E0me9B6TBO9LptPmBx6pKs2qHiOYd4OJ/2o
 RFbo3pOmqawMDtCxAOiKGdGq/yK2q/7dlyCjKBV2AOe4WP4zA8C71+wO3FbhsKUtGlHj
 1SuQGmyAmlztgJsLavK+LSWTOXwJj9O90yWlRhHSQqS18yC1nPyz/2UKroAvYXL7Nt1M aA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmqbyukhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 19:33:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32UJPlCV035025;
        Thu, 30 Mar 2023 19:33:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd9whmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 19:33:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTIYHySYxmeev/9tYdEro2KD5V77wh0QSINnHQxiJhJdURdJ1oWU25AuzcXB1BFslczHiU2BoAjq60tXLaldnfaT2otngMxDgpbQESqFl3tRumZ7UjVbGW+Mx0PeV2NOEC9orVPLtucDzECe0r/KzW1YXrZS7KOa8x0Z4yLWOKcyltdeDN88wkNZGDXYFD78yyW+9xyhko/FwTN5KPcnAiOq7GxvfXDK2gshAT08YmO6LpTpZ4SAaaahQnDKRbM0Y0/VY7bxd+RrhH83jhEb49FgUmZst3ZkICvkO727N7WFRvljw/hQiVJuzMmUGIEUitPIUW/UyD/i9uAvT0BxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vl9F0Ic9WX1uWyaRrNlP5MY/sdp8QHVITncyCDDBeEI=;
 b=RWTFWIy0F3qj5mvccmE0xI+wvzYcLuVCA81OaYAuWYy1ZvOti5R0q2tGSnB8HasgfxYtl+Ivwn8X5djnOPFMZrFTuH2gIlL6Lt6+FdQIZvhuB2AfBrkhxpYUlHb7C9ym7lJZEYSj0p1KWM7lqNLD3Du3M64lwE/f48KCpd2NJbKITjspJX3sbmZAZKP9u9LjAKceDmoN6LjMevFFh6LLuEIIZea71qiPJIeGIeXQ9QaSJp62GJ894gwG15BInH2xRdpcFqNB7z1v5FW1Bq1UbSgLp/fiVfWi/QM3whszl4tMp2DJJZ9sNb9eMEO6SdEDS/uvN+MXn7sMx8W/fspjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl9F0Ic9WX1uWyaRrNlP5MY/sdp8QHVITncyCDDBeEI=;
 b=skyGUapn0JbkNtEBs6MpCZzkfIzz0WmUHqWA5qywasVV8KvfFatoW1tkU9uOgyx3vxuY0fUKxxEMXfr9Qx5jf+u5N08BfbiHFGe9SXjJF44y/Rny5NwB9jaLcok9YAi4XgdfcxPE4gY0PUqEHcylYi0zBlltbhCTv5w/2S/ZTJA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4434.namprd10.prod.outlook.com (2603:10b6:303:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:32:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 19:32:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: don't allow OPDESC to walk off the end of nfsd4_ops
Thread-Topic: [PATCH] nfsd: don't allow OPDESC to walk off the end of
 nfsd4_ops
Thread-Index: AQHZYzl9HlZwrqYmSU63s1AkwBklFq8TtmcA
Date:   Thu, 30 Mar 2023 19:32:58 +0000
Message-ID: <3EA9A5F9-1F2F-4C90-8363-A357278D8C63@oracle.com>
References: <20230330185729.22895-1-jlayton@kernel.org>
In-Reply-To: <20230330185729.22895-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4434:EE_
x-ms-office365-filtering-correlation-id: 1b88abef-56b1-4eac-ebcb-08db31559164
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oJgBnF4Sgh8MXAYj8YZPH+UEsYARPqIuzB+ZWP24I9ls1tBja5wOay25DWL/n0Fmj4o441CdnTByeY/BWihqsMyUrxCg2to9n/1rbxh/u+MvXF5NKOdePe3Vw/I3m0zkAk+FK7P8r38dd2cpMcTzCxdD2bupCZ9bp8jKkt3qtXTs1b3HxhJHNSl+lGp6opdw+vYWFq06dgdydlrJH9yf5VipmQw8gW3wM9ZzxSfGMpegyzBYxjcBoBdZAZoDOMfY3aeOHgNfbG/xZykUH98FTS+QYNTMdQn6yLBF8CAeMQpdIDgjmajSHUlkg+vVnrAX9GH1hWMYW28HWW+HH01S1DwfxnfcOdUF2YtDWBG2q03bxI2hQWTF3Bz4fFvSwi/vDvzjOztdvIjQlIAUDOBvKbyfbhSbSA0YldXiCOx47c4PRKpYFVMNO9V6XFba6OmUL7DZNLyEdOkRj9xdYoU8LqJRLFaimDGpFNyzsFY6m78UAEbEBYK4Opp+FrjJejo56VlIyH7Ri24TSa2Br8GV34b6OU+TR6dax4nVYryC3+e3hbDCldSDMN/dHPWyMyPAxfC1v7/DYmrCpWSlDJcEJ40ZelomihURTdOaxjEdhcgA/EnrErImyURWtYzeCI/5ucdhafQh+dh3e7YTkQ3tsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(38070700005)(2906002)(38100700002)(8936002)(41300700001)(5660300002)(36756003)(86362001)(33656002)(122000001)(71200400001)(478600001)(186003)(6486002)(6506007)(6512007)(53546011)(26005)(2616005)(76116006)(91956017)(66946007)(66476007)(83380400001)(64756008)(66446008)(8676002)(4326008)(66556008)(6916009)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lTZP0GxBHbeaQ3KN2BWHgCidq6LxSqmd7yOrQhJallYh+8NXjZeCmQehLhcs?=
 =?us-ascii?Q?isjVWp1PksTmNlnjPk8+WS/g5fZwZuKU0fd7uZNX746vAA0nMf4DFDijAo8l?=
 =?us-ascii?Q?fLN+1bL85YeM6IpjQT014XjPC7Ttu9P1C3pUZRrj+eEcUgpUEx5TN7Rm9tnG?=
 =?us-ascii?Q?WR1ktETSbjMnPrM1f5aJC5uDBS7MbQq4p0ndgpMqWGWVYJYdxkWtU3QJkIxP?=
 =?us-ascii?Q?+r2ZwOkupyVJpssS8TyLceXPiJE28uwIoKVaa7h8Grn6zIVSerP1J75vdje/?=
 =?us-ascii?Q?2oN7ngKxNbfnGvLDrO0qzKDE17rQnMZBoT3CSi/CJ+EoM79D4blQ1/t0YEFn?=
 =?us-ascii?Q?GFjsWNMHgZ7rGYG8Eo7i/3I/1oslxjkve3DvLo9RhjFiJ7HzveHxZ8HKEIm9?=
 =?us-ascii?Q?4zel6HjYBQoUdgotUycUiAOJOaz8tyedOggDpj766MHYoT8LnD69WL9iByz/?=
 =?us-ascii?Q?SIOwcJDQN8vyNqf5NKH0CXlxFo7Izkfm1HBsTsoU7siKh9V1mx814+gresca?=
 =?us-ascii?Q?ucNrXUZS/Qnil+u+9yPycajHOTTQ850KfDH6Gb+Bf5eTMD9/EycsSvpAkB9P?=
 =?us-ascii?Q?EMB1FOHi9H6Fm3eBcOeyx9qEN8wiPrP6/a9QdgFD6vaaQXt5dmjV+DcpFktE?=
 =?us-ascii?Q?HePQR7myEpJC3ZpZlyDjitfGje1dd11LotCLR/26Z8f2LOEU3iV1xl9JJeBs?=
 =?us-ascii?Q?MnI3ytO8xT96N2gvXFJ4t32MEA+fJVhdSIzPOQkh44/phKrnpCeaTllS47zj?=
 =?us-ascii?Q?Tx6eEEBXds9Dg2Ml8SI80hqWEfqwIqCYwdMcjs8MieIvcLAmUTfuOHSdiEJQ?=
 =?us-ascii?Q?/57PgVOHI03HFzEoosMi3ZQpB++LFfgNd1tIvCy9ml5+nEgv5J9aH2XaRnpW?=
 =?us-ascii?Q?sKFz+LviriPOIK/ML8CUclhE65AnAn5tF59kr57g4nnwavsu3Lq1kE0yu9YT?=
 =?us-ascii?Q?ML5NCD1U3J/Ihm5OBiLoyjCNU69iuRx951QODpWlgKzAdP6mEbIzrGzvsToA?=
 =?us-ascii?Q?zECXkTZg5nm1aEDTMxZDfnNi0+xN5OdFqyYqhobtZBvo1m8htU4fugxqq1MW?=
 =?us-ascii?Q?DZuDBXQ6nsRRSHiuPR4lmke41QexiSLXpdvQhzyw0HSdMQBWc0dpYPXXFtnp?=
 =?us-ascii?Q?SLhQuml3yfgZhi26mIS+t+nf97TwUFTwUok4NYMjeT4BsS1lulDwIHBhq/tC?=
 =?us-ascii?Q?+4K9IS4YzI/nftsO0iGvb3Wdhc7eFvudQnqXHiEOINMNM/L7RGxH0mdm4gIW?=
 =?us-ascii?Q?j2R4VQ9OKyQY9aeUlBU1f2nN4Tv00qZ07FWNOabUesLroDvNywqlGP16djCN?=
 =?us-ascii?Q?pZpPIB1C7o8UJeOcvx29RULFWeRRQ010phCrogCiRz1+oSM518yeTW5sBprr?=
 =?us-ascii?Q?rmWXF3qxgn1h9f8SHlaiSYsez6khF6WDB2BF1G5511sWNbXAoE+4RJTqJLQZ?=
 =?us-ascii?Q?CZtFWgElkwT96ryi2UW783nbaxrIniug+QfWc26mlVSfrTmrLUSjBs7+XUU/?=
 =?us-ascii?Q?y2iDzsuyYm8wcnYJ7Cth6ALt+ej+2haoj+Z41v592oQjaamxicZJ9kWMLwzp?=
 =?us-ascii?Q?i8zAVfx49eU58Mw+tAdVL+44s21OLxzyF900j4k3N3ABSvP7cRn4HfWi19qK?=
 =?us-ascii?Q?mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2DAF9D918A7913478EF449FDC8A57E91@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3OfkIChPx4JWRyvOighmNWK0xI2wfXjxn75Wp+C71mJ2xU8sCXsz3SgES/DE+Ja+X4lKkQcfEC20lNCW5WhDU77mDjN66poobx+2kP7GQWrYfiiub4kYu484/Ve2ZU+aJzcW/edA/p3/+FN5XyEu0pojVjHHs8PJeoQNEUKpJCziuJKaHDap30kZstvgO62nItVv0Z2nXtSS2KtYIXbwzKaB3K0Pidt+W1jmK5S4JLo8oPW7XHmUIQI4dcs812sDwVteDlilnehy0q1GDw2PB21VidafQbMf73wU3GfFNkA/GsTNWCxRSfndiyVLFirnLrFu8C3eKdnUUFC8L500k2X/0vqcn0HOBpejwIyVXOg7HfAQatULtdrD5lWftpTjJBiOioqQlSTxyzqZ7BzovOIpBz5lPPjK+cUDgre29YGXvZQzqA4XdsYTkcm/IvIvRNNMVATVwYlJPYGdaO6D87C6OKKI6O3QBic0NCVpNe56hVgud5sXd8EXEZ4Ubk6QNWL+N7yuHOiZikg9GeTPRjTP1cVBwaFyp+Pyp4woR84PGt7Kz4jEw5owX2B/1TzbOPmDeQ1gdgA8cumG+0zjPrbaUGX5POvaGx6EFMSg9bp1n0XUkkB9B+fgbGzzAkTuogw1Iqar73xSEKJswc3wBNnulc2xJXB5k3yj+FyicwbF6mSxp3UsBp0rBKt8CtUv0GkU2dUYTBxzqGg4yYDeKoYnpTB0w+tL6Pwn/1UlUrzPYKWXMyrWiJKZKNiLAEv0BiMi+CDnoDPSg9ZMNmxC+qCqq6P531imAXsKOaH8zg0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b88abef-56b1-4eac-ebcb-08db31559164
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 19:32:58.3742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MV1jyJMCcW8PM05YBNPHk8k7wTXXxjX/Sho2cB+fe7LQqtQk9ErXR4cRSlWSHBVI9o1C0QG7wiH9csSTXe1dDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4434
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_12,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=855 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303300154
X-Proofpoint-GUID: OgIaHx0GK17gZR9QDTv-pGkIxbGqJu8A
X-Proofpoint-ORIG-GUID: OgIaHx0GK17gZR9QDTv-pGkIxbGqJu8A
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 30, 2023, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> Ensure that OPDESC() doesn't return a pointer that doesn't lie within
> the array. In particular, this is a problem when this funtion is passed
> OP_ILLEGAL, but let's return NULL for any invalid value.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/nfs4proc.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> This is the patch that I think we want ahead of this one:
>=20
>    nfsd: call op_release, even when op_func returns an error
>=20
> If you end up with OP_ILLEGAL, then op->opdesc ends up pointing
> somewhere far, far away, and the new op_release changes can trip over
> that.  We could add a Fixes tag for this, I suppose:
>=20
>    22b03214962e nfsd4: introduce OPDESC helper
>=20
> ...but that commit is from 2011, so it's probably not worth it.

Well, my concern would be that we want this fix in stable if the
op_release fix is applied as well. I think we will need to either
squash these two or mark this one with an explicit Fixes: tag.


> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 5ae670807449..5e7b4ca7a266 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2494,6 +2494,8 @@ static __be32 nfs41_check_op_ordering(struct nfsd4_=
compoundargs *args)
>=20
> const struct nfsd4_operation *OPDESC(struct nfsd4_op *op)
> {
> +	if (op->opnum < FIRST_NFS4_OP || op->opnum > LAST_NFS42_OP)
> +		return NULL;
> 	return &nfsd4_ops[op->opnum];
> }

Several OPDESC callers appear to expect the return value will be
a non-NULL pointer, so this will either crash the system, or
crash the human reading the code. ;-)

Besides, those callers appear to have already range-checked the
opnum (on cursory inspection). It's only nfsd4_decode_compound()
that looks dodgy.

How about something like this (untested) instead?

NFSD: Don't call OPDESC with a potentially illegal opnum

[ Fill in your description here, or squash this patch ]

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 97edb32be77f..67bbd2d6334c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2476,10 +2476,12 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *ar=
gp)
        for (i =3D 0; i < argp->opcnt; i++) {
                op =3D &argp->ops[i];
                op->replay =3D NULL;
+               op->opdesc =3D NULL;
=20
                if (xdr_stream_decode_u32(argp->xdr, &op->opnum) < 0)
                        return false;
                if (nfsd4_opnum_in_range(argp, op)) {
+                       op->opdesc =3D OPDESC(op);
                        op->status =3D nfsd4_dec_ops[op->opnum](argp, &op->=
u);
                        if (op->status !=3D nfs_ok)
                                trace_nfsd_compound_decode_err(argp->rqstp,
@@ -2490,7 +2492,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp=
)
                        op->opnum =3D OP_ILLEGAL;
                        op->status =3D nfserr_op_illegal;
                }
-               op->opdesc =3D OPDESC(op);
+
                /*
                 * We'll try to cache the result in the DRC if any one
                 * op in the compound wants to be cached:


--
Chuck Lever


