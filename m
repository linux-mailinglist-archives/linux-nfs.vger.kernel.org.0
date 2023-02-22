Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8536169EFA1
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Feb 2023 08:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjBVHxw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Feb 2023 02:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjBVHxt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Feb 2023 02:53:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08D92887A
        for <linux-nfs@vger.kernel.org>; Tue, 21 Feb 2023 23:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677052387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ljX43G0wEY8L63/ppMMsMkg7cRFEwM1I5WynBYgGF5o=;
        b=NFkmYfVtY4qumxZ2cRlcFY1DridgmvvdtkNevmfXWSEZyI/NleE89w8lRYiapucU6/NVQv
        JOpAo1jj1DOs2WF4LY4WsEIvjpS8UZwUwo9DMcf02/CXstu6wZnULWIGYG/fsJHwYkJMAx
        insKHFnCHeyjEmoVblK+mvA/5OsMFlI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-220-cS54Vf-dNlKdM1di790zEw-1; Wed, 22 Feb 2023 02:53:06 -0500
X-MC-Unique: cS54Vf-dNlKdM1di790zEw-1
Received: by mail-pf1-f199.google.com with SMTP id be12-20020a056a001f0c00b00593e2189278so3025886pfb.19
        for <linux-nfs@vger.kernel.org>; Tue, 21 Feb 2023 23:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677052385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljX43G0wEY8L63/ppMMsMkg7cRFEwM1I5WynBYgGF5o=;
        b=YvJbfXqVqgsrs5WTqoiQHLyZiFs2oIYfkWVKKdI0R3dK09mTA8ZnTgzpDCmYok2tZt
         uamg0JTizjDdA9sNfzdIygDMSrAbxsMKnSrCqth4DSJdi5sn14lXjthmsIheAfPXUzpg
         bf52egGO92hktTO230J5tcEQYbN0KYlXRDC7j3ChwlKrKE/DT/MqzQbqL11A8Bp3r+Zb
         f7Qeq1Msv2kWMXtXJIb2rpLazDcUxhi4U0RbJdrqLoMyu+ggVrpX9MJ1mnmg1GNhSE8/
         eykUQeEoFh5bXPk8vdyfAPYSCTvDuwX6KdxxSedLPqnl0SI/W8l9w/lyLR78hJPqxeKj
         lZyA==
X-Gm-Message-State: AO0yUKXPwIdEjDMWV93H4j61sF+CrJRMpTSljLukZGn5f7Vhee9iyPzt
        J0titdzy6GfY3SKIMJCoY5GJa8KqSvMVjevkwCaIFI+sZhjdnMneajnFGUa38ZtKjmYlcNIHQLC
        CON0Y4WJm5zAvE85O82vU/VRr5nvRWAkpiFHp
X-Received: by 2002:a62:e906:0:b0:5a8:c0e0:3b2 with SMTP id j6-20020a62e906000000b005a8c0e003b2mr1331080pfh.45.1677052385599;
        Tue, 21 Feb 2023 23:53:05 -0800 (PST)
X-Google-Smtp-Source: AK7set/h+aPFUm4SbrYbWk3iTTUpShGxZ6VUSjD4ik+PIQ2xgY3zYr2/zd6r5vbnkirTo15iRgIAj/K7nLMGyrknNUw=
X-Received: by 2002:a62:e906:0:b0:5a8:c0e0:3b2 with SMTP id
 j6-20020a62e906000000b005a8c0e003b2mr1331073pfh.45.1677052385289; Tue, 21 Feb
 2023 23:53:05 -0800 (PST)
MIME-Version: 1.0
References: <20230210145823.756906-1-omosnace@redhat.com> <63f500ba.170a0220.c76fc.1642@mx.google.com>
 <Y/U5X5F0iFcpLwRK@bombadil.infradead.org>
In-Reply-To: <Y/U5X5F0iFcpLwRK@bombadil.infradead.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 22 Feb 2023 08:52:53 +0100
Message-ID: <CAFqZXNtK=y=V9_R0PWh1svkKzkotEtUiH-o2whWy=TdYiqfLCg@mail.gmail.com>
Subject: Re: [PATCH] sysctl: fix proc_dobool() usability
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 21, 2023 at 11:04 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> On Tue, Feb 21, 2023 at 09:34:49AM -0800, Kees Cook wrote:
> > On Fri, Feb 10, 2023 at 03:58:23PM +0100, Ondrej Mosnacek wrote:
> > > Currently proc_dobool expects a (bool *) in table->data, but sizeof(int)
> > > in table->maxsize, because it uses do_proc_dointvec() directly.
> > >
> > > This is unsafe for at least two reasons:
> > > 1. A sysctl table definition may use { .data = &variable, .maxsize =
> > >    sizeof(variable) }, not realizing that this makes the sysctl unusable
> > >    (see the Fixes: tag) and that they need to use the completely
> > >    counterintuitive sizeof(int) instead.
> > > 2. proc_dobool() will currently try to parse an array of values if given
> > >    .maxsize >= 2*sizeof(int), but will try to write values of type bool
> > >    by offsets of sizeof(int), so it will not work correctly with neither
> > >    an (int *) nor a (bool *). There is no .maxsize validation to prevent
> > >    this.
> > >
> > > Fix this by:
> > > 1. Constraining proc_dobool() to allow only one value and .maxsize ==
> > >    sizeof(bool).
> > > 2. Wrapping the original struct ctl_table in a temporary one with .data
> > >    pointing to a local int variable and .maxsize set to sizeof(int) and
> > >    passing this one to proc_dointvec(), converting the value to/from
> > >    bool as needed (using proc_dou8vec_minmax() as an example).
> > > 3. Extending sysctl_check_table() to enforce proc_dobool() expectations.
> > > 4. Fixing the proc_dobool() docstring (it was just copy-pasted from
> > >    proc_douintvec, apparently...).
> > > 5. Converting all existing proc_dobool() users to set .maxsize to
> > >    sizeof(bool) instead of sizeof(int).
> > >
> > > Fixes: 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled")
> > > Fixes: a2071573d634 ("sysctl: introduce new proc handler proc_dobool")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > Ah nice, thanks for tracking this down.
> >
> > Acked-by: Kees Cook <keescook@chromium.org>
>
> Queued onto sysctl-next, will send to Linus as this is a fix too.

Thanks, Luis!

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

