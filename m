Return-Path: <linux-nfs+bounces-8363-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C99C9E63F4
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 03:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22194163E6C
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 02:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4433C13C8FF;
	Fri,  6 Dec 2024 02:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tXbojatm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hN+ZLD61";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y1mIuzUA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R27lv0Kn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C7F2AE9A
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 02:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451539; cv=none; b=n1iLtHzOwD8qP07jy/Jma1huIQ8iC3FHWgLylILKC9R8/ukE7IP99/GaMUjJPM73DGLft8oiO5OuiF/pmW31WBl8KCIg2jT0nVTwVh8xgmNzk2rJdV3VsZKu8f0jD0Vu78W2Zu7BTFcYZd0u58H5jFOytDH1CRp3C0kOn6eaa1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451539; c=relaxed/simple;
	bh=kXPBRNZcoD3OkbHeMrsVATTpsPTbStIY2d3U5getpVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJMuDQSfKeAOmEGGmLIgW2wVq13fBauk+tx5dLcvDipzL9WkzA8TR5BiiPKdOcCsuR0cPak3PJBg6SzL/1LKY1OtucnFx8LflU1iX7BchuWuQQ4T/dageUsjp51FIScY2GTVJKF4QqJJGBGwwEpdgMUWT9ED2RYAM/W5Q8gG1Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tXbojatm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hN+ZLD61; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y1mIuzUA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R27lv0Kn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E7CC12115B;
	Fri,  6 Dec 2024 02:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o0cK4Rx7MxF1ENT8nhTwaDqP+YLq7bJIiJadWi+uzOM=;
	b=tXbojatmYrYDK+6LU79nCjO+sdKkKBNPrNuf5JgN87f4LVFOUyDzYj0eu34j7feu1fJfIt
	pMUdj6eZ4z7iDHUVQitcd8KxmOjckZesHvu1Gptu/pN9qJJBRdX21+GGStmOZI7m0HGCot
	z4m4sLQBTNNNok615n9DcVW9dtHHLjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o0cK4Rx7MxF1ENT8nhTwaDqP+YLq7bJIiJadWi+uzOM=;
	b=hN+ZLD61+m+asGR1AIlDo6M89MDBshfLDYT1NPiSZaplLSRmzqSLlE96Q/SwSdySqDNwmt
	+4QFcQZUcpDKP1DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y1mIuzUA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=R27lv0Kn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o0cK4Rx7MxF1ENT8nhTwaDqP+YLq7bJIiJadWi+uzOM=;
	b=y1mIuzUAB/egaj5vgGZYbRb2eG381RL0V7hjQY1IVHCcxWckZF6+cLm5NVMKzuucWGpK3V
	Ou/fFNoQf+TrKw/fnrOsYSa3V6dJql73l5awKYwFpGKgC2B7YFiQX16UB4FcH9YLzpoo7P
	nut02NHvnR8k0hm2BkNedUK6VbHHvZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o0cK4Rx7MxF1ENT8nhTwaDqP+YLq7bJIiJadWi+uzOM=;
	b=R27lv0KnJ79dXWR5ptR1tq1hgxMy/iMze0v/0bFt0iY1lKNamadSvko6KXAt7yW2hagSGZ
	IAJi4z5kTdpqXuAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF06B13A15;
	Fri,  6 Dec 2024 02:18:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KWSyGAtfUmcWJAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 02:18:51 +0000
From: NeilBrown <neilb@suse.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 00/11] nfs: improve use of wake_up_bit and wake_up_var
Date: Fri,  6 Dec 2024 13:15:26 +1100
Message-ID: <20241206021830.3526922-1-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E7CC12115B
X-Spam-Level: 
X-Spamd-Result: default: False [-2.18 / 50.00];
	BAYES_HAM(-2.17)[96.05%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.18
X-Spam-Flag: NO

wake_up_bit and wake_up_var are fragile interfaces as they sometimes
require a barrier before them.  Recently some new interfaces were added
which avoid the need for explicit barriers.  If we can remove all
instances of those fragile interfaces, that would be ideal.

Unforunately there is one can in NFS that does not fit the new
interfaces.  However most do.  This series replaces most use of the old
interfaces with the new, and adds various related cleanups.

Thanks,
NeilBrown


