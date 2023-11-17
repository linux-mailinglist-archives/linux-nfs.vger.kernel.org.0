Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029897EF475
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 15:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjKQO3x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 09:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKQO3w (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 09:29:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9BDC5;
        Fri, 17 Nov 2023 06:29:49 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHEDM9R006765;
        Fri, 17 Nov 2023 14:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/D4FCuZGAUWYy9hj8ON/qJnIEH2z3xO5P6OAF2SRdoA=;
 b=UfzY+Tkqe/GdInufnDcPwdzRe87fW8xkLcTGfbSsbk8vQ/dv4TDMrfyUa7JW01VkQyfi
 m5Vq9CvPw337bV+wRiruo/DSSWu6rYRFLXyYbgLk3eocSVk+8RozNGJmTN4emZXWT6Hs
 IQSHN/uMDPqmkoFPSegGDrc06PKWcL+EjZ5hWAHWDhwY8p5LMhjdLF/fMrnnulp0fFNp
 TrKWxPlwSSHDaOwWNC2Spp1rujA0a30UVIIIyDyQz5E2jHFFoaE56MCe118EMO5z2cm6
 CLIlWqQLdTcgHSd/Zq/YLGMFVFtu4lvcEEN8Vdf/41IxwlADx6qm00+oufFQd6zG201z 8A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2mdwq94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 14:29:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHDYNd7036324;
        Fri, 17 Nov 2023 14:29:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxh6m9j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 14:29:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0o5qDEz1xojzztMcQI/Xnus5oltzBcB0JFQGKSdzme+sumrbfYwAnXYqx4KIxrc1VzaMS+U3UdxiXHaDQ99L22js7qfIV7yMoheTT6ya8pOD8ViVz0vN1PO2xtQYZShW2gNw9ruuOPiTer/EfoufMEt1dPagLcSKmJ4uJFCyxrrHPhKySqWo6hI+qWcl4TqRRimM0alJF3TL6r8I+C5ZLquahaF9P/wxNwjeOUTgluYmON4QebED+6ycqWW47s7r5gkPTlJD2BUECr19KsRfYObOT4eOj0vu5uZHT6bAFQYixanZH6zyISc+Mp7pDJFKfgW8EUTldrv3zF3Ak08PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/D4FCuZGAUWYy9hj8ON/qJnIEH2z3xO5P6OAF2SRdoA=;
 b=U/0eiASWMPZTXA48Bm8tZwoDkppNqAGrhH2f3q4NB2P/vHEoHYlqq4DvBtNoT40qC8tBg9V/a3KIxXSgwdtUMI6h8VeJHaNj9ICI6e4HK8PV7gVAb41D9OXYIJRgP1s5gekUuVfOZxBs6FfHjS5slHLYhag4lWx5cNQLSqk7wyeuf0/CeVPwOMdTASY4sqibLpl0kXYlpK0UW5SESFutzmujgPsBtObR5RQvNi8fdHNnGUNgKVkEAHLPBC1fY+2at2sVWitLanIDPv0pLQy57PDuX5oBVnD8ixD66ES0EV0vScobxWZje/NYZVSvkSDgVOWsFNILXT1wbUreZ/vWNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/D4FCuZGAUWYy9hj8ON/qJnIEH2z3xO5P6OAF2SRdoA=;
 b=dUDetm1pKL0mSjTHxRlpjygoSatXfF5DV5lWjsxYGzuHwOq4QRiSrurNhJ+wdCaiV6YnM4bxEkjpFNngroT4aVBIQtaaPCdwQkp1yWscfGL/I+udB4FhP8WOzJTR3lnoP1e4iy6f2wCa2PsCuXJXTEoAavxzPJq2Gd+P2r/A/6w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Fri, 17 Nov
 2023 14:29:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 14:29:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL]: first set of fixes for nfsd-6.7
Thread-Topic: [GIT PULL]: first set of fixes for nfsd-6.7
Thread-Index: AQHaGWJ8DGcKrOzZsE2x9qFyX/QJYA==
Date:   Fri, 17 Nov 2023 14:29:34 +0000
Message-ID: <BE7C5C79-819A-4971-87C5-DB6CCFBFD1FE@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4544:EE_
x-ms-office365-filtering-correlation-id: 72b44854-697a-4634-eb9f-08dbe7799eb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UTrzB5ORBzB120R4jsLaSInBYO+ENUwNsPduvGT1xPoW8onrJmeLYQ5Ew+6fy7CfHUwW/A/PocWQZ2UR6KnybasoBxNrvjO5I952PS1W70vyizR8AE3sTKarPK9QMHzvxSe6WpOk0e7pspjO5AChTHaSLdk9wF40OGzuiZiYuUYT3Y9d433eCatsma+YjqIVrc5szviqc9mrKcXMpmYjUYdld5qfiJlKgh9DqIWRT3ZEfyaIlFlWl4ZdcFHhzVEx0w8v6RUoGOFQ3Q3MmpTx7QZWBDKyenew7gvkPGhXs6zpyeeoB0D7TLxTfwCMFxzbk0vTVU/vrYdeZPql3auVUqGm7gQk3j4RIYRpXf++ntp1j9Hf9dxUS5c4Bykav5foHlFH/gLoft5s7VFfHAEL5LzIkUTHGtczhlBotQjgJsAg1yozsM4tYAuUB5xwCAus4CnO0CHXU5rOIf1/zdo3dd8c2zFd4Eo8EdIJBoQyX8MJuYc8KO6/ES3G+CdXBt+MemWd5mGYycEVxS5j5sfX0ajJdaTnS7CXx9Cde85qmFMI49pEyEjvQSKRTRDTUSScvAUImCvJYiABp070lUUxKuWDG9rO/rsj/8GG+xNw892Pze95lL305Ux5snQ619wntVEWFYVbZo3ETXET24qhKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(38070700009)(64756008)(86362001)(966005)(316002)(66556008)(66946007)(6916009)(66476007)(36756003)(54906003)(76116006)(91956017)(66446008)(33656002)(71200400001)(8936002)(83380400001)(8676002)(4326008)(26005)(2906002)(4001150100001)(41300700001)(6512007)(2616005)(6506007)(5660300002)(6486002)(38100700002)(122000001)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0iQnIwnNf8XIrEedP1nZyOBhJ1m02mqZMVwXm2u23LnRwG1jR6ctJjr6sHG9?=
 =?us-ascii?Q?lR03zOkYzCZi3AL8/g3ERkO/Gmd8zlUoTknqlt0db7ChgjTgnSrdmkbtaHF7?=
 =?us-ascii?Q?iXANuC7j4GmQbWPLD2QoyZ5hC5MUeb5KwNBWkwUDtOV06CbPBVnn1mWG8oZc?=
 =?us-ascii?Q?QIxeMrJpxHx2UAceIfWW9tt3dugeKgq0MFiSh6jYChxlQHuRzI5hYoQ9Yo0x?=
 =?us-ascii?Q?4VP5sLlXw1GSWA9kGZidoe31b7xmK+9YX+wwN2JyGP5NWTAv+LgIBMInipPq?=
 =?us-ascii?Q?ySqFb3HQrB5BoA9aT+0ifXBPEgHWcGizIFyDtO0B1ml3MR975NHplDH4r6m9?=
 =?us-ascii?Q?QFqNWkaHH0+pz5GxMLM4ZzqAg5DqKe/wVIEhMEiBae1Y+BtJLDQkuNvn9vvH?=
 =?us-ascii?Q?c48+h+ZVAQ4MJVfOSrAUKZ+Gka3V7Vib8ckDf88I0yxwweQ1Z8AC6kmsLmc9?=
 =?us-ascii?Q?XY5Mbt8a+xuUHXyF+MCwKAVc+rtSl0ajk9hqj3ddTVG5ecLTlNrBZoB0s8+7?=
 =?us-ascii?Q?7YwJjN0cllY2AFS9B1suKptZhb4fV9inwbJm7ln+wIPe3qm5pJeGLcM2nvuy?=
 =?us-ascii?Q?QlxalMSMWRNIG2Xw/8Hwla5BoYIILBWHtXUdvkACiwE6164OL0BMfvBMNABY?=
 =?us-ascii?Q?Rjgv8aORNFixiLvexAboxWzPj9RmTeq9P49rsVLDiFepsYbgJR8KoAtpstRp?=
 =?us-ascii?Q?cMqBwpwE7MCcBzJvRdwaEyDkThU1foAXGJ89iGsiAg5XWN7HRAJAy41Q5m5L?=
 =?us-ascii?Q?nHs0sqMLRM32W7MBU35/w0Pj1FHtl5EJ4c3dds6+p/bzOCXHyFCSUZ+sM2Jv?=
 =?us-ascii?Q?3KLWRI/J+8HPvT4VTOnkEA05IiSpOvCAv+nCH+cEp8MoQQdiLG4tB6u9zaCO?=
 =?us-ascii?Q?a9GJDB9VTna+j3aBLqeTEyn7Os9X+TrK15k/BsDbBpGU3HhbZ9g7PJJfiacp?=
 =?us-ascii?Q?zAHdJN4zDDbwzuxETh41rN1tmMMDjZQKvtjX6XNaDvQ3/lmozLvUVoF3AoIt?=
 =?us-ascii?Q?njLLz5ppGwAY6nBWEGp9vEbDllDsfNhqcpdqXmGKq2hdDdjzifv7gR+khBiN?=
 =?us-ascii?Q?tF+zP8Fk1RWPY8EHYA+vg2wnuTSxjOkhQ188iJz5Mms+tRpev+waqHyYxADE?=
 =?us-ascii?Q?9RLfigR0CJkWHKOHkWn8KfcQOuODSUD/UBE2lSsgXXdh/J8JR1OCWrRuJOzx?=
 =?us-ascii?Q?J3OVo2f1lKGEwYJ5YhHaRDbfBSiI269rLRV+Uavz8HYoNmucB9p+mGmqzHp/?=
 =?us-ascii?Q?6UqgeByO/MQVoPfjMSiwZMAfk01pIcBYujHh+0oY7/Mg132PjSEEXekl+RcA?=
 =?us-ascii?Q?ucxlUNV/PCdNBak8/Vqxo2K1FZmnbQ6R50TYy9zhQ+6ULBKhZx0MPAenDmNB?=
 =?us-ascii?Q?6VQlMv9+PW/ImXSJIs0NPwKN27jae3WQIQjiEPG0w6SebP+03dfdMW+Wbhn8?=
 =?us-ascii?Q?+4G9f1yGmnS8GTOB6DtHf2vb0NnkgDw29vOzUnR5SPbFZFGSONJV2nWc3GCx?=
 =?us-ascii?Q?00U1qvxign5nOsnFArvcgqRSa9SSRTjQRWhfyhwO/AO5BVdB5PjnMqD62EDR?=
 =?us-ascii?Q?oHhBwxssfa2qMKdpOsEWAHr91OuATNgkNM3G1QwBmtjXHcYP/ERdIkOwTr9p?=
 =?us-ascii?Q?eA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <40C2E85432F19541BF2256431A0DE3AF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qHGgOyyvjlKsoq6MxC9T69j21gODeZraKLZYRnMI4CSU7h9UwOQGMB7JCju7AaJyVyWljTq6PQzBnaJm9rjPjj8EA7jbG5oKIFH18TZlfNg7xtItpW2RvCuTPumvl3Oq2N8gMgL7UDDFc/wqI4qGt0S4dtMx1dIAPcAtB3oYT94iudzlV9tFMkb1KBw4KkUV63kr3Gd811mEytvnd2n/9v5RnZLepN8uhLLuh6SS5WCGwnoKgjmML34zk0qX1GULLMgHuOPY8V2vH4jsCKJJ298f6VkzJfOf4fW6Us+c9vnCYZmesBQhcy9mltVGeXqxbHFJmxJ6vkdoH7hPP3thgi/jm6KY+sIWKT3S15Juz2TArrnGKN8rffXuenIQ0V2mCBNTgS63d+9H+BooV1lLtzLaB4gCgiXe+aQq0HBOfUWqd+EcF8rbl8g1NyS6r2fU1o5CsubWkZJDPGmrCyvwGOFcJfonxGum7t/s0et/i2vU0woLk2PiK7+T0cz30j0kP4ymN3GsmHJJgRnIBC7piKoVexRaBO7jf7vuiTWJyHhjwQzBbWsyO6eV0nSFkjdVWWmMelfETtiv6M71RA7ewKOjZYDfBHRmZnKkWXZ4E6BN/9/ppIzFB0UQkjdS6ZC23LZn1Y8kv8kMq66D8pSTD9SHlbJNtNQ1vQ0O3+FkUG+bDFfHKI37KxZcDGL2AnVZh+8TpwpK0hSUTdcheivscTx5huGjPofG9/NDioLya/BDc8RLs9W8j2mlzt7KOnXup22n/Nf/XR/XyiQ6wP6B1SFRK5KkTRuKpZ/LylQYaNAcGP4DUv0MEiqpCn+soFsGhouRAS+UlwfgVJ5ntK8JbEd7vyiX1Fx0us+NDZSM44E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b44854-697a-4634-eb9f-08dbe7799eb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 14:29:34.2339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QbAKH4l9zgE9Gx1VH10+Ft6fZMdhwCc3oPtJAqSwU5RQRujmGvaFWOecmXvr+6YStsyABnhXByBPSrnMJyfTTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_13,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=783 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170108
X-Proofpoint-GUID: OieJv1xmXWFwlayKuyZekelDH4eCHeUU
X-Proofpoint-ORIG-GUID: OieJv1xmXWFwlayKuyZekelDH4eCHeUU
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

The following changes since commit 3fd2ca5be07f6a43211591a45b43df9e7b6eba00=
:

  svcrdma: Fix tracepoint printk format (2023-10-16 12:44:40 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.7-1

for you to fetch changes up to 264e064fa28c3a9ca56b008bf2a66e93c2a62448:

  NFSD: Fix checksum mismatches in the duplicate reply cache (2023-11-11 14=
:22:27 -0500)

----------------------------------------------------------------
nfsd-6.7 fixes:
- Fix several long-standing bugs in the duplicate reply cache
- Fix a memory leak

----------------------------------------------------------------
Chuck Lever (3):
      NFSD: Update nfsd_cache_append() to use xdr_stream
      NFSD: Fix "start of NFS reply" pointer passed to nfsd_cache_update()
      NFSD: Fix checksum mismatches in the duplicate reply cache

Mahmoud Adam (1):
      nfsd: fix file memleak on client_opens_release

 fs/nfsd/cache.h     |  4 ++--
 fs/nfsd/nfs4state.c |  2 +-
 fs/nfsd/nfscache.c  | 85 +++++++++++++++++++++++++++++++++++++++++++++++++=
+-----------------------------------
 fs/nfsd/nfssvc.c    | 14 ++++++++++++--
 4 files changed, 65 insertions(+), 40 deletions(-)

--
Chuck Lever


