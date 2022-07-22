Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BFE57E81E
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 22:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbiGVUMb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 16:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbiGVUMP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 16:12:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CCCB5550
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 13:12:04 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MIYQ2v018178
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gekzdy8Yoi+7kAee7Dle/Hioxeu97aQRw8pIgvtGKDU=;
 b=YjyKnIwdbQVnluiGgFfCiNz9oWxqoa+v1GxJBMCIGuN/zkXbeI5Yi895lWPjESoHIXVZ
 Q16+npRz4dyVu/Llbn2k0hip0iy/C6K2JtsqzJnLjqI7U4/JPiVmn125Z5bui8jK9FEy
 a1Hxh14iErCLiCukNS25pjiDPLFbmNpGKtDFoCBT3Lj4ezjEwyMX17jK6KudWkEf4drX
 DNc6nruomlrctpn0lQVOQRQuKMkIO+eHEILamyOIf3UQIirB9FYdnc9d6M4ksaw7Yh7O
 XueRLayn6zwIKqGUqJw5T+1L9UGl+cbeVYsF1giVDS4vY9T905L9RVb5VKVuAHFZczGg TA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxsgdng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:12:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26MGhERg022173
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:12:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hvhw4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:12:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=af1nMuIyqxQUvuwXT7Z76bPjuuwLYiaYP/8rt7FYvGMnEqhHv4V4nw8BjL/oYRIo3qPuqkmISUjzALTfPVucyEw15ShGwF1cvMI/BJEaXAIqh2RZjOfrY1al5OGtbaelS8muxw5TnMU/TCr8tBbIFlEC8keLbQ92MRgfiRHXxtGjFjDvirOCRyKsHHEUjiFhZL670Z8ZfshnYOGpeTdQKJtTN8cLVvNd2Y3nRBeSTdVnJK8W2P222XdHaieA1pXHlt/0eyQRsoXy0eW8NoDjguJziMqGfsVFRI71KEdQtlcJK66XPrSFQhTuMT+NXIyEZFOS0CSxMbx2z42Jcp/LkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gekzdy8Yoi+7kAee7Dle/Hioxeu97aQRw8pIgvtGKDU=;
 b=HbKTpQ3Li/qAJfdIk9Kfpwdh6cbU2GyqwNF0NIyIYqcttDVZzX9wVwKGiFIAT6e/hd6+hcx0ZtdRjDxZluAqraaIFQqItB3XAuM6JFKRid+Vllhe7GraDu5r7epvo+h9CD4Ac7m/tdujJjJY5PmQKuFjM6X1TcM/Vz/cljdtNMbqSRYt7nZAYDWPk5CUtFrdN7wDvoSGyIw+dRewhNuKLkmSOLjz4R+AT/YQQNGOoZ+z0efMUoMLiKmSTjPcC3da4JVaa8JsURM5vGD6yTrdgS9y0cWIrRuoee3rSQVzIx1SbpVx2aYlxSJSePW9tDOmUpZoNaG4bN3RVlFg3Pyrgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gekzdy8Yoi+7kAee7Dle/Hioxeu97aQRw8pIgvtGKDU=;
 b=TetyaaOYSouIY+sKn5GrUjB7+UWCFcewirVil6ELc+CMQSbBKzxD3sVzkSuwxAo+N2FHzctIv1cH7NaYed8PrnICLv9yo9iIl8b/gn20K8qVSm2QWWZ49b0ItlXuYhKUCo2LsE81oaeTaQ277d2C6boUhIUaXpsrmaXZgAy0gJg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB3182.namprd10.prod.outlook.com (2603:10b6:208:132::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 20:12:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%8]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 20:12:00 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 1/8] NFSD: Optimize nfsd4_encode_operation()
Thread-Topic: [PATCH v1 1/8] NFSD: Optimize nfsd4_encode_operation()
Thread-Index: AQHYngbpSQ9QZL9xbkiIK/IHMr+cjK2K0oqA
Date:   Fri, 22 Jul 2022 20:12:00 +0000
Message-ID: <A87D312E-1042-451A-A1B7-438351BCE368@oracle.com>
References: <165852051841.11198.2929614302983292322.stgit@manet.1015granger.net>
In-Reply-To: <165852051841.11198.2929614302983292322.stgit@manet.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe5a68d5-49ea-487e-fff7-08da6c1e6f93
x-ms-traffictypediagnostic: MN2PR10MB3182:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8YBN1m9cF6Yq0i4vYRdPfT37j+DB5tqZtOc9+UGpps00q64As9tCwNbpMSDz+4XL+bf8oEqi20u9/y5KJuJPUK/305wpcxDsUppAU//GfHoxPBAnJAyXxvFdjgh7AiMaClkmcI1lZnDJCA6p7gsbeEDy8olXZ28iKeNqzMG5VHvsrgX2eYd+f+ai/SyudaqJh279RRfJZB6+bmw0qEci0ma2W9bJvGt20dZKCYVHz9jzB/1kuTUawm6wXhKipfu7H/+elsZV+VbWQ3VzRtS7URyF0xR4MLAuO0NcIz93mPIXmdhOdGyh9SIH3+MW9cC6aaivVzETbb1BQLP/FjiKo+rU9Rg5QPWOGk+yttImuOrR7ezjIZ9AJpWtsznYaAdAp4z1gwqAStjuQGi5c8vdFuvxG9A8JrE/9H4EdbiaP02370Xanru0BvpRlS+EWcGkvcCPGBe+pr3e5lTEwmx99DU4O8qD4+i+Kx+rMVb3U00Ib0LCzluj355eENWPLlfZ5gwlWDu3UrQiFZoTxUDi8ncskJj01yP238KXvengb6le3mnWUl6OfW/BGtIOiigciG1oQI2Z4iqC3yjsbyyfpgyx9flV03t6iPOuVz8SN+caVDPa9NlTKuSoiqwsY7SfJXC3KouyyTPX/10oHP1HBOa9SVTqid641A8fP4l1YTEzUjuriyMhcoUfEvjHcaQ323cibqIUCes0jfBD6vXfHND1749AJC9dDojj1BCu4LCFC2fiWWuGfDgppoEMZUL7rmrk3CaRCJ34/JKygZYXUvaqYqW1pZFk4cid2xXRSkxYr3UzI6nQ2DBUxLMdFMTsXFQ1WapLb+DBE1QM56hPAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(376002)(366004)(39860400002)(346002)(26005)(478600001)(6512007)(53546011)(41300700001)(66946007)(33656002)(36756003)(76116006)(6486002)(6506007)(2906002)(2616005)(71200400001)(5660300002)(38070700005)(38100700002)(122000001)(91956017)(83380400001)(64756008)(66556008)(66476007)(186003)(66446008)(8676002)(6916009)(8936002)(86362001)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2X4hilqVPYvsAkriUj4WAEmp+457xdHCnwH1m+kP8PhUDMk1nuurXAfMY6WQ?=
 =?us-ascii?Q?cNh3kBQNId1+B7yTkhga1xRFqMD/Zk6OWhsJaACFQWhD/P/Iu5OEprwNtP11?=
 =?us-ascii?Q?AM/2gyiswcuvaY6b87h7eP4dhHwDhHdNhGyk345VNYrdh8UXq0I3l6GLYdRX?=
 =?us-ascii?Q?fiIGOMhxRUDoQzbajQPhFJm+4RuL3iP3TQOiq3jsCWaTLZ+6kw4DbrFT893a?=
 =?us-ascii?Q?9kcsdtnV6oDg5M5FOUrhSc6FoHbyDnUxjDYldLhvWTpss9Eshdu79LX74oiD?=
 =?us-ascii?Q?Z+A9hkUoa0772kgw1MYTKXz+WwPxFeTgWRvB4OweuJ8mAQNTiAtxvNESlRjt?=
 =?us-ascii?Q?OcrU/bLsmMqpRNTWbdAeXe5lm05AGdbs5RGNEztpm3H9StHBqatUqQ/M+2Q3?=
 =?us-ascii?Q?AYcVdw51ceZahRNHVm9NpwIJoAgP2xDhNmsJFNAtV9d5OVOctgpG4zq2+o12?=
 =?us-ascii?Q?52Javxaz2URl6hCd/L2yX95uz1xayUCeUBaf5YWa3dVFk/Ba5brWwxlIviJY?=
 =?us-ascii?Q?U7LQztCniRSeUZvjvGYa6gEVpQKculWhCPpReOPISpQtfyL8MUr6HSxGNTXF?=
 =?us-ascii?Q?heAzcKyPROhbcQJrGawSPGBmJhlwmCqVp7K5ismuFc3HauNYLLwRj9kau64b?=
 =?us-ascii?Q?cd9I7zb6vOVYdiJCrL8faxWgDawT/GsE+pJ/X5C/wVC3usj9ENGNSphugVxY?=
 =?us-ascii?Q?1/bEvW78WOe851oZZvjzbjn09iFc7Ua/q3Zk7XlongsxFmAXF6qf2pNtxPd9?=
 =?us-ascii?Q?BLy3ne0U0FyR9ZiaOjub3Nm1xD5qgvtYMMajak6qVMGVLL1mP56cnpCeJud8?=
 =?us-ascii?Q?GiNNdXgP0BXuzWPixa0DEE+IIzy5Ojnbm6aPMe+1L6W5MtCgeQLI1dAqgJtS?=
 =?us-ascii?Q?ZzBwAubf65bC2uJPIXv1o37pTjILZHN/YKMvuKDJ8Dy1ZP7IU+iF1TspDgKd?=
 =?us-ascii?Q?6u+O1cvC7QodJualElPT0l96kDPmKnrnx6EYvz6LYnKXjvr+ks8QP9S3Go5r?=
 =?us-ascii?Q?bxXIkz5SVvoELquk7joO2CVDh109B6cBTySvu3wjCKnRU2WUdVD/CDG26L6h?=
 =?us-ascii?Q?o2ccJ3ZBayvxeCK4KitokMBJ7AIaqa1Ud8ESNn4VcuQAuTPXQWY47EBjHKw2?=
 =?us-ascii?Q?r3ny1r0X7XkkcmldH48K4oYA5C4cnWfxQJ9fRwohCmKOPdMVUyjannZxGbBL?=
 =?us-ascii?Q?I1FWMSYXWNTsjMn4WWKY8AAzTDfRMretfQylsfoF/mkYD2VRYYAvYfBhttuo?=
 =?us-ascii?Q?UN7o4eCmal6F/vM3lvWqEo0xIxKvJZ9Tjwi752Dmi2Fs5EdqeF9PVRbr6Ucz?=
 =?us-ascii?Q?DqV3ow9dZtN6hqY2SspHBmDloLcVlx7ImYF0oTItRzp697mWfjTTNxs42LYz?=
 =?us-ascii?Q?/AzsE77YgaNLiLIxavmeMo1z/iDGu8KbacvnUSOSM7Gy4Y+h+hbCugDYQUzy?=
 =?us-ascii?Q?5TONSVUSDkenNJ+eUaZ+rM1hAHkUc1DlaTx4Uz0uEmBavg+BhyMva2Xb4J0d?=
 =?us-ascii?Q?c5oLa2mziPJu7f2mRrBzLn8D7VP61r1MVE8cwdPNBvXOpubpAD9IJ0F3ZnL2?=
 =?us-ascii?Q?Lc4I3InDYt7E7/FSiPRvudMLX+4st4wIm65hL3f2/LX6oMY6H3hbm3CE7t83?=
 =?us-ascii?Q?DA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F1215133E23BDC47BEDBF990C0EB6BFA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5a68d5-49ea-487e-fff7-08da6c1e6f93
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 20:12:00.2510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LVX0VyBX+46mGDWowZ/3D8gg+wXVZ3uNFA0k0pDkKSliFT674agPVymnMporIBaFBzhKck6hzjJka0FkX9Dy/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207220082
X-Proofpoint-GUID: 9ogBl0Z2FuHBPhCz1qMgpbjAxXgPx3S8
X-Proofpoint-ORIG-GUID: 9ogBl0Z2FuHBPhCz1qMgpbjAxXgPx3S8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 22, 2022, at 4:08 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
> write_bytes_to_xdr_buf() is a generic way to place a variable-length
> data item in an already-reserved spot in the encoding buffer.
> However, it is costly, and here, it is unnecessary because the
> data item is fixed in size, the buffer destination address is
> always word-aligned, and the destination location is already in
> @p.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> fs/nfsd/nfs4xdr.c |    3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 2acea7792bb2..b52ea7d8313a 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -5373,8 +5373,7 @@ nfsd4_encode_operation(struct nfsd4_compoundres *re=
sp, struct nfsd4_op *op)
> 						so->so_replay.rp_buf, len);
> 	}
> status:
> -	/* Note that op->status is already in network byte order: */
> -	write_bytes_to_xdr_buf(xdr->buf, post_err_offset - 4, &op->status, 4);
> +	*p =3D op->status;
> }
>=20
> /*=20

I hit "Send" too soon. Here's the cover letter for this series.

write_bytes_to_xdr_buf() is a generic mechanism by which to push
an arbitrary set of bytes to an arbitrary alignment within an
xdr_buf. It's expensive to use, though.

I found several hot paths in the server's NFSv4 reply encoders
that write a 4-byte XDR data item on a 4-byte alignment, and
thus can use the classic "*p =3D cpu_to_be32(yada)" form instead
of write_bytes_to_xdr_buf().

This series replaces some write_bytes_to_xdr_buf() call sites.


--
Chuck Lever



