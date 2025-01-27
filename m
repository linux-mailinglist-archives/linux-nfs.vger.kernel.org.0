Return-Path: <linux-nfs+bounces-9711-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A77A20159
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 00:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E67918860B2
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 23:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3241EB2A;
	Mon, 27 Jan 2025 23:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bj5v+7C5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+fxscE2z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bj5v+7C5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+fxscE2z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B061DD0F6
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 23:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738019126; cv=none; b=PJXL+PMeXWr98taU3P9ubRBz93iH4Vrk5WKscbLu7dFYANyltvmZpIW3DeoJ1buziKv5XMO1ODZX5gVGjeglIw09bhJvNmKRMv694K2FhLqp0yXo33qVCBcwkRjasmlzjq7Rfxcc+FtXGxrlwhHWJKOjsvVZd/Dj1LeVpykZsfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738019126; c=relaxed/simple;
	bh=0j2geOmVFui2ykSCwJW0ou8c+au1zPmZi8lMKqGpEQk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=rxjPzymBmDHffeW06vfNBwcSsfoDMGES6H0jkD5v4arYOy1uw6f8YTuc/wCWRVQ1Xp4E4KIpppWudEeoJGwnPPR6iUWfoDCtHG70EqlBMqtNn7FwBIZFGOedEGd3HYPgPFpT+ijLiK0D3HRXo4O5VN/Yum/Zn4wen7aRera6dNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bj5v+7C5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+fxscE2z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bj5v+7C5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+fxscE2z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E14DE21108;
	Mon, 27 Jan 2025 23:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738019122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yt1OQgmx3n4EVoLSLC3o7DBMIw3+C9LJRmoDxZdFHpY=;
	b=bj5v+7C5QvZKADZYN7ntRNz+pAt1gx75wiHh4RfLfif7nFsk7u1ejGGXDm9pKdh4Luh1BR
	HxvKnwIxn7Ge6g8B5ETRK8Df/72JZfcxaRmgPN88SNghic+8TROhtzBkAWzcHCrJN5+uXu
	WBtaT6RGnHT99DdhmIIZb+npMMaoYic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738019122;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yt1OQgmx3n4EVoLSLC3o7DBMIw3+C9LJRmoDxZdFHpY=;
	b=+fxscE2zbs2xvciVG57JfQzMzJovdmA8iKot+plyPSG/qzEcMJJ0YaEbFJK4mayGLhOCUp
	HfCUit/gJxlrrPDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738019122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yt1OQgmx3n4EVoLSLC3o7DBMIw3+C9LJRmoDxZdFHpY=;
	b=bj5v+7C5QvZKADZYN7ntRNz+pAt1gx75wiHh4RfLfif7nFsk7u1ejGGXDm9pKdh4Luh1BR
	HxvKnwIxn7Ge6g8B5ETRK8Df/72JZfcxaRmgPN88SNghic+8TROhtzBkAWzcHCrJN5+uXu
	WBtaT6RGnHT99DdhmIIZb+npMMaoYic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738019122;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yt1OQgmx3n4EVoLSLC3o7DBMIw3+C9LJRmoDxZdFHpY=;
	b=+fxscE2zbs2xvciVG57JfQzMzJovdmA8iKot+plyPSG/qzEcMJJ0YaEbFJK4mayGLhOCUp
	HfCUit/gJxlrrPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6CF113715;
	Mon, 27 Jan 2025 23:05:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p7VxFjERmGdrPAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 27 Jan 2025 23:05:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject:
 [PATCH nfsd-next] nfsd: fix uninitialised slot info when a request is retried
Date: Tue, 28 Jan 2025 10:05:03 +1100
Message-id: <173801910367.22054.5749156945763150749@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO


A recent patch moved the assignment of seq->maxslots from before the
test for a resent request (which ends with a goto) to after, resulting
in it not being run in that case.  This results in the server returning
bogus "high slot id" and "target high slot id" values.

The assignments to ->maxslots and ->target_maxslots need to be *after*
the out: label so that the correct values are returned in replies to
requests that are served from cache.

Fixes: 60aa6564317d ("nfsd: allocate new session-based DRC slots on demand.")
Signed-off-by: NeilBrown <neilb@suse.de>
---

Feel free to squash this into the offending patch, though subsequent
patches will need to be refreshed carefully.  Or just add it as-is.
Thanks.

 fs/nfsd/nfs4state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index cc819b8e8acd..b42e2ab7a042 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4460,10 +4460,11 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
 			}
 		} while (slot && --cnt > 0);
 	}
+
+out:
 	seq->maxslots =3D max(session->se_target_maxslots, seq->maxslots);
 	seq->target_maxslots =3D session->se_target_maxslots;
=20
-out:
 	switch (clp->cl_cb_state) {
 	case NFSD4_CB_DOWN:
 		seq->status_flags =3D SEQ4_STATUS_CB_PATH_DOWN;

base-commit: c1d6e5f7635895b5e9b2e4a9e4b7cdb9cc07eaf7
--=20
2.47.1


