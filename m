Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE917E3B8
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Aug 2019 22:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388957AbfHAUBC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Aug 2019 16:01:02 -0400
Received: from fieldses.org ([173.255.197.46]:44390 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388766AbfHAUBC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 1 Aug 2019 16:01:02 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id E24AF7CB; Thu,  1 Aug 2019 16:01:01 -0400 (EDT)
Date:   Thu, 1 Aug 2019 16:01:01 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Cc:     linux-nfs@vger.kernel.org, Tom Haynes <loghyr@gmail.com>
Subject: Re: [PATCH] st_flex: fix uid/gid formatting in error message
Message-ID: <20190801200101.GB21527@fieldses.org>
References: <20190722141602.14274-1-tigran.mkrtchyan@desy.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722141602.14274-1-tigran.mkrtchyan@desy.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 22, 2019 at 04:16:02PM +0200, Tigran Mkrtchyan wrote:
> as ffds_user and ffds_group are utf8 encoded string use '%s' when
> constructing an error message.

Thanks, applied--sorry for being slow to get to this.

--b.

> 
> Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
> ---
>  nfs4.1/server41tests/st_flex.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/nfs4.1/server41tests/st_flex.py b/nfs4.1/server41tests/st_flex.py
> index 335b2c8..f4ac739 100644
> --- a/nfs4.1/server41tests/st_flex.py
> +++ b/nfs4.1/server41tests/st_flex.py
> @@ -313,10 +313,10 @@ def testFlexLayoutTestAccess(t, env):
>      gid_rd = ds.ffds_group
>  
>      if uid_rw == uid_rd:
> -        fail("Expected uid_rd != %i, got %i" % (uid_rd, uid_rw))
> +        fail("Expected uid_rd != %s, got %s" % (uid_rd, uid_rw))
>  
>      if gid_rw != gid_rd:
> -        fail("Expected gid_rd == %i, got %i" % (gid_rd, gid_rw))
> +        fail("Expected gid_rd == %s, got %s" % (gid_rd, gid_rw))
>  
>      res = close_file(sess, fh, stateid=open_stateid)
>      check(res)
> -- 
> 2.21.0
