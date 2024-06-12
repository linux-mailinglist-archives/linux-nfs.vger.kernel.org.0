Return-Path: <linux-nfs+bounces-3682-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C67904A1E
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 06:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6683A1C2370B
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 04:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80580250EC;
	Wed, 12 Jun 2024 04:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DvHmMYYa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j3aoa0nq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ahvRYQe+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="smLqdDx+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E198E20DFF
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 04:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718167170; cv=none; b=Ox4igga6Nk8de1o7IhLffprEzaajNdm37zUkmJ7UmHgy+NE16jJVjb2a71a7tOBqhT6sDOOPK663ELmZ+yb5u2Vb0rf4iQq0x2Rpzpn3NDLdYyHDsw50wABCI+LL2TJPlWrysi77wnW85Fs/Wb7ZErju/Y8OWFPEoCsnq/X8rxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718167170; c=relaxed/simple;
	bh=NwWPrAeM2mQ67ELWvaTnws6c03oGHchZ7MZFKh/ZWx0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=OhaMW0WCpyOj32KZcD6u9BUSrnWpLuLhA0NAA24zHpv7azu8SRfYeY70ojvPdAsZVrkOo9Ve2IlJlnCXD9XcIu+8o1hpB5WXzS7+8xUTIKPJlJS+zvP1UCQBdZWLz22acOOeBrpE6bzGInClHNOOy//7FCqB/wcH2f26iqnRMTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DvHmMYYa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j3aoa0nq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ahvRYQe+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=smLqdDx+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E694F20F76;
	Wed, 12 Jun 2024 04:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718167166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3wo5EkhpP4WDZTnjcoQ4st6bEjO+Gwn6j5Ex2FrRiQ=;
	b=DvHmMYYaaJmvlF6GXujGEtnCc/qkfJVmKyjjGGYBGMwM8lwNLIUHpouocxLCGCFDBiNPwQ
	/OoK6KRlR1pN2LeOfE+WKIQKYVyw4dygH1sRj6FVX6ukd51W5SynT1nowbXpDhLl3RZW+M
	GHnbl5Dv66O4tEAEWo3CZZamJNu5osk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718167166;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3wo5EkhpP4WDZTnjcoQ4st6bEjO+Gwn6j5Ex2FrRiQ=;
	b=j3aoa0nqbTPgOu+uPpV95lk1DLVqCFmYpMxQtN/syIPToKXSsOPkMPtiwFIrDolEz26QWR
	ASzf6EmMQ5bH7OCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718167165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3wo5EkhpP4WDZTnjcoQ4st6bEjO+Gwn6j5Ex2FrRiQ=;
	b=ahvRYQe+53DFFpoMaY/CpgoyV1Fs3xo6KQzG5IoJuLljKmuU9sur7DHz2FuvsTJQmdYvds
	eX7LibGmdMsMiWhSrtgJDhqJFbLThqZ8XNI+doazR/2sntDmtevbrojLfFwOMaMsXjFLKy
	DzyV6q6pN6Td122dLDtI0Teac9wWFI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718167165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3wo5EkhpP4WDZTnjcoQ4st6bEjO+Gwn6j5Ex2FrRiQ=;
	b=smLqdDx+tH86qeaC9dKyaUkY1lNtxDfSqknrQF8wejLhIM3RgVVTEvQ25fybHEcXiQHtYd
	QH1XjhN5tLlRbOCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57F7D137DF;
	Wed, 12 Jun 2024 04:39:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LlY8O3omaWbMIAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Jun 2024 04:39:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [RFC PATCH v2 08/15] NFS: for localio don't call filesystem
 read() and write() routines directly
In-reply-to: <20240612030752.31754-9-snitzer@kernel.org>
References: <20240612030752.31754-1-snitzer@kernel.org>,
 <20240612030752.31754-9-snitzer@kernel.org>
Date: Wed, 12 Jun 2024 14:39:15 +1000
Message-id: <171816715571.14261.10325425432606108026@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCPT_COUNT_FIVE(0.00)[6]

On Wed, 12 Jun 2024, Mike Snitzer wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Some filesystem writeback routines can end up taking up a lot of stack
> space (particularly xfs). Instead of risking running over due to the
> extra overhead from the NFS stack, we should just call these routines
> from a workqueue job.
> 

Do we really need this today?  Kernel stack is a lot bigger than it once
was.

If we do need it, do we need a dedicated workqueue?  Why not just use
system_unbound_wq ??

NeilBrown

