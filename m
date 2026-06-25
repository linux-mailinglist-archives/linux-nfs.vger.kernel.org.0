Return-Path: <linux-nfs+bounces-22839-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iaq4D+9lPWoJ2ggAu9opvQ
	(envelope-from <linux-nfs+bounces-22839-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 19:31:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF7A6C7CB3
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 19:31:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="JyWz/so9";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22839-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22839-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD465304C37E
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 17:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B6223395F;
	Thu, 25 Jun 2026 17:31:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC8A1C695
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2026 17:31:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408685; cv=none; b=rt4UCjhjlwa38wEHxePEwdMAvkjY3yHsb0MWMnRUj7+/SNPOPI8B98MxTOQyS3iXosOe/Q3rtHKBiG7fZeE+lgvuAFhNqU8DN+WuAiHZ8elA6lIfeLd3iaGlbhSdM+V2Gn/npdBqtWRDQ2lxzCasHRu1UWQ0F4cW7ju069PIWV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408685; c=relaxed/simple;
	bh=c2lU4rMq1FEMAcA/hCAZMuBdxfd4KcxtaA3stXyJjZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDlxP3CfY35uY4V2PYDnaVWP8mIrjoOUvtSFkXfVlHmuRQ/kloY43sEg6+oK0tokO4p2gSqwyVzFRh/XqpTfX8WhaaUhN9NKV78y4wVTAuuaDGNFlQnmEITKjSRSsKpSaHPtY/fQlOV3IMlE1YdLfnC06oDeImXSGTGoxNfwIis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyWz/so9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E9B1F000E9;
	Thu, 25 Jun 2026 17:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782408683;
	bh=N1pf2ISjatJU5GZKzU5itdhJRp/l3uYrDfSTynbQagk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JyWz/so9Juv5puVkFhRzt1XbILSx0zmGJUlAWFZvfMxkgN8c4XrNB6UcJ5qcuiZAZ
	 wuvCPbT5VDhyr9SZ6n5DqYLHLrTjbFGA7HAnGyZ8ifxkR2CqvuloyTBWGExbMX9XKU
	 yMQyiB9I/GEu0GEj40uXLKbG0Fw2+zE16CmOH0N1CVExkTH8fVQNDUFJj/3127/8Oe
	 iM+YcONSb5XrnwlFjnRjZ72KfGKxmJVE2dShUZqxSsu/jtYMC0Eyr4hJss+ZL7zNQM
	 1UTEdw0iX+BWccqit/VvIYz5KH+HS6VKYskFq9akUSajM39tBEdN6aOTix1BCsDhWN
	 QeqdgfS+Cklkw==
Date: Thu, 25 Jun 2026 13:31:22 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>,
	Tom Haynes <loghyr@hammerspace.com>, Chuck Lever <cel@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/4] nfs4.2: add nfs4_2.x to generate the
 UNCACHEABLE_FILE_DATA attribute
Message-ID: <aj1l6i8ebnkHu67U@kernel.org>
References: <20260624191706.72544-1-snitzer@kernel.org>
 <20260624191706.72544-2-snitzer@kernel.org>
 <16ff281b-f776-4e6c-9f2a-83c03f0d6eae@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16ff281b-f776-4e6c-9f2a-83c03f0d6eae@app.fastmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:anna@kernel.org,m:trondmy@kernel.org,m:loghyr@hammerspace.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22839-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FF7A6C7CB3

On Thu, Jun 25, 2026 at 10:26:22AM -0400, Anna Schumaker wrote:
> Hi Mike,
> 
> On Wed, Jun 24, 2026, at 3:17 PM, Mike Snitzer wrote:
> > Introduce Documentation/sunrpc/xdr/nfs4_2.x for NFSv4.2 protocol
> > extensions and define the UNCACHEABLE_FILE_DATA attribute (attr 87)
> > there, verbatim from draft-ietf-nfsv4-uncacheable-files Section 7:
> >
> >   typedef bool            fattr4_uncacheable_file_data;
> >   const FATTR4_UNCACHEABLE_FILE_DATA      = 87;
> >
> > This mirrors how the sibling NFSv4.2 attributes (FATTR4_OFFLINE=83,
> > FATTR4_TIME_DELEG_*=84/85, FATTR4_OPEN_ARGUMENTS=86) are defined in
> > Documentation/sunrpc/xdr/nfs4_1.x and generated by
> > tools/net/sunrpc/xdrgen into <linux/sunrpc/xdrgen/nfs4_1.h>, which
> > nfs4.h already includes.
> >
> > Wire the fs/nfsd "make xdrgen" target to generate the definitions header
> > <linux/sunrpc/xdrgen/nfs4_2.h> and include it from <linux/nfs4.h>, so the
> > generated FATTR4_UNCACHEABLE_FILE_DATA constant and the
> > NFS4_fattr4_uncacheable_file_data_sz size macro are available to the
> > NFSv4.2 client support that follows.
> 
> Aren't these client side changes? The xdrgen stuff is used on the
> server-side. I wouldn't expect any of these values to be available
> if nfsd is kconfig-ed off.

The NFS4.x client code needs and has access to NFS spec definitions
also, via <linux/nfs4.h>.

Its only that the server side's xdrgen framework is needed to generate
updates to the headers.  So you'll note that I have also included in
this commit the gnerated output of <linux/sunrpc/xdrgen/nfs4_2.h>.
Even if NFSD weren't Kconfig'd on, the NFS client code still has the
benefit of these NFS spec definitions via <linux/nfs4.h> (and its
inclusion of previously generated <linux/sunrpc/xdrgen/nfs4_1.h> and
now <linux/sunrpc/xdrgen/nfs4_2.h>).

Getting xdrgen to build and verify it to work took effort (Chuck uses
recent Fedora AFAIK, I happen to be using EL9.6 in this container, but
Claude code helped me cut through the missing deps pretty quickly).

So to be clear: the Linux kernel build (and NFS client build) isn't
dependent on xdrgen running at build time.

Tangential but related: maybe the xdrgen stuff should get lifted to
fs/nfs_common/ ?  Or we're fine with it living with NFS server?

Thanks,
Mike

