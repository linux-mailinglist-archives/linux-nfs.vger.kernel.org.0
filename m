Return-Path: <linux-nfs+bounces-10187-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA6AA3ABA6
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 23:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C24E7A1304
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 22:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACE21D6DBC;
	Tue, 18 Feb 2025 22:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zjd16IS+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ImofqmNp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zjd16IS+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ImofqmNp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF6F28629B
	for <linux-nfs@vger.kernel.org>; Tue, 18 Feb 2025 22:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917634; cv=none; b=hizw6ZRC45mPl1f4+/JyptMt8xyVqJiG/N4U9opPbLU/70tVN/v1LctmHY4bBZ0VYM5sol7MHKzIi+jcRMu9RZQfcsDWdS5CmYYDFcq8sKEljCCEg1I2swYvzfdL94AUO1fu1GWqQUWFcwJGjZd5zG5m3zywG47BPKttu1l3P8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917634; c=relaxed/simple;
	bh=V1gGI3XvX5MCCgrYLHp85uoDkyNvQtWgmp6p6apcOXU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=vFTHa2UyxYJtFl14gJPhc6ZxvWIUEk/H9Z6ST33jyE08oozMMvSXHUrpvLTEOHcze+wgqRpfAgM5WdTz6LlMj5Z4z4XrQvvQRq1fPN7D9KaRYTInotpZ0XPqX5wnRCJgUgPmGrR+2BtzHIodIVyC3YN2BSAdyv7DpQo6xJ7w66s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=fail smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zjd16IS+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ImofqmNp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zjd16IS+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ImofqmNp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9CF1D1F396;
	Tue, 18 Feb 2025 22:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739917630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2VyOLn0+pTGux40SRgGbccItWcU6fEoLbEoJszf/5E=;
	b=Zjd16IS+3rrOab0NEgb1+z137x5IB/oxrDa/UKzBQIYYIHr2QLGJHXU7OXn4zt4CQsYpUK
	a58wdbV0ohUJtsYSHH3MMSAU5WrrhZ4wbrhy/IBC2x/Vng9pz/89BzhRfLKxfis9Tp7gAu
	fcaWSnT+OwYIcXqYvHevWNm/reOCpTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739917630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2VyOLn0+pTGux40SRgGbccItWcU6fEoLbEoJszf/5E=;
	b=ImofqmNpDE100XD9zr2QxkbigWZP5ApAOEHkEyrMkez/jTbgolpIkmYqJ16i/YzjmqIRsy
	2T2dzpP74PpXXTBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Zjd16IS+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ImofqmNp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739917630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2VyOLn0+pTGux40SRgGbccItWcU6fEoLbEoJszf/5E=;
	b=Zjd16IS+3rrOab0NEgb1+z137x5IB/oxrDa/UKzBQIYYIHr2QLGJHXU7OXn4zt4CQsYpUK
	a58wdbV0ohUJtsYSHH3MMSAU5WrrhZ4wbrhy/IBC2x/Vng9pz/89BzhRfLKxfis9Tp7gAu
	fcaWSnT+OwYIcXqYvHevWNm/reOCpTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739917630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2VyOLn0+pTGux40SRgGbccItWcU6fEoLbEoJszf/5E=;
	b=ImofqmNpDE100XD9zr2QxkbigWZP5ApAOEHkEyrMkez/jTbgolpIkmYqJ16i/YzjmqIRsy
	2T2dzpP74PpXXTBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA347132C7;
	Tue, 18 Feb 2025 22:27:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ag2gJzsJtWfzcwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 18 Feb 2025 22:27:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Li Lingfeng" <lilingfeng3@huawei.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject:
 Re: [PATCH 0/3] nfsd: don't allow concurrent queueing of workqueue jobs
In-reply-to: <20250218-nfsd-callback-v1-0-14f966967dd8@kernel.org>
References: <20250218-nfsd-callback-v1-0-14f966967dd8@kernel.org>
Date: Wed, 19 Feb 2025 09:26:59 +1100
Message-id: <173991761979.3118120.3421996111713215488@noble.neil.brown.name>
X-Rspamd-Queue-Id: 9CF1D1F396
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Wed, 19 Feb 2025, Jeff Layton wrote:
> While looking at the problem that Li Lingfeng reported [1] around
> callback queueing failures, I noticed that there were potential
> scenarios where the callback workqueue jobs could run concurrently with
> an rpc_task. Since they touch some of the same fields, this is incorrect
> at best and potentially dangerous.

If the problem is that workqueue jobs might run concurrently with
rpc_tasks and that we don't want that, could we simply run all the cb
tasks as "sync" rpc tasks in the workqueue??

i.e. change rpc_call_async() in nfsd4_run_cb_work() to rpc_call_sync ...
and fix any breakage because I doubt it is really as simple as that.

This would fully serialise all the callbacks.  Is that what to goal is
here, or is the goal more subtle?

Thanks,
NeilBrown


>=20
> This patchset adds a new mechanism for ensuring that the same
> nfsd4_callback can't run concurrently with itself, regardless of where
> it is in its execution. This also gives us a more sure mechanism for
> handling the places where we need to take and hold a reference on an
> object while the callback is running.
>=20
> This should also fix the problem that Li Lingfeng reported, since
> queueing the work from nfsd4_cb_release() should never fail. Note that
> the patch they sent earlier (fdf5c9413ea) should be dropped from
> nfsd-testing before this will apply cleanly.
>=20
> [1]: https://lore.kernel.org/linux-nfs/20250218135423.1487309-1-lilingfeng3=
@huawei.com/
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Jeff Layton (3):
>       nfsd: prevent callback tasks running concurrently
>       nfsd: eliminate cl_ra_cblist and NFSD4_CLIENT_CB_RECALL_ANY
>       nfsd: move cb_need_restart flag into cb_flags
>=20
>  fs/nfsd/nfs4callback.c | 12 ++++++------
>  fs/nfsd/nfs4layouts.c  |  7 ++++---
>  fs/nfsd/nfs4proc.c     |  2 +-
>  fs/nfsd/nfs4state.c    | 26 +++++++++++---------------
>  fs/nfsd/state.h        | 13 ++++++++++---
>  fs/nfsd/trace.h        |  2 +-
>  6 files changed, 33 insertions(+), 29 deletions(-)
> ---
> base-commit: 4a52e5e49d1b50fcb584e434cced6d0547ddea42
> change-id: 20250218-nfsd-callback-f723b8498c78
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20


