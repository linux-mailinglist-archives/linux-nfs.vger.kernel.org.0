Return-Path: <linux-nfs+bounces-5119-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE3593EAC2
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 03:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35481C20BB8
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 01:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D858C3716D;
	Mon, 29 Jul 2024 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m8MuQXgC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IX0w8BUV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1Y+ct8XO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A87Frnof"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA9126AC3
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 01:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217805; cv=none; b=NvwwU7qx3sG46SZLc6JobFcuU3AOzm34g0H9ARCatz7gqfiw5Dw+tQkUP5JBUkRRf054JNmfg/DNWDedRcRBGHIfPZbxKI9mCjjkby6W2exO2rZ3t9+X7HbTQnSn9K4U9G+zCVTQvVsMYWbsY23Tu3bM2C9omZwYnbQVMbimiVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217805; c=relaxed/simple;
	bh=V143JMP8iZj4fS3hWx6zyJTBBDwMguaXULtv5B/tZhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IrYgpgVRV7/+FH6Eod2RFKR6O0xfdg0+FYoCradzG7SrqGmMXYpWjppP/Y6nApQgTFZBSzX8H4reHXMUWSA7toz8msykTAvYshxHU8dpNgSipuRONi1xnT9Vycso8NTGIoIdrlcE6PPqMJczOUIEwhuvso/c9OgHEAnVd9X5n2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m8MuQXgC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IX0w8BUV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1Y+ct8XO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A87Frnof; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F0CCB1F749;
	Mon, 29 Jul 2024 01:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722217795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=n+SXKeLaIa56hqYRRXB89QZcta9hDwobI2LUH2hamJM=;
	b=m8MuQXgCmoQ/NU+lF4eI3IeeB2V6cKjJIVSMy4Gwxay+WXAgTY9Xwf9/BGRbxoCqW7/OVW
	j9QjPmaaP+SZAKcVTlhgPhJkjGXJ5XYWa29Z39zWQiznKZdEhFZCG0ysEWEhNPQKotT8pL
	BSPNor5UtXcUB669XvwzoL5KurR5yB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722217795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=n+SXKeLaIa56hqYRRXB89QZcta9hDwobI2LUH2hamJM=;
	b=IX0w8BUVd3TDI/EhtfPikXe5rqOhRNBNxjhedpZbPFzIWiAhvjdDLvvQClwAkvmHpp+PIw
	9tmDLAZSKDrgGxBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722217794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=n+SXKeLaIa56hqYRRXB89QZcta9hDwobI2LUH2hamJM=;
	b=1Y+ct8XOtOyfykFpZMIqfF0ztnMvAt3iSLSAPUYbeET+uWOgOvo7ei87wnVFsRnkXMbeOu
	wQ2ITCwCffqsNJSmoWexsmFx5A84etIiAsH07mtrfcNlNEc4gCbYIkBg7gMpta4dSv9jZ3
	Y6Z0kU5bhjwyGRzcmSw4z/SuLB81+KA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722217794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=n+SXKeLaIa56hqYRRXB89QZcta9hDwobI2LUH2hamJM=;
	b=A87FrnofkNZvvr1nhMEBj0wQwoYwS+do0OKHYxWtutknUF4wdxvZ006USBTtflbV/sPxyU
	4/ueRNiRkre27qCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDD0413704;
	Mon, 29 Jul 2024 01:49:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +Yf4H0D1pmbvFgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jul 2024 01:49:52 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/3] nfsd: move error code mapping to per-version code
Date: Mon, 29 Jul 2024 11:47:21 +1000
Message-ID: <20240729014940.23053-1-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.60 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

These three patches replace my earlier patch
    [PATCH 3/6] nfsd: Move error code mapping to per-version xdr code.

The mapping is now in proc code, not xdr code.

NeilBrown

 [PATCH 1/3] nfsd: Move error code mapping to per-version proc code.
 [PATCH 2/3] nfsd: be more systematic about selecting error codes for
 [PATCH 3/3] nfsd: move error choice for incorrect object types to

