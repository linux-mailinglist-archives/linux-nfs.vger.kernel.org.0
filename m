Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF9F5AFB74
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Sep 2022 06:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiIGE7B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Sep 2022 00:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIGE7A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Sep 2022 00:59:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C8790838
        for <linux-nfs@vger.kernel.org>; Tue,  6 Sep 2022 21:58:59 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2872xGiB022232;
        Wed, 7 Sep 2022 04:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vr9HrBHb3ZnI1kM+GwdJfkk2Hg2dVxt0SrjM0B6ia4Q=;
 b=iTzT7CMmBbVPofj+JTrHj2ejwo+FueXLEVOX5OL/a85xkhy541SSKQU3JGz582Z46Tmo
 V5RfK5WR6tn6Vw5XuKgBHP5UDmkq8pf6UzANoY05WsEjFcfKHreZY8L8EHOQ2/EiL89d
 DLr3lKHVjR/lLVhzoAhgYeVstqI6udaBA4ch5NRRCkcOiULRJA8cQVo5yhHHEglk817k
 77CRQHOQe2Q7/igrhBbIgB/Cxk7UgRv9tQhJNUIPnI5nlvcumtSMF9VNPQh9g06426Dc
 SiTVe6ajRqnRVU0fAF9qaTpyWX9D5QCv2q6aqT4VTsyr1bmeBq5onfFndEwV2r/IotHQ 7Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftqpw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 04:58:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2873jYqg039711;
        Wed, 7 Sep 2022 04:58:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwca2nb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 04:58:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRBZQx5wS28fb2tM3QOAjuTQICUOEmzmq+HHgctU90xf4/gdWmguaG20C/bKE0K34qExXbWl/lPfUD85JgRDV7PTkZ0aWybgglXovqSiUEhusySg4PFE0fa42iiMqCMjHU5m3cZFquuCWzOHKTFv5zprwyk/f8E3rgwXnLUblUPxLYGK0hXQyMjIwK3mvjFVONw19WDCwN8FnB0VYpPDYUgFWErnFVSFh4PYija3N6R6CF/ywsmDh14vG3+XZK54ucX7Kofn/vhzqlqrNYS7IzZLWJppRNwmOlzX5uLGLpQemt23G7Xg/Q9rPvK/prP4GElJNOLN0a0oEh5Jb/5U0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vr9HrBHb3ZnI1kM+GwdJfkk2Hg2dVxt0SrjM0B6ia4Q=;
 b=MUELcoDHl1ZU5dQ1oEaVj2Us0EXa8SAsnb5UCgXrWTbZ72bzo6etu+TtGs4uFWMSU9gFywglJp0f4VRx0+bODA2UA46J4Nti62mQ4XCD1hZRGg6a6toNyVd58LgMm9eqVWyKu1V8QvoUmHOe7e+EziM4IUw0OEqu55kScB/lOZ+sAbMHPLsX57PthenXp8MzZmoPD7bwTzW+QaLNBwaBPWemN1uZvWqnvw4OK9LvqyqXh0Yldg8guHY2nn1Acl5A8pFyFKgrEpfKjW7Kbo5oWegkbN7wMyuVbTEyMdMY3VK14H2VNNQbzV2HPJ2ZNghFwkvgIvGAFhIHy3l1J3wQaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vr9HrBHb3ZnI1kM+GwdJfkk2Hg2dVxt0SrjM0B6ia4Q=;
 b=fXUxr/43m7+BSUVEnpKbKetshP5vHKG/TCm1Fqq6nbObn0m8OuX8H4/eDg5Qfvsz5SFVZzQYd4tONMmiBKGgFH7vYLcgJrSOU/klp7mh05B/V7RmtbqDrkJdXAcEXr81XeimghMpyXz3e5Yf/sUkLE04I/zirsFey9r7qXzvkX0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5721.namprd10.prod.outlook.com (2603:10b6:510:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 7 Sep
 2022 04:58:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 04:58:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Is this nfsd kernel oops known?
Thread-Topic: Is this nfsd kernel oops known?
Thread-Index: AQHYvJP9R6JamLcYaUyLf/owehh7vq3HuG2AgALiPACAAGl2gIAAWREAgAdmpICAAAw8AIAAo8KA
Date:   Wed, 7 Sep 2022 04:58:37 +0000
Message-ID: <EE9C1D1C-AA5B-48BC-9E3A-8A4523456AEE@oracle.com>
References: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
 <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
 <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com>
 <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
 <D0A6E504-F2C2-4A5F-BC51-FD3D88A790F0@redhat.com>
 <CAN-5tyHYH7ODzmTK=Maa3NZOSxfcE0mfaWY11+n2htQpya869g@mail.gmail.com>
In-Reply-To: <CAN-5tyHYH7ODzmTK=Maa3NZOSxfcE0mfaWY11+n2htQpya869g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB5721:EE_
x-ms-office365-filtering-correlation-id: 62bd3a39-07f8-4938-743b-08da908d9ffc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E68dq5xBVHULon0i0Ax1S3azc+33gaz532bNA0tgAccazvR3Gep7VlRDQtmgLvQjLg4ZuEllCEghi6SHUFgYUQt9SxlGFY1Iyafj0302XU2q4wymNKb9sSbl3VSNa3Y1pU+f3OAAG08zVPHQ0qWTMdvNCP1TtWFmcsnfdlYJ3hZQo166bbPdR98NWMBgSK5ub8s8/QkCWIZZG245M0VBmJM05NDwNfHLtWLvlX7nVNNfB5r84vP0exJ3jfDALe4BtfzVXekktoUaLNXJbb6Vn1w4++rlEDnnF+sjFtj/koPOPqqOY2f3cq7MKy49gtHU7EeDH+5SDeH6Ega7M0WknuWa27aXhDxfOgwXV7f1Q0z8k/IZoGd+PCMpdGi3RArDw7DRVIi9Np0kMxTnBDen8sGabTaSQka9k/TmYLNApYUPyqT0u4iq/MdpvIxkd04d+mSB+AdqjeiefWgD7A7kN4WPzO//HKb89AKjC4gM6OThyeCAZzjb31tm+8GHXsycYdZSDedEQkYwxd9iqlToCtfO1nKdyYhPJrcmspbTD/ka3fDQ92/G+SvCnJfcGRv5UbqVGdrU+3tdDxeIuENJ+07raUvJBU4fx8XDE8JzaHV4dxRU25bqvZsy/cVVBFiaymPK7AHwxY7u+yABzs9Q1e2On/Md2O49R8Au+pSNPFwDKYV6tEaYqF39HXQa/DJdNeVjK7RpMls42oKCuvgcLfbYClvsGbqUHaCfLR4R5eOVFiwwnfu1Q7IG9UYrHCsYouYn/btrYfKDPXc23U8PXWIJTuKghVuxHEFFtzdCNhg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(39860400002)(366004)(376002)(478600001)(71200400001)(41300700001)(6506007)(26005)(6512007)(53546011)(66946007)(66556008)(66446008)(64756008)(38070700005)(66476007)(91956017)(76116006)(4744005)(2906002)(6916009)(316002)(33656002)(86362001)(36756003)(4326008)(54906003)(6486002)(122000001)(38100700002)(2616005)(186003)(5660300002)(8676002)(8936002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3qCO/FG241fLVkFT2jNCd/P4Kc0y3Z+oUVmuzOrS6ERPIvpbfJ4wzgTgaPpG?=
 =?us-ascii?Q?QRWYVnhDyc9MWouxEaHcG45IE8aVr9XGNGuPhJ7nsxr8NOrDuyKLrWzz84UZ?=
 =?us-ascii?Q?qHYR9r4WoVDjel8p7ebC2j7wxCzMHJxAifL5iG3pn4ITNEAW/nBN7Y0qNn1N?=
 =?us-ascii?Q?HvlwnDSXm6QSlPaAk5UM9TFbRdi/7Vzf6jOsMEKk/SOnFoeyNYFb1qtBQDeO?=
 =?us-ascii?Q?TQnb/296xHV49micQvCmM7WIk50AdoF50SMmwd8VbMzwvaXwJcq39YU175os?=
 =?us-ascii?Q?GJw3UOJoGFfPZXaL8xcJbcrqDFa7yzwCX2C6pcE66cdPA8hkutvedQIi2//r?=
 =?us-ascii?Q?cZsHSRSggNUjz8bLOMWlK+6b9FYBf4DZKsi5DDRumU/Qc9C/9kqmlTeVi8LW?=
 =?us-ascii?Q?fORNjen/NUiXNMdlmFHaQRGHce8fg3x7AlAeBvNBgNUHXC62q8g59m3zZmY9?=
 =?us-ascii?Q?aNTmg/EKYflmQ2T4BloGVESe7V4nXmLD1JZ/lbPjCC/PM4RV4LBnB6GjNQWE?=
 =?us-ascii?Q?K/BKSy+lS4Akf/e8tMC6fYyF5SGCW0Ajq+/8Bg2rPZcQlds9gSaUtPNNPAH8?=
 =?us-ascii?Q?1MJDYN0g44RTjDrVmXXW0j+zEjbWmrFsDknWIIJuL20bddlqsXbKWtI+J44n?=
 =?us-ascii?Q?YLGHOOwMOEuYDCHiQkJrqImz2eH/8XukwtORGfwoZWpIODf3n4YdCUsiOpqm?=
 =?us-ascii?Q?+f7PPC3wEITa5jtibhVPspj+Xpy++WDgQRfeSDQs12M3tLNm4gOL2fZP4atB?=
 =?us-ascii?Q?XP0NemX45h5U2D/SrZPGY3mAdYuIzGbGwJ2l9wlWRmfJq6qAOzz2IvovVoTg?=
 =?us-ascii?Q?8hS53jne2IlGWEly2wMHC1ykZf/595rI6LI9O7Dp347yDN0Zb1vuaR8VGwnq?=
 =?us-ascii?Q?saLNtv7cl8oWZWrn11xPUA25A5ygDXHNl5oLsP9SIC7LzhI8Vi6GA+tIpCwY?=
 =?us-ascii?Q?uOnxeJlCONyMsmn0NKHWu7DhqHn1A+SkOVBtinL1+cx9Hr2wEFQScLtgfOVz?=
 =?us-ascii?Q?Qr2XQoE16mj0xVExhA/GaA2tVGH4g3zkKDXy6itdYIDS/nW5qZkL1WPqMArq?=
 =?us-ascii?Q?w7ABUnrKn3wxZPac6RN3PeirdaOCII4T576Cy2HoFwY4pF9SKvPQ92BfDVZd?=
 =?us-ascii?Q?wHaDRn2GVWZsYMSgrqtOtlJ6cxtYLuOiBu10JrMWFmd9bSxA//pDHXO7wmxz?=
 =?us-ascii?Q?PsMqtRYpiW7UaERIkT6DMeo2DF5Zr0mrlUTwV0SEvU0090xHo31e77mCK1X8?=
 =?us-ascii?Q?gcZs4aoZGXVYZiWvKuOLP+asmYw2TxLD5c9Z1pl+UBDr1mOQx0TA+5f13bd6?=
 =?us-ascii?Q?hHcPqD6FbuelbXx1kNQZ1Gu4fvMvI8c+DwyTdmZgxng2bSuhoPXj9zIEvS+x?=
 =?us-ascii?Q?h2sCJe4Dzn3B912FBQlBRDcxZZXU7TRWdebic34/9JXHKpYlSzgNSgMD42x3?=
 =?us-ascii?Q?QjDtAcus8SFaeeHJ2ksQ8JE3LSO/N3P/4ghnVTh2Va7D9ULeg2knEQ8+0aIb?=
 =?us-ascii?Q?XNojfKkuvJ3K7dyZAvsq93znJgxR5BHqiqDexGkzYyAD2E05+VgMtCHJ/KQM?=
 =?us-ascii?Q?FCTEXBYGLMT3TX2snJU+5mT+D4C8EV3psqbH7y4zVqdGFLSyqz9/CUUI/9ob?=
 =?us-ascii?Q?dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <67240BA796B0DE4994754A511B1CE907@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bd3a39-07f8-4938-743b-08da908d9ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 04:58:37.4788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ri/gQehtaAPr/mFs/yh1FiC5vfAllbgfTEHS8ZqznyOI00mCaX3UB3HPdrE4y2y9fJ8+yK/LckRoLH4+42J12Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5721
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_02,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209070019
X-Proofpoint-ORIG-GUID: _huwIaMfwxUpfU6cFWx-L3qQRuPRYUVD
X-Proofpoint-GUID: _huwIaMfwxUpfU6cFWx-L3qQRuPRYUVD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 6, 2022, at 3:12 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Tue, Sep 6, 2022 at 2:28 PM Benjamin Coddington <bcodding@redhat.com> =
wrote:
>>=20
>> On 1 Sep 2022, at 21:27, Olga Kornievskaia wrote:
>>=20
>>> Thanks Chuck. I first, based on a hunch, narrowed down that it's
>>> coming from Al Viro's merge commit. Then I git bisected his 32patches
>>> to the following commit f0f6b614f83dbae99d283b7b12ab5dd2e04df979
>>=20
>> No crash for me after reverting f0f6b614f83dbae99d283b7b12ab5dd2e04df979=
.
>=20
> I second that. No crash after a revert here.

I bisected the new xfstests failures to the same commit:

f0f6b614f83dbae99d283b7b12ab5dd2e04df979 is the first bad commit
commit f0f6b614f83dbae99d283b7b12ab5dd2e04df979
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu Jun 23 17:21:37 2022 -0400

    copy_page_to_iter(): don't split high-order page in case of ITER_PIPE
   =20
    ... just shove it into one pipe_buffer.
   =20
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

 lib/iov_iter.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)


--
Chuck Lever



