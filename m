Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894EE41EF32
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Oct 2021 16:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354204AbhJAOOv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Oct 2021 10:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353676AbhJAOOu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Oct 2021 10:14:50 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DCBC061775
        for <linux-nfs@vger.kernel.org>; Fri,  1 Oct 2021 07:13:06 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2FCC035BB; Fri,  1 Oct 2021 10:13:06 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2FCC035BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1633097586;
        bh=Po35VI2WR0mijHYgFjs8du/5yXKWXjR3fLwzLdFoLS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fF4ULZukIifnDTNrYAkBz1aTOGg2hyqonLYKA4bWmg5r/RwD+u3uE9Koj0fJ+XJtj
         iByMjrEEkNjvp5AYszpU2QbApJCsaZjPHtiQTX+idowO67uBfVqDuPGCEvN0Kj8fLS
         m7djECghzpjs3d2LI1ZZCjq71KWUOhHTEUEAvuR4=
Date:   Fri, 1 Oct 2021 10:13:06 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Volodymyr Khomenko <volodymyr@vastdata.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: GSSAPI fix for pynfs nfs4.1 client code
Message-ID: <20211001141306.GD959@fieldses.org>
References: <CANkgwetkTUjj-bMrM4XTvk0vhGiJt3wNKPpRvzgTk-u7ZfrdXg@mail.gmail.com>
 <20210930211123.GA16927@fieldses.org>
 <CANkgweuuo7VctNLNSGyVE2Unjv_RMdG7+zPYr6_QwSZAQTbPRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANkgweuuo7VctNLNSGyVE2Unjv_RMdG7+zPYr6_QwSZAQTbPRQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 01, 2021 at 09:49:50AM +0300, Volodymyr Khomenko wrote:
> > So, I can verify that --security=krb5 works after this patch but not
> > before, good.  But why is that?  As you say, the server is supposed to
> > ignore the sequence number on context creation requests.  And 0 is valid
> > sequence number as far as I know.
> 
> By design of RPCGSS we have a 'last seen seq_number' counter on the
> server side per each GSS context
> and we must not accept any packet that was already seen before (we
> also have a bitmask of several last requests for this).
> This 'last seen counter' is unsigned int32 (the same as seq_num) so we
> can't just init it to -1 so next seq_num=0 will be valid.
> The most obvious implementation is to init it last_seen_seq_num to 0
> so the very 1st packet after NFS4 NULL must be 1 to differ from last
> seen seq_number.

Note in theory gssapi mechanisms can require multiple round trips (in
the GSS_PROC_CONTINUE_INIT case), so this wouldn't actually avoid
duplicate sequence numbers.

In any case, the rfc is unambiguous here: "In a creation request, the
seq_num and service fields are undefined and both must be ignored by the
server."

> A better implementation (theoretically) can set this counter to
> 'undefined' state by additional flag, but this is  more
> resource-consuming
> (you need to process is_inited flag + last_seen_seq_num instead of
> just one counter).
> If the last seen seq_number is undefined during GSS initialization,
> then strictly speaking we can send ANY seq_num for the very 1st
> request after NFS4 NULL.

Right, again, from RFC 2203, " The seq_num field can start at any value
below MAXSEQ."

It can be implemented without the need for an is_inited flag.

The initial sequence number of 0 really did find an actual bug in the
server, so pynfs is definitely doing its job in this case!

--b.
