Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3497E8544
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 22:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjKJV4M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 16:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKJV4K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 16:56:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE54131
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 13:56:05 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAHi242005016;
        Fri, 10 Nov 2023 21:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/Sg+2M4wpRpM1xOSoHu0irRYHQv7WFB6MpEdDAbAW6Q=;
 b=Q9cDu74Dc4z0Po6sXSssDoTTyxDTPn8W8uxssRCf8DRe/IPJwkLtqOnA1v0ttoTKt7aV
 u2zk1vDRp9gcvvUmvC+UJZnUuxDOa/z8Rcj/zX1H89ZQui0b+lu7nqiaZPf7pGDtJxZh
 lARraPjDsyH81k/2Bl/a2Bgf12UUPDyFmn89vsHla7AWRU+CVyzMaqck+Tjg6javbMCh
 VgiQ/k8k4dMqw5dLOFjLEpBpyQNDmWi+ZxGZh/wCiHQxy4vKncuaBnollsD6jqsmtlpy
 F7iosOwztK82mdQTGxbdLSara4i8mt6+q5scu9KKlMtiYNxszwY3h3mnWRuBmTgZwLRU NQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2273a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 21:55:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAKiTfW017639;
        Fri, 10 Nov 2023 21:55:53 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u8c02agkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 21:55:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvlM2cDUONsghc1Quw3iJIajDWFtcE+xK494D6GE7iJCslIUAxP3I8aOVDFNatQZZLKZhp5bNAqVM3qdXMzAorIHQ5BamPfsR5MhA/QgISMTGMJypnrnnqaZYUM08Hshv+K1QOrMhz5+XxazPD97JZo9UcRfUqX+Pzh4bug5Aazh129PliF+OriCylfh/e+NX21F2A+5tKmaGNNwXw8h/4yS9CA8HuU4mbLVotn/FTFtb4iPOn+nmldSu5fg0Xkm4z+ZydCkcgzEBC35xsDpsJxkiwZ3yOhVxKcFitYjKjbieuVicNQYNPomBiUlemv38qEH4DKJizLt8b2QTm8wqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Sg+2M4wpRpM1xOSoHu0irRYHQv7WFB6MpEdDAbAW6Q=;
 b=Exru9pTeK1ag8qUccAgnIWhjER/UysegBkQ0qhx2tF59UChXdwtkOwPuNrIkeVs5Mg3sfqR3TSqi5ja0dc1zX54GVdhlY96QSdOUFgKZRc1iIv9YH3ko+MwWmWxhXqYlcNjIsBRPxYovTwdCdC3AKXJC+yTFDRn47gqW+wG3clfxQqT46zoDriso06hB9lDq+rf2ZeTos+8W7v6CLUzGVdLKfaN1WiuNhlf+TTEk56pb7KCrovGmBLffohB+S9+ySgsjZ94WAY+xXLvyjBdSFogruPV0jFgUcSy6GqlO4gxl/gQXkBpRSMHNXQ894yhNeUuqp0d/FzEaeNKkJqgr4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Sg+2M4wpRpM1xOSoHu0irRYHQv7WFB6MpEdDAbAW6Q=;
 b=uQRh5dw14FexPVcGPphA8lt+S10JgfyDfXC6JbPyU8QJLC9U4Px4YDW2WTiMrZltwA/mb+h2Kv+wzN5PkTLMk7GHe4+r76FN/sAmP3WFCjoh+kajczXE80faqZXDnOdOvImTPymlkBTrQePZgVUKurcl/0d3QxphGyngx+7AMvQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6881.namprd10.prod.outlook.com (2603:10b6:610:14d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 21:55:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.6977.020; Fri, 10 Nov 2023
 21:55:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Mahmoud Adam <mngyadam@amazon.com>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix file memleak on client_opens_relaese
Thread-Topic: [PATCH] nfsd: fix file memleak on client_opens_relaese
Thread-Index: AQHaFAKwg4hpMTIhnkyCopP3NxOenbB0Ep4AgAAGpYA=
Date:   Fri, 10 Nov 2023 21:55:49 +0000
Message-ID: <05C7DD1D-367E-44B9-A5FB-533296577A29@oracle.com>
References: <20231110182104.23039-1-mngyadam@amazon.com>
 <169965191274.27227.708763777533834603@noble.neil.brown.name>
In-Reply-To: <169965191274.27227.708763777533834603@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB6881:EE_
x-ms-office365-filtering-correlation-id: 573318cf-f2ac-450b-3793-08dbe237cd53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RRloCvv4T85O6APAiWSrGGwLQY7eiHqH8gKSlmG6ZvGSLckqG6+JY0taBmfxj2VTt/mWMtzlr42rK34i3EukP/nGepGicUdnbt4XZPqurNhLRn10b1mhMhizH4Uora9QHAiK/OS78HMZr9p8fkKswFmckSN+oo6AA9AKdF9YvdtXFC93SNCbP6OP35Ajb4KHrjLwlOX2h9VvEAfo12FsQu/1z+DITbapiBBOKtIoWCmFhhUbd24CyJ8Qar4M6A38j/2EkRzj9Yf0UXPbV/oM3MTb/TIUG3b6Vaf7XXQ/Y4d1dHDrRH+vU1EblBJgiEVYiDEbTX0dknxc3Uws242uFymIMj4+hupEX+ahEdHvzFjsNoh0uEg8NbP0fr98ouerQGJR2wYOg458yWqUl7BMg+rzQmTKWXaxLJQ/orQZT/SSWe3IFMnKGvvFjsP07sibNozJtXxzNyNn/p1n797Aw/Wka/XrdwaWNqDmC8RJkXU+kkn5IKAxlUA0SX2oresVKFZ006WVZIXHgfQKTcPjoochZGt+Tbc4qJAhaj3aO3O9WPvyY76VCCGSWPkA8V+dINN6gZ5AcCIWKCYvzVcAKF11QLjlr5CrOHYO5KYoTo2beazXJBAfrAMcN4rrd7+vHaZo+Mwf+T8BGcKfUSARh0WBdCyGY2oG52fe7isFNSg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(53546011)(8936002)(8676002)(4326008)(5660300002)(6506007)(2616005)(478600001)(71200400001)(83380400001)(26005)(4744005)(2906002)(316002)(54906003)(66446008)(64756008)(66476007)(76116006)(66556008)(66946007)(6916009)(91956017)(86362001)(122000001)(41300700001)(38100700002)(6486002)(6512007)(33656002)(36756003)(38070700009)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ETXugvIh2EjpUZlH5xyqC4Go7KS3Udgy9URPlY797IEh4l5ro6uxzm6qY16U?=
 =?us-ascii?Q?nM41dFOSu10afscGkdUjt/+OkWiAUYrhOSxWY7jTPtdz/r59LHyClDvSJRgV?=
 =?us-ascii?Q?6xJp9cZ8+AcEWJpckrbP4l4GOqLgb+r0nHhP+HqglIkFMPtiJ44OuI/D8Gll?=
 =?us-ascii?Q?N1fiP/1U5V7ghV9Xt9PgyUVxE0Yp7DKnZATXe8dunInUOav7gmp8QGwyhWqX?=
 =?us-ascii?Q?jX75oFLRAdRkmgry8or/vfw2YrM4j2WvFIHcEjGz1ho12DGenyOxj8SgKw2E?=
 =?us-ascii?Q?rM1huI5EjDVoLYUPlKcHXfHmNG1HDs83VZ5lnxv+9AjnoekljaKMvGXRDMCU?=
 =?us-ascii?Q?E+x+shQeoKJ0dK3nwSSZHIBgLyaNAAYgWG5vm2PC1eNavdY1iG7LEaHiJG06?=
 =?us-ascii?Q?29dtacr7wl58qEfTqKDq5hBdsYATjOodAnd45dIm91FgD5zbRP/14vfRvYl1?=
 =?us-ascii?Q?dKw5q/x5aV0GuH3+bhBa+x+W/Bf684C0sZdQZsePn2MjQxLUidpzBcM0Pfgf?=
 =?us-ascii?Q?UpEyHebRi0HJXHNFcgbYDQhYErw6FArZF7CQqvNla/vLzaYFN+sDO1vWWD7O?=
 =?us-ascii?Q?o1a563ggP6jP6aBz0XkNqwMnBLqL94K0c2OuN8jbt2zwcLoRfLijqHqCozpo?=
 =?us-ascii?Q?OYJFxhM2Z18ZWpqqNt9mNmSHIOTOFAdJollAuGOGDsG34TcA9ZJWTnpqor7n?=
 =?us-ascii?Q?yqw/3qqBxFYehMaiKsnd4L878YcO/MRJFZokCjgNsVOaFVVa5wTW0iK8jxjB?=
 =?us-ascii?Q?2LhIjErP8R1cAPgxiA1QPB5ezjRpL5tz+ESt7khER1eTU/OYg1dseE+kC7YG?=
 =?us-ascii?Q?yyJMScpx/0aLiL00uCLANssdXiLaTKXwSxsIFZLwEhJIQ5j7qG/IfkU4E386?=
 =?us-ascii?Q?RKM0Y5J+LARxDVBq+obHZArzD2bMyk4uzK9+VpCV91O6WeVGEAmoXdsHyanW?=
 =?us-ascii?Q?3AlaI0/pCETioDEWIYv1XaQfbCNzFcoRw6X1JTePZ8JEL7X3SkIzT1wYKGkQ?=
 =?us-ascii?Q?yGgootvHFS4DYIQrfQptvGJGoJVvmZtkBwGi35EoH3MHEVcecdzXCubswEkJ?=
 =?us-ascii?Q?49l8p4SbhONFtshZt1vZlCgYQ42UXfROiCCaarjr4CFAhkXjL+AaCLxZo6rU?=
 =?us-ascii?Q?e/0BiiBMOFiCm1BtPlb6mkGicH/N5tqK+sH4N/Imw+l67L9WFOMaNUZQBTWe?=
 =?us-ascii?Q?+nntVzMJ0QYyJ/YmwYqqM3NvjbbSxkQyf4gtS2+uWBJwCoE2Sjt/2Tnaioex?=
 =?us-ascii?Q?4eH2rZXVUJLdZa3B5OSgpOKMoq5hEbWlNb8IQbRTzPOZ8B7krEw0C3cn4wY+?=
 =?us-ascii?Q?h77S63OqEg+O/X9W3SPm14s58kgVmmrmuem5pd6jlwPJf/IOVKCIm65mDPK5?=
 =?us-ascii?Q?SjMc3dcr1//0rG3n06jlZjiFvu9Xb7HyyCxQHoWPDcXGCh5x8hoYIV5+Ttok?=
 =?us-ascii?Q?btXiKF1f+fNqheStCA29RIivYG0nRC4s/Lu6jU1ULajczDR34ff3seathbj+?=
 =?us-ascii?Q?DHu7uaB483MAMAJFT7mUi3ri9rni5KIUv74btsnLAEGDpIXfkJcLvKvTNMKg?=
 =?us-ascii?Q?LT3+X2r60Cel1d1KKXju+fFQ6r5ru1BQCaOIDgZgiXHF/6yma73IuDgW6nGK?=
 =?us-ascii?Q?iQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0052EE22AACD084FBDAE6040273ADA73@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +J8bxrpyZn/WLZiJq7v9eo0voLqwUqENCUujAMgPxo11/3W8O2rlsp9ZUptlsoZ2tJQ/YfP6bO1rmNRfaqyw4FkwLU4DMwE6PMN05vk5aE24FKnjqb8C8eLivs7VZIzdS/umq0JmJMCw9/46pHP/GALFLJycQt7eHwBRY3C5y3PUjzOeV78Y/M9fAOV9U0vNuczanX75OBHe6xFmbd8DSWxN5CBwb/3VK5ZOFwdDJCxOqlPEmjNRDqCb/UHiSvfR0+2/vrCO6NQD5fhIo+z6MiftsWeXe0UxVfvx/GqZJHAizc24lzMmabI95IpDQogm7xGvfjBlbEHjw4AvCAhOUynFA4MurD9cEPo3JyM0y1T88GoQCXHEh8/oOakLCV6NqHzHIOK28SCeNAMc16004ep0cisvYnBvswWSmt8u+UgeS3yjuANhMV6y8QKCwjL3l6pxswE1xLt2V5xMEbXh5e4O3xm7cmBspcKjzTytYD6uyf1twLnvOkBFg2uN1CUu6WCGtjvctMPqeeqDhrtL72M8dsUCGEJGPO1xJDUoTlgON904/ctxUQs8Ab/AcHgC/159JU5VXi1O6E3YdCDf7SjlOm4rQEuEeFWx5u5W6ThStPvwkZrD+XNzYt+nC5SFG7Q989LBb45PKIrnUIwSLE6QsIa5QQ+iZLk2KRdCTUnzmGdaPfvoXgKSKB3TsceqJd1kpR8qPGgnaJkC8kov0RIKbXI+El6G+6vwEFkhWdxD4905xZ81iL5Z07gg9Xo6+evcP7MnsrdzLFezTktUu+1GWNaggpZ56XunCBPVVGPtuqNnYizqgYA/z0TQ5zca9kctZczffD9EayiHLSN+ZaUhT0U4RKUM5xHts+Gz1DjPW6iWzO453E9g6A029/FlR8F4wX4ukqap9piJ56QkuQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573318cf-f2ac-450b-3793-08dbe237cd53
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 21:55:49.8602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQmXcGo7KnenGyRaTyC3FGNyyHtJHfgN/LNXyMA/rUd/X7Wkfl/JQdM5jLTSkJlFlNbXP/7tSU36ItCiRYW8qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6881
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_20,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100183
X-Proofpoint-GUID: EcyywdUKRW_103_7xYJzI0xEEklIrZOI
X-Proofpoint-ORIG-GUID: EcyywdUKRW_103_7xYJzI0xEEklIrZOI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 10, 2023, at 4:31 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Sat, 11 Nov 2023, Mahmoud Adam wrote:
>> seq_release should be called to free the allocated seq_file
>>=20
>> Cc: stable@vger.kernel.org # v5.3+
>> Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
>=20
> Fixes: 78599c42ae3c ("nfsd4: add file to display list of client's opens")

Agreed, and pushed to nfsd-fixes.


> Reviewed-by: NeilBrown <neilb@suse.de>
>=20
> Thanks,
> NeilBrown
>=20
>=20
>> ---
>> fs/nfsd/nfs4state.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 4045c852a450..40415929e2ae 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2804,7 +2804,7 @@ static int client_opens_release(struct inode *inod=
e, struct file *file)
>>=20
>> /* XXX: alternatively, we could get/drop in seq start/stop */
>> drop_client(clp);
>> - return 0;
>> + return seq_release(inode, file);
>> }
>>=20
>> static const struct file_operations client_states_fops =3D {
>> --
>> 2.40.1
>>=20
>=20

--
Chuck Lever


