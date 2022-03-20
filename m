Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967504E1CFC
	for <lists+linux-nfs@lfdr.de>; Sun, 20 Mar 2022 18:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245615AbiCTRBq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 20 Mar 2022 13:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245618AbiCTRBn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 20 Mar 2022 13:01:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255FC4A927;
        Sun, 20 Mar 2022 10:00:18 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22K7FdWK017476;
        Sun, 20 Mar 2022 17:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1BB19l28LQL7jOv8ZQe2fUbzTcVvuk9YyIkIHn2QClA=;
 b=KtAFZZghr1t7aAqqLZrNo+WJtuyd6mWFtLSNuaZKyVaUZVrWfYTio/4azt/OUI0KXZGq
 9OBqhMk783BggfSNtA/0N6QUG0Sy7BxzWnNnVAGULnTikcQFeVc3xKuQDCaEdjJvn8BL
 mQ04rXJhfIbEdJfz4e+enY3L5a5+ytT9BhHu0Ef5YV9fYoPQjDBYd/v4JueA92xDpIPX
 CWnoUaO8zS2tzCNACUL1vQZVk2Q1sXGbe7+pJhMOEAmS3EfyUlMDn5FX7i2NUF8YKuaH
 /8+zV7P0CxN43eszjwDYkaypqm+AgdNQ3NUsTj1eJOn1nykD6ln0vuCkf0AfSXrb9kMc xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5kchm99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 20 Mar 2022 17:00:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22KGp19L040376;
        Sun, 20 Mar 2022 17:00:07 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by aserp3020.oracle.com with ESMTP id 3ew7003uxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 20 Mar 2022 17:00:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ef3Db5KlpOp/T0d4EeB0+SwTInH6kuEb9U+eTwD3qvPztFsLZMGLC0gBvfGzG4lD0ilyA2i6NQVfF1ufIFOCvsBjlPXKg8z6Ei/nVcmNfkCLuVp+0N9AqFMrCV0mIGPsaUHnbeaPtKpMLkvzwCsV1f7VJ1dNe7fdnQVpnF8EsFyBjaZdg7AEsjgkHbUEx12Y489mjduBwQWZam0qLC76/WsQlJYeSEGKEflyo7rtte+Qylk9i1Dyig4JxXPtdzJGYfcLHl+NXvpOxBC7GOU088N5LkMYlem0CK1RC2/ip8RbvPya6hzYBcXxcdqzSTLyWNvyPGxoml7w+fySsoxH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BB19l28LQL7jOv8ZQe2fUbzTcVvuk9YyIkIHn2QClA=;
 b=L5feWtSFA7geXv3geVf1cS00kf1Jso2rR/j5sPubwZ2enfHMY8DQNXSP3U/Cuf3doxuoRdwnvWVPQ+VQc16modXo0Cskph8Jl/8haoWQcQQiSAdp8rT3SzWmj7C+AyAG5IieGY2HjVUG5JKkvYWwDqmKYjhU5LUOUKLQekw7zRnPgRuKTKEHfLUSGrUAy9TXVqCvjqIJnOLm0U0Xa4vHbTk9hsLuB3exoDHg5v/VnFClCHwiKz5hksYi63/T3C3+iaXWSqqL091L67OTsOiMgpIha63x4m/pHRKu7WxoW7NUbGX2oLMTZZN8wxWGNu7dkGZY5ZDjsWT/VTBpXSVvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BB19l28LQL7jOv8ZQe2fUbzTcVvuk9YyIkIHn2QClA=;
 b=KdrELZnEP4OUIsP/zrInXVXFj7jV8RCorwtT/VoyJBlOYL9eh1XM5XcOp1dc9tJWfISFAu+cP9SQNc1M5dulmc7XuHWKVhmblse14zGUqGdqR7iCUpCdjQ3cxF3kfJy4H6S0DdELgs/OHn9oK1n3U9fHFf0xBp26AWzVKzReRBE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MWHPR10MB1374.namprd10.prod.outlook.com (2603:10b6:300:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Sun, 20 Mar
 2022 17:00:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 17:00:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] nfsd: fix using the correct variable for sizeof()
Thread-Topic: [PATCH] nfsd: fix using the correct variable for sizeof()
Thread-Index: AQHYO8++vl2zzVrArUKFNFsvwKrRc6zIgEMA
Date:   Sun, 20 Mar 2022 17:00:05 +0000
Message-ID: <AA231722-C9C8-4198-B8FD-7A7C09095831@oracle.com>
References: <20220319202704.2532521-1-jakobkoschel@gmail.com>
In-Reply-To: <20220319202704.2532521-1-jakobkoschel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00e2e12e-28a3-4ef5-3285-08da0a9314ca
x-ms-traffictypediagnostic: MWHPR10MB1374:EE_
x-microsoft-antispam-prvs: <MWHPR10MB13743E42F51D53E19A0B800593159@MWHPR10MB1374.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nzrOB+pjGBK3kmDRJZkCO2jTs1kC+GSWk4CqfkqKxDeqqV8M0DW6RJyu8v0UJuNqihS1I/5AKmBb0hi0Op3tzWFp4ERbW6OORVCdZbJpZgXtjJdNAiMMg5LXwCN49JavT1/jNUMSfUyOkrOe3Eifz8jBkx+7Y94PX7x/0R4vDBffGp2Ed/FpD5Mm9fYUq5jOJpYA4aNqUbViUfGZNYBa0Mf49N7h5OWmRg9RlUQ3M+1caEEhWV7QxK2zo9nNFrxvAtX2esv31BGiaMWrfQ+erKXZWiDbq6Hylop1o4ecu/QnUAMi6p5QKN+lwrBdBDrMbutm9Pw9uC0lBy+P+IHUKULSbTEXR5N6eITg8G/mWV92hjVW7fIX16R5pr4ebm+otoGUQOL/0sXr8X5HDU+NvSyD/jot5Zui5/gdYAnQghI4v/64EYqJonzDgGvZk2d1vW0jjjHYdFYB+ul4l1df/6+rybfOyCX0b13iXWuOr3Rt9vH2Uy29ZWAHOwFt4ejMC1rF24d1b1ripTct2nWVrRm/XZui7KOEsldr5m+hezJOh/MYtvG+DgGWaSO6XzSyrUagVorg7qm+pLniucQ/RcARFSacb+10Q3D1yaZA2Q+L8LyqtqbMHckhv1d2MrXb+qdXJPHpCzSsZ33lUXG8hGcqwa0zEaKPTucuQ+Iu82PGtv/PSisNUL0U2hl39L8n8bikcqBFFsPD/wntz8CylP8RuXy8ysSlNLYKl0ZWmuYsvAkafmn/EhQTxnFylkDuJNV1RyemcvGVjJU+m5E7tZHrt1a365AkdCr7Qf5szzd81QuLzsPtgngzqXEEZoJ2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(966005)(6486002)(38070700005)(2616005)(316002)(66556008)(6512007)(186003)(66946007)(26005)(76116006)(38100700002)(2906002)(508600001)(91956017)(4326008)(33656002)(6916009)(64756008)(66476007)(66446008)(8676002)(54906003)(6506007)(5660300002)(53546011)(83380400001)(36756003)(86362001)(8936002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mtJtR9WEHBEyhue5WVF6HR3EEXHl3WH0WIvdNFs86Is6RFVGa/h7bqnHoGm9?=
 =?us-ascii?Q?yMWadFw/HaOFbhnZkU2luLYE6XoSYA4sYpVmAB2HFXnsyzDevoEv6JHP7OZa?=
 =?us-ascii?Q?MW6SaByo9G/V4reYdMlrBrGtdYmgcVcgx0xeFbS7OcZ7GFwuSkWy97aRcmRX?=
 =?us-ascii?Q?AS19MmYNutUDIRqxrsP69HFmtZgS2iueCfYCKRlLJ/lnI3/76W19M3xsLw+N?=
 =?us-ascii?Q?cuQSEzt3M8NY6ol/aX8crl2+tg4cVTn7ooC8C+8JXu0t+z4mLmYEe50aufy1?=
 =?us-ascii?Q?sFHVCqP6JXb8FwldCNd7PUO1aA5FU2FQbNy0zRP4l+MXKlOJOInb728GbxwW?=
 =?us-ascii?Q?Axa8QpqVY/nKSNthAi9E1L6c6P/c6EmA5uMQLgRfpjNNhB/36QyBtVYmk1db?=
 =?us-ascii?Q?+zPWHznlXtgeZSCwXurAaKm+x3t0DY0DFTBWmN1IILTd8wNkuMdj5mnluBEL?=
 =?us-ascii?Q?HvaMZ2AV0z7pAz+4EMzB6/tU8YiMUzbaLX29i8+W3IoNVKV3NZJ2Pkv1/W+b?=
 =?us-ascii?Q?9ke1mdH12dbspVkJy9pv8fA0YVdd8r7m975aJ6aVlRu45lElj/7NgVEjuTbj?=
 =?us-ascii?Q?J++H8hmLKDbFZqOvDxc59vexR6nIawzBaOerFeMpHJeZ4e/Wsf3MExAkCE2F?=
 =?us-ascii?Q?/rD49AwQBjE4iDUBBeLRvdbpn8hzZCPNoUziGxvJntJZXxHpx/v+NIsod1Lo?=
 =?us-ascii?Q?Vrjf2HulRkcyQNWzRXByOfB8SDYicW0kaWNlCp3Cpir6jZQkgNoNpEz2nksc?=
 =?us-ascii?Q?T92A7qUEt8CiWIlg+2ThYJhuxt2k+Wg/M3aD9rk/0Q/18UZi/s1UznJNRrh1?=
 =?us-ascii?Q?6J8xkfeipL5AE0LjimZ1kbqFCWBg15xDoS8Schkym2tKJ6WMNBPs6P5k39Ni?=
 =?us-ascii?Q?d8zMg97Q9vDH0+bSZ6w2SWVVeDcUeHXJdjnavFVu6a7pxKBrB3Ra1ANM4WEV?=
 =?us-ascii?Q?V26mteDk5orOe7jYJNvlb41qeIf16wbgk7iFH0erjK2MtXPh6tVtOA096/T+?=
 =?us-ascii?Q?0+ptn2tD4NKTthQBRH75kufFt/3CLt4PD0bppFWWOhlnF15wURWhumpLAprO?=
 =?us-ascii?Q?5JlxAjplf157dvFPcGBnjncng+cGJwbVOhwXrXPCIHmiX5IcAFjTRgHzjlrr?=
 =?us-ascii?Q?0GwrjFtDpQYsiyUVgEO+4jYkSJ+Ho9UtUKEoxJXIeVJlNeTJ/qI02fwbezUS?=
 =?us-ascii?Q?3Jby5SBdXGslmKjT1mSmnedylOkTQ1zrsKNgFbQ7PAhmDM5AbhIOICB6jWX4?=
 =?us-ascii?Q?axsKA7cDw/s0NqmpNl73P9+hFzG2MQbYQDB7aU0BdI+7wdf+zF1P3Q5HcFpW?=
 =?us-ascii?Q?JWRSIDt2Jk6FLifXYD3t/JLmV8B01kM3Fby1bqxETGioq3fEkaReiH2qqBPw?=
 =?us-ascii?Q?4dA+vFLJmko8KkgtIFcfbETFqXR0M1O10B1uYhV08JwRYK5Od3IBdkvA02pX?=
 =?us-ascii?Q?gmkB8fYeTn5OE0SvRh6UW89YawHNlfAoZmnSD+jC3FvDgCZgX6K1UQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CDE46AFCEFAC2C48800A210A7F9FCBBF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e2e12e-28a3-4ef5-3285-08da0a9314ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2022 17:00:05.1143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 41XopCzBSj26EHpqe/cvilyb73MQO1iXdYruWcH8ehYPr2Aa3JnIe1DNnkScLi28L5xkpvQ9CcBDn5eoBUGGjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1374
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10292 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203200123
X-Proofpoint-GUID: FEke4hXM22QGB5DMeanB3RualZ-kr2F1
X-Proofpoint-ORIG-GUID: FEke4hXM22QGB5DMeanB3RualZ-kr2F1
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Mar 19, 2022, at 4:27 PM, Jakob Koschel <jakobkoschel@gmail.com> wrote=
:
>=20
> While the original code is valid, it is not the obvious choice for the
> sizeof() call and in preparation to limit the scope of the list iterator
> variable the sizeof should be changed to the size of the destination.
>=20
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
> fs/nfsd/nfs4layouts.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index 6d1b5bb051c5..2c05692a9abf 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -422,7 +422,7 @@ nfsd4_insert_layout(struct nfsd4_layoutget *lgp, stru=
ct nfs4_layout_stateid *ls)
> 	new =3D kmem_cache_alloc(nfs4_layout_cache, GFP_KERNEL);
> 	if (!new)
> 		return nfserr_jukebox;
> -	memcpy(&new->lo_seg, seg, sizeof(lp->lo_seg));
> +	memcpy(&new->lo_seg, seg, sizeof(new->lo_seg));
> 	new->lo_state =3D ls;
>=20
> 	spin_lock(&fp->fi_lock);
>=20
> base-commit: 34e047aa16c0123bbae8e2f6df33e5ecc1f56601
> --=20
> 2.25.1
>=20

Thanks, Jakob. Applied to the for-next branch at

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

--
Chuck Lever



