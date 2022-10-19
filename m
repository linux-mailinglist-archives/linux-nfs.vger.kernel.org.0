Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4954604643
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Oct 2022 15:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiJSNDt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Oct 2022 09:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiJSNDd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Oct 2022 09:03:33 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2129.outbound.protection.outlook.com [40.107.114.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620DB357D8
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 05:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+ZnRNH60wuPSJL/+l/z3kw7yHUKVcQ4P7JW8I+rKr9xIM3SZro/3gxB8cd3dku2Bg9FmEypI8hYZdtpMqwfzdTe9KcMMnu3N8/vNmYUsEea6BmkoTwz8LBlRK0CTnQYkNwOsPqv+k/rxvxZmTAeKba7I2gSWQkqdQGjRE+5xDwM8x6JHQ1FQ+CSr8Z2CrtoCIDIrL+vVSg/VMwM+vN9sNep3lzzIemw6ubPftA2Nzw1oCGhOm7ETHOxbyfdA6Cm8hXTKJgnykerkQZ65GQOAHGSBD8h/btbm34VDSAFMFPckuoyX2hdGfmsvjJCWFUwHd+n3nzq0wsqKJda1irQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CC9+oTPnp8csQzllcjosiHUXKKthOfUFxZ2azv4S6v8=;
 b=W6AppzOoKRBsbjasUBnIxULJceqEPnMxUfbAIsg8IYS4tvhcHL2FXw72q2wiHzEv604tcnwrMEeJXg9MePeMZc8H6qZk8i6JY+m3NDtnV08A5Rq1HnrczB7mn0KclRDZSEen4JuhFmlfVhUKVCMuQ43PulII4cSL1lg67kxOBYZnHqgWiw59uF+k99E8M5f+f0n6829qFmjRfeT6qcf0kp7HFCtETQEr4p49UpAOZhnPsjhRV8GCUGS0ZIQsGeF2fmefRxpg9SwoBHz7mhOpNVsMMsPITUVhBkazEdxHcnJ35ElhBxqHoTjV5zKTCOMlUvZcc+A41bgdTytbq+6Idw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CC9+oTPnp8csQzllcjosiHUXKKthOfUFxZ2azv4S6v8=;
 b=L0lg6Nl5M+1xz66R6dDKYFUKq4cZTICWROxcCzes/J32KVdtjgUsrvpOq97OjVtoa3kWxLVTSAWCqnDvgqMGNE8OzkiGZTTG4+WvgysFP7sqnUjug/E4myO5kxUCk4iAcnNMH4lMCxj7SUiZNTzK8TpHXDViGDN3Dm6zBxluN9Y=
Received: from TYXPR01MB1854.jpnprd01.prod.outlook.com (2603:1096:403:d::19)
 by TYCPR01MB10763.jpnprd01.prod.outlook.com (2603:1096:400:297::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 12:46:39 +0000
Received: from TYXPR01MB1854.jpnprd01.prod.outlook.com
 ([fe80::7c26:5a68:d3dc:3ba4]) by TYXPR01MB1854.jpnprd01.prod.outlook.com
 ([fe80::7c26:5a68:d3dc:3ba4%3]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 12:46:39 +0000
From:   Ondrej Valousek <ondrej.valousek.xm@renesas.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Patch nfs4 server to advertise usage of v4 ACLs
Thread-Topic: Patch nfs4 server to advertise usage of v4 ACLs
Thread-Index: AdjjtsW0W3hLEqUwTbu+VlLdLEMrqA==
Date:   Wed, 19 Oct 2022 12:46:39 +0000
Message-ID: <TYXPR01MB1854EFC8F9631529CCE996B1D92B9@TYXPR01MB1854.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYXPR01MB1854:EE_|TYCPR01MB10763:EE_
x-ms-office365-filtering-correlation-id: 23abfd0b-2d6e-4da3-d541-08dab1cff755
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B8e8UseX8hHDy1xIsijQHrChiIQvhrq0JDwGRhWyLKlIPmcZQzWzfgobiFgHdJRLEr6+43MYkm89SAXXPW4dzie8SxYNNX+a+DoVY5OlU6UiY4dc07+r375JoPKWBKDdxFYlBY2pvbwiQlQUFJQ4pmVvDafny1N2HxN7Upcsyj7v2DNCGcnCdpYon7xXCaGClS0MGz6xUGBNr/SDzZ0TPJV8lcf4JR294HVDf3Ovu+QQITMtDVykvlJYTCnOhSOdvyaoXRwiF5S+O0vI9EkFM4bn/3i8+iybH1DOEuh5gTO1tiPa6xsz2NbHtVEEZbrjN7T73H2pk56RcR8F4VcsGA3xCh0iVFU8yThx9Rb/8AeiCUzCIF/7ysIPFaQjTtyEYvXRWc0GDbaUAhCeWtpDim3l0f6BgqgZaDb5pbVYiEbdeVxTta6xK59hKwbAhDn2uYZkmIjw/Wk1QTlFdtA7IUP1xWgQWSG/GA5hmjtfXboMzKuHEytokqqj1RZoWj8hQc0duXoZIhTW/hVxyDtmzK//PVNk2X7Q2K1D2wo+Y1Iw1l89zrISN6Bcqlzlk3hOqFYPfMMiF6ax2ffnlQev4T04Yi3ltEdroZKR1Js0N8gWzkeuJ4dKAMsNp6dmq3nAv3NMsTX9BGj60Dh9zXNS8VXfwb63UqJennA7qyzSoJV5iJhvQFF4EEpFV+2VBkjLZIRe2rfS0EaE8Zo5SaOtxuvHOcQt+HvitR08fxboNfS3MRNFA9bLhzZwzP9j8ciU6ICIKYuH6WWMai62xCMCyyQvUfn98PasQYJv1OUbHn0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYXPR01MB1854.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199015)(186003)(33656002)(2906002)(71200400001)(966005)(122000001)(38070700005)(478600001)(26005)(86362001)(6916009)(66446008)(66476007)(66556008)(66946007)(64756008)(8676002)(76116006)(38100700002)(55016003)(8936002)(52536014)(9686003)(7696005)(83380400001)(41300700001)(6506007)(316002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ij4D04rMsMIGrFJvCGgzPSO5bRGF8kR1N/5BkfKPovlWD9HP5spFoaQ+H0uw?=
 =?us-ascii?Q?+aR+9aTE0C1yeoEz+VPRPDzp+uDLyXDl9ceUhIXOIlhfwJ9NoRxewCYMchxC?=
 =?us-ascii?Q?hjjGwwv8oPzpLqR54Eq9zYtEAmJJNSTPREPaawQvPsNZKKaa6dRw38Re5ySU?=
 =?us-ascii?Q?EASxR7OQ7qKICpz7G07SAMxArMF0MwzRl49V4+G3KQagmTbkkOrJRpdHCRwI?=
 =?us-ascii?Q?DMQ1lB02Ex9iafe49QXNFXH1yd9dXDONzI5dmBBUYADGRZBk4tiv+lyLb/Q2?=
 =?us-ascii?Q?0KvfBsy3xOh09Vuo2qSJ6crn/5EljVnuFsrxwHxSDa/+BKqlI3kQ8BqPJHCj?=
 =?us-ascii?Q?tKAbRP7MmasL7spzuprZqeiWp2F3golWm/pardRBr/jRb1RRdlQ75vWQKzzc?=
 =?us-ascii?Q?2aCUTedF7hwRCs2q618F2euyuQAen+58yBEDMGjiI2DFBY6Ipwr2q7sdFaNS?=
 =?us-ascii?Q?JAh25omEOmZsULsclesqwnu0aEO8PRgD8tvSADC+EvFyHiArUTU7Kd/HQ2xU?=
 =?us-ascii?Q?nPluETTess2P5SuESlQUy4tDQUDWKsgLg+3CL842wQ7veBQmli0gsyFm4o4P?=
 =?us-ascii?Q?IvpjkcjVHO1dAFor5VbF5DJ2cvpYA4WkjiUgpq1dEvNwaM/iRKP77DxVoejM?=
 =?us-ascii?Q?QaX7NomnMHgj7Gan6p6bBsIRE1eQHdWWnwr+vuFDg7AncCtkKdeOrrVh+5UV?=
 =?us-ascii?Q?SrwRy2R1o/Q+6fB3K1kE//BInEaFe+myvtrjZalLSfAaAQ0yNFtE/M8pXxDY?=
 =?us-ascii?Q?n2FrB+UTx2sCrbZ0IAQrgeEL8OhpO0NBbfO4SNr3RnEZj/t9RuO42PIJrk23?=
 =?us-ascii?Q?8sekzzgfjAkjKSGjyxokhGKNuSnmuysI0mVhHMrK2RGLavccbAOSnIxz6tuW?=
 =?us-ascii?Q?jIw9OD1b1mgMqQtW7gTWZMY+53Of65NG8iCpNpctnMuea5Vs7V9z9wdMl1nu?=
 =?us-ascii?Q?o/3MC1gX/0hnfllcgC1i03Dvm1AfWBMltvh6963l514YemuVkesp5RGjGXUC?=
 =?us-ascii?Q?AoEZrHSfzdJJ95SePAbTMntRG44U60RP+Ubn/i9+SwOk+1k3LK+v/JiuHIrw?=
 =?us-ascii?Q?e1s8f+0DBthv4/NN9XaGarZb7heS2nt4HxPZlz24XQYYMpagdeZlkl3HnIzR?=
 =?us-ascii?Q?AINh8PUGc+2EvZAm698/JwsJd0uPfOBqs7Lcq/X/6OGjryBTzegN9Ypi0v+L?=
 =?us-ascii?Q?i2ifoilxZwsJyWK2ZeJf1kG+toV54SdMUIiMAN8OeS1wJ2b/V+1y5G3EC4TN?=
 =?us-ascii?Q?ev9CLMCCHlRt31QUeTWMsW2UhPWrnapMtsl2QAEz2ASV8w+49AAqreTM9CvG?=
 =?us-ascii?Q?qp4UF3H38dB16tGiYR7wJh0zO+Jq15wHB55cW1JWkvNtFRbc25U03lXsLtKD?=
 =?us-ascii?Q?erIItGE6pbcBlFgxD6fOMzxeiB0XIIEQXBCeX9UpkeQaXcIVGgSVp2osKLuX?=
 =?us-ascii?Q?1WJ3S7uxb4qAidW+5JrlQO59N2hEOPtVbGoemRH1mP95fSPqILXicQSED7Da?=
 =?us-ascii?Q?AU2QDUv7oRHWGaRFmV/43qgH/lhmZBKTqDg9wk0ma3DdDYKv0eZUIuwVGHvZ?=
 =?us-ascii?Q?Z50lSMqRgoeXe6GiUM5bVmKmolIAdfHrkar2ALtrCBVsGGQzIkQzU8/ozhg8?=
 =?us-ascii?Q?GA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYXPR01MB1854.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23abfd0b-2d6e-4da3-d541-08dab1cff755
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 12:46:39.1665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q/pbEwQkuO/IEDnnjxl+D2QwYd0VSafcdAXzgMZjtjde0LVr/Wgf3zLf01b1DhLQP2LBkQtx+qccoze42s52TBe70tGZvdhVQ2kkUy30Nm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10763
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi list,
I was trying to address an issue described in
https://bugzilla.redhat.com/show_bug.cgi?id=3D767584
basically AFAIK RFC7530 instructs v4 NFS server to send a fake ACLs even wh=
en the there is actually no ACLs (aside of standard Unix attrs) defined.
This means the v4 client has no easy way to figure out if there are ACLs on=
 the file/directory or not, hence tools like 'ls -l' can't display the '+' =
character in front of file/directory much like on FS mounted with NFSv3.

I was trying this address this issue with this (sort of naive) patch:

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1da721515b61..ad9324b25b7e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3182,7 +3182,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc=
_fh *fhp,
                p =3D xdr_reserve_space(xdr, 4);
                if (!p)
                        goto out_resource;
-               *p++ =3D cpu_to_be32(stat.mode & S_IALLUGO);
+               *p++ =3D cpu_to_be32((stat.mode & (S_IALLUGO | S_IFACL)));
        }
        if (bmval1 & FATTR4_WORD1_NO_TRUNC) {
                p =3D xdr_reserve_space(xdr, 4);
diff --git a/fs/stat.c b/fs/stat.c
index 28d2020ba1f4..da5b8bfbcd0f 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -20,6 +20,7 @@
=20
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
+#include <linux/posix_acl.h>
=20
 #include "internal.h"
 #include "mount.h"
@@ -43,9 +44,15 @@
 void generic_fillattr(struct user_namespace *mnt_userns, struct inode *ino=
de,
                      struct kstat *stat)
 {
+       struct posix_acl *pacl =3D get_acl(inode, ACL_TYPE_ACCESS);
+
        stat->dev =3D inode->i_sb->s_dev;
        stat->ino =3D inode->i_ino;
        stat->mode =3D inode->i_mode;
+       if(pacl){       /* ACL of some kind is present */
+               stat->mode |=3D S_IFACL;
+               posix_acl_release(pacl);
+       }
        stat->nlink =3D inode->i_nlink;
        stat->uid =3D i_uid_into_mnt(mnt_userns, inode);
        stat->gid =3D i_gid_into_mnt(mnt_userns, inode);
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 1500a0f58041..2ab453ed8bfb 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -6,6 +6,7 @@
=20
 #if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
=20
+#define S_IFACL 00200000       /* ACL of some kind is present */
 #define S_IFMT  00170000
 #define S_IFSOCK 0140000
 #define S_IFLNK         0120000

... which aims to inform the remote nfs client about that no real ACLs are =
present.
Question - is something similar possible or doable?

Many thanks.


