Return-Path: <linux-nfs+bounces-4664-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E629928EE5
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 23:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2414128844E
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 21:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84DF144D01;
	Fri,  5 Jul 2024 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OYInPBGJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XMgWgRJv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OYInPBGJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XMgWgRJv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD0A13F42A
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jul 2024 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720215608; cv=none; b=jOSf3n7E9w+0vJV/gizERE8B2WjiBds120rs1ko9Tc/gOmVnr7aXShbClKHTycfuCJ0QKsXyaNZ4Hkc6yHMmi0s76UqTNQ2xJQBmU/UeHlhHzJwNxg/IykOWqYYxxxDYlqBuSwpTBpuwiqXADhESqIScfrpwKOq/RgBfRSLkZvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720215608; c=relaxed/simple;
	bh=co2ctFHy2KTxaHuJoWRqF+GwctXfbDPE9pPctp0bWw4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=E077QMZZUaven2Csx7xOBoEl7FrU1kfiAgodZW796UnKbtimSRz1veZt5hPDifRU3gmEq8dDp7x4e7XODAQfa3QgIU1fn4Tm0EfHJ1C+mjPMUylLTjqoGZJGGYaakxRWwMPC38aishvz7zb86PR/AqK31TtjrFhnl08sDsKO7kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OYInPBGJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XMgWgRJv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OYInPBGJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XMgWgRJv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1A2C71F7DB;
	Fri,  5 Jul 2024 21:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720215605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrRZTWScHtmUax2ZS3azJ8Db6J6hASSReX9iW47V1qk=;
	b=OYInPBGJcc1WKEUdi3Oh6M79TELvVyeVgzZU4rWIfvJx5OWsgoYYoUYR2pscJmnYtm4nvc
	K8EEEvrdCEiTQPMsfg5JtUyO8mQDWN4Dkw1ngowCxm5fBoR+lWWNXnrM97hte5YL26KzIU
	JDLOtUV02V1Lu0OQIvMGC/o20rI1XgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720215605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrRZTWScHtmUax2ZS3azJ8Db6J6hASSReX9iW47V1qk=;
	b=XMgWgRJvr++leKAs2U+3ZA3Q4kz58ahXtJhte/1L+NDLO8ZjB1NZI40rMVJybuTViB98Lz
	poQYpqxim+8GLqCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OYInPBGJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XMgWgRJv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720215605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrRZTWScHtmUax2ZS3azJ8Db6J6hASSReX9iW47V1qk=;
	b=OYInPBGJcc1WKEUdi3Oh6M79TELvVyeVgzZU4rWIfvJx5OWsgoYYoUYR2pscJmnYtm4nvc
	K8EEEvrdCEiTQPMsfg5JtUyO8mQDWN4Dkw1ngowCxm5fBoR+lWWNXnrM97hte5YL26KzIU
	JDLOtUV02V1Lu0OQIvMGC/o20rI1XgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720215605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrRZTWScHtmUax2ZS3azJ8Db6J6hASSReX9iW47V1qk=;
	b=XMgWgRJvr++leKAs2U+3ZA3Q4kz58ahXtJhte/1L+NDLO8ZjB1NZI40rMVJybuTViB98Lz
	poQYpqxim+8GLqCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C9F913889;
	Fri,  5 Jul 2024 21:40:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J9tHLDFoiGYzCwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 05 Jul 2024 21:40:01 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Christoph Hellwig" <hch@infradead.org>, linux-nfs@vger.kernel.org
Subject: Re: Security issue in NFS localio
In-reply-to: <ZoYlvk7LnhyUCYU1@kernel.org>
References: <172004548435.16071.5145237815071160040@noble.neil.brown.name>,
 <ZoYlvk7LnhyUCYU1@kernel.org>
Date: Sat, 06 Jul 2024 07:39:49 +1000
Message-id: <172021558910.11489.5865399031739295244@noble.neil.brown.name>
X-Rspamd-Queue-Id: 1A2C71F7DB
X-Spam-Score: -5.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu, 04 Jul 2024, Mike Snitzer wrote:
> On Thu, Jul 04, 2024 at 08:24:44AM +1000, NeilBrown wrote:
> 
> > 2/ The localio access should use exactly the same auth_domain as the
> >    network access uses.  This ensure the credentials implied by
> >    rootsquash and allsquash are used correctly.  I think the current
> >    code has the client guessing what IP address the server will see and
> >    finding an auth_domain based on that.  I'm not comfortable with that.
> 
> nfsd_local_fakerqst_create() isn't guessing.  rpc_peeraddr() returns the
> IP address of the server because the rpc_clnt is the same as
> established for traditional network access.

I think it is guessing in exactly they same way that your previous
internal code tried to use IP addresses to guess whether the server was
on the same host or not.

Whatever reasons you had for thinking that was fragile and needed to be
replaced - apply those reasons to the mechanism for choosing an
'auth_domain' (which is what the IP address is used for).  I am
confident that we need to choose the auth_domain when the client is
making a LOCALIO RPC request to the server, and to use that auth_domain
for subsequent interactions with that client (and possibly a different
auth_domain for a different client).

> 
> It's now 4th of July for me, so I'm with Jeff: I need a drink! ;)
> 

Hope you enjoyed your drink!

NeilBrown

