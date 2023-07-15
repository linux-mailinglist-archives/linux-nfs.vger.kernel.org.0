Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F96F754B8E
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jul 2023 20:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjGOS4Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 Jul 2023 14:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjGOS4D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 15 Jul 2023 14:56:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391723A8C
        for <linux-nfs@vger.kernel.org>; Sat, 15 Jul 2023 11:55:31 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36FISMXh004738;
        Sat, 15 Jul 2023 18:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=qnrbxkEyPnP7gJSSoXPietgiH1+aaxjPaxYVuwLv3ds=;
 b=waSOPoSkU37U8SeBqSm0lexhdhtzrT72R5W6Qx5CUVTbcC9FV0Qxfl/Iqk8AjlONm/mG
 Bx/f7qzUwUxKOqjAm6yjfsmeBgSNdY/0d7a7ogRVcu97YDcophKxqqVnuN1GEVze/08E
 7c3cIoffLkVFMWQsRIQXqPrUEyKXadxu6N0W43HWRZptlCbj8TDOjUzLigV4V+OGvxOa
 lhhVojrUYYZNYrwH/MM9ESuAHeDvtYYH/zaeTggHm+AjVqS+bQPy8VPh+eFOXr2yKxox
 ijhRxllhNBq/h7/ncM51xDiEFJLwZn9AynXsYGRgRolixOv3bR5dyJKXw7TZjq+iFvSr MA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run76rm4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Jul 2023 18:54:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36FEjblR019258;
        Sat, 15 Jul 2023 18:54:01 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw27w0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Jul 2023 18:54:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPh0pkZE215YoU+9uR3HMZ7J2Os/Cm5TI4BJCmaMShQCoKx4QyvQFS2ncx8IP5MAksrdCkwdfrbb5R7maE3HL5s2+edSq5TMtH8ngq/m1DHlL+Bj6WBRmgH+MVMi4Jm1q3xryLcZMcuR2o57Zi3UQEBn7HceYSTacw7mC6ctd3kSZugMzFbXsf3anBysgZOKMLrX7xUNJyoRZUIPXntBw0TM2rIdN7N8SIRW6BUtgYJtLOs5xsNdvJFyswM0rzFGU2XW7an7F+RmGupSnbj0XyeJ+oBZI07CUXAeRSd2Vbl2u6h6r6xrduHpShfdabiXp99GQPnH3VnMEHQJFLUrlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnrbxkEyPnP7gJSSoXPietgiH1+aaxjPaxYVuwLv3ds=;
 b=VDDAFXVqGEMemIlddL16zvSszCoy2GIDyQPj7A8rVda7FtDJXevp9bT/G3RWZqWYulV4VPo9UT2szkonZfq3JRMTkboIkcvd9f25YlJmlspBofcmyMH5FwhEn/s3Y2SMYVbRmnsQk7IM9n/XJO8uAQvnMSIaOqsQ7yJp9SmZnBK+nvvRKHhQ/iOjswfssB/rMpeZu234tTnGXvUdJdJsc61dwAE9lmARLUWa1bUXjgCsNZcFvBhh8TnwpHVBWG5UKglUbGiiPs42AURjtsDFRGgBFioAlkcRLA839OD/F626wFEWIiJgwpR6MSOONnlcNTDm/UNkHqIYnnKCwCxojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnrbxkEyPnP7gJSSoXPietgiH1+aaxjPaxYVuwLv3ds=;
 b=uPQ8GF72EZ1eIqHWCEaUzk1QBKr1NH1hWz37Sp1OJzmk/Nky4eIGVBw9cp67+zDR6mZaEVk2lqN1eMUWeC/GENtygfku5JhKmpZ5GpzDJ5BQMq1StP+odDqux4mVbNSoc4jeQDUpvGRC0IMURqzq60+V7kEbbZ/ov61KSN6FdGk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ1PR10MB5978.namprd10.prod.outlook.com (2603:10b6:a03:45f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Sat, 15 Jul
 2023 18:53:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7%3]) with mapi id 15.20.6588.031; Sat, 15 Jul 2023
 18:53:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steve Dickson <SteveD@redhat.com>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-tls-handshake@lists.linux.dev" 
        <kernel-tls-handshake@lists.linux.dev>
Subject: Re: [PATCH v1] nfs(5): Document the new "xprtsec=" mount option
Thread-Topic: [PATCH v1] nfs(5): Document the new "xprtsec=" mount option
Thread-Index: AQHZtoIX9SlT9BlsY0uswhwwu22SDq+7IXmAgAAM4YA=
Date:   Sat, 15 Jul 2023 18:53:57 +0000
Message-ID: <697F49D8-938A-426D-A4DF-8077247AE90E@oracle.com>
References: <168935977873.1850.8214830433103692090.stgit@bazille.1015granger.net>
 <a6e861a1-1609-11fc-219c-88dd8d90b526@redhat.com>
In-Reply-To: <a6e861a1-1609-11fc-219c-88dd8d90b526@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ1PR10MB5978:EE_
x-ms-office365-filtering-correlation-id: bd6ca372-71de-4044-7493-08db8564d852
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wDg8bEyomEEwqBjI2XrwtDlRaBdzZHY/7DBc8fdy48ZR3khz0f1l45kiVQe4BuaZoit9bOMoawzjzTsQI6tocmwyxc+6v+KPTmWPeSAgPVBqoiRXJa+8s4zz/8OjNzyKJ5+ap4DvrM88PD9GYw/W5g7OdDCkVrckEac4cgzlc5s2KXmucajsyFSHGu1sfYbd2Jlr3Isv4FmAy5o9cxf5Ev74xCbRAywWlSXGHKj+xh/DyPBjD9Ws0j4g68GWV+7aTXDCh/q866uFd4pxl0CL3WTNH/1N5zk3LJIGRWdqzCFojzMk1Zt4rO74ZHpgq/MPNKPwnbH5mlalYRN8k83FvYM5Jkp5kkLmxLTG78ZNB4sVHk+60S+jpC4u8BVoKx6sxbEKoU+O0a87277N0Md/R9glM6T3Zz2MDY1zexOmHzFJPDFKgSlnVrQdetMia5P8IyxuPMnLZPxFEk15OshMX5GXKpUvthw5Yf8XMaVySEkImI3SFwRW/775c67CHP5qUOKrv4/jBcAh5n+WXX+PL8O8iICOxgBFuju88853Rqux/P9E0fZofuvuW2efNPxMXmI+uwOjmzMJy/h6/8p4ygU0WJqq8NXUjlFch5vtQzXwZbzvI9gcyzlOjAVCAVQRYvFG6Nl47LtrH877G/gK5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199021)(2906002)(54906003)(478600001)(6486002)(71200400001)(36756003)(8936002)(91956017)(41300700001)(316002)(6916009)(64756008)(66556008)(66946007)(76116006)(4326008)(66476007)(66446008)(83380400001)(186003)(38100700002)(122000001)(86362001)(53546011)(5660300002)(33656002)(8676002)(6512007)(38070700005)(26005)(2616005)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u1JIcWwNpejRu0isGpsWWMU0WHR0SJreOibPoIX974J7yhmxMhaNQAbfKPJz?=
 =?us-ascii?Q?Hk/2P4gIfLNQfYVGgVv6Z3KApndOiJPEVCRDwJwKpXs3w2CYd5GnyDeb8hrP?=
 =?us-ascii?Q?CvJskJBvJZV91eO/OxCi6aG9MuIUADGfq2RxKhtzh/qwGTlPvueawkSKrwCA?=
 =?us-ascii?Q?EOOyFuBsDBYkXfoKgr9dmn+Oz5j/AnrdSjjxRf2/0nAjjNMIgU2qs+YSKlbt?=
 =?us-ascii?Q?x4aYcadm0P98+04uP4tMbtYLUfSr0L9SA2BIROtn6eShnOB3jma7EjC1lB4g?=
 =?us-ascii?Q?qvu+ef4x3jB2Kjmsw+e02GDgFXpbwDyo04UdNBwlaS91Kul6dn2yc+5n/QK7?=
 =?us-ascii?Q?YYFULKA1D67ORSTGeQHRvg5ktkLdPnG1f/H4GUGewBTNV5Jfn5EuU2Tg1heo?=
 =?us-ascii?Q?yzX2gfoHszAkgBQ8LiKppXepSEij6teRGXPdfJk/8hmpMis8uIuUDJbLAR9J?=
 =?us-ascii?Q?GEUosMMRfi/yJsWXM9P8yG00ypuDhhvUOS5Er5OnKhJueQVvX0LcjXF6Tovs?=
 =?us-ascii?Q?l5dSkPcc2d9v/DD3YSk654li4vx5msiqLlGsc80xxpaAGjTl+txXtGCasQ15?=
 =?us-ascii?Q?FklbjKN5c4VnGHtPfxK9K+W8nHdkmYIEdoRzOjcbJgoiBIReKn7UO/gDMotS?=
 =?us-ascii?Q?PhFRPbD7JXo7VC+76H4UO7HyNCphpQLny+Of1Iy4e6Bgv5fAmAr4jYlusecs?=
 =?us-ascii?Q?0fLUN3n/j8kXkvSryC+rpqEXjNFyQKGREJCwm8DQVpnBvX5/mQSNIEpcNL0Y?=
 =?us-ascii?Q?6QARRnCZ+4TEWfQS2+29MPl3DvPxn2sldsH7aDnKENJNjnVB7wZCftzadDHF?=
 =?us-ascii?Q?9cfsLE9ro3+zTVj+qomTMUlSB1D6C8ka6Z0YMbt/PHOlJJTsdR3Hy2ehu+ak?=
 =?us-ascii?Q?hszV5mlfh3gAwxVza+LgmEwtMQ58GoL2HJiF0dLIH3c3b6BtYfEDxJQ6gZ+v?=
 =?us-ascii?Q?B2uT/b9tX0leP0yd7sdrp1DNTt0qxYcxKRNS6XgFse05GRL6sDqicSFq1AJ4?=
 =?us-ascii?Q?ufAnQF2SBxNRUChOdNcYP/Ks+UjoX4pqeGru9dFwOpAVbAtG/zRYbDsB5VpJ?=
 =?us-ascii?Q?/Ao1LH9Xt/CndBkRMBoVqBCNis5PCnZq0q5ym5yOARLU/TwmklnD7mgHVjju?=
 =?us-ascii?Q?muJfOTFyqXGk7b5JfjcYbvFO8NCA5xgMlLMGH7/6fepf1kryKk+usAyK4KDk?=
 =?us-ascii?Q?Topy1KBdjip0hap9UCbX00JLlLgbB7cY2Nn7ilxVf7oHOPQuKyBrcn2I5nWH?=
 =?us-ascii?Q?YUvWZ8udCq03HgufkstdcujHtVnxLUGV2q5qigarvP4DUIo99eC1VRcQECsO?=
 =?us-ascii?Q?a2c4OjuvmXrtG+R7NN9z8uUWsrKhrjJtWOqFZu0ijmzkKehPN4k5DVzKh1Nd?=
 =?us-ascii?Q?KBrxpK04pFp8UrjvJ630YsoBJVmN3YeN8cN5gWp/NtxzkBRqrtEH2vnlEh2I?=
 =?us-ascii?Q?DWfK0t1gHlpoU+n5E2sF+E6f2vujwuiUwe2chxHuljveRrVOEWNCtOaICOhE?=
 =?us-ascii?Q?J30WoDf+cvsH7XkEGsgWsPdMvSefrsR1FSl4VH6S42zgcWYQUOEFMovXCo5i?=
 =?us-ascii?Q?FTn6HP6LDDqy3EeByDA05i5PxAEUxo4jSt9YsuLTAxDK87kb+UHiAhAekPev?=
 =?us-ascii?Q?KA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BA90B11314504F49882E1D3AC2FC6B25@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YXVHd1VQDkx2Xg3eBnv8iO0ZtuhvbPJAtFe0h7lQeGdTM8hRfcj4k8Qt4vlRraMbbhKxua4Kknt/+aH6pN2yruOup1O0uj1mJx7jQmOBL0+4J4WW5cN8cK2pI/xQgq3iAzIGQykPPRrL9EQoNpcLIIOl2zRwnVIJSARZMLYYFrQVDhAKBc1bJPY1uEDpK2QI6Zoqzj0LtmquH7gAJD9W5KOKSNyv6m6vn1HjfKQYghMVjanQhZdjaCCRtnpgsW9pELsPoq2FaHAFCyRtPjk4jHs7sHLbbCSThYSQ818qBkLGQ2cYwzB5JzysqbOiZbprZo+eg124djKO3YjsoFGvG3pypSoUdsqF44q/dmtFxxce6eThSmF4gOBvzOKCmJ4zUaik9y4DM5+ixBRjT8wT6zJpcwvAaz1sVlwroS7IHcH6qGuim/2l+zPRvaNJnJbxM4RRmxCt4G9BkgeULsT/9TNyzivwuIAPuiGgD2qqrY/QrdIjpIneckQ2gkQw8DTWeN37KGY+ind1QLf4+BXIsn5x1nK6NkaZynxK/qB2sQrot38WrHfCcw0pBqfHPosuPItLHTK4ZAiuDr5r4uxUsz754ET2+opwe8M0IgYbTV8O71pvtk+4UqWRutFWirxsmlK9xVQbVoq+giZkmuspwurkSaiBORraE6pjNp4DX6FStRGxek6H2asN1F2/q5Q1UKZqa9R+h+XH0wXsRrObdZF+VSYqe3bWtm0l2E1UG/X0oJJfE4XBcUvXnFeJ3ojiDeM+cm93uJcuj7yVwyrF01xCJbzrcNII2z3CQumAAn64EAkH1el4e/YbGPNw07Q4lMLJE1N7hT1Sm9LAjSnU8J2G/cARAQHtQBXFmdxb25s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6ca372-71de-4044-7493-08db8564d852
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2023 18:53:57.5416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yzGIoiiSlV3Fj6qxIZVXWo7RDlM2rSTozVr0urwjp+iXQOr2GB0JI4wHUa0xEsu7EYA1tEW3y9pp41IGPZW1BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-15_08,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307150180
X-Proofpoint-GUID: OSPV0uK2SeGcmuiNK991qL4Ucye_nuEw
X-Proofpoint-ORIG-GUID: OSPV0uK2SeGcmuiNK991qL4Ucye_nuEw
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 15, 2023, at 2:07 PM, Steve Dickson <SteveD@redhat.com> wrote:
>=20
> Hey!
>=20
> On 7/14/23 2:36 PM, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> More information about RPC-with-TLS and some brief set-up guidance
>> are to be provided in a separate man page in Section 7.
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Question: commit b5e4539f already add this RPC-with-TLS
> update to the man page. So do you want me to revert b5e4539f
> and replace it with this patch?

Hrm, I didn't remember sending you a client-side man page update.
I thought I was waiting for the in-kernel parts of the client
TLS work to land, which they've done now in v6.5-rc.

If it's no trouble, go ahead and replace that one.


> steved.
>=20
>> ---
>>  utils/mount/nfs.man |   38 +++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 37 insertions(+), 1 deletion(-)
>> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
>> index d9f34df36b42..dfc31a5dad26 100644
>> --- a/utils/mount/nfs.man
>> +++ b/utils/mount/nfs.man
>> @@ -574,7 +574,43 @@ The
>>  .B sloppy
>>  option is an alternative to specifying
>>  .BR mount.nfs " -s " option.
>> -
>> +.TP 1.5i
>> +.BI xprtsec=3D policy
>> +Specifies the use of transport layer security to protect NFS network
>> +traffic on behalf of this mount point.
>> +.I policy
>> +can be one of
>> +.BR none ,
>> +.BR tls ,
>> +or
>> +.BR mtls .
>> +.IP
>> +If
>> +.B none
>> +is specified,
>> +transport layer security is forced off, even if the NFS server supports
>> +transport layer security.
>> +If
>> +.B tls
>> +is specified, the client uses RPC-with-TLS to provide in-transit
>> +confidentiality.
>> +If
>> +.B mtls
>> +is specified, the client uses RPC-with-TLS to authenticate itself and
>> +to provide in-transit confidentiality.
>> +If either
>> +.B tls
>> +or
>> +.B mtls
>> +is specified and the server does not support RPC-with-TLS or peer
>> +authentication fails, the mount attempt fails.
>> +.IP
>> +If the
>> +.B xprtsec=3D
>> +option is not specified,
>> +the default behavior depends on the kernel version,
>> +but is usually equivalent to
>> +.BR "xprtsec=3Dnone" .
>>  .SS "Options for NFS versions 2 and 3 only"
>>  Use these options, along with the options in the above subsection,
>>  for NFS versions 2 and 3 only.
>=20
>=20

--
Chuck Lever


