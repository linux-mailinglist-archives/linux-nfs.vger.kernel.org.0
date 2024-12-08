Return-Path: <linux-nfs+bounces-8432-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0946E9E8845
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 23:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021F91884EBC
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 22:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E51584D29;
	Sun,  8 Dec 2024 22:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U470gQwO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WtliE7g1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U470gQwO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WtliE7g1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDC274040
	for <linux-nfs@vger.kernel.org>; Sun,  8 Dec 2024 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733698012; cv=none; b=ifMj6ACCxBgDI6N+n07se4Muqgnn68wALrMBkET61i+3GK5g/8QRDvXJT5Unz1yMXHyOilAWr67eS9rMxMwqrQ+M/rNA92/M73J3m9Y3J1N+tqhMZPONCVS6x1g6pz77sEFJOyBtWaxt/y85Lw66XfaELFpMg6H4QHS03ynHW1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733698012; c=relaxed/simple;
	bh=RzTMO2fp03WqspmucYhIw4jVcnQa+c50plNAJ0cTPgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kgx7TCoo5j3jlRXIzaYJMUmYRIt3ca0G5NupFz4ZSN5l7Pdy+ZQkQRVJY/4u4j1Ly5+El9AGtiRuxxNONj/GvaQwiNGnm0w2r2euVAp/dO4JOvvX8UTp17Q1x4Ol0Y76Wc0ATXo7JR0c8DI/90tjnrl3xiRyeAYnEmbAU+L7z0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U470gQwO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WtliE7g1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U470gQwO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WtliE7g1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D72F21176;
	Sun,  8 Dec 2024 22:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733698003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ot2CM2xwnGQNauZgDGJyKKNrdBWXSxb2Fdeg2HeT3xk=;
	b=U470gQwOdrzovTrAYKo6h81R+gUv2+ggzyoiJv+YnR4Nu6FiWB0DcYE8DkXiLkcLp/kus8
	X3cnnVYrrJ+dLprOymS0pNOSAmJRl6DhrGcDb+h8H1UDy4VxwLwUuapKkoxD+uyOM4VJUV
	tq0PQ31iCOqKLkLUBHjEr0dMvM9lAaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733698003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ot2CM2xwnGQNauZgDGJyKKNrdBWXSxb2Fdeg2HeT3xk=;
	b=WtliE7g1pA74VERerd1Dp8pICt+OZDDQ1glw83V2KEGyb6Vx6ujcgPPWxRL30qRlgatvML
	qclaxZSmlUJzGiAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733698003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ot2CM2xwnGQNauZgDGJyKKNrdBWXSxb2Fdeg2HeT3xk=;
	b=U470gQwOdrzovTrAYKo6h81R+gUv2+ggzyoiJv+YnR4Nu6FiWB0DcYE8DkXiLkcLp/kus8
	X3cnnVYrrJ+dLprOymS0pNOSAmJRl6DhrGcDb+h8H1UDy4VxwLwUuapKkoxD+uyOM4VJUV
	tq0PQ31iCOqKLkLUBHjEr0dMvM9lAaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733698003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ot2CM2xwnGQNauZgDGJyKKNrdBWXSxb2Fdeg2HeT3xk=;
	b=WtliE7g1pA74VERerd1Dp8pICt+OZDDQ1glw83V2KEGyb6Vx6ujcgPPWxRL30qRlgatvML
	qclaxZSmlUJzGiAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DE2713998;
	Sun,  8 Dec 2024 22:46:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S41xMNAhVme2AQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 08 Dec 2024 22:46:40 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/6 v4] nfsd: allocate/free session-based DRC slots on demand
Date: Mon,  9 Dec 2024 09:43:11 +1100
Message-ID: <20241208224629.697448-1-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Changes from v3 include:
 - use GFP_NOWAIT more consistently - don't use GFP_ATOMIC
 - document reduce_session_slots()
 - change sl_generation to u16.  As we reduce the number of slots one at
   a time and update se_slot_gen each time, we could cycle a u8 generation
   counter quickly.

Thanks,
NeilBrown

 [PATCH 1/6] nfsd: use an xarray to store v4.1 session slots
 [PATCH 2/6] nfsd: remove artificial limits on the session-based DRC
 [PATCH 3/6] nfsd: add session slot count to
 [PATCH 4/6] nfsd: allocate new session-based DRC slots on demand.
 [PATCH 5/6] nfsd: add support for freeing unused session-DRC slots
 [PATCH 6/6] nfsd: add shrinker to reduce number of slots allocated

