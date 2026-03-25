Return-Path: <linux-nfs+bounces-20370-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGhuBk/aw2m1uQQAu9opvQ
	(envelope-from <linux-nfs+bounces-20370-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 13:51:27 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 679FC325302
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 13:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7FC73356D7C
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 12:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E5B3DA7F4;
	Wed, 25 Mar 2026 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b="URNu2Cxg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-m3295.qiye.163.com (mail-m3295.qiye.163.com [220.197.32.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921B3D565E
	for <linux-nfs@vger.kernel.org>; Wed, 25 Mar 2026 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440689; cv=none; b=fz6re4cWN6tPXjGzttyAy6gJoQPJf2bJXcIfu7RW2LUWpExyrXO0y6x084k8BO9mAwOcgtazjajgWOu8gar87qm7VeYhKJyT6sqMLK7pVC1AZpzuK8djaMVDgEd64Qp64IawG71Mqp2LdDxgnhKx2cM2miYBS403nTPg3ojz3Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440689; c=relaxed/simple;
	bh=n6EQXFmz8dbOCbohWl8OWWQ1reQTGqqaxNAcIf1FsPs=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=crb1XZ0Ig4N/NS6ITAuX48wKhKIFIXd8kfzPOklXdpBWJpcD1VkbDfbdPFIX/+No3RcQOAbmtHDwxdb+XMG0ZelxzSZxCf55/VhF7C/2PBPGfhQgK4+UUj2/rXrBDffuhjGSBs6t7Go6kBPPpVuy5xRM4wgZaSZTvdccSSNWoMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn; spf=pass smtp.mailfrom=ucloud.cn; dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b=URNu2Cxg; arc=none smtp.client-ip=220.197.32.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucloud.cn
Received: from smtpclient.apple (unknown [106.75.220.2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1813ea914;
	Wed, 25 Mar 2026 20:11:17 +0800 (GMT+08:00)
From: user <wei.guo@ucloud.cn>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: [BUG] NFSv4.1 client hang in OPEN reclaim path
 (rpc_wait_bit_killable) on 5.15
Message-Id: <538B06AD-0307-4BD4-8E44-16BF6BAD7B4E@ucloud.cn>
Date: Wed, 25 Mar 2026 20:11:07 +0800
To: linux-nfs@vger.kernel.org,
 trond.myklebust@hammerspace.com,
 anna@kernel.org
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-HM-Tid: 0a9d24e8020a023bkunm7540f956680fb5
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHx9JVk5DT0keGkgaSB0aH1YVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlKS01VTE5VSUlLVUlZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVU
	pCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=URNu2Cxg4/7tqZmyPOmtCFFhKL3JrnZAdvG9y1UWwJH4V9/bXGF2Z8yk5LqjIx/77BYo6XMCEtw7BoM0lZ6oLPVk35iYa7Hcb1McGWcxO2PO3+HkmslNmO31f6jVtyUGJMfs4i88rpUa8BE2MVPH+6s3FfL3y8EM4W5kfT6DHHQ=; c=relaxed/relaxed; s=default; d=ucloud.cn; v=1;
	bh=n6EQXFmz8dbOCbohWl8OWWQ1reQTGqqaxNAcIf1FsPs=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ucloud.cn,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[ucloud.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ucloud.cn:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20370-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.guo@ucloud.cn,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ucloud.cn:dkim,ucloud.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 679FC325302
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

I hope you are doing well.

We are currently investigating an issue with an NFSv4.1 client on Linux =
kernel 5.15 (Ubuntu 22.04), and would really appreciate your guidance.

The issue starts when the server returns NFS4ERR_EXPIRED. The client =
appears to enter recovery, but the reclaim process does not complete.

The state manager thread is observed to be stuck with the following =
stack:

rpc_wait_bit_killable
__rpc_wait_for_completion_task
nfs4_run_open_task
nfs4_open_recover_helper
nfs4_open_recover
nfs4_do_open_expired
nfs40_open_expired
__nfs4_reclaim_open_state
nfs4_reclaim_open_state
nfs4_do_reclaim
nfs4_state_manager

During this time:
- The server continues to return NFS4ERR_EXPIRED
- The client does not appear to successfully reclaim state
- IO operations continue but repeatedly fail

=46rom RPC statistics:
- ~30 million calls have been made
- retransmissions are very low (94)

This seems to suggest that the issue may not be caused by network loss =
or server unresponsiveness.

Additionally, from our observations:
- Network connectivity appears stable
- The NFS server seems to be operating normally (no restart or failover =
observed)

One detail that we found particularly interesting is that:
- We do observe ongoing RENEW / SEQUENCE-related traffic from the client
- However, the client still eventually encounters NFS4ERR_EXPIRED

This makes us wonder whether lease renewal might not be effectively =
taking place, even though related traffic is being sent.

Given that we are using NFSv4.1 (where lease renewal is implicit via =
SEQUENCE operations), we would greatly appreciate any insights on the =
following:

1. Under what conditions might a client still hit NFS4ERR_EXPIRED =
despite ongoing SEQUENCE activity and a seemingly healthy =
server/network?
2. Could there be scenarios where RPC completion, session slot handling, =
or sequence handling prevents the lease from being properly renewed?
3. Is this behavior something that has been observed before in the =
NFSv4.1 recovery or session handling paths, particularly in 5.15?

At the moment, it looks like the client is stuck in the OPEN reclaim =
path waiting for RPC completion, and recovery is unable to make forward =
progress.

If there are any known fixes or relevant patches in newer kernels (e.g., =
5.19 or 6.x), we would also be very interested to learn about them.

Thank you very much for your time and for any suggestions you may have.

Best regards,=

