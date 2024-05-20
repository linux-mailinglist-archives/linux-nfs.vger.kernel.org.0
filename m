Return-Path: <linux-nfs+bounces-3288-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA3B8C9889
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2024 05:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B5E282AA2
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2024 03:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40019168B7;
	Mon, 20 May 2024 03:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z/Bn3fMa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="epi1zt9j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z/Bn3fMa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="epi1zt9j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724FD1643D
	for <linux-nfs@vger.kernel.org>; Mon, 20 May 2024 03:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716177171; cv=none; b=DfTsUQ/SMBdJ6FS5SXfiLhWIPDYCLgiBi4wyf/vCxRezts5kQrCydVWx4szwqTnLZ6Gmrl1CIoI3F4AA8Slzj/jXNqajmitamn90+YKP3NpcrcBaFUSVd9KnfGipVfN99TUwg//0vvG3OGtj2uVRBvC6eGFf3BkQNBhtUPtsP7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716177171; c=relaxed/simple;
	bh=512lwFYZj/dkJy6zmEpeaPmu++9KiYDVJ0J5jWXPxfg=;
	h=Content-Type:MIME-Version:From:To:Subject:In-reply-to:References:
	 Date:Message-id; b=leZ8xOfeB+VJZputFNziIwkfL1wyFqbYBTe4fStEnFoZaVfGIlLiDmgDhCWwDHyHRM0hTqFC2nP4DhYjLTIWbp+KPWX3Sa4L1s5JUA5ALJTNehhufWy9HIei+A1nnjOc31fGxywNU1ucB3trv71B4yICMn18nF7OQEGQn4zQlTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z/Bn3fMa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=epi1zt9j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z/Bn3fMa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=epi1zt9j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6FEA833E16
	for <linux-nfs@vger.kernel.org>; Mon, 20 May 2024 03:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716177167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YyROcX46237N+5/obp3dYYop2lGhT5zov81nelPO3M0=;
	b=z/Bn3fMaQ9nVvdxhMHWOyU/+ygS7XVp0PdO5+R19raXcIFqm4HcofxG6g2+l3M5Cwqnh3j
	9JtqeP3Qb+Uus4sHWV+aZUe/HAsqFopilihWgnx5vfJ5XS9iJfB7ilsBnTmufPS9+q/AA7
	S1kjqv8bZP2OEjsi2uuV1j0W8Keuxj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716177167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YyROcX46237N+5/obp3dYYop2lGhT5zov81nelPO3M0=;
	b=epi1zt9jwPTWO/j40OqxUtB0qgTPMmE+SCRzMIISS4xuRdJR90vUfxr0+VlxSpsZl18tI9
	6L9GTAEUBlfc/JDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="z/Bn3fMa";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=epi1zt9j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716177167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YyROcX46237N+5/obp3dYYop2lGhT5zov81nelPO3M0=;
	b=z/Bn3fMaQ9nVvdxhMHWOyU/+ygS7XVp0PdO5+R19raXcIFqm4HcofxG6g2+l3M5Cwqnh3j
	9JtqeP3Qb+Uus4sHWV+aZUe/HAsqFopilihWgnx5vfJ5XS9iJfB7ilsBnTmufPS9+q/AA7
	S1kjqv8bZP2OEjsi2uuV1j0W8Keuxj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716177167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YyROcX46237N+5/obp3dYYop2lGhT5zov81nelPO3M0=;
	b=epi1zt9jwPTWO/j40OqxUtB0qgTPMmE+SCRzMIISS4xuRdJR90vUfxr0+VlxSpsZl18tI9
	6L9GTAEUBlfc/JDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5E881378C
	for <linux-nfs@vger.kernel.org>; Mon, 20 May 2024 03:52:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dVFGEg7JSmZcegAAD6G6ig
	(envelope-from <neilb@suse.de>)
	for <linux-nfs@vger.kernel.org>; Mon, 20 May 2024 03:52:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: linux-nfs@vger.kernel.org
Subject: Re: When are layouts destroyed on server reboot
In-reply-to: <171617508551.18863.10945867499281791407@noble.neil.brown.name>
References: <171617508551.18863.10945867499281791407@noble.neil.brown.name>
Date: Mon, 20 May 2024 13:52:42 +1000
Message-id: <171617716265.18863.8448767801936248728@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-6.17 / 50.00];
	BAYES_HAM(-2.66)[98.49%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6FEA833E16
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -6.17

On Mon, 20 May 2024, NeilBrown wrote:
> 
> Hi,
>  I have a customer who is experiencing a problem on an older kernel.
>  After a server restart (actually a cluster fail-over) the client
>  recovers all opens and locks correctly, but then sends a (previously
>  queued) WRITE request with a filehandle/stateid for a LAYOUT that was
>  provided by the server before the restart.  Unsurprisingly this doesn't
>  work.
> 
>  I've been hunting through the code to find out where the code attempts
>  to invalidate all layouts as required by 12.7.4 in RFC-5661.  But I
>  cannot find it.
> 
>  I'm guessing that adding a call to pnfs_destroy_layout() in
>  __nfs4_reclaim_open_state() would do the trick but maybe there is a
>  better way that is already implemented in later kernels, that I cannot
>  find.
> 
>  Any pointers?

I think I found it. nfs4_establish_lease() calls pnfs_destroy_layouts().
And that is present in the old kernel that isn't working... both.  Must
be something else.
Sorry for the noise.

NeilBrown

