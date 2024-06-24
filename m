Return-Path: <linux-nfs+bounces-4284-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3177E915A41
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 01:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C04E0B2324E
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 23:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6551A2553;
	Mon, 24 Jun 2024 23:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ogEGcE89";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sSjqCXkP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DJ2qL0Ry";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e/cJ7BGc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDBB19FA92
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 23:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719270532; cv=none; b=Y1Ak3qEUIn6Bz2H8q/hGQQXI8k3eDLIJKWr1pgaeV/BnfVEmSGCF+D7N070wfbSKH3ByPJnlJAn95j5dOAfLoHQCOSl5oO0uaVHqAG5yfVBViaNdWxFY4RC1FB7EGDWSzh25lyQe774sFIqk/UDaq+6ONF6eVtQ59GAylfOVZrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719270532; c=relaxed/simple;
	bh=WVQvhYQBQKuRJA8OkM1Ksv1Aw1aPCYbtXOEDTSi7LKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OvhRuX1d81EpWv4Rhr52DZ6NhV8YD4cJXJXi4IVDGtBBRwufjqprl2wDcmJ3WivoFeVmiSMJCpCF0g3nvf3usptUY2gMvILeF340dX+lpxgWKW0apmE2dnoi0hJbMEte/QE4vJVSkJ/AmWi3yqgqJGDVv7Xn41LJIZ+0UWIAKaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ogEGcE89; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sSjqCXkP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DJ2qL0Ry; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e/cJ7BGc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B1FFD1F7F3;
	Mon, 24 Jun 2024 23:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719270529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WVQvhYQBQKuRJA8OkM1Ksv1Aw1aPCYbtXOEDTSi7LKk=;
	b=ogEGcE89Ak53Yi4TQTOCFdrfmAZo6ew9YktdZBPhTQo5q0f3mXWcokfiVOVPhhb6fq+8ck
	WzqrxpVo8JdJnV59IL8Qla64eJFtBJ2SC6X2oongUn+vPZqU39GsD+iHejf+N1hnXIlvZf
	kFX/99oqgyqo5366fxq1O0WuPumPAho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719270529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WVQvhYQBQKuRJA8OkM1Ksv1Aw1aPCYbtXOEDTSi7LKk=;
	b=sSjqCXkPRBGHw2tDbcDp4KCRIF1xP+DlMUICImBo6nTi/M1u5V3KIYjnyTY1Fqsx7pnhsP
	JsifxlqcR7LQ7TAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719270527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WVQvhYQBQKuRJA8OkM1Ksv1Aw1aPCYbtXOEDTSi7LKk=;
	b=DJ2qL0RyRzqqkhi/YmGLm/sb5cQ5wbZD0ST2WXLmUMc1VZIc7+yRAtUFt+hy7HzT7Nh5HZ
	WE4QSJgRfFi2i1V4pmF4eHREhWyWQJTZfOkRLhcC9QpXILaEQsUCJvM3N3w294pSdSuWEc
	qqBYbtgrdDrNO8OvV9VvSR4nQqFDkdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719270527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WVQvhYQBQKuRJA8OkM1Ksv1Aw1aPCYbtXOEDTSi7LKk=;
	b=e/cJ7BGc4KNx95va+hOfibGrYoHVU2TTtrcX3Xke4kE591Q62kVUjj6AmnGhx45NbA4xVT
	ClNyIC9z9c+Iu9Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FAA41384C;
	Mon, 24 Jun 2024 23:08:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +3jcLHz8eWZiGwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 24 Jun 2024 23:08:44 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/2] nfsd: proper fix for NULL deref in svc_pool_stats_start()
Date: Tue, 25 Jun 2024 09:04:55 +1000
Message-ID: <20240624230734.17084-1-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.60
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.60 / 50.00];
	BAYES_HAM(-2.80)[99.13%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

A recent patch attempted to fix a NULL pointer deref but introduced a
different NULL pointer deref and a possible unbalance unlock.

This series fixes the bug correctly and reverts the faulty fix.

(Sorry for not reviewing this patch earlier)

NeilBrown

 [PATCH 1/2] nfsd: initialise nfsd_info.mutex early.
 [PATCH 2/2] Revert "nfsd: fix oops when reading pool_stats before

