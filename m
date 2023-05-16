Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B66705977
	for <lists+linux-nfs@lfdr.de>; Tue, 16 May 2023 23:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjEPV2q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 May 2023 17:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEPV2p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 May 2023 17:28:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C503B7A8B
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 14:28:42 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GK02Oa032006;
        Tue, 16 May 2023 21:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=bNnOjla3z1tN0ZtS3uUmEA9UEkoSkN4LYHRZwKd8ooo=;
 b=iyIzOh2AW0efLrDJftKYSmGYkNbY9QHhWKECmUt1P0Lot4LzgPOYRrXpWaVOKcIFNxZw
 aaQXM0InkPTykNm60YGGmfn4JUsF6eYtKW0rio3Bq2QQOzg97Pthue6fVnThyCmE7da6
 /iyFqsNPXW/6olDc9W6dNmrmk7rT5JeZrjdBJ6CYsifM9FfkAFkvwh5clVimYH0YloPr
 8YuBWVvVvluiuY1DG5v9/4oGyIkV3KADOfq1D5qY6mq4CCuKCxmzn0+Mdi6Q3a88ehcW
 XNpwCNpRWUT9P7pYM7wVq+KF6DiOIgp3yHg7lzCy7zf8HBjtxWr9jtAhw5Nj9N74Xsya zg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2eb3ura-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 21:28:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GKcIxf023863;
        Tue, 16 May 2023 21:28:22 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10avxj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 21:28:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ia3WK5Te9Br2eLnKjypZnAiHszj8ewCd/kEGfhqfAnwoh+1WlhcNrmVK9SPZUr5D+Xj8iv8C/ntqDpAnHrIt4e4Pe9gk/vQkfXjBoE99Ikk1KPftPX4EVxHQAHvq0JC+/vldym9/XPcFvviRSE4EsdufXvJ2Jzh9iQE5DxuSy148KdkKBWhvruwpF+AE8lAdy66IIYY6Z3tccyp0GiviWQ5snfNgSIhe56XM7wWm/tqusGatztD0UDQ90wkvSLVhDm7fmMHhWsPWZIbPdp1QpUxemZkhHKab3icT9zyK/1uCk/Txe+Kyp5S6MdV3jb/bWofaNzdi7JsbUtU1B6IOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNnOjla3z1tN0ZtS3uUmEA9UEkoSkN4LYHRZwKd8ooo=;
 b=aw9nJoOnr1C8PI3+R1vu7U9O+m/6cfXQ3jlovqQVjRBeafp2VtKW95FiO5ZiB/BqyJ7VISdMPBIn1vBiUX7g4Fhivxd/eEntweVcETCZKZ86Su/pFSYvmQki4X6Z86jMnskZxXJlYFCmO+VlbKhdO0gsyKV9cG+/PbahCKMkZ/VzB5Qqhx8ousxNivzqs8bHrtLJiXUkiQVh+VeQg6QacSAcLRKC09QJH4u1GDONhHiM9AkggVDsI6oh8udkelyvCKrUaiq2DXLavQDinrFPhfpLzJqpCdE7Ck4YTTxMEhQ0D9/48cjuP4I6kankUQhy5IpUHyhXPZLIKW9DvTaPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNnOjla3z1tN0ZtS3uUmEA9UEkoSkN4LYHRZwKd8ooo=;
 b=eIqR1uOav/kee6yBFonQARvAz0ru/QuCbi/OAu8ZbO8NMuNh7V76IOOhdgGiQjJiSqpWXXlIBU5q0Ml/6zwmrGTe3Rk5hNOQ5zV/ME5m/JYc4w+OmN603yndEeMIzEfwh6XSlRfhNESy1ephrB+sUFD1vKTijQAYBiq6EkBUN0I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6269.namprd10.prod.outlook.com (2603:10b6:8:d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 21:27:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6387.034; Tue, 16 May 2023
 21:27:55 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Steve Dickson <SteveD@redhat.com>,
        Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        Alexander Ahring Oder Aring <aahringo@redhat.com>
Subject: Re: [PATCH v1 26/27] SUNRPC: Set rq_accept_statp inside ->accept
 methods
Thread-Topic: [PATCH v1 26/27] SUNRPC: Set rq_accept_statp inside ->accept
 methods
Thread-Index: AQHZI37QRUQ4TvDJik2GwoQT/5RlW69HhAGAgAA1uwCAFlcegIAAAJUAgAAhZ4CAAACugA==
Date:   Tue, 16 May 2023 21:27:55 +0000
Message-ID: <4C3DA96B-1FAA-4B80-A344-582BF213BCA8@oracle.com>
References: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
 <167319546521.7490.43383592461162363.stgit@bazille.1015granger.net>
 <3e34a2dc-7d72-b719-248f-e78361db8a5b@kernel.org>
 <4AB1ED03-57C8-42C1-9A04-6C224E98EDCC@oracle.com>
 <569be8e6eff7af373e6baaf2170edb8a8c52f262.camel@kernel.org>
 <0DEDF045-8C95-463D-B5E7-D2A3DF3230FC@oracle.com>
 <08b1fc12a271688c908ad615c08f910c3ec19672.camel@kernel.org>
In-Reply-To: <08b1fc12a271688c908ad615c08f910c3ec19672.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB6269:EE_
x-ms-office365-filtering-correlation-id: 43213559-7bef-4372-b4b2-08db565469e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NEmCMg1AQyBjkWRtVo6NHwYnd0rXUBPvPK0nuMMXyWld/tEELEJD9znfxcSQl0ZhU3MEvf1Xphq8O4FzyjyHKdFufEh8dQpFbsEIO7K9/azCAXpaqKU8Fqg/ARlg08UR9LwgZSz4YpbLe2D0NWYtmnhY/7UmM2d7pIxFgwOGFNK1xLBdJJjKzwRtjdB4s24ZuiVmIQxVHk74i0r+oF119oUHajCS6afQ0C0vH6sbybYtXvEf3BXUIiG80iVZgebO4Bqr9dSrNW0LxpohVhGLRKba05j0MEjdK2U6yrmDrK9Kt2SjQ48Xz6ZHX+Xim+nlKIid4CLLDpwisyKIhFxdyzR2EzRo8w+t3pZ3ww/G22+dC2vYRMoB7vp42vNrzvWYXOISUu0UA/py9CckTf+PfxtA8fS9YHGSJxw2L9GBGFh5EB+H5g8l8ax20gVXGa+65NMwIM0te0mGqifCUflRSbNKUq4vSEuHp8En8O9NGeG3rYh0IeDG4dzDk82U8FG6NLmGhAi5ZAfkmCq7HGXiA/eoCwSkbEbUQYGk5tPjIzjlY8qfsCR6yQhCQme/WueNlJmleENnVxp4jnabQdrq/Bd0FXdKJG9WO3mxoPBFIlrKcBbZda3HDafpECGuskedSsqrltAziBkfuiYGhEIJJvLnU17zSymhhxMafxS3fPsprvMv3jp/oO67rr7XP6J2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199021)(36756003)(33656002)(6486002)(86362001)(54906003)(316002)(91956017)(966005)(66556008)(66446008)(64756008)(6916009)(66476007)(76116006)(4326008)(66946007)(478600001)(5660300002)(8676002)(41300700001)(2906002)(71200400001)(8936002)(122000001)(38070700005)(38100700002)(2616005)(6506007)(186003)(26005)(6512007)(53546011)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P3v0X2oAyIQaCAtx8zmfoC85CIRarUXSPncQ0EM3eliRD9G9lHH/AmemA0mU?=
 =?us-ascii?Q?pal3roRd/8aa2gYxHz9tRvv7dOQa5K0hLGZkdyZgT38jo4PYV+pFtSAnsIm/?=
 =?us-ascii?Q?JcRObuJuy5EXcEOwKqwx11umWR+fAXbPOLj6/e4iNFPVypfCwo08BWwdJhaM?=
 =?us-ascii?Q?7dSgrmhyE98oKnIYEfIBWvR7pOTnT9tbz0RcDwOcinHJO7m6IjWNJl+5vhFf?=
 =?us-ascii?Q?fFU4Aa5Z5zSykqVwQRzofeA/f+lXPz0FpYavJO1dXqeCS4gqP8VLjqB2PJnR?=
 =?us-ascii?Q?Dhou0kxGNcrJ6AIunR3LwhKOwCKmshL3ApZoObR2MRfphj6CUry5ynnG2J1u?=
 =?us-ascii?Q?xjnXzYWTHjr1TwBD82QWILBuGCumneB7Pzn1Mny9jGo0MAEDyZqv6Jd/P/gU?=
 =?us-ascii?Q?6wpn1sHIcbAj5aXtYbK4+TnCbdUvZ9wXqLZA29BTnRT76l7GNygUO4CSPokY?=
 =?us-ascii?Q?B1txeUhuiAcueQbAGw2qAXKOJ4R59f5X7CV+0M/205UbC2Em9RXpOo2nh+c7?=
 =?us-ascii?Q?NyKrp+2LL0AKPCkKjLSyAWViC43ibf6whxe2J88xI3Su9/sHZb5TcfziPRm6?=
 =?us-ascii?Q?S/rLOFbDbsmO1xXgDmE5Yp2bEyN2njdSrknGcLol4rAYrUmjp+Mo+isB8H6C?=
 =?us-ascii?Q?UoxBp3PkS8fgfce835BMgpYTPc1rFutoIzAQysc1VaGTxI1Xi7BTDwLErQUa?=
 =?us-ascii?Q?5nGIFRSXkkJ9I2Fwy6yvMXUmN1VzuaTSH0pnXePfo7jiYLMY1tvcRT7GP0EF?=
 =?us-ascii?Q?qgXir/dm2A1L+KRxI2HhYgM8Nqi402CxqQDhRDBYY/LNRguPNVyKMt9B/q4C?=
 =?us-ascii?Q?USvXwQJosEjBIGvBe5n/5tLyvb7dmum94m/UmnhdpFwJ6h1YeSy/8PPMOG+B?=
 =?us-ascii?Q?G1wLodxaHi3EjHxgdIGfbqogb3geyJyymi0T+sKeSotaEsyiWBbk850qr6Ro?=
 =?us-ascii?Q?RhxtR6/CaER//Zrp+W5BPmJ5VfWI1jS0Avy8OwRrXdljpXm2cKnGI5M6nlRi?=
 =?us-ascii?Q?iAq3/xof9HPoyaJgx8oJB+Yw/z41qQBglkRk+Ov3+NvzZ4hA9zFvDliOJkJZ?=
 =?us-ascii?Q?ByB74z4nC+X+17eKbjVbNZrxb4Wmh/ikuWA0J9dE4Sku5129R+BuYP5eIkpc?=
 =?us-ascii?Q?po41uvoQ/rwlg8wxfx6ksbe+OKNqpvnH9QAwBlTbQ3mqJ+Mi9MYhOX4VBzkT?=
 =?us-ascii?Q?EWYEXRB9UzSsaXQDZ2GMrKDb/9crSfiDKu3xbP8LK9s7NMn6UR1Vh7/KUiJx?=
 =?us-ascii?Q?XP7p9DUjpJLehaSs606xNb5IV34PKLE87ShDxlviauBOf0I6PzSKKpxm7Yfg?=
 =?us-ascii?Q?KQK1eWbjrxNzYD+eBwKA373B/xvuQ4LMRgmTTsLWw3UOiDodKzVewPGsguuS?=
 =?us-ascii?Q?IVmlb3tYWAZWQI7PxxUbvO4GWfr/EP9ayYbJEXb0ErrL2deDiDK8reUSTOqz?=
 =?us-ascii?Q?qRnibxicbsMQXuFNwV9StXvwAEi/ONM2k78/X0Hw8qWP6ExDgOiGQ0sXuAbr?=
 =?us-ascii?Q?qu9tVkYm6jz41ZcNJY/mBpDg5EbPIY/eHCakBtlVUuGKhuGAkj8+XfmKrUlA?=
 =?us-ascii?Q?raolI8KVinylgCopZSuTaWYhVdZqOSHKDoI/I9wnw6QBAp0LHqzsRr4rqt+M?=
 =?us-ascii?Q?vQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <70EDABE91799EE43968F0B555FCD06D3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IKJgva2EYGgVJa+qS9N1HGMx16UFdtN6MN17ggH6bYlDYwfkz0Bd513RsgmQqK8IvvKKhjYzd33U71m/46SvyrawFB5HobAXfZEBkAVUlqg7LIZt7U3xvqnt6FkmYCiKeg2QC0T1LSFMxiub2oiGjCI2Pr22eBASaJ/jz4eB1RV06VgHnGafcw4gY9YwNWtkz2AFT0Rs+cXd5KRKSG+kr6Fi3LYM1+AaATbjoHZ3g0jf2HiBgyUQlaFsFiC5CSCiXqEG+VSNO1sp9VpkwGum2WRwv9UaGDEuPlwuoJLEHE+HrmEBAl0cukMRPezxGGoXEm5VSBMimfD5Vipewbte8KqS12QRcfDKcXAshoi7mpm5nzbjfSd1Ur9tOksFEFJeekp7DbcKFWMiR5L9YNvt3HNdMuM4UTXhFRuMTuWYQbDs98cvgPjv3DxXulWpnge7/0/2mdVb5RR6DTNVNri7yu0qKpZlSCByzyc1iuBv6CRbg4X2Z5YMQfS6/fgvOBSJZtPm35gcVIa1LiPiMzOtxKeyZF7v8I1BLaT2kQFV6hmVG6LcJFx7HExJng3HdCVKPWcO+7n6wraHsuGgboXfupkg37+xFXEqHiUjtxu+TnwEv94Bz65n/oPCOzVh/TTsrPOHfdGjSobbjlqNGz16/zQrpGbmDrXhTEy37KkdKi7lFVsYHmY1qAHHsRAcSVBUBTpLs1B2VCTmw9BQPGJjEJh3F1x8R8ekj/xAvDeCET3TCHrAWHjhl6Qg+cmoMvDYE84Y5QWXY0nfLsuuYtxdT+M5F4OnxWasPlB16kMciOU8VMvLYFi3J0aM8iuk0Cx0bliq9kLeFy57f9Vbo35+Ew==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43213559-7bef-4372-b4b2-08db565469e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 21:27:55.6888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lu8rStj1J1J7tzqJDwB0nTAaSEdjlIqyW4l4JveTxlOq9ezvfySuR3b7em9mugU+vEwY9LB8sBXO+T1h0+KObg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6269
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_12,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160182
X-Proofpoint-GUID: lkKtVBKwXyVSV5kVQRVhcp9nTCGo-1Ze
X-Proofpoint-ORIG-GUID: lkKtVBKwXyVSV5kVQRVhcp9nTCGo-1Ze
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 16, 2023, at 5:25 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Tue, 2023-05-16 at 19:25 +0000, Chuck Lever III wrote:
>>=20
>>> On May 16, 2023, at 3:23 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> On Tue, 2023-05-02 at 14:14 +0000, Chuck Lever III wrote:
>>>>=20
>>>>> On May 2, 2023, at 7:01 AM, Jiri Slaby <jirislaby@kernel.org> wrote:
>>>>>=20
>>>>> On 08. 01. 23, 17:31, Chuck Lever wrote:
>>>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>>> To navigate around the space that svcauth_gss_accept() reserves
>>>>>> for the RPC payload body length and sequence number fields,
>>>>>> svcauth_gss_release() does a little dance with the reply's
>>>>>> accept_stat, moving the accept_stat value in the response buffer
>>>>>> down by two words.
>>>>>> Instead, let's have the ->accept() methods each set the proper
>>>>>> final location of the accept_stat to avoid having to move
>>>>>> things.
>>>>>=20
>>>>> Hi,
>>>>>=20
>>>>> I bisected to this (4bcf0343e8)
>>>>=20
>>>> Assuming you did the bisect on the NFS server's kernel?
>>>>=20
>>>>=20
>>>>> as it breaks nfs3-only servers in 6.3. I.e. /etc/nfs.conf containing:
>>>>> [nfsd]
>>>>> vers4=3Dno
>>>>=20
>>>> Note: Changing the settings in /etc/nfs.conf had no effect
>>>> on my server, so I effected the change by stopping the
>>>> server and poking values into /proc/fs/nfsd/versions by
>>>> hand.
>>>>=20
>>>> Steve?
>>>>=20
>>>>=20
>>>>> The client sees:
>>>>> mount("10.0.2.15:/tmp", "/mnt", "nfs", 0, "vers=3D4.2,addr=3D10.0.2.1=
5,clientad"...) =3D -1 EIO (Input/output error)
>>>>> write(2, "mount.nfs: mount system call fai"..., 45
>>>>> mount.nfs: mount system call failed for /mnt
>>>>>=20
>>>>> And the kernel says:
>>>>> nfs4_discover_server_trunking unhandled error -5. Exiting with error =
EIO
>>>>>=20
>>>>> I reported in downstream as:
>>>>> https://bugzilla.suse.com/show_bug.cgi?id=3D1210995
>>>>>=20
>>>>> It cannot be reverted cleanly on the top of 6.3.
>>>>>=20
>>>>> Any ideas?
>>>>=20
>>>> I can reproduce a similar problem. Network capture shows
>>>> that the server is responding with NFS4ERR_NOENT to the
>>>> EXCHANGE_ID operation, and the client kernel log says:
>>>>=20
>>>>> nfs4_discover_server_trunking unhandled error -121. Exiting with erro=
r EIO
>>>>=20
>>>> That's not the failure mode I expected given the commit
>>>> you bisected to, so it might not be the same problem you've
>>>> hit. I'll troubleshoot this and send a fix for testing.
>>>>=20
>>>=20
>>> Alex hit this problem in testing too, and I took a quick look.
>>>=20
>>> In the attached capture, the client should have gotten back a
>>> RPC_PROG_MISMATCH error, but the server has recorded an extra successfu=
l
>>> accept state before encoding the RPC_PROG_MISMATCH error, leading to a
>>> malformed reply.
>>>=20
>>> I think that the problem is that encoding the accept status too early
>>> means that we can't properly handle failures from the pg_init_request
>>> call.
>>>=20
>>> Chuck, any thoughts on how you'd like to handle this?
>>=20
>> With this:
>>=20
>> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=
=3Dnfsd-fixes&id=3D29cd2927fb914cc53b5ba4f67d2b74695c994ba4
>>=20
>> I plan to send the fix to Linus tomorrow.
>>=20
>>=20
>=20
> Oh! I hadn't seen that cross the list. Did I miss it?

https://lore.kernel.org/linux-nfs/8cd5d041-77c3-51dd-a960-7fd8ce1d1271@kern=
el.org/T/#t


--
Chuck Lever


