Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04D2417B6F
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Sep 2021 21:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346095AbhIXTF1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Sep 2021 15:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhIXTF0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Sep 2021 15:05:26 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443E8C061571
        for <linux-nfs@vger.kernel.org>; Fri, 24 Sep 2021 12:03:53 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 359BF6814; Fri, 24 Sep 2021 15:03:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 359BF6814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1632510232;
        bh=jiFlW5P4EJb78zkwd+/lDROWq7Wav9LBFK4/hyCNR2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U9QLfC4SES3wJ6iDLfomIzKECxBEmhm8woNYUSIxTUOR59hNujwvsRS9iFmOvQCX3
         MdYz3EI1cYyK+ZubYj8mxlioDZj/tXxwTGkIk1c38hRKYB+FvVuGjG2lJual0Ph5Pp
         Cz82c+lE49mR2gS4FNvZIavejUMOgiImLiuelAb0=
Date:   Fri, 24 Sep 2021 15:03:52 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Kazi Anwar <kazia@srf-ext.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: nfs4err_delay
Message-ID: <20210924190352.GD13115@fieldses.org>
References: <CAGw7ksJxiKkOf2F9FUDCa_mSAkoU6U=vCXFcupsu+izKuEE1WA@mail.gmail.com>
 <20210924163948.GB13115@fieldses.org>
 <CAGw7ksJGjG0PUZqr+U+ssq_6YHgJ4cga40MCdpm8b_rYn1a5OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGw7ksJGjG0PUZqr+U+ssq_6YHgJ4cga40MCdpm8b_rYn1a5OA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 24, 2021 at 12:54:30PM -0500, Kazi Anwar wrote:
> Yes, both clients and server are centos 7.6. And the NFS4ERR_DELAY is
> a response to a REMOVE.
> I will need to check on the locks the next time it happens. Can you
> share what you are thinking?

Offhand the only reason I can think a server would return DELAY is that
there's a delegation on the file being removed, and the delegation
recall and return isn't working for some reason.

If that's the case, it should succeed after about 90 seconds.  Also, you
can workaround the problem by turning of delegations and leases with
"echo 0 >/proc/sys/fs/leases_enable".

--b.

> 
> thanks,
> Kazi
> 
> On Fri, Sep 24, 2021 at 11:39 AM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Wed, Sep 22, 2021 at 03:56:23PM -0500, Kazi Anwar wrote:
> > > We are running nfs v 4.1 on centos 7.6.
> > > We are seeing an NFS issue where when files/dirs are deleted from a
> > > client they are occasionally stuck at unlinkat system call(according
> > > to strace its stuck for 100.5 secs every time). Can anyone explain
> > > this behavior?
> > > Running tcp dump shows nfs4err_delay status sent from the server to
> > > the stuck client.
> >
> > Client and server are both centos 7.6?
> >
> > Is the NFS4ERR_DELAY a reponse to a REMOVE?
> >
> > Does /proc/locks show a delegation held on the file the client's trying
> > to remove?
> >
> > --b.
