Return-Path: <linux-nfs+bounces-1204-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9AA832312
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jan 2024 02:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9681F22794
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jan 2024 01:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B743C28;
	Fri, 19 Jan 2024 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QZx52EeU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4JHj4o9N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QZx52EeU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4JHj4o9N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F97F3C0A
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jan 2024 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705628636; cv=none; b=Tdid/sEKjIisMKgyHEhFDgqI/dkzPwCRSAXA/SHV/qObqM9sGx6iuCUSttPL2iGwt17KOz9fW4HdghvJ0rLc7p0Fp4LdZDlps5cj7v2kUkWdNn5uH48Hc49P5oFjKNohwjN/KLKmCFkqQbVDvCi6BR8mpp9kp1NOihMbbNFihzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705628636; c=relaxed/simple;
	bh=vFA94ZkARncC92IsI0gJKCCAOQfKaZcCiTrHUAzivWo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=AQgoEiiTqrq4v51vC2TW4V6rsb08oQrg7SNOSm0d4KNs+DxGciLXRDuGVjIIco5/Ar0YbrjwrZSk3X8YANWAVDZ0gJsp7f2+U1W+MNpqwmV/DYiet5rogbtnVmX2iB6d/EQbTp1A1ak0pIgdGzFjpgzEdaRPmyj5ogBANZeOTOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QZx52EeU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4JHj4o9N; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QZx52EeU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4JHj4o9N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B31F21FBF;
	Fri, 19 Jan 2024 01:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705628633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTpY+lhlCgXFvedNpNFzFiuSb5SeoI30lkEuaTDtJcg=;
	b=QZx52EeUyANE6yPxwVxPuSHB27vkNCMPE5jPRvXnkkEIegULkua8F0R31KW7gp8W8IK+uQ
	VoOGZGajFJs2xLPui5O/6uvGRyZCn+Hth/HlypM31EWDudQsqANrNIbAq8+02f3fPvM/NX
	2T6ryEi2qWAzD0QTc14UEAIQgRreUjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705628633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTpY+lhlCgXFvedNpNFzFiuSb5SeoI30lkEuaTDtJcg=;
	b=4JHj4o9NVZavE51iygo6QkNXq7zqIrnMJ8F9Ld2fyES638K+ZEUu72ijsFVX3Ki9fFLxY6
	OP2h8NrdrlkOBnCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705628633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTpY+lhlCgXFvedNpNFzFiuSb5SeoI30lkEuaTDtJcg=;
	b=QZx52EeUyANE6yPxwVxPuSHB27vkNCMPE5jPRvXnkkEIegULkua8F0R31KW7gp8W8IK+uQ
	VoOGZGajFJs2xLPui5O/6uvGRyZCn+Hth/HlypM31EWDudQsqANrNIbAq8+02f3fPvM/NX
	2T6ryEi2qWAzD0QTc14UEAIQgRreUjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705628633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTpY+lhlCgXFvedNpNFzFiuSb5SeoI30lkEuaTDtJcg=;
	b=4JHj4o9NVZavE51iygo6QkNXq7zqIrnMJ8F9Ld2fyES638K+ZEUu72ijsFVX3Ki9fFLxY6
	OP2h8NrdrlkOBnCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AF9613777;
	Fri, 19 Jan 2024 01:43:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TkQjANfTqWWcWwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 19 Jan 2024 01:43:50 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject:
 Re: [PATCH 07/11] nfsd: allow admin-revoked NFSv4.0 state to be freed.
In-reply-to: <ZWOJdVwsOI/IKZVp@tissot.1015granger.net>
References: <20231124002925.1816-1-neilb@suse.de>,
 <20231124002925.1816-8-neilb@suse.de>,
 <ZWOJdVwsOI/IKZVp@tissot.1015granger.net>
Date: Fri, 19 Jan 2024 12:43:48 +1100
Message-id: <170562862834.23031.8326629221834970585@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.991];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[42.51%]
X-Spam-Flag: NO

On Mon, 27 Nov 2023, Chuck Lever wrote:

> > +static void nfsd_drop_revoked_stid(struct nfs4_stid *s)
> > +{
> > +	struct nfs4_client *cl = s->sc_client;
> > +
> > +	switch (s->sc_type) {
> > +	default:
> > +		spin_unlock(&cl->cl_lock);
> > +	}
> > +}
> 
> I'm not in love with unlocking cl_lock inside nfsd_drop_revoked_stid,
> but I understand why it's necessary. How about:
> 
> static void nfsd4_drop_revoked_stid_unlock(struct nfs4_client *cl,
> 					   struct nfs4_stid *s)
> 	__releases(&cl->cl_lock)
> {
> 	....
> 

I made it
	__releases(&s->sc_client->cl_lock)

thanks.
NeilBrown

