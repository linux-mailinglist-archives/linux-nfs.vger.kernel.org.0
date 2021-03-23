Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7761E345785
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 06:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbhCWFvL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 01:51:11 -0400
Received: from mail-eopbgr1300099.outbound.protection.outlook.com ([40.107.130.99]:36960
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229437AbhCWFu4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Mar 2021 01:50:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6mUmuZdvM3rRX7hpR4lw2ZC6cEzSBkojM1e8WiRUfE6gCcGCOaw1ZQEvnTGXyjG1P1CxbalNVBZTpTfH8tOEblQbr7Vj6JaVWWjm6CdopblUkPNivlpZ/xWk+lVLHJ5xKGzYnOI6CjtGXLgAShn9jpJ/Qxeid5Dt1y3W/moAvCEphxfIQ/4vPR19kwWkF8GkeWBUkEpChHa3ZUiyV+aKxf7aRqPWvD8I2LhbZvP8qDsj96cxAkkhgV5l56AovlLty4R5+IzIfU8D8JlZ012rqUGnRtVF95OL7Om7JKOz02VUNq4ZOXoAIFHCL6HFFMHq/Q5I24/o621nMHsZhM2ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpnXlBdV6iGr7tGSetGZ8Fsm8pjYmK0e9IGAZTKz+OI=;
 b=kBqE+VaFbHrN6joEhJxSf8PYka9kRfl5GfkEQ7sY9qfT8tFKwafegddUgeE94Pf/732+Bdzz5hZhkjIeQehsAHN2RsEHXIRGyVh6R4iIoBT0T5OjqDNmDGcGDd+S99Vkj2psnhhRwF6E/FWvKvd4xq19cwn8Jzm8c2L9+rrR+OfN5b0vPEaHbsp+jA5j9M9Ubc5smoo6sPc0OlgkbdL8IXWJzAzMVCuA+62ZP9+7YcQob4YzW6Wkw9H6j3EWZ25kKNQLEcOR9QzrMRA8WQqhQLZRfqMY6tGWNgWq8T7T5AfjqG2pNV5bU8bAvdcxvx7nlC+C7Vlw+DMG4UVSfY/kRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpnXlBdV6iGr7tGSetGZ8Fsm8pjYmK0e9IGAZTKz+OI=;
 b=SjStkD6WEWrIO/s35AWc7XiQIgCOfdu1b/2sMO6ZRIxYj3IMMnha90V7WEaklqMEei4zw0UrCO4BmrU/ShvTyBZStV231P7JrojrY06IdIBr1ziNm48cgTsbvS/fOk2DO953GmGnWNeqjB6sptnlSwT0SFHNKf8iS4QAyK7QXKc=
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM (2603:1096:0:4::11) by
 SG2P153MB0214.APCP153.PROD.OUTLOOK.COM (2603:1096:4:8c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.2; Tue, 23 Mar 2021 05:50:53 +0000
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488]) by SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488%5]) with mapi id 15.20.3999.008; Tue, 23 Mar 2021
 05:50:53 +0000
From:   Nagendra Tomar <Nagendra.Tomar@microsoft.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: [PATCH 5/5] nfs: Add mount option for forcing RPC requests to one
 file over one connection
Thread-Topic: [PATCH 5/5] nfs: Add mount option for forcing RPC requests to
 one file over one connection
Thread-Index: AdcfqGipFyIum9yvQ0a745ORygpMdQ==
Date:   Tue, 23 Mar 2021 05:50:52 +0000
Message-ID: <SG2P153MB0361DFC634D26E46D33A3D059E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
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
x-ms-office365-filtering-correlation-id: 1d9e8c4e-d712-4c58-d55a-08d8edbf9ebd
x-ms-traffictypediagnostic: SG2P153MB0214:
x-microsoft-antispam-prvs: <SG2P153MB02142CA9433C2949AB6D4C919E649@SG2P153MB0214.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sTbsiDyq3ZwOf4ePfqKgyt6V3m0uKGw4RQManozmYGUK9ki09touX58f9sE21zeYOrgmQ0NkCIa0hU24D4+LKCfmWJnmW7MWmk0JSIL1C5WPcwnm2PaoqS0zoIWuzjd2iwTRcOQJhPdWFHk2+8RcMf/bmvihbFXcMC1KJ1FkZB2nRaVN2BvizbjaKhxSJ5SA56b7V6l2l51v+TBdQUVK7MQ132pCDIQ1UlEMcuAmkojNr7ND0J5Hx2gylOpI7y8lPM5NkuhurxRXAojmSkqOkDHDRulg4fh3hLvr4VazEuZLIJussc/g0YslGgXf3SQnUK+oNP2t+CkKqzNXd2E2uhvcbG+0kYtNmtaQr1yxNYMniwQCRjsPUAPIn/EIzpZExXhZ3Yr0Ht1zde8Nmj50HqNoyKWwT1z0e3HZ6a9cIFZwrc10nXUS6qwp2JyjSLqE72Gp5RGcvfACsayUzYO1/yheSF89LU6YcvaGqTDrXHL4hv5jlmS+LqnsvFTUMbnVMC4LFNZI5FX4OA7BaI/kHHg35oYdn6J/gFEfK0o9z1mYYHOj4eI4aMGBM3mvm54x0tc6XpYSKCeEfPVY/hZYM0VwX9PhZhIeRlYI73bJXyxBKcVy7QJoGDBv7ZwWpaBjs6ahvElFy36gUerq9RAX685sot3FOU5GLjgszVFM5PM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0361.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(316002)(71200400001)(33656002)(76116006)(478600001)(6506007)(8676002)(8936002)(6916009)(7696005)(55016002)(83380400001)(66946007)(30864003)(52536014)(66446008)(8990500004)(9686003)(66476007)(26005)(54906003)(66556008)(64756008)(10290500003)(2906002)(38100700001)(4326008)(86362001)(5660300002)(82960400001)(55236004)(82950400001)(186003)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?s3XMPiI/pajpr6MeeXp/nVOU/kDvtUGO7Sq1eYaP18Q2h3BABWWye6uoIwRL?=
 =?us-ascii?Q?Z5Kf7n/YczJa5tl91vECgL4eSQ3vflgf48DlMAwh/x9HGFbpW9OEBgmfjQf4?=
 =?us-ascii?Q?J2Sh5oRFMJRsG3NJwy1Xv87r7WOd9equ/74ZeyxwmwJl6dtMT8W2PxLAYxTi?=
 =?us-ascii?Q?46dNwrc7+Au0rn/izm86Kxai85v/0HAMtTTsmxpa9kk6xWQ2GNpTMp4W1AqD?=
 =?us-ascii?Q?4heOhLkj9zKdi1I+6AWvA/mLWndLt7bktySlo2nvJJtI4b/8d++T0Pl2yErb?=
 =?us-ascii?Q?maowILErX1ZTQD0AF7q6i2PKh5acjFroMphDLUfFRHtCYU1GZpwUKhWMTli0?=
 =?us-ascii?Q?vZ7PIf9N8LcPNSpLukgRcC9b+Ufb/x5rsaiNIHHH54mXkuIbaZ9EfuZ9VwlE?=
 =?us-ascii?Q?nQLVmnvBpB4SsdyUDCTwF94ELxZ0s6vgbFVUnqCLZDUFciEIBYb610Y6IKLS?=
 =?us-ascii?Q?uWBnk5oJoqRzwo9FoI4lbL703qKHoQTRxzcwI36fvBDozK1bwBvDz54wBEEc?=
 =?us-ascii?Q?MwXqexqmhEPhW6LH1ggFmC0EgVuTpfYzJD+b5s9v4CS7hoh+o6ZuG833L0tG?=
 =?us-ascii?Q?TcstTWMZGEcLFQoinrzez1b6QVGYtBnAmrMpxDLo5YIWpIWtAu8JQAMx49w0?=
 =?us-ascii?Q?+SflCf6KbKi2+lTuB92BEXE5EpET589WM3+pNhOSxyRf7HNntYun5/jQxoOG?=
 =?us-ascii?Q?tBsfB0Y0iW8+xsij1XWeh4Ec60Zq9HxyOwN0zVdXf3dtqTVnfxZOAUqbBll/?=
 =?us-ascii?Q?Te1WMW1GGjFsHYSdyF5yTD0V5L/AkXP3M34m1JZK2667E1Ss2CvBTF8c2soO?=
 =?us-ascii?Q?WRbeQqZCF65CesgyRpoCOdduAy+kttRJBzDVTnBsJN18I+oUjHLNfEF0rBzm?=
 =?us-ascii?Q?QXoKh3Fwy48uMAZt1/gZXGQIk8wt2cX5TQkG2TAD6mNjjjEFHLgKWfybQuKg?=
 =?us-ascii?Q?3wg0Tmi7aDZ9LV+ftTuUzdjOL/J3rkmRDSnWkna0rGMwdb5Z+aBS2dHs9uHD?=
 =?us-ascii?Q?WY8vg0vZNkaz1eDsUU5h5LeEXdoXYKkQTgtNoloCqs8BqYsyKVjnE2OH1mUC?=
 =?us-ascii?Q?lXtUW/QsMMeXDydjNfCyB2cY+0nc9ZdYT5tQ3GmgL30jnApolDB6S4U4w/8n?=
 =?us-ascii?Q?zlPgbelVqzjcEu8syHgx8z+rPEHRq8N2hPpCP7YjQJijklji6wlQOteKD4jU?=
 =?us-ascii?Q?JPrsctdAJelWtqzPYrPB0QtPHWot1VWqtjGDysZwAPYZllZlF+usg6WbiI16?=
 =?us-ascii?Q?J+UnhinOcoRGz1PXr3ZPat+oGT6hw7TDYApKdb03LkoD+Uh/OvAXMaTqqaXO?=
 =?us-ascii?Q?4Dfb7CNFNJRl6Wa2RV03xtQf?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9e8c4e-d712-4c58-d55a-08d8edbf9ebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 05:50:52.8233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LPz1gMdq2hD5/gkUBWvQ3C0w2vJGyXxopxSS74v7534c5mA6a8wEzFd5tuqtjJSyDFkPbtPXV6ilVZbDmzgTmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0214
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Nagendra S Tomar <natomar@microsoft.com>

Functions for computing target filehandles' hash for NFSv4/41/42.
RPCs which are not targeted to a specific file return a hash of 0
and they will map to the first available xprt.

Signed-off-by: Nagendra S Tomar <natomar@microsoft.com>
---
 fs/nfs/nfs42xdr.c | 112 ++++++++++++
 fs/nfs/nfs4xdr.c  | 516 ++++++++++++++++++++++++++++++++++++++++++++++----=
----
 2 files changed, 557 insertions(+), 71 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index c8bad735e4c1..c1a9d80dc85a 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -662,6 +662,14 @@ static void nfs4_xdr_enc_allocate(struct rpc_rqst *req=
,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_allocate(const void *data)
+{
+	const struct nfs42_falloc_args *args =3D data;
+	const struct nfs_fh *fh =3D args->falloc_fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 static void encode_copy_commit(struct xdr_stream *xdr,
 			  const struct nfs42_copy_args *args,
 			  struct compound_hdr *hdr)
@@ -697,6 +705,14 @@ static void nfs4_xdr_enc_copy(struct rpc_rqst *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_copy(const void *data)
+{
+	const struct nfs42_copy_args *args =3D data;
+	const struct nfs_fh *fh =3D args->dst_fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode OFFLOAD_CANEL request
  */
@@ -716,6 +732,14 @@ static void nfs4_xdr_enc_offload_cancel(struct rpc_rqs=
t *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_offload_cancel(const void *data)
+{
+	const struct nfs42_offload_status_args *args =3D data;
+	const struct nfs_fh *fh =3D args->osa_src_fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode COPY_NOTIFY request
  */
@@ -735,6 +759,14 @@ static void nfs4_xdr_enc_copy_notify(struct rpc_rqst *=
req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_copy_notify(const void *data)
+{
+	const struct nfs42_copy_notify_args *args =3D data;
+	const struct nfs_fh *fh =3D args->cna_src_fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode DEALLOCATE request
  */
@@ -755,6 +787,14 @@ static void nfs4_xdr_enc_deallocate(struct rpc_rqst *r=
eq,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_deallocate(const void *data)
+{
+	const struct nfs42_falloc_args *args =3D data;
+	const struct nfs_fh *fh =3D args->falloc_fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode READ_PLUS request
  */
@@ -777,6 +817,14 @@ static void nfs4_xdr_enc_read_plus(struct rpc_rqst *re=
q,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_read_plus(const void *data)
+{
+	const struct nfs_pgio_args *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode SEEK request
  */
@@ -796,6 +844,14 @@ static void nfs4_xdr_enc_seek(struct rpc_rqst *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_seek(const void *data)
+{
+	const struct nfs42_seek_args *args =3D data;
+	const struct nfs_fh *fh =3D args->sa_fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode LAYOUTSTATS request
  */
@@ -819,6 +875,14 @@ static void nfs4_xdr_enc_layoutstats(struct rpc_rqst *=
req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_layoutstats(const void *data)
+{
+	const struct nfs42_layoutstat_args *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode CLONE request
  */
@@ -841,6 +905,14 @@ static void nfs4_xdr_enc_clone(struct rpc_rqst *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_clone(const void *data)
+{
+	const struct nfs42_clone_args *args =3D data;
+	const struct nfs_fh *fh =3D args->dst_fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode LAYOUTERROR request
  */
@@ -862,6 +934,14 @@ static void nfs4_xdr_enc_layouterror(struct rpc_rqst *=
req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_layouterror(const void *data)
+{
+	const struct nfs42_layouterror_args *args =3D data;
+	const struct nfs_fh *fh =3D NFS_FH(args->inode);
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 static int decode_allocate(struct xdr_stream *xdr, struct nfs42_falloc_res=
 *res)
 {
 	return decode_op_hdr(xdr, OP_ALLOCATE);
@@ -1483,6 +1563,14 @@ static void nfs4_xdr_enc_setxattr(struct rpc_rqst *r=
eq, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_setxattr(const void *data)
+{
+	const struct nfs42_setxattrargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 static int nfs4_xdr_dec_setxattr(struct rpc_rqst *req, struct xdr_stream *=
xdr,
 				 void *data)
 {
@@ -1526,6 +1614,14 @@ static void nfs4_xdr_enc_getxattr(struct rpc_rqst *r=
eq, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_getxattr(const void *data)
+{
+	const struct nfs42_getxattrargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 static int nfs4_xdr_dec_getxattr(struct rpc_rqst *rqstp,
 				 struct xdr_stream *xdr, void *data)
 {
@@ -1567,6 +1663,14 @@ static void nfs4_xdr_enc_listxattrs(struct rpc_rqst =
*req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_listxattrs(const void *data)
+{
+	const struct nfs42_listxattrsargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 static int nfs4_xdr_dec_listxattrs(struct rpc_rqst *rqstp,
 				   struct xdr_stream *xdr, void *data)
 {
@@ -1605,6 +1709,14 @@ static void nfs4_xdr_enc_removexattr(struct rpc_rqst=
 *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_removexattr(const void *data)
+{
+	const struct nfs42_removexattrargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 static int nfs4_xdr_dec_removexattr(struct rpc_rqst *req,
 				    struct xdr_stream *xdr, void *data)
 {
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index ac6b79ee9355..49ced4762ab5 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -2130,6 +2130,14 @@ static void nfs4_xdr_enc_access(struct rpc_rqst *req=
, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_access(const void *data)
+{
+	const struct nfs4_accessargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode LOOKUP request
  */
@@ -2150,6 +2158,14 @@ static void nfs4_xdr_enc_lookup(struct rpc_rqst *req=
, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_lookup(const void *data)
+{
+	const struct nfs4_lookup_arg *args =3D data;
+	const struct nfs_fh *fh =3D args->dir_fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode LOOKUPP request
  */
@@ -2170,6 +2186,14 @@ static void nfs4_xdr_enc_lookupp(struct rpc_rqst *re=
q, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_lookupp(const void *data)
+{
+	const struct nfs4_lookupp_arg *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode LOOKUP_ROOT request
  */
@@ -2190,6 +2214,11 @@ static void nfs4_xdr_enc_lookup_root(struct rpc_rqst=
 *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_lookup_root(const void *data)
+{
+	return 0;
+}
+
 /*
  * Encode REMOVE request
  */
@@ -2208,6 +2237,14 @@ static void nfs4_xdr_enc_remove(struct rpc_rqst *req=
, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_remove(const void *data)
+{
+	const struct nfs_removeargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode RENAME request
  */
@@ -2228,6 +2265,14 @@ static void nfs4_xdr_enc_rename(struct rpc_rqst *req=
, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_rename(const void *data)
+{
+	const struct nfs_renameargs *args =3D data;
+	const struct nfs_fh *fh =3D args->old_dir;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode LINK request
  */
@@ -2250,6 +2295,14 @@ static void nfs4_xdr_enc_link(struct rpc_rqst *req, =
struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_link(const void *data)
+{
+	const struct nfs4_link_arg *args =3D data;
+	const struct nfs_fh *fh =3D args->dir_fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode CREATE request
  */
@@ -2270,6 +2323,14 @@ static void nfs4_xdr_enc_create(struct rpc_rqst *req=
, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_create(const void *data)
+{
+	const struct nfs4_create_arg *args =3D data;
+	const struct nfs_fh *fh =3D args->dir_fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode SYMLINK request
  */
@@ -2281,6 +2342,14 @@ static void nfs4_xdr_enc_symlink(struct rpc_rqst *re=
q, struct xdr_stream *xdr,
 	nfs4_xdr_enc_create(req, xdr, args);
 }
=20
+static u32 nfs4_fh_hash_symlink(const void *data)
+{
+	const struct nfs4_create_arg *args =3D data;
+	const struct nfs_fh *fh =3D args->dir_fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode GETATTR request
  */
@@ -2299,6 +2368,14 @@ static void nfs4_xdr_enc_getattr(struct rpc_rqst *re=
q, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_getattr(const void *data)
+{
+	const struct nfs4_getattr_arg *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode a CLOSE request
  */
@@ -2321,6 +2398,14 @@ static void nfs4_xdr_enc_close(struct rpc_rqst *req,=
 struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_close(const void *data)
+{
+	const struct nfs_closeargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode an OPEN request
  */
@@ -2349,6 +2434,14 @@ static void nfs4_xdr_enc_open(struct rpc_rqst *req, =
struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_open(const void *data)
+{
+	const struct nfs_openargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode an OPEN_CONFIRM request
  */
@@ -2367,6 +2460,14 @@ static void nfs4_xdr_enc_open_confirm(struct rpc_rqs=
t *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_open_confirm(const void *data)
+{
+	const struct nfs_open_confirmargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode an OPEN request with no attributes.
  */
@@ -2395,6 +2496,14 @@ static void nfs4_xdr_enc_open_noattr(struct rpc_rqst=
 *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_open_noattr(const void *data)
+{
+	const struct nfs_openargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode an OPEN_DOWNGRADE request
  */
@@ -2416,6 +2525,14 @@ static void nfs4_xdr_enc_open_downgrade(struct rpc_r=
qst *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_open_downgrade(const void *data)
+{
+	const struct nfs_closeargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode a LOCK request
  */
@@ -2434,6 +2551,14 @@ static void nfs4_xdr_enc_lock(struct rpc_rqst *req, =
struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_lock(const void *data)
+{
+	const struct nfs_lock_args *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode a LOCKT request
  */
@@ -2452,6 +2577,14 @@ static void nfs4_xdr_enc_lockt(struct rpc_rqst *req,=
 struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_lockt(const void *data)
+{
+	const struct nfs_lockt_args *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode a LOCKU request
  */
@@ -2470,6 +2603,14 @@ static void nfs4_xdr_enc_locku(struct rpc_rqst *req,=
 struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_locku(const void *data)
+{
+	const struct nfs_locku_args *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 static void nfs4_xdr_enc_release_lockowner(struct rpc_rqst *req,
 					   struct xdr_stream *xdr,
 					   const void *data)
@@ -2484,6 +2625,11 @@ static void nfs4_xdr_enc_release_lockowner(struct rp=
c_rqst *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_release_lockowner(const void *data)
+{
+	return 0;
+}
+
 /*
  * Encode a READLINK request
  */
@@ -2505,6 +2651,14 @@ static void nfs4_xdr_enc_readlink(struct rpc_rqst *r=
eq, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_readlink(const void *data)
+{
+	const struct nfs4_readlink *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode a READDIR request
  */
@@ -2526,6 +2680,14 @@ static void nfs4_xdr_enc_readdir(struct rpc_rqst *re=
q, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_readdir(const void *data)
+{
+	const struct nfs4_readdir_arg *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode a READ request
  */
@@ -2548,6 +2710,14 @@ static void nfs4_xdr_enc_read(struct rpc_rqst *req, =
struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_read(const void *data)
+{
+	const struct nfs_pgio_args *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode an SETATTR request
  */
@@ -2567,6 +2737,14 @@ static void nfs4_xdr_enc_setattr(struct rpc_rqst *re=
q, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_setattr(const void *data)
+{
+	const struct nfs_setattrargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode a GETACL request
  */
@@ -2594,6 +2772,14 @@ static void nfs4_xdr_enc_getacl(struct rpc_rqst *req=
, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_getacl(const void *data)
+{
+	const struct nfs_getaclargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode a WRITE request
  */
@@ -2615,6 +2801,14 @@ static void nfs4_xdr_enc_write(struct rpc_rqst *req,=
 struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_write(const void *data)
+{
+	const struct nfs_pgio_args *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  *  a COMMIT request
  */
@@ -2633,6 +2827,14 @@ static void nfs4_xdr_enc_commit(struct rpc_rqst *req=
, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_commit(const void *data)
+{
+	const struct nfs_commitargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * FSINFO request
  */
@@ -2651,6 +2853,14 @@ static void nfs4_xdr_enc_fsinfo(struct rpc_rqst *req=
, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_fsinfo(const void *data)
+{
+	const struct nfs4_fsinfo_arg *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * a PATHCONF request
  */
@@ -2670,6 +2880,14 @@ static void nfs4_xdr_enc_pathconf(struct rpc_rqst *r=
eq, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_pathconf(const void *data)
+{
+	const struct nfs4_pathconf_arg *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * a STATFS request
  */
@@ -2689,6 +2907,14 @@ static void nfs4_xdr_enc_statfs(struct rpc_rqst *req=
, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_statfs(const void *data)
+{
+	const struct nfs4_statfs_arg *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * GETATTR_BITMAP request
  */
@@ -2709,6 +2935,14 @@ static void nfs4_xdr_enc_server_caps(struct rpc_rqst=
 *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_server_caps(const void *data)
+{
+	const struct nfs4_server_caps_arg *args =3D data;
+	const struct nfs_fh *fh =3D args->fhandle;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * a RENEW request
  */
@@ -2726,6 +2960,11 @@ static void nfs4_xdr_enc_renew(struct rpc_rqst *req,=
 struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_renew(const void *data)
+{
+	return 0;
+}
+
 /*
  * a SETCLIENTID request
  */
@@ -2743,6 +2982,11 @@ static void nfs4_xdr_enc_setclientid(struct rpc_rqst=
 *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_setclientid(const void *data)
+{
+	return 0;
+}
+
 /*
  * a SETCLIENTID_CONFIRM request
  */
@@ -2760,6 +3004,11 @@ static void nfs4_xdr_enc_setclientid_confirm(struct =
rpc_rqst *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_setclientid_confirm(const void *data)
+{
+	return 0;
+}
+
 /*
  * DELEGRETURN request
  */
@@ -2783,6 +3032,14 @@ static void nfs4_xdr_enc_delegreturn(struct rpc_rqst=
 *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_delegreturn(const void *data)
+{
+	const struct nfs4_delegreturnargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fhandle;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode FS_LOCATIONS request
  */
@@ -2816,6 +3073,14 @@ static void nfs4_xdr_enc_fs_locations(struct rpc_rqs=
t *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_fs_locations(const void *data)
+{
+	const struct nfs4_fs_locations_arg *args =3D data;
+	const struct nfs_fh *fh =3D args->migration ? args->fh : args->dir_fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode SECINFO request
  */
@@ -2835,6 +3100,14 @@ static void nfs4_xdr_enc_secinfo(struct rpc_rqst *re=
q,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_secinfo(const void *data)
+{
+	const struct nfs4_secinfo_arg *args =3D data;
+	const struct nfs_fh *fh =3D args->dir_fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode FSID_PRESENT request
  */
@@ -2856,6 +3129,14 @@ static void nfs4_xdr_enc_fsid_present(struct rpc_rqs=
t *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_fsid_present(const void *data)
+{
+	const struct nfs4_fsid_present_arg *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 #if defined(CONFIG_NFS_V4_1)
 /*
  * BIND_CONN_TO_SESSION request
@@ -2874,6 +3155,11 @@ static void nfs4_xdr_enc_bind_conn_to_session(struct=
 rpc_rqst *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_bind_conn_to_session(const void *data)
+{
+	return 0;
+}
+
 /*
  * EXCHANGE_ID request
  */
@@ -2891,6 +3177,11 @@ static void nfs4_xdr_enc_exchange_id(struct rpc_rqst=
 *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_exchange_id(const void *data)
+{
+	return 0;
+}
+
 /*
  * a CREATE_SESSION request
  */
@@ -2908,6 +3199,11 @@ static void nfs4_xdr_enc_create_session(struct rpc_r=
qst *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_create_session(const void *data)
+{
+	return 0;
+}
+
 /*
  * a DESTROY_SESSION request
  */
@@ -2925,6 +3221,11 @@ static void nfs4_xdr_enc_destroy_session(struct rpc_=
rqst *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_destroy_session(const void *data)
+{
+	return 0;
+}
+
 /*
  * a DESTROY_CLIENTID request
  */
@@ -2942,6 +3243,11 @@ static void nfs4_xdr_enc_destroy_clientid(struct rpc=
_rqst *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_destroy_clientid(const void *data)
+{
+	return 0;
+}
+
 /*
  * a SEQUENCE request
  */
@@ -2958,6 +3264,11 @@ static void nfs4_xdr_enc_sequence(struct rpc_rqst *r=
eq, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_sequence(const void *data)
+{
+	return 0;
+}
+
 #endif
=20
 /*
@@ -2980,6 +3291,11 @@ static void nfs4_xdr_enc_get_lease_time(struct rpc_r=
qst *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_get_lease_time(const void *data)
+{
+	return 0;
+}
+
 #ifdef CONFIG_NFS_V4_1
=20
 /*
@@ -3000,6 +3316,11 @@ static void nfs4_xdr_enc_reclaim_complete(struct rpc=
_rqst *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_reclaim_complete(const void *data)
+{
+	return 0;
+}
+
 /*
  * Encode GETDEVICEINFO request
  */
@@ -3027,6 +3348,11 @@ static void nfs4_xdr_enc_getdeviceinfo(struct rpc_rq=
st *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_getdeviceinfo(const void *data)
+{
+	return 0;
+}
+
 /*
  *  Encode LAYOUTGET request
  */
@@ -3049,6 +3375,14 @@ static void nfs4_xdr_enc_layoutget(struct rpc_rqst *=
req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_layoutget(const void *data)
+{
+	const struct nfs4_layoutget_args *args =3D data;
+	const struct nfs_fh *fh =3D NFS_FH(args->inode);
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  *  Encode LAYOUTCOMMIT request
  */
@@ -3071,6 +3405,14 @@ static void nfs4_xdr_enc_layoutcommit(struct rpc_rqs=
t *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_layoutcommit(const void *priv)
+{
+	const struct nfs4_layoutcommit_args *args =3D priv;
+	const struct nfs_fh *fh =3D NFS_FH(args->inode);
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode LAYOUTRETURN request
  */
@@ -3090,6 +3432,14 @@ static void nfs4_xdr_enc_layoutreturn(struct rpc_rqs=
t *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_layoutreturn(const void *data)
+{
+	const struct nfs4_layoutreturn_args *args =3D data;
+	const struct nfs_fh *fh =3D NFS_FH(args->inode);
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Encode SECINFO_NO_NAME request
  */
@@ -3109,6 +3459,11 @@ static void nfs4_xdr_enc_secinfo_no_name(struct rpc_=
rqst *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_secinfo_no_name(const void *data)
+{
+	return 0;
+}
+
 /*
  *  Encode TEST_STATEID request
  */
@@ -3127,6 +3482,11 @@ static void nfs4_xdr_enc_test_stateid(struct rpc_rqs=
t *req,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_test_stateid(const void *data)
+{
+	return 0;
+}
+
 /*
  *  Encode FREE_STATEID request
  */
@@ -3144,6 +3504,11 @@ static void nfs4_xdr_enc_free_stateid(struct rpc_rqs=
t *req,
 	encode_free_stateid(xdr, args, &hdr);
 	encode_nops(&hdr);
 }
+
+static u32 nfs4_fh_hash_free_stateid(const void *data)
+{
+	return 0;
+}
 #endif /* CONFIG_NFS_V4_1 */
=20
 static int decode_opaque_inline(struct xdr_stream *xdr, unsigned int *len,=
 char **string)
@@ -6373,6 +6738,14 @@ static void nfs4_xdr_enc_setacl(struct rpc_rqst *req=
, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
=20
+static u32 nfs4_fh_hash_setacl(const void *data)
+{
+	const struct nfs_setaclargs *args =3D data;
+	const struct nfs_fh *fh =3D args->fh;
+
+	return jhash(fh->data, fh->size, 0);
+}
+
 /*
  * Decode SETACL response
  */
@@ -7521,10 +7894,11 @@ nfs4_stat_to_errno(int stat)
 #define PROC(proc, argtype, restype)				\
 [NFSPROC4_CLNT_##proc] =3D {					\
 	.p_proc   =3D NFSPROC4_COMPOUND,				\
-	.p_encode =3D nfs4_xdr_##argtype,				\
-	.p_decode =3D nfs4_xdr_##restype,				\
-	.p_arglen =3D NFS4_##argtype##_sz,			\
-	.p_replen =3D NFS4_##restype##_sz,			\
+	.p_encode =3D nfs4_xdr_enc_##argtype,			\
+	.p_decode =3D nfs4_xdr_dec_##restype,			\
+	.p_fhhash =3D nfs4_fh_hash_##argtype,			\
+	.p_arglen =3D NFS4_enc_##argtype##_sz,			\
+	.p_replen =3D NFS4_dec_##restype##_sz,			\
 	.p_statidx =3D NFSPROC4_CLNT_##proc,			\
 	.p_name   =3D #proc,					\
 }
@@ -7551,75 +7925,75 @@ nfs4_stat_to_errno(int stat)
 #endif
=20
 const struct rpc_procinfo nfs4_procedures[] =3D {
-	PROC(READ,		enc_read,		dec_read),
-	PROC(WRITE,		enc_write,		dec_write),
-	PROC(COMMIT,		enc_commit,		dec_commit),
-	PROC(OPEN,		enc_open,		dec_open),
-	PROC(OPEN_CONFIRM,	enc_open_confirm,	dec_open_confirm),
-	PROC(OPEN_NOATTR,	enc_open_noattr,	dec_open_noattr),
-	PROC(OPEN_DOWNGRADE,	enc_open_downgrade,	dec_open_downgrade),
-	PROC(CLOSE,		enc_close,		dec_close),
-	PROC(SETATTR,		enc_setattr,		dec_setattr),
-	PROC(FSINFO,		enc_fsinfo,		dec_fsinfo),
-	PROC(RENEW,		enc_renew,		dec_renew),
-	PROC(SETCLIENTID,	enc_setclientid,	dec_setclientid),
-	PROC(SETCLIENTID_CONFIRM, enc_setclientid_confirm, dec_setclientid_confir=
m),
-	PROC(LOCK,		enc_lock,		dec_lock),
-	PROC(LOCKT,		enc_lockt,		dec_lockt),
-	PROC(LOCKU,		enc_locku,		dec_locku),
-	PROC(ACCESS,		enc_access,		dec_access),
-	PROC(GETATTR,		enc_getattr,		dec_getattr),
-	PROC(LOOKUP,		enc_lookup,		dec_lookup),
-	PROC(LOOKUP_ROOT,	enc_lookup_root,	dec_lookup_root),
-	PROC(REMOVE,		enc_remove,		dec_remove),
-	PROC(RENAME,		enc_rename,		dec_rename),
-	PROC(LINK,		enc_link,		dec_link),
-	PROC(SYMLINK,		enc_symlink,		dec_symlink),
-	PROC(CREATE,		enc_create,		dec_create),
-	PROC(PATHCONF,		enc_pathconf,		dec_pathconf),
-	PROC(STATFS,		enc_statfs,		dec_statfs),
-	PROC(READLINK,		enc_readlink,		dec_readlink),
-	PROC(READDIR,		enc_readdir,		dec_readdir),
-	PROC(SERVER_CAPS,	enc_server_caps,	dec_server_caps),
-	PROC(DELEGRETURN,	enc_delegreturn,	dec_delegreturn),
-	PROC(GETACL,		enc_getacl,		dec_getacl),
-	PROC(SETACL,		enc_setacl,		dec_setacl),
-	PROC(FS_LOCATIONS,	enc_fs_locations,	dec_fs_locations),
-	PROC(RELEASE_LOCKOWNER,	enc_release_lockowner,	dec_release_lockowner),
-	PROC(SECINFO,		enc_secinfo,		dec_secinfo),
-	PROC(FSID_PRESENT,	enc_fsid_present,	dec_fsid_present),
-	PROC41(EXCHANGE_ID,	enc_exchange_id,	dec_exchange_id),
-	PROC41(CREATE_SESSION,	enc_create_session,	dec_create_session),
-	PROC41(DESTROY_SESSION,	enc_destroy_session,	dec_destroy_session),
-	PROC41(SEQUENCE,	enc_sequence,		dec_sequence),
-	PROC(GET_LEASE_TIME,	enc_get_lease_time,	dec_get_lease_time),
-	PROC41(RECLAIM_COMPLETE,enc_reclaim_complete,	dec_reclaim_complete),
-	PROC41(GETDEVICEINFO,	enc_getdeviceinfo,	dec_getdeviceinfo),
-	PROC41(LAYOUTGET,	enc_layoutget,		dec_layoutget),
-	PROC41(LAYOUTCOMMIT,	enc_layoutcommit,	dec_layoutcommit),
-	PROC41(LAYOUTRETURN,	enc_layoutreturn,	dec_layoutreturn),
-	PROC41(SECINFO_NO_NAME,	enc_secinfo_no_name,	dec_secinfo_no_name),
-	PROC41(TEST_STATEID,	enc_test_stateid,	dec_test_stateid),
-	PROC41(FREE_STATEID,	enc_free_stateid,	dec_free_stateid),
+	PROC(READ,		read,		read),
+	PROC(WRITE,		write,		write),
+	PROC(COMMIT,		commit,		commit),
+	PROC(OPEN,		open,		open),
+	PROC(OPEN_CONFIRM,	open_confirm,	open_confirm),
+	PROC(OPEN_NOATTR,	open_noattr,	open_noattr),
+	PROC(OPEN_DOWNGRADE,	open_downgrade,	open_downgrade),
+	PROC(CLOSE,		close,		close),
+	PROC(SETATTR,		setattr,	setattr),
+	PROC(FSINFO,		fsinfo,		fsinfo),
+	PROC(RENEW,		renew,		renew),
+	PROC(SETCLIENTID,	setclientid,	setclientid),
+	PROC(SETCLIENTID_CONFIRM, setclientid_confirm, setclientid_confirm),
+	PROC(LOCK,		lock,		lock),
+	PROC(LOCKT,		lockt,		lockt),
+	PROC(LOCKU,		locku,		locku),
+	PROC(ACCESS,		access,		access),
+	PROC(GETATTR,		getattr,	getattr),
+	PROC(LOOKUP,		lookup,		lookup),
+	PROC(LOOKUP_ROOT,	lookup_root,	lookup_root),
+	PROC(REMOVE,		remove,		remove),
+	PROC(RENAME,		rename,		rename),
+	PROC(LINK,		link,		link),
+	PROC(SYMLINK,		symlink,	symlink),
+	PROC(CREATE,		create,		create),
+	PROC(PATHCONF,		pathconf,	pathconf),
+	PROC(STATFS,		statfs,		statfs),
+	PROC(READLINK,		readlink,	readlink),
+	PROC(READDIR,		readdir,	readdir),
+	PROC(SERVER_CAPS,	server_caps,	server_caps),
+	PROC(DELEGRETURN,	delegreturn,	delegreturn),
+	PROC(GETACL,		getacl,		getacl),
+	PROC(SETACL,		setacl,		setacl),
+	PROC(FS_LOCATIONS,	fs_locations,	fs_locations),
+	PROC(RELEASE_LOCKOWNER,	release_lockowner, release_lockowner),
+	PROC(SECINFO,		secinfo,	secinfo),
+	PROC(FSID_PRESENT,	fsid_present,	fsid_present),
+	PROC41(EXCHANGE_ID,	exchange_id,	exchange_id),
+	PROC41(CREATE_SESSION,	create_session,	create_session),
+	PROC41(DESTROY_SESSION,	destroy_session, destroy_session),
+	PROC41(SEQUENCE,	sequence,	sequence),
+	PROC(GET_LEASE_TIME,	get_lease_time,	get_lease_time),
+	PROC41(RECLAIM_COMPLETE, reclaim_complete, reclaim_complete),
+	PROC41(GETDEVICEINFO,	getdeviceinfo,	getdeviceinfo),
+	PROC41(LAYOUTGET,	layoutget,	layoutget),
+	PROC41(LAYOUTCOMMIT,	layoutcommit,	layoutcommit),
+	PROC41(LAYOUTRETURN,	layoutreturn,	layoutreturn),
+	PROC41(SECINFO_NO_NAME,	secinfo_no_name, secinfo_no_name),
+	PROC41(TEST_STATEID,	test_stateid,	test_stateid),
+	PROC41(FREE_STATEID,	free_stateid,	free_stateid),
 	STUB(GETDEVICELIST),
 	PROC41(BIND_CONN_TO_SESSION,
-			enc_bind_conn_to_session, dec_bind_conn_to_session),
-	PROC41(DESTROY_CLIENTID,enc_destroy_clientid,	dec_destroy_clientid),
-	PROC42(SEEK,		enc_seek,		dec_seek),
-	PROC42(ALLOCATE,	enc_allocate,		dec_allocate),
-	PROC42(DEALLOCATE,	enc_deallocate,		dec_deallocate),
-	PROC42(LAYOUTSTATS,	enc_layoutstats,	dec_layoutstats),
-	PROC42(CLONE,		enc_clone,		dec_clone),
-	PROC42(COPY,		enc_copy,		dec_copy),
-	PROC42(OFFLOAD_CANCEL,	enc_offload_cancel,	dec_offload_cancel),
-	PROC42(COPY_NOTIFY,	enc_copy_notify,	dec_copy_notify),
-	PROC(LOOKUPP,		enc_lookupp,		dec_lookupp),
-	PROC42(LAYOUTERROR,	enc_layouterror,	dec_layouterror),
-	PROC42(GETXATTR,	enc_getxattr,		dec_getxattr),
-	PROC42(SETXATTR,	enc_setxattr,		dec_setxattr),
-	PROC42(LISTXATTRS,	enc_listxattrs,		dec_listxattrs),
-	PROC42(REMOVEXATTR,	enc_removexattr,	dec_removexattr),
-	PROC42(READ_PLUS,	enc_read_plus,		dec_read_plus),
+			bind_conn_to_session, bind_conn_to_session),
+	PROC41(DESTROY_CLIENTID, destroy_clientid, destroy_clientid),
+	PROC42(SEEK,		seek,		seek),
+	PROC42(ALLOCATE,	allocate,	allocate),
+	PROC42(DEALLOCATE,	deallocate,	deallocate),
+	PROC42(LAYOUTSTATS,	layoutstats,	layoutstats),
+	PROC42(CLONE,		clone,		clone),
+	PROC42(COPY,		copy,		copy),
+	PROC42(OFFLOAD_CANCEL,	offload_cancel,	offload_cancel),
+	PROC42(COPY_NOTIFY,	copy_notify,	copy_notify),
+	PROC(LOOKUPP,		lookupp,	lookupp),
+	PROC42(LAYOUTERROR,	layouterror,	layouterror),
+	PROC42(GETXATTR,	getxattr,	getxattr),
+	PROC42(SETXATTR,	setxattr,	setxattr),
+	PROC42(LISTXATTRS,	listxattrs,	listxattrs),
+	PROC42(REMOVEXATTR,	removexattr,	removexattr),
+	PROC42(READ_PLUS,	read_plus,	read_plus),
 };
=20
 static unsigned int nfs_version4_counts[ARRAY_SIZE(nfs4_procedures)];
