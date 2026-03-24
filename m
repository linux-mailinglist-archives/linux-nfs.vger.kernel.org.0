Return-Path: <linux-nfs+bounces-20350-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKLrHj+Pwmn/ewQAu9opvQ
	(envelope-from <linux-nfs+bounces-20350-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 14:18:55 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0247F309307
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 14:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3D45317ACF3
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 13:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808A03F7A94;
	Tue, 24 Mar 2026 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9hnRYmC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E96C3F1643
	for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2026 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774357494; cv=none; b=spHKzYIM1spij9Acok+9W2HQdkrDxXA0c7WyRahMqL7qLMI7Gn4Wddqz3NQXB68wsBt8usa4Th8cFjFCfUZfUPWXjqqwhlnyAm7+/R0crAhaJ8MGhyHMhVlMFISkSB8i6hgd2UxvM6JpwrfaZse6xPriPaxV4+AmvOi0FZvgVb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774357494; c=relaxed/simple;
	bh=RiA3l+xBx7slPIegWMGY6wmtNGD3r6+FNa36TQabvO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2kTAS/vglKALKCSvPlkrhRrdymEvbmiE8BsVIu+Q230/IaK1ZWVUXErNCoFwQiGCT/c0IMUPW77Vels9bbMghWgm2nRsEqOKnf0DK4J3xOyZWzPrn0b4qWq2z93nuw7uxFsw3uRz7DlcDcBHufxjkvoeRzL9lM2ueF7BtpYMg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9hnRYmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87130C2BC87;
	Tue, 24 Mar 2026 13:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774357494;
	bh=RiA3l+xBx7slPIegWMGY6wmtNGD3r6+FNa36TQabvO4=;
	h=From:To:Cc:Subject:Date:From;
	b=Q9hnRYmC0NO5eUCSQDIA3sD80d5jJgcqZbJtB2XBNPDDKV+OCEU1ung0pJk95PVe7
	 IA59b0BFNUGwFLeTplujWzkvLJvfcTiiFl6rPPJup4WRsqqyizU3oYzeNSdyuK13eO
	 KdrtIac7BFvnDE6jsUok520y9SJmrGrZxRw+Tr1XpRVufpGxwAzpC4Ra8Y3pCCXCNV
	 sfdBx5BwpSTpJw2OW5ZqjiX/4sccqdaie/E4B4X8x6d8M94WPu6PENb7lb4wQU8SV/
	 1uCrmCH4j00kh8cFmtEnWBZmgwCJWgARDrMexU9AVv404UlIiHGZpL9l3h/9RJkyYb
	 oCqVxh9PvuZQg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 0/3] Avoid no-op transport enqueues
Date: Tue, 24 Mar 2026 09:04:46 -0400
Message-ID: <20260324130449.16437-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20350-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 0247F309307
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Reduce the amount of wasted work the svc thread scheduler has to do
when no work can be scheduled. Exiting threads already check for
work so no work is lost.

The three patches in this series each identify a particular scenario
where an enqueue becomes a no-op. I've also measured a slight uptick
in IOPS and data throughput as well as a drop in 50th percentile
latency for simple workloads on fast storage.

Chuck Lever (3):
  sunrpc: skip svc_xprt_enqueue when no work is pending
  sunrpc: skip svc_xprt_enqueue in svc_xprt_received when idle
  sunrpc: skip svc_xprt_enqueue when transport is busy

 net/sunrpc/svc_xprt.c | 46 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

-- 
2.53.0


