Return-Path: <linux-nfs+bounces-2151-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A38AE86F949
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 05:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A4C1F214E4
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 04:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6923B17F3;
	Mon,  4 Mar 2024 04:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AkZaAHZA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zG1zJ9yS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AkZaAHZA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zG1zJ9yS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD4C17C8
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 04:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709527398; cv=none; b=HJ0PQdEeWDUM3BUanCFPeR5GWO7kySIfF7eHocT2wnbxg2zxpLjx+C0+LHrD1l8A2zdBX1beq4P39Dp+2BG/v5V/hV+F5ha41UnngYdzMW+foMexNgq12uAPwhMC9+8xM50/w6nxt942OINjpoU0d/OnxQs7bjt9PQmcqJYB6dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709527398; c=relaxed/simple;
	bh=mPdWC9bbuw83jcdll88gCoSK23g0WaSqD3d8An1DR6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DKzH2C1yOeKnQTPF3BD74FyPSnbTriIWCBKgSYcWvltorIUKGuifl1R74yEl7bdRXiVKs6jXK/X2trmKUXI3XN5T9qHz3H6Wqlcalcr+DRDx+D2o6Bk/pr3TYNlFI2S567JKDbQor8UI4spEVR2baR+m8DYZDIAWPLHkOgmAjec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AkZaAHZA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zG1zJ9yS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AkZaAHZA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zG1zJ9yS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 99712680B9;
	Mon,  4 Mar 2024 04:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709527394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DDHbUZRDFgtYefhvGBrM7gomjbPYKx2uf4imiRFKtEY=;
	b=AkZaAHZA+2XdmAPjepvEgT7w9+K+d8Yxkki1XyyOeP0eStdT3drJpDYSAeokz57zYkzrqf
	HLEe+K6bSt4Z2sF6SBY4FmmwPDpl7XacXoowL9h7x7FUY8tR3KyyKNWCqgFVfUmoCOMKtx
	HjaakfYCAT1zpEz0y/8Km4tT0+tSvds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709527394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DDHbUZRDFgtYefhvGBrM7gomjbPYKx2uf4imiRFKtEY=;
	b=zG1zJ9ySSHz2uoJsZZHq6dXEbM23VjUVIJKFfNKcNaplL/ijkeFDrdj3SnUne7pEbBRSQQ
	G3M8ipaP8v5GZ2Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709527394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DDHbUZRDFgtYefhvGBrM7gomjbPYKx2uf4imiRFKtEY=;
	b=AkZaAHZA+2XdmAPjepvEgT7w9+K+d8Yxkki1XyyOeP0eStdT3drJpDYSAeokz57zYkzrqf
	HLEe+K6bSt4Z2sF6SBY4FmmwPDpl7XacXoowL9h7x7FUY8tR3KyyKNWCqgFVfUmoCOMKtx
	HjaakfYCAT1zpEz0y/8Km4tT0+tSvds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709527394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DDHbUZRDFgtYefhvGBrM7gomjbPYKx2uf4imiRFKtEY=;
	b=zG1zJ9ySSHz2uoJsZZHq6dXEbM23VjUVIJKFfNKcNaplL/ijkeFDrdj3SnUne7pEbBRSQQ
	G3M8ipaP8v5GZ2Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F131813A9F;
	Mon,  4 Mar 2024 04:43:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xseuJF9R5WVPNwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Mar 2024 04:43:11 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/4 v2] nfsd: fix dadlock in move_to_close_lru()
Date: Mon,  4 Mar 2024 15:40:18 +1100
Message-ID: <20240304044304.3657-1-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AkZaAHZA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zG1zJ9yS
X-Spamd-Result: default: False [2.44 / 50.00];
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
	 BAYES_HAM(-2.25)[96.44%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.44
X-Rspamd-Queue-Id: 99712680B9
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

This series replaces 
   nfsd: drop st_mutex and rp_mutex before calling move_to_close_lru()
which was recently dropped as a problem was found.
The first two patches rearrange code without important functional change.
The last two address the two relaced problems of two different mutexes which are 
held while waiting and can each trigger a deadlock.

Thanks,
NeilBrown

 [PATCH 1/4] nfsd: move nfsd4_cstate_assign_replay() earlier in open
 [PATCH 2/4] nfsd: perform all find_openstateowner_str calls in the
 [PATCH 3/4] nfsd: replace rp_mutex to avoid deadlock in
 [PATCH 4/4] nfsd: drop st_mutex_mutex before calling

