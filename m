Return-Path: <linux-nfs+bounces-617-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD80813F1F
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 02:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518331C20E49
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 01:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACCC7EA;
	Fri, 15 Dec 2023 01:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tlZ7SFOV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IiS41LCA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tlZ7SFOV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IiS41LCA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7C07E4
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 01:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E2FDD1F7FB;
	Fri, 15 Dec 2023 01:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702603273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pqdKIwWMz9a1fPDUb40sia6YdDng+17n7FU1tFPAn1k=;
	b=tlZ7SFOVTPI1suI9IV4p0hMwPQs2lXnAEhzhZLkSN7067bGpAh//lhUXxjDBhcSS3snbNC
	5Z+6ZynA8qJcp7o7vZvOsNxEsKU7784CaNCVuc1WKbj6ppWDln8ivALdT7YxT88vAShSI2
	wJjjG8fcWHKA5+K9lVI9nfw1vVBUSNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702603273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pqdKIwWMz9a1fPDUb40sia6YdDng+17n7FU1tFPAn1k=;
	b=IiS41LCAn4PAf4PBxc2N6r1TW45cjeB0SYjyWRVW3Y2a2N0spF2+8H1hZi1evu5OMptBUq
	Kbb9mSuEXP+RgzDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702603273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pqdKIwWMz9a1fPDUb40sia6YdDng+17n7FU1tFPAn1k=;
	b=tlZ7SFOVTPI1suI9IV4p0hMwPQs2lXnAEhzhZLkSN7067bGpAh//lhUXxjDBhcSS3snbNC
	5Z+6ZynA8qJcp7o7vZvOsNxEsKU7784CaNCVuc1WKbj6ppWDln8ivALdT7YxT88vAShSI2
	wJjjG8fcWHKA5+K9lVI9nfw1vVBUSNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702603273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pqdKIwWMz9a1fPDUb40sia6YdDng+17n7FU1tFPAn1k=;
	b=IiS41LCAn4PAf4PBxc2N6r1TW45cjeB0SYjyWRVW3Y2a2N0spF2+8H1hZi1evu5OMptBUq
	Kbb9mSuEXP+RgzDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2C2F1342E;
	Fri, 15 Dec 2023 01:21:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z8nFIQeqe2UlVQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 15 Dec 2023 01:21:11 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/2 v2] nfsd: fully close files in the nfsd threads
Date: Fri, 15 Dec 2023 12:18:29 +1100
Message-ID: <20231215012059.30857-1-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: 4.89
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ********
X-Spam-Score: 8.08
X-Spamd-Result: default: False [8.08 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 NEURAL_SPAM_LONG(3.42)[0.976];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.04)[58.08%]
X-Spam-Flag: NO

This is a revised version of my recent series to have nfs close files
directly and not leave work to an async work queue.

This version takes a more cautious approach and only using __fput_sync()
where there is a reasonable case that it could make a practical
difference.


