Return-Path: <linux-nfs+bounces-22748-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IE4FGZ4GOGq/XAcAu9opvQ
	(envelope-from <linux-nfs+bounces-22748-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 17:43:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B8E6AB325
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 17:43:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HcWzK5LD;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22748-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22748-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68E95300C023
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71BA1A9F97;
	Sun, 21 Jun 2026 15:43:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE71A1D63F3
	for <linux-nfs@vger.kernel.org>; Sun, 21 Jun 2026 15:43:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782056603; cv=none; b=tIYVQylhxllB/hmjSzBNvYIXlLowiAIIEVS+MQQjs3kRSfY0fC/uTAyipYg3N3ylVk2yLdzVuBFKS8UXOhU9yMNjJ0v5CUZOMF2r/7wL6rTGEvlmjPvL2rfNyalVlEL+yA/U9A5uDGoXeSmlMue8mcKht+4wcZA8eQUviEtSepc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782056603; c=relaxed/simple;
	bh=LniOFOCQU7MZxA+zt2G1g2mTvUJWkCLBl+F4TVPCIrY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=e94N4p/6YTIdDmRVc0SkJ+DP+WjRorLAMJ4p+jVpKm3WkF7CVZIhCyDjmnHyp/jzx/CwfwVrLioYkZVOPCMuWHhz4q0k2qg31lVycH4IjBdKFcRwrOwanTBT+X5Z36Lgo4zfv9/7YEFNQnpA8AnD2MakhTLh0JJIllrWKeMWVQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcWzK5LD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7D21F000E9;
	Sun, 21 Jun 2026 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782056602;
	bh=mrBSbNPJhGN/H6DH2mXAxGAowqnk8usPYS+UA33KJPQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=HcWzK5LDP1pyPuh989EecpnHYV4bNoFdhnjbLmlQemZKq5lLrZAkSEHK/Oz/NJBnK
	 zNgBv0vcXENUegyDEb+XUvqQPNiRVCsEaUU5pkHmPABQfIIJ+RxLc0hckqhlpVcIHM
	 Meb4QdlEGoUFokhIRfGA5Ibdmx9I0bD+ICQVIAb6ZtR8rSmOPDYoAGtjcOOtakilsK
	 xdoNEcWfwedihW86lt7YqSqZsstPaukGPeSD1EgJd38smQZQM+Z4Ii/LBZa3xBtTQk
	 7lV/OerTLXoc8r71F2DWHmlPAXayIxs87blOzvK+DvUdfw29TVudI3flpVVFA7miSe
	 jsJNRBcd5RXBg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 33981F40068;
	Sun, 21 Jun 2026 11:43:21 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sun, 21 Jun 2026 11:43:21 -0400
X-ME-Sender: <xms:mQY4av1nu-vuDnRsMOUoWuipD5wiH742e9RyhuLVc8COA3KeshHYqQ>
    <xme:mQY4ao5oA90Uy9QtynCxX3hK4k3XZ2UgkiG4b-QYRo5i0_CPyqNMYGjo9N0-97y2U
    o1BP4rfIIyxbL1kCs3hv6XSTlLxBgEWOMlhjfoL0vWHC4QOVXxmhoX8>
X-ME-Proxy-Cause: dmFkZTE8Pb8A96WcG51jElAWu1eUNYQ0/GYAN2f6sZngrpFKAvWvv15SMy0JihZFAtL0+0
    e4/PbsxL1qydEchMR3H8V1RsIX3uHfn0WRlWqVQQSPHb2Vh6mPdrbI7mAep1xW8FoOkKmw
    Jb/uZ6yoTyV3T1Rq3UNkt0gjcVx7+LooBBPwt1vvWXKH2lHSO8GoM65QbyIbqctuCQOpy0
    v3KBy0/706RWXTMLfJ2ruALsjQvBx9g567b7La1t0QcpJAkUCjIUt9S3AAwDI2VYqt0M53
    ce7U4f8gccL+Zk+8xQCzRQAu+BDyYVgcnxZYSpfYAKcHkxtkrByU4aJZcCldm9w3nXArJA
    jOG496Y63i6GFu8mxEh5nhA4Z+xCgvtjr1IU9rAGIcj0A9DKAyy0ZbXYOb1LbBrd+Tbsv+
    hutVuk6CdCAOOEGQBwpzUYqbBnJkpAULUCBKQtD+HxbM8NCxYZh5SPephrkspY0EyE9Ud0
    J89VMvrny0ETDe79VN9SuAH5oxrwgEvAbzKXW2xIq7S1CyC+7gGGVIoYkayDRTHVUNSv2G
    VpaQw4r96GGmdZJnKRSx7I80kaBlaDQOKsdH+NGndQ/KcVkbHgZznq/g/BVRYFLjZBZD3b
    HKXH/USEMNmvkvlatKaVbNcvFLYFCKpxTjQtegw1tPa1XG0/H4S291Gx3LxQ
X-ME-Proxy: <xmx:mQY4arIUqwz7EgTS-9P6AEsBgQshhKl-dv9dh67LbLzzIXlofaJ3qw>
    <xmx:mQY4apLZcP7De6ikCbpEf2BQeQgjStvAWAiSCjBUhDVCC78CoHvpfg>
    <xmx:mQY4aqVdXBAoYDPpxzgRRaeMDBqwcPE8_TvsN2VtumCkm8fjrlSS8g>
    <xmx:mQY4aikbSj7riz55DVQ3k3DBP4OUMrV6wp3or-9W_AHOOKVyZgRpMQ>
    <xmx:mQY4agm3gzS_VVKundUovVQi6cboqOHVNxOrK2J5q49E08nNmw6GofHM>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0D084780AB5; Sun, 21 Jun 2026 11:43:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADCxxJSGcr2Z
Date: Sun, 21 Jun 2026 11:43:00 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "XIAO WU" <xiaowu.417@qq.com>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Cc: "Musaab Khan" <musaab.khan@protonmail.com>, linux-nfs@vger.kernel.org
Message-Id: <fa4991b0-910e-4ef5-81b1-7a6c236acdd4@app.fastmail.com>
In-Reply-To: <tencent_7C446FB89D462E14FD321DDEB9E47B640A07@qq.com>
References: <20260613-unlock-filesystem-uaf-v1-0-462b9bec8c84@kernel.org>
 <20260613-unlock-filesystem-uaf-v1-1-462b9bec8c84@kernel.org>
 <tencent_7C446FB89D462E14FD321DDEB9E47B640A07@qq.com>
Subject: Re: [PATCH 1/3] NFSD: Prevent post-shutdown use-after-free in
 unlock_filesystem
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
	TAGGED_FROM(0.00)[bounces-22748-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[qq.com,kernel.org,brown.name,redhat.com,oracle.com,talpey.com];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:xiaowu.417@qq.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:musaab.khan@protonmail.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[protonmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7B8E6AB325


On Sun, Jun 21, 2026 at 07:07:47PM +0800, XIAO WU wrote:
> I was able to trigger it in QEMU with KASAN: creating an NFSD listener
> via portlist sets `nn->nfsd_serv`, but without starting any threads,
> `nfsd_startup_net()` never runs.  Writing to unlock_filesystem then
> calls `nfsd4_cancel_copy_by_sb()` which dereferences the uninitialized
> `nfs4_client` hashtable -> NULL pointer dereference. 
  
Thanks for the careful analysis and the reproducer. I agree the crash
is real. nfsd_create_serv() sets nn->nfsd_serv from the portlist and
netlink listener paths, none of which run nfsd_startup_net(), so
nn->nfsd_serv can indeed be non-NULL while the NFSv4 state tables are
still NULL.
  
One correction: the array the walk dereferences is nn->conf_id_hashtbl,
not nn->nfs4_client_hashtbl. Both are allocated together in
nfs4_state_create_net(), reached only via nfsd_startup_net(), so your
mechanism holds either way; the name in the report is just off.
  
However, this crasher is a different bug from the one this series
addresses, and AFAICT it is not introduced by this patch. Before this
change the cancel ran unconditionally, so the same NULL conf_id_hashtbl
walk was reachable in the startup window (and more besides). The
nn->nfsd_serv guard added here narrows the post-shutdown case but does
not cover the startup window, because nn->nfsd_serv is set before the
tables exist. The two also differ at KASAN: this patch fixes a
slab-use-after-free on a freed-but-not-cleared conf_id_hashtbl; what
you hit is a null-ptr-deref on a never-allocated one.

The correct guard for the startup window is NFSD_NET_UP, which is set
at the tail of nfsd_startup_net() exactly when the state tables become 
valid, rather than nn->nfsd_serv. nfsd4_revoke_states() walks the same
tables and nfsd_nl_unlock_filesystem_doit() repeats the pattern, so a
fix needs to cover both unlock paths. I'll address that in a separate
follow-up and add your Reported-by.

-- 
Chuck Lever

