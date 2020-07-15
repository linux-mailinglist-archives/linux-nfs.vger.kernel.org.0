Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7919220E8C
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2020 15:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbgGON41 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jul 2020 09:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbgGON41 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jul 2020 09:56:27 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68F3C061755
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jul 2020 06:56:26 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id BF79E6193; Wed, 15 Jul 2020 09:56:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org BF79E6193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1594821384;
        bh=Qqcgu+AxDAO/yXXawtazKVarh7tfQNjk0S9R+kJiJRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QbR6JUMXNZaIYuHPMA6oloYlJWT4OT9/l6mpPzmOUgnJxq2AMtwBCQPSNXoG5XBVZ
         Il0Jrr1mk3HYNfJYLfOgV1bTNte/TtnurhP3YLcbhkbZjjQpfjycXOu7ZCF3lidQjc
         iaLimqvJ5hLLnPFx1fxz6TnHbM6PM+wjqOEIA0Lc=
Date:   Wed, 15 Jul 2020 09:56:24 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] change shebang to python3
Message-ID: <20200715135624.GA15543@fieldses.org>
References: <20200714185734.133111-1-tigran.mkrtchyan@desy.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714185734.133111-1-tigran.mkrtchyan@desy.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 14, 2020 at 08:57:34PM +0200, Tigran Mkrtchyan wrote:
> as there are still OSes (RHEL7 and clones) that point `python` to `python2`

OK.  Thanks, Tigran!

--b.

> 
> Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
> ---
>  nfs4.0/nfs4client.py  | 2 +-
>  nfs4.0/nfs4lib.py     | 2 +-
>  nfs4.0/nfs4server.py  | 2 +-
>  nfs4.0/setup.py       | 2 +-
>  nfs4.0/testserver.py  | 2 +-
>  nfs4.1/errorparser.py | 2 +-
>  nfs4.1/nfs4proxy.py   | 2 +-
>  nfs4.1/nfs4server.py  | 2 +-
>  nfs4.1/testclient.py  | 2 +-
>  nfs4.1/testserver.py  | 2 +-
>  setup.py              | 2 +-
>  showresults.py        | 2 +-
>  xdr/setup.py          | 2 +-
>  xdr/xdrgen.py         | 2 +-
>  14 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/nfs4.0/nfs4client.py b/nfs4.0/nfs4client.py
> index f67c1e3..d3d6e88 100755
> --- a/nfs4.0/nfs4client.py
> +++ b/nfs4.0/nfs4client.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>  
>  #
>  # nfs4client.py - NFS4 interactive client in python
> diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
> index a9a65d7..905f8f4 100644
> --- a/nfs4.0/nfs4lib.py
> +++ b/nfs4.0/nfs4lib.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>  # nfs4lib.py - NFS4 library for Python
>  #
>  # Requires python 3.2
> diff --git a/nfs4.0/nfs4server.py b/nfs4.0/nfs4server.py
> index 753372e..3cf6ec2 100755
> --- a/nfs4.0/nfs4server.py
> +++ b/nfs4.0/nfs4server.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>  #
>  # nfs4server.py - NFS4 server in python
>  #
> diff --git a/nfs4.0/setup.py b/nfs4.0/setup.py
> index fa680e2..58349d9 100755
> --- a/nfs4.0/setup.py
> +++ b/nfs4.0/setup.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>  
>  from __future__ import print_function
>  from __future__ import absolute_import
> diff --git a/nfs4.0/testserver.py b/nfs4.0/testserver.py
> index a225077..3ceac3c 100755
> --- a/nfs4.0/testserver.py
> +++ b/nfs4.0/testserver.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>  # nfs4stest.py - nfsv4 server tester
>  #
>  # Requires python 3.2
> diff --git a/nfs4.1/errorparser.py b/nfs4.1/errorparser.py
> index 328fe8d..9df41d9 100755
> --- a/nfs4.1/errorparser.py
> +++ b/nfs4.1/errorparser.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>  from __future__ import with_statement
>  import use_local # HACK so don't have to rebuild constantly
>  from xml.dom import minidom
> diff --git a/nfs4.1/nfs4proxy.py b/nfs4.1/nfs4proxy.py
> index dc8fdd4..dd870d9 100755
> --- a/nfs4.1/nfs4proxy.py
> +++ b/nfs4.1/nfs4proxy.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>  from __future__ import with_statement
>  import use_local # HACK so don't have to rebuild constantly
>  import nfs4lib
> diff --git a/nfs4.1/nfs4server.py b/nfs4.1/nfs4server.py
> index 4500daf..6f7d10c 100755
> --- a/nfs4.1/nfs4server.py
> +++ b/nfs4.1/nfs4server.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>  from __future__ import with_statement
>  import use_local # HACK so don't have to rebuild constantly
>  import nfs4lib
> diff --git a/nfs4.1/testclient.py b/nfs4.1/testclient.py
> index 46b7abc..dd68bda 100755
> --- a/nfs4.1/testclient.py
> +++ b/nfs4.1/testclient.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>  # nfs4stest.py - nfsv4 server tester
>  #
>  # Requires python 3.2
> diff --git a/nfs4.1/testserver.py b/nfs4.1/testserver.py
> index 8b80863..01d600e 100755
> --- a/nfs4.1/testserver.py
> +++ b/nfs4.1/testserver.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>  # nfs4stest.py - nfsv4 server tester
>  #
>  # Requires python 3.2
> diff --git a/setup.py b/setup.py
> index 3e48346..83dc6b5 100755
> --- a/setup.py
> +++ b/setup.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>  
>  from __future__ import print_function
>  
> diff --git a/showresults.py b/showresults.py
> index a39e1b9..5abd72a 100755
> --- a/showresults.py
> +++ b/showresults.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>  # showresults.py - redisplay results from nfsv4 server tester output file
>  #
>  # Requires python 3.2
> diff --git a/xdr/setup.py b/xdr/setup.py
> index 1ab9c8d..e8af152 100644
> --- a/xdr/setup.py
> +++ b/xdr/setup.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>  
>  from distutils.core import setup
>  
> diff --git a/xdr/xdrgen.py b/xdr/xdrgen.py
> index abfc8d7..130f364 100755
> --- a/xdr/xdrgen.py
> +++ b/xdr/xdrgen.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>  # rpcgen.py - A Python RPC protocol compiler
>  # 
>  # Written by Fred Isaman <iisaman@citi.umich.edu>
> -- 
> 2.26.2
