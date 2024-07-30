Return-Path: <linux-nfs+bounces-5191-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB8394029D
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2024 02:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C95EB21277
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2024 00:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AAE4A28;
	Tue, 30 Jul 2024 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WbG4LGPr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JZf5pGV8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WbG4LGPr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JZf5pGV8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58044A21
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jul 2024 00:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722300200; cv=none; b=ng4JTs+5wLB2ci4Pvx2gedsrB1QRAPHwfEj6jJL+I8ai+Vf/o5x81dvPpqGig+rYg80ERwOr92z94eLUGLOhU5pJ2OLCY4yfRjXbhHgDMrC2DcOvm94pRM/ttRAFQVjk6Sba1VpLZIkY6hsYqCEjxBMq/q4WqIbjlcgy7jK1cu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722300200; c=relaxed/simple;
	bh=OtoLdq7jbytXhxaIbF5YmmCYVCmr3xcT3agPiC7CGsI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=EHNXdAg6NklXEluEjQAJiRYvZuHr/Rt8K2B6k2QGzfFLi/6j6Oi9xzNROAOloRJtH0XHmnVyIr1qGbkeHwKYdpLxld5zZ7iSzc1MJgVFRcoMU5S6TGpxxucKJdph/PKHNy4E4dLbK05rndzI2Oqetx7Tnz0yLmfQaCwMy9UPBbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WbG4LGPr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JZf5pGV8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WbG4LGPr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JZf5pGV8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 067E821A92;
	Tue, 30 Jul 2024 00:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722300196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvI7h6H0ChMf/Km9B1XSel7MZo+jtYomnG/K/e/IoO0=;
	b=WbG4LGPrIMC/Tf6ubjbW+dyWG+qCBIM8hS1yzKCmvXO7grqaiiR/zFqqODw0S3R10iwAGB
	VZn2EvVDxEnpfBETfQZDCv3oD3yXNZkf/h5MRkerd5mPKY74ZpGzzEiiBBI4okeuSTd9x8
	1ncl1smy0g9YeuFDuH32oHkmeJ6zM/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722300196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvI7h6H0ChMf/Km9B1XSel7MZo+jtYomnG/K/e/IoO0=;
	b=JZf5pGV8XUiURSpwahUOBSnKBjLJEnuj1yl7CGDNCYeOe1n7Fmh2uo6LnpRdmJdGH5VjVg
	GTvC1aBma2Z2UBAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722300196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvI7h6H0ChMf/Km9B1XSel7MZo+jtYomnG/K/e/IoO0=;
	b=WbG4LGPrIMC/Tf6ubjbW+dyWG+qCBIM8hS1yzKCmvXO7grqaiiR/zFqqODw0S3R10iwAGB
	VZn2EvVDxEnpfBETfQZDCv3oD3yXNZkf/h5MRkerd5mPKY74ZpGzzEiiBBI4okeuSTd9x8
	1ncl1smy0g9YeuFDuH32oHkmeJ6zM/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722300196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvI7h6H0ChMf/Km9B1XSel7MZo+jtYomnG/K/e/IoO0=;
	b=JZf5pGV8XUiURSpwahUOBSnKBjLJEnuj1yl7CGDNCYeOe1n7Fmh2uo6LnpRdmJdGH5VjVg
	GTvC1aBma2Z2UBAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E01DC13983;
	Tue, 30 Jul 2024 00:43:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XfitJCE3qGYECwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 30 Jul 2024 00:43:13 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 0/2] nfsd: fix handling of error from unshare_fs_struct()
In-reply-to: <Zqeo1c37E6xDDgSA@tissot.1015granger.net>
References: <20240729022126.4450-1-neilb@suse.de>,
 <Zqeo1c37E6xDDgSA@tissot.1015granger.net>
Date: Tue, 30 Jul 2024 10:43:10 +1000
Message-id: <172230019067.31176.5761077158743507069@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-1.10 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -1.10

On Tue, 30 Jul 2024, Chuck Lever wrote:
> 
> In 2/2, what is the reason to make svc_thread_init_status() a static
> inline rather than an exported function? I don't think this is going
> to be a performance hot path, but maybe it becomes one in a future
> patch?
> 

Sorry - I missed this question the first time.

My reasoning was that it was a tiny function which would be optimised
even smaller in two out of three call sites where the err number is a
constant zero.  Also my original draft didn't even have this as a
function but was open coded.

I don't think it matters much either way.

Thanks,
NeilBrown

