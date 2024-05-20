Return-Path: <linux-nfs+bounces-3287-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43928C982F
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2024 05:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505341F221F4
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2024 03:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DF8DDAB;
	Mon, 20 May 2024 03:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yiFkdphc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R0i9pWoW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yiFkdphc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R0i9pWoW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCF1DDA3
	for <linux-nfs@vger.kernel.org>; Mon, 20 May 2024 03:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716175104; cv=none; b=FyW2C9guIDvJ47yBVP9+8Apiqexz062hbjQHLllLdKVCf4tObq7EZJADzmZLLl2PK9TO8dHLCCnVy3OJ3yeUQc2BiFaVLjIrZDCTYDyxVJg/T/wRY+Uw2pnMeOhqsHh49BdjVBUx6rtluQnV6UEuuqSWpLYPKxGspgaA24B8BrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716175104; c=relaxed/simple;
	bh=zg6fi4EPv9hhN9+027OpjZUM3lo8iieaBZbOQzKtOOs=;
	h=Content-Type:MIME-Version:From:To:Subject:Date:Message-id; b=BAzkmeRGEot8nrTw9m0/mzj8/VOG/NTI1TFibwZS6AF0WzChjQsq09j7lClWeFE+LQtnFdJ8ye0H4ekBoQLdgVptvGOAbhkvhTfOAQ1ho8aaP1Gpdyuu/YoJcBv9T1kN4VOhBa4TUE1uPRWCspQPojaITanI6gDB16MMt0uJ6Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yiFkdphc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R0i9pWoW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yiFkdphc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R0i9pWoW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 61D1820A2B
	for <linux-nfs@vger.kernel.org>; Mon, 20 May 2024 03:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716175094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KwpJ+hkC7Qy0HzauM9T7+/0pqFQZ3o6IL3fviMtujto=;
	b=yiFkdphc7Mq5ewNQtKfo+Xhq2PH8DhZP4s43ScuSvF6bMOd65CNY3wKpUZaovJ6APyG/2L
	J/+qWZZm5/huYx3ZXGXpd1fhsGQshcTdp0EQxw4b8/gbuVzTfmdXaTZRkCr+Oh7BG2X/lF
	h0Q7DILDTHEZELAXUPMPYElQTV8BCYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716175094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KwpJ+hkC7Qy0HzauM9T7+/0pqFQZ3o6IL3fviMtujto=;
	b=R0i9pWoWcmKZfT5jDaOgrMJhs2WQAJg33Pa8WNUHgYIiqSbBvNe8XLnhhOZ/GO+4E0+QK+
	zRcb4nQ39vXPoTCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yiFkdphc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=R0i9pWoW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716175094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KwpJ+hkC7Qy0HzauM9T7+/0pqFQZ3o6IL3fviMtujto=;
	b=yiFkdphc7Mq5ewNQtKfo+Xhq2PH8DhZP4s43ScuSvF6bMOd65CNY3wKpUZaovJ6APyG/2L
	J/+qWZZm5/huYx3ZXGXpd1fhsGQshcTdp0EQxw4b8/gbuVzTfmdXaTZRkCr+Oh7BG2X/lF
	h0Q7DILDTHEZELAXUPMPYElQTV8BCYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716175094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KwpJ+hkC7Qy0HzauM9T7+/0pqFQZ3o6IL3fviMtujto=;
	b=R0i9pWoWcmKZfT5jDaOgrMJhs2WQAJg33Pa8WNUHgYIiqSbBvNe8XLnhhOZ/GO+4E0+QK+
	zRcb4nQ39vXPoTCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96CD01378C
	for <linux-nfs@vger.kernel.org>; Mon, 20 May 2024 03:18:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X+UoDvXASmbmeQAAD6G6ig
	(envelope-from <neilb@suse.de>)
	for <linux-nfs@vger.kernel.org>; Mon, 20 May 2024 03:18:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: linux-nfs@vger.kernel.org
Subject: When are layouts destroyed on server reboot
Date: Mon, 20 May 2024 13:18:05 +1000
Message-id: <171617508551.18863.10945867499281791407@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -5.03
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 61D1820A2B
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.03 / 50.00];
	BAYES_HAM(-2.52)[97.82%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]



Hi,
 I have a customer who is experiencing a problem on an older kernel.
 After a server restart (actually a cluster fail-over) the client
 recovers all opens and locks correctly, but then sends a (previously
 queued) WRITE request with a filehandle/stateid for a LAYOUT that was
 provided by the server before the restart.  Unsurprisingly this doesn't
 work.

 I've been hunting through the code to find out where the code attempts
 to invalidate all layouts as required by 12.7.4 in RFC-5661.  But I
 cannot find it.

 I'm guessing that adding a call to pnfs_destroy_layout() in
 __nfs4_reclaim_open_state() would do the trick but maybe there is a
 better way that is already implemented in later kernels, that I cannot
 find.

 Any pointers?

Thanks,
NeilBrown

