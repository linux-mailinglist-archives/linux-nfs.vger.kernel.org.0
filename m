Return-Path: <linux-nfs+bounces-21700-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDfQOUFoDGpXggUAu9opvQ
	(envelope-from <linux-nfs+bounces-21700-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 15:40:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EF057FDA5
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 15:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E41D308740D
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 13:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992F8369D75;
	Tue, 19 May 2026 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uW2U90Bf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F96369D5D
	for <linux-nfs@vger.kernel.org>; Tue, 19 May 2026 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197672; cv=none; b=aPqRsJIY0lKil0Lst7CWCCtb/JAwQzhwDnBYG/wMpUWqiRNjL1oP0N/cySxm9f+9TBnS+bqLeF7agH2EYU3OtNqnQl+riM2PllafsJi4vGe0hJ41auSWwz33eUTm4UwJOImhsA4Lyz7r1elBIZCg07hAOdAS6OiDTR52aUvobXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197672; c=relaxed/simple;
	bh=uKRU7fp4ABsS4yo5W6WgXviyjL96hNvY9q9kR/MUoqk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ckiBMkU32ZQgk2BLjSU8kFY5np2V85YugbJb2ifG8tYm8h/r6k9sxZtzyH4DsJeD5jb8PnfNvpJ1h4L7Acl4hi0ybCFudpskKz+UVu0UycZMh1+3HXIRviPmMI9o7Xus7loTy3ddItKZowRnWxAts+S8HG/tcjPMlmkrc1l03u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uW2U90Bf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAA4C2BCB3;
	Tue, 19 May 2026 13:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779197672;
	bh=uKRU7fp4ABsS4yo5W6WgXviyjL96hNvY9q9kR/MUoqk=;
	h=From:Subject:Date:To:Cc:From;
	b=uW2U90Bff3B/WjiSbR/ePT3zuaUsLSWV09HB+wlVKn2VYe9aR7F8gR3Lc9kmn0Xfq
	 ijpQKYbl6cw04/Ov3CqlJr+moPt3BvQz/hbyx8tGcLG02qNDyfgI8j6Oxt0Pqv7RXL
	 tVU5gTZ/IP8Ed+Guvy7wSE1ODmiRAWLQRIdeAMGJTG2NBZ1njgXRQnUS9pe4cmGFE+
	 ok1z1xSAqJ06OXPdmMWZEOmArq6XyNkY+Ni6773/RiKn1iViphr6WEcXajpp6pVVwA
	 4rOO6NyPKb8DhqsJiFMgXXB03vuLvSmWrMB3F7Upd2sdNeMGl6VGcc5E1Ack4MtX7E
	 pX5BPxvdFdDtQ==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH 0/2] SUNRPC: Fix xdr_buf_to_bvec() bio_vec array overflow
Date: Tue, 19 May 2026 09:34:20 -0400
Message-Id: <20260519-xdr-buf-to-bvec-fix-v1-0-1c9decbd4466@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMyw6CMBBFf4XM2om0RgR/xbjoYwpjTDGdQkgI/
 26ry3Ny79lBKDEJ3JsdEq0sPMcC6tSAm0wcCdkXBt3qrr2qHjef0C4B84x2JYeBN+zUTQd7cf0
 wGCjPT6Kif9XH88+y2Be5XFN1YY0Q2mSim6py9D7HIB4zSeY4wnF8Af1XJqeaAAAA
X-Change-ID: 20260518-xdr-buf-to-bvec-fix-6172fb3c899a
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=3018;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=uKRU7fp4ABsS4yo5W6WgXviyjL96hNvY9q9kR/MUoqk=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqDGbgje7W58XfQO9JKtvNqmcFHIxOL1wIPnk+8
 lwyDlJ47QeJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagxm4AAKCRAzarMzb2Z/
 l/sBD/9IYbdQNEChbdcYc33bY1135ou9v1iDBTLPBAAKqFYvDsC6vXBxC5S7XazpQV3o2hbYfEM
 FYVOh6nuCq7uHyfvpJfUHiSmyQ2Lb6qosFvp+OujhCXETyq8Ky7mIexfI5gySeodLzZgwpl55s/
 rLYtk3lWz6QKYjQ79HljyCxKdnb764/kcPTPZQ/CeGMqhTz9Sflpi8v8ZE4SYt1QiWsdxfNdnOq
 yM6luR+0DJJ8KDPHiER6ZaPcX789U/3m0upGgN2g53vF/q9MoHJhrwvN5CKQuU2AyxmGONrhlUk
 oDU5swMFMxNzGCxWvvCEd70Mc3dnOiQr5U1tLAuFX9STkh0TnV52WTkZNQyN2teDYLZcBzsEqa7
 etM3deqJe4dIFfG9R2H96S5Ljvp+BtwT9xgo84X5ai2pLRPzXjFVdH0l7KmQfOx2xNN5AlZCC9y
 N+v7Dzh2wPig5pjJ4O9Yx7Xg+bbM8+jTmmKQqRs1gNl5mArx/Hz7jPPl+DhbbQ9Z+oceAJbRFHq
 kczd0VDxScLDr9CAAYEKnU8T27Mq5AlbWjMLLUqXnmdJ3V8RIZz8LXLRgl7YM2irDS0I8GnJTdP
 QovILIgy3RUwB3pLMHO4DXAtyxfdi+I/d7szchfY/KAPQQAkW6/tuuppzGttaeNIe9yogDsQTE1
 xYbFxc6+kxd1Clw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-21700-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:mid,oracle.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: 62EF057FDA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xdr_buf_to_bvec() lives on the NFS server's WRITE-decode and TCP/UDP
send hot paths, and the array it writes into is sized exactly to the
budget the caller passes -- no slack. The function has two halves of
the same overflow hazard. The first is a store-before-check in the
head, page loop, and tail branches that lands one bio_vec past the
end of the array. The second is an overflow label that returns a
foreshortened slot count rather than failing: callers feed that
count into iov_iter_bvec() with the original byte length, and
iterate_bvec() walks by byte count, so the bvec pointer steps past
nr_segs into adjacent slab and dereferences it as
bv_page/bv_offset/bv_len, handing the result to sock_sendmsg() or
the file's iter_write path.

This series is hardening, not a confirmed regression fix. The
current in-tree callers all size their bvec arrays via
svc_serv_maxpages(), whose formula reserves slack above the maximum
decoded-WRITE footprint. A WRITE payload extracted from rq_arg by
xdr_stream_subsegment() therefore fits within the budget that
nfsd_vfs_write() passes, and the overflow path is not reachable
from a remote NFS WRITE today. xdr_buf_to_bvec() has been
EXPORT_SYMBOL_GPL since 62bf165c04bf, so the bound also covers any
future caller that does not replicate the same accounting.

The two halves are addressed separately so that the bounds-check
reorder stays a self-contained regression fix safe for backport,
with no API change. Promoting the overflow label to an -ESERVERFAULT
return is deferred to a second patch because it changes the function
signature and requires updating every caller. The signature change is
not appropriate for stable trees. After this series, any future budget
mismatch surfaces as an error rather than as a short transfer reported
to the client as full success.

One adjacent hazard is deliberately not addressed. svc_tcp_sendmsg()
passes rqstp->rq_maxpages as the budget for a write into
svsk->sk_bvec, which is sized at socket creation. Static analysis
flagged the two snapshots as a potential divergence if sv_max_mesg
changes mid-flight. In current code sv_max_mesg has exactly one
writer (__svc_create()) and is never mutated thereafter, so the
values cannot diverge. After this series the bvec layer will return
-ESERVERFAULT loudly if that invariant is ever broken by a future
change.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

---
Chuck Lever (2):
      SUNRPC: Bound-check xdr_buf_to_bvec() stores before writing
      SUNRPC: Return an error from xdr_buf_to_bvec() on overflow

 fs/nfsd/vfs.c              |  6 +++++-
 include/linux/sunrpc/xdr.h |  4 ++--
 net/sunrpc/svcsock.c       | 14 ++++++++++++--
 net/sunrpc/xdr.c           | 23 ++++++++++++++---------
 4 files changed, 33 insertions(+), 14 deletions(-)
---
base-commit: 8ed8efa735e64013bdc8918d24c656e08bbd3e03
change-id: 20260518-xdr-buf-to-bvec-fix-6172fb3c899a

Best regards,
--  
Chuck Lever <chuck.lever@oracle.com>


