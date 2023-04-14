Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28366E2421
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Apr 2023 15:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjDNNSH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Apr 2023 09:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDNNSG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Apr 2023 09:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39A413A
        for <linux-nfs@vger.kernel.org>; Fri, 14 Apr 2023 06:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681478242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bl5CykRMZhAhKzWq0hTBe7uu2r1EpOUA3ikJ3QXm9Fs=;
        b=hQKmSg6ig4c37jgUIAZo1bm8amlAN3YIjp1bsv/Mp5eLtlupv682nhKopLFYAaJZ1FTM/p
        rF/h8UBFGnHcSccdZKRIEA4ob6kG1RzBHiFmnVEN/6Ua/hQbNNA4OE06eFXQ7wohE7hsEY
        9ADSz9hwMnwuaBSmM1XOjHrfE0lJEtM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-jM8rj_MvMGKYaZq_5RXbpQ-1; Fri, 14 Apr 2023 09:17:21 -0400
X-MC-Unique: jM8rj_MvMGKYaZq_5RXbpQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2473661358eso190356a91.1
        for <linux-nfs@vger.kernel.org>; Fri, 14 Apr 2023 06:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681478240; x=1684070240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bl5CykRMZhAhKzWq0hTBe7uu2r1EpOUA3ikJ3QXm9Fs=;
        b=QY2Vba36P4tN2CFPVP8Y2Y/BYnqBs9TSfvQB5AKRCh75my+72vxabl2h3CfMJPmoYd
         UtVvhEo/CDmef4SfoYS62hO00Tod8Y0mYPJtHPp6/7Vr7EMTCRrlWRHegB0ufYlDV1qb
         97USw8SWKAIgMftHf0SBjZmqkRKioUfGAflzkN+kOJUbUghCp7G6jzVDFytCUfarlNvf
         8qyPVeldF0DdNnXNBSNgZVFOX/SlTVqluI7bS7ya9kW/b+ztQiIv2DxKJNAyGlA4joz2
         CYqDI49apw3q32r9quAKRmJ5ODc4hebxZGG1HAxBwdzT0DLyhBOQKYHd6fCGe9io30Pw
         MMPQ==
X-Gm-Message-State: AAQBX9cqqTtLjs9U5McwwgZBHtn91UD/CWXPCExchjhi31bBdFxPwKg3
        KJX7QJUdLynunxI+OO942w7yYWyNtxD51uXNDFUFCW7vagR8OOTtAb87sD4t25HiTEpghyutNrV
        ldNi7/4J6gARwW0gLjrLcBJ5LKir4eS/6g5cu
X-Received: by 2002:a05:6a00:1946:b0:63a:fefa:6cc9 with SMTP id s6-20020a056a00194600b0063afefa6cc9mr3078573pfk.2.1681478240421;
        Fri, 14 Apr 2023 06:17:20 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y4qd1bBj8owZmmZRVlehZ/QnrEY2G6TKuXp3/MjTR91YiCvj4RwGD7WWvmQyWFSMAusEdJkRHyI8/wkfKbJPI=
X-Received: by 2002:a05:6a00:1946:b0:63a:fefa:6cc9 with SMTP id
 s6-20020a056a00194600b0063afefa6cc9mr3078559pfk.2.1681478240141; Fri, 14 Apr
 2023 06:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org> <20230414023211.GE3390869@ZenIV>
In-Reply-To: <20230414023211.GE3390869@ZenIV>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 14 Apr 2023 09:16:43 -0400
Message-ID: <CALF+zOnbBf01ThYyv2sByyjBJww6pbkza93ixb1Vdh4i3B1+BQ@mail.gmail.com>
Subject: Re: allowing for a completely cached umount(2) pathwalk
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, NeilBrown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Apr 13, 2023 at 10:34=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Thu, Apr 13, 2023 at 06:00:42PM -0400, Jeff Layton wrote:
>
> > It describes a situation where there are nested NFS mounts on a client,
> > and one of the intermediate mounts ends up being unexported from the
> > server. In a situation like this, we end up being unable to pathwalk
> > down to the child mount of these unreachable dentries and can't unmount
> > anything, even as root.
>
> So umount -l the stuck sucker.  What's the problem with that?
>

Speaking in the context of the original reproducer:
This does work if you "umount -l /A" - the underlying "/A" mount,
but not if you do "umount -l /A/B" (both have lost their access on
the server).

The problem with this is IMO, it is not very intuitive to lazy unmount
the root of a whole tree like that.  Also, the customer's case was autofs,
and I don't think autofs does this, it tries to umount the children
first and gets stuck there in this scenario.

But overall yes it does make sense, IMO.

> > 2/ disallow ->lookup operations: a umount is about removing an existing
> > mount, so the dentries had better already be there.
>
> That changes the semantics; as it is, you need exec permissions on the
> entire path...
>
> > Is this a terrible idea? Are there potentially problems with
> > containerized setups if we were to do something like this? Are there
> > better ways to solve this problem (and others like it)? Maybe this woul=
d
> > be best done with a new UMOUNT_CACHED flag for umount2()?
>
> We already have lazy umount.  And what will you do to symlinks you run
> into along the way?  They *are* traversed; requiring the caller to
> canonicalize them will only shift the problem to userland...
>

