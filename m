Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 096BC1B74E
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2019 15:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfEMNo6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 May 2019 09:44:58 -0400
Received: from fieldses.org ([173.255.197.46]:58336 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728755AbfEMNo5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 13 May 2019 09:44:57 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 6E19F1DCB; Mon, 13 May 2019 09:44:57 -0400 (EDT)
Date:   Mon, 13 May 2019 09:44:57 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     steved@redhat.com, linux-nfs@vger.kernel.org, jfajerski@suse.com
Subject: Re: [PATCH] manpage: explain why showmount doesn't really work
 against a v4-only server
Message-ID: <20190513134457.GA13359@fieldses.org>
References: <20190510215445.1823-1-jlayton@kernel.org>
 <20190511135442.GA15721@fieldses.org>
 <593884facebf2ebcafcbe577845a961abbaa9928.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <593884facebf2ebcafcbe577845a961abbaa9928.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 13, 2019 at 09:29:42AM -0400, Jeff Layton wrote:
> Yeah, that certainly wouldn't hurt. I'd suggest we add that in a
> separate patch though.

Agreed.

> We will need to spell this out in the manpage either way. At least with
> ganesha, you can export some filesystems via v3 and others via v4 only,
> and the MNT service there will only report the v3 ones. In that case,
> you have a reachable service, but the v4-only filesystems will be
> missing from showmount's output.

That doesn't sound like a great idea to me, but maybe you have no choice
if for some reason you want to allow simultaneous support for v3-only
clients and for filesystems that require long filehandles?  Ugh.

Anyway, this kind of warning doesn't have to catch every odd case.

--b.
