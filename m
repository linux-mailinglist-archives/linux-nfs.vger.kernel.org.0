Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A8A568F30
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 18:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbiGFQaI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 12:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbiGFQaD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 12:30:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C6027FE9
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 09:30:02 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266GNxQG006104;
        Wed, 6 Jul 2022 16:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3gznJE/omN/ck2fRTajMczQF1EyO1g5JnbbWcMGNHhM=;
 b=gS4A/atg/Aiyr4fzhjDhPuI07W8Lp1F/441lIqUjAFDicAUPOGWcUH27DZV2YLOaTIhM
 kkqAn8pb57judSMVckdTUPS5gbWonqPROxLPE+Azg3u85VUfkpzFlkMjPJNuBK/K2xud
 jyzWLDMbCu7wOSKd2NTHUbn9jafgByspi8nG16nJaJPj+aGeh7cAsCOLaYanxGUr1R5S
 uBfskE5wf0kadJon2tC2fzzePoZrsle7h9t3fqPHJeRow0GXIZV28L3Tc122WJK4FK0q
 4id8ui+JufUpl1GZ9/4I1QX1CYO4G2hgiCrE+Jxcjx99zGbHsZgvTlt5BvillDIeEGHr kw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubythtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 16:29:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266GBqaN004653;
        Wed, 6 Jul 2022 16:29:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4udeq26f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 16:29:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lc5xMABe7kdbPfqGAlHaJAvkc1MRbueV43zdXwmmHHUOmbJePGKG8LqB0oeoMxcvee0hvkcfimuW9ntVWygAJxPC9mMTnqPVPinCdx6XYN4OE56cYMRlG5E9WCCvAan5DO6iVz/GUe04XBT/+gG7OqyypUDUFEjYNGniESGZVJhb/Dsn5QXImqCmx45r4BiU9suDR0Als77kCDC5PFLBsMTOdt2TxG7h+yWWOhcP/r1tCQwugseDKOOOGq52sC+qPuPBVLyo/Qo7v7f95Bwv/+BFJkiws+2KS/Ax2Al0JWNQG5++qNulYGY1TH0Lge//cqrFQPp7rYsuh4NceYgO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gznJE/omN/ck2fRTajMczQF1EyO1g5JnbbWcMGNHhM=;
 b=NFO+F9ifmH5rZ044j+mlMdCFuzW1Q3r2P8PvOvyoii+wq0XjbFS9s4ermx6yM6LrbijAspDYCjK6WIIf/UJilr1axm0vR8kbgmCJ+G+5ZFi6L0Fog2mNzKFDwx6/XS3x+d633NFeNZDnb/kP6KoXmiupAmVLeELCBYOtjzODFgml/HXyUyYKHRTzGZUvzI/TB0j7lSKoG3Sug+LgmsRPNTRxF40sqFB1FKSbeMSBuvTgMUhKEJpyq5UtMA+H06v0rUv+o73aW9rCwr0slBU4FCWun1XHpsy19eko2L5uLAC2tJLVCly8sKz8AOdt+0n8Fbe7SibGzqIMzhx86gsPeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gznJE/omN/ck2fRTajMczQF1EyO1g5JnbbWcMGNHhM=;
 b=o3XxbM3Dr4sGlhmp95pcWZ9YwcKdkbNncHreNCns9hE2RpE4qX7pkfyGf8C4vquFwinbnwY5b8/7UILVzR0li8Fh9Fae/wSPOTVFKLWprJLyBlXAajAnKZ0uQmQ4mLZz+cZZHQZDGdufM8QlVY1bFo//WHMguJUBsjOVSFuzmEE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB3063.namprd10.prod.outlook.com (2603:10b6:a03:89::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Wed, 6 Jul
 2022 16:29:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 16:29:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 6/8] NFSD: use explicit lock/unlock for directory ops
Thread-Topic: [PATCH 6/8] NFSD: use explicit lock/unlock for directory ops
Thread-Index: AQHYkO/Oqqab8vIWF0aB44V884IBca1xiVwA
Date:   Wed, 6 Jul 2022 16:29:53 +0000
Message-ID: <37A77F67-7D27-401B-9414-E747256655BF@oracle.com>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>
 <165708109259.1940.685583862810495747.stgit@noble.brown>
In-Reply-To: <165708109259.1940.685583862810495747.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de18798c-6583-47ac-d772-08da5f6cc159
x-ms-traffictypediagnostic: BYAPR10MB3063:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rQribjKhQxrwUcCSxwpRQ03MxKBHTrATO24tSlGNt4m1af3YrHXCd3JErHYrOjkvHm7ESpv0EJcV7litwIT6jRoOizb9VPGK/joA2QLlTx8ypu4hOYOJGOdbfvPhAn4a+Ym68jvmA9Yh1RA8bZ2xrzNk29owXXH6CdlqHa1LpxnH+/a/9bUFmdTpjwYOntMMTjKRtf3BFADQ/76TMysf+LRoXk31FG05DWyAFbdFGIts/gYVVSN8Mqg3SJd2OzBQNpm0dRmXwPpPI0Rw05Jm17XPEuvcqD5bUOjF7YTRm5al4GRAp7naIGe+U2Rvn42GULE/+NgUGEvuYw5QLNUo0FbffYo68WmvKWLvwN2kTtfzhbT7SSTC0fEvUgEWNQLABqMWElloVv5Zwe0WgDz5pP2VzAFHHC4otZKMbpd+FSCw3U6EPmqxlQUAE3Ac6ez5UWY1sy2uHa3JFx+1d+2tRv3jH4i0JTiILLgQFiGsvtcgF4AIDIV4L65QoU9hNtUnyvWYdESXDCoUEqzFZ+LXS5sYJ+xje9KsnbqvA1TakP/SASJgYeVp2hRxPgN6/IPNmDiQ63ZvlB1QwwCW3Pl0yiOW1bgapnZnbfEBiMqV25PVgJwObSKyPpL5ksf8Zv25TooC7mGYWNUYBMdUayE/lz+8BflWKLLE8YrX6ixre7Z6YfcXHc0w9nKjfYFF1TsPMs5A4EAa+bErtsUSGJZU2Qnx8WjKLzMnnSUqLXmmW2A4j45VSghyUOvBFzxqg2zMtwMJoRDDrnOGVO69o7TztGZrfC+yUi3UBz+mxxoS4EnOGmqYXwEAFrWklCPvvy6nyMPYFb/t4OOXu/2NrZ92wn3hvRC8hiUSLKclU6XQXU0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(39860400002)(396003)(136003)(122000001)(38070700005)(66556008)(53546011)(66946007)(6506007)(41300700001)(76116006)(66476007)(91956017)(8936002)(66446008)(83380400001)(5660300002)(4326008)(38100700002)(6512007)(8676002)(36756003)(26005)(64756008)(2906002)(6486002)(478600001)(6916009)(316002)(33656002)(86362001)(71200400001)(54906003)(2616005)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aMblZOEi5T6rwl/VhGBIhdySc1KQ1yShO1f9TYe3mHFn+EnBZv/Y5GtSszQe?=
 =?us-ascii?Q?2iHVRlvZ6//HL3WdXws03NwxwcrURiW9zVPGqi3VO1wAEIpvoma1AQ333nuR?=
 =?us-ascii?Q?XsPAZMtkjctkMZY0y3H5q+w3WOyeJUMi+HdQhc4azQDsPlt6GOZ2Nr+ZM9+F?=
 =?us-ascii?Q?MG1749xYCvbfGO+dc12NKLXem7GzxhTD8rVKBW2RhV/hIl0js7/rpfypCuE7?=
 =?us-ascii?Q?/yUd9YDk1UbwMbVtKLlJNsbxs8CVTYjN9khHFgbgqx+EdqEnf686VM70aB4w?=
 =?us-ascii?Q?7ZFqmZmJt/2fH6bYdF/GEEu+N711N6lSOGAvPY7o5CsAKiHb/7/xfR3Myh/x?=
 =?us-ascii?Q?oOeA8qLpfYFHyJQAAXJnxEcoYhxxrOsqR9mkV3tuIVOJ8E1zGfuiYPTXK7dQ?=
 =?us-ascii?Q?pqRqVAYKghZEVi1+/NjskP3UP3FcD3DOQq+mcbwvKxNz+LJPJ0NMdBooINsk?=
 =?us-ascii?Q?bW94Sa1ajCVTdgD7tnjJFwuO93w2/5YFYrudDU+LwkLN9cDieGduvdEXMNyv?=
 =?us-ascii?Q?H7NHTSlgZToFTWXueXxMfUtUcN5v3GsG6/uN4bRuhCu60onkUy9Z88gg1dFP?=
 =?us-ascii?Q?bfbdQ5Jd+UB1B915uBqX1SI4ysYjnJpSt3QxB9mtzlWwz/QwQg3pVLnPA7HF?=
 =?us-ascii?Q?ZbjapZMtcMjL39k3t7AMdrqF4v9OYSBVPt5Rw+yepelR4uUNCu66rUbRCDrX?=
 =?us-ascii?Q?WLeltsM9lGnlgF+BA3kT9l07+qCOGbIFOmtAKR9CAZVN5YRINjO1wJo13tNi?=
 =?us-ascii?Q?9B5LK9zjhtE2Fw680iiAGKitM0GdNr+2nD5PaGbH1AL63+FF/JUsMjreol3P?=
 =?us-ascii?Q?SXxuAJK213mg/kc+jZLaaOlPZNA0NS6YmZbIJsngmjG30cmlUcHLpIEDDZv7?=
 =?us-ascii?Q?8R2aVwKERcNh7Qf/iWDRl/yCUu6pgKceK4DFHbDCKXecznZe8HPBx7AUGs6k?=
 =?us-ascii?Q?WdahE0LuOQFohUYQ7wT86ivk28BXRqqRUBmBxIf2QDEK4byFYqQVJyzBTnqV?=
 =?us-ascii?Q?10p/GZGrt0D0pKRmGy0lOMEtLRUsRw623+4tR9FUFrPFTE8w4MCgELwJ0e+T?=
 =?us-ascii?Q?DVViQZpug2MStqmIJ1aSbxV6soL1myIVqxatCPYPkYgp54uuc4gCMoWdE80x?=
 =?us-ascii?Q?5tWnmebEdqXAHT9rA+g8CRTGMr1tn9jB0Tb3BmNbkQaK15DhVk/14GKZa19o?=
 =?us-ascii?Q?rxeem9pgbgRlwp9QExRzw3VISwFFYHOh3OPWlC7LC7n27LpeBsdl3roZN8Ja?=
 =?us-ascii?Q?p/ykXSAm4yme/Spc/VkWncw+T4TUsZJEJHBpeiixKw+zs+2zyS/LR6owiVoF?=
 =?us-ascii?Q?5UIW2L3kL/3NEYvo3O7KfipyDtiDvBHwtqq/1B6iL2kjOP1ysrregefLxcHJ?=
 =?us-ascii?Q?mD3OxEe7zok8boU9mWDT4Mi2NWUFUHIbZJvjYACpYEq3pzdfAqYo8wIp01is?=
 =?us-ascii?Q?gURmyMszJQlr7PksSlC2nlKsHEZwXiyke8DP9DHKO+dSlVxTAojOidzhOo3g?=
 =?us-ascii?Q?+zlCis/Rns8VpFFMaKWStCcBK8a+lwZU5soDpkd2UWxy5LEksTNOAVgzA985?=
 =?us-ascii?Q?ovFVVqCcUFFFqvlkOJljFILHTkdLnKfUl4megFKsQ+xzkDgUGmBbczIet6Ni?=
 =?us-ascii?Q?Bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <70DE43F14513074BAFE982B4572C691A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de18798c-6583-47ac-d772-08da5f6cc159
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 16:29:53.1031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iJBA2Aab87SFeh72QgH7IYLMIL5eKPoHGIxXMriWSn25aNItZT/QZzsYDohFPLLCz0tf/M5gIO+ABg3KVtmkgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3063
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_09:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxlogscore=608 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060065
X-Proofpoint-ORIG-GUID: C0MUu4eHvNfj1RAFihrzWstL1dl5WhNC
X-Proofpoint-GUID: C0MUu4eHvNfj1RAFihrzWstL1dl5WhNC
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
> When creating or unlinking a name in a directory use explicit
> inode_lock_nested() instead of fh_lock(), and explicit calls to
> fh_fill_pre_attrs() and fh_fill_post_attrs().  This is already done for
> renames.
>=20
> Also move the 'fill' calls closer to the operation that might change the
> attributes.  This way they are avoided on some error paths.
>=20
> Having the locking explicit will simplify proposed future changes to
> locking for directories.  It also makes it easily visible exactly where
> pre/post attributes are used - not all callers of fh_lock() actually
> need the pre/post attributes.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> fs/nfsd/nfs3proc.c |    6 ++++--
> fs/nfsd/nfs4proc.c |    6 ++++--
> fs/nfsd/nfsproc.c  |    7 ++++---
> fs/nfsd/vfs.c      |   30 +++++++++++++++++++-----------
> 4 files changed, 31 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 3a67d0afb885..9629517344ff 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -254,7 +254,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> 	if (host_err)
> 		return nfserrno(host_err);
>=20
> -	fh_lock_nested(fhp, I_MUTEX_PARENT);
> +	inode_lock_nested(inode, I_MUTEX_PARENT);
>=20
> 	child =3D lookup_one_len(argp->name, parent, argp->len);
> 	if (IS_ERR(child)) {
> @@ -312,11 +312,13 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
> 	if (!IS_POSIXACL(inode))
> 		iap->ia_mode &=3D ~current_umask();
>=20
> +	fh_fill_pre_attrs(fhp);
> 	host_err =3D vfs_create(&init_user_ns, inode, child, iap->ia_mode, true)=
;
> 	if (host_err < 0) {
> 		status =3D nfserrno(host_err);
> 		goto out;
> 	}
> +	fh_fill_post_attrs(fhp);
>=20
> 	/* A newly created file already has a file size of zero. */
> 	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size =3D=3D 0))
> @@ -334,7 +336,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> 	status =3D nfsd_create_setattr(rqstp, fhp, resfhp, iap);
>=20
> out:
> -	fh_unlock(fhp);
> +	inode_unlock(inode);
> 	if (child && !IS_ERR(child))
> 		dput(child);
> 	fh_drop_write(fhp);
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 6ec22c69cbec..242f059e6788 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -306,7 +306,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> 	if (host_err)
> 		return nfserrno(host_err);
>=20
> -	fh_lock_nested(fhp, I_MUTEX_PARENT);
> +	inode_lock_nested(inode, I_MUTEX_PARENT);
>=20
> 	child =3D lookup_one_len(open->op_fname, parent, open->op_fnamelen);
> 	if (IS_ERR(child)) {
> @@ -385,10 +385,12 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
> 	if (!IS_POSIXACL(inode))
> 		iap->ia_mode &=3D ~current_umask();
>=20
> +	fh_fill_pre_attrs(fhp);
> 	status =3D nfsd4_vfs_create(fhp, child, open);
> 	if (status !=3D nfs_ok)
> 		goto out;
> 	open->op_created =3D true;
> +	fh_fill_post_attrs(fhp);
>=20
> 	/* A newly created file already has a file size of zero. */
> 	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size =3D=3D 0))
> @@ -406,7 +408,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> 	status =3D nfsd_create_setattr(rqstp, fhp, resfhp, iap);
>=20
> out:
> -	fh_unlock(fhp);
> +	inode_unlock(inode);
> 	if (child && !IS_ERR(child))
> 		dput(child);
> 	fh_drop_write(fhp);
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index ed24fae09517..427c404bc52b 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -285,7 +285,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 		goto done;
> 	}
>=20
> -	fh_lock_nested(dirfhp, I_MUTEX_PARENT);
> +	inode_lock_nested(dirfhp->fh_dentry->d_inode, I_MUTEX_PARENT);
> 	dchild =3D lookup_one_len(argp->name, dirfhp->fh_dentry, argp->len);
> 	if (IS_ERR(dchild)) {
> 		resp->status =3D nfserrno(PTR_ERR(dchild));
> @@ -382,6 +382,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 	}
>=20
> 	resp->status =3D nfs_ok;
> +	fh_fill_pre_attrs(dirfhp);
> 	if (!inode) {
> 		/* File doesn't exist. Create it and set attrs */
> 		resp->status =3D nfsd_create_locked(rqstp, dirfhp, argp->name,
> @@ -399,10 +400,10 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 			resp->status =3D nfsd_setattr(rqstp, newfhp, attr, 0,
> 						    (time64_t)0);
> 	}
> +	fh_fill_post_attrs(dirfhp);

Are the fh_fill_* twins necessary for NFSv2 CREATE?


> out_unlock:
> -	/* We don't really need to unlock, as fh_put does it. */
> -	fh_unlock(dirfhp);
> +	inode_unlock(dirfhp->fh_dentry->d_inode);
> 	fh_drop_write(dirfhp);
> done:
> 	fh_put(dirfhp);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 8e050c6d112a..2ca748aa83bb 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1412,7 +1412,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
> 	if (host_err)
> 		return nfserrno(host_err);
>=20
> -	fh_lock_nested(fhp, I_MUTEX_PARENT);
> +	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
> 	dchild =3D lookup_one_len(fname, dentry, flen);
> 	host_err =3D PTR_ERR(dchild);
> 	if (IS_ERR(dchild)) {
> @@ -1427,12 +1427,14 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
> 	dput(dchild);
> 	if (err)
> 		goto out_unlock;
> +	fh_fill_pre_attrs(fhp);
> 	err =3D nfsd_create_locked(rqstp, fhp, fname, flen, iap, type,
> 				 rdev, resfhp);
> 	if (!err && post_create)
> 		post_create(resfhp, data);
> +	fh_fill_post_attrs(fhp);
> out_unlock:
> -	fh_unlock(fhp);
> +	inode_unlock(dentry->d_inode);
> 	return err;
> }
>=20
> @@ -1505,14 +1507,15 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
> 	if (host_err)
> 		goto out_nfserr;
>=20
> -	fh_lock(fhp);
> 	dentry =3D fhp->fh_dentry;
> +	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
> 	dnew =3D lookup_one_len(fname, dentry, flen);
> 	host_err =3D PTR_ERR(dnew);
> 	if (IS_ERR(dnew)) {
> -		fh_unlock(fhp);
> +		inode_unlock(dentry->d_inode);
> 		goto out_nfserr;
> 	}
> +	fh_fill_pre_attrs(fhp);
> 	host_err =3D vfs_symlink(&init_user_ns, d_inode(dentry), dnew, path);
> 	err =3D nfserrno(host_err);
> 	if (!err)
> @@ -1525,7 +1528,8 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh =
*fhp,
> 	if (err=3D=3D0) err =3D cerr;
> 	if (!err && post_create)
> 		post_create(resfhp, data);
> -	fh_unlock(fhp);
> +	fh_fill_post_attrs(fhp);
> +	inode_unlock(dentry->d_inode);
> out:
> 	return err;
>=20
> @@ -1569,9 +1573,9 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ff=
hp,
> 		goto out;
> 	}
>=20
> -	fh_lock_nested(ffhp, I_MUTEX_PARENT);
> 	ddir =3D ffhp->fh_dentry;
> 	dirp =3D d_inode(ddir);
> +	inode_lock_nested(dirp, I_MUTEX_PARENT);
>=20
> 	dnew =3D lookup_one_len(name, ddir, len);
> 	host_err =3D PTR_ERR(dnew);
> @@ -1585,8 +1589,10 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *f=
fhp,
> 	err =3D nfserr_noent;
> 	if (d_really_is_negative(dold))
> 		goto out_dput;
> +	fh_fill_pre_attrs(ffhp);
> 	host_err =3D vfs_link(dold, &init_user_ns, dirp, dnew, NULL);
> -	fh_unlock(ffhp);
> +	fh_fill_post_attrs(ffhp);
> +	inode_unlock(dirp);
> 	if (!host_err) {
> 		err =3D nfserrno(commit_metadata(ffhp));
> 		if (!err)
> @@ -1606,7 +1612,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ff=
hp,
> out_dput:
> 	dput(dnew);
> out_unlock:
> -	fh_unlock(ffhp);
> +	inode_unlock(dirp);
> 	goto out_drop_write;
> }
>=20
> @@ -1781,9 +1787,9 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
> 	if (host_err)
> 		goto out_nfserr;
>=20
> -	fh_lock_nested(fhp, I_MUTEX_PARENT);
> 	dentry =3D fhp->fh_dentry;
> 	dirp =3D d_inode(dentry);
> +	inode_lock_nested(dirp, I_MUTEX_PARENT);
>=20
> 	rdentry =3D lookup_one_len(fname, dentry, flen);
> 	host_err =3D PTR_ERR(rdentry);
> @@ -1801,6 +1807,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
> 	if (!type)
> 		type =3D d_inode(rdentry)->i_mode & S_IFMT;
>=20
> +	fh_fill_pre_attrs(fhp);
> 	if (type !=3D S_IFDIR) {
> 		if (rdentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK)
> 			nfsd_close_cached_files(rdentry);
> @@ -1808,8 +1815,9 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
> 	} else {
> 		host_err =3D vfs_rmdir(&init_user_ns, dirp, rdentry);
> 	}
> +	fh_fill_post_attrs(fhp);
>=20
> -	fh_unlock(fhp);
> +	inode_unlock(dirp);
> 	if (!host_err)
> 		host_err =3D commit_metadata(fhp);
> 	dput(rdentry);
> @@ -1832,7 +1840,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
> out:
> 	return err;
> out_unlock:
> -	fh_unlock(fhp);
> +	inode_unlock(dirp);
> 	goto out_drop_write;
> }
>=20
>=20
>=20

--
Chuck Lever



