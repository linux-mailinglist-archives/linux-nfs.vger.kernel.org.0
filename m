Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278044AC93C
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 20:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbiBGTNN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 14:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240060AbiBGTJs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Feb 2022 14:09:48 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0966C0401DA
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 11:09:47 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217IqnuK004455
        for <linux-nfs@vger.kernel.org>; Mon, 7 Feb 2022 19:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mqno3Kj+E8+YpA06hG/7fQMN8iumY9JybfD11UTLFdE=;
 b=TbrRvDOD369HsPcMuf17Yuq1lwxxUfBjRP6OcRCGJNHWOSDRrk+KPESq0je6mFMLtCnF
 LuZljYfTf7tkDxVUC40izW3fFVzkZL5E8/+zM7/54niYNl+ylfmbRSFxqlHxS/DobLSy
 yX6kN+F4VgjjZLjR7NpCZ1RBCgqMzEqKcAo2UvzOwkpLVZBEp714bkSSyoQc9OhfhX5U
 +Of6qm3R8rRI0hAlm+y0bTavS/i3mptNnoT7ehiw+4miIpS9+5alvsWM0MjpOaXvdjIk
 pD6+f2/ylBsI3QsEa8MqykKW6KcNybih/Ns4Gsf+6QEtXfppiRetkdCD41JGtk4/PU7F kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1g13q9hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 07 Feb 2022 19:09:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 217J5UZx020684
        for <linux-nfs@vger.kernel.org>; Mon, 7 Feb 2022 19:09:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3020.oracle.com with ESMTP id 3e1h24skrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 07 Feb 2022 19:09:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTQ+yY5svvaL7+N1kyFSbhwW2IRCTXnQP403iVhlVlGdBJM8IdCdht1691Ra6ERD+pm8oHhfq08lnt0piuOEYtdNuzpspZzYi7Ef8rGq9zQjoGSlADkl8sr1PlwTGsB5wVumaJQOnXQ/0VAJnYpig0SqBJeJyU/zqwnjLmis/ASJZaSxTGrokGgXsoFk8gBf2gllD7GArYls+gPE/H+8XkCC+GLru7S3E65a3cIqlVdANu8aBvblBEkjfyqZuQoXhXf0QUQ7CwOKMpGNvIwa2/OLa3kbWrkHR8A2r1HHP2ZxHQOi4qiARXM6QlzO499T+ARlOELC2PAy2aaa87vH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqno3Kj+E8+YpA06hG/7fQMN8iumY9JybfD11UTLFdE=;
 b=BgW4V4uYkEiUwJZv7I00K+ilKWfgB+KJEq15VVFwReV5w30S3fqluRdkbKWPI6NRXoJBM+miRWyxKqQ6VxOhXHRvwFkyk2Z5AYWmB5Botj9optag7gY+922U77HajM7fEHTMZ8+0zaasIIPxiu+k52kB6r/GcC1s3KF3PidKnaGbvVsGACLOfTDXABpN5P3Tjez9ykHGlLnT4wyx/IFBKcovI9h0QItrkUtJpRt2AaT+X1/Lxu2Oi4F7PygfVug7bXhf1bP0WqLM0VtISrIVL3bD7jL4muZ7rxQY9R9pgdbdzsqahrA2flf43Rmj6h4K15+x/k/WMaP6XhUjVh506Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqno3Kj+E8+YpA06hG/7fQMN8iumY9JybfD11UTLFdE=;
 b=dkReDn9emubZgRp8k4emnm8ny1uhhOr3VhbMOuXm3Dx4Kzn1uYXmkhiH86imioeRffnCR++kIS4vMpX3sqxDjKE7Qf3nx1sgpHMReROzg3SouPkNauzTHB+iJQgp6leX6RuF4Wki4eX3pncUH94mpulzklEkQ/7sX664AuszU74=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 19:09:44 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 19:09:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Cache flush on file lock
Thread-Topic: Cache flush on file lock
Thread-Index: AQHYF9ij5r5wZxOe10G+VO/hoTSM1KyArgyAgAM1aICABJlgAA==
Date:   Mon, 7 Feb 2022 19:09:42 +0000
Message-ID: <BAA6F711-7291-4EE2-B45C-C25ABC051D18@oracle.com>
References: <20220202014111.GA7467@hostway.ca>
 <4691F0AB-FCDB-49EF-B62B-51F135F692A5@oracle.com>
 <309e27b9-da26-bcd0-dc55-1b63cb93203f@math.utexas.edu>
In-Reply-To: <309e27b9-da26-bcd0-dc55-1b63cb93203f@math.utexas.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 401f1955-8e78-41ce-ea61-08d9ea6d65b0
x-ms-traffictypediagnostic: CH2PR10MB4312:EE_
x-microsoft-antispam-prvs: <CH2PR10MB4312D52B3A2C181F76916E81932C9@CH2PR10MB4312.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tie3MCOTqgah89M0Ydi3yCpr6YjNwmobCsxjfcK9BjmDwNdzvz42m3dL+8BqQ6mJ29sQr8WFaQLfaUja3S+kLhAxz4Ru3yMZkSStv3hUQ0SlPdozkH8A7DJI0/r56lh/11sewgSWlXY4XFQzkfJwXrvTivLRapOD5mgSDDc5PPntKSbraHQqfttBTI9lZ5FZgRe0ib4lB/6KsQ2LD5TaqeXdS/8FCaPUg9HgXQyVvOOZpMBl8X2V9Sfko8epAeBmapaEuafOVCkdU6B3H0qKijs0W/Tmiy8v8IDVBvy597W17QA0fW+7Y/EozdWmaTFVtUaiQTyCpbv/98w3wxTXTNyLOwFnRBf0shXxzL2U3VWTB29X3JKiAp1MOq6LMNmQOJQhTmJ2Tuh4FiLGw0mAPScRUh50t1vwUukSt0Ooo17MaUrnAbz9Rx1VJ8ktnEPxLQZbTyjXzjMZtcz1IAVwqKaS94TnfZ58YyPj+d5LAiQ80pZMgmY2QfF0MxVc+XkQUaW/rDmoA9qaVobLJKr3p87LeDokfNLZ8tL9KkydzvoEjP9C0SR3Ln2tLWvadWEEzj2+ztDm0F8HyNFGrTTo1TZEyvGAEhyxE4U3axmDcZ13+Zvf+DjsQUfEi9VSOFXowPpD9wBxEWMoxj1reIsSK9SOmc6dKidaUkiazmVrDAoQmU3RIH05f9+HOtJs/UBEdssIzscDl0tHTqAh5zEUvNypA0MmSDLxe0rlqrNQnQBaNwJymtp8dZoVeb+CoWgl1B/QBu8FA46ihli7jtbSL2Ee5aBuiJV/cHryyp1yiau7NSP2+0twIpO5sml7VVp0a1A4tKaCmcai0HE/qh/xZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(38100700002)(26005)(122000001)(508600001)(966005)(186003)(2906002)(5660300002)(38070700005)(71200400001)(36756003)(6512007)(6506007)(6916009)(86362001)(33656002)(316002)(66946007)(66556008)(66476007)(66446008)(64756008)(8936002)(8676002)(6486002)(76116006)(53546011)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XgsQSUQ8lWt1vF36oryO6sSOOtp5ccgfpKoO6S6XYPXaRQce5d0+2F4OrWFK?=
 =?us-ascii?Q?FSqVB5fKd4UHzbgNuohRxYJ1KwzNBMvkV9JHgkdion3WtekzeC0WyEoN+o5/?=
 =?us-ascii?Q?FTElgOx2m5XCHZ+9gFu+h3ypFqLJyXCNJPfYX1+nBgHM8TYpaoIHs4c3RVSQ?=
 =?us-ascii?Q?rpf4SZ94mWlGWW7GsSPX4UidS6px2ypV3ls6rVOriS30pqqOIpqxmkL1gvtv?=
 =?us-ascii?Q?VzHI52twuZCDIjAc9ZeY0zzAWZVfKI8B9LsCYjkVOAxTCEb0n5HfjNrre+a0?=
 =?us-ascii?Q?z9UG8+eNRYNTnlpID9BqlB4SSLN0use39p030tq5bUcZCdNhNApkmcgcInNe?=
 =?us-ascii?Q?NjakTyUs325mAgWIv56z88pnVaro/DfK6WNzSSbVnHBGYtN1ZOpbD8U8IhPg?=
 =?us-ascii?Q?7w8m954GjbZRp8iBUsmNg2bZlk3cKS9IVBqO2St5BLF8FTq4UqYECkR74a9I?=
 =?us-ascii?Q?r/tFzUQ0/YT9YsFjt0oCzHdItdpQgTqbRv7d86bgmMNGL2IuUT8GLscluJYX?=
 =?us-ascii?Q?wilwYdZAdxFiZNyEcw2tXXiwBcsaJBwRHQZUkLCWKml28k9cMEJIh5BIM9jI?=
 =?us-ascii?Q?C/qa0/MpIFF1Gdb9dcCoeduYihSdl0ZxkElmaw+vljH47Fav1amarghBZ/HT?=
 =?us-ascii?Q?womAD333SVIjTXViKErn0EjzPyrN2APvgf3WeDTGgBBiX4D2BFxgCJjLF3DW?=
 =?us-ascii?Q?kgPHjM6u2HTXxt46gybkheba2+PGlwdrFJ8bRG0Kcp6hv6LzJ0kbLdebxCa2?=
 =?us-ascii?Q?YqAGPcf3LU71vFAePx+yHt0qKZYpc4R7zojP05uJaIrwMWpnuEWzOGKuvfAd?=
 =?us-ascii?Q?h2TVgHKWfbufCBeKlExuLjDQWAXGst1mkpd4nQe/rDhjYTXSNNIdBX58UJ39?=
 =?us-ascii?Q?g2q/oz67S1u3CYTpzq+r9P4X31qFnd3WbPhKjVI4DthsJ413aWgjFENW+uYz?=
 =?us-ascii?Q?j3/FLwREVJnFVb9kmrsF42Ww3U9rUG8yCA+mtnKIviVnRPTji4vEMa/Y/mPp?=
 =?us-ascii?Q?Wdehev0mK2MJj5XEwm/QNNUljaJFrduMnrRUF/GvfXoEBMGKJ5LxAITJVMJ9?=
 =?us-ascii?Q?64W3LrmLLCKNO+Ga53a4qYthpCiVX07vBjlFGKh20u1BuWJpTukBmRj4pmsj?=
 =?us-ascii?Q?0/HfOFnv6moBJbVaAkH8jWPMVrQbKef9DjkhDZO0GpZnZRY+7HBLRbKvi3kC?=
 =?us-ascii?Q?og6E+hrrU0kLWWj2IVrOgjWigU/QX/yMMHnsdMZWJBGgu7ohK3Od5XFJ9f/9?=
 =?us-ascii?Q?Tav6v4S7PUWeZ0gK6SJKoajB0f/HSjU8MFsWLZMVVM8gEUIA/lgCRx7Xplvm?=
 =?us-ascii?Q?QmcoE2Vd07kqeHQsc80Ikncj0pPC52hMdMtaQPyEsORy5Y7zItRAbcG5ygTG?=
 =?us-ascii?Q?WORYuRiKKjTGsk60gO/TRxXx387yIchZVf5FMJ3HnNZxrUuatdKpUNxBhWP4?=
 =?us-ascii?Q?F6ClXSIWO5ubQh3vb0sDUphCrtjiyOvot1cpUMq6mnQfaDDoqafiOib+FQzC?=
 =?us-ascii?Q?zDlVTPyDlxq3PyI8pWI+xpAtWsIR1P/ADTOPcHtJ+Y3jwR/SZoMEqCqbw3cm?=
 =?us-ascii?Q?CbQukS8lic/mI4VYXK5IgGurgYgKEbpldgk5j2fBtf1DPIWEKpply9pjwjTq?=
 =?us-ascii?Q?aZyWSe7YJbHM2eeD/s2uii0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <09A049454DBD184F824667E68B8883A6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401f1955-8e78-41ce-ea61-08d9ea6d65b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 19:09:42.7126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7bWIKyjqXh3jC/UgQgLtPvcVpYHafPmVQlyt5/ayXfpOL+G1PRkRZKrgnL7d+c/EK2xr70edKyWu4D1Tidy0sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4312
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10251 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070116
X-Proofpoint-GUID: odfNImTrFPyEfJJDDM3Gqwz2pi36pete
X-Proofpoint-ORIG-GUID: odfNImTrFPyEfJJDDM3Gqwz2pi36pete
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 4, 2022, at 3:55 PM, Patrick Goetz <pgoetz@math.utexas.edu> wrote:
>=20
>=20
>=20
> On 2/2/22 13:55, Chuck Lever III wrote:
>>> On Feb 1, 2022, at 8:41 PM, Simon Kirby <sim@hostway.ca> wrote:
>>>=20
>>> How far off would we be from write delegations happening here?
>> We are tracking a "feature request" for write delegation support
>> in the Linux NFS server:
>> https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D348
>> At this point the effort is not resourced. It's not clear how
>> much benefit it would be.
>=20
> First shock is I thought write delegation was already supported.

WRITE delegation and READ delegation are both supported on
the Linux NFS client.

The Linux NFS server offers only READ delegations.


> But especially for users who have NFS mounted home directories, how could=
 there not be a major performance benefit? To cite one example that has bee=
n a problem before (in particular, on Mac OSX clients with NFSv3 home direc=
tories mounted from a linux fileserver), facilitating the firefox "awesome"=
 bar, which writes to a SQLlite database in ~/.mozilla/fireworks with alarm=
ing frequency in order to keep up the awesomeness.

I might be missing something, but if SQlite is using fsync()
then there isn't much choice for the NFS client but to push
dirty data to the server and see that the data is committed.
The purpose of that fsync() is to ensure the written data is
robust against client or server failure.

WRITE delegation would probably not have much impact on that.
It's purpose is to enable the client to cache more aggressively
in cases where immediate data persistence is not needed.

The fact that there is only one client reading and updating
that database is beside the point.


> This flat out didn't work previously unless you went to about:config and =
set
>=20
>  storage.nfs_filesystem =3D true
>=20
> Not at all sure how this changed the execution of firefox though.
>=20
>=20
>> That said, it seems to me that your use case might benefit if
>> the Linux NFS server offered a READ delegation for the SQLite
>> database file even when it is open R/W. It might be appropriate
>> if the server offered such a delegation when there are no other
>> clients that have the file open for write or that hold write
>> delegations.
>> Patches and performance data are, as always, welcome.
>> --
>> Chuck Lever

--
Chuck Lever



