Return-Path: <linux-nfs+bounces-5411-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AAC9548F8
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 14:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95EA280719
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 12:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E1F1B5800;
	Fri, 16 Aug 2024 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBjwsILu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7961B4C4B;
	Fri, 16 Aug 2024 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812155; cv=none; b=j56Nh2DFY1Z05jfanbrvYeOO8C3a+dAESIEU14n2as8k688qudXsWRiqI9neGtoqabMfeowNYqZvLN7IyvIFjsSa50pciUGTmGNRr4v6BshJo4vusQU6KVvBF7Pr/klASf+vwHahAvfk2iLIT53jnrYQXEwTjc9imoJdur1Dr8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812155; c=relaxed/simple;
	bh=XAVNd7eNGetYO/s4SKS4PDcX3zzd1/jHRso3c7tiSmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZAXqwd35+Pn/F5bm25aVSfCLqZWSYptOLR5GASdTpkeV1l8ko9QPXQZHZcHRzRFZEwc+7tQI72acnOOLfpVQ0Nzt3vR4+iqFNHCIaC2hVtZtvW4kmwHeNgfZY27Y63LWhihM9XHwjVPShGHewRdyEINBSCP0HUaz+UCuNI+k20I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBjwsILu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC69C4AF10;
	Fri, 16 Aug 2024 12:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723812154;
	bh=XAVNd7eNGetYO/s4SKS4PDcX3zzd1/jHRso3c7tiSmE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gBjwsILugEhIcfbeRoqLUoZv915kh3omE4Sa6jEABgSdhguf08Uv86G10cJlHqnFt
	 yZ4PwTBdz3oxNSZrX+fcTD3mGM85eVlgb6bQTQTq4HnS6653rm8mBIWpJmvZzEoQyU
	 S7eJm9lnSwO2u8BxuUsS89bPo8DdGij4FCVIrvEvL43w9ZFVFtsaKM/SDy4MKaJ6kR
	 li64YowvYUhz4b6sllkbe8ZjCXCSyxdoS4rwsPrFCayS2ATYB1ljCehlGCnCEmvMtm
	 FjrCEkRq43hO8Z+FO6JfUPCUqmMRpc4Ayi60mOA4WO50n189E/7h9WtpFQpjgCbr/e
	 q2UlvDNMkL78A==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 16 Aug 2024 08:42:07 -0400
Subject: [PATCH 1/3] nfsd: bring in support for delstid draft XDR encoding
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-delstid-v1-1-c221c3dc14cd@kernel.org>
References: <20240816-delstid-v1-0-c221c3dc14cd@kernel.org>
In-Reply-To: <20240816-delstid-v1-0-c221c3dc14cd@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Tom Haynes <loghyr@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15959; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=XAVNd7eNGetYO/s4SKS4PDcX3zzd1/jHRso3c7tiSmE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmv0k3/XxnMJjtI6vbJHTZqzIKf6jrsumJxOM4F
 foq+wrdNxCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZr9JNwAKCRAADmhBGVaC
 FaMsD/0RW6jpspLZzCvAbO6I2I/sb7voE5bJgy0H8Zz48AEXDUgqvJARoMxpfJgGtKYl8dMAMZU
 wEE/y7GWZTasAi8wfoUgRJACWGG7asYUHvzV3ZNfY6I/9lE3R0AyfTFJe9yA4N8H7gHh0+5V1tI
 Z0K3Vx9tHZAFpXImk+MR6Ou8JXFt0kx5eXGSUoLy8y5CujOhPMMnLX86wcQpvzwxIy0Lk7M9jMC
 ExWVFOO08lKlyfaIdGKXhneqernyiX+NhM0nWhwfGqyrB+fT+zdzXgMiJvY4tun45vLSIHI/VYo
 Nhx9aXtwi/tDZzwdHjH4GiHVA+J6IkcA9eSo6DUvH4JymfeHv+R44FzzbV7yhDThOzu74kIMwek
 SOJ57gGeWvZIySaAXM1DM1QNGzygbnKy5XRw3qfvO393qbY9c6Ob8SDGVpGJQhu6sBlSVytxuaL
 v1O2a36371ERpx9fnlPrTz3WWbg55jLmEIXfihKGaGRdvkN9DKCb5KROON/txZS7M+Yj0iCR6QR
 K/AD4w/jaQNU97VDs9rIJjrXSjqM2PJPTGaEBNbJgML9pfiAnw8yXUtgkL30ySADz7k3nq4yE2V
 EYDdPl4Yf6jBSSuiMPbEQXNNwkX/ucYAsAPlbo35Dx33ydd3wIFmnxEdOh/Zh3e4mb1zsGjsJ4L
 fePOFDV0pxSi+RA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This adds support for the "delstid" draft:

    https://datatracker.ietf.org/doc/draft-ietf-nfsv4-delstid/05/

Most of this was autogenerated using Chuck's lkxdrgen tool with some
by-hand tweaks to work around some symbol conflicts, and to add some
missing pieces that were needed from nfs4_1.x.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/Makefile      |   2 +-
 fs/nfsd/delstid_xdr.c | 464 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/delstid_xdr.h | 102 +++++++++++
 fs/nfsd/nfs4xdr.c     |   1 +
 4 files changed, 568 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
index b8736a82e57c..187fa45640e6 100644
--- a/fs/nfsd/Makefile
+++ b/fs/nfsd/Makefile
@@ -18,7 +18,7 @@ nfsd-$(CONFIG_NFSD_V2) += nfsproc.o nfsxdr.o
 nfsd-$(CONFIG_NFSD_V2_ACL) += nfs2acl.o
 nfsd-$(CONFIG_NFSD_V3_ACL) += nfs3acl.o
 nfsd-$(CONFIG_NFSD_V4)	+= nfs4proc.o nfs4xdr.o nfs4state.o nfs4idmap.o \
-			   nfs4acl.o nfs4callback.o nfs4recover.o
+			   nfs4acl.o nfs4callback.o nfs4recover.o delstid_xdr.o
 nfsd-$(CONFIG_NFSD_PNFS) += nfs4layouts.o
 nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
 nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
diff --git a/fs/nfsd/delstid_xdr.c b/fs/nfsd/delstid_xdr.c
new file mode 100644
index 000000000000..63494d14f5d2
--- /dev/null
+++ b/fs/nfsd/delstid_xdr.c
@@ -0,0 +1,464 @@
+// SPDX-License-Identifier: GPL-2.0
+// Generated by lkxdrgen, with hand-edits.
+// XDR specification modification time: Wed Aug 14 13:35:03 2024
+
+#include "delstid_xdr.h"
+
+static inline bool
+xdrgen_decode_void(struct xdr_stream *xdr)
+{
+	return true;
+}
+
+static inline bool
+xdrgen_decode_bool(struct xdr_stream *xdr, bool *ptr)
+{
+	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*ptr = (*p != xdr_zero);
+	return true;
+}
+
+static inline bool
+xdrgen_decode_int(struct xdr_stream *xdr, s32 *ptr)
+{
+	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*ptr = be32_to_cpup(p);
+	return true;
+}
+
+static inline bool
+xdrgen_decode_unsigned_int(struct xdr_stream *xdr, u32 *ptr)
+{
+	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*ptr = be32_to_cpup(p);
+	return true;
+}
+
+static inline bool
+xdrgen_decode_uint32_t(struct xdr_stream *xdr, u32 *ptr)
+{
+	return xdrgen_decode_unsigned_int(xdr, ptr);
+}
+
+static inline bool
+xdrgen_decode_long(struct xdr_stream *xdr, s32 *ptr)
+{
+	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*ptr = be32_to_cpup(p);
+	return true;
+}
+
+static inline bool
+xdrgen_decode_unsigned_long(struct xdr_stream *xdr, u32 *ptr)
+{
+	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*ptr = be32_to_cpup(p);
+	return true;
+}
+
+static inline bool
+xdrgen_decode_hyper(struct xdr_stream *xdr, s64 *ptr)
+{
+	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT * 2);
+
+	if (unlikely(!p))
+		return false;
+	*ptr = get_unaligned_be64(p);
+	return true;
+}
+
+static inline bool
+xdrgen_decode_int64_t(struct xdr_stream *xdr, s64 *ptr)
+{
+	return xdrgen_decode_hyper(xdr, ptr);
+}
+
+static inline bool
+xdrgen_decode_unsigned_hyper(struct xdr_stream *xdr, u64 *ptr)
+{
+	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT * 2);
+
+	if (unlikely(!p))
+		return false;
+	*ptr = get_unaligned_be64(p);
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_opaque(struct xdr_stream *xdr, opaque *ptr, u32 maxlen)
+{
+	__be32 *p;
+	u32 len;
+
+	if (unlikely(xdr_stream_decode_u32(xdr, &len) != XDR_UNIT))
+		return false;
+	if (unlikely(maxlen && len > maxlen))
+		return false;
+	if (len != 0) {
+		p = xdr_inline_decode(xdr, len);
+		if (unlikely(!p))
+			return false;
+		ptr->data = (u8 *)p;
+	}
+	ptr->len = len;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_string(struct xdr_stream *xdr, string *ptr, u32 maxlen)
+{
+	__be32 *p;
+	u32 len;
+
+	if (unlikely(xdr_stream_decode_u32(xdr, &len) != XDR_UNIT))
+		return false;
+	if (unlikely(maxlen && len > maxlen))
+		return false;
+	if (len != 0) {
+		p = xdr_inline_decode(xdr, len);
+		if (unlikely(!p))
+			return false;
+		ptr->data = (unsigned char *)p;
+	}
+	ptr->len = len;
+	return true;
+}
+
+static inline bool
+xdrgen_encode_void(struct xdr_stream *xdr)
+{
+	return true;
+}
+
+static inline bool
+xdrgen_encode_bool(struct xdr_stream *xdr, bool val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*p = val ? xdr_one : xdr_zero;
+	return true;
+}
+
+static inline bool
+xdrgen_encode_int(struct xdr_stream *xdr, s32 val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*p = cpu_to_be32(val);
+	return true;
+}
+
+static inline bool
+xdrgen_encode_unsigned_int(struct xdr_stream *xdr, u32 val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*p = cpu_to_be32(val);
+	return true;
+}
+
+static inline bool
+xdrgen_encode_uint32_t(struct xdr_stream *xdr, u32 val)
+{
+	return xdrgen_encode_unsigned_int(xdr, val);
+}
+
+static inline bool
+xdrgen_encode_long(struct xdr_stream *xdr, s32 val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*p = cpu_to_be32(val);
+	return true;
+}
+
+static inline bool
+xdrgen_encode_unsigned_long(struct xdr_stream *xdr, u32 val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT);
+
+	if (unlikely(!p))
+		return false;
+	*p = cpu_to_be32(val);
+	return true;
+}
+
+static inline bool
+xdrgen_encode_hyper(struct xdr_stream *xdr, s64 val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT * 2);
+
+	if (unlikely(!p))
+		return false;
+	put_unaligned_be64(val, p);
+	return true;
+}
+
+static inline bool
+xdrgen_encode_int64_t(struct xdr_stream *xdr, s64 val)
+{
+	return xdrgen_encode_hyper(xdr, val);
+}
+
+static inline bool
+xdrgen_encode_unsigned_hyper(struct xdr_stream *xdr, u64 val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT * 2);
+
+	if (unlikely(!p))
+		return false;
+	put_unaligned_be64(val, p);
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_opaque(struct xdr_stream *xdr, opaque val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT + xdr_align_size(val.len));
+
+	if (unlikely(!p))
+		return false;
+	xdr_encode_opaque(p, val.data, val.len);
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_string(struct xdr_stream *xdr, string val, u32 maxlen)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT + xdr_align_size(val.len));
+
+	if (unlikely(!p))
+		return false;
+	xdr_encode_opaque(p, val.data, val.len);
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_fattr4_offline(struct xdr_stream *xdr, fattr4_offline *ptr)
+{
+	return xdrgen_decode_bool(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_decode_bitmap4(struct xdr_stream *xdr, bitmap4 *ptr)
+{
+	if (xdr_stream_decode_u32(xdr, &ptr->count) < 0)
+		return false;
+	for (u32 i = 0; i < ptr->count; i++)
+		if (!xdrgen_decode_uint32_t(xdr, &ptr->element[i]))
+			return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_decode_open_arguments4(struct xdr_stream *xdr, struct open_arguments4 *ptr)
+{
+	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_share_access))
+		return false;
+	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_share_deny))
+		return false;
+	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_share_access_want))
+		return false;
+	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_open_claim))
+		return false;
+	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_create_mode))
+		return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_decode_open_args_share_access4(struct xdr_stream *xdr, enum open_args_share_access4 *ptr)
+{
+	u32 val;
+
+	if (xdr_stream_decode_u32(xdr, &val) < 0)
+		return false;
+	*ptr = val;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_open_args_share_deny4(struct xdr_stream *xdr, enum open_args_share_deny4 *ptr)
+{
+	u32 val;
+
+	if (xdr_stream_decode_u32(xdr, &val) < 0)
+		return false;
+	*ptr = val;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_open_args_share_access_want4(struct xdr_stream *xdr, enum open_args_share_access_want4 *ptr)
+{
+	u32 val;
+
+	if (xdr_stream_decode_u32(xdr, &val) < 0)
+		return false;
+	*ptr = val;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_open_args_open_claim4(struct xdr_stream *xdr, enum open_args_open_claim4 *ptr)
+{
+	u32 val;
+
+	if (xdr_stream_decode_u32(xdr, &val) < 0)
+		return false;
+	*ptr = val;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_open_args_createmode4(struct xdr_stream *xdr, enum open_args_createmode4 *ptr)
+{
+	u32 val;
+
+	if (xdr_stream_decode_u32(xdr, &val) < 0)
+		return false;
+	*ptr = val;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_fattr4_open_arguments(struct xdr_stream *xdr, fattr4_open_arguments *ptr)
+{
+	return xdrgen_decode_open_arguments4(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_decode_nfstime4(struct xdr_stream *xdr, struct _nfstime4 *ptr)
+{
+	if (!xdrgen_decode_int64_t(xdr, &ptr->seconds))
+		return false;
+	if (!xdrgen_decode_uint32_t(xdr, &ptr->nseconds))
+		return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_decode_fattr4_time_deleg_access(struct xdr_stream *xdr, fattr4_time_deleg_access *ptr)
+{
+	return xdrgen_decode_nfstime4(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_decode_fattr4_time_deleg_modify(struct xdr_stream *xdr, fattr4_time_deleg_modify *ptr)
+{
+	return xdrgen_decode_nfstime4(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_encode_fattr4_offline(struct xdr_stream *xdr, const fattr4_offline value)
+{
+	return xdrgen_encode_bool(xdr, value);
+};
+
+static bool __maybe_unused
+xdrgen_encode_bitmap4(struct xdr_stream *xdr, const bitmap4 value)
+{
+	if (xdr_stream_encode_u32(xdr, value.count) != XDR_UNIT)
+		return false;
+	for (u32 i = 0; i < value.count; i++)
+		if (!xdrgen_encode_uint32_t(xdr, value.element[i]))
+			return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_encode_open_arguments4(struct xdr_stream *xdr, const struct open_arguments4 *value)
+{
+	if (!xdrgen_encode_bitmap4(xdr, value->oa_share_access))
+		return false;
+	if (!xdrgen_encode_bitmap4(xdr, value->oa_share_deny))
+		return false;
+	if (!xdrgen_encode_bitmap4(xdr, value->oa_share_access_want))
+		return false;
+	if (!xdrgen_encode_bitmap4(xdr, value->oa_open_claim))
+		return false;
+	if (!xdrgen_encode_bitmap4(xdr, value->oa_create_mode))
+		return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_encode_open_args_share_access4(struct xdr_stream *xdr, enum open_args_share_access4 value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+static bool __maybe_unused
+xdrgen_encode_open_args_share_deny4(struct xdr_stream *xdr, enum open_args_share_deny4 value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+static bool __maybe_unused
+xdrgen_encode_open_args_share_access_want4(struct xdr_stream *xdr, enum open_args_share_access_want4 value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+static bool __maybe_unused
+xdrgen_encode_open_args_open_claim4(struct xdr_stream *xdr, enum open_args_open_claim4 value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+static bool __maybe_unused
+xdrgen_encode_open_args_createmode4(struct xdr_stream *xdr, enum open_args_createmode4 value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+static bool __maybe_unused
+xdrgen_encode_fattr4_open_arguments(struct xdr_stream *xdr, const fattr4_open_arguments *value)
+{
+	return xdrgen_encode_open_arguments4(xdr, value);
+};
+
+static bool __maybe_unused
+xdrgen_encode_nfstime4(struct xdr_stream *xdr, const struct _nfstime4 *value)
+{
+	if (!xdrgen_encode_int64_t(xdr, value->seconds))
+		return false;
+	if (!xdrgen_encode_uint32_t(xdr, value->nseconds))
+		return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_encode_fattr4_time_deleg_access(struct xdr_stream *xdr, const fattr4_time_deleg_access value)
+{
+	return xdrgen_encode_nfstime4(xdr, &value);
+};
+
+static bool __maybe_unused
+xdrgen_encode_fattr4_time_deleg_modify(struct xdr_stream *xdr, const fattr4_time_deleg_modify value)
+{
+	return xdrgen_encode_nfstime4(xdr, &value);
+};
diff --git a/fs/nfsd/delstid_xdr.h b/fs/nfsd/delstid_xdr.h
new file mode 100644
index 000000000000..3ca8d0cc8569
--- /dev/null
+++ b/fs/nfsd/delstid_xdr.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Generated by lkxdrgen, with hand edits. */
+/* XDR specification modification time: Wed Aug 14 13:35:03 2024 */
+
+#ifndef _DELSTID_H
+#define _DELSTID_H
+
+#include <linux/types.h>
+#include <linux/sunrpc/xdr.h>
+#include <linux/sunrpc/svc.h>
+
+typedef struct {
+	u32 len;
+	unsigned char *data;
+} string;
+
+typedef struct {
+	u32 len;
+	u8 *data;
+} opaque;
+
+typedef struct {
+	u32 count;
+	uint32_t *element;
+} bitmap4;
+
+typedef struct _nfstime4 {
+	int64_t seconds;
+	uint32_t nseconds;
+} nfstime4;
+
+typedef bool fattr4_offline;
+
+#define FATTR4_OFFLINE (83)
+
+typedef struct open_arguments4 {
+	bitmap4 oa_share_access;
+	bitmap4 oa_share_deny;
+	bitmap4 oa_share_access_want;
+	bitmap4 oa_open_claim;
+	bitmap4 oa_create_mode;
+} open_arguments4;
+
+enum open_args_share_access4 {
+	OPEN_ARGS_SHARE_ACCESS_READ = 1,
+	OPEN_ARGS_SHARE_ACCESS_WRITE = 2,
+	OPEN_ARGS_SHARE_ACCESS_BOTH = 3,
+};
+
+enum open_args_share_deny4 {
+	OPEN_ARGS_SHARE_DENY_NONE = 0,
+	OPEN_ARGS_SHARE_DENY_READ = 1,
+	OPEN_ARGS_SHARE_DENY_WRITE = 2,
+	OPEN_ARGS_SHARE_DENY_BOTH = 3,
+};
+
+enum open_args_share_access_want4 {
+	OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG = 3,
+	OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG = 4,
+	OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL = 5,
+	OPEN_ARGS_SHARE_ACCESS_WANT_SIGNAL_DELEG_WHEN_RESRC_AVAIL = 17,
+	OPEN_ARGS_SHARE_ACCESS_WANT_PUSH_DELEG_WHEN_UNCONTENDED = 18,
+	OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS = 20,
+	OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION = 21,
+};
+
+enum open_args_open_claim4 {
+	OPEN_ARGS_OPEN_CLAIM_NULL = 0,
+	OPEN_ARGS_OPEN_CLAIM_PREVIOUS = 1,
+	OPEN_ARGS_OPEN_CLAIM_DELEGATE_CUR = 2,
+	OPEN_ARGS_OPEN_CLAIM_DELEGATE_PREV = 3,
+	OPEN_ARGS_OPEN_CLAIM_FH = 4,
+	OPEN_ARGS_OPEN_CLAIM_DELEG_CUR_FH = 5,
+	OPEN_ARGS_OPEN_CLAIM_DELEG_PREV_FH = 6,
+};
+
+enum open_args_createmode4 {
+	OPEN_ARGS_CREATEMODE_UNCHECKED4 = 0,
+	OPEN_ARGS_CREATE_MODE_GUARDED = 1,
+	OPEN_ARGS_CREATEMODE_EXCLUSIVE4 = 2,
+	OPEN_ARGS_CREATE_MODE_EXCLUSIVE4_1 = 3,
+};
+
+typedef open_arguments4 fattr4_open_arguments;
+
+#define FATTR4_OPEN_ARGUMENTS (86)
+
+#define OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION (0x200000)
+
+#define OPEN4_RESULT_NO_OPEN_STATEID (0x00000010)
+
+typedef nfstime4 fattr4_time_deleg_access;
+
+typedef nfstime4 fattr4_time_deleg_modify;
+
+#define FATTR4_TIME_DELEG_ACCESS (84)
+
+#define FATTR4_TIME_DELEG_MODIFY (85)
+
+#define OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS (0x100000)
+
+#endif /* _DELSTID_H */
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 643ca3f8ebb3..b3d2000c8a08 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -55,6 +55,7 @@
 #include "netns.h"
 #include "pnfs.h"
 #include "filecache.h"
+#include "delstid_xdr.h"
 
 #include "trace.h"
 

-- 
2.46.0


