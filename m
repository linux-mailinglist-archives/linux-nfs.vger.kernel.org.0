Return-Path: <linux-nfs+bounces-22994-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AC2BOJ+wSWrE6AAAu9opvQ
	(envelope-from <linux-nfs+bounces-22994-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 05 Jul 2026 03:17:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 352EB708C2B
	for <lists+linux-nfs@lfdr.de>; Sun, 05 Jul 2026 03:17:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UepoQlbJ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22994-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22994-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1DA5300EFB3
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jul 2026 01:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A068188CC9;
	Sun,  5 Jul 2026 01:16:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E694207A;
	Sun,  5 Jul 2026 01:16:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783214203; cv=none; b=EaZXSDRFeC1xW++xjhVouVLUE/3g4LhjdRgeeIETu3JiphcR1BtpY6nuhsePHO5Pu+qlzoCIeHP0GJEXiYHyF2hCWGStIPjJVFWb9f/5pUTM4ZuUVCFd1kmTO1M5A5qtq7DODzA9RGx0LoYB9kYsRSqS5lMaZ+2dbrKfUVD/CXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783214203; c=relaxed/simple;
	bh=otmSyEE4r4W6IWXiP/y5hUShoMAMAB0YFm14wMkqnt0=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pGQpWYYyz/jz9PpUzgSLLwLhJiz8KIsUdHhbB+NRDT5015g8DYjjaofFX16x5keFSHL41ZDqCrujlFnCUccHDiogZNC5bEPQmVXPrCFWTx7lcKB8iDNdgOJqn1cGpQvjE/ufCI4WHMOa3QXHpTgYVAIySu5w3ZODR02YOEue/qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UepoQlbJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B851F000E9;
	Sun,  5 Jul 2026 01:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783214201;
	bh=igvSi8BiREbcSC0oNNsjOWRl0EPberDPu7faJjPRXrQ=;
	h=Date:From:To:In-Reply-To:References:Subject;
	b=UepoQlbJ8QtRVlnl91Rie+XrPdIkwbHaNMsESC0rSJBxPZvpEwEqfAu1lt9t6VH8y
	 USfyVobBXzqAXQA2HLtrXwvGOoc+n3gzTjydRLzhDFvbOiDQx0vPYuEKg476bTXV8K
	 8x9niA1R9XgWtD1ZhnyJxnOeM1MnV5X99IVkogu/uNgE5gltDt1qtWQgePsm/B42ca
	 0T30ovtRsuCur6WPqzCf8xHmSVzbq6QHl+CDu4S/hQRD5/5Sq+EJEq6L0pYWvtnOj1
	 hLHu9oEVWEZnp/5sgw+Jl2K//7OAGTdS4FpdcCwFfbROK3giEl1yLbnaNdPn6EQh3g
	 X0VoNnncKntdg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6ED2CF40068;
	Sat,  4 Jul 2026 21:16:40 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 04 Jul 2026 21:16:40 -0400
X-ME-Sender: <xms:eLBJarmy0ZsUQVvfE7jhNWBJ6k_h_uWGOz2-fUoYzGYymD9Gi8A9Ig>
    <xme:eLBJapoi9sp_kPpE5yeJfz3XqjBE9hfrn5Hn9GCYN-sH9YhIiJBZj_RqniOnAFIJg
    H2HlUXLvS6fucLyAB6MQgMNPyBpR8asLM1jxyFLFLpqG6iQqNUszTU>
X-ME-Proxy-Cause: dmFkZTGGPrGEcY3Xavg7LixQR434I8qQcsHVc+5LV0XIzwtFC2//o1Lx0ZU2guU0T7W/Rf
    t3Kby0aaQCmN1hWVuNJKYVCqPvYuT0exDmeVkafQNBJ3KiHDVCQFnIf+SUnMAkKYYh7U4v
    yNhrW2CswauWkQyj9pP3nHOkOuIBISAPWFrl/5jGFEgXRkiAK7Fxbn+0apyDULg3iRmi67
    76dfT2TszxRLiIr6bTNVez4eHk/EIyGw0BuhbiAmQAM2nfcbYmcmxdj+W9sF1reUGoZcsN
    arzI7l/nek3XTrLqV1AVfpROWSV8WWcg1DOwUu37dIss1IwMT/VzqZeC3I8q0Jmw4/JII/
    7Us7RehNGf0TIjYPXTd8V27708ftFjA5vBCxI0Fzvg7JeYnNLHKObiyo5G2BtOucBxtqkS
    48UsRafqQV+jikCld2pH4gNVeDMxVPmdBT136V2HH1oD+lnw3Y2FgoUz/Vbi3aF2WBDZnY
    +poQ0DMocRzjbs+hDDvFNsjDUgPvqT3zZYs2v1OTqBm4xDlpi1cSRSa9JhE1xNgqtqZJrz
    MbOA5eMcuNRSSutupmraSbBv4+ytgG4OhPt0OiE5vd4U90nToBFmFUUO+oFv4rX1Bo32zk
    bA0VkxO7zsn+D3MQR4VEDxe+qg9ZM0RESnszWHUfufl2UOJSuIoMNGF4w+Jg
X-ME-Proxy: <xmx:eLBJaoG_sTYISWnVP9vF9ZNsztmpPCMblmWQfZweB0zQTpdReJKYtQ>
    <xmx:eLBJatVtYEUVFiGWbCJY-WeprbiFpQt5Lfs2sI2hWhTqOw6b4QmjEQ>
    <xmx:eLBJakVy26UhoHoFEjlIBKlvjxQ2-_-75RNM08xKtA6TeuPOAyONeQ>
    <xmx:eLBJarKFaScc0uYQVnwXg4E4LObxJXIvI3ZWYAOUffIk0Rf3exG4Zw>
    <xmx:eLBJasCtQbkiWWfR5aj3Iv15Rb5vxp1T-cBJl2P_So3vnkfqI-y6It1W>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4B5BD780AB8; Sat,  4 Jul 2026 21:16:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 04 Jul 2026 21:16:20 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Guangshuo Li" <lgs201920130244@gmail.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <4fe80ee0-d032-4355-abff-eb499dbe2288@app.fastmail.com>
In-Reply-To: <20260704172300.254447-1-lgs201920130244@gmail.com>
References: <20260704172300.254447-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH] nfsd: Fix dentry refcount leak in nfsd_set_fh_dentry()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,brown.name,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:lgs201920130244@gmail.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22994-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 352EB708C2B


On Sat, Jul 4, 2026, at 1:23 PM, Guangshuo Li wrote:
> nfsd_set_fh_dentry() gets a dentry reference before checking whether an
> NFSv2 or NFSv3 filehandle resolves to a V4ROOT export. Such filehandles
> are rejected, but the rejection path jumps to out before the dentry is
> stored in fhp->fh_dentry.
>
> As a result, fh_put() will not see the dentry, and the out path only
> drops the export reference. The dentry reference obtained by dget() or
> exportfs_decode_fh_raw() is therefore leaked.
>
> Add a separate error path for the V4ROOT rejection case that drops the
> dentry reference before dropping the export reference.
>
> Fixes: 8a7348a9ed70 ("nfsd: fix refcount leak in nfsd_set_fh_dentry()")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Thanks for the report. It appears that there is already a fix for this
issue queued in nfsd-next:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-next&id=ce7d3cc59012382bad5946b4cfc2cdcaabb81163


-- 
Chuck Lever

