Return-Path: <linux-nfs+bounces-23120-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /0HEOXofTGpnggEAu9opvQ
	(envelope-from <linux-nfs+bounces-23120-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 23:34:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6871715BF7
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 23:34:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=janestreet.com header.s=waixah header.b=m9egatQ7;
	dmarc=pass (policy=quarantine) header.from=janestreet.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23120-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23120-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3CF5300A5A3
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 21:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943432D780C;
	Mon,  6 Jul 2026 21:34:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604C73DCDA7
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2026 21:34:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783373684; cv=none; b=YCNXryLtaqvAUZECrfmz2IdRh4QwuNcxTFh4tFvhsvPADWbqV86GQQ+/RPqi4cdsmtOXRhP/fevBundykxW5GGXxpxVwpMw9iN8nCHIt/azSyZDNnVehvhKJfVDhQ4cT5PSib5pvJIYD03FwTJqhopRZ8JfBlaJnmo6u6is9yk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783373684; c=relaxed/simple;
	bh=ku/tCkJmgHTK/gVPKoZiukqbluLKMPYDczFXjMrlI34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FkRTEmh9cR3qUd0Kii3opY1gFTWZZ6m4xRDKugecy6hinqvgUNOGYpFqdBTHKcF8xY50Ixk6UHdhqj6BZXrtvQZgQ0WH9yi8aKGJ8x2LTWmo9ELk3qjmRO/tf65PQiKWIGZx9VnAsoDLC1glKUV7zAtt7DPricnbOVMlIC6tuzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=m9egatQ7; arc=none smtp.client-ip=64.215.233.18
From: Tian Lan <tilan@janestreet.com>
To: linux-nfs@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>,
 	Anna Schumaker <anna@kernel.org>
Subject: nfs: opening a file with O_WRONLY|O_CREAT flags can result in permission denied error
Date: Mon,  6 Jul 2026 17:34:22 -0400
Message-ID: <20260706213435.659381-1-tilan@janestreet.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1783373676;
  bh=+IwGXdTBTPPtTq1VN+XfB3huDHiso0Tjv3DZ/Igins0=;
  h=From:To:Cc:Subject:Date;
  b=m9egatQ7vFBZQZqEd5+HAWshNe4tAil6PhI0Lvr0CsxNAYelmyPIfWks7WgVxbVTY
  MQUKCBbEJw9FXz16Oi7K4KJJeVeYrF1Z7TbOZwyGyU8XsLCyyEZ6WckHWHn70iraN1
  Np78xRkgjSrRziOZaB9HJKZ07YBE/jf+zHfWefUoDI4cZgpOvv/hDRwzegXcJ6nqPI
  Ztj54weH5dy1tgdRYXEpWTjw0ENR0eaRtIciIUFIJN2bvlXTKI0siqKZkEQKWNbbKb
  LSzAXGee51TSqZGim3ezsU3CX5Vlp7h4YXmyyKvu7qbQ2CvaGrMCaR2joBXAw246Mk
  H29+uB0jlo6eg==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[janestreet.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[janestreet.com:s=waixah];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23120-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tilan@janestreet.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tilan@janestreet.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[janestreet.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6871715BF7

Hello,

We recently noticed there is a behavior change w.r.t opening a file 
with the O_WRONLY|O_CREAT flags over the NFSv3 protocol after upgrading
the kernel from 6.1 LTS to 6.12 LTS. From the packets capturing, it seems
like the kernel would now issue an additional CREATE rpc call to the
remote NFS server regardless if the target file pre-exists or not.
The CREATE rpc request could return an EACCES error if the client only has 
the write permission to the pre-existing file but no write permission on 
the directory containing the pre-existing file. This causes the openat 
syscall to fail with permission denied error which is not expected.

After doing some code tracing, it seems like the new behavior was
introduced as part of 7c6c5249f061 ("NFS: add atomic_open for NFSv3 to
handle O_TRUNC correctly."). We would like to confirm if the current 
behavior that we are observing with the 6.12 kernel is expected given 
that the new behavior breaks existing user's application code. We 
currently have a workaround by explicitly remove the O_CREAT flag when 
opening a pre-existing file for write, but would still prefer not have
to apply this workaround when upgrading to the newer kernel.


Best,
Tian

