Return-Path: <linux-nfs+bounces-5343-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7609513BA
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 07:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1CF1C24043
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 05:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A46939879;
	Wed, 14 Aug 2024 05:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uUl1uoqa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iSoaAk0m";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="keMY5dXq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9HGI0FCA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6122755887
	for <linux-nfs@vger.kernel.org>; Wed, 14 Aug 2024 05:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723611722; cv=none; b=LbK0dlz0kbwCodeZyDkxDYv0WptWlpp4wonnLZ/+GXz1/ixwRolrJ876txw0xCBlX7e8IzfwZYQ9Ag+dIpMf1WLHr2ADc+4utCgxZo69X9TBJP5jQ8Yt4B+xD+Cltds0DUSmSfPWiiZclDKjseZ+vUTQq8uJ+AVdBjGDLvtgUkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723611722; c=relaxed/simple;
	bh=FIrHXP/MJ3pkhZfhtJ7xeGetihRBw0vy7Ed75UCNlVI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=YUdCGYby5zKptI9KOAm3w4M/EkEPJCEGoXy9g4QD3qKEc80Ez73X5RlvPBaDQ5hCXeOxtM0HVFxPLgVD4yCfweuoIAukBJojXiwxrh72sD0zGv/buqHIxleX42Yo5H4B3W6JWqRxqSI/YaWQkzqG2NuTBWWk8WOAtasbt8KWBIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uUl1uoqa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iSoaAk0m; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=keMY5dXq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9HGI0FCA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 24D681FCEF;
	Wed, 14 Aug 2024 05:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723611717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8F9S9R9bytoYT3v+dxA/9XdYc+4CZo6yIuDsVZreZw=;
	b=uUl1uoqagTSXJrX7NT+cezgmlmrMsT1NOrBTBkJ2xvaxX+yaJVrpz/7jbsRaw712GRwlKO
	NPE2cmcAXJGWIS+VhA/FoHlMSe/oxi+UOrpQEdKQ1GcXmaG4qZxIdqqLZ1I+uVyJ85BKRg
	mpUZ+qDxFwFm9ueEN87veMbMjlo3EWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723611717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8F9S9R9bytoYT3v+dxA/9XdYc+4CZo6yIuDsVZreZw=;
	b=iSoaAk0mgM5SHNF1NCE51nvQ345ImPiqbf+xh7+ZFxcHjiflao1mwdFyPjwqKWxru+XlAU
	jBYaDfEIay1+t6Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=keMY5dXq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9HGI0FCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723611716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8F9S9R9bytoYT3v+dxA/9XdYc+4CZo6yIuDsVZreZw=;
	b=keMY5dXq6KBSHgCxGuJC6QhzFMLcBbDx+zS2qxAD1CUU398wnN1YBt06jfXwbwu1j1dYV3
	X2xzWhw7qs6UK8opBaT6inTVT5DVHQt4Z0pZ6LYkttY7vGB00P9KzEcYs0WIcs0/RxFWGe
	0Woj5VAGvbyH5simsvQpEQADrPadxAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723611716;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8F9S9R9bytoYT3v+dxA/9XdYc+4CZo6yIuDsVZreZw=;
	b=9HGI0FCAXa0BPWFdC6b9Hm8o357l9jXlsMlm6mFlk5XuhsxVYegmA+G2j52jMbXNx7nHNh
	uqPH558EiLbHdXBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5B74139B9;
	Wed, 14 Aug 2024 05:01:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M9VyJkI6vGZPCAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 14 Aug 2024 05:01:54 +0000
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
Subject: Re: [PATCH] SQUASH: nfsd: move error choice for incorrect object
 types to version-specific code.
In-reply-to: <ZrofRICmD8kDFP7X@tissot.1015granger.net>
References: <172343558582.6062.9756574878881138559@noble.neil.brown.name>,
 <ZrofRICmD8kDFP7X@tissot.1015granger.net>
Date: Wed, 14 Aug 2024 15:01:51 +1000
Message-id: <172361171154.6062.12860479041598912260@noble.neil.brown.name>
X-Rspamd-Queue-Id: 24D681FCEF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 13 Aug 2024, Chuck Lever wrote:
> On Mon, Aug 12, 2024 at 02:06:25PM +1000, NeilBrown wrote:
> > 
> > [This should be squashed into the existing patch for the same name,
> > with this commit message used instead of the current one.  It addresses
> > the pynfs failures that Jeff found]
> > 
> > If an NFS operation expects a particular sort of object (file, dir, link,
> > etc) but gets a file handle for a different sort of object, it must
> > return an error.  The actual error varies among NFS version in non-trivial
> > ways.
> > 
> > For v2 and v3 there are ISDIR and NOTDIR errors and, for NFSv4 only,
> > INVAL is suitable.
> > 
> > For v4.0 there is also NFS4ERR_SYMLINK which should be used if a SYMLINK
> > was found when not expected.  This take precedence over NOTDIR.
> > 
> > For v4.1+ there is also NFS4ERR_WRONG_TYPE which should be used in
> > preference to EINVAL when none of the specific error codes apply.
> > 
> > When nfsd_mode_check() finds a symlink where it expected a directory it
> > needs to return an error code that can be converted to NOTDIR for v2 or
> > v3 but will be SYMLINK for v4.  It must be different from the error
> > code returns when it finds a symlink but expects a regular file - that
> > must be converted to EINVAL or SYMLINK.
> > 
> > So we introduce an internal error code nfserr_symlink_not_dir which each
> > version converts as appropriate.
> > 
> > nfsd_check_obj_isreg() is similar to nfsd_mode_check() except that it is
> > only used by NFSv4 and only for OPEN.  NFSERR_INVAL is never a suitable
> > error if the object is the wrong time.  For v4.0 we use nfserr_symlink
> > for non-dirs even if not a symlink.  For v4.1 we have nfserr_wrong_type.
> > To handle this difference we introduce an internal status code
> > nfserr_wrong_type_open.
> > 
> > As a result of these changes, nfsd_mode_check() doesn't need an rqstp
> > arg any more.
> > 
> > Note that NFSv4 operations are actually performed in the xdr code(!!!)
> > so to the only place that we can map the status code successfully is in
> > nfsd4_encode_operation().
> 
> Thanks for noting the RFC sections in the comments, that will be
> very helpful for us forgetful old farts.
> 
> nfsd_check_obj_isreg's only caller is do_open_lookup, and the minor
> version number is available there, via nfsd4_compound_state. If the
> minor version is passed to nfsd_check_obj_isreg, it can correctly
> choose to return nfserr_symlink or nfserr_wrong_type, yes? That
> would eliminate the need for nfserr_wrong_type_open, perhaps.

Probably a good idea.  The original goal of this series was to reduce
the number of checks on version number by moving version-specific choices
to version-specific code.  However that doesn't apply to differences
between 4.0 and 4.1 as we don't have distinct code for the distinct
minor versions.

I'll post an alternate SQUASH patch.

> 
> What were the other error code leaks you found?

They were happening because I was calling nfsd4_map_status() before
nfsd4_encode_operation().  This is *before* the status in set in many
cases.  status is often set inside the xdr encode functions called by
nfsd4_encode_operation().  Moving the call to nfsd4_map_status() inside
that function fixed those leaks.

NeilBrown


