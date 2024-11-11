Return-Path: <linux-nfs+bounces-7835-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 061999C3563
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 01:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801371F21749
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 00:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFFD749C;
	Mon, 11 Nov 2024 00:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VJsF8XIG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O/f/CEM1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bGsDnGVx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SsdKsh4x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A590749A
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 00:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731285389; cv=none; b=VjRaxauKbzlBEV/5yckOj7bOGDPsUWOH8OkgDCrk1hhoTKlIDjRC8kvR1BxPGaT/EpuV0RdAhdCAkC8qSpT8M9tEWoyX3rSgC4PU4aNQrMObKpgB0W05N6+l5/2gGULzywFay4/PDjhIfH8codNcuT83XS1snTXxWDjL3jabq8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731285389; c=relaxed/simple;
	bh=y1RHs7wnGsPfAE0wrRY99Uo4Uiz1vr1gsyB5vwkprF4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=lVpAFl/K4MTJB0INLHDuo2l7Ktf3qWqnP7hXI0z+EA/vVXSGpiMruYdbCX3jxqPGqI4OFkLs0F38x3YqL78phqF3u8ye6DwYZ1CZqcYsowPRMuMCEDbFfjteFiB6EBNVIOL+fZIqvKJlesw/DvLGY7qJNySs/wgyJYcuavCanbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VJsF8XIG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O/f/CEM1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bGsDnGVx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SsdKsh4x; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D081219F4;
	Mon, 11 Nov 2024 00:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731285385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8jBWU5hWQRsIooZM+OTxJPQqoti8v20/3MJD8aQqg8=;
	b=VJsF8XIGPdbkQu73akux/n41gf3Jw373bKPRYqk+sxu5HImhAdLRHQ3wYATUP7d2CQQIiZ
	S/CTBr7yQu/Ribs9ec/M51PObbg9XOvA+yvl3WJauPG8PRU5lkW0KBsMoo42XzG4WcG19U
	ckudnkaLPMXvBeQOmpK5FQQfG5PxP/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731285385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8jBWU5hWQRsIooZM+OTxJPQqoti8v20/3MJD8aQqg8=;
	b=O/f/CEM18llNyDI7wCe91floBuFSCmp3xrWpCu2dyWck4H1c7kL0PUZ9o4TdgxFq1s04EK
	i8VmunnKFjz07PCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731285384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8jBWU5hWQRsIooZM+OTxJPQqoti8v20/3MJD8aQqg8=;
	b=bGsDnGVxSuKCPaqb0egFMDe7ldPGMsognR09gQhw5HeGMMlQPstgyCm3jAPBrnmu27+5uJ
	Z5n2M9h2B16Oq4+mZ1kB4K1ErTbXiT5WxcfN8+ViuLcOjyvqiI4HE1blBDrKAOINzeR+7E
	9cHWTTA/Yl0L4cvqdo3l6K46nFAExAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731285384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8jBWU5hWQRsIooZM+OTxJPQqoti8v20/3MJD8aQqg8=;
	b=SsdKsh4xJGupxdPq9IF3VAkEcOwHaVpsk5ryGMVAFKWjx0BYeV1t6jpMNf/dITZxm5zJUq
	TjHJStSQxOUbp7AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A00613690;
	Mon, 11 Nov 2024 00:36:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UdTFN4VRMWcbbwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Nov 2024 00:36:21 +0000
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
Cc: linux-nfs@vger.kernel.org, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [for-6.13 PATCH 01/19] nfs/localio: must clear res.replen in
 nfs_local_read_done
In-reply-to: <20241108234002.16392-2-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>,
 <20241108234002.16392-2-snitzer@kernel.org>
Date: Mon, 11 Nov 2024 11:36:17 +1100
Message-id: <173128537794.1734440.6485533764883085616@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,noble.neil.brown.name:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 09 Nov 2024, Mike Snitzer wrote:
> From: NeilBrown <neilb@suse.de>
> 
> Otherwise memory corruption can occur due to NFSv3 LOCALIO reads
> leaving garbage in res.replen:

I'm not comfortable with this patch.  It doesn't tell us *why* there is
garbage in res.replen.
This is part of nfs_pgio_header and whenever that is allocated it
initialised to all zeros.  So where does the garbage come from?

Answer: it comes from
	hdr->res.verf    = &hdr->verf;
in nfs_pgio_rpcsetup().


struct nfs_pgio_res contains a union.  'replen' is present for read.
'verf' is present for write (and there is other stuff).

so I think that init of res.verf should only happen for write.

I cannot see an easy way to do that.  The best I can come up with is
to add a new pg_ioflags flag which says "this is a write", and only
initialise res.verf if that is set.

If we do stick with the current patch, I'd like a comment where we set
res.replen saying that it was corrupted when res.verf was initialised in
nfs_gpio_rpcsetup().

Or maybe move res.replen out of the union.  There is a 4byte hole before
the union (on x86_64).  It would be cleaner to move verf out, but that
is bigger....

Thanks,
NeilBrown

