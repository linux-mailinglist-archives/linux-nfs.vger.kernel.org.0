Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2459595F1D
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Aug 2022 17:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbiHPPd1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Aug 2022 11:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbiHPPdU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Aug 2022 11:33:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8016346
        for <linux-nfs@vger.kernel.org>; Tue, 16 Aug 2022 08:33:11 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GDdnwP001659;
        Tue, 16 Aug 2022 15:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vG42i16lf9uoma2btniUO+wyqyQwC2HNrvlK6Y3Yswk=;
 b=cD42No+iUKwoY3b1uLgQKpwrGAzdMicXL7SkPVJ31oF33trAjHDNZHzHLjthNh6am66j
 n6TTtCExWPJUHkMx+lvXF1F91U/hKo0Zdxvbi2wlFsXUC4hGnJhSc5lKEhfkP2fbCj1h
 6TR+LSJZyghUShF81CngQjJLKE04AKzXm/ShDN492x0S4dy+MYZLIFEpQhnrxbYTBpvd
 VZue1vNsVle5SQZKj3fZVxabJQbLqQ/aYQmYu7ai1BpxOGCNQpHr0TNP3eWoplScGXi1
 F/kzyJJVGHcCkltXs3ms1pE7m8JSSz7wi4moDMAvOGSOZNS3VzsN7ic6hwapVCj8xQIR QQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx4gt67jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 15:33:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27GDPsbw004258;
        Tue, 16 Aug 2022 15:33:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c46uvmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 15:33:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOW1SqpwY7OTPMp8RNhklZa9sl1FcAM3dHa3Hl3yrp1f4YxnkZMzNiNy8CUo6IwHpbkhaCoxxd6PpJ2HXgYEg8rbuaxn+KPc8TMm2jIEGjjEvsMEwO+4Pz6BlPWjCes2/lV768L1xqrC5PPx3ztnBIdgKxBh53JEijqjvwBfldzfMLiI6FPwtHrGhL8bnf9IoLG9zdLDnbJSvnjFwgAc1+TSJSY0JQq/teH/+74OfDBLh0B8z2EeB+31EB1kGhY4kRriDfRsYs9iNLQgfs1GbJNFbqUumIkhGLSek1xctxUMnQ+fSxBhMFzh73TGFIc/VsILNym864s1Cffh9v+5uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vG42i16lf9uoma2btniUO+wyqyQwC2HNrvlK6Y3Yswk=;
 b=kE1U5Q3uZOn0h9sPbF9OH5V2613XdwJeSMfwy6Scn0a/6SA8qb4H6UzIzjBU07GOXbKU817E7MKOwA6WGUTYzE80wKd56nxoLD7Gu4XWx2FZS/THMOiqWjvzqhNBHcJeBh3UAj/X0kvpnaCuksgqISaDmR7VcXttPzNUg2D20Jv2/BB5kq9sx17lCFSM7P/DLtBvJ2gMkxB9hNAxqYLC+x1JfHZeU+KMoiOfqVtzdMrthh65g5uV/WtGanJI6T2jkLGJq5x3i7SteYi6VatmHGu7ocEWrDu7NhMyxGx7x3o4adrevzFn7mTMV99k6+DcCS+lgOJFCEn6De2mpLDSNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vG42i16lf9uoma2btniUO+wyqyQwC2HNrvlK6Y3Yswk=;
 b=aSfdW5uvfsSblDmKrDxyIXfsFs2p5aT6ziDFne/CgHcVnnphjqoxoSPvjZJ/RvT1+d0/rtTni5Uze3PTmhh+N7eZcJqDV/Px2cp829xiW4/KxYAr8fOrA4lkOrY5hg+oPxv4IApCPRcsEx3hJh8xoecMBH91hXEWR7xBAIM2+24=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB2997.namprd10.prod.outlook.com (2603:10b6:a03:90::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 15:33:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9%9]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 15:33:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Thoughts on mount option to configure client lease renewal time.
Thread-Topic: Thoughts on mount option to configure client lease renewal time.
Thread-Index: AQHYsRznD0hZhSTn+UmSu/0gXbQWz62xqLiA
Date:   Tue, 16 Aug 2022 15:33:03 +0000
Message-ID: <729DBD49-62EE-4663-AB4C-97BEF756E8A3@oracle.com>
References: <166060650771.5425.13177692519730215643@noble.neil.brown.name>
In-Reply-To: <166060650771.5425.13177692519730215643@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdfa151a-1625-4d9c-3771-08da7f9c9c0e
x-ms-traffictypediagnostic: BYAPR10MB2997:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d8M0DeXA34hnrF1eApvJpXlMI1I8g7D1hoDFHLGW6SYHpShOK+YkVB+5lLHlSNsWpwJatIgPs//UE8KOJF9WTD6q2GD/6hhxKo4lxLNiT25n8MMv2MjJy5C1PbPLHOQKP7SPL0FNDIDmmYYl9RHdXFUA8n/8BLwTxE8mH15kt7Ul+Jg3BuRTh2lM5qlf/zxa7zoyiQbaIWcGNI+nP+X+dWeeSNd9xgTs9qybd1mvvKMz1KMAteLIykIG3tW0MOOgA5dqxtC/iWmZR74hE9ZmCeSqPn0rmEiw5H2sLhlNfDUI6uw9aHC8jaousR3NKrSUIeu5S2J3tPrgTnVfzHlmPFG/r7z00OJ/BsaM2V4EKxYDcecvs6RvO6FQ5cRk7VSZAxQmhIaO0+M8KQkYx1hfTUVCfkpeuqAGgVQTwTPY0P0W05Zti799g+8RwEiljxMJ1R0kqzg6ha3p2PCk49ERg7TWbAqIYNDSj/oRJjSEuVQWi7D8oazGEudYXNw4VvIHyc6H+64ojJoeDiBvNnk3w5SkDcRPGoXQEDCxewnfnPgAbwOPXTMaiKVrey0MdX3htH8ygqU6ahCZzoTsaRzWiaugHxAjCfJXi35PMzw3JdANBiSB12DPWeub8y4LVgQYNw1wNcY/zN5o1dtEvBxqKBugo+mA0e18FOMVC9ern0cOZMHSuu4+vXp46RKmKFpe1iRob7Urs+2R+jfiG6ZOGPVkif5cRt5fC6T00ry81Mew1Kk8o+0SsPjQ89hFSwlcIHnHwdfanmU260r/AIJ/c8cBN5yd9J+MPDeLErs5dfb2lqMP00Fq8tXe2X9Hi7AKbgbXKSGGlBGPalDkAvbTCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(346002)(39860400002)(136003)(186003)(2616005)(83380400001)(6486002)(71200400001)(478600001)(38100700002)(316002)(41300700001)(66556008)(91956017)(76116006)(6916009)(5660300002)(38070700005)(33656002)(2906002)(122000001)(8936002)(66446008)(66946007)(64756008)(6512007)(8676002)(66476007)(36756003)(53546011)(4326008)(86362001)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JVG4hvZbgL41MC9B7zzbKMQ9eS6auSpDHv5bZHuw9w3ZlMIOxzRo42E+C65z?=
 =?us-ascii?Q?xtXKpYcHat4On7LBhHsr2bHs+aMcMqyTukJUVmga2MaA2LU6DyvieESMoBLA?=
 =?us-ascii?Q?cXzB27C9G7ao6ZISznYpPIle9tmsl/4cP+nQEywCE69pxJDGggAJKm16N+iM?=
 =?us-ascii?Q?IN1mDxxXEmisI3WTi+WRVsKUDRWeusJqvTS3qhBRB5contf9pPZdHsrcZDiJ?=
 =?us-ascii?Q?iKRrBEh+c71Tqylfu6zKCpR3yufjDX3Xgny4E+hn+lEwQIu2Pq/vA+kH2w/L?=
 =?us-ascii?Q?jZlbcoTuG5xEDUqhle8AOPcbqptqAn1edysyt2VA9KAik6uAbK16Cgw8yfhK?=
 =?us-ascii?Q?sX8X2QgeitKBju+gcWQLJi9jhIJLpWsgIeUb1IqulXR8/Rblpdf8zt5kutcZ?=
 =?us-ascii?Q?T+xgt4UdfOEVcQ8dgdzM8u7QeEet4fE0l6neCMCBTi+4fscr2In1jui1bWuw?=
 =?us-ascii?Q?rcsQqRrtT3q/lvCMwRRj5XusOO3SwpNOvRsGaV1JfWFajJo8U/5ICZJ9IrYq?=
 =?us-ascii?Q?3qGG3lRKyLfpsZpLkhY3n1TwG991vjk6+MpuH4xnYz3chBHo8J+hZGac8oos?=
 =?us-ascii?Q?lpt2Mk6+n+82vJImsPdJIpPo7dpSzaAdjkXSv1/lBk7mJmC3ZdL421cikTJC?=
 =?us-ascii?Q?4AEgwJULrPqrADeYbs6ofj73KVQlWOsEpaZVNImJ1j8cav94wP+sOrmD2/Z6?=
 =?us-ascii?Q?ylZ7m8hPwm8mQi9dc845Cg6DufYZ4y8jqybJioRC1v3LUh5i5oIMhvWLH0ou?=
 =?us-ascii?Q?dX1tjRahT/bJw+VBtQhCSEci/i+mTCzZLUcxWeLQ6WJHATL3kgDMX01lrMIM?=
 =?us-ascii?Q?MnDha4ntMYOu4e7l66BIqBjCjkgmjozN2EysP3ABh+xu2Xn55hCt17yrUurp?=
 =?us-ascii?Q?u+czD8xb4LUr09kuqUFtUxPxbGk4pBpVpIQWARpPfDeTn1PPO/PlSP5BQGsI?=
 =?us-ascii?Q?6bMbSvmzKDZ8awAze9aMue0QbWTpJn7QRz73rqjwonDLsPL6JPoyiiikRQ4m?=
 =?us-ascii?Q?XvzFNJ0pi87xyBOjYAM3ceMA57Ac6JgDvViFWT0aVulAHeGeK9Hp9wQx6Z5/?=
 =?us-ascii?Q?vd0+XTgwkxNbSlDkTcPkDmnXkVgDgDVFMiX2Ik0uOrXB1ozo1RlLcbWLstZk?=
 =?us-ascii?Q?HbdVqRpaVSRQFNPXNPTmEvDgMehmmrpteM4Nc5DvP10OlP/sVYcaB14qjXNY?=
 =?us-ascii?Q?JG11xeZN/Xmm+XxlNT1IE22m58Fc3tBN2IGbjHGsZFGIvrRKh0/q0jdbgrE2?=
 =?us-ascii?Q?XrD7+Dhdq/vDVjHY53MvVIO0PTpislQqtpAfaXOpC0rTNz/7eyWTiaaSK84i?=
 =?us-ascii?Q?xrylYHG2rvnxgK5TJE0KHtdNM66HOnw9MhO6jZC57Fm5cB1V2uox1/N7vQEW?=
 =?us-ascii?Q?+99zGy8brm8N2S8NfrRfs0Wd7sIAsKLyyEfUkCG8hYFRm/KJ0qAWxGXFHijS?=
 =?us-ascii?Q?JNIgAP+sNh1c/WJfzOG7x6KkhMGkTeYtd0oWxdmZJt7HX2FsugfNentIfMFT?=
 =?us-ascii?Q?leaY2A2+BNxZnKeWST9k6UrFni2i+WIgcA7Smm6FHPBKQxBoa8pouENmfw3i?=
 =?us-ascii?Q?DNw/p4kuBNQ0ouLP7/KkKIlnmL/VqcOO+kQLyLX0FAi+7sj7KWZSUu5qvkF2?=
 =?us-ascii?Q?9wmNEt54teZzy17X1JL/t3LK8FZ+xr/D4lB3bzHcIw1Vod8z305zgMWVFRPA?=
 =?us-ascii?Q?XWY17Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <519A512606B32640A6C5CE025A874970@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XC9qU/sWalB8+c2g3zfE14Xpz5IhkdC/UFH0OV0Dqg+/gC+LEVkkRxoS1NPHTCtrtwRL9YhHUsp9iyb340hjPhSeN5Nj+Lnb04UHwkhehf9EkWl9IrUuKclCeRENRmNeXDDdX4mpbyqbII0zWJR8pIoAL2gVjdNNgSBapcIjbdM96j5Hr1L0EEprqlGxdj5FvnCSxaBEN55eXeOLNOAiMdVlmR2lItvzBhe6hlUL+NVFibGXhXW3I5riHKOpus4JtW9G+H1+Ti6s7LTMS2CnYlIb9ILQxs3hIZxzKOgKV4wzyYzSdIIXxZD3FSPX16h1yqhQLsDRbPYRc77kWfvk2FOdwOuQFbM97Dt1Pa0A33CW+zKAgxKkxCNAY+SYTnHYkpJraqZxSn7UbNavXM2lNcw+vnuF49tX/nzeSNaVSugNqlJZ5eb2buQvvMjc04tzUpo42GoYZ7MRDEqQECx2n6OrZnGTrKO2LrgvwEiLtMEjh15wfsNP3Z5I43fmju/MCJxd/voOpvelUAO42dblGJVhvDw0HKHjkQWLScsdgYorS8SHKs8BGiYuDdDi2bLR2WLA34GKZWzPvyVwkLUmttZ1zT1bElQFOe+WbpGGSWqBEYNkq9R8649tVJXV4dYEFqgWElUL9N1YRzt4Np96F4k+0ZzR8qEJRCT3eIxSzT3bLqSv8lorQDreVkWkOzuBkqdAtiLpSEnCqbt8ioiyMhIKqj6WMEl5gyh7Y4XZsCSGSJho6cV2oKo/nvmWKb7n
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfa151a-1625-4d9c-3771-08da7f9c9c0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 15:33:03.5837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/g/++/B1cTAmfrxwr/eDiDbBVTzjGGRRpjjbQrJWxVWOjyM9HxRIpaRxDeNqNA2//hP4UuHo2lAPV7uHD2Xnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160059
X-Proofpoint-GUID: 6cSGkZHRVxM5bL5vHEINXiB0so90AxK0
X-Proofpoint-ORIG-GUID: 6cSGkZHRVxM5bL5vHEINXiB0so90AxK0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Aug 15, 2022, at 7:35 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> Currently the Linux NFS renews leases at 2/3 of the lease time advised
> by the server.
> Some server vendors (Not Exactly Targeting Any Particular Party)
> recommend very short lease times - as short a 5 seconds in fail-over
> configurations.  This means 1.7 seconds of jitter in any part of the
> system can result in leases being lost - but it does achieve fast
> fail-over.=20
>=20
> If we could configure a 5 second lease-renewal on the client, but leave
> a 60 second lease time on the server, then we could get the best of both
> worlds.  Failover would happen quickly, but you would need a much longer
> load spike or network partition to cause the loss of leases.

If loss of leases is the only concern (ie, there is no file sharing that
can cause a client to steal another's locks when the other client loses
contact with the server) then courteous server should handle that. The
Linux NFS server is now courteous, and several other implementations are
as well.


> As v4.1 can end the grace period early once everyone checks in, a large
> grace period (which is needed for a large lease time) would rarely be a
> problem.

IMO the above paragraph is the most salient: if failover time is being
impacted by state recovery, use NFSv4.1 with implementations that take
proper advantage of RECLAIM_COMPLETE.


> So my thought is to add a mount option "lease-renew=3D5" for v4.1+ mounts=
.
> The clients then uses that number providing it is less than 2/3 of the
> server-declared lease time.
>=20
> What do people think of this?  Is there a better solution, or a problem
> with this one?

RECLAIM_COMPLETE is the preferred solution, if I understand your problem
statement correctly. Can you describe how it does not meet expectations?

The other side of this coin is that clients can have so much outstanding
state that they can't recover it all before the grace period expires.
To compensate, a server can limit the number of delegations it hands out,
or it can lengthen its lease/grace period.


--
Chuck Lever



