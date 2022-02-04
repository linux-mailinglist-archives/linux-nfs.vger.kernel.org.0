Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD554A9BBF
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Feb 2022 16:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiBDPRs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Feb 2022 10:17:48 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9330 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232586AbiBDPRs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Feb 2022 10:17:48 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214F3vIM006724;
        Fri, 4 Feb 2022 15:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1dxcbuucOMDYPnCqfBfzcu81fHvDn9XTfWRNwUDNI48=;
 b=VSPfMqSzImSR1ZDEpebkDIg5B3rg9ZUF/7PUKf12FPtQndgg0BWyAIH6Ea99OZDTl1m+
 7nFbgTAHd/NMWUfBcPauJ6ISQDlPGgokHdAETPlqgpqg4Miq64AVAByis7dxIMvc4wCz
 mUm60hN+DivqdfTyZOSrxRj6QG8OpM/LQpB7jeXyGOFp/gNL9jQO1NaEk9DR8bMzYTcy
 kGULxVv24fCJwrktJPm2nwQoLnTiB458oZDH/CkNrbQc0DsU6z/BFV3lUyJND03TREKZ
 rawETQjXMZ5E1Ue3c34aGPx5u8kht6qKWgz2wE55L7UAWi1qnxKsVaNv9+Iz5wxPimoR UQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hetb0v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 15:17:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 214FFYHr045266;
        Fri, 4 Feb 2022 15:17:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3030.oracle.com with ESMTP id 3dvtq7pwg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 15:17:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxqwkoOc0tpKSyAZ1Pq6ht/tJLo2FG94SLw4s6wEguSLXV7r/kC0G6JvNu5pReM6MoICBKyEHqmkz7L6NZB0DRJE0ch5qzc5gNn+XW0muw801mCfI3gpMuawu+ksm7wfq21kUrB9F/K46rMo1QplMnEWKwtQo7ryiH5xoYENf/PvHewWlXOhM/uWK2bSthFfvAOPvc/doaHp6s71LwGKCmvZeA2wzWLMnR610rVlZQGCxKJ3TPi+r99+W0sE9c72RwZ+EGYfEt5Iw8otjRbJIYeCBk6U4iY2Py3UDOcQ+rsV7URs3UHifxdMcg3ui26b5FvqdYoHNKySF3qn9A3NeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dxcbuucOMDYPnCqfBfzcu81fHvDn9XTfWRNwUDNI48=;
 b=Bg3YNPC6PJkJvG1xpfTRqjNUyoPWxFlb6qI3KZvjfub2+0geSJG7zGGVzccnQvPxCAAf+wc6JbumTH3niWo33g7Aco1U5laPVNZvb0NFcs9ul25M0dIS1z8GiQ2uspx+K5Pdy+bns0+Db7mX6R2eq0P4m2B0MEfRTSMjofrpLKM5r0e5C+onGbuISBYf3QlHmm+jylFdUx/gfupqzzKVafb5MYrdAd9DQc7neYNKmc2BTKKV6BNmBJCUletmVjEUTSubeq9QNrWJbGTrQ7WGJY3aHXBsex1XaFbaFZrUOvkpOwYER6ag6Sbv9Dbigwpv4/Hob3cRAVm+8gnUBTPrmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dxcbuucOMDYPnCqfBfzcu81fHvDn9XTfWRNwUDNI48=;
 b=dBzD+bxFyHmTSjxD85+rn4fV7aqwGeHy87IOwVhfAkCLF/gQMbY396J1EpGBaB58o17Pqccb+c3ms23yspVENnMt1mcFFIH4t3NCRr2Ys8ivpPzfMoj0GhRDE6Z31OIK60hFT5T+7RmgkzYPIUwVrKgA7N3isHqQUGQxtSi7Qs0=
Received: from DS7PR10MB4864.namprd10.prod.outlook.com (2603:10b6:5:3a2::5) by
 SJ0PR10MB4493.namprd10.prod.outlook.com (2603:10b6:a03:2dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 15:17:33 +0000
Received: from DS7PR10MB4864.namprd10.prod.outlook.com
 ([fe80::6438:8348:3b0a:5b00]) by DS7PR10MB4864.namprd10.prod.outlook.com
 ([fe80::6438:8348:3b0a:5b00%5]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 15:17:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Thread-Topic: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Thread-Index: AQHYGca9ZpW/pPf5rEWUIwyc/qfEDKyDgRyA
Date:   Fri, 4 Feb 2022 15:17:33 +0000
Message-ID: <87EAC6F6-C450-4642-A11A-55247C791D66@oracle.com>
References: <c2e8b7c06352d3cad3454de096024fff80e638af.1643979161.git.bcodding@redhat.com>
In-Reply-To: <c2e8b7c06352d3cad3454de096024fff80e638af.1643979161.git.bcodding@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60f28181-cd9b-48dd-a066-08d9e7f17830
x-ms-traffictypediagnostic: SJ0PR10MB4493:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB44934F4B8D5AA6653A5A764C93299@SJ0PR10MB4493.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0k30vAW+XuwkpT3/MX/hiEI0fpVa9bY2MC0Y2CfoMszsOnJnMMop7FuBlZEBNOMWgi+T1k3beXcHCW3X2hH3ChUfK+nLLl70W16P9e8joRPphoZJ+fkazjpqdgQXZfQYu9jYKG7uCgDvJBXssRLDi8jsul1HXYJh1twXuRLaa1neFkAh3s2FSpTjV1B/WDgBxNF9k1Aj8IPbn1UdQ/A0pVeGz07IMQG8WhSonokjj+Z6CrGroUaHVdZtJMPFxVZBekIIpSAzfqCHikYN2PGDFVIujSZjkfA5whj5Ajy6hpn7HDJXQpYqk6Hc7pYallr0jvDADsO9z1STnFbmqamlibA0Rwg1+zsN7q9dzyhUG9aRcF7MT4soUHT0ybYrvdLDQkT6yPycjHyLMnWvrvah2wTQPamDX/PXMtgfQ2wZSWjbuuwW4sFEtwgKrvyJWPCbKMQ5SaMaLxoaqqPYWCrQNEixYqQMVHcPXYScZ/WwTvwGPKA3CGFTbGIpnHA6+8ppCkl3T+P1chEQagHyG5VT83nXpxllIkV5npN77+yJWM6SxAj/KZadFREuWrHs6qCSHpVZx+JCedMX88QBI3wGqVfEnVD0bH5GzFSHyHBdvMMfxJmQJCz6prEwb9Y/thxnN/KM6uEjI64bWYx159UwMt6LTg8vaSDlRwlHf6MP+NsGKHqiDwwkzAL4PFKdnV0XOwgk4WZwU9CLakZxfZFB6opIYQdMsYUaA2sVA4/jE0yjF/yO8m6DYn3KsTMC3EmBSUclOPm1Ct9aZW0dZ2rrro4UDSRJq3hxVmfoXeEUzYU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4864.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(4326008)(66946007)(6916009)(8936002)(66574015)(66556008)(66446008)(64756008)(66476007)(508600001)(6506007)(6512007)(54906003)(316002)(36756003)(26005)(86362001)(33656002)(6486002)(91956017)(83380400001)(76116006)(38070700005)(186003)(71200400001)(53546011)(2616005)(122000001)(5660300002)(2906002)(38100700002)(2004002)(32563001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JB3//Bxbpb97VOF6Gu69367KwskPLdLrHdzRI+8BxLRObCccf8GXzHHBC3H6?=
 =?us-ascii?Q?crWe6oEbdDKEYtcx0wlMl8n0iG7i43bYkl7/m+2pcn8Co0LZ7vK/eCSO1MEm?=
 =?us-ascii?Q?cNJOcL6sSZe7xd1wXOWxKxUV4m25772sFs4uxJ8ENbffbw8f88+0HE12Ui6h?=
 =?us-ascii?Q?XXjVYdlImIe+CJdTJfmyatqUQH/kFUzwIyWWYosA2t8qYg3ufiaCfAN0tfYF?=
 =?us-ascii?Q?6lxZCfZDHVoh+69+DNNmVfOj01c8vFRULa0orQReMvtOVMGc0UNtvDt3yZpl?=
 =?us-ascii?Q?4ZPPUayC903gSoimVcTaSSCG1KuoVm1Hgn1VhtnrldREZ43dSAe4Q4QdsiGD?=
 =?us-ascii?Q?3LptueAzslCX7pBqga0T5HD1OVQ+4n/YIoJXVOocxnnaxLVqfsKah4WD45IA?=
 =?us-ascii?Q?Y1JYdjzCaxHdgo9+cgJ+b+lp6dysHaHojQ3hC6wGPW6E8vSQTzoPWYpIRYBQ?=
 =?us-ascii?Q?vxZHc4WbG+Ey51DHAosDJz855TM0w1s8ns8U3dcUhxqjbeSlQAaMhJZEs2FU?=
 =?us-ascii?Q?3XDkLW3EukswYjJjaB7SrPSWc3oYIr5K66d8MFxZPLiuii2KQrZ49Kr1G8mP?=
 =?us-ascii?Q?x7OZdfb/20/aYawjYDFFsq2D7VWL9LRsfWaTtAEQZ5xYttjrvq7Pnbn6ICnO?=
 =?us-ascii?Q?+dShdGVNxV16/l2kI1UmW0fejlUPEESJxwVeiBKTRN93IU4YXoeJflqiZI4S?=
 =?us-ascii?Q?75BUP5XBAU2Ii2D+qC3OxvFwMpkwnG2vF//CBwKIksAtrXTSFuad1xpOuve5?=
 =?us-ascii?Q?AGOMsLOsETAix6N0HELUTo7fcY1HYa5dpDVPj3NNysrNebarTS7RIol0UcMJ?=
 =?us-ascii?Q?x0A1+rCUIKVElEWu1gcFrrHn4ieLGlY3dTyxWCYSwUtecUXtReWgYOuyXlAQ?=
 =?us-ascii?Q?2XErCfdCZ98z/4Wde+ZtALZ0PLTjdsr5PJBc1lCDMt6V5fW/NKyyYVYICOMI?=
 =?us-ascii?Q?OH7Rb2jSupOOPbE7T+xd2/c81hBJlVu4afh8mxRnmOglDfl/4SrqGeqmvTTh?=
 =?us-ascii?Q?fVFfsVS2o+Embg43Z8UfsR2VwH2+jii4ynu39089pIqPnQxtfmzmfFOM6xQ8?=
 =?us-ascii?Q?9/ze2j/Twzjreo7xBiU9f6aNWY+IbRMfKwIwLaWImMow8mJurvCj2Rl37sAJ?=
 =?us-ascii?Q?kgim0+ImW1TzJ300D6RE8OVylanKPfE7uGM0jTZYBepaZWJAFOATiqbEWsyV?=
 =?us-ascii?Q?ODT1OuBPFHWYmHz/UfIFxes+4lZlxMZhU/nckblxmW5U1FiE8ubndCvTpg06?=
 =?us-ascii?Q?mnEut9S4+LGHICxqHrxwxVNdIkvDkmRMZkrzMrHARSxrYTEUTX7nySKvWokk?=
 =?us-ascii?Q?KwgMXvOYnPMeIWojtstoPa2ck9J5b0eiwZYefO/YNR/rhgT7g/zXGtdvjCqw?=
 =?us-ascii?Q?SKOv0tue9ZhEm+Bad+wjJUNvQQcqJrYeh9C6bqBz1zy0VgrezB8st5w1bCZf?=
 =?us-ascii?Q?josibIP0UUWJ6o9lkATutgDGIBt9H3TDOm8WlNd5E2hdxk/S79srLeFP9OMR?=
 =?us-ascii?Q?8wOXYFTinVcAZUqI46X3Y8Zip1hLvHxiNhXkFZ6SlhqSF2FxS7NJedg+vjgd?=
 =?us-ascii?Q?AU1npDgl7Lzhw5+8j/tQC5PW9ZUhaH3k8RyOeWLb3McQwbPLitxY5d2061tH?=
 =?us-ascii?Q?JRKbTMJT32Gdh6GUka0LmfE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9BE795431DF59F499C297146FCBED889@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4864.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f28181-cd9b-48dd-a066-08d9e7f17830
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 15:17:33.8285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SlAcTsjacPbJ7OuyQQokbu8JiEXNnz3fLV44N9Zd+z2F0aFLZf8DZBaqy5rmv6xCsPX+hirPFNPqccPYr6vF4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4493
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040087
X-Proofpoint-ORIG-GUID: LBKmCnw5ZkpYtp_QF-MDTZcaQuc3eJ08
X-Proofpoint-GUID: LBKmCnw5ZkpYtp_QF-MDTZcaQuc3eJ08
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Ben-

> On Feb 4, 2022, at 7:56 AM, Benjamin Coddington <bcodding@redhat.com> wro=
te:
>=20
> The nfs4id program will either create a new UUID from a random source or
> derive it from /etc/machine-id, else it returns a UUID that has already
> been written to /etc/nfs4-id.  This small, lightweight tool is suitable f=
or
> execution by systemd-udev in rules to populate the nfs4 client uniquifier=
.

Glad to see some progress here!

Regarding the generation of these uniquifiers:

If you have a UUID generation mechanism, why bother with machine-id at all?

As noted in bugzilla@redhat 1801326, these uniquifiers will appear in the
clear on open networks (and we all know open network deployments are common
for NFS). I don't believe that TLS or GSS Kerberos will be available to
protect every deployment from a network MitM from sniffing these values and
attempting to make some hay with them. In particular, any deployment of a
system before we have in-transit NFS encryption implemented will be
vulnerable.

Some young punk from Tatooine could drop a bomb down our reactor shaft,
and then where would we be?


Regarding the storage of these uniquifiers:

As discussed in earlier threads, we believe that storing multiple unique-id=
s
in one file, especially without locking to prevent tearing of data in the
file, is problematic. Now, it might be that the objection to this was based
on storing these in a file that can simultaneously be edited by humans
(ie, /etc/nfs.conf). But I would prefer to see a separate file used for
each uniquifier / network namespace.


> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
> .gitignore               |   1 +
> configure.ac             |   4 +
> tools/Makefile.am        |   1 +
> tools/nfs4id/Makefile.am |   8 ++
> tools/nfs4id/nfs4id.c    | 184 +++++++++++++++++++++++++++++++++++++++
> tools/nfs4id/nfs4id.man  |  29 ++++++
> 6 files changed, 227 insertions(+)
> create mode 100644 tools/nfs4id/Makefile.am
> create mode 100644 tools/nfs4id/nfs4id.c
> create mode 100644 tools/nfs4id/nfs4id.man
>=20
> diff --git a/.gitignore b/.gitignore
> index c89d1cd2583d..a37964148dd8 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -61,6 +61,7 @@ utils/statd/statd
> tools/locktest/testlk
> tools/getiversion/getiversion
> tools/nfsconf/nfsconf
> +tools/nfs4id/nfs4id
> support/export/mount.h
> support/export/mount_clnt.c
> support/export/mount_xdr.c
> diff --git a/configure.ac b/configure.ac
> index 50e9b321dcf3..93d0a902cfd8 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -355,6 +355,9 @@ if test "$enable_nfsv4" =3D yes; then
>   dnl check for the keyutils libraries and headers
>   AC_KEYUTILS
>=20
> +  dnl check for the libuuid library and headers
> +  AC_LIBUUID
> +
>   dnl Check for sqlite3
>   AC_SQLITE3_VERS
>=20
> @@ -740,6 +743,7 @@ AC_CONFIG_FILES([
> 	tools/nfsdclnts/Makefile
> 	tools/nfsconf/Makefile
> 	tools/nfsdclddb/Makefile
> +	tools/nfs4id/Makefile
> 	utils/Makefile
> 	utils/blkmapd/Makefile
> 	utils/nfsdcld/Makefile
> diff --git a/tools/Makefile.am b/tools/Makefile.am
> index 9b4b0803db39..cc658f69bb32 100644
> --- a/tools/Makefile.am
> +++ b/tools/Makefile.am
> @@ -7,6 +7,7 @@ OPTDIRS +=3D rpcgen
> endif
>=20
> OPTDIRS +=3D nfsconf
> +OPTDIRS +=3D nfs4id
>=20
> if CONFIG_NFSDCLD
> OPTDIRS +=3D nfsdclddb
> diff --git a/tools/nfs4id/Makefile.am b/tools/nfs4id/Makefile.am
> new file mode 100644
> index 000000000000..d1e60a35a510
> --- /dev/null
> +++ b/tools/nfs4id/Makefile.am
> @@ -0,0 +1,8 @@
> +## Process this file with automake to produce Makefile.in
> +
> +man8_MANS	=3D nfs4id.man
> +
> +bin_PROGRAMS =3D nfs4id
> +
> +nfs4id_SOURCES =3D nfs4id.c
> +nfs4id_LDADD =3D $(LIBUUID)
> diff --git a/tools/nfs4id/nfs4id.c b/tools/nfs4id/nfs4id.c
> new file mode 100644
> index 000000000000..dbb807ae21f3
> --- /dev/null
> +++ b/tools/nfs4id/nfs4id.c
> @@ -0,0 +1,184 @@
> +/*
> + * nfs4id.c -- create and persist uniquifiers for nfs4 clients
> + *
> + * Copyright (C) 2022  Red Hat, Benjamin Coddington <bcodding@redhat.com=
>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor,
> + * Boston, MA 02110-1301, USA.
> + */
> +
> +#include <stdio.h>
> +#include <stdarg.h>
> +#include <getopt.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <uuid/uuid.h>
> +
> +#define NFS4IDFILE "/etc/nfs4-id"
> +
> +UUID_DEFINE(nfs4_clientid_uuid_template,
> +	0xa2, 0x25, 0x68, 0xb2, 0x7a, 0x5f, 0x49, 0x90,
> +	0x8f, 0x98, 0xc5, 0xf0, 0x67, 0x78, 0xcc, 0xf1);
> +
> +static char *prog;
> +static char *source =3D NULL;
> +static char nfs4_id[64];
> +static int force =3D 0;
> +
> +static void usage(void)
> +{
> +	fprintf(stderr, "usage: %s [-f|--force] [machine]\n", prog);
> +}
> +
> +static void fatal(const char *fmt, ...)
> +{
> +	int err =3D errno;
> +	va_list args;
> +	char fatal_msg[256] =3D "fatal: ";
> +
> +	va_start(args, fmt);
> +	vsnprintf(&fatal_msg[7], 255, fmt, args);
> +	if (err)
> +		fprintf(stderr, "%s: %s\n", fatal_msg, strerror(err));
> +	else
> +		fprintf(stderr, "%s\n", fatal_msg);
> +	exit(-1);
> +}
> +
> +static int read_nfs4_id(void)
> +{
> +	int fd;
> +
> +	fd =3D open(NFS4IDFILE, O_RDONLY);
> +	if (fd < 0)
> +		return fd;
> +	read(fd, nfs4_id, 64);
> +	close(fd);
> +	return 0;
> +}
> +
> +static void write_nfs4_id(void)
> +{
> +	int fd;
> +
> +	fd =3D open(NFS4IDFILE, O_RDWR|O_TRUNC|O_CREAT, S_IRUSR|S_IWUSR|S_IRGRP=
|S_IROTH);
> +	if (fd < 0)
> +		fatal("could not write id to " NFS4IDFILE);
> +	write(fd, nfs4_id, 37);
> +}
> +
> +static void print_nfs4_id(void)
> +{
> +	fprintf(stdout, "%s", nfs4_id);
> +}
> +=09
> +static void check_or_make_id(void)
> +{
> +	int ret;
> +	uuid_t nfs4id_uuid;
> +
> +	ret =3D read_nfs4_id();
> +	if (ret !=3D 0) {
> +		if (errno !=3D ENOENT )
> +			fatal("reading file " NFS4IDFILE);
> +		uuid_generate_random(nfs4id_uuid);
> +		uuid_unparse(nfs4id_uuid, nfs4_id);
> +		nfs4_id[36] =3D '\n';
> +		nfs4_id[37] =3D '\0';
> +		write_nfs4_id();
> +	}
> +	print_nfs4_id();=09
> +}
> +
> +static void check_or_make_id_from_machine(void)
> +{
> +	int fd, ret;
> +	char machineid[32];
> +	uuid_t nfs4id_uuid;
> +
> +	ret =3D read_nfs4_id();
> +	if (ret !=3D 0) {
> +		if (errno !=3D ENOENT )
> +			fatal("reading file " NFS4IDFILE);
> +
> +		fd =3D open("/etc/machine-id", O_RDONLY);
> +		if (fd < 0)
> +			fatal("unable to read /etc/machine-id");
> +
> +		read(fd, machineid, 32);
> +		close(fd);
> +
> +		uuid_generate_sha1(nfs4id_uuid, nfs4_clientid_uuid_template, machineid=
, 32);
> +		uuid_unparse(nfs4id_uuid, nfs4_id);
> +		nfs4_id[36] =3D '\n';
> +		nfs4_id[37] =3D '\0';
> +		write_nfs4_id();
> +	}
> +	print_nfs4_id();
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	prog =3D argv[0];
> +
> +	while (1) {
> +		int opt;
> +		int option_index =3D 0;
> +		static struct option long_options[] =3D {
> +			{"force",	no_argument,	0, 'f' },
> +			{0,			0,				0, 0 }
> +		};
> +
> +		errno =3D 0;
> +		opt =3D getopt_long(argc, argv, ":f", long_options, &option_index);
> +		if (opt =3D=3D -1)
> +			break;
> +
> +		switch (opt) {
> +		case 'f':
> +			force =3D 1;
> +			break;
> +		case '?':
> +			usage();
> +			fatal("unexpected arg \"%s\"", argv[optind - 1]);
> +			break;
> +		}
> +	}
> +
> +	argc -=3D optind;
> +
> +	if (argc > 1) {
> +		usage();
> +		fatal("Too many arguments");
> +	}
> +
> +	if (argc)
> +		source =3D argv[optind++];
> +
> +	if (force)
> +		unlink(NFS4IDFILE);
> +
> +	if (!source)
> +		check_or_make_id();
> +	else if (strcmp(source, "machine") =3D=3D 0)
> +		check_or_make_id_from_machine();
> +	else {
> +		usage();
> +		fatal("unrecognized source %s\n", source);
> +	}
> +}
> diff --git a/tools/nfs4id/nfs4id.man b/tools/nfs4id/nfs4id.man
> new file mode 100644
> index 000000000000..358f836468a2
> --- /dev/null
> +++ b/tools/nfs4id/nfs4id.man
> @@ -0,0 +1,29 @@
> +.\"
> +.\" nfs4id(8)
> +.\"
> +.TH nfs4id 8 "3 Feb 2022"
> +.SH NAME
> +nfs4id \- Generate or return nfs4 client id uniqueifiers
> +.SH SYNOPSIS
> +.B nfs4id [ -f | --force ] [<source>]
> +
> +.SH DESCRIPTION
> +The
> +.B nfs4id
> +command provides a simple utility to help NFS Version 4 clients use uniq=
ue
> +and persistent client id values.  The command checks for the existence o=
f a
> +file /etc/nfs4-id and returns the first 64 chars read from that file.  I=
f
> +the file is not found, a UUID is generated from the specified source and
> +written to the file and returned.
> +.SH OPTIONS
> +.TP
> +.BR \-f, \-\-force
> +Overwrite the existing /etc/nfs4-id with a UUID generated from <source>.
> +.SH Sources
> +If <source> is not specified, nfs4id will generate a new random UUID.
> +
> +If <source> is "machine", nfs4id will generate a deterministic UUID valu=
e
> +derived from a sha1 hash of the contents of /etc/machine-id and a static
> +key.
> +.SH SEE ALSO
> +.BR machine-id (5)
> --=20
> 2.31.1
>=20

--
Chuck Lever



