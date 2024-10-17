Return-Path: <linux-nfs+bounces-7254-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E286D9A2F14
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 22:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2491C2140E
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 20:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107521DF26C;
	Thu, 17 Oct 2024 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TCCzmJQK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KMxYKQnU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TCCzmJQK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KMxYKQnU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F74168BD
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 20:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729198623; cv=none; b=Um+v2onAVxk53PK3BRwERZc2gyDwbw+PUB40oQU7HkjLamXtJmi4/se5G/ui3WOso5PoywtW4WeBlP2lU4J+j2TEjlqmY2+TqSatoHNVjfeAMQsF4/S5TQLKVMI/7/vs+pfCvdppdTroetFJ1qaMIIgIMK/8BvIE0aBeQiDc8IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729198623; c=relaxed/simple;
	bh=0V0aRppF6azpZlnfMonjhOr1FSkw9mz+kQlkdm8AXis=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=tT4F0+627B27FMR3MQzCMLv2Rz2UiNAZVfSfrWZyeWRTxMFTXRa5aJ0IgRS/kZI80Aa+BQljBxz+WhkOxEyCF+df8jFcyib9GoYYttdtralqpgRnRgS9mo6Sagf6+ZhOArn83dl7U0335Y8v6+7T8jV6/pDmKwLLo7N6r9J9Nwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TCCzmJQK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KMxYKQnU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TCCzmJQK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KMxYKQnU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 58C301F78A;
	Thu, 17 Oct 2024 20:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729198619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrqBh0TFJk82qpBfFl2wUGlMPSz4OyfMMZv+HcWh3jc=;
	b=TCCzmJQKwqebRmKQD865P78YXJ6e31YxgBiXdyFazciFDGZORfDxQhUlre5/JrWDpNYBil
	3qWGJlKn9Y3NGt2wIraYqbJ0mxdpjfbkZaTZZYaDkmvqedOsdi38YkJBZszvfqpvlnigYd
	Qtn3jNwP1yS46M1gPwp62FSCen9hufk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729198619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrqBh0TFJk82qpBfFl2wUGlMPSz4OyfMMZv+HcWh3jc=;
	b=KMxYKQnU6pe/FVilg+Hk2vryKZ9RI3gmyxNfTYvBH/fC8RjroIr+fzT8pHg+1YMAWS8G7r
	/pSPMmXmDTqZewCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729198619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrqBh0TFJk82qpBfFl2wUGlMPSz4OyfMMZv+HcWh3jc=;
	b=TCCzmJQKwqebRmKQD865P78YXJ6e31YxgBiXdyFazciFDGZORfDxQhUlre5/JrWDpNYBil
	3qWGJlKn9Y3NGt2wIraYqbJ0mxdpjfbkZaTZZYaDkmvqedOsdi38YkJBZszvfqpvlnigYd
	Qtn3jNwP1yS46M1gPwp62FSCen9hufk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729198619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrqBh0TFJk82qpBfFl2wUGlMPSz4OyfMMZv+HcWh3jc=;
	b=KMxYKQnU6pe/FVilg+Hk2vryKZ9RI3gmyxNfTYvBH/fC8RjroIr+fzT8pHg+1YMAWS8G7r
	/pSPMmXmDTqZewCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F38B113A42;
	Thu, 17 Oct 2024 20:56:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y5sLKhh6EWf+EQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 17 Oct 2024 20:56:56 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>, "Chuck Lever" <cel@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5/5] lockd: Remove unneeded initialization of
 file_lock::c.flc_flags
In-reply-to: <396ABDBD-E05E-44F7-8297-CE421EB44319@oracle.com>
References: <>, <396ABDBD-E05E-44F7-8297-CE421EB44319@oracle.com>
Date: Fri, 18 Oct 2024 07:56:52 +1100
Message-id: <172919861235.81717.17351924666029125819@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Fri, 18 Oct 2024, Chuck Lever III wrote:
> 
> Which is going away when NFSv2 is removed. I'm not too concerned
> about that duplication.
> 

We have a customer with industrial hardware which stores data (logs?)
via NFSv2.  So we might need to continue to support v2 indefinitely.

Possibly we could use a user-space-nfsd solution if/when v2 service is
removed from the kernel, but I would rather not.

Reverting the nfs-utils patches which remove v2 support is fairly easy. 
Reverting kernel patches that remove v2 support wouldn't be so easy in
the long term.

So I'd vote for not removing NFSv2 from the server.

Thanks,
NeilBrown

