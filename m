Return-Path: <linux-nfs+bounces-16056-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E33EC3660C
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 16:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E841A430CD
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 15:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13CC3328E1;
	Wed,  5 Nov 2025 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZ+0eFjW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8D531DDBB
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356371; cv=none; b=sBRlmMuRLgujCHD3mpCfa91n/KNkFOrzHmFrp0JiJVU5rqOvWLW0YbjgMs3x1V6BJh+OgwQlMp3kVf4K6EBZDIEyDkG44VlMguWG4eVaEzAFXgSXwJqd91c5TXZJnFTPsWZkWtgdqfRGoSx79Q6J22tEzlPN/6dDIJ2lu1ys0g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356371; c=relaxed/simple;
	bh=z4QJJjhQFnFbNDVftnv374cpbLBdq7Z5ORR1ZcpzJkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2y0hD7rxoHmqzoRcicHf/0U5BCsO7NLcpUqR/3X4Kw8Wwr0gZLqndGO/myELiLDUgAPPpKacnl316P8WiGELJj5az9fDEhOZCzJejdE75fwhVlhWa4Jhwur8256f7Rg4GJ4kETDtPlGWm2X+oe2wpgjNTSZ4La8bQAqUDYhY7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZ+0eFjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A41C4CEF8;
	Wed,  5 Nov 2025 15:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762356371;
	bh=z4QJJjhQFnFbNDVftnv374cpbLBdq7Z5ORR1ZcpzJkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sZ+0eFjWGgd4RYULV9RxHmz3h7JVOMW/Jz4kE6MMo621VTx+5NuJnM9T4XUQ2tUXk
	 omRDmUAvze6SpEld7Stm1Xdr9bMeUEcqxZKVqIpF4mCGcwrFG+esvK6xMamlBDn6YV
	 kF1MYgOd/OEFrgd0SvuXCIlhW+ihvsNsSW2Zt6n5ofWR8BhdIpptwo0aEyzAriez+W
	 V5J9dthorHYziA9A35M1rz/6GSA7D2oNGNs5bC33VpnEYyddkiWBrDNbCIz+WAv69o
	 GJPCYPz5UgaKjxnc4oUHX5jmWd3hoyeTYrPJvKnDrt1T5fKi8FHTqYpx7IY0+1V9Js
	 4KcFY+qXWVipA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 2/2] xdrgen: Don't generate unnecessary semicolon
Date: Wed,  5 Nov 2025 10:26:07 -0500
Message-ID: <20251105152607.63773-2-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105152607.63773-1-cel@kernel.org>
References: <20251105152607.63773-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The Jinja2 templates add a semicolon at the end of every function.
The C language does not require this punctuation.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/close.j2    | 2 +-
 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/close.j2    | 2 +-
 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/close.j2     | 2 +-
 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/close.j2     | 2 +-
 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/basic.j2    | 2 +-
 .../xdrgen/templates/C/typedef/decoder/fixed_length_array.j2    | 2 +-
 .../xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2   | 2 +-
 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/string.j2   | 2 +-
 .../xdrgen/templates/C/typedef/decoder/variable_length_array.j2 | 2 +-
 .../templates/C/typedef/decoder/variable_length_opaque.j2       | 2 +-
 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/basic.j2    | 2 +-
 .../xdrgen/templates/C/typedef/encoder/fixed_length_array.j2    | 2 +-
 .../xdrgen/templates/C/typedef/encoder/fixed_length_opaque.j2   | 2 +-
 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/string.j2   | 2 +-
 .../xdrgen/templates/C/typedef/encoder/variable_length_array.j2 | 2 +-
 .../templates/C/typedef/encoder/variable_length_opaque.j2       | 2 +-
 tools/net/sunrpc/xdrgen/templates/C/union/decoder/close.j2      | 2 +-
 tools/net/sunrpc/xdrgen/templates/C/union/encoder/close.j2      | 2 +-
 18 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/close.j2
index 5bf010665f84..3dbd724d7f17 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/close.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/close.j2
@@ -1,3 +1,3 @@
 {# SPDX-License-Identifier: GPL-2.0 #}
 	return true;
-};
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/close.j2
index 5bf010665f84..3dbd724d7f17 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/close.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/close.j2
@@ -1,3 +1,3 @@
 {# SPDX-License-Identifier: GPL-2.0 #}
 	return true;
-};
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/close.j2
index 5bf010665f84..3dbd724d7f17 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/close.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/close.j2
@@ -1,3 +1,3 @@
 {# SPDX-License-Identifier: GPL-2.0 #}
 	return true;
-};
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/close.j2
index 5bf010665f84..3dbd724d7f17 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/close.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/encoder/close.j2
@@ -1,3 +1,3 @@
 {# SPDX-License-Identifier: GPL-2.0 #}
 	return true;
-};
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/basic.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/basic.j2
index da4709403dc9..b215e157dfa7 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/basic.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/basic.j2
@@ -14,4 +14,4 @@ xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ name }} *ptr)
 	/* (basic) */
 {% endif %}
 	return xdrgen_decode_{{ type }}(xdr, ptr);
-};
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_array.j2
index d7c80e472fe3..c8953719e626 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_array.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_array.j2
@@ -22,4 +22,4 @@ xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ classifier }}{{ name }} *ptr
 			return false;
 	}
 	return true;
-};
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2
index bdc7bd24ffb1..c854fc8c74e3 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2
@@ -14,4 +14,4 @@ xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ classifier }}{{ name }} *ptr
 	/* (fixed-length opaque) */
 {% endif %}
 	return xdr_stream_decode_opaque_fixed(xdr, ptr, {{ size }}) == 0;
-};
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/string.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/string.j2
index 56c5a17d6a70..bcbc1758aae9 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/string.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/string.j2
@@ -14,4 +14,4 @@ xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ classifier }}{{ name }} *ptr
 	/* (variable-length string) */
 {% endif %}
 	return xdrgen_decode_string(xdr, ptr, {{ maxsize }});
-};
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_array.j2
index e74ffdd98463..a59cc1f38eed 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_array.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_array.j2
@@ -23,4 +23,4 @@ xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ classifier }}{{ name }} *ptr
 		if (!xdrgen_decode_{{ type }}(xdr, &ptr->element[i]))
 			return false;
 	return true;
-};
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_opaque.j2
index f28f8b228ad5..eb05f53e1041 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_opaque.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_opaque.j2
@@ -14,4 +14,4 @@ xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ classifier }}{{ name }} *ptr
 	/* (variable-length opaque) */
 {% endif %}
 	return xdrgen_decode_opaque(xdr, ptr, {{ maxsize }});
-};
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/basic.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/basic.j2
index 35effe67e4ef..0d21dd0b723a 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/basic.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/basic.j2
@@ -18,4 +18,4 @@ xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ classifier }}{{ name }
 	/* (basic) */
 {% endif %}
 	return xdrgen_encode_{{ type }}(xdr, value);
-};
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_array.j2
index 95202ad5ad2d..ec8cd6509514 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_array.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_array.j2
@@ -22,4 +22,4 @@ xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ classifier }}{{ name }
 			return false;
 	}
 	return true;
-};
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_opaque.j2
index 9c66a11b9912..b53fa87e1858 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_opaque.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_opaque.j2
@@ -14,4 +14,4 @@ xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ classifier }}{{ name }
 	/* (fixed-length opaque) */
 {% endif %}
 	return xdr_stream_encode_opaque_fixed(xdr, value, {{ size }}) >= 0;
-};
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/string.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/string.j2
index 3d490ff180d0..28b81f1d0bd6 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/string.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/string.j2
@@ -14,4 +14,4 @@ xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ classifier }}{{ name }
 	/* (variable-length string) */
 {% endif %}
 	return xdr_stream_encode_opaque(xdr, value.data, value.len) >= 0;
-};
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_array.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_array.j2
index 2d2384f64918..ff093c281d51 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_array.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_array.j2
@@ -27,4 +27,4 @@ xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ classifier }}{{ name }
 {% endif %}
 			return false;
 	return true;
-};
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_opaque.j2
index 8508f13c95b9..2e89592fa702 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_opaque.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_opaque.j2
@@ -14,4 +14,4 @@ xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const {{ classifier }}{{ name }
 	/* (variable-length opaque) */
 {% endif %}
 	return xdr_stream_encode_opaque(xdr, value.data, value.len) >= 0;
-};
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/decoder/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/close.j2
index fdc2dfd1843b..39d8d6c5094d 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/union/decoder/close.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/decoder/close.j2
@@ -1,4 +1,4 @@
 {# SPDX-License-Identifier: GPL-2.0 #}
 	}
 	return true;
-};
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/encoder/close.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/close.j2
index fdc2dfd1843b..39d8d6c5094d 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/union/encoder/close.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/close.j2
@@ -1,4 +1,4 @@
 {# SPDX-License-Identifier: GPL-2.0 #}
 	}
 	return true;
-};
+}
-- 
2.51.0


