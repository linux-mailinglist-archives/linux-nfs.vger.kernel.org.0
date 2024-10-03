Return-Path: <linux-nfs+bounces-6825-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EE998F694
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 20:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2756F1C22CD9
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 18:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0D01AB6DD;
	Thu,  3 Oct 2024 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4HPBAN0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539851AB6C3
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981700; cv=none; b=MWGv43WMg0Ro7Z9FVSEKNKcvOhxh+5eqEvuTpAQ14a2gS9HMQkwsvrJeO6yY9jl5FR2kdoK1By04+y0QnuM6b5Fy7UyFmvTED1nR+j+0ps4TtnIMaTJiTrAfKyE83gaoVNG5AtLlLYM70gSXN72stIAcR0eVkSqU0t2ICuEtx0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981700; c=relaxed/simple;
	bh=0ZaLW82Z4hhv4olbY3SzXyBGU124DODtGWXPKKfQjb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LCNJbs+98w7DP6PdSbnLs9PYy6jjPBUV59VhAwG0+WNZ+5k3+pb5RDdNj6ct5nfOc6q38rTcFiF+yVcQN73X0uA5kW0W2tiAfuqrJMRtpXPUdX9efFw3763na3hCdoySpfNb7bwyA/C+l/kFGSG0dhrgAmbk1hv4VOC6xoObTYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4HPBAN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D157C4CEC5;
	Thu,  3 Oct 2024 18:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727981699;
	bh=0ZaLW82Z4hhv4olbY3SzXyBGU124DODtGWXPKKfQjb4=;
	h=From:To:Cc:Subject:Date:From;
	b=a4HPBAN0meY4nKG61MxXs8xP2VvSBneywTw5yHLW2eydnti5TziNtK8MKBal/q8V+
	 wPYxQ+Eh/EG1xeDGCZIDexz5KyrGOGY3AWzcE2INUyqKXRkCO+V5pgWMncq5Rjz6Cc
	 CUoDMf2pu4tu8BBBaGLac9se/ldgs9bqFZ4CxgsCkLcRJtwI2qfRb2nuxIOYMZFiS+
	 S6MqDDm8NKCBZdRzqvCXF5N2XW6/aj4L15nuIYXOoRzCDW6UCCEXv6ajKuF/qOGNk/
	 usaMFgZvRA/dhJkfxRHvXseN/qsLZXojkMkNfyWRuNpTQNtNl+xtzDrv39w7cpLklJ
	 fW2BGZm1ow0Qw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 00/16] xdrgen: Emit maxsize macros
Date: Thu,  3 Oct 2024 14:54:30 -0400
Message-ID: <20241003185446.82984-1-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

This series implements the generation of "maxsize" values for each
XDR data type defined in a specification. These are emitted as C
pre-processor macros, following the lead of existing XDR functions
in the kernel. The macros are added to the header file containing
C type definitions.

This facility takes xdrgen a step closer to the generation of all
XDR code needed for each RPC protocol implementation in the kernel.

Changes since v1:
- Resend including all 16 patches (d'oh)

Chuck Lever (16):
  xdrgen: Refactor transformer arms
  xdrgen: Track constant values
  xdrgen: Keep track of on-the-wire data type widths
  xdrgen: XDR widths for enum types
  xdrgen: XDR width for fixed-length opaque
  xdrgen: XDR width for variable-length opaque
  xdrgen: XDR width for a string
  xdrgen: XDR width for fixed-length array
  xdrgen: XDR width for variable-length array
  xdrgen: XDR width for optional_data type
  xdrgen: XDR width for typedef
  xdrgen: XDR width for struct types
  xdrgen: XDR width for pointer types
  xdrgen: XDR width for union types
  xdrgen: Add generator code for XDR width macros
  xdrgen: emit maxsize macros

 include/linux/sunrpc/xdrgen/_defs.h           |   9 +
 .../net/sunrpc/xdrgen/generators/__init__.py  |   4 +
 tools/net/sunrpc/xdrgen/generators/enum.py    |  13 +-
 tools/net/sunrpc/xdrgen/generators/pointer.py |  18 +-
 tools/net/sunrpc/xdrgen/generators/struct.py  |  18 +-
 tools/net/sunrpc/xdrgen/generators/typedef.py |  18 +-
 tools/net/sunrpc/xdrgen/generators/union.py   |  20 +-
 .../net/sunrpc/xdrgen/subcmds/definitions.py  |  24 +-
 tools/net/sunrpc/xdrgen/subcmds/source.py     |   3 +-
 .../xdrgen/templates/C/enum/maxsize/enum.j2   |   2 +
 .../templates/C/pointer/maxsize/pointer.j2    |   3 +
 .../templates/C/struct/maxsize/struct.j2      |   3 +
 .../templates/C/typedef/maxsize/basic.j2      |   3 +
 .../C/typedef/maxsize/fixed_length_opaque.j2  |   2 +
 .../templates/C/typedef/maxsize/string.j2     |   2 +
 .../typedef/maxsize/variable_length_array.j2  |   2 +
 .../typedef/maxsize/variable_length_opaque.j2 |   2 +
 .../xdrgen/templates/C/union/maxsize/union.j2 |   3 +
 tools/net/sunrpc/xdrgen/xdr_ast.py            | 292 ++++++++++++++++--
 19 files changed, 406 insertions(+), 35 deletions(-)
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/maxsize/enum.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/maxsize/pointer.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/maxsize/struct.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/maxsize/union.j2

-- 
2.46.2


