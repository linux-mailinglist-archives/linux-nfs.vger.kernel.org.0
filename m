Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F7731C384
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Feb 2021 22:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBOVX4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Feb 2021 16:23:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhBOVXz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 15 Feb 2021 16:23:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3AAF64DE0;
        Mon, 15 Feb 2021 21:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613424195;
        bh=+/OBtwovyx4fA6F+V31Ui5SRTkafymigVbIcNBNTo0k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QM6Cs67vv+uzV9IsUYSd6harMCW3aMxiIp31o+O0R9k7+WZAiNKlD3e68TJzySxOH
         a/SetCxQRQyrCWkjIJaSELukASgrgMZPzGn2qNqQ2KUev5fS+Au8xfqQwmumxmeHA2
         8L9YfnAbGxICiJn52F5uQeHB59qWOrrxK+KscKpho66tE3oqJntBcf89SXYD4PzM5o
         PuAxxVKdvFdsgPfLTwQ3Lh3iqR07avshgVT5kEkmkwHjFVaBrxVIik7ulcJLlu4XQt
         lIch2JNEUI/7u/oTFYJnf3nQBOBIcALPA3/S5+Fd5SeFA+kbxnxrhhlGRuXrewSATn
         M+BQtR7FF5HnQ==
Message-ID: <a6c23b0b9b20246cff0ca2062997bd7209a29098.camel@kernel.org>
Subject: Re: pynfs breakage
From:   Jeff Layton <jlayton@kernel.org>
To:     Bruce Fields <bfields@fieldses.org>
Cc:     "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>
Date:   Mon, 15 Feb 2021 16:23:13 -0500
In-Reply-To: <20210215212235.GD30742@fieldses.org>
References: <804830ba7fdd91cbf9348050b07f9922801d20f0.camel@kernel.org>
         <20210215201728.GC30742@fieldses.org> <20210215212235.GD30742@fieldses.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2021-02-15 at 16:22 -0500, Bruce Fields wrote:
> On Mon, Feb 15, 2021 at 03:17:28PM -0500, Bruce Fields wrote:
> > On Mon, Feb 15, 2021 at 03:15:08PM -0500, Jeff Layton wrote:
> > > Hi Bruce!
> > > 
> > > The latest HEAD in pynfs doesn't run for me:
> > > 
> > > $ ./nfs4.1/testserver.py --help
> > > Traceback (most recent call last):
> > >   File "/home/jlayton/git/pynfs/nfs4.1/./testserver.py", line 38, in <module>
> > >     import server41tests.environment as environment
> > >   File "/home/jlayton/git/pynfs/nfs4.1/server41tests/environment.py", line 593
> > >     def write_file(sess, file, data, offset=0 stateid=stateid4(0, b''),
> > >                                               ^
> > > SyntaxError: invalid syntax
> > > 
> > > If I revert this commit, then it works:
> > 
> > Yeah, sorry about that, I pushed out quickly thinking I'd tested it, but
> > in fact it has a bunch of mistakes.  Fixing....
> 
> Should be fixed, apologies again.--b.

No worries. Thanks for fixing it so fast!
-- 
Jeff Layton <jlayton@kernel.org>

