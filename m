Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A509D0C3
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 15:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfHZNjv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 09:39:51 -0400
Received: from fieldses.org ([173.255.197.46]:46568 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728862AbfHZNjv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Aug 2019 09:39:51 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 112331CB3; Mon, 26 Aug 2019 09:39:51 -0400 (EDT)
Date:   Mon, 26 Aug 2019 09:39:51 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Alex Lyakas <alex@zadara.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        Shyam Kaushik <shyam@zadara.com>
Subject: Re: [RFC-PATCH] nfsd: when unhashing openowners, increment
 openowner's refcount
Message-ID: <20190826133951.GC22759@fieldses.org>
References: <1566406146-7887-1-git-send-email-alex@zadara.com>
 <CAOcd+r0bXefi79dnwrwsDN1OecScfTjc8DYS5_9A8D5XKrh7QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOcd+r0bXefi79dnwrwsDN1OecScfTjc8DYS5_9A8D5XKrh7QQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Aug 25, 2019 at 01:12:34PM +0300, Alex Lyakas wrote:
> You are listed as maintainers of nfsd. Can you please take a look at
> the below patch?

Thanks!

I take it this was found by some kind of code analysis or fuzzing, not
use in production?

Asking because I've been considering just deprecating it, so:

> > After we fixed this, we confirmed that the openowner is not freed
> > prematurely. It is freed by release_openowner() final call
> > to nfs4_put_stateowner().
> >
> > However, we still get (other) random crashes and memory corruptions
> > when nfsd_inject_forget_client_openowners() and
> > nfsd_inject_forget_openowners().
> > According to our analysis, we don't see any other refcount issues.
> > Can anybody from the community review these flows for other potentials issues?

I'm wondering how much effort we want to put into tracking all that
down.

--b.
