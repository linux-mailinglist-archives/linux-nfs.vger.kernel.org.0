Return-Path: <linux-nfs+bounces-6501-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497F99799E5
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 04:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B473F280618
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 02:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B045223;
	Mon, 16 Sep 2024 02:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JCe4sKYa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RnWLL1xe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JCe4sKYa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RnWLL1xe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F071B85F9
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 02:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726452267; cv=none; b=QGOSTcbATvXIZmIJBaQN9kcUUhq15vH1yif0r1V+nMhl0+3L9T2Vd+SH7u7sMTlS6BeeUuzxAmzPUn9ndQ+bSwFKK4WwS5y6Nvc2xcrGg9gZK5DaXTSUdgA+jvT7hz5dNkglP4pGpwchlUbE8mEVbMA0JPgdZdbiihuufVLHeNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726452267; c=relaxed/simple;
	bh=TNeoAiW6wraKC7OTx0xAxvutEdaJcGq+TiXiWHet6V4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=IJyaJQbAA3IqAPTcS44JcHgoeIRv2sNUzccDqCUdYd3yGT+nbgG2hFApc4uSqzylmnP/vQcVctmoUvSB8l3tHuSw5sx+0MdT+KJhS5FCjfJgGSOYYkP4EvsYaZXNayzj/gJ8yxcNSpO00ECWNxSu0Y5R2cUpazK6a6r3ce7F/rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JCe4sKYa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RnWLL1xe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JCe4sKYa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RnWLL1xe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BDE5D1F83E;
	Mon, 16 Sep 2024 02:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726452263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VUag/Zo8y41zXffBpZVlTHOl9xMtf6knMt1ztNTezfs=;
	b=JCe4sKYaoNk+/5rTGl2zSmQm0FSqnYiv1fVMh0uo0LcGXZUc7zJtDtOdVNzPMOOhGleru+
	IcVtypbZ3OqlnadwDpZhwETaViKx26wlO5RjQU9R+aNRA1d7ZpI7xNW8FS8fe8+9F+/EXj
	09QSbhoje2JL59eS9BFNXWNpk+4RtZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726452263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VUag/Zo8y41zXffBpZVlTHOl9xMtf6knMt1ztNTezfs=;
	b=RnWLL1xeOoSt0FDmeub5Uv+ElLx2mdejgNzpakakFcIAHVaG2bw25yHLebOLptCzXx60J8
	Cuys8pnuokNeA1CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JCe4sKYa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RnWLL1xe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726452263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VUag/Zo8y41zXffBpZVlTHOl9xMtf6knMt1ztNTezfs=;
	b=JCe4sKYaoNk+/5rTGl2zSmQm0FSqnYiv1fVMh0uo0LcGXZUc7zJtDtOdVNzPMOOhGleru+
	IcVtypbZ3OqlnadwDpZhwETaViKx26wlO5RjQU9R+aNRA1d7ZpI7xNW8FS8fe8+9F+/EXj
	09QSbhoje2JL59eS9BFNXWNpk+4RtZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726452263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VUag/Zo8y41zXffBpZVlTHOl9xMtf6knMt1ztNTezfs=;
	b=RnWLL1xeOoSt0FDmeub5Uv+ElLx2mdejgNzpakakFcIAHVaG2bw25yHLebOLptCzXx60J8
	Cuys8pnuokNeA1CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6F0513A8A;
	Mon, 16 Sep 2024 02:04:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kBb0FiWS52YlWAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 16 Sep 2024 02:04:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Olga Kornievskaia" <okorniev@redhat.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix delegation_blocked() to block correctly for at
 least 30 seconds
In-reply-to: <172644946897.17050.6911884875937617912@noble.neil.brown.name>
References:
 <CACSpFtDNpOMfRt1Msbo4XNaja5_Nuhxd5Vs51UvjCap5Z9-wLg@mail.gmail.com>,
 <172644946897.17050.6911884875937617912@noble.neil.brown.name>
Date: Mon, 16 Sep 2024 12:04:10 +1000
Message-id: <172645225046.17050.8735780069132152636@noble.neil.brown.name>
X-Rspamd-Queue-Id: BDE5D1F83E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Mon, 16 Sep 2024, NeilBrown wrote:
> On Thu, 12 Sep 2024, Olga Kornievskaia wrote:
> > 
> > What about vfs_truncate() which also calls break_lease?
> 
> vfs_truncate() is quite different, though that isn't a good excuse for
> me to leave it out.  It uses break_lease() like open does - not
> try_break_deleg() like rename.
> It can do this because it has called get_write_access() in the inode
> which has incremented i_writecount which will prevent leases from being
> granted.  But that DOESN'T prevent delegations from being granted.  I
> think it should.

Actually it does.  check_conflicting_opens() does cause the delegation
request to fail because it is a no-op for delegations.
But between getting the delegation and hashing the delegation,
nfsd4_check_conflicting_opens() is called and it fails if i_writecount
has been elevated.

So the break_lease() from vfs_truncate() is safe - delegations are
prevented until the truncation completes.

NeilBrown

