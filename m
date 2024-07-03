Return-Path: <linux-nfs+bounces-4612-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1149926B7B
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 00:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BEE4282A0B
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 22:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF21136643;
	Wed,  3 Jul 2024 22:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rXD1O088";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f7yx2Et3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rXD1O088";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f7yx2Et3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643F125760
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 22:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720045499; cv=none; b=LCQrCsHcULgFmZQZdvGRXKsUCUBl2zqs4M3hcUc1dbkMiJnatDIFlyu5ibKN2pYLObAK8TR+WmaV6h6WcTopLiZULyS/cfV4tKgPYqDJyLdJpS+X9Jlh4CWPGSkVFZrVD1UDG21c7FDpQW7x4TeeD0rcskYtvqYJeVb7FVPGb0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720045499; c=relaxed/simple;
	bh=dpz/oTutQukMh62IElnW8i+uwi9QCR0Heqzj6R09bxk=;
	h=Content-Type:MIME-Version:From:To:cc:Subject:Date:Message-id; b=il1U9w3izqiYRiIULMX/kCe0qMFulg9dQ+eWeyABZ2mi15qfnPMknuEtrIx7j9gzhURLoI8LslkFrp9hjnGWt1t8HJoAlVnotuHmr5WadMMENCNg3fVtOMD4qbE1Y3moOZuL4Qbm2muNzwyefnH5BrX9vhJvBt4a1iRZCKmcmHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rXD1O088; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f7yx2Et3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rXD1O088; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f7yx2Et3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A32D1F78C;
	Wed,  3 Jul 2024 22:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720045495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K9RAdz4O2RFKB43rN/Oq2p8uIBVW5ienN44rz73zRBs=;
	b=rXD1O088577i1lQCGmAhpmwZThSyLNq2vOOyS3CcWnFD4RTiEOQS1A7VpdwyIzUU2igtiZ
	cpHZFaxD5d1i575ckCqTpZLvJOucrivPMN4zBpviPQYNugfKj668GpDHbt06w3U2SCWWdG
	KmCOStp62w53H+uwqhfMCCjEGc532Ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720045495;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K9RAdz4O2RFKB43rN/Oq2p8uIBVW5ienN44rz73zRBs=;
	b=f7yx2Et3kyT/OShCT9C0QxBg4JBySHSdZf+K9ctsdbYeiEYf5X3bIQCS11SSDkblbfH2CH
	DuuiARIPNel3X/BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720045495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K9RAdz4O2RFKB43rN/Oq2p8uIBVW5ienN44rz73zRBs=;
	b=rXD1O088577i1lQCGmAhpmwZThSyLNq2vOOyS3CcWnFD4RTiEOQS1A7VpdwyIzUU2igtiZ
	cpHZFaxD5d1i575ckCqTpZLvJOucrivPMN4zBpviPQYNugfKj668GpDHbt06w3U2SCWWdG
	KmCOStp62w53H+uwqhfMCCjEGc532Ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720045495;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K9RAdz4O2RFKB43rN/Oq2p8uIBVW5ienN44rz73zRBs=;
	b=f7yx2Et3kyT/OShCT9C0QxBg4JBySHSdZf+K9ctsdbYeiEYf5X3bIQCS11SSDkblbfH2CH
	DuuiARIPNel3X/BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CAA713889;
	Wed,  3 Jul 2024 22:24:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4BZnALTPhWbHOwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 03 Jul 2024 22:24:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>
cc: Anna Schumaker <anna@kernel.org>,
 Trond Myklebust <trondmy@hammerspace.com>,
 Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org
Subject: Security issue in NFS localio
Date: Thu, 04 Jul 2024 08:24:44 +1000
Message-id: <172004548435.16071.5145237815071160040@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 


I've been pondering security questions with localio - particularly
wondering what questions I need to ask.  I've found three focal points
which overlap but help me organise my thoughts:
1- the LOCALIO RPC protocol
2- the 'auth_domain' that nfsd uses to authorise access
3- the credential that is used to access the file

1/ It occurs to me that I could find out the UUID reported by a given
local server (just ask it over the RPC connection), find out the
filehandle for some file that I don't have write access to (not too
hard), and create a private NFS server (hacking nfs-ganasha?) which
reports the same uuid and reports that I have access to a file with
that filehandle.  If I then mount from that server inside a private
container on the same host that is running the local server, I would get
localio access to the target file.

I might not be able to write to it because of credential checking, but I
think that is getting a lot closer to unauthorised access than I would
like.

I would much prefer it if there was no credible way to subvert the
LOCALIO protocol.

My current idea goes like this:
 - NFS client tells nfs_common it is going to probe for localio
   and gets back a nonce.  nfs_common records that this probe is happening
 - NFS client sends the nonce to the server over LOCALIO.
 - server tells nfs_common "I just got this nonce - does it mean
   anything?".  If it does, the server gets connected with the client
   through nfs_common.  The server reports success over LOCALIO.
   If it doesn't the server reports failure of LOCALIO.
 - NFS client gets the reply and tells nfs_common that it has a reply
   so the nonce is invalidated.  If the reply was success and nfs_local
   confirms there is a connection, then the two stay connected.

I think that having a nonce (single-use uuid) is better than using the
same uuid for the life of the server, and I think that sending it
proactively by client rather than reactively by the server is also
safer.

2/ The localio access should use exactly the same auth_domain as the
   network access uses.  This ensure the credentials implied by
   rootsquash and allsquash are used correctly.  I think the current
   code has the client guessing what IP address the server will see and
   finding an auth_domain based on that.  I'm not comfortable with that.
   
   In the new LOCALIO protocol I suggest above, the server registers
   with nfs_common at the moment it receives an RPC request.  At that
   moment it knows the characteristics of the connection - remote IP?
   krb5?  tls?  - and can determine an auth_domain and give it to
   nfs_common and so make it available to the client.

   Jeff wondered about an export option to explicitly enable LOCALIO.  I
   had wondered about that too.  But I think that if we firmly tie the
   localio auth_domain to the connection as above, that shouldn't be needed.

3/ The current code uses the 'struct cred' of the application to look up
   the file in the server code.  When a request goes over the wire the
   credential is translated to uid/gid (or krb identity) and this is
   mapped back to a credential on the server which might be in a
   different uid name space (might it?  Does that even work for nfsd?)

   I think that if rootsquash or allsquash is in effect the correct
   server-side credential is used but otherwise the client-side
   credential is used.  That is likely correct in many cases but I'd
   like to be convinced that it is correct in all case.  Maybe it is
   time to get a deeper understanding of uid name spaces.

Have I missed anything?  Any other thoughts?

Thanks,
NeilBrown
  

