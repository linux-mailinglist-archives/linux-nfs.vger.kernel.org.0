Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659F67EE6F8
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 19:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjKPSqW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 13:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKPSqV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 13:46:21 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEABFD49
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 10:46:17 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b5ff072fc4so664315b6e.3
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 10:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700160377; x=1700765177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+G3Thi9QyaCj6G+9c//7y8tpV11xzrqy7tArsUAiXA=;
        b=Zw1VCBY1r+zGu9M6JFNK6NZm9cwJTPF306Ly0oXrhXW8WotYpjix2J7T/hfgR5Ogt5
         V9ofn7co3oYRzpIqPTSfQouAdMhKSCGwa8uR/BIQtNCvlbNQdZtqHDOy6erM839pHSfI
         7NumeX0z1vC8zMSIWr00Jgf06SgzWx4g3vuWhdqhRZQ//tQCHIWuJKmvwQCsOe7LYE3G
         yWYGekCQJDMUf8b0hkAPiHOH8h+ue6197JJqnagxlZpx2pzv09hx2tDW7agQV5R8olAg
         viAVvXuuyqmbbG2rY1NDaTlW7P1lqtUo+mmWVKMQNitNFBj2JHyd3A4mtAYgkSXbs79E
         8d/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700160377; x=1700765177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+G3Thi9QyaCj6G+9c//7y8tpV11xzrqy7tArsUAiXA=;
        b=cMHPnQRnL5KVE+xueZrpM60kRgTbD//y+8y2yL6U1zuMrbVJlv4kgwi2Hf+7IP4D0f
         qfFiOutYh2V5epjvvxWBFbU8QViY4KRqYnRQyL/z0V4lt5b7u7j85bscmnMsnZl9bSR5
         9kFIe0Zy933y1vpO0Lqj6M2zSw5wm1X8wcajPLVRdVpjwkA5dGwfpf8V5UeHoKSzUsh6
         OwCf4lI+y4+mEABHO6kL/4/K0IiSqQ18OyEHffqzZKBTRDdyVImcZduPkW9jH4eIIw8r
         ot5M/XhcOdLCNyTHg3YKfvnRHpptzi9AzCHM1PT2TTfqtys5L/oVaaLJne7hgYUrUK/r
         W4og==
X-Gm-Message-State: AOJu0YyMGY2rHApTasOxngFF/qOQbkyMjWkEbKx8b0D0inPXCUwbzeG+
        YbsBvkQId/cUHrz4TSocAyg0pGWXdrt6YZ2AHD8k
X-Google-Smtp-Source: AGHT+IGAfgdZtmxubZhWLgb4REHHB7a+iMS46HjHd0YyX0scqg/dVHmKFiBP9iP4hjqFVyXuUq7chZhRosvMyhNi/Qo=
X-Received: by 2002:a05:6358:52ce:b0:16b:c486:c315 with SMTP id
 z14-20020a05635852ce00b0016bc486c315mr12386060rwz.3.1700160377054; Thu, 16
 Nov 2023 10:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20231107134012.682009-11-roberto.sassu@huaweicloud.com>
 <231ff26ec85f437261753faf03b384e6.paul@paul-moore.com> <b0f6ece6579a5016243cca5c313d1a58cae6eff2.camel@huaweicloud.com>
In-Reply-To: <b0f6ece6579a5016243cca5c313d1a58cae6eff2.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Nov 2023 13:46:06 -0500
Message-ID: <CAHC9VhSkomRmz9OQGaQ=4Ni=B+UEO=SLUtDtv7X_kbTSam=h=w@mail.gmail.com>
Subject: Re: [PATCH v5 10/23] security: Introduce inode_post_setattr hook
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, mic@digikod.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 16, 2023 at 4:44=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Wed, 2023-11-15 at 23:33 -0500, Paul Moore wrote:
> > On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> > >
> > > In preparation for moving IMA and EVM to the LSM infrastructure, intr=
oduce
> > > the inode_post_setattr hook.
> > >
> > > At inode_setattr hook, EVM verifies the file's existing HMAC value. A=
t
> > > inode_post_setattr, EVM re-calculates the file's HMAC based on the mo=
dified
> > > file attributes and other file metadata.
> > >
> > > Other LSMs could similarly take some action after successful file att=
ribute
> > > change.
> > >
> > > The new hook cannot return an error and cannot cause the operation to=
 be
> > > reverted.
> > >
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> > > ---
> > >  fs/attr.c                     |  1 +
> > >  include/linux/lsm_hook_defs.h |  2 ++
> > >  include/linux/security.h      |  7 +++++++
> > >  security/security.c           | 16 ++++++++++++++++
> > >  4 files changed, 26 insertions(+)
> >
> > ...
> >
> > > diff --git a/security/security.c b/security/security.c
> > > index 7935d11d58b5..ce3bc7642e18 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -2222,6 +2222,22 @@ int security_inode_setattr(struct mnt_idmap *i=
dmap,
> > >  }
> > >  EXPORT_SYMBOL_GPL(security_inode_setattr);
> > >
> > > +/**
> > > + * security_inode_post_setattr() - Update the inode after a setattr =
operation
> > > + * @idmap: idmap of the mount
> > > + * @dentry: file
> > > + * @ia_valid: file attributes set
> > > + *
> > > + * Update inode security field after successful setting file attribu=
tes.
> > > + */
> > > +void security_inode_post_setattr(struct mnt_idmap *idmap, struct den=
try *dentry,
> > > +                            int ia_valid)
> > > +{
> > > +   if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> > > +           return;
> >
> > I may be missing it, but I don't see the S_PRIVATE flag check in the
> > existing IMA or EVM hooks so I'm curious as to why it is added here?
> > Please don't misunderstand me, I think it makes sense to return early
> > on private dentrys/inodes, but why aren't we doing that now?
>
> My first motivation was that it is in the pre hooks, so it should be in
> the post hook as well.
>
> Thinking more about it, suppose that the post don't have the check,
> private inodes would gain an HMAC without checking the validity of the
> current HMAC first (done in the pre hooks), which would be even worse.
>
> So, my idea about this is that at least we are consistent.
>
> If IMA and EVM should look at private inodes is a different question,
> which would require a discussion.

As I said above, I can understand why having the IS_PRIVATE() macro
check might be a good idea, I am just concerned that the current
IMA/EVM hooks don't check for S_PRIVATE and thus moving to this new
LSM hook would potentially be a change in behavior (like I said, I
could be missing a subtle detail).  I'd just like a quick confirmation
from Mimi that either there is no difference because of X, or she is
aware of the difference and is okay with it.  It's very possible she
is fine with it, she did provide her 'Reviewed-by', but I worry this
is the sort of thing that might have gone unnoticed during review.

--=20
paul-moore.com
