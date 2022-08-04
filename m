Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D048589ECB
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Aug 2022 17:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiHDPiS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Aug 2022 11:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiHDPiR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Aug 2022 11:38:17 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB97F1D0E2
        for <linux-nfs@vger.kernel.org>; Thu,  4 Aug 2022 08:38:16 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 0F3B546EF; Thu,  4 Aug 2022 11:38:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 0F3B546EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1659627496;
        bh=IgomHCSPSlob4jZm+mGLOCUBH0zrH29GGO92LTRejMI=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=ou/KptL6xo40kH4ruRfyP6a8BsNwniVtJ1xvBRdnKMg2DA0egITdyG3iMAp7335h8
         T+pDOIxGoC8txlfCljF2OxPE4OEmBWuuvn93Ciy3Dw1g9FvO8JN1zIWfnHlvCP5b7L
         kz+SvtU06t8sjWGvNftRkstV0lJ2DupyQP4LY3i0=
Date:   Thu, 4 Aug 2022 11:38:16 -0400
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: pynfs clean_init issue
Message-ID: <20220804153816.GB9019@fieldses.org>
References: <F80796C9-DFCE-4C7A-A2EE-4EB2075B9007@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F80796C9-DFCE-4C7A-A2EE-4EB2075B9007@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 04, 2022 at 03:23:44PM +0000, Chuck Lever III wrote:
> Hi Bruce-
> 
> I'm running DELEG21 to unit-test delegations, and this message comes
> out at the end:
> 
> Making sure b'DELEG21-1' is writable: operation OP_SETATTR should return NFS4_OK, instead got NFS4ERR_DELAY
> 
> I guess there's no callback service running during the test's clean-up phase.
> 
> Then if I run the test again immediately:
> 
> [cel@morisot pynfs]$ sudo nfs4.0/testserver.py manet:/export/tmp --maketree --rundeps -v cel
> Initialization failed, no tests run.
> Perhaps you need to use the --secure option or configure server to allow connections from high ports
> Traceback (most recent call last):
>   File "/home/cel/src/pynfs/nfs4.0/testserver.py", line 394, in <module>
>     main()
>   File "/home/cel/src/pynfs/nfs4.0/testserver.py", line 346, in main
>     env.init()
>   File "/home/cel/src/pynfs/nfs4.0/servertests/environment.py", line 150, in init
>     c.clean_dir(self.opts.path)
>   File "/home/cel/src/pynfs/nfs4.0/nfs4lib.py", line 579, in clean_dir
>     check_result(res, "Making sure %s is writable" % repr(e.name))
>   File "/home/cel/src/pynfs/nfs4.0/nfs4lib.py", line 906, in check_result
>     raise BadCompoundRes(resop, res.status, msg)
> nfs4lib.BadCompoundRes: Making sure b'DELEG21-1' is writable: operation OP_SETATTR should return NFS4_OK, instead got NFS4ERR_DELAY
> 
> And I think this condition persists until the old lease expires and
> the server permits the client to delete that file.

DELEG21 should pass on any recent kernel.

But possibly cleanup should also be better.  I'm not sure what the right
fix is.

--b.
