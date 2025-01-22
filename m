Return-Path: <linux-nfs+bounces-9451-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61878A18AD6
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 04:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93415168EDB
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 03:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917D0136351;
	Wed, 22 Jan 2025 03:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tvakoaC3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dGRvNKPg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tvakoaC3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dGRvNKPg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE9C1FAA
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 03:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737518196; cv=none; b=LTRJwzE6tpRYzMjtN/fXy4WjwTqweIYnu1yL/EaiTm1dn9Ot64TJC0Qc2b0ILSKnLIgfr3V5Mxdj4Mya1tB/CcYPZ8rUDTj+L84tHW1AizSad2dDdpKlGwiVJtuKBVUk9ymauygdQY6Iqlx2KWgxIar3GOQcaVj4jj0w6nmvjPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737518196; c=relaxed/simple;
	bh=fFRuojqKv1wPatHPUV64/GGlA9FmxmkvtxHmN/PgDfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K0JeewsILs3+0OTpHOdcqI8O5t0ab8DN0kYw9nV5fDRwGDFfIbAoDGh9v7YT6KGhHpTpLuZA5LR69KQLkM8dMymvB0FFyTjBHf4MA6/NKiugC8VAvUpC5H5QuFg2ZlDkkSNWgWKzEPXOT/XSV1L9FkYB2LiUvVudHyIp7b+PAk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tvakoaC3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dGRvNKPg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tvakoaC3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dGRvNKPg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C514211F1;
	Wed, 22 Jan 2025 03:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737518193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cazxGRXKxJK332tlLbjD6Gy+f9FiTh+4RCNbPb79Z8I=;
	b=tvakoaC3qBZTRAidlzSeRIrtcBcDH9BYqrx7+zH5/tjkg5jjOE9FUgXmv7NFTNVboXz/fQ
	uRQkqxs9IqffUbVa5U14hno8LcLkw9Xfy7CodXcFzWmYZU8r5RIc+7T3vwjIjk7JDfzVLQ
	eqdNNbnjOvvvd8tjLLaLCPDPppTHSLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737518193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cazxGRXKxJK332tlLbjD6Gy+f9FiTh+4RCNbPb79Z8I=;
	b=dGRvNKPgIOmox47mlDxDpkMpV8mJCTIBU2p8QV3Yy/bmPNE6eeX4FE4Y46Kl0l+DFZPaxl
	LYZe/z3OZHRRDNDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737518193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cazxGRXKxJK332tlLbjD6Gy+f9FiTh+4RCNbPb79Z8I=;
	b=tvakoaC3qBZTRAidlzSeRIrtcBcDH9BYqrx7+zH5/tjkg5jjOE9FUgXmv7NFTNVboXz/fQ
	uRQkqxs9IqffUbVa5U14hno8LcLkw9Xfy7CodXcFzWmYZU8r5RIc+7T3vwjIjk7JDfzVLQ
	eqdNNbnjOvvvd8tjLLaLCPDPppTHSLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737518193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cazxGRXKxJK332tlLbjD6Gy+f9FiTh+4RCNbPb79Z8I=;
	b=dGRvNKPgIOmox47mlDxDpkMpV8mJCTIBU2p8QV3Yy/bmPNE6eeX4FE4Y46Kl0l+DFZPaxl
	LYZe/z3OZHRRDNDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE92A136A1;
	Wed, 22 Jan 2025 03:56:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MC5HKG5skGdEWAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 22 Jan 2025 03:56:30 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/4] nfsd: filecache: change garbage collect lists
Date: Wed, 22 Jan 2025 14:54:06 +1100
Message-ID: <20250122035615.2893754-1-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO


The nfsd filecache currently uses  list_lru for tracking files recently
used in NFSv3 requests which need to be "garbage collected" when they
have becoming idle - unused for 2-4 seconds.

I do not believe list_lru is a good tool for this.  It does no allow the
timeout which filecache requires so we have to add a timeout mechanism
which holds the list_lru for while the whole list is scanned looking for
entries that haven't been recently accessed.  When the list is largish
(even a few hundred) this can block new requests which need the lock to
remove a file to access it.

This patch removes the list_lru and instead uses 2 simple linked lists.
When a file is accessed it is removed from whichever list it is one,
then added to the tail of the first list.  Every 2 seconds the second
list is moved to the "freeme" list and the first list is moved to the
second list.  This avoids any need to walk a list to find old entries.

These lists are per-netns rather than global as the freeme list is
per-netns as the actual freeing is done in nfsd threads which are
per-netns.

This should not be applied until we resolve how to handle the
race-detection code in nfsd_file_put().  However I'm posting it now to
get any feedback so that a final version can be posted as soon as that
issue is resolved.

Thanks,
NeilBrown


 [PATCH 1/4] nfsd: filecache: use nfsd_file_dispose_list() in
 [PATCH 2/4] nfsd: filecache: move globals nfsd_file_lru and
 [PATCH 3/4] nfsd: filecache: change garbage collection list
 [PATCH 4/4] nfsd: filecache: change garbage collection to a timer.

