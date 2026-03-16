Return-Path: <linux-nfs+bounces-20199-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEc8KEEhuGmdZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20199-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:26:57 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 283C529C4C2
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B16893250A2C
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798B93A1A56;
	Mon, 16 Mar 2026 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPz3C9sr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5604C3A1A3D
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674213; cv=none; b=Va3gmJTCFdNEza4Yy4tU1CW3SxE8GtFH/TCj0yqDwstWsd2YYqq0nov3D76BzOfcbN0dhUIMlF8ovMCLjDruRKWuiNA0FcfO8HlsFMb9EvD174z8KVQzrRb9aFF1UU5JWcLm7TwwlOEpaUnqBYY/SOngzQYfqOuB7sFLwfQat+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674213; c=relaxed/simple;
	bh=By5E/s37Nz8ULOOA+zLD2q3k5uhJzkO0sRbWYKEr2ME=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Syfl8oNwZ0et1sFwP4UjHGC3q0A+cmEYFQkT/e2HMb8vCJvRYYaKEnRWf7kzUaFC1Kr0kmoXzrwL5E4VeNgZFigNnxckdEeAj1/jRVQ/OV4T2IdveXR1iuANmADueWWUDG6+1caX5KsMkz0PRUv29mjMLnhCjjhl79/hQg/t4Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPz3C9sr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2370DC19425;
	Mon, 16 Mar 2026 15:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674213;
	bh=By5E/s37Nz8ULOOA+zLD2q3k5uhJzkO0sRbWYKEr2ME=;
	h=From:Subject:Date:To:Cc:From;
	b=pPz3C9srDIItCkSL3TVGQUMkRZ6+1ZGKiLbDOG6qncTUHNHB3YMdXls4IB2pooNUq
	 f57QC4b2OKHkpouvbk5wQ1AH82R2IkMZ+T9Rlx1jq0MvgJ7a23+dErqdSJH8SOiBZG
	 iNOIzLxR5yiehbAQTv0q5NeqJIhdEMrOG8qw8rdEfWbKosX40/+erWK0zH+ETF3bCv
	 BE1snojCB7nCrDh+0xaixXCXO+zaVLifrC/Yg4jTJSIFJbY4rCV6rwb4jhU+Myq+ce
	 eD0XMuodV4lkPimAGDFp1UjDlfYpbwmDn7q7peKqsHROyDIjC7p9RRIGdpiaAML0cN
	 Ronj9yFyULScQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH nfs-utils 00/17] exportfs/exportd/mountd: allow them to use
 netlink for up/downcalls
Date: Mon, 16 Mar 2026 11:16:38 -0400
Message-Id: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqEMAxA0atI1gaqHbvwKuKiaqpBidJUEcS7W
 2b5Fv8/oBSZFNrigUgXK++SUZUFjIuXmZCnbKhN7YytHNJ97DFNKJQ2lhV9Y4fgnCdjf5CrI1L
 g+3/sQILimXhT6N/3A6fUsJlsAAAA
X-Change-ID: 20260316-exportd-netlink-a53bf66ae034
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3018; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=By5E/s37Nz8ULOOA+zLD2q3k5uhJzkO0sRbWYKEr2ME=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB7fgAzp4vZaZy9dkDN5QnOonV4nQdHScKuwY
 dHtJvZt/aiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabge3wAKCRAADmhBGVaC
 FUp7D/wMgGR2brzcB+3LWyebu3MEGimL8bFFscP9mvwoPfPivdcQfotL0kwQJJPJUrtSB2hnyI3
 JMHQlN+R1I2lcSkuXE2fCZ7LHnrpy9Of+ss3axktWjxP2QyO46jYupq9xW+CXHVBiKH3mbNa1YU
 SgEVPhBLzm5VzTc/EIbTg6SfVZKuRHDsm+GitcUhfN32SKlPqgM2rKjQX8cb9HYo3yezkjmeLmP
 SS//xXe7Ef1GExrZ2FBBrG0w3K4fwdcpOYgWT+DcGPX4Getzx72J8Nv/yzPSYLCLbeC/7whRYdM
 fAQrGURPMvg4cJvrE94zwFs0lr/hTo9Dt2+wa1VnP8jOCFUhK/4swVbV10nUyB9WIUnviihu2Mp
 ki3hHrKzGascFS1610zkk/zpJloBlRRZANaFBQZsokKzOWitm+AwIthl8MvhSO4FSivS8/zQbcp
 BcOX6TFoA8X/n8f/UFqMe5c2xQVDw+1KeuAMSAWaYCRL9c7IPMcj3pCm2c7s0yg75/4nLJGHO7N
 uv6jrJos/SBCIQebdPsX/q6CLMY7nY4dPoijopu38y170Ze/oq3EeRJjbf4nffcnQMrx4sPN/sy
 3i9oxmSN72MaGSvu2BngZ2pvuGJ2gp6HcHboKRuuRu/eCW0GfIEP0W6YuD4jXv1ZATfRHw17f3V
 v9J+G0dEIMhWQlQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20199-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,configure.ac:url]
X-Rspamd-Queue-Id: 283C529C4C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This adds support for the new netlink-based upcalls and downcalls in
mountd, exportd and exportfs. With this, mountd is no longer reliant on
/proc for sunrpc cache upcalls.

There are also a few bugfixes and cleanups for existing code and
documentation in here too.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (17):
      nfsdctl: move *_netlink.h to support/include/
      support/export: remove unnecessary static variables in nfsd_fh expkey lookup
      exportfs: remove obsolete legacy mode documentation from manpage
      support/include: update netlink headers for all cache upcalls
      build: add libnl3 and netlink header support for exportd and mountd
      xlog: claim D_FAC3 as D_NETLINK
      exportd/mountd: add netlink support for svc_export cache
      exportd/mountd: add netlink support for the nfsd.fh cache
      exportd/mountd: add netlink support for the auth.unix.ip cache
      exportd/mountd: add netlink support for the auth.unix.gid cache
      mountd/exportd: only use /proc interfaces if netlink setup fails
      support/export: check for pending requests after opening netlink sockets
      exportd/mountd: use cache type from notifications to target scanning
      nfsd/sunrpc: add cache flush command and attribute enums
      exportfs: add netlink support for cache flush with /proc fallback
      exportfs: use netlink to probe kernel support, skip export_test
      mountd/exportd/exportfs: add --no-netlink option to disable netlink

 configure.ac                                       |   32 +-
 support/export/Makefile.am                         |    5 +-
 support/export/cache.c                             | 1892 +++++++++++++++++---
 support/export/cache_flush.c                       |  166 ++
 support/include/Makefile.am                        |    7 +-
 {utils/nfsdctl => support/include}/lockd_netlink.h |    0
 support/include/nfsd_netlink.h                     |  232 +++
 support/include/sunrpc_netlink.h                   |   85 +
 support/include/xlog.h                             |    2 +-
 support/nfs/cacheio.c                              |   49 +-
 utils/exportd/Makefile.am                          |    2 +-
 utils/exportd/exportd.c                            |   10 +-
 utils/exportd/exportd.man                          |   12 +-
 utils/exportfs/Makefile.am                         |    6 +-
 utils/exportfs/exportfs.c                          |   55 +-
 utils/exportfs/exportfs.man                        |   79 +-
 utils/mountd/Makefile.am                           |    2 +-
 utils/mountd/mountd.c                              |    9 +-
 utils/mountd/mountd.man                            |    9 +
 utils/nfsdctl/nfsd_netlink.h                       |   98 -
 20 files changed, 2343 insertions(+), 409 deletions(-)
---
base-commit: b9c9eea7c3afcfc77e241f71302a792dd15c8ea8
change-id: 20260316-exportd-netlink-a53bf66ae034

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


