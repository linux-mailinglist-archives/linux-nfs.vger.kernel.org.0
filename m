Return-Path: <linux-nfs+bounces-4667-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11759928F43
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 00:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C631C22C61
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 22:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6829E13F432;
	Fri,  5 Jul 2024 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dlmYzgnU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uwBrpL1Z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dlmYzgnU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uwBrpL1Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE101F61C
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jul 2024 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720217302; cv=none; b=fg7UCc5PMlp9mqAcuwSrGwg48jYbLjQ3yxHv8IL2SzC46seXJOgoqAE5ms4LDj2V3PNVanPs1ZGTV72rV7fPKb0IK/ThfhMnL2kxEtgwnEthS9wu+ex7fxoeqD/GOiom/ay2xESQYH0MTDC0HirwBxhVJLuRhiKeOP1rN6umyqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720217302; c=relaxed/simple;
	bh=AgrbDmFkwKbfZvSsdSgEzUqho3oyQG2tRN4dqwTsWao=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Tpa6e3Dv/c6vp9i0e/GDBrEUxm62ltxprEuVlCZvZPhGTDEAauFYb0KpyQ4PAsnvN59ccX7LccRu8KrYtrB+aMXZ/DnFJ7NPWYpqTGh9wGzVdcD7eiVxDLEm175PdOmEn15lomqwA7LLYhl8uv9szqQ1snJKrSBdxvup6KXs+s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dlmYzgnU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uwBrpL1Z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dlmYzgnU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uwBrpL1Z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 600121F820;
	Fri,  5 Jul 2024 22:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720217298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=++YmCUcX2bBU2dWSFAjMZg446UHM1/vpGxhlYQgcO7E=;
	b=dlmYzgnUge5ke5VL9FdrQCu4wOxu5WTk+abyUAYO7qmo4WzCRdbbpL1h1n8IjW4L0P8lyJ
	3VrBMbD+8ZYeH5Z1dwj99YRbkUJoQEE7DaqS4+j4q+RFx8ZXwLGPnvmY1z1Ug+tNAiPA2b
	/aL68VPsWp2Q31BXFe+Wfp2QYk0FSYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720217298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=++YmCUcX2bBU2dWSFAjMZg446UHM1/vpGxhlYQgcO7E=;
	b=uwBrpL1ZCLQ2xNWCzP0BCMK4rnyvniW6tmtAQtpAziNNVzHEdtWZ+BINk15OTRXIlebu+A
	X7ez6K6iPaAjyOAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720217298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=++YmCUcX2bBU2dWSFAjMZg446UHM1/vpGxhlYQgcO7E=;
	b=dlmYzgnUge5ke5VL9FdrQCu4wOxu5WTk+abyUAYO7qmo4WzCRdbbpL1h1n8IjW4L0P8lyJ
	3VrBMbD+8ZYeH5Z1dwj99YRbkUJoQEE7DaqS4+j4q+RFx8ZXwLGPnvmY1z1Ug+tNAiPA2b
	/aL68VPsWp2Q31BXFe+Wfp2QYk0FSYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720217298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=++YmCUcX2bBU2dWSFAjMZg446UHM1/vpGxhlYQgcO7E=;
	b=uwBrpL1ZCLQ2xNWCzP0BCMK4rnyvniW6tmtAQtpAziNNVzHEdtWZ+BINk15OTRXIlebu+A
	X7ez6K6iPaAjyOAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F33921396E;
	Fri,  5 Jul 2024 22:08:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 58EjJc5uiGZmEQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 05 Jul 2024 22:08:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Mike Snitzer" <snitzer@kernel.org>,
 "Christoph Hellwig" <hch@infradead.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever III" <chuck.lever@oracle.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Dave Chinner" <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
In-reply-to: <ZoeCFwzmGiQT4V0a@infradead.org>
References: <>, <ZoeCFwzmGiQT4V0a@infradead.org>
Date: Sat, 06 Jul 2024 08:08:07 +1000
Message-id: <172021728732.11489.12447081357748108934@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Fri, 05 Jul 2024, Christoph Hellwig wrote:
> On Thu, Jul 04, 2024 at 02:31:46PM -0400, Mike Snitzer wrote:
> > Some new layout misses the entire point of having localio work for
> > NFSv3 and NFSv4.  NFSv3 is very ubiquitous.
> 
> I'm getting tird of bringing up this "oh NFSv3" again and again without
> any explanation of why that matters for communication insides the
> same Linux kernel instance with a kernel that obviously requires
> patching.  Why is running an obsolete protocol inside the same OS
> instance required.  Maybe it is, but if so it needs a very good
> explanation.

I would like to see a good explanation for why NOT NFSv3.
I don't think NFSv3 is obsolete.  The first dictionary is "No longer in
use." which certainly doesn't apply.
I think "deprecated" is a more relevant term.  I believe that NFSv2 has
been deprecated.  I believe that NFSv4.0 should be deprecated.  But I
don't see any reason to consider NFSv3 to be deprecated.


> 
> > And in this localio series, flexfiles is trained to use localio.
> > (Which you apparently don't recognize or care about because nfsd
> > doesn't have flexfiles server support).
> 
> And you fail to explain why it matters.  You are trying to sell this
> code, you better have an explanation why it's complicated and convoluted
> as hell.  So far we are running in circles but there has been no clear
> explanation of use cases.

Please avoid sweeping statements like "complicated and convoluted"
without backing them up with specifics.
I don't particularly want to defend the current localio protocol, and I
certainly see a number of points which can and must be improved.  But it
isn't clear to me that the big picture is either complicated or
convoluted.  Please provide details.

Thanks,
NeilBrown


