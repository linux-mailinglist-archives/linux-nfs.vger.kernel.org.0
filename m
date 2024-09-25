Return-Path: <linux-nfs+bounces-6652-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D6B986847
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 23:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB50282804
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 21:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F742AE6C;
	Wed, 25 Sep 2024 21:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vKUf+K2g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fScy7wuS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vKUf+K2g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fScy7wuS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE841CF93
	for <linux-nfs@vger.kernel.org>; Wed, 25 Sep 2024 21:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727299529; cv=none; b=AlMccdbQHvcftPh/o653EmGtX6mku4Caj7tLAZP4A4cp5c4Qht4qLT9ZOD8mZQ5QAW5iUpGD8rU3AxgIMZG62rveoSw3DCbSZ63mvTkrNZEYKbSiHcSNWbDlhxrUFDlDcW7vquevQq4cqfNESDo/3N6zFokBHv6Ic9NJxW4yHGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727299529; c=relaxed/simple;
	bh=GcaYFshzEj5vmmeuIwAJk5Dg5xZtR1nZ8yO3/oBLmEo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=OYyHoz/mxae3XPsqsKSPMvGlxbm6Z+ARU+6P8o0eG+wEJksSbOozsQrFMqS56PtAah0lkdnUoF3/QwxZXb6djDgbLd5UpYh/8/qDXELY3gkOB2rC2SN3C2q+hf3Kt3uFyvBHFHZVvvvCgf3hkVfeBUfNraL2rvT6Yddkj8b+qss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vKUf+K2g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fScy7wuS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vKUf+K2g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fScy7wuS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A248E1F809;
	Wed, 25 Sep 2024 21:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727299525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rSmLqRMsPpABr98wn4pOXmAgEhg9PHzmMGIzcwT9PS0=;
	b=vKUf+K2gO272JdF580QthTSGjWgjf4WvB74T1sJE8lYyz/3If1nm5RIdbuMU1/RerirsT1
	izfYkSufKEFHT2cZnL5wzA23BMmvDj3Y9orKKDVLzBxkusB2Z4h/6znp5280JeD01Z+66V
	ilBT05aPnxhIA7adG35/D656PlBX91M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727299525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rSmLqRMsPpABr98wn4pOXmAgEhg9PHzmMGIzcwT9PS0=;
	b=fScy7wuSUJGoYiqvBSw26Az8sWkZ3nhYnFkwAAEREer+khDBhudolGO5maWHnvhQQeG/Cd
	P1FHn34uivw7EOCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vKUf+K2g;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fScy7wuS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727299525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rSmLqRMsPpABr98wn4pOXmAgEhg9PHzmMGIzcwT9PS0=;
	b=vKUf+K2gO272JdF580QthTSGjWgjf4WvB74T1sJE8lYyz/3If1nm5RIdbuMU1/RerirsT1
	izfYkSufKEFHT2cZnL5wzA23BMmvDj3Y9orKKDVLzBxkusB2Z4h/6znp5280JeD01Z+66V
	ilBT05aPnxhIA7adG35/D656PlBX91M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727299525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rSmLqRMsPpABr98wn4pOXmAgEhg9PHzmMGIzcwT9PS0=;
	b=fScy7wuSUJGoYiqvBSw26Az8sWkZ3nhYnFkwAAEREer+khDBhudolGO5maWHnvhQQeG/Cd
	P1FHn34uivw7EOCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 014EB13793;
	Wed, 25 Sep 2024 21:25:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 57zrKcJ/9Gb8YQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 25 Sep 2024 21:25:22 +0000
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
Cc: "Anna Schumaker" <anna@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>, linux-nfs@vger.kernel.org,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>
Subject: Re: [PATCH] sunrpc: fix prog selection loop in svc_process_common
In-reply-to: <ZvQcZge2KfnfvQwC@tissot.1015granger.net>
References: <172724928945.17050.3126216882032780036@noble.neil.brown.name>,
 <ZvQcZge2KfnfvQwC@tissot.1015granger.net>
Date: Thu, 26 Sep 2024 07:25:10 +1000
Message-id: <172729951045.17050.17378763434329064607@noble.neil.brown.name>
X-Rspamd-Queue-Id: A248E1F809
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.51
X-Spam-Flag: NO


[I fixed Dan's address - sorry about that]

On Thu, 26 Sep 2024, Chuck Lever wrote:
> Hi Neil -
> 
> On Wed, Sep 25, 2024 at 05:28:09PM +1000, NeilBrown wrote:
> > 
> > If the rq_prog is not in the list of programs, then we use the last
> > program in the list and subsequent tests on 'progp' being NULL are
> > useless.
> 
> That's the logic error, but what is the observed unexpected
> behavior?

The unexpected behaviour is that "if rq_prog is not in the list of
programs, then we use the last program in the list".  Isn't that a
behaviour?  Should I add that "we don't get the expected
rpc_prog_unavail error?
What am I missing?

> 
> 
> > We should only assign progp when we find the right program, and we
> > should initialize it to NULL
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Fixes: 86ab08beb3f0 ("SUNRPC: replace program list with program array")
> > Signed-off-by: NeilBrown <neilb@suse.de>
> 
> IIRC commit 86ab08beb3f0 went through Anna's tree during this merge
> window. It would be easier (for me) if Anna took this one.

I don't entirely understand the logic, but ok.

> 
> Acked-by: Chuck Lever <chuck.lever@oracle.com>

Thanks,
NeilBrown

> 
> 
> > ---
> >  net/sunrpc/svc.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> > 
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index 7e7f4e0390c7..79879b7d39cb 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -1321,7 +1321,7 @@ static int
> >  svc_process_common(struct svc_rqst *rqstp)
> >  {
> >  	struct xdr_stream	*xdr = &rqstp->rq_res_stream;
> > -	struct svc_program	*progp;
> > +	struct svc_program	*progp = NULL;
> >  	const struct svc_procedure *procp = NULL;
> >  	struct svc_serv		*serv = rqstp->rq_server;
> >  	struct svc_process_info process;
> > @@ -1351,12 +1351,9 @@ svc_process_common(struct svc_rqst *rqstp)
> >  	rqstp->rq_vers = be32_to_cpup(p++);
> >  	rqstp->rq_proc = be32_to_cpup(p);
> >  
> > -	for (pr = 0; pr < serv->sv_nprogs; pr++) {
> > -		progp = &serv->sv_programs[pr];
> > -
> > -		if (rqstp->rq_prog == progp->pg_prog)
> > -			break;
> > -	}
> > +	for (pr = 0; pr < serv->sv_nprogs; pr++)
> > +		if (rqstp->rq_prog == serv->sv_programs[pr].pg_prog)
> > +			progp = &serv->sv_programs[pr];
> >  
> >  	/*
> >  	 * Decode auth data, and add verifier to reply buffer.
> > -- 
> > 2.46.0
> > 
> 
> -- 
> Chuck Lever
> 


