Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29C160BF6D
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 02:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiJYASv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 20:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiJYASY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 20:18:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBB41B1D6
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 15:39:03 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OKdAjG021673;
        Mon, 24 Oct 2022 22:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1Nf65RWsr4eNa+i/5OrotUN2n+Bnt+KrYZ+T31RMoYM=;
 b=kB63LqNE9lzHZcJGwMkwG/4t0f4X8R8vEOZlFJM/nA2Wg/yvpoXpnPbhlL0/ofUBN7y+
 iv/nGSgeNxxO+9IdB1aO0pdBMVGMcCwPLiihJS+g8jgVkSdu/km51ELx/8wTnE6NnZoI
 VMdXPJbYhl9bscrjZmYXbqBuGPpm6g4Lu2N0fJ/vq0uuDF0cPiK+FjeDMmeeiropppj7
 Uxeb/1N8Qa5H+4JRdfXSLt1kpo0FsmS9klIaX6Q2/Sh9xBI2404rK2GFI2en1hFdi1SD
 ZiNBbEWuQ5cO71V+xrjLkYlyrq/9Gm5LeQgw/3PM/H2BGwabB9GLDIIrB5/VcniV75uu Nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc9396n01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 22:38:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29OLdotR034052;
        Mon, 24 Oct 2022 22:30:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y9u8we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 22:30:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7Aa51B97mbrmi6bAg7BpZW1mOf+cDdUfh5M+tOAwvIA77crQM3xPtK77xIAVaFLpiDhX2mqLlqh8CiKpz7Z/wObSxbksAl/7+Zgqljm+a8dYNd8oo1Dg1ZBp91tSMU02N9JUytsi1Bq+NpAwXH+tT325Z35MRd2olkZKNmwwktLnqeRZdltzHKXFcxL42V4iI01A28q8ilDQiyTVPVZzSvh04orBsSLCWdwwXxBPWY5gs2D8C4R4L5lFM1PNDyxlG03uXXy/rWgjFIuOszodqgqqYrZzRLGNlg1oYKCec+VGXe1ziSshm0jAldIOvrP3nkqVvfiJpgqJ/RHTTghLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Nf65RWsr4eNa+i/5OrotUN2n+Bnt+KrYZ+T31RMoYM=;
 b=RsH86HbU3rejQIp/NNF/ebM/sIUW409e1IDe2FGJCLvPukXyq8AgGI61hmqbA0V44j3plzHaEmq6GMAnZjWPlr/OzooBuu+y2fl7L1ONCFTasiR70UQWJNcqEaTUG3MdOD7zOHlhei3z94+GqfLA+/BUMRH619f0GySfFKlA79XPj9TgVC/nksxVWqnvyuJY2TU4QFuUw4n9TLLd/OJXATxPNA0NuNWkBaB5ZmvAeXINxYNNQGb4nxxLNcBu170m0WQ/Ujj9xXVzpkmss7FVXlJ2cpDTxqLawrX4SUy38LcOnu8vf4LtzoAAi4xHhKIQzfPDrtKNgG6+Yjs3You7IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Nf65RWsr4eNa+i/5OrotUN2n+Bnt+KrYZ+T31RMoYM=;
 b=q7XEg5ayuHgL+khXes1xD9+XEaQCo07EkuClX3IYqbZF6il8rRNWHgy21dY5DK0YxLqhHc4l7bHb+CxqXgSKdlx1bfJSsZ30z1KdTm8dkPIV8O44pTJoV0NeOh1qc8awm/vkPOYOQxNCx0lYKlEAT0zagvw43a91/3eJBiEKvMQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4587.namprd10.prod.outlook.com (2603:10b6:806:114::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Mon, 24 Oct
 2022 22:30:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 22:30:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 5/7] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Topic: [PATCH v4 5/7] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Index: AQHY4ywcCv9nfMlOd0+Wa/Y/m9MOsq4c6pOAgADqiACAAE0UAIAAB+UA
Date:   Mon, 24 Oct 2022 22:30:26 +0000
Message-ID: <E948A44A-D36E-4591-ADD2-D3D8504FA2B3@oracle.com>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>
 <166612313084.1291.5764156173845222109.stgit@manet.1015granger.net>
 <166658201312.12462.15430126129561479021@noble.neil.brown.name>
 <51A1D02F-4BD7-4AA4-AB5A-6962D8708122@oracle.com>
 <166664893048.12462.2026765054120312799@noble.neil.brown.name>
In-Reply-To: <166664893048.12462.2026765054120312799@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4587:EE_
x-ms-office365-filtering-correlation-id: 2886f0dc-afd7-4d10-62df-08dab60f5985
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QvMjOOleU98JZcUROLamjmPOaRlbEeMM62tuGkwmqNMJC1bM53L3qrWZmAG/dtVf6fS5LrbyVcKMqfgiMZXiWYJAJGa7Wro3p2cFnAfYhFOS3Apu4ONGu9DWDXCV2e2lFcuedXam/y5DyQyPYhuDlIv6LS/0NCvNiXkHfUPabhoJBgx6U2fkIMNnzme7no4IH5FZL38tNkUONOxbeeTgglw7YqJ6X4Cmv2lriwywyJwgAhLXwOaF3WUdK2L473FsY42jHwpnIuiF/MZzZ862yADckY7fEvTroN9JS9vVLSxrd1c2HvG90sp/hD03yS1pLIhoWD9+yiJQP4Mxqjk+FAHJg8fY4EO1DvSQNTYne1witoFhFwsqlObp0kfTi/OUkn4VdMyrECxQ1TlLR9dZmk2xS7nXnRlNpZ8vrMuWu9/oUWvQNDJy/xIMQyBMCOyuAvSL7UEF2VB4d86woP789V7tcwAI3YUbVmBII3260IsxByHURU4F3kKTvuD0hJkHu9NJKgHsQiKP3CVOg7Fnx3i+L1a7D+/bimpDz8jNMdnQdfExAnkDGo3C7M2UzWZnssvef9uXncPXr1n6Xkkmi3fCDiYEjdCOs4qAIH+VCThkjlCSiIYPVw7b7U4WHR5URPw6t0mpBHUl/YM3qD33ipNTDoet4Ua/IFj7z2LQN5jZRD/j+NYaupGCFjwLqyEDUSvRIco8JBakY6UV/al0/59CFl5H3CZyI+ZqoaSKbfNijgskyltPqCI2PTBvvtga21mcjpe8+n1Sb30Tq8zC80fkcE9jGqNglrt1HwYQH/w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199015)(26005)(6486002)(66899015)(478600001)(86362001)(83380400001)(76116006)(2906002)(71200400001)(6512007)(6506007)(316002)(91956017)(66556008)(4326008)(8936002)(66446008)(41300700001)(6916009)(36756003)(53546011)(8676002)(2616005)(186003)(33656002)(66946007)(64756008)(66476007)(5660300002)(38100700002)(122000001)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vcv3lzOf/6DoCZgAukiWLlFh+BN1Nqgdzn9WHnZElBGzvn4IytDCmuXffwqr?=
 =?us-ascii?Q?BRio+9LhdBIg2Ofw/r3rtbGpb+N8gTVP2vsoOQUI3HxvL7HJKyChyb0ZP/F/?=
 =?us-ascii?Q?A4AZGXptVauxxfYE+uy7VUU/Dkclz4We2/E2sb3Ib7/6R1LhNQh8a3KBepES?=
 =?us-ascii?Q?0xRPXdeq4Pyoe51zN+I+KsFWv/wbOYzwMosQyAtzJqbfJFqnweHe9GHHeJR7?=
 =?us-ascii?Q?gHhUx74mUYrMacRH5fCSuJZeVbF1+e59ROJnG3PGg4vfmxXsChc5rWtqO1k9?=
 =?us-ascii?Q?tS8VquBoEs6N3qwCS2gYDMzOOUy7hqvCtsYRN2XkyTOkfLlOCAfzg3bllpi0?=
 =?us-ascii?Q?ifwcG6QrO3+0NX8GUVAhC/4Zc3A6E+FRP8brGtX8B4r8kG7IusAoBRdPaEHq?=
 =?us-ascii?Q?CGOCM3cTljYvYrsV0SaBIi0sIlAcxcjqavSIZ5OPtgpHg5XQFnDa/aboFmh4?=
 =?us-ascii?Q?TLOtBKCveJUePAVD3+4Bj1zIMo4MrzlFNoEUqMJIHrOJY9B1rAFD7YiT04d0?=
 =?us-ascii?Q?yYWIRG0eYTN+M5+xbZ2+IyBG6jTZAMPBlkt4WHAh00WRAZ258wEGjt8HCZTG?=
 =?us-ascii?Q?IRekUXGoda6i4yj0l8jFeqECH/rgpNA60sjBS3HGZ9pnMUoUeKCFdFXi6x7k?=
 =?us-ascii?Q?rTK7xscTo22VY1BghOFyFWzfFfcMMvO58MGkNWa3yplB75oydmMnp7KdGqZU?=
 =?us-ascii?Q?poyidTXU8mG5HSixMgGg4tFW4oIQgXNcMuz06W1DM76cwZeEcMkCZOnOIaQg?=
 =?us-ascii?Q?MF2UMnpVpXkibcWP8EZjS+fTUD2aizsJj9s9L9tvTWWMOPrvi98QCRquEMLC?=
 =?us-ascii?Q?xRRbIDC6rgrGSxRVCkhyZRRikVHICGcKDsSsnFHXPNrPtFXf2IRWNgZU6jxB?=
 =?us-ascii?Q?SeabR9d/AkZH2JsCn9Yfi4grzrXK32Qju+EKi29NkcNWK9jMetUqxjCyXMLr?=
 =?us-ascii?Q?Pmu+MQFNz8LpETnIPIt7oLzfSMA8vielOEDv34oPI3xnbMiixsmbaGmQfgsP?=
 =?us-ascii?Q?Ef4aPLYaXip+Y6GDXd6ReqTftKIOMIJmLg/Mg+beVJF2ELMNLqRqkcfL6Q/p?=
 =?us-ascii?Q?8dbahAMmMMDD7dpaENxpPY6+cfMTW/1P0b0+e7zFx0vNTc+4BHpJFNozjChV?=
 =?us-ascii?Q?ytsa1vkvICUzxeihZRwpOLmlQJCm3vEyJ+HSNbHxWeujBzRBCoj10Ftv+bdv?=
 =?us-ascii?Q?XVQBcrETqSPT714m9s+AzIPRhB7MwMfnoDgoJkh3Y5tFHF0NXI2bb2NxYhNv?=
 =?us-ascii?Q?1r/qwJ59BKfapBgEpXOyOZeCi2dfbj/Wxp+KBvrzbdUtIbiHYoFNveGCLFVu?=
 =?us-ascii?Q?W9zGX3Nzr9pt93eAKPhu0/p3kyHaUOF7NeS26Z9ywlZL5N92TEkMqzGI/tlX?=
 =?us-ascii?Q?aqRIgI97mggg2TgD3S4zIGBLXat1UVkSdVoDSBJdwRcZMaVCfvnRXBzCZtyH?=
 =?us-ascii?Q?DvNFXlc4Ud3vc6ovsQ1UPdH62R+4UisIJO08lmGj/4KEdpcrPatVqpi72+PZ?=
 =?us-ascii?Q?UYZwxLEXC55lxGwNBtoFGSQJOMZYv36PhKW/SOAkLDnChn9vtVO/bZquxBno?=
 =?us-ascii?Q?12mRgbdSJvZkFA4nr2Tr+DsbzhSqZCHnnZwR1G55RLOLT65bTNF8Ub7bdqpo?=
 =?us-ascii?Q?Ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D6DD2F925B13684F8FDBFC8960CAC444@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2886f0dc-afd7-4d10-62df-08dab60f5985
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 22:30:26.8868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9La5oYv6a7YIOVDymfYwFDA6enwR44UR0SkAuUWuDRLnmnZDt7un31Wdk2p+zZFVxQXHE9wr34GdUIkb4dbOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4587
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_07,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240134
X-Proofpoint-GUID: FdXYe9HKSzCmedaBoBsDizAXT7YLy588
X-Proofpoint-ORIG-GUID: FdXYe9HKSzCmedaBoBsDizAXT7YLy588
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 24, 2022, at 6:02 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 25 Oct 2022, Chuck Lever III wrote:
>>=20
>>> On Oct 23, 2022, at 11:26 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> On Wed, 19 Oct 2022, Chuck Lever wrote:
>>>> +/*
>>>> + * The returned hash value is based solely on the address of an in-co=
de
>>>> + * inode, a pointer to a slab-allocated object. The entropy in such a
>>>> + * pointer is concentrated in its middle bits.
>>>> + */
>>>> +static u32 nfs4_file_inode_hash(const struct inode *inode, u32 seed)
>>>> +{
>>>> +	u32 k;
>>>> +
>>>> +	k =3D ((unsigned long)inode) >> L1_CACHE_SHIFT;
>>>> +	return jhash2(&k, 1, seed);
>>>=20
>>> I still don't think this makes any sense at all.
>>>=20
>>>       return jhash2(&inode, sizeof(inode)/4, seed);
>>>=20
>>> uses all of the entropy, which is best for rhashtables.
>>=20
>> I don't really disagree, but the L1_CACHE_SHIFT was added at
>> Al's behest. OK, I'll replace it.
>=20
> I think that was in a different context though.
>=20
> If you are using a simple fixed array of bucket-chains for a hash
> table, then shifting down L1_CACHE_SHIFT and masking off the number of
> bits to match the array size is a perfectly sensible hash function.  It
> will occasionally produce longer chains, but no often.
>=20
> But rhashtables does something a bit different.  It mixes a seed into
> the key as part of producing the hash, and assumes that if an
> unfortunate distribution of keys results is a substantially non-uniform
> distribution into buckets, then choosing a new random seed will
> re-distribute the keys into buckets and will probably produce a more
> uniform distribution.
>=20
> The purpose of this seed is (as I understand it) primarily focused on
> network-faced hash tables where an attacker might be able to choose keys
> that all hash to the same value.  The random seed will defeat the
> attacker.
>=20
> When hashing inodes there is no opportunity for a deliberate attack, and
> we would probably be happy to not use a seed and accept the small
> possibility of occasional long chains.  However the rhashtable code
> doesn't offer us that option.  It insists on rehashing if any chain
> exceeds 16.  So we need to provide a much entropy as we can, and mix the
> seed in as effectively as we can, to ensure that rehashing really works.
>=20
>>>> +static int nfs4_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
>>>> +			       const void *ptr)
>>>> +{
>>>> +	const struct svc_fh *fhp =3D arg->key;
>>>> +	const struct nfs4_file *fi =3D ptr;
>>>> +
>>>> +	return fh_match(&fi->fi_fhandle, &fhp->fh_handle) ? 0 : 1;
>>>> +}
>>>=20
>>> This doesn't make sense.  Maybe the subtleties of rhl-tables are a bit
>>> obscure.
>>>=20
>>> An rhltable is like an rhashtable except that insertion can never fail.=
=20
>>> Multiple entries with the same key can co-exist in a linked list.
>>> Lookup does not return an entry but returns a linked list of entries.
>>>=20
>>> For the nfs4_file table this isn't really a good match (though I
>>> previously thought it was).  Insertion must be able to fail if an entry
>>> with the same filehandle exists.
>>=20
>> I think I've arrived at the same conclusion (about nfs4_file insertion
>> needing to fail for duplicate filehandles). That's more or less open-cod=
ed
>> in my current revision of this work rather than relying on the behavior
>> of rhltable_insert().
>>=20
>>=20
>>> One approach that might work would be to take the inode->i_lock after a
>>> lookup fails then repeat the lookup and if it fails again, do the
>>> insert.  This keeps the locking fine-grained but means we don't have to
>>> depend on insert failing.
>>>=20
>>> So the hash and cmp functions would only look at the inode pointer.
>>> If lookup returns something, we would walk the list calling fh_match()
>>> to see if we have the right entry - all under RCU and using
>>> refcount_inc_not_zero() when we find the matching filehandle.
>>=20
>> That's basically what's going on now. But I tried removing obj_cmpfn()
>> and the rhltable_init() failed outright, so it's still there like a
>> vestigial organ.
>=20
> You need an obj_cmpfn if you have an obj_hashfn.  If you don't have
> obj_hashfn and just provide hashfn and key_len, then you don't need the
> cmpfn.
>=20
> If you have a cmpfn, just compare the inode (the same thing that you
> hash) - don't compare the file handle.
>=20
>>=20
>> If you now believe rhltable is not a good fit, I can revert all of the
>> rhltable changes and go back to rhashtable quite easily.
>=20
> I wasn't very clear, as I was still working out what I though.
>=20
> I think an rhashtable cannot work as you need two different keys, the
> inode and the filehandle.
>=20
> I think rhltable can work but it needs help, particularly as it will
> never fail an insertion.
> The help we can provide is to take a lock, perform a lookup, then only
> try to insert if the lookup failed (and we are still holding an
> appropriate lock to stop another thread inserting).  Thus any time we
> try an insert, we don't want it to fail.
>=20
> The lock I suggest is ->i_lock in the inode.

I will give that a try next.


> The rhltable should only consider the inode as a key, and should provide
> a linked list of nfs4_files with the same inode.

The implementation I've arrived at is rhltable keyed on inode only.
The bucket chains are searched with fh_match().

I've gotten rid of all of the special obj_hash/cmp functions as a
result of this simplification. If I've set up the rhashtable
parameters correctly, the rhashtable code should use jhash/jhash2
on the whole inode pointer by default.


> We then code a linear search of this linked list (which is expected to
> have one entry) to find if there is an entry with the required file
> handle.

I'm not sure about that expectation: multiple inode pointers could
hash to the same bucket. Also, there are cases where multiple file
handles refer to the same inode (the aliasing that a0ce48375a36
("nfsd: track filehandle aliasing in nfs4_files") tries to deal
with).

I will post what I have right now. It's not passing all tests due
to very recent changes (and probably because of lack of insert
serialization). We can pick up from there; I know I've likely missed
some review comments still.


> An alternative is to not use a resizable table at all.  We could stick
> with the table we currently have and make small changes.
>=20
> 1/ change the compare function to test the inode pointer first and only
>   call fh_match when the inodes match.  This should make it much
>   faster.

I had the same thought, but this doesn't reduce the number of CPU
cache misses I observed from long bucket chain walks. I'd prefer a
solution that maintains small buckets.


> 2/ Instead of using state_lock for locking, use a bit-spin-lock on the
>   lsb of the bucket pointers in the array to lock each bucket.  This
>   will substantially reduce locking conflicts.
>=20
> I don't see a big performance difference between this approach and the
> rhltable approach.  It really depends which you would feel more
> comfortable working with.  Would you rather work with common code which
> isn't quite a perfect fit, or with private code that you have complete
> control over?

I think rhltable still has some legs, will keep chipping away at that.

--
Chuck Lever



