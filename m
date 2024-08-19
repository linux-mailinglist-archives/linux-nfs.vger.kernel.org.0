Return-Path: <linux-nfs+bounces-5433-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D07295604B
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2024 02:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4F01F21E0B
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2024 00:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8BB322A;
	Mon, 19 Aug 2024 00:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n3GZf9+4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eh7ett96";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n3GZf9+4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eh7ett96"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C242F32;
	Mon, 19 Aug 2024 00:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724025871; cv=none; b=DlGK1vZWEyFuCMSr2X+5Y7qFqanwljHe83/mejhoXaoIvvQwp7uUbog9/MtsjrwJR1ydd21w/qhovGvzfNigo3PnvHxDPKAR/4FwX3yimo3zM1io5ybnTRMpt+B2maOCk2Kh0jAA4HQIcZNG1aCXQdYuWOCQvR44TTgKHXuLBEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724025871; c=relaxed/simple;
	bh=9dIz3PEXhxqykFdhXh3S8uAB/PSD7Khb4HXhPZOh0vw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=IaBhpeQb1w+o+9b3fWBTuA8vzpRrYiJ9YOTLF1068xMoPLIV1LCk8aKANIrV2FSTfZGp5S/mzfczXZu/zz8O3TgXTNb2ZnzZW+V1/Cv2uLZ9BkDiCLT+QNu9JlclbbuguvQ9cZmqCx59C+SMrvTruZXIV60e4UqPI+aszM2bPDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n3GZf9+4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eh7ett96; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n3GZf9+4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eh7ett96; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4224C21FBD;
	Mon, 19 Aug 2024 00:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724025862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f/zSJxp2oq5IQB53rRJrkxa4bNDT6Gvj6hdUfVbYtss=;
	b=n3GZf9+4PJuyPNoesjoc13H2M2tVGUs94gt05nQCDSDCyVfy9prlY/ifoOCs2dHa2vRvmy
	HqMxQg481i736ByGdj2gMjKbf27d/zwzgnC5uAasxZs4oTPEjshIMODVWeIA6rshdkR08B
	Gz1Dzh3pAVI0ONIhqS5fB1hoX/1RH+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724025862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f/zSJxp2oq5IQB53rRJrkxa4bNDT6Gvj6hdUfVbYtss=;
	b=eh7ett96/mJjeF7ALmbbcmJyMhSC3rgoOYUlMoAsdjncxhAhdVvcwgEcFSdnRVJRsCBPTr
	0SgKBiGPCV1QwkDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=n3GZf9+4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eh7ett96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724025862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f/zSJxp2oq5IQB53rRJrkxa4bNDT6Gvj6hdUfVbYtss=;
	b=n3GZf9+4PJuyPNoesjoc13H2M2tVGUs94gt05nQCDSDCyVfy9prlY/ifoOCs2dHa2vRvmy
	HqMxQg481i736ByGdj2gMjKbf27d/zwzgnC5uAasxZs4oTPEjshIMODVWeIA6rshdkR08B
	Gz1Dzh3pAVI0ONIhqS5fB1hoX/1RH+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724025862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f/zSJxp2oq5IQB53rRJrkxa4bNDT6Gvj6hdUfVbYtss=;
	b=eh7ett96/mJjeF7ALmbbcmJyMhSC3rgoOYUlMoAsdjncxhAhdVvcwgEcFSdnRVJRsCBPTr
	0SgKBiGPCV1QwkDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE21C139DE;
	Mon, 19 Aug 2024 00:04:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nAorKAKMwmaoGQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 19 Aug 2024 00:04:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Tom Haynes" <loghyr@gmail.com>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH 1/3] nfsd: bring in support for delstid draft XDR encoding
In-reply-to: <20240816-delstid-v1-1-c221c3dc14cd@kernel.org>
References: <20240816-delstid-v1-0-c221c3dc14cd@kernel.org>,
 <20240816-delstid-v1-1-c221c3dc14cd@kernel.org>
Date: Mon, 19 Aug 2024 10:04:00 +1000
Message-id: <172402584064.6062.2891331764461009092@noble.neil.brown.name>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 4224C21FBD
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,netapp.com,talpey.com,kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On Fri, 16 Aug 2024, Jeff Layton wrote:

> +// Generated by lkxdrgen, with hand-edits.

I *really* don't like having code in the kernel that is partly
tool-generated and partly human-generated, and where the boundary isn't
obvious (like separate files).

If we cannot use tool-generated code as-is, then let's fix the tool.
If we cannot fix the tool, then include the raw output and a
human-generated patch which the makefile combines.

Ideally the tool should be in tools/, the .x file should be in fs/nfsd/
and the makefile should apply the one to the other.  We are going to
want to do that eventually and I think it should be priority.  The tool
doesn't have to be bug-free before it lands (nothing is).

A particular reason for this is that I cannot review tool-generated
hand-editted code.  It is too noisy and I don't know which parts are
worth closer inspection etc.

Thanks,
NeilBrown

