Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB8C3C6192
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jul 2021 19:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhGLRMr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jul 2021 13:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233331AbhGLRMr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 12 Jul 2021 13:12:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42F55611CB;
        Mon, 12 Jul 2021 17:09:58 +0000 (UTC)
Date:   Mon, 12 Jul 2021 13:09:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
Message-ID: <20210712130956.68a5a29f@gandalf.local.home>
In-Reply-To: <BC78B174-91E3-44C5-8B49-2C5F34BA8823@oracle.com>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
        <162083370248.3108.7424008399973918267.stgit@klimt.1015granger.net>
        <20210512122623.79ee0dda@gandalf.local.home>
        <238C0E2D-C2A4-4578-ADD2-C565B3B99842@oracle.com>
        <20210513105018.7539996a@gandalf.local.home>
        <BC78B174-91E3-44C5-8B49-2C5F34BA8823@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 12 Jul 2021 15:18:05 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> Hello Steven-
> 
> > On May 13, 2021, at 10:50 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > On Wed, 12 May 2021 16:52:05 +0000
> > Chuck Lever III <chuck.lever@oracle.com> wrote:
> >   
> >> The underlying need is to support non-NUL-terminated C strings.
> >> 
> >> I assumed that since the commentary around 9a6944fee68e claims
> >> the proper way to trace C strings is to use __string and friends,
> >> and those do not support non-NUL-terminated strings, that such
> >> strings are really not first-class citizens. Thus I concluded
> >> that my use of '%.*s' was incorrect.
> >> 
> >> Having some __string-style helpers that can deal with such
> >> strings would be valuable.  
> > 
> > I guess the best I can do is a strncpy version, that will add the '\0' in
> > the ring buffer. That way we don't need to save the length as well (length
> > would need to be at least 4 bytes, where as '\0' is one).
> > 
> > Something like this?  
> 
> I don't see this change in v5.14-rc1.

Grumble.

I thought this thread was over with the bug fix that was sent, but
completely forgot about this change, as I never made it into a real commit.

I can add this now, kick off some tests, and grovel to Linus saying that
this is unused code, but other code will depend on this, and I want to get
it upstream so that it can.

-- Steve
> 
> 
> > I added "__string_len()" and "__assign_str_len()". You use them just like
> > __string() and __assign_str() but add a max length that you want to use
> > (although, it will always allocate "len" regardless if the string is
> > smaller). Then use __get_str() just like you use __string().
> > 
> > Would something like that work?
> > 
> > -- Steve
> > 
