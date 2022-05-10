Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AD0521D30
	for <lists+linux-nfs@lfdr.de>; Tue, 10 May 2022 16:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbiEJO5y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 May 2022 10:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345547AbiEJO4k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 May 2022 10:56:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A23E281372
        for <linux-nfs@vger.kernel.org>; Tue, 10 May 2022 07:17:40 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24ADKZqX027467;
        Tue, 10 May 2022 14:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=u2QsW/Gyj3VDBoeAIoX2h2f2qv5UvUedOZRJ5qZL53I=;
 b=MKjDIg8yCQA8sHVB/Hd9HBXAaWER9AxR0uxzqfC3vKoN9PHrbGg+q8Duc1wvcEhThFCt
 pSS8GjsYHWeHuKvDIpIuEXxaMCZNi2SQhEVH8VGTzmXW4JysQEM/IXemjXmU6G8imbqZ
 ZLRvmkDGu8dXVi2NBR+akugwK28IbntMMYVvI+/eOM9VoMBmLSsxiBOgkT1dT+zrpp/I
 kWF9L3zgDAVX1D7/y9H9mufMj/+3oejOHc4+j/CvvK4n5zBVcuDTrYuUD+qv5yxNsKkt
 FCvmQdZb7hQw3ub/7eKE19ZG/F5yjdYf+elysdC3AhqDPBCYb9LW64TQQ6MbmS/s8dfO 6Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfj2ew9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 14:17:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24AEGHB7036296;
        Tue, 10 May 2022 14:17:23 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf72vdy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 14:17:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbPpulkIqTBPTalRBGtCjMKlDQO/mKFo+oBzh9SHfnKP2kSKK09yj8jku+KCtduZS6EIDBHLQnDqbLzBGpsjK+m//1z7w5lchPYqB+TEr9mKiOTWeiM9AWONqTwrMgTbI4y2U2ek4Ff64syC89hs1jsI3iE58t685MrlXnmGK23aIkAmuJ2UyMkO6/GV3JdsUtN8Vkiy8Gi2OWmq96gCHoP6zsLLG0obnn/gOJqr+ENLHWx1F3KXp0qqhRhgzXvr9kFvyHFTG2LQg4ux1PwPV2dtE+0VZFqvIGM5d1QEMkLGO4VHlR+4Bpw62CTHew646xFPS/4ZGMlrBI56RHOFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2QsW/Gyj3VDBoeAIoX2h2f2qv5UvUedOZRJ5qZL53I=;
 b=Ro52yzD6wWKfkOCj77ImlTVnkeOTVUn33rxeqnLknu0cmeHZfGdk35XsKujUIlA8WzW2yCMJel+luwTUKE+UNViK6kD2ruoFvCyyy58AauyklfgZF/buEdmMQTjpK997LCPvnG2a+/IZ267m7uwZw3/nXA4Mi0BC0Nk1OF/5ZagfXTR+fgAK6lmgOsCpgbVRwF7clvbYf2xqIBwyQYr7bTUuHW2h3KfJjLWALV1ljqhS+l1mf1kmHCys4ylVDFIjeflouj0kPVqm0EbSgYW1rrZV3otyC4pBDZy1TNN3v+ShOgKdE83z4MJUN9HMnHS0xsfhfkclEr+oDzQRKYbk2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2QsW/Gyj3VDBoeAIoX2h2f2qv5UvUedOZRJ5qZL53I=;
 b=I+Ui7khKu2HgQo0WlVVpbnOdC4gW3/0JhK6XvoFweggj/SJsMKPXOW5ri8gZBsObzTqonzSY9vs3IvNBsx34u1AN3lgZXs6OSe1vFFBQG3vS6ZU6AeB/niKCz6nmGpncp0/8Y5Ff8spTGnvjye6for1RbkP49snJjXyQO/y1Fag=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5740.namprd10.prod.outlook.com (2603:10b6:303:19a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 10 May
 2022 14:17:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 14:17:21 +0000
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
Thread-Index: AQHYXgHgoneWG2g3iEC82B/y61YHaq0YKM4AgAAEiICAAARAAIAAA7gA
Date:   Tue, 10 May 2022 14:17:21 +0000
Message-ID: <650BB9E2-7CBD-4A38-92AD-C2AC82DDBD8C@oracle.com>
References: <20220502085045.13038-1-richard@nod.at>
 <20220502085045.13038-2-richard@nod.at>
 <f4ae288c-b7f3-25fe-ef08-7b37256771bb@redhat.com>
 <1A6F1763-C95B-4678-B622-6D3300AF087E@oracle.com>
 <fe2ecc50-4036-2922-28d6-e2f139408961@redhat.com>
In-Reply-To: <fe2ecc50-4036-2922-28d6-e2f139408961@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c40a588-0c81-4503-a694-08da328fcc14
x-ms-traffictypediagnostic: MW5PR10MB5740:EE_
x-microsoft-antispam-prvs: <MW5PR10MB57400970AC121BA9E854810D93C99@MW5PR10MB5740.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xLNzBJGry96BrBXD8Ac3PwUj2jMJ5avZxOzmi3qzu0+aBIakXgzUie8Yti02HO07qPkKlPLWt/Ljj6vQlKx9xcuR3g3PGhyQahwuV0A5Wd7GX0cDWgxBOR1j9oRGWQ3N+uaBjEqXVqUUXZpe6ZE+IloCvsmsaDn+Gzdt2eLhAhTpGK0vrR+C5UWM/KZSFxhp+I54iL/ztwjt8rd/clOV0PYHrAgi8Y0plioTLml14s03IkAFrBLgi/0GkUy9G8Zqo/x4nQrtxUfC5hJNxcHmb+B7vaWhMxUFi2a5PRSoaLXLWhJ43HbEKKpXot7ztiTlF7x3677VXb2JaPa45ohzk0cyFVnNJvVlvSW7375VYhYVBqOxzIwiPrF/vk4E3KohDe7wBRhA1krRAc/XUJlh4I1yZoj8INPfYdxMyYtPZtpSCCiNu8xHpRcFoXzaGBy9Q5HA2Vx7ESOHscpkJTdMGxYZwRqfOr0VNYHpaV69LuVrCWklVlXbcXLUPTJqd4hvr85+0CUayEDwrYUZR99vtn+NCsRj0W3iWK9zpGuU546+3FOD1qDchghjHRcazo0Pry1zLDhwEThs0WuKmeDAGOmiQNnYIRRRsRAGq0/JXf7ESj9G4XwxnsccBOiN/utuEQ2ufRY/+NXscu9QssMo90Gu4jpbGB6WhMxZJyjlVeiyVozMDWN6AxMiGJOhxR7wgbEMdaG1kluyhjKZNRKXvHVDC/Y3zLy63brEnbIorGpvgYj7TimI2+24nPYlmRkoKjxVhRpIFE64df4O8WgGIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(66556008)(66476007)(64756008)(66946007)(8676002)(4326008)(508600001)(91956017)(5660300002)(76116006)(71200400001)(86362001)(316002)(54906003)(6916009)(66446008)(6506007)(26005)(38070700005)(53546011)(38100700002)(2616005)(83380400001)(122000001)(33656002)(186003)(7416002)(36756003)(8936002)(2906002)(30864003)(6512007)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TKcdK25JYAt8idYfD+Yfr2mYSecUMe9dkNAC0NvB8UWWUlhlNEoaQ+LfKoUi?=
 =?us-ascii?Q?WKxsvhpJi2sdUKbs0gWN4NJrCMwpf0G704KWsAGiimhgWcCZbNhsjaRR/Sfs?=
 =?us-ascii?Q?IqtErss10qVW4F94tWyt0Gu2S0uXc9wWQ1C5o0dv8wUsYf3qH6Q9gYPUqD4o?=
 =?us-ascii?Q?JJc7Jxc5P9bU4HIsK9H7we04ulgQicR82k59ybnnx0xUtKpY4VzUFrN3D831?=
 =?us-ascii?Q?uYFSqRhC+NwdUgc+WAw4IqZ7UioH7s8lAadAk+ElbQKSyBlMGICSvTI1W1/4?=
 =?us-ascii?Q?ZhppDQk8f1iRaEBPpN/lU/Y1b5q7eQ+DOFciyEuOzFQW9N3qmQTo7lLKAl39?=
 =?us-ascii?Q?A4WOQKFQzQIN/FsizS9akpbC8bJ9opsZ7+7YBoXen41NwJRmoxCIuvMhFA17?=
 =?us-ascii?Q?cKmnGCpmWqK/ON+ktIiyet++5VSS5I4Cj3DQNZweHJr3z29b1a7yTNo3eqWF?=
 =?us-ascii?Q?jr++3ecQQiGIezxDp4ALA1ke6rFm3NjRH4TOmF+o+AvZ+k2L4+nBPDcEr3Fi?=
 =?us-ascii?Q?Qj4VJ6cREL4kfB/34LI5jCvY+v68y9gJdohe+dlYISvNUwQ+D+1Sfl6itaSS?=
 =?us-ascii?Q?7xMWpTlNqxlhuo37ds3zQR2J5Ru3CCP+ctjaEtIlOwUWR2HDjlUF8BxQd9A/?=
 =?us-ascii?Q?5yfc1eMJ5f7rG+8U5KtU5M7o9IhY91cBebjYf+36EhLP+hSosv6Q485ZDazK?=
 =?us-ascii?Q?RyM26vRwfyNit2wbUZGB+2LFw2blLy0GiLJ/6sn96VB2/l5MxjbUfqJLZR55?=
 =?us-ascii?Q?0u8P32M49lKldDZXdsit2vKSoAn61PBMjP6I3EQU3T6n8Fvq4odkYFi1Hhf5?=
 =?us-ascii?Q?ZqypyE8kh1dOmMjnb1PzEpL8WvGkNvkZ9NV7bbkMFcZVujMDuaJYds0ZJMkk?=
 =?us-ascii?Q?maDStQ6EU0zerrcXVBwO4edxWFXi0d5Hg/3SC+jhzkU9T+j/4SrKIWXZNFVw?=
 =?us-ascii?Q?K73o0CpPko7MvtJTLiPDuYXZxbEVr5nARzPrUKZWV7kvntK4ghGlluZ84aJu?=
 =?us-ascii?Q?75iXcjkQ1tuH0/mJw2xa3F5y17+uNHPHY+b4irC7sllkBgXPM6KP/SytHi12?=
 =?us-ascii?Q?iNrhuoxJwXM9t8EBy+zzWPy90JrgM1Vb68T6grmV1OB6WSHKYfJR5FU8WAPL?=
 =?us-ascii?Q?i+874XqjsINZJwcsDR2us8106JbP0e+YPNEoPVcKMFUHGD4ZdYkRsNnlLlLB?=
 =?us-ascii?Q?i/k8gdZcOZKdJ1C6GbJ/KnAFeqUl8vIJe2cITkCWKvtYtoX1rqxaUQl6lD0Z?=
 =?us-ascii?Q?bMdGvj+eq8+7u8eYyKRYkow8IY3qm2Pz5Hrej1cVsP4QDm3AI7kCgY8Ct/1I?=
 =?us-ascii?Q?5PPITriDp+MRRLau+mvVhhQF48Qtg3J4C9wQ8KjRdkZzG4HMVp2nfi0fU63o?=
 =?us-ascii?Q?fd2+3i/lzMwyYLZpcoI/lRHpqzQeauFAF7GsVTDK3LXhWg3VimsYrXm70mxu?=
 =?us-ascii?Q?u69bn6mGUQXCwLpoTciJtylDIYYb1jaL3tuJ2eMi6gx6FzJ0/oQ3zDk79xSB?=
 =?us-ascii?Q?l1Em5IAML9b56WyYFkMOS0r/r8RggKFLdGPnNRvQfXvqkutB/p4pLP9yeFrw?=
 =?us-ascii?Q?Db1RnfyEaBGeg6uB9OA0YV60VF+/m70RENDdLlKOXS+buzBHUK+qLSvq5lmv?=
 =?us-ascii?Q?nuMQDrfJGrmYtW3v+6jYo25L0+ACX5BUeIaMEO9BQG5SihGBu+06INFXI1Bl?=
 =?us-ascii?Q?wAmCKQAf0qoj27UMN5eP6Hg1ILwvcMumOCae0LVcp2D6TOLhkbkHkmU57uTF?=
 =?us-ascii?Q?mMO7XChs6f9+KuxvQJlhCxczTJ5CBP4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AFF4E001B7F3E24C911D524ED8C465B0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c40a588-0c81-4503-a694-08da328fcc14
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 14:17:21.1651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wuR/Iz+DK1AyQR9MY+maYmXhDWO6zbyC7yhFQSccftN2zvrFS3dtwdJ+g0ynhTsH130nCmPCQzsg66UNkWx9FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5740
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-10_03:2022-05-09,2022-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100067
X-Proofpoint-ORIG-GUID: VfYwm4VCOlPX0_cQupThYMj5Jmt6F7vY
X-Proofpoint-GUID: VfYwm4VCOlPX0_cQupThYMj5Jmt6F7vY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 10, 2022, at 10:04 AM, Steve Dickson <steved@redhat.com> wrote:
>=20
> Hey!
>=20
> On 5/10/22 9:48 AM, Chuck Lever III wrote:
>>> On May 10, 2022, at 9:32 AM, Steve Dickson <steved@redhat.com> wrote:
>>>=20
>>> Hello,
>>>=20
>>> On 5/2/22 4:50 AM, Richard Weinberger wrote:
>>>> This internal library contains code that will be used by various
>>>> tools within the nfs-utils package to deal better with NFS re-export,
>>>> especially cross mounts.
>>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>>> ---
>>>>  configure.ac                 |  12 ++
>>>>  support/Makefile.am          |   4 +
>>>>  support/reexport/Makefile.am |   6 +
>>>>  support/reexport/reexport.c  | 285 ++++++++++++++++++++++++++++++++++=
+
>>>>  support/reexport/reexport.h  |  39 +++++
>>>>  5 files changed, 346 insertions(+)
>>>>  create mode 100644 support/reexport/Makefile.am
>>>>  create mode 100644 support/reexport/reexport.c
>>>>  create mode 100644 support/reexport/reexport.h
>>>> diff --git a/configure.ac b/configure.ac
>>>> index 93626d62..86bf8ba9 100644
>>>> --- a/configure.ac
>>>> +++ b/configure.ac
>>>> @@ -274,6 +274,17 @@ AC_ARG_ENABLE(nfsv4server,
>>>>  	fi
>>>>  	AM_CONDITIONAL(CONFIG_NFSV4SERVER, [test "$enable_nfsv4server" =3D "=
yes" ])
>>>>  +AC_ARG_ENABLE(reexport,
>>>> +	[AC_HELP_STRING([--enable-reexport],
>>>> +			[enable support for re-exporting NFS mounts  @<:@default=3Dno@:>@]=
)],
>>>> +	enable_reexport=3D$enableval,
>>>> +	enable_reexport=3D"no")
>>>> +	if test "$enable_reexport" =3D yes; then
>>>> +		AC_DEFINE(HAVE_REEXPORT_SUPPORT, 1,
>>>> +                          [Define this if you want NFS re-export supp=
ort compiled in])
>>>> +	fi
>>>> +	AM_CONDITIONAL(CONFIG_REEXPORT, [test "$enable_reexport" =3D "yes" ]=
)
>>>> +
>>> To get this moving I'm going to add a --disable-reexport flag
>> Hi Steve, no-one has given a reason why disabling support
>> for re-exports would be necessary. Therefore, can't this
>> switch just be removed?

> The precedence has been that we used --disable-XXX flag
> a lot in configure.ac... -nfsv4, -nfsv41, etc...
> I'm just following along with that.

I get that... but no-one has given a technical reason
why disabling this code would even be necessary.


> Yes, at this point, nobody is asking to turn it off but
> in future somebody may want to... due some security hole
> or just make the footprint of the package smaller.

I'll bite. What is the added footprint of this patch
series? I didn't think there was a new library dependency
or anything like that...


> I've always though it was a good idea to be able
> to turn things off.. esp if the feature will
> not be used.

If there is a hazard to leaving it on all the time, we
should find out now before the series is applied. So, is
there harm to leaving it on all the time? That should be
documented or fixed before merging.

I must be missing something.


> steved.
>=20
>>> +AC_ARG_ENABLE(reexport,
>>> +       [AC_HELP_STRING([--disable-reexport],
>>> +                       [disable support for re-exporting NFS mounts @<=
:@default=3Dno@:>@])],
>>> +       enable_reexport=3D$enableval,
>>> +       enable_reexport=3D"yes")
>>> +       if test "$enable_reexport" =3D yes; then
>>> +               AC_DEFINE(HAVE_REEXPORT_SUPPORT, 1,
>>> +                          [Define this if you want NFS re-export suppo=
rt compiled in])
>>> +       fi
>>> +       AM_CONDITIONAL(CONFIG_REEXPORT, [test "$enable_reexport" =3D "y=
es" ])
>>> +
>>>=20
>>> steved.
>>>=20
>>>>  dnl Check for TI-RPC library and headers
>>>>  AC_LIBTIRPC
>>>>  @@ -730,6 +741,7 @@ AC_CONFIG_FILES([
>>>>  	support/nsm/Makefile
>>>>  	support/nfsidmap/Makefile
>>>>  	support/nfsidmap/libnfsidmap.pc
>>>> +	support/reexport/Makefile
>>>>  	tools/Makefile
>>>>  	tools/locktest/Makefile
>>>>  	tools/nlmtest/Makefile
>>>> diff --git a/support/Makefile.am b/support/Makefile.am
>>>> index c962d4d4..986e9b5f 100644
>>>> --- a/support/Makefile.am
>>>> +++ b/support/Makefile.am
>>>> @@ -10,6 +10,10 @@ if CONFIG_JUNCTION
>>>>  OPTDIRS +=3D junction
>>>>  endif
>>>>  +if CONFIG_REEXPORT
>>>> +OPTDIRS +=3D reexport
>>>> +endif
>>>> +
>>>>  SUBDIRS =3D export include misc nfs nsm $(OPTDIRS)
>>>>    MAINTAINERCLEANFILES =3D Makefile.in
>>>> diff --git a/support/reexport/Makefile.am b/support/reexport/Makefile.=
am
>>>> new file mode 100644
>>>> index 00000000..9d544a8f
>>>> --- /dev/null
>>>> +++ b/support/reexport/Makefile.am
>>>> @@ -0,0 +1,6 @@
>>>> +## Process this file with automake to produce Makefile.in
>>>> +
>>>> +noinst_LIBRARIES =3D libreexport.a
>>>> +libreexport_a_SOURCES =3D reexport.c
>>>> +
>>>> +MAINTAINERCLEANFILES =3D Makefile.in
>>>> diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
>>>> new file mode 100644
>>>> index 00000000..5474a21f
>>>> --- /dev/null
>>>> +++ b/support/reexport/reexport.c
>>>> @@ -0,0 +1,285 @@
>>>> +#ifdef HAVE_CONFIG_H
>>>> +#include <config.h>
>>>> +#endif
>>>> +
>>>> +#include <sqlite3.h>
>>>> +#include <stdint.h>
>>>> +#include <stdio.h>
>>>> +#include <sys/random.h>
>>>> +#include <sys/stat.h>
>>>> +#include <sys/types.h>
>>>> +#include <sys/vfs.h>
>>>> +#include <unistd.h>
>>>> +
>>>> +#include "nfsd_path.h"
>>>> +#include "nfslib.h"
>>>> +#include "reexport.h"
>>>> +#include "xcommon.h"
>>>> +#include "xlog.h"
>>>> +
>>>> +#define REEXPDB_DBFILE NFS_STATEDIR "/reexpdb.sqlite3"
>>>> +#define REEXPDB_DBFILE_WAIT_USEC (5000)
>>>> +
>>>> +static sqlite3 *db;
>>>> +static int init_done;
>>>> +
>>>> +static int prng_init(void)
>>>> +{
>>>> +	int seed;
>>>> +
>>>> +	if (getrandom(&seed, sizeof(seed), 0) !=3D sizeof(seed)) {
>>>> +		xlog(L_ERROR, "Unable to obtain seed for PRNG via getrandom()");
>>>> +		return -1;
>>>> +	}
>>>> +
>>>> +	srand(seed);
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void wait_for_dbaccess(void)
>>>> +{
>>>> +	usleep(REEXPDB_DBFILE_WAIT_USEC + (rand() % REEXPDB_DBFILE_WAIT_USEC=
));
>>>> +}
>>>> +
>>>> +/*
>>>> + * reexpdb_init - Initialize reexport database
>>>> + */
>>>> +int reexpdb_init(void)
>>>> +{
>>>> +	char *sqlerr;
>>>> +	int ret;
>>>> +
>>>> +	if (init_done)
>>>> +		return 0;
>>>> +
>>>> +	if (prng_init() !=3D 0)
>>>> +		return -1;
>>>> +
>>>> +	ret =3D sqlite3_open_v2(REEXPDB_DBFILE, &db, SQLITE_OPEN_READWRITE |=
 SQLITE_OPEN_CREATE | SQLITE_OPEN_FULLMUTEX, NULL);
>>>> +	if (ret !=3D SQLITE_OK) {
>>>> +		xlog(L_ERROR, "Unable to open reexport database: %s", sqlite3_errst=
r(ret));
>>>> +		return -1;
>>>> +	}
>>>> +
>>>> +again:
>>>> +	ret =3D sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS fsidnums (num I=
NTEGER PRIMARY KEY CHECK (num > 0 AND num < 4294967296), path TEXT UNIQUE);=
 CREATE INDEX IF NOT EXISTS idx_ids_path ON fsidnums (path);", NULL, NULL, =
&sqlerr);
>>>> +	switch (ret) {
>>>> +	case SQLITE_OK:
>>>> +		init_done =3D 1;
>>>> +		ret =3D 0;
>>>> +		break;
>>>> +	case SQLITE_BUSY:
>>>> +	case SQLITE_LOCKED:
>>>> +		wait_for_dbaccess();
>>>> +		goto again;
>>>> +	default:
>>>> +		xlog(L_ERROR, "Unable to init reexport database: %s", sqlite3_errst=
r(ret));
>>>> +		sqlite3_free(sqlerr);
>>>> +		sqlite3_close_v2(db);
>>>> +		ret =3D -1;
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +/*
>>>> + * reexpdb_destroy - Undo reexpdb_init().
>>>> + */
>>>> +void reexpdb_destroy(void)
>>>> +{
>>>> +	if (!init_done)
>>>> +		return;
>>>> +
>>>> +	sqlite3_close_v2(db);
>>>> +}
>>>> +
>>>> +static int get_fsidnum_by_path(char *path, uint32_t *fsidnum)
>>>> +{
>>>> +	static const char fsidnum_by_path_sql[] =3D "SELECT num FROM fsidnum=
s WHERE path =3D ?1;";
>>>> +	sqlite3_stmt *stmt =3D NULL;
>>>> +	int found =3D 0;
>>>> +	int ret;
>>>> +
>>>> +	ret =3D sqlite3_prepare_v2(db, fsidnum_by_path_sql, sizeof(fsidnum_b=
y_path_sql), &stmt, NULL);
>>>> +	if (ret !=3D SQLITE_OK) {
>>>> +		xlog(L_WARNING, "Unable to prepare SQL query '%s': %s", fsidnum_by_=
path_sql, sqlite3_errstr(ret));
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	ret =3D sqlite3_bind_text(stmt, 1, path, -1, NULL);
>>>> +	if (ret !=3D SQLITE_OK) {
>>>> +		xlog(L_WARNING, "Unable to bind SQL query '%s': %s", fsidnum_by_pat=
h_sql, sqlite3_errstr(ret));
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +again:
>>>> +	ret =3D sqlite3_step(stmt);
>>>> +	switch (ret) {
>>>> +	case SQLITE_ROW:
>>>> +		*fsidnum =3D sqlite3_column_int(stmt, 0);
>>>> +		found =3D 1;
>>>> +		break;
>>>> +	case SQLITE_DONE:
>>>> +		/* No hit */
>>>> +		found =3D 0;
>>>> +		break;
>>>> +	case SQLITE_BUSY:
>>>> +	case SQLITE_LOCKED:
>>>> +		wait_for_dbaccess();
>>>> +		goto again;
>>>> +	default:
>>>> +		xlog(L_WARNING, "Error while looking up '%s' in database: %s", path=
, sqlite3_errstr(ret));
>>>> +	}
>>>> +
>>>> +out:
>>>> +	sqlite3_finalize(stmt);
>>>> +	return found;
>>>> +}
>>>> +
>>>> +static int get_path_by_fsidnum(uint32_t fsidnum, char **path)
>>>> +{
>>>> +	static const char path_by_fsidnum_sql[] =3D "SELECT path FROM fsidnu=
ms WHERE num =3D ?1;";
>>>> +	sqlite3_stmt *stmt =3D NULL;
>>>> +	int found =3D 0;
>>>> +	int ret;
>>>> +
>>>> +	ret =3D sqlite3_prepare_v2(db, path_by_fsidnum_sql, sizeof(path_by_f=
sidnum_sql), &stmt, NULL);
>>>> +	if (ret !=3D SQLITE_OK) {
>>>> +		xlog(L_WARNING, "Unable to prepare SQL query '%s': %s", path_by_fsi=
dnum_sql, sqlite3_errstr(ret));
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	ret =3D sqlite3_bind_int(stmt, 1, fsidnum);
>>>> +	if (ret !=3D SQLITE_OK) {
>>>> +		xlog(L_WARNING, "Unable to bind SQL query '%s': %s", path_by_fsidnu=
m_sql, sqlite3_errstr(ret));
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +again:
>>>> +	ret =3D sqlite3_step(stmt);
>>>> +	switch (ret) {
>>>> +	case SQLITE_ROW:
>>>> +		*path =3D xstrdup((char *)sqlite3_column_text(stmt, 0));
>>>> +		found =3D 1;
>>>> +		break;
>>>> +	case SQLITE_DONE:
>>>> +		/* No hit */
>>>> +		found =3D 0;
>>>> +		break;
>>>> +	case SQLITE_BUSY:
>>>> +	case SQLITE_LOCKED:
>>>> +		wait_for_dbaccess();
>>>> +		goto again;
>>>> +	default:
>>>> +		xlog(L_WARNING, "Error while looking up '%i' in database: %s", fsid=
num, sqlite3_errstr(ret));
>>>> +	}
>>>> +
>>>> +out:
>>>> +	sqlite3_finalize(stmt);
>>>> +	return found;
>>>> +}
>>>> +
>>>> +static int new_fsidnum_by_path(char *path, uint32_t *fsidnum)
>>>> +{
>>>> +	/*
>>>> +	 * This query is a little tricky. We use SQL to find and claim the s=
mallest free fsid number.
>>>> +	 * To find a free fsid the fsidnums is left joined to itself but wit=
h an offset of 1.
>>>> +	 * Everything after the UNION statement is to handle the corner case=
 where fsidnums
>>>> +	 * is empty. In this case we want 1 as first fsid number.
>>>> +	 */
>>>> +	static const char new_fsidnum_by_path_sql[] =3D "INSERT INTO fsidnum=
s VALUES ((SELECT ids1.num + 1 FROM fsidnums AS ids1 LEFT JOIN fsidnums AS =
ids2 ON ids2.num =3D ids1.num + 1 WHERE ids2.num IS NULL UNION SELECT 1 WHE=
RE NOT EXISTS (SELECT NULL FROM fsidnums WHERE num =3D 1) LIMIT 1), ?1) RET=
URNING num;";
>>>> +
>>>> +	sqlite3_stmt *stmt =3D NULL;
>>>> +	int found =3D 0, check =3D 0;
>>>> +	int ret;
>>>> +
>>>> +	ret =3D sqlite3_prepare_v2(db, new_fsidnum_by_path_sql, sizeof(new_f=
sidnum_by_path_sql), &stmt, NULL);
>>>> +	if (ret !=3D SQLITE_OK) {
>>>> +		xlog(L_WARNING, "Unable to prepare SQL query '%s': %s", new_fsidnum=
_by_path_sql, sqlite3_errstr(ret));
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	ret =3D sqlite3_bind_text(stmt, 1, path, -1, NULL);
>>>> +	if (ret !=3D SQLITE_OK) {
>>>> +		xlog(L_WARNING, "Unable to bind SQL query '%s': %s", new_fsidnum_by=
_path_sql, sqlite3_errstr(ret));
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +again:
>>>> +	ret =3D sqlite3_step(stmt);
>>>> +	switch (ret) {
>>>> +	case SQLITE_ROW:
>>>> +		*fsidnum =3D sqlite3_column_int(stmt, 0);
>>>> +		found =3D 1;
>>>> +		break;
>>>> +	case SQLITE_CONSTRAINT:
>>>> +		/* Maybe we lost the race against another writer and the path is no=
w present. */
>>>> +		check =3D 1;
>>>> +		break;
>>>> +	case SQLITE_BUSY:
>>>> +	case SQLITE_LOCKED:
>>>> +		wait_for_dbaccess();
>>>> +		goto again;
>>>> +	default:
>>>> +		xlog(L_WARNING, "Error while looking up '%s' in database: %s", path=
, sqlite3_errstr(ret));
>>>> +	}
>>>> +
>>>> +out:
>>>> +	sqlite3_finalize(stmt);
>>>> +
>>>> +	if (check) {
>>>> +		found =3D get_fsidnum_by_path(path, fsidnum);
>>>> +		if (!found)
>>>> +			xlog(L_WARNING, "SQLITE_CONSTRAINT error while inserting '%s' in d=
atabase", path);
>>>> +	}
>>>> +
>>>> +	return found;
>>>> +}
>>>> +
>>>> +/*
>>>> + * reexpdb_fsidnum_by_path - Lookup a fsid by path.
>>>> + *
>>>> + * @path: File system path used as lookup key
>>>> + * @fsidnum: Pointer where found fsid is written to
>>>> + * @may_create: If non-zero, allocate new fsid if lookup failed
>>>> + *
>>>> + */
>>>> +int reexpdb_fsidnum_by_path(char *path, uint32_t *fsidnum, int may_cr=
eate)
>>>> +{
>>>> +	int found;
>>>> +
>>>> +	found =3D get_fsidnum_by_path(path, fsidnum);
>>>> +
>>>> +	if (!found && may_create)
>>>> +		found =3D new_fsidnum_by_path(path, fsidnum);
>>>> +
>>>> +	return found;
>>>> +}
>>>> +
>>>> +/*
>>>> + * reexpdb_uncover_subvolume - Make sure a subvolume is present.
>>>> + *
>>>> + * @fsidnum: Numerical fsid number to look for
>>>> + *
>>>> + * Subvolumes (NFS cross mounts) get automatically mounted upon first
>>>> + * access and can vanish after fs.nfs.nfs_mountpoint_timeout seconds.
>>>> + * Also if the NFS server reboots, clients can still have valid file
>>>> + * handles for such a subvolume.
>>>> + *
>>>> + * If kNFSd asks mountd for the path of a given fsidnum it can
>>>> + * trigger an automount by calling statfs() on the given path.
>>>> + */
>>>> +void reexpdb_uncover_subvolume(uint32_t fsidnum)
>>>> +{
>>>> +	struct statfs64 st;
>>>> +	char *path =3D NULL;
>>>> +	int ret;
>>>> +
>>>> +	if (get_path_by_fsidnum(fsidnum, &path)) {
>>>> +		ret =3D nfsd_path_statfs64(path, &st);
>>>> +		if (ret =3D=3D -1)
>>>> +			xlog(L_WARNING, "statfs() failed");
>>>> +	}
>>>> +
>>>> +	free(path);
>>>> +}
>>>> diff --git a/support/reexport/reexport.h b/support/reexport/reexport.h
>>>> new file mode 100644
>>>> index 00000000..bb6d2a1b
>>>> --- /dev/null
>>>> +++ b/support/reexport/reexport.h
>>>> @@ -0,0 +1,39 @@
>>>> +#ifndef REEXPORT_H
>>>> +#define REEXPORT_H
>>>> +
>>>> +enum {
>>>> +	REEXP_NONE =3D 0,
>>>> +	REEXP_AUTO_FSIDNUM,
>>>> +	REEXP_PREDEFINED_FSIDNUM,
>>>> +};
>>>> +
>>>> +#ifdef HAVE_REEXPORT_SUPPORT
>>>> +int reexpdb_init(void);
>>>> +void reexpdb_destroy(void);
>>>> +int reexpdb_fsidnum_by_path(char *path, uint32_t *fsidnum, int may_cr=
eate);
>>>> +int reexpdb_apply_reexport_settings(struct exportent *ep, char *flnam=
e, int flline);
>>>> +void reexpdb_uncover_subvolume(uint32_t fsidnum);
>>>> +#else
>>>> +static inline int reexpdb_init(void) { return 0; }
>>>> +static inline void reexpdb_destroy(void) {}
>>>> +static inline int reexpdb_fsidnum_by_path(char *path, uint32_t *fsidn=
um, int may_create)
>>>> +{
>>>> +	(void)path;
>>>> +	(void)may_create;
>>>> +	*fsidnum =3D 0;
>>>> +	return 0;
>>>> +}
>>>> +static inline int reexpdb_apply_reexport_settings(struct exportent *e=
p, char *flname, int flline)
>>>> +{
>>>> +	(void)ep;
>>>> +	(void)flname;
>>>> +	(void)flline;
>>>> +	return 0;
>>>> +}
>>>> +static inline void reexpdb_uncover_subvolume(uint32_t fsidnum)
>>>> +{
>>>> +	(void)fsidnum;
>>>> +}
>>>> +#endif /* HAVE_REEXPORT_SUPPORT */
>>>> +
>>>> +#endif /* REEXPORT_H */
>>>=20
>> --
>> Chuck Lever

--
Chuck Lever



