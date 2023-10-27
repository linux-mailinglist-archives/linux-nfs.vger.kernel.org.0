Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72387D9B5C
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 16:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345929AbjJ0O1u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 10:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345952AbjJ0O1t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 10:27:49 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24591DE;
        Fri, 27 Oct 2023 07:27:46 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-778a20df8c3so163573885a.3;
        Fri, 27 Oct 2023 07:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698416865; x=1699021665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXbUbK7JAE9A7HTRcV9zd4hClFZcd4gmsfJ+w0RwJf4=;
        b=MnmlCWj9iT4ySuec0pJEKyWRssgzVSpggCf83Hgsm+E62roF/baIoq27FrsBdyi9ZZ
         ANiinyw30hgqWWOVHnd8/pU7YK5PES31RzZ2e7fDx+KbvQQZxhtUu7GYKEp/TBFkjthq
         idb+RwyImN9PcSRP/UDohonHU+ERU1ZKAJ4e7VXQn5R9gmoqK4qkBNh5M5dmu3ED9azC
         Un+p1ff4L2N/a8xKu3nviLclPeF3GY+a87qJDwh6oVdkzc9F68nLqPpJXT6Iop7H46WB
         XT4GDVmZn6Psi79d1CZk+cTC3bRxPS5W7Bq383aDmO4RDYlp6exTWeFntWjUBzvAemWE
         1RSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698416865; x=1699021665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXbUbK7JAE9A7HTRcV9zd4hClFZcd4gmsfJ+w0RwJf4=;
        b=oPCC5DdJVe3addPeK1JYld4M3h9n0R/JXkP46RhJwofl9qHCWAIkjDHUaLwuG9fTSW
         4QxdqakOdrmeT5qx8z25GP1Eqz9PqIoQ69zsUOjNztaUVNgTVoKg7E5XF+cbxg0toTPs
         vaGEnm8vIO9Y7U56P8DGjWMIUgPdpL3Qk0wMjfDcTLJ1Z6judWwSPa65nE8GkrGVzBXB
         GqkiI1QXcl01GjE7LshhRraqXaRj72JB+VsKKesNrukIMWFEiKvbknx9Wp0NM2Rj4/dQ
         ych/AdzkQiU1SqYIneenYvXqaaVzOjGvj7JWoRPRNnOKdBtPu9+6J4qN3lSGSBASX2NU
         Cm3Q==
X-Gm-Message-State: AOJu0Yza4YZUmoSgLY3fOqt+OZjQ5wfpJBbS7QBg9ijy5uT/NPSGyXnt
        aTPDsI00V6V0pHx1YLGzKw0hsR6cPM8lC0f9cCw=
X-Google-Smtp-Source: AGHT+IH6iqx/gEZVJgXEqFhYngcKarhWB2bymHIjQTTNVm5XVws5kOoXp5ynhhZWF1h2RkGB7wtCn8FMrVOQy8Ncd0U=
X-Received: by 2002:a05:6214:1d0a:b0:66f:ba8f:39a9 with SMTP id
 e10-20020a0562141d0a00b0066fba8f39a9mr2891162qvd.8.1698416865139; Fri, 27 Oct
 2023 07:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231023180801.2953446-1-amir73il@gmail.com> <20231023180801.2953446-4-amir73il@gmail.com>
 <ZTtTEw0VMJxoJFyA@infradead.org> <CAOQ4uxj_R1KyYJqBXykCDUYZUEdXC3x0j1vZdOXsRcSb6dKaRg@mail.gmail.com>
 <ZTtnd6Lis8azPirM@infradead.org>
In-Reply-To: <ZTtnd6Lis8azPirM@infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 27 Oct 2023 17:27:33 +0300
Message-ID: <CAOQ4uxj-iFhfN8_80kAkY7Y4xUibO9mdcb=_LnO+zLUXzQw88w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] exportfs: define FILEID_INO64_GEN* file handle types
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 27, 2023 at 10:32=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Fri, Oct 27, 2023 at 09:43:01AM +0300, Amir Goldstein wrote:
> > > Presumable the same for fuse, but for that
> > > I'd need to look at how it works for fuse right now and if there's no=
t
> > > some subtle differences.
> > >
> >
> > There are subtle differences:
> > 1. fuse encodes an internal nodeid - not i_ino
> > 2. fuse encodes the inode number as [low32,high32]

Sorry, that's [hi32,lo32] as written in commit message.

> >
> > It cannot use the generic helper.
>
> That's what I almost feared.  It still should use the common symbolic
> name for the format just to make everyones life simpler.

That's what I thought.
This patch converts fuse to use the new defined FILEID_INO64*
constants.

I plan to send a followup patch to xfs to use the symbolic name
after this constant has landed in vfs.
It is going to be easier than collaborating the merges of xfs and vfs
and there is no reason to rush it.

Thanks,
Amir.
