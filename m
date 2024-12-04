Return-Path: <linux-nfs+bounces-8339-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885F49E31A8
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2024 03:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C23DB23A56
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2024 02:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3BE4AEE0;
	Wed,  4 Dec 2024 02:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hh7QVpG1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7cMdBDVi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cxIfFM+n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DsE49Pi5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAD71FA4
	for <linux-nfs@vger.kernel.org>; Wed,  4 Dec 2024 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281101; cv=none; b=RENVWgkBUfLO/aMQu3jj8r36UnJ/yj9RdWVFW3t+PhK0nRr6r31e59zTlWgFypwwuLQuF4yv6JgYCgc1ta6Pggo3KnePiYGeGMF0BYvnariWBdMywNxzHB3cH9G3M7qHT4EwgGJcqBclX33BGfvU9OvJD4y+vIu+/HsylQrc2FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281101; c=relaxed/simple;
	bh=BJeLVTG+DhM5VrZ+f569Swjb2wuLvEhXynPlJX6gFqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NWhNmdaBY92TSE+ZMIvJG/VzgzVd11NKsWjfUf+GroVrDPLj7Q48Go+PHr19c5H8Ecdg8Icng1xpDGSsFPzsI+x0sk0PbVa29XJFKTBJHnnzja+ezf9Jk6reNEkAiKUiZ0uoNimWN4b1oYBRMZo1QGGwHbuZjv8rLwYXUK0FEqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hh7QVpG1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7cMdBDVi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cxIfFM+n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DsE49Pi5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D80BD210FA;
	Wed,  4 Dec 2024 02:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733281096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uZ7N39TbhDZtoREtu223BKcOhX9LP21i4/8z0V/Lhks=;
	b=hh7QVpG1xz7AOLDkHNjTS1aR3EiABDkvKgHmzY++bZFkMZ5GABSeZC/SNZjLOfgKRNB3e/
	y1WZRI3dPDCkofrHR+LVAZ4OPWi6UQOO3NTId4wEvyyoZsYNhkk1rPac3YxfslNTUzKyre
	/DPWqs+iInpu0JgsCNtCFyETiVKAR7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733281096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uZ7N39TbhDZtoREtu223BKcOhX9LP21i4/8z0V/Lhks=;
	b=7cMdBDViY9EgYbsgbiKhxOAb8gKkAWrJo0UTwx+FWkTSLQJwFnd5Rn1JmOvhgAPs8VMMkD
	8UHQ+wHJHtBNUeDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733281094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uZ7N39TbhDZtoREtu223BKcOhX9LP21i4/8z0V/Lhks=;
	b=cxIfFM+nCm4EUN6xEzkHWFFNs22Px5MQPqDLSWVY2aR+rq7JufgFy23G4DV5k99myzHWts
	o2jc9yybg0mCpoyfIUEM/6JnQ3+DxAwcZhYlepoKNEn37vCxOUr9+2UcHSCmGdPDGVOQr3
	5ZMyi7RekBUpgW45tfyYkoNZ5c/Kps4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733281094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uZ7N39TbhDZtoREtu223BKcOhX9LP21i4/8z0V/Lhks=;
	b=DsE49Pi5mPhquAFb2UBIo6sbQIWZKtrRG/q96pQAYg51IlTdnhuy4iIMUpbM4wABS3uHap
	HqDqkhvJlgT6FrAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55F0E139C2;
	Wed,  4 Dec 2024 02:58:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6vfDAkXFT2dVBwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 04 Dec 2024 02:58:13 +0000
From: NeilBrown <neilb@suse.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: David Disseldorp <ddiss@suse.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] NFS - fix some _maxsz and _sz #defines
Date: Wed,  4 Dec 2024 13:53:08 +1100
Message-ID: <20241204025703.2662394-1-neilb@suse.de>
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
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The first patch fixes some _maxsz that are now wrong since a patch of
mine which changed for format of NFSv4.0 open-owners.

I think this inconsistency might have been easier to avoid if the
#define was closer to the code that it describes.  So the second patch
moves most of these #defines close to the code.  That requires moving
all the "encode" function after the "decode" functions.

So maybe the second patch is too intrusive to be worth it - it is just
an RFC patch.  The first patch is much less intrusive.

Thanks,
NeilBrown

 [PATCH 1/2] NFS: fix open_owner_id_maxsz and related fields.
 [PATCH 2/2] NFS: move _maxsz and _sz #defines to the function which

