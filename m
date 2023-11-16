Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD167EE6EB
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 19:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345464AbjKPSmF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 13:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345368AbjKPSmD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 13:42:03 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40101AD
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 10:41:59 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso1130466276.3
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 10:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700160119; x=1700764919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8WEQSBjc/MfcmSAT4ejxWpUPPmu2uF4kQuqYIUxqKA=;
        b=FiKuO3OLOxYWZbRS088GinMafw6uUbhXXcBbEO20j/tWQcRp1dAjcGC0q3VWHbhB8V
         IgOhkXjX93b/sNUO11ZBFkEvwNedL7qnxmRNq8+Lmtak4Wd6vU5oIh1nxChlzyB+777c
         KI1VVHgBL/FMURxjzqKp3C3+hk9kEhvXW3AiIvxLuE5pB6IqQK8J94ziLaRyh7TlZwcy
         XEXAeZJLLmUmWPxXxIxvhKJoYOJqX6l4aSIxzHCYGROeaNIN00/61kWhXRRKenbdbhvr
         SbI7Ogm+/7Ecr9H04YvmeQ1LocZQhDT8hDsVbn9v+TBniRbj7i1FKZU+ECrpXWudRxPr
         7wnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700160119; x=1700764919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8WEQSBjc/MfcmSAT4ejxWpUPPmu2uF4kQuqYIUxqKA=;
        b=Ze4Boddb25TwlV7l2OpI2DPp3KubbYs4zxDNAUKEiYLb30WpZaEe3agXbvIy2krD4d
         rGTtxUhNBdVO0OvvTI7KPbg7qdeQ4XWluVXgTf9PT0TTBBi0dml+QWMUf64fcpG+V5pU
         eRgGwcQVMzBDCpNtBzTGmkBrbwyofVh1+kbpB70yMY0o9HZew1toAQc6wueePDvsscn9
         hipX/DCqUXk5wfZOztfQKYV7CiJ8Zms9RzlMC9A9EIPHIpp8JwLFCaNAF/juqco53EoN
         skJKQ9sqb82XS3O+m5BrP5OCsuzBGg0H+AITMuXFDmc0yRctSascej76bvcIpOYtXHKf
         AemA==
X-Gm-Message-State: AOJu0YwVE3JHlZekX8q2VW/JDxZRsWIqi8VXSQVl28uMyTXgijrO1bYs
        7xo6VrJJxqMOcxi4hbPKL9zEEQWiL0YH2ih19YMD
X-Google-Smtp-Source: AGHT+IFrNERH99etoRYFFGcfGckM9eZr5jAdvP3Cqsg4T2YPSq7MZRtVHGkbsnW80wNaWxVnmZXI59XcmNXo2maxlb0=
X-Received: by 2002:a25:7688:0:b0:d9b:e043:96fa with SMTP id
 r130-20020a257688000000b00d9be04396famr15091479ybc.22.1700160118675; Thu, 16
 Nov 2023 10:41:58 -0800 (PST)
MIME-Version: 1.0
References: <20231107134012.682009-14-roberto.sassu@huaweicloud.com>
 <4f8c441e02222f063242adfbf4d733e1.paul@paul-moore.com> <5a7a675238c2e29d02ae23f0ec0e1569415eb89e.camel@huaweicloud.com>
In-Reply-To: <5a7a675238c2e29d02ae23f0ec0e1569415eb89e.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Nov 2023 13:41:47 -0500
Message-ID: <CAHC9VhR29VEybYHsx65E=-YYNLuLHOVm6BF2H==bEcrcHU7Ksg@mail.gmail.com>
Subject: Re: [PATCH v5 13/23] security: Introduce file_pre_free_security hook
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
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 16, 2023 at 4:47=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Wed, 2023-11-15 at 23:33 -0500, Paul Moore wrote:
> > On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> > >
> > > In preparation for moving IMA and EVM to the LSM infrastructure, intr=
oduce
> > > the file_pre_free_security hook.
> > >
> > > IMA calculates at file close the new digest of the file content and w=
rites
> > > it to security.ima, so that appraisal at next file access succeeds.
> > >
> > > LSMs could also take some action before the last reference of a file =
is
> > > released.
> > >
> > > The new hook cannot return an error and cannot cause the operation to=
 be
> > > reverted.
> > >
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > >  fs/file_table.c               |  1 +
> > >  include/linux/lsm_hook_defs.h |  1 +
> > >  include/linux/security.h      |  4 ++++
> > >  security/security.c           | 11 +++++++++++
> > >  4 files changed, 17 insertions(+)
> > >
> > > diff --git a/fs/file_table.c b/fs/file_table.c
> > > index de4a2915bfd4..64ed74555e64 100644
> > > --- a/fs/file_table.c
> > > +++ b/fs/file_table.c
> > > @@ -385,6 +385,7 @@ static void __fput(struct file *file)
> > >     eventpoll_release(file);
> > >     locks_remove_file(file);
> > >
> > > +   security_file_pre_free(file);
> >
> > I worry that security_file_pre_free() is a misleading name as "free"
> > tends to imply memory management tasks, which isn't the main focus of
> > this hook.  What do you think of security_file_release() or
> > security_file_put() instead?
>
> security_file_release() would be fine for me.

Okay, assuming no objections for anyone else let's go with that.
Thanks for indulging my naming nitpick :)

--=20
paul-moore.com
