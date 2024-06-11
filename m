Return-Path: <linux-nfs+bounces-3643-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EC9902E5E
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2024 04:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D001C21D0D
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2024 02:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C47615AAD7;
	Tue, 11 Jun 2024 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sGgGM0tZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="et/mc+f8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sGgGM0tZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="et/mc+f8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2868C04
	for <linux-nfs@vger.kernel.org>; Tue, 11 Jun 2024 02:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718072992; cv=none; b=cSC37NqLFNKlGH8pjL3GlF+qQNClr6/ipsZmzrEruADmc9jiHgBHQlkO20aweDmsNdCO7UqVmnAkYqkMnNmamQHs+GXvHC+teu/cw2klioVTrajrtcuMolkWJHLotVJQJFNjTawof1eh70R51IxNKVB55iBr6LBb57fjuHXyOPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718072992; c=relaxed/simple;
	bh=o3i5C0uxz2aqhzDjJ631ZLxZfAv7Zr3f6le2g0hkblc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=aG9fzZ/ca8/OmIh2xdRyMa/GvqwR5cJWEVpVZfI667BOwipV50WlCXff1L8VZdmyxhRKPkmRP8smdCBAIvdseZhGBuP+9wMNZ+feW9Qle50K/3gXi2WEn17SHxUV2W/MixoMn500ZqwCjE5w02+1oiP3Lcck6y1jZUWIYl9Pky4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sGgGM0tZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=et/mc+f8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sGgGM0tZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=et/mc+f8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 223E82036C;
	Tue, 11 Jun 2024 02:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718072989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVjH1fHvwfQQ1PVrJkDTO6ZXRA/W342Faxj5hOlWZ6M=;
	b=sGgGM0tZZ3ni9LHXf083sO61ArvvEGZ4D66I35vZ6DnsNFzACFLO1oTG+PCfeNT6Y2J/j6
	Ho0PxzD8WeBYxFnKtp3Z/405vsNj2NbbuQPRRHj8v4kG3v/ZqWFdhJhaXVuKThO0rxqE+5
	dWktFl6Pz8m3lrb2sym68SQgnJRwIck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718072989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVjH1fHvwfQQ1PVrJkDTO6ZXRA/W342Faxj5hOlWZ6M=;
	b=et/mc+f8i1I3Gk/L6wkVs6k4p2WaOwsYdFyTO6XjJNTY7DEuWV/hp3dC3zoG/4T0q0w/L8
	igqspgdDlMM+2SBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718072989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVjH1fHvwfQQ1PVrJkDTO6ZXRA/W342Faxj5hOlWZ6M=;
	b=sGgGM0tZZ3ni9LHXf083sO61ArvvEGZ4D66I35vZ6DnsNFzACFLO1oTG+PCfeNT6Y2J/j6
	Ho0PxzD8WeBYxFnKtp3Z/405vsNj2NbbuQPRRHj8v4kG3v/ZqWFdhJhaXVuKThO0rxqE+5
	dWktFl6Pz8m3lrb2sym68SQgnJRwIck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718072989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVjH1fHvwfQQ1PVrJkDTO6ZXRA/W342Faxj5hOlWZ6M=;
	b=et/mc+f8i1I3Gk/L6wkVs6k4p2WaOwsYdFyTO6XjJNTY7DEuWV/hp3dC3zoG/4T0q0w/L8
	igqspgdDlMM+2SBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE966137DF;
	Tue, 11 Jun 2024 02:29:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MNs4IJq2Z2ZifQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 11 Jun 2024 02:29:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "James Clark" <james.clark@arm.com>
Cc: linux-nfs@vger.kernel.org, ltp@lists.linux.it, broonie@kernel.org,
 Aishwarya.TCV@arm.com
Subject:
 Re: [PATCH] NFS: add atomic_open for NFSv3 to handle O_TRUNC correctly.
In-reply-to: <01c3bf2e-eb1f-4b7f-a54f-d2a05dd3d8c8@arm.com>
References: <>, <01c3bf2e-eb1f-4b7f-a54f-d2a05dd3d8c8@arm.com>
Date: Tue, 11 Jun 2024 12:29:42 +1000
Message-id: <171807298283.14261.13687949173694068461@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -4.26
X-Spam-Level: 
X-Spamd-Result: default: False [-4.26 / 50.00];
	BAYES_HAM(-2.96)[99.82%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
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
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Fri, 07 Jun 2024, James Clark wrote:
> 
> Hi Neil,
> 
> Now that your fix is in linux-next the statvfs01 test is passing again.
> However inotify02 is still failing.
> 
> This is because the test expects the IN_CREATE and IN_OPEN events to
> come in that order after calling creat(), but now they are reversed. To
> me it seems like it could be a test issue and the test should handle
> them in either order? Or maybe there should be a single inotify event
> with both flags set for the atomic open?

Interesting....  I don't see how any filesystem that uses ->atomic_open
would get these in the "right" order - and I do think IN_CREATE should
come before IN_OPEN.

Does NFSv4 pass this test?

IN_OPEN is generated (by fsnotify_open()) when finish_open() is called,
which must be (and is) called by all atomic_open functions.
IN_CREATE is generated (by fsnotify_create()) when open_last_lookups()
detects that FMODE_CREATE was set and that happens *after* lookup_open()
is called, which calls atomic_open().

For filesystems that don't use atomic_open, the IN_OPEN is generated by
the call to do_open() which happens *after* open_last_lookups(), not
inside it.

So the ltp test must already fail for NFSv4, 9p ceph fuse gfs2 ntfs3
overlayfs smb.

Can you confirm is that is, or is not, the case?

Thanks,
NeilBrown

