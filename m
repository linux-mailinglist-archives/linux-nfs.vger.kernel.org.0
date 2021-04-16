Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3940936288A
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 21:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242551AbhDPTVs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Apr 2021 15:21:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54010 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242887AbhDPTVr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 16 Apr 2021 15:21:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13GJIvca053487;
        Fri, 16 Apr 2021 19:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lYlibSezri4HQ6l7XdmaVyzeKEehM7P0xBPS75K2diQ=;
 b=WwEahtdlyYL4kpJ/8b3lCOlfESxnKM6Oo3v5I0Z68oVCCq2UKsiMLfgDVyXGQ8MoFsh8
 JYw7oKu8Zc1LSkqGt9eUxhlL/IU5T58iCNWESE7prvHPyFlb7DV+LU1fMe1axHJlBYos
 Xn/IF/o8wQ3ZqzwEZFkIhKMo0LDZEBcaJF9JTs0mEsne/b4q/l00QBI3ZR1UC9s7/bSE
 OjjvBqsVGKi6sJemcCN7Bp6WFSInwH3O9gf/3uuhBMRLQMuTcjW7/7ZesNWsnuTteQ2e
 mGxlR0kFWqxKacw2xYhN93EilswJvdla1toAmCZvAF+2QYwH2KrI5luOdSVgncRn3if2 ww== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37u3ymt41a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 19:21:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13GJKYGd106863;
        Fri, 16 Apr 2021 19:21:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by userp3030.oracle.com with ESMTP id 37uny34033-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 19:21:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnhIEY3PXq3d5fqw90DkWC12uBKioS2nXFzuvj7/+Sw1HoKwkO49oREsQDQUBgCsbxV5kcojAlAVURxLAF7Wo/JXIJGxZTkmnp818/lhFW1eunNWlFCGcQv32+Mo0tKSz/zEaC7pffSajI3CjPlgEFDF3+oE0ZLVc2vIzDEjQCneBNH1LgrZ9JhojJkM87EvZrNSLOQn4WpDXaWTC0T0f1tXz6v2GBaRqa29ai4ZeXeExgcwTZaVbQu+Rxot2T634CHcPDpvbQThAHZUmrICPkRFYweekmUGOdjCc81zKir8p5McHAN6LWc2UaUhAqSLZldt76lMAcUOqd4UTLXlpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYlibSezri4HQ6l7XdmaVyzeKEehM7P0xBPS75K2diQ=;
 b=EQ42mUIqEZV255vHpAwMCoDG3OBCSVjKb28buJKRVSnzFM08pyFUAXjC3Vdi0OBMQOU+H/cCVcphkiWGefBymgEOVeiejdAOU8hvMe48Bmcj4On1VN+awFCJU/RNfNbXQaWmgC8vP8t+qidzF31WvIJBGI9eE6OtpVZWJmzC3D4FqyHkKH2dGErBGJIT9RvnSI47HqN/+iQJuf2X/MyZMuj3nltPcdMJ1McmXseSzLlpwI3jVQkwfKISypf4cBAPwKIv5vp7xCpkKKKBm0phfFgbusn8KT/3uazDusBN6HEjxq6ddWaZengohvfT+Q4bxySveC+vwfbWt45u6t46Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYlibSezri4HQ6l7XdmaVyzeKEehM7P0xBPS75K2diQ=;
 b=xKqYfMvs1/J8wYZpWa7rHMwMR4g6QKxILdviOj6bJB9SwTMix6bSNbYmW4R3TTpNomMZ+SaJC6y94zC1Ka5y9kPsM6c5/ZVuBqwZzVTEazl2gazkv8NWOq3g3TJyj1fZu5PwVTgfo9AudS3nHMtzoYjffqPFNgnOcX3Sanc6v14=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3112.namprd10.prod.outlook.com (2603:10b6:a03:157::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Fri, 16 Apr
 2021 19:21:16 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 19:21:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/5] nfsd: hash nfs4_files by inode number
Thread-Topic: [PATCH 2/5] nfsd: hash nfs4_files by inode number
Thread-Index: AQHXMupixIvrGePep02kzvU78UvPJ6q3hYIA
Date:   Fri, 16 Apr 2021 19:21:16 +0000
Message-ID: <7342A4CD-0B93-4C13-AD32-4DADC26CD8ED@oracle.com>
References: <1618596018-9899-1-git-send-email-bfields@redhat.com>
 <1618596018-9899-2-git-send-email-bfields@redhat.com>
In-Reply-To: <1618596018-9899-2-git-send-email-bfields@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9775e60f-549e-42ed-a2ff-08d9010cce99
x-ms-traffictypediagnostic: BYAPR10MB3112:
x-microsoft-antispam-prvs: <BYAPR10MB31126312B4AD50DFCBD9AA27934C9@BYAPR10MB3112.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3UjjHUZks4qd2Y2spvLJUztOWRhJjiLn/dbKcwOYOVUcwClej30RiwMu9/8G0LPnSAbtIBjLAbH6aGUyRKWwCNCTmhDQnrz/W5oeNWbAfhpqF/ycecYpAZhTnAy5YZwxohnNR+W79snDJNtA+cH7yh29cC5Nvoyo0n7PelZZ1FiJ+CFCkOFEOk7KIt8NaDFWxYFbJl1BMTX7BJ2ilbsNo0+JmKzvwhvcdladW/Zd3cOA3ZC/dw/9x6UgIh1RTabxy4CQY8sdZajgTOxW+I6rsuhXGeKK+TeHfOcqNrita32qNhu17LAMDq4KXX2y2zvzQ8uNgzHAA3A9NH6TEqUOzqGtVhHgaTIk9eb1GB52SHDixDt5E0m0ykMAb50HmblFlUuQhbCzlFO0Fl/cBg+QY9EaSGEfUuzYfnearnl8uA4lO+nu20B5E50wzIFiIxqE1iMk5EuWmJTXWMyVSq0ReKH2XZ70wvFw0IdZmIxvo3KackI4OKdWYCB5LuxYhYnA3stGktKpxaaFEbujS1jbQinJXzCKvczB0g9cjtL35EmsZ4IrelYHhafp3zIRAwM7idUXLLxSOk4U5RLycV/+i0mhq/6ayo1Wo7bspTrYyaskZ/jk/oh8EUpgnVx8cFdZZrU7tB/ORe8R9pRJSqM8ePNXJzLc5US10JES6fuo0Rc2XOJ9TcZP+LBUruws9u0s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(6486002)(6512007)(6506007)(508600001)(53546011)(8676002)(122000001)(6916009)(66556008)(64756008)(5660300002)(4326008)(38100700002)(186003)(26005)(8936002)(83380400001)(2616005)(316002)(2906002)(33656002)(86362001)(66446008)(71200400001)(66946007)(36756003)(76116006)(66476007)(91956017)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XfmTNHyyvlbV1sDbVfBusbJ8xIYCmj5hGkVNnG3C44UXZEyok9C8Dl6D4IVa?=
 =?us-ascii?Q?XWS2PrM4V7o6itgzyGN18wNSxhRu/08PIDTA50hHDoRf/e0k0RSfs+MJJIRD?=
 =?us-ascii?Q?9dWm4wi4ws/MpDZCVqVJdCJnfttTUWnlRRzIxghR00DoSqyGq24q0XtEcPy6?=
 =?us-ascii?Q?3uIi3QU/jEvuSKbwIkP/NKhTeNfjxHHrlax4xoNXg9fi4aJ1/07dDR9qfqNu?=
 =?us-ascii?Q?V26p0+9nlrssM1tVLq/+UQgp3Vd/2XQVX9mrWmeQrUUZ2hKtkOMizhvi+tOi?=
 =?us-ascii?Q?tbYlw83ejN3+6E5pwPp3yG8HIwZW9D5zrCd3jdwjiTydsgC+tdT/dbo/4+Xi?=
 =?us-ascii?Q?Kd2fa8Y3BUGaaCuy9MRAtACmBDrT5r3JS8B+9rOH3JwGeNDAwTEc+W2EC438?=
 =?us-ascii?Q?xisvDYxZG4dPqhB5pJFhBgWdMljTmJW4pOxe85a1/TioUtq9nvqPxvJbJyqv?=
 =?us-ascii?Q?OF/kZUjaVYBSp/uRny4EGgoPyGzZirppdAUv+yJcIx5gjau2jU/WHEI+9HrB?=
 =?us-ascii?Q?Oh87ETnvDN6fJ7/JuNhkYIMeGJJrc/zBA9x49NFJW60TqSnmR3J9ADymbp7s?=
 =?us-ascii?Q?ne+krYhBuT18dADXIvQmo3xtm9nM28NXuHOqxDNmcaGGewH8q//NfT1RYVBs?=
 =?us-ascii?Q?wuJPxUGUqQ9XvSe/0RPeDXkBvKBsg0pChpYfR6snGdKeUIZwIXdXNXkzMq5d?=
 =?us-ascii?Q?Kd3tIi7YbMlopzh/GhzPTGZRK6sZ7jiR/zhlIgG+qGwQkn98ffJ92iNab/cH?=
 =?us-ascii?Q?FTG7QLRTIalwx4X+lg2AtDUA4nG1lql2Ne+0Z0XigueSPaDfsxTuZnztTHKd?=
 =?us-ascii?Q?OE1Mww/U5NyW6VBRtKq8j5uSO0snmuQfVnxLnUvYBFp9TGQ82e5mI+TPtNlY?=
 =?us-ascii?Q?mRu1Q1XciVtuZieu8sOmmuFhWaeTVAT3j5exvEe4E4V6Id+brPDknJvSbXeP?=
 =?us-ascii?Q?IViB0miy6ReMYGRq648t2SrxDHVNCmhFmBZj2Ufvl5Qc/S6WvT818qwYQg2J?=
 =?us-ascii?Q?ofkN85fD2/3hrorsrBTtHjsAhwnaLh4u3GNyQBkWClI6dbhQyCji2XqSBHS4?=
 =?us-ascii?Q?k5Mop8Prnw1KfAaJAPYAZk4s8J/yEyC5OKIbhgCYkds1bQ+NY0rIro/6mlKM?=
 =?us-ascii?Q?Tt0kcmLlaeWJD0LVQOcnJP4YBbqWoV2sz5edTXb7vn3CgQWazXTrSxR2wTis?=
 =?us-ascii?Q?/02qmNFdqi1979gS507rNzdjj+pgsiwD9WsNE2mUAw2VoaVryQE2oLuVx6M8?=
 =?us-ascii?Q?osR+Z5255YM9o+vAQSokaYY+OecdeyJpyiSy1JtS2ET4KREDu4zA1UgKP44k?=
 =?us-ascii?Q?UH9woJJTY5BsiniZfHm9JpOE06p4GEph9GKGq0HRELysYw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CA844D0CC7416845B79EE8051BE45FD9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9775e60f-549e-42ed-a2ff-08d9010cce99
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 19:21:16.5861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iXnkZsaOGLCLl9h0X6tMAmmRAcQLQ/+w7tMG/oHFxewZXc9SxsR3FEykRo8G65KeKkWPSJgxbWi5WrVFs7NtNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3112
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104160136
X-Proofpoint-GUID: CKyopCa-raYPuEEqQur5nd8zp2qOUTt3
X-Proofpoint-ORIG-GUID: CKyopCa-raYPuEEqQur5nd8zp2qOUTt3
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104160136
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 16, 2021, at 2:00 PM, J. Bruce Fields <bfields@redhat.com> wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> The nfs4_file structure is per-filehandle, not per-inode, because the
> spec requires open and other state to be per filehandle.
>=20
> But it will turn out to be convenient for nfs4_files associated with the
> same inode to be hashed to the same bucket, so let's hash on the inode
> instead of the filehandle.
>=20
> Filehandle aliasing is rare, so that shouldn't have much performance
> impact.
>=20
> (If you have a ton of exported filesystems, though, and all of them have
> a root with inode number 2, could that get you an overlong has chain?

^has ^hash

Also, I'm getting this new warning:

/home/cel/src/linux/linux/include/linux/hash.h:81:38: warning: shift too bi=
g (4294967104) for type unsigned long long


> Perhaps this (and the v4 open file cache) should be hashed on the inode
> pointer instead.)
>=20
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
> fs/nfsd/nfs4state.c | 27 ++++++++++++---------------
> fs/nfsd/state.h     |  1 -
> 2 files changed, 12 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 886e50ed07c2..b0c74dbde07b 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -542,14 +542,12 @@ static unsigned int ownerstr_hashval(struct xdr_net=
obj *ownername)
> #define FILE_HASH_BITS                   8
> #define FILE_HASH_SIZE                  (1 << FILE_HASH_BITS)
>=20
> -static unsigned int nfsd_fh_hashval(struct knfsd_fh *fh)
> +static unsigned int file_hashval(struct svc_fh *fh)
> {
> -	return jhash2(fh->fh_base.fh_pad, XDR_QUADLEN(fh->fh_size), 0);
> -}
> +	struct inode *inode =3D d_inode(fh->fh_dentry);
>=20
> -static unsigned int file_hashval(struct knfsd_fh *fh)
> -{
> -	return nfsd_fh_hashval(fh) & (FILE_HASH_SIZE - 1);
> +	/* XXX: why not (here & in file cache) use inode? */
> +	return (unsigned int)hash_long(inode->i_ino, FILE_HASH_SIZE);
> }
>=20
> static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
> @@ -4061,7 +4059,7 @@ static struct nfs4_file *nfsd4_alloc_file(void)
> }
>=20
> /* OPEN Share state helper functions */
> -static void nfsd4_init_file(struct knfsd_fh *fh, unsigned int hashval,
> +static void nfsd4_init_file(struct svc_fh *fh, unsigned int hashval,
> 				struct nfs4_file *fp)
> {
> 	lockdep_assert_held(&state_lock);
> @@ -4071,7 +4069,7 @@ static void nfsd4_init_file(struct knfsd_fh *fh, un=
signed int hashval,
> 	INIT_LIST_HEAD(&fp->fi_stateids);
> 	INIT_LIST_HEAD(&fp->fi_delegations);
> 	INIT_LIST_HEAD(&fp->fi_clnt_odstate);
> -	fh_copy_shallow(&fp->fi_fhandle, fh);
> +	fh_copy_shallow(&fp->fi_fhandle, &fh->fh_handle);
> 	fp->fi_deleg_file =3D NULL;
> 	fp->fi_had_conflict =3D false;
> 	fp->fi_share_deny =3D 0;
> @@ -4415,13 +4413,13 @@ move_to_close_lru(struct nfs4_ol_stateid *s, stru=
ct net *net)
>=20
> /* search file_hashtbl[] for file */
> static struct nfs4_file *
> -find_file_locked(struct knfsd_fh *fh, unsigned int hashval)
> +find_file_locked(struct svc_fh *fh, unsigned int hashval)
> {
> 	struct nfs4_file *fp;
>=20
> 	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash,
> 				lockdep_is_held(&state_lock)) {
> -		if (fh_match(&fp->fi_fhandle, fh)) {
> +		if (fh_match(&fp->fi_fhandle, &fh->fh_handle)) {
> 			if (refcount_inc_not_zero(&fp->fi_ref))
> 				return fp;
> 		}
> @@ -4429,8 +4427,7 @@ find_file_locked(struct knfsd_fh *fh, unsigned int =
hashval)
> 	return NULL;
> }
>=20
> -struct nfs4_file *
> -find_file(struct knfsd_fh *fh)
> +static struct nfs4_file * find_file(struct svc_fh *fh)
> {
> 	struct nfs4_file *fp;
> 	unsigned int hashval =3D file_hashval(fh);
> @@ -4442,7 +4439,7 @@ find_file(struct knfsd_fh *fh)
> }
>=20
> static struct nfs4_file *
> -find_or_add_file(struct nfs4_file *new, struct knfsd_fh *fh)
> +find_or_add_file(struct nfs4_file *new, struct svc_fh *fh)
> {
> 	struct nfs4_file *fp;
> 	unsigned int hashval =3D file_hashval(fh);
> @@ -4474,7 +4471,7 @@ nfs4_share_conflict(struct svc_fh *current_fh, unsi=
gned int deny_type)
> 	struct nfs4_file *fp;
> 	__be32 ret =3D nfs_ok;
>=20
> -	fp =3D find_file(&current_fh->fh_handle);
> +	fp =3D find_file(current_fh);
> 	if (!fp)
> 		return ret;
> 	/* Check for conflicting share reservations */
> @@ -5155,7 +5152,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct =
svc_fh *current_fh, struct nf
> 	 * and check for delegations in the process of being recalled.
> 	 * If not found, create the nfs4_file struct
> 	 */
> -	fp =3D find_or_add_file(open->op_file, &current_fh->fh_handle);
> +	fp =3D find_or_add_file(open->op_file, current_fh);
> 	if (fp !=3D open->op_file) {
> 		status =3D nfs4_check_deleg(cl, open, &dp);
> 		if (status)
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 73deea353169..af1d9f2e373e 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -665,7 +665,6 @@ extern struct nfs4_client_reclaim *nfs4_client_to_rec=
laim(struct xdr_netobj name
> 				struct xdr_netobj princhash, struct nfsd_net *nn);
> extern bool nfs4_has_reclaimed_state(struct xdr_netobj name, struct nfsd_=
net *nn);
>=20
> -struct nfs4_file *find_file(struct knfsd_fh *fh);
> void put_nfs4_file(struct nfs4_file *fi);
> extern void nfs4_put_copy(struct nfsd4_copy *copy);
> extern struct nfsd4_copy *
> --=20
> 2.30.2
>=20

--
Chuck Lever



