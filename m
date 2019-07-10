Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E82D664E99
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2019 00:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfGJWJc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Jul 2019 18:09:32 -0400
Received: from fieldses.org ([173.255.197.46]:53602 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbfGJWJc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 10 Jul 2019 18:09:32 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id B8EC78A6; Wed, 10 Jul 2019 18:09:31 -0400 (EDT)
Date:   Wed, 10 Jul 2019 18:09:31 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/16] nfsd: escape high characters in binary data
Message-ID: <20190710220931.GB11923@fieldses.org>
References: <1561042275-12723-9-git-send-email-bfields@redhat.com>
 <20190621174544.GC25590@fieldses.org>
 <201906211431.E6552108@keescook>
 <20190622190058.GD5343@fieldses.org>
 <201906221320.5BFC134713@keescook>
 <20190624210512.GA20331@fieldses.org>
 <20190626162149.GB4144@fieldses.org>
 <20190627202124.GC16388@fieldses.org>
 <201906272054.6954C08FA@keescook>
 <20190628163358.GA31800@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628163358.GA31800@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jun 28, 2019 at 12:33:58PM -0400, J. Bruce Fields wrote:
> But I may just give up and go with my existing patch and put
> off that project indefinitely, especially if there's no real need to fix
> the existing callers.

I went with the existing patch, but gave a little more thought to
string_escape_mem.  Stuff that bugs me:

	- ESCAPE_NP sounds like it means "escape nonprinting
	  characters", but actually means "do not escape printing
	  characters"
	- the use of the "only" string to limit the list of escaped
	  characters rather than supplement them is confusing and kind
	  of unhelpful.
	- most of the flags are actually totally unused
    
So what I'd like to do is:
    
	- eliminate unused flags
	- use the "only" string to add to, rather than replace, the list
	  of characters to escape
	- separate flags into those that select which characters to
	  escape, and those that choose the format of the escaping ("\ "
	  vs "\x20" vs "\040".)
    
I've got some patches that do all that and I think it works.  I need to
clean them up a bit and fix up the tests.

--b.
