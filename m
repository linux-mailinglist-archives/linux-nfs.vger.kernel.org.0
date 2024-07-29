Return-Path: <linux-nfs+bounces-5123-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C007A93EB17
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 04:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4853DB208B1
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 02:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2FA2BD04;
	Mon, 29 Jul 2024 02:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xvr3zWrG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iOlgovPL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xvr3zWrG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iOlgovPL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2621B86D6
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 02:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219701; cv=none; b=TieMmcogJhY9CxokU/Ojd+aHSEhNZbf2zveWAT1ACRfDluO2yj1se5NUzAmbB4Z5X1zD/PHqvzMNkyRPjkSNlBQQOc913u5hWaJk7hBIacqO8hk60lkgN1PNvRvq7Ybsw/M5GfoZZqhCb77EEA47AD5pf3N8rgMPVuoEOcO1DxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219701; c=relaxed/simple;
	bh=ta4pY1Si5ay5ToH0l9nWJ189IpL2eP+Y4/+u3DwxTqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4eU7FV1NNE4zr1nK+O8j7capcV5Z+NaKum6I/6xyUP6SDvHP/BTgWJ8kRSSJoPrZf0kRsywjVP2V57944k3fIQ+s9ugVcfDTNGBUPEajLJ7Je2mjE8VYZ9HMpMqhYv0xgBbMiC0CBFmUuj2bNVbrPpFPXdQlmEqr9q6ArfdIi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xvr3zWrG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iOlgovPL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xvr3zWrG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iOlgovPL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2795121B48;
	Mon, 29 Jul 2024 02:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722219698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+UCedhh3w0M5pWTm36YQJMsCSPJM+kUX4bUmC9ByxW8=;
	b=xvr3zWrGgCDDJAMrIYwUzheGUwBRXL/DnhXiSQ6rU8y81I7AlFO+/j85mbuuS6dVGUffIZ
	V/rhW3zA5FKws7F4DjE3wbQRGvhRpG1uDM/KHhWogpDFhSaIYVFYHym1EWeWuNZYKmx5Mp
	kmsY73FZcIiylzfSy8GuB/0RYyzr9Tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722219698;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+UCedhh3w0M5pWTm36YQJMsCSPJM+kUX4bUmC9ByxW8=;
	b=iOlgovPLRwgyfkKhnrweOsfVSXuaAS7Mw9lRIM6e9h55XJq8tGp7ZNA3wXwppaoa/4InTS
	Bhr/Rngaw/XzVbAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xvr3zWrG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iOlgovPL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722219698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+UCedhh3w0M5pWTm36YQJMsCSPJM+kUX4bUmC9ByxW8=;
	b=xvr3zWrGgCDDJAMrIYwUzheGUwBRXL/DnhXiSQ6rU8y81I7AlFO+/j85mbuuS6dVGUffIZ
	V/rhW3zA5FKws7F4DjE3wbQRGvhRpG1uDM/KHhWogpDFhSaIYVFYHym1EWeWuNZYKmx5Mp
	kmsY73FZcIiylzfSy8GuB/0RYyzr9Tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722219698;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+UCedhh3w0M5pWTm36YQJMsCSPJM+kUX4bUmC9ByxW8=;
	b=iOlgovPLRwgyfkKhnrweOsfVSXuaAS7Mw9lRIM6e9h55XJq8tGp7ZNA3wXwppaoa/4InTS
	Bhr/Rngaw/XzVbAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDA5313704;
	Mon, 29 Jul 2024 02:21:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0AbUJ6/8pmbCHQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jul 2024 02:21:35 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/2] nfsd: fix handling of error from unshare_fs_struct()
Date: Mon, 29 Jul 2024 12:18:19 +1000
Message-ID: <20240729022126.4450-1-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2795121B48
X-Spam-Score: -2.81
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.81 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

These two patches replace my previous patch:
 [PATCH 07/14] Change unshare_fs_struct() to never fail.

I had explored ways to change kthread_create() to avoid the need for
GFP_NOFAIL and concluded that we can do everything we need in the sunrpc
layer.  So the first patch here is a simple cleanup, and the second adds
simple infrastructure for an svc thread to confirm that it has started
up and to report if it was successful in that.

Thanks,
NeilBrown



 [PATCH 1/2] sunrpc: merge svc_rqst_alloc() into svc_prepare_thread()
 [PATCH 2/2] sunrpc: allow svc threads to fail initialisation cleanly

