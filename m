Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7EF5992E9
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Aug 2022 04:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344070AbiHSCHO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Aug 2022 22:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343685AbiHSCHO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Aug 2022 22:07:14 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EC9D25D7
        for <linux-nfs@vger.kernel.org>; Thu, 18 Aug 2022 19:07:12 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id c185so3430649oia.7
        for <linux-nfs@vger.kernel.org>; Thu, 18 Aug 2022 19:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7FnofYSJQVqMcwObKiPoclmUUgog9bhmYO53YPglp1g=;
        b=GX8kGc2VNDTD33NJ/fvEi1ucSQdLqQ7hwf5zCrmTGt4qPXCTu/n1o61/RVTMAy1TKM
         sI/ZErSSKKeTEfTy7gW5ozAX4kYZ9gdaOMpYknqrUzd2hYTodMJ/a0GVQic7Y46Lz+a3
         o74vy6ZRtANrFfDTVPP616J23XshowlWQD0IUNT5mfUv6Hux8r3eJ+N48x1k1hSmB+mU
         oEfs07GB24v+owqIGmgGwhL0wc5CZX6TJ6/VDf/Up6Qnw4UYisHDbWm/db0ROUF4nsfw
         h0xKbWmRPyl/ZvzL2IFxirIOJnAdRWwN94r5wap/LAacMya0Bx0cHcilqULYlyUGY/Hj
         mUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7FnofYSJQVqMcwObKiPoclmUUgog9bhmYO53YPglp1g=;
        b=nDbaaMiqLfc0ssscaqWBWNDlcxXRkwIw/6Bf1nPMBFkI+ksycDc1o0nf9mXab7wLzC
         cNoPSic+6yZBGpGWMbr/UQLEaSuke3/r1Aei1y7E2SfE9et1YJd132vJtR+yJShR8ew7
         6Ut7aAbxcZ843T0Fut1CVpvWwAAS0ftcAIcjXklMzF2KFcSM1UI0YKLWSXYaEy3asiAu
         4nufDEbcOvYCQfrXYAI61X9RzErZYgdebsxF+HkH9duvEIJWC/XdYbd4auNFrrfdjejT
         6jO/Essh0l/gVQjt8eg9dT8LujU6FOz+Gl29kNkFCT8cB80NBIr7BWMMrNwrvMdb+NfT
         5jUw==
X-Gm-Message-State: ACgBeo3Z/OW8rkxbiAFk9K0WDHJpmjZtol3a13kPbgZAe9VOGLebhx39
        59W14lqzhdbm0nEYwysOIp3UW8KACStSfSToiiiH
X-Google-Smtp-Source: AA6agR6cj8VSpjI/zApuASeCp69SrwPgQ8cO+N+6GBvKR4OZOomr/8/vSNzS2f2WUZvq2z45LGjtxYHiuXLI20C0OyI=
X-Received: by 2002:aca:b7d5:0:b0:343:c478:91c6 with SMTP id
 h204-20020acab7d5000000b00343c47891c6mr2523807oif.136.1660874831825; Thu, 18
 Aug 2022 19:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <165970659095.2812394.6868894171102318796.stgit@warthog.procyon.org.uk>
 <CAFqZXNv+ahpN3Hdv54ixa4u-LKaqTtCyjtkpzKGbv7x4dzwc0Q@mail.gmail.com>
 <CAHC9VhTpqvFbjKG5FMKGRBRHavOUrsCSFgayh+BNgSrry8bWLg@mail.gmail.com> <2026286.1660828477@warthog.procyon.org.uk>
In-Reply-To: <2026286.1660828477@warthog.procyon.org.uk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Aug 2022 22:07:01 -0400
Message-ID: <CAHC9VhSVRgSK_ShwShcYnnDOg+mR0V9WEodVmJ=c5_UzK3KLiQ@mail.gmail.com>
Subject: Re: [PATCH v3] nfs: Fix automount superblock LSM init problem,
 preventing sb sharing
To:     David Howells <dhowells@redhat.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        dwysocha@redhat.com,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 18, 2022 at 9:14 AM David Howells <dhowells@redhat.com> wrote:
> Paul Moore <paul@paul-moore.com> wrote:
>
> > I guess my question is this: for inodes inside the superblock, does
> > their superblock pointer point to the submount's superblock, or the
> > parent filesystem's superblock?
>
> They have to point to the submount superblock.  Too many things would break, I
> think, if inode->i_sb pointed to the wrong place.  As far as the VFS is
> concerned, apart from the way it is mounted, it's a perfectly normal
> superblock.

If the submount inodes point back to the submount's superblock then it
seems reasonable that the rootcontext should remain unset to me.

-- 
paul-moore.com
