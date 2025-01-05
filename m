Return-Path: <linux-nfs+bounces-8921-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6907DA01CC1
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 00:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E167D3A33C5
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jan 2025 23:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664CE1487DD;
	Sun,  5 Jan 2025 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sxsuTR2D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WBh62DTE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sxsuTR2D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WBh62DTE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981941465BA
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jan 2025 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736120449; cv=none; b=QKZLV/LKYxpQ7NjrCbaXy2Jr2WVryTIHxGYVvUJD+zLVjO4oFbkb3mn2XdDRS5F16cHSguIwM88D1rGlnB5WVNWHBn1+8VAHGa4R3iiv97YyUwb+jPLt6W4EtZyIbHGT3zLi11bErpLcx2fzOerTGas3RZiGGB5NEhTYQR0pIMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736120449; c=relaxed/simple;
	bh=CTIg/HS7HJSxxH2TTDwYHPtW2Hn23tOS44QnEkG+Hx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PmC+LFYbzQd6pn1MmHOIzO7ARuJ3p4JtHLTCZKZltIENvNZr4dOaaZodVRdNdIoIfZ/J/yRVRaykGbnedVRRvAOW+hRQzBr5fdVk8kQ9rD9sOfiH/+GaKfJ6sbKc4/rvtOKxAeYdKBsDWQuytUg3WjLkIJ7PvkQR4L+Bfa8q9Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sxsuTR2D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WBh62DTE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sxsuTR2D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WBh62DTE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF6301F365;
	Sun,  5 Jan 2025 23:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736120445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EMrv+AvuDIcCquQaOEytmLmCkeQ926HlwG2YnzZE+Yk=;
	b=sxsuTR2DtLXXh0Fs2M8rABx88iejM+8EH7ZabuBOokIdL4TJioz62TNt+22RXP0PfSEBQ1
	2sYwZ+RcO4BbMYgWKczueDNDZuQRxyQGMYFEc2juROKR0GimYG5Le6kVMDWVw2yQ4SFhif
	zGCkZkUjdr4+Tg/vzDHR7jsdqsv3iOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736120445;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EMrv+AvuDIcCquQaOEytmLmCkeQ926HlwG2YnzZE+Yk=;
	b=WBh62DTEs7Wd5+Y2OImDGTydkxzYqXmYq85Wn/FRNl4PXA5fJY+IiljqoFc3LfsNy+ghWk
	XJ83GQIbU/V7eNDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sxsuTR2D;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WBh62DTE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736120445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EMrv+AvuDIcCquQaOEytmLmCkeQ926HlwG2YnzZE+Yk=;
	b=sxsuTR2DtLXXh0Fs2M8rABx88iejM+8EH7ZabuBOokIdL4TJioz62TNt+22RXP0PfSEBQ1
	2sYwZ+RcO4BbMYgWKczueDNDZuQRxyQGMYFEc2juROKR0GimYG5Le6kVMDWVw2yQ4SFhif
	zGCkZkUjdr4+Tg/vzDHR7jsdqsv3iOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736120445;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EMrv+AvuDIcCquQaOEytmLmCkeQ926HlwG2YnzZE+Yk=;
	b=WBh62DTEs7Wd5+Y2OImDGTydkxzYqXmYq85Wn/FRNl4PXA5fJY+IiljqoFc3LfsNy+ghWk
	XJ83GQIbU/V7eNDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DFAE137CF;
	Sun,  5 Jan 2025 23:40:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HFiUDHsYe2eKaQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 05 Jan 2025 23:40:43 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH intro] nfsd: add scheduling point in nfsd_file_gc()
Date: Mon,  6 Jan 2025 10:11:58 +1100
Message-ID: <20250105234022.2361576-1-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AF6301F365
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

This patch is intended to fix the problem:
    However, I've seen the laundrette running for multiple milliseconds
    on some workloads, delaying other work. 

reported by Chuck in 
   [PATCH v1 2/2] NFSD: Change the filecache laundrette workqueue again

I believe this problem is mostly likely caused by a lack of scheduling
points in nfsd_file_gc() so this patches adds them as needed.

On reflecting, I think that the approach here is wrong but that would
need a bigger fix.

We generally expect a given file to be used repeatedly for a while, and
then for accesses to stop when the client closes the file.  The
nfsd_file_gc() call happens every two seconds with the aim of discarding
all the files that haven't been used since two seconds ago.

To do this, it scans all the files currently on the list - many of which
are likely to have been used recently.  This seems like a waste of
effort.

I think it would be better to have two lists. A and B.
When refcount reaches zero for a GC file, it is added to A.
When the refcount is incremented we removed from wherever it is.
Every 2 seconds we free everything on B and then splice A across to B.

This completely avoids walking through all the still-active files,
moving them to the end of the LRU.

However this would make the shrinker a little more complex as we
wouldn't be able to use list_lru.  So I'm not proposing that immediately
but would like to know what others think first.

Thanks,
NeilBrown




 [PATCH] nfsd: add scheduling point in nfsd_file_gc()

