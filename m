Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8790A60F152
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 09:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbiJ0HoD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 03:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbiJ0HoB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 03:44:01 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2120.outbound.protection.outlook.com [40.107.113.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533223121C;
        Thu, 27 Oct 2022 00:44:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h76Fr8lEqJfb2AtJ/SwR847MiMw2XQHI/99btnrEFAcJHCJzEZ8qJLx/LfdDVcQ2m7Mw1GH9rjutulAol01yN/YnEtmA4T0nE0e03wmlcXbLuLQItwBfgDRzzbSUavv1YsZ8+PIDfLglFCVdQ7x8Hjj7DvOt7LJWWBiLdGroQ6/5z/b2CB42D+8sVzgDsEqs/Jrygp9wD7wjfa8JpqRUq2UpLCHhRYMehyPItOkU5HyYAcfBLhueTvJMmMG9rmMefA06QUH4wfcpoI9xei4taIwxTimA6CHLWa7apLVXLeZRKHoKo0EJSCu7atMqo5jean83wrzS40WG5xeDD0BhOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hHLGaICvW2LYZ/AO+OXnJXjOfVIUPTv7F/lH22tXFg=;
 b=CP1rCdxVR0BFlUvYMzx0tF7iwnvsK0P98UF6NERGjNwdBcuSfChBwbfJzfAc9Kn5IvkdvzQ0iX4EB947ZSIpwUxSgih8gUlf7yFuQkcNMGBAAviGtlkvzQIFTQcPeiCYT9blwnv7JkpBFfGN0fOB9WIXdZAeqwNKGaHB+Cu1VDlczfSJBt3TqBF1yDQYAzFm0jExcQTySQAHbaE8tlNV/jmnTTv3hunP0t79icEfrAitMy/Yo8QNnIRuYHS3eWX6/tIXUnqAlNs8NvsKv1UiB9Czxxg9lYSz2sj+PCduUBHORoeiprfRPGXLGRznRAqpMi6b8JIcG+ZQNosuVZYZGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hHLGaICvW2LYZ/AO+OXnJXjOfVIUPTv7F/lH22tXFg=;
 b=CPFJYcJvyvAhroL7g2+gz4ESyW+bGyCO7lGFT4ZwVkOrjfCzdDlgukcXTNPRj/aJIm3WVcnvNYH+F5oILn4OvFb64tvdOF0cQT4JslBmBM2H118n+WNNsq6H7Aupwt6hYydzQdQn5Vc2zkGr2Nw3m41FX1uecfVAas5poCcyoDw=
Received: from TYXPR01MB1854.jpnprd01.prod.outlook.com (2603:1096:403:d::19)
 by TYWPR01MB10307.jpnprd01.prod.outlook.com (2603:1096:400:1d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Thu, 27 Oct
 2022 07:43:58 +0000
Received: from TYXPR01MB1854.jpnprd01.prod.outlook.com
 ([fe80::7c26:5a68:d3dc:3ba4]) by TYXPR01MB1854.jpnprd01.prod.outlook.com
 ([fe80::7c26:5a68:d3dc:3ba4%3]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 07:43:58 +0000
From:   Ondrej Valousek <ondrej.valousek.xm@renesas.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>
CC:     Chuck Lever III <chuck.lever@oracle.com>
Subject: [PATCH 1/1] nfs: Move ACL xattr definitions to linux/xattr.h
Thread-Topic: [PATCH 1/1] nfs: Move ACL xattr definitions to linux/xattr.h
Thread-Index: Adjp191PvyyHwERbQa6sSzLdPAGESQ==
Date:   Thu, 27 Oct 2022 07:43:58 +0000
Message-ID: <TYXPR01MB1854FB85D24BDED2B490B8E6D9339@TYXPR01MB1854.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYXPR01MB1854:EE_|TYWPR01MB10307:EE_
x-ms-office365-filtering-correlation-id: 659e2900-4372-4544-e122-08dab7ef01da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o2x7j6gd1B+G4vbItm9/BJ6MJqEsKdUOtHdEqW0dgRRkPBOUsvcBMh9aYEGGMcevEZjAxdqx1Urw9tFRFi2zbBd3C8eYRAfp+az1fXiEgLfwNG+/M+9b0FX8zHGYJXKc2p0bKc4Eigu+8jFsmTLEXNWqMJSCvXYnZw0wgbHmwYnkX9nAWZKzmGyXfRwK/nDa8QkYc4ng5bid0CJEEnKqQBCbOQ2igKi9aBUU2C5FPdvujuvknxCwWXJjiDHWUJKLIP8rh4z9Bzke+SZsIe4mqxxskIkSWYymYnK/sNsZVo8TSZ2scnwNkc5gKY3++/P3NHb8ATdQfmirygg4yi5It26XeoZnCmTexJ9I/2u5TlGEgtChMnQ2mfR9BQtI8HDEFVJJtS+fSE28Q8/G4HKeHWN3/Oz6BFLRPhySpSYTQDfZRIeCRulWy5AUB269qAN1iRrPzSCfVkOrijRNmhuXqc1v+Wb5BwTHk0dS996Yac0gkl8pYdWdkOBfXnqVB9ArxMTBHnBf52T3yEJeK5bNrcQ6vMrnZBmsGhkFMJlWu20iRJCBJR7E2OKW0lVnza6S53FVwFEUFYwsfx6JRsDlFHpU251peST4KL6Ar0RMTwxWOemo2+zEahnFhjM7KVIxKMOw/DHIGGkMQwOy9i7szLEovASbXoXYifNLL3MAClb0VZ+YzHW+avzR9fkST2ZKzWn5zMB177AaZALFzuRVNbjFVmgxJLdWvujGfS4Z6IxDFQMI302wY5ppehQ9+LWgqZt/DRQfH+w74VosuW8R2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYXPR01MB1854.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199015)(52536014)(26005)(33656002)(478600001)(9686003)(316002)(6506007)(7696005)(8676002)(71200400001)(110136005)(86362001)(38070700005)(38100700002)(122000001)(55016003)(83380400001)(186003)(41300700001)(8936002)(2906002)(66446008)(4326008)(76116006)(5660300002)(64756008)(66556008)(66476007)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GwHeuwe4TJHLMrcLYMcmc80uGpXm8OzQiIp8s5cmGDFRXhmAAviyzkiL/JAS?=
 =?us-ascii?Q?lDiEheIVliwYom6pgoRWFjG7F7ppWkKVqHoMj9AkNo04ULWb/RbfU+3LhQjd?=
 =?us-ascii?Q?MTQkhZwAmMUuD4Y2QEPJVtSTLZpo9qyYU00ZhznM1/gdzOtzRJJemQ/tqfaZ?=
 =?us-ascii?Q?dA2jjIkst6f1Fb7KzC+pclkKs2mFGxbtjErJBkGHJaBUE2Tip+DSfQmm4Riz?=
 =?us-ascii?Q?9RkDvd6rGR4PwJnOwxwZI55tcUJ+wVeF2gNu+Wl5rVG3z3x9BUUJMkFU2WXB?=
 =?us-ascii?Q?pJZsMFkzCNk/vO8Mp0NKhLIIznJBi2Jpr1iKwKl/dMN3P64IEuU9qY5WXV1J?=
 =?us-ascii?Q?pI2buii9qHYC6jLcHUJgu5xagRnfnqeLxKQL/ifN9b2XJJyqcPCg6KjoJzKo?=
 =?us-ascii?Q?twexA+tTKYe3QLBGObLj78tohnGF97B58Yr4uzcHXLU/MzQUzB7awO+JPaQI?=
 =?us-ascii?Q?yQ/NGzmcP2oJlV0xv6GS6Z0ERJhZLkFF+QjvrBybXYDMHiwGf/ExmgKp8464?=
 =?us-ascii?Q?BVi5TxEkrRfBreKOqHkKhzMTcaQztachWFHV5o0iS8vkLoAVAyDHtZmU61R8?=
 =?us-ascii?Q?hUpYiUvNDkNghxpaA9DYqao2KtBLDkSnB/uKJ+OZigXURTotTQc0OZkosRad?=
 =?us-ascii?Q?CKPgaeQTrEvpIz1nC7NEMpYJUmNLldCp0wwxLUY9x+ASO62m/DcwPFn/mNIm?=
 =?us-ascii?Q?DVjHGyilhIFZXbgiuoLxtcVirfVDBjegJloPxT+3vOM288S6LYHlhi2N97Pr?=
 =?us-ascii?Q?BaHTsUBslIqml80Y/FJnsAJ/TG1Fgx9AKowF77/LHzMhQqXKvgwHKBw+1sZw?=
 =?us-ascii?Q?BNI3GCexGGwg89+13Ok93ahCzBgnOr3tWmANAKd7fNPDoQyKoAagTgnpZZy4?=
 =?us-ascii?Q?Ki7rgPlzN0gKUW+LPulvnsgEcxPu/hIK43ACfxvSEk/cvzB3tUkIf1AalJdw?=
 =?us-ascii?Q?bSRZifWn+UM7m4sR48u3e58iFUmAbGyzJdyKzGCc+K+T1LLA2zIXVSgbUSOh?=
 =?us-ascii?Q?Tx8LC9MNfOBpHm9BrdIkRYvRwQuX7I95lkF4w2/lRfOT+uHEeUUzIgakLndP?=
 =?us-ascii?Q?qS09dX/RSxAJGWiYkhxywBvp23zH3jXPeatYCazk3wgj1ei5tbhidqDZTwxv?=
 =?us-ascii?Q?2wugMKrmQaMIWrmxhlfhnGIcYXeuwBK4ZWOlic/JrT8Pk2QH3eC1TyYNreRj?=
 =?us-ascii?Q?A0b7P7dAXXbJiljOOIrA2oE4VlE+iuolkSTMatnKE+ug2isxISpTL031RAev?=
 =?us-ascii?Q?pK60b79/EEaxOR6MXyBlUALhW/qRA5O4HQK9FuTGS5aKkDiPf/OkMuR7r+Ap?=
 =?us-ascii?Q?qywFTMtMzeGw5KMuLb0dukOCh8Z+tb0wMHCh4g8HOh9R8HlptRQ2AmZu3P2i?=
 =?us-ascii?Q?n6TbnW0M6cSWAp6fQbCEeQqT+UT+pwfKdeBxgQ9zep18mq1U3ZDBCkv71XuF?=
 =?us-ascii?Q?9fsyShdmLBF42KjiGy/0CDyzcnGCDgLhLVAzG1gOkVPdrKZzKWfo8TTKIQql?=
 =?us-ascii?Q?85XT56d9SoeoPflXSHZQeqf+PXlC4Q2vpeVT+mu4FKiU+RUoOIrvSWSmL7pB?=
 =?us-ascii?Q?opRSoL/9dNwZi6cn9FDlqGO354H9V9t/ED3ifKI5a7tZrIfGqOyEGbv5oiai?=
 =?us-ascii?Q?Xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYXPR01MB1854.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 659e2900-4372-4544-e122-08dab7ef01da
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 07:43:58.1910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1VFjtys2S9WYS4QOngRQ9S5byEXOHiKBypxKxifM84sLZ3wE3H8D9Uku8TOWFI1csnMkG7j2BFWZVwrZv8gcUTAWFVgPj1kz0BV2wS3AW1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10307
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi kernel maintainers,

Please help to submit the following patch into kernel
---
Signed-off-by: Ondrej Valousek <ondrej.valousek.xm@renesas.com>=20
Short description:

The XATTR_NAME_NFSV4_ACL definition is also useful for userspace (i.e. nfs4=
_acl_tools/libacl/coreutils)=20
so makes a sense to move the definition to the linux/xattr.h

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
