Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AC333129E
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Mar 2021 16:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhCHPyj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Mar 2021 10:54:39 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35804 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCHPy0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Mar 2021 10:54:26 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 128FnMkH084981;
        Mon, 8 Mar 2021 15:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4AL/aPNT8gMjszvpuYjwd7GrJkU0z/u6ofuBBgu8EjQ=;
 b=t5rDbWdRNmfH6A/kJoXY4cnQd4/Wyb3PI/wrQro4TL3AHN1ATzq1PtjTZ+uKYpNMRN4y
 QjQBCGGP12kWHJi6H1tdtNUnb/opXma275hXu5A5cSUoxOlStaaBXHWQa5WW40omD7bN
 xKAfA0ij1s298RjbuK3l/+fAKXhOue0sonhc4QvpBo9qX8BngqwrBqF+7LOh5on8Jr2v
 xG+6kNgUUhWgq7jwnH7mkbonwmRU2nYe3UXTRIwiaYbHMBSq+hH3RbPBhUj+IB270ncn
 UrlxmCqKdgTc2eNVzWQs6CEU79LYLSh3UbKQGulr7OAbu9fTIB8jds0wjsThLwX3ac1h FA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 3742cn40fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Mar 2021 15:54:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 128Fotlp120810;
        Mon, 8 Mar 2021 15:54:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by userp3020.oracle.com with ESMTP id 374kgqfbjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Mar 2021 15:54:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4Bn7FJ6JsEP0vBk5hx+7X8ktB7oLWRplRfJG1XtTeJnh+9+D3/fZVeXly3ZyR8BUYOpDOfkiKD0xRnW6Au9euvps4Ly2i+FLBKx7AAA/9l8Nmcj1wa3m75Opc6sbRomF097LqfvGu4pttXo2pcMa8CKbOAqqlH3KhJ46HiUjHtkRefHrNSHvwaWuDgTghqS6n+BppJ+r+0SrPBoLlgQwEg8odEF9WZjRT49W5O97dFhE9lZGCw0vz52Hh97qC1C/1/iTe160+Fu/vmsRZCXGe7vS1vMLCCisVWnA6wgPT4VHOP42GUlDeXmk6FrnrvMbkijz6bXrzg3aDwmP0+64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AL/aPNT8gMjszvpuYjwd7GrJkU0z/u6ofuBBgu8EjQ=;
 b=bAVc4XZXHGfWH0gp0GYeB5vF5ds1SgE5ib7N/mqTdtrQiGtZfT6YsbaUJHO+0HFthD87cfAl9fkw1EEVMZly3MrhMysxim0ZoRjKaQbsZ2WJloVk0ZAm8G2mk0ZHF7wg966xmMt0aUDGKVUEYs8EgZ2CqViQNgFY/I/fiw0plx27veoWcmMdhyV338b/M9bKtWhVBfmdZ/5iYqWvbrBnDHmgLCUCKQRtcW3cr66NO4G5S+wwvt119epjUdbOjVbwZD2D47uAS15mIruETOcmcikoidSpO/j2bP+5JHaO3J4tavkcmFFvcFwGerABw2V6oxTe4HatIvFkRxeVPcqUaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AL/aPNT8gMjszvpuYjwd7GrJkU0z/u6ofuBBgu8EjQ=;
 b=LpkMaR8HMJgyfafs2ONzFYPvwu41lhcfKw8kf4YTwx84G1kOMJ9lAd8r8G7Ra84DHAqiOMvJWIfcpNripiC64fd6MB+D2LTkl0rpS0JA624QNl1FFsnInTOswjmlgSUqo7uhrWHrY/W82Px5ftSR19zH/FRicTB/QRLnDpdi7Y4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4049.namprd10.prod.outlook.com (2603:10b6:a03:1b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Mon, 8 Mar
 2021 15:54:21 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 15:54:21 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] Revert "nfsd4: a client's own opens needn't prevent
 delegations"
Thread-Topic: [PATCH 2/2] Revert "nfsd4: a client's own opens needn't prevent
 delegations"
Thread-Index: AQHXFDMNQbn31a+2PUeMNtliARrSqKp6PjWA
Date:   Mon, 8 Mar 2021 15:54:21 +0000
Message-ID: <7BC3CBA0-36AF-4F51-A5E4-ED0A1FABF16F@oracle.com>
References: <20210308155151.GC7284@fieldses.org>
 <20210308155229.GD7284@fieldses.org>
In-Reply-To: <20210308155229.GD7284@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9374a85-e356-457b-7655-08d8e24a70a2
x-ms-traffictypediagnostic: BY5PR10MB4049:
x-microsoft-antispam-prvs: <BY5PR10MB4049BA1649BD8C882683A3C793939@BY5PR10MB4049.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M4DVtJVSKdh9KRak13FXqgpS7phmke6WO6++8T74fi8vBdjOmz7N38udIDKwa7Mz8ldY9zm92oGhroPf3wdbhzGBNqkkUV/8l+LL6qDNSnKoqN3j9yqJ2TkS6bK8KL5FIbdtmpzFlKVz+oXPn1DANT0Fv8JqGpk0q5tUaLnCXsamBd85C8JIgeIebQjPZOHzSqW5RwqAuPBhWPoPm1hwWFQjtkhcF/2/8tls/dMaQtTTp/Pl6wvuvsNO5UFN3c7hIPvBaEeiTap3MjxvQ2BRb5DOhqo4cRIsOPdGrdTXJwfpC16yAfmzqdeDMxKdSDR2HRh5E3zxtbJ7cdQCZxUkk3GQqDzvlo4tTbyboMIDtKjY8QKPbXpT2KP/4xuHkHAkDnVWt9Utzqw4JLK5cDm714f/PZaYM0C2e1mGOiVIUp/Zqy5BGmj3fy6/TBF3Rd2LoVD4uF6QSjD4x1fILFGfhRd+AXGuvNLobSluMK81W0Pgzq3meo7vf6/fyNVSyjD+sTYxn5s9ssXfui0meKME+26JNZFDXQ5E1p3Hc7OJLMhtkVeyM8tVbWEKVGtjtN9bZIinJwwWD8ad+0fbGTiNoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(39860400002)(396003)(6916009)(8676002)(2616005)(186003)(478600001)(26005)(316002)(66946007)(66476007)(71200400001)(66446008)(36756003)(44832011)(86362001)(2906002)(64756008)(6506007)(6512007)(76116006)(66556008)(53546011)(83380400001)(4326008)(8936002)(33656002)(91956017)(6486002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cF58zO/m7e/d3SABHJXOt0YohQCZgGHdjt+OBG9VWRPe8SeUY38wSUxWFwXb?=
 =?us-ascii?Q?6XtpgtBwu5PIhkdDfQNm8jBfh4mBM6uDdMyZNEUDOsKdY8dcqrDV/B6lU4vJ?=
 =?us-ascii?Q?CiVtBwsHbknrrI/KZnEglOEDW/MlT8Dsb5+2I/u+TXvOrbJMDShzVP9fpix1?=
 =?us-ascii?Q?Rv/AGggFnIhfn/i0jxuqkImCTUxZnvjPBXxQmCYMkW85WM1QghFekUD3RThM?=
 =?us-ascii?Q?ZFbb1MtVBfj4/oBcztWl9eGLTuyGgGaoSxnf7uAfykohyBCXIuHLlwmMw4g8?=
 =?us-ascii?Q?xUo01VgllM0c0d5XWjbkc8dqAob+mzjteRH80vAok5hH7U7riiHEw+PmWoFK?=
 =?us-ascii?Q?FoI27L4J2D2L5snqcIzlqI92UfQZxgysfX+nXAMWG+RLxzsXJfnTHZ9PwIkf?=
 =?us-ascii?Q?kFuyqhq3zJqeVtCuPp7aoVVONFU+sWDGZjQ3XJzQhlkxzpKPpyvrOcG20BT7?=
 =?us-ascii?Q?gxRcr8w7YQr+cFgA8KqJXy61OWsapfFwXz+ygSvDOxvl5uLljr6oNdYwzWJu?=
 =?us-ascii?Q?2ay1qdL0Z8Voa5SqqHGLRF9eqUmTUzIExn8KEOmR5iu1lrn9FilXDWo0kcbU?=
 =?us-ascii?Q?YLotE3BNoAEvkKEgAi/lV3FywzeAs/vi4LRVk1aVYXiHSNzcvAYKpGFEY5JZ?=
 =?us-ascii?Q?Qe3Kz4nb9139O6HSQWd64sb8qwcUgYUud9R0U82lSRvy6bTJ4A3UKjGprbXJ?=
 =?us-ascii?Q?A8M6W5t17HTAsOST3tZ0wh+wtMvzB/7dddK2CO4LGFwn6TtvQ9UyPkXv2i5G?=
 =?us-ascii?Q?PCWO67V5lDfus/Wh9QKRGBIm1tj9zFyjcMqYgv55JtoPJ5gquZfffEiiL3Ia?=
 =?us-ascii?Q?s1gSfCFaPMu8bhwCHh8+Jz0/u7/DlqHR//HklUg2xPo6HXvRpa/fZKIhA527?=
 =?us-ascii?Q?/0tGYNfjM4hGy7reGeASsAqDWHp6stEgw3rMHQSWLqLxG35QmT2fKJwt32ow?=
 =?us-ascii?Q?GF8mZKrN/3PoiU+bAfVHu+JHS9N2yQZK2gIabpgeXj+NiJw7qJoTp1FDRZeS?=
 =?us-ascii?Q?Qpzi/tp1n6VR6jptk49n4sC5104Ebs8QBjLEYsnT/Q/W0a9Ax2C1kMjKuQ0P?=
 =?us-ascii?Q?bwXxQ1cWddeFz16qLvYwFmEwcIdYhGuUoL58uebiqlmU2SNUXfQupRXPGzyA?=
 =?us-ascii?Q?nEVmtuxCPVn+ArpiyfUK/X6FAtgOxhKAOjGKrILJi7hJHEpCCoNJ1Aub53UF?=
 =?us-ascii?Q?XH8vW5tnX3jiexSywm5F1EKyi45TUi+07UjRW45MYlad3TbonRLb8qXSv0vb?=
 =?us-ascii?Q?a5TG4X+R7P3vt/3h0NS1eo8AF9nHfJ+0sN+bfkWfiL0JJGO0XTNZTiQNwa4x?=
 =?us-ascii?Q?kkB74pyQXiN5457Mau+7Xrsu?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FB8DDE1592F2BE45956C522022144030@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9374a85-e356-457b-7655-08d8e24a70a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 15:54:21.7420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: huIJbziElcEY6+Y/cQWIgxRwGkCa4OY0m7UTeo9HsmN9PO12Eis96OaZpez60Zv8GG+Q4vcqlOSTCIn6nYLLUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4049
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9917 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103080086
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9917 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103080086
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 8, 2021, at 10:52 AM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> This reverts commit 94415b06eb8aed13481646026dc995f04a3a534a.
>=20
> That commit claimed to allow a client to get a read delegation when it
> was the only writer.  Actually it allowed a client to get a read
> delegation when *any* client has a write open!
>=20
> The main problem is that it's depending on nfs4_clnt_odstate structures
> that are actually only maintained for pnfs exports.
>=20
> This causes clients to miss writes performed by other clients, even when
> there have been intervening closes and opens, violating close-to-open
> cache consistency.
>=20
> We can do this a different way, but first we should just revert this.
>=20
> I've added pynfs 4.1 test DELEG19 to test for this, as I should have
> done originally!

Excellent, Bruce. I'll get these into for-rc right away so it can get
some testing with the 0-day infrastructure.


> Cc: stable@vger.kernel.org
> Reported-by: Timo Rothenpieler <timo@rothenpieler.org>
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
> fs/locks.c          |  3 ---
> fs/nfsd/nfs4state.c | 54 ++++++++++++---------------------------------
> 2 files changed, 14 insertions(+), 43 deletions(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index 99ca97e81b7a..6125d2de39b8 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1808,9 +1808,6 @@ check_conflicting_open(struct file *filp, const lon=
g arg, int flags)
>=20
> 	if (flags & FL_LAYOUT)
> 		return 0;
> -	if (flags & FL_DELEG)
> -		/* We leave these checks to the caller. */
> -		return 0;
>=20
> 	if (arg =3D=3D F_RDLCK)
> 		return inode_is_open_for_write(inode) ? -EAGAIN : 0;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 408e2c4db926..27983a50435e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4940,32 +4940,6 @@ static struct file_lock *nfs4_alloc_init_lease(str=
uct nfs4_delegation *dp,
> 	return fl;
> }
>=20
> -static int nfsd4_check_conflicting_opens(struct nfs4_client *clp,
> -						struct nfs4_file *fp)
> -{
> -	struct nfs4_clnt_odstate *co;
> -	struct file *f =3D fp->fi_deleg_file->nf_file;
> -	struct inode *ino =3D locks_inode(f);
> -	int writes =3D atomic_read(&ino->i_writecount);
> -
> -	if (fp->fi_fds[O_WRONLY])
> -		writes--;
> -	if (fp->fi_fds[O_RDWR])
> -		writes--;
> -	WARN_ON_ONCE(writes < 0);
> -	if (writes > 0)
> -		return -EAGAIN;
> -	spin_lock(&fp->fi_lock);
> -	list_for_each_entry(co, &fp->fi_clnt_odstate, co_perfile) {
> -		if (co->co_client !=3D clp) {
> -			spin_unlock(&fp->fi_lock);
> -			return -EAGAIN;
> -		}
> -	}
> -	spin_unlock(&fp->fi_lock);
> -	return 0;
> -}
> -
> static struct nfs4_delegation *
> nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
> 		    struct nfs4_file *fp, struct nfs4_clnt_odstate *odstate)
> @@ -4985,12 +4959,9 @@ nfs4_set_delegation(struct nfs4_client *clp, struc=
t svc_fh *fh,
>=20
> 	nf =3D find_readable_file(fp);
> 	if (!nf) {
> -		/*
> -		 * We probably could attempt another open and get a read
> -		 * delegation, but for now, don't bother until the
> -		 * client actually sends us one.
> -		 */
> -		return ERR_PTR(-EAGAIN);
> +		/* We should always have a readable file here */
> +		WARN_ON_ONCE(1);
> +		return ERR_PTR(-EBADF);
> 	}
> 	spin_lock(&state_lock);
> 	spin_lock(&fp->fi_lock);
> @@ -5020,19 +4991,11 @@ nfs4_set_delegation(struct nfs4_client *clp, stru=
ct svc_fh *fh,
> 	if (!fl)
> 		goto out_clnt_odstate;
>=20
> -	status =3D nfsd4_check_conflicting_opens(clp, fp);
> -	if (status) {
> -		locks_free_lock(fl);
> -		goto out_clnt_odstate;
> -	}
> 	status =3D vfs_setlease(fp->fi_deleg_file->nf_file, fl->fl_type, &fl, NU=
LL);
> 	if (fl)
> 		locks_free_lock(fl);
> 	if (status)
> 		goto out_clnt_odstate;
> -	status =3D nfsd4_check_conflicting_opens(clp, fp);
> -	if (status)
> -		goto out_clnt_odstate;
>=20
> 	spin_lock(&state_lock);
> 	spin_lock(&fp->fi_lock);
> @@ -5114,6 +5077,17 @@ nfs4_open_delegation(struct svc_fh *fh, struct nfs=
d4_open *open,
> 				goto out_no_deleg;
> 			if (!cb_up || !(oo->oo_flags & NFS4_OO_CONFIRMED))
> 				goto out_no_deleg;
> +			/*
> +			 * Also, if the file was opened for write or
> +			 * create, there's a good chance the client's
> +			 * about to write to it, resulting in an
> +			 * immediate recall (since we don't support
> +			 * write delegations):
> +			 */
> +			if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE)
> +				goto out_no_deleg;
> +			if (open->op_create =3D=3D NFS4_OPEN_CREATE)
> +				goto out_no_deleg;
> 			break;
> 		default:
> 			goto out_no_deleg;
> --=20
> 2.29.2
>=20

--
Chuck Lever



