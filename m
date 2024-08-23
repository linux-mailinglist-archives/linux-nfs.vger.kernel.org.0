Return-Path: <linux-nfs+bounces-5596-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B19395C259
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 02:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F6A1F215CE
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 00:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6A9195;
	Fri, 23 Aug 2024 00:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J5oNZSyF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4CSdgPco";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J5oNZSyF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4CSdgPco"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB41AB66F
	for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 00:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724372617; cv=none; b=UF3e2vZiptUnfa5wmq1ptYbIlK2F2Zzb/iQ/aaAShHVQepsz9l9ve1I0XikUOP4w87P9X9PA055xMQDWv7Y1HaKhAf4UBIeCeLzMFBK7Qd++6v4GR7p+luapyc9yr4Ujp7mi2eo3SnzPgAuTTWvo8avWD6zIBs5nhZTTOxPcTAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724372617; c=relaxed/simple;
	bh=07EAmeOFNe6Nfcx+frMNULqjf0BvXO35kwzF4Ss+Ay4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AHmCnaZjL+I6XaR59OhfDI5q/1xTn2tNUykNpqCM/ZmAy5x5TTl3W0ea2IOaf6QplwymLgcKn24NmAA9cM5za/yND/8leDOkHUUPf1sH80kxpmoAmfjgOpx5duZa82QIkY12lvzXNLwpURX23KTVTusTF1gDJDDX/sTX24RUGic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J5oNZSyF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4CSdgPco; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J5oNZSyF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4CSdgPco; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0390420273;
	Fri, 23 Aug 2024 00:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724372614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BD6STLF3vvGKXiZaoSsM8FQ3lrgUjfbKAu7d7W7PttE=;
	b=J5oNZSyFEdXWYVhX1XzZxd2B58J7lOqheY0GThlej7f+udpNw+MUh9UJV1JE4Zie5QUfkV
	Zyy5iN2dOXCSLa0MChhoctTpMWhRmvZfkjGRCI4Zff0uPHQYC9Odnqq/kgST4eyxr+vqWO
	Vy78WI23/eYnU7FDE8CBpMCQ8UmpXy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724372614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BD6STLF3vvGKXiZaoSsM8FQ3lrgUjfbKAu7d7W7PttE=;
	b=4CSdgPcoWtCla7HI/hwZSxn/1oqXpzPU27aJqTSIOwHJckgz2e4eio+nBKL6MjfcrnspK0
	QcsGGpM0hFfhkmBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724372614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BD6STLF3vvGKXiZaoSsM8FQ3lrgUjfbKAu7d7W7PttE=;
	b=J5oNZSyFEdXWYVhX1XzZxd2B58J7lOqheY0GThlej7f+udpNw+MUh9UJV1JE4Zie5QUfkV
	Zyy5iN2dOXCSLa0MChhoctTpMWhRmvZfkjGRCI4Zff0uPHQYC9Odnqq/kgST4eyxr+vqWO
	Vy78WI23/eYnU7FDE8CBpMCQ8UmpXy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724372614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BD6STLF3vvGKXiZaoSsM8FQ3lrgUjfbKAu7d7W7PttE=;
	b=4CSdgPcoWtCla7HI/hwZSxn/1oqXpzPU27aJqTSIOwHJckgz2e4eio+nBKL6MjfcrnspK0
	QcsGGpM0hFfhkmBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0184139D3;
	Fri, 23 Aug 2024 00:23:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zcwHLoXWx2bwBwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 23 Aug 2024 00:23:33 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-nfs@vger.kernel.org
Cc: libtirpc-devel@lists.sourceforge.net,
	Petr Vorel <pvorel@suse.cz>,
	Steve Dickson <SteveD@RedHat.com>,
	Josue Ortega <josue@debian.org>,
	NeilBrown <neilb@suse.de>,
	Thomas Blume <Thomas.Blume@suse.com>,
	Yann Leprince <yann.leprince@ylep.fr>
Subject: [PATCH rpcbind 0/4] Update systemd/rpcbind.service.in
Date: Fri, 23 Aug 2024 02:23:18 +0200
Message-ID: <20240823002322.1203466-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.19 / 50.00];
	BAYES_HAM(-2.41)[97.28%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.18)[-0.892];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_HAS_DN(0.00)[]
X-Spam-Score: -2.19
X-Spam-Flag: NO

Hi,

NOTE I'm not systemd expert, others may understand more.

But trying to upstream various hardenings options which we have been
using since 2021. Adding EnvironmentFile I tested locally today.
systemd-tmpfiles-setup.service should be also safe.

Kind regards,
Petr

Josue Ortega (1):
  man/rpcbind: Add Files section to manpage

Petr Vorel (3):
  systemd/rpcbind.service.in: Add few default EnvironmentFile
  systemd/rpcbind.service.in: Add various hardenings options
  systemd/rpcbind.service.in: Want/After systemd-tmpfiles-setup

 man/rpcbind.8              |  8 ++++++++
 systemd/rpcbind.service.in | 16 +++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.45.2


