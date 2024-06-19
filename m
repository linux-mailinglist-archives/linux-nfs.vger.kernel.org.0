Return-Path: <linux-nfs+bounces-4054-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C14E390E40F
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 09:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A2E1F2386D
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 07:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6CD74BE0;
	Wed, 19 Jun 2024 07:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zWOkUNJz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Us6Wa99A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mahoiPa/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TGuDIep/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B386139
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718781027; cv=none; b=Y17NFWGEMGtdLDOsETGi1W3gKsnEASOYFJ2ablCQnnMKJzFE5KH9Ul5DmDjSJPWo1PyZA2SjdHW8jmBU5uGHs4up5U3lxttSYkXdugHffUx7a7UoIrph8kvVDjJxkgus8WE3o+Eiyl/PujIpWi5nGPLdXyrxI76HMwfti96m4MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718781027; c=relaxed/simple;
	bh=EuaVi/+yDQASvlOr/3Tzd2bddbHLAnMsTzIyau30NsA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=tZAGjoGGrhMd2hHuVta8n/3axt0zosXaz0AaKVCXfZev5JE8M8em49aM6s+rmj8KJu4szsXHeu2gDO+EWBuX6+KCRVukBc/2ORuj13oLAdqcrMTfK9p7PAwuLOqX+nANM/9VLUgRFMsFfe/qzUySVsTrcEtVjY8RDw6fk6J2CxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zWOkUNJz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Us6Wa99A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mahoiPa/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TGuDIep/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 305101F7FE;
	Wed, 19 Jun 2024 07:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718781023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVfc2rlSQljbD2nRiPzC/IFCdvxvG3Ygev4ei1J/p+M=;
	b=zWOkUNJziRhj+e9R3zEfRGVGxl75Z7MMrlT5AwZWxL43jL6OD51ZaRN/ltYwPKVPiwz60g
	SJUzHVbR0zINrUnRxPeZ9f2qagfS08DBk0lVbjZZMiBh26jEwX9TmTm57kp2L499NQtUHt
	I6vSbYnAHEFvvZI15T/k5B6GJMDdrWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718781023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVfc2rlSQljbD2nRiPzC/IFCdvxvG3Ygev4ei1J/p+M=;
	b=Us6Wa99ACdZHhJO5lLSEw1AncIlsiep5c1Ds+sDld8wn5xRzUF/I5QWui9e4kdaCZy2iZ5
	AvQ93KgdiE79kYAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718781022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVfc2rlSQljbD2nRiPzC/IFCdvxvG3Ygev4ei1J/p+M=;
	b=mahoiPa/LgykqWktOd9IgCW0ifEChxww4eDjKGi72pT2lNd4olNfoTyBbOPS5Sse9jlQuc
	SImGyuNDuhENVkqQMMLaK8W4GlJjFDTEt2Ogd1EGKvmLScmWsi9pOg9+H6H1KIM6c2z98I
	5t2UPx6DvezD3oHHdD6h3yWieW6PGQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718781022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVfc2rlSQljbD2nRiPzC/IFCdvxvG3Ygev4ei1J/p+M=;
	b=TGuDIep/Z/3Z6LLAio/MFl8dvKhuRe7ePtxoOmXOrxON/E+16b2Zh16ojiLWwXG1dsZYt6
	G7DZREIf2imlRfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 263CD13AAA;
	Wed, 19 Jun 2024 07:10:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pjl3LlqEcmYdBAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 19 Jun 2024 07:10:18 +0000
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
Cc: "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v5 00/19] nfs/nfsd: add support for localio
In-reply-to: <ZnJxTsUuAkenmvWP@infradead.org>
References:
 <20240618201949.81977-1-snitzer@kernel.org>, <ZnJxTsUuAkenmvWP@infradead.org>
Date: Wed, 19 Jun 2024 17:10:10 +1000
Message-id: <171878101003.14261.1089014272023335768@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Wed, 19 Jun 2024, Christoph Hellwig wrote:
> What happened to the requirement that all protocol extensions added
> to Linux need to be standardized in IETF RFCs?
> 
> 

Is that requirement documented somewhere?  Not that I doubt it, but it
would be nice to know where it is explicit.  I couldn't quickly find
anything in Documentation/

Can we get by without the LOCALIO protocol?

For NFSv4.1 we could use the server_owner4 returned by EXCHANGE_ID.  It
is explicitly documented as being usable to determine if two servers are
the same.

For NFSv4.0 ... I don't think we should encourage that to be used.

For NFSv3 it is harder.  I'm not as ready to deprecate it as I am for
4.0.  There is nothing in NFSv3 or MOUNT or NLM that is comparable to
server_owner4.  If krb5 was used there would probably be a server
identity in there that could be used.
I think the server could theoretically return an AUTH_SYS verifier in
each RPC reply and that could be used to identify the server.  I'm not
sure that is a good idea though.

Going through the IETF process for something that is entirely private to
Linux seems a bit more than should be necessary..

Thanks,
NeilBrown


