Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370AE3D5BF2
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 16:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbhGZOCF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 10:02:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61272 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233206AbhGZOCE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Jul 2021 10:02:04 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QEeYC2007896;
        Mon, 26 Jul 2021 14:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4Mepci37jzrZ0fgUH2cWAFugtnnNyUQjcNGFPB3EJ8Y=;
 b=wl+ifU+ZknKAJ0Mzgt7Vw1fwblfh7E3rk+Tl2EG5frUM9RT+B7v0BjRNCz6E4RPcRmvt
 0pp3Vk9N783NNC/iMaov49fHrci2z65CeIMRF/+O4IhK8rWzuisgud9wqIHBYFy9+Uvu
 BkkgNX6Ju9gurIuMoHSbF7oY1rFkyk9hFPuy9rDT6YW7McQ5pGeSvCVCGpgdyIQ5mUuz
 0kS4EVkm5s0aRuXolYSUmTOmC4JRFV5C6GQrEKGRk6iX6X6jhhoXX88jPasxna4Weal2
 qmShJ7PERGIpo25rbaX2oO6R9tXiAcvnP1gGT7Ob30HJdbMomBGqCfnC+m8ihpVcEwy5 Eg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4Mepci37jzrZ0fgUH2cWAFugtnnNyUQjcNGFPB3EJ8Y=;
 b=K/MvsE6n3urRZPdu7pVWdDpAqpN54zyVT1MR57P2ezhJoqTabPXqudsRc1B3HpxtWBF2
 IKYzAWb99JlVUH7EDEKjpYfeTFY7GTn9DGNo1T1tOBPJUU8lBSfoMWD+dytsHFHVnxlx
 G1nLJkBAZp9OqTg7dE7FkiRIn2Y/VxlKx8xssZy2hhKkF/cUKmbETcxmmu1gfyMYxw4X
 uf2aBqF8i2gv7ur8PYsTZdVdtTJ5lZc6J1HY2UIGh3euuOcF73T2785TiQelK/Pl8mdR
 QK6pBOFsICtPGqZKY0dQ/3bwI1cM3/3d0LeaDOsE786sFkLzVeYVdIa6Ma87yEBkfUHn 7g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a1cmb1pnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 14:42:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QEddNQ075820;
        Mon, 26 Jul 2021 14:42:29 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by aserp3030.oracle.com with ESMTP id 3a08wep1q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 14:42:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ck1PGhGDXuvSU6Gi/aGqzkCTW+uyXN/i8PgLZp2oj4n6wQTQcCKkjUeVfqwnzBQd2SeF5kD93SeF53OCqbdtbiHeJauDIR+oom8lBnjFHFINBjZEz3spyKHU1RAHIBldwJz01fSIl1ZFt0ZzhNYwX2c8CGZ7EkzRnF8fzNWk0+EDeybd/X6gSzYv/YrcsuMuGKyaUrYMyI+3Mz9PGzlKdlWWeNarrlJngSsYClpW8yLnF7FFJjcfSrAn/V/vbx2ypEAjQKHCS+S9HhsPYVIfPcZTrCmssUmdh1wKpnxYMtYCiExmYQRLhpdAT4VKal2FdkicZxA8VtZt65uYtjD8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Mepci37jzrZ0fgUH2cWAFugtnnNyUQjcNGFPB3EJ8Y=;
 b=EChfwlzMZzKjTECyzC7RC4rPkiQ4+ccFd0UxjQG0Mr96oS7J6QalUEiJ+nkDsvGRqNgW/jQWyi6D+JAmW+WoMDVoiuLIrSBEiW2kLtxNMEQWk41914/mn3fDk4fytlSXy4jDz7T4DMjFv9h0gBESNBkW1Wmm3TMZKymRpBt+CzBbIQASAphhmXKqDa8fSiKYVavy8fhz7T2cHQ1uw5pNwe+DVWSdmswiM52TKvhSmo3SmRXEu6vCdTkAKYSFve4TSY4OE4MKVWp6lH3duRQw04UiFDeSj1K8xu3pimm0+gPPmK/BQ32Iwesgwjfwwgen7swz26xHl0/LNf1JI+sW+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Mepci37jzrZ0fgUH2cWAFugtnnNyUQjcNGFPB3EJ8Y=;
 b=mDJ8JXr5sU5hSxPY5H88WwQzV53ivZh5p+CP+p6P2H1HV5CqherM1GGDNHzgwM/TjxWUPBaaNdkT7HGkeWvN2WeQbHyTXpSQ9FvtoE2QCLYmFy/+4gJ9Yrd77tJGSKrMX6BbnkTmEQVvtnQH60Vv6PqEy6S3TSdnhbwhmbw8j3k=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB3858.namprd10.prod.outlook.com (2603:10b6:a03:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Mon, 26 Jul
 2021 14:42:27 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 14:42:27 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH V2] lockd: Fix invalid lockowner cast after vfs_test_lock
Thread-Topic: [PATCH V2] lockd: Fix invalid lockowner cast after vfs_test_lock
Thread-Index: AQHXgiLZkl3s3GdWP0aN4lK0XjVvSqtVVKKA
Date:   Mon, 26 Jul 2021 14:42:27 +0000
Message-ID: <0B397787-45A2-4469-B48C-3A1182B24307@oracle.com>
References: <f94e02c019495fea4495fbef7498f342d5848dac.1627217317.git.bcodding@redhat.com>
 <a060024e4cde48b224a7b4aecae7d20423ce506f.1627306204.git.bcodding@redhat.com>
In-Reply-To: <a060024e4cde48b224a7b4aecae7d20423ce506f.1627306204.git.bcodding@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0aa63848-30e6-44d2-8711-08d950439714
x-ms-traffictypediagnostic: BY5PR10MB3858:
x-microsoft-antispam-prvs: <BY5PR10MB38585BB2D018954415F42D5493E89@BY5PR10MB3858.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 87cFQ/BlPjUloKXxPmKKAfEMJiB01wSLhWdxKn4AuX6IPMv+ZxaAtp4o+HFvZN5/FgWIsNHNFWToGURnQWZCmTaJVgpdVGVy04fNlUgxC4LDcBIFxlQf7gUAITq8xHkdq5yE9k2418LxR9eCcKWiYWuedKdEVsEvlG9i1FNhh/cKxiKIW4X1JLC45vYvyN+Y7lvWjJJJdb2DufaSchTlJCRNwICXhtJnM4coS1jUS2wM1L6uFG5EXgayOwWydounhJw1YQLTq0WAlH61AUxR+PZTnWGbXXRD6wLoqHPbPt6+VrBS3YtjNJUAuQq1VbbJGn45p1LrfUXyaKFbn9A3VAmNc+WzlwEVEzb0HyEh+UP3Ne1BluI34wrCZGWEY1LZJXyTtsFH6/3x7KAul5HzU4qX9jJQJNwmerh3SBklgOi1Az7v8lkFqbUOZvNMWRI5NeBQN4szv22rYitCc77Anc6OwT8o+7rY7nJkapuQZ0+UNZj4tqWc4h0KH8XqYL0gLZuu2meconqpYjiLipj7m2rB+6iG5rDJ0LgW778cbdnXf1nSOkcor/rAnGgrw6DtnP2fI9dtfkHQ7uly+l/EEHlPX3WEYtlGHLciocTnJODCC3FHgX5W8LYPxcaoBoBky36wfOarug5tNmV3r3G4un5Jk/7LOjzXFTuM52AO0As9trhTw5zH0+qbPTYCaEJ+QkbkfyKrPumUTD8xoTq9+ra2p/AFU4STrmVlCtEYnF4Cc19PSkfMJG097V2h1ieBy8b2gg2UBb6kYqmey+tmQiLnIrBZWwo27LXlWDA9MjrbgtWD2GvV/TxIG0CjGI1Tk7YhCA8sB63iiClOL9kXvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(39860400002)(396003)(136003)(36756003)(83380400001)(66446008)(64756008)(2906002)(186003)(33656002)(76116006)(316002)(8936002)(91956017)(66476007)(4326008)(71200400001)(8676002)(38100700002)(86362001)(26005)(6506007)(122000001)(478600001)(53546011)(66556008)(54906003)(6916009)(5660300002)(66946007)(2616005)(6512007)(966005)(6486002)(38070700004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pv1xS5J/mkpw+xtf/pb72I4Tc/QYt+zvAd2koHwhi2q+CytyWJmKuhogbo0a?=
 =?us-ascii?Q?cpxn5Iutas9b0LcYUcwnVENMPSHJRKJN7NRRcbEL16Hhh4rfEah41RWdUP5J?=
 =?us-ascii?Q?9dm5zXuFQ0uENyxoXttFIMAbCoQXb1MiXCWXQkL5cluUfZLRQQA7I0kvH0+s?=
 =?us-ascii?Q?qZUxd+uyLFHGs7/wrxlZkfSvy93uumW2ZkcndeGtDHfOV6k13GtCVdEX0st0?=
 =?us-ascii?Q?XuDme8UeVSoyHEY34kFVdC0RjWfaMfaFNOFATSFq/1ZNJG9NhvpHLxTc2yrL?=
 =?us-ascii?Q?LYt6liESX4wiokhfl6KHttMlij3Q5G5ULaUK+nZp6eyKM5hR3RvsFniUdAsX?=
 =?us-ascii?Q?EvM366skWuEaKHbC+8BP8F+GKxiQ5aEeTxaHNsISAXnbJMYHAj+B8MUEOhOS?=
 =?us-ascii?Q?5l6RN3OW/D4e8ispMh6iHHhuCepJoIOKjbq3p+iUlikZsl7rD41YVvW8K3pX?=
 =?us-ascii?Q?nN1kG2MNf2RdKB5LhbDKtcnfzLMHe51vPeayuwjeDZ7XoYHU1qCBX2w4Bnnn?=
 =?us-ascii?Q?nicn+3mO7OD5V3qEyq73dpCpMCQtcha9kGg+D1DbwIHhlv+lNQ6D2oSXntoz?=
 =?us-ascii?Q?jdLmUan96aFALd4a+xDCjk91tQllnmpsw1OXpnqQsXFfamgwmCuky+PW5Ik4?=
 =?us-ascii?Q?pJh+zwokrQXnPu3EtmR40KXmh2eg4Xd5egkA2dbSXsyy1iTiGWVm/8Suvv4Z?=
 =?us-ascii?Q?z2dWYHrni+FsnK+2wZBjoAthmk1eAPF0CL+iKFAHqHh33Y10to3lMYmaT5Yr?=
 =?us-ascii?Q?ImmVxglGpV9OTpc3OD5YUTzr0sy4R2ogp0vbHPl2bPKdzf4tM2U1Qgma+a7z?=
 =?us-ascii?Q?NRq0qCpqE8k9PQF8rXDza/6bQrPT7Y6J66Mq5VF+fby++y6kIdnN5P6h88he?=
 =?us-ascii?Q?Ue3hasVdoRoAAy7Ys6nVTekO0MhzgfvT3c9SyxCaT+MpTC4sfEa0u8zfnULL?=
 =?us-ascii?Q?SHLOPs3QtIk4dMKRlDES9gfgY5pgzPt0qCMyCvB0MPcuYboGRTIt22tb9n3e?=
 =?us-ascii?Q?xYO5ZnU+SqcCYEZgl6Pgktz7dvG7m8CWTQy1YFHYHvQNSRRp9chiriLjJ4Cc?=
 =?us-ascii?Q?cvrhe5i2TTPwd8H2Pz+uvvyswYMxks4OgIv4LDF76jIAaqScoSUzJQ2raedn?=
 =?us-ascii?Q?igAwMIHh/QDMbg118+5alOTXjulY492psWnN/PeLlRkhKNxXGA28Eq51BLjW?=
 =?us-ascii?Q?U8MU1qlozZb7/k8mvcVqAMmMxc1uqVt5O3Orcyrq1VQ60JSKjBsZ+zGrqq6P?=
 =?us-ascii?Q?k+py7mPDwViIRXUMFl3mDjZpZWlF1o5BxJggFcuY3S1ywgUz+Y9p6zLqqLGl?=
 =?us-ascii?Q?EzzTpdchm4IqTOWEOM3nmBvj?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <77DD07A7E27CB341B5DBBB26AB05B370@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa63848-30e6-44d2-8711-08d950439714
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 14:42:27.6147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1dvhI6mZe2qskiVKit3svWuxDMNy+VFf0hYsCGZNCbHI+28YkoOB2yTZ6fffFqQaeJM6P/o3TdSVGPzgT1Khng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3858
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10056 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260083
X-Proofpoint-GUID: jd95jSTtgG345a7f1kWKtwp6KYkEL_t_
X-Proofpoint-ORIG-GUID: jd95jSTtgG345a7f1kWKtwp6KYkEL_t_
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Ben-

> On Jul 26, 2021, at 9:33 AM, Benjamin Coddington <bcodding@redhat.com> wr=
ote:
>=20
> V2: fix typos in patch header
>=20
> 8<-------------------------------------------------------
>=20
> After calling vfs_test_lock() the pointer to a conflicting lock can be
> returned, and that lock is not guarunteed to be owned by nlm.  In that
> case, we cannot cast it to struct nlm_lockowner.  Instead return the pid
> of that conflicting lock.
>=20
> Fixes: 646d73e91b42 ("lockd: Show pid of lockd for remote locks")
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>

I've added this change provisionally to

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=3Dfor-=
next


> ---
> fs/lockd/svclock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index 61d3cc2283dc..498cb70c2c0d 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -634,7 +634,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
> 	conflock->caller =3D "somehost";	/* FIXME */
> 	conflock->len =3D strlen(conflock->caller);
> 	conflock->oh.len =3D 0;		/* don't return OH info */
> -	conflock->svid =3D ((struct nlm_lockowner *)lock->fl.fl_owner)->pid;
> +	conflock->svid =3D lock->fl.fl_pid;
> 	conflock->fl.fl_type =3D lock->fl.fl_type;
> 	conflock->fl.fl_start =3D lock->fl.fl_start;
> 	conflock->fl.fl_end =3D lock->fl.fl_end;
> --=20
> 2.30.2
>=20

--
Chuck Lever



