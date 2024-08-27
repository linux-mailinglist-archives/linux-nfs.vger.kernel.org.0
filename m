Return-Path: <linux-nfs+bounces-5807-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157CA961243
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 17:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E122811F7
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 15:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7681C3F17;
	Tue, 27 Aug 2024 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o+dYyyKx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bgprGjwO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o+dYyyKx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bgprGjwO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C141BC073;
	Tue, 27 Aug 2024 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772434; cv=none; b=MDKjWyz/73eVkpnAWpxUHBiBapjfizEzzWLkUYogfFC0VpoLZkwpVc9u04rmu+YT0b3A8mKgyeTimYuQlCs1lqI7CzjWU9XSfIsSjMkUZPAalU9+RTUyAztH1KtgLtZ7biqJHhcopg093829yCQVD1zy/3BUdvDVpAr6PC2f7go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772434; c=relaxed/simple;
	bh=Rkd112+cL0uRYtV9jUWbMqRMP2d4qZA0DESvv5WzZoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyLIurDiSTJ52rApgArBTiDl8/MmdP1CHiDMEmwDxZHm/QIzXBkOmO/Ziv8daZP0OeJzPjNKnY3oexnlj18+9VxG7tdAe8e+/augWV3lvVEqyu1MKaYj37pxie2aheKRPvmubz0inpNg/aXH0uVHZQnfBoyGIS1opW6Ir4Hn3Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o+dYyyKx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bgprGjwO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o+dYyyKx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bgprGjwO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0163121B0E;
	Tue, 27 Aug 2024 15:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724772430;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DiRuT6KS5xm/a1uK/VGs5u1puvYNGTCyQqWHx/rE3bo=;
	b=o+dYyyKxYYk97NirY9aGv5IfKvHrHrqFWWqd9hJ+rwZaiV4IMrT9fYnxGt86PR0jNIoMJV
	6l92S7RFOOAUCK1SjpiOfDcCmedGKugqzx9JI6yMoBCg3KhOvtw4+eed8G9Pgjf6WcAUET
	Jh3kYsoBPntmoJJxkX3N0PRNUtT/vQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724772430;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DiRuT6KS5xm/a1uK/VGs5u1puvYNGTCyQqWHx/rE3bo=;
	b=bgprGjwOLEXZUcFTaD/4uIXDLmpzKCJ5Gjx7/8DrVfnaXTc6U7kK8itUTGzddff1AbSyGw
	+B2JIMwaO0HJFuBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=o+dYyyKx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bgprGjwO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724772430;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DiRuT6KS5xm/a1uK/VGs5u1puvYNGTCyQqWHx/rE3bo=;
	b=o+dYyyKxYYk97NirY9aGv5IfKvHrHrqFWWqd9hJ+rwZaiV4IMrT9fYnxGt86PR0jNIoMJV
	6l92S7RFOOAUCK1SjpiOfDcCmedGKugqzx9JI6yMoBCg3KhOvtw4+eed8G9Pgjf6WcAUET
	Jh3kYsoBPntmoJJxkX3N0PRNUtT/vQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724772430;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DiRuT6KS5xm/a1uK/VGs5u1puvYNGTCyQqWHx/rE3bo=;
	b=bgprGjwOLEXZUcFTaD/4uIXDLmpzKCJ5Gjx7/8DrVfnaXTc6U7kK8itUTGzddff1AbSyGw
	+B2JIMwaO0HJFuBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5FE113724;
	Tue, 27 Aug 2024 15:27:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hmVCJ03wzWbUJAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 27 Aug 2024 15:27:09 +0000
Date: Tue, 27 Aug 2024 17:27:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Martin Doucha <mdoucha@suse.cz>, Neil Brown <neilb@suse.de>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-stable <stable@vger.kernel.org>,
	"ltp@lists.linux.it" <ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH v2 1/1] nfsstat01: Update client RPC calls for
 kernel 6.9
Message-ID: <20240827152702.GA1634061@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240823064640.GA1217451@pevik>
 <172445038410.6062.6091007925280806767@noble.neil.brown.name>
 <9afef16d-52b2-435d-902a-7ccfa5824968@suse.cz>
 <20240827132242.GA1627011@pevik>
 <44DF7F99-3FDA-46C0-BC93-B6679F04B7AB@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44DF7F99-3FDA-46C0-BC93-B6679F04B7AB@oracle.com>
X-Rspamd-Queue-Id: 0163121B0E
X-Spam-Level: 
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.71
X-Spam-Flag: NO

Hi all,

> > On Aug 27, 2024, at 9:22 AM, Petr Vorel <pvorel@suse.cz> wrote:

> > Hi all,

> >> On 23. 08. 24 23:59, NeilBrown wrote:
> >>> On Fri, 23 Aug 2024, Petr Vorel wrote:
> >>>> We discussed in v1 how to fix tests.  Neil suggested to fix the test the way so
> >>>> that it works on all kernels. As I note [1]

> >>>> 1) either we give up on checking the new functionality still works (if we
> >>>> fallback to old behavior)

> >>> I don't understand.  What exactly do you mean by "the new
> >>> functionality".
> >>> As I understand it there is no new functionality.  All there was was and
> >>> information leak between network namespaces, and we stopped the leak.
> >>> Do you consider that to be new functionality?

> > Thanks Martin for jumping in. I hoped I was clear, but obviously not.

> > Following are the questions for kernel maintainers and developers. I put my
> > opinion, but it's really up to you what you want to have tested.

> >> The new functionality is that the patches add a new file to network
> >> namespaces: /proc/net/rpc/nfs. This file did not exist outside the root
> >> network namespace at least on some of the kernels where we still need to run
> >> this test. So the question is: How aggressively do we want to enforce
> >> backporting of these NFS patches into distros with older kernels?

> >> We have 3 options how to fix the test depending on the answer:
> >> 1) Don't enforce at all. We'll check whether /proc/net/rpc/nfs exists in the
> >> client namespace and read it only if it does. Otherwise we'll fall back on
> >> the global file.

> > 1) is IMHO the worst case because it's not testing patch gets reverted.

> >> 2) Enforce aggressively. We'll hardcode a minimal kernel version into the
> >> test (e.g. v5.4) and if the procfile doesn't exist on any newer kernel, it's
> >> a bug.

> > I would prefer 2), which is the usual LTP approach (do not hide bugs, we even
> > fail on upstream kernel WONTFIX [1], why we should refuse the policy here?).

> 2) makes sense to me.

Thanks for your opinion. I'll send another version (+ still wait for others input).

Kind regards,
Petr

> > Whichever older LTS upstream kernel gets fixed would drive the line where new
> > functionality is requested (currently v5.14, I suppose at least 5.10 will also
> > be fixed). LTP also has a way to specify enterprise distro kernel version if
> > older enterprise kernel also gets fixed (this should not be needed, but it'd be
> > possible).

> >> 3) Enforce on new kernels only. We'll set a hard requirement for kernel
> >> v6.9+ as in option 2) and check for existence of the procfile on any older
> >> kernels as in option 1).

> > Due way to specify enterprise distro kernel version and upstream kernel testing
> > expecting people update to the latest stable/LTS we should not worry much about
> > people with older kernels.

> > Kind regards,
> > Petr

> > [1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/ustat/ustat01.c#L48-L49

