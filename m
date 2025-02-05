Return-Path: <linux-nfs+bounces-9890-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B8AA29D22
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 00:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CF81888F00
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 23:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AC91519B4;
	Wed,  5 Feb 2025 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mxCJV1HR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vDtca0E0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mxCJV1HR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vDtca0E0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1621121C198
	for <linux-nfs@vger.kernel.org>; Wed,  5 Feb 2025 23:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738796674; cv=none; b=ImaPFCoXQ9Z2AgGgaL6DHR+uizvSXDSxonaMzgTnVbY+9G6fsJso/dVE/8ECvmKev6Axq29B8SoyGnTzgXYQqWes631+UCRSpIg68hW4CNfDz3T1zF07yqs5bIyHYYNSrLsZ2/tF61/aV2Xurs1AoCukmX86lXlZNFpByM2GPok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738796674; c=relaxed/simple;
	bh=XHHXVm0/MYdanNmkfTo8OnCOVEhKrsKjzrsHuFcNxNQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=l9VgBB03M7d9G3EzBhHMkbJEMYoRPw2w/22GmF557nvHKVxyHXlNONjWIaLSR6ysEo4HX134rhEjEGKh/bD4/pPM2wQ3q5B4t5ulovSrvexQ+OSJr6yyEmRDqWFQDhIV+sOxAt7Yjza/PDhpFawj0aJjd0O7EZkZbd17/pRZFCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mxCJV1HR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vDtca0E0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mxCJV1HR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vDtca0E0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F9AE1F381;
	Wed,  5 Feb 2025 23:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738796671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5228Goui4mazjLfK2TThFdbjozqecMoeJg+S9cUbBlg=;
	b=mxCJV1HRt0dwlHPoIvhTzRNBrs4XHsC0cAWNzQ/Cpu9aJUTAFLrkQQHNt2YJmDn4SNAfBk
	nh/B7oSCa+8xuD8Zg+Pb5LOq+RXbOI+L2bighHM7+qMbfILgCGLrnju1i+fj97Q4kki1NO
	ubrBIwzM5uXacUkdKWqiD0GedhgzA90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738796671;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5228Goui4mazjLfK2TThFdbjozqecMoeJg+S9cUbBlg=;
	b=vDtca0E0B4G5YcP5mQKiLV1r0OOF5deyTHaUqfFWWf/h7WkgvYHDPzynzhX7K4v4BNqLeK
	5LAGQG/WjXrZRAAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738796671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5228Goui4mazjLfK2TThFdbjozqecMoeJg+S9cUbBlg=;
	b=mxCJV1HRt0dwlHPoIvhTzRNBrs4XHsC0cAWNzQ/Cpu9aJUTAFLrkQQHNt2YJmDn4SNAfBk
	nh/B7oSCa+8xuD8Zg+Pb5LOq+RXbOI+L2bighHM7+qMbfILgCGLrnju1i+fj97Q4kki1NO
	ubrBIwzM5uXacUkdKWqiD0GedhgzA90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738796671;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5228Goui4mazjLfK2TThFdbjozqecMoeJg+S9cUbBlg=;
	b=vDtca0E0B4G5YcP5mQKiLV1r0OOF5deyTHaUqfFWWf/h7WkgvYHDPzynzhX7K4v4BNqLeK
	5LAGQG/WjXrZRAAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B77D613694;
	Wed,  5 Feb 2025 23:04:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 09TBGnzuo2c/IwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 05 Feb 2025 23:04:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Dave Chinner" <david@fromorbit.com>
Subject: Re: [PATCH 0/7] nfsd: filecache: change garbage collection lists
In-reply-to: <20250127012257.1803314-1-neilb@suse.de>
References: <20250127012257.1803314-1-neilb@suse.de>
Date: Thu, 06 Feb 2025 10:04:25 +1100
Message-id: <173879666534.22054.7515430207159287196@noble.neil.brown.name>
X-Spam-Score: -4.28
X-Spamd-Result: default: False [-4.28 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.18)[-0.882];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 


Hi Chuck,
 what are you current thoughts on merging this series?

 One of my thoughts is that I now realise that

Commit 0758a7212628 ("nfsd: drop the lock during filecache LRU scans")

in nfsd-next is bad.  If there are multiple nodes (and so multiple
sublits in the list_lru) and if there are more than a few dozen files in
the lru, then that patch results in the first sublist being completely
freed before anything is done to the next.
I think the best fix for backporting to -stable is to wrap a
for_each_node_state((nid) around the while loop and using
list_lru_count_node() and list_lru_walk_node().

I could send a SQUASH patch for that and rebase this series on it.

Thanks,
NeilBrown


On Mon, 27 Jan 2025, NeilBrown wrote:
> [
> davec added to cc incase I've said something incorrect about list_lru
> 
> Changes in this version:
>   - no _bh locking
>   - add name for a magic constant
>   - remove unnecessary race-handling code
>   - give a more meaningfule name for a lock for /proc/lock_stat
>   - minor cleanups suggested by Jeff
> 
> ]
> 
> The nfsd filecache currently uses  list_lru for tracking files recently
> used in NFSv3 requests which need to be "garbage collected" when they
> have becoming idle - unused for 2-4 seconds.
> 
> I do not believe list_lru is a good tool for this.  It does not allow
> the timeout which filecache requires so we have to add a timeout
> mechanism which holds the list_lru lock while the whole list is scanned
> looking for entries that haven't been recently accessed.  When the list
> is largish (even a few hundred) this can block new requests noticably
> which need the lock to remove a file to access it.
> 
> This patch removes the list_lru and instead uses 2 simple linked lists.
> When a file is accessed it is removed from whichever list it is on,
> then added to the tail of the first list.  Every 2 seconds the second
> list is moved to the "freeme" list and the first list is moved to the
> second list.  This avoids any need to walk a list to find old entries.
> 
> These lists are per-netns rather than global as the freeme list is
> per-netns as the actual freeing is done in nfsd threads which are
> per-netns.
> 
> Thanks,
> NeilBrown
> 
>  [PATCH 1/7] nfsd: filecache: remove race handling.
>  [PATCH 2/7] nfsd: filecache: use nfsd_file_dispose_list() in
>  [PATCH 3/7] nfsd: filecache: move globals nfsd_file_lru and
>  [PATCH 4/7] nfsd: filecache: change garbage collection list
>  [PATCH 5/7] nfsd: filecache: document the arbitrary limit on
>  [PATCH 6/7] nfsd: filecache: change garbage collection to a timer.
>  [PATCH 7/7] nfsd: filecache: give disposal lock a unique class name.
> 
> 
> 


