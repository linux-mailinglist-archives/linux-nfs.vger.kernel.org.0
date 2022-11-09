Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1001622D02
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Nov 2022 14:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiKIN6o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Nov 2022 08:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiKIN6Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Nov 2022 08:58:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6FF22B13
        for <linux-nfs@vger.kernel.org>; Wed,  9 Nov 2022 05:58:16 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9Dljeh027737;
        Wed, 9 Nov 2022 13:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2QfxDq7qJFEhStau2uKBiY+aNFgqvkusotqZxJFhyQY=;
 b=tFI9roiVatRiGDKSoBa1UPr/gXX0UTGPGnxkRMcMvfTJVZld11Z1FVLv4A3nSwO+vmNM
 C2fqYbVaqjFNTmqwWdtp4yQL2cO02eQ227DBYjn7m6nGneWa0aDGw65/J7LrpVP4hgPj
 AYg13zJ60VUh/3/4cdygdJl5gUfMYJU++KRUxon0HhIObBgZIh1HVUZ4MbD9eWuUOcuc
 XB6I3AYIm0IYs7rVmI/EkGihiinTIkMR7zITfs5V0LozEX2U4lovVieJMaSAxtsJc7AA
 K/hvG8Xw8NPiA1dNTDJm2ot4byLnayO/hCfr7EYkBUlAMB1FW0ppbDRvY5rygXAgudKf Ow== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krddar0bv-84
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 13:58:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9CJU9G017881;
        Wed, 9 Nov 2022 13:38:07 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctdn4gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 13:38:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOjCkw5ZbYIrIM6DaBbLeSn1GI1/O2WEKyH8J7CeTI15RkE1fpGE0fXSjY/caZmU6x6nqv1UvHKc2SUvHxlxz8wqGWjhQz6f1XW1tTBcxRzbizLEMHj1Yid/ZMaxRRyq7t1D6q1fnvMqH7jQm+66Vfs4aCltD7dlXpeBdwSUBdhObwCJXEVVitmeZbotDI5AvSxXru7uko5m08RDgfWO32eQtEzkzjTaSlJg5sb9pXDy6MFW+TKBom6VxdCh9bsw5/RJ4gySTTZFesqIxPCC72q9FSdsSj6UmyLKX7FvH1h730Yy0zLQcvhS7BS6fFv0NZ9dxNeo6TefbnlavI4AVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QfxDq7qJFEhStau2uKBiY+aNFgqvkusotqZxJFhyQY=;
 b=Mhyn2fvaDDNPYhaYg2RV2gsfh+BpIefwGhOKEaqwMc8vq7MpBKseCk5/7nlfLC/iJ1R1KjuaTAU4EO/bMgAq6kPxPZseqVZGKDhza2uxZvTjWB68yVpVkCJPXdX25OVKI6laCgOE8NmGI6eONS+a9cvbwmlcpvqmV33fWjJBR6/fh8EDbWxou7ODRtzQbTMIC30KopzXb5nL9Q8tcsfzyXQfqSo0LYYdsFn/3CvLVO4HMVmh9J0fZRukgSrDJB4w4FyctlH+r+BI3f5G9phRkAnlgvHGCtQb7fWzujl6ydrR7cVs8uHfnho8kCQSverMYQoxEn7xitOvvDYh1aFRKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QfxDq7qJFEhStau2uKBiY+aNFgqvkusotqZxJFhyQY=;
 b=WFSPCvM3+FfXsBqgsIDrrCuRlkB1zG8PLiPBUN1pe8DwwI3SmP4R3l0eLkUnMAnPC+eyQOMjjQ/5KaSqDjLDK+KF5oe6CZuP5RmslUnDBe+ODeKfmL4zyRgtbidcaQOmtyAZNcdDn8l4VOdpzehgT3EUyS6Nnfaz7KYkeLJz7Nw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6204.namprd10.prod.outlook.com (2603:10b6:510:1f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 13:38:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%4]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 13:38:04 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dave Wysochanski <dwysocha@redhat.com>
CC:     Anna Schumaker <anna.schumaker@netapp.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] Documentation: Fix sysfs path for the NFSv4 client
 identifier
Thread-Topic: [PATCH] Documentation: Fix sysfs path for the NFSv4 client
 identifier
Thread-Index: AQHY9D/UHAS9TN3bW0a4ulUjeWuAMa42mHuA
Date:   Wed, 9 Nov 2022 13:38:04 +0000
Message-ID: <CC98B38C-2E79-40CE-BD9B-6E336BBD6552@oracle.com>
References: <20221109133306.167037-1-dwysocha@redhat.com>
In-Reply-To: <20221109133306.167037-1-dwysocha@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6204:EE_
x-ms-office365-filtering-correlation-id: 3d68911c-ae42-4a6c-2e72-08dac257a0c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FwZL+EB4+BlvAW7cHSO87Wt30JLhQH6+jpUydIC3zl/x9w3ZcPzLV4UE2H0VsgeufR/IIq1EdPcMO4ksSIERwcggZtQUNRnhFirwLxWSswLzcBxu/tu/wmIN9mEH429styB+qa8TzZhQ7wdbWC6ftZkVnMU/eXKP1Bt19ekAcf5rjOY96Lp668LOfqgW3B0o+l0u0GykvvrZBKMk1wOK6a5+cDL578Tu+7b8L+jaycHaTFPiLllqh1gIXqgiYd9jve+JmESWulzkTYfAbWj7f9oB1a7dQykTCkZYdlILQ8e1wXwoEOtaHeXbDZcq0KQ874iAZnm2ZcXuXM28NbEj5fH0WJDjuYMV23I8ggC3r2ougsYsMk7us/rjNY4J53H/wYzCiRmIiVh3Dd02+gUfTZXUlZSR6R71ykZQHHN9BBHLmczNZLZqix8zMroikravQFdFz5zAgnJF96iBTme1Tk57n3/n4R6PQm6H/YnTEjKANH9ZxbMI1TnAl1HEecmUX1qRHMA/WYxPJdlC7yQeeRoR1VGvUQbGWsNuIZRukUaHVvjJBfp9YpFU7F4pf0boaPxewcHN6JiyifR4R4Gty3vlsZzjz4iZKs1L7b5QV6Egt5QFOVUnNDvOVjS4e77qPlqY7BUwsMsJNhrH8tDjnBr8swQXf08gZvru8vkFOslNKNdqI2WPrAB5DJEo4Qml6royT5UhJKkrODlivZ9Louk1nqWy2AyUub0gmLpil7Xwl5mbVc4vZSalDsC2xmxS8tYbs4nkQmV4v7M0C2pFZdrK5E4uwdygLkNvkLTAhp4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199015)(2906002)(91956017)(66556008)(4326008)(54906003)(6916009)(36756003)(38070700005)(38100700002)(41300700001)(66446008)(64756008)(66476007)(66946007)(8676002)(76116006)(33656002)(478600001)(5660300002)(8936002)(6486002)(71200400001)(316002)(83380400001)(122000001)(6506007)(86362001)(53546011)(6512007)(26005)(2616005)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gO5cmtJvgINazb8bQBiWChGHEljgBYSxHb3RSXjVefsVMmVXJ2RMG+CyHfza?=
 =?us-ascii?Q?U6W3YLzjSL3m+Ma6aihF+Rf9CGNiwnCgLMBOcmnwZOwRVa9ESU6VVDqJkiW9?=
 =?us-ascii?Q?wpCTOMS7ONuisB2frMpt46sn96R1RGRQ+B004WB79cdoA4oo1KVq6oC+AiWQ?=
 =?us-ascii?Q?XFOb5t8+PdA/KM/OoYh9oNKRNwQ1Zynsrm5sy3U7CJGtC+mWM0048J+PGMjC?=
 =?us-ascii?Q?RQgyStTN7Uvw8D4RQnwh8FWOTIKFd8kVUl7eAhpNY06IwlevtnAasf4dqD/K?=
 =?us-ascii?Q?ER9hl4VI36a+uTed/qu3/UKNnolFucwR8x/bzfbnlWWcW5NJQa/imicEUfZV?=
 =?us-ascii?Q?WwiP1qsdRDtMBYZk7CUsJPLDsqldAibwITbqfZlNFT1tPQfKwp3ogRGdYZ6k?=
 =?us-ascii?Q?qt6ZL2TYmvhhOOZUngjLIrlb8hSOqShwYamePsxWlDz4wSXQpdqGlBu/G4n+?=
 =?us-ascii?Q?Se/BQckLsiTlHYRMuBe8D7YEv4z/dm13vqAuZOo+oxNVTVweKsCtVPbnoqKl?=
 =?us-ascii?Q?Vc4woZWT0LstFxnxxViFIKVEzS5wsZGiPiMd8gXvmDxzzf5nhDLlfnoEhQye?=
 =?us-ascii?Q?J++PmhLJYk5DGZ0k3RTfOInlYo2ru9g94jCPM/JXnDJGMOsNUKz8Gv7y6p07?=
 =?us-ascii?Q?oS9ra7y7hmldLffQsktnLq4K0+kvwSFFltF2fXtAjvs+hdD95kwl/Du6zhNv?=
 =?us-ascii?Q?kOkdWusl+H+YRXtyzCXsI45NH9cP5J/OUE+U2vCEaAJHLqM4+Y2oV2+HLOta?=
 =?us-ascii?Q?q8PZAQtsqkhA5FHjDQw0mx++smDpTbQZpnbX55NL+Kd3ixFx2+aMVTGuu0Oj?=
 =?us-ascii?Q?4T74MlqcCbWtFZaGpenCKTKdQhrFK4fm5xNrvs3/rkqN6jENcDs5Cgw/lTCA?=
 =?us-ascii?Q?WSjazolmg8n4Z/58Zpy5bvZH/9SAZc8vOfiPH/SFpr2G/sX/bzSOhcsuJpmy?=
 =?us-ascii?Q?RWuSwBWKDHmEg7kI1rmicRn+ISg1MgG4y2arzjf5Qgc5USXgtOJwy4kRZ5Be?=
 =?us-ascii?Q?l90Qmk/dLGs7dAuF/eUckiQTr+t08S6Lq4EQc0m9FaFVuIu9aMpZgbHa9dbd?=
 =?us-ascii?Q?iGiq8zmo6OpOsiYGPyB+/mjWAmKjtRN3eTEmUw0o2xy//KvZuOH9L/lZTeGI?=
 =?us-ascii?Q?+GmI3wjPb83Z3WAjHBKF7FnGMTd10sj9hWNxAiqYaShh1QXqBN0TVOB4oDy5?=
 =?us-ascii?Q?sDIkAtQKtm/y8jb6Tga3FV6BJ6NwkO4+K3eywaR59000f2iM/5ds4DMLNnZJ?=
 =?us-ascii?Q?0um7nLHz1exlBXPpkfFJ87bVfuVo4phxgLRFVzFWc+ohdcAbVr+ziSyLrj3I?=
 =?us-ascii?Q?bAyv+MNYnehkMQql/2FUFZ49sC661+XlqcoMiYtJSjVgZOR7BcQosxeOfLNR?=
 =?us-ascii?Q?fAVXMG9VPIjo9Qy08lhjo9lE856+J9FX9DwjdvoQezH62rOlgFYp6/ZDm6YM?=
 =?us-ascii?Q?e4dVE8bDde3V8NcfwWyTh2ZkOLtIsBOQLOWUFIs/n9ICaKEpemz0MZayACVz?=
 =?us-ascii?Q?+AdJBlBAZpEZhf4ewnCD881uukXFNclRMv7xUxa615pVoTPUtgO2N6FJBy+C?=
 =?us-ascii?Q?+1f6uVDdHFDyAAxMhBDPT6LdrlIMUi3/STojY9C8DdUXtTmFqLy7+qpZ3EEg?=
 =?us-ascii?Q?EQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4FAD31376C40884F8DE9EF61B0C07193@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d68911c-ae42-4a6c-2e72-08dac257a0c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 13:38:04.0745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dKY/H4nZZO5jJQbw3uitikaRMqGac/tkz+BsfCjKfX1gR3fYwHzYVQZ/1oE5M5yc2hBDzEgu4PX+8bfwSgZZEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090104
X-Proofpoint-GUID: AyywZ9NjV-FbFQwL36gZfiiX7b_MHBUP
X-Proofpoint-ORIG-GUID: AyywZ9NjV-FbFQwL36gZfiiX7b_MHBUP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 9, 2022, at 8:33 AM, Dave Wysochanski <dwysocha@redhat.com> wrote:
>=20
> The sysfs path for the NFS4 client identfier should start with
> the path component of 'nfs' for the kset, and then the 'net'
> path component for the netns object, followed by the
> 'nfs_client' path component for the NFS client kobject,
> and ending with 'identifier' for the netns_client_id
> kobj_attribute.

Seems like the redundancy has some purpose and is baked-in to
the path. I'd rather leave the sleeping dog as it is, enjoying
the morning sun.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> Fixes: a28faaddb2be ("Documentation: Add an explanation of NFSv4 client i=
dentifiers")
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> ---
> Documentation/filesystems/nfs/client-identifier.rst | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/filesystems/nfs/client-identifier.rst b/Docume=
ntation/filesystems/nfs/client-identifier.rst
> index 5147e15815a1..a94c7a9748d7 100644
> --- a/Documentation/filesystems/nfs/client-identifier.rst
> +++ b/Documentation/filesystems/nfs/client-identifier.rst
> @@ -152,7 +152,7 @@ string:
>       via the kernel command line, or when the "nfs" module is
>       loaded.
>=20
> -    /sys/fs/nfs/client/net/identifier
> +    /sys/fs/nfs/net/nfs_client/identifier
>       This virtual file, available since Linux 5.3, is local to the
>       network namespace in which it is accessed and so can provide
>       distinction between network namespaces (containers) when the
> @@ -164,7 +164,7 @@ then that uniquifier can be used. For example, a uniq=
uifier might
> be formed at boot using the container's internal identifier:
>=20
>     sha256sum /etc/machine-id | awk '{print $1}' \\
> -        > /sys/fs/nfs/client/net/identifier
> +        > /sys/fs/nfs/net/nfs_client/identifier
>=20
> Security considerations
> -----------------------
> --=20
> 2.31.1
>=20

--
Chuck Lever



