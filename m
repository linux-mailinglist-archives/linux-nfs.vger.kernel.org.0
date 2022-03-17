Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C794DCF7A
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Mar 2022 21:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiCQUj4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Mar 2022 16:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiCQUjz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Mar 2022 16:39:55 -0400
Received: from smtpout-2.cvg.de (smtpout-2.cvg.de [IPv6:2003:49:a034:1067:5::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6074443E4
        for <linux-nfs@vger.kernel.org>; Thu, 17 Mar 2022 13:38:35 -0700 (PDT)
Received: from mail-mta-3.intern.sigma-chemnitz.de (mail-mta-3.intern.sigma-chemnitz.de [192.168.12.71])
        by mail-out-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 22HKcVM7010841
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Thu, 17 Mar 2022 21:38:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
        s=v2012061000; t=1647549511;
        bh=l2kGD8+E1qtGN+8wSu9y39iWN/ZX7eqP4L3yK0oe28I=; l=618;
        h=From:To:Cc:Subject:References:Date:In-Reply-To;
        b=gVBs8k48xKGkYkSGae3vj4AWquFrYsBb4iCOCycaN/raAbH8zLsamBee0f55/mTdy
         /1fkkdgS7s8Sn1yox+/YOqyXSSdQUrGk2jhZfTqfypem3fUsL1T9Gjw10vfzr7Ul/r
         XiBDx1ib925RKUG19xcfnh8WwuhRCURWDmlEAdvg=
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.sigma.local [192.168.16.32])
        by mail-mta-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 22HKcSEX766059
        for <linux-nfs@vger.kernel.org> from enrico.scholz@sigma-chemnitz.de; Thu, 17 Mar 2022 21:38:29 +0100
Received: from mail-msa-3.intern.sigma-chemnitz.de ( [192.168.12.73]) by reddoxx.intern.sigma-chemnitz.de
        (Reddoxx engine) with SMTP id 2D04AD40B2A; Thu, 17 Mar 2022 21:38:27 +0100
Received: from ensc-virt.intern.sigma-chemnitz.de (ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
        by mail-msa-3.intern.sigma-chemnitz.de (8.15.2/8.15.2) with ESMTPS id 22HKcQV4270059
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 17 Mar 2022 21:38:27 +0100
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim 4.94.2)
        (envelope-from <ensc@sigma-chemnitz.de>)
        id 1nUwt8-009PIS-Az; Thu, 17 Mar 2022 21:38:26 +0100
From:   Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Random NFS client lockups
References: <lyr172gl1t.fsf@ensc-virt.intern.sigma-chemnitz.de>
        <lysfrhr51i.fsf@ensc-virt.intern.sigma-chemnitz.de>
        <fd4d017808a5ff9492fc6dfce8506f64e600fb35.camel@hammerspace.com>
        <lyilsd8sfi.fsf@ensc-virt.intern.sigma-chemnitz.de>
        <800eb7d5daf7f59548645b1a310d2ba7993ba8af.camel@hammerspace.com>
Date:   Thu, 17 Mar 2022 21:38:26 +0100
In-Reply-To: <800eb7d5daf7f59548645b1a310d2ba7993ba8af.camel@hammerspace.com>
        (Trond Myklebust's message of "Thu, 17 Mar 2022 03:05:46 +0000")
Message-ID: <lybky45n7h.fsf@ensc-virt.intern.sigma-chemnitz.de>
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

Trond Myklebust <trondmy@hammerspace.com> writes:

>> yes; but the client should reconnect (and does it in most cases).
>> Sometimes there seems to be a race which prevents the reconnect and
>> brings the client in a broken state.
>> 
>
> I didn't realise that you were seeing a long term hang.
> Can you please try the attached patch and see if it helps?

Thanks; I applied the patch and it runs without problems so far.  It
fixes the connect-close race very likely.  I hope, this was the reason
for the lockups but it is too early to confirm as they usually take 1-2
days before they occur.



Enrico
