Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680194D31C2
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Mar 2022 16:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiCIPaI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Mar 2022 10:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiCIPaG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 10:30:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F0DD2276
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 07:29:07 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229Eqmvf010008;
        Wed, 9 Mar 2022 15:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=moac6hR4fAPmr7+Z3580d0Pvx1lx+5HitPl3vQR+Uj8=;
 b=VXV2oXU1J6bM9EMRiC6u7fvtMZfBSAXawGKE9rrDFVAw9K2qWgSN/Iny8VZxAFM6DlkZ
 yKv1rar3QEAD1snUncmm0JWEGX30g5AQn2Ul25mVqhhrwJFH/wvKHsdy4sqgskvPusWx
 mBJVHWtRZJW6FVWkIiw3sSReslVqh+6NIH6JlUlizSxoOWwiu4Cd6xgaGaG2rtbBrCDO
 RUb3cfZyqSx9pMhkD48Schwj6Dzyc2NIVt+Gs7fuLOWG9Ek2a4XbJZTj6RTqww+yzF1j
 iYDFvOo8SGCr/utag6CW9BYB+p/+q0Xr6W3pW7clXFWCarbxdfCzEbiYvy9UbZqlikz8 Yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyrat2he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 15:29:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229FBGTT097835;
        Wed, 9 Mar 2022 15:28:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by aserp3020.oracle.com with ESMTP id 3ekyp30q6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 15:28:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMEduGYzidS9ZdIc3Y0ukzFRioW3yXXo5cn8CXG6Qp+ijTVFb2Tu3jASvixncBxbPCtkW4ZC+xtUbOU6DpkqlB8ynjceQ//Z8uOc6nZkjbMmSDb5pip2cT6yilXmGc7q6xj0K3JvV3Hm0+711jNhKLQRYNWdSA+9bxPA+7ytFGYa5ZeeZkJdYdzu9tfIMaR7mZ5XJ6Ma32nTgPnd0libeO5xqqFDVnJSGydaBPmrXf+1Lzsw7LKjnEHDKvCUoL3f6KoJ+pTXxcoF5OOR85F64wYzzmAONUGTHGY1ERO/MNqwyQwCkgYY5/szcuK50wmum4mCSvs+uJEPDRsIhHAcXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moac6hR4fAPmr7+Z3580d0Pvx1lx+5HitPl3vQR+Uj8=;
 b=VtplrcO6B6p/sRRJ0sLD33w97uxMVBWsl3XrSisactUP2Wjks8P5u9VSd6O8kDmusL/3kBH+Sui2i9M5ObMy9Oeulu/CV5NLmk/RJ7AVHuNFbvHKlnQtWLSV1pQDUbQfpPyKQc9qHdoljyF9iXO9i/SCCh/+uc2NGTttu+coEBn/BmNuZEnka2qsoa+Z9/TneSKIYhcdEHL5nfp36ICPgV8GJV5xFLS/t9TVWNpeyn3s7JymW8kktAObCe5Yng582IqX36g8+s7sk9eafNkMz3LphSIZP9w6M/HDIZ0bABev98VxSfTsRY7XetjgYa5FCCvdL5a+USNc9JRh1x7ryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moac6hR4fAPmr7+Z3580d0Pvx1lx+5HitPl3vQR+Uj8=;
 b=nhYei0b3H7b+AI0X4DoezgwVQ0t1E9eZquqhvoqL9jvH8kwFP7wQDAuC346mdSuDvf80cw0i0VfuF7G7qKgpirHib+A7BXQ0pp+MDlE0/nLYi6JO5tv6wBqSLkXTcNu++aFzH0d6bDeLTgPWDcDmOPbqrJ497tFoyKhJgJ6pWF8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5248.namprd10.prod.outlook.com (2603:10b6:5:3a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 15:28:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%8]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 15:28:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v9 03/27] NFS: Trace lookup revalidation failure
Thread-Topic: [PATCH v9 03/27] NFS: Trace lookup revalidation failure
Thread-Index: AQHYLDBe+tYfJllDgkq1fiAqzlCwyay3Hr6AgAAdmgA=
Date:   Wed, 9 Mar 2022 15:28:45 +0000
Message-ID: <52214581-7C9A-425A-9B8E-082B7ACE23C1@oracle.com>
References: <20220227231227.9038-1-trondmy@kernel.org>
 <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org>
 <20220227231227.9038-4-trondmy@kernel.org>
 <638A1DDB-5424-4FFA-A5A5-D212519D3A37@redhat.com>
In-Reply-To: <638A1DDB-5424-4FFA-A5A5-D212519D3A37@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1de4cdbe-b86e-41d5-331b-08da01e18004
x-ms-traffictypediagnostic: DS7PR10MB5248:EE_
x-microsoft-antispam-prvs: <DS7PR10MB524861B9B8B1677440FF28A0930A9@DS7PR10MB5248.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YUdUTwRk+AYLmmRpjoAAEXRaDCDWhCZ3JtlnLsX22mQfxobDrj4Co/rUcbYfhDQ4wWiPraU0Iw5RhoCqIQWmXHMDuzpixY4ECDhw0src44L0CVB3Jxzzgd75nXjLJniaMLIKi47VCt8B0ugtrIicP2rhD28je5cQJ83ViyZCT4Z/wjpszDqAzB2qiQOmjfD3mBRP5rpKyX2wnoWCueErcjbKhMzI4MvSmPKRCd7bPsmomWed21wQbbe8dArhNPHR7pq3iukhhGt1LGr8mA8+xRX0fgKbjRF9uvr01ZL63fU9CmH5SCYcql7eQlzUAHX7BjlkzlscTJy7xzMy/Ffi9GLDTJTHCoZ3Sa8p7xW3Hm+uUaEzBabIYR2ngsUAXwNe0wT5JHgM2clfNGdKy0WlqdNH0zxpvIryFA0Ydfw5jhjQgT0Sa64k+AKYnMj7YhuZlPfORFDDliBDs/QAo14MINO9ZGix+QaCYL05C67AqqPi80K1GRFRUFfzJCycxNovbOEhLfFb90/Y9xALuA+7nJiQgloGY9pCDsNh8iHm5VMEIOJ2rI9Qqj/9plhSNwIgK/MmkEwIQoXJm53BScnOJPfX3z61x36ll0Wag3xI5p0aMMSWptO1wCVPhzF8btzKTCB9luTDYBlsfd0G4Z0OQyZbWYpfaI7TwdfI0k1kr0hl3bifekU34a8lJe/fyT8gySnbrKGnLeSvUX+KWv0OdqGNVs++PlJsTpLucm0Yi21nHcrtsiyRuBshUgj95lod
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(316002)(66946007)(91956017)(38100700002)(8676002)(66556008)(64756008)(38070700005)(66476007)(86362001)(4326008)(110136005)(53546011)(8936002)(122000001)(2906002)(5660300002)(2616005)(6512007)(76116006)(26005)(186003)(6486002)(6506007)(71200400001)(508600001)(83380400001)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rrsXRvT3zo1TUFFVmAXwBXVavLojV7flhh8csatSmAZLrbLew23LKVwycXVQ?=
 =?us-ascii?Q?zT17rlb9COVnYFJ8gPzcnMZlr0MX7+X3JVzGDziRUFvy/re7i8P41r9SNroD?=
 =?us-ascii?Q?CnKDlN629AC3HYnStPcXrepadG/gxrE8kIpU6yXctq2qkTzwQXVN4Wa/cS62?=
 =?us-ascii?Q?T/uJIU+gGRmLeo9Pe9TBZICqQ67oifEZtipFwKWf7QqW54KYeaMDOtdygPnD?=
 =?us-ascii?Q?/+15rYRQCplNdqgbn38nSRfpm8neAQLlj8zXdMZTJUOaylHqTt/omDQu5g5R?=
 =?us-ascii?Q?yI9oHbrmo5GH6O22uVgEciTQcfUoBx2kQj/dP9WimZvtET2dHiOO58hiSZfM?=
 =?us-ascii?Q?6RWyUW1aHGpEkfkN6G/+teBc30oG1JPdTlzPFD3XmaHAqY1qAvn1vbqYatOX?=
 =?us-ascii?Q?8qN1Ag3K2W543DafEAot6n/gsCjAS3cdQvZn1tY8GWKlvRbeV+BdQ5tYMz1X?=
 =?us-ascii?Q?l4p29Npqmy3xkT5GA80JDYmpXmj4MAWEvXNFGvHZGx4kKjDPeeDTm5d3ZSKQ?=
 =?us-ascii?Q?DQhKfqxdLKTcv8y3np7+68Gr6g0rfPeqjIbxvAL2UogHOn0KlT1nqv0UTdjJ?=
 =?us-ascii?Q?hw3KMpIRPcO+S7wT8//XbIHGTDHMR7KZ8XmGh2XueGVpzVjMx30da0q8zVVK?=
 =?us-ascii?Q?fkV6x0cmv+U1OgFGnoxXnaCY0jwFNr5UV+zb3q+31INMppt5uE7PqtYC7eLU?=
 =?us-ascii?Q?8kXarhI/AzalhBEqHZtsNCEuJojIYGQXXETEw5/lD+KGmtb40E0OnSSOZ5h3?=
 =?us-ascii?Q?Zwx4l1MJnjyPa88xmDiQ1+PuH3YbEoCPzxWPNPdlVPv7Th+c1sDS1JC+Axnf?=
 =?us-ascii?Q?ZUzZMN03si2SNWNzAqke4GqGOVK+phal3HyRsvGO4quZlW8MtQRwwAVXYb6c?=
 =?us-ascii?Q?oI3L8dXrKry5NWo/Twh5q0ZylXNXMhSuLA/gXIXYlg56ajKRwouvqX4BqNQD?=
 =?us-ascii?Q?2xUm70EVLGfC8/TOPwCRT1XmMELOX4/xuMeZWnkKlaEZcKzQPKhcH39y1XwE?=
 =?us-ascii?Q?YjFrE8cQf+tgZjWfMa08x+vcPNQWwXQBBpB85shUQIDiV538uN/U8BGZoTs1?=
 =?us-ascii?Q?OJmFc2pjv5GDrJvA5uVDc3eZm9T3lFWjCqYkSvANu/Huq2dz9fcLb/65K5l7?=
 =?us-ascii?Q?mTTZCckTW3bpspQ5W8o4jYbAANZ8jAXPx2TIwicxwzSD5sr0Umk3tu51lan1?=
 =?us-ascii?Q?mWF4skyZ7y8q8mui3YTvWDrQC8SC6Ox6F4kxc/dhfjKBTc0i2CfFsiHqySDW?=
 =?us-ascii?Q?r1iZ/Qs+esG0LoLd+cx7olqtJvNX/1BmmwFhcF96lf73IuJ82yaNe0XwaTJp?=
 =?us-ascii?Q?CxHFWsXd6agByjJbdCn2f9t0OBjOOQvr96ZEO/rhb4877I0KCBKlyEJpp1/v?=
 =?us-ascii?Q?OssWc5Bqa23ULTdibWt1kluHfFvpwOtF9nM+ZvxNzInE4HGI/SLi2eKmzXVm?=
 =?us-ascii?Q?IpjAJvpVPSxee1OBYJp93gU8QJ27ymrcAQZJrh0x1mFhN9oUZ+ANUlnREr52?=
 =?us-ascii?Q?WYG6+fItGMUcCSTJ4ZHqTfzj9VT0giAglFa4TicXigajLkcO7ENduXuUsQ+V?=
 =?us-ascii?Q?JwZ/N8EW0biaHx1sEn2/1TV9vsy2ei/lI6ZuUGyEoI2Ft2KLEy2S/hOYaQnD?=
 =?us-ascii?Q?52qvN8rzT1xKaglPMAOEqj4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ED3A760B380F2047976EB6132F0E6341@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de4cdbe-b86e-41d5-331b-08da01e18004
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 15:28:45.2281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dtIcOIFk8WvwaJr2+a15tFb91+fiR2Ivspdpc+mHu127Lwla6zrOkerJwrEBBHN6W+htc/5MXhtc7z7TfJMSDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5248
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=844 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090085
X-Proofpoint-GUID: 365m-28mdFFGrpPGYFkoDrzZy3yaq2sx
X-Proofpoint-ORIG-GUID: 365m-28mdFFGrpPGYFkoDrzZy3yaq2sx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 9, 2022, at 8:42 AM, Benjamin Coddington <bcodding@redhat.com> wro=
te:
>=20
> On 24 Feb 2022, at 21:09, Trond Myklebust wrote:
>> On Thu, 2022-02-24 at 09:14 -0500, Benjamin Coddington wrote:
>>> There's a path through nfs4_lookup_revalidate that will now only produc=
e
>>> this exit tracepoint.  Does it need the _enter tracepoint added?
>>=20
>> You're thinking about the nfs_lookup_revalidate_delegated() path? The
>> _enter() tracepoint doesn't provide any useful information that isn't
>> already provided by the _exit(), AFAICS.
>=20
> No, the path through nfs4_do_lookup_revalidate(), reval_dentry: jump.  Bu=
t I
> agree there's not much value in the _enter() tracepoint.  Maybe we can
> remove it, and _exit more like _done.
>=20
> I am thinking about hearing back from folks about mis-matched _enter() an=
d
> _exit() results, but also realize this is nit-picking.

I think the _enter / _exit trace points simply replaced
dprintk call sites which did much the same reporting.
Maybe we should consider replacing some of these because
we can rely on function call tracing instead.

But generally we like to see trace points that report
exceptional events rather than "I made it to this point".
The latter category of trace points are interesting
while code is under development but often loses its
value once the code is in the field.


--
Chuck Lever



