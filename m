Return-Path: <linux-nfs+bounces-2189-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2B287104C
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 23:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6041F21949
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 22:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEDB1C6AB;
	Mon,  4 Mar 2024 22:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w1YtvC8x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jiIMu+re";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w1YtvC8x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jiIMu+re"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF23C28
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 22:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592451; cv=none; b=hxMKcRWjBCugJnhuujvlVYS/MMsCWQvShSJYql2yBY/k2OwubRm8vWAkFH9fZy0YLRE314d4m4XshcroU7R+ZBBbk7TecHlU0LoaJ2P+2BaH83riF+8AeCjyRhu64eS/2GnQd8okxx4tJ72iENQHnxAC55b5A4zT4lrOFTQqAI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592451; c=relaxed/simple;
	bh=chur+EFAgDnlqjxLwr6qwmfyrWqZHtCo9SvTBxUUlKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qSgEe79TY2X2VcL+f7gDAnwNydtk5bxR4zGFbNTvdaRoFNoMb0S/pe80nEo9B84DatFsc9G5v8wQmrG7DthhNtPAreZk5CvMVNdDieC6u9kNNGjkO+6JXyypckPAMQij516dmC6478i1ia979MwJfr/hO/A2BLZa+GRJohNhs90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w1YtvC8x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jiIMu+re; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w1YtvC8x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jiIMu+re; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47A3F3501B;
	Mon,  4 Mar 2024 22:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709592448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=chur+EFAgDnlqjxLwr6qwmfyrWqZHtCo9SvTBxUUlKk=;
	b=w1YtvC8x0ADkRHhhQNMwj8JVky4xaTIq9jbmVIgoC4phNgTS9tIJ+G3AQm8H6O93uMEkqp
	/DQIRNUyiJ82JVxjxC9/H6/YcKwcQ3XGqQUbnJ/4aPFNv4rrsHwJpicDL/2mpCburRKNif
	1ATRNT96XqW48EIHeHDoE+rm+wuDDoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709592448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=chur+EFAgDnlqjxLwr6qwmfyrWqZHtCo9SvTBxUUlKk=;
	b=jiIMu+re+GJ+7DHFQAUA0H4d3BEVvYPNnZW09ph8pkQMHSwGWjhOpqCxCx8HEnzMq49VZR
	Qz7bBZQP241SVzCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709592448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=chur+EFAgDnlqjxLwr6qwmfyrWqZHtCo9SvTBxUUlKk=;
	b=w1YtvC8x0ADkRHhhQNMwj8JVky4xaTIq9jbmVIgoC4phNgTS9tIJ+G3AQm8H6O93uMEkqp
	/DQIRNUyiJ82JVxjxC9/H6/YcKwcQ3XGqQUbnJ/4aPFNv4rrsHwJpicDL/2mpCburRKNif
	1ATRNT96XqW48EIHeHDoE+rm+wuDDoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709592448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=chur+EFAgDnlqjxLwr6qwmfyrWqZHtCo9SvTBxUUlKk=;
	b=jiIMu+re+GJ+7DHFQAUA0H4d3BEVvYPNnZW09ph8pkQMHSwGWjhOpqCxCx8HEnzMq49VZR
	Qz7bBZQP241SVzCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5AC213A5B;
	Mon,  4 Mar 2024 22:47:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jwMTEn1P5mUOYgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Mar 2024 22:47:25 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/4 v3] nfsd: fix deadlock in move_to_close_lru()
Date: Tue,  5 Mar 2024 09:45:20 +1100
Message-ID: <20240304224714.10370-1-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=w1YtvC8x;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jiIMu+re
X-Spamd-Result: default: False [1.33 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.36)[97.04%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.33
X-Rspamd-Queue-Id: 47A3F3501B
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

This is very similar to v2 with:
 - first two patches swapped
 - while(1) loop changed to "goto retry"
 - add a comment to patch 3
 - rebase on nfsd-next
 - rb from Jeff added.

NeilBrown

 [PATCH 1/4] nfsd: move nfsd4_cstate_assign_replay() earlier in open
 [PATCH 2/4] nfsd: perform all find_openstateowner_str calls in the
 [PATCH 3/4] nfsd: replace rp_mutex to avoid deadlock in
 [PATCH 4/4] nfsd: drop st_mutex_mutex before calling

