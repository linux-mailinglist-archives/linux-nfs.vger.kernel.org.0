Return-Path: <linux-nfs+bounces-6701-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64EE9898AA
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 02:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AB8AB226C5
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 00:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4754D2904;
	Mon, 30 Sep 2024 00:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFTZszSx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213D3257D
	for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727657424; cv=none; b=XT1Vc2E97h/1aL61spPTUHkFFbAxIUfCTFT+Wc/8qh7zW5U+z7EqgdMO6US1ZlKP5u/e61qv/0z7Pul7ET0dl/gWNdegPyBkTdspHzt8J9nQcQMJdezuvm5v4Mgey+mkEluU0GqmCIcvo1juxZjziwDxQHNPNqvzyfVjRYdxQ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727657424; c=relaxed/simple;
	bh=RjOH5PM8GrPsIht3iyKGlHURGNc10EqhW17V++2wTjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RV5mMpNbXyVBELBHwXSLKRSTZL1zbpPIbge5hOCryfAHvS5xGGbpLgJIY7pIJSN3YBjhb7Gnfm2tJTf7y4Ld0VoLlvJ6iQYgu2fSzRl5AY95qgtiw25bg23h/pJ5xOutpx+NkscGjCMtbZzN6rP9LKuj3GCV3SVMsC/duc8Dwgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFTZszSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C5AC4CEC5;
	Mon, 30 Sep 2024 00:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727657423;
	bh=RjOH5PM8GrPsIht3iyKGlHURGNc10EqhW17V++2wTjI=;
	h=From:To:Cc:Subject:Date:From;
	b=CFTZszSxXpdCNjQJXK3SqGQVUDVk+6LsDBJTvsZHIfyGRDbSpP8aOvIoPJKieixj7
	 RNVXcbk3dzfVMh7N4OCIdxVo07d4e4TWlT6mv4Esowu2tfOZJUx8ie9C8tRVdCponP
	 FBk1qr1gTqc9JiKnPHs/p+ABV6uax+uGIeAXdYMaD6TFZ8KgUcP7nFxtL2l3U5frYI
	 f4b0raPVi0BETtkm48H5LJXQjsiPTa/sl57GpjiWU7Q1b/mXeZboeaMgVnULtsnE1J
	 2+6TBbvdzI1lbJY+3wbe1b9lfI4aKYtvtzy4PeqPf5q7KzcCbBisPLO5A69KHqxv3r
	 JMzEUVXVWl8wA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 0/6] Continued work on xdrgen
Date: Sun, 29 Sep 2024 20:50:09 -0400
Message-ID: <20240930005016.13374-1-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

This series (intended for v6.13) contains some clean-ups and new
features for the xdrgen tool.

The "Exit status should be zero ..." patch is needed so that "make"
co-operates properly with xdrgen. I've prototyped some Makefile
stanzas that can generate encoder and decoder functions to ensure
this is working correctly (to appear in a later series).

"enum" types are now generated as C typedefs, without the "enum"
classifier. This is to enable the same type name to be used to
represent either an enum (CPU-endian) or a __be32 (network-endian).

So, instead of generating, say, "enum nfsstat3 {};" xdrgen now
generates "nfsstat3" which can be either an enum or a __be32,
depending on a new pragma directive. The goal is to handle the
special case where the upper layer prefers to use __be32
discriminant values for XDR union types.

Comments are welcome.


Chuck Lever (6):
  xdrgen: Exit status should be zero on success
  xdrgen: Clean up type_specifier
  xdrgen: Rename "variable-length strings"
  xdrgen: Rename enum's declaration Jinja2 template
  xdrgen: Rename "enum yada" types as just "yada"
  xdrgen: Implement big-endian enums

 include/linux/sunrpc/xdr.h                    | 21 ++++++++++++
 tools/net/sunrpc/xdrgen/README                | 17 ++++++++++
 tools/net/sunrpc/xdrgen/generators/enum.py    | 19 ++++++++---
 tools/net/sunrpc/xdrgen/generators/pointer.py |  8 ++---
 tools/net/sunrpc/xdrgen/generators/struct.py  |  8 ++---
 tools/net/sunrpc/xdrgen/generators/typedef.py | 10 +++---
 tools/net/sunrpc/xdrgen/generators/union.py   | 34 ++++++++++++++-----
 tools/net/sunrpc/xdrgen/grammars/xdr.lark     |  6 ++--
 .../templates/C/enum/declaration/close.j2     |  4 ---
 .../templates/C/enum/declaration/enum.j2      |  4 +++
 .../xdrgen/templates/C/enum/decoder/enum.j2   |  2 +-
 .../{encoder/enum.j2 => decoder/enum_be.j2}   |  6 ++--
 .../templates/C/enum/definition/close.j2      |  1 +
 .../enum/definition/{close.j2 => close_be.j2} |  1 +
 .../xdrgen/templates/C/enum/encoder/enum.j2   |  2 +-
 .../C/enum/encoder/{enum.j2 => enum_be.j2}    |  6 ++--
 .../{variable_length_string.j2 => string.j2}  |  0
 .../{variable_length_string.j2 => string.j2}  |  0
 .../{variable_length_string.j2 => string.j2}  |  0
 .../{variable_length_string.j2 => string.j2}  |  0
 .../{variable_length_string.j2 => string.j2}  |  0
 .../{variable_length_string.j2 => string.j2}  |  0
 .../{variable_length_string.j2 => string.j2}  |  0
 .../{variable_length_string.j2 => string.j2}  |  0
 .../{variable_length_string.j2 => string.j2}  |  0
 .../{variable_length_string.j2 => string.j2}  |  0
 .../templates/C/union/decoder/case_spec_be.j2 |  2 ++
 .../{variable_length_string.j2 => string.j2}  |  0
 .../templates/C/union/encoder/case_spec_be.j2 |  2 ++
 tools/net/sunrpc/xdrgen/xdr_ast.py            | 21 ++++++------
 tools/net/sunrpc/xdrgen/xdrgen                |  4 ++-
 31 files changed, 125 insertions(+), 53 deletions(-)
 delete mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/declaration/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2
 copy tools/net/sunrpc/xdrgen/templates/C/enum/{encoder/enum.j2 => decoder/enum_be.j2} (51%)
 copy tools/net/sunrpc/xdrgen/templates/C/enum/definition/{close.j2 => close_be.j2} (60%)
 copy tools/net/sunrpc/xdrgen/templates/C/enum/encoder/{enum.j2 => enum_be.j2} (50%)
 rename tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/pointer/definition/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/struct/decoder/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/struct/definition/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/struct/encoder/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/typedef/definition/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/{variable_length_string.j2 => string.j2} (100%)
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/case_spec_be.j2
 rename tools/net/sunrpc/xdrgen/templates/C/union/decoder/{variable_length_string.j2 => string.j2} (100%)
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/case_spec_be.j2

-- 
2.46.2


