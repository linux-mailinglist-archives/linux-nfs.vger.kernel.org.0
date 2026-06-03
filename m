Return-Path: <linux-nfs+bounces-22234-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JFupCW47IGrYywAAu9opvQ
	(envelope-from <linux-nfs+bounces-22234-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 16:34:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC80638A31
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 16:34:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BNv5tWRT;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22234-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22234-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20EDB3004D3F
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 14:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652D444E04C;
	Wed,  3 Jun 2026 14:27:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5531748124B
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 14:27:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496865; cv=none; b=PNx9bsMldIiQ4B+lTDo4BoqOYgvj7AFj+OMcexO8rI/an1QqxggklnFD6vGdaQF+kPfZ0ld5vXMTuTBJYThuwghUscDv5AQILAthdPOHdHdlSJpCw4N1f0cYt8U90CMkP1NK/q/+e99kg/OXYRC6gTfd/HgAQ4JcWtFi6+POru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496865; c=relaxed/simple;
	bh=4yf/iDMHPPuwrHwZQBzjb/RozjRScuFF+dadggoTuos=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=c6AnfwBVdp/e4ilPhotuA3bPCb7YQzVZVBzsQJGBH04uaczOxmdzsnjgIxuP1J7DOJkW/fYivZ6q+8XDbxf1j3+4bbXzMJrp07JQyvPjuzQpLNaJMVO6Sa6OEaWlDMiRp4yPmeDzpU/X3qIoPNGvngysxuXoGmS4rHGpz/DrQk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNv5tWRT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C647F1F00893;
	Wed,  3 Jun 2026 14:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780496864;
	bh=X9k0ZKde1df7umdEWko/fUWiCcJY9ed+xctbWrHAaFo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=BNv5tWRT6G16v9/nyr69m2WlCOtC97YeqGC7vjsByMD4NbtH9D9/sdYlehkqqVR+j
	 jSct4vYBm4DcaI1aC4JRsL+XIzVWQSJYNiRbFTiOESfm0gLLIDR3w8GDaScGN6sHs/
	 uVVGAhmvn/DewO8xv0XrbFjIlsnJbToA1hM2t7nU3qk719GmAosjv+ttdg4KYm7R0a
	 BbzzF1G9o7guCaGcuJkr2cONgB2TeFEO1ZiRhLyOsncjibruBaIqPwcAMJriC+SV6U
	 DNSgWqU2gR7OL0ZSctd60Mv54ks5cWeuxC3tMeWKwTf0J1VoFxFsPxMScNgBxWIZ9n
	 mCVbWZ9g+853g==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id BEF40F40078;
	Wed,  3 Jun 2026 10:27:42 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 03 Jun 2026 10:27:42 -0400
X-ME-Sender: <xms:3jkgakDK-qZ4h80Vxz-7eU5-iE6gdV01JmBpUK89M7for8FBqj-5cg>
    <xme:3jkgahVxDDnEr0DNBvlkNPRXx8k6Kq5W1s4gF99tE1w5snucZBoYGDxs6e5-w2bYo
    UfCkkz0sVMO32Q6g4LJdeDxPZ6V9eYreJbEPofD1T3oLkyNKvd_o952>
X-ME-Proxy-Cause: dmFkZTE2lsB7YPrQcTSGDnyrTSvE10E4Y/lR8bdFvpgWTUm3xnZeZ3OUISWZUFpfRcVIZS
    Ws5zdg/jHRTAE12CA3Bmg3xS1S+Rr1s7xgavj041oC51E+Ve5kkPuSIGSO/aExVeTHoy96
    Sg/prauf2YLewYXHUpkt8uoTFbfwl6dn4UvP/tO3U7kX5fkYez07Lpz78glnR4sI9WNLKO
    ARvyuldb+lg7yP2qYVeCeCvy22hTeFVqp/UW9CRthN6I0Cq4/N+4OA3tAMI0eQC/UbWKij
    EOQ3zqaevaiYOqheJfqlu5Cpw1bChBPlxWGPXVF3KdWN4THuzaz4YdiC5joOgXcLthB3Rh
    iZcC+Tc7a46UocMF/TENtt3tWhZj8LYqFRYeojIFHEo1ZpACjftNHJDsHRS7jpazJ1DLo9
    rIGEVmvYdyS/vQyh/3Mvbd4fpncdf9dZ+4sppca8mCIj8v5rCRyqKNOHPb0J7aJrACnVzW
    LncpFJpLpkHod5bloWS9J1/JwL0Op+nnJ2yz+Twtu0yVKrs9CkTzmR2n/C6Y63PO0WsNpu
    S6l5FIG/f2jEz2zKHSmDPiN5d99+oX0sBCasYr9hCFPZJXE/p8GWBe7DVC5Py0ibWbKITg
    NwLWB8F/UcIijeLN2E5EJzXyDydBPXnKGdjbBQ8UruzoRhvCfbrNh0LlDeBg
X-ME-Proxy: <xmx:3jkgaknjotcVbrh0-YNqI39lZqkeqZAHZkCe90paaujyZrTuVBQMuQ>
    <xmx:3jkgalaZiDAV3Y7buUh8Oa1IhHnJJhG-J2UZ_46anwF9j4b4GP9WnQ>
    <xmx:3jkgah4kv5mldtIbdJdG4zI427u43W8pnp0jFGJgetl4gSXGVJBYvQ>
    <xmx:3jkganAmfKt6EClsm6nsV97ghSnQNeiJ7u_I6ZLmBaEX9E_xKR0UEQ>
    <xmx:3jkgan8LPufZ-dQ3vB1F_dnhpjIM1cJmWywu9PJgG_9pku7ggXmPeIg->
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9BE0E780070; Wed,  3 Jun 2026 10:27:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAPZyXKTxCYB
Date: Wed, 03 Jun 2026 07:27:22 -0700
From: "Chuck Lever" <cel@kernel.org>
To: "Hannes Reinecke" <hare@suse.de>, linux-nfs@vger.kernel.org
Cc: keyrings@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Christoph Hellwig" <hch@lst.de>,
 "David Howells" <dhowells@redhat.com>, "Jarkko Sakkinen" <jarkko@kernel.org>,
 "Sagi Grimberg" <sagi@grimberg.me>
Message-Id: <b38b0983-7a63-4e77-a549-2d8859752cb9@app.fastmail.com>
In-Reply-To: <bb9a872a-d4aa-467a-b4c9-7bca174a6bbc@suse.de>
References: <20260602154740.49861-1-cel@kernel.org>
 <bb9a872a-d4aa-467a-b4c9-7bca174a6bbc@suse.de>
Subject: Re: [RFC] NFS: named client identities for mTLS mounts and a per-namespace
 .nfs keyring
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-22234-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hare@suse.de,m:linux-nfs@vger.kernel.org,m:keyrings@vger.kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:dhowells@redhat.com,m:jarkko@kernel.org,m:sagi@grimberg.me,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BC80638A31


On Tue, Jun 2, 2026, at 6:39 PM, Hannes Reinecke wrote:
> I am all for making keyrings namespace-aware. Logically I _think_ they
> should be tagged per user-namespace, as this really is about the 
> filesystem (and as such would warrant to be tagged per mount ns).
> Tagging it per net-namespace is not a great fit (well, for me, at 
> least), as also block devices might require keys to present the
> bdev (eg nvme authentication)

My understanding of the proposal is that there is one keyring on the
system for .nfs and the keys in it are visible only in the namespace
where they were created.

Therefore the consumer (say, NFS, or NFSD) is running in a particular
network namespace. It will create keys on the one .nfs keyring, but
only the tlshd in that same network namespace will have access to
those keys.


> I might be okay to have it tagged per net-namespace, though, as all
> current users are in some shape or form being network related.
> But I'm not sure if that stays that way, so I am worried if we're
> not restricting ourselves to much by that choice.
> As really, the question is: what is the driving the namespace selection?
> Is it the _requesting_ layer, ie the layer issuing the mount() call?
> Or is it the _providing_ layer, ie the layer providing the 
> devices/interfaces where the mount() call is operating on?
> If it's the former, then we need to tag is as
> net-namespace. If it's the latter, then we need to tag it as a
> user-namespace / mount-ns.

tlshd is a network layer service, so it doesn't make sense to bind
it to a user or mount namespace, IMHO.


-- 
Chuck Lever

