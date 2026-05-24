Return-Path: <linux-nfs+bounces-21894-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H7cMR5OEmqjxgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21894-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 24 May 2026 03:02:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4513C5C0FF9
	for <lists+linux-nfs@lfdr.de>; Sun, 24 May 2026 03:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56B8A300DDE0
	for <lists+linux-nfs@lfdr.de>; Sun, 24 May 2026 01:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C37418FDBD;
	Sun, 24 May 2026 01:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1HWQHy4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810E170818
	for <linux-nfs@vger.kernel.org>; Sun, 24 May 2026 01:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779584537; cv=none; b=Pwcy5m8JDeXZHPg8Xq+lKTrnBGsjIBrpxYGHzMBRd/BJnBvKbwa33auk32aYCctKcWmIUJVzaPpSROybp+eU0QM1AyGRlUnjxd4gXZ5thLZm02WLlRVuypGvAtokgzFIJoO7yPXh8i6mWeYwchwE5GbPvEUurTiE7qdT8YTBIk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779584537; c=relaxed/simple;
	bh=zA2S/u4vsbOJZkWgdlQA+koUihbdp+1stVmHFUOlgoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gr6CDIADpiWX4qdzE6PhgJdXc5HL5XN6nniAlr+rkI+4gPBxK7PUwTanP5eLF8Cef0JQGlN6v3+BHaCj+nlrAA3Euxlc5gfz1cZR2fMWMZBK7ExLUGFJ6xFdsGkQe2gfIey0aJQ2cwW2013UCnVjDMQf5Lo7jKB0JWhro7aEDKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1HWQHy4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A68E1F000E9;
	Sun, 24 May 2026 01:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779584536;
	bh=5xCycKQbqjNeUvfUyLOIo2ZAmBrMXv6wcL4kjHiQPdk=;
	h=From:To:Cc:Subject:Date;
	b=a1HWQHy4b7L1XGMcPY2LVZjdR16cePcIvRCl7vDmn7h3qWIPJFKJz3GND+/0vy9pA
	 CVCNEFXoywyqHi3xks3CsBKi0yR21sG4A7fKTZTegy9zBQHYHMdtig46Yn+xRVSLp4
	 gWJ1LaiiVyWyxTisZiRVGZz/RW8hq3+SCWnvW/OpR8IFefd0O06REng2bbVCTKCuYE
	 hpujgtmqw9tsJiZkfz2ZxwpC4XdITAiUtjQagQ0YL1ZFwm+666Q+MtRgx9jg0HTv4G
	 nENmbXYdClRuL2MXOHoCr70nqF8gAJeEkasH2g6DgeOuIegELxXXFXH1UjBha83gdd
	 YIdAH7Mj7r1Eg==
From: Chuck Lever <cel@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 0/4] sunrpc: close length validation gaps in krb5p unwrap
Date: Sat, 23 May 2026 21:02:09 -0400
Message-ID: <20260524010213.557424-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21894-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Queue-Id: 4513C5C0FF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Neither svcauth_gss_unwrap_priv() nor gss_unwrap_resp_priv()
enforces a minimum on the wire-supplied opaque length before
forwarding it to the krb5 unwrap core.  An authenticated krb5p
peer -- NFS client or server -- can send a token shorter than the
16-byte RFC 4121 header and reach gss_krb5_unwrap_v2() with a
length that drives pre-decrypt out-of-bounds reads, a
divide-by-zero in _rotate_left(), and a post-decrypt unsigned
underflow in the movelen computation that feeds a multi-gigabyte
memmove.

The fixes are layered so that neither the caller boundary nor
the unwrap core depends on the other for safety.  The caller-side
floor checks (patches 1, 2) are sufficient to close the attack,
but gss_krb5_unwrap_v2() must also be self-defending because it
is reachable through gss_unwrap() from any future caller that
might not enforce the same floor.  The xdr_buf_trim() clamp
(patch 3) is independent of krb5 -- it corrects a generic
invariant violation that gss_krb5_unwrap_v2() happens to be the
only current trigger for, but that any caller could hit if
buf->len and the component iov_lens get out of sync.

The client side (patch 2) has an additional u32 integer-overflow
bypass that the server side does not: the original
`offset + opaque_len > rcv_buf->len` wraps when opaque_len is
near UINT_MAX, accepting a huge token length that re-enters the
same underflow chain.  The replacement splits the check into
separate offset and length guards that are safe in u32 arithmetic.

Chris Mason (4):
  SUNRPC: svcauth_gss: enforce krb5 token minimum length
  SUNRPC: harden gss_unwrap_resp_priv length checks
  SUNRPC: xdr_buf_trim: clamp buf->len to avoid underflow
  SUNRPC: harden gss_krb5_unwrap_v2 against short tokens

 net/sunrpc/auth_gss/auth_gss.c      |  6 +++++-
 net/sunrpc/auth_gss/gss_krb5_wrap.c | 11 +++++++++--
 net/sunrpc/auth_gss/svcauth_gss.c   |  2 ++
 net/sunrpc/xdr.c                    |  2 +-
 4 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.54.0


