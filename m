Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0EF40C5E2
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Sep 2021 15:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbhIONHT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Sep 2021 09:07:19 -0400
Received: from mail-co1nam11on2110.outbound.protection.outlook.com ([40.107.220.110]:63648
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233139AbhIONHT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 15 Sep 2021 09:07:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogQLpOWc77qu0iyz/myuXGjLW0+bd2EZwSJwMQ9mqf03eORlfh9ri8COU7koYIKmdvK+Fo/EPBvkG54ZJ42v5uXyeK73gucRxxrbcNdC6Tu8WT9TQO1bgKiXcEOfdnWegKGJ8IZ2HXhiVJbwIEcocY31MXU+XDNF8HI0RiPub2Y967iJLdTQh4OY/9QzBzlL/Ucae6R2FgZnxsxbpPtHWeL3d4YwlBpfi2L25N39EeWbxO2/AbjMqdWarYzuuGsJiCH90CdRM/IAHMjnGZQNbq5XdgpEkME+iMB1YdYUWysjAMo3CAdnKOEHt9k1H3FbgUNkJC9ToUw5VeE4B0iuPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SdygmmET5717g/26VqGRH3nUoEchr+AlOu4Es4oREEY=;
 b=AcpImjxKKf1Jlm9BoUnN/IOvpRUagod5SjFUgArYdUNPvujaVQaDdVXAr7S9Eb6wnqyE+3CfeeTgh3lTM7y5h4dSmIq5Ymbp+1uKc+1bI7goIfqqHHizD5gX20wi6RkR/j2S8BsleE6tcIdaLxby8oV2uGkY7c0Q9ig+PFMU4b1HQbcV9Pe4Ul1bVWXQ6267ezcz9lbzKADBJ7QD2VZmcbNTTMA+MWMFYaqcpnIUoLR56q/1pGk1GM7dprrozNyINIE112kV5f+akvxwu4XNVpSzKNNAa58l8I1/wgWPsQ2YkD7PIGNReLBy2H613r9Wp/vBMZLJ3nkaW/scmEw0kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdygmmET5717g/26VqGRH3nUoEchr+AlOu4Es4oREEY=;
 b=Ml3fLxKD2fj0CIEkhX/vkAtEhGJMbIZJCMR6LHGigihZN6zjWBHVzDobEelXtTEbPIcMgOk89JOCI+6vqoadasgh1I8o8xmvg3zrDXhH89X58eRzBF3p9FA+V9KsIC6hWULY4tF8TEoQmRMJKbkk/4D6RdadFWta255u5Xz4o8U=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4604.namprd13.prod.outlook.com (2603:10b6:610:d8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.9; Wed, 15 Sep
 2021 13:05:58 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%8]) with mapi id 15.20.4544.006; Wed, 15 Sep 2021
 13:05:58 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Luo Meng <luomeng12@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Subject: Re: Questions about nfs_sb_active
Thread-Topic: Questions about nfs_sb_active
Thread-Index: AQHXqggqrDZYSx21fUSxNoXGAjuX7KulEMkA
Date:   Wed, 15 Sep 2021 13:05:58 +0000
Message-ID: <30A81685-4F45-44D3-B497-117BF7B33903@hammerspace.com>
References: <ce24474a-39a6-dc3b-0580-378cdfedf0c5@huawei.com>
In-Reply-To: <ce24474a-39a6-dc3b-0580-378cdfedf0c5@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bea6f5a-4776-434a-bb35-08d978498f91
x-ms-traffictypediagnostic: CH0PR13MB4604:
x-microsoft-antispam-prvs: <CH0PR13MB4604A8510057DCB018ECD1C4B8DB9@CH0PR13MB4604.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JFXUhIzmKXkxFbFn1cQ3MnlLkG+sbBPxdh+ZdOPwOvjyEi7ghZ23CnpQzyY/+JGL3U7xj0mMhEH4Arg6J4fcffs559zpvYshQgX64PswO8txlG7NJPbekznrucFtKvqkaC7WOkHw2IEGcU+gw5WJ22ORY3SIKvJWC5LgZYO43UDDMWCju5EZHfussmOgVaKY+KyLM69ReGmGOE+0GQhnr7UynoYSYXzD7JoEQnNRncuobJzxS8r7UAgk/RbrtWVms6/ykN9RtwlQqiWPIotocN5y2Pp22uneM8IjkpaJ4enPoZ/+AFWH9/Bws48Zy1WERObROQXJk4IVwE5V1+r1lKOul9o5meJHfyZ9Z41UpBUEi9Qsd5dpQMszM6i4XGLujSCuWkEg3woQ5lNpprdis7OsUhQflzPsIooTGTsHJzm+Y4Axqy7BbL7mqEgSIgn5g6LtRpSZM86f01/awXHnQxOQqGLFF7k8mQOM3dJAQU1OlPfHuzx+yWJkuBpURVlp+8A8nVGAhfQMwPjfB+Iq4sQNw4b7lnQpoWffWfyU/5xLlKjNbUijTVQvc8gKujOh/vFfILl/2tj3HYYXD75F85XmmoiPwlz+RrpYb4igfBWq7bSemQvnv5x33cEL8cVCoKw9KjMv7Je9eHuWouk/kA4yh3TuaYo1p0JE+cD8VyYDhObAM+um6lWH6Eyl3I9g/jqytQt+qbAy0dZbwKB++GMA7IGPoeEco7o9Hk1d3ZQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39840400004)(366004)(136003)(346002)(6512007)(54906003)(66556008)(478600001)(6486002)(5660300002)(7116003)(122000001)(38070700005)(86362001)(2616005)(76116006)(66946007)(2906002)(33656002)(64756008)(6916009)(66446008)(4326008)(38100700002)(6506007)(53546011)(8676002)(71200400001)(66476007)(83380400001)(8936002)(316002)(186003)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UFjdULxiQHA7Bu4eGYcVDNpnB411rFlKHwAnTQvlqrvusNNjAtSXIYEEmM2J?=
 =?us-ascii?Q?c6Liy2fuULdAV26oPpPhQfI3pvRlF1HrkG8CstrHqthtCdO/+myzEDGBZRbP?=
 =?us-ascii?Q?N6npWZsGTMJXIRVDcMyE34r/Qz+0DyFLr5I1+o+A5X/BFuBJ+DaENown4K1I?=
 =?us-ascii?Q?OKIftj0TNjUyjC86MHS1K8QEoJ4VnLOYldGWLxPWbdxng+v/LN1GBCM2enUK?=
 =?us-ascii?Q?Cl8xzEVQTuINCjtWo0tJiKGhcAuG9JcgxNxoyqhPg/GEee4M5P9zjxXBEts2?=
 =?us-ascii?Q?ZsR/vEuOVzYAu3pOugu9v4ovTCkESpkGatfzT4rau5Jv28oHn5NT9bRMsZUv?=
 =?us-ascii?Q?koQ9kLd4eIDtvjZCiG6EZzuwkN5lEFVlub5KiTIw5FtnXXzKh92j3MolFU7L?=
 =?us-ascii?Q?Rh9ZVtcU65/eDdGyt9/0ulgtO83np0JjACKc/UK4faZHW/zpjO9XiqrvOAXi?=
 =?us-ascii?Q?1qaJTA7phIHAq85EAZWob8G/evSqbIpZ/XH02GijXdmAAtsVSSWNS8ejJ6R2?=
 =?us-ascii?Q?1Gz3I77kktG4POU+Lfxcpl436CCDjW2G9Mn7hF9cwu6ulj8hOB17LhHYZDJD?=
 =?us-ascii?Q?ImqCsiru/2MkUeixvDCu0wctyMRUTJASOCGLi9Yg92Bo/EnVhe/Q4EuRgi6d?=
 =?us-ascii?Q?eBqjHT6GrlzIm4SVRMHfK3emVptECiTcNa4udBRrqCSwSMI6bPhHXrSneq6I?=
 =?us-ascii?Q?kZrG+BN3ux+0E+0l9njIbVpl2B8zODn1gpSUeROGyvvCOpLwG8VqX3y58or1?=
 =?us-ascii?Q?KKRluKlPghjJY3t4Bgx0YVuCEqdw15sSXiDHB/bMbqcvXYWZc2/xllrCRASR?=
 =?us-ascii?Q?y+f2LxDTpmem2KyA+Te0EXZ6Yrr4cH4RL452Hl+x3thsYoiJHlBb5dUzVJ6Y?=
 =?us-ascii?Q?XmLzdEphPzfpHS1hE5pvLL4ErOBP07VIIGrSSsUrx9fRLdn7y7mh4TKsQC4g?=
 =?us-ascii?Q?3nCrBSM5Vwvo6uQ8y6MB5QVYjvK0MIexoafg1ef7hSBvo6EKaDNN2eRPVyZv?=
 =?us-ascii?Q?vCrnyRQxTp6Dws11b4Vqcp47h9yiUwAfqbvHXxaJMt8Pvp/GmDqAMYrZXZON?=
 =?us-ascii?Q?3zSlDnWwgGW5XNARgC/QT239DU38E0B5mL083ksiqHWutnPP5oJAycxcsK7E?=
 =?us-ascii?Q?6pivU1GGj5nxfzoi1s4nsOJYrprQI/zvoiN/sdJIpoHHGQympPyI67ArdN2D?=
 =?us-ascii?Q?pkbty3AnJrIs3CLpdyVePfvjhexzOuszlRio8emXfl6IHKF2Y7BgkEhKbUC2?=
 =?us-ascii?Q?xIRUoe6kyK3wIqJucDtUDjy6fP3Zitk3+fmk7mVQcWaCNBAyoPPaL1iNzhXz?=
 =?us-ascii?Q?t3kskLktc+0uKZAZv4CKasO9q4Px32wIFE1muZkSZGb9XZN5WWXK03LstgMI?=
 =?us-ascii?Q?s395fwQ9bDh05ANTJdCv4t8SxbAE?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3868010FF91BCB40A12A1437C05FCCFD@namprd13.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bea6f5a-4776-434a-bb35-08d978498f91
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 13:05:58.5168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AbYXo2hjyZTrM59sG3b5sC7w3JdaZ3nSFthEQyvJQ+Gwmdb7Tiggd7eNn9Q4jdoIF1rQbC7yLdmBL6jOQHOuzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4604
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 15, 2021, at 04:03, zhangxiaoxu (A) <zhangxiaoxu5@huawei.com> wrot=
e:
>=20
> Hi Trond,
>=20
> I have some confuse about 'nfs_sb_active'.
>=20
> The following commit increase the 'sb->s_active' to prevent concurrent wi=
th umount process when handle the callback rpc message.
>=20
>  e39d8a186ed0 ("NFSv4: Fix an Oops during delegation callbacks")
>  113aac6d567b ("NFS: nfs_delegation_find_inode_server must first referenc=
e the superblock")
>=20
> But it also delay the process in function 'generic_shutdown_super', such =
as 'sync_filesystem' and 'fsnotify_sb_delete'.
>=20
> For the common file system, when umount success, the data should be stabl=
e to the disk, but in nfs, it maybe delay?
>=20
> I want know :
>  1. whether we _must_ stable the data to the server?
>  2. how to ensure the data not lost when umount success but client crash?
>  3. the delayed fsnotify umount event is reasonable or not?
>  4. the 'nfs_sb_active' should be used under what scenario?
>=20
> Thanks.

That has nothing to do with I/O. Delegations are state.

_________________________________
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com

