Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AB95AB9F3
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Sep 2022 23:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiIBVN0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Sep 2022 17:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIBVNX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Sep 2022 17:13:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD45CE0947
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 14:13:21 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282KFBMh030906;
        Fri, 2 Sep 2022 21:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ljyrTbWv7aC8NJl2UsoVHenGY42Ej22uutcxxMWOorI=;
 b=gZuKRUIlbCeFKK2GhntDIIzD0KpE0xyAVq6hKr8Fwiub7Mog5tzbKHtTlN5un8V9T977
 1kXtvQzwXLHfO7+dgnG7333bntS6wXvZjYMxr4tacT2K/Ea3UyvsnA46/Dtc7egyV6zL
 d5ZaNzqyTN/eZ9pRoqeB5duSDd0Ad2KWSO6DdyyyinT1WzMe4iz1pJ+IJ2lre78xoMTM
 vhaYmw7xIEbEAkfHiRz2ggm+0SoNR3S+WLpQ5rJQOUaOZq096BAiPyHobiPxbqS7l5DM
 f2SNw1S04RJ9oH4pT2XoJGGCwHnu9Gkws2N4oC6LQrizSJ5zOKWa6HRP6nrDBgUKrTT9 Yw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v105j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 21:13:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 282KUV2R001973;
        Fri, 2 Sep 2022 21:13:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jarqm8cys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 21:13:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZD24yy/H+BQmo1AN753gDQ3XA5kQbxuYJKnfYMWeqgxCAks61EaEEoiVhOBb86i7EyE4QmbP5I4rx3hieQY8jN0nJ20DgNhGOdF2IS3QlO9Hf6e0tQcvswdO+Y/Co0CtIRYgmS5mac1dpoTBFQHF5NPbadEp79oTjMhIUAzlscgH17A1CeYFf/YsNOW6nB2CvNzbkhigvhXLtS2gtNIESSkZ4PEqFf6d1kzwrHx20UHgqFGDolUEt81pl9/jAuNTbdb+1X+89y8TJ+XMext0qS5hkf7DY11KqT20PwfKjMKFz6E7QdmoWgXScNS1hH8GxEzohfuyROnp0OUptr605g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljyrTbWv7aC8NJl2UsoVHenGY42Ej22uutcxxMWOorI=;
 b=B42l3uDyi1Tbjv+5luKKBb4/WnnIRtflq/YGp1pOIVhJcD4WexTmHSyy+qTciM6FHOG5u8IhxRqaeLOua/0R35RBPvR6Wij2UdvJlQp3tVJwcL7KP5drwOFv7g6dQMbYcuuLP3X1IhQFs1K44ihWh/CZ9rRVnmR9idBI00mxfuq3W7X6F271xKnhbt/6fHXIxsgmHQFvYN9vtOEVlQLVinymnI5dhoAEM0dl0wP80RelIDIKFIuv9PrYsjSuguPOHIpdH/T3t/6yU7NElEUG0lNYRYCQAvniA+yegcOL0RKogbs80ZrrcXpCmAdAOir5sNEJVU2xqS5HmFiOnea2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljyrTbWv7aC8NJl2UsoVHenGY42Ej22uutcxxMWOorI=;
 b=gf6rULfVkm+YIRxT/hNEwh49ryohxZFa9uimxmXK1yLz1YzFXEkie7OeSBofOq8xuCI9MpJlN6VJsj9GlOvq2H6f5NXyt4CXGIs3oSpv4uHWeUN/UY66f4NnekrDz3yNsIQOULGO7blobY1NqcPxJHSp/OMpsn5EDx0lhu+D4zE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4830.namprd10.prod.outlook.com (2603:10b6:5:3ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 21:13:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.012; Fri, 2 Sep 2022
 21:13:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Olga Kornievskaia <aglo@umich.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Is this nfsd kernel oops known?
Thread-Topic: Is this nfsd kernel oops known?
Thread-Index: AQHYvJP9R6JamLcYaUyLf/owehh7vq3HuG2AgALiPACAAGl2gIAAWREAgAFHCwCAAAQygA==
Date:   Fri, 2 Sep 2022 21:13:06 +0000
Message-ID: <2E6F8E3F-C14C-44C7-8B72-744A5F6E8F7F@oracle.com>
References: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
 <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
 <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com>
 <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
 <6DC1F4DF-8242-480B-813A-5F87D64593A6@redhat.com>
In-Reply-To: <6DC1F4DF-8242-480B-813A-5F87D64593A6@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c60ade3-0a10-48d8-153a-08da8d27ee15
x-ms-traffictypediagnostic: DS7PR10MB4830:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tc/DYfvUGRjLOUGQD5aXLJJRkmaVNvM9nh/YkRZOd0iU4C4HPdn5FJYg9Y6a63wlcUnVKp5iMAlYIcOKAs7wP/tTeNb/vQw6JQoQZICGe6uZ17TqUFVOaCL1XVgAu8BLPWp2s8eEvyhDfn2WvmUgVZ7sIPuKfu3refnuiSe/4t2RAnGDYaKLctNGtJraH4S2d0FliINcNb8dMTDczkA8X3i1x1wQSnsrg8Ouz4uWCpTymFS8zCEdgV4Axf2Zo61I6zkLBFoIcvwp7tlQ1mH2gqivhOGxWFyl+VHiy5HFaQ5LIOYDdNZq2Mm8UQ7xtiOwwKrjcyKqRH0fInSv1Qj84Vkw2pMTD2X12mPjZ3/PpI2aA06KLj80TfJGam2LKcxSjCSAMXz99lFZ5a2vLQEflEHoPCNkwEP2dmvEHHvYGPH8PqKq4VMaxqj1DiLaBuA3kVG1cOCXmKr58rBIeyJBI1PLoF1V0u7N1PzKk/Gca5t6wvM5j3udhVlw7mBtxGtVsR6MRi0S6i/eHewizi0FR09+ULZy+bXK1RsdALCKXELog5He9Jgt+4F4Z+B+For1aY3omFJEc7RDe40f9nBEAyMLQLlUnIGCbAZbHoy+BSMoqkQeNEkcDUt/4a/FfDd1+bC6czmRdhtuJ7bxpQWP7tjWRwlspq5HyN2FxsIfOt879vZwOvBWVlGH2M9cMVUwWgbTogCKTLigOI9xVcXzumLh3Qa09DOwI9jpykclAzwfjxfbHcfNC16FsHHrnbKLNj22Ovp4Q3s6Aslbp5Btd3olYP0IKYxrMr4b/HCfE1k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(366004)(39860400002)(136003)(83380400001)(66556008)(91956017)(66476007)(6486002)(38070700005)(4326008)(66446008)(8676002)(64756008)(66946007)(478600001)(33656002)(76116006)(86362001)(26005)(2906002)(6512007)(6506007)(53546011)(186003)(8936002)(5660300002)(41300700001)(2616005)(316002)(122000001)(54906003)(38100700002)(71200400001)(36756003)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nlwiuzs/TljTNsq3E2m2Y87quBAMupdGFWscbG9MEzqbOr7y8A2zBa5W5CXw?=
 =?us-ascii?Q?T/hx5rKRA0cj10fDHLQmUA1D0r2s05QtH0nX4HzaSoB1khpQaKrifkTbAN0G?=
 =?us-ascii?Q?ViiyDjcb4pfKaZzl2yT9z4ibW+4TIc59QTekMf7z9r5lsYdE9Qgd4MTII+On?=
 =?us-ascii?Q?jqMBeG0rVvEgu05b4f9c6uWCyYbjkHAJFykPgzRUznPRZegFlizVqBQYFk1U?=
 =?us-ascii?Q?ws1MAM/l4hYdCURQSOde1PPPqj2YmPnmh43AImsHKVDOtyE61ltENQxCyqJW?=
 =?us-ascii?Q?NkuRbleJZ+/ptsrsD7DEzYereh2w6WvQJxwn4NegGr9AxVdUg1j6pdpih+Hx?=
 =?us-ascii?Q?IS5SwEYhbARgbiv+D8GQq+gyQaNYJ1fEgw4TDVSaIgJSo1i5o+iZ6CEcCh3/?=
 =?us-ascii?Q?DxDzWDJC1HyWGgiF9900eY7aHvAtsuzM8CKYAd3E609WvBSnbrGXliMCfQjl?=
 =?us-ascii?Q?0qCtODWkSzAsovrMBUnfNS8ViIXb5+wH4g6jG4WqpgrunracWXMmvcxAWmyy?=
 =?us-ascii?Q?WCJItaPoeL/Z+w/RJQSxOIwSZm0RZHZY2TrEAMpw86rVWSrwVRariXPHRYwg?=
 =?us-ascii?Q?931z0SMu7iB3LWa+hjiXuZxK+k4rzEbxtCb55oygDo59J/03pwxOmqGCbqAo?=
 =?us-ascii?Q?NFHua4kPZtj/gTBXxQ+XcVOslTUNTnP2gTmShvMa/dmEPmKD8J9gPNIN5H6f?=
 =?us-ascii?Q?ZXfBWL965xroVYN3ROwDliisfecfP86YysMd6vBiDaELo/NW4e/sH43Fl5v0?=
 =?us-ascii?Q?UsMeyGsdmQRE09vhOEHgvDptCuq/t2NTIRpRnV9AG7P++QUlzqn+6oigo75r?=
 =?us-ascii?Q?E+UUt8Pw2tuYTx+5rSLOnij4JQwddx0rQywoSgvEgKjM1thdtzShOKgTlp+o?=
 =?us-ascii?Q?dV5Jti8I260AMl+IzLWEnoZmBbfiHl+ee/lSjszA28l8WtmgeYxcSNgYwiTX?=
 =?us-ascii?Q?piGSAM3KilxhV2uKc6PlyZRU18Y2roxgks5yZXm2pv4spUMcCIQXLQ0obHn9?=
 =?us-ascii?Q?EHyb6nxum2m3A2USoYLlKFqNK7Yc9/j5sxHi6IaOxzoemuu+k9ytgjMdYIiL?=
 =?us-ascii?Q?I37Px4p7CtQF/yNDEY01CxV4Ej9DJPUUnkI2oTAKle/4CQUgSzUZt+oKN1Np?=
 =?us-ascii?Q?ekOHsMSSEpk/Xz+QDf6RUG0bPuo6SPowimcKzdrIi0OvspMvhEnLHRtd8Qfv?=
 =?us-ascii?Q?CcNhEMmVLdnwcq729/3Zwl1qyOLdlHcOHmidhvqx/DOX3irqyMn13nh/pvks?=
 =?us-ascii?Q?wmNnAKM5ZfEmg5qkP3/cKIjW6zR5/nMbW47/Aq6E5/5EXvSCgXSOGpyL8t+I?=
 =?us-ascii?Q?M3uc1jFdmqO/a5JjqRG0kKzLvQV1w5bzbQyN5mFGMG3px/Isb+XsRqjVaeis?=
 =?us-ascii?Q?wP0KZWH8FNoNsgtz7RSpdm5KxeUl7sW1B2MqUchGx/+1I6/iMsMUA2Uf3HSc?=
 =?us-ascii?Q?9RoN0YfLfP9uPg/W5iCPFWv33Tv1SOKTg+WdwpFpzv2jTzhDtOK6Q0gtB8eg?=
 =?us-ascii?Q?/ocaU23oO5YGscaNBgl9AZfASVawEftImT9djijIORJ3tQpNU06zf3ASY2Xj?=
 =?us-ascii?Q?gKSVlo7LBCs6aFE24hKfSliryxz2ZOOWxQbJ/Vd6TxoOKTSwcaMptSod8j1I?=
 =?us-ascii?Q?lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ED69B3825AA58045B74704E307464414@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c60ade3-0a10-48d8-153a-08da8d27ee15
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 21:13:06.3790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gsw/oO0LtSpH9uX3qFMhD5SIF6tam55MMkUPG+VTzop4XHH5Oxgpa+eiy9yrxZC3QPE1NS9Z9eoelgXdsx5MaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4830
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_06,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020093
X-Proofpoint-GUID: PKD86cP8ClAY_vS4UAti36yhXXTI5eZg
X-Proofpoint-ORIG-GUID: PKD86cP8ClAY_vS4UAti36yhXXTI5eZg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 2, 2022, at 4:58 PM, Benjamin Coddington <bcodding@redhat.com> wro=
te:
>=20
> Olga, does this fix it up for you?  I'm testing now, but I think it might=
 be
> a little harder for me to hit.
>=20
> Ben
>=20
> 8<------------------------------------------------
> From 6bea39a887495b1748ff3b179d6e2f3d7e552b61 Mon Sep 17 00:00:00 2001
> From: Benjamin Coddington <bcodding@redhat.com>
> Date: Fri, 2 Sep 2022 16:49:17 -0400
> Subject: [PATCH] SUNRPC: Fix svc_tcp_sendmsg bvec offset calculation
>=20
> The xdr_buf's bvec member points to an array of struct bio_vec, let's
> fixup the calculation to the start of the bio_vec for non-zero
> page_base.
>=20
> Fixes: bad4c6eb5eaa ("SUNRPC: Fix NFS READs that start at non-page-aligne=
d offsets")
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
> net/sunrpc/svcsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 2fc98fea59b4..ecafc9c4bc5c 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -1110,7 +1110,7 @@ static int svc_tcp_sendmsg(struct socket *sock, str=
uct xdr_buf *xdr,
>                unsigned int offset, len, remaining;
>                struct bio_vec *bvec;
>=20
> -               bvec =3D xdr->bvec + (xdr->page_base >> PAGE_SHIFT);
> +               bvec =3D &xdr->bvec[xdr->page_base >> PAGE_SHIFT];

Color me skeptical.

I'm not sure these two expressions are different. This variety
of pointer arithmetic is used throughout the XDR layer:

net/sunrpc/xdr.c:       pgto =3D pages + (pgto_base >> PAGE_SHIFT);
net/sunrpc/xdr.c:       pgfrom =3D pages + (pgfrom_base >> PAGE_SHIFT);
net/sunrpc/xdr.c:       pgto =3D pages + (pgto_base >> PAGE_SHIFT);
net/sunrpc/xdr.c:       pgfrom =3D pages + (pgfrom_base >> PAGE_SHIFT);
net/sunrpc/xdr.c:       pgto =3D pages + (pgbase >> PAGE_SHIFT);
net/sunrpc/xdr.c:       pgfrom =3D pages + (pgbase >> PAGE_SHIFT);
net/sunrpc/xdr.c:       page =3D pages + (pgbase >> PAGE_SHIFT);
net/sunrpc/xdr.c:       xdr->page_ptr =3D buf->pages + (new >> PAGE_SHIFT);
net/sunrpc/xdr.c:               ppages =3D buf->pages + (base >> PAGE_SHIFT=
);
net/sunrpc/xprtrdma/rpc_rdma.c: ppages =3D buf->pages + (buf->page_base >> =
PAGE_SHIFT);
net/sunrpc/xprtrdma/rpc_rdma.c: ppages =3D xdrbuf->pages + (xdrbuf->page_ba=
se >> PAGE_SHIFT);
net/sunrpc/xprtrdma/rpc_rdma.c: ppages =3D xdr->pages + (xdr->page_base >> =
PAGE_SHIFT);
net/sunrpc/xprtrdma/rpc_rdma.c: ppages =3D xdr->pages + (xdr->page_base >> =
PAGE_SHIFT);

Commit bad4c6eb5eaa is from v5.11. Wouldn't this issue have
shown up in earlier kernels? At the very least, the patch
description needs to explain why this computation is not a
problem for kernels 5.11 through 5.19.


>                offset =3D offset_in_page(xdr->page_base);
>                remaining =3D xdr->page_len;
>                while (remaining > 0) {
> --
> 2.37.2
>=20

--
Chuck Lever



