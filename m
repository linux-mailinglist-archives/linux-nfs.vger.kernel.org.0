Return-Path: <linux-nfs+bounces-21956-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKqXOiuiFWqmWwcAu9opvQ
	(envelope-from <linux-nfs+bounces-21956-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 15:37:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AED5D6A03
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 15:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DDAF3003502
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 13:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722283CC7CD;
	Tue, 26 May 2026 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGzuTkZW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197BA3E0C59;
	Tue, 26 May 2026 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802572; cv=none; b=CUVaPMtMY2zGvfBAmtQoJ11LUF2CK5rPb375ZvhPTCzFvteOzaxgo6Rpg6EpNiXy9qXSa6hEtOqFX7FLGJTKio3qhwz2G2D7mJnmPolOkB/3QTnACHJpyO9hnLT4S0qF+5IAczjekMZ64p1+UEmTAIGCfOfgm6Eh/Y+P+wFS9Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802572; c=relaxed/simple;
	bh=2JJOeRxE2lFZJcCAye42Wy+KUQ/+u/MSM13XDCeDeQ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Yv7SpdFip0FwBPSMHzFK2UCv332CtLcyMwVaypxq7fEn/ZJNEEUlh+/4jMF2wIGplW9lHm8DuyPc57LmzCSxwK57O2FD+0FzDPwJ2Vn+b9kFeyr/e5JO5wnW0K28wZLu0cGnceLx7dudGPCGfVAXk2OO1rERTKct6I6LwT98PJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGzuTkZW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA77E1F000E9;
	Tue, 26 May 2026 13:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779802570;
	bh=kIvr27V6ovRg+GTv+185zkWCXnVBBPigE3t9E9k6mUg=;
	h=From:Subject:Date:To:Cc;
	b=CGzuTkZWWIIaO0uYwe2pTaRCsp1e2d7WMbZNgpMFVjBIygTtxEaz09h32jAUXq+7r
	 Jz7TzP4GyIBW3iyZwNXYy+8kFGijWrmiFvmsAxHOdUtuiqhlHEAnFA4sUDE7uGioBI
	 vY3c/YI2+oVKOn3ICx4cm8X7VlnC1RNf3ceqCMwraE8OOFGPZPqzPrcqIZ8JYCzxG9
	 RF6ZDwRHcs4g4aMOSTqN9AaPjD1v+ZwPtKk1nQNEEMj9x00+yMqcj62o32q1n9KPpF
	 g5m+T6Us+d8ROS9vMjncc83VDsCv9GonVzZBnP0TGrcFhaDbkRmztJa4e6HANC29Xj
	 30Y6222yu5R1A==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH 0/6] svcrdma: harden parsed chunk list against malformed
 wire values
Date: Tue, 26 May 2026 09:35:54 -0400
Message-Id: <20260526-rpc-kernel-bugs-v1-0-e251306ccca9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBBFr1Jm7UBaTQWvIi6SdJKOylgyqQild
 zfR5fv89zZQykwKl26DTG9WfkmF/tBBmJ0kQp4qw2CG0djhhHkJ+KAs9ES/JsXo7fHszNhbClC
 tJVPkz694vf1ZV3+nUFqmPbxTQp+dhLlNEnXCQlpYEuz7F9yYChqSAAAA
X-Change-ID: 20260524-rpc-kernel-bugs-fb537a0615ec
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@meta.com>, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2575;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=2JJOeRxE2lFZJcCAye42Wy+KUQ/+u/MSM13XDCeDeQ4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFaHCViAcDU/Liypb8hqczU7z/pIDlTkVAkM11
 5eMqxZqiuuJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahWhwgAKCRAzarMzb2Z/
 l0l/D/9k0oSxYVi6blQ7D7aesWHqYfuRDtx1a9aJRi5JKwArp4A0BsLZYp3Vmr/spQurqsfOlaH
 9T2uCL+SdExOAYqopcrE9gXTs2KnNAPhVJ1Id3krsdoSA+fNo954Mg+7hjU34acfAgduFK8sXCd
 14ioQRftChjww2lZc6K3sVnqI1R85mg8ocSrrge8fdM6vJZdUJ21+kOHrEbOSqxfuoNJlinKilc
 0C82bnyyc4iZY6WJEX/iro2h8o1NmUG1leCEJEHa91n4C0X5kV+q6C/jp8i8VMzsWpDeVD53gkO
 kWnBvVCPUs6vBTQq00XrpzXA6LQrO585StHpSuQr8gY9vETvv9CRhv81f3x0oP69S/bTYW9RFS3
 jPZ/lbJ1MaZsoEQeTIgy2RkLooknTFeE2ZrPngtdOo0cLXtFsp84BvX2LKz1LQeSPbQYLsSdE35
 B2HBRb3pl5dW2H4iRFf1HzieceyBfwREzHy7wfAQVj246ti+XuybDc3ASWQ2l8/QY+mTYXK+uOE
 xA4yj3241JP85oW5/8zPplFFV2zSmdZRXaYnOtzTGs++RIYjGFWs2Td/QbSMXIHoDyr5PduSoKJ
 yWa227fMrrg+Vmb+fGl28wU0o0sPZK/nktDClijIPR9M5JrwOd7fKiNzrg8ioMYggj3ggdKE1JV
 WiEIP42nGuqU2tQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21956-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: 61AED5D6A03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RPC/RDMA transport stores wire-supplied chunk positions, lengths,
and segment counts verbatim in the parsed chunk list.  Consumer
functions compute gap lengths and sub-range offsets from these values
using unsigned subtraction.  A malicious or buggy peer can supply
values that cause these subtractions to underflow, exposing slab
memory to the Reply channel or driving oversized allocations.

The fix proceeds in two layers.  Consumer functions in svc_rdma_rw.c
gain bounds checks against the saved inline body length before each
unsigned subtraction, closing the immediate underflow paths.  The
Read list decoder in svc_rdma_recvfrom.c gains a segment-length cap
against the receive context's page budget, and the existing page-
overrun guard in svc_rdma_build_read_segment() is corrected to
release the rw context it has already acquired.  These consumer-side
fixes are backportable independently.

pcl_for_each_segment() uses an inclusive upper bound that underflows
when ch_segcount is zero, turning a zero-segment Write or Reply
chunk into an unbounded memory walk.  The macro is changed to a
half-open bound that naturally produces an empty iteration for
ch_segcount == 0.  The decoder then also rejects zero-segment chunks
at the wire boundary, and reorders pcl_alloc_write() so that only
fully-populated chunks appear on the list.  The macro fix remains as
defense in depth and is safe to backport to trees without the decoder
change.

A consolidation pass validates Read chunk positions and overlap
invariants once, immediately after decoding, so that future PCL
consumers inherit the guarantee without replicating per-site checks.

---
Chris Mason (3):
      svcrdma: Fix offset arithmetic in read_chunk_range
      svcrdma: fix pcl_for_each_segment for empty chunks
      svcrdma: reject Write/Reply chunks with segcount 0

Chuck Lever (3):
      svcrdma: validate Read chunk positions before reconstruction
      svcrdma: reject oversized Read segments at decode time
      svcrdma: Validate Read chunk positions at decode time

 include/linux/sunrpc/svc_rdma_pcl.h     |  4 ++-
 net/sunrpc/xprtrdma/svc_rdma_pcl.c      | 63 ++++++++++++++++++++++++++++++---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 14 ++++++--
 net/sunrpc/xprtrdma/svc_rdma_rw.c       | 52 ++++++++++++++++++++-------
 4 files changed, 113 insertions(+), 20 deletions(-)
---
base-commit: 887d478bb2115cec0be8caae58bad4d4b3109b1a
change-id: 20260524-rpc-kernel-bugs-fb537a0615ec

Best regards,
--  
Chuck Lever <chuck.lever@oracle.com>


