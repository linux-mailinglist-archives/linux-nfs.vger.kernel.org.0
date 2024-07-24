Return-Path: <linux-nfs+bounces-5044-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CBC93B886
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 23:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB9F9B24BFD
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 21:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCCD137932;
	Wed, 24 Jul 2024 21:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xCfaH6vx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YycbtF93";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xCfaH6vx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YycbtF93"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C432F6F068
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 21:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721856343; cv=none; b=hG3YNGcgY1FzyjBIveTBAAZhfFQBoJxv91baiVIBfyEtwMdyd58zYYdB+HYCDTPiCgs6C/kr6ktCn0DzLaTBQFtebUvTqHFfO/YvPeCQZdKSSVc0DWFF6LqOxmhIq/3oS1o9ijVss7WcagLR7T5+6weiil8KH+ecRraPEOUpEQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721856343; c=relaxed/simple;
	bh=yofpqIRdGXcm0Ut5aMYzTXpLQZtBUVMUk0hFl0MEcIU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Tyn4CC0bxYlv6Slwx8gr3Xcz1PT+TqST28qnxfsQ7/ATpHgZ3gNsg0FezOVWJfimPfHFnM6qwj9A9jinNyBNS66c1TcmpIW55pL+3aq3eLr49HULFONQ6lYlYdNxiRp87auInFWHQDBx0pMxbzpHGxH1AFo0C3VFEqW8ZcQBH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xCfaH6vx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YycbtF93; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xCfaH6vx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YycbtF93; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A59AA1F7C3;
	Wed, 24 Jul 2024 21:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721856339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JW2r9j8mQOv8L20ytKQEodXEAKrw/64NLOuhUpNnWx4=;
	b=xCfaH6vxGOotfGXukU5Ib0IMs2/oXd8I2Aq8di09PefWJ0sN2Ye6NRzClfSm8JQd0yshZO
	E/spZ9xHY36uDBvOfSzTPOWRwB8T9LY4uGSnfkzdTZtqyhLruDCpyX11qQRcoHW8S3E146
	i8kDLadP3ho3UYVaNQevKY6zoAxCv8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721856339;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JW2r9j8mQOv8L20ytKQEodXEAKrw/64NLOuhUpNnWx4=;
	b=YycbtF93N95XgudlBzJl03Ve8S9mT+gk/zi0X+usIYY5d9nVWFwxM/EEnsa4yELIq/irXM
	tRVvsGV8Qu8BmnCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xCfaH6vx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YycbtF93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721856339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JW2r9j8mQOv8L20ytKQEodXEAKrw/64NLOuhUpNnWx4=;
	b=xCfaH6vxGOotfGXukU5Ib0IMs2/oXd8I2Aq8di09PefWJ0sN2Ye6NRzClfSm8JQd0yshZO
	E/spZ9xHY36uDBvOfSzTPOWRwB8T9LY4uGSnfkzdTZtqyhLruDCpyX11qQRcoHW8S3E146
	i8kDLadP3ho3UYVaNQevKY6zoAxCv8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721856339;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JW2r9j8mQOv8L20ytKQEodXEAKrw/64NLOuhUpNnWx4=;
	b=YycbtF93N95XgudlBzJl03Ve8S9mT+gk/zi0X+usIYY5d9nVWFwxM/EEnsa4yELIq/irXM
	tRVvsGV8Qu8BmnCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36F101324F;
	Wed, 24 Jul 2024 21:25:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ak2ZNlBxoWZKDwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 24 Jul 2024 21:25:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Steve Dickson" <steved@redhat.com>
Subject: Re: [PATCH 00/14 RFC] support automatic changes to nfsd thread count
In-reply-to: <FE431D13-1C6C-4336-8015-8A67EEDC23C5@oracle.com>
References: <20240715074657.18174-1-neilb@suse.de>,
 <FE431D13-1C6C-4336-8015-8A67EEDC23C5@oracle.com>
Date: Thu, 25 Jul 2024 07:25:29 +1000
Message-id: <172185632988.18529.2090587353377329647@noble.neil.brown.name>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A59AA1F7C3
X-Spam-Score: -4.31
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]

On Thu, 25 Jul 2024, Chuck Lever III wrote:
> 
> 
> > On Jul 15, 2024, at 3:14 AM, NeilBrown <neilb@suse.de> wrote:
> > 
> > This patch set (against nfsd-next) enables automatic adjustment of the
> > number of nfsd threads.  The number can increase under high load, and
> > reduce after idle periods.
> > 
> > The first few patches (1-6) are cleanups that may not be entirely
> > relevant to the current series.  They could safely land any time and
> > only need minimal review.
> 
> I'm trying to get moving on this series. So, I've reviewed 1-6,
> with one minor comment (posted previously). If you plan to
> repost 5/14, let me know, or you can send me a set of edits for
> its patch description and I can apply what's already been posted
> to nfsd-next now.

I do have plans - for code comments as well as commit comments.  I'll
try to send something on Friday.

> 
> I stopped at 7/14 because we should resolve whether to continue
> adding NOFAIL in new code. My impression, from attending the
> various LSF sessions on this topic, was that community consensus
> is "NOFAIL is NO BUENO". If we feel the community discussion is
> ongoing rather than concluded, then we'll have to sort this out
> ourselves.

I will post that NOFAIL patch more broadly - including fs-devel and
linux-mm and see if any consensus emerges.

Thanks,
NeilBrown

> 
> 
> --
> Chuck Lever
> 
> 
> 


