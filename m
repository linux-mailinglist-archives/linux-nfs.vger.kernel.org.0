Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3B75EFA15
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Sep 2022 18:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbiI2QTR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Sep 2022 12:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbiI2QTL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Sep 2022 12:19:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2023B1E05C8;
        Thu, 29 Sep 2022 09:19:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TG6Jr7022167;
        Thu, 29 Sep 2022 16:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QCPWUqAIY1QiX050ViXf4voSEd7iTWeEcqiWSWVmUDk=;
 b=wgYDG1Vsfqk6yuPbBs9eilUIcw5sK51yIqPAPO9fnrJDQhpLCPccLONbTKDeV98yco6D
 Vzfx18BPWo18JEQVtoJh71srvJGnAOpnvd6K2PPjp8EBaXKfez7jKkGb7SrTrCw+y0zl
 pAtsHgQNTMja9jlrG/Ft9mYoUsEfCX/oww/M2wKs+yhfdxKTPKkihzdbvARJSdIPaBer
 IRwKdR4SQaSUdyYkJ9VOvfZhddXuKlsa08iB0pYK6SIgtCC5xP45rz8GGcoUiBoSPtn/
 AE9b0rg7u6TSd3nkvRfRjyUFQtBXeytuC5gX32V/AN2vEDnsCKXUnei0zbqsgn6NwUzi 1Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssubne5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 16:18:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28TEnDhT039393;
        Thu, 29 Sep 2022 16:18:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpqabbau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 16:18:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2Eg/3eqwVTXElBKldvBV+R4WVIYI76mzX7lwqTc34VCxLafWSFuGlny72B1nGKkVps1+Cyuh7yKMzidC3ACcr36cvvq0T9Lsqr95/0UeB2GUdcnnyygKNYYwuWhoTTCFwby0MyxlbjxkX+IqLyssiFf7k8ZOqgaoQD1AU4UKhhyBOPCpkbyZDVIhXR27S2y4eD90qYdnzDbvIDabhRJ8WRtYOdMeprY6krPxuHXj6JC3+EFCqPSX/xEJW63ZxNrkpcu7yoS2YlzaV03319BZjf/EkgIrP/m9HSfuPCoCglr6a44oV+X/7TWFpc8A+6NHzWrKi/EuuHzrC7vbE0ZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCPWUqAIY1QiX050ViXf4voSEd7iTWeEcqiWSWVmUDk=;
 b=Vxn+04DykNTvRRrY01ftGP3ZnGGT4SBN4flO1Ryt3fCqPMG6yPD99hGI3jk2l6LbzsXMo+1zvT4585JTTgLxgcsrKlMGORIKaliaYJkhRV969dpM8zV1r7oJEcx0SxIGWyXpwC9mwMSUS4x3YcEnNSsTmpWS6u8KQOtUgxtSdIS8o8yIQw1jIUbHioX9uxM0qcrBomYWKv1Si0azdlx+mmk/M/ZcM3HGQwz10wukPCgTqoJtRJ93Z+Bs81qBuEKKMrJpSiY4yDJTRhADMjobXlSyhK2ZLLc3vr0fDKn6cTm/WlUgbHHag3s2O/K5hnRykLTmmktfbnRet0PZFGS1wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCPWUqAIY1QiX050ViXf4voSEd7iTWeEcqiWSWVmUDk=;
 b=j5LiQN6FW32B0IgKIeHIEof4Gg6hRVdNcgNIjtUzqbV+NXLOhBDubYSXkOnQF9dgEnxyP3kxjDnFN17/uKyzkZXCvYRTSzx5bReAeFY1PaEyusynVFoxocExVNkFSGkwRqO+/wTwn37GTtzaXPP4YD16jJ+diXL+e9qwa8IC5fc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4122.namprd10.prod.outlook.com (2603:10b6:5:221::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Thu, 29 Sep
 2022 16:18:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 16:18:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     jaganmohan kanakala <jaganmohan.kanakala@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: LINUX NFS support for SHA256 hash types
Thread-Topic: LINUX NFS support for SHA256 hash types
Thread-Index: AQHY0zKLaDiZfQG1FkW5IfB4RW19Ga32l+4A
Date:   Thu, 29 Sep 2022 16:18:52 +0000
Message-ID: <2DC5A71F-F7B7-401B-954E-6A0656BDC6A9@oracle.com>
References: <CAK6vGwma1mALwE1zDUqXhGP+YHjtXdPipykui3Tt0a6NL_KOqw@mail.gmail.com>
In-Reply-To: <CAK6vGwma1mALwE1zDUqXhGP+YHjtXdPipykui3Tt0a6NL_KOqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM6PR10MB4122:EE_
x-ms-office365-filtering-correlation-id: 9618538c-0b32-46e5-a1fb-08daa2364d01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rVqaW1pmrKrvjR6GAc1RAM1bMgrhpNtf/AQwCsOkdyRt0uC7zRqS9xy0e+GSiF2NzdF3N0AKCsHOHcHCncNfAyrw20Mj4+JwB5w18Oe3nDxC1pWmYGG9ATRz21VydLIm7ppssRmfVfs/S562DQIemjHwVeP8ph7UqxthdzAFBJ5IK1cLGDh2WD8T3vwf7bNqyHK5vEsx0rYbxb03kIgIhQSmLWKYHgBU7X3MGRS90gnrzH17e0EsP6A3a7JIKsYtAwpaCyCyrvM4Z6RvEv5twA36Ow7D7tmQWPU+DkdJ5YxvzKFeBf5ZbUutttLJJTf1X/79IqjoBLQVdyYtAgB0KNA/Wg9F6c3Yxhvp2phY+tvG/2jd/6UtY/ORGx7NPEncWgbQ2HJN8Tp5scKoeR0mxj54h/ecdd+uk6c79cwpUzr8UkdPT6bMG9VG2woFB7YTZbeStp4Q3Y1lp3pGYQKEjkgnDm/hptEuvg44CLhDCF6oXeSaHVUUwmcr2qICcvb3VI1BzKOiowyiZeCgQzVzVkkCe2vchbmEkaScoKp1N8VizbxQL8QJzliQjJSA7pjwXjkOZT9dJJ2XSUKSLmPfK3mVIUTfgRxY2tercteamVhzNUSiCEz2o8BXBtlQYEfat0g8FbkitXTOfhP8aWH2DQwyWhMTft05tTItrkqr2SZDNfOuBo/i5fKSTqGeiUbpARhfoFk/8wDRh29t4qo3avqb6ZDs1fBngTnw67H+xoBsitGZYWuRRsvMqqgRYGXfPPEWkgHgyoNfzsyLe65eveHdWmD8j0TYE3i2tmcw/2QfjZ2ihM58OzrF+VJ34XpWBbByFaQ9Y62YLl97i2mRvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199015)(66556008)(86362001)(36756003)(53546011)(2906002)(76116006)(966005)(54906003)(186003)(8676002)(6486002)(66476007)(66946007)(316002)(64756008)(6916009)(91956017)(478600001)(26005)(8936002)(2616005)(6512007)(4326008)(66446008)(6506007)(41300700001)(71200400001)(5660300002)(38100700002)(33656002)(122000001)(38070700005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O2CFE09RPnG1mR//BUnQFxUXje9iyqBpPajrPUES8MjPZuf5MEfUFIERsMnV?=
 =?us-ascii?Q?ag/0WhbKN860rU+reoc+H1EsxAd1tCjR+bMh3TVOIEjuDWmFFF/07d+pn48y?=
 =?us-ascii?Q?qpBvzDVEaeryomlkinvm4WwKMPwLF01yiDHIoZwh29L/JOn0djOoXhETQpvY?=
 =?us-ascii?Q?LFAaYESYHZwC8uUO9ErtdE07AlqV+gELZBPe3sX8nU1QljIH9SHLojzTKUo2?=
 =?us-ascii?Q?pkIXbsgb1iuNU9tpztzodpphbxCTqkWriLCXLHEStwSwXr3O0ZFiMgelVOTC?=
 =?us-ascii?Q?dLXA2NF7gAOkjCz/6Yaw9LFRPsqFcnRhVdJPgWrFranx/0YlUxDQkeuRZFH4?=
 =?us-ascii?Q?CB/iL2E66Kl1WUqGFb6WKWwqTTzIrnHX94mo7Bu9U9ErBpV5qT5AWe6J4aoC?=
 =?us-ascii?Q?1apdfDvDlBNuI49bHRWyifAOq6/IqVddwXoThBsWgwxPM6SSqfbX6INebIo8?=
 =?us-ascii?Q?DlIT6ze5w17UM+d8RCEYCmrHLNv1Jskl7zTxFrMZvNYJN7XiGrbV8z5VMjdp?=
 =?us-ascii?Q?IqUFq4O4kmNbeewEEnkclmXgdm+brwXX8A1BQWOmpEBoXDmq1x2xT/KVrD/Y?=
 =?us-ascii?Q?XrOetJh7BRy/GRrXjqJt09BttSsGM6BL2L5v272EwOMsXPh5eW0bTolte+L6?=
 =?us-ascii?Q?4tkgOn2XWUulU00Z4O0godg5e5D683jIps9O8jhX/+5Qyy0todSU+vREZ1EV?=
 =?us-ascii?Q?KDE4u3MDq3FUtcVIvIwpQ1P73gYYE1DJh+uAyACVu5jfQMJY+fHglZPQy2v3?=
 =?us-ascii?Q?MefH6BG0Ro9djeCLEnMcWrHz+OXthEys5RHHXiKYSdvjYZO61sy8k5ufZF0I?=
 =?us-ascii?Q?oSEuNLiJQfbfzK6uztRJeyEnRqEO/PzFKqWU9gXXDGU/yTjpO4LpVmYY3/+h?=
 =?us-ascii?Q?235Hfa17cvD6nE08iSIwiazY4QRd9j86e2v2Mr6UiHJjijGxRdI4E7uujn2G?=
 =?us-ascii?Q?31/XOo7dZrd34itTiedTi55WX2qXnFCJMR00CvNMEZOz7ziRHMZ509Axi1IT?=
 =?us-ascii?Q?ZgMQe/imk0IgFARj8JTt086EAVBSqKifHQ5fako/d+K4N4HZkO5sGwoD4ULp?=
 =?us-ascii?Q?7ker+za0XpFMCX7bMuO6BjOfUD6Dyd64BUyPquj4F6Jtk7RAOGQIaeCViTNM?=
 =?us-ascii?Q?BWsm6i3TJVRmXgYqilor5SQ40ZEV+mFZ07klWUqa1NkfBPzO/4/tmmkl2b7S?=
 =?us-ascii?Q?mjJoCPKL/w2mMJgaLiKzD2dogkSCsRK0GB7CXNt5zCIWvTyorutaPwWgqD5j?=
 =?us-ascii?Q?kOvznq6UVZtiUfezsN/9yDs/zIfWYZDOK1sxDmooSutSVGRkvSOlsXCvAw8V?=
 =?us-ascii?Q?egIi/w6HphwHxZYzvvNiJ0xl+yG/7Y2SLi7ZAd8jTC3Cag0Gm+9qFb3bA09A?=
 =?us-ascii?Q?oBY2J6MQjUfOLbUIh+7aEHVuCstd93UQR936jF0s+1klYRHeM5SDQ0xnY0L6?=
 =?us-ascii?Q?h/biS9MpIMp6InCbB++9eohHHtvMtSru5xeiJ5Ww+HNOFivUksEPcCbXzc/9?=
 =?us-ascii?Q?bAfiE3UzRKmjBW1svBwnKPfj+YkXAUBWYCqG+OvTeaC4WM33G6kxOb/wEv8x?=
 =?us-ascii?Q?J2qGZ3O8Y3UNuIP+Ws18ctSVcqOTY2CRouOGyfb5oyUulh9fFNQola2zvslw?=
 =?us-ascii?Q?sA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14BD3B1984F7C946A51F1767383E493A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9618538c-0b32-46e5-a1fb-08daa2364d01
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 16:18:52.9764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZFKiqWzHHxEeRyH06w+E6jWIvi+kDxMOLjXDOTJEd6xYxTaAZ5hxK2D8DQARIsyUhUn2PO1xlWRMnvKiHf6kGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209290102
X-Proofpoint-GUID: SQifiUYUhSXxa6jq8uSSPW4HpHkD8CkJ
X-Proofpoint-ORIG-GUID: SQifiUYUhSXxa6jq8uSSPW4HpHkD8CkJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 28, 2022, at 8:04 AM, jaganmohan kanakala <jaganmohan.kanakala@gma=
il.com> wrote:
>=20
> Hi Linux-NFS team,
>=20
> I'm trying to set up the Kerberos5 setup with MIT as the KDC on my
> RHEL 8 machines.
> I'm able to get the setup working with Kerberos encryption types where
> the hash type is SHA1 (aes128-cts-hmac-sha1-96 and
> aes256-cts-hmac-sha1-96).
>=20
> As SHA1 is kind of obsolete, my goal is to get my setup working for
> SHA256 hash types (aes128-cts-hmac-sha256-128,
> aes256-cts-hmac-sha384-192).
>=20
> I tried that. The communication between the Linux client and MIT KDC
> is aes128-cts-hmac-sha256-128, but the communication between the Linux
> client and Linux NFS server is only aes256-cts-hmac-sha1-96.
>=20
> When I checked the Linux upstream code I see that there is no support
> for SHA256 (and above) hash types.
>=20
> https://github.com/torvalds/linux/blob/5bfc75d92efd494db37f5c4c173d3639d4=
772966/net/sunrpc/auth_gss/gss_krb5_mech.c
>=20
> Have I looked at the right source code?
> Does the latest Linux NFS server has support for kerberos encryption
> types aes128-cts-hmac-sha256-128, aes256-cts-hmac-sha384-192 ?
>=20
> Can anyone confirm?

As far as I know, the Linux in-kernel SunRPC RPCSEC GSS implementation
does not support the new encryption types defined in RFC 8009. That
means neither the in-kernel client or server support these types at
this time.

I'm not aware of plans to implement support for these. Cc'ing the
crypto mailing list to see if others are considering it.


--
Chuck Lever



