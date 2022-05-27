Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3B2536749
	for <lists+linux-nfs@lfdr.de>; Fri, 27 May 2022 20:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348129AbiE0S7y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 May 2022 14:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344647AbiE0S7x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 May 2022 14:59:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679B691587
        for <linux-nfs@vger.kernel.org>; Fri, 27 May 2022 11:59:52 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RG9r15006285;
        Fri, 27 May 2022 18:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hn/8dg8KhfA4syc54AzwrKHtCqLUvB2DKUpUdT1HLZM=;
 b=IE/YjKkfRGZGqbvfn128ttUGk1Rz3lIoFtQN3Oo+1/rak8Cvm9tKFHjLQf5OUHwwgmFK
 +ttnQHNP3tQf/StQb+uecnxbQlUWYdUw6VtU8m2DxMib8WhP/7+VgfHQksGv7AyLVmcB
 0oZJ13h4QH5EYHm5nysPbpAYPAzuTce2+IPX42xlBW2TKmtIF2ZXGu2K37pyk6w1/FlT
 8yh8f5Y28moLNPKqfVyMs3yV3RxQ9FReVEWc9YudgmZaPABn/FGJE9xducaWtTxayZXh
 7hdl4ygK885kP7Rk0ITTy210/xQ5lFqFpeW+UkAyX1+Mqn5HSdfD5GFGkJuNnP/69SnZ qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tc82v0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 18:59:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24RIuTxD012329;
        Fri, 27 May 2022 18:59:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93x7yebs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 18:59:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eqqi7CzvCNiAlatjya0Guzuw7Y5QKlQNQpB4BxcrZqpC7HsiA9/lAIoQx1aZRk2IEKGN+55z0iS2u5uBMdZvdQuY0z9B1pkaSGoGLvD/ygRHvgyGBtMjOVKuLwmNOgrjSztR8BCuJAZkQUKV5TBSOojUrinr35fa0E/z5d/26pzIuZCmr9v9x8MjnVsKJQdbIb3s6QZxJwawjDA7hqSQNLYhmP7zqv569/6+mu+ggCUO078MnBkyQePJ0ydrsx7kt/6mfaqIF82y7EObH5VXVi07e3RKdx9ct8ivHjwcS+34lEq8r1xXPaR0Rzu2NZo0yKO6WkqcLk4Ke/PxLaTtWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hn/8dg8KhfA4syc54AzwrKHtCqLUvB2DKUpUdT1HLZM=;
 b=Nsyan1Wg29uiSyGo4O/Q8sC7AkexWMyxrBIOlWj5Sgjhsvd+FJZaXdgenPhIpBAmZc/j4pGgCQn6LjnY5Ot/HS/GcUZ+Ss1iYufobaiL7jJL17FUf8Q3r9FTH3J/VuPP7iPdzVS7cud/sPcfH130Tz3slNh3k85/JrPLBbA4TQP+nHrVJ1LUKRoi+s8CYvq4DP66LuWGaLP65uOTAwbQzgyHeW0JWC4/ZH3vQgFQzidt1B3yBDgkdbTWj46I/eXPwJlSFmM6Wf7uq0Io5iXg5Zxeu6j4LdANrYnDJzSCQvWiDKy0O4BCiolHl3AbMAtC0V6f0rtYypaOvQ7TCIhjOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hn/8dg8KhfA4syc54AzwrKHtCqLUvB2DKUpUdT1HLZM=;
 b=Fg/Hopo6ohjpmrKshjdrlUAqv5OJIOIYoVISmg+xomo3GGdMZ7UbnBD2yKq4FYIW3C+rB1UicASNqF6KDcLz3p6pYPMazs2fwFUnunu+bNwOiSvJ4KYo7LzbljzN2c/7jSgj4H9PJqwBVoo6nJvVw0TPvbiGbZmpJnqZM2XCmxM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MWHPR10MB1869.namprd10.prod.outlook.com (2603:10b6:300:111::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Fri, 27 May
 2022 18:59:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5293.016; Fri, 27 May 2022
 18:59:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "fllinden@amazon.com" <fllinden@amazon.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: filecache LRU performance regression
Thread-Topic: filecache LRU performance regression
Thread-Index: AQHYcfvvz95XBFD9XEq+YMeEhqQtsA==
Date:   Fri, 27 May 2022 18:59:47 +0000
Message-ID: <5C7024DA-A792-4091-BFDE-CEED59BC1B69@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f3970bd-f61c-46d0-47a5-08da40131203
x-ms-traffictypediagnostic: MWHPR10MB1869:EE_
x-microsoft-antispam-prvs: <MWHPR10MB186971660F953BD50E5A31A293D89@MWHPR10MB1869.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3i0XrbjYMdOmagm/UhFYOxnqmxa4YAh6ji7Dby42nxLmxMyv5l0VQdcsthRat63s6hkCiBb6MeWnrIHJE3Y6w1FKmv6JAN/+idhymDo6H8pL400eUcBewm+NQEspYUf+OLqK4BxqQ0XHGY+p/lZkba+zoWJj/51srg0km6tszh6Y6jv6GV4aK3HKCe2jReC44xVeNSfGHIiHGxFpjzS8kqYoLPUicYMT3Mz9uYiOuRUEnvUnQngp6pzmtmaDKpe6w5SURiN2XAHMxVcnGU2S7dMBZNkf8xor3AGSlQ0rn+JZAzMN05iVRFcOouCDp0J4Hv58NFn2b3YpI//M87fjC4939y44mrSqHbBEro0R2XZ/bnwdM+CM0ar/j9Up7fdS1masg76L5lhZFYoqtbLiQecRashFVkz11PbkqdbIo5Mjxo5Cw8mC2SZaEHmm1EP23TvYwPpE6Pgtr9DgFmXPfH55YqSydD+h1Bh9S56MjGA3Q4CmYykIC5qAgN36VOnHIbzlDIks8fPWB6t7nMJlAjs8sb+DQm9kxzhn0/cewxIxSSqPmkN0OZQ4h1F2/at3cyCILXKwmAkbEYVYdtwB8VE5DnWHcAG+IL7VshjvTDvfeJ3J3SLSvh2c3hrkj4aJpbCHlYSSIrVVDmlrNT0abmAHM89K5ve8yg9W3oVDHjFkiG00fXYSsRiM/NadOyPjCMzDo+Ilq1M/4sXd/ptRQ8aLdkU4HNHBOuZ5ok7kmIaIqf9tNLiwdO/v1kMjixjc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(316002)(6916009)(26005)(8676002)(66476007)(86362001)(66946007)(66446008)(3480700007)(5660300002)(66556008)(4326008)(91956017)(76116006)(38100700002)(6506007)(64756008)(38070700005)(508600001)(36756003)(122000001)(6512007)(2906002)(186003)(6486002)(558084003)(83380400001)(8936002)(71200400001)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PvRV8sBAhzCge3VEJhWH8GRfcKft1PtCunog2hlYJYFHZgskPS9lLTskxqgy?=
 =?us-ascii?Q?vFnxrCGxBftoA6tdGTHPMu81lG4xAbIPe1N9pNIgU9yyaK0bmqIlu/FLj1/U?=
 =?us-ascii?Q?cgqJM5QIGijGp3oZvb8Ua7a2QZloCbhNSj57Be0+PKJuu6lfpW/GSbrxlFx1?=
 =?us-ascii?Q?7e98R0TmLAZVnO80HjG7QXGIzWUFe6FXLqKZFPMbFKT0ZnanI2GGfFl0c1Oh?=
 =?us-ascii?Q?LUnDJ4475NBG8sLkwShKTXD9PdJbTSnK3szp0ePnAXR3ee5w1FKQ6GbLkNic?=
 =?us-ascii?Q?SckSunVQdUj8rmm6tUNTtNLxdVK4Ki+ZkW9GxyYIT2Vxw0tPKLvF0ogdYwMd?=
 =?us-ascii?Q?KzrPfU475qHV0HjR/65Oi8iOPyeJ0QOv+ztzhq77wqU6nxvegT8FDhAuQhAS?=
 =?us-ascii?Q?vGUR8uJJSKN7qkSpBQtz7+COV48e2F+v3jDHXlUmQ0Xg1AgK/Je1pj9doKgK?=
 =?us-ascii?Q?kuxEgoLwSzCayWugCVHwIL94bj/0FBP5+aeThB3UR7bUsrhGWSxpDNSPmlPI?=
 =?us-ascii?Q?m1KcRtkSlmhnGgWJAjtCBBFgdHuxsJw0HwXBxRS84LWVoVfOKzCeAsJKtMHV?=
 =?us-ascii?Q?WEn9sNiWKRLHprLRmk1XiPMKp9HAyxYRiQ9d+BSFspS5KnWcdYGAkenYSJhG?=
 =?us-ascii?Q?GWF3cItqSCFKXYDCg1KVYJkfSrCA7L8NFmn6qBuBqkcYm2W4Ei7YYGBw3yl8?=
 =?us-ascii?Q?ZE97bBWt3TiVzF1t0F/Iu4ndiMS4ulpL/recM+DiGNn2mkdZugxCAK9VkBpo?=
 =?us-ascii?Q?tRXdV1E4bBxsCM1r0qdmhmSSu77o4w/cpr9aXen2ByobeTt35+yGz/SpZlcQ?=
 =?us-ascii?Q?PaeXyPHC7tZ1ArMOk3tkPhqddlIks2Aa5hbMYOTWT+qH7dh/57AraRkWAyNZ?=
 =?us-ascii?Q?Wyb6NoqfAisbwm+n4BzHEmn4BalYS2fV2Jjnf+WMLuDEXYyPjKkXqXnm98E0?=
 =?us-ascii?Q?8wDchRPUpqZSNV76v+axBz6LKsBcGlki4kzSrXxqszIb2tMwURlsgPf3E2BX?=
 =?us-ascii?Q?JfoFIH9ZF+iX6z20R6AHsMx1WJfvrRAgxzcnHGfVUOkrY629K9JQZbfloCFr?=
 =?us-ascii?Q?Gc5mAIzMrjZ0nP1txR/rSMpZXS8o6THzJIlEjSyUmBFGmN8qXSOAVtnN+Zh2?=
 =?us-ascii?Q?oOn7kA70GqoJwhsNb7uSsiu+HuPHeqeLzzJ2msBtqQ7LPOkMI1djhX0WsEQT?=
 =?us-ascii?Q?nYW9zeCD+UhxT/BsgceFU1xM2+AMoM6AdFAZJ4Kr38TOOf+IC2KtvuOmmxtw?=
 =?us-ascii?Q?PPf8W800mOiI8Cn7ddTE3237+cNk1Gm5z45dmyiaKdo6yaoozIvxdFKeE/DW?=
 =?us-ascii?Q?my8CXB0EIs8BQIsFOcj/Wu0tiW5CDbQZNYxerznTJXLOD4RJXAO9jwp/vdOv?=
 =?us-ascii?Q?gBjE2eb4x5QmSr24Uc6yC2TowNbfX3O8lUND8qCjqAH/EhEA9FiGCBd6t60H?=
 =?us-ascii?Q?H0trjnqaMLUT1sZYpBIyw1JGAg8Nx9Z0dqpItpmMF1hS+TOeOAWJZe7ZSHeu?=
 =?us-ascii?Q?5D6Zt9M7k1jq1RN9TGuK341IlCk8A5qxz9XxjsYOhFhgfqtjrDMXsLHx4j1o?=
 =?us-ascii?Q?M8UEdZvIrPRVz23/2e4uqVPy4tQTLA6hQsxUGKaT8SWxnl2vVgFRCpqA0LyM?=
 =?us-ascii?Q?daxwSzQHdjt5m2QrhIDBdwsNdqkxD1sqg0guNJRzcgPJoaahJliBJYwy46hd?=
 =?us-ascii?Q?UETYVsxbj1h9rcsjd6O0H2MzioiaXzEzYhXZFVGxTieEyejEG5jlg0Oj7qwk?=
 =?us-ascii?Q?QBF2lCwUE9eEEAl456mdIbv9LIUoaAA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16547D69775E09458B71B4C229271106@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3970bd-f61c-46d0-47a5-08da40131203
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 18:59:47.6483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2qtNhcCFZQA+d1VTgr6upnrvAMcZn/mLSeKTKiLHN8rkH6LuqUEJ9ivcS4ypJ6dv3nzHOY0NjpPXtY9glKHccw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1869
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-27_05:2022-05-27,2022-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=834 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205270093
X-Proofpoint-ORIG-GUID: iX4MW8WPO3eLlTM4qErp9oA0ZpGU2vpA
X-Proofpoint-GUID: iX4MW8WPO3eLlTM4qErp9oA0ZpGU2vpA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Frank-

Bruce recently reminded me about this issue. Is there a bugzilla somewhere?
Do you have a reproducer I can try?


--
Chuck Lever



