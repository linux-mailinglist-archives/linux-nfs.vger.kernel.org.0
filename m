Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33D026AB90
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Sep 2020 20:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgIOSLT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Sep 2020 14:11:19 -0400
Received: from mail-eopbgr1300095.outbound.protection.outlook.com ([40.107.130.95]:1233
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727723AbgIOSJR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 15 Sep 2020 14:09:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsXBc2s7uYfkEzUa5OHDLdnaHJ0pNk24zA85D8J8Y91vNXyLPpsZqbKATO6FoZYvRlTxFUk3siBRcEAzj9+GrAoO6F7IyvXPZAKX8HUlFaa8B9JMZk5xqHDDlu2Lg6Tbuv/HdhPIfh6uem+YPTGKecKtHx1pQoxOk35v64QFIsWygc4UU1WA6AeSxP6cuARWU1AqFF8bp8YBmh9K1xaFpmrwaUqF2JKIrGb7C9Cqn4THNZJdSP8xvnSLOfAhvd/zWxRUugk59QOFawRaAdmkKUEYp2S4z3Zcyb0/TtS2KEAOWQHsB450lYRT1v8wowO8aBm/Q19MwMyxeL57sz5cEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXown2goUmZ1oY6gz3TvdwAmKixqXI1if3BkEXXppxM=;
 b=Yh/wiVnB/wexqFNF3fkQdoqanbHbAT6z4xCPpnSd/1Tx42lKkwd8HjUwBqMLvHxiap/vCZ7E/0zEEieSzYmrvn7WZ7WlTUiMx+hOa9hwIK3wsaXy61N6nJs/Yd1WqZvuo1KoNXMEc9hBS2TX2dhgrSgJzxaqICAP1jDh/DSzC4Vo0WP5yy4/+nQuVaqK5ARU1qewHxBZjd54lr3QneTzCs4juTok9WFSsalJft7u/Swi3B9mK8u9z0fxebeB6Y0miQvkwJn85cpmTxh2Mi+yBNcl5VyZ2wfKYu16HopuxDUCVQ0b/QYsemPb8r09V9JuxQK5mTaPZpzA/Xyy6Gy85Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXown2goUmZ1oY6gz3TvdwAmKixqXI1if3BkEXXppxM=;
 b=ArO1fiQnmzXyJXEp3DTQMX1wk0zIvLRb3e42K0rkUXCtOaOOTf8q6PBzXgMIhEwjxLj/VtwezdBNTCJLQeo1vYHJSqNW0rudJJDM0HEKAmjlXwbioVJrBSEEgnnX3lMXEZ4hgwYQtj1Z62YOvhsIw9z5B3p7Taht3tYoEuapyT4=
Received: from SG2P153MB0231.APCP153.PROD.OUTLOOK.COM (2603:1096:4:8c::20) by
 SG2P153MB0380.APCP153.PROD.OUTLOOK.COM (2603:1096:0:6::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.1; Tue, 15 Sep 2020 15:33:06 +0000
Received: from SG2P153MB0231.APCP153.PROD.OUTLOOK.COM
 ([fe80::8d7a:7c12:788:af5]) by SG2P153MB0231.APCP153.PROD.OUTLOOK.COM
 ([fe80::8d7a:7c12:788:af5%6]) with mapi id 15.20.3412.003; Tue, 15 Sep 2020
 15:33:06 +0000
From:   Nagendra Tomar <Nagendra.Tomar@microsoft.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: [PATCH] nfs: reset cookieverf even when no cached pages
Thread-Topic: [PATCH] nfs: reset cookieverf even when no cached pages
Thread-Index: AdaLdYAHSfC4FmukRxSfbPzbpNbQ4Q==
Date:   Tue, 15 Sep 2020 15:33:04 +0000
Message-ID: <SG2P153MB02316AF481EB246AED91DCB69E200@SG2P153MB0231.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=abd93397-bde9-47d9-851c-d3337636c9a0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-09-15T15:28:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [122.179.61.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc02c067-ac79-47ff-b2c0-08d8598ca467
x-ms-traffictypediagnostic: SG2P153MB0380:
x-microsoft-antispam-prvs: <SG2P153MB0380576AED7B535BB2A0FF7D9E200@SG2P153MB0380.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xD/jo74PFzNFwVJ75CgyYSt711iSFeq9P12pWGzmVXJmUvAISRQU+xT2BkiIt7Et8htu/T4utt3tnnq5hmko2c4BsRvgPwvQ77fa3D/D14nrRM8hUuf03NOd1mCW5RvBP5wy5NjyNWqGINXjMC/Y8sWJRrE5OO0llpduJEsE6c0kYTWwjkeikjH6No24WVb+R2hVVpopYDpuVHtI9AJuagZ5My5hF4j3q24kMXFi4sULoHTcqe7aW5oODuv5ZSYeeq5mu/XD54BnWMuPUkmBTTCOuYKjK3N/JrWT7nVSApN2WAHwxNY5exwXXmmKM55kR/qOdCLhg37IHXVmEHIPTqFCrR+cZpm9IJQilwAw/oTpgmrqMb51NRrznqjfLEj/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0231.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(6506007)(186003)(2906002)(8936002)(55016002)(9686003)(316002)(7696005)(26005)(33656002)(6916009)(10290500003)(478600001)(8990500004)(54906003)(8676002)(4326008)(82960400001)(82950400001)(83380400001)(71200400001)(76116006)(52536014)(66556008)(5660300002)(66476007)(66946007)(66446008)(64756008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: U8eIlTPVhCy9xg93Rz/HiW7YDIfQKGvtDDjzT1hndFWBPF1vuJ0YbeEz1juSFTi9uBufdfBraOnAlOZSf9yccb9N232bTKdVQvvABzfRJVT/w52E5oa7/IDecoh1pityj3zJ+9haDcJLtsh7Bk0ILXp3z2wk/DjXYLOsJpVCbQX328KXkENTU8QzNwH+TI5z3Lfjp8HbBt7Y2Z+Qjlu3z1CX4+SxECPn1xgbOJ9GSyqu/davyz3VhGbDolTEq0mo9c56Jle0LTDZ7dWgbHebD9cyH2S7Z1mJ5gwsW8e9VNNa7PSIrdZFyxxuD5miFz5j3c+ZNPOFJKKIBGNyC1wIKX1bi+KmnmG7a/b6akcE51kWc7cJojZVhBf8lu/R5M23nYtY8sCXY9Di7zWXpNnO3oCPYIFl0ktTRkJgoifQsgJ+JmWrLifkNdI38xvNh63gnx1/tB1j7FS8OWslTlOjftu5IAtgBHxU5eZXOcvlbX5ZRJ9m2afrH28DYrj76coNOPHx76sfGOHd45OAcyNzzA1S8QxcRJOFNOYc+Ei+cT+yNwzD/nL8uFHMzuHrlUTS3AA2btAjXX0QeISvYreDdH1WC6Q1P/qUPLZBV6sjwN0itOmzRnZbiSNDyyii272JUu2dhIyjUUCzX60OaBtdzQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0231.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cc02c067-ac79-47ff-b2c0-08d8598ca467
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 15:33:04.2818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6gVaOwks7JmGvBfW7dLaZHDTtlUXg1hGE8bR0MChCulpjFvEC3Vkoo22iO3GYP+GipU4KWUZ6WgAqE6Th7LYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0380
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Nagendra S Tomar <natomar@microsoft.com>

If NFS_INO_INVALID_DATA cache_validity flag is set, a subsequent call
to nfs_invalidate_mapping() does the following two things:

 1. Clears mapping.
 2. Resets cookieverf to 0, if inode refers to a directory.

If there are no mapped pages, we don't need #1, but we still need #2.

Signed-off-by: Nagendra S Tomar <natomar@microsoft.com>
---
 fs/nfs/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index aa6493905bbe..40f2bfaa4e46 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -209,8 +209,13 @@ static void nfs_set_cache_invalid(struct inode *inode,=
 unsigned long flags)
 				| NFS_INO_INVALID_XATTR);
 	}
=20
-	if (inode->i_mapping->nrpages =3D=3D 0)
+	if (inode->i_mapping->nrpages =3D=3D 0) {
+		if (S_ISDIR(inode->i_mode) &&
+		    (flags & (NFS_INO_INVALID_DATA | NFS_INO_DATA_INVAL_DEFER)))
+			memset(nfsi->cookieverf, 0, sizeof(nfsi->cookieverf));
 		flags &=3D ~(NFS_INO_INVALID_DATA|NFS_INO_DATA_INVAL_DEFER);
+	}
+
 	nfsi->cache_validity |=3D flags;
 	if (flags & NFS_INO_INVALID_DATA)
 		nfs_fscache_invalidate(inode);
