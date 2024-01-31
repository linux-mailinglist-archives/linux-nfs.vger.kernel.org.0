Return-Path: <linux-nfs+bounces-1622-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D6E8442C9
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 16:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C90628507C
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 15:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E939284A4B;
	Wed, 31 Jan 2024 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jWuPLTo1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gp390m5c";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jWuPLTo1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gp390m5c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E1A5A7A1
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714103; cv=none; b=fhipJPlB+W8p+2NqHYWhqtd+lGPnF/uDaC29RWWKK/a2v953dw5m6U4ZuwMZkZN0OSN88CfGbJOEHv5/BPFB1JsvHCIR/Sf7G+M1iLh54Pc4W/+cZisP4vhbak+anBNJV/MWHf7gfHgBUzUPYcqrJccDIkbcrZmfWK/ho+ViH6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714103; c=relaxed/simple;
	bh=fPuOeeDy1Rnf0waztu10t0U96uM4i2xI1SPJ2xr6orQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kn6TC0SNqQMNUK+7qTz/RODxW0BtD8ZPXBpvsZHltcw/VFLkPNrnNsr/LtX+AGiZf+ytKgWUoagMALW4tVtArh7obNqqn8Hde/N1vkDy02Zt/8KKIJa4KkUyLGoVcsvP28NA+09GiripWe3OhTYmIyZLht0tt6F8DjoSJInionU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jWuPLTo1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gp390m5c; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jWuPLTo1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gp390m5c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C5B8A21FF9;
	Wed, 31 Jan 2024 15:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706714099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZEiUTRZkh8inO5+YNVbj+n37qKraFO4+vyQgGitviAA=;
	b=jWuPLTo1tn1PT+igogqktc66cl6+dlGY0U/xLc57rxZIHCC83dN2c0H1GZa8XBWYyqP/E0
	F9kAbAOiHXs07cv/7IldwsFiM1gY8a2ZDmwI0kRgKVyyAZ7AF91ymx84z4PIzMJW3YIvbN
	6hBPFBtg2Rv76kDtxQ5mtbPdi2Do7WM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706714099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZEiUTRZkh8inO5+YNVbj+n37qKraFO4+vyQgGitviAA=;
	b=Gp390m5cK/lO56fp9uc0lQ1zGL9EVhzZxc96bbAY2URzxNdg5ISX+um0yxlWlJrzTxLn3n
	gLYO1GBMpUeuvQCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706714099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZEiUTRZkh8inO5+YNVbj+n37qKraFO4+vyQgGitviAA=;
	b=jWuPLTo1tn1PT+igogqktc66cl6+dlGY0U/xLc57rxZIHCC83dN2c0H1GZa8XBWYyqP/E0
	F9kAbAOiHXs07cv/7IldwsFiM1gY8a2ZDmwI0kRgKVyyAZ7AF91ymx84z4PIzMJW3YIvbN
	6hBPFBtg2Rv76kDtxQ5mtbPdi2Do7WM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706714099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZEiUTRZkh8inO5+YNVbj+n37qKraFO4+vyQgGitviAA=;
	b=Gp390m5cK/lO56fp9uc0lQ1zGL9EVhzZxc96bbAY2URzxNdg5ISX+um0yxlWlJrzTxLn3n
	gLYO1GBMpUeuvQCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7774F132FA;
	Wed, 31 Jan 2024 15:14:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6QFcG/NjumWJeQAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Wed, 31 Jan 2024 15:14:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Martin Doucha <mdoucha@suse.cz>,
	linux-nfs@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>
Subject: [PATCH 0/4] nfsstat: Test also on NFSv4*
Date: Wed, 31 Jan 2024 16:14:42 +0100
Message-ID: <20240131151446.936281-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jWuPLTo1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Gp390m5c
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[43.18%]
X-Spam-Score: 3.49
X-Rspamd-Queue-Id: C5B8A21FF9
X-Spam-Flag: NO

Petr Vorel (4):
  runtest/net.nfs: Rename test names
  nfsstat01.sh: Validate parsing /proc/net/rpc/nfs{,d}
  nfsstat01.sh: Add support for NFSv4*
  nfsstat01.sh: Run on all NFS versions, TCP and UDP

 runtest/net.nfs                              | 197 ++++++++++---------
 testcases/network/nfs/nfsstat01/nfsstat01.sh |  47 +++--
 2 files changed, 135 insertions(+), 109 deletions(-)

-- 
2.43.0


