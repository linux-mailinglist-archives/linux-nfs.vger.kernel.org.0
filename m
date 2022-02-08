Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB274AE363
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 23:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351543AbiBHWWV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 17:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386895AbiBHVS1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 16:18:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200B2C0612B8
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 13:18:23 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218L1PcR012748;
        Tue, 8 Feb 2022 21:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3pysJvVcPfvq1RHOkzPUbrGF3eWMySciTAJgBZRgPyI=;
 b=oLcdPlJPJPZBWPyLr/6TTiLV6f7tm+MD9GeXISqgNipfLtbFXbUSqng1/8La55huTDb9
 HJl5smWyjai9i3J2du/9HLy5OPsNZcFUuh7cskDIyHySly6GIP9EbKBCSNGkAP4xAQuo
 CJqaAtcRinQ3He+OEr+HL/8mIL40pdcJSYM0prR1Dl7QHQYxOLU9lu4GWrtKU894If3q
 4uLXG4h/4scPHIbWo59rfYbBIubEBgtp+CRJ2iHIyoPXIIW76AcWfqA70m+l7VYzkci/
 aPn2ykMc94EHwoQ7yzsH1LmvWe4MOskzOk9ywLo0/O9AuPFfsOmN1R+TDgRMzBHoaihb xA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3fpgju28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 21:18:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 218LAhpB104050;
        Tue, 8 Feb 2022 21:18:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3020.oracle.com with ESMTP id 3e1jprjt24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 21:18:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6DKEFoRPUyr65cJWHio7QL2yN+YfTfP/SN4zcIZid1OFNKGukTxlS9akT84vyMeM8c+JchJExxHWe0suwi7SdI8xtJb2+DdIsE1zCrdgIG5BT1/b3aXb/02mbsKCug4qgu+tscDbCZ8P8EaF79b0BKVYFeNJcBSF8tV1Wyb0pHJQwWAshamJdfmhZCiu0BteEr6VvW4h6el6jQvL86zQnLuTbN82d/84yC0b8dSodKYcPefkI6xXbBK0Lw3VyTop8AnczbavL4WcvsCGSMdLeGta4iAgD0K65ntpbOYCGmEcp0iE1yyCbXWbJAkjzShIHducFwvt/bcpd8QId8CGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pysJvVcPfvq1RHOkzPUbrGF3eWMySciTAJgBZRgPyI=;
 b=ZiXD3hHz0DRUnPt2ZDhAOUbckIqbRC89nx1LolK19WfELcTlbLHWYksGoTjQ/XboUZHhxXJKKxp7VMTTxKqFx40yWtHwNjQjkWHOgxsG0SuLtXcI0YluHD5ZW68oG/D13s5etvUVuvzlDbUEU5VxS9FlYNs7H4PZBiZSeiHQIUeVhRG3oWP5u4tnQnDeeUkn0Roq6ZfgzH2udlHh7peIe3mxzRP1SaLjfNa8LqwQnw9WakOHo5h5+E+zQssYH/3CS0EwQXUcaXR/4N5inMMldaMYYN1scWCKt4c8vz5EvXcHuV1TR/5C1INFD/AecnLgPwRW6LhBITcVCG5fVe1D6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pysJvVcPfvq1RHOkzPUbrGF3eWMySciTAJgBZRgPyI=;
 b=lI6MuQYtxEkmOnVu3SYJyp9BetnDvgqs2j8CxA5imbFt0Zje1rEB4bmUY/11LzbQnktxOJNZXHlUxmXuoC9zHx1QW8eXFJl20IC5hpKg0FfVf7wyRWAbvzCm32+X16bpiyXYCNzcm7ken+TEw6kbKyR946nCRZw23VhKpFyUR7U=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by DM5PR10MB1307.namprd10.prod.outlook.com (2603:10b6:3:e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.18; Tue, 8 Feb 2022 21:18:15 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 21:18:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steve Dickson <steved@redhat.com>
CC:     Benjamin Coddington <bcodding@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Thread-Topic: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Thread-Index: AQHYGca9ZpW/pPf5rEWUIwyc/qfEDKyJ14OAgAAE1wCAADSIgIAAHlWA
Date:   Tue, 8 Feb 2022 21:18:15 +0000
Message-ID: <32D8EBC9-652A-49D7-B763-A82E2AEF6282@oracle.com>
References: <c2e8b7c06352d3cad3454de096024fff80e638af.1643979161.git.bcodding@redhat.com>
 <6f01c382-8da5-5673-30db-0c0099d820b5@redhat.com>
 <33B10EBB-3DD1-45FE-B7D2-D5EA21DFB172@oracle.com>
 <839b09ed-fd21-bda1-0502-d7c6f1fa9e88@redhat.com>
In-Reply-To: <839b09ed-fd21-bda1-0502-d7c6f1fa9e88@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f415074-cb92-48fd-599c-08d9eb48853e
x-ms-traffictypediagnostic: DM5PR10MB1307:EE_
x-microsoft-antispam-prvs: <DM5PR10MB1307C4BB804B5F33A3606A7A932D9@DM5PR10MB1307.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Th7ClRDcYMuGGAi1Y85GhlY7yGTOK+T+sjr6ltBf0xcQjaF7XOi0dhCvhZx5CkMRIJmU/MoKC7V+bztI5KANCileXWTb8XCjuUBXjSulnPKDtjcQq3uTGK2M9COR6FWxLd9mQUIsKETCAtm1TPW+bv5XB/aTGHldQDqFshVK3ESFbias7YnTxMQTUI3DWMXzxPuE5HWpt5IBQ9MpcRnwUr4KjRX1HfMRUgkm5EtvY/9m1YM1wvvBRK1sWIDfhve0ss+ALCa/1lnfb1b9P7OryiVHczld6sw1fyzaLorpZ/o5JhPo8XlVwB/we26HrTO8OB8YZIXPSPljqIHYItMKedaitlQ8V6gYWHEy+8apNmjt0d747PKU4pWqdVz9dLZTyjkL7VXi7Q/x8oOAJ2NFTzNMasj1L7vX49ca2A90kLrCw7fqMSv2bQBRUm4ODrIBsfwFEQtC3KrgLQcUX8yfAhI3oFwRyHLwkHfasYSjJx1+cYX5K+cNi7avQHAFEi7tMODmu47MUeKitEzSVJBbFRUyGh2O9E4NhkW8lRiapFTadKMuqYEMLGSglACxARl5jYWWCZsbCoRHFAUxeul9VCYRbN8jQTlkyQv/IfVD6Z2PTNBV4GZsjp2AIzsXiV4w9dPHjgwqxCCKxzDl/wAVYu37FZbXGUhtuwT5hJVcKpbmyFC2xBs+W8kh8PBoAG0j8E2begvvgjGwcP810VmpFHtlfpVcvHehax455JyvlddP/8z0hNKsOVM1I/lNLhpBH4jfANqLWG/ohjO9p59UUStdnXFMYompsJpqy7jX+FU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(2906002)(76116006)(4326008)(64756008)(8936002)(38070700005)(6512007)(6506007)(71200400001)(66446008)(8676002)(83380400001)(66476007)(36756003)(5660300002)(2616005)(66556008)(6486002)(33656002)(54906003)(66946007)(38100700002)(122000001)(6916009)(508600001)(316002)(53546011)(26005)(186003)(32563001)(2004002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ocA3sBw4XDSkMQpNcHcCNN/f6Qv6gxfoM8ZhO6bgrLHnsRcciTPYS8miNlZs?=
 =?us-ascii?Q?fuWS2sU6XcVrpgO4oIOhOYod4qSBco7/PVxhs05bOz2Ha3AARfxJpmD5oUYt?=
 =?us-ascii?Q?IOJ3yJFg7mgWiIJ9gofStMieKB0Nj6ZSDfTk0+Pu5m6rrzI5LoDZnCUr/sri?=
 =?us-ascii?Q?tv6lSy2rmr3LGI0CDs0K2q6K2QdPBNWoR5wdHh/763rRliun70B/iMTKJZV9?=
 =?us-ascii?Q?baCUgxsLO0JTcxnAHjWz4lcWf9gq4mcCFJlUWLZkXBkq69DAtt9yHRjWA3VW?=
 =?us-ascii?Q?f++1S+Ox7ch9OHpjfpFb9Tp/tjm2Nv6tVzlFWMJbOu4osePZWR/cDhZLzhCN?=
 =?us-ascii?Q?S28wse3whFX3N0NkHtHNC2Zl+VIv9dhUAjT8ayER6KGX1CepcpsQJinDg9Ng?=
 =?us-ascii?Q?dSX0oshtAgJoUHFtp4LttQFZycnGCBx9ULeoefdAuo2eakLbVSXEUJF6fn8H?=
 =?us-ascii?Q?qDsrNAvgOlkAt59Hlsi+T9bDVfP/DCIPDNaefpwDz14NivA0BkZr6DcQeinf?=
 =?us-ascii?Q?UyihSmU0SIp2o3hTsW/VWbL+cwXop5EBF/h+TbmR+RxPKV/8+AR/yxVvfco6?=
 =?us-ascii?Q?zb/WAmyZzhDzRFeQ7aKUYStJ1yNkeCuFCxAWhluXwos0QtUZZ9TJ45M41Am0?=
 =?us-ascii?Q?z2gFOQLDkPmlm/xHmE9g5amrco/RUG7LY6+R0fWyKCVFJ90gmphUrmsgVInW?=
 =?us-ascii?Q?TcyUJIm8uHXjv0yUwlUSEPUm2ehGJ+uCkI8Rxbigq/j2SzAAS5Vad4ZhoMDO?=
 =?us-ascii?Q?KhMC68bYARyKCP8MuaLDxbxk+zrT0ebqtuQe4VGXCxilgaw5vBuwAoY7Uxsz?=
 =?us-ascii?Q?YeYgbamqvNetA/w5xTK6J1p39bixcWAxIJW25caMvD9/h+yBfje91ImLXTXe?=
 =?us-ascii?Q?SrUD3l4sd2oH+6UZFE492C0D1R1fopxMQu4OpZYITyEtg3l3KTEegHOhMk5f?=
 =?us-ascii?Q?R9PaEvGdJ8kK6OxR6q4VjajWwjNBXPIS0cKcBQfl8iTXS1SoNnQ5bX6F0l7b?=
 =?us-ascii?Q?eKWsFLly1PL6NazMcEEmHh3VtyZHVyDEwa/BjHVBfo9CnNJqjnxCUTKsjVuf?=
 =?us-ascii?Q?Vxi5KKABFApQbntsZO/Wi4lsuXHOkWYMx531h8Smv3ishOAtsKN+iBR/cLmA?=
 =?us-ascii?Q?cbwgoj50S05KcCgaVa8CDNm4Cyd+mNrMJM8gkSNckiPD09RlhgGlqW00n5BW?=
 =?us-ascii?Q?mX/9Cl+Ev7jpkNVqfr+51RSn6r6X00ima60OGk/e/l8UdRvIYW8Qo/iE3LDM?=
 =?us-ascii?Q?8+BUuHD599kRuv1Q09k+X5T4FQZWNOLXTfpIwzPOMO4R9HO8XXMhOs1kTWJO?=
 =?us-ascii?Q?hJMlAQOW+4JhHp930zue5K4rYyt32w7ObAlF00lAm9y/vwWvpjAB94iWnTu2?=
 =?us-ascii?Q?X3IS7ps8Lg449P7xwN0tAPKEpzIvohQ7MjknrSkARXBjdYNE3LpEWiP9l44n?=
 =?us-ascii?Q?ezco/oGyGPpiNCzhiGri9ZYCIOBLrsEFS++JSPv+kqE8W4fPwiaXysIZzPkw?=
 =?us-ascii?Q?teDhQLhdvZgB/H7zm60FTTrk7BQd0npW+DWJ61YTDlWQklylc0Qa0exu5vi7?=
 =?us-ascii?Q?mo7Z6pEDxZm3+WHHYW12aHUXiSwqoQvRsmFB9gpKEi3yAaB3pwZHptRzCsNl?=
 =?us-ascii?Q?gM6vFyiD9J5X1tBXVht9c+U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E84950FAEBBAA148840C6B4688B7C01C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f415074-cb92-48fd-599c-08d9eb48853e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 21:18:15.4639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z0Wgy0vJTHd9Fm6UgDoB4+8eh8sCXZZGODZpl9hORcynidYiR8MMy7zjkjkOf75p02zUSIFct9J7rVGQJA0NrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1307
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10252 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202080125
X-Proofpoint-GUID: CPxiPcZybKKRnyun3KX7kbWQ8RNjf3bG
X-Proofpoint-ORIG-GUID: CPxiPcZybKKRnyun3KX7kbWQ8RNjf3bG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 8, 2022, at 2:29 PM, Steve Dickson <steved@redhat.com> wrote:
>=20
>=20
>=20
> On 2/8/22 11:21 AM, Chuck Lever III wrote:
>>> On Feb 8, 2022, at 11:04 AM, Steve Dickson <steved@redhat.com> wrote:
>>>=20
>>> Hello,
>>>=20
>>> On 2/4/22 7:56 AM, Benjamin Coddington wrote:
>>>> The nfs4id program will either create a new UUID from a random source =
or
>>>> derive it from /etc/machine-id, else it returns a UUID that has alread=
y
>>>> been written to /etc/nfs4-id.  This small, lightweight tool is suitabl=
e for
>>>> execution by systemd-udev in rules to populate the nfs4 client uniquif=
ier.
>>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>>> ---
>>>>  .gitignore               |   1 +
>>>>  configure.ac             |   4 +
>>>>  tools/Makefile.am        |   1 +
>>>>  tools/nfs4id/Makefile.am |   8 ++
>>>>  tools/nfs4id/nfs4id.c    | 184 ++++++++++++++++++++++++++++++++++++++=
+
>>>>  tools/nfs4id/nfs4id.man  |  29 ++++++
>>>>  6 files changed, 227 insertions(+)
>>>>  create mode 100644 tools/nfs4id/Makefile.am
>>>>  create mode 100644 tools/nfs4id/nfs4id.c
>>>>  create mode 100644 tools/nfs4id/nfs4id.man
>>> Just a nit... naming convention... In the past
>>> we never put the protocol version in the name.
>>> Do a ls tools and utils directory and you
>>> see what I mean....
>>>=20
>>> Would it be a problem to change the name from
>>> nfs4id to nfsid?
>> nfs4id is pretty generic, too.
>> Can we go with nfs-client-id ?
> I'm never been big with putting '-'
> in command names... nfscltid would
> be better IMHO... if we actually
> need the 'clt' in the name.

We have nfsidmap already. IMO we need some distinction
with user ID mapping tools... and some day we might
want to manage server IDs too (see EXCHANGE_ID).

nfsclientid then?


> steved.
>=20
>>> steved.
>>>=20
>>>> diff --git a/.gitignore b/.gitignore
>>>> index c89d1cd2583d..a37964148dd8 100644
>>>> --- a/.gitignore
>>>> +++ b/.gitignore
>>>> @@ -61,6 +61,7 @@ utils/statd/statd
>>>>  tools/locktest/testlk
>>>>  tools/getiversion/getiversion
>>>>  tools/nfsconf/nfsconf
>>>> +tools/nfs4id/nfs4id
>>>>  support/export/mount.h
>>>>  support/export/mount_clnt.c
>>>>  support/export/mount_xdr.c
>>>> diff --git a/configure.ac b/configure.ac
>>>> index 50e9b321dcf3..93d0a902cfd8 100644
>>>> --- a/configure.ac
>>>> +++ b/configure.ac
>>>> @@ -355,6 +355,9 @@ if test "$enable_nfsv4" =3D yes; then
>>>>    dnl check for the keyutils libraries and headers
>>>>    AC_KEYUTILS
>>>>  +  dnl check for the libuuid library and headers
>>>> +  AC_LIBUUID
>>>> +
>>>>    dnl Check for sqlite3
>>>>    AC_SQLITE3_VERS
>>>>  @@ -740,6 +743,7 @@ AC_CONFIG_FILES([
>>>>  	tools/nfsdclnts/Makefile
>>>>  	tools/nfsconf/Makefile
>>>>  	tools/nfsdclddb/Makefile
>>>> +	tools/nfs4id/Makefile
>>>>  	utils/Makefile
>>>>  	utils/blkmapd/Makefile
>>>>  	utils/nfsdcld/Makefile
>>>> diff --git a/tools/Makefile.am b/tools/Makefile.am
>>>> index 9b4b0803db39..cc658f69bb32 100644
>>>> --- a/tools/Makefile.am
>>>> +++ b/tools/Makefile.am
>>>> @@ -7,6 +7,7 @@ OPTDIRS +=3D rpcgen
>>>>  endif
>>>>    OPTDIRS +=3D nfsconf
>>>> +OPTDIRS +=3D nfs4id
>>>>    if CONFIG_NFSDCLD
>>>>  OPTDIRS +=3D nfsdclddb
>>>> diff --git a/tools/nfs4id/Makefile.am b/tools/nfs4id/Makefile.am
>>>> new file mode 100644
>>>> index 000000000000..d1e60a35a510
>>>> --- /dev/null
>>>> +++ b/tools/nfs4id/Makefile.am
>>>> @@ -0,0 +1,8 @@
>>>> +## Process this file with automake to produce Makefile.in
>>>> +
>>>> +man8_MANS	=3D nfs4id.man
>>>> +
>>>> +bin_PROGRAMS =3D nfs4id
>>>> +
>>>> +nfs4id_SOURCES =3D nfs4id.c
>>>> +nfs4id_LDADD =3D $(LIBUUID)
>>>> diff --git a/tools/nfs4id/nfs4id.c b/tools/nfs4id/nfs4id.c
>>>> new file mode 100644
>>>> index 000000000000..dbb807ae21f3
>>>> --- /dev/null
>>>> +++ b/tools/nfs4id/nfs4id.c
>>>> @@ -0,0 +1,184 @@
>>>> +/*
>>>> + * nfs4id.c -- create and persist uniquifiers for nfs4 clients
>>>> + *
>>>> + * Copyright (C) 2022  Red Hat, Benjamin Coddington <bcodding@redhat.=
com>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or
>>>> + * modify it under the terms of the GNU General Public License
>>>> + * as published by the Free Software Foundation; either version 2
>>>> + * of the License, or (at your option) any later version.
>>>> + *
>>>> + * This program is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> + * GNU General Public License for more details.
>>>> + *
>>>> + * You should have received a copy of the GNU General Public License
>>>> + * along with this program; if not, write to the Free Software
>>>> + * Foundation, Inc., 51 Franklin Street, Fifth Floor,
>>>> + * Boston, MA 02110-1301, USA.
>>>> + */
>>>> +
>>>> +#include <stdio.h>
>>>> +#include <stdarg.h>
>>>> +#include <getopt.h>
>>>> +#include <string.h>
>>>> +#include <errno.h>
>>>> +#include <stdlib.h>
>>>> +#include <fcntl.h>
>>>> +#include <unistd.h>
>>>> +#include <uuid/uuid.h>
>>>> +
>>>> +#define NFS4IDFILE "/etc/nfs4-id"
>>>> +
>>>> +UUID_DEFINE(nfs4_clientid_uuid_template,
>>>> +	0xa2, 0x25, 0x68, 0xb2, 0x7a, 0x5f, 0x49, 0x90,
>>>> +	0x8f, 0x98, 0xc5, 0xf0, 0x67, 0x78, 0xcc, 0xf1);
>>>> +
>>>> +static char *prog;
>>>> +static char *source =3D NULL;
>>>> +static char nfs4_id[64];
>>>> +static int force =3D 0;
>>>> +
>>>> +static void usage(void)
>>>> +{
>>>> +	fprintf(stderr, "usage: %s [-f|--force] [machine]\n", prog);
>>>> +}
>>>> +
>>>> +static void fatal(const char *fmt, ...)
>>>> +{
>>>> +	int err =3D errno;
>>>> +	va_list args;
>>>> +	char fatal_msg[256] =3D "fatal: ";
>>>> +
>>>> +	va_start(args, fmt);
>>>> +	vsnprintf(&fatal_msg[7], 255, fmt, args);
>>>> +	if (err)
>>>> +		fprintf(stderr, "%s: %s\n", fatal_msg, strerror(err));
>>>> +	else
>>>> +		fprintf(stderr, "%s\n", fatal_msg);
>>>> +	exit(-1);
>>>> +}
>>>> +
>>>> +static int read_nfs4_id(void)
>>>> +{
>>>> +	int fd;
>>>> +
>>>> +	fd =3D open(NFS4IDFILE, O_RDONLY);
>>>> +	if (fd < 0)
>>>> +		return fd;
>>>> +	read(fd, nfs4_id, 64);
>>>> +	close(fd);
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void write_nfs4_id(void)
>>>> +{
>>>> +	int fd;
>>>> +
>>>> +	fd =3D open(NFS4IDFILE, O_RDWR|O_TRUNC|O_CREAT, S_IRUSR|S_IWUSR|S_IR=
GRP|S_IROTH);
>>>> +	if (fd < 0)
>>>> +		fatal("could not write id to " NFS4IDFILE);
>>>> +	write(fd, nfs4_id, 37);
>>>> +}
>>>> +
>>>> +static void print_nfs4_id(void)
>>>> +{
>>>> +	fprintf(stdout, "%s", nfs4_id);
>>>> +}
>>>> +=09
>>>> +static void check_or_make_id(void)
>>>> +{
>>>> +	int ret;
>>>> +	uuid_t nfs4id_uuid;
>>>> +
>>>> +	ret =3D read_nfs4_id();
>>>> +	if (ret !=3D 0) {
>>>> +		if (errno !=3D ENOENT )
>>>> +			fatal("reading file " NFS4IDFILE);
>>>> +		uuid_generate_random(nfs4id_uuid);
>>>> +		uuid_unparse(nfs4id_uuid, nfs4_id);
>>>> +		nfs4_id[36] =3D '\n';
>>>> +		nfs4_id[37] =3D '\0';
>>>> +		write_nfs4_id();
>>>> +	}
>>>> +	print_nfs4_id();=09
>>>> +}
>>>> +
>>>> +static void check_or_make_id_from_machine(void)
>>>> +{
>>>> +	int fd, ret;
>>>> +	char machineid[32];
>>>> +	uuid_t nfs4id_uuid;
>>>> +
>>>> +	ret =3D read_nfs4_id();
>>>> +	if (ret !=3D 0) {
>>>> +		if (errno !=3D ENOENT )
>>>> +			fatal("reading file " NFS4IDFILE);
>>>> +
>>>> +		fd =3D open("/etc/machine-id", O_RDONLY);
>>>> +		if (fd < 0)
>>>> +			fatal("unable to read /etc/machine-id");
>>>> +
>>>> +		read(fd, machineid, 32);
>>>> +		close(fd);
>>>> +
>>>> +		uuid_generate_sha1(nfs4id_uuid, nfs4_clientid_uuid_template, machin=
eid, 32);
>>>> +		uuid_unparse(nfs4id_uuid, nfs4_id);
>>>> +		nfs4_id[36] =3D '\n';
>>>> +		nfs4_id[37] =3D '\0';
>>>> +		write_nfs4_id();
>>>> +	}
>>>> +	print_nfs4_id();
>>>> +}
>>>> +
>>>> +int main(int argc, char **argv)
>>>> +{
>>>> +	prog =3D argv[0];
>>>> +
>>>> +	while (1) {
>>>> +		int opt;
>>>> +		int option_index =3D 0;
>>>> +		static struct option long_options[] =3D {
>>>> +			{"force",	no_argument,	0, 'f' },
>>>> +			{0,			0,				0, 0 }
>>>> +		};
>>>> +
>>>> +		errno =3D 0;
>>>> +		opt =3D getopt_long(argc, argv, ":f", long_options, &option_index);
>>>> +		if (opt =3D=3D -1)
>>>> +			break;
>>>> +
>>>> +		switch (opt) {
>>>> +		case 'f':
>>>> +			force =3D 1;
>>>> +			break;
>>>> +		case '?':
>>>> +			usage();
>>>> +			fatal("unexpected arg \"%s\"", argv[optind - 1]);
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	argc -=3D optind;
>>>> +
>>>> +	if (argc > 1) {
>>>> +		usage();
>>>> +		fatal("Too many arguments");
>>>> +	}
>>>> +
>>>> +	if (argc)
>>>> +		source =3D argv[optind++];
>>>> +
>>>> +	if (force)
>>>> +		unlink(NFS4IDFILE);
>>>> +
>>>> +	if (!source)
>>>> +		check_or_make_id();
>>>> +	else if (strcmp(source, "machine") =3D=3D 0)
>>>> +		check_or_make_id_from_machine();
>>>> +	else {
>>>> +		usage();
>>>> +		fatal("unrecognized source %s\n", source);
>>>> +	}
>>>> +}
>>>> diff --git a/tools/nfs4id/nfs4id.man b/tools/nfs4id/nfs4id.man
>>>> new file mode 100644
>>>> index 000000000000..358f836468a2
>>>> --- /dev/null
>>>> +++ b/tools/nfs4id/nfs4id.man
>>>> @@ -0,0 +1,29 @@
>>>> +.\"
>>>> +.\" nfs4id(8)
>>>> +.\"
>>>> +.TH nfs4id 8 "3 Feb 2022"
>>>> +.SH NAME
>>>> +nfs4id \- Generate or return nfs4 client id uniqueifiers
>>>> +.SH SYNOPSIS
>>>> +.B nfs4id [ -f | --force ] [<source>]
>>>> +
>>>> +.SH DESCRIPTION
>>>> +The
>>>> +.B nfs4id
>>>> +command provides a simple utility to help NFS Version 4 clients use u=
nique
>>>> +and persistent client id values.  The command checks for the existenc=
e of a
>>>> +file /etc/nfs4-id and returns the first 64 chars read from that file.=
  If
>>>> +the file is not found, a UUID is generated from the specified source =
and
>>>> +written to the file and returned.
>>>> +.SH OPTIONS
>>>> +.TP
>>>> +.BR \-f, \-\-force
>>>> +Overwrite the existing /etc/nfs4-id with a UUID generated from <sourc=
e>.
>>>> +.SH Sources
>>>> +If <source> is not specified, nfs4id will generate a new random UUID.
>>>> +
>>>> +If <source> is "machine", nfs4id will generate a deterministic UUID v=
alue
>>>> +derived from a sha1 hash of the contents of /etc/machine-id and a sta=
tic
>>>> +key.
>>>> +.SH SEE ALSO
>>>> +.BR machine-id (5)
>> --
>> Chuck Lever
>=20

--
Chuck Lever



