Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4774EAF6C
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Mar 2022 16:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbiC2Om5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Mar 2022 10:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238067AbiC2Omx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Mar 2022 10:42:53 -0400
Received: from smtpout-2.cvg.de (smtpout-2.cvg.de [IPv6:2003:49:a034:1067:5::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF23021C044
        for <linux-nfs@vger.kernel.org>; Tue, 29 Mar 2022 07:41:06 -0700 (PDT)
Received: from mail-mta-2.intern.sigma-chemnitz.de (mail-mta-2.intern.sigma-chemnitz.de [192.168.12.70])
        by mail-out-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 22TEf39Y124658
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 29 Mar 2022 16:41:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
        s=v2012061000; t=1648564863;
        bh=MxgqZ3RBmRu2b3ArrTpt1l8xf7CJk1YTDBLdPHl5+b4=; l=479;
        h=From:To:Cc:Subject:References:Date:In-Reply-To;
        b=P/iIJUtwBr86LD/sM4b557H9r5ilca3xHtcw6Q47EYfdWhQZSlatYmSCrjOYiJ5GC
         wzHrkr2kYujI7NI+OxbIVx74Rb93+/y13PXoEaO5INULadhA4G0gldKNvAOPFkW3KQ
         nInEXvgXU6LtSijDMihn2jlwCHVABKAezkwRhBRM=
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.sigma.local [192.168.16.32])
        by mail-mta-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 22TEf1UA165008
        for <linux-nfs@vger.kernel.org> from enrico.scholz@sigma-chemnitz.de; Tue, 29 Mar 2022 16:41:02 +0200
Received: from mail-msa-2.intern.sigma-chemnitz.de ( [192.168.12.72]) by reddoxx.intern.sigma-chemnitz.de
        (Reddoxx engine) with SMTP id 1420D173BAE; Tue, 29 Mar 2022 16:41:01 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de (ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
        by mail-msa-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 22TEf00J121784
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 29 Mar 2022 16:41:01 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim 4.94.2)
        (envelope-from <ensc@sigma-chemnitz.de>)
        id 1nZD1o-000qJr-Bp; Tue, 29 Mar 2022 16:41:00 +0200
From:   Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Random NFS client lockups
References: <lyr172gl1t.fsf@ensc-virt.intern.sigma-chemnitz.de>
        <lysfrhr51i.fsf@ensc-virt.intern.sigma-chemnitz.de>
        <fd4d017808a5ff9492fc6dfce8506f64e600fb35.camel@hammerspace.com>
        <lyilsd8sfi.fsf@ensc-virt.intern.sigma-chemnitz.de>
        <800eb7d5daf7f59548645b1a310d2ba7993ba8af.camel@hammerspace.com>
        <lybky45n7h.fsf@ensc-virt.intern.sigma-chemnitz.de>
Date:   Tue, 29 Mar 2022 16:41:00 +0200
In-Reply-To: <lybky45n7h.fsf@ensc-virt.intern.sigma-chemnitz.de> (Enrico
        Scholz's message of "Thu, 17 Mar 2022 21:38:26 +0100")
Message-ID: <lyzgl8rfcz.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Enrico Scholz <enrico.scholz@sigma-chemnitz.de> writes:

>> Can you please try the attached patch and see if it helps?
>
> Thanks; I applied the patch and it runs without problems so far.  It
> fixes the connect-close race very likely.  I hope, this was the reason
> for the lockups but it is too early to confirm as they usually take 1-2
> days before they occur.

Client runs now for >10 days without seeing the lockups or other
regressions.


Thanks again
Enrico
