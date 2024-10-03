Return-Path: <linux-nfs+bounces-6809-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C904D98F203
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 17:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4DC2824C0
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 15:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6922619C54D;
	Thu,  3 Oct 2024 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4qIJiNS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4480916F0F0
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967717; cv=none; b=DflXmgps8EaetSJ0TQoX7adFShrkQGwchQ3t/Ypq3fqhRLvjwmrl3UPBhvDepDhbk7KcJXsWuvyJ7O4YKSl5wUxvzgrpan1AicvkSX/v3/L0dKMgVPfENZ0Ov8iID4UjbdT5oNbdncSTL1j3S5byzmRc3riEtOXGNhI8iMMhZZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967717; c=relaxed/simple;
	bh=qFWlwNLksEyWsZmfuu99XEA/mebyqmYuWYsozGi5B5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/T1X9CcoTVujbHoMI5CAnuASuQsLYp9du40Jmbo/pQLGCdR0sF3ByGXo84ZPZQDSjUJisSbB8TGBPN063drgUZCGNxz+Hn456Z1Yh97Pg1bDTemn4f4+XVmPWzjWTbz0BS3LSqZOKdlXTussVYcd0zqjcAtGW+/CgCC9P6pt2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4qIJiNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151EEC4CEC5;
	Thu,  3 Oct 2024 15:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727967716;
	bh=qFWlwNLksEyWsZmfuu99XEA/mebyqmYuWYsozGi5B5Y=;
	h=From:To:Cc:Subject:Date:From;
	b=Z4qIJiNSi0pyd8IcdrfbyviNr4EhGNmt0VndZMqDiznvgaxe4lOa0kDpSnp1SW/5R
	 gM8cRRbSJ2kVF80CazbzIEFw34vGfbyojViwM9ypRdtgtiHyHMQkxLdWxEvPe4yBlv
	 pF87Gt2tANwOrRSrBRKG4C8P4P6x66LhUYIyw9WyJWLvCXAUrFB72sIgK/ePLo9lfr
	 FYr4/xfru7nXOm6VguWgXuWWgx5xVePzs9d2szdnjjCMkqp3n+ADJGlYKe6LsXSqr2
	 byVpJ7mmlu02H07+3lfkyFxW55a3XG/NKRbx0RkBfZz7Zrj74C9KpgIrb3KwSDWEFv
	 uL2RFEEZmgMGw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 00/16] xdrgen: Emit maxsize macros
Date: Thu,  3 Oct 2024 11:01:42 -0400
Message-ID: <20241003150151.81951-1-cel@kernel.org>
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


