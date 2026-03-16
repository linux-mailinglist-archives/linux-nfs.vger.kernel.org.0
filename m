Return-Path: <linux-nfs+bounces-20202-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UObpL0chuGmdZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20202-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:27:03 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E73D29C4C9
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B33D43028EF3
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EB83A0EB1;
	Mon, 16 Mar 2026 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5NFp4g+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10503A1CE6
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674216; cv=none; b=SIQnjJ1Qrksv+x/3ly4P1W7Dv+fIZk34Hl45oGY5wPM4VnC1XqScsDSxbTKgDrL+XoF5RMAvoCbL97nK6Jev8OCdzZ3TyNqALDUlDivFfKXJY3NVEoMf/qa2cE8r8qygPASHchMNmBQ+1HuFA9571XaxPrfAeUMHc38lAwbhXZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674216; c=relaxed/simple;
	bh=pLs5uiAKMZOKuVfM70p1l3lCyTX4ZhVTT2WoG0Rn8fE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W5VFgPWJdStz/AAu9ODSm6UZvSDlQSYbtWSn6WfM+osdR3ZpOlOwu+BDoF0ChJb9Cc1D5Ko4nOpvMRtkEBnzaKLzzkt6inoa+f5+V7rin+GbpE17c3po0etoKuNZIFORCPPyiyfZrt82iNdqsXrND+nh6t8L6xJbkgxUPFSGc5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5NFp4g+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8F0C2BCB2;
	Mon, 16 Mar 2026 15:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674216;
	bh=pLs5uiAKMZOKuVfM70p1l3lCyTX4ZhVTT2WoG0Rn8fE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o5NFp4g+6LTKV55CFLkcTYDunM+MhtREpe10z0OYvbCNp2xp8OFgLW2uyx1FuKU8r
	 EE++LUtd9qRqHMhBJAPHbn6yx1j1oq7n5O0U4vxhs+AbsZSM3yNb9pTJFEZDSK9Gyz
	 rwcj18uf7nHgG/bDeMmZRslJE/oGUpMqm+hUm7LwGmrD4bS3j2ilbMRdV+Xcip/UgX
	 hiQFPMIghpTPj9udDF/MWEcTr1NJi/nqnXidjx7DUKUMzbuEdViU/vMJ0cd9nS+u2G
	 6t2M8nW7E2cqjEq3G6Hm+XlP0ot8eIpp/BnI8nc4vyXrt7HEA+81IiFYNcuKMh2OBK
	 XokAmj20bFkew==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:16:41 -0400
Subject: [PATCH nfs-utils 03/17] exportfs: remove obsolete legacy mode
 documentation from manpage
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-3-9a408a0b389d@kernel.org>
References: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1997; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pLs5uiAKMZOKuVfM70p1l3lCyTX4ZhVTT2WoG0Rn8fE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB7g7DTsPJ9Xkreoum9kdKHzUVUSc6ob0aDWK
 5LgmLf1bomJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabge4AAKCRAADmhBGVaC
 FWI4D/9Q3r27AHj+NWrJeslFJlTLmkxB/SqHc4CvDMXm3ZqKtIcarkRrBG8Zli/nloF/6KWAa8b
 sAkB5GVDW1QcupwVuBneNG7oElFRi63utQaBDPysDSMVAJEZGbulRGud/OHNlIOgO2TZ1L+Dz25
 pO925AM+SYz26huJknA62/5F7EAalVli9J/uxUQ/TJW+DBSkn5b9spmxxPyK2YJPvxSWVm0jVVo
 LjM2Wo1K38mSYv0kfzBBXC3v6xSU33qMnlAj+Z6lq3AfgQ4zbKXkTlIUTeYa9YGRscFuDWVT8st
 po041xo3WiLRn6hIrUymCe+FAVu4Q5fiNxG0CBY03fAuqDPvQ9QiKS4MrnDppTKpLmpC3g3AhKP
 xaCK6Z7MUnSLbH21Rnp0Lkh8yYKcFkd3eNc5avqMGjtKwKqcy0heNicAjAymM88EycFfyy2s8d+
 O9rpxPBM0Qafsv9+rnUMwuJwWdn+qHhie88sxxv1TVB9w/h6O3G4cUugy07ff0HbIP7RgiabXNo
 Budm055dMPD6Dl5A14ywvSOL4ml/q3yZdtepr4qztmhsiIQedszrsXN/eZtghzfkXuVpmPfRJJ/
 AOCbtzgdOF+c9MmpoJbP7L5rgWBU9I1taWtZ+CqX0YvoIwp+hCgMaU9wEpyID1Doyb4I1SB6l85
 v+gFaF0EfITtH2A==
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
	TAGGED_FROM(0.00)[bounces-20202-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E73D29C4C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The exportfs manpage described a "legacy mode" for 2.4 and earlier
kernels that used the nfsservctl() syscall to inject exports directly
into the kernel. This syscall was removed from the kernel in Linux 3.1
and the corresponding nfs-utils code was dropped long ago. Remove the
outdated text and simplify the description.
---
 utils/exportfs/exportfs.man | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/utils/exportfs/exportfs.man b/utils/exportfs/exportfs.man
index 6d417a700340f050c0af5c8af848ebe8403f8379..af0e5571cef83d4f3de6915608b4871690a8853a 100644
--- a/utils/exportfs/exportfs.man
+++ b/utils/exportfs/exportfs.man
@@ -53,39 +53,14 @@ by using the
 command.
 .PP
 .B exportfs
-and its partner program
-.B rpc.mountd
-work in one of two modes: a legacy mode which applies to 2.4 and
-earlier versions of the Linux kernel, and a new mode which applies to
-2.6 and later versions, providing the
-.B nfsd
-virtual filesystem has been mounted at
-.I /proc/fs/nfsd
-or
-.IR /proc/fs/nfs .
-On 2.6 kernels, if this filesystem is not mounted, the legacy mode is used.
-.PP
-In the new mode,
-.B exportfs
-does not give any information to the kernel, but provides it only to
+does not give any information to the kernel directly, but provides it
+only to
 .B rpc.mountd
 through the
 .I /var/lib/nfs/etab
 file.
 .B rpc.mountd
 then manages kernel requests for information about exports, as needed.
-.PP
-In the legacy mode,
-exports which identify a specific host, rather than a subnet or netgroup,
-are entered directly into the kernel's export table,
-as well as being written to
-.IR /var/lib/nfs/etab .
-Further, exports listed in
-.I /var/lib/nfs/rmtab
-which match a non host-specific export request will cause an
-appropriate export entry for the host given in
-.I rmtab
-to be added to the kernel's export table.
 .SH OPTIONS
 .TP
 .B \-d kind " or " \-\-debug kind

-- 
2.53.0


