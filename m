Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDA37E048B
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Nov 2023 15:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjKCOSg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Nov 2023 10:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjKCOSg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Nov 2023 10:18:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE4C1B9;
        Fri,  3 Nov 2023 07:18:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3DbGJ3023495;
        Fri, 3 Nov 2023 14:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=F3oW1Bb31fA9ywiYlFuTORLInMAJq0cGvYGNceMMZoY=;
 b=GPjIYs3TVPOftBNLN87XOhRM6DPj0qv5ckFfWcMBDE/Yw5cqkNK95rY6ry7/nOoDLKmB
 RdzH/ff2gA6AjEaYmGCmML7tyLhPYOhz/Jz983LC9/26SEznlw9SQKO/fYnkHTrmsEM1
 cVBLuRc28XrmC7GiuPMli9faur4c6VXMmo2sXNWh2JYTtbFZoZeLHKzbYFFzEC2JAfNa
 saQoakIq5tgtQ/d7USP7C0Nbmx/7j5+v7P7kj5shqd0x1QSm5kjcWC72v9qVu6ioJSGw
 k4EU1QblmFoO3RBV9u2pdJeJWXY9FfcDZyQQCy+TxDUmzMWirdzJDwSx/5DuegWB5iOL +g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rqe42x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Nov 2023 14:18:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3DDI6L012930;
        Fri, 3 Nov 2023 14:18:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrgcr3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Nov 2023 14:18:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUKCRRcre+MPJrvtYVzxgTTC79TPqJp3gXZDgk3x8sRCTVQ0pv4WOPGzJyRWfvRBGIxJldMfD+MclVKXbIEqJ3/pdIsNdEiRpojkrwV9+mSMzQqZv+KGvJYyByNY5L15iN/yZButNVPJVNdkObBTXEvFCPf+4SoypTuIj+4wM2nlPg8jJY2dwfjejSqAg83tumNpKy3BYUU34tQIjdomY4UWYXoDda5ffom7SxOK2QDMvp/fJczJonL1rSBTBniVyn0ApBsMMYdKIq3BC8ovqJkMkkmhzjR9I51dUZMe68FJdKhUqSZ4x2Gnn5+/DpZS93pi6GBHV9cfXHTc//6IUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3oW1Bb31fA9ywiYlFuTORLInMAJq0cGvYGNceMMZoY=;
 b=BJeK6p9FgEM17jCMUtxPXqW/A8/813PMhBZWvgGL5lj677L6p3DmHaE+2Bysx76yI7AXO/4YL41uXabojBukqAnUeV2upBBCr73Jt5h5uv0XkSqeK/teu8zWObfq3vjP1s6sbhZIS2rc2Db0ikrpIq9O807aTf3dZMuHPNG0iko6+Ox0bOwGnDKk04AhivJ+iuA13cb23xL8Eg16df5l+nXgWbDJpN3/EzUgdvO6pEc8ikmdoEUjWdOGkzidXqrJe9KVd6g+L8N6rWLflalnJxzWnvnHcMfJ64YbCXVsR7DSN42lbyuPe09h16sK+6SE96pVcVKQ7KkVNDNRERPx9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3oW1Bb31fA9ywiYlFuTORLInMAJq0cGvYGNceMMZoY=;
 b=bM8wzjv7dBrq98WDE7GwCQKSKwQOGIt4T28kgq/cqwUNkQaYPgkZ7L7v+/d9YTERJi4NWPH8XDuyYQzpZdqSYKJBRGUIG6njSumvWUXpnUcglTTVAoQk3z9xfABcqw2S9SZnrt/1Myo0p8hoVbacQvNbSPNEDKi6Ev7FbvQBgRo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7840.namprd10.prod.outlook.com (2603:10b6:510:2fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 14:18:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1%3]) with mapi id 15.20.6954.024; Fri, 3 Nov 2023
 14:18:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] nfs: clean up some tracepoints in the lookup /
 revalidate codepaths
Thread-Topic: [PATCH 0/3] nfs: clean up some tracepoints in the lookup /
 revalidate codepaths
Thread-Index: AQHaDj4kMvimT2TVzkSiRtxKP0K+l7BopJeA
Date:   Fri, 3 Nov 2023 14:18:06 +0000
Message-ID: <8EB59F3B-D902-4934-879F-8994C947CB89@oracle.com>
References: <20231103-nfs-6-8-v1-0-a2aa9021dc1d@kernel.org>
In-Reply-To: <20231103-nfs-6-8-v1-0-a2aa9021dc1d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB7840:EE_
x-ms-office365-filtering-correlation-id: b3ea9f7c-83ce-4675-e29c-08dbdc77b328
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oi7iFEXnIZPOLE2d8rmNZer4qv4mZLcG0V5ZJ53li0LFQOq9J9vbDlZOfINYw/dzxQ54frwkJvE2oYQUQODYfxFRIIWYMmty5e78r/2a6oFeh7CWFrJbxP94WySMpe9Qu/7XrP4ti0Ek6DLo4sO27InZgk231DzQEUIUHt8z/QpL8dFsbSS+p9jxgiz9tq5R7sHQlc8/OdhTmCUBRKJ/Od0MpsHt3oniL3udew3xwA3bJiJH9Mtiqx9+W42JQvnC99xuMAmyQD4Fj34kA1sB0CbgKsu4zb1oNGjzyEv3eVvUUkUKRffxECNLA7k6LHR02oCSGzafZDBmYFx3KcqTM10X6kNF+NjbeSlexOvVJ5D7j51/fMe49LFLtDvaXya2dduRInkH61+LYeeGuCK+4NXST2BMKMbWIUBVydIBn+Ln9vicI5hdhqogkJS+HAfej6N6HZBWdFlEQGHPL9vpljeEPYkhRLv3DZgQVIhoA4OvGpk7+swBASpg6a71QK1zl5TXfDy/gZBaAiCo46lIL9CWIYu+VsUo/1sEU4r9SZC/Dn1IY69HX/5JR66jAYKXTEgU5/w8uT2jGJW/trwcGdV+u9veFfLNu4Z8TUVBL3bkjXbwfmwueLkLUFYqwAWM1Q62ssMh5QQ+I886OJM6Cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6486002)(64756008)(26005)(83380400001)(66476007)(54906003)(38100700002)(91956017)(76116006)(66446008)(66556008)(5660300002)(8676002)(316002)(6916009)(8936002)(6512007)(4326008)(53546011)(6506007)(41300700001)(71200400001)(2616005)(478600001)(2906002)(4744005)(66946007)(36756003)(33656002)(86362001)(122000001)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?507BByOY1z6C7GBLEVZAxGbT75WwbVM/UmEUawV17Nx2WWCatSO4qWn4IzqV?=
 =?us-ascii?Q?SL6KmdoE7BumTRZtcrg45GHyiuVlZ1hETg0PCDyIdV9QDtNwIqMsahAJN2og?=
 =?us-ascii?Q?Wa6n2h6XwZrgxRkzNwOH+A3pyFHPhAN/ra5OjmKIIJ5vYgbJJplkvw6xtiYx?=
 =?us-ascii?Q?u9KnNk4dGzDUoQW0U9rSUdVBAZck+qGjvEDEi5l4IMjAI9PXJe7RYHVdWEGR?=
 =?us-ascii?Q?CjkIjY7JIV9QIayVMDMR+I4NYvX+vWsoUqZQx1WDBLAkg21xUEP9rBRUv455?=
 =?us-ascii?Q?VJbRrxHKIq13L7dEYWaxE82U9D3uCGhy0sByuND/UEo3AcDZEA0WquFP1MYA?=
 =?us-ascii?Q?ZLiyV+ZWYmkIMmt62A6d/vfGBEM/ypgTUjvFkvxlhAuAcYYf4BP8BBB0iDMU?=
 =?us-ascii?Q?MhJE45xe/gaMaumVb9703ceOdFRcFDeqrOvDhYDxTfWYE6zkaAfm/B8F3jIB?=
 =?us-ascii?Q?70sZCpP6Xpw1YTBNHSPcoCLNnVD2SRJvl5OmJVQPTygLeUIi8FxW6oObZsAC?=
 =?us-ascii?Q?Bs4DErnuYTaMou5Qox3rDgpbfkxghJDq1b1UgShegj+KWvBcydYlETNGgUIi?=
 =?us-ascii?Q?uJK2Y4VfDROheRnuPbiTqAJ6OIiyknL0SRCVnNItkIhsCLdcxVzSNGD6L39c?=
 =?us-ascii?Q?0W6xBVp56tI2IFhbm366Y9GUWqpzmtrxayt3HLwmWcfiy06u4Q58NNSwL4Lx?=
 =?us-ascii?Q?qBLHHzpeRvE6SnxVVepCMLbpLmPx94yCHEi+Rp892IXDwqOY106voEjfZXfE?=
 =?us-ascii?Q?s4Tk9Emf3mNxsvNDC7vB/W7Oohr06dpHScl/B1brU1F1xmz4y0zYr+BiMRPR?=
 =?us-ascii?Q?TcMfV2APCVhr414feST6hzM3hYwYFN1DdVHV3JtXu7TCsist0Obe6W+E2Yfj?=
 =?us-ascii?Q?WG/ADT5Wf4Kb3rA6KO7CHgOZ/aPky+Pxf2d8ByNHWFCm4YsRKQHJS6ZE+8hZ?=
 =?us-ascii?Q?PVELhrQtk/LH4NmcJ3B/6ivTdFtx2+hfkWrLx2BL3zLERyMv9uK6wQrCbcKD?=
 =?us-ascii?Q?/FwyLXUqvWD32nM6wH4+OH8UDAiaqEOEQV1m7peOkeCXmj8UyA26PmXhcXQI?=
 =?us-ascii?Q?+J9Rskrp90QwMgxeWgZ8qKCSQGLwxbek6i2rq+SsJ5Oxh217mFZkedZItC1p?=
 =?us-ascii?Q?JtnJK0v3H5eyK0htWH9y3kP5ljTLcQlVSHP2NpmH1KynmMirBPvsLYcNqcEx?=
 =?us-ascii?Q?v304v70AeaGqRKcrhcPVStswbqy0Q+slLh+Oo7miKRgV0R8vXdebepzY1hdV?=
 =?us-ascii?Q?ca6SeSfEK1M2q1esYVJ7YCGRMHpVqjoAv/JMsD3ypN1KpxTsytcmkBmo3WS/?=
 =?us-ascii?Q?jNPzfyJZkNkUBV4+QslscxNgWgna0oYYVZj0UxKgwiedhN0Hql1cwDbvfhNS?=
 =?us-ascii?Q?IEt5S0ZxqFXI8xC6rLyIH7cgVQ0bMtPVuGcIt9SEegaK7udQs41oiISxIt5e?=
 =?us-ascii?Q?srA5NpxX+RrrMdMRG/krBz4E+qIDfV6W5yvpCrl8vqzclgj2dW9BxQHPWeO1?=
 =?us-ascii?Q?KYtUnZ+01NYbgjadMWFdN9vyOUtTDOg5gg0pYgJPIJEJYqrrSNzFX/s4QSlK?=
 =?us-ascii?Q?H0T1arb9+uYaAl6Lq2fE8pp7UinRoc627R4NF3C0hoV1+djFUX8fca3YHS85?=
 =?us-ascii?Q?Yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AA5A24467F8A2C4B9004E5AFA12A65AE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hnqXknya62md9hs0VY1QE18zGEPqTUhCRVBP18OkxvBXQS04QAF54PltoO3tVawxxzOP65p1sAR+l73TGAYBjnA2ULZ/LYZ9wZW3xP6Y6AhObpLoUAmz8sEoVoAZeQuhXlKaYLRJ85Oo69JoGh8PyJWqfLpLPjOeY7NI6ear6h6Szfm8WQmOKeRgYzEKi3AGAuim/Ow1051P6Nl3tZbGDiXS2YUEFFWl5FzqsW8kbjOJxIuCWpDCaQiTE0um4WryG1YlZvPFaA/uhjUqvae0BjJXYdkZ9zW7LyM7LmQiQK6HcY2kuDL4lgEoqAGFcu30P0/rO21GViHYZiiw8H4/3klCSP8hU/fvAauoT4QIhJ6fIsaTcm0vbzgl+fxLCFasunJLnuS1x41smoDCsjx9WR6XsVFLQc6/IpzPnqoNXt22UwySGcm3MRiHbi3DatWW3hf6tO43/nS5++/GLGz5Dibl4NQxHg8ZiFe496GTSJ6OX+szuC/tgm7EevfTsJttQyOuqFKugIW/nPoaZVd3yA94Yd8SpJRhsE3KsFEtPML5YXMxQh+SxL74uReCUpfaZg5v/c04yD5lgDmZhAT6zY0ECUD8NKYV3FoUpP5+t/UygGKGmTv1T/mxaqWx2vJVEwEw6jatx0pyGSXBXoZYP5MouDLGLHIwSqznRKEm0mFPG74tOtpfS9hkh6I4+CZQhHDz3zx59dTrMsT9Z8NhCgJaiYq4FsIKK9MwDYIG9+9F8o0dSEu0jUY95R3X1iQeiIylI7ORde4jiIrvtKS+lqQcoWkBq6c9f2QVmyP0dz7QlMXLPvCWBIcHtD5hzjn3EG64e7X2ogVtwAdZ6sKt4g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ea9f7c-83ce-4675-e29c-08dbdc77b328
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 14:18:06.7933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2e0B3BvcqxGAG1Qj5aedogKjNyJM/tyE+G6JPG2Q3TjONd7aWvSYGpaju8gvWOEJF3fx6JbYAPUNbyKFEskD8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7840
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_13,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=887 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311030121
X-Proofpoint-ORIG-GUID: zwy4_IJ4b5jHzBsHc2WlrCXBHpBspPcz
X-Proofpoint-GUID: zwy4_IJ4b5jHzBsHc2WlrCXBHpBspPcz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 3, 2023, at 3:10 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> I was looking at a lookupcache issue the other day that turned out to be
> a false alarm. While looking I needed to turn up some tracepoints, and
> found some of the info to be lacking. These patches just do a little
> cleanup to the nfs tracepoints, and flesh them out a bit.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Chuck Lever <chuck.lever@oracle.com <mailto:chuck.lever@oracle=
.com>>


> ---
> Jeff Layton (3):
>      nfs: add new tracepoint at nfs4 revalidate entry point
>      nfs: rename the nfs_async_rename_done tracepoint
>      nfs: print fileid in lookup tracepoints
>=20
> fs/nfs/dir.c      |  2 ++
> fs/nfs/nfstrace.h | 16 +++++++++++-----
> fs/nfs/unlink.c   |  2 +-
> 3 files changed, 14 insertions(+), 6 deletions(-)
> ---
> base-commit: 21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
> change-id: 20231102-nfs-6-8-7a98e3e480d2
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20

--
Chuck Lever


