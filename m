Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B2F357538
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Apr 2021 21:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355759AbhDGTwr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Apr 2021 15:52:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59372 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345660AbhDGTwq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Apr 2021 15:52:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 137JmmgN126748;
        Wed, 7 Apr 2021 19:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=8wdRQDL6xODEe1nn+1/+3RfLYozs9WRtyRrcPVtJLOo=;
 b=YWq8HDjiMIwVPU8lY4SHgqgi7RxPHf15FXv+UXDCyuwkFMtY/2uFKbN7QYyYat1MWR7s
 vklsq8cB80OHkTdvwvpAG2MHqJgQCqvrWC5tHF7WFQvspwuXpo2slGVTmvf/Qfhw0jKg
 PvJ/MOxB57CsT2QL7jVIEBbWtRJXrf11JDVox8TeosdSa7ThpFmaP+52dsEW78IJFRRR
 fSbv14QOv44r34PmjhkKx2w/U4mAMZEDIn1wzUyKm1llPs6P46EEBn5NoD+idcLx20TU
 lU9n2rMIj8YkSlquweGVdURR1LYBEnLrsBDM8kzDsXuGRuKrnKX1RGllHtUeXXQwlys9 5w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37rvas3swu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 19:52:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 137JnxlA090686;
        Wed, 7 Apr 2021 19:52:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3030.oracle.com with ESMTP id 37rvbet3qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 19:52:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8gw00kOlvUbNY31rejH2B+SUX7whspCBAe718cgj1KEmopGepqCSWJWCdIP+0NbGayt/1P6wY0eHzBF80vzMqSONs/UKXB1/NI4kIGY5CXthGr1BPvqHR6Zaf0ItE4094JtQrrtG7+fLboTDsVdjXM06EeQatNJ/PNcl8GPmmGDNOibiIX5sPkifPpRNXOWgk/uAu08cWr3Cn8v7GQzyvLxjpbv7Aq/kFlRD9jhcVPFDJt1Q3x4eZKANThk4gqkWHJXzudXu0C+KFno3ieN8BmaBdXrwsQX9zEijHcQ4YrcOuoFkdQUwhd3PShaaAApYHeP9VribIQ3x6cYLmvBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wdRQDL6xODEe1nn+1/+3RfLYozs9WRtyRrcPVtJLOo=;
 b=lzLTwdvIcsAmdionoK0UG1oj/ETvS3vcMxyhMqLgIZoPMpVBeImsSlZrDqUJffWvrYvuSKuBHDDbrIRGwo51of50xgOOxwXD5NZEAyBYMW/v5CtEbOL4We37e31CYaO0Pt6IqdlLTLqeCwtKxO2SajTTfXuKaL+AkNNQym8QCRmabkYY9UmvcWHufIJ/ucrnwHttQBSQAeQeDz/tEWgEQHYR/J7YxgInWtRurmUalrMkGh8oD7Bqlt5Bl7cog6grM4FY1ejmeJnZSpFd3oMqryYv4G5bgF3Ox00mH72Cn7BMmkZSOn95LgGllEPSB0690lcTxWghM6bBwFsCgzw2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wdRQDL6xODEe1nn+1/+3RfLYozs9WRtyRrcPVtJLOo=;
 b=BFELtdJJYzx9qzq7kZaYgt96cuX0EAJaIZu+mXV4iEwLE4I3WzIJZreSXhqWzI8Fzcba1bnMjoO8pcY+oeqioNKU1IEfBfo378X2R+lwlrQZZnkeb7V7r5HxeFUewAfDLCvfxDlNSMh4X0ncPhfIvDRloli7XSD3LqJ4UJkO9fY=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3045.namprd10.prod.outlook.com (2603:10b6:a03:86::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Wed, 7 Apr
 2021 19:52:33 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 19:52:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steve Dickson <SteveD@RedHat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS server should enable RDMA by default
Thread-Topic: [PATCH] NFS server should enable RDMA by default
Thread-Index: AQHXK7iPajJcb3y5kkW1TNK2+G2GgaqpdEuAgAADXAA=
Date:   Wed, 7 Apr 2021 19:52:32 +0000
Message-ID: <7E7345D0-7C8E-454A-AE60-A1187A203B6E@oracle.com>
References: <20210407141810.33710-1-steved@redhat.com>
 <9ae5a73c-7435-471b-a14b-e673bdf77c14@RedHat.com>
In-Reply-To: <9ae5a73c-7435-471b-a14b-e673bdf77c14@RedHat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: RedHat.com; dkim=none (message not signed)
 header.d=none;RedHat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5358153-ee25-41ca-b855-08d8f9feaf3c
x-ms-traffictypediagnostic: BYAPR10MB3045:
x-microsoft-antispam-prvs: <BYAPR10MB3045D5C285E01F2E606CFFE493759@BYAPR10MB3045.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iAgEsAsFY2QjKDd0zwLuiXzU4nTgibL5pT3PrUDV8bYTDOLHPFNMVQOv8DqYM+qtq2CrBK8ypN7LXGoH78i2Rl218kqC9U6adQUIP4yntnYiQnsU3Em+aUPWJpIxcbi+4FSt1EkBCvPtMQXz5KsH372Jr0xpf4MV/gpSeZAuK3Pm/iEj6oUHg3+l1aU0UZC0vsAG7+tOseqSFXf3A4fmwZNTcNWYz71cUgKDubKNJ4Mts5li+zNNlEjw8LsjgBaV1BpuAbVOJzwnVNXc/YjgeKCbfu25y/xosz3PVX1batF74qwVhjg/jjNb8SxtJqCe7Qy7vccuOAoJxRsZwaGCqemgwpqK9ns1aF7UeipwnPF15v7lyZrSv7ySVK/RtqEw5lJfEO8areIdMMUDApVCafTL+PQMQtgfiTF0QzfO8z3hRpPt+BaS+Mcy4fz22cj+rn4mopclK1l2FfvgJaqhtiNXyOwxigjp0wxi2An+lY0lFugaEzPiTMAk1e3pBdA58Y+YKLd8Z2Yt1oGIZHn/MEq2s8vg0eH4wLDg0L0ZJ61o1axuQYJ6iQK+S9W+HLQqt5hUdxWw76wsEQ+JVIu3EO+ggLOXSx6J9cPyuVvn4/GBTTD7hlZy5Y74CD041DXfbA6vRGEtZ6+YE2mAR3gd/aoD/qIDBVSqfG6/xGDkNnljmFAY7r3h3cSmcr/bb0jD0+0iXBi87hv5qmirdkaE7Pp69Eq0NTwP32c2ddkQjLZ1x/ukLftDFH6PglK3LlrERUdsQDvxTG8HnhIloSQ7UA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39860400002)(8936002)(66476007)(66556008)(66946007)(66446008)(2616005)(64756008)(6506007)(86362001)(71200400001)(966005)(316002)(4326008)(91956017)(6486002)(76116006)(6512007)(8676002)(5660300002)(83380400001)(478600001)(36756003)(6916009)(33656002)(2906002)(4744005)(38100700001)(186003)(26005)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sBNJfEuVKNFgarPfUxBzJN1GgSVR1uOYCu9C7UOtxowp5c0pb8oNZYPZ+oBs?=
 =?us-ascii?Q?Yrxi9CL+v8xUGwzTeWqwikQj0ozdgnSu3XnK08h37oFaZEQW8DGEZysX5dvf?=
 =?us-ascii?Q?OklaGuHcCd1Z50JkSf1PFLvKrnGvHJ1kMAvjZJwVpNlD6BUmq3vIpqyFb1gf?=
 =?us-ascii?Q?Yga5BNc8Q6PxJo272p31pADlwDnn8B9PBgufJK5/LtZ4xgZK1MN60t1k6bmf?=
 =?us-ascii?Q?usiwB8BYsgw3a0vWBht5FeYYP3ZpzhKxuVeyGrRfe9EhDVR4NwGxqCcZB02Y?=
 =?us-ascii?Q?raveLlRxXVusNUHrN48lplh5VI2HPekGUUZSKnXvLLqUB3ym6c42GKtuV8gD?=
 =?us-ascii?Q?dy8t6NpoFvQgP0c6AJx7USIj6ZJeBVJYAGYpoikSlkS+XOf2b8sG1iqKyy4S?=
 =?us-ascii?Q?Gwa8hDBLYEOgP3lSHJkSw5j7DogXIF6CgDP7+G1Lhy7S7+//1SSorT8ZPR0Z?=
 =?us-ascii?Q?fTRZ7PhiCaut2m2Dz57LcF+aYXAH5zLeW+0Kml6RoPgzSg6qdy9jcRhd5WTV?=
 =?us-ascii?Q?uwaIygbhSjMiJP3XJ1vgCzbysu4wOrxsnTLuN1ixzsuA+UdDySTYziR7ORGn?=
 =?us-ascii?Q?Bc0N0H98jZFjkM5knBu3C6MiSoKY8QtgDYY1Mz+59q1xeT5GuztMIJdL/ZdM?=
 =?us-ascii?Q?1+F6a56Kz5BtWoDpq9K8Nn31rSlusWN2WPuq+6W8R2ySJ3t1Xm3/WFNbXtL/?=
 =?us-ascii?Q?lVrIugWlKySG6iqOKJkeGSlVSEXgG8nQ6xwsE19HfEMH64xEiYozESERvWsG?=
 =?us-ascii?Q?T35zeugtIRyH3gepVtUW/JTFf5ZH16V/qTzZbFtRnnxxkldCQypQ3HcydLbL?=
 =?us-ascii?Q?hVVM1yPLLXX+JEAUFRAzHY2BIgsHS7k9huwOI7VeUDKa86irVE2FDhJCC8G6?=
 =?us-ascii?Q?OeZF2Pr95NhLqlNWtzCtbb0pJtE/cuTWLGtWKiTRzDxbQtJyno3lcfh3aJFD?=
 =?us-ascii?Q?RRxT67ffEnX6lezCOJZ2oMRax0aM1+DNAbNFPpwYK0aG6k7JFXWiFgO41Mzw?=
 =?us-ascii?Q?HnRXvUO09Ylna3Bb7/RoicuBiC06tOWWfsiRUBorWImBqy5dj+gXzKYI/icG?=
 =?us-ascii?Q?1GgK3k9ZYORQnYzHco0uyuNP6j5KF+PXD2+giWAayzlqzCy+Z4kVzRTlJlPM?=
 =?us-ascii?Q?+NAJjbOvFgNjZz3sJPibLpyZqwxl1KuvnxnpuMtUWCfgb/ggH4ad5YLNjauH?=
 =?us-ascii?Q?WGDvWZIdnvSTtXoNQ5dXo/XHMKyuCPvdhtyh4pwIpVgelyNp2lGOMVZHmqYn?=
 =?us-ascii?Q?Z2jRC1T/Z6CA7/C/o5A/8gkEOr7JwsfmdGNvmZ/UsfY4xyGHumKbQHftgIqN?=
 =?us-ascii?Q?Q0pdEiCE9wNjbG3fz2ZQUnxQ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DCFCF84F2641A64399A4995BC93630A5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5358153-ee25-41ca-b855-08d8f9feaf3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 19:52:32.9170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7fCQtiPI3b+vdq64fxbRaiU98UjdSp3fBzVnFNM0tft5TikKM9xIuStn78ySqZugi0PhgF6zu0ALt1WMHEgf0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3045
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070138
X-Proofpoint-GUID: Gg0TvOZ2LsYaQgTBR1y-XKyeieIbgEzP
X-Proofpoint-ORIG-GUID: Gg0TvOZ2LsYaQgTBR1y-XKyeieIbgEzP
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070138
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 7, 2021, at 3:40 PM, Steve Dickson <SteveD@RedHat.com> wrote:
>=20
>=20
>=20
> On 4/7/21 10:18 AM, Steve Dickson wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> Product is shipped with NFS/RDMA disabled by default.
>> An extra step is needed when setting up an NFS server
>> to support NFS/RDMA clients.
>>=20
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1931565
>>=20
>> Signed-off-by: Steve Dickson <steved@redhat.com>
> Committed... (tag: nfs-utils-2-5-4-rc2)

Hi Steve, thank you for pushing this forward!


> steved.
>> ---
>> nfs.conf | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/nfs.conf b/nfs.conf
>> index 9042d27d..31994f61 100644
>> --- a/nfs.conf
>> +++ b/nfs.conf
>> @@ -72,9 +72,9 @@
>> # vers4.0=3Dy
>> # vers4.1=3Dy
>> # vers4.2=3Dy
>> -# rdma=3Dn
>> -# rdma-port=3D20049
>> -#
>> +rdma=3Dy
>> +rdma-port=3D20049
>> +
>> [statd]
>> # debug=3D0
>> # port=3D0
>>=20
>=20

--
Chuck Lever



