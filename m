Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F88251B7F2
	for <lists+linux-nfs@lfdr.de>; Thu,  5 May 2022 08:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244315AbiEEG35 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 May 2022 02:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244337AbiEEG34 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 May 2022 02:29:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340061A049
        for <linux-nfs@vger.kernel.org>; Wed,  4 May 2022 23:26:17 -0700 (PDT)
Date:   Thu, 5 May 2022 08:26:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651731974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lElSnvPoDr4apsvMtWFl3WqB8Lr+4R59Bz+dhdQx418=;
        b=liP6O2E1NdTnP6Ur1YVFjI9rwEgWmYupyJPBMXiBGOWPwDxfSKZd9XfafegXCqRJL90E6Q
        P/sjLVA7k2yebXf/d9hv3BquL3MjDMO6fzoc6YEE2rx0Uero/UzqlufIR4+NG2QjX5hALh
        NZCYT4ER27+hOSLYcPJXR+UeC15O+cZvjOubygCkmIVBDU+d7sAmx2J09jh0sX3vwv+PNC
        Ttg9MLKqtChO8uNTpqF9r7d2XXL4g90/HvnpKqlodE5X86bW+h8SyMqdSdCb7AoFio4gsB
        iPdEvaNTp+aILZU/ebdmnhN5N6BDhc2D0ONGG4n3h8BCpC0RzXSEn2vtu31+dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651731974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lElSnvPoDr4apsvMtWFl3WqB8Lr+4R59Bz+dhdQx418=;
        b=GLcuvbwEmCFcetNN/SYkcvNScEAoYhPyWn8pOD6LRE4LxSrmbN715zLJIAbnuSVOiArDoi
        4qSuj+KddON8sgCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH] SUNRPC: Don't disable preemption while calling
 svc_pool_for_cpu().
Message-ID: <YnNuBbh278TOJ81z@linutronix.de>
References: <YnK2ujabd2+oCrT/@linutronix.de>
 <C4463E0E-2886-47A2-B915-A008C35343A5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <C4463E0E-2886-47A2-B915-A008C35343A5@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2022-05-05 03:19:57 [+0000], Chuck Lever III wrote:
>=20
> Sebastian, I will have a closer look in a few days. Meanwhile, if I=E2=80=
=99m
> reading the patch description right, this is a bug fix. Was there a
> lockdep splat (ie, how did you find this issue)? Does it belong in
> 5.18-rc? Should it have a Fixes: tag?

It is a bugfix for PREEMPT_RT and I'm posting this as part of getting
PREEMPT_RT merged upstream. This is already fixed in the PREEMPT_RT
queue.=20
There is no need to get this merged in the current -rc series since
!PREEMPT_RT is not affected. Next release is fine.

Sebastian
