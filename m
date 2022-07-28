Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD45584262
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 16:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbiG1O4c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 10:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiG1O4R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 10:56:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADB570E70
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 07:54:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SD38js008461;
        Thu, 28 Jul 2022 14:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KCcXGW4eZYWOMnzeg6E8l/zFqmhc5wBttr+JOrZBL5I=;
 b=Pg+5CRo1DxyRKcrbEzjsaVz0I3meQNdElb4LriiVExXxqwlpcRmw9JAlgXBQa1SQDUao
 HxndS688OsTwD8IuRs/UaeFkKzDTzQFYZiSGBc8t4YeQHUDmyUJCOXcRCBW+dEHkgdKq
 5zFwOYEf9hnBzJnXiIQIgcVb7uPuigAda1FVU3qpRz5JGj91Gbe8nhm071AREq7VOuRO
 ZDFMgYskBfbrsFMKpuBpHkYku74gkx1TsWEZEI3JQNoN0lD0HpDyvF7q8VnFGEexgYyH
 TFjGOnoGygOd/HxDbgGBhI80N+fjFgcVAPZK2Jz/LQgyYohgkp1bv5pcqKEreyW3nbkF wA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a9mvxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 14:54:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26SDqxQU023074;
        Thu, 28 Jul 2022 14:54:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh5yxmatr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 14:54:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQeCjjnmQQLo98KltN9SaGIZDi83wjncr1z7W+25NJ9uz28AZHV/hnyDQ0oNGqfWp3ZSblRpnnzXrIO0M1oYPfemIzWaD+oYeG4e+QAmWVLEg/+iGKWL05KWyspXo7+c/Iun4zd7JAFaBsc1j7PC9P9jIgVFMbsvq+uGHVm/nNPlbch08Z5fm/x1lkNSt2qFv10mJLGtaeo+VkjEWShRjwUkc3YIhIxSa1BK1Yic+h+JPIZXQb6c5fD2QJiGGybFTvRwCTJfQd7QoOHDpSZOj3TY91YVJ/25gFtwcsdFAYYuUB2XIBvw7umzGfwm3QJqx23tIjkaA6F+P33f6afaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCcXGW4eZYWOMnzeg6E8l/zFqmhc5wBttr+JOrZBL5I=;
 b=KOGPUB2gWi/KfjBo9xkzEX1qUMEEiHV50A7BWOmf6Pfbm+RkOQr2wSgW+kVBPzJZGFFSfipuRVJal64UypcRV5pTDQJnn9gkdgBe5U6jA/RxoPHTWilm9zlaETup8phFcTVkMB5bqNLSGQDMSGOG822+8Hyhgz+lFykUfJiSi22n0OAMlcOJIeZYqiO59lxcoOzdqV4/ZCHvVZ6aZcoUKV/IpEgVR+B+K0fm4hkPY2nzDz+Z+EfitcaGYqusE+lzLoKMyQS2NAbZkn8gTHtXN4MO7VcGKoSJRD9sjOT3yh358AOZdZArc5FMcKEcVxK3feYha106AWwkPkdIEj8vtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCcXGW4eZYWOMnzeg6E8l/zFqmhc5wBttr+JOrZBL5I=;
 b=TQFIVz79UPiNZ8Yr2nh01zXDjwnoJ3LjsmS4Lh0VQyYq6UJJR+7gYNSvndI5kcMApZnxgXvbtkf/W3wzRxeA80XUCIjhCqZIRWhRf6+O3E4N4STjQy0GjCCqlwaZtAynNwW17ybuIl6cr5e/2gCot3C4WkpnZ4CuFeP2H7zBJM4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4593.namprd10.prod.outlook.com (2603:10b6:303:91::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 14:54:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%9]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 14:54:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 10/13] NFSD: reduce locking in nfsd_lookup()
Thread-Topic: [PATCH 10/13] NFSD: reduce locking in nfsd_lookup()
Thread-Index: AQHYohNW0Dk29eHwp0mjhA2rghjzS62T37CA
Date:   Thu, 28 Jul 2022 14:54:22 +0000
Message-ID: <5C349BAC-D552-4809-B88D-337109CCEACA@oracle.com>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
 <165881793059.21666.657711087588520392.stgit@noble.brown>
In-Reply-To: <165881793059.21666.657711087588520392.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d607472e-7df8-435a-a4c1-08da70a90e7c
x-ms-traffictypediagnostic: CO1PR10MB4593:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: USTG4zXvX0aTN8Y8uaTl7G7cXe2Tbjm3OsPKj5OoNM/hKIhsqSJTQNnF7Prtf5T1jVkLOB+TNVEor388xSvbuSxenLSRv5EwrG5Sol/vov+DyWAhFlModARjTN8XZ7MC8k67yVNG6Uy4n9KODsBbJnQQkJoi4nJ+/O/FoaJF893bQdUy7rt6SnxZGG95jKraqQ/YUQP9uC0e+XK8gBHFOCSR1ZLFfIhg+IAZG2HcT4Dwe64R+ublvw9u8jMWqPFAjVE88WKgeddqxfmp8LNZDi3KavTA/1G/ti7jb8eSQbSpbngVc/OAqVEAXbjjEwhnzKbg/5z+ENPMXfXDW7Fa35dxbRJsB3H+zyP+cv+szCxroq/Fs17tyGciFQaJ+54WEuIGVc+osN7Cn5DJUMUukMNyKGrDL9WV9dqbKAsR6MdlpPmMyJIBBR3oXZ4bIFzXQIWIrjGWFSdLsE1sVKTKKZrxx0quZvtyuMLV42l9IC1Y6Aw2zJgvBOSOxJcpP6PRWiUDKN3UmaJ2sbC4vUKZ40IP7ruLlMEzBoikDAYveYmNdeGgPfwyUGrdr24nXEuwV8MK55YBRfZdbEHWhcXVS9uaDMTepcZPVsbQ/zVofzgqIrgz9//fRvPJwjev3rxTwmvRLUR7YePI7r1HGiLtMzsjrXvtpPWTiAeLKLyHI1Ki4z4nAyy4D0EjtBjw6kP9C0s268+UnBy0Y6Mc1KgVRp21Jm5T53sJYBatIXtHBupiu0JqcGf77v/pf9JlSR253K1u0iTaduUoR/cMwdffX/TWPb1bwx4kfPQii16ApJfPTUkaHGcZ4dPF9Q2vnLpbTtlXegqDavNNziRnR3H4Bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(136003)(396003)(366004)(4326008)(66476007)(478600001)(41300700001)(71200400001)(53546011)(26005)(6486002)(6512007)(64756008)(6506007)(8676002)(66446008)(38070700005)(86362001)(38100700002)(83380400001)(2616005)(186003)(122000001)(8936002)(5660300002)(2906002)(36756003)(6916009)(66556008)(33656002)(54906003)(316002)(91956017)(66946007)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wKo50aRRgti00LNfKOjgH7YhR83ayvK7qq+tLT4YKRcmZwtvXPQj4dR2tEvR?=
 =?us-ascii?Q?0seOJUer7QFgw4yKRN7+hfDGlDUkiZteMn/60B4V7UStEHjjzKmT9R8jDZlv?=
 =?us-ascii?Q?88seBdQ/nBzr9PJ2Oo229NlUm6VufqiLCxyosBdq7Z4oTOFrphYMBRtb2Yun?=
 =?us-ascii?Q?h25PjTc08AUhz2gOXYWlutMG9fKhz9/W1806qlI+WoJroN+GpAhmcvmznSe4?=
 =?us-ascii?Q?r5VXpVm9+K5CQ/RWZU/C8vhQ9JqSR3Y0ta8g4lUGzip2zsIveU++s9UKdHT+?=
 =?us-ascii?Q?/DIix+xQW+Di9UkDs6sXZ5CrybdOVvrCAtVUXifJlQZQmBjMA4ZM7O+wnps1?=
 =?us-ascii?Q?aiYkNW3+N8Aoaws7GbdyldF4BuqIQpmR5BGFxxcHUppz0DD4iO7GEDhknkzv?=
 =?us-ascii?Q?OQ0qk20bCDeC+9kSFUPeSxhuf0VqotoDlsYKox8RLO49NN6Nrfn4xZhwJNNX?=
 =?us-ascii?Q?dU9aWBwj66z2oCioJonvhJdGJB5OB5JU7z3DX64pR2WORFjN0+y0wRM4Ztd/?=
 =?us-ascii?Q?XCdkayhY4FMED4/SECWrPR2x7hvNS1ZyThn+DVBpA16+QtHxxfBdhycJchIN?=
 =?us-ascii?Q?nlt4qQZ45zGToNjyWSwNBDVl5uMDMazS1YQzhs3XgglQy29A4u3BdRaEpwiq?=
 =?us-ascii?Q?dH0y6udM/cCcqxrUxPsk3F9+lO3ko6vnYO/Bp/95gNy26UmEkSm0TgAaVvZW?=
 =?us-ascii?Q?MSji/ihzD1EBP1Zvo01XSfYybKruWVMYSnT7PCrxnGPplvWg/ne9IdSyyQGM?=
 =?us-ascii?Q?n0d0hn0PW/1NsD//749WIRk474ru8+DLNF4WCDR8e865nSCS+aR4oxCJ4Wh7?=
 =?us-ascii?Q?xZbW48fF7dsJfxAcP0BpO8+pab8Nm9G+8z3LJtYt593XUPJnzJ3ndqdDuYa0?=
 =?us-ascii?Q?vl85O3KynQ0AncpxgKBrGd1ijZBu+t5ZiptryThfrjhDDqOnSgNHzJGOJFZ8?=
 =?us-ascii?Q?smw5SDa0FbfB16yUE7sYbocXOpN4Gx4Af2fubUaTDVXSF1O73PN1uAkO+x44?=
 =?us-ascii?Q?ph9h2Y3+gNHmcwvNfYzT7GIxAUYZyalAq1eN/ex9PFJbTsyJqd+5m/rjWH+V?=
 =?us-ascii?Q?4ViJR99JiofWGktZJ+4Ovy04/UMWN8CxV5A3YrEm2sAfagYJNuphqp3xVNT8?=
 =?us-ascii?Q?9LohztxWNUzZQzoLaVz7SbgBcvn/GXzviyJDlg7RRyMCXIztdDgvsD+p9OHQ?=
 =?us-ascii?Q?l5U6FkFnbI7o0A42m3/hdiPaqNzhT+4p01Z7392fqhgb+0XMYui3jNFq3Fj1?=
 =?us-ascii?Q?DshqXDqT0/6nr5RsxZSvM4zAbbwYZkS2+3drWf3tvN41AM0EoM/tRRZzCFO6?=
 =?us-ascii?Q?Bb8oWg6y/fYcLJxzMY6s6QoZvVBNw99pIAn2cE3TObERhTz676Kiis+fT1GI?=
 =?us-ascii?Q?6JlnPxac0EOGNA/Ny8MEK4EUyidUIoy3QPG8/rmDXQ7d0wBzaCW4/dl+EMyY?=
 =?us-ascii?Q?pxUuSiLQpWxwcAF9e2ByLn10svvqYrazycYNGOF0/za+RfW9mazPITmXZmv2?=
 =?us-ascii?Q?FABLOQ8M0O3SSy4ulwdAZVsKw/Rw/EVssIWSX1ykJnTiwlOKvgACgIEefvhI?=
 =?us-ascii?Q?Bs1jCU6WVpLUfWgnWioNgQFJDZHmUCtufrMTuFBwq386zgNdh6tkJmcXjT2a?=
 =?us-ascii?Q?MA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65AE80C827E22A4CAD6B5D1D1C99DDDD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d607472e-7df8-435a-a4c1-08da70a90e7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 14:54:22.0867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fdciejS2zqQXT3r696948tVG0GwZX5rzaZf9r4vAqN5QNKGg7hTzrabZfTtazXUPgH9BH/BjMhDieoEFLDy+Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280068
X-Proofpoint-GUID: JbU2kZG0CL9BwOTaWuIZxMhGqwytTT1g
X-Proofpoint-ORIG-GUID: JbU2kZG0CL9BwOTaWuIZxMhGqwytTT1g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 26, 2022, at 2:45 AM, NeilBrown <neilb@suse.de> wrote:
>=20
> nfsd_lookup() takes an exclusive lock on the parent inode, but no
> callers want the lock and it may not be needed at all if the
> result is in the dcache.
>=20
> Change nfsd_lookup_dentry() to not take the lock, and call
> lookup_one_len_locked() which takes lock only if needed.
>=20
> nfsd4_open() currently expects the lock to still be held, but that isn't
> necessary as nfsd_validate_delegated_dentry() provides required
> guarantees without the lock.
>=20
> NOTE: NFSv4 requires directory changeinfo for OPEN even when a create
>  wasn't requested and no change happened.  Now that nfsd_lookup()
>  doesn't use fh_lock(), we need to explicitly fill the attributes
>  when no create happens.  A new fh_fill_both_attrs() is provided
>  for that task.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> fs/nfsd/nfs4proc.c  |   20 ++++++++++++--------
> fs/nfsd/nfs4state.c |    3 ---
> fs/nfsd/nfsfh.c     |   19 +++++++++++++++++++
> fs/nfsd/nfsfh.h     |    2 +-
> fs/nfsd/vfs.c       |   34 ++++++++++++++--------------------
> 5 files changed, 46 insertions(+), 32 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 1aa6ae4ec2f5..48e4efb39a9c 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -302,6 +302,11 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
> 	if (d_really_is_positive(child)) {
> 		status =3D nfs_ok;
>=20
> +		/* NFSv4 protocol requires change attributes even though
> +		 * no change happened.
> +		 */
> +		fh_fill_both_attrs(fhp);
> +
> 		switch (open->op_createmode) {
> 		case NFS4_CREATE_UNCHECKED:
> 			if (!d_is_reg(child))
> @@ -417,15 +422,15 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4=
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
> -		 */
> +	} else {
> 		status =3D nfsd_lookup(rqstp, current_fh,
> 				     open->op_fname, open->op_fnamelen, *resfh);
> +		if (!status)
> +			/* NFSv4 protocol requires change attributes even though
> +			 * no change happened.
> +			 */
> +			fh_fill_both_attrs(current_fh);
> +	}
> 	if (status)
> 		goto out;
> 	status =3D nfsd_check_obj_isreg(*resfh);
> @@ -1043,7 +1048,6 @@ nfsd4_secinfo(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
> 				    &exp, &dentry);
> 	if (err)
> 		return err;
> -	fh_unlock(&cstate->current_fh);
> 	if (d_really_is_negative(dentry)) {
> 		exp_put(exp);
> 		err =3D nfserr_noent;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c2ca37d0a616..45df1e85ff32 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5304,9 +5304,6 @@ nfsd4_verify_deleg_dentry(struct nfsd4_open *open, =
struct nfs4_file *fp,
> 	struct dentry *child;
> 	__be32 err;
>=20
> -	/* parent may already be locked, and it may get unlocked by
> -	 * this call, but that is safe.
> -	 */
> 	err =3D nfsd_lookup_dentry(open->op_rqstp, parent,
> 				 open->op_fname, open->op_fnamelen,
> 				 &exp, &child);
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 5e2ed4b2a925..cd2946a88d72 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -672,6 +672,25 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
> 			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
> }
>=20
> +/**
> + * fh_fill_both_attrs - Fill pre-op and post-op attributes
> + * @fhp: file handle to be updated
> + *
> + * This is used when the directory wasn't changed, but wcc attributes
> + * are needed anyway.
> + */
> +void fh_fill_both_attrs(struct svc_fh *fhp)
> +{
> +	fh_fill_post_attrs(fhp);
> +	if (!fhp->fh_post_saved)
> +		return;
> +	fhp->fh_pre_change =3D fhp->fh_post_change;
> +	fhp->fh_pre_mtime =3D fhp->fh_post_attr.mtime;
> +	fhp->fh_pre_ctime =3D fhp->fh_post_attr.ctime;
> +	fhp->fh_pre_size =3D fhp->fh_post_attr.size;
> +	fhp->fh_pre_saved =3D true;
> +}
> +
> /*
>  * Release a file handle.
>  */
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index fb9d358a267e..28a4f9a94e2c 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -322,7 +322,7 @@ static inline u64 nfsd4_change_attribute(struct kstat=
 *stat,
>=20
> extern void fh_fill_pre_attrs(struct svc_fh *fhp);
> extern void fh_fill_post_attrs(struct svc_fh *fhp);
> -
> +extern void fh_fill_both_attrs(struct svc_fh *fhp);
>=20
> /*
>  * Lock a file handle/inode
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 06b1408db08b..8ebad4a99552 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -199,27 +199,13 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct s=
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
> +		dentry =3D lookup_one_len_unlocked(name, dparent, len);
> 		host_err =3D PTR_ERR(dentry);
> 		if (IS_ERR(dentry))
> 			goto out_nfserr;
> 		if (nfsd_mountpoint(dentry, exp)) {
> -			/*
> -			 * We don't need the i_mutex after all.  It's
> -			 * still possible we could open this (regular
> -			 * files can be mountpoints too), but the
> -			 * i_mutex is just there to prevent renames of
> -			 * something that we might be about to delegate,
> -			 * and a mountpoint won't be renamed:
> -			 */
> -			fh_unlock(fhp);
> -			if ((host_err =3D nfsd_cross_mnt(rqstp, &dentry, &exp))) {
> +			host_err =3D nfsd_cross_mnt(rqstp, &dentry, &exp);
> +			if (host_err) {
> 				dput(dentry);
> 				goto out_nfserr;
> 			}
> @@ -234,7 +220,15 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct sv=
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

/home/cel/src/linux/klimt/fs/nfsd/vfs.c:246: warning: Function parameter or=
 member 'fhp' not described in 'nfsd_lookup'
/home/cel/src/linux/klimt/fs/nfsd/vfs.c:246: warning: Excess function param=
eter 'ftp' description in 'nfsd_lookup'


> + * @name:    the component name, or %NULL to look up parent
> + * @len:     length of name to examine
> + * @resfh:   pointer to pre-initialised filehandle to hold result.
> + *
>  * Look up one component of a pathname.
>  * N.B. After this call _both_ fhp and resfh need an fh_put
>  *
> @@ -244,11 +238,11 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
>  * returned. Otherwise the covered directory is returned.
>  * NOTE: this mountpoint crossing is not supported properly by all
>  *   clients and is explicitly disallowed for NFSv3
> - *      NeilBrown <neilb@cse.unsw.edu.au>
> + *
>  */
> __be32
> nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
> -				unsigned int len, struct svc_fh *resfh)
> +	    unsigned int len, struct svc_fh *resfh)
> {
> 	struct svc_export	*exp;
> 	struct dentry		*dentry;
>=20
>=20

--
Chuck Lever



