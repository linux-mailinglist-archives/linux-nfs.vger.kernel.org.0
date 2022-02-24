Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B308A4C3842
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 22:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiBXV4s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 16:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiBXV4r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 16:56:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9892757A9
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 13:56:17 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OKTJxI007900;
        Thu, 24 Feb 2022 21:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IVvA4oFHvFYdPYWWvPfwx3fMeRS4Zsn1wqcfE8KdQds=;
 b=euM2IxxqM/xVWJopC/g8FwoIhCDgWoyn4aHCUuXl0boHwekYY8azTtz/zV9aWHc8VKeB
 lB9Vum9D3ylCErg1msV4ngJK4Hsoscl7KCRQLpnIF5xgl3Tbb7NcXYW9MtPIWP3fFEH+
 o7Z2xAUgIN4NYNXmlEvn3S/ttuipoR5lr7Q5VXA3JjsmXY8waInxM0SMKjNin3voTBhe
 XFlaug9GRRfzzJMWN00l/i8Vz40bwWYMMfKtALTaZ2qNniLy2WpMUTVbklUF7/TwTzjR
 rb+N41ZGCsNvpxOr/yiQhb1mMhtTYQwGjnT6TXnyaL4IvYOmtaLnTRlMVECF+9gpikY2 Ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecv6f0jvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 21:56:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OLewjU053106;
        Thu, 24 Feb 2022 21:56:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3020.oracle.com with ESMTP id 3eat0rbk0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 21:56:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHskwc02CHr6t2D1h9NeIRIc3e0NcaEYDbq2ryaFj8OXHBka0XVA1fbyXiYyOz6hBuMiGH+awGeDSyevvENwSHB8Tnkw8XsdNZPxTxtw8ojkJ1mY/hqsh/LH0G6p4o5VgSTd81b3qY/mQZK7wvUR8F0lQeANYT6X/wZ7XvFxe7RpVEI6z4vfpCElOimhrfR36Yvuqsc8sJfnZt9yFD4NBdVwe6kFMhlgpG4QLQZi4hWvTy3ZcOlyg0rPVEi1bOHSRWJHyC6rLQiaGPOTUIsXqDIcqOcguHp8QEMAucmXne08ZbFWSU4Zb0H6Nh2UQXY7JiiybwtpAeEopoMjpHmqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVvA4oFHvFYdPYWWvPfwx3fMeRS4Zsn1wqcfE8KdQds=;
 b=ls3xk9bUWidlN7bTTG3K07vdLB14+peQ54x52p0pwzZ8M8HNqprOPhDzSRghsnrTpPIT9238IyUiRwwsTFcJUH8UBdXMNvF6wHf8HZgsy1bTbLxK3YwOIb8ZeF5q7BSpyVy5yP6jdUK2ZeF4WXrMjKk6zv6/eF7+cuXYErktBZ2Q/jwh6X8/lC0x6+RQHJY4OdoarFRDXZGXyR29fMoTU6EsI1KZr19U5Z7G6t74YPAERqd+KNi9/7t+d9tfF73Ci9umjiDHmaekBU76X6hkPBCKW09u+oojNM8RG1eaM1JE7sFG0+X4/9iud1UZDQTO22XcLKhP+tNPVgGExzA1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVvA4oFHvFYdPYWWvPfwx3fMeRS4Zsn1wqcfE8KdQds=;
 b=ja+gm/Celocd8q/4U1WHJj5/GuIzEHLLL3GcienC7Bsnd8Jgqvz0a1mxfJk5UYUlOFi7+7YKtZTzP1AFor6rtuSGuiGcrcAs9jdinpbUX/2jnBFSZJrqwD32gpAPCfx4rl2kkpK2M7AStgYPCkFtLcrzdx8PQwMBGgr/LW7pgjI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY4PR1001MB2295.namprd10.prod.outlook.com (2603:10b6:910:40::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.19; Thu, 24 Feb
 2022 21:56:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 21:56:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] nfsd: more robust allocation failure handling in
 nfsd_file_cache_init
Thread-Topic: [PATCH v2] nfsd: more robust allocation failure handling in
 nfsd_file_cache_init
Thread-Index: AQHYKZoEe5El1hMKYEiEq+uh3pv5TKyjPaAAgAAB0oA=
Date:   Thu, 24 Feb 2022 21:56:07 +0000
Message-ID: <9186769A-B9F7-4210-A120-38FB26538679@oracle.com>
References: <20220224161705.1041788-1-amir73il@gmail.com>
 <164573937670.25116.10310536737134724947@noble.neil.brown.name>
In-Reply-To: <164573937670.25116.10310536737134724947@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd223dde-8bda-4e68-08db-08d9f7e07652
x-ms-traffictypediagnostic: CY4PR1001MB2295:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB22959CCB4F947BF1CCEC6C3A933D9@CY4PR1001MB2295.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kju1Ic2vtLtd5Jz7dWCt7m45iX+Vu7MBZ3u9lttGMm5EoGrgnvAAZJNHtV43bkYS+MxpUP8aLcNNocRZQhRaSRJYOfIu/mCf/tZwyFn1KtxtRExCFCT5pQXwhH/V5CKveci6DeJ66mhUgfzf17/t9GtOnD4cUJxHpkrlRD+pDpe2UwgU5iy7RdcA2vUb27GEQN+y+zG89kICLRJSaxmbmfz2LHIhFUPlGAk6p2/6CA7TrKD2RypDz0jVFP+ra10Bc7eOrMJs1KlsdVHKp0mgvRrYHZpmYd1/6vieFlpFlbfEEOmRFVxEuQ3N5Ar4bRR3OJgSU29M45gibHjnkrssN5fAfQCdWZqpu4/a1e57XlY9kcIpa67/ReTbsZMZvCeGnD8HmcN5BGGnZfrsPmElX0IwYG7mJh6erh2jC4I1bqm8ST4HQe4ABcGtkYGE76PQQb/c9bdXYSS+87+KLQoPnW6KgByu9ZCcrK45vRUCYMuq6k9TdYpgZl4LNkqZstdweVOz1h8qP3pY0yoJWTCKNlp489ZjhvqcfAhlu3riMvtki/5Pt1J9SJmWj4q9S/noYVVtChk2fMm46cytBhnFp5deOXjlKgX1Sw72HjIPNWVunccL2dvfJDoyb7EvjLhKFFesYjoegds+1YiHp19cKNCHi+pNnbyPSUcZQYc47RTv+21hb5xB6h2chrjV5jUGLPSNwbQDuonRGGKNYwKwTB3TtiETbVpPT+dEjfkNqOTJfmkVvcQit8aAg96CgvjdvhA36psKifGbxVTOcok8mtziesiqjHWVZdx3CqYtlZFDeBEuJkrjHxRc3HOG9VBSz2h9NozbBfJmaA/ubHs+Cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6506007)(53546011)(26005)(186003)(2906002)(6512007)(6916009)(66556008)(76116006)(66476007)(66446008)(64756008)(4326008)(91956017)(8676002)(508600001)(66946007)(5660300002)(2616005)(71200400001)(54906003)(83380400001)(122000001)(33656002)(6486002)(8936002)(38070700005)(966005)(38100700002)(36756003)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mh3HuMxeNL1TWd2VufpjL/EkK34E0+qy81dZlTrm2BHBS978vQm0Pads6dHb?=
 =?us-ascii?Q?orbu3Uz8u/czB2WZA1hXbnz9svoyNBV9yv4osAncwHUzqnlRxO7YDXN+8GNJ?=
 =?us-ascii?Q?nc1m+HfnPDxP4DB5FWH0ycjn6vfT6Ma4rfJt/mqvAT54hp9icDiXByW2hdGa?=
 =?us-ascii?Q?y023NRriJws0aVo22tKvae44QGcutJqgJUi14dJOdmy7eQP+pnkK2YJ4V5xb?=
 =?us-ascii?Q?QmGlSUltiN33QVVQtvae24pD8+FefpnJLQcR8MT7A/deEL3cB+MlkcPIKolL?=
 =?us-ascii?Q?GtbQY3DNRiexXqu9VeE4kZnVLE3OOSLk1e3DNjaXV5TeKXtIm5XNgn4I+geT?=
 =?us-ascii?Q?iMxuFTxG5TQcROUrcv1eczWpWgxPSTKkEH0L01fLNgzAJ/SovVMBLfjUzOS+?=
 =?us-ascii?Q?vfbJXwf6ELk4XXHZIHscSXTrusTHxmAkZr9jJOzW7XEQ1kCNr/xZ+J3qUpKn?=
 =?us-ascii?Q?oIhZikd3ArsRRt4FqAOIH3W+D9yYZxKA9aQwtjIwn72Vgp8ux5OGQzKWiS/z?=
 =?us-ascii?Q?Rxd6ut8mNmcaSjBC+zbZTn/6+3UDLzk8VjKJ/K+8wfjZBdqpoXhxBQDZHtZy?=
 =?us-ascii?Q?X2+NGDXNRWG+hmXPcj8ZcEZtAzwwNzbH8IBvCaRfYacoCoM4EWmcOBB5J9/b?=
 =?us-ascii?Q?YBzmS5BKwisTS9+B29m81IEpYlok0wdruv5bGP/KWq2XEy+57wF2606Mbkbs?=
 =?us-ascii?Q?zFKqWCCNSu2lZeXwwUpkfpM9MxG8s+M4jS9rnYVkRdLcEfNO4JuwF/2dvLJO?=
 =?us-ascii?Q?mTHXiWvRl3MJv4L8/73KE9xzIMeXaBcEEIeXV3Np3AkYkx+wupIYkF5FkXS7?=
 =?us-ascii?Q?crU+vWvxRNM+Ae2xHEYo3g1Top0BD45570V39N5Me4JES+c4WptW7o2CZa8y?=
 =?us-ascii?Q?UekZ59R12ljQHWLoCuqox49lpAWV+1p0ZfyX5RQskX3vJnKKbwG9p0U0UJ3D?=
 =?us-ascii?Q?5aK5bK4SgA5xG8U+OHor8eDP1qt8Tkt7N1Q2mLRNkU/4ReDil6XgMn6TvdJ2?=
 =?us-ascii?Q?U2kyspmIDLl/amN9LmcD4uRa8/cDM8ALmSFKOCc8O5svmI4yG+2LuBsTYp8W?=
 =?us-ascii?Q?dc3SAAt/Qj2iHeIBxjXbiJMEHLMt3eZXKO6SomZJcLzUvmMIYaDslO22htOA?=
 =?us-ascii?Q?KI+XAUQv7PbzICqKZfaw4E9exHdk5hqourGZLJKIO4hxtLsEhcCiVXk4J2SH?=
 =?us-ascii?Q?se38iQlNZuCyk89kXb5B+6+/ZN1mJgesoCXSIe2pBpmlvpc0BmaxGQAb0c5H?=
 =?us-ascii?Q?CuIbKu9daGJH+cVGpbNnCkEkRKU2En7QeRngY582bNbABG0Yy4WN82jfKHG5?=
 =?us-ascii?Q?R9j3hJ7QUt7Icnw1KR2Zr4+te9Odgao6q49518HdRsihIi0HI75QRaSgc5Y6?=
 =?us-ascii?Q?fSNYDCEJzJNDP9I6auVnT82ssVsVC32ctueX6tHPHYlF0CDi+4C6zVv4nUHx?=
 =?us-ascii?Q?nwOHnlsg5DGki4W6/xJN5mqr4D+CZd6OEEWuu9+MTWG7P4BuTaNOtan1SxS9?=
 =?us-ascii?Q?pheZBROZB7YGE+Zht6vGz3Jn3b8Xf4tSJE1NoIjLfPv04xXBV/7I0EpuWstE?=
 =?us-ascii?Q?/24dVAqWXIwxks0xLI6kQQM+1tlGSTg1nOHfBtwcAkFWSv9TrdgYMq6FGZq4?=
 =?us-ascii?Q?Rx/YoUrZvXkTVB5plOaiwkI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BAA6DDC215E8ED4786894A7DC34BDC19@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd223dde-8bda-4e68-08db-08d9f7e07652
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 21:56:07.8364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: egBg3jS4+l5P2v4n42v+Oc4TnERO2TrWIV1Ofq/1xciQA0VTua63/nSE+0UtTo3ZT9DtNJ9+NuoN1bQ8afeMrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2295
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240120
X-Proofpoint-GUID: Si958Syn9zn6aKowmIe964iTmm9aawx-
X-Proofpoint-ORIG-GUID: Si958Syn9zn6aKowmIe964iTmm9aawx-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 24, 2022, at 4:49 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, 25 Feb 2022, Amir Goldstein wrote:
>> The nfsd file cache table can be pretty large and its allocation
>> may require as many as 80 contigious pages.
>>=20
>> Employ the same fix that was employed for similar issue that was
>> reported for the reply cache hash table allocation several years ago
>> by commit 8f97514b423a ("nfsd: more robust allocation failure handling
>> in nfsd_reply_cache_init").
>>=20
>> Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to nf=
sd")
>> Link: https://lore.kernel.org/linux-nfs/e3cdaeec85a6cfec980e87fc294327c0=
381c1778.camel@kernel.org/
>> Suggested-by: Jeff Layton <jlayton@kernel.org>
>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>> ---
>>=20
>> Since v1:
>> - Use kvcalloc()
>> - Use kvfree()
>=20
> I think this is a good improvement, but it would be really nice to
> replace this bespoke hash table with an rhashtable.  They we wouldn't
> need to worry about these trivial details.

I agree -- I didn't want to saddle Jeff or Amir with pulling
on that chain. But I'm willing to review patches that attempt
that kind of replacement (same for the DRC hash table).


--
Chuck Lever



