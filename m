Return-Path: <linux-nfs+bounces-16279-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483B7C4FC76
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 22:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C503B2F54
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 21:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E95B35C1A2;
	Tue, 11 Nov 2025 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAhWARpm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5DB35C192
	for <linux-nfs@vger.kernel.org>; Tue, 11 Nov 2025 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894799; cv=none; b=EkWkQyJXCTKCMtlKOC1bOW2rGJ5dlXXwZXm7syrFAoY99JSXEzRqn4QpawDDo/hF+sluX42zHyye+EqKbWimlxYyCZ0EDP8JpJkOGZ790N3j1DFexoTGZrx4BAYS+PDiQzqRDPJYfsJVbCHY71jjQr+zqbjaD/iVQsbDpfJEzS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894799; c=relaxed/simple;
	bh=OQJgp4DEq2joCsVHjoDiIEgHVPSh6NxyzcNZwuRFfQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ewcb6nkd1hHfMzN6gAbdI+w0Lwz7nCGdUrey2BJHDHicML9SVhLLcyrFKmnqychZoBLEB4MuYGe3T51WvdefH8RhreEhBhOoxI6h1LW1CnY3n09TaEm5JkYBR0WjD/M1jJ2TAEIWEQgEK7otdCCplTwNpV5KiIB/4gjtmX2VBxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAhWARpm; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so148388b3a.0
        for <linux-nfs@vger.kernel.org>; Tue, 11 Nov 2025 12:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762894797; x=1763499597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ssdPSHyU3gM2ZHlP9TSRwuYAKtI9+Fzog3TySdjfjWw=;
        b=iAhWARpmiF97QN067SslA3ZByqHEptQVU8bTFBF4V7a+lWlETG3IvzKl+jhxekE1mF
         pDVjtSHRq6VBQ61hS/jHNuHmZ1PFoW2HwpVEWBetg56+jVLbeAo+w70oZJykYDpYbhK6
         XK4UAqLrsTUOBAoJfLSompHtqAuqn+1PS1ZPlSDBF0FF2smEvQ2ZpGVqL0ZNTj4Mm5eE
         gkQv+eYbpqDtpiW96jwcRTJeaEF6vzht6IAgVMJ1VbLngPqUzxJ7B4vfpLbpCHhfbbkt
         CL2qgT9t5rthab/DD1n9gDhmtwdRU48jHCPtf+0KZjT/bq3L3Wfp33LBLKHSeaqSK0Tq
         qxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894797; x=1763499597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssdPSHyU3gM2ZHlP9TSRwuYAKtI9+Fzog3TySdjfjWw=;
        b=dSmu09XNNVOQrsiP84TgjrNzhsiqiQo+OYZ/nsSViZAljrCsYsNCXg/wTgbsO0x9mJ
         NCwH/H8D0fNC+fkE1N3br/cVzkZ5GnDmXtVa2ep5EbgdhDCq/XKhlSkZ/AOXlcOuCO6y
         jLp3nbSSZjg26AMX923Gq7a7YtnL0g39wdef/HauCoRWVxPeKpoKO8SX7gxhfAFU4XcS
         rnvyzO0ost/WLcIz5R/RmtU3hPkJKbuyoU/D2hF2EhA1oR5e3h+FSLRcUcX55vvIiZg3
         meC9rjGznw10AInVFQPKoPbV8N1DoqLl4Vta54U00QhBpaxwVNrFeDM/KRt/djsOJbfn
         9bCA==
X-Forwarded-Encrypted: i=1; AJvYcCVceDf4UuFXnjr/rA7jOKPpDYeAZSZJPxT2QdiSFNUmJsWGZBds7ETOJaXMQiWyQv1KZsVpyxBGPdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI9JuKYb7FO2ARgz2l1DLNA1SMm/EY36mJkEWE7AxZB+BJs5vu
	tvEt5/b7aI/67taJdL9PifvxIsrqY4A+d6olbp+ObyCUMnkiVGXWH9UR
X-Gm-Gg: ASbGnctYRzHYaWG5FFc6v69lqxo42dR6VhqMJvemh5NgAvsk4IcvkDqrkxLcuW/i6ro
	jDXM0W6RwrdWVqXgyedYlxhnMUniiOJSvyO0l7Zzo9Td1198qKAuIOcclnM3tvM3MVN2PKXn8qt
	7Z4n80cFTPXqEgLJWMpQXM159sJiWbSMHfdkTtc+Nevv2AqljZZs9uBtx/Z3Xp67boSZPRN0INQ
	QTcApELpJjPvybxwEVWVjgmUqz9WKHB3WPNz91H2ykKbS30TJ2SZvv1gFMoUHrTkurNkJ9+YsIw
	ZnNdJ20M6TPGPrbLCNvQTAgHy4wvaEMNAyj0BzwR/+oG5yQB/MW07YgIRRQbvtat7ku1WXgDF2r
	aZrKospOS82I6cLsb2uaYPEjx6CbhjlV/ls6b95WKh5O4EfDTijTAq9LBNdeB3abheqd6hHzVD8
	PNwebPYYGO6Q==
X-Google-Smtp-Source: AGHT+IFCW1p6ho9Y11SAcC7SESQcgTHINsTJhTvR5vLV8FdaDa43LTw4C+qNG6PEY11aI2k6EiSRRQ==
X-Received: by 2002:a05:6a00:2e0d:b0:781:1550:1ac7 with SMTP id d2e1a72fcca58-7b7a25aa49fmr429506b3a.6.1762894796759;
        Tue, 11 Nov 2025 12:59:56 -0800 (PST)
Received: from snowman ([2401:4900:615d:9a7b:70c6:577c:2e8f:2a51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccb5a517sm15949308b3a.57.2025.11.11.12.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 12:59:56 -0800 (PST)
From: Khushal Chitturi <kc9282016@gmail.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khushal Chitturi <kc9282016@gmail.com>
Subject: [PATCH] xdrgen: Handle typedef void types
Date: Wed, 12 Nov 2025 02:27:38 +0530
Message-ID: <20251111205738.4574-1-kc9282016@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch Handle typedef void in XDR Generator. Previously, such
declarations triggered a NotImplementedError in typedef.py.

This change adds handling for _XdrVoid AST nodes within the
typedef generator. When an XDR includes a typedef void,
the generator now recognizes _XdrVoid nodes and emits the
respective C typedefs and associated functions. New Jinja2
templates were introduced for encoder, decoder, declaration,
definition, and maxsize generation. The XDR grammar was
updated so that void typedefs can be parsed properly

Tested by running xdrgen on tests/test.x containing a typedef void
declaration. The tool now runs and produces the encoder, decoder,
and typedef outputs across source, definitions, and declarations.

Signed-off-by: Khushal Chitturi <kc9282016@gmail.com>
---
 tools/net/sunrpc/xdrgen/generators/typedef.py        | 12 ++++++++----
 tools/net/sunrpc/xdrgen/grammars/xdr.lark            |  2 +-
 .../xdrgen/templates/C/typedef/declaration/void.j2   |  2 ++
 .../xdrgen/templates/C/typedef/decoder/void.j2       |  6 ++++++
 .../xdrgen/templates/C/typedef/definition/void.j2    |  2 ++
 .../xdrgen/templates/C/typedef/encoder/void.j2       |  6 ++++++
 .../xdrgen/templates/C/typedef/maxsize/void.j2       |  2 ++
 7 files changed, 27 insertions(+), 5 deletions(-)
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/void.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/void.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/void.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/void.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/void.j2

diff --git a/tools/net/sunrpc/xdrgen/generators/typedef.py b/tools/net/sunrpc/xdrgen/generators/typedef.py
index fab72e9d6915..f49ae26c4830 100644
--- a/tools/net/sunrpc/xdrgen/generators/typedef.py
+++ b/tools/net/sunrpc/xdrgen/generators/typedef.py
@@ -58,7 +58,8 @@ def emit_typedef_declaration(environment: Environment, node: _XdrDeclaration) ->
     elif isinstance(node, _XdrOptionalData):
         raise NotImplementedError("<optional_data> typedef not yet implemented")
     elif isinstance(node, _XdrVoid):
-        raise NotImplementedError("<void> typedef not yet implemented")
+        template = get_jinja2_template(environment, "declaration", node.template)
+        print(template.render(name=node.name))
     else:
         raise NotImplementedError("typedef: type not recognized")
 
@@ -104,7 +105,8 @@ def emit_type_definition(environment: Environment, node: _XdrDeclaration) -> Non
     elif isinstance(node, _XdrOptionalData):
         raise NotImplementedError("<optional_data> typedef not yet implemented")
     elif isinstance(node, _XdrVoid):
-        raise NotImplementedError("<void> typedef not yet implemented")
+        template = get_jinja2_template(environment, "definition", node.template)
+        print(template.render(name=node.name))
     else:
         raise NotImplementedError("typedef: type not recognized")
 
@@ -165,7 +167,8 @@ def emit_typedef_decoder(environment: Environment, node: _XdrDeclaration) -> Non
     elif isinstance(node, _XdrOptionalData):
         raise NotImplementedError("<optional_data> typedef not yet implemented")
     elif isinstance(node, _XdrVoid):
-        raise NotImplementedError("<void> typedef not yet implemented")
+        template = get_jinja2_template(environment, "decoder", node.template)
+        print(template.render(name=node.name))
     else:
         raise NotImplementedError("typedef: type not recognized")
 
@@ -225,7 +228,8 @@ def emit_typedef_encoder(environment: Environment, node: _XdrDeclaration) -> Non
     elif isinstance(node, _XdrOptionalData):
         raise NotImplementedError("<optional_data> typedef not yet implemented")
     elif isinstance(node, _XdrVoid):
-        raise NotImplementedError("<void> typedef not yet implemented")
+        template = get_jinja2_template(environment, "encoder", node.template)
+        print(template.render(name=node.name))
     else:
         raise NotImplementedError("typedef: type not recognized")
 
diff --git a/tools/net/sunrpc/xdrgen/grammars/xdr.lark b/tools/net/sunrpc/xdrgen/grammars/xdr.lark
index 7c2c1b8c86d1..d8c5f7130d83 100644
--- a/tools/net/sunrpc/xdrgen/grammars/xdr.lark
+++ b/tools/net/sunrpc/xdrgen/grammars/xdr.lark
@@ -8,7 +8,7 @@ declaration             : "opaque" identifier "[" value "]"            -> fixed_
                         | type_specifier identifier "<" [ value ] ">"  -> variable_length_array
                         | type_specifier "*" identifier                -> optional_data
                         | type_specifier identifier                    -> basic
-                        | "void"                                       -> void
+                        | "void" [identifier] -> void
 
 value                   : decimal_constant
                         | hexadecimal_constant
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/void.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/void.j2
new file mode 100644
index 000000000000..22c5226ee526
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/void.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+typedef void {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/void.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/void.j2
new file mode 100644
index 000000000000..ed9e2455b36f
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/void.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+static inline bool
+xdrgen_decode_{{ name }}(struct xdr_stream *xdr, void *ptr)
+{
+    return true;
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/void.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/void.j2
new file mode 100644
index 000000000000..22c5226ee526
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/void.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+typedef void {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/void.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/void.j2
new file mode 100644
index 000000000000..47d48af81546
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/void.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+static inline bool
+xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const void *ptr)
+{
+    return true;
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/void.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/void.j2
new file mode 100644
index 000000000000..129374200ad0
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/void.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+#define {{ macro }} 0
-- 
2.51.2


