Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408D12DE78F
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Dec 2020 17:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgLRQoH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Dec 2020 11:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgLRQoG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Dec 2020 11:44:06 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9441EC0617A7
        for <linux-nfs@vger.kernel.org>; Fri, 18 Dec 2020 08:43:26 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id D6E826EB9; Fri, 18 Dec 2020 11:43:25 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org D6E826EB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1608309805;
        bh=jWwrM48PmnJ3YcfcYyFdW/hGj4I6ba18W8cKaR7d0sc=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=BnMHDrKuEBykkVt/HzQ0S0zNpF4v43ji67RrXvoYj5G82Rvg4DN6zYr7vbnRTlEtd
         JCOWkNfTeiIxUEnqY9fwHCcwRlN72w3zL8IbvvpEgkzKAkgqy6jLlcntL01lNpoovR
         FELTkd8KgekNpHwFaugdPi8Z3xtNRbE1535pYb2A=
Date:   Fri, 18 Dec 2020 11:43:25 -0500
To:     Tom Haynes <loghyr@gmail.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [pynfs 03/10] Close the file for SEQ10b
Message-ID: <20201218164325.GD1258@fieldses.org>
References: <20201217003516.75438-1-loghyr@hammerspace.com>
 <20201217003516.75438-4-loghyr@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217003516.75438-4-loghyr@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 16, 2020 at 04:35:09PM -0800, Tom Haynes wrote:
> Signed-off-by: Tom Haynes <loghyr@hammerspace.com>
> ---
>  nfs4.1/server41tests/st_sequence.py | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/nfs4.1/server41tests/st_sequence.py b/nfs4.1/server41tests/st_sequence.py
> index 9be1096..969deb8 100644
> --- a/nfs4.1/server41tests/st_sequence.py
> +++ b/nfs4.1/server41tests/st_sequence.py
> @@ -225,6 +225,7 @@ def testReplayCache007(t, env):
>      check(res)
>      fh = res.resarray[-1].object
>      stateid = res.resarray[-2].stateid
> +
>      ops = env.home + [op.savefh(),\
>            op.rename(b"%s_1" % env.testname(t), b"%s_2" % env.testname(t))]
>      res1 = sess1.compound(ops, cache_this=False)
> @@ -233,6 +234,10 @@ def testReplayCache007(t, env):
>      check(res2, [NFS4_OK, NFS4ERR_RETRY_UNCACHED_REP])
>      close_file(sess1, fh, stateid=stateid)
>  
> +    # Cleanup
> +    res = sess1.compound([op.putfh(fh), op.close(0, stateid)])
> +    check(res)
> +

This is giving me:

SEQ10b   st_sequence.testReplayCache007                           : FAILURE
           OP_CLOSE should return NFS4_OK, instead got
	              NFS4ERR_BAD_STATEID

probably because the file was already closed just above.  I'm not sure
whta was intended here.  Reverting for now.

--b.

>  def testOpNotInSession(t, env):
>      """Operations other than SEQUENCE, BIND_CONN_TO_SESSION, EXCHANGE_ID,
>         CREATE_SESSION, and DESTROY_SESSION, MUST NOT appear as the
> -- 
> 2.26.2
