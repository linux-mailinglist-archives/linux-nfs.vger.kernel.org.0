Return-Path: <linux-nfs+bounces-22435-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SMlPK/BtKWrqWgMAu9opvQ
	(envelope-from <linux-nfs+bounces-22435-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 16:00:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B91366A0A9
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 16:00:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fpPtx8HR;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22435-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22435-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D69132CC0D6
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 13:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73073E44F0;
	Wed, 10 Jun 2026 13:55:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576F13F44DE
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jun 2026 13:55:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099738; cv=none; b=H5PxO6rWdwqe9HUnsZoGRhYTdyxwegIYbCtvpmC8MjfE7/E9K/B2K2GWyotd7+Vmbn2J4bTnoBOFn+pRliEHc7/tJUfeOR0SptBeHhyxjKGKZYQ6Om1CXR05QC05od81st/BrvjHRAPnHahUrtRwP6/KcFALPsuoEG+j460y1/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099738; c=relaxed/simple;
	bh=sgVCmEXJ05yqMvmvKs4K15bBV1ue0Tix/Vri7Qtc2Gg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=k3C6OETjgZPy3bui5WyJbbJKX5lVasgrSMMEwuEzuxyEt8HbpMjfyx2hqpxSP5PrYONRrmU4D2G+hskHIW4Zsca6YStdBwQtM53nLsp79z23YPfvgID9RQOVsyKEzJIEQAf1ujL4gZ2LKXyxdlVbry79t81Unq8Oiz8uMZpNKmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpPtx8HR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4F61F0089B;
	Wed, 10 Jun 2026 13:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781099736;
	bh=EIptf/kZR7ZgZomdxqsw/QNW2ZGT5E521CikG/0aXYc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=fpPtx8HRIc6J8ZD7Xf6Oa3CAcSCF0fKVx4Mk3ilZB35MdVCj0W1xmW9YFmDYINwSa
	 6izgC0FGSSWssNwsreVZnO5x3gnEw0+kxDCzezfds6k3iMVCTJM4gln+YoeQbkHFfx
	 6nlcdOmYQcDXEhLFJfx4C4nC9YTvfFtOxvUd/2w2A6GnF3iA3rNkhaKH4bxkrC1/hF
	 egWfVx9GxFVebJw1RTpt1viNoJFzLvhSlMIOF1zzWL1M4BS0GDDm9vOLtgPbP3VFe2
	 DFy1u9w4jRKlKjr4vWZMXu1KHvg43Gqs9f7HgJ7dNMgOGlEu2c83//IGYa8ABbEq6U
	 IvzHQy1m1Z+eA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id CEE81F4007A;
	Wed, 10 Jun 2026 09:55:34 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 10 Jun 2026 09:55:34 -0400
X-ME-Sender: <xms:1mwpahfpM7jwyMhrNiv_621V7F4IiDdI5ZNYPLkoRodKdhmK94frSg>
    <xme:1mwpaqC8R8CP9s16rd6Pp6NFTur-ak9bmtmEbyzGld2fPtqxzO6gi4x38ZMMTPglE
    l5wxsCw8NAYVkgt4p8ORaOWNi4jRqpT6i4PO-r8QX8rZ7sZ3pv6Gg>
X-ME-Proxy-Cause: dmFkZTGIkxF1Ha5m1RRadaxFl3ZQpD0qbpPfE6qIRzD29tBEXVylIvHGFe9yCz/+Fdx5kt
    jkNvjrM3wSTkgWWqOWFEbJf0juO/IPtWe7tY71MzGbC1ONlCunxHyz3cm7UCcUiNtUU7/W
    BHZcRHyiyuHUIjjze+JTBWwZsJgvItMWWqxW/GQuWnTWQbrhjJesKIlEjBiekt3cAIA6W6
    +7B4GCyzF7pbzvm6TZPRupHSnGuuVyWtyrml0WTSlZM3Othe4S2bfbAmMnTdsXc2iwuvAW
    Mf5ICCFFHoL7fo8QNmKyrQqQ7np4xRb+TM48fXPpPWFRcozbN5CLBTM6ruEKVAkg1OgdA6
    aKv0do7+9MRDkhNzkpeUTTyMfFFWN5N9JimtU6tXUnl47Z78cupN+IK988u9xlWngvfttH
    DQ2Q9U1YAUg1qbpOdknOgNTT2v4TtvaIbnMXvkra+6FrAjmcG0+aRdJzTGNBb5gtc/CYwz
    uzShJGpm/VKSocP3Mz/bxEQgVVtP4a9nwHXpxCKVw502N/seBCPGNJtArjYLQogTK4K+Ff
    VRTm3BGZVTIFDPRdjNbKYZx3pfmD5dqUo1CpmJX9AqqdSZuqBJM1IXvZbNny7DS2lcjSAr
    kSOmLrSBW90RtPN1aNp0c171kQrR6wsrwAmoC2zgU2p1B1LuFtFrYDoh6PTg
X-ME-Proxy: <xmx:1mwpavFho5Sm20ciTNwd0kpLqWdwB3hycqU3D9kNf8NHAdHHL-0RPQ>
    <xmx:1mwpajbQFhxivQVtWdFpZDFWbhOcvTQEFq-P9rID81BTKU_m7TIguQ>
    <xmx:1mwpao1MWUSQXbITRXuQN8c8sSfHiX8HxlRQIjisNzgXskIAQtQ4vA>
    <xmx:1mwpajf61vZaAyjWkiM7og1pohCj-NhQ0YIC6ZZE9dOP7d-FoEdMKg>
    <xmx:1mwpaiABxBltPoyPuxPmEIUFUof-rWX5oNWeLL5BFYHZpDeuq7aKhYrA>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A6E88780070; Wed, 10 Jun 2026 09:55:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AK594_Pyz8Yk
Date: Wed, 10 Jun 2026 09:55:14 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>,
 "Calum Mackay" <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <6f0dab5e-dd60-4a82-b04f-4e3b168ce137@app.fastmail.com>
In-Reply-To: <dd5836b365946641824dbde5b6edc5395271617d.camel@kernel.org>
References: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
 <20260522-dir-deleg-v5-5-542cddfad576@kernel.org>
 <e0e995e9-8272-44f6-b2e0-9e61ed0eef3b@app.fastmail.com>
 <dd5836b365946641824dbde5b6edc5395271617d.camel@kernel.org>
Subject: Re: [PATCH v5 05/21] nfsd: update the fsnotify mark when setting or removing a
 dir delegation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.65 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22435-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,app.fastmail.com:mid];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B91366A0A9



On Wed, Jun 10, 2026, at 9:49 AM, Jeff Layton wrote:
> On Mon, 2026-06-08 at 12:38 -0400, Chuck Lever wrote:

>> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> > index 2a34ba457b74..efbc99f0a965 100644
>> > --- a/fs/nfsd/nfs4state.c
>> > +++ b/fs/nfsd/nfs4state.c
>> > @@ -1246,6 +1246,38 @@ static void 
>> > nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct f
>> >  	nfsd_update_cmtime_attr(f, ATTR_ATIME);
>> >  }
>> > 
>> > +static void nfsd_fsnotify_recalc_mask(struct nfsd_file *nf)
>> 
>> Since nfsd_fsnotify_recalc_mask() takes a single struct nfsd_file
>> as an argument, should this function reside in fs/nfsd/filecache.c
>> instead? The question might reflect my misunderstanding of the
>> new function's purpose.
>> 
>
> The only caller is in this file, so by keeping it here we can make it
> static. I can change that if you'd prefer it be in filecache.c.

My thought was that the new function is accessing and modifying
the internals of an nfsd_file -- it contains local knowledge about
how the filecache manages fs notifications.


>> > +{
>> > +	struct inode *inode = file_inode(nf->nf_file);
>> > +	u32 lease_mask, set = 0, clear = 0;
>> > +	struct fsnotify_mark *mark;
>> > +
>> > +	/* This is only needed when adding or removing dir delegs */
>> > +	if (!S_ISDIR(inode->i_mode) || !nf->nf_mark)
>> > +		return;
>> > +
>> > +	/* Set up notifications for any ignored delegation events */
>> > +	lease_mask = inode_lease_ignore_mask(inode);
>> > +	mark = &nf->nf_mark->nfm_mark;
>> > +
>> > +	if (lease_mask & FL_IGN_DIR_CREATE)
>> > +		set |= FS_CREATE | FS_MOVED_TO;
>> > +	else
>> > +		clear |= FS_CREATE | FS_MOVED_TO;
>> > +
>> > +	if (lease_mask & FL_IGN_DIR_DELETE)
>> > +		set |= FS_DELETE | FS_MOVED_FROM;
>> > +	else
>> > +		clear |= FS_DELETE | FS_MOVED_FROM;
>> > +
>> > +	if (lease_mask & FL_IGN_DIR_RENAME)
>> > +		set |= FS_RENAME;
>> > +	else
>> > +		clear |= FS_RENAME;
>> > +
>> > +	fsnotify_modify_mark_mask(mark, set, clear);
>> > +}
>> > +
>> >  static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
>> >  {
>> >  	struct nfs4_file *fp = dp->dl_stid.sc_file;


-- 
Chuck Lever

