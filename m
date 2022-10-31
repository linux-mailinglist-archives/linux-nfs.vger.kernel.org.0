Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD04E613F61
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 22:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiJaVAu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 17:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJaVAt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 17:00:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E52412AF7
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 14:00:49 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VL0Vfo010690;
        Mon, 31 Oct 2022 21:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=P/Mi0OKH5aB/95tPEMPLWhp9xLKWe9YjpdKj2h25ABI=;
 b=woerFG8yYsdtqvdlpjly1QIoTQ8eGYJGqDJwm9F0nlARcYaQHnZMvHaj/nd6BRshSDDT
 ogQeOciiPi6LM+rGpgOijI1T1Tb2QJcjXZvEhs7m8eWpfyVfqoVNPFqp/wFUC5YbK8Vg
 7dm7VM+wyqUwoiYg7eZq+u5RbZ5QG15V6fR1prms0AruZs5V4mPFeQBubYBs1G3tUBRo
 sd6E3dc2ZxRKXH7gS0POOFwkW/wItcxR6Yegh13SgpdxMxnV7VRWHd8BHQW+yKNIpAzA
 emJ/xZMwew/PxhzFX6UP6700mBtAdeE0/YFdLh7EecWdhFBDQLPg0Tw/yfds4WYxkgb8 HA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgussn1qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 21:00:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VK6N4K032885;
        Mon, 31 Oct 2022 21:00:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm3prwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 21:00:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mod8S1JesbAVvLcogJ9m1mLNRHtUhSmI6gyZbQn5IMIf8ibLcHZBnTXcXX68ZnezHGXMDpg5Qyp9gtuYHL6wt5mstyVb1SE+Cyk4kHS6ZtG5Cba3nwc1M2mrOq7ENefQ5UjByf8zSCBUuVdgIIUgbnGcLCrr/0ci0avcfmCx3p0wfwFbdV5H/VzixENA4oKYnUW1rj0/Q6wlv4VhT7eQamDiNw9k+4G9lQ0Hz1gxsbTqeaRYJpll82ZgHhtvp4apay3flRcWcl0jglbcf3QTXxT497MRPwmAvEMwf5PmP3AA6z3HDBQnpNLgpu5f+z6Y5k3bsfmAkyI24la5ZXZY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/Mi0OKH5aB/95tPEMPLWhp9xLKWe9YjpdKj2h25ABI=;
 b=E1t43a+OsmcloHcAez39WA6Wh1S3ZxSansArDG7g2+fY+5WZ/z+xl+dQU7KwVh6X/mH9yQ1xN0QsWdsQwxjeBAXNejHlpWNQjuj2gtpaB0NjUhlToz15YWkxkb4Q1AcnSCgVMurvY6x8lqfrBONDaFaIS2PGl3/oSWny+B9j5Tktfn+MLzXcRQVEtMNO1TgsO8gT+qUmvitsXf+pVm/U+DXm3C9gMXxyJ+F1Z1M6GHdR6QRlDIiIZn/3xp6YU3IWdEIIl+NSIL2BSQ5+TkOxA+aXXCWOCvJAskXGswDKScOZGBXP/kic7AggcevByfXnsdC1Ju99D1aEp5PH/kKLTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/Mi0OKH5aB/95tPEMPLWhp9xLKWe9YjpdKj2h25ABI=;
 b=U/PJuTBIA8d1tGLUReXfMdC3UFj03T259VqfYDZYNp10r2YezdYo6KBauUa70F3R/b3gn3/Fg4hpmAJ8WmMmCHLqNllxwIlQJAsUHrp39swzskO4Y3ONO4NDY6yEB5ifxuXbVJOBx/4uxfAkMgK54RJ7njqgwY6DszVxXTZDTFY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6088.namprd10.prod.outlook.com (2603:10b6:8:8a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.19; Mon, 31 Oct 2022 21:00:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.021; Mon, 31 Oct 2022
 21:00:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] nfsd: start non-blocking writeback after adding
 nfsd_file to the LRU
Thread-Topic: [PATCH v4 5/5] nfsd: start non-blocking writeback after adding
 nfsd_file to the LRU
Thread-Index: AQHY7R03KN21kqk5ukm1fCsNXCWZkK4o/W6A
Date:   Mon, 31 Oct 2022 21:00:39 +0000
Message-ID: <3A83C32A-B851-49A5-8C6D-7CFB67B97136@oracle.com>
References: <20221031113742.26480-1-jlayton@kernel.org>
 <20221031113742.26480-6-jlayton@kernel.org>
In-Reply-To: <20221031113742.26480-6-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6088:EE_
x-ms-office365-filtering-correlation-id: 0f6f383d-ff5d-44e3-8534-08dabb82f736
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aPo4jIw+YSGC46Ns/+Ec7nE1GvH6eEBlD5RTIPDRdqiYKHxflFdVO0BiodQbdYvLAJRfif97cHGx212ywTZnFItSAntnCxLR4PWjc20vjnYlJkck0JhKaZi+6TK/rBPLPodgv4qulTR7Gm9SfPLUyhTPBx+WfHSf1YrZhFw0emDOsIdYB7M5wSzloLWbKfXtmYdxRNP4tyLutqjTI3IuLvEP+ZAkgjB6U3LgEOEONKttx609U3YY8hIH3W2X2m+TNtO83dmSLmEAsaU/Uj+gm4ZF/5xA0FDZVu3w72XE7wz3VVFwBHpJy92Tyd32BHpKL5LzlsNSCs7DtwJHzsXu/Gr9Ku9wAYnsYNWhCARxNDAzpqYplMiBHsv0e8pU76hzWGc4GyPJnKFH7OS3UDywKib64ZPyG8w1XRXYWr/DdTJkEUoAFEIeJIO6f5kmN3KlhjLXCDuv089dd19v9tQvf6JbPKDCyrR9dmMkITkHOO2ppkZBP+N0Nh4S8nT0dOIMehfLLS3uM+7wHu1gRzDerz9LQ3vOhvGoUK0e2EOQYf9KYi1IhmFvYuSNQIDLndFmUW3/hL1ke86hSmvjDqKNtK43ErcW4CDHkhmHF70Zbv67+58Y2dXyDnJ027ieHq/cn3ipCevTWLzRtkZAK86h0L72XNCr3Z8TKO6EdQ4314mwQG3Wo5XmJWLdopz/YS4oY+gxbIckR3KnqsaEsYTFkVjUlgy6ogtVqlH/wiK1bSB/S4Nv2aZodP2JUL6Np7IeW0F9NguLGfXRqLikS/RtWzhkUcGzJL/5P52CdWTONug=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199015)(5660300002)(86362001)(33656002)(2906002)(2616005)(26005)(53546011)(6506007)(6512007)(71200400001)(36756003)(478600001)(6486002)(186003)(83380400001)(66556008)(66476007)(66446008)(38100700002)(64756008)(66946007)(122000001)(91956017)(4326008)(66899015)(38070700005)(8676002)(76116006)(316002)(8936002)(54906003)(41300700001)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mBvQ1MfwFiVwbjINV6mKoNaNebBq4pRH3odIewj6uKyq0oE6QckV6UbLFGq8?=
 =?us-ascii?Q?wteAOPSy2qQLKkDha1wyh8C6N1Bmlnbgj7eqD+W4tUHQQYTAmv7rdd2gyf87?=
 =?us-ascii?Q?tjJoInsNU00KIM09RujvHxdPEaI6qeWwovY4VeIrEJ8fx2vJqI6nmTfGkncJ?=
 =?us-ascii?Q?Wpbq0lwJc9ueJURXnnkn4GqBJhXpffvJygbd7PHHb7KqQ5hAob9ZQXXeZpMr?=
 =?us-ascii?Q?7TbhKu5Mlm2Vk1+jTTrYMx9JklECMc7f5tRLJ7VUYTgmGCAo+kuMmIZcL6Qd?=
 =?us-ascii?Q?K6VdiIqq5bzB6NK+SEbQQDcSt1POv3f/1VSYvoPTSOIcgkNUOnRT1kzxnmgu?=
 =?us-ascii?Q?tbrDr7HCl//PyHvP2Mn4jGGNIXgagXvKFOYr9/wA3EbfWnk/HFOuoKienZP7?=
 =?us-ascii?Q?Yn9js3UK5wS/Rq9jiYz6+TjhStWV/xcqF+t6EjKAbomQSpQg1LAv+2i55Xbu?=
 =?us-ascii?Q?wkL00UnpiEFXXfYca6cYI58zzfzVN9vSlLy3GKsUOWeTw5rfMPrt+kkpG5rY?=
 =?us-ascii?Q?uFK+rLURZwQLDQRMiLniy9otIR7nmSxUkn6MntsuSg+TVytBJ61JjFuc96UD?=
 =?us-ascii?Q?VMQrcvM25sd69vzo7uh8rQkqacj0FC3O16BdxrY4oTD2sCdHaEy79xmkNQsi?=
 =?us-ascii?Q?BdL4vsUj3TvBaKyrKW6175dlcOkzhiG1PCF8Pa4X5ikEjnvJZ4/aPlEGQvTu?=
 =?us-ascii?Q?K7oewMzk0ZVanNRYGiq/zFODCVwNeb4YY0JESacp4iRwY/4DuyjgM1qtQyTQ?=
 =?us-ascii?Q?zpzk90g9VRq7fHSHMF8AXxvnRkKDWP3YjITWp5ZxizVFoV14CONyKI6mL1t7?=
 =?us-ascii?Q?3PsncjqKECJVy/VqZSvCn+/7DL417gt1u67VQpNtyI+pUvu7OIItbNMgXLz4?=
 =?us-ascii?Q?FsRAbJzZEQKSXwApoBDBTSZhbmGhmcrPbBBwGle4gey8HmnxIqGsOMPdQsjY?=
 =?us-ascii?Q?vFYk2e8rBWvTxi21r3jhCpiwVJWuLhErZxBxQCe/SeoxthAVV8hF28EcsikR?=
 =?us-ascii?Q?fYeW97I1kYQ87zdR2QsVeXBCuBTiubwkewxvFFY2rPooc2RCMq2zOZYewAzG?=
 =?us-ascii?Q?DnADuStzwxu+ytXImUIvpj6PWQ6AqwHBHew+syu+M4AZZ2R1M+TzIoeaadZW?=
 =?us-ascii?Q?u3cHszjsAgcDipKK2B9VpKzihj1YlZcZX2ZKsHlwVvLSp40fHWDBIPCnsj/s?=
 =?us-ascii?Q?xKOm4yc4jx4rQsMKCqJMe2u3+ELkaPU46aTsuduNu/VDftzTJztlpr3ADGlI?=
 =?us-ascii?Q?xeqAgmKGXUvgJQcp7+NWf27C1jk+FT6wML/gVxr4c2jeizNKRkANsHP2o4mG?=
 =?us-ascii?Q?0uThdEx+IWclG9nUxj2cVuaOmL5oz8XqRfbnEViFOOlYgQaBqN0wRpGleVFV?=
 =?us-ascii?Q?YwsdyHgSv6keMkFRhjG0pfgTrv0DUbPn36jY+q0jQSVHMEUadsh4qq2yF9BO?=
 =?us-ascii?Q?d/+dN+mQOjGzQExg4KMMd7Sa4Chqftr7T6avgG5NRcYR7H9Po0pRasPdp8xY?=
 =?us-ascii?Q?Yv51tTiknftoQixVnr2s0kxVsQPKkCF3j63tSyTvEabonAPgqXClkuVUjGNC?=
 =?us-ascii?Q?s6WMA1Lknx4m9oeky+mazCbbQVTNBU4DK0utZgGbtQ2Ghq2mzqAuD4ELIsgO?=
 =?us-ascii?Q?MQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5ACA2CC4F9C7A348AE41B41E7488B3FE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6f383d-ff5d-44e3-8534-08dabb82f736
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 21:00:39.3410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c7r6K84FuePBf4uWI/TYEE54mLzu0Yt/uTlC1jpQ9pHhG3I8jae+tVc6EPSvc+2mKFwOwazNy/XgTFx2nysfgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_21,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=791
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310130
X-Proofpoint-ORIG-GUID: B05VklVElL1YugCjkRwtvlOF6SW58oA8
X-Proofpoint-GUID: B05VklVElL1YugCjkRwtvlOF6SW58oA8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 31, 2022, at 7:37 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> When a GC entry gets added to the LRU, kick off SYNC_NONE writeback
> so that we can be ready to close it when the time comes. This should
> help minimize delays when freeing objects reaped from the LRU.

Tested against a btrfs export.

So, the current code does indeed do a synchronous fsync when
garbage collecting files (via nfsd_file_delayed_close()).
That indicates that it's at least safe to do, and 3/5 isn't
changing the safety of the filecache by moving the vfs_fsync()
call into nfsd_file_free(). These calls take between 10 and
20 milliseconds each.

But I see the filemap_flush() call added here taking dozens of
milliseconds on my system for large files. This is done before
the WRITE reply is sent to the client, so it adds significant
latency to large UNSTABLE WRITEs. In the current code, the
vfs_fsync() in nfsd_file_put() does not seem to fire except in
very rare circumstances, so it doesn't seem to have much if any
impact.

My scalability concerns therefore are with code that pre-dates
this patch series. I can deal with that later in a separate
series. Do we need to keep this one?


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 23 +++++++++++++++++++++--
> 1 file changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 47cdc6129a7b..c43b6cff03e2 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -325,6 +325,20 @@ nfsd_file_fsync(struct nfsd_file *nf)
> 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> }
>=20
> +static void
> +nfsd_file_flush(struct nfsd_file *nf)
> +{
> +	struct file *file =3D nf->nf_file;
> +	struct address_space *mapping;
> +
> +	if (!file || !(file->f_mode & FMODE_WRITE))
> +		return;
> +
> +	mapping =3D file->f_mapping;
> +	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
> +		filemap_flush(mapping);
> +}
> +
> static int
> nfsd_file_check_write_error(struct nfsd_file *nf)
> {
> @@ -484,9 +498,14 @@ nfsd_file_put(struct nfsd_file *nf)
>=20
> 		/* Try to add it to the LRU.  If that fails, decrement. */
> 		if (nfsd_file_lru_add(nf)) {
> -			/* If it's still hashed, we're done */
> -			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
> +			/*
> +			 * If it's still hashed, we can just return now,
> +			 * after kicking off SYNC_NONE writeback.
> +			 */
> +			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> +				nfsd_file_flush(nf);
> 				return;
> +			}
>=20
> 			/*
> 			 * We're racing with unhashing, so try to remove it from
> --=20
> 2.38.1
>=20

--
Chuck Lever



