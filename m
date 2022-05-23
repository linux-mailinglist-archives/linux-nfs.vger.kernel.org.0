Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE88F530AE4
	for <lists+linux-nfs@lfdr.de>; Mon, 23 May 2022 10:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiEWHxv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 23 May 2022 03:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiEWHxu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 03:53:50 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F70A1FA41
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 00:53:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8E136608110A;
        Mon, 23 May 2022 09:53:46 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 63bmoculaRcC; Mon, 23 May 2022 09:53:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0ED886081119;
        Mon, 23 May 2022 09:53:46 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O1maQPBDqJRu; Mon, 23 May 2022 09:53:45 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D53FF608110A;
        Mon, 23 May 2022 09:53:45 +0200 (CEST)
Date:   Mon, 23 May 2022 09:53:45 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     bfields <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>, david <david@sigma-star.at>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        anna schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
Message-ID: <1149772405.87856.1653292425664.JavaMail.zimbra@nod.at>
In-Reply-To: <20220502161713.GI30550@fieldses.org>
References: <20220502085045.13038-1-richard@nod.at> <20220502161713.GI30550@fieldses.org>
Subject: Re: [PATCH 0/5] nfs-utils: Improving NFS re-exports
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: nfs-utils: Improving NFS re-exports
Thread-Index: fhx8pCzjb2vRJNSIl8BuL+/2SLUokg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Bruce,

----- Ursprüngliche Mail -----
> Von: "bfields" <bfields@fieldses.org>
>> The whole set of features is currently opt-in via --enable-reexport.
> 
> Can we remove that option before upstreaming?

What is the final resolution regarding this option?
I can think of embedded/memory constraint systems where the dependency on SQLite
is not wanted.

On the other hand, with my latest patch, the plugin interface, the could be solved
too.

> For testing purposes it may makes sense to be able to turn the new code
> on and off quickly.  But for something we're really going to support,
> it's just another hurdle for users to jump through, and another case we
> probably won't remember to test.  The export options themselves should
> be enough configuration.
> 
> Anyway, basically sounds reasonable to me.  I'll try to give it a proper
> review sometime, feel free to bug me if I don't get to it in a week or
> so.

*kind ping* :-)

Please also don't forget the kernel side of this work. It is small but still needed.
See: https://lore.kernel.org/linux-nfs/20220110184419.27665-1-richard@nod.at/
or
https://git.kernel.org/pub/scm/linux/kernel/git/rw/misc.git/log/?h=nfs_reexport_clean

Since the kernel changes don't change the ABI, it should not really matter which part
is merged first. Kernel or userspace. The only important part is stating the right
kernel version in the nfs-utils manpages.

Thanks,
//richard
