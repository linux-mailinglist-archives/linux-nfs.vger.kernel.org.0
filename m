Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07984568F2F
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 18:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiGFQ3y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 12:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiGFQ3x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 12:29:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1995022BCB
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 09:29:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266GPZbi010478;
        Wed, 6 Jul 2022 16:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UHniZhexwnMSOdaDV9dfZXV3/1a/1//+Oawjd7FH5wc=;
 b=tebAMwB6pDE90arFh4GzG0OtgSiCbmgyojr1sXZu8fnNS+ASrOHgIqchPxfmgJWKC0yK
 P6uwah9/ArTG53p5tZancjvbJgO7lXa5D48jBGfc3gwoGwf4Gz5NfYueVyGRKcGhgXdz
 DAr+LsP+t7rk2KNTzTHn8oL0R7sMKLCfVliOMtHZx0vintMY/A0JHTJWTQp2LSIDZonf
 BJQAJJuYb9vT5Acth+PDHU38vLt/TPvDptZ/RRkdrGcFJXrLwKQRdF/hovcJn6PyKbxm
 xvRF74B3qskGHWQqXzYQ0JCMi3oRTAf156iQiD45Shi5otSUMyhZ4D9RNItGSSWjyb/Z uA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyaftv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 16:29:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266GBHLV005494;
        Wed, 6 Jul 2022 16:29:44 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud50new-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 16:29:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4EF5ukoXnBnvtbjGMlW7UbwrdOCnCOqX1Gw26c5vb85eq3lE4bv9xZaOKyrGg+HMHTw7Rw7NjqwOz1QPb9nk/MypoxZkGqTGLjhSb6R5L1Q/RefHkLkiS5H8WvYMg7rPVIhg9+EPHNUmdBK4i0sZnOJZNEtr+EhyFFARsP4KLlj201aRAhjI8q3PSpZ0HutZf/sAS3Yf+GD+dZEd2Nzci4G+kV9RgxW74Q25IAJxePCbWoWqOUbF9HiWc6bmNbvYKg3nUiOZJyfqF958pdEW6YYd/AqxirONE5pDWahwzsmDASDUblHXxyTsXxWwkqRRKTUcIYrANr9yOfOUi/F/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHniZhexwnMSOdaDV9dfZXV3/1a/1//+Oawjd7FH5wc=;
 b=VeEMHBHHgv41beyUFFmrF5DiuD/igWcIU/n09c4vldE2s8lfd4QBnTb4XC6VigrOb+vlqIyoeHz1X0Z4tErT8PZweY7C/PvKtFX24/kGZcA4Z7wbfY90NrAdaG03YO+iXeiWabnGnCUhZeAQ4OUbrOfWfunCVCOgz39bja+IIoWEJVvoCVT34QQcGYWwVo48ZP2rjHR8QY6bXoGojJM/LVV8UYN0G+tjTd+M26rUrjpcdZhMO7CG3F9bA/PNpqmZyPwzEx8ewgta3ls28v/SYnCWqMkY6AWiOYB6tqugPwzhLYDxy4d0s0kk5R9MQGfVV2kbliSr5IzEDq7oTw4q+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHniZhexwnMSOdaDV9dfZXV3/1a/1//+Oawjd7FH5wc=;
 b=DkblzTvi3kUNT4nq33c90NxsMeihcamzG0eqBJVElPF91G/HigMZTucpikK7U/2ES2440URYwF4JqOJmonuz4aqQRnHvsY/FroQI1T21BVLvVUX+z6j7Vm8bzoMJwmXyK2tlo4BR08l1DCUXLufgN+b6twCqPbuL/Kw0370al6k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM8PR10MB5478.namprd10.prod.outlook.com (2603:10b6:8:33::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.15; Wed, 6 Jul 2022 16:29:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 16:29:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5/8] NFSD: reduce locking in nfsd_lookup()
Thread-Topic: [PATCH 5/8] NFSD: reduce locking in nfsd_lookup()
Thread-Index: AQHYkO/J35OJsRzt5UWWsoM3tn/dgq1xiU+A
Date:   Wed, 6 Jul 2022 16:29:42 +0000
Message-ID: <0A6DEF8A-232B-45FE-8A45-C403DE4E4342@oracle.com>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>
 <165708109258.1940.1095066282860556838.stgit@noble.brown>
In-Reply-To: <165708109258.1940.1095066282860556838.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 337f16a7-9ed6-41eb-a57c-08da5f6cbad3
x-ms-traffictypediagnostic: DM8PR10MB5478:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SJEgF8KQfMKxs4DoHfh+emp8P/zuO6qPI+Znf8qTGeHO3j2+kzokcjxmVZqkMK5c5BG6bXST7mp3pKFuyJRX60e8pezcpE2QYCmVoN/d7stOQKxAUXHwcRE2DHwzBkyafqwYz6BlxtI6xKgE8g6lwxTL97wBe7GdhjrEyAK9VaQkQ0nGLI+aIsB7k3Kk852vMY8GZB3msD5Heb50R+hqUznHDfNyuOU5cCOCd5X92Rq1U5dotaSBTFHZsD5q+/ovJLRoNbYF1O+TDkpMAZBZfqQC+SEztiMq7S14n6EPHstlqg23CAeiumwpel1QLI4u/zOUwbWov4eus1/kk2No3cPOBAbJSVGElGsjspBNkB26E7w3QhxcG3qlZl58Hqq55lcXhaSZ1Ykl1QBLbwOAAYzleKydgyAOa9ZXko8K/juXbJ4hvr1AdIvC+OJsdAWgm0FoZr4nb5kcO7KWrzGN8aeuPWPpt842aXmxFU+p6lZSUwOh3ZRi2Y++6TNfssDtrU4FtjGKj7RkL3V+dZT70N7CcZ6Iz4YMiLB3x67pBEs+zACVQOqpejsaMWXPb1e0XN9dCzAvI5gjlIh2OFby+nXtaWQFHVdLivLOpg6lc69tIq/qgm/lQ9Lzkpb66tOTruRoirXBwWUMchkxjO5bMaIpivn/BCJYFj10DQXzaZGHakIlonRxJJiEEvVvc22giePuH7KU7UhrE/humIYpe4frLqTgeKwQJZMt1Y70v+YkyN0wNE5sJrMxKFwFTKxQeyNjC3TM9ASAzp4N5IAk5R6cb7yxYJDEHpgB15GRiPL6NPpJqdwm0EIYiJUl4gtUv6nRzUb8SNTusHNvQeTOscS/UV9Axaa095vs0pJI61o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(396003)(136003)(346002)(6916009)(54906003)(38070700005)(122000001)(316002)(86362001)(8936002)(30864003)(5660300002)(64756008)(83380400001)(4326008)(8676002)(66556008)(66946007)(76116006)(91956017)(26005)(6512007)(36756003)(2616005)(66446008)(6486002)(38100700002)(478600001)(2906002)(71200400001)(53546011)(41300700001)(33656002)(66476007)(6506007)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+A5KClI2iItBMEyYvIOUp6JvAAmg1dpRLsBGGsfQcaU50ebUu4UZqLZBXIAc?=
 =?us-ascii?Q?AiESNbsE9VIAe8UvT0PTRK9kHfy2Ombk8rxlu5nWnrsRYalujgeTXMZ7XZcd?=
 =?us-ascii?Q?I98bTAwVm/TGS/RxTJERU8ripKchZRN5NF0FcYIw4iPcMqby8oAEPSP13l/4?=
 =?us-ascii?Q?CV5u66QdsNwK30TN92z3k2IYjtx0sM8Fzu/b+B7Ln8DA6QkPkFsbhLU4b7Jm?=
 =?us-ascii?Q?yCOj0Gxj5+WMJaBz1DYcpGru2cZ9WcvFdmnptdGifRbCjnX6yFyZZJFau7Rb?=
 =?us-ascii?Q?t1zZPfJ/qaKr1UTMURnJCf5qVqxbF9sNa82HMfQwNrkFj3v+0QUOWszqf9lc?=
 =?us-ascii?Q?vY9Vorw7yv1tsyzKL6PsywhvjjEuFEUyHLvUEzgB7kmqGvnyfBo9EmnZ9hmu?=
 =?us-ascii?Q?gERIHwzS2XDot+5ThrvnOfC4LY0ASJ/Ijg3e2s6kPANjIGiFzjRQqhnapAJe?=
 =?us-ascii?Q?hYM2/b/FhkjHHpeJtG4w0EumLyH9/i2cW3KqYFk5rpEehqH9/djA49+uTjsp?=
 =?us-ascii?Q?UWEVAn4zA8aS0s1QK58GAwhOZaLjBQeedHVXACNOYW4Cql+MSMvhpdqjka3X?=
 =?us-ascii?Q?CkUTeyZRNhen7R0cQj3Az/NjWdPlIdcHlzWK1RGcR53wNaFRnnCMa9vHf1xx?=
 =?us-ascii?Q?sO4fIOy2s9V/Ibqg9kcoVwjawf8wShAZ7yfjQFhBqLQ9hNnA1zAxhOFbiLVx?=
 =?us-ascii?Q?Irmzc2dK2UZ1ABI808VyHc84xRX35cxD+Odncjrjt5ttuKdAVU/x5lpkYjKW?=
 =?us-ascii?Q?RPURY3KKgAcPqGFulIFl5egXSL4kdPerhKTX7bmGH0Byt2tUxQxH94FHM6fW?=
 =?us-ascii?Q?ATR1XNh8+fb3l3Ksu2oK7pZic68jPKx5n7ibZhpeOxDawmELUoos34Alu+nn?=
 =?us-ascii?Q?i86lpy3w9QDSNECz1cKIeeMbBDUZEaqDKh3TASlUHGMdTGhWWpmnV1RnwU4Z?=
 =?us-ascii?Q?xVS0xsfYvO3KMvhgZhnZFa90maKHPtqX4Xuc0qH3RGlD5sZLastzzCNYZc3c?=
 =?us-ascii?Q?oVna4sMorNzltmeyw9QdJzqSI6WRnwyalg2H6HRIdqkTYNsX2ElYtzJz4tEk?=
 =?us-ascii?Q?2imFYjUubi2WsyRpP0d84N9UC/2RFn2asaNJVFMCCV+yFmhS/fQDNaJaKW8U?=
 =?us-ascii?Q?ohcr5X9P/x3GYBDtZNgUx2uCDlEHppM7seKqoV9DilxY1705xEvqc/JMwCJq?=
 =?us-ascii?Q?JJR/eyQKDa20CLmICyanvDxZM6b9Pv0KjFm36l2x1DHFw1QaUS+LxzIQ/ZJs?=
 =?us-ascii?Q?NvdIyIH9ca9d5YSaKWhzDod6F7pjQoj8zhqcK/Mklft1ptrzSQQdB0r7SYUA?=
 =?us-ascii?Q?0AM5wLhbMOj9j5n9mj2EUJVmvY0DJq4zJient5Ca1V9Xd27kQXUnQjJ6FYRG?=
 =?us-ascii?Q?shZj3JE0gwZj5fkQAoA2A8RJCQ2uHHziwTLqA279xWOZKtXsmtkMQeem3ZvY?=
 =?us-ascii?Q?b28hX1Zwe7kZ9bPSljw6gV99cduef2WUgshzJ8FIy2O/0da7ELSFEIEpp00i?=
 =?us-ascii?Q?+hkuNkeVy4BivGZ2Nv0yHNucVvRaG/kyBUEb4BKAuZeJ0uXQ9k6jjLd9e8or?=
 =?us-ascii?Q?cgrxOKmQ668zCwbnFQoydMQDPEV27hQnKC/J7TdyiG2Ym8QSpSH/LU898v08?=
 =?us-ascii?Q?7A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5FD855396B936E47BFF53D2B5DF00218@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337f16a7-9ed6-41eb-a57c-08da5f6cbad3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 16:29:42.1260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WPp3RxWxM8mwytN/EHYbpu4ZYL+8NiAazYuapnQyP7V1gA/n0l/xD9LkTWXrnNP/1vZkgtOG6YZNpw+D41dvnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5478
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_09:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060065
X-Proofpoint-GUID: B1IjFTP1mU_kipL1UlPf4ChKVF8huYgh
X-Proofpoint-ORIG-GUID: B1IjFTP1mU_kipL1UlPf4ChKVF8huYgh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 6, 2022, at 12:18 AM, NeilBrown <neilb@suse.de> wrote:
>=20
> nfsd_lookup() takes an exclusive lock on the parent inode, but many
> callers don't want the lock and may not need to lock at all if the
> result is in the dcache.
>=20
> Change nfsd_lookup() to be passed a bool flag.
> If false, don't take the lock.
> If true, do take an exclusive lock, and return with it held if
> successful.
> If nfsd_lookup() returns an error, the lock WILL NOT be held.
>=20
> Only nfsd4_open() requests the lock to be held, and does so to block
> rename until it decides whether to return a delegation.
>=20
> NOTE: when nfsd4_open() creates a file, the directory does *NOT* remain
>  locked and never has.  So it is possible (though unlikely) for the
>  newly created file to be renamed before a delegation is handed out,
>  and that would be bad.  This patch does *NOT* fix that, but *DOES*
>  take the directory lock immediately after creating the file, which
>  reduces the size of the window and ensure that the lock is held
>  consistently.  More work is needed to guarantee no rename happens
>  before the delegation.
>=20
> NOTE-2: NFSv4 requires directory changeinfo for OPEN even when a create
>  wasn't requested and no change happened.  Now that nfsd_lookup()
>  doesn't use fh_lock(), we need explicit fh_fill_pre/post_attrs()
>  in the non-create branch of do_open_lookup().
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> fs/nfsd/nfs3proc.c |    2 +-
> fs/nfsd/nfs4proc.c |   51 ++++++++++++++++++++++++++++------------
> fs/nfsd/nfsproc.c  |    2 +-
> fs/nfsd/vfs.c      |   66 +++++++++++++++++++++++++++++++++++------------=
-----
> fs/nfsd/vfs.h      |    8 ++++--
> 5 files changed, 88 insertions(+), 41 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index ad7941001106..3a67d0afb885 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -96,7 +96,7 @@ nfsd3_proc_lookup(struct svc_rqst *rqstp)
>=20
> 	resp->status =3D nfsd_lookup(rqstp, &resp->dirfh,
> 				   argp->name, argp->len,
> -				   &resp->fh);
> +				   &resp->fh, false);
> 	return rpc_success;
> }
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 4737019738ab..6ec22c69cbec 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -414,7 +414,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> }
>=20
> static __be32
> -do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *csta=
te, struct nfsd4_open *open, struct svc_fh **resfh)
> +do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *csta=
te,
> +	       struct nfsd4_open *open, struct svc_fh **resfh)
> {
> 	struct svc_fh *current_fh =3D &cstate->current_fh;
> 	int accmode;
> @@ -441,11 +442,18 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate, stru
> 		 * yes          | no     | GUARDED4        | GUARDED4
> 		 * yes          | yes    | GUARDED4        | GUARDED4
> 		 */
> -
> 		current->fs->umask =3D open->op_umask;
> 		status =3D nfsd4_create_file(rqstp, current_fh, *resfh, open);
> 		current->fs->umask =3D 0;
>=20
> +		if (!status)
> +			/* We really want to hold the lock from before the
> +			 * create to ensure no rename happens, but that
> +			 * needs more work...
> +			 */
> +			inode_lock_nested(current_fh->fh_dentry->d_inode,
> +					  I_MUTEX_PARENT);
> +
> 		if (!status && open->op_label.len)
> 			nfsd4_security_inode_setsecctx(*resfh, &open->op_label, open->op_bmval=
);
>=20
> @@ -457,17 +465,25 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate, stru
> 		if (nfsd4_create_is_exclusive(open->op_createmode) && status =3D=3D 0)
> 			open->op_bmval[1] |=3D (FATTR4_WORD1_TIME_ACCESS |
> 						FATTR4_WORD1_TIME_MODIFY);
> -	} else
> -		/*
> -		 * Note this may exit with the parent still locked.
> -		 * We will hold the lock until nfsd4_open's final
> -		 * lookup, to prevent renames or unlinks until we've had
> -		 * a chance to an acquire a delegation if appropriate.
> +	} else {
> +		/* We want to keep the directory locked until we've had a chance
> +		 * to acquire a delegation if appropriate, so request that
> +		 * nfsd_lookup() hold on to the lock.
> 		 */
> 		status =3D nfsd_lookup(rqstp, current_fh,
> -				     open->op_fname, open->op_fnamelen, *resfh);
> +				     open->op_fname, open->op_fnamelen, *resfh,
> +				     true);
> +		if (!status) {
> +			/* NFSv4 protocol requires change attributes even though
> +			 * no change happened.
> +			 */
> +			fh_fill_pre_attrs(current_fh);
> +			fh_fill_post_attrs(current_fh);

If this is really correct, the comment should also state that
no concurrent changes to the parent are possible during
the lookup, and thus the pre and post attributes are expected
to be the same always.

Otherwise, this code paragraph looks just a little insane ;-)


> +		}
> +	}
> 	if (status)
> -		goto out;
> +		return status;
> +
> 	status =3D nfsd_check_obj_isreg(*resfh);
> 	if (status)
> 		goto out;
> @@ -483,6 +499,8 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate, stru
> 	status =3D do_open_permission(rqstp, *resfh, open, accmode);
> 	set_change_info(&open->op_cinfo, current_fh);
> out:
> +	if (status)
> +		inode_unlock(current_fh->fh_dentry->d_inode);
> 	return status;
> }
>=20
> @@ -540,6 +558,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compo=
und_state *cstate,
> 	struct net *net =3D SVC_NET(rqstp);
> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> 	bool reclaim =3D false;
> +	bool locked =3D false;
>=20
> 	dprintk("NFSD: nfsd4_open filename %.*s op_openowner %p\n",
> 		(int)open->op_fnamelen, open->op_fname,
> @@ -604,6 +623,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compo=
und_state *cstate,
> 		status =3D do_open_lookup(rqstp, cstate, open, &resfh);
> 		if (status)
> 			goto out;
> +		locked =3D true;
> 		break;
> 	case NFS4_OPEN_CLAIM_PREVIOUS:
> 		status =3D nfs4_check_open_reclaim(cstate->clp);
> @@ -639,6 +659,8 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compo=
und_state *cstate,
> 		fput(open->op_filp);
> 		open->op_filp =3D NULL;
> 	}
> +	if (locked)
> +		inode_unlock(cstate->current_fh.fh_dentry->d_inode);
> 	if (resfh && resfh !=3D &cstate->current_fh) {
> 		fh_dup2(&cstate->current_fh, resfh);
> 		fh_put(resfh);
> @@ -933,7 +955,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp=
, struct svc_fh *fh)
> 		return nfserr_noent;
> 	}
> 	fh_put(&tmp_fh);
> -	return nfsd_lookup(rqstp, fh, "..", 2, fh);
> +	return nfsd_lookup(rqstp, fh, "..", 2, fh, false);
> }
>=20
> static __be32
> @@ -949,7 +971,7 @@ nfsd4_lookup(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> {
> 	return nfsd_lookup(rqstp, &cstate->current_fh,
> 			   u->lookup.lo_name, u->lookup.lo_len,
> -			   &cstate->current_fh);
> +			   &cstate->current_fh, false);
> }
>=20
> static __be32
> @@ -1089,11 +1111,10 @@ nfsd4_secinfo(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
> 	if (err)
> 		return err;
> 	err =3D nfsd_lookup_dentry(rqstp, &cstate->current_fh,
> -				    secinfo->si_name, secinfo->si_namelen,
> -				    &exp, &dentry);
> +				 secinfo->si_name, secinfo->si_namelen,
> +				 &exp, &dentry, false);
> 	if (err)
> 		return err;
> -	fh_unlock(&cstate->current_fh);
> 	if (d_really_is_negative(dentry)) {
> 		exp_put(exp);
> 		err =3D nfserr_noent;
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index a25b8e321662..ed24fae09517 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -133,7 +133,7 @@ nfsd_proc_lookup(struct svc_rqst *rqstp)
>=20
> 	fh_init(&resp->fh, NFS_FHSIZE);
> 	resp->status =3D nfsd_lookup(rqstp, &argp->fh, argp->name, argp->len,
> -				   &resp->fh);
> +				   &resp->fh, false);
> 	fh_put(&argp->fh);
> 	if (resp->status !=3D nfs_ok)
> 		goto out;
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 4916c29af0fa..8e050c6d112a 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -172,7 +172,8 @@ int nfsd_mountpoint(struct dentry *dentry, struct svc=
_export *exp)
> __be32
> nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
> 		   const char *name, unsigned int len,
> -		   struct svc_export **exp_ret, struct dentry **dentry_ret)
> +		   struct svc_export **exp_ret, struct dentry **dentry_ret,
> +		   bool locked)
> {
> 	struct svc_export	*exp;
> 	struct dentry		*dparent;
> @@ -199,27 +200,31 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
> 				goto out_nfserr;
> 		}
> 	} else {
> -		/*
> -		 * In the nfsd4_open() case, this may be held across
> -		 * subsequent open and delegation acquisition which may
> -		 * need to take the child's i_mutex:
> -		 */
> -		fh_lock_nested(fhp, I_MUTEX_PARENT);
> -		dentry =3D lookup_one_len(name, dparent, len);
> +		if (locked)
> +			dentry =3D lookup_one_len(name, dparent, len);
> +		else
> +			dentry =3D lookup_one_len_unlocked(name, dparent, len);
> 		host_err =3D PTR_ERR(dentry);
> 		if (IS_ERR(dentry))
> 			goto out_nfserr;
> 		if (nfsd_mountpoint(dentry, exp)) {
> 			/*
> -			 * We don't need the i_mutex after all.  It's
> -			 * still possible we could open this (regular
> -			 * files can be mountpoints too), but the
> -			 * i_mutex is just there to prevent renames of
> -			 * something that we might be about to delegate,
> -			 * and a mountpoint won't be renamed:
> +			 * nfsd_cross_mnt() may wait for an upcall
> +			 * to userspace, and holding i_sem across that
> +			 * invites the possibility of a deadlock.
> +			 * We don't really need the lock on the parent
> +			 * of a mount point was we only need it to guard
> +			 * against a rename before we get a lease for a
> +			 * delegation.
> +			 * So just drop the i_sem and reclaim it.
> 			 */
> -			fh_unlock(fhp);
> -			if ((host_err =3D nfsd_cross_mnt(rqstp, &dentry, &exp))) {
> +			if (locked)
> +				inode_unlock(dparent->d_inode);
> +			host_err =3D nfsd_cross_mnt(rqstp, &dentry, &exp);
> +			if (locked)
> +				inode_lock_nested(dparent->d_inode,
> +						  I_MUTEX_PARENT);
> +			if (host_err) {
> 				dput(dentry);
> 				goto out_nfserr;
> 			}
> @@ -234,7 +239,17 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
> 	return nfserrno(host_err);
> }
>=20
> -/*
> +/**
> + * nfsd_lookup - look up a single path component for nfsd
> + *
> + * @rqstp:   the request context
> + * @ftp:     the file handle of the directory
> + * @name:    the component name, or %NULL to look up parent
> + * @len:     length of name to examine
> + * @resfh:   pointer to pre-initialised filehandle to hold result.
> + * @lock:    if true, lock directory during lookup and keep it locked
> + *           if there is no error.
> + *
>  * Look up one component of a pathname.
>  * N.B. After this call _both_ fhp and resfh need an fh_put
>  *
> @@ -244,11 +259,15 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
>  * returned. Otherwise the covered directory is returned.
>  * NOTE: this mountpoint crossing is not supported properly by all
>  *   clients and is explicitly disallowed for NFSv3
> - *      NeilBrown <neilb@cse.unsw.edu.au>
> + *
> + * Only nfsd4_open() calls this with @lock set.  It does so to block
> + * renames/unlinks before it possibly gets a lease to provide a
> + * delegation.
>  */
> __be32
> nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
> -				unsigned int len, struct svc_fh *resfh)
> +	    unsigned int len, struct svc_fh *resfh,
> +	    bool lock)
> {
> 	struct svc_export	*exp;
> 	struct dentry		*dentry;
> @@ -257,9 +276,11 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *f=
hp, const char *name,
> 	err =3D fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_EXEC);
> 	if (err)
> 		return err;
> -	err =3D nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &dentry);
> +	if (lock)
> +		inode_lock_nested(fhp->fh_dentry->d_inode, I_MUTEX_PARENT);
> +	err =3D nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &dentry, lock);
> 	if (err)
> -		return err;
> +		goto out_err;
> 	err =3D check_nfsd_access(exp, rqstp);
> 	if (err)
> 		goto out;
> @@ -273,6 +294,9 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fh=
p, const char *name,
> out:
> 	dput(dentry);
> 	exp_put(exp);
> +out_err:
> +	if (err && lock)
> +		inode_unlock(fhp->fh_dentry->d_inode);
> 	return err;
> }
>=20
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 9f4fd3060200..290788f007d4 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -45,10 +45,12 @@ typedef int (*nfsd_filldir_t)(void *, const char *, i=
nt, loff_t, u64, unsigned);
> int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
> 		                struct svc_export **expp);
> __be32		nfsd_lookup(struct svc_rqst *, struct svc_fh *,
> -				const char *, unsigned int, struct svc_fh *);
> +			    const char *, unsigned int, struct svc_fh *,
> +			    bool);
> __be32		 nfsd_lookup_dentry(struct svc_rqst *, struct svc_fh *,
> -				const char *, unsigned int,
> -				struct svc_export **, struct dentry **);
> +				    const char *, unsigned int,
> +				    struct svc_export **, struct dentry **,
> +				    bool);
> __be32		nfsd_setattr(struct svc_rqst *, struct svc_fh *,
> 				struct iattr *, int, time64_t);
> int nfsd_mountpoint(struct dentry *, struct svc_export *);
>=20
>=20

--
Chuck Lever



