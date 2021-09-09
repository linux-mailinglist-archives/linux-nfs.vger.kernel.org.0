Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5497A4059CC
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Sep 2021 16:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbhIIO5o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Sep 2021 10:57:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234825AbhIIO5n (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 9 Sep 2021 10:57:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D818610E8;
        Thu,  9 Sep 2021 14:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631199394;
        bh=vFL72CmMkXVdfMX8sotd18f0qOdFM9KsWHphJnhUU1s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HI1z0OWqLRwNia/dmRYN6kcS47w46H/UtpPseC9aJ4DTlZQGEwK0NX/F4sBLXuyPk
         L2pYILi+JvMQ3Huo8uVqx9OzDD44d6q3+JA/ixbhB5U4wXhIswI82qsnAnxvaf4L/J
         uYQAUbloHJ57CKanIS3wsoHNmAhWeEdR3UnRte7ByWDDOA8/C6Xq0paI7awOgm2AQb
         VbtnEidZ3PKtOq0LbtcFnCzKoo3PHKNhQh1EFElNZETrfelpi72nWiS0ZZMKsj/P6x
         9o8MKn1gS/LEIWKkEEIEWZ+6uJxPI0+AGzgzIxczPoV8DYKr6vN4GuSjDLiFX6kcXi
         ZPPfQzhXkqSqw==
Message-ID: <c72e78075bcdc174e5786aa6678655fdae73eaaf.camel@kernel.org>
Subject: Re: [bug report] nfsd: Protect session creation and client confirm
 using client_lock
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 09 Sep 2021 10:56:33 -0400
In-Reply-To: <57B147B6-FC8F-4E70-A3E1-D449615B8355@oracle.com>
References: <20210907080732.GA20341@kili>
         <deba812574c9b898f99fc08f0c3fa23e85fc36ca.camel@kernel.org>
         <622EC724-ECBF-424D-A003-46A6B8E8C215@oracle.com>
         <20210908212605.GF23978@fieldses.org>
         <23A4CB30-F551-472F-9F2F-022C40AE1D70@oracle.com>
         <b63e52660e39cc7688921f85eadf1958ced6a869.camel@kernel.org>
         <57B147B6-FC8F-4E70-A3E1-D449615B8355@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2021-09-09 at 14:31 +0000, Chuck Lever III wrote:
> 
> > On Sep 9, 2021, at 6:19 AM, Jeff Layton <jlayton@kernel.org> wrote:
> > 
> > On Wed, 2021-09-08 at 21:32 +0000, Chuck Lever III wrote:
> > > 
> > > > On Sep 8, 2021, at 5:26 PM, Bruce Fields <bfields@fieldses.org> wrote:
> > > > 
> > > > On Tue, Sep 07, 2021 at 03:00:23PM +0000, Chuck Lever III wrote:
> > > > > We have IPV6_SCOPE_ID_LEN as a maximum size of the scope ID,
> > > > > and it's not a big value. As long as boundary checking is made
> > > > > to be sufficient, then a stack residency for the device name
> > > > > should be safe.
> > > > 
> > > > Something like this?  (Or are you making a patch?
> > > 
> > > I thought Jeff was going to handle it? More below.
> > > 
> > 
> > No, sorry... I was just suggesting a potential fix. I'd probably rather
> > you guys fix it since you're better positioned to test this at the
> > moment.
> > 
> > > 
> > > > I'm not even sure how to test.)
> > > > are
> > > > --b.
> > > > 
> > > > diff --git a/net/sunrpc/addr.c b/net/sunrpc/addr.c
> > > > index 6e4dbd577a39..d435bffc6199 100644
> > > > --- a/net/sunrpc/addr.c
> > > > +++ b/net/sunrpc/addr.c
> > > > @@ -162,8 +162,10 @@ static int rpc_parse_scope_id(struct net *net, const char *buf,
> > > > 			      const size_t buflen, const char *delim,
> > > > 			      struct sockaddr_in6 *sin6)
> > > > {
> > > > -	char *p;
> > > > +	char p[IPV6_SCOPE_ID_LEN + 1];
> > > > 	size_t len;
> > > > +	u32 scope_id = 0;
> > > > +	struct net_device *dev;
> > > > 
> > > > 	if ((buf + buflen) == delim)
> > > > 		return 1;
> > > > @@ -175,29 +177,23 @@ static int rpc_parse_scope_id(struct net *net, const char *buf,
> > > > 		return 0;
> > > > 
> > > > 	len = (buf + buflen) - delim - 1;
> > > > -	p = kmemdup_nul(delim + 1, len, GFP_KERNEL);
> > > > -	if (p) {
> > > > -		u32 scope_id = 0;
> > > > -		struct net_device *dev;
> > > > -
> > > > -		dev = dev_get_by_name(net, p);
> > > > -		if (dev != NULL) {
> > > > -			scope_id = dev->ifindex;
> > > > -			dev_put(dev);
> > > > -		} else {
> > > > -			if (kstrtou32(p, 10, &scope_id) != 0) {
> > > > -				kfree(p);
> > > > -				return 0;
> > > > -			}
> > > > -		}
> > > > -
> > > > -		kfree(p);
> > > > -
> > > > -		sin6->sin6_scope_id = scope_id;
> > > > -		return 1;
> > > > +	if (len > IPV6_SCOPE_ID_LEN)
> > > > +		return 0;
> > > > +
> > > > +	memcpy(p, delim + 1, len);
> > > > +	p[len] = 0;
> > > 
> > > If I recall correctly, Linus prefers us to use the str*()
> > > functions instead of raw memcpy() in cases like this.
> > 
> > I hadn't heard that.
> 
> I'm paraphrasing these:
> 
> https://lore.kernel.org/lkml/CAHk-=wj5Pp5J-CAPck22RSQ13k3cEOVnJHUA-WocAZqCJK1BZw@mail.gmail.com/
> 
> https://lore.kernel.org/lkml/CAHk-=wjWosrcv2=6m-=YgXRKev=5cnCg-1EhqDpbRXT5z6eQmg@mail.gmail.com/
> 
> 
> > If you already know the length to be copied, then
> > strcpy and the like tend to be less efficient since they continually
> > have to check for null terminators as they walk the source string.
> 
> I'm sure there's one str helper that comes close to what we need.
> Here efficiency doesn't really matter, and the size of the device
> string is always going to be in the single digits.
> 
> The priority is correctness.
> 
> 

Hmm, it sounds line in the second email he suggests using memcpy():

"Your "memcpy()" example implies that the source is always a fixed-size
thing. In that case, maybe that's the rigth thing to do, and you
should just create a real function for it."

Maybe I'm missing the context though.

In any case, when you're certain about the length of the source and
destination buffers, there's no real benefit to avoiding memcpy in favor
of strcpy and the like. It's just as correct.

Your call though, of course. ;)

> > > > +
> > > > +	dev = dev_get_by_name(net, p);
> > > > +	if (dev != NULL) {
> > > > +		scope_id = dev->ifindex;
> > > > +		dev_put(dev);
> > > > +	} else {
> > > > +		if (kstrtou32(p, 10, &scope_id) != 0)
> > > > +			return 0;
> > > > 	}
> > > > 
> > > > -	return 0;
> > > > +	sin6->sin6_scope_id = scope_id;
> > > > +	return 1;
> > > > }
> > > > 
> > > > static size_t rpc_pton6(struct net *net, const char *buf, const size_t buflen,
> > > 
> > > --
> > > Chuck Lever
> > > 
> > > 
> > > 
> > 
> > -- 
> > Jeff Layton <jlayton@kernel.org>
> 
> --
> Chuck Lever
> 
> 
> 

-- 
Jeff Layton <jlayton@kernel.org>

