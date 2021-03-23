Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE09345784
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 06:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhCWFu2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 01:50:28 -0400
Received: from mail-eopbgr1300123.outbound.protection.outlook.com ([40.107.130.123]:41984
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229464AbhCWFuN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Mar 2021 01:50:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juc1LK5/yvEBecgl3L4TOwOlk6uprndPC/uJBtOCEQy53HUuOP/h8h3OhmoNN8EfNGmNpyY/w4HKSV5458YbNoznhciRGyfyp1QDnC/hpFgRpK//7x8hqSlfhs9Y3/K+vpPdv0KuVYPFVWRwJt3hBlsBZHYQpCIp1AJoqRZyapVcaKEYVRBuEA4HwHxwnGyo7yTy50RynX2gwcGhW0A9n+atSjA1zaD32CPmxiARg9QIAysRiXla9VAHX3q93MXT8btaNwjo2JZkIM+xiNNGOrvCGHX5mJq0zXuF7xUZ0P06T643LEI+P1OegnG85imXAmxOfUdJlScTzAMtGGqS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8LhEWBRosaBd6Enmw4UPcQDwVJ/DxtNO56iLhzpUAM=;
 b=BX4G4D6K9QdFnzMMmcp/cs80/y2gbrXOdtzQuqICUFzhIwGMap21f8srjQ2Dq9Xaj/lt1WnqDqxkXt2f0NaD6IKBEHFeRHvKWVm4L4JTfWssT4YBK6ohQutw+1oUZL6k2fk53OwgHesPsFghUWDR50L04AA+QjfwIVDUefh/tIZ0I8lV9I/lkSPIBEwZ4ErAJzL+IDKh8dOIH/Znik8b4lVrQqjIPqfx8mErvCpP4oa01ChxCcDsxhY+EOmfGCj8NcRcxHeQo2VycTmZInuzj+62suZ0muG7jByxtaaRuxFJKLdb+by6J4fsGgm5fVUqZaABWBabyWGsanO6KXbXcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8LhEWBRosaBd6Enmw4UPcQDwVJ/DxtNO56iLhzpUAM=;
 b=EZXLTsaJYyQ4+FO9BPuYGJ+IddiUbJL3mIOqRiiAZM5oG9/HT1cQd3qfAvReo8nIlTOqbz0z1ZZNSgIEu6imVbfsDXqPMvy++Tf2At4fWGQ3WCQM1JGpSyjoNV55kGlgpgcV+wUUeOlJEQO1UF2s9dhWovUYCsCYE3UcPaExNGc=
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM (2603:1096:0:4::11) by
 SG2P153MB0214.APCP153.PROD.OUTLOOK.COM (2603:1096:4:8c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.2; Tue, 23 Mar 2021 05:50:09 +0000
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488]) by SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488%5]) with mapi id 15.20.3999.008; Tue, 23 Mar 2021
 05:50:09 +0000
From:   Nagendra Tomar <Nagendra.Tomar@microsoft.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: [PATCH 4/5] nfs: Add mount option for forcing RPC requests to one
 file over one connection
Thread-Topic: [PATCH 4/5] nfs: Add mount option for forcing RPC requests to
 one file over one connection
Thread-Index: AdcfqE88Ub7NiS+HTXGHJpvme+wyQQ==
Date:   Tue, 23 Mar 2021 05:50:09 +0000
Message-ID: <SG2P153MB036175692E2D6C18D06C3A1B9E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [122.172.188.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5c9e8708-32de-4ce1-9d19-08d8edbf84cd
x-ms-traffictypediagnostic: SG2P153MB0214:
x-microsoft-antispam-prvs: <SG2P153MB021423B11C506EBAFD2883BB9E649@SG2P153MB0214.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:170;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8R0f4K3rn4cQBV+jKqlH0ciyldi+cA+Ur0g3SVh3GerZvSGCPBhoAnlTuRD1xe8X0vMhNePVCsK+fIynrjyPSTpMADDdJuOaCp0p2WTcUZVsDomxljY/NeQUPs/Dk7+IUn6ZvKX9SWu9bwjgJuwChXbrSy3EIhrEJxpd+DXtg5+5rUREIkS22Py+b/ga7Jlm/mbWXe6te215IXzDKS/G4XqVa8ZUP+sY++rhrYZx984rCwVt9AeEZxQpVExp+V/cJrJPXe2ropjQBlSBmnXKuPoZb1ZxOhbNYCLwc2/R2FeIxcZtw9tmltfQnZAafSJ52Bj/IhwM3p7mV2PTZ1WnXGXBVFxzR98qPeYv5uN1vZhYQkrzY1PuuuCxYp9AlKdLOOhEboRkyHxX5JfxgTpZXAFG2UwQDENmB7XMWmXc6Pk7eBYpq73OKh4NTxgfza9vYwwCZ636MOiteKwSVAp8G9GjWmVmoMK8IBvgt4usvcJ5PoB1J+hTqhG6v2UDukvrmNz7RxDpfdOkQDqMvqOs7yabZsH1jsFY8w2S9TFy6vn+CuJuO431NVqgAwvkIg3VRwhWtIm7hIgtxguClzjMQ+G5CooN6Hkpc8bZAByWNk+rmcaJqRu+76XsjzjmVrMxl/DumBAQcF1bfGiNAXQaeTJqdBJEEzxi7XGPFx2cvkY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0361.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(316002)(71200400001)(33656002)(76116006)(478600001)(6506007)(8676002)(8936002)(6916009)(7696005)(55016002)(83380400001)(66946007)(52536014)(66446008)(8990500004)(9686003)(66476007)(26005)(54906003)(66556008)(64756008)(10290500003)(2906002)(38100700001)(4326008)(86362001)(5660300002)(82960400001)(55236004)(82950400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bIkR4Jz5gZEwHk6rsoWxgGNH/jLsvtsEXljGdS88GlIiy5J6Xr8W0v7kVVKd?=
 =?us-ascii?Q?T44YVXvQgMZcsSs4VU4M5q5L3vpZlDnkUGjPOjbsSUnmtwdipIE9IFFCDRoV?=
 =?us-ascii?Q?LC1d9YsiyFozCGGLu+32hfXrq3Q4mqN8Pj3UqmWc+nZP4ybSSZ188VZK7IB4?=
 =?us-ascii?Q?YabPKEoinIamh+5hkTnHh92t18uLmOe4u3SIt32jycwrYcOrRE1q2OWeGMCV?=
 =?us-ascii?Q?ck+jqqWWHNG9T8OwR5WTiQM0u/VlPqK1aaRAqbu4pSgrKr4DoZbDc/rrTQxD?=
 =?us-ascii?Q?X8EQOrNkA35FJC/FFK/amXSKeHWRh6kS2YTFDi3QguJ3ESNhaKG8bZhfvt9m?=
 =?us-ascii?Q?Cf/FF615DLIdZbt42z8R2tgTCnI4ZxQV5xlyPw+h69L3s5Gyyc0VOuPjAgmQ?=
 =?us-ascii?Q?sTNK3Vpe+I9tP/xUB36Iy59nWBTFhFdJaoykfXgvBinjtFAPKBQkU1IIH71T?=
 =?us-ascii?Q?vFSxu3q6Mik0JJMXeENs0JozPq08T0ai9MuQUpag149SXo+fl5SWRFAg6Gc+?=
 =?us-ascii?Q?xIanMu8/mHYm+KXdM4sRC1LXnaWSHEac8ETTfXz3Lqd4c0rGVvAdqSuaEAf2?=
 =?us-ascii?Q?HS9DwqZEKC7jP3PaH55V25lfHo45M8uwHywZqECoU1mhm1pGp9PDwuz15sfb?=
 =?us-ascii?Q?RNbfK67ZS6EpSkvaV5F7PzmVUYHw5x4DHex5Vd4g5p4umJh1qAdH5UjddrJh?=
 =?us-ascii?Q?MMzKPIk2xcyfpTgYW3e4Y2oWzQFM3Af77e+brr5jMw0T4XmaLOZJR3C0/TOg?=
 =?us-ascii?Q?VbRuIubN6ED/CFqY3O+Zs1mwtLOuhoqwW3h3O4SzRZ/IUTwabUmxr9ee8BWm?=
 =?us-ascii?Q?UqStSIfVlQMznt5DiMc5p6t2fgZ23O9fc0+J1zCjW3EGFxZbNamrBpjJleFV?=
 =?us-ascii?Q?d4iWeFXKwMcMutrqxnac2WtkDSlfcOZsiB+U5ySMVrv0zoyZoUm9PVyU3miU?=
 =?us-ascii?Q?xzMqjtQagqtCemQ9s5tbXe026vNsi9ehWGh2wolPCXthmsi9ElHti97yzbon?=
 =?us-ascii?Q?NDfx6tEtUeec822p27SRIKi4qJV22SESjRItOo2yjYBVFql4P6MW1FlK2hYi?=
 =?us-ascii?Q?KpTviiq4Aau316MdcxxDvuOpuNK8XiLyeyyDrYkgYWm7UzS8j3nTUImBSwjk?=
 =?us-ascii?Q?WJeTYGHZc+Op/Buic03UtlcjwD8EwvpX7hVqOgNbWNrf3R5rWVRovkkVtMBC?=
 =?us-ascii?Q?0/YXdcalGTDvlcjMd/6tZ2CLbReMO24eSwXJI3T+eSyfjupItIzfZYDt/1CM?=
 =?us-ascii?Q?EBoEcKvJ7oSxfiDYzcNewrVrVpp1wDWv3Bem7pwkOPaF5O6uEBgQL6jxFFR/?=
 =?us-ascii?Q?T9k9n4x838G9HJ1QIO8bZi2e?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9e8708-32de-4ce1-9d19-08d8edbf84cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 05:50:09.2562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vh2GNmSU71oXIV9A8qjqFENhmB/TYoPJ6W47WcC9qSKnbGvioSe9xtgAtsanTQ4BSQZz8y8W74hVakbhvDiQMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0214
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Nagendra S Tomar <natomar@microsoft.com>

Functions for computing target filehandles' hash for NFSv3.

Signed-off-by: Nagendra S Tomar <natomar@microsoft.com>
---
 fs/nfs/nfs3xdr.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 154 insertions(+)

diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index ed1c83738c30..3d90686cd77d 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -817,6 +817,13 @@ static void nfs3_xdr_enc_getattr3args(struct rpc_rqst =
*req,
 	encode_nfs_fh3(xdr, fh);
 }
=20
+static u32 nfs3_fh_hash_getattr(const void *data)
+{
+	const struct nfs_fh *fh =3D data;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * 3.3.2  SETATTR3args
  *
@@ -858,6 +865,14 @@ static void nfs3_xdr_enc_setattr3args(struct rpc_rqst =
*req,
 	encode_sattrguard3(xdr, args);
 }
=20
+static u32 nfs3_fh_hash_setattr(const void *data)
+{
+	const struct nfs3_sattrargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * 3.3.3  LOOKUP3args
  *
@@ -874,6 +889,14 @@ static void nfs3_xdr_enc_lookup3args(struct rpc_rqst *=
req,
 	encode_diropargs3(xdr, args->fh, args->name, args->len);
 }
=20
+static u32 nfs3_fh_hash_lookup(const void *data)
+{
+	const struct nfs3_diropargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * 3.3.4  ACCESS3args
  *
@@ -898,6 +921,14 @@ static void nfs3_xdr_enc_access3args(struct rpc_rqst *=
req,
 	encode_access3args(xdr, args);
 }
=20
+static u32 nfs3_fh_hash_access(const void *data)
+{
+	const struct nfs3_accessargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * 3.3.5  READLINK3args
  *
@@ -916,6 +947,14 @@ static void nfs3_xdr_enc_readlink3args(struct rpc_rqst=
 *req,
 				NFS3_readlinkres_sz - NFS3_pagepad_sz);
 }
=20
+static u32 nfs3_fh_hash_readlink(const void *data)
+{
+	const struct nfs3_readlinkargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * 3.3.6  READ3args
  *
@@ -951,6 +990,14 @@ static void nfs3_xdr_enc_read3args(struct rpc_rqst *re=
q,
 	req->rq_rcv_buf.flags |=3D XDRBUF_READ;
 }
=20
+static u32 nfs3_fh_hash_read(const void *data)
+{
+	const struct nfs_pgio_args *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * 3.3.7  WRITE3args
  *
@@ -993,6 +1040,14 @@ static void nfs3_xdr_enc_write3args(struct rpc_rqst *=
req,
 	xdr->buf->flags |=3D XDRBUF_WRITE;
 }
=20
+static u32 nfs3_fh_hash_write(const void *data)
+{
+	const struct nfs_pgio_args *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * 3.3.8  CREATE3args
  *
@@ -1043,6 +1098,14 @@ static void nfs3_xdr_enc_create3args(struct rpc_rqst=
 *req,
 	encode_createhow3(xdr, args, rpc_rqst_userns(req));
 }
=20
+static u32 nfs3_fh_hash_create(const void *data)
+{
+	const struct nfs3_createargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * 3.3.9  MKDIR3args
  *
@@ -1061,6 +1124,14 @@ static void nfs3_xdr_enc_mkdir3args(struct rpc_rqst =
*req,
 	encode_sattr3(xdr, args->sattr, rpc_rqst_userns(req));
 }
=20
+static u32 nfs3_fh_hash_mkdir(const void *data)
+{
+	const struct nfs3_mkdirargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * 3.3.10  SYMLINK3args
  *
@@ -1095,6 +1166,14 @@ static void nfs3_xdr_enc_symlink3args(struct rpc_rqs=
t *req,
 	xdr->buf->flags |=3D XDRBUF_WRITE;
 }
=20
+static u32 nfs3_fh_hash_symlink(const void *data)
+{
+	const struct nfs3_symlinkargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fromfh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * 3.3.11  MKNOD3args
  *
@@ -1159,6 +1238,14 @@ static void nfs3_xdr_enc_mknod3args(struct rpc_rqst =
*req,
 	encode_mknoddata3(xdr, args, rpc_rqst_userns(req));
 }
=20
+static u32 nfs3_fh_hash_mknod(const void *data)
+{
+	const struct nfs3_mknodargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * 3.3.12  REMOVE3args
  *
@@ -1175,6 +1262,14 @@ static void nfs3_xdr_enc_remove3args(struct rpc_rqst=
 *req,
 	encode_diropargs3(xdr, args->fh, args->name.name, args->name.len);
 }
=20
+static u32 nfs3_fh_hash_remove(const void *data)
+{
+	const struct nfs_removeargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * 3.3.14  RENAME3args
  *
@@ -1195,6 +1290,14 @@ static void nfs3_xdr_enc_rename3args(struct rpc_rqst=
 *req,
 	encode_diropargs3(xdr, args->new_dir, new->name, new->len);
 }
=20
+static u32 nfs3_fh_hash_rename(const void *data)
+{
+	const struct nfs_renameargs *args =3D data;
+	const struct nfs_fh *fh =3D args->old_dir;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * 3.3.15  LINK3args
  *
@@ -1213,6 +1316,14 @@ static void nfs3_xdr_enc_link3args(struct rpc_rqst *=
req,
 	encode_diropargs3(xdr, args->tofh, args->toname, args->tolen);
 }
=20
+static u32 nfs3_fh_hash_link(const void *data)
+{
+	const struct nfs3_linkargs *args =3D data;
+	const struct nfs_fh *fh =3D args->tofh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * 3.3.16  READDIR3args
  *
@@ -1247,6 +1358,14 @@ static void nfs3_xdr_enc_readdir3args(struct rpc_rqs=
t *req,
 				NFS3_readdirres_sz - NFS3_pagepad_sz);
 }
=20
+static u32 nfs3_fh_hash_readdir(const void *data)
+{
+	const struct nfs3_readdirargs *args =3D data;
+	struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * 3.3.17  READDIRPLUS3args
  *
@@ -1289,6 +1408,14 @@ static void nfs3_xdr_enc_readdirplus3args(struct rpc=
_rqst *req,
 				NFS3_readdirres_sz - NFS3_pagepad_sz);
 }
=20
+static u32 nfs3_fh_hash_readdirplus(const void *data)
+{
+	const struct nfs3_readdirargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * 3.3.21  COMMIT3args
  *
@@ -1319,6 +1446,14 @@ static void nfs3_xdr_enc_commit3args(struct rpc_rqst=
 *req,
 	encode_commit3args(xdr, args);
 }
=20
+static u32 nfs3_fh_hash_commit(const void *data)
+{
+	const struct nfs_commitargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 #ifdef CONFIG_NFS_V3_ACL
=20
 static void nfs3_xdr_enc_getacl3args(struct rpc_rqst *req,
@@ -1337,6 +1472,14 @@ static void nfs3_xdr_enc_getacl3args(struct rpc_rqst=
 *req,
 	}
 }
=20
+static u32 nfs3_fh_hash_getacl(const void *data)
+{
+	const struct nfs3_getaclargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 static void nfs3_xdr_enc_setacl3args(struct rpc_rqst *req,
 				     struct xdr_stream *xdr,
 				     const void *data)
@@ -1366,6 +1509,14 @@ static void nfs3_xdr_enc_setacl3args(struct rpc_rqst=
 *req,
 	BUG_ON(error < 0);
 }
=20
+static u32 nfs3_fh_hash_setacl(const void *data)
+{
+	const struct nfs3_setaclargs *args =3D data;
+	const struct nfs_fh *fh =3D NFS_FH(args->inode);
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 #endif  /* CONFIG_NFS_V3_ACL */
=20
 /*
@@ -2517,6 +2668,7 @@ static int nfs3_stat_to_errno(enum nfs_stat status)
 	.p_proc      =3D NFS3PROC_##proc,					\
 	.p_encode    =3D nfs3_xdr_enc_##argtype##3args,			\
 	.p_decode    =3D nfs3_xdr_dec_##restype##3res,			\
+	.p_fhhash    =3D nfs3_fh_hash_##argtype,				\
 	.p_arglen    =3D NFS3_##argtype##args_sz,				\
 	.p_replen    =3D NFS3_##restype##res_sz,				\
 	.p_timer     =3D timer,						\
@@ -2562,6 +2714,7 @@ static const struct rpc_procinfo nfs3_acl_procedures[=
] =3D {
 		.p_proc =3D ACLPROC3_GETACL,
 		.p_encode =3D nfs3_xdr_enc_getacl3args,
 		.p_decode =3D nfs3_xdr_dec_getacl3res,
+		.p_fhhash =3D nfs3_fh_hash_getacl,
 		.p_arglen =3D ACL3_getaclargs_sz,
 		.p_replen =3D ACL3_getaclres_sz,
 		.p_timer =3D 1,
@@ -2571,6 +2724,7 @@ static const struct rpc_procinfo nfs3_acl_procedures[=
] =3D {
 		.p_proc =3D ACLPROC3_SETACL,
 		.p_encode =3D nfs3_xdr_enc_setacl3args,
 		.p_decode =3D nfs3_xdr_dec_setacl3res,
+		.p_fhhash =3D nfs3_fh_hash_setacl,
 		.p_arglen =3D ACL3_setaclargs_sz,
 		.p_replen =3D ACL3_setaclres_sz,
 		.p_timer =3D 0,
