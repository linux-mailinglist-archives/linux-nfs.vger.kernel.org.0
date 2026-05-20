Return-Path: <linux-nfs+bounces-21720-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3fwQNZIADWporwUAu9opvQ
	(envelope-from <linux-nfs+bounces-21720-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 02:30:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF9058644E
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 02:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08F4C3023076
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 00:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB80D1D435F;
	Wed, 20 May 2026 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1KszHlb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F4514A8B
	for <linux-nfs@vger.kernel.org>; Wed, 20 May 2026 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237007; cv=none; b=cICRZ0C/FWWSi+CzU1tfGXHtQKOW8YeaPUSD7xqyhVLuZX+YDuAPbdOdftBGczc/GPzyXNkHGoHE45yK9obHplaF5vXSsoE++uaZEHpkGOxN1Aci3Ps7v4v/lI1z/bGVoaSXb/PrFy5gc5/pV6NqH5OmvhOIVYBwRCRdNFCYWtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237007; c=relaxed/simple;
	bh=QfHEk4SH/oVxP2Sgw2J5T1jsfmlxADI+rwem5ZKoPao=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MeJQvYBBu+i8BC+cq0l3Vkj3euWU8FQ4SIlFVtoyG512RzuaHEKzEp5z3La3iZyqWj+EnbwffpXGqLI0HWyYSFWCwG6yhXFpgu9HkBiAiz/+4+TNWxD+3Zc1txihC4D6H39J0HYqfvGHW9x6UQ2uiMu8SdaQnRUCMv4h+28rKYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1KszHlb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D541F00893;
	Wed, 20 May 2026 00:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779237006;
	bh=kXr3aZpt0lqtneW6ycclYVc3wxNPXhKuZjSbOIURMPw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=n1KszHlbyJCvRRNucV1tJir+6lp0hsuac6dlrXZV4sSes9Zr0pp0ecGFD37wFWyoy
	 ho9dOc3m2Lswqf+h38pcmtyE0Gwm8JBSdjLSfhhSHWJVG3x3n22Ok2/H1siYKTZRRB
	 BdlZyCFCWF45AscllWRXRaiQ2d3CmkFUCbqjH6pf1tjXREqHMBX4AySPqpL2e+SVtW
	 mz/G/OTkNBjoluLHUETSJ3P7ro4iupEvkLU1A1oYywUgZ/i3tpXf+7t5aZlnr9nQDB
	 LMMEMF1uOWbvtzkdYU+WEIL7qZ+ALVHwiL1vPXvD+C+9KDJsaEguZDsihmKtwHLUWf
	 /vAvv9kWjPacA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id CF1F2F40068;
	Tue, 19 May 2026 20:30:04 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 19 May 2026 20:30:04 -0400
X-ME-Sender: <xms:jAANappNMZtEMLXP-7IJ8iPd_uy2kcZOu5pbZtYQ9YOyU9bqNUBV2Q>
    <xme:jAANamc6PVFAT1liBLAdrVkvtWD-PPg99ypf60IqBnbzvc6RH3vFueo67nh-K3aqn
    gU1wZlTOTnhx6jl5evys3wXMD2H_Up_KmcI92e8ezpdocFjT8ngmOh0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsggvnhdrtghougguihhnghhtohhnsehhrghmmhgvrhhsphgrtggvrdgtohhmpd
    hrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgv
    ihhlsgesshhushgvrdguvgdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jAANaqRirEYKT9v-7fkU5PC6bkyKxh8RRpOyhuJjLoJtKqO5uuy7Og>
    <xmx:jAANatllVfhZSllnWpDgApnQaAqap6_YHBN0ZmXwcft95NFp8V061w>
    <xmx:jAANaiSJKjUKJKedbYA8PxWNgy3eXUpwpvROGueU_TRzB3YOi69u3g>
    <xmx:jAANajMKGc5QM_WK6qy9uOJt969qv9sL6bXXtglsjSkh087e9m9jPQ>
    <xmx:jAANajU9wmi-vGhYnGDVq9PyFSi9rOYb-lotif80LM-sR-T47qHe-kAK>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A8092780075; Tue, 19 May 2026 20:30:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 May 2026 20:29:41 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <ben.coddington@hammerspace.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neilb@suse.de>,
 linux-nfs@vger.kernel.org
Message-Id: <1a5c70d8-e7f4-4671-a29a-023be7c107fc@app.fastmail.com>
In-Reply-To: <AED22AED-E97D-40E3-9839-BF8307EF8B65@hammerspace.com>
References: <D33770A1-9098-4F1A-93EF-590E6C0B7638@hammerspace.com>
 <473e337b-fabc-4884-a6c4-0f04b6874d0b@app.fastmail.com>
 <3AB7EB6A-B207-4B91-A695-66C4704D0E31@hammerspace.com>
 <4c5dbb98-0209-4572-8eac-1578536bbd78@app.fastmail.com>
 <AED22AED-E97D-40E3-9839-BF8307EF8B65@hammerspace.com>
Subject: Re: [RFC] knfsd: per-client fair scheduling to prevent single-client
 starvation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-21720-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4EF9058644E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Tue, May 19, 2026, at 6:02 PM, Benjamin Coddington wrote:
> On 19 May 2026, at 14:44, Chuck Lever wrote:
>
>> On Tue, May 19, 2026, at 5:08 PM, Benjamin Coddington wrote:
>>> Just to be clear - the issue I'm exploring isn't the same as when al=
l the
>>> kNFSD threads are slow due to their workload.  This is very much a
>>> multi-client dynamic where one client (or a group of automated client
>>> instances) are able to easily starve another simply because they cre=
ate the
>>> most connections.
>>>
>>> That's different from the other problem that we've discussed a bunch=
 at
>>> bakeathon and on the list previously.
>>>
>>> This is not so much a deadlock issue as it is an issue
>>> of per-client fairness.  I think this problem is in a different clas=
s.
>>
>> Does dynamic svc thread creation have any impact?
>
> I haven't tested it - I think it would just pin to max-threads for the
> workload in question.

If the aggregate workload consumes all the threads, then that doesn=E2=80=
=99t
sound like xprt scheduling is the bottleneck. But I should look at
numbers instead of speculating.

Are you seeing connection loss in these scenarios?


> I'm probably not understanding you here, because for the problem I'm
> interested in fair would look like prioritizing each client's request
> queue equally, no matter how many xprts each client has.

Then for NFSv4.1 and later, NFSD might schedule work on the session, and
manage each session=E2=80=99s workload by raising and lowering the numbe=
r of slots
in its slot table.


--=20
Chuck Lever

