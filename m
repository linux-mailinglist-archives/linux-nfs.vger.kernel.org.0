Return-Path: <linux-nfs+bounces-4703-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22806929B3E
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 06:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27BB91C20AB3
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 04:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBE96FCC;
	Mon,  8 Jul 2024 04:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O0rc3t8+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p0XfdAP6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O0rc3t8+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p0XfdAP6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DFE6FC5
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jul 2024 04:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720411847; cv=none; b=pjrrVdYz//1OUduXSbI6HhI4bXu9IkbHYXpYb/RlhCNivDljSpK6xRHuOnecrnrfCAVEpEobkm4EYf/JH9EvXqdPxkQ+as0+IhMY9BUcTkrhNCgiviwrKc+xahd164t/B/M+BfryMJKNuZXS+U0Yr+aq9mvNJ1PVAXn0Xj7Ayz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720411847; c=relaxed/simple;
	bh=m987WkuDPlGftAnxdZP6Sk1VdBp6KrjMbhRCoI9IeJg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=pg/Ovdf7tLvzaxwTn7x2E0ZUIGHmPOQdPhud4MqRTXXRtV2WRa9upvtuMadh2xCUD6uNhextl/QC6CsOa3ndb29IgwcoZ90Tk9iknHFgPBzxQ9dB1cWVIicp7v5RLcrgncSSPdRowMl5ZODsK8hhvbJODqrxw79/HBLb0IvvxQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O0rc3t8+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p0XfdAP6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O0rc3t8+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p0XfdAP6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC4BD1FBBC;
	Mon,  8 Jul 2024 04:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720411843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OB1zH0n//0xoMnhJErfxYpmPyBjRULGG+TcAdVmfvPU=;
	b=O0rc3t8+63jxO6nwHzRP3Fl+b4vPJm3wHg31So/F++KB6j7zACqgq7tml7mPQ5XyBFw4Ud
	bJXMOJQ9wku4atPjSP24PDcl88S89aCvTEa743Z/zatRI1xPzvxe0OrWyUFskB71sN5GBk
	jWcquB8zYmrxeuCZMVtcvWvBSjlscMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720411843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OB1zH0n//0xoMnhJErfxYpmPyBjRULGG+TcAdVmfvPU=;
	b=p0XfdAP6PhljQPl1oUzL5G7SEr4LzFLjOuhHLidEPJcNGsGadhG3TpneZbyb8bZWL+IWyt
	igfB3uegqfICWzBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720411843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OB1zH0n//0xoMnhJErfxYpmPyBjRULGG+TcAdVmfvPU=;
	b=O0rc3t8+63jxO6nwHzRP3Fl+b4vPJm3wHg31So/F++KB6j7zACqgq7tml7mPQ5XyBFw4Ud
	bJXMOJQ9wku4atPjSP24PDcl88S89aCvTEa743Z/zatRI1xPzvxe0OrWyUFskB71sN5GBk
	jWcquB8zYmrxeuCZMVtcvWvBSjlscMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720411843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OB1zH0n//0xoMnhJErfxYpmPyBjRULGG+TcAdVmfvPU=;
	b=p0XfdAP6PhljQPl1oUzL5G7SEr4LzFLjOuhHLidEPJcNGsGadhG3TpneZbyb8bZWL+IWyt
	igfB3uegqfICWzBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E7BC12FF6;
	Mon,  8 Jul 2024 04:10:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MYP1BMBmi2b3VgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 08 Jul 2024 04:10:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: "Christoph Hellwig" <hch@infradead.org>,
 "Mike Snitzer" <snitzer@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Dave Chinner" <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
In-reply-to: <CCC79F21-93A6-4483-A0B8-62E062BE4E6A@oracle.com>
References: <>, <CCC79F21-93A6-4483-A0B8-62E062BE4E6A@oracle.com>
Date: Mon, 08 Jul 2024 14:10:36 +1000
Message-id: <172041183681.15471.6809923976922602158@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Sun, 07 Jul 2024, Chuck Lever III wrote:
> 
> Both the Linux NFS client and server implement RFC 8154
> well enough that this could be an alternative or even a
> better solution than LOCALIO. The server stores an XFS
> file system on the devices, and hands out layouts with
> the device ID and LBAs of the extents where file content
> is located.
> 
> The fly in this ointment is the need for NFSv3 support.

Another fly in this ointment is that only XFS currently implements that
.map_blocks export_operation, so only it could be used as a server-side
filesystem.

Maybe that would not be a barrier to Mike, but it does make it a lot
less interesting to me (not that I have a particular use case in mind,
but I just find "local bypass for NFSv4.1+ on XFS" less interesting than
"local bypass for NFS on Linux").

But my interest isn't a requirement of course.

> 
> In an earlier email Mike mentioned that Hammerspace isn't
> interested in providing a centrally managed directory of
> block devices that could be utilized by the MDS to simply
> inform the client of local devices. I don't think that's
> the only possible solution for discovering the locality of
> storage devices.

Could you sketch out an alternate solution so that it can be assessed
objectively? 

Thanks,
NeilBrown

