Return-Path: <linux-nfs+bounces-3373-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEC78CE888
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2024 18:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603721C20D88
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2024 16:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D74912E1E5;
	Fri, 24 May 2024 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hPAwtHlQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+A9M3TFq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wAX9GoHz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NVgXEbup"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C4612E1CD
	for <linux-nfs@vger.kernel.org>; Fri, 24 May 2024 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716567274; cv=none; b=rtPYWTngBXqPGdeRF7tjfYRp2I8uccF2hSSFC6x5sSnGmAteM/GbQxB5R2SHMS0cXGiusneoLpKqLCWZhO7LNpRszt8tMEzVIF5Z2AlMjwwxIjibHqzA1WAkkSg6zhGMisVUkpVUkFAKKuG9UN4zIsah7Jvhx+mhF1vFfU6ek+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716567274; c=relaxed/simple;
	bh=37p9AYtM6CQU0P5EkC3JE4iSaJqM5obIVJ5IL9wntGo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GNvKoBu+f/pigiKDxz0z0NUf865sdIHn0Pkzd26yTOnpbWAUA7lYMoWj1KOMwTzpk60IbDKD38y4alsKO/i4x3xydDXaZ8RHoVtkz+1k517iHXZrj6G6+cki5KEyxUWGcT5Os/IY/SO6A+8QSM2oLw482DPtnIzt7qYxgNl5qAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hPAwtHlQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+A9M3TFq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wAX9GoHz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NVgXEbup; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 11C3B20B56;
	Fri, 24 May 2024 16:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716567270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ngCbx/tzaCI12rrACcTzxiqqplNePk7cRA/E7cu+4XI=;
	b=hPAwtHlQhNznE+dJp7OK4NkdXH/ImjnHnsO7Yg27i4WpuOEkydDLHfKUT0w8CSvLCCWMk+
	nyCGue27NLUGGXWIRzUdokWkKOau5TdN/w31KPxktn658m34vq5WOGuMp4AHe79eIMcIGd
	jjLPuKj3wEnkdkYxhjkeX1K54g7pwYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716567270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ngCbx/tzaCI12rrACcTzxiqqplNePk7cRA/E7cu+4XI=;
	b=+A9M3TFqdH6Y3wo3oIFF+96s1Qy4ypZwTHpAZX4wUo6Zdymtz8zWf9lNufInkAfYaAFiop
	vhdstKLwAuTyUEBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wAX9GoHz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NVgXEbup
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716567269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ngCbx/tzaCI12rrACcTzxiqqplNePk7cRA/E7cu+4XI=;
	b=wAX9GoHzKoaCiB3BP22K7ylErnlL96QvaqX3OplQredBq623NEMobEuhjWBqbUDHSWNadS
	oSUMGvra1v4DLp6RMBFfwJd4oUB3BNp94R9L25FW0MWQ0KS2e0nWVdSAZ5A7fHhVd8F7Cd
	ZmeXfuG+o923g53ynLEhVIVW0eP7ynk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716567269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ngCbx/tzaCI12rrACcTzxiqqplNePk7cRA/E7cu+4XI=;
	b=NVgXEbup7Ycn7oD7jqUi6Ffo8UWLl+6JYAee1ppKJLcoHuYU4zp4LrpD76thOLLGutxfUH
	uczj/0ar1mjJFfDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06C4B13A6B;
	Fri, 24 May 2024 16:14:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ty+eAeW8UGZYOQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 24 May 2024 16:14:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AFD07A0825; Fri, 24 May 2024 18:14:20 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: anna@kernel.org,
	linux-nfs@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] nfs: Avoid flushing many pages with NFS_FILE_SYNC
Date: Fri, 24 May 2024 18:14:19 +0200
Message-Id: <20240524161419.18448-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1736; i=jack@suse.cz; h=from:subject; bh=37p9AYtM6CQU0P5EkC3JE4iSaJqM5obIVJ5IL9wntGo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmULzUoWCQcS/ju647m6PWWFz02vXXUkkBsDNWbczB DgNGHHSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZlC81AAKCRCcnaoHP2RA2S+bB/ 9+bXkjRHnZuri7gCOE3aOdLegqtKINmIpnnQ0IaDGhGCYhOZ0rS7lkE8dV1ZleztjOWH0/bD6yqXbj kDwsyY3yiz35qMJfjyN28f6qoECJCdW90sip/t4TdmPeDOpbS/DCoKiddECZmmlyxPhTxZaXpo79Ok /mLIvB/qc7TE0kSg9vUjFIa+rzTXw0OVxNOW4jjGRWTJf7oOVPqPaCdXE7wue+y3atkuDcOsB2CAfU f0xRhFx6sDW1+5JtOGJH1jJsmq9WUkCT1q2gW8oXb2prt7Dy3ZuOjD0e/QftDn6yoL7BuQuTzNMUif lTCk/869yGh7vAbN1INyUTWVL8WnQ7
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 11C3B20B56
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

When we are doing WB_SYNC_ALL writeback, nfs submits write requests with
NFS_FILE_SYNC flag to the server (which then generally treats it as an
O_SYNC write). This helps to reduce latency for single requests but when
submitting more requests, additional fsyncs on the server side hurt
latency. NFS generally avoids this additional overhead by not setting
NFS_FILE_SYNC if desc->pg_moreio is set.

However this logic doesn't always work. When we do random 4k writes to a huge
file and then call fsync(2), each page writeback is going to be sent with
NFS_FILE_SYNC because after preparing one page for writeback, we start writing
back next, nfs_do_writepage() will call nfs_pageio_cond_complete() which finds
the page is not contiguous with previously prepared IO and submits is *without*
setting desc->pg_moreio.  Hence NFS_FILE_SYNC is used resulting in poor
performance.

Fix the problem by setting desc->pg_moreio in nfs_pageio_cond_complete() before
submitting outstanding IO. This improves throughput of
fsync-after-random-writes on my test SSD from ~70MB/s to ~250MB/s.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/nfs/pagelist.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 6efb5068c116..040b6b79c75e 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1545,6 +1545,11 @@ void nfs_pageio_cond_complete(struct nfs_pageio_descriptor *desc, pgoff_t index)
 					continue;
 			} else if (index == prev->wb_index + 1)
 				continue;
+			/*
+			 * We will submit more requests after these. Indicate
+			 * this to the underlying layers.
+			 */
+			desc->pg_moreio = 1;
 			nfs_pageio_complete(desc);
 			break;
 		}
-- 
2.35.3


