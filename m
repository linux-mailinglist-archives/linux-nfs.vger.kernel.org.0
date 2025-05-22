Return-Path: <linux-nfs+bounces-11858-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7C5AC0524
	for <lists+linux-nfs@lfdr.de>; Thu, 22 May 2025 09:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D4C9E1114
	for <lists+linux-nfs@lfdr.de>; Thu, 22 May 2025 07:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AF83BBC9;
	Thu, 22 May 2025 07:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GXHonMOB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GXHonMOB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308835893
	for <linux-nfs@vger.kernel.org>; Thu, 22 May 2025 07:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897313; cv=none; b=uMD6s4aO+35h4smPpVtMLwSGHREWPffHL9+Qw1jOaabNPJVpD+Ktr8cdkNOn4miu58x1q8wFUi8YXJTXGOMplp6zrRB2VU5SrTYDWjLae25RGRaq/upAY/dHUHBFs1DU+mMAKNk7miRuiUOFvGc+dTtJQVPBNLc8Xir+8Eciywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897313; c=relaxed/simple;
	bh=PEEKQ9m8l3ymj621xvGS6I10fQMy1tLHJiMURyBjyUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KhjN4cFix2BSezz3JynxUARLF3xMs+ljxfMjUUiUJbixS2Cx+kighgKoOsEAIHYOU3GfFfhBd7AAguE1iDr7Rqwj4cl5gpDnqUX16yFTdTLIcxwx2lJhD5yudVxZVthYwAAdfdAN2pUvA/dV98WFv5mv9K+bjvcoDa4mhu1NzYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GXHonMOB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GXHonMOB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 861F61FFC9;
	Thu, 22 May 2025 07:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747897308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rLcy+om4e52XpzgsRFReeYpJYEAx51fQMNw35HG7Q6U=;
	b=GXHonMOBr+imlU1nckw4oiN3ESJIpoT1beZMuu/G0JQpFJKHMOJpRy44yqdv/K4CwfXA/3
	b7FfbV5C0L4A/m1EbJZIAQnNUAjvcSUyXqFKyGlnI/1lndNQVEfCrPLKOEDSWSB9sYcwfn
	dwwmo0EOA/OdQWumJvQA997ZDx1pwbw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747897308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rLcy+om4e52XpzgsRFReeYpJYEAx51fQMNw35HG7Q6U=;
	b=GXHonMOBr+imlU1nckw4oiN3ESJIpoT1beZMuu/G0JQpFJKHMOJpRy44yqdv/K4CwfXA/3
	b7FfbV5C0L4A/m1EbJZIAQnNUAjvcSUyXqFKyGlnI/1lndNQVEfCrPLKOEDSWSB9sYcwfn
	dwwmo0EOA/OdQWumJvQA997ZDx1pwbw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E15313433;
	Thu, 22 May 2025 07:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EkjJC9zLLmgHBQAAD6G6ig
	(envelope-from <antonio.feijoo@suse.com>); Thu, 22 May 2025 07:01:48 +0000
From: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
To: linux-nfs@vger.kernel.org
Cc: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
Subject: [PATCH 0/2] systemd: Handle nfsroot
Date: Thu, 22 May 2025 08:59:08 +0200
Message-ID: <cover.1747753109.git.antonio.feijoo@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.20
X-Spamd-Result: default: False [0.20 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[opensuse.org:url,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]

Every initrd generator (dracut, initramfs-tools, mkinitcpio, ...) has
its own implementation of nfsroot, i.e., allow to mount the real root
filesystem via NFS in the initrd.

The main goal of this patchset is to provide a common, centralized,
simple and modern systemd implementation of nfsroot that can be used
by any initrd generator.  nfs-utils can easily provide it, and thus
also improve the maintainability of this feature.

The initial idea is to support NFSv4 only.

The matching patch for dracut (on top of openSUSE Tumbleweed) would be:

https://github.com/aafeijoo-suse/dracut/commit/f737e382988e77bd650dbb4951ef6925644fb523

OBS build with this patchset and the dracut patch:

https://download.opensuse.org/repositories/home:/afeijoo:/branches:/openSUSE:/Factory:/nfsroot/openSUSE_Tumbleweed/

Antonio Alvarez Feijoo (2):
  systemd: Allow nfs-idmapd.service to be started without the server
  systemd: Add a generator to mount /sysroot via NFSv4 in the initrd

 .gitignore                  |   1 +
 systemd/Makefile.am         |   8 +-
 systemd/nfs-idmapd.service  |   2 +-
 systemd/nfs.systemd.man     |  62 +++++++--
 systemd/nfsroot-generator.c | 243 ++++++++++++++++++++++++++++++++++++
 systemd/systemd.c           |  16 ++-
 systemd/systemd.h           |   1 +
 7 files changed, 321 insertions(+), 12 deletions(-)
 create mode 100644 systemd/nfsroot-generator.c

-- 
2.43.0


