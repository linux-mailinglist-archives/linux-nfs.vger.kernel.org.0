Return-Path: <linux-nfs+bounces-1703-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA9F846362
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 23:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F117B241DE
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 22:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B62D3FE52;
	Thu,  1 Feb 2024 22:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ns57tg+o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OXrsN73T";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ns57tg+o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OXrsN73T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABDB3FE4C;
	Thu,  1 Feb 2024 22:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826295; cv=none; b=V3XDHlHZq83Ym0Y+h2lORZB329dKxQrB7neS6R5BbECLWHks86dbAe8sPByp1HJipjscWBjvgbxjt5bCG492lGMEOrZ1//M+rMt43rg1HpK3MTBmA3OvJLKcf5cUR/8zQJtv/luT8Bsc0aZcuLRpabTkUqo9XLKbaLra4ogzt3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826295; c=relaxed/simple;
	bh=q/RXw/wz9e8k2OeAcJpW/Z4nj1DNk8ypmb92aV3johU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=rtSCiHfS45qCpF61Kw+iE2KbkyfkGwtSoWMPTuclwisK5fJRapayPdu8fxEbd9Y6C5KROS/DacLA/OYcsL/SguV2PpYs/sWjfjW7vrJOx/yqNqEu8ih2HcWciYEFPAdclnsFs2/KThUymCuHsqDJm0KbWH5X7wiYHyFwRkXDCNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ns57tg+o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OXrsN73T; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ns57tg+o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OXrsN73T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B2EF41FC25;
	Thu,  1 Feb 2024 22:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706826291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9xusTiuViOZVqFuXTNlaMAj31ojkMlLDi+EhZpM64o=;
	b=Ns57tg+odPykMm9gBhCbnas1SgYEoFWeAsYzsNhb7OBfxteKJtbKNTV85cbqd/Udcx7Yup
	9qM/9QTnPz5127YD1FkTHTqbU/yeI6LSQJpsE6QWoE1JejVdXJtJFv4CYHqV3zCy29c1K8
	70m/JURYxqrqzBdRJby0G83d6OBSxbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706826291;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9xusTiuViOZVqFuXTNlaMAj31ojkMlLDi+EhZpM64o=;
	b=OXrsN73TMgFbtSxnYlGmZ+9Ydo9QiXhi+QgG8Ob4EsR7k/4vtKxVJXutJPIH0Gwulx1mQn
	hZhDpKmA/+O4hDCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706826291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9xusTiuViOZVqFuXTNlaMAj31ojkMlLDi+EhZpM64o=;
	b=Ns57tg+odPykMm9gBhCbnas1SgYEoFWeAsYzsNhb7OBfxteKJtbKNTV85cbqd/Udcx7Yup
	9qM/9QTnPz5127YD1FkTHTqbU/yeI6LSQJpsE6QWoE1JejVdXJtJFv4CYHqV3zCy29c1K8
	70m/JURYxqrqzBdRJby0G83d6OBSxbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706826291;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9xusTiuViOZVqFuXTNlaMAj31ojkMlLDi+EhZpM64o=;
	b=OXrsN73TMgFbtSxnYlGmZ+9Ydo9QiXhi+QgG8Ob4EsR7k/4vtKxVJXutJPIH0Gwulx1mQn
	hZhDpKmA/+O4hDCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BB9313672;
	Thu,  1 Feb 2024 22:24:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0vU8ETIavGWhZgAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 01 Feb 2024 22:24:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <cel@kernel.org>
Cc: stable@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix RELEASE_LOCKOWNER
In-reply-to:
 <170681433624.15250.5881267576986350500.stgit@klimt.1015granger.net>
References:
 <170681433624.15250.5881267576986350500.stgit@klimt.1015granger.net>
Date: Fri, 02 Feb 2024 09:24:47 +1100
Message-id: <170682628772.13976.3551007711597007133@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[10.42%]
X-Spam-Flag: NO

On Fri, 02 Feb 2024, Chuck Lever wrote:
> Passes pynfs, fstests, and the git regression suite. Please apply
> these to origin/linux-5.4.y.

I should have mentioned this a day or two ago but I hadn't quite made
all the connection yet...

The RELEASE_LOCKOWNER bug was masking a double-free bug that was fixed
by
Commit 47446d74f170 ("nfsd4: add refcount for nfsd4_blocked_lock")
which landed in v5.17 and wasn't marked as a bugfix, and so has not gone to
stable kernels.

Any kernel earlier than v5.17 that receives the RELEASE_LOCKOWNER fix
also needs the nfsd4_blocked_lock fix.  There is a minor follow-up fix
for that nfsd4_blocked_lock fix which Chuck queued yesterday.

The problem scenario is that an nfsd4_lock() call finds a conflicting
lock and so has a reference to a particular nfsd4_blocked_lock.  A concurrent
nfsd4_read_lockowner call frees all the nfsd4_blocked_locks including
the one held in nfsd4_lock().  nfsd4_lock then tries to free the
blocked_lock it has, and results in a double-free or a use-after-free.

Before either patch is applied, the extra reference on the lock-owner
than nfsd4_lock holds causes nfsd4_realease_lockowner() to incorrectly
return an error and NOT free the blocks_lock.
With only the RELEASE_LOCKOWNER fix applied, the double-free happens.
With both patches applied the refcount on the nfsd4_blocked_lock prevents
the double-free.

Kernels before 4.9 are (probably) not affected as they didn't have
find_or_allocate_block() which takes the second reference to a shared
object.  But that is ancient history - those kernels are well past EOL.

Thanks,
NeilBrown


> 
> ---
> 
> Chuck Lever (2):
>       NFSD: Modernize nfsd4_release_lockowner()
>       NFSD: Add documenting comment for nfsd4_release_lockowner()
> 
> NeilBrown (1):
>       nfsd: fix RELEASE_LOCKOWNER
> 
> 
>  fs/nfsd/nfs4state.c | 65 +++++++++++++++++++++++++--------------------
>  1 file changed, 36 insertions(+), 29 deletions(-)
> 
> --
> Chuck Lever
> 
> 
> 


