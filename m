Return-Path: <linux-nfs+bounces-9763-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77906A22585
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 22:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF55165E0E
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 21:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FF71B040B;
	Wed, 29 Jan 2025 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h79oVO6F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a7UeeZs5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h79oVO6F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a7UeeZs5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2820F190072;
	Wed, 29 Jan 2025 21:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738185228; cv=none; b=n0jttyUvDl0ip2suJp37pUBTQ9CqN26/MKo1ptZbVZiOC8loDqdw/8NPpK+WjFKZr0FuBeTcMozOanuso7FQYUcTxOboVlsaw2IcW+ilb+BqkiSB6YXnIH2GX4OZzdYmBCrbfm1cT4FXTzd6vtDUPcY0XQykIBr0RXxJH5gqB2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738185228; c=relaxed/simple;
	bh=0UG6CC7XIfMHVtKJ9owiwWhGASrQSE/6prDZMcxN8Ys=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=D4z5sbcz0YlQ5JmzxRkQIVdI//8d3yytNp/QLIe/+5dTbyqSd+HbYKjJITn9Wi6ZwAt73hXqSvkc5oMkWdGw7m5eoH1MMCNdXSrrb8lt6fhhDpjXeUbmAb//JSXVWgrLlpt4Ouq7SkPWbuLmrHN+e2UdKvdlhfVevao31K1m2h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h79oVO6F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a7UeeZs5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h79oVO6F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a7UeeZs5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B01E210F7;
	Wed, 29 Jan 2025 21:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738185218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ngRSYEs/wyAhTMpT/Ds1sDh7+RSLWhoeEnwvOFO/D4o=;
	b=h79oVO6FxLJ/PE99PC4Lbq8CEaBOQ0oyHU/xFu8B5YHRX7yQ0V9H2Gk76FACNuTSjhEFGj
	yHLaD+9usT6JIHOcNDQzMJvAR07HyLflkWnN2Zlfb8Ri10g12fyimsdf/bIcWybQ6fAG09
	BYneIns5kxWDyIQ6U2D0DB4zEdDwRbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738185218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ngRSYEs/wyAhTMpT/Ds1sDh7+RSLWhoeEnwvOFO/D4o=;
	b=a7UeeZs54debVWHGRR4noZXXbrg8wneqIYUgerDXj2UdJfe1qZ2qgCYg/m/rkP2YNz54lG
	tYN4cM524T/as4Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738185218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ngRSYEs/wyAhTMpT/Ds1sDh7+RSLWhoeEnwvOFO/D4o=;
	b=h79oVO6FxLJ/PE99PC4Lbq8CEaBOQ0oyHU/xFu8B5YHRX7yQ0V9H2Gk76FACNuTSjhEFGj
	yHLaD+9usT6JIHOcNDQzMJvAR07HyLflkWnN2Zlfb8Ri10g12fyimsdf/bIcWybQ6fAG09
	BYneIns5kxWDyIQ6U2D0DB4zEdDwRbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738185218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ngRSYEs/wyAhTMpT/Ds1sDh7+RSLWhoeEnwvOFO/D4o=;
	b=a7UeeZs54debVWHGRR4noZXXbrg8wneqIYUgerDXj2UdJfe1qZ2qgCYg/m/rkP2YNz54lG
	tYN4cM524T/as4Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1ADB5132FD;
	Wed, 29 Jan 2025 21:13:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ph+AL/6ZmmelEgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 29 Jan 2025 21:13:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: cel@kernel.org
Cc: "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Salvatore Bonaccorso" <carnil@debian.org>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] nfsd: validate the nfsd_serv pointer before calling svc_wake_up
In-reply-to: <173808393439.39052.5320146579477812509.b4-ty@oracle.com>
References: <20250125-kdevops-v1-1-a76cf79127b8@kernel.org>,
 <173808393439.39052.5320146579477812509.b4-ty@oracle.com>
Date: Thu, 30 Jan 2025 08:13:26 +1100
Message-id: <173818520688.22054.4135013466624893151@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Wed, 29 Jan 2025, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> On Sat, 25 Jan 2025 20:13:18 -0500, Jeff Layton wrote:
> > nfsd_file_dispose_list_delayed can be called from the filecache
> > laundrette, which is shut down after the nfsd threads are shut down and
> > the nfsd_serv pointer is cleared. If nn->nfsd_serv is NULL then there
> > are no threads to wake.
> >=20
> > Ensure that the nn->nfsd_serv pointer is non-NULL before calling
> > svc_wake_up in nfsd_file_dispose_list_delayed. This is safe since the
> > svc_serv is not freed until after the filecache laundrette is cancelled.
> >=20
> > [...]
>=20
> Applied to nfsd-testing, thanks!
>=20
> Test experience should demonstrate whether more strict memory
> ordering semantics are needed.

No it won't.  The need for READ_ONCE is theoretical, not - in this case
- practical.

=E2=80=9CProgram testing can be used to show the presence of bugs, but never =
to show their absence!=E2=80=9D
=E2=80=95 Edsger W. Dijkstra=20

NeilBrown

>=20
> [1/1] nfsd: validate the nfsd_serv pointer before calling svc_wake_up
>       commit: 363683ced1718d66ad54e1bdf52d41d544f783b2
>=20
> --
> Chuck Lever
>=20
>=20


