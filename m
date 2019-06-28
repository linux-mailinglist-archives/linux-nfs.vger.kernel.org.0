Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51BB85A101
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2019 18:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfF1Qd7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jun 2019 12:33:59 -0400
Received: from fieldses.org ([173.255.197.46]:37464 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfF1Qd7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 28 Jun 2019 12:33:59 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id A1FCA1CE6; Fri, 28 Jun 2019 12:33:58 -0400 (EDT)
Date:   Fri, 28 Jun 2019 12:33:58 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/16] nfsd: escape high characters in binary data
Message-ID: <20190628163358.GA31800@fieldses.org>
References: <1561042275-12723-1-git-send-email-bfields@redhat.com>
 <1561042275-12723-9-git-send-email-bfields@redhat.com>
 <20190621174544.GC25590@fieldses.org>
 <201906211431.E6552108@keescook>
 <20190622190058.GD5343@fieldses.org>
 <201906221320.5BFC134713@keescook>
 <20190624210512.GA20331@fieldses.org>
 <20190626162149.GB4144@fieldses.org>
 <20190627202124.GC16388@fieldses.org>
 <201906272054.6954C08FA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201906272054.6954C08FA@keescook>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 27, 2019 at 08:58:22PM -0700, Kees Cook wrote:
> On Thu, Jun 27, 2019 at 04:21:24PM -0400, J. Bruce Fields wrote:
> > No, I was confused: "\n" is non-printable according to isprint(), so
> > ESCAPE_ANY_NP *will* escape it.  So this isn't quite so bad.  SSIDs are
> > usually printed as '%*pE', so arguably we should be escaping the single
> > quote character too, but at least we're not allowing line breaks
> > through.  I don't know about non-ascii.
> 
> Okay, cool. Given that most things are just trying to log, it seems like
> it should be safe to have %pE escape non-ascii, non-printable, \, ', and "?
> 
> And if we changing that, we're likely changing
> string_escape_mem(). Looking at callers of string_escape_mem() makes my
> head spin...

kstrdup_quotable:
	- only a few callers, mostly just logging, but
	  msm_gpu_crashstate_capture uses it to generate some data that
	  looks like it goes in a crashdump.  Dunno if there might be
	  some utility depending on the current escaping. On the other
	  hand, kstrdup_quotable uses ESCAPE_HEX, "\f\n\r\t\v\a\e\\\""
	  so those characters are all escaped as \xNN, so I'd hope
	  any parser would be prepared to unescape any hex character,
	  they'd have to go out of their way to do anything else.
string_escape_str:
	- proc_task_name: ESCAPE_SPACE|ESCAPE_SPECIAL, "\n\\", used for
	  command name in /proc/<pid>/stat{us}.  No way do I want to
	  change the format of those files at all.
	- seq_escape: ESCAPE_OCTAL, esc: haven't surveyed callers
	  carefully, but this probably shouldn't be changed.
	- qword_add: ESCAPE_OCTAL, "\\ \n\t", some nfsd upcalls.  Fine
	  as they are, but the other side will happily accept any octal
	  or hex escaping.
string_escape_mem_any_np, string_escape_str_any_np:
	- totally unused.
escaped_string: this is the vsnprintf logic.  Tons of users, haven't had
	a chance to look at them all.  Almost all %*pE, the exceptions
	don't look important.

So the only flag values we care about are ESCAPE_HEX, ESCAPE_OCTAL,
ESCAPE_SPACE|ESCAPE_SPECIAL, and ESCAPE_ANY_NP.

So this could be cleaned up some if we wanted.

> Anyway, I don't want to block you needlessly. What would like to have
> be next steps here?

I might still be interested in some cleanup, I find the current logic
unnecessarily confusing.

But I may just give up and go with my existing patch and put
off that project indefinitely, especially if there's no real need to fix
the existing callers.

I don't know....

--b.
