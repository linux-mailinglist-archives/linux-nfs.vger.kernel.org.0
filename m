Return-Path: <linux-nfs+bounces-20848-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KnRHqSj32miXAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20848-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Apr 2026 16:41:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A16F4056D7
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Apr 2026 16:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43CB83009FB9
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Apr 2026 14:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CAE35B658;
	Wed, 15 Apr 2026 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGRxvm/X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7DA358367;
	Wed, 15 Apr 2026 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776263693; cv=none; b=kJZD2uY8q+ZZBXAQeoat3rK7iEy0cXCU/GAiZWV6foYb7003P+dUMEsC3j/2hs05lRfPrwA+AAkbTalQ5279foE/iRIfIWHbrJrrRRAET4x9V6NDmAleJE9TPlkWXmXUmqjVyWO7FvoSUUmLPuphYWktzvSfkjeDoz7kXn3mgwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776263693; c=relaxed/simple;
	bh=8B3JEnHtc26ea94Qf12pLpgUQm3OGM/HkIcKv8RtGRQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WG6MK1waFaVathWyPHIwXPQVKksiDwDcQuDsLARPfv9D5L/vc5tHJI0hCQTMUt3f6K0ulBEjO/UQWZmt//ZP/ISSXAkxZTfAa+g0evojWa8gT4IS7qiowjg+gGgyOAezMg/nWtXMFDPK+/RZE0dE3/ChlCbadCXxpCTBolHb9Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGRxvm/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF1EC4AF0B;
	Wed, 15 Apr 2026 14:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776263693;
	bh=8B3JEnHtc26ea94Qf12pLpgUQm3OGM/HkIcKv8RtGRQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=pGRxvm/XD/Fq5IK9vY3jJaw08hZd7eyEB+b5JYDHsJ4W+0cSa24g0pTts4RUDDPvM
	 4JxIblqK06IOoUrUiJS1uKhK499v7ZAuBsfIpQshaYifb5iSb2NgKoTFU3T5StYVX+
	 QCzvV+mIvs6DVSrvQUa1UJ53+zt3HHuJv8FiSz1g58QQnFpEbkc6Axs/4Igmvz5+OC
	 qvycua9zJo8E0IP8aizVtxbIKwuYosdaHoxqzYIlh6xkmBqU4JX4P4O4jkHH66qcT/
	 Smhzyl3el3oPtBH8M5fj+cCz5yn223vZnDRmm1oOJ5cx0tOkf8+OWvqrgn22vUYVos
	 R7l/SEaLWBU7w==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 97337F4006F;
	Wed, 15 Apr 2026 10:34:51 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 15 Apr 2026 10:34:51 -0400
X-ME-Sender: <xms:C6LfaYd7VLfQ3ekkky0J9aTErhecBsipsXemgMNMSstmGe5XmPrqfQ>
    <xme:C6LfaVC29sOVFFe6Hx9cqUJExJHUW09Ed44bLEjvvGkf0H_Q_Na45EUnoc7Qx3Dgs
    400skqYN6HNxprarAS6k6uKwhLBlhoRerAexw2O7V8HDhl4tusRfuUH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopegrmhhirhejfehilh
    esghhmrghilhdrtghomhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    htohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthht
    ohephhgthheslhhsthdruggvpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrd
    gtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhr
    tghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:C6LfaTPej6W1qEA32psXtWIAu6dTfmkFfZwiffXo1foywhCDe8V4Fg>
    <xmx:C6LfaYZ7gJoaYOoAMMsDJE-sh1r1tYJzajYNfy8rP2RVL-qymA4-7w>
    <xmx:C6LfaZx6oZ0qBSuXcJqy93FHQW1p0L2XApjN3ZNobyuUmx6kcoqgaQ>
    <xmx:C6LfafN9qf5sZOQJkjuvNYfbx3O78hSB5lwbwTpxEavsJ3TC-ejrmA>
    <xmx:C6LfaQeSxPB7EcCzsSQZhh0BPhJu2vsyj1qNXq3H7Xn8F7h_5ZltEv7o>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6314A780070; Wed, 15 Apr 2026 10:34:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwBntrSeBB7R
Date: Wed, 15 Apr 2026 07:34:31 -0700
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>, "Christian Brauner" <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Message-Id: <217438cb-63ff-41d2-8f3c-fbdb1945a670@app.fastmail.com>
In-Reply-To: <20260415052925.GC26559@lst.de>
References: <20260401144059.160746-1-hch@lst.de>
 <8bef4d4e-1c0d-451d-8854-ed0cba27ee1f@app.fastmail.com>
 <20260409-schwalben-neutralisieren-fb5a184e5049@brauner>
 <20260410111007.GA10292@lst.de>
 <20260414-ausbrechen-gemixt-ff09f46bdad2@brauner>
 <20260415052925.GC26559@lst.de>
Subject: Re: cleanup block-style layouts exports v2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-20848-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[brown.name,redhat.com,oracle.com,talpey.com,vger.kernel.org,kernel.org,gmail.com,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5A16F4056D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, Apr 14, 2026, at 10:29 PM, Christoph Hellwig wrote:
> On Tue, Apr 14, 2026 at 12:01:39PM +0200, Christian Brauner wrote:
>> On Fri, Apr 10, 2026 at 01:10:07PM +0200, Christoph Hellwig wrote:
>> > On Thu, Apr 09, 2026 at 03:26:09PM +0200, Christian Brauner wrote:
>> > > > Christian, are you OK if I take this series through the NFSD tree?
>> > > 
>> > > Hm, I generally prefer infrastructure to go through the VFS tree.
>> > > You can get a stable branch ofc.
>> > 
>> > Communicating this earlier would be helpful.  If we switch to a new
>> > tree base we're going to miss this merge window.
>> 
>> The series was sent on April 1 so with about 2 weeks before the merge
>> window... If your series isn't ready by -rc5 what is it doing being
>> merged for the coming merge window is the other side of the question. So
>> afaict, there's no hurry.
>
> That's a very weird generic standard.  I know a lot of subsystem don't
> take complex core changes until a bit before the cutoff, but killing
> 3 weeks of the merge window for everything is odd.
>
> Even more I'm not even why we're having that discussion - exportfs
> has it's own maintainers, one of whom ACKed this including the whole
> tree discussion.

In this case, pNFS is the only consumer that will notice or use the
new "infrastructure" and us NFS experts are the only ones who can test
and review it properly. And, the likelihood of conflicts with patches
in nfsd-testing is high (in fact we've already had at least one). It
makes sense to me to take this series through NFSD.


-- 
Chuck Lever

