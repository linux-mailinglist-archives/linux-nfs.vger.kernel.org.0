Return-Path: <linux-nfs+bounces-22123-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D0gJc59G2pNDgkAu9opvQ
	(envelope-from <linux-nfs+bounces-22123-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 02:16:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4E2613FC5
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 02:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83D11302BB87
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 00:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C3D1A9FBA;
	Sun, 31 May 2026 00:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1B6pFMY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBC361FFE;
	Sun, 31 May 2026 00:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780186557; cv=none; b=eEsc8OUfvl/KRSUxM6R5IjugMkUKnk2jNHbgbtNDCv/XFmSV2peGET6dw0VkSFQEASWkXndb6TCLvWr7EfsPi24afo8xGd666yKkaqT6w0y4RoFvoWlkIkybaZTOUlBzczKvh17K3X+3dHUefLpgYIG6lrxByAcRc6qI6uoyObo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780186557; c=relaxed/simple;
	bh=ElcPU6XvIInRg7COmAS4z/EVUvcWunOkJU85QBlY690=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlxDsMvn4vyuktr4H/5Ug1Q+hn0I0gbj/kgz6EBcoDxu2/oKqVytvGkM1zZOLFJXNtI09M5qkP8dC+R2ix4RgUGZhN4PcOzWRIBXTM90izIpviqXFXJ5QQvXZDR2kzqE39eufjFgy3f7zkfv1WWP2nBK8nwq/y2OU4uLPZkrb8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1B6pFMY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342241F00893;
	Sun, 31 May 2026 00:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780186556;
	bh=9Ujyku4GWV5GxE6vN7e6SkTPxvGvLZ0WdPkGbjeKa7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B1B6pFMYABkOD48BPWyBc+3Jz6rdkRJKByTyXbAxwpu/ikqYYmRMRDtXJfB7Dgb6q
	 A2kFu2DaYhnwGCVfC8iQpLnCWrq4lTzug0msD4ZeqqxwoCFXwTw9WSaL3iE8zA1NE1
	 OWASPPAL9msSxwgD5xXl3KTLTGdF0FzOhvxM2E4WHyTSZlEgOgv3EzknwhX9/2xS3i
	 +XBgoY7GkkJDCAOF9ivKeT8LBveKv+fr39Fg5xiYyoa7RB9RvfufnN7zTWQexFdLkw
	 fOdmfIsH66Rt/e/4hAIJ1oM9eYUGBc6rIuQIRxKEkFqbncYW5liAGJoxrh3Y/LN3+B
	 +cj40MRdwY2Ew==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Scott Mayhew <smayhew@redhat.com>,
	Trond Myklebust <Trond.Myklebust@netapp.com>,
	Andreas Gruenbacher <agruen@suse.de>,
	Mike Snitzer <snitzer@kernel.org>,
	Rick Macklem <rmacklem@uoguelph.ca>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] nfsd: a pile of fixes for random bugs
Date: Sat, 30 May 2026 20:15:51 -0400
Message-ID: <178018654363.481318.3763501329195176115.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260530-nfsd-fixes-v2-0-f27e8eb4d974@kernel.org>
References: <20260530-nfsd-fixes-v2-0-f27e8eb4d974@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22123-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Queue-Id: EF4E2613FC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Sat, 30 May 2026 09:19:16 -0400, Jeff Layton wrote:
> These bugs were categorized as remotely-triggerable panics, UAFs, DoS's,
> etc., but they aren't reliable. There are also a few protocol fixes in
> here too, etc. It's a grab bag.
> 
> There are a number of substantial changes in this version. See the
> changelog below:
> 
> [...]

Applied to nfsd-testing, thanks!

[1/9] nfsd: fix BUG_ON in nfsd4_alloc_layout_stateid on racing delegation revoke
      commit: 4b32baefd3dc7d91d0c9b947247874d4b66bdad8
[2/9] nfsd: RCU-protect cl_cb_session to fix use-after-free on session teardown
      commit: a2070a5688503d8fa27163a42ac3fda04d69c90b
[3/9] nfsd: convert nfsd_net boolean flags to unsigned long flags word
      commit: 7118e4c25d7598498620018e321eebbd6e50d4d3
[4/9] nfsd: dedup nfs4_client_to_reclaim inserts
      commit: 4b2ddffd38f4cedf8b3ee8f48773140dfd6b42c9
[5/9] nfsd: gate nfs3 setacl by argp->mask
      commit: 3f0949f6d0c7744aedb01c825347ed26438e8535
[6/9] NFSD: check truncate permission under inode lock
      commit: 89c66302414a43713dc21f4d8f8055bb7d9c238a
[7/9] nfsd: fix partial-write detection in nfsd_direct_write
      commit: cd38d5ab0f3adfd19a4ed045a7a341e685287eaf
[8/9] nfsd: cap decoded POSIX ACL count to bound sort cost
      commit: 67fda0293e2fea8b35f46ba741befa4ee24c7a9e
[9/9] nfsd: validate symlink target length in NFSv4 CREATE
      commit: d23e024771f93ca606dbbcc210651f4e61c74313

--
Chuck Lever <chuck.lever@oracle.com>

