Return-Path: <linux-nfs+bounces-14697-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A38B9C6E5
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 01:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766D0163329
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 23:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEF81D618A;
	Wed, 24 Sep 2025 23:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="LoXWH6WU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TIhFaA/T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF9935957
	for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 23:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758754968; cv=none; b=VuU1KCa0yeW6KWELQCX7wpT0ts0cila+3C4IOzfecHPkwKXfJDQntxhQTpqumlf0kgdvqjkdHLAHMUg8XOf+t+agHip6coDZfUgipO3/UtRYsNFBBurqSn/Lk+8yX1J1/AmiwGWjgvsz7bOcUHcQwopc7Jc1LCBoxuLK1U22Ci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758754968; c=relaxed/simple;
	bh=Kt34QUbQ/rMsMT9VOCfkZjgBST66EAGwjskvIy8mZEk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Z9eTc9KP7C3eLY3a5T+LFiLRpvzcSh4nHx6oPe49jRfm1BCo/LvoAYyaBPGFUJijhtxOqOefTPVzD9ueTYqKxyTlpnzMP8uF0fbHChmGZFEd1o8xQkWaG8uKGwmMAYaJKZ1zufM9AMENL12UxqgJSKPKnTlpFvKY9EXPikLojcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=LoXWH6WU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TIhFaA/T; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id ED1DFEC009E;
	Wed, 24 Sep 2025 19:02:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 24 Sep 2025 19:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758754964; x=1758841364; bh=Fs6RhB8WiRW2ZcemAHeks+XvS98YsahECW1
	PJbEUILE=; b=LoXWH6WUNZ4j+FF2swhb3oLzN8crN13VAMPWjThm8WAljEiz7TW
	DwDCQkMINZnahjFFBb0SF7/RnZ6MNBvg6Q/cm+jV8HAuUrPSD2U5G6C2i7vD/QaZ
	f3Gy2Vhk6mvBCi6FGRm63XPSk5MxkalCDnkUYIuiXDlUU20dD0mxjUSrpggNZXzb
	FGf9Pa5e7qK+u2Zmro8EiEvtJ9WbUjvjRqjh0w7Ppbzr5VESL2QktwLrhUFnp1Ts
	t67GXD55XlkD8178LaBk4enPsoZ8aheS0hFsF8YpSZ63ET56URtw1II2uUQT61j/
	sDWR60n2BLPQgcB8Pghalsw4tGyRi7nQOIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758754964; x=
	1758841364; bh=Fs6RhB8WiRW2ZcemAHeks+XvS98YsahECW1PJbEUILE=; b=T
	IhFaA/T4Bz4yyivQwnHY8+M8miMOh77rVTkyw53+90b81+SLD55tjMPQMr0ZQs3o
	WHF++fEibx2nXLFnlQz6v7AAZzaSDw0Am8CMAYsSHDpXM3OWuSURZZ6q9H5gUSZH
	ys6489nq/jdp3hLBL/gzxZESnLdqQGWRGei+P+N5h7ehTVCZPGfCPrEKSGC+5zsw
	P1vsJ2ZnwV8Vc3eNX/lxaZ53HpUbZXJ6/DyPvlj0rhLZa7tBTTVyUOESdZYLUrLC
	61ebOziuXokGZQ09xrKA2jkp9xYjAV0+finFSligtcBbnH6fxD7tN30AjbAiIq/P
	iL7mA+qCrIfysfSp/yu3Q==
X-ME-Sender: <xms:lHjUaP41hgeRnMX7gINJFqlfEDxkZXIUciAfEfcoYRN3KuECOzycDg>
    <xme:lHjUaHcRgwXxkbtwqGgCJEvmY2enzMwaDi14f1F2D5sPBl55gcLQ2VkZE6j6uygp5
    Q3stVyQQEOG26NTXGAPsepK6PHlbxPE_2l8YWDeagNDXlFRlg>
X-ME-Received: <xmr:lHjUaKEuUe1YrLgkRASIQMDGu05Cf7bUnMrPChfD2Q_d4GswVxbU_x4l_2kUs0IOeVht1qZgJGnUSzk581U9eEGhp8iD71AHCK3ABtJcdgYS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthejredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duteefhfduveehvdefueefvdffkeevkefgtdefgffgkeehjeeghfetiefhgffgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvg
    drtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehmtghgrhhofheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrg
    ihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughjfihonhhgsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lHjUaAQ2bqOGgFmKQL8EbcSGop8zsS6et1lKB6UdfmZAFuivn9YohQ>
    <xmx:lHjUaIbHpF9q0wQUeG60RVOJhL0NHtjcAOxvkk0x-WxhMQBdYLhOYQ>
    <xmx:lHjUaD0OlfmBLXyIItJ5eZN9DevLATfnXGvLkMmJp5RdckGXKfJUKQ>
    <xmx:lHjUaDrahP7YeysIh__NdfqkfY_P-2-ryRzcSqSoF56FTb8vrAxYcA>
    <xmx:lHjUaA5NDvNNZHXXlMI4uTqUgb_S1GdMOknQMSaYY6HgvjfbITeBU_Nk>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 19:02:41 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>,
 "Luis Chamberlain" <mcgrof@kernel.org>
Subject: Re: [RFC PATCH] NFSD: Add a subsystem policy document
In-reply-to: <20d9c387-c914-4e03-9410-f2f4a2d73cea@kernel.org>
References: <20250921194353.66095-1-cel@kernel.org>,
 <175851511014.1696783.3027085648108996983@noble.neil.brown.name>,
 <0fbaef6f-80ad-4885-ba2b-6a9567f01042@kernel.org>,
 <175870373332.1696783.10824173167180857471@noble.neil.brown.name>,
 <20d9c387-c914-4e03-9410-f2f4a2d73cea@kernel.org>
Date: Thu, 25 Sep 2025 09:02:34 +1000
Message-id: <175875495445.1696783.16386734137519689871@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 25 Sep 2025, Chuck Lever wrote:
> On 9/24/25 1:48 AM, NeilBrown wrote:
> > On Tue, 23 Sep 2025, Chuck Lever wrote:
> >> Hi Neil -
> >>
> >> On 9/21/25 9:25 PM, NeilBrown wrote:
> >>>> +Patch preparation
> >>>> +~~~~~~~~~~~~~~~~~
> >>>> +Like all kernel submissions, please use tagging to identify all
> >>>> +patch authors. Reviewers and testers can be added by replying to
> >>>> +the email patch submission. Email is extensively used in order to
> >>>> +publicly archive review and testing attributions, and will be
> >>>> +automatically inserted into your patches when they are applied.
> >>>> +
> >>>> +The patch description must contain information that does not appear
> >>>> +in the body of the diff. The code should be good enough to tell a
> >>>> +story -- self-documenting -- but the patch description needs to
> >>>> +provide rationale ("why does NFSD benefit from this change?") or
> >>>> +a clear problem statement ("what is this patch trying to fix?").
> >>
> >>> These paras look to be completely generic - not at all nfsd-specific.
> >>> Do they belong here?
> >>
> >> Can you clarify which paragraphs you mean, exactly? Maybe the whole
> >> section?
> > 
> > I specifically meant the previous two paragraphs.
> > 
> > The "Describe your changes" section of submitting-patches.rst seems to
> > cover the same ground.  It even says:
> > 
> >> Once the problem is established, describe what you are actually doing
> >> about it in technical detail.  It's important to describe the change
> >> in plain English for the reviewer to verify that the code is behaving
> >> as you intend it to.
> > 
> > which is close enough to the addition that I suggested.
> 
> Hi Neil,
> 
> Based on your previous remarks, I've already restructured this section.
> I'll post a refreshed version of this document and we can go from there.
> 
> 
> >> For context:
> >>
> >> IMHO these comments aren't necessarily generic because I haven't seen
> >> them in other documents, and we seem to get a lot of patches where the
> >> description is just "Make this change".
> >>
> >> The comments about tagging: I think other subsystems might not mind
> >> seeing Cc: stable in the initial submission. NFS maintainers (even on
> >> the client side) like to add those themselves.
> > 
> > If you don't want "cc: stable" then certainly include that.
> > submitting-patches.rst encourages it to be included - for "a severe
> > bug"....  but it has been a long time since stable was for "severe" bugs
> > only.
> 
> Right... I can't think of a reason to copy stable@ on a patch that is
> first headed to Linus' kernel.
> 
> We could remind folks about stable@kernel.org, which is equivalent in
> meaning to stable@vger.kernel.org but is a dead email address...?
> 
> 
> >> I'd like to encourage contributors to get the Fixes: tag right before
> >> submitting, too. It saves me a little incremental time per patch.
> > 
> > submitting-patches.rst encourages a Fixes: tag.
> 
> And still people forget. A little more encouragement can't hurt. Unless
> you believe this addition is actively harmful, I'd like to keep the
> gentle encouragement here.

There certainly is a place of code duplication at times, but it is good
to highlight it when it happens.
So maybe:

 As explained in submitted-patches.st, it is helpful to provide a Fixes:
 tag when a regression is being fixed. ......

That makes is clear that we know we are repeating information which
emphasises its importance and helps the reader to find out more on the
topic.

So I'm not against duplication as long as it is clear that it is
deliberate.

Thanks,
NeilBrown


> 
> 
> -- 
> Chuck Lever
> 


