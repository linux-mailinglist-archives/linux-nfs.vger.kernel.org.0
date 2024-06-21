Return-Path: <linux-nfs+bounces-4207-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C97D3911A2B
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 07:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E84928769F
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 05:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2921412C801;
	Fri, 21 Jun 2024 05:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wypDPrR8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rGMzEkhV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wypDPrR8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rGMzEkhV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A9086AFA
	for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 05:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946667; cv=none; b=bNGNXq1894YJkJaQC+imeV7zP0vV0BpMb4keUi1SwyEgQrPPpGQyAMflOBUsaDXM2t+wVkmUwqvJkYUPuczSYd96bmO370gi9gW5bVOqFlOjZyuqfNnPbRLh6EmmumHTgx+C9cK6yZqhlN6LuyjUGhBPzBjZbebXfcD8ipfUj4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946667; c=relaxed/simple;
	bh=N6Dmx89cK8wh4wfksuJlCTfP0wPhCo8aO1uNpoWzh+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=frfnCCzqBX+YWj95m5XvzZmDTPkhssd8WgAZfEJO46WDP8YDrmMBTDqch2g6q+B+YDaNPpH0GSu5wPeeCL6vREDFtSdN10tMmHoGeX4BsuNAcrBban6bNuz3mxh2H53f0QBo2kVglCWXL0tes+v71W5Y87RIsu8OdFXadGLHvy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wypDPrR8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rGMzEkhV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wypDPrR8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rGMzEkhV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 93BB31FB3B;
	Fri, 21 Jun 2024 05:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718946655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=J54atI4NpcAeWMSp0vksjnIH67wxu9/i8vApdQE/As4=;
	b=wypDPrR8nP21XIiv2idbf4p5C/1JAbU3pFUX0W2Kb3jQeg0lVT4OQFzC/53xFjWs8A/Y6Q
	EbvmLd7c8ZIFEiNdvYEYfI7MISvc3MhjktmaNsRY53aaQb3ZJpklUaUHd2QrDrv+TOYSfq
	4NaIlwRRj7JNrTEzSdo02diDN4U5gqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718946655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=J54atI4NpcAeWMSp0vksjnIH67wxu9/i8vApdQE/As4=;
	b=rGMzEkhVMIpDszp6nWlXx5keYl1DJEfqWTuNGwPjk2Yx5+hjHqbOhcZfzZA2BnnpNthNbQ
	FwlGON9Vepzjs/AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wypDPrR8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rGMzEkhV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718946655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=J54atI4NpcAeWMSp0vksjnIH67wxu9/i8vApdQE/As4=;
	b=wypDPrR8nP21XIiv2idbf4p5C/1JAbU3pFUX0W2Kb3jQeg0lVT4OQFzC/53xFjWs8A/Y6Q
	EbvmLd7c8ZIFEiNdvYEYfI7MISvc3MhjktmaNsRY53aaQb3ZJpklUaUHd2QrDrv+TOYSfq
	4NaIlwRRj7JNrTEzSdo02diDN4U5gqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718946655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=J54atI4NpcAeWMSp0vksjnIH67wxu9/i8vApdQE/As4=;
	b=rGMzEkhVMIpDszp6nWlXx5keYl1DJEfqWTuNGwPjk2Yx5+hjHqbOhcZfzZA2BnnpNthNbQ
	FwlGON9Vepzjs/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E0B213AAA;
	Fri, 21 Jun 2024 05:10:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OQneN1wLdWbYagAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 21 Jun 2024 05:10:52 +0000
From: NeilBrown <neilb@suse.de>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>
Subject: Suggested improvements for localio support.
Date: Fri, 21 Jun 2024 14:59:27 +1000
Message-ID: <20240621050857.20075-1-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 93BB31FB3B
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

These three patches are intend to be merged into the nfs localio patch series.

The first two should be squashed into existing patches as mentioned in
the commit description.  The first is a stand alone patch which cleans
up some ugliness that the current rpcsvc infrastructure requires.

As mentioned in the first patch, a small rearranged of patches is
required for each individual patch to compile.

I would like to suggest changes to the CONFIG options too - I haven't
provided a patch for that.

There should be just one config option: CONFIG_NFS_LOCALIO.  There is no
point enabling for client without server or server without client as in
either configuration nothing useful can be achieved.  There is also no
gain in enabling only for v3 or v4 and not both (unless I've missed
something...)

Despite Jeff's generally sensible suggestion, I'd like the CONFIG option
to be added earliy so that we can compile-test each individual commit.
If that would mean some intermediate commit might be problematic then I
would rather the localio_enabled module parameter were forced to 'false'
until it was safe to turn it on.

I note that the server uses uuid_t while the client doesn't.  I might
have made that worse...  We should probably be consisent.

I have only tested very lightly - treat as a base for further work more
than as a fully polished solution.

Thanks,
NeilBrown

 [PATCH 1/3] NFS: Simplify Client NFS_LOCALIO_PROGRAM support
 [PATCH 2/3] NFSD: Simplify server NFS_LOCALIO_PROGRAM support
 [PATCH 3/3] SUNRPC: replace program list with program array

