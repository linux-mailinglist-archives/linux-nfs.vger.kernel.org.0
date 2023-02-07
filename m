Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2091568DC5F
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Feb 2023 16:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjBGPBo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Feb 2023 10:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjBGPBn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Feb 2023 10:01:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DD412F25
        for <linux-nfs@vger.kernel.org>; Tue,  7 Feb 2023 07:01:40 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317DxbwX032326;
        Tue, 7 Feb 2023 15:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=bxyv8H7CW1hGWZxxGKcVqSMLzttHhHodBte0hcvlIG8=;
 b=HewSqvJK6jhkSWaNnR38m6F3vMXpMqNsISJZXj6m/Wsii2WGgQRkHIcmZ4qZtiHjsdQg
 iLn6XaP6FwmYRE60TzubPSYE17IEwn2laD/Gd8gZ4/z4cCRARhlf5fA52p3/e1zDwod/
 1mTJPC4Z+gLFsmId7VIut9zHG+s3mJhmGLJI7/UNVjjjJRjIR29SMtInj79abaUJPo0T
 WUGDY3QA9E41uh6S5CQM6C/N/kETpuCE249255UXU+CfVnIb/30/QDFD+7C2wlqCu8zh
 TAC20W8lLbNd7SrL/8kJdwSVjGUk//rNWSg4tDEA0qgpAaTrHBqpB806eDGN/DVl/OFN iA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhf8a5nhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 15:01:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 317EQ88J029166;
        Tue, 7 Feb 2023 15:01:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtc85re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 15:01:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRXJnOuaPWGb70xTo63DlxWcbk6LuSLriAaPqG2737b2cYgR/n2GzXNHaOB4IAGBLy8cVSQBoRXp1uGeJwwhHq6pT9Eif4WXQ+zvVVlAGja4Q/DNu3GIn0xsfpqJu1lD1pett5fMhN9x2mMDDslkhtJLyfysdSyZn58mGZ2F9fWoh5PJ0HJIqnSm3QwCS/clBtMPoOPjjv0q/blCX5/WEHbVJ2wGt3HSUZfHhsKJUMaBQMKWFR6wv2vPVi8H0iRiv6PLtDpDUakCL3JHesW/iwyEEddvt7pU/nhOxf7T95xr4jvkBuqaxtWFWQ95AOLTnnjSw3nAqxsRdGHL9F8QpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxyv8H7CW1hGWZxxGKcVqSMLzttHhHodBte0hcvlIG8=;
 b=Gp3xfmLlD6RUe3ZpfBXt7j797UhqxKt9JNMr5oWH6+Pe04sbgPGU2h/eZ8QTdg8A/S4juixbdxG/ZlYf8pnls1STRckDdUIY4zgP9OhkxMupsW/H89my0YQtBu9lzhfC0madzWQzd7PMtKw1rSnaMJ/hGcDW0if1YHBUeS/YFEfEkuge2d9/wuZ5fqmHzqtVaag/TfcZGi7fuUkjp6x+/l+nHs+0rVkyPZdAGfrfoHktrM45CC+UyimBLTphSyFjZM54Hcl4K7//n1BaC2gGR/Cw/Be+N8tJIQvGxZmHGVZbgA+SwIancRoDw5bzaHtN8ATyyx8wmhlOTXhD+zRniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxyv8H7CW1hGWZxxGKcVqSMLzttHhHodBte0hcvlIG8=;
 b=A0jLZTgTKOxiPcWUHYpPCaJZVrri33+TV0rH6kelMysyBUEBcEnV2yqH6+wdZQ6qY6ZBYa25QGx+9M9DjA6siSeXiTlGywqCdRuLzOd4hmONqLkPu4GLfg9mK46B/4+YA19yA3F/5Yp0E1zOxUSTBaNH/SsX7x4DvKg/6VEay0E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6850.namprd10.prod.outlook.com (2603:10b6:930:9e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.15; Tue, 7 Feb
 2023 15:01:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%6]) with mapi id 15.20.6086.015; Tue, 7 Feb 2023
 15:01:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Pierguido Lambri <plambri@redhat.com>
Subject: Re: [PATCH] nfsd: don't fsync nfsd_files on last close
Thread-Topic: [PATCH] nfsd: don't fsync nfsd_files on last close
Thread-Index: AQHZOwOLyJLMqY1kMEWJKMRFv6gLCa7DlAqA
Date:   Tue, 7 Feb 2023 15:01:20 +0000
Message-ID: <90CCAB9B-935F-4450-8AE8-7F3C902A5402@oracle.com>
References: <20230207145030.90123-1-jlayton@kernel.org>
In-Reply-To: <20230207145030.90123-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6850:EE_
x-ms-office365-filtering-correlation-id: 0def67db-2a77-414b-2fb7-08db091c2c36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1LtkID/61gmg9Iq3MJ4Tj8d1hIcJGwOVN0f+1pOwR6umM2954T+6O3vL7HVu4XZIPyYmV79QZnIFpsoZcmAU5SOlaChIRsg9fCOFzhWeey8XEmURIW0xhtJz+8K5ILdweEESDIDpILFlcE0LkpGmUCLz5GXg8r9//pBQfCWLessNe3Jr4w8e2WoIWyRMTov/xj7qRGHsMEgacCjM15kLMgXByvalNwEGSmKNX/CblrgQ7ga/J9tAouUGdpG9DE3hOLyV+ldNyYwaUJ9hyp9MYQjhtPMUCjymq8N9cbE1vEJmjqKl24VRi3LuWkzyotSFge8CZJ7HWQH5lnnpq24dZpQLjz02yOnwfjKLOvglS7k4TCyOwkj5dFzNdH1Lbn5VM1psUnADoxSaMqDAyPLNXfBy31+I2Gr3YWgmHJROkTeIyppMuxU21big+skkzvNimos7gt2L00tYqO+nhPWntf/Hfp0dmgYkVQXWWSK6+XfotUYcEZdaRdTq6MC7sLFORW6WlDUFXfd99qgk5Y0+1+FzQc9Gt7lt5q5eay08zMtQEvpmWPa4T0p/8exeivjZEueA9mmLqhyjALLRNrCyMw1RNYuL7Pf3RZHzmKXaCJTirIRHBo1ianFLjFRHhEg0P3qOS+GRChsA+xexTCZMDeBegC5ex3ixtF4Q0DlKTH13CZ4MU443qB2a2W6mRnMULhFjA8dLgV0fjh0NZDWQuh7IY5uV556WMJR80M1Yupc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199018)(36756003)(71200400001)(33656002)(186003)(54906003)(478600001)(6486002)(6506007)(53546011)(26005)(316002)(41300700001)(2906002)(5660300002)(8936002)(6512007)(66946007)(91956017)(66476007)(38100700002)(66446008)(76116006)(64756008)(122000001)(6916009)(8676002)(86362001)(66556008)(4326008)(38070700005)(2616005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QOMJvR6MAH6tJNCL1/ex2eA79vn6FAMozc17o+DO9+I5ZZLFwUqs/hHWdW0S?=
 =?us-ascii?Q?PK7Gi3GhX0X4LWRYwqFAbugkKeoU84Zf6NHecBZTRwmUWYTRRiYnShnKbn9G?=
 =?us-ascii?Q?bhHGqULVuzRHhra7E/PDtq8DJRUS5iVIMAahYlPdjHU24SK6uPOJi+PyaYV/?=
 =?us-ascii?Q?ppPMv3sds8qMSOe+8Kr8J2vrxvlSYB5K40qwTl+W3c5juR7kjF+4xLBNR15a?=
 =?us-ascii?Q?ZJk7SH8J3MIc3iHajdr/JvwbGJ+neS+aSgEDpwIqTteSZehdRmqfo+I9nrj4?=
 =?us-ascii?Q?m7EVABgQRUq7Tw5iLioiUBKOkX8wrgFGJA0NEtw6yOMN65ST3QRZU5IV57Y8?=
 =?us-ascii?Q?YiwY6QPJfXCgGp0hbwWUozMreBWR9V3i496hdg82vyNWWZbqKyXxvKxj6KVw?=
 =?us-ascii?Q?q0CZGsCV+VuRpW9ZQZNi3R7vNSQ7umbCUGSccS2Gm4c6T7PH2BEyJ6otQRwO?=
 =?us-ascii?Q?dcmejDMr9ZIGgoFLo5vQEpdz+LGKKi0gwP5jW743TFT4QttubZK6LaWQnvDd?=
 =?us-ascii?Q?a+sFI67riGwwhiF9I55ZU/7RZYsOEMmqUPQhjbFAZulcg/nXPktfyyxjg79V?=
 =?us-ascii?Q?FhIED/mPlIoZB/tDD1xPjugH5D2dmmIf44OuBptFBxbeAE1a/St/6b4NObLV?=
 =?us-ascii?Q?CPTOZX0wV1iYgvPMMiP3/iGVDVfwvQdcTTN24TviP2GuM5I+DHeJWyPVWFDL?=
 =?us-ascii?Q?DuKEYMs0qqTPeeowIUxKMRLpWBepladM5hKJjyJ5oCWCRnoUpGyyOTn1A9rl?=
 =?us-ascii?Q?FuwDaOORyAToMK1x/cPTIoCM2rlCVMDL2KgsiLuXbs+fJy0uFNjWUuae4X+M?=
 =?us-ascii?Q?dq/KVZH1SpTK2tPF3gAgEvzuAH5Ga3m7028GoDZZZLtm/lrQ1AN4+b4qMtCA?=
 =?us-ascii?Q?PQp6ml4o3qrw7jMcXqk++9maF7IO4UVOFOs6zEULixsIeX2pigoL1M/XVeTt?=
 =?us-ascii?Q?nv4tUpY7uHSlq7xprXWc/kKCqS1PUODuV/auvE50y2Bfq6Xki8x95ef26sdx?=
 =?us-ascii?Q?FtWz5yfJf+QKcLf6gyKNQzOp5ls5YMq1AFnumoSpuSdKoTHb1LPGJkax6oTM?=
 =?us-ascii?Q?lfB9SuA2lnQUmDF33B0Hu8kLJZh3cO1QYiqAi23cnj//O/Is7ltu44DvG8Hr?=
 =?us-ascii?Q?ggvBVN21L9B/FpqAGiQn8UzrGaEU1+yUEoHabvq9OQzOnNHMlTqbkX1lKaM0?=
 =?us-ascii?Q?JlBRMvsWz9sbRyfVVkkJqUPb3StgyGkK3rUpmf8M2hssowFCZJ6G/1gZF0lH?=
 =?us-ascii?Q?3F7uch9ivRZLZj56VDrA8rzG0gdQg3+KQ26KzDeAgMhdGN89skkwKcNHLTJV?=
 =?us-ascii?Q?b+4N6pGbbUGCQ/1/fdz6NBPEEKQcmLxfQPSfldYmXpGbZJvWHdA2GuhT3g3h?=
 =?us-ascii?Q?VWo55GzdG9MxSmCW881jrMpl9h/9+dqrFPP3H2k0jnVXlzon843SZ6yDOasj?=
 =?us-ascii?Q?aMkzwXNxU40uTHrYcCTjJbYfDXs4iuWzD2A4LnpPx6DCAV8s9BRtSlx//9mj?=
 =?us-ascii?Q?vIMP8mZUZvhUhPmNeq8m8WGt6rDec2jrACk1QcGHexbBL6UAl5VdJWkgZjvS?=
 =?us-ascii?Q?RIqLkkOIZsQtKxiDyc1Age8quAgS3DtvOz5tzyV05ro2CNe/FH8mD2VR3nHn?=
 =?us-ascii?Q?Dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2FCFE0EEA7200D40A886FE5746A431D2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: poOTksiwFgzmZwOeW/rvCkA9DxS6lnBSqoYBaa3OAZr4Zi0ww7I74tGP/JColapMhfLpEw0nVi+na/TH6dT4J0wCOLRSL7IgjjDDdEn5ZocXp/rvPm0tZabTR2pnbNXfR7i8kIt8tMNPqN7MVFExVw2aWAiPe5kqLXHVv1fyPKbpmMWETixYp/lIVBJgpf80eVv04CauTyCDCdtmGBEad/bQC8opTPOcVXMuumqWsVyKTipvom8h5zMvi1uGieVHoVUejKEIlZQF+TzkJWw8VelqTWL4tfHdII1x+xFZCayY2eh8I5DnTThTwqZ1gUOgem+UN67Gvd/4x88ekB/kJQVXdwTaYeatVVUPe1cln5ogfXK5Q0n+vOX9OIJS3KlYu+5r1UC6QzTnDncFmcCJAi9DTUrqumqdlw5Elsp/DjgZqite0p8IO3nIZz5cjv+ie1NCbGApuJTHp0AvIQCbzF44hxZcp3WlIaXxDgHuVBihauS1FVxd2gAdW/i7VyXavLhKEj1g8aIM/iwnAlum+Ols37o8jYKuG92sOcdzOeaDDGf++jLDnIB3GpjAlJMqO6Tnnbh7Wxgr2Z8W5coiCdoANbcWqBW7VEz+oeUSiU9/sbYC0t7qjTv1rLSliNeq2REek/Xv2KLP8YgN+KWYNOhGqp5mJ1W7qVR3UFKxhaO9PpEZQJMDyA1iG1mq+Cve/J+MoDfHLejsylhg3zA1OEwRoPPTLfNnL/HbW51q8Btd0kLoAf0sID7Spg1rMqax13MM4gyLcvrE+lA+jP4eU90WCfHJ8xrFwX7U8xTJ9W1Owi7YbI1G2pRt7I0g+DiD
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0def67db-2a77-414b-2fb7-08db091c2c36
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 15:01:20.7915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /G17xRrOaoh+lvPsA9ElvIDA6xSaEhpftH8/uxtYWCpbfaYzrpN1b58V3j9yqvaVhqY8VQIX8gWNmAMmI6dJFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6850
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302070134
X-Proofpoint-ORIG-GUID: QFZtTx7eT-BA3nVrkP4KDJ14gICv5fbx
X-Proofpoint-GUID: QFZtTx7eT-BA3nVrkP4KDJ14gICv5fbx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 7, 2023, at 9:50 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> Most of the time, NFSv4 clients issue a COMMIT before the final CLOSE of
> an open stateid, so with NFSv4, the fsync in the nfsd_file_free path is
> usually a no-op and doesn't block.
>=20
> We have a customer running knfsd over very slow storage (XFS over Ceph
> RBD). They were using the "async" export option because performance was
> more important than data integrity for this application. That export
> option turns NFSv4 COMMIT calls into no-ops. Due to the fsync in this
> codepath however, their final CLOSE calls would still stall (since a
> CLOSE effectively became a COMMIT).
>=20
> I think this fsync is not strictly necessary. We only use that result to
> reset the write verifier. Instead of fsync'ing all of the data when we
> free an nfsd_file, we can just check for writeback errors when one is
> acquired and when it is freed.
>=20
> If the client never comes back, then it'll never see the error anyway
> and there is no point in resetting it. If an error occurs after the
> nfsd_file is removed from the cache but before the inode is evicted,
> then it will reset the write verifier on the next nfsd_file_acquire,
> (since there will be an unseen error).
>=20
> The only exception here is if something else opens and fsyncs the file
> during that window. Given that local applications work with this
> limitation today, I don't see that as an issue.
>=20
> Reported-and-Tested-by: Pierguido Lambri <plambri@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Seems sensible and clean.

I would like to queue this in the filecache topic branch, but
that means it won't get merged until v6.4 at the earliest. Is
that OK?


> ---
> fs/nfsd/filecache.c | 48 ++++++++++++++-------------------------------
> fs/nfsd/trace.h     | 31 -----------------------------
> 2 files changed, 15 insertions(+), 64 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 136e543ae44b..fcd16ffbf9ad 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -233,37 +233,27 @@ nfsd_file_alloc(struct net *net, struct inode *inod=
e, unsigned char need,
> 	return nf;
> }
>=20
> +/**
> + * nfsd_file_check_write_error - check for writeback errors on a file
> + * @nf: nfsd_file to check for writeback errors
> + *
> + * Check whether a nfsd_file has an unseen error. Reset the write
> + * verifier if so.
> + */
> static void
> -nfsd_file_fsync(struct nfsd_file *nf)
> -{
> -	struct file *file =3D nf->nf_file;
> -	int ret;
> -
> -	if (!file || !(file->f_mode & FMODE_WRITE))
> -		return;
> -	ret =3D vfs_fsync(file, 1);
> -	trace_nfsd_file_fsync(nf, ret);
> -	if (ret)
> -		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> -}
> -
> -static int
> nfsd_file_check_write_error(struct nfsd_file *nf)
> {
> 	struct file *file =3D nf->nf_file;
>=20
> -	if (!file || !(file->f_mode & FMODE_WRITE))
> -		return 0;
> -	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err))=
;
> +	if ((file->f_mode & FMODE_WRITE) &&
> +	    filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err)))
> +		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> }
>=20
> static void
> nfsd_file_hash_remove(struct nfsd_file *nf)
> {
> 	trace_nfsd_file_unhash(nf);
> -
> -	if (nfsd_file_check_write_error(nf))
> -		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> 	rhltable_remove(&nfsd_file_rhltable, &nf->nf_rlist,
> 			nfsd_file_rhash_params);
> }
> @@ -289,22 +279,13 @@ nfsd_file_free(struct nfsd_file *nf)
> 	this_cpu_add(nfsd_file_total_age, age);
>=20
> 	nfsd_file_unhash(nf);
> -
> -	/*
> -	 * We call fsync here in order to catch writeback errors. It's not
> -	 * strictly required by the protocol, but an nfsd_file could get
> -	 * evicted from the cache before a COMMIT comes in. If another
> -	 * task were to open that file in the interim and scrape the error,
> -	 * then the client may never see it. By calling fsync here, we ensure
> -	 * that writeback happens before the entry is freed, and that any
> -	 * errors reported result in the write verifier changing.
> -	 */
> -	nfsd_file_fsync(nf);
> -
> 	if (nf->nf_mark)
> 		nfsd_file_mark_put(nf->nf_mark);
> -	if (nf->nf_file)
> +
> +	if (nf->nf_file) {
> +		nfsd_file_check_write_error(nf);
> 		filp_close(nf->nf_file, NULL);
> +	}
>=20
> 	/*
> 	 * If this item is still linked via nf_lru, that's a bug.
> @@ -1080,6 +1061,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> out:
> 	if (status =3D=3D nfs_ok) {
> 		this_cpu_inc(nfsd_file_acquisitions);
> +		nfsd_file_check_write_error(nf);
> 		*pnf =3D nf;
> 	}
> 	put_cred(cred);
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 8f9c82d9e075..4183819ea082 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -1202,37 +1202,6 @@ TRACE_EVENT(nfsd_file_close,
> 	)
> );
>=20
> -TRACE_EVENT(nfsd_file_fsync,
> -	TP_PROTO(
> -		const struct nfsd_file *nf,
> -		int ret
> -	),
> -	TP_ARGS(nf, ret),
> -	TP_STRUCT__entry(
> -		__field(void *, nf_inode)
> -		__field(int, nf_ref)
> -		__field(int, ret)
> -		__field(unsigned long, nf_flags)
> -		__field(unsigned char, nf_may)
> -		__field(struct file *, nf_file)
> -	),
> -	TP_fast_assign(
> -		__entry->nf_inode =3D nf->nf_inode;
> -		__entry->nf_ref =3D refcount_read(&nf->nf_ref);
> -		__entry->ret =3D ret;
> -		__entry->nf_flags =3D nf->nf_flags;
> -		__entry->nf_may =3D nf->nf_may;
> -		__entry->nf_file =3D nf->nf_file;
> -	),
> -	TP_printk("inode=3D%p ref=3D%d flags=3D%s may=3D%s nf_file=3D%p ret=3D%=
d",
> -		__entry->nf_inode,
> -		__entry->nf_ref,
> -		show_nf_flags(__entry->nf_flags),
> -		show_nfsd_may_flags(__entry->nf_may),
> -		__entry->nf_file, __entry->ret
> -	)
> -);
> -
> #include "cache.h"
>=20
> TRACE_DEFINE_ENUM(RC_DROPIT);
> --=20
> 2.39.1
>=20

--
Chuck Lever



