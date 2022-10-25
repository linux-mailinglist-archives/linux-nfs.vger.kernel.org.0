Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E82860C078
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 03:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiJYBHK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 21:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiJYBGa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 21:06:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8447FE73
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 17:14:04 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OKZ8gX010216;
        Tue, 25 Oct 2022 00:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KBxnCE/qtleY4NmbIyhgM43bVngpdjfu7ERIDO9UjdI=;
 b=bvj3eggijrXDDs6NtqvqNiHCbNDwanCwWyPUOJVNQl41aU0IjjK2jGzpdarLoTmsPwsN
 0D6VFuoO8S3K02L4mZjSuwiZ9Qiz3j3A7L2nct1+5mSkWkFasxjcveHXjRCSUWJ4wV4N
 UDo87PEhYYGtQgpNa7r4Vk+i4LDCDzWJQM6z18sV/nS6rc2mUvZjSPPW5hXDXbwzUa5c
 3W64jIeDagWSDz0XvA2rIqqiTiXsi50poKFR46mq7oGvfo2XwT9Idz91nOg2t8YgX8Mi
 olWu3HswpIQnkEnhqjkY8AUtyASjjQuC7lqGn5+aZhDCTA1B6xHBHNVrq4G4A7Q6utke CQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc7a2xqku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 00:14:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29P05AJB032123;
        Tue, 25 Oct 2022 00:14:01 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6yad0r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 00:14:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiRZ5jIrhc8ejjFmlTXd4DFfMJvIDS7cQTFZJXAjwr+vMXvRADz4ngoLLvm9xOTvtxzjTXP+srEDfdBaB8ss6gPy/IIDWEW3PISBO35tsV2Fe3jROcofKCrNcTPo1fEn7eBaFi8MkYJ3G+hdvxNspohpYWrPieT+f5Pc1k+vVQBCZ1+oWFa8ZSFPfCmUVTtRtXH52zFHz44rQRhk1sNfpnD9bl+EkUnRGJQLCIola2As9ixF23T4clzqp2w99L7gLumVkUdpEllzYnYEv1HaBISmuoHhGzhZow7sxT7M8k79gO4hVQIMvAWjyC/+YuM8uiEwuPKKGU2BKd02IuJ86Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBxnCE/qtleY4NmbIyhgM43bVngpdjfu7ERIDO9UjdI=;
 b=ipDAIq/HBXlfq7uvQpDqjDITaOJ8lHTpezwk2rAN9x165W4NX7M3bQS1N07TJCXlgyw1PFoAcf4+VUF8VpwVVmSRzhm+WWfldqVLIa82b89ZjEKIr+K3074GJUxATFQMTeCn2cuPFmrCYXhqG9mbiVsQBTJl1B2mR/3Eece644lb+2sP6RG5YT6FimuFaUPSzvCEjOmrfcvD3/FcxWLgsvW1lQcqAxyN6MBrYvgZP/tlom194gSMRDHNQ8EnGXRRZ8qf6GKF79zLZmpAgZ9YT1bY28VlIbuFuOgk2VRjMhd6WF/mKvQ7huTIWASMi0ZekeUgouAgoL09MnJ3Rs70XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBxnCE/qtleY4NmbIyhgM43bVngpdjfu7ERIDO9UjdI=;
 b=kxzF7bJXvsSsZBH6y1pJJdrZIe8SPfglivC/8GHQVPxZcxq9K/cIp8uv8a9HZdfeSOxS6bFxAZpCnZ94FXH98pDmAkAbEfAYKNODF6w6vC7RxH18kybkoHhoxtijdPG6boCIUOBv0jBZgEJaoSnUVc9YO07qRzLZNiJDCK9BDTE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5645.namprd10.prod.outlook.com (2603:10b6:a03:3e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.25; Tue, 25 Oct
 2022 00:13:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 00:13:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 12/13] NFSD: Allocate an rhashtable for nfs4_file
 objects
Thread-Topic: [PATCH v5 12/13] NFSD: Allocate an rhashtable for nfs4_file
 objects
Thread-Index: AQHY6AGdu/UYtY1O+kiAsof/0iyDy64ePVcA
Date:   Tue, 25 Oct 2022 00:13:59 +0000
Message-ID: <C1C6B958-A138-42A0-B39E-D8CCEB3D79F7@oracle.com>
References: <166664935937.50761.7812494396457965637.stgit@klimt.1015granger.net>
 <166665108857.50761.11874625810370383309.stgit@klimt.1015granger.net>
 <166665465494.12462.9078997979555811271@noble.neil.brown.name>
In-Reply-To: <166665465494.12462.9078997979555811271@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5645:EE_
x-ms-office365-filtering-correlation-id: fd067c63-2fe4-4521-30b2-08dab61dd060
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8uZg7LMMERHFoh4tY/Coy7Pyi+YH6tYf0YqdLcz3jsN2uohLdu26+5xLiAqoWy4U0YLG5KxnsVfPaxcF1PN8EvC8+OiduhY9qaqmWt4IiiVJ3wwsGBGClZmvCQ3ln4bg7tumkMUQvjO96t1Yy8Dp4LPU7VauWULHUWtQKI7M5HnM7px7zeUcHg96+ra6Tmvr4vsdTrl/imp+o6hCZGOk92t90h7CgOn3kVFHw5RIuykMKYMLltXS7+umT79ulVRXp9brKsq6HaZ584tQDH2CpwBB828eKQ4ijo8s+0GTWIpkbCXcQk351fAsbHD8FcM5xlqAYxxzp9UdYmsdpa2hJRyqPiBn2zkYM++ta3imNXCWiB5ECdmTky3oYelnvELQyTeZUFrak0UTAkWukLnnm1qK6lx/XuN4ebS3htAX2BZ7L03zsqc/xQ9Z9LArdL1mPW5ntJhDC7lT7uYLIU+OHoChoZ77suxrb2PcdUp6q2N6xGnM8u4/+XmJCBymMdCg4H500bPV24ueUWImlJkOXKjv8BdC14qFIMOEe2aDn1jA9gIFzdpIwn86s3BVXDQm+TY8DLIgg+NxoyNFDKrl1GrnrJN0thh3PpNbyJ9sXbhFSys8lSJ3A6Epf9VSKJDBNv++uChc0sW1Ed0mOhP/25tCvIFf1UZmTFla+DQJ1hj71cGt3zGMKPPskvbbJIGH7SiffQO7bw/uPZl9W7lfTmSVF+ztIyyIAj5xxRN+J5y6h+RxKVgSyCrHm9KyDAoy2J2kk7bNHPiC/cUbCuddTBKf1B4KvcSvU6MwmS3RbExZ2ySE5EvJFBovFDSj2b167LUvPcu0EDCN0dSHfzr4ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199015)(38070700005)(33656002)(6916009)(36756003)(2906002)(5660300002)(8936002)(41300700001)(66476007)(66446008)(8676002)(66946007)(66556008)(86362001)(4326008)(64756008)(53546011)(6512007)(316002)(91956017)(26005)(6506007)(83380400001)(186003)(2616005)(71200400001)(38100700002)(6486002)(122000001)(478600001)(76116006)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hVrNADLzKDWbjI7HZcDjz8DZO+p5HbLJ/oVMWy+OgPsuMQWSXEjYrxFfte36?=
 =?us-ascii?Q?3jz699TvYaE1fBiHEIxfVURilxXxeUwDidzryedbZNt89CECXSKkQhWWINFb?=
 =?us-ascii?Q?eTvmVSG85Fb22rFnJSwp+J9f3O+iR8TFXFITmBXd3cKvD+oxvEvQJMRTHCHl?=
 =?us-ascii?Q?lWInVFiYjXn0bfi03UdAP3J9TPYpMZTyl6vR+YNoFr+50DyyhQmgqBmd/OUz?=
 =?us-ascii?Q?R76zsh4dI7wrDfyHOW3s259zq0BK2SDGSgquMRAEZvXsEfVeT93CxhuGE9vN?=
 =?us-ascii?Q?i7I27HbDwDd0l2IW3dQ67Pf60l6vReOLzglJgPud9YpsD6H2t3nW/5AdnkQ+?=
 =?us-ascii?Q?un8R3Zynw03VQpP86QUiTvy1eyzfGE3MJxkG8zXechvg7JSs01ZJvNbO+Ys+?=
 =?us-ascii?Q?y9kNi+H4oMOJ7YRrBuiMFzw3aw9SYBpRSVxLbUBnb5dpj5RYseCVqQT8vgsW?=
 =?us-ascii?Q?g+05RVL1uDeY9k1moSZ5kw4v0CfPCcKIzGfDh+FllopZ1XDTEgQn0YEzlhrF?=
 =?us-ascii?Q?yDe+rOWsqBGqIcfUoq0oicXosYsEWhnhw4UM2TyGGMle4BssylNyrHDOmkCt?=
 =?us-ascii?Q?P3xiw2dhWXpP8mNCfiPhplJrDn7UzkBCvjqMPG/VRThlC00sVo8OJLPdpzO5?=
 =?us-ascii?Q?twrU6ZlA/N6Kkfs2k4tL4Hu/Pw8cL4tRlSZDJf2MWW4Y9ObpXzFm3LPGTuJB?=
 =?us-ascii?Q?0Yzk4w3lDpVh1rUYB0TTPBvp7qNxjHkdYPW8UTmSUsS8oC+oXat7dDdDH0K+?=
 =?us-ascii?Q?LlE1A6PA+khmC/Xz7z3JhBacmKzHvLvp4OdnAKtnbZSzvPIWGLmS52PTMu+8?=
 =?us-ascii?Q?a8wga6IJBr1PXPC+U6kJgRKUER71qNQ99NXOtpKC+5nJHQbnuqGxZD4m0jU/?=
 =?us-ascii?Q?SOiUjQeZM+VFvgl9q/VCvZy8yQrUs18KN2fsI9O5J+uvHSSyitLxLJiuED4B?=
 =?us-ascii?Q?rBvzuG/+603yG8JKaZsVqYvlQ+UJoEmG16a7XOgYHXMMpKZJTkpurHFuvtso?=
 =?us-ascii?Q?G+1xQohjyW3HrGIO87H6nU1mh8d3POtL58sBzVWeJBpFNGC0hme7DlmykMTO?=
 =?us-ascii?Q?93+ccSOIej4W27LrRkKHff44aIgqvmUYhXp32Ff1nC/cML7FDAzzfZDZNlAJ?=
 =?us-ascii?Q?evX5fYLvU0Cd4ftrKlRHI1YpMt7gUXqid656RdL6pfGoowYg8yV7pFHd7rWa?=
 =?us-ascii?Q?ImM+EmejMRHXCyFKSKZonEZz28CBYzPvZML0eTOUhVgWPLSTxMK7jxQcL5Jx?=
 =?us-ascii?Q?OpQkUn4U7o2DaPtd0Y9qunSf+8/JTpCxk/gJfeqxzHJcjuxuP0oRSBW22jL/?=
 =?us-ascii?Q?kOzF/DFG6XDkfxHMa5NqtEYfsaGwIFfelYZtYDecTZu7dtWP31W2eerfEQMJ?=
 =?us-ascii?Q?Kx7ab2MntCLEcBfTNvfwKJtoHteP1bTXmr64gv5vQACdTR1K3YGZf9zxM2t7?=
 =?us-ascii?Q?0SPA1azQ5wM5AG57uJXeiuRPai1Zl2Bg3YrXV8XL5sNqy/GqEmdP4wyecQq2?=
 =?us-ascii?Q?9P2/4ix2tF21+l+s7p/e3AUOK8BOOVDYI82+lw3UKXXemL1ZLUipQkvfBVox?=
 =?us-ascii?Q?c6TRax3Og9jr8ws6Q8NwmPIdNy0BwVWZuobDStg8Ue1zQL1WCJZbiZ/aFsKV?=
 =?us-ascii?Q?hQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <85F84A3F7FD9184DA47A0431B03B5C48@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd067c63-2fe4-4521-30b2-08dab61dd060
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 00:13:59.1993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +m5/pyf8CFwiJLHpa5mqskBj8PJtTOlRuqJB96uPKEsZhbEPiSk+DpD6l7XvEYCVOdXu+xNALdOYrk5lnQ8jUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_08,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250000
X-Proofpoint-GUID: WLXb_s7xNhRsKkOy7Tf5OmeSDpfDdgQN
X-Proofpoint-ORIG-GUID: WLXb_s7xNhRsKkOy7Tf5OmeSDpfDdgQN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 24, 2022, at 7:37 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 25 Oct 2022, Chuck Lever wrote:
>> Introduce the infrastructure for managing nfs4_file objects in an
>> rhashtable. This infrastructure will be used by the next patch.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c |   23 ++++++++++++++++++++++-
>> fs/nfsd/state.h     |    1 +
>> 2 files changed, 23 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index abed795bb4ec..681cb2daa843 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -44,7 +44,9 @@
>> #include <linux/jhash.h>
>> #include <linux/string_helpers.h>
>> #include <linux/fsnotify.h>
>> +#include <linux/rhashtable.h>
>> #include <linux/nfs_ssc.h>
>> +
>> #include "xdr4.h"
>> #include "xdr4cb.h"
>> #include "vfs.h"
>> @@ -721,6 +723,18 @@ static unsigned int file_hashval(const struct svc_f=
h *fh)
>>=20
>> static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
>>=20
>> +static struct rhltable nfs4_file_rhltable ____cacheline_aligned_in_smp;
>> +
>> +static const struct rhashtable_params nfs4_file_rhash_params =3D {
>> +	.key_len		=3D sizeof_field(struct nfs4_file, fi_inode),
>> +	.key_offset		=3D offsetof(struct nfs4_file, fi_inode),
>> +	.head_offset		=3D offsetof(struct nfs4_file, fi_rlist),
>> +
>> +	/* Reduce resizing churn on light workloads */
>> +	.min_size		=3D 256,		/* buckets */
>=20
> Every time I see this line a groan a little bit.  Probably I'm groaning
> at rhashtable - you shouldn't need to have to worry about these sorts of
> details when using an API...  but I agree that avoiding churn is likely
> a good idea.
>=20
> Where did 256 come from?

Here's the current file_hashtbl definition:

 710 /* hash table for nfs4_file */
 711 #define FILE_HASH_BITS                   8
 712 #define FILE_HASH_SIZE                  (1 << FILE_HASH_BITS)
 713=20
 714 static unsigned int file_hashval(const struct svc_fh *fh)
 715 {
 716         struct inode *inode =3D d_inode(fh->fh_dentry);
 717=20
 718         /* XXX: why not (here & in file cache) use inode? */
 719         return (unsigned int)hash_long(inode->i_ino, FILE_HASH_BITS);
 720 }
 721=20
 722 static struct hlist_head file_hashtbl[FILE_HASH_SIZE];

256 buckets is the size of the existing file_hashtbl.


>  Would PAGE_SIZE/sizeof(void*) make more sense
> (though that is 512).

For rhashtable, you need to account for sizeof(struct bucket_table),
if I'm reading nested_bucket_table_alloc() correctly.

256 is 2048 bytes + sizeof(struct bucket_table). 512 buckets would
push us over a page.


> How much churn is too much?  The default is 4 and we grow at >75% and
> shrink at <30%, so at 4 entries the table would resize to 8, and that 2
> entries it  would shrink back.  That does sound like churn.
> If we choose 8, then at 7 we grow to 16 and at 4 we go back to 8.
> If we choose 16, then at 13 we grow to 32 and at 9 we go back to 16.
>=20
> If we choose 64, then at 49 we grow to 128 and at 39 we go back to 64.
>=20
> The margin seems rather narrow.  May 30% is too high - 15% might be a
> lot better.  But changing that might be difficult.

I could go a little smaller. Basically table resizing is OK when we're
talking about a lot of buckets because that overhead is very likely to
be amortized over many insertions and removals.


> So I don't have a good recommendation, but I don't like magic numbers.
> Maybe PAGE_SIZE/sizeof(void*) ??

The only thing I can think of would be

#define NFS4_FILE_HASH_SIZE  (some number or constant calculation)

which to me isn't much better than

	.size	=3D 256,	/* buckets */

I will ponder some more.


> But either way
>  Reviewed-by: NeilBrown <neilb@suse.de>
>=20
> Thanks,
> NeilBrown
>=20
>=20
>> +	.automatic_shrinking	=3D true,
>> +};
>> +
>> /*
>>  * Check if courtesy clients have conflicting access and resolve it if p=
ossible
>>  *
>> @@ -8023,10 +8037,16 @@ nfs4_state_start(void)
>> {
>> 	int ret;
>>=20
>> -	ret =3D nfsd4_create_callback_queue();
>> +	ret =3D rhltable_init(&nfs4_file_rhltable, &nfs4_file_rhash_params);
>> 	if (ret)
>> 		return ret;
>>=20
>> +	ret =3D nfsd4_create_callback_queue();
>> +	if (ret) {
>> +		rhltable_destroy(&nfs4_file_rhltable);
>> +		return ret;
>> +	}
>> +
>> 	set_max_delegations();
>> 	return 0;
>> }
>> @@ -8057,6 +8077,7 @@ nfs4_state_shutdown_net(struct net *net)
>>=20
>> 	nfsd4_client_tracking_exit(net);
>> 	nfs4_state_destroy_net(net);
>> +	rhltable_destroy(&nfs4_file_rhltable);
>> #ifdef CONFIG_NFSD_V4_2_INTER_SSC
>> 	nfsd4_ssc_shutdown_umount(nn);
>> #endif
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index e2daef3cc003..190fc7e418a4 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -546,6 +546,7 @@ struct nfs4_file {
>> 	bool			fi_aliased;
>> 	spinlock_t		fi_lock;
>> 	struct hlist_node       fi_hash;	/* hash on fi_fhandle */
>> +	struct rhlist_head	fi_rlist;
>> 	struct list_head        fi_stateids;
>> 	union {
>> 		struct list_head	fi_delegations;
>>=20
>>=20
>>=20

--
Chuck Lever



