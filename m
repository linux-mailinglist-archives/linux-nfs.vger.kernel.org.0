Return-Path: <linux-nfs+bounces-17305-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 152CECDECA5
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Dec 2025 16:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01E4C3003061
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Dec 2025 15:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A553F1DC997;
	Fri, 26 Dec 2025 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8cEbbQN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8051453E0B
	for <linux-nfs@vger.kernel.org>; Fri, 26 Dec 2025 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766762378; cv=none; b=fsJzpYOqYtgwDnXL9Q1QsxNq6ZRDK5pVrYK6u6A3cY6jYg+iYJJ06BPK+28RuwjV7+X2WUTf1kts3erq6Y2lh1rS3v5daijYxqTswqZ8lzeSUrhNtJ65laCtRopNKe3v76R28JZD1J3LyEYou63FwLyCvz16oDd2kD2n5BjtghU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766762378; c=relaxed/simple;
	bh=rjvynIU/pUsNTEgCIA1LJKfu7RKZBCy888QZ455gVMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=txGcyqyJM3TvM+Uh1OYEFX49t8yg977O9LHxpSTSe6loDSag8n3ezMi/9FsOwweled5XiEYo4+ilL/Lca4qk2Ad9KgXF1//70M04cOelRKdBx94Mw023dB29mUU2xFIu6Rb7YO9QA9ST9H0xbsz4ZfCD0x6PV7WF5t8XmK7N6rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8cEbbQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D4EC4CEF7;
	Fri, 26 Dec 2025 15:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766762377;
	bh=rjvynIU/pUsNTEgCIA1LJKfu7RKZBCy888QZ455gVMY=;
	h=From:To:Cc:Subject:Date:From;
	b=h8cEbbQNVP1y0FnCzPMGwNU+Bzy8DE78bIiyT3nHWmSrBVetUf8LbJ330jR+cSxw1
	 IKm8zoZ9ogANyzS3tqKjeQRI3lhmejO2aZZrL4ONuJHB5LMpF1K10Hxf4c4qzfbzi8
	 LQqkGnZPfGUCwzDKVl/GI7zBEa3FV81GD9ZDbf/bO2e3RjDhsMZg7GnNAJc8+D9J6w
	 eN1soJ3H3xq5IGy4L9/wCr2nlj+gxh1PDwHVyKvz0raIgmMIj/4pma5TRqQwLH78hb
	 Us9lAfR7nSpGCv1h/jtPM9xUILv3bIAzMlyOuLH6ZzHxn11NSN028fqI6KXyC0M/hL
	 Gmk9P0kB714dw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 0/3] Three xdrgen short subjects
Date: Fri, 26 Dec 2025 10:19:32 -0500
Message-ID: <20251226151935.441045-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

While working on converting lockd to uses xdrgen, I noticed these
issues in the xdrgen tool.

Chuck Lever (3):
  xdrgen: Extend error reporting to AST transformation phase
  xdrgen: Emit a max_arg_sz macro
  xdrgen: Add enum value validation to generated decoders

 fs/nfsd/nfs4xdr_gen.c                         | 105 ++++++++++++++----
 fs/nfsd/nfs4xdr_gen.h                         |   2 +-
 include/linux/sunrpc/xdrgen/nfs4_1.h          |   8 +-
 tools/net/sunrpc/xdrgen/generators/enum.py    |   9 +-
 tools/net/sunrpc/xdrgen/generators/program.py |  35 +++++-
 .../net/sunrpc/xdrgen/subcmds/declarations.py |   8 +-
 .../net/sunrpc/xdrgen/subcmds/definitions.py  |  10 +-
 tools/net/sunrpc/xdrgen/subcmds/lint.py       |   8 +-
 tools/net/sunrpc/xdrgen/subcmds/source.py     |  11 +-
 .../xdrgen/templates/C/enum/decoder/enum.j2   |  11 ++
 .../templates/C/enum/decoder/enum_be.j2       |  20 ++++
 .../templates/C/program/maxsize/max_args.j2   |   3 +
 tools/net/sunrpc/xdrgen/xdr_ast.py            |   6 +-
 tools/net/sunrpc/xdrgen/xdr_parse.py          |  54 ++++++++-
 tools/net/sunrpc/xdrgen/xdrgen                |   6 +
 15 files changed, 262 insertions(+), 34 deletions(-)
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/maxsize/max_args.j2

-- 
2.52.0


