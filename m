Return-Path: <linux-nfs+bounces-22232-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vPWPHhIyIGrHyQAAu9opvQ
	(envelope-from <linux-nfs+bounces-22232-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 15:54:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D596663847F
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 15:54:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lmmDKal3;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22232-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22232-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 363F632981C8
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 13:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3023264CA;
	Wed,  3 Jun 2026 13:42:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CD9319617;
	Wed,  3 Jun 2026 13:42:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494172; cv=none; b=ubSe//griQwprc9xvb5Tmail7bsLRFIeElir/vn+OwYAfhcHqy05psG2BIcwzL+cG76izJ40PudKPUJuvyRu4EpCHn4w3jURpulc8y1xkDlnULQYo+JsUmWAnKCyDTsT4b9XxurW0ZumhCQg6PY+8UpZNXJnhgqJsIl/iEfQtIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494172; c=relaxed/simple;
	bh=iFe1WYbCxcFuXahK7sPo09FPJtlLBCULH5KmxcAQnCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3SUUt+eJZKxarey5GXunPioMqHB/10VVNjDM7X9z8q4eLPa8pzn9Sg3RX13YIfSQJEGEvk3Ma4X0gr/rluQIvHHktZC/qx6kQ6Mew+HX9m+KkvpTgpV6wff7qOQa/tfNLXRthezVCYWz+R/918JSEslqFGjZq1ubyZlCeF0ejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmmDKal3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8CD1F00898;
	Wed,  3 Jun 2026 13:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780494171;
	bh=c1s3wYbkURqhM7qkvJRBzhJenXV+nbjO4FcCfUvzTI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lmmDKal3j5juWoavef85dcQUeUs+HB448UiSj9bp43A2WeRYvNXS4A8q1QaMXMnD8
	 03NYxRzIKwaZ8yKdBSCAsmwGbPdHk8J1XUYivek+WREcdTrAoSvxoTCT8oVg7sNjsU
	 UxVWsTyvgB5I+zXGy7OUb8NabqNFk7oVBO0Obx9Vn21a0cSxSYWGyOFJxZffclTRPo
	 VZHQaMX1+XFowxETj7fNtwkOg8kFtVQIqYajjaP1LqBwyqsO+uuSDiK+Gb3m6oZdDX
	 +AHyZt1ebA7L+8PpMLdE6Wah/uvaNsH0rsTik1wm17uNxWmDRUrdh/t1JgHZpZ4nMx
	 DfZDg3QzWzkUg==
Date: Wed, 3 Jun 2026 09:42:49 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jens Axboe <axboe@kernel.dk>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v7 3/3] mm: kick writeback flusher for IOCB_DONTCACHE
 with targeted dirty tracking
Message-ID: <aiAvWRr_3Y07Ba0V@kernel.org>
References: <20260511-dontcache-v7-0-2848ddce8090@kernel.org>
 <20260511-dontcache-v7-3-2848ddce8090@kernel.org>
 <20260511-zusieht-amputation-efe8b5058cb7@brauner>
 <7c0880ee25b13f64f71319203fcd7105f54e5ad0.camel@kernel.org>
 <20260511-caravan-behaupten-0402c454c22d@brauner>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-caravan-behaupten-0402c454c22d@brauner>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22232-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:jlayton@kernel.org,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:willy@infradead.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:Liam.Howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:axboe@kernel.dk,m:ritesh.list@gmail.com,m:chuck.lever@oracle.com,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:linux-mm@kvack.org,m:riteshlist@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,infradead.org,linux-foundation.org,oracle.com,google.com,suse.com,kernel.dk,gmail.com,vger.kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D596663847F

On Mon, May 11, 2026 at 04:06:42PM +0200, Christian Brauner wrote:
> On Mon, May 11, 2026 at 09:53:21AM -0400, Jeff Layton wrote:
> > 
> > That does look much cleaner. Do you want to just make that change or
> > would you rather I resend?
> 
> I'll just fold it. I already have 1157 mails. I don't need more. :D
> 

Hey Christian,

Did you happen to pick this series up from Jeff?  Not seeing it in any
of your vfs-7.2 topic branches.

I could easily just not be looking in the correct place.

Thanks,
Mike

