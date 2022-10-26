Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8C960E373
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Oct 2022 16:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiJZOgR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Oct 2022 10:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbiJZOgN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Oct 2022 10:36:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885FF4F190
        for <linux-nfs@vger.kernel.org>; Wed, 26 Oct 2022 07:36:11 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QEDq2H021472;
        Wed, 26 Oct 2022 14:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FCN6UfnpnFSKK4zAOp/84G2HgK452jizw5f6fkFSLN0=;
 b=TRbbzCFYxeKxVr7F6oqChMKs2AsdCmzbTb/3lmiZdnplujnPGDmTjIA/1vpTglk+4X3b
 3BtQuqp8rprMbGTHEE0UEv1Qmj3izP/fw197gELgI5BJclaVqe1kX6zQXahZsU8huMdE
 k1p/Ob6O9ee8bH5q0C0qCxNMfBs1Ihlwlqzs5DP1GxF9w8RMmfX6hskgirEbPk3JwRpb
 dl4qLHDyZUkrP9H1ynKxy1c+F9M/sGbCy9dnTL/UqhhhP8w8uTtSMjKqAAabgIWewooy
 gKS2t8aiMu643GnhSxpPVRrlG02acUhwgnUegFEa/6uG3ZBVAHbGR/1IwKPPhPWzYd0L qA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc741ycus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 14:36:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29QD1LS6020905;
        Wed, 26 Oct 2022 14:36:07 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y5tdhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 14:36:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vq5MVpIzlLJqqTpPBX4s6yiOZeiSVVA1Q8Davn8bAGNfy30VL3xiRtz+VTkGHgej1iZX3wYzjxJvnD0ZuYOp/ZGQq1v5Bi/XdX81gOQIBKNWTPyyPYeyWE52H14Q8MtJaBjxUCeex7wy33TXlLC4xEBrDXRtkxji3PWWtvtgTG8YsCfN2KNxLydvLUb6JvIcMXNFwSIMhZQYV2Dw9NobMhuzqMklLfwHPlQmNcTRTEvbHaCSiCAozxUV3FTYrHXhov9WXqeYqB9M1cplZjVHINmuFBTxVEY8JU6+bcHacawAQzpu1OJotTkb8m5ZkRkt186rHHI8Kaa1xYt7EafK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCN6UfnpnFSKK4zAOp/84G2HgK452jizw5f6fkFSLN0=;
 b=PQo5UWY9dKJtgBEVK9MvaFoZ9/Dev26MnwUYlWuRSFKt5q+b/68uAN3/IoqnaEUAWGcIBiDjLwwN9y1eMdgJlBi9oJ6+vWBYAPdygkvUNIeapgTytO3L4+B1w1N4XhzWXW10f7FSxS6V33IgdBjF0bY7mpLVPGq6JjuHIngpHwbisuX3fudbpFZQPtE0Adx+6JMSd20g+td+hm2LjacF+jp58uCdDDxxFHoJbtewBBJu7ZKkcavqEzaSp60x6pV9gElgNZAwOi67B59mX/Y0h6tHofTDqckavM4sca1NUciHs1HsnZetJ78C5pmHboMMyGaYNvhReja2m2MjZjvFmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCN6UfnpnFSKK4zAOp/84G2HgK452jizw5f6fkFSLN0=;
 b=nQsZnPfhX+xxEsuGdyRuJDmbjfrtACKq9ErUHRH7u+UqtOyRJXJdWvU4QuTmaWeKtAmF/sON0ahqqKKgc7f1X4qVVkI3ZJqoDri6G2yTU4+glCubkZ5mJtgQlh8Rcl5qou3TMcHVC3kfGjCsYy1TiC3yE6JoTffo4EBMqqOeU3c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4564.namprd10.prod.outlook.com (2603:10b6:303:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 14:36:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Wed, 26 Oct 2022
 14:36:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix licensing header in filecache.c
Thread-Topic: [PATCH] nfsd: fix licensing header in filecache.c
Thread-Index: AQHY6UgyJjhEsyzLKU6cRbJ9KOmgVK4gvfwA
Date:   Wed, 26 Oct 2022 14:36:05 +0000
Message-ID: <33228E9D-74A3-405F-950B-0FA9C4846CE2@oracle.com>
References: <20221026143518.250122-1-jlayton@kernel.org>
In-Reply-To: <20221026143518.250122-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4564:EE_
x-ms-office365-filtering-correlation-id: fd06e4e5-394d-4b6d-958a-08dab75f6a0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O6HBZENVcoX3rnbTHb+eM9HyUT9kwVf91sMpJl6+n1ISHtNJF3leMuBEGI/vTT6Li/JOPhcyqIPuJbZlU0nMOpQ8DatgNMOLyLymqwgxC23m7rT6AexqOuZAZHie0O5MtfhyHXOnJEUjCXgpnYX6ETENX4WqB/bgXOPCegeMMSdEdGU/6Y8LCL/cPSPDbgMB2Yrbyuh+sLyjzd/veEfswy5K++VRk+R1CGqmxjsw6R5AbL1ofItHYxIXirNLCGbtew1kfo/bwJZNyu8sd77ld8sR8FJMqxkoZX0AZiW4627z52zn1C3JY4gHoqUMK9OpXtUBwOPODPmhG9aAuQALutx9gxJediDRZohWOXFdKBoc3o/qRJaBWh1m/ADLogNasvTaF09gGzvHBcJg8f1RvWNUaUalBd1RM2HRFKHvGtpygNKG974DuCzKDOaPUDtVa9YZYTGGn9RtfVhON3966p3NEi7KvwWIiL6tpK4y5nhYLfUe+AGUKU+GPDo0KSrJ2uau912pcVmV73DYYH24UklHoghNfcQBjewUOvEE/xXO2t+oc0Ggu/wwnuhaxuTWa+6OtP4D3Rw37VeDZzblelJnzuvXX6YYuuJ2gX+IEr9M/k7TMJnTVNVMB9sUkpPcxx/xDyVScYRxKE3niUZEPjDOEnFonMSyNajodF50YBitmqmMC9ALm3ayZFaNH8buVcnsuDq4M381yYPcxDKwKd0AxOYJ1uSqz1rxgXdCZBXtUaPezaKtaBmP6sgOr0IC8Z0r3AP2IJerG5TXdnnfa6xIH9elOIypN0KlpkF9NkY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(86362001)(8936002)(4744005)(5660300002)(41300700001)(6512007)(38100700002)(36756003)(26005)(122000001)(38070700005)(186003)(2616005)(33656002)(2906002)(83380400001)(6486002)(71200400001)(64756008)(478600001)(66476007)(6916009)(91956017)(66556008)(66446008)(8676002)(4326008)(76116006)(66946007)(316002)(6506007)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m5bcs3pAMQsXg/1+U283F/DNAqbEv+lFvRu8waKA7ATd2zn5p4ssEnbHNSgO?=
 =?us-ascii?Q?6uTIS9od0PC9JrnAJ03hpLak9DIbUcnf0Oy/ryYVxLWpyNTKi7Ga2zMY4mfJ?=
 =?us-ascii?Q?yG7/LXnH74apXVNwXs9iNjyQqNfzxeM49wQvbekCiUH+motKopJpOLduQFzt?=
 =?us-ascii?Q?GuAUN+EOmqfutci4BinsusRJ+G2FH4DkTW+TSsZWGwCjedBv+XdLiAQYvwkU?=
 =?us-ascii?Q?Q+jqot7xqtFCGZxct3KrxsHflZ+M3ctFsTQWKLIabVwRGvieil4xonSyqs0u?=
 =?us-ascii?Q?rIOZ/ItDQdZevo5zzLzV6BtZSSwyc5wuCzu54TiP5b5wkQlFEgO+6+bAT7mm?=
 =?us-ascii?Q?ZzDXXJyVM3opnfbB6jTJhCM9lvLRNDhq7781+VFqsJO7suXBkCVOyqKGsA09?=
 =?us-ascii?Q?hB3MjDjZRi12fllIyE5+diYVglpirfe4nIV59j9/xPyQBcDNH3iL/VxbgFm7?=
 =?us-ascii?Q?Q6E619aBGq+hblNBcB7Y4fBpMg/nT2PM62i6v581v00f/lPOedCfFsi5OZZ0?=
 =?us-ascii?Q?4+6/gNluLzNG75tdhQjmcbye0+o91u2NRhg8GuLTpyHPsgptvCTtttUPzrwT?=
 =?us-ascii?Q?MfRBrRJYkDIr+XFrGRGYvhw5+Hl6nhbmS9xPo0srahIq/Dnjih9Brz67wz4z?=
 =?us-ascii?Q?7ZT3u1ZihRyt/TwcW79AKT09s8kW3MduN0K2KyATn/7VhRBZkyDm3NuExsbo?=
 =?us-ascii?Q?jcFGhSydKJTDutyTOeTrfhlwz44MPkw89UK2ymnVIa8qU3EiAdC6vdDHaL32?=
 =?us-ascii?Q?blZBM6TADSLF9JZujnp5DK5dbknJ+5lbALKH7y1oSiIoSHzPLTHTL5NIpBQp?=
 =?us-ascii?Q?epWLVzVpaquqdd/mC32ufk133pcHJbAoZqG+P7RR//srYS02m/8nAm46W1Xf?=
 =?us-ascii?Q?05+Zzl7dsznU9xMvJ/tVSi2nJ28VDuXPpVW6dQRPMi2IMZ3Ns4BdxG936Nwh?=
 =?us-ascii?Q?9Abq/u2nPv7FW5UTpccUeyZgnN6qdlgWokzqLO5HQtCVpM94HzlCOkKSA1FB?=
 =?us-ascii?Q?UmPa1XfmqwpdS3z/rLM6a9dcJ+BbHqU5eHorcTDqv0Tg7raPhrMGyCVvj26I?=
 =?us-ascii?Q?+vy7y3XQb8B0TZt/eUChkTvF3g1N6ccYLi/dLUmIFiKKNXWoeXnz/ttqty/5?=
 =?us-ascii?Q?kwxvzhEJ9Oh6cftWVolkoHQLLed1cWZWM8MFxHIJp5CzipRAblBHjAchKBbL?=
 =?us-ascii?Q?gN0VlueApesvpAR+XoGJt7P15rWetoz9Li9UCGfh32ks0pNqiL603vFvCfhP?=
 =?us-ascii?Q?4mJiPd7vNbaEAUBMXHYVaBRPDr1d6HZV3xVY3glIqeRtljP2+9F45/JxltkX?=
 =?us-ascii?Q?TIjT6m4lNnI/rtbIZRrH+i88i1i+iETDMVG4UfWdtM9mOx40jwZxhuPVgsxH?=
 =?us-ascii?Q?dxSi9HaxmOOYu/8Yo4QC+iVC9/pDqrXsgwVdeM8Dd00tJwIF29jjb4XSjnuU?=
 =?us-ascii?Q?F9V6sGxbaVV4ipkOdUzFuPVaqWxST27whJsBCr2VWt0LBRzDqKFspApkaJts?=
 =?us-ascii?Q?QIrIxKJ/6NuLo3+rcw5wViGwOreu8fzbpKlfGRBJLFNHvd2dz+vA3Jlk359L?=
 =?us-ascii?Q?9ldrwsvl3hGO0tWH/4tTZJyjP0WOuzpTKigPhpQSXM32dKMJSCEWblP8hoEm?=
 =?us-ascii?Q?BQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22D60A753E3134419E7BD7B241C0780D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd06e4e5-394d-4b6d-958a-08dab75f6a0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 14:36:05.4732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X46MKiIi0DsWNoOQ83d796SzJJL3q+AT23Bbfz5EsR7MTgd+OCG8UFCbpZN0rDjwVckeXvcKdP7njUGX36/S8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4564
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_06,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260082
X-Proofpoint-GUID: MBuGv-d1QRW5XwSr4DV-BFPiVswl8Qpx
X-Proofpoint-ORIG-GUID: MBuGv-d1QRW5XwSr4DV-BFPiVswl8Qpx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 26, 2022, at 10:35 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> I'm the same Jeff Layton that worked at Primary Data, but the email
> address is no good anymore. Drop the explicit copyright statement
> and change it to use a standard SPDX header.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Excellent, I'll apply this today.


> ---
> fs/nfsd/filecache.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 918d67cec1ad..dbc61b243d39 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1,7 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
> /*
> - * Open file cache.
> - *
> - * (c) 2015 - Jeff Layton <jeff.layton@primarydata.com>
> + * The NFSD open file cache.
>  */
>=20
> #include <linux/hash.h>
> --=20
> 2.37.3
>=20

--
Chuck Lever



