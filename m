Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE25F72E4C8
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jun 2023 16:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239765AbjFMOBj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Jun 2023 10:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242423AbjFMOBg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Jun 2023 10:01:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D721510E9
        for <linux-nfs@vger.kernel.org>; Tue, 13 Jun 2023 07:01:34 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DDOUP7004486;
        Tue, 13 Jun 2023 14:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MCXVamaBwnN3ZE8GX4Y3BtudwLruSkr6XQa9N1HKcng=;
 b=RYWLYfvfzDTK0E0N1tIMWLt6c6pAOXVt+FYlXiuvvpD9LP1uGK411wjDt8VxykjTQ4yz
 DK+KlJ72WM81/IS8aiVgF5WUHrNuGyjKXOmuc2EpTq4k+DJz3PsZYtMAaaY9VbX1Jy9+
 cy4/Ir/gCRHdwemL49xZxpzCo2ms+6nlnOW/Msd558hRcQF3fB5/PDba8Ut9S+HrwNt8
 m8KlbBSLODf1rQTL3bsKGQ47MwTE+lxYgMjFbUQR/xVXLvyFGi4f0P2GVmLZh4dQakIx
 pwinC55Okj28+syprdFejAeetL3bnweNEHX5p2H/wh5mwFGLlumcRdKCgWBKzwOkfMMP Hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs1wbuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 14:01:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35DDfnCN021725;
        Tue, 13 Jun 2023 14:01:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm4732m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 14:01:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIAQUHfB2K9qxq6xQoLRDye44wIrcN9FgiTFsOtQLByKKKpFJ7E870hUBQnKuqQtM5v8jlH1DELf12T/mxgaymD6A6FAk0E00nvGToMmP8bHvKEjMarKy4rRcfOUH8nZfPSVt2tGRVgUokpa8UAM2SqM7FkGDjLfclUnnpUvApBtvpcU0uz67y8a9zS469/jruwYm55T8Hij9e+KrpzALAUPPawv9lQ0l5JFE1yI/ryAftmMOIG6A5lNaHruPy0K7sDyC9HOPPyWdarL/Pb8+c6BaAE/h67faxio2UG5FMYBOOunY/6YcHoyY+6aRAkXizEc/3nkXoP+E9IbK8jA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCXVamaBwnN3ZE8GX4Y3BtudwLruSkr6XQa9N1HKcng=;
 b=hNoiTZmJV5+l3bopTSNhLgoq8HaT0I0UNgAcizv28I8jgpMjvQOkUlUgejB2PhOhtlxfPklxEUihN5T9OuMhB+WY2RYndrU1QP4IA8xToi6lJlIfT++4i+7jVGRhlZ9Thyhq8XAGQeGTOEUWaNH6+eprARnzwcL/uK+rp90KBzytyF9QXdFx3I/XLZtG7flwg0ZEC5NOksClLHlfWPn1m0EGvAqaKa6gtZ6xt+aYtq48wtv3yyTK4pNiddOk7fd9iquPuNmwFTlUna/He7jgeOSCFlKIbr45yV4n0u6GEIv6bM538NZKpbjONTdXThwuak5+mMonc5bCBm49TOV4SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCXVamaBwnN3ZE8GX4Y3BtudwLruSkr6XQa9N1HKcng=;
 b=uxHMgRB9xRZ2qh0vrsv/MX0IbtqTVsFVbHeHveuULYsEBmrLXhWkjSgMNMTddqlfGSIYKSyAWjIGLszQ+v310bIdffIAbwcyeLQcqCZFCQFEN8fw1nMiaTLr59wYMO9WPgqb3QMvQjfrQo9nsj0v/EUjB6k+gGEJz2Qiq4gOM1o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6173.namprd10.prod.outlook.com (2603:10b6:8:c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 14:01:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 14:01:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>
CC:     Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 0/7] Several minor NFSD clean-ups
Thread-Topic: [PATCH v1 0/7] Several minor NFSD clean-ups
Thread-Index: AQHZnTgVF3K6hRJFDkCiZxprc1wsvK+HOZkAgAGCAQCAAAj9AA==
Date:   Tue, 13 Jun 2023 14:01:24 +0000
Message-ID: <836F2D6E-6268-49C0-ABDD-6971820D310B@oracle.com>
References: <168657912781.5674.12501431304770900992.stgit@manet.1015granger.net>
 <0946f8f0d8d1901ade3396b84931110d6dea5785.camel@kernel.org>
 <1a7ba06a-3b53-777f-dc2b-73c8797d2fd8@talpey.com>
In-Reply-To: <1a7ba06a-3b53-777f-dc2b-73c8797d2fd8@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB6173:EE_
x-ms-office365-filtering-correlation-id: 79f0e538-a1e7-4104-7556-08db6c16acb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZVTn2tU6C/M5/khlEJMjbkkcz9Asody7qNOzyZoGf/uYguDjXecC2nLGPlZ2nwwz6e/VD7NYYY0jxSLovCPmYYKchOctmFKttfvQooyG9SvNT3Y0knxgjfbw4BntHEiYITrA93K6TnUNX+MaEneliAUa1HwP5dddWHKWreHhJ+KYXDAjlGJ0vsZN4I6+b5GPjWDAAehrsdSeMW+snmRKKWYw2EbEtoov3u+BjtxeE3E7ywHv/1yhNJCReBAu/ehlHGMf8WxXCujywdogegLoN4aW4LDZYd0euYiJmgE0w/gzcvI5EFAoHugZRYapPGJILkBxEPIYpnG8wsZKHvG9JQB6kgkgATUb84mRkqrgqoUHAPtJ10DsvF1LzyW6l9HDuk6zWVVaKF6KkLjRF03WvvfFs6lDLX5HaFFdB1RbkygWkONChl581xqG+I2ZDM4BU26Aoq3v30pK1hsH8NINfuLL7akWpbGMfn0BDtG7LeNvpAp3x00t4HfgNJU8/s/sus3SkBI+2iM08TJtv7jZldz20IxCUEzBnYv9mr+kv6m3nCtyJot3L/mgOulOJ2767Frp2OSMfaXusmqG5R0eEpnuwQZTsQ+FpWW9Tvkj/49KQe7ZW8IgpgoknXOlVtAvf5safqvPxKVSLSm6l3TGLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(2906002)(2616005)(83380400001)(122000001)(86362001)(36756003)(33656002)(38100700002)(5660300002)(54906003)(6486002)(316002)(41300700001)(8676002)(38070700005)(478600001)(71200400001)(66556008)(64756008)(66446008)(66476007)(53546011)(76116006)(4326008)(6512007)(6506007)(6916009)(66946007)(91956017)(26005)(8936002)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e1AQy5XEntcUn9fqIgTK9lVN2WrCL5FzKLh5ggbqaLQP9676BT/b/i1KX60v?=
 =?us-ascii?Q?VROEO7QIV71RE50tMBTvzGQfFyzPP8hF3bHUkU5OWPgdoU5AgoirjIluYmt7?=
 =?us-ascii?Q?x9T4Kcs7KTtNhaK7oqAW+70YV18ek2lnERkCuN21wIZ3F95b2ZNIVX4v2ZKO?=
 =?us-ascii?Q?hYa/Kuyiz4M5PCJuvXMna9X7sCILZbNFpcUDDW29Sf5OO6VpgD7d+17gFHwH?=
 =?us-ascii?Q?Pqmth4InKaJoKamp0QsE94XlWtnJjCkTpoEJhWRexZuXBtWhpDfKrXyOlvbo?=
 =?us-ascii?Q?6KAv0HB0R4vsTsyBK3HsJ8C6brdgKV812E2/J4y71mnweAlnU1jsfKilDR3D?=
 =?us-ascii?Q?xjGkb9/WWyQRkRUEiFU77hjqXaOlFa31GXlMTMO9061IEpb8aSb1yGRfrXSl?=
 =?us-ascii?Q?YdhndtlJOlBDtf9QOIIneJv4SQzIzByTKHw4CT4/LDCkwJGwPm6Ujhs6w/4z?=
 =?us-ascii?Q?VM1Sy1tggMbd5VJMVAoo/uAHJ8ga6wDfabj7CLMY4yVn7mSt1cOq6f+FBnr3?=
 =?us-ascii?Q?de/sOWv4Jn/221MC9zRK6oDjW2MTKSD6ln8XFqqHPBO4mv0SvBtEluzkX6Iw?=
 =?us-ascii?Q?XzAYHrSDl3BM3hgUv6iiFv4R1NuZQcrtRNiM7IXZgSZ8CVXbIySID13pDzAn?=
 =?us-ascii?Q?geIXukPxUIm09+jkQDI0yPp8jpF9/17/rfNJs4WgVcXGq+C1wPMEH2u/g6Sq?=
 =?us-ascii?Q?1323SYScyNAK31RB+UbtfpjgnaBOqNZxWYBz0VBO1sZz/cEVg9/zvazy+Xr7?=
 =?us-ascii?Q?hxM5RDcf87e6bVNqvh36QDG+i8fy3VEoZtnNOMBRH+dYBCkwQyAJcd3Q/Blp?=
 =?us-ascii?Q?luml78bhEmkejMiF1mS1VSWzSDCGFD+EdFt/1oQ7QlXA9vxilWyElP8JjiRO?=
 =?us-ascii?Q?VNYDNjStX0MkCy8uCBPQhsqcsiDsavXL26N6pLRWoC1jB5P+hJPGMMjKB4sp?=
 =?us-ascii?Q?bPSVwsD+6Mj55+q38inBSL4R2G/dMlAY5lE77SfovAhlIB6/N3QHlSkqv/up?=
 =?us-ascii?Q?5X9w6mW7LW/6WD9Z9i28QI6BrmWGe4rVdBkX68IwpDImGXwWZDHNq38ov+HM?=
 =?us-ascii?Q?9FxUFqK1Jy/6J0zEaRTaJuvrfCKF8Wg5bwZJwz8OegET8PYDVYtij3GfbHXC?=
 =?us-ascii?Q?fep0UjLmetuqpE5KmxwhTwe3QVl+4DC3op7Ibwmd2hkOsLes7nFgju4R3JaF?=
 =?us-ascii?Q?IvBSNOzcZ1IitMwRHa9WNyKnW/6evyF+Lio0Ku3xLePLdDLaQ4PaJ9SfeEiD?=
 =?us-ascii?Q?thwjX4GHfk7wJ1AGXu1dauabdMR+eCFbxSqEupliWU2qZ24yGxRBp15O0/Mx?=
 =?us-ascii?Q?Ov31HW4eaJf0EEcpvMbqRfL/2U7kkTrxetWKFJ0eQpZa7dsusdh0cd1RcsCS?=
 =?us-ascii?Q?DSI2V48HyIOvxeE3p8B6p40p36qkNvEp04P9mppRaTP9MjGJUmeZ48mkrZ6Z?=
 =?us-ascii?Q?0OPXMtr5CYdpLEEgN6Al43xagB+klXOITYvSL7/imtz69i4nFEGJ7KDrgxBh?=
 =?us-ascii?Q?HTrsZ7QN/UzHX52mC0lE8mOso0ue/bilvw6pvY6eIeS2iTxGT4CTxAgnq0lW?=
 =?us-ascii?Q?OBv0AF+0kAg2eAGFaeaY+sWhYBmwvfAEOfC5rj167WbdMqFa/PU8WnUGuXQj?=
 =?us-ascii?Q?qQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20C4D8A8DC694D41AA8935CE88687782@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kSLeZOhF2CXT+eFe+hbTEk9l0rMA8FdACozwG3aX8gzGKZjMZEDPIZ24QLuRaSafT0Ec5cmteEB/y4JD0ovtGEsk2SoZ8vCN+mkIvlYI6eA65yQBFyAdcuhXU2lKXoFizglLBa6D1RE2A/yTdNHDgDoeUjtZOAR92lM3r7RvWQDDkqHKrB8yKAu0PgM3S5kGpJ22HCZ1OJeayjV0uhC5Da0h1wBARu8apm47Ov3uCh8zFcj0fY2hBlDGuqO0uUvt9Q1vi3IfOjYIA2w2bELxKY9XL7h5DlHQiOM7+1+bLRBz0DGk+jqftIJbYppFoILdys2Z3+/yRCl/PkEdg6ndOkaPZgk99lL9OLklpEU2K5eOTq2QwiF9D/kQcHYax+i53LEmY0JLDMSqtw4XZR6+9HHFqA3fQOp1bR5E6iv4n6XlAMVq5A4RXz1P5ImWTPaKnAgDJDFU+zaj3yV9q7r6d7SQp9V820x81DRluPIv1cxayXJnpu3qvfa72FVlXwowePNhDiLjRjpBqbHP4IhSFt74rBnj45rIK+lYgCydEM1y1q3WZnLwNKrTI2RP0YKLFjJwCDGtBjXdDY88lRLqDW/emAUJgM5sQn4g/7FIBH7vLALNeytgmSp0IQRBTu9guImXfRSYQdi80xM/s08Nf/n/Ig39hh6a1/ElyO9NAQD4JvSFy2YByrYdviCIGiTE3iput74m8hsaGfPXsdr0xOCg0jXBcOXNon5oBoby22MiQrw8fgnlFeZlnYDCZytN86c9nybcyiVmw/Nketu9AlF0DpN7mNa/lpmjzdGRs68VCg46RIuF6Hkf2/mQ9jnm
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f0e538-a1e7-4104-7556-08db6c16acb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 14:01:24.5531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B3ReTWNYvsIDW1r1epdsTSOCadvTZN9wZF0Er7zLGBCcIiongZyOfYPDaD0Ig/cBSPMaW5wfnmHlkG7+/bTTgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130123
X-Proofpoint-GUID: D6owLxP5-wXLvU9ayPay6_PL3Ulxx2-d
X-Proofpoint-ORIG-GUID: D6owLxP5-wXLvU9ayPay6_PL3Ulxx2-d
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jun 13, 2023, at 9:29 AM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 6/12/2023 10:27 AM, Jeff Layton wrote:
>> On Mon, 2023-06-12 at 10:13 -0400, Chuck Lever wrote:
>>> These are not strongly related to each other, but there was a whole
>>> collection such that I didn't feel like posting each individually.
>>>=20
>>> ---
>>>=20
>>> Chuck Lever (7):
>>>       SUNRPC: Move initialization of rq_stime
>>>       NFSD: Add an nfsd4_encode_nfstime4() helper
>>>       svcrdma: Convert "might sleep" comment into a code annotation
>>>       svcrdma: trace cc_release calls
>>>       svcrdma: Remove an unused argument from __svc_rdma_put_rw_ctxt()
>>>       SUNRPC: Fix comments for transport class registration
>>>       SUNRPC: Remove transport class dprintk call sites
>>>=20
>>>=20
>>>  fs/nfsd/nfs4xdr.c                     | 46 +++++++++++++++------------
>>>  include/trace/events/rpcrdma.h        |  8 +++++
>>>  net/sunrpc/svc_xprt.c                 | 18 ++++++++---
>>>  net/sunrpc/xprtrdma/svc_rdma_rw.c     | 14 ++++----
>>>  net/sunrpc/xprtrdma/svc_rdma_sendto.c |  2 ++
>>>  5 files changed, 58 insertions(+), 30 deletions(-)
>>>=20
>>> --
>>> Chuck Lever
>>>=20
>> This all looks good to me:
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20
> Ditto.
>=20
> Acked-by: Tom Talpey <tom@talpey.com>

Thanks, applied and pushed.

--
Chuck Lever


