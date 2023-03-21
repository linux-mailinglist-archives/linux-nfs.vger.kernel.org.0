Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9A86C3396
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Mar 2023 15:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjCUOD0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Mar 2023 10:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjCUODZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Mar 2023 10:03:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DA6AF12
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 07:03:22 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LBiWtS010902;
        Tue, 21 Mar 2023 14:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6MYhJjRHu1Sr3tzKN8OTd7t0Cn4P7gmYE1B9WNacRQc=;
 b=G9sZJPJWZHjCuiFj2bCrtnZwFSH5mMj4TMUZHdhnia75RKa3zbl4b1EpvRDHg94VTjdH
 HuzpVXAYRjZVsFGvpAlGxYpK9pGrj93LxjLdRROhubTKMMRYEHn84E5EEt9Bj0NLp3aZ
 Mx0PiGT6QpeGco05uDQSeLi8RoiaGqDPZRmrVGbEcj79tc2beKPRLLA3tU7bAOYWUPfL
 9BKalb3HvSXYUSqVvNPtcTNJ7Vw/iuTQWrB6OehRV0DFsZqAqW4gOdO51owl8hDHOclc
 97g2hvldcCuwwXSy8zeg4dIuTdY8w0zCLtav+ckZqO/EeHKntasxBo4U7e42ki84veYc iQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd56ax7q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 14:03:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32LDOGj6006553;
        Tue, 21 Mar 2023 14:03:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r5rv3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 14:03:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXOllzGkNSGYbp0vm549g8B75U2pyyePKsjvOU+uJ7u7csbOQfoQtKkKPT6/lEMKaWXtK7+mAvTITSdj92Seb1UsqHHODAW4OT/yd6Y07gXGQ694nL6R9NYDYdTgvZIZHWT5DYxhH+MaXhPPVIoFFfG2CUxikBcvc1hAlColEoks1AhB5yJePRnEaHZw5IKNvgOx0MKCC3mVFLGOJ8fp+9PZWvy7a8clgBTSuH2Y20Fc5NdrNytogvHL2IX8cgSj0d8VRwZPlRag3/p2y0JxxWuh5zTlmlQWNaUW9aZRC5Otm2+uuhIsRgvmQw4NqIEiWww0Q1nmspImngT3a+X0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MYhJjRHu1Sr3tzKN8OTd7t0Cn4P7gmYE1B9WNacRQc=;
 b=B4VanCEgqNgH99xwNgReMxlwAfPoNCIwoJhn14tL+MawoyGGShm7CdbIlNddhaOiOTUXMTybhl5SnDZklr+sRREJvuMNya1ADPpv6k7FdAMkyqGrJVE8M5cL75u8NQi7VURNZPCAbAWAmziwenkAMQugLDus66dHtFtVklCWIhI73VrAxhUMYtA4ORrz/K/6Q5PUAwZWve0iq56FHBKqIplMNo+uHxv/yczP5hzVuxY5NRgLU0+fMX1cpYcjq9Cpty6G6RMCYRYBcRhLElNutMltZXKpYO2t8/gBBKKaS/VZpSc0e1163RtXfDwS3UgixJN6L/rjeTXYUkpC8vBFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MYhJjRHu1Sr3tzKN8OTd7t0Cn4P7gmYE1B9WNacRQc=;
 b=dpgRaiLDoel7RlOLyviTt7BkQJMEJ9agEVs3+i6vkKQE3K5alKiywm9xMq/SUZa5EavyTvzQyyCvib1pw414M356VSFmAQ9im/qasJKzXL4Hc2p+oTGnm/AavSosGL+zeTuvTtwotfP0X9BrMVnn8GHrJnmvzNuJrp0Gh+t/cw4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6390.namprd10.prod.outlook.com (2603:10b6:806:256::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 14:03:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 14:03:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-tls-handshake@lists.linux.dev" 
        <kernel-tls-handshake@lists.linux.dev>
Subject: Re: [PATCH RFC 4/5] SUNRPC: Support TLS handshake in the server-side
 TCP socket code
Thread-Topic: [PATCH RFC 4/5] SUNRPC: Support TLS handshake in the server-side
 TCP socket code
Thread-Index: AQHZWze6raUwPVIJ30ib5xd+ODRKva8FHigAgAAnHIA=
Date:   Tue, 21 Mar 2023 14:03:03 +0000
Message-ID: <81A90B73-3367-4D4E-9F60-A20CF6EE6BF9@oracle.com>
References: <167932094748.3131.11264549266195745851.stgit@manet.1015granger.net>
 <167932228666.3131.1680559749292527734.stgit@manet.1015granger.net>
 <55c3480354ae273fceb67976bbce33b9e04e6cf3.camel@kernel.org>
In-Reply-To: <55c3480354ae273fceb67976bbce33b9e04e6cf3.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6390:EE_
x-ms-office365-filtering-correlation-id: fac09dcf-6d3b-4ded-3b0a-08db2a14fd1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XNVWl9+YRP/y0ArxSyFHZwKkW6ZT0nhgs1KzrPOG1Xofq5bn2N1X+WZW74CljH9P2QrTX/9KdIakjM7ypzEFQCpWa2tf+lCQ3HtLRB1AGPjdEyFG8wkHUzlNrAr/4HhNZeAt4zYEXasnO75pvN/odHATOEjeHdvIhq37tHH54bDJ/0JFAXTNfWdODxeb9j+DN8zCO+se254FDi+V5bZ3s7MbGwzMVrH+oNXwt3UUHgrWrEZyeuOrzutyziYFvUu53v9FZ7COPbWoGu9x875jiQdn+2CT6sRyjPG61DajBD7c7IPlAN5689AtWsmerhtPRU+xp1QLs8dBAcV4ixRvb6+WY5M2dkiykCF4592UlyGG0mw1zOwWprcOb8LvrdMELR7x6JUtQmoYiQ96wQpdznPDiJkIebBOMW19XPh+pBJIohVBqwzr63lvGBltKWZpq7Vx9OVT0juBegKBgNHxrK4O7124Bd4aw1puANMEswkgAmHeY9hduSXqQMioj+aBHAHrycxCj0kREoDFp38pJNzs7F/CZv+OacYFY+rHYIIU6YfTmPI8ioRtQlB/De95L31ZiQTSj6NHE1fAilELlhmbMWtg2A1ZBBdxeOu+WOeh0Quoo9Z4+FMu6wP7xDm1htbO7nHnC8Y9RW2+rgpNijMLz2LrQk4ZNkm1TndpxBQp+c2g/wW2032kMl0XxzcbBHEiYWi7ijN1/JNVXUEjv3ttXeGyB2m+jiGoZ5vmIds=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199018)(41300700001)(71200400001)(38070700005)(30864003)(8936002)(6486002)(5660300002)(122000001)(2906002)(186003)(91956017)(2616005)(478600001)(38100700002)(66556008)(33656002)(316002)(6506007)(6512007)(83380400001)(26005)(54906003)(86362001)(53546011)(4326008)(36756003)(66476007)(66446008)(64756008)(66946007)(76116006)(6916009)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wSeRDH+GJNiE72ux1Bpc2vbY5XquLjPDZyb/yxtoR2PBChR2lnhzatWw2/uf?=
 =?us-ascii?Q?iPGcOpZLFFVc/ya2gSrh7BRFPpS5tnwk7T2CxWeYI0gedJ9nNElUC0qmDU66?=
 =?us-ascii?Q?k8mbht8mADI2ehzc6D5JypfH3043uLp6aXW7NoStmQ6F3rsbbEV/D3q2ugdV?=
 =?us-ascii?Q?5/+F+rIwHGNFynQ8zC/jPvDbzqDAR9SfwOCNllD35P6yuaMxPt6zj3aZtQR6?=
 =?us-ascii?Q?5s53+iXZcgLsuJpFTJa0tvjiVLrQNhncSz59ztPKYILnj57syScfnXjs/ix2?=
 =?us-ascii?Q?iMrVgLA8UOdDQ0yzjD/S7Vfl8BMDAffkMiB7zZ+IBDo13ydc1v/wq364bSdc?=
 =?us-ascii?Q?cJZYXguiL0dIbbU3Q0z/KEGMe3aoJ6dTJ6BdXbtFVoLb5J86A/WwGnJwsRjO?=
 =?us-ascii?Q?e49pDUzSVDRYnEANg45ijV0iBYGb8/TOhy9cdwZZAja3jFitIj2PHAi4GEsL?=
 =?us-ascii?Q?abuE6ClfoGIkZPvMx8Cb0T8VGrgnO0IFEM1vrR+cPpXMP6lPJkkUEYL0oswx?=
 =?us-ascii?Q?ECQzituIvJnRWDnw2lGHAgsGOYqkyHXAMeQX6eFEJ+wDllOdhKi0WG24IJ8n?=
 =?us-ascii?Q?QL8dwvXRQIpEsrNSnjZFmpB+w07w6Ej8zH2WNo2F8LeXCMRkPlKxeZg4dwvt?=
 =?us-ascii?Q?9YoJ1cK5fKdG5kY65eyCvTc8Tj+2V2zL0TNtuBOkmsk+3XBXkUAasIhefaQC?=
 =?us-ascii?Q?OLidxCBHf3PU/GQtNharDMLEWe7O8hPN5Vkgz7wP/ofoA1U2InNwqsZEW9Vo?=
 =?us-ascii?Q?m7YPnS6cXUzxq+nvp6J8pA5fq9tWvLQ5jru3b3PlnjEZ71V5ydJut4jLOZ7J?=
 =?us-ascii?Q?d6Tu+Jcyda3Yyv64hrkP2MQmRM/PngnhBQzlZipLLDdqIbDVg/u/88rX8JO7?=
 =?us-ascii?Q?JbnqjcqzG0UIVqaTG+pVM3NB+UbKbxHMpgLcNCgK/Bp757PFWgt3ypAGpSD8?=
 =?us-ascii?Q?PjWw6XwFYeya3OYG8wG4ep3mEqXGS1RpIljAS0Q1X7rVROc7AIIPGju3jbTd?=
 =?us-ascii?Q?5MiHUJPsN2OXSCxpU4q0PjSMO/6lHU5h/1aTy+hbk7gAT1m1jGCWTMztvFgv?=
 =?us-ascii?Q?a93K7yxsvJe4imsZDgRV4TJ5knCucuojZBv89eJDVm7V6BjhTDQzuHbXYTO5?=
 =?us-ascii?Q?tSijeXrjXJnbcbCIe3gI2Mj0LtFbJpCzepLGXhpCx990q7aSLzO5RVny0yjZ?=
 =?us-ascii?Q?LsxTRB/3b8258xihTd78suCUG/uCXAlc3C3bYG2I+dTOTo8OtqtjZNBOdZxT?=
 =?us-ascii?Q?SdAxuvhA2JfNYVLvc4dh/avmRzoMk4BpBYSpolzF7O4yhLN5s45+/DvEmZGo?=
 =?us-ascii?Q?UMSRQ3ZrBqOFCEcKrivmjcTuxVHCXsETjyiLGYlR+4b3BVqigKJNe9MNis0+?=
 =?us-ascii?Q?wpw474FneMu59UFCze/Qxxy3Zx3INUFSYe/gBysBO5XhrSqks0Oo369C7riB?=
 =?us-ascii?Q?A4xWHPq05nYrKXWVywxJe7nLPYMQTbojDsW89PH0V+iaWzmpNWyfdZyRRB2O?=
 =?us-ascii?Q?y72xi50eehVfzhxmnTGsZobzIAvLbYHapkzjx+ubzAWlznAO2ggvk+F6io4A?=
 =?us-ascii?Q?zIYLv6T59calgM/IH8zSJsEe2glCY32M0tLMeYsZj34dm7P+h8a53iKANjuG?=
 =?us-ascii?Q?ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <942520AA7A9A854193E557D8AE6B2B25@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0cQcKVx47ykhsaI31Tgl2w4TP+o62OczjOSfZh48ED7I+lwoxqDeCis4XtXIqXbAGve1J2GMZPq51dmTtPfStSg+lINAX6o7FiY13k4arf1jWg9uPDhD41QbPk+Xv5hAFAXP03d8UAuKskVuROjCsMy/w0l23t9N6RFleA12lbhx1EdjbNBjcXnuvVyzB0GA9mEsDBTMOwj18pucWi8h4lsIAalCaoWblCfGgk+m1Ka+I3VeVRnQTxd6CHAjyS8uJZ2xhHPmiEO9cFBpI+Pyf+tal2mH2Of46HlwVwk0BJUdmAnCUQCj0x4bW6yHeWgxfiXUIo4PFdo81gE9Xhu6dY9yNDqocXy/H5/rugN9OgVmkyCuvQq1uymTHX/eRnZztFrD1xZ9P96oWZmObLy7NnmGavXDr6rHyTS9912jvmiCLP4pGxc/+D9RPI+RvUvJO5aquwtHcekG+kP8EK5/2w4/tG9c2jAPIw+DWw//Mn41Tbwyee7c1OSKZwzMRRCR76ceKTuE25IhNG87dHGGbwHIPNp0J8HKNk52i4hiDmLFT4QwCgBMF4Bz5yObxwNBFQxcmwm9/9HjAbkXfblf90g60F5a9uv2P9+CO9zhPiYpU3i59f5gc+3hrkuFNwDCjLJUFwo7HMutJSDdcHBmEIx/nwqVYn0wcNdhzeqXknRyH/NUW9PM5YtT5cqQU/iQGFbhajMKrqje/MiaFyFUNed9edComL54a+Cxz5AQjU0RDK/lxR8TYg7kifAvoTp+QoNGlNCfRHh4lQi2XNDFWEQkl/RdKZKACK5g/lov2mPubu3VfEd+KoKuYYF8YgdpDVrlVUmJ48L052zkjzVGfA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac09dcf-6d3b-4ded-3b0a-08db2a14fd1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 14:03:03.6721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4DJd6N7doCrs8V1Od0fcXJlQ2swrolL0nvpq6jae6hDMQ1X3f6aNBks66qIBWjdayJlAqnhp8mSewCCl7uEJvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6390
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_10,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210109
X-Proofpoint-ORIG-GUID: LzQEzWk5JEwPnonEq6W2jHVDJb56BLr5
X-Proofpoint-GUID: LzQEzWk5JEwPnonEq6W2jHVDJb56BLr5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 21, 2023, at 7:43 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2023-03-20 at 10:24 -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> This patch adds opportunitistic RPC-with-TLS to the Linux in-kernel
>> NFS server. If the client requests RPC-with-TLS and the user space
>> handshake agent is running, the server will set up a TLS session.
>>=20
>> There are no policy settings yet. For example, the server cannot
>> yet require the use of RPC-with-TLS to access its data.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> include/linux/sunrpc/svc_xprt.h |    5 ++
>> include/linux/sunrpc/svcsock.h  |    2 +
>> include/trace/events/sunrpc.h   |   16 ++++++-
>> net/sunrpc/svc_xprt.c           |    5 ++
>> net/sunrpc/svcauth_unix.c       |   11 ++++-
>> net/sunrpc/svcsock.c            |   91 +++++++++++++++++++++++++++++++++=
++++++
>> 6 files changed, 125 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_=
xprt.h
>> index 775368802762..867479204840 100644
>> --- a/include/linux/sunrpc/svc_xprt.h
>> +++ b/include/linux/sunrpc/svc_xprt.h
>> @@ -27,7 +27,7 @@ struct svc_xprt_ops {
>> 	void		(*xpo_detach)(struct svc_xprt *);
>> 	void		(*xpo_free)(struct svc_xprt *);
>> 	void		(*xpo_kill_temp_xprt)(struct svc_xprt *);
>> -	void		(*xpo_start_tls)(struct svc_xprt *);
>> +	void		(*xpo_handshake)(struct svc_xprt *xprt);
>> };
>>=20
>> struct svc_xprt_class {
>> @@ -70,6 +70,9 @@ struct svc_xprt {
>> #define XPT_LOCAL	12		/* connection from loopback interface */
>> #define XPT_KILL_TEMP   13		/* call xpo_kill_temp_xprt before closing */
>> #define XPT_CONG_CTRL	14		/* has congestion control */
>> +#define XPT_HANDSHAKE	15		/* xprt requests a handshake */
>> +#define XPT_TLS_SESSION	16		/* transport-layer security established */
>> +#define XPT_PEER_AUTH	17		/* peer has been authenticated */
>>=20
>> 	struct svc_serv		*xpt_server;	/* service for transport */
>> 	atomic_t    	    	xpt_reserved;	/* space on outq that is rsvd */
>> diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcso=
ck.h
>> index bcc555c7ae9c..1175e1c38bac 100644
>> --- a/include/linux/sunrpc/svcsock.h
>> +++ b/include/linux/sunrpc/svcsock.h
>> @@ -38,6 +38,8 @@ struct svc_sock {
>> 	/* Number of queued send requests */
>> 	atomic_t		sk_sendqlen;
>>=20
>> +	struct completion	sk_handshake_done;
>> +
>> 	struct page *		sk_pages[RPCSVC_MAXPAGES];	/* received data */
>> };
>>=20
>> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc=
.h
>> index cf286a0a17d0..2667a8db4811 100644
>> --- a/include/trace/events/sunrpc.h
>> +++ b/include/trace/events/sunrpc.h
>> @@ -1948,7 +1948,10 @@ TRACE_EVENT(svc_stats_latency,
>> 		{ BIT(XPT_CACHE_AUTH),		"CACHE_AUTH" },		\
>> 		{ BIT(XPT_LOCAL),		"LOCAL" },		\
>> 		{ BIT(XPT_KILL_TEMP),		"KILL_TEMP" },		\
>> -		{ BIT(XPT_CONG_CTRL),		"CONG_CTRL" })
>> +		{ BIT(XPT_CONG_CTRL),		"CONG_CTRL" },		\
>> +		{ BIT(XPT_HANDSHAKE),		"HANDSHAKE" },		\
>> +		{ BIT(XPT_TLS_SESSION),		"TLS_SESSION" },	\
>> +		{ BIT(XPT_PEER_AUTH),		"PEER_AUTH" })
>>=20
>> TRACE_EVENT(svc_xprt_create_err,
>> 	TP_PROTO(
>> @@ -2081,6 +2084,17 @@ DEFINE_SVC_XPRT_EVENT(close);
>> DEFINE_SVC_XPRT_EVENT(detach);
>> DEFINE_SVC_XPRT_EVENT(free);
>>=20
>> +#define DEFINE_SVC_TLS_EVENT(name) \
>> +	DEFINE_EVENT(svc_xprt_event, svc_tls_##name, \
>> +		TP_PROTO(const struct svc_xprt *xprt), \
>> +		TP_ARGS(xprt))
>> +
>> +DEFINE_SVC_TLS_EVENT(start);
>> +DEFINE_SVC_TLS_EVENT(upcall);
>> +DEFINE_SVC_TLS_EVENT(unavailable);
>> +DEFINE_SVC_TLS_EVENT(not_started);
>> +DEFINE_SVC_TLS_EVENT(timed_out);
>> +
>> TRACE_EVENT(svc_xprt_accept,
>> 	TP_PROTO(
>> 		const struct svc_xprt *xprt,
>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>> index ba629297da4e..b68c04dbf876 100644
>> --- a/net/sunrpc/svc_xprt.c
>> +++ b/net/sunrpc/svc_xprt.c
>> @@ -427,7 +427,7 @@ static bool svc_xprt_ready(struct svc_xprt *xprt)
>>=20
>> 	if (xpt_flags & BIT(XPT_BUSY))
>> 		return false;
>> -	if (xpt_flags & (BIT(XPT_CONN) | BIT(XPT_CLOSE)))
>> +	if (xpt_flags & (BIT(XPT_CONN) | BIT(XPT_CLOSE) | BIT(XPT_HANDSHAKE)))
>> 		return true;
>> 	if (xpt_flags & (BIT(XPT_DATA) | BIT(XPT_DEFERRED))) {
>> 		if (xprt->xpt_ops->xpo_has_wspace(xprt) &&
>> @@ -829,6 +829,9 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, s=
truct svc_xprt *xprt)
>> 			module_put(xprt->xpt_class->xcl_owner);
>> 		}
>> 		svc_xprt_received(xprt);
>> +	} else if (test_bit(XPT_HANDSHAKE, &xprt->xpt_flags)) {
>> +		xprt->xpt_ops->xpo_handshake(xprt);
>> +		svc_xprt_received(xprt);
>> 	} else if (svc_xprt_reserve_slot(rqstp, xprt)) {
>> 		/* XPT_DATA|XPT_DEFERRED case: */
>> 		dprintk("svc: server %p, pool %u, transport %p, inuse=3D%d\n",
>> diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
>> index 983c5891cb56..374995201df4 100644
>> --- a/net/sunrpc/svcauth_unix.c
>> +++ b/net/sunrpc/svcauth_unix.c
>> @@ -17,8 +17,9 @@
>> #include <net/ipv6.h>
>> #include <linux/kernel.h>
>> #include <linux/user_namespace.h>
>> -#define RPCDBG_FACILITY	RPCDBG_AUTH
>> +#include <trace/events/sunrpc.h>
>>=20
>> +#define RPCDBG_FACILITY	RPCDBG_AUTH
>>=20
>> #include "netns.h"
>>=20
>> @@ -823,6 +824,7 @@ svcauth_tls_accept(struct svc_rqst *rqstp)
>> {
>> 	struct xdr_stream *xdr =3D &rqstp->rq_arg_stream;
>> 	struct svc_cred	*cred =3D &rqstp->rq_cred;
>> +	struct svc_xprt *xprt =3D rqstp->rq_xprt;
>> 	u32 flavor, len;
>> 	void *body;
>> 	__be32 *p;
>> @@ -856,14 +858,19 @@ svcauth_tls_accept(struct svc_rqst *rqstp)
>> 	if (cred->cr_group_info =3D=3D NULL)
>> 		return SVC_CLOSE;
>>=20
>> -	if (rqstp->rq_xprt->xpt_ops->xpo_start_tls) {
>> +	if (xprt->xpt_ops->xpo_handshake) {
>> 		p =3D xdr_reserve_space(&rqstp->rq_res_stream, XDR_UNIT * 2 + 8);
>> 		if (!p)
>> 			return SVC_CLOSE;
>> +		trace_svc_tls_start(xprt);
>> 		*p++ =3D rpc_auth_null;
>> 		*p++ =3D cpu_to_be32(8);
>> 		memcpy(p, "STARTTLS", 8);
>> +
>> +		set_bit(XPT_HANDSHAKE, &xprt->xpt_flags);
>> +		svc_xprt_enqueue(xprt);
>> 	} else {
>> +		trace_svc_tls_unavailable(xprt);
>> 		if (xdr_stream_encode_opaque_auth(&rqstp->rq_res_stream,
>> 						  RPC_AUTH_NULL, NULL, 0) < 0)
>> 			return SVC_CLOSE;
>> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
>> index b6df73cb706a..16ba8d6ab20e 100644
>> --- a/net/sunrpc/svcsock.c
>> +++ b/net/sunrpc/svcsock.c
>> @@ -44,9 +44,11 @@
>> #include <net/tcp.h>
>> #include <net/tcp_states.h>
>> #include <net/tls.h>
>> +#include <net/handshake.h>
>> #include <linux/uaccess.h>
>> #include <linux/highmem.h>
>> #include <asm/ioctls.h>
>> +#include <linux/key.h>
>>=20
>> #include <linux/sunrpc/types.h>
>> #include <linux/sunrpc/clnt.h>
>> @@ -64,6 +66,7 @@
>>=20
>> #define RPCDBG_FACILITY	RPCDBG_SVCXPRT
>>=20
>> +#define SVC_HANDSHAKE_TO	(20U * HZ)
>>=20
>> static struct svc_sock *svc_setup_socket(struct svc_serv *, struct socke=
t *,
>> 					 int flags);
>> @@ -360,6 +363,8 @@ static void svc_data_ready(struct sock *sk)
>> 		rmb();
>> 		svsk->sk_odata(sk);
>> 		trace_svcsock_data_ready(&svsk->sk_xprt, 0);
>> +		if (test_bit(XPT_HANDSHAKE, &svsk->sk_xprt.xpt_flags))
>> +			return;
>> 		if (!test_and_set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags))
>> 			svc_xprt_enqueue(&svsk->sk_xprt);
>> 	}
>> @@ -397,6 +402,89 @@ static void svc_tcp_kill_temp_xprt(struct svc_xprt =
*xprt)
>> 	sock_no_linger(svsk->sk_sock->sk);
>> }
>>=20
>> +/**
>> + * svc_tcp_handshake_done - Handshake completion handler
>> + * @data: address of xprt to wake
>> + * @status: status of handshake
>> + * @peerid: serial number of key containing the remote peer's identity
>> + *
>> + * If a security policy is specified as an export option, we don't
>> + * have a specific export here to check. So we set a "TLS session
>> + * is present" flag on the xprt and let an upper layer enforce local
>> + * security policy.
>> + */
>> +static void svc_tcp_handshake_done(void *data, int status, key_serial_t=
 peerid)
>> +{
>> +	struct svc_xprt *xprt =3D data;
>> +	struct svc_sock *svsk =3D container_of(xprt, struct svc_sock, sk_xprt)=
;
>> +
>> +	if (!status) {
>> +		if (peerid !=3D TLS_NO_PEERID)
>> +			set_bit(XPT_PEER_AUTH, &xprt->xpt_flags);
>> +		set_bit(XPT_TLS_SESSION, &xprt->xpt_flags);
>> +	}
>> +	clear_bit(XPT_HANDSHAKE, &xprt->xpt_flags);
>> +	complete_all(&svsk->sk_handshake_done);
>> +}
>> +
>> +/**
>> + * svc_tcp_handshake - Perform a transport-layer security handshake
>> + * @xprt: connected transport endpoint
>> + *
>> + */
>> +static void svc_tcp_handshake(struct svc_xprt *xprt)
>> +{
>> +	struct svc_sock *svsk =3D container_of(xprt, struct svc_sock, sk_xprt)=
;
>> +	struct tls_handshake_args args =3D {
>> +		.ta_sock	=3D svsk->sk_sock,
>> +		.ta_done	=3D svc_tcp_handshake_done,
>> +		.ta_data	=3D xprt,
>> +	};
>> +	int ret;
>> +
>> +	trace_svc_tls_upcall(xprt);
>> +
>> +	clear_bit(XPT_TLS_SESSION, &xprt->xpt_flags);
>> +	init_completion(&svsk->sk_handshake_done);
>> +	smp_wmb();
>> +
>> +	ret =3D tls_server_hello_x509(&args, GFP_KERNEL);
>> +	if (ret) {
>> +		trace_svc_tls_not_started(xprt);
>> +		goto out_failed;
>> +	}
>> +
>> +	ret =3D wait_for_completion_interruptible_timeout(&svsk->sk_handshake_=
done,
>> +							SVC_HANDSHAKE_TO);
>=20
> Just curious: is this 20s timeout mandated by the spec?

The spec doesn't mandate a timeout. I simply wanted
to guarantee forward progress.


> It seems like a long time to block a kernel thread if so.

It's about the same as the client side timeout, fwiw.


> Do we need to be concerned
> with DoS attacks here? Could a client initiate handshakes and then stop
> communicating, forcing the server to tie up threads with these 20s
> waits?

I think a malicious client can do all kinds of similar things
already. Do you have a particular timeout value in mind, or
is there some other mechanism we can use to better bullet-
proof this aspect of the handshake? I'm open to suggestion.


>> +	if (ret <=3D 0) {
>> +		if (tls_handshake_cancel(svsk->sk_sock)) {
>> +			trace_svc_tls_timed_out(xprt);
>> +			goto out_close;
>> +		}
>> +	}
>> +
>> +	if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags)) {
>> +		trace_svc_tls_unavailable(xprt);
>> +		goto out_close;
>> +	}
>> +
>> +	/*
>> +	 * Mark the transport ready in case the remote sent RPC
>> +	 * traffic before the kernel received the handshake
>> +	 * completion downcall.
>> +	 */
>> +	set_bit(XPT_DATA, &xprt->xpt_flags);
>> +	svc_xprt_enqueue(xprt);
>> +	return;
>> +
>> +out_close:
>> +	set_bit(XPT_CLOSE, &xprt->xpt_flags);
>> +out_failed:
>> +	clear_bit(XPT_HANDSHAKE, &xprt->xpt_flags);
>> +	set_bit(XPT_DATA, &xprt->xpt_flags);
>> +	svc_xprt_enqueue(xprt);
>> +}
>> +
>> /*
>>  * See net/ipv6/ip_sockglue.c : ip_cmsg_recv_pktinfo
>>  */
>> @@ -1260,6 +1348,7 @@ static const struct svc_xprt_ops svc_tcp_ops =3D {
>> 	.xpo_has_wspace =3D svc_tcp_has_wspace,
>> 	.xpo_accept =3D svc_tcp_accept,
>> 	.xpo_kill_temp_xprt =3D svc_tcp_kill_temp_xprt,
>> +	.xpo_handshake =3D svc_tcp_handshake,
>> };
>>=20
>> static struct svc_xprt_class svc_tcp_class =3D {
>> @@ -1584,6 +1673,8 @@ static void svc_sock_free(struct svc_xprt *xprt)
>> {
>> 	struct svc_sock *svsk =3D container_of(xprt, struct svc_sock, sk_xprt);
>>=20
>> +	tls_handshake_cancel(svsk->sk_sock);
>> +
>> 	if (svsk->sk_sock->file)
>> 		sockfd_put(svsk->sk_sock);
>> 	else
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever


