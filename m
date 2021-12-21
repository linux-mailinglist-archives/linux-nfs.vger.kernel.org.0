Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A6047C597
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 18:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhLUR4X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Dec 2021 12:56:23 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11456 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240768AbhLUR4W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Dec 2021 12:56:22 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BLHK7kx023709;
        Tue, 21 Dec 2021 17:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nvHrLunxshDwnxgNSY6Jm3I+6qEUZ0+i+LNt2YpksKM=;
 b=x215+RjFHpKapD79actp9Wj/5IMCz+5vvwxtFrfZZQgDRJ45W4g1VZIXO3msVkEGSV/I
 hjon82Eubv4qvlOCv0wy3/Q9aNmwvJUmsexZ1Ec0BGclurzHqDN8sEu9MQtObt3XYaym
 bG4wIfU/vF7DqSevNBK8kXi+BREi+/tkgOEgE0FFxUrKxd7NeAZc4mjIDdEnyiFlU7h4
 qNU+i7X2loCthzr575kNqSLR9WxJu2VWSxpIjKUhj3eVKmLDmzVWW/clMS1DqKuYAQHN
 poLFU4fhxHjkbo402V9pjk53sr3BTPN1BG8yAK5iioxFSV4/p8+sNyjQARfjKBVOhBkL wg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d2qk2c1cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 17:56:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BLHbELm174820;
        Tue, 21 Dec 2021 17:56:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3030.oracle.com with ESMTP id 3d14rvvy2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 17:56:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQyp1e1oYSDffQV0k1ENyfHgJN/k2A+w1ZrD+v4xbhy+CASbBruv0d9oKHndYGSO72AA40JLyWo52FsBZRkuQB4d5PcoU5DjP6mOTTnCDUhUUVPEyb/RkyllVd3owO3Fzb0KyUrsw/HsPCJdX//zJJlLyYFDE++MeiDpModMfkoHobj2O5wf5Af3GjSgQJUK538TtyckW+L0qMpBvahEC39cHiYvabWe8H2PD+kxnDrQkiw5V82LZ9ScmgAumpMWtfxu+CD+S/pTba9QijPnkZCPfBG8FBgu97rgB5UIFR6BWACHlHz2RNfkw3c7WrqAMzffjFKn9YUNAb2q8q2JcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvHrLunxshDwnxgNSY6Jm3I+6qEUZ0+i+LNt2YpksKM=;
 b=J1kECdfQeEbvX/c0144xxxpcbYzxMniH1usIXcCkL8PM38sQk4OyUzKZgqD2OxJJW1uF9ES/jPN7ousGKA/HrVxX5W6h/kRj7vRjnHawZ/nDJdAoCpE/MFOxXG1nlTc4nG3u5K1szXfye6LN3bG7lRgfHrK71tVhwsW61AOSuOfDnoxvurWdZIyOW0JHfEtGfBO0wXBXn1TnJmK1nsz/nac9XjZqs3yIaN+0NZ+fvWEq+fBU0QVsnWRSdBPZ+PfBcPgPUPyjDuWkNnvium7icIFIfWz4twAFGHsVtQ5cW560CilZWAyny3N8H5rT1tdvQN5HozuM3OweMRduM/MYHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvHrLunxshDwnxgNSY6Jm3I+6qEUZ0+i+LNt2YpksKM=;
 b=m8lKhxKu1PPcfyQRe4ykr42eYqsy1aq8dBJGedFEomTjHo9yrHT8HdQchU4AUn94LCSwCY+NiGUe6BQZzPMzuomp9BYwrczGDQ1L7eaSjWGuTMEdN9wvC8McrpMaR7rV+eu9wqH9AkNQn5DgK+N48xeqfZSeqbvzfpQIEtUjNOU=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB3800.namprd10.prod.outlook.com (2603:10b6:610:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 17:56:03 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4823.017; Tue, 21 Dec 2021
 17:56:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Vasily Averin <vvs@virtuozzo.com>
CC:     Bruce Fields <bfields@redhat.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        "Denis V. Lunev" <den@virtuozzo.com>,
        Cyrill Gorcunov <gorcunov@virtuozzo.com>,
        Jeff Layton <jlayton@kernel.org>,
        "kernel@openvz.org" <kernel@openvz.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd4: add refcount for nfsd4_blocked_lock
Thread-Topic: [PATCH] nfsd4: add refcount for nfsd4_blocked_lock
Thread-Index: AQHX8xJJi0i//mNmDUy6e6NXpDYxh6w9QeOA
Date:   Tue, 21 Dec 2021 17:56:03 +0000
Message-ID: <F7169092-65F0-4D1B-A8EF-846EC0177F26@oracle.com>
References: <CAPL3RVGBN4SMCBbJcrdgpdZfsfb+AFiHiLhDOFmjkD0ua+XpNQ@mail.gmail.com>
 <943cfe47-d48a-4a55-3738-e93370160508@virtuozzo.com>
In-Reply-To: <943cfe47-d48a-4a55-3738-e93370160508@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee1f7037-a1d9-46fa-8b53-08d9c4ab27ab
x-ms-traffictypediagnostic: CH2PR10MB3800:EE_
x-microsoft-antispam-prvs: <CH2PR10MB38000C4591B3F31F22E1319C937C9@CH2PR10MB3800.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rvdlXv1w03q0G0N8h/fLTh3aANKrMpTJfPDSvAdKZHjp5n+c/lQcax/IMF4L2lwTOQGYL1iOB9QdNEmajSRiteze7LMKtouAeRvFI9z4ayYk5tFuGRgn6nuIf2hawzNxGKXv8riN0gH9/rgJElSG7I1R6E35zMb8kXXYoWVXxyb6abxptGnWqrfLMIpPIzXaWHFZQi4ctSp67CFEVwp+G4AyJeNbx8oeGC02nPIa/rBjXcduCYngyCTXm7OnEksJZxH7kk1prbZwN0BrX88sV5nKhNPCUXRtx0zX1Kmk6B6TEiKMKDXRILLvvswg8dEPOWRzrMOtv1/SGsNucII8FaATPY6TPEK/hwtWlwkl35c9gX4ywEtJkCwJXH0dEiEFmW7HCJ/3QvbLppXgqzOhPocEYADTRU/M7YY9Wr0cS3lnpJZSJ35kyeB+fB3UfKGaR86KY8QANF0XKsdKAy3qruqJPTtURkdVxrUsp2xTmsCE1HtzwIzBGK4H22KZS7LFLLWQSOlpXlXkaiiWePaDkoJoPsYZhswmPsBWxtct0C9r0c2cb+r8/GkvP9AxS8XwNJ+yw51PY1F00/qBhG3CoDx9EdaHVqG/GFtHGC7u4HbNzqETCcfy5ueU0iB3Z1p79LFXgfZtWGwiowyeFvT74dkON2V7e//hhVaRhHbVRTrMMmjIXHHht+gM0T+SFomYFiQs7wmJYn4mWvUsyA5fY+7LmHkISa++mdnbFX0Zv0XI5wS2geUnEceJpBJHbCIn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(83380400001)(6486002)(66476007)(5660300002)(86362001)(6512007)(26005)(38070700005)(186003)(76116006)(316002)(54906003)(53546011)(2906002)(8936002)(8676002)(6506007)(2616005)(64756008)(6916009)(122000001)(71200400001)(66556008)(508600001)(4326008)(38100700002)(36756003)(66946007)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FrOa6/fx720AuX1q6XBs5Rnc0eMSDV6cif0h5qdXTvNjlvlMZPqkM9XZF5W7?=
 =?us-ascii?Q?yUINnbceBo/1egeLpvhT3jyViI5r0Wq3oCmMV1XORE6cB9Zao1S6a1mK8D1z?=
 =?us-ascii?Q?pCEt7PvbxsNJJ3eL63LYWbWBX8jO/YdERSeeOmotSiilIC9YHRNmnMZM+r+d?=
 =?us-ascii?Q?VUtno23Y7TSqdKkRGgLXuy6OtOl3S/HZ+023JmPGHF2T3+w3vngkuABQSRGa?=
 =?us-ascii?Q?4jowitpMYICLNqpWq+V1JFn3pBK68VDwj6O6l1INU88jJxkBA7cPfJjgeE0H?=
 =?us-ascii?Q?7KTQ2JgoM93faKJ3Dj9qyzYha5DQu0PAnq2P2itJ6/b3KibSF60Mcxv8R7UG?=
 =?us-ascii?Q?WHO1pQwbWiFXmltqRl4cHOlzk28KeIuzeiVkHJe4XD/TKEGUDGg1qVfw0RcD?=
 =?us-ascii?Q?P43E0RqR41SLw+PExNHWv5uY/hlbwDmERQbGStJOPenHM8Iz1OlYuPUgCJNK?=
 =?us-ascii?Q?6XdjGdk5YF/zB3MDDK89RlfPI0RRQretRHsBlt67dc4+/HC6CHs32eHzvUh7?=
 =?us-ascii?Q?wyhgKApLjWL8RuwfeQZZh7/DKXqulSyBsJpeJR2ao3E1XX77/hwqlURr+nd3?=
 =?us-ascii?Q?spJUuOtB70I5ztlAnT2i9DYTLwP0ce7mzimMI4/xicxody2UtvTr1Q45AuDu?=
 =?us-ascii?Q?I3x7A90wO0cph+ctlzH2zpSLauNsDEGwtsamOCdWFm2OyLZIolcZieDQEqly?=
 =?us-ascii?Q?Vbs9xmiFLArcd7MLyhBmXvugqIypXYMNhiyDkSL2EeDx7dG8GExMxvpWJvJj?=
 =?us-ascii?Q?8b3LR/fmYafGc7PBOTIM4vQ3vGHeJWq7aDtmbK3WypQGCc5Yp4xh1TbDg2Q/?=
 =?us-ascii?Q?6w802hfeOyih9P3wkTpmpPxuKXaMOliLZ4NsvNnk/hXWJ0TWiDWbOHVEd2ep?=
 =?us-ascii?Q?fuPioHlUIRvMtOkv9fCRT2ZFvsBjuTNtOieHlTHGibmZgWnNVC6hv5gldHan?=
 =?us-ascii?Q?277CP0QgSkp3kIb/n7ozj1uuwdOhSM3qMydFlvoW5fz40LNcRUVWiFjocR7z?=
 =?us-ascii?Q?H9A63+dKfro1LRgcZL/ZR6g6FnLlGQFs+NKzUWZmF5Ii81nXMhf8o3dQXxzZ?=
 =?us-ascii?Q?BdCYd6JL02824D+Q2mpBcF6b6xIt0GMprHwbnZupCz0GonYEPgEU13Fxbigq?=
 =?us-ascii?Q?AFnGM9pa4FhH6cLoQ4inhgVVyjLlEKvav0exAIJfcYJw5VYsoUfdnldk2Iq+?=
 =?us-ascii?Q?apkl2LGFg+BBx4bP9T0qoX7M7pDI4s9xL3cPg2fN0BkNaHDHqSLB4YZImeCX?=
 =?us-ascii?Q?n6+R25T8WAi0qfAZJZ9eynoDq/BdrfdSW2v9RUNbMMLqkAxVTd9Sk1teboy9?=
 =?us-ascii?Q?e2Q2Y/26rx2kpE/7kMxw/H4eBITYs2eUMgE4dPDbXq2A8urKHMGMsrS+eCLR?=
 =?us-ascii?Q?JWmQvTgpsAIJ7AlwUS8DyYVn8O5/Q7LUJkp9PZ10Mnm2Y22gCdDg0TrCCQy4?=
 =?us-ascii?Q?sI5IueCAAjStqiAQ8TrvKzv70Ir8geSn1SeZzxWy1bhXJaxnmBRB7afv0xOF?=
 =?us-ascii?Q?q0GGAp6nfnoo+a5ThlpbnvVK+7otPaGLhFixdsNVQP+v9qubkZ8nIzjSt1Qn?=
 =?us-ascii?Q?7IasOJQI4f6t4hWdQ1QuVHtGCvqgSb4lVTpZ4YKVlahkafj3oMgf69t3YpRC?=
 =?us-ascii?Q?p/HDocHQnsrw4GtpNAhTGBc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1071198104E4CE48AE46C6FBB24525A3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1f7037-a1d9-46fa-8b53-08d9c4ab27ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 17:56:03.2391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /wPqKhi02QLAVEPpOfQ6n9n9bzJMR6Hpd++RZ6upGsZ/X1LUGt6+1TRLzPkJ4tzon8Qhrvl/BURLTeVOH+xKAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3800
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10205 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112210087
X-Proofpoint-GUID: XQtExIo74lVTNag2CCyBK27u9rcWO2nm
X-Proofpoint-ORIG-GUID: XQtExIo74lVTNag2CCyBK27u9rcWO2nm
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Vasily-

> On Dec 17, 2021, at 1:49 AM, Vasily Averin <vvs@virtuozzo.com> wrote:
>=20
> nbl allocated in nfsd4_lock can be released by a several ways:
> directly in nfsd4_lock(), via nfs4_laundromat(), via another nfs
> command RELEASE_LOCKOWNER or via nfsd4_callback.
> This structure should be refcounted to be used and released correctly
> in all these cases.
>=20
> Refcount is initialized to 1 during allocation and is incremented
> when nbl is added into nbl_list/nbl_lru lists.
>=20
> Usually nbl is linked into both lists together, so only one refcount
> is used for both lists.
>=20
> However nfsd4_lock() should keep in mind that nbl can be present
> in one of lists only. This can happen if nbl was handled already
> by nfs4_laundromat/nfsd4_callback/etc.
>=20
> Refcount is decremented if vfs_lock_file() returns FILE_LOCK_DEFERRED,
> because nbl can be handled already by nfs4_laundromat/nfsd4_callback/etc.
>=20
> Refcount is not changed in find_blocked_lock() because of it reuses count=
er
> released after removing nbl from lists.
>=20
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks. Applied provisionally to the for-next branch at
git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


> ---
> fs/nfsd/nfs4state.c | 25 ++++++++++++++++++++++---
> fs/nfsd/state.h     |  1 +
> 2 files changed, 23 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index d75e1235c4f5..b74f36e9901c 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -246,6 +246,7 @@ find_blocked_lock(struct nfs4_lockowner *lo, struct k=
nfsd_fh *fh,
> 	list_for_each_entry(cur, &lo->lo_blocked, nbl_list) {
> 		if (fh_match(fh, &cur->nbl_fh)) {
> 			list_del_init(&cur->nbl_list);
> +			WARN_ON(list_empty(&cur->nbl_lru));
> 			list_del_init(&cur->nbl_lru);
> 			found =3D cur;
> 			break;
> @@ -271,6 +272,7 @@ find_or_allocate_block(struct nfs4_lockowner *lo, str=
uct knfsd_fh *fh,
> 			INIT_LIST_HEAD(&nbl->nbl_lru);
> 			fh_copy_shallow(&nbl->nbl_fh, fh);
> 			locks_init_lock(&nbl->nbl_lock);
> +			kref_init(&nbl->nbl_kref);
> 			nfsd4_init_cb(&nbl->nbl_cb, lo->lo_owner.so_client,
> 					&nfsd4_cb_notify_lock_ops,
> 					NFSPROC4_CLNT_CB_NOTIFY_LOCK);
> @@ -279,12 +281,21 @@ find_or_allocate_block(struct nfs4_lockowner *lo, s=
truct knfsd_fh *fh,
> 	return nbl;
> }
>=20
> +static void
> +free_nbl(struct kref *kref)
> +{
> +	struct nfsd4_blocked_lock *nbl;
> +
> +	nbl =3D container_of(kref, struct nfsd4_blocked_lock, nbl_kref);
> +	kfree(nbl);
> +}
> +
> static void
> free_blocked_lock(struct nfsd4_blocked_lock *nbl)
> {
> 	locks_delete_block(&nbl->nbl_lock);
> 	locks_release_private(&nbl->nbl_lock);
> -	kfree(nbl);
> +	kref_put(&nbl->nbl_kref, free_nbl);
> }
>=20
> static void
> @@ -302,6 +313,7 @@ remove_blocked_locks(struct nfs4_lockowner *lo)
> 					struct nfsd4_blocked_lock,
> 					nbl_list);
> 		list_del_init(&nbl->nbl_list);
> +		WARN_ON(list_empty(&nbl->nbl_lru));
> 		list_move(&nbl->nbl_lru, &reaplist);
> 	}
> 	spin_unlock(&nn->blocked_locks_lock);
> @@ -6976,6 +6988,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> 		spin_lock(&nn->blocked_locks_lock);
> 		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
> 		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
> +		kref_get(&nbl->nbl_kref);
> 		spin_unlock(&nn->blocked_locks_lock);
> 	}
>=20
> @@ -6988,6 +7001,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> 			nn->somebody_reclaimed =3D true;
> 		break;
> 	case FILE_LOCK_DEFERRED:
> +		kref_put(&nbl->nbl_kref, free_nbl);
> 		nbl =3D NULL;
> 		fallthrough;
> 	case -EAGAIN:		/* conflock holds conflicting lock */
> @@ -7008,8 +7022,13 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
> 		/* dequeue it if we queued it before */
> 		if (fl_flags & FL_SLEEP) {
> 			spin_lock(&nn->blocked_locks_lock);
> -			list_del_init(&nbl->nbl_list);
> -			list_del_init(&nbl->nbl_lru);
> +			if (!list_empty(&nbl->nbl_list) &&
> +			    !list_empty(&nbl->nbl_lru)) {
> +				list_del_init(&nbl->nbl_list);
> +				list_del_init(&nbl->nbl_lru);
> +				kref_put(&nbl->nbl_kref, free_nbl);
> +			}
> +			/* nbl can use one of lists to be linked to reaplist */
> 			spin_unlock(&nn->blocked_locks_lock);
> 		}
> 		free_blocked_lock(nbl);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index e73bdbb1634a..ab61dc102300 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -629,6 +629,7 @@ struct nfsd4_blocked_lock {
> 	struct file_lock	nbl_lock;
> 	struct knfsd_fh		nbl_fh;
> 	struct nfsd4_callback	nbl_cb;
> +	struct kref		nbl_kref;
> };
>=20
> struct nfsd4_compound_state;
> --=20
> 2.25.1
>=20

--
Chuck Lever



