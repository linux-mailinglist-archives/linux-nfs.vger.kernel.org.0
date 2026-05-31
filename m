Return-Path: <linux-nfs+bounces-22128-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PF0INEkHGr9KAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22128-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 14:08:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0A4615F7E
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 14:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E5593013A41
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 12:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8279135675A;
	Sun, 31 May 2026 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6aEwZX6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8912532AAB5;
	Sun, 31 May 2026 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780229230; cv=none; b=Re0AH8a98g/5DM4+ESSHyoqER4xmYgxp0T9TShPzs1qr8JZDUVfcHrHjZRz5Tv6cUuF3u5IBjCKTDBRPXzBiFsC/eW7CEjzftEue8ZGR9lL4/Z2INxJWGA5TlPpKUYmhO7dONzBFPHzdvpONzoVbDBAzfkB2XErqI2gb4+khEmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780229230; c=relaxed/simple;
	bh=57mrSY1QZaEY0fXbP/8UKAMgrPYmQk3qePuPO023egk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G6h3R4wUjAqv7D/DwHaOLoqx/7bjNJ/pEaZMbcFXtY+lYy22AkBHkM0sumMdo+JyxgW9uTlknJQctRNWYLxHlWzRNcTgz1H2n6QPJotGUtuszpnzRz6kMyXnNnvdDn6Xfqo9xJDk4y4G+JlNb8YIAHZe3Ci/P5YZtVNlrAFqm7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6aEwZX6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B8B1F00893;
	Sun, 31 May 2026 12:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780229229;
	bh=kRwk4vc2h9vuTKpurmEeQDF5/591humxvFM21kWNa0Y=;
	h=From:Subject:Date:To:Cc;
	b=E6aEwZX6qQ/QGw96/Q/UdierM/j9PW6WoDLoH6HqW+eTJ+UGsDZVY+GJhLjkRo1Ma
	 dJS0YQKnC4MAWKSBiZAYvIzHfxP32AIT5yITHBZQQGkIi/PCMLuPRuhT2RtXPBfInF
	 Vtb1D4soTvllkzOb08pCtD1OXl2akuohNF2FKIWEqZXZMNo9DNUpv8NpCiBoX1QZRH
	 q7Sk5t5MRAzlmA6S10jbepg7qGF3a1+gGp2cj9ND3k7raRPEIQuC1/yTSWGqSsocPW
	 kXgOh9A0C7BCpBY+ikoUFEOgjA7g/wJvmbrSTbx8mpYQDhC5hJHI/gZ39CTZ/PkQ3p
	 7SLCdWLOot9Vw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/6] nfsd: medium-severity bugfixes
Date: Sun, 31 May 2026 08:06:57 -0400
Message-Id: <20260531-nfsd-testing-v1-0-7bfa481b0540@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBPUMLCrRIvS0WZj4UgE4t2Tl
 m/xfwXGTMiwDBUyPsR0pQ41DuDOPUUU5LtBSz1LMymRAntRkAulKKzS+ghGObQGenJnDPT+u3V
 r7QP0tV+UXgAAAA==
X-Change-ID: 20260531-nfsd-testing-9122bf51ce95
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, David Howells <dhowells@redhat.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Rick Macklem <rmacklem@uoguelph.ca>, 
 Chris Mason <clm@meta.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=57mrSY1QZaEY0fXbP/8UKAMgrPYmQk3qePuPO023egk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHCRq5fhB5nuRFxe9AvrHzaiWG4TO/q8G8r4hu
 F6gGsRXnOCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahwkagAKCRAADmhBGVaC
 FRXGEAChCJz6EoZOKJTS31NVpgACpl6h6sGAvQXQOlxJY3R4YDAuVtLpZubaMUfdRk+QPOz3XXs
 ZUJQhZ2B+XcluWFdoC0bRhZuiYqVhT30EmljLzLqNm0oLNqsIKHlGR+jTfRLrsmlK8TA+2LC8HW
 4YUWddP9NT0c/2dOYnd9skemzt3D8jT152syx1xnsGfTINHJJkKNaf3M6fQeJZJ/OGRNVUCDLWJ
 11SlWdmo95zcHqTqY4gKSVftcA4wskj7w5ysQYXMevGV/GUxjWBhtGWAcIZEGi5jmi4cgFsVtMk
 ok4Dx2yjsPKJdcleRFNPGIdNK2UxbRlhsyk7MyY8qmUZWPoqv9NLgY9dXqwo08zy+dZ/Qm1soSG
 7ylxSRYCzHAV4ywgIZQVV2lTqUXRVI0760c6pkKkbJT5oCleOcFnxr/ZuCHWMkBmc8cWAHT4Cri
 OcvngJbHIGxM+MrDhc0XXXfvJni4e+D6qxrXVoruqhAr69cqVT/L5F8kzYN3AAMLswx1tdKQ19b
 ekskopPzgkNK0Kq8vxglQ6GGm7n8s0U/rDvW1wCsdmS+sq2OCGKI585v+9TlBbA7JVjMVuxih4E
 Q8aI91JoCxYvv8tnC82wGmgmblkgJ+ybbAulBLY/DKiNbzaa7513+PfbzMysMrRIPeB8bGLANXh
 YSXUwiy9N3ww7JQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22128-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DE0A4615F7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These are classified as medium-severity, remote-triggerable.  Some
memory leaks and refcounting bugs, and a potential buffer overrun in a
tracepoint.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Chris Mason (3):
      nfsd: size fh_verify server sockaddr slot by xpt_locallen
      nfsd: release path refs on follow_down() error
      nfsd: release OPEN-decoded posix ACLs via op_release

Jeff Layton (3):
      nfsd: fix nfsd_file leak on inter-server COPY setup failure
      nfsd: fix dentry ref leak on V4ROOT export filehandle lookup
      nfsd: fix layout fence worker double-reference race

 fs/nfsd/nfs4layouts.c | 27 +++++++++++++++------------
 fs/nfsd/nfs4proc.c    | 20 ++++++++++++--------
 fs/nfsd/nfsfh.c       |  8 ++++++--
 fs/nfsd/state.h       |  1 +
 fs/nfsd/trace.h       |  4 ++--
 fs/nfsd/vfs.c         |  4 +++-
 6 files changed, 39 insertions(+), 25 deletions(-)
---
base-commit: d9f35aa8be6e05deded63f92b153292518bd60a4
change-id: 20260531-nfsd-testing-9122bf51ce95

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


