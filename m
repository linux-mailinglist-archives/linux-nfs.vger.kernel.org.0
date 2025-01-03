Return-Path: <linux-nfs+bounces-8904-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954F7A01056
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 23:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6B1162D7F
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 22:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E8D7DA95;
	Fri,  3 Jan 2025 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k9cxOI4e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oWg+pagZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k9cxOI4e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oWg+pagZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB271C07EA
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jan 2025 22:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735944651; cv=none; b=krSjq+LJezJwP+WdGZhKmtvo9uQycJnNbjtMNOKxiEOu6Qr2Z/pXWbUN1JoqcaB6V9krTkgC/XTGAldD21OQ6As6GjjCrGk0aKbDnDfJlPPIfCiMnO4gMhlNR3S1ZuMkkirWnPcaFM3+VbkapKc+90UXpTacPA3wvbEIjICjotk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735944651; c=relaxed/simple;
	bh=fGwihIBEAykI9FMVqkG/V7yRphfNmVvg0rUc7sNGulg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=b0kyvTgT7L1XGrc9oPsyCwSH1u6n30dMY9aB8shXzQYkN+6DAgXwMXtX5LCwSSDA3HwKXBzgYfSkgIb1NlgJLRMGmgJsxUoYnlp3TstLalSPEgk4K6TBXSwwlYBB6M7MUWDNpF/mUtXMPkaWiflI4LzYTF2m5Te3ouSbycEoCRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k9cxOI4e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oWg+pagZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k9cxOI4e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oWg+pagZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F3671F37C;
	Fri,  3 Jan 2025 22:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735944648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4wriA98aDJOoJDO/L45Vaj8MWtd0YfpOWwpRlnJP4U=;
	b=k9cxOI4eIM5JVapmiIcFI0eJ7PjRZCCUTBILm6fujKbDUGyu8lkyi569c0yL7rldUlG/lf
	ZdAUqPfHNPzsHNVCnGu/FiycwY8gdOpoqu/fc2XJvXbIDCSUcvVYDkhzzdSqnS0JkozOnr
	Iln4nqNv1NtW/7Dli+8/ZjJqiFLI9OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735944648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4wriA98aDJOoJDO/L45Vaj8MWtd0YfpOWwpRlnJP4U=;
	b=oWg+pagZxPrs/Sx5SMsH4sLyRwZQsRLwqzIWp42I7vVhHSXL5mNPIAEP+ocVCDcXU6apzC
	3v8sTfdBze1Fz5DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735944648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4wriA98aDJOoJDO/L45Vaj8MWtd0YfpOWwpRlnJP4U=;
	b=k9cxOI4eIM5JVapmiIcFI0eJ7PjRZCCUTBILm6fujKbDUGyu8lkyi569c0yL7rldUlG/lf
	ZdAUqPfHNPzsHNVCnGu/FiycwY8gdOpoqu/fc2XJvXbIDCSUcvVYDkhzzdSqnS0JkozOnr
	Iln4nqNv1NtW/7Dli+8/ZjJqiFLI9OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735944648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4wriA98aDJOoJDO/L45Vaj8MWtd0YfpOWwpRlnJP4U=;
	b=oWg+pagZxPrs/Sx5SMsH4sLyRwZQsRLwqzIWp42I7vVhHSXL5mNPIAEP+ocVCDcXU6apzC
	3v8sTfdBze1Fz5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A9BB134E4;
	Fri,  3 Jan 2025 22:50:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /6lCO8RpeGf/UwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 03 Jan 2025 22:50:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: cel@kernel.org
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Tejun Heo" <tj@kernel.org>
Subject:
 Re: [PATCH v1 2/2] NFSD: Change the filecache laundrette workqueue again
In-reply-to: <20250103010002.619062-2-cel@kernel.org>
References: <20250103010002.619062-1-cel@kernel.org>,
 <20250103010002.619062-2-cel@kernel.org>
Date: Sat, 04 Jan 2025 09:50:32 +1100
Message-id: <173594463285.22054.5607940116597245970@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Fri, 03 Jan 2025, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Youzhong Yang <youzhong@gmail.com> noticed the workqueue subsystem
> complaining about how long the filecache laundrette was running.
> This resulted in switching from using the system_wq for the
> laundrette to system_unbound_wq (see commit 4b84551a35e3 ("nfsd: use
> system_unbound_wq for nfsd_file_gc_worker()").
> 
> However, I've seen the laundrette running for multiple milliseconds
> on some workloads, delaying other work. For the purpose of
> scheduling fairness, perhaps a better choice would be to process
> filecache disposal queues on the system_long_wq instead.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/filecache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index a1cdba42c4fa..91a535c2dede 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -112,7 +112,7 @@ static void
>  nfsd_file_schedule_laundrette(void)
>  {
>  	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
> -		queue_delayed_work(system_unbound_wq, &nfsd_filecache_laundrette,
> +		queue_delayed_work(system_long_wq, &nfsd_filecache_laundrette,
>  				   NFSD_LAUNDRETTE_DELAY);

This doesn't seem right to me.
"unbound_wq" is not bound to an CPU.  It just gets allocated that thread
which shouldn't interfere with any other work (except for normal
scheduling contention) until the queue limit is reach, which is unlikely
to happen often.

"long_wq" IS bound to a CPU and is concurrency managed so it could
interfere with other things.  The idea is that work items scheduled
there are not in a hurry and could take longer.  But I dont' think they
should take very long...

I think the problem is elsewhere.
list_lru_walk() can hold a spin lock for as long as it takes to walk
nr_to_walk objects.  This will tie up the CPU no matter which work queue
it is running on.

I think that instead of passing "list_lru_count()" we should pass some
constant like 1024.

cnt = list_lru_count()
while (cnt > 0) {
   num = min(cnt, 1024);
   list_lru_walk(...., num);
   cond_sched()
   cnt -= num;
}

Then run it from system_wq.

list_lru_shrink is most often called as list_lru_shrink_walk() from a
shrinker, and the pattern there is essentially that above.  A count is
taken, possibly scaled down, then the shrinker is called in batches.

NeilBrown

