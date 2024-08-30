Return-Path: <linux-nfs+bounces-6047-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCC09660D3
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 13:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4C51C22DCF
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 11:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AEE185B51;
	Fri, 30 Aug 2024 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CQY58qj7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g7exihHt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CQY58qj7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g7exihHt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398E016D32D
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017589; cv=none; b=aZH28KeWrUKhxgivC5le+Ri5FXjoEzKirUthoMHZrNhTMzA0RdXB2h15lEXJm3waKfu5TDonQVgAwbTOq+ZEY6WqM5LAhpYZj4HLxL1UajUqLcjJTcKTB6tLHVoX9D+g3f8RoSo0a5ysyzITeXTt8LS2Fd+sQMzODa+6CnoP+A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017589; c=relaxed/simple;
	bh=S/TBowJScCvAfvlOOv7XMuBun0Id/0WA7TZXH0bkh6M=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=LNjniGZzOJnwe5tpR0zu/m2XBjMt+tRSEaVzDR38P1qenLnEENSwx9mvNsMxeovhL6IvTWwn7sVp6llbFNT9mDv1Tx76fj52CCRbNOA+E5Ca4J0dcH9qnA8rL9CelAI7JFChRU9AXk8tLZm7IQS5Q1ig4PDmHTb9JKJQPBUMN2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CQY58qj7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g7exihHt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CQY58qj7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g7exihHt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 41DFF1F7CA;
	Fri, 30 Aug 2024 11:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725017586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CxWZlO5dgdNKc3T4YFHMeSR2zggm4Ht2P/HNbKpCS4Y=;
	b=CQY58qj7RseMuVmfffPtXMyejIdURx0hUpCSJtBPHNW0eWhf6vhg7Tfonj8PtsGxQIMNDC
	ti1SfqKz9NlzV5QAQF52mJmw0eBE4oWobyviN4ItZra7cgXCLaQbqGSIUoiZzycI81psOx
	5tGhdEuFg06rpcvkitLl4nVS8a7RzxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725017586;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CxWZlO5dgdNKc3T4YFHMeSR2zggm4Ht2P/HNbKpCS4Y=;
	b=g7exihHty6+yA1a7OVAQwcrjIJAPIp7MnBiotATVrRLtaMUv0OHZtNm/Yvfj35ZBvOJc7u
	PFzwHR5Oyrq/OiCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725017586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CxWZlO5dgdNKc3T4YFHMeSR2zggm4Ht2P/HNbKpCS4Y=;
	b=CQY58qj7RseMuVmfffPtXMyejIdURx0hUpCSJtBPHNW0eWhf6vhg7Tfonj8PtsGxQIMNDC
	ti1SfqKz9NlzV5QAQF52mJmw0eBE4oWobyviN4ItZra7cgXCLaQbqGSIUoiZzycI81psOx
	5tGhdEuFg06rpcvkitLl4nVS8a7RzxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725017586;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CxWZlO5dgdNKc3T4YFHMeSR2zggm4Ht2P/HNbKpCS4Y=;
	b=g7exihHty6+yA1a7OVAQwcrjIJAPIp7MnBiotATVrRLtaMUv0OHZtNm/Yvfj35ZBvOJc7u
	PFzwHR5Oyrq/OiCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E5F213A44;
	Fri, 30 Aug 2024 11:33:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oBC1E/Ct0WaqMQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 30 Aug 2024 11:33:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Santosh Pradhan" <santosh.pradhan@gmail.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/2] nfsd: improvements for wake_up_bit/var
In-reply-to:
 <CAOuNp5m9zencvTnEsE6ovq__A_pyVo4omjUJAhoT7RQHTnXkhQ@mail.gmail.com>
References: <20240830070653.7326-1-neilb@suse.de>,
 <CAOuNp5m9zencvTnEsE6ovq__A_pyVo4omjUJAhoT7RQHTnXkhQ@mail.gmail.com>
Date: Fri, 30 Aug 2024 21:32:56 +1000
Message-id: <172501757611.4433.3843686586666002708@noble.neil.brown.name>
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 30 Aug 2024, Santosh Pradhan wrote:
> Hi Neil,
> Do we need a barrier in nfs4_disable_swap() as well ?
> 
> 10830         set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
> 10831         clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
> >>> HERE>>>>
> 10832         wake_up_var(&clp->cl_state);

Probably but that is in fs/nfs/, not fs/nfsd/.

Thanks,
NeilBrown


> 
> Regards,
> Santosh
> 
> On Fri, Aug 30, 2024 at 12:37 PM NeilBrown <neilb@suse.de> wrote:
> >
> > I've been digging into wake_up_bit and wake_up_var recently.  There are
> > a lot of places where the required barriers aren't quite right.
> >
> > This patch fixes them up for nfsd.  The bugs are mostly minor, though
> > the rp_locked on might be a credible problem on weakly ordered hosts
> > (e.g.  power64).
> >
> > NeilBrown
> >
> >  [PATCH 1/2] nfsd: use clear_and_wake_up_bit()
> >  [PATCH 2/2] nfsd: avoid races with wake_up_var()
> >
> 


