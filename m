Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF12C440EEE
	for <lists+linux-nfs@lfdr.de>; Sun, 31 Oct 2021 16:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhJaPHN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 31 Oct 2021 11:07:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62454 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229685AbhJaPHM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 31 Oct 2021 11:07:12 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19VBv4jY030325;
        Sun, 31 Oct 2021 15:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YQO4HB3AAzOtFSBHjQ+/JZAyCkgyvoPTJNFU4W1hQGY=;
 b=1DWVbTxhEnFp16+jTKXCOWm3L9e4Pz/zRmUgVUKvjUDdZ+Lo4LIg3lXgoN2hKPawCOPv
 v91go/1x71yVloSZkL0FSFypBdYPGJBr2C/CwyFPmOcd1RJ7UI1LsArN8zDmjP1BYius
 Qwh0cXbJ7StmCES4CZoOWmlDgmQdkrISershFIGk4H7cp+Fe8TmYVuTLDDzNjDKCEz9x
 e1KrKOQXvOi/enjKcllSDvG70psws+oExCXtP932Lltju72DPMapuKOT0CBP0yA3hx54
 juGD7SXOUr/tuA6IpWMeF/bFgllLqtQZkU83hOOrUuScqiatZzNJKHqfxVsiAQ4uYljE VA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c0wxaaj65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Oct 2021 15:04:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19VF1lxQ121141;
        Sun, 31 Oct 2021 15:04:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3020.oracle.com with ESMTP id 3c0wv1qbct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Oct 2021 15:04:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0KQRydvHvHWMgpn1qFnIOqXD/9htFGBi/lXsmJnPVxCl87hoDfU6ni15Av1r4wq33orB/+621bC5AgR0so84U+z+KxZ5dlUaRiohRGA9uxweM+70Kblo96bZMTo5VxAiGJd/bXNSq7E+Mh10x+cS2E+2XQD9rq3QqQvnlHzeboMEE32JhXqd3xZL+OfmZd9TZPYVM8mVqTziTTIqjs2bDaFQm+RA3gThgjL44nuktdtWnCfsmCxLTIW2QLtuzqxqleEZUqkKdrUUmIEhAuV+2iHeGrI2L7z1t3fIKMHX1cIKKbwRzgWBnfq8W2fwzexejqK6Ki+GPnFy6yDwJgaQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQO4HB3AAzOtFSBHjQ+/JZAyCkgyvoPTJNFU4W1hQGY=;
 b=gWypa8fYWYLcy/H1qwLGdy8HXr262vP/x1RXQ7GTh/kuzTh4hMqMNFuxxHaBmM+yTgGd5Yv+ZoM6U49fBz/2oGZM2kHwTOrUySc41DduDOUg2K06F7qCpaXJedBed/xetcAwjUWPNtbU7E1WjGuhjhdAZpQfxeQ81qemFIAiUhI/cprKvJxUAImVmtbD1kkrmBEhfVePl6Ffzc3Yy+He269cDbKrQLFaiLLmxNmqPFCJfB1qx461EycZLAG2RnAabfEwRemPQh2kwY3nMp7STCmIlA1VtHlVvYb+R8RuWDX/bfPG7m6pSk1VKB+VsQfijJINHrLNead/6P9Nb/BQKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQO4HB3AAzOtFSBHjQ+/JZAyCkgyvoPTJNFU4W1hQGY=;
 b=o6t+ZVwm0qUjN2lvS0HWY5c8hw+2+QDn+oWTH+bMVAtZ+uPo+oQiDAWPjwzFTwgo/jXiQzHgdOLLw8CGlj9sWla1O95zMGF+cYXnB6mCbc12+YT3Zu3ag7kncj/XpjJ/wGjOs1v0eaN8Lz7FBJurKL64yaycb8ESl3VmvtLtA1c=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2488.namprd10.prod.outlook.com (2603:10b6:a02:b9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Sun, 31 Oct
 2021 15:04:35 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200%5]) with mapi id 15.20.4649.019; Sun, 31 Oct 2021
 15:04:35 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: Re: [PATCH] xprtrdma: Fix a maybe-uninitialized compiler warning
Thread-Topic: [PATCH] xprtrdma: Fix a maybe-uninitialized compiler warning
Thread-Index: AQHXzlh5ESpT5Pt9IEKLG0l4cvaW6avtNIkA
Date:   Sun, 31 Oct 2021 15:04:35 +0000
Message-ID: <3EC776BC-8E37-477B-98BB-C9DE163EFA52@oracle.com>
References: <2b32d41cf6a502918a685447cd749c4b1cb0d16d.1635685588.git.bcodding@redhat.com>
In-Reply-To: <2b32d41cf6a502918a685447cd749c4b1cb0d16d.1635685588.git.bcodding@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2ab1155-a5e8-4895-a75d-08d99c7fc066
x-ms-traffictypediagnostic: BYAPR10MB2488:
x-microsoft-antispam-prvs: <BYAPR10MB248830BE3B73E15887DE29D793899@BYAPR10MB2488.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:270;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LVR5qUGzIeYQyRIVXJYJ2gTs3qM2Cv3YvHZtY8G2XsLfpUTRIx7C/g5ovjJKvTwf+isBbPOBrGz1g5/cytykPQSN0oAnHG6jjiGeb5gh2OkQ0QzCHytByRIb+Q1UwzOeeqaWoHuKxqOpqlhn3vRAYJJztEAhLKr7TJJXftYx3yyMCItDy0dvXWkdliBLdJI+0aWrB/zXmr3K/kewgv/2uij8mrX8RDIIswc2nwtrMnlgvRP+IW2wwHgb5ibZLsOyoXEs1TAIkjgDMtLla0k1tUMYWdn6cnlsENWqvXU/58UtNUPgBrPD/uTIYmA/pICL512wmKBU5t0KxyEqgKYq797X4EoGmkRRERSm7Ak+jveOGQud2jVBZBLW+D3PbMyK1qtw6meA5Z0utAiflYqSG0ZIauBKiWR/CsE3TXAP9ya8o/jwsK7TaQiIkjmjts8jEWSUZQYj+xhXRc9ydENofoJOucEmWiKa0zSncmX45XoVI3zAeF08DJb7j+wWLLCb+ZVmefAnEJm7oBKlj/CUdNdgKKPXx1fl8l0qpGRsECTFUIebvCaO/Zo+NZJElmZcW4mncVLGqTWTMMKgT7oMgwo27/XOwmN2B4dOreVF9PduMz0t6sZwuSp0gDCmZY1nar86IPpvbGYbtjltCivSBdv/niZEbC2jusw/NxYvI4/ZMt16PjZ6ny3zNtL2Y3v5mSidwTxh66VoYb9u4BUEOvioKGRhkRs9o/8roRhKN5ZYh50A+bCFLpqjfIOkKjbN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(36756003)(8676002)(83380400001)(26005)(8936002)(316002)(71200400001)(6486002)(54906003)(53546011)(122000001)(2906002)(38100700002)(6916009)(6512007)(38070700005)(6506007)(5660300002)(508600001)(86362001)(66446008)(66556008)(66476007)(64756008)(66946007)(91956017)(76116006)(33656002)(2616005)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bxuRJye4FmVtBfTa5FhzgqWniz+S+jMYg9PXB6g5DraMWc7h7bX/uywVrthT?=
 =?us-ascii?Q?vjeS1mvcxtejnrLKZNacaj2gnMIf5TTRPonItg5bEQ+R8bTmXODGXgd2iCjB?=
 =?us-ascii?Q?AqzOXeIO0G8NLrbU8/uSZaEhLb+wyc7T0IquEt0BvblpHsRuhIYKrKDJRRM7?=
 =?us-ascii?Q?AvTF9gw0kNFW1hS5yRb5Eu1aldZQ1ofAeHoMXafstwAcd+5KYZYWGBWOaaoA?=
 =?us-ascii?Q?lMAxHqaeJQ3lzjfT+sYkYizvvn7hqA9gzQCFtOutPZGH+TNnXfqGFd95NSFM?=
 =?us-ascii?Q?Si8x4UuiS7jVVcz8eX4esWywqTqmUW5p1dEVvDq9ZUQYLo5o1cYCTp7Z0uo8?=
 =?us-ascii?Q?ZPVGCNoc4uMd5x9kXiNyPJuwmHzvGoy+MXmUU0EUN2rStzvr749FUVWar21k?=
 =?us-ascii?Q?ewDAEyI0I1Ox0m9JTHwLm1REscdpKxoZptRdjry5TvDUjvFGM8vgXiQFtQtB?=
 =?us-ascii?Q?UD98O1IImtN7W2hKbaoNqP+k95AeNVMACA0A3Vx2Pzp2TJkwzQZORoIKJxhc?=
 =?us-ascii?Q?D0n+gI7FAXa6hTzUgmP6JTkSg3aCFW3C1Ztxx8KxY3EscYDZcBtb+WIztl7H?=
 =?us-ascii?Q?50JQImLTX6O0kQ0f1SqGcIh+cXsK9RsXCAa2WqXbAiEyFGms5poOqa2mPzv2?=
 =?us-ascii?Q?MlZb2KAQEjULVixHWUS3PfGptMcbSQld2CnopA3KmTmQNttTO8PO05Vs+L6M?=
 =?us-ascii?Q?KN2jepnPumhcsGIp0TKDOx4ImrnsAiz5yOC6Bn+4B40FJwWxmUgJGuAC1C1G?=
 =?us-ascii?Q?z5TEg8GhQB+ayLiGCwcQKbIwLb3wOKnRR6DCtFvV6pG4ArH4sSaVJPpmCMbx?=
 =?us-ascii?Q?PQ52ho8M4JmzuLpWmKmap/q6u9LeDGOBMvikpUvmnDIRPBDPGuwXf5wM4NWN?=
 =?us-ascii?Q?auaqA4O+iZPS7fnYIOLUAifh6t9ytOHjAywZw77+0OcXTtlIppivhrMYHbL6?=
 =?us-ascii?Q?/GuEh/CHTEsb3C3hn6as0xdXc28IqXJtXzebFXKUdWMcWVwn5lhr53spVnod?=
 =?us-ascii?Q?THleiEPm3lbFGyZoE1K7lWDFZpZ0jJdl53BX1+egbXBFEEAuxcsASMLlKIk+?=
 =?us-ascii?Q?Ct4Z4usnP9BCO8zsSy07zhmX5IJNNl0IfxwBfcgozlBNKuPRjnB7EDDRjNfQ?=
 =?us-ascii?Q?l3ULHGLW+ZvLi2ag5vAdtgGPVzhhL92W6pfoDW/fcxV8Jm+DvlGidJL8/i0D?=
 =?us-ascii?Q?qJCIwt0h+yBmJYoxeBH+Z1UaAZ0JK0lH/IwEIfPUG7bNzL7PWqYTTaKA60E3?=
 =?us-ascii?Q?BVIaWhnBz4tqQ5PJ5mZByY9oCN5ko/+EMT0in9hWlNRVG+tDfbwQgIHtxUY3?=
 =?us-ascii?Q?Fq14ck7C/LzrI6kx4bWn31lZCKU5AuFJybDcQSUtrHVAM5YVGTC8tzPkFsXt?=
 =?us-ascii?Q?clKn9KUkIPw1oJYwRC91CFyJbKJ/AjsCydVtSlynyWUihfPazJhOk/7gkuIm?=
 =?us-ascii?Q?CEjSJeLBbpHdmEvl874rgd56cLxfW82SpsZZ/QXoYc5SOMDaIAy1X/OrpJNQ?=
 =?us-ascii?Q?BHdMUQYoC3o2frQOUwFjn72S40vfC5n07945ecx6aO0f9iA9sryrPEKNPC2u?=
 =?us-ascii?Q?UOvZH+7rp+kSCjGmnnKeK7o1NeDuLwBajEJITpG986e7PWWaeM7Te5WsL0mS?=
 =?us-ascii?Q?RmT+5X513WN+ZnEeQMY/E6E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FDC19C377A9BF94C89BDCDF1E7E286B6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ab1155-a5e8-4895-a75d-08d99c7fc066
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2021 15:04:35.1263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: klJuTlpSjgz+Rh+3RRB1T/yR+xGDN0oJ6DJ3xmrPdz3PVVfG+SIf3FXiixYNZ1i5hOGb4cNbyS6BNH/h3Ukbzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2488
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10154 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110310095
X-Proofpoint-GUID: G6ViPhlHMhX__EX8c6K5mRa9oFKdFiTG
X-Proofpoint-ORIG-GUID: G6ViPhlHMhX__EX8c6K5mRa9oFKdFiTG
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 31, 2021, at 9:08 AM, Benjamin Coddington <bcodding@redhat.com> wr=
ote:
>=20
> This minor fix-up keeps GCC from complaining that "last' may be used
> uninitialized", which breaks some build workflows that have been running
> with all warnings treated as errors.
>=20
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> net/sunrpc/xprtrdma/frwr_ops.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_op=
s.c
> index f700b34a5bfd..de813fa07daa 100644
> --- a/net/sunrpc/xprtrdma/frwr_ops.c
> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
> @@ -503,7 +503,7 @@ static void frwr_wc_localinv_wake(struct ib_cq *cq, s=
truct ib_wc *wc)
>  */
> void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req=
)
> {
> -	struct ib_send_wr *first, **prev, *last;
> +	struct ib_send_wr *first, **prev, *last =3D NULL;
> 	struct rpcrdma_ep *ep =3D r_xprt->rx_ep;
> 	const struct ib_send_wr *bad_wr;
> 	struct rpcrdma_mr *mr;
> @@ -608,7 +608,7 @@ static void frwr_wc_localinv_done(struct ib_cq *cq, s=
truct ib_wc *wc)
>  */
> void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *re=
q)
> {
> -	struct ib_send_wr *first, *last, **prev;
> +	struct ib_send_wr *first, *last =3D NULL, **prev;
> 	struct rpcrdma_ep *ep =3D r_xprt->rx_ep;
> 	struct rpcrdma_mr *mr;
> 	int rc;
> --=20
> 2.31.1
>=20

--
Chuck Lever



