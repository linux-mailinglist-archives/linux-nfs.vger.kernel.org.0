Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE5D5A8049
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Aug 2022 16:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiHaOe5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Aug 2022 10:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiHaOe4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Aug 2022 10:34:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528E67674;
        Wed, 31 Aug 2022 07:34:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VEGFOn010674;
        Wed, 31 Aug 2022 14:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=F7D1k15hVYSBGLlJVM0XBPTeQvG93C28OBveQ5tzoNw=;
 b=mQ6sGd3p6bFiti/uPFlS3pMtPIPRGXiak9scj/AafwRW49DhLBINbLtDvVH0+kkmGILg
 qJwmGX/aYTn4xZ2EBlmfp8mqiOd9dvQ4ZP5yzb6L17WDaZnD7cmjNSntSmN3XUwmhZLI
 cXXXN+VGWckMeFkyLu6uLelDmdSZoVUq3s/Mp7Z3ku76evkGP7TklCmRY7EoPRH8sRdZ
 bO2KcjKzANGmUvqNUqyT8gMU35eB1EpYqWaU++cu6DUpj/xkBQkPbpzhYSL7RsbqfwMd
 8U0viNFJmWjb9CDLuu8H9FruimwYbNMtCFLYdeOfEMJbPxFcpBVodT1Fis02JYf8hB24 mQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7btt9dbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 14:34:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27VEN5V5022117;
        Wed, 31 Aug 2022 14:34:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q54ets-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 14:34:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5q2xIB7JIEZrz2/79YqWPP8aVaxOJXlxAv7I7rDSVm9059DzCvDA9p98mBuLoMYhIKQM7gKF5jW1T+ruu2IxFI1pwdE2+MsSNiXTnMTCxaHuC7PRsFacPD6GMEqqcd4wo2KZ8ibbdpHi8Te9rD8bgvSXAFSxqdr5aVMgxk2Vx9egYDgiVFAMDX1J+PhWhh7PSI7k8y1076AGQZ/vMXwSjva80/yw+Z3XYUgxfVg0k0mR1x6nDrwCCwoA15PgXXOMl86v3sqL7XZreuSV0JZumONBn7TKChuJ4UdId6bfjmxH9MqmWCdd855ymBiEg5pDSXSL8LJzIP4PgZ6vcVJKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7D1k15hVYSBGLlJVM0XBPTeQvG93C28OBveQ5tzoNw=;
 b=PI7rjC61i3PqTWGzz3jsR8D29vqdCqAV/hPeC5G6z1s06UCvJneHN2CzAZX0poV4IggGYfpW1AMCYt71dG1qzOGtmtgGgyaHgM3WWN25JyIQ2KUhUE1tnBz4ngguBW8P0+iJg6IrySa9rxDEB0eoIqvzZvPn3xEdiT5vnxhieuJiMRfm1Q1WVaVVgNgy5LsMtvvwDQMnnwC0CVs9BVfD5v6V0Q0ugqASBBG04DwkwBBm2E0nYzif3x1JajywOqgI7yaQLu55M666foTJ0skNV6osNJ9HhWToXXochzg3LL/MHC5IjnckEg/ecypGC6B/NbfHZ//DJCbM72ozQuKwQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7D1k15hVYSBGLlJVM0XBPTeQvG93C28OBveQ5tzoNw=;
 b=wfHf74zawrOiV6Orzhmq5yh5EjZ6w7oJBROL3SK8QVD0dIymImALdz6f+9XZW6xcfmOaRvM8MkOgxmLyn+v6z3QVN7MU2kffxzsBmgWRczM0h62FvMZWV8FijuSt3Uq31l5D8sbD0APxjkKUYQqRtMybrAYohrRP2iM+xU0+M/4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5570.namprd10.prod.outlook.com (2603:10b6:303:145::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 14:34:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 14:34:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "cgel.zte@gmail.com" <cgel.zte@gmail.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] NFSD: remove redundant variable status
Thread-Topic: [PATCH linux-next] NFSD: remove redundant variable status
Thread-Index: AQHYvUTILtNEN+DAvUKXygdP6dpSma3JEwuA
Date:   Wed, 31 Aug 2022 14:34:36 +0000
Message-ID: <A854F8D3-3FB3-4B64-9CE0-16FCAE3A7D22@oracle.com>
References: <20220831142002.304176-1-cui.jinpeng2@zte.com.cn>
In-Reply-To: <20220831142002.304176-1-cui.jinpeng2@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4ff0da3-0b56-45e9-a126-08da8b5dedbe
x-ms-traffictypediagnostic: CO6PR10MB5570:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YxVZuW91BGjY64MfF/r8x4wgy5NMNTE0t4zxSPv2MjPElXdhQLV2+FZ8EQJaVan25ftaP7HqG4ddD60lRYlhsz3BjRj3KQlpdgN3oflEsTDCFQiwWN1nv6clTeWqIA7cS94yujdBN3VHVThHQ4vvqzN7RzHBVMxzmvvMFR7xmTPjai2R/hTJ6gWiCr3C+26l84juYOXaOgTyT0zxbjwo3nczjv0FVrt1QqF0I9VHDY86s7OkQPkzYotqEF2KPkDODcItWDLIiUAu7/aCp1OjRUzS4xkird01l0UK7OJhpsxSpDJVdJlfUKjoBlmE9xE5eIgO9ujFvW973lIFmplah1rbj13vCRPMZtlt8UNaNL9s2CnKhqBPYIxXTiNBvqjln9Kly5+Z2w1g3qUfLd7T27WYGe7xlGe3yLjb9cdTGt4SnkWTkLsiQUNuLh4t1GbHbAtq2m69X5zMA+Nr2T2UZrtFQMXoiJ5Smf1eIGK1QaQ1EYWlOKu+Zkvz+ZttJzKNX94jPzOm24YgVBOpn+4GsHjr24YdWolSC8Gln5A2fwVhUtUGr0Th7rMYcYUMQa8WuhjSgCGRkE70E8UaLQbYEAJkIc7FaD7BMjp32ZPMg+MK8DAHYEQOO/e0zARF9oouXssb9wxESzUQNMpktlDqdeX3DDxC7brtJu0gSqt/bOl1DZclMiaZoH1DY9p/dGQxss9Y9IdxYhijdSDkaeZWeY9wmXorOzxw8AeWzkp2e6lxm3kN51/9rQhgYvKi47x3rFZe4TBWX623OsPJnFCHJ0B3A/HcHr9vmLERYWnIw8M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(396003)(376002)(136003)(346002)(2906002)(53546011)(66946007)(41300700001)(33656002)(8676002)(6486002)(91956017)(66446008)(6506007)(8936002)(4326008)(76116006)(66556008)(2616005)(5660300002)(83380400001)(64756008)(186003)(86362001)(478600001)(6512007)(26005)(66476007)(6916009)(38100700002)(122000001)(38070700005)(316002)(71200400001)(54906003)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N000BiiRl7HJ25YlY2s2KNULtQ/StoxQafua7UqKvHW6Pyomi5gnkHvHr+M8?=
 =?us-ascii?Q?nr3rUODO3b2Lqh6B0I1CtvOswFpxIAM62k00MO4QJCBD2EFon+6yC+kUG0G8?=
 =?us-ascii?Q?87NTfAGGHT8HfgvXlITUDHO8lphWlJ+L6005Cw+tzWZzPJial5ZNWANdiUHD?=
 =?us-ascii?Q?slN0OgaVYC4f2OVGIYDqeJsaD4mm42JNFf9QqXxujTukyouDRma+vkQD2QsF?=
 =?us-ascii?Q?C07V6lgL+YBmtFNkJYGLj0Oe+mCKxXy1i+Hx7jmYzgycuDOYmFMhZvtqMOcn?=
 =?us-ascii?Q?l+dMTWG1YDsJdlE78MUcsrheK87OEC1810o0tACE1UQbC3YgjtUXBWbKYoCT?=
 =?us-ascii?Q?lWmIX3KsotYAStQHbdtUWv/Piky4dnfmlQCi12AW058fHuQb/3UI8G4fX4zP?=
 =?us-ascii?Q?1nNMZl+WLec5t4yjyA79ZwHz/oB55jWJbO5l7vj2SzYxeqftsQzK+jm7PIpV?=
 =?us-ascii?Q?TZbD3kEF6qbC4/YnUgPbUou3vlSZUbrFvirYgQAyfFdCW/phXJlTwCYZLjn6?=
 =?us-ascii?Q?7QnZyRXRioWELsYocSxX/3DVpDpuaZcnJxEEzG6koO/ME2he1Jxa8Iuv6m64?=
 =?us-ascii?Q?yANL62GMFw7Rvq+qGx7Xro9x9VpQepOHiUF0PfsuuNIKwUFzAWnbnATNZ89M?=
 =?us-ascii?Q?+GsCX5LBD0ZxIbGBE7wRfTyUEhE3OPJcflcY9NQAc8sPzofQC2zhK23vfbGr?=
 =?us-ascii?Q?rpjeDWv//osyuh6iHaIvUPtQ/vBT4bGHTEMRz8VhNvuIHP+IZoakt6kNZV88?=
 =?us-ascii?Q?NDOpQvY4Kzli6yWb9+06hykvDBeB5M1F1J7aSCh+WFZ1KrHea6vpuX8mVnma?=
 =?us-ascii?Q?bKm1cMVfUz3vO3aANTLZfRpUzPcbeXzJ4oOpqtVM6+CKXAoSV5uf8ohzNhn3?=
 =?us-ascii?Q?ucthQuTwlPsxvYg4AsOzsIc2Bs1y54XQLoWpLP1cezydjZmBb0az9K4+pyIH?=
 =?us-ascii?Q?JpYKy7FKiltstQNX0dDT1fGZLQX4nGCq3Bbg3HCFxuEe4E2+Or1ZblMY+C6y?=
 =?us-ascii?Q?sS4R5d53bm83jqbxhMtJ4eYAFvZ2ND4YbuV4DMWuQ/9NgvYMAs1bjaSHndSI?=
 =?us-ascii?Q?cyE+7yluAAmcQ0rvy/qZshZTYSRICfsw2ldOG+leweLlFdbC/nNL939qrbqZ?=
 =?us-ascii?Q?+CgnInStdtTwmGWQRhJG4UB6gFM7f6XzUKCJPk6UBkj7pFM1WVrnrAZrLooj?=
 =?us-ascii?Q?9erWdc0iGe1yffZKuv1B8wtcY5J3C+JJ2ya2JBpa0syccNuHPbsFgBw6JIIS?=
 =?us-ascii?Q?/agrCFe3ww+BFZM5xobAGmr1qyZHb0wo2rgbqxjvSQEaaUf3Kn9P4XKPx6qK?=
 =?us-ascii?Q?J24T8vrKhb2Krofe7snx8MJSTeRBDt3S3fGYSE9qe1WMaGVB9uJNhASoaP2d?=
 =?us-ascii?Q?tqZ3J3clcTzBTVzupVUMAvgIcZ3s+sIWH3FDvI04mqMURRuL/KDUtf+hDle0?=
 =?us-ascii?Q?Q2C//nyu1pPFSNHmSzSEudOCI/gAT2H4NftSSnNusQ+N3pJ6vIWE1bO2mG0Z?=
 =?us-ascii?Q?LhZMrGbgO+DLVjLCEWqdeAwH/qHou2CkeyKEn7QhnSPtrz7Uahn0BK2K/EzT?=
 =?us-ascii?Q?pcfbbjg5kaeMX4meD3oFdoJrmbKuNCNIx3ee+X/WLZ1Y635tcUdoX2eq9EhI?=
 =?us-ascii?Q?Nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <605D035F6F4250468BC7F344B3F3AF3C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ff0da3-0b56-45e9-a126-08da8b5dedbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 14:34:36.2634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zAHLO6A7eQjfkr24Hij3275SEQzeh2plJBN74QpVY+SXaWR790XMZKXfoQSQMNeO+fP2hpSha2UIftjON/HBAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5570
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_09,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310073
X-Proofpoint-ORIG-GUID: NnfUDXJfmfUmW4iv4qpi5VItuVFKf3qY
X-Proofpoint-GUID: NnfUDXJfmfUmW4iv4qpi5VItuVFKf3qY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 31, 2022, at 10:20 AM, cgel.zte@gmail.com wrote:
>=20
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
>=20
> Return value directly from fh_verify() do_open_permission()
> exp_pseudoroot() instead of getting value from
> redundant variable status.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Applied for v6.1. Thanks!


> ---
> fs/nfsd/nfs4proc.c | 16 ++++------------
> 1 file changed, 4 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 757d8959f992..7055e1c91d0e 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -141,7 +141,6 @@ fh_dup2(struct svc_fh *dst, struct svc_fh *src)
> static __be32
> do_open_permission(struct svc_rqst *rqstp, struct svc_fh *current_fh, str=
uct nfsd4_open *open, int accmode)
> {
> -	__be32 status;
>=20
> 	if (open->op_truncate &&
> 		!(open->op_share_access & NFS4_SHARE_ACCESS_WRITE))
> @@ -156,9 +155,7 @@ do_open_permission(struct svc_rqst *rqstp, struct svc=
_fh *current_fh, struct nfs
> 	if (open->op_share_deny & NFS4_SHARE_DENY_READ)
> 		accmode |=3D NFSD_MAY_WRITE;
>=20
> -	status =3D fh_verify(rqstp, current_fh, S_IFREG, accmode);
> -
> -	return status;
> +	return fh_verify(rqstp, current_fh, S_IFREG, accmode);
> }
>=20
> static __be32 nfsd_check_obj_isreg(struct svc_fh *fh)
> @@ -454,7 +451,6 @@ static __be32
> do_open_fhandle(struct svc_rqst *rqstp, struct nfsd4_compound_state *csta=
te, struct nfsd4_open *open)
> {
> 	struct svc_fh *current_fh =3D &cstate->current_fh;
> -	__be32 status;
> 	int accmode =3D 0;
>=20
> 	/* We don't know the target directory, and therefore can not
> @@ -479,9 +475,7 @@ do_open_fhandle(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate, str
> 	if (open->op_claim_type =3D=3D NFS4_OPEN_CLAIM_DELEG_CUR_FH)
> 		accmode =3D NFSD_MAY_OWNER_OVERRIDE;
>=20
> -	status =3D do_open_permission(rqstp, current_fh, open, accmode);
> -
> -	return status;
> +	return do_open_permission(rqstp, current_fh, open, accmode);
> }
>=20
> static void
> @@ -668,11 +662,9 @@ static __be32
> nfsd4_putrootfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *csta=
te,
> 		union nfsd4_op_u *u)
> {
> -	__be32 status;
> -
> 	fh_put(&cstate->current_fh);
> -	status =3D exp_pseudoroot(rqstp, &cstate->current_fh);
> -	return status;
> +
> +	return exp_pseudoroot(rqstp, &cstate->current_fh);
> }
>=20
> static __be32
> --=20
> 2.25.1
>=20

--
Chuck Lever



