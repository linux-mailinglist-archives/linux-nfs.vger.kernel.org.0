Return-Path: <linux-nfs+bounces-9918-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F69A2BA8D
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 06:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A73317A2C51
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 05:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59D614F9C4;
	Fri,  7 Feb 2025 05:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xvFxJ78v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="08HKjXm6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xvFxJ78v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="08HKjXm6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062F963D
	for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2025 05:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738905436; cv=none; b=Qs9g2h3bHoizuIE9wAi9q0qNCC8uNZ0ODG+SSFLdRZ4/xGSOra9ccYwdV8LmCy/f4WNA/j5nPCSP3NSMcn54WuHfTMOsPxN5PfJVUsL4JJQN5IjEg1XYRRAfTCJWUsns0W01V4bu27aHsBrdqjfHwkfzs1krRn8lvn++XXdBnCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738905436; c=relaxed/simple;
	bh=gkxN/iqdd66sdjlrEpOn2fppvL0GLaCxU+ab3NdQKxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kqeCY1Mi7Nj+DMEk9G78/97jdLDVfraYw2/8CuFnKzFik5QbLjke4b2ODBhnVYlEvtl7TuF+UGwLC8IglEjFGekKjPGcq5rpL1Q5KruDkyOi5IBMxTGWcXMCMGvTH+mM3titM/XxqAO/ZahfvvDNRR03R+RgxSdaucM/OznmIMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xvFxJ78v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=08HKjXm6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xvFxJ78v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=08HKjXm6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C4DC21133;
	Fri,  7 Feb 2025 05:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738905432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gkxN/iqdd66sdjlrEpOn2fppvL0GLaCxU+ab3NdQKxw=;
	b=xvFxJ78v9jPtkNfEixe6wmu1UyxMeGxtF9M/BeBU3N15PWgILzO07ctj5tkAzFHm3IzzwU
	4pUkSiwgQAJ2IKTmVF+0sQI16HOLPnuzcIxTb7fM6uD9wmcW6bS1gIH92Nc+RtasrYTYBG
	pcrZjfHAJHQXDD/RBMQJXvXwBR93G3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738905432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gkxN/iqdd66sdjlrEpOn2fppvL0GLaCxU+ab3NdQKxw=;
	b=08HKjXm6YyFXhe7LuvhzoBWo/ZHekRjHsQ3YVa25bmcp61Hgy/rx8q2Vh2/r/+JwfVXMnL
	l+njtsT/rJ/M4wAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xvFxJ78v;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=08HKjXm6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738905432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gkxN/iqdd66sdjlrEpOn2fppvL0GLaCxU+ab3NdQKxw=;
	b=xvFxJ78v9jPtkNfEixe6wmu1UyxMeGxtF9M/BeBU3N15PWgILzO07ctj5tkAzFHm3IzzwU
	4pUkSiwgQAJ2IKTmVF+0sQI16HOLPnuzcIxTb7fM6uD9wmcW6bS1gIH92Nc+RtasrYTYBG
	pcrZjfHAJHQXDD/RBMQJXvXwBR93G3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738905432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gkxN/iqdd66sdjlrEpOn2fppvL0GLaCxU+ab3NdQKxw=;
	b=08HKjXm6YyFXhe7LuvhzoBWo/ZHekRjHsQ3YVa25bmcp61Hgy/rx8q2Vh2/r/+JwfVXMnL
	l+njtsT/rJ/M4wAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 936B813694;
	Fri,  7 Feb 2025 05:17:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W9fyEVWXpWfsFgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 05:17:09 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH 0/6] nfsd: filecache: various fixes
Date: Fri,  7 Feb 2025 16:15:10 +1100
Message-ID: <20250207051701.3467505-1-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0C4DC21133
X-Spam-Level: 
X-Spamd-Result: default: False [-2.99 / 50.00];
	BAYES_HAM(-2.98)[99.92%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.99
X-Spam-Flag: NO

hi all,
 following is my attempt to fix up shrinking and gc of the NFSv3 filecache entries.
 There series is against nfsd-next.

 What do you think?

Thanks,
NeilBrown



