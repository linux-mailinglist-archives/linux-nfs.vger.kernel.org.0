Return-Path: <linux-nfs+bounces-20178-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGz9IFy+tmmDHgEAu9opvQ
	(envelope-from <linux-nfs+bounces-20178-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Mar 2026 15:12:44 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D45C290F08
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Mar 2026 15:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D0D73004C9B
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Mar 2026 14:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95B826E6E1;
	Sun, 15 Mar 2026 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGtRmZg5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6B55B5AB;
	Sun, 15 Mar 2026 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773583956; cv=none; b=jMmcpmT7KZOOIZ8CRaW950Mgyku0QbapHJhvOuUOXutBkAIDMEz381iGqKM4vCqZgdvuJ2xoieU/p7M1dkYW4I2eFHHko5+2ZgdVSwKihDFl1d00PvxLZgoXcujyBVZdxP4f8c1B4zIhdu3lrKnPOtuwugBjpNM7CKLMziQtn14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773583956; c=relaxed/simple;
	bh=qa/E8IzS4V7rRsDQq+u365Q1vo4yRB2NiQ4vXWig9/k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zl2mP8CLXlvv/0bJpcZzTscJ9BKmoCMqKGAvc/4CCF4SU/Db2W20fwumdpxaEAEhnJE1jBoK5zbbZ4qMNpoMgASlxQKhfP4Re/A9p/Iw5EpPdymWKTJ4UtcVOT5FrirYCzKH2unO7JR9JrfJozWN4VF9zKqOVSYqBMfQdd/y9kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGtRmZg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D349C4CEF7;
	Sun, 15 Mar 2026 14:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773583956;
	bh=qa/E8IzS4V7rRsDQq+u365Q1vo4yRB2NiQ4vXWig9/k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FGtRmZg5llmswT6V2h6j+y55E9ovxYtQlfo9/yAjWu6b9xkQ+by91QJZ3qvycVHG2
	 xvukAj53AxPygNWYOZf2xazfsmgQScBs9sdfaOjvXfI/Tsrm4MIyw1BbfRlXjrPMMp
	 oQMV3WyzZDjBD/eHDj687DyVJSnB/uqJXY9iAeoZE1rElWUdOzo3xHBVpJRz7sV6UE
	 Q47/vqCLexvMeYUOEI/9o13SLBsQhPzh3m3RWMa1DcKPRP3Mz7EaGLueGubtuJpQzQ
	 XTVtWAbyCdQCBZtdPYweTbAfjIh65LlxIDT3uA633v42p7Yc05Mm6t7NFyWgk1oRuD
	 GX4p0ZRIHp/kw==
Message-ID: <46a87e31656d23d6246d170955ec2d633bfe63ea.camel@kernel.org>
Subject: Re: [regression] Large rsize/wsize (1MB) causes EIO after
 2b092175f5e3 ("NFS: Fix inheritance of the block sizes when automounting")
From: Trond Myklebust <trondmy@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Salvatore Bonaccorso
 <carnil@debian.org>,  Maik Nergert <maik.nergert@uni-hamburg.de>, Valentin
 SAMIR <valentin.samir@magellium.fr>, Anna Schumaker	 <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, 1128834@bugs.debian.org
Date: Sun, 15 Mar 2026 10:12:34 -0400
In-Reply-To: <73c3a6a03fbe30a4f4b05c7fe58b3dceda87c45b.camel@kernel.org>
References: <177349021750.3039212.10211295677877269201@eldamar.lan>
		 <0f9572e731939f365f6708f58b258bee89d6245a.camel@kernel.org>
	 <73c3a6a03fbe30a4f4b05c7fe58b3dceda87c45b.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20178-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D45C290F08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 2026-03-15 at 07:29 -0400, Jeff Layton wrote:
> Servers use the max_request_size to properly size their receive
> buffers, and the client is responsible for adhering to that value. I
> don't think you can stick a bunch of operations in a request compound
> and then put a huge WRITE at the end that blows out max_request_size,
> and expect the server to be OK with that.
>=20
> ISTM the client should clamp the length down to something shorter
> that
> allows the request to fit. Maybe drop the last folio and force
> another
> request? Performance would suck but it would work.
>=20
> All that said, the server in this case isn't sizing max_request_size
> with enough overhead for the client to actually achieve a full 1M
> write, which is just dumb. Dell should fix that.

I'm aware of what the spec says, Jeff.

We're not putting "a bunch of operations" before the WRITE. There's a
SEQUENCE, PUTFH, WRITE and GETATTR.
The point is, we expect the value of maxwrite to be set to a reasonable
value w.r.t. max_request_size so that the client doesn't have to sanity
check everybody and their dog's server.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

