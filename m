Return-Path: <linux-nfs+bounces-7950-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0C79C816C
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 04:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6411F222E5
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 03:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FF31E7C16;
	Thu, 14 Nov 2024 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EYkLc+gh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JMCzRO6t";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SEDQAw0y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rfihD9BM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEC92E634;
	Thu, 14 Nov 2024 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731554408; cv=none; b=ZzEPBGq+YKWN07etghDmFM3/RYw8+AgKzQ6tzpMaHVTdnLd0fzihNidJR5BbmPwoK5SO4t/+06r7rQwllyckO+nn9QYoTFtC16PKAfvxXYNGfj9ZjND8tqJNa+HZkVWTvk03t+sDgUvwHNyH30OLaTwXugMik+8MIhuAKiTU/Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731554408; c=relaxed/simple;
	bh=3sQdte3d2GmSTKI2e1MXGW+iL+19HEgnHdz/TVvD+D0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=UGzohbl2gD8ANxo425yumRe1VfuEWBJLhKa1pA6UEQ/9sheEGzMm8x4skY/wAgEu0CSZEgxWUUM3aTe1yxfKHQvXLLFfmH8HbWI+zuVTouH9NG1hb5rpVhF2pGL4jRmOWeXMuoB7rfCoT2HtM7ylRY1yOYXwaSdToY5MGAgL2WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EYkLc+gh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JMCzRO6t; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SEDQAw0y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rfihD9BM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 274B621257;
	Thu, 14 Nov 2024 03:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731554404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9Nj8DbtCBCQfkb845l7xWbwGT1PBU9w7HPNymN787I=;
	b=EYkLc+ghv2rrcG3ItYXadA+lN/ortySd5cvhEGAcPByQG427GC8hlgtnk/6vJcN5DahnPr
	sMqUYuLnOKOKYCAj9YpIFzs+SqRYTkibpt943d1YEu9ynN/vqZw/8SrROeRa3hZYPfmC2L
	PxIrDMy56gAo2iWyR9mV3A9+ib6JV/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731554404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9Nj8DbtCBCQfkb845l7xWbwGT1PBU9w7HPNymN787I=;
	b=JMCzRO6tHG/r9uq+ptbWtPulbNe2xlJzT4DJ1ndm28ZOhgAoxsiUXBenQ2xbIsy7jeiwps
	0JSoaArtQM5lMMCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SEDQAw0y;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rfihD9BM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731554403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9Nj8DbtCBCQfkb845l7xWbwGT1PBU9w7HPNymN787I=;
	b=SEDQAw0yfBiIXFK9BhLd6M03NgBabSTqEwJ5Jp/fKvDrM0DvzLPwJ4JFv82135wlRb5XSw
	Vm86TtEWEdqu8UZl8ih5678XNaB1ffqhj6Xlrcd+fOomAlfpCa1ScnHQJhgm+z3LvfJtl+
	crfrWDbfarTeXJbLQl9H8ApkXW2VCvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731554403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9Nj8DbtCBCQfkb845l7xWbwGT1PBU9w7HPNymN787I=;
	b=rfihD9BMnkuTCPbh86g4FIAqq8Oq1wf3+NiYez2ZxNzDrNu3iDZrCBUEpVykwkyTZPXud6
	d4mODfcB4atWVSCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C122913301;
	Thu, 14 Nov 2024 03:20:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F0o2HWBsNWe7EgAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 14 Nov 2024 03:20:00 +0000
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
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Olga Kornievskaia" <okorniev@redhat.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] nfsd: allow for up to 32 callback session slots
In-reply-to: <acf8d86338c881b6837d85399bfca406f1e1c0a3.camel@kernel.org>
References: <>, <acf8d86338c881b6837d85399bfca406f1e1c0a3.camel@kernel.org>
Date: Thu, 14 Nov 2024 14:19:56 +1100
Message-id: <173155439694.1734440.14845420245634385370@noble.neil.brown.name>
X-Rspamd-Queue-Id: 274B621257
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 14 Nov 2024, Jeff Layton wrote:
> On Wed, 2024-11-13 at 12:31 +1100, NeilBrown wrote:
> > 
> > So initialising them all to 1 when the session is created, as you do in
> > init_session(), is clearly correct.  Reinitialising them after
> > target_highest_slot_id has been reduced and then increased is not
> > justified by the above.
> > 
> 
> But, once the client and server have forgotten about those slots after
> shrinking the slot table, aren't they effectively new? IOW, once you've
> shrunk the slot table, the slots are effectively "freed". Growing it
> means that you have to allocate new ones. The fact that this patch just
> keeps them around is an implementation detail.


There is no text in the RFC about shrinking or growing or forgetting.
The only meaning given to numbers like ca_maxreqs is that the client
shouldn't use a larger slot number than the given one.

I think the slot table is conceptually infinite and exists in its
entirety from the moment CREATE_SESSION completes to the moment
DESTROY_SESSION completes (or a lease expires or similar).  The client
can limit how much of that infinitude that it will choose to use, and
the server can limit how much of it it will allow to be used so neither
need to store the full infinity.  But it never changes size.
Implementations can choose how much to store in real memory and can
discard every except (I think) the last sequence number seen on any slot
for which a request was sent (client) or accepted (server).

I agree that this seems less that ideal and it would be good if the
protocol has a mechanism for the client and server to agree to reset
the seqid for some slots.  But I cannot find any such mechanism.

Thanks,
NeilBrown

