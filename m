Return-Path: <linux-nfs+bounces-4980-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D48934B26
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2024 11:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E19BBB221FF
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2024 09:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFE63CF58;
	Thu, 18 Jul 2024 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DB6livRT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7A31D+WS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DB6livRT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7A31D+WS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B928C06
	for <linux-nfs@vger.kernel.org>; Thu, 18 Jul 2024 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721296071; cv=none; b=PeTLtQhmsAr6KedaRMEzaqxVyiEU/E6jQSS8LJbY0V0jqiBC6MIOymIRdXlZjxRwOvxXhNlZhJ50EGFgOFB520V3MoIVlrI53gXqVFOB69IVwir8COrUPA/WskYmFZy12Q+4jVkXifCkZ7C42viUH1zMgNWS7O49s1eUGKN4QHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721296071; c=relaxed/simple;
	bh=3Qow/UubaOvv2FXr89Ep+loRY645ORZeVYSwVaAuQrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBkKh83ROKOT8D2lMFFmGL5baENlpcsyuOFw52PO4na+aTB5eLcRz+SkGkW5hf3W4GmquDUMy5uKFdr+2OmSgV4ICifnACOSiXOVxMkgdE02FDPUhMVtaKvnwbs+vxS4H2rO5gLaaxXEiSDXH7kpRlaoHoTh0+PGAWEII/noM2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DB6livRT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7A31D+WS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DB6livRT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7A31D+WS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7FEB11FBB4;
	Thu, 18 Jul 2024 09:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721296067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IkuAby009k90ubu/jobZkBhSNa39omEgkZXzlSiwwrg=;
	b=DB6livRT0OrZCONJq388KR4T58MBSnvAV+YrUlKP9/ISd05jtOuZm8hnBuyXntrbQemgtq
	Zmw8FV+c1xbCjJSu9SNPIGwxpaI5q9v1ZLUXjeJZuSpSfFDOjrWkXLwrRXA3gGBrasn9QP
	Fk1y5gyrv9PuRgUpqgk1SWMlwCGhoa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721296067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IkuAby009k90ubu/jobZkBhSNa39omEgkZXzlSiwwrg=;
	b=7A31D+WSXkGcBXmRrMtW+fBGrAbhPqWsfRK1Klqj3EXAypEbEXhexsaRiJeV7tnEJcDhuP
	SVVSgEeSvqxZiXDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DB6livRT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7A31D+WS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721296067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IkuAby009k90ubu/jobZkBhSNa39omEgkZXzlSiwwrg=;
	b=DB6livRT0OrZCONJq388KR4T58MBSnvAV+YrUlKP9/ISd05jtOuZm8hnBuyXntrbQemgtq
	Zmw8FV+c1xbCjJSu9SNPIGwxpaI5q9v1ZLUXjeJZuSpSfFDOjrWkXLwrRXA3gGBrasn9QP
	Fk1y5gyrv9PuRgUpqgk1SWMlwCGhoa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721296067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IkuAby009k90ubu/jobZkBhSNa39omEgkZXzlSiwwrg=;
	b=7A31D+WSXkGcBXmRrMtW+fBGrAbhPqWsfRK1Klqj3EXAypEbEXhexsaRiJeV7tnEJcDhuP
	SVVSgEeSvqxZiXDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 676821379D;
	Thu, 18 Jul 2024 09:47:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vpb5GMPkmGbmPQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Jul 2024 09:47:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 20973A0987; Thu, 18 Jul 2024 11:47:47 +0200 (CEST)
Date: Thu, 18 Jul 2024 11:47:47 +0200
From: Jan Kara <jack@suse.cz>
To: Anna Schumaker <anna@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Trond Myklebust <trondmy@kernel.org>,
	linux-nfs@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH RESEND v2 0/3] nfs: Improve throughput for random
 buffered writes
Message-ID: <20240718094747.labht76fwq6a4bi6@quack3>
References: <20240617073525.10666-1-jack@suse.cz>
 <20240717155808.hemnfxyrbfwu6euo@quack3>
 <CAFX2JfkGU21cDZ81GeajCZu6LaAZXK7+xMU55Q2dWjLOVG4-bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFX2JfkGU21cDZ81GeajCZu6LaAZXK7+xMU55Q2dWjLOVG4-bA@mail.gmail.com>
X-Rspamd-Queue-Id: 7FEB11FBB4
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spamd-Bar: /

Hi Anna!

On Wed 17-07-24 13:44:57, Anna Schumaker wrote:
> On Wed, Jul 17, 2024 at 11:58 AM Jan Kara <jack@suse.cz> wrote:
> >
> > Ping? I don't see these patches being in NFS git tree. Did they fall
> > through the cracks?
> 
> I have these patches in my tree starting with this commit:
> http://git.linux-nfs.org/?p=anna/linux-nfs.git;a=commit;h=37d4159dd25ade59ce0fecc75984240e5f7abc14

Aha, great! I was checking the tree mentioned in MAINTAINERS file which is
Trond's one and because it seemed fairly active it didn't occur to me you
are maintaining your tree as well. Thanks for the link!

One more question: Do you plan to push these changes for 6.11 or 6.12?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

