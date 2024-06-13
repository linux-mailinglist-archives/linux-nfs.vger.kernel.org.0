Return-Path: <linux-nfs+bounces-3743-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D88B9066C1
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 10:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FEC1F232E2
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 08:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF9614264A;
	Thu, 13 Jun 2024 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qst3DPl0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tGwHMXvO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w1CdRhxf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rCIchcfM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1275013E030
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267321; cv=none; b=S5vKgEBg4ZpNdEtz4uJk0GHAI++1pbffE0AcHBN2Qa1rIKeVXP5mDQD0Nl8uv3/eyg4GySnGLPehEQaNT4nutUPNMUUsiJeFNU3OA8/ulNmD9iER5+4Jk6HXnYs9nafQ+QxtSsMwIw3EWlC2Bmx+l0OtxgZtpuJh35vYlHQm1oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267321; c=relaxed/simple;
	bh=nMTCTFZCk8jJdwDnaPVunAd5+RPRhpnhtPIUEQEYIRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lf7oItBDOiOmsB4z3k4vrVCH+WV9Zvn2QSowCjECYXx9e9o4htG5U9GtOqs9DIcWpPzWQ+WFjcKcc7TOSVqD+2pcF/yq/qAmioxsxh0V0hfxDRK/t6Zz4bs11NoEUQ6wkGgz/2sFbzvftBYsqApJYyKo/AtXaKTUHZtjSun4tPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qst3DPl0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tGwHMXvO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w1CdRhxf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rCIchcfM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D955F5D006;
	Thu, 13 Jun 2024 08:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718267318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=A8KThnrSKY5mD4diBjbQR2NfaacmbNc7/WJuV+8WFM4=;
	b=qst3DPl0vj9Vu1lVtjg8ShdojzEEIL+nwr8mo0HSbv88Q2KglXQuBoTvwCIAbXTiBLXy02
	3UW8AA8DzEU1olt+za7kYeT24AXwiNCfNR3IanG2Zcjp2KyT7AdJd9sI2FAX0Yos+hvfph
	nQ9CMPLv1edUO7S314qJi/W9NtmjSN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718267318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=A8KThnrSKY5mD4diBjbQR2NfaacmbNc7/WJuV+8WFM4=;
	b=tGwHMXvOSPNRYp2zMc7e5dlKkUXL/3DeLrqgC+E+yxJhY1w6kTYe4myTFu72RkHUPdBJ09
	OlFtCwGFyN9KGyCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=w1CdRhxf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rCIchcfM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718267316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=A8KThnrSKY5mD4diBjbQR2NfaacmbNc7/WJuV+8WFM4=;
	b=w1CdRhxftOfrFxWRwkkZQ/cC50LZ814cGmDYNBduX7uKiJONac4BZwgV0dROfsWo9/SIAQ
	Dpad8vwojcVpBfqZwJKQW+sRu73wzTEaPKoAo+q1G+5bXQ26Ql0dJzjMLXug8UQIGSUVqY
	8hP/6nKtuH0G5rPNUcau/JwYBrKbUzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718267316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=A8KThnrSKY5mD4diBjbQR2NfaacmbNc7/WJuV+8WFM4=;
	b=rCIchcfMp9JNVt595QLy5ISU5RBdROAEmklQ5stpWe7QuzF8WJ29HPvlBMQJWg6QwSeYOC
	QQFIi/3jaOqpb5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDF3C13A7F;
	Thu, 13 Jun 2024 08:28:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kn1DMrStamY5XAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 13 Jun 2024 08:28:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 765A7A0870; Thu, 13 Jun 2024 10:28:21 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Neil Brown <neilb@suse.de>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3] nfs: Improve throughput for random buffered writes
Date: Thu, 13 Jun 2024 10:28:16 +0200
Message-Id: <20240612153022.25454-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=618; i=jack@suse.cz; h=from:subject:message-id; bh=nMTCTFZCk8jJdwDnaPVunAd5+RPRhpnhtPIUEQEYIRY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmaq2buBT8EuMwJ8GpcKyjt6eb0JQmXb9hGfD+st/p c1Qnps+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZmqtmwAKCRCcnaoHP2RA2UKFB/ 9+YRf2PvdMn4EOFap87sGJ1MipeUyk9NLnFZf4+5JdpVH0ixRZrBgWunK9BDtakagr3nByoBaVqG7I 3ZxDwKHXjdGzuWts9Thwq+j88betzQMmfrCkLjwYKGWMInMMlJnrt5tJ/jQWyqZ5QssIQK1DEzLttH ZPL8hOkQgrs4BCK4Xc4QEOXz4DGzFECLVNZOiWO0Io+wDatDvf9a02irj1NawgmUPos5VgSalsnkgX n2z868TZBc8yxAeASO2vByaoWAZiPZ0TXh4b1yGsFNq7Ms7XNnIvJGDTHGKwixrhhIrKjeoqqjFBj6 MH1FwfotyFxbfRfj7m5f7NluQfJcdv
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-2.00)[95.06%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D955F5D006
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Spam-Level: 

Hello,

I was thinking how to best address the performance regression coming from
NFS write congestion. After considering various options and concerns raised
in the previous discussion, I've got an idea for a simple option that could
help to keep the server more busy - just mimick what block devices do and
block the flush worker waiting for congestion to resolve instead of aborting
the writeback. And it actually helps enough that I don't think more complex
solutions are warranted at this point.

This patch series has two preparatory cleanups and then a patch implementing
this idea.

								Honza

