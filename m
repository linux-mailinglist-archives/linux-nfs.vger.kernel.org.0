Return-Path: <linux-nfs+bounces-5600-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C0E95C25D
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 02:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01AEF1F23567
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 00:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F874B679;
	Fri, 23 Aug 2024 00:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iA+6lXFz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="70ohfEDs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s6cBd78n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9IG/Ozzd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F370C148
	for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 00:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724372620; cv=none; b=aa6TlMq1L3a2qzolf4Sj/marclwXeAVYON9jUvO4qnZ1109i1ikpy3H9uG6MCOF1p3byvKvjCpqKQb/0DaztMMBaHCjm95B8ZjZ8OuYe1h42VJyMS5kSsKdHNXY31VRne3E1Q1czqbcY99s9ADoA1xWRzCU8yHpYQV8iieNJMD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724372620; c=relaxed/simple;
	bh=M+UUGhc2nUZ4JX/VsKfAPjTpOyC12DJbP+GIgunJRjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkeRk/zX6454MsUW+D1m6xEYi8vwi5X+GmewUyCuDnot/JMvJv8IcsG0apJaJnZQ2nBucf/77FSbIjIJdDMy4vvrOU0dzvUItjfkJP/wkub8r1EhPfQD1z8Weqx0yAWuJVve0mJfTfIvI01g6uDLg2p8N7BjzVo3oISwENjtQOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iA+6lXFz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=70ohfEDs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s6cBd78n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9IG/Ozzd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9E0D2255C;
	Fri, 23 Aug 2024 00:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724372615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIWqfsXp4Sn9wxiS2ywi6rnDCzqv92s0X3Bgrp6gS/U=;
	b=iA+6lXFzKAienQ9dK99DL85DJUxJCrKUntcMX8RQnSrAtOIHfrYIQpJpvwUjXRCM0+73R/
	mKi7QzaVZjkrYf3qXleLidFG5NE23rqEQOU6+SoVhK7zDBajTzwkV1VMO3M6qr621ZuRtP
	MCFcxcBwSc47aix8mxbBo5RrJTZ0RN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724372615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIWqfsXp4Sn9wxiS2ywi6rnDCzqv92s0X3Bgrp6gS/U=;
	b=70ohfEDsTHIwNJ+fPwBDdsB1hKYcsgBTip4VuRvyLQZILzHHeLacaso6KgZcsCYmB77VFH
	N2SAiPNH0niPEKCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724372614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIWqfsXp4Sn9wxiS2ywi6rnDCzqv92s0X3Bgrp6gS/U=;
	b=s6cBd78n5oTttzGCfZa2tqnUIN16kXBlL1Ct3Vpf2SzdDoBmk+FMDVdGGEVzlAN23TWOCc
	QGz8yCXaWyFYmFrzPB9VVQd3fJfmM/j3vozJqeKTXs2cFVmkNryVFW5HOhyf6JUZ4nfT27
	/sKUuLIglvmjZMMFxknr3K2eOHMEn4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724372614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIWqfsXp4Sn9wxiS2ywi6rnDCzqv92s0X3Bgrp6gS/U=;
	b=9IG/OzzdDCb/C+jhjJMdXO+a5orCx2DfY5CA/PvF4lduaMcwoupMYc8ZI4AQkXuib0HgvY
	OlE9dnqEa01iUtBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C036A139D3;
	Fri, 23 Aug 2024 00:23:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CEMnLobWx2bwBwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 23 Aug 2024 00:23:34 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-nfs@vger.kernel.org
Cc: libtirpc-devel@lists.sourceforge.net,
	Petr Vorel <pvorel@suse.cz>,
	Steve Dickson <SteveD@RedHat.com>,
	Josue Ortega <josue@debian.org>,
	NeilBrown <neilb@suse.de>,
	Thomas Blume <Thomas.Blume@suse.com>,
	Yann Leprince <yann.leprince@ylep.fr>
Subject: [RFC][PATCH rpcbind 4/4] systemd/rpcbind.service.in: Want/After systemd-tmpfiles-setup
Date: Fri, 23 Aug 2024 02:23:22 +0200
Message-ID: <20240823002322.1203466-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240823002322.1203466-1-pvorel@suse.cz>
References: <20240823002322.1203466-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.79 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.938];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLbne46a3kcd13catcztqqtt6y)];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.79
X-Spam-Flag: NO

Add Want/After systemd-tmpfiles-setup.service. This is taken from Fedora
rpcbind-0.2.4-5.fc25 patch [1] which tried to handle bug #1401561 [2]
where /var/run/rpcbind.lock cannot be created due missing /var/run/
directory. But the suggestion to add RequiresMountFor=... was
implemented in ee569be ("Fix boot dependency in systemd service file").

But even with RequiresMountsFor=/run/rpcbind in rpcbind.service and
/run/rpcbind.lock there is error on openSUSE Tumbleweed with rpcbind
1.2.6:

rpcbind.service: Failed at step NAMESPACE spawning /usr/sbin/rpcbind: Read-only file system

Adding systemd-tmpfiles-setup.service fixes it.

NOTE: Debian uses for this purpose remote-fs-pre.target (also works, but
systemd-tmpfiles-setup.service looks to me more specific).
openSUSE uses only After=sysinit.target as a result of #1117217 [3]
(also works).

[1] https://src.fedoraproject.org/rpms/rpcbind/blob/rawhide/f/rpcbind-0.2.4-systemd-service.patch
[2] https://bugzilla.redhat.com/show_bug.cgi?id=1401561
[3] https://bugzilla.suse.com/show_bug.cgi?id=1117217

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 systemd/rpcbind.service.in | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/systemd/rpcbind.service.in b/systemd/rpcbind.service.in
index 272e55a..771b944 100644
--- a/systemd/rpcbind.service.in
+++ b/systemd/rpcbind.service.in
@@ -7,7 +7,8 @@ RequiresMountsFor=@statedir@
 # Make sure we use the IP addresses listed for
 # rpcbind.socket, no matter how this unit is started.
 Requires=rpcbind.socket
-Wants=rpcbind.target
+Wants=rpcbind.target systemd-tmpfiles-setup.service
+After=systemd-tmpfiles-setup.service
 
 [Service]
 ProtectSystem=full
-- 
2.45.2


