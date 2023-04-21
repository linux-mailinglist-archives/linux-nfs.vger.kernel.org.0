Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378B46EABB9
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Apr 2023 15:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjDUNdN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Apr 2023 09:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjDUNdL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Apr 2023 09:33:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D3B72AB
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 06:33:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33LCYYo9006655;
        Fri, 21 Apr 2023 13:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=IC5JL54e1GKUzIRBjFWq/S4zi0y2r0KLGNmJrqw2kf8=;
 b=IahVII38+rjzo6iJqr6tiUN7gd1tAvHBoWH9P5JPNcWKBMt2Bq4RUFR+5UBa5QZDHQWb
 hCrE5FFNHVKKAaekM23Ic/WKM/VTGZJZ/3OSwiB1E1TebgdFurnrzwKh7HMtxREz56lF
 MJ/i9WWQjG6VS/9AWmQxWPRPIyjxQxDeQrjIy8Qjd1snm88AfJdo1azTEtd5PJTJxC/E
 hOtzpc5yVzjOH2jhCfehsCvQIYX0XTcFx5HlMpqrPAC5UimWuWRD9ZvcPK/iIQlMwTTh
 OEFyZshxQSj4XeqIIiewFYsgGO/QFWUWat7Jy7XDjrxG5NtsH4Z0QLEl2tHG76WaRWff CQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykhu59af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Apr 2023 13:33:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33LCMdDZ037901;
        Fri, 21 Apr 2023 13:33:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc9mdkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Apr 2023 13:33:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNkOiVlgctEsdqKkyjZUIip+FTctiMIR2b0Dj9GuVpstsQKq7gi+GpDlQqgU1TKI88Njau0J6XcY8SPxgs0PY6DRp1SA4XcWPq+CfHSmg/HZf0rdDlm38kuxeVOP8aclwEbnWlrEkYQAcoaSzFTc8FpKHxuVULjgQt0eWHxF9f+zHfRe12TuI+27WzjN+JUib1APumAcwaS9uW6WzddejSGAA0h8kbu5LAgFX2EATBuyxSIRTvITT7Ry3EYFK8k+cJAeD21I9AfMPzyEvxbGcGX9v6SldP7JxQkNR7I5DTJF7qXI2aZDM/g0XzjKMjI2eNz6NeImnUULYHJkxqzqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IC5JL54e1GKUzIRBjFWq/S4zi0y2r0KLGNmJrqw2kf8=;
 b=SbbdEdWQ13SINMCLrBMrFpDe9AmfGpCdzNkfpUue4rzyFhp1y0hQPKqU/F4jb8hKSSWKK/KUUDnrSKZ4ek/whB4QcZFUr4ei7rFG5ii8xy7TmVUj+KvBjRsF9r1X/YcVG5uEUGNmKncGBusUwa8/rdWV3ghgeSM8yZRNF5KI/h2xkCUu2CuGmbsXfZICXPQdSWmhq3RlbuFq0qAUDVVaHvUai3jtQDu+PdpGHK/L01ot/JOyFZEyKm1H0WBfeRSOLKVY/c1wCokxP7htzwxeKSUge6FdYhyEuLf/w+OkNAteP1KPXz1ixYKfxoWZcI7zvi8EwlA0Ekv1vYtHYNm+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IC5JL54e1GKUzIRBjFWq/S4zi0y2r0KLGNmJrqw2kf8=;
 b=lwjnCMvaTaLO5k2db2Hix8gxl6P8g33h67oHU8idx4qzBd4avJskWqKANDVy43BA9jjLbvYEfrfqf28M8KywNx8RiVOXkuPVZ316AvR/DbvzkShqLETfS8y5fDCCnByACgZJhHbxk0mnePwp46Le6qKniXUiToim1DVaJ3uu6tg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5876.namprd10.prod.outlook.com (2603:10b6:303:190::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 13:32:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 13:32:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>
Subject: Re: Fedora packages for ktls testing available
Thread-Topic: Fedora packages for ktls testing available
Thread-Index: AQHZc6OTDRi68AaSH0OhYEiif9AHcq81xD6A
Date:   Fri, 21 Apr 2023 13:32:58 +0000
Message-ID: <2CFA4DB8-7EAD-46CB-970F-67CD5FCF9D36@oracle.com>
References: <85ee133945a9f816ffb9612146a6f835c6d443ec.camel@redhat.com>
In-Reply-To: <85ee133945a9f816ffb9612146a6f835c6d443ec.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW5PR10MB5876:EE_
x-ms-office365-filtering-correlation-id: d0ee6a05-a1b7-4469-6d57-08db426cebb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A3eQCcVyrOAMFweYkHB352h6fndHvjYto7hPwFDMujzWKHaYv+rOecRmW/3GMv7NhsLQoO2ikD/wFktr7EdajCd1dR2i/zWKJ+qWPKf8mzEAgADDs+bx2GVOCP9ea4FV7y4VrTfLk2y8+wrd2c7p4oNItU/GyS1PZuK2xrpWLJI9lq5wO96F4fCZbFZyh5XayYngdri8vxmuM79mA7J1lX6O6uTQOd5HDX/exdwRMI42fbsDKNopmOdJy+GWkf/dwSkr/DBBFy5IrbbGphJKV35xp0Z99EuiQXUN4ri9BmO3HLjlDklx00IyAj2QxL/CbDUNlsvp0rWxHTVTZYdrtKsRjhZWdL8/dipWR6jt006VXIzx25Emf6d6WPWz766nO7q4vUyUFS6wW01/8v86/KWdNgLyRqdlpAAR+tLz+Rjpbd5TyF5Y9ZDyV40F4VG2fo0jea1HD+GON83m8GNjNyfcq3Wor7rqIrhKX8U/EB7I45oHAmf8QL2jEGDQNy7o0Ql0zvb+Bpq4mDoTH4b97hNYYihsKleluHFsxQQdCOVz33l4gUWZ9SNKYpCaXZJ2V7btetkpu7uhr3APLMECJE0z6wxBcLxJtQPFmjUDDs9uMlwj387jJalhvkmtOrhE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199021)(966005)(186003)(54906003)(53546011)(6486002)(71200400001)(86362001)(6512007)(26005)(6506007)(2616005)(478600001)(6916009)(4326008)(83380400001)(64756008)(66946007)(66476007)(76116006)(66556008)(66446008)(91956017)(316002)(41300700001)(122000001)(5660300002)(8676002)(2906002)(4744005)(38070700005)(8936002)(38100700002)(36756003)(33656002)(486264002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VFFXksH6CDPeZ7GaRnBcTnC43/bZ9skwk1ISqs7drq2sqjCvKKkccY4o/5AB?=
 =?us-ascii?Q?A1w0SUmoSs86Bff5oZ0ttfZd9wgwwzk9gluZgx8rr5w+O0ugC3t4riXDqZ2C?=
 =?us-ascii?Q?xwA2/YVI2Fr3tkdQZ21Aq3EtjAXL2fSqnK0jc2jYSszUm9dE/htnaLLeYhW8?=
 =?us-ascii?Q?P7kF/yRenFRuxoGy83f/XaMEmPcq+qtqICg/Qd22alIeCMg9iMu2Fz+OJkeu?=
 =?us-ascii?Q?F0xQvoRf/LYxFZ49aLGL3dtGxW8CK/w+PfCXfYv/8+iyaHfWgGcF/Yxers7n?=
 =?us-ascii?Q?tE9/3ldU1tZMRGi1FyrTDT4TGTW1HTRwNZcOnSJAXrRpY77o5Pdj5+CsiSuH?=
 =?us-ascii?Q?T5E0kXmyoFhJmywj6kZ4VDKaenEYYOe3rd+8vPtED35sqJbOCmzZhew2EoTQ?=
 =?us-ascii?Q?WOwtV3O4fuEx08Ug+FS2GygUF/y6Ho6524zP4CEjd6amDmHHMPh7UQzHLknX?=
 =?us-ascii?Q?yqZPDm9EnWUdwnEzmCUGFiV1JDjCEwKb1QQ9sUgR7RlfGdm4bNPLEw2LdYi8?=
 =?us-ascii?Q?ln3hHRJw8QwVAQJpgogNa0ll6LwafQoDQ1sBB5QBn51StsXPqQD1dCrYUuzo?=
 =?us-ascii?Q?kPp936ikY8mYlS2JT4Y3z2nS+FVqKfD+ZuTeMsHioh7hY8s/Xr6VlErQdo/D?=
 =?us-ascii?Q?ZsChAZXyHodpEMjNeJ3dWQOTJJhTy9UuHtEXZ7MCFvnKymwpoZvirAuSoeTK?=
 =?us-ascii?Q?NzQCCtRDl9c1WY7RX01RZRb37i7Ki8cAb0nVX81fUBB2Fi+D3vNy9QwovSwQ?=
 =?us-ascii?Q?hNEmDeF7XF564CuWmcTlk59j6HaUSW67962uzxUe5tl/HZyBGJmWoQIBCvys?=
 =?us-ascii?Q?lU4g/vzVzp5j/6RGQcOpc12D908Vc0rOi0nge3lMhGnn9RdpXp+lQyRPUWjG?=
 =?us-ascii?Q?OmF1KL5zMVdyqFFEgYArz+QlgEU4zak9RIRNC4GQZO2zdPSNKcBE0fbFeHsR?=
 =?us-ascii?Q?b2In0bHDBXbnAfdIzLtRDqv6PkEoW6mlP5LAZmiAE9ItJ3/3Uz1x7j2zkleR?=
 =?us-ascii?Q?O/FDwyHC1FNpUzS5J8lHjhkk9Jp909HI3l8WJaoZyUuOWkUItE+CtAGc6PvV?=
 =?us-ascii?Q?ktoq6yRrXH7hBQ8VEsvMNdOqRue9mF3mBArtX717bb32nwCwfIa7dH3HVgzc?=
 =?us-ascii?Q?0G/EmtFeG9sAYAWqDRDlOMgRVMoIHMTImhteSU3/EioF+2ralxrbfwZnN6u1?=
 =?us-ascii?Q?zUUVKI3i0lDj1IQ/gdaNnKVpJj/j98htvT996nrqGbFl+3B3LMPdaHAx4o6b?=
 =?us-ascii?Q?Wt3RqdwDXKoFJQJTQJsbfP+YIT81r7q5+wc7DRcw5DW7RiAIi7XbN8WTY1az?=
 =?us-ascii?Q?8ZGoX/skeOeBAr88o/FRgSNjMvjtSdUFG/Kvz+FuDX56hgEKZmKLNjr0zFyt?=
 =?us-ascii?Q?xQTNCeG7BBjWRdYkJ4l5pEOZUTmMDrlsTCqVOX2D+3DgmV3xKvdAsx5Qt/cx?=
 =?us-ascii?Q?X1gDJ8ywDXqKASqflw3BK8rGGFmoiLSPKDNzT3z/hLuyC9DyEv6Cc+m2K06p?=
 =?us-ascii?Q?8VNbhGwSpNv0ntVgKTPQGLYl6iQOFt15fSJpyPTq7HCR5D/ea+rSVZOwjJXI?=
 =?us-ascii?Q?DYpSZyWSlsrLnk9YrT+veeqL68ALmlLrZjiRBhtZZzi/MASmBGFfTQ4naUbY?=
 =?us-ascii?Q?2Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D2CE03C44F4A6849AF480B38CD383768@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: B035dFhn2UumbemWR6DPRAc889qoOVcOL2swWYY6xZmKWHkbbqolFg+TRY12hfm85y1z0bWyiU8TReBwLjGy2psVgWY/saOQ+7IqNz4gNYPjlJx0C/D4idh6ZB+QY6Thj2CBKi8DOtioHB7kSz7rEMCn2Mn+frX8mmzRm5t5uuyUnZ+Y8KLQa9juEdrw6RhlhVpJaY077UapxhuviAhYrWt7BI40FsAmW0UTM5gWOg5mjtDzpVABWVaiDua6k3XLH7Lhc72CU1prYSxO+V5dnf7pUp6rZd1+5zpYwkguvEwcck22cVBkjYHHayC1/KUaOcwmOzfv3V4Jb/XZUxG6CmShhnCCsjax9Ya/KAo6PdZLn7CEv5uRtTM33L1ACBVKYMwV/ITfTLbWtuGR+TBWJIFld8PBKksSIfn7mAUS8MSHTI00Jfy+kbj2aOH/vQoNt9ON2637BgSrPIddmQWaw8XXg6sujgikK4Od8JcR0YsGQQfqDs7XGZxe/Yed0TMCbjKEI1CTlenLAOutozhfvNw746o6+Cl1jquiZVjfwIC5Oxb2g5MsSjtJgChsprlKsdRXR+YCFYoFI731N6mcTWk5t0zRIZxueyBT3ju7Mb2jwHGzC4FE8zdPV7VeNm7vUpFEHDI5/3TgRL2vNr0OnwOvTSCZwVZoOXyPyOSLGozcHvmEpDDh2f3xJaO4LiRpxV9XA6qEhZe4k/0+34Oystlkt85kYlHwtJ0vWZ/vr31rLQte2EelIA5K4LG2tRLoy1scYSYTPgHoTe0AQYK0pxA0jJ+8yU7E9Py+Vm1d+/qInflpYHYD0V3AyOJp1V+ByIItycW5Tq+jwqglonu9ug==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ee6a05-a1b7-4469-6d57-08db426cebb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 13:32:58.0961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EcLMCLQ0dyuxbt0e5hHZcTuy28gAyUCxcx7h1+r6UsTThnuX+nyROj9kFhfv4p57jlwlEjTwbAsWoIgz2ebGzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_06,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210118
X-Proofpoint-GUID: _FEB3ERc31FbrKBRD6R1PeZl2TL9nxP7
X-Proofpoint-ORIG-GUID: _FEB3ERc31FbrKBRD6R1PeZl2TL9nxP7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 20, 2023, at 12:17 PM, Jeff Layton <jlayton@redhat.com> wrote:
>=20
> I have a Fedora COPR repo set up with the latest RPC with TLS bits from
> Chuck:
>=20
>    https://copr.fedorainfracloud.org/coprs/jlayton/rpctls/
>=20
> It has a kernel package (currently based on v6.3-rc7), an updated nfs-
> utils package (only needed by the NFS server), and a new ktls-utils
> package (0.8 based currently) that I'm working to get into the main
> Fedora repos after the kernel patches are merged.
>=20
> My goal is to keep this up to date until the relevant code starts
> landing in the main Fedora repos.

Hi Jeff-

Excellent work!

I've had questions about building ktls-utils so I'm interested in
your experience packaging it.

On Fedora, folks have installed keyutils-lib and keyutils-lib-devel
but ./configure still reports:

  Package 'libkeyutils', required by 'virtual:world', not found

Did you encounter this issue, and if so, how did you resolve it?

--
Chuck Lever


