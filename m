Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1E173BA52
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jun 2023 16:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjFWOhb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Jun 2023 10:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFWOh3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Jun 2023 10:37:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C149E184;
        Fri, 23 Jun 2023 07:37:24 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NAaIbj001181;
        Fri, 23 Jun 2023 14:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Aj1QssFSgRAVAsg7TbJXBM+BQSCza+IqFytzutQdKpI=;
 b=yumlPSmh6zXei2WFucwq0evOiXanxA4eEqELT1ViRHHer5U8Z7Y5eWthEOZfRYIBhn2S
 LEx67UixvK3TF1lIYywYPK+M41cLVbukZ8KVhcRPEeFbZpKuVl3FvaegmvyMyOXk5/SO
 E/EawwxeJ6+G9acg7R/9E/PoVZPybcuYMhPBqZgVoRl2O6c0ZSAVF563dw87mFCB5gTU
 iJMNUZCO8WU+WimBV4ArFguJlG3Knsu8DKfkqa+PVIE61lWrqHqzpJXd7uTQ5zboRNsn
 dEPG83ZzNVylgEow3ehzD4kHdvtV76yHvI0wXtKBuZGfdqga4CgsyK/m1fqp4BgQ+em/ BQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r938dv310-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 14:37:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35NDAgnT031878;
        Fri, 23 Jun 2023 14:37:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdc20bqxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 14:37:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSBrZ8l92upj9f+/pg5D7PPaHqgU3fA2U083UDAcIwaEn6XgRpkbFukjAiFLglQEBQkgfm6JlbiXMl3oMqjnhchTXus6a3iPcQD/h1Y/3JE64gJ6QylNQn2sXkl6nWl1fG3HXB2Ba8RrxBxqsTCtKoYj4lMnBHNmeuapwXXsnQqYq+34+/2fUwr7utp4C1KiwdjHbJIvepwCGpDdLxaWZCIMPZyexsyh1c4luV5tCTcfKc5bSDsEFecpj/MxLxOz0kzdsVV3m9WTgZxtytszRa/KTS3z00L3dR5gaUTQqkkaP0YWzmgi4VOuvXwBlx1v8GukOOySiDvA6afo3Ss3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aj1QssFSgRAVAsg7TbJXBM+BQSCza+IqFytzutQdKpI=;
 b=l1VVjzwF2q8pmKAfcXW7efrGM7PpkdqGIRpfdAXUYpJZyEuaqqkq7+YGocG6HQp6G+kiDCAOvTesNS3gmAfkigbOrE3nBjb3JMe3G3j/RwsvEkw4cD6HfNBVTQhjgYfdqc2fElPXtSclnsD1cX6/kjR7F9HirycHj5UmnKtVU2m0qrpYyoOyBOE9tLl8SpuFK7t8xXZQ6ufEPx/4CdLZdn2Z/6F9HKgbZ53IfjUI5MgvLl+YklkAod/68V98D11d9Pc2OygRg8AFr/TXX6MAD9jhIPsTrJOEWzEikE7Vx0UsDC6vWoOb865qOEFAyGR58k8FS3OXl+VP/dIpW+gBbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aj1QssFSgRAVAsg7TbJXBM+BQSCza+IqFytzutQdKpI=;
 b=r67ssRlVbjd167fRnBbzbj09EgKJFEA4Lon7OYpigPifYBKCHerT49dYOiXloFFMKoQ9R1m1aWN4WQ7R17jhpRDA9Dl1DzpwLDD85/xfVSfF/pxN++m9nQ6RSIhiZCuUzoQiIfAqK7XcU4F7i+h0a67zCMg3Z2T/gI8dYjA285E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4340.namprd10.prod.outlook.com (2603:10b6:a03:210::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 14:37:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 14:37:17 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tejun Heo <tj@kernel.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: contention on pwq->pool->lock under heavy NFS workload
Thread-Topic: contention on pwq->pool->lock under heavy NFS workload
Thread-Index: AQHZpFS9Q4z69UfUdkyWw4ptMMUQRK+VxgUAgAEyXACAAD0DAIAABE6AgAE+A4A=
Date:   Fri, 23 Jun 2023 14:37:17 +0000
Message-ID: <7E9EF026-EF8B-4125-AB00-A1E9F0F907C5@oracle.com>
References: <38FA0353-5303-4A3D-86A5-EF1E989CD497@oracle.com>
 <ZJNrht3NlLyPn2A0@slm.duckdns.org>
 <CF5AF0E6-5213-489D-87CD-8E8325A6560F@oracle.com>
 <ZJSfsvFtC_d265M1@slm.duckdns.org>
 <36C8F75A-7C84-4D86-A721-6BCD6001CAFF@oracle.com>
In-Reply-To: <36C8F75A-7C84-4D86-A721-6BCD6001CAFF@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4340:EE_
x-ms-office365-filtering-correlation-id: e0bd5b80-7f15-4cbe-6617-08db73f7582f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oHUV2crHHwu1cH2sOmelkI0+YQSzpYrNKlTgbU5xLN1r1+vxxBJoOlfKYH0Z97a8chQACf46mm1K0xHruvKsucUDRl4bkhlNSVrMRGH5JXXguz+2Rh+L/mPTeaRQhQvps2vx9a4Grb3RmoMGWDuANWfDrVDQMKu1YUXOwGGStTUSzIEisWfk7eK9UvgM4Qgbiwq7o7tcNG0p+SqBc+QsUc2mocCPS+Wsowfm0TcOqzqH7Y1BCc76RzXhdJNGG0WP6Pw6dt2RMFKOMY6xUAhm/iLkeXdSjCFFxh09GYcNJQ56AyiDSePfeJbJAIDq6IqWH7lUUW43Nlwgns5OgW+pVXWpXh600wfaD/8ykTDW2Y0zTit2nAnIojamNF/LtPCuQd0uGBv1hSGcuPoTEk2xzWOotXw111NkkZsi8JTU5UpclGiSYYMMnhq2QjWBXv3M30NGcmX8i2d4RasFMZzehKdiw37tTcKz5FcXRsvIUJ+AAjqXrlhCBfagW4zquaFxedmgKvwpehEpxu2vhpvXgZY8Oe+yi85aBlsyXrM6XGI6ZqLBWvjCx2+3KXxZW8T2etjeEzpixMOX+HvqBubMq9aHkZ7mEmCAM9HeKsGWFL2uuZsMZuPuWO9piwjTiDhpNmAYbwgLlpPY45vtWgmyLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(316002)(83380400001)(41300700001)(8676002)(8936002)(2616005)(186003)(38070700005)(122000001)(38100700002)(6506007)(53546011)(6512007)(26005)(71200400001)(54906003)(6486002)(478600001)(36756003)(76116006)(91956017)(66446008)(86362001)(66946007)(4326008)(64756008)(66556008)(6916009)(66476007)(33656002)(2906002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZcTkbGrRNsAaYg8uUXTVVfARixNf/1l7SW4knsgYn6Q42rjrLjLj+2+NMWiI?=
 =?us-ascii?Q?A4ENjS7qwSAn1sIlzsD8qXNDlIw3149igWYBssO9wa1nQSowWSkyEmAdpmh2?=
 =?us-ascii?Q?/a9KMkChY3hETb1lmdFLDCzxdNUj3eGZbZa5ngqOZlFHYWVmKvvvtzUmK//A?=
 =?us-ascii?Q?2o5LfvMG65PckXYDiu+aUF/d2LUc027d7YcHU9ZWySqmS9P3Q5oTm+oWV1CX?=
 =?us-ascii?Q?FpEe7aQlTB+r6bTP2DYM92Z5HmjpwOQNH3XjWPDAayEwyG0OFdSLRbnF0LiV?=
 =?us-ascii?Q?TsyelmIa8Wm6MiaT2Gw+2+Nnre9fTxXB9cPYuiG/04xCy9+Clj3gJXp7jjP2?=
 =?us-ascii?Q?/Pri1W3jghWvnYO+vtHuZj2W9GY8dwBkBF+du9XLT5+6hTIQZ5NR0/FNBxeO?=
 =?us-ascii?Q?d1vyCrA7JrfNhnclH7JPMo7qKAA2zM0P3rjh7UVL2xwrYw8htMs7TYAIn5VL?=
 =?us-ascii?Q?Ll2QTZqMszbSMSwGWVtDDNfVhEM2LNDOwrsy9XzY+F/XZj9/ArnJbRun2P8/?=
 =?us-ascii?Q?xFGP1bEqYDYnSnjyFituecmGwOJRhYmfEMgDswYgAq2mJjhMnjiXcEK3ro2E?=
 =?us-ascii?Q?6wkiSZL3t4cGEUKie4OGJ1NJATn0+0Ri0NTwpoew+kSxe8VF0Nz4XmrIzAse?=
 =?us-ascii?Q?b8OFzrPjCtf0P0rX5A/5m1neXR5jymVE+yrOM3GU6sW7QDdZDnRYqdz7gjli?=
 =?us-ascii?Q?qdHTryphibCJ89dbHcJ+DLmOQYogONf3Et/45xpFxsYpuFpKq15+DG5/TX91?=
 =?us-ascii?Q?ssfG2qRxnod5joYecj2uoFOrW9r4Z5k4prgyiQNcDOYPp4hvZ5A+x4YMm8BY?=
 =?us-ascii?Q?cNM8+m164gcuP/9ZjwC3R6uBFv8Jq+It3p4xQqEOITtRmNeCDG78K/erPptQ?=
 =?us-ascii?Q?PsZE4ztE4e6CVsL0RoB8IExyUeDrvulWDjmUkdRVJa1fVlStg49L3pUXI44v?=
 =?us-ascii?Q?1zp6Gh6iSyu70im8ft29p6KcBLEcmupe/jbIBRPNT3WBNVSawdrZQxRfUi63?=
 =?us-ascii?Q?cgJvnjHRy8beaa3SeLNvMe3Fr0yqpQT8cu6PM+b9vt8/Ly/zE1mmTqucyk91?=
 =?us-ascii?Q?1eghWfHIV2dT4DWwYH9VJ2C1H8yOfvGHm94Li/Ls3m3kA3WLMLfdtOiuWmaa?=
 =?us-ascii?Q?OTWpx8XXYQMTPcnR45R5HjHRKjkrp5rIUPpWfUU6RcmtyH9kf+GrW0dIJSg1?=
 =?us-ascii?Q?oAeg0ub3U7QLCkLtBmIMD11wCaaKizJWTGxubaaMvLSo2z0LIA5upYC/ISH3?=
 =?us-ascii?Q?IJRTVgqnxFrogvUmpu+ox5/2vkcoVuYwpPW5RpVTmMWZLc36ZYOWQ7VfBVGS?=
 =?us-ascii?Q?wPTVNXGA7ciyBe6/p44Jg5OSzeJ7rFqffc6Bf8wh3CGiyd5vr7Xhsa4Q+Ff5?=
 =?us-ascii?Q?E+8KtLdCeXOlihvKuMSTymon5416EE++XTPhyWRxkkkEN8DXdZTGaqfLo9rb?=
 =?us-ascii?Q?on/sZXjbUIq5E25aM09nSOUpT1XI8hMFQAPiDMwYTJ3Pcht40FfSyuKRA1hK?=
 =?us-ascii?Q?lb/7GMJ2Fvcbr/bbUeVf7vAfgOw1LmWWWzBRC5MHxNl8LLppqFIuA3xxmx3y?=
 =?us-ascii?Q?IT3IJwP1W24u2/H528OAMLiP01X1j2uus7opGwI9wCc1VeQvjqPdkrwFIRzg?=
 =?us-ascii?Q?7w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D9D795724858D4F847107211A0BBEE1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZxGNCb7tKup8hGAHUWygpDRho8HHDQV/24m/dLDzzUPJab3AMjd2prrlatnj4AF7mb6P2o3pHBZLRVHjZyteZCFT4qgi4n7a1RzfmuecDsxrdak/WP79PxgyXQGOEYx2vmLSoas9D7937p80KLxLp2QrFIHN7gNpqt7rWsCYS8+zD7v4wjYbN1vjxssd2Hywe2+28WeH5boV/80cLXy/NX4gzDeC9y+wh43RXfvfJWQwZ7J7uVOgkP/pirlO8DusyVDuSwG/grAdr00sQc8k5ZLBqxdLISvhmiT4EcLuE4h8YkZyoCbKqNqeE6g1r0C10gMj6+3Hhj+NVqTB9ZIiLhpvKv83J93oG4oM3ylnC5mXg9YlakgDf0TsLdYV1WbOnpqpwh5YVDV4HieIkJAZQ+JztDMIlo9Z0IdUvk18p9Bt6L56lfXxHSYR+nhwBGsfo8rnm+KmMceBSrN5OLADLf2/zNbhyPrspWeMwRVSIiZMsZnAhqGZ871Pndqe+IIAbSpTxfGLlKhwW/pifMUALzuCYAOt12b4NV32FjUWcPcdYXhJALS6OkZIIX9nb6qovhkFLgmdy4fkcNLr5T1F7DLhKyZyfBshj6VAN1xNAF444/jmDDdl0TM6VSM0u+/jgUGYtrzq/mQToXgQESpX8N5J5Ai1sNjbh/5prLAGkbW2DbYBoNs1DOWmHSCvVNyuHKOZg+U5RiNTmFHagBXW7WmYz2I1aYJDSRq+R4pYnBI+pRRc6sB704G5qwiEEnox06xIub9/ZnDExIPABB2Am2jHjxJA5Yhk9/XIdvxq+4c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bd5b80-7f15-4cbe-6617-08db73f7582f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 14:37:17.6453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1k8ynWH+0+2iUxB8mbns5GieriAOXmf1DfP0LsaGtrxk+Oef+mDu70/Xde/kSFjTuF32uoZQrQ7HfhjRibvnYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4340
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230131
X-Proofpoint-GUID: nUlxRGcgS2lLH7x8BhywTWyA-NTUXS6n
X-Proofpoint-ORIG-GUID: nUlxRGcgS2lLH7x8BhywTWyA-NTUXS6n
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 22, 2023, at 3:39 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>=20
>=20
>> On Jun 22, 2023, at 3:23 PM, Tejun Heo <tj@kernel.org> wrote:
>>=20
>> Hello,
>>=20
>> On Thu, Jun 22, 2023 at 03:45:18PM +0000, Chuck Lever III wrote:
>>> The good news:
>>>=20
>>> On stock 6.4-rc7:
>>>=20
>>> fio 8k [r=3D108k,w=3D46.9k IOPS]
>>>=20
>>> On the affinity-scopes-v2 branch (with no other tuning):
>>>=20
>>> fio 8k [r=3D130k,w=3D55.9k IOPS]
>>=20
>> Ah, okay, that's probably coming from per-cpu pwq. Didn't expect that to
>> make that much difference but that's nice.
>=20
> "cpu" and "smt" work equally well on this system.
>=20
> "cache", "numa", and "system" work equally poorly.
>=20
> I have HT disabled, and there's only one NUMA node, so
> the difference here is plausible.
>=20
>=20
>>> The bad news:
>>>=20
>>> pool->lock is still the hottest lock on the system during the test.
>>>=20
>>> I'll try some of the alternate scope settings this afternoon.
>>=20
>> Yeah, in your system, there's still gonna be one pool shared across all
>> CPUs. SMT or CPU may behave better but it might make sense to add a way =
to
>> further segment the scope so that e.g. one can split a cache domain N-wa=
ys.
>=20
> If there could be more than one pool to choose from, then these
> WQs would not be hitting the same lock. Alternately, finding a
> lockless way to queue the work on a pool would be a huge win.

Following up with a few more tests.

I'm using NFS/RDMA for my test because I can drive more IOPS with it.

I've found that setting the nfsiod and rpciod workqueues to "cpu"
scope provide the best benefit for this workload. Changing the
xprtiod workqueue to "cpu" had no discernible effect.

This tracks with the number of queue_work calls for each of these
WQs. 59% of queue_work calls during the test are for the rpciod
WQ, 21% are for nfsiod, and 2% is for xprtiod.


The same test with TCP (using IP-over-IB on the same physical network)
shows no improvement on any test. That suggests there is a bottleneck
somewhere else, when using TCP, that limits its throughput.


--
Chuck Lever


