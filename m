Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334BE1DC708
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 08:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgEUG26 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 02:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbgEUG25 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 02:28:57 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D0EC061A0E
        for <linux-nfs@vger.kernel.org>; Wed, 20 May 2020 23:28:56 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id p4so2587099qvr.10
        for <linux-nfs@vger.kernel.org>; Wed, 20 May 2020 23:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbear-xyz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XcQ706mnkEUUcBhpxWy4uMZE46OzXR5MKbNg5tOP08M=;
        b=slNA0LMVAH2uhsQP/DitPkZcZcs6y2T94XBE5xB4eOjuTKqBVtEvgxTfKLutP7h1jx
         xvPuVuKrAPtoRR/3s2qC9s5dcZn2Ty+lQn5/rre1f33Tbs/DT6ZbD7GlgdIQLPeGtY99
         2J52amdnIZYeTNeqUTyuJbGix4g+AZPVIrh/d16iL9fzsGMSvy4IDlsFI/jdXEMf6lyK
         qH2ba6N52boFXUkGBgVMYa8GcFQWjVAmvzvQile2FK5886nYKKyRoxu6pIq539KxDnwv
         RadnSlXdzsQ9CjV2ZbgqeObhrgnk5Ia8GNK4F0kE9/QEhSs6wOsXJVTBlPdj+h6y10ND
         9lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XcQ706mnkEUUcBhpxWy4uMZE46OzXR5MKbNg5tOP08M=;
        b=Mf372mBZZrlemXQIqJO81FO4KeONjcXuM/K/6qk977D6DN0+LLq4h1kpnjJA62rzOh
         /TMWGEjdx7Xjl7ulE10Yttldp4T7dVEEfaSaJ4nyQZdHtg7zrfgnQXiINa0nX44O3dkW
         1qePvKP/Z9CIOSnt68AbmYIY5as3H18mWF2LZktSB+7+jfHbp3b22xXByH65pdpMD0qH
         IeGCKmyNLq7SAyJqfmVokCA14k6n5vTPTwNhX58ne4OYJlXyv0GjK1V756Hs262gCxKT
         eyM7RAxTeJPaVosj82s3VYUmem3Um3Vlug05R5xb6O/fN0VrLov0VXcM9y8XVM8u1qIj
         WC/A==
X-Gm-Message-State: AOAM530jbNDBzK/HvQBBuG9fW2pScUDJtu3Jk0VmzB3apeAER0o7c1l4
        uM5vyFJl7fsfuR4zLgJHaA9a4HqU3Ps9Ud+zu/cePZJB
X-Google-Smtp-Source: ABdhPJw6tB8DyPWfRUV1IT5oyd00LeUvUo1qjMTiw14xaGRpJu3Fiyg26kBvhwpO3sl2Q5Th6ycWcJ2KA+WCxuCck0k=
X-Received: by 2002:ad4:4d03:: with SMTP id l3mr8769799qvl.158.1590042535217;
 Wed, 20 May 2020 23:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200521023055.GA1246587@dropbear.xyz> <87eerdan1q.fsf@notabene.neil.brown.name>
In-Reply-To: <87eerdan1q.fsf@notabene.neil.brown.name>
From:   Craig Small <csmall@dropbear.xyz>
Date:   Thu, 21 May 2020 16:28:44 +1000
Message-ID: <CALy8Cw5xrcn94qRWb2rcn9FjcoYFY3_gZiO=ekvyYopR3zBhsw@mail.gmail.com>
Subject: Re: How to separate NFS mounts have same device ID
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 21 May 2020 at 15:12, NeilBrown <neilb@suse.de> wrote:
> I would examine /proc/<PID>/fdinfo/3 and extract the 'mnt_id:' number,
> then look for that (as the first field) in /proc/<PID>/mountinfo.

The mountinfo looks very promising and a better way of uniquely
working out where a file is mounted. Thanks!

 - Craig
