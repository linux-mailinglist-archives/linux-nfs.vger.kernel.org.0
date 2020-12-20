Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067482DF600
	for <lists+linux-nfs@lfdr.de>; Sun, 20 Dec 2020 16:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgLTP5c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 20 Dec 2020 10:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbgLTP5c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 20 Dec 2020 10:57:32 -0500
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [IPv6:2001:638:700:1038::1:9b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C93C0613CF
        for <linux-nfs@vger.kernel.org>; Sun, 20 Dec 2020 07:56:51 -0800 (PST)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
        by smtp-o-2.desy.de (Postfix) with ESMTP id 893A6160FC0
        for <linux-nfs@vger.kernel.org>; Sun, 20 Dec 2020 16:56:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 893A6160FC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1608479806; bh=3kK3mhw+useqdgx5jLgtA9QBVnohbfPTJ7e3YpNHCCk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=z3+StjpRrwT+IC+9avFy6Kibg/zBZUybcLu4URJcK4tdnbC8zbONt1fxNvyRLevZn
         U845Lv6oczrDGyjzFGXh0L1MGzedVFYzz2OdbRLp6YZEIRvwzeeBWgb0lA6JAF2oDh
         UBiS24HbHRpsYZ36jCrO5MskatXysfWN4SWYP+Oc=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id 7C3DF1A01C7;
        Sun, 20 Dec 2020 16:56:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-1.desy.de (Postfix) with ESMTP id 549D3C0177;
        Sun, 20 Dec 2020 16:56:46 +0100 (CET)
Date:   Sun, 20 Dec 2020 16:56:45 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Tom Haynes <loghyr@gmail.com>
Cc:     bfields <bfields@redhat.com>, linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <2110076167.5569939.1608479805678.JavaMail.zimbra@desy.de>
In-Reply-To: <20201219182948.83000-7-loghyr@hammerspace.com>
References: <20201219182948.83000-1-loghyr@hammerspace.com> <20201219182948.83000-7-loghyr@hammerspace.com>
Subject: Re: [pynfs python3 6/7] st_flex: Return the layout before closing
 the file
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3980)
Thread-Topic: st_flex: Return the layout before closing the file
Thread-Index: 7wVd+MpsQbGPPzcZVDTEom3paTQXOw==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Tom,

works for me as well with fedora33 and dcache server.

Thanks,
   Tigran.

----- Original Message -----
> From: "Tom Haynes" <loghyr@gmail.com>
> To: "bfields" <bfields@redhat.com>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Saturday, 19 December, 2020 19:29:47
> Subject: [pynfs python3 6/7] st_flex: Return the layout before closing the file

> From: Tom Haynes <loghyr@excfb.com>
> 
> Signed-off-by: Tom Haynes <loghyr@excfb.com>
> ---
> nfs4.1/server41tests/st_flex.py | 40 +++++++++++++++++++++++++++------
> 1 file changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/nfs4.1/server41tests/st_flex.py b/nfs4.1/server41tests/st_flex.py
> index 3aae441..2b1820c 100644
> --- a/nfs4.1/server41tests/st_flex.py
> +++ b/nfs4.1/server41tests/st_flex.py
> @@ -56,6 +56,15 @@ def testStateid1(t, env):
>         # the server increments by one the value of the "seqid" in each
>         # subsequent LAYOUTGET and LAYOUTRETURN response,
>         check_seqid(lo_stateid, i + 2)
> +
> +    ops = [op.putfh(fh),
> +           op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
> +                           layoutreturn4(LAYOUTRETURN4_FILE,
> +                                         layoutreturn_file4(0, NFS4_MAXFILELEN,
> +                                                            lo_stateid,
> empty_p.get_buffer())))]
> +    res = sess.compound(ops)
> +    check(res)
> +
>     res = close_file(sess, fh, stateid=open_stateid)
>     check(res)
> 
> @@ -79,13 +88,13 @@ def testFlexLayoutReturnFile(t, env):
>     res = sess.compound(ops)
>     check(res)
>     # Return layout
> -    layout_stateid = res.resarray[-1].logr_stateid
> +    lo_stateid = res.resarray[-1].logr_stateid
> 
>     ops = [op.putfh(fh),
>            op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
>                            layoutreturn4(LAYOUTRETURN4_FILE,
>                                          layoutreturn_file4(0, NFS4_MAXFILELEN,
> -                                                            layout_stateid,
> empty_p.get_buffer())))]
> +                                                            lo_stateid,
> empty_p.get_buffer())))]
>     res = sess.compound(ops)
>     check(res)
>     res = close_file(sess, fh, stateid=open_stateid)
> @@ -150,6 +159,15 @@ def testFlexLayoutOldSeqid(t, env):
>                                                             lo_stateid, empty_p.get_buffer())))]
>     res = sess.compound(ops)
>     check(res, NFS4ERR_OLD_STATEID, "LAYOUTRETURN with an old stateid")
> +
> +    ops = [op.putfh(fh),
> +           op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
> +                           layoutreturn4(LAYOUTRETURN4_FILE,
> +                                         layoutreturn_file4(0, NFS4_MAXFILELEN,
> +                                                            lo_stateid3,
> empty_p.get_buffer())))]
> +    res = sess.compound(ops)
> +    check(res)
> +
>     res = close_file(sess, fh, stateid=open_stateid)
>     check(res)
> 
> @@ -260,8 +278,8 @@ def testFlexLayoutTestAccess(t, env):
>                         0, NFS4_MAXFILELEN, 8192, open_stateid, 0xffff)]
>     res = sess.compound(ops)
>     check(res)
> -    lo_stateid = res.resarray[-1].logr_stateid
> -    check_seqid(lo_stateid, 1)
> +    lo_stateid1 = res.resarray[-1].logr_stateid
> +    check_seqid(lo_stateid1, 1)
> 
>     layout = res.resarray[-1].logr_layout[-1]
>     p = FlexUnpacker(layout.loc_body)
> @@ -277,11 +295,11 @@ def testFlexLayoutTestAccess(t, env):
>     ops = [op.putfh(fh),
>            op.layoutget(False, LAYOUT4_FLEX_FILES,
>                         LAYOUTIOMODE4_READ,
> -                        0, NFS4_MAXFILELEN, 8192, lo_stateid, 0xffff)]
> +                        0, NFS4_MAXFILELEN, 8192, lo_stateid1, 0xffff)]
>     res = sess.compound(ops)
>     check(res)
> -    lo_stateid = res.resarray[-1].logr_stateid
> -    check_seqid(lo_stateid, 2)
> +    lo_stateid2 = res.resarray[-1].logr_stateid
> +    check_seqid(lo_stateid2, 2)
> 
>     layout = res.resarray[-1].logr_layout[-1]
>     p = FlexUnpacker(layout.loc_body)
> @@ -300,6 +318,14 @@ def testFlexLayoutTestAccess(t, env):
>     if gid_rw != gid_rd:
>         fail("Expected gid_rd == %s, got %s" % (gid_rd, gid_rw))
> 
> +    ops = [op.putfh(fh),
> +           op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
> +                           layoutreturn4(LAYOUTRETURN4_FILE,
> +                                         layoutreturn_file4(0, NFS4_MAXFILELEN,
> +                                                            lo_stateid2,
> empty_p.get_buffer())))]
> +    res = sess.compound(ops)
> +    check(res)
> +
>     res = close_file(sess, fh, stateid=open_stateid)
>     check(res)
> 
> --
> 2.26.2
