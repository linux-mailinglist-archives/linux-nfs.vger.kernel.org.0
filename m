Return-Path: <linux-nfs+bounces-8421-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA579E834E
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 04:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B502E281B44
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 03:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBC417C77;
	Sun,  8 Dec 2024 03:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LmUxGqai";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dNHcTkMi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LmUxGqai";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dNHcTkMi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D902749C
	for <linux-nfs@vger.kernel.org>; Sun,  8 Dec 2024 03:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733628572; cv=none; b=P1C5JOCPLMJOUhcqu5oOB1qKDpOnToszjR+/6cI3zn+jWtj37DdlwKNE2ry99Fsvh+8Pm+YNWJhPChLdH28Umxged5WGWWwaQSvhqIDkGsIoaUg1kT9EWX0fHJdV2aSa4M449H5X+29g8LVw3w9N0Ruz3CKKd0+Q/T+v0lkAETU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733628572; c=relaxed/simple;
	bh=q4R0Gfrfwi41L2TNngxMcDZ/AG3pZO9vzmqcUKXEQ4I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=u10919BEpRs6jh0rZvQvzTxmunoyMHH32o2CZBBIwHZTwFpmiITnEE3bcVYA0Lu56CEI30PIkAz6ndGWoR5tZei4/FZs7P/kzPgyzOz5r694zM6okrFZ6G+BwwKuypcf8pV2CrtNZVJteBSu84JkLrIDqY6bNyuRBM0P3KiCNLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LmUxGqai; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dNHcTkMi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LmUxGqai; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dNHcTkMi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 246301F37E;
	Sun,  8 Dec 2024 03:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733628568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqTsuqYIlJ/s2NyousTgw8IJS3Xc3xsxPH0b7K2Iz7Y=;
	b=LmUxGqaiq40lxPt/JVGEjwHJkFVumvN240Nnr406YenS8xdVmZZZT++ymVVb1T3xW3H9mc
	c7CpKlQLARdhBCw3FP07Fqj/FEODLd+nLEaDBC4K0XsgSStOCn47O1825rb6fLH5Ukas3D
	agkzS9l4XUgOqbRB1YH0KN+8+cR1+sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733628568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqTsuqYIlJ/s2NyousTgw8IJS3Xc3xsxPH0b7K2Iz7Y=;
	b=dNHcTkMiUEFZxkO6hD6okUVkun+7H8C5z3ykIL9iFoYdr78FDRTAaZT8d6v6iUG6dcwdJW
	Q4j7S/1LSnHzTqBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733628568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqTsuqYIlJ/s2NyousTgw8IJS3Xc3xsxPH0b7K2Iz7Y=;
	b=LmUxGqaiq40lxPt/JVGEjwHJkFVumvN240Nnr406YenS8xdVmZZZT++ymVVb1T3xW3H9mc
	c7CpKlQLARdhBCw3FP07Fqj/FEODLd+nLEaDBC4K0XsgSStOCn47O1825rb6fLH5Ukas3D
	agkzS9l4XUgOqbRB1YH0KN+8+cR1+sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733628568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqTsuqYIlJ/s2NyousTgw8IJS3Xc3xsxPH0b7K2Iz7Y=;
	b=dNHcTkMiUEFZxkO6hD6okUVkun+7H8C5z3ykIL9iFoYdr78FDRTAaZT8d6v6iUG6dcwdJW
	Q4j7S/1LSnHzTqBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 932C5133D1;
	Sun,  8 Dec 2024 03:29:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MuBtEZYSVWd0eQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 08 Dec 2024 03:29:26 +0000
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
Cc: "Roland Mainz" <roland.mainz@nrubsig.org>,
 "Steve Dickson" <SteveD@redhat.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [patch] mount.nfs: Add support for nfs://-URLs ...
In-reply-to: <cce34896-f8fe-42fa-a8aa-4a26cd42498c@oracle.com>
References: <>, <cce34896-f8fe-42fa-a8aa-4a26cd42498c@oracle.com>
Date: Sun, 08 Dec 2024 14:29:18 +1100
Message-id: <173362855836.1734440.12419990006245500946@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 08 Dec 2024, Chuck Lever wrote:
> On 12/7/24 3:53 PM, NeilBrown wrote:
> > On Sat, 07 Dec 2024, Chuck Lever wrote:
> >> Hi Roland, thanks for posting.
> >>
> >> Here are some initial review comments to get the ball rolling.
> >>
> >>
> >> On 12/6/24 5:54 AM, Roland Mainz wrote:
> >>> Hi!
> >>>
> >>> ----
> >>>
> >>> Below (and also available at https://nrubsig.kpaste.net/b37) is a
> >>> patch which adds support for nfs://-URLs in mount.nfs4, as alternative
> >>> to the traditional hostname:/path+-o port=<tcp-port> notation.
> >>>
> >>> * Main advantages are:
> >>> - Single-line notation with the familiar URL syntax, which includes
> >>> hostname, path *AND* TCP port number (last one is a common generator
> >>> of *PAIN* with ISPs) in ONE string
> >>> - Support for non-ASCII mount points, e.g. paths with CJKV (Chinese,
> >>
> >> s/mount points/export paths
> >>
> >> (When/if you need to repost, you should move this introductory text into
> >> a cover letter.)
> >>
> >>
> >>> Japanese, ...) characters, which is typically a big problem if you try
> >>> to transfer such mount point information across email/chat/clipboard
> >>> etc., which tends to mangle such characters to death (e.g.
> >>> transliteration, adding of ZWSP or just '?').
> >>> - URL parameters are supported, providing support for future extensions
> >>
> >> IMO, any support for URL parameters should be dropped from this
> >> patch and then added later when we know what the parameters look
> >> like. Generally, we avoid adding extra code until we have actual
> >> use cases. Keeps things simple and reduces technical debt and dead
> >> code.
> >>
> >>
> >>> * Notes:
> >>> - Similar support for nfs://-URLs exists in other NFSv4.*
> >>> implementations, including Illumos, Windows ms-nfs41-client,
> >>> sahlberg/libnfs, ...
> >>
> >> The key here is that this proposal is implementing a /standard/
> >> (RFC 2224).
> > 
> > Actually it isn't.  You have already discussed the pub/root filehandle
> > difference.
> 
> RFC 2224 specifies both. Pub vs. root filehandles are discussed
> there, along with how standard NFS URLs describe either situation.
> 
> 
> > The RFC doesn't know about v4.  The RFC explicitly isn't a
> > standard.
> 
> RFC 7532 contains the NFSv4 bits. RFC 2224 is not a Normative
> standard, like all early NFS-related RFCs, but it is a
> specification that other implementations cleave to. RFC 7532
> /is/ a Normative standard.

The usage in RFC 7532 is certainly more convincing than 2224.

> 
> 
> > So I wonder if this is the right approach to solve the need.
> > 
> > What is the needed?
> > Part of it seems to be non-ascii host names.  Shouldn't we fix that for
> > the existing syntax?  What are the barriers?
> 
> Both non-ASCII hostnames (iDNA) and export paths can contain
> components with non-ASCII characters.

But they cannot contain non-Unicode characters, so UTF-8 should be
sufficient.

> 
> The issue is how to specify certain code points when the client's
> locale might not support them. Using a URL seems to be the mechanism
> chosen by several other NFS implementations to deal with this problem.

If locale-mismatch is a problem, it isn't clear to me that "mount.nfs"
is the place to solve it.

The problem is presented as:

 to transfer such mount point information across email/chat/clipboard
 etc., which tends to mangle such characters to death (e.g.
 transliteration, adding of ZWSP or just '?').

So it sounds like the problem is copy/paste.  I doubt that NFS addresses
are the only things that can get corrupted.
Maybe a more generic tool would be appropriate.

How are people going to create the nfs: urls so they can paste them into
the chat?  In there a reverse tool for getting them out?

Or we just just adding a hack to avoid "*PAIN* with ISPs" rather then
getting the ISPs to fix their breakage?

> 
> 
> > Part seems to be the inclusion of the port number.  Is a "URL" really
> > the best way to solve that need?
> > Mount.nfs currently expects ":/" to separate host name from path.
> > I think host:port:/path would be unambiguous providing "port" did not
> > start "/".
> 
> There's also IPv6 presentation addresses, which contain ":" already.

Those are usually inside [] I think.

> 
> However host:port:/path is not something that other NFS implementations
> (eg that might share an automounter map) would understand. There is a
> significantly higher likelihood that those implementations would be
> able to interpret an NFS URI correctly.
> 
> I'm not especially convinced by the arguments about port numbers, but
> I don't happen to use alternate ports daily.
> 
> 
> > Do we really need the % encoding that the URL syntax gives us?  If so -
> > why?
> 
> See above. Character set translation issues.
> 
> And note that NFS URIs are coming soon to other parts of the Linux NFS
> administrative interface. No reason that mount.nfs should not also
> support them properly.

Are they?  Where?  That certainly might be a good justification.

nfs: urls were introduced precisely for WebNFS (as I understand it).  So
when the post said "This is not about WebNFS" I had to wonder if they
were really the right tool for a very different task.  Maybe they are,
but I think comprehensive justification is needed.

Thanks,
NeilBrown

