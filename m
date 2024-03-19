Return-Path: <linux-nfs+bounces-2383-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B1987F4B9
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 01:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8B72829EF
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 00:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55104368;
	Tue, 19 Mar 2024 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V6B1jML3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/7wBqdat";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V6B1jML3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/7wBqdat"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85413363
	for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 00:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710809079; cv=none; b=hdzW0WcOmZI6WmVDy9lKvHo7vZFiHD1zsd9mEGRfApQjs26V3/Q7pTmJU7I18b3lMKo9BAItu4v6vQDfz8TFvhzxoUVVNJ5VIbX+e9vSx/xWqDCXstNxyG3uxZta2S2Y4DS4KLbSUzpkCoWV90iBiQdDZ2A/Z1YxCg8/aBrKhYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710809079; c=relaxed/simple;
	bh=AV3+Vn3BWrOcybAlGVoSARpg9seBmt4o4y6vbKvWDTI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=lMOlQe87JfYnfRcrx6+naHe/ZmVbtMR3/Frek8q3rKOYnDby+lSfWWR8HDcGSTed3RS+czUYHGxyTGc/0DYgLiD3v1YkNTTY+NWxDBoog87jXW3YL8bF9X+M3yBMg0lVEn5XS2nCEPAS5aR/SKS1UV+vZ0efs6IR0AId9AZyDRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V6B1jML3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/7wBqdat; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V6B1jML3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/7wBqdat; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7CEFE3526D;
	Tue, 19 Mar 2024 00:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710809075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EC8BfTJZvwY5QZKjoYWFZxTLGxiO/1e8q9z7VxdakrA=;
	b=V6B1jML3mnl6pfwwlAWW/p7+auxg+wYC27ipUbKvlbUk17fmb6zKxbPttEQcRzoUGYaP68
	coXMSvO8vKwseP5IDJ35mJPw05g74KwI7J4HM3XfValxsDL1yRXr+gRfMuwd1Ah42X8JDS
	hkUs0GQ2egxViYr5iAFTcRuue8AGWzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710809075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EC8BfTJZvwY5QZKjoYWFZxTLGxiO/1e8q9z7VxdakrA=;
	b=/7wBqdatc3BXdNdnv2fWfmF4ubSiXQhCag8GWgr6R3uWUXDTmXW2CRyHgR2aatnIzArLz2
	yBZ7/O6VIDjOPvAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710809075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EC8BfTJZvwY5QZKjoYWFZxTLGxiO/1e8q9z7VxdakrA=;
	b=V6B1jML3mnl6pfwwlAWW/p7+auxg+wYC27ipUbKvlbUk17fmb6zKxbPttEQcRzoUGYaP68
	coXMSvO8vKwseP5IDJ35mJPw05g74KwI7J4HM3XfValxsDL1yRXr+gRfMuwd1Ah42X8JDS
	hkUs0GQ2egxViYr5iAFTcRuue8AGWzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710809075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EC8BfTJZvwY5QZKjoYWFZxTLGxiO/1e8q9z7VxdakrA=;
	b=/7wBqdatc3BXdNdnv2fWfmF4ubSiXQhCag8GWgr6R3uWUXDTmXW2CRyHgR2aatnIzArLz2
	yBZ7/O6VIDjOPvAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC224136A5;
	Tue, 19 Mar 2024 00:44:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id stLuIvHf+GVqegAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 19 Mar 2024 00:44:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject:
 Question about possible use-after-free in nfs_direct_write_reschedule()
Date: Tue, 19 Mar 2024 11:36:28 +1100
Message-id: <171080858885.13576.7878757943353384571@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=V6B1jML3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/7wBqdat"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[35.29%]
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: 7CEFE3526D
X-Spam-Flag: NO


I've been reviewing some nfs/direct.c patches for possible backport to
one of our older enterprise kernels and I've found something that looks
wrong.

It isn't clear to me how to exercise the code so I haven't be able to
trigger a problem.  I'm hoping that someone could either explain when
this code runs, or confirm if the code is correct or not.

Commit 954998b60caa ("NFS: Fix error handling for O_DIRECT write scheduling")

adds an extra call to nfs_release_request() but I cannot find any place
that an extra reference is taken.

The code currently reads:

	while (!list_empty(&reqs)) {
		req =3D nfs_list_entry(reqs.next);
		nfs_list_remove_request(req);
		nfs_unlock_and_release_request(req);
		if (desc.pg_error =3D=3D -EAGAIN) {
			nfs_mark_request_commit(req, NULL, &cinfo, 0);
		} else {
			spin_lock(&dreq->lock);
			nfs_direct_truncate_request(dreq, req);
			spin_unlock(&dreq->lock);
			nfs_release_request(req);
		}
	}

after the nfs_unlock_and_release_request() call I would expect that the
request could be freed, so that nfs_mark_request_commit() or the
nfs_release_request() could cause a problem.

Superficially it looks like the call should be simply
nfs_unlock_request().  This would follow the
list_remove;unlock;mark_commit pattern also found in
nfs_direct_write_reschedule_io().

Do we need:
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -581,7 +581,7 @@ static void nfs_direct_write_reschedule(struct nfs_direct=
_req *dreq)
 	while (!list_empty(&reqs)) {
 		req =3D nfs_list_entry(reqs.next);
 		nfs_list_remove_request(req);
-		nfs_unlock_and_release_request(req);
+		nfs_unlock_request(req);
 		if (desc.pg_error =3D=3D -EAGAIN) {
 			nfs_mark_request_commit(req, NULL, &cinfo, 0);
 		} else {

??

Thanks,
NeilBrown

