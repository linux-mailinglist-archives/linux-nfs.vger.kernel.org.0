Return-Path: <linux-nfs+bounces-2130-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E580686D824
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 01:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1D01C20D59
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 00:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE76368;
	Fri,  1 Mar 2024 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m55tEZGL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fRZICQbF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m55tEZGL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fRZICQbF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C4B365
	for <linux-nfs@vger.kernel.org>; Fri,  1 Mar 2024 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251803; cv=none; b=EP5tvfH5l7hv8FTMkeAcysOmVR3y5hkx8EQslqUp+FUPQAmymV0SFTXIKi+YO39svEpU/DIVCBwusCtj8KV4qMMn6XFBqP3xiXAQD0TZACgiECFLfKNU5AAbge96AZqjuSGEm1rGtPw4Y+yb9B/xxRPsJDdb+3xs4g0LLhNnKGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251803; c=relaxed/simple;
	bh=zZzJNIkv/YVjrItV9vlh20mlSzUXYLNeyPRMbvTJPE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cTud8S0KhNRxVfatztoxfWlfp4/rA236HM6HghxZ9OLaOzEv+N5c/VAlOYxc4SlMsmHrTEkfTgD00BconUw7WfTDxHPxTIZSPC1dM+hhfILhvuSBghUD+pmuLRJaUpiQYj6TeKvmj/aauLPAkcWgrzw3i4/S0PYKRqU7Mc8QKbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m55tEZGL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fRZICQbF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m55tEZGL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fRZICQbF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 486B11F80F;
	Fri,  1 Mar 2024 00:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709251799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BKg+ptV39jBDax+gksMpF9mTzQrL2eIQGA/Kx6tZUu4=;
	b=m55tEZGLB6biTVupA7LhdZw0chtmz6QBOMIzTEoIZrr7xTr/uHpapEgeRWBLz5lhG2FcB5
	DzQRxQSVrJjJeIiEPevSNykcz1BSbt/z4uYtRLJeaNvtI1pqNhteSPDiANxn9Zm8tUbN0X
	fTvh66xwbCahohZNXlJhGhvQpNfM9pM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709251799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BKg+ptV39jBDax+gksMpF9mTzQrL2eIQGA/Kx6tZUu4=;
	b=fRZICQbF+sxKBtcIHutENPhf23DcaHE1s4+AzXt0DkGo8cXoRQW219QMGFx6ms2YSNeOs3
	bH52cR3M1AT6eVAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709251799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BKg+ptV39jBDax+gksMpF9mTzQrL2eIQGA/Kx6tZUu4=;
	b=m55tEZGLB6biTVupA7LhdZw0chtmz6QBOMIzTEoIZrr7xTr/uHpapEgeRWBLz5lhG2FcB5
	DzQRxQSVrJjJeIiEPevSNykcz1BSbt/z4uYtRLJeaNvtI1pqNhteSPDiANxn9Zm8tUbN0X
	fTvh66xwbCahohZNXlJhGhvQpNfM9pM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709251799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BKg+ptV39jBDax+gksMpF9mTzQrL2eIQGA/Kx6tZUu4=;
	b=fRZICQbF+sxKBtcIHutENPhf23DcaHE1s4+AzXt0DkGo8cXoRQW219QMGFx6ms2YSNeOs3
	bH52cR3M1AT6eVAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A97113AB0;
	Fri,  1 Mar 2024 00:09:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vQQ3K9Qc4WWiJwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 01 Mar 2024 00:09:56 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/3] nfsd: fix dadlock in move_to_close_lru()
Date: Fri,  1 Mar 2024 11:07:36 +1100
Message-ID: <20240301000950.2306-1-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=m55tEZGL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fRZICQbF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.88 / 50.00];
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
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.37)[97.10%]
X-Spam-Score: -0.88
X-Rspamd-Queue-Id: 486B11F80F
X-Spam-Flag: NO

This series is intended to replace 
 98be4be88369 nfsd: drop st_mutex and rp_mutex before calling move_to_close_lru()
in nfsd-next.
As Jeff Layton oberved recently there is a problem with that patch.
This series takes a different approach to the rp_mutex proble, replacing it with an
atomic_t which has three states.  Details in the patch.

Thnaks,
NeilBrown


 [PATCH 1/3] nfsd: move nfsd4_cstate_assign_replay() earlier in open
 [PATCH 2/3] nfsd: replace rp_mutex to avoid deadlock in
 [PATCH 3/3] nfsd: drop st_mutex_mutex before calling

