Return-Path: <linux-nfs+bounces-8353-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1429E6272
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 01:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9623E18842EE
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 00:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9D480603;
	Fri,  6 Dec 2024 00:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1Tgj0b6A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NRQBJWBR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1Tgj0b6A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NRQBJWBR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE39BE46
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 00:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446136; cv=none; b=BSBf91az1UWK4UemWv+FsloPMl3/V3BzDnspTlhMIi+mmrAndGV+P0qFeu37z19LtmCfGLfgGnwRZWMdeIQ+PvKtIQczKGaqRGxxgB07NpxY+wApS0sk12kkaHLt7temN6c2HuYO0BvV+8q+YmkgR8DyViInI2apTqq/N6V/pdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446136; c=relaxed/simple;
	bh=sor8/9/u7vl1IXO5c8lop2zFEr5QKVmjr56gc5EGsmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TKyFg/TvrWThSDNy1Y1qBbXYoyAJwdm+8dONWgm5dRF7zmio8DjPakCDC0HtM5DD4IH/QewNgMRNLzvkGfzgTL/fZKe7m6MgYohOzGMug/x+cuoRnwQppiGwkQl0vp1YTtH5A0QTAymFqqFyuqDFImL3w9ofVzXBEd8XXyUlOPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1Tgj0b6A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NRQBJWBR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1Tgj0b6A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NRQBJWBR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D59A21F37C;
	Fri,  6 Dec 2024 00:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733446131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QF84E+dc2OeXC4UIFy1V2f7S0ah2atGUtqH7FVPq4vQ=;
	b=1Tgj0b6AvZLNr2uyvD9RehX8+iQXbTkEMtQ/kX8P8dkBTyUA9cVTJQf5dD65wLbUwNddzk
	zTLkBt+qcMfc05l9M9aKvUFDy5udo7CuwmAObT3O1UVwiZNKCCWYMzPX5Xkx3r5ro23qDG
	yW38LiUbIQwz5Gev4bhy2HZTBG9Og9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733446131;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QF84E+dc2OeXC4UIFy1V2f7S0ah2atGUtqH7FVPq4vQ=;
	b=NRQBJWBR4hyAmwVaDj+xIXHjIc/c0A52+iiqe8OMHXZ/pu/1cwWbyKmKeJRPWBOsPEwgrj
	4b7NEH02ugbYueAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733446131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QF84E+dc2OeXC4UIFy1V2f7S0ah2atGUtqH7FVPq4vQ=;
	b=1Tgj0b6AvZLNr2uyvD9RehX8+iQXbTkEMtQ/kX8P8dkBTyUA9cVTJQf5dD65wLbUwNddzk
	zTLkBt+qcMfc05l9M9aKvUFDy5udo7CuwmAObT3O1UVwiZNKCCWYMzPX5Xkx3r5ro23qDG
	yW38LiUbIQwz5Gev4bhy2HZTBG9Og9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733446131;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QF84E+dc2OeXC4UIFy1V2f7S0ah2atGUtqH7FVPq4vQ=;
	b=NRQBJWBR4hyAmwVaDj+xIXHjIc/c0A52+iiqe8OMHXZ/pu/1cwWbyKmKeJRPWBOsPEwgrj
	4b7NEH02ugbYueAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5B84132EB;
	Fri,  6 Dec 2024 00:48:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C5QTGvFJUmfIDQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 00:48:49 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/6 v3] nfsd: allocate/free session-based DRC slots on demand
Date: Fri,  6 Dec 2024 11:43:14 +1100
Message-ID: <20241206004829.3497925-1-neilb@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Changes from v2:
 - number of slots is increased more quickly.  Every time the highest-number
   slot is used, we increase by at least 20%.
 - when xa_store() is used in a context where we no that no allocation can
   happen, pass '0' as the GFP flag.
 - report target slots as well as total slots in /proc/fs/nfsd/clients/*/info

I've stay with reporting session information in the client info file
rather than creating a directory or using netlink.  I think the client
info file is simple and adequate.

I still haven't added support for CB_RECALL_SLOT.  While it is helpful,
it isn't essential.  I'll probably try to add it after the current
series lands.

Thanks,
NeilBrown



