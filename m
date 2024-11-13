Return-Path: <linux-nfs+bounces-7922-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FD59C68E7
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 06:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EFF1F233FF
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 05:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16172309AE;
	Wed, 13 Nov 2024 05:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uuFBhC6l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fSU+VH4b";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uuFBhC6l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fSU+VH4b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD051632E8
	for <linux-nfs@vger.kernel.org>; Wed, 13 Nov 2024 05:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731477239; cv=none; b=jOLC0TOGh/k9yid/LFLOaOkGMS2gC67eJN9wnkBQZdfDx/+t8Sl+VYWbHmni8Bd+wCUbMUv79OvLXwPBpCLGwBJBI9aCa4Ibe96EP9bmfojpfhyujF9LwDWFW7DK4BeKE6rNHyZWkCfTlov3L+BZ5Xtks/qItWQ0quKBGF6NS7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731477239; c=relaxed/simple;
	bh=zTo6mE/FKEyXEt7iX6XckAfBuX7aZD5jqS4kqDI/fhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LhUHWc6kUnRgp7UcbL9/auyENCtOrOImViSh/4ennJQkFDxwEKKLNoOT7hJE1XLmphGF9+apuKl7s6jWbaluSi0kfw2b5a7QioFPVT0cLy9IuU2/v4My1ChU/DJXnXd57Y87gzLUrfyLtDpquOLZdQwVIXearudZwvU2j9w02QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uuFBhC6l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fSU+VH4b; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uuFBhC6l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fSU+VH4b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF4EF211E7;
	Wed, 13 Nov 2024 05:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731477235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bPnv0xT/8Jrp0K/2YjrNlW00aVuOPKc7TzJ1evdN/Cs=;
	b=uuFBhC6lanWLBNIcAbwb4axZZ3lEJkR5fBytgOVMlawaxEWe7XApfr/p5Y5Z1vyPiWzhdb
	DDOkbuO3gg1SdtnDAKfr9IsdMiE5EePZLtqB+vyqRXGlZCl/KqZ7WwQiD5aTgRt1VJb89Y
	dfhqb/lki2WdDorUueS/30uiBpCtxAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731477235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bPnv0xT/8Jrp0K/2YjrNlW00aVuOPKc7TzJ1evdN/Cs=;
	b=fSU+VH4bPrTX6FxQ7YTumYS9KEQL85A6Pc+5/8EmpetxFHwHBKoIe8+CnzzaYIDRIE2l9H
	Q7ZVi3x9m3J/JPBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731477235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bPnv0xT/8Jrp0K/2YjrNlW00aVuOPKc7TzJ1evdN/Cs=;
	b=uuFBhC6lanWLBNIcAbwb4axZZ3lEJkR5fBytgOVMlawaxEWe7XApfr/p5Y5Z1vyPiWzhdb
	DDOkbuO3gg1SdtnDAKfr9IsdMiE5EePZLtqB+vyqRXGlZCl/KqZ7WwQiD5aTgRt1VJb89Y
	dfhqb/lki2WdDorUueS/30uiBpCtxAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731477235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bPnv0xT/8Jrp0K/2YjrNlW00aVuOPKc7TzJ1evdN/Cs=;
	b=fSU+VH4bPrTX6FxQ7YTumYS9KEQL85A6Pc+5/8EmpetxFHwHBKoIe8+CnzzaYIDRIE2l9H
	Q7ZVi3x9m3J/JPBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE70113890;
	Wed, 13 Nov 2024 05:53:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id esOwIPE+NGd7fQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 13 Nov 2024 05:53:53 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/4 RFC] nfsd: allocate/free session-based DRC slots on demand
Date: Wed, 13 Nov 2024 16:38:33 +1100
Message-ID: <20241113055345.494856-1-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
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
X-Spam-Flag: NO
X-Spam-Level: 

This patch set aims to allocate session-based DRC slots on demand, and
free them when not in use, or when memory is tight.

I've tested with NFSD_MAX_UNUSED_SLOTS set to 1 so that freeing is
overly agreesive, and with lots of printks, and it seems to do the right
thing, though memory pressure has never freed anything - I think you
need several clients with a non-trivial number of slots allocated before
the thresholds in the shrinker code will trigger any freeing.

I haven't made use of the CB_RECALL_SLOT callback.  I'm not sure how
useful that is.  There are certainly cases where simply setting the
target in a SEQUENCE reply might not be enough, but I doubt they are
very common.  You would need a session to be completely idle, with the
last request received on it indicating that lots of slots were still in
use.

Currently we allocate slots one at a time when the last available slot
was used by the client, and only if a NOWAIT allocation can succeed.  It
is possible that this isn't quite agreesive enough.  When performing a
lot of writeback it can be useful to have lots of slots, but memory
pressure is also likely to build up on the server so GFP_NOWAIT is likely
to fail.  Maybe occasionally using a firmer request (outside the
spinlock) would be justified.

We free slots when the number of unused slots passes some threshold -
currently 6 (because ...  why not).  Possible a hysteresis should be
added so we don't free unused slots for a least N seconds.

When the shrinker wants to apply presure we remove slots equally from
all sessions.  Maybe there should be some proportionality but that would
be more complex and I'm not sure it would gain much.  Slot 0 can never
be freed of course.

I'm very interested to see what people think of the over-all approach,
and of the specifics of the code.

Thanks,
NeilBrown


 [PATCH 1/4] nfsd: remove artificial limits on the session-based DRC
 [PATCH 2/4] nfsd: allocate new session-based DRC slots on demand.
 [PATCH 3/4] nfsd: free unused session-DRC slots
 [PATCH 4/4] nfsd: add shrinker to reduce number of slots allocated

