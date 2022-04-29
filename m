Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A570514E83
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 16:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378046AbiD2O7b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Apr 2022 10:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378066AbiD2O7H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Apr 2022 10:59:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0616C8A30B
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 07:55:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TDlHBm025790
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 14:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WWcE5mDseC/Z8dY61WuUDaaER8BWh4Wgd3WmEha1rF4=;
 b=GerQHLRK4gkvbg5aNq++UcVCtMHESoWds4/ME+wsDFhKDO2eWti5yqn24sqTuNUa66eH
 94QrOh6dVE0Jxi1/SBbBSNVil10bj1lnXUT+Tv7ajj1L78l8duQ1AbCJyWXXKKdX2D5d
 lfw2gwNLTru7DDSmAeUL5hioNvlcgdz+1mW4cqbqDVOkwjI/kBEYnna6yUuHVyfstLU4
 aoHYLmZAF/2u0m15xowKSiVP2IEz9tlGsc4Y39pMpw7D8ptR3jFEsiNTCA7+xIL3W8eL
 PMn2Km69hdAcRj5QTdf8h2iYcvBYl49lVuZ/oGcUNgY+j+aBLNerAuCY17CcrmETBc0n NQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1my451-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 14:55:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23TEpFWb021241
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 14:55:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w85844-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 14:55:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGHdMiIUTst6/yv7pXzMD6++cYAqfr/7dtEo90f00oWDeWNZhEKSU4vl8qI6iyvUqvYrJ808OZoFGw2PEUh9pPNsCDFRr7RIjShtkY8fe9DH43atnQy5ahn4cUl8Vrs4DPPyzRJImVRVxdgz/saiSfjxFTufnEPsGFvVhkyDoNKBJJNRObSmooOfkLDQj7PImmbbvSf2bVNJHLJiYN9nkcZZd6ayyLWpKUvJPfozQAQ8lHoVxecPX70KRoilFMKLa/JbUo3mrcwH8MYQT+dD0N3Y/AUTfCnU4FDMKlSLqn4GujXooGtjCCzs/EkDxSpWioFcAAkT0AJU/QpjHck5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWcE5mDseC/Z8dY61WuUDaaER8BWh4Wgd3WmEha1rF4=;
 b=oO8obEriwvZ58UCKBc95BcXqxficBf3YJbS1fArowWbL1hioVd+DpBQcwShZtp5R/yOxet/MB6fv5g4N6js/hZCUePZhosqEKtvfiKa9YXL8Z+jW6NH/PgsfatNT216QsmMe9FX7G04QzJa84WZZXI6K6DjfKGjSVE1rvdZoG3TqJDcSqbc3MXNAw/QPMxw5iyMEPrTalBBQIBN34wo1xRR9SfQoNwNoD4bOEQH8SL473/k0JsC/D69YW843AF2OBzXdudCRe4eeSlNwEFOysljEN2fRXQtOQeC8kJY/rfBQjgywofFiNw++bvNiDX3o69SIwLxIUNjG4pGXzR60GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWcE5mDseC/Z8dY61WuUDaaER8BWh4Wgd3WmEha1rF4=;
 b=NEv6KY446JVHlwEQvJna/c0rFOhr23uCMPFMJkXWVziG+kydRQgpCEo/lzzKA36JuaaYuTKLDfJ/2wJJn2D0HX0HPh7gBLalqR+0rUocUzZmvhcAOQtRACTBPJvUyCDcEy6AnZFPv0jG/is92khzY0nelyo2Cu2Ncb6+7qtaXA0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY4PR10MB1832.namprd10.prod.outlook.com (2603:10b6:903:123::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Fri, 29 Apr
 2022 14:55:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 14:55:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/6] Minor NFSD fixes and clean-ups for 5.19
Thread-Topic: [PATCH 0/6] Minor NFSD fixes and clean-ups for 5.19
Thread-Index: AQHYW9juTZ29QDTEgEe/mhN/xVjtX60G+rAA
Date:   Fri, 29 Apr 2022 14:55:41 +0000
Message-ID: <45545156-4667-422D-84D7-9B9356F557E8@oracle.com>
References: <165124376329.1060.17013198516228928515.stgit@bazille.1015granger.net>
In-Reply-To: <165124376329.1060.17013198516228928515.stgit@bazille.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6d87e5d-89e4-4bd8-e174-08da29f054b6
x-ms-traffictypediagnostic: CY4PR10MB1832:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1832D8085FFA4ED314EF6ECA93FC9@CY4PR10MB1832.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gLxjiYvAx/fXtAgJJH351hbZZmyfewujBXY16XEcFtsnJ1dIM0gpVnztSw+OqX6OOcZ8pUtzlG3t+DaMs+Z1I1iCmVWySyIaGQPI7U7VTQ1/hg3K1X38DsmbSg7yzeOQnxFCjlR48B+m66mYiF4N+5c0Jb5fSHQkIthe/7+tIi/OcyMTaVerfP0zk+bZw8+XcodBrESalrjtZsxv0wvxXT/0jpXsE1jrA01ii+OLTHbbhOHKokAQryr/iLUup1S6DIUHkGL9FlvZQLKvXuGEynrWzbzwpoHUf+l+S3DRh0mkHCZtcU0ZuI0kaw1BN2Mj76HDjGFhxZ+Je+/EZeXxyJHhPH1tDnewAlgOCOg4S4dNgmcD5HtvmDcgYrQAHhRhN2Wj7FHB9GaTjzjnD8ZTBTiZTbWdHZrduod2IdU5GeFUZhDSWZB4KgWSiVcoGUvq9h446k4/rW6ttoWWSBfFxfGY/BH2CBhCG+QBOZsPDtd9csj59oBjlw7C/b1tpH8tcSqSeCVmruo0jDlBvYMOUR2WuUoZEBgykv8lKzvc04o6yxAomLevJi9EMAob68+OIthKZpNopeALREXntwapUh42nmxOhkwrBf2Cu0x1KD2A7bIoyXSSvPX1/aA5vyCMikS8LBMAYtpADajHdRFZV/LPC4muXT+9UlLrr5VBXqKThPIGHlyMYmqsASPYX/fBoOqczU7JwQrVCp+za1bPSGsbv7msqDhMC6x6VNqFmK/6ECxOd9dvhCnAoVnai8GVrJkid+Usic4Ainmj4oY0zWYzys0FhKuhULY/lkg6Mjh99BEsUUxFYbHR5WIUZEsr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(91956017)(186003)(316002)(36756003)(66556008)(64756008)(66946007)(2616005)(66446008)(66476007)(8676002)(8936002)(5660300002)(26005)(6512007)(6916009)(966005)(76116006)(6486002)(83380400001)(33656002)(53546011)(71200400001)(508600001)(6506007)(38070700005)(38100700002)(122000001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tXARZtFik0mI7PLH/Vxg3vzVKZIME9yErDmg9b2uNiwuwUFezrbaaLQ4AA0i?=
 =?us-ascii?Q?lyivfRJktZSPw2b0P3qvFS0xThVNDO+ogyK9jPWGxMq4Pnun6RyWr9LPCTri?=
 =?us-ascii?Q?Mn7OB7ldrn7eQL4szgQSUUhelg6WO/HzXteiRCRoSzU1cgIJW0FoUbMHQIyW?=
 =?us-ascii?Q?luVjmsarBu+CTKGrwb1tAUjoedonWieNBJPnYSFvA3ghSrMLUG4F2/+K/uT9?=
 =?us-ascii?Q?xeM9KIkbuTpiTTRYbMr+N4dkfeE1sTObefecRXSw4LzPjG0n+sCQ0h5iKYk9?=
 =?us-ascii?Q?Ow0aqQSsqBkNJDXuwse6L6zciiobk0GuaTFb4Ui8G5kmR3m1tRMlP1gLIzLI?=
 =?us-ascii?Q?b6bEuCaxaf9OBjxgy6Af/R7b83pW42s+5TxQWnoHtP4pn+Q5fYJore3QBeRt?=
 =?us-ascii?Q?RoAp3x1Gy0hgYWG+rKO2uPK+i4NNQaqJpO4EepgBQtecKcxOWf+IlR+4QAk3?=
 =?us-ascii?Q?Bi/5xuL51HWarHo3IFcmhIfL6XwhCqlfDaV2lBzrk8jcurlJcxVZ6GsRcLJo?=
 =?us-ascii?Q?gchcnX5NXyQhB/8wEyFuNmgXh5eF3CQ/7LRrR/jDV6okI8iUQLPnz4ymWlPF?=
 =?us-ascii?Q?T46QArsMLh7XPj5l1Olhi7jvawsvTcyb0AvOdtE8o0JXXqBDFMhOxW4176aO?=
 =?us-ascii?Q?ZR8GW8yAipkaiPgI/PvRyKND9/ya9pugSnuWwCsB0KnLKaf03zLvVJ3trv8i?=
 =?us-ascii?Q?O81iCch0iQ17DmUubBO3Dc/pEjuFOAtNqMIpEj2k3Xgt1M/lEtuEti3r4NHx?=
 =?us-ascii?Q?O/sNOAyb4hkexzY5O3Sq2knPUZyNyr8/PPToBXyc1g41NYuq/D0yPEgOfvqf?=
 =?us-ascii?Q?jLUC5cioz7eDeMsbFRd9AKbx5HzVciIuIRyTn2yRjWovYsDPsi3eAxcywwM/?=
 =?us-ascii?Q?r9h6KGzTd8t8X0SNqKLjyTnm1hAY5NjcD76AQuK+hf7PykRELJ8j1Efu9/a8?=
 =?us-ascii?Q?anAqrOdgExcExaYATbw/IKHZGNZ15llDzz54fda9nT6CoghII4Z0zpCg4lbI?=
 =?us-ascii?Q?Q+ZJsMjV57k/mNMSN51DkO77imHWomtHFLqsyQJoFXcgrqPZSyahbRDTYIJV?=
 =?us-ascii?Q?o7cHmHrB5Vsr3QAEq8ljKk/2BynQ6egnpMZd+78DKufkuR+mV3FuYd/0+szm?=
 =?us-ascii?Q?YiPYUkWj8kgmX/ZRq7nezI1nJcX/ncRIk7/UPegvnB9A9COy/HmtIIOqOL0T?=
 =?us-ascii?Q?s3y+AYXta/IVPQxRbGQm04OXt0rrr2oPAoSXwLRyYUInJJA7OFYlPzxCjkuO?=
 =?us-ascii?Q?fPHNhGhJvhfByBHNHEDzQ3pLA4/W6dYoTUS7SWJPndWOJknFTZMOpY+ZtR7l?=
 =?us-ascii?Q?6MfPHaoDKQD+t62fWq5ZNCzETASv3V9XLWg+tNbLqNi16ANEg4890C/tvbEJ?=
 =?us-ascii?Q?vIeuaREoQs1g69BFtCU0VvCUo5kElZr3a2QdSIvbe+nh+v3bdwOg7Y6H3SmL?=
 =?us-ascii?Q?T8qxhgQiwGHfC+vp2O7k26rDpzxeIZSSp0hiPufVaEZZ5/HooDvjPeC+SQg4?=
 =?us-ascii?Q?+Ed0SMlFxenOfBhHFtkBcpFVW4qXkGaNz5UxBkPpoKyXEgH3KaY/sJ3iWlds?=
 =?us-ascii?Q?EEtnzUgg999ejydyrVpGGKUzCBXBMhVVepre3vbDb+tI9uf3JRgFm+NWn+Os?=
 =?us-ascii?Q?JkgO61lCbVEUP/09qa6ubKBZHbrwwpBs/nrgDK2nAkZkwBtZYEKI1K4YG8QN?=
 =?us-ascii?Q?m6Q38g/ps1s3jggCNG6ri7dsQ+hkxvwmoUrscw6qkhs0JdaNDV9hwYw0Hmx4?=
 =?us-ascii?Q?u/WpFgZoN9EJdYyJo0sq8KjIhCWJsB4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A8E59CD276EE9546BA98AC283FDC5988@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d87e5d-89e4-4bd8-e174-08da29f054b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 14:55:41.6338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7P40O9QmTya6lncTCsW+Jn2dsq5+E09upo4l6yOoq1AB/1pW6+oQsfPoC/bzHIQK/EHapST7U2gG8aBbO6/fzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1832
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-29_05:2022-04-28,2022-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290082
X-Proofpoint-GUID: _m3bKLiC6m0Yiq_6fuoaUG7aMjRdHNKo
X-Proofpoint-ORIG-GUID: _m3bKLiC6m0Yiq_6fuoaUG7aMjRdHNKo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 29, 2022, at 10:53 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
> I've gotten confirmation that the NFSv3 OPEN(CREATE) fixes posted
> previously:

Argh. "NFSv4 OPEN(CREATE)".


> https://lore.kernel.org/linux-nfs/20220420192418.GB27805@fieldses.org/T/#=
t
>=20
> are effective and so far, have not resulted in any regression. I've
> pushed these to my for-next branch.
>=20
> On top of these I have collected a few related clean-ups and fixes
> that were found along the way, posted here for review.
>=20
> ---
>=20
> Chuck Lever (6):
>      NFSD: Remove dprintk call sites from tail of nfsd4_open()
>      NFSD: Fix whitespace
>      NFSD: Move documenting comment for nfsd4_process_open2()
>      NFSD: Trace filecache opens
>      NFSD: Clean up the show_nf_flags() macro
>      SUNRPC: Use RMW bitops in single-threaded hot paths
>=20
>=20
> fs/nfsd/filecache.c                      |  5 +-
> fs/nfsd/nfs4proc.c                       | 67 +++++++++++-------------
> fs/nfsd/nfs4state.c                      | 12 +++++
> fs/nfsd/nfs4xdr.c                        |  2 +-
> fs/nfsd/trace.h                          | 34 +++++++++---
> net/sunrpc/auth_gss/svcauth_gss.c        |  4 +-
> net/sunrpc/svc.c                         |  6 +--
> net/sunrpc/svc_xprt.c                    |  2 +-
> net/sunrpc/svcsock.c                     |  8 +--
> net/sunrpc/xprtrdma/svc_rdma_transport.c |  2 +-
> 10 files changed, 85 insertions(+), 57 deletions(-)
>=20
> --
> Chuck Lever
>=20

--
Chuck Lever



