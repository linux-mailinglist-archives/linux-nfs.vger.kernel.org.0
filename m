Return-Path: <linux-nfs+bounces-6113-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79130967D12
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Sep 2024 02:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF4D1F2159F
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Sep 2024 00:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56212CA5;
	Mon,  2 Sep 2024 00:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OsMHk54z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5yuFEIe9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JtBGAxJH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BnThm87a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D7BA47
	for <linux-nfs@vger.kernel.org>; Mon,  2 Sep 2024 00:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725238279; cv=none; b=uz/hrMxYCkX253xjC5ZH/WkMtWulH65kNdAJ3Uug+bLLalWHzRty3UQpEt+7jwBtvXCidM9RtrXOr+KIgNJrmeJA+LZvv/BOHwKumAKkk8m6Qjn/TV8dmqILFMbcwnu4koRGx91iarjd7hym1sYdLl3vfHwqfL+11HnD7pXGuPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725238279; c=relaxed/simple;
	bh=whNgsQ6uviH1b7KOphda2K6rjuSJI7ZxDnr8k6mc9fE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=j2CPnPL6bFBZM1k4sWYvr0UXlOfht1zGGTEyRezU1nCX3SkaljGBYifYvN8P0sKCu8i45cqfFS5kc6F0+T0eTZllopHlMD4jTGhlqEu6Gf+71ywjATgyjAlZHi8b6DR8v12iXX7kojGTJRKt4jAg+tggT+7kZ8KWNRdvSUfJhQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OsMHk54z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5yuFEIe9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JtBGAxJH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BnThm87a; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 78C7721B0C;
	Mon,  2 Sep 2024 00:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725238276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhKqk0KLZ6IaXyyxMnWYJVaAHrCLnOK7b7vetKeDieM=;
	b=OsMHk54ziRldeNPlyLjyyfcQsk3fAQjsregnucOL3rLZDApI1KyFSn6cpM59D69n+vGwx+
	coYK8+yqTWhQVG4bcCbyz8rcrmtRrRGIszaLsHMwkilDqPjtV6Ig3a6kvF2GHxk1R4zURl
	f1D6QMmQo8xOlV9NjKaTBmezja/NZqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725238276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhKqk0KLZ6IaXyyxMnWYJVaAHrCLnOK7b7vetKeDieM=;
	b=5yuFEIe9hOEe6f8WGtlE77Dzz4J6cabppRqESYEmuRfE1wxe2URZ41B9khnjnZpjt/gdjE
	jxo5ZSvIDanT0sAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725238275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhKqk0KLZ6IaXyyxMnWYJVaAHrCLnOK7b7vetKeDieM=;
	b=JtBGAxJHau+wRxX/zTV7snKXfHwSA23FtmzxYvhTCK9tLG8p0OwWiKZE519qE4XHgOrMT7
	saGY3psBu0+NzquL6Phs5gsabtqtxwb3L6JdZm/FeXt2In5rdduQEpTXBYGSPGouSiCIGS
	KazFUssAH7FOHrMNEH26SLI28Ex2VKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725238275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhKqk0KLZ6IaXyyxMnWYJVaAHrCLnOK7b7vetKeDieM=;
	b=BnThm87auYC93LdjcPRqHSNhVAhrS5qUgBQqa+zflabqxZBFdF/fcLK3G4TTcXkSe2A1W5
	7I5hDL77KClEMGDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36FEC1397F;
	Mon,  2 Sep 2024 00:51:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vg5LNwEM1WbMQAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 02 Sep 2024 00:51:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/2] nfsd: improvements for wake_up_bit/var
In-reply-to: <ZtHZa+ww1Ec3nkxg@tissot.1015granger.net>
References: <20240830070653.7326-1-neilb@suse.de>,
 <ZtHZa+ww1Ec3nkxg@tissot.1015granger.net>
Date: Mon, 02 Sep 2024 10:51:02 +1000
Message-id: <172523826289.4433.3121429979430193675@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 31 Aug 2024, Chuck Lever wrote:
> On Fri, 30 Aug 2024 17:03:15 +1000, NeilBrown wrote:
> > I've been digging into wake_up_bit and wake_up_var recently.  There are
> > a lot of places where the required barriers aren't quite right.
> > 
> > This patch fixes them up for nfsd.  The bugs are mostly minor, though
> > the rp_locked on might be a credible problem on weakly ordered hosts
> > (e.g.  power64).
> > 
> > [...]
> 
> Applied to nfsd-next for v6.12, thanks!
> 
> [1/2] nfsd: use clear_and_wake_up_bit()
>       commit: 2b9a19d16beda1b2ca5edab47d74b73d4d958b12
> [2/2] nfsd: avoid races with wake_up_var()
>       commit: a2bf7d13821603fb90c3f6e695bd5fb4ee19de71
> 
> Both of these patches threw compilation errors. I corrected those
> issues before applying. Please check my work.

Thanks for that ...  I really shouldn't post patches in the afternoon -
I'm not thinking as clearly :-(

> 
> checkpatch.pl complained about the lack of comment on the added
> barriers. I felt the code was self-explanatory so made no change.
> 

I'd really like a wake_up_var_after_atomic() but Linus wasn't keen on
going in that direction.

if/when my improvements land
  https://lore.kernel.org/all/20240826063659.15327-1-neilb@suse.de/
we could change rp_locked to an "int" and use
   store_release_wake_up()
which includes that required barrier.

NeilBrown

