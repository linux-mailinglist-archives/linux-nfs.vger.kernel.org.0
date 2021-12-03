Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F829467E98
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Dec 2021 21:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353557AbhLCUJT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Dec 2021 15:09:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36660 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1382982AbhLCUJS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Dec 2021 15:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638561953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UogtZCtOibb86QGhbKhrXQ6Fsq+EU4BpJKktzOUyQ1E=;
        b=exP1VdHk+ZiuTuCgyPNOsd3D/rVl16atRU7DSOs4m2WxD/IwGtpiPyK45/LvdRmwm/h5am
        QuD2R921Pp6TU7bS5jffNzL0dh5C90BseTWidf96DDMNJW9qHuAeIIVe6T7egH1HooOMpD
        ctw9a7mxQZ4w7Cb5IJNAfEyOBSie7oE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-485-mdSn4-kvOX-_aJg5_SJFmQ-1; Fri, 03 Dec 2021 15:05:52 -0500
X-MC-Unique: mdSn4-kvOX-_aJg5_SJFmQ-1
Received: by mail-ed1-f70.google.com with SMTP id y9-20020aa7c249000000b003e7bf7a1579so3502382edo.5
        for <linux-nfs@vger.kernel.org>; Fri, 03 Dec 2021 12:05:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UogtZCtOibb86QGhbKhrXQ6Fsq+EU4BpJKktzOUyQ1E=;
        b=UVHEp3J7XgISmaaUeVP3UJ3YKJOYKcSJdPxxUMejDUS08CWZ5szIGhUI/yz3IVApEs
         n2S5hncOTdrkXlFsarPT6lNgZbo5Awnhosniz/QsY69ygCElPTPNmFxaTuplKGXO4jsf
         W95GJlmrTbPEdm/VaSgLhXgbpJXsCnYEzYhPqPYpUSsM30eDf2y24lqcze2z8Rr++Qc9
         uXOg6MGwcWv3nL4Iase48kYdJvsWMdnOTmtam1NdurzlMfcVDjm9+QQeGnOX3aRg7lee
         Fx8zkDkFa7SaAlNOi9x5uMNBVOz0kz4DOy+mCEmdinDUeWMpgQTNZouxZjVVWzX6Ul9V
         +/qA==
X-Gm-Message-State: AOAM5311I68m3ZyfhADOyd+WZBkYlfs4dWSzymxZULJ1wqZKJOeAFPl4
        x/KSZsgNlfHSBc30mEW9faxMNjCHZ+vfnYyvY1LE6OWySVv0M0AbRG70WPbqARZxuLvY/GbPDt2
        W7zzVq86+vdCUPHjOJ4JsUVWtWWx/7TKalYJa
X-Received: by 2002:aa7:dad5:: with SMTP id x21mr5354543eds.280.1638561950808;
        Fri, 03 Dec 2021 12:05:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlp1T/X86rTKPau+Q6JByvOFX6EhN6/VXZUCJ+cMWioC8/Rt19U1rqSn361BU+0qAhhCYxJ78sGHxstIfS2O4=
X-Received: by 2002:aa7:dad5:: with SMTP id x21mr5354526eds.280.1638561950669;
 Fri, 03 Dec 2021 12:05:50 -0800 (PST)
MIME-Version: 1.0
References: <20211201085443.GA24725@kili> <CALF+zOkZgtfP7HrX4oP=qx2uKr3FTRHqECRqKGkRBZaz6F-jdg@mail.gmail.com>
 <997841.1638547576@warthog.procyon.org.uk>
In-Reply-To: <997841.1638547576@warthog.procyon.org.uk>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 3 Dec 2021 15:05:14 -0500
Message-ID: <CALF+zO=+1JV2JbXWL1zFjkWX=Rz-q93X0C7GTvng77U4LqT91w@mail.gmail.com>
Subject: Re: [bug report] nfs: Convert to new fscache volume/cookie API
To:     David Howells <dhowells@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 3, 2021 at 11:06 AM David Howells <dhowells@redhat.com> wrote:
>
> David Wysochanski <dwysocha@redhat.com> wrote:
>
> > >     29         if (*_len > NFS_MAX_KEY_LEN)
> > >     30                 return false;
> > >     31         if (x == 0)
> > > --> 32                 key[(*_len)++] = ',';
> > >     33         else
> > >     34                 *_len += sprintf(key + *_len, ",%llx", x);
> > >     35         return true;
> > >     36 }
> > >
> > > This function is very badly broken.  As the checker suggests, the >
> > > should be >= to prevent an array overflow.  But it's actually off by
> > > two because we have to leave space for the NUL terminator so the buffer
> > > is full when "*_len == NFS_MAX_KEY_LEN - 1".  That means the check
> > > should be:
> > >
> > >         if (*_len >= NFS_MAX_KEY_LEN - 1)
> > >                 return false;
>
> It shouldn't ever overflow the array.  The sprintf really shouldn't insert
> more than 18 chars (comma, 16 hex digits and a NUL), but the allocated space
> has a 24-char excess to handle that.
>
> Maybe I should use:
>
>         static inline unsigned int how_many_hex_digits(unsigned int x)
>         {
>                 return x ? round_up(ilog2(x) + 1, 4) / 4 : 0;
>         }
>
> from fs/cachefiles/key.c to determine how much space I'm actually going to
> use.
>
> Actually, I would very much rather not include the comms parameters if I can
> avoid it.  They aren't really something that distinguishes volumes on servers
> - they're purely a local phenomenon to distinguish local *mounts* made with
> different parameters (for which nfs has different superblocks!).
>

Brainstorming...

1. Use the nfs_server.s_dev (someone can lookup the mount from
/proc/self/mountinfo)
Maybe "%u:%u", MAJOR(sb->s_dev), MINOR(sb->s_dev)

2. Use a checksum on the parameters?

> David
>

