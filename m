Return-Path: <linux-nfs+bounces-10052-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA20A326F8
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 14:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AF216502A
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 13:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EF020E026;
	Wed, 12 Feb 2025 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1h6HhAyW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a87re1yi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1h6HhAyW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a87re1yi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A122066DB
	for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2025 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739366869; cv=none; b=F9clazo1bGYlq61E1g+ogfqG95P8s/3qLNvcZ0MJrw49GVDXSTLaHd1hFluWj6yzO6I5RU6oJ6dsqiGMpOE5FQA6ov8pY89x0vVoTBDGnkvmtqiyitpbhfT3OKQxRT7crIPIr4IQl8DEF3THcKxkflfvPl7Gkd4kibTbyn5YKxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739366869; c=relaxed/simple;
	bh=GFoJyicM1YowVTTRKspiHXamr0LLytdP5D3QW7o4h0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx/bEECl2hsKiC1QI8SpeGrg9ZyoipWCdiFT6MpO5HghDcZEOMO3R+4MGHZzj6IHrOBDK1/1p/E0cneCe7i8m5gIe/0m17xXwNZnNchBNKWNmJQbFeXt7GVi+DeXIQGIuzxDTX9U/BGhDJDKnG+yj1hJxXdTsUZzCfut2JVpkxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1h6HhAyW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a87re1yi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1h6HhAyW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a87re1yi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A104F1FD3D;
	Wed, 12 Feb 2025 13:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739366865;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GFoJyicM1YowVTTRKspiHXamr0LLytdP5D3QW7o4h0s=;
	b=1h6HhAyW0X5FTPHMPHiLTxw5ewHsndjbr9XJSaJKu8+33VtyVJac1SzTZY70zDJ/fbuLlQ
	0UzMIRKTMylVmTvz+T6+N1AcG0lssF0sTNh2QHSqALlQd4fWP7rdvnD1mzyElSz/dypU6l
	3Zs/MZD89HuAsMQkW54rdARow6Dlc88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739366865;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GFoJyicM1YowVTTRKspiHXamr0LLytdP5D3QW7o4h0s=;
	b=a87re1yiGhH6muHhEl8jk2Tyx8uzjLBDGm//HqKl53zhg1Vv8Ulr7A8g2XuYIeYF5IdBLU
	YXICOK4mziNhgMAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739366865;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GFoJyicM1YowVTTRKspiHXamr0LLytdP5D3QW7o4h0s=;
	b=1h6HhAyW0X5FTPHMPHiLTxw5ewHsndjbr9XJSaJKu8+33VtyVJac1SzTZY70zDJ/fbuLlQ
	0UzMIRKTMylVmTvz+T6+N1AcG0lssF0sTNh2QHSqALlQd4fWP7rdvnD1mzyElSz/dypU6l
	3Zs/MZD89HuAsMQkW54rdARow6Dlc88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739366865;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GFoJyicM1YowVTTRKspiHXamr0LLytdP5D3QW7o4h0s=;
	b=a87re1yiGhH6muHhEl8jk2Tyx8uzjLBDGm//HqKl53zhg1Vv8Ulr7A8g2XuYIeYF5IdBLU
	YXICOK4mziNhgMAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77E1E13AEF;
	Wed, 12 Feb 2025 13:27:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DhpXHNGhrGfgGwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 12 Feb 2025 13:27:45 +0000
Date: Wed, 12 Feb 2025 14:27:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Calum Mackay <calum.mackay@oracle.com>,
	Michael Moese <mmoese@suse.com>
Subject: Re: [PATCH pynfs] Allow to fallback to xdrlib if xdrlib3 not
 available
Message-ID: <20250212132744.GA2043440@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250212132346.2043091-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212132346.2043091-1-pvorel@suse.cz>
X-Spam-Level: 
X-Spamd-Result: default: False [-1.91 / 50.00];
	BAYES_HAM(-1.41)[91.03%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -1.91
X-Spam-Flag: NO

Hi,

I'm sorry, the subject was supposed to be:

[PATCH pynfs] Allow to fallback to xdrlib if xdrlib3 not available

Kind regards,
Petr

