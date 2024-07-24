Return-Path: <linux-nfs+bounces-5026-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B2993AB6F
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 04:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C6C1F22783
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 02:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B7C4A00;
	Wed, 24 Jul 2024 02:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SYeFk4mM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a10NZMfu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AgxZoZZ9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Mz+VUMpq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51761CAA1
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 02:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721789779; cv=none; b=uJ1luCtuee5wGB/vb+nbUcinn4vLb4bvDFjnut7mwCxQ64zXjN7UeLL+gKipae+zJHWCMyOYNcXYu87eZ6r/+2R5ZJz8rd5s+ivjTITX8NVr/fOcEZJxrRV4hh6ewClAyj/4ENwxRuKLNz2c6evZvAzH9CbnPtQpPxfJWo20t/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721789779; c=relaxed/simple;
	bh=/cJWzmDuTw8ALl287hbm67hiOP0uSOHTMk4ljhTvYD0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=EKxFBhNcSAN3iUpFFdFkr8lLMNPhMs9syCLpOdovxkot9cKCmKyqY61+eY0zA7EoVBszyArEej00XUxbyLk9D/DzjO7VWMTaad5CvnoGodnaSbt9rTTz1IiDPXWyMKQYDqM8SaS+4d1JtgEamaGOanh1K2bldIzBw0JN5N6SwAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SYeFk4mM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a10NZMfu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AgxZoZZ9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Mz+VUMpq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD33421A55;
	Wed, 24 Jul 2024 02:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721789776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=llYf8cdoMmXNPjASRMUGiALkRpCkttvi7ZFgEK02HG8=;
	b=SYeFk4mMDRkPNloNeKpc4Yg62UfG5eyriqMSgcHw+aXm38k572uM+yF8qQOMMLLNJc++3V
	VZfz6YwEHvNQ4CIniYZcn5lJoTRyuhCfdiDoqS7PyRIKW6U2y/3U4CFgHHoMINDpwNTOtO
	n9fWwIiWj6G8+im1b8rqBWnCBZbmgBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721789776;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=llYf8cdoMmXNPjASRMUGiALkRpCkttvi7ZFgEK02HG8=;
	b=a10NZMfulPsS0Mb1+mgCuAGxuQ3SDb5l9NUPlpotQg09mzjHFUs2Ig1mf2u0WzXsPf6KYf
	TXx78vaPizKNz6Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AgxZoZZ9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Mz+VUMpq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721789775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=llYf8cdoMmXNPjASRMUGiALkRpCkttvi7ZFgEK02HG8=;
	b=AgxZoZZ9Vl09EgmeV4fZVqYAo1jv9kTa1/4m/TDvxO27oqUJf72LUvbwM+jR9vMuyA0LAc
	Klz/u6i4fT54ECX7dw9w8fvqVMRRu+DxqrrDmmx5mcDTsG5Q7Gn4ny+6XTK1lFsrhsIL/b
	rWi3x6MF0GXAbKO3PamfJ2+t98p+X9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721789775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=llYf8cdoMmXNPjASRMUGiALkRpCkttvi7ZFgEK02HG8=;
	b=Mz+VUMpqMmb4/wynd1gEPAFk+T2cDENy8t0PLxFkbO9bCC9wpdL65OFPgrXwlSdRmudDjr
	tpj5Wga3s0RoVbBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 597C91324F;
	Wed, 24 Jul 2024 02:56:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kjrRA01toGbTfAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 24 Jul 2024 02:56:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: don't EXPORT_SYMBOL nfsd4_ssc_init_umount_work()
Date: Wed, 24 Jul 2024 12:55:49 +1000
Message-id: <172178974983.18529.7196430427173527960@noble.neil.brown.name>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.31 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.31
X-Rspamd-Queue-Id: CD33421A55


nfsd4_ssc_init_umount_work() is only used in the nfsd module, so there
is no neex to EXPORT it.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a20c2c9d7d45..1795bd8e7ae9 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6268,7 +6268,6 @@ void nfsd4_ssc_init_umount_work(struct nfsd_net *nn)
 	INIT_LIST_HEAD(&nn->nfsd_ssc_mount_list);
 	init_waitqueue_head(&nn->nfsd_ssc_waitq);
 }
-EXPORT_SYMBOL_GPL(nfsd4_ssc_init_umount_work);
 
 /*
  * This is called when nfsd is being shutdown, after all inter_ssc
-- 
2.44.0


