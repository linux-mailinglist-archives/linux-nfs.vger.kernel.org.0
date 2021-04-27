Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC0836CB7C
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Apr 2021 21:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhD0TKq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Apr 2021 15:10:46 -0400
Received: from gaia.bitwizard.nl ([149.210.166.240]:33852 "EHLO
        gaia.bitwizard.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhD0TKq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Apr 2021 15:10:46 -0400
X-Greylist: delayed 410 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Apr 2021 15:10:46 EDT
Received: from abra2.bitwizard.nl (unknown [10.8.0.6])
        by gaia.bitwizard.nl (Postfix) with ESMTPS id CE4B85A0058;
        Tue, 27 Apr 2021 21:03:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bitwizard.nl;
        s=default; t=1619550191;
        bh=ZLP+eMQrTWQGIgjlJOLA1enQ8g7PNFjcrzqFlBCO0LM=;
        h=Date:From:To:Subject:From;
        b=Y2RObIJ5ZHfNURXACrTIlJIgiebxtZZELLg1RzK2eTRLo0XE/363Q1Vxx9/HY9obW
         RIT4D8oSWAJplxXDaIaQNKMBtht//69AX4jSbulj44tLNOvxRkjb1XkMAySwkpiYeB
         Xf/EVsQpRGL2y+niNVVlBQYy0xNW2GbdvD/idGeUmZbZ7qs8pZlNqak5u+3A1yhiQv
         Lopei9dDfP5rdeR7jIO5J/nPJrsIoEXQRO5vQqsq9ZQO+OhO825UN0u5P2DZX8ZhDJ
         wG5PqxGrt6PgBVApkcCirxxoToOPOKvBbo5JSuOmrDNniMPNtCiabJ6rc7X54q7+E/
         04dTUaSjvbTOw==
Received: by abra2.bitwizard.nl (Postfix, from userid 1000)
        id A452AE42624; Tue, 27 Apr 2021 21:03:11 +0200 (CEST)
Date:   Tue, 27 Apr 2021 21:03:11 +0200
From:   Rogier Wolff <R.E.Wolff@BitWizard.nl>
To:     bfields@fieldses.org, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Subject: Lockd error message is unclear.
Message-ID: <20210427190311.cjjzeded7hl3fkew@BitWizard.nl>
Organization: BitWizard B.V.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Hi, 

Two things..... 

I got: 

   lockd: cannot monitor <client> 

in the logfile and the client was terrily slow/not working at all.

everything pointed to a lockd problem... 

In the end... it turns out that my rpc.statd stopped working.  I had
to go and download the sources to figure this out... I would firstly
suggest to improve the error message to give others running into this
more hints as to where to look.

The erorr message on line 169 of lockd.c could read: 

	lockd: Error in the rpc to rpc.statd to monitor %s\n

Would it be an idea to print the res.status error code? 


That said... 

When this situation is going on, the client grinds to a halt, and
lockd seems "stuck" in D state. I tried killing or stracing it, to try
to clear the error, before I found out it is a kernel deamon...

When this failure happens, I get the impression that lockd keeps on
trying to be "of service", retrying operations that are bound to
fail. So maybe the error should be cached, and then immediately
handled instead of making the client grind to a halt. (it is the (one
second?) timeout in nsm_mon_unmon and the big backlog of requests that
result in the same call and timeout that frustrate the client... )

	Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** https://www.BitWizard.nl/ ** +31-15-2049110 **
**    Delftechpark 11 2628 XJ  Delft, The Netherlands.  KVK: 27239233    **
f equals m times a. When your f is steady, and your m is going down
your a is going up.  -- Chris Hadfield about flying up the space shuttle.
