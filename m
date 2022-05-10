Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE16D521BDD
	for <lists+linux-nfs@lfdr.de>; Tue, 10 May 2022 16:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243230AbiEJOXt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 May 2022 10:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344117AbiEJOXk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 May 2022 10:23:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A781F2E8921
        for <linux-nfs@vger.kernel.org>; Tue, 10 May 2022 06:49:15 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24ADOP65024581;
        Tue, 10 May 2022 13:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Ou+F42CmJGt4kb0Y2GXNTi7gY5mSoWRtatAP3x8MDOY=;
 b=tNOFs35j+HqkStLiKShao6cFS2ARcwNfPTAfbwwiNFiwsBVfa6NLi4wEsW9u9I7mQfUe
 dm6b7cIKP/5VjKYMGrknhN4ZhA3NPMPKq8wjWnlEnB6xth+AbbpZqdhTX+72IAGMxjq4
 uUDOqLHKtMcCbuT6s0RyiYNVMkPau2rliekEuVcoaOmdRYCQ1uv27X5oocW+0pU7RN6g
 nvNhUhrMq3Mmn22QQHrrxJ2S7oiCr7W/3/vkHvrN2XB/rKVaNLXOCSGsiMWybmucO1dj
 264G14CvuRrbgdsFH+qhFVzUQgpK9dBHEOixQ92CIN4angfcjCmoVS0va/+vzbHw+/xK LQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfc0pqyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 13:48:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24ADjaKi013796;
        Tue, 10 May 2022 13:48:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf72akkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 13:48:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVFVlQVpmdB40N61V6HIMJigsKVNEvn4T2R+ADYh8btzM9WHl33eMzU/quj7cgBqdgDlpvCxBnvkFZg2VXfax28xG4d9itg1SxgEWSgRpi0eTQ1otMfNIctiTtp77maTWXe/wg8dwngEZWPDeKoSVdtaf0+WMf1fk4Es8HG8ArSwDspthir5v6kbh50GBPcuYd2OBp6qEEMtQlkA2tpCNRUOPrAeoYCxgGCyYsWqRRx8FWIq3/r2Yln0V6xC51NWwxMhxd2gvsbnShXnjcQcVw13+vactKxmfp2vOCbYMrykz3r4z27DLPg02ZJ3mtyzTcHt3VIZfXqXpEDERzp1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ou+F42CmJGt4kb0Y2GXNTi7gY5mSoWRtatAP3x8MDOY=;
 b=bJB7kUUndSXMyaAyK0E0eblFIGlRO46KHSbxKO03cXWkEa2Z+oFeQy8uGAIwJepyOzi7pEhk3iFVtMwAnPlQWjlnKZnfhS7wq+1WTy8VXXPVPxI/mo4kRpfwKwfPPzPdprAdXJHmr9DtaaB1gPVVKV/fmUdGexarHkmrKfbiSo+pW2KIoHc4IO25gcTCkwvnobtIe8OIxU0+rUoVV+oaaN0PhZq0lDwk9fm0L6Px6G8He722lodYxCi9FYOacShU+87DtckEevb3Jv6TpZ00N4azSpu2b7w434WTNQiaOCO3+5PEW+LWdi4xCTSzsHCp+qpmfV6iXggOQqtPwBItIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou+F42CmJGt4kb0Y2GXNTi7gY5mSoWRtatAP3x8MDOY=;
 b=a6JNNPxqjIplzMpaM8mRsAHjLFfGk1tM5kfOuX7Z2GSOVrqHdGUC/pgO3YNSyKmcgcyHil3BdTv7amdoT1AqFSyNa0CIM6L9IasR3gmAlVQ8bKThaANEcnvaJ737BaIrWFFQb26geXnFsms/TnNlDpqOvqavB8Y1RnyapJ5Qt3E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MWHPR10MB1824.namprd10.prod.outlook.com (2603:10b6:300:10a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 13:48:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 13:48:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steve Dickson <steved@redhat.com>
CC:     Richard Weinberger <richard@nod.at>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        david <david@sigma-star.at>, Bruce Fields <bfields@fieldses.org>,
        "luis.turcitu@appsbroker.com" <luis.turcitu@appsbroker.com>,
        "david.young@appsbroker.com" <david.young@appsbroker.com>,
        "david.oberhollenzer@sigma-star.at" 
        <david.oberhollenzer@sigma-star.at>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "chris.chilvers@appsbroker.com" <chris.chilvers@appsbroker.com>
Subject: Re: [PATCH 1/5] Implement reexport helper library
Thread-Topic: [PATCH 1/5] Implement reexport helper library
Thread-Index: AQHYXgHgoneWG2g3iEC82B/y61YHaq0YKM4AgAAEiIA=
Date:   Tue, 10 May 2022 13:48:49 +0000
Message-ID: <1A6F1763-C95B-4678-B622-6D3300AF087E@oracle.com>
References: <20220502085045.13038-1-richard@nod.at>
 <20220502085045.13038-2-richard@nod.at>
 <f4ae288c-b7f3-25fe-ef08-7b37256771bb@redhat.com>
In-Reply-To: <f4ae288c-b7f3-25fe-ef08-7b37256771bb@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87bb8aed-e2c1-4de5-5b69-08da328bcff5
x-ms-traffictypediagnostic: MWHPR10MB1824:EE_
x-microsoft-antispam-prvs: <MWHPR10MB182414F00C5E31D93BF5989E93C99@MWHPR10MB1824.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MpH9q5ep+mWOT6IkA/nPLsBY4DvE+94EfaI9Wm02+82MIW7LaD4O3MCRy8gIujJ4wEYMkBKYiXc10E4H6iAsv/13WPlbK1c2nh8tIyYKgo/ALCheKAA2tqPJ1rfvJ0rOyhlC/fRUyqVzsmch7ZvF7oai5Fkn8MUnNgN6O1a0RhKSBZWN6X2e35pNereVYvNGG6SG25IHPzP6R5nrr8/4SSCiI/CIbNUcuN2Bu9hQYT8CyxB8XZfVPb9nyJuxMUtWp1PeoxNO4Z5iR0eAO2goRGL18tf1XE7fZCILyTUjRq4yCV3aOKnCsoSf0kyoQ7sfbkN116zeiq4FHTl4J4uuKySmvxRoDtWX0P6UDgNjIlHjVy3YF7F4iLn67gmIb3MV6PhxZ+HiNSqvQrzwAg9/uHQb4yh0ne4rHr2EFUKg5Fi4ff7suxlfKLtDeRws6PDJI0pxmslwI28WprNK29FbUMOSqQIzo6rWiRwp/cPnEy1fP5/R4UGuidxNWYj8f6D9dp3JjlJGr56LxSFGo8IihBFoCbaAYELlEKF9nQDmeDaahBscH4IoKG07eN3SxezdL4TcL2bv2JPnN0ink9kQDY9k/1SCB+yS38N+Br08RfOI0LANgGV2j2jWxCy+bltI1BYK0wJaCExBqIK6Zjo7nn8a67WiTU7i7XpJCMMeljSRQmDmlbmP09Yxa2mp5bxcWKyf8J/gSmJIAp3vuGb92KMbX0YLBUGgraXnSrhp9EZkdGoig4Zr6RILUYb8aAao
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(30864003)(6486002)(71200400001)(86362001)(8936002)(33656002)(508600001)(7416002)(5660300002)(83380400001)(38070700005)(2906002)(6506007)(6512007)(122000001)(26005)(38100700002)(2616005)(186003)(6916009)(316002)(36756003)(91956017)(54906003)(8676002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e3OHYyXeMprc61/0DTaWT7ZI/lVRPNbLwyrXasAq0ggz/4ZzUIRafaQXFCiu?=
 =?us-ascii?Q?IDspvVloDy9nE/L8tcXhsISk7mC/wX9WdG43/7NGJrqAMYCKSVzmuAU0hP4Q?=
 =?us-ascii?Q?VxvhoE0FFtmdeBcW4TEN4fWe3/bDE/97xkhYxktGq1XVL1VL7/9/xeP1vS2a?=
 =?us-ascii?Q?uFlhmlA4mGbz3Znrngrd6JHOMXZWT8kGmVe6j3ei/yX7Qi61yJZuAzIfaDr8?=
 =?us-ascii?Q?q3HLv6Yws6hkT4FX+OVhjzaF6igc9KKwnsV9W3R+LGmAc8UoJIekS7Rs1HGj?=
 =?us-ascii?Q?KQigVo7tKxL6PXj9f0vmBJtkPAFkuZ0xhj0wmrQUNDayPtI+onROFt1SCvwV?=
 =?us-ascii?Q?THgXUGi/CjPlQ2Vfaj2DHYepMFrgXn9sABXQWz3VrzlTRTeOWQbFA133lXul?=
 =?us-ascii?Q?9WND6ffz+f+F4D7VMLB0lWO6n6DIx/Wr8KDGdCsFOK5+/Ihu3YqPGX9VYIS0?=
 =?us-ascii?Q?ozPLx7k31rDuOO9Avm0TNpdu9291RnnoJN+afnoyXQ2NAcYGTuqB4Zk0DmMz?=
 =?us-ascii?Q?strTM3e95n0eHLhjv1vbxj+zUD5BtT0Oc6hCFDuuIibWgVCuqpm1I0gZ7Ayc?=
 =?us-ascii?Q?NPH83kMCP//k3I0gGoeyAdzcpiUe7WTpY5Fn+MCLfI1cYT4/LvjroEXNECP6?=
 =?us-ascii?Q?EuvrJltfkMuxjEf73Cm+HiWKK02ZJoLXuTcu+gwrzcsHBy6ae/xtE/jl3pqv?=
 =?us-ascii?Q?YT2GoK/0jAjeKqqElnDhO49rxKEI6kctMahlB19WTVYe/07QNdK1tymNauAb?=
 =?us-ascii?Q?kv4TLa95mJ0WKLoyfR4DzjXHtH2BN5xBu0huvCzYmllegQ24rrO84j4oRMg4?=
 =?us-ascii?Q?Tv4tpZuIlb5BtpPeWyrxoN+eoZRLlLJ9RiNfH0h8ugVn1d8beokt1VVGlWDp?=
 =?us-ascii?Q?ZvrSwlpGOvFKeAblX/iCCYArRNZ3qzz+VZvA6fk4UQIVvj6WcgnX316kE0Ad?=
 =?us-ascii?Q?+o2kJtGil8Zp0kqp/PpUVxyuHADzzeIn4ZUUracPtyeMUKqsqur7iJ+A6y7z?=
 =?us-ascii?Q?Vw7cStWasjHfiydxJQYFMrtM2Z+hciAm7TuVjoLOCdTzO+8Lz75ceVY0HuHA?=
 =?us-ascii?Q?bkUM/Gt3fyaXTrRniGRPw77EGV7/LV7pbzIeRJ6KsPdpNlhecKzZueb/d/JC?=
 =?us-ascii?Q?Zir21rKP+E3fC+0AtOhPxNJPV5hfn7TYXfp+fyYbeMWA95/AebAVzrQu1lR9?=
 =?us-ascii?Q?pLkgkMGLLH6Zvu65AFyj/gNqR/t4Ya55/sKiZXZ+U1ZnTOhdweGA6Tk/igU9?=
 =?us-ascii?Q?P2yfUp2+CWr6Ck99qu026o7U6SHI5GvRCyoTn6M6aMne/nXDQfD80sgPtUst?=
 =?us-ascii?Q?97CAG4t72XVAq1ktAxb+8abjVzGPGsvnMPQvBdDOd882oB6TFI5UOSqSvje2?=
 =?us-ascii?Q?9+EhAH4GCu4gXcWKC/nHqWnGRU0Zk5CmsodJavKbb4qkBRgrG8xqaYzTm9dD?=
 =?us-ascii?Q?lY2ahkuUSfrhj1dVJlw95bkj5Tmxe0AaRDamSWAvI10tzAwWq5hpZY6Xs+y8?=
 =?us-ascii?Q?Sw3VYZLt4krVlU9Yxm7r02hnjl/ctCg8hwZmwrfzVaPAQ3B//mzuT5BrOscw?=
 =?us-ascii?Q?L/c2gaurb/+39qQbq23vVNy3N4eVy7U/pO0vD25kK6++g1dnSPkbz508RtNd?=
 =?us-ascii?Q?Fzojjfmoc6HDIsm8da1ux6t3cdnzjOpEnP7YLN9RNEMH7pyWYDyw0ltxt6Iz?=
 =?us-ascii?Q?arpfve7gzpQAXx+dAMkWB9ZJwp5LjYXLHHynywA6QwsXb8ulucHsGOpOtgSL?=
 =?us-ascii?Q?0VxG3RWp/dpxHz5euuKKXSE48Yr1MWY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A841F110B7973C41AF3020DAE897F1B6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bb8aed-e2c1-4de5-5b69-08da328bcff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 13:48:49.6840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECpeIBmiVPbjK1xR+1GflXQTOgQgJ8fP/DXCJX3WKgs8po696Jw2giDtJovECcm91s62d5P2UpW5ilWLwS6a7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1824
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-10_01:2022-05-09,2022-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100063
X-Proofpoint-ORIG-GUID: iCP3SsTSDyiXq-rsuysLFDolnUX-4wfn
X-Proofpoint-GUID: iCP3SsTSDyiXq-rsuysLFDolnUX-4wfn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 10, 2022, at 9:32 AM, Steve Dickson <steved@redhat.com> wrote:
>=20
> Hello,
>=20
> On 5/2/22 4:50 AM, Richard Weinberger wrote:
>> This internal library contains code that will be used by various
>> tools within the nfs-utils package to deal better with NFS re-export,
>> especially cross mounts.
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> ---
>>  configure.ac                 |  12 ++
>>  support/Makefile.am          |   4 +
>>  support/reexport/Makefile.am |   6 +
>>  support/reexport/reexport.c  | 285 +++++++++++++++++++++++++++++++++++
>>  support/reexport/reexport.h  |  39 +++++
>>  5 files changed, 346 insertions(+)
>>  create mode 100644 support/reexport/Makefile.am
>>  create mode 100644 support/reexport/reexport.c
>>  create mode 100644 support/reexport/reexport.h
>> diff --git a/configure.ac b/configure.ac
>> index 93626d62..86bf8ba9 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -274,6 +274,17 @@ AC_ARG_ENABLE(nfsv4server,
>>  	fi
>>  	AM_CONDITIONAL(CONFIG_NFSV4SERVER, [test "$enable_nfsv4server" =3D "ye=
s" ])
>>  +AC_ARG_ENABLE(reexport,
>> +	[AC_HELP_STRING([--enable-reexport],
>> +			[enable support for re-exporting NFS mounts  @<:@default=3Dno@:>@])]=
,
>> +	enable_reexport=3D$enableval,
>> +	enable_reexport=3D"no")
>> +	if test "$enable_reexport" =3D yes; then
>> +		AC_DEFINE(HAVE_REEXPORT_SUPPORT, 1,
>> +                          [Define this if you want NFS re-export suppor=
t compiled in])
>> +	fi
>> +	AM_CONDITIONAL(CONFIG_REEXPORT, [test "$enable_reexport" =3D "yes" ])
>> +
> To get this moving I'm going to add a --disable-reexport flag

Hi Steve, no-one has given a reason why disabling support
for re-exports would be necessary. Therefore, can't this
switch just be removed?


> +AC_ARG_ENABLE(reexport,
> +       [AC_HELP_STRING([--disable-reexport],
> +                       [disable support for re-exporting NFS mounts @<:@=
default=3Dno@:>@])],
> +       enable_reexport=3D$enableval,
> +       enable_reexport=3D"yes")
> +       if test "$enable_reexport" =3D yes; then
> +               AC_DEFINE(HAVE_REEXPORT_SUPPORT, 1,
> +                          [Define this if you want NFS re-export support=
 compiled in])
> +       fi
> +       AM_CONDITIONAL(CONFIG_REEXPORT, [test "$enable_reexport" =3D "yes=
" ])
> +
>=20
> steved.
>=20
>>  dnl Check for TI-RPC library and headers
>>  AC_LIBTIRPC
>>  @@ -730,6 +741,7 @@ AC_CONFIG_FILES([
>>  	support/nsm/Makefile
>>  	support/nfsidmap/Makefile
>>  	support/nfsidmap/libnfsidmap.pc
>> +	support/reexport/Makefile
>>  	tools/Makefile
>>  	tools/locktest/Makefile
>>  	tools/nlmtest/Makefile
>> diff --git a/support/Makefile.am b/support/Makefile.am
>> index c962d4d4..986e9b5f 100644
>> --- a/support/Makefile.am
>> +++ b/support/Makefile.am
>> @@ -10,6 +10,10 @@ if CONFIG_JUNCTION
>>  OPTDIRS +=3D junction
>>  endif
>>  +if CONFIG_REEXPORT
>> +OPTDIRS +=3D reexport
>> +endif
>> +
>>  SUBDIRS =3D export include misc nfs nsm $(OPTDIRS)
>>    MAINTAINERCLEANFILES =3D Makefile.in
>> diff --git a/support/reexport/Makefile.am b/support/reexport/Makefile.am
>> new file mode 100644
>> index 00000000..9d544a8f
>> --- /dev/null
>> +++ b/support/reexport/Makefile.am
>> @@ -0,0 +1,6 @@
>> +## Process this file with automake to produce Makefile.in
>> +
>> +noinst_LIBRARIES =3D libreexport.a
>> +libreexport_a_SOURCES =3D reexport.c
>> +
>> +MAINTAINERCLEANFILES =3D Makefile.in
>> diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
>> new file mode 100644
>> index 00000000..5474a21f
>> --- /dev/null
>> +++ b/support/reexport/reexport.c
>> @@ -0,0 +1,285 @@
>> +#ifdef HAVE_CONFIG_H
>> +#include <config.h>
>> +#endif
>> +
>> +#include <sqlite3.h>
>> +#include <stdint.h>
>> +#include <stdio.h>
>> +#include <sys/random.h>
>> +#include <sys/stat.h>
>> +#include <sys/types.h>
>> +#include <sys/vfs.h>
>> +#include <unistd.h>
>> +
>> +#include "nfsd_path.h"
>> +#include "nfslib.h"
>> +#include "reexport.h"
>> +#include "xcommon.h"
>> +#include "xlog.h"
>> +
>> +#define REEXPDB_DBFILE NFS_STATEDIR "/reexpdb.sqlite3"
>> +#define REEXPDB_DBFILE_WAIT_USEC (5000)
>> +
>> +static sqlite3 *db;
>> +static int init_done;
>> +
>> +static int prng_init(void)
>> +{
>> +	int seed;
>> +
>> +	if (getrandom(&seed, sizeof(seed), 0) !=3D sizeof(seed)) {
>> +		xlog(L_ERROR, "Unable to obtain seed for PRNG via getrandom()");
>> +		return -1;
>> +	}
>> +
>> +	srand(seed);
>> +	return 0;
>> +}
>> +
>> +static void wait_for_dbaccess(void)
>> +{
>> +	usleep(REEXPDB_DBFILE_WAIT_USEC + (rand() % REEXPDB_DBFILE_WAIT_USEC))=
;
>> +}
>> +
>> +/*
>> + * reexpdb_init - Initialize reexport database
>> + */
>> +int reexpdb_init(void)
>> +{
>> +	char *sqlerr;
>> +	int ret;
>> +
>> +	if (init_done)
>> +		return 0;
>> +
>> +	if (prng_init() !=3D 0)
>> +		return -1;
>> +
>> +	ret =3D sqlite3_open_v2(REEXPDB_DBFILE, &db, SQLITE_OPEN_READWRITE | S=
QLITE_OPEN_CREATE | SQLITE_OPEN_FULLMUTEX, NULL);
>> +	if (ret !=3D SQLITE_OK) {
>> +		xlog(L_ERROR, "Unable to open reexport database: %s", sqlite3_errstr(=
ret));
>> +		return -1;
>> +	}
>> +
>> +again:
>> +	ret =3D sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS fsidnums (num INT=
EGER PRIMARY KEY CHECK (num > 0 AND num < 4294967296), path TEXT UNIQUE); C=
REATE INDEX IF NOT EXISTS idx_ids_path ON fsidnums (path);", NULL, NULL, &s=
qlerr);
>> +	switch (ret) {
>> +	case SQLITE_OK:
>> +		init_done =3D 1;
>> +		ret =3D 0;
>> +		break;
>> +	case SQLITE_BUSY:
>> +	case SQLITE_LOCKED:
>> +		wait_for_dbaccess();
>> +		goto again;
>> +	default:
>> +		xlog(L_ERROR, "Unable to init reexport database: %s", sqlite3_errstr(=
ret));
>> +		sqlite3_free(sqlerr);
>> +		sqlite3_close_v2(db);
>> +		ret =3D -1;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>> + * reexpdb_destroy - Undo reexpdb_init().
>> + */
>> +void reexpdb_destroy(void)
>> +{
>> +	if (!init_done)
>> +		return;
>> +
>> +	sqlite3_close_v2(db);
>> +}
>> +
>> +static int get_fsidnum_by_path(char *path, uint32_t *fsidnum)
>> +{
>> +	static const char fsidnum_by_path_sql[] =3D "SELECT num FROM fsidnums =
WHERE path =3D ?1;";
>> +	sqlite3_stmt *stmt =3D NULL;
>> +	int found =3D 0;
>> +	int ret;
>> +
>> +	ret =3D sqlite3_prepare_v2(db, fsidnum_by_path_sql, sizeof(fsidnum_by_=
path_sql), &stmt, NULL);
>> +	if (ret !=3D SQLITE_OK) {
>> +		xlog(L_WARNING, "Unable to prepare SQL query '%s': %s", fsidnum_by_pa=
th_sql, sqlite3_errstr(ret));
>> +		goto out;
>> +	}
>> +
>> +	ret =3D sqlite3_bind_text(stmt, 1, path, -1, NULL);
>> +	if (ret !=3D SQLITE_OK) {
>> +		xlog(L_WARNING, "Unable to bind SQL query '%s': %s", fsidnum_by_path_=
sql, sqlite3_errstr(ret));
>> +		goto out;
>> +	}
>> +
>> +again:
>> +	ret =3D sqlite3_step(stmt);
>> +	switch (ret) {
>> +	case SQLITE_ROW:
>> +		*fsidnum =3D sqlite3_column_int(stmt, 0);
>> +		found =3D 1;
>> +		break;
>> +	case SQLITE_DONE:
>> +		/* No hit */
>> +		found =3D 0;
>> +		break;
>> +	case SQLITE_BUSY:
>> +	case SQLITE_LOCKED:
>> +		wait_for_dbaccess();
>> +		goto again;
>> +	default:
>> +		xlog(L_WARNING, "Error while looking up '%s' in database: %s", path, =
sqlite3_errstr(ret));
>> +	}
>> +
>> +out:
>> +	sqlite3_finalize(stmt);
>> +	return found;
>> +}
>> +
>> +static int get_path_by_fsidnum(uint32_t fsidnum, char **path)
>> +{
>> +	static const char path_by_fsidnum_sql[] =3D "SELECT path FROM fsidnums=
 WHERE num =3D ?1;";
>> +	sqlite3_stmt *stmt =3D NULL;
>> +	int found =3D 0;
>> +	int ret;
>> +
>> +	ret =3D sqlite3_prepare_v2(db, path_by_fsidnum_sql, sizeof(path_by_fsi=
dnum_sql), &stmt, NULL);
>> +	if (ret !=3D SQLITE_OK) {
>> +		xlog(L_WARNING, "Unable to prepare SQL query '%s': %s", path_by_fsidn=
um_sql, sqlite3_errstr(ret));
>> +		goto out;
>> +	}
>> +
>> +	ret =3D sqlite3_bind_int(stmt, 1, fsidnum);
>> +	if (ret !=3D SQLITE_OK) {
>> +		xlog(L_WARNING, "Unable to bind SQL query '%s': %s", path_by_fsidnum_=
sql, sqlite3_errstr(ret));
>> +		goto out;
>> +	}
>> +
>> +again:
>> +	ret =3D sqlite3_step(stmt);
>> +	switch (ret) {
>> +	case SQLITE_ROW:
>> +		*path =3D xstrdup((char *)sqlite3_column_text(stmt, 0));
>> +		found =3D 1;
>> +		break;
>> +	case SQLITE_DONE:
>> +		/* No hit */
>> +		found =3D 0;
>> +		break;
>> +	case SQLITE_BUSY:
>> +	case SQLITE_LOCKED:
>> +		wait_for_dbaccess();
>> +		goto again;
>> +	default:
>> +		xlog(L_WARNING, "Error while looking up '%i' in database: %s", fsidnu=
m, sqlite3_errstr(ret));
>> +	}
>> +
>> +out:
>> +	sqlite3_finalize(stmt);
>> +	return found;
>> +}
>> +
>> +static int new_fsidnum_by_path(char *path, uint32_t *fsidnum)
>> +{
>> +	/*
>> +	 * This query is a little tricky. We use SQL to find and claim the sma=
llest free fsid number.
>> +	 * To find a free fsid the fsidnums is left joined to itself but with =
an offset of 1.
>> +	 * Everything after the UNION statement is to handle the corner case w=
here fsidnums
>> +	 * is empty. In this case we want 1 as first fsid number.
>> +	 */
>> +	static const char new_fsidnum_by_path_sql[] =3D "INSERT INTO fsidnums =
VALUES ((SELECT ids1.num + 1 FROM fsidnums AS ids1 LEFT JOIN fsidnums AS id=
s2 ON ids2.num =3D ids1.num + 1 WHERE ids2.num IS NULL UNION SELECT 1 WHERE=
 NOT EXISTS (SELECT NULL FROM fsidnums WHERE num =3D 1) LIMIT 1), ?1) RETUR=
NING num;";
>> +
>> +	sqlite3_stmt *stmt =3D NULL;
>> +	int found =3D 0, check =3D 0;
>> +	int ret;
>> +
>> +	ret =3D sqlite3_prepare_v2(db, new_fsidnum_by_path_sql, sizeof(new_fsi=
dnum_by_path_sql), &stmt, NULL);
>> +	if (ret !=3D SQLITE_OK) {
>> +		xlog(L_WARNING, "Unable to prepare SQL query '%s': %s", new_fsidnum_b=
y_path_sql, sqlite3_errstr(ret));
>> +		goto out;
>> +	}
>> +
>> +	ret =3D sqlite3_bind_text(stmt, 1, path, -1, NULL);
>> +	if (ret !=3D SQLITE_OK) {
>> +		xlog(L_WARNING, "Unable to bind SQL query '%s': %s", new_fsidnum_by_p=
ath_sql, sqlite3_errstr(ret));
>> +		goto out;
>> +	}
>> +
>> +again:
>> +	ret =3D sqlite3_step(stmt);
>> +	switch (ret) {
>> +	case SQLITE_ROW:
>> +		*fsidnum =3D sqlite3_column_int(stmt, 0);
>> +		found =3D 1;
>> +		break;
>> +	case SQLITE_CONSTRAINT:
>> +		/* Maybe we lost the race against another writer and the path is now =
present. */
>> +		check =3D 1;
>> +		break;
>> +	case SQLITE_BUSY:
>> +	case SQLITE_LOCKED:
>> +		wait_for_dbaccess();
>> +		goto again;
>> +	default:
>> +		xlog(L_WARNING, "Error while looking up '%s' in database: %s", path, =
sqlite3_errstr(ret));
>> +	}
>> +
>> +out:
>> +	sqlite3_finalize(stmt);
>> +
>> +	if (check) {
>> +		found =3D get_fsidnum_by_path(path, fsidnum);
>> +		if (!found)
>> +			xlog(L_WARNING, "SQLITE_CONSTRAINT error while inserting '%s' in dat=
abase", path);
>> +	}
>> +
>> +	return found;
>> +}
>> +
>> +/*
>> + * reexpdb_fsidnum_by_path - Lookup a fsid by path.
>> + *
>> + * @path: File system path used as lookup key
>> + * @fsidnum: Pointer where found fsid is written to
>> + * @may_create: If non-zero, allocate new fsid if lookup failed
>> + *
>> + */
>> +int reexpdb_fsidnum_by_path(char *path, uint32_t *fsidnum, int may_crea=
te)
>> +{
>> +	int found;
>> +
>> +	found =3D get_fsidnum_by_path(path, fsidnum);
>> +
>> +	if (!found && may_create)
>> +		found =3D new_fsidnum_by_path(path, fsidnum);
>> +
>> +	return found;
>> +}
>> +
>> +/*
>> + * reexpdb_uncover_subvolume - Make sure a subvolume is present.
>> + *
>> + * @fsidnum: Numerical fsid number to look for
>> + *
>> + * Subvolumes (NFS cross mounts) get automatically mounted upon first
>> + * access and can vanish after fs.nfs.nfs_mountpoint_timeout seconds.
>> + * Also if the NFS server reboots, clients can still have valid file
>> + * handles for such a subvolume.
>> + *
>> + * If kNFSd asks mountd for the path of a given fsidnum it can
>> + * trigger an automount by calling statfs() on the given path.
>> + */
>> +void reexpdb_uncover_subvolume(uint32_t fsidnum)
>> +{
>> +	struct statfs64 st;
>> +	char *path =3D NULL;
>> +	int ret;
>> +
>> +	if (get_path_by_fsidnum(fsidnum, &path)) {
>> +		ret =3D nfsd_path_statfs64(path, &st);
>> +		if (ret =3D=3D -1)
>> +			xlog(L_WARNING, "statfs() failed");
>> +	}
>> +
>> +	free(path);
>> +}
>> diff --git a/support/reexport/reexport.h b/support/reexport/reexport.h
>> new file mode 100644
>> index 00000000..bb6d2a1b
>> --- /dev/null
>> +++ b/support/reexport/reexport.h
>> @@ -0,0 +1,39 @@
>> +#ifndef REEXPORT_H
>> +#define REEXPORT_H
>> +
>> +enum {
>> +	REEXP_NONE =3D 0,
>> +	REEXP_AUTO_FSIDNUM,
>> +	REEXP_PREDEFINED_FSIDNUM,
>> +};
>> +
>> +#ifdef HAVE_REEXPORT_SUPPORT
>> +int reexpdb_init(void);
>> +void reexpdb_destroy(void);
>> +int reexpdb_fsidnum_by_path(char *path, uint32_t *fsidnum, int may_crea=
te);
>> +int reexpdb_apply_reexport_settings(struct exportent *ep, char *flname,=
 int flline);
>> +void reexpdb_uncover_subvolume(uint32_t fsidnum);
>> +#else
>> +static inline int reexpdb_init(void) { return 0; }
>> +static inline void reexpdb_destroy(void) {}
>> +static inline int reexpdb_fsidnum_by_path(char *path, uint32_t *fsidnum=
, int may_create)
>> +{
>> +	(void)path;
>> +	(void)may_create;
>> +	*fsidnum =3D 0;
>> +	return 0;
>> +}
>> +static inline int reexpdb_apply_reexport_settings(struct exportent *ep,=
 char *flname, int flline)
>> +{
>> +	(void)ep;
>> +	(void)flname;
>> +	(void)flline;
>> +	return 0;
>> +}
>> +static inline void reexpdb_uncover_subvolume(uint32_t fsidnum)
>> +{
>> +	(void)fsidnum;
>> +}
>> +#endif /* HAVE_REEXPORT_SUPPORT */
>> +
>> +#endif /* REEXPORT_H */
>=20

--
Chuck Lever



