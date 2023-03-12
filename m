Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4255E6B686D
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Mar 2023 17:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjCLQvs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Sun, 12 Mar 2023 12:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjCLQvr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Mar 2023 12:51:47 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3998B3E613
        for <linux-nfs@vger.kernel.org>; Sun, 12 Mar 2023 09:51:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 09FA86431C3A;
        Sun, 12 Mar 2023 17:51:43 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HYstGY0lt6ze; Sun, 12 Mar 2023 17:51:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id AB2986431C39;
        Sun, 12 Mar 2023 17:51:42 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VhU1ZKaYtOGF; Sun, 12 Mar 2023 17:51:42 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 906E0608F44F;
        Sun, 12 Mar 2023 17:51:42 +0100 (CET)
Date:   Sun, 12 Mar 2023 17:51:42 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
Message-ID: <404384146.237438.1678639902506.JavaMail.zimbra@nod.at>
In-Reply-To: <ecfe32fc-f547-ca7f-dc07-018af4d23f39@redhat.com>
References: <1497292229.221220.1678287959937.JavaMail.zimbra@nod.at> <655a8ee6-dd94-effd-738a-9ce8db8ebed7@redhat.com> <156604342.233758.1678553565027.JavaMail.zimbra@nod.at> <31643f88-26ec-515c-d1d6-fad951248a8c@redhat.com> <1826031117.236924.1678628160815.JavaMail.zimbra@nod.at> <ecfe32fc-f547-ca7f-dc07-018af4d23f39@redhat.com>
Subject: Re: mountd: Possible bug in next_mnt()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: mountd: Possible bug in next_mnt()
Thread-Index: wocOLM+GHMEzj1fvYhC4rhW6Kianrw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

----- Ursprüngliche Mail -----
>> Well, the goal of my mail was not sending a ready-to-apply patch.
>> It was a question. To me next_mnt() looks wrong but I'm not sure whether
>> the current handling of "/" is desired for some special case I'm not aware of.
>> 
>> I'll happily send a patch after we agree that next_mnt() is wrong.
> I'm still trying to reproduce problem... I have
> 
> /etc/nfs.conf: rootdir=/export
> 
> /etc/exports:
> /home *(rw,sec=sys:krb5:krb5i:krb5p)
> /tmp *(rw,fsid=666,all_squash)
> / *(rw,fsid=root,all_squash)
> 
> I'm not seeing the problem... Where does the crossmount come in?

Chris reported the problem to me while he was testing my re-export/crossmount patches.
I can try reproducing without re-exporting later.

In theory you should see the problem as follows:

1. Have rootdir=/export in your nfs.conf
2. /export is some filesystem that contains more mounts
3. /export/fs1 is a different filesytem
4. /export/fs2 is a different filesytem too
5. /etc/exports contains: / *(rw,fsid=root,all_squash,crossmount)

Client mounts / to /nfs and then tries to access /nfs/fs1.
Then nfsd_fh() iterates over all exports, finds one with NFSEXP_CROSSMOUNT set.
Using next_mnt() it finds possible sub-mounts. But for the "/" case next_mnt()
returns none -> nfsd_fh() fails -> client cannot enter /nfs/fs1.

Thanks,
//richard
