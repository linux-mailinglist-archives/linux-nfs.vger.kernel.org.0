Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980E829C03A
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Oct 2020 18:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1817070AbgJ0RMr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Oct 2020 13:12:47 -0400
Received: from fieldses.org ([173.255.197.46]:45358 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1817068AbgJ0RMl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 27 Oct 2020 13:12:41 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 55FD535BD; Tue, 27 Oct 2020 13:12:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 55FD535BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1603818760;
        bh=YY/CRMQVRAZTZEHH+SsAxDZD0KcbZ4AGJuhnrkTPCPA=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=bjccu2qXIA59tBqIe7woktxz0EpRXfXwHam5WCDA1uhx6cXy19crCngDc3oYWtiK6
         p7kMrQClXLQXIGJCcvIu6YY1gYhjZhP6BX5ItZ+DUOuGYQHUADQxrZdh58GO5AgeCt
         M0sgNdUsB6gUJJM3ZFfZVnAT+vTKd3gpXt1YF/sA=
Date:   Tue, 27 Oct 2020 13:12:40 -0400
To:     Vasyl Vavrychuk <vvavrychuk@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: Hard linking symlink does not work
Message-ID: <20201027171240.GA1644@fieldses.org>
References: <CAGj4m+5rpNqW=XnU2cxGmWiBi47w3XTvn9EGekVPjq74pHfFGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGj4m+5rpNqW=XnU2cxGmWiBi47w3XTvn9EGekVPjq74pHfFGA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 23, 2020 at 01:13:02PM +0300, Vasyl Vavrychuk wrote:
> I have found that hard links for regular files works well for me over NFS:
> 
> $ touch bar
> $ ln bar tata
> 
> But if I try to make hard link for symlink, then it fails:
> 
> $ ln -s foo bar
> $ ln bar tata
> ln: failed to create hard link 'tata' => 'bar': Operation not permitted

Huh.  I'm not sure I even realized it was possible to hardlink symlinks.
Makes sense, I guess.

I think my first step debugging this would be to watch wireshark while
attempting the "ln", and see what happens.  That should tell us whether
it's the client or server that's failing the operation.

--b.

> 
> I am using NFSv4 with Vagrant, here is mount entry:
> 
> 172.28.128.1:PATH on /vagrant type nfs4
> (rw,relatime,vers=4.0,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,port=0,timeo=600,retrans=2,sec=sys,clientaddr=IP,local_lock=none,addr=IP)
> 
> I have also verified that rpc-statd is running on host.
> 
> Host machine is Ubuntu 18.04 with NFS packages version 1:1.3.4-2.1ubuntu5.3.
> 
> Will appreciate help on this.
> 
> Thanks,
> Vasyl
