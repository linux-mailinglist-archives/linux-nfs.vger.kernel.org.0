Return-Path: <linux-nfs+bounces-1582-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CEC841821
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 02:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F480B22A0F
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 01:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9432E646;
	Tue, 30 Jan 2024 01:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i3Ph+e7a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7TjoisU1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i3Ph+e7a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7TjoisU1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344F52E40E
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jan 2024 01:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706577074; cv=none; b=NBzuUvc/+8pSsh6IbWGZK6ztFXcxumISlvoONJ7NOGa/QGlKeGb+Xnr8REy1jXsURPLwNpPZSuBLcZhwjz65baQsdj0ElCGF7y7ahojM0dxRfJ/I+rtRJxgfFlZNaLDvSzJTANlQtIf1VYYzC0ZdlyLV/VmTIAVVdMIn7Tz3wmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706577074; c=relaxed/simple;
	bh=F4wMGSd1qHpsBukefn4ELoR3BUvwLC8OQvBXIDx17Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPN2J152cYByM1PxhP6q+IppglCNhmr4xqAxFOe1YGq+vT284kUPVSnIqvprvy/dMJIfrbE5D7ocrSo26i5tFPk4H6wC5nDuCeu15xzk7tU8U6ceMIdej8SElHQvUAYSbUIFIuksD4d6YipqNTUfeNigRHeoNTya9xaXAexTquM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i3Ph+e7a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7TjoisU1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i3Ph+e7a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7TjoisU1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 526B3220BB;
	Tue, 30 Jan 2024 01:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706577071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Srh3cIjBYRaI6wwNJ8jhdwcXoeCeh7FfmcJF/fbfdXU=;
	b=i3Ph+e7aKmCHt3ylybVneEVvMoYipifzNTWlNqZGNcwd5pjh9XQTVsx1HPTawW6vMelUzk
	VUaulUzHQDMwEYbkfBDopQPKbDL72KPdgHMWM7Pizo4OZq4m09yBxJE944QtQjR6Gsb1e5
	wORm2dI6Xxyt9fDPL8hNCFbj0ybN4bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706577071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Srh3cIjBYRaI6wwNJ8jhdwcXoeCeh7FfmcJF/fbfdXU=;
	b=7TjoisU1yCgoTcEH9E3UeEdGp65BX+1TH6dFIdOMkE0KbEHXK/WZAcbbVpQvviFPLi6GIu
	NH5OpEOmoQr49pBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706577071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Srh3cIjBYRaI6wwNJ8jhdwcXoeCeh7FfmcJF/fbfdXU=;
	b=i3Ph+e7aKmCHt3ylybVneEVvMoYipifzNTWlNqZGNcwd5pjh9XQTVsx1HPTawW6vMelUzk
	VUaulUzHQDMwEYbkfBDopQPKbDL72KPdgHMWM7Pizo4OZq4m09yBxJE944QtQjR6Gsb1e5
	wORm2dI6Xxyt9fDPL8hNCFbj0ybN4bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706577071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Srh3cIjBYRaI6wwNJ8jhdwcXoeCeh7FfmcJF/fbfdXU=;
	b=7TjoisU1yCgoTcEH9E3UeEdGp65BX+1TH6dFIdOMkE0KbEHXK/WZAcbbVpQvviFPLi6GIu
	NH5OpEOmoQr49pBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A774712FF7;
	Tue, 30 Jan 2024 01:11:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lh3VF6xMuGWPQAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 30 Jan 2024 01:11:08 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>,
	Tom Haynes <loghyr@gmail.com>
Subject: [PATCH 00/13 v5] nfsd: support admin-revocation of v4 state
Date: Tue, 30 Jan 2024 12:08:20 +1100
Message-ID: <20240130011102.8623-1-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,netapp.com,oracle.com,talpey.com,lst.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[33.80%]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

Changes compared to V4:
 - rebased on nfsd-next.  There was a new trace point which caused a conflict
 - added some reviewed-by from Jeff
 - Fix the new kdoc comment - kernel test robot reported I had the wrong 
   syntax for documenting function parameters.
 
Thanks,
NeilBrown

 [PATCH 01/13] nfsd: remove stale comment in nfs4_show_deleg()
 [PATCH 02/13] nfsd: hold ->cl_lock for hash_delegation_locked()
 [PATCH 03/13] nfsd: don't call functions with side-effecting inside
 [PATCH 04/13] nfsd: avoid race after unhash_delegation_locked()
 [PATCH 05/13] nfsd: split sc_status out of sc_type
 [PATCH 06/13] nfsd: prepare for supporting admin-revocation of state
 [PATCH 07/13] nfsd: allow state with no file to appear in
 [PATCH 08/13] nfsd: report in /proc/fs/nfsd/clients/*/states when
 [PATCH 09/13] nfsd: allow admin-revoked NFSv4.0 state to be freed.
 [PATCH 10/13] nfsd: allow lock state ids to be revoked and then freed
 [PATCH 11/13] nfsd: allow open state ids to be revoked and then freed
 [PATCH 12/13] nfsd: allow delegation state ids to be revoked and then
 [PATCH 13/13] nfsd: allow layout state to be admin-revoked.

