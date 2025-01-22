Return-Path: <linux-nfs+bounces-9450-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 791AAA18ACC
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 04:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288AF1887CFA
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 03:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A58136351;
	Wed, 22 Jan 2025 03:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zopl+JIq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lT0krW3z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zopl+JIq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lT0krW3z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E241FAA;
	Wed, 22 Jan 2025 03:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737517724; cv=none; b=QE/4TUjmJPWzi9o+2oCWpM7zvPvFQ3yFMp3zi0tNNT0n7QehX5fVDbppdbRQE7IlgwBXTAcW4tVPZJUyu/CslVu1TRYfmIYcDQMiEyYsilfIwJSzREQoNzXgwVly5014SReIvnupmIvqSedO8Iicussdea4nB2bMXAlAiBgYelo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737517724; c=relaxed/simple;
	bh=KEB2WBJAhq++CYrCXycOUoyU18DykBQLM/7AyNCcC3o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ZtgwiXmui+qwGfNw0rNXb8VP++EX8paHEn/2nzfvDVzyCxDiyPanWu38Zf5LA/DKAoOvVbX/n5WW9XnxZAVH6/W18YvSAToE606aMm3xTDCiZRed52lucJuobgkxm6dOoHTisMj/1LFmRwOxdi4L111buulX6aNLHOMkl3dl9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zopl+JIq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lT0krW3z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zopl+JIq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lT0krW3z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 68DF7211F1;
	Wed, 22 Jan 2025 03:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737517720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DbO63TjlwjZNzUB5KzMtlqNpo/MW+yaUvxZoqTIGt0E=;
	b=Zopl+JIq5o+94Uq38PCEad8QftxXK8NED6cHsB5z59o61epzt6ItktrR0t++17gdIRO+Zl
	8BmwTwYiOGDS5UqWPgE4ZYbMcChc1gI/c+CO5OEHCNJQVlKoPVyGaUA7b5wIecZKJSckuT
	vw7kkI1MNoBIPuHqlvS35ZRJexShPIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737517720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DbO63TjlwjZNzUB5KzMtlqNpo/MW+yaUvxZoqTIGt0E=;
	b=lT0krW3z5bxBWPtYHFJCIuLkZyHKn4qQv+PjaSZsY3q0P4U/kttBsNzsGQBuL+UgvLFx44
	gsHRiMBuoYoQ77Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Zopl+JIq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lT0krW3z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737517720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DbO63TjlwjZNzUB5KzMtlqNpo/MW+yaUvxZoqTIGt0E=;
	b=Zopl+JIq5o+94Uq38PCEad8QftxXK8NED6cHsB5z59o61epzt6ItktrR0t++17gdIRO+Zl
	8BmwTwYiOGDS5UqWPgE4ZYbMcChc1gI/c+CO5OEHCNJQVlKoPVyGaUA7b5wIecZKJSckuT
	vw7kkI1MNoBIPuHqlvS35ZRJexShPIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737517720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DbO63TjlwjZNzUB5KzMtlqNpo/MW+yaUvxZoqTIGt0E=;
	b=lT0krW3z5bxBWPtYHFJCIuLkZyHKn4qQv+PjaSZsY3q0P4U/kttBsNzsGQBuL+UgvLFx44
	gsHRiMBuoYoQ77Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D81C1387C;
	Wed, 22 Jan 2025 03:48:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /e2vMJNqkGeVRQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 22 Jan 2025 03:48:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Li Lingfeng" <lilingfeng3@huawei.com>, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, houtao1@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng@huaweicloud.com
Subject: Re: [PATCH] nfsd: free nfsd_file by gc after adding it to lru list
In-reply-to: <173750853452.22054.17347206263008180503@noble.neil.brown.name>
References: <>, <6fb21e60487273864136b4912951b5a4fb5b3ae0.camel@kernel.org>,
 <173750853452.22054.17347206263008180503@noble.neil.brown.name>
Date: Wed, 22 Jan 2025 14:48:27 +1100
Message-id: <173751770796.22054.11065694028641211869@noble.neil.brown.name>
X-Rspamd-Queue-Id: 68DF7211F1
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Wed, 22 Jan 2025, NeilBrown wrote:
> On Wed, 22 Jan 2025, Jeff Layton wrote:
> > To be clear, I think we need to drop e57420be100ab from your nfsd-
> > testing branch. The race I identified above is quite likely to occur
> > and could lead to leaks.
> > 
> > If Li Lingfeng doesn't propose a patch, I'll spin one up tomorrow. I
> > think the RCU approach is safe.
> 
> I'm not convinced this is the right approach.
> I cannot see how nfsd_file_put() can race with unhashing.  If it cannot
> then we can simply unconditionally call nfsd_file_schedule_laundrette().
> 
> Can describe how the race can happen - if indeed it can.

I thought I should explore this more and explain what I think actually
happens ...

Certainly nfsd_file_unhash() might race with nfsd_file_put().  At this
point in nfsd_file_put() we have the only reference but a hash lookup
could gain another reference and the immediately unhash it.
nfsd_file_queue_for_close() can do this.  There might be other paths.

But why does this mean we need to remove it from the lru and free it
immediately?  If we leave it on the lru it will be freed in a couple of
seconds.

The reason might be nfsd_file_close_inode_sync().  This needs to close
files before returning.
But if nfsd_file_close_inode_sync() is called while some other thread
holds a reference to the file and might want to call nfsd_file_put(),
then it isn't going to succeed anyway so any race here doesn't make any
difference.

So I think the following might be the best fix

???

Thanks,
NeilBrown

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index fcd751cb7c76..773788a50e56 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -322,10 +322,13 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
 static bool nfsd_file_lru_add(struct nfsd_file *nf)
 {
 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
+	rcu_read_lock();
 	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru)) {
 		trace_nfsd_file_lru_add(nf);
+		rcu_read_unlock();
 		return true;
 	}
+	rcu_read_unlock();
 	return false;
 }
 
@@ -371,19 +374,8 @@ nfsd_file_put(struct nfsd_file *nf)
 
 		/* Try to add it to the LRU.  If that fails, decrement. */
 		if (nfsd_file_lru_add(nf)) {
-			/* If it's still hashed, we're done */
-			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
-				nfsd_file_schedule_laundrette();
-				return;
-			}
-
-			/*
-			 * We're racing with unhashing, so try to remove it from
-			 * the LRU. If removal fails, then someone else already
-			 * has our reference.
-			 */
-			if (!nfsd_file_lru_remove(nf))
-				return;
+			nfsd_file_schedule_laundrette();
+			return;
 		}
 	}
 	if (refcount_dec_and_test(&nf->nf_ref))


