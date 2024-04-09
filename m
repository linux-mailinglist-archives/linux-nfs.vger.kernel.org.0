Return-Path: <linux-nfs+bounces-2727-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D756089D0A4
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 05:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9891F22B09
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 03:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027BA54794;
	Tue,  9 Apr 2024 03:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vACUQuSu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p/PFA4fq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vVGbOFPN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WXBJh5f9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0260554756
	for <linux-nfs@vger.kernel.org>; Tue,  9 Apr 2024 03:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712631981; cv=none; b=osrHohoImhXK/hgseXCHBtEDOVIQtU68sJgbBY9TL0CFZ3n8TUP+NoRa52W7YJCtmJAramr9zWNiYfhRI3JYlmmqNSsDFMWDGv0ql2dzv6rxdOdTsbu/EyiuETFZ5zmzOOWyVqHlEmW1k0EqvO2SFJMFlcxI/F6/YK2egdepT74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712631981; c=relaxed/simple;
	bh=pvRrVUklp5f5mTIEVOMoFNq60pFAMtVbBcnTRunQD6Y=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=fTFNHtTJDFlexYuDfJepr7gZGNRwNmz53B45LChZAxe3kHxsRGAH3FSnyjEX7TSssaZIwsvH6acOpjZH/pb5dcLkSvyRlOW0GrI0xfIwVVrz9frcVhC/vvmSuP5JVCVbY/+izU0X7FcXFEV7Rq6Ubb3jBDT8fzCNBasEz1VV8ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vACUQuSu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p/PFA4fq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vVGbOFPN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WXBJh5f9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CBD7733767;
	Tue,  9 Apr 2024 03:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712631972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itAR3SdmWKOZD6ctqNrtQKq2nghkVrAaQJnukF4w1oU=;
	b=vACUQuSuaV67VkbOGEn8ohmZDXjoVw587VLmMURoFqOdlcJoAN6KekUoYmLZA3EoOjAAdV
	jb/i5zF04I1JZkPb7TYOF+Wm+z61ZTOZEBcvpQ1Ul64iarTV9njh6aEDkVWlfNdkH1MCeK
	WPoyBkG53buqpVVgDW1XvfW4E99IohA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712631972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itAR3SdmWKOZD6ctqNrtQKq2nghkVrAaQJnukF4w1oU=;
	b=p/PFA4fqWitEGgZmoWoqWXn8Lsv+n/mpCuin8UHKCV3YeAcdgaNHd4kJn/ovulafYy7upf
	Eww8c/oHWsP6D0Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vVGbOFPN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WXBJh5f9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712631971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itAR3SdmWKOZD6ctqNrtQKq2nghkVrAaQJnukF4w1oU=;
	b=vVGbOFPNcw2VfPiUAVZ/Aqoe+WL7LIqR7NnFQR2gepJAOIQxBuIeSXiF5Bn+XFhuvtHFiZ
	fIJ6kuPWoeaQom3RYrBLn+dxym6fIcWEwvr+xhNj2DLCOxpJrzlvWuadMONa+cTA7lMOEq
	DjSDx1eIl7JI3e6GHxGqMaZgDBY9nTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712631971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itAR3SdmWKOZD6ctqNrtQKq2nghkVrAaQJnukF4w1oU=;
	b=WXBJh5f9QILYiarQHN9qHeJDN26RGdW8scM48GXUprANwF3vA+9IBwMgL3PJ5UFIi3lImF
	kTiad4UCADXHtxCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBA5E13675;
	Tue,  9 Apr 2024 03:06:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dvqPG6CwFGZhAQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 09 Apr 2024 03:06:08 +0000
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
Cc: "Chen Hanxiao" <chenhx.fnst@fujitsu.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <kolga@netapp.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: remove redundant dprintk in exp_rootfh
In-reply-to: <ZhSjEGEMyVuyApha@tissot.1015granger.net>
References: <>, <ZhSjEGEMyVuyApha@tissot.1015granger.net>
Date: Tue, 09 Apr 2024 13:06:00 +1000
Message-id: <171263196068.17212.17916891599918470772@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CBD7733767
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

On Tue, 09 Apr 2024, Chuck Lever wrote:
> On Tue, Apr 09, 2024 at 11:12:12AM +1000, NeilBrown wrote:
> > On Tue, 09 Apr 2024, Chuck Lever wrote:
> > > On Tue, Apr 09, 2024 at 09:21:54AM +1000, NeilBrown wrote:
> > > > On Tue, 09 Apr 2024, Chen Hanxiao wrote:
> > > > > trace_nfsd_ctl_filehandle in write_filehandle has
> > > > > some similar infos.
> > > > 
> > > > Not all that similar.  The dprintk you are removing includes the inode
> > > > number and sb->s_id which the trace point don't include.
> > > > 
> > > > Why do you think that information isn't needed?
> > > 
> > > I asked him to remove that dprintk.
> > > 
> > > Can you say why you think that information is useful to provide
> > > via a dprintk? It doesn't seem useful to system administrators,
> > > IMO.
> > 
> > I'm not saying it is useful, but I don't think the onus is on me.
> 
> No the onus isn't on you. I'm merely asking for feedback (and I
> explain why below).
> 
> 
> > When removing tracing information, the commit message should at least
> > acknowledge what is being removed and make some attempt to justify it.
> > In this case the commit message claimed that nothing was being removed,
> > which is clearly false.  Maybe just the commit message needs to be
> > fixed.
> 
> Agreed, the patch description could have more detail and a proper
> justification.
> 
> 
> > I don't think these tracepoints are just for system administrators.
> > They are also for tech support when they are trying to remotely diagnose
> > a customer problem.  It is really hard to know what will actually be
> > useful.  Many times I have found that the particular information that I
> > want isn't available in any tracing.  I expect this is inevitable.  We
> > cannot trace EVERYTHING so there will always be gaps.
> 
> When there is no in-code tracepoint available, the usual course of
> action these days is to wheel out BPF, systemtap, or drgn. Distro
> support engineers know how to do that. Server administrators might
> not be so well trained, so I consider dprintk() of primary
> importance to them.

Point for clarification: do you see tracepoints and dprintk as having
different audiences, or do you see them as serving the same purpose with
dprintk being a legacy implementation which is slowly being transitioned
to tracepoints?  I had assumed the latter but your language above makes
me wonder.

Certainly systemtap and other are invaluable and should be understood by
support engineers, but its a whole lot easier (and quicker) if the
useful information is easily available.  Our first-level support can
easily ask for a rpcdebug or trace-cmd trace and if we can get all the
useful information from there, that is a big win.
(It'll be nice when we can stop using rpcdebug and only ask for
trace-cmd output).

> 
> Here the dprintk() is reporting information that seems useful only
> to kernel developers. That's a code smell IMO. And the guidance in
> these cases, historically, has been to remove such observability
> either before a patch is merged, or after the fact, as we're doing
> here.

Interesting...  I had always assumed that dprintk/trace was largely
useless without some understanding of the inner workings of the kernel. 
I certainly need to dig around before I can work out how to interpret
the trace information.  So I think of all of it as "useful only to
kernel developers" ... or potential developers.

> 
> 
> > But removing some information that was previously generated seems
> > like a regression that should at least be justified.
> > In the case of write_filehandle() we are now tracing the request, but
> > not the result.  Is this generally sensible?
> 
> Let's instead look at the specific situation. The purpose of the
> nfsd_ctl_* tracepoints is to record in the trace log when 
> configuration changes are made, in order to juxtapose those with
> other server operation.

configuration changes?  write_filehandle is used by mountd to get a
filehandle to return to a v3 MOUNT request.  I guess that is a config
change on the client, but not on the server.

> 
> So, here, it's quite sensible. We want to observe the information
> that was passed from user space, and the starting timestamp.
> 
> 
> > Would it not make sense to
> > trace both after the core of the function (exp_rootfh) has completed?
> 
> In some cases there are already tracepoints that would report or
> infer the new state, so reporting a result would be redundant in
> those cases.

Well there was already a dprintk, but that is being removed...  I don't
know what other tracepoint might already provide this info.  Maybe I'm
confused about your meaning.

> 
> 
> > At lease the knfsd_fh_hash() of the generated filehandle could be
> > reported.
> 
> Chen's original patch replaced the dprintk with a tracepoint. So I
> asked, a week or so ago, for exactly this kind of feedback. There
> have been no responses until now. Therefore it seemed logical to
> assume no-one had a use for this info.

Sorry - I don't pay as close attention to nfs traffic as I might like.
(In this case I was on leave a week ago...)

> 
> The folks whom this information would serve have been silent to date
> with any specific suggestions, and usually we hear from someone
> quickly when removing observability that is depended upon.
> 
> We could record the FH hash, but what would it be used for? User
> space requested the FH, which can be reported by the requesting
> program.

What is the FH hash ever used for?  Presumably for tracking a particular
object through multiple tracepoints.  Maybe we need to see when the dir
that the client mounted gets accessed later?

> 
> I'm not hearing a convincing specific justification for maintaining
> observability here.... but we have a few more weeks before making a
> more permanent decision.
> 

I'm not seeing a significant cost in maintaining observability.  But I
don't know that I care quite enough to write a patch.  So I'll leave it
up to you.

Thanks,
NeilBrown


> 
> -- 
> Chuck Lever
> 


