Return-Path: <linux-nfs+bounces-5654-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BAF95D5BB
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 21:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA93A1F236E5
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 19:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53F1192B94;
	Fri, 23 Aug 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y6Hos3+M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="skRm8FGy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y6Hos3+M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="skRm8FGy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8F5192B86;
	Fri, 23 Aug 2024 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439744; cv=none; b=q9T9AV6W1mdXXU6qsggDpDQ0P/jo0wq/rJgjpLpvm/iZ+d4eFL78pZ+IwTV9W7ePaD+fEpzf/gGiBZWe81j7KWkNMux04zTeOTF2z/o7x4OUsQBZwq3p3wbOMMr/WoKfkGVka81OtZDaygdQhedl9QZVAPuTtjkHxzKbinYgbRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439744; c=relaxed/simple;
	bh=X/Aux/Oxye9WarYf5QaQpbTtf/dohJK0nr1mA2PS2KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdHw6unjBXLTYZafXlugUr3y+5P1kJGHQDqE/aLg1NxgjzjHER+d+o6teioQB/dICYdn0qUa6QgVhdXuDYwIBg6tXgXncmTTSfleVZSFx5hqEdIuPSnXlMcnTQDpgKM25vfZMn3O0K1KS/aQJVKezQvmoq5xTUeYTgFi1HMbBps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y6Hos3+M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=skRm8FGy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y6Hos3+M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=skRm8FGy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A308522319;
	Fri, 23 Aug 2024 18:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724439184;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OG3GVJvSkSrZing4dFbZLwgqoUoF+8JjNz2qwIrHZF0=;
	b=y6Hos3+MKKCwRWqdGbalwjyN0yI1r3BArHAE2+WFm6lI1iM4Aoaa2LHiwKm3e5rBI7T4zf
	8zyE/YOu+jT/ClG/iM5ucHm87XLCB9elPs058ly1RhChqF3nmx8je31lBAAbnUdawXGjb7
	gSVsugwnfc2na5GoNRktCsvZMj3sA48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724439184;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OG3GVJvSkSrZing4dFbZLwgqoUoF+8JjNz2qwIrHZF0=;
	b=skRm8FGyz3iCWprfZB+kYg+cSsywIeLFwMXLzs0BnteHym7JYC81cN8C0IP7iigmDe90xu
	OvQcUno0gBdS94Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724439184;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OG3GVJvSkSrZing4dFbZLwgqoUoF+8JjNz2qwIrHZF0=;
	b=y6Hos3+MKKCwRWqdGbalwjyN0yI1r3BArHAE2+WFm6lI1iM4Aoaa2LHiwKm3e5rBI7T4zf
	8zyE/YOu+jT/ClG/iM5ucHm87XLCB9elPs058ly1RhChqF3nmx8je31lBAAbnUdawXGjb7
	gSVsugwnfc2na5GoNRktCsvZMj3sA48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724439184;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OG3GVJvSkSrZing4dFbZLwgqoUoF+8JjNz2qwIrHZF0=;
	b=skRm8FGyz3iCWprfZB+kYg+cSsywIeLFwMXLzs0BnteHym7JYC81cN8C0IP7iigmDe90xu
	OvQcUno0gBdS94Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 184E41333E;
	Fri, 23 Aug 2024 18:53:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7H5dA5DayGZYRAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 23 Aug 2024 18:53:04 +0000
Date: Fri, 23 Aug 2024 20:53:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>, Li Wang <liwang@redhat.com>,
	Cyril Hrubis <chrubis@suse.cz>, Avinesh Kumar <akumar@suse.de>,
	Josef Bacik <josef@toxicpanda.com>, Neil Brown <neilb@suse.de>,
	linux-stable <stable@vger.kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] nfsstat01: Update client RPC calls for kernel 6.9
Message-ID: <20240823185302.GA1302254@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240814085721.518800-1-pvorel@suse.cz>
 <Zrytfw1DRse3wWRZ@tissot.1015granger.net>
 <20240823064640.GA1217451@pevik>
 <0BDD1287-471E-47A8-A362-DF660806CED6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0BDD1287-471E-47A8-A362-DF660806CED6@oracle.com>
X-Spam-Score: -7.50
X-Spamd-Result: default: False [-7.50 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 



> > On Aug 23, 2024, at 2:46 AM, Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Chuck, Neil, all,

> >> On Wed, Aug 14, 2024 at 10:57:21AM +0200, Petr Vorel wrote:
> >>> 6.9 moved client RPC calls to namespace in "Make nfs stats visible in
> >>> network NS" patchet.

> >>> https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/

> >>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> >>> ---
> >>> Changes v1->v2:
> >>> * Point out whole patchset, not just single commit
> >>> * Add a comment about the patchset

> >>> Hi all,

> >>> could you please ack this so that we have fixed mainline?

> >>> FYI Some parts has been backported, e.g.:
> >>> d47151b79e322 ("nfs: expose /proc/net/sunrpc/nfs in net namespaces")
> >>> to all stable/LTS: 5.4.276, 5.10.217, 5.15.159, 6.1.91, 6.6.31.

> >>> But most of that is not yet (but planned to be backported), e.g.
> >>> 93483ac5fec62 ("nfsd: expose /proc/net/sunrpc/nfsd in net namespaces")
> >>> see Chuck's patchset for 6.6
> >>> https://lore.kernel.org/linux-nfs/20240812223604.32592-1-cel@kernel.org/

> >>> Once all kernels up to 5.4 fixed we should update the version.

> >>> Kind regards,
> >>> Petr

> >>> testcases/network/nfs/nfsstat01/nfsstat01.sh | 9 ++++++++-
> >>> 1 file changed, 8 insertions(+), 1 deletion(-)

> >>> diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> >>> index c2856eff1f..1beecbec43 100755
> >>> --- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
> >>> +++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> >>> @@ -15,7 +15,14 @@ get_calls()
> >>> local calls opt

> >>> [ "$name" = "rpc" ] && opt="r" || opt="n"
> >>> - ! tst_net_use_netns && [ "$nfs_f" != "nfs" ] && type="rhost"
> >>> +
> >>> + if tst_net_use_netns; then
> >>> + # "Make nfs stats visible in network NS" patchet
> >>> + # https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/
> >>> + tst_kvcmp -ge "6.9" && [ "$nfs_f" = "nfs" ] && type="rhost"

> >> Hello Petr-

> >> My concern with this fix is it targets v6.9 specifically, yet we
> >> know these fixes will appear in LTS/stable kernels as well.

> > Great! I see you already fixed up to 5.15. I suppose the code is really
> > backportable to the other still active branches (5.10, 5.4, 4.19).

> I plan to work on backporting to v5.10 next week.

> I've been asked to look at v5.4, but I'm not sure how difficult
> that will be because it's missing a lot of NFSD patches. I will
> look into that in a couple of weeks.

> I'm very likely to punt on v4.19, though Oracle's stable backport
> team might try to tackle it at some point. (pun intended)

Thanks a lot for info, we'll see what you / your Oracle backport team will
manage in the end.

> > We discussed in v1 how to fix tests.  Neil suggested to fix the test the way so
> > that it works on all kernels. As I note [1]

> > 1) either we give up on checking the new functionality still works (if we
> > fallback to old behavior)
> > 2) or we need to specify from which kernel we expect new functionality
> > (so far it's 5.15, I suppose it will be older).

> > I would prefer 2) to have new functionality always tested.
> > Or am I missing something obvious?

> I don't quite understand the question.

> The "old functionality" of reporting these statistics globally
> is broken, but we're stuck with it in the older kernels. I guess
> you might want to confirm that, for a given recent kernel
> release, the stats are actually per-namespace -- that's what we
> expect in fixed kernels. Is that what you mean?

Yes. I'm just trying to say that Neil's proposal "work everywhere without
checking kernel version" will not work. I would like next week, after you send
5.10 patches to expect anything >= 5.10 will have new functionality
and update kernel version if more gets backported.

Kind regards,
Petr

> > Kind regards,
> > Petr

> > [1] https://lore.kernel.org/linux-nfs/172367387549.6062.7078032983644586462@noble.neil.brown.name/

> >> Neil Brown suggested an alternative approach that might not depend
> >> on knowing the specific kernel version:

> >> https://lore.kernel.org/linux-nfs/172078283934.15471.13377048166707693692@noble.neil.brown.name/

> >> HTH


> >>> + else
> >>> + [ "$nfs_f" != "nfs" ] && type="rhost"
> >>> + fi

> >>> if [ "$type" = "lhost" ]; then
> >>> calls="$(grep $name /proc/net/rpc/$nfs_f | cut -d' ' -f$field)"
> >>> -- 
> >>> 2.45.2

