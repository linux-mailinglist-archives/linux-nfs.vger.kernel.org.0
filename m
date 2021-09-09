Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D719D404852
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Sep 2021 12:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhIIKUP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Sep 2021 06:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233147AbhIIKUK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 9 Sep 2021 06:20:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28A396113E;
        Thu,  9 Sep 2021 10:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631182741;
        bh=NglITK0f+aXCjb3IekLE+xFF/VCVX54NzeAjXtqVE9g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=As/7B9o1wNXWfsXMngYBb7p6P5yKI9rpSQCffYRdALwZRctsKKeArBJw/Rk0g9oqs
         gv6luLRzLg79cZ/uG5oBUWHfbOwSCJQVL9kxxtpu3ZNt38KRc0jXiqT4kd6iWHXz94
         4Vdd5osG2E4Tl/F60uMCPQzRYo2rMOLOp2/7wp9XJNQYIDjL4QwKZ6cljShanpQPOC
         cqeFJu56H/0oBWm3dndVlZjfqXaQOwxaiam6KvG/qEtz17IyI3jAfhznXqas54B340
         8G3rCaucpcneqWyTxtlzG0qFrUfi5BgTvrxfSq2jdvcmn0PaK0jbSdAjLHZGJFQRCm
         cA44nNsRqQ4/A==
Message-ID: <b63e52660e39cc7688921f85eadf1958ced6a869.camel@kernel.org>
Subject: Re: [bug report] nfsd: Protect session creation and client confirm
 using client_lock
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 09 Sep 2021 06:19:00 -0400
In-Reply-To: <23A4CB30-F551-472F-9F2F-022C40AE1D70@oracle.com>
References: <20210907080732.GA20341@kili>
         <deba812574c9b898f99fc08f0c3fa23e85fc36ca.camel@kernel.org>
         <622EC724-ECBF-424D-A003-46A6B8E8C215@oracle.com>
         <20210908212605.GF23978@fieldses.org>
         <23A4CB30-F551-472F-9F2F-022C40AE1D70@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2021-09-08 at 21:32 +0000, Chuck Lever III wrote:
> 
> > On Sep 8, 2021, at 5:26 PM, Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Tue, Sep 07, 2021 at 03:00:23PM +0000, Chuck Lever III wrote:
> > > We have IPV6_SCOPE_ID_LEN as a maximum size of the scope ID,
> > > and it's not a big value. As long as boundary checking is made
> > > to be sufficient, then a stack residency for the device name
> > > should be safe.
> > 
> > Something like this?  (Or are you making a patch?
> 
> I thought Jeff was going to handle it? More below.
> 

No, sorry... I was just suggesting a potential fix. I'd probably rather
you guys fix it since you're better positioned to test this at the
moment.

> 
> > I'm not even sure how to test.)
> > are
> > --b.
> > 
> > diff --git a/net/sunrpc/addr.c b/net/sunrpc/addr.c
> > index 6e4dbd577a39..d435bffc6199 100644
> > --- a/net/sunrpc/addr.c
> > +++ b/net/sunrpc/addr.c
> > @@ -162,8 +162,10 @@ static int rpc_parse_scope_id(struct net *net, const char *buf,
> > 			      const size_t buflen, const char *delim,
> > 			      struct sockaddr_in6 *sin6)
> > {
> > -	char *p;
> > +	char p[IPV6_SCOPE_ID_LEN + 1];
> > 	size_t len;
> > +	u32 scope_id = 0;
> > +	struct net_device *dev;
> > 
> > 	if ((buf + buflen) == delim)
> > 		return 1;
> > @@ -175,29 +177,23 @@ static int rpc_parse_scope_id(struct net *net, const char *buf,
> > 		return 0;
> > 
> > 	len = (buf + buflen) - delim - 1;
> > -	p = kmemdup_nul(delim + 1, len, GFP_KERNEL);
> > -	if (p) {
> > -		u32 scope_id = 0;
> > -		struct net_device *dev;
> > -
> > -		dev = dev_get_by_name(net, p);
> > -		if (dev != NULL) {
> > -			scope_id = dev->ifindex;
> > -			dev_put(dev);
> > -		} else {
> > -			if (kstrtou32(p, 10, &scope_id) != 0) {
> > -				kfree(p);
> > -				return 0;
> > -			}
> > -		}
> > -
> > -		kfree(p);
> > -
> > -		sin6->sin6_scope_id = scope_id;
> > -		return 1;
> > +	if (len > IPV6_SCOPE_ID_LEN)
> > +		return 0;
> > +
> > +	memcpy(p, delim + 1, len);
> > +	p[len] = 0;
> 
> If I recall correctly, Linus prefers us to use the str*()
> functions instead of raw memcpy() in cases like this.
> 

I hadn't heard that. If you already know the length to be copied, then
strcpy and the like tend to be less efficient since they continually
have to check for null terminators as they walk the source string.

> 
> > +
> > +	dev = dev_get_by_name(net, p);
> > +	if (dev != NULL) {
> > +		scope_id = dev->ifindex;
> > +		dev_put(dev);
> > +	} else {
> > +		if (kstrtou32(p, 10, &scope_id) != 0)
> > +			return 0;
> > 	}
> > 
> > -	return 0;
> > +	sin6->sin6_scope_id = scope_id;
> > +	return 1;
> > }
> > 
> > static size_t rpc_pton6(struct net *net, const char *buf, const size_t buflen,
> 
> --
> Chuck Lever
> 
> 
> 

-- 
Jeff Layton <jlayton@kernel.org>

