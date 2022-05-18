Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D987C52BEBD
	for <lists+linux-nfs@lfdr.de>; Wed, 18 May 2022 17:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbiERP04 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 May 2022 11:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiERP0z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 May 2022 11:26:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204E31A0487
        for <linux-nfs@vger.kernel.org>; Wed, 18 May 2022 08:26:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IEVLjT005212;
        Wed, 18 May 2022 15:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cJSibPnbRi4AV7eU3nbtFdqhflipHWMkxssoQfLtIMg=;
 b=mGjOx9/zI1c62kVOLDBgiLauzRq91fHA6hqPmg5ngYG3JrwLqgm54uGq1RAIefnRA2zM
 tHH1kSr1+4LPppxw1xTjaKA1CT9se/L2UWIcS2ao1O/UR55sEr2YeCb6uTSDO96emhJI
 gmDqyvTzG94k4C1tAxyUBXrhlnApCW6oikHpirpuKNEFp82IYFrMbG9Lp9cAI759avzv
 WBfawEfLKLjrihPvX8oSUiowVJqmPjLQDXdsHXOXmU5YwqQ/754UuIwT7aZhYpLL+6y9
 qE/rjZtyni9LQ6ztRN31Bzgl/lr981qOb0D5/qqkkKyZbYtfIvuS5+nU1dDfuaRSm0oo uw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g23721t8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 15:26:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24IFQVUe011277;
        Wed, 18 May 2022 15:26:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37cqgqk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 15:26:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7hxppuq0ySHJHS+g5PHHGF43ssmCK9crcvyRRh2CLTz/r3mKnjfxgI1eZZrpT8emmmhQmp7+ISX4zrdITl8sx3YvdsSdbPTofyFP8Rjc5KqCbM8DmQOfCq4AVJOIPJdJyVFL9FqzGxE+/6E+5x6nSLkZarHCtC6jRmyq+r9k4xx6CXDI5AnEOEm9BXSDXerbG4VbAgASscq/4Cxws8LG78sElDI4GyFwI+B2jAa/poijzNakn5M171b1JkfJC6DcBvgrJ+ZPR2ozezr4YseDTdDhsyHNmCriBVH6fYWfCy2sAX9/B6Ktkmt1UGuZZ47+WxhIwyOK/6Km29meD3LAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJSibPnbRi4AV7eU3nbtFdqhflipHWMkxssoQfLtIMg=;
 b=BSl894hLC+upNt3fZV7mk58yJm/Mykef4O0YU0L//OxYI0vM0ZnHua2tSOuKDOD4duNURTCEs4k3BoFmJgJjlG6dj3QNzMcC60lQmWL5HgdBAw6rRtN0XE/2tAY4fbiQ8bVDfu8mLXBPKlzX8a0BA+4dJlT8uNnIqcHZHJPa4sggXj4He+Bqe5vsqRb86tbtns0AlAlPVoJG2BBQBLYlNmUjTM54i8FuFkcHpQ6Awl+krKgVYvK1vVmJuMBIWOOn7qAX41RgV0OHIj8EZy8Qmbz3ke2KRzeYT6DqHeds50wg5mi/4YsOdQq484M5l3cWs5DMDpxb5vmRCL0WBa2TKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJSibPnbRi4AV7eU3nbtFdqhflipHWMkxssoQfLtIMg=;
 b=m+9F7kZ2q6l0s91rnT59FddMvhtW6rHoFJBggE/RSAyo9Dt0bFcL0Ope3+xOoKI3mY6TjPEdiURj3yPoS7ks49O/vpMK2Sd8zhoD/PkBrwOMkrDfNPhJWctLYzNYdyzIyfah/2vI8/9smKT9g5+TMnt7wiZSriPV1fUxYjMHhMY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY4PR10MB2038.namprd10.prod.outlook.com (2603:10b6:903:122::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.17; Wed, 18 May
 2022 15:26:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 15:26:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Bruce Fields <bfields@fieldses.org>,
        Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] nfsd: report client confirmation status in "info" file
Thread-Topic: [PATCH v2] nfsd: report client confirmation status in "info"
 file
Thread-Index: AQHXHRCg4I/NVojQCUuAkyEihGCrLa0nUdcAgAALZAA=
Date:   Wed, 18 May 2022 15:26:45 +0000
Message-ID: <A62B027C-434A-41CF-938C-2ABFE10A794E@oracle.com>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
 <874khui7hr.fsf@notabene.neil.brown.name>
 <20210302032733.GC16303@fieldses.org>
 <87y2ejerwn.fsf@notabene.neil.brown.name>
 <87v99neruh.fsf@notabene.neil.brown.name>
 <87h7l6epmb.fsf@notabene.neil.brown.name>
 <41FCC628-9C02-4A8D-9E82-292AAF489E9B@oracle.com>
In-Reply-To: <41FCC628-9C02-4A8D-9E82-292AAF489E9B@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de4ddf44-99fa-453d-995d-08da38e2d150
x-ms-traffictypediagnostic: CY4PR10MB2038:EE_
x-microsoft-antispam-prvs: <CY4PR10MB20382B8D7DA687530EE4528C93D19@CY4PR10MB2038.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yneM784ujWIJ92LpSrhqESppqQx/VBF4eGrYo/hg2qot6mIYAZiZq/Sl8fSHNuteJMN5V2sAEtkvsM/Mhwa1OBoDOV1pOSxIDvCl9CS1L6K+m623gvoI7gcR2bZmAIGlTIoVE55uRXfqXdSqaa1SZRq3j5fC1d9GoWikP8cAdcX8kNdTIfYs18kQpjKujqqiHSU53tlA8WBJrThvq2JhgnjliNuQ4kvMxXzGYentH3StTsEETcOJ17YhsXPwyQh1R3KvExo3m5hP9BspDKepzGI8YgVwHGHA5AqUqSiUU56yfBAfIdUGbkOsXWT7SSsmi49kKSD9GEMjN4NtlohTl6WeqYa0Nkid0q343j1Z7C7iDgCHWYrm8yXBznfFum0m6zmDwMKPu4HdUpC5mjYCjy+ri1pOli/+ZmQtLTqOQbzBBwPkb3wwa2/gVki5HbfT6tFNK4XNvoijl4MYJV13hFW6ngmwIM0k2cXYafL7pKWQYzE14vHyYzYED7PoZfLAMN/GI4vpYkUUgDKeVaAAkfH4olmxfLKyTazADBmHUYCosXi/KqjNDel0f7OY1wxlnU15ossQOXTWsXcu5EasWgAR4ygvnPuAY9tLCBxU3+4ea3CXG0U2dWlkz0kXNgxfsbb9Bn0DGFWa8IKgHvuHkGso7Fr9MDkUj8wZ7fsxZqTUPPdcoJZ1LBcseyd6fO0Ob+3JLcWrZ4q3lYDn2l/2mg4OTBqdqoqx01sk8iugNkqRmikgiHRFMJ6umB7vxN3ODL651SqixLolO3nq6xJQhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(64756008)(2616005)(33656002)(6916009)(2906002)(186003)(76116006)(66476007)(91956017)(66556008)(66946007)(5660300002)(83380400001)(122000001)(6486002)(86362001)(6506007)(53546011)(71200400001)(508600001)(6512007)(316002)(8936002)(38100700002)(66446008)(54906003)(38070700005)(26005)(36756003)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SkbPw0Hbz8iVpHj/hOzvmuJy9Wr11fQJSmtx5dv+KQa9030a4XZ7FqdHrlOM?=
 =?us-ascii?Q?gV3lu/JVO582d1N6tHBKguvTeCH0X4iBdq0zTKdMzN/blRH+r0vNu2z9wFfC?=
 =?us-ascii?Q?phc5sN8t+wIyozeJ94K5IGlITZ5+J6ax4xs7oZEZZAXuxjiUuzgE5eEZInPp?=
 =?us-ascii?Q?vQGfe6HTFNzBCfkakUT9XAxaQjGOTC6ZV6cYQO9DYdOIxOw8lLRAA/oD28qx?=
 =?us-ascii?Q?iMo+DgGhihSDartZcuXnDegUGmk7eD1hzatdSF4lrFCQQ8LCRSkmM2zsbWFw?=
 =?us-ascii?Q?N24C+9qD9IjuZMeCcLDdgjWWOp/hysLmGhn7SEf7D7Qpe3Jo+LV5qe0uQTmo?=
 =?us-ascii?Q?EiOFrFyC4cnRuHM1GpecIugyN3j/qjErHf54CCOok4WK4ARNtSvdQcYUVr7g?=
 =?us-ascii?Q?DnMYZnixqSyy72ZD+vaqNgyRRAvl9DW9JnyoUo4unTpcWJVBnO3Kvh8YkSus?=
 =?us-ascii?Q?Qpx8a8NmuRJhzxVpk6GRZi48TWq8W3oF/rm5HQ2X6tVpLDxTCHPRtE6Etfb1?=
 =?us-ascii?Q?zk+N28kSOQnUrI7aNw57QXoJ9SykXMsVsXtnYaK3Y054w5TYUN2j27twm/Rb?=
 =?us-ascii?Q?U6UTxwe+UrZO+nzVImTClUofx3QuK+ULYvFgJAhV0nFWI81cAwUhcgnbw2IZ?=
 =?us-ascii?Q?HghnGP3i++DYIGE1mt0lr0HziTYUtOfCg7ptMGydB0s18p7pZx+OaaKkmeYF?=
 =?us-ascii?Q?b8hLp+H+WRq81g/EubHy7PhEI4I1Fiy3jjGx4QpgxcWdZ+LJ2gQFAIuSVgiL?=
 =?us-ascii?Q?c6AWk6HT5idCGPug5YMKKwF/HiPYadfmNXmlI+Sl57q1HlODpoz37oWIWhna?=
 =?us-ascii?Q?a0lt3MmwYg/xLISX1kVW4ZeGYmJqZn94YfhV1eMsyh4a43VE1Uf1bsc44jbf?=
 =?us-ascii?Q?Q/hS0F+9RCyDhORzxHCrlP9cmZeR2e0JatnBTWY1z6tMiADZNUYL78LHBVXz?=
 =?us-ascii?Q?3qzVOInhqtFG66uelDISxREdn9JqLWHFHKukwkZCqeOl+I/y2tNh+p7NB+Rk?=
 =?us-ascii?Q?d1xkvxewu4vK2wwgKq4tgLhlEN0A3k6OmINvIGGV3qFxBqm/57VtOVT2LkSz?=
 =?us-ascii?Q?WXL6R5mkNYi5LzxIf0sA5oTLZPPNM0TVzB0tkRkFahoT9q9HSd0iwNzMg/AN?=
 =?us-ascii?Q?UcwB/hdrDl88g8U53aawMBGZuyR1jEtEw2qA03rsswKAXUa6Q7ugKaym7qsz?=
 =?us-ascii?Q?cJhopJHkovgsUjKQvthEaD9ya7k/Cydx7lb/yFalKN+BMg79Dh0UG+0BYp93?=
 =?us-ascii?Q?/tusmf5G+9OGru6BeinqVfYXspUtuNVRYCdOd/bi0zYx6LJ2mAnH21z8mVl3?=
 =?us-ascii?Q?eCrfYEiHIRd/MdiYYWVQFoG1FtarCe6F8bKq8xZ3X9DVpPODne5t32c2WrE1?=
 =?us-ascii?Q?sOdaR4MbrhR/iErk8v7H/VJ3SLZ9h4Vn+P0+YfarmWa3ciHt57tGypxXJ+Hb?=
 =?us-ascii?Q?gD7ymNfqm331eRupqH/0KTO+VXCBDGvwn76XPOlkCF6id5GPVZDxcln+EGz5?=
 =?us-ascii?Q?wxKxa4I/PRzVwn5aJqFKbVnup33AyUSbbWQMYpoDBckGZgk57wFabyM6yIti?=
 =?us-ascii?Q?EIY4TmrziUyDo8oiXJFjJLA9Z0iDSorJrk4+jaQUqBeajyVg2AVM7R5PFvXp?=
 =?us-ascii?Q?+bTZ793s9PTopVvUDluV+Nrk0phDogVCvmfGEhVfR55QjCutk8nQZaAz/kWk?=
 =?us-ascii?Q?mTCzpX+5pbuCoP0F9DBAvI1D/W4hQn4UE1nUxVmQofjYSyLYG0cNwdRiIH/O?=
 =?us-ascii?Q?cmCAQHtq5Xb3lJvIvkzqTmZxzwMq8kQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E2E0BE17CCC5FB40A6FF515EAA68B290@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4ddf44-99fa-453d-995d-08da38e2d150
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 15:26:45.1674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQbGiL/B3X/pbBiH6y70bYj/rBVLpYXh1+4yR1ZgcZZlH09WPjuE8l3a8BzFQaRc2Imbw2SuH7D9Dn5evhpU3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB2038
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-18_06:2022-05-17,2022-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205180091
X-Proofpoint-GUID: lJwTYF0VUnDgs1QsTB9pDDQYACwvBlt1
X-Proofpoint-ORIG-GUID: lJwTYF0VUnDgs1QsTB9pDDQYACwvBlt1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 18, 2022, at 10:45 AM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>=20
> Hi Neil-
>=20
>=20
>> On Mar 19, 2021, at 6:38 PM, NeilBrown <neilb@suse.de> wrote:
>>=20
>>=20
>> mountd can now monitor clients appearing and disappearing in
>> /proc/fs/nfsd/clients, and will log these events, in liu of the logging
>> of mount/unmount events for NFSv3.
>>=20
>> Currently it cannot distinguish between unconfirmed clients (which might
>> be transient and totally uninteresting) and confirmed clients.
>>=20
>> So add a "status: " line which reports either "confirmed" or
>> "unconfirmed", and use fsnotify to report that the info file
>> has been modified.
>>=20
>> This requires a bit of infrastructure to keep the dentry for the "info"
>> file.  There is no need to take a counted reference as the dentry must
>> remain around until the client is removed.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.de>
>> ---
>> fs/nfsd/nfs4state.c | 19 +++++++++++++++----
>> fs/nfsd/nfsctl.c    | 14 ++++++++------
>> fs/nfsd/nfsd.h      |  4 +++-
>> fs/nfsd/state.h     |  4 ++++
>> 4 files changed, 30 insertions(+), 11 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 97447a64bad0..ec1b2dd8fd45 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -43,6 +43,7 @@
>> #include <linux/sunrpc/addr.h>
>> #include <linux/jhash.h>
>> #include <linux/string_helpers.h>
>> +#include <linux/fsnotify.h>
>> #include "xdr4.h"
>> #include "xdr4cb.h"
>> #include "vfs.h"
>> @@ -2352,6 +2353,10 @@ static int client_info_show(struct seq_file *m, v=
oid *v)
>> 	memcpy(&clid, &clp->cl_clientid, sizeof(clid));
>> 	seq_printf(m, "clientid: 0x%llx\n", clid);
>> 	seq_printf(m, "address: \"%pISpc\"\n", (struct sockaddr *)&clp->cl_addr=
);
>> +	if (test_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags))
>> +		seq_puts(m, "status: confirmed\n");
>> +	else
>> +		seq_puts(m, "status: unconfirmed\n");
>> 	seq_printf(m, "name: ");
>> 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
>> 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
>> @@ -2702,6 +2707,7 @@ static struct nfs4_client *create_client(struct xd=
r_netobj name,
>> 	int ret;
>> 	struct net *net =3D SVC_NET(rqstp);
>> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>> +	struct dentry *dentries[ARRAY_SIZE(client_files)];
>>=20
>> 	clp =3D alloc_client(name);
>> 	if (clp =3D=3D NULL)
>> @@ -2721,9 +2727,11 @@ static struct nfs4_client *create_client(struct x=
dr_netobj name,
>> 	memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
>> 	clp->cl_cb_session =3D NULL;
>> 	clp->net =3D net;
>> -	clp->cl_nfsd_dentry =3D nfsd_client_mkdir(nn, &clp->cl_nfsdfs,
>> -			clp->cl_clientid.cl_id - nn->clientid_base,
>> -			client_files);
>> +	clp->cl_nfsd_dentry =3D nfsd_client_mkdir(
>> +		nn, &clp->cl_nfsdfs,
>> +		clp->cl_clientid.cl_id - nn->clientid_base,
>> +		client_files, dentries);
>> +	clp->cl_nfsd_info_dentry =3D dentries[0];
>> 	if (!clp->cl_nfsd_dentry) {
>> 		free_client(clp);
>> 		return NULL;
>> @@ -2798,7 +2806,10 @@ move_to_confirmed(struct nfs4_client *clp)
>> 	list_move(&clp->cl_idhash, &nn->conf_id_hashtbl[idhashval]);
>> 	rb_erase(&clp->cl_namenode, &nn->unconf_name_tree);
>> 	add_clp_to_name_tree(clp, &nn->conf_name_tree);
>> -	set_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags);
>> +	if (!test_and_set_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags) &&
>> +	    clp->cl_nfsd_dentry &&
>> +	    clp->cl_nfsd_info_dentry)
>> +		fsnotify_dentry(clp->cl_nfsd_info_dentry, FS_MODIFY);
>=20
> I hit a "sleep while spin-locked" splat and bisected it to this
> commit. fsnotify() can allocate memory with GFP_KERNEL, so it
> can't be called while &nn->client_lock is held, unfortunately.

Never mind. This was fixed by

  934bd07fae7e ("nfsd: move fsnotify on client creation outside spinlock")


>> 	renew_client_locked(clp);
>> }
>>=20
>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>> index ef86ed23af82..94ce1eabd9d1 100644
>> --- a/fs/nfsd/nfsctl.c
>> +++ b/fs/nfsd/nfsctl.c
>> @@ -1266,7 +1266,8 @@ static void nfsdfs_remove_files(struct dentry *roo=
t)
>> /* XXX: cut'n'paste from simple_fill_super; figure out if we could share
>> * code instead. */
>> static  int nfsdfs_create_files(struct dentry *root,
>> -					const struct tree_descr *files)
>> +				const struct tree_descr *files,
>> +				struct dentry **fdentries)
>> {
>> 	struct inode *dir =3D d_inode(root);
>> 	struct inode *inode;
>> @@ -1275,8 +1276,6 @@ static  int nfsdfs_create_files(struct dentry *roo=
t,
>>=20
>> 	inode_lock(dir);
>> 	for (i =3D 0; files->name && files->name[0]; i++, files++) {
>> -		if (!files->name)
>> -			continue;
>> 		dentry =3D d_alloc_name(root, files->name);
>> 		if (!dentry)
>> 			goto out;
>> @@ -1290,6 +1289,8 @@ static  int nfsdfs_create_files(struct dentry *roo=
t,
>> 		inode->i_private =3D __get_nfsdfs_client(dir);
>> 		d_add(dentry, inode);
>> 		fsnotify_create(dir, dentry);
>> +		if (fdentries)
>> +			fdentries[i] =3D dentry;
>> 	}
>> 	inode_unlock(dir);
>> 	return 0;
>> @@ -1301,8 +1302,9 @@ static  int nfsdfs_create_files(struct dentry *roo=
t,
>>=20
>> /* on success, returns positive number unique to that client. */
>> struct dentry *nfsd_client_mkdir(struct nfsd_net *nn,
>> -		struct nfsdfs_client *ncl, u32 id,
>> -		const struct tree_descr *files)
>> +				 struct nfsdfs_client *ncl, u32 id,
>> +				 const struct tree_descr *files,
>> +				 struct dentry **fdentries)
>> {
>> 	struct dentry *dentry;
>> 	char name[11];
>> @@ -1313,7 +1315,7 @@ struct dentry *nfsd_client_mkdir(struct nfsd_net *=
nn,
>> 	dentry =3D nfsd_mkdir(nn->nfsd_client_dir, ncl, name);
>> 	if (IS_ERR(dentry)) /* XXX: tossing errors? */
>> 		return NULL;
>> -	ret =3D nfsdfs_create_files(dentry, files);
>> +	ret =3D nfsdfs_create_files(dentry, files, fdentries);
>> 	if (ret) {
>> 		nfsd_client_rmdir(dentry);
>> 		return NULL;
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 8bdc37aa2c2e..9aee72f65330 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -107,7 +107,9 @@ struct nfsdfs_client {
>>=20
>> struct nfsdfs_client *get_nfsdfs_client(struct inode *);
>> struct dentry *nfsd_client_mkdir(struct nfsd_net *nn,
>> -		struct nfsdfs_client *ncl, u32 id, const struct tree_descr *);
>> +				 struct nfsdfs_client *ncl, u32 id,
>> +				 const struct tree_descr *,
>> +				 struct dentry **fdentries);
>> void nfsd_client_rmdir(struct dentry *dentry);
>>=20
>>=20
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 73deea353169..54cab651ac1d 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -371,6 +371,10 @@ struct nfs4_client {
>>=20
>> 	/* debugging info directory under nfsd/clients/ : */
>> 	struct dentry		*cl_nfsd_dentry;
>> +	/* 'info' file within that directory. Ref is not counted,
>> +	 * but will remain valid iff cl_nfsd_dentry !=3D NULL
>> +	 */
>> +	struct dentry		*cl_nfsd_info_dentry;
>>=20
>> 	/* for nfs41 callbacks */
>> 	/* We currently support a single back channel with a single slot */
>> --=20
>> 2.30.1
>>=20
>=20
> --
> Chuck Lever

--
Chuck Lever



