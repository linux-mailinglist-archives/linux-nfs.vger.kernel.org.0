Return-Path: <linux-nfs+bounces-6333-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8973F970CD3
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 07:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C24B1C217DA
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 05:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D619461;
	Mon,  9 Sep 2024 05:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RkVBpt7J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wkRtZLwN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MS8XSReu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="M+9lQnfn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49BC3D8E
	for <linux-nfs@vger.kernel.org>; Mon,  9 Sep 2024 05:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725858415; cv=none; b=D4Zb2UzBfrYkAEpJsCkbNBnl2adELhtOBUzHy0UULxRntoAt32/tBhNCfPNB2X3fLTu8CpQtiZaKnl3hV9WI3IwLk/u+b/yJdTC34YuQHe7hLOxL5iK3ijQM0OCAjzL6x+OBzVadQfwCTYabWKDSuqvvw4xGpQzWCkgh8P4l2NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725858415; c=relaxed/simple;
	bh=2zoDhmspYDYsoiRGdu4p4s81/u52jy5ElmrsrawK+A0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=kDsP5g7jAxENzjdc8NMZPFl/1FPWnQ32WYTbKBopClVhrmqF+jCCeapLHo6RXIhUjN/OvQOeH9Lbz3x14LlvVHhd6aacq1e5+buPs2uSAXW+evC72DV1GaMwkeFGLGMHJ2n3wbGJJ3eM9hCJmW1RrpaaIQmQH/V9lSGWJdR6vk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RkVBpt7J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wkRtZLwN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MS8XSReu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=M+9lQnfn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E8C521F789;
	Mon,  9 Sep 2024 05:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725858406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OLy5CvJNo6vPmA3ns4ZbfblSCDOmcjHrnyZEQ61RvQo=;
	b=RkVBpt7JG5KwRdQutdLuS0BvYBfRvJhTBf7Eo+Ze+Rp0jcOcE02koojK3X/IwglqlGQoJS
	IPHFJEREpDMij1UpGN2u1I9+KwS6QVKQMzRzLNc61glFEscQb5sIG2YM5QWY4peRkG9hcc
	q7UAy6CyohyK2VkIelC4VdUoiij4VgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725858406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OLy5CvJNo6vPmA3ns4ZbfblSCDOmcjHrnyZEQ61RvQo=;
	b=wkRtZLwNybEhxmFUuAnDaXCEH8xnICwPeIdS4/Hic7ADzSmKTtLUNfiioGy8XdCB/h+mb5
	mxDDzE7UfLAGRYAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725858405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OLy5CvJNo6vPmA3ns4ZbfblSCDOmcjHrnyZEQ61RvQo=;
	b=MS8XSReu+FBLT/4kN7uv+gAYWJzojb4NTlJ30GU7BB/iPKTia8tU9OEPTq/hQQbkFwPFSu
	r5gyASPdN6XiNvwfDvmGNqHoA5ym7k7Gvj/ZuZQSDegeKD3Rl8cCIDrfwP+k2bCUNGJddL
	bdHGSH+gE7yyk8+qISPVzdF+Vczhyi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725858405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OLy5CvJNo6vPmA3ns4ZbfblSCDOmcjHrnyZEQ61RvQo=;
	b=M+9lQnfnpwmYo5qIPFYjt09Rp2mksdvrDkMmEG1YFPz1wyPDF2jH/SsqZNbOsvlEL208kS
	5Vv109xPbzyetLDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D446413A3A;
	Mon,  9 Sep 2024 05:06:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LZEKImOC3mbFNQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 09 Sep 2024 05:06:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>
Cc: Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: fix delegation_blocked() to block correctly for at
 least 30 seconds
Date: Mon, 09 Sep 2024 15:06:36 +1000
Message-id: <172585839640.4433.13337900639103448371@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO


The pair of bloom filtered used by delegation_blocked() was intended to
block delegations on given filehandles for between 30 and 60 seconds.  A
new filehandle would be recorded in the "new" bit set.  That would then
be switch to the "old" bit set between 0 and 30 seconds later, and it
would remain as the "old" bit set for 30 seconds.

Unfortunately the code intended to clear the old bit set once it reached
30 seconds old, preparing it to be the next new bit set, instead cleared
the *new* bit set before switching it to be the old bit set.  This means
that the "old" bit set is always empty and delegations are blocked
between 0 and 30 seconds.

This patch updates bd->new before clearing the set with that index,
instead of afterwards.

Reported-by: Olga Kornievskaia <okorniev@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 6282cd565553 ("NFSD: Don't hand out delegations for 30 seconds after r=
ecalling them.")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4313addbe756..6f18c1a7af2e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1078,7 +1078,8 @@ static void nfs4_free_deleg(struct nfs4_stid *stid)
  * When a delegation is recalled, the filehandle is stored in the "new"
  * filter.
  * Every 30 seconds we swap the filters and clear the "new" one,
- * unless both are empty of course.
+ * unless both are empty of course.  This results in delegations for a
+ * given filehandle being blocked for between 30 and 60 seconds.
  *
  * Each filter is 256 bits.  We hash the filehandle to 32bit and use the
  * low 3 bytes as hash-table indices.
@@ -1107,9 +1108,9 @@ static int delegation_blocked(struct knfsd_fh *fh)
 		if (ktime_get_seconds() - bd->swap_time > 30) {
 			bd->entries -=3D bd->old_entries;
 			bd->old_entries =3D bd->entries;
+			bd->new =3D 1-bd->new;
 			memset(bd->set[bd->new], 0,
 			       sizeof(bd->set[0]));
-			bd->new =3D 1-bd->new;
 			bd->swap_time =3D ktime_get_seconds();
 		}
 		spin_unlock(&blocked_delegations_lock);
--=20
2.44.0


