Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E20419830
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Sep 2021 17:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbhI0PtO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Sep 2021 11:49:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55470 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235202AbhI0PtM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Sep 2021 11:49:12 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18RF5PG7020794;
        Mon, 27 Sep 2021 15:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6aTvokLc2ax0RfF04L/yRzq+oueKRU6wx/FfZ7aV3Ek=;
 b=lxcPKsgJZ9HnfIKfOmwhUrS8wRFFOkiVHqwDX/rDmykYoPlYR0aVPMWuxw8tF84iPd+5
 ExZ/qXpgNSxq4AB6yUGfPBjGt6KMjBXtZkQqcciKblcyroDQYMLleD+XVKM/YJ5owbQx
 0u84PPhJ3DiCIXEBM9IhZ27tASzES3XThHoUMqINKaD/qr6stzqubFpzr1zMwtofuefg
 O+Ztibe+ND7xC8QwDZohHAAeC+yqI5hZiQIEGm1rAcNczFU/B1mn/NYiPM3F5cwSh54f
 L+6SdGbXKftpQgR0pEH+8F8ohpN7VcIQkebbrYX6lOGsmRyCZLZcnHEoo06nveG7dga5 +A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bbeu11b9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Sep 2021 15:47:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18RFj7MY085169;
        Mon, 27 Sep 2021 15:47:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by aserp3020.oracle.com with ESMTP id 3b9x50knnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Sep 2021 15:47:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFF/tZszAWXkclF5jfcwzIyy/y0mxkfPbrRV8axdp9thS9p//kJeAkmZNUhjgQBLwix7oeGpSk+VYlvzoL9UQSDaVyNMKOp6wVl0FBg2FcwnJxkjZiQtkGovOxfC+OIUaoa/tnzDlHftLQEk/67OE5I+eemS+XVpfG0vbezply5QPzpnnYTpcXIvL0LvB2zYT5XU0Tdp9eMVheYZvpV4ONRvVlL9lEsEpT7nS0q65Y6gYSkKJskaTamwPTiwjNULQ3I04p05QMoUNenLJQkvw/xAVWjZ6sojBm97mBt6El4TLrWNdC+GeilyRVVnMKMPoxgmPowRiBmX9ToLsnog5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6aTvokLc2ax0RfF04L/yRzq+oueKRU6wx/FfZ7aV3Ek=;
 b=daKbiRZIeF51rpgLBQJ7qJEc99vRDegxTagzU/Z5hQ/B64oydkHthLByj3VsP3GIFJom3/L1z+FYyCHmxDYo3t2vQOsEb7b1I3RhwbZZbWZyJSYh+WOLy8gZSlbl7E8W+5b4fUDzz2ypLF93sacXt7atR6Buo3WrdAkKtHNrJ7nTbwJ9I30ITazT3SVFnd5bEDhmlG3tamoCe/K4iem0stLMRDgVTZrFAJl2yh/eDvk6CuaiwK42q/zegDNtBPpvsTN8C53j+C6gx983OuK1oKZu56YuD/xG0KBT2ak1gA1smuqKJD2lJ8OllQTM4Bn4cfPi7P8VmahshbIClk2SSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aTvokLc2ax0RfF04L/yRzq+oueKRU6wx/FfZ7aV3Ek=;
 b=hGVw+T7h8gCSXU7apaRdsS7A0VaCm7Zq1ZXfmimxZVaenwbtPwQo4O1pc8miht1ijaLkAy/t25VJhL2gW7tMmhm/camBth4EW7sKoozbOq8JvdrSGUU+1SxTSTttdL9Dxjcygs5V9qwATfOWCa+RW2FntdrHMWftTwMI1zAb4ik=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Mon, 27 Sep
 2021 15:47:27 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%5]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 15:47:27 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFS: Default change_attr_type to
 NFS4_CHANGE_TYPE_IS_UNDEFINED
Thread-Topic: [PATCH v2] NFS: Default change_attr_type to
 NFS4_CHANGE_TYPE_IS_UNDEFINED
Thread-Index: AQHXs6bfMg3A8oydekeHlTQ76MxxXqu4BqIA
Date:   Mon, 27 Sep 2021 15:47:27 +0000
Message-ID: <A0636BF4-62A4-4821-BE12-DC846B2CE389@oracle.com>
References: <20210927135206.4455-1-trondmy@kernel.org>
In-Reply-To: <20210927135206.4455-1-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee081176-747a-4ddc-dcee-08d981ce1bb6
x-ms-traffictypediagnostic: BYAPR10MB2966:
x-microsoft-antispam-prvs: <BYAPR10MB2966ED81E2119A75BD836EC493A79@BYAPR10MB2966.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XwJaY1e7yuu/wkyNM6SCOtXF0vUd6AKOxt6Tu0SQS0mc3nUT0z62vCSbUueTmvPC7i9X7xQaTcni12WTNRf88Mdpjq3t118pzu5dhKK3b+LvxGE1TWmlqe/Os4VBvvOyLPn+axAu8zc5P8lf5Un8RGkBErITyrqH4ALGXDOaIlTLtYBNkC8Dspb1Sn53IHgAgBS9NWNkVNWUY7Ed57A/x7TxZ+Dvy3Od+FZlrssMQ1faFMGwwKTrMoUkUjk+mpyiB+N6jOfFY2hMQvU+UAIoTgjOEUXiyr8lOfCs9MSjTBh5eognGRyy2zw9YOfvS7wvMe3OLjtYfgSfM+mQeU6s1rMLbdvbWgX7iLrQ+zQZaRFmJiGN5FI0Cu7BcS6OyYEr5yFVc3ADlVNK7wQ9sQm9GHWv2pYNkvue1Lzg0tDctUZH5iX/UcjinvkI9h98SSlB38hlHqVKkR7jEEeeMvGkEXEswqNMDm6zPTcr0LL8q8J57d/wOooU7GmhifWjOLtPbwdatQ7rAjr2geF+1XxuxCUgbgPbAb/O27NMXPAXsR09TdFvmZYgDOhsx8pNe1QLAEsJdMxAt7jGm08mmlsmlucDhXcuhvlzOJZwtF5RVekYaWmim7wtOdaXyX3jhv16yNG6T6HfC2JO+WmdfNknXJi6GAPqOrj3KBtUfoJ8rQtZDCmb6WYp9UJKa3c+hcwIl0W8tYZw8YS+Kz8CKje2AUuMF1QR/GoaIp3BoltK4bmmLjcZEC68MzmgeDVzHMGT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(64756008)(4326008)(6486002)(36756003)(38100700002)(83380400001)(71200400001)(26005)(38070700005)(6512007)(186003)(66946007)(8936002)(54906003)(122000001)(66446008)(8676002)(66476007)(53546011)(91956017)(76116006)(5660300002)(33656002)(6506007)(2906002)(86362001)(2616005)(316002)(66556008)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jaQMl9+0mWMZxIshlktSuFLoX1B2Uae2lHeNDdUGzAkRWKotalbLU/GzDd2I?=
 =?us-ascii?Q?IubTKjDyFlUxFJNkcX/mCM2IFfdr6gSR4y2vj5RM35DJpIA2AFFFsEVKWOsO?=
 =?us-ascii?Q?Idq+cbfCMmugIqpEebowUaD87QMshlHO7po3l2YuC37qNkfnJ+2V+3tpPmPe?=
 =?us-ascii?Q?LLD8IaR+Wq/fzyVT0eEm6wWSfEiTLu+bHAvLM5zBhWyAOXasuYKMgGXq6Ot0?=
 =?us-ascii?Q?yym3hZboLuwpKCNHYMpA9eB1nq0rdEIw1aa1MMj1zrY9yNMa30yFKzYhfXtE?=
 =?us-ascii?Q?u46ZRtC95heeYf/PNWJyQZPhyfbV9c+yaYXV5uVAEPN0LBaoRgmePZO5Ds/R?=
 =?us-ascii?Q?7jFxyS2RlHMtdULjihJOUGS73d1H8rXMzF8hBS94NwMCUE5zG5SGsbpPFAtO?=
 =?us-ascii?Q?OL4iZsv8DDJXMbqvmEOaDkh2ZFVRr1AoeM3HsIIELhy6j78XM5WQ86puD631?=
 =?us-ascii?Q?V/pdUfgXAzFDDvpxJxnnaLckMGwO6tGAdO/aEuDcdSmCvqv3ZZqlSsdWUkTt?=
 =?us-ascii?Q?NuYkNKMEGpDVOVT8HWSn09tkI0KwlELNmjwZvLYjcZ2JNoinCD287UYUr7Od?=
 =?us-ascii?Q?wdvtWpvyfhTkbjIX3hvX1etTghxUfOZR4WyPbydQtpuXOIbjy/Dod2eDYyC9?=
 =?us-ascii?Q?eJ1F3Uj+Whd3K94FWaIhIjzS/T67kDmIWGWa61zoFE/2mGX/TcmLaT4ElBPR?=
 =?us-ascii?Q?X7vEl1AuuKfynKoy+sptOJFxLcjvCqKcoS1gRZ6YQnZ08nlkuEvlmurqvhYJ?=
 =?us-ascii?Q?GErKlnRbN4gF30ahEEiKn0JmA8slymnNc4AhbCUlFhkWjdB5vx5JEGWSxWsC?=
 =?us-ascii?Q?ErRv9ND/s+I1G1DdA6seUwBNrlmzIgR6AnTKtfu9L8zXUjMr+5ht/feNwh6O?=
 =?us-ascii?Q?ftpKCXxuCgwqsA7ry++1QgbqoHz7ido8cl+mnmwwYzgE1qvddp01EEa55AOM?=
 =?us-ascii?Q?7EcC8pEiJ6/N6fyEzipeari/63g6YlnTBGRpifSl5Tm6mER2FefXJJUTnxr5?=
 =?us-ascii?Q?v7Ebs/7iEx8jQRCgcvHO777877+INmNsKp/n4yBhzD+1ELlqZYFifMGZtcG1?=
 =?us-ascii?Q?vM0m/F3Ua0PoOor/UxHszdAIZ2nT5DOWD6Q7A/JwTo3YDD60IdiylFQMubfK?=
 =?us-ascii?Q?ZNLV2YuzPn/OWkRW3tFpxmzdPBplP0ZQUYF9hol176oseClzGJulIG4mGZoZ?=
 =?us-ascii?Q?BN/ESWnf+malkaJ7rXR5ld2AiVjHezglskfLIfgTnvsIbJenH32AmK5MY99W?=
 =?us-ascii?Q?0cqDG9ryreTOZt4yHTJj0atD2wgyB/1SXXYVZixQC+feR38I8U2tt2JBx0Eh?=
 =?us-ascii?Q?B+hzBudzey8ihKTOQ9Z9mhPd?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0C864EFC9751D844863782A382751F6C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee081176-747a-4ddc-dcee-08d981ce1bb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 15:47:27.6277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/X8T6UDROgfQRFboj/F/VOnJ/MMYG0/P2trHcmGk86c83WuYS9/V7aO4Vaev1p9j3wVK1Ak+thp06vZDW0Mlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2966
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10120 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109270107
X-Proofpoint-GUID: G4ypfoyLGIM9gUD2D_GXQuc0TXHJR2h2
X-Proofpoint-ORIG-GUID: G4ypfoyLGIM9gUD2D_GXQuc0TXHJR2h2
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 27, 2021, at 9:52 AM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> Both NFSv3 and NFSv2 generate their change attribute from the ctime
> value that was supplied by the server. However the problem is that there
> are plenty of servers out there with ctime resolutions of 1ms or worse.
> In a modern performance system, this is insufficient when trying to
> decide which is the most recent set of attributes when, for instance, a
> READ or GETATTR call races with a WRITE or SETATTR.
>=20
> For this reason, let's revert to labelling the NFSv2/v3 change
> attributes as NFS4_CHANGE_TYPE_IS_UNDEFINED. This will ensure we protect
> against such races.
>=20
> Fixes: 7b24dacf0840 ("NFS: Another inode revalidation improvement")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

[root@morisot ~]# mount -o vers=3D3,rdma,sec=3Dsys klimt.ib:/export/tmp /mn=
t
[root@morisot ~]# (cd /mnt; /home/cel/src/xfstests/ltp/fsx -q -l 262144 -o =
65536 -S 191110531 -N 1000000 -R -W fsx_std_nommap)
All 1000000 operations completed A-OK!
[root@morisot ~]# (cd /mnt; /home/cel/src/xfstests/ltp/fsx -q -l 262144 -o =
65536 -S 191110531 -N 1000000 -R -W fsx_std_nommap)
All 1000000 operations completed A-OK!
[root@morisot ~]# (cd /mnt; /home/cel/src/xfstests/ltp/fsx -q -l 262144 -o =
65536 -S 191110531 -N 1000000 -R -W fsx_std_nommap)
All 1000000 operations completed A-OK!
[root@morisot ~]# umount /mnt
[root@morisot ~]#

Tested-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> fs/nfs/inode.c   | 4 +++-
> fs/nfs/nfs3xdr.c | 2 +-
> fs/nfs/proc.c    | 2 +-
> 3 files changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 4f45281c47cf..0f092ccb0ca1 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -1777,8 +1777,10 @@ static int nfs_inode_finish_partial_attr_update(co=
nst struct nfs_fattr *fattr,
> 		NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_OTHER |
> 		NFS_INO_INVALID_NLINK;
> 	unsigned long cache_validity =3D NFS_I(inode)->cache_validity;
> +	enum nfs4_change_attr_type ctype =3D NFS_SERVER(inode)->change_attr_typ=
e;
>=20
> -	if (!(cache_validity & NFS_INO_INVALID_CHANGE) &&
> +	if (ctype !=3D NFS4_CHANGE_TYPE_IS_UNDEFINED &&
> +	    !(cache_validity & NFS_INO_INVALID_CHANGE) &&
> 	    (cache_validity & check_valid) !=3D 0 &&
> 	    (fattr->valid & NFS_ATTR_FATTR_CHANGE) !=3D 0 &&
> 	    nfs_inode_attrs_cmp_monotonic(fattr, inode) =3D=3D 0)
> diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
> index e6eca1d7481b..9274c9c5efea 100644
> --- a/fs/nfs/nfs3xdr.c
> +++ b/fs/nfs/nfs3xdr.c
> @@ -2227,7 +2227,7 @@ static int decode_fsinfo3resok(struct xdr_stream *x=
dr,
>=20
> 	/* ignore properties */
> 	result->lease_time =3D 0;
> -	result->change_attr_type =3D NFS4_CHANGE_TYPE_IS_TIME_METADATA;
> +	result->change_attr_type =3D NFS4_CHANGE_TYPE_IS_UNDEFINED;
> 	return 0;
> }
>=20
> diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
> index ea19dbf12301..ecc4e717808c 100644
> --- a/fs/nfs/proc.c
> +++ b/fs/nfs/proc.c
> @@ -91,7 +91,7 @@ nfs_proc_get_root(struct nfs_server *server, struct nfs=
_fh *fhandle,
> 	info->dtpref =3D fsinfo.tsize;
> 	info->maxfilesize =3D 0x7FFFFFFF;
> 	info->lease_time =3D 0;
> -	info->change_attr_type =3D NFS4_CHANGE_TYPE_IS_TIME_METADATA;
> +	info->change_attr_type =3D NFS4_CHANGE_TYPE_IS_UNDEFINED;
> 	return 0;
> }
>=20
> --=20
> 2.31.1
>=20

--
Chuck Lever



