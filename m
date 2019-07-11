Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D1265003
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2019 03:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfGKByn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Jul 2019 21:54:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44397 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfGKByn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Jul 2019 21:54:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so1943963pfe.11
        for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2019 18:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qW9jfYxNMujId7LJT1rGzbFdQXmkSzpdOyWFgtYjpjk=;
        b=nr1P4tOysoPDsg+1X42+Mwpj8CCZy/iQeTImBlVtNnB9+DbrTfcRFknaEy7rq2ct0W
         cQzAsJ05yWSgDH3Krz64BzFtYqHziLVi5NtLZX/6UPSjs50kxsKk5XuDAnkOtr/VesgY
         qKqGI3vTw1+ILQviGnWmAhlKfeBpU9dA9tvqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qW9jfYxNMujId7LJT1rGzbFdQXmkSzpdOyWFgtYjpjk=;
        b=ufc/Mzm+VPfowrpAyTiaoF/DLW1DnIo2fKCLlBsqqoVfcpqKjT3yA/STqbS/BpUWzT
         cJIsIkyyR7scrM9m4vSLxW6WOhf5tZS+kKd9TBW6MTRBJL73NjMKwxdaDUAEun1nQpO4
         3oqgNdHdml7r4lrai7xyKKRvjz/BkZOxcjntxZHMDFIAFOCTifzoSNENrpofHbzZQylJ
         2q2q5JhMOagUoGZ47I7yloyn855Vfs9fYnXXPomCv33cR5ChOUsv+I0MFg8wTGhD+GrH
         x7BWuXS2CDbFt8FRK6upV2r+l6P6sJXvwkpWNg24uOTkKAo5LZrdDCtmouoDG0dIJC2X
         f/zA==
X-Gm-Message-State: APjAAAX9lmkuor7reUsS/RfZBKEAOsrrlP6g0HBhrg02hYj6YiNcGr9w
        pleWpT1ZJBN3mgQbsiTzv75R+AuxTHU=
X-Google-Smtp-Source: APXvYqyi7toXW1TF+qKLrbMZDPdvh5YEUi90anz2DzhBpNoUWzsiAPBce0aw+SXyV3xmjjdCPGmXXA==
X-Received: by 2002:a17:90a:bc42:: with SMTP id t2mr1676472pjv.121.1562810082347;
        Wed, 10 Jul 2019 18:54:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x1sm2981654pjo.4.2019.07.10.18.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2019 18:54:41 -0700 (PDT)
Date:   Wed, 10 Jul 2019 18:54:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/16] nfsd: escape high characters in binary data
Message-ID: <201907101853.AB9F346A92@keescook>
References: <20190621174544.GC25590@fieldses.org>
 <201906211431.E6552108@keescook>
 <20190622190058.GD5343@fieldses.org>
 <201906221320.5BFC134713@keescook>
 <20190624210512.GA20331@fieldses.org>
 <20190626162149.GB4144@fieldses.org>
 <20190627202124.GC16388@fieldses.org>
 <201906272054.6954C08FA@keescook>
 <20190628163358.GA31800@fieldses.org>
 <20190710220931.GB11923@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710220931.GB11923@fieldses.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jul 10, 2019 at 06:09:31PM -0400, J. Bruce Fields wrote:
> On Fri, Jun 28, 2019 at 12:33:58PM -0400, J. Bruce Fields wrote:
> > But I may just give up and go with my existing patch and put
> > off that project indefinitely, especially if there's no real need to fix
> > the existing callers.
> 
> I went with the existing patch, but gave a little more thought to
> string_escape_mem.  Stuff that bugs me:
> 
> 	- ESCAPE_NP sounds like it means "escape nonprinting
> 	  characters", but actually means "do not escape printing
> 	  characters"
> 	- the use of the "only" string to limit the list of escaped
> 	  characters rather than supplement them is confusing and kind
> 	  of unhelpful.
> 	- most of the flags are actually totally unused
>     
> So what I'd like to do is:
>     
> 	- eliminate unused flags
> 	- use the "only" string to add to, rather than replace, the list
> 	  of characters to escape
> 	- separate flags into those that select which characters to
> 	  escape, and those that choose the format of the escaping ("\ "
> 	  vs "\x20" vs "\040".)
>     
> I've got some patches that do all that and I think it works.  I need to
> clean them up a bit and fix up the tests.

This sounds amazing; thanks! Luckily there are self-tests for this code,
so anything really surprising should stand out. I'm looking forward to
it -- I want to see if I can refactor a few of the callers (if you
haven't already do so) too.

Yay!

-- 
Kees Cook
