Return-Path: <linux-nfs+bounces-4588-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFD0925E57
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 13:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AAAB1F25BDE
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 11:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4871802CD;
	Wed,  3 Jul 2024 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="toDhpS90";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X9wrxc4W";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="toDhpS90";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X9wrxc4W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E20313A27E;
	Wed,  3 Jul 2024 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006151; cv=none; b=GE78mqOKQLSDVN/6l0+NWfMIeBYizZA33U00hKf9r9tb+vCQZvJJsWIGByFD07fVDbU9Kz8Owwt4GoaNXSB2bSk9lqdS+9WfyXVGl6z5i492pTRqkys37HamJM+M7MM0RkO8g0Y1DnLAK8fQoqZsZriW/SehE17/pkQzSaBViBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006151; c=relaxed/simple;
	bh=clBp2gFjYxSBPCBVP1prGGDuX8fZP+r2pa/gnb/vNMw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=X/jmiu1otl+1smez0LediTwm8WUEw+RwJEc1W/v/ab61gSP9DpoJ03gp7CUCzlgvtetF2blA/Nem9xBEgrsPAwR0Cq67rMA3dLh65Gx5fAqEdiQuG1UKil/W3ESHpk5ha4uJTpZeMltzGVx/xsPcvkEmIDGoN22yMSoRQrn/HLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=toDhpS90; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X9wrxc4W; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=toDhpS90; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X9wrxc4W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4D17C1F441;
	Wed,  3 Jul 2024 11:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720006148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uKNyrV9edPI4vFa2o5JZwjYeXioTNrHBFMbQb1xQySM=;
	b=toDhpS90U9SBxoxR1CNAeIdQzq8sEHtPUYv2mska0/8uVV3pa6LSDAfmLGbo0uEg861Ks7
	R6Qb360gQK1AS0LuZ6C8SnHIZtnaGyTGs2LFLvvkrolp2tJiEDXCCmJOcShkhYVpq3lhyB
	cJEcidHcGH+syhrqJHfH9L2NW/oFs8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720006148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uKNyrV9edPI4vFa2o5JZwjYeXioTNrHBFMbQb1xQySM=;
	b=X9wrxc4WJVk/oL7l8lYQIIcfEopNnBkiOuHx7Q2l6zHt6pErLv0YmXwGo58l7RqQnGZcRP
	io3NWnN/sTUbSWCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=toDhpS90;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=X9wrxc4W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720006148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uKNyrV9edPI4vFa2o5JZwjYeXioTNrHBFMbQb1xQySM=;
	b=toDhpS90U9SBxoxR1CNAeIdQzq8sEHtPUYv2mska0/8uVV3pa6LSDAfmLGbo0uEg861Ks7
	R6Qb360gQK1AS0LuZ6C8SnHIZtnaGyTGs2LFLvvkrolp2tJiEDXCCmJOcShkhYVpq3lhyB
	cJEcidHcGH+syhrqJHfH9L2NW/oFs8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720006148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uKNyrV9edPI4vFa2o5JZwjYeXioTNrHBFMbQb1xQySM=;
	b=X9wrxc4WJVk/oL7l8lYQIIcfEopNnBkiOuHx7Q2l6zHt6pErLv0YmXwGo58l7RqQnGZcRP
	io3NWnN/sTUbSWCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2EAB13974;
	Wed,  3 Jul 2024 11:29:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OwPvFQE2hWZLeQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 03 Jul 2024 11:29:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Dave Chinner" <david@fromorbit.com>, "Mike Snitzer" <snitzer@kernel.org>,
 linux-xfs@vger.kernel.org, "Brian Foster" <bfoster@redhat.com>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] xfs: enable WQ_MEM_RECLAIM on m_sync_workqueue
In-reply-to: <ZoI0dKgc8oRoKKUn@infradead.org>
References: <>, <ZoI0dKgc8oRoKKUn@infradead.org>
Date: Wed, 03 Jul 2024 21:29:00 +1000
Message-id: <172000614061.16071.4185403871079452726@noble.neil.brown.name>
X-Rspamd-Queue-Id: 4D17C1F441
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Mon, 01 Jul 2024, Christoph Hellwig wrote:
> On Mon, Jul 01, 2024 at 09:46:36AM +1000, Dave Chinner wrote:
> > Oh, that's nasty.
> 
> Yes.
> 
> > We now have to change every path in every filesystem that NFS can
> > call that might defer work to a workqueue.
> 
> Yes.  That's why the kernel for a long time had the stance that using
> network file systems / storage locally is entirely unsupported.

I know nothing of this stance.  Do you have a reference?

I have put a modest amount of work into ensure NFS to a server on the
same machine works and last I checked it did - though I'm more
confident of NFSv3 than NFSv4 because of the state manager thread.

Also /dev/loop can be backed by a file, and have a filesystem mounted on
it, and if that didn't work I'm sure we would have complaints.

> 
> If we want to change that we'll have a lot of work to do.

What sort of work are you thinking of?

Thanks,
NeilBrown


> 
> 
> 


