Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB8745A926
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 17:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhKWQrp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Nov 2021 11:47:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50788 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238012AbhKWQrb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Nov 2021 11:47:31 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANFkMj4028835;
        Tue, 23 Nov 2021 16:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jKhgZCHWyNjEevazadh2KQ5hZJ3ph0F8zrh6q2zKK9k=;
 b=KC/EutJlxVbU6TXzRQwIOEfwlYolFt+Nligopr8MDQyIqsS47xtSa04wWSTWscY0dqC4
 3qFRTQlyc4l9S+zDNXHoDYfaP9cpCYnEgY9p3EKYJ2rjnaQuaIbTPsScfEuy7Z2BYEez
 4lkLAMCehYVRCGqE4JUEcjG10fni/nqmjV2K24foYfwtKOkmoaC0uG4rQivOglqIMcSc
 +iKXv7r437wqpMhxAvjI01OVkjZ82B4QF2ON8Zl1z1o9AS6Nb8itiLEN7F1KYEG0S3M+
 IiyVQhspjEBEyWbyjB5p7KV69CecT2uBUQ1u3A+djdNhIgCEIoNAXU1ufyiLD27o88a9 pA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg46fb63k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 16:44:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ANGV3c4169073;
        Tue, 23 Nov 2021 16:44:16 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by aserp3020.oracle.com with ESMTP id 3ceru5ews6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 16:44:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4mrZxyq0lPcI+KnDaVIzkAYXK03xxigwZid9sZ1v0F0+L3v7lHGgfqCh1OlwJjIgXm2q/ICup/vK20Ar3dEHIJ2DRLB61Os849kaGdUgQ6Y95UOIN/j6UXVgBeRButA/pfpjxRktW5m3pAzyODrWGzlT2ggOhAhFl/AI/H5RI3v7SVWNE4pLH5OMfDN55OH1nbpTimM97PTYR0u1OS3a92OK+unrZxAu56qkgUv5HkcTNovOAHendmEFWeigsl20RVQ1bEW+wnDjADu/o9fWi6onuV0yqgwwTh8LqyL1koJXkTCKUoqbLd5N19AL8rzewnFN8+U55jroptLRz5SzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKhgZCHWyNjEevazadh2KQ5hZJ3ph0F8zrh6q2zKK9k=;
 b=ZzzTXUQ4V/35gQ7sLFgxEVx0W2kf4R4CCU7TaScubNpeoM5qvmGrajiKjCKm85ldfXy++2jUJNlopLDQOcV5IXL1V5iJvtbiFF2MUj6II2clq9C9mXwNmHcpnqcrMdSLqLQJLiqzbzMRkfrcWBjXs1JpsGjLSo8S7HMwcbzzJjTawIzWUDwEWZlPIqKUyiP2YoUebu8aD7Gfxpldq3wCnlcnLn44NaDWdffmz+DbOT59//0duhIqDS03BrV9JlIRkp0KkL5k8DUw81jMHqKODQfSy4NPBEEU4iGEn1PtrBfcKu09CzwOxKUh1ea6AM9VRirCp1hxHKvQDYZvvs3hrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKhgZCHWyNjEevazadh2KQ5hZJ3ph0F8zrh6q2zKK9k=;
 b=AWIeNFuSDxeV7mXDr+AzhsI1z38HtSjDB9Gwt2Dh/kBbu7T2w/8rT0ivXegHaYPY2Yxtu30pkvMJy6ZziOMAC/g/WT2ki2zQsyX85l0uJIPjAeu5lowSsBNlA9HSGEmZAJyTDZ/PERMtuCSeIiRKKC56htUZG8zhyZXSMsVXwKc=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3720.namprd10.prod.outlook.com (2603:10b6:a03:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Tue, 23 Nov
 2021 16:44:00 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f%7]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 16:44:00 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 02/19] NFSD: handle error better in write_ports_addfd()
Thread-Topic: [PATCH 02/19] NFSD: handle error better in write_ports_addfd()
Thread-Index: AQHX4AnL7ZLjXXV6dUG8wvLXqxTiAawRUo0A
Date:   Tue, 23 Nov 2021 16:44:00 +0000
Message-ID: <3B93593B-861F-4816-9259-EBB20FDB4375@oracle.com>
References: <163763078330.7284.10141477742275086758.stgit@noble.brown>
 <163763097543.7284.12067402792054742606.stgit@noble.brown>
In-Reply-To: <163763097543.7284.12067402792054742606.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d68b8d8-d0db-4962-ce4d-08d9aea07375
x-ms-traffictypediagnostic: BYAPR10MB3720:
x-microsoft-antispam-prvs: <BYAPR10MB37204C5255916F03103EB64E93609@BYAPR10MB3720.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JIe8iW5yX47xxgeOe9YirKtqOHTp3wXfve8RDUFmT/mWHon+qlfFCFYOUFyhAddNBjeheCKYPG2Y4RORo0k9kXlGucLjKMmQdjM6hMN5fV6LveGH8mutNWY2vp9lgMnk3M1B6lDgnFuI+B1HfY6ZpMQt1vctJz2hM8z0jWIQvxV1LIbB+jAIobS0c2fFBjF+xVH8/sb3Y/g+6/FzR3TjiBUmgmUORJHpn71ANTLtrdiw4j2UuuduuHZdm9NhXzmVrBqnDYJZzS+TwCZ1RcLNULnWIVqPMmjOldKtRs6JHsezKKrl2m+D1EezbGR6bytgBghJesaEjBXrLbjtSgqRbfIecWMp0cGrDVGkaTBp4azJLpGgkXhG0+G9GCOdev8t4sy3OxCmhkNdtDmpKiqpvBxSUTX7mnZdQp8hPasrg0lIYy4zLdp8C936R4oAh5GLTRAOjDaBpi3+5yuCpqKg3cTfjY4T9ezCstoYw5YV0OrIrxcSnrUCnam1D0nmig39HyMKNYuA273I0XVxr2dkGFZlRy2NzY09XsRn+u8iyIO6cG0NdkNBbrLKGZ/H91GAVHk3yZ5AUL4NkhhwMknoXrS7YxsMaw11l2Jl3qE1KEq7UgHmcGQkcNqGo+wh4nr65qTdPWaUcgGWSOEFV7Z0hrwHDwFEFmsVtk4TFWPKIrcjRzFnw0VuyzfHrRmBEWZjGN66BB719XyCKkUnCcYd/nYHO49QgyBnMz+AWf5meB+MPD0DGyG7K9+xGBg9o9AI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(66476007)(122000001)(64756008)(66556008)(38100700002)(66446008)(6512007)(5660300002)(508600001)(316002)(8676002)(71200400001)(53546011)(6916009)(36756003)(86362001)(38070700005)(83380400001)(6506007)(33656002)(26005)(91956017)(2616005)(76116006)(6486002)(186003)(54906003)(66946007)(8936002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ard5WXUB+945ZxZ/Mwm1zErmAvPOG4U7DynF+5esdiILkqMJmoyyaAOemTL0?=
 =?us-ascii?Q?uIljlqv/bRnPuOuI7dw1Uv/C+RgbdfPrwzNFuQcB5rar6fcs7Fmn5NVCgJmY?=
 =?us-ascii?Q?I1QdOMV13hiAvZ0hr77bBDVXNn7e+Iyd+mnxII3b62LT9Gh4EcI3I4seuWHe?=
 =?us-ascii?Q?75Xq6ZCcn3C1uRCfvEDjafFDtTNTTWymVZrEZlZJU2TikhcMZmy09/XTYZKG?=
 =?us-ascii?Q?SkVCqIZNTKFPQ1PDdZ+7dY1BDQky/0FODrRqZ0co0BG25Ppa2ND8IQeJh9ag?=
 =?us-ascii?Q?WParMpUg+LfOENAzNrdCUt9KxxgxMzGmBUHNJJrXKJ0l7Fkh4uzeXIV3LgaF?=
 =?us-ascii?Q?71vADeCQTF6BW4adbwdXlNPKS4CgnOqLWWQ4hHkwhhoUSWPefBxzzD+yYLJq?=
 =?us-ascii?Q?APYaU190+hwOh130JYozgQB/L3KB+1ut3mRHuV7vUTd1wrHUlD71hOEKqC6P?=
 =?us-ascii?Q?UcLVndt1WTnS+4THB5iST0VA1UhCNGTtqTivZO8p/zrMG5SzlT7PTteBodWV?=
 =?us-ascii?Q?0e+QNPyPWsptWb3yB0NzkPCicmwJPZweC83LsGi9OyEZdKD+Y0Oq2NHt+ojr?=
 =?us-ascii?Q?lw3KrU+qvnskxubY+lm+wROcuCEaYJoRkMtkKdGUp26m7Ug9d4qK9BgbsG+g?=
 =?us-ascii?Q?CvIW33GVDYYEaUSb7K1WhDh+228auvsMwiEf8XqwBLQWMEYwMkhajrTQI09q?=
 =?us-ascii?Q?Iu2TnYS+ZNb21nYSB34/vB11zTQE2xTHyxgB3iJZyRzvCXMJxiDsoSevQEiz?=
 =?us-ascii?Q?g69TWbMBEtR9U35mIE6Y/oU1rUgB2y6yNL/s03aavaB03VTOJ8j3PJxH22qU?=
 =?us-ascii?Q?zl3+akEX3RkA+f3DOhM/5MTRVoP5ljZhj1V7n/0DVrZkLomYxwCsYUPdxF/x?=
 =?us-ascii?Q?5FYcPV+2Q/v2W9U8y0LuhXcuA7dpGqjjdb4ofUYI7FxA80cj1hpsQiV+4adl?=
 =?us-ascii?Q?WO6qaGh1EXizAi7MV+z5b2YukAZ0M2WuB21UXf0lnYlOBE9b2/xmQplTCmby?=
 =?us-ascii?Q?PMHlG7Xtf/3wTVU641ivPcvpurHnJoMQxN3l82xi5wF5KUQW1aCNbcNURyob?=
 =?us-ascii?Q?APoMftwbYtZWjhRUNSH2+ysIM0Gc1QeptvXzAhhqTP7Khd3ohLkpK7KPLbzL?=
 =?us-ascii?Q?14+yOrMQ8phQzDhxOhHkQq41Jv5uYyDQ41owN/xTWmZvwo8jKAguyPut4VKW?=
 =?us-ascii?Q?Y86WK7GaChKHygiIM2wHdzyCb3LpXPA4U4T31PMX+MyeDpmOPzJOXBKw+pb7?=
 =?us-ascii?Q?g/gyLMvv7JJcyKJjoKtd1IjR42n1R2e8P3QNriLynfdR2+4ekU14IkNeDSQb?=
 =?us-ascii?Q?UnS5hozmbE15iCsFcNnIVnLq143npkrV9frv+iJ1RrDvZNw8NV+rlN3rC1nY?=
 =?us-ascii?Q?ld5gxYJG3r658Q5oYfXEi2EyeTPcXuOP+IsV+bDDrNOvbT+4v6tO6gkFachh?=
 =?us-ascii?Q?7klWoPTKR04LT7jJYuOx+hmjIDEQqV1qRDWYqg1VXObhWIoy4ruch+lOhhlo?=
 =?us-ascii?Q?pAKOxD+pwPgj7P6EoTosNGu2KRrALDtafPWe3u28Vf5odbKhqiznDTPYtyhE?=
 =?us-ascii?Q?Bg3Vmb9VuUy5AvUww6iUJJ5acICUv7YgSS8mZWOozTJg/GQq52ZsJ1GLuLoz?=
 =?us-ascii?Q?S4p0d7KXEMqgW67L3RrStD0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A70796A637B334A8A16AEFB0F587650@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d68b8d8-d0db-4962-ce4d-08d9aea07375
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 16:44:00.3661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7z2LS/1myFQdLF5AhYrn/NGkAeL9swOPZP340LfuBrhqKTN/z/3Y9YY4B8+Vg7BMERptmGUEiRnemg2NuB1/0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3720
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111230084
X-Proofpoint-GUID: T33nyBhU8UFqhfLnTUw-M3YVvthLpiEV
X-Proofpoint-ORIG-GUID: T33nyBhU8UFqhfLnTUw-M3YVvthLpiEV
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 22, 2021, at 8:29 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> If write_ports_add() fails, we shouldn't destroy the serv, unless we had
> only just created it.  So if there are any permanent sockets already
> attached, leave the serv in place.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>

This needs to go at the front of the series, IMO, to make it
more straightforward to backport if needed.

Though ea068bad27ce ("NFSD: move lockd_up() before svc_addsock()")
appears to have introduced "if (err < 0)" I'm not sure that's
actually where problems were introduced. Is Cc: stable warranted?


> ---
> fs/nfsd/nfsctl.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 5eb564e58a9b..93d417871302 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -742,7 +742,7 @@ static ssize_t __write_ports_addfd(char *buf, struct =
net *net, const struct cred
> 		return err;
>=20
> 	err =3D svc_addsock(nn->nfsd_serv, fd, buf, SIMPLE_TRANSACTION_LIMIT, cr=
ed);
> -	if (err < 0) {
> +	if (err < 0 && list_empty(&nn->nfsd_serv->sv_permsocks)) {
> 		nfsd_put(net);
> 		return err;
> 	}
>=20
>=20

--
Chuck Lever



