Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E56E60DD7F
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Oct 2022 10:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJZIsk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Oct 2022 04:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiJZIsj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Oct 2022 04:48:39 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2136.outbound.protection.outlook.com [40.107.114.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3C377541
        for <linux-nfs@vger.kernel.org>; Wed, 26 Oct 2022 01:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfIqSZ27jnMNr1xA9tzrKkH20MIGWfqbQBGpEz6A0Vn9FjkyA+ZU1upxnvmBpxn6gJRDEjaIPjYDunUsiDUfNsha1hnClf65j+zeCAc5/TmfO0wC+va9eTQc6PTF8AW0IqIu7A+JpR9Os0eEkbUqFfzVXp+x54M0rzR3gHD40fAEkGwgy55YH3FNNFDQSjdJnN6hej/PQ97CDYmJj7P9KgkigTPen+hiEnP8Ww2STdSfGX1/mq2a1YVBTzsWGSfpFHf4wqd3nK1jbJPXxa08V//9z+NKnuL56ZhX6V/LYcPN6rNQkqj5LS9sf1R9DQMiObJ9JWyCbtSn8C89yt4Ugg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6rUg0+tfOsdcmzwAzYQmpLYetcwauxiCoZG3ag4fpc=;
 b=Ssr+9AyKSvOXcFXd7zmxKvbO9b7sKsUiJ8EshlMVx5cBC3IG26CeFw8QP3Bg3Iq4GqD7F3fu6r851oFTB4Azb/k5gfzJX4P1hnqM0jkRGz0Gvuq75pb2lG+MCVVF3be9/r1/W7IloNkCiQWWWLGMCLu9yj3sPCFX9C2C7wLoGkld1KI7kMCLZs8EWeILKTXtxKykoqz8SCsJQmSYuIo27BgXB5RRQ65+cpvbenRiwNEb/IKIdChpDIRMCEkVWl6HqBsU1Qn2QBWFyuJaq0mAr2JK7z37OcxdEau+63ZGFYDuubMF6zEClO3aa9t1XTXxeQwht0J7OCKd1Ck72bk2mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6rUg0+tfOsdcmzwAzYQmpLYetcwauxiCoZG3ag4fpc=;
 b=VM6zNY9d8JVSRLZl27Rq3DmSAbZah5xfNZ0FpGeSTrpVtTikB+d1hZBkodagPA8+KUz8xPdQgyCoqI8jNO/Z8Cj+bCFTZk1CZks7fJStDpAlFgaYa3sAWETz71Mo/J+WtPBW2oAmf2J7zMobXfBG3GF/9vftpsDojkuevbbL8oA=
Received: from TYXPR01MB1854.jpnprd01.prod.outlook.com (2603:1096:403:d::19)
 by TYWPR01MB9791.jpnprd01.prod.outlook.com (2603:1096:400:235::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 08:48:35 +0000
Received: from TYXPR01MB1854.jpnprd01.prod.outlook.com
 ([fe80::7c26:5a68:d3dc:3ba4]) by TYXPR01MB1854.jpnprd01.prod.outlook.com
 ([fe80::7c26:5a68:d3dc:3ba4%3]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 08:48:35 +0000
From:   Ondrej Valousek <ondrej.valousek.xm@renesas.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: [PATCH 1/1] nfs: Move ACL xattr definitions to linux/xattr.h
Thread-Topic: [PATCH 1/1] nfs: Move ACL xattr definitions to linux/xattr.h
Thread-Index: AdjpFseyCVMG/398TgCgX5c43WmIgQ==
Date:   Wed, 26 Oct 2022 08:48:35 +0000
Message-ID: <TYXPR01MB18543A8B371E885CC9AA497CD9309@TYXPR01MB1854.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYXPR01MB1854:EE_|TYWPR01MB9791:EE_
x-ms-office365-filtering-correlation-id: 1a4c75aa-06be-485e-433b-08dab72edeb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lP9zrDSxBsQ3oCnDSukcyXt3zrlrM01G6JKktxcIc+UZVgg/7dIFFiN6KiSecDvThqznLTztNv/pva15BaEXc/k3nrQYKmDNrm98txqCRMLIiv10dsiUc4SWCdinAG2v8c99SM+H3J9q1PrEn9ytvVitsIdToz8aCZ5AimkEfodsER2FprlEnpRUrhSOETbNmdO7G8qVWNYlLxtk5u6iDzIDjdKj5ckm55j+15kdrpzUIF1E1QI7v1umeeNGdU0tJYr49NYTry3UFBNFQYTwD2mPiisdailYCWDDU+kkdr/+J0Ul3IvdvzvVushUD3LtnkUTQaJWS/49Pv7umyLtpQbtzXFPh31HzHximg+v6Hq0r1eL+tHbYOSzk6wDgrEt/jU4sEgr+rGUrUWsf4lzDvq4DFRvPgtqFX7L+MKxpizbpZE9DnmpWherV5+60XDoiakuHg4YhTdTxrnCnWwGcvLJccprQFKrNKGUkZ2NMYlpk6zPiKijFIGHBvl8xre9lWdt6ZtBrwO+ozKb5X1ntqzTyU+OMA5D5F2zOyA5p4XpRQ7DoCKrOVryy6BELH34vIumPc5H2TAgDnEOkQP3Iy+LXpTKUL2mAHkJVYOydd6usWlaCTbzlJN+rUxgsctdxSvO4sfx/izLrGpIAWWSVycWufP0reYhWPW2oTOJftCpd0wm8S4vkt5XTm8EXgKZNvPpLPsAOkC1yH3tnuFtoDuiKK+H4HQVnt1S/AYWsZpZT4xc1EM7qurCPQgb8GWH7uJb2qGfj1kCZjZPuXgcTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYXPR01MB1854.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199015)(83380400001)(33656002)(8936002)(86362001)(38070700005)(122000001)(38100700002)(5660300002)(52536014)(66946007)(76116006)(64756008)(2906002)(66476007)(41300700001)(4326008)(7696005)(6506007)(26005)(9686003)(186003)(66556008)(6916009)(316002)(8676002)(66446008)(478600001)(55016003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zZj0TIA4ZRiKQRjZz4lkGYQAkSX6fq5zWWgDWrxFHhH1wHsct7eywlhZdvr3?=
 =?us-ascii?Q?QzwekgWc544EFbgjabY9LRYqaHpZiRYFhTefdczV7hqToXOJ3Cjsrq5cvC04?=
 =?us-ascii?Q?thFNPHiDXEcX+9vpMG0xp7VWGXEQapMsmMyBcvcOSyzOvUAssjoaSwgEtevN?=
 =?us-ascii?Q?nHfbDKOjX6hTmUeC3w5rOM3WcSI5pCz0O8i8EYMkFaaXF6FK2lk192Z/stwk?=
 =?us-ascii?Q?KWomOqzU/4LTt12RFjZJnxus+ifaQYJbmK8j1/O5S41IeCHsOz26zk/2rlom?=
 =?us-ascii?Q?Kbv+rvL8Pezsy7dXLrUR+LcMJ+Z2Vbqw/nU2W4pcomEAMs9dheINMTK9LfP2?=
 =?us-ascii?Q?kc0IiTvvuF1+BhEbSsHKOiGyBeAb64y6vCeHPNa54AAxYFPsyPIbf8NeUuTW?=
 =?us-ascii?Q?I5S+/Z/NUP4YS5KAcydy4lzpM1DUoNntg4akOOeCav8QHJNlwxODA9ryG3ut?=
 =?us-ascii?Q?0A3lo/l10AJkXUIyVCIKAxyIXK4yYROJ9HTuaClOEA6KNTHVCmnTwcePU9US?=
 =?us-ascii?Q?wvkeIxpGIVH4WNU3NpEdpCMpACligfU41jcCc+YN76kcamUEfoll51VQseXf?=
 =?us-ascii?Q?7e4+uUo43UM9oFrDw8tZAYf5/04m3VQuot+R72OGc+vGA3xEK/eiB/7n71AP?=
 =?us-ascii?Q?s+1B2005+/IoImLN+OkZ6i5voE6qKckZ2R7dsyiQH6GIx434O/nE/uTVkMZl?=
 =?us-ascii?Q?bn86Rt3zBlWW/j0Mx9fROMRKfgwbmGF1jsOCsN6rhP4nBWskfQAFcCT4TgV5?=
 =?us-ascii?Q?EGapql7hG+E+tv2b0gnRCiGOGzjEOHWNEymUugKKx/oSnLrg1ciKT1nwFGto?=
 =?us-ascii?Q?z7D7/uzbLbbcE3dHTaddiQAFTEuZtJpBge+uQB1/v/pjk6oejLf7YFNFUC71?=
 =?us-ascii?Q?TwduiLK8o89+sumIMnoFJXmE5ZowoHMk1FYlaSF0JSp1yN9Dktr+bjjAAeGx?=
 =?us-ascii?Q?9TE21Gjj8Is5TT1/RALqwqT2n1hMX/b2jJFfqESzuMYzwvYmmM3cqOZs52wi?=
 =?us-ascii?Q?Jn3T5GG0SNtCHd/6ZlJxfllJXdd0fmfoYb5STffi27wcKF/K29IsW215yJoL?=
 =?us-ascii?Q?lE/PrJpOUTpKl1h7d/uecFXCH5UFQkdrTbZ3hY0ZOjlMihyo2isJSMAT3GCj?=
 =?us-ascii?Q?Jw/zHV6foDEcqql0NXuBbRTfqaTgnvjR2xj/wHndKQLHUWE4rSDLgpkn5Lu4?=
 =?us-ascii?Q?GJm8BtClHAx0cTSKBQY5Z0stX3x4vmk5I2jILCWmpTBG8Ya4wIY7kF/evg2f?=
 =?us-ascii?Q?9HvuD0evD+JYrrlOnowCxdnAF8nQPPDwGsWnTdZyKf0WBDXFxYoZJpW+IWQU?=
 =?us-ascii?Q?lBq1q5FCQccN/ByH5tS+CSWd90PqI3eMfzjrwLsRqEgzhHJz0JX1txh4T81L?=
 =?us-ascii?Q?mLxUh6BsptqCCHHFvyrlkWSGuGNnHwoFLtgMJSh+Dsty65viGrBc1j9z6+zz?=
 =?us-ascii?Q?vrec2yUKRYmN7u/eYYYfG6X03IRrk0uxira9QqwHZ4BJa3pslrR5Teky8Hjw?=
 =?us-ascii?Q?km6hLMJoLM85o8nPcjCeDW2/ETZpFRBai8UFgIWvg85Xk4PJoLXYNnEV89uv?=
 =?us-ascii?Q?DOldtOs9VTXEsmnAxyCjjVlpA+MF/n83676EzvN9GE9NR9DEal4BRU5o+aNA?=
 =?us-ascii?Q?dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYXPR01MB1854.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4c75aa-06be-485e-433b-08dab72edeb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 08:48:35.8349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iImWAJUlGhkXOzW1aFGzWjMhr61f1fB0mMkQcUJIx50klz1druzK3KmlqHO5V2Or6Ouw5kOy4/FiUb5ONInbmufxLyGk8xSPNI3vCt40VCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9791
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi kernel maintainers,

Please help to submit the following patch into kernel
---
Signed-off-by: Ondrej Valousek <ondrej.valousek.xm@renesas.com>
Short description:

The XATTR_NAME_NFSV4_ACL definition is also useful for userspace (i.e. nfs4=
_acl_tools/libacl/coreutils) so makes a sense to move the definition to the=
 linux/xattr.h


diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e2efcd26336c..07c3d8572912 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7680,8 +7680,6 @@ nfs4_release_lockowner(struct nfs_server *server, str=
uct nfs4_lock_state *lsp)
        rpc_call_async(server->client, &msg, 0, &nfs4_release_lockowner_ops=
, data);
 }
=20
-#define XATTR_NAME_NFSV4_ACL "system.nfs4_acl"
-
 static int nfs4_xattr_set_nfs4_acl(const struct xattr_handler *handler,
                                   struct user_namespace *mnt_userns,
                                   struct dentry *unused, struct inode *ino=
de,
diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
index 9463db2dfa9d..77eb8c885861 100644
--- a/include/uapi/linux/xattr.h
+++ b/include/uapi/linux/xattr.h
@@ -81,5 +81,7 @@
 #define XATTR_POSIX_ACL_DEFAULT  "posix_acl_default"
 #define XATTR_NAME_POSIX_ACL_DEFAULT XATTR_SYSTEM_PREFIX XATTR_POSIX_ACL_D=
EFAULT
=20
+#define XATTR_NFSV4_ACL "nfs4_acl"
+#define XATTR_NAME_NFSV4_ACL XATTR_SYSTEM_PREFIX XATTR_NFSV4_ACL
=20
 #endif /* _UAPI_LINUX_XATTR_H */
