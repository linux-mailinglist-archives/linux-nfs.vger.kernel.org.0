Return-Path: <linux-nfs+bounces-16628-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDC6C75CF7
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 18:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B70C9341565
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 17:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BC52FE59D;
	Thu, 20 Nov 2025 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="mgQAyN0J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA832F60D8;
	Thu, 20 Nov 2025 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763660882; cv=none; b=SrOUTcl4klVrJSykFAumysY8cGudnEvvyx0GTsR4/TvrBu4U+WhmRcKUWv9xMPc+c+biTJc+9mAUGgjBcBJWUORfWUdb4O1WLoQZeeP82Q4SPmNsADmwJK9A65NV1QLuklicvYKRUspIiJ+GNMqFWU5xKZ3vlDT+Omv6Lx8G8Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763660882; c=relaxed/simple;
	bh=7Hii1fepSYb2R2xAPHJoYXk4k8Ps7RQqJ8Ba8lBX0ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZItXDGz81GPmU5qxsDdEsh5u/YUp73Xr5rxt24NAb3fLjLgYaHpTAx1axvA1cOZCr8UzMxzgBHE9fp03vWdECu0+VQR1VOvHDusWrJFcZnaU2sONccHC3YUoRUN4GT1ZXnDA3TkEatZvKMqg0FtNAwNv6caX+FEWZGxqPR/PCFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=mgQAyN0J; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1763660872;
	bh=7Hii1fepSYb2R2xAPHJoYXk4k8Ps7RQqJ8Ba8lBX0ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mgQAyN0JxSO6T6Wp5PMGr0h69W2XRKcuK8ZRopawNJa1H7NO/c34ySjzfjfkW9CZ2
	 yzqWf7WugthCmQ7v/3QeQa/1WXV4b8yKU6mZmsZDyRDLPHwPhTLyaMaokFm9oC9ghj
	 uL5WMJgNzAUTbCw9x/0P4m9fJu/b9poMf5twrXMU679J/v0Q6hikFJGRc0lFk63Rer
	 PAHjWP+xfX9ABUmGPJEG+gYG0Qc5DpDbELZyCamW4oXLxsjBwbIcqinQfHmmIswSGo
	 tLmgI/2KlmksbDBV12YsvWUe60rihOmF9CJV73fwrCNGFRjSK7QUMD0hQ0E2czoUZG
	 2UqVIKQaguBZQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 6A0AC60103;
	Thu, 20 Nov 2025 17:46:25 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id D1CB8203EA5; Thu, 20 Nov 2025 17:45:07 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Anna Schumaker <anna@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Carlos Llamas <cmllamas@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Wei <dw@davidwei.uk>,
	Eric Dumazet <edumazet@google.com>,
	Geliang Tang <geliang@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hannes Reinecke <hare@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Joe Damato <jdamato@fastly.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	kernel-tls-handshake@lists.linux.dev,
	Li Li <dualli@google.com>,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Martijn Coenen <maco@android.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	mptcp@lists.linux.dev,
	NeilBrown <neil@brown.name>,
	netdev@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Samiullah Khawaja <skhawaja@google.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Suren Baghdasaryan <surenb@google.com>,
	Todd Kjos <tkjos@android.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 1/2] tools: ynl-gen: add function prefix argument
Date: Thu, 20 Nov 2025 17:44:26 +0000
Message-ID: <20251120174429.390574-2-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120174429.390574-1-ast@fiberby.net>
References: <20251120174429.390574-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds a new CLI argument for overriding the default
function prefix, as used for naming the doit/dumpit functions
in the generated kernel code.

When not specified the default "$(FAMILY)-nl" is used.

This can also be specified persistently in generated files:
  /* YNL-ARG --function-prefix wg */

In the above example it causes the following changes:
  wireguard_nl_get_device_dumpit() -> wg_get_device_dumpit()
  wireguard_nl_get_device_doit()   -> wg_get_device_doit()

The variable name fn_prefix, was chosen as it relates to op_prefix
which is used to prefix the UAPI commands enum entries.

Link: https://lore.kernel.org/r/aRvWzC8qz3iXDAb3@zx2c4.com/
Suggested-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index aadeb3abcad8..0dd589e502cb 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1205,7 +1205,7 @@ class SubMessage(SpecSubMessage):
 
 
 class Family(SpecFamily):
-    def __init__(self, file_name, exclude_ops):
+    def __init__(self, file_name, exclude_ops, fn_prefix):
         # Added by resolve:
         self.c_name = None
         delattr(self, "c_name")
@@ -1237,6 +1237,8 @@ class Family(SpecFamily):
         else:
             self.uapi_header_name = self.ident_name
 
+        self.fn_prefix = fn_prefix if fn_prefix else f'{self.ident_name}-nl'
+
     def resolve(self):
         self.resolve_up(super())
 
@@ -2911,12 +2913,12 @@ def print_kernel_op_table_fwd(family, cw, terminate):
             continue
 
         if 'do' in op:
-            name = c_lower(f"{family.ident_name}-nl-{op_name}-doit")
+            name = c_lower(f"{family.fn_prefix}-{op_name}-doit")
             cw.write_func_prot('int', name,
                                ['struct sk_buff *skb', 'struct genl_info *info'], suffix=';')
 
         if 'dump' in op:
-            name = c_lower(f"{family.ident_name}-nl-{op_name}-dumpit")
+            name = c_lower(f"{family.fn_prefix}-{op_name}-dumpit")
             cw.write_func_prot('int', name,
                                ['struct sk_buff *skb', 'struct netlink_callback *cb'], suffix=';')
     cw.nl()
@@ -2942,7 +2944,7 @@ def print_kernel_op_table(family, cw):
                                             for x in op['dont-validate']])), )
             for op_mode in ['do', 'dump']:
                 if op_mode in op:
-                    name = c_lower(f"{family.ident_name}-nl-{op_name}-{op_mode}it")
+                    name = c_lower(f"{family.fn_prefix}-{op_name}-{op_mode}it")
                     members.append((op_mode + 'it', name))
             if family.kernel_policy == 'per-op':
                 struct = Struct(family, op['attribute-set'],
@@ -2980,7 +2982,7 @@ def print_kernel_op_table(family, cw):
                         members.append(('validate',
                                         ' | '.join([c_upper('genl-dont-validate-' + x)
                                                     for x in dont_validate])), )
-                name = c_lower(f"{family.ident_name}-nl-{op_name}-{op_mode}it")
+                name = c_lower(f"{family.fn_prefix}-{op_name}-{op_mode}it")
                 if 'pre' in op[op_mode]:
                     members.append((cb_names[op_mode]['pre'], c_lower(op[op_mode]['pre'])))
                 members.append((op_mode + 'it', name))
@@ -3402,6 +3404,7 @@ def main():
                         help='Do not overwrite the output file if the new output is identical to the old')
     parser.add_argument('--exclude-op', action='append', default=[])
     parser.add_argument('-o', dest='out_file', type=str, default=None)
+    parser.add_argument('--function-prefix', dest='fn_prefix', type=str)
     args = parser.parse_args()
 
     if args.header is None:
@@ -3410,7 +3413,7 @@ def main():
     exclude_ops = [re.compile(expr) for expr in args.exclude_op]
 
     try:
-        parsed = Family(args.spec, exclude_ops)
+        parsed = Family(args.spec, exclude_ops, args.fn_prefix)
         if parsed.license != '((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)':
             print('Spec license:', parsed.license)
             print('License must be: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)')
@@ -3430,10 +3433,14 @@ def main():
     cw.p("/* Do not edit directly, auto-generated from: */")
     cw.p(f"/*\t{spec_kernel} */")
     cw.p(f"/* YNL-GEN {args.mode} {'header' if args.header else 'source'} */")
-    if args.exclude_op or args.user_header:
+    if args.exclude_op or args.user_header or args.fn_prefix:
         line = ''
-        line += ' --user-header '.join([''] + args.user_header)
-        line += ' --exclude-op '.join([''] + args.exclude_op)
+        if args.user_header:
+            line += ' --user-header '.join([''] + args.user_header)
+        if args.exclude_op:
+            line += ' --exclude-op '.join([''] + args.exclude_op)
+        if args.fn_prefix:
+            line += f' --function-prefix {args.fn_prefix}'
         cw.p(f'/* YNL-ARG{line} */')
     cw.nl()
 
-- 
2.51.0


