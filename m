Return-Path: <linux-nfs+bounces-1515-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2071883FCD2
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 04:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D2B9B220FE
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 03:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C5610949;
	Mon, 29 Jan 2024 03:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yEpReidT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0ZoNLniw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yEpReidT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0ZoNLniw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543901078D
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 03:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499414; cv=none; b=k2dQHaeZEztli8JsdoEKLKIdVxtI/GpqP3JF29vT8kfN3biC93lZLLkhUyx5WkmXmDQBYy94oWE9mT6RD825Yb4i7CBPaCB+Sh5zEXa43azUF/Q0UPVZsHBvgBswYRHK7IlCa/nrStwYdIkV/x/4e78cY6nK4+OLRlCo6DJzAdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499414; c=relaxed/simple;
	bh=yIaadzfsTvxvRqafA/9hueaDlEdal5VJT8Y4PvjylbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rbV4vk2tF/W5oUDu8cdFFWj00MSgpisoMAwdv0BUqBFdqvYEmcXspURnCDMxEpwu/GzhAAAlZlP6pJqDyzLpenCOc7y1y7+sgUtpu5y4Yz9h+EQfNZZ2qH4mRFTcN3rH25eRCs2AHRGS+tznqv8D5g2sG6qt/GhaoolV9FwZ8FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yEpReidT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0ZoNLniw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yEpReidT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0ZoNLniw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3BD5E2229D;
	Mon, 29 Jan 2024 03:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bshgP5jtsTYtg49iRJO39X4XZTO3XKpaSs5GbR7p1nI=;
	b=yEpReidT+VnqA+SWxzDAz444APm8+iru111RCFG6S4256gM4G5XjqAPDgBfhr8nVm0z4Lh
	foTtmTs0lUwrc6c8IjYP88OG+t/OuzAxQvL5+lpXAZLG8rd1wtDUjRRBQ4/txnU0808omF
	lEI+xr9YJ3L59cScTxTLQa9PwlprQ3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bshgP5jtsTYtg49iRJO39X4XZTO3XKpaSs5GbR7p1nI=;
	b=0ZoNLniw3kcJJyT4esbL3DTSoyHCwEwiTM8N6rvg75evk3VDNuwrFQbv2XlGxrwrI5GrDm
	Om5/Da12yjtPb5Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bshgP5jtsTYtg49iRJO39X4XZTO3XKpaSs5GbR7p1nI=;
	b=yEpReidT+VnqA+SWxzDAz444APm8+iru111RCFG6S4256gM4G5XjqAPDgBfhr8nVm0z4Lh
	foTtmTs0lUwrc6c8IjYP88OG+t/OuzAxQvL5+lpXAZLG8rd1wtDUjRRBQ4/txnU0808omF
	lEI+xr9YJ3L59cScTxTLQa9PwlprQ3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bshgP5jtsTYtg49iRJO39X4XZTO3XKpaSs5GbR7p1nI=;
	b=0ZoNLniw3kcJJyT4esbL3DTSoyHCwEwiTM8N6rvg75evk3VDNuwrFQbv2XlGxrwrI5GrDm
	Om5/Da12yjtPb5Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A2EC13867;
	Mon, 29 Jan 2024 03:36:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ICmHFE8dt2UHKgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jan 2024 03:36:47 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>,
	Tom Haynes <loghyr@gmail.com>
Subject: [PATCH 00/13 v4] nfsd: support admin-revocation of v4 state
Date: Mon, 29 Jan 2024 14:29:22 +1100
Message-ID: <20240129033637.2133-1-neilb@suse.de>
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
X-Spamd-Result: default: False [1.90 / 50.00];
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
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

Changes compared with v3:
 - fixed a bug (tested a status flag in sc_type) that kernel test robot reported
 - Changed all NFS4.*STID.* #defines to SC_TYPE_foo or ST_STATUS_foo to match field names
 - fixed problems with accessing ->ls_file correctly in final patch
 - assorted speeling fixes and cosmetic changes
 - added Christoph and Tom to Cc as requested by Chuck


Patchset introduction:

There are cirsumstances where an admin might need to unmount a
filesystem that is NFS-exported and in active use, but does not want to
stop the NFS server completely.  These are certainly unusual
circumstance and doing this might negatively impact any clients acting
on the filesystem, but the admin should be able to do this.

Currently this is quite possible for NFSv3.  Unexporting the filesystem
will ensure no new opens happen, and writing the path name to
/proc/fs/nfsd/unlock_filesystem will ensure anly NLM locks held in the
filesystem are released so that NFSD no longer prevents the filesystem
from being unlocked.

It is not currently possible for NFSv4.  Writing to unlock_filesystem
does not affect NFSv4, which is arguably a bug.  This series fixes the bug.

For NFSv4.1 and later code is straight forward.  We add new state flags
for admin-revoked state (open, lock, deleg, layout) and set the flag
of any state on a filesystem - invalidating any access and closing files
as we go.  While there are any revoked states we report this to the
client in the response to SEQUENCE requests, and it will check and free
any states that need to be freed.

For NFSv4.0 it isn't quite so easy as there is no mechanism for the
client to explicitly acknowledged admin-revoked states.  The approach
this patchset takes is to discard NFSv4.0 admin-revoked states one
lease-time after they were revoked, or immediately for a state that the
client tries to use and gets an "ADMIN_REVOKED" error for.  If the
filestystem has been unmounted (as expected), the client will see STATE
errors before it has a chance to see ADMIN_REVOKED errors, so most often
the timeout will be how states are discarded.

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

