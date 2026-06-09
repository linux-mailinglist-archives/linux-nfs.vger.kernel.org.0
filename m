Return-Path: <linux-nfs+bounces-22398-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /8MTNCkoKGr3/AIAu9opvQ
	(envelope-from <linux-nfs+bounces-22398-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 16:50:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3438D661565
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 16:50:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aTJSty4D;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22398-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22398-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 383EA3132048
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BED352039;
	Tue,  9 Jun 2026 14:30:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B5F33F390;
	Tue,  9 Jun 2026 14:30:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015419; cv=none; b=TZQWMilBv3ZodvBDeuxOkM3/O9MwLDQF3aWjqULL4uEoY9gWvh1UA9c/cgbg7QF8P+6TClT18LJpx4/jFloetU9Y4FjXe+HOjZ856Oq9m52O28j8ykHel7SFNPz58ePkgTrvV2/kCafZSJh5Upbobab5JzKWxCNrqrtYnv37CG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015419; c=relaxed/simple;
	bh=is2mRaWR+4YunR/LPXqVl1Ng9UrhinPbGcP3VKy5ZgY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jZx7AHnD4yUc4jBi4fUoOqRq2nAEu4lFBTJbvwsyUKJ4DMweJnfpFkA3OMM6FSGYl7aVbesHGuS+zu9E8La2D8q5Fq4hrXTVt0KAXrXwUnMlnmxyrYpPYveCUuNC5tsHZQg3FY9bYG61EcyP12dwsYtHH8lp5GipQZO/rFQE+EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTJSty4D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA171F008A0;
	Tue,  9 Jun 2026 14:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781015418;
	bh=mNllo/EAh5OGpFDve9m7daTWGpd6XC59pL4YC3FC5iw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=aTJSty4Diblx3iJfPXl9JSxScs3lyUKgJCVZzgLCaiFqkA3vhlyBrCYmGVXuhEms5
	 cyA1dxJETNcGxsoa8DXJQiv4uKqQf8o87ua1TKaKLHeyxHkXD77Ko8kWeBH7JskyR0
	 kzeEovugzp8iInPqlzwEnx84F4VRCrNcqerPtJeaQNWRgVVCDgmihcB/KDhk3tptaJ
	 A6kBnPvu+VgkMuklRacvUntgF0Mdcbf8et30Wh+jNIvLUaC3yUfjBPYoTmYBxwCDX7
	 G+x2lkUzhxpHjyeCNdoEylWcDAyhPd5tIB0jbgxAVRSwzt12KaxopsgQHvEzioHSAw
	 G/Q3H/4z1fJqg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1D36DF4006A;
	Tue,  9 Jun 2026 10:30:17 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 09 Jun 2026 10:30:17 -0400
X-ME-Sender: <xms:eCMoapKexCjkXyEZ3eOdAyNVK7HmUxvij5QfLLNufEv9AWuLQ4OiaQ>
    <xme:eCMoav-DVagjzGgldgg9bfWz6OkOAYl2zJ8oTpsg5ImJjBNBsKlotda8ZuMZ-tUyS
    jc9znDr0HiG4_kteXTEsN8IZh6LjAvOD7SyHAkeLQCKWo1rczrSMA>
X-ME-Proxy-Cause: dmFkZTEizTHeulnQTPsT2PqpHc+Eyp22TRfQg2TIYhjfXCvDwYB5d+dpktqe8zqEr5vrux
    inI0MaXzbLYOKH28GbCSYr7WNBS7ciLxN3MktKo4fd/b0/auhV9bx5/335lN43MtbhHgaw
    pcY4At/FI5BH9Q+isuapA48wsxxK8yGo3GI50GUcEsmXZ1OJSWRlC2olrybnDDHyFp/NCB
    sl9G29kfAu+FwiIfTdK1EP+bilNHvKeRJr2fVvvpZF64ZwSk4jSC2N1yq2mWiRQafdMPLV
    CPoO225ay/zgAbScNX405bdIc8NAHneoofbMWsiMbGl4+bxfS42vp4TMFVMvhR1biniuhF
    gvJfHtIE1phaCbK1q36GPBiNyAV/F4vqu6uIxtQxoD1dJq0DktPPW31G3BxxS/DDwqjrzB
    RM0eEpdb5KDlAKMkqagjqGzPeerJfvJ2R3HRgCBCp6AqoN4fzYVfxbwVYOLm3gwM9TeC27
    plWvOKPFbqflqJm5JC5PDKit7/NxQNlDe9prBsBtEp0jUDEI9+ImrN9ZRzgO9vbtzVoOlL
    CmWOk5Mxr4UToBD/NN0Yb/wJ5R+iy9F3tj4YLdCzN20W2o+KnzZ3UEAmM+2XtO7Um8cabI
    WDsPNsJ0mSyPa/ZAAAEOlRdmYZTGnWn+I1l+KodL7EdPraTepwLkDI2nFjPg
X-ME-Proxy: <xmx:eSMoajydRPr-3XfKnVMdGvDQyBe_v-zUgmtCASsY_NKiBiclA2Vivw>
    <xmx:eSMoara60p1DcjOLLYYii5Hx-wzp5cVEClGXsLDboIukoE9m05ED6A>
    <xmx:eSMoarJhF3VGKrbDDOqeyll3AEz18DOvuZp8G3Ii1fOxpQ5PV-s09g>
    <xmx:eSMoahzEx9yATQYXzLeypZFFTodr7zoXwfg9bS3LZjk0ocHzxe9bwg>
    <xmx:eSMoajNWKedofmIUTPxdyquFv_J51zANp_OViVMCBNz3-k_uqafaWKfG>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DD895780070; Tue,  9 Jun 2026 10:30:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_qtNCD-JAng
Date: Tue, 09 Jun 2026 10:29:56 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Hannes Reinecke" <hare@suse.de>,
 "Donald Hunter" <donald.hunter@gmail.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Sabrina Dubroca" <sd@queasysnail.net>, "Keith Busch" <kbusch@kernel.org>,
 "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>,
 "Sagi Grimberg" <sagi@grimberg.me>, "Chaitanya Kulkarni" <kch@nvidia.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <7b5276ff-cceb-446c-97ec-65ad80689495@app.fastmail.com>
In-Reply-To: <40199ef9-416e-4a58-908a-ed514dfd6ff2@suse.de>
References: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
 <20260605-tls-session-tags-v1-2-47bd1d94d552@oracle.com>
 <40199ef9-416e-4a58-908a-ed514dfd6ff2@suse.de>
Subject: Re: [PATCH 2/9] handshake: Add tags to "done" downcall
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22398-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,linux-foundation.org,queasysnail.net,kernel.dk,lst.de,grimberg.me,nvidia.com,brown.name,oracle.com,talpey.com];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_RECIPIENTS(0.00)[m:hare@suse.de,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:akpm@linux-foundation.org,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,app.fastmail.com:mid,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3438D661565


On Tue, Jun 9, 2026, at 2:41 AM, Hannes Reinecke wrote:
> On 6/5/26 19:34, Chuck Lever wrote:
>> We'd like tlshd to tag certificates according to admin-defined
>> characteristics. The tag list is to be returned on a successful
>> handshake. Upper Layer Protocols (such as NFS) can then authorize
>> access based on the set of tags returned to the kernel.
>> 
>> For example, suppose NFSD wants to restrict access to an export to
>> only clients that present certificates whose issuer DN contains
>> "O=Oracle". tlshd can parse incoming certificates, and add an
>> "oraclegroup" tag to handshakes where a client presents a
>> certificate with "O=Oracle" somewhere in its Issuer field. NFSD can
>> then be configured to look for that tag and permit access only when
>> it is present. NFSD needs no knowledge of x.509 certificates.
>> 
>> This patch plumbs in the netlink protocol elements for tlshd to
>> return a list of tags to the kernel when a TLS or QUIC handshake
>> succeeds. Subsequent patches add tag extraction and storage in
>> the handshake layer.

> Not sure if I agree with this; to my untrained eye the 'tag' attribute 
> is just a string, and someone else will have to parse that. But we
> are at the netlink level here, so we _can_ have nested tags.
> Wouldn't it be better to make 'tags' a nested tag (ie a list of tags)
> such that we can avoid parsing in the caller/consumer?

Had some time to digest your comment a little more...

The tag attribute is declared "multi-attr: true", so it is already a
list rather than a single delimited string. tlshd emits one
HANDSHAKE_A_DONE_TAG attribute per tag, and the kernel receives each
tag as a separate netlink attribute. There is no string to split in
the consumer; the parsing you are worried about does not happen. 

This matches remote-auth directly above it, which is likewise a
multi-attr scalar list in the same DONE message.

A nested attribute earns its keep when each list element is a
structured record with several sub-fields to group. A tag is a single
string, so nesting would add a container attribute, a second
attribute-set, and a nested policy without making anything on the
consumer side simpler. If a tag later needs to carry structured
metadata, nesting becomes the right tool, but that is not in scope for
this series.


-- 
Chuck Lever

