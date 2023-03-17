Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D546BF06A
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 19:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCQSIj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 14:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCQSIi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 14:08:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8DE23C5E
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 11:08:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HHteOX032396;
        Fri, 17 Mar 2023 18:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wEYhhI/Bv7VYoymgWxuI9yaH0A66Hcz7NPyriKzM6Y8=;
 b=XiP4d6/VhqPjCaKwzRcsRVM8wqWrH9/03gs1lLffL1OIKSduqXPWUVh2KxNBtCj79Fch
 CjFRpCE2dRSGiNDv/qiosozzW55K6QXwPOWbag5pO4WZQ1sbsFNtD3hzE3nd/0mBzQpX
 TjfevGCCxN5eeGi971f6Ho0Dxnetqdxrqd0rIZzSwg2Zd6P1NU7QrbSvtehUCBYL9UOM
 FVY081/k151dUxClEiF9IRGc/Is+VIvVqShyOdJexfN/EKv4yF3gJT1aKThwZdT/GI7w
 cIuiB64adyC4zc51wtPP8UiyJ6ibIu4Lb70uMNOkygtRIgt7r2rlYaBFekNOYuyLPyqa sA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs29vdqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 18:08:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HHDFAT020647;
        Fri, 17 Mar 2023 18:08:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq46m9tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 18:08:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvEMx0xLGkEti35JHX0fN9WFfMsKmMzJ8AdKOzvtyjjBNt6JydT7blZrnm/skKQO4QxBAv+BeY2+FZKEFj1fswMayDPBsLzMokvAAYjA0TGciEPym8VkNGyVL3vXJQdZ1KJRP3BxJ+5rWhGdCTQq39uuF2T1h6dwdKV83Le/k/1I7qrKeja2YfzVqBGYYPLl7fYL3JQiNg0YVZD0B3oal0O//ucmkO10ACjuWiq69LeHwUHrcNtsXWT7RmrdgF7vENLAZgMweMxufCa9OEOKAEurgajaT3aCcqQGTUaSR6QmGiljqwmVQq0HXHZp3fyK+3iG2XSh0h8PBGxNVeqeuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEYhhI/Bv7VYoymgWxuI9yaH0A66Hcz7NPyriKzM6Y8=;
 b=fByo8H8hOSXRvvMh2ZBKPCgm2u0bihwYUnLksGLsqqnmx3tFarZO95njgPWTKwnh6vI8oDB4m3K1AHiF+LkOUVIVTDaSnn0UxEOznTaaeeJJMDqGHgTW9d/EIXVA51G3C0Jws07/cXXdlZFszG1KyDF7CZntzz+5f0IFO/VtZSLP+MPUXafCNzxmd8Fc/Ab3EWsIxHUsbzwHNs7LhXW4RXpM13yEKoiSVnNCKK1s+DAsHGavXs/5hFRamDmUQdMD37NrG6aAt7vRLL3hgpt1tsjGCYazZyLa7IjZ4350uwUTYpuiWmW9WW3HSNV1ON/iYc9ee2T3T5ozm8wdfcwm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEYhhI/Bv7VYoymgWxuI9yaH0A66Hcz7NPyriKzM6Y8=;
 b=EhCfchQ2CBxpmhmYrT5wCePMshH34Vu0am5fMDA7nd89Vy7Ur3co85MkS2DIROVDUrwDsy4qhdRwgUjzfXEld0amAQRG2RhDVupF330+eLljVdGsLGo5et7m7EgTJsZtAtoZzsqi49TGi3kRt0r8CYjwi7tcyo2L1OPehE3M7fw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5681.namprd10.prod.outlook.com (2603:10b6:510:146::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 18:08:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 18:08:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "dcritch@redhat.com" <dcritch@redhat.com>,
        "d.lesca@solinos.it" <d.lesca@solinos.it>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 2/2] sunrpc: add bounds checking to
 svc_rqst_replace_page
Thread-Topic: [PATCH v2 2/2] sunrpc: add bounds checking to
 svc_rqst_replace_page
Thread-Index: AQHZWPPHhxprfvZio0CVZD7mRL0pxa7/QGmAgAADkYCAAAD6gA==
Date:   Fri, 17 Mar 2023 18:08:10 +0000
Message-ID: <F6CE9F70-628B-44D3-A8B1-D4EEBBA28B87@oracle.com>
References: <20230317171309.73607-1-jlayton@kernel.org>
 <20230317171309.73607-2-jlayton@kernel.org>
 <6F8F3C24-A043-443A-BBB7-E4788FBE29C9@oracle.com>
 <827d46876b57bec309164d4c9513bac523ad5843.camel@kernel.org>
In-Reply-To: <827d46876b57bec309164d4c9513bac523ad5843.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5681:EE_
x-ms-office365-filtering-correlation-id: d997285e-4e46-4abb-57e0-08db271291a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 52b+kYl8kLnpTxmZ8clZZ+N9Ql37/ViQARHN8Lio/9pkWUtCMtuzYe+XIb4ztI6WjpLO/GAPltAxHXstieBqWpYKt/xJz58F2g6/Zt4jgEolJ8yqzE6esFrotkLXwvrkgdr9nXKBYOjdiRDtr5fqgo5vYBukuiFjmxU3NmG16pEfqoHxOZcI5mErymRlsR6bq+Ga8uSar3aGlqMnY6zLR3pG20FqmFMYYw7COOzJWI+EbkKja8IiA66JbWTHaVKhnscjbw3rB3ygj/PkDDvl/9lKoDsMGKidRvWpq3D1+oTXHghR+85+m+Z+FnXzCsXZIDmwmUIxM1MCpA9KpZWvm2Wzx0fa5yxAbeBBlON0IQJm8wlLZNGAwDwmA8dsNegOIhMroNC6vht3Qs3w7Jtiy2PQV70eqcLjA2XB8y0yKdRp+Sp+UDllyiPqjuW5v2P47OsMMRptSvBaoE7OH0tyIkcXeQMCa2j0YNSsGJ8ZuUJhCNPVugoN0k1nOJqV9Mj0OtaWRHNescq0XXq0Ke/DOEnAYo7hIbQrt3RTO5ZsqaKWbL23iP4nsbmjdMyoTBBvxHPvuJxlCZ8CQHAh71kLRtsUcg8B+SjtTOhfDidO+Fb+rQKUmYfUedZTtIjeWgljwTM3qCqUum5L4sbzGBsCNer4vJzuMQ/9zIWrIG1p32wdKdZlccGEN9B4960oowVSoivcJEJKHJfOmc9CUE/CNWq5G2wjDPiGtxrOoj3JtIg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199018)(71200400001)(2616005)(186003)(6486002)(83380400001)(478600001)(316002)(66446008)(66556008)(66476007)(64756008)(8676002)(66946007)(6512007)(26005)(6506007)(76116006)(91956017)(54906003)(53546011)(41300700001)(6916009)(4326008)(8936002)(5660300002)(122000001)(38100700002)(2906002)(86362001)(38070700005)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wg9C97i476Q9hZ8Y3LD3nnNt/f10YzjWr85/Vo9ssIabJGE9tFTY3/pjhwwr?=
 =?us-ascii?Q?cwV7JbkLS47jizTk6Z2CxR1LX5e7wI5I6ePZRVJgXzWlsM+CpNSCzRxTmBdh?=
 =?us-ascii?Q?NtE510LHzSa53M3NZzXZM259lnvi7eszWGmqQna3STyYynxHT0JdOwTOk2Jb?=
 =?us-ascii?Q?Jgely/z9l9o7lB6OVJGljhRkJ8IR377uHoFiIg3PP1Eib+YiqeH8ChteLd+g?=
 =?us-ascii?Q?N0TUmpaI86yS7Il/5G6SA22xe/sq+RAEzt0a9LyuANaYyGX3XeWp9opVTkMN?=
 =?us-ascii?Q?9ZSCspIvQhEvQlRARVAvU0zscO5x4KqfTdmdmqzR/tkxC8l2AYj1vuxLO2Ap?=
 =?us-ascii?Q?ZYOVxLu49WsElzZ3CtZUngT6vzm1cF8KEpv2FpT3/EqAi7SiEGN8ZjY8QsYO?=
 =?us-ascii?Q?Ify56ojGa9vuFjiCKWIZYAhKlTQURDvU8R2A16MkHnhBzZrFMlPILC7bbT8Z?=
 =?us-ascii?Q?qmeaBp7oeP3YwLJnzQhjlM5rk6aT+Lk+WmD/3UWXOiNUiVmXb2fpJ/Z0q7Q0?=
 =?us-ascii?Q?Loif/nZm2+hUqRCt64nFF2Z8hNjSo7ioNYH7/IoTyXlYH4fi5upEeaULlMCi?=
 =?us-ascii?Q?X4kn9erUpQLvCY5ZBAzWQHljS7XVPHx6EFroh+3TePLV1FK0ur3CbsVfbbJt?=
 =?us-ascii?Q?LdejvJmMW1uPWu+/NKM09tXM+IG86wO+7J7/fcb/ot3KXalTxBUFEBjuN5zV?=
 =?us-ascii?Q?ud3Zrc9oPf16tri8lhjAfhI/3HZeRSCaJbHZVfj5u5cU9hxmZEmMK39lk8GU?=
 =?us-ascii?Q?tZG7OOf63u3ZWlOFvOqmcajq/2ZcJ+0fP/+wW9Nli6e3o7WCdUKh0RW0Itgt?=
 =?us-ascii?Q?2T4ZI9FHzghFUISVjhaXWqHj5jqSPMcjzCyM9hOIqOTB2bwgB39cW1qDWoaC?=
 =?us-ascii?Q?8yQE9H2hw5UKmFbBsO4IE16Zfvl2zz6x+ueiMRSJfpIeox/lmDdyo6tqrD1P?=
 =?us-ascii?Q?cnK5pBFu1lI+bPFMbmsFon4PcKXQc+YRJPQo+/3efFN871cG9NGETQY82IFm?=
 =?us-ascii?Q?Q1yhfi4pyduTfyJuYa7vrUrMDPsJ2fyaGrsYRPalc5oevOdEHJwPgoXVuJNh?=
 =?us-ascii?Q?zJUwMN7qCb/On8Ke2UJ+AuysbZg4vpwVhOXhyicoAvs8lHB4zAQ5ltgc0ls5?=
 =?us-ascii?Q?K0fv0NJfysuR+Fpjpvo1kUc6WSmWUJXeCiCHaBiqsUl7owm2p3t5Q7JRXD+1?=
 =?us-ascii?Q?sCiN0lX1pX/H89J3+stjDtqQqJUMLgG7baJAPsj7Hoyv1w23Muk0wsVuZ1aZ?=
 =?us-ascii?Q?ei7zr51UpNHFqo7seTNBtyEQQxC/srbCo2QjLRm/gno6zhg28lEmUl/U5snn?=
 =?us-ascii?Q?rLz4lp5EdNfvgIOCVy0+Ni0IysRenr4IMETASR3TYJ3zYW7IDvOxpgjZnAvB?=
 =?us-ascii?Q?cMZCaeAwN7Ma8HO9Rzx7rEXKO5KPS2gZTMWahbglqLOm8aLZW48NiH97y4Oi?=
 =?us-ascii?Q?pmOxAXM61uVmguusFTToP/8HXElovu4eQ+/eOAf4X02C/RSQO0f7A1eDNoAI?=
 =?us-ascii?Q?Cg9fT+5num9Xp0mH5KqTZmWJiZJDBOCBi/Jd+H+g7sfJTnOksffmp/OpN8kq?=
 =?us-ascii?Q?F+Z676QRRmM8Q5B+KI5UN9S5qMMLfI8xmY9lAtJURhIhsasXlKPtRiDar5Cf?=
 =?us-ascii?Q?dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F7FF87A21C55654C9D3B051FF0CEE5A0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GYd1aCBbKJgseE6tUjYUyWY+I+p7VxCb6R0C/FHRaCUhDZp+Yd8jydI9S0PpJIpiXnO2R2pkzjG3SKrg9WeYoZsZhxRATSVylG56uVwllOHQUyULYbBny7nCztm8PyIEd/1dyGEFCLXEPn+AmSlxqe+/D2Jg9u9oRl0Dwd+RnpndA/Ucwo0aRrS7d+UO5rGyRNL1jBUjZMiEV4Z8ES92t3Tr8cEFpBQa6JbDeG6FvAqv2j5KJgiy/twCT0t9hMwmtHKC3CfKuAdCqzmVbbni6xjEYyspbqv1KO2uif8aj6zn5nPtgEx9gt9YxUup+2+5kTYjJievZ+NESlZlp/S3cqk3NKqF2uMtNgEZlhX1DeuPJQeCZ3WpMigm2OK7zHqPq0SH8+Rpj7NIJP4kG01lP7YpnXw13PcCEv8yR5L+1wjFSe2WkK10ptaT5RvMGgNdJiRTc/KdbzNvINFK+/NGErKSkHey9d6gwGHbPTeqn2IcfPHdXJkU7Yv/bbyMlu9wYGkbZGnnEfcwQGrhr2GfFJV2AwZMhJRQd4HpuUAqb0kZFCVzvNPOfjpQuxJjbM0RH2z6aHyn0mGwmNSB3uzJ4YjZdricqlq6V6wUyPmaan6fCa/xnfOp7Mc0nsZtNEsgN8Ez/qk1Gp+bIO3w+c1Ya4+SW/d+z+BwgnDCFrl7MjxPT5s4G4/WgHIzKdfkIXQq7hVUr5h/dOzoHfHWl3LS47uy6L7ew9BOSr42Rq+c5begpwgFehPervtU82/frpE2JFiPcqanmv04+8PAayR4ekuN/wJtWa9273qYV4vmA30upr+0GhIyPRV/jmd3/IrwDIMqWY7a6xAOd91rxN4CeoddX82yK6Iz/n9X2J/qC5B9+s2jkg2FGDVxvz2vhMSW8CRQtsqa7zGv8r9FSkJb+A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d997285e-4e46-4abb-57e0-08db271291a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 18:08:10.8818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wo+n3hYMgCe/OW6mEpMOifWwsxgZTuE73med3IC2qCTbSFXzaJdJPVccQ5f/q3EkcpvTO1nyxAhLxRnZkHjwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5681
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_14,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170123
X-Proofpoint-GUID: cX7NHLhR2T6vNs1DIStSF9nbsJAZxS3J
X-Proofpoint-ORIG-GUID: cX7NHLhR2T6vNs1DIStSF9nbsJAZxS3J
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 17, 2023, at 2:04 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2023-03-17 at 17:51 +0000, Chuck Lever III wrote:
>>> On Mar 17, 2023, at 1:13 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> If rq_next_page ends up pointing outside the array, then we can
>>> corrupt
>>> memory when we go to change its value. Ensure that it hasn't strayed
>>> outside the array, and have svc_rqst_replace_page return -EIO
>>> without
>>> changing anything if it has.
>>>=20
>>> Fix up nfsd_splice_actor (the only caller) to handle this case by
>>> either
>>> returning an error or a short splice when this happens.
>>=20
>> IMO it's not worth the extra complexity to return a short splice.
>> This is a "should never happen" scenario in a hot I/O path. Let's
>> keep this code as simple as possible, and use unlikely() for the
>> error cases in both nfsd_splice_actor and svc_rqst_replace_page().
>>=20
>=20
> Are there any issues with just returning an error even though we have
> successfully spliced some of the data into the buffer? I guess the
> caller will just see an EIO or whatever instead of the short read in
> that case?

NFSv4 READ is probably going to truncate the XDR buffer. I'm not
sure NFSv3 is so clever, so you should test it.


>> Also, since "nfsd_splice_actor ... [is] the only caller", a WARN_ON
>> stack trace is not adding value. I still think a tracepoint is more
>> appropriate. I suggest:
>>=20
>>   trace_svc_replace_page_err(rqst);
>=20
> Ok, I can look at adding a conditional tracepoint.

I thought about that: it doesn't help much, since you have to
explicitly test anyway to see whether to return an error.


>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> fs/nfsd/vfs.c              | 23 +++++++++++++++++------
>>> include/linux/sunrpc/svc.h |  2 +-
>>> net/sunrpc/svc.c           | 14 +++++++++++++-
>>> 3 files changed, 31 insertions(+), 8 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>> index 97b38b47c563..0ebd7a65a9f0 100644
>>> --- a/fs/nfsd/vfs.c
>>> +++ b/fs/nfsd/vfs.c
>>> @@ -939,6 +939,7 @@ nfsd_splice_actor(struct pipe_inode_info *pipe,
>>> struct pipe_buffer *buf,
>>> 	struct page *page =3D buf->page;	// may be a compound one
>>> 	unsigned offset =3D buf->offset;
>>> 	struct page *last_page;
>>> +	int ret =3D 0, consumed =3D 0;
>>>=20
>>> 	last_page =3D page + (offset + sd->len - 1) / PAGE_SIZE;
>>> 	for (page +=3D offset / PAGE_SIZE; page <=3D last_page; page++)
>>> {
>>> @@ -946,13 +947,23 @@ nfsd_splice_actor(struct pipe_inode_info
>>> *pipe, struct pipe_buffer *buf,
>>> 		 * Skip page replacement when extending the
>>> contents
>>> 		 * of the current page.
>>> 		 */
>>> -		if (page !=3D *(rqstp->rq_next_page - 1))
>>> -			svc_rqst_replace_page(rqstp, page);
>>> +		if (page !=3D *(rqstp->rq_next_page - 1)) {
>>> +			ret =3D svc_rqst_replace_page(rqstp, page);
>>> +			if (ret)
>>> +				break;
>>> +		}
>>> +		consumed +=3D min_t(int,
>>> +				  PAGE_SIZE -
>>> offset_in_page(offset),
>>> +				  sd->len - consumed);
>>> +		offset =3D 0;
>>> 	}
>>> -	if (rqstp->rq_res.page_len =3D=3D 0)	// first call
>>> -		rqstp->rq_res.page_base =3D offset % PAGE_SIZE;
>>> -	rqstp->rq_res.page_len +=3D sd->len;
>>> -	return sd->len;
>>> +	if (consumed) {
>>> +		if (rqstp->rq_res.page_len =3D=3D 0)	// first
>>> call
>>> +			rqstp->rq_res.page_base =3D offset %
>>> PAGE_SIZE;
>>> +		rqstp->rq_res.page_len +=3D consumed;
>>> +		return consumed;
>>> +	}
>>> +	return ret;
>>> }
>>>=20
>>> static int nfsd_direct_splice_actor(struct pipe_inode_info *pipe,
>>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>>> index 877891536c2f..9ea52f143f49 100644
>>> --- a/include/linux/sunrpc/svc.h
>>> +++ b/include/linux/sunrpc/svc.h
>>> @@ -422,7 +422,7 @@ struct svc_serv *svc_create(struct svc_program
>>> *, unsigned int,
>>> 			    int (*threadfn)(void *data));
>>> struct svc_rqst *svc_rqst_alloc(struct svc_serv *serv,
>>> 					struct svc_pool *pool, int
>>> node);
>>> -void		   svc_rqst_replace_page(struct svc_rqst *rqstp,
>>> +int		   svc_rqst_replace_page(struct svc_rqst *rqstp,
>>> 					 struct page *page);
>>> void		   svc_rqst_free(struct svc_rqst *);
>>> void		   svc_exit_thread(struct svc_rqst *);
>>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>>> index fea7ce8fba14..d624c02f09be 100644
>>> --- a/net/sunrpc/svc.c
>>> +++ b/net/sunrpc/svc.c
>>> @@ -843,8 +843,19 @@ EXPORT_SYMBOL_GPL(svc_set_num_threads);
>>>  * When replacing a page in rq_pages, batch the release of the
>>>  * replaced pages to avoid hammering the page allocator.
>>>  */
>>> -void svc_rqst_replace_page(struct svc_rqst *rqstp, struct page
>>> *page)
>>> +int svc_rqst_replace_page(struct svc_rqst *rqstp, struct page
>>> *page)
>>> {
>>> +	struct page **begin, **end;
>>> +
>>> +	/*
>>> +	 * Bounds check: make sure rq_next_page points into the
>>> rq_respages
>>> +	 * part of the array.
>>> +	 */
>>> +	begin =3D rqstp->rq_pages;
>>> +	end =3D &rqstp->rq_pages[RPCSVC_MAXPAGES];
>>> +	if (WARN_ON_ONCE(rqstp->rq_next_page < begin || rqstp-
>>>> rq_next_page > end))
>>> +		return -EIO;
>>> +
>>> 	if (*rqstp->rq_next_page) {
>>> 		if (!pagevec_space(&rqstp->rq_pvec))
>>> 			__pagevec_release(&rqstp->rq_pvec);
>>> @@ -853,6 +864,7 @@ void svc_rqst_replace_page(struct svc_rqst
>>> *rqstp, struct page *page)
>>>=20
>>> 	get_page(page);
>>> 	*(rqstp->rq_next_page++) =3D page;
>>> +	return 0;
>>> }
>>> EXPORT_SYMBOL_GPL(svc_rqst_replace_page);
>>>=20
>>> --=20
>>> 2.39.2
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever


