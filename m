Return-Path: <linux-nfs+bounces-22761-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zDYrC4g2OWqWogcAu9opvQ
	(envelope-from <linux-nfs+bounces-22761-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 15:20:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C1A6AFC4B
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 15:20:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YYRb+nxD;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22761-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22761-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61EAC3032F6C
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 13:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44FE363C6B;
	Mon, 22 Jun 2026 13:14:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7FB3AFCE1
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jun 2026 13:14:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782134077; cv=none; b=UPvIQqB/7ogrlphjneZK6XesiY6VeyfsGEF+DujaVLu1LlkoxZvn6l49u+6DgOeY7xjPBn1gctoLLN8g3XFKfOQDeS7N0P2VqmlrjyZbgzOYCU1e1gXjz6xIawkp2hp0n2KR47oavHs9If6JugzV/wJdSp/ZkudRPsQIiko9eGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782134077; c=relaxed/simple;
	bh=PTizy4elym3vQ0ZYmpnbM3q07Iklucf5tCjJSL2qzN8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oHwup/vEWneiY+7sRNIdKDxtNDlpBKlokfh4RjbP4HE0rNFag2m1XqMXQM9kdLpxrLdjZn7B5y1Z+NeXQt35OtbfLjqKerOuERxRWKipq9Ejpq72zLyNmNk2w1fOFOOAQ2Hicv6wSkuCeCC8rsxrhVPReecGVSBjba25UWsXhhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYRb+nxD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5FD1F00A3D;
	Mon, 22 Jun 2026 13:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782134076;
	bh=/+w0EC+WGCdmlx5tVdSQ25EjnwuBJ1/p6B9yt9FIcWk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=YYRb+nxDIF9yuKU9zq9U4tcOcLDPu6qfzb/L1t/zr6BqmL9gHTE7H/IcuCpit/FqG
	 oDGtzy0p/kkHd/xwNTRgau8gfh2vIC7dkuqwE8+K3kK6oj8NmewVuqHNgeKhTeXyLQ
	 WlEc9Ff8AOuWCfp2lCLg2puBejNmkIh7XzXN0QeChbmn0O7VBJForp+6Q+k8L0SD7O
	 9W69zzLe+zrd3cn2ocW5FqeTHaXIqDmMXzJ5pbyqo35I9H4v4YmNyB7xQwqzBpq4Oc
	 S2pe+E4TOENBCWPLE901J8eAsvioqx26rCtwrO7TuOD0Z4q5gNhaS8J56pzbwFGmJh
	 IJ3UFoP85xrzA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id CF208F40068;
	Mon, 22 Jun 2026 09:14:34 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 22 Jun 2026 09:14:34 -0400
X-ME-Sender: <xms:OjU5ajSNbn-wEG_CD3qgIlilM62lay3aS3Ma2MulIIjNH0PiSEpqDw>
    <xme:OjU5avmqbbTz4IcUz7D5wlA3gOoo08NZ2rMgp6S_NK04CA5ToJts-Y64M9z2wVar9
    EeLbyub6kbUoN2G2n3eHFRg1EeoLmUNCIo1kZSwTPeJAOcWKXtz5to>
X-ME-Proxy-Cause: dmFkZTFAwpOMVDiI5XxQ6QnkRi5ToSudf2FwpDJVl8srkRqIlq9DFrqGZqoS90nU4VhJIs
    gtWTIDw/aDmGExRvSIYC8RsmtZL8fae1mJtvj/rzT6uQOAK5pFFIzcFu7dDUFRnsD1qYaK
    RkxRfV/wEZyMZPg/D9gWzQOrQIFkSzI1z7T7cLlYQdWcysn6YyZhqL4Db9blWtjZ6lz84x
    3V/aHmkxcPGf5GJAvi3NFrMOJdGxJbn71GR8w9HrTE1iarBtl7keqDOhSCPnLVHJYH6LU3
    hkaZBKitE6qB/HADN57YbhIJ0nKzGy65JysnB4x88aPYXWyjwjSqAVa4vQVHrqgyTMFHTS
    6wu476h+J42pbhvh0lftwX5HrnkT9IAr0fGpRo66LzGvpDcxY9xjNasqFRL1DL2/RaF/S2
    t6+nlYOhpFpDjcXnwg+yw9yuj2rKnl2wNv7uZA53bV8y/JZwzZbypJSr7uSwXq62flSgpe
    ajb+fCc/VSj9kgLVlqKicVrIXDmikcb8RSdL0UoymXAhrm8srCRuC/Qpuefz++g/zqlVaM
    32d5nSWdW9jlP/ZJouT2OQL6TT468LdiDaBwGrkSO+wacfQOqJ8MUDMesVK4JHY09ahQFz
    D9p5wKLKH57QsbgGd7sNx4lr9XYpk1fxSKM2Gfxm688LyXrEqM01+YWou0gQ
X-ME-Proxy: <xmx:OjU5aqIWsXitcfkunPlsGNrOtpW8Qn2-Qh9F-EEopFRZn5oGwdC9DA>
    <xmx:OjU5ai2dw2WaBeWbR8NA97k68d4Cxh14IV6RR3anTRGrRLPm7jHQaw>
    <xmx:OjU5ao4usUYd-1Od9L0HGGeKgavrDQg5UHHnKiDDKrYUDLudR3-4sA>
    <xmx:OjU5aj_Gear8FL1sEgJzFVdzdlrGDaYlIVocbkUsrzQ1OVxJqK3ppQ>
    <xmx:OjU5anVe5NV7cJUqXw4CCvmQc8VUXT_Tk093ozdbhvUMAKRbC7rIOkOb>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A7823780AB8; Mon, 22 Jun 2026 09:14:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ar2pZyaUUoUc
Date: Mon, 22 Jun 2026 09:14:14 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neilb@ownmail.net>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, "XIAO WU" <xiaowu.417@qq.com>
Message-Id: <2b3f6886-86ca-4da3-b1df-a2bec0f93e5f@app.fastmail.com>
In-Reply-To: <8369948d3e01471c64d37182ddc6a2f1cdb0c473.camel@kernel.org>
References: <20260621162551.2469460-1-cel@kernel.org>
 <8369948d3e01471c64d37182ddc6a2f1cdb0c473.camel@kernel.org>
Subject: Re: [PATCH] NFSD: Guard admin state-revocation walks with NFSD_NET_UP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22761-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,qq.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neilb@ownmail.net,m:okorniev@redhat.com,m:dai.ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:xiaowu.417@qq.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75C1A6AFC4B


On Mon, 2026-06-22 at 07:57 -0400, Jeff Layton wrote:
> Can nn->nfsd_serv be non-NULL while the NFSv4 state tables are still
> NULL?
> ...
> Would checking nn->nfsd_net_up instead of nn->nfsd_serv be more
> accurate here, since nfsd_net_up is set at the tail of
> nfsd_startup_net() exactly when the state tables become valid?

Yep, that's exactly the gap. The hunk you've quoted is 1/3 of the
earlier "post-shutdown use-after-free" series, which only guarded the
shutdown side of the window. nn->nfsd_serv is also set at service
creation, before nfsd_startup_net() allocates conf_id_hashtbl, so the
startup side was still exposed.

The thread you're replying to is the follow-on that closes it: it
switches all three unlock paths (write_unlock_fs,
nfsd_nl_unlock_filesystem_doit, nfsd_nl_unlock_export_doit) from
nn->nfsd_serv to test_bit(NFSD_NET_UP, &nn->flags) and rewrites the
walkers' Context: notes to match. NFSD_NET_UP is set at the tail of
nfsd_startup_net() and cleared in nfsd_shutdown_net() after the tables
are freed, so it brackets precisely the window you describe.

I assume your comment was meant for 1/3 of that series rather than
this thread... but we've reached the same conclusion, so no action
needed beyond this patch, correct?

-- 
Chuck Lever

