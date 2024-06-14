Return-Path: <linux-nfs+bounces-3823-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF481908ADF
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 13:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978ED1F286B5
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 11:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4857186E5D;
	Fri, 14 Jun 2024 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QPZPxEmL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EniCxY54";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QPZPxEmL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EniCxY54"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED05D14D29B
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718364792; cv=none; b=IH67KCuEprkNe/hsQbQ9H1flBF4ojuzOhMU0qRfZQnj+lI8n0BH2f1Kx6vm9PQe7FqMHmrxYbq5L2Vn7Kl0wQrkcGzlSgIbEOwN6a/oORRvzZ+Gu5klLo2Fg22bikzfl2MZO+QmQosxbUOJzKGzzR/uRYTY3U/+IKAkY1EqkpK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718364792; c=relaxed/simple;
	bh=utDP+d+njgtxR8SLt6se2h6ZYPulPNA5O9CT/lnlAJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTV5sSa27zekJ0CCD2OicBqh1ROLOigyQ+Yjilm77Su0Ouc50/XdoppuH5ivFUETKJnzbsWn7hBVcg7O2aNZtLcq/tyKctEblmDdVjpmVLrFA3vcfNpa5bJR5yPybaePtShWg593EXkyZYVoiGeHhsVP8KttIi02rnpomKXqxFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QPZPxEmL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EniCxY54; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QPZPxEmL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EniCxY54; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 42C0233747;
	Fri, 14 Jun 2024 11:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718364789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WCT2T0iZKEoFmmpIcxaFuzJO206Q1uuOZXK6md9HkA4=;
	b=QPZPxEmLYVdPIKMls8fmA5QbUd2JXwoJ6d1wxLBCvvFI0mwf+EHQlqgGD0Q6oJJIf4HbQs
	lpKMuJytXvpsxmO93/aoxKtLfDsaMdi4xccLbzgXYRH5x/rAO3YCbowfx9jCisT1T1a1u9
	NbMYWmxGdfRCWdq0MfgU32E9exTKX8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718364789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WCT2T0iZKEoFmmpIcxaFuzJO206Q1uuOZXK6md9HkA4=;
	b=EniCxY54dLun5gS4+GpUm3ZWrukoi2i/y5oNIbBYBlk2sRpwLHXCMxfBDl+YPRUOjECRwT
	g6SRR77v9GbLYhBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718364789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WCT2T0iZKEoFmmpIcxaFuzJO206Q1uuOZXK6md9HkA4=;
	b=QPZPxEmLYVdPIKMls8fmA5QbUd2JXwoJ6d1wxLBCvvFI0mwf+EHQlqgGD0Q6oJJIf4HbQs
	lpKMuJytXvpsxmO93/aoxKtLfDsaMdi4xccLbzgXYRH5x/rAO3YCbowfx9jCisT1T1a1u9
	NbMYWmxGdfRCWdq0MfgU32E9exTKX8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718364789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WCT2T0iZKEoFmmpIcxaFuzJO206Q1uuOZXK6md9HkA4=;
	b=EniCxY54dLun5gS4+GpUm3ZWrukoi2i/y5oNIbBYBlk2sRpwLHXCMxfBDl+YPRUOjECRwT
	g6SRR77v9GbLYhBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 386D213AAF;
	Fri, 14 Jun 2024 11:33:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EojFDXUqbGY6GgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 14 Jun 2024 11:33:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DD16CA0873; Fri, 14 Jun 2024 13:33:08 +0200 (CEST)
Date: Fri, 14 Jun 2024 13:33:08 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>
Subject: Re: [PATCH 2/3] nfs: Properly initialize server->writeback
Message-ID: <20240614113308.sqgrnzdczbw2za5a@quack3>
References: <20240612153022.25454-1-jack@suse.cz>
 <20240613082821.849-2-jack@suse.cz>
 <4ccfb492bd6af24f8bdfd085d369c7c94c1865d1.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ccfb492bd6af24f8bdfd085d369c7c94c1865d1.camel@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Thu 13-06-24 15:56:36, Jeff Layton wrote:
> On Thu, 2024-06-13 at 10:28 +0200, Jan Kara wrote:
> > Atomic types should better be initialized with atomic_long_set()
> > instead
> > of relying on zeroing done by kzalloc(). Clean this up.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/nfs/client.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > index de77848ae654..3b252dceebf5 100644
> > --- a/fs/nfs/client.c
> > +++ b/fs/nfs/client.c
> > @@ -994,6 +994,8 @@ struct nfs_server *nfs_alloc_server(void)
> >  
> >  	server->change_attr_type = NFS4_CHANGE_TYPE_IS_UNDEFINED;
> >  
> > +	atomic_long_set(&server->writeback, 0);
> > +
> >  	ida_init(&server->openowner_id);
> >  	ida_init(&server->lockowner_id);
> >  	pnfs_init_server(server);
> 
> I'm guilty of doing this, well, all over the place. Is there any
> plausible scenario where another task could see this value set to non-
> zero after kzalloc()? One would hope not...

No, it is not a practical problem these days. It is more a theoretical
correctness thing that atomic_t should be initialized through atomic_set()
and not memset() because in theory you don't know how some weird
architecture decides to implement it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

