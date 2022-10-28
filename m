Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8971D611B32
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 21:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiJ1TuF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 15:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJ1Tt7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 15:49:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48E62D77C
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 12:49:56 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SIxIaS028036;
        Fri, 28 Oct 2022 19:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nriMbUqWXIN1rWK31HVNXBFJbBT82fWwtz1EkCDLsBQ=;
 b=M1/EQ2FsCowAKWhWruFvYTJKdJv6rmMdMGSE89rGE+U0nVcB+kqWs5bFTzeRAYIFwv+f
 HG8I7r7/oFD5wOraMvLUt/34F6WJdEBExtLHLOWhjZ2XycY/u6KsXyvxZpnu+/JakAre
 Xekfy0hElp26c2NcaYv4jk0OJQe8H6sgzvfQbf+Hspv6s9sovrae+e2b/KS8S0IoIebt
 KcWDgj0LC4bwpCCoAKS8inA0NmiMmCzsXuFiWwyAJ16HbQxOkx2gcQTuDmadqG4LVL9J
 24wEiNUCF4AAy57RuB6ZV/bvRrUYW5P3Lzm6KbTDhmFva/6p9rKEO8dotdxPid/OiiYM Mw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfax7wr79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 19:49:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SHQm7d009475;
        Fri, 28 Oct 2022 19:49:47 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaggcmp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 19:49:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsdBn2ccfymhFNLjjHajWelni4+frpVon4E7FELq610nRNQKOyMd2JQ5iZrYmgyUVM2lY9NqvZdH96+o51RIdf44k6tOR04wpaNAlCep1ZlR+hDAbRvKsP3BsJCXK7kU46dPGVkFKnjR3SfphEbm/ELBAa1Sn2Ja4xSvw9Uzhun+y7zoZoQay4aM2jDM7Lp4BUc1S2l1/WU8uTBbHfRd7U8V4xGaFWYrcUxoDWT4BgAbapNkCjJDCL7AbvC/xMp0VJhiS5WjwJ1NtX5TjGnWMkRE5+FaNOVIeJwJPCVl9sTpLkCFUrjJQfZxeqj+/geJt2dqKnY6WNiTIpFznhz13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nriMbUqWXIN1rWK31HVNXBFJbBT82fWwtz1EkCDLsBQ=;
 b=Uk9qHjv7Q5Be1/RE462kFUaLmUcrGa1dBNQduCNVjszKqJTq5ZalqktSfzti1ZT5nky0WYBwSkUp7l6eA1rTTVmbGJPS26MqyP+AfXTZy+rwaXO9VUEPXKAmEtef3VqGowM8Yq3POtfszAP+hfQB1xurV9CHqEepHQJMs4qH+A7vtfuOtGfFj4WuOABYQej1mBJm0zBAJOXo35tzLdD/LKzHWmYNhYVh5MYuZ13+ZE54WNI6ORbAnNFORiRNhX7mJycak9NZifSicaRE9bOqQd22eSTL7HBqzPrp+whFVwnb/AUFvtjYror7pWHXi6Wb3HQjGUIYM4WNGvGFWw+dMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nriMbUqWXIN1rWK31HVNXBFJbBT82fWwtz1EkCDLsBQ=;
 b=mUdPhhyuoIYOMy5VTzv61Xs4o2+59XIgUv1M5IoUEzqUJBzqnNBplNIIrIWNETY0Yga3+X3K71AmLiaaEYGbIOdQTx4lauGH+kyeVqpJFhNvILfdy272PiR0OmYnYijLiQE97NVbOtvuMZ6vNeCzp7BmF/MXBOsRIssn/o2jK6A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4361.namprd10.prod.outlook.com (2603:10b6:5:211::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 19:49:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Fri, 28 Oct 2022
 19:49:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v3 2/4] nfsd: rework refcounting in filecache
Thread-Topic: [PATCH v3 2/4] nfsd: rework refcounting in filecache
Thread-Index: AQHY6v8c+/AX0w4PQ0iPSe2aFwWbQK4kNtsA
Date:   Fri, 28 Oct 2022 19:49:44 +0000
Message-ID: <96D34180-0E11-4582-8B45-B3FD9CD8F2DB@oracle.com>
References: <20221028185712.79863-1-jlayton@kernel.org>
 <20221028185712.79863-3-jlayton@kernel.org>
In-Reply-To: <20221028185712.79863-3-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM6PR10MB4361:EE_
x-ms-office365-filtering-correlation-id: 3c796ac5-f8af-4102-ca07-08dab91d9000
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p2REE4xCfK/72NtYh018LwcaPxlMDp7z2TIkkryiot6giuG5bMDplohihGhq2F9qxcgtg7qpgRRWVx/5lDCPJccKQ/9RgpnKe/zqrLg1Pz1WR3wky0Oc6Y4mUjDxvVpq83igZbtYPgbA/Q/wsj3svza8mdRlseKA4VQEwkUYj4GY2H6h4MiW6STLndXwc7NLgS3BMbUL2m4P0b4ua3XHp5Lc5QcVNi/0uarJdRF4z+6/atWBdpax2dFzgFc1q4ZEPaSBoHMrn8gD+ev0Oam7KEkLa6euaEph9skBbx3L05Xm8RhkTcUJ99X0pjtJPn6kICaVc1O1/kuSBJcmplnjUhguDxEiIHEb5fVBYBnfMhu+qODmxyqqtdkuhK3NE3Cr09XEeR01NefnUy2/rFkHWRvUDvNjuSs8Cn6rVE1NSTva6IpZdpnSUQpD5/8ITxPQfJ/zzZ4+TCM2HT0IH/Jrc7lO7iL5P3bMvew2Z4skog7bbQx51myz6MKXzept0qfqMoGKNn9BXw0iGWWtV1Mzmy0JNzfGGTj86DYOLvE35Kc36zHerdfKxe8JsCM5GDPCuWySyBBk9VfPttIEvl86HXRgVbya9npqnUfut24fXfLLHQqyMjibxbh2/H663QpVgaU0CqeNBrFcmNQOl0X1eX3ZKjNc+Q59ELPmSeOXPRehxtI41AAl+juo5NMy4tfQ44o3J7s1O4fQl1fKS3ILTX8KqtA5Lwm6bVZNLCL/1lDDuhVHb5pRCbCHJTyZFmNkKvP3k3M8CIUvyqU7Mf/yYhKikvH30xuB5IM3XQrGezQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199015)(66476007)(316002)(6916009)(33656002)(54906003)(2616005)(5660300002)(66946007)(86362001)(2906002)(30864003)(4326008)(6506007)(186003)(8936002)(36756003)(53546011)(76116006)(83380400001)(64756008)(8676002)(26005)(66446008)(66556008)(6512007)(91956017)(41300700001)(478600001)(122000001)(38100700002)(66899015)(6486002)(71200400001)(38070700005)(45980500001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rAFK7k5Bc/BxrO7tCBkXuSacouMzM+GbfFw3fHgE7kzkB3Nib2skMVRjpj0s?=
 =?us-ascii?Q?etYaNZ+Jevgt/Xo1WNE6OXhrhX/HalqZlN1qVzr6ZaegpnAPrd3FSwDu0Fcy?=
 =?us-ascii?Q?gub2AW6lPO4lG+Y6PkQTfQ9S2xVh9JNXi4bWDh6tazAflhKTrl+y87Vx4GNx?=
 =?us-ascii?Q?9nlWKzCEQdYqaYJHME45BXIOfM2nqjbQJTSt4ExKweTmLA9MCepEp7HC6WgC?=
 =?us-ascii?Q?vFTl6drWc8qUF8lXOUihEvr7/6yFv/F/FfK/jyGcCWPg4kX5Gj2ABIu4fW3x?=
 =?us-ascii?Q?h0U7H4w2LMyP0umeQAnepIztH9een71d+HGr/Hzj0SEixDndrBsIzS6zVJn7?=
 =?us-ascii?Q?Jz+Oa8v7xuxCBfcxn/hxxz37QMN7YCXVrIMvlCqyLBC3adCSY++SBJ8oE3Sn?=
 =?us-ascii?Q?fJoWXWwKojc7xc3Co1kcCCaoTF0cwUrndFsz4korMKuOFjQ2HZ0+nx1AYwj4?=
 =?us-ascii?Q?Z0C+3N/kk1gEEoeCsLzS4CkEwICehj5ttDPLP7F8xwLJW2XSyQS/VcEt550f?=
 =?us-ascii?Q?0X7JZGdLAbrA6Sz+l+sXhTpeST0v6krIJgb/8KJhvu+g+Yiyp0wk8HIUtvBe?=
 =?us-ascii?Q?20LxwcLN0M0NAyy+O3VPobTnhxfJ/CoVWYkpcGQU8h0wiGBBiGJHzG66cZ0A?=
 =?us-ascii?Q?KePCLgTIZM4Jf17WaXgFDVFyMv/hoM55yYSqF1snExMiXctwHfO8aRERYxRd?=
 =?us-ascii?Q?ZFUovwy4OHND44TJavq3EInkE1tGIYK8yI//EPdynNtgW6eUoU0zoDBPdW3U?=
 =?us-ascii?Q?rGD6a6QhrRQY3nhvQCKdJC6eV5kHg59EIff+PU9yKKkdyOmXw+HQsbGB/8zr?=
 =?us-ascii?Q?ytVRNI4bYAnAk4M1jQgIGQ9pRzz3Prv/zI4S/SV/WcQcL55LQzaGGbhRWRJ5?=
 =?us-ascii?Q?FFfqD5il+PqdF1VIAu5uSCk9j4AxyiD19Sly/j/huAxyADJAVykpjmZVXCWx?=
 =?us-ascii?Q?NMoTpy9dZREBZ6RMf3Fk3Tt4OA59DDUFruoFVRe2e4SdpzcABkm4VCc/1Xqm?=
 =?us-ascii?Q?FAm5BNBo9DiU361ckk/xe6SJfwzor8Kzaq2OyeLwYYe9luRkqanN4SiFTHSP?=
 =?us-ascii?Q?iX08o3jZh/3Axwf70Hmx6aDEnDzny/f21juCfuPrcMr7i6g+WJgfsqTomqjv?=
 =?us-ascii?Q?tN7oEQppuofFOeUlSiQD0J9KK36zaK5XkNDmEgw11c5YNjpFVGz4ebsmay1+?=
 =?us-ascii?Q?OaHRLf8Es0mn8yrlwXIebhXXSkvUYAGQsVfPsyPwsELcdlZ4kA/qu6pFGCKn?=
 =?us-ascii?Q?7qz4pMrv0+AC4p9OimtkKp2z+LU9KrDuSQrZj5s9qcVLYKl1v6YmS+xIs0SB?=
 =?us-ascii?Q?t93NC8B0xbF5cBlFQa3Dz7+ZJAET/PpE2G5aO97K7uoWjIjMqQURlQ/KP0+z?=
 =?us-ascii?Q?BCp+l7auXCf954lENr+vB1k3nJZ5kcCuytt1A5YSBrgNsbX6UJ4ghsosivEE?=
 =?us-ascii?Q?lqKT6kTdWrFkDsAKGjdaTUTep7nrIiVtI4uj40em5KunRAnYIid2CWCoq7Ua?=
 =?us-ascii?Q?+5LVgxMAhro+SXsv3a8VREGUiAMIPdgZzCA5fV5CdSaqP5L66Cwcf5fLVgkn?=
 =?us-ascii?Q?uZt1QmR4aeDCpGClPdNq7NM3flNGU1qu+DU02vAx4yJ7CsimGenJv3CLmMhJ?=
 =?us-ascii?Q?Kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F5FA25EA6C918E45B4E41BF9A544B3D8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c796ac5-f8af-4102-ca07-08dab91d9000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 19:49:44.6882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QXTkxtY7ypJBExRjObZ50z7g4xAXCfvgojy8oSfNSnoD+dvcmqq20+AKVieu3Y4AiJX0R1bNEqcH+F/glt1QCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_10,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280125
X-Proofpoint-GUID: LjamrnVw6drij5B4uLyMdgOgsn8erhzZ
X-Proofpoint-ORIG-GUID: LjamrnVw6drij5B4uLyMdgOgsn8erhzZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 28, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> The filecache refcounting is a bit non-standard for something searchable
> by RCU, in that we maintain a sentinel reference while it's hashed. This
> in turn requires that we have to do things differently in the "put"
> depending on whether its hashed, which we believe to have led to races.
>=20
> There are other problems in here too. nfsd_file_close_inode_sync can end
> up freeing an nfsd_file while there are still outstanding references to
> it, and there are a number of subtle ToC/ToU races.
>=20
> Rework the code so that the refcount is what drives the lifecycle. When
> the refcount goes to zero, then unhash and rcu free the object.
>=20
> With this change, the LRU carries a reference. Take special care to
> deal with it when removing an entry from the list.

I can see a way of making this patch a lot cleaner. It looks like there's
a fair bit of renaming and moving of functions -- that can go in clean
up patches before doing the heavy lifting.

I'm still not sold on the idea of a synchronous flush in nfsd_file_free().
That feels like a deadlock waiting to happen and quite difficult to
reproduce because I/O there is rarely needed. It could help to put a
might_sleep() in nfsd_file_fsync(), at least, but I would prefer not to
drive I/O in that path at all.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 357 ++++++++++++++++++++++----------------------
> fs/nfsd/trace.h     |   5 +-
> 2 files changed, 178 insertions(+), 184 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index f8ebbf7daa18..d928c5e38eeb 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1,6 +1,12 @@
> // SPDX-License-Identifier: GPL-2.0
> /*
>  * The NFSD open file cache.
> + *
> + * Each nfsd_file is created in response to client activity -- either re=
gular
> + * file I/O for v2/v3, or opening a file for v4. Files opened via v4 are
> + * cleaned up as soon as their refcount goes to 0.  Entries for v2/v3 ar=
e
> + * flagged with NFSD_FILE_GC. On their last put, they are added to the L=
RU for
> + * eventual disposal if they aren't used again within a short time perio=
d.
>  */
>=20
> #include <linux/hash.h>
> @@ -301,55 +307,22 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, u=
nsigned int may)
> 		if (key->gc)
> 			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
> 		nf->nf_inode =3D key->inode;
> -		/* nf_ref is pre-incremented for hash table */
> -		refcount_set(&nf->nf_ref, 2);
> +		refcount_set(&nf->nf_ref, 1);
> 		nf->nf_may =3D key->need;
> 		nf->nf_mark =3D NULL;
> 	}
> 	return nf;
> }
>=20
> -static bool
> -nfsd_file_free(struct nfsd_file *nf)
> -{
> -	s64 age =3D ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime));
> -	bool flush =3D false;
> -
> -	this_cpu_inc(nfsd_file_releases);
> -	this_cpu_add(nfsd_file_total_age, age);
> -
> -	trace_nfsd_file_put_final(nf);
> -	if (nf->nf_mark)
> -		nfsd_file_mark_put(nf->nf_mark);
> -	if (nf->nf_file) {
> -		get_file(nf->nf_file);
> -		filp_close(nf->nf_file, NULL);
> -		fput(nf->nf_file);
> -		flush =3D true;
> -	}
> -
> -	/*
> -	 * If this item is still linked via nf_lru, that's a bug.
> -	 * WARN and leak it to preserve system stability.
> -	 */
> -	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
> -		return flush;
> -
> -	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
> -	return flush;
> -}
> -
> -static bool
> -nfsd_file_check_writeback(struct nfsd_file *nf)
> +static void
> +nfsd_file_fsync(struct nfsd_file *nf)
> {
> 	struct file *file =3D nf->nf_file;
> -	struct address_space *mapping;
>=20
> 	if (!file || !(file->f_mode & FMODE_WRITE))
> -		return false;
> -	mapping =3D file->f_mapping;
> -	return mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
> -		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
> +		return;
> +	if (vfs_fsync(file, 1) !=3D 0)
> +		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> }
>=20
> static int
> @@ -362,30 +335,6 @@ nfsd_file_check_write_error(struct nfsd_file *nf)
> 	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err));
> }
>=20
> -static void
> -nfsd_file_flush(struct nfsd_file *nf)
> -{
> -	struct file *file =3D nf->nf_file;
> -
> -	if (!file || !(file->f_mode & FMODE_WRITE))
> -		return;
> -	if (vfs_fsync(file, 1) !=3D 0)
> -		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> -}
> -
> -static void nfsd_file_lru_add(struct nfsd_file *nf)
> -{
> -	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> -	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
> -		trace_nfsd_file_lru_add(nf);
> -}
> -
> -static void nfsd_file_lru_remove(struct nfsd_file *nf)
> -{
> -	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru))
> -		trace_nfsd_file_lru_del(nf);
> -}
> -
> static void
> nfsd_file_hash_remove(struct nfsd_file *nf)
> {
> @@ -408,53 +357,66 @@ nfsd_file_unhash(struct nfsd_file *nf)
> }
>=20
> static void
> -nfsd_file_unhash_and_dispose(struct nfsd_file *nf, struct list_head *dis=
pose)
> +nfsd_file_free(struct nfsd_file *nf)
> {
> -	trace_nfsd_file_unhash_and_dispose(nf);
> -	if (nfsd_file_unhash(nf)) {
> -		/* caller must call nfsd_file_dispose_list() later */
> -		nfsd_file_lru_remove(nf);
> -		list_add(&nf->nf_lru, dispose);
> +	s64 age =3D ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime));
> +
> +	trace_nfsd_file_free(nf);
> +
> +	this_cpu_inc(nfsd_file_releases);
> +	this_cpu_add(nfsd_file_total_age, age);
> +
> +	nfsd_file_unhash(nf);
> +	nfsd_file_fsync(nf);
> +
> +	if (nf->nf_mark)
> +		nfsd_file_mark_put(nf->nf_mark);
> +	if (nf->nf_file) {
> +		get_file(nf->nf_file);
> +		filp_close(nf->nf_file, NULL);
> +		fput(nf->nf_file);
> 	}
> +
> +	/*
> +	 * If this item is still linked via nf_lru, that's a bug.
> +	 * WARN and leak it to preserve system stability.
> +	 */
> +	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
> +		return;
> +
> +	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
> }
>=20
> -static void
> -nfsd_file_put_noref(struct nfsd_file *nf)
> +static bool
> +nfsd_file_check_writeback(struct nfsd_file *nf)
> {
> -	trace_nfsd_file_put(nf);
> +	struct file *file =3D nf->nf_file;
> +	struct address_space *mapping;
>=20
> -	if (refcount_dec_and_test(&nf->nf_ref)) {
> -		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
> -		nfsd_file_lru_remove(nf);
> -		nfsd_file_free(nf);
> -	}
> +	if (!file || !(file->f_mode & FMODE_WRITE))
> +		return false;
> +	mapping =3D file->f_mapping;
> +	return mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
> +		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
> }
>=20
> -static void
> -nfsd_file_unhash_and_put(struct nfsd_file *nf)
> +static bool nfsd_file_lru_add(struct nfsd_file *nf)
> {
> -	if (nfsd_file_unhash(nf))
> -		nfsd_file_put_noref(nf);
> +	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> +	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
> +		trace_nfsd_file_lru_add(nf);
> +		return true;
> +	}
> +	return false;
> }
>=20
> -void
> -nfsd_file_put(struct nfsd_file *nf)
> +static bool nfsd_file_lru_remove(struct nfsd_file *nf)
> {
> -	might_sleep();
> -
> -	if (test_bit(NFSD_FILE_GC, &nf->nf_flags))
> -		nfsd_file_lru_add(nf);
> -	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
> -		nfsd_file_unhash_and_put(nf);
> -
> -	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> -		nfsd_file_flush(nf);
> -		nfsd_file_put_noref(nf);
> -	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
> -		nfsd_file_put_noref(nf);
> -		nfsd_file_schedule_laundrette();
> -	} else
> -		nfsd_file_put_noref(nf);
> +	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
> +		trace_nfsd_file_lru_del(nf);
> +		return true;
> +	}
> +	return false;
> }
>=20
> struct nfsd_file *
> @@ -465,36 +427,77 @@ nfsd_file_get(struct nfsd_file *nf)
> 	return NULL;
> }
>=20
> -static void
> -nfsd_file_dispose_list(struct list_head *dispose)
> +/**
> + * nfsd_file_unhash_and_queue - unhash a file and queue it to the dispos=
e list
> + * @nf: nfsd_file to be unhashed and queued
> + * @dispose: list to which it should be queued
> + *
> + * Attempt to unhash a nfsd_file and queue it to the given list. Each fi=
le
> + * will have a reference held on behalf of the list. That reference may =
come
> + * from the LRU, or we may need to take one. If we can't get a reference=
,
> + * ignore it altogether.
> + */
> +static bool
> +nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct list_head *dispo=
se)
> {
> -	struct nfsd_file *nf;
> +	trace_nfsd_file_unhash_and_queue(nf);
> +	if (nfsd_file_unhash(nf)) {
> +		/*
> +		 * If we remove it from the LRU, then just use that
> +		 * reference for the dispose list. Otherwise, we need
> +		 * to take a reference. If that fails, just ignore
> +		 * the file altogether.
> +		 */
> +		if (!nfsd_file_lru_remove(nf) && !nfsd_file_get(nf))
> +			return false;
> +		list_add(&nf->nf_lru, dispose);
> +		return true;
> +	}
> +	return false;
> +}
>=20
> -	while(!list_empty(dispose)) {
> -		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> -		list_del_init(&nf->nf_lru);
> -		nfsd_file_flush(nf);
> -		nfsd_file_put_noref(nf);
> +/**
> + * nfsd_file_put - put the reference to a nfsd_file
> + * @nf: nfsd_file of which to put the reference
> + *
> + * Put a reference to a nfsd_file. In the v4 case, we just put the
> + * reference immediately. In the v2/3 case, if the reference would be
> + * the last one, the put it on the LRU instead to be cleaned up later.
> + */
> +void
> +nfsd_file_put(struct nfsd_file *nf)
> +{
> +	trace_nfsd_file_put(nf);
> +
> +	/*
> +	 * The HASHED check is racy. We may end up with the occasional
> +	 * unhashed entry on the LRU, but they should get cleaned up
> +	 * like any other.
> +	 */
> +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
> +	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> +		/*
> +		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
> +		 * it to the LRU. If the add to the LRU fails, just put it as
> +		 * usual.
> +		 */
> +		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
> +			return;
> 	}
> +	if (refcount_dec_and_test(&nf->nf_ref))
> +		nfsd_file_free(nf);
> }
>=20
> static void
> -nfsd_file_dispose_list_sync(struct list_head *dispose)
> +nfsd_file_dispose_list(struct list_head *dispose)
> {
> -	bool flush =3D false;
> 	struct nfsd_file *nf;
>=20
> 	while(!list_empty(dispose)) {
> 		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> 		list_del_init(&nf->nf_lru);
> -		nfsd_file_flush(nf);
> -		if (!refcount_dec_and_test(&nf->nf_ref))
> -			continue;
> -		if (nfsd_file_free(nf))
> -			flush =3D true;
> +		nfsd_file_free(nf);
> 	}
> -	if (flush)
> -		flush_delayed_fput();
> }
>=20
> static void
> @@ -564,21 +567,8 @@ nfsd_file_lru_cb(struct list_head *item, struct list=
_lru_one *lru,
> 	struct list_head *head =3D arg;
> 	struct nfsd_file *nf =3D list_entry(item, struct nfsd_file, nf_lru);
>=20
> -	/*
> -	 * Do a lockless refcount check. The hashtable holds one reference, so
> -	 * we look to see if anything else has a reference, or if any have
> -	 * been put since the shrinker last ran. Those don't get unhashed and
> -	 * released.
> -	 *
> -	 * Note that in the put path, we set the flag and then decrement the
> -	 * counter. Here we check the counter and then test and clear the flag.
> -	 * That order is deliberate to ensure that we can do this locklessly.
> -	 */
> -	if (refcount_read(&nf->nf_ref) > 1) {
> -		list_lru_isolate(lru, &nf->nf_lru);
> -		trace_nfsd_file_gc_in_use(nf);
> -		return LRU_REMOVED;
> -	}
> +	/* We should only be dealing with v2/3 entries here */
> +	WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
>=20
> 	/*
> 	 * Don't throw out files that are still undergoing I/O or
> @@ -589,40 +579,30 @@ nfsd_file_lru_cb(struct list_head *item, struct lis=
t_lru_one *lru,
> 		return LRU_SKIP;
> 	}
>=20
> +	/* If it was recently added to the list, skip it */
> 	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
> 		trace_nfsd_file_gc_referenced(nf);
> 		return LRU_ROTATE;
> 	}
>=20
> -	if (!test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> -		trace_nfsd_file_gc_hashed(nf);
> -		return LRU_SKIP;
> +	/*
> +	 * Put the reference held on behalf of the LRU. If it wasn't the last
> +	 * one, then just remove it from the LRU and ignore it.
> +	 */
> +	if (!refcount_dec_and_test(&nf->nf_ref)) {
> +		trace_nfsd_file_gc_in_use(nf);
> +		list_lru_isolate(lru, &nf->nf_lru);
> +		return LRU_REMOVED;
> 	}
>=20
> +	/* Refcount went to zero. Unhash it and queue it to the dispose list */
> +	nfsd_file_unhash(nf);
> 	list_lru_isolate_move(lru, &nf->nf_lru, head);
> 	this_cpu_inc(nfsd_file_evictions);
> 	trace_nfsd_file_gc_disposed(nf);
> 	return LRU_REMOVED;
> }
>=20
> -/*
> - * Unhash items on @dispose immediately, then queue them on the
> - * disposal workqueue to finish releasing them in the background.
> - *
> - * cel: Note that between the time list_lru_shrink_walk runs and
> - * now, these items are in the hash table but marked unhashed.
> - * Why release these outside of lru_cb ? There's no lock ordering
> - * problem since lru_cb currently takes no lock.
> - */
> -static void nfsd_file_gc_dispose_list(struct list_head *dispose)
> -{
> -	struct nfsd_file *nf;
> -
> -	list_for_each_entry(nf, dispose, nf_lru)
> -		nfsd_file_hash_remove(nf);
> -	nfsd_file_dispose_list_delayed(dispose);
> -}
> -
> static void
> nfsd_file_gc(void)
> {
> @@ -632,7 +612,7 @@ nfsd_file_gc(void)
> 	ret =3D list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> 			    &dispose, list_lru_count(&nfsd_file_lru));
> 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> -	nfsd_file_gc_dispose_list(&dispose);
> +	nfsd_file_dispose_list_delayed(&dispose);
> }
>=20
> static void
> @@ -657,7 +637,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_=
control *sc)
> 	ret =3D list_lru_shrink_walk(&nfsd_file_lru, sc,
> 				   nfsd_file_lru_cb, &dispose);
> 	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
> -	nfsd_file_gc_dispose_list(&dispose);
> +	nfsd_file_dispose_list_delayed(&dispose);
> 	return ret;
> }
>=20
> @@ -668,8 +648,11 @@ static struct shrinker	nfsd_file_shrinker =3D {
> };
>=20
> /*
> - * Find all cache items across all net namespaces that match @inode and
> - * move them to @dispose. The lookup is atomic wrt nfsd_file_acquire().
> + * Find all cache items across all net namespaces that match @inode, unh=
ash
> + * them, take references and then put them on @dispose if that was succe=
ssful.
> + *
> + * The nfsd_file objects on the list will be unhashed, and each will hav=
e a
> + * reference taken.
>  */
> static unsigned int
> __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
> @@ -687,52 +670,59 @@ __nfsd_file_close_inode(struct inode *inode, struct=
 list_head *dispose)
> 				       nfsd_file_rhash_params);
> 		if (!nf)
> 			break;
> -		nfsd_file_unhash_and_dispose(nf, dispose);
> -		count++;
> +
> +		if (nfsd_file_unhash_and_queue(nf, dispose))
> +			count++;
> 	} while (1);
> 	rcu_read_unlock();
> 	return count;
> }
>=20
> /**
> - * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
> + * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
>  * @inode: inode of the file to attempt to remove
>  *
> - * Unhash and put, then flush and fput all cache items associated with @=
inode.
> + * Unhash and put all cache item associated with @inode.
>  */
> -void
> -nfsd_file_close_inode_sync(struct inode *inode)
> +static unsigned int
> +nfsd_file_close_inode(struct inode *inode)
> {
> -	LIST_HEAD(dispose);
> +	struct nfsd_file *nf;
> 	unsigned int count;
> +	LIST_HEAD(dispose);
>=20
> 	count =3D __nfsd_file_close_inode(inode, &dispose);
> -	trace_nfsd_file_close_inode_sync(inode, count);
> -	nfsd_file_dispose_list_sync(&dispose);
> +	trace_nfsd_file_close_inode(inode, count);
> +	if (count) {
> +		while(!list_empty(&dispose)) {
> +			nf =3D list_first_entry(&dispose, struct nfsd_file, nf_lru);
> +			list_del_init(&nf->nf_lru);
> +			trace_nfsd_file_closing(nf);
> +			if (refcount_dec_and_test(&nf->nf_ref))
> +				nfsd_file_free(nf);
> +		}
> +	}
> +	return count;
> }
>=20
> /**
> - * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
> + * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
>  * @inode: inode of the file to attempt to remove
>  *
> - * Unhash and put all cache item associated with @inode.
> + * Unhash and put, then flush and fput all cache items associated with @=
inode.
>  */
> -static void
> -nfsd_file_close_inode(struct inode *inode)
> +void
> +nfsd_file_close_inode_sync(struct inode *inode)
> {
> -	LIST_HEAD(dispose);
> -	unsigned int count;
> -
> -	count =3D __nfsd_file_close_inode(inode, &dispose);
> -	trace_nfsd_file_close_inode(inode, count);
> -	nfsd_file_dispose_list_delayed(&dispose);
> +	if (nfsd_file_close_inode(inode))
> +		flush_delayed_fput();
> }
>=20
> /**
>  * nfsd_file_delayed_close - close unused nfsd_files
>  * @work: dummy
>  *
> - * Walk the LRU list and close any entries that have not been used since
> + * Walk the LRU list and destroy any entries that have not been used sin=
ce
>  * the last scan.
>  */
> static void
> @@ -890,7 +880,7 @@ __nfsd_file_cache_purge(struct net *net)
> 		while (!IS_ERR_OR_NULL(nf)) {
> 			if (net && nf->nf_net !=3D net)
> 				continue;
> -			nfsd_file_unhash_and_dispose(nf, &dispose);
> +			nfsd_file_unhash_and_queue(nf, &dispose);
> 			nf =3D rhashtable_walk_next(&iter);
> 		}
>=20
> @@ -1054,8 +1044,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
> 	rcu_read_lock();
> 	nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
> 			       nfsd_file_rhash_params);
> -	if (nf)
> -		nf =3D nfsd_file_get(nf);
> +	if (nf) {
> +		if (!nfsd_file_lru_remove(nf))
> +			nf =3D nfsd_file_get(nf);
> +	}
> 	rcu_read_unlock();
> 	if (nf)
> 		goto wait_for_construction;
> @@ -1090,11 +1082,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
> 			goto out;
> 		}
> 		open_retry =3D false;
> -		nfsd_file_put_noref(nf);
> +		if (refcount_dec_and_test(&nf->nf_ref))
> +			nfsd_file_free(nf);
> 		goto retry;
> 	}
>=20
> -	nfsd_file_lru_remove(nf);
> 	this_cpu_inc(nfsd_file_cache_hits);
>=20
> 	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_f=
lags));
> @@ -1104,7 +1096,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> 			this_cpu_inc(nfsd_file_acquisitions);
> 		*pnf =3D nf;
> 	} else {
> -		nfsd_file_put(nf);
> +		if (refcount_dec_and_test(&nf->nf_ref))
> +			nfsd_file_free(nf);
> 		nf =3D NULL;
> 	}
>=20
> @@ -1131,7 +1124,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> 	 * then unhash.
> 	 */
> 	if (status !=3D nfs_ok || key.inode->i_nlink =3D=3D 0)
> -		nfsd_file_unhash_and_put(nf);
> +		nfsd_file_unhash(nf);
> 	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
> 	smp_mb__after_atomic();
> 	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index b09ab4f92d43..a44ded06af87 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -903,10 +903,11 @@ DEFINE_EVENT(nfsd_file_class, name, \
> 	TP_PROTO(struct nfsd_file *nf), \
> 	TP_ARGS(nf))
>=20
> -DEFINE_NFSD_FILE_EVENT(nfsd_file_put_final);
> +DEFINE_NFSD_FILE_EVENT(nfsd_file_free);
> DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash);
> DEFINE_NFSD_FILE_EVENT(nfsd_file_put);
> -DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_dispose);
> +DEFINE_NFSD_FILE_EVENT(nfsd_file_closing);
> +DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_queue);
>=20
> TRACE_EVENT(nfsd_file_alloc,
> 	TP_PROTO(
> --=20
> 2.37.3
>=20

--
Chuck Lever



