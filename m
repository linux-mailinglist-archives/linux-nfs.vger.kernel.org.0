Return-Path: <linux-nfs+bounces-12618-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A180AE33C0
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 04:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E387188F555
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 02:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C4218EAB;
	Mon, 23 Jun 2025 02:48:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACF3134CB
	for <linux-nfs@vger.kernel.org>; Mon, 23 Jun 2025 02:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750646890; cv=none; b=j5Avp13BT3IH+tJZ22gm34mELHHHyBYdbubVM/8z/sfrwlZ0+xHbKKkwnG//FU4ed+TevZQlLmseWaY/ygNIi9ryM3v/4qvATRr3giNPmbn6GOxV3m1nwI3T37CGWb6IQ8GTlARHxeeKcutoJcVNGyqeRVxbqbfTmsSEET8tJYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750646890; c=relaxed/simple;
	bh=LHg6FVMlDpk0k4XpDFtzWsAwX+L+SIjruHqqluDvZTk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=WCD0KDrRR3WBcsyZdqTHjFLcoD+zfL3uG/KpI3Ab5maSsq37KVI4cPYsnWmvY8dGjgvCf1X3fH1aQR63dBR8K9Hf1Ce6kQX+LpQNkj+dwigqJbYqxFuVNtPWFIOU3+meNlfhuuKUB0HIxQyMD3nDOHBTmlIGnQgkSgH8S86DzEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uTXDu-0036Du-8j;
	Mon, 23 Jun 2025 02:47:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Li Lingfeng" <lilingfeng3@huawei.com>
Subject: Re: [PATCH 0/3 RFC] improve some nfsd_mutex locking
In-reply-to: <b8f44a6a-6e35-4d59-bfbc-fac0454f7c22@oracle.com>
References: <20250620233802.1453016-1-neil@brown.name>,
 <b8f44a6a-6e35-4d59-bfbc-fac0454f7c22@oracle.com>
Date: Mon, 23 Jun 2025 12:47:52 +1000
Message-id: <175064687236.2280845.1689314838395885759@noble.neil.brown.name>

On Sun, 22 Jun 2025, Chuck Lever wrote:
> On 6/20/25 7:33 PM, NeilBrown wrote:
> > The first patch hopefully fixes a bug with locking as reported by Li
> > Lingfeng: some write_foo functions aren't locked properly.
> > 
> > The other two improve the locking code, particulary so that we don't
> > need a global mutex to change per-netns data.
> > 
> > I've revised the locking to use guard(mutex) for (almost) all places
> > that the per-netfs mutex is used.  I think this is an improvement but
> > would like to know what others think.
> > 
> > I haven't changed _get/_put to _pin/_unpin as Chuck wondered about.  I'm
> > not against that (though get/put are widely understood) but nor am I
> > particularly for it yet.  Again, opinions are welcome.
> 
> I think of get and put as operations you do on an object. Saying
> 
>   nfsd_startup_get();
> 
> seems a little strange to me. As I said before, it seems like you
> are protecting a critical section, not a particular object.

I agree it looks like a critical section.  That suggests lock/unlock
naming.
A "get" is somewhat like a read_trylock.  But a put isn't much like an
unlock.

But maybe I can side-step the whole issue.  I think it is reasonable to
move the nfsd_shutdown_generic() code in to nfsd_exit() which is called
at module_put time.  There is no real need for any this before then.
With that done the ref on the module that we already maintain correctly
will ensure no code can race with the cleanup in
nfsd_shutdown_generic().

Then we don't need nfsd_users as a counter - just a flag to say if
startup has completed yet.

This series does that.  It also delays the conversion to guard(mutex)
until a final patch so it can be reviewed separately - or rejected
separately.

Thanks,
NeilBrown

