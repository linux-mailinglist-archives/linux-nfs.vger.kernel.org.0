Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3505D4C8E9B
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Mar 2022 16:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbiCAPJF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Mar 2022 10:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbiCAPJF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Mar 2022 10:09:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870055D65F
        for <linux-nfs@vger.kernel.org>; Tue,  1 Mar 2022 07:08:23 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221ECwNi004279;
        Tue, 1 Mar 2022 15:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=E6i16/iobwUdsfQ+GJ7g/AGwd54vUo6aYZEVTku3E+Y=;
 b=Q6hortKF4AjSmo7xqd11aVb+5/fjzedvpx1D1/fTtJEpXjGnzx4qiwPlCJn8h+fXN6SS
 vr4bChT2/qW4rZuE8FzGAkJ6YYiuEy7uJfuvLUZNEWam6LvdHPqaEb2V4bjL3VtTJxkw
 g6wMbpPEb/sRsaU7u7I7O9OwEnifvA0ZvHwBPrdvF5Ey9L2+6CUBC7A1nuRYo8Pp8lP4
 XN5XFWRIZ3heMNkxepn2CUKRB+6dCCx44tsAEk9fyFCsjs8nM7r7GmfA/KuKDj9szUdg
 hS+tm6J8KikYlBN86MEZWcNEvoguzBdM23PkNHVB7N4XlPTTiAI3m4P/3P/BoQvbYDkh kA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehbk99gdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 15:08:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 221F5ba1151469;
        Tue, 1 Mar 2022 15:08:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3020.oracle.com with ESMTP id 3efdnmvvde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 15:08:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7zTUhonJjdVIV6tpJhiGdu86IJ09eWVn3L3ZIACYj9b4vASI1cSeg9HWG+Va5Wug4FXgBLtzoTxaT+OF5jGMqAAD1r6TQFrBNXpWtyaYcEEAlQSHOin+vroeudFNIELjdlaWuoKWBAcpsrB9zJSc9r28aSoEbBDp+ilUs0dUaLgO276yDoGFbP2m6UXmAVTt54R2dhB7MGmhvlxu3rQPZvxkfHXwq1wMT2Q+kOgKEbjqd8HQ4WOtC3qj0gyuSzEg3H/PMSZtRAbKmgkKd/F8IMUfJAkcygzKYSBnYem2qP4+WaQbRHY5yKlN8lsxqzvX3YGK+A1dGHSU0v9MssoGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6i16/iobwUdsfQ+GJ7g/AGwd54vUo6aYZEVTku3E+Y=;
 b=fp+OSW4NDT7h5VZCEnXh0KXjk7qxuqWnZog/TqmDXk3IcKqhDuFyYBsDVxexQul9gspQuQRO/SQdJ8yIUjKlAV6f8JTVbDnos9XRuqubX7LJYfuMqpBgyssP0arb8SIdJgIX06BxD0ThHVnwOhXu89pWIw6YMsqkOYD2ywElXm5bU+btALTtP7U4i4RLF/2gL57P804p+a4+eKIBih5VocjPkCSdExthglphvQc2FQZJDMVc6728RuoM/4FOladedsagPq3cD5/4sDuS2ktOfncH4+KJeCu0IofVZB4YRV+c4IG3KEprPXLCi6Hr3BPMS/wzEbDw600CEOhZZrTo5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6i16/iobwUdsfQ+GJ7g/AGwd54vUo6aYZEVTku3E+Y=;
 b=OaSBfwfMN8OM/3PAgKAvGGU19HgnEIRfV3lNrnEkXXJD05scV5wVBro/8LydtOFy9IpI3wBcz0rTZw0hPR2HnxBx9HcPO9syk8/S+boNaa29CKMU7s6O/tF7StR35rw2f6W3+EZip7UPH69tJX7Sn5OG1KQQXvXTbnVA4XZbohQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5719.namprd10.prod.outlook.com (2603:10b6:a03:3ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 15:08:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 15:08:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Benjamin Coddington <bcodding@redhat.com>,
        Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs.man: document requirements for NFS mounts in a
 container
Thread-Topic: [PATCH] nfs.man: document requirements for NFS mounts in a
 container
Thread-Index: AQHYLR6czeCutPWqYkWZgIa/iwKGvKyqohqA
Date:   Tue, 1 Mar 2022 15:08:13 +0000
Message-ID: <F285A122-30EC-4353-AF10-FBF6999B7F25@oracle.com>
References: <cover.1644515977.git.bcodding@redhat.com>
 <7642FA55-F3F2-4813-86E2-1B65185E6B36@oracle.com>
 <3d2992df-7ef7-50ba-4f11-f4de588620d2@redhat.com>
 <DDB59BD9-8C29-45C3-ABAF-B25EDDB63E09@oracle.com>
 <D0908E76-C163-4DBF-A93C-665492EB9DB2@redhat.com>
 <E2C56D5B-AC77-48D1-9AF6-268406648657@oracle.com>
 <4657F9AE-3B9E-4992-9334-3FF1CF18EF31@redhat.com>
 <C7533D80-25B3-4722-94A9-0440C48B8574@oracle.com>
 <945849B4-BE30-434C-88E9-8E901AAFA638@redhat.com>
 <06B01290-E375-455E-A6D7-419CA653A0D1@oracle.com>
 <948D8123-E310-4A35-BF04-C030F20EA83C@redhat.com>
 <164479707170.27779.15384523062754338136@noble.neil.brown.name>
 <863AB69A-D5D6-4F22-950C-E5F468CD4552@redhat.com>
 <42AAFEDD-F4EE-4A91-BD23-E08B1149EF1C@oracle.com>
 <3AF29DC6-2EEB-4C3E-BD6C-BE31910921AE@redhat.com>
 <9FC005FB-370E-4AFA-AD80-8599CBFCC1E0@oracle.com>
 <2965D098-7AEE-419D-BF8B-4D7AF4AB40FB@redhat.com>
 <164505339057.10228.4638327664904213534@noble.neil.brown.name>
 <164610623626.24921.6124450559951707560@noble.neil.brown.name>
In-Reply-To: <164610623626.24921.6124450559951707560@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3434fbb8-34db-484b-b17f-08d9fb954ec5
x-ms-traffictypediagnostic: SJ0PR10MB5719:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB5719A104D684BBEB82204DE493029@SJ0PR10MB5719.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: md7Ip9aqmd5d9kTqWvw83VuzwgC3UKPLBzqhDQleCCFGknCIa046g0QixmoHLM/NR23OzD6n/Rbm/gWCJNjXoy1IG732mSzR93YWJPlrklZhnEldki2jLk9sVVsCkrLHnYird/z7aYb1bxElWyzq0P7LpZoNO4umqdL+XLXqEJupeRZp7zv2FI6t1WrjN3bCaniAiXBWX4GQz0f+A/2SW1LROpv5gktJY8xgAwQ93dUOyKhPPuLGfMVSnZVkry3Yj+kBotCTVxzD7oIi/wvCUYvsEHUpUWTa+sPT9TL6u8r2pkOf0wc0wJP2TTmXzlbuR48vazZDsLoWL7JE/Xq33+5eH014UBNHgHrURJFBKnIZ/T5sPsHbGqtZFr3plSO8/14tDUN0mCXqjF12a5qMYJzujb2MYO37TdLUQU5dhWee4OBwccCVjQFvLWiVhUXBxa+oSCz0T9FG5iAapggWHNOa4WUYNvDFDB9GRvKHyLYtWV0Ur9XGUvQlMij9PYDqWpEMzddwbJrSQW9co8MSFcq5bvwYT4a6q+mYhR8637jgSeYRDnDaSGmxW1KsZuIT8BhOYUGn8xk4H6olv7QLm7MOx5vZJdZgLJ5TsFXUYB8eBOEBWlDpTqc5iEijzXQuhyRMBPgKa0MEOU1m1hgOHeJjhoJKM1FNrY8r7CCsGhl/V9HDBkzK6mdzfCAffYybcDmc9aqyKEevYhkdHlPczcOn6VbjBBmDv768NHvLFP8iaOY6P1y70mfzMbAADYg3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(86362001)(38070700005)(508600001)(53546011)(6506007)(186003)(38100700002)(36756003)(33656002)(6486002)(6512007)(26005)(76116006)(66446008)(66476007)(66556008)(66946007)(64756008)(5660300002)(8676002)(4326008)(83380400001)(122000001)(91956017)(2616005)(8936002)(6916009)(316002)(2906002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3U5BKwxG5vkv0AW3AuPEOK3uaj0nvlRYu5h7m6ZwvyBSXn6glpCfnlFXc+Nh?=
 =?us-ascii?Q?EKsKS6FF7CmBYbyGyLyHUnsUuWjg2EDODcywx0pLjK67TZChBBtzKc0jiTuw?=
 =?us-ascii?Q?enNjd4PtDrc/TkF58I1qO/jkGQTDFGhu1g4rr470D1iAnAJwHvQcQZfvBlGv?=
 =?us-ascii?Q?qejgm4x2v2dq5V45K5FVCXfxyG4M1abeFAm8Rry3NSWppuiKlzXL4phGvMjW?=
 =?us-ascii?Q?kQTFHAfZimrFtrRm7K+ZiOieWjiLYbTNgEJw27EkDZZqt6PYPD08IWWXqYu9?=
 =?us-ascii?Q?L/dvmfV4tTD2B4TaYQo0eXaxcA0v+vC4YtnUlpUj8lOmffkmNvI98cLzsk4o?=
 =?us-ascii?Q?vkakwkjtCef0LRIImh4C8wI5b90pUcpe99zVvv8eMNJlWWkyd/PlEQPpzJdQ?=
 =?us-ascii?Q?RJKkCUTVwk5on4wBjDFvDw/XyiO3UCAGL0dGyL7u0k9UsMsYIaOEdyJqZg9/?=
 =?us-ascii?Q?j3AdYT6wEGDvPC0lNSRkszW2TXLSuE/omed8i/rONy6FuPhp4ivG4ZqmpZJI?=
 =?us-ascii?Q?JM9puAYK3Ks29inZGJ6xRgXlsILF0g+2pnliB7SF+9aEREP3MEyDeAmXRnQQ?=
 =?us-ascii?Q?K5KDFFsC/2tZUxHQ2sEWOEQmQZAucY4RpWumCB6c8M9A5F5HJKDWUCvZzDr2?=
 =?us-ascii?Q?SJ842GyuEgK8PK2eYpHMpLZyYd+Gih/BSGueQTTp/oyoRg0ESedNQkAujyBY?=
 =?us-ascii?Q?1/dSPMoZZAoNlEQvqHyC4tWtxmHyVResP69atDMng0QJ0UsL5rV3Eni7B7zS?=
 =?us-ascii?Q?X9Y+eX0WLAq38k3u9ZPWWG2gLTGz1jioCXdRS7MEtqZPTZW7Xq+tOuEPNbmC?=
 =?us-ascii?Q?cZXxvgFn37klOVWYltIlw0LXIrXHxw8SjRFseEqEqKTBmsOtNHvH8G6qx2N4?=
 =?us-ascii?Q?8bzmxNrAamp2+4H3UAxWiVRcu3+OPMquHOpZf0Uk5fcr9wGJlYbo1ZKocXQc?=
 =?us-ascii?Q?tIEWeD80XxzIPZmcR/GE7MUEtbY9XMsCZqtiOXl8nE2bzjT21tnKF92fRcJa?=
 =?us-ascii?Q?aaAKR50021dgcJdEkCo7XRMJRv6S+54TJ96aWEKG9rLKt8CpQo/HaNkgnnQf?=
 =?us-ascii?Q?Dfuyc80jTddgkiOGfu+NMo8+QEYeSjYepAgpcRy2/0ejPlcaVXkaMMPenYx/?=
 =?us-ascii?Q?wPLTkWpSKFl2lrZpAMbA0uGpQ58FvWielt6iWIoV18nsw7z5BgC/xqbwhltN?=
 =?us-ascii?Q?YD296vaB7dYtJxTjXuFWCRdSP09RzPVqo5jpXwyExqYE+3QDUDBOp8DyxdAn?=
 =?us-ascii?Q?OUuF2p6ZkrQ5xTuzxImVgcT4ChQ0zTDjGuVq+9tFMHqlcAxE5vBtJgvktL+J?=
 =?us-ascii?Q?s8mpcMFPieZcJR7eJOJgtFKIArlE5/wEGWEi6kVv3iJ14wdGDl53xXJfbMqP?=
 =?us-ascii?Q?t1cqJzPvQiRtFC2m9ulyaJm2tJSojCS+vrWMAi0gGYDbN1jBdp5u0/8iJXnd?=
 =?us-ascii?Q?5EPmoyxbAp9k0tz2rvllfU7eOhJ22NHhqREQhUYa6sqkYiRg+Iif5DcNR7UX?=
 =?us-ascii?Q?Sf43IdK6CAXhVQWQGPPBxViRE9g8kh0RdMklU08bsfD9YJSM1jdp4/PR/9NZ?=
 =?us-ascii?Q?ovk0FKUBUj3oj9NLWXl/dpavUjL7RV66hbWR0KelWB3XaOchwEkP+h4irrbF?=
 =?us-ascii?Q?QFh48QXsFTT7nX1pXmpHYlk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <738C0E2BDA76C94991EB84575AEC1A6B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3434fbb8-34db-484b-b17f-08d9fb954ec5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 15:08:13.8664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OM3EKEaA3v+7ZSJ4VFe/GPArC+EJDZC6H9YeTgcpMYWmeE0uIbQrF7wit/kZl9p//wfRsRUnbW4a/C/6KkOWZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5719
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10272 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010081
X-Proofpoint-GUID: PKDnQYKDE9UU4k-pKmudfhPO2kvbO17o
X-Proofpoint-ORIG-GUID: PKDnQYKDE9UU4k-pKmudfhPO2kvbO17o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 28, 2022, at 10:43 PM, NeilBrown <neilb@suse.de> wrote:
>=20
>=20
> When mounting NFS filesystems in a network namespace using v4, some care
> must be taken to ensure a unique and stable client identity.
> Add documentation explaining the requirements for container managers.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>=20
> NOTE I originally suggested using uuidgen to generate a uuid from a
> container name.  I've changed it to use the name as-is because I cannot
> see a justification for using a uuid - though I think that was suggested
> somewhere in the discussion.
> If someone would like to provide that justification, I'm happy to
> include it in the document.
>=20
> Thanks,
> NeilBrown
>=20
>=20
> utils/mount/nfs.man | 63 +++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 63 insertions(+)
>=20
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index d9f34df36b42..4ab76fb2df91 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -1844,6 +1844,69 @@ export pathname, but not both, during a remount.  =
For example,
> merges the mount option
> .B ro
> with the mount options already saved on disk for the NFS server mounted a=
t /mnt.
> +.SH "NFS IN A CONTAINER"

To be clear, this explanation is about the operation of the
Linux NFS client in a container environment. The server has
different needs that do not appear to be addressed here.
The section title should be clear that this information
pertains to the client.


> +When NFS is used to mount filesystems in a container, and specifically
> +in a separate network name-space, these mounts are treated as quite
> +separate from any mounts in a different container or not in a
> +container (i.e. in a different network name-space).

It might be helpful to provide an introductory explanation of
how mount works in general in a namespaced environment. There
might already be one somewhere. The above text needs to be
clear that we are not discussing the mount namespace.


> +.P
> +In the NFSv4 protocol, each client must have a unique identifier.

... each client must have a persistent and globally unique
identifier.


> +This is used by the server to determine when a client has restarted,
> +allowing any state from a previous instance can be discarded.

Lots of passive voice here :-)

The server associates a lease with the client's identifier
and a boot instance verifier. The server attaches all of
the client's file open and lock state to that lease, which
it preserves until the client's boot verifier changes.


> So any two
> +concurrent clients that might access the same server MUST have
> +different identifiers, and any two consecutive instances of the same
> +client SHOULD have the same identifier.

Capitalized MUST and SHOULD have specific meanings in IETF
standards that are probably not obvious to average readers
of man pages. To average readers, this looks like shouting.
Can you use something a little friendlier?


> +.P
> +Linux constructs the identifier (referred to as=20
> +.B co_ownerid
> +in the NFS specifications) from various pieces of information, three of
> +which can be controlled by the sysadmin:
> +.TP
> +Hostname
> +The hostname can be different in different containers if they
> +have different "UTS" name-spaces.  If the container system ensures
> +each container sees a unique host name,

Actually, it turns out that is a pretty big "if". We've
found that our cloud customers are not careful about
setting unique hostnames. That's exactly why the whole
uniquifier thing is so critical!


> then this is
> +sufficient for a correctly functioning NFS identifier.
> +The host name is copied when the first NFS filesystem is mounted in
> +a given network name-space.  Any subsequent change in the apparent
> +hostname will not change the NFSv4 identifier.

The purpose of using a uuid here is that, given its
definition in RFC 4122, it has very strong global
uniqueness guarantees.

Using a UUID makes hostname uniqueness irrelevant.

Again, I think our goal should be hiding all of this
detail from administrators, because once we get this
mechanism working correctly, there is absolutely no
need for administrators to bother with it.


The remaining part of this text probably should be
part of the man page for Ben's tool, or whatever is
coming next.


> +.TP
> +.B nfs.nfs4_unique_id
> +This module parameter is the same for all containers on a given host
> +so it is not useful to differentiate between containers.
> +.TP
> +.B /sys/fs/nfs/client/net/identifier
> +This virtual file (available since Linux 5.3) is local to the network
> +name-space in which it is accessed and so can provided uniqueness betwee=
n
> +containers when the hostname is uniform among containers.
> +.RS
> +.PP
> +This value is empty on name-space creation.
> +If the value is to be set, that should be done before the first
> +mount (much as the hostname is copied before the first mount).
> +If the container system has access to some sort of per-container
> +identity, then a command like
> +.RS 4
> +echo "$CONTAINER_IDENTITY" \\
> +.br
> +   > /sys/fs/nfs/client/net/identifier=20
> +.RE
> +might be suitable.  If the container system provides no stable name,
> +but does have stable storage, then something like
> +.RS 4
> +[ -s /etc/nfsv4-uuid ] || uuidgen > /etc/nfsv4-uuid &&=20
> +.br
> +cat /etc/nfsv4-uuid > /sys/fs/nfs/client/net/identifier=20
> +.RE
> +would suffice.
> +.PP
> +If a container has neither a stable name nor stable (local) storage,
> +then it is not possible to provide a stable identifier, so providing
> +a random one to ensure uniqueness would be best
> +.RS 4
> +uuidgen > /sys/fs/nfs/client/net/identifier
> +.RE
> +.RE
> .SH FILES
> .TP 1.5i
> .I /etc/fstab
> --=20
> 2.35.1
>=20

--
Chuck Lever



