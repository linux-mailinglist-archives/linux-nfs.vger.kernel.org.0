Return-Path: <linux-nfs+bounces-8135-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B099D306F
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 23:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1255B2222D
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 22:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9111D7989;
	Tue, 19 Nov 2024 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="of4NIBPJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="keRNz2f2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="of4NIBPJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="keRNz2f2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C3F1D2794
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054989; cv=none; b=OQOfNtUnNAx1Be4PED8MjYm9GvGIIU6+KOGuEfRQBAmoyeLEF4dW8ev8n7xKumUoHndBFrieO0paQDBLJ43Rkb1Rp5dPeT+03OwHXksSKDuy+x58L87nP9mEqHxYS3rw2IzJK8RCivVP+1FQc+wTQ5/tAYNJSEWufIpYhueTQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054989; c=relaxed/simple;
	bh=sJ4Eb6f4G6h5BqeTg//DhrirkGiqD78whSAlV63Cmfc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=PaTaAaw8iEii896n0d1jRtHNXygfuWSonQ5t27Y9O9S9bjKCP2Vn0NlYm/an/Og+aY1IfcIcabNaLyqQHXEZ0T748fKXHhX9BCp4yi64nh0DiqxTfQRhiAdyXRWbdtWXwGsYLPJQ+ktc6MbL2uGM7/rdscVsginMj+PRQ5R6DWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=of4NIBPJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=keRNz2f2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=of4NIBPJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=keRNz2f2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4BD811F395;
	Tue, 19 Nov 2024 22:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732054986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IURETQq4fS6uu3RdgGEmD/POGw8hY+widdNLuMeCiRo=;
	b=of4NIBPJX9JbvRmqq0QN1Biap/I8tUh5q7vtPL7+/UcvxusCu2UBWGl7NnWGoHqoOxHmYR
	dLso88hXBt9UKy3xwcZPoCj5mQHGaXdqMdOGdM+JWWKrsNIm1F11W7wbA9Ntffmbg6ZO1n
	miegcBvopXpgmI3RjxDfZiHQGS8KXh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732054986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IURETQq4fS6uu3RdgGEmD/POGw8hY+widdNLuMeCiRo=;
	b=keRNz2f2s3X3mwRSD4bjy5LAH1PCr/RgNke4WRa4pi4wEvYDWtu+kolySlJ8HGuP9ux23r
	xcfrY/HlozmFyWBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732054986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IURETQq4fS6uu3RdgGEmD/POGw8hY+widdNLuMeCiRo=;
	b=of4NIBPJX9JbvRmqq0QN1Biap/I8tUh5q7vtPL7+/UcvxusCu2UBWGl7NnWGoHqoOxHmYR
	dLso88hXBt9UKy3xwcZPoCj5mQHGaXdqMdOGdM+JWWKrsNIm1F11W7wbA9Ntffmbg6ZO1n
	miegcBvopXpgmI3RjxDfZiHQGS8KXh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732054986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IURETQq4fS6uu3RdgGEmD/POGw8hY+widdNLuMeCiRo=;
	b=keRNz2f2s3X3mwRSD4bjy5LAH1PCr/RgNke4WRa4pi4wEvYDWtu+kolySlJ8HGuP9ux23r
	xcfrY/HlozmFyWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46EBB13736;
	Tue, 19 Nov 2024 22:23:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WbCKO8cPPWcBHAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 19 Nov 2024 22:23:03 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject:
 Re: [PATCH 3/6] nfsd: add session slot count to /proc/fs/nfsd/clients/*/info
In-reply-to: <Zzzjjln34sdtnEkI@tissot.1015granger.net>
References: <>, <Zzzjjln34sdtnEkI@tissot.1015granger.net>
Date: Wed, 20 Nov 2024 09:22:59 +1100
Message-id: <173205497998.1734440.4810487064683118888@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 20 Nov 2024, Chuck Lever wrote:
> On Tue, Nov 19, 2024 at 11:41:30AM +1100, NeilBrown wrote:
> > Each client now reports the number of slots allocated in each session.
> 
> Can this file also report the target slot count? Ie, is the server
> matching the client's requested slot count, or is it over or under
> by some number?

I could.  Would you like to suggest a syntax?
Usually the numbers would be the same except for short transition
periods, so I'm not convinced of the value.

Currently if the target is reduced while the client is idle there can be
a longer delay before the slots are actually freed, but I think 2
lease-renewal SEQUENCE ops would do it.  If/when we add use of the
CB_RECALL_SLOT callback the delay should disappear.

> 
> Would it be useful for a server tester or administrator to poke a
> target slot count value into this file and watch the machinery
> adjust?

Maybe.  By echo 3 > drop_caches does a pretty good job.  I don't see
that we need more.

Thanks,
NeilBrown


