Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52B2613F30
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 21:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiJaUpr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 16:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiJaUpq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 16:45:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68E5DF65
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 13:45:43 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VJZgMc026892;
        Mon, 31 Oct 2022 20:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5sLMKiu4PhJ/mTd+9KGkXFKH3SZr0kCpjcahxwdQdIY=;
 b=riJpp7U1ye2bu5FWdUd1ngb2BST0HXQp6JlOPjQRydqRPZOdgp33ATqqAxQfssFF6hKz
 tCzd6Dnnj+N+vSI4NSg8WaoxvZei1JrVbklhaIGWfOk7+2w/AxyUnYW+EPW7olmRCkUr
 BwOeI9wPOWBw2Qk6YhasuaEQp/i0Ie32Rs1+HG5hqDB1nwEBaeO0WR5scEs0CSJ4Qe1Z
 aUojCgvIrXr6HJVNnk2baHsuGSxeV7nbIYOmzwVR1w3CExmKAVV4zZ74IJvccc6+yo/L
 4jGizxSleTm6aMb0r18BU9bfiS9sDEUmIiEJxppQBSWli0mBTdsudAZ7gB+k6GhaUJH/ Zw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts14ywq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 20:45:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VJoelh032869;
        Mon, 31 Oct 2022 20:45:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm3peky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 20:45:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRIXEM6ZdqlnUtXeexdBoqoWx0BhJR/3x4WldzEdYazZwkvbWh4kg7Ft7n8fEhOI6+IJIk6G0zpipKLL92cPszIRLqoyjL9QjphqG4uCkuRiEs/fu8ZvTZCUwEO3f3HUQnfWm9JEaO8X1YkAdKOeDXwcGw9xk03vCtZsYkRRR5OMFvv3CB1UQFxgAZFVbA/7UGIkunzcRF02DQWc6GvcWc4l8X5PDSJgOVslVo7dcjRYr3z6C99OTisIxESLgh/HST4SaxpLhZLSCPZzYaOrLWnZsCY1Qw+4a6zH/h+dOwDd49oBJ4/X0pgkAq/wOmxU6FBHISh3YOGpRJ1/yR+Irg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sLMKiu4PhJ/mTd+9KGkXFKH3SZr0kCpjcahxwdQdIY=;
 b=myx+rv+3bmqS0LrHvcVtft0YOjFo/Q0hdwrY+hnK9220RD68JMfnOvSZjQ1dYs/mI8kndt2AQ3K45tL8XusjeK7kscGEjpUnzZ5mfVv7JZ8LFqWvtHkL0X5Vr7OUpVR27/k1TEwt6WXT20p0ywcphrZwjLI+xU0eJRtqfEd7bFuw2I83qDZIRDFHLdXnZonzmCuwlGo1KskB50ZRccAyggChQIlVk3oB5Khik88hqGOipOQv/JY81z8lzZub+JKc8kqiNJH7r/iUZIQhx6a7tdTWSbmpb1Qpjex8HzTBU3ivHfba6tE/LkhgwUgc1xF0jqdevT4iGOKsgnwhl/dyFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sLMKiu4PhJ/mTd+9KGkXFKH3SZr0kCpjcahxwdQdIY=;
 b=S9ZnRchrETBO8i89/dFgRuvIy72q9pgZy7vesAgKey+aImFNaZsQvbcFCi1Wras9v9KgJ1r4lEdIpS7bQAIsFtK8YhaI8EIs2SzJdq7Nj/JZBn/nNBL0aVL8RHMsVQ/dX7bMUp06IO7K5Sa0dedNrPvjdGDN6QQ0K+1c/jzdTKA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5282.namprd10.prod.outlook.com (2603:10b6:208:30e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 20:45:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.021; Mon, 31 Oct 2022
 20:45:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] nfsd: rework refcounting in filecache
Thread-Topic: [PATCH v4 3/5] nfsd: rework refcounting in filecache
Thread-Index: AQHY7R01UaiB+MCFm06GTKlJJrSp4a4o+TSA
Date:   Mon, 31 Oct 2022 20:45:32 +0000
Message-ID: <9BF1F1BF-8665-4F01-9CD5-1FFA62DEEB43@oracle.com>
References: <20221031113742.26480-1-jlayton@kernel.org>
 <20221031113742.26480-4-jlayton@kernel.org>
In-Reply-To: <20221031113742.26480-4-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5282:EE_
x-ms-office365-filtering-correlation-id: 34b1545a-cd83-4537-edfc-08dabb80da74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ePZRSPVVhAeEUm4oPeqxVWVvDTM7TTGGMQs17ZLiWzR/SYwNqhRuXxfzxnhtof/V8syGUxSRQJzPzsOuU7jmf+L0HbnIf51DvU7tppqlPR76rbCtA1GYOmRFsky9qdPLrGRj8RSl53iBIcAYb2bIj8aTB6FcO/e75dgStERc+R+bz2xbvJ0e0qisrh8O0srxxilVE+v5zM0h40k4QYOzwr53TDudzTZ4W6N2v0gQDVJt8LmDIG7HbcRHiI1Btyaogjj2rVO5n3TCtIpdMUY+g6ed9HcHy+QaykqLnEEkEld/OntJGzGuu8xSdQGyzgjoc0+s4WKxnCjpJD4N9/OVIT0Lkns4klm1RqUPj5kHugADoaxQsPR+sSUJDJDDiynpAW3bVxaycYGIs6nRgQLtH7y6tBLGDdChuzTFaZXG9eI2wuDMuvi0vWx4/gvNToJ9OyDb73WXe+N2/WMhs1tNjz5peXdkL2hlb0XNk0pyOLpkeCVfs0VgsAt/MnvO9bsmrQyWV52raotaccsRCZWaD7AgvA0ZXw+hj16z8YgQKc2oPm6tzAz3ReeQB5XYJ1j9P8LBwEVuWnzw/eJOPgHS/ki4B36IZGWr5/7jlRqjkNkg+vIL6C3c1WdLNPK/FgmR/NQgKhiKe8RK1Z//gKn5FbMfQRqxShgT1z7fxYixiuxrq/rOJKroo7cnwifkAsFsmKJmbmp+E4tPiJC6dL0rkds7zkjn0HU8Krk0E/WXV4Rl9EB7oPLiu5/3Azny1a/raEj7kGUTb+XqJXRbPG4zW0MeLL4PGgae+xuABbFAws=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199015)(83380400001)(66899015)(33656002)(30864003)(6486002)(2906002)(71200400001)(122000001)(38070700005)(36756003)(38100700002)(53546011)(6512007)(26005)(186003)(76116006)(86362001)(91956017)(316002)(8676002)(66556008)(66446008)(66476007)(66946007)(478600001)(4326008)(41300700001)(6506007)(8936002)(64756008)(5660300002)(54906003)(2616005)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EX153OPaLhUzE4W91iGQSV6BZkQzoMveA9KYg94Pn5EwNAsqilrnYrOlYQum?=
 =?us-ascii?Q?Yq/UiBeRZGfkVfQc6SWVKFiWTr4Zf9OMSp+mbt24bFJggYzvtgh9L00JENZd?=
 =?us-ascii?Q?T2o5qmYq3IBLNg/M4tRl5xUGUdIaDwkifmWtK1PvCHtnr3RCQBIGzd8Ehh31?=
 =?us-ascii?Q?+i9MZcYX94G8VB9R7Z3lgvbd9pI4cqMhwqHASa/S58eVizzr4fss10aIbr3b?=
 =?us-ascii?Q?JnRZv1VrxzevYnj2EgPluAitmdJpkr2REIA3kzrh3XvEmzRhtaGuy4i/9iEh?=
 =?us-ascii?Q?5CunwoHqElAsxMeeet+wix2mX878xB/oxgQkQpcDRDSXEZZmG97s64bjaMZO?=
 =?us-ascii?Q?GCseV9SzcVJFvfUxHKhjamM21PIG4u0Hk9HUFT0JMtbINGOS7RsTyE5j6t+U?=
 =?us-ascii?Q?0Fwh7lkG9YX46/HR5tRS99b5fnOdLT3FktxuQ9ETAwLDF1sFa9j1Ofhivk5R?=
 =?us-ascii?Q?wZr9lsbis4qjiXS7i6jRh6UACxv+uKfVDami4Jf+ZlsqIzUjPcY+Q0gaBeVm?=
 =?us-ascii?Q?R3gfZ/BcOGrDiV0rSyC4XmRJ6f7VRXVX3OCwlCjujMmDaNEc7UpQx0a/9btd?=
 =?us-ascii?Q?1I/wOb1lmS6NtqW7LlS3NDA76iY4gTk+C3oShHv4ZKv1K/8ViXTRpTNAopps?=
 =?us-ascii?Q?+yC5055iR2lIRdyjoHugnmuKZwhgB3t4XlHXc2ZjIb7yRPs6ExWCCWJDeMh3?=
 =?us-ascii?Q?dTtw327G7qIgENEiI1+FIvf86MhReKTZL+op3ts/ajbGP8z1TJa2D3mT8ScF?=
 =?us-ascii?Q?y2FuZ73NvIeWGDhe/bkgrn3PweOQlVhTWNUywRzgW4blrKf9obV+aJ2/w22Y?=
 =?us-ascii?Q?imlAIULUDDALzFEugslWeGuvjfALVvo5xXYJ7Vuh+XKos056d1rOa4CytOof?=
 =?us-ascii?Q?2TFMCTN7zkbeSBdgyXfDSozoNusk5auwtBgyKTloyuZzYWYrUVX1p4lukorH?=
 =?us-ascii?Q?/gz8MQB+LVYosWd56jmB8hsxUpTdYTx1CNf2rHancqoJFO6ZVDEpsClW+gOa?=
 =?us-ascii?Q?4GWwBaCbODXJLnQfcQht4gcWkBMGjS3SV/IhUyBYJhdvIxDUFOY31OuPOJN3?=
 =?us-ascii?Q?E8nhPguJM8rW9sgYTV/1pm+LpR0B6kJK5Zb9sFU4q8BPKFg43vDSBnQbnNsj?=
 =?us-ascii?Q?2iAiIVpHEr2UdOU4zngDTIzzbHwxMsyxnLav3NvpGxVGOEqLJsmfjQxfK+n4?=
 =?us-ascii?Q?JbyKE0cy3Zjtds1qIUYlrAD2G3I4Dm6TNw1j1RU9q9BdmlZAx4IC00ZFs2co?=
 =?us-ascii?Q?pjn8iEskFSD24OWHOrL1xqoWyKl+x+ATk4TpPOoYzY4h/Q7VaxK5OjWyjhJW?=
 =?us-ascii?Q?W/c3/3HXfbdHqhL2Rl4XpwE+tqFqctajTaUR7M/uesW/6Z6oDVbsZrj17k2F?=
 =?us-ascii?Q?xEWPi0Wxas/Fvnq4N88PvNUhBmfyrQxZZmfsSKSda8U/dgjJOPazrvadOdvo?=
 =?us-ascii?Q?NYF90APYVApEt/Zn577Cz8SscnUB3Dt5ApTtX71b+vysevB1NZqWE8Dodz8A?=
 =?us-ascii?Q?KvYy9Ozt70AbK6hFLODPmYxR8/Wn84UxUQfC80+QO7S1R2ZopwUYUELWKopj?=
 =?us-ascii?Q?EfBMq7sv4Mg+H9m/ObrBr+I1ywEjVbaWjH13G+3/ywEAuE4PPApZYQevPLgZ?=
 =?us-ascii?Q?Mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7F22740173E04E4AAB6CD140FB9966E2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b1545a-cd83-4537-edfc-08dabb80da74
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 20:45:32.1494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fWCUU61YI1meUAt6f/M5RAS41hjsNOtejEoNFScwFGtO+Bo7wP6Xl9y0osiTrpaargy6KAARpWumoU4t18FRHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5282
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_21,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310128
X-Proofpoint-GUID: G2mxtm4vMgqZLe24XRRN97mXQJr1-0VB
X-Proofpoint-ORIG-GUID: G2mxtm4vMgqZLe24XRRN97mXQJr1-0VB
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

....removing an entry from the dispose list, or the LRU?

I spent today reviewing and testing this series, and
comparing its behavior to the behavior of the current
code base. A few general comments below:


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 247 +++++++++++++++++++++-----------------------
> fs/nfsd/trace.h     |   1 +
> 2 files changed, 121 insertions(+), 127 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index ce80b6a80ffc..d928c5e38eeb 100644
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

Trond and I discussed intentionally not using the terms "v4-only"
and "v2/3" in the filecache comments and function names. That's
why the flag is called GC and not, say, NFSV3. Can the new comments
stick with gc and nogc?


>  */
>=20
> #include <linux/hash.h>
> @@ -301,8 +307,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, uns=
igned int may)
> 		if (key->gc)
> 			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
> 		nf->nf_inode =3D key->inode;
> -		/* nf_ref is pre-incremented for hash table */
> -		refcount_set(&nf->nf_ref, 2);
> +		refcount_set(&nf->nf_ref, 1);
> 		nf->nf_may =3D key->need;
> 		nf->nf_mark =3D NULL;
> 	}
> @@ -351,23 +356,25 @@ nfsd_file_unhash(struct nfsd_file *nf)
> 	return false;
> }
>=20

There's still no explanation in the code of why writeback is
needed for GC files. I can write a patch to add that, say,
right here as a documenting comment for nfsd_file_free, if
you agree.


> -static bool
> +static void
> nfsd_file_free(struct nfsd_file *nf)
> {
> 	s64 age =3D ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime));
> -	bool flush =3D false;
> +
> +	trace_nfsd_file_free(nf);

Maybe move this tracepoint in 2/5 instead? Or just leave it
where it was. Up to you.


>=20
> 	this_cpu_inc(nfsd_file_releases);
> 	this_cpu_add(nfsd_file_total_age, age);
>=20
> -	trace_nfsd_file_free(nf);
> +	nfsd_file_unhash(nf);
> +	nfsd_file_fsync(nf);
> +
> 	if (nf->nf_mark)
> 		nfsd_file_mark_put(nf->nf_mark);
> 	if (nf->nf_file) {
> 		get_file(nf->nf_file);
> 		filp_close(nf->nf_file, NULL);
> 		fput(nf->nf_file);
> -		flush =3D true;
> 	}
>=20
> 	/*
> @@ -375,10 +382,9 @@ nfsd_file_free(struct nfsd_file *nf)
> 	 * WARN and leak it to preserve system stability.
> 	 */
> 	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
> -		return flush;
> +		return;
>=20
> 	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
> -	return flush;
> }
>=20
> static bool
> @@ -394,17 +400,23 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
> 		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
> }
>=20
> -static void nfsd_file_lru_add(struct nfsd_file *nf)
> +static bool nfsd_file_lru_add(struct nfsd_file *nf)
> {
> 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> -	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
> +	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
> 		trace_nfsd_file_lru_add(nf);
> +		return true;
> +	}
> +	return false;
> }
>=20
> -static void nfsd_file_lru_remove(struct nfsd_file *nf)
> +static bool nfsd_file_lru_remove(struct nfsd_file *nf)
> {
> -	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru))
> +	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
> 		trace_nfsd_file_lru_del(nf);
> +		return true;
> +	}
> +	return false;
> }
>=20
> struct nfsd_file *
> @@ -415,86 +427,77 @@ nfsd_file_get(struct nfsd_file *nf)
> 	return NULL;
> }
>=20
> -static void
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
> nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct list_head *dispos=
e)
> {
> 	trace_nfsd_file_unhash_and_queue(nf);
> 	if (nfsd_file_unhash(nf)) {
> -		/* caller must call nfsd_file_dispose_list() later */
> -		nfsd_file_lru_remove(nf);
> +		/*
> +		 * If we remove it from the LRU, then just use that
> +		 * reference for the dispose list. Otherwise, we need
> +		 * to take a reference. If that fails, just ignore
> +		 * the file altogether.
> +		 */
> +		if (!nfsd_file_lru_remove(nf) && !nfsd_file_get(nf))
> +			return false;
> 		list_add(&nf->nf_lru, dispose);
> +		return true;
> 	}
> +	return false;
> }
>=20
> -static void
> -nfsd_file_put_noref(struct nfsd_file *nf)
> -{
> -	trace_nfsd_file_put(nf);
> -
> -	if (refcount_dec_and_test(&nf->nf_ref)) {
> -		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
> -		nfsd_file_lru_remove(nf);
> -		nfsd_file_free(nf);
> -	}
> -}
> -
> -static void
> -nfsd_file_unhash_and_put(struct nfsd_file *nf)
> -{
> -	if (nfsd_file_unhash(nf))
> -		nfsd_file_put_noref(nf);
> -}
> -
> +/**
> + * nfsd_file_put - put the reference to a nfsd_file
> + * @nf: nfsd_file of which to put the reference
> + *
> + * Put a reference to a nfsd_file. In the v4 case, we just put the
> + * reference immediately. In the v2/3 case, if the reference would be
> + * the last one, the put it on the LRU instead to be cleaned up later.
> + */
> void
> nfsd_file_put(struct nfsd_file *nf)
> {
> -	might_sleep();

The might_sleep() annotation should be added back to nfsd_file_fsync()
or its callers. It might give more useful warnings if you were to
annotate the external API functions (as was done here) rather than
internal helper functions.


> -
> -	if (test_bit(NFSD_FILE_GC, &nf->nf_flags))
> -		nfsd_file_lru_add(nf);
> -	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
> -		nfsd_file_unhash_and_put(nf);
> -
> -	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> -		nfsd_file_fsync(nf);
> -		nfsd_file_put_noref(nf);
> -	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
> -		nfsd_file_put_noref(nf);
> -		nfsd_file_schedule_laundrette();

This might be the only caller of nfsd_file_schedule_laundrette.
How does the laundrette get scheduled now?


> -	} else
> -		nfsd_file_put_noref(nf);
> -}
> -
> -static void
> -nfsd_file_dispose_list(struct list_head *dispose)
> -{
> -	struct nfsd_file *nf;
> +	trace_nfsd_file_put(nf);
>=20
> -	while(!list_empty(dispose)) {
> -		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> -		list_del_init(&nf->nf_lru);
> -		nfsd_file_fsync(nf);
> -		nfsd_file_put_noref(nf);
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
> -		nfsd_file_fsync(nf);
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
> @@ -687,8 +670,9 @@ __nfsd_file_close_inode(struct inode *inode, struct l=
ist_head *dispose)
> 				       nfsd_file_rhash_params);
> 		if (!nf)
> 			break;
> -		nfsd_file_unhash_and_queue(nf, dispose);
> -		count++;
> +
> +		if (nfsd_file_unhash_and_queue(nf, dispose))
> +			count++;
> 	} while (1);
> 	rcu_read_unlock();
> 	return count;
> @@ -700,15 +684,25 @@ __nfsd_file_close_inode(struct inode *inode, struct=
 list_head *dispose)
>  *
>  * Unhash and put all cache item associated with @inode.
>  */
> -static void
> +static unsigned int
> nfsd_file_close_inode(struct inode *inode)
> {
> -	LIST_HEAD(dispose);
> +	struct nfsd_file *nf;
> 	unsigned int count;
> +	LIST_HEAD(dispose);
>=20
> 	count =3D __nfsd_file_close_inode(inode, &dispose);
> 	trace_nfsd_file_close_inode(inode, count);
> -	nfsd_file_dispose_list_delayed(&dispose);
> +	if (count) {

Why is it necessary to check @count? I would think that
the the empty list check would be sufficient.


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
> @@ -720,19 +714,15 @@ nfsd_file_close_inode(struct inode *inode)
> void
> nfsd_file_close_inode_sync(struct inode *inode)
> {
> -	LIST_HEAD(dispose);
> -	unsigned int count;
> -
> -	count =3D __nfsd_file_close_inode(inode, &dispose);
> -	trace_nfsd_file_close_inode_sync(inode, count);
> -	nfsd_file_dispose_list_sync(&dispose);
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
> index 940252482fd4..a44ded06af87 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -906,6 +906,7 @@ DEFINE_EVENT(nfsd_file_class, name, \
> DEFINE_NFSD_FILE_EVENT(nfsd_file_free);
> DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash);
> DEFINE_NFSD_FILE_EVENT(nfsd_file_put);
> +DEFINE_NFSD_FILE_EVENT(nfsd_file_closing);
> DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_queue);
>=20
> TRACE_EVENT(nfsd_file_alloc,
> --=20
> 2.38.1
>=20

--
Chuck Lever



