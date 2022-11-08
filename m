Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D4F6219D4
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Nov 2022 17:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbiKHQxV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Nov 2022 11:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiKHQxV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Nov 2022 11:53:21 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE21857B50
        for <linux-nfs@vger.kernel.org>; Tue,  8 Nov 2022 08:53:19 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8Gl1MF013716;
        Tue, 8 Nov 2022 16:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=WglwFPyjDAxReilsZUVJWB3vFJPwAnuhYZk/IlIbHhA=;
 b=IEHuOn0tmFlQqgnHg6CTuG17LrwvWNHu8CWmwgE31e7pXmyVJevuMNAVjLRgkQgr9dz8
 Kx7Y8d+Jq9KGCrTHWkSmG90tBPQxBmirxKaY0E+ZqI8qaJ0ePmHCsPrW90/CwI/fs1kh
 VfKgRPyIuCfSZ9CTSupkkphbYmbX5EE3X/bYGMD0dchsILKgGOfyQ9czq9jwJEQDVJiy
 eov18xUdJW2fFKosLC6j6EixCQsWwNgxNIvGUzXQL8zOTKelC4YYQUhOBCBWDeWjof8o
 whFmk7BHXsc4nklhcfTAUPLAuzVc/wIqr73GTt0aG0rIyr3vFes4V2KOlufMeSHoxXUL EQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kqtxeg134-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 16:53:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8GcFlQ000385;
        Tue, 8 Nov 2022 16:39:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcsdp131-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 16:39:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mw7TCjWWgmvF7JuuX+J40OALCxR7IbmemUW2GI9cJJIbJULOFr2/aprRLUexDhhTo8ZGmKbBGe9L0DYb/KwA3mMuaeP9RV+dfw5UQmPWB6pXS0xJAI2YR7pxhKEszeuLREE+qM2WeB2rPjEplzl23LFtoQzd+tMjf71QyCkdZ9c9FyRXYWDYdtlEhYaOR4Ir3ihlMnsXZScaxafr/B2Bf4ns2ptDO4OfI8vwFkgDcfJR/8CIyd21zs+VmYFr8pnZiP7e6ccIoYaaYLev68Il635BiPoJ0gTFvhcbB5Mfe5vKWiOPpzCZayLo/QCwDjQHUZA+FpoyXEw7c9FhV7eyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WglwFPyjDAxReilsZUVJWB3vFJPwAnuhYZk/IlIbHhA=;
 b=X6hLIdyUC0C202W+fy1miyzAmeX/rWGsH4cLqDIho2ywspFz3F9KOjARB2aea3XLWDI5dWKwgHPOqsE6O44qWOYRdp+Nr4JiTI4q1caTNkeWHyczssaQ4CtsXCjV4Zp+beJPj0r3UVUqDR3EUPovD/QrTMyxlCy3l2aNH9YF1Z7DSIlTg0pzcE4AFPtTN+Zzeb3zCZmljt6f1e9j8WFF81b01b5Q3Xzgz1j1UsgGToG8B/rAABFhA6xWRfwHPGDokTH9zIeugA47pA9yz4Ml4wwAWy0otqNAIrc3obASN8X+grJYmmHAxqBGMh+VQ95soyY7EEYf+UIzFNyId7K5fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WglwFPyjDAxReilsZUVJWB3vFJPwAnuhYZk/IlIbHhA=;
 b=VWNN7CvYBC+FaR6Bd3LsJ4B13QNQeZFAuuy21nr0zCo8o8XiLCZ+B3ct+qat4OtIw+xG8QMDaOnPdja9Jk9u7LGQDgLG9X/9gLSIKZnOfNdTFJ69CQCtHi9buVf9Ds9UCJ0GFhm5mVtO2rCT8OBCcTvVHxgbStfpPn6+Yt1O27o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB6960.namprd10.prod.outlook.com (2603:10b6:510:26e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 16:39:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 16:39:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Yongcheng Yang <yoyang@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: put the export reference in
 nfsd4_verify_deleg_dentry
Thread-Topic: [PATCH] nfsd: put the export reference in
 nfsd4_verify_deleg_dentry
Thread-Index: AQHY845pDsdDj46Z8UGbnOuwZh9Al641OkwA
Date:   Tue, 8 Nov 2022 16:39:44 +0000
Message-ID: <A91EAEB8-4EDE-4AEE-AA5A-6DBBE6AA6866@oracle.com>
References: <20221108162311.320755-1-jlayton@kernel.org>
In-Reply-To: <20221108162311.320755-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB6960:EE_
x-ms-office365-filtering-correlation-id: 2d4c623e-370e-447f-1d1b-08dac1a7d78f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZQtPCHntF+U+NOkcwiEBKFgIquRGL0NSms1qgzXNkW32H6tkf1BU2chzzMCujNFd9EZYC/40zRyGjywp+ibb9GauwWvzhc5i85b0SKGKR86EIqkaUeJOxfUetIBvuzkzniAA+xDLZl+ip/7txrD79fulBFvbRlzQyi7TqXtU+QIHRD0u2QaAvY8yQrLmTsuEQxn+V4u9QQDv+AwW5wV9e3J7NdwDfh9aWSoNAVDXNVcR5EUMOBkIrLKEcQU4Bx4ltf/pgAyVIkpRfMNt/RVUHC8cS8g+c5GqG+aeJwTbBzWNOERfOQlgCvA7mqrZ62dELQNdRooDsWvr64gIgvv3usYun81OlGS6VeN7JDXHEWL5omGXirpy6uLFQGxNQ+4g8tQScWTQC9HVYgYvE8VF0I+h8YamtrM0nv9/x6wqqdxs+Yi/NZfk4eq2XFQbqnOMJHcyMeeu8GYrOW0D+nsDeVAfppJAZQCiEWZ+xKP45+8VHnZsODdPKHiAwMY2vp2i0TftMF/N6qgaGp9M2an32dQavgEXtJkhu6aqVdZQ6y3nMzoMJqov/hU+aqJOankoEzXQ9cLvvd5UO2CffQAxeCQz7HLGy+xl6v+pSeZQQWgwQY+mCSTpCUbX1JhNUSS0q56m93LmXq5vD5kACL880cPOTueB2EPGZTpAnlOznxBWzB4lT+NPdM4nUQ5wV9Ty+Aq1QS2neLaXn4bNWCoFmuuy6TqulHaANjAXVznuvxcfZK2NNMTHJr1N0j1BPkRKGf/OuTU44PNjPPO7miNAt9uIHd5xMdYu6GfOBexQyLUsFQQdEfkRREUha5L9XgESb5BfFVdmvpNeFcVYPQ9Zrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199015)(2616005)(186003)(83380400001)(86362001)(110136005)(316002)(33656002)(122000001)(38100700002)(38070700005)(36756003)(41300700001)(6512007)(6506007)(26005)(53546011)(76116006)(6486002)(66476007)(66556008)(5660300002)(8936002)(966005)(4744005)(2906002)(66946007)(478600001)(8676002)(4326008)(66446008)(64756008)(91956017)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/gmRFuUkksTE0YRjRzHpcEiT+SEhp+DEEI0v2xcTBpGeEL2vQuxrrjZ7T3tB?=
 =?us-ascii?Q?p5iAW71fVtc8fKgvFxcrg62MghynvsjBNpOqAShRvQiDkAxQMlprDURB2XHB?=
 =?us-ascii?Q?/imKKIiNRAtWOP7YekJ3mRpi5n89IgKgaqOGRwujfILmBEDPvaJSUICWtTsm?=
 =?us-ascii?Q?o1pqMh6S4tW5fCGfr6lvF8HfQjl2wtH/txjgRfA291Wmq8Au0O0hC7UQbVkW?=
 =?us-ascii?Q?UdIYA7wYQwEz9uH476Np2LHXDr679hfjW+CuBsCDEJvWmjqfx2s+Gz7jOOyt?=
 =?us-ascii?Q?NkCuw3iyivAbxbtEd54bgHdj/KnzQwZDwMMRMm/E+RYm9AuKDAnDTLS5nZmn?=
 =?us-ascii?Q?G6LBhe2A49jKWvbd7nzA09Ov4JtpM4Jmk2G7MGqL4xeeLNfCEnsKxJUBacgy?=
 =?us-ascii?Q?XZMZpspT3kcfFm7HyWWPy+eVoQMnmB0yIcGw+p6st5zp+Rq6gC6zB6ohKhg3?=
 =?us-ascii?Q?Aku9gmRFpyP8gpSeB/tms+LOgpGPXBuwfX7qlZ07hyKWux235PqXwIKsqANO?=
 =?us-ascii?Q?joiib4DklSdOr7ZGRDyhVf//qGwljAlO9+F9pjCXoOAq8qhjpydLq403m9P2?=
 =?us-ascii?Q?1Wr9I4cqxEdN53GhRfA37pA5bW4KoN/gHbidLxsOuF1szJqxprJxLJSwwsJU?=
 =?us-ascii?Q?UV6MyQmbkWY2ioyLgHp31exjlsU32nLYwGZgBs+h39IapTETgsHH2lEB4DbH?=
 =?us-ascii?Q?xdi0GIztJeJw4WmLDE7HgifhoJUuGE1m0kyP1BSFq+ZpVBd8dvBP0YkWp1/C?=
 =?us-ascii?Q?c+zI/OEveOwMb71k+gj+dsBMEOqj0gBqtWfnfxV76VcLtUy9DRbenvASb+GD?=
 =?us-ascii?Q?E0vt96t/vRk+eWkNhGugbuIC+cOH7gOfNISVkhBKeKOCBqmMhz813iycnMLm?=
 =?us-ascii?Q?binmLlD7tgbylbThg7FlZnPGPIBNIKWkFfar9hdd8CbVx+C5rMDott/aYmt+?=
 =?us-ascii?Q?+TDx6YkCpk426SV0lFxyejjHE26ZWiknL1ij3VsXNHjVN7cFMruNL8ZmTTNu?=
 =?us-ascii?Q?+2ZK8dAkx6Z7eqAILFlRnRkNzKlA7BFtKtG028mzo0kmSLivpppjfIxYoJiE?=
 =?us-ascii?Q?q8IrOeVPC1M2AYD8wsVr08SYezwcE2PgE0E1YQhuQIIOtc3nIOgDWJ+fy+Gg?=
 =?us-ascii?Q?aY9BbqLzaeTohwLbQfbiSFCVo1IyVmbne53NtjXByM94UO9zxxYUgm6UarNY?=
 =?us-ascii?Q?FXGvAv1ofFMh+uGAnQQuS4PTrqEIWd7NOVKx1keJGUC8C0yiQZS0HZhllEiG?=
 =?us-ascii?Q?fJ0WC0lgxbD3EkIYuecCdZLnM+Au0gSHc3yKMYaKptdbmrIs3Nwr9xYpvWqs?=
 =?us-ascii?Q?HtLRfRtPkcoVFBpsJvIt9LjU1Ex7+BIVFZYVE+3uhofXUtEyR3OspuQbdy5j?=
 =?us-ascii?Q?fJ4b9HnN/mLR8lWGRRvKjrNlXOV0o3+Z7LEHK5D6hfwxfrbZkN0IfPr7/Nib?=
 =?us-ascii?Q?MR4rrqMbSyHcMFSXYTcOYxz/TI8H4WfMt0NtFcdP3ERpty666/aRp/9TZ4o2?=
 =?us-ascii?Q?BjPrekAgPtkOqvWEYBtgCMjsPF4wLup5/Q7SJmOSTVDFzKMHmWvkj2idQyZN?=
 =?us-ascii?Q?E/yy4eCoYvDGhL1FoH4+1oPGfQVn838B8x0K5AC1WLCo4vrz2cVyNqDKKlz4?=
 =?us-ascii?Q?Pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F6C12283B9F3654B98F9622A52596762@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4c623e-370e-447f-1d1b-08dac1a7d78f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 16:39:44.5900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W0iXY6CHtZswcZpnYOkWhYQjhgeLPqsHGI6TYBcWMGH6ox4yYdcd/OZLdMrcdNoG8Ycsd+L5mJ9rG8Emu4tJJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6960
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080103
X-Proofpoint-GUID: Ycn-9rDWKj015Rd-nQ-pDLz6wFDGgeJR
X-Proofpoint-ORIG-GUID: Ycn-9rDWKj015Rd-nQ-pDLz6wFDGgeJR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 8, 2022, at 11:23 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> nfsd_lookup_dentry returns an export reference in addition to the dentry
> ref. Ensure that we put it too.
>=20
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2138866
> Fixes: 876c553cb410 ("NFSD: verify the opened dentry after setting a dele=
gation")
> Reported-by: Yongcheng Yang <yoyang@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Applied to nfsd's for-rc (-> 6.1-rc). Thank you both!


> ---
> fs/nfsd/nfs4state.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 554c4e50caf8..2ec981fd2985 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5407,6 +5407,7 @@ nfsd4_verify_deleg_dentry(struct nfsd4_open *open, =
struct nfs4_file *fp,
> 	if (err)
> 		return -EAGAIN;
>=20
> +	exp_put(exp);
> 	dput(child);
> 	if (child !=3D file_dentry(fp->fi_deleg_file->nf_file))
> 		return -EAGAIN;
> --=20
> 2.38.1
>=20

--
Chuck Lever



