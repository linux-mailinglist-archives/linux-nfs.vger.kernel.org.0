Return-Path: <linux-nfs+bounces-5887-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C657963395
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 23:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20EB41F24DD9
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 21:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977B51AE85A;
	Wed, 28 Aug 2024 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xEXkbI5J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cHopfOkm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AaRPjpF7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8N31NtTH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7F31AE84D
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 21:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879157; cv=none; b=j1cxAho9BA4GymNutQZnbYyoS4Z71NryEFJcPO1MP6uqGxQw47YdIN83n7QXEomUPmaxiICjUEsmWHJ2qIv8vvsl/G96casGcXSKYn1tXpWaFOvRPGKLVX1Q3UcO62v3LcK4Ne5056J+Jva5v1chdj7Eo4NW57JEeyYYIBe8ejk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879157; c=relaxed/simple;
	bh=wClPTVNOckbI+22z9aLjk2hsWiSGT8R4IXCYZmfnISc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=QDPWieDAWZH/fhTRZ/ZHJ7Oqqs8Fljmzvj2W0DHCOMQcS7DwJBjifWVkFiL7LAesbKtGZ79Tn+/OLaRdqbs/GZAkeGJdT4BpC0a3qNzpGwmZa6WoXs+jnr1ksxRlp6Paxjv/871dQ+tHbtwwCsVxnvtUqMoVDZG9l4SpgbKZ23M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xEXkbI5J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cHopfOkm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AaRPjpF7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8N31NtTH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6EE571FC07;
	Wed, 28 Aug 2024 21:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724879151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0dLpBFYOOblQepiz+l6NttTYLD5i8KFOD/sLD1aU2ko=;
	b=xEXkbI5JtSfa9ZoZO6SzfWUhDoqVmqQJ61jWG3NSN3AXS1Ff6O6TaPNVlLPWbnbn0DaRMm
	pWVtiA8xpJ3zoKyW1ZDqYTVG9Q0pTaoYRa/xdPkkZKXV06grAxddsyDD9/ecR7ZNll1WAS
	0Y8bJ0KS0LxE3+Z7DaA+vGk2U9/1QE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724879151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0dLpBFYOOblQepiz+l6NttTYLD5i8KFOD/sLD1aU2ko=;
	b=cHopfOkmBgeNf2vQsjlogsJhUZDqxbknCs/QW4N8WgAk6Im4nCTjLoqn/CzvxEoD9taNNZ
	EE5JnlS0uPRV/uBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724879150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0dLpBFYOOblQepiz+l6NttTYLD5i8KFOD/sLD1aU2ko=;
	b=AaRPjpF78lH74AlNIqvSccD+A5PKAzE0Y4uNC3v5PzFLJ3FjwEPtntl2zTcZ5vPplzsrB8
	mc672QFxcdnMVS2zi4nqZgpCYPn6wl6c6HrqsWTd3nH+g9PYkG5rhe8PObFY7tgwmymfBJ
	k9og0auQdCTTfbavhHKMVlYgof7C1PA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724879150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0dLpBFYOOblQepiz+l6NttTYLD5i8KFOD/sLD1aU2ko=;
	b=8N31NtTHmO73obBlykmdY4Zn2SgXnJ6akqlqEidBsRYWYxZvgzsbkqPv0NzXZ+iJ8cIdxo
	G1wrcQFmkUuv3FAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A6751398F;
	Wed, 28 Aug 2024 21:05:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zBALOCyRz2a4MgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 28 Aug 2024 21:05:48 +0000
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
Cc: cel@kernel.org, linux-nfs@vger.kernel.org
Subject:
 Re: [RFC PATCH 1/6] NFSD: Handle @rqstp == NULL in check_nfsd_access()
In-reply-to: <Zs8p6ej4K0CLcmt0@kernel.org>
References: <>, <Zs8p6ej4K0CLcmt0@kernel.org>
Date: Thu, 29 Aug 2024 07:05:45 +1000
Message-id: <172487914501.4433.5035812857573545333@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Wed, 28 Aug 2024, Mike Snitzer wrote:
> 
> So I honestly feel like Chuck's latest revision is perfectly fine.
> I disagree that "The behavior for LOCALIO is therefore the same as
> the AUTH_UNIX check below." is inaccurate.  The precondition from the
> client (used to establish localio and cause rqstp to be NULL in
> check_nfsd_access) is effectively comparable no?
> 

I don't think the correctness of the code is at all related to
AUTH_UNIX.
Suppose we did add support for krb5 somehow - would we really need a
different test?  I think not.

I think that the reason the code is correct and safe is that we trust
the client.  We *know* the client will only present an filehandle which
it has received over the wire and which it verified - with the
accompanying credential - it was allowed to access.

Maybe that is what you meant by "The precondition from the client".  I
agree that does give us sufficient safety.  I don't think AUTH_UNIX is
relevant.

/*
 * If rqstp is NULL, this is a LOCALIO request which will only ever use
 * filehandle/credential pair for which access has been affirmed (by
 * ACCESS or OPEN NFS requests) over the wire.  So there is no need for
 * further checks here.
 */


(It wasn't quite this clear to me when I wrote previously - but I always
 seems to think more clearly in the mornings!)

Thanks,
NeilBrown

