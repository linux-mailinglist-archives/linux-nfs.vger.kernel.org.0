Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBDB675EDF
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jan 2023 21:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjATUVm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Jan 2023 15:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjATUVl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Jan 2023 15:21:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B87A6D6AA;
        Fri, 20 Jan 2023 12:21:39 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KJwsB0004833;
        Fri, 20 Jan 2023 20:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=q4bOVstEfhXaSHtNJSBLtlJo3AzaBo8mqoOyfvylEq0=;
 b=1MrKT6QDvD1lmUwEzWg896AdkW91UZumeLMagUlb/U2G34NbA/dKZWFiDSYwh57vohD8
 qU4w9hdPYgr318sWBL8PpnO9vHScrhAzt2fZH4oBcKM6ofb7xlpvHcWUmXL0jMX64QZX
 R+K8l77RqVP3UkiaE62vH+eQaCqmkIuhyOUHieOTDtTMFNc80twZtUM2Un9+vfl71ozn
 CZ5NpH0oKDX/YVV0yJ62l4D87JCk26VPcAQGFcxXd2/Cl+T/DVm4UrEGsoyj+dTCLcL8
 Gb/LYfWS+sJvSOsE6KWpsR5L6rCxEVdS+7S1ekCxdBQ6xJAR2RmZ+cjxfM5Dd7YxAkFf vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n7895b9dk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 20:21:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KJpDPI013503;
        Fri, 20 Jan 2023 20:21:23 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qmfm8jh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 20:21:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6O42bPxUi0fuemULEnyBFgk30x0z/YYk+6dTyYFyM2s3v7VFVMVSbsvQVtFMAaCPg6S7wtBsRBypFEqhLIcQoV0JbQbEEug3ym50m5r4ph65YxtpSO+owE9c5OO6B2WmaCTjzzvbw/aNKV9Icu2af1HOZPOcEJQeKji4Trz2aQjXdc0eRf2M1YywYkbdZWka1tFjmSBznbTjJPERWOapQ0HIf06sSqdje5hz5tn4Vqiv+UskJKDBO52iCCNdY8TnVvvkxZILytp3wPUdivNU9PUU3WPvK8PwyZ3ftXKRTBab5/34hsjKJDgTtAHGON04NyLmyllssNwZ0a/xmQdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4bOVstEfhXaSHtNJSBLtlJo3AzaBo8mqoOyfvylEq0=;
 b=AwUq14Kf3eTSFRB+EXCn1pbS66MqeRBZcoNZNSDDHzWZgvC7FLbHEog5cEbbCgzQvevQxassh8nLTb/yc1J+BsTsOKyPNR66TMqeWZY3w9RpWagHf+26uZBBgmKV9QyPLsoaqfUuD682TkQobJ+/6Rf+qCkws4AwhXp5+NdW6uWfUcF8nqEVeZ8PvsSmynYP2H6+vB0ENbSkmVqTGAZrBwOOuXHN7y6WLVvtwA43WesCprqCxb5hfqifGPNDcdVs+WDpRMXhgEfH6oUAHnurjsV9osUzknJ4e9ZSObO6Xf1xbbPhscuW/YlKmPzlEXlbmTGmVIexVq+I+gh12y2d8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4bOVstEfhXaSHtNJSBLtlJo3AzaBo8mqoOyfvylEq0=;
 b=t4H9eA1ZpNm1s9TyWFwhDcnvulwTouaapkBn5tadFTTdZII7BX07iDlz5iNApugXfRsxErtMd/h3CnhFMY6NWQvnF48On4BdmYCRM7Ws5DsvUnSwWYJCSfrC5dlOOfITEM9nxSCWjE4mmw2kdphpu1NnnBQam7bDVjMcCgLxFYA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 20 Jan
 2023 20:21:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.6043.006; Fri, 20 Jan 2023
 20:21:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Ruben Vestergaard <rubenv@drcmr.dk>,
        Torkil Svensgaard <torkil@drcmr.dk>,
        Shachar Kagan <skagan@nvidia.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: don't free files unconditionally in
 __nfsd_file_cache_purge
Thread-Topic: [PATCH] nfsd: don't free files unconditionally in
 __nfsd_file_cache_purge
Thread-Index: AQHZLQi3y7Mea6cMiE2cfMbyen4b566nv26A
Date:   Fri, 20 Jan 2023 20:21:18 +0000
Message-ID: <C04F7C2C-848A-47C5-9C4E-9B9E5E82BAFF@oracle.com>
References: <20230120195215.42243-1-jlayton@kernel.org>
In-Reply-To: <20230120195215.42243-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5819:EE_
x-ms-office365-filtering-correlation-id: 68bf456c-f5fd-43a4-4b99-08dafb23e3b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hCsGTu2sKeH1L1p/+oXxXRtN4onK85UZT6yA9bZQDiXOUtL9RK5ulcJxmoi4xkZiLROcSgS9sQHAVQlBdcVhxx2VP6L1ar9lYuwMTlyR63nc2R8U535loGSITY9p6NOSqA3L0i0bDOXUJTHO4ZbmXalK2coJG/qMWOHsROlIyBEdmAqrMVA0H77tZiiGYu7RqzyHkW/vYosrTmScdtaOYQvgBSWKZW1Mfg/AOiLpx3bvDIOhLftHKwP9oAtSWXjkgNTUAsyy+Wo7a2AfymiG2U42qabKIlG4VH1quN9g+TsJmeJNJ4I2eSMtTUATf9/kXJAA3TCdp72d750Ey/jO4gnHxMJeAw2NLNrKhSe/rwwajlZYBLjRopCObzBSFY9SAVTqS2UzlGpie5BZyoEx4x7G24Cjr0sY35IAJfboE12glf/eqEpJGIu2U1HpVjj+RIBHzhQ0Q3goyS01t8sPrxf6U8jJ59g0yQs0jg/5HUjp5JiwG+dAqTzRXtTdOsvFTeKKBvCL8ypyqtWa7hv02rIpRSwylPFJkS20qY5aSMDLOBE782c0BypePAIrynGpKmVdL9JLJIA8ApnZHc5Yd0q0oxAozYAv0uc3V1/B32wJiwmcBbT6hiW7MvzzYootXsgcwHApS0efT4Kwfelc5q313uOtDjlmCyW4WH31Gnr4OF+PkbLOFsmlV6b9mqf69lDCOsIQYxgtkgqYjpwOLsnOgRP4VLSdOaafaV/81aA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(71200400001)(5660300002)(316002)(8936002)(6506007)(86362001)(33656002)(41300700001)(54906003)(53546011)(64756008)(66446008)(66946007)(36756003)(66556008)(66476007)(76116006)(91956017)(2616005)(38070700005)(4326008)(6916009)(8676002)(38100700002)(122000001)(6486002)(186003)(478600001)(2906002)(83380400001)(6512007)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lDAcbRO+mgo1+/c7vSdguIjqTj5s4N/kwpU+cKW5q5ergfyKuw9lb0R7pWBd?=
 =?us-ascii?Q?iXicv7SQHb4ZqQht5Np2SRqAuceiR/u4Rv3A8TK9cEJXtkEWXPvOLneEF/p9?=
 =?us-ascii?Q?R16xzZ1qKS8ZxyA7I68hA7IEdqnZBb7ijvFM/cDfQnyL7g9lGSlm6tr1tz0k?=
 =?us-ascii?Q?6YPr5B1jcjVE5KtTk/wtnefB6pHPudG6Hu5iatIe0ucPu9k0VIw+3JFc5yOt?=
 =?us-ascii?Q?t5WFBLpKFNG5zxsyG6bQnlUhEKq2rQgnDvhfR1bF66htyY1mr/kyDEY3BgPR?=
 =?us-ascii?Q?P3Ja1mbkzgctDwNpJ+GH3zUr7a8hzPiO3akwQgIKBQtX28yJeMAyNv/Rq6c5?=
 =?us-ascii?Q?9R22zhQrk3+DqhEWjsnck8lDnWRsTBTOPosOS96twmHa0EEk6BfenhCnrrQR?=
 =?us-ascii?Q?r09cM8T1x3w7qZbAO6doO11PbF6+XDHCHNxELweysUWbRnK8sQv/QrWBBCFM?=
 =?us-ascii?Q?FeE0sc9SMLSuKYE/HITKR5KYCKiQA7zbMgqIxn6nToL4lnbza/hVHka30v+/?=
 =?us-ascii?Q?V5EDo7dgIEt2zhwVNiPjl37RFG/p40oqk7Y+DuBBX/dik7FiUTesZxsD0kuI?=
 =?us-ascii?Q?K5OuK+WDfX65mtxLlhSZZ4M9tYvWWIh9x9g//JMtcT/qBM13WktXeBzmUlCP?=
 =?us-ascii?Q?WvzWwCVkxfTlgXtzmwy+dYgv0se+3388DIgRT3NFAdJoObznMT5wKiAwh3F3?=
 =?us-ascii?Q?dPotcVs0auVPKTYQne1oRiQXctgP3sk27LcE9YdB9FMhPQG70LlgV7LRLfq/?=
 =?us-ascii?Q?rHNsbqf3N26swEzy3kwbDctvoDPK4fdHOuh+1swDX3kAnllMpz3sLWZEfsNc?=
 =?us-ascii?Q?V3IHb/wX6v9Pewxhio3/NQ+k9EnQzkY+UxFeadywT+Wj1wPw90Xggs0gmZZx?=
 =?us-ascii?Q?b2od5tRZu4L1VkNH1UdhYsLq50TmHOmjzJhY//FOFHNmjdrL8vAf9h34fMmw?=
 =?us-ascii?Q?EplkWiHqrGLnCD7qvz0moEsFC/HRHx8bLpbgD9EzZQ9Tauim1rfZTx7Ts5vz?=
 =?us-ascii?Q?1MkV8gnUdawMI7DUVLaKsCy8GQjBf2yL/06mSKvzdJhz8t7M4sX3FGF9V1S0?=
 =?us-ascii?Q?7LcpUMLIm2htmKnAWRDswt+zlYO02Xd3yWG95oeF/bfbIW5BnIDGaxYsZJHM?=
 =?us-ascii?Q?NLhyHgMtmruLTd512kHhftFkfTtDadvRWWseRfQ4zsukQF5lvu5HzaigJqmX?=
 =?us-ascii?Q?9Rjqs9QprQoQijg8m4W0P5ZJhxvGrAGiGtkt3ynNQiD4yeQ3zmaVFTL7u8CR?=
 =?us-ascii?Q?4GAvnOajVAPdAnlcjy9PJThREeZXmli4okzgqxkGIPcjoD9UBGocgiF45eXj?=
 =?us-ascii?Q?iyq427K6s2NelRuzU79upWeQNgZBHHu2f148zcmB1wpk9mq05imoqJHVNdnr?=
 =?us-ascii?Q?K6/1Ek15Ln/OFht2dreGzDpBomEXrlGM5aUkDjx3Jed3CuCzAFI4ZpgXq+R2?=
 =?us-ascii?Q?mhyrGKqCOdBjtAI1ElSPesDx2G3z90iMKxg3tMQb3gwASXU0jDDOEEJ3Rnn4?=
 =?us-ascii?Q?d1vRNuxKDzLTRVjnc29GrOOKJbZTrDS4Jkm2yzJ6bbKr+0g0kC+d+N0psIgy?=
 =?us-ascii?Q?BmD8Iv+AFu45msNPVsedrHS0Oxb2GEOtzPVyYFR7VzwOC/Vht8sV5jvkLpFb?=
 =?us-ascii?Q?xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8FF5F8FC603A1241BD02A0B016FBA93E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: H+ZtCl0CLaBH+Lep7ivWuNNjQrtmD2rHqbptY7//LGxAUz6V/Rb9S9x+U+bxrNUu2nZIPFD1QP1fkK3oBo6enR+Jljf5G6omW7iucvLE4U/9CkIEcBz3xzAQzf3SFN/Yhga9vzJYA6YLeDn62x+g37aMbIbv26a5GSJreT2NahJrocPQk9sikZfTwBbogL4XsJ1bho1oj9Ck7DnqykSLnTlJXTAOYdcxGdNF9rFytED2GmNRWN2uRczDq1uqaL6RZmoNZC9zPi4hwc1APYRHDl3V7gBGpceTzk9IfJcaNuADX+EWT6jH8JfMsHQ5b6c7+u4WKdmhHdxJoNz+8G4UwKrb00+NW8aEEORjymZYnY/dxDrILBY0Qqgj/lgyK/z/wJ5XwMTUCGrA4CB6TpglHIKhdMdLA88efCxkjLJ9peEV68iGecnbBEyiTHnJ6WpZOdwDwOEUjGNfbS7bySdH+kMiCAJKq4a/a3WnRN50T8cec8tPOOrKa+pgD/PKApjJJi9GVws68bveK24OQGXDlkPS3kyADPS1tMQbSaYJnL/j7UcSMLHNve9Bsv9t+W5RylGcQgSuIxaQ32hFJDVdOYd4lXxCvYguDUvMzIY94H9oLOJZfvshoascuVMNBNtfrB/3B4/Q4z0JbKsCgrjBq5jbfrZB2n8o3HHCDGDu/TWgv3rjBzpzQGPLT55S6bVztuboexAhdxqwz1R12PRcx7zKwaX9n0VrXfO7o4W6XkWBpaCzUzhvcyr0j9ViywuJZH0gJtjHCzej9coQjX0L40EdAWoLnQLqJZBF1V8we48Dz+6R/g+HOQaeu8ucmHtFzF3v6e/LN024vobWZ1ExBw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bf456c-f5fd-43a4-4b99-08dafb23e3b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 20:21:18.8811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xZ4d63cbncsEEaiXClAbQqlkd0OcHRqViAKTEOzz5F1pkP7Kzs0SWkA02/yZM+5dj8PXfiGz6BCP+qyvmRvZFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_10,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200193
X-Proofpoint-ORIG-GUID: t7OVUMigBQg3yrcGw35yz6sa7ZhTUfxT
X-Proofpoint-GUID: t7OVUMigBQg3yrcGw35yz6sa7ZhTUfxT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 20, 2023, at 2:52 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> nfsd_file_cache_purge is called when the server is shutting down, in
> which case, tearing things down is generally fine, but it also gets
> called when the exports cache is flushed.

Yeah... cache flush is probably the case we've been missing.


> Instead of walking the cache and freeing everything unconditionally,
> handle it the same as when we have a notification of conflicting access.
>=20
> Fixes: ac3a2585f018 ("nfsd: rework refcounting in filecache")
> Reported-by: Ruben Vestergaard <rubenv@drcmr.dk>
> Reported-by: Torkil Svensgaard <torkil@drcmr.dk>
> Reported-by: Shachar Kagan <skagan@nvidia.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 61 +++++++++++++++++++++++++++------------------
> 1 file changed, 37 insertions(+), 24 deletions(-)
>=20
> v2: use the same method to purge entries from the cache as we do when
>    there is a notification of conflicting access.
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 58ac93e7e680..397ae212b98d 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -661,6 +661,40 @@ static struct shrinker	nfsd_file_shrinker =3D {
> 	.seeks =3D 1,
> };
>=20
> +/**
> + * maybe_queue_nfsd_file - try to unhash and queue a nfsd_file to be fre=
ed
> + * @nf: nfsd_file to attempt to queue
> + * @dispose: private list to queue successfully-put objects
> + *
> + * Unhash an nfsd_file, try to get a reference to it, and then put that
> + * reference. If it's the last reference, queue it to the dispose list.
> + *
> + * The caller MUST hold the rcu_read_lock() !

__nfsd_file_cache_purge() isn't holding rcu_read_lock(), it's
holding the nfsd_mutex. Is this comment incorrect, or is it just
too specific? Or did I miss something obvious?


> + */
> +static void
> +maybe_queue_nfsd_file(struct nfsd_file *nf, struct list_head *dispose)

I prefer the name nfsd_file_try_to_queue() or nfsd_file_try_to_dispose().
nfsd_file_ should be the prefix where possible. Unless you're
redriving, I can fix that.


> +{
> +	int decrement =3D 1;
> +
> +	/* If we raced with someone else unhashing, ignore it */
> +	if (!nfsd_file_unhash(nf))
> +		return;
> +
> +	/* If we can't get a reference, ignore it */
> +	if (!nfsd_file_get(nf))
> +		return;
> +
> +	/* Extra decrement if we remove from the LRU */
> +	if (nfsd_file_lru_remove(nf))
> +		++decrement;
> +
> +	/* If refcount goes to 0, then put on the dispose list */
> +	if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
> +		list_add(&nf->nf_lru, dispose);
> +		trace_nfsd_file_closing(nf);
> +	}
> +}
> +
> /**
>  * nfsd_file_queue_for_close: try to close out any open nfsd_files for an=
 inode
>  * @inode:   inode on which to close out nfsd_files
> @@ -688,30 +722,12 @@ nfsd_file_queue_for_close(struct inode *inode, stru=
ct list_head *dispose)
>=20
> 	rcu_read_lock();
> 	do {
> -		int decrement =3D 1;
> -
> 		nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
> 				       nfsd_file_rhash_params);
> 		if (!nf)
> 			break;
>=20
> -		/* If we raced with someone else unhashing, ignore it */
> -		if (!nfsd_file_unhash(nf))
> -			continue;
> -
> -		/* If we can't get a reference, ignore it */
> -		if (!nfsd_file_get(nf))
> -			continue;
> -
> -		/* Extra decrement if we remove from the LRU */
> -		if (nfsd_file_lru_remove(nf))
> -			++decrement;
> -
> -		/* If refcount goes to 0, then put on the dispose list */
> -		if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
> -			list_add(&nf->nf_lru, dispose);
> -			trace_nfsd_file_closing(nf);
> -		}
> +		maybe_queue_nfsd_file(nf, dispose);
> 	} while (1);
> 	rcu_read_unlock();
> }
> @@ -928,11 +944,8 @@ __nfsd_file_cache_purge(struct net *net)
>=20
> 		nf =3D rhashtable_walk_next(&iter);
> 		while (!IS_ERR_OR_NULL(nf)) {
> -			if (!net || nf->nf_net =3D=3D net) {
> -				nfsd_file_unhash(nf);
> -				nfsd_file_lru_remove(nf);
> -				list_add(&nf->nf_lru, &dispose);
> -			}
> +			if (!net || nf->nf_net =3D=3D net)
> +				maybe_queue_nfsd_file(nf, &dispose);
> 			nf =3D rhashtable_walk_next(&iter);
> 		}
>=20
> --=20
> 2.39.0
>=20

--
Chuck Lever



