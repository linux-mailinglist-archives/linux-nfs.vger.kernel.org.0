Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1725B7C0A
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 22:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiIMUMV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 16:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIMUMU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 16:12:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0889642D3
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 13:12:19 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DK1pkf025656;
        Tue, 13 Sep 2022 20:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=XZkYlepARouY3rFyH7F7RKkVxFHuG/wUamV0QakzmUo=;
 b=C58O84GxW60nzuiwiOGbt/dyjgeb8j0ppQwuyLwUpjj+7tcactHbHyxsX5wMR9cUDJ6w
 hX3Fmf1oWa5aKxchYwfXWt+GPBoqsLbt/gT7fMd4XkYGKpBd/FU9Q03XPcCx7uNJaH4X
 hMnq+T4ZGLfaqLoYZ1HYDoO4Z8Ndqwek5Sl3EN0M4SpkCTeC+E5khy74WnNzoJV3MDvO
 lShwV75qlKRVg5vxHMPjuZp6mqEiUc1WkbJu3c1QvxZR2VRuSbVwnkBca0hqTg5Bq/6D
 n7PvyajOZkfJJ55RONao3efhEhY3H4aog1OzbW7Prv9ZGQrnF/AQJ4W2amOX3oPX4+aE jg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyp89vp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 20:12:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28DIwhOe013406;
        Tue, 13 Sep 2022 20:12:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjym3sxts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 20:12:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3rlWQr64iUTbxpVqn7tcTV8tR46js+Txv7YwQrdfYGGiK80uuix9FqbB+EHEN3MS0D3cRUoEtGUUGSRUFKDP+ZKn8xfW2HQhgFQwNqhuSNdM2PF4Rvqa2K7o6sFWUNrqdgUFzN6kH5LnSAm/HPAF7An9tydXIyiyoNFsICx1taVTfKJa/Toxcd/rur5olFk2VyRLTHc/WltxB3t34IsM/nWX8OozjOUQrYcLFq/Zv/YiaIEvdC7M8TvJgep/0EK9CaZOPE/S3CeZyQEzrXMA+LrLDAb0wYTRLn8eKAJLeEXWqgCW57Mmjh4TeiQwsfws3nbtsheDrVpRcUN3ysL/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZkYlepARouY3rFyH7F7RKkVxFHuG/wUamV0QakzmUo=;
 b=DCkJyk6roBD1Rs3Lm3rdTmqT+iSPkKGCXRDe/dyQvP0iH8GBdPCqKLSi1dd/l/PXGkCVxBdIImZ9Y46CzdOeWFXNr/qAWAO8NY0R7fHMHdH5bJR++Uk/ZrEKkbZhmxyo6I57vulUuYpY80j8KRjVVpUXdkHd9twdzjHB4bZR3pEoFE8JeJZhTqfB08PuEy1RQaA4wdsFD68Cwv/2Nd92YMlJ0e6pL7/Uesr+r1t5/FUYhNvrpLIkqzQgI+iPf5EPU7rIWLMzJ7YitEl7zD25cMhxUI/U7MzjllyIjzWcKV3EBHJ9pPECt5SWTtL07w7GZQyfe7cIYAhvzt9o9+9Y1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZkYlepARouY3rFyH7F7RKkVxFHuG/wUamV0QakzmUo=;
 b=S+pipNW3pKDLoAc915qlyoB5FIr8FaUH0f/5Wupl4yQvuYkYCZLJoKZ2fXRLz5Gx9T0odKOQ7sAzHKQ36PJnYprRXdsiOd2OGFDX9p1rFiOXh9dlFEDRFf282K5/XwAc69F3mQ53X0LLj2aeRCDMu3RwcI9YH7W8uedzEycQJ+Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6235.namprd10.prod.outlook.com (2603:10b6:208:38e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 20:12:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 20:12:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] NFSD: Return nfserr_serverfault if splice_ok but
 buf->pages have data
Thread-Topic: [PATCH v4 1/2] NFSD: Return nfserr_serverfault if splice_ok but
 buf->pages have data
Thread-Index: AQHYx5rr/lc8S5bVRUSZRf9utUmxSK3dywCA
Date:   Tue, 13 Sep 2022 20:12:12 +0000
Message-ID: <DE16B82B-67D9-49BA-B797-AC21AC8E7CE4@oracle.com>
References: <20220913180151.1928363-1-anna@kernel.org>
 <20220913180151.1928363-2-anna@kernel.org>
In-Reply-To: <20220913180151.1928363-2-anna@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BL3PR10MB6235:EE_
x-ms-office365-filtering-correlation-id: a6d80456-9b68-452f-203a-08da95c43ed2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +AZ+fO/Uwhw9Wkv5uMufcs5GYTl3L5ozPYk5PwWnzubXel23jHhK/Xbpvzv9inaNURdu1xgwUH70M0cBS5dd4/6lifvQagfpcSUPL/ExNyXpytP5lyraM1Qr/aAxPZhpLIDS2ak5Dn0CJzPpUee6CQWMWso+jemmudUsBrmL6yDNn2h3ieV+pjLIO4UqM7H+e1WaP3WEQiqxC1gqDn+ljePuIpFhuoymqkYB5DWIL3nqY27x7qpA19uXOLNzlh3z7fie5xvwg9B4xJVh1e5uInq5QAsyhmsSCwCKmZPQt3y+YAXYrezKegLOPq5wFgOyC6fE9Ej11amsR5n4rp2BF0UG7YldlRimPkOUVktUlFncj6h77NT8yGSloxN+CFSda8nZxW7IkunGyyVPtFbFra/JTP2GIw2egNTBaeKjKaHL6ein1J03P+gJ+9X4spxG45wgVVKOZOmS/NnBRhsvHm9GmXa3oeOEPtAdO+0wzbMZ1gm66D0aNbMc9MZZCkybnlmIGhcgpXaSKl+df1XYm6O4QY8GoY2vo6nxfdIXjG6cg2JOqPbrHxTwovqlaCB8FMe7WTdc4pgiAA+nLu4XqqjOJN+W4HgLe3nugdP3KLKJKn0UMZ6puyHIFEFnscEOCtvSF3YkKsTA2XLG6FqO2GnBVQ/t7y3Kd5H9y34Cwnif1Sz2WlNVxyOed27tLfS94dWiJoOBC6i1DJK+fD7SnQa+8jBalpeZqprTfL234ukZ+K4r4XD+qH3lkPny98p5hy027macsVwPm/tMph+NEWKHqw8zu2QhdLIJezaXjfU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199015)(478600001)(5660300002)(8936002)(36756003)(2906002)(122000001)(71200400001)(86362001)(33656002)(6486002)(38100700002)(316002)(26005)(83380400001)(186003)(53546011)(38070700005)(6506007)(6512007)(41300700001)(2616005)(6916009)(4326008)(66476007)(66946007)(66556008)(66446008)(91956017)(64756008)(8676002)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dixP5WGMXKj9jG6CzTPhYyL0r5JjedTiMkonKubQB4owe1x2WU2EQR6JCFag?=
 =?us-ascii?Q?c5/HZWy4+RbwdhTf03GolGQ+PddS+ZrR6NYtTzljfGHNZs7DYWBhZYZ5kkQu?=
 =?us-ascii?Q?t/WYCAPl6qLa5xjcQk5OACnG+bpOkG0zaZrDC5rrNpAkF68H+9uSgHNnP1kD?=
 =?us-ascii?Q?bPdTZJXvGv53OZT0WSbfZDom+UzvzoHmHuTfvaursVm4gfcuD3kTALkRt2iE?=
 =?us-ascii?Q?NMLvKtSq8vM5IUwd4bcn2qaGnikuvgt9uE8wPVJ0RGo2SkszgzO2g4nBEZ5M?=
 =?us-ascii?Q?kiQh2jsRYNZKHiDFUVpK9KsVUcVhj/CnKsHRpECR6yWXfxhHObROMbyYLenA?=
 =?us-ascii?Q?DXScLoaEeYHNPHw5pLIGTRCxGlDJwHu73OAjiyaWo1GZ43XqBZ/CLtg12ze3?=
 =?us-ascii?Q?NjizYyIOudqDEw8aRwM84WTBetuvLlWxWvFXeFf08EKuLUkLJRNSqNvHR+Sn?=
 =?us-ascii?Q?kmA55QVM8kMFYDP4Fy7SlCpmRJtxusQeERWc4zOADjPrCZ6p5sTUKgOmQ+aQ?=
 =?us-ascii?Q?TC/WAXcjLjZAR3auAN0GCr9hmCs9SuDc0rbofJ8FNWKb7FJZAR2wzRFXYXgZ?=
 =?us-ascii?Q?tqvs/0zy4nghuX3J47SLe2FlIVlF483mGd0v5qOpzsl4YZL8uuiBncwkB0BD?=
 =?us-ascii?Q?XlKGuvybWDGVrR0WFEiPG+3bsJOOpyfG/RSB5aP4X5Qyk4nbyAEjVQVKDGXL?=
 =?us-ascii?Q?melg4mECSs781UwlXdSKOz0+FfuezOZa/B7F1Z7m0+SNvg1Zjhz0e7zkLPWT?=
 =?us-ascii?Q?PZQ/J/0AqeJUczPreY+fK5J//baFvLP6t0cTu7jJDN/QDWUj+CMtM2ocpV4a?=
 =?us-ascii?Q?tC1dFnSFN8XKfxRJncqRgWXDIN5YS9k3vG9YykzZE7dTnrQD7pZk1+tIeNz3?=
 =?us-ascii?Q?TJm/MMCHhzWtoAJqE9rNJyesSOQ43rdnD+2RDLvubpgqkcbfT6FN1p7roiTo?=
 =?us-ascii?Q?WVDkogKnVOi0dtnhq1eXbih5bioAY6djjHnVr2rp2E4glGMBnGWhCn2gXCV3?=
 =?us-ascii?Q?39kG17Ujx0/E3jnTEndrJ3X9ttwHWB/nG66eu4sDqkZV2mw8og8ZEfaOeQqQ?=
 =?us-ascii?Q?G2FoZtFti7aV8p1byAUbHeDuY4zlgqFgJ82DCOdrA2DM+cBn3U23HUZsCoIw?=
 =?us-ascii?Q?//BYZda0mXZ6JDl+0OvDauPNDXR/O8uuHt4GrLtrCgcfOH9cAAC4+/nIgCcD?=
 =?us-ascii?Q?bfaztWP253JJYkYOCFUXrufoLQl5KMAog2B8LqxgNf+mJJHcLC8ChVqaBV0f?=
 =?us-ascii?Q?lPBcB0S9oQohYFI7v8EyAT/e/D5OyoPjaqFiQZ85Moz4dB3poLTT14fCXAWa?=
 =?us-ascii?Q?HaWQcIpRlyn973u9hrKese1a419KFeGFJn+aCWzFxiiRuPPuyG74dinkFA6W?=
 =?us-ascii?Q?o4y1tqHsHpLCRG+jqTvO4NVVF7zcjUKDIz4ywjKX+bBU46Owr0X5RqEgPHjF?=
 =?us-ascii?Q?Wn1tadK16UF+IJmIfYsoq+qTTgPZbQzT1S/dh2yHIqNXsfKNv9sOIWy/rYuH?=
 =?us-ascii?Q?tuGuhU3tFIrd7puexLEge5wIO0zftdYKDMMUzuPyq+aX3IxJnuewQH5LNdjE?=
 =?us-ascii?Q?DAZoZTU5RepNGD6J1tv/hGmyhUCiqRfl9sixxew6rgj7IYUtbHYwwjv+Mo85?=
 =?us-ascii?Q?zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32900A8F10F4D64082739D4DC724089C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d80456-9b68-452f-203a-08da95c43ed2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 20:12:12.6277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v/wW4VtHDLNwMv6LLLtR3D1hD7GkjWpP24U8a0+dcX96iEovvtRF/h6ea0mLeo9+S+gvBaDKYL1Up5sQWZ2ISw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6235
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_09,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209130093
X-Proofpoint-ORIG-GUID: OEReD4l6BzJ-4cupR0gO_hX-zH4dkpSP
X-Proofpoint-GUID: OEReD4l6BzJ-4cupR0gO_hX-zH4dkpSP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 13, 2022, at 11:01 AM, Anna Schumaker <anna@kernel.org> wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> This was discussed with Chuck as part of this patch set. Returning
> nfserr_resource was decided to not be the best error message here, and
> he suggested changing to nfserr_serverfault instead.
>=20
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
> fs/nfsd/nfs4xdr.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

I've applied this one for nfsd for-next. Thanks!

As I mentioned, 2/2 looks OK, and I'll apply it to my private
tree for testing while we work out why it's a little slower.


> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 1e9690a061ec..01dd73ed5720 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3994,7 +3994,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, _=
_be32 nfserr,
> 	}
> 	if (resp->xdr->buf->page_len && splice_ok) {
> 		WARN_ON_ONCE(1);
> -		return nfserr_resource;
> +		return nfserr_serverfault;

Odd, I couldn't find a definition for nfserr_serverfault when
I asked for this patch last week, but this one-liner seems to
compile correctly. Oh well!


> 	}
> 	xdr_commit_encode(xdr);
>=20
> --=20
> 2.37.3
>=20

--
Chuck Lever



