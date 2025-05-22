Return-Path: <linux-nfs+bounces-11859-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0E3AC0526
	for <lists+linux-nfs@lfdr.de>; Thu, 22 May 2025 09:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D921BA3522
	for <lists+linux-nfs@lfdr.de>; Thu, 22 May 2025 07:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BB7482EB;
	Thu, 22 May 2025 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="orRe7s9j";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WHIUYiIJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C963535893
	for <linux-nfs@vger.kernel.org>; Thu, 22 May 2025 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897319; cv=none; b=sbDp1Jjm5w+WMMkaaFSUfcMp6lV2EuroArZ2IMcE2Be7+Ioj0cRNNcTuQBjFC3CT5P6uIbe7a/ZWgK2szsAQ6D0ZX54TJVAmpxy8QwhAr0kGcJGJEgpIWsvTKOI2zsMgDqqsuwwBsRTvu/olHhTVAuIwql6EJ7grywDPuBxRTSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897319; c=relaxed/simple;
	bh=SXdqb4l0hMf96eSZC9K9XD26rBj7CeXpkLvJqn0IgPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Co0x08UTLqRBrcsJ+31YdeMBGG+0YRPGBc/AqvACPw9Nc6g8HpcR6xqJzKvgsr+HMKpf7N0vqwyE/ombDjXedgAqVtF0+QzxQ8SQC0MS1i1CePJ2egFzJZP5+m6C5/selzOMXAQNu3x3yNZWT8eBPXouEE4W+ZU99DD/oHkDJjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=orRe7s9j; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WHIUYiIJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A42E4339AC;
	Thu, 22 May 2025 07:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747897315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ik+WQKpq2stPPi5hOavOanwaFdhahyJkxVmA+a2Jtjg=;
	b=orRe7s9jPa2MXyaGJ1gQCLWzlUhYIKONvnOG0vALaO7Wzy2UGyq7gWJNDlndQHTu8pFoLU
	wNHL6Sxs/ryc7G2jMhSlzJNvJxY7p0w9bZL3naxINaPfNIav7c4CzzMr7qF/u0bHC7lHk0
	QwUxyFcqhK/hKtIfewQqZyejHR9KXc8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747897314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ik+WQKpq2stPPi5hOavOanwaFdhahyJkxVmA+a2Jtjg=;
	b=WHIUYiIJzGAscdrcBF3QIkAd8swOKGTFazHrH9RVoja8Ymae9ArbD+EzqViKWou0pc7crh
	F5x7ahIu6S4HHGV+n95bVHWSEZk39qocUg5a/9kZgK8n2arDGxaanaor4ToFU77p19chvh
	P8aNDLIYi8SvTD8VKBI++eLL8Qj1XN0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DC9513433;
	Thu, 22 May 2025 07:01:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eDWXC+LLLmgHBQAAD6G6ig
	(envelope-from <antonio.feijoo@suse.com>); Thu, 22 May 2025 07:01:54 +0000
From: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
To: linux-nfs@vger.kernel.org
Cc: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
Subject: [PATCH 1/2] systemd: Allow nfs-idmapd.service to be started without the server
Date: Thu, 22 May 2025 08:59:09 +0200
Message-ID: <39e5050139e77397037f67705cf9d97fbe6a1520.1747753109.git.antonio.feijoo@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747753109.git.antonio.feijoo@suse.com>
References: <cover.1747753109.git.antonio.feijoo@suse.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	REPLY(-4.00)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid,network-online.target:url,local-fs.target:url];
	RCVD_TLS_ALL(0.00)[]

rpc.idmapd may be needed in the client if nfs4_disable_idmapping is
set to 0. By replacing BindsTo= with PartOf=, nfs-idmapd.service can
be started independently, and also affected if nfs-server.service is
started or stopped.

Signed-off-by: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
---
 systemd/nfs-idmapd.service | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/systemd/nfs-idmapd.service b/systemd/nfs-idmapd.service
index d820f10c..3afdcea0 100644
--- a/systemd/nfs-idmapd.service
+++ b/systemd/nfs-idmapd.service
@@ -6,7 +6,7 @@ Requires=rpc_pipefs.target
 After=rpc_pipefs.target local-fs.target network-online.target
 Wants=network-online.target
 
-BindsTo=nfs-server.service
+PartOf=nfs-server.service
 
 [Service]
 Type=forking
-- 
2.43.0


