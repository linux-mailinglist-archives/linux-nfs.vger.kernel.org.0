Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3FC58424B
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 16:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiG1OyP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 10:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbiG1Oxr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 10:53:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18DE68DF7
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 07:53:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SD2lSf018062;
        Thu, 28 Jul 2022 14:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=zr6xhBfAcYt+Auv2NRQINqx7Dk6Qxd5b/s1YiB/aMn4=;
 b=E/t5Dfy/YAEnQdAal10XEhGm5DKThBmHCBSWyH82FBBbZn6eYECvDmOBwHRzw6SPb70e
 p0WJoOMIm/0HNgGJJEdngdLDshlWoFRdXbyW0gHPS5S2JptMEVDIu35zKySBqSC2J22X
 u3wDzh2rUk89rOKX0Dd9JdLGNmIWnVzkfkvFDd22pJrCpDhVMAE/iw8quw6/qr/v+nSt
 W/WY175hphYu+EQ+7siZNikfPYHK9OnJ1gNIXyyQqOEgmoUBmJJfFtt/Q5m6ozk6gPlS
 Wj5hz93so52AUuOldnAKXCUKGbFI8qKj6Z1yspyuP2KWcNNpSaNKEUQ+9phGwXetcW6U jQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a4vxjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 14:53:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26SDi7qN019886;
        Thu, 28 Jul 2022 14:53:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh63ap7vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 14:53:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhubyelYus4VAvz/ihsNTkkOauum3mXKItM7MpEH0p7X1lFu4HHUuaZ6UtKGti+GXImkfFo+YiSl8IzvjbesmPOhiv1Kw3GT+XX7+YicqANJRHzfhtSUp0RXZNvHAf5zJuNLvz+VSCPBWfbfh72lrb7iK+RTNVZG3AHvYadfqRXGMbPKu+Wz7sifT2CKMKgti8OgPW+x07w51iitU6dCVfT7mRePew7rJ+7SSX0I82FYlu+UiwtODMaIiMOkE8MYTd1ti0X1AnTB7RVwOjmYJgNQaatyEsicA8qe5aatS1SU+6XYbvP8g1CSrK8aC685ebvTdBHzt7me4wSjPvDM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zr6xhBfAcYt+Auv2NRQINqx7Dk6Qxd5b/s1YiB/aMn4=;
 b=L2jwN9NsQRQ6LvXm/RGzg55Ds+U7pQmpKwC+2QCiv2loYiIbRXIBE0gN0Qx1lwhITlFnT2zEZQWdcIDHd0aDAz1MMwCcHf655vU580hvFCPtgD2UMSzSSnGKyrwDOsNYBNfpcNAwsdrM+yWJ7xrsGu4qts2kL6g8bzQod826jGJ65c3OzHAQ5EcHEBk0479YgepDZA+UTa9LnWRaT4MXkJpEHPnG+/pltZioU7RFsOQt4iH0DpMv5IHm2X9l+FBDkZzfvN1/o9AjfpS3twkLUnAgl76hECCNEYSjZ9gXrbTi0ieCmP3LtDWyBKFI0W94Hps+FPQB7Uj46LSFuufW+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zr6xhBfAcYt+Auv2NRQINqx7Dk6Qxd5b/s1YiB/aMn4=;
 b=PEkthE5stTsczIFGuDOSenyHSUOG7wgIzGQMI+mynw2nscsh7AeWCs8FPEz9KpTWWvwIrZlZu9zkeao7LmLusqDdBSeQbdDJVUrxJQ7hQmzLVtG1C/VynhsU55cXXu9sl1hhmGhJ7Yln4XPyIkiikcIR2PwLBwM3LWYy84fLNN4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB3752.namprd10.prod.outlook.com (2603:10b6:610:d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 14:53:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%9]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 14:53:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 03/13] NFSD: introduce struct nfsd_attrs
Thread-Topic: [PATCH 03/13] NFSD: introduce struct nfsd_attrs
Thread-Index: AQHYoLuXMGkEW23+L0CNVzVgwM71eK2T4gYA
Date:   Thu, 28 Jul 2022 14:53:06 +0000
Message-ID: <BB1B64F4-8949-4315-9D19-6A2D5FADC840@oracle.com>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
 <165881793055.21666.3761329899598926055.stgit@noble.brown>
In-Reply-To: <165881793055.21666.3761329899598926055.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f74de9f2-58e0-4c38-fcff-08da70a8e19c
x-ms-traffictypediagnostic: CH2PR10MB3752:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I6FEWe7mMJrH4KmHTcF9Hheq1ZRGug5mAva4khHSDAx3NM/+y4qyJepya+Bk+EcxVfC1wvZ1vEkvgF3YtYnfQhqZU/NXBZXDekIVEsb7uvjgupNAd+EEZJbhvSEVO5Nh3R92xeWKPJA3PPTvGcccutLw8S5OFEwSVvPbWK5xM0Lz6B+H5SCbecOSE1V0J/kM0Gb+oD0aijXsnEM7dFCUdqfGrUsrnk4fxCHS9KG5mSxqhnwBnyFlC7W9PH2eCxRRYNs9tdmUXOX+L4/J/jq+Q+lHTEbjn5gEo30Gbv7tNcxJTcqpzyGb2ImJDtCOCRd6t/HZ5CtWOi9PXw6anFbYbd1XKfxC6DZb392c2VF5LKJFFdEHyJnj2ipSARg1/MDHBLLIrDrJHHjkqiSOsx1aQdlhEby31abxMC7R11+r+U6ofCHpwcCePFCwRBg8f3tRkger7DnWXGQMbl7ytFa0DsHbFLR57tedjCz6dAYp9W/IRSCOAK/HjhenpOggAfP9BgZZi8l7t1ZsbfLT8OtMb1P2DHC0wYy2O/zOqHnyXAGJd3ltd1H04J41UJCJFuMBjrGRzKIeg5vcTsz6F9/WqakzecJ1JNFUhZ/Hwvko0fuiB1IS3ESXLNOyevOK/D17EAnLEsJp6w/1ZcGOjuz2imBm8LPx+OjW6sITewJLcPjhH+ismOEPPCZIvEmS+CLZncUHrKIj1dA4mNny+xWNrQwlr49XVRV+BYBv/gKjXnFmO25e+3aaGEz0Yj52d6iNmjEHvz0JyXBgeAasffL+bm8miLthjpygFoZZf0B3BVsqmJfm+xtjJSEX7bcd+FQ7UazMw70qv55fGRTZsKfdkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(136003)(346002)(396003)(376002)(6916009)(2906002)(36756003)(54906003)(2616005)(41300700001)(64756008)(86362001)(316002)(33656002)(30864003)(122000001)(66476007)(6486002)(91956017)(5660300002)(6506007)(66946007)(38100700002)(8676002)(6512007)(76116006)(4326008)(8936002)(26005)(83380400001)(186003)(478600001)(38070700005)(53546011)(66446008)(71200400001)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F/kzbytXvl/i5O2Y0wBdMKDdtWVFu/bsgZfr8CB3MZp/4Qe7JgVidJ154zgq?=
 =?us-ascii?Q?2WNPE3MoQ9CN2JUdP0OX+mo/lGSg/JHLNtrglv/wwJXyiVTwX+bVOiJnpVrH?=
 =?us-ascii?Q?tGZOorgaTQ/Nj54+UcD+tIr5B4BlgTho9Et+sumROVACwvJx+WZcEokaPmlR?=
 =?us-ascii?Q?YwNS0gSeEwNOWVjqTXtaDQloZ+gUToM0hMIdeqX2LC1qzuohk3lGx7hES1uw?=
 =?us-ascii?Q?UgxhvN6GPY+nqD46kuGLUq0NppWD5xmf3ZqGT4RWb2UKJ38GSUYYBOBKhqiX?=
 =?us-ascii?Q?EGXBg5V+NUqDHo+Yo+QoKJSp/fCd//vDDwtEw/7JFpduM/+m9Nlduoi5lbVF?=
 =?us-ascii?Q?d/EnlRtS8uXnjzKyoH56Bke/tcBl8fe+NZ6ig/gatXcn9T77fJo3kdPrGFyq?=
 =?us-ascii?Q?hg1b4wYcTBy+J68prTfOsKBsfxANyN3gUnA2Y9UbRG4JH4rBet/fUs8PimG8?=
 =?us-ascii?Q?0lXrpQNWla9wrped2q8EGOhK+lXeYsQXIF19COpJmTNP1xzOorZZL5TCZC6Q?=
 =?us-ascii?Q?J4uOC9cBN4RztrWPaXNNQ1BLE//6BQIatotr2zFLX2Vp3/O5+dC4TMhiUAE0?=
 =?us-ascii?Q?tK0ygU7S/olKktqx2ZI1iv5DoxcTikTN4/FgLXwBDQ0FlepQtpU/NcAndAux?=
 =?us-ascii?Q?hYfEGRKI+ZLyLVK6bQNRwM5S1szGjEPCFOJtJhrPhi25ejYVFsEwVuGlDMdy?=
 =?us-ascii?Q?hvBRSF0cG5pH9qZpqieQxRjAjQbX36Z/Aw91UBAofBXrhTQQPPKOdCiL76Lx?=
 =?us-ascii?Q?D/7GlmBKhivaqz55EUMFDOgBqmWtIel2wHvx3Mys8PZ+vXqdWBg/lZB+PApQ?=
 =?us-ascii?Q?VXbgtdCSziyb1ueeypu+0tozZT8lEpO4LeUpfxkxF5HE5N+Bh8SDoRdgKAUW?=
 =?us-ascii?Q?hnpHSLFK1DIGti/7ZzKKoY1Ihrtyog7AP7LDca3IBSGioAeQeUoPIo2Kt3GX?=
 =?us-ascii?Q?r0AcxKeAkXQS2fXMXKG130b/+pIqTXSF59pkzn+EJ8dSEg3qSecQZ3Ly8vVn?=
 =?us-ascii?Q?dfpKcFpg6oNMYlFgKdpld7RPmgmPKRJCrELzJT6B5bkOWV+PusahcEF9pM8F?=
 =?us-ascii?Q?eQn/ae7NnG3KMVhvdkH1VYYXPpAzVo9heKCOtOmeGJkj7agdTOOXq5RpN1iB?=
 =?us-ascii?Q?6pHsanl5q/gLej4WGskLnFeq1Lzr30mZQ/+X5MqjhSdI4M4dMHo04J6rMBmq?=
 =?us-ascii?Q?Oujp7cz//v2i2Ca2bCi9ZyeQ7DvTuYJT8KGnYsv9a82pRgfsbk+vzdu30odM?=
 =?us-ascii?Q?ag+qptMca/xxYHhJiiqYyrHSHA73UEzaZfeL1ackOGZZrIHEnsDIvIsdJ4u3?=
 =?us-ascii?Q?8apGCecRDZzykX62qWCRbtPmt8VoVXYa4ZyKgay57Z/obppg06Ch3eI05JaK?=
 =?us-ascii?Q?+JNZdfXGfDhaOa8gFaDjlf/VkKgw68dibJwrnkUMOkwnpyf1Wu7XMm9uk8Rp?=
 =?us-ascii?Q?pSd4++9V0VlmwwCGqn37Omu79brw5mcgV01EQ1IFolbgLHjFiyuSAQfaJ/Wh?=
 =?us-ascii?Q?nepmlMZ+fKsX7Qy2xtKIVsJnlFtYW8jHBQ7JrD8tRgkKVz1KxKKPGnxlugTs?=
 =?us-ascii?Q?osYv8hE5lOKRlM+WSfUC83pciDqVOg/g7vn34vqBm9Cugwhocy+u5BXhb32s?=
 =?us-ascii?Q?dQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D966C634C593F543AFF2FB1841CAE514@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f74de9f2-58e0-4c38-fcff-08da70a8e19c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 14:53:06.8012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gm1mX/DyuzHefAvgAeMkw8kMdptiNxnPImXYPyo/IK8M/0werlaXfAlfvMTlpQ1H97V9B4TbTFjW+ejPArS3Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280067
X-Proofpoint-ORIG-GUID: LZyQXbUL3cVqUC3Pr7FZoTKGbbnZfYuZ
X-Proofpoint-GUID: LZyQXbUL3cVqUC3Pr7FZoTKGbbnZfYuZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 26, 2022, at 2:45 AM, NeilBrown <neilb@suse.de> wrote:
>=20
> The attributes that nfsd might want to set on a file include 'struct
> iattr' as well as an ACL and security label.
> The latter two are passed around quite separately from the first, in
> part because they are only needed for NFSv4.  This leads to some
> clumsiness in the code, such as the attributes NOT being set in
> nfsd_create_setattr().
>=20
> We need to keep the directory locked until all attributes are set to
> ensure the file is never visibile without all its attributes.  This need
> combined with the inconsistent handling of attributes leads to more
> clumsiness.
>=20
> As a first step towards tidying this up, introduce 'struct nfsd_attrs'.
> This is passed (by reference) to vfs.c functions that work with
> attributes, and is assembled by the various nfs*proc functions which
> call them.  As yet only iattr is included, but future patches will
> expand this.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> fs/nfsd/nfs3proc.c  |   12 ++++++++----
> fs/nfsd/nfs4proc.c  |   17 ++++++++++-------
> fs/nfsd/nfs4state.c |    5 ++++-
> fs/nfsd/nfsproc.c   |   11 +++++++----
> fs/nfsd/vfs.c       |   22 +++++++++++++---------
> fs/nfsd/vfs.h       |   12 ++++++++----
> 6 files changed, 50 insertions(+), 29 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 981a3a7a6e16..289eb844d086 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -67,12 +67,13 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
> {
> 	struct nfsd3_sattrargs *argp =3D rqstp->rq_argp;
> 	struct nfsd3_attrstat *resp =3D rqstp->rq_resp;
> +	struct nfsd_attrs attrs =3D { .iattr =3D &argp->attrs };
>=20
> 	dprintk("nfsd: SETATTR(3)  %s\n",
> 				SVCFH_fmt(&argp->fh));
>=20
> 	fh_copy(&resp->fh, &argp->fh);
> -	resp->status =3D nfsd_setattr(rqstp, &resp->fh, &argp->attrs,
> +	resp->status =3D nfsd_setattr(rqstp, &resp->fh, &attrs,
> 				    argp->check_guard, argp->guardtime);
> 	return rpc_success;
> }
> @@ -233,6 +234,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> {
> 	struct iattr *iap =3D &argp->attrs;
> 	struct dentry *parent, *child;
> +	struct nfsd_attrs attrs =3D { .iattr =3D iap };
> 	__u32 v_mtime, v_atime;
> 	struct inode *inode;
> 	__be32 status;
> @@ -331,7 +333,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> 	}
>=20
> set_attr:
> -	status =3D nfsd_create_setattr(rqstp, fhp, resfhp, iap);
> +	status =3D nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
>=20
> out:
> 	fh_unlock(fhp);
> @@ -368,6 +370,7 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
> {
> 	struct nfsd3_createargs *argp =3D rqstp->rq_argp;
> 	struct nfsd3_diropres *resp =3D rqstp->rq_resp;
> +	struct nfsd_attrs attrs =3D { .iattr =3D &argp->attrs };
>=20
> 	dprintk("nfsd: MKDIR(3)    %s %.*s\n",
> 				SVCFH_fmt(&argp->fh),
> @@ -378,7 +381,7 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
> 	fh_copy(&resp->dirfh, &argp->fh);
> 	fh_init(&resp->fh, NFS3_FHSIZE);
> 	resp->status =3D nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
> -				   &argp->attrs, S_IFDIR, 0, &resp->fh);
> +				   &attrs, S_IFDIR, 0, &resp->fh);
> 	fh_unlock(&resp->dirfh);
> 	return rpc_success;
> }
> @@ -428,6 +431,7 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
> {
> 	struct nfsd3_mknodargs *argp =3D rqstp->rq_argp;
> 	struct nfsd3_diropres  *resp =3D rqstp->rq_resp;
> +	struct nfsd_attrs attrs =3D { .iattr =3D &argp->attrs };
> 	int type;
> 	dev_t	rdev =3D 0;
>=20
> @@ -453,7 +457,7 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
>=20
> 	type =3D nfs3_ftypes[argp->ftype];
> 	resp->status =3D nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
> -				   &argp->attrs, type, rdev, &resp->fh);
> +				   &attrs, type, rdev, &resp->fh);
> 	fh_unlock(&resp->dirfh);
> out:
> 	return rpc_success;
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index d57f91fa9f70..ba750d76f515 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -286,6 +286,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> 		  struct svc_fh *resfhp, struct nfsd4_open *open)
> {
> 	struct iattr *iap =3D &open->op_iattr;
> +	struct nfsd_attrs attrs =3D { .iattr =3D iap };
> 	struct dentry *parent, *child;
> 	__u32 v_mtime, v_atime;
> 	struct inode *inode;
> @@ -404,7 +405,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> 	}
>=20
> set_attr:
> -	status =3D nfsd_create_setattr(rqstp, fhp, resfhp, iap);
> +	status =3D nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
>=20
> out:
> 	fh_unlock(fhp);
> @@ -787,6 +788,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> 	     union nfsd4_op_u *u)
> {
> 	struct nfsd4_create *create =3D &u->create;
> +	struct nfsd_attrs attrs =3D { .iattr =3D &create->cr_iattr };
> 	struct svc_fh resfh;
> 	__be32 status;
> 	dev_t rdev;
> @@ -818,7 +820,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> 			goto out_umask;
> 		status =3D nfsd_create(rqstp, &cstate->current_fh,
> 				     create->cr_name, create->cr_namelen,
> -				     &create->cr_iattr, S_IFBLK, rdev, &resfh);
> +				     &attrs, S_IFBLK, rdev, &resfh);
> 		break;
>=20
> 	case NF4CHR:
> @@ -829,26 +831,26 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> 			goto out_umask;
> 		status =3D nfsd_create(rqstp, &cstate->current_fh,
> 				     create->cr_name, create->cr_namelen,
> -				     &create->cr_iattr, S_IFCHR, rdev, &resfh);
> +				     &attrs, S_IFCHR, rdev, &resfh);
> 		break;
>=20
> 	case NF4SOCK:
> 		status =3D nfsd_create(rqstp, &cstate->current_fh,
> 				     create->cr_name, create->cr_namelen,
> -				     &create->cr_iattr, S_IFSOCK, 0, &resfh);
> +				     &attrs, S_IFSOCK, 0, &resfh);
> 		break;
>=20
> 	case NF4FIFO:
> 		status =3D nfsd_create(rqstp, &cstate->current_fh,
> 				     create->cr_name, create->cr_namelen,
> -				     &create->cr_iattr, S_IFIFO, 0, &resfh);
> +				     &attrs, S_IFIFO, 0, &resfh);
> 		break;
>=20
> 	case NF4DIR:
> 		create->cr_iattr.ia_valid &=3D ~ATTR_SIZE;
> 		status =3D nfsd_create(rqstp, &cstate->current_fh,
> 				     create->cr_name, create->cr_namelen,
> -				     &create->cr_iattr, S_IFDIR, 0, &resfh);
> +				     &attrs, S_IFDIR, 0, &resfh);
> 		break;
>=20
> 	default:
> @@ -1142,6 +1144,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
> 	      union nfsd4_op_u *u)
> {
> 	struct nfsd4_setattr *setattr =3D &u->setattr;
> +	struct nfsd_attrs attrs =3D { .iattr =3D &setattr->sa_iattr };
> 	__be32 status =3D nfs_ok;
> 	int err;
>=20
> @@ -1174,7 +1177,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
> 				&setattr->sa_label);
> 	if (status)
> 		goto out;
> -	status =3D nfsd_setattr(rqstp, &cstate->current_fh, &setattr->sa_iattr,
> +	status =3D nfsd_setattr(rqstp, &cstate->current_fh, &attrs,
> 				0, (time64_t)0);
> out:
> 	fh_drop_write(&cstate->current_fh);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 8f64af3e38d8..c2ca37d0a616 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5060,11 +5060,14 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc=
_fh *fh,
> 		.ia_valid =3D ATTR_SIZE,
> 		.ia_size =3D 0,
> 	};
> +	struct nfsd_attrs attrs =3D {
> +		.iattr =3D &iattr,
> +	};
> 	if (!open->op_truncate)
> 		return 0;
> 	if (!(open->op_share_access & NFS4_SHARE_ACCESS_WRITE))
> 		return nfserr_inval;
> -	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
> +	return nfsd_setattr(rqstp, fh, &attrs, 0, (time64_t)0);
> }
>=20
> static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file =
*fp,
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index fcdab8a8a41f..594d6f85c89f 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -51,6 +51,7 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
> 	struct nfsd_sattrargs *argp =3D rqstp->rq_argp;
> 	struct nfsd_attrstat *resp =3D rqstp->rq_resp;
> 	struct iattr *iap =3D &argp->attrs;
> +	struct nfsd_attrs attrs =3D { .iattr =3D iap };
> 	struct svc_fh *fhp;
>=20
> 	dprintk("nfsd: SETATTR  %s, valid=3D%x, size=3D%ld\n",
> @@ -100,7 +101,7 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
> 		}
> 	}
>=20
> -	resp->status =3D nfsd_setattr(rqstp, fhp, iap, 0, (time64_t)0);
> +	resp->status =3D nfsd_setattr(rqstp, fhp, &attrs, 0, (time64_t)0);
> 	if (resp->status !=3D nfs_ok)
> 		goto out;
>=20
> @@ -260,6 +261,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 	svc_fh		*dirfhp =3D &argp->fh;
> 	svc_fh		*newfhp =3D &resp->fh;
> 	struct iattr	*attr =3D &argp->attrs;
> +	struct nfsd_attrs attrs =3D { .iattr =3D attr };
> 	struct inode	*inode;
> 	struct dentry	*dchild;
> 	int		type, mode;
> @@ -385,7 +387,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 	if (!inode) {
> 		/* File doesn't exist. Create it and set attrs */
> 		resp->status =3D nfsd_create_locked(rqstp, dirfhp, argp->name,
> -						  argp->len, attr, type, rdev,
> +						  argp->len, &attrs, type, rdev,
> 						  newfhp);
> 	} else if (type =3D=3D S_IFREG) {
> 		dprintk("nfsd:   existing %s, valid=3D%x, size=3D%ld\n",
> @@ -396,7 +398,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 		 */
> 		attr->ia_valid &=3D ATTR_SIZE;
> 		if (attr->ia_valid)
> -			resp->status =3D nfsd_setattr(rqstp, newfhp, attr, 0,
> +			resp->status =3D nfsd_setattr(rqstp, newfhp, &attrs, 0,
> 						    (time64_t)0);
> 	}
>=20
> @@ -511,6 +513,7 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
> {
> 	struct nfsd_createargs *argp =3D rqstp->rq_argp;
> 	struct nfsd_diropres *resp =3D rqstp->rq_resp;
> +	struct nfsd_attrs attrs =3D { .iattr =3D &argp->attrs };
>=20
> 	dprintk("nfsd: MKDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), argp->len, arg=
p->name);
>=20
> @@ -522,7 +525,7 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
> 	argp->attrs.ia_valid &=3D ~ATTR_SIZE;
> 	fh_init(&resp->fh, NFS_FHSIZE);
> 	resp->status =3D nfsd_create(rqstp, &argp->fh, argp->name, argp->len,
> -				   &argp->attrs, S_IFDIR, 0, &resp->fh);
> +				   &attrs, S_IFDIR, 0, &resp->fh);
> 	fh_put(&argp->fh);
> 	if (resp->status !=3D nfs_ok)
> 		goto out;
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index d79db56475d4..a85dc4dd4f3a 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -349,11 +349,13 @@ nfsd_get_write_access(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
>  * Set various file attributes.  After this call fhp needs an fh_put.
>  */
> __be32
> -nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *i=
ap,
> +nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +	     struct nfsd_attrs *attr,
> 	     int check_guard, time64_t guardtime)
> {
> 	struct dentry	*dentry;
> 	struct inode	*inode;
> +	struct iattr	*iap =3D attr->iattr;
> 	int		accmode =3D NFSD_MAY_SATTR;
> 	umode_t		ftype =3D 0;
> 	__be32		err;
> @@ -1208,8 +1210,9 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *=
fhp, u64 offset,
>  */
> __be32
> nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		    struct svc_fh *resfhp, struct iattr *iap)
> +		    struct svc_fh *resfhp, struct nfsd_attrs *attrs)
> {
> +	struct iattr *iap =3D attrs->iattr;
> 	__be32 status;
>=20
> 	/*

/home/cel/src/linux/klimt/fs/nfsd/vfs.c:1214: warning: Function parameter o=
r member 'attrs' not described in 'nfsd_create_setattr'
/home/cel/src/linux/klimt/fs/nfsd/vfs.c:1214: warning: Excess function para=
meter 'iap' description in 'nfsd_create_setattr'


> @@ -1230,7 +1233,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
> 	 * if the attributes have not changed.
> 	 */
> 	if (iap->ia_valid)
> -		status =3D nfsd_setattr(rqstp, resfhp, iap, 0, (time64_t)0);
> +		status =3D nfsd_setattr(rqstp, resfhp, attrs, 0, (time64_t)0);
> 	else
> 		status =3D nfserrno(commit_metadata(resfhp));
>=20
> @@ -1269,11 +1272,12 @@ nfsd_check_ignore_resizing(struct iattr *iap)
> /* The parent directory should already be locked: */
> __be32
> nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		char *fname, int flen, struct iattr *iap,
> -		int type, dev_t rdev, struct svc_fh *resfhp)
> +		   char *fname, int flen, struct nfsd_attrs *attrs,
> +		   int type, dev_t rdev, struct svc_fh *resfhp)
> {
> 	struct dentry	*dentry, *dchild;
> 	struct inode	*dirp;
> +	struct iattr	*iap =3D attrs->iattr;
> 	__be32		err;
> 	int		host_err;
>=20
> @@ -1347,7 +1351,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
> 	if (host_err < 0)
> 		goto out_nfserr;
>=20
> -	err =3D nfsd_create_setattr(rqstp, fhp, resfhp, iap);
> +	err =3D nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
>=20
> out:
> 	dput(dchild);
> @@ -1366,8 +1370,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
>  */
> __be32
> nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		char *fname, int flen, struct iattr *iap,
> -		int type, dev_t rdev, struct svc_fh *resfhp)
> +	    char *fname, int flen, struct nfsd_attrs *attrs,
> +	    int type, dev_t rdev, struct svc_fh *resfhp)
> {
> 	struct dentry	*dentry, *dchild =3D NULL;
> 	__be32		err;
> @@ -1399,7 +1403,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
> 	dput(dchild);
> 	if (err)
> 		return err;
> -	return nfsd_create_locked(rqstp, fhp, fname, flen, iap, type,
> +	return nfsd_create_locked(rqstp, fhp, fname, flen, attrs, type,
> 					rdev, resfhp);
> }
>=20
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 26347d76f44a..9bb0e3957982 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -42,6 +42,10 @@ struct nfsd_file;
> typedef int (*nfsd_filldir_t)(void *, const char *, int, loff_t, u64, uns=
igned);
>=20
> /* nfsd/vfs.c */
> +struct nfsd_attrs {
> +	struct iattr *iattr;
> +};

Please separate the type and the field name with a tab,
and use field names that are easier to grep for, like:

na_iattr
na_seclabel
na_pacl
na_dpacl
na_labelerr
na_aclerr


> +
> int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
> 		                struct svc_export **expp);
> __be32		nfsd_lookup(struct svc_rqst *, struct svc_fh *,
> @@ -50,7 +54,7 @@ __be32		 nfsd_lookup_dentry(struct svc_rqst *, struct s=
vc_fh *,
> 				const char *, unsigned int,
> 				struct svc_export **, struct dentry **);
> __be32		nfsd_setattr(struct svc_rqst *, struct svc_fh *,
> -				struct iattr *, int, time64_t);
> +				struct nfsd_attrs *, int, time64_t);
> int nfsd_mountpoint(struct dentry *, struct svc_export *);
> #ifdef CONFIG_NFSD_V4
> __be32          nfsd4_set_nfs4_label(struct svc_rqst *, struct svc_fh *,
> @@ -63,14 +67,14 @@ __be32		nfsd4_clone_file_range(struct svc_rqst *rqstp=
,
> 				       u64 count, bool sync);
> #endif /* CONFIG_NFSD_V4 */
> __be32		nfsd_create_locked(struct svc_rqst *, struct svc_fh *,
> -				char *name, int len, struct iattr *attrs,
> +				char *name, int len, struct nfsd_attrs *attrs,
> 				int type, dev_t rdev, struct svc_fh *res);
> __be32		nfsd_create(struct svc_rqst *, struct svc_fh *,
> -				char *name, int len, struct iattr *attrs,
> +				char *name, int len, struct nfsd_attrs *attrs,
> 				int type, dev_t rdev, struct svc_fh *res);
> __be32		nfsd_access(struct svc_rqst *, struct svc_fh *, u32 *, u32 *);
> __be32		nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -				struct svc_fh *resfhp, struct iattr *iap);
> +				struct svc_fh *resfhp, struct nfsd_attrs *iap);
> __be32		nfsd_commit(struct svc_rqst *rqst, struct svc_fh *fhp,
> 				u64 offset, u32 count, __be32 *verf);
> #ifdef CONFIG_NFSD_V4
>=20
>=20

--
Chuck Lever



